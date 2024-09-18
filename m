Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C76CCD1A0
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B6AF88C63;
	Wed, 18 Sep 2024 15:03:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="NqJz65CD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D9888C4A; Wed, 18 Sep 2024 15:03:41 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E36C888BC2
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:03:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a8a837cec81so393861866b.2
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 06:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726664619; x=1727269419;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=17S3cLgSSyfrh4jrDKmovvUFpvIIjoNHgkdhg5KiYug=;
 b=NqJz65CDxyiwdcpZ7IX6OmvkOZHzTatcKRuO64gJO8nKaZRTv8HThfoI7DVcLbF9Gs
 LZaOQnytA7cD0yz2YAYWDUHnkbgSzrH2O8woi5eH8TJPzZ0KkihlAD87UifxEXac/K/m
 Sov2Zbpc9bIlZziVIEh6lO2C2SrRrsWg5kjHhxMnxxFw1UynCVi9WaWfyflDBNpOtiYo
 FwQ2OGdEz7C9LyNCDf9RSVwZeu0JqFl36zOHtKaEP3i2AiSNQnyP6V/Ho0cXt0sgaPXx
 tgMw2KKgCji5P1G4QEV5QsaZHeYcIHLWz1vQsexwWidjGuQml/3kh48fJgHVl0LM9mO7
 mt+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664619; x=1727269419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=17S3cLgSSyfrh4jrDKmovvUFpvIIjoNHgkdhg5KiYug=;
 b=CK7/OMyj0BoZKfx2txe8GtoiFv995avOdZaPMhWwWWzy30Bug+cwu1eGk3Gricr3Yd
 /SrXdzGfy8HBk9scMLPb2/qBGP/Sh4y21YH4Xn2wqeqcTiQXbqDD2IAGaJ5S2tEOqazI
 8/6iE/Ld+R/Ix5G0eHPedv/Y7zmD+UDHB19VBC6Q22CPErFo8st2Bd8qSj48cXDUGVKN
 SDszVzB/xM2FXIMFixmzqcUJKLT+zEUnuale8bAhMihAQtsj7yrS4/o4IWqutsUXdUVB
 PRsGNL5x1VpkkRlTJzskC0M2MhjJN5VmaX+T6VZbEyhuSi+7h9sdzGYj8pX+VYk1jhlw
 M6fw==
X-Gm-Message-State: AOJu0Yw/ihMFmvSuryB0G6x6FfKsdG01ckSNwcsWvMf85emadjFvpVhB
 te+DJJ1TZ6+DtFV9S/jO1NgCgG/kUZtXN3HSP7Lkf8nGEGhXexdhOE5LPnCawQRgax8JW2LruzO
 n
X-Google-Smtp-Source: AGHT+IEYk0lsiNQYa9zUfEu1QtK3un2Bje/dA9eJyVpo3uvlsPJOe/7e/gFgOIIy64FL44fHjuUc8Q==
X-Received: by 2002:a05:6402:51c6:b0:5c2:5df4:5a4c with SMTP id
 4fb4d7f45d1cf-5c41e2af39dmr26153902a12.33.1726664618916; 
 Wed, 18 Sep 2024 06:03:38 -0700 (PDT)
Received: from localhost.localdomain (83-238-227-197.dynamic.inetia.pl.
 [83.238.227.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb495a8sm4885576a12.11.2024.09.18.06.03.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:03:38 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 2/4] ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
Date: Wed, 18 Sep 2024 15:01:53 +0200
Message-ID: <20240918130155.299353-3-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
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

The RAM_ROCKCHIP_DEBUG can be used only if DEBUG_UART is
available, otherwise it won't have any effect.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 drivers/ram/rockchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ram/rockchip/Kconfig b/drivers/ram/rockchip/Kconfig
index 67c63ecba04..d707d09c1c8 100644
--- a/drivers/ram/rockchip/Kconfig
+++ b/drivers/ram/rockchip/Kconfig
@@ -15,6 +15,7 @@ if RAM_ROCKCHIP
 
 config RAM_ROCKCHIP_DEBUG
 	bool "Rockchip ram drivers debugging"
+	depends on DEBUG_UART
 	default y
 	help
 	  This enables debugging ram driver API's for the platforms
-- 
2.43.0

