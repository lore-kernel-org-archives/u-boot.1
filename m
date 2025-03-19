Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD291C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1269881E13;
	Wed, 19 Mar 2025 15:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gRlWU7Kx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C430A81EC5; Wed, 19 Mar 2025 15:38:56 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F4EA81E13
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-391342fc0b5so5721647f8f.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395133; x=1742999933; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HXpLgtjDQYuJuz299qj3qncNcp++jBzRXhOnSAK7jMw=;
 b=gRlWU7KxNZByYCVCtk8SAXQxm8+xAoIKTp6iM+xE3YgHNp4Lbear8dFnCQweQ2fNI+
 79apLLF11+JEBKZ1m3VI1xJB30E83JLNL1OCef4wwwE7nfQqhD2wFCt6QZZmMvZtSODt
 oogk0MEOIr0Ra5ZU1/p+VgjSe+78kWrqxWVuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395133; x=1742999933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HXpLgtjDQYuJuz299qj3qncNcp++jBzRXhOnSAK7jMw=;
 b=ubwil98HJ/6hTMWCuGqoodj3sh6XiFriYv7KjiuAKoGNxFT6YxqT1o+RZ3FObUef8h
 TgjimBs7ypZLo5AXZTiQH7/imifbvgoxZhjvJqY22M+adI1GhYZWJVYybc59DK7VyOhP
 7lZCL3tdN9E3HE5EvUi28uHPHa8SAzm02MLWgnoNtjBMmVNgkjBZlr2nZYRgysRvkZcD
 Tpru0d7SnICcjnMu5YHueD+tgF94nT7QWbEoPQ8Hk/i4YewKVXzwhNVm/Yk1BtQUnDSu
 va6/UTcHAl8RohDiBIwTWRy3+0JXAq894t82zvArbjPovGFOsE+8yPgquW0dKvDMthya
 FppQ==
X-Gm-Message-State: AOJu0Yxnz+L4Kkgo1S1HaFRHLhC0p9YtVSYACapa1dKFb47HVJsZ9vl/
 E2rmmEMNGvrkRWqi1zZAS6THjYulA4k72bZHXQBimaHB7B2M5MrbRG9U+aiuJDJEwHWnUAKcKyQ
 =
X-Gm-Gg: ASbGnctdDQBSABpCr2CW08wRpiXs8OJsJKCz0dh/oRSIhJbFq30zeZA4PQWmmlpjruS
 sKB2jEQRrH/qkLXpNSBC94xrRXCM6W0nIO4uNefDdnQOFMbjEZTwDuw7/LFYgMlPItsy4ond6pZ
 iFhVBbf7W/TfA/WiV2b+xXOLGEB6y9qTIwior9Ljs6woIJynybIbcFMg/+0v2wpv5lqb15HPhGQ
 7ovhT/alZ6L/uNw6CLUmpoCSsQ9+yyHyeZNYqHP0s9dMWxbB0kBQ8+NBi6JFRYxFfTTNrmAoJza
 oLr7FHzcUm66nCBhyjx8NghvnJ5wNaOuqf7a9zTcD5NtiQyr+AdA
X-Google-Smtp-Source: AGHT+IEGb6V9unsF35ANhlVZQre6AMj1lrgwdpsDrw2mlJxvQroXQ+GdkzYiLEdCuVSp1zKiLvXDLw==
X-Received: by 2002:a05:6000:2b0f:b0:391:40bd:621e with SMTP id
 ffacd0b85a97d-39973b02ad1mr2106202f8f.44.1742395133147; 
 Wed, 19 Mar 2025 07:38:53 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:52 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/17] bootstd: Try all bootmeths on the final partition
Date: Wed, 19 Mar 2025 15:38:00 +0100
Message-ID: <20250319143820.2385092-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319143820.2385092-1-sjg@chromium.org>
References: <20250319143820.2385092-1-sjg@chromium.org>
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

At present when one bootmeth fails on the final partition, the next
bootmeth is not tried. Adjust the logic to go to the next bootmeth,
which is the more natural behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 28c606b0258..83a1d3a7c8b 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -198,27 +198,25 @@ static int iter_incr(struct bootflow_iter *iter)
 	if (iter->err == BF_NO_MORE_DEVICES)
 		return BF_NO_MORE_DEVICES;
 
-	if (iter->err != BF_NO_MORE_PARTS) {
-		/* Get the next boothmethod */
-		if (++iter->cur_method < iter->num_methods) {
-			iter->method = iter->method_order[iter->cur_method];
-			return 0;
-		}
+	/* Get the next boothmethod */
+	if (++iter->cur_method < iter->num_methods) {
+		iter->method = iter->method_order[iter->cur_method];
+		return 0;
+	}
+
+	/*
+	 * If we have finished scanning the global bootmeths, start the
+	 * normal bootdev scan
+	 */
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
+		iter->num_methods = iter->first_glob_method;
+		iter->doing_global = false;
 
 		/*
-		 * If we have finished scanning the global bootmeths, start the
-		 * normal bootdev scan
+		 * Don't move to the next dev as we haven't tried this
+		 * one yet!
 		 */
-		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
-			iter->num_methods = iter->first_glob_method;
-			iter->doing_global = false;
-
-			/*
-			 * Don't move to the next dev as we haven't tried this
-			 * one yet!
-			 */
-			inc_dev = false;
-		}
+		inc_dev = false;
 	}
 
 	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
-- 
2.43.0

