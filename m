Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15269C4167B
	for <u-boot@archiver.kernel.org>; Thu,  7 Dec 2023 17:51:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A80F8747A;
	Thu,  7 Dec 2023 18:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1701971479;
	bh=Yb+aNHoAh0rIU/ri7Y/Oaaa4i5Bb72ajdmaEhLPFy1g=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ppZIQxZUbEocJVFuBWDWzjCiyB/7eII5jbsFyXRLT9+hllhz7RlwH2IIYsgE+VVSJ
	 41MzcozQ9skRIDsq7Hw2bGPskLFoN8a4x4H1PlWKKjK40ieWn5JWtPXUg6Y6r+n9YM
	 xFkk2aKYcKvJiAcSSdvpOSzglsQvC2psbC3pHwic2+yM8/oGHN+3vxbP/N4RXSoIl2
	 KoCtYJSbQQSe+GrjIbXIichfjk5w3CnZJNF35RtkS4oSaGfQ76/lsgXGIZJlx7BhDt
	 zpy/H+llhdAJS+Y+x6HmpvUMlGh1bMq0GXYpwFT2vX99ChQFyDjTuawlw02jb747hB
	 HDqM2l69cPzxg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 1EE59865A8;
 Thu,  7 Dec 2023 18:51:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1701971478;
 bh=Yb+aNHoAh0rIU/ri7Y/Oaaa4i5Bb72ajdmaEhLPFy1g=;
 h=From:To:Cc:Subject:Date:From;
 b=mqgJDi8vIoLauru/8u/aCQAbgkvInkMeP03qcrum8wGBEUi3u3X1QPncsnyN5U/SO
 lM89dUDRuq9H9uTC6Ub0zlDpfO3i0SILYZwBooFSYHrLV/kd84Cj/2N/gKyPPhTh9Q
 GX0D7uVlc7bTOBgL7GY3lBst7SuTeNpX+g+2kwvrX/vZymJpa6wqXlrsJVER0We8p9
 7AaN22sfV/zCYHGe/2xXp8psRqKXK9b3Xk/UEzDE0RZNx2JGCxEhYyJyHykkZwnAbh
 mh87pq336lNMBSEsPoqooV9nn5V70ewW2LIjsHHNn8W9YZf1coQjeQg0w0raejdxF8
 2VX6AegRjP6fQ==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>
Subject: [PATCH 1/2] ARM: imx: Force DRAM regulators into FPWM mode on Data
 Modul i.MX8M Plus eDM SBC
Date: Thu,  7 Dec 2023 18:50:31 +0100
Message-ID: <20231207175056.336787-1-marex@denx.de>
X-Mailer: git-send-email 2.42.0
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

In case the Buck5 and Buck6 regulators which supply DRAM Vdd1 and Vdd2/Vddq
respectively operate in automatic PWM/PFM mode, the DRAM EDAC detects more
correctable errors than if the regulators operate in forced PWM only mode.
Force DRAM regulators to forced PWM mode only to stop tempting the DRAM.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
---
 board/data_modul/imx8mp_edm_sbc/spl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/data_modul/imx8mp_edm_sbc/spl.c b/board/data_modul/imx8mp_edm_sbc/spl.c
index cfc4b65e0f9..a3600c8568a 100644
--- a/board/data_modul/imx8mp_edm_sbc/spl.c
+++ b/board/data_modul/imx8mp_edm_sbc/spl.c
@@ -68,6 +68,11 @@ int data_modul_imx_edm_sbc_board_power_init(void)
 	/* To avoid timing risk from SoC to ARM, increase VDD_ARM to OD voltage 0.95V */
 	pmic_reg_write(dev, PCA9450_BUCK2OUT_DVS0, 0x1c);
 
+	/* DRAM Vdd1 always FPWM */
+	pmic_reg_write(dev, PCA9450_BUCK5CTRL, 0x0d);
+	/* DRAM Vdd2/Vddq always FPWM */
+	pmic_reg_write(dev, PCA9450_BUCK6CTRL, 0x0d);
+
 	/* Set LDO4 and CONFIG2 to enable the I2C level translator. */
 	pmic_reg_write(dev, PCA9450_LDO4CTRL, 0x59);
 	pmic_reg_write(dev, PCA9450_CONFIG2, 0x1);
-- 
2.42.0

