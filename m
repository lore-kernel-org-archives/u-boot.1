Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0E1C4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BA388C4E;
	Thu,  2 May 2024 03:32:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UrbufoxS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B44888C61; Thu,  2 May 2024 03:32:27 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DD1A88C4C
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4376e3fd7e4so42027251cf.2
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613544; x=1715218344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3R2oW8pggIhKc9IxVXa4kvCD6AcBeZnkiFSHP48kRm8=;
 b=UrbufoxSsbdIk3EDSyScgpGfLdHP5+nAxTY45laOZlikyhSmP7nuolkBoqDghqtKqo
 2ohb/1Th6maZlsKSTBytDD671d/K5ztg56Jh40YQWbxnZ8hFrs8qyAbdlx7VJvSBu5BU
 ZSaL4E5jV7//FbaKm3ONi92VxYBXsdxTkE82Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613544; x=1715218344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3R2oW8pggIhKc9IxVXa4kvCD6AcBeZnkiFSHP48kRm8=;
 b=utSrdnPdVlocQFLdtIDFRSnj/58z7wkwWPctdsLJhnNQmhX8m7miO3xfxGMye+Vztj
 /S4h4SihBNzWznMRf3kL0lz4jk34JtpviAoTdJ3sSeY5GxDH5b3kAyWNpb8NUq+vv3wc
 dNlXqKMtow32MxoHpcELujUJwyfLnOvr5RcTRDLvGb+IO6tH+IWQcNy+B3+XauLjlyUl
 qd15p+q6xhWn0ym1+0DJHdAVLJCwJp3PNzHDxL/ocTYoeBEBeI2CICiEWShdbprPioBN
 oI0jnrg/smbFky79BxP7gNxOhvh+0YLxuCBzMYfVeXck1zaI2+psQXPxZnCgrTUOx5Yg
 CPaA==
X-Gm-Message-State: AOJu0YwDGzPfS/el/zJf3Eizr4To1wv1N/Dkr94mGvI0Rr8Z6w8lspmf
 1mKixXdsUoYERl23uRaj6fJXUF8SAONyo+d32DDVKIdioK5HbEO8Sbc54oLhMWg/q36UjXVlotJ
 pyd2kf6qF
X-Google-Smtp-Source: AGHT+IH3vnXNe7LhBB9nEcikYZHQUzByL3o3t2kY3iFRRVa7l2THMK0V4XKGc2oCULKAt3ku1226vQ==
X-Received: by 2002:a05:622a:2d6:b0:43a:abe8:1a41 with SMTP id
 a22-20020a05622a02d600b0043aabe81a41mr5156511qtx.52.1714613543927; 
 Wed, 01 May 2024 18:32:23 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:23 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Tanmay Shah <tanmay.shah@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Weizhao Ouyang <o451686892@gmail.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>
Subject: [PATCH 29/81] firmware: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:46 -0600
Message-Id: <20240502013138.2383421-29-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Cc: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Cc: Tanmay Shah <tanmay.shah@amd.com>
Cc: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Cc: Weizhao Ouyang <o451686892@gmail.com>
Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
Cc: Etienne Carriere <etienne.carriere@foss.st.com>
---
 drivers/firmware/arm-ffa/arm-ffa-uclass.c    | 1 -
 drivers/firmware/arm-ffa/arm-ffa.c           | 1 -
 drivers/firmware/arm-ffa/ffa-emul-uclass.c   | 1 -
 drivers/firmware/arm-ffa/sandbox_ffa.c       | 1 -
 drivers/firmware/firmware-sandbox.c          | 1 -
 drivers/firmware/firmware-uclass.c           | 1 -
 drivers/firmware/firmware-zynqmp.c           | 1 -
 drivers/firmware/psci.c                      | 1 -
 drivers/firmware/scmi/base.c                 | 1 -
 drivers/firmware/scmi/mailbox_agent.c        | 1 -
 drivers/firmware/scmi/optee_agent.c          | 1 -
 drivers/firmware/scmi/sandbox-scmi_agent.c   | 1 -
 drivers/firmware/scmi/sandbox-scmi_devices.c | 1 -
 drivers/firmware/scmi/scmi_agent-uclass.c    | 1 -
 drivers/firmware/scmi/smccc_agent.c          | 1 -
 drivers/firmware/scmi/smt.c                  | 1 -
 drivers/firmware/ti_sci.c                    | 1 -
 17 files changed, 17 deletions(-)

diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
index f1e91d151ea3..e0767fc75517 100644
--- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
+++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
@@ -5,7 +5,6 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
-#include <common.h>
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
 #include <dm.h>
diff --git a/drivers/firmware/arm-ffa/arm-ffa.c b/drivers/firmware/arm-ffa/arm-ffa.c
index ee0bf9a55b48..94e6105cb38e 100644
--- a/drivers/firmware/arm-ffa/arm-ffa.c
+++ b/drivers/firmware/arm-ffa/arm-ffa.c
@@ -6,7 +6,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <arm_ffa.h>
 #include <arm_ffa_priv.h>
 #include <dm.h>
diff --git a/drivers/firmware/arm-ffa/ffa-emul-uclass.c b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
index 4bf9f6041fec..1521d9b66ac3 100644
--- a/drivers/firmware/arm-ffa/ffa-emul-uclass.c
+++ b/drivers/firmware/arm-ffa/ffa-emul-uclass.c
@@ -5,7 +5,6 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
-#include <common.h>
 #include <dm.h>
 #include <mapmem.h>
 #include <string.h>
diff --git a/drivers/firmware/arm-ffa/sandbox_ffa.c b/drivers/firmware/arm-ffa/sandbox_ffa.c
index 11142429c09b..44b32a829ddf 100644
--- a/drivers/firmware/arm-ffa/sandbox_ffa.c
+++ b/drivers/firmware/arm-ffa/sandbox_ffa.c
@@ -5,7 +5,6 @@
  * Authors:
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
-#include <common.h>
 #include <arm_ffa.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/firmware/firmware-sandbox.c b/drivers/firmware/firmware-sandbox.c
index d970d75f781d..226b5cfc191e 100644
--- a/drivers/firmware/firmware-sandbox.c
+++ b/drivers/firmware/firmware-sandbox.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <dm.h>
 
 static const struct udevice_id generic_sandbox_firmware_ids[] = {
diff --git a/drivers/firmware/firmware-uclass.c b/drivers/firmware/firmware-uclass.c
index e83a147a000b..84caf25548be 100644
--- a/drivers/firmware/firmware-uclass.c
+++ b/drivers/firmware/firmware-uclass.c
@@ -2,7 +2,6 @@
 
 #define LOG_CATEGORY UCLASS_FIRMWARE
 
-#include <common.h>
 #include <dm.h>
 
 /* Firmware access is platform-dependent.  No generic code in uclass */
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index dfad798a2e7d..f99507d86c61 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2018-2019 Xilinx, Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 03544d76ed4a..c32c3f5c6a54 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -6,7 +6,6 @@
  * Copyright (C) 2015 ARM Limited
  */
 
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <efi_loader.h>
diff --git a/drivers/firmware/scmi/base.c b/drivers/firmware/scmi/base.c
index 1d41a8a98fc6..f4e3974ff5b4 100644
--- a/drivers/firmware/scmi/base.c
+++ b/drivers/firmware/scmi/base.c
@@ -6,7 +6,6 @@
  *		author: AKASHI Takahiro <takahiro.akashi@linaro.org>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <scmi_agent.h>
 #include <scmi_protocols.h>
diff --git a/drivers/firmware/scmi/mailbox_agent.c b/drivers/firmware/scmi/mailbox_agent.c
index 7ad3e8da9f08..6d4497f4b92a 100644
--- a/drivers/firmware/scmi/mailbox_agent.c
+++ b/drivers/firmware/scmi/mailbox_agent.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <mailbox.h>
diff --git a/drivers/firmware/scmi/optee_agent.c b/drivers/firmware/scmi/optee_agent.c
index 48dbb88a3fb5..631625d715bf 100644
--- a/drivers/firmware/scmi/optee_agent.c
+++ b/drivers/firmware/scmi/optee_agent.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index cc9011c7312f..19be280ec448 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <dm.h>
 #include <malloc.h>
 #include <scmi_agent.h>
diff --git a/drivers/firmware/scmi/sandbox-scmi_devices.c b/drivers/firmware/scmi/sandbox-scmi_devices.c
index 603e2bb40aff..96c2922b067e 100644
--- a/drivers/firmware/scmi/sandbox-scmi_devices.c
+++ b/drivers/firmware/scmi/sandbox-scmi_devices.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_MISC
 
-#include <common.h>
 #include <clk.h>
 #include <dm.h>
 #include <log.h>
diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 0f1003e167e6..8c907c3b0328 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
diff --git a/drivers/firmware/scmi/smccc_agent.c b/drivers/firmware/scmi/smccc_agent.c
index 972c6addde21..ac35d07ebaff 100644
--- a/drivers/firmware/scmi/smccc_agent.c
+++ b/drivers/firmware/scmi/smccc_agent.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <scmi_agent.h>
diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
index 509ed618a997..67d2f4500249 100644
--- a/drivers/firmware/scmi/smt.c
+++ b/drivers/firmware/scmi/smt.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_SCMI_AGENT
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6c581b9df9c0..8ce0f46e70c8 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -7,7 +7,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <dm.h>
 #include <errno.h>
 #include <log.h>
-- 
2.34.1

