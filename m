Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF04C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 08:38:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602DA83A62;
	Wed, 28 May 2025 10:37:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ULC90Zkv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 901D983A44; Wed, 28 May 2025 10:37:29 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BC6983A5E
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 10:37:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-442eb5d143eso45122065e9.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748421446; x=1749026246; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eEG7LJyHsNEZ97ji+ZyysYaNteOevWoW54Cx8HL2y0U=;
 b=ULC90ZkvmA1boe3Kex01khP/U3v8q7JDkGPy0Yzq2+edIzfAlTPVMzho0usJlkraGR
 R8qCJxLQzgUvOX/gwVpYRTuvFc8ATDCw5C/Fhc1DoztLb2mIo9TuslopypNTmyF4SDyY
 H4B1lt836zhyLskNJL2nkQ2GYl32CpHfHRNuhMaZyvCArKyvvVvfD58649U7ZJ0J33vX
 JQZTd+NvxNxy1T00+YZDYFUHcrDXV7tPtelUPzRUDpW0UKnhadwvBQKbOfMFGG8jfN0/
 6zhlnQSSCnd8haEpZf/7yOC0FaWKQIJhWhCe6IcKmIdyxZ6iF8IB1OEK5TVOBBUtTy3L
 AeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748421446; x=1749026246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eEG7LJyHsNEZ97ji+ZyysYaNteOevWoW54Cx8HL2y0U=;
 b=S2EGwACeBSUrpS+CuXWvPm0YdJ3kZ6LSU8qXnNvqIfmoer5DuDOn31H2hh3Yjxs6rh
 hu1WA2guU09Isn8Z7TtxDsfqecvyc/E/TXdaMRI4QBWzqG+2/KBb5rG+coJl0MRnwQo/
 GdONVm5QoAcNtkwfgryDc+SSSjr7F5W/UvpxLRhwcnG8m3GSrcqrinMm21mjucKYQoVo
 HSzHMnboiQ2RRydOPzMwyrQf4L4f703KVxb2qcQk3Kte8CL8brdecgf7v2qOrzpkl5s1
 YWuAoEcNVKeKXb/W48phzglVjfO27k5qLN+tEShG6lm3yAc99xqZe9fg5ZA3dxOf9bjo
 sa5w==
X-Gm-Message-State: AOJu0YxQvlSXjU7xtv2eJnHaH5XtOCu8ZSNXalpk6CdnB4P/Q8ttLwJi
 i+Aq5snslOGwDFfCCo/7MrkXI3OIRXauefN6SrvNnK1dii84UFRs34cJjctNbmCtXtQ=
X-Gm-Gg: ASbGnctsdQgk4KX76bFQuNKt6TdXv0QY3bhiDqrBeFCDxN/kjeTEkk9OpujnHL/OlyE
 xi84U49CxreCmKNhdsvW5BVkg5bOj1KRQaf1UqG7OSYng6Ua4JDMB1KV/bvwKYDVhPJEG3Q2HBw
 nuwNMQ1RTTsx/EhSlvOZCisapOjg1ZsiCEQBNOcQ3FxhlEBWERlw1ikKOmJw1Yb3fcHWUzbMOuG
 PA4hfsUxmhSrDR/Ya/LmXNtMuBWF5UsgocKxq3QhI3w7BiRXZ8a6kbojB11auAHlBScCoreLn7m
 b3bmsHg/n8A7R1yJZSHimSDP98PfleuGvH8Kb2OQ/LedXqEA5rzdNeSvGoGnfJvFsHY9hcYWiH2
 x8Mnm54nR7qVVvMiH25CmCXTd/jc=
X-Google-Smtp-Source: AGHT+IElV9A4MV6FjcN4YWmPyFBshOK9vqDAf9hgjZ47X0Lp9O0ejr4Vx4e15ZUIkFpYEINsgmqibg==
X-Received: by 2002:a05:600c:37c4:b0:442:e109:3027 with SMTP id
 5b1f17b1804b1-44c92d351e0mr128375375e9.24.1748421446159; 
 Wed, 28 May 2025 01:37:26 -0700 (PDT)
Received: from adriano.. (15.red-79-153-17.dynamicip.rima-tde.net.
 [79.153.17.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4eac6eb45sm857130f8f.12.2025.05.28.01.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:37:25 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org, rfried.dev@gmail.com,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 9/9] pytests/test_efi_loader: Test EFI_HTTP_PROTOCOL
Date: Wed, 28 May 2025 04:38:21 -0400
Message-ID: <20250528083821.567514-10-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250528083821.567514-1-adriano.cordova@canonical.com>
References: <20250528083821.567514-1-adriano.cordova@canonical.com>
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
index dc58c0d4dbd..1714af0f255 100644
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

