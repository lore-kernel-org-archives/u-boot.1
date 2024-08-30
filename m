Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87854CA0EFB
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 10:19:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16B6A88B40;
	Fri, 30 Aug 2024 12:17:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ocq5lCr1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3F7988B36; Fri, 30 Aug 2024 12:17:41 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30F2886E5
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 12:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-37186c2278bso1465941f8f.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 03:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725013059; x=1725617859; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QbZVlJebjDcysexzGA3hEXvcZomrRPMcMsuwByFYdbw=;
 b=ocq5lCr1QanfQk96Ag1qu5F7wduOGxRnba3pCoqAavU6RNxol3rcfqTCFXRqD2bZOy
 vubkOSjzzap9xO28fgDOlmSwK26Ya1YZsiYn/EWuF8sInmMPPpxUGA8OH+NAEK4owPHg
 DajgmbnIw+13q47GJFgmsaPTxUH6nVpXi6jqm9NwJaznjUgvbsDUiYBbazVMrfPt/ogg
 xwOyopix0EblmnClu8cyd7e6I4mhOPFr4/F4Q4CEFpZg/ORwa4M+IquW6fcWit8CpzPo
 QhvUmznWMiF9cmkTtTvrH9GVxxgbT4W3FZ3Hq07cdQL3cO9T04QkeP4OXa3+hXSJfhUB
 w6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725013059; x=1725617859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QbZVlJebjDcysexzGA3hEXvcZomrRPMcMsuwByFYdbw=;
 b=ebc8JRsDd0rhjRa09JTtYadEwt31CC4HS7V3uzt1J2tpCmmreNU0KR2P39BrbqBOVZ
 mTjw3Q8EqwYZhPplWsLJntRXasIdCGbW7s88Kcsgj+ZTteCBcqT54V5O61FjUES+uuqN
 pbFJhDslim112hW4VrHMdOTEV3s6dCBF6A25aXUyTSMh3BTx16Cz2pk3Yp71LQdNqh1A
 YVCxRj5PdZ7W4P5mwJCPLC7tfrTRmqYyBfXnW5gYCnheV4s4voTeLXioDyg26wVp+OCp
 ICA/5G7y+zq0neKaHUsi7diWQy4SdUoCs1rpCFnuveZ4k2jD9wc6Bh1ftvRhOCH27NsZ
 xOig==
X-Gm-Message-State: AOJu0Yzs0DwvPKxfu7T2Y4c0Dp9NLNFpMis/iwBvl3DPpM1hWbekvcUK
 NA55k7X0fORYPXSLkDg2F4evSv1QKti2WX3gOJ9C6qeXkvhGmU5cUkDricFx4McT1EeCz2Pslmt
 3WHYguNI0
X-Google-Smtp-Source: AGHT+IGCxmNOk/YVIcMnwglMWCxLPOdJQoJjhqzZjyZr1pV7PNs+x2lMCqs9KuqTb1BLaELgjwjV9g==
X-Received: by 2002:a5d:668d:0:b0:36b:ea2d:fd5a with SMTP id
 ffacd0b85a97d-3749c22131fmr3238072f8f.22.1725013058701; 
 Fri, 30 Aug 2024 03:17:38 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b6a3d27fsm472728f8f.59.2024.08.30.03.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 03:17:38 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 14/16] test/py: test_efi_loader: add HTTP (wget) test for
 the EFI loader
Date: Fri, 30 Aug 2024 12:16:57 +0200
Message-Id: <6f3a49531286932d01e92a55071a80f3765b1700.1725012294.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1725012294.git.jerome.forissier@linaro.org>
References: <cover.1725012294.git.jerome.forissier@linaro.org>
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
index 7c1e0ffa59..5f3b448a06 100644
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

