Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6282E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:32:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96273896CD;
	Mon,  9 Dec 2024 16:32:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HyGmg2fb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E182896CD; Mon,  9 Dec 2024 16:32:37 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E132A896E4
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:32:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-434fe0a8cceso5648325e9.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733758354; x=1734363154; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GV3g14i78FTlGzNDiVOWexFAol6X9xHVY1yVWGsGDr4=;
 b=HyGmg2fb77Kd2239GsG3d+evMrElKEAPZe1AIJ91Kh8oi1osPKXgolM+eLCiCkDRpY
 ldXd34LAK7RpbT1I8gQJfYqIFptk6F3ELMCm03VEKqC1168oXA9ayyol5AUBxy/TDr/4
 kCerHFxIQ3w8aUADDopCdptZyxKX5JapvJL43QOQFbK0k1ao3EfcRgEMJflHwM5Sz92m
 DgtgxHMoaZpQW287CRst9J8DWf9pR8WtDgTTuVYpmUgxtjJqEY4bupjKBa3Y7W0+RA7P
 43Oz+CXxg+lO6KR+DMnQudDFWIybLhZtWUOujANKO+CRq/n1DfkcaI2PEuAYuVV6BSGD
 QAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733758354; x=1734363154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GV3g14i78FTlGzNDiVOWexFAol6X9xHVY1yVWGsGDr4=;
 b=P36tLwIRQHtraMQ7bkYjWQDZylSjPlt/+UAi6tXu6ssUI1bKFJORZNraJaxcDpm4Dz
 iqnovFlqpM2oJ5tmjPs8XC4yBiS1LDq7yfWwyWuhLVOjjlQpuYqCb8pvZedDcFwTxXnj
 Uvt4/gmDQuKKyQSqmq/y1JJ21GD2fSsy5ghVo2ppm0GxpmJkz64707HRcTvu3LaBvuOq
 W5in70j7a+Jay4tloIFapRM6js2T38jisyNqzZlbucun1MbzPBZ2V5rw+NLGZoN5+s26
 VrDxZbSLtLsmWztbiyafzDMzWVCJFq9q9FQNA7CswRFtb1J/y2KFHIu7Ep0yM1q4IgRV
 8fFw==
X-Gm-Message-State: AOJu0Yy7EFVk2UpzPcCsjij/47Q0/tUL6VEv0+BunUboh1XdbP8kuxMa
 CBKMkd6DpR/rUCsFnEEpi7jPpJWYwo4QeWHehjdoX/uVBrJrpnujtv6yk2EX/qLRCEeMj68QxCv
 Xdd4=
X-Gm-Gg: ASbGncttk7UCnWP1wbgg4vK8fuFg2Y98X5f5e6m4/75PTZEVxd2mECcg772r8Xbgoqy
 af5rjopPMGM8AhcO376NE0ov3Ces+SNueit/tiAYy0u3YpoP72ruqSMGb5mb4my3DFZGR4O4k4V
 SyyFQrOpEIJ0+y0LCjqgTe8+Dh8COkR9JR9it0ODhaj6ZYbC95lpDkjMl0snmZntcSG3SaKYDl5
 8cD81PZeprW46BjhOF5CXHtD3VunC/bNX3TGbd2y6XyY09QPCqg3cr2p5g=
X-Google-Smtp-Source: AGHT+IFSYyTzkWQ/seYaqvODIJtw0G5O2zd3lWg6jcrTY3Rb1zWytjwd6kO8FlzomQyEDAlEo9k8MQ==
X-Received: by 2002:a05:6000:1846:b0:37d:4647:154e with SMTP id
 ffacd0b85a97d-3862b333747mr10386997f8f.9.1733758354113; 
 Mon, 09 Dec 2024 07:32:34 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:144b:1fbf:fd90:f158])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f55733d2sm53000415e9.40.2024.12.09.07.32.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 07:32:33 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 2/2] test: test_trace.py: test "trace clear" command
Date: Mon,  9 Dec 2024 16:32:14 +0100
Message-ID: <a23d88947ef928e3492445796855db2c00d64b2d.1733757864.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1733757864.git.jerome.forissier@linaro.org>
References: <cover.1733757864.git.jerome.forissier@linaro.org>
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

Also test the newly added command 'trace clear'.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/py/tests/test_trace.py | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/test/py/tests/test_trace.py b/test/py/tests/test_trace.py
index ec1e624722c..29c115275da 100644
--- a/test/py/tests/test_trace.py
+++ b/test/py/tests/test_trace.py
@@ -70,6 +70,32 @@ def collect_trace(cons):
     return fname, int(dm_f_time[0])
 
 
+def clear_and_collect_trace(cons):
+    """Pause and clear traces, return the number of calls (should be zero)
+
+    Args:
+        cons (ConsoleBase): U-Boot console
+
+    Returns:
+        int: the number of traced function calls reported by 'trace stats'
+    """
+    cons.run_command('trace pause')
+    cons.run_command('trace clear')
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
+    # Check that the trace buffer can be cleared
+    numcalls = clear_and_collect_trace(cons)
+    assert numcalls == 0
-- 
2.43.0

