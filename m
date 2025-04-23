Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46045C369CB
	for <u-boot@archiver.kernel.org>; Wed, 23 Apr 2025 14:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E871807AE;
	Wed, 23 Apr 2025 16:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GGjhtKDx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5377A80944; Wed, 23 Apr 2025 16:49:18 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 230388059D
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 16:49:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2d4f832069cso2796194fac.0
 for <u-boot@lists.denx.de>; Wed, 23 Apr 2025 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745419755; x=1746024555; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BfCLfLfhK7L6zVFq3JBqYDPA1QPKYvunXv6fyKasL5U=;
 b=GGjhtKDxSpzkQNbCLwCdggSQSLw+t/h3dp7a+/ScdU//wk9Oa+JqPD7oLVLtPZBhkQ
 9DugU/BYi6y7JjfQv0IYdJOjH4NcMyljsfQZj7vXuoGzwppWmpCaEvbBOCwIrvFf+R/b
 wMDo1zQqcGZ8d+mtmcVGBx0/peLvqmm13tOIA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745419755; x=1746024555;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BfCLfLfhK7L6zVFq3JBqYDPA1QPKYvunXv6fyKasL5U=;
 b=Ay09TPhwhFLumc3EHYgr4LbY2g5mjfD/gBjLsPNcShvgP96/HITI15ZWXptmjS02OR
 LLS0OJ6pSqQho3bio3Z4A2bAVPA5gNVl/WdBbNWwYbhApNbo/h/K1Mej7rBPCuB1mSDt
 pVTl8H9YPibPEgDtIWVLsNUgNWdaCGBWvdsHI69+G/Dw81100XOSFpcO9Fll9qO9nLrr
 QvtBlOtKq76GccYXPUQ/1a/6U2cWDVOdRdJZbkmL65uv4INXl4t+XY3KQKQxXzUlIJtP
 Jn4xWG1VyNfmE02oUGxr63TpOky7A4VPDfPncRLEsoPYceZkoJLCq5VqU3mRyfgbvktz
 qZmQ==
X-Gm-Message-State: AOJu0Ywmndz2gEd2sFSIxGKns0zFwyH2x0Q2tXd/8SaAT6zTr361RJQ9
 pWmjrfdX+cqHp6CyMhP30AjYN7nqWEOI2i8rxCFhUyb8K7MjjPUeej2B/m9y7VfVvmXWPHBS97J
 Om6I=
X-Gm-Gg: ASbGncuEaQkfArnfhuzhH7KK53luruKcEpFncOnNLp12j+3DXtNeKO7ooNKyZQ/NTgY
 L59xc+a3+CsAoYNqL30pztOnjb3YfQDg1ULiBw59Mw/RnH6Y68JElVLYXZHDrIVzIi3R56olVaI
 sYR/fR6kOuDBRHoFmpP1Gvd2JqJruP1yhlpj7U/zN1KnwJ1ao8y8W5XiG7I+9NIWT65WKi5Gjkf
 EwqisSZtO4+2yfz/VUYQ7+HKv/wj8PGzxwSQTWTtrRn4kuaMhh8ALPdsKRzOBB/EZ/TX3K53khW
 s+F7TXHh0JXM0uXq9jlZnYRKaTUsyHrjfnxmsS7lB/wUoMn+KBDNMtchbDchwuP/Off/AwbgdMv
 PZFxg
X-Google-Smtp-Source: AGHT+IFX06+QPhxun/WKYuy7kQPG/oWnrC0/D5sgwz4LlEbRW09a2d9zts8quUjVEjySYCqwTpLd5A==
X-Received: by 2002:a05:6871:bb0f:b0:2d5:2955:aa57 with SMTP id
 586e51a60fabf-2d5295619aemr10015782fac.0.1745419754882; 
 Wed, 23 Apr 2025 07:49:14 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2d52135b8a8sm3227756fac.15.2025.04.23.07.49.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 07:49:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] bootstd: Rework BLK dependency
Date: Wed, 23 Apr 2025 08:49:13 -0600
Message-ID: <20250423144913.3918472-1-trini@konsulko.com>
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

The bootstd code itself does not have any dependency on BLK in order to
build. However, in order to minimize size growth of non-migrated
platforms, change this from being "default y" to "default y if BLK".
This will make it easier to begin migration of platforms which do not
have any BLK-class device but do want to use bootstd.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 boot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index fb37d912bc95..0e796a71a82c 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -427,8 +427,8 @@ config BOOT_DEFAULTS
 
 menuconfig BOOTSTD
 	bool "Standard boot"
-	default y
-	depends on DM && OF_CONTROL && BLK
+	default y if BLK
+	depends on DM && OF_CONTROL
 	help
 	  U-Boot supports a standard way of locating something to boot,
 	  typically an Operating System such as Linux, provided by a distro such
-- 
2.43.0

