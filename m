Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77EA5E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 21:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BDCF801F5;
	Fri, 10 Jan 2025 22:57:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AE6GvXTW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713AC801F5; Fri, 10 Jan 2025 22:57:03 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29DD880050
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 22:57:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d888fc8300so13904436d6.3
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 13:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736546220; x=1737151020; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MyxsR5e4w5Q4jexJaGb3uKMflqLkpgEb9HnZCFdzkFc=;
 b=AE6GvXTWyvlFUQ5I3vOHY/5JtsiJxR8yyxYw6S3MNI17+vvaZV3Rg4fhB/vGwh+7lb
 hPAL0tQloZqVB3FKP4qjOAMNg02k3LhFhUMPyugzJiqCXIOiVaWN9X9uXy8Yp3jzjprP
 S3CQ0s6HL3DaRQBLNZOQiYrxOwuSerfxHjIKhEemJXNCmJLjpxNFZ+SCn4zo0HMpazmb
 I6M6SPh+s1fnH6z+BhPj2ArdUsdGqCRhmR4hT314f7KV9xlSQwP/Jft1to5xQ/VqUA91
 Yhqx6XnKNAlFj1xD+6He9R5RvVof3hkGtCZ0Fv8q1qqCYhyTH0WpiqWhZMQj6NsYW8bH
 kNBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736546220; x=1737151020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MyxsR5e4w5Q4jexJaGb3uKMflqLkpgEb9HnZCFdzkFc=;
 b=VWfPNu89JtGAqzYuxUD8s7CZ3R2V3IBDE3zOozPuD9kq/xWPq9djEUR04KDov/FUPw
 gCHWnIMduj/Lhf/bUv0QCeVZ223jPy2tvRrLSrRU5TCcKqUrTLVESPPRiozeflmcGAod
 0puMmVVI4nS7H4Awn8TNX063dhy3X1tc/43Uta8a9clhAAq8IDsRn7s4DvCBe1DZ+alg
 kIO1CwHoQhyxQXGP/PmhixsGlANHQJZz+iXVaQHJ36y90dsxGPcIhqwxxSJweF/fMAS3
 5GqBlRRqqGG4I3vacLCnB1flNU4I5C7fFhIXoPoC8hBomucO6IlkXoMhEZF+n7rWyUjT
 qm8A==
X-Gm-Message-State: AOJu0Yz5yEcBnYHaIwHv55Udms3O6wz3n4HGMDnI5C09lfDB6u7xfaE7
 UhPy4j5DMc+biTvZLx7iqyxOLGcU9k5c5WQ9OJoyHSX7h6SSJ1VqXAn2NfwaYHIQC8Y3Smp6wpJ
 3m7M=
X-Gm-Gg: ASbGncsLWoREw743iiOsR6iXvrRYe8MtAJWJn939quQilkxLxpb9PpYxR/dMPO/0xch
 OS4VZH2ThL5mWy0SLkYKS8cHC8CpXedoch0o7xT5mwOB1twN0Qk1n5XCyhvaswmDN0MjTxFZPTS
 uWwznXO6rU6ifi7nVFsdhaYJHev093DRleUGb4xdRzCythmq8rx+X1vnj+Mo/IXutzPBb/ABDY+
 Kai0x6fLKLdFyARZhm3Fu4+/hBA/VQv00njllvzkhoOPmgINvz5MI1SRO8Ys+MdHKQBKj1Hny86
 ZfFsiHQCZHN8TVjh2DY/cJeC+s9GlXWjmOQ/IVASvtjmA6d8QMDEO68=
X-Google-Smtp-Source: AGHT+IGTTcSH0MxZ3i1i+mEsfxJtX3TO3B8YtgLHMvQyjxDoV0xeIsvksrHC8cjD9vcfyTktrZ/QcQ==
X-Received: by 2002:a05:6214:c6a:b0:6d8:b2f2:bccf with SMTP id
 6a1803df08f44-6df9b1d21ffmr137416506d6.1.1736546219758; 
 Fri, 10 Jan 2025 13:56:59 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfad85f6bdsm13839496d6.17.2025.01.10.13.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 13:56:59 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v4 3/3] tpm: get tpm event log from bloblist
Date: Fri, 10 Jan 2025 13:56:35 -0800
Message-Id: <20250110215640.892539-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250110215640.892539-1-raymond.mao@linaro.org>
References: <20250110215640.892539-1-raymond.mao@linaro.org>
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
and no user buffer is passed, malloc a default buffer to initialize
the event log.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove patch dependency.
- Remove the fallback to FDT when BLOBLIST is selected.
Changes in v3
- Malloc an 8KB buffer when user eventlog buffer does not exist.
Changes in v4
- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.

 lib/tpm_tcg2.c | 55 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..685699688b 100644
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
+		elog->log = malloc(TPM2_EVENT_LOG_SIZE);
+		if (!elog->log)
+			return -ENOMEM;
+
+		memset(elog->log, 0, TPM2_EVENT_LOG_SIZE);
+		elog->log_size = TPM2_EVENT_LOG_SIZE;
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

