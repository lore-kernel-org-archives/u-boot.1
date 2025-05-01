Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0D6C3ABA3
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 13:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDF738214B;
	Thu,  1 May 2025 15:37:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oZ9837U+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 280F78059D; Thu,  1 May 2025 15:37:47 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBAAF81E25
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 15:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-864a22fcdf2so24254139f.0
 for <u-boot@lists.denx.de>; Thu, 01 May 2025 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746106663; x=1746711463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XQTv3D9fOrl2Bdp5TjP0wXxky4XAnSB/QzDYbkUZYs=;
 b=oZ9837U++1rdMhXxAZ48Zr03KsWrYnox6ZW14Vi+eKTTQpErw0mT6s8i7CNcIQPKHG
 VrI+lLfzu0WbHYLWhO1yc/LZSRhzeTdcbCO/WVU/GFmBBO2py18wmHV+szvoGNtuTCgy
 uzNgk5boQDLk61Lu7bfK22635xbcaAd4p7B8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746106663; x=1746711463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1XQTv3D9fOrl2Bdp5TjP0wXxky4XAnSB/QzDYbkUZYs=;
 b=nY1qXJMEj6TfBj+IHn0lzPsjmDWJJ4io8ivzWHbD4iDrSIYQNMuyYaP2vWgVaxOc7c
 +f0k7rkuQ3YMySBymYnqnIIpxdpyHrQ9aSE0ncOAlW3rGMP5v0lNfgMturmfJvEw4IWy
 HsA0L4BbAUJ9RgDRR6nho3baOft5ZekTJsyJI+N+FjhPPF9cDLYapQS1R51PLaQMNJ6W
 un43AR2tPj8f/5j2585L3R7x7cuAiGlPznqQ+eO1id6K7UBsYTFrPNBl5G7r2RuABoDg
 fnhYIvMmgCMsZOne3kmkaPgtclsOCqDbrb84iUUUogiCi6TdvW3v8KAXDkAlScrP92xc
 lHvA==
X-Gm-Message-State: AOJu0YzEf7trawuQmcL2UWDelIkf34hc8IXOI4cGyYchXh113E+Y6EWv
 mS3DFVFiaLbNFCqooMr+C4qA2Tz8N6GB60AQ1HvMh8kNRUTqX0noRSvjy4lDq+9lFGje9iC2WPU
 =
X-Gm-Gg: ASbGncvFoDjwDX2TXUnEpK6NqyfN4fL6GJqF9ecb5r2dMQC6XYME7D8VYtkLXtKS6He
 rgwWLuSvOiiCDlooBsQiqNFGylanjOy9eR9W/1npIHT+dkR3O5NhK34UVx9q/6XILpwo+K0w5lo
 EwCuBT0bB0eKq31S92h+sTqlkvzF9IvT+IkKQ6Xub9nGnyUGk+U3iJDBceQhJFb/rsU1gF2YNtZ
 qxNcP6F//NxsMbiWz2RVdwsLRtxcATTpzDnMaOd3dmWBVNbCQQWrDMObjUMuLcrdZBo2/835Xq4
 F7oUtQcGDw3JziJF6w72ZvO29/ebAQB8FtzllVShG9sQv4nrHHKxJ8GoD+0MLsCLHotPl/cYChL
 clg==
X-Google-Smtp-Source: AGHT+IHkxvmRbe66/cIyq9U40lvXvvl9GGyIsOj0p9zehAr4lTHmX7Mc6d7onMXO6SyoSuzcu9Umcg==
X-Received: by 2002:a05:6602:2bf2:b0:85e:16e9:5e8d with SMTP id
 ca18e2360f4ac-864a3dde2fcmr259664139f.7.1746106663126; 
 Thu, 01 May 2025 06:37:43 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f88303bb9esm165385173.136.2025.05.01.06.37.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 06:37:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Guillaume La Roque <glaroque@baylibre.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/18] bootstd: Try all bootmeths on the final partition
Date: Thu,  1 May 2025 07:37:07 -0600
Message-ID: <20250501133726.2627373-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501133726.2627373-1-sjg@chromium.org>
References: <20250501133726.2627373-1-sjg@chromium.org>
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

(no changes since v1)

 boot/bootflow.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 4054a966af8..345dd993c14 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -195,27 +195,25 @@ static int iter_incr(struct bootflow_iter *iter)
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

