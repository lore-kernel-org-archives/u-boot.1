Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D1DC48BF6
	for <u-boot@archiver.kernel.org>; Wed, 21 Feb 2024 06:26:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 019388803B;
	Wed, 21 Feb 2024 07:26:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UKae8rhZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3DAC387E26; Wed, 21 Feb 2024 07:26:23 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69CA887DD4
 for <u-boot@lists.denx.de>; Wed, 21 Feb 2024 07:26:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so739944566b.1
 for <u-boot@lists.denx.de>; Tue, 20 Feb 2024 22:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708496774; x=1709101574; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0AkpK6kuSK+BHKjuimBb7NzmN2DKnhqzcGkb0bNfbw=;
 b=UKae8rhZBNhtknT24sASpwePx/vZfg7OOXdj5zLtddBiiwgxA7o2fIe81cm3qDhVNw
 /W9yfqzQfBjwefQ2OXevVirsqiubVyU5QN8x2XZz61bc9zjbKTdYF9jhQn+yLegR2RFv
 SN0gXAIiXvxh0R4xWVXWR632WhCT73kiBdn3tL7v4KaXNBtIdwuqMlH/WPM2S8LvBGmL
 VaRryYXzag0Dbg9qwELnUh79VpQdiEikFov6bNLa7P2ArTd6rVSoFFdydFCN199p/EXr
 n82yQOAgoHh4+stVbnNUXSDcbO02u9ztdlnbxjdAWMp9s4b+pCAsA/vaWDNH/BUqeL3L
 6pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708496774; x=1709101574;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E0AkpK6kuSK+BHKjuimBb7NzmN2DKnhqzcGkb0bNfbw=;
 b=VOaP359BE+Sc+iS7Xp+cZZVzmDrJlHxqqJpHphhS3Fdgb3BnK80QaFsdeCShmCezHK
 tydCHp7Y+6FthgpQnT1bZU5MiafBpLQOYLXZHMO8DcT9+V+FrjC9xW8POKcFpDQ3BTgd
 eS62j6FBtsYxdLO7KG4d1y/kqPzIMevVkmq9z3WJFeecuwnMpanEzeUyvBfRbpK0mJl7
 mJzkNL7bIsWEDNClGzo7CMlNSAi3pIp2PvXQEr3QU8NXdYaTJuOsujRgCTNWZ18KzsMO
 3jX8x2yLlrs6OBkb8A9jConMPRBH2ZCxK1Ii6nF9PSId9b8UX6H2iijEpM5wNgwYhos4
 66IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV7bhXqNNILkFX1aKQ3zzuers5ylnk4QwRbm+9V9l4mFHQJPh1XXqovgNKwUSpBfr7mTgGcBrTWROHqOKJUOI2frcwzw==
X-Gm-Message-State: AOJu0Yy0CRWf9Ux6lQ42HPpA0kOGBuYlgJrNK5K9uCpUVFFdI+/PoJQy
 YgHHrstEpTAHnTQ7qHp080UJYjiRxsIkUNai9Z2gZJEoTJjIV7Enymstw33UJcI=
X-Google-Smtp-Source: AGHT+IFu5gqlIfd3BMJqrFIMJQeDJ/UtzZf3hh35szKpBcMEJzY8XQBzgYzgZjGBmnCWpijI7Sz/Gw==
X-Received: by 2002:a17:906:6b0f:b0:a3e:cefe:722f with SMTP id
 q15-20020a1709066b0f00b00a3ecefe722fmr4541915ejr.54.1708496773612; 
 Tue, 20 Feb 2024 22:26:13 -0800 (PST)
Received: from localhost ([102.222.70.76]) by smtp.gmail.com with ESMTPSA id
 w8-20020a1709067c8800b00a3e9ea30a95sm2597371ejo.5.2024.02.20.22.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 22:26:13 -0800 (PST)
Date: Wed, 21 Feb 2024 09:26:09 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de
Subject: [PATCH] bootflow: Fix build error when BOOTMETH_CROS is disabled
Message-ID: <7f33a6aa-5018-484d-af40-bdb7c4e3a70e@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
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

The bootflow testing assumes that BOOTMETH_CROS is enabled but it
might not be which leads to a build error.

aarch64-linux-gnu-ld.bfd: test/boot/bootflow.o: in function `prep_mmc_bootdev':
test/boot/bootflow.c:549:(.text.prep_mmc_bootdev+0x1c8):
    undefined reference to `_u_boot_list_2_driver_2_bootmeth_cros'

Fixes: d08db02d2d3d ("bootstd: Add a test for bootmeth_cros")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 test/boot/bootflow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index fa54dde661c8..4845b7121c84 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -544,7 +544,7 @@ static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 				"bootmeth_script", 0, ofnode_null(), &dev));
 
 	/* Enable the cros bootmeth if needed */
-	if (bind_cros) {
+	if (IS_ENABLED(CONFIG_BOOTMETH_CROS) && bind_cros) {
 		ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 		ut_assertok(device_bind(bootstd, DM_DRIVER_REF(bootmeth_cros),
 					"cros", 0, ofnode_null(), &dev));
-- 
2.43.0

