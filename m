Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4753ACCD1A0
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 13:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A6F188A1C;
	Wed, 18 Sep 2024 15:03:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="p4iElAxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8178288A74; Wed, 18 Sep 2024 15:03:29 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CAEA889EF
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 15:03:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32974fso8488322a12.3
 for <u-boot@lists.denx.de>; Wed, 18 Sep 2024 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1726664607; x=1727269407;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSy14b2y/VPKqgMXD8B+ePwNswGEkZd6MJ0ZEn2e7UU=;
 b=p4iElAxBhsnIiPC/DYtig6uG/GsspmCl3jd0MoQRIKWUIh9WE+hs0XM9gvqCSUFkmq
 S6DSMn2zQMTLl0D4W+qVfy8Gg1nSxG4Y8tvkAkDBWsNqC8JoWlYJj3XdNfowzyR7ym6M
 WJGDAUKIRxr+t35HEO1E5kXMUa3Ix+D8L+LDYHMrWfl8JwQKi1gUeH15OldnXJnmhqFw
 hnoOmESQEYbY44IolGwItlwXmDVhZgUzdCPKc4Jqx12gF/cD/XvIjCTJIs3UUCfBdCl5
 dqGCDeHFDNN/ulFKDyQKf3FpNX/+ZzS8pA54MSxEnb+eRmb3iLKnSqvAc+Vfo3QJtY0f
 BWxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726664607; x=1727269407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xSy14b2y/VPKqgMXD8B+ePwNswGEkZd6MJ0ZEn2e7UU=;
 b=IRBctmn7nPGTHSCRRmp2AOFBhawGpGYQ9RzXGUU50h6AdLdofby0BzKF/WN8R4YmdK
 5KpfJLNa1wtZlywyI/MMNh9AeKvVlEC6tJ5mJ9vEyn688WxeJkFXnmKJC5st4LkE5xhj
 w/dhXJFTEtRMsfUKjQWo3zAsWTnS3sOqgEnlaQyj/Z2watFscu/EgnR6RGix19bamFaN
 z/+3I7PDtVvxAMMa4RCoKpxsXhb61jprTyvu5al2P3y+6fHud6BxGgePJnjJgsSA/7lb
 +xgzLiq1gUvfu5WUoyfLB/8Iwin0DZqswR1AE/c1mH3pmslkZNyDZdnsd7hjZo3ox2t4
 SZRg==
X-Gm-Message-State: AOJu0YxsYspuFE0IzKaro/JQhNXS+allP8u3fzL39QEfjyoOPH6X6Hdy
 6V9dzSEZp8UHqA2Yrd7D6E/j7vafZeyKx9H0wnQ8No5kcCkztAaiF4/H4cHd2V+EJBTmSdniftU
 M
X-Google-Smtp-Source: AGHT+IEZIFeYDnwPEjP9Zvd3yG626ls1mGqHwHn/wK0wkPtcrSrlnMRh0oWXPFu1MM3GjEOgACjQOA==
X-Received: by 2002:a05:6402:1e8b:b0:5c2:5620:8ba3 with SMTP id
 4fb4d7f45d1cf-5c413e5227dmr16519418a12.30.1726664606371; 
 Wed, 18 Sep 2024 06:03:26 -0700 (PDT)
Received: from localhost.localdomain (83-238-227-197.dynamic.inetia.pl.
 [83.238.227.197]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c42bb495a8sm4885576a12.11.2024.09.18.06.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Sep 2024 06:03:26 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v3 0/4] Rockchip: Allow to silent TPL/SPL debug console
Date: Wed, 18 Sep 2024 15:01:51 +0200
Message-ID: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
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

Currently it is not possible to completely silent the debug console
in i.e. PX30, what might be required in some embedded devices.
Disabling DEBUG_UART results in errors, due to missing symbols.
In particular, rockchip sdram driver performs calls to debug_uart
functions (i.e. printascii), defined directly in serial driver.
This patch series fixes the dependencies in Kconfig and provides
dummy implementation of debug_uart functions that are linked in case
serial driver is not used.

changes in v2:
 - Update commit titles
 - Create separate SPL and TPL symbols for RAM_ROCKCHIP_DEBUG

changes in v3:
 - Dropped [PATCH v2 3/5] ram: rockchip: Add separate RAM_ROCKCHIP_DEBUG config for TPL/SPL
   As suggested by Kever, dependency on DEBUG_UART is sufficient and this patch
   was not needed.

Lukasz Czechowski (4):
  debug_uart: Replace debug functions with dummies if CONFIG_DEBUG_UART
    is not set
  ram: rockchip: Fix dependency of RAM_ROCKCHIP_DEBUG
  rockchip: px30: Weaken dependency TPL/SPL serial
  rockchip: px30: Fix hard dependency to DEBUG_UART_BOARD_INIT

 arch/arm/mach-rockchip/Kconfig |  5 ++---
 drivers/ram/rockchip/Kconfig   |  1 +
 include/debug_uart.h           | 16 ++++++++++++++++
 3 files changed, 19 insertions(+), 3 deletions(-)

-- 
2.43.0

