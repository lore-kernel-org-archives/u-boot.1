Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6612DC4829E
	for <u-boot@archiver.kernel.org>; Sun, 18 Feb 2024 11:16:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB9587EA8;
	Sun, 18 Feb 2024 12:16:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W6gDKHYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D611387EAA; Sun, 18 Feb 2024 12:16:43 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DCAE87971
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 12:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33d2710f3acso863118f8f.0
 for <u-boot@lists.denx.de>; Sun, 18 Feb 2024 03:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708254997; x=1708859797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TI4Tf/hNcAsby/Pp+yVwfCS9vwyMAH80iobTZs6zTC4=;
 b=W6gDKHYPuloqEjkJ+CHyPIT8A+YzxcNs0ff7LuEUAqNXasrUSRWkN0D2JoeAV7rmdj
 gE+1vA37Y90NXCb9L04QNkyOvteNiKjLAFevGuu8v2CUaflSOfoVqfHg8WbF1ybdjjEz
 JpcNA0nABwPf2fT65ziGY0K3U2b49qQtr9a+zU/ySY0PAA44Hk82u63VxFEf+rj7Qguc
 z4O6BuSSqTUynNt/htImfFAILf6iUc9lEUwUBePKE6yZZqZMQIgu3yea5bkhErGwBIP6
 gUeI5LpsX6GRA6lRbvAJjG1lcMqZg/vF1Qe3L/C1DsfiSWwzB/u5RMG3/ZryO/xR7i0y
 +tCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708254997; x=1708859797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TI4Tf/hNcAsby/Pp+yVwfCS9vwyMAH80iobTZs6zTC4=;
 b=jVLRW2Igbh5uBkZGe03W5DMVmc6Ks5Y72f5SzZ4zmPoimVotYoWNR26X4e1FHEWD+K
 UBrDPKSq1hBbwM7H0vAbkf9tewrccpmGC+NPHQ88S/P/EesQCDtHUofltEQUDSSl57U/
 Og1z4wL9l+EITUTkoyg3Jon1oi0BM0MBKGvrCUX20CFpYvAGbWeFpDw2VEYR/SlC/GI5
 BprwdgWG05J4z6Hy3M1sAjhB96Xc/oWFe+tiyMVf6NOjSMfnERuBt65O5JTC9KDUbUcA
 GyA1f1o5qAFfEMGG3yYOMGcKfe+c3eXuOtU+kDvENFvzkDxqQ3mU80s3rFhtFNDPQUNQ
 9+KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSwKo6LD9gcGg5hOMs4qRxMJ1yXlnERcx8YJ3dycaLjihgyYi2mrcSTxyKZWzdIuAPHt8LyBAactLb8b62OoXoKtqXZw==
X-Gm-Message-State: AOJu0YwYuc71ednBs8j1uL3a6QqlOg7on/gYYCi46V9QMv6oqhqbEL4e
 4huZAjLFOjF4Z9S88l1yCslg7I4vRdhHgF0Xv1xDk7yxlxGah8M6
X-Google-Smtp-Source: AGHT+IFsOqkn8JJjxOnX6HIRrD41kRzFMRGRxYpXb/I63pl+MANcb0kmMnyRDf7utio4qUCVbbAw4A==
X-Received: by 2002:a05:6000:186a:b0:33d:1974:4ae8 with SMTP id
 d10-20020a056000186a00b0033d19744ae8mr7895139wri.16.1708254997284; 
 Sun, 18 Feb 2024 03:16:37 -0800 (PST)
Received: from morpheus.home.roving-it.com.com
 (8.c.1.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::1c8]) by smtp.googlemail.com with ESMTPSA id
 jn4-20020a05600c6b0400b00411b7c91470sm7727192wmb.12.2024.02.18.03.16.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 03:16:36 -0800 (PST)
From: Peter Robinson <pbrobinson@gmail.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] remove Broadcom Northstar 2 Target entry
Date: Sun, 18 Feb 2024 11:16:20 +0000
Message-ID: <20240218111629.849167-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.43.1
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

The Broadcom Northstar 2 support was removed when the
bcm958712k board was removed but the target entry was
missed so clean that up as well.

Fixes: d59bc09d829 ("arm: Remove bcm958712k board")
Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 arch/arm/Kconfig | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6b072be2463..9367287327d 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -699,15 +699,6 @@ config TARGET_BCMNS
 	  ARMv7 Cortex-A9 SoC family including BCM4708, BCM47094,
 	  BCM5301x etc.
 
-config TARGET_BCMNS2
-	bool "Support Broadcom Northstar2"
-	select ARM64
-	select GPIO_EXTRA_HEADER
-	help
-	  Support for Broadcom Northstar 2 SoCs.  NS2 is a quad-core 64-bit
-	  ARMv8 Cortex-A57 processors targeting a broad range of networking
-	  applications.
-
 config TARGET_BCMNS3
 	bool "Support Broadcom NS3"
 	select ARM64
-- 
2.43.1

