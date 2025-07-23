Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B115C83F1A
	for <u-boot@archiver.kernel.org>; Wed, 23 Jul 2025 13:46:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410C8834BC;
	Wed, 23 Jul 2025 15:46:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dfq4tHKK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D188352B; Wed, 23 Jul 2025 15:46:16 +0200 (CEST)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BA1382BA1
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 15:46:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2363616a1a6so59556055ad.3
 for <u-boot@lists.denx.de>; Wed, 23 Jul 2025 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753278373; x=1753883173; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y34BGiXE+FDCRVLooQ7vfctlBSrpdAF2GzyAIao8LtA=;
 b=Dfq4tHKKRy7TovtE3NdnrtLWG0x6IzkL4IqHobzjuOs4mVDJVnhexeEvv2FlFduL+w
 GAequrx3ivEQF9DmPBklhtyJcMmWnLDGZW3lW/rcuhp3xswAT+ygdUvYUztfnSFloAgy
 nYQUH/2akhhdzZ9Bsc+2vq4f9v1CSkPnQGazkZ/60xw9vy2YDIVjk38+rvYdfLj7QSpN
 MkbcAT0pjuOQgWN11GwtVLK4EQS5OBUFMsm5GPSg8xl8xf/5fqpXZbMjI798VxPBk0Lr
 z09V1whNCd2gaBKCuPtk6wuzl8eldq6UyK28ihqkrkFXFKClwUnzoYZRCLoVth1pVw5J
 Itsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753278373; x=1753883173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y34BGiXE+FDCRVLooQ7vfctlBSrpdAF2GzyAIao8LtA=;
 b=gVCmEpLfGOmdXTgXNA+zijplXhYfHs1fV445n7BxVQltt5ERBrIArxDz3aYeuajLFX
 SmHggpN/JJurBHfzqAdG5XssJSAUkrbasfSYExQk3KFUfvCajF2HfzmwT92aKY0IoWH6
 DJFxlA+Ea8MqTi75rwH3jmXZbjY0F7CbMf2FPl6/ODkAPo3lm/juCc61jdfK5Quaobag
 UmNpH+fHRsKqzHIhKIEuu4Piw+9sLR71+xMYa1zFhoiZAaeYEALhGOvwluuRmYER0BQp
 30YbiZovKr+v9yPxMRDb3YVp3/Pz/MWSnSv/ynqDGdvyh6OeHpoQiRx2XjY6ATNAgAP9
 N6PA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoW1j4ufhdvwP4rzSOvWqRFswrw1n35EB6KMkobYA6M4sr+UCdtWjTyEk6Ht67ryqdq84vNFY=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1ch5CgcZg/f6dVjhDD8tO0EZuZf8Ut5iFhQkhlkQN5OqhGumq
 XgPhXX9bYqH00PL+dhU0D1Ck2+RSr8uy1knMFzsiMP1TUbkQovVOSk/G
X-Gm-Gg: ASbGnctiwSQ1cu33OD2eaXbJrtUTxLiVFoB3g8Xi24eI5zE3eQO+acRLVz/xJ7W6Aec
 bCIy9VQIzEP1fP90zFCizkfQXoYqcJ9KwpNEEEQ4x8OnO/wh5lsjdEdV9F0lZaTzO5W3untcSIj
 pjNmj3mwdxqQwie1fCcjlOR1PAgK4lE39psKRpN6n8o67Cq9p9wV7TfJhdqQ0BaTCI2h2yqu6HA
 eisL1P6x3/rq8RX7i6vGANRPvqsFQGuOIjSGA2bu6I8I+Yh7Uw7wusI7HYfPKUhoLopqWUDpKR4
 TbU3HxA0kycEZyGzR0mO18WSicop7Y3OwdxWUTae0h8lBAUhz/0G1PVGPx7xRP71zd6naMgWNjd
 Tx3sUDaF2sk42oYNrDeb6BXmkTqK+eO0eHd5/
X-Google-Smtp-Source: AGHT+IGsHYEnFQGSK+Id6iWvBRMDr6o42RWqo4wNenzdyGIkD3A2XME3jKaYfPj7Dkoia/CYkQ0Ibw==
X-Received: by 2002:a17:902:d4cc:b0:235:880:cf70 with SMTP id
 d9443c01a7336-23f9814af1bmr34371445ad.14.1753278372860; 
 Wed, 23 Jul 2025 06:46:12 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:db41:d59a:1994:977c])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f3c999588sm7154595a12.66.2025.07.23.06.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 06:46:12 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: peng.fan@nxp.com
Cc: trini@konsulko.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] imx93_evk: Remove PMIC and USB header files
Date: Wed, 23 Jul 2025 10:45:57 -0300
Message-Id: <20250723134557.1972331-3-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250723134557.1972331-1-festevam@gmail.com>
References: <20250723134557.1972331-1-festevam@gmail.com>
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

There is no PMIC and USB related C code in this file.

Remove these unneeded header files.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index d84d56be5e1f..d62f94dc4189 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -13,11 +13,8 @@
 #include <asm/arch/sys_proto.h>
 #include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
-#include <power/pmic.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
-#include <usb.h>
-#include <dwc3-uboot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-- 
2.34.1

