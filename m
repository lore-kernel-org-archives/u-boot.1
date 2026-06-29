Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3F0C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 18:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D42184A8D;
	Mon, 29 Jun 2026 20:20:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bZhFA9zC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DA4384A7D; Mon, 29 Jun 2026 20:20:48 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5319584A6B
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 20:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so27255755e9.0
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782757246; x=1783362046; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/jWltThE5k4RgeXn0ijxKSCU6PUaYmjRempnw29Y4w=;
 b=bZhFA9zC4jRHDiE01F4gN7EK3rzKIgBMcTDRT4qdhsp7YpVxP1w//cVNjeiuU0CSY/
 6ASxBMpEJaptSudF3hXMtBNgGdl2lxfYtjUt6qAZdLkcvVxn0oRDeBram4UaNlNkkmBg
 v5rVWW37SjU5LdxF8djFsveE5ESCAZSMP8vNmw4ADTFw0D8R3jU47F0ur7mbUqGYY3LH
 l654PxyNTJjnlZPKZ94oE9gdxa6B6P5bPKZ0Xv7uuC54QdQ5f86kW7ZaGuVwPPaUGRCa
 qRfMu9sQrgaSPq9xx4d5EFuiH0Hx4cCGZy2yQLrlxlx9u0j5wh2cVbidmD6xv0RhLwEO
 eQMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782757246; x=1783362046;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/jWltThE5k4RgeXn0ijxKSCU6PUaYmjRempnw29Y4w=;
 b=fqKJlt2SvLq8L/pgm7dABfS1kisntu5miRaWHJTjgA+ZtQg2N+aKvtqMKbmg+logug
 WJXH53SWoFX3XGbArFhfIe7KjAAgMz0BbVXYOqI4KRUGDG/PbGCzsehRtVvKcjhb2Oha
 eK5DzyHfPD5rAgwxy1p68y7GMkqrdrmUJIWVyTsGC2rXjpukQZLX0l/r/eLtRj8CJJut
 hWyotYzGTbofNww0oy9Z2MezXqcHB0DH5dv4zTQK4pKl8vORCoeIetRgT9ScRI7JSKrP
 AijMB/bFWRlk3bXMAfrJ7iiuPzamw2XeYD1vJ31MTNCImLE5rxDKFtcv3aIIVHCqalaY
 nI2g==
X-Gm-Message-State: AOJu0YwbEBYsCIw9hcbIN8kpFIjh4mzONaKc4rKyftU7BZGGdrbiqfe0
 cCR9FWo6sZVeLDmqKwJMAexGJawoNQR2K8Fw0oie/2XJQFOux4Nyr3nOCCmdJBU5
X-Gm-Gg: AfdE7cnEyCXWE7Fby42FTOLLBMn06/e+GHYLnAej9yYvT1h7fDrnS1DoMXZkJWtbz56
 f85DdYZMkttCP+o6ell+9R8xs9EHJoFg2P01AU6OMtYKV4f0h+Ou9tsV2uICOBg2/LCIgHqnWPZ
 SAifjhAjMvyQ5Te0TYxxGPsggKr3SAXZVQc7323jNbmqp4SNajwIVK4vschlGkXpQp7VxTRo+TB
 Ph2NmRp+zveLNJOgxmljMw/R/OaLxk3Hb6kcxEeynppYecOPyqCGGO40bhnWuxa/a1ZG8M5yEfZ
 rL+/b/yLdFtcAF5EYv7SHj7EoW+QmxMj13n74Jk74rgd9AUIZy4KswfkyAUVcSUDZfAEBAOchPQ
 2ZqbD8C9uFfzSrQInEx/h+kjEG35vsCmMSx7JZTlNd75NJN19OHuxfgF0lySpI4mFi1j1UyziZV
 CiAdsgEoz8PTQlP8idsNCZ97yWbdtIyUX/D9ldTcyX7Ugcrt3u7ux/0Xz/cavlcAE=
X-Received: by 2002:a05:600c:4e08:b0:490:d32b:39d6 with SMTP id
 5b1f17b1804b1-493b82ad241mr10797395e9.19.1782757245713; 
 Mon, 29 Jun 2026 11:20:45 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926c2954efsm219567015e9.2.2026.06.29.11.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 11:20:45 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v3 3/3] rockchip: odroid-m1s: enable watchdog support
Date: Mon, 29 Jun 2026 20:20:12 +0200
Message-ID: <20260629182012.1508336-4-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
References: <20260629182012.1508336-1-andreas.zdziarstek@gmail.com>
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

The rk3566 ODROID-M1S has a DesignWare watchdog. Enable CONFIG_WDT,
CONFIG_DESIGNWARE_WATCHDOG and CONFIG_CMD_WDT so it can be driven via
the wdt command.

CONFIG_WATCHDOG and CONFIG_WATCHDOG_AUTOSTART are left explicitly unset
to not cause any breaking changes on existing systems.

Signed-off-by: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 configs/odroid-m1s-rk3566_defconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/configs/odroid-m1s-rk3566_defconfig b/configs/odroid-m1s-rk3566_defconfig
index d59882a2a59..943c0509e9e 100644
--- a/configs/odroid-m1s-rk3566_defconfig
+++ b/configs/odroid-m1s-rk3566_defconfig
@@ -30,6 +30,7 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_INI=y
 CONFIG_CMD_PMIC=y
@@ -87,5 +88,9 @@ CONFIG_USB_DWC3_GENERIC=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_ROCKUSB=y
+# CONFIG_WATCHDOG is not set
+# CONFIG_WATCHDOG_AUTOSTART is not set
+CONFIG_DESIGNWARE_WATCHDOG=y
+CONFIG_WDT=y
 CONFIG_FS_CRAMFS=y
 CONFIG_ERRNO_STR=y
-- 
2.53.0

