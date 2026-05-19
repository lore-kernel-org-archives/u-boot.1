Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F227BCD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 23:33:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9619B848BB;
	Wed, 20 May 2026 01:32:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ohp6vLrP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C757F848BB; Wed, 20 May 2026 01:32:47 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABC6B8483C
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 01:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7df05fc49e5so4412881a34.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 16:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779233564; x=1779838364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfW0bb6KtkCP1HXOTjC6X/gvtnOsjOLOu3NLt5nlGsc=;
 b=ohp6vLrPqm9jG75Bl6S5KPnZZemWzJI3wACeTIeOpuai0Vtz4sI970w9GELa6FQibT
 2gD49A1fqrfybPDeDJQmsFoiy1PBw+LB3QTd717+DTRHaJ0UWtnQsuzf76fpxLKTg2dY
 +iyB7P2+vuK7bjYdBBLfowEY82gyztdUdXh6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779233564; x=1779838364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bfW0bb6KtkCP1HXOTjC6X/gvtnOsjOLOu3NLt5nlGsc=;
 b=PsADcZuXqzsFstpLWLnoomC3HkPUgvxU76INLHWlS4YXiwCe85uKVCV1Ep6fMw956J
 Pamo/H7SWoe92YDWBEI9bNreA7rv6LQltzXTHZgF2BBzqSQ2w7mdCSqXKhTQC+AMj+qt
 vLLmIoXIZoU4NX4LR/YD2E3U+Cc9cVaGTdTp9t9BX5vKgCQfyc/B+6/Xm5QxqT98fGBY
 kwuhE0YLaxmGXhjR9znL0ph+nK1tPNJ1j/3MMmFkArFLcwFzWyAI1uyGh0v0rB6GnUKd
 LpkTgA8TBF5+HNjJnR3ofgdxlICwYToCkhC8TprGJjgPOcHlN3CwwalfCycf65NownEw
 BUZA==
X-Gm-Message-State: AOJu0YzRuRj9P+iZl6r1xqCfudvGq+z6Y4ypTSB/dVyK70TzzKpYTJQy
 jYsxsVVM0XriNLDjoNV5Wt2fdKbfWQImp4kTik+lHDAs3LBB/SLoI5a2FR4/oNB172UaBYa+t7d
 VD/c0Gf8l
X-Gm-Gg: Acq92OFzGRFM2GBF61ElCSz/0y+tthfuehzrEmfOk86jpEkMe/51VPG39Rmpr6jlAK2
 Q/uoX2ji3k3iMtpWtx5hILJWwzgHQiWtcKuFOkF7N9u6yTHiIKTw3xDr/JWec+FZZoozijuj3bH
 j8XRdmb6jiy+iTExvKS7bfsqvawYi9+hJWCTvr+o7tqEUqtNzjyDGGbq0v98U1nv8GsO8gMQTho
 2KF0YnCKvtFENL2uzNlWSbwkEeSnbH+louFvc97GbmZorBm7yWmya1RPkuqhkE85ImQ8kwjU1Ue
 N7QfWBvk1Me4Vr5FXpYS5HHCsGBkTz0prtdNz92daOr4RBdjpEk5QJzryVudkO6cA4mCZVdDsPM
 zFj9vWA8M3ghwXAsXRo8mhcPdmK7VF0JKjS70DxsQ6lCODWaBQr2NMqgA3Hc/NHAwwkswcev4aY
 /9Hms3gNp5i/IfNfM4NNw/3LPRqhXBftfloKpQGCM=
X-Received: by 2002:a05:6820:f07:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-69c9436a217mr13496853eaf.33.1779233563849; 
 Tue, 19 May 2026 16:32:43 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69d04911744sm7983725eaf.12.2026.05.19.16.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 16:32:42 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [RFC PATCH v2 06/17] lib: getopt: Add getopt_pop() helper
Date: Tue, 19 May 2026 17:31:32 -0600
Message-ID: <20260519233207.2765755-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519233207.2765755-1-sjg@chromium.org>
References: <20260519233207.2765755-1-sjg@chromium.org>
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

 include/getopt.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/getopt.h b/include/getopt.h
index d90bee2abdd..52aabcc19ac 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,6 +10,7 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <stddef.h>
 #include <linux/kconfig.h>
 
 /**
@@ -138,4 +139,26 @@ static inline int getopt_silent(struct getopt_state *gs, const char *optstring)
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
+	if (gs->nonopts > 0)
+		gs->nonopts--;
+	return gs->argv[gs->index++];
+}
+
 #endif /* __GETOPT_H */
-- 
2.43.0

