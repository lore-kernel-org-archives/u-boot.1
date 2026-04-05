Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A443BE64019
	for <u-boot@archiver.kernel.org>; Sun,  5 Apr 2026 11:13:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F08384120;
	Sun,  5 Apr 2026 13:12:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f2cqyUMh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42B078341A; Sun,  5 Apr 2026 13:12:39 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD1484020
 for <u-boot@lists.denx.de>; Sun,  5 Apr 2026 13:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-40ea611d1a4so1308047fac.2
 for <u-boot@lists.denx.de>; Sun, 05 Apr 2026 04:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775387554; x=1775992354; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+9Tn0VH4oSx3AdU4sU7QfHuzg3FL0kz9+OT6yTwOMuk=;
 b=f2cqyUMhs+vjm58TrNRhixjqOIkiqEixYRBYkQfGVZ1ye+XyWfzsH4af91jxR2W0hK
 BfDPUtezLR6MDgbemTjM9PNCoXZHI/0FXdha0Hnk41894NvO4M+jelhGh4b4P/B9gmTk
 xMCq0WumB3gbZ74aX7qwaKB9FbqzC0STlEe3Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775387554; x=1775992354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+9Tn0VH4oSx3AdU4sU7QfHuzg3FL0kz9+OT6yTwOMuk=;
 b=flmBT4sjwqsmySpnVv1dg7mFTsL/6Zl/thUEjMyfTN+VNIJ/4icHr0Aphw9LBpYHIQ
 iBhD9g2EhLrPa4C8JqxvCJupnkf6RVUnYa6tkDxZ2xSygrsC7JvtKwlU8rWxWUUF3W7c
 1yigtWU/1ctCrCW2z8lBAXhjzXrUqkYsXyuO43KaZRzidTv2x1VMi8BPAs6ndQLsnQOK
 XWoVaGuWsBNl3aD9DLtTh4oMDbVNuR8vhIVZYegDRMaCl6M17bcTdg2FZni5DCM1hRmr
 Cg07yLsXj8HqHeMcIQ/FkwXyUvDS7pFfkvZZzxfcbN/vwq3VBo4lcu5IZQ5TGrtMGgZ9
 DSpQ==
X-Gm-Message-State: AOJu0YxDJZJZdGkynjgppqLkih52JdHAQ8dK5Sc90Zqs87uuBLC+tSWX
 maeS3oGl2xvJ+qmpctOGxE/KC7N/8sXv2k3uO5oJhcvZaGanjTBzs/j7YaM3kLarwD67i0+4iCc
 gABhlzA==
X-Gm-Gg: AeBDietPebimB3V7e95nQEBr450NOChwrQCOa2ZDPhz744xZTxuFEHS5/HmomMnR7zN
 J9zmDRp5kNkyH2p/jRWxbAYgazv5WNz2C3t8idCDBgsKY1tolFucb0puZbIlPd090Io8ObVBE25
 lKwuEJm6E4WQvtF6rqOFK6hUSr8ADMHt8QmZ4m06hdnanVoTTNC79Z3UWHuLTHmX49bOJN5f5Xt
 QnIPbr8J9FwIW2Jd/g41wYPQBABkxyQp3s+N8713erjmTNN9DcMn/F+gndtnBS2rgO5rlgfz5Ku
 ZIZX7PkzJj/ofY5XVdajqanLM/vv5esvUGv2wCNfGCkgB8ZYP6OTdZ6wGIXJjNYowQr0e3FiHmm
 sDOoCENpLH6JIqa7HwSNhEDtPl4w/MaYAMAW/Big0nxsFav5IbQKVBLGRBwa7aQMj6wVdzvLXSI
 pqMa7cPBO75xelIxej3Q==
X-Received: by 2002:a05:6808:ec2:b0:467:f636:23bd with SMTP id
 5614622812f47-46ef831b60emr4471184b6e.42.1775387553841; 
 Sun, 05 Apr 2026 04:12:33 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46d8d109b69sm6414382b6e.0.2026.04.05.04.12.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2026 04:12:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 5/8] test: Update fit test to fix a few Python warnings
Date: Sun,  5 Apr 2026 05:11:50 -0600
Message-ID: <20260405111206.945185-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260405111206.945185-1-sjg@chromium.org>
References: <20260405111206.945185-1-sjg@chromium.org>
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

