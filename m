Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA38CD379F
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 16:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CEE78876E;
	Tue,  3 Sep 2024 18:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thaumatec-com.20230601.gappssmtp.com header.i=@thaumatec-com.20230601.gappssmtp.com header.b="Rswcbpwz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EB57886E5; Tue,  3 Sep 2024 18:44:36 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C0B688B64
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 18:44:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=thaumatec.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=lukasz.czechowski@thaumatec.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2f43de7ad5eso70476351fa.1
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 09:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thaumatec-com.20230601.gappssmtp.com; s=20230601; t=1725381874; x=1725986674;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SwZPVfpTlGBMmqKzZrpqUyjuo92nxpmyx16Vro+ppvk=;
 b=RswcbpwzE20sNRRQLDLHSMcsWgQz11FgEO/pYchD3BBdZzRbj4UXcXzV6F/bY5a5RJ
 0FziKl/3oKZ1NtuM2lYwP/cRDK4IrfoH97ka8EhxJCy+h7OMNqaWkzmgbhfZtmKilJGA
 JCuDO7g33nyE5dqbQHm8oCuQf2GMOLFjHpVdK1Y4rvSJIxkpbCYO2CR8sU5vr4fNnUi1
 mGyHKmRsOBAk6SoJOA5Sh55/6HGt/pKr6+TDJscSE8KsjbJ8nrdP2NGokllPtwtZLVAs
 H+XV2lfHdhcMiNUjyy10S2buU2l4zWin8zBsxCClD6MPL6kEiq3og8KdecVWQfawdPdN
 qQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725381874; x=1725986674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SwZPVfpTlGBMmqKzZrpqUyjuo92nxpmyx16Vro+ppvk=;
 b=vq6sRIm7eqe5x60eSXTJYkRnPgClP9PBp+c5l9FXT4VOvrNQUoByGRG1R2+vfjLP5e
 qZuWToR3/gZK5+PbLoZc0lnuJBdZlBpWqgLay1LvmVGs3c/YRPPi1GCy2BMLY1ZcTdBi
 6hlrq20b9Fjs2kQw+Xz3RZg6/whJrTqe6LMJmKQWz9IKSFPMjgkN/1UWF5quFOIAIyBl
 RooVHAaQ25yne0I/5y5v1wCyi56mvMMupNTcDd0DhWvdg5nWlorZkJQ1qaLoiia0BFAO
 4vOiA6GurQuR5b8Tdc4D98QC8qJtVBTRukdunIgo0VFAelLYvzE+MzjcrHxicJ5/pLAn
 nIww==
X-Gm-Message-State: AOJu0Yxw9RmoJtwlfPlz5z1RrBGCcKvB5Jsz68+8i7gxQFXtLQ7GtE6r
 szoQYeTGXkQmJ9yiRWO0VilLYGiQECgzjNVBqswiBUFB9x9BVkt5IbIB76Fz6esk+Pe2zV5X9W6
 P
X-Google-Smtp-Source: AGHT+IFTpCcXsp7tjU9NNWBwxUjun41Y4H9CFf21itC7rCFobB4zVSGtDGIAPm1Fc1DMZgbWHCL04g==
X-Received: by 2002:a05:651c:a0a:b0:2f5:1fa7:ac3a with SMTP id
 38308e7fff4ca-2f62dc25bd8mr64829321fa.28.1725381873522; 
 Tue, 03 Sep 2024 09:44:33 -0700 (PDT)
Received: from localhost.localdomain (178-36-242-203.dynamic.inetia.pl.
 [178.36.242.203]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c24b5ad63dsm4177197a12.80.2024.09.03.09.44.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 09:44:33 -0700 (PDT)
From: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
To: u-boot@lists.denx.de
Cc: trini@konsulko.com, sjg@chromium.org, philipp.tomsich@vrull.eu,
 kever.yang@rock-chips.com, quentin.schulz@cherry.de,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>
Subject: [PATCH v2 4/5] rockchip: px30: Weaken dependency TPL/SPL serial
Date: Tue,  3 Sep 2024 18:38:57 +0200
Message-ID: <20240903163858.1155218-5-lukasz.czechowski@thaumatec.com>
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

Allow to disable serial console in TPL and SPL. Weak dependency
to SPL_SERIAL and TPL_SERIAL is also used in other Rockchip boards.

Signed-off-by: Lukasz Czechowski <lukasz.czechowski@thaumatec.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/mach-rockchip/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
index fc1b638ff01..47a6275d45f 100644
--- a/arch/arm/mach-rockchip/Kconfig
+++ b/arch/arm/mach-rockchip/Kconfig
@@ -11,8 +11,8 @@ config ROCKCHIP_PX30
 	select TPL_TINY_FRAMEWORK if TPL
 	select TPL_NEEDS_SEPARATE_STACK if TPL
 	imply SPL_SEPARATE_BSS
-	select SPL_SERIAL
-	select TPL_SERIAL
+	imply SPL_SERIAL
+	imply TPL_SERIAL
 	select DEBUG_UART_BOARD_INIT
 	imply ROCKCHIP_COMMON_BOARD
 	imply SPL_ROCKCHIP_COMMON_BOARD
-- 
2.43.0

