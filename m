Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1EDE77188
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 15:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F3F580740;
	Tue, 14 Jan 2025 16:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wSfbR1TA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ED8D806F4; Tue, 14 Jan 2025 16:21:03 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDE468070D
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 16:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7b6f1b54dc3so894971385a.1
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 07:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736868058; x=1737472858; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJq9GhsO5crEp32JTB6T5xt9VkNFdW2Yo6ZOBSXazM4=;
 b=wSfbR1TAOTHOST+7fgqMNH39Zh/WWTqpj5564K5D/nuIS434+lZqwK+D7kD4vy9INA
 DzpdcBcT7IObBcQWGR+SvKG/lMcpjlTg8EeMlOnHACH2ouMQAjNipnR1OPQGFmysJqJP
 NizQ5lVbYf1lcgnxa4q1+Unow5r71MKmNJBBVfI+6QNO/4gOyX2OnW3ojSRxoX1NZMby
 4aMb8z214HaByT9ElTQoraIGo+XY5ePMZqmujWHirDK6kt/ypZYc/A+nSjNVzR1YRECj
 FLEljYK1mB1gVRen1FSOqbXugbdY4KOzJXhHfpioysDEZwVI8/5qBvnR2Hg/Z8NXBQff
 whrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736868058; x=1737472858;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GJq9GhsO5crEp32JTB6T5xt9VkNFdW2Yo6ZOBSXazM4=;
 b=L+Z6VfZQtv6upvSdk3aNNIG9ZzvjinkK+AA4LHqhATyXMhbLWWfortMJ5V8mm7aa4T
 +S/ZGefLwquI9ZKOvUJziz+qN1u52EuAyvu20oLaVr4iYRNIFIdxIAIxVqvqKFskWgq0
 AxriZPHLY9w8cP7UjyR/+I88N+4MRahsdScJ7nMWOqLEzQwIBQrd4Z1ZsmTJRSGshJMF
 l3tmln5roEgZCCyg7crwAOp093xyrO+Z/kDsE1RZF3u62RLN87VguZB+M2GO6Rq6UycX
 jTWj4oYZ9DMeQ8+FeqNVGCbCz6OtovMp/WYG4OLcDnG9iBo+FAVjUoiCXKA2qxvng4xB
 uobQ==
X-Gm-Message-State: AOJu0YwacdnjN0e+OstAyoBf190f9KsiCS3r1yyqYVpXSgk2+YP9S+1o
 Kq/CgyqMQ6iUKovwJ052kWBRj4e0HmZIXxSxqm9EuUSYeGsnb9FOQ+aqn55PykrSwbfht4dswKg
 0p6E=
X-Gm-Gg: ASbGnctIynDXVmanCd6CuUiQ2tsf3G2Oo51uITWHBy/BXLEi5UrjZfRn2Qqrqzupjh3
 wofWdzzvlob9jvXdRbqvGHy/H+q0iCUkn5La0CEaibHnGAOzxjJh8RYff53Gvjj1BuHcPUEZr3K
 F+bb46Pl655vOOQ3j1zMJ7/CGExe2e9vD+sX6x+Xp0uEHwlG60Zg2HLRf4hmH5GJhkqvmmzVQ+5
 I8kMGLg1plOJit//PgNRtvZxdxDC/ZfQQE5rWbaHn4DCPNvHtBMAuuo252j77rM6fGf8pjA0h86
 Ou1mr1PzuLT4UYOZOv5Dj2Kdqaqxh7TtjtPdFnsDHleY4xcc1PsCU7I=
X-Google-Smtp-Source: AGHT+IF6uCSuf5NuUtG5J9v1a3csau9mz7gEk4oOTNcGZSLEnaCAOAbrnzBMl1fFWfgbQkt9vwAiqA==
X-Received: by 2002:a05:620a:462c:b0:7b6:d4df:2890 with SMTP id
 af79cd13be357-7bcd97292a8mr4011433385a.4.1736868058643; 
 Tue, 14 Jan 2025 07:20:58 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7bce3281697sm613736885a.67.2025.01.14.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 07:20:58 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Tim Harvey <tharvey@gateworks.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>
Subject: [PATCH v5 3/3] tpm: get tpm event log from bloblist
Date: Tue, 14 Jan 2025 07:20:18 -0800
Message-Id: <20250114152022.933662-3-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250114152022.933662-1-raymond.mao@linaro.org>
References: <20250114152022.933662-1-raymond.mao@linaro.org>
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
Changes in v5
- Replace TPM2_EVENT_LOG_SIZE with CONFIG_TPM2_EVENT_LOG_SIZE.
- Add an inline TODO comment.

 lib/tpm_tcg2.c | 61 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 42 insertions(+), 19 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 4134d93a35..2d9076f091 100644
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
@@ -615,15 +617,24 @@ int tcg2_log_prepare_buffer(struct udevice *dev, struct tcg2_event_log *elog,
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
+		elog->log = malloc(CONFIG_TPM2_EVENT_LOG_SIZE);
+		if (!elog->log)
+			return -ENOMEM;
+
+		memset(elog->log, 0, CONFIG_TPM2_EVENT_LOG_SIZE);
+		elog->log_size = CONFIG_TPM2_EVENT_LOG_SIZE;
+	}
 
-	return rc;
+	return tcg2_log_init(dev, elog);
 }
 
 int tcg2_measurement_init(struct udevice **dev, struct tcg2_event_log *elog,
@@ -676,10 +687,25 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
+	/*
+	 * TODO:
+	 * replace BLOBLIST with a new kconfig for handoff all components
+	 * (fdt, tpm event log, etc...) from previous boot stage via bloblist
+	 * mandatorily following Firmware Handoff spec.
+	 */
+	else if (CONFIG_IS_ENABLED(BLOBLIST))
+		return -ENODEV;
+
 	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
 	if (!addr_prop)
 		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
@@ -694,22 +720,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 
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

