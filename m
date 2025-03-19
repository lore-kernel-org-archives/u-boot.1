Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC650C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:39:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E94681A0C;
	Wed, 19 Mar 2025 15:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AcPOGNLa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0FD581EBB; Wed, 19 Mar 2025 15:38:58 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 708E681A0C
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:38:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so51170635e9.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742395135; x=1742999935; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2fXXkAt8Bo3ivRxSvxcIYt9UvVh5gD9DCGewgfSy4AY=;
 b=AcPOGNLakbas1lCFCRL8ul4Iic+On51wIueGJYH19090K2OSOdWzwUhv1GkLeIA3WJ
 V1uUmAVDlPtUTM5FFbt1OYGOhWlAnDHFA5kA1xiXg9KPX5XFND5MwZVRLa5ahmP6dmlR
 Qqqazsz9L6ra1E+eYrteZIV7XpejFC/jElrGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742395135; x=1742999935;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2fXXkAt8Bo3ivRxSvxcIYt9UvVh5gD9DCGewgfSy4AY=;
 b=iXREVnHFTSKlOww1CtYhNqZqgx2KMtQqbtJmf/vGnBwaQ9VZxsOIvS6nHRA29dL2Nd
 2CyH5VD/mUxCsqElg4/1aeSU7vZ70xZjd9VPK47rJWVF27o71LyMVdRO+WPr6FCgVL4b
 Re+pq9FPYAS/WvXU/loUKUxtH4AfBlFzsf0sXnBdIix6Bb4hT0aeI/HIYJxkhBAn72gw
 fvQravMf+w8t4V0rXWteeLEF//7BRnECbEyHU4FBsb0wg2YpP5lEicdEH3lIUEYGP20P
 qS4yweZ3kO5Q8cpUEoPb5dw4VoiUBUgwj+EyaS2bRplImX+ARiCq/siTQ1SoW2/5xxl1
 zKrw==
X-Gm-Message-State: AOJu0YylclPoShJOEvThPMOXK+BSeAvzy5iEy6QcIEYe9+xdCcqnfI5y
 fSqPm+6SsYHbY3dWH/uQonIhp3wjgNO4tLc1Y3yEKKQqkba8oYToE2XHvs7lwQB23FMho3BQxnM
 =
X-Gm-Gg: ASbGncveQ3SUunC3ueK9Aoe7HJMjIQq69xrPbIvYYNIaeCNKbRQJ868hsudHvNmpLUu
 YzQCyBVSp36OE1gAn0MyeIe/xGJQJr7uLXm+dlmgLnDzywRG/rnhmPS5p0bmQNWhOWPZphkYtS0
 fb32lKF34NWELTIoqXcRmEvSfYzuk1aQcOT33CjFS3kToo4WQMDkDEPGOWurq0Ylzh1dHu8ofPw
 bLDb/3BJKPI5O1wULWyDizNvdDMLZx0EVZFkBFbrHX3WIn6gBaIyNFmsDZJBNLLQqgrRr1jaa4N
 gREzmLhxI7CocMxc1TEd4jpmfRw2OfNcLdNk4YgPrQ==
X-Google-Smtp-Source: AGHT+IH+g3UuOElFLdgVsalCDSgS2egG0aU/+gYYzQaNMxZy1+WoG1XTtzmL8DAjmOV8t04yNyPBdw==
X-Received: by 2002:a05:600c:1d88:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-43d436c7acemr31394005e9.0.1742395134793; 
 Wed, 19 Mar 2025 07:38:54 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb318a80sm21534428f8f.61.2025.03.19.07.38.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:38:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/17] bootstd: Fully complete iteration of a uclass
Date: Wed, 19 Mar 2025 15:38:01 +0100
Message-ID: <20250319143820.2385092-8-sjg@chromium.org>
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

When trying all bootdevs in a uclass, the method flags are not preserved
in the iterator.

This has no impact on the first bootdev, since that is the one which
sets the flags. For the next one, iter_inc() is used and it finds the
next bootdev. However it sets the method_flags to 0

The result is that the third scan is conducted without the required
BOOTFLOW_METHF_SINGLE_UCLASS flag, so iteration procees to the next
label. This can miss bootdevs if there three or more USB-storage
devices, for example.

Fix this by keeping the method flags around in this case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 83a1d3a7c8b..473e4d5f02c 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -292,7 +292,8 @@ static int iter_incr(struct bootflow_iter *iter)
 				 * bootdev_find_by_label() where this flag is
 				 * set up
 				 */
-				if (iter->method_flags &
+				method_flags = iter->method_flags;
+				if (method_flags &
 				    BOOTFLOW_METHF_SINGLE_UCLASS) {
 					scan_next_in_uclass(&dev);
 					log_debug("looking for next device %s: %s\n",
-- 
2.43.0

