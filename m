Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377BBCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 00:13:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1997C848CE;
	Wed, 20 May 2026 02:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AyJNkO4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 431F3848AA; Wed, 20 May 2026 02:12:45 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16421848B9
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 02:12:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-43a1004f686so1643874fac.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 17:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779235960; x=1779840760; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ynj4D8mgwL6yVyYfFrDb8qs7Ne3q7Azyeqi0cPdoLY=;
 b=AyJNkO4uudf/eNZsrJZyS+LgzRnvVsq5MVAmKjCKi4VusQNrQKurmXGAwB0noIzvnu
 mS04pxdwDMcNyerNy4XJj/0It4m3Ai4+zPYUNptNt0QWtZC3sSCbe2tftxAVu2iPIHj4
 MJwLkozx7FcRdsJZd7TC5JQ+MMWArvb6X0M/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779235960; x=1779840760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ynj4D8mgwL6yVyYfFrDb8qs7Ne3q7Azyeqi0cPdoLY=;
 b=F7cNoGc+CJBbk+yXw9yyrABUiSvPQhy80t57bpRF+2UT+sXDYxl7G015eb1zbPl2Ye
 KWa0OzO7qLLJ/aAm6ZdUeH7BTOgkBZMK9+7n66xvPD9uZTGLgMMFLRR66atW2Tna9oU4
 rkads+VamdzYE7beUpUvuBShoBz2+CUcXIMaDjnBYfoKqkzws1jCsNimM6qMsXOb7NKf
 6LJuoAK0vowVnndhMYw/MjWm8l8YDxHHx36DftsbJfrMW49jg2YYxHNTLY/aHvcqgVYE
 Pjc7L6wpRTAU1TatWR89q/wLng8FcOXWd9QBfzZ+0SCHPlZ047UmAFaetQCL0ZbiJljj
 UH2w==
X-Gm-Message-State: AOJu0YxJJlvcAD+xiWdOcRhuxAV/H8RHRy/BKmh7hYcpXIdjnvGrsyq/
 rlcNGS8HsKixIBq7YTrBGuV5I7Tc1pn7ygi68WOSxm0gVEl8w0BDzFEVQheZGqNvnT1PjsWge4M
 6ahpK86LykM+W
X-Gm-Gg: Acq92OF5DHsk6Wdur/r1QJZ8jFjYToQT1dzIL8O3+8Itp1zry4RH1qt2+P1R0IAaYxn
 N/uzKfH6nkR6ypv/QKAbpBuxiarqnuraIkOJpbCak+XhS/qzN9DIJclWA5d3T70AhUmGg+RgHXa
 0w/lAirnRSnlYIDpoLAZXCQCF9S3IFMyJgXaQmfpoI61iQGuxTTWJc3muvAtr1nB7uXUVqdhWzY
 OcZxqM8ky/zgnrAvJAtlEVsbYVedKie3dW5l9/DoczpFu4Y5ElUhegyBO5qqVMaDdP2wfPSzMwu
 XgAT9DxblUGQKTlMul0jbj/+vBCAy3r+dH0/mbsqFEHSGaKUt2+YTdO6ubiWlqr5KKqupvSZeye
 Wq3L5Z283uNDnsu0CJ+2uOiDWQVsHe5ZeqZdjt1cTlWGREif00NY4Vlb3ghlK97ylgsH+pAKzEd
 tgJZScGBA2glGX0IjJEwxfZ5Eq1y94VhamDyMs9qHiARY0wBkh7lVR+jnxPomDc1C87brbz5E6v
 YADjd+VT4jCrl827ZOZfm1dQ2PoTsScuEJ9dcI7JGNqmCr/ir9UTRnRRCiQAV0MjLEM7zP+k64=
X-Received: by 2002:a05:6820:4d07:b0:684:bf61:ed2c with SMTP id
 006d021491bc7-69c942ffd0fmr14672423eaf.21.1779235960418; 
 Tue, 19 May 2026 17:12:40 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-189-203-106-235.totalplay.net. [189.203.106.235])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94fce014sm8859863fac.7.2026.05.19.17.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 17:12:40 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/3] event: Remove obsolete comment and __used attributes
Date: Tue, 19 May 2026 18:09:54 -0600
Message-ID: <20260520001234.1555120-4-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520001234.1555120-1-trini@konsulko.com>
References: <20260520001234.1555120-1-trini@konsulko.com>
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

Now that we have both resolved the problem on sandbox that lead to a comment
about linker list entries being omitted as well as made linker lists
never list themselves as unused, we can update the event header file.
Remove the now obsolete comment and "__used" attribute marker.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 include/event.h | 35 ++---------------------------------
 1 file changed, 2 insertions(+), 33 deletions(-)

diff --git a/include/event.h b/include/event.h
index 3ce5f992b04e..450281f666a8 100644
--- a/include/event.h
+++ b/include/event.h
@@ -308,44 +308,13 @@ static inline const char *event_spy_id(struct evspy_info *spy)
 #endif
 }
 
-/*
- * It seems that LTO will drop list entries if it decides they are not used,
- * although the conditions that cause this are unclear.
- *
- * The example found is the following:
- *
- * static int sandbox_misc_init_f(void *ctx, struct event *event)
- * {
- *    return sandbox_early_getopt_check();
- * }
- * EVENT_SPY_FULL(EVT_MISC_INIT_F, sandbox_misc_init_f);
- *
- * where EVENT_SPY_FULL uses ll_entry_declare()
- *
- * In this case, LTO decides to drop the sandbox_misc_init_f() function
- * (which is fine) but then drops the linker-list entry too. This means
- * that the code no longer works, in this case sandbox no-longer checks its
- * command-line arguments properly.
- *
- * Without LTO, the KEEP() command in the .lds file is enough to keep the
- * entry around. But with LTO it seems that the entry has already been
- * dropped before the link script is considered.
- *
- * The only solution I can think of is to mark linker-list entries as 'used'
- * using an attribute. This should be safe, since we don't actually want to drop
- * any of these. However this does slightly limit LTO's optimisation choices.
- *
- * Another issue has come up, only with clang: using 'static' makes it throw
- * away the linker-list entry sometimes, e.g. with the EVT_FT_FIXUP entry in
- * vbe_simple.c - so for now, make it global.
- */
 #define EVENT_SPY_FULL(_type, _func) \
-	__used ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
+	ll_entry_declare(struct evspy_info, _type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC(_type, _func)
 
 /* Simple spy with no function arguments */
 #define EVENT_SPY_SIMPLE(_type, _func) \
-	__used ll_entry_declare(struct evspy_info_simple, \
+	ll_entry_declare(struct evspy_info_simple, \
 		_type ## _3_ ## _func, \
 		evspy_info) = _ESPY_REC_SIMPLE(_type, _func)
 
-- 
2.43.0

