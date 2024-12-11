Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E5DE7717D
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 12:51:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA429802BF;
	Wed, 11 Dec 2024 13:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k3udKbws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEC180212; Wed, 11 Dec 2024 13:20:54 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F2E128020B
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 13:20:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eichest@gmail.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa6a92f863cso296652766b.1
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 04:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733919651; x=1734524451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+dJ2VUoNgAwspKFn/0x601GOyZJxRobR7GNJJ8VngE=;
 b=k3udKbwsSZTungHfmamuvXCo8oi0uCzbn2IcCct3C55TrvrMspRZjXb1bBwB+t+TjM
 MztV8FQmo+5WxUfhRIPMMNMrgIX7Iui6TTEur2y8Rou5YGOYkbHRN5gC+nl8yWFiuMYA
 7PVEJLpkVib3v6ba3ZYQKpSHUFtDZRsqyYcuTCExCNL6xOiO7Sd418bwxt6XMr5RmDpz
 pJI4Ms/9zp5PfTJ6EWR9N0OvI4+I3IYAsIN5Y9xEt5A9CnujK2aKLzTLgJwik69t5m0W
 XWVTamlVlnyjj2OdTJLxyB+2sQA1Eu02b/POH/O5QLq8H3V+F4B+nQDlkw4YNOd7HC96
 FUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733919651; x=1734524451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z+dJ2VUoNgAwspKFn/0x601GOyZJxRobR7GNJJ8VngE=;
 b=S/iFbV2erg1Gyq/B43mlEMHGGPg79+AUiaS49XXx9dDkXoFEPd3G+odM+Op7GOpsG3
 oaC3lX5pkjvg3qnM3WUEUhsQ1Rc2IidfMbhNqwiYtAV3vfF+TqYnSuJdl8IhamT0bhsL
 T29fLOpDy4ZFxvdJtf5gu8VCR0mrdkwfBZHef7E2oUTqy6as79vGlZlfvGRuwLQPydp0
 vkFCnQCLbm6WA2lgLdneQXnRN0+UcsARqHbE3sN68ppntfKL8Ka/Xg7nFCl8W/+fCCQ7
 nBe1CSS/uYB9c3EQ5tj7hCxKUmH3ohYOUa+iQaiYFDi181D/VdKoruj8hduJ7oe8Wgcy
 s1wQ==
X-Gm-Message-State: AOJu0YzM17uAFc3ZLU/Ma7kfPhIz1QlJjftYAswXPLNhBpiw9LmC2q2I
 ATn/uM9/WOgE1P6knmhY4rDGTuGNc087a0u83mAY7jJ8y5CiAxp8
X-Gm-Gg: ASbGncuK/3bH4aXFHRInUlKzB+cFCh5EN2So6fxgr4E/IvLu9PzBqZSsS5wpUjvI0lz
 KMdYOnpKS1PhvhdYYo5maVN/k9fWfrEmvuP7jLcy+3CJSvTLkBP7rgspp4M4Wkj3PaL9fH1giqi
 n1+D4pmhIlr2mW8VtKu0bkuJk+5YEEJ8EJxUSRFcNWMfiYWNAPXUXM37zJrJhnvRldzuac2gUwu
 Y6521DJgLDehRDMvLg+efSt2kqU6RRkUmKNa7NH+u6mGO8bgh2hpzOAI2Unu7vKMn72bK0t4gEt
 007aX2/I3jO/LlsZiiwSmbRNBPZ+
X-Google-Smtp-Source: AGHT+IFCBG/N/h6Een8Dxu9u4F0ZkPTvrjWg8M0Ii6IV/Cn1jk2s7O1vNdwayS0Duc67F3BDrnnHkQ==
X-Received: by 2002:a17:906:31db:b0:aa6:23ba:d8c8 with SMTP id
 a640c23a62f3a-aa6b10f520dmr263901766b.11.1733919651270; 
 Wed, 11 Dec 2024 04:20:51 -0800 (PST)
Received: from eichest-laptop.corp.toradex.com (31-10-206-125.static.upc.ch.
 [31.10.206.125]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa6a23ad9c1sm256530266b.48.2024.12.11.04.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 04:20:50 -0800 (PST)
From: Stefan Eichenberger <eichest@gmail.com>
To: sbabic@denx.de, festevam@gmail.com, uboot-imx@nxp.com, trini@konsulko.com,
 francesco.dolcini@toradex.com, stefan.eichenberger@toradex.com,
 peng.fan@nxp.com, emanuele.ghidoli@toradex.com, joao.goncalves@toradex.com,
 vitor.soares@toradex.com, igor.opaniuk@foundries.io
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 5/5] imx: mach: imx8: fdt: set correct frequencies for the
 industrial SoC
Date: Wed, 11 Dec 2024 13:18:55 +0100
Message-ID: <20241211122036.103383-6-eichest@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241211122036.103383-1-eichest@gmail.com>
References: <20241211122036.103383-1-eichest@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 11 Dec 2024 13:50:55 +0100
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

From: Stefan Eichenberger <stefan.eichenberger@toradex.com>

Set correct CPU and GPU frequencies for the industrial i.MX8 SoC
variant.

Ensure that the CPU and GPU frequencies are properly configured for the
industrial variant of the SoC. According to the "i.MX 8QuadMax
Industrial Applications Processors" datasheet, the frequency limits for
this variant are as follows:
- Cortex-A72: 1.296 GHz
- Cortex-A53: 1.104 GHz
- GPU core: 625 MHz
- GPU shader: 625 MHz

The CPU clock is enforced by the System Controller Firmware (SCFW), but
the cpufreq driver is unaware of this enforcement. By removing
unsupported frequencies from the operating points, we ensure that the
cpufreq driver aligns correctly with the SCFW's settings.

The GPU frequency, on the other hand, is not enforced by the SCFW. As a
result, the GPU could potentially be overclocked. To prevent this, we
set the correct clock frequency and update the operating points
accordingly, ensuring compliance with the datasheet specifications.

Signed-off-by: Stefan Eichenberger <stefan.eichenberger@toradex.com>
---
 arch/arm/mach-imx/imx8/fdt.c | 132 +++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/fdt.c b/arch/arm/mach-imx/imx8/fdt.c
index 6d0585f5cc6..ce78c8ce919 100644
--- a/arch/arm/mach-imx/imx8/fdt.c
+++ b/arch/arm/mach-imx/imx8/fdt.c
@@ -11,6 +11,8 @@
 #include <fdt_support.h>
 #include <linux/libfdt.h>
 #include <linux/printk.h>
+#include <cpu.h>
+#include <dm.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -279,6 +281,134 @@ static int ft_add_optee_node(void *fdt, struct bd_info *bd)
 	return 0;
 }
 
+static int delete_node(void *blob, const char *node)
+{
+	int nodeoffset;
+	int err;
+
+	nodeoffset = fdt_path_offset(blob, node);
+	if (nodeoffset < 0)
+		return -ENXIO;
+
+	err = fdt_del_node(blob, nodeoffset);
+	if (err)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int change_property(void *blob, const char *node, const char *property,
+			   const void *value, int len)
+{
+	int nodeoffset;
+	int err;
+
+	nodeoffset = fdt_path_offset(blob, node);
+	if (nodeoffset < 0)
+		return -ENXIO;
+
+	err = fdt_setprop(blob, nodeoffset, property, value, len);
+	if (err)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void update_fdt_gpu_industrial_frequencies(void *blob)
+{
+	u32 gpu_opp_table[6];
+	u32 gpu_assigned_clocks[2];
+	int err;
+
+	gpu_opp_table[0] = cpu_to_fdt32(625000); /* Normal Core Clock */
+	gpu_opp_table[1] = cpu_to_fdt32(0);
+	gpu_opp_table[2] = cpu_to_fdt32(625000); /* Normal Shader Clock */
+	gpu_opp_table[3] = cpu_to_fdt32(0);
+	gpu_opp_table[4] = cpu_to_fdt32(400000); /* Low Shader and Core Clock */
+	gpu_opp_table[5] = cpu_to_fdt32(0);
+
+	gpu_assigned_clocks[0] = cpu_to_fdt32(625000000); /* Core Clock */
+	gpu_assigned_clocks[1] = cpu_to_fdt32(625000000); /* Shader Clock */
+
+	err = change_property(blob, "/bus@53100000/gpu@53100000",
+			      "assigned-clock-rates", gpu_assigned_clocks,
+			      sizeof(gpu_assigned_clocks));
+	if (err && err != ENXIO)
+		printf("Failed to set assigned-clock-rates for GPU0: %s\n",
+		       fdt_strerror(err));
+
+	err = change_property(blob, "/bus@54100000/gpu@54100000",
+			      "assigned-clock-rates", gpu_assigned_clocks,
+			      sizeof(gpu_assigned_clocks));
+	if (err && err != ENXIO)
+		printf("Failed to set assigned-clock-rates for GPU1: %s\n",
+		       fdt_strerror(err));
+
+	err = change_property(blob, "/bus@54100000/imx8_gpu1_ss@80000000",
+			      "operating-points", &gpu_opp_table,
+			      sizeof(gpu_opp_table));
+	if (err && err != ENXIO)
+		printf("Failed to set operating-points for GPU: %s\n",
+		       fdt_strerror(err));
+}
+
+static void update_fdt_cpu_industrial_frequencies(void *blob)
+{
+	int err;
+
+	err = delete_node(blob, "/opp-table-0/opp-1200000000");
+	if (err && err != -ENXIO)
+		printf("Failed to delete 1.2 GHz node on A53: %s\n",
+		       fdt_strerror(err));
+
+	err = delete_node(blob, "/opp-table-1/opp-1596000000");
+	if (err && err != -ENXIO)
+		printf("Failed to delete 1.596 GHz node on A72: %s\n",
+		       fdt_strerror(err));
+}
+
+static void update_fdt_frequencies(void *blob)
+{
+	struct cpu_info cpu;
+	struct udevice *dev;
+	int err;
+
+	uclass_first_device(UCLASS_CPU, &dev);
+
+	err = cpu_get_info(dev, &cpu);
+	if (err) {
+		printf("Failed to get CPU info\n");
+		return;
+	}
+
+	/*
+	 * Differentiate between the automotive and industrial variants of the
+	 * i.MX8. The difference of these two CPUs is the maximum frequencies
+	 * for the CPU and GPU.
+	 * Core			Automotive [max. MHz]	Industrial [max. MHz]
+	 * A53			1200			1104
+	 * A72			1596			1296
+	 * GPU Core		800			625
+	 * GPU Shader		1000			625
+	 *
+	 * While the SCFW enforces these limits for the CPU, the OS cpufreq
+	 * driver remains unaware, causing a mismatch between reported and
+	 * actual frequencies. This is resolved by removing the unsupprted
+	 * frequencies from the device tree.
+	 *
+	 * The GPU frequencies are not enforced by the SCFW, therefore without
+	 * updating the device tree we overclock the GPU.
+	 *
+	 * Using the cpu_freq variable is the only know way to differentiate
+	 * between the automotive and industrial variants of the i.MX8.
+	 */
+	if (cpu.cpu_freq != 1104000000)
+		return;
+
+	update_fdt_cpu_industrial_frequencies(blob);
+	update_fdt_gpu_industrial_frequencies(blob);
+}
+
 int ft_system_setup(void *blob, struct bd_info *bd)
 {
 	int ret;
@@ -294,6 +424,8 @@ int ft_system_setup(void *blob, struct bd_info *bd)
 
 	update_fdt_with_owned_resources(blob);
 
+	update_fdt_frequencies(blob);
+
 	if (is_imx8qm()) {
 		ret = config_smmu_fdt(blob);
 		if (ret)
-- 
2.45.2

