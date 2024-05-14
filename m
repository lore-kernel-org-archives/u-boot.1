Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F11C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 10:18:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C50A3882B5;
	Tue, 14 May 2024 12:18:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sartura.hr header.i=@sartura.hr header.b="FKUVKik6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2303882DF; Tue, 14 May 2024 12:18:29 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0940877AF
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 12:18:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=robert.marko@sartura.hr
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-573137ba8d7so1162386a12.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 03:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura.hr; s=sartura; t=1715681907; x=1716286707; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gjkJbzeIPVwnUM2T+KBM9zS9cshui4x33o7GukKpnwc=;
 b=FKUVKik6WREsQivj1PFfwMtjsrbmpdI865k6B1xAr84RlDEPAstd4Jhr/kAAQycy+u
 IwQIGJFvWIyGGbeqMuhGmpG1PY5U0Sla3ZvvPvVz45BM9BWbYzYUQhJjVl5PDTebbP7D
 j2++7xSSR6pYvj+71qCL0pwQLmKZYoNx9khgzCQPnLdISHtNQbhYKxpZZ6nOP+hFVOrg
 PMaGrZzU5gbFFooKe1AqG3Ghzayp4W+dgKHnzNmY0FlIdQSXfoR7YLKZxZpwsOJTfHrP
 QTykL+34qTf+7Xr37OhgbrUKTyBZN1YY78CSf89Luhwvki0HYZb1ftXFtXHakCafJPLc
 8dHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715681907; x=1716286707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gjkJbzeIPVwnUM2T+KBM9zS9cshui4x33o7GukKpnwc=;
 b=CRErwu9hW7AZjJkSQ0DRRYRWiEZLvhMVtvMnVR5lsPgwDDIIOATrEEFSApHJ56ueQv
 k+uIO+qxKbzs2u8kGnF94bBbSJJbXOCho/vSx7sU/hmrOqG6JEwR8Lt4r0u9d6N9vRnS
 VSAGjtId3AQxFa4WWCYWIrBBGCWCCRO3ooTru+sBnPxcyksfnwLGQ5yA/jcnt17hyEdJ
 rCUbUuqwjJxmXmn5kC1SMj84b7Qg9jDIzq7WK19Ze9d7cQ7QqBqszjBQQ0bljkfe5BSe
 ISFfO+GIo6pfKeYGmHXqWg5kFrfbDCaZ96Pt+G7E2FZB/CeeZRhzV1D/rs2/UAgoyIF2
 646Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoP5mtXri/L06yX6zuEjfhfFl6zQB3rff3G7JYUiSk+E/6j7E4RwUcgu3td2uhOKVPGHKNnk2Z/pHddlk0wUpYf2rZKA==
X-Gm-Message-State: AOJu0Yx/Xdie88dmkrI/aqH+sz72X3/WUCuTNgs1KceCYqhgI8fqOaC2
 mkwbzabhp1v00qHV+LdyO7Z4YTduJA8VEhinbJBvfxxdm4Cnn3dd4bQsQgSCILQ=
X-Google-Smtp-Source: AGHT+IFwZzIFXTQvpBPc4C9gPdoODUDvOqt99ST1NUsMfTH3cFw/CY5iLWqZxH6fg8SqBdHzKbSMZA==
X-Received: by 2002:a50:c342:0:b0:572:a7c8:f12b with SMTP id
 4fb4d7f45d1cf-5734d6f3201mr9988233a12.13.1715681907441; 
 Tue, 14 May 2024 03:18:27 -0700 (PDT)
Received: from fedora.. (cpe-188-129-44-220.dynamic.amis.hr. [188.129.44.220])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-574ea5d755bsm261802a12.51.2024.05.14.03.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 03:18:26 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: trini@konsulko.com, caleb.connolly@linaro.org, neil.armstrong@linaro.org,
 sumit.garg@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: j.beck@linefinity.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v2 1/3] mach-ipq40xx: add CPU specific code
Date: Tue, 14 May 2024 12:17:50 +0200
Message-ID: <20240514101824.23872-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.45.0
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
Acked-by: Caleb Connolly <caleb.connolly@linaro.org>
---
Changes in v2:
* Drop <common.h>

 arch/arm/mach-ipq40xx/Makefile |  7 ++++++
 arch/arm/mach-ipq40xx/cpu.c    | 43 ++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)
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
index 0000000000..92c34d6111
--- /dev/null
+++ b/arch/arm/mach-ipq40xx/cpu.c
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CPU code for Qualcomm IPQ40xx SoC
+ *
+ * Copyright (c) 2024 Sartura Ltd.
+ *
+ * Author: Robert Marko <robert.marko@sartura.hr>
+ */
+
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
2.45.0

