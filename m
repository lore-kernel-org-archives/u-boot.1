Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4973FC3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB39188BD1;
	Fri, 19 Jul 2024 14:43:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZBFxNpjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B6A788BC4; Fri, 19 Jul 2024 14:43:55 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16961887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57cf8880f95so983791a12.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393032; x=1721997832; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=slrydBxT451ee2noHD42WIxnJtB5G2V4lRIuOaWEQBY=;
 b=ZBFxNpjdYRdcHOIQUrsPcDpqJd5zjYMzPJftUws4LCHnQuoMyx8Y3VktiV2JQzT8R1
 BKtY+Wh8IgrI2C1jwrshRVkvGZ1HvM22zbQH2dh45Jrj71jIIBZ13aol9ST+oKTJJKxY
 TJgCAHn5i8OsSPySRfb+6HWtnM+ZBJQ4GQmn5a56jdBvy4RlZ4K2JedFuqd0zTXCapZG
 kdWSiL85b+K5HjEZ8teXbSFc29XJ3lYlGu6/SYdRkaHpU6YUS9UXWMJJmo/KkVLJG9TU
 dPXhgWUbLaoMF5B7fG3T2z9nQf8SZ1FmKLms5gapWB9pX6CVXACHhr6bH3dz6GIKMuCC
 HgXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393032; x=1721997832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=slrydBxT451ee2noHD42WIxnJtB5G2V4lRIuOaWEQBY=;
 b=J8lUZ9gbXqoben3/V5ZiV2OqCwh+6WVrO69EIemem4toSYM2XBB1riT6e5MriJCjNB
 VbqBx+HTl+wl77CDMsqbsF1jcq1p6GMw51zRwQH6YQR9SRBJ2IPG3VlkkCNWMMGtGMTs
 k6MZQwSmf7Hg9yAZceofxoh7ix+vsy0Wtu+Dx30Gbnh8nT+divRlBfU5zoLkDSw9X7XQ
 cgRA2csD4CSw6p1n3X3KBS1WydraAO8ZMg5rYsI1A05oz80fxnUizPZ/Xlk+VIcfKslf
 yscOw8QTuKr7BlshRBv3W26t5xkIaU2T/dhdBjXGZS1WM+F03NnKq0jWplY/QoEq48XP
 c/SQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVZyth17UsnvbYaBKnD0755SQ2YZ0aRWl+pYe+IVyfgujBM9p76B3VW2358cg44X0u5GNmtmgNPhHj0GJCj4fdm7JjCw==
X-Gm-Message-State: AOJu0YxsuyCWewikH4u46SNhieKSJUB+ygU8owXTw33TDkAcVme64jqw
 k0nnI/eBRW5ZoDQzFW0O4oapiPLFcaBhIYhJdUx7wsniDHX0ekHFTyuXGJzZjkI=
X-Google-Smtp-Source: AGHT+IHYt70+gA+XMvFtdL5D7ILa86uDcPKoa3PAKGsp3B4OEcdRo9yHQKRIuXxO95PREw1r0vcrFw==
X-Received: by 2002:a17:906:2c50:b0:a6f:58a6:fed8 with SMTP id
 a640c23a62f3a-a7a012f3bd6mr611013166b.28.1721393032399; 
 Fri, 19 Jul 2024 05:43:52 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:51 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:45 +0200
Subject: [PATCH v5 05/11] sandbox: switch to dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-5-8a83de3fe3dc@linaro.org>
References: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
In-Reply-To: <20240719-b4-dynamic-uuid-v5-0-8a83de3fe3dc@linaro.org>
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
 bh=hcfD1220PUFTgwyapeU1Eesp+6IpzsCEjNL61IBFVB0=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+AT50L821FTpVWm+5y3cskh7afuUqC23/vg
 uI6F6xR9MSJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 toD2EACmThzygO8gc8aEdWSckDzJDlqXPpo7pVHPHURsp9A1ukIB+Q0Fcmo1lHvtO2DsuZBfcg5
 0Ge1vuV6+YAV0/QJjcdHaDblL9cQpTItdV4PjdNZL7Vp4+t80232V/DnUmFfY/SLMexAGt+rC29
 a8j6KOoUwA+lmYPlhoPYlUVpY2TUgcj2RqAgH6SimcbauXZRAf/xvCdPKc3avwqhu2gH17uvSP4
 sSAQ5W1qsE9rQbzrS41uaMxuc6oIhLtNvofb6JVoTe01YnvGtfj13pJwPA7P7SyMjhM0wH9FuZS
 VrXy+XRb3A+OVJYyzR/2N6hJYj8nW3SAuw+DjDJk6rUxLzbq0sXX849dEvlku2ZSNtxumtZWBbo
 0lGjeKL8uHZ2EvR/rOLCZBoKIuZvWX/5538kpNc6iuxQNIQ2pA7BvRcMfUDLjmwSsYVPTHhuOFL
 h++7A1ewLBBBuXyiXIAtz93de9jSoJCTNhxdIR5J+tcPCMZziTb74DBSGgs3ahd0h5bmNFbiccs
 dsC0PrSvGc2rwHK2BYSArGWWVicRr9qszkO/KA0s806tb2G5bmwOv1tK1PW9f146QAwcV6DnjX/
 DAy2Fqmb7GoLDNXyPKZ689DAne1YekGfRYc7ue2YbfKlPEGvULcQy7/BvPrpXmJglWkSOlKWLgL
 6yww0bslleO53Zw==
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
index e4da04030a51..735413ddb0db 100644
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

