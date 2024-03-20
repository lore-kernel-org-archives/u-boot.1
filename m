Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07DB4C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 12:17:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA1EF87F6E;
	Wed, 20 Mar 2024 13:16:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Cz/ZR/8O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 385DC87F6E; Wed, 20 Mar 2024 13:16:58 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EADED87F6E
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 13:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-29fa98705b1so2437977a91.3
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 05:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710937014; x=1711541814; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YItxV2xnFEjqxWmK5FQWjrVm47bMelG+ZtuZfhx9PpI=;
 b=Cz/ZR/8OOp4mm7QOFLTodaU67LzzRXQqvyD8Sn82S5v1FE7JuNu6rGOkI+bEqEGOOD
 meFVEOaaLwItVvweKHWnYJHU9kvqs84NDKUz3SET51lylfa98GxlGxZOAIoL688vLy+a
 9jYXJEE8ax5/3eMCV86FUCOV74c06Sc3E+9c2QtzHuPxM/zocMoKQR91IsJzbOWzPiks
 mOxnOsAmui0uRA++ulBd265nof36r8gZcpJsg+qAKJU2h1OlhBkkBMvRtxVRbyhqV+PY
 DM8497awN9qZIa2TbQ8Wxp+HhCbXQ0FOaKgaLk8yHy0sgApkLJSU1aq2AcuDRDlFFvAF
 tmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710937014; x=1711541814;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YItxV2xnFEjqxWmK5FQWjrVm47bMelG+ZtuZfhx9PpI=;
 b=iY+8KR3umq5kFoNuAz7p2EKHzvBhgpxtvZ9l80TODN4lYdsAh6wj4zKUhyYUeTLLUS
 JV1ZQWqBiQtOLaKeWOqZK4bsBJ/WDd/pFmZvISPtl8I65QAi2hmA+1jDwv0Gu9sXl3+X
 acXKZXgj5QNpQNO8HIVH5eIhrQFOqCBSkUiKln/Da6mYoOZqqZ8LBcSR2OjT7yl30VvT
 wsa7axwtvsacaGYQoGIhttmoQ2qMx54+ZykjDL1jqlMVzZEISci+qye/teb4Wmy8lR2i
 k91w/yU6MBKrSFiSo1lr8sDn1PQDWl7LFjRXSAV7U2ZH8I3aWSuNIgvtQruQPqEUEWyq
 13iQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+1GM5U0vo18+xac1ZEJwZe6Kt3R5C/qq6XljEsGX5BbyZDZoAc+PhF403bVHqN0YjOhsoE9d/UpMzlWil4ypfI68Z/A==
X-Gm-Message-State: AOJu0Yyem9IR04N3hozMfkCCkKOYLSR8tV68giqHkxVNqoVjmghlSkT6
 UXL9Sa+gvqWcNMTILyDDk2D3HXM+9BvoJ0AgyqCGuwlQXDVehcQc+oYc2HX5oIs=
X-Google-Smtp-Source: AGHT+IHYgcqOEyfrKEEYMrvvO7nVL1WxThsc4pkijq/e8uune0jPlKYDUDGRWdF/dIsbxAB0VuIMXQ==
X-Received: by 2002:a17:90b:1056:b0:29b:acc6:c54f with SMTP id
 gq22-20020a17090b105600b0029bacc6c54fmr5243984pjb.35.1710937014305; 
 Wed, 20 Mar 2024 05:16:54 -0700 (PDT)
Received: from joaog-nb.corp.toradex.com ([201.82.41.210])
 by smtp.gmail.com with ESMTPSA id
 sj10-20020a17090b2d8a00b0029af5587889sm1447870pjb.12.2024.03.20.05.16.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Mar 2024 05:16:53 -0700 (PDT)
From: Joao Paulo Goncalves <jpaulo.silvagoncalves@gmail.com>
To: Tom Rini <trini@konsulko.com>
Cc: Joao Paulo Goncalves <joao.goncalves@toradex.com>, u-boot@lists.denx.de,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 2/2] arm: mach-k3: am625: Fixup a53 cpu frequency by speed
 grade
Date: Wed, 20 Mar 2024 09:16:32 -0300
Message-Id: <20240320121632.105730-3-jpaulo.silvagoncalves@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
References: <20240320121632.105730-1-jpaulo.silvagoncalves@gmail.com>
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

From: Joao Paulo Goncalves <joao.goncalves@toradex.com>

The maximum frequency of the A53 CPU on the AM62 depends on the speed
grade of the SoC. However, this value is hardcoded in the DT for all
AM62 variants, potentially causing specifications to be exceeded. Moreover,
setting a common lower frequency for all variants increases boot time.
To prevent these issues, modify the DT at runtime from the R5 core to
adjust the A53 CPU frequency based on its speed grade.

Suggested-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Joao Paulo Goncalves <joao.goncalves@toradex.com>
---
 arch/arm/mach-k3/am625_init.c | 62 +++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/arch/arm/mach-k3/am625_init.c b/arch/arm/mach-k3/am625_init.c
index 6c96e881146..961f36e6549 100644
--- a/arch/arm/mach-k3/am625_init.c
+++ b/arch/arm/mach-k3/am625_init.c
@@ -14,6 +14,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/pinctrl.h>
+#include <dm/ofnode.h>
 
 #define RTC_BASE_ADDRESS		0x2b1f0000
 #define REG_K3RTC_S_CNT_LSW		(RTC_BASE_ADDRESS + 0x18)
@@ -24,6 +25,9 @@
 #define K3RTC_KICK0_UNLOCK_VALUE	0x83e70b13
 #define K3RTC_KICK1_UNLOCK_VALUE	0x95a4f1e0
 
+/* TISCI DEV ID for A53 Clock */
+#define AM62X_DEV_A53SS0_CORE_0_DEV_ID 135
+
 /*
  * This uninitialized global variable would normal end up in the .bss section,
  * but the .bss is cleared between writing and reading this variable, so move
@@ -112,6 +116,62 @@ static __maybe_unused void rtc_erratumi2327_init(void)
 	writel(K3RTC_KICK1_UNLOCK_VALUE, REG_K3RTC_KICK1);
 }
 
+#if CONFIG_IS_ENABLED(OF_CONTROL)
+static int get_a53_cpu_clock_index(ofnode node)
+{
+	int count, i;
+	struct ofnode_phandle_args *args;
+	ofnode clknode;
+
+	clknode = ofnode_path("/bus@f0000/system-controller@44043000/clock-controller");
+	if (!ofnode_valid(clknode))
+		return -1;
+
+	count = ofnode_count_phandle_with_args(node,  "assigned-clocks", "#clock-cells", 0);
+
+	for (i  = 0; i < count; i++) {
+		if (!ofnode_parse_phandle_with_args(node, "assigned-clocks",
+						    "#clock-cells", 0, i, args)) {
+			if (ofnode_equal(clknode, args->node) &&
+			    args->args[0] == AM62X_DEV_A53SS0_CORE_0_DEV_ID)
+				return i;
+		}
+	}
+
+	return -1;
+}
+
+static void fixup_a53_cpu_freq_by_speed_grade(void)
+{
+	int index, size;
+	u32 *rates;
+	ofnode node;
+
+	node =  ofnode_path("/a53@0");
+	if (!ofnode_valid(node))
+		return;
+
+	rates = fdt_getprop_w(ofnode_to_fdt(node), ofnode_to_offset(node),
+			      "assigned-clock-rates", &size);
+
+	index = get_a53_cpu_clock_index(node);
+
+	if (!rates || index < 0 || index >= (size / sizeof(u32))) {
+		printf("Wrong A53 assigned-clocks configuration\n");
+		return;
+	}
+
+	rates[index] = cpu_to_fdt32(k3_get_a53_max_frequency());
+
+	printf("Changed A53 CPU frequency to %dHz (%c grade) in DT\n",
+	       k3_get_a53_max_frequency(), k3_get_speed_grade());
+}
+#else
+static void fixup_a53_cpu_freq_by_speed_grade(void)
+{
+}
+#endif
+
 void board_init_f(ulong dummy)
 {
 	struct udevice *dev;
@@ -210,6 +270,8 @@ void board_init_f(ulong dummy)
 			panic("DRAM init failed: %d\n", ret);
 	}
 	spl_enable_cache();
+
+	fixup_a53_cpu_freq_by_speed_grade();
 }
 
 u32 spl_mmc_boot_mode(struct mmc *mmc, const u32 boot_device)
-- 
2.34.1

