Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C7EBE7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 12:46:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61D9A8012C;
	Fri, 13 Dec 2024 13:46:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YEfj2VGF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC284801BF; Fri, 13 Dec 2024 13:46:05 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 70113801BF
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 13:46:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso10635215e9.1
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 04:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734093963; x=1734698763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s11seQ0nBLmcmLQyb1bjkuKWamubsNqeB+LsSfF85K8=;
 b=YEfj2VGFpK7DksECl1rNC0wlA2vW9++Ru91vij2HAzVKhccZdDMKpg/Yy4b+MFD82q
 +54hTvFlX1V3zZO1QiHBMSGBh7yWf92czeVU6SajlLiNXScM2ST5U8mlVyPKbb5y+/iq
 SskAU40YC8qQ+r7dCl07qcBSOOJcIrxTMPRKfZsohlNoVcsHqw3/uss9b5sMNXQPUOLo
 A/XnG2836GTKzsWfDCBluCdQbmhvzJX9Xayz+xftdsTcuL9qCE0dniumOetjNuuQjE/o
 ygodtN+jsAT0LIinPopcxAzaMantITDiiE/63c8+aQ4Occnz8KJdFYBVhEayeSIlyB+a
 MzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734093963; x=1734698763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s11seQ0nBLmcmLQyb1bjkuKWamubsNqeB+LsSfF85K8=;
 b=tXDlXVOfI+mgT99ujbDitFm6EW7ui+KWzCWzHQ5llSbCFtZVJ55cNh4zXCECe0QE7F
 Fs41gbkHzmdU7X2WTqwmJ7IeSj0QfMO1BvgbPSmRy0Fx2IuZgYX99PCGQmHtpdQa07Au
 DDZ8Rz6QJdO4VlsxVzKNcUSlMN6hbPaiCyWTP8M2aWZkHALgO252Uap+1GGiqlyOJnu6
 egiFRH+AGJXGwCD/93lwH6qd8hb/eI1Zciw360/y6oupX8VFEZXVl5ruJMPCbM9HVXjG
 OJNqNSXtZlr4LMMkBDfElXjkAGWJSMsFWrrkIoqyja/J4BAe9Q+OLSALqtEKA2itTciY
 L+Iw==
X-Gm-Message-State: AOJu0Yyn2SO+2rURvTOmpzImO1alPN825Ajze6nQVLGpvcOf44GsXnro
 gpoQaKsOMk6MUTUWiS4pFnWeTcYGT/g+pgGeeajCL4SrNbuPlDgOwMw8kfKomP1pnsxHGv7R3MY
 VmQ4=
X-Gm-Gg: ASbGncv7/+oqliZ+u59epDEJPPoWWeEmV7D9vHS6PP17I6yGg/LRN7r+LrPiOHjaPiz
 R0xUQ+Z3LdZdPTZuqr3aqmqPL480Z7ekuNZF2wQohsKFAR9UYyvzgjoD6iczP1R+LDgHbI0KQQO
 TAhFXJf6GgnfcHlXDPE/+AUuOnV0+DdHuPO5V2V8LJxQ7GAgFIJnqjqiozXSdyr8/gXbjGVmyEZ
 4WqO42UPinMwUWigq6MOJjrR3BNk6CMvcS3UeuKaiF6oaONQsE08s4SkL7g/hTx2Q==
X-Google-Smtp-Source: AGHT+IGC78P3nVSvpsPJXfXRQW5WVb+SCAKs7x8F4gYiynEmghUzQOFOuOD18uxbuGSl7d6ZP+5Gqw==
X-Received: by 2002:a05:600c:1c19:b0:434:f2af:6e74 with SMTP id
 5b1f17b1804b1-4362b16beb1mr17913255e9.15.1734093962706; 
 Fri, 13 Dec 2024 04:46:02 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:3390:8f2f:2eb7:90a7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248e54dsm7050988f8f.19.2024.12.13.04.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 04:46:02 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH v2 2/3] test: test_trace.py: test 'trace wipe'
Date: Fri, 13 Dec 2024 13:45:37 +0100
Message-ID: <0e06e3326cc28d8a88eb3f88fa9dccf4bab5bede.1734093566.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1734093566.git.jerome.forissier@linaro.org>
References: <cover.1734093566.git.jerome.forissier@linaro.org>
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

Test the newly added 'trace wipe' command.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_trace.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ec1e624722c..44239da5280 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -70,6 +70,32 @@ def collect_trace(cons):
     return fname, int(dm_f_time[0])
 
 
+def wipe_and_collect_trace(cons):
+    """Pause and wipe traces, return the number of calls (should be zero)
+
+    Args:
+        cons (ConsoleBase): U-Boot console
+
+    Returns:
+        int: the number of traced function calls reported by 'trace stats'
+    """
+    cons.run_command('trace pause')
+    cons.run_command('trace wipe')
+    out = cons.run_command('trace stats')
+
+    # The output is something like this:
+    # 117,221 function sites
+    #       0 function calls
+    #       0 untracked function calls
+    #       0 traced function calls
+
+    # Get a dict of values from the output
+    lines = [line.split(maxsplit=1) for line in out.splitlines() if line]
+    vals = {key: val.replace(',', '') for val, key in lines}
+
+    return int(vals['traced function calls'])
+
+
 def check_function(cons, fname, proftool, map_fname, trace_dat):
     """Check that the 'function' output works
 
@@ -304,3 +330,7 @@ def test_trace(u_boot_console):
     # This allows for CI being slow to run
     diff = abs(fg_time - dm_f_time)
     assert diff / dm_f_time < 0.3
+
+    # Check that the trace buffer can be wiped
+    numcalls = wipe_and_collect_trace(cons)
+    assert numcalls == 0
-- 
2.43.0

