Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A8BC54798
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 16:19:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6F4387FC8;
	Thu,  7 Mar 2024 17:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GwE+DPWt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F9F787D8F; Thu,  7 Mar 2024 16:24:02 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C10987D16
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 16:23:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=parth105105@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a3ed9cae56fso393800966b.1
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 07:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709825035; x=1710429835; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M7cDC9p0MOdLSN2toxJvdp7scQADGdm76ICDC68MWmQ=;
 b=GwE+DPWtbLezx93fMIah/X3mqCttsMxBqymuqxmKllLVr+u2O9xTbrT57fBTKUz8Ew
 Iu0Yz8DB193Qgr/pX+4LiLxsUDAglvXSvmbFeRjLEUXTQnGv3KsiiowcwV1deUOTG2Cl
 4mBMSRiKtqirAj9ZcbwdS6/RmhOMM4zSu63w6Rb4aYsnW90cq/FHE0qvKw6WmOjZfD48
 jm3qEH4x1JcHk4OhUQuCfYdDe2yhD98jKHiMGo87LCwqO/5MX/4pxhQ53fJESScq4K1S
 sq4QxOQCKSr4rh/0LyJi7kZ9TZ/S/eReqb0OzxwwOtMeyEwgfHSH3VHFbP+nvl26jSlv
 DkNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709825035; x=1710429835;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M7cDC9p0MOdLSN2toxJvdp7scQADGdm76ICDC68MWmQ=;
 b=V6XlM1Lyyb2MuarKmxM4FTdeVtmTd+rq0bVdvFXPnj1jIpWAJQk7At6hJaTmA7grLE
 Nafot4irILpOeDrqWlKt3osxaiy7p9TT2MMFwelOhMh33qk4XbkFmShzyMleC+4sMPxe
 iY0uBuJdTxlGiyL9g8r3rda5VtVq1HUOfA4AFS31BXS41JxOeTJyX9m//EUz9RGhRLpj
 jvTH/uMK7H+QPDX9ysClD/YzSvJMVmZBHgg8iyQJCqTFf9pnPc+ZkfIWyStBNSnAXaKq
 6SiYdEz1lyDYGXNiMuav9QJuGcxi2kzRihKrCBbUELlICytPhlES3aDGWhJobWCbEjwO
 3qoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3fWGxJFQ2NiRhE21wRDfy721vLzWBpXiEolhs0KXbdASkIfuA/x1kTTB32unsu68W7tnytp1r/GB6B/aznFq1ZMYBUw==
X-Gm-Message-State: AOJu0Yy4L2zT+oo5QH/bgAbdp449aDorTvEvx70N/a9uPMdn7W7H7tkt
 TT9perQ1rRe8XZabhxdGecSZ5cq7wfTjnBoTPTFfnOg6bOFSi4VaUxBq3Se+6AM=
X-Google-Smtp-Source: AGHT+IFjrZB3JLFb0uu8IfoW/a9PwbFA2U+krSVYxYzobwIsruBv7bQmaXtb6L4MLZ81ezaLuIc+8A==
X-Received: by 2002:a17:906:b293:b0:a45:b7aa:ca29 with SMTP id
 q19-20020a170906b29300b00a45b7aaca29mr1726422ejz.22.1709825035152; 
 Thu, 07 Mar 2024 07:23:55 -0800 (PST)
Received: from partp-nb.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 p5-20020a1709060dc500b00a4537466591sm4843037eji.32.2024.03.07.07.23.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 07:23:54 -0800 (PST)
From: Parth Pancholi <parth105105@gmail.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Parth Pancholi <parth.pancholi@toradex.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] configs: colibri-imx7: enable watchdog
Date: Thu,  7 Mar 2024 16:23:02 +0100
Message-Id: <20240307152302.2338472-1-parth105105@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 Mar 2024 17:18:36 +0100
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

From: Parth Pancholi <parth.pancholi@toradex.com>

Enable watchdog functionality for Toradex's Colibri iMX7 (NAND/EMMC)
modules.

Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
---
 arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi | 4 ++++
 configs/colibri_imx7_defconfig                 | 2 ++
 configs/colibri_imx7_emmc_defconfig            | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
index 68142769d3..854bf2798a 100644
--- a/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
+++ b/arch/arm/dts/imx7d-colibri-eval-v3-u-boot.dtsi
@@ -51,3 +51,7 @@
 		};
 	};
 };
+
+&wdog1 {
+	bootph-pre-ram;
+};
diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 58eb431785..0c6a272ddf 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -98,10 +98,12 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_RN5T567=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_WDT=y
 CONFIG_CI_UDC=y
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 3382371d40..9d4423cd0d 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -85,10 +85,12 @@ CONFIG_DM_PMIC=y
 CONFIG_PMIC_RN5T567=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
+CONFIG_IMX_WATCHDOG=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_MANUFACTURER="Toradex"
 CONFIG_USB_GADGET_VENDOR_NUM=0x1b67
 CONFIG_USB_GADGET_PRODUCT_NUM=0x4000
+CONFIG_WDT=y
 CONFIG_CI_UDC=y
-- 
2.34.1

