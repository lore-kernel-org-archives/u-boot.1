Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 937E6CD13CF
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6666988D2C;
	Tue,  3 Sep 2024 10:39:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SpKazF24";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52D0B88D29; Tue,  3 Sep 2024 10:39:05 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38B1988D13
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-374c4c6cb29so1979896f8f.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352742; x=1725957542; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVLp2Yc0TD42b4eD8h2KJ+CtamgC47vAQn8KmKi6cS4=;
 b=SpKazF24Tut0PsshPtTo/ZKsDxi5bSeiZ9HEYYYFPXTZAQjD/Y+G7L6lvXjOTx4JJV
 EgRigbnnES1IcSiIURtYWLy7cT8+HtpkUa/i0inkhasub1tg1PNjDPLEWqB4TfyeT0L4
 eApOQcRiIJjd2S0mLZIIz8hapOHzekOE4wft/wJUdlnFn/wDh1usCBDGOlV11YwaaYx5
 MNWwmDXP/GM/dyAh2Et8Yb8938GOP49j28c1U5zyRtPnCuoTDjN1XffRtRSIZbFiTeZ9
 yhjT80aI9m2ryEsWjiOlLAolqnzr1DyIPVLrjYftiOdvLZaA+8H4BuYw3YjoM1p1lrkV
 1BQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352742; x=1725957542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVLp2Yc0TD42b4eD8h2KJ+CtamgC47vAQn8KmKi6cS4=;
 b=sQk2/mk6SqjED/JwHsv3BalLlYRg115aGuboIYKovJ0CoFDT7pUFUm3HEdsuuPcdo1
 VC+hn2nNDZkVA/mr1Mn0gXGMGIJFJHfm4gFsOzVNgjLURyoFXS2IyBuKqcDQER/0RIxp
 DVKIDEuFROmNHCErhuvXi5TWJ0RAnVCZWI8pSCKT75xuYDTg+MZPufTnzkYlrJIPYfsh
 psxeCPRK6MsSzuX4GDJarpZ7CGTPQC0AAXmTffCLbW8GscqiF0ME2qOquc0+jcRfP1L1
 ZbbExm7VvdR9T/I4ZQlJ32dKTcOOzl+U46/kwGv4sOL0elWdoNrKeDjCpEUkEo31GTgF
 kLpg==
X-Gm-Message-State: AOJu0YxI9J7g6ujZTUEujoxW1TG6ahdKOaQIJL62fdrD976kFjNO9m69
 9aDVXvwFjaZy+i6pk17F5asgLrJs8Na1WdXd8sz/y+8WXWxlXuk9/MoadRIzPaX4rQOvZRlazfG
 UZYueOw==
X-Google-Smtp-Source: AGHT+IFWCfFDDjzpAuNogc49mJrasqJdjIHKWFJNYf1yKQfLdvwqZo+6CpF/pliRYbUWmVoH9zAjhg==
X-Received: by 2002:adf:e005:0:b0:368:4c38:a668 with SMTP id
 ffacd0b85a97d-3749b526b73mr14821017f8f.9.1725352742237; 
 Tue, 03 Sep 2024 01:39:02 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.39.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:39:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 14/16] test/py: test_efi_loader: add HTTP (wget) test for
 the EFI loader
Date: Tue,  3 Sep 2024 10:38:11 +0200
Message-Id: <062d95132016f9be6ae1a4ce21ab754cee0f9745.1725351676.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725351676.git.jerome.forissier@linaro.org>
References: <cover.1725351676.git.jerome.forissier@linaro.org>
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

Add a test to test_efi_loader.py similar to the TFTP test but for HTTP
with the wget command.

Suggested-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Tested-by: Tom Rini <trini@konsulko.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
---
 test/py/tests/test_efi_loader.py | 62 +++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 16 deletions(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 7c1e0ffa594..5f3b448a066 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -45,11 +45,18 @@ env__efi_loader_helloworld_file = {
     'crc32': 'c2244b26',                   # CRC32 check sum
     'addr': 0x40400000,                    # load address
 }
+
+# False if the helloworld EFI over HTTP boot test should be performed.
+# If HTTP boot testing is not possible or desired, set this variable to True or
+# ommit it.
+env__efi_helloworld_net_http_test_skip = True
 """
 
 import pytest
 import u_boot_utils
 
+PROTO_TFTP, PROTO_HTTP = range(0, 2)
+
 net_set_up = False
 
 def test_efi_pre_commands(u_boot_console):
@@ -110,10 +117,10 @@ def test_efi_setup_static(u_boot_console):
     global net_set_up
     net_set_up = True
 
-def fetch_tftp_file(u_boot_console, env_conf):
-    """Grab an env described file via TFTP and return its address
+def fetch_file(u_boot_console, env_conf, proto):
+    """Grab an env described file via TFTP or HTTP and return its address
 
-    A file as described by an env config <env_conf> is downloaded from the TFTP
+    A file as described by an env config <env_conf> is downloaded from the
     server. The address to that file is returned.
     """
     if not net_set_up:
@@ -128,7 +135,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
         addr = u_boot_utils.find_ram_base(u_boot_console)
 
     fn = f['fn']
-    output = u_boot_console.run_command('tftpboot %x %s' % (addr, fn))
+    if proto == PROTO_TFTP:
+        cmd = 'tftpboot'
+    elif proto == PROTO_HTTP:
+        cmd = 'wget'
+    else:
+        assert False
+    output = u_boot_console.run_command('%s %x %s' % (cmd, addr, fn))
     expected_text = 'Bytes transferred = '
     sz = f.get('size', None)
     if sz:
@@ -147,17 +160,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
     return addr
 
-@pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
-@pytest.mark.buildconfigspec('cmd_tftpboot')
-def test_efi_helloworld_net(u_boot_console):
-    """Run the helloworld.efi binary via TFTP.
-
-    The helloworld.efi file is downloaded from the TFTP server and is executed
-    using the fallback device tree at $fdtcontroladdr.
-    """
-
-    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld_file')
+def do_test_efi_helloworld_net(u_boot_console, proto):
+    addr = fetch_file(u_boot_console, 'env__efi_loader_helloworld_file', proto)
 
     output = u_boot_console.run_command('bootefi %x' % addr)
     expected_text = 'Hello, world'
@@ -165,6 +169,32 @@ def test_efi_helloworld_net(u_boot_console):
     expected_text = '## Application failed'
     assert expected_text not in output
 
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
+def test_efi_helloworld_net_tftp(u_boot_console):
+    """Run the helloworld.efi binary via TFTP.
+
+    The helloworld.efi file is downloaded from the TFTP server and is executed
+    using the fallback device tree at $fdtcontroladdr.
+    """
+
+    do_test_efi_helloworld_net(u_boot_console, PROTO_TFTP);
+
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_wget')
+def test_efi_helloworld_net_http(u_boot_console):
+    """Run the helloworld.efi binary via HTTP.
+
+    The helloworld.efi file is downloaded from the HTTP server and is executed
+    using the fallback device tree at $fdtcontroladdr.
+    """
+    if u_boot_console.config.env.get('env__efi_helloworld_net_http_test_skip', True):
+        pytest.skip('helloworld.efi HTTP test is not enabled!')
+
+    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
+
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
 def test_efi_helloworld_builtin(u_boot_console):
     """Run the builtin helloworld.efi binary.
@@ -187,7 +217,7 @@ def test_efi_grub_net(u_boot_console):
     executed.
     """
 
-    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
+    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
 
     u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
 
-- 
2.40.1

