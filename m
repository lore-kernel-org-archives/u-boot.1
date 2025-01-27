Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D215CC0218A
	for <u-boot@archiver.kernel.org>; Mon, 27 Jan 2025 14:50:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B785581423;
	Mon, 27 Jan 2025 15:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I4XGlZh7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34DD181276; Mon, 27 Jan 2025 15:50:07 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8CE9812C8
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 15:50:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b6fc3e9e4aso393607785a.2
 for <u-boot@lists.denx.de>; Mon, 27 Jan 2025 06:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737989403; x=1738594203; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjHfFyreUad9mmF3WZCDJ/ElxGdCJGtq0+eYoL70wWY=;
 b=I4XGlZh7Vo1kGfhXpaz7L/k1VBFTQc+SRPaygHa9gLcJLUOydaynG9zBNvR8waJETg
 //EVA4oTZ/irn+UsfWpc8733Ff9LNZ54+k7QKKMfUOsD7FljW1gv1fR76XMloN4JaXDv
 +TgsAPsY8mUqFtTuFOY4myjVakIHIjT2pyWHKmsnY0/DJg+/S63IGcMskRugGSqVySQY
 GOa41n1/4bEowsux8b+mZR6yZDzIa/XTo9zTBmUvV5qDAHRRZn1HMO2HGo0nigSke/8g
 hGtEZ25ojlBY0KphS5Uu4yuHxoOAyWkdpAGeYr3gnqdgkly3SV/NHLE9CxF4Jr2gK9u2
 2ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737989403; x=1738594203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjHfFyreUad9mmF3WZCDJ/ElxGdCJGtq0+eYoL70wWY=;
 b=Pmz7kGV4q44owUOV0nqJMWRbFaEWlxUlzTJix7ASUDJ1MQ3ZmS9+Ihu+zSaKrFHKU4
 2K4Nc0mmfqigRHlYeIHYO9dWj5+y9FUb49fhe9iIk44bqfLoBxKGp5iPF7g4Deh9CT6y
 X8Bi61IxdlevWkgP5vQsJRHW46I9nSn2fBo1ixpToP8owb26xwg2HPRTm0R6U1fUIxXF
 Sj4WQ7fEz9TuFK3VbLwEz/IUJf6L2TgXpkkVin6NngMnWqrvsERtSrL1RLYhE4wbA3Rh
 DC9IeHzD03tdDT7W4ToKDH2IswbZe9yykn09FBhF3sLT2A0405zFf4aIry+IMN3hSbbo
 agQQ==
X-Gm-Message-State: AOJu0Yz5Mr/BalNgzZrCZkgdAqVQPDP+9SYiFgyfTvikCsofU+CnP+jS
 sflGt4VQBK1SBUIFkiFyYMDnETOYhkoQm3Rg/AareqY1m3M8cLCKdkhOvUXx8/Oi441mXdh0UQE
 AIL4=
X-Gm-Gg: ASbGnct5Ygnvrp79TtuC+/g2Yz6PE7twazvRe6BGHb1w3kd8Mud8Si8qnI2X+GWeCF1
 mRiTq4xyKFKAwqFs9g708bXowwdT2v753+9ev55vwcoXG5XOivddC/YBQULQpzgJedu3dXmPbTs
 saaUAJA27DeGIUoyiGeAeh+qhObW9JnpyohsnkQaGdkQ/nMuZAtlzGRCsN9GKSmTWzoxphYgamC
 Sn3PppKJtX+1xO2BuuB6EE5RC7035iJbVWe4kW0CNEi7trf6tJiQTJu2cwGey5Suj2QdQMkfU0T
 7Cd9IGPNlUJIwRxcBGAfnx8CmFgSxHrJX7gdDmAJLdJyCjzpUVz2mgKMJkNUjdyuW6xPLr/7Fh3
 enEI=
X-Google-Smtp-Source: AGHT+IHrsU1Ay/vXV0JTCB+uZ5H5uVTQlu15iplqz8yEdw5JWq3WicScjDVs8zpeCzNW5I5E+d4uYw==
X-Received: by 2002:a05:620a:4051:b0:7b6:eed4:695c with SMTP id
 af79cd13be357-7be63249b19mr6210317985a.32.1737989403353; 
 Mon, 27 Jan 2025 06:50:03 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be9aeedc7esm397345985a.70.2025.01.27.06.50.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 06:50:02 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Eddie James <eajames@linux.ibm.com>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v7 3/3] tpm: get tpm event log from bloblist
Date: Mon, 27 Jan 2025 06:49:36 -0800
Message-Id: <20250127144941.645544-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127144941.645544-1-raymond.mao@linaro.org>
References: <20250127144941.645544-1-raymond.mao@linaro.org>
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
Changes in v7
- Remove '#include <malloc.h>'.
- Add mapping for the blob address.

 lib/tpm_tcg2.c | 59 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 39 insertions(+), 20 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 4134d93a35..adb32a14f0 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -19,6 +19,7 @@
 #include <linux/unaligned/generic.h>
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
+#include <bloblist.h>
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_bank, u32 *active_bank,
 		      u32 *bank_num)
@@ -672,21 +673,42 @@ void tcg2_measurement_term(struct udevice *dev, struct tcg2_event_log *elog,
 
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
+	if (*addr && *size) {
+		*addr = map_physmem((uintptr_t)(*addr), *size, MAP_NOCACHE);
+		return 0;
+	}
 
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
@@ -694,22 +716,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 
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

