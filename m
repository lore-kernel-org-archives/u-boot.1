Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5D09CA5FE0
	for <u-boot@archiver.kernel.org>; Fri,  2 Oct 2026 08:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6ECB640A32;
	Fri,  2 Oct 2026 08:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQBTgjNfs5QH; Fri,  2 Oct 2026 08:38:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 5FDFA40A41
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790930290;
	b=Gs2eQY2feIqAdncgZKrxXkj0MYFq3O+4hrKYOVED+D+LfrlulugM+UA1OhBbn33Nvkzy
	 I6aFxQq4bHbyVnZLiPKYZfb5KV6r2RrR1J/fFtrCgaFwaEXBenLbtJWYb5REIWXi9RsOz
	 ANwrdUT4BleWDL2jcdAFMaYFuoKJDg2txnspMoSONFNFd8xB28a8Uk6LoDqvn63tYOww8
	 WO5WyV+kPCsmuy/7pga1M8bVUV31yK2gv0QhG2f1jB6CS4Qx9rsMNJ5tG4J0+Zt4luB4g
	 4j+T+tfN+XoKPgq9kPrcaFIotOsmgVVGylDW/kzFDe6WZ1DEvkJUANVpx0pPCjn75DA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790930290;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=zuZscwXC0Ksa44tQaW7ppETli8mg/W4tHhII0rCqRT4=;
	b=KfSQHHb5bKrs8EdfeUP2mInQ6gnzLafcZN+fJg+VGeFjpeqA0srrNcEua2gF7i3ILXzG
	 vzi/6ORgzyKaPOOx4VP9ZGfRENSMnmfkpGo91e503TKPWv88irX9fBhjdEiqfjN3AflXt
	 7IF2LSe2fEf1acAbI1+MSDpun0j1r2eJxX+ni+Kikhqn0yc66uP5r53+qXl9qgpyeCgV9
	 SheZ8KdsmGx47m7bXM77FWy0gcfvbK01HOkdhUBHBJGN/H/byPX7gF/gIPYjNHh8VNSyJ
	 hc/IK29ECJ2DS2+BIayCpkZN0AfPwlh2PdG2Vc1lXOeSlX1NZJcQp0cLolharjoX9kw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790930290;
	bh=zuZscwXC0Ksa44tQaW7ppETli8mg/W4tHhII0rCqRT4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YpUU3jGirey6pUIP5H8J3WmaC+Pn4yR7miWEStzA/ju6INm+3nrj+EwjJYzUAKt1i
	 g3BHJPfMyYM6r5Uwx/DLoB2lr96ABmr1QqFCPPCc6oXyslldN9FR0+L6w6ZkrwiLwV
	 CKAGJ2qpGjdj9JwhFTiQh85ral7kLDlpfwVpPpnVYFhhAeS8DfBcLuuKM5kcCAK51x
	 WZM+/9KqJ+znEHF/N6ImwJIV+qsnlBAkr5FYyo2TlkPq1yKbl7qCl5tRx1rfv06vXX
	 c+mRg01sIwdKioiF9HsQm1ictustGxH3Xqt48Z7SeSU51YLxwQ+Bb6nQHBKMNxw2H/
	 dlpZN8sCe6QRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5FDFA40A41;
	Fri,  2 Oct 2026 08:38:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC61F34D
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D1C90607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rVru5aoOJdsg for <u-boot@lists.u-boot-project.org>;
 Fri,  2 Oct 2026 08:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2025160612
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790930287;
 b=Z8XO9TONaPAA5aTiTlKw2axgW2lrPmS7QzmxJYAX473NMMdIArMF0tOyjmQvLfbslSR4
 1cQuxPFeLn4DtquCyLlwhQ2gNwlHTLkBNb7YaGmkRMRfWG+jIIEZkZ55L+saQtg6xTfDh
 z12OeRb9boOENM9YW26kLxzVPSgxml4Co7Di2O7l53tu7S30RSfcQJ6XkcRoXXAbRYzFE
 5Bq7C6r4tHIBsyO7iemtH2Z6FWr4jRRkTN5O1pvhxcjYop5Zeg0rTylfZ9gKgmd/jOCEV
 Ixi0Ue4ZcEtwhzH3c4mKsP6ILRxmubKTNcq1uI8A0S5YaGxIeuNhiNYBVK9l7jm33GA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790930287;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Date:Subject:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
 X-Developer-Key;
 bh=zuZscwXC0Ksa44tQaW7ppETli8mg/W4tHhII0rCqRT4=;
 b=EMqeb1+Ex3jsEZwTKPfq2uKattXfQ1kDb6ZWnO4Esu3/ygaPfTO6fhewj2prmV3Mz2VR
 7ISbd3OkMuu5r6p2GRXef/iL3j0402znRUcFK5Enb0cUoVe9IQHiS32UcUMZzadqLUgRu
 Y9rDcI2FYwVUArsFL05YAsurrQ+LNvNmLsad+jv2xQVF7qL0i+1IpKyZZ/YkwATdQ3HOP
 OFO8ulpyXsC/Tcj+EpC2iymfcCOpXhYq9G8A3RNYU1tPqyfYeFF6VrnTCRQM+25PUVbVV
 W/bOO0bJf8L9zx2kzbe//62+dr0BSQ3VwECNJjAEsF5l2e55TH2h8/oqzFqf/zW3wlg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss
 header.b=oe+3mEHZ; 
 arc=none smtp.remote-ip=217.140.110.172
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=217.140.110.172;
 helo=foss.arm.com; envelope-from=vincent.stehle@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=foss header.b=oe+3mEHZ
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2025160612
 for <u-boot@lists.u-boot-project.org>; Fri,  2 Oct 2026 08:38:06 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34293169C;
 Fri,  2 Oct 2026 01:38:02 -0700 (PDT)
Received: from [127.0.1.1] (unknown [10.57.11.46])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 849153F85F;
 Fri,  2 Oct 2026 01:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790930285; bh=Tu8OYCGojSD1pPNQZfRLs5gtATOe9a5cY8s/Khb7K3Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oe+3mEHZQRcA8UgGcEIcOU1M5hPmPjI9F3g/dkuRTje2FvG2zhrRSN81g5xsUGM/u
 ZjP9Sc9+1D5VRLefA4BrF6NPrta0qOCXm8aZputw3UQ/A2TgoBonDJQM8gVJwhLvOf
 SpDyJvocDMgZjpfayAfwvve6ScCP5e+qqbyL+Y58=
From: =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Date: Fri, 02 Oct 2026 10:37:48 +0200
Subject: [PATCH v2 2/2] efi_selftest: add minimal fmp test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261002-authi-v2-2-900f6f9141d5@arm.com>
References: <20261002-authi-v2-0-900f6f9141d5@arm.com>
In-Reply-To: <20261002-authi-v2-0-900f6f9141d5@arm.com>
To: u-boot@lists.u-boot-project.org
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Udit Kumar <u-kumar1@ti.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, 
 =?utf-8?q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9757;
 i=vincent.stehle@arm.com; h=from:subject:message-id;
 bh=Tu8OYCGojSD1pPNQZfRLs5gtATOe9a5cY8s/Khb7K3Y=;
 b=owGbwMvMwMV42vNHWNlitimMp9WSGLL256Z2FO0v4XnDzTllXdP/9nepr81CA5asW7djk6Oin
 p8Ic0F2J6MxCwMjF4OsmCLL9QSRBX1RAYIFFVo5MINYmUCmMHBxCsBE2Oez/68/rbOAv+51Lff5
 PSdcj2trbKnbJZXLc9LobkLky+KM378a53an/98c+tXdUrl0BlvORecFSel8u19t4Sot8uvU/v/
 mgbjCE+Fzn0tTT1rHxsvmHGh5wn1rvxWn6n5WVU73FkvOJm/2Z+tUJ9g3vmH67sr822lX7Mu2G/
 pzIhpD495N63B+LmJ+PY9N0CPw1EmT+osF3coRBZs1//DNYVWP/22hsFPEsvRbdlilv/+bLQtSw
 nXaDi2on6wq8SVN4+oh9VSW0Na2NX4HMxhdfLa8fK1jMD38gaa4fGn0/rtdCw/YZgW7bZTJKVDc
 0M2QcuD9tQOOQh/zVrI/c53o0dazeKfxzVUfc5srjUwA
X-Developer-Key: i=vincent.stehle@arm.com; a=openpgp;
 fpr=D76014A08E5A501170782A6CCB49F85676A30694
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Add a minimal test for the UEFI Firmware Management Protocol.
At this point the test only does the following:

For all handles in the system with FMP,
- Get current firmware images info.
- For each image, verify consistency of the flags, with some attention to
  authentication.

This can be tested on the sandbox with the following command:

  ./u-boot -T -c "setenv efi_selftest firmware management protocol; \
                  bootefi selftest"

Testing with multiple handles supporting FMP can be done by enabling
both CONFIG_EFI_CAPSULE_FIRMWARE_FIT and
CONFIG_EFI_CAPSULE_FIRMWARE_RAW.

Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
---
Changes in v2:
- Check that DescriptorSize is not smaller than the sizeof() U-Boot
  knows about, and use DescriptorSize as the stride when iterating the
  img_info[] array.
- Use IS_ENABLED() instead of CONFIG_IS_ENABLED().
- Check that any bit set in AttributesSetting is also set in
  AttributesSupported.
- Check that AUTHENTICATION_REQUIRED is not set in AttributesSetting when
  authentication is disabled.
- Use locate_handle_buffer() to discover all handles in the system with
  FMP, and test them all.
(All those changes above suggested by Simon.)
- As a precaution, check that the total size of the descriptors is not
  larger than ImageInfoSize.
- Verify that U-Boot knows all the image attributes set in
  AttributesSetting and AttributesSupported.
- Move the original test to a test_fmp() function, which tests a single
  handle, and call it on all the discovered handles.
- Print also the handle when printing images informations.
- Rely only on AttributesSetting to determine if an image is updatable.
- Do not forget to free PackageVersionName.
---
 lib/efi_selftest/Makefile           |   2 +
 lib/efi_selftest/efi_selftest_fmp.c | 240 ++++++++++++++++++++++++++++++++++++
 2 files changed, 242 insertions(+)

diff --git a/lib/efi_selftest/Makefile b/lib/efi_selftest/Makefile
index 67102648703..9882d9f2748 100644
--- a/lib/efi_selftest/Makefile
+++ b/lib/efi_selftest/Makefile
@@ -80,6 +80,8 @@ obj-$(CONFIG_EFI_ESRT) += efi_selftest_esrt.o
 
 obj-$(CONFIG_EFI_DEBUG_SUPPORT) += efi_selftest_debug_support.o
 
+obj-$(CONFIG_EFI_CAPSULE_FIRMWARE) += efi_selftest_fmp.o
+
 targets += \
 efi_miniapp_file_image_exception.h \
 efi_miniapp_file_image_exit.h \
diff --git a/lib/efi_selftest/efi_selftest_fmp.c b/lib/efi_selftest/efi_selftest_fmp.c
new file mode 100644
index 00000000000..e082888990e
--- /dev/null
+++ b/lib/efi_selftest/efi_selftest_fmp.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test Firmware Management Protocol support.
+ *
+ * Copyright (C) 2026 Arm Ltd.
+ */
+#include <efi_selftest.h>
+
+static const efi_guid_t firmware_management_protocol_guid =
+	EFI_FIRMWARE_MANAGEMENT_PROTOCOL_GUID;
+
+static struct efi_boot_services *boottime;
+
+/**
+ * setup() - Setup unit test.
+ * @handle:	handle of the loaded image
+ * @systable:	system table
+ *
+ * Keep Boot Services.
+ *
+ * Return:	EFI_ST_SUCCESS for success.
+ */
+static int setup(const efi_handle_t handle,
+		 const struct efi_system_table *systable)
+{
+	boottime = systable->boottime;
+	return EFI_ST_SUCCESS;
+}
+
+/**
+ * test_fmp() - Perform FMP test on one handle.
+ * @handle:	firmware management protocol handle to test
+ *
+ * Call GetImageInfo() to retrieve current firmware images descriptors.
+ * For each descriptor, verify image authentication consistency.
+ *
+ * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
+ */
+static int test_fmp(efi_handle_t handle)
+{
+	efi_status_t ret;
+	efi_uintn_t img_info_size, desc_size, total_size;
+	struct efi_firmware_image_descriptor *img_info = NULL;
+	u32 desc_ver, pkg_ver;
+	u8 desc_cnt;
+	u16 *pkg_ver_name = NULL;
+	int i, result = EFI_ST_FAILURE;
+	struct efi_firmware_management_protocol *fmp;
+
+	/* Get the FMP of this handle */
+	ret = boottime->handle_protocol(handle,
+					&firmware_management_protocol_guid,
+					(void **)&fmp);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("HandleProtocol returned %u\n", (unsigned int)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Determine buffer size */
+	img_info_size = 0;
+	ret = fmp->get_image_info(fmp, &img_info_size, NULL, NULL, NULL, NULL,
+				  NULL, NULL);
+	if (ret != EFI_BUFFER_TOO_SMALL) {
+		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	/* Allocate enough memory for image info */
+	ret = boottime->allocate_pool(EFI_LOADER_DATA, img_info_size,
+				      (void **)&img_info);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("AllocatePool returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	ret = fmp->get_image_info(fmp, &img_info_size, img_info, &desc_ver,
+				  &desc_cnt, &desc_size, &pkg_ver,
+				  &pkg_ver_name);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("GetImageInfo returned %u\n", (unsigned int)ret);
+		goto out;
+	}
+
+	if (desc_ver != EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION) {
+		efi_st_error("Bad DescriptorVersion %u\n", desc_ver);
+		goto out;
+	}
+
+	if (desc_size < sizeof(struct efi_firmware_image_descriptor) ||
+	    __builtin_mul_overflow(desc_size, desc_cnt, &total_size) ||
+	    total_size > img_info_size) {
+		efi_st_error("Bad DescriptorSize %u\n",
+			     (unsigned int)desc_size);
+		goto out;
+	}
+
+	/* Verify each image info */
+	for (i = 0; i < desc_cnt; i++) {
+		const struct efi_firmware_image_descriptor *inf =
+			(const struct efi_firmware_image_descriptor *)
+			((uintptr_t)img_info + i * desc_size);
+		u64 attr_supp = inf->attributes_supported,
+		    attr_set = inf->attributes_setting;
+		const u64 attr_mask = IMAGE_ATTRIBUTE_IMAGE_UPDATABLE |
+				      IMAGE_ATTRIBUTE_RESET_REQUIRED |
+				      IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED |
+				      IMAGE_ATTRIBUTE_IN_USE |
+				      IMAGE_ATTRIBUTE_UEFI_IMAGE |
+				      IMAGE_ATTRIBUTE_DEPENDENCY;
+
+		efi_st_printf("  handle %p, image %u: %ps\n", handle,
+			      inf->image_index, inf->image_id_name);
+
+		/* No unknown image attributes supported or set. */
+		if (attr_supp & ~attr_mask) {
+			efi_st_error("Unknown AttributesSupported %u\n",
+				     (unsigned int)attr_supp);
+			goto out;
+		}
+
+		if (attr_set & ~attr_mask) {
+			efi_st_error("Unknown AttributesSetting %u\n",
+				     (unsigned int)attr_set);
+			goto out;
+		}
+
+		/* No unsupported image attributes set. */
+		if (attr_set & ~attr_supp) {
+			efi_st_error("Unsupported AttributesSetting %u\n",
+				     (unsigned int)attr_set);
+			goto out;
+		}
+
+		/*
+		 * When support for authentication is compiled in, our updatable
+		 * images must require it, both as supported and set.
+		 */
+		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
+		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
+		    !(attr_supp & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
+			efi_st_error("Bad AttributesSupported %u\n",
+				     (unsigned int)attr_supp);
+			goto out;
+		}
+
+		if (IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
+		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
+		    !(attr_set & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
+			efi_st_error("Bad AttributesSetting %u\n",
+				     (unsigned int)attr_set);
+			goto out;
+		}
+
+		/*
+		 * When support for authentication is not compiled in, our
+		 * updatable images must not advertise it as set.
+		 */
+		if (!IS_ENABLED(CONFIG_EFI_CAPSULE_AUTHENTICATE) &&
+		    (attr_set & IMAGE_ATTRIBUTE_IMAGE_UPDATABLE) &&
+		    (attr_set & IMAGE_ATTRIBUTE_AUTHENTICATION_REQUIRED)) {
+			efi_st_error("Bad AttributesSetting %u\n",
+				     (unsigned int)attr_set);
+			goto out;
+		}
+	}
+
+	result = EFI_ST_SUCCESS;
+
+out:
+	if (img_info) {
+		ret = boottime->free_pool(img_info);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool returned %u\n",
+				     (unsigned int)ret);
+			result = EFI_ST_FAILURE;
+		}
+	}
+
+	if (pkg_ver_name) {
+		ret = boottime->free_pool(pkg_ver_name);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool returned %u\n",
+				     (unsigned int)ret);
+			result = EFI_ST_FAILURE;
+		}
+	}
+
+	return result;
+}
+
+/**
+ * execute() - Perform the test on all handles with FMP.
+ *
+ * Call test_fmp() on each handle in the system supporting FMP.
+ *
+ * Return:	EFI_ST_SUCCESS for success, EFI_ST_FAILURE in case of error.
+ */
+static int execute(void)
+{
+	int i, result = EFI_ST_SUCCESS;
+	efi_handle_t *buffer = NULL;
+	efi_uintn_t count;
+	efi_status_t ret;
+
+	/* Locate all handles with FMP */
+	ret = boottime->locate_handle_buffer(BY_PROTOCOL,
+					     &firmware_management_protocol_guid,
+					     NULL, &count, &buffer);
+	if (ret != EFI_SUCCESS) {
+		efi_st_error("LocateHandleBuffer returned %u\n",
+			     (unsigned int)ret);
+		return EFI_ST_FAILURE;
+	}
+
+	/* Test all handles */
+	for (i = 0; i < count; i++) {
+		result = test_fmp(buffer[i]);
+		if (result != EFI_ST_SUCCESS)
+			break;
+	}
+
+	if (buffer) {
+		/* Free handles buffer */
+		ret = boottime->free_pool(buffer);
+		if (ret != EFI_SUCCESS) {
+			efi_st_error("FreePool returned %u\n",
+				     (unsigned int)ret);
+			result = EFI_ST_FAILURE;
+		}
+	}
+
+	return result;
+}
+
+EFI_UNIT_TEST(fmp) = {
+	.name = "firmware management protocol",
+	.phase = EFI_EXECUTE_BEFORE_BOOTTIME_EXIT,
+	.setup = setup,
+	.execute = execute,
+};

-- 
2.53.0

