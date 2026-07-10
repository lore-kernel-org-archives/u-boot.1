Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 007B7C43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 18:11:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08A0784AD6;
	Fri, 10 Jul 2026 20:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="NqeR2E+n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E66AF84ADB; Fri, 10 Jul 2026 15:24:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6871084ADD
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 15:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=imullins@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783689860;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=235TeRTaP37oN6y7lT+lQKXe2rYJZ3R3odPK8qSdtnc=;
 b=NqeR2E+nNbxDizsrkAEnhqJtWIliA0tSso4kaZRuTsHxzUDwE6uWWhFu0aeGeJLldeh0PH
 I74O5MKJYvqaUZBqqRd1sgIeDFfv8uMIWA4bd0ZpmN5RgM8oj+0/Axhw9rWsvFTQeFbUjt
 4veU5pen/DQdqHuoIeCwwm7lkhhBzeY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-3OTcQSCZN3mX8H2CtfZyWA-1; Fri, 10 Jul 2026 09:24:17 -0400
X-MC-Unique: 3OTcQSCZN3mX8H2CtfZyWA-1
X-Mimecast-MFC-AGG-ID: 3OTcQSCZN3mX8H2CtfZyWA_1783689856
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493bab443f7so5998275e9.0
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 06:24:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783689855; x=1784294655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=235TeRTaP37oN6y7lT+lQKXe2rYJZ3R3odPK8qSdtnc=;
 b=P+Q2TOqkFID/3Iw51RPIcE4y4ez37sPSft5nb8loQ5Q5w1MZLrLz4nuCvp4iUJyctw
 x37m1FC/RPTwKcNDzG6vEpUwqm/GkOrt+ti4KG3bNsKB7NnDnRt1SPUFid6k7pr99LMK
 rq3OVpQKiBY/3ztnrxW2P4IEaQ7UmCDwndx/xSBAAcqGRahyMyGoTjRB5nGWVGZqtaly
 sgn0ReRuXVnVoWAErtFuF/YUaFNJALR1+IqO1aOyGrCGj4iHuC21/t211XJFkLgWfphm
 2tS0FdmASYXQzah7T/VcIb7VtSY22a0bx/gEbrH0uToLjAJ2sKsaHlsdT42r97hIfhbl
 LVig==
X-Gm-Message-State: AOJu0Yxu8hNGFHxCpkXMo9Juy9T/cG4sosCeCqpMcUHWm24dfAa8VtdV
 s4BBwgU2yWloVJvC2iYgucoEwNf9r/SM+r1LQItxew4eO+CllvSqgaK/mpBo5mv0SUVbAPawDn5
 tnX9qq8wYJO1S+2cBeytpri0eOAYbJsDo1QkEOLK3li9HuirZBh45L4E=
X-Gm-Gg: AfdE7cm3y94u0173eqIWfTsec0rreZAasjSdN1K6iqWepeXhbKkRjWmyhaGL4dSmxFX
 yXElY3uz//m+pkiHAK/DehHBh/C+l8y+lYnMXR37+E488ZQ38HaI+Lb9QUoUNUi5+vY6+eXngvq
 5IKfckPdAYxD6h0njXIfwaSPyqccRNwDKK6NYL++oc55/3erkZxPwgVwRYCfb5atNUtEOX8gOe9
 BcL8Jtbhd1V6u8xE42q2eLsLsGPCGxaoA8DqhOxw33LIWmKtdT2cRa5zdYjhrPGd129DTyk3e5h
 NwM39GHHJBO1VhgJEu06lxDYgEYCEV74ENA6nl9LqK+Ksgk98TCTJ+blSiVXvW2ji507dMXvpoA
 h5eI+ZeZZLDuHz0dQ/r2JkESRRq9UrHye/8CS1/mfFg==
X-Received: by 2002:a05:600c:3495:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-493f2b4a78bmr34468505e9.17.1783689855551; 
 Fri, 10 Jul 2026 06:24:15 -0700 (PDT)
X-Received: by 2002:a05:600c:3495:b0:493:ecf5:89fd with SMTP id
 5b1f17b1804b1-493f2b4a78bmr34468125e9.17.1783689855034; 
 Fri, 10 Jul 2026 06:24:15 -0700 (PDT)
Received: from [192.168.68.133] (33b7f9ad.skybroadband.com. [51.183.249.173])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2e77c2esm41527715e9.2.2026.07.10.06.24.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 06:24:14 -0700 (PDT)
From: Ian Mullins <imullins@redhat.com>
Date: Fri, 10 Jul 2026 14:23:08 +0100
Subject: [PATCH 1/2] efi_loader: implement EFI Security Architecture protocols
MIME-Version: 1.0
Message-Id: <20260710-efi_security_protocol-v1-1-a06cef90057b@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13489; i=imullins@redhat.com; 
 h=from:subject:message-id;
 bh=uMpriCj1LLvGVYLvlpIx5awGdCLYhKon7lH+++apRmU=; 
 b=owEBbQKS/ZANAwAKAdSOKmyUBwJWAcsmYgBqUPJ7JWdSsq7r5YRk2oSFsjAEqYIz9WU6AntF8
 vvEtiFpVQOJAjMEAAEKAB0WIQTdLPzJ05Wjhy4Uwd3UjipslAcCVgUCalDyewAKCRDUjipslAcC
 VvhBEACEqizZIc0dVI0hewnk+O8IaZBGkJRB0e7xnkVButWGzA9hkgyWOPWFS+vkXcoPM2aQ4Kj
 AIbCf9inW+xdsMPXsC90qh/VLcQl3oOTawuYxBBYnN/kynNCaiQArlUGDDbOksIrXfA/ZkYtmed
 wUJ7+2o5ldXKrrs3ZGwb7tPq9DLIpIwZvwgVx2PvxiYoEauSlfokrSxpKQfcgkeDmhZ590tHqYu
 GTmiQ/c6s2M/n2XAqxXRvehyxNIdIwWNbwO/ucpKsRyVi/dl+Z+EU1fBUUksu3AWBBrEn01PfqA
 07luvU5bxbYy0e/57TPYn7W4dgLWhT3pnI+yJZBCQBgqbimh0hIy1dD/Nscqq+hBPl2ofWNWVjK
 ysKfgM7sAB+U1glAyWjaNllIE3sF/e7bxyrhVsrkihwPkWaD/XjxKuq2jdsHeoC5PSY484rl1ht
 X6Woe17+K/EF3Z9etkNN1hSLBxQ9Fn3DEYzQ/CHG9ZxfyAV8lmnLrRQcJK/VJetLvxzNbNyL1ZQ
 DTfRM5fQynwRc5Co1OPZs0rnvQds1PB8+mUzsQaRcUHOdCxMMRKlvwX6L3SFJgWWSxcTFnrXwDK
 wBYU/+3XwfKyjc8xjdCSk1ZJyyxTaHt4t0xckyhCWWlN8tzI9q/uGVzDl+2iLuQMqg5vSK3+1WK
 tREbXE7cC5j2nKA==
X-Developer-Key: i=imullins@redhat.com; a=openpgp;
 fpr=DD2CFCC9D395A3872E14C1DDD48E2A6C94070256
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sdxvJxC8kQvV3zHfYdZtQwwsyq5J1fzPeacb7sBoeSs_1783689856
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

This patch implements the EFI_SECURITY_ARCH_PROTOCOL and
EFI_SECURITY2_ARCH_PROTOCOL as defined in the UEFI Platform
Initialization (PI) specification.

These protocols provide a mechanism for the EFI loader to perform security
checks on images before they are executed. By default, the implementation
delegates to the internal UEFI Secure Boot authentication logic.

The primary motivation is to support EFI applications like systemd-stub
in Unified Kernel Images (UKI). These applications can install a custom
version of the security protocols to temporarily override authentication
for embedded payloads that were already verified as part of the signed
PE binary.

Signed-off-by: Enric Balletbo i Serra <eballetbo@kernel.org>
Signed-off-by: Ian Mullins <imullins@redhat.com>
---
 include/efi_api.h                 | 30 ++++++++++++
 include/efi_loader.h              | 15 +++++-
 lib/efi_loader/Kconfig            | 11 +++++
 lib/efi_loader/Makefile           |  1 +
 lib/efi_loader/efi_boottime.c     |  3 +-
 lib/efi_loader/efi_image_loader.c | 31 +++++++++---
 lib/efi_loader/efi_security.c     | 99 +++++++++++++++++++++++++++++++++++++++
 lib/efi_loader/efi_setup.c        |  7 +++
 8 files changed, 188 insertions(+), 9 deletions(-)

diff --git a/include/efi_api.h b/include/efi_api.h
index d4fdd50c49e..1c52855af63 100644
--- a/include/efi_api.h
+++ b/include/efi_api.h
@@ -487,6 +487,14 @@ struct efi_runtime_services {
 	EFI_GUID(0xccd15fec, 0x6f73, 0x4eec, 0x83, \
 		 0x95, 0x3e, 0x69, 0xe4, 0xb9, 0x40, 0xbf)
 
+#define EFI_SECURITY_ARCH_PROTOCOL_GUID \
+	EFI_GUID(0xa46423e3, 0x4617, 0x49f1, 0xb9, 0xff, \
+		 0xd1, 0xbf, 0xa9, 0x11, 0x58, 0x39)
+
+#define EFI_SECURITY2_ARCH_PROTOCOL_GUID \
+	EFI_GUID(0x94ab2f58, 0x1438, 0x4ef1, 0x91, 0x52, \
+		 0x18, 0x94, 0x1a, 0x3a, 0x0e, 0x68)
+
 /**
  * struct efi_configuration_table - EFI Configuration Table
  *
@@ -2445,4 +2453,26 @@ struct efi_disk {
 					  void *buffer);
 };
 
+struct efi_security_arch_protocol;
+
+typedef efi_status_t (EFIAPI *efi_security_file_authentication_state)(const struct efi_security_arch_protocol *this,
+		u32 authentication_status,
+		const struct efi_device_path *file);
+
+struct efi_security_arch_protocol {
+	efi_security_file_authentication_state file_authentication_state;
+};
+
+struct efi_security2_arch_protocol;
+
+typedef efi_status_t (EFIAPI *efi_security2_file_authentication)(const struct efi_security2_arch_protocol *this,
+		const struct efi_device_path *device_path,
+		void *file_buffer,
+		efi_uintn_t file_size,
+		bool boot_policy);
+
+struct efi_security2_arch_protocol {
+	efi_security2_file_authentication file_authentication;
+};
+
 #endif
diff --git a/include/efi_loader.h b/include/efi_loader.h
index 3a4d502631c..b80ce390466 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -381,6 +381,9 @@ extern const efi_guid_t efi_guid_cert_type_pkcs7;
 
 /* GUID of RNG protocol */
 extern const efi_guid_t efi_guid_rng_protocol;
+/* GUIDs for EFI Security Architecture Protocols */
+extern const efi_guid_t efi_guid_security_arch_protocol;
+extern const efi_guid_t efi_guid_security2_arch_protocol;
 /* GUID of capsule update result */
 extern const efi_guid_t efi_guid_capsule_report;
 /* GUID of firmware management protocol */
@@ -671,6 +674,12 @@ efi_status_t efi_console_register(void);
 efi_status_t efi_disks_register(void);
 /* Called by efi_init_obj_list() to install EFI_RNG_PROTOCOL */
 efi_status_t efi_rng_register(void);
+/* Called by efi_init_obj_list() to install Security Architecture Protocols */
+efi_status_t efi_security_arch_register(void);
+/* Check image authentication via Security2 Architecture Protocol */
+efi_status_t efi_security_check_image(const struct efi_device_path *file_path,
+				      void *file_buffer, efi_uintn_t file_size,
+				      bool boot_policy);
 /* Called by efi_init_obj_list() to install EFI_TCG2_PROTOCOL */
 efi_status_t efi_tcg2_register(void);
 /* Called by efi_init_obj_list() to install RISCV_EFI_BOOT_PROTOCOL */
@@ -728,10 +737,14 @@ efi_status_t efi_set_watchdog(unsigned long timeout);
 void efi_timer_check(void);
 /* Check if a buffer contains a PE-COFF image */
 efi_status_t efi_check_pe(void *buffer, size_t size, void **nt_header);
+/* Verify a PE image's signature against secure boot databases */
+bool efi_image_authenticate(void *efi, size_t efi_size);
 /* PE loader implementation */
 efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			 void *efi, size_t efi_size,
-			 struct efi_loaded_image *loaded_image_info);
+			 struct efi_loaded_image *loaded_image_info,
+			 struct efi_device_path *file_path,
+			 bool boot_policy);
 /* Called once to store the pristine gd pointer */
 void efi_save_gd(void);
 /* Call this to relocate the runtime section to an address space */
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 4cb13ae7c8a..b253af121a4 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -71,6 +71,17 @@ config EFI_SECURE_BOOT
 	  it is signed with a trusted key. To do that, you need to install,
 	  at least, PK, KEK and db.
 
+config EFI_SECURITY_ARCH_PROTOCOL
+	bool "Install EFI Security Architecture Protocols"
+	depends on EFI_SECURE_BOOT
+	default y
+	help
+	  Install EFI_SECURITY_ARCH_PROTOCOL and
+	  EFI_SECURITY2_ARCH_PROTOCOL. These allow EFI applications
+	  (such as systemd-stub in Unified Kernel Images) to temporarily
+	  override secure boot authentication for embedded payloads that
+	  were already verified as part of a signed PE binary.
+
 config EFI_SIGNATURE_SUPPORT
 	bool
 
diff --git a/lib/efi_loader/Makefile b/lib/efi_loader/Makefile
index d73ad43951b..2cfa33bb114 100644
--- a/lib/efi_loader/Makefile
+++ b/lib/efi_loader/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_EFI_HTTP_PROTOCOL) += efi_http.o
 obj-$(CONFIG_ACPI) += efi_acpi.o
 obj-$(CONFIG_SMBIOS) += efi_smbios.o
 obj-$(CONFIG_EFI_RNG_PROTOCOL) += efi_rng.o
+obj-$(CONFIG_EFI_SECURITY_ARCH_PROTOCOL) += efi_security.o
 obj-$(CONFIG_EFI_TCG2_PROTOCOL) += efi_tcg2.o
 obj-$(CONFIG_EFI_RISCV_BOOT_PROTOCOL) += efi_riscv.o
 obj-$(CONFIG_EFI_LOAD_FILE2_INITRD) += efi_load_initrd.o
diff --git a/lib/efi_loader/efi_boottime.c b/lib/efi_loader/efi_boottime.c
index de57823bd44..934bdd89a69 100644
--- a/lib/efi_loader/efi_boottime.c
+++ b/lib/efi_loader/efi_boottime.c
@@ -2120,7 +2120,8 @@ efi_status_t EFIAPI efi_load_image(bool boot_policy,
 	efi_dp_split_file_path(file_path, &dp, &fp);
 	ret = efi_setup_loaded_image(dp, fp, image_obj, &info);
 	if (ret == EFI_SUCCESS)
-		ret = efi_load_pe(*image_obj, dest_buffer, source_size, info);
+		ret = efi_load_pe(*image_obj, dest_buffer, source_size, info,
+				  file_path, boot_policy);
 	if (!source_buffer)
 		/* Release buffer to which file was loaded */
 		efi_free_pages((uintptr_t)dest_buffer,
diff --git a/lib/efi_loader/efi_image_loader.c b/lib/efi_loader/efi_image_loader.c
index f9a2d2df405..f128aabf142 100644
--- a/lib/efi_loader/efi_image_loader.c
+++ b/lib/efi_loader/efi_image_loader.c
@@ -641,7 +641,7 @@ static bool efi_image_verify_digest(struct efi_image_regions *regs,
  *
  * Return:	true if authenticated, false if not
  */
-static bool efi_image_authenticate(void *efi, size_t efi_size)
+bool efi_image_authenticate(void *efi, size_t efi_size)
 {
 	struct efi_image_regions *regs = NULL;
 	WIN_CERTIFICATE *wincerts = NULL, *wincert;
@@ -818,7 +818,7 @@ out:
 	return ret;
 }
 #else
-static bool efi_image_authenticate(void *efi, size_t efi_size)
+bool efi_image_authenticate(void *efi, size_t efi_size)
 {
 	return true;
 }
@@ -890,11 +890,15 @@ static u32 section_size(IMAGE_SECTION_HEADER *sec)
  * @efi:		pointer to the EFI binary
  * @efi_size:		size of @efi binary
  * @loaded_image_info:	loaded image protocol
+ * @file_path:		device path of the image (for security protocol)
+ * @boot_policy:	true if loading as a boot option
  * Return:		status code
  */
 efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 			 void *efi, size_t efi_size,
-			 struct efi_loaded_image *loaded_image_info)
+			 struct efi_loaded_image *loaded_image_info,
+			 struct efi_device_path *file_path,
+			 bool boot_policy)
 {
 	IMAGE_NT_HEADERS32 *nt;
 	IMAGE_DOS_HEADER *dos;
@@ -939,11 +943,24 @@ efi_status_t efi_load_pe(struct efi_loaded_image_obj *handle,
 	}
 
 	/* Authenticate an image */
-	if (efi_image_authenticate(efi, efi_size)) {
-		handle->auth_status = EFI_IMAGE_AUTH_PASSED;
+	if (IS_ENABLED(CONFIG_EFI_SECURITY_ARCH_PROTOCOL)) {
+		efi_status_t auth_ret;
+
+		auth_ret = efi_security_check_image(file_path, efi, efi_size,
+						    boot_policy);
+		if (auth_ret == EFI_SUCCESS) {
+			handle->auth_status = EFI_IMAGE_AUTH_PASSED;
+		} else {
+			handle->auth_status = EFI_IMAGE_AUTH_FAILED;
+			log_err("Image not authenticated\n");
+		}
 	} else {
-		handle->auth_status = EFI_IMAGE_AUTH_FAILED;
-		log_err("Image not authenticated\n");
+		if (efi_image_authenticate(efi, efi_size)) {
+			handle->auth_status = EFI_IMAGE_AUTH_PASSED;
+		} else {
+			handle->auth_status = EFI_IMAGE_AUTH_FAILED;
+			log_err("Image not authenticated\n");
+		}
 	}
 
 	/* Calculate upper virtual address boundary */
diff --git a/lib/efi_loader/efi_security.c b/lib/efi_loader/efi_security.c
new file mode 100644
index 00000000000..66f2e79ad31
--- /dev/null
+++ b/lib/efi_loader/efi_security.c
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * EFI Security Architecture Protocol implementation
+ *
+ * Implements EFI_SECURITY_ARCH_PROTOCOL and EFI_SECURITY2_ARCH_PROTOCOL
+ * as defined in the UEFI Platform Initialization (PI) specification.
+ *
+ * These protocols allow EFI applications (such as systemd-stub in Unified
+ * Kernel Images) to temporarily override secure boot authentication for
+ * embedded payloads that were already verified as part of a signed PE binary.
+ */
+
+#define LOG_CATEGORY LOGC_EFI
+
+#include <efi_loader.h>
+#include <log.h>
+
+const efi_guid_t efi_guid_security_arch_protocol =
+	EFI_SECURITY_ARCH_PROTOCOL_GUID;
+const efi_guid_t efi_guid_security2_arch_protocol =
+	EFI_SECURITY2_ARCH_PROTOCOL_GUID;
+
+static efi_status_t EFIAPI
+default_file_auth_state(const struct efi_security_arch_protocol *this,
+			u32 authentication_status,
+			const struct efi_device_path *file)
+{
+	return EFI_SUCCESS;
+}
+
+static efi_status_t EFIAPI
+default_file_authentication(const struct efi_security2_arch_protocol *this,
+			    const struct efi_device_path *device_path,
+			    void *file_buffer, efi_uintn_t file_size,
+			    bool boot_policy)
+{
+	if (efi_image_authenticate(file_buffer, file_size))
+		return EFI_SUCCESS;
+
+	return EFI_SECURITY_VIOLATION;
+}
+
+static struct efi_security_arch_protocol efi_security_arch = {
+	.file_authentication_state = default_file_auth_state,
+};
+
+static struct efi_security2_arch_protocol efi_security2_arch = {
+	.file_authentication = default_file_authentication,
+};
+
+/**
+ * efi_security_check_image() - authenticate image via Security2 protocol
+ *
+ * Calls the currently installed FileAuthentication callback on the
+ * EFI_SECURITY2_ARCH_PROTOCOL instance. This may be the default handler
+ * (which delegates to efi_image_authenticate()) or a custom override
+ * installed by an EFI application such as systemd-stub.
+ *
+ * @file_path:		device path of the image being loaded
+ * @file_buffer:	pointer to the image data
+ * @file_size:		size of the image data
+ * @boot_policy:	true if image is being loaded as a boot option
+ * Return:		EFI_SUCCESS if authenticated, error code otherwise
+ */
+efi_status_t efi_security_check_image(const struct efi_device_path *file_path,
+				      void *file_buffer, efi_uintn_t file_size,
+				      bool boot_policy)
+{
+	return efi_security2_arch.file_authentication(&efi_security2_arch,
+						      file_path, file_buffer,
+						      file_size, boot_policy);
+}
+
+/**
+ * efi_security_arch_register() - install Security Architecture Protocols
+ *
+ * Installs both EFI_SECURITY_ARCH_PROTOCOL and EFI_SECURITY2_ARCH_PROTOCOL
+ * on the root handle during EFI subsystem initialization.
+ *
+ * Return:	status code
+ */
+efi_status_t efi_security_arch_register(void)
+{
+	efi_status_t ret;
+
+	ret = efi_add_protocol(efi_root, &efi_guid_security_arch_protocol,
+			       (void *)&efi_security_arch);
+	if (ret != EFI_SUCCESS) {
+		log_err("Cannot install EFI_SECURITY_ARCH_PROTOCOL\n");
+		return ret;
+	}
+
+	ret = efi_add_protocol(efi_root, &efi_guid_security2_arch_protocol,
+			       (void *)&efi_security2_arch);
+	if (ret != EFI_SUCCESS)
+		log_err("Cannot install EFI_SECURITY2_ARCH_PROTOCOL\n");
+
+	return ret;
+}
diff --git a/lib/efi_loader/efi_setup.c b/lib/efi_loader/efi_setup.c
index f302bb62ab9..7c8ce129e22 100644
--- a/lib/efi_loader/efi_setup.c
+++ b/lib/efi_loader/efi_setup.c
@@ -338,6 +338,13 @@ efi_status_t efi_init_obj_list(void)
 			goto out;
 	}
 
+	/* Security Architecture Protocols */
+	if (IS_ENABLED(CONFIG_EFI_SECURITY_ARCH_PROTOCOL)) {
+		ret = efi_security_arch_register();
+		if (ret != EFI_SUCCESS)
+			goto out;
+	}
+
 	/* Indicate supported runtime services */
 	ret = efi_init_runtime_supported();
 	if (ret != EFI_SUCCESS)

-- 
2.54.0

