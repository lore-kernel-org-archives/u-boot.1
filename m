Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14DC7C3064D
	for <u-boot@archiver.kernel.org>; Wed, 26 Jun 2024 16:01:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2050688574;
	Wed, 26 Jun 2024 18:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aQL5FTsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9371C884C7; Wed, 26 Jun 2024 18:00:15 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8018855B
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 18:00:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4248ea53493so27310475e9.3
 for <u-boot@lists.denx.de>; Wed, 26 Jun 2024 09:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719417612; x=1720022412; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=aQL5FTspN9pL0chNoKbFJHRtOUvm/nWdZFvnJvfwGyxGFU3BaR+7Pb4zvrGr4cH85n
 SYzmLbh/V79yBbtf3JtaiwyPd930EAwvv3vZ90CjLu/JeSE3mTN/sK+5P72cDvcIg+He
 conjdkKRCiYimSvVosv4XT1wMb9fFzQA9j0vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719417612; x=1720022412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bJXFsCW6LCl1bXkmZ8sKbXEiUPqgjCbPoT+lGmHDHLY=;
 b=cy//eESnK4e0hDClKilaZ/S5gWjH08ICy5mWXIMkWI0igYqden+1uoL0EkP5ZiZL4r
 +fbYuyKNMJsn0jOlVn9nbJ+mxwW/CoVY5RgXN1gxP+QVxVCTfW1NjniVv4JN592+Lwqw
 dTJE5iGv2tXyTT8WBOn5nkmVxbpihrl6Ln20z74Cwhl6ZUQDCuSlzuyYkwgbno0IKCEA
 +80tNLXAjOprLojLBkheeAYVfegaubW1SqUvb2hWQ4rNN2tzs2OS2KuI9dMvZqwzInv9
 BWVKHa//Hy6KDCzkQBpm834Oxmy74GfC1Ox9/vE0DOnxZz1FzhXkM3pGHL+vIAN5Dm5q
 YsQw==
X-Gm-Message-State: AOJu0YxMKdvbUqfqSqENBJ2ylMPWDr+6I2TQKcM4mx1Foytcr4HdodA9
 dEeOpswj5yoYXR9rihp+E8pb5yG04/wu7fLWcVJXfHv8fN3GbyVWodEIx7lzMyXBZRph/SjKEe+
 Jbg==
X-Google-Smtp-Source: AGHT+IG3mYUR/H3ckbcSlWSpABLSiE68kn81Lp07psRTVQx1aqtDCBJEVPHn71ZlWuimzIoXsjl/oQ==
X-Received: by 2002:a05:600c:1d24:b0:424:917e:f394 with SMTP id
 5b1f17b1804b1-424917ef3dbmr75354985e9.31.1719417612713; 
 Wed, 26 Jun 2024 09:00:12 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-424c827507bsm30753715e9.22.2024.06.26.09.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 09:00:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 10/16] power: regulator: Handle autoset in
 regulators_enable_boot_on()
Date: Wed, 26 Jun 2024 16:59:39 +0100
Message-Id: <20240626155945.278640-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626155945.278640-1-sjg@chromium.org>
References: <20240626155945.278640-1-sjg@chromium.org>
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

With a recent change, regulators_enable_boot_on() returns an error if a
regulator is already set. Check for and handle this situation.

Fixes: d99fb64a98a power: regulator: Only run autoset once for each regulator
Reviewed-by: Jonas Karlman <jonas@kwiboo.se>
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/power/regulator/regulator-uclass.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/regulator/regulator-uclass.c b/drivers/power/regulator/regulator-uclass.c
index 77d101f262e..d9e1fb68295 100644
--- a/drivers/power/regulator/regulator-uclass.c
+++ b/drivers/power/regulator/regulator-uclass.c
@@ -518,7 +518,7 @@ int regulators_enable_boot_on(bool verbose)
 	     dev;
 	     uclass_next_device(&dev)) {
 		ret = regulator_autoset(dev);
-		if (ret == -EMEDIUMTYPE) {
+		if (ret == -EMEDIUMTYPE || ret == -EALREADY) {
 			ret = 0;
 			continue;
 		}
-- 
2.34.1

