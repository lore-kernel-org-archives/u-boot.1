Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440ADC25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0F0688625;
	Wed, 29 May 2024 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MR7TplxA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE48B88629; Wed, 29 May 2024 16:49:04 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FE2D88623
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-57a034697fbso1258489a12.0
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 07:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716994142; x=1717598942; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Y28ZRmJZXP44Z5xd4CjT1ucROldm5l5ZmxQKzCTuTk=;
 b=MR7TplxAbktkWbXfWSpf8iM7XTBThJJ16Vy4KdFonTF3gsxLdJl9Vn3am9BbL7CIqn
 znyAexI/spduom28TJOLrAUTQ2K4vZvM+shZVwc5+oUnk4XpbbAumouyADSVa/mFU6RI
 Zj142r7mHVJD9cNXkMDRibQ7Z25NB9KT/FiPS1AW9CsKLPl5dLYROzTiIArAEzIg9bi/
 GIDkL6b4QJVZFuJSLngy3Jc/C0jWioqwmhbzAujNRCwEp1P+CNWj0/mx8O1kHN9kAzrt
 YjLRO58ZZhdOmDCjd+2rge4oYYqPrmzSzZoliMjA/gdNasnNIDeqWaqhgggfUzlAsy11
 +MDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716994142; x=1717598942;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y28ZRmJZXP44Z5xd4CjT1ucROldm5l5ZmxQKzCTuTk=;
 b=cAAOLQlrg78bCXj6rs4qBF/F/D5SK7mXQbtc2WKyTbNa54/WnQliIw5muEPwJJXVUx
 DHNXEhFDBQxnkdhv14YF5fwuqzQZsVIY+9eOqRX20gpmIQtztGnpqxC2FVQOljhj9Vfx
 GcP2s6VtQs7jAEZ1Cju9ITUyRe+MNNkCh0GANj4VPNFYtNvqYQwCkavUTo03AxJpoB7Z
 2u5BsFhdTBQqc45B6JaZ4zU54TDF9wRdkr+7yewkntgxHXyl8blubXuJi9PUr/J4Mf2z
 lbsX56K+qA0KWDYM1EONRRfxsmWYzR3mZYGAaFZnoGUKQFJGM6Bl+mO8CRkxzfNF6yeJ
 F08g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2RJkj936TqtP3xb/FUH3h+7qDomuyNUzFspNkOr55z1UOr0zCXONKrQpnwyaYSF3RTVbUqsUnBgcjYxiMBjXuM6eTJA==
X-Gm-Message-State: AOJu0YwINeGCaSRz2vciLUBOJ+oVwOGn7aaYyzNfz7qhd79IFYTRCsLi
 Bj/gSiYEEZgifLRrCO8j7PIIMd4LMG1r2DaekTdLg8FVsPqRzGVIzDbz4JVwnm8=
X-Google-Smtp-Source: AGHT+IGe82rCXWGm0tp46yzI2OjdEd0p4WQDJ6+FgFd8XbN+V3tTFB+NuwbbNLXg+gyPesRDzlI5SA==
X-Received: by 2002:a50:8d53:0:b0:578:6536:481e with SMTP id
 4fb4d7f45d1cf-578653648d6mr8319422a12.30.1716994142012; 
 Wed, 29 May 2024 07:49:02 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8bb3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-578638009b1sm6922029a12.17.2024.05.29.07.49.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 07:49:01 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Wed, 29 May 2024 16:48:51 +0200
Subject: [PATCH v2 2/7] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240529-b4-dynamic-uuid-v2-2-c26f31057bbe@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5425;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=ihik6rOObYTcfAQqc+c7iPdePVxUCgEjrkSBDa9glj8=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmV0Ba6BUNi7Rzilov7q5UMY2a5pq0ADtzlK4Bb
 ktF+D7Kc2WJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZldAWgAKCRAFgzErGV9k
 tgbRD/0WCwNjwEYcpD6BzXRY0G14NO3gPrZ9DvuYj647kctRWqKMB6SvpsyQbhr7Bt2c2vx3Z9d
 j2QP6ysxAksVlkw4YUY0Vbha51eE0zp4gAIVxo0B5yFBSFX780YNGKnwCkcM8GsAIt3M/08Xu6O
 uJ5eDJ+FZVZewSLnNMAiSZF+SvIgW+J4FGv5h1kayYrmOPYQZ/PPXYJ3PjnMOLmElUCLCCRVr6i
 cvnMcGpuyVzs+2ztMT3VTtH/tCfUz/8bIJNxZdgRgmEzZvaeIqtNydd4P11MX/5dyxg1+GOfvhZ
 lojYGqSGeWVytUUGruV4xYi+Q6L/5wOEO8STykLhX6XZTQVNgumx8VOtVt61983yh8OBD5GkOet
 WAbJpbVaXQEdM+Q7G1uIIG4KvwHdonPco9gG9rI/u/b68aHYn6HSwKIqgNswqD4UOIExiRSPASX
 yhPuUil+ylJs5vriArk6MwmgftfB8IR7sQ3Yrvx8Xlt8+v0ihv8GjCvd9LuqoZli8HxFAMQZzIB
 X1sx47rou7xl9kWz2G7Vq2cMcL2X/S2xF4O71uFqW90z41n9AQ18yOZkoDqCJFInMEw2IehrBXd
 hfGUDRWht5jsj2z7LTDII0Vafhr4nKQNsN3vWR6PHn2EprtVnCyTZoar78kfTRoKySovSXEt1vG
 lskda3n0WdlHC9w==
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

This is behind an additional config option as it depends on V5 UUIDs and
the SHA1 implementation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi_loader/Kconfig        | 23 +++++++++++++++
 lib/efi_loader/efi_capsule.c  |  1 +
 lib/efi_loader/efi_firmware.c | 66 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..e90caf4f8e14 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -235,8 +235,31 @@ config EFI_CAPSULE_ON_DISK_EARLY
 	  If this option is enabled, capsules will be enforced to be
 	  executed as part of U-Boot initialisation so that they will
 	  surely take place whatever is set to distro_bootcmd.
 
+config EFI_CAPSULE_DYNAMIC_UUIDS
+	bool "Dynamic UUIDs for capsules"
+	depends on EFI_HAVE_CAPSULE_SUPPORT
+	select UUID_GEN_V5
+	help
+	  Select this option if you want to use dynamically generated v5
+	  UUIDs for your board. To make use of this feature, your board
+	  code should call efi_capsule_update_info_gen_ids() with a seed
+	  UUID to generate the image_type_id field for each fw_image.
+
+	  The CapsuleUpdate payloads are expected to generate matching UUIDs
+	  using the same scheme.
+
+config EFI_CAPSULE_NAMESPACE_UUID
+	string "Namespace UUID for dynamic UUIDs"
+	depends on EFI_CAPSULE_DYNAMIC_UUIDS
+	help
+	  Define the namespace or "salt" UUID used to generate the per-image
+	  UUIDs. This should be a UUID in the standard 8-4-4-4-12 format.
+
+	  Device vendors are expected to generate their own namespace UUID
+	  to avoid conflicts with existing products.
+
 config EFI_CAPSULE_FIRMWARE
 	bool
 
 config EFI_CAPSULE_FIRMWARE_MANAGEMENT
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index 0937800e588f..ac02e79ae7d8 100644
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
index ba5aba098c0f..a8dafe4f01a5 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -244,8 +244,71 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
 	free(var_state);
 }
 
+#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
+/**
+ * efi_capsule_update_info_gen_ids - generate GUIDs for the images
+ *
+ * Generate the image_type_id for each image in the update_info.images array
+ * using the first compatible from the device tree and a salt
+ * UUID defined at build time.
+ *
+ * Returns:		status code
+ */
+static efi_status_t efi_capsule_update_info_gen_ids(void)
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
+	ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_UUID,
+			(unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
+	if (ret) {
+		log_debug("%s: CONFIG_EFI_CAPSULE_NAMESPACE_UUID is invalid: %d\n", __func__, ret);
+		return EFI_UNSUPPORTED;
+	}
+
+	compatible = ofnode_read_string(ofnode_root(), "compatible");
+
+	if (!compatible) {
+		log_debug("%s: model or compatible not defined\n", __func__);
+		return EFI_UNSUPPORTED;
+	}
+
+	if (!update_info.num_images) {
+		log_debug("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
+		return -ENODATA;
+	}
+
+	for (i = 0; i < update_info.num_images; i++) {
+		gen_uuid_v5(&namespace,
+			    (struct uuid *)&fw_array[i].image_type_id,
+			    compatible, strlen(compatible),
+			    fw_array[i].fw_name, u16_strsize(fw_array[i].fw_name)
+				- sizeof(uint16_t),
+			    NULL);
+
+		log_debug("Image %ls UUID %pUs\n", fw_array[i].fw_name,
+			  &fw_array[i].image_type_id);
+	}
+
+	return EFI_SUCCESS;
+}
+#else
+static efi_status_t efi_capsule_update_info_gen_ids(void)
+{
+	return EFI_SUCCESS;
+}
+#endif
+
 /**
  * efi_fill_image_desc_array - populate image descriptor array
  * @image_info_size:		Size of @image_info
  * @image_info:			Image information
@@ -282,8 +345,11 @@ static efi_status_t efi_fill_image_desc_array(
 		return EFI_BUFFER_TOO_SMALL;
 	}
 	*image_info_size = total_size;
 
+	if (efi_capsule_update_info_gen_ids() != EFI_SUCCESS)
+		return EFI_UNSUPPORTED;
+
 	fw_array = update_info.images;
 	*descriptor_count = update_info.num_images;
 	*descriptor_version = EFI_FIRMWARE_IMAGE_DESCRIPTOR_VERSION;
 	*descriptor_size = sizeof(*image_info);

-- 
2.45.0

