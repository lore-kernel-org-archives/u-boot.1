Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE74C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 13:06:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1C0788659;
	Sat, 18 May 2024 15:06:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="qEcuQCHv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EBDF88687; Sat, 18 May 2024 15:06:45 +0200 (CEST)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8C48861E
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 15:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2e0a34b2899so22014891fa.3
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 06:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1716037601; x=1716642401;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DaP8uJlEN4pEUVmbOf+oZJtDx2RH/0NTgeiiWSTzU3o=;
 b=qEcuQCHvX8ym5DpTbS7ADevDFi05CHBBhXiUiDBL9lS4riYsZKF+YN2LUwGwWCXCVx
 r5EGwvfSCJYNFqLYiwBRMi09aScEYOV1ctFUl/KZak06sP77zOy/GnpaiotOUd321q+H
 Z44uW1HznvXs4bD0DtOlDUsiJXN2U5lckAMcOZMDsKB61VAJUx2plXwoUhTphLmtZYJa
 OIWOO2orz/Z1PpqkyHtg3rDdZ69I+CRg6w6KeCtYIE5RlSWZs5PdZzbSZ5iUZ4gVSh3C
 lCLXAclrjfrcdle1ZBnN3J9NRP3Kx5B4x9hT5w7DWWGMR8e8dkhTVV9TQMyEqtqpXIb0
 aEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716037601; x=1716642401;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DaP8uJlEN4pEUVmbOf+oZJtDx2RH/0NTgeiiWSTzU3o=;
 b=xFD2l45pRoEOSJSv9rlf9RXAELNtykMsprOPMGOMo6mZwmFRmnf1Uq1rLTlg4itOdw
 Tx6yGHGV55AGwPQQ07A9g20cZ1OjHSurWO1CdqRjuwTGNBTWtjfWGPF8X0MNA0+2D8cl
 zJEiCl1iE/cyNG8k7Q52Gnae5wziv7RcHquZOaCb1xLhAXaQwlhC3+KMGb+Pp8fq3NFz
 4wJMzDx/8VaYpX5IW5O4ZvglVK3LxcoafBRtTs2KZbw5RGVYUFU10YfJ5rY74wbiP+vr
 NUZhYgDQ5nxg9Tv1/tEG3rMxmxG9gMPKYdtp7eOLytHZ4KAIGLayg/IQOCTPFu9iPe0Y
 ICUw==
X-Gm-Message-State: AOJu0Yx3XAqAVFILzAst7AWCd1NHX2LWfKpXaUgdl4cIlvLrnaG2qI8X
 IEZxuSrRyMadTMyWRsSUPEF7yXTLO1LQpXZUk7L21QUepa2u4u5iaAxqh8Ht+stdGgRl2MQ5U1m
 X
X-Google-Smtp-Source: AGHT+IHYeN0YOm/3ts8rLZaIgdYb472wUVjjyiyOwiff+MMs9yZZvK/XoQRJK9/gxkyRj1PP78ZEAQ==
X-Received: by 2002:a2e:9e97:0:b0:2df:dea1:5378 with SMTP id
 38308e7fff4ca-2e51fe53141mr197396061fa.16.1716037601445; 
 Sat, 18 May 2024 06:06:41 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420273cff03sm122048335e9.26.2024.05.18.06.06.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 06:06:40 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 1/4] omap3: igep00x0: Increase malloc() pool size
Date: Sat, 18 May 2024 15:06:12 +0200
Message-ID: <20240518130622.219031-2-javier@dowhile0.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240518130622.219031-1-javier@dowhile0.org>
References: <20240518130622.219031-1-javier@dowhile0.org>
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

From: Javier Martinez Canillas <javierm@redhat.com>

The IGEPv2 board boot started to fail since the commit afd4f15a39de ("spi:
omap3_spi: Read platform data in ofdata_to_platdata()"). Because this made
the OMAP3 SPI controller driver to allocate its platform data before doing
a relocation, but the igep0x00 config sets this pool size to just 1 KiB.

Increase the pre-relocation malloc heap size to 16 KiB, as is set by other
OMAP3 boards. This not only restores booting but also makes it consistent.

Leave the SPL pool size to the previous 1 KiB size since 16 KiB may not be
a possible size in that constrained environment and is also the value that
is set by other OMAP3 boards.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 configs/igep00x0_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index 261f71acc1dd..e4d25556e3f3 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -1,6 +1,6 @@
 CONFIG_ARM=y
 CONFIG_ARCH_OMAP2PLUS=y
-CONFIG_SYS_MALLOC_F_LEN=0x400
+CONFIG_SYS_MALLOC_F_LEN=0x4000
 CONFIG_TI_COMMON_CMD_OPTIONS=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
@@ -10,6 +10,7 @@ CONFIG_DEFAULT_DEVICE_TREE="omap3-igep0020"
 CONFIG_SPL_TEXT_BASE=0x40200000
 CONFIG_TARGET_OMAP3_IGEP00X0=y
 CONFIG_SYS_MONITOR_LEN=262144
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x400
 CONFIG_SPL=y
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_BOOTDELAY=3
-- 
2.45.0

