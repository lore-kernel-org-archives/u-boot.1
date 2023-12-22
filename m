Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B10C4706F
	for <u-boot@archiver.kernel.org>; Fri, 22 Dec 2023 21:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C32F087809;
	Fri, 22 Dec 2023 22:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="KmLZrJXb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 825F186C67; Fri, 22 Dec 2023 22:03:44 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 632E187800
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 22:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40d4ee4cbbcso632165e9.2
 for <u-boot@lists.denx.de>; Fri, 22 Dec 2023 13:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1703279016; x=1703883816;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BcgDjTUVo40UDuiyJdykmNbr2taIcntC0eai6o9YHmk=;
 b=KmLZrJXbalXfewxD56aSNIqPesnQFDwNoYhnGvrjC1ZsWLX0MzXKrjSRTbKIyI09rk
 f9P0a5U0zQhtjK0r5wOEU3wx+s8cFHUWo82IHcMahW3tkdzkecfRTiW+JZrQWxRGBlDr
 +ihmAHTxIN/QNUp4mf5DzG33h+jZIwPA+5FSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703279016; x=1703883816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BcgDjTUVo40UDuiyJdykmNbr2taIcntC0eai6o9YHmk=;
 b=SX0qBQsJ35ehH0SR35O+UhianDjfNCNfsAURDC5GstbM6IfbG90mEVEZd5QliLN0cY
 sEtE8MiQ1r9hF2h3n8sY1m/lznqKND5A8f9/lEKypG6TuEs1HG8NHGYoa2nOpcS9aUPK
 Lw7yiFkY0Q5PZbp3DeUoev/edc80R2h6nGQI0f+y2Upy6nUAXrqgTekD56w3nTqiW6JC
 49gC2gv4KyHsSyl5rY9+VtlQu1ReTp6UpFDgpTuFkN5avxBx+c4x5GXZQ0r5NkTEepH2
 e1nrEd2w2qo3GQH+hpbD0ASqZk3nvRmJKOO8LmGZ9ivCxXRODl7wxS0Xacu49Hua6r49
 g+zA==
X-Gm-Message-State: AOJu0Yz8igegyYV3qBv1eVocu0zAYLV9iZQhj2t+vC9Qfm0WTgPBAXQw
 woqefPJgJk/hnVCocVG7qsgr9+S9551t7NnxCyGVnl8VxtU=
X-Google-Smtp-Source: AGHT+IFX6KS7pQDoOum+yKckNC71Vvr68tuYMroeDKo8oPZXJf/V4ZeN0zMuIbOE6MMU+LZGDuajwA==
X-Received: by 2002:a05:600c:474a:b0:40d:4eee:a604 with SMTP id
 w10-20020a05600c474a00b0040d4eeea604mr37293wmo.170.1703279015997; 
 Fri, 22 Dec 2023 13:03:35 -0800 (PST)
Received: from pwmachine.numericable.fr (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 j20-20020a05600c191400b0040b349c91acsm348294wmq.16.2023.12.22.13.03.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 13:03:35 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v13 18/24] cli: hush_modern: Enable using < and > as string
 compare operators
Date: Fri, 22 Dec 2023 22:02:38 +0100
Message-Id: <20231222210244.91830-19-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
References: <20231222210244.91830-1-francis.laniel@amarulasolutions.com>
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

