Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C86C25B7E
	for <u-boot@archiver.kernel.org>; Fri, 31 May 2024 13:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5AAEB887B5;
	Fri, 31 May 2024 15:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="a9rz9r/z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3942E887B2; Fri, 31 May 2024 15:50:51 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D85488878B
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 15:50:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a6265d3ba8fso190300666b.0
 for <u-boot@lists.denx.de>; Fri, 31 May 2024 06:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717163448; x=1717768248; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1Y28ZRmJZXP44Z5xd4CjT1ucROldm5l5ZmxQKzCTuTk=;
 b=a9rz9r/zQnUJgUL9IWuruECM92cdP5pbmNr/Dlycy5/gwPkGRBFyOUypYId5kfTuw0
 ZQTlgcxbj4a5ZnKFvbB7RQEsUG1xtq4M3Qfyb32+NpazB1jNW75yKsUc6BQC6tnXvKek
 6Umvq1dxvjtxiYyX0JVf2aBHWl4FY7GGj3BuqJFnRKM9SwTkgzrnSaNKTltC8+inqxrl
 s8eC31vWocyhcEBwVou9oWpDhQ1AyeL4IORgfCF5PuZe3gz5fu/NbtanZt54r89own2u
 59C7AanMQUbRNbrM+pmrWlKBf4C7PJDqcJboXb/TAyM8wbZ54jpaT0TPxD8a7Uf0Zy2o
 IFuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717163448; x=1717768248;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Y28ZRmJZXP44Z5xd4CjT1ucROldm5l5ZmxQKzCTuTk=;
 b=jU7l9p43d2pkx3c18pQdzaKDeUUSuJaVybxnJeSt/cpZLxWaQZSE6rqtuN9qc2Mnxl
 4CTGjMkZGsA88KJGWJ9tSvuMY1AJ3LwsmKbz6Lj9PcIWgaVDE82GAYhdE+HCtZkFn8cf
 fDplQE7aCWRoiBMut8T1SQEknpolpfnMpe2g5LE/dzGlJeOq44KAw+5wXK3MqZG2DVeB
 24ccrXJum97Ho08l4bYg+pQWUEn4m5UORXARXOxdMy2jzPIwhg9uC28TM9KQ82gNDhTZ
 LGyjO+2MtkrJ83hoyEwrNdldM5Si8N0uVs2QedYWbqTpX4CEhqDJliORwTAOwoAVPzMS
 BCuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIm61wNfqTYcwsTfSUFYQ8yFgQtqo/vKjYmmoP8+WeekDs0VuSgAJFUxD2IQd4dote7tINfhgnwqyPyKWGsLyW8v1pew==
X-Gm-Message-State: AOJu0YzHAOX8grOHzpuFXd1vrueQOGd8gg6lVWJWXp7GGn7cPvYx3b5r
 gjtOWAJaTcw4vTEVsbe2WWACJdsYj/bnPdtAeHcrlfmeNWhN3thhzY5dlcg/Olw=
X-Google-Smtp-Source: AGHT+IGY3C90JhWDcKc4AJW8n9nxI+hfDLmgYZJ01kldETdfMv+WT60h9Cr2S9RtjruFX97u5BeRzw==
X-Received: by 2002:a17:906:1911:b0:a68:9086:cbdf with SMTP id
 a640c23a62f3a-a689086cc6amr59200666b.40.1717163448216; 
 Fri, 31 May 2024 06:50:48 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::8090])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a67eab84a99sm89442866b.143.2024.05.31.06.50.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 06:50:47 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 31 May 2024 15:50:36 +0200
Subject: [PATCH v3 2/7] efi: add a helper to generate dynamic UUIDs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240531-b4-dynamic-uuid-v3-2-ca4a4865db00@linaro.org>
References: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
In-Reply-To: <20240531-b4-dynamic-uuid-v3-0-ca4a4865db00@linaro.org>
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
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmWdWzkkCxI0Kd7jKogoqhUuysy8Am5n0P9sTS7
 0anfDect2+JAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZlnVswAKCRAFgzErGV9k
 tqESD/9xe0eZIfnRPO82r5jxBF62DTS4qHcFWypxkE7IUo2LqZXkeizpbc1m9zkv6Tm2SwK3qzT
 ssDVjXlk/lEqTNs7KXTwY0G/WddLlINqgNZBNdvg4nNb7mEAKVJNKrQxzarsPjneIdDbsCN0jV2
 O5TCL5rxruB6IjqGNLovMVGo5j/mZEHNqQEFcKp5KR2cxhSia9nWPUt8UJo1cL5TLpUcB1gfh+G
 lnyBct/6QRVIu11NfX00gomr9EBtd+U9A92dtZS9anxq+ReKYlViMwxe++xNgfG1A5d0a7h2N6c
 C8CD+G/Xbj6FXSQY9DwjVAKsG8AkKG4hEZXVZRFTP7gBRnUw5IeAVhXo2bp1Yl+eVjCE4nR4eJe
 oPjBdNcMpHfAcDyce7JL9MePTmS0PSdV+TMdSycfb/gr5pBUc21ihc4zNwye87sgZ1I7YGdyACr
 nCKYVdlCzdN7rMe6nF8OJFl7LNxL+IBGNlT5wjmAgkLK0i178H+AfL28cEi+a69WeofsCVzEkcm
 L4A2lm5OjB1NLJeR9DVtXPHP1Zm4Kc3QSqtAHwurdJBdiLCJk3LxIQ/t3HPz5GtOsqajZt2GMqX
 zrBOWpcR2/xGFiylk2SNCguF7lc2jIbc4rkBE40I7IJO0KmQTpnZP8qTaAb8iZxEVl0zZ2HkJ+O
 CPLNocn+C8x0H7w==
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

