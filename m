Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF08EE498A
	for <u-boot@archiver.kernel.org>; Wed, 11 Sep 2024 10:01:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF71889264;
	Wed, 11 Sep 2024 11:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CXxL++0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C4D89255; Wed, 11 Sep 2024 11:59:05 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B339C89257
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 11:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so43029375e9.0
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726048740; x=1726653540; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pVLp2Yc0TD42b4eD8h2KJ+CtamgC47vAQn8KmKi6cS4=;
 b=CXxL++0oZIQAivAn8XfDvDGsfEteQ4oMq38QrGsy5xRyJHzAv8HAokwhWcUasA9XtO
 eTsKjzP6WE7x8ezQf9vFRDkgzfFEOYTJ3Zt1hD49QzHsh11nO9+RmpI6Qka0Ru7JoE14
 etUSbHyQMT1quZfL3QE+J09Aid7YN9Xe+lpvdQIYuzww+MO+dJmNqAS+vvF7wCJYcuoI
 bt8U3lS9amNrQ1TY5H6A2kqDfJF/vDhEgIPH66LicoVJzJF/487b4x+CnxAHk6yfhV1F
 osZBPaBIMYTP34xZNfgEQVCy+LwFh0K1AsqLzNiB8gXylmeWmClwsuG8+YVZPDHWfAAG
 2P3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726048740; x=1726653540;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pVLp2Yc0TD42b4eD8h2KJ+CtamgC47vAQn8KmKi6cS4=;
 b=jP/ZHWpvUM1M1a+Vp1STSm+q5TlBnGryH7E+0DXjiyVplqeoxY9vmb517WUXC0c2LA
 mi43KFftr9aGiADs2r80qyC6NIXH6bTI/ELo/MP0RwpJOCflP3q4CfIaSgLkSm50FtRV
 5d84NygHlRR/sCpc9lyr8v75aZIOm7IZuzv/WNoPSuwOTebyoUhqpB3x6vKdAlMztThd
 EUuv34zY1jocER9ifXt0IlC1DnL21s7UhX+IrseQAXFwjLizkwWizEU6n++d93CLkurA
 jG2GWZC2l7qRZYKSFfpQhb6dRnpafYXqthhgZZ39rxtAHTkNjhIzWRC8WeSM9ApWE2+v
 exRg==
X-Gm-Message-State: AOJu0Yyu7L9pP1MWwjONzkOK+jGoK30O8XYHq//hemzqQHSVg4gc7sgg
 b/fvXPotMSm8SYxcNgLWzeRnx+9RZTcHo6LcrrjWGf71oetkxETjreOspzuUk3HrmW5ZeMM5Me8
 6bahJAw==
X-Google-Smtp-Source: AGHT+IGZnnjvFVLeQdUBcEK9uvnWwGUFz/HwLCzxmogCBpCrkW4FjljYnDk9XkWN71TqBRtrbaDr/g==
X-Received: by 2002:a05:600c:4449:b0:42c:b52b:4349 with SMTP id
 5b1f17b1804b1-42cb52b45a0mr105693275e9.33.1726048739901; 
 Wed, 11 Sep 2024 02:58:59 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:7d92:535d:cd3d:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649bafsm11300507f8f.7.2024.09.11.02.58.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 02:58:59 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v4 13/15] test/py: test_efi_loader: add HTTP (wget) test for
 the EFI loader
Date: Wed, 11 Sep 2024 11:58:26 +0200
Message-Id: <37d1101caa3efe11f65b8b5fc5262203cb6aa29b.1726048404.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1726048404.git.jerome.forissier@linaro.org>
References: <cover.1726048404.git.jerome.forissier@linaro.org>
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

