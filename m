Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6534EC7EE2A
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 17:40:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAD2D82E50;
	Mon, 23 Jun 2025 19:40:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X0bO1YmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D109482E36; Mon, 23 Jun 2025 19:40:31 +0200 (CEST)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com
 [IPv6:2607:f8b0:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A067E82D34
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 19:40:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jpaulo.silvagoncalves@gmail.com
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-879d2e419b9so3893917a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1750700428; x=1751305228; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FU8XAc8U98K6vz7xtnM+0Lpzg4doADjD+yKigKxSS/4=;
 b=X0bO1YmTUMPtM0dUcpSOaJEmBsJpfwVqAYr1Vz4ElJq4sNH7D43or+Yxzl1PODf4El
 yw7d9T0YAa4maRAXi1BTrd0XWWGxDSw83VOUCu8Jsm+Fi7mQM/Hby2MA1gaYW2BoBieb
 jLC9wNQ4wVcde3bKH5dYBcgrgGB9Nn8RiOFbZFCVVrwc4NxfU6jHlyJn7MQUfPFgYMaW
 U3b9wfLjHQbzPH66hAtPFJ5WANefnJkQYYuHjxMjUSBDxInZ1+U5iDpS9Tctn944JtzP
 HsBIZi3yk736qhMGe9ppZOGUsoJVB32NA2+RPOeNjuX8Gy3uhWKnqzSKA1xGyZl0OlM6
 /xFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750700428; x=1751305228;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FU8XAc8U98K6vz7xtnM+0Lpzg4doADjD+yKigKxSS/4=;
 b=RJ+TsOfu1swIFICkZ7lcwW5QleQh+7rJwUYyB/7pxxL7DWmjOW5dbY8C5PU3EZeVJL
 9XplT/9x1hZaCaEZTMphLxNWlTyuyz2jA0gA1GcqKvOHnGHth44lE0gMnyn8zvPK2s4C
 vLEgLD3a1ffRb2abOmc9ntK/3iKHMva8tj+SMwTrhHMprMRo+v79GB7P2fGm6Tw5QrrF
 A77fcuhs2wdDGsuZqD9D+iKvFvWV3HhlBfGF7gUPLfvbnfCObC/PzWoGsLCmiKhtylbh
 A7YWtIQkg4KDZBZZLMG5Dv8Lqyver0+BouauczLplzHBMosarJYfaLewUKXQJVKfxvIv
 JqUg==
X-Gm-Message-State: AOJu0YyCmPZmpFdC48sMVABcIR5p0eoU3CX+bAFj/o7hn2Tr/7K8k/Vl
 y2parbzDiAwyTsxv8JxI46XjkTUc27wa1Hzio5Rd1J3vLtDPl0/RHHZV
X-Gm-Gg: ASbGncusbUt9y3CFhnDiNdK99qKZ73ZZRk/a6wReI1h6BrNxIMY2/Um5Rn/HAaXAoJC
 oqyZtOEXZUQvwmFGvYZPbrYqWilU8H9N8fY+Ck+SJ5bhpADZc0m8j2aabPLE+6SeIlm+ljJtHpQ
 79vyKBrDTelHdGpB0hLbFw0jzvKUhGMq5CS9ctaP2Av6Rvg0FDQ8uG0H7tvmj9YFf9FNaYOrGjj
 wnWPzf2J5pr+I+XiY2vMSZn5EJYEXxPoQBaorI5Eifvfp3Ph53c7NTqwjeOMYNDr7EDXa9o5BW4
 j4bmrqp+raRDrsMJCqlA8nNNmdF7O8qt5OW96pamIHlPr3sJWWgflw2k5kqplbexxoy77xLDrMS
 EUEY2te3dfqpoKf8=
X-Google-Smtp-Source: AGHT+IFwH6RjUQIKP9hzu/InxFkPSDF5UMb9JDzLGo3q+f0Yy3x3HAEjUbmoXId0Bf4yjIJpQIbWBA==
X-Received: by 2002:a17:90b:4cd1:b0:312:639:a06a with SMTP id
 98e67ed59e1d1-3159d8fce9bmr17521177a91.31.1750700428124; 
 Mon, 23 Jun 2025 10:40:28 -0700 (PDT)
Received: from [10.22.1.180] ([67.159.246.222])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159df8354bsm9465088a91.18.2025.06.23.10.40.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 10:40:27 -0700 (PDT)
From: =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Date: Mon, 23 Jun 2025 14:39:56 -0300
Subject: [PATCH 3/4] arm: mach-k3: am62p: fixup thermal cooling device by
 cpu number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-am62p-fdt-fixup-trip-points-v1-3-12355eb6a72f@toradex.com>
References: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
In-Reply-To: <20250623-am62p-fdt-fixup-trip-points-v1-0-12355eb6a72f@toradex.com>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Apurva Nandan <a-nandan@ti.com>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>
Cc: u-boot@lists.denx.de, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>
X-Mailer: b4 0.14.2
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

From: João Paulo Gonçalves <joao.goncalves@toradex.com>

TI AM62Px devices support CPU throttling based on thermal alerts.
However, the device tree assumes a 4-core configuration. Since the AM62P
also supports 2-core configurations, add a fixup to dynamically adjust
the cooling-device nodes within thermal zones based on the actual number
of CPU cores available.

Signed-off-by: João Paulo Gonçalves <joao.goncalves@toradex.com>
---
 arch/arm/mach-k3/am62px/am62p5_fdt.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/mach-k3/am62px/am62p5_fdt.c b/arch/arm/mach-k3/am62px/am62p5_fdt.c
index 4d8061354c84c0f429d2ad0447bcdc2aea4d1004..4a5ff594df66878368777cd7aa79b3adf0a094e1 100644
--- a/arch/arm/mach-k3/am62px/am62p5_fdt.c
+++ b/arch/arm/mach-k3/am62px/am62p5_fdt.c
@@ -6,6 +6,7 @@
 #include <asm/arch/k3-common-fdt.h>
 #include <asm/hardware.h>
 #include <fdt_support.h>
+#include <fdtdec.h>
 
 static void fdt_fixup_cores_wdt_nodes_am62p(void *blob, int core_nr)
 {
@@ -49,12 +50,48 @@ static void fdt_fixup_cpu_freq_nodes_am62p(void *blob, int max_freq)
 	}
 }
 
+static void fdt_fixup_thermal_cooling_device_cpus_am62p(void *blob, int core_nr)
+{
+	static const char * const thermal_path[] = {
+		"/thermal-zones/main0-thermal/cooling-maps/map0",
+		"/thermal-zones/main1-thermal/cooling-maps/map0",
+		"/thermal-zones/main2-thermal/cooling-maps/map0"
+	};
+
+	int node, cnt, i, ret;
+	u32 cooling_dev[12];
+
+	for (i = 0; i < ARRAY_SIZE(thermal_path); i++) {
+		int new_count = core_nr * 3;  /* Each CPU has 3 entries */
+		int j;
+
+		node = fdt_path_offset(blob, thermal_path[i]);
+		if (node < 0)
+			continue;
+
+		cnt = fdtdec_get_int_array_count(blob, node, "cooling-device",
+						 cooling_dev, ARRAY_SIZE(cooling_dev));
+		if (cnt < 0)
+			continue;
+
+		for (j = 0; j < new_count; j++)
+			cooling_dev[j] = cpu_to_fdt32(cooling_dev[j]);
+
+		ret = fdt_setprop(blob, node, "cooling-device", cooling_dev,
+				  new_count * sizeof(u32));
+		if (ret < 0)
+			printf("Error %s, cooling-device setprop failed %d\n",
+			       thermal_path[i], ret);
+	}
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	fdt_fixup_cores_wdt_nodes_am62p(blob, k3_get_core_nr());
 	fdt_fixup_video_codec_nodes_am62p(blob, k3_has_video_codec());
 	fdt_fixup_canfd_nodes_am62p(blob, k3_has_canfd());
 	fdt_fixup_thermal_critical_trips_k3(blob, k3_get_max_temp());
+	fdt_fixup_thermal_cooling_device_cpus_am62p(blob, k3_get_core_nr());
 	fdt_fixup_cpu_freq_nodes_am62p(blob, k3_get_a53_max_frequency());
 	fdt_fixup_reserved(blob, "tfa", CONFIG_K3_ATF_LOAD_ADDR, 0x80000);
 	fdt_fixup_reserved(blob, "optee", CONFIG_K3_OPTEE_LOAD_ADDR, 0x1800000);

-- 
2.43.0

