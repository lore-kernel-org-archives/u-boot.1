Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D36CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B6AC837E4;
	Wed,  1 Oct 2025 23:30:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jwk34QJt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15EBB837E4; Wed,  1 Oct 2025 23:30:01 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C679836C1
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-912d4135379so14505939f.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354197; x=1759958997; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0jv73eooulWMzExx6bikohCkML0MPHsDVboBXtVimTI=;
 b=jwk34QJtzOjSg3VQNT1BuvoEAUQ/2Iw+DEugKiljl2FIYltHpbbIByo/xURiK3yTBF
 JeWzkGaq0CW65gfCsoBGhvguIqYLVIVeWmh4oN5RgTM7G2+aCHXcD2Fh3ANRIl41H2K0
 QytFeLzz2OpMDah7QVM5qbSrvnMfDgqwDUKLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354197; x=1759958997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0jv73eooulWMzExx6bikohCkML0MPHsDVboBXtVimTI=;
 b=rsB2X5VDlxjk+TBoQy1WlqjXe9iS/z2Q/zcWvlSQ4DZsQnUrSEJoXUg/E6J2RirOIY
 H3ZzFvLmsmz1dS+ag6I+uFR3KdpIbcJxgrnFNl7lKfolt3IccV1Nla2e/KL/ax7ToyGg
 z4aF9s28sctMGKmp7Hx9kOj3mlojM2ea+qHA13txkDm3JTv34NkRn4WOShKPncYaQDT5
 cUoT8U+lnVV7Vl5YWGjxpfbQrZranhkEh5Tb/ENI8q6LCWqtmHgF5N3A2l3XCktWOY0z
 GJwFAjcWwVu0OwSk0uUahsa4RO3u6SdskdtsBsqSvsYxceAfRleTYc8M/XNDMSlkVIoT
 g7uQ==
X-Gm-Message-State: AOJu0Yy25rK84Cc+DE2H2NnowNVayuQcYI7pRUK8DM02OBJjI816K2sw
 ukb9grJqHE4UsGCx5w3/RLH2EwHm8Jvpc1FBxL46Egd+k5GtKaAWd4ziKZiBFVaYqMknIakWy/d
 +BQExhaP2
X-Gm-Gg: ASbGnctOn6RSkI5aa1d22CbZA7LdpnOGacT6y1i7+LgtHlY0sBGYI7zus5CMqPtyMPs
 tJVXjrntS1kJAaFYznGhEeFaPh8za3tifIjuqJT24huIsvwDUxHhXiApikMpuYpKweatukThbVp
 v9MgBvhOOjSi9YkdwpV207wY859qTT4RqFqWZzL3G80yh86xIkSDyFPGqyURWdakI15XOrwCE7y
 5KPmL8JlZKaOCXqbRb7Akj2v2giN8z7APjrXhgbEse+NZtI9HStW8PVADHTNMlQCI8yZLWWvBdr
 8fyMix1uQqEwYGPGfrPEMmUnwHcEgxsIltqV4JKJGizpOEeS2ER8oHitJS4FahDZl3ydlAlunSA
 FgXJ7Smxqm8gGeLVcas4aETjqf0uyX+jsrN6KgmA5
X-Google-Smtp-Source: AGHT+IG9PhMZ91pNLEhvHDI0a4vyKTF3Z/ZwPHi0Ho787/L2riLFmcsj+t6DmshNp+XaOlOQSxIHQw==
X-Received: by 2002:a05:6602:2b94:b0:887:4ba9:a0ee with SMTP id
 ca18e2360f4ac-937adb6098amr722009739f.10.1759354196805; 
 Wed, 01 Oct 2025 14:29:56 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 14/17] boot: Don't change the method count after global
 bootmeths
Date: Wed,  1 Oct 2025 15:26:39 -0600
Message-ID: <20251001212649.3263574-15-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

At present before scanning global bootmeths, the iterator sets the
method count to the index of the first global bootmeth. Now that we
support scanning the global bootmeths multiple times, we must leave this
count alone.

Check against have_global and first_glob_method instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c      | 18 ++++++++++++++----
 test/boot/bootflow.c |  6 +++---
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index d4c842c00fd..1070ed542ce 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -364,9 +364,20 @@ static int iter_incr(struct bootflow_iter *iter)
 	for (iter->cur_method++; iter->cur_method < iter->num_methods;
 	     iter->cur_method++) {
 		/* loop until we find a global bootmeth we haven't used */
-		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global &&
-		    !bootmeth_glob_allowed(iter, iter->cur_method))
-			continue;
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->doing_global) {
+			if (!bootmeth_glob_allowed(iter, iter->cur_method))
+				continue;
+
+			iter->method = iter->method_order[iter->cur_method];
+			log_debug("-> next global method '%s'\n",
+				  iter->method->name);
+			return 0;
+		}
+
+		/* at this point we are only considering non-global bootmeths */
+		if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->have_global &&
+		    iter->cur_method >= iter->first_glob_method)
+			break;
 
 		iter->method = iter->method_order[iter->cur_method];
 		log_debug("-> next method '%s'\n", iter->method->name);
@@ -380,7 +391,6 @@ static int iter_incr(struct bootflow_iter *iter)
 	 * normal bootdev scan
 	 */
 	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && global) {
-		iter->num_methods = iter->first_glob_method;
 		iter->doing_global = false;
 
 		/*
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 505aa095b56..1e98bb7d978 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -427,7 +427,7 @@ static int bootflow_iter_glob(struct unit_test_state *uts)
 	ut_asserteq(-EPROTONOSUPPORT, bootflow_scan_next(&iter, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(3, iter.num_methods);
 	ut_asserteq(2, iter.first_glob_method);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
@@ -494,7 +494,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assertok(bootflow_scan_first(NULL, NULL, &iter, 0, &bflow));
 
 	/* at this point the global bootmeths are stranded above num_methods */
-	ut_asserteq(3, iter.num_methods);
+	ut_asserteq(4, iter.num_methods);
 	ut_assert(!iter.doing_global);
 	ut_assert(iter.have_global);
 	ut_asserteq(3, iter.first_glob_method);
@@ -506,7 +506,7 @@ static int bootflow_iter_disable(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* Check that the sandbox bootmeth has been removed */
-	ut_asserteq(2, iter.num_methods);
+	ut_asserteq(3, iter.num_methods);
 
 	for (i = 0; i < iter.num_methods; i++)
 		ut_assert(strcmp("sandbox", iter.method_order[i]->name));
-- 
2.43.0

