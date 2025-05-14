Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6061C3ABDA
	for <u-boot@archiver.kernel.org>; Wed, 14 May 2025 07:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09D4882A76;
	Wed, 14 May 2025 09:44:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TU4btZJJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 83BB282998; Wed, 14 May 2025 09:44:22 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97E4980107
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 09:44:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=adrianox@gmail.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so4118705e9.1
 for <u-boot@lists.denx.de>; Wed, 14 May 2025 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747208660; x=1747813460; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZJT1mXdCIfo66tEHEt//y9BN3P5lpojTnEiFKYVpFxk=;
 b=TU4btZJJr5QgFHhkxTyl/okEbufxX3R7glhBKWe0wXGv2GCj6+63wBj6IXN8qDp4/T
 r9LomzzODDDDDPUqQjPWk6C+4DpiZPHSLEnvm0YSegZw/rizEpC68y6iDiYflpWuKkDP
 63dVFIykuIZ8xr/8Do+te6Seb7WUwAxaWTC12avvqF016S9f2fA/vRR8z0sU4eUcWOio
 e73q2HKUOBTn2wlSsqEjTXHFdVVw9iMht2ny7MQG+v0gBb0v+kfz+1FxaqCf6mnACe8h
 ZSZBiSPWISQqmp+iApelllEQdU6H231kTBpLixBZd2yAHIt0A8M1iWK6jr85vAolqADO
 gyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747208660; x=1747813460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZJT1mXdCIfo66tEHEt//y9BN3P5lpojTnEiFKYVpFxk=;
 b=cFpIPth93qYcX8fI7e0lHCEfSv30bwBuzNLmcVMPQbsUILN4EDW+h/qJc5hC3UgA7K
 vm81Zlt4fw7BFvH0/nAy8Qa/nFJkL7e0Cr667INX26V2nCOge8fq1xZfXSj7ca5Ob3sW
 7PslHLOQ9AhGLmrYC9QV0vOrGgiNapsjeJp7rJY7nRowXm6vIiMArvHCzBahnc8eboW3
 6fsAWLjvO8YV+DwjgL9zl5OoA1mpar3XrNUvnai96E0ZBiYl2qyMiHtlWc1DFEMAT3Ct
 /fCKGYXGtUSVaBgSZr0Ou0hMckclOX/ULuLF3wa2lAsUC+luRyDJAxUrFuctB+gZQquG
 Dqsw==
X-Gm-Message-State: AOJu0YwA8H3SHV7J3C54GNGmVxEKVqEkqy/KH/8SqvvbUKEv30N1VoHt
 aVCEsmGjU5fam5LVjY3u+bjOrrgE4XwefV+h/QNWJp/TWwOzKY9MQk/wJaIG3lQ=
X-Gm-Gg: ASbGncvYUdYKrFhtNdScZC0p7gTTPuPhCAnBBCF2jxuKBycnIxu93PmU4u5zBGotJZi
 8JgMFfw2QS92xvqqIltm3axIN1C0iBCO8Is0A7WUc1N47SzsRo/voaNm3mj8VLh+874TeW6e4JK
 BIZ7sWDr5X1hwlxOyi9DK5eXv1lK940cjcfb7crmZ/ASl0d1UguMf5rldM7OH8yvLDYufJomzOU
 9WQsmpfsuuzOP85yyzNvrqYjRqmNzyaO2fkV5OuABx0fbAFObtyfvSZ+EGZxcroRQQ+hWCDRwtk
 hjFn4IiUbhCOjrSywX0qjSSnleG0CXlcWI+Y7Euu/z0BjxfvN6ZfjosazGAq5A==
X-Google-Smtp-Source: AGHT+IEm+5pl8aIcLsBMcL9bAB5tZJamAziyQGU4zvnfHMBhY8/xEhVlMOTXTKIszgPt+FaWKw7xgg==
X-Received: by 2002:a05:600c:8707:b0:439:9434:4f3b with SMTP id
 5b1f17b1804b1-442f1a42318mr23555555e9.8.1747208659872; 
 Wed, 14 May 2025 00:44:19 -0700 (PDT)
Received: from adriano.. ([213.157.19.150]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f337db30sm18085895e9.11.2025.05.14.00.44.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 00:44:19 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
X-Google-Original-From: Adriano Cordova <adriano.cordova@canonical.com>
To: u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, sjg@chromium.org,
 trini@konsulko.com, jerome.forissier@linaro.org,
 Adriano Cordova <adriano.cordova@canonical.com>
Subject: [PATCH v2 3/3] py/tests/test_efi_loader.py: execute HTTP testing
Date: Wed, 14 May 2025 03:45:13 -0400
Message-ID: <20250514074513.3562063-4-adriano.cordova@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250514074513.3562063-1-adriano.cordova@canonical.com>
References: <20250514074513.3562063-1-adriano.cordova@canonical.com>
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

Execute test_efi_helloworld_net_http

Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
---

v2:
 - remove --httpserver option

 test/py/tests/test_efi_loader.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 91f151d09cd..e19920b4fce 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -195,7 +195,7 @@ def test_efi_helloworld_net_http(ubman):
 
     Call the do_test_efi_helloworld_net function to execute the test via HTTP.
     """
-    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', True):
+    if ubman.config.env.get('env__efi_helloworld_net_http_test_skip', False):
         pytest.skip('helloworld.efi HTTP test is not enabled!')
 
     do_test_efi_helloworld_net(ubman, PROTO_HTTP);
-- 
2.48.1

