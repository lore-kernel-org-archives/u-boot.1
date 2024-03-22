Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F2C54E71
	for <u-boot@archiver.kernel.org>; Fri, 22 Mar 2024 11:43:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7FE2881EC;
	Fri, 22 Mar 2024 12:43:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711107818;
	bh=W2SIImO38ouVpgkps1pm/Gfp7We6piaKHqANJcbDs0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1dkSd7tFh1jKsljQhQkUkYPO9BHn0HrHAQcBv4gdKKj6mcxZ7KdenkLiGJFYb6Ql
	 gYgzHRzeXozBHJxr2a2ZkklBNq/2OTMOME0Q8DBCETPW9qdgFBZKRlREgRokWE0Hv+
	 X0s+fcA3/+yWnQ9fM5HTxnBqbPrGZ414aNuFYWkn+p99PGo+2jMvyI70/tgTYWtYOj
	 W8aTcL+OfB3aCNBwpJSy4ez6C4mzFykDhE41OVxamHbxzOb0pcxuudaKJjtxrXtquD
	 HfDeHP3yIDfkug9bpadLbNmZFNEXiR7gDMVo+jivL6ldIJ27qIXALB4xoQLVwOO23W
	 9p7HTE7gNb4Yw==
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl
 [85.222.111.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: lukma@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2B06C881D4;
 Fri, 22 Mar 2024 12:43:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1711107815;
 bh=W2SIImO38ouVpgkps1pm/Gfp7We6piaKHqANJcbDs0o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FMrz8tC2Y9HcjsROSAZ802Qm4ZTuagt6yvECcz6ITUjhj6J+dtyhsoYb/O3RS3jOS
 Y0iP3pXcQl5wlBcQoBwlnPPVlUiTy+pbNbKXlgOLkYsyrKaSeE2I2+mgZVnlBdzxvG
 CfPzhYfGLyzjkEpO8dJ9lNcZnR0kQ/SZa/Xtyfe3+Z2rznl6jsTVDRJIxvFQU8T/sh
 SzTVehmLM11at2ltPMfKm+bkSDNAz4+gi50zFlHfFSxNqvd5qJ66CzJqxkdu/VuMte
 bH5yKzuG05+IOJwseeEvEQDSiDrfZhN5AwcZG2FoU7AJi0nHDQR//HyuA+BcrUKzLR
 yndnMrzLZY0yw==
From: Lukasz Majewski <lukma@denx.de>
To: Stefano Babic <sbabic@denx.de>,
	u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/12] arm: xea: Add support for reading SoM (CPU) and base
 board HW revision
Date: Fri, 22 Mar 2024 12:43:05 +0100
Message-Id: <20240322114315.2720727-3-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240322114315.2720727-1-lukma@denx.de>
References: <20240322114315.2720727-1-lukma@denx.de>
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

The XEA board now has several HW revisions for both SoM and base boards.
This patch provides support for reading those revision ID values in SPL
(u-boot.sb) and then pass this information to u-boot proper, as the
maximal SPL size (~55KiB) is not allowing for having FIT support in it.

It was necessary to handle reading GPIOs values solely in u-boot proper
as one configuration (i.e. 'single binary' - imx28_xea_sb_defconfig)
is not using SPL framework.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---

 board/liebherr/xea/spl_xea.c | 11 +++++++++++
 board/liebherr/xea/xea.c     | 29 +++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/board/liebherr/xea/spl_xea.c b/board/liebherr/xea/spl_xea.c
index 551ed6fbae..71194db235 100644
--- a/board/liebherr/xea/spl_xea.c
+++ b/board/liebherr/xea/spl_xea.c
@@ -230,6 +230,17 @@ const iomux_cfg_t iomux_setup[] = {
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
index c8ac526cb4..d9cf27c81b 100644
--- a/board/liebherr/xea/xea.c
+++ b/board/liebherr/xea/xea.c
@@ -48,6 +48,35 @@ DECLARE_GLOBAL_DATA_PTR;
  * Functions
  */
 
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
+static inline u8 get_som_rev(void)
+{
+	struct mxs_register_32 *reg =
+		(struct mxs_register_32 *)XEA_SOM_HW_ID_GPIO_PORT;
+
+	u32 tmp = ~readl(&reg->reg);
+	u8 id = (tmp & XEA_SOM_REV_MASK) >> XEA_SOM_REV_SHIFT;
+
+	return id;
+}
+
 static void init_clocks(void)
 {
 	/* IO0 clock at 480MHz */
-- 
2.39.2

