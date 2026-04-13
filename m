Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D81CF34C49
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 13:02:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AF718422D;
	Mon, 13 Apr 2026 15:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RGA/PMem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05C8984198; Mon, 13 Apr 2026 15:01:44 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8DCE84227
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 15:01:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7dbd23bc684so2507562a34.2
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 06:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776085298; x=1776690098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9Tn0VH4oSx3AdU4sU7QfHuzg3FL0kz9+OT6yTwOMuk=;
 b=RGA/PMemTcFIWGbvkO2iJ6QFNZWDc2OftPzhb9uW0msDzxZHEUTiR4jL9wxhueliZ5
 CwcaOI3Gk80dPcdGo0tjPIYgkXXU0XaVtZFoDEnOgN5t3wLTy3tZeY8GUy1A8lG+Kypi
 jrUKOQbDYudQ2m2pIT1GVrr2oYx9RoPMaVIsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776085298; x=1776690098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9Tn0VH4oSx3AdU4sU7QfHuzg3FL0kz9+OT6yTwOMuk=;
 b=fBYCv6wAY7KzIDKoJcIzD2McllFnJPVuRYTOQ31tctcu45N0BVA3jb/fx2EozNRcRS
 MIYzs4fxAwm/NcR4h4o4emzOt0SKhYzB4zDLq8KYD6IW7g7hvmJoxYvysusX6YgIJg5d
 FcjtJ0B+TsouvucLN2iUeUvM6U5HRoVY7DKkSovoOg4fpp+o8UWcUV4Y7kqy5IKAfelN
 9vpJuK0F7J9rxqT0dky1PsRjHT/IFwOnDKMQvR2UE33ZCBPHpEmiD0cuStF5ptCqzRyJ
 8QpXanVqQ8scr1vPdoL8ep0vm68BucHKhyBOyF1hcNESZ2HLOkSJQ64jFL2VorE/CMUL
 2t5g==
X-Gm-Message-State: AOJu0Yzv+LCKItfa+FwttRP5v274URC9jTRARnjmXO/RIauzLpaIefT6
 EkhfOkbKXlYBGdcIfcssMqlnIwWByFHblD1QQJKaA4FnySI5e2L5W7uT7Ir9ORURx/UTykmqiZ7
 UbvD3fw==
X-Gm-Gg: AeBDietwWKVm8pNBr6115yh8hF22DZX3Y2EJNCLD5jv48AHu1CqdjTBOcOelbPF/5aw
 KfhCl0HuXwwv0+ohuDymFmH31cavTyUyu0/M9wo4yBwcu3XnZo9CRmv6ocFzJsY0L1/pZnQ21bk
 ccGiZeKs05NvNkD2J+rlaraRda158nUrFaJHlSEmpmO3FE8S5WnkUarwJOmFVqvzevtNB5nmsBb
 NRfZO/zRqoQqB8xlNcfsZpDFVQKpurG1CsLzqUGa/DttsSoO+sjvLOfr6JX2EWSA+nOfHUB7dXC
 R0Uk3eDft/gwFat/7+itbPrzywxGy+tgY1Y639ZfUvY5nZtfKW7QehGt81yfL0iUKRh1TxAvTdp
 22j5IeVt4jxMZS5sE22LR3vK80O0Hd94MphQo4H/C5HcwGrX0waZjqDum+1oEUAyeXqp9gAqODu
 c2tCc0WF9QSaN1OynWRw==
X-Received: by 2002:a05:6830:25c3:b0:7d9:d483:e0be with SMTP id
 46e09a7af769-7dc27f2d63fmr7398028a34.25.1776085295369; 
 Mon, 13 Apr 2026 06:01:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc2696532bsm8369144a34.21.2026.04.13.06.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 06:01:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 5/8] test: Update fit test to fix a few Python warnings
Date: Mon, 13 Apr 2026 06:59:56 -0600
Message-ID: <20260413130007.1987326-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413130007.1987326-1-sjg@chromium.org>
References: <20260413130007.1987326-1-sjg@chromium.org>
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

(no changes since v1)

 test/py/tests/test_fit.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_fit.py b/test/py/tests/test_fit.py
index 9bfe25c0a51..6a8649792cf 100755
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

