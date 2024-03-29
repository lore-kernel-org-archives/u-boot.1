Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CFD3CD11DD
	for <u-boot@archiver.kernel.org>; Fri, 29 Mar 2024 11:18:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7335B88256;
	Fri, 29 Mar 2024 12:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711711107;
	bh=+/XeB/RfsBz270dI2tAJRZEbtuZIjJY5m7v6Ub4jYbM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fhjELbpJyYMbiDwexs6V1O+9Z+XkghgUQ5rack9yI8EpkQvU/m4LxRUDPwxgJ3aBI
	 Op+4tMAZRoBBg75kS+W7tNrSEjRMr1gxaBfqiSYw+yZu2WjheYy5wzTUw25rqpmuCJ
	 lxj9mUMMex4rbrcG2mZ8RuQYRP6mQ7PLAr+ksoUcKVoTHSanlTiGnNWNyxHqAFnH1t
	 n0ZIKtZPc76FHsHff4qiapndZtEneL9MKfbB75xPgJ4EKcwYm0EsMaVkG0Tvfm+aZF
	 sRsKIsmP0HQht/TdtuxS0fodW9GV1UBGDyIOBCCeOtPYVw/3e7HN7sVKaUQG96HeWT
	 aA88dmRVmqKMw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0B75288247;
 Fri, 29 Mar 2024 12:18:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711711104;
 bh=+/XeB/RfsBz270dI2tAJRZEbtuZIjJY5m7v6Ub4jYbM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ncVO/9TrH4y3iWOXYzvpuHlkzx4nQ+5dPBITZUHbA/lqvXOSx8NqlzeemVMWwGvIJ
 kLYCevgj3pyBhjzB3fu7kpp94HbgkH8BJGOhFbiQZjp3sVTRvimWKSpErMy/a3GfxJ
 Uwx7M1kgjIUrDsHOJ1cWHhqPACJVfztI+MF9kQO4m1zZe86q1g3LoGeeLZWFTdv8p/
 dwlq3dgiD+jT5p1mrpCYkFz0XFBe5/iOKcIIP/XbP1ORxSr4odXhFugTkuNvGFvIUa
 7G0Ljkkd1mrq2Sc2dIPI3vFxMEqGZc8icKbJi2TnBanK2a87Z33tUS9jo6HSpBCAeO
 BqjknpsFXiZDw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/4] arm: xea: Add support for reading SoM (CPU) board HW
 revision
Date: Fri, 29 Mar 2024 12:18:08 +0100
Message-Id: <20240329111809.3959962-4-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240329111809.3959962-1-lukma@denx.de>
References: <20240329111809.3959962-1-lukma@denx.de>
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

The XEA board now has several HW revisions for SoM boards.
This patch provides support for reading this revision ID values in early
u-boot proper as production devices boot via falcon boot with correct DTB
flashed at production (so there is no need to alter SPL).

Additionally, the maximal SPL size (~55KiB) constraint is not allowing
having even simplified FIT support in it.

As a result it was necessary to handle reading GPIOs values solely in
u-boot proper as one configuration (i.e. 'single binary' -
imx28_xea_sb_defconfig) is not using SPL framework.

Moreover, the 'board_som_rev' environment variable will be used to point
correct configuration from the Linux FIT file.

Additionally, as now XEA has its second HW revision - this information is
printed when u-boot proper starts.

Signed-off-by: Lukasz Majewski <lukma@denx.de>

---

Changes in v2:
Remove "inline" from get_som_rev() function definition
Squash with 'config: xea: Enable late board initialization to set revision variable'
Update commit message
Squash with 'arm: xea: Print information about XEA's SoM HW revision'

 board/liebherr/xea/spl_xea.c   | 11 ++++++++
 board/liebherr/xea/xea.c       | 49 ++++++++++++++++++++++++++++++++++
 configs/imx28_xea_defconfig    |  1 +
 configs/imx28_xea_sb_defconfig |  1 +
 4 files changed, 62 insertions(+)

diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index 4068a2ad49..6cf8f8390e 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -231,6 +231,17 @@ const iomux_cfg_t iomux_setup[] = {
 	/* TIVA boot control */
 	MX28_PAD_GPMI_RDY3__GPIO_0_23 | MUX_CONFIG_BOOT, /* TIVA0 */
 	MX28_PAD_GPMI_WRN__GPIO_0_25 | MUX_CONFIG_BOOT, /* TIVA1 */
+
+	/* HW revision ID Base Board */
+	MX28_PAD_LCD_D12__GPIO_1_12,
+	MX28_PAD_LCD_D13__GPIO_1_13,
+	MX28_PAD_LCD_D14__GPIO_1_14,
+
+	/* HW revision ID (SoM) */
+	MX28_PAD_LCD_D15__GPIO_1_15,
+	MX28_PAD_LCD_D16__GPIO_1_16,
+	MX28_PAD_LCD_D17__GPIO_1_17,
+	MX28_PAD_LCD_D18__GPIO_1_18,
 };
 
 u32 mxs_dram_vals[] = {
diff --git a/board/liebherr/xea/xea.c b/board/liebherr/xea/xea.c
index c8ac526cb4..0a6fd7f143 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -216,6 +216,34 @@ int spl_start_uboot(void)
 	return !boot_tiva0 || !boot_tiva1;
 }
 #else
+/*
+ * Reading the HW ID number for XEA SoM module
+ *
+ * GPIOs from Port 1 (GPIO1_15, GPIO1_16, GPIO1_17 and GPIO1_18)
+ * are used to store HW revision information.
+ * Reading of GPIOs values is performed before the Device Model is
+ * bring up as the proper DTB needs to be chosen first.
+ *
+ * Moreover, this approach is required as "single binary" configuration
+ * of U-Boot (imx28_xea_sb_defconfig) is NOT using SPL framework, so
+ * only minimal subset of functionality is provided when ID is read.
+ *
+ * Hence, the direct registers' access.
+ */
+#define XEA_SOM_HW_ID_GPIO_PORT (MXS_PINCTRL_BASE + (0x0900 + ((1) * 0x10)))
+#define XEA_SOM_REV_MASK GENMASK(18, 15)
+#define XEA_SOM_REV_SHIFT 15
+
+static u8 get_som_rev(void)
+{
+	struct mxs_register_32 *reg =
+		(struct mxs_register_32 *)XEA_SOM_HW_ID_GPIO_PORT;
+
+	u32 tmp = ~readl(&reg->reg);
+	u8 id = (tmp & XEA_SOM_REV_MASK) >> XEA_SOM_REV_SHIFT;
+
+	return id;
+}
 
 int board_early_init_f(void)
 {
@@ -253,6 +281,27 @@ int board_init(void)
 	return 0;
 }
 
+#if defined(CONFIG_BOARD_LATE_INIT)
+int board_late_init(void)
+{
+	int ret = env_set_ulong("board_som_rev", get_som_rev());
+
+	if (ret)
+		printf("Cannot set XEA's SoM revision env variable!\n");
+
+	return 0;
+}
+#endif
+
+#if defined(CONFIG_DISPLAY_BOARDINFO)
+int checkboard(void)
+{
+	printf("Board: LWE XEA SoM HW rev %d\n", get_som_rev());
+
+	return 0;
+}
+#endif
+
 int dram_init(void)
 {
 	return mxs_dram_init();
diff --git a/configs/imx28_xea_defconfig b/configs/imx28_xea_defconfig
index 64a0561a34..6098c1f3be 100644
--- a/configs/imx28_xea_defconfig
+++ b/configs/imx28_xea_defconfig
@@ -39,6 +39,7 @@ CONFIG_BOOTCOMMAND="run ${bootpri} ; run ${bootsec}"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run prebootcmd"
 CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
diff --git a/configs/imx28_xea_sb_defconfig b/configs/imx28_xea_sb_defconfig
index 9872d35c1b..8d48d8c507 100644
--- a/configs/imx28_xea_sb_defconfig
+++ b/configs/imx28_xea_sb_defconfig
@@ -23,6 +23,7 @@ CONFIG_BOOTARGS="console=ttyAMA0,115200n8"
 CONFIG_USE_PREBOOT=y
 CONFIG_PREBOOT="run prebootcmd"
 CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
 # CONFIG_SPL_FRAMEWORK is not set
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_SPL_BOARD_INIT=y
-- 
2.39.2

