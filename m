Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EA94C7114C
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 22:56:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C350886F9;
	Thu, 29 Aug 2024 00:56:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l33qmBa2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA3E486E61; Thu, 29 Aug 2024 00:56:16 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C179888C2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 00:56:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf9db9740aso227846d6.2
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 15:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724885773; x=1725490573; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3xNTeMJWuP2ZrHUr1Xvtf0D4CVv+dfpsduLt8MdCmFw=;
 b=l33qmBa2ubU9efCMD21RVPTZeoAFbbijbRZTv6zLOssc2kSI6nL+3NcFFwe5rfSakL
 tGd3dlj4QjgdWHsuQlySUfgQBiZKVV3aPhD/50pLsqXfxDI9OtjhTi9t7q/1H8Kn7oV9
 DUZUO2lGVuSeh3y+lLw3ZIwaf+Osay9nWC04w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724885773; x=1725490573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3xNTeMJWuP2ZrHUr1Xvtf0D4CVv+dfpsduLt8MdCmFw=;
 b=ucuackwOm6F9u3/qf8rdmMPpiSCdZErsEd+47LJ4QyoWMqB5yRJy2ys5GgxqhSLSUO
 7wrs0Wgy+hMKgc4y8hpVjrCcFi764Y4NvYFRURqTaqTyuFOnP6aXHmtszbi25qlo6AoF
 qHIs0LDcJhbb2xKcV+jcbNKX7WRwmjq7hmhK89TeWRHyrVQrOblf1S6H8rNla/KcmpP+
 bMeeZZ+L3QPFt6G8xnFPHpUmqQdIXFtL3zHIu2uDzw/1zJgk861w24eA7ybr+9ZVl8PB
 N1m32XvJAF8tB891zwf2a78vsHFS2foAQC8rePaQshMIPS6cEw5UxOrA2LLntYcYJbGv
 5Dxg==
X-Gm-Message-State: AOJu0YzWXu7dZHQPVLrYszb41RMekmM02Lm9tpFApx7a880JLPmu5tG4
 ZWVkKriXJZcix7O3LL1NkokdKK85XpuJLIAbvffbqPMtjJgHjmTh75kWwUlUbmVUPcXUCg6Wf1C
 x
X-Google-Smtp-Source: AGHT+IG6mYJLpb3VB/N50USfoJX+GYWL/t2mGfn+VYp2lvtILVpvR3hNiNOSuIkb4S7G1D44B/waqg==
X-Received: by 2002:a05:6214:4a8b:b0:6c1:6acc:767e with SMTP id
 6a1803df08f44-6c33e626d27mr13697296d6.14.1724885773373; 
 Wed, 28 Aug 2024 15:56:13 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c340c41e42sm216806d6.65.2024.08.28.15.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 15:56:13 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH] test/py/tests/test_bootstage.py: Combine stash/unstash tests
Date: Wed, 28 Aug 2024 16:56:10 -0600
Message-Id: <20240828225610.3081635-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

When running the bootstage tests currently we get a warning like:
tests/test_bootstage.py::test_bootstage_stash
...PytestReturnNotNoneWarning: Expected None, but tests/test_bootstage.py::test_bootstage_stash returned (37748736, 4096), which will be an error in a future version of pytest.  Did you mean to use `assert` in stead of `return`?

This is because the unstash test will run the stash test and fetch the
addr / size from that. Rework the test to be stash and unstash and then
run the unstash command at the end of the current stash test.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
It's possible we could solve this instead by getting addr / size again
from our environment file, and then also noting that order-wise the
unstash test follows the stash test. However, this felt more clean to
me.

Cc: Love Kumar <love.kumar@amd.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>
---
 test/py/tests/test_bootstage.py | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index a9eb9f0b4a11..bd71a1af3a25 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -33,7 +33,7 @@ def test_bootstage_report(u_boot_console):
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_stash')
-def test_bootstage_stash(u_boot_console):
+def test_bootstage_stash_and_unstash(u_boot_console):
     f = u_boot_console.config.env.get('env__bootstage_cmd_file', None)
     if not f:
         pytest.skip('No bootstage environment file is defined')
@@ -55,13 +55,8 @@ def test_bootstage_stash(u_boot_console):
     # Check expected string in last column of output
     output_last_col = ''.join([i.split()[-1] for i in output.split('\n')])
     assert expected_text in output_last_col
-    return addr, size
 
-@pytest.mark.buildconfigspec('bootstage')
-@pytest.mark.buildconfigspec('cmd_bootstage')
-@pytest.mark.buildconfigspec('bootstage_stash')
-def test_bootstage_unstash(u_boot_console):
-    addr, size = test_bootstage_stash(u_boot_console)
+    # Check that unstash works as expected
     u_boot_console.run_command('bootstage unstash %x %x' % (addr, size))
     output = u_boot_console.run_command('echo $?')
     assert output.endswith('0')
-- 
2.34.1

