Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF9ECCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:32:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BC8A836C8;
	Wed,  1 Oct 2025 22:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o6WrUdBG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 174A28349B; Wed,  1 Oct 2025 22:30:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8A51836B8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7a7c1ecd433so161577a34.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350655; x=1759955455; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ixh8TU52mofV5VoU9esWAM0JDg7b+9zfIjXs8fOxyL0=;
 b=o6WrUdBGMCAG8ai2AoHCqxrK+EaR925OP8HHwLuFrjaXJJa8BxVEmWbRmPR4xZP6Nn
 Rr9Aoug1bRO7TYSwyYd5zzOquK9+HU+LXzB8zSOo7e/Yfy+5YLTbq1wAbiMZ3PzVYdRn
 D24OO7ME68J4cbSjOqULQA2nxwQ3qWU2iFAOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350655; x=1759955455;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixh8TU52mofV5VoU9esWAM0JDg7b+9zfIjXs8fOxyL0=;
 b=gWfLGULX6XiHr2yfpKtEVuTXqV5xa+5pod/YuJWACUQLhvx/9NyAAt2z+EhUBhatRT
 dZqHF2jft/pq5diBK0riuVwk6LP4kfZQVJJNKA0s+Y+WDqzwN/xfgPKfkvqiiuT1tpNw
 t6XwYeV0eqrxbS5SwgBL8ygKsk3QcAP4Qps+FPykm0PJrg39wpBpfo0/TTB+5vYX/O+T
 UHmJCxJaNE8T55OK5SyZheoibvYWPNAAOzKwBL9Ot6IbCVi9THaeyZDyhePjAVM8mq64
 Qy3O726d38dvnv88nxaTwEjI/+wd+MHXlZtRxG7JSBo9/JHc9ECIgtfw+j/2YIUtoubg
 NsyA==
X-Gm-Message-State: AOJu0Yzr9HYj75ChaUy86pahL9CxM8NpEL7GalOipmOflq+ucQ2/gSkp
 GT5K/Qtx0i8YBGTuHWzlIEQKVX7akaKysM/EjGP3bJ+LmMTp2WYWVv0zFupXMFa/K1d18gNuE9I
 rw7fSy6k=
X-Gm-Gg: ASbGnct6PVg5Nsp5uvB2yJ5Lh7Yg0AbTJkm5c88NZCAgP5P76bWNkuTWr4TmAFTmcaf
 7jxLtGFcHAFJDf5TYSQOC7kT2KFD9rT1DN/rZTb9WVSOrIejy9MRU81UlIE6Blt0Gc1yvSmSQQ2
 KH6nWTQ+zTODNxBbtiiP/PCLEEsDiSIv9Jd43JJjBotZeAIc29mrbffK2m2xPMzqKafNfUzL0jw
 gozT8b84yKF3AU8SyHTdDNo4odzQp8fLqCMIgiOXl8JnLp3kG+KRkbf23FjNgyJBDI6qocoIxPz
 MLZeNlG5QIPbB2Um1MPwm5vUVMUT/xfTy/VLKTqT+B7zoz4fT2qRJPho0/JFXbtZ5DchoSVM6rJ
 zeb5MhYKx8A9+oEOqwhHFchECYPZtE3xMScPKGZTUK3iiuSwXfVGG0OMDD0lK5tQlzR3VR0tFVs
 L8crcUsio=
X-Google-Smtp-Source: AGHT+IFvFIhgk5z4Sgi5NM+AJwZVhxfUM7UXNPz2VkoaAbUBCK1otaC/bETMSFFlxTXW91hoDwmx5Q==
X-Received: by 2002:a05:6830:6ac7:b0:7b0:6c2e:7c13 with SMTP id
 46e09a7af769-7bddc94c2e3mr3401292a34.16.1759350655530; 
 Wed, 01 Oct 2025 13:30:55 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3fdcf8b4sm122593a34.12.2025.10.01.13.30.54
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:54 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] xPL: Make NAND_SUPPORT depend on !COMPILE_TEST
Date: Wed,  1 Oct 2025 14:30:53 -0600
Message-ID: <20251001203053.2828484-1-trini@konsulko.com>
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

In order to compile NAND_SUPPORT files we need non-zero values for
various parts of the NAND chip that would be expected. Rather than start
to dummy this up in Kconfig, make these options depend on !COMPILE_TEST
to start with.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 common/spl/Kconfig     | 1 +
 common/spl/Kconfig.tpl | 1 +
 2 files changed, 2 insertions(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index cb7b4179384b..defc8bd6a8ed 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -977,6 +977,7 @@ config SPL_MUSB_NEW
 
 config SPL_NAND_SUPPORT
 	bool "Support NAND flash"
+	depends on !COMPILE_TEST
 	select SPL_LOAD_BLOCK
 	help
 	  Enable support for NAND (Negative AND) flash in SPL. NAND flash
diff --git a/common/spl/Kconfig.tpl b/common/spl/Kconfig.tpl
index a535b61ecd35..19ce3d92e65b 100644
--- a/common/spl/Kconfig.tpl
+++ b/common/spl/Kconfig.tpl
@@ -236,6 +236,7 @@ config TPL_MMC
 
 config TPL_NAND_SUPPORT
 	bool "Support NAND flash"
+	depends on !COMPILE_TEST
 	help
 	  Enable support for NAND in TPL. See SPL_NAND_SUPPORT for details.
 
-- 
2.43.0

