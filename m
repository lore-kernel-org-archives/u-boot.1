Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD765C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 08:19:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2810A82B07;
	Fri, 16 May 2025 10:18:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FjiVA1lt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACF79803DF; Fri, 16 May 2025 10:18:02 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67C2480079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 10:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a361b8a66cso177871f8f.2
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 01:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747383480; x=1747988280; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QUqNes4vQo0CSvSW/i5UMTc064edywwv28brzKV8XUo=;
 b=FjiVA1ltAYsTD0UBzdgcTT200MJ3IiA9C2oYGvbUvcfUDUqu8mLtl6I4sJrvLhcLdx
 EtLZ0pqKUrSh6NQZ8i+f2nE/LZ0jwKJ5eE4eSdv7RovU530sWUTyDI1z4gDuOgzYLPir
 6USftVc6nYlivztLyHe6DQAjyv6Bndv9byIQb1sSvLwmQmzbWbJ7RsxK2Vr9QhayNODR
 X2R0D9QNKd2IJ8q4oPvuBoDy9i2CkXc4nbc/Enngts5j5cwew7WSSkZls1ZWMg91yXW8
 sj0P69gpaM2up3fCfq8cyi0YiEECpgxZAa3L7LEcJfDIdAE+BBkyyrZaY4siQBusvhpj
 jBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747383480; x=1747988280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QUqNes4vQo0CSvSW/i5UMTc064edywwv28brzKV8XUo=;
 b=i034tL+vH4wDORTDuf1CeMVIZMddtt/deC3sEyBfh2lFsbrV2lKwk0+5LlW4Y78nvt
 VPId99PrZf42A6FXpeP55XJg2sKzfPHH89RPfeZu7fGFuXXcg+MyOd320teiBtnvNWSO
 GNy1LIAoNZIYZRzr5P2YctM5NQjN9PJ/MHhVatUzEq37HlN+6CkMxB0lAw8dmHYxLp2y
 wRwQA6E9mtU9ErbniQt+kUfjdcsJVZLQZ+aOrPiFnqwX+GOROMco+vI2Q+ENbSmRYEzD
 m4JDJh0EoiWfTCGBqXrTrhOyBPrZUcw+wBVEChXE6IOxfTbInlHxWXH1HgJQt1vCJr6M
 rQAQ==
X-Gm-Message-State: AOJu0YzPtDqGL/xpdf/1RQq3gachUa4JqGDjANVOxqARAgXKNwBuhYpH
 QZsYRrmq0uRa6LKitVe/+EXcMIgB8JClHZF69SU24PZhykk+bxz9QOyU4wAPhjjjmIo=
X-Gm-Gg: ASbGnctHEGcdDzxAhHkaRsK2tSuWf+93WesLMWdEO/BrwZnxUtN/SegybMYk1wTWiWJ
 kxvBk1LdW6+skYwmf0cqGEfX0dws30R6JBxjd407Lwa9R4xGCnn+LPUc78H82Db16C74BH2+EK7
 ObiRbYgCkJTTvh/sKx8R1c4SgsaCAIkcL3ih/FphzsodeZXqtqXG30luCLXx8fueHUHuXSWp1YO
 sJtmSsl14qe5Z1FO4QdbO+LXhsW5hY/oXCc6Zutob8d/1UUiaE+dpmizprX9MJHVB7KKARJFV7/
 K8Er48uswA5PaXONt1YzRi9ArMWXmA4+ZVqMAqKxBHASkCJH+fudyjtpF+cIBQ==
X-Google-Smtp-Source: AGHT+IGjdEKnA9MDw19B9Lju/Rfczm0NK4PnXa4gNkz65SALqUs2JdQA1S+51Zk0blPCdymZm0X/Xw==
X-Received: by 2002:a5d:59a9:0:b0:3a0:831c:dff6 with SMTP id
 ffacd0b85a97d-3a35c83acebmr2566456f8f.18.1747383479687; 
 Fri, 16 May 2025 01:17:59 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a35ca8ce9asm2010159f8f.86.2025.05.16.01.17.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 01:17:59 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH 9/9] pytests/test_efi_loader: Test EFI_HTTP_PROTOCOL
Date: Fri, 16 May 2025 04:18:39 -0400
Message-ID: <20250516081839.28587-10-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250516081839.28587-1-adriano.cordova@canonical.com>
References: <20250516081839.28587-1-adriano.cordova@canonical.com>
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

Download via both TFTP and HTTP an EFI application implementing
an HTTP client using the U-Boot EFI_HTTP_PROTOCOL implementation
as backend, and from the application then download a payload via
HTTP.

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---
 test/py/tests/test_efi_loader.py | 63 ++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 91f151d09cd..4f0e6c92133 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -48,6 +48,18 @@ For example:
         'addr': 0x40400000,                    # load address
     }
 
+    # Details regarding a httpprotocol file that may be read from a TFTP server. This
+    # variable may be omitted or set to None if TFTP testing is not possible or desired.
+    env__efi_loader_httpprotocol_file = {
+        'fn': 'lib/efi_loader/netdump.efi',              # file name
+        'size': 5058624,                                 # file length in bytes
+        'crc32': 'c2244b26',                             # CRC32 check sum
+        'addr': 0x40400000,                              # load address
+        'payload': 'http://10.0.2.2/path/to/payload',    # file uri
+        'payload_length': 6354745,                       # file length in bytes
+        'payload_crc32': 'b22e4a36',                     # CRC32 check sum
+    }
+
     # False if the helloworld EFI over HTTP boot test should be performed.
     # If HTTP boot testing is not possible or desired, set this variable to True or
     # ommit it.
@@ -200,6 +212,57 @@ def test_efi_helloworld_net_http(ubman):
 
     do_test_efi_helloworld_net(ubman, PROTO_HTTP);
 
+def do_test_efi_httpprotocol_net(ubman, proto):
+    f = ubman.config.env.get('env__efi_loader_httpprotocol_file', None)
+    if not f:
+        pytest.skip('No env__efi_loader_httpprotocol_file specified in environment')
+
+    payload = f.get('payload', None)
+    if not payload:
+        pytest.skip('No payload specified in env__efi_loader_httpprotocol_file')
+
+    ubman.run_command('setenv bootargs nocolor');
+
+    addr = fetch_file(ubman, 'env__efi_loader_httpprotocol_file', proto)
+
+    output = ubman.run_command('bootefi %x' % addr)
+    assert "NET Dump" in output
+    assert '## Application failed' not in output
+    response = ubman.run_command('wget %s' % payload, wait_for_echo=False)
+    expected_text = 'Efi Http request executed successfully'
+    assert expected_text in response
+    expected_length = f.get('payload_length', None)
+    if expected_length:
+        assert f"length: {expected_length}" in response
+    expected_crc = f.get('payload_crc32', None)
+    if expected_crc:
+        assert f"crc32: 0x{expected_crc}" in response
+    ubman.restart_uboot()
+
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('efi_http_protocol')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
+def test_efi_httpprotocol_net_tftp(ubman):
+    """Run the httpprotocol.efi binary via HTTP.
+
+    The httppotocol.efi file is downloaded from the TFTP server and executed
+    """
+
+    do_test_efi_httpprotocol_net(ubman, PROTO_TFTP);
+
+@pytest.mark.buildconfigspec('of_control')
+@pytest.mark.buildconfigspec('efi_http_protocol')
+@pytest.mark.buildconfigspec('cmd_wget')
+def test_efi_httpprotocol_net_http(ubman):
+    """Run the httpprotocol.efi binary via HTTP.
+
+    The httppotocol.efi file is downloaded from the HTTP server and executed
+    """
+    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', False):
+        pytest.skip('httpprotocol.efi HTTP test is not enabled!')
+
+    do_test_efi_httpprotocol_net(ubman, PROTO_HTTP);
+
 @pytest.mark.buildconfigspec('cmd_bootefi_hello')
 def test_efi_helloworld_builtin(ubman):
     """Run the builtin helloworld.efi binary.
-- 
2.48.1

