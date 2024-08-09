Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC3FDC52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:57:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E438D88C0F;
	Fri,  9 Aug 2024 02:56:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SjAOu8Tx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3F7088BD1; Fri,  9 Aug 2024 02:56:38 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D506788BB0
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso132936066b.0
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164996; x=1723769796; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R3fNXm5Eot2FvdfdyhfEXC5+miWVrUR26Z5LFqrrLag=;
 b=SjAOu8TxKgCpLsN2M1yRvCGgUbj1ajZ0K4JUT6Xr9PdPsyf22ysK/nICZLLe6c8CAi
 uQwXpJgEJ91KXquuh/Y4z8oIwyf/HwwSWakG6T4pd0VdgpjQNwQrCdV2WaWUs7jZG5z9
 YzgmagoNUAIjt2TZlaCaE7S1ciSM/tj5nQa88LeFylO7NCIFP3ra2XQmOSF8EeKMpagp
 6nvj8UokrW2qmRbM0Vb5N42BfIVk2ZdZwskRVwX1TsXObnNY8KD2vwSXaxSOmgIP27Jw
 P2hu/oVzRuJlPS0S34hk1g8i7RcvpmVqY7Aqo/iFG2zteX3hjOkt5FBeRkXE1ziYafqs
 6kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164996; x=1723769796;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R3fNXm5Eot2FvdfdyhfEXC5+miWVrUR26Z5LFqrrLag=;
 b=gMbA7UUxltZI8MiDl8MBLUim/44ic0Gl9WXLGIWiWFBxHp/89WE23NKTZhWZffWCxH
 rWNXNaXwfiQvu5dwkOos91/1/6jjJpKdDjrF/+YuMDd0KOqOTB89fT4Kfs8XgelXk3uw
 FCz6ouG5RN6znMXNCF5nang4HGUcy1rIXSuR8zQ1s2Y2k2ibXTwRQW0UCJU2Yle8PIto
 DGYhj03ZWzRowk704AsA3apkTGoBKFUhqa/owpPhvj8xSmAZbqrGTVY/j2G9/atK8a5k
 V0JSpnySDvgGYq/BezhFdlId64/GRKRdv+Fr9SDyo5HgzXcC85rSziLCFCuB8WzbkiBs
 mq8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMSd4TlMyiF90rQtVU528JCw4Jn2Lj2keIV4M8mmW/aWxaCVtQzcYYvR/aSNZE4X8lI3slA3tpitS8dYGQeR39CF/heQ==
X-Gm-Message-State: AOJu0YwHFHatr6mK3NmlvcGmJbMO4rQw+CF+6tKxLAEuBqCfwwgkD6D1
 FasSKb+LHVZkJWEJy8DClI7HAF8SXl1gZ3TJmYzlbgVnWp++ReFyFvucJ3OJQF0=
X-Google-Smtp-Source: AGHT+IFMCtMWtklJITXcJeisIbmIkd2rgLZe25zkRjMNGHKEwh8c8aeeYiHAa1Ae8+aUTJwiqd3X3A==
X-Received: by 2002:a17:907:96a9:b0:a77:f2c5:84bf with SMTP id
 a640c23a62f3a-a80aa54fb30mr958066b.2.1723164996199; 
 Thu, 08 Aug 2024 17:56:36 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:35 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:24 +0200
Subject: [PATCH v7 05/11] sandbox: switch to dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-5-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=10634;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=kvFOlfiiZPFPkMLijvRkNhuNuQX3WZhbH8J41MieVjc=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8IenX9hZf8/62rNnNPBXamDpBLqZhBqVyK
 /M6LqXc8bWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tgXJD/9faAmcgOsjJhVzLvKdZTSMXTVKuOklAV08t/DOJEfgxlWMOnA+IVZzcNGYSe5wPJ9fb8E
 UiPCCRxAuabKJ577ApjuB64y2c8sb7aoMR8jP0uejAkEpRJ74BaF/V88oCe+ZFbkjH66ZwivW6s
 KzKNHRDyPU6C1gasLiFs/lz4R0vmlFStFlbJAaEQwIGuwZTFh6NKpnOuqj+mmsulTujwdpzo9n3
 U4ZDGSx9NVtFfcGTLK8nbzavBFpWQPP93Qxuc/Bpi6Nh42a6XqphBj4ay6FfT7glAYQxxNNxSsF
 VFZYpiagqHqi9cp0pnqs68zxm010ZWF1exHWjvRhjdKoIct9FMY+Dzdsluic5xFEoxZiMt0gKfS
 Wi5ogUIvN/tjOWyt7b7PqrBtOBQABzhabq4YAMAXm6EpsogHoatlwr8CWkB7cmHYp335co0K45E
 wKD1zkcA1P6R6jmXQ9BmOrQNsg7eZTuvdsytdIdyfBnIdRUGgXydOrTR0MRdzUhPKHVPfmhH01Z
 RGHCl8DE/u+heZ0lxkXV7ZKiN5aaccJwrMSoM3DFePpcOTPn2ZzXHA8iyFDUiZgOPQzTh/CdG/2
 vIIJnSIFHQrcCEPq18vV/8w1gG6suIPSXa0shYHNmlPicgMTs18zLwNDtzPZYdxLSXGXMyaT3qh
 rd8E3zuA6nzFcrA==
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

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/sandbox/sandbox.c                                  | 16 ----------------
 include/sandbox_efi_capsule.h                            |  6 +++---
 .../tests/test_efi_capsule/test_capsule_firmware_fit.py  |  2 +-
 .../tests/test_efi_capsule/test_capsule_firmware_raw.py  |  8 ++++----
 .../test_efi_capsule/test_capsule_firmware_signed_fit.py |  2 +-
 .../test_efi_capsule/test_capsule_firmware_signed_raw.py |  4 ++--
 test/py/tests/test_efi_capsule/version.dtso              |  6 +++---
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
index f3a2dff5c2c8..8a790405c7c4 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -144,12 +144,12 @@ class TestEfiCapsuleFirmwareRaw:
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
@@ -198,14 +198,14 @@ class TestEfiCapsuleFirmwareRaw:
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
diff --git a/test/py/tests/test_efi_capsule/version.dtso b/test/py/tests/test_efi_capsule/version.dtso
index 07850cc6064c..3aebb5b64fbd 100644
--- a/test/py/tests/test_efi_capsule/version.dtso
+++ b/test/py/tests/test_efi_capsule/version.dtso
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
index 751f654bf310..7ed016432074 100644
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
index 93f3d22cf573..2577c0016c0c 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -124,9 +124,9 @@ TEE_ADDR = 0x5678
 
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
2.46.0

