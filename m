Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06FFCCD1A3
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0C7688CA2;
	Wed, 18 Sep 2024 15:03:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Vws9kuKy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71D7088C10; Wed, 18 Sep 2024 15:03:44 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A1EA88BCF
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c4146c7d5dso7570630a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 06:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726664622; x=1727269422;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZ0LcukNClzxY082kwgtPA4hPtir00Kxl1vAfHhyCmA=;
 b=Vws9kuKyKp4HCK5IQqvJfQdLwlrcrmBwvEm1s1BrOQ9Y8UkKve02fgCCf+Tnu0LzTP
 b2GXvAFZsYBvCUxmduGf0db9Ze4kdayBxLUSwaVJS6PYNg15kWOHY9n1M6wAIdSi3Hjf
 y+IKUvUcUf/eW5i8Hcn5hYyZ2FyO8rnsGA1JSy1pkzLjhOot2lJOtMW51Zm+3x9uQvK9
 k+/J1CMEG1ndPxTGdvOpgjTaEmyzCflYAkzGH4qi+EANxixtp1YADI6CB+sVfU1KMfBJ
 vijBoxCFKYdr8P6UbMyvpgS0HfdmbT4EZlf89eFhFFxqGLX6lLB4LtVdHGGNrck3OxRq
 nwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664622; x=1727269422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZ0LcukNClzxY082kwgtPA4hPtir00Kxl1vAfHhyCmA=;
 b=W2QvJFtECiFoxCrl1XsA38EySew1yZqM4Bm+7VYC6oF2ESB2dJqyxMpWjTk39btmUC
 MnsyNeztkiZ3W8rTzo5YyyVV/iBNwpQcgBCgqt6WaCk1scRWGRh0SJbKfbjd2zHWFBFP
 oq+o2gEkwzfSMJt8R+KtVJ3wyPFmuvZUO4OMxWcfBLbawF/E7G5hKzO5Bh6SffLl9rNl
 GO2KVXB5CEndZnt1cGmwBdJdU8Di5pCKX1j2PU4BG94fvtlBrAi8UjplwhEXDPgGoVO2
 LEPQGpuNdidZQwFcmKnCC4s2DOk2ItT6JzMrDeIEVw/bVtRC6Ms5CbZlLZuGWtTkWEiY
 H/Mw==
X-Gm-Message-State: AOJu0Yysap6ZkIkUl9upV4+WvXGXQTxF1xcRE6OsFDpxPxVz9VVUF8Q+
 YTl7BpjqUR0mtFqQRd+Xb4jLXxpBhqZ+MzWucZ71T1MBQOym7/jyXZWziKJa62jIU/gMIPTeuBm
 2
X-Google-Smtp-Source: AGHT+IF1VYV4iw695jNV5Gyq1HbejG/SMnfRErLRzcHjLbktfwRuycOK6LRZCyJMqrVMh8WX8m+nBQ==
X-Received: by 2002:a05:6402:34ca:b0:5c4:2be3:dc74 with SMTP id
 4fb4d7f45d1cf-5c42be3dffcmr10368051a12.36.1726664621643; 
 Wed, 18 Sep 2024 06:03:41 -0700 (PDT)
Received: from localhost.localdomain (83-238-227-197.dynamic.inetia.pl.
 [83.238.227.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb495a8sm4885576a12.11.2024.09.18.06.03.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:03:41 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 4/4] rockchip: px30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
Date: Wed, 18 Sep 2024 15:01:55 +0200
Message-ID: <20240918130155.299353-5-lukasz.czechowski@thaumatec.com>
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

Because DEBUG_UART_BOARD_INIT depends on DEBUG_UART, hard dependency
to DEBUG_UART_BOARD_INIT in ROCKCHIP_PX30 can cause warnings if
DEBUG_UART is disabled.
The DEBUG_UART_BOARD_INIT is already implied by ARCH_ROCKCHIP entry.
Remove hard dependency from ROCKCHIP_PX30, so that it will be
consistent with other rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
---
 arch/arm/mach-rockchip/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index 47a6275d45f..c9aaf6d3476 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -13,7 +13,6 @@ config ROCKCHIP_PX30
 	imply SPL_SEPARATE_BSS
 	imply SPL_SERIAL
 	imply TPL_SERIAL
-	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
 	imply ARMV8_CRYPTO
-- 
2.43.0

