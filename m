Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2DAC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:03:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C7438413A;
	Fri, 11 Apr 2025 17:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SpTlOOQk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFB6A84148; Fri, 11 Apr 2025 17:03:44 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D52FC84143
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:03:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfebc343dso15992095e9.2
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744383822; x=1744988622; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FSa5QNB53S+69Dbruhd9xlOrJA2Nu+cbfcsov0S7PQI=;
 b=SpTlOOQkoHeb2oDzFUnwmWy5djIBr9ylNamBFfEvSCqe5Xp+ZgLQha5wCiKAFBwtof
 cwuGHiOQ6m5IeeqJ5zzAgdk56175JNaucttmzaZVpvmjz4aMu7BAEg7DnW3ztMS80NAs
 JK4PwoKjqYfOqPoKjHvlpYomUsLLBOmqnU7R8jn5r+4wgFB1MfAsZa4GQD4R+HlOVLto
 BtJg9Ej+kdQTxtiwgoK4MWvzSGyAjjVWGcbQlIwfAOB0JdDBlQYbTI1YjFlEqGIEfXIh
 iyUEuksDgeam3gpDRdoKzeRiYST4ILmTx4Yjx2VMk/0tVUXqYA+s3Hs/Ob1cVdeSHEAS
 w62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744383822; x=1744988622;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FSa5QNB53S+69Dbruhd9xlOrJA2Nu+cbfcsov0S7PQI=;
 b=SBdnvTfA9+Onf3VKq9e11iFW7WB3CLLenzjnJXOVTeVSKIU9WqdJ3EBkFSThehVIMa
 gWpBUGLuRgh0XJjni6UEFzBPI4ERe71gYytHlZrNzyp1AIqnDH/UJT6eFWbgEFsjyxZ0
 O0+AJKIPecn6qJXplfo4zS9PHXt2BxlEiReYTwTHZEfSUc1z05e4FeJHxFDK9f0+/6EW
 G9Xht+2jsuXrRfZXlPOC/BbbE9IB5ZnPVoGnN7kGDoZff8ZUB39rdVEsHL7nrZj4bKOD
 jiTbsLSGAu87EOdYOvt3hf+PuxxD2tyBIQUEYtSJNikwijkidG5l4uRimqNT1Y4mUjD9
 YF8g==
X-Gm-Message-State: AOJu0Yz0QlNJ8AhWVad8wWePl9wy5aQCJPdmK+cWfI6AKu6W8wPvf7p/
 fBdvlj3i4tMRa7wiOHrMWRvRIQHTq9i4qpatfcbsXXUO+WuZCvuwRuJFabiRVVlD7eojZ2bQkKi
 XvhM=
X-Gm-Gg: ASbGncuk7xyMAuQuqLD7esUNjtWLXHOSAzjkkvHZdPMBO0X7PQduwaG9qFkvmisnjat
 NRD169IJWmTXlItrk+3/wJiv1qaHeakqVrVN2955Fbx5bI8K8Mj1zBmRo9bKrChPaoDQIzWGYg/
 lJCcaub+nmQY9MJAaYvQWoJBJRkwd1znrdyjHv4rgTYNP+peH8gTS4ER/nbhrwUOMwNXfwMHwHO
 Iq3v3u2dRvmWsjmBcpvM+r6cq8WpY2e2L6PpLR1G5fpAtCfjg5o7aBlniwMGNHoGhJaftJzzihT
 bG7CZTWz9zL95YqKjk7d8wtessaKpUXOCsU+szNAFCUoY4DYKAMmMQ54gRxmNgH9CPJiFtvOAch
 XbvJ5OqJ0QXW0aDnuow==
X-Google-Smtp-Source: AGHT+IHfTE6T/YuLZfo+zQIf7/GVzgC5T1CBniyDSmXDmBSWSLLZ84ZqJrV94p698UN7YbuACOqRwQ==
X-Received: by 2002:a05:6000:18ac:b0:39c:142d:c0a with SMTP id
 ffacd0b85a97d-39ea52037f9mr2504199f8f.19.1744383821492; 
 Fri, 11 Apr 2025 08:03:41 -0700 (PDT)
Received: from toyger.tail248178.ts.net (35-60-142-46.pool.kielnet.net.
 [46.142.60.35]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eaf445270sm2201005f8f.81.2025.04.11.08.03.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:03:40 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Fri, 11 Apr 2025 17:03:34 +0200
Subject: [PATCH v2 1/4] mach-snapdragon: track boot source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-b4-qcom-capsule-update-improvements-v2-1-27f6b2fcc4a9@linaro.org>
References: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
In-Reply-To: <20250411-b4-qcom-capsule-update-improvements-v2-0-27f6b2fcc4a9@linaro.org>
To: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3177;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=KPSwS7EDhp0UhWBnLFtWO/msI1anYMpSnbXCoVWHpdw=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBn+S9JpBCo1/xkUWJKOoguY4CBNr53G+2YnXrPp
 cCHl48NSkuJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZ/kvSQAKCRAFgzErGV9k
 tr7aD/9x5NVbYZp0+2WumkBasGWG5wRL3PI5nluolNZzsr40lEEEDhy2HQXjMTF5ufQLzOgS1MC
 fP/fyFgBCQ10LJ/mOF1mnYVDA6lU/D6Z/6V8s7/VDMxm8zeK9CGj9x/8KRb453MIK/qLtO5SV9K
 IxN9MmaQe6gYFQ+D+C9fT542apa5ChAEEc4cD3Ty2mxetml/81ilVJyfjmpJQHoeXLJgXLPUZb6
 wi2l/FohyeDO4IK3bJwsGSQJQaRgWwgxZJLqIEc4NYv4DbC/qf8EK67WRGPzEDENgJwcwbyx3Pq
 hNPU+xajOdkVTHSN7Yb4SSLp69K5hyRGQNiICtwXh8z8V5BXQDLkNeye2FCOR79A95uyZTp7vdx
 U8RApljx9Zj/SKtJU5eNSQJyT2Cec6QeKrDCNiSmowmiH0awthRKfYg65W/vofCS6pxTuu3RuQY
 bVuswFRPfST7vmDLlgIRWqQRRi1qhHWGaXYFlDRjaGDxwvPM/x3If9GTbb3DxNcXtmYdy3DHrEK
 Re7Lm9R2FwglY+H++/ciYW8ih7YZNoC5fcsbCnmql2SXHzh1M5zzsnQOa4tJs0utvS/Zrr9Qmli
 91fvHN5/5HgWXpocJH042TEz/JkLlNQ7lkPYI+lBFRgGM8YvZYNHFuC27/tV6Q2/OFNBJCjwIn7
 6zxZ1SnT8E+WMIA==
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Keep track of whether we were loaded via ABL or if U-Boot is running as
a first-stage bootloader.

For now we set this based on if we have a valid external FDT or not,
since it isn't possible to chainload U-Boot from ABL without there being
an external FDT.

This will be used to inform the capsule update logic which partition
U-Boot is flashed to.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/mach-snapdragon/board.c     | 26 ++++++++++++++++++++++++++
 arch/arm/mach-snapdragon/qcom-priv.h | 14 ++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index deae4d323789eab75d5fe735159b4cd820c02c45..34e37ab083f20b70660f2ab90a2995a4dfb33f8e 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -36,8 +36,10 @@
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
+enum qcom_boot_source qcom_boot_source __section(".data") = 0;
+
 static struct mm_region rbx_mem_map[CONFIG_NR_DRAM_BANKS + 2] = { { 0 } };
 
 struct mm_region *mem_map = rbx_mem_map;
 
@@ -237,8 +239,14 @@ int board_fdt_blob_setup(void **fdtp)
 
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
 
+	/* If we have an external FDT, it can only have come from the Android bootloader. */
+	if (external_valid)
+		qcom_boot_source = QCOM_BOOT_SOURCE_ANDROID;
+	else
+		qcom_boot_source = QCOM_BOOT_SOURCE_XBL;
+
 	debug("ram_base = %#011lx, ram_size = %#011llx\n",
 	      gd->ram_base, gd->ram_size);
 
 	if (internal_valid) {
@@ -472,8 +480,25 @@ static void configure_env(void)
 
 	qcom_set_serialno();
 }
 
+void qcom_show_boot_source(void)
+{
+	const char *name = "UNKNOWN";
+
+	switch (qcom_boot_source) {
+	case QCOM_BOOT_SOURCE_ANDROID:
+		name = "ABL";
+		break;
+	case QCOM_BOOT_SOURCE_XBL:
+		name = "XBL";
+		break;
+	}
+
+	log_info("U-Boot loaded from %s\n", name);
+	env_set("boot_source", name);
+}
+
 void __weak qcom_late_init(void)
 {
 }
 
@@ -515,8 +540,9 @@ int board_late_init(void)
 
 	configure_env();
 	qcom_late_init();
 
+	qcom_show_boot_source();
 	/* Configure the dfu_string for capsule updates */
 	qcom_configure_capsule_updates();
 
 	return 0;
diff --git a/arch/arm/mach-snapdragon/qcom-priv.h b/arch/arm/mach-snapdragon/qcom-priv.h
index 74d39197b89f4e769299b06214c26ee829ecdce0..e5eb4cfbc2b752de799b1407ede69683c81474c1 100644
--- a/arch/arm/mach-snapdragon/qcom-priv.h
+++ b/arch/arm/mach-snapdragon/qcom-priv.h
@@ -2,8 +2,22 @@
 
 #ifndef __QCOM_PRIV_H__
 #define __QCOM_PRIV_H__
 
+/**
+ * enum qcom_boot_source - Track where we got loaded from.
+ * Used for capsule update logic.
+ *
+ * @QCOM_BOOT_SOURCE_ANDROID: chainloaded (typically from ABL)
+ * @QCOM_BOOT_SOURCE_XBL: flashed to the XBL or UEFI partition
+ */
+enum qcom_boot_source {
+	QCOM_BOOT_SOURCE_ANDROID = 1,
+	QCOM_BOOT_SOURCE_XBL,
+};
+
+extern enum qcom_boot_source qcom_boot_source;
+
 #if IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT)
 void qcom_configure_capsule_updates(void);
 #else
 void qcom_configure_capsule_updates(void) {}

-- 
2.49.0

