Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C133AC30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8314588709;
	Tue,  2 Jul 2024 15:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Vo5ck9vg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59B287CF8; Tue,  2 Jul 2024 15:30:52 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A37C8850A
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-58bac81f3f9so829287a12.2
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927050; x=1720531850; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7y2Aqe9bNKKYxPOwwmHZj4GaTeg6kQWNiSCUi9GjQ/M=;
 b=Vo5ck9vgSTA4abiECiElAcMcE29EdwaoErnT0O18glv+C8orzT/dIGC8BvqO3y3/Yd
 TE38v3F/WVe5JMESGlekjzmZIJj1lwXXCru0o1TFbO6L4fpWai4SAOQ91XyV6HcMDdzm
 VvjYNh14/pLL/P7OrtoUIXca0NZ8gIPD7mxr9Fi3KQeEJoh2jshxhr/ND2g9sLq47Pge
 /R0+MoayNDdzxrR2L5pI40Y8kqJTiS8ULm1Wp+qt4l9+2vL8LQuACQDdV91gMwbx3j0x
 SLvbsFkF99prX9YLst4oE845i9s/1rHpaJLcXaI5Ez+DzhS+h4cYoxUF6cUj5fM1vlV+
 PaAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927050; x=1720531850;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7y2Aqe9bNKKYxPOwwmHZj4GaTeg6kQWNiSCUi9GjQ/M=;
 b=n5MEk5LK228q2i7DOEBGm1dip+A65fsFl8e1q+5EB59Apn1ZS1qc5h6CPA7sm2uTuW
 Tjswj3JjZHTzQ/BSPh2thTNvWffbDyZbiakg2pXt9jBQstQMnq4GEDKXCyZKWmuXkDWX
 qjs7CGaB5BdN1Ncx3uM6uVDZrJfzliu9P5xHW2Cc/tfVcmbzDi9F4aZfJyFc3xNxEH3F
 4Q8WfolrRZEqYxdBOyRLmwvl2iTHVXdCzk5OSyvkW5UfddG8PfZNqsIpC+VNL/gaYkD/
 QE/pYukd/D6a0TL+gsOXWjsGIla3ZuXYwIIMHIn21ZjkEqHpaaWH5FqnDY13SLapUCKd
 AlhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb23MOZfMfoS2deypLYT4LtuRR35oO0X0F86fQCD/9+TrODvgktMEvmEK8qVxAxjaTOwfKFc3LzaF7isLU8Pxg36GC8Q==
X-Gm-Message-State: AOJu0YwFETBpuNiWVsK9exiHkiXrSm0OKaiggt60HNBnTLw5AgBxAQsG
 CJMkGR5+gfhCn6UBH1gm6pgW/mgd2CtKA/3PgLFkLIzQaWYBGjOKVMxHZPY/He0=
X-Google-Smtp-Source: AGHT+IHb+SPDqt8yM/Hvg5v4XMTla46o5Zn4nBCALiAh6inSeDeHCkrS7io2tsF6rQtXTXMijk1ocA==
X-Received: by 2002:a17:907:72c2:b0:a69:13a2:4f6e with SMTP id
 a640c23a62f3a-a7514512d6fmr695901866b.74.1719927050060; 
 Tue, 02 Jul 2024 06:30:50 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:45 +0200
Subject: [PATCH v4 05/10] sandbox: switch to dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-5-a00c82d1f504@linaro.org>
References: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
In-Reply-To: <20240702-b4-dynamic-uuid-v4-0-a00c82d1f504@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10572;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=zv4jofCF6+YseWsXVvbv52gSZxVgEi77F83BqYSOU5w=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAECUAtQUaSTnNUUiqbq5bda64aOPgXQSPruV
 cA3hfghDFKJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tsRuD/9iGS4PoM4u2gVkVyxr73suk2J5jxqx6ML+PAOI09x2myGVYSsAMW1UMOVswx70u78Okci
 QBSoEitoygX67ctCJEEfEeH+zwRHD5CJbBUDytM1ld532jtJlFVDdBmHRHqgSBwxBJhmNJMphD0
 5lCTkugZC9JwxXhcpc4eU8zULV1Nuwta5vzIxpQwb3H8550HmW7pSloYhncHE5IaGr/pkGzUOjP
 bubivG8KcN1pzr34dJQVHsJzmSWY74XUBZQsAgmTD1C/aSzB046ubQNW+vuoMKqrhz8Bm/NrYk2
 ijyFU4l6BhudFTCEwEhSgDBUYUbdpwNFnt8UxTtLET4+R/3juMBAk7xlByFXGuhJ0mTmgY3uOZ2
 aNid9oB6lQLYDEXOrrHhv5oyOloIvR8Elb8nH7s/jJ42Jl5sI9bMf01OFD9Qq35Diu2ieeZf8n1
 3GWqrLaLxV8RzMTE5NhiXXz0jYLPYflcGlfLJB9nuDS0ybyFCxOqdvc61H0UhbdXyyn4EieAwbl
 IIDovi5M0rZtYBY8atWBfoe6c3UOta0hyxxU8WzCOv/6O92ZSBE07fqgkL95pTGudJt68x+6U6E
 4D+b6jT5EyB1heGlfcVnGdSZNkXic3DX1TxFquNaxv5NfOElZvoramFrGBR4HmoeyFCI1OGluIl
 3dyat55R4GsZl+Q==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Migrate sandbox over to generating it's capsule update image GUIDs
dynamically from the namespace and board/image info. Update the
reference and tests to use the new GUIDs.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/sandbox/sandbox.c                                  | 16 ----------------
 include/sandbox_efi_capsule.h                            |  6 +++---
 .../tests/test_efi_capsule/test_capsule_firmware_fit.py  |  2 +-
 .../tests/test_efi_capsule/test_capsule_firmware_raw.py  |  8 ++++----
 .../test_efi_capsule/test_capsule_firmware_signed_fit.py |  2 +-
 .../test_efi_capsule/test_capsule_firmware_signed_raw.py |  4 ++--
 test/py/tests/test_efi_capsule/version.dts               |  6 +++---
 tools/binman/etype/efi_capsule.py                        |  2 +-
 tools/binman/ftest.py                                    |  2 +-
 9 files changed, 16 insertions(+), 32 deletions(-)

diff --git a/board/sandbox/sandbox.c b/board/sandbox/sandbox.c
index 802596569c64..d97945e58fcf 100644
--- a/board/sandbox/sandbox.c
+++ b/board/sandbox/sandbox.c
@@ -31,36 +31,20 @@
  */
 gd_t *gd;
 
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
-/* GUIDs for capsule updatable firmware images */
-#define SANDBOX_UBOOT_IMAGE_GUID \
-	EFI_GUID(0x09d7cf52, 0x0720, 0x4710, 0x91, 0xd1, \
-		 0x08, 0x46, 0x9b, 0x7f, 0xe9, 0xc8)
-
-#define SANDBOX_UBOOT_ENV_IMAGE_GUID \
-	EFI_GUID(0x5a7021f5, 0xfef2, 0x48b4, 0xaa, 0xba, \
-		 0x83, 0x2e, 0x77, 0x74, 0x18, 0xc0)
-
-#define SANDBOX_FIT_IMAGE_GUID \
-	EFI_GUID(0x3673b45d, 0x6a7c, 0x46f3, 0x9e, 0x60, \
-		 0xad, 0xab, 0xb0, 0x3f, 0x79, 0x37)
-
 struct efi_fw_image fw_images[] = {
 #if defined(CONFIG_EFI_CAPSULE_FIRMWARE_RAW)
 	{
-		.image_type_id = SANDBOX_UBOOT_IMAGE_GUID,
 		.fw_name = u"SANDBOX-UBOOT",
 		.image_index = 1,
 	},
 	{
-		.image_type_id = SANDBOX_UBOOT_ENV_IMAGE_GUID,
 		.fw_name = u"SANDBOX-UBOOT-ENV",
 		.image_index = 2,
 	},
 #elif defined(CONFIG_EFI_CAPSULE_FIRMWARE_FIT)
 	{
-		.image_type_id = SANDBOX_FIT_IMAGE_GUID,
 		.fw_name = u"SANDBOX-FIT",
 		.image_index = 1,
 	},
 #endif
diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
index 3e288e8a84a2..84d45ec5cfd5 100644
--- a/include/sandbox_efi_capsule.h
+++ b/include/sandbox_efi_capsule.h
@@ -5,11 +5,11 @@
 
 #if !defined(_SANDBOX_EFI_CAPSULE_H_)
 #define _SANDBOX_EFI_CAPSULE_H_
 
-#define SANDBOX_UBOOT_IMAGE_GUID	"09d7cf52-0720-4710-91d1-08469b7fe9c8"
-#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"5a7021f5-fef2-48b4-aaba-832e777418c0"
-#define SANDBOX_FIT_IMAGE_GUID		"3673b45d-6a7c-46f3-9e60-adabb03f7937"
+#define SANDBOX_UBOOT_IMAGE_GUID	"985f2937-7c2e-5e9a-8a5e-8e063312964b"
+#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"9e339473-c2eb-530a-a69b-0cd6bbbed40e"
+#define SANDBOX_FIT_IMAGE_GUID		"46610520-469e-59dc-a8dd-c11832b877ea"
 #define SANDBOX_INCORRECT_GUID		"058b7d83-50d5-4c47-a195-60d86ad341c4"
 
 #define UBOOT_FIT_IMAGE			"u-boot_bin_env.itb"
 
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
index 11bcdc2bb293..a726c71c1138 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
@@ -146,9 +146,9 @@ class TestEfiCapsuleFirmwareFit():
                 verify_content(u_boot_console, '100000', 'u-boot:Old')
                 verify_content(u_boot_console, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-                assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
+                assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
                 assert 'ESRT: fw_version=5' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
                 verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index a5b5c8a3853a..ca51a279763f 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -133,12 +133,12 @@ class TestEfiCapsuleFirmwareRaw:
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+            assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+            assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
 
             check_file_removed(u_boot_console, disk_img, capsule_files)
 
             expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
@@ -187,14 +187,14 @@ class TestEfiCapsuleFirmwareRaw:
                 verify_content(u_boot_console, '100000', 'u-boot:Old')
                 verify_content(u_boot_console, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-                assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+                assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
                 assert 'ESRT: fw_version=5' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
                 # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-                assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+                assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
                 assert 'ESRT: fw_version=10' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
                 verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
index 44a58baa3106..debbce8bdbdf 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
@@ -156,9 +156,9 @@ class TestEfiCapsuleFirmwareSignedFit():
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
+            assert '46610520-469E-59DC-A8DD-C11832B877EA' in ''.join(output)
             assert 'ESRT: fw_version=5' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
             verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index 83a10e160b8c..439bd71b3a7d 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -150,14 +150,14 @@ class TestEfiCapsuleFirmwareSignedRaw():
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+            assert '985F2937-7C2E-5E9A-8A5E-8E063312964B' in ''.join(output)
             assert 'ESRT: fw_version=5' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
             # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+            assert '9E339473-C2EB-530A-A69B-0CD6BBBED40E' in ''.join(output)
             assert 'ESRT: fw_version=10' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
             verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dts
index 07850cc6064c..3aebb5b64fbd 100644
--- a/test/py/tests/test_efi_capsule/version.dts
+++ b/test/py/tests/test_efi_capsule/version.dts
@@ -7,18 +7,18 @@
 	firmware-version {
 		image1 {
 			lowest-supported-version = <3>;
 			image-index = <1>;
-			image-type-id = "09D7CF52-0720-4710-91D1-08469B7FE9C8";
+			image-type-id = "985F2937-7C2E-5E9A-8A5E-8E063312964B";
 		};
 		image2 {
 			lowest-supported-version = <7>;
 			image-index = <2>;
-			image-type-id = "5A7021F5-FEF2-48B4-AABA-832E777418C0";
+			image-type-id = "9E339473-C2EB-530A-A69B-0CD6BBBED40E";
 		};
 		image3 {
 			lowest-supported-version = <3>;
 			image-index = <1>;
-			image-type-id = "3673B45D-6A7C-46F3-9E60-ADABB03F7937";
+			image-type-id = "46610520-469E-59DC-A8DD-C11832B877EA";
 		};
 	};
 };
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e32037178221..0609760d7174 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -23,9 +23,9 @@ def get_binman_test_guid(type_str):
     Returns:
         The actual GUID value (str)
     """
     TYPE_TO_GUID = {
-        'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+        'binman-test' : '985f2937-7c2e-5e9a-8a5e-8e063312964b'
     }
 
     return TYPE_TO_GUID[type_str]
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b36..d12f1561b367 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -123,9 +123,9 @@ TEE_ADDR = 0x5678
 
 # Firmware Management Protocol(FMP) GUID
 FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
 # Image GUID specified in the DTS
-CAPSULE_IMAGE_GUID = '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+CAPSULE_IMAGE_GUID = '985F2937-7C2E-5E9A-8A5E-8E063312964B'
 # Windows cert GUID
 WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
 # Empty capsule GUIDs
 EMPTY_CAPSULE_ACCEPT_GUID = '0c996046-bcc0-4d04-85ec-e1fcedf1c6f8'

-- 
2.45.2

