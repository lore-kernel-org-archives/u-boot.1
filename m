Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99605C35FF1
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 18:00:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DFABF819FC;
	Wed, 12 Mar 2025 18:59:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WLUwQm5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DFBD817D8; Wed, 12 Mar 2025 18:59:30 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A42E8175D
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 18:59:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so19653366b.1
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741802368; x=1742407168; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u+V8CA4jKyHh54Sljirspc4fnBS6UAhQ83x/oIcN9Ow=;
 b=WLUwQm5uFV/jxpguAofPznZkeO9HIHFIvxtudizkGNyg5UdpaDu3wI76K26OHAfbWg
 qQAHHYbbU1/ef2H0uwLmuj1M7dZz2JBBdZRf7YDdq3wlYITip2OOpTztDs2t68rFXe4t
 GbSRgEAKf6RLKsNTUz2YVTi8AMKslU2qmDh13+cJvc5pLwJxkrHZgeAz4xH7pFTHnMAA
 7wssCNCSXZgiixEjjN5TWPL1AmZGJdGjgtsdHrp45uuIqmHhVro2VcDJ5eUagYKk06Vm
 NcOXo4QkPQ6LMLUhMirX97/MS5Y0GSloEfdF3+I7VwEev3zB9+4IKnB5Uhsi+Bxvish7
 xPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741802368; x=1742407168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u+V8CA4jKyHh54Sljirspc4fnBS6UAhQ83x/oIcN9Ow=;
 b=ZMwAKNylYqUS/AtQWL2b6gXqIPCAW/hWiQeQUcFi6okj1AD0mLitgQqmzp9C7jQeJL
 N4embiR1zeh8NZbIeZ2i+MN9C4gYv96wlWCE638SUFFAJpp/jNWvHAYZvjgvzSSuWYNw
 G9ljieubI3cJ7IiR+tRFLB9oyXK8wSjBmiqXzwGsctHVXf+KG5geBddwhwVBjST2xj6o
 SQ4OChFzSVCCKsagev0PdHXwAqytLTArZrB1LLUqJVXMBFHA9Z4lQyh+sx+WvofAF8Cg
 ohap/dNzXbMsY0UjBT6NunCvXX8dl8sbJn9j+pXBONWq/d/E6S1VePPl66wDoX3Sl+ZD
 J2tg==
X-Gm-Message-State: AOJu0YysuVnglXnh/eNfY6A7kThp8AY6xREv9er8x+kqe83K30poccI/
 anlwn/Pj2VwO9DXmQnOkyI8mZIE0wIM9XH4830vT/gj9m/r7pOc2
X-Gm-Gg: ASbGncvKkF6UK4XvBu7ltqALN4f4O9eP436dGCH9nFOB5Lf4i20L6IKtAFNhilOkabQ
 AtP83lydKDfsSGk2vKF67NIaLbZH2sFtqZNzomMoxwbs3hXIvsLDiyQ02H000lfMtMIKCWnR7S6
 2yKFXr1MUqa9IGT+NJcMroM4n8S4rv+0DEIXxiGcriUcxDcp7AHEDRi5CeS2h8cseeE3cuIEOz2
 nrOh7yBl/R5w85ZaxFQU3SCZt802qJgHUhoJEISzTgur+7qPJ79etkVmF+NkeOjh2X8gULaoIbS
 5Z7pASw032eJgXoLXmngPqUrQWrH7Sn5ExeNPd+Azbv3ey4=
X-Google-Smtp-Source: AGHT+IETusdM88Vd936uGO2Jx6RLP6xBeiiarEGLfBCSaX/P0bjfjzzeM2QNr/X+2nXfEIsRm1o5hA==
X-Received: by 2002:a17:907:7213:b0:abf:6f87:c732 with SMTP id
 a640c23a62f3a-ac2b9de96d4mr1223620166b.20.1741802367653; 
 Wed, 12 Mar 2025 10:59:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.73]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac2394825adsm1125291166b.56.2025.03.12.10.59.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 10:59:27 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Peter Robinson <pbrobinson@gmail.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 07/10] video: tegra20: dc: support binding child devices
Date: Wed, 12 Mar 2025 19:58:54 +0200
Message-ID: <20250312175857.120313-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312175857.120313-1-clamor95@gmail.com>
References: <20250312175857.120313-1-clamor95@gmail.com>
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

Implement child binding helper within DC bind to support DC PWM backlight
feature.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/tegra20/tegra-dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/tegra20/tegra-dc.c b/drivers/video/tegra20/tegra-dc.c
index 516a397872a..1f43153ff27 100644
--- a/drivers/video/tegra20/tegra-dc.c
+++ b/drivers/video/tegra20/tegra-dc.c
@@ -632,7 +632,7 @@ static int tegra_lcd_bind(struct udevice *dev)
 	plat->size = LCD_MAX_WIDTH * LCD_MAX_HEIGHT *
 		(1 << LCD_MAX_LOG2_BPP) / 8;
 
-	return 0;
+	return dm_scan_fdt_dev(dev);
 }
 
 static const struct tegra_dc_soc_info tegra20_dc_soc_info = {
-- 
2.43.0

