Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BBBBC2D0CD
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 15:58:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35FA182CA2;
	Thu, 15 May 2025 17:58:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="pwYkCvMI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DCE282C13; Thu, 15 May 2025 17:58:17 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9C7382C67
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 17:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ad4ffb005d8so206764366b.1
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 08:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1747324695; x=1747929495;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iVifqlMpjS045IPnR8Vf+MjFZOjKmOJei9bkw4j2Y84=;
 b=pwYkCvMIQ6jE6faGwZci4kJxxrLkyZHvgTPl9dC6Eycpse+oAbBQETpB5DrHt7ZFD1
 qwHEUvXVLIkNqYNBGz46VVJPZMLsmNH7qKTgXgKsNfgZG084tpxGH6cxw6pnRqIhM1B5
 rmiVsd9IYyViGJiNB++3nJhbMcLdhausorBi73bFCj8SFHiZyVsS43qrHdIvDniqB319
 NwqCie6zLrzuPQdUNyOeVgHc+IgcxPKOJYhE2Zh9fYxhZUZObbET7p5W6cK3a88W+D3z
 XmT2VhKzYGXqGtGDHm0SnPbDV88VyDZ0cwhOr56IPM9tSCcM+TVP8vBHo5z23JtvtYcy
 /Tyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747324695; x=1747929495;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iVifqlMpjS045IPnR8Vf+MjFZOjKmOJei9bkw4j2Y84=;
 b=qjzFqC1Yzj96BEhSKBVG3WVzePSryg+G9ONlZVxLWF4XW1LBkqqnD3V8xCAM7K66SJ
 2AJ1iKiMZjyDNjyZh/hWu9TW7xMoV3PK/gGQMdE4CHf5xIayVR8Lbq+VvKAyraYg2Q69
 GLYxDaa2ebHbE7NDcAWWV7YPVxVit2tio3b8+SvdDTbo63sa5pl4IJ2EeEm7nvfmRisJ
 JO1k1oF2NfAz3OjMIjWjMI5as4R8PX3lBlhwTZwPlcTpZ+ri0j8wzohy/jKUsQBu8Pdh
 kAyrFYknPXEyVqchM2JWdO5Ir7iOrxYqWuUqu0e+vg+JjjJ9NLCVJV3vVS8WU4shgYZn
 /TrA==
X-Gm-Message-State: AOJu0YwfYfZqHaWeflsgWGvb8UjvejO05l1zpLcMWszLScrpOB/nJzz1
 I76sYdhFbVOhah0KlOmWfwvH3ZcXZHQqv0l6KumKEsY4DdDUiYPCJNQHo0bDhX7TArM=
X-Gm-Gg: ASbGnctj735MN3LAd2yQFYymVFdeki9vp5bd/fiqX/UKam6rn8kmZOpmNHftd9jMLbJ
 Nwp7++A53wJ0I325jqHz0Hvdr5FxN+xmc5E6JcyCLqr4Pvju4PkJ+vQFouY3Cl34sPl1gMw+iaX
 aPXHeyYp20Q+I0f7M0T6TgoO1vloi9Zr1bIKCIJkYdd1mv9xdAhztbl3UDFTR2smd/IJ0jfE/kg
 SsqspUTVjEcuuJnbrcDHGyAMBJ9q6Nk8fjc6hlKNsBGcky9LgIdAauI+G42pt61lBmi6iBZtCsx
 5xiSOANrWYaB0x0ASY3nSzhb80EAIXH2uj/Xzc4+uQthaSFSFnSxjLr5EN3AIL4D
X-Google-Smtp-Source: AGHT+IHQTzZepMpzE/G+JzvwpYTvONJolhbWQEY6qAhc3CcTgAztmMqE66V1gxkHNvjTiI7fSSrZrg==
X-Received: by 2002:a17:907:1c0a:b0:ad1:8fc6:d704 with SMTP id
 a640c23a62f3a-ad52d444d53mr29293266b.1.1747324695060; 
 Thu, 15 May 2025 08:58:15 -0700 (PDT)
Received: from [127.0.1.1] ([185.72.186.3]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad52d271916sm8698266b.69.2025.05.15.08.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 08:58:14 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Date: Thu, 15 May 2025 17:55:47 +0200
Subject: [PATCH v4 4/5] rockchip: px30: Weaken dependency TPL/SPL serial
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250515-silent_console-v4-4-dec6c8391f01@thaumatec.com>
References: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
In-Reply-To: <20250515-silent_console-v4-0-dec6c8391f01@thaumatec.com>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
X-Mailer: b4 0.13.0
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

Allow to disable serial console in TPL and SPL. Weak dependency
to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 9210877a4a49..dac160d33ae3 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,8 +11,8 @@ config ROCKCHIP_PX30
 	select TPL_TINY_FRAMEWORK if TPL
 	select TPL_HAVE_INIT_STACK if TPL
 	imply SPL_SEPARATE_BSS
-	select SPL_SERIAL
-	select TPL_SERIAL
+	imply SPL_SERIAL
+	imply TPL_SERIAL
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply ROCKCHIP_COMMON_STACK_ADDR

-- 
2.43.0

