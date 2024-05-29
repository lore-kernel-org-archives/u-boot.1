Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E30BC27C43
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73FBF88619;
	Wed, 29 May 2024 16:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Yr3qypCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6346D88619; Wed, 29 May 2024 16:49:07 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 064EF88623
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-529b4011070so2624744e87.1
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994144; x=1717598944; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DiS6tkUpaxndkmQtKOrLUpeZedTPdW0/QJrv/eROMxw=;
 b=Yr3qypCdIUPd1m/IuAGiSzgtllOri1iZ9ELBLVFzc0E3/K8IBJ71Qhh+gCDCcRP1Oj
 LCUGc00XooSTUvWboHi9z/IvKG8eShlNvE6SqZL9ta3f1TWPZ0wC+UTDFuNQ3H/meBkn
 MvzaPv3RxESJHd8rSZ57rk7KZtLAZ0/YM2jzZkm3FkxSAwhban1xCz+gNwyTMv0Hv/bf
 CDRUAmhhFZjORFlimIYIjMEHI8WOsT/y86uJwT1VjaQYPErHMegKAaYDCyaYaJ0QOGWo
 w7jJkMI+2BYWJgqOyxNy3Q5tM74jTMChG7jVpIjYkYLT5Dg3I1U82esQSimsRvf/aPsd
 dVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994144; x=1717598944;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DiS6tkUpaxndkmQtKOrLUpeZedTPdW0/QJrv/eROMxw=;
 b=YT7pasMDI+E6QW3X2jxYjSqeuTsJP7311sKuR6mwf+MS34jr6szPUXCe6SQPpbQ9RI
 7dqEg5Aj0n6UYYioX3uHTJplQqV4VCG6AL8HlDeA6JfekCg93njsnh3pR6Mg2fs0Gpga
 75t4WCvGIH3EMgUJIy7t2e9FTEKn1Ubfvj4GSzLRehvAzhXFy0COJZx8Ko3sGKES/W3U
 gmMYB2V8uAagshcEUGeqVsQ6SzGo0aUUVxuyVpmMWL4zR3kzNdYng1kRselC+0NBzemf
 DbxsVPemdshNQ9dtSSw/e2fbuHV+vZPL3b4GfbyWx0L0T9LrMge0/zC6f/XZCNCThbJN
 5HwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSZf/0ZrwchJ5bpj5hi6VAv8F6BFDYPbqY9VTxu1wGWjRWMkbXDvpg95uOosJlD9I8D8rx258zjYINmYKHzfHXShbWWQ==
X-Gm-Message-State: AOJu0YzaaqaOU1c356guIO22ifoySaNeRzVo5jNHbqcX9dsU2zUSo9Z0
 oxnzDZZLFmp8XeLTIT9Kt7ZuR28UEnyov22cbR4vZXpFY5BN9tln+WwPiP/Ggvw=
X-Google-Smtp-Source: AGHT+IGyxqs/3NynEA4KyOweJimi6jo83v0XV6OOg3eXeA8iVk6PqYPevANHLe2iOuUEdB/i+a4KYw==
X-Received: by 2002:a05:6512:3994:b0:522:2a2c:759e with SMTP id
 2adb3069b0e04-5296420479emr11207888e87.6.1716994144203; 
 Wed, 29 May 2024 07:49:04 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:03 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:53 +0200
Subject: [PATCH v2 4/7] sandbox: switch to dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-4-c26f31057bbe@linaro.org>
References: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
In-Reply-To: <20240529-b4-dynamic-uuid-v2-0-c26f31057bbe@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=12323;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ebvcIW8ENg3nKp4MgxtFbZceBlrQGRzQUXlv6yEpMtU=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0BaOF9IPnBV4Zghz/JzLJoa3zp5Kw8U0BC1u
 xOd4tr+fhGJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWgAKCRAFgzErGV9k
 ttDBD/9Do821MEwW/qOvK6R0YvMnMH/LBqUGIhSjJUa3mANBvl76d4fS/13WXUAH/b/s6dtDoY0
 AY4m8TjYgDuC43Q9cYAhakT1jiBW1SwAhPgydYFNq225ptN5lL+46t0TDbdZ6ma5j4mGOq8Jedq
 ZX5bFWTHWC6XOwBDzHY4l58FkpY2gJwBx8kcj+d2RqqwAH/m9WRGOjZtHchs9cF1+YchOU9fRbE
 1XXx8bTr6wpA3zbEojjZTe1SWwwm6vLLEaYCj8P4Wi22wGNaGYuxA2KfiSFVKmpbBrRpOoQCwXD
 xpNcuEF9AAqunBpAT7RdfeRqDCJ34VTEt8u4HMK9mdbZVvgeKZk8FJo/r8qNGkj8laobnEYkfG7
 mw6ovECNYgSUat+jGtka4twJYcfyAgnHWkJ8n2jBf9ULxEFLt12LoqKNhi8JWeWVCBjrQAvmLc2
 vNzL8QF1HliYvtsjHpmA5YrUwwgjMFL5ZGn6AY2Z3ckWM5LoGmZC1m6SV8XK3RE3zW9T0YjstcU
 gHzFTqOxe8AQSnXgm0vS8M4IYQZ+b1BKEMSp0DiTqJdnXLJaFXa+6Ny7fK/hTJ3gabIWDI1LR8v
 a05MW+URh1MhPHPTnOVG/o8EuZDVhAWsh5eQrzRQctHzyE27Laqf2Bw90s27IYHe0umLfs7VdL3
 XHFxgMj2Ldy6L9A==
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
 arch/Kconfig                                             |  1 +
 board/sandbox/sandbox.c                                  | 16 ----------------
 configs/sandbox_defconfig                                |  1 +
 configs/sandbox_flattree_defconfig                       |  1 +
 include/sandbox_efi_capsule.h                            |  6 +++---
 .../tests/test_efi_capsule/test_capsule_firmware_fit.py  |  2 +-
 .../tests/test_efi_capsule/test_capsule_firmware_raw.py  |  8 ++++----
 .../test_efi_capsule/test_capsule_firmware_signed_fit.py |  2 +-
 .../test_efi_capsule/test_capsule_firmware_signed_raw.py |  4 ++--
 test/py/tests/test_efi_capsule/version.dts               |  6 +++---
 tools/binman/etype/efi_capsule.py                        |  2 +-
 tools/binman/ftest.py                                    |  2 +-
 12 files changed, 19 insertions(+), 32 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index abd406d48841..0558c90540b6 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -164,8 +164,9 @@ config SANDBOX
 	select SYS_CACHE_SHIFT_4
 	select IRQ
 	select SUPPORT_EXTENSION_SCAN if CMDLINE
 	select SUPPORT_ACPI
+	select EFI_CAPSULE_DYNAMIC_UUIDS if EFI_HAVE_CAPSULE_SUPPORT
 	imply BITREVERSE
 	select BLOBLIST
 	imply LTO
 	imply CMD_DM
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
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 93b52f2de5cf..58775b271600 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -349,8 +349,9 @@ CONFIG_TPM=y
 CONFIG_ERRNO_STR=y
 CONFIG_GETOPT=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_NAMESPACE_UUID="09D7CF52-0720-4710-91D1-08469B7FE9C8"
 CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
 CONFIG_EFI_SECURE_BOOT=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 6bf8874e722e..85ae63da8881 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -224,8 +224,9 @@ CONFIG_TPM=y
 CONFIG_ZSTD=y
 CONFIG_ERRNO_STR=y
 CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
 CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_CAPSULE_NAMESPACE_UUID="09d7cf52-0720-4710-91d1-08469b7fe9c8"
 CONFIG_EFI_CAPSULE_FIRMWARE_FIT=y
 CONFIG_EFI_CAPSULE_AUTHENTICATE=y
 CONFIG_EFI_CAPSULE_ESL_FILE="board/sandbox/capsule_pub_esl_good.esl"
 CONFIG_UNIT_TEST=y
diff --git a/include/sandbox_efi_capsule.h b/include/sandbox_efi_capsule.h
index 3e288e8a84a2..25ac496ea24f 100644
--- a/include/sandbox_efi_capsule.h
+++ b/include/sandbox_efi_capsule.h
@@ -5,11 +5,11 @@
 
 #if !defined(_SANDBOX_EFI_CAPSULE_H_)
 #define _SANDBOX_EFI_CAPSULE_H_
 
-#define SANDBOX_UBOOT_IMAGE_GUID	"09d7cf52-0720-4710-91d1-08469b7fe9c8"
-#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"5a7021f5-fef2-48b4-aaba-832e777418c0"
-#define SANDBOX_FIT_IMAGE_GUID		"3673b45d-6a7c-46f3-9e60-adabb03f7937"
+#define SANDBOX_UBOOT_IMAGE_GUID	"fd5db83c-12f3-a46b-80a9-e3007c7ff56e"
+#define SANDBOX_UBOOT_ENV_IMAGE_GUID	"935fe837-fac8-4394-c008-737d8852c60d"
+#define SANDBOX_FIT_IMAGE_GUID		"ffd97379-0956-fa94-c003-8bfcf5cc097b"
 #define SANDBOX_INCORRECT_GUID		"058b7d83-50d5-4c47-a195-60d86ad341c4"
 
 #define UBOOT_FIT_IMAGE			"u-boot_bin_env.itb"
 
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
index 11bcdc2bb293..746da4602085 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_fit.py
@@ -146,9 +146,9 @@ class TestEfiCapsuleFirmwareFit():
                 verify_content(u_boot_console, '100000', 'u-boot:Old')
                 verify_content(u_boot_console, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-                assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
+                assert '5AF91295-5A99-F62B-80D7-E9574DE87170' in ''.join(output)
                 assert 'ESRT: fw_version=5' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
                 verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
index a5b5c8a3853a..1866b8086573 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_raw.py
@@ -133,12 +133,12 @@ class TestEfiCapsuleFirmwareRaw:
                 'env set dfu_alt_info "sf 0:0=u-boot-bin raw 0x100000 0x50000;u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+            assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
 
             check_file_removed(u_boot_console, disk_img, capsule_files)
 
             expected = 'u-boot:Old' if capsule_auth else 'u-boot:New'
@@ -187,14 +187,14 @@ class TestEfiCapsuleFirmwareRaw:
                 verify_content(u_boot_console, '100000', 'u-boot:Old')
                 verify_content(u_boot_console, '150000', 'u-boot-env:Old')
             else:
                 # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-                assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+                assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
                 assert 'ESRT: fw_version=5' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
                 # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-                assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+                assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
                 assert 'ESRT: fw_version=10' in ''.join(output)
                 assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
                 verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
index 44a58baa3106..a4e0a3bc73f5 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_fit.py
@@ -156,9 +156,9 @@ class TestEfiCapsuleFirmwareSignedFit():
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '3673B45D-6A7C-46F3-9E60-ADABB03F7937' in ''.join(output)
+            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
             assert 'ESRT: fw_version=5' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
             verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
index 83a10e160b8c..260c71860632 100644
--- a/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
+++ b/test/py/tests/test_efi_capsule/test_capsule_firmware_signed_raw.py
@@ -150,14 +150,14 @@ class TestEfiCapsuleFirmwareSignedRaw():
                 'u-boot-env raw 0x150000 0x200000"',
                 'efidebug capsule esrt'])
 
             # ensure that SANDBOX_UBOOT_IMAGE_GUID is in the ESRT.
-            assert '09D7CF52-0720-4710-91D1-08469B7FE9C8' in ''.join(output)
+            assert 'FD5DB83C-12F3-A46B-80A9-E3007C7FF56E' in ''.join(output)
             assert 'ESRT: fw_version=5' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=3' in ''.join(output)
 
             # ensure that SANDBOX_UBOOT_ENV_IMAGE_GUID is in the ESRT.
-            assert '5A7021F5-FEF2-48B4-AABA-832E777418C0' in ''.join(output)
+            assert '935FE837-FAC8-4394-C008-737D8852C60D' in ''.join(output)
             assert 'ESRT: fw_version=10' in ''.join(output)
             assert 'ESRT: lowest_supported_fw_version=7' in ''.join(output)
 
             verify_content(u_boot_console, '100000', 'u-boot:New')
diff --git a/test/py/tests/test_efi_capsule/version.dts b/test/py/tests/test_efi_capsule/version.dts
index 07850cc6064c..3f0698bf7280 100644
--- a/test/py/tests/test_efi_capsule/version.dts
+++ b/test/py/tests/test_efi_capsule/version.dts
@@ -7,18 +7,18 @@
 	firmware-version {
 		image1 {
 			lowest-supported-version = <3>;
 			image-index = <1>;
-			image-type-id = "09D7CF52-0720-4710-91D1-08469B7FE9C8";
+			image-type-id = "FD5DB83C-12F3-A46B-80A9-E3007C7FF56E";
 		};
 		image2 {
 			lowest-supported-version = <7>;
 			image-index = <2>;
-			image-type-id = "5A7021F5-FEF2-48B4-AABA-832E777418C0";
+			image-type-id = "935FE837-FAC8-4394-C008-737D8852C60D";
 		};
 		image3 {
 			lowest-supported-version = <3>;
 			image-index = <1>;
-			image-type-id = "3673B45D-6A7C-46F3-9E60-ADABB03F7937";
+			image-type-id = "FFD97379-0956-FA94-C003-8BFCF5CC097B";
 		};
 	};
 };
diff --git a/tools/binman/etype/efi_capsule.py b/tools/binman/etype/efi_capsule.py
index e32037178221..da1f9b0a381a 100644
--- a/tools/binman/etype/efi_capsule.py
+++ b/tools/binman/etype/efi_capsule.py
@@ -23,9 +23,9 @@ def get_binman_test_guid(type_str):
     Returns:
         The actual GUID value (str)
     """
     TYPE_TO_GUID = {
-        'binman-test' : '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+        'binman-test' : 'fd5db83c-12f3-a46b-80a9-e3007c7ff56e'
     }
 
     return TYPE_TO_GUID[type_str]
 
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index 8a44bc051b36..dc602b95ecd5 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -123,9 +123,9 @@ TEE_ADDR = 0x5678
 
 # Firmware Management Protocol(FMP) GUID
 FW_MGMT_GUID = '6dcbd5ed-e82d-4c44-bda1-7194199ad92a'
 # Image GUID specified in the DTS
-CAPSULE_IMAGE_GUID = '09d7cf52-0720-4710-91d1-08469b7fe9c8'
+CAPSULE_IMAGE_GUID = 'fd5db83c-12f3-a46b-80a9-e3007c7ff56e'
 # Windows cert GUID
 WIN_CERT_TYPE_EFI_GUID = '4aafd29d-68df-49ee-8aa9-347d375665a7'
 # Empty capsule GUIDs
 EMPTY_CAPSULE_ACCEPT_GUID = '0c996046-bcc0-4d04-85ec-e1fcedf1c6f8'

-- 
2.45.0

