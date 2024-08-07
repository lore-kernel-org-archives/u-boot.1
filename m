Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EEAC52D73
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:16:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF2F88D7E;
	Wed,  7 Aug 2024 19:13:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n652Febd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E34BD88D7C; Wed,  7 Aug 2024 19:13:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDBED88D53
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-42812945633so885115e9.0
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050807; x=1723655607; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OwXVSacIGJrOmt+KdZz2TtbXdcfdbD4gAE3Ma3mZxA0=;
 b=n652Febd/CdB0anBvZiYMn355aPvSJLFUXVcbss38g3KDji5reZCj5on99YUdAyTCg
 NUX516OWyUPjID9wSQWfzNzHPT3jbGqcplokUGxVK5fOnU8oRaF14GFiqXi7YUp+0yi4
 zaJtxSad3QfP9NyIbE0fAufDh6P+DigmSbt8aP1Gl3gJuFEnZmpvyHcuL2riZdWgO0EX
 sr12P+yrhqPX+nM6oyNOu73l4MgCxQ0siTjuyl41JLZFvwL/xyXTPNn2RmYSOM2GfYrW
 25jS9BUDy7qQ8TgaTvaw6ZJjqLPi84AsQMKigkQ3J4QfzL1r1YKvKcU70P4j6df62v7B
 FqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050807; x=1723655607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OwXVSacIGJrOmt+KdZz2TtbXdcfdbD4gAE3Ma3mZxA0=;
 b=mhl21PB3/MhuDKC3/YtCsI4Rw7y2J1Su1ZZRipmrrL/PBiYMNhuUkRnv50tzys1Jkg
 tN4MWgEQS2wWBFT8CaiV8mfrsRz6X7UYx1uAfBd4p9gFzCR33rVdzDdrPmYSqrR00irO
 Kd+OUxmMRxjKQshsze87fF/W1iBIKpMftmLU2bE5RHvuBYwoRMWP1/Vyl8ZkJlsLzCBD
 6fa5shdg08COoD54S6R3Q6OnXLOeWkPO316eq5BVfFb5A1mZ6PAcFSKIqNJ5GBCgwaFB
 1JigzfQLFpMsFqzLUqM7IfCXq+KuPCvsWdTPufSjE6AiiB96DwsggHdbSdm2FJ2GqPqm
 xvKg==
X-Gm-Message-State: AOJu0YxtsQ7wN7+iaeydXTQ+//EZb1NBnu0ot+6aKd9TPFC2UMshv3rY
 koGSxcrygH18VJzQEzfyn05VUJCRC7QzrB/uDG1Lf4fxjFn7Dc7HzooVtPllO2df3kz7ZRiB5G4
 XcmFKcJXx
X-Google-Smtp-Source: AGHT+IHiOvD7txLGf96LFpkjQhEtNx7Oa+dn0kegeImav7GHvd9lIWxgx5s5rz8MODqABJbsuQXjig==
X-Received: by 2002:a05:6000:c03:b0:367:923b:656b with SMTP id
 ffacd0b85a97d-36bbc1d2019mr11915729f8f.54.1723050807023; 
 Wed, 07 Aug 2024 10:13:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.13.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:13:26 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v8 22/23] test/py: add HTTP (wget) test for the EFI loader
Date: Wed,  7 Aug 2024 19:12:06 +0200
Message-Id: <9b055b18f84755d775bf0cf4064e66801608839c.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
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
---
 test/py/tests/test_efi_loader.py | 52 +++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 15 deletions(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..64c994fdf95 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -50,6 +50,8 @@ env__efi_loader_helloworld_file = {
 import pytest
 import u_boot_utils
 
+PROTO_TFTP, PROTO_HTTP = range(0, 2)
+
 net_set_up = False
 
 def test_efi_pre_commands(u_boot_console):
@@ -110,10 +112,10 @@ def test_efi_setup_static(u_boot_console):
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
@@ -128,7 +130,13 @@ def fetch_tftp_file(u_boot_console, env_conf):
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
@@ -147,16 +155,8 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
     return addr
 
-@pytest.mark.buildconfigspec('of_control')
-@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
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
@@ -164,6 +164,28 @@ def test_efi_helloworld_net(u_boot_console):
     expected_text = '## Application failed'
     assert expected_text not in output
 
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
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
+def test_efi_helloworld_net_http(u_boot_console):
+    """Run the helloworld.efi binary via HTTP.
+
+    The helloworld.efi file is downloaded from the HTTP server and is executed
+    using the fallback device tree at $fdtcontroladdr.
+    """
+
+    do_test_efi_helloworld_net(u_boot_console, PROTO_HTTP);
+
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
 def test_efi_helloworld_builtin(u_boot_console):
     """Run the builtin helloworld.efi binary.
@@ -185,7 +207,7 @@ def test_efi_grub_net(u_boot_console):
     executed.
     """
 
-    addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
+    addr = fetch_file(u_boot_console, 'env__efi_loader_grub_file', PROTO_TFTP)
 
     u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
 
-- 
2.40.1

