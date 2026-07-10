Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0902EC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:11:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D5084ABE;
	Fri, 10 Jul 2026 20:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="CnKWgXyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B0084AE6; Fri, 10 Jul 2026 15:24:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD0C784ADB
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=imullins@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783689859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bw5V0JW59Csvg+wkpF2D09yzgt4aryxltKkfc+Km7UA=;
 b=CnKWgXyNV8Q5B2lZxJHXd/gNmxARHKNPZ4377Cm719HwUoUZIZwemYteXEn+f3Bvx5cdoA
 aQVFLDP0fVhUKBLSwuqiDsnrHUQp5u+CqXxgq4orCwQG5lQOHsJz6x7XsmCHfqg/XCTRGX
 6ag+ZgvShRpD9S++e2qPRLAyLz6Cuus=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-av5LzrdZPMOqPGOFku09NA-1; Fri, 10 Jul 2026 09:24:18 -0400
X-MC-Unique: av5LzrdZPMOqPGOFku09NA-1
X-Mimecast-MFC-AGG-ID: av5LzrdZPMOqPGOFku09NA_1783689857
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-476d52b13d7so967320f8f.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:24:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689857; x=1784294657;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bw5V0JW59Csvg+wkpF2D09yzgt4aryxltKkfc+Km7UA=;
 b=LWkpgIMwyi8dJg9WoC4rSQ/GVrtX3bh/dkODN1eMAj5KVFBRnw1oXlzcM6PeN63Q6U
 5pl+yGFAni5Zg82DtSwia1YWJJGfi/NuniRiIINJIR/RHBNylGVaYa/ixptUNjCnagD4
 91TCsb4lRcCkSRkBHkod+Rwgw2HxPdTW+TiOLCSTXtw7ikrOjOox6jhxh2XhNzjJ8GKK
 hYJc0qpXIJLhCdxamyPiRJEX433eHPef4DawfmIHC4HiHb2lEWMrblRU1/BTCeuNY/DR
 5L5HDtdTs+3+N0ufyzjKgJ/1dNnzhRLUZ4W4GmIyAt3p9wry61NxFFV0LCw6W8ZfIb9G
 zQdA==
X-Gm-Message-State: AOJu0YxujgziFL/bRnIBM1EjSPNvwenSsVCd+p/bXnwjKs+UvICvT/Vj
 /f+jb++T2cMAhKQMSPMWLY58zkxXi5IDA4ANpM8o/7fSSHKz7QflTJ0/K59l8nO+W1BTAm8uzVn
 JElCSuiduvo9Xs1Os8cCoQgNO30CEDPsa36dvWVhfUN8mJXxJkfKMveo=
X-Gm-Gg: AfdE7clwc7jR3wxiZqbSkDOaJXm6Mfm06yh8hYA4fOUD9PeHCuQ6oMmxo0ViRp1UUgj
 jNuIMId31m37MuYZkRNovD5/IsUylwuDFOVkDQFEX9lMn2NfZmQbIgtLVtG8coU4PNqLZzawnXK
 WPll9SuHzT4+9M0P0jrDxp8jsyoXsDBBWQDTFJ3T85/KKdhvItu6KXlBUz9PoLPa74W2ud4K1tm
 p+sHnUGPEZlQxZCcpKpGsRdno9oXN6sPA693JIT+nyL7UXRZ5taycQK8MEGcGwrZNMdFG9WNFcT
 SgpbyFqGG0buUmyK4cZ6+rJsHNoP8K7BYLWI1Ki+Q5ORvfDy58fJEesIpwP3hq0CemCJkvzD6Bw
 Kx7GtI/S7bjZ0XobwEm19EzyhIprCpzA6jAAxK5aR8g==
X-Received: by 2002:a05:600c:c4a4:b0:493:f2dc:fc4e with SMTP id
 5b1f17b1804b1-493f2ea3c86mr36456125e9.17.1783689856850; 
 Fri, 10 Jul 2026 06:24:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a4:b0:493:f2dc:fc4e with SMTP id
 5b1f17b1804b1-493f2ea3c86mr36455595e9.17.1783689856294; 
 Fri, 10 Jul 2026 06:24:16 -0700 (PDT)
Received: from [192.168.68.133] (33b7f9ad.skybroadband.com. [51.183.249.173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e77c2esm41527715e9.2.2026.07.10.06.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:24:16 -0700 (PDT)
From: Ian Mullins <imullins@redhat.com>
Date: Fri, 10 Jul 2026 14:23:09 +0100
Subject: [PATCH 2/2] efi_selftest: add tests for security architecture
 protocols
MIME-Version: 1.0
Message-Id: <20260710-efi_security_protocol-v1-2-a06cef90057b@redhat.com>
References: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
In-Reply-To: <20260710-efi_security_protocol-v1-0-a06cef90057b@redhat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ian Mullins <imullins@redhat.com>, 
 Enric Balletbo i Serra <eballetbo@kernel.org>, 
 Enric Balletbo Serra <eballetb@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>, Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Shantur Rathore <i@shantur.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Udit Kumar <u-kumar1@ti.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=16479; i=imullins@redhat.com; 
 h=from:subject:message-id;
 bh=1BybdwAR1LrUx/iAtgbvxFK/MU0yn3feGFnjzWlV4eY=; 
 b=owEBbQKS/ZANAwAKAdSOKmyUBwJWAcsmYgBqUPJ7Mwr6s3myGpCpt53N87kjXe6pmSSf0O7Wm
 jgOIaCh31WJAjMEAAEKAB0WIQTdLPzJ05Wjhy4Uwd3UjipslAcCVgUCalDyewAKCRDUjipslAcC
 Vj9uD/9b60fySR4P44qdJI5RpRMCSp3uqUNGXvmnvfxnXbIG0tZR1kDq44y+s7yCXBQInBNmage
 QFqSw+0Yf3OXrR4nzgqW6RYj1uCEuOhCDP3KSWeK3Oa3AS6expMktiUC1EfoGxA2n2eBBuOPU/Q
 9EIiVIyWJ49cTQuWYwD4iKrwNauoH5SXWTswY7OKxANtmSCkV7+dGZ6fqxeivW6YFlKGVczYlyy
 tASv2/hOe4piHjely+Cbome5Q19KdPWeLh7zFfkPh3ld4NAvqJ+X9Mi584WaNaUKeqnR6zWoz6c
 UOc6rh8teB6tU3xCcVeNIVzXbtm7tm6+WUMGasXoMftMwDn3U4BQR7RRS53VLwlLMlO69oCv/ZU
 AGvQJ++yKIrJrX8OQyitNtZMsHpPoo0wu4TeQEOyCyh7R9wt0FfMNrV80XiCYrYnBOcPyfQCfyc
 6sNrxdeedM7z/ZuCNxgkjNCvVZjir3B2Kf06NdcH2m3lmKu1uX/y47LB2yRxIzG2eP6MTyRJ+Yk
 /TzCGJ/Qsxoe/cZWWOYStgzgCbChdBgIdcO5pHEPcCm1skKAga8IZBG1kOI2UhIfG7ifaKf5xG5
 ngZzQurHXb4QkADLWCMX+SiWEWrSboYYYo1BXhazDgD2KupoOUot76mCxJiniLyLDpOiy1fwEsk
 GTBoprz46iHhYfA==
X-Developer-Key: i=imullins@redhat.com; a=openpgp;
 fpr=DD2CFCC9D395A3872E14C1DDD48E2A6C94070256
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TjYCfY0rRExTWL6cO-nUJyPWLvKsQlYstBA2UzVdGvQ_1783689857
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 10 Jul 2026 20:11:14 +0200
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

From: Enric Balletbo i Serra <eballetbo@kernel.org>

Add unit tests and Python integration tests for the
EFI_SECURITY_ARCH_PROTOCOL and EFI_SECURITY2_ARCH_PROTOCOL
implementation.

The C-based unit test verifies:
- Protocols are correctly installed on the root handle.
- The FileAuthentication override mechanism works, which is required for
  tools like systemd-stub to bypass secure boot for embedded
  UKI payloads.

The Python tests verify:
- Protocols are discoverable via 'efidebug dh'.
- Functional regression: Signed images still authenticate and boot
  correctly.
- Functional regression: Unsigned images are still rejected under
  Secure Boot.

Additionally, add a README with step-by-step instructions for manual
end-to-end testing using a real Unified Kernel Image (UKI) and QEMU.

Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
Signed-off-by: Ian Mullins <imullins@redhat.com>
---
 lib/efi_selftest/Makefile                          |   1 +
 lib/efi_selftest/efi_selftest_security_arch.c      | 110 +++++++++++
 .../py/tests/test_efi_secboot/README.security_arch | 208 +++++++++++++++++++++
 .../tests/test_efi_secboot/test_security_arch.py   |  73 ++++++++
 4 files changed, 392 insertions(+)

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 67102648703..06de55c6f4f 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -65,6 +65,7 @@ obj-y += efi_selftest_unaligned.o
 endif
 obj-$(CONFIG_EFI_LOADER_HII) += efi_selftest_hii.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_selftest_rng.o
+obj-$(CONFIG_EFI_SECURITY_ARCH_PROTOCOL) += efi_selftest_security_arch.o
 obj-$(CONFIG_EFI_GET_TIME) += efi_selftest_rtc.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_selftest_tcg2.o
 
diff --git a/lib/efi_selftest/efi_selftest_security_arch.c b/lib/efi_selftest/efi_selftest_security_arch.c
new file mode 100644
index 00000000000..384146a187a
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_security_arch.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * efi_selftest_security_arch
+ *
+ * Test the EFI Security Architecture Protocols.
+ *
+ * Verifies that EFI_SECURITY_ARCH_PROTOCOL and EFI_SECURITY2_ARCH_PROTOCOL
+ * can be located, and that the override mechanism works -- this is the same
+ * pattern used by systemd-stub to temporarily bypass secure boot for
+ * embedded UKI payloads.
+ */
+
+#include <efi_selftest.h>
+
+static struct efi_boot_services *boottime;
+
+static efi_guid_t security_guid = EFI_SECURITY_ARCH_PROTOCOL_GUID;
+static efi_guid_t security2_guid = EFI_SECURITY2_ARCH_PROTOCOL_GUID;
+
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	return EFI_ST_SUCCESS;
+}
+
+/*
+ * Custom Security2 hook that always succeeds -- mimics what systemd-stub
+ * installs for its embedded kernel payload.
+ */
+static efi_status_t EFIAPI
+permissive_file_authentication(const struct efi_security2_arch_protocol *this,
+			       const struct efi_device_path *device_path,
+			       void *file_buffer, efi_uintn_t file_size,
+			       bool boot_policy)
+{
+	return EFI_SUCCESS;
+}
+
+static int execute(void)
+{
+	struct efi_security_arch_protocol *security = NULL;
+	struct efi_security2_arch_protocol *security2 = NULL;
+	efi_security2_file_authentication original_hook;
+	efi_status_t ret;
+
+	/* Locate Security Architecture Protocol */
+	ret = boottime->locate_protocol(&security_guid, NULL,
+					(void **)&security);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Could not locate EFI_SECURITY_ARCH_PROTOCOL\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (!security->file_authentication_state) {
+		efi_st_error("FileAuthenticationState callback is NULL\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Locate Security2 Architecture Protocol */
+	ret = boottime->locate_protocol(&security2_guid, NULL,
+					(void **)&security2);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Could not locate EFI_SECURITY2_ARCH_PROTOCOL\n");
+		return EFI_ST_FAILURE;
+	}
+
+	if (!security2->file_authentication) {
+		efi_st_error("FileAuthentication callback is NULL\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/*
+	 * Test override mechanism: save original, install permissive hook,
+	 * verify it was installed, then restore original.
+	 */
+	original_hook = security2->file_authentication;
+
+	security2->file_authentication = permissive_file_authentication;
+
+	if (security2->file_authentication != permissive_file_authentication) {
+		efi_st_error("Failed to override FileAuthentication\n");
+		return EFI_ST_FAILURE;
+	}
+
+	/* Call the overridden hook directly to verify it works */
+	ret = security2->file_authentication(security2, NULL, NULL, 0, false);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("Permissive hook did not return EFI_SUCCESS\n");
+		security2->file_authentication = original_hook;
+		return EFI_ST_FAILURE;
+	}
+
+	/* Restore original handler */
+	security2->file_authentication = original_hook;
+
+	if (security2->file_authentication != original_hook) {
+		efi_st_error("Failed to restore FileAuthentication\n");
+		return EFI_ST_FAILURE;
+	}
+
+	return EFI_ST_SUCCESS;
+}
+
+EFI_UNIT_TEST(security_arch) = {
+	.name = "security architecture protocols",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};
diff --git a/test/py/tests/test_efi_secboot/README.security_arch b/test/py/tests/test_efi_secboot/README.security_arch
new file mode 100644
index 00000000000..d1792703c26
--- /dev/null
+++ b/test/py/tests/test_efi_secboot/README.security_arch
@@ -0,0 +1,208 @@
+QEMU Integration Test: EFI Security Architecture Protocols with UKI
+====================================================================
+
+This describes how to manually test the EFI_SECURITY_ARCH_PROTOCOL and
+EFI_SECURITY2_ARCH_PROTOCOL implementation end-to-end with a real Unified
+Kernel Image (UKI) on QEMU.
+
+IMPORTANT: Both U-Boot and the UKI must be built for the same architecture.
+If your UKI is x86_64, you must use qemu-x86_64. If your UKI is aarch64,
+you must use qemu_arm64. A mismatch causes:
+  "Machine type 0x8664 is not supported"
+
+Prerequisites
+-------------
+- qemu-system-x86_64 (or qemu-system-aarch64 for arm64)
+- systemd-ukify (for creating UKIs)
+- sbsign (for signing PE binaries)
+- efitools (cert-to-efi-sig-list, sign-efi-sig-list)
+- mtools (mcopy, mmd -- for populating FAT images without root)
+- openssl
+
+Overview
+--------
+The test works by packing everything into a single FAT disk image (esp.img):
+
+  esp.img  (FAT, passed to QEMU as a virtio disk)
+  ├── PK.auth          Secure Boot Platform Key
+  ├── KEK.auth         Key Exchange Key
+  ├── db.auth          Authorized Signature Database
+  └── EFI/
+      └── BOOT/
+          └── BOOTX64.EFI   The signed UKI (contains systemd-stub + kernel + initrd)
+
+U-Boot sees this as "virtio 0:1". First you enroll the keys from the root
+of the FAT, then you boot the UKI from EFI/BOOT/.
+
+Step 1: Build U-Boot
+---------------------
+
+  For x86_64:
+
+    make qemu-x86_64_defconfig
+    scripts/config --enable FIT_SIGNATURE
+    scripts/config --enable EFI_SECURE_BOOT
+    scripts/config --enable EFI_SECURITY_ARCH_PROTOCOL
+    make olddefconfig
+    make -j$(nproc)
+
+    Output: u-boot.rom
+
+  For aarch64:
+
+    make qemu_arm64_defconfig
+    scripts/config --enable FIT_SIGNATURE
+    scripts/config --enable EFI_SECURE_BOOT
+    scripts/config --enable EFI_SECURITY_ARCH_PROTOCOL
+    make olddefconfig
+    make -j$(nproc)
+
+    Output: u-boot.bin
+
+Step 2: Create Secure Boot Keys
+---------------------------------
+  GUID='11111111-2222-3333-4444-123456789abc'
+  mkdir -p keys && cd keys
+
+  # Platform Key
+  openssl req -x509 -sha256 -newkey rsa:2048 \
+    -subj /CN=Test_PK/ -keyout PK.key -out PK.crt -nodes -days 365
+  cert-to-efi-sig-list -g $GUID PK.crt PK.esl
+  sign-efi-sig-list -t "2024-01-01" -c PK.crt -k PK.key PK PK.esl PK.auth
+
+  # Key Exchange Key
+  openssl req -x509 -sha256 -newkey rsa:2048 \
+    -subj /CN=Test_KEK/ -keyout KEK.key -out KEK.crt -nodes -days 365
+  cert-to-efi-sig-list -g $GUID KEK.crt KEK.esl
+  sign-efi-sig-list -t "2024-01-01" -c PK.crt -k PK.key KEK KEK.esl KEK.auth
+
+  # Authorized Signature Database
+  openssl req -x509 -sha256 -newkey rsa:2048 \
+    -subj /CN=Test_db/ -keyout db.key -out db.crt -nodes -days 365
+  cert-to-efi-sig-list -g $GUID db.crt db.esl
+  sign-efi-sig-list -t "2024-01-01" -c KEK.crt -k KEK.key db db.esl db.auth
+
+  cd ..
+
+Step 3: Create and Sign a UKI
+-------------------------------
+  # Get a kernel and initrd matching your target architecture.
+  # Tip: use a small initrd for initial testing to avoid memory issues.
+
+  For x86_64:
+
+    ukify build \
+      --linux /boot/vmlinuz \
+      --initrd /boot/initrd.img \
+      --cmdline "console=ttyS0 root=/dev/vda1" \
+      --output test.uki.unsigned
+
+  For aarch64:
+
+    ukify build \
+      --linux /boot/vmlinuz \
+      --initrd /boot/initrd.img \
+      --cmdline "console=ttyAMA0 root=/dev/vda1" \
+      --output test.uki.unsigned
+
+  # Sign the UKI with the db key
+  sbsign --key keys/db.key --cert keys/db.crt \
+    --output test.uki test.uki.unsigned
+
+Step 4: Build the ESP Disk Image
+----------------------------------
+  All files -- keys and the signed UKI -- go into one FAT image.
+  This image is what gets passed to QEMU as a disk.
+
+  dd if=/dev/zero of=esp.img bs=1M count=128
+  mkfs.vfat esp.img
+
+  # Copy the key enrollment files to the FAT root
+  mcopy -i esp.img keys/PK.auth  ::PK.auth
+  mcopy -i esp.img keys/KEK.auth ::KEK.auth
+  mcopy -i esp.img keys/db.auth  ::db.auth
+
+  # Copy the signed UKI as the default EFI boot binary
+  mmd   -i esp.img ::EFI ::EFI/BOOT
+
+  For x86_64:
+    mcopy -i esp.img test.uki ::EFI/BOOT/BOOTX64.EFI
+
+  For aarch64:
+    mcopy -i esp.img test.uki ::EFI/BOOT/BOOTAA64.EFI
+
+Step 5: Launch QEMU
+---------------------
+  The esp.img disk image (containing both keys and the UKI) is passed
+  to QEMU as a virtio drive. U-Boot accesses it as "virtio 0:1".
+
+  For x86_64:
+
+    qemu-system-x86_64 \
+      -bios u-boot.rom \
+      -m 4G \
+      -drive if=virtio,format=raw,file=esp.img \
+      -nographic
+
+  For aarch64:
+
+    qemu-system-aarch64 -machine virt -cpu cortex-a57 -m 4G \
+      -bios u-boot.bin \
+      -drive if=virtio,format=raw,file=esp.img \
+      -nographic
+
+Step 6: Enroll Keys and Boot (in U-Boot console)
+---------------------------------------------------
+  # All files are on the same disk: virtio 0:1
+
+  # 1. Enroll secure boot keys (from FAT root)
+  fatload virtio 0:1 4000000 db.auth
+  setenv -e -nv -bs -rt -at -i 4000000:$filesize db
+  fatload virtio 0:1 4000000 KEK.auth
+  setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK
+  fatload virtio 0:1 4000000 PK.auth
+  setenv -e -nv -bs -rt -at -i 4000000:$filesize PK
+
+  # 2. Verify secure boot is active
+  printenv -e SecureBoot
+
+  # 3. Verify security protocols are installed
+  #    Look for GUIDs a46423e3-... and 94ab2f58-... on the root handle
+  efidebug dh
+
+  # 4. Boot the signed UKI (from EFI/BOOT/ on the same disk)
+  For x86_64:
+    efidebug boot add -b 1 UKI virtio 0:1 /EFI/BOOT/BOOTX64.EFI -s ""
+
+  For aarch64:
+    efidebug boot add -b 1 UKI virtio 0:1 /EFI/BOOT/BOOTAA64.EFI -s ""
+
+  efidebug boot order 1
+  bootefi bootmgr
+
+Expected Result
+----------------
+1. The UKI outer PE passes secure boot authentication (signed with db key).
+2. systemd-stub inside the UKI locates EFI_SECURITY2_ARCH_PROTOCOL.
+3. systemd-stub overrides the FileAuthentication callback.
+4. systemd-stub calls LoadImage() for the embedded kernel.
+5. U-Boot's efi_load_pe() calls the overridden callback, which returns
+   EFI_SUCCESS for the embedded kernel.
+6. The kernel starts successfully via StartImage().
+7. After loading, systemd-stub restores the original callback.
+
+Troubleshooting
+----------------
+- "Machine type 0x8664 is not supported": The UKI is x86_64 but U-Boot
+  was built for a different architecture. Rebuild with qemu-x86_64_defconfig.
+
+- "Machine type 0xaa64 is not supported": The UKI is aarch64 but U-Boot
+  was built for x86_64. Rebuild with qemu_arm64_defconfig.
+
+- "Failed to load initrd: 0x8000000000000009" (EFI_OUT_OF_RESOURCES):
+  Not enough EFI memory for the initrd. Increase QEMU RAM (-m 4G), use
+  a smaller initrd, or increase CONFIG_SYS_MALLOC_LEN in U-Boot.
+
+- Keys fail to enroll: Make sure the .auth files are time-based
+  authenticated variables signed with the correct parent key (db signed
+  by KEK, KEK signed by PK, PK self-signed).
diff --git a/test/py/tests/test_efi_secboot/test_security_arch.py b/test/py/tests/test_efi_secboot/test_security_arch.py
new file mode 100644
index 00000000000..9ba3cbcf944
--- /dev/null
+++ b/test/py/tests/test_efi_secboot/test_security_arch.py
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier:      GPL-2.0+
+# Copyright (c) 2026
+#
+# U-Boot UEFI: Security Architecture Protocol Test
+
+"""
+This test verifies that EFI_SECURITY_ARCH_PROTOCOL and
+EFI_SECURITY2_ARCH_PROTOCOL are installed and discoverable.
+"""
+
+import pytest
+
+
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.buildconfigspec('efi_security_arch_protocol')
+@pytest.mark.buildconfigspec('cmd_efidebug')
+@pytest.mark.slow
+class TestEfiSecurityArch(object):
+    def test_efi_security_protocols_installed(self, ubman):
+        """
+        Test that Security Architecture Protocols are visible on root handle.
+        """
+        ubman.restart_uboot()
+        output = ubman.run_command('efidebug dh')
+        # EFI_SECURITY_ARCH_PROTOCOL_GUID
+        assert 'a46423e3-4617-49f1-b9ff-d1bfa9115839' in ''.join(output).lower() \
+            or 'Security' in ''.join(output)
+        # EFI_SECURITY2_ARCH_PROTOCOL_GUID
+        assert '94ab2f58-1438-4ef1-9152-18941a3a0e68' in ''.join(output).lower() \
+            or 'Security2' in ''.join(output)
+
+    def test_efi_security_signed_image_with_protocol(self, ubman, efi_boot_env):
+        """
+        Regression: signed images still authenticate when the security
+        architecture protocols are installed and route the authentication.
+        """
+        ubman.restart_uboot()
+        disk_img = efi_boot_env
+        output = ubman.run_command_list([
+            'host bind 0 %s' % disk_img,
+            'fatload host 0:1 4000000 db.auth',
+            'setenv -e -nv -bs -rt -at -i 4000000:$filesize db',
+            'fatload host 0:1 4000000 KEK.auth',
+            'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
+            'fatload host 0:1 4000000 PK.auth',
+            'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
+        assert 'Failed to set EFI variable' not in ''.join(output)
+        output = ubman.run_command_list([
+            'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi.signed -s ""',
+            'efidebug boot order 1',
+            'bootefi bootmgr'])
+        assert 'Hello, world!' in ''.join(output)
+
+    def test_efi_security_unsigned_image_rejected(self, ubman, efi_boot_env):
+        """
+        Regression: unsigned images are still rejected under secure boot
+        when the security architecture protocols are installed.
+        """
+        ubman.restart_uboot()
+        disk_img = efi_boot_env
+        output = ubman.run_command_list([
+            'host bind 0 %s' % disk_img,
+            'fatload host 0:1 4000000 KEK.auth',
+            'setenv -e -nv -bs -rt -at -i 4000000:$filesize KEK',
+            'fatload host 0:1 4000000 PK.auth',
+            'setenv -e -nv -bs -rt -at -i 4000000:$filesize PK'])
+        assert 'Failed to set EFI variable' not in ''.join(output)
+        output = ubman.run_command_list([
+            'efidebug boot add -b 1 HELLO host 0:1 /helloworld.efi -s ""',
+            'efidebug boot order 1',
+            'efidebug test bootmgr'])
+        assert '\'HELLO\' failed' in ''.join(output)
+        assert 'efi_bootmgr_load() returned: 26' in ''.join(output)

-- 
2.54.0

