Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 214AFC71136
	for <u-boot@archiver.kernel.org>; Wed, 11 Jun 2025 20:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 620E082CC9;
	Wed, 11 Jun 2025 22:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uuWmJ6rS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD0CF82B63; Wed, 11 Jun 2025 22:25:19 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1D9382CE7
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 22:25:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-442ea341570so1308775e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Jun 2025 13:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749673517; x=1750278317; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gyGXDkHLx9118TFNH0C/SmTYkkuq81Vl+KQfxSnbIl4=;
 b=uuWmJ6rSEkSLQRTUjdMeINdXLlzMV1AqFIbYwYol7AVrGelajbNr82Mf5QN/yaNabG
 +bCloXogmtC8yVEYf12cSisrrDORqwyHyslszqLt5EjqHvZNDmmhsg1sKnAbMjCR6YlF
 WT5VN5/F9vsfZxggnq6RcfTgAWz4Hj3KM8Jk8TYkaFApFBw4W2DfN41sVeniXDlJCGz9
 FjmfT+NNJj3/zVMCBfWOA8sBVlse237W2u9uRgYWGg11QoVJKcNBoFVfwM+Yi/LZWR68
 PrVg4UrCQnADn/vz0veHXd9CLc/LlDleYC6ZSLS+CgCYzZkLveknQrzAfyL/OZRMb9Bu
 1FSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749673517; x=1750278317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gyGXDkHLx9118TFNH0C/SmTYkkuq81Vl+KQfxSnbIl4=;
 b=jj8mEeodMJi3aUaF/Xs1yqutqjSMcs8Rp8MDMk1FQ226cT+Of/iu4iHphlnlPWn4md
 5RIv4XuPSZQqZlmGlaAY/ARANtm8as8edlJXLrpuzhcKd4aLrjnslFWe8HnSNmCuvB05
 Te5tqnrnMC+yoP8rZWUsbshQTLOnX5qYEoYHt0Fhx54JdSr0O5DYbxxV+rY2zSCcV/cJ
 AGjeUF2/If0qOq1EeWU8Mig6G7jVwt/KzlFMA2Ak/Q7Y9jUYPNIhg4fd4kKjZVIOjHNr
 LZDK0MfbB+Ez1QzpjtDl0cmDv8z8SoclPwik1ge0nJp8WqvvAy9x2M63akGy5LdVgQ43
 qSRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOex55C5CLkhpaA4VGVO65Hn4FDxDeGnGeZ0VImvPcbXpvPQJ4Xxh/OtbV8ZEz1a5+xWFmCqg=@lists.denx.de
X-Gm-Message-State: AOJu0YxSPWNyEaUa1tYlDENiADXd7ExfqZRzotjedzhKbRkphMYd+BZA
 XplV4DKA6ow/gcd4e0V1QGKyebHON10vHMZ8tg2JBfSWVc93r71e4nuWTAmc+fLQE10=
X-Gm-Gg: ASbGnctfQFbTnCQXaPSy1SsLldjnAsVZ15p89XLJ6jwvi00f8J4JDt05FYOu1XO/3og
 A3Ik55J96rwAKPKN9pede50qEfivNQ2da5R6NnMqjfZ3N6UeMe1Zce2KnbwbA7bX6cjTSCJND/z
 PIIQUmk19tlmxJNQdpCJpBjvjnKBaukLUhwlbB/B/H9XGjzhpxPy1gajk6b/y9xB1vX7cPLbQNi
 lnUpFsGbFbkDx+wSf4hFgoQS95Jbs5dzpEsDi8l9u6Yt0RN562C/hF/ROaEHo9m0u7P3KfmtdJu
 cU01FWPZIVh71LTuZDYrEINQPUadOHcYANKafEbbCGFUgLL9QlW82rzYGxy1ngej12cGtyxhPY4
 B8rRJsNy7nWcyuE5ZWR7qnGBFR8R5WiN6GZnQJLtX
X-Google-Smtp-Source: AGHT+IH6UldHWlbkrKgXK1abbqpBpzkBh2TG2MW5k+/d7L6mwsZ2+uup44rrExOaetJBCQn3f3Q8fA==
X-Received: by 2002:a05:6000:40c8:b0:3a5:39d7:5d5d with SMTP id
 ffacd0b85a97d-3a56072919fmr619549f8f.36.1749673517427; 
 Wed, 11 Jun 2025 13:25:17 -0700 (PDT)
Received: from localhost.localdomain (ppp089210105145.access.hol.gr.
 [89.210.105.145]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a561a3c538sm12071f8f.50.2025.06.11.13.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Jun 2025 13:25:16 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: trini@konsulko.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <ziyao@disroot.org>,
 u-boot@lists.denx.de
Subject: [PATCH v2 10/13] kbuild: skip parsing pre sub-make code for recursion
Date: Wed, 11 Jun 2025 23:24:37 +0300
Message-ID: <20250611202449.2317279-11-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
References: <20250611202449.2317279-1-ilias.apalodimas@linaro.org>
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

Backported from kernel
commit 221cc2d27ddc ("kbuild: skip parsing pre sub-make code for recursion")

Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5dad1aa57f70..4e339ef4bb9c 100644
--- a/Makefile
+++ b/Makefile
@@ -51,7 +51,7 @@ undefine MK_ARCH
 # descending is started. They are now explicitly listed as the
 # prepare rule.
 
-ifneq ($(sub-make-done),1)
+ifneq ($(sub_make_done),1)
 
 # Do not use make's built-in rules and variables
 # (this increases performance and avoids hard-to-debug behaviour)
@@ -176,17 +176,18 @@ MAKEFLAGS += --no-print-directory
 
 endif # ifneq ($(KBUILD_OUTPUT),)
 
+export sub_make_done := 1
 PHONY += $(MAKECMDGOALS) sub-make
 
 $(filter-out _all sub-make $(CURDIR)/Makefile, $(MAKECMDGOALS)) _all: sub-make
 	@:
 
 sub-make: FORCE
-	$(Q)$(MAKE) sub-make-done=1 \
+	$(Q)$(MAKE) \
 	$(if $(KBUILD_OUTPUT),-C $(KBUILD_OUTPUT) KBUILD_SRC=$(CURDIR)) \
 	-f $(CURDIR)/Makefile $(filter-out _all sub-make,$(MAKECMDGOALS))
 
-else # sub-make-done
+else # sub_make_done
 # We process the rest of the Makefile if this is the final invocation of make
 
 # Do not print "Entering directory ...",
@@ -2549,7 +2550,7 @@ $(cmd_files): ;        # Do not try to update included dependency files
 
 endif    #ifeq ($(config-targets),1)
 endif    #ifeq ($(mixed-targets),1)
-endif	 # sub-make-done
+endif	 # sub_make_done
 
 PHONY += FORCE
 FORCE:
-- 
2.49.0

