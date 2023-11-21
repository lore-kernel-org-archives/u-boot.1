Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DEA0C61D88
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 01:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 778B087593;
	Tue, 21 Nov 2023 02:31:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="M8chPif7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C0C875AB; Tue, 21 Nov 2023 02:30:52 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E428986BFA
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 02:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=takahiro.akashi@linaro.org
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1cc28719cb0so8856985ad.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 17:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700530242; x=1701135042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtBO7KJX8Q9+7Q4jJOUKHuAVfeIuAYXNAI/om3PTs+Y=;
 b=M8chPif7z/fdqAwoYaHwRJ5hCMKapX3rim0DUsxqFGLNiHJRIJbNbwY80ZZ5DTj3ai
 XS/MwF3KOV6Ivwpc15kpsvl5S2fxObyD/lAgvmTnU+Y6RMeRprFJBhUTktMimmOf33uE
 LYfr8Abbmr1wgJ36uElyiCatqNBwHGYhhw2A9ooTfFg5+tnpbtekS7b10B5WtOpbauNh
 axk0n8wt7ZbjM/pfkMluqaDLFkh5yQNqtGHnzEcM0p8P69pUzoXb7ghYQL99BjQ+IbhY
 X+ZjAvaSAopMSLFY8xXCmPoKEEBfNlgcWNkWrrJKk1Kxv1TzfMJ7owvFEEPzPqi94KIH
 v4Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700530242; x=1701135042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtBO7KJX8Q9+7Q4jJOUKHuAVfeIuAYXNAI/om3PTs+Y=;
 b=kx8s4g0/FvOXI4DD7wNHVg76JKkWxtd1QMXllCaWTriezkHeb+3pviHyevZrQ0V8o9
 wNmLwb4odm5N2Q3YK91WRGv7XL+eE+lqAYizMmWYpSHk8mJj90txKPzD0+3f8PdfrB/0
 Z8uFmIdaEyE4EZ3Ha8EvxnUdDsXzmjVH209zZD1AYP6pipDjej+dsK6cHfCn4tYPc6j5
 jN6vIyvjHow+RV+1LkmoEsNvm84TgV8/6C/qDsxjm5ulZPDPugiQW0rX/YB/nkVcBRbp
 IpxW3SvhGBEp9h/nFGYIHXPcC/uPPrOZyr3Hn8mTGwE81iW4zCv7oc024/FDxpwvgUba
 Yvtg==
X-Gm-Message-State: AOJu0YyoAplc5qX4FNhXb+PL6X6uMkxXbf/b07yBxtPKh+cvdUnospwF
 PN3gdJf5xsziNHqpsYpJ7MN6KA==
X-Google-Smtp-Source: AGHT+IFdZXZOT2ozViPXgsM3oer379bayuBSqbC/cTPRpQnFdLhKQWDid1HV/hug1K6R99Vf9bfK+A==
X-Received: by 2002:a17:902:eccd:b0:1cf:6a75:e989 with SMTP id
 a13-20020a170902eccd00b001cf6a75e989mr2294288plh.6.1700530242416; 
 Mon, 20 Nov 2023 17:30:42 -0800 (PST)
Received: from octopus.. ([2400:4050:c3e1:100:f6af:a59c:7ca:897f])
 by smtp.gmail.com with ESMTPSA id
 e9-20020a170902d38900b001c8a0879805sm3612508pld.206.2023.11.20.17.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 17:30:42 -0800 (PST)
From: AKASHI Takahiro <takahiro.akashi@linaro.org>
To: trini@konsulko.com, sjg@chromium.org, xypron.glpk@gmx.de,
 ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de,
	AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [PATCH v2 05/12] cmd: bootefi: localize global device paths for
 efi_selftest
Date: Tue, 21 Nov 2023 10:29:43 +0900
Message-Id: <20231121012950.156539-6-takahiro.akashi@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121012950.156539-1-takahiro.akashi@linaro.org>
References: <20231121012950.156539-1-takahiro.akashi@linaro.org>
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

Device paths allocated in bootefi_test_prepare() will be immediately
consumed by do_efi_selftest() and there is no need to keep them for later
use. Introduce test-specific varialbles to make it easier to move other
bootmgr functions into library directory in the next commit.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
 cmd/bootefi.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/cmd/bootefi.c b/cmd/bootefi.c
index 957e2618aca2..7930c99def44 100644
--- a/cmd/bootefi.c
+++ b/cmd/bootefi.c
@@ -29,6 +29,8 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+static struct efi_device_path *test_image_path;
+static struct efi_device_path *test_device_path;
 static struct efi_device_path *bootefi_image_path;
 static struct efi_device_path *bootefi_device_path;
 static void *image_addr;
@@ -586,23 +588,26 @@ static efi_status_t bootefi_test_prepare
 	efi_status_t ret;
 
 	/* Construct a dummy device path */
-	bootefi_device_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
-	if (!bootefi_device_path)
+	test_device_path = efi_dp_from_mem(EFI_RESERVED_MEMORY_TYPE, 0, 0);
+	if (!test_device_path)
 		return EFI_OUT_OF_RESOURCES;
 
-	bootefi_image_path = efi_dp_from_file(NULL, path);
-	if (!bootefi_image_path) {
+	test_image_path = efi_dp_from_file(NULL, path);
+	if (!test_image_path) {
 		ret = EFI_OUT_OF_RESOURCES;
 		goto failure;
 	}
 
-	ret = bootefi_run_prepare(load_options_path, bootefi_device_path,
-				  bootefi_image_path, image_objp,
+	ret = bootefi_run_prepare(load_options_path, test_device_path,
+				  test_image_path, image_objp,
 				  loaded_image_infop);
 	if (ret == EFI_SUCCESS)
 		return ret;
 
 failure:
+	efi_free_pool(test_device_path);
+	efi_free_pool(test_image_path);
+	/* TODO: not sure calling clear function is necessary */
 	efi_clear_bootdev();
 	return ret;
 }
@@ -627,6 +632,8 @@ static int do_efi_selftest(void)
 	ret = EFI_CALL(efi_selftest(&image_obj->header, &systab));
 	efi_restore_gd();
 	free(loaded_image_info->load_options);
+	efi_free_pool(test_device_path);
+	efi_free_pool(test_image_path);
 	if (ret != EFI_SUCCESS)
 		efi_delete_handle(&image_obj->header);
 	else
-- 
2.34.1

