Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D73FC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04DDF8214F;
	Wed, 19 Mar 2025 15:56:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="S6PQVK6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C5AA8219D; Wed, 19 Mar 2025 15:56:48 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E6182786
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d07ca6a80so22186135e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396204; x=1743001004; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=brx/aHAAs3Dm9RDTQdUlADKEVIpMZCYu3grS7WXHRzc=;
 b=S6PQVK6j6shBgc2hF8X+IVYf0vtef0nN9X/DbSo6e6NpyyLOhBavTKZN8KsVv9etYz
 gI2+mOBes3Uwv82E7SbD1kmiQ1wJ9610Vz0t+ONOE81HCZOa9crL3Zls8Pg57LVTdHMf
 qujTMYy8OwZO/fgrAi9rwGk1HLd0SwUk3iR00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396204; x=1743001004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=brx/aHAAs3Dm9RDTQdUlADKEVIpMZCYu3grS7WXHRzc=;
 b=oSqO/g4eQ7b1W1UF3ROMZ7XyNkhxkR9tM0eSK4cMbdpr6EOfBf72f/IyxmSgGKlXGe
 P5yCB1Hl34HpfhGXFGRQYMc9bL3xrtDr6wKiJQvI4HCnhORm5ss3Sxh9ATc4t9kVHyuS
 8IJsYV/IDuwy/5wvzd2+0V+BtV3n4hMZb7S3HKwKscUus5NqsROxYew8+yiXLD4zBKba
 f1LK4Bn4wFUL79yUgZFnO6EpxPUff4o0Yt39TMGeGnQ7kB+w6XD5zd+14fF4j8pYpl+q
 0fVQTHjPdnW26WKMeF4BpiBIk8+rCtSsa5ua1b4uOt8JMRqQJOqmGu1o1uf0KAH3qDQV
 YPgA==
X-Gm-Message-State: AOJu0Yww1NaSdwa7DQTEgYPi8g4Nd4gIKSnEp9CqDRAE65L/cAn1npeA
 qgHuYaFxEHmuMfwbgW4wW+PBiehlDpJPkd0J+GZW16wam8qbAHJY52qRqxVTwB76P3J08S7WBA4
 =
X-Gm-Gg: ASbGncvj6treILL1vcNnNx3i7DdReXMF2hUvn7EuIGfVjC4ncrumYHnCfgtQIi/K27N
 /Or3x7n/dO4kHl3EjnyDXnuMavXTj8gNRZat3kn3MzhCW5b3mTLcguTNGtTGdxJ9/88eGSgnj/x
 08EIT1brI0qDBlUGnvuwWvY75dk7JLnlDt46/cVDN1ipJNFAN2SEIXqu8HI6/RMQRfp8Ce7RyPc
 4CLq8S0AsVL5jZYsWYOMkMzWYvqHE3CS7JIYdmdf54+NPbxMzotANrIdR63bznp1/Z6PKDIT9vx
 Ai9E1M6JyVgsvmp8khOCugwuMVKLast78BjjcaYA5g==
X-Google-Smtp-Source: AGHT+IF9RZWDjul/MxDdi8Yv87Tb4NlozO5hNCUJO8w/2uip/XB7CPxksw4JgTAC1zDQAouSbgq0hg==
X-Received: by 2002:a05:600c:1c19:b0:43d:16a0:d82c with SMTP id
 5b1f17b1804b1-43d437822b6mr24673435e9.2.1742396203866; 
 Wed, 19 Mar 2025 07:56:43 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:43 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 41/52] expo: Use a simpler name for USB media
Date: Wed, 19 Mar 2025 15:54:46 +0100
Message-ID: <20250319145512.2391122-42-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

For USB devices we use the string 'usb_mass_storage' which is a bit
verbose. Use 'USB' instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index cadffcf259a..986334e95e2 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -84,7 +84,9 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 {
 	struct menu_priv *priv = exp->priv;
 	char str[2], *label, *key;
+	struct udevice *media;
 	struct scene *scn;
+	const char *name;
 	uint preview_id;
 	uint scene_id;
 	bool add_gap;
@@ -101,7 +103,14 @@ int bootflow_menu_add(struct expo *exp, struct bootflow *bflow, int seq,
 	key = strdup(str);
 	if (!key)
 		return log_msg_ret("key", -ENOMEM);
-	label = strdup(dev_get_parent(bflow->dev)->name);
+
+	media = dev_get_parent(bflow->dev);
+	if (device_get_uclass_id(media) == UCLASS_MASS_STORAGE)
+		name = "usb";
+	else
+		name = media->name;
+	label = strdup(name);
+
 	if (!label) {
 		free(key);
 		return log_msg_ret("nam", -ENOMEM);
-- 
2.43.0

