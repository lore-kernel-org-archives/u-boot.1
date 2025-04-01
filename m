Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81131C36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 07:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97D1381F69;
	Tue,  1 Apr 2025 09:01:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Eb6E3xl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4829281F0D; Tue,  1 Apr 2025 09:01:41 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC0DE81F66
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 09:01:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so46914385e9.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1743490898; x=1744095698;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTQ+TNjN0ZkbXi6gStEVEIBZZSMT6jM2ofTUWWx3Nss=;
 b=Eb6E3xl521Nf2DL2oYxSRNBcYI6XwYZcz9Uow4FswpzVbtrgpYSQoKolxJO1PUYIoJ
 cbLRgWrLAUO1P+X+fu9brUlbXxwmPMmfYymdBpvCGrPHK0zdSw61/KxtV09XR9n9cZXX
 LvKR0q66XJ996GmR5/uz92w6UPD86JEB/h/o4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743490898; x=1744095698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kTQ+TNjN0ZkbXi6gStEVEIBZZSMT6jM2ofTUWWx3Nss=;
 b=mUJWoK699dPrgOEJDJSUXb2457B2cs5M1PaJ2SYcNlj3ycH67/4lx4Sq3ZA1HPnIR2
 eXFrmVFDv9byL/NGy/e/tzeOwSE89iNSDeX7Lx4AfnCBWr0VhKoJNpNMUPOxYMoaBptT
 YyigP4EJdfCxIB+ME5TKOCS/bqEpV7cbfs6xtrRQI5jZWb9rrgkEbioEicTAul5Pa7Jd
 NcLYnPwT/P0ICOPmLOzehDDirazDk4J/v3TVYnOqiredzpAKYIE6KRAPJxAZMeTpCqA2
 iPV+SVJk7flzhiBEqvNIXwG4sF3smFJ4tslTlxMxWuuSm/yJRH6W1KHotV/pePf1eRAV
 FmRg==
X-Gm-Message-State: AOJu0Yzu2n+mQE/YFqPzisCt+4xcSQPP6yPmLN708r1pdvz3nAPceYAG
 aP8lUB1fjh7QGNolb4c/UgJ45hw6Iu6kUOff5QuVmsC7AC2uLZw/jdqAPb8ajPoRgEenZr3/pOw
 c
X-Gm-Gg: ASbGncvypyxXle421yZy6ngSjiuLFOHzrWNoxmTXCQPgBwD6NdL2P1RKSdovh+nz+/x
 6X2OoYVdNSyGFfRDvxq7nF5sMDxPMY86wY7yTzmlxIb7/7ha8XbIbepw5wAh0zpE+3F7TvrGCK+
 TCMW3wAr7vB0YjgVc5mrVu6SiyUwuOFJtsIkAREvqqOHdMQlNkVK31Z3jlMrSlc7nVnO2fDFgut
 D8N8R+zySyUlrAcbQQMuV5+MuakpbKKg2w8lIttnAVTVey+9pGQ6LMhstbJxlixpxpzQ/HFxZbK
 VCB3C6k3/RCcp1bs7/zzzTSsuX+DIcmjqQaIFJu72cGDaBsTpiqkrjBuPezLd/vGnQNX85Pkz2a
 vTKP2Hl6A/g==
X-Google-Smtp-Source: AGHT+IHMD1aP/Wpogv7IoutMlL8YlXO6P2Hu8HIWE2cSle7SIQHie/5zCiL4Xx8axF87UD18PdgO8Q==
X-Received: by 2002:a5d:5982:0:b0:390:e9b5:d69c with SMTP id
 ffacd0b85a97d-39c120e3873mr9871980f8f.25.1743490898168; 
 Tue, 01 Apr 2025 00:01:38 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66b015sm13701760f8f.54.2025.04.01.00.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 00:01:37 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Vikas Manocha <vikas.manocha@st.com>,
 uboot-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v2 6/6] configs: stm32f769-disco: support FRD400B25025-A-CTK
 display
Date: Tue,  1 Apr 2025 09:00:57 +0200
Message-ID: <20250401070125.3705126-7-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
References: <20250401070125.3705126-1-dario.binacchi@amarulasolutions.com>
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

Support FRIDA FRD400B25025-A-CTK display on stm32f769-disco board.

As reported in the section 8.3 (i. e. Board revision history) of document
UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
related to the board revision addressed by the patch:
- Board MB1166 revision A-09:
- LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK

This means that the MB1166-A09 is using an NT35510 panel controller,
unlike the previous versions which use an OTM8009A controller.
Therefore, let's add support for NT35510 panel handling to the
stm32f769-disco board configurations.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

---

Changes in v2:
- Replace board with configs in the commit title
- Add Reviewed-by tag of Patrice Chotard

 configs/stm32f769-disco_defconfig     | 2 ++
 configs/stm32f769-disco_spl_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/stm32f769-disco_defconfig b/configs/stm32f769-disco_defconfig
index 5be221afd2fa..e50d62e93bd6 100644
--- a/configs/stm32f769-disco_defconfig
+++ b/configs/stm32f769-disco_defconfig
@@ -52,12 +52,14 @@ CONFIG_DW_ALTDESCRIPTOR=y
 CONFIG_MII=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_STM32_QSPI=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_LOGO=y
 CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
 CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_DSI=y
diff --git a/configs/stm32f769-disco_spl_defconfig b/configs/stm32f769-disco_spl_defconfig
index 7d4bda440685..6229ee5089f5 100644
--- a/configs/stm32f769-disco_spl_defconfig
+++ b/configs/stm32f769-disco_spl_defconfig
@@ -75,6 +75,7 @@ CONFIG_MII=y
 # CONFIG_PINCTRL_FULL is not set
 CONFIG_SPL_PINCTRL=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_SPL_RAM=y
 CONFIG_SPECIFY_CONSOLE_INDEX=y
 CONFIG_SPI=y
@@ -84,6 +85,7 @@ CONFIG_SPL_TIMER=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_LOGO=y
 CONFIG_BACKLIGHT_GPIO=y
+CONFIG_VIDEO_LCD_NOVATEK_NT35510=y
 CONFIG_VIDEO_LCD_ORISETECH_OTM8009A=y
 CONFIG_VIDEO_STM32=y
 CONFIG_VIDEO_STM32_DSI=y
-- 
2.43.0

