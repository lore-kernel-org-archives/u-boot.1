Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B21FEC102
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 19:44:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5B5083AAB;
	Tue, 24 Mar 2026 20:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VvyYARil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9A9C83E4C; Tue, 24 Mar 2026 20:43:40 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF22583AAB
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 20:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-40ede943bf0so2137731fac.2
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 12:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774381415; x=1774986215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXB9QcYi+lytoxOmcv79YoRHgade1tinNTkKeTLm3ec=;
 b=VvyYARilUsyHzbt+V8b5uSomWnZvXR26emGAEiiIEaRklf8BTUJowsSir5DE7jo10/
 r6yEH/vFXgauw9HtxmNphNteQlOZCJuXui6CUG4nuFKTWRdGPYr79gH3nt2NfB+ycRUf
 eaDdbGTkkwtvNcNsO6Mq9NpKDgLT0QQeQq6vc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774381415; x=1774986215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXB9QcYi+lytoxOmcv79YoRHgade1tinNTkKeTLm3ec=;
 b=QATRf7SbfWZHJbWBXHBoWnTOLhKfIRYy9qnrjZGIqtTvb4KVU9fZJa326Di33Pge3w
 i2Kaf3138nxsArqKv1Mwn+NX25IENmqWKAlG6JDz6BcrUOIk5+i/unramaPEG5ed7wDY
 oAF8hD7Hn3Rej8i2Sl/DoCTk4QvrY9GuG2GZIh+GDBRwX8IkFjIAmYuHX+C2HmSlCU+p
 aRc9oeEyWLVWBvcRChH0xSG5BUL5ShyIWk6IOBNsFMhJyOdmoIDRs7P3My5fg13CDZFm
 dn8HFqaWiy8Qmxm3tyqg0kmRp2q0TPeiUYbi4wiBo4ymEcXaOfRPdNnzqAvV9dPlEqh6
 fYZg==
X-Gm-Message-State: AOJu0YxRYFOMkimo9SYN6WD9nBJ82GkJmVYZWW1V+nKI+h1pq3R6JVn/
 8VdyVjeS2CzLrAtzNWzA9Uqelx1gS1sfYSclq3Ff0EdmsUnk01R6sa7cGrhbH2EGcXRlbS1n4vv
 DGsdxLw==
X-Gm-Gg: ATEYQzzWSPuQPcnAuzofXJer7aRTra7C4CWtjzfOEtN8S9+5xvKnphi3YyJVm4DD1Hc
 A55lZAVkazn9FDMvySu0mM7fTcvpARed9yq7mpkQYxCUolw8nilLx2btGADwxpTJ8gDinziGn9c
 42qeH5C+oNwxwwH5q2EreEDQjmgBEL1lYBTCnt4dxJSJ4X2WFzWNK+ZUQvvxizPOxWDHgwOJuWL
 xRJa7dISStEnwMFREGtbmQLhwB94BXcDzMEADcGBB9a88rszIrXKmTv//lU2x9riaHY1UbwZwEf
 dJwddys84ZwUoztkO8hQa9TasPmD7WlRiuDFxh2b7dEPNM2O72NJ36zOsDgJtmd4bZBhYOFWn5Y
 PUuYiyORlkWS1QmbCqGl5wd/34/hL4qNQBFPPpQfyNK4MbpY5PLSJ0UvcqzKGZff7DCjOAx136G
 PwdV/jzviMQm8gIlpG+/UyBY2l3A8R
X-Received: by 2002:a05:6820:1c99:b0:67c:2b28:ec95 with SMTP id
 006d021491bc7-67dff3cfa75mr561851eaf.1.1774381415486; 
 Tue, 24 Mar 2026 12:43:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c88218654sm3714784fac.17.2026.03.24.12.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 12:43:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] test: Update fit test to fix a few Python warnings
Date: Tue, 24 Mar 2026 13:43:19 -0600
Message-ID: <20260324194323.2335679-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324194323.2335679-1-sjg@chromium.org>
References: <20260324194323.2335679-1-sjg@chromium.org>
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

Fix some warnings and disable one that cannot be fixed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_fit.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 811bafaf94d..b3a08bedd70 100755
--- a/test/py/tests/test_fit.py
+++ b/test/py/tests/test_fit.py
@@ -1,13 +1,14 @@
 # SPDX-License-Identifier:	GPL-2.0+
 # Copyright (c) 2013, Google Inc.
-#
-# Sanity check of the FIT handling in U-Boot
+
+"""Sanity check of the FIT handling in U-Boot"""
 
 import os
-import pytest
 import struct
-import utils
+
+import pytest
 import fit_util
+import utils
 
 # Define a base ITS which we can adjust using % and a dictionary
 base_its = '''
@@ -160,8 +161,8 @@ def test_fit_base(ubman):
         fname = make_fname(filename)
         data = ''
         for i in range(100):
-            data += '%s %d was seldom used in the middle ages\n' % (text, i)
-        with open(fname, 'w') as fd:
+            data += f'{text} {i} was seldom used in the middle ages\n'
+        with open(fname, 'w', encoding='ascii') as fd:
             print(data, file=fd)
         return fname
 
@@ -202,6 +203,7 @@ def test_fit_base(ubman):
                           'third_line:')
         '30'
         """
+        # pylint: disable=W0612
         __tracebackhide__ = True
         for line in '\n'.join(text).splitlines():
             pos = line.find(match)
@@ -209,6 +211,7 @@ def test_fit_base(ubman):
                 return line[:pos] + line[pos + len(match):]
 
         pytest.fail("Expected '%s' but not found in output")
+        return '<no-match>'
 
     def check_equal(expected_fname, actual_fname, failure_msg):
         """Check that a file matches its expected contents
-- 
2.43.0

