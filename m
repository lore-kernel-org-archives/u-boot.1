Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FA0D7308D
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 14:04:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4BEE84129;
	Sat,  4 Apr 2026 16:04:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iVXhkGl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 419EA80325; Sat,  4 Apr 2026 16:04:02 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A264183642
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 16:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-40423dbe98bso1007436fac.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775311438; x=1775916238; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gy6xutbHcwVWD/p+tmP+at/3H8NsY6yA7pZYmxjKOg0=;
 b=iVXhkGl+3UD66fhlkiRKCwhWpDjiariYlmMYXD0DLHH8K4J9baAqM6JGY7MkmhHF4+
 T7Ruf31qxX4TLQ0HCnVJKn8PkvlEabhqYnyyttROU+jNX9M+zX90S30fp9T8tImlZOyq
 qnps00BbTn53pjkfaqhiZvoZ2j9zgMFfN2s18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775311438; x=1775916238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gy6xutbHcwVWD/p+tmP+at/3H8NsY6yA7pZYmxjKOg0=;
 b=hgnfFmjqaXXjoHQUL0J7gWZHpJuUEAyUJMrIteKN5op8/mZ5i0TWWTi9ZkMAg2kw5y
 v5SPu3c07k4XDEiVzyJDfp5nwsXX7nNLINqy8TwcPqt8AHL/CHo6DC5973PleH1O6qz7
 jnzWIQsHAJDAOoetJQOlf5r8K0TDlktfd/Twy96NhWyYA4xD0Fg4Lsr0NJKDjQPrJPS8
 UUrdEvGXjLMumF6nxa9/Rz6tL5TW/BIcPJq8e4TBrG4saFxJz/c4P3gtuR9T/y4ukyNk
 /sklb6Yq7KZ37Ohm25iKnQN3G5gemSQnFOtmkyuDghK+kMWFcbwwWJxC9G3Fp4hLK8pS
 x5tQ==
X-Gm-Message-State: AOJu0Yxp9zO2Dj6yTlhvYhPKdKkxmsm/XpMHzEWxPlvkwR2KZYzQ1lTq
 8U2AtkdI3xUlpYW7LpoI72kqXKIwqvBvm7coor7Hj/QMedn9LEU9TTfqrauCJwpRMEwQZeoGNpd
 eSlk=
X-Gm-Gg: AeBDieuSKNTslGCNSWKt+A7LK9/5thTzv2Nzubja4TKOYzOH3AXzqOYc4q5VoOYUNeS
 8WejzSE+bS64gAaHKTGSVMhYJ7FkkT3JUYUmQLOCabP5cdkAT3Q0L8AlENn7cwmoYTb6y5+tKmb
 d79hOTT3UE8ao3mgYpOw1C7RS3T4gUdiyI/ADeTkeHjxVe9u88HbIgDWQ+Im8/G5qmcfys3xcaO
 83glGrrTNNSk/BT7j4QqwXQnGttGc8ZGTXJaekbvQZNVx812Ib+kqBpMc9N/SV5qf2G0xGfMYzH
 sZoZAXqFcmeR1eGT3RKmVI2CS6HxU9wysKLqRh0scmDR3jed31gT4UieKRREwqGqR/DBj4vDXdO
 8s3P3SWeEKxKkaCz3wMIQgdWjXyN2uwRf/S3/KQDtr+KfGOfsgvTdUBtPJ0JCDX/+tw9xX2UX0F
 YOwMDQNvq/MMASD4UNGw==
X-Received: by 2002:a05:6870:521:b0:3eb:7a2e:34a4 with SMTP id
 586e51a60fabf-4230ff388a5mr3765639fac.28.1775311437690; 
 Sat, 04 Apr 2026 07:03:57 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4232eb3d0e4sm2348235fac.6.2026.04.04.07.03.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 07:03:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/14] test: Convert test_cat to use FsHelper
Date: Sat,  4 Apr 2026 08:03:08 -0600
Message-ID: <20260404140328.3724864-5-sjg@chromium.org>
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

 test/py/tests/test_cat.py | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

diff --git a/test/py/tests/test_cat.py b/test/py/tests/test_cat.py
index 252c3d50a02..f793b9fe0a1 100644
--- a/test/py/tests/test_cat.py
+++ b/test/py/tests/test_cat.py
@@ -4,8 +4,7 @@
 """
 
 import pytest
-from subprocess import call, check_call, CalledProcessError
-from tests import fs_helper
+from tests.fs_helper import FsHelper
 
 @pytest.mark.boardspec('sandbox')
 @pytest.mark.buildconfigspec('cmd_cat')
@@ -15,23 +14,11 @@ def test_cat(ubman):
     Args:
         ubman -- U-Boot console
     """
-    try:
-        scratch_dir = ubman.config.persistent_data_dir + '/scratch'
+    with FsHelper(ubman.config, 'vfat', 1, 'test_cat') as fsh:
+        with open(f'{fsh.srcdir}/hello', 'w', encoding = 'ascii') as outf:
+            outf.write('hello world\n')
+        fsh.mk_fs()
 
-        check_call('mkdir -p %s' % scratch_dir, shell=True)
-
-        with open(scratch_dir + '/hello', 'w', encoding = 'ascii') as file:
-            file.write('hello world\n')
-
-        cat_data = fs_helper.mk_fs(ubman.config, 'vfat', 0x100000,
-                                   'test_cat', scratch_dir)
-        response = ubman.run_command_list([ f'host bind 0 {cat_data}',
-                                                    'cat host 0 hello'])
+        response = ubman.run_command_list([f'host bind 0 {fsh.fs_img}',
+                                           'cat host 0 hello'])
         assert 'hello world' in response
-    except CalledProcessError as err:
-        pytest.skip('Preparing test_cat image failed')
-        call('rm -f %s' % cat_data, shell=True)
-        return
-    finally:
-        call('rm -rf %s' % scratch_dir, shell=True)
-        call('rm -f %s' % cat_data, shell=True)
-- 
2.43.0

