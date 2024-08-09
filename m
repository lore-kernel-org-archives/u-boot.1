Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55139C52D7B
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 00:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E30988BF9;
	Fri,  9 Aug 2024 02:56:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LJb6jb/y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A099B88BB0; Fri,  9 Aug 2024 02:56:36 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914D688B63
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 02:56:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5af326eddb2so4279780a12.1
 for <u-boot@lists.denx.de>; Thu, 08 Aug 2024 17:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723164994; x=1723769794; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gIscCG1WFbxRNqwDTcTD0Z+2J8C6jKPkaxE8BsmFV/U=;
 b=LJb6jb/y572R89DpTiN4DrB1+eiImxCcqwf138vhY36eQ4vm/1thN12oM9LmI2cFqd
 VU65bNEKe9WLA4vFkSxOAimRDw+ZzGjWdr7uoIXksjXP7UvIKXFF0Bnw69k5vxXkg+UC
 j1ySnXoViH2wtAAMzp1LUryJzVV6/c1mXyuvYwgXqQWs/CJTMBvhfQA97KkgcTzhUF6e
 gdKoCvFLWSKhcXK45CjDIBKC28jsVpO1ooCz2hujyPMuQkYXvdZaiCd1b6t8DgzXRCXZ
 YI2FL1zVSE+El9v246xejFIN1iFEUrrxhd4ZNx/keQHhmFPjp3BqxH+EqbrGggXINqWH
 G9YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723164994; x=1723769794;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gIscCG1WFbxRNqwDTcTD0Z+2J8C6jKPkaxE8BsmFV/U=;
 b=GAKFLOOLajV7APlVXxeczBTLwCGK6vUOn0/GrXw+cfIw21JiIlgI67WEyzVtA0hdM8
 4mjfkAh0Itak08JUoqeMwV7zYL6VvHy/pbnQgSHruq/d/YmFdKY06Yf1LDh+rd/tqihb
 x3QJkjzUa4FI7iLScVI7fQmYVUeND25rbq/QyuIOoLGrGRjYPM4VUT1YpalW4W2qjon/
 Me60E9TuZLrnvNyyMR6KfVadRKPhGRN8dvVXMHatn4K1IDrvHajl1uS/puLgHy+pyfsm
 7mjsCwyaSPu5WArpr/qiF6m3BXV5wAzq57UaG8mVrDPkMt68YNt4HqauCp/L2naokovj
 Jj6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRcCUscOOv/0zq3G/ucHz4n5FsrJx/E4mh76+bmtorRVHFCySGUoTcSzR76lpiw/EeZbb6e4TrOWukRHnHHFSEikveRg==
X-Gm-Message-State: AOJu0Yys/wCIRlLuiRCnlwWymkZuBoxCBZ/8inLepVi2qkPxz94cMrMz
 962JSTrAI4nIhfWV3WhUQx/E+ZxW+IckTs7J7cMgN927u3hBFXDFOzZZDgVwtig=
X-Google-Smtp-Source: AGHT+IGVFy0+/VbAnNgFNhNl/Rq4fnC48NKACNwGhjbGMgjTq4iqM58CG2+ru7Ar0ehoHfPmNZADLQ==
X-Received: by 2002:a17:907:7256:b0:a75:7a8:d70c with SMTP id
 a640c23a62f3a-a8091ed6f3fmr286400766b.4.1723164993903; 
 Thu, 08 Aug 2024 17:56:33 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::7424])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9e80e54sm790680266b.167.2024.08.08.17.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 17:56:33 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 09 Aug 2024 02:56:22 +0200
Subject: [PATCH v7 03/11] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240809-b4-dynamic-uuid-v7-3-8c44ab1f06a5@linaro.org>
References: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
In-Reply-To: <20240809-b4-dynamic-uuid-v7-0-8c44ab1f06a5@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmtWk8BkA+Mppo3GlXF9wXF5Dn6AfCgkUr+PptN
 hu/l7zmeYqJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZrVpPAAKCRAFgzErGV9k
 tgCpEACX6GiLo50bdnhmVX4Qo6gBoICTXVbHGE8D6c8x0dK0/BCBze9dIfQ2FRLWKaTlmizPnqK
 LhFuj7K1bwu6ta89N7CgiPpv/Rx3nFpe2x7wHwUbSj2i3/1NQKyqayderYJI6wfl9AZwMmqOqEz
 irZKJWiSh5qISIwcn89zsdGyD8rT3j5koV5BAwswvJr81PunbYbDLDICE639zE1xX23bOJERJh6
 w1NX7zwX3R4IRJEz3qtombFk+16JR8DlUZtm8I1xBd62Qml0fqPqZtYVQeEZcjbYUtACUQ9mISB
 82UpUDL0GX+j/ZMtmhXuHNJybOgWjLq/AatKxjh15nTMvbfnVwYCdNHX5ayT8/kIGQsIIc9CtuW
 aEA9BFwnxtkaBuxp5RTdZRGrIJbD2rsTDydmnARgU0fMYK/h9dinYlhnJXyquJU+1YC4lExh8GP
 LLLGilL0RufUBWmN4mD/lciQG2SeNZQpbHqEqiR1+plBG6Sk2BENIYUEgh6t06pTH6H7lzAF1oh
 q0OsjkX5u7MpobgD+Nwgza17q81HOlQJDclRVnqPbsIg7I8QuHqDup1ztbMqB6NRpy3fZdQJyOv
 dFf3YMOPpfuVbgeA2oAAQV07A+WnGxD2QzJxI/LBU/eCkkXMeNHZLPk9AUFfFp9IEvCJY6woFcD
 vOmUzqwEFKv9V7g==
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

