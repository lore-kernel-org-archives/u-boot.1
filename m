Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04403D66B9A
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 20:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D99FC83C0C;
	Wed, 17 Dec 2025 21:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="W9R0boay";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0031E83B49; Wed, 17 Dec 2025 19:43:14 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDD4483B55
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 19:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-44fe6771b2dso1530369b6e.1
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 10:43:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765996991; x=1766601791;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MxCSejA2VlXDaJWDiYw9OpE98IcuilOgAK/0AS2wwr8=;
 b=W9R0boayI4iygdZonPfR/dYuUgsRWm3VrClvERT80B2VlfCRamY0QAeQ6XakKTQAG3
 iGPH/0L4aDmEcgc/XF4YVal4Alw9fHvYUNBmQ6tnekkvNqHMlU3qKn5RG3fmfYSXx3Tp
 4Ouo7MIM6jcnsrxxoHUd3ZU/OVXrRoSb5/YKl6jFg2AjYU/s4TyWJzbvHFOb8ZDANfqC
 TZkPHPxOvj8t6VQyu4St3g3jefT5UeFSzczHrYZk4pS2zP7KM527lKe4dnbPmd6pC1Xc
 VPcLXSBMMpLn1AZ8d3CbtQb0v3Ts4WrxZ95JOWxugmGrMH6J9aqHD5X9jtEO570A8O5B
 F3bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996991; x=1766601791;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MxCSejA2VlXDaJWDiYw9OpE98IcuilOgAK/0AS2wwr8=;
 b=FXFrwYq0Nc78YiYGSmC+XaQ5L8ZR88X8dpqXZQEGOAXfLYeWR/CYHi2FZ0nYXlcopq
 iXrfmoGGR7TKPfuxnnYOfk3hygJJ9pk8h4B/niLSINnzF4HAlqevGyfONTJkQ/mqOcRs
 FzfYwdJU7ZH2Vc7p02UYTihRMvLgENk97CGTASQjspmZui9MI46d9jpzDT0x0YX20nnz
 4Rgrx3Nfqgv+6jgHOFXo0YemVPtM/mjbJ/GB/S/et2gPfYP8I9EO06aq9iEmKdLEM+tx
 eX+pLtVP1I3he5FV4ULIfo2pb6CxqDtP2wAz0j8FbygCN92DW4RDilBu3EMnTUvIgPeL
 236A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMvsBWFlDvHjsltHAXCG5mhyWdbT1cewIRoy0PD69iueafo6s4Y89UcechePttIfQJOWaTFPk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy/LfJ/ozoNfOUG7WkxzJmeXnFkyBPqJPv1FzOM8rtHUbkfhi5N
 a1YpcLlXcWcPExafyqHuIODQIL0eIAgbZRcBkhQqiV5o056ezsIrWOf6ZgOZsVuF85itACFtIHi
 YUmbZ
X-Gm-Gg: AY/fxX7mGxmqSaKcmwmbtJMYPN9fpT7d1KEAsYjALf1F2fvTVW6SOsaEog+8y7vnlVv
 MqmQZsF0zsxo0I4Or5w3aQSaAejhFdl3xEPj5p/UWY8OX4FeA0+FqWo/E2SJV/cYVVYHOK6Khom
 aBH7miRIAXkyxOnsXjl4rZ1FTXOVgX7dKfbiYMOlO9mSe6r89iSOZc44At/MUKfgscnxnjwVtUW
 u9FnKyoz4dhjfbGAk87h1W8MMqmYcjpcoXvMf0jKYtdT4tvBF9I9JlgcAvAITX1UN5UB0MODytq
 9gvLHgPqHXwOihYHeOB01ijvx6BA6BXPfpP69aANA8OEsT/iTV2EOyolxhn8z2F/NgYFOLaU4rQ
 tkGKYbXaOr6iHvn6H1+Wsh8WtizOaecuZ4cMTILkpgc8ww3BZnV7j6hcm6U7TTyf6GqP8RkONTl
 pUG+pl99MBWvzwvQ==
X-Google-Smtp-Source: AGHT+IFlu4grOp28zXZjfi4YfdWybV5H8NmGbvMeekii+Xjoy186t0aSp1sIb25M1SSRxObpJjpOSA==
X-Received: by 2002:a05:6808:3509:b0:450:c8c3:7106 with SMTP id
 5614622812f47-455ac7f6d52mr8180277b6e.9.1765996991365; 
 Wed, 17 Dec 2025 10:43:11 -0800 (PST)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:11a:676d:852f:9349])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fa18021a81sm91782fac.20.2025.12.17.10.43.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Dec 2025 10:43:10 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Dec 2025 12:42:09 -0600
Subject: [PATCH v2 1/3] test.py: check ubconfig exists before using it
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251217-a-few-test-py-improvements-v2-1-e1f91e3bf551@baylibre.com>
References: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
In-Reply-To: <20251217-a-few-test-py-improvements-v2-0-e1f91e3bf551@baylibre.com>
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=bJhkvNHeJn+tdEbGjyJnKtBIMtQhBV9WMm/YO+F+35w=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpQvmnMao+WII+1Q7yFlF+sxOBVaWPu/QgjS2Vi
 2NYafD7fDmJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaUL5pxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AUNgH/0rRL7NG91gwXKePDAqh6G0kRO1qfSvX5SLRIMw
 SH7LbRa5iEti5j1A0Hug4/ucS2ytOYnVhQEED9xLF+OPVtqUyqNMrCZo55xR75rdspadAJDuNjP
 gGZkCY2AbFWDnL4ljM89s1qeN2kwkte2jEy30O2hl47dlmm8+TabtvDdwT4uJ61zeGeR0aeYFcf
 P1IBnLhbEKgJw4aWPWEBcXvh/dOrV/GoWx5fc5woL2OvSzbEIx3rfORbMYYsdStRZFUA9LWJdkN
 HpfTH8Tj1FUhtfqGkJ4msKbYih8Kh6f3cBeEBXfI6ihdTQidttMlAQbKHHY2hC0VmjstawP/B3K
 GYFc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Approved-At: Wed, 17 Dec 2025 21:08:13 +0100
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

Set ubconfig to None and add a check in the show_timings() function of
test/py/test.py to ensure that the global ubconfig variable was actually
initialized before access attributes.

If tests fail early, e.g. because --build failed, ubconfig may not have
been initialized yet and results in an exception in an atexit handler.
Adding this check avoids unnecessary noise in the output.

    Exception ignored in atexit callback: <function cleanup at 0x7de475ea6b60>
    Traceback (most recent call last):
    File "u-boot/test/py/conftest.py", line 669, in cleanup
        show_timings()
    File "u-boot/test/py/conftest.py", line 616, in show_timings
        if ubconfig.timing:
        ^^^^^^^^
    NameError: name 'ubconfig' is not defined

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
v2 changes:
- Set to None and check for not None instead of using 'in globals()'
---
 test/py/conftest.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/py/conftest.py b/test/py/conftest.py
index 8ce680a92a0..5689fcd0349 100644
--- a/test/py/conftest.py
+++ b/test/py/conftest.py
@@ -28,9 +28,10 @@ import sys
 from spawn import BootFail, Timeout, Unexpected, handle_exception
 import time
 
-# Globals: The HTML log file, and the top-level fixture
+# Globals: The HTML log file, the top-level fixture and the config container
 log = None
 ubman_fix = None
+ubconfig = None
 
 TEST_PY_DIR = os.path.dirname(os.path.abspath(__file__))
 
@@ -613,7 +614,7 @@ def show_timings():
         if too_long:
             show_bar(f'>{get_time_delta(max_dur)}', too_long_msecs, too_long)
         log.info(buf.getvalue())
-    if ubconfig.timing:
+    if ubconfig is not None and ubconfig.timing:
         print(buf.getvalue(), end='')
 
 

-- 
2.43.0

