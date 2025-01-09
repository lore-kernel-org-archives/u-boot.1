Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8731BE77197
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 15:09:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2117F806D3;
	Thu,  9 Jan 2025 16:09:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xxP8EsTk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07634806E6; Thu,  9 Jan 2025 16:09:48 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95038806D3
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 16:09:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4678cce3d60so8954071cf.2
 for <u-boot@lists.denx.de>; Thu, 09 Jan 2025 07:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736435382; x=1737040182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxDsn3kT2MmXKnaZjp4itwhipiUEOUCGQEeMD1MqHXQ=;
 b=xxP8EsTkxklcVNBGr2Nj0IYpTxzOqTfRt9HO/rcJLymIC986FC3HOnDMZdnvhW68rk
 eVaKyF7G/5pxTZeTUN/oLVRQmjpHQmQHZSXt9AT60T1XndBPdH5NVY3eJPDzN6T2Lj6E
 rXvaGkeFuw70KoWQCeU+5rQDOBzc0wOWgskAar9XC/bLOmiRz7kMmFpWnqrgw9vgNuXq
 FPyTFy0kyaQ3JSYQ5Y/sI1lIvARNVAKg63YevfjPJT3Wh265IO7UIT6UujU9TnSM65cr
 +sdGoK0LoGx6gixTKeBiTzC0nAwQMwrNWDXO+2TKdpk6zk4IAhNBt53WPz8gTufqDTJA
 WRvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736435382; x=1737040182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxDsn3kT2MmXKnaZjp4itwhipiUEOUCGQEeMD1MqHXQ=;
 b=a9Z+FYaKJwgujPMPghLEZHH7Yik5y6+CuMClWDBxFakKK9fM97GwlpwHbxzNtHqvvX
 Zo6m0V4azwftIV9wIpv4PqoKEhX0D3pMDw2uXt5faFJAYQuPKcHL3eKtoZpUmq1za2ui
 mGCLUU23niF1LsEm2C+sqrYHxPckxiFegFsoTAwcPyfpwt95wmVF2JRDebySL+MZsfCD
 NLyJEY8g2gt6dmCmTca+nDliXZQu8XRbZcd7Hgbfo0VVqT2iIXzM7IwdIATM5MZ7byr+
 h6xn9kyAbWQ7jHvDZJRrD5eaRVTJxj43o4DprspT6s2biahzblirGOC11f/KNsCNhmvk
 7FlQ==
X-Gm-Message-State: AOJu0YyGOGvijMTkdNIVTD6PT02fMVLqWzECHeAKwR17NPmSSsGSl147
 d5aWgl4UYhr280j9s7sKL/WaYAINVJe88j38C6Mi5hG+HfMtOlHZH/4+k5kWWBWIIKzHEkXlZLn
 4FV4=
X-Gm-Gg: ASbGncvFbVicTMx5PVkxEJUvkzfO4jJ8ZLkdIOA3ObDvqoardXU1FcVROIn45X2tVJf
 1k7lv8H6tdIRRLvQFFRFERM8ffWcXgD3J3msH1sSWV2oISP7Uc3SX98NRAvSIhZLJ0W+bgMpiuZ
 l/Fj7WIZDk4y4acDPN/y0v5st27LvRANxy5+jYwPNBGYcRwgRGwSx14SK1qqM6T0Ttkjw4XFQlw
 xQIQcjW3T5AOYj7zaWgrqVsYpMSaLqKIvo3KbgRAu3uEEurIMNAZvwHGAMLH79gsynJQAJupMch
 O/fioeTKFwENYpYoBCtVWEZTaFLkJOSn6pNUvUhBM5br8yvW686DwU4=
X-Google-Smtp-Source: AGHT+IHR+jxuO7FO5ywV4KBNpqbRhn4TIIOj4wiafdjiL+2xyVdANJ6kklm7lmnOYtZUVVVXk7edLw==
X-Received: by 2002:a05:622a:1f99:b0:46c:7646:4a3a with SMTP id
 d75a77b69052e-46c76464d85mr83679131cf.7.1736435382147; 
 Thu, 09 Jan 2025 07:09:42 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3e4fdf93sm206396451cf.0.2025.01.09.07.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jan 2025 07:09:41 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Levi Yun <yeoreum.yun@arm.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v3 2/2] tpm: get tpm event log from bloblist
Date: Thu,  9 Jan 2025 07:09:23 -0800
Message-Id: <20250109150928.878849-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250109150928.878849-1-raymond.mao@linaro.org>
References: <20250109150928.878849-1-raymond.mao@linaro.org>
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

Get tpm event log from bloblist instead of FDT when bloblist is
enabled and valid from previous boot stage.

As a fallback, when no event log from previous stage is observed
and no user buffer is passed, malloc an 8KB buffer to initialize
the event log.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove patch dependency.
- Remove the fallback to FDT when BLOBLIST is selected.
Changes in v3
- Malloc an 8KB buffer when user eventlog buffer does not exist.

 include/tpm_tcg2.h |  2 ++
 lib/tpm_tcg2.c     | 55 ++++++++++++++++++++++++++++++----------------
 2 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index 6519004cc4..6ea316888b 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -65,6 +65,8 @@
 #define EFI_DTB_EVENT_STRING \
 	"DTB DATA"
 
+#define EVENT_LOG_DEF_BUF_SIZE 0x2000
+
 /**
  *  struct TCG_EfiSpecIdEventAlgorithmSize - hashing algorithm information
  *
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..d880b14888 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -5,6 +5,7 @@
 
 #include <dm.h>
 #include <dm/of_access.h>
+#include <malloc.h>
 #include <tpm_api.h>
 #include <tpm-common.h>
 #include <tpm-v2.h>
@@ -19,6 +20,7 @@
 #include <linux/unaligned/generic.h>
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
+#include <bloblist.h>
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 		      u32 *pcr_banks)
@@ -607,15 +609,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
 		elog->found = log.found;
 	}
 
+	if (elog->found)
+		return 0;
+
 	/*
-	 * Initialize the log buffer if no log was discovered and the buffer is
-	 * valid. User's can pass in their own buffer as a fallback if no
-	 * memory region is found.
+	 * Initialize the log buffer if no log was discovered.
+	 * User can pass in their own buffer as a fallback if no memory region
+	 * is found, else malloc a buffer if it does not exist.
 	 */
-	if (!elog->found && elog->log_size)
-		rc = tcg2_log_init(dev, elog);
+	if (!elog->log_size) {
+		elog->log = malloc(EVENT_LOG_DEF_BUF_SIZE);
+		if (!elog->log)
+			return -ENOMEM;
+
+		memset(elog->log, 0, EVENT_LOG_DEF_BUF_SIZE);
+		elog->log_size = EVENT_LOG_DEF_BUF_SIZE;
+	}
 
-	return rc;
+	return tcg2_log_init(dev, elog);
 }
 
 int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
@@ -668,10 +679,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 	const __be32 *size_prop;
 	int asize;
 	int ssize;
+	struct ofnode_phandle_args args;
+	phys_addr_t a;
+	fdt_size_t s;
 
 	*addr = NULL;
 	*size = 0;
 
+	*addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
+	if (*addr && *size)
+		return 0;
+	else if (CONFIG_IS_ENABLED(BLOBLIST))
+		return -ENODEV;
+
 	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
 	if (!addr_prop)
 		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
@@ -686,22 +706,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 
 		*addr = map_physmem(a, s, MAP_NOCACHE);
 		*size = (u32)s;
-	} else {
-		struct ofnode_phandle_args args;
-		phys_addr_t a;
-		fdt_size_t s;
 
-		if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0,
-					       0, &args))
-			return -ENODEV;
+		return 0;
+	}
 
-		a = ofnode_get_addr_size(args.node, "reg", &s);
-		if (a == FDT_ADDR_T_NONE)
-			return -ENOMEM;
+	if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
+		return -ENODEV;
 
-		*addr = map_physmem(a, s, MAP_NOCACHE);
-		*size = (u32)s;
-	}
+	a = ofnode_get_addr_size(args.node, "reg", &s);
+	if (a == FDT_ADDR_T_NONE)
+		return -ENOMEM;
+
+	*addr = map_physmem(a, s, MAP_NOCACHE);
+	*size = (u32)s;
 
 	return 0;
 }
-- 
2.25.1

