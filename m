Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E993C47073
	for <u-boot@archiver.kernel.org>; Sun,  7 Jan 2024 18:18:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 871AD86EF1;
	Sun,  7 Jan 2024 19:18:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="hvN7lLbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26686879AC; Sun,  7 Jan 2024 19:18:55 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C00A8309D
 for <u-boot@lists.denx.de>; Sun,  7 Jan 2024 19:18:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=248a=IS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1704651521;
 bh=mNOM8fSCrih1rdp3gHa98xcJ75mFZHwvJkhJ/8ZcI9o=;
 b=hvN7lLbowR99pFtcVGcAcLNFQ/PaMiFrnVEGiruhia9BdG5OEPvd/3IWaV8m9W0vtKU/7HTXw
 LZR9BEljvGfZjLM9lZfT+Nx3zsVUXqD/X+KktvPal5U3A1LFk1OUGc0ERYZEP1EI+iYKqJZQTzt
 XcmEdvAbJUYEFU20uDzoF3wvYOY3k/Ng+0YGjCN4pum8Cm5dZJYElCg3YqhFYxhzXRpRgiI1tNs
 W1iTqaGHjyhOMKpAxdKeva9QjuXcm2mVK3r7GvVsKuinkB9fotVQd2hhAen+B8JwG0xDD2LRue5
 sg5sjFHZPxYR9x7rA/zeeuAfce3sKjPSUMnMkoC3G8qQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2] rockchip: rk3328: Set efuse auto mode and timing control
Date: Sun,  7 Jan 2024 18:18:33 +0000
Message-ID: <20240107181834.1589988-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 659aeb016bac4da560885c23
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

Reading from efuse return zero when mainline TF-A is used.

  => dump_efuse
  00000000: 00 00 00 00  ....
  00000004: 00 00 00 00  ....
  00000008: 00 00 00 00  ....
  0000000c: 00 00 00 00  ....
  00000010: 00 00 00 00  ....
  00000014: 00 00 00 00  ....
  00000018: 00 00 00 00  ....
  0000001c: 00 00 00 00  ....

However, when vendor TF-A blobs is used reading from efuse works.

Change to use auto mode, enable finish and auto access err interrupts
and set timing control using same values that vendor TF-A blob use to
fix this.

With this efuse can be read when either of mainline TF-A or vendor blob
is used.

  => dump_efuse
  00000000: 52 4b 33 82  RK3.
  00000004: 00 fe 21 55  ..!U
  00000008: 52 4b 57 34  RKW4
  0000000c: 35 30 32 39  5029
  00000010: 00 00 00 00  ....
  00000014: 08 25 0c 0f  .%..
  00000018: 02 0d 08 00  ....
  0000001c: 00 00 f0 00  ....

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
Changes in v2:
- Read and mask user mode flag instead of force 0x46 value

 arch/arm/mach-rockchip/rk3328/rk3328.c | 38 ++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index de17b8868273..ca623c0d3d03 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -19,6 +19,23 @@ DECLARE_GLOBAL_DATA_PTR;
 #define GRF_BASE		0xFF100000
 #define UART2_BASE		0xFF130000
 #define FW_DDR_CON_REG		0xFF7C0040
+#define EFUSE_NS_BASE		0xFF260000
+
+#define EFUSE_MOD		0x0000
+#define EFUSE_INT_CON		0x0014
+#define EFUSE_T_CSB_P		0x0028
+#define EFUSE_T_PGENB_P		0x002C
+#define EFUSE_T_LOAD_P		0x0030
+#define EFUSE_T_ADDR_P		0x0034
+#define EFUSE_T_STROBE_P	0x0038
+#define EFUSE_T_CSB_R		0x003C
+#define EFUSE_T_PGENB_R		0x0040
+#define EFUSE_T_LOAD_R		0x0044
+#define EFUSE_T_ADDR_R		0x0048
+#define EFUSE_T_STROBE_R	0x004C
+
+#define EFUSE_USER_MODE		0x1
+#define EFUSE_TIMING(s, l)	(((s) << 16) | (l))
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
@@ -50,10 +67,31 @@ struct mm_region *mem_map = rk3328_mem_map;
 int arch_cpu_init(void)
 {
 #ifdef CONFIG_SPL_BUILD
+	u32 reg;
+
 	/* We do some SoC one time setting here. */
 
 	/* Disable the ddr secure region setting to make it non-secure */
 	rk_setreg(FW_DDR_CON_REG, 0x200);
+
+	/* Use efuse auto mode */
+	reg = readl(EFUSE_NS_BASE + EFUSE_MOD);
+	writel(reg & ~EFUSE_USER_MODE, EFUSE_NS_BASE + EFUSE_MOD);
+
+	/* Enable efuse finish and auto access err interrupt */
+	writel(0x07, EFUSE_NS_BASE + EFUSE_INT_CON);
+
+	/* Set efuse timing control */
+	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_CSB_P);
+	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_PGENB_P);
+	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_LOAD_P);
+	writel(EFUSE_TIMING(1, 241), EFUSE_NS_BASE + EFUSE_T_ADDR_P);
+	writel(EFUSE_TIMING(2, 240), EFUSE_NS_BASE + EFUSE_T_STROBE_P);
+	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_CSB_R);
+	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_PGENB_R);
+	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_LOAD_R);
+	writel(EFUSE_TIMING(1, 4), EFUSE_NS_BASE + EFUSE_T_ADDR_R);
+	writel(EFUSE_TIMING(2, 3), EFUSE_NS_BASE + EFUSE_T_STROBE_R);
 #endif
 	return 0;
 }
-- 
2.43.0

