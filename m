Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F7FC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 17:05:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B7B084A29;
	Mon, 29 Jun 2026 19:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j3SFg/XZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75E2B84A36; Mon, 29 Jun 2026 19:05:31 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EAFF84A27
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 19:05:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andreas.zdziarstek@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so31392975e9.2
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782752729; x=1783357529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0/jWltThE5k4RgeXn0ijxKSCU6PUaYmjRempnw29Y4w=;
 b=j3SFg/XZ2SRezV+WNV2b9zvS9mtCoM5lMr5oPagw4xhDkC2g/H4pyHwTghx7UfxN/m
 Bm3XkR0QXXiqNJP58VwDyJXxTPduvqn9hOrwKuCfsvj11Qmhu6vJ98P9PgwOvDHzvndw
 1HTvSUsHrEjfYOR0GIcta/FIq07vY2AiF/zjAOc/AA2y+sahFjaulhKi8diI2gTqLhXb
 Y+ObdGENxb3Bx8Gje9LG3ePJvPBoey70LFE2c8E9Kf5vRnCyq6iItc1r4w9LF9VaLJge
 mJhf0h49qQqVKFszWBMGmfhkpu/CGJRQn0UCElhhS22x5k6r2ZOFo85aD3M910U2F1SK
 td3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782752729; x=1783357529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0/jWltThE5k4RgeXn0ijxKSCU6PUaYmjRempnw29Y4w=;
 b=Wk3z3epl2tajBCCYLO+gdv9BYzwLFODdF8RwzfnDxs4Fr7k9xQBE2Buhe+VLusgLKf
 3hK8OPHKjOxAS2cZZ9Kz5VpswbsmdjCdBVa8vHIqEYEs5Xie32C6GZoGyuW9hqc07R+F
 822dqCTKb3khZ03WezTfiual/loLIz+U0rfGzrx5KyguIrxBICCFnlNW5Ur1PqYJpegU
 2ObgDdW10+6xGi3gcQY/uwhKwrBBbMDOBf5gA5NB1spXDN9qJkr1Uf+ljio93PI2IyZT
 Tjhy06gD+RxenHEhZzUlNC2/UutJTr7ed3+Pm6K0khF/cj5vJFpBLzw+qBZuPhExfZ/E
 3R/Q==
X-Gm-Message-State: AOJu0YzqLRVWY6deJE/ilsHmRD2QEDsMRpTi+/HAfC4i9HFHjS+C8ugL
 Gk/WE6NLC99/TkZuV+1LiCfDaFFBqIOafn77AqvSYG8wimGBdSq0UCGC/JGWeWYG
X-Gm-Gg: AfdE7ckOVzizfrlrhiTdwfaxTsxVtej5wTSMVXG9MnmekSDjNiUqjOWt0xJSzcSdoos
 bmCLd/lXHNHLKls+7WnHFNya016oVBZ9r+2xbzS8q810fVl3eDllj30zEERRvnc3+L12hAwQbaz
 XJNNDZO8PIqPYNSCU2gZdV9xLHhMi1KsOYC38vxTRQpxJudpLtOb/Kf7ZtWrRTovpk0bfKhqMux
 d4mFWnbpwDQMZtf4oiVXBbqYlEhZsrtXSlZ442yU3svaQHTnPWbz1maFvq8sqcK86pBLjMuQ1hK
 qq5+QV0HsNfarnj0XAfDopMtKPXMXDTaljp3U82thcJOI3T9D27z4mIvWBBJxXPBE+igLojiJj2
 R39L2OZtu4GjoAqGtmqxBEft6XEOXRQntwjy4c1E39ZcqbxohJ76HbCHrYL03XLtpJ9JYh2kdKq
 e6m/u5xGke2QcEe9lj/odH1wGIjElfe47LeHv3GiPcTxYlRfEfqyU6eYOOmuMSFeuJEA7V9Uv/8
 w==
X-Received: by 2002:a05:600c:a413:b0:493:b4cf:d37f with SMTP id
 5b1f17b1804b1-493b82880camr8113155e9.16.1782752728398; 
 Mon, 29 Jun 2026 10:05:28 -0700 (PDT)
Received: from turbine.fritz.box (p5784ea85.dip0.t-ipconnect.de.
 [87.132.234.133]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46cf775a4f0sm41791121f8f.17.2026.06.29.10.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:05:27 -0700 (PDT)
From: Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, jonas@kwiboo.se, quentin.schulz@cherry.de,
 Andreas Zdziarstek <andreas.zdziarstek@gmail.com>
Subject: [PATCH v2 3/3] rockchip: odroid-m1s: enable watchdog support
Date: Mon, 29 Jun 2026 19:05:17 +0200
Message-ID: <20260629170517.1436613-4-andreas.zdziarstek@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
References: <20260629170517.1436613-1-andreas.zdziarstek@gmail.com>
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

