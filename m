Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA634E7C4E3
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAB93875BA;
	Wed,  4 Oct 2023 18:43:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="P9x8PAT+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8BFB875EB; Wed,  4 Oct 2023 18:43:49 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DC6875D1
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:43:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-533f193fc8dso4206841a12.2
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437805; x=1697042605;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrEsEK+VQyzUUFkwp6MoEWPPjw+Y1IwvDWUuQtPlLoQ=;
 b=P9x8PAT+7urcf+m2vMNC8sVidubSETC5+cKI2+IWoPhk3mYsJZpm67HNEc5JeTlNDm
 n/L1OooPoy0PL0FaXSjbaXrq5Wj9tcCPhQKt9Eh/55lvIEHmT9VP0HmiLK2t+zPhn4Bu
 tV7p+lEVG3AtPmzEgIDpIDYh0wNBGT3ZMSWNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437805; x=1697042605;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrEsEK+VQyzUUFkwp6MoEWPPjw+Y1IwvDWUuQtPlLoQ=;
 b=GbeCxa4SqOs9ODJjrH8kXz2HIPTuvMLq06cdh/4sslpsrrgvPLd+5pCAyhneixnE31
 OdLzvnbgas8tJXwlqjXrVo27bL8yFivHXQ3vmnF8/35r3e6wNpiBkzXQmBa7dZuWgq7b
 OgJwuPPPHW4amroKfj3cccTMEwb7RTIcU2HYauCXARiJudMklag0MJAt2uXBj81pulGy
 yYUOMfMVZ5EYHseUCzUHgl7IkgIfSNv/Pft4xxTi1Mw7BKgZBdh33s08YHuOuJwrmrv/
 2fd8ku73LEuEz5eeFs0y7GSl77kq/ML/KyU9dB6Oq6ztmnrkf2INSPb27NSQ8IRS1xc1
 hunQ==
X-Gm-Message-State: AOJu0YwDC0AqMrsUOd0GT3CB3Z8q60WVR9igEdVXY2jNcZeA8P1wlonw
 4LYNOsMjf4QKd7vyZOYdo9HyT3JG88G85SF/1KQ=
X-Google-Smtp-Source: AGHT+IG6bhmpuazsCwkBMjPUGPPHCCuZbmp9K1ixZW6+cJZqvtLwmUKlh+ZF6qUM7R48yP3/m1OQoA==
X-Received: by 2002:aa7:db46:0:b0:532:ac24:3081 with SMTP id
 n6-20020aa7db46000000b00532ac243081mr2472708edt.30.1696437804982; 
 Wed, 04 Oct 2023 09:43:24 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.43.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:43:24 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [RFC PATCH v10 18/24] cli: hush_2021: Enable using < and > as string
 compare operators
Date: Wed,  4 Oct 2023 19:42:14 +0300
Message-Id: <20231004164220.15738-19-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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
index dbf77ad503..68a9a4bb72 100644
--- a/common/cli_hush_upstream.c
+++ b/common/cli_hush_upstream.c
@@ -6160,7 +6160,28 @@ static struct pipe *parse_stream(char **pstring,
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

