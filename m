Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD895D41D61
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 16:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1865D830E4;
	Thu, 11 Dec 2025 17:05:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KBKWJxPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6A5E835B3; Thu, 11 Dec 2025 17:05:41 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AF68309A
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 17:05:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-4eda77e2358so2361031cf.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 08:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765469138; x=1766073938; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5Dm3XcHHf7p4GibsIIpyHhijZXrIej0yUjv1Nbkuv9c=;
 b=KBKWJxPPXm/BZeglZ5BFdrFBLFqI2LmPB5OavdKgEXgS8yPXaFJd1fOq8h0x6pRBPm
 hbrHDC+Iz5L7S/aGEOPpoo9aDl330wgoC88991493LU8j9OHjCZOur/ClWL4b9KBm7NK
 YggaZacwWp4GIJPeNwuItYzUw1qNQlh/QeQR6pYsFw+h1/TVpNumuiw0AItvaVxlJ2es
 bFzlTVFuAuFVo5o8XDUb+qGrWiMbky8ZFMEW0O7L1X4XS2DmePYOnD5In6d2wg4UiC/n
 ermAr7gc5XypHSPZdZmexsa4fhoVVYMKjSH6ipHcIRPPVtUayie+WiKpZeEs1uZGa5/4
 MXaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765469138; x=1766073938;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Dm3XcHHf7p4GibsIIpyHhijZXrIej0yUjv1Nbkuv9c=;
 b=moCumeRJKYA85g3938bxCmI0o550nhfp2/c5rdgtb7Zv+HGGbbM7knsZGFXa8fK71C
 oYxWQHtDXBRGcBojGtoujRyQ076Zo7rHoa9QjH8AI6NyRjqGY0IgQHUI+dcz0uRfsSZL
 cU2gmYb//MPEPnxLHUbyudIJkvfXJaFXIvaIm3Es/8uPYstYazU3xgAmqkGbVv8Gfwd+
 6+GAYxJVTKiy5vGW2lrAT0UGEBaTsseGReC7m3b3ka+cY4wwZP9AHdFvYF1Ej38I9g2Q
 i6BIpHxrU/tb9vplvryd8oWDUO38w2OJSVTP6yffyRekWFziZLYNl2BlESXwxa82+NJU
 rbBg==
X-Gm-Message-State: AOJu0YxW8FZ/kd3pgx/tvC3tmdXf19Y06OFOBUuKxXHDOUdxi1MjApL6
 5FIz7LTCR/6ZbbpkRIAObiYPiRJYlqQhMoT04CioIhn6Xx3OE3KjZ8M5AM8ercFuM1M=
X-Gm-Gg: AY/fxX64gC8c9uRvH/vsSQEpbiNOQg3mXc1rN4mqadNRkTbE+tjM5FOk0eUMWxC8DCt
 y37kJPXQrBW0HcobZgJx8XsWfPnE0TxnumRzlUpOQ78ZB1EbfpHocBGrqS2SJFyPLAbB+/EDtZu
 ZjhTHB6PtTMQFD5gPsgvj9mp74NLg9mF+bKM8fUhwSL51F3F7JlmN5cICJPUu5SdiwqK1YIWO83
 JoZ64kikV4QA23ccXhc52KxmtWn7JEUZ82Th2IkkKS1cSWPMjf2lCRqQuALC8qnjK5+DNpzg1Kc
 ixqg3+/f3vn/tnLEKOsquZJPXUHK7iBPZfnhQoBdD+wTwM5PVJuN6s5kN8oTobWexFfnUtnIIEB
 vt5Fzb6qIwU2whawnpSfD4ub13ly+4m9pFAFyPcfpP1I3A3rJXmcE0vy+t3zSk/B/3lkFvq+uMf
 6xtowDJWiEIrI1iX2kxe2MZ38RNO5t
X-Google-Smtp-Source: AGHT+IEGGimfriBvcSBK9rG/rQnHpxCv/Pg1yClTLrT+Vssfmtq3PPE8SPfntB7We6zO61Lr/ZUroQ==
X-Received: by 2002:a05:622a:17c5:b0:4ee:1b99:e112 with SMTP id
 d75a77b69052e-4f1b1a09a98mr96478191cf.34.1765469137517; 
 Thu, 11 Dec 2025 08:05:37 -0800 (PST)
Received: from maple.netwinder.org ([173.206.223.168])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4f1bd5dc8b3sm22291171cf.15.2025.12.11.08.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 08:05:37 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Thu, 11 Dec 2025 11:05:23 -0500
Subject: [PATCH v2] spi: designware: Allow disabling designware driver in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-spi-designware-spl-v2-1-4b570c82e357@linaro.org>
X-B4-Tracking: v=1; b=H4sIAMLrOmkC/33NQQrCMBAF0KuUWRtpBhNaV95Dughmmg6UpEwkK
 iV3N/YALt+H//8OmYQpw7XbQahw5hQb8NTBY3ExkGLfDNij0dgPKm+sPGUO8eWEGlflB+OtQ0u
 GRmjFTWjm9zF6n5oXzs8kn+Oj6F/6d65opRVqsrPRo7t4uq0cnaRzkgBTrfUL88ydUbUAAAA=
X-Change-ID: 20251208-spi-designware-spl-d85d6a26e5e9
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Sean Anderson <sean.anderson@seco.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183
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

To reduce SPL size, make it possible to exclude designware driver,
while keeping it enabled in the main u-boot.

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
Changes in v2:
- defaut y if DESIGNWARE_SPI  (Tom)
- move out of the SPI/DM_SPI and add depends SPL_DM_SPI (Sean)
- Link to v1: https://lore.kernel.org/r/20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org
---
 drivers/spi/Kconfig  | 8 ++++++++
 drivers/spi/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2afb15fff1e..e31db9d4e31 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -677,6 +677,14 @@ config SH_QSPI
 	  Enable the Renesas Quad SPI controller driver. This driver can be
 	  used on Renesas SoCs.
 
+config SPL_DESIGNWARE_SPI
+	bool "Designware SPI driver in SPL"
+	depends on SPL_DM_SPI
+	default y if DESIGNWARE_SPI
+	help
+	  Enable the Designware SPI driver during SPL.
+	  See the help of DESIGNWARE_SPI for details.
+
 config MXC_SPI
 	bool "MXC SPI Driver"
 	depends on MACH_IMX
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d5d1e543588..0dc2d23e172 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -35,7 +35,7 @@ obj-$(CONFIG_CF_SPI) += cf_spi.o
 obj-$(CONFIG_CORTINA_SFLASH) += ca_sflash.o
 obj-$(CONFIG_CV1800B_SPIF) += cv1800b_spif.o
 obj-$(CONFIG_DAVINCI_SPI) += davinci_spi.o
-obj-$(CONFIG_DESIGNWARE_SPI) += designware_spi.o
+obj-$(CONFIG_$(PHASE_)DESIGNWARE_SPI) += designware_spi.o
 obj-$(CONFIG_EXYNOS_SPI) += exynos_spi.o
 obj-$(CONFIG_FSL_DSPI) += fsl_dspi.o
 obj-$(CONFIG_FSL_ESPI) += fsl_espi.o

---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20251208-spi-designware-spl-d85d6a26e5e9

Best regards,
--  
Ralph Siemsen <ralph.siemsen@linaro.org>

