Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C484C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 13:31:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEDDC8871C;
	Tue,  2 Jul 2024 15:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qbpPb/Ce";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7079188718; Tue,  2 Jul 2024 15:30:50 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62731880AE
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 15:30:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a732cb4ea31so547549166b.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 06:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719927048; x=1720531848; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fr1+sdiguyvehnp+x8gS3zldozFZxVm6TZIi52bVPcg=;
 b=qbpPb/CeeZRfU1ZwpdkZS4Fta8MmLcM1A+8p4icDxNgLBUnJo1aT6PwTotIgSmMYPO
 ZuK2CGPt2s8PizOyOS4FjRdnXIKVEiW4obTkc0h5K6pGWB90V2IoUt+qUZAqyaNm4ivE
 nCzFk4jQrbEfKprk2dtEv+3ihk4Ux7ZqlamtMMkni1+t4CZg7ysaoKepN75rZ1rSSIGK
 z2kwarVw3SnJBP/O5DCzRS6tFnwBJdaQQwEFAycaXgztr41Fy/iejW4wi81+OhLQO5bm
 Wj21KiEU8unkRIwcAq2PPVAhvVWCkNoUJZqvh3jC9cYSGoL7IRD25rbagjRtpqf9bPwU
 udZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719927048; x=1720531848;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fr1+sdiguyvehnp+x8gS3zldozFZxVm6TZIi52bVPcg=;
 b=eJZy9KlQXrNxSb3oD0qoZ8c86cqf2Kjn1pc+kPsbPNFvXDvuDE7ltdZqH+X//ylc8T
 oG8WBx6uILIevLfCOEUUBZgbwPAKXYwooGKrgyJXAjLa/ybYXxzRtsMqE+txr+J6COO1
 ElJm25B9LlbmayLtxpHu0A+LIReD2LEcMoW1E1rWbMtM7KZvBmBsRt9BlpxMQ6Lvqr1j
 CpAqO29NKTzaGuweUZaFtb86DdvRahttXZGNDcqrHUej3yrxwyttEAkok7oLfLUAsHkV
 kkbEjNc6qj4dFaAtJY5gq+sf7ZBM2aPE0Hhji+a5vHtJL8KlNK+sl6pUe9pe5xwmLTML
 ve7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8axOxash4ZuHLFwuQz2ZPj06UXatuGcDc6YHGnambIg4Hwi9Iat1CB/c2hGA5yQtRDqcTtT/hRBIwb4odwzzkWdjSXQ==
X-Gm-Message-State: AOJu0YwNRLszpu1PHRzzgIo7q1oCZmGcZFNk6wIR59wRKCuPveGV8jt5
 XAMiZ+Js2qlxacIBeX1Qhqs6e4JFm1PZgzrJ9UVDxl68XPuEJJXHKPLoRW2i3aQ=
X-Google-Smtp-Source: AGHT+IE/xRqHzFKycU1T2o3XPa5n+mSnw9L03fRoyOiPP4MHlcJ/hudeW6w1ATjGv7oWyEgb0sI2RA==
X-Received: by 2002:a17:906:4895:b0:a6f:e8a5:e8a6 with SMTP id
 a640c23a62f3a-a72aefa6328mr790106666b.23.1719927047883; 
 Tue, 02 Jul 2024 06:30:47 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7430367d55sm323796166b.87.2024.07.02.06.30.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 06:30:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 02 Jul 2024 15:30:43 +0200
Subject: [PATCH v4 03/10] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-b4-dynamic-uuid-v4-3-a00c82d1f504@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4574;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=RBdJ7tsK8WK1Ra3J+ekcIQtZPMkLTswbLk0/LMsw0uY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmhAECiNE8KaWv/+g45BiPeLreptCa3qHKVUYDQ
 fl/YpFwXiuJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZoQBAgAKCRAFgzErGV9k
 tgB4D/0UL5H5zYAcpIRKdWwTk6UKh6KXZD5h82X/mv8SWnOC7IYMJFQz+ngoB1PVoJC/Cfg+JPL
 gnrcCG3cY2xXuldw11/jeVLHT4aAbTibByAFxBAmO5FNIEhxWjp39Z/aa8DE8GoDosSe15NdzJV
 paQLtJtWegkhdXKOE+SODryZzdfYXoIdHiYLXLZtAgoyzaCo6960+eq+j3c1DjSkJPtFkqd0tUX
 q5ACJZRH2w7StJh2TBSMml8yWmLMDEIRTMKeunkBOkShwO6mk5Lh1UTW/ZbWNXXvTz/S9XE0J+1
 yOQADs1sCz8axX4bvMcU2lty0RMsqovbnsMnZFpYasfXbbi2uiMxg3uSYP+dXy32XjnnkOS0l7n
 F7yTkDqNSJm7oMY2BRsc1r2O0BJFEzspxgHMwuCZRcP1otSFR8ue6xvo57tcpwYpVP0URNhs3dJ
 l3BqCqQxurDnaxtS4xChhpjlJ8yxKYkwfc2RIjkt7IFQaKDtHjT/MaznizXeqo0tkWStlrPXfRr
 RMkSMo0Kx54k/9U/x/Sp+XcSddD++DfrX0SuY5k33zkKW/DhnCtO7EexiM8m2GazyRHQ8bbe3dB
 RG1MvzerG66TaPgBxEuQmRWZ7dKITIRgg9NVJioaF4tUaqpuI347lbYYW0P5sedBf66geYTWq27
 20bqd386hcyR+OQ==
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
index 430bb7f0f7dc..9553520c6bba 100644
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

