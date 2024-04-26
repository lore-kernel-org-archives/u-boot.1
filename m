Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4029DC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 14:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E43F89175;
	Fri, 26 Apr 2024 16:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="um1UMJXD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0F908917E; Fri, 26 Apr 2024 16:19:47 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A6D089173
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 16:19:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-572347c2ba8so2545145a12.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714141184; x=1714745984; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I96UQMKCMZVk9G/+8NZaXHuNSujSrUJjsebt41L2Rkc=;
 b=um1UMJXD6a8mDKXiWGZohOYvidhjdZdIY5uK9zK2/u8/bnTSHH82FN4twYnbe978vc
 YGrlo9ZCaKBh+V14Wr3ubWLLO9r4RRuURJ4tkff0yeSStyckMS2zMcAS36L9Q65BHfWn
 Lwi7hCwIVCMJF8clw/S+0Aug6A1iuI5PdWYn9WxN5oRC7j6C6sabmAY7fH7+U3ZKiedS
 CCiGmFXbFlJTXUz2JA/JJmsWMEcxPUGmoVIs7kYkbUqOVCoTeDrQs0T4xbw+THvpzx4t
 gCjhrpmIvuyrc+pWc3cxqieC6A2JqOlwbsL1Y5J0hAfitC+vkJ9+6FFdJyXxJ8ZjzCdj
 hnNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714141184; x=1714745984;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I96UQMKCMZVk9G/+8NZaXHuNSujSrUJjsebt41L2Rkc=;
 b=EKvD1Zj7YamHFY0RPLJbcegpQhhcPLukDnd4XcRFXwgDU6pnVAx48/9WNOCrFLHUMM
 JXBW7q/V4G1huKkCohZiCYEdK//71+vKqlWTFoHTQQ2K2PiUq+Xs3L8rAkKS+yxSsHj0
 u2E6bCqUTNQJyVt5sIelHkNehYDxdZ4k3L8aRUai3q2mYFyMOZDKLq+Y2YugfPlZPDoP
 31IwIqyJipn9L5Nd5Bu/bP/lq5P/VKx17DHMjAMY43zs6zSuZ57WtI7YDOdYwf3NxATI
 UB95aeLvnRkLTVpJ5AeDs/mp94w8WNYfLDIytNdvEyRshy31Dg8erA9p7FDIXZLtKCDC
 /ZAw==
X-Gm-Message-State: AOJu0YxE4TK2rUT9GX6yc+nHItdj8OkwPC9ai0fvFUB2oE7t23oGnvuR
 TR+3b4k8CodQkpZ3LCjY8X9U1tpd8GfnPAOZjvviqcKOpzPE7G3CBA+cs3KVW3QzNdIVNe8r84l
 UpZoQ5Q==
X-Google-Smtp-Source: AGHT+IGWaGp/Ktf7UsRR2OjGsYW04Wll0cr+xl6DrU0PuDHXPqBreIYEtB+gXJGSMttDAqoqQXCjBQ==
X-Received: by 2002:a50:c049:0:b0:571:b9ac:ff3d with SMTP id
 u9-20020a50c049000000b00571b9acff3dmr1903100edd.4.1714141184729; 
 Fri, 26 Apr 2024 07:19:44 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::9b06])
 by smtp.gmail.com with ESMTPSA id
 ds2-20020a0564021cc200b0057059d26756sm10041182edb.76.2024.04.26.07.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 07:19:44 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 26 Apr 2024 16:19:36 +0200
Subject: [PATCH RFC 2/4] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240426-b4-dynamic-uuid-v1-2-e8154e00ec44@linaro.org>
References: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
In-Reply-To: <20240426-b4-dynamic-uuid-v1-0-e8154e00ec44@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Richard Hughes <hughsient@gmail.com>
Cc: u-boot@lists.denx.de, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5086;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=BZqycRWqMsd1O7DfnNQx1DsKBKBx7coL3xHbhjoYLhQ=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmK7f9AIoUrzKS6tMKURnTGxWyl/MxAjvmMwmAb
 OZG5uGfdYmJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZiu3/QAKCRAFgzErGV9k
 tq88D/0QM7HGqxnyM6gZGqDaDvJ/qi1JH/inwxF/55FP3N67WJi23Hi4Ocq4BdvJXYUq75ZTE4K
 ph2ZggF35qAWawIIBgYSBoQuxHBQj05eqa2vfUYY1EQEkS6QLepTwqkln4gqcIpnhdx7eFCL822
 YU8S0dqa3AJrb/PG1PnAqfnJI9AVIjZiQnJdSdP2ZJPVceAYnUKO0BVByFH3edFvAsFOd/Kh30f
 Ia1N4O+LAuWPjI+XE3LeTcOj4yskdwPATT3Ul3CTzqkSr3L3a2wPgjiD0HOP2dibcGpRkmMZ4sl
 tbLnkcgmay2wtgNEgbulLBo/xb8WPvGHVbWYHNFolz9AKOoPC3p4mktyGuWTx2FwCOn6ug1sZOM
 3Sjdl9DEGcuxntqZBepVgjPsvIFOibrGfo/ARR43yrVM45LVuOf3SH7VB4SvNKoe9O5GBzzD4yE
 toE9EamE7bOfAmj9OCDGhux44DhKuaxzPEoa5UgOTGCfmmIaM8D0K6AZRnfgAKOL/p77D0lERIS
 yFxyTYMYFQ1nBKvTQ45wkjbjEo7gAG+udnau8w99rGjEr2hJVojE8iHnzJoEmadir+ENHA994qd
 6FPQ+xK5hlc+ui24S94ZFeaLfaidFN+ayrvAfop3O92YmCsQDtGrHbq+hir6DPOmhIkoJCP9225
 YH1/XtMGHjP5dPw==
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

Introduce a new helper efi_capsule_update_info_gen_ids() which takes
several strings to identify the currently running board as well as a
platform specific salt UUID and uses this data to populate the capsule
update fw images image_type_id field. This allows for determinstic UUIDs
to be used that can scale to a large number of different boards and
board variants without the need to maintain a big list.

Generating capsule updates can be done using the same namespace, soc,
model, compatible, and fw_image name strings.

This is behind an additional config option as it depends on V5 UUIDs and
the SHA1 implementation.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/efi_loader.h         | 28 ++++++++++++++++++++++++++++
 lib/efi_loader/Kconfig       | 14 ++++++++++++++
 lib/efi_loader/efi_capsule.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+)

diff --git a/include/efi_loader.h b/include/efi_loader.h
index 69442f4e58de..7d6b6ff83229 100644
--- a/include/efi_loader.h
+++ b/include/efi_loader.h
@@ -1125,8 +1125,36 @@ struct efi_capsule_update_info {
 };
 
 extern struct efi_capsule_update_info update_info;
 
+#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
+/**
+ * efi_capsule_update_info_gen_ids - Generate image_type_id UUIDs
+ * for all firmware images based on a platform namespace UUID.
+ *
+ * @namespace: The arch/platform specific namespace salt. This should be
+ * hardcoded per platform and replaced by vendors.
+ * @soc: A string identifying the SoC used on this board.
+ * @model: The model string for the board.
+ * @compatible: The most specific (first) root compatible string.
+ *
+ * This can be called by board code to populate the image_type_id
+ * UUID fields deterministically based on the board's model. Allowing
+ * many boards to be supported without the need for a large hardcoded
+ * array of fw images. This works using v5 UUIDs.
+ */
+int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc,
+				    const char *model,
+				    const char *compatible);
+#else
+static inline int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc,
+						  const char *model,
+						  const char *compatible)
+{
+	return -ENOSYS;
+}
+#endif
+
 /**
  * Install the ESRT system table.
  *
  * Return:	status code
diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 430bb7f0f7dc..dd8fc1b08812 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -235,8 +235,22 @@ config EFI_CAPSULE_ON_DISK_EARLY
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
+
 config EFI_CAPSULE_FIRMWARE
 	bool
 
 config EFI_CAPSULE_FIRMWARE_MANAGEMENT
diff --git a/lib/efi_loader/efi_capsule.c b/lib/efi_loader/efi_capsule.c
index de0d49ebebda..9ef67d1b4405 100644
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
@@ -403,8 +404,40 @@ out:
 	return status;
 }
 #endif /* CONFIG_EFI_CAPSULE_AUTHENTICATE */
 
+#if CONFIG_IS_ENABLED(EFI_CAPSULE_DYNAMIC_UUIDS)
+int efi_capsule_update_info_gen_ids(efi_guid_t *namespace, const char *soc, const char *model, const char *compatible)
+{
+	int i;
+
+	if (!soc || !model || !compatible) {
+		log_err("%s: soc, model, or compatible not defined\n", __func__);
+		return -EINVAL;
+	}
+
+	if (!update_info.num_images) {
+		log_err("%s: no fw_images, make sure update_info.num_images is set\n", __func__);
+		return -ENODATA;
+	}
+
+	for (i = 0; i < update_info.num_images; i++) {
+		gen_uuid_v5((struct uuid*)namespace,
+			    (struct uuid *)&update_info.images[i].image_type_id,
+			    soc, strlen(soc),
+			    model, strlen(model),
+			    compatible, strlen(compatible),
+			    update_info.images[i].fw_name, u16_strlen(update_info.images[i].fw_name),
+			    NULL);
+
+		log_debug("Image %ls generated UUID %pUs\n", update_info.images[i].fw_name,
+			  &update_info.images[i].image_type_id);
+	}
+
+	return 0;
+}
+#endif
+
 static __maybe_unused bool fwu_empty_capsule(struct efi_capsule_header *capsule)
 {
 	return !guidcmp(&capsule->capsule_guid,
 			&fwu_guid_os_request_fw_revert) ||

-- 
2.44.0

