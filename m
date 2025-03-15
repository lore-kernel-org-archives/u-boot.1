Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81288C282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:29:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DA482115;
	Sat, 15 Mar 2025 02:29:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C2tsAeuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D3A82116; Sat, 15 Mar 2025 02:29:23 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAD8282107
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:29:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6e86b92d3b0so23799666d6.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002160; x=1742606960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pWbJi7dD5KMzDPlXlvPWGdQGclrlQkR8N3soT9+cgog=;
 b=C2tsAeuD6ufOnZEvivTs2QrFW8Tc2ME/Ojain81pFM0UEzVVo3IrEuQGFQoDkZxQjE
 c8/4hWvfGmEzNfhwxcEpToLs8+7dlyeow96wBSE5E0k5SxyS7KuC+3u7kRGkEb7sLUbI
 SuHWGxovvseUWK7BaZnSirMlHlrIEnXg36guc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002160; x=1742606960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pWbJi7dD5KMzDPlXlvPWGdQGclrlQkR8N3soT9+cgog=;
 b=SyHvKy6XeEI66w/MuUpquqkMEJK+YIVKH7Qh/cv1Iw+D/MfYoM+kIIlTPdNqxSkBoE
 J3uW2zN+YalngftCVuRqHnOMTCkJdqR3usH9QPlbpWeZP1N8JZECCUlbGNibslWOT2vK
 QR6zSGrJv7t4vQ7GTiYpS2vNJAmMXoTaSdKm8DTZRPd1VYcP533K05WPLgYkJ1xszzrP
 ZFX+q/JuQyOkXx7xcYCpKb2jm5YUFyRqBD3wr3XxIVID0NxcT2uOUqJrep1KgZfuJpTb
 W9yqcaMhxtYYkyD6jrjH7T/Ez8fcHQenYuIWlUBSs9S9mjIraDWWLZRZqFmWrObFAcbG
 FWIA==
X-Gm-Message-State: AOJu0Ywd9if/arS0aArLLQqwnzy16lsucH+z6//E6oXGe5hDMggYi6ei
 RMv0CinYwDN2I/ARaNVNG+5ImyzB9XmannpXNbDhlTgZYMlXz9wXsU5DO8467wshDs8Pzg794fg
 1
X-Gm-Gg: ASbGncsjXwMPTWv7Xb9MkyeZg2WyyUmfZ6pkdqogrnMQpPOzHMG9ItyhlV2lAcEF5Wr
 yuS3TDIOv+h5CB/w4F3ZyQ4f9kGK+/E1tc8rurb/oFnp278qCOk+tyCRwb7BYwY/WbdDzVwh89G
 xXrR5kqdb2cJZS6AaaU9t5h5m93y64FJ5wFVpNIHPp7gx233FEl/8+nLjXo0W09Ch63mdYlJAtv
 nd/0FRgORbTFgYuLtvtRP4ZfYeOKX8UjWUXoJbTWs0ySleLRHZ+vc10WP+xJ5lDSN+/T8ytrJI6
 qFH3IV6BbbLkOM1LYsGLJS6NO5N2hUKzhS7u1zUpSoU2AClK
X-Google-Smtp-Source: AGHT+IFK6LnmQdOybR1i5/og3Ya1ctkVy9zkPhrn4dwzryOpmXW/h+1Vp9PXctm1czOMevovKussyQ==
X-Received: by 2002:a0c:e785:0:b0:6e8:f945:ece with SMTP id
 6a1803df08f44-6eaf676e302mr13634776d6.11.1742002159764; 
 Fri, 14 Mar 2025 18:29:19 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade2097f3sm30314246d6.17.2025.03.14.18.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:29:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Teresa Remmet <t.remmet@phytec.de>
Subject: [PATCH] phycore_imx8mp: Rework some of the RAM related Kconfig symbols
Date: Fri, 14 Mar 2025 19:29:16 -0600
Message-ID: <20250315012916.399442-1-trini@konsulko.com>
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

As the code is today, we get a warning about "select" statements on
"choice" options not doing anything. In this case we can easily fix this
by dropping the select line as the following choice statement handles
things correctly. We also drop the "default false" line as false / n is
the default.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Teresa Remmet <t.remmet@phytec.de>
---
 board/phytec/phycore_imx8mp/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/board/phytec/phycore_imx8mp/Kconfig b/board/phytec/phycore_imx8mp/Kconfig
index bdf9e97beaa6..caf9cb0c3c39 100644
--- a/board/phytec/phycore_imx8mp/Kconfig
+++ b/board/phytec/phycore_imx8mp/Kconfig
@@ -45,7 +45,6 @@ config PHYCORE_IMX8MP_RAM_SIZE_4GB
 
 config PHYCORE_IMX8MP_RAM_SIZE_8GB
 	bool "8GB RAM"
-	select PHYCORE_IMX8MP_USE_2GHZ_RAM_TIMINGS
 	help
 	  Set RAM size fix to 8GB for phyCORE-i.MX8MP.
 	  Only 2GHz RAMs are supported.
@@ -54,7 +53,6 @@ endchoice
 
 config PHYCORE_IMX8MP_RAM_FREQ_FIX
 	bool "Set phyCORE-i.MX8MP RAM frequency fix instead of detecting"
-	default false
 	help
 	  RAM frequency is automatic being detected with the help of
 	  the EEPROM introspection data. Set RAM frequency to a fix value
-- 
2.43.0

