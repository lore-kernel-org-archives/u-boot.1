Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F9DCDB474
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 01:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F9E8756A;
	Sat, 21 Oct 2023 03:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C46874E1; Sat, 21 Oct 2023 03:11:44 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id 9B92F8755C
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 03:11:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E97B0143D;
 Fri, 20 Oct 2023 18:12:17 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12CAC3F64C;
 Fri, 20 Oct 2023 18:11:35 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 4/4] sunxi: DRAM: H6: use proper MMIO accessors in
 mctl_set_addrmap()
Date: Sat, 21 Oct 2023 02:10:25 +0100
Message-Id: <20231021011025.568-5-andre.przywara@arm.com>
X-Mailer: git-send-email 2.35.8
In-Reply-To: <20231021011025.568-1-andre.przywara@arm.com>
References: <20231021011025.568-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

For accessing MMIO registers, we must not rely on the compiler to
realise every access to a struct which we made point to some MMIO base
address. From a compiler's point of view, those writes could be
considered pointless, since no code consumes them later on: the compiler
would actually be free to optimise them away.

So we need at least the "volatile" attribute in the pointer declaration,
but a better fix is of course to use the proper MMIO accessors (writel),
as we do everywhere else.
Since MMIO writes are already ordered within themselves (courtesy of the
"device nGnRnE" memory attribures), and we don't do any DMA operation
which would requrire synchronising with normal memory accesses, we can
use the cheaper writel_relaxed() accessor, which have the additional
advantange of saving one instruction, for each call.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 69 ++++++++++++++++------------
 1 file changed, 39 insertions(+), 30 deletions(-)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index 8e959f4c600..89e855c1a7d 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -192,77 +192,86 @@ static void mctl_set_addrmap(const struct dram_config *config)
 
 	/* Ranks */
 	if (ranks == 2)
-		mctl_ctl->addrmap[0] = rows + cols - 3;
+		writel_relaxed(rows + cols - 3, &mctl_ctl->addrmap[0]);
 	else
-		mctl_ctl->addrmap[0] = 0x1F;
+		writel_relaxed(0x1f, &mctl_ctl->addrmap[0]);
 
 	/* Banks, hardcoded to 8 banks now */
-	mctl_ctl->addrmap[1] = (cols - 2) | (cols - 2) << 8 | (cols - 2) << 16;
+	writel_relaxed((cols - 2) | (cols - 2) << 8 | (cols - 2) << 16,
+		       &mctl_ctl->addrmap[1]);
 
 	/* Columns */
-	mctl_ctl->addrmap[2] = 0;
+	writel_relaxed(0, &mctl_ctl->addrmap[2]);
 	switch (cols) {
 	case 7:
-		mctl_ctl->addrmap[3] = 0x1F1F1F00;
-		mctl_ctl->addrmap[4] = 0x1F1F;
+		writel_relaxed(0x1f1f1f00, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
 		break;
 	case 8:
-		mctl_ctl->addrmap[3] = 0x1F1F0000;
-		mctl_ctl->addrmap[4] = 0x1F1F;
+		writel_relaxed(0x1f1f0000, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
 		break;
 	case 9:
-		mctl_ctl->addrmap[3] = 0x1F000000;
-		mctl_ctl->addrmap[4] = 0x1F1F;
+		writel_relaxed(0x1f000000, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
 		break;
 	case 10:
-		mctl_ctl->addrmap[3] = 0;
-		mctl_ctl->addrmap[4] = 0x1F1F;
+		writel_relaxed(0, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0x1f1f, &mctl_ctl->addrmap[4]);
 		break;
 	case 11:
-		mctl_ctl->addrmap[3] = 0;
-		mctl_ctl->addrmap[4] = 0x1F00;
+		writel_relaxed(0, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0x1f00, &mctl_ctl->addrmap[4]);
 		break;
 	case 12:
-		mctl_ctl->addrmap[3] = 0;
-		mctl_ctl->addrmap[4] = 0;
+		writel_relaxed(0, &mctl_ctl->addrmap[3]);
+		writel_relaxed(0, &mctl_ctl->addrmap[4]);
 		break;
 	default:
 		panic("Unsupported DRAM configuration: column number invalid\n");
 	}
 
 	/* Rows */
-	mctl_ctl->addrmap[5] = (cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24);
+	writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24),
+		       &mctl_ctl->addrmap[5]);
 	switch (rows) {
 	case 13:
-		mctl_ctl->addrmap[6] = (cols - 3) | 0x0F0F0F00;
-		mctl_ctl->addrmap[7] = 0x0F0F;
+		writel_relaxed((cols - 3) | 0x0f0f0f00, &mctl_ctl->addrmap[6]);
+		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
 		break;
 	case 14:
-		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | 0x0F0F0000;
-		mctl_ctl->addrmap[7] = 0x0F0F;
+		writel_relaxed((cols - 3) | ((cols - 3) << 8) | 0x0f0f0000,
+			       &mctl_ctl->addrmap[6]);
+		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
 		break;
 	case 15:
-		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | 0x0F000000;
-		mctl_ctl->addrmap[7] = 0x0F0F;
+		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | 0x0f000000,
+				&mctl_ctl->addrmap[6]);
+		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
 		break;
 	case 16:
-		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24);
-		mctl_ctl->addrmap[7] = 0x0F0F;
+		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24),
+			       &mctl_ctl->addrmap[6]);
+		writel_relaxed(0x0f0f, &mctl_ctl->addrmap[7]);
 		break;
 	case 17:
-		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24);
-		mctl_ctl->addrmap[7] = (cols - 3) | 0x0F00;
+		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24),
+			       &mctl_ctl->addrmap[6]);
+		writel_relaxed((cols - 3) | 0x0f00, &mctl_ctl->addrmap[7]);
 		break;
 	case 18:
-		mctl_ctl->addrmap[6] = (cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24);
-		mctl_ctl->addrmap[7] = (cols - 3) | ((cols - 3) << 8);
+		writel_relaxed((cols - 3) | ((cols - 3) << 8) | ((cols - 3) << 16) | ((cols - 3) << 24),
+			       &mctl_ctl->addrmap[6]);
+		writel_relaxed((cols - 3) | ((cols - 3) << 8),
+			       &mctl_ctl->addrmap[7]);
 		break;
 	default:
 		panic("Unsupported DRAM configuration: row number invalid\n");
 	}
 
 	/* Bank groups, DDR4 only */
-	mctl_ctl->addrmap[8] = 0x3F3F;
+	writel_relaxed(0x3f3f, &mctl_ctl->addrmap[8]);
+	dsb();
 }
 
 static void mctl_com_init(const struct dram_para *para,
-- 
2.35.8

