Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6120BCD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:44:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15F988CBF;
	Tue,  3 Sep 2024 18:44:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="sjqMQ5c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AD6288C9F; Tue,  3 Sep 2024 18:44:41 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99EFF886E5
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:44:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c25dd38824so2218188a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381879; x=1725986679;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LlCLxapT/MPMX/03FzIj7Ta17veA4kndQ6QxvkkkqX4=;
 b=sjqMQ5c/62B7UNAdZUh9J+H+Ac+J0KVpABy/Fc/Igbigh7BYhgqfyB9FqdYeP2hQY5
 EIcT3fmE5LXfs7AqsazBKbfKh51p6ZyzCDO/pIjtKWQEoAoateobo23DN5TE+Xq5tete
 2uS8f3iQvKNbqyEoezS4FQXM9Ex+9RL5j8F7Uio+dz6bEhsw7XBjcQxKB59O2ZL611El
 lTgKNHRL0ZUtLl9MCAYY3jfhJNTzoyQxkuFVX7myeJq2CWJaKJh5IX48BndnOptrCb3s
 Jsz4xiUzbwWYr0BWdPnCgg68iDscaDYMO3PCKCNZgF/Q4q5MvTvet+xUR0sdaNSBZtdK
 iECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381879; x=1725986679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LlCLxapT/MPMX/03FzIj7Ta17veA4kndQ6QxvkkkqX4=;
 b=Pj25ReOa88/dTJ9P2gf1PqyXOv0qDKvMubm6IxZsum9tugiKMeZenrYuJppGepTbWw
 L+Fhy+GcvjLw8Ifxw9EgKlzgxycCPM3G8xc50Sw0qSYWDQEKCUTAZdz1DVLdYSV3fNB7
 319hYvUDMos0+Ueam0uM4i4ElB15NtGyY897HjwaUjAGzigtvE2vAfUZsaSAqq0mNQpO
 d6sUx/G7YejK72A/EseomxM1zi+qlV82lr0EsnIhyzK4Bn2gpic7tiT5zMdPqKg5zUrJ
 wiXvMRmPmXvVNxLFF13Wih86OIESXDWGRAJDfSrKwVEB8+mbdY1M5w0rCgwo1dCaAlYs
 1WlA==
X-Gm-Message-State: AOJu0Yw6aO1GOgOEPW3skQtWNSAazMed+7pzAyFWwHlEZm5NVzC5b4r+
 Odc2hQPfQeVfWY1AUdHufD+Sii8vDAg7Ns+Z36HgppM/r0/YGS4lHUPR4gz52pJh4bpiKtqK0q2
 r
X-Google-Smtp-Source: AGHT+IHywTFpbrTsY4j0EVG1j3SUFXrYQQODPPH8HIcSvHjbrP7R6SRwojhnre8SV47Kvw9WcAvZLg==
X-Received: by 2002:a05:6402:5186:b0:5be:e9f8:9ba4 with SMTP id
 4fb4d7f45d1cf-5c22f7af6f1mr14644611a12.4.1725381878703; 
 Tue, 03 Sep 2024 09:44:38 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:44:38 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 5/5] rockchip: px30: Fix hard dependency to
 DEBUG_UART_BOARD_INIT
Date: Tue,  3 Sep 2024 18:38:58 +0200
Message-ID: <20240903163858.1155218-6-lukasz.czechowski@thaumatec.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
References: <20240903163858.1155218-1-lukasz.czechowski@thaumatec.com>
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

