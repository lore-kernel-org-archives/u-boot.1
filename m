Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81917C25B48
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 05:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F03487B3B;
	Thu, 26 Oct 2023 07:31:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rSs3bZ4e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F35D187B2C; Thu, 26 Oct 2023 07:31:49 +0200 (CEST)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26B2387B09
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 07:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-51f64817809so54607a12.1
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 22:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698298304; x=1698903104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCUBljU3l7bLi+2Mof6yKcdAJGAgEsp6V13IE4RoUsg=;
 b=rSs3bZ4e4ihjZQtAf+mbfgRGVrkTNLFeiL6/7/5+e7gGKdYv1gA6+D3gqUD8csoy5a
 kgAwuiar+4WGZubt7+B6s5RY2s3AdR9ZQhGq7CkWJRngPf6JHKylddoRa3oMNysxGTui
 /1GQI1GTB7RBuFXq/YncAUsi7kQyUlgOzESIgL/04t5p3yBwTpBogsSedYT4xTYIJ3nG
 17WVB6KpxQHZ8efEuDS7HEWDaEDXds7TOtGPGTLdgrNbJz36ndpASLaqejgN7bHQh1W/
 R2EoAxHR5tdw/RjH8Cnq2dkTvyAMo2ofP5+YsoJKKb5hCmWdH6BtacM2Tr4hocoLpQgQ
 a+yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698298304; x=1698903104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCUBljU3l7bLi+2Mof6yKcdAJGAgEsp6V13IE4RoUsg=;
 b=EhhMgtTdo2IQlJq5klFQYKCI8eyyb31JJ0+wa+A3r9LoAexXOAJF8o0aNBUJOpou5W
 YrOpki9wFGxMrYBGU5uQm0pct7rCPY+iUE5BZTnJe9o/Gh0Hsw0HxiAdYmLpUMOeM77P
 0Yis+ksuwnZ7k7yuGrBb6d6sgjzuoUntEaFkBxwauozi8p4b9BBwqcELXx8y5azffnnM
 vhpuayYSw01gjMznMexPhNSKzuf6DewzsyRTRe0F3hsuN+P7Xje08Nb8Uo6S0ZrsmQXN
 nqpmLBUHWkkUCMaJF8T8FkCNDUAL9botmM7G9/CWw7t8w/b2U4yqhSmTHXEEi+GTkVid
 +6XQ==
X-Gm-Message-State: AOJu0YwTeCHsoPwkI3OULRmL+laH5P6Jmy4Gb5nRryfezxA6fgE9ukc5
 XoLYbDPfgF7yGONvpmDa/0A8Ww==
X-Google-Smtp-Source: AGHT+IG620YoZ678NwRJsYtK62wEVXIMqWr0iO8dl7Cj0eVzYT8qBVj+aIicVeDsnOtTTmrPKAX1fA==
X-Received: by 2002:a05:6a20:e68c:b0:15c:b7ba:e9ba with SMTP id
 mz12-20020a056a20e68c00b0015cb7bae9bamr17078542pzb.0.1698298304383; 
 Wed, 25 Oct 2023 22:31:44 -0700 (PDT)
Received: from octopus.. ([2400:4050:c3e1:100:bca9:3af7:89e9:80b7])
 by smtp.gmail.com with ESMTPSA id
 fa13-20020a056a002d0d00b006c06804cd39sm440715pfb.153.2023.10.25.22.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 22:31:44 -0700 (PDT)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: jbx6244@gmail.com, u-boot@lists.denx.de,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [RFC 11/13] fs: remove explicit efi configuration dependency
Date: Thu, 26 Oct 2023 14:30:50 +0900
Message-Id: <20231026053052.622453-12-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026053052.622453-1-takahiro.akashi@linaro.org>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
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

Now it is clear that the feature actually depends on efi interfaces,
not "bootefi" command. efi_set_bootdev() will automatically be nullified
if necessary efi component is disabled.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 fs/fs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs.c b/fs/fs.c
index 4cb4310c9cc2..70cdb594c4c8 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -791,10 +791,9 @@ int do_load(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[],
 		return 1;
 	}
 
-	if (IS_ENABLED(CONFIG_CMD_BOOTEFI))
-		efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
-				(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
-				len_read);
+	efi_set_bootdev(argv[1], (argc > 2) ? argv[2] : "",
+			(argc > 4) ? argv[4] : "", map_sysmem(addr, 0),
+			len_read);
 
 	printf("%llu bytes read in %lu ms", len_read, time);
 	if (time > 0) {
-- 
2.34.1

