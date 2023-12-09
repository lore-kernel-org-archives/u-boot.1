Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D30B5C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 20:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9D9B8717E;
	Sat,  9 Dec 2023 21:01:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qfmWT5qd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A26F78753C; Sat,  9 Dec 2023 21:01:34 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7200187078
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 21:01:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dbc72b692adso298215276.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 12:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702152091; x=1702756891; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Yz0Nuuhx9Jgaa5oJujXBPttVsLlPE/sxNCLVC6W8t/4=;
 b=qfmWT5qdMewk6+qFO0chuMW1b1W7vKqBn21bA/0n6lcLgKuMBxZTXLnfTE5Iiyu7uq
 LE5tUr0DJxMhbrMMLzr87RsV1L1YXMjXjfjtP3G1AdeoRguKr9soLyFsmLcUfb+Sd7V9
 7HF7LlL04Ve2tXNDOJhGdix+GSPRSC2l3Luv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702152091; x=1702756891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yz0Nuuhx9Jgaa5oJujXBPttVsLlPE/sxNCLVC6W8t/4=;
 b=Z1DLwGeA/dJejHLdk43HMyqa6EfReftd1XltgCc51eWilOsI34ZClQ87G3tlxP/YZP
 nXy40kYaIaibayqAaFFPlIH8yYPU1gupnjW9/WN3zGesBA+zOmEouU3ijJqQEtbEEOfx
 XRG1VwTkZ+fngPb792shO97BibK85+70M9AZgUB3rJLdDTwE3+k/t/F/JcJdCvC9SIwR
 JUr/bFj6xyXJlQda2ZWR3IqnrKVQzuVnQC11EJhfYtZlKGQSv8j5n/lvPfJ0fl2AEPgU
 PGgsMR5r+IButKKGGRcVVmODUvxtgAonfBvRCvUB/kB6y9JoI+FHepOXtL7024sqhBF+
 Dbrg==
X-Gm-Message-State: AOJu0YxpJhFaUCysG+a6tSbiavQGqhNSTuhZbDBWca5/jZCdJubwO6q9
 mA5ukS5Xi7wGMCtxTqxqaiqJb7YJtnEg9Iosl/W7eA==
X-Google-Smtp-Source: AGHT+IGU/dpJ0SmffVHNcjq3IORTPbgrWD5IZ0lH2N1SJYIxsjmiHokvpFZ/ELjNfjYia2n1EpqimA==
X-Received: by 2002:a5b:789:0:b0:d9a:4ae7:ba2c with SMTP id
 b9-20020a5b0789000000b00d9a4ae7ba2cmr1155386ybq.22.1702152089465; 
 Sat, 09 Dec 2023 12:01:29 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 y26-20020a25ad1a000000b00d7ba4c5e31fsm1465343ybi.39.2023.12.09.12.01.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 12:01:29 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] test/py: Disable error E0611 in two cases for pylint
Date: Sat,  9 Dec 2023 15:01:28 -0500
Message-Id: <20231209200128.3819612-1-trini@konsulko.com>
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

Recently pylint has started to complain about:
No name 'fs_helper' in module 'tests' (no-name-in-module)

Due to:
from tests import fs_helper

However, we have:
test/py/tests/fs_helper.py

And since we do not want to add a dummy test/py/tests/__init__.py to
silence this warning we instead just disable it as needed.

Cc: Simon Glass <sjg@chromium.org>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_fs/conftest.py | 1 +
 test/py/tests/test_ut.py          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/test/py/tests/test_fs/conftest.py b/test/py/tests/test_fs/conftest.py
index 0d87d180c7b6..7c76425b51a4 100644
--- a/test/py/tests/test_fs/conftest.py
+++ b/test/py/tests/test_fs/conftest.py
@@ -9,6 +9,7 @@ import re
 from subprocess import call, check_call, check_output, CalledProcessError
 from fstest_defs import *
 import u_boot_utils as util
+# pylint: disable=E0611
 from tests import fs_helper
 
 supported_fs_basic = ['fat16', 'fat32', 'ext4']
diff --git a/test/py/tests/test_ut.py b/test/py/tests/test_ut.py
index 1d9149a3f683..0e3a48e73f61 100644
--- a/test/py/tests/test_ut.py
+++ b/test/py/tests/test_ut.py
@@ -9,6 +9,7 @@ import os.path
 import pytest
 
 import u_boot_utils
+# pylint: disable=E0611
 from tests import fs_helper
 
 def mkdir_cond(dirname):
-- 
2.34.1

