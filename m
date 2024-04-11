Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF845C4345F
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 17:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE52E881F6;
	Thu, 11 Apr 2024 19:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LF/9AmRY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 130C3881FC; Thu, 11 Apr 2024 19:53:11 +0200 (CEST)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BC6A881F1
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 19:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2d9fe2b37acso362961fa.2
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712857988; x=1713462788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1AeII3r5MVcCQpaq1ln/8s1eOrE8HbiWZ4EfXHkUwfc=;
 b=LF/9AmRYQNSzsjf82hqELCEC7VbVioda9nI9/3KVwFshQvdUdZZJO7LeqYBtXgxvi9
 uyntU8XvnOomTIDDfq9K4mqDv1qoZZ1Yje20RNxSV7fe+0zo3daqUrHyeHD+Muz3F9R0
 aqQn4h1e9ZJsvTsCTVASj9+UPGRsYZLWq6UVfpCYxGLo/qAYLl6H4n1YDiG8RH4bljlK
 Nr+CHqO6u/uc3vaILp3W4WZTn8m3pvwEdfDa9/xOXymNC3xGX9lvEexmh++suuBXxe35
 XIrDTB9BELWAoihf+gvNHUxifR6ug82XFtZA/nrJk3iCuj7/6I9tkUc5Bc9MLzJvXzX+
 gtEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712857988; x=1713462788;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1AeII3r5MVcCQpaq1ln/8s1eOrE8HbiWZ4EfXHkUwfc=;
 b=rZtzJg5lJeg8I4/sZ3CJkQGGyQaWJ5TyH1rrceRgtSVBZfDqMVBl4upYTkhnHY8k/2
 oJCrDFzcZz8UtT+QpBes06xCgQH9+pGwo8w9km9mFDFZzrjIV4GU2IYmPyLwcCLwX1Jv
 uPBoEDv5KSHrb+b54Y8aabuv0Q1jHoBfFytCmCLCd+Rslm7G5RSfF+gJS2v7FF7Tvhlx
 n71a6NVLSFQlh2j2fDkn3YISPSXNfwf5OLFoBelMtTHiEO1pv6j3C7IxamA2ZCQIWnaX
 zdowLk7MM624eddcgOC6thZ5DrSUiCtca1Gh3jbJwYqdiOhbjE/oI3zRYMyQ5MU914Y+
 WtpA==
X-Gm-Message-State: AOJu0YzqJv6d0lDfSjlFjRmWLrt/7grfRyIwT66X9Bogyj6BGy5GZyFw
 cOylz6nita6HaspN7iOsCO40mJOhefaIgn2a2uoS6UCkBDm57ZKTHw38RYQ2wOA=
X-Google-Smtp-Source: AGHT+IEpuhL7tlq9uM0Eo3GBt7tbifZ1OaCQGlolOReFd81rGQJxAUG7NTRHaxb8ZZRNEh50cIsieg==
X-Received: by 2002:a05:6512:485c:b0:513:bc95:50c3 with SMTP id
 ep28-20020a056512485c00b00513bc9550c3mr302566lfb.12.1712857988153; 
 Thu, 11 Apr 2024 10:53:08 -0700 (PDT)
Received: from cymric.caleb.rex.connolly.tech ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a170906254700b00a4655513f0bsm951925ejb.88.2024.04.11.10.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Apr 2024 10:53:07 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] input: button_kbd: gracefully handle buttons that fail probe
Date: Thu, 11 Apr 2024 19:52:37 +0200
Message-ID: <20240411175244.937795-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.44.0
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

If a button device fails to probe, it will still be added to the uclass
device list, and therefore will still be iterated over in
button_read_keys() resulting in a UAF on the buttons private data.

Resolve this by unbinding button devices that aren't active after
probing, and print a warning so it's clear that the button is broken.

Fixes: e8779962898e ("dm: input: add button_kbd driver")
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/input/button_kbd.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/input/button_kbd.c b/drivers/input/button_kbd.c
index 74fadfca8bb8..c73d3b18be9c 100644
--- a/drivers/input/button_kbd.c
+++ b/drivers/input/button_kbd.c
@@ -33,9 +33,10 @@ struct button_kbd_priv {
 static int button_kbd_start(struct udevice *dev)
 {
 	struct button_kbd_priv *priv = dev_get_priv(dev);
 	int i = 0;
-	struct udevice *button_gpio_devp;
+	struct udevice *button_gpio_devp, *next_devp;
+	struct uclass *uc;
 
 	uclass_foreach_dev_probe(UCLASS_BUTTON, button_gpio_devp) {
 		struct button_uc_plat *uc_plat = dev_get_uclass_plat(button_gpio_devp);
 		/* Ignore the top-level button node */
@@ -45,8 +46,23 @@ static int button_kbd_start(struct udevice *dev)
 		      uc_plat->label, i, button_gpio_devp->name);
 		i++;
 	}
 
+	if (uclass_get(UCLASS_BUTTON, &uc))
+		return -ENOENT;
+
+	/*
+	 * Unbind any buttons that failed to probe so we don't iterate over
+	 * them when polling.
+	 */
+	uclass_foreach_dev_safe(button_gpio_devp, next_devp, uc) {
+		if (!(dev_get_flags(button_gpio_devp) & DM_FLAG_ACTIVATED)) {
+			log_warning("Button %s failed to probe\n",
+				    button_gpio_devp->name);
+			device_unbind(button_gpio_devp);
+		}
+	}
+
 	priv->button_size = i;
 	priv->old_state = calloc(i, sizeof(int));
 
 	return 0;
-- 
2.44.0

