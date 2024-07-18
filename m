Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 649E4C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:37:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1AFC388B4F;
	Thu, 18 Jul 2024 19:36:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UizgYk6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8791488B3B; Thu, 18 Jul 2024 19:36:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B371988B23
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4266ea6a488so6001245e9.1
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324199; x=1721928999; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RkHCTDl52U697puwVM55SCiXNevFrYwycV6yhhmASLs=;
 b=UizgYk6czyNERwQwaO2Xp+QAWKII1XNTjcJEvRyWupMPaI3mngLGlEWCO3t50pFsNI
 /y0Hb6oUk3ereq38RkT9SFyDpPUkEQUxDyjJdh/xkjeDpSJB5vSV5W34zxXSZr6w+f2J
 6dqO9iCxducq9lCb4YDLV3h1vrN8m6O1QcLdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324199; x=1721928999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RkHCTDl52U697puwVM55SCiXNevFrYwycV6yhhmASLs=;
 b=p1kabKbYyCoOY9HcK8rBReD30Bbflm3+fueHabTBixJ90YVGXBE7wtJ43IVn7/8MV+
 LLlQjtvt3ox1AwD5i2NVBZQDZZAEwpOyDQAt5z4r27WBlq3WNATa5QqeDccCTBAyAOL6
 4r+EJPsYZ/HipHjQ8u0b6r+PiQzHLz+xN6GUxQf/TFCuYEq4ZAjJa277ec3gAW1Z+BEx
 uwVJoAeDuh94zCqAMnzkMbnhPB3RZM4Aid7f0xAmXQk53GXOEM6CziXDCNpZ8BAuLJl6
 KoUVaHBOsfj7K1f/gXupHFUtBaTtTOL29mukQCO7Fb6ASODE0u7Qvn2xsHk/iA0GVnfr
 P3yg==
X-Gm-Message-State: AOJu0Yz1qfd23h/KbTTxY+HD/YXIN3bE/vkovruKfIoSBJaSiMHfwDPI
 8N0vEXKhNnxNeqjHaXUA7x6LdvBo+DMUVc8ZEQpTrWu6sTe+vhyFl0whWyyyGSaM6RC/R8Po8jI
 =
X-Google-Smtp-Source: AGHT+IEtwQLxsp8hXbnNkUIJ+bJ0n0BSlezRVLryTYoXlAxRMaw+PbQ2hAV90NDR/i8OET3lYIoV8A==
X-Received: by 2002:a05:600c:3105:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-427c2d02027mr48717505e9.28.1721324199035; 
 Thu, 18 Jul 2024 10:36:39 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Paul Burton <paul.burton@mips.com>
Subject: [PATCH 05/20] mips: malta: Drop CMD_DATE
Date: Thu, 18 Jul 2024 18:35:56 +0100
Message-Id: <20240718173611.4014274-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

These boards use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/malta64_defconfig   | 1 -
 configs/malta64el_defconfig | 1 -
 configs/malta_defconfig     | 1 -
 configs/maltael_defconfig   | 1 -
 4 files changed, 4 deletions(-)

diff --git a/configs/malta64_defconfig b/configs/malta64_defconfig
index ff371daaa0d..8ac29b9289f 100644
--- a/configs/malta64_defconfig
+++ b/configs/malta64_defconfig
@@ -27,7 +27,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/malta64el_defconfig b/configs/malta64el_defconfig
index 5b130bcde9b..0a71013d5fc 100644
--- a/configs/malta64el_defconfig
+++ b/configs/malta64el_defconfig
@@ -29,7 +29,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/malta_defconfig b/configs/malta_defconfig
index ce917a69de5..355292ef950 100644
--- a/configs/malta_defconfig
+++ b/configs/malta_defconfig
@@ -26,7 +26,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
diff --git a/configs/maltael_defconfig b/configs/maltael_defconfig
index de29a7a3a5b..ffd27713963 100644
--- a/configs/maltael_defconfig
+++ b/configs/maltael_defconfig
@@ -28,7 +28,6 @@ CONFIG_CMD_PCI=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_ENV_IS_IN_FLASH=y
 CONFIG_SYS_IDE_MAXBUS=1
-- 
2.34.1

