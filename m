Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74512C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 09:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2560288671;
	Tue,  9 Jul 2024 11:35:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cpHDaNip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E36388633; Tue,  9 Jul 2024 11:35:00 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9982788599
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 11:34:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-595712c49ebso310181a12.0
 for <u-boot@lists.denx.de>; Tue, 09 Jul 2024 02:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720517698; x=1721122498; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1/oy+3IqC+5kQl8PWMQW3z9p6kippV7RnBhe0o9oXz0=;
 b=cpHDaNipj23GUBohbko6K6mO6ibBmynVx/GaOkTwURwms3Cjp+dYFf+wBj7uV49VOi
 9hfVTTQZpFdptpPLsvJ+8c1c2pmkADNsyhijE9LPZbrd0+NMyXX9mtEFjtF1V5WYMSKj
 pKkfMH4CZUYPeddMQYuqiwLIg2c+mKRlJE+9H+4v03N5LQWo8/9mupuJCLBuLvCn3xN6
 xnjpINXslTzoIFtpl0ctAjAK+t5wJcOnK3DWpSh5ReW4gIKm7jaT4M06ttDKPnn7JYcX
 Ur7Y+Asu7eifvhrjcoS/GbpZyBQCfP16yeN/OvKc8/VCJo5ul9BjKWL47oX+ZnVTynla
 amHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720517698; x=1721122498;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1/oy+3IqC+5kQl8PWMQW3z9p6kippV7RnBhe0o9oXz0=;
 b=jeikIcFsja6OxWx9TxKqN+bUzusVXzAl1EzZ1me05qKfdnpSY7ClEcjjHIS0GdpLoN
 ps/NOMjGUyrapdWLI12EdQ/ZlwYv+X/AQumCRUqPTEIg2E8bu/glNfXF3L1VULN7fmaT
 7YdOX/h68bOegIz62EMZT5ZYTC8vjkW1nMqu0YmA5mJanC0gGaN1DoSoOKp+Q28atvKw
 ma0sMCndjJhjNZM8otwCo6r6Bsmli21mGzXUWGKZRfDp2eqKY+pC5g3JtLnLMYn3TyAc
 U7QpT0DjggV2ESUmiRqDPdwAlvCigo4Rvrxx3Ivs5eAn9sGCLeMfHmPvHdif4z9GW5dK
 amwg==
X-Gm-Message-State: AOJu0Yz+fXJbEiuihVKP9/ygIAHP4a1PgLBlY8iR2yr1+pIZzCpt2hT6
 GdnS2ZTHk+ZpRJEPMBi80ni9S+x7knZd8eHM47gHIeAhtpJGLKcefJvMZdCQbtY=
X-Google-Smtp-Source: AGHT+IHje2lkrSnGpnFl5XQP0ts5WJs/mIKe5v82kCqQ/FP+ScJDVubfD7A9fgVFSnhoot50I5+L0Q==
X-Received: by 2002:a17:907:1c10:b0:a72:4b4a:a626 with SMTP id
 a640c23a62f3a-a780b89dde4mr167488466b.68.1720517698104; 
 Tue, 09 Jul 2024 02:34:58 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::18f8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a780a7fefaasm62884566b.140.2024.07.09.02.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jul 2024 02:34:57 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Jul 2024 11:34:39 +0200
Subject: [PATCH v4 11/21] soc: qcom: rpmh: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240709-b4-qcom-rpmh-v4-11-c06d0a26644a@linaro.org>
References: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
In-Reply-To: <20240709-b4-qcom-rpmh-v4-0-c06d0a26644a@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1037;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=dEWx0VCEvlzfufQk7qIGZ9d9o9zCXlKNzAcD9M7ua7E=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmjQQzMpEPzfV+LHqaHNKaBxJ/8IruQfSacX1kk
 ErPD5TdHcWJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZo0EMwAKCRAFgzErGV9k
 ttCcD/0Q6meB7JtBmtxCwJ5yA+AOZ7mo2B9cvM6KfSQ0AX0UsZwB8RcRF/O3TOFeamM43+wzxy8
 NuTIvgC3dHjL33O5L5jF1AZTBJPgeOAaCWvDCyV7ERgSULGA+/0tmIB0nLyNsJzhykkuxOsS2Tf
 nIckRmj0Y4KnDUvqXVX9b60xTlVx9Y2iq2vS0AJgM8qWbXO1vJSLWoCoygO1cUiRn1D8eyUqfr0
 e28nvqBVSLN0fUS6Z2tetlTuf0u+iSI8LL6+LZamjvqRFPboOZomjdvfSsvEFPEHaUnfvAmZqve
 RzubVkHOLPGurdidvPkvh5rBZhVIOe2en/eYiNL1FAOAXZMvp+/XBUAOuKuhJO52i0Tqo99g1am
 qeV64thPfMchx21POQ5x3dxQu5g1iwRH+dVMP6GsUf5SmNb6lKRoQ9LsMChdPCzn4uneIDg/BGj
 DlbhVcyEGhOW2vpAQ4kN0WFN/G9y1tgkIJ9Gdte1vBzxiNqkN9rdTM5cZDx/ccplMgQ362VP/Ob
 QEDXVNX9gYBEK/VHafdwEp3GGCg2Ul9tMUsPJ4nUCdP2UUkop5qN1It4948DwE5JlUO26g5FpVk
 WPHq0x8Jxw2qeyGvoyUAtATFx4v6Ni4xdS/1tw+g9Hh8lFXOfmq9jGvPeGV2ZOomnkvgDuXalmO
 h51pRtKT7FouA+A==
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

Drop unused/unsupported Linux headers and add dm/device.h for U-Boot.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/rpmh.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
index 8903ed956312..03ef4106c9a6 100644
--- a/drivers/soc/qcom/rpmh.c
+++ b/drivers/soc/qcom/rpmh.c
@@ -2,22 +2,14 @@
 /*
  * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/atomic.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
 #include <linux/bug.h>
-#include <linux/interrupt.h>
-#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/lockdep.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/types.h>
-#include <linux/wait.h>
 
 #include <soc/qcom/rpmh.h>
 
 #include "rpmh-internal.h"

-- 
2.45.2

