Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83EE7C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9214B87636;
	Mon, 27 Nov 2023 14:00:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="b/bZVD4u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2393B87617; Mon, 27 Nov 2023 14:00:47 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33F3087570
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:00:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-50a6ff9881fso6358922e87.1
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090044; x=1701694844; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Lv+IzLO2cUAOkfnCTRBq4ia8OKl6IHY5T/8C3fm1Ac=;
 b=b/bZVD4ut2skVJZ800lTBrU6s+hlyrIIaWvcMOE4IPqog0WTOtPUSEbS7tBCnu/124
 rkMHGDRri9HXLA6OKlk6+y6jnY2kp126XeNjaevmAwIEQ4kK5gno2qC6fsCcRUKvJFkL
 PZsXrFelid+ufFLSGX+tYXiPysx4yM/6doNfzSKhZbChQOT/6efMZTnqWuIptzhDGrAi
 8TRnV1vvzncD60fgdrwMehhNDe/K6tet98mjBcOwKO0k5A2NzL5PkgNAA6eWDoh19cBT
 hlm6izTgjBWGu00W7vnRHn20truhpmeqI37ZLc4puQ5mQ0GTNPlhGfHRpKo9Foh0p/ID
 eOqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090044; x=1701694844;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Lv+IzLO2cUAOkfnCTRBq4ia8OKl6IHY5T/8C3fm1Ac=;
 b=W0TcPJdd3UuCgyldNtihZ2PLlAXv5ZZk5tEcDXK9vPTM42d3gtD86AtYwbeJXEVYAM
 7FIlrn8F1Yb5yCFxKGg4TGegpXM/TPlElAaBvagaK2g+XMiUtr7UXYJd8bPdkkmh3NhS
 cBfejiuiwxFui4KFUSZor35URNtAQrpikbB8MJISLi9e6DGJvkZpSCQYpecYeQ+86feH
 5gJbA/BV20uK0cni17NOQW3jOt2A0ejMhIVp9QatR5jx7UbDz7yriJo+GH9DD6fWyCia
 jlS9//+w7NFVimDq8kNOonBgXFpAZfsq6Yx56K+N0P5SortZdvkz5kBjpRmT9eY6JtG7
 iqdw==
X-Gm-Message-State: AOJu0Yzda7sG/5M7MseN7CFMHkQa2rR0Ku5EXgNb65V0h+BKY3qYvmvF
 tWPM5XIGpT4ZLwEpWNQyq8K5gLPBnMRZlsLblYNKrw==
X-Google-Smtp-Source: AGHT+IH5RjdT+xHjcvUM1uFYOyNV2vGqS7ijKyR7UNYNGpHA+MTls+9Tay5p8PpfpV1G4P8JTcgSjg==
X-Received: by 2002:a05:6512:4022:b0:509:4ae3:465b with SMTP id
 br34-20020a056512402200b005094ae3465bmr10439246lfb.8.1701090043836; 
 Mon, 27 Nov 2023 05:00:43 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.00.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:00:42 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 15/43] test_efi_loader.py: use $filesize var
Date: Mon, 27 Nov 2023 18:56:58 +0600
Message-Id: <20231127125726.3735-16-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

bootefi code relays in internal variable then to filesize environment.
lwip tftp do not update this variable. For not I update test to provide
correct size.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 test/py/tests/test_efi_loader.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/py/tests/test_efi_loader.py b/test/py/tests/test_efi_loader.py
index 85473a9049..9b2541593c 100644
--- a/test/py/tests/test_efi_loader.py
+++ b/test/py/tests/test_efi_loader.py
@@ -158,7 +158,7 @@ def test_efi_helloworld_net(u_boot_console):
 
     addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_helloworld_file')
 
-    output = u_boot_console.run_command('bootefi %x' % addr)
+    output = u_boot_console.run_command('bootefi $fileaddr:$filesize')
     expected_text = 'Hello, world'
     assert expected_text in output
     expected_text = '## Application failed'
@@ -187,7 +187,7 @@ def test_efi_grub_net(u_boot_console):
 
     addr = fetch_tftp_file(u_boot_console, 'env__efi_loader_grub_file')
 
-    u_boot_console.run_command('bootefi %x' % addr, wait_for_prompt=False)
+    u_boot_console.run_command('bootefi %x:$filesize' % addr, wait_for_prompt=False)
 
     # Verify that we have an SMBIOS table
     check_smbios = u_boot_console.config.env.get('env__efi_loader_check_smbios', False)
-- 
2.30.2

