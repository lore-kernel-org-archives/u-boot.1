Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E83AC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 21:17:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B7C680BB0;
	Sun,  9 Feb 2025 22:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GIgNKS5D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61E5880AE5; Sun,  9 Feb 2025 22:16:01 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35FB0803B5
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 22:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-8550803e1afso157786439f.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 13:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739135757; x=1739740557; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRVDFxD2ZJoW5h5eWXxFUi+/JU1cO4s2U0dIw7ifkl0=;
 b=GIgNKS5DZquIgS/GltjcJG7EKWMMYEvBlvcynns7HP18iIvxT5foutQ9ciqSp9BmCn
 15gH/LqlAqrQlciioDwMX1tiySMP3fxTZJwVNUZiNGTYb/9cudtUKZEj1xfutD4G9jh2
 rAK2RxGTgBnM9jPT+bUKUcfizklB8Tg6HpY4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739135757; x=1739740557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IRVDFxD2ZJoW5h5eWXxFUi+/JU1cO4s2U0dIw7ifkl0=;
 b=XpuetaDj1Jjt/q0FUdhDMHqKnGWQ7XmibdyTBt7Ue2I0R/SFy9jWHt+F4YPIy29QNy
 oGWrKeK2qtgPFUxjZhTTUZRshH4doJPCEa6bjqYdW5P0HGIRb8jgCcJiDJMtwQppgM79
 BF90IKXhEG/KG/kQjE9ecfP2HL65wEM2osMrnzLtJBC1dAkrFAL/dv0ylMlaDKdGDIEY
 Scj0N+VG7jWS9itUB0YaveaT0Vf5M5s5yBAUyjlrZSxgq72YbG4BSw4NYdgMQEZiLvFa
 nspnUjJkqujdsLr4Fqb+DOEMxhcb164eA9U/FFhi+I9xNvestQN8DtP4hKJbCZ4Ux4re
 21Vg==
X-Gm-Message-State: AOJu0YzulHDUPZdnSAnZQEu8GuOkarWvOBUDGcUzpVpJJ2llmz12ib6g
 yI8Rt0yCYHHnW9eN/R+Y3+r4M7/LSzNhhDGPg79ETBaCXZe4QhEFsPzblnojcgillks2tAgRhYE
 =
X-Gm-Gg: ASbGncsUXdZPIqnHI5ifrRFHtMuIuCgv0evu4tZRyZQQM1TlWgUMCaOL/R6yFzJOk1H
 UXLE8z9w1gLt12dTqUjpyvgRzhm6HO0J3cC06KD689DK2AF9i2AAIvppuraegHkydJ+F9RF9c35
 5SBXdB4qCK2xUOTBG4fgAsXqq0ppfb89UJwJMN4wJOFXVN0LTSsfiodGYnHwM7a2+6RsSzhMcRD
 dhOsPz7lWKa+sWSLrD/1G3p/3XRt6kW7EbjujLGsYOgtAc/6fI7K/R0vnkkGnyS5sMfUFJtpwNV
 nbZ9Mra8YcBT8wVbFW4dchyuV4AWVTBY/2V1ES8zXA/DQmXO3i55
X-Google-Smtp-Source: AGHT+IHsaqoUTh1SoLf7FhZalFT5RE18bgtUkXT+MSPfLrbXWsztN9G2FYdV/XlEAUKxsIYPta/9ZA==
X-Received: by 2002:a05:6e02:b23:b0:3d0:237e:c29c with SMTP id
 e9e14a558f8ab-3d13dd5e8cdmr95997705ab.12.1739135757028; 
 Sun, 09 Feb 2025 13:15:57 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3d05e96f245sm18978655ab.51.2025.02.09.13.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 13:15:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Jeffy Chen <jeffy.chen@rock-chips.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 huang lin <hl@rock-chips.com>
Subject: [PATCH v2 14/35] rockchip: dts: Use the new binman template for the
 SPI image too
Date: Sun,  9 Feb 2025 14:14:35 -0700
Message-ID: <20250209211502.2299245-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209211502.2299245-1-sjg@chromium.org>
References: <20250209211502.2299245-1-sjg@chromium.org>
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

At present simple-bin-spi relies on the u-boot.itb file created by the
simple-bin image. Use the template to avoid this, since Binman may
change to process images in parallel in the future.

Drop the filename to prevent another image being created which uses the
u-boot.itb file.

Signed-off-by: Simon Glass <sjg@chromium.org>
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
---

(no changes since v1)

 arch/arm/dts/rockchip-u-boot.dtsi | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/dts/rockchip-u-boot.dtsi b/arch/arm/dts/rockchip-u-boot.dtsi
index 281119a53d3..79f4188b76b 100644
--- a/arch/arm/dts/rockchip-u-boot.dtsi
+++ b/arch/arm/dts/rockchip-u-boot.dtsi
@@ -41,7 +41,6 @@
 #endif
 		#address-cells = <1>;
 		fit,fdt-list = "of-list";
-		filename = "u-boot.itb";
 		fit,external-offset = <CONFIG_FIT_EXTERNAL_OFFSET>;
 		fit,align = <512>;
 		images {
@@ -208,8 +207,7 @@
 
 #if defined(CONFIG_ARM64) || defined(CONFIG_SPL_OPTEE_IMAGE)
 		fit {
-			type = "blob";
-			filename = "u-boot.itb";
+			insert-template = <&common_part>;
 #else
 		u-boot-img {
 #endif
-- 
2.43.0

