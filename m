Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B39C8C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 11:47:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D555C84BE5;
	Wed,  1 Jul 2026 13:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LuMxxPLM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB6ED84BD5; Wed,  1 Jul 2026 13:47:04 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14ABB84BC5
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 13:47:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7ea9c6ea7deso387905a34.3
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 04:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782906421; x=1783511221; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xkp5rEZANspdt8ZyZLrdBoDgHqeYqtwx/4SB5u388/U=;
 b=LuMxxPLM6lLuynaCxkQtAQgBBIH6rgh0nEk7Y7RgBnzO+D7HOshvIYpy9J3wA2y0E8
 3EnCqsRNQHmbgs9N4c9CmXtkvEJTsdpWVgd/wrkoQuOIPkwIpJyKvIdVfxGw8JOqC8kZ
 xk8YKSsjNJhYAYnSnl6v99blagcBmJqvApmX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782906421; x=1783511221;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xkp5rEZANspdt8ZyZLrdBoDgHqeYqtwx/4SB5u388/U=;
 b=RAic+tNDq5S6V3EB82wzG2Sxv/M8v7m+9dg8tnX/n+/m2rW7AkgkjUYt14quPeMdjX
 GYNlxY597cBbiLQDhlFUIlA8ztuPH+2XLxAYfgPXXAuvMj8Q2i8HA/C1xPnlLtzxPqaf
 wqF9baykA808Ry/lPZ0XPdHUK2qi/Z/5YDK/DyNhTbCpQhoHkPTH12HDGdAM8EzSFIjv
 cEHFbKL+pj+DL/O/8r4pDsQYzICbATKJe2Nx2yyrs9mVnLuUpbGSAIsdaoWO2EBhl+qo
 0G8FzvVyH/ygV+CD1sE+T83lgGwny9E0Uo12dD8Od7fUAqTDvR9UXHliVoP+lyTwRFCx
 KC+A==
X-Gm-Message-State: AOJu0YyymdhLw2uHJzZqSnaELERD1ttqFLdfLn1MxF5303UiiUQQp4CI
 MrFt1if6UFHkkE7F3oJcB9OzoI0RGYvmkGe5UeBBP6GZ6rs2cSbO6WOzzO/VTBoDld5+yxRwp5P
 02Io=
X-Gm-Gg: AfdE7cnuQ4rqGiqxUr9W4qQ5cnbLcbCP66QUno8bL7zV1XUvKt3J0TW8xoPogoJNfzM
 DwFXkmOI33lYiF+EdjUPJETqxaL76pRC5VDlTf44N6nYLBtMI8ARfYvaS7tP3Nh37MIPnfCKI3g
 3tZrqkIBd0klU5jEX+gFyFQwwxTkCMmbGQc5k4BWm37yJKc1IRjUzmYffNZQETPR6BDd5nSIRW3
 Go2BpM4CqAyEKOsce/mXJMildheZRVKgzKDGh4UFHTLhr7SVIOck969SY2LJhTD6cXa3W0rfNoo
 1RP1BTlNb9ir/iFYKNeBXOLH1xfA4LNZJFNvpzZdH9J4VUwkJDEewah+Wj7iSsKc6AzC/25CvPe
 c3XkgYNExPHUTXymH+g+30ZLK/Y7yz1gVWbF8qa2b3HJNnoTivZhIT42evs1qSXt90+0lcUgpIH
 rYctGNFMY=
X-Received: by 2002:a05:6808:509e:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4960ed515d3mr930272b6e.8.1782906420815; 
 Wed, 01 Jul 2026 04:47:00 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4960655e3e2sm1199823b6e.0.2026.07.01.04.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 04:46:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 02/14] lib: getopt: Add getopt_pop() helper
Date: Wed,  1 Jul 2026 05:42:22 -0600
Message-ID: <20260701114248.1396125-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260701114248.1396125-1-sjg@chromium.org>
References: <20260701114248.1396125-1-sjg@chromium.org>
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

Callers that consume positional arguments after parsing routinely write
the same shape:

    algo = gs.args[gs.index];
    /* advance past algo */
    return hash_command(algo, ..., gs.nonopts - 1, &gs.args[gs.index + 1]);

Wrap that in a small inline helper that returns the next positional,
advances gs.index, decrements gs.nonopts, and returns NULL when no
positionals remain. The same helper doubles as an iterator:

    while ((arg = getopt_pop(&gs)))
        process(arg);

stddef.h is now included from getopt.h for the NULL macro.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 include/getopt.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/getopt.h b/include/getopt.h
index 87851242659..03db6647cc6 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,6 +10,7 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <stddef.h>
 #include <linux/kconfig.h>
 
 /**
@@ -148,4 +149,28 @@ static inline int getopt_silent(struct getopt_state *gs, const char *optstring)
 	return __getopt(gs, optstring, true);
 }
 
+/**
+ * getopt_pop() - Take the next remaining positional argument
+ * @gs: State, after getopt() has returned -1
+ *
+ * Returns the first permuted non-option (``gs->argv[gs->index]``),
+ * advances the index, and decrements ``gs->nonopts``. Returns NULL
+ * when no positional arguments remain.
+ *
+ * Useful for consuming positionals one at a time after parsing::
+ *
+ *     algo = getopt_pop(&gs);
+ *     return hash_command(algo, ..., gs.nonopts, &gs.argv[gs.index]);
+ */
+static inline char *getopt_pop(struct getopt_state *gs)
+{
+	if (gs->index >= gs->argc)
+		return NULL;
+#ifdef CONFIG_GETOPT_PERMUTE
+	if (gs->nonopts > 0)
+		gs->nonopts--;
+#endif
+	return gs->argv[gs->index++];
+}
+
 #endif /* __GETOPT_H */
-- 
2.43.0

