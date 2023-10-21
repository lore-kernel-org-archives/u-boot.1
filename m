Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D94CDB474
	for <u-boot@archiver.kernel.org>; Sat, 21 Oct 2023 01:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 344978755D;
	Sat, 21 Oct 2023 03:11:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21D388755E; Sat, 21 Oct 2023 03:11:43 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by phobos.denx.de (Postfix) with ESMTP id E71A8874E1
 for <u-boot@lists.denx.de>; Sat, 21 Oct 2023 03:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andre.przywara@arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4DEBF153B;
 Fri, 20 Oct 2023 18:12:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E9973F64C;
 Fri, 20 Oct 2023 18:11:32 -0700 (PDT)
From: Andre Przywara <andre.przywara@arm.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: Gunjan Gupta <viraniac@gmail.com>, u-boot@lists.denx.de,
 linux-sunxi@lists.linux.dev
Subject: [PATCH 1/4] sunxi: DRAM: H6: add barrier after finishing DRAM setup
Date: Sat, 21 Oct 2023 02:10:22 +0100
Message-Id: <20231021011025.568-2-andre.przywara@arm.com>
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

From: Gunjan Gupta <viraniac@gmail.com>

During the DRAM controller setup, we program its registers for certain
configurations (multiple times), then try to access the DRAM array, to
detect the number of rows and columns in the used DRAM chips.
This requires that all MMIO writes have reached the DRAM controller,
before we actually access the DRAM.
Add a DSB instruction at the end of the controller init function, that
ensures that outstanding stores have been completed.

That hopefully fixes occasional DRAM init failures on some H6 boards
like the Orange Pi 3 LTS, where this leads to the erroneous detection of
4GB instead of the actual 2GB.

Signed-off-by: Gunjan Gupta <viraniac@gmail.com>
[Andre: move DSB, add comment]
Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 arch/arm/mach-sunxi/dram_sun50i_h6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-sunxi/dram_sun50i_h6.c b/arch/arm/mach-sunxi/dram_sun50i_h6.c
index bff2e42513c..43a2d19f084 100644
--- a/arch/arm/mach-sunxi/dram_sun50i_h6.c
+++ b/arch/arm/mach-sunxi/dram_sun50i_h6.c
@@ -554,6 +554,12 @@ static bool mctl_channel_init(struct dram_para *para)
 	writel(0x7ff, &mctl_com->maer1);
 	writel(0xffff, &mctl_com->maer2);
 
+	/*
+	 * Make sure all MMIO writes are committed to the DRAM controller,
+	 * so that accesses to the DRAM array adhere to the above programming.
+	 */
+	dsb();
+
 	return true;
 }
 
-- 
2.35.8

