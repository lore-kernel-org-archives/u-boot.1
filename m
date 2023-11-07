Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0245C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AF2E87626;
	Tue,  7 Nov 2023 22:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="WZdApFMw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D25848769B; Tue,  7 Nov 2023 22:42:32 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 558C88769C
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:42:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5079f6efd64so7664880e87.2
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393338; x=1699998138;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CrEsEK+VQyzUUFkwp6MoEWPPjw+Y1IwvDWUuQtPlLoQ=;
 b=WZdApFMwaKvTq/hxqGkhoKzgARRKmAuqN559i9X8DC4F9u7c5XeBIE3Z+vtxfe5APT
 Wzi8u7BpGwEKh89i5YtRlbX5Wl0hfYmnU5JF18xXlS/UEoftR2e4Il0fKTb94cQZjfQF
 XiCFEjo/dKZMmYG/4lec4R1LiK4MNfdqr+ZB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393338; x=1699998138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CrEsEK+VQyzUUFkwp6MoEWPPjw+Y1IwvDWUuQtPlLoQ=;
 b=FumUPPlv/ON+lOE2ijpfogcvzKs/JYOdIC1oISQq4LmLBq2LdribVHrVwgWC5DDm+S
 r59l/ibGVgRDHyIuxJeF0gwYYq63FR2t6+XRWoc3OivvUPNkgj63tggECJtxh+d3xiU0
 rTY73ptx3teVPoG1f4WMccf6C863V7RRAFexEunYPuR4OG+zFqyotmrVWJteOCnvEZ90
 yKFJAOiDACi/diIU51YQhmotSmI2G1tTWPSYRl/xTVXyE4S3VRiLt79sief0ORVd65m7
 EgVNJkXunzy12LoNSrQNk2MRL5DhBQeBaaB7faRFxscXyfxVdP/xCh/8XTZeT61IYKIu
 1xwg==
X-Gm-Message-State: AOJu0Yx+EPsOmHo3aM9jhvCyvJAXqM5Di6i6vBqo82Oae7RZpfM5N6FJ
 xxbHF0wuSDePdRraYR7Gg6b2ZZUjMmo4Ca3JP4Q=
X-Google-Smtp-Source: AGHT+IHmN8HvGnvq1gKa5+siWnBuXQ+40rUunzRJOy8kIPmoXRv7au+2ZmOILmqqF+H0py93t2o8Tg==
X-Received: by 2002:ac2:562c:0:b0:503:9a4:26f7 with SMTP id
 b12-20020ac2562c000000b0050309a426f7mr24498131lff.40.1699393338697; 
 Tue, 07 Nov 2023 13:42:18 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.42.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:42:18 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>
Subject: [PATCH v11 18/24] cli: hush_2021: Enable using < and > as string
 compare operators
Date: Tue,  7 Nov 2023 23:41:15 +0200
Message-Id: <20231107214121.132079-19-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

