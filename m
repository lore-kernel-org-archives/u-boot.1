Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1908EC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:09:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33C5D87D09;
	Fri, 19 Jan 2024 17:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1705680534;
	bh=WrF2PyaOpqUkt0fPNoepMGYXNbCaFxMbl31hUUADsy4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pe1PLcWB7kCv0QLJCAmG0Guv8qvb11Bgv4FlhKCBpZ4keRHj68LoApOxofQCigblN
	 eupmPMUeAbfhRKLFRPJAx4xwMF+LhEn3eCcur21QEEJ9OIPvqfwTAWO8ACiG7ATELd
	 CgQRRIBWwlt702943I6PBfCwatoEj2DFO8I5hUzvOX1Q/puGl4dvw6gleCsomd4O2a
	 Fm8f3sEcZ2/pj7IcCH5LM5WXX+C44cJbNxXfptYXG2b8+WL9g+VeMj2paIwi9rYCbP
	 6cCwKJHSgsEKGK9O0RktsRUfYMMOUz7nDxVuN/51qA2ztageiO8+7FpWKUuJZ5fr5T
	 dzsDxlaSuShMg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id C93C687D0F;
 Fri, 19 Jan 2024 17:08:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1705680533;
 bh=WrF2PyaOpqUkt0fPNoepMGYXNbCaFxMbl31hUUADsy4=;
 h=From:To:Cc:Subject:Date:From;
 b=0WZbufdwErz2EF6H1X3EJ1Ti/a518KVsQ59W4sl8O8TH9mMG21GWGRT/H5e0KZH3n
 A+k4Cr/iYlfVOrnx8cy/sxLuDXXros61yQ/EqDZfDFJwHbdEukJISfDnoxBObUk//M
 NsyATrvAcRTjJjnIw3GRw6OY8eD01YDopojqBlWkxsEbbI+8FF3+J31sBjX4zCp9Sx
 mx2s7108qrKfxtuzlPZ7Xw4g8OrDF5LSPAlXRbAwb65jadllHWZuXkH8uOgxkoZLYi
 htWFHoZc0RCA44Vmg6D5Dhmo09Hd9Qf6mGOTIZimVMgbYdltBAROT8YjDqyL87JLDi
 BXPGCA72EjF3g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@denx.de>,
 Stefano Babic <sbabic@denx.de>
Subject: [PATCH v2] ARM: imx: Configure GIC clock parent on Data Modul i.MX8M
 Plus eDM SBC
Date: Fri, 19 Jan 2024 17:08:32 +0100
Message-ID: <20240119160845.11412-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

The CONFIG_SPL_BOARD_INIT lets SPL common code call spl_board_init()
during the SPL start up. On this particular system, spl_board_init()
is used to reconfigure GIC clock parent to PLL2 500M, which is the
configuration expected by the Linux kernel. Enable SPL_BOARD_INIT
and fill in the GIC clock configuration code.

Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
allow to change it. Should set the clock after PMIC setting done.
Default is 400 MHz (system_pll1_800m with div = 2) set by ROM for
ND VDD_SOC.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Fabio Estevam <festevam@denx.de>
Cc: Stefano Babic <sbabic@denx.de>
---
V2: Duplicate code comment into commit message
---
 board/data_modul/imx8mp_edm_sbc/spl.c       | 13 +++++++++++++
 configs/imx8mp_data_modul_edm_sbc_defconfig |  1 +
 2 files changed, 14 insertions(+)

diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index a3600c8568a..cc2d253e391 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -80,6 +80,19 @@ int data_modul_imx_edm_sbc_board_power_init(void)
 	return 0;
 }
 
+void spl_board_init(void)
+{
+	/*
+	 * Set GIC clock to 500 MHz for OD VDD_SOC. Kernel driver does not
+	 * allow to change it. Should set the clock after PMIC setting done.
+	 * Default is 400 MHz (system_pll1_800m with div = 2) set by ROM for
+	 * ND VDD_SOC.
+	 */
+	clock_enable(CCGR_GIC, 0);
+	clock_set_target_val(GIC_CLK_ROOT, CLK_ROOT_ON | CLK_ROOT_SOURCE_SEL(5));
+	clock_enable(CCGR_GIC, 1);
+}
+
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	if (boot_dev_spl == SPI_NOR_BOOT)	/* SPI NOR */
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index a55630c1a6d..d29bc986267 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -56,6 +56,7 @@ CONFIG_SPL_MAX_SIZE=0x25000
 CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x96fc00
 CONFIG_SPL_BSS_MAX_SIZE=0x400
+CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_BOOTROM_SUPPORT=y
 # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
 # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
-- 
2.43.0

