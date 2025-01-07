Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54943E77198
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:03:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D27098060C;
	Tue,  7 Jan 2025 16:03:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="oJ1LiLpw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6372D801C3; Tue,  7 Jan 2025 16:03:18 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61882801C3
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46677ef6910so166685921cf.2
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736262193; x=1736866993; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h/dKGwGNF40ONyt59cWSYhz0z3R8VnMfmBWT9zEMcoo=;
 b=oJ1LiLpw5rzywL5n0MPynFxczn6MgaTqfrXNQ134EjRR477yjI3/io3I94ep9mXehs
 suaBdrzJRBW5f3W/IGk+tewoWnKhajdJXpY1yMIb2HXQah+/GPCb3RnH8klAi5ngEyXq
 4CUIPFsLCFSUYAV8ekcltFyMhuNIiFI6ZYLH0tHnfNJL8rNBJYuRP/Sr5s96gjI1zNYW
 cZT5P/ucsURznbEEAOq8s14hNPr0igq6wOal5nURwNAxWlyL1hE2nvNT47KSwVS2s0jh
 NFpBX75hLMFgpMXwGKLfxElEWTMnNQ7ZMnAD7P2ippG7vAYmYf/+sxTRMw8WUYd8kEI6
 vGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736262193; x=1736866993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h/dKGwGNF40ONyt59cWSYhz0z3R8VnMfmBWT9zEMcoo=;
 b=Xuj+FqPAiHUeQGicjP/WBNcpbmqiltc/18yYcIOaCJiO8u0M9xaAfP+wxgVsPz1zS7
 503vJLfYiDyMKH6ShuWMWqeyXznMkkpH0Z37LBI0iyWBLBo6/SP2hhT6KQylM2TfGgAW
 uRfxnHhTQL9NR0H3C54bzZliUJuembMyi98D4WiJgf94NhQVZQU9gN9PJJFyn1C88T2V
 CJV9eTP3Om+XyqFc5lrDvkdilLBgxSinw9QIYagmkwfVJ8xjJ3+yNC5jOxq3EXS/rKnf
 pSR8z6U+HNPgwr1qaJEEVN6ZoRXLc0D6pcHSIWkNrDXYfcM7c2PfFI93gMNmsutQfAk1
 z+AQ==
X-Gm-Message-State: AOJu0YzO9wJatIa4Z3mpXjYLvD32KJcECxuM+TSY1Wb39B5GQOSrId6L
 FtZImQKfwVaTjU35pAOI9j3qa66K+xqPKMgNBpEN0gDdx0C1f9CkeV5S7vY84/oSN+ch3w/S5j4
 Q
X-Gm-Gg: ASbGncu1GgkTjtKeWS1HTQkJFxyLqXat+CnMxyqaXdg7XSTiGdwKklV8SpMt0ZryOul
 om2lBzPBP+X1/5hrFI5dzXcqiZb1cJt1++R4sIX0K/hempdNIVweVFrO0SSyqz2mg/0JScLhM/d
 aALMiGI6YUCRTnjEHcBfoQd7p/VVSnAZt1uOiy7czPQlHORq3CJMFiu7buY/8iJcTwqlRhiPhjd
 WY4fmyBbHMDn5xTkqPuzcQNB8hDl6UwsWajZeG+bk0oANDpyNw8IHCs+9m59xINg8l0ncGp/nje
 1M+hPdHzcdGQ9wCA/RXI4vX8RDlMnP8UlkGpr8jjV02vkkTlwjLtgb4=
X-Google-Smtp-Source: AGHT+IFcRa/ZLeLEKKwPzfHiG1u0JE4jOtskbjJygJEbzSoNbzuHzMN2vnP1+oyRshR5SdlfAUpDGQ==
X-Received: by 2002:a05:6214:2388:b0:6d8:80e8:d567 with SMTP id
 6a1803df08f44-6dd23346480mr1166139106d6.18.1736262190990; 
 Tue, 07 Jan 2025 07:03:10 -0800 (PST)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d422asm180967096d6.105.2025.01.07.07.03.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 07:03:10 -0800 (PST)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>
Subject: [PATCH v2 2/2] tpm: get tpm event log from bloblist
Date: Tue,  7 Jan 2025 07:02:55 -0800
Message-Id: <20250107150258.813289-2-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250107150258.813289-1-raymond.mao@linaro.org>
References: <20250107150258.813289-1-raymond.mao@linaro.org>
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

 lib/tpm_tcg2.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/lib/tpm_tcg2.c b/lib/tpm_tcg2.c
index 7f868cc883..84845fc026 100644
--- a/lib/tpm_tcg2.c
+++ b/lib/tpm_tcg2.c
@@ -19,6 +19,7 @@
 #include <linux/unaligned/generic.h>
 #include <linux/unaligned/le_byteshift.h>
 #include "tpm-utils.h"
+#include <bloblist.h>
 
 int tcg2_get_pcr_info(struct udevice *dev, u32 *supported_pcr, u32 *active_pcr,
 		      u32 *pcr_banks)
@@ -668,10 +669,19 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
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
+		goto map_log_mem;
+
 	addr_prop = dev_read_prop(dev, "tpm_event_log_addr", &asize);
 	if (!addr_prop)
 		addr_prop = dev_read_prop(dev, "linux,sml-base", &asize);
@@ -686,22 +696,20 @@ __weak int tcg2_platform_get_log(struct udevice *dev, void **addr, u32 *size)
 
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
+map_log_mem:
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

