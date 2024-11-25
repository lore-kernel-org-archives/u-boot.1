Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77DFD5806A
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 11:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D47489A3F;
	Mon, 25 Nov 2024 12:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="bLJn42l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16AF89A3C; Mon, 25 Nov 2024 12:56:57 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D7889987
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 12:56:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-432d866f70fso40332985e9.2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 03:56:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732535815; x=1733140615; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hO6HN/1ZHKXZDlbmBO3+BH1EtfZLQTmPvADU2ZuQYXc=;
 b=bLJn42l0cjofe/uiah8o3LqEETcW/r4WIAUC1/fHPOThPCAlJU0rHkCG9QcMk8JNhS
 PcfnRK9Y7UFza3bA6bOj3tId5WQwWLomW9qzYNe3WgxJsK0hUWj3prv+VkCUGIR2eBe7
 8r3GRNaQuTjjvKb2Da+g1PFFGwC7ud3zDL/iNl4fgT9YtI6dfqRTDtc6JUThf02rzQzt
 qZiRQC3Z8Py9i7uufInKDNBdLcj1Srukisc0BIVGtAjhf9cBQeBAkcjYtfU5pu68H94l
 M3jocZ8un6uMmfqgM/pGKMQAfmV5h9aYH/hUzJuOuZZxevvp8xiB4sFFJy5zyhloVuC+
 vpxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732535815; x=1733140615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hO6HN/1ZHKXZDlbmBO3+BH1EtfZLQTmPvADU2ZuQYXc=;
 b=F+iDuV41c6aTkstnXk93gHHyt7K8SA92emQsNgrd2NTAxEIFCRH83lGaWlrXXWR/Kv
 j9EzzfVLYS+LdWhYuhXHUilgsoga/6tG2qU5Rgq/T3jUQiSr+WWxei+RzziXOOdkWT68
 hwn9D7csl6slwWKozopA2CEfA5+U79Z+36pke3dOEgLpHJCt/e/WHLZQNJKW0dojftWR
 kyPtRAwFYq5ObwX9p5botspsm57zvXc6PXtbhPXTYPWADlt9tdpGvNTOOHtijrrD1FI4
 zHpJxj9oj/qCnnMp0w8ePGbSC0GpGbzoOfwgDvxic6EKSSY/AnnQOoBEYuyDy64T+EYE
 lusw==
X-Gm-Message-State: AOJu0Yyckle5D9ongY5RBK3gSQn2ekoXS3AWqBkodbPlJYAtI7rLSR4Z
 0V5Ywh9smZ6pIL+lL91RGNA28Q5a4/uHMVy4t+H3zA0vpijpUQTwIYGhPC7+uxU+DUEek3yP/ai
 t9zHm7Q==
X-Gm-Gg: ASbGncvlJCeejiCJO83YI6dgIeCk6KdSrHtMloEWIfamARFV5RIP5kFsITm2ohXbvh2
 Cg0njdBsgl/lTiSlZ0wX9Px025C/xW1xRpYIbKoGKR1+hT0lbbjrYe4xXOk4TwWH2TFmt5JmRWF
 uTerPNoQCiHBdwGD1odf6dmY1/nLtPq3/SZwqWD0CUQpLQm+PgnJLHtryv7gSPrUevN0lOkeBbP
 BJH7aNs2WOISCwFkxhG+kWB+U05ZCDq98VHBNur2vcYgMCe2yVexksoG3q77NAPw9lz/A==
X-Google-Smtp-Source: AGHT+IGibnMiNj0xUjzyXcP9rOeEm5f+NTtjrAaUhbKXXeUWo6OBLtCRZUUe3XRW+hzbz/aD4CA4Og==
X-Received: by 2002:a5d:5984:0:b0:37d:54de:1609 with SMTP id
 ffacd0b85a97d-38260b4574fmr10136601f8f.10.1732535815339; 
 Mon, 25 Nov 2024 03:56:55 -0800 (PST)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:7b40:ce24:60a6:e419])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3825fb271ffsm10139626f8f.53.2024.11.25.03.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Nov 2024 03:56:54 -0800 (PST)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 4/4] test: lib: Use CONFIG_64BIT to detect 64 bit compile
Date: Mon, 25 Nov 2024 11:55:54 +0000
Message-Id: <20241125115554.1707080-5-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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

Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

(no changes since v3)

Changes in v3:
New patch added for this version.

 test/lib/str.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/lib/str.c b/test/lib/str.c
index e62045318c..48351abc75 100644
--- a/test/lib/str.c
+++ b/test/lib/str.c
@@ -224,13 +224,13 @@ static int str_itoa(struct unit_test_state *uts)
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
@@ -244,13 +244,13 @@ static int str_xtoa(struct unit_test_state *uts)
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

