Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B69C52D7B
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 16:23:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 719F988BAB;
	Thu,  8 Aug 2024 18:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gvIVeK/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6BD588B9E; Thu,  8 Aug 2024 18:22:00 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8045A88BB6
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 18:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5b9d48d1456so1856358a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 09:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723134117; x=1723738917; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gIscCG1WFbxRNqwDTcTD0Z+2J8C6jKPkaxE8BsmFV/U=;
 b=gvIVeK/jT6vYtkZvJ26wAxPPE58PWnH2qXJ8aEsRUdmadB/GSVryKzelqh4VrH8ttI
 6Gvqxinf+qX6O9wtyrmj+jhRFMc1LjtlKMnW2fP2wiW+Mz/veeKYfbCcCVS0kLy02455
 fcZDup9nFp2vxOppOMv1esYSK5pYwAFzE+pvRoZZRFFdbcnpkbrcujpBXj2pCQzXqDv6
 v/bEdzum78RDoN6tRsbqFOklp3D0Fy040tcyzfDWqGZ1//5VpMRHhMcL1KxGUnJUQwPZ
 ZJdP0qtEuM7I2SUTl62h4sTi5WjJwJ9EbGaPk/dLzDi9R4juM+J47uKBJj11flQKmQEv
 409g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723134117; x=1723738917;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIscCG1WFbxRNqwDTcTD0Z+2J8C6jKPkaxE8BsmFV/U=;
 b=rYq1+VwXDMauB/SEt03ctB8PZ3T3zsSbzNbrBygtpbWU3CkbWhCOsKjjuXrXxJdSyP
 J/Vk/usVekBjnswhPuRSmWe3ClRM7/EUtD/vA9rgz1AvhlXriPazoRv/RpCZox0Pnlp4
 A0fU1OjFusw/asn4Kmecrmzy2g/R/XRSp4gKOv7jTkQtBSqAMT3rZBzLIrN/bldB80ZI
 ZnmFL87Z/0f1e/fvxN2SHTLFcDMswy89/A7UAJZOMaAUK9Ak76rycJJNl+Herg34PQ65
 oIXOykVs2CuuTmf3qr7tECDAy+ag2wikBVWiuKNjq1rsjV0+tIop4p5LBu/6LeSQ6Lqq
 bGgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVP2o+CTh54bczCP9gyaBNQtu+KlG6mYz0vMxsJbXtLnn7Wy+xpoiYhIOnopdkAEYSf5zlIAw=@lists.denx.de
X-Gm-Message-State: AOJu0YxbtYbJED5lr+gIW5hhIMz3vnxQLPEQaAa0YOh841GjRnSSRfTS
 X1y0sB4bE9mnJG+OQ8a5qusQV1ORyLecz7CElCnzjJcEY9/TMzlBbZcsw5OjKn8=
X-Google-Smtp-Source: AGHT+IEKHuTEdkgsrSH0A5UUuseVYaiHDa8YN8tfck9lbzfxa5JDl0V3MCfTL7ljP+HsCCKnl8IYqw==
X-Received: by 2002:a05:6402:40cf:b0:5b8:4824:be62 with SMTP id
 4fb4d7f45d1cf-5bbb39cd56fmr2066935a12.0.1723134116904; 
 Thu, 08 Aug 2024 09:21:56 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5bbb2e5c8fbsm812351a12.79.2024.08.08.09.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 09:21:56 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 08 Aug 2024 18:21:50 +0200
Subject: [PATCH v6 03/11] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240808-b4-dynamic-uuid-v6-3-9332e7237119@linaro.org>
References: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
In-Reply-To: <20240808-b4-dynamic-uuid-v6-0-9332e7237119@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Mario Six <mario.six@gdsys.cc>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Richard Hughes <hughsient@gmail.com>, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4865;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dusThMI9yKohZk7FRpXJrRXE4relVzw/dtal3KcFB+4=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtPCeQKczt29DUQSko+czuUwPWncGANWS6LfCq
 RkNEkxASciJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrTwngAKCRAFgzErGV9k
 tuR3D/98iGE3u+e8ziOcqfGVVCwudWSbHVmblNk/nhz+wkSd5qotVEl+3bFcGHmCbfaLLahmXQt
 S44IZqFHXUhkSmyw6qdW6VZ6zpCi3IaIgRHRTfIWwltgghzqZxbJAYF2FRuq0/tNIcfs7//EOfo
 NDY6nukzbkd8mnhXBws6xljxemFIYahc1xENFCwZb25gP+67C+uyFA9+z6mR12oqK6j2/5iSYaA
 L+WZfeMkAg4DgmbWdjcgG2dCCH8Cfuqv7aT4j24x+LoMXLKb92kJe9fHdW4WEDcZIhEpjcH1ihT
 hMbVCQLshqGMY/CMNDuRtj+eCZ1ANjK1HaY5EfdUhzIHJVQsJySo2VJW0UCPqoz4gUYcVq6NJr4
 g+IMr7j2mTwBGozT7kjGtjqRH5WiRMa0WvdFgK81ftRxW0LUfVhnHlXdDlTA30r56YY8mLVn2Cj
 o38L64uQb2IEVKK88TNrDw1USeT9PU8JJ/zs3TGhr1TfmM/q9JbBw0rGdkAG8SBmarSR9j1vjAF
 1+h6cBSOKnl2+qtKwMJWdsCoIF7RMEKKKkPgp3TbIMfmtXrxs9mG3eA/Vik/hpvk3sCt1UZIRA4
 BMFMqclYj4dR8euexAJZWtxBkX+cAuAxu0T0DpqcWdBCqYJ0vqaQWTWtpdOoDaTgM6yCkR88i4X
 Qim8+3MvqMK2VlA==
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
index ba5aba098c0f..c0240e95cf13 100644
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
+			(unsigned char *)&namespace, UUID_STR_FORMAT_GUID);
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

