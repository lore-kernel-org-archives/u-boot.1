Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6E22C3DA5D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jul 2024 12:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1143488BC0;
	Fri, 19 Jul 2024 14:43:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PVz6kVYi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAA3588BB8; Fri, 19 Jul 2024 14:43:52 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9498887CE
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 14:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-52ea0f18500so1620852e87.3
 for <u-boot@lists.denx.de>; Fri, 19 Jul 2024 05:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721393030; x=1721997830; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=exuUqCZhdw0E2T7u3FlM18c6PlVREGJqtpCJYiJqOKI=;
 b=PVz6kVYio0GjptUk4vI96nCk6dcAuTYdQKCKxFXUv+MuRj6sW/VQkvk5Bt6niWUGWa
 VQS/Hm5lAktlf4Dmq7qDz4TFMaXrYgVr18KwcMwDpjACPcVTno5UtJUGM1aIYbnUdvzT
 pnm7SJ5BKGaR2lIHWzaUgD7L9bE+bUNye60N7g04mhMmDe5PFgkuszbxX85CBmQpavQI
 1f9isRX9chGZVXv31ZK99r6fzreaCwd+iddE06yIu4jja46MbOFi7VSaSYj187Eocmow
 te/Tpzq9ri0tHWeNeGxZvcLMvnnrTS+3IddG8DA2Q9ixvP2X2IKhJW+OhYBE6ll6gR8J
 v6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721393030; x=1721997830;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=exuUqCZhdw0E2T7u3FlM18c6PlVREGJqtpCJYiJqOKI=;
 b=ewLmI+qylWfzbEnkO/FS2p6BmaBbzpdrygaVp6RCKNtzk8LR1ue49CNLxfetYPBqAx
 uwg9E2X+atklgRTszot2XE76/VA6Zkd2AkDvEBqxb5IjiUrNLjSzXVV4zjO7jkYCW7Eb
 qCqKHBBpgLGU8lcuhrW9bazLvHAO+DVv2k1WYQW8xMBUOWQ6AOQh9MujsFie2KY4F0Eb
 U6yRaGyHR2+qgzuTy9LJxF4z84QWt6cWaYLrAuNNuJ7W+W3V5xyV+EOjW3p+U9rnnTBK
 f4hDGiGU9vTugTqU/8SMAG4/wGLPU8JSxOAMycvTtW2+GiFpwP/mhePa6Vj5SvfhVYjf
 gUxQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYOrjMIUCZ/ujyYrbZvsT8FjVMqxtqcypWQXTJIkc1cHh5wXn+p1W0Pq+VzYYQ0zekPtZ0xAt9L4YPYLVPr1a8Y99P3A==
X-Gm-Message-State: AOJu0YzEdy+fqf305GihZFUAOkRO18AnoqsEUWmq4iml2AilAHGd+3vK
 CLOP6iGD/IChuLu1X216ok94HZODxTHwD1Nbi9CFM44nK9T4PIBbG31Oq5cNFiQ=
X-Google-Smtp-Source: AGHT+IFXZ2AC9LWf0iSv+5rRwf0IzYlV69uRMXpqA2wpad+V+SlcCmkjWY5vHjFt36pAFHGAfrYPUA==
X-Received: by 2002:a05:6512:2247:b0:52e:9b4f:cfdc with SMTP id
 2adb3069b0e04-52ee53bd259mr5445868e87.26.1721393030158; 
 Fri, 19 Jul 2024 05:43:50 -0700 (PDT)
Received: from [192.168.2.172] ([90.187.152.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c785e97sm28577466b.39.2024.07.19.05.43.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jul 2024 05:43:49 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 19 Jul 2024 14:43:43 +0200
Subject: [PATCH v5 03/11] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-b4-dynamic-uuid-v5-3-8a83de3fe3dc@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4574;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=vORDiZ07Z5TkZufbWhFIR52ZdH7ILrIzNN1l2jnt5D4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmml+A0NbdiAFHtsFjsP0l4pOhItUlYV5xtXvNL
 tfQazksCheJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZppfgAAKCRAFgzErGV9k
 tgpvD/0bNDa/0RfNvaS/jsmv9gAmrlXQhqFKLc9ZZYfAZtlBaMloYrhozVw++5HmpjFvcnbLtxO
 E/eyk0IE+O3Hoq7wYqBNxirHnkOwXl35qiQggW9JCS/RnbonR8gu5VXXioriGel69I7+xtzjivJ
 rDFNZvEUVqBaVHRN4eCzUz1qgXUg82fREaxllBgWRDZRTeUuYQdJFjC5nTfE3DLR9jbtBhdNMJF
 6R1VDkGGDHKeHPTmbhYTl/z/okUczkyZoBngDkTAQCjZpHZo4wD/qQLyPHLB94raHxgu9b7DZwu
 ZQiYpceVOcQptqpO3z/dRAQ1T6N6qcYkao3Gur/rEyLK4RmqWOzhsNeqIeDqRUx5B71et6JweqL
 /7Ks/1otEYhtxcKc9qRoD0WAqt7ZxUMk4XWbQRqwk8PXlheJ0USQKRFF0qnk1pE/sisanRNTnbp
 91G+mWtW6ec+z2kzw+wc3kR02G/rW8GvfIOkkGNz/BrM0IO4oChQ3qQM4WYfTznNAVjDcFcJy/F
 ZUJWJfpgdrnBptoqjf+/tlJN+O8w3531XZDU1OQ7RYQXcQ4uA96nVGVYtZYsGEIStdckWhvgTbf
 MxmkCFPBKej7KMg6gGiEwjuN38c8ohPn8qEFw8fmZplDkyZp+gywYAEgJLxE9zvncRjBwqR9f7a
 iYNiSdvKvA7YoKw==
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

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 lib/efi_loader/Kconfig        | 12 ++++++++++
 lib/efi_loader/efi_capsule.c  |  1 +
 lib/efi_loader/efi_firmware.c | 52 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 2fb24d7af9a4..4735f877c709 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -235,8 +235,20 @@ config EFI_CAPSULE_ON_DISK_EARLY
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
index ba5aba098c0f..81d060b47a34 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -244,8 +244,57 @@ void efi_firmware_fill_version_info(struct efi_firmware_image_descriptor *image_
 
 	free(var_state);
 }
 
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
+	ret = uuid_str_to_bin(CONFIG_EFI_CAPSULE_NAMESPACE_GUID,
+			(unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
+	if (ret) {
+		log_debug("%s: EFI_CAPSULE_NAMESPACE_GUID is invalid: %d\n", __func__, ret);
+		return EFI_UNSUPPORTED;
+	}
+
+	compatible = ofnode_read_string(ofnode_root(), "compatible");
+	if (!compatible) {
+		log_debug("%s: model or compatible not defined\n", __func__);
+		return EFI_UNSUPPORTED;
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
@@ -282,8 +331,11 @@ static efi_status_t efi_fill_image_desc_array(
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
2.45.2

