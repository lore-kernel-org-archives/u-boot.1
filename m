Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954A5C4167B
	for <u-boot@archiver.kernel.org>; Sun, 26 Nov 2023 19:47:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE4EE87128;
	Sun, 26 Nov 2023 20:47:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="Cn3cY8MY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C9DB87128; Sun, 26 Nov 2023 20:47:03 +0100 (CET)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B42586ECA
 for <u-boot@lists.denx.de>; Sun, 26 Nov 2023 20:47:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=1af8=HI=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1701028013;
 bh=CK/x2bQz0KLJiN8CVWARZ+vV/ecdfRUIA8+i544COaI=;
 b=Cn3cY8MYXZ/UFLlcN4eUqcjnV5yhn5lV3hZkA3d6DxYLY3OvUZfal5w0x00uWJzY6Odeg6cs/
 R7dczeMtjEGK1uZNyPJN6CaZnVi0fHEpYmuBP/3/iXP2Kv2Al7OpoVvpjQSZ4253LM1mVdl9Z/c
 U194TtxbepuJrwMyirsJSZYTPhiWQ91fxVMTmJ5NByDZuTg3/PJup+DkGK+okKXezLz57LRkDHU
 fSLKUIB/sMSP/RUtfwH6lJw1XCglv73FJLA7/DfPYjuBb6+kjZjMxXgSNbAr7UJsE+Oqsv0o+f0
 bT3nnpzF36TZ2Bzxqn+7g6xSZ0Z07WFyUBqFWj9GROHQ==
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Subject: [PATCH] rockchip: rk3328: Set efuse auto mode and timing control
Date: Sun, 26 Nov 2023 19:46:46 +0000
Message-ID: <20231126194647.2238775-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-ForwardEmail-Version: 0.4.40
X-ForwardEmail-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-ForwardEmail-ID: 6563a0ad7d9e87de7a12630a
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
 arch/arm/mach-rockchip/rk3328/rk3328.c | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/mach-rockchip/rk3328/rk3328.c b/arch/arm/mach-rockchip/rk3328/rk3328.c
index de17b8868273..edb22a58fc67 100644
--- a/arch/arm/mach-rockchip/rk3328/rk3328.c
+++ b/arch/arm/mach-rockchip/rk3328/rk3328.c
@@ -19,6 +19,22 @@ DECLARE_GLOBAL_DATA_PTR;
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
+#define EFUSE_TIMING(s, l)	(((s) << 16) | (l))
 
 const char * const boot_devices[BROM_LAST_BOOTSOURCE + 1] = {
 	[BROM_BOOTSOURCE_EMMC] = "/mmc@ff520000",
@@ -54,6 +70,24 @@ int arch_cpu_init(void)
 
 	/* Disable the ddr secure region setting to make it non-secure */
 	rk_setreg(FW_DDR_CON_REG, 0x200);
+
+	/* Use efuse auto mode */
+	writel(0x46, EFUSE_NS_BASE + EFUSE_MOD);
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
2.42.0

