Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD0CC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 19:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9002387CAB;
	Fri, 19 Jan 2024 20:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jCi/ozGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4AEF087D83; Fri, 19 Jan 2024 20:41:51 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D22E087BA2
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 20:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d48a8ed85bso2551125ad.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 11:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705693307; x=1706298107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a8v5wm7eXyzF+W3FvXnAaxiUuWeSuv5ubPtPr/EnT3o=;
 b=jCi/ozGjqUYljU9I9DsnSbxrHOG/C4fzZuC3cUrIC6Ghzg7l1sj30gcIGzSzM/4TJE
 oTfLhP2rxBBUJaD1ZrfRE3C0jI20hFNT2yJX95LURdBB4wNoLwtmIRJ7VKn3jGXOUdwx
 U/VPrl3/r2t1YX4EX/08LNeHJeYLmtoPEb3mpJy3bmJSIaUKiRxKeXoYnVDOV495QInn
 j+d7rVikDrOqA5ElKMXeTtvU0r7R5VTjeSLXxWo1bDTHqQzrHxm+1j64tq1IYNsihJZH
 nGdFO7IG+w6WWO91ScKJXBc5MzB7BORWsluxqGxLUp2ytcn/B5t0Lr17K3fXZYnvKKKO
 AyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705693307; x=1706298107;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a8v5wm7eXyzF+W3FvXnAaxiUuWeSuv5ubPtPr/EnT3o=;
 b=fj5WD7f3kTfLo52lck3u9iF3bkiW8UZi4kB9VKigf53kBExGfYpZVu9hkHk9kUwx/e
 BdLgexr4FzAEAORDNfBOXG+2l3a+qwo/MpWMMovayD8LU2mkomRGiqUumHMrvXre7v+q
 TLWBLJi24GWmmF5+Hu+ulXtciAfrKfV3C12DyYqZ+UmHYwrqnb7/6+mQuhfvubLKgLf3
 DAjUKOyQMTIrttQ57ZTzGs+3ToEGEGao4U1OA7l1xUhJPhogDLuS+F1/Ob9HmZ5/4I4V
 sGkDda/T8Y7ri6sGUufUPu68le2TEx2aRPjC1yYuWHTAJ+HGkVEinz1Lym8+pRMGG2dN
 ydXQ==
X-Gm-Message-State: AOJu0YwaEc6xvWxQ+iF4mS4pnvF9f5uiXH7yMxAov0lYCK4t7HxAHpKX
 0b0PIBweWA3M+ax18/r+Qs30u/IHbDSzAEXDIhpOaCfpvhfFvZMN
X-Google-Smtp-Source: AGHT+IF7Mr4AggeJpy1vEHh2DdqX4pVXr+cEqiR4gJI8SbY7Ojbzbca9GaNXeQnSjbxbALsm1bRrkA==
X-Received: by 2002:a17:902:db09:b0:1d5:dfd8:a92a with SMTP id
 m9-20020a170902db0900b001d5dfd8a92amr785640plx.1.1705693307108; 
 Fri, 19 Jan 2024 11:41:47 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a173:61bc:3362:89aa])
 by smtp.gmail.com with ESMTPSA id
 k13-20020a170902f28d00b001d70602f550sm3270636plc.27.2024.01.19.11.41.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 11:41:46 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] pico-dwarf/hobbit-imx6ul: Convert to CONFIG_DM_SERIAL
Date: Fri, 19 Jan 2024 16:41:34 -0300
Message-Id: <20240119194134.681075-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The conversion to CONFIG_DM_SERIAL is mandatory, so select
this option.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/pico-dwarf-imx6ul_defconfig  | 1 +
 configs/pico-hobbit-imx6ul_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/pico-dwarf-imx6ul_defconfig b/configs/pico-dwarf-imx6ul_defconfig
index 7ae37264612c..8b90285980f4 100644
--- a/configs/pico-dwarf-imx6ul_defconfig
+++ b/configs/pico-dwarf-imx6ul_defconfig
@@ -67,6 +67,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
diff --git a/configs/pico-hobbit-imx6ul_defconfig b/configs/pico-hobbit-imx6ul_defconfig
index fc5a54b4e5ed..e3aca6e82e16 100644
--- a/configs/pico-hobbit-imx6ul_defconfig
+++ b/configs/pico-hobbit-imx6ul_defconfig
@@ -70,6 +70,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
-- 
2.34.1

