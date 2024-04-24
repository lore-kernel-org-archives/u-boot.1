Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01555C4345F
	for <u-boot@archiver.kernel.org>; Wed, 24 Apr 2024 11:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 572BC88BE0;
	Wed, 24 Apr 2024 13:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="PHPOa6BO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 852AF88C5D; Wed, 24 Apr 2024 13:14:39 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84912831A2
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 13:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a55b2f49206so142072466b.1
 for <u-boot@lists.denx.de>; Wed, 24 Apr 2024 04:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1713957277; x=1714562077; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1i43YC7/wZVVAH2dTIVn+OjGG+AuvPawti8R0thDIg=;
 b=PHPOa6BO0QlbfgTOTk+vLqlLi5EZO9n+f4t0jGh7ztyHk5vCHp/lqZO1xcZE6tGKWA
 bu3TNBQC3NHtpqUjEC5ggtkHCKzsCqZ+d4hvFWZuyIoEzyYwpsS57GwMn2AX+9pE0W2+
 Sfjtpnu9KIW2lYqXNzw1oYHFk9rK9/iaB1edfxfA6Mc7Hs2A6llL4+sUUfjxt2CgILoo
 QMx86MPLiDscDx6HgySMahQBdx+fxQdZSh8TkVMReBw8YYrVVDSj1cxhNj/yJR8VJTyF
 YHDCCt6ufZ9hR1b+PHVrUyV0H5g3qTjcqb9UiDEQQeoSUAb5vVUAt3wVSquOTbvz8vCP
 wx6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713957277; x=1714562077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q1i43YC7/wZVVAH2dTIVn+OjGG+AuvPawti8R0thDIg=;
 b=AKTi24tGaJrUnOf15Ah7cg+PugV39JdYx/DWRKU0RRpSerAb4lyoAJW7ZVQAks+v+T
 X/E+6hhqeeCqq2VcRa1ddmSs0Agojl5SJ2ifIcJAi9gA0ImqT8csuwCvvwqHjQkSaztl
 2WDHNvZ9VBhuhDJvjeix1Ory8YX/bdMhfCfGg8aJaM0fgvN56ky943/Nq1NVZ9Ex5dPJ
 4tiBH1kOptWbzY5A5DpUwXCzQqW9G346sqXw1DnV0n1qVMszsLe/J+6O0SdCPRlkNCf0
 jJGP7O1afPGJuLW+QMNL0tz0iDPB8NPjM6eWhvlmzhIfrzrjkz76Xmo5w+vgrI64Z4L1
 LVYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUV1t8h8reTv9Ds2BroTW6yE3MBbacCGyCcnwy8s3UyzM/hprSndpDuTd/4jDadRSbZsFd2oKWsbcEWnqXAao4x3HH9uQ==
X-Gm-Message-State: AOJu0YwslbhOGBDjNKFW6oWQ7Kod2ilsn1ijIi8mPXy3jKU+JK/o2fal
 oAJM5psrqF5JLs4zd3elfaMtxZ1C5KaFcCLhgFIhkQDyyeaw5r1xmArhWO853K4ni2S/T1ddGKx
 z
X-Google-Smtp-Source: AGHT+IEUZZgWfTlzthDisbxn9A7N1B9Sx1rOeQQ7kNC4HU+ROClwTMJMQzjugLehh/D7Dob4Adzi8w==
X-Received: by 2002:a17:907:944e:b0:a55:7e8b:bbfa with SMTP id
 dl14-20020a170907944e00b00a557e8bbbfamr2518998ejc.10.1713957276939; 
 Wed, 24 Apr 2024 04:14:36 -0700 (PDT)
Received: from fedora.. (cpe-188-129-47-121.dynamic.amis.hr. [188.129.47.121])
 by smtp.googlemail.com with ESMTPSA id
 ju5-20020a170906e90500b00a55b35b57a7sm3964553ejb.62.2024.04.24.04.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 04:14:36 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/3] mach-ipq40xx: add CPU specific code
Date: Wed, 24 Apr 2024 13:13:56 +0200
Message-ID: <20240424111434.373920-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.44.0
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

Provide basic DRAM info population from DT, cache setting and the
board_init stub.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 arch/arm/mach-ipq40xx/Makefile |  7 ++++++
 arch/arm/mach-ipq40xx/cpu.c    | 44 ++++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)
 create mode 100644 arch/arm/mach-ipq40xx/Makefile
 create mode 100644 arch/arm/mach-ipq40xx/cpu.c

diff --git a/arch/arm/mach-ipq40xx/Makefile b/arch/arm/mach-ipq40xx/Makefile
new file mode 100644
index 0000000000..d611de9933
--- /dev/null
+++ b/arch/arm/mach-ipq40xx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (c) 2024 Sartura Ltd.
+#
+# Author: Robert Marko <robert.marko@sartura.hr>
+
+obj-y += cpu.o
diff --git a/arch/arm/mach-ipq40xx/cpu.c b/arch/arm/mach-ipq40xx/cpu.c
new file mode 100644
index 0000000000..0446627a8f
--- /dev/null
+++ b/arch/arm/mach-ipq40xx/cpu.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CPU code for Qualcomm IPQ40xx SoC
+ *
+ * Copyright (c) 2024 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
+#include <common.h>
+#include <cpu_func.h>
+#include <init.h>
+
+int dram_init(void)
+{
+	int ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		return ret;
+	return fdtdec_setup_mem_size_base();
+}
+
+/*
+ * Enable/Disable D-cache.
+ * I-cache is already enabled in start.S
+ */
+void enable_caches(void)
+{
+	dcache_enable();
+}
+
+void disable_caches(void)
+{
+	dcache_disable();
+}
+
+/*
+ * In case boards need specific init code, they can override this stub.
+ */
+int __weak board_init(void)
+{
+	return 0;
+}
-- 
2.44.0

