Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EBCE77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D921680317;
	Fri, 20 Dec 2024 05:01:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f5KXA9Cx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C572280352; Fri, 20 Dec 2024 05:01:43 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 355C08036F
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a9cdcec53fso11872635ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667297; x=1735272097; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERHQk5VKujlOeMuFic6qwyZgbwfH7T3j0jLV1RDKl2Y=;
 b=f5KXA9CxinQPnvNC3OhpTbYC05ssEu3iHf3gTvo0o0qkJiv0b7UwNE725gK/rxS/zM
 IdECh0Xc/l+GqGebrwhAtHqI8JphNMmJRcT7JjVrvaQNQubZ09TgbTnEFHep6J4Bsrx6
 wK0ml7fwS2Lr1frjL9uQf5+UdZIdr4TKBXz0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667297; x=1735272097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ERHQk5VKujlOeMuFic6qwyZgbwfH7T3j0jLV1RDKl2Y=;
 b=pAo3K5ewlH7oyJpycIUm1OSc0runKqvS7z4f1XAeV4jwcWy/WWU78443PElaFPsUvy
 sOji0/GidkY21uj0imJVxHdjh6jZzCMQraYluBh1X1Hp+Q3GAQSaJ6kFnzySBxObwtQP
 qedwK9cTeEtt7wMxktbb75eNI1RN3JPwNW+DYFtiP5EF38tcZKyc0scSssZ3gv6QuEMa
 9OzIZxLiZMgKZf7bcxtXBk48nnB/kxicGOIiKJXaGGn8ssrSnTO5yTtixfP3xiwYSMEI
 PM+J0ax4ekdNmHv0wuXApLXypL4/TY2gFcxK9KWO60cbKTMJvXs0xq9/jJu3YHqMzmrQ
 LdWg==
X-Gm-Message-State: AOJu0Yy7H39GWbQ2ra/Zv98p7/2dKynJiODGeI8rW6Sd8RHfObufYOWD
 m55+BCmURM6mjj6nq27M24vkI1Z8WNrusf9aXD7Ute94TDTWEfhUMJSGEDs6cVO1zElhmIsv9Uc
 =
X-Gm-Gg: ASbGncvX6QNYWjUTm5X+sIzwSaMCgjQRcWtY96dBTaVHG8ChzKlNEeQsD7QdSCwBpHx
 xFJ8NbYU639MxRpdUBy9D/mDhb/Ln5bnjIgy/9790eR2B6ujsAn23FPQLSI1CFAQVqOOXryGq9/
 k4Wlbgc3ZFhonhYfc46HfN1aib1FngiBPkNjnvCQOQdzBWMYS63qGlXxdXUYA0q2JNJT2tfCdEm
 ZWiIHjoPAIZd7jeu+8lrpZs7Ae6kBn++oodTbs1SY/B61/F4UOJdQAbHztDi5ppw13m2UPS3xdC
 qN9uvJZKXS0Kshy9jw==
X-Google-Smtp-Source: AGHT+IHv7FDZo+L21DYQiqmYOvTCDvgmuUbLoWXY4ucei2uouzmwqCy+QzwoVB9yUxI/O0hgg0zYJQ==
X-Received: by 2002:a05:6e02:1a2c:b0:3a7:6f5a:e5c7 with SMTP id
 e9e14a558f8ab-3c2d14d23d2mr13582205ab.4.1734667296792; 
 Thu, 19 Dec 2024 20:01:36 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:35 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/5] test: bootflow: Avoid a confusing error condition
Date: Thu, 19 Dec 2024 21:01:17 -0700
Message-Id: <20241220040120.3245610-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220040120.3245610-1-sjg@chromium.org>
References: <20241220040120.3245610-1-sjg@chromium.org>
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

The prep_mmc_bootdev() function replaces bootstd's bootdev_order with
its own static version, then returns it.

From then on std->bootdev_order cannot be freed, since it was not
allocated.

So long as the test passes, all is well. But if a test fails, the test
system will try to free std->bootdev_order and this will fail.

Adjust prep_mmc_bootdev() to allocate the boot_dev order, instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootflow.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 35580cee90c..4d7d795cbe1 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -540,12 +540,15 @@ BOOTSTD_TEST(bootflow_cmd_boot, UTF_DM | UTF_SCAN_FDT | UTF_CONSOLE);
 static int prep_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 			    bool bind_cros_android, const char ***old_orderp)
 {
-	static const char *order[] = {"mmc2", "mmc1", NULL, NULL};
+	static const char **order;
 	struct udevice *dev, *bootstd;
 	struct bootstd_priv *std;
 	const char **old_order;
 	ofnode root, node;
 
+	order = calloc(sizeof(void *), 4);
+	order[0] = "mmc2";
+	order[1] = "mmc1";
 	order[2] = mmc_dev;
 
 	/* Enable the requested mmc node since we need a second bootflow */
@@ -605,6 +608,7 @@ static int scan_mmc_bootdev(struct unit_test_state *uts, const char *mmc_dev,
 	/* Restore the order used by the device tree */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	std = dev_get_priv(bootstd);
+	free(std->bootdev_order);
 	std->bootdev_order = old_order;
 
 	return 0;
@@ -635,6 +639,7 @@ static int scan_mmc_android_bootdev(struct unit_test_state *uts, const char *mmc
 	/* Restore the order used by the device tree */
 	ut_assertok(uclass_first_device_err(UCLASS_BOOTSTD, &bootstd));
 	std = dev_get_priv(bootstd);
+	free(std->bootdev_order);
 	std->bootdev_order = old_order;
 
 	return 0;
@@ -726,6 +731,7 @@ static int bootflow_scan_menu(struct unit_test_state *uts)
 
 	std->bootdev_order = new_order; /* Blue Monday */
 	ut_assertok(run_command("bootflow scan -lm", 0));
+	free(std->bootdev_order);
 	std->bootdev_order = old_order;
 
 	ut_assertnull(std->cur_bootflow);
-- 
2.34.1

