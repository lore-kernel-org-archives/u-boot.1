Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89014C54E90
	for <u-boot@archiver.kernel.org>; Sun, 25 May 2025 10:50:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D5983693;
	Sun, 25 May 2025 12:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FIdjiXz3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D0EA836C1; Sun, 25 May 2025 12:48:36 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3758482AA7
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 12:48:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so9600455e9.1
 for <u-boot@lists.denx.de>; Sun, 25 May 2025 03:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748170113; x=1748774913; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=87sA9g/OBKgaEIo3fazfxg/kdkd040onUxdZJULqGC0=;
 b=FIdjiXz3ow7Jhv0WjKkewrVfuqXVB6PSXisdauFOohVe343cYa9Lsm0Z+jSxv7r8cb
 0LxnMnkjds4awij59Dy6QxNjVMA7UJimMKGff3VOSrMGfoqOYB/4km0Wnx6BRzi7hJPq
 nDVcSJZARGKSYCedh2YsyxYVS/RW+mjd9MJAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748170113; x=1748774913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=87sA9g/OBKgaEIo3fazfxg/kdkd040onUxdZJULqGC0=;
 b=l24bMLdhMe5NKP9HCECcnz1Xve0QlRKZkIyfHT1H8CeII9vSSLeyxsmv0Y9/P6l6U5
 BZ26AtJ2oQBc4ArcK7T5RNMpk9WXui6uTN6Ffj5Q1nDKuFN/QyumofzHgqt7W+aG0KMl
 xUzzrOowVpL1g38X7JTMAyzRAc+n1uliSoc0d2bx21qtypEaXVIQz/O4rFVDTwtMSQvk
 TkbY7aJDJLVTLqB2Fv5w1t1WpdcU28a5BvGH8RhcDERf42L6NrLUXV3GRb7cbfWmj8ep
 Fc+yCCwFkKHdRy4qjjeqspXmyW52baGgeM08YLTSSTn1WnJy1+bghU6YguVgdcMdE//n
 twGA==
X-Gm-Message-State: AOJu0YznA9vTmTnYJvShViRcTRgEri6lpnrywowo3qvZviAuuikMh9MF
 Y3knlLorHubVa1LB4U4lcZMAXaFEvZ4sd01Lg+DDhPEc/ISbwagju7Cf2Ada5JiGVJwHYf3OQYA
 v1+4lyl4t
X-Gm-Gg: ASbGncvWuyIO+GXpY8f4O6JS3On9mfCAtQ5JrldBSPAcx1ya75S+AuHOWui7Y8wRgBF
 qAXGyydkuo7cC+47XYybHSgRP72ccn7eJcEnkXwELaUgGydSWHV1eKguYuQX2h00tklpGwWReGX
 FUFiQDeoPbiMUlEP9TyTbjXpJSuXXjMqJVuSSRFwPSZRYJiLlgd1eYece492MUmaVA7hpHs+XER
 joXBmvLHLiNwqTMlxJ2kWVbE2W/dirqEaZS5ZTwhHnTt14rb6aAGEqrr5IoWLdmxfgEm/C+FGyS
 K/uWCBsV5xpngh25nUYytkcGcyu8+wT+V6EP9jMD7FX+lCDKfsyh0haTeb87n8jR4IRMzBo=
X-Google-Smtp-Source: AGHT+IEaUqrSa+5VoxD6niw0PaMYqEmCdAglUu3TqZ8Gxyq7SbEM3ZwxV0gGnYnd++kR64EXcTN+YA==
X-Received: by 2002:a05:600c:1e02:b0:43c:e6d1:efe7 with SMTP id
 5b1f17b1804b1-44d5c54c831mr28503005e9.26.1748170113143; 
 Sun, 25 May 2025 03:48:33 -0700 (PDT)
Received: from tasman.. (host-80-43-238-15.as13285.net. [80.43.238.15])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4cb450867sm5045047f8f.57.2025.05.25.03.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 May 2025 03:48:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Dragan Simic <dsimic@manjaro.org>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Paul Kocialkowski <paulk@sys-base.io>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v4 16/25] rockchip: Allow SPL to set up SDRAM
Date: Sun, 25 May 2025 11:47:52 +0100
Message-Id: <20250525104801.1440260-17-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250525104801.1440260-1-sjg@chromium.org>
References: <20250525104801.1440260-1-sjg@chromium.org>
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

The current logic assumes that if TPL exists then it must be setting up
the SDRAM. This is not true with VBE, so allow this to be controlled by
whether CONFIG_TPL_RAM is enabled, or not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/arm/mach-rockchip/tpl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-rockchip/tpl.c b/arch/arm/mach-rockchip/tpl.c
index cc794a7dca2..2a261199179 100644
--- a/arch/arm/mach-rockchip/tpl.c
+++ b/arch/arm/mach-rockchip/tpl.c
@@ -60,10 +60,12 @@ void board_init_f(ulong dummy)
 
 	tpl_board_init();
 
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret) {
-		printf("DRAM init failed: %d\n", ret);
-		return;
+	if (CONFIG_IS_ENABLED(RAM)) {
+		ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+		if (ret) {
+			printf("DRAM init failed: %d\n", ret);
+			return;
+		}
 	}
 }
 
-- 
2.34.1

