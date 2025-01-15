Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F1DC02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:33:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D1AE807F3;
	Wed, 15 Jan 2025 14:31:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XXA88I3l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9FD807EC; Wed, 15 Jan 2025 14:31:35 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACD380821
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:31:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-844ce6d0716so467521739f.1
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947890; x=1737552690; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7YiGW3s6GUG0rSmv4oKSl4HkCSSizzCfWH106zQU+E=;
 b=XXA88I3lNs4YtnDhkot49h3QnPmjfwuK8dCNA5dA6TfC4YNjSV1GC8p95D9mVaiU47
 wUMV9FptNQj3My0IPqikVYk1REODUBgZc0GI0jyTeIBnNj6ZlsB39WOunkBhoveDGJdf
 lGFk2e9xKHt7CDO5b3wM9PQil+dYV0o10aVbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947890; x=1737552690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=i7YiGW3s6GUG0rSmv4oKSl4HkCSSizzCfWH106zQU+E=;
 b=TKNgaj4G8B4nt5fcHVmY8VQZKVj5Uz7rzop78xaDO1FEpziGDUVeKNrKcgqC+Xgvwb
 VBOZi1L64TdWs0tbXoE3A1+V2HZPXA/2cDkb6AYXeXiL2qRm8IRrM+bB3RqOFp78qltI
 noKNcMjBsjN4pPRyN048tHipsL/XyVRzS+aHlieTb1vr8mSm24oQ12u8SrFTMwCD2mfU
 BiZAtRmKF3a+2IkLCGsfiJW5dNATS810Hca9F+tIWt6jWZX1slPakcKWVZnDASzVVhmL
 9bGu7M1gtXD9vFrsg+UkZ/mPRvfrpFFNRLj/jq4uAn6yre2XDrEXJ3rWYtyR0bSeWMcC
 BGYg==
X-Gm-Message-State: AOJu0YxSg9lORoapiqQcYOIgTXqJFiRDD5iqD2XYVICFPZpZWiBVmmdK
 Bv7mv+dw/LlcbGkorsBjSlCYm1GUnr223ug+tbXaOIAHK5r6BTk59oO7DrsFGq4Cga02QakT5Jc
 =
X-Gm-Gg: ASbGncvuUp6Odz4pSF1DXAd4eNYJSxr2soqCjumMs5EasJoCDobiKXiB+alLCEcFKDx
 dVQrzKr5m4lItx49/5kU59TfDhIOsOlQ12ZuhBTdf7Qvl7a/wdYhIo2dIx+0jJmyrMsKwMcdWOn
 j2eCZihe2NYa4Gl7YWmDssPF4RZ6ilrvnVl2b1U1OWsKZLedUmzNpeDhl3kqmSFavzBVQFbXMCM
 TbUQS8qutlTnoTIlGyKYHe9DssFdKGHQZrXuJBz39Qalz2ULRf+gt6sjWRvJJ4PfavBbOH/GoQ0
 CvnPGYiSWZRt1aYQ2g==
X-Google-Smtp-Source: AGHT+IHT6Mgwa889M+BxLCO+Yq21Ta8R1LS0frysFe2nOXgtkNSEnZvJs2zalWb12y1dwq0wWgqODw==
X-Received: by 2002:a05:6602:6cc6:b0:844:debf:2c8f with SMTP id
 ca18e2360f4ac-84ce01a47ebmr2920935339f.14.1736947890629; 
 Wed, 15 Jan 2025 05:31:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:31:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Ion Agorria <ion@agorria.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 06/43] test: Add newlines to hush-test messages
Date: Wed, 15 Jan 2025 06:30:36 -0700
Message-Id: <20250115133114.590375-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

A few messages lack a newline so the test output shows the next
test-name on the same line. For example:

   Beware: this test sets local variable dollar_bar and dollar_quux
      and they cannot be unset!Test: hush_test_env_dollar: dollar.c

This is confusing, so fix it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/hush/dollar.c | 7 ++++---
 test/hush/loop.c   | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/test/hush/dollar.c b/test/hush/dollar.c
index 077dcd62c0e..820110799a2 100644
--- a/test/hush/dollar.c
+++ b/test/hush/dollar.c
@@ -108,7 +108,7 @@ static int hush_test_simple_dollar(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("dollar_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable dollar_foo and it cannot be unset!");
+		puts("Beware: this test set local variable dollar_foo and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -140,7 +140,7 @@ static int hush_test_env_dollar(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("env_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable env_foo and it cannot be unset!");
+		puts("Beware: this test set local variable env_foo and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -206,7 +206,8 @@ static int hush_test_command_dollar(struct unit_test_state *uts)
 		ut_assertok(run_command("dollar_bar=", 0));
 		ut_assertok(run_command("dollar_quux=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test sets local variable dollar_bar and dollar_quux and they cannot be unset!");
+		puts("Beware: this test sets local variable dollar_bar and "
+		     "dollar_quux and they cannot be unset!\n");
 	}
 
 	return 0;
diff --git a/test/hush/loop.c b/test/hush/loop.c
index a9b6a8edf24..7154b9bc0ae 100644
--- a/test/hush/loop.c
+++ b/test/hush/loop.c
@@ -25,7 +25,7 @@ static int hush_test_for(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("loop_i=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable loop_i and it cannot be unset!");
+		puts("Beware: this test set local variable loop_i and it cannot be unset!\n");
 	}
 
 	return 0;
@@ -56,7 +56,7 @@ static int hush_test_while(struct unit_test_state *uts)
 		/* Reset local variable. */
 		ut_assertok(run_command("loop_foo=", 0));
 	} else if (gd->flags & GD_FLG_HUSH_OLD_PARSER) {
-		puts("Beware: this test set local variable loop_foo and it cannot be unset!");
+		puts("Beware: this test set local variable loop_foo and it cannot be unset!\n");
 	}
 
 	return 0;
-- 
2.34.1

