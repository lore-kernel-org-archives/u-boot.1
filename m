Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07BFCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 20:34:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AD0184873;
	Fri, 15 May 2026 22:33:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DM6gOjse";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B9F8483F; Fri, 15 May 2026 22:33:46 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EB838483F
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 22:33:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7dcd17e19b6so137734a34.1
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 13:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778877222; x=1779482022; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vNCzOFtBp0eqqWXkcqSDc54bRDcUrKpveg7v8KOOaU0=;
 b=DM6gOjseqF+7lFvnG9/rz4LdleovcfjK0twLb5SF16SXzy2rQbSqitDF+T5jB6T/G2
 IB1mJdE/2sX71FnK4vLSMRAZLjP/IEZW88WuRubxzH3hcX1cQ1C74cntRxjszB/in1p2
 N6OFy7VEkyxXyqNSIKaxuAY4ho/Hk82jyX+4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778877222; x=1779482022;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vNCzOFtBp0eqqWXkcqSDc54bRDcUrKpveg7v8KOOaU0=;
 b=KWryEDn5Y0nBkTo0MXqJmSaLMkq3BbU1EeNuF/fopfqnQSSe7jXnyjyGpzsT/LqRs9
 ypRt/bPmZMnNTAmTdhXtSoHbmx9qBwGVkYJlrXtG3hXG+25JndVCzs487G2QBKrvEHGu
 Nj8RV85ilpJQO5M6COGXIk2TzW6axSICZB4IPACSaBRMtqjmaZPNmi7o88WqEx1mNF8+
 VTkDetsxMKwUTCGl+iyZ/VSnTO68EFlzM5eMNkh0oD/qsTlF1LufpUVgzcJ9td24uDv6
 U8BxLOfgQ1xPNpUxWlmnjv+qWEOyjPGw7eNr6Hr9t1yGgFfIlOvkexWckLNmUzew/nuk
 F47A==
X-Gm-Message-State: AOJu0YxZ2dWE3SfokR3kfzsrwzeyR84uM9E61+ghYRqEgdzmdk7YyD1l
 0O17/nnMy/WYlTFKd3uGAkzo9B78KS0MG/MAz31GYkJPEX2V5+6J5NX1t9Tl08Dgx/DEmpVZE6E
 CzbvIRg==
X-Gm-Gg: Acq92OHl8MBur48aCXoU7GA0Hh60dk2h9/UvtUlERQkZh2qKldAqfXDaAuTt0WRebwp
 bcv9KbUbZlcQctk++X15g8JsR9vHwjTSieY0p1MtGXiNOzZ8gICTJU1kjMtLZBKZcWfP3EdoChL
 KAfuegjV1HKjotCjlGl2NDJAxEApEpqFkqL/IXaA2aB5EbLEryFpaHqjTOENDoBdpnC0nmlXzw5
 XhspsKL164rvpA/t8CznnUUN1FZJYevf7JiBGUEPNwCoUzfmAm4WCOr1LdWqRqYlFbbftgzJLm/
 S+MgTL0dACE/qZjYO4txA79FHHFufv/Fckf6FlYKv/3Q4RBFlHvcL5Tl+/Njyh82IZGoi2+r4q3
 1qSygwHaY33dpBFsh1TB5rturPjlwZ2YEC4OwKhKN9FWv4StTaAGzpjY+l89mjNSe1GXs0Pd7Mq
 CnSaEewNPm9OuXBDgaJw==
X-Received: by 2002:a05:6830:4983:b0:7dc:a6f8:e3be with SMTP id
 46e09a7af769-7e4fa0d50c8mr3896804a34.26.1778877222418; 
 Fri, 15 May 2026 13:33:42 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b95b82fsm2414906a34.12.2026.05.15.13.33.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 13:33:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH 06/11] lib: getopt: Add getopt_pop() helper
Date: Fri, 15 May 2026 14:32:57 -0600
Message-ID: <20260515203311.2555651-7-sjg@chromium.org>
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

 include/getopt.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/include/getopt.h b/include/getopt.h
index 5a9e7802e65..013431807ff 100644
--- a/include/getopt.h
+++ b/include/getopt.h
@@ -10,6 +10,7 @@
 #define __GETOPT_H
 
 #include <stdbool.h>
+#include <stddef.h>
 #include <linux/kconfig.h>
 
 /**
@@ -126,4 +127,26 @@ static inline int getopt_silent(struct getopt_state *gs,
 	return __getopt(gs, optstring, true);
 }
 
+/**
+ * getopt_pop() - Take the next remaining positional argument
+ * @gs: State, after getopt() has returned -1
+ *
+ * Returns the first parked non-option (``gs->args[gs->index]``),
+ * advances the index, and decrements ``gs->nonopts``. Returns NULL
+ * when no positional arguments remain.
+ *
+ * Useful for consuming positionals one at a time after parsing::
+ *
+ *     algo = getopt_pop(&gs);
+ *     return hash_command(algo, ..., gs.nonopts, &gs.args[gs.index]);
+ */
+static inline char *getopt_pop(struct getopt_state *gs)
+{
+	if (gs->index >= gs->argc)
+		return NULL;
+	if (gs->nonopts > 0)
+		gs->nonopts--;
+	return gs->args[gs->index++];
+}
+
 #endif /* __GETOPT_H */
-- 
2.43.0

