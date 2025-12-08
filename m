Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E593AD3B7EA
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 20:47:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23F2C83A57;
	Mon,  8 Dec 2025 21:47:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LeUTHhGv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4EF783AEE; Mon,  8 Dec 2025 21:47:26 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B39783990
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 21:47:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ralph.siemsen@linaro.org
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-8824888ce97so61802326d6.2
 for <u-boot@lists.denx.de>; Mon, 08 Dec 2025 12:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765226842; x=1765831642; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c/4fKeTLzU2N2FsUgiaPEappldAmVdJ9JS4tKX61ksY=;
 b=LeUTHhGvTJLPK8cstyHP5HZZjLsCJhPoV140liPp63DlSOFyoThgmOhmvi7TMgdb+m
 nqhkWqrBbbSNz1IV1fU9ZkGQsCbN/k+aGnNF8hIyTVVKD5jz73Z9c/prYJYHZ9zNIBbX
 EGiNsZYsM7YOhTUFM1sGZ8HEM2kRCuCGvoniSxYdfpbbWdxpVyBwRIxawKDEOvPurITB
 dZSwlJ5w8AfsT62UdoGeZwbEzfQx4GmRZH9NJ+jq5RmxR1+3Ln+l94JBB8b/gXIS3Spz
 WpF1AesY+nF/NSRfi1bTTWHIIkmXJo3LUMD06GwJC9A+h5tsShxENn6i+b4+J0FLfzbB
 EOwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765226842; x=1765831642;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c/4fKeTLzU2N2FsUgiaPEappldAmVdJ9JS4tKX61ksY=;
 b=I1ULFIcoWqZzQNkRaMlMtMV90FYzfA60JOirjk9wgVISpnLmibEZD1e9uVj20QPPZ/
 b5MoO/uNFnsP4sopMmhnsetcMNe7D7BDQiqOsX/unkbUaFTDgbGA3cUeO+BE9GnZKUZd
 ACwFn4a5KTbpgqA1bQSOYEt9NOe5XWoGQGRpTp96PqCUq7r37WL7Jxk/RSSYbmaTRM1f
 NF5vmN4SD29cOHor8UhhUpmPsYxjr+nNtemN90Jway4gZlHKJ222/Ao3BSCJLh3DAJvK
 K/sb+W4q1Ed+RXSqtcIBICM5ecLd5U5zQKkHYGVDEEHc4Rmx/ViaO27a4CunraKfS0bg
 aAHA==
X-Gm-Message-State: AOJu0YyXDmEsmOv/1RgPx1w/999EoVh+I3AQx8Y9RDsVpn1rA5gIEiqV
 o9KeSZvtzOfWQ7XYcsBYTtaARammyAi3b5ITekmG5ryEt6OCBFwF97Em0H1i6i3sm+g=
X-Gm-Gg: ASbGncuRlIga+2P0MNNKRxQtYxWtAhFzb0B8WulnspLjamctJycU+IEtwyASzDAzzWq
 zwVPM7BqKf2quxGOQFT7pKFqDOMLigY2WPTLNQKAAloeu2k8vMUMUL39BVPixT2ES/vAMXA3RLF
 6yklgtrTU4kSUBQc/qG+W7IrgU2+Sbt3BZBvH1nsBQpcuxTyqulVH1It4JkJhg//HQBTYRsxnUn
 5XoxjA15LXGFHbxxRbM62246+g0Wb0rUZZ62Wu09NvR6TnIEdBXw0DBEIgNBBl1sVSepL3BEX42
 yGDsnnUfOzufO6TDiGUPd3gNrCiizX/rei2KWkj5djaS/XA5017ttthS2zKXeld9Ff7T7bhDwJg
 2j0XQyr6Js0kblqo1dOAgQBwM2z3MWf+1Q2dFL6ouzO6POv2Ge1ea1rn8LP5K87I6Y1Z/d+wCby
 GbTBV7DHSMyjNE9oNlo6OPQtw+g4ug
X-Google-Smtp-Source: AGHT+IH2dindWsFOU2Nd8y3Qx2MH2y8OZrBfQN0IZuPBrCdMvdZjVuiYyqEG7MArppb8FAUlv8sfBw==
X-Received: by 2002:a05:6214:d4b:b0:880:5bff:74d6 with SMTP id
 6a1803df08f44-8883dc4b9fcmr171709876d6.51.1765226842155; 
 Mon, 08 Dec 2025 12:47:22 -0800 (PST)
Received: from maple.netwinder.org ([173.206.223.168])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-888583bd0f3sm2624786d6.7.2025.12.08.12.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Dec 2025 12:47:21 -0800 (PST)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Mon, 08 Dec 2025 15:47:06 -0500
Subject: [PATCH] spi: designware: Allow disabling designware driver in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251208-spi-designware-spl-v1-1-21e6f519a4de@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEk5N2kC/x3MQQqAIBBG4avIrBNSMKqrRAvJvxoIEwcqkO6et
 PwW7xUSZIbQqAplXCx8xgrTKFp2HzdoDtVkW+uMbXstiXWA8BZvn1F56NC70HnbwWGgGqaMlZ9
 /Os3v+wETIosUZAAAAA==
X-Change-ID: 20251208-spi-designware-spl-d85d6a26e5e9
To: u-boot@lists.denx.de
Cc: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
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
 drivers/spi/Kconfig  | 8 ++++++++
 drivers/spi/Makefile | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 2afb15fff1e..94054ba39b0 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -223,6 +223,14 @@ config DESIGNWARE_SPI
 	  access the SPI NOR flash on platforms embedding this Designware
 	  IP core.
 
+config SPL_DESIGNWARE_SPI
+	bool "Designware SPI driver in SPL"
+	depends on SPL
+	default y
+	help
+	  Enable the Designware SPI driver during SPL.
+	  See the help of DESIGNWARE_SPI for details.
+
 config EXYNOS_SPI
 	bool "Samsung Exynos SPI driver"
 	depends on ARCH_EXYNOS
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

