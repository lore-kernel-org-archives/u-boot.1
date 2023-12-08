Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51493C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 22:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0261876E8;
	Fri,  8 Dec 2023 23:31:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Op8Y3E1y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4078762F; Fri,  8 Dec 2023 23:31:29 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9293A876D9
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 23:31:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40c26a45b2dso14639005e9.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 14:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702074681; x=1702679481;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcgDjTUVo40UDuiyJdykmNbr2taIcntC0eai6o9YHmk=;
 b=Op8Y3E1yjpEUsT6xsAEgNMSE1OZndJWGHs5w7qA5lz9IIDTAG66uUjujOK69JFV/Kl
 B2EwhpvDPGJx3sGoKUlBhoXmTg6GMMaF9BBLa/UjxS7hJmdiaER7bTjdVMQXfAhsRONF
 CpXnVLFNiEPQAbvOjk+Ncg4iTts7LeeuVXxBk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702074681; x=1702679481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcgDjTUVo40UDuiyJdykmNbr2taIcntC0eai6o9YHmk=;
 b=gFjcjU3d/FVfj4dB4HAje8uStb3RF8poZ5/B2ll8DAn1duq6xBQuoUi5f0l+JXf1yR
 HFqjr4hI3zj3s0wZ9OECQ4/iWYNrdTWZXX3pvu5r96jETe4vwChjX+tKAstn0QhRwcqy
 P7VLs272O6RuR3JJRF/LEFaG7RiI9siLN+3EctW/oMG2wlNFxEXt9ObbjA12NN585+fZ
 Z9MKptvRStdUASXWajEhsFF4Zo9bsBJS1lTk86wp0wcSYN75wQoxgX+po4BZuvp8z+f0
 tKVKbngBpraIhUZ4wUsQw1VHdY0C0gGms4bMphBw5b+3rK/RL4fFu3zB/MkZgUT3FfKW
 lV/A==
X-Gm-Message-State: AOJu0Ywl41rM+4BXbs/TTppXkmTFNn1jmsjjY212fV7dtJIHknMC8w+N
 T2U5Ltd3sVWJk4Onx5LzvS/n0//3Mtf8c++TTZsVyA==
X-Google-Smtp-Source: AGHT+IHmYUCI3mKXNRC/u/e6tPDc9EsIdyAeBbccUFO7gZ9IiYyS8sTaJKV2HwrFLxlDvgGu2y6acw==
X-Received: by 2002:a05:600c:364f:b0:40c:2307:fae1 with SMTP id
 y15-20020a05600c364f00b0040c2307fae1mr374095wmq.57.1702074681090; 
 Fri, 08 Dec 2023 14:31:21 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 h11-20020a05600c350b00b0040b4cb14d40sm6357863wmq.19.2023.12.08.14.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Dec 2023 14:31:20 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v12 18/24] cli: hush_modern: Enable using < and > as string
 compare operators
Date: Fri,  8 Dec 2023 23:30:19 +0100
Message-Id: <20231208223025.55076-19-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

In Busybox hush, '<' and '>' are used as redirection operators.
For example, cat foo > bar will write content of file foo inside file bar.
In U-Boot, we do not have file system, so we can hardly redirect command output
inside a file.

But, in actual U-Boot hush, these operators ('<' and '>') are used as string
compare operators.
For example, test aaa < bbb returns 0 as aaa is before bbb in the dictionary.
Busybox hush also permits this, but operators need to be escaped ('\<' and
'\>').
Indeed, if escaping is needed it permits the developer to think about its code,
as in a lot of case, we want to compare integers (using '-lt' or '-gt') rather
than strings.

As testing in U-Boot is handled by the test command, we will stick with the
original behaviour and not adapt to Busybox one.

Nonetheless, if one day we decide to implement test with '[[ ]]', we will then
stick to upstream Busybox behavior.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 common/cli_hush_upstream.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/common/cli_hush_upstream.c b/common/cli_hush_upstream.c
index 11870c51e8..a56ea6c5c8 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -6159,7 +6159,28 @@ static struct pipe *parse_stream(char **pstring,
 			if (parse_redirect(&ctx, redir_fd, redir_style, input))
 				goto parse_error_exitcode1;
 			continue; /* get next char */
-#endif /* !__U_BOOT__ */
+#else /* __U_BOOT__ */
+			/*
+			 * In U-Boot, '<' and '>' can be used in test command to test if
+			 * a string is, alphabetically, before or after another.
+			 * In 2021 Busybox hush, we will keep the same behavior and so not treat
+			 * them as redirection operator.
+			 *
+			 * Indeed, in U-Boot, tests are handled by the test command and not by the
+			 * shell code.
+			 * So, better to give this character as input to test command.
+			 *
+			 * NOTE In my opinion, when you use '<' or '>' I am almost sure
+			 * you wanted to use "-gt" or "-lt" in place, so thinking to
+			 * escape these will make you should check your code (sh syntax
+			 * at this level is, for me, error prone).
+			 */
+			case '>':
+				fallthrough;
+			case '<':
+				o_addQchr(&ctx.word, ch);
+				continue;
+#endif /* __U_BOOT__ */
 		case '#':
 			if (ctx.word.length == 0 && !ctx.word.has_quoted_part) {
 				/* skip "#comment" */
-- 
2.34.1

