Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C438CCD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 263398485D;
	Fri, 15 May 2026 22:33:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SF76+OX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64CB48485D; Fri, 15 May 2026 22:33:42 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BFA88483C
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-47c35be031dso208107b6e.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877218; x=1779482018; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnceSCAXcMvthyMlPv6AiUC5WeJY6HaI8CYhk/0HEE8=;
 b=SF76+OX7XOSAu8j70k504/tIG2RE9oDUcd5dqJFxk04KAzldZ1BmvKUdbTDgv6qFTR
 Aon5Zxw3cUJq5s9fPcmT5E27AoS2Y4Gfml2nrqrUtOhkSe1LLCpF5PM37q/rDpjJH7Lt
 UtBiwlg/4SnoaZXtIhWt3vXVuo5DnBe+qpEWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877218; x=1779482018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnceSCAXcMvthyMlPv6AiUC5WeJY6HaI8CYhk/0HEE8=;
 b=FmXnGjtUxxAFPXu91KVPhW8JRfreEro0YdOtetwCTHLFPD+uTryHPI+Q8Z2dTjISvP
 H3TQmA6WWnd3lrImHuj9b0sOWuWEeS8r0+AFqn4bm3764O4u2R30S2taPFnacvUlD+S/
 879MYgpeREMOxqUkIO+SSDWz2LDG2esvelPaYaPAutPOE/xAXD4c1gr7l9l4bMgUToK9
 7qdFZxOU5zzWIQnURy9DPRM0ZyilpC74cY0rK3urpKr7+A5utrU0xeiYHSOtdiEn/KRR
 aNg8gMkMm3l5SzXW3u6hmnKUQiJkGgROi2GhJIckEJgzXnxyJuVt0vhEtp70pa7oJyVT
 h1hg==
X-Gm-Message-State: AOJu0YwVBqZyg9EGqrHTzLMKU1mtaO8H5w9iU85AkY/EgDxKHFm1HJiX
 aYa2pDqARAHS6cYfwscjQ8yBAZ/XZwzWE+VZcAB/V7K1NrleQkha1pdmvVHzYFV00Idtpk4pKsr
 qDf2F+Q==
X-Gm-Gg: Acq92OFZG0o1mp6EgSwJ9QTaKn2yr01LQh++IaKH4+5cjnwfx8zFk1xenv9YaQzBmbA
 i2IshzRmhejwi0otVdZldPrTrZk/vmr/F1SPaztpjMUh2xNSHVqfYckWP76UDwafT3LmoSI6cty
 JdpLVk8rmDvHADJxSAta6ESa8XENa/PzKVDnWoXow+BAhh+CLxEdRc9Z3AK1OxvnNuS4r+lS9eO
 BIPTXmLmbRK0nll9fEVmMPGv2IZ/1raEYy8n/9jWi14YhISgshdAEDloYNQuNN/+Up9ffcvW4b1
 dskwruSd6wTFKGC18AnPiDAwU5NHXjVi5QB1IWe1NKDS5os6g8B0BZaYzIOhgkNdWUCTxVcRtUj
 oXmXYizT2qGKBDTawD8X1OQshLUhbqzuuZ8lQqlGlteQQA9SKWmzX+QY1L+mkGnbbcXIHXE3C5s
 aTMN0YmPIVx0ZN0a/MXg==
X-Received: by 2002:a05:6808:3029:b0:462:aa0f:4375 with SMTP id
 5614622812f47-482e5789699mr3399146b6e.39.1778877218441; 
 Fri, 15 May 2026 13:33:38 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 04/11] boot: pxe_utils: Use strlower() in get_string()
Date: Fri, 15 May 2026 14:32:55 -0600
Message-ID: <20260515203311.2555651-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515203311.2555651-1-sjg@chromium.org>
References: <20260515203311.2555651-1-sjg@chromium.org>
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

The copy loop hand-rolls a per-character branch on the 'lower' flag.
Split it into a straight memcpy() followed by an optional strlower()
so the common path is a single copy and the lowercase case is obvious.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 419ab1f1b0e..098ee9bbbfe 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -950,7 +950,7 @@ enum lex_state {
 static char *get_string(char **p, struct token *t, char delim, int lower)
 {
 	char *b, *e;
-	size_t len, i;
+	size_t len;
 
 	/*
 	 * b and e both start at the beginning of the input stream.
@@ -976,14 +976,10 @@ static char *get_string(char **p, struct token *t, char delim, int lower)
 	if (!t->val)
 		return NULL;
 
-	for (i = 0; i < len; i++, b++) {
-		if (lower)
-			t->val[i] = tolower(*b);
-		else
-			t->val[i] = *b;
-	}
-
+	memcpy(t->val, b, len);
 	t->val[len] = '\0';
+	if (lower)
+		strlower(t->val);
 
 	/* Update *p so the caller knows where to continue scanning */
 	*p = e;
-- 
2.43.0

