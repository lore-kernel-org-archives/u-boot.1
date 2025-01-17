Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF93C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 16:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7175080771;
	Fri, 17 Jan 2025 17:36:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="U4ncVZGj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A42C8076E; Fri, 17 Jan 2025 17:36:15 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008248074B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 17:36:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6dd420f82e2so31853796d6.1
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 08:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737131770; x=1737736570; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oxttJthZ2989iDMvN0xk6xJ+VIPmh3+fsvMCZ9QYcco=;
 b=U4ncVZGjbvPAKSS5iS6yuv6q1mSRU7IWiZJgG6mI4XdzBIz5PNneab/cgaehmRHAOg
 h9XzaTT3O95q7xCM+AqkO0N9YyKYneg+4lUX7SNNZbH2SwIjmeFULxR5QjejvSaRInYC
 VS4lI+tm3KNsngd2ezEKkx8L3//0hMm2aJnfVsA4Ox6jfTJjpcBBzA6CwGWjLXd4pOkz
 xIcTeJe6P3jGrxuOc+4LZ7sDD4QDlSfhVwZLPWdS0mtzypNbqYbnKshUjv+JSLmjgTms
 YKqcK81ILAh6EKj3/16aABYoFfyV+YtCJw6YSy8ARcmXfGwgDuEG0zKfFMicolUc29b7
 /Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737131770; x=1737736570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oxttJthZ2989iDMvN0xk6xJ+VIPmh3+fsvMCZ9QYcco=;
 b=nF4F70WO27mhvUAHtNtXMTJx3ZH1Oy0uWZq4tnqij3IMyPauw6bFsYFxcDlnlkeORA
 kK4+WCaOWYclJvGSl5xhvpAQdMT6M+rosS5JLyRmmgW1XhORB6Kog8Tx/xEB20iusCpI
 2Wa4hPgzqOXtWGbXFEZflrsbe94OGPOQygoFhsFtBZZUUhzcFpNSJolKFwBlSk9jOgan
 FyX13Llh9k2dd1sQjS3Dnpg2HNOInUDDDP+RsYZIB19cx89z8AqucF0x+L7zdf/R19GC
 tijiNvKbqe1XI6Jph9u9TkPBGLNGcCQ+7aGKmHEw5l2Zj03A9rbBVzBRw/jzAf9K4EuJ
 1e8Q==
X-Gm-Message-State: AOJu0YyRxjtt+DpkaNzOqGcM/pUjkEmOJozFJ48QIPt2O3ZztULBkOZ3
 Wg7TWOhfBtpgneY2L7l3AWNpEuJa0qenKvLV0ovKAww9W8AGpt0an7PtOPsHERvoeyRZQ66VrM/
 /D+A=
X-Gm-Gg: ASbGncstTmJIB7vATQMS4PtkM+UQ9fvHJ2bRzX4011lVCNM+mypyyz7W0CU4tIJ5++c
 iTEzSuFz533d0BmzRLUdWKR1NqpKEE4r3RxMNhnPEpCGTOaFyFXZVdhqQnCL8eJ+DbSFN0a1ZVx
 BoZsubz3WLw1yTRwJfJaMpxu6p4vZDBFkENFu+EUZ1lLJScbDyu7wijv2Riz5ZySkGVkieNHSMX
 rtSECCjHrIcsQuHmAK5JslTRhCw3G8HzaMUInqtK0nWoR9ygFgYG4J3MsQmDtnZN/WTlJIS4fma
 1IrxrwMpdWY61NOi0CtZG0yykNFHjmbQfKiM9/MSnNhrt4atmgER9DU=
X-Google-Smtp-Source: AGHT+IE+5AZMhSVakIQfA5Hx7D1ulnC7eKiQqdDcxY1G9CNCmRUgcQsqhi/Kmq9R+K/IT50Mi2ctvQ==
X-Received: by 2002:ad4:5742:0:b0:6d8:821d:736e with SMTP id
 6a1803df08f44-6e1b220d9b1mr60181616d6.36.1737131770518; 
 Fri, 17 Jan 2025 08:36:10 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e1afce45c0sm12733946d6.103.2025.01.17.08.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 08:36:09 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v6 3/3] tpm: get tpm event log from bloblist
Date: Fri, 17 Jan 2025 08:35:41 -0800
Message-Id: <20250117163545.88627-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117163545.88627-1-raymond.mao@linaro.org>
References: <20250117163545.88627-1-raymond.mao@linaro.org>
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

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- Remove patch dependency.
- Remove the fallback to FDT when BLOBLIST is selected.
Changes in v3
- Malloc an 8KB buffer when user eventlog buffer does not exist.
Changes in v4
- Replace the default eventlog size with TPM2_EVENT_LOG_SIZE.
Changes in v5
- Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
- Add an inline TODO comment.
Changes in v6
- Remove the malloc and keep the buffer pointed by "sml" for the fallback
  as it is the right place for linux to discover the eventlog.

 lib/tpm_tcg2.c | 58 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 20 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 4134d93a35..6425bf143a 100644
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
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
 		      u32 *bank_num)
@@ -672,21 +674,40 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
 
 __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 {
-	const __be32 *addr_prop;
-	const __be32 *size_prop;
+	const __be32 *addr_prop = NULL;
+	const __be32 *size_prop = NULL;
 	int asize;
 	int ssize;
+	struct ofnode_phandle_args args;
+	phys_addr_t a;
+	fdt_size_t s;
 
 	*addr = NULL;
 	*size = 0;
 
-	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
-	if (!addr_prop)
-		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
+	*addr = bloblist_get_blob(BLOBLISTT_TPM_EVLOG, size);
+	if (*addr && *size)
+		return 0;
 
-	size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
-	if (!size_prop)
+	/*
+	 * TODO:
+	 * Replace BLOBLIST with a new kconfig for handoff all components
+	 * (fdt, tpm event log, etc...) from previous boot stage via bloblist
+	 * mandatorily following Firmware Handoff spec.
+	 */
+	if (!CONFIG_IS_ENABLED(BLOBLIST)) {
+		addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
+		size_prop = dev_read_prop(dev, "tpm_event_log_size", &ssize);
+	}
+
+	/*
+	 * If no eventlog was observed, a sml buffer is required for the kernel
+	 * to discover the eventlog.
+	 */
+	if (!addr_prop || !size_prop) {
+		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
 		size_prop = dev_read_prop(dev, "linux,sml-size", &ssize);
+	}
 
 	if (addr_prop && size_prop) {
 		u64 a = of_read_number(addr_prop, asize / sizeof(__be32));
@@ -694,22 +715,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 
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
+
+	if (dev_read_phandle_with_args(dev, "memory-region", NULL, 0, 0, &args))
+		return -ENODEV;
 
-		a = ofnode_get_addr_size(args.node, "reg", &s);
-		if (a == FDT_ADDR_T_NONE)
-			return -ENOMEM;
+	a = ofnode_get_addr_size(args.node, "reg", &s);
+	if (a == FDT_ADDR_T_NONE)
+		return -ENOMEM;
 
-		*addr = map_physmem(a, s, MAP_NOCACHE);
-		*size = (u32)s;
-	}
+	*addr = map_physmem(a, s, MAP_NOCACHE);
+	*size = (u32)s;
 
 	return 0;
 }
-- 
2.25.1

