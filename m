Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06189C25B77
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 12:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DFB8835E;
	Thu, 16 May 2024 14:50:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=edgeble-ai.20230601.gappssmtp.com header.i=@edgeble-ai.20230601.gappssmtp.com header.b="pR9+2E8V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D6A78824A; Thu, 16 May 2024 11:04:13 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94ADB88258
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 11:04:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=edgeble.ai
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=anand@edgeble.ai
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5b2e942171cso1540421eaf.3
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 02:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=edgeble-ai.20230601.gappssmtp.com; s=20230601; t=1715850248; x=1716455048;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVq5nA9Hg192jm46GdIDSqZEIgskpqnFqccjK7OBPAU=;
 b=pR9+2E8VV35bFpeqT2BsPVEiNIQeghsTAvyI4s1d0g8+fauqGu9m/mNPVbf/EGKcbU
 CV33j9wVBE9xtY/ciPLf3QnKmtfNowoOeOFCszT4xMi7cIN8CuwW2b+pXAybZ/9GEm13
 +aLA7zKmyjyuBCsFUT6t/1Ngfj1rYH2hplSkhZ7p2wQWMWpJkgetG3E2f7De9FyC+JLh
 OTrz83Fwj1dKJ6Yq+AqBE7IHDxRytu5pMUl9VWIn2JWBC76DtA0f3neQ/sBxWxfvypEf
 BjKXemtGKP34Dy4oVnaR2UgFUVlBWcRXsQv/sgwvf4VxhofputQhuPaL5/bGSBj/tHA9
 W7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715850248; x=1716455048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVq5nA9Hg192jm46GdIDSqZEIgskpqnFqccjK7OBPAU=;
 b=Jczy/vxRZi7QKQ/2T0joUIVUF0XUuC3YN7b7j+v2TKWkapB0phPhArvJwE7Sqgp3fC
 Yos9lSu/Wg53KyIdwM/b0eZdwGBKxDgvrjsMEV+EtW47OgRNIv8b9eCstdmCSygfI5EL
 sI4UxsRCfVY5KKbqIphQMOYxkChYC0tIZ89X493YGf0OvzmkQd4vMyNZRrm5aqxBzBSF
 RgagYaw7zcbLW0OHtc9hS9zOQum/GqknaaufntdXiiozfgiPYM94YhQbHDLRYYPZYjj3
 wRaWvmpvWQibrutgMYJ40QR8wl0La+8k3vpZKckeJFIxQaydcM/4uAv4xY6WsJKwkJGL
 mJQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy1pteWWjQowEbbUkSjrcgAL32XPEBgxzZABX6uPZK4avV+bruSRJFSzjy0pkowB3zXG0YtKULEqf+3LidzVwhSdxtqg==
X-Gm-Message-State: AOJu0Yxeik+8P5jo8dYD1cSKETnpBmcekqVlofLHm4wAN5snv/pjanYk
 JzcosoOEnFS1h8DDfwA7jb9Ac/xree2R5OXnLpVoSIagYyHLbFyLjzI4rVMMNe0=
X-Google-Smtp-Source: AGHT+IHuopIkniqWlsDcf+h+hubQDHk2CkhXW9gw4CUbptR1XBMEAEbqx74rjGTTRxd0bxAywBpzAQ==
X-Received: by 2002:a05:6871:d282:b0:233:f233:c3ee with SMTP id
 586e51a60fabf-24172fc18c8mr20670641fac.50.1715850248416; 
 Thu, 16 May 2024 02:04:08 -0700 (PDT)
Received: from localhost.localdomain ([113.30.217.222])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6584e7897bdsm1325189a12.21.2024.05.16.02.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 May 2024 02:04:08 -0700 (PDT)
From: Anand Moon <anand@edgeble.ai>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Anand Moon <anand@edgeble.ai>, Jagan Teki <jagan@edgeble.ai>,
 u-boot@lists.denx.de
Subject: [PATCH v1 8/9] rockchip: RK3588: Read the reset cause from clock
 reset unit for RK3588 SoC
Date: Thu, 16 May 2024 08:59:08 +0000
Message-ID: <20240516090031.2373-9-anand@edgeble.ai>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240516090031.2373-1-anand@edgeble.ai>
References: <20240516090031.2373-1-anand@edgeble.ai>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 16 May 2024 14:50:16 +0200
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

Read the reset cause from clock reset unit for RK3588 SoC.

Cc: Jagan Teki <jagan@edgeble.ai>
Signed-off-by: Anand Moon <anand@edgeble.ai>
---
 arch/arm/mach-rockchip/cpu-info.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-rockchip/cpu-info.c b/arch/arm/mach-rockchip/cpu-info.c
index 114608b506..8415009fc5 100644
--- a/arch/arm/mach-rockchip/cpu-info.c
+++ b/arch/arm/mach-rockchip/cpu-info.c
@@ -14,6 +14,8 @@
 #include <asm/arch-rockchip/cru_rk3399.h>
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK33568)
 #include <asm/arch-rockchip/cru_rk3568.h>
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3588)
+#include <asm/arch-rockchip/cru_rk3588.h>
 #endif
 #include <asm/arch-rockchip/hardware.h>
 #include <linux/err.h>
@@ -26,6 +28,8 @@ char *get_reset_cause(void)
 	struct rockchip_cru *cru = rockchip_get_cru();
 #elif IS_ENABLED(CONFIG_ROCKCHIP_RK3568)
 	struct rk3568_cru *cru = rockchip_get_cru();
+#elif IS_ENABLED(CONFIG_ROCKCHIP_RK3588)
+	struct rk3588_cru *cru = rockchip_get_cru();
 #endif
 	char *cause = NULL;
 
-- 
2.45.0

