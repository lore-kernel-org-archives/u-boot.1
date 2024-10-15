Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98504D216AD
	for <u-boot@archiver.kernel.org>; Tue, 15 Oct 2024 14:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9DAC88599;
	Tue, 15 Oct 2024 16:17:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="G54s3/TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD5C885D1; Tue, 15 Oct 2024 16:17:47 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891D38852B
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 16:17:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-539fe76e802so1111483e87.1
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 07:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729001865; x=1729606665; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7/gbyRSTQRzibMflrFd7z8IlPrxer+KUo5bdDD+IiBY=;
 b=G54s3/TO48pOUdenPr68FA+v6F2/N8jKGxIT5Uuax1/AGVPN311Blmwfs5kK5Gmbo0
 zcjBOrHv6mT7YoA22CN3RoJNZmhyb84pn9dii5mog77WcyjX1Lvxz2oSiH85JrIYUw1y
 +4diVm4W155goeYqVirc2AE/iOE99QODVhcui30vsjE+LwhPHhZ+h/EytNh0AMkSzahX
 98JI0t5IxYdPFVUZvnCbEZgTQmdx68Eksd/GwI/cF7q8a9u3SQtx0BUgSMCYTOkLJn7q
 jQc3/nYDOeR3s8912Il002wfU6pRQWRuPILqhBnWnFrwnnUnwn8FQ/CaBye9U0bWQqF1
 3djg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729001865; x=1729606665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/gbyRSTQRzibMflrFd7z8IlPrxer+KUo5bdDD+IiBY=;
 b=PaHYWs1AQN7ohmguZy63U7YrqwZ7i5yfs+aF22ci3rincZVkg6D/mpMzvyoRlD0z2W
 w8J5xNzgaMD6WtTX08EYgiqU5kCJOHFcK+zgyDVFpslGQfwSUnc8ep4I9oTD0M2j2brt
 uaVaTaGG4aHlpGjt7/BYTm9+UjG655OxLjWc7oOQEUbATDGr0apvS+6c5YGDcUMKIWMe
 GMfedAQ9YcKDrbiMI51tnGzUmMexgcG9h3+/dZ0vLQ7WNC68E7TpYbspU7R3WgA8No2y
 aP7qQkSzC9Kvy1niOmWBeG8cRNekXqeX1IvOK7vI708NTprolmIES7w3XCCc0kTf8536
 zNWA==
X-Gm-Message-State: AOJu0YyG7QxdiNOuQl49JO+IIWiSgF0OSeQENUnGbxW3TWvGKkcPZEAB
 evzCzzhS4snxI/yyccIOrwHJJvApRou2cfC6yMKPwPDIyTh+RWaCZ1zU7bXmrnrxiWKi1lFNJaW
 HJ3I=
X-Google-Smtp-Source: AGHT+IHzXYIkdBG6/l6ZcGGezdFTr8/LYgUUOlkxbednQOulbdxgFoJixHUWKloUhSw78FbRa4Daeg==
X-Received: by 2002:a05:6512:e9d:b0:535:6aa9:9855 with SMTP id
 2adb3069b0e04-539e54051famr5625339e87.0.1729001864654; 
 Tue, 15 Oct 2024 07:17:44 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:edb:fc01:52f8:5161:22d9:48c2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f6c567esm18856535e9.45.2024.10.15.07.17.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 07:17:44 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] usb: Fix test dependency on ext4write command
Date: Tue, 15 Oct 2024 15:17:37 +0100
Message-Id: <20241015141737.1170669-1-andrew.goodbody@linaro.org>
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

The tests test_usb_ext4load_ext4write, test_usb_ext2load and
test_usb_load depend on the command ext4write being present not just
the feature of being able to write to an ext4 file system. So update
their dependencies to include the ext4write command itself. This will
prevent spurious test failures when running the USB tests against USB
storage with an ext2/ext4 partition but no ext4write command available.

Fixes: 1c5b6edad381 ("test/py: usb: Add tests for USB device")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---

 test/py/tests/test_usb.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_usb.py b/test/py/tests/test_usb.py
index fb3d20f082..b86fc290c7 100644
--- a/test/py/tests/test_usb.py
+++ b/test/py/tests/test_usb.py
@@ -382,7 +382,7 @@ def test_usb_ext4ls(u_boot_console):
 
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext4')
-@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
 def test_usb_ext4load_ext4write(u_boot_console):
     devices, controllers, storage_device = test_usb_part(u_boot_console)
@@ -469,7 +469,7 @@ def test_usb_ext2ls(u_boot_console):
 @pytest.mark.buildconfigspec('cmd_usb')
 @pytest.mark.buildconfigspec('cmd_ext2')
 @pytest.mark.buildconfigspec('cmd_ext4')
-@pytest.mark.buildconfigspec('ext4_write')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_memory')
 def test_usb_ext2load(u_boot_console):
     devices, controllers, storage_device = test_usb_part(u_boot_console)
@@ -543,6 +543,7 @@ def test_usb_ls(u_boot_console):
         pytest.skip('No partition detected')
 
 @pytest.mark.buildconfigspec('cmd_usb')
+@pytest.mark.buildconfigspec('cmd_ext4_write')
 @pytest.mark.buildconfigspec('cmd_fs_generic')
 def test_usb_load(u_boot_console):
     devices, controllers, storage_device = test_usb_part(u_boot_console)
-- 
2.39.5

