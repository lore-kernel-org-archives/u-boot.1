Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7534E7C4E5
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:44:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FE1875BE;
	Wed,  4 Oct 2023 18:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="YR0b/mxZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C09B875A2; Wed,  4 Oct 2023 18:42:57 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2926987593
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5363227cc80so4017734a12.3
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1696437772; x=1697042572;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LSZpiP6tur6oGFo9r3EjGkafCJA0FEFBjTak7P6g49I=;
 b=YR0b/mxZD1L/5uMlBkzG270ijyL09krI8DlWUjqqz4qOMlt8h/tXg5VVsPmPzwA+Gh
 BhbZCYR4SnXksiMmNAIAEjsPBLxvdWlnglbRsSozBjkXMbkiqM/1xjl/+d4YUyC2SDXq
 vC8atk/hUpmtlv3jDXYtNiS/IyMHy0PKOzBWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696437772; x=1697042572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LSZpiP6tur6oGFo9r3EjGkafCJA0FEFBjTak7P6g49I=;
 b=hYYocPhWJ2GQ/BOkGCyX02mqcKEqc39QhIBOiynKfQrczBIfIw+8BK1IyImKsEeEme
 Lp66sByOtYcsMRdHsQAA82lD75yV35pt/TJgoKPNJM1Pyzadhlo9c/f2INfcI3sXtrnC
 reuRKIoCzmEaeKf9mPJ6PigdbeZdMPNInrQLyq/yp32UM2DpgedLAgQ1c7LgauVgkp2+
 WtQ6AKFwnImcM9n5tM/hZOUlTyFlYal/nwalHZev1ShFut5Iq6dwUck+iPSBPLrsFtyZ
 VX7Alz91MeKv5yu1Xgixalf6bA3dgZGHroYYKLzaGrNozcP7p9xi6WmhPO0qk3p8BCJF
 Gl7A==
X-Gm-Message-State: AOJu0YwWQCLQXgN95+buFcFMCzZ2pCESEzqcfvosqGPlktS8Wq3OeujZ
 aTkFxcersmu9Hy42xiDpqwqJnnf5JtaltgkLG4Y=
X-Google-Smtp-Source: AGHT+IFAEtjktsyvDLv9UXjvW0tA0jBv4SgwFvv8sY1CKsTBmT8y/bFf65sJ20dHM3tSjUpoZvwJ5A==
X-Received: by 2002:aa7:c418:0:b0:522:1f09:dde3 with SMTP id
 j24-20020aa7c418000000b005221f09dde3mr2433104edq.3.1696437772398; 
 Wed, 04 Oct 2023 09:42:52 -0700 (PDT)
Received: from pwmachine.numericable.fr
 ([2a02:2f0a:e213:b400:4d86:b2fb:68b4:3466])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b005381936efa7sm118351edw.16.2023.10.04.09.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 09:42:52 -0700 (PDT)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Harald Seiler <hws@denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH v10 03/24] test/py: hush_if_test: Remove the test file
Date: Wed,  4 Oct 2023 19:41:59 +0300
Message-Id: <20231004164220.15738-4-francis.laniel@amarulasolutions.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
References: <20231004164220.15738-1-francis.laniel@amarulasolutions.com>
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

