Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3551C4167B
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 05:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3109C87BA3;
	Sat, 16 Dec 2023 06:43:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1702705384;
	bh=AYYyhMK01+kqMQqBLuFPs6XHhZKNKI+F59sWYcNoNNU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=i3MkStSvSnTscfJlpJumbh/3qD6AQNWbfv8pCIR+dXnZhPVrZHe+mOS0RjHVXfkKC
	 urOShJghpcx96UmzEDzaYm6C3rTznUvLESopm6ziBILpHoQoSg7z4nJheFnL+EvehF
	 O0d0GcMajxZbiiKXqqnFE/jMYdXYrco03hEDBzTZ2G9OMVn4LoKD/7PZMehsree5ZA
	 WZY7avQqgILAC8ZndZklOfKrCaqHCmqS71zqtPBVzYvE7GZkA4b6RL8l6wJo/GHslq
	 +vl9smi4FnYfgSqveBuVgo1k9fhQzgQhVg6l924Wq4EahUBx4HGdi46Drv7Y2L7AvH
	 s87xzhfdocDSA==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id BD9A787AF3;
 Sat, 16 Dec 2023 06:43:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1702705382;
 bh=AYYyhMK01+kqMQqBLuFPs6XHhZKNKI+F59sWYcNoNNU=;
 h=From:To:Cc:Subject:Date:From;
 b=pv0gKRCl/p6XRmPcly+CH/aZRg81hxraK+IpzUVNe6QqmsXxUiT0PC+zgC/ZcI3Xl
 XhYhPfHkZVr/lDAVq7tL+vBDCTCk96fE6VSyd58jYZjiUJNJBdEoiU4TZSVjQyRNag
 2te1vH6/Pi9rQhhjlxsVq90vl5651ttKGVdZ4JQdM/1YPSdTKOd6HDMl4lSUhbGuNU
 uAsFBFMEntW14VZaZGFrm7WYLGdORU0iNAiJCYBn37PpIeJYAfjNRqqfGQT7ayIl5U
 f8cSpWLmu6BnhCwU+8mG8zIuuQgq1u1Yodhi/phmd/V5Uto0sDAhPHqu/snwDBR1C4
 av4N0qCW3HF+w==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>,
 u-boot@dh-electronics.com
Subject: [PATCH 1/2] ARM: imx: Force DRAM regulators into FPWM mode on DH
 i.MX8MP DHCOM SoM
Date: Sat, 16 Dec 2023 06:42:28 +0100
Message-ID: <20231216054243.327104-1-marex@denx.de>
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

In case the Buck5 and Buck6 regulators which supply DRAM Vdd1 and Vdd2/Vddq
respectively operate in automatic PWM/PFM mode, the DRAM EDAC detects more
correctable errors than if the regulators operate in forced PWM only mode.
Force DRAM regulators to forced PWM mode only to stop tempting the DRAM.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Stefano Babic <sbabic@denx.de>
Cc: u-boot@dh-electronics.com
---
 board/dhelectronics/dh_imx8mp/spl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/board/dhelectronics/dh_imx8mp/spl.c b/board/dhelectronics/dh_imx8mp/spl.c
index 1b05da53c35..21b12a70c8e 100644
--- a/board/dhelectronics/dh_imx8mp/spl.c
+++ b/board/dhelectronics/dh_imx8mp/spl.c
@@ -94,6 +94,11 @@ static int dh_imx8mp_board_power_init(void)
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
2.43.0

