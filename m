Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C940E67805
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 19:40:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7991189321;
	Sat,  2 Nov 2024 20:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AU+Poreg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53EBC892F0; Sat,  2 Nov 2024 20:38:07 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 363338931D
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 20:38:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b1474b1377so245730885a.2
 for <u-boot@lists.denx.de>; Sat, 02 Nov 2024 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730576283; x=1731181083; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jGP1bJpXT1AFrRz0UEfgBvJFSaFs+V7emvpBUTZFKLE=;
 b=AU+PoreghEDF02SW1TTDGTHfsivz1poWsiqhZm+dq5S7LuEuxVgcSL90fnxWzRbC9H
 qJ61XrJ/ueswvnflJrYOcm47D8Sx0mrL466XnGwMOZY2IZ9Lf0zWaIVns9qhbyqHPED+
 Wqxy0sjWwI4JWJnZnpjXjq3JxWfCRi+QH0bcQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730576283; x=1731181083;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jGP1bJpXT1AFrRz0UEfgBvJFSaFs+V7emvpBUTZFKLE=;
 b=bIYv6zMQUa4iecncqu/w2bTvzsKCF5YcGKTUXbsLEaZTKrCniANFPle2vUsvnbS/y5
 NrRlGHze0/umDbubfLDVYS69i3VYihO3PRaXUZQyAsgzo6R2JLNCx+jRYz4eDQ2j4Ah0
 fHl47DkirAg3v+YoUbuC+uZ63c3IHRG3CtvBoa9w6VHep5iViJfEEVq2p+Fo7mg3Jb4G
 Yza0LMO4UhXmHu6mdmAzBNdLY9e2cUkkP+bZM2YOf4uWhZk15IL7yZpvC20SyjJPmQMI
 y6dmH/U2FUrO/lT0oMLGg1rzJZruAYp+2GtpvvNbceD99XDtT+DfANR+WV7Lky2FcMD2
 ggSw==
X-Gm-Message-State: AOJu0YywCe244JDjS2kIuavhYJpoUc7RHxW/78U+uR5oqM6LYIptB3Og
 F4oK8Wu+euEqvr+lkHwk4MMkpriBdRVgab/WBQc7TSH35F1BhXLureyZ6u230bt4aldXMdemCkj
 kTAaw
X-Google-Smtp-Source: AGHT+IF8E3fvg2gLdgpeJLlFhlzV/4ncHyuH3ZDh7gvHmGsXCRQAJr5k6BcjARnQdpHDOKlcncxVBA==
X-Received: by 2002:a05:620a:4692:b0:7b1:541d:ed6 with SMTP id
 af79cd13be357-7b2f253d7bcmr1479110285a.40.1730576283566; 
 Sat, 02 Nov 2024 12:38:03 -0700 (PDT)
Received: from chromium.org ([165.225.8.161]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d353f9dfeasm32324976d6.14.2024.11.02.12.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 12:38:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/20] test: Update time tests to use unit-test asserts
Date: Sat,  2 Nov 2024 13:37:03 -0600
Message-ID: <20241102193715.432529-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241102193715.432529-1-sjg@chromium.org>
References: <20241102193715.432529-1-sjg@chromium.org>
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

Rather than returning various error codes, use assertions to check that
the test passes.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/lib/time.c | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

diff --git a/test/lib/time.c b/test/lib/time.c
index 2095bef7589..b99e738c500 100644
--- a/test/lib/time.c
+++ b/test/lib/time.c
@@ -22,11 +22,7 @@ static int test_get_timer(struct unit_test_state *uts)
 			next = get_timer(0);
 		} while (start == next);
 
-		if (start + 1 != next) {
-			printf("%s: iter=%d, start=%lu, next=%lu, expected a difference of 1\n",
-			       __func__, iter, start, next);
-			return -EINVAL;
-		}
+		ut_asserteq(start + 1, next);
 		start++;
 	}
 
@@ -35,11 +31,7 @@ static int test_get_timer(struct unit_test_state *uts)
 	 * an extra millisecond may have passed.
 	 */
 	diff = get_timer(base);
-	if (diff != iter && diff != iter + 1) {
-		printf("%s: expected get_timer(base) to match elapsed time: diff=%lu, expected=%d\n",
-		       __func__, diff, iter);
-			return -EINVAL;
-	}
+	ut_assert(diff == iter || diff == iter + 1);
 
 	return 0;
 }
@@ -57,11 +49,8 @@ static int test_timer_get_us(struct unit_test_state *uts)
 		next = timer_get_us();
 		if (next != prev) {
 			delta = next - prev;
-			if (delta < 0) {
-				printf("%s: timer_get_us() went backwards from %lu to %lu\n",
-				       __func__, prev, next);
-				return -EINVAL;
-			} else if (delta != 0) {
+			ut_assert(delta >= 0);
+			if (delta) {
 				if (delta < min)
 					min = delta;
 				prev = next;
@@ -70,11 +59,7 @@ static int test_timer_get_us(struct unit_test_state *uts)
 		}
 	}
 
-	if (min != 1) {
-		printf("%s: Minimum microsecond delta should be 1 but is %lu\n",
-		       __func__, min);
-		return -EINVAL;
-	}
+	ut_asserteq(1, min);
 
 	return 0;
 }
@@ -95,8 +80,7 @@ static int test_time_comparison(struct unit_test_state *uts)
 	error = delta_us - 1000000;
 	printf("%s: Microsecond time for 1 second: %lu, error = %ld\n",
 	       __func__, delta_us, error);
-	if (abs(error) > 1000)
-		return -EINVAL;
+	ut_assert(abs(error) <= 1000);
 
 	return 0;
 }
@@ -115,8 +99,7 @@ static int test_udelay(struct unit_test_state *uts)
 	error = delta - 1000;
 	printf("%s: Delay time for 1000 udelay(1000): %lu ms, error = %ld\n",
 	       __func__, delta, error);
-	if (abs(error) > 100)
-		return -EINVAL;
+	ut_assert(abs(error) <= 100);
 
 	return 0;
 }
-- 
2.43.0

