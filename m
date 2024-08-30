Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CFCCA0FE1
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 12:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE2DA88C36;
	Fri, 30 Aug 2024 14:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nxFJroXw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0438E88B16; Fri, 30 Aug 2024 14:34:41 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0474A88B16
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:34:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4280b3a7efaso14990765e9.0
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 05:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725021278; x=1725626078; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zs4Gu8Qf2U45wSZmb1eyVaN9T3a2AvbsPdlCbYpA1zc=;
 b=nxFJroXwIGpDWJxOEVGE0IKyOi+H2mkVTVh1IxVzR3gWgCo62s58e0cLuSp5hkjW5k
 Z1FoSvKwqZ5L79jI0kULan50ksJpTGcPLmHOGWmUIbssRqZ/nvs9mTHBC/TyY4uynOlX
 OE/DTZTYpylkA3m50jX3UzpLphd24AarHtdol0anfR2H/HVl1S+HJHzu2zONUdno39Q+
 35OqMfIMTtQ6krc/jZzbfBBeCdyqbQhiLQZ5x434iX2hfkFWJIvP+8EjaxOPn2AqfSft
 ztp5MeEP6heBxWsb5Nj69/YohlDlA/dVhQaWrOUI4MYd3QQxRJZF445W3uMEYr8i85jX
 NR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725021278; x=1725626078;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zs4Gu8Qf2U45wSZmb1eyVaN9T3a2AvbsPdlCbYpA1zc=;
 b=xM23eO4MpBx6370wzW622mfAoxw5HSVCqXhJ1yCT7NYbk6uOZoyYTd0jqkJ2XWceHR
 /tlNpx8Q1QUxaKpU+Gv05IoQqdc6g7ug9T0rt1TLwrXxpj4Tl/Ohzlh6wmhrDyWTfo//
 z1shRQsXFMmgc3/oGclv82y5b0OK/p7H+JD3CrXvTBVlORnkKkQLyqH3FaG4R8chux4Y
 uezMEi2WwPQi4do4N6yGlkj75z6Yy/cl4pz5Z99sexeGklPHicjgEu08YdzZ9Oq+Q0Ed
 FGbqgZd7DgSukgvH6nKFM2cwx4omnRgFdcPk2Jd2F1muhIb3EwV0IpR7sVmb2Az+XklC
 K+Mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpvi/aP3HKy+VGzVsDQEb3s/aXAN4fsy6E4+3vNfHLoChI0g08nEAvIwTH8bnyLytonMONwSo=@lists.denx.de
X-Gm-Message-State: AOJu0YzaqtIhNjF55auTnL1g7muOg07MDYs3PvjER3CtJN6Qluom0FG2
 bAYPutxoCIKtmVcA2KOcY1vCdRRtnMcmZRbcttywwa3ANB5T01oYK8l+3GtQQtU=
X-Google-Smtp-Source: AGHT+IEpYWzW9gRG4yQ/DuH9qL5f8bdE65oalkNXpYXuZsiu0HA3lEcEN+NIoolPnRiMWgZEQq3GGg==
X-Received: by 2002:adf:a3ce:0:b0:371:879f:72e5 with SMTP id
 ffacd0b85a97d-374a956618bmr1315433f8f.20.1725021278400; 
 Fri, 30 Aug 2024 05:34:38 -0700 (PDT)
Received: from [192.168.1.17] (host-80-47-105-51.as13285.net. [80.47.105.51])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-374b960ef94sm648207f8f.103.2024.08.30.05.34.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 05:34:37 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 30 Aug 2024 13:34:33 +0100
Subject: [PATCH v8 03/11] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240830-b4-dynamic-uuid-v8-3-79b31b199bee@linaro.org>
References: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
In-Reply-To: <20240830-b4-dynamic-uuid-v8-0-79b31b199bee@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4932;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=gMwk6mkD9Ufvv7gOE59jH5gnrG+CZ0zKKyfkCUdSwH8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBm0bxZIXTUOUUw0elITJ9H8BStazsIGgU934TwE
 IVYDwLIYJiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZtG8WQAKCRAFgzErGV9k
 toJ6D/91KC4Vq5XGgX/Nw0lX73XlIYM9+sMkb88GYUx8uWJtEFdY1yHRr0SrI17rCiliKlxaz1L
 ofKYe8JQUKDS1jzLYhaf1CuKqj7wZNfdxv4zltztaA/VOOzjmVQZ+Q7xGgU4Ze9tQGISSqeH6+r
 J9LfJcz6gMAeVEdIlaEhp9h1EN6kX+ooBcEjLlIphwUJVpuLazYclwMU6IGiB6QLzRiKcPgAQ6x
 e7h2APItRGqwKXErkkWzGpjViYtbU+d64LJ/s4Es5KKIWLcep5uWH8YiTI6lFE+2jtag2eQBVXD
 7lR6MHqqTpbO9ewj/fOx8Yijjmgaz5gfpWSVPFOmlOnTBeVl+8UJuprMRiTfCKRce/kOpWlA8ve
 rC5kaPd0hBBZ3J2BVCpdh4wu1kdbRkAjBHZ4EUEr94mnq+geyuAgoqn4ESK529B/wS1Jkbs4dQl
 HAHy/HBD61lEyF77R0/ZkdIICaqKRMONDmZn77WpwwHNxkr6N+UPv4KP04JkMklMdd4VP1aPQMZ
 k54DIrWczGKmm5twtUnw2+5O8TFNElIrDRP1SOPSoK0zAj3DlZu4N4HHqcTG85RC1gcSV0fnYA9
 8BfziwoPO5OW9kTD6tTahkOs6FFL+65CmCMmLbAdIwpH6RUAw/7r4/rr+6bn0IspqB6+S316/e7
 uIQVzFhipu/e7Kw==
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

Introduce a new helper efi_capsule_update_info_gen_ids() which populates
the capsule update fw images image_type_id field. This allows for
determinstic UUIDs to be used that can scale to a large number of
different boards and board variants without the need to maintain a big
list.

We call this from efi_fill_image_desc_array() to populate the UUIDs
lazily on-demand.

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi_loader/Kconfig        | 12 ++++++++++
 lib/efi_loader/efi_capsule.c  |  1 +
 lib/efi_loader/efi_firmware.c | 55 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 1179c31bb136..85a31113fcf0 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -236,8 +236,20 @@ config EFI_CAPSULE_ON_DISK_EARLY
 	  If this option is enabled, capsules will be enforced to be
 	  executed as part of U-Boot initialisation so that they will
 	  surely take place whatever is set to distro_bootcmd.
 
+config EFI_CAPSULE_NAMESPACE_GUID
+	string "Namespace for dynamic capsule GUIDs"
+	# v4 UUID as a default for upstream U-Boot boards
+	default "8c9f137e-91dc-427b-b2d6-b420faebaf2a"
+	depends on EFI_HAVE_CAPSULE_SUPPORT
+	help
+	  Define the namespace or "salt" GUID used to generate the per-image
+	  GUIDs. This should be a GUID in the standard 8-4-4-4-12 format.
+
+	  Device vendors are expected to generate their own namespace GUID
+	  to avoid conflicts with upstream/community images.
+
 config EFI_CAPSULE_FIRMWARE
 	bool
 
 config EFI_CAPSULE_FIRMWARE_MANAGEMENT
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 635088f25a13..f3a2388506cc 100644
--- a/lib/efi_loader/efi_capsule.c
+++ b/lib/efi_loader/efi_capsule.c
@@ -19,8 +19,9 @@
 #include <mapmem.h>
 #include <sort.h>
 #include <sysreset.h>
 #include <asm/global_data.h>
+#include <uuid.h>
 
 #include <crypto/pkcs7.h>
 #include <crypto/pkcs7_parser.h>
 #include <linux/err.h>
diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index ba5aba098c0f..6650c2b8071d 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -244,8 +244,57 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
 	free(var_state);
 }
 
+/**
+ * efi_gen_capsule_guids - generate GUIDs for the images
+ *
+ * Generate the image_type_id for each image in the update_info.images array
+ * using the first compatible from the device tree and a salt
+ * UUID defined at build time.
+ *
+ * Returns:		status code
+ */
+static efi_status_t efi_gen_capsule_guids(void)
+{
+	int ret, i;
+	struct uuid namespace;
+	const char *compatible; /* Full array including null bytes */
+	struct efi_fw_image *fw_array;
+
+	fw_array = update_info.images;
+	/* Check if we need to run (there are images and we didn't already generate their IDs) */
+	if (!update_info.num_images ||
+	    memchr_inv(&fw_array[0].image_type_id, 0, sizeof(fw_array[0].image_type_id)))
+		return EFI_SUCCESS;
+
+	ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_GUID,
+			      (unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
+	if (ret) {
+		log_debug("%s: EFI_CAPSULE_NAMESPACE_GUID is invalid: %d\n", __func__, ret);
+		return EFI_INVALID_PARAMETER;
+	}
+
+	compatible = ofnode_read_string(ofnode_root(), "compatible");
+	if (!compatible) {
+		log_debug("%s: model or compatible not defined\n", __func__);
+		return EFI_INVALID_PARAMETER;
+	}
+
+	for (i = 0; i < update_info.num_images; i++) {
+		gen_v5_guid(&namespace,
+			    &fw_array[i].image_type_id,
+			    compatible, strlen(compatible),
+			    fw_array[i].fw_name, u16_strlen(fw_array[i].fw_name) * sizeof(uint16_t),
+			    NULL);
+
+		log_debug("Image %ls UUID %pUl\n", fw_array[i].fw_name,
+			  &fw_array[i].image_type_id);
+	}
+
+	return EFI_SUCCESS;
+}
+
 /**
  * efi_fill_image_desc_array - populate image descriptor array
  * @image_info_size:		Size of @image_info
  * @image_info:			Image information
@@ -271,9 +320,9 @@ static efi_status_t efi_fill_image_desc_array(
 	u16 **package_version_name)
 {
 	size_t total_size;
 	struct efi_fw_image *fw_array;
-	int i;
+	int i, ret;
 
 	total_size = sizeof(*image_info) * update_info.num_images;
 
 	if (*image_info_size < total_size) {
@@ -282,8 +331,12 @@ static efi_status_t efi_fill_image_desc_array(
 		return EFI_BUFFER_TOO_SMALL;
 	}
 	*image_info_size = total_size;
 
+	ret = efi_gen_capsule_guids();
+	if (ret != EFI_SUCCESS)
+		return ret;
+
 	fw_array = update_info.images;
 	*descriptor_count = update_info.num_images;
 	*descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
 	*descriptor_size = sizeof(*image_info);

-- 
2.46.0

