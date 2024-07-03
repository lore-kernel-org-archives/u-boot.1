Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1D6DC2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 21:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBA7E88863;
	Wed,  3 Jul 2024 23:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a/we2MLA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26F1688863; Wed,  3 Jul 2024 23:19:15 +0200 (CEST)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E738188872
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 23:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-25e134abf00so3296fac.1
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 14:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720041551; x=1720646351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=VTlbX4tXg2gmraBqsjU0YRSRb29oi02TXTqgzxuB8fI=;
 b=a/we2MLAH9fmh2OjIgEak+VqpchIkn3R/4yBQQF4dsqGsSW4C54dpVx5sAQfqG7ztO
 ewbIomnByP1D1Zv0h9DuqjtC4Kt95YeYt//rwgDGak2NVj/90FZVG4ySafSZ9HRmk36q
 jMedmjAB9m7GZipHefiJkDSSHXu+A61L8BYbI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720041551; x=1720646351;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VTlbX4tXg2gmraBqsjU0YRSRb29oi02TXTqgzxuB8fI=;
 b=RVXtm+ivx6WpgQF9TY+3YXIguJ7MpFu8X/gn5wS/YMsKy9dANycH4XNXJn1eoaFqEW
 1tOICo3polKmFhJocMIUkoD+q/4n0GuO/PSTHR9AF0n6kHtuIyiHZrl6ofVu4xYU0btY
 eqEwRXJnrNIwVzhJ8yQIyEUWuxAkxYi9dIP+JPRGyf3YoCPbl7qFPBDDGlfjws7AC1mM
 +7OVw5f7jISiXCVsaSjaQGgFELzv+RP//OntCvTGpJwgVAxzu6Sm2DitWWlxRY1FtmmM
 8tFOYX7lCQyFaBaEOihOfwdFR0HXESqmW4yHjBuj/70Nk0xcnePG9+0xeBeI5OBRPfws
 yo/w==
X-Gm-Message-State: AOJu0YwaHJMx99xXwoPcqJlBm7Kts2LgyE2TBf7p1SThOVKnFLifoFkR
 xlKwaLYiyR/ljIicDcDxBKDCiBCj/CKncxP+pSkEU0AxZmczSWPtNuiPGURSgIqp3HYsmn1g5yD
 IexY=
X-Google-Smtp-Source: AGHT+IE5AJB6JOP7e1LcBhHv5WpGkmHiLIOZ5Z8QZQJGEysfHivIq+mfepFgEOttOXCZ4LCeRcCWnA==
X-Received: by 2002:a05:6871:24cc:b0:25e:940:e934 with SMTP id
 586e51a60fabf-25e0940f0a3mr3394856fac.47.1720041551559; 
 Wed, 03 Jul 2024 14:19:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (fixed-189-203-97-45.totalplay.net. [189.203.97.45])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-701f7b36034sm2097719a34.66.2024.07.03.14.19.10
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jul 2024 14:19:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test/py/tests/test_fpga.py: Correct check for legacy image
 format support
Date: Wed,  3 Jul 2024 15:19:09 -0600
Message-Id: <20240703211909.1435390-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

The build option to support images of type 'IMAGE_FORMAT_LEGACY' is
CONFIG_LEGACY_IMAGE_FORMAT so update the pytest to check for the correct
option.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_fpga.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/test/py/tests/test_fpga.py b/test/py/tests/test_fpga.py
index ca7ef8ea40d6..460ff227f6f2 100644
--- a/test/py/tests/test_fpga.py
+++ b/test/py/tests/test_fpga.py
@@ -256,7 +256,7 @@ def test_fpga_loadbp(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 def test_fpga_loadmk_fail(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
 
@@ -275,7 +275,7 @@ def test_fpga_loadmk_fail(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 def test_fpga_loadmk_legacy(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
 
@@ -289,7 +289,7 @@ def test_fpga_loadmk_legacy(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 def test_fpga_loadmk_legacy_variable_fpga(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
 
@@ -306,7 +306,7 @@ def test_fpga_loadmk_legacy_variable_fpga(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 def test_fpga_loadmk_legacy_variable_fpgadata(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
 
@@ -323,7 +323,7 @@ def test_fpga_loadmk_legacy_variable_fpgadata(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 def test_fpga_loadmk_legacy_variable(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy')
 
@@ -342,7 +342,7 @@ def test_fpga_loadmk_legacy_variable(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_fpga')
 @pytest.mark.buildconfigspec('cmd_fpga_loadmk')
 @pytest.mark.buildconfigspec('cmd_echo')
-@pytest.mark.buildconfigspec('image_format_legacy')
+@pytest.mark.buildconfigspec('legacy_image_format')
 @pytest.mark.buildconfigspec('gzip')
 def test_fpga_loadmk_legacy_gz(u_boot_console):
     f, dev, addr, bit, bit_size = load_file_from_var(u_boot_console, 'mkimage_legacy_gz')
-- 
2.34.1

