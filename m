Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F881D60D17
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 10:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D313896A8;
	Wed, 20 Nov 2024 11:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tLqWhfuH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D5958969D; Wed, 20 Nov 2024 11:02:40 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97BC2895D2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 11:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315eeb2601so56418515e9.2
 for <u-boot@lists.denx.de>; Wed, 20 Nov 2024 02:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732096958; x=1732701758; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cmAW8/LIad3dpkshTTwsYb3oxmsfByZwJqz4iRcC7XE=;
 b=tLqWhfuHmjQSnh/vMYkFQ/OVE6GvN1BI116wz+69S+YMp06fiy0usZQ0ZWSdLwITlW
 0TY4TM47PWJKhYHXJQxOaabDk87cm3GVixAvOTNJ3cwQpdHHbhTRGm4ViiozvDu/nrBK
 h/8BJ44VbyJL98sNafot6CrOkn1yjAhOhHlw1KqzocxA2TeMXKSLe2UtW8ztrwsm03RZ
 68b4Sf8LMZe+dcJwxWgGcsQ++sU38lSjUFh/iolIJc8JgWK/AH9MY9mqOka2WuEIZf3W
 /PO3MlOqD1q38+RZ/BK3LWsxOkk5hzaokbr/36GxShCjzIDyc9C4+B2bkhjbri9hCrCb
 XRQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732096958; x=1732701758;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cmAW8/LIad3dpkshTTwsYb3oxmsfByZwJqz4iRcC7XE=;
 b=cXtYjrnpyd1NlJ6SsRSUuJfm8oSZkmkWYAa1wlVhSMQUsiONT1TmLY8jmXb+cn7cfk
 XMdsv2ss0aC41t57jUn3x7gkJNEvHGNNpGgCL068PntEoyUjqRKFIrDYcwHEheS+EUph
 WBOSsfWqN8gtXCNF+hjwp+yd7oPfWxy0kB0FK09Y9J2z9ozq8HJS+tzx5el4idF2dpmw
 q5fmRKd+yRLiKmuyN9Nyn4+oUCv5O9O3FZshJOdYgm4DFsntCTQj3SGoUprw1Avd5ZLT
 r32wx3fAStG/YE+eT5gw7z7+iNusBo2Xud+NEg7/Ofg480iY4RPKvynZLeKVKjYj9f1A
 IwiQ==
X-Gm-Message-State: AOJu0YzZSWyh/WlspLx2tO38zlEBiiMsT5g+XcadSoBbdgZX2LYt0c+l
 KL2Y1/0cJvHYetQIrcmyqjTlzoCr5cKSmaVfAHD37LG/X8sYeXZ4CJIwfH+EpTA/FdkW3Wle8lr
 cgXcO4A==
X-Google-Smtp-Source: AGHT+IGdxn8Gi/hcLgngieF5mNKgiJ3zprwM8aYgE1UUfQJhnQlQ5Aw3CrM/pw+MAoshlI9wWhjRIw==
X-Received: by 2002:a05:600c:3b9c:b0:431:24c3:dbaa with SMTP id
 5b1f17b1804b1-43348981499mr23088005e9.2.1732096958082; 
 Wed, 20 Nov 2024 02:02:38 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:24e0:2f5f:4be2:4309])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-433b45fa706sm13572655e9.16.2024.11.20.02.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 02:02:37 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 4/4] test: lib: Use CONFIG_64BIT to detect 64 bit compile
Date: Wed, 20 Nov 2024 10:01:57 +0000
Message-Id: <20241120100157.485418-5-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241120100157.485418-1-andrew.goodbody@linaro.org>
References: <20241120100157.485418-1-andrew.goodbody@linaro.org>
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

Should use CONFIG_64BIT to detect a 64 bit compile and not
CONFIG_PHYS_64BIT. This allows more platforms to run the
full test code.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

Changes in v3:
New patch added for this version.

 test/lib/str.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/lib/str.c b/test/lib/str.c
index 3cc9dfea6a..0505aed09d 100644
--- a/test/lib/str.c
+++ b/test/lib/str.c
@@ -206,13 +206,13 @@ static int str_itoa(struct unit_test_state *uts)
 	ut_asserteq_str("4294967295", simple_itoa(0xffffffff));
 
 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
-#ifdef CONFIG_PHYS_64BIT
+#ifdef CONFIG_64BIT
 	if (sizeof(ulong) == 8) {
 		ut_asserteq_str("9223372036854775807",
 				simple_itoa((1UL << 63) - 1));
 		ut_asserteq_str("18446744073709551615", simple_itoa(-1));
 	}
-#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_64BIT */
 
 	return 0;
 }
@@ -226,13 +226,13 @@ static int str_xtoa(struct unit_test_state *uts)
 	ut_asserteq_str("ffffffff", simple_xtoa(0xffffffff));
 
 	/* Use #ifdef here to avoid a compiler warning on 32-bit machines */
-#ifdef CONFIG_PHYS_64BIT
+#ifdef CONFIG_64BIT
 	if (sizeof(ulong) == 8) {
 		ut_asserteq_str("7fffffffffffffff",
 				simple_xtoa((1UL << 63) - 1));
 		ut_asserteq_str("ffffffffffffffff", simple_xtoa(-1));
 	}
-#endif /* CONFIG_PHYS_64BIT */
+#endif /* CONFIG_64BIT */
 
 	return 0;
 }
-- 
2.39.5

