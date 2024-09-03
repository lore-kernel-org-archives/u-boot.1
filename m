Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385ADCD3427
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 08:41:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEA6E88CD0;
	Tue,  3 Sep 2024 10:39:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Eam6hdkW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205E188D22; Tue,  3 Sep 2024 10:39:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E2C988CED
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 10:39:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42bb9d719d4so36858385e9.3
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 01:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725352741; x=1725957541; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3bGIbCSvTZOUrrfzEdG3CRsey8qYbjuB8FdRv1iwMkY=;
 b=Eam6hdkWHPDmOmk9thNEhfAz5GhX4IKAaU19phuEldOrvim18AEZJOu8nLU0g78aSV
 xh0ahinCbqH5k0FiKgpljZecujJTPlkfZ97P9KeXaq4/ubVten/usvRywstA+WspQ3Ta
 dlnR7oLP4kAfir38j3odkAmQa7BVov4DOZQyG4KQShKwg9rYdc/JzzgXeUpd7SX1VDeD
 Df/elPVy9KXk3cWeqC//zoR8pw4YOObwdzZBkdMZiaScT6dUNIvIsRLCcnoI+9JCJSs9
 o6qieRyW7M6w5mwL8bsgMq9ZY6pajzfUy5/ArgrPnhHhz9G/YD8OetADQRvTb/S/NtjQ
 zORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725352741; x=1725957541;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3bGIbCSvTZOUrrfzEdG3CRsey8qYbjuB8FdRv1iwMkY=;
 b=b7wR/mS3PrDVVHPaBEsBKItOGnjwJwxdz0Qn2jpKtkFJ8NQFkjTYWTby+0WHKMp7mP
 pwUvyCT6fkyHSGF5pG51olv7nkc/SWLF8rjTONtT8Gu8UD9nGIz5FoOTge52yM0EZXbP
 tJv1ZAuox50uQ50lUPxF2ZemE4+Mvv/jcf1oN5sIDCuZQ9YYIV11ZDl1HBazcH9Laxop
 dFFNYOYa3jJklkGMt58FvC6NZ5dLzJ2/w3CfitwRk0MCqsP2m4JRTCYnow6Z2+tPoipN
 SPSZmkA33dHbE/R2uVSZpdtZuKXz9JtMXpyLzSqNzY9ITj8JlouaVhfFLDok2aU3oG16
 u7kw==
X-Gm-Message-State: AOJu0YwGd8uGppIEEfOKP3KgDH9amQQa4tyDLF70i8bbuTrxSsc6ygQG
 Q0Gp552t47xkw0D9C3TddGjo4jUFCphRbEUE6F8bH3+eBSu77G+jcUxrQIxy4X9nzTjX69uZOUK
 spVjQZg==
X-Google-Smtp-Source: AGHT+IG31gEg00ktlJ654Z5O6xi8e2KC//q3C5IQXdvJSgOO+LilFS02jF9AWHxZxIeSkMe3DjV7Jw==
X-Received: by 2002:a05:600c:45d1:b0:42b:afbb:1704 with SMTP id
 5b1f17b1804b1-42c880ec5e4mr21819265e9.6.1725352741433; 
 Tue, 03 Sep 2024 01:39:01 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df795asm163103325e9.21.2024.09.03.01.39.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:39:01 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v3 13/16] test/py: test_efi_loader: add missing dependency on
 cmd_tftpboot
Date: Tue,  3 Sep 2024 10:38:10 +0200
Message-Id: <31db70d1519d1084258a7de1895b77f0e34cbbbd.1725351676.git.jerome.forissier@linaro.org>
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

test_efi_helloworld_net() and test_efi_grub_net() depend on
cmd_tftpboot so add the missing annotations.

Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 test/py/tests/test_efi_loader.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049b..7c1e0ffa594 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -149,6 +149,7 @@ def fetch_tftp_file(u_boot_console, env_conf):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi_hello_compile')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_helloworld_net(u_boot_console):
     """Run the helloworld.efi binary via TFTP.
 
@@ -178,6 +179,7 @@ def test_efi_helloworld_builtin(u_boot_console):
 
 @pytest.mark.buildconfigspec('of_control')
 @pytest.mark.buildconfigspec('cmd_bootefi')
+@pytest.mark.buildconfigspec('cmd_tftpboot')
 def test_efi_grub_net(u_boot_console):
     """Run the grub.efi binary via TFTP.
 
-- 
2.40.1

