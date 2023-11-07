Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B17AC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 21:42:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9EB787666;
	Tue,  7 Nov 2023 22:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="gnextTPR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B543287626; Tue,  7 Nov 2023 22:42:08 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D8E87626
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 22:41:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40859dee28cso46746825e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 13:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1699393317; x=1699998117;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSZpiP6tur6oGFo9r3EjGkafCJA0FEFBjTak7P6g49I=;
 b=gnextTPRM9SCmxhpNo+YQ6dC3KxXW9NbYwJLy9b8TBeYnyTPsmnE3baAzDRpg1z+qJ
 QqZpPuKS1FM/75SbXWkRspqsW1UHzQZjiHLt56Dy9pScR32pCoUBnF5fhj4xdwqhNCvi
 SVCVbI0kfBRhNtDvIb2+DZH/xfeM7tzpp65aU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699393317; x=1699998117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSZpiP6tur6oGFo9r3EjGkafCJA0FEFBjTak7P6g49I=;
 b=vYf4C9n1ChtGvzHgN5nOMUD2wyvbeKO/UQ7c+PskbG+Uvl9DoPFpy8T4QtQu6uMtgY
 7W9EeKBFRoSgDI+sSkTVuEQkPgUO/x0N6Sxd5Utdkosi68lffhcV46Ssc6pYPPt4ECIO
 Eqj6ZUgptrKjtT0YuEYw8AEYTwwfnmYPe0w3SDdrbjEC4D5uZGg+Ku0IUvLuM6teSEQr
 npRoraCz+UGiIjScP8SbPlr/GhP4PfmUIiPr2Wqmru94U27sS9GYfZnN4LIFJtmt5AUo
 yz8O/EZeZHCAI6rx3pQlTbt2gUY9cLIO3haYII+iiW5Dy3sOZE6vfpJD5jmCZtLG2fA/
 HCPA==
X-Gm-Message-State: AOJu0YwCHJvo3i/R5qz8TTbf0wfPvONDcnTWdvJLhI65+a9JdaMmg+ge
 aiSLXrHYBytC8ZBifg7UX/xe0JKQLb+/PEHHJR4=
X-Google-Smtp-Source: AGHT+IFXdMVL9e6hPL9gp5nlQync1QY2bMomZdjavuNvJTLL7sP22T3qazi6CWlxzjJsBJaUZABjrQ==
X-Received: by 2002:a5d:64e3:0:b0:32d:d756:2cc7 with SMTP id
 g3-20020a5d64e3000000b0032dd7562cc7mr14416wri.58.1699393317707; 
 Tue, 07 Nov 2023 13:41:57 -0800 (PST)
Received: from pwmachine.numericable.fr ([86.120.35.5])
 by smtp.gmail.com with ESMTPSA id
 u10-20020adff88a000000b0032f7f4089b7sm3306437wrp.43.2023.11.07.13.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 13:41:57 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v11 03/24] test/py: hush_if_test: Remove the test file
Date: Tue,  7 Nov 2023 23:41:00 +0200
Message-Id: <20231107214121.132079-4-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
References: <20231107214121.132079-1-francis.laniel@amarulasolutions.com>
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

5804ebfeb1ce ("test: hush: Test hush if/else") translated this test to a C test,
so this python file is no more needed.

Signed-off-by: Francis Laniel <francis.laniel@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
---
 test/py/tests/test_hush_if_test.py | 197 -----------------------------
 1 file changed, 197 deletions(-)
 delete mode 100644 test/py/tests/test_hush_if_test.py

diff --git a/test/py/tests/test_hush_if_test.py b/test/py/tests/test_hush_if_test.py
deleted file mode 100644
index 3b4b6fcaf4..0000000000
--- a/test/py/tests/test_hush_if_test.py
+++ /dev/null
@@ -1,197 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2015-2016, NVIDIA CORPORATION. All rights reserved.
-
-# Test operation of the "if" shell command.
-
-import os
-import os.path
-import pytest
-
-# TODO: These tests should be converted to a C test.
-# For more information please take a look at the thread
-# https://lists.denx.de/pipermail/u-boot/2019-October/388732.html
-
-pytestmark = pytest.mark.buildconfigspec('hush_parser')
-
-# The list of "if test" conditions to test.
-subtests = (
-    # Base if functionality.
-
-    ('true', True),
-    ('false', False),
-
-    # Basic operators.
-
-    ('test aaa = aaa', True),
-    ('test aaa = bbb', False),
-
-    ('test aaa != bbb', True),
-    ('test aaa != aaa', False),
-
-    ('test aaa < bbb', True),
-    ('test bbb < aaa', False),
-
-    ('test bbb > aaa', True),
-    ('test aaa > bbb', False),
-
-    ('test 123 -eq 123', True),
-    ('test 123 -eq 456', False),
-
-    ('test 123 -ne 456', True),
-    ('test 123 -ne 123', False),
-
-    ('test 123 -lt 456', True),
-    ('test 123 -lt 123', False),
-    ('test 456 -lt 123', False),
-
-    ('test 123 -le 456', True),
-    ('test 123 -le 123', True),
-    ('test 456 -le 123', False),
-
-    ('test 456 -gt 123', True),
-    ('test 123 -gt 123', False),
-    ('test 123 -gt 456', False),
-
-    ('test 456 -ge 123', True),
-    ('test 123 -ge 123', True),
-    ('test 123 -ge 456', False),
-
-    # Octal tests
-
-    ('test 010 -eq 010', True),
-    ('test 010 -eq 011', False),
-
-    ('test 010 -ne 011', True),
-    ('test 010 -ne 010', False),
-
-    # Hexadecimal tests
-
-    ('test 0x2000000 -gt 0x2000001', False),
-    ('test 0x2000000 -gt 0x2000000', False),
-    ('test 0x2000000 -gt 0x1ffffff', True),
-
-    # Mixed tests
-
-    ('test 010 -eq 10', False),
-    ('test 010 -ne 10', True),
-    ('test 0xa -eq 10', True),
-    ('test 0xa -eq 012', True),
-
-    ('test 2000000 -gt 0x1ffffff', False),
-    ('test 0x2000000 -gt 1ffffff', True),
-    ('test 0x2000000 -lt 1ffffff', False),
-    ('test 0x2000000 -eq 2000000', False),
-    ('test 0x2000000 -ne 2000000', True),
-
-    ('test -z ""', True),
-    ('test -z "aaa"', False),
-
-    ('test -n "aaa"', True),
-    ('test -n ""', False),
-
-    # Inversion of simple tests.
-
-    ('test ! aaa = aaa', False),
-    ('test ! aaa = bbb', True),
-    ('test ! ! aaa = aaa', True),
-    ('test ! ! aaa = bbb', False),
-
-    # Binary operators.
-
-    ('test aaa != aaa -o bbb != bbb', False),
-    ('test aaa != aaa -o bbb = bbb', True),
-    ('test aaa = aaa -o bbb != bbb', True),
-    ('test aaa = aaa -o bbb = bbb', True),
-
-    ('test aaa != aaa -a bbb != bbb', False),
-    ('test aaa != aaa -a bbb = bbb', False),
-    ('test aaa = aaa -a bbb != bbb', False),
-    ('test aaa = aaa -a bbb = bbb', True),
-
-    # Inversion within binary operators.
-
-    ('test ! aaa != aaa -o ! bbb != bbb', True),
-    ('test ! aaa != aaa -o ! bbb = bbb', True),
-    ('test ! aaa = aaa -o ! bbb != bbb', True),
-    ('test ! aaa = aaa -o ! bbb = bbb', False),
-
-    ('test ! ! aaa != aaa -o ! ! bbb != bbb', False),
-    ('test ! ! aaa != aaa -o ! ! bbb = bbb', True),
-    ('test ! ! aaa = aaa -o ! ! bbb != bbb', True),
-    ('test ! ! aaa = aaa -o ! ! bbb = bbb', True),
-)
-
-def exec_hush_if(u_boot_console, expr, result):
-    """Execute a shell "if" command, and validate its result."""
-
-    config = u_boot_console.config.buildconfig
-    maxargs = int(config.get('config_sys_maxargs', '0'))
-    args = len(expr.split(' ')) - 1
-    if args > maxargs:
-        u_boot_console.log.warning('CONFIG_SYS_MAXARGS too low; need ' +
-            str(args))
-        pytest.skip()
-
-    cmd = 'if ' + expr + '; then echo true; else echo false; fi'
-    response = u_boot_console.run_command(cmd)
-    assert response.strip() == str(result).lower()
-
-@pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.parametrize('expr,result', subtests)
-def test_hush_if_test(u_boot_console, expr, result):
-    """Test a single "if test" condition."""
-
-    exec_hush_if(u_boot_console, expr, result)
-
-def test_hush_z(u_boot_console):
-    """Test the -z operator"""
-    u_boot_console.run_command('setenv ut_var_nonexistent')
-    u_boot_console.run_command('setenv ut_var_exists 1')
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_nonexistent"', True)
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_exists"', False)
-    u_boot_console.run_command('setenv ut_var_exists')
-
-# We might test this on real filesystems via UMS, DFU, 'save', etc.
-# Of those, only UMS currently allows file removal though.
-@pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.boardspec('sandbox')
-def test_hush_if_test_host_file_exists(u_boot_console):
-    """Test the "if test -e" shell command."""
-
-    test_file = u_boot_console.config.result_dir + \
-        '/creating_this_file_breaks_u_boot_tests'
-
-    try:
-        os.unlink(test_file)
-    except:
-        pass
-    assert not os.path.exists(test_file)
-
-    expr = 'test -e hostfs - ' + test_file
-    exec_hush_if(u_boot_console, expr, False)
-
-    try:
-        with open(test_file, 'wb'):
-            pass
-        assert os.path.exists(test_file)
-
-        expr = 'test -e hostfs - ' + test_file
-        exec_hush_if(u_boot_console, expr, True)
-    finally:
-        os.unlink(test_file)
-
-    expr = 'test -e hostfs - ' + test_file
-    exec_hush_if(u_boot_console, expr, False)
-
-def test_hush_var(u_boot_console):
-    """Test the set and unset of variables"""
-    u_boot_console.run_command('ut_var_nonexistent=')
-    u_boot_console.run_command('ut_var_exists=1')
-    u_boot_console.run_command('ut_var_unset=1')
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_nonexistent"', True)
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_exists"', False)
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_unset"', False)
-    exec_hush_if(u_boot_console, 'ut_var_unset=', True)
-    exec_hush_if(u_boot_console, 'test -z "$ut_var_unset"', True)
-    u_boot_console.run_command('ut_var_exists=')
-    u_boot_console.run_command('ut_var_unset=')
-- 
2.34.1

