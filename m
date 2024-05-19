Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4812C25B78
	for <u-boot@archiver.kernel.org>; Sun, 19 May 2024 19:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B72AF87C83;
	Sun, 19 May 2024 21:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="noskCreg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D4E988093; Sun, 19 May 2024 21:19:13 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5115881EA
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 21:19:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r.stratiienko@gmail.com
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34d9c9f2cf0so1578805f8f.3
 for <u-boot@lists.denx.de>; Sun, 19 May 2024 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716146351; x=1716751151; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oa2EyQ/NWmndmd/7fwRdHGzbEVAzycMo9tzXk8yWyG0=;
 b=noskCregW+Zug9SBxxNnU/CiYO/UMdmepJJ5F0Wm3yre+NIgSDdnKXhHgPaRNdTEyP
 XQys1j/kbDD6sJnKie23WVVoHel7bSA06VDwUcqzfcAXGgBrmO9fYxhIkTsVWrAVmIjD
 ZuIBXUeseK9GRooMFwrzf/z7xNk/8jvhZyuRzTS9Y7UsUu+DRmeV4fSZ+WLmpvuBpJI4
 pt+eVW4isqSXzQAuORtD+5OOWrqGAwjdiLaoqErhPHTngy0C29nftjkL0MbLcgC3eknu
 C28OgFOPJK5C9yVzPy0JnmMv2FOTg9B7KqZO0p00apxcTGdJrQ34U3lXKatk1UAdM79N
 zcAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716146351; x=1716751151;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oa2EyQ/NWmndmd/7fwRdHGzbEVAzycMo9tzXk8yWyG0=;
 b=G/LnYdi/kRri5CRaf/xZPqnKQw5ZbHQFPubJn3JiDa13Dv7faGkV6S6yIdsyjTM0pS
 JVT9/q/AW9r2vCvOZ/A+sjGZ/kOPI/YmdCUQuDtxdvcZ3rHxduEz9pEapeCVgunuUIy+
 QXXA6a4Ihz1ASrfMLrwVjSeW+AR1eRhWUD0d7Iolmtr7hODwnZlJo+7N9/0zMTiSL7h6
 cVU9I6XgTWib+Am8HZsz3UL6IT810bhgd1XgUOBQ1ysBkqajL3aUSFtzdw78I/HMJWiJ
 ZYEYOVrxv36mnVpt95Iqvt3oJl+hToEaZ1GI+DpgRNzS4Lf7zwaAju1ygthmNNrTqy51
 AO7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULFqi+w5qdNmhziwDa5gV9AfElzHK/ydTJHCRHuI5pHcttEXO+Qp/U+MTccn6QP0A+PXkmGNTFHUr1mRb83/QM5z54rw==
X-Gm-Message-State: AOJu0YzdJeyQpEB85TOslmaCaLgc2M4MkW6t3dYmdV5MflMCKY2KB0uY
 AmL2vwLftdB+d/Ltmhwffh0p/zJU8Vvc/+h3j8rV5O569PCyQrNI
X-Google-Smtp-Source: AGHT+IFtnT7v/XQjsbOHmLmgjvMtRY2ORgnp+s7IMlQMpJ/7s0KL/MoaQyzEBUPe7pRacSNWyFi49A==
X-Received: by 2002:a5d:6982:0:b0:346:bc1b:4e7c with SMTP id
 ffacd0b85a97d-3504a73e009mr22054762f8f.35.1716146350842; 
 Sun, 19 May 2024 12:19:10 -0700 (PDT)
Received: from roman-envy-fast.. ([46.172.77.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3502b89583dsm27411682f8f.33.2024.05.19.12.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 May 2024 12:19:10 -0700 (PDT)
From: Roman Stratiienko <r.stratiienko@gmail.com>
To: r.stratiienko@gmail.com, mkorpershoek@baylibre.com, igor.opaniuk@gmail.com,
 dsimic@manjaro.org, sjg@chromium.org, ilias.apalodimas@linaro.org,
 xypron.glpk@gmx.de, eajames@linux.ibm.com, marek.vasut+renesas@mailbox.org,
 paulerwan.rio@gmail.com, u-boot@lists.denx.de
Subject: [PATCH 2/3] avb: Implement get_preloaded_partition callback
Date: Sun, 19 May 2024 19:18:55 +0000
Message-Id: <20240519191856.2582174-3-r.stratiienko@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240519191856.2582174-1-r.stratiienko@gmail.com>
References: <20240519191856.2582174-1-r.stratiienko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

AVB can reuse already loaded images instead of loading them
from the disk.

The get_preloaded_partition now looks for the env. variables
set by the 'abootimg load' to find the correct partition in RAM.

Signed-off-by: Roman Stratiienko <r.stratiienko@gmail.com>
---
 common/avb_verify.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/common/avb_verify.c b/common/avb_verify.c
index cff9117d92..d2626e8844 100644
--- a/common/avb_verify.c
+++ b/common/avb_verify.c
@@ -6,6 +6,7 @@
 #include <avb_verify.h>
 #include <blk.h>
 #include <cpu_func.h>
+#include <env.h>
 #include <image.h>
 #include <malloc.h>
 #include <part.h>
@@ -595,6 +596,55 @@ static AvbIOResult read_from_partition(AvbOps *ops,
 			   num_bytes, buffer, out_num_read, IO_READ);
 }
 
+#ifdef CONFIG_ANDROID_BOOT_IMAGE
+/**
+ * get_preloaded_partition() - Gets the starting pointer of a partition that
+ * is pre-loaded in memory, and save it to |out_pointer|.
+ *
+ * If the partition is not pre-loaded in memory, the out_pointer shall not be
+ * modified.
+ *
+ * @ops: contains AVB ops handlers
+ * @partition: partition name, NUL-terminated UTF-8 string
+ * @num_bytes: amount of bytes to read
+ * @out_pointer: pointer to the starting address of the partition
+ * @out_num_bytes_preloaded: amount of bytes pre-loaded in memory
+ *
+ * @return:
+ *      AVB_IO_RESULT_OK, if partition was found or was not found
+ *
+ */
+static AvbIOResult get_preloaded_partition(AvbOps *ops, const char *partition, size_t num_bytes,
+					   uint8_t **out_pointer, size_t *out_num_bytes_preloaded)
+{
+	size_t partition_start = 0;
+	size_t partition_size = 0;
+	char env_name[64];
+
+	sprintf(env_name, "abootimg_%s_ptr", partition);
+	partition_start = env_get_hex(env_name, 0);
+
+	sprintf(env_name, "abootimg_%s_size", partition);
+	partition_size = env_get_hex(env_name, 0);
+
+	if (partition_start == 0 || partition_size == 0)
+		return AVB_IO_RESULT_OK;
+
+	if (partition_size < num_bytes) {
+		printf("AVB: Preloaded partition %s size %zu is smaller than requested %zu\n",
+		       partition, partition_size, num_bytes);
+		return AVB_IO_RESULT_ERROR_IO;
+	}
+
+	*out_pointer = (uint8_t *)partition_start;
+	*out_num_bytes_preloaded = partition_size;
+
+	printf("AVB: Using preloaded partition %s at %p\n", partition, *out_pointer);
+
+	return AVB_IO_RESULT_OK;
+}
+#endif
+
 /**
  * write_to_partition() - writes N bytes to a partition identified by a string
  * name
@@ -1043,6 +1093,9 @@ AvbOps *avb_ops_alloc(int boot_device)
 	ops_data->ops.user_data = ops_data;
 
 	ops_data->ops.read_from_partition = read_from_partition;
+#ifdef CONFIG_ANDROID_BOOT_IMAGE
+	ops_data->ops.get_preloaded_partition = get_preloaded_partition;
+#endif
 	ops_data->ops.write_to_partition = write_to_partition;
 	ops_data->ops.validate_vbmeta_public_key = validate_vbmeta_public_key;
 	ops_data->ops.read_rollback_index = read_rollback_index;
-- 
2.40.1

