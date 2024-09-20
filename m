Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBF7CF58D1
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 06:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E23089359;
	Fri, 20 Sep 2024 08:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j1ubulTv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DA689325; Fri, 20 Sep 2024 08:03:11 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A7C89344
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:03:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a7a81bd549eso188518166b.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 23:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726812189; x=1727416989; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=By6LLmlNfpGYfC8hRJlbuluca2yelOebJvJPu9FgFiM=;
 b=j1ubulTvPqkExq5ZLnKmjvpSgjV1SvhUCl4trippaqJ11/U2F1sUgOPXs6d7wOWR1I
 E+YWYFRib7c2fNfkvvv5WXqsoDzgVPjaq8Uok1Z7jlMuuMtPAy9dKGUeP0bi98H36c9I
 lro+nHZe3pGDzp9EXMMxiSFIfD4+6L1+RXrnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726812189; x=1727416989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=By6LLmlNfpGYfC8hRJlbuluca2yelOebJvJPu9FgFiM=;
 b=l+DT2hFxDB7bAmO/78ZWDSb6qnZWfDv+6AB0oPkRmVv7XBQ3OxG3sGm3fngnV8ohoD
 uNo2xXQEuOCz1zkCw5aZqsLQS/R7+9Kzuvg2L6Cpk6ukE8LtHmZwTxNLUEWusdR+pFCf
 EPivnIiCz4RNM2T/4EwBfADfmsr5sppKI6j7uJtmFCMxQrDLNtAwGcVNmZhlg4KX2NLI
 l/j3Yi5ksLdOeQS5yrTaClJjdeBWvUY5wH0zca9xe7MuqDSzAyK+ErBuL6jRqXqsiEzc
 qtCzfoB/tbH2l0tcYXSmgu7iQPC8Y81arPWB/iEgC4y0eOsquvXffuVAjlrJcx1RyZn4
 4gqQ==
X-Gm-Message-State: AOJu0YxT5BUSVg6ggHOaJWGvuP/IFtLdG/gxzlyaAqWL2Qr1lrR1RyC+
 38DMU8DKZsJk9O4oYjw/Q/s66JyQ2cc92849UyLJK7Ey5oDT8bYFeyCox4RPuK1sW3KsIa8p+CQ
 x1k22
X-Google-Smtp-Source: AGHT+IH9rFCtqUbUiWfuhpGK9kZFzNZP8fTjt5qPjie6TRMLE2hnzKiW7bVVvREX47epqIY6Ej4fVg==
X-Received: by 2002:a17:906:d261:b0:a86:80b7:4743 with SMTP id
 a640c23a62f3a-a90d4ffddf4mr125564466b.24.1726812189171; 
 Thu, 19 Sep 2024 23:03:09 -0700 (PDT)
Received: from chromium.org ([185.44.53.103]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df750sm796420666b.160.2024.09.19.23.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Sep 2024 23:03:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v6 11/19] test: Tidy up remaining exceptions
Date: Fri, 20 Sep 2024 08:01:46 +0200
Message-ID: <20240920060158.106612-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240920060158.106612-1-sjg@chromium.org>
References: <20240920060158.106612-1-sjg@chromium.org>
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

Use the new handle_exception() function from ConsoleBase also.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/py/u_boot_console_base.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/u_boot_console_base.py b/test/py/u_boot_console_base.py
index fa87952694d..9474fa87ec9 100644
--- a/test/py/u_boot_console_base.py
+++ b/test/py/u_boot_console_base.py
@@ -14,7 +14,7 @@ import pytest
 import re
 import sys
 import u_boot_spawn
-from u_boot_spawn import BootFail, Timeout, Unexpected
+from u_boot_spawn import BootFail, Timeout, Unexpected, handle_exception
 
 # Regexes for text we expect U-Boot to send to the console.
 pattern_u_boot_spl_signon = re.compile('(U-Boot SPL \\d{4}\\.\\d{2}[^\r\n]*\\))')
@@ -294,12 +294,12 @@ class ConsoleBase(object):
             # indentation.
             return self.p.before.strip('\r\n')
         except Timeout as exc:
-            self.log.error(str(exc))
-            self.cleanup_spawn()
+            handle_exception(self.config, self, self.log, exc, 'Lab failure',
+                             True)
             raise
-        except BootFail as ex:
-            self.log.error(str(ex))
-            self.cleanup_spawn()
+        except BootFail as exc:
+            handle_exception(self.config, self, self.log, exc, 'Boot fail',
+                             True, self.get_spawn_output())
             raise
         finally:
             self.log.timestamp()
-- 
2.43.0

