Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC195C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 17:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A175187FFA;
	Mon,  4 Mar 2024 18:45:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S7OLRalm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E9D387FDA; Mon,  4 Mar 2024 18:45:20 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF2F386F6E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 18:45:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-412e41cab5aso684325e9.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 09:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709574316; x=1710179116; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=29ZfrGGPw9deOi4jp/M1SFPGboRFKNilOsGHVs2N7NM=;
 b=S7OLRalmP5riUdv+Ei3Br904aaVByD7F2acPwODWfnvp9lhR+2kTLbGvTleJB18EIU
 aD5TzZ4YGVBgr8nqf39ouSb/9NoW9dnUu+cSCHcj44gaDnb2rAm1DstMV0IiLMi4Lz78
 z0togSaLWDXuZRF87sYki/3UpVo5fT5kTkzkUjXcqH/NkVtWBOB7aEiIiNBJHlNhF49H
 BmO5eRkN9VVoMkohragYzs9KywtNxln63xzMpMHKW+5f3XwdT/YlQlKEKWfFSJuXtaXV
 Om4RbaCAH0/W2NqRVIBf1PfzKLqsYI9mwFSEUZhs8GuIiKXpeWNqZMJrfk62f1apdQRf
 CwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709574316; x=1710179116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=29ZfrGGPw9deOi4jp/M1SFPGboRFKNilOsGHVs2N7NM=;
 b=OGn4IGpENIxqE4hWK2wtrR6muUMvRZVWbK9WyZX90vzJBfbGnbf9LeHZV+tzVPr1Of
 tmG8+JeIXd9s428oe04O3TFny0xq+r6sshu2NocTk9pg+QNH+65Syj7L88CiEW1Tejhb
 qBeYWsSUK/uGy3GijrcDdmpID0IAozzaGfRD+5dIyPEnsSr9qE+VacqvBVigNB1vXskT
 azJM4AH2orE0+emooXs4F3pnWxxcDRg2GqCk+srkP/PbYeAWGy4Lg3FOXil2UoA7BhHZ
 euNqvax3TpOnJZPEUYqrs2F1kPncgAOBwtUe6UDu634Ijg22tfhy7cU1c825YKwuEeXy
 qZtg==
X-Gm-Message-State: AOJu0YyNtnD5ty7UIkSoQ6wgwWclLdpZLisWwBFjPRtU3AjgacLiFgRV
 sRHJcVcqtf+Q92pqi6VVhXW+rYBcFAtGFrd71vHkdM/cbCb12vkCvPn/TY0ZWhI=
X-Google-Smtp-Source: AGHT+IFdjMHRzm6eT81ZzDa28Ao3iZlegKddAf5tV/YNkzElFU4hOX7zeRO4z1qVdeSIQnVqeJjRIg==
X-Received: by 2002:a05:600c:1d1f:b0:412:c327:4064 with SMTP id
 l31-20020a05600c1d1f00b00412c3274064mr7695664wms.3.1709574315603; 
 Mon, 04 Mar 2024 09:45:15 -0800 (PST)
Received: from localhost ([109.108.76.111]) by smtp.gmail.com with ESMTPSA id
 w15-20020a05600c474f00b00412ca1dc2e4sm11267844wmo.7.2024.03.04.09.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:45:14 -0800 (PST)
From: Igor Opaniuk <igor.opaniuk@gmail.com>
To: u-boot@lists.denx.de
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jens Wiklander <jens.wiklander@linaro.org>,
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 6/6] tee: remove common.h inclusion
Date: Mon,  4 Mar 2024 18:44:54 +0100
Message-Id: <20240304174454.1484507-7-igor.opaniuk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
References: <20240304174454.1484507-1-igor.opaniuk@gmail.com>
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

The usage of the common.h include file is deprecated [1], and has already
been removed from several files.
Get rid of all inclusions in the "drivers/tee" directory, and replace it
with required include files directly where needed.

[1] doc/develop/codingstyle.rst

Signed-off-by: Igor Opaniuk <igor.opaniuk@gmail.com>
---

Changes in v2:
- Fixed chimp_optee.c:37:9: error: implicit declaration of function 'memset'

 drivers/tee/broadcom/chimp_optee.c | 3 ++-
 drivers/tee/optee/core.c           | 1 -
 drivers/tee/optee/i2c.c            | 1 -
 drivers/tee/optee/rpmb.c           | 1 -
 drivers/tee/optee/supplicant.c     | 2 +-
 drivers/tee/sandbox.c              | 2 +-
 drivers/tee/tee-uclass.c           | 1 -
 7 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tee/broadcom/chimp_optee.c b/drivers/tee/broadcom/chimp_optee.c
index 37f9b094f76..bd146ef2899 100644
--- a/drivers/tee/broadcom/chimp_optee.c
+++ b/drivers/tee/broadcom/chimp_optee.c
@@ -3,9 +3,10 @@
  * Copyright 2020 Broadcom.
  */
 
-#include <common.h>
 #include <tee.h>
 #include <broadcom/chimp.h>
+#include <linux/errno.h>
+#include <string.h>
 
 #ifdef CONFIG_CHIMP_OPTEE
 
diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 47f845cffe3..5fc0505c788 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2020 Linaro Limited
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
diff --git a/drivers/tee/optee/i2c.c b/drivers/tee/optee/i2c.c
index ef4e10f9912..e3fb99897c5 100644
--- a/drivers/tee/optee/i2c.c
+++ b/drivers/tee/optee/i2c.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2020 Foundries.io Ltd
  */
 
-#include <common.h>
 #include <dm.h>
 #include <i2c.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
index 5bc13757ea8..bacced6af6c 100644
--- a/drivers/tee/optee/rpmb.c
+++ b/drivers/tee/optee/rpmb.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018 Linaro Limited
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <tee.h>
diff --git a/drivers/tee/optee/supplicant.c b/drivers/tee/optee/supplicant.c
index f9dd874b594..8a426f53ba8 100644
--- a/drivers/tee/optee/supplicant.c
+++ b/drivers/tee/optee/supplicant.c
@@ -3,10 +3,10 @@
  * Copyright (c) 2018, Linaro Limited
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <tee.h>
+#include <linux/errno.h>
 #include <linux/types.h>
 
 #include "optee_msg.h"
diff --git a/drivers/tee/sandbox.c b/drivers/tee/sandbox.c
index ec66401878c..8ad7c09efdd 100644
--- a/drivers/tee/sandbox.c
+++ b/drivers/tee/sandbox.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (C) 2018 Linaro Limited
  */
-#include <common.h>
+
 #include <dm.h>
 #include <sandboxtee.h>
 #include <tee.h>
diff --git a/drivers/tee/tee-uclass.c b/drivers/tee/tee-uclass.c
index 52412a4098e..0194d732193 100644
--- a/drivers/tee/tee-uclass.c
+++ b/drivers/tee/tee-uclass.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY UCLASS_TEE
 
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <log.h>
-- 
2.34.1

