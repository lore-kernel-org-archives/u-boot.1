Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4E8CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 14:40:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 681B9849AF;
	Wed, 10 Jun 2026 16:40:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kqMfvRcD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D39849BA; Wed, 10 Jun 2026 16:40:01 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72DF38494B
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 16:39:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-68c201ec1cfso957893a12.0
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 07:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781102399; x=1781707199; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Y5Kx4PDMHdF3+MYEDz7bD8G9BLnDB4XReVZpOLjw3Fc=;
 b=kqMfvRcDiafgoh/X8Z3JnCzFRRyjuiwMsvBWDg2GqUWhgY5Y50gb8L7zN9xyfa4gAA
 C3twfW7Rx4lbCvG5msLbucuhzRi3reDjYvE6a0nKEBFN2ODct3qeGLzvz53NxeNs7yhP
 Fig7gdy/FqhmXJWAZeY2ZKCC/BSaUyfDR8sJD7Yd3cnNZ9tG5Y3IQGYydQLUrX/mAtsi
 gy4p4mb2uhUuI+4a5MC/2Q5EytZCuPcIT4V3+23utVUICs6l7ZNm7aAEw1ItsvIXXMkH
 1vP3TKasYWRLJ1w+BDyE69W/0zkfpWLVOvnwYHhpeg8U0pA5M3keSMGPhrpv5R0oVRe+
 yQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781102399; x=1781707199;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5Kx4PDMHdF3+MYEDz7bD8G9BLnDB4XReVZpOLjw3Fc=;
 b=JbZZ69bA5HO8SWy2cj1gwXfQuuvHZlG4RuukRQ0RuzAQDAlW9Ih8pj4ER9zFZNDQRR
 GtifJgn9llKNJOqMgTaPLRcKVcCkyn0e0/HbI74UUlR0eZdzgCWK6cqWSTMHamo059L2
 EMFMBJbG+LcQ9YoHb37+A1QHBrY1qYL2cZBUJ90qVk2JlrKHMfxs19MKmt1rXUPN2mpa
 tLNn+MWineFeepuwkRTY/ZKBj7guCRZmvnQM6ZWzgVJaAvId9pPTijCxaPNS8av+tp3l
 dcP/iJ6KiySWdFtxpbVfOVfZV6Zf9d55mwCXgkReNCkdr+kBedFtEoRnLTCZQ2jPdEcF
 2GUQ==
X-Gm-Message-State: AOJu0YyWiG+8ivaK57dFJzRjCzR7mzRzTjUKr9eMT2V7fcAlLkZBPA5h
 Vt/YAm+O0kCR6kdvDvTJ/GtuOix8++MW4Tilj0eR9xkyxbQyXhE+3i0MYrTY8Q==
X-Gm-Gg: Acq92OEsTwtw7/t9Gl3YwAsUsU1brVbN/r0TVpigDp0euN5DdGoyXkOtwxCXRWFjCvq
 gMJjFhdHhGcKV7MBHRhzNTl5OeI11UeYjbXCr+k7b2bctHx1r5hkT0UD+qq8CYN4VMhiPHlNhk0
 8X2300orGU5HdKc4wgSebDiP/pUX6PHZz3HUk73srsGvPaSUxdL5bb07E7yJI5CX4xvDdFGqqbS
 /4MzimeDmydW1YD2pnvXNx2lgiHR8SPDj8IbCWZmdlKzjqoy70ApHr/Dxj9/BN5+30TgQvYmSBb
 seZotYWDOsgKHq7RwkGauxQs869ZwMrq/JABoF/5hjpjui2o3Zy/jZnGEbQaakPF7npRpsazV1j
 TXDPVGkBh/4V8lCdWpzvAmgMTIN3kly8GhXRlM/s/3CXSD9+vgAFFiVGFz5YC+s6BWZD9I6pkad
 cuUNkoC0C+zrSwTPWUhToJNLyLcAuXamhd37QeeruKCEVNx6i+DqR7vMzoFVWgJzuKn5Ajge8i
X-Received: by 2002:a05:6402:388:b0:691:4586:4651 with SMTP id
 4fb4d7f45d1cf-69145865088mr3937078a12.8.1781102398636; 
 Wed, 10 Jun 2026 07:39:58 -0700 (PDT)
Received: from ?IPV6:2a02:a449:4071:0:32d0:42ff:fe10:6983?
 ([2a02:a449:4071:0:32d0:42ff:fe10:6983])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-68e65b57c66sm9879348a12.28.2026.06.10.07.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2026 07:39:58 -0700 (PDT)
Message-ID: <62e7aff9-19e0-4bc3-ae8b-29a2b474f772@gmail.com>
Date: Wed, 10 Jun 2026 16:39:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 12/18] Kconfig: pinctrl: restyle
To: trini@konsulko.com
Cc: u-boot@lists.denx.de
References: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Language: en-US, ar-EG
In-Reply-To: <ef462dea-69aa-48df-9f7c-af2e6c54e52a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Restyle all Kconfigs for "pinctrl":
Menu entries   : no space left
Menu attributes: 1 TAB
Help text      : 1 TAB + 2 spaces
Replace '---help---' by 'help'

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 drivers/pinctrl/broadcom/Kconfig |  8 ++++----
 drivers/pinctrl/mediatek/Kconfig |  2 +-
 drivers/pinctrl/mscc/Kconfig     | 20 ++++++++++----------
 drivers/pinctrl/mvebu/Kconfig    | 12 ++++++------
 drivers/pinctrl/qcom/Kconfig     | 10 +++++-----
 5 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/pinctrl/broadcom/Kconfig b/drivers/pinctrl/broadcom/Kconfig
index b01b725583ae..d7cf3855928e 100644
--- a/drivers/pinctrl/broadcom/Kconfig
+++ b/drivers/pinctrl/broadcom/Kconfig
@@ -3,13 +3,13 @@ config PINCTRL_BCM283X
 	default y
 	bool "Broadcom 283x family pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Broadcom's 283x family of SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Broadcom's 283x family of SoCs.

 config PINCTRL_BCM6838
 	depends on ARCH_BMIPS && PINCTRL_FULL && OF_CONTROL
 	default y
 	bool "Broadcom 6838 family pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Broadcom's 6838 family of SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Broadcom's 6838 family of SoCs.
diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index cf72a7df62c6..5a90d74a9e1a 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -59,7 +59,7 @@ config PINCTRL_MT8516
 	select PINCTRL_MTK

 config PINCTRL_MT8518
-        bool "MT8518 SoC pinctrl driver"
+	bool "MT8518 SoC pinctrl driver"
 	select PINCTRL_MTK

 endif
diff --git a/drivers/pinctrl/mscc/Kconfig b/drivers/pinctrl/mscc/Kconfig
index 567c93f404cc..285787c4467f 100644
--- a/drivers/pinctrl/mscc/Kconfig
+++ b/drivers/pinctrl/mscc/Kconfig
@@ -10,8 +10,8 @@ config PINCTRL_MSCC_OCELOT
 	default y
 	bool "Microsemi ocelot family pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Microsemi ocelot SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Microsemi ocelot SoCs.

 config PINCTRL_MSCC_LUTON
 	depends on SOC_LUTON && PINCTRL_FULL && OF_CONTROL
@@ -19,8 +19,8 @@ config PINCTRL_MSCC_LUTON
 	default y
 	bool "Microsemi luton family pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Microsemi luton SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Microsemi luton SoCs.

 config PINCTRL_MSCC_JR2
 	depends on SOC_JR2 && PINCTRL_FULL && OF_CONTROL
@@ -28,8 +28,8 @@ config PINCTRL_MSCC_JR2
 	default y
 	bool "Microsemi jr2 family pin control driver"
 	help
-	    Support pin multiplexing and pin configuration control on
-	    Microsemi jr2 SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Microsemi jr2 SoCs.

 config PINCTRL_MSCC_SERVALT
 	depends on SOC_SERVALT && PINCTRL_FULL && OF_CONTROL
@@ -37,8 +37,8 @@ config PINCTRL_MSCC_SERVALT
 	default y
 	bool "Microsemi servalt family pin control driver"
 	help
-	    Support pin multiplexing and pin configuration control on
-	    Microsemi servalt SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Microsemi servalt SoCs.

 config PINCTRL_MSCC_SERVAL
 	depends on SOC_SERVAL && PINCTRL_FULL && OF_CONTROL
@@ -46,6 +46,6 @@ config PINCTRL_MSCC_SERVAL
 	default y
 	bool "Microsemi serval family pin control driver"
 	help
-	    Support pin multiplexing and pin configuration control on
-	    Microsemi serval SoCs.
+	  Support pin multiplexing and pin configuration control on
+	  Microsemi serval SoCs.

diff --git a/drivers/pinctrl/mvebu/Kconfig b/drivers/pinctrl/mvebu/Kconfig
index 10ba440f246e..72b97a7935db 100644
--- a/drivers/pinctrl/mvebu/Kconfig
+++ b/drivers/pinctrl/mvebu/Kconfig
@@ -4,22 +4,22 @@ config PINCTRL_ARMADA_38X
 	depends on ARMADA_38X && PINCTRL_FULL
 	bool "Armada 38x pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Marvell's Armada-38x SoC.
+	  Support pin multiplexing and pin configuration control on
+	  Marvell's Armada-38x SoC.

 config PINCTRL_ARMADA_37XX
 	depends on ARMADA_3700 && PINCTRL_FULL
 	select DEVRES
 	bool "Armada 37xx pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Marvell's Armada-37xx SoC.
+	  Support pin multiplexing and pin configuration control on
+	  Marvell's Armada-37xx SoC.

 config PINCTRL_ARMADA_8K
 	depends on (ARMADA_8K || ALLEYCAT_5) && PINCTRL_FULL
 	bool "Armada 7k/8k pin control driver"
 	help
-	   Support pin multiplexing and pin configuration control on
-	   Marvell's Armada-8K SoC.
+	  Support pin multiplexing and pin configuration control on
+	  Marvell's Armada-8K SoC.

 endif
diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 11e6763b5f3e..6f8da2d12568 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -79,12 +79,12 @@ config PINCTRL_QCOM_QCS404
 	  as well as the associated GPIO driver.

 config PINCTRL_QCOM_QCS615
-        bool "Qualcomm QCS615 Pinctrl"
+	bool "Qualcomm QCS615 Pinctrl"
 	default y if PINCTRL_QCOM_GENERIC
-        select PINCTRL_QCOM
-        help
-          Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
-          as well as the associated GPIO driver.
+	select PINCTRL_QCOM
+	help
+	  Say Y here to enable support for pinctrl on the Snapdragon QCS615 SoC,
+	  as well as the associated GPIO driver.

 config PINCTRL_QCOM_SA8775P
 	bool "Qualcomm SA8775P Pinctrl"
--
2.39.5

