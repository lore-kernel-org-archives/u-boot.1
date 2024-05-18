Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C02C25B75
	for <u-boot@archiver.kernel.org>; Sat, 18 May 2024 13:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38B3588695;
	Sat, 18 May 2024 15:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dowhile0-org.20230601.gappssmtp.com header.i=@dowhile0-org.20230601.gappssmtp.com header.b="a40CyhYM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FB2388695; Sat, 18 May 2024 15:06:46 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C118858C
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 15:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dowhile0.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=javier@dowhile0.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42011507a54so5655315e9.0
 for <u-boot@lists.denx.de>; Sat, 18 May 2024 06:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dowhile0-org.20230601.gappssmtp.com; s=20230601; t=1716037603; x=1716642403;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WbNbHz0JT/RhhNHKKpnWbtPQCGMazloPF21FxWSttDI=;
 b=a40CyhYMdbz+NSWGLVf1zEVQCG9/Kg6ysMR3dxjxDm6pLkS/WOOBgc4qpKW1B5Cl1H
 cCq4ozYqDrXexdL0OkF6R7YSHK0SEMx2L8lQvQ1oFmral5JHpXUiH4odeSBZf1Qp000o
 gmV3qUZg9MlO33iyNOYo4000X/Bj/jcLwSkLuC20qsx4quqPd4cf0RC6gmLyVAHhsV7d
 UUmWiQyT3IYQsmw4lkFoQkY/BWXQQmu07n2gzqRvWBqjAoI2Uw7ZvlkkezKp6umnSmi1
 03G/krmzFah2ytq768FF5qoOqO+fDtIIxLkzIa8pKwQVpxLtt0nKPBJnQ2zqG9jmHwk8
 qZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716037603; x=1716642403;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WbNbHz0JT/RhhNHKKpnWbtPQCGMazloPF21FxWSttDI=;
 b=Y259JpKK98IJAW0GXW19OtkfbvBaimbS/A2dJFRaWRK3UeP65uD14yiH4hA7ukuzJ7
 ZEROF0EvVhxZI3Ym8PyI6wKEVxIaIEmdNhv7zdRIEcQDoT9P7vrUVWGzySeEHmMFkjDV
 x7e/nF/5cRwJSW4w56KQCkEAXpXLpCFN8gjJF2ExDnA0rFnlUxe5GjvFxB0T7NDM2LTL
 6SUsFDcIspuLy53hBk+Gtsa8yq1XBWnztUSMo1/vrHnDsj2j+Jfhe4vPsYBPxJvhUDZB
 QWUYJT2HNFurgECOU4jchFCLHRAnt/18th/JTbjDXALTiOd1HNv8WQrfUFCdJ9FPg0jG
 s1cA==
X-Gm-Message-State: AOJu0YwTFkDHbR7r7WdinOFoLBhUMZ5fWcqoMvfMhZfaoHDtDx/JHQyQ
 yN9MiqrefGg7fY8XMMervPz1SOuavylF3qStX2RthGOJizV1AdUT0fwAGgWs+L9/a0KeaDLoY78
 c
X-Google-Smtp-Source: AGHT+IGa4ETb9DQCcI8NVfX+XetyXKEYviWv5F8k8N1LNfTpXjroREdmzv/1ZjBisEwg0XLfB6pw8Q==
X-Received: by 2002:a05:600c:3549:b0:418:f5a:580b with SMTP id
 5b1f17b1804b1-420e1a6cdb9mr13562655e9.18.1716037603225; 
 Sat, 18 May 2024 06:06:43 -0700 (PDT)
Received: from minerva.home (205.pool92-176-231.dynamic.orange.es.
 [92.176.231.205]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-420273cff03sm122048335e9.26.2024.05.18.06.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 May 2024 06:06:42 -0700 (PDT)
From: Javier Martinez Canillas <javier@dowhile0.org>
To: u-boot@lists.denx.de
Cc: Javier Martinez Canillas <javierm@redhat.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [RESEND PATCH 2/4] omap3: igep0x00: Drop unused SPI support
Date: Sat, 18 May 2024 15:06:13 +0200
Message-ID: <20240518130622.219031-3-javier@dowhile0.org>
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

There are no SPI peripherals in neither the IGEPv2 board nor the IGEP COM
Module, so there's no reason to have this enabled in the boards defconfig.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 configs/igep00x0_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/configs/igep00x0_defconfig b/configs/igep00x0_defconfig
index e4d25556e3f3..6df6c33e25ab 100644
--- a/configs/igep00x0_defconfig
+++ b/configs/igep00x0_defconfig
@@ -82,7 +82,4 @@ CONFIG_SYS_NAND_OOBSIZE=0x40
 CONFIG_SYS_NAND_BUSWIDTH_16BIT=y
 CONFIG_MTD_UBI_FASTMAP=y
 CONFIG_CONS_INDEX=3
-CONFIG_SPI=y
-CONFIG_DM_SPI=y
-CONFIG_OMAP3_SPI=y
 CONFIG_BCH=y
-- 
2.45.0

