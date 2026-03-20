Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F021F1099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AC9984088;
	Fri, 20 Mar 2026 21:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jdtqT2gh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 920868394E; Fri, 20 Mar 2026 21:53:39 +0100 (CET)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3657983FFF
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-67bac077116so364876eaf.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040016; x=1774644816; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9eNxSi1oZaYIn0l5y4FIjirlf3yMQBpnRKNMiVXe60=;
 b=jdtqT2ghWeng5YDtHDxBwU4KKVYhy2tflOHeMEAs2WzRZ/uqwsfskHcTP4KCzgnYd5
 e9Fw+7blxiT3LpTBrk36bzYMPZmcdcJEw9y+dw9dr6LWKksy/CoBDebZmt3vEhceifi9
 azPci67YE/3J4+iG0h6mjvzLfiszzoioNxJ98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040016; x=1774644816;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9eNxSi1oZaYIn0l5y4FIjirlf3yMQBpnRKNMiVXe60=;
 b=jyJ3XkqfI1+HviEZ3NB9r+3mnkkFISZEcr8rxlvam880eXKBYYUJJ0N4p4heTNEqYo
 ewJfSzHED1Muj6E5vaXsRofGpBd6DpWwZy574o5mdEgzk7HsM0jpaDAZ54h0hKkU1Ams
 jGM2jqmEkUzImarmzmLe92D4Y6jFXXhCoFs6A9QzroJjQ45t81k9eKGccpfm6pKlNqFU
 dAVbUyH8gTz+g3AgXbTAch2tfclbBSEcp5XieWF6c/CTRwyE33sr9KwP/LW3CZubOtad
 AJEzjgc4oVAC2dp3Q3h4FBF70Do5a84+kz4uUi4kaX+SWNVjtEEvZRs9cwiKp1/sBaIW
 rbRA==
X-Gm-Message-State: AOJu0Yy2RaBdBRN1PK53wnPOWhvyPS41yqcd+zt8GdFfXHxYU7DFs/HA
 Cn+EfP1OaXIPVVlxicu+d4zvGUTnbOQu59K7CuKpcQUQhtgZHcnOuZ4G/ORdnajTRGj3yRe0//3
 Lzrr4XV8=
X-Gm-Gg: ATEYQzy7KFrR3laoCEvwK8pesNcY9i5YGy4BkSoi2jhA0ysQc+llTei8Q4HeuQUf216
 tBDAELmrR+0X4F4uoY5tzxXS50bI+VYfHGLnffsNXFMcPDl+Basm0sV0dkQPcWwQgdy0XBC5eBg
 3pR1zKMvByUcG3Wu/ONBQazr5+dj6ed79rIaxzE79zuUtV+C9Zbo8gumWaz4aNk4J4KqmWv9B3U
 ytRD2DEJDKQNP7HdZbum5BkuR8uJkl+wZ7inKMMXmT4rVu7mCFLGYeS0jP1SXw9Plb3ltZbIk/m
 ufhE69/OSca8iiTBommRNDDIdh1eQebuDNwGAgdm5sYFxzcgB41XNePNYO7eGxL679GCfShDJMw
 8MYoDzpVInRZvGSZhIbP1GqpsYxVa3c/X6mIq/ldEkNd3VsUZubTYxQMo25vLxf7/5hzC4aF/vB
 hxF8iP6WQ+bhQyHyIw4evau+QG1VHg1iABNZ999xXzx5W0STLaqdXGx7+FTA9I+kOIyyXLcU6W7
 A02mWUud9jDPxjWeQYYJis0g7wjsEl1bdF7rou40z7K4zA/9Gg=
X-Received: by 2002:a05:6820:998:b0:67b:bc25:267e with SMTP id
 006d021491bc7-67c22ed154emr2865451eaf.30.1774040015744; 
 Fri, 20 Mar 2026 13:53:35 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c253fceddsm1881215eaf.15.2026.03.20.13.53.35
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:35 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] rtc: Update Kconfig dependencies
Date: Fri, 20 Mar 2026 14:53:34 -0600
Message-ID: <20260320205334.3788743-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Update the dependencies for RTC drivers which did not express a
requirement on DM_RTC, or in some cases on DM_RTC being disabled. In a
few cases, when DM_RTC is disabled we also require DM_I2C to also be
disabled or for POWER_LEGACY to be enabled.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/rtc/Kconfig | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 648948cc735e..65d9bf533cb1 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -84,7 +84,7 @@ config RTC_DS1337_NOOSC
 
 config RTC_DS1374
 	bool "Enable DS1374 driver"
-	depends on !DM_RTC
+	depends on !DM_RTC && !DM_I2C
 	help
 	  Support for Dallas Semiconductor (now Maxim) DS1374 and compatible
 	  Real Time Clock devices.
@@ -166,12 +166,14 @@ config RTC_PCF85063
 
 config RTC_PCF8563
 	bool "Philips PCF8563"
+	depends on DM_RTC
 	help
 	  If you say yes here you get support for the Philips PCF8563 RTC
 	  and compatible chips.
 
 config RTC_PT7C4338
 	bool "Enable Pericom Technology PT7C4338 RTC driver"
+	depends on DM_RTC
 
 config RTC_RV3028
 	bool "Enable RV3028 driver"
@@ -235,13 +237,14 @@ config RTC_MV
 
 config RTC_S35392A
 	bool "Enable S35392A driver"
+	depends on DM_RTC
 	select BITREVERSE
 	help
 	  Enable s35392a driver which provides rtc get and set function.
 
 config RTC_MC13XXX
 	bool "Enable MC13XXX RTC driver"
-	depends on !DM_RTC
+	depends on !DM_RTC && POWER_LEGACY
 
 config RTC_MC146818
 	bool "Enable MC146818 driver"
@@ -253,6 +256,7 @@ config RTC_MC146818
 
 config MCFRTC
 	bool "Use common CF RTC driver"
+	depends on DM_RTC
 	depends on M68K
 
 config SYS_MCFRTC_BASE
@@ -262,9 +266,11 @@ config SYS_MCFRTC_BASE
 config RTC_MXS
 	bool "Enable i.MXS RTC driver"
 	depends on ARCH_MX23 || ARCH_MX28
+	depends on !DM_RTC
 
 config RTC_M41T62
 	bool "Enable M41T62 driver"
+	depends on DM_RTC
 	help
 	  Enable driver for ST's M41T62 compatible RTC devices (like RV-4162).
 	  It is a serial (I2C) real-time clock (RTC) with alarm.
@@ -305,6 +311,7 @@ config RTC_ABX80X
 config RTC_DAVINCI
 	bool "Enable TI OMAP RTC driver"
 	depends on ARCH_DAVINCI || ARCH_OMAP2PLUS
+	depends on DM_RTC
 	help
 	  Say "yes" here to support the on chip real time clock
 	  present on TI OMAP1, AM33xx, DA8xx/OMAP-L13x, AM43xx and DRA7xx.
-- 
2.43.0

