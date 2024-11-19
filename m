Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C8BD44160
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 14:05:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6F4895A4;
	Tue, 19 Nov 2024 15:05:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="quoILucM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 539B6895B1; Tue, 19 Nov 2024 15:05:33 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082A9895A2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 15:05:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b1488fde46so51778585a.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 06:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1732025130; x=1732629930; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jfabih24ze7OXOr7LKe+a1XKoGifHJaC3I2iT2VjzSY=;
 b=quoILucMjVnvWrwcqioB+iA8RWDOtld109Rl7WrJBERh50Ac53lndk0iljHHQMXsF+
 nL/tDIJYutxduMaqG1bOmUUhg65u73nZVqOhkaxEseld1AQ0QKbqQWJbNy70SX6/r/Xi
 hwc87Esxh18yTX3jFEghmgN3yooL0RZAyS+Xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732025130; x=1732629930;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Jfabih24ze7OXOr7LKe+a1XKoGifHJaC3I2iT2VjzSY=;
 b=uzzx+yZWkDf1Kl+M3vhq3zpGRBNUGUBg1uoqU4S6gBddAI3ybvW7r4jin2++fgiWA3
 7QsX+Jq++TV1ibDs2RqSH089lYIfnRXFuLVgRONy8uSVSURmsY0TB8tzVplPPaeICV2u
 2ujT2gVleK0++bCKIjicebnYFeM1+eVsx5u2XzFr2T/Ij2iHHLSMby4ml0IliobC2WP/
 RaeBWNtnXhI4bnhqdAdxqCetElbyUBIIHDYwtNEmEbnxH8GvmyXvUh1n9vRsBh9+gltw
 RX96yOSF+g2Z5jOpWbrfG26jT4LvngC8I1w3g83CDhukvxDEMXzhy7hmFZYw7tArFtl/
 Q5aA==
X-Gm-Message-State: AOJu0YwiLxCx29VCgrcpBBPUF40En2dqDF/BNLotTvtjRRyIgyB0S80a
 r1frx3tZizo9ydyXM5KodzciYcIXsXiaAnnvoOu4HI7M6nKr6AluObEy3BVPbJ35P1XodIF5aau
 O0v0=
X-Google-Smtp-Source: AGHT+IEHpjPeLvqqpRsCOUsJS1t1zDdSrm5DMchugs0wQrk72TixKP6U4kKUCRZENQz2EhwjY/ICgQ==
X-Received: by 2002:a05:620a:4444:b0:7a9:b856:434 with SMTP id
 af79cd13be357-7b362297e3cmr2011722385a.12.1732025129854; 
 Tue, 19 Nov 2024 06:05:29 -0800 (PST)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b37a89627csm94924085a.86.2024.11.19.06.05.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 06:05:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] Revert "test: Update time tests to use unit-test asserts"
Date: Tue, 19 Nov 2024 08:05:26 -0600
Message-ID: <20241119140526.3485208-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

While at the base level, this conversion looks equivalent, we now see
both of these tests failing (due to exceeding their allowed margin for
being too slow) in Azure with a very high frequency.

This reverts commit 88db4fc5fec20429881896740df61d402b4b1f66.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 test/lib/time.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/test/lib/time.c b/test/lib/time.c
index b99e738c500f..2095bef75892 100644
--- a/test/lib/time.c
+++ b/test/lib/time.c
@@ -22,7 +22,11 @@ static int test_get_timer(struct unit_test_state *uts)
 			next = get_timer(0);
 		} while (start == next);
 
-		ut_asserteq(start + 1, next);
+		if (start + 1 != next) {
+			printf("%s: iter=%d, start=%lu, next=%lu, expected a difference of 1\n",
+			       __func__, iter, start, next);
+			return -EINVAL;
+		}
 		start++;
 	}
 
@@ -31,7 +35,11 @@ static int test_get_timer(struct unit_test_state *uts)
 	 * an extra millisecond may have passed.
 	 */
 	diff = get_timer(base);
-	ut_assert(diff == iter || diff == iter + 1);
+	if (diff != iter && diff != iter + 1) {
+		printf("%s: expected get_timer(base) to match elapsed time: diff=%lu, expected=%d\n",
+		       __func__, diff, iter);
+			return -EINVAL;
+	}
 
 	return 0;
 }
@@ -49,8 +57,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
 		next = timer_get_us();
 		if (next != prev) {
 			delta = next - prev;
-			ut_assert(delta >= 0);
-			if (delta) {
+			if (delta < 0) {
+				printf("%s: timer_get_us() went backwards from %lu to %lu\n",
+				       __func__, prev, next);
+				return -EINVAL;
+			} else if (delta != 0) {
 				if (delta < min)
 					min = delta;
 				prev = next;
@@ -59,7 +70,11 @@ static int test_timer_get_us(struct unit_test_state *uts)
 		}
 	}
 
-	ut_asserteq(1, min);
+	if (min != 1) {
+		printf("%s: Minimum microsecond delta should be 1 but is %lu\n",
+		       __func__, min);
+		return -EINVAL;
+	}
 
 	return 0;
 }
@@ -80,7 +95,8 @@ static int test_time_comparison(struct unit_test_state *uts)
 	error = delta_us - 1000000;
 	printf("%s: Microsecond time for 1 second: %lu, error = %ld\n",
 	       __func__, delta_us, error);
-	ut_assert(abs(error) <= 1000);
+	if (abs(error) > 1000)
+		return -EINVAL;
 
 	return 0;
 }
@@ -99,7 +115,8 @@ static int test_udelay(struct unit_test_state *uts)
 	error = delta - 1000;
 	printf("%s: Delay time for 1000 udelay(1000): %lu ms, error = %ld\n",
 	       __func__, delta, error);
-	ut_assert(abs(error) <= 100);
+	if (abs(error) > 100)
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.43.0

