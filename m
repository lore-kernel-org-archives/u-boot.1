Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EB3E7E0CD
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 17:59:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCC083C5E;
	Mon,  9 Feb 2026 18:59:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d5Q+HwFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F85F83C65; Mon,  9 Feb 2026 18:59:50 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEA778388D
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 18:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59dd54b1073so3353383e87.0
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770659988; x=1771264788; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWRlxNgGi2A1N7eHJRP9jo56lGquFUEbaqxBXQ/ZvXE=;
 b=d5Q+HwFkohQiioxFKT/EoRHwUFgkp2PBehhIpQf2uu0hlx/14FwaHAIqQkVM50+97F
 DC69qpYc7RLmkl3iB223zBYwSdPs+IgVtNxbK0bxTXXt4t1gI/LsBEg7QOVo8YlfFALn
 lEhPhi+n86hi+qynx5lhqfVb2BihvkXj/6WAoRh1hdOP1z7cw4pdDCeWg7B8FR2yrCqs
 oijN+t48i0+sVp6Ty2q19ro1qs9HMAxqExBs/ECh2LOtIIwY1OCaqLY6Dxn2RSokaOHx
 lc94UmIlz1riGqc2cM/2sw3vlmxAc2SdCBVqJYh/4kO1bw8mqQ1BG5q+w2VQWakKs0Sb
 RTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770659988; x=1771264788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pWRlxNgGi2A1N7eHJRP9jo56lGquFUEbaqxBXQ/ZvXE=;
 b=bPpv/5EEiZhmdt4Cjn9eGSuvYEN564woXqzA0IlI8BVrrSLvn7JpDA/gHd0esPp0xp
 lG5YlkgKWt23EZcJM6FnhSEpHHf+m7PCytIFae9Kz6bo1pwAClckDouvwnboj3Wpan4b
 rRwUF5PsEK5dubXyMQTuNh6rSHR/em9aWQVEHCSwvlV8YwjEHlSV0kVlaZDLCjjd4p7P
 DTolEXu8G1zTBIrHsni6CpHbvKNZ52aQACb4R+/vog3VLcNcPxQrDY4O9H/qVnf2AQVq
 PHb9QNl8wJQDx490fZBqfZ9GP28/J1Xdix9PfAKky5CvBpDABH1EloE3fhFDOLY/nFCS
 aRBA==
X-Gm-Message-State: AOJu0YyylRTOzPgXdq5UXCs0UwP37UwNUcyP6/+tdgqs0rGVwemYhlVM
 Bv1qW8IcN4eTa0DqdRYEQFqMg5rruPlbaR4GPcmkhISBoYZ02grqyzNu
X-Gm-Gg: AZuq6aJFPKlYI/+W8Dpnc/sEoN/ti0BMHUvrmWcx6mDFlIaJUtJMIBFDb0mcwKYeT03
 /ZfrAreDHFs93MyOIimMtY5rXsywoM3FjBcgCdEbvZihO6MtqiYEq9s09a1docImmDrWJOLYjp4
 9Kj6Zy/BhlBlyGeA/DmMUW6aGrx2O9xtIswZD2pAlRalU5uYMAwSgcF77QqbiIXfYWqoj7guamk
 G5bxvKE8701xld7bqZXRUBG5jvGyANjfeXgdIiAZfpmhhRs8XLGhAMIs4qMUSX2+VKyxiMEcKp4
 qmXLyTqZY0h/5Kc8EwhVW2ASqEa//Y2b72UjuVH3S8uWKBFZr7Se2o14HU+Ixi5jL1r5rX7faUM
 6fVJXwQCAaGvuJhNYYc/e5S78gLXvwdjZjQI3Q//xByWZRle/xswEQb4RplotuSoVfu0yQS8A11
 ww
X-Received: by 2002:a05:6512:4008:b0:59e:384b:9492 with SMTP id
 2adb3069b0e04-59e45047279mr4164795e87.14.1770659987724; 
 Mon, 09 Feb 2026 09:59:47 -0800 (PST)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59e44e21c9fsm2756688e87.77.2026.02.09.09.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 09:59:46 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>, Ion Agorria <ion@agorria.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/3] ARM: tegra: ap: add support T20 A04 SKU id
Date: Mon,  9 Feb 2026 19:59:34 +0200
Message-ID: <20260209175937.32010-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260209175937.32010-1-clamor95@gmail.com>
References: <20260209175937.32010-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

Add definition for Tegra20 SKU 0x4 / A04 found in Sony Tablet P.

Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/tegra.h | 1 +
 arch/arm/mach-tegra/ap.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/include/asm/arch-tegra/tegra.h b/arch/arm/include/asm/arch-tegra/tegra.h
index a399c94213b..8c38c71c93a 100644
--- a/arch/arm/include/asm/arch-tegra/tegra.h
+++ b/arch/arm/include/asm/arch-tegra/tegra.h
@@ -68,6 +68,7 @@ struct timerus {
 
 /* These are the available SKUs (product types) for Tegra */
 enum {
+	SKU_ID_T20_A04		= 0x4, /* Sony Tablet P value */
 	SKU_ID_AP20		= 0x7,
 	SKU_ID_T20		= 0x8,
 	SKU_ID_AP20H		= 0xf,
diff --git a/arch/arm/mach-tegra/ap.c b/arch/arm/mach-tegra/ap.c
index a7938ed7910..ba67cbb1447 100644
--- a/arch/arm/mach-tegra/ap.c
+++ b/arch/arm/mach-tegra/ap.c
@@ -66,6 +66,7 @@ int tegra_get_chip_sku(void)
 	switch (chip_id) {
 	case CHIPID_TEGRA20:
 		switch (sku_id) {
+		case SKU_ID_T20_A04:
 		case SKU_ID_AP20:
 		case SKU_ID_T20:
 		case SKU_ID_AP20H:
-- 
2.51.0

