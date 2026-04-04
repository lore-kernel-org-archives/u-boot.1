Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58775E88D9D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EBDF83642;
	Sat,  4 Apr 2026 16:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UEcy2zfm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD65883642; Sat,  4 Apr 2026 16:04:04 +0200 (CEST)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B1B580325
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-42321c8b8f5so870311fac.1
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311440; x=1775916240; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/+V7AQXX4aGTSN0g//jrTjL8MH4caY3ts2MNEgIrAl0=;
 b=UEcy2zfmHiAHM5i0N6LwU36V4IEW3Twx2cChx18eSwq+Odnix8Eh0rDeU2rDr9fwcw
 CQoxHwBHMRW0xsscad7qLGEaoUwktgYmf1DToifl5GhPRlTyCNbkHD4VnZ2/0aFQIjkS
 gOGMOEWGDFpftsUlxkDBmUJB+rY+oefoAejfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311440; x=1775916240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/+V7AQXX4aGTSN0g//jrTjL8MH4caY3ts2MNEgIrAl0=;
 b=SI3L1wb/jCkunbi0s8CuhVXB69E7KAPdMKZqg5sJMdA94JN2bCuJLq6kV6FeLmb8ik
 hP8UJFil2OiDCLsMv9D4soNRoyA2s/EePc5pRYAT5nBShNJ1L8lVyrqtMzigdTgG+5eq
 aA6ZYj4+2FISQxZSINQDMpthx6rnkWn3ztQW7l2wGsl7rirzCo8LCmhrDOhJwUjDvJGY
 ZpHZhJsYNruU/cfP94Bneg+U5BUIYoVCfcfPHoygiFrZrgX/opEqkKPTxEU5ENmWN4Eu
 QEBVKvsS0SriZL5ON8AEcdRnDytt5t7WOSNYhO+DWNZsJ0tYZFuPv/j5QtQxrtvtd5Q4
 rCvQ==
X-Gm-Message-State: AOJu0YyiTupgbJqTzBEpkwUnnDYbLJTS+gsODhsB7AVdt3Y/JkrkbcdQ
 4sem6d1DeKjHDN0537J8JWkq69TnYpgYDhGtdh079U/vig6eKpBa4dMyM5u62d1QleIlNfNoB6h
 3fKc=
X-Gm-Gg: AeBDieu7hjSt1f9FnsymTc6kyG2aSedcUX35Q+IaaSVkFTSIuiyYKNfCdkSCW8TaLtI
 gQTVA9JJxJpxJsvtbGL7KwA8sx1ZGmU3zrvkVlC2EbVS7arPgaUebAq34SsYwReLhODOC98bFAM
 dzJoHMnOv18iVXCVYX9d9riH9FssDOjGoJE6Cz5miP2ORVxKWXN+OVfzjhxDHUf0gwfzdpgXmPi
 THYk0o6XYLss9r/N05tlhBO60jgrD3PTfwQ8+12hTapQX15J1XzxYWgdOeX93XvAa+4EsoB7Ihn
 PWRmLIZA7TnzinmFGEDoYEqj8kkrjJyWr/P8tuXhvJIija7Kyx8zAZrTr7oIPiSekr9NIZHONDw
 94wFHrJXSQwE1d8qG/BkVdYFN+i0oYVNS+rE/LmZIQOkxc65ixPx+Smsy5jw7mtLTavthWDn3L8
 jhVzDspLVS2BI9a/cJ7w==
X-Received: by 2002:a05:6870:9692:b0:417:43c8:a58e with SMTP id
 586e51a60fabf-4230dd7444cmr3064186fac.3.1775311440590; 
 Sat, 04 Apr 2026 07:04:00 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:58 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 05/14] test: Convert test_xxd to use FsHelper
Date: Sat,  4 Apr 2026 08:03:09 -0600
Message-ID: <20260404140328.3724864-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404140328.3724864-1-sjg@chromium.org>
References: <20260404140328.3724864-1-sjg@chromium.org>
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

Simplify this test by using the helper.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_xxd.py | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/test/py/tests/test_xxd.py b/test/py/tests/test_xxd.py
index c457c54146c..a5f63f006fe 100644
--- a/test/py/tests/test_xxd.py
+++ b/test/py/tests/test_xxd.py
@@ -4,8 +4,7 @@
 """
 
 import pytest
-from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from tests.fs_helper import FsHelper
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_xxd')
@@ -15,26 +14,13 @@ def test_xxd(ubman):
     Args:
         ubman -- U-Boot console
     """
-    try:
-        scratch_dir = ubman.config.persistent_data_dir + '/scratch'
-
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-
-        with open(scratch_dir + '/hello', 'w', encoding = 'ascii') as file:
-            file.write('hello world\n\x00\x01\x02\x03\x04\x05')
-
-        xxd_data = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
-                                   'test_xxd', scratch_dir)
-        response = ubman.run_command_list([ f'host bind 0 {xxd_data}',
-                                                    'xxd host 0 hello'])
+    with FsHelper(ubman.config, 'vfat', 1, 'test_xxd') as fsh:
+        with open(f'{fsh.srcdir}/hello', 'w', encoding = 'ascii') as outf:
+            outf.write('hello world\n\x00\x01\x02\x03\x04\x05')
+        fsh.mk_fs()
+        response = ubman.run_command_list([f'host bind 0 {fsh.fs_img}',
+                                           'xxd host 0 hello'])
 
         assert '00000000: 68 65 6c 6c 6f 20 77 6f 72 6c 64 0a 00 01 02 03  hello world.....\r\r\n' + \
                '00000010: 04 05                                            ..' \
                in response
-    except CalledProcessError as err:
-        pytest.skip('Preparing test_xxd image failed')
-        call('rm -f %s' % xxd_data, shell=True)
-        return
-    finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % xxd_data, shell=True)
-- 
2.43.0

