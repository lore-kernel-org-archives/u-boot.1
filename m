Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D6CC52D7C
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 13:51:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D035488B9C;
	Fri, 23 Aug 2024 15:49:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iXB6v/76";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 622A7886E7; Fri, 23 Aug 2024 15:49:26 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 608C188ABF
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 15:49:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-371a13c7c80so1738729f8f.0
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 06:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724420964; x=1725025764; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RmknMyAEHfs1JMtP1FJ6M3yqq1Eqt8h9Sbcy1PINCR8=;
 b=iXB6v/764QzMXbCDmNkR5IlwHnCXvFqFd6xV+Ryoqh/JezzUbh4U71TY5/GgG6XICi
 rVJ0LUHP7Rwj9jXOK2p6B3iK6HBArH9wo49LUu1ZMCfcbYDMsQ43hm2OocAqJBluhXo+
 FUT1lOeLogROsAOzv5S76t7pO519+sLZx/2ra3NTFn32eGR34ct22ReVSsitFkCCyMct
 dkx4udxgbkV/UX0IJQXcxs3AHJH+9tu/OJo+99kYkizNMR4hoeHFEXYY9zvf/bynMhuH
 +TUdAhupXji7KScyCzp7osBBzxDdSTmoArddjCVhqeaJQEPA87LlEIfbmXSG+LC202+r
 bIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724420964; x=1725025764;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RmknMyAEHfs1JMtP1FJ6M3yqq1Eqt8h9Sbcy1PINCR8=;
 b=dDD6/Kh9XkVev4GMH/WpxZ8FjDH096KU7wQuBqHprkHMMCPELVWw0ijEftK7lLr04w
 1LXBKB8TJ9M4rMRocZoAa2XiEXgmu7BSTMzV4XR45FbnMnqv7+Sa781Z3QqqySrFR987
 4lccy0M0t64h1xjx5+1WETKfX0omfMhBRgz6qInJteeuvsX8ElWNIXuwWLn31SfrkXHs
 +o2wO3poO1Fpi80KuREtlHu5f2AklGM7DR+EXKMHt3M4xI7/bFjutRKyq79MjW8ZsC6m
 +4k69fV79FFdn1QJtW+9WXQvjmb1uIug2Em5V8yPDnm+focswQQ9aABO8U+vFZ/oOMNo
 f59Q==
X-Gm-Message-State: AOJu0Yx4fmjfdRHWS+FDVBxM1KC+r+ix16Dhdl2XHyv9qIjFMkOOAZSm
 rTISLyJyXKDfypPjOhNDhTiOOEhQyu9MPYnMbbwOrdULqXIeKgiTIwePuihm1u/fcWlcWjzWksc
 h6tnVyOFC
X-Google-Smtp-Source: AGHT+IHW57QNcozdIYbGYZevNSiYsUeIRcb34lzcSVdQn8CrupBZjgqQ3bPTISEFjMKxbplQaS18og==
X-Received: by 2002:adf:f8ce:0:b0:368:6bb:f79e with SMTP id
 ffacd0b85a97d-37310eb3921mr1502688f8f.4.1724420963540; 
 Fri, 23 Aug 2024 06:49:23 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e668:dc94:35c7:8064])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-373081ffb40sm4201665f8f.76.2024.08.23.06.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 06:49:23 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v9 13/37] test/py: test_efi_loader: add HTTP (wget) test for
 the EFI loader
Date: Fri, 23 Aug 2024 15:48:17 +0200
Message-Id: <ab83e1d833eb86dda8b3ae6f014bdf2754534ac1.1724419624.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1724419624.git.jerome.forissier@linaro.org>
References: <cover.1724419624.git.jerome.forissier@linaro.org>
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

