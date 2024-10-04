Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6AECFA775
	for <u-boot@archiver.kernel.org>; Fri,  4 Oct 2024 12:55:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB67B8865D;
	Fri,  4 Oct 2024 14:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KQHNZKG3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0EA288606; Fri,  4 Oct 2024 14:54:59 +0200 (CEST)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5BBA8870D
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 14:54:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e0a950e2f2so1780428a91.2
 for <u-boot@lists.denx.de>; Fri, 04 Oct 2024 05:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728046496; x=1728651296; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KAA2PWPsDNc0IJpzlUA2SdAHHPOt4/nJr3Dt7VuLI3w=;
 b=KQHNZKG3wEMZLZY8Xo7ItFb6MS5q4S/2jZ6xoABWDRhY5/tdjWHhFGwC+c4MjTpIqY
 hMpJGeFVJ+7k3YPv46DUzY2qRjOowlDK2E884Zg6jGMQevKx+gQ4CbPsIZVVAv9RwqNf
 YLww0F8MCyuUmHa3ldl//MC7Ao0VXGSgIzCZKx+5WKoA1EIBjS+7kPgG06/zDv9TIvO7
 V9RUhWvVlQ1gZXe4Ok+nQRAV0R9s7StaBHYc9garCkoyDEFDH0dJ0S2N2CYidmyfO+7z
 DqdrXaXl+3H7+jlemotc2jwWy8TKbDeeIJcMzfGeS0ZBz/z12TBTsSaU1tAOgVIRvhcx
 TkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728046496; x=1728651296;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KAA2PWPsDNc0IJpzlUA2SdAHHPOt4/nJr3Dt7VuLI3w=;
 b=u7vbhCJDbsipuAO3SLq2OyLEe7QUAJaE/JDh3FfvUUnQIG4h/cGW6MjKXkJlUzIdw1
 abxncItMmpcHJ9f6Bcsr4hAQhzosVeeXJdrM0JlZ2mgTk/+HGwPi+9IcjcGVC4+77VaU
 WcRO6y/xrBZTinLgHUamW893fLdFtWvreAFsfBmLF0pR8Jj034OBiLxmRDNRNmn6JOCw
 wCwpv+lf+ru42Sq7ug/03LedOJ/Gt8d17IbECwI56ZBPPw3n8RL6i8SqsCVEyNU6apy8
 fm/8RVkJkAlbMy/dS4opvtgZfD96DCwN3tY0suWgkHgxTXBxzKq6aIoPpiCWQlO0pM7h
 ZHHw==
X-Gm-Message-State: AOJu0Yyo2QkGt+q/nZ2T/PtjOpwfTlpQoANH9UVihHThRL8zY5g7h6qC
 AMDOLKRIRBjkkrUJib6JrFv0gD8Uus//oonNHzHOSsbOjFLerg9UYLqA2g==
X-Google-Smtp-Source: AGHT+IHaWvHH8Mc1tbu8V+2XNiUjHq7VFI1LHfMYUzUV93jdTEKEptFxOoky/61quXZfTR+wa4gInA==
X-Received: by 2002:a17:90a:d181:b0:2d3:c8e5:e548 with SMTP id
 98e67ed59e1d1-2e1e622904fmr3575273a91.13.1728046496160; 
 Fri, 04 Oct 2024 05:54:56 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:1459:b2ba:617b:7ada])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beeca30c5sm23751375ad.88.2024.10.04.05.54.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 05:54:55 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH] lxr2: Add DA9063 watchdog support
Date: Fri,  4 Oct 2024 09:54:50 -0300
Message-Id: <20241004125450.1923873-1-festevam@gmail.com>
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

From: Fabio Estevam <festevam@denx.de>

The LXR2 board has a DA9063 that can provide watchdog functionality.

The DA9063 watchdog can cause a full POR reset, which is preferred
over the built-in i.MX6 watchdog.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/lxr2_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index 855366d42151..2659b1f14b7e 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -104,6 +104,8 @@ CONFIG_RGMII=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_PMIC=y
+CONFIG_DM_PMIC_DA9063=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
@@ -116,3 +118,4 @@ CONFIG_SYSRESET=y
 CONFIG_SYSRESET_WATCHDOG=y
 CONFIG_SYSRESET_WATCHDOG_AUTO=y
 CONFIG_IMX_THERMAL=y
+CONFIG_WDT_DA9063=y
-- 
2.34.1

