Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DD8C4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 11:21:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF0A58845A;
	Wed, 17 Apr 2024 13:21:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="3feXjKih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 263C58845A; Wed, 17 Apr 2024 13:21:35 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B49A87842
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 13:21:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-418c0e9aa1eso2331925e9.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 04:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1713352892; x=1713957692;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Irpt+ASg9f0394NY/CbXegsYuBA0Bl2+DVcIGuPkTho=;
 b=3feXjKihLA3uY6jrp8icyj5cHB/PMx2n/QTUUEfVTD4/Fz5VuUSVtpzRMO4FZrcFMW
 NLmnPpp7RqtQYYm2aV7OhY/XNJDshFjJm36F37onZmnb3gCT6/2YRtFNZEz1CeV2vh7A
 04bY2thfeFLSkFB0TiEXIpHgGzywLrtRljH1fmahJzM99EmlOwQQFPoRlw9Owxr7MYna
 /D7PLyAvNI2cdzGZJT3HzGp8I7IZ3yBw0xcMYQIV5mi7keP8kmIr4/U8QHpLJVXKaVW/
 FAkqS6bujDrc86VAgwAToSQVkjXLV6gMxhrPa+qzM3YDhW3zj9dn1y/vcsu7QPX90z3j
 iM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713352892; x=1713957692;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Irpt+ASg9f0394NY/CbXegsYuBA0Bl2+DVcIGuPkTho=;
 b=pRpaO0ORXXAexaN3Q8XR3zqhM59mKBV7GFZUY9WZO3k8Be2dMAXDoPBo3cthnRmB2k
 5pIVZutHEAYVfJwRI6E9DVDDNDyR3ne7Gd+8SpC4n4kUxsQNI7RVaFhMhBMgHWUm9wkN
 wvLFpDUBBln30FD685l8KKwZCTCM6We0cCzwE5ZOGOwFvqekZZjrRjyie5PWE4yz14iR
 Fi7zsSm3aSBahOsNjtzpLvtYmiwsX/GN2JArMcCZz/g+RxrRZ+Hik3BhY216ygV0lpOp
 Tj5YtXwu/WIQDjM+jnxfxZCREsbnleZz+fY26i+PjeLt7rJFu4nA+MmyfQVH0QgHGllh
 sXTg==
X-Gm-Message-State: AOJu0YzxDYRKRU2FAgwtemevD5IlsTTuUdDcwR4/VJsZgR7TKoj4Zkb0
 oKwRBD3OvWUwMCuO7mkd6JRjc+vs8Np0dPOb6EUnwk8alwqxzc5o/XEFMwygd+VSp0+2Qbq5o0u
 Q+RI=
X-Google-Smtp-Source: AGHT+IEFXxbmUN/gHkNtNaddMSd8rgpcPTu5ckdiXcA6UrwyyQO18X56xrbPTsZWLZAjjmFXB5QSWA==
X-Received: by 2002:a05:600c:3505:b0:418:4019:b079 with SMTP id
 h5-20020a05600c350500b004184019b079mr7426197wmq.7.1713352892418; 
 Wed, 17 Apr 2024 04:21:32 -0700 (PDT)
Received: from localhost.localdomain (ip092042140082.rev.nessus.at.
 [92.42.140.82]) by smtp.gmail.com with ESMTPSA id
 bd14-20020a05600c1f0e00b004182fab5098sm2441413wmb.20.2024.04.17.04.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 04:21:32 -0700 (PDT)
From: lukasz.czechowski@thaumatec.com
To: u-boot@lists.denx.de
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu, kever.yang@rock-chips.com,
 trini@konsulko.com, Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3] rockchip: px30-board-tpl: Sync ifdef guards with full TPL
Date: Wed, 17 Apr 2024 13:21:28 +0200
Message-Id: <20240417112128.288531-1-lukasz.czechowski@thaumatec.com>
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

From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Display TPL init information message only when TPL_BANNER_PRINT
configuration entry is set. This allows to disable information
message in case logs on UART are unwanted.
Update parent ifdef condition to check also CONFIG_TPL_SERIAL
to match logic of the non-PX30 TPL implementation.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

---
Changes for v2:
- Updated parent ifdef condition

Changes for v3:
- Updated commit title
---
 arch/arm/mach-rockchip/px30-board-tpl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/px30-board-tpl.c b/arch/arm/mach-rockchip/px30-board-tpl.c
index 637a5e1b18..db368a7b8c 100644
--- a/arch/arm/mach-rockchip/px30-board-tpl.c
+++ b/arch/arm/mach-rockchip/px30-board-tpl.c
@@ -36,7 +36,7 @@ void board_init_f(ulong dummy)
 {
 	int ret;
 
-#ifdef CONFIG_DEBUG_UART
+#if defined(CONFIG_DEBUG_UART) && defined(CONFIG_TPL_SERIAL)
 	debug_uart_init();
 	/*
 	 * Debug UART can be used from here if required:
@@ -46,7 +46,9 @@ void board_init_f(ulong dummy)
 	 * printhex8(0x1234);
 	 * printascii("string");
 	 */
+#if CONFIG_TPL_BANNER_PRINT
 	printascii("U-Boot TPL board init\n");
+#endif
 #endif
 
 	secure_timer_init();
-- 
2.34.1

