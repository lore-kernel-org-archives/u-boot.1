Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D1ECD98F6
	for <u-boot@archiver.kernel.org>; Fri, 19 Jun 2026 23:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 457F8849BF;
	Sat, 20 Jun 2026 01:29:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OqKQdTn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28A0D8499C; Sat, 20 Jun 2026 00:09:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6AC848EB
 for <u-boot@lists.denx.de>; Sat, 20 Jun 2026 00:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so16941245e9.0
 for <u-boot@lists.denx.de>; Fri, 19 Jun 2026 15:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781906957; x=1782511757; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KARAjUmafuApvk8Ed09KBP3ey+Ow5u+nuHw7Vo6fj08=;
 b=OqKQdTn3cjl+v6VcQrT8hGRe2kcwKCv5LThCbduepDNLEkm0NAXzlyFuww2TIAihWz
 HxoaIbxFGRzTST/iMT3YS2uGgDHYgc3Ua5qvC+Tdrtgmp2o/MycOYeOfRWcMGWkplF2O
 +SaAUJa7ERD0nBP7pRIE6g6qE+J5Xlbu3+ZLA62+AUxvqg06rb1g2RMUf5C9M61jcKfp
 wBbMswjlCzquI4MGtMJ1BqBbRf45SRAwJc1wCyCxkVn0YKqkPHm3hqtQC0MGvxzlEnZv
 K5Rb8Lc8e08n8d22MSMS3Ey1HxALoPiBfhQIE7adJ5c8T4QbAer1W2M4Sl5FrpCsxBGV
 uMKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781906957; x=1782511757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KARAjUmafuApvk8Ed09KBP3ey+Ow5u+nuHw7Vo6fj08=;
 b=JSLRQfc+uPqpObDvYjSGMQltZ1d5qDGMozCUnJ4DcCSH3I2ZJIWBCLUf4bDAebP3HR
 dXoxhRTorr7WJ2XS7nLOFeBtyYLKouOWE+ggMjKeLB581nT48eLDgPSEjEVLzVOLMFYU
 KICB15z9CJ/NoifIkuftUj19MO/HGdnDu1slat38XYOraFqdkmAY4SpmQE+C2m46Id1I
 Sedfk4iaPRalEaj8qAZpMwsUsr28Fq5Cu21aoxIDaiyjOZu9wjSIVZ0po4IcaaF4w4wT
 Ir82io8ZGmkxPARYF9TYOucdK9lpI12VLX19i3lT4VsuRq1UNH7GtbeD+VVckKBEr9x4
 QzYg==
X-Gm-Message-State: AOJu0YzAOC2r89XwfeCF3aZeBNnEeD/iAq2MsL9wEoQWEm4B3T2+X8EG
 pmYFGA9gQH92ztl6tGgbSsbpBtwoRXs33gZEVRyHLqcwyxXPAELM4S7x3yCF6kPl
X-Gm-Gg: AfdE7clfn5VANyNC4jcFF4076xIRiV3Oz2nYlVQsInwV59hQJRoMmuWh17zmEADHyF0
 HjFlj8D7Dof6dWVMiH8W4TZ3XGdBK6o4+5vBPgNooqBjCPpAEMjyxjyv514t1Kw1xoJNCnL0ksy
 0cUZxKCW1Jn3TI6wPXli0IroP1rHo+W3pC/OPmAeF2VJ42JZhEv2e19tj9ZGLzbOVm+9ZYVy2TX
 xd1WDzKACxTUmQF5GIVXC9CP1zFCOQZAhw116bWWQ6ZKj6kFLSJmKyF9rWtQu2VC3YCNrh5PGT9
 pdymJcEqTG2CmclUhNoaspGBxzhqsSRYD8VjZhczio7YygjroHY/qjqS6dhoXsY+ckTR2DHvjia
 BpUO2Iai2r/W1YSqOcqxwgi+9RN5AuWTP9N9xXvee88fQ3Xo+VFJu35CFwiqdvo31tGLN1JDqek
 xijkb1Bq0/RtSxNWm43Omt1Bmgkv4QArfavoMFbWohFkY7ix4toiv6aSXfvzMGe+Y=
X-Received: by 2002:a05:600c:8b38:b0:492:40df:d49c with SMTP id
 5b1f17b1804b1-492490a7783mr14283305e9.23.1781906956648; 
 Fri, 19 Jun 2026 15:09:16 -0700 (PDT)
Received: from turbine.fritz.box (p578499fa.dip0.t-ipconnect.de.
 [87.132.153.250]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-466643f4d9csm2176698f8f.4.2026.06.19.15.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 15:09:15 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH 2/2] rockchip: odroid-m1s: enable watchdog support
Date: Sat, 20 Jun 2026 00:08:20 +0200
Message-ID: <20260619220820.301787-3-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
References: <20260619220820.301787-1-andreas.zdziarstek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Jun 2026 01:29:08 +0200
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

