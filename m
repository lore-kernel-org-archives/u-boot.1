Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A366C71159
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 14:54:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA7786E36;
	Fri, 18 Aug 2023 16:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ee77YWvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8999986E37; Fri, 18 Aug 2023 16:54:19 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 015E786C7D
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 16:54:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe24dd8898so9737755e9.2
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 07:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692370456; x=1692975256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uakBAi0ldDp+Nizsfdv/En1JU67RfcIpTZ8Kv3L16mY=;
 b=ee77YWvXMLZAZad2QPy2rdV1dcpV/YhiRoHkX3f9cErbWwJTjeFsW3R2eQPYHFAt9B
 /ltylu0e1yS1PevgZtWA0USEyqyizil16A068UXCAPeczFWgUo6xW0j2BSfWsUrp0m6Q
 uoJ/pfDluINrFIgzsD1+fytPSAvFI6mI+bpd72p2vp9H45P+QIG7rHJoWvgemOxqcdwE
 inl4nJ70yKW2oZYzl2G8qHdfFD10AuyqU3qq/72dg/t4j2FC/A7ZPnoMpCYc6tbdJI0/
 iOx2dmj3Fcq6Bp53Sb5lEBNxEZD11b3qancWc9/kD7NBEOxJ4vSpRBZXqsguEEPitA0J
 PWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692370456; x=1692975256;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uakBAi0ldDp+Nizsfdv/En1JU67RfcIpTZ8Kv3L16mY=;
 b=lPZwOTS+vDeFTvy3wApU2qjfvFylz3bil9L3nJg1Iv/wW1bp01ATr4ACrdS7RU7ShA
 M9KAqI42VaU5xkM7OWZKajWNeQA1IyfaPtEOusFFb8DRySTfqVNLq63opeIrNX07p0FM
 +KvVg9ecG6hVtTO0lOQYYmjgi2bT4hL/Yv4hQ6MMJ7ayrtsjABEzVLENMK64bRx4xavd
 smMuh/i+XTiK1P6se49vdsWMzXluA1zpjPFlP6L3pNfWOpAvJZTpRd7cyz9lYwVPvSHj
 oyIbZelGjyoCANYXjX77P95YgT0ggwUD8anO1JGx4VfoGgkfCytmMwkLHnjrtdxO6BYF
 DSXA==
X-Gm-Message-State: AOJu0YwfiEbjuhrafG4WIhU7W6faYud8HKHeVeSk45G2DGGRlDTug+XQ
 wpUvof7WgHgemXmidGfCcts=
X-Google-Smtp-Source: AGHT+IFf02jjT1JYnVq6Xf/H4yGV0ak25Vg9uccdBF9g0j6++Stt+NArWE5/9nkkpmjnCqWE+jNcdQ==
X-Received: by 2002:a5d:4a8b:0:b0:319:6ec3:79c7 with SMTP id
 o11-20020a5d4a8b000000b003196ec379c7mr2218329wrq.36.1692370456129; 
 Fri, 18 Aug 2023 07:54:16 -0700 (PDT)
Received: from morpheus.home.roving-it.com.com
 (3.e.2.0.0.0.0.0.0.0.0.0.0.0.0.0.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681::2e3]) by smtp.googlemail.com with ESMTPSA id
 t24-20020a7bc3d8000000b003fe195cecb3sm711475wmj.38.2023.08.18.07.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Aug 2023 07:54:15 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH] boot: Fix reference to bootmenu doc
Date: Fri, 18 Aug 2023 15:54:10 +0100
Message-ID: <20230818145413.280037-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.41.0
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

The Kconfig references a readme file that's moved and
converted to rst so update the reference.

Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
---
 boot/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index e8fb03b8016..86c2787dc53 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -1439,7 +1439,7 @@ config AUTOBOOT_MENU_SHOW
 	  This enables the boot menu, controlled by environment variables
 	  defined by the board. The menu starts after running the 'preboot'
 	  environmnent variable (if enabled) and before handling the boot delay.
-	  See README.bootmenu for more details.
+	  See doc/usage/cmd/bootmenu.rst for more details.
 
 config BOOTMENU_DISABLE_UBOOT_CONSOLE
 	bool "Disallow bootmenu to enter the U-Boot console"
-- 
2.41.0

