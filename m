Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7524D21684
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 12:19:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D5DC8841E;
	Tue, 15 Oct 2024 14:19:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="byp8mF1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34EC688365; Tue, 15 Oct 2024 14:19:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C27B3881A5
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 14:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4311ae6426aso35171365e9.2
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 05:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728994765; x=1729599565; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T10Z1SjecXYUkSapfFtoSjw9zuWkWiGcHm62HYvDOtY=;
 b=byp8mF1wc18MSlJal4ebun3W8lGUn59jaT+xAfNv2ZKh+GNGOid2TIs2E0ExbgYFaL
 si8N3iINVLDzLnooC5e2cpMXIKNrQqxC5EHLheWLTkS2rzu7LqyMdBzfsVb78179+h9m
 f0VbmleZSN5vzm3uqae+OpEDfR4QF9305fohQV2+mvLCbQZ5uJeT4PqfOR/XLbrVDMTB
 M1Pm2ln/MiHe1FupsAeAul882bRGAP5KFPfdUhWjxlXMl+KFpPsa3s5J3m0K2iTfK7C3
 B/mrwT46tnisq8bazFdIlMJUuXr9UMrw4+vAbat/h7ZrVnBLT2MO8mXa44//Ws8jfL1f
 g0mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728994765; x=1729599565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T10Z1SjecXYUkSapfFtoSjw9zuWkWiGcHm62HYvDOtY=;
 b=QlTBp23qcu8q1S8A4p8tq/p04WpGsTGHArTv6a4ItFK5LEB2Et7BdZlu1RDYcqOaPy
 nQS1dpOOUcYawP8wrvRllMBfCNkwTQDRtKv+G+Es0SqVIEagDaPs9O2nRyUby69zNGVw
 ZcYaiednOFk4O5wrS7qpeUsfbWjC98kge1/cwUn0KwJrcOTfPe4ku/QTQIUMs7M8OXrZ
 8eGr9dpgntwQDkuEaJwpoo7FNtZAjNg/xL82Dzl2JEheiB9v0THSKBuTNo7JosWQ5H5I
 3k4lWaoKqldCuPIW5DtKZdhB/RRX2zdsmzbjdnCf5AJ7gGpA8cmLEBj0SLHrNAGqI5ty
 uGVQ==
X-Gm-Message-State: AOJu0YzYv+uCHGvudnr0MB3FxMwbsr7ACbsltcErcY5TwHOPNLNNE3KG
 BlgR1SuFCmdU6nACSQywNtpwUeLYq5iGbw4tpMJnNOFbZDtX6gV8ZL2UFHTh85bj9Ut25WV09S/
 fWCw=
X-Google-Smtp-Source: AGHT+IEBCYYIKr6gD7F2x0z3le8vRhy5tN4aiiiivxxAuPCBhE0VaSHClKGCxN2aqTRugScvA/p/pQ==
X-Received: by 2002:adf:ea41:0:b0:37d:4cd6:6f2f with SMTP id
 ffacd0b85a97d-37d86ba83b6mr56070f8f.3.1728994765085; 
 Tue, 15 Oct 2024 05:19:25 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:52f8:5161:22d9:48c2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d7faa4085sm1453123f8f.65.2024.10.15.05.19.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 05:19:24 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: Fix test failure with multiple partitions
Date: Tue, 15 Oct 2024 13:19:16 +0100
Message-Id: <20241015121916.1155120-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When test_usb_load finds multiple partitions of the same type then
it will cause a test failure. The call to write the test file will
write a different test file to each partition but only return the
name and size of the last one written. So the test then fails to
load the test file from the first partition as it uses the name of
a file on a different partition.

Refactor the code so that only one test file is written at a time
and is written to only the partition being tested at that time. This
allows the correct file name to always be available to the code that
runs the load command. This reduces the number of files written and
also the number of calls to crc32 needed.

Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/py/tests/test_usb.py | 166 +++++++++++++++++++-------------------
 1 file changed, 82 insertions(+), 84 deletions(-)

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index fb3d20f082..e7966cad2b 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -288,6 +288,47 @@ def test_usb_fatls_fatinfo(u_boot_console):
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
+def usb_fatload_fatwrite(u_boot_console, fs, x, part):
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    size = random.randint(4, 1 * 1024 * 1024)
+    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+    m = re.search('==> (.+?)', output)
+    if not m:
+        pytest.fail('CRC32 failed')
+    expected_crc32 = m.group(1)
+
+    file = '%s_%d' % ('uboot_test', size)
+    output = u_boot_console.run_command(
+        '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
+    )
+    assert 'Unable to write' not in output
+    assert 'Error' not in output
+    assert 'overflow' not in output
+    expected_text = '%d bytes written' % size
+    assert expected_text in output
+
+    alignment = int(
+        u_boot_console.config.buildconfig.get(
+            'config_sys_cacheline_size', 128
+        )
+    )
+    offset = random.randrange(alignment, 1024, alignment)
+    output = u_boot_console.run_command(
+        '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
+    )
+    assert 'Invalid FAT entry' not in output
+    assert 'Unable to read file' not in output
+    assert 'Misaligned buffer address' not in output
+    expected_text = '%d bytes read' % size
+    assert expected_text in output
+
+    output = u_boot_console.run_command(
+        'crc32 %x $filesize' % (addr + offset)
+    )
+    assert expected_crc32 in output
+
+    return file, size, expected_crc32
+
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_fat')
 @pytest.mark.buildconfigspec('cmd_memory')
@@ -309,49 +350,11 @@ def test_usb_fatload_fatwrite(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
-                addr = u_boot_utils.find_ram_base(u_boot_console)
-                size = random.randint(4, 1 * 1024 * 1024)
-                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                m = re.search('==> (.+?)', output)
-                if not m:
-                    pytest.fail('CRC32 failed')
-                expected_crc32 = m.group(1)
-
-                file = '%s_%d' % ('uboot_test', size)
-                output = u_boot_console.run_command(
-                    '%swrite usb %d:%s %x %s %x' % (fs, x, part, addr, file, size)
-                )
-                assert 'Unable to write' not in output
-                assert 'Error' not in output
-                assert 'overflow' not in output
-                expected_text = '%d bytes written' % size
-                assert expected_text in output
-
-                alignment = int(
-                    u_boot_console.config.buildconfig.get(
-                        'config_sys_cacheline_size', 128
-                    )
-                )
-                offset = random.randrange(alignment, 1024, alignment)
-                output = u_boot_console.run_command(
-                    '%sload usb %d:%s %x %s' % (fs, x, part, addr + offset, file)
-                )
-                assert 'Invalid FAT entry' not in output
-                assert 'Unable to read file' not in output
-                assert 'Misaligned buffer address' not in output
-                expected_text = '%d bytes read' % size
-                assert expected_text in output
-
-                output = u_boot_console.run_command(
-                    'crc32 %x $filesize' % (addr + offset)
-                )
-                assert expected_crc32 in output
+                usb_fatload_fatwrite(u_boot_console, fs, x, part)
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
-    return file, size
-
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext4')
 def test_usb_ext4ls(u_boot_console):
@@ -380,6 +383,39 @@ def test_usb_ext4ls(u_boot_console):
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
+def usb_ext4load_ext4write(u_boot_console, fs, x, part):
+    addr = u_boot_utils.find_ram_base(u_boot_console)
+    size = random.randint(4, 1 * 1024 * 1024)
+    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
+    m = re.search('==> (.+?)', output)
+    if not m:
+        pytest.fail('CRC32 failed')
+    expected_crc32 = m.group(1)
+    file = '%s_%d' % ('uboot_test', size)
+
+    output = u_boot_console.run_command(
+        '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
+    )
+    assert 'Unable to write' not in output
+    assert 'Error' not in output
+    assert 'overflow' not in output
+    expected_text = '%d bytes written' % size
+    assert expected_text in output
+
+    offset = random.randrange(128, 1024, 128)
+    output = u_boot_console.run_command(
+        '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
+    )
+    expected_text = '%d bytes read' % size
+    assert expected_text in output
+
+    output = u_boot_console.run_command(
+        'crc32 %x $filesize' % (addr + offset)
+    )
+    assert expected_crc32 in output
+
+    return file, size, expected_crc32
+
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext4')
 @pytest.mark.buildconfigspec('ext4_write')
@@ -402,41 +438,11 @@ def test_usb_ext4load_ext4write(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
-                addr = u_boot_utils.find_ram_base(u_boot_console)
-                size = random.randint(4, 1 * 1024 * 1024)
-                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                m = re.search('==> (.+?)', output)
-                if not m:
-                    pytest.fail('CRC32 failed')
-                expected_crc32 = m.group(1)
-                file = '%s_%d' % ('uboot_test', size)
-
-                output = u_boot_console.run_command(
-                    '%swrite usb %d:%s %x /%s %x' % (fs, x, part, addr, file, size)
-                )
-                assert 'Unable to write' not in output
-                assert 'Error' not in output
-                assert 'overflow' not in output
-                expected_text = '%d bytes written' % size
-                assert expected_text in output
-
-                offset = random.randrange(128, 1024, 128)
-                output = u_boot_console.run_command(
-                    '%sload usb %d:%s %x /%s' % (fs, x, part, addr + offset, file)
-                )
-                expected_text = '%d bytes read' % size
-                assert expected_text in output
-
-                output = u_boot_console.run_command(
-                    'crc32 %x $filesize' % (addr + offset)
-                )
-                assert expected_crc32 in output
+                usb_ext4load_ext4write(u_boot_console, fs, x, part)
 
     if not part_detect:
         pytest.skip('No %s partition detected' % fs.upper())
 
-    return file, size
-
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext2')
 def test_usb_ext2ls(u_boot_console):
@@ -473,7 +479,6 @@ def test_usb_ext2ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_memory')
 def test_usb_ext2load(u_boot_console):
     devices, controllers, storage_device = test_usb_part(u_boot_console)
-    file, size = test_usb_ext4load_ext4write(u_boot_console)
 
     if not devices:
         pytest.skip('No devices detected')
@@ -491,12 +496,9 @@ def test_usb_ext2load(u_boot_console):
 
             for part in partitions:
                 part_detect = 1
+                file, size, expected_crc32 = \
+                    usb_ext4load_ext4write(u_boot_console, 'ext4', x, part)
                 addr = u_boot_utils.find_ram_base(u_boot_console)
-                output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                m = re.search('==> (.+?)', output)
-                if not m:
-                    pytest.fail('CRC32 failed')
-                expected_crc32 = m.group(1)
 
                 offset = random.randrange(128, 1024, 128)
                 output = u_boot_console.run_command(
@@ -565,15 +567,11 @@ def test_usb_load(u_boot_console):
                     addr = u_boot_utils.find_ram_base(u_boot_console)
 
                     if fs == 'fat':
-                        file, size = test_usb_fatload_fatwrite(u_boot_console)
+                        file, size, expected_crc32 = \
+                            usb_fatload_fatwrite(u_boot_console, fs, x, part)
                     elif fs == 'ext4':
-                        file, size = test_usb_ext4load_ext4write(u_boot_console)
-
-                    output = u_boot_console.run_command('crc32 %x %x' % (addr, size))
-                    m = re.search('==> (.+?)', output)
-                    if not m:
-                        pytest.fail('CRC32 failed')
-                    expected_crc32 = m.group(1)
+                        file, size, expected_crc32 = \
+                            usb_ext4load_ext4write(u_boot_console, fs, x, part)
 
                     offset = random.randrange(128, 1024, 128)
                     output = u_boot_console.run_command(
-- 
2.39.5

