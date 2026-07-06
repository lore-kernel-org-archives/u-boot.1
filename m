Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB113C43458
	for <u-boot@archiver.kernel.org>; Mon,  6 Jul 2026 13:33:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14EEC846FD;
	Mon,  6 Jul 2026 15:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Ww1WaEEe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB76984852; Mon,  6 Jul 2026 15:33:48 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3012846B4
 for <u-boot@lists.denx.de>; Mon,  6 Jul 2026 15:33:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ccaione@baylibre.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493b61b52b6so21003665e9.1
 for <u-boot@lists.denx.de>; Mon, 06 Jul 2026 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783344826; x=1783949626; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SBcbi5GnqQ3NDGSNJQ1FHOtqtyyjqLfFURgE/+q65pU=;
 b=Ww1WaEEeOliJtEfilJV/GIsiN7uN6jNfMXYvXElqgNwbdQeD5En+5ebMp8sRpv5KjY
 HbvmtOy2wILSFAPlHmVjiKJHbJa8pXnthvt2tq+Vj1bOY62SFBvCStvsW7dIWebJmejk
 WDooMtq0L6qRlRDeU+cQOZ9uQqXO5A4GxxSH4T5NqbwdRjhpnolf+AcLPWTeTqFreB3p
 bAF0jlkqiMYkfzRr1wWJ4nMQPpmqDtA/3DplEcAbFfKJhOGxVLOR8gH7oyoBTyhTi9H8
 LYKEeUE/xPq8ca/HNRmmI4DRz6kExBr3dNVqp73UIEHp4fm0qQADufCHVAcTWqH3BKXv
 a2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783344826; x=1783949626;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SBcbi5GnqQ3NDGSNJQ1FHOtqtyyjqLfFURgE/+q65pU=;
 b=fwTfrQErMirM2iNn8QbJrNfYpEBYx4a4A7rll2Rs7b3jcFPzNrH/MU2w72f8CXn39J
 96EpMmx8XCmcwGxFiTJoc4ay/uk550dJBmTy5Mzz/QnfZyVV/pg5Wnf0GJnNPnELn/hN
 h9ly1VhY4vimD8xaTclU1Iytb6EP5OYpWUUPRVEceH/6ze++W8obFRLlSGd3Wb/ShW15
 NpJUCSFdYFgaU9Ch0oJ7M+moTtQsD8sw0rKuwGHL4f7CfJRVy1Ppic9KVEBkWEzNrnDZ
 10C/ktFsn5ef1GesmUbv93WpRau+NTC4OVJivdcQNOY3wbOkX8mttvXcxiru4xqCoC96
 pnAQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqy+5zOh44DcZ8Pro8V/jzboXyXEMd6KZuGPV0y68L4goV9XhyLSpBLTA8yfo+07aFaijsvvP4=@lists.denx.de
X-Gm-Message-State: AOJu0YzV+RvPnWPjK8HWA7u5BDvjj55SRE/wCIKDLbKAm7ApXelZhZmu
 BBQY/BmjW/cK3k+VyA9bjh0sRvJppKu4aOxU8WYZlYi/Toq8ikf1+vLWgBOLbDS6udE=
X-Gm-Gg: AfdE7cniPdCbpEBAufwlvo3PUDvPV+Xr+7etnKmfljSHV7h04hNuBpTyh9ccmxCiqCU
 rUg5XBVAnC0DLSKQMGrIf3vHrKV8HxOdalrNbQQ5aTStAlIzPbe5Zo8gzSZCrCqiQsn1vy+pDg6
 t9oPcZr1hflrpeee37zkyjNcxZJkmPjrAd4YKAdahhgLudGB1aum5FOeURcncG6PTwsfRxnSP7B
 k4HfIry9Kj7ybBZYGiJ6K4Fm6cankOAzOMYTUYJml5KKl89qXgFnNSeUr0xhdf5ojx0iicnJiRl
 C8AhWEe8fdPOcpsl3ecpwMBjtjYSMGLhT9L29S4M/YgXxKK71v5Lyf+TPV1QPGRMKyuX2HkSOqf
 V68jqpzrr9vggRgMirZr81n0Cprcf6atr5AAB0rf9OLtibmJD/FXpWyWunGlvv5rnZtP6yGHNql
 W4wnbBbDJ+976hJs2PFsTD0C1FDGc+fZvZRCs8jyJh9TMQwBwENHRNH0mq
X-Received: by 2002:a05:600c:474a:b0:493:c062:a533 with SMTP id
 5b1f17b1804b1-493df0673f8mr6512645e9.17.1783344825964; 
 Mon, 06 Jul 2026 06:33:45 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it ([95.236.170.123])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef11338sm390544345e9.1.2026.07.06.06.33.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jul 2026 06:33:45 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
To: Macpaul.Lin@mediatek.com, jstephan@baylibre.com, trini@konsulko.com,
 jmasson@baylibre.com, dlechner@baylibre.com, u-boot@lists.denx.de
Cc: Carlo Caione <ccaione@baylibre.com>
Subject: [PATCH] configs: mediatek: do not autostart the watchdog on the Genio
 EVKs
Date: Mon,  6 Jul 2026 15:24:59 +0200
Message-ID: <20260706133322.68010-1-ccaione@baylibre.com>
X-Mailer: git-send-email 2.55.0
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

U-Boot autostarts the SoC watchdog (CONFIG_WATCHDOG_AUTOSTART default
y) and services it from its main loop, but nothing services it after
ExitBootServices()/bootm: an EFI-booted OS that does not take over the
watchdog in time is reset mid-boot at a wall-clock-dependent point.

The MediaTek toprgu can count at most ~16 seconds, once firmware stops
servicing it at the handoff, the OS has whatever is left of those 16
seconds.

On the Genio 700 EVK the generic Ubuntu 26.04 arm64 image is hard-reset
before its first boot reaches the login prompt: the mtk-wdt driver is
a module loaded from the rootfs and cannot win that race. Nothing tells
a generic OS that the watchdog is armed, so the failure is silent and,
from the user's side, indistinguishable from broken firmware.

Disable WATCHDOG_AUTOSTART for the Genio EVK boards (mt8365_evk
directly, mt8188.config for the Genio 510/700).

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 configs/mt8188.config        | 1 +
 configs/mt8365_evk_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/mt8188.config b/configs/mt8188.config
index 9dfba6bf99f..26823cf35d2 100644
--- a/configs/mt8188.config
+++ b/configs/mt8188.config
@@ -20,6 +20,7 @@ CONFIG_PINCTRL_MT8188=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
 # CONFIG_RANDOM_UUID is not set
diff --git a/configs/mt8365_evk_defconfig b/configs/mt8365_evk_defconfig
index 1a385492547..6620f540fd4 100644
--- a/configs/mt8365_evk_defconfig
+++ b/configs/mt8365_evk_defconfig
@@ -29,5 +29,6 @@ CONFIG_DM_REGULATOR_MT6357=y
 CONFIG_BAUDRATE=921600
 CONFIG_DM_SERIAL=y
 CONFIG_MTK_SERIAL=y
+# CONFIG_WATCHDOG_AUTOSTART is not set
 CONFIG_WDT=y
 CONFIG_WDT_MTK=y
-- 
2.55.0

