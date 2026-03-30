Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF911061B20
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 20:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C06383FD9;
	Mon, 30 Mar 2026 22:23:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1HUgDKTf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F05280212; Mon, 30 Mar 2026 22:23:48 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC72683CE3
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 22:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-4043b27ddeaso3186674fac.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1774902224; x=1775507024;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wKs1pITaMZCPimQS0fmnnNqtLOdHdMzvP+C/vX3cL9E=;
 b=1HUgDKTfzcOft4KvXlLzwdpsg6NnTQ3q46K4zLF26PIj1lFwJHJUFpipAdYT/agNnh
 heymfxH+kuSNKvM8AbrGTujKXj3McpVviCgdnhbQeVkxJthTnK5gVpXtcXbfZcdWscw3
 3iKdWNesBCOZFNI62T2t+Gl00PJwAdoYf71yCo99h/zr5s4aFDToz7QbF5zxWkvWY6eg
 QtJZdhOOciHlfCbcnJ5YqgN/q9dT0ty2MpEVXbv3NyH01cgAOvIeT1IIk84GrbG3mPTQ
 OI1DIbkEZbEWy+urXTrWqueF3m86ToodNOS7gD/zoHOJJe+vb2Nm0yBuiLhRaDVxonfG
 /UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774902224; x=1775507024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wKs1pITaMZCPimQS0fmnnNqtLOdHdMzvP+C/vX3cL9E=;
 b=fD9l/yQnJeIAhfX41WgYF0wXmrsmuzxBk++aj/Pbo9FJznImANvI5gHF/l7Nfb3Lif
 5gAbLVI04wDzHGyawqa6nadjz1l5p1DnyTYBpV53SZ5QMueY+r62+ILn6b6ErbBzpTgI
 K34wP+RVPBnJurDRFVxLZzoXkh8u7ngdCpbaPkhWFa8cvH9N3771Eph5n3i6CDkTvnkJ
 LGSrCE2FxWt46HFExqmqBN3/DeU2KutPraWkUfI+LoozUrdLiEzqm6qe0KRvkWxiqv7z
 21h5GQIcZI6nbE94GYuQ2h0m30VQkQ5dLVjU/SaBe1pKgCTRX0LWopf0nECt2yfll+5H
 n5rg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvdjmfjKGY8MLWb9mNbnnrTz+s1WSfhDlohHONWhlSNNufgl9JwBqTYVgNYZhM+JUsZ5I785Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyJby7HbceLBXxD7wGmZzMN6JxTK5ACFKXPG/zxbRc+Pgn6S3A6
 LgrD3BV9YolF1bn+xmiCbi8wKOMppTkHKkFvRWfhpsB2m15oNfWWqA6mkKQM7+f6u4RjAK06ASC
 BmEuh
X-Gm-Gg: ATEYQzwCNll4g7QZq/MQ2yiSMZ+RuiiATiLbWSZECPwvVtaDwO7/oupkgkibFYMfKrX
 2zcVUe9s9GG0Od0Z94PzXUG+7j/Wx65MbL38pRpmRX/cDIJZMdUwnJeHi4mIKwrNy8oUF3GRXAG
 meZCTnPWKzsK3Y5b8ANobLA+rc4BwrnoQcn+XP8z9qf64EpPSFq4GD7VKgTw42gdtf5cgH//FuK
 IGvAILdNgHvk294HDa+pPOtkjMxahDIULPXheXZWEDQDpLppNVewynR5wKCbQsjLThy47kxVM1+
 mj4t+twMz+Rm6d8YzOLGdqtNgzC7BxV23vuZ2G83Tfa5ifuGEkwNR5wl4XxH8r8DR74897HIPcb
 zlAIB0BjK3DqNk2LyfZPSV21Cw0OEgXROdv5KljsAsuWqylfP7rRlqnnC9t1BkkK9hwhYG7qYyF
 /cxcUn3uWRwj4xBl/yYlvQlQM0hhTl
X-Received: by 2002:a05:6870:9d9a:b0:41c:fdd7:5b4b with SMTP id
 586e51a60fabf-41cfdd77fa1mr7121904fac.21.1774902224463; 
 Mon, 30 Mar 2026 13:23:44 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:a67f:a092:38d7:379e])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41d048e1984sm5882608fac.4.2026.03.30.13.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 13:23:44 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 30 Mar 2026 15:23:18 -0500
Subject: [PATCH 1/2] arm: mediatek: add SIP platform bininfo lookups
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-mtk-mt8189-cpu-type-v1-1-4059c3b52761@baylibre.com>
References: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
In-Reply-To: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2861; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=0wQ96CpxG4gTYfxqjYWBRPIfajhuWCb/UVRjlQCFzso=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBpytvBdSmt3o05WxutzKlMTWaZyOQLTlJ2QvaNc
 7/9+dq5ISOJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCacrbwRYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AM0cIAJwIkaJ/VywZgLjt8VFdpiJfLxV53iTWYuv5zHj
 qoOd4U1argkRLWyBbFVL78NdX9Uc1D/AbKhKKYCQtTZTvQLOSa9d+KqWM2pzC/VMYFjU0aOBD1v
 SAs1HIxH77Y3P/C62rpk9mjaQ2xhzRL94m1zwcWJxEBLvJ8wKgz+LUYm8UCTPPw/SidiMHv+Skm
 RdEgJ5v9NVu/bDGGqo7jD57r+ZywtTYMa70SerInSEcJhnbgkymvb6INHC57bNyJ6WlLAfBPcUR
 iLEscN58TAvp0DvJu+KvyzXOPqpKN1S5q9kGtbvG+MBZdgvDYEBi21md1lSmGxWr1Qm2pq5TV4E
 1zQc=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add a couple of functions to look up the segment and part name using SIP
calls. These will be used to print more accurate CPU information in
print_cpuinfo().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 arch/arm/mach-mediatek/cpu.c | 55 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mediatek/cpu.h | 14 +++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm/mach-mediatek/cpu.c b/arch/arm/mach-mediatek/cpu.c
index 8e8bc4f9cea..56a41e42df6 100644
--- a/arch/arm/mach-mediatek/cpu.c
+++ b/arch/arm/mach-mediatek/cpu.c
@@ -8,6 +8,11 @@
 #include <init.h>
 #include <wdt.h>
 #include <dm/uclass-internal.h>
+#include <linux/arm-smccc.h>
+#include <linux/types.h>
+
+#define MTK_SIP_PLAT_BINFO ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_64, \
+					      ARM_SMCCC_OWNER_SIP, 0x529)
 
 int arch_cpu_init(void)
 {
@@ -21,3 +26,53 @@ void enable_caches(void)
 	/* Enable D-cache. I-cache is already enabled in start.S */
 	dcache_enable();
 }
+
+/**
+ * mediatek_sip_part_name - get the part name
+ *
+ * Retrieve the part name of platform description.
+ *
+ * This only applicable to SoCs that support SIP plat binfo SMC call.
+ *
+ * Returns: the part name or 0 if error or no part name
+ */
+u32 mediatek_sip_part_name(void)
+{
+	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
+	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
+		struct arm_smccc_res res __maybe_unused;
+
+		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 0, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0)
+			return 0;
+
+		return res.a1;
+	}
+
+	return 0;
+}
+
+/**
+ * mediatek_sip_segment_name - get the segment name
+ *
+ * Retrieve the segment name of platform description.
+ *
+ * This only applicable to SoCs that support SIP plat binfo SMC call.
+ *
+ * Returns: the segment name or 0 if error or no segment name
+ */
+u32 mediatek_sip_segment_name(void)
+{
+	if (CONFIG_IS_ENABLED(TARGET_MT8188) || CONFIG_IS_ENABLED(TARGET_MT8189) ||
+	    CONFIG_IS_ENABLED(TARGET_MT8195) || CONFIG_IS_ENABLED(TARGET_MT8365)) {
+		struct arm_smccc_res res __maybe_unused;
+
+		arm_smccc_smc(MTK_SIP_PLAT_BINFO, 1, 0, 0, 0, 0, 0, 0, &res);
+		if (res.a0)
+			return 0;
+
+		return res.a1;
+	}
+
+	return 0;
+}
diff --git a/arch/arm/mach-mediatek/cpu.h b/arch/arm/mach-mediatek/cpu.h
new file mode 100644
index 00000000000..768284e487f
--- /dev/null
+++ b/arch/arm/mach-mediatek/cpu.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2026 MediaTek Inc.
+ */
+
+#ifndef _MACH_MEDIATEK_CPU_H_
+#define _MACH_MEDIATEK_CPU_H_
+
+#include <linux/types.h>
+
+u32 mediatek_sip_segment_name(void);
+u32 mediatek_sip_part_name(void);
+
+#endif /* _MACH_MEDIATEK_CPU_H_ */

-- 
2.43.0

