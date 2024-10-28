Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F443D10C11
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:44:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB778914D;
	Mon, 28 Oct 2024 13:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FMCt4BWh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F269B89150; Mon, 28 Oct 2024 13:42:09 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FB9689099
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:42:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9a0f198d38so617798266b.1
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119327; x=1730724127; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tJvRHHCctc/orx2jbVKeTBVBNxCTGX3F8zMGmTuRfc4=;
 b=FMCt4BWh+pKM0nHboM6WZtmRL1uNvZUZg+/VebiboBCzQHNuAgyYQHp4ps8rYa76nZ
 BbqRunCB3ol/OT5N5CponCCv4BR5izjtyb7eLxAZWkH7gQzAD6peCAu+rUOoAk2Jwj4F
 cOaPFBG8t4Xe/rjpHK+SJOvSfn7jHXMfRDjHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119327; x=1730724127;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tJvRHHCctc/orx2jbVKeTBVBNxCTGX3F8zMGmTuRfc4=;
 b=Z1Q7xbLoASGyyfDeKXj2y8KGfhzyjqHOeqUz4w0LW2eY10nGjpEry1aGkLQWHJU1Kj
 ebqKqt5jHphX7zhEic/v7O6r1sacvCUlB/Xl9NQaA+VKWvlDli+guLjeKz7JrawVn5z3
 HxULE4fgChQkrPx+VF2DVdGJtgaP5IeDMWTGS1GeFQZysJQQnEn28Ty+rWLptOt8XnFh
 2SbUnDPWQMmH6R7aejsI0lM3KOnkZZFWN1cXpMaW/AdxtZhTpsNOq/4lBclkw6c3kX04
 7jZtqLmgePyYH0o8TaHVZ6aNjYp0rsFmKYS0Ky2xxq5NtydIcQjBu+B3592x2TrB0z8m
 NxtA==
X-Gm-Message-State: AOJu0YxI9XdFars+xGOtcilNAATuz+aIcFryuNnl2Bhci2MVPFHK0AN8
 NYvAX8qv4bSO46Qzpez5U47wyxI50bjoNr1kUt0edI1R11/DrgpCCxYe6rI2Wb7QZJ8HfzaeDsn
 xxg==
X-Google-Smtp-Source: AGHT+IGPykvUAUrQ7S5CHiQiy8Bdf9zHFRPHh3hXA7BNRwYHMMprEl06cBIHr203BFZJS4D2gHjJxA==
X-Received: by 2002:a17:907:7f1b:b0:a99:61d1:348f with SMTP id
 a640c23a62f3a-a9de61e8ddfmr634599966b.52.1730119326839; 
 Mon, 28 Oct 2024 05:42:06 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.42.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:42:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/21] test: Update time tests to use unit-test asserts
Date: Mon, 28 Oct 2024 13:41:24 +0100
Message-ID: <20241028124130.32072-20-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

