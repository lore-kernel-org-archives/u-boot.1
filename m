Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791A0C5475B
	for <u-boot@archiver.kernel.org>; Tue, 20 Feb 2024 18:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7946E8801C;
	Tue, 20 Feb 2024 19:29:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="c0/E9NN1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD14787FF2; Tue, 20 Feb 2024 19:29:42 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61FBB87FF7
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 19:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb.corp.toradex.com (31-10-206-125.static.upc.ch
 [31.10.206.125])
 by mail11.truemail.it (Postfix) with ESMTPA id C186C226E3;
 Tue, 20 Feb 2024 19:29:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1708453772;
 bh=QnbxatbMjRM+CaEBz9flZcJ+9+/MqFKs8l8WTO9qe84=; h=From:To:Subject;
 b=c0/E9NN1I1u+Ajdbzt9b2oIwT0U6qBmzFHoW/ZWQneZo9KJizst7toOQcRyjuAD7H
 awFRVuVgNCJpI3OO2I+Q2yr5rYsK18flXqPUUd64FKIlT6FP5HR4C42lgRwSZmOOP1
 8kw6CKwpD9tYAyPAa+vhCvw2Yh/W8CPToJT/4om/Aek9EJiHl9KR32HA2Z9Av6WSbN
 5CrSBcN+wwZIX1zw3jm6+7jPHxvi0YeqP9zWZG2qIxL1srImazb4jdWJuOLEeQPgbY
 V3TNAaylZcd0678kk7eaqJzTjZ8U4VckUXGDMOvoQREzGPzyHEUw+kx1OhtMDZYfEC
 jWimWp0y/B4Kg==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Tom Rini <trini@konsulko.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, u-boot@lists.denx.de,
 Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: [PATCH v1 2/7] toradex: Remove not necessary model prints from
 checkboard()
Date: Tue, 20 Feb 2024 19:29:21 +0100
Message-Id: <20240220182926.101161-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220182926.101161-1-francesco@dolcini.it>
References: <20240220182926.101161-1-francesco@dolcini.it>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Sysinfo prints the model obtained from device tree, checkboard()
take info from hardware and tdx_checkboard() use the model retrieved by
toradex config block.

Remove the print from checkboard() function because the model obtained
from toradex config block is the most complete.
If toradex config block is missing the model info from device tree is
enough.

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 board/toradex/apalis-imx8/apalis-imx8.c       | 10 ---------
 board/toradex/apalis-tk1/apalis-tk1.c         |  7 -------
 board/toradex/apalis_imx6/apalis_imx6.c       | 21 -------------------
 board/toradex/apalis_t30/apalis_t30.c         |  8 -------
 .../toradex/colibri-imx6ull/colibri-imx6ull.c |  7 -------
 board/toradex/colibri-imx8x/colibri-imx8x.c   | 10 ---------
 board/toradex/colibri_imx6/colibri_imx6.c     | 20 ------------------
 board/toradex/colibri_imx7/colibri_imx7.c     |  8 -------
 board/toradex/colibri_t20/colibri_t20.c       | 10 ---------
 board/toradex/colibri_t30/colibri_t30.c       |  7 -------
 board/toradex/colibri_vf/colibri_vf.c         | 10 ---------
 board/toradex/common/tdx-common.c             |  9 +++++++-
 board/toradex/common/tdx-common.h             |  1 -
 13 files changed, 8 insertions(+), 120 deletions(-)

diff --git a/board/toradex/apalis-imx8/apalis-imx8.c b/board/toradex/apalis-imx8/apalis-imx8.c
index b351ce64abfc..2483a63c6733 100644
--- a/board/toradex/apalis-imx8/apalis-imx8.c
+++ b/board/toradex/apalis-imx8/apalis-imx8.c
@@ -208,16 +208,6 @@ void board_preboot_os(void)
 	gpio_direction_output(BKL1_GPIO, 0);
 }
 
-int checkboard(void)
-{
-	puts("Model: Toradex Apalis iMX8\n");
-
-	build_info();
-	print_bootinfo();
-
-	return tdx_checkboard();
-}
-
 static enum pcb_rev_t get_pcb_revision(void)
 {
 	unsigned int pcb_vers = 0;
diff --git a/board/toradex/apalis-tk1/apalis-tk1.c b/board/toradex/apalis-tk1/apalis-tk1.c
index 79a1c92da0a0..ee87d9f4145f 100644
--- a/board/toradex/apalis-tk1/apalis-tk1.c
+++ b/board/toradex/apalis-tk1/apalis-tk1.c
@@ -91,13 +91,6 @@ int arch_misc_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	puts("Model: Toradex Apalis TK1 2GB\n");
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/apalis_imx6/apalis_imx6.c b/board/toradex/apalis_imx6/apalis_imx6.c
index 164fcc41f550..0da245374a0d 100644
--- a/board/toradex/apalis_imx6/apalis_imx6.c
+++ b/board/toradex/apalis_imx6/apalis_imx6.c
@@ -716,27 +716,6 @@ int board_late_init(void)
 }
 #endif /* CONFIG_BOARD_LATE_INIT */
 
-int checkboard(void)
-{
-	char it[] = " IT";
-	int minc, maxc;
-
-	switch (get_cpu_temp_grade(&minc, &maxc)) {
-	case TEMP_AUTOMOTIVE:
-	case TEMP_INDUSTRIAL:
-		break;
-	case TEMP_EXTCOMMERCIAL:
-	default:
-		it[0] = 0;
-	};
-	printf("Model: Toradex Apalis iMX6 %s %s%s\n",
-	       is_cpu_type(MXC_CPU_MX6D) ? "Dual" : "Quad",
-	       (gd->ram_size == 0x80000000) ? "2GB" :
-	       (gd->ram_size == 0x40000000) ? "1GB" : "512MB", it);
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/apalis_t30/apalis_t30.c b/board/toradex/apalis_t30/apalis_t30.c
index b9a2af33f19f..b10beb447965 100644
--- a/board/toradex/apalis_t30/apalis_t30.c
+++ b/board/toradex/apalis_t30/apalis_t30.c
@@ -45,14 +45,6 @@ int arch_misc_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	printf("Model: Toradex Apalis T30 %dGB\n",
-	       (gd->ram_size == 0x40000000) ? 1 : 2);
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri-imx6ull/colibri-imx6ull.c b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
index a775f54eb3f4..9b9fb342c9d9 100644
--- a/board/toradex/colibri-imx6ull/colibri-imx6ull.c
+++ b/board/toradex/colibri-imx6ull/colibri-imx6ull.c
@@ -205,13 +205,6 @@ int board_late_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	printf("Model: Toradex Colibri iMX6ULL\n");
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri-imx8x/colibri-imx8x.c b/board/toradex/colibri-imx8x/colibri-imx8x.c
index d8cc72f323c5..2c673a4a6b06 100644
--- a/board/toradex/colibri-imx8x/colibri-imx8x.c
+++ b/board/toradex/colibri-imx8x/colibri-imx8x.c
@@ -114,16 +114,6 @@ int board_phy_config(struct phy_device *phydev)
 }
 #endif
 
-int checkboard(void)
-{
-	puts("Model: Toradex Colibri iMX8X\n");
-
-	build_info();
-	print_bootinfo();
-
-	return tdx_checkboard();
-}
-
 static void select_dt_from_module_version(void)
 {
 	/*
diff --git a/board/toradex/colibri_imx6/colibri_imx6.c b/board/toradex/colibri_imx6/colibri_imx6.c
index 784ca7f65f7b..ce19a9c79752 100644
--- a/board/toradex/colibri_imx6/colibri_imx6.c
+++ b/board/toradex/colibri_imx6/colibri_imx6.c
@@ -636,26 +636,6 @@ int board_late_init(void)
 }
 #endif /* CONFIG_BOARD_LATE_INIT */
 
-int checkboard(void)
-{
-	char it[] = " IT";
-	int minc, maxc;
-
-	switch (get_cpu_temp_grade(&minc, &maxc)) {
-	case TEMP_AUTOMOTIVE:
-	case TEMP_INDUSTRIAL:
-		break;
-	case TEMP_EXTCOMMERCIAL:
-	default:
-		it[0] = 0;
-	};
-	printf("Model: Toradex Colibri iMX6 %s %sMB%s\n",
-	       is_cpu_type(MXC_CPU_MX6DL) ? "DualLite" : "Solo",
-	       (gd->ram_size == 0x20000000) ? "512" : "256", it);
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri_imx7/colibri_imx7.c b/board/toradex/colibri_imx7/colibri_imx7.c
index 2e5b02f72675..c37c5e0af6d9 100644
--- a/board/toradex/colibri_imx7/colibri_imx7.c
+++ b/board/toradex/colibri_imx7/colibri_imx7.c
@@ -273,14 +273,6 @@ void reset_cpu(void)
 }
 #endif
 
-int checkboard(void)
-{
-	printf("Model: Toradex Colibri iMX7%c\n",
-	       is_cpu_type(MXC_CPU_MX7D) ? 'D' : 'S');
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri_t20/colibri_t20.c b/board/toradex/colibri_t20/colibri_t20.c
index 5861cf7dc93e..97e33d00f0d6 100644
--- a/board/toradex/colibri_t20/colibri_t20.c
+++ b/board/toradex/colibri_t20/colibri_t20.c
@@ -70,16 +70,6 @@ int arch_misc_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	printf("Model: Toradex Colibri T20 %dMB V%s\n",
-	       (gd->ram_size == 0x10000000) ? 256 : 512,
-	       (get_nand_dev_by_index(0)->erasesize >> 10 == 512) ?
-	       ((gd->ram_size == 0x10000000) ? "1.1B" : "1.1C") : "1.2A");
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri_t30/colibri_t30.c b/board/toradex/colibri_t30/colibri_t30.c
index 8cef098c8e59..0da247de98f9 100644
--- a/board/toradex/colibri_t30/colibri_t30.c
+++ b/board/toradex/colibri_t30/colibri_t30.c
@@ -28,13 +28,6 @@ int arch_misc_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	puts("Model: Toradex Colibri T30 1GB\n");
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/colibri_vf/colibri_vf.c b/board/toradex/colibri_vf/colibri_vf.c
index af9f2d379cf4..35920008805f 100644
--- a/board/toradex/colibri_vf/colibri_vf.c
+++ b/board/toradex/colibri_vf/colibri_vf.c
@@ -366,16 +366,6 @@ int board_init(void)
 	return 0;
 }
 
-int checkboard(void)
-{
-	if (is_colibri_vf61())
-		puts("Model: Toradex Colibri VF61\n");
-	else
-		puts("Model: Toradex Colibri VF50\n");
-
-	return tdx_checkboard();
-}
-
 #if defined(CONFIG_OF_LIBFDT) && defined(CONFIG_OF_BOARD_SETUP)
 int ft_board_setup(void *blob, struct bd_info *bd)
 {
diff --git a/board/toradex/common/tdx-common.c b/board/toradex/common/tdx-common.c
index ddc4a175da68..cdf645b14177 100644
--- a/board/toradex/common/tdx-common.c
+++ b/board/toradex/common/tdx-common.c
@@ -96,7 +96,12 @@ static const char *get_board_assembly(u16 ver_assembly)
 	return ver_name;
 }
 
-int tdx_checkboard(void)
+__weak int print_bootinfo(void)
+{
+	return 0;
+}
+
+int checkboard(void)
 {
 	unsigned char ethaddr[6];
 
@@ -144,6 +149,8 @@ int tdx_checkboard(void)
 #endif
 	}
 
+	print_bootinfo();
+
 	/*
 	 * Check if environment contains a valid MAC address,
 	 * set the one from config block if not
diff --git a/board/toradex/common/tdx-common.h b/board/toradex/common/tdx-common.h
index 44234dc49cd7..d446e9f1d5ca 100644
--- a/board/toradex/common/tdx-common.h
+++ b/board/toradex/common/tdx-common.h
@@ -11,6 +11,5 @@
 
 int ft_common_board_setup(void *blob, struct bd_info *bd);
 u32 get_board_revision(void);
-int tdx_checkboard(void);
 
 #endif /* _TDX_COMMON_H */
-- 
2.39.2

