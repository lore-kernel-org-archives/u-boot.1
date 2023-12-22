Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB7DBC4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:07:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76ADE878B1;
	Fri, 22 Dec 2023 22:03:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MpvO8OG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87D63877BC; Fri, 22 Dec 2023 22:03:48 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B19C58770F
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40c29f7b068so22130595e9.0
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279024; x=1703883824;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=id6CAVWn/WV2uFwvBbLCoWgM2eQk2AHpMTRuSOsMmCg=;
 b=MpvO8OG/keM9MgJshWgKug6qkhuwQJOfbAmIMPuLRBG5aeV0r6w6nM/LOTl4r+4U6h
 GtkvaxhjjuRznn+FwaeLl9ChX5V+Cy0Hp+0KL8f74DB0su2SBO9gizl5naQr0is+2PMw
 Mvzx7XZz6Uh0mztTBJEmT6eiCx7A40Ulpxjwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279024; x=1703883824;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=id6CAVWn/WV2uFwvBbLCoWgM2eQk2AHpMTRuSOsMmCg=;
 b=HpOxcjtD7Sid1O6NMjQ9tn/3WXiTkxwYIevE9C5Bcy05UOhfqzR9jzdL65JDW9ok0c
 GlT7Hp4ZxGv3vWmO3l94uj57uR99H2vccJ2M4GRoddKXUf122zBlaNsy3TnC5RnbLeXz
 C4OeBiawG7b3lvuAsByN1I/I0te/VJo10FWRI6X/4z7YRqw+7U8iocrj+aPGuEfW84Yf
 2hFiBUVFv+FawB5QWrkWxLkGAZJfAfWVxZQljXkkj/d8PxUULWokvBR9dHDXZFA3ud2T
 5qk7duLnIyWXu11RBJkihe/9LuDgg7tsMXTSd2nW1SN6cX+vylAZ59MPFiYydEtFZwVx
 6Jng==
X-Gm-Message-State: AOJu0Yy/CDndrpMIYn+6MSZ+qFUzDsLRzbia0ufUeT6OFtFjpxad9vTt
 Ficv4aOaTHJ9+hAmP3eYc4XUahmBz+6cgrNB68tSRyC1iBY=
X-Google-Smtp-Source: AGHT+IFOxC7bTdkjgDqsF860QU3T20OZS5j1XtShNIFbdI421W/vcAdVQ9h5A397IAuKPigv4+QiiA==
X-Received: by 2002:a05:600c:3547:b0:40c:2c34:8fb5 with SMTP id
 i7-20020a05600c354700b0040c2c348fb5mr1042794wmq.27.1703279024289; 
 Fri, 22 Dec 2023 13:03:44 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:44 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Edmond <seanedmond@microsoft.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Roger Knecht <rknecht@pm.me>
Subject: [PATCH v13 23/24] cmd: Set modern hush as default shell
Date: Fri, 22 Dec 2023 22:02:43 +0100
Message-Id: <20231222210244.91830-24-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
---
 cmd/Kconfig | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/cmd/Kconfig b/cmd/Kconfig
index e25578cde3..26aeeeed03 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -27,21 +27,17 @@ depends on HUSH_PARSER
 
 config HUSH_OLD_PARSER
 	bool "Use hush old parser"
-	default y
 	help
 	  This option enables the old flavor of hush based on hush Busybox from
 	  2005.
 
-	  It is actually the default U-Boot shell when decided to use hush as shell.
-
 config HUSH_MODERN_PARSER
 	bool "Use hush modern parser"
+	default y
 	help
 	  This option enables the new flavor of hush based on hush upstream
 	  Busybox.
 
-	  This parser is experimental and not well tested.
-
 config HUSH_SELECTABLE
 	bool
 	default y if HUSH_OLD_PARSER && HUSH_MODERN_PARSER
-- 
2.34.1

