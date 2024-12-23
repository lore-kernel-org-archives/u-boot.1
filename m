Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892A1E7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 14:48:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36DE980730;
	Mon, 23 Dec 2024 15:48:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hGGSEkJM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6D9480741; Mon, 23 Dec 2024 15:48:19 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 924E0806D4
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 15:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6dd43aa1558so6422926d6.0
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 06:48:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734965296; x=1735570096; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4YRs4LxgJj3HURqtJqLqMHlekfM/VQPnuM7GWtjTynE=;
 b=hGGSEkJMEiildGE2uzMMQtYFtJgIvTSDDRD4niqj3lO5R4iMd8YQ8olert1pylOyfh
 YEBa8ARvbZg+ttFqgFIIvFnAkdJ0/NB/rHmr3FyqAev/qNRTFvGG5FOb7Dy/ITut2aYT
 /orpPlEmgoBXz4kJfaZbkMf51tM6e+HVwf+jCQ8oCGOw6Y25/caxuS1F83Mk4jhtCXEl
 p8m6md9TapM1feJPbEXE61focS/T1PlxDaYrzZlZoYRQkfRGX9iKfNylw8nZUriW558U
 fRDvZTVQmpvMxlmVVG1TfdF6wjqz++1PwNQjL8GwWa2c1gV0kZX8kabr+Wfh3NEF4UI/
 TQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734965296; x=1735570096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4YRs4LxgJj3HURqtJqLqMHlekfM/VQPnuM7GWtjTynE=;
 b=s94eNkdy+1RyvARjtY8QtSJYjGtjeJNfrLxzwsp2Qb47GikAadgUc3dkn9xapkdqsD
 AwycwJiJ/u9rgO9JQ0cjszxfmHGWC1tZa0rCa8V/PDO7NQ+yAuTyhIJdUUxk2yKjXcAS
 XdLV9QvPmAAKnQjRrzY4Nk9yz5qT/0jn9psrRz1zv5j4ohHUj/VV9TDgCB+c8s9+7MQd
 luU2aOY3GZYLQv9NbT9QrPA7UoRnUt9X3afVeY12eEPM7Ayv4/arY89R0Ss2TBDZCcH9
 F3bqDslMCq0aHxtPdgdUqJMRFXjLBpqdCizREq2lGtfvRiyWjPPNnaQbhm66Ay2qmCUJ
 KYRQ==
X-Gm-Message-State: AOJu0Yy08MZUYLrD26xgs8ewzoVnzuWv+U9ip3zdpeAKYNteFtOj8mKs
 VU+RBGuT5zmWuDpBPZYr4uq7IXYaV7RPiAJL7pWFX3KbxjMDntYtqsrxLwZGiuHYyYsTtF6vy1E
 C
X-Gm-Gg: ASbGncuxrqQmKmbY7y5fnBsTGSDVhIU6dVCTWWklpys7CJ0bt6nLowkrsiTaRS2/aQn
 xdVmH9inCddz2uAuBZbYgap9mbjQ9qoxrMYURXU4Qu5KT7MtA0KEZsdXsM31jcbf/dtxZaGywnP
 3i5ksLd86f7SJulvQVxWzRnn2uo72uSprLXkCRvVDMfHbxegHBzUxBdcsMculuRSnI4i4BuTG5u
 NBbWK8LMw9Q3nDtlwCEWBtExcr+ROju2mlNtSxN0bsi8WF6noYKCPUDKQaguILRjySUUIr6/6+b
 HvjvBdIPoNd0B4ETwTfmEuF5UAJnaxPAWn/zdqwX6dY6ErIAm0jRUkE=
X-Google-Smtp-Source: AGHT+IEpNq/8yMieXfy5jBC520xhC8c9p+f6hzbvp4FmzBNlnqTakkHmgCrPrMEGPMfE0TnRXdJ8bA==
X-Received: by 2002:a05:6214:e48:b0:6d8:95c9:af2b with SMTP id
 6a1803df08f44-6dd2339ff71mr197380596d6.35.1734965296033; 
 Mon, 23 Dec 2024 06:48:16 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb519sm44243246d6.83.2024.12.23.06.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 06:48:15 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tim Harvey <tharvey@gateworks.com>, Simon Glass <sjg@chromium.org>,
 Eddie James <eajames@linux.ibm.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH 04/11] tpm: refactor tcg2_get_pcr_info()
Date: Mon, 23 Dec 2024 06:47:26 -0800
Message-Id: <20241223144737.554992-5-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241223144737.554992-1-raymond.mao@linaro.org>
References: <20241223144737.554992-1-raymond.mao@linaro.org>
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

Rename the arguments of tcg2_get_pcr_info() to clarify
they are bank masks, not PCR mask.
Remove the unused local variable.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
 include/tpm_tcg2.h | 12 ++++++------
 lib/tpm_tcg2.c     | 19 ++++++++-----------
 2 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/tpm_tcg2.h b/include/tpm_tcg2.h
index 6519004cc4..eb6afe49e7 100644
--- a/include/tpm_tcg2.h
+++ b/include/tpm_tcg2.h
@@ -94,17 +94,17 @@ struct tcg_pcr_event {
 } __packed;
 
 /**
- * tcg2_get_pcr_info() - get the supported, active PCRs and number of banks
+ * tcg2_get_pcr_info() - get the supported, active banks and number of banks
  *
  * @dev:		TPM device
- * @supported_pcr:	bitmask with the algorithms supported
- * @active_pcr:		bitmask with the active algorithms
- * @pcr_banks:		number of PCR banks
+ * @supported_bank:	bitmask with the algorithms supported
+ * @active_bank:	bitmask with the active algorithms
+ * @bank_num:		number of PCR banks
  *
  * @return 0 on success, code of operation or negative errno on failure
  */
-int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks);
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
+		      u32 *bank_num);
 
 /**
  * Crypto Agile Log Entry Format
diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index dc5a0644fd..16f41cbfd1 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -21,19 +21,16 @@
 #include "tpm-utils.h"
 #include <bloblist.h>
 
-int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
-		      u32 *pcr_banks)
+int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
+		      u32 *bank_num)
 {
-	u8 response[(sizeof(struct tpms_capability_data) -
-		offsetof(struct tpms_capability_data, data))];
 	struct tpml_pcr_selection pcrs;
 	size_t i;
 	u32 ret;
 
-	*supported_pcr = 0;
-	*active_pcr = 0;
-	*pcr_banks = 0;
-	memset(response, 0, sizeof(response));
+	*supported_bank = 0;
+	*active_bank = 0;
+	*bank_num = 0;
 
 	ret = tpm2_get_pcr_info(dev, &pcrs);
 	if (ret)
@@ -43,16 +40,16 @@ int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 		u32 hash_mask = tcg2_algorithm_to_mask(pcrs.selection[i].hash);
 
 		if (hash_mask) {
-			*supported_pcr |= hash_mask;
+			*supported_bank |= hash_mask;
 			if (tpm2_is_active_bank(&pcrs.selection[i]))
-				*active_pcr |= hash_mask;
+				*active_bank |= hash_mask;
 		} else {
 			printf("%s: unknown algorithm %x\n", __func__,
 			       pcrs.selection[i].hash);
 		}
 	}
 
-	*pcr_banks = pcrs.count;
+	*bank_num = pcrs.count;
 
 	return 0;
 }
-- 
2.25.1

