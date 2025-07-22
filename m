Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D52AC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 14:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B127083887;
	Tue, 22 Jul 2025 16:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eZFlVhTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 596018388C; Tue, 22 Jul 2025 16:05:06 +0200 (CEST)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3EE583873
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 16:05:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso3482397b3a.1
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 07:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753193102; x=1753797902; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PZDeW0ae0szG/MHN5IOxnV540ERPV/V8sXPMsDOrNZ4=;
 b=eZFlVhTQMJsjBXq/FFMt1JAfizrNN9ayU+xLu3mPsxDovsRfv1srbUNXKAIKT8aEMJ
 YDNcmUpnqHpF6cBXbX49dTorcfAkBIGFVnhuHuUH1TEjgmLTNVazDBXVsI2s4bLXUMeN
 WtasskAzIEtvtMcr7XoFnekAGv/mT2f2mfSyKoq1odzk7js0DzLDJbEfXiKeSz8TeG9S
 A2sPOqrOpbvG70DIiHoH+crs8KNekPwccJ0jsMRu0RuWxs4v6SIWjrA9zgiXxrJ4Jmzl
 vQirQTY4uXVBdRs1PV+RFMKP1BdREqJUSjR7QwcyaTA2FFtJIO49iI5n/k8/56g6/iMy
 Zw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753193102; x=1753797902;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PZDeW0ae0szG/MHN5IOxnV540ERPV/V8sXPMsDOrNZ4=;
 b=f8zEGeylhLxwNSRytiKGr0s5gI+UpR0PV5kVcwP5jAEgE20/YkZ6Gh8i7Sl2YW+Jlx
 P7noz1M5jMdoBUA3+qbd2IfKRAVgCs5zKfO5gpr9eTZ7nFchFCFxYkvW5I1DO05/EJre
 cneOBJsG+yp2zcfkxaoolwg0RcA7zGg9OwxtXs56uR01ZqoQzWVf8S9J6+OAPXlli7vi
 LI7ll5iwRfF387AJ6D/y0/wv1Z5pygAh0Oj3oMiANu47QAz0qkq3QcdfDg+mouqbEZ5n
 LiSk4BEUEbftwug91jpCPMgnfEyo78rGnHCiUYlkb27N4JW5N5G7jfsIbwOoNb6q4apD
 oU+w==
X-Gm-Message-State: AOJu0YySf0lLuZNDBjyOEv8QXRX3SB6c755oEm3D965cKb4/BfzYjcG1
 bO5D3tXryaLhsrBmxmEvRGTXwS6B6Wa2It7MSzub6p6icY+RGDcG6cfF
X-Gm-Gg: ASbGncvNPfUF2PrjREvIRBFi3lFJehsQj1r8X0ccmhkwP8b6/2mFT4807whRAVGMZC3
 +oRZcvTz/illwy6fpFBpWiXCMnO5YgorOZuy/qfxiIs5cXn98vs+Cidkb9RxU7z3viZBEZyois1
 jOiG8e56X089n0EP+zvYg/Cqz8UGzwOx+DZHQYRPR75P6d4B+wsuap5bp9iUS8F5KjtscLUUz35
 NqXw9x7j1nY+70/oFvsIqBp/gc+Yyfhxwl47wiGatL2l6QWYR+pRd1dC1PivHBRcuW6IsFL1of5
 5EuuC1ksY8TAPynh6Fl3di+0rFt9yuvPEXK+rBrYslOoz+MEEe5E3KbEgLxmq0CWaIkerRVq3jb
 9/5zu/w/8RHf7enQG//G5hy6uZqVkWdLFEOiaf6cc6g==
X-Google-Smtp-Source: AGHT+IGPKI6Hup88a+CIQee+ZNCinOddq+ynirHGtoR/kBkk12dbCfX345bpehVTAHEaI+a6g9gNSQ==
X-Received: by 2002:a05:6a00:ad3:b0:748:f1ba:9af8 with SMTP id
 d2e1a72fcca58-756ea5c7e6bmr34869166b3a.21.1753193102031; 
 Tue, 22 Jul 2025 07:05:02 -0700 (PDT)
Received: from [192.168.0.7] ([2804:14c:490:1191:4a5e:d649:8d77:acd7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-759cbc6c16esm7824927b3a.149.2025.07.22.07.04.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 07:05:01 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Tue, 22 Jul 2025 11:04:45 -0300
Subject: [PATCH] arm: imx: imx9: scmi: Fix booting from USB
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250722-v1-fix-imx95-usb-boot-v1-1-dec7f2384405@toradex.com>
X-B4-Tracking: v=1; b=H4sIAHyaf2gC/x2MQQqAIBAAvxJ7bkEFk/pKdMjaag9paIkQ/j3pO
 DAzL0QKTBGG5oVAiSN7V0G2DSzH7HZCXiuDEkoLoxQmiRtn5DP3Gp9o0Xp/Y0/dajphSQqC2l6
 BqvV/x6mUD8QYV7xnAAAA
X-Change-ID: 20250722-v1-fix-imx95-usb-boot-9e6d760be10e
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

On i.MX95, when booting from USB, the U-Boot environment is always
assumed to be in RAM. However, this causes the boot to hang when
`CONFIG_ENV_IS_NOWHERE` is not enabled. The boot also hangs even if the
environment is present in another storage media (for example, eMMC). Fix
the issue by correctly handling the U-Boot environment's location when
booting from USB. Also, set the environment location based on the ENV
config and not solely based on the boot device type.

---
Hello all,

The change was not tested on mainline, but with downstream
`toradex_imx_lf_v2024.04` U-Boot branch. In the past, i.MX8M had the
same problem and the solution was similar.

Best Regards,
João Paulo Gonçalves
---
 arch/arm/mach-imx/imx9/scmi/soc.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 13f13ca7d1056ac5a9f1b529b13e0d8dbe2462f1..2c052c38521793e1f6ab2dc5125afa3b5ca63d0f 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -633,9 +633,13 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	if (prio)
 		return env_loc;
 
+	if (IS_ENABLED(CONFIG_ENV_IS_NOWHERE))
+		env_loc = ENVL_NOWHERE;
+
 	switch (dev) {
 	case QSPI_BOOT:
-		env_loc = ENVL_SPI_FLASH;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			env_loc = ENVL_SPI_FLASH;
 		break;
 	case SD1_BOOT:
 	case SD2_BOOT:
@@ -643,10 +647,14 @@ enum env_location env_get_location(enum env_operation op, int prio)
 	case MMC1_BOOT:
 	case MMC2_BOOT:
 	case MMC3_BOOT:
-		env_loc =  ENVL_MMC;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			env_loc =  ENVL_MMC;
 		break;
 	default:
-		env_loc = ENVL_NOWHERE;
+		if (IS_ENABLED(CONFIG_ENV_IS_IN_SPI_FLASH))
+			env_loc = ENVL_SPI_FLASH;
+		else if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+			env_loc = ENVL_MMC;
 		break;
 	}
 

---
base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
change-id: 20250722-v1-fix-imx95-usb-boot-9e6d760be10e

Best regards,
-- 
João Paulo Gonçalves <joao.goncalves@toradex.com>

