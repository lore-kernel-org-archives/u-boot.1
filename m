Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA8FC4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 11:44:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5941187061;
	Tue, 13 Feb 2024 12:44:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZ52/Bz1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF6C987D55; Tue, 13 Feb 2024 12:44:07 +0100 (CET)
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com
 [IPv6:2607:f8b0:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB34987D5A
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 12:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-58962bf3f89so1686060a12.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 03:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707824637; x=1708429437; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hC7jWWCMAwtBrnELSMVwegGqQ+Uro7tkHnfDnqFHKFo=;
 b=GZ52/Bz19Z9I+iB1lDrXU3yscnvu2/EsNLZ1DiOmjBN3NwmAglQAydhHOzuJ3dP4KQ
 ISQrFd6bFrk23HqyXjRJG+wOVHZU3iUVHg1hQYaeUyuzO5FcfItS8ARXQqlR2FRZO5y9
 9+tfhVfiuD5aPyH/OskFmK7i46x5CqmsXOdxjkgl3kap8TTGJIhvNYM7qqLZWmarzynC
 GK6lc/X7Ze3cgGivrJYpONSsvAqz9kguq8ebc1clC08W9aEwT6sLsLRG3yeg58iSwYuE
 yorL0AqDTWC8XKaHh+8lDtyw1q/BeuTZHYxm4gIB9bVcawX3kMxb4DnKgEE7No30/fSj
 5HSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707824637; x=1708429437;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hC7jWWCMAwtBrnELSMVwegGqQ+Uro7tkHnfDnqFHKFo=;
 b=ixE6K1Cgh4Ofd7AvVOcMSKIW7ZuRt2ctue4I7gzs7U2FrO9nm3fBL9LfwxGg4U0uDy
 7qsqyIWzffRg1Gvl8LkUIy28v9eVjgbtarw93LYsTG6tpLMRWDNsMW5Ppb8iqKkQ0KHO
 y6bVjKoCtVxqfTBznxDzupHNN9wKd9udkcX2yUwasMr+JDWwh8sPfNnNqba+L1//zJRg
 KN5Asg1QA8ZnYnju6XA3LupuT7bNtNx2eoWE1fT3WIEZwTL84M3SghPVDi5BkI/Djxd+
 fw+ansM39lySCI5WzbCBkDqbLf9luZEMBc3YenO/a8Ul7R5E5a9BOF8gyoDCHwUdJtVd
 /xlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUpjOY3oMiEJ5nLTanIPc22WXzVophp+C0O345T16w4eJqijTSBDfxDmieP9Wgv017qwlZQ7AEEDEEjTXGzB2r//8+8ZQ==
X-Gm-Message-State: AOJu0Yw2kqy4qM0YqB1X5RyTKTe1PcbTbJOnPp7SZCNiW7Uxww9jKxHd
 zaDP9LfDeyFZSwDLBoZr6XWtfeXppOGZyOokqWo2MkqbVYm3WXlqQi6LnOAZ
X-Google-Smtp-Source: AGHT+IHXPOCgXrTmPloG13JzmzntA2HdwW6/mOJKvctj/NwFgoR3Bb20/58fPDGFzjcoq0peBVK8Gg==
X-Received: by 2002:a17:902:d488:b0:1da:2af1:a8c5 with SMTP id
 c8-20020a170902d48800b001da2af1a8c5mr5547243plg.4.1707824637025; 
 Tue, 13 Feb 2024 03:43:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVcuT9A4EhLcpoVxcIY3G/D3AOqdC0pld/4770cCxMZaj2KvaVq93VGrSsvKPQk/VoBEB2m7vIiZEWkXzzm6ctGwHn7B+1tA/4T3iqjHldIuJolZ50yA2bNwVB20zFvkuBI02z0bW9uFRSUG1vKfvjlMAU=
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:c0bb:2b3:6958:833])
 by smtp.gmail.com with ESMTPSA id
 k5-20020a170902f28500b001d8f0e4bc32sm350795plc.144.2024.02.13.03.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 03:43:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: ian.ray@ge.com, martyn.welch@collabora.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH 4/5] msc_sm2s_imx8mp: Add redundant environment support
Date: Tue, 13 Feb 2024 08:43:41 -0300
Message-Id: <20240213114342.2728075-4-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240213114342.2728075-1-festevam@gmail.com>
References: <20240213114342.2728075-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

Redundant environment support is required for software updates.

Add support for it.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/msc_sm2s_imx8mp_defconfig | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/configs/msc_sm2s_imx8mp_defconfig b/configs/msc_sm2s_imx8mp_defconfig
index a190c1ea22..3a49b7d55c 100644
--- a/configs/msc_sm2s_imx8mp_defconfig
+++ b/configs/msc_sm2s_imx8mp_defconfig
@@ -5,7 +5,8 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
-CONFIG_ENV_SIZE=0x1000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x200000
 CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-msc-sm2s"
 CONFIG_SPL_TEXT_BASE=0x920000
@@ -16,6 +17,7 @@ CONFIG_SPL_SERIAL=y
 CONFIG_SPL_DRIVERS_MISC=y
 CONFIG_SPL_STACK=0x960000
 CONFIG_SPL=y
+CONFIG_ENV_OFFSET_REDUND=0x204000
 CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x48000000
 CONFIG_SYS_LOAD_ADDR=0x40480000
 CONFIG_SYS_BOOT_GET_CMDLINE=y
@@ -62,6 +64,8 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_USE_ETHPRIME=y
-- 
2.34.1

