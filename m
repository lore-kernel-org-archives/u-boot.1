Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA95CD98C5
	for <u-boot@archiver.kernel.org>; Sun, 14 Jun 2026 14:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 676898485F;
	Sun, 14 Jun 2026 16:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="JHnqaNEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D3EF83FEE; Sun, 14 Jun 2026 13:34:28 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86AF8800AE
 for <u-boot@lists.denx.de>; Sun, 14 Jun 2026 13:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 183662707A;
 Sun, 14 Jun 2026 13:34:25 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U4KiXRU5n4Ch; Sun, 14 Jun 2026 13:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1781436864; bh=CaRhoGnmR9bmtJOFNGmSxkIj1SOPydMYO610IRenjRk=;
 h=From:Date:Subject:To:Cc;
 b=JHnqaNEe/G6DlTKCfl4TOG1UxP7D6LoKG+NHHneipPeXjy337T8LdD2R9hhYz6AbU
 UGbG/DIu9GzLoINhcMTjcvirGcoT4U+T504uIGrLt0+o81UOH54vAXfVFNWfaHfEq6
 ceFpKENfSBpWOGkQlfVm8C5oBJHPou43mBbJ5d6P4dCIGdXqK75dQZS6h3vmqApf7B
 tGPkgsstbnA3gv5YbgsoFz7pD05j7F/Pd0tffIfuyo1gKolyRTnbOMxeb/Q19K4W3h
 UAe+MZ4GsGtC2J8uvi1BW1uMeCbGmZbxlp+oUfVOVEm1ebcP76wfOvLIQGmzZucPBs
 MTpyLj+eSEwJw==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Sun, 14 Jun 2026 17:04:08 +0530
Subject: [PATCH v2] board: samsung: exynos-mobile: prohibit memory
 overwrite access beyond DDR low region
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-j6lte-lmb-v2-1-6046b54db536@disroot.org>
X-B4-Tracking: v=1; b=H4sIAK+RLmoC/22NQQ6DIBAAv2L2XBrBBmtP/UfjAXDVNVYMUNLG8
 PeivfY4yWRmA4+O0MOt2MBhJE92ySBOBZhRLQMy6jKDKIUsJa/YJOeAbH5qppq+VpfGXLXikP3
 VYU/vo/Vof+xfekIT9sBujOSDdZ9jFvnu/etGzjhTlTA1opSGi3tH3lkbztYN0KaUvi6smA+2A
 AAA
X-Change-ID: 20260613-j6lte-lmb-a9f7a49c8ba1
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Henrik Grimler <henrik@grimler.se>
X-Mailman-Approved-At: Sun, 14 Jun 2026 16:04:46 +0200
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

With commit a3075db94d49 ("lmb: Reinstate access to memory above
ram_top"), the memory region beyond 0x100000000 is now accessible for
allocation. This breaks booting in devices like at least in some
variants of the Samsung Galaxy J6, where only CPU0 is able to appear
online.

Similar to some other boards, limit the memory to the DDR low region.
This also appears to re-implement the logic which was reverted. The
lmb_arch_add_memory() takes over the lmb initialization for the board.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This one's a critical fix, would be nice to have it pulled in by v2026.07.
---
Changes in v2:
- enable CONFIG_LMB_ARCH_MEM_MAP from target
- Link to v1: https://patch.msgid.link/20260613-j6lte-lmb-v1-1-a32c7ee66c12@disroot.org

To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/mach-exynos/Kconfig                |  1 +
 board/samsung/exynos-mobile/exynos-mobile.c | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index b084b7284aa..8251599332a 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -258,6 +258,7 @@ config TARGET_EXYNOS_MOBILE
 	select BOARD_EARLY_INIT_F
 	select CLK_EXYNOS
 	select LINUX_KERNEL_IMAGE_HEADER
+	select LMB_ARCH_MEM_MAP
 	select OF_CONTROL
 
 config SYS_SOC
diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
index 6b2b1523663..f1f6cf683dd 100644
--- a/board/samsung/exynos-mobile/exynos-mobile.c
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -353,6 +353,31 @@ int dram_init_banksize(void)
 	return 0;
 }
 
+void lmb_arch_add_memory(void)
+{
+	u64 ddr_low_top = 1ULL << 32;
+	unsigned int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		u64 start = gd->bd->bi_dram[i].start;
+		u64 size = gd->bd->bi_dram[i].size;
+
+		if (!size)
+			continue;
+
+		lmb_add(start, size);
+
+		/* Limit memory used by U-Boot to the DDR low region */
+		if (start >= ddr_low_top)
+			lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &start, size,
+				      LMB_NOOVERWRITE);
+		else if (start + size > ddr_low_top)
+			lmb_alloc_mem(LMB_MEM_ALLOC_ADDR, 0, &ddr_low_top,
+				      start + size - ddr_low_top,
+				      LMB_NOOVERWRITE);
+	}
+}
+
 int board_init(void)
 {
 	return 0;

---
base-commit: 7e47c37adf53f3010a6bf151df32df04a3c9ab91
change-id: 20260613-j6lte-lmb-a9f7a49c8ba1

Best regards,
--  
Kaustabh Chakraborty <kauschluss@disroot.org>

