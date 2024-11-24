Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB5D75E34
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:18:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E5F98999A;
	Sun, 24 Nov 2024 20:17:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RgrI1GPH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E98689578; Sun, 24 Nov 2024 20:17:56 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED0C8985F
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cfc035649bso5142523a12.2
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475873; x=1733080673; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZhiZzlhanjmoy/ixJ4Go/EF0N+6n3Z+6cx+gDfMUfLY=;
 b=RgrI1GPHDNT+BoKQ46ZJdUjJOwEEbxCfp9mD8oXMYStINPQuoXlUHQ/TpeB6yQi+Ow
 emrRDqLy0KqvkxBY8ZA2eCdthvSU6ISwLe9ffUvZzzYQoKqQdWvdyDSdYAEiTGjCg8e7
 oV2MqaY/t+LamJZY8c7l1wHhv60xFus01kRwnfnYaj4MF3Dl8YTG1sXlbuJIGWo7UQvV
 nzfu9KNk/UDHVgwvnbA9FCD/hUMSopRWkqXf+/Cd8CFCFyGEf+J35eIKi/Wc0OMHD/8h
 edjol1htPTDpCCb0xxCocFl2/NYkgrbeAZHJmiNLYM3rxKct5SPMdPqLabHKO9DE9WGL
 oQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475873; x=1733080673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhiZzlhanjmoy/ixJ4Go/EF0N+6n3Z+6cx+gDfMUfLY=;
 b=afUE3KFgBh8WBDydLZIm/PY8fAKtS/gYZtYQZza8nTJLfaBLh8wtnPfgCAaVZYx+xE
 sTwoFP/gTmeyRKwJGDaWkh9Y09wXzoTBmzQpmOIrtbHdQwbxpEznPnjRqjSS0S3ukhNP
 Lt8S9zemX+HU/rexElvE0RX8vocJlCZd4g5w/GBO9MQO0tomPfQr/vthHhyynQviScUR
 KA2evCZzl28Mpfq0qL9Ly0oten2zvnsWD+oaa/ZZhXAYtvRbnsmQ0rH/MH+wmeJnBFHp
 Oea08bBEmY4iupu6EghE/9ojTveI/PR3pECHz70mgxlsagIu0uDB5eHksd6k0s8oAns+
 32Ww==
X-Gm-Message-State: AOJu0Yxnv9WzS828Ox1+CUQIJlzGIo7s/OZ6k0H1gJvtKOYv0TIdGEgI
 lbCaDm9uBaCMJ5Hq5pY3O3fE2orfO1oZbXIZ6E+HIzfZQpR5h+8EHbxc/G3VCe4=
X-Gm-Gg: ASbGncus9ZOG2iluyfIEeIcsnPjuR3KUDVhmjJddH/4gTTkw3lBry7SgqJNrh5QNc7o
 8S7ewVKvu/BN/npca0uqEyHqZ/hVUInRAegoUtTaGtYBLRV5FYySvUArnXSUiN/8Np1/q7ItKfS
 YpQ8P29aRl1AcQcXd3d2yKg+mUYw7TwHeZYpv9RGqeCw5x+uFfRrA+eL9fiVnct/Ge9Kbajwvw2
 L1VhNhaReCAwiy8dVlLvxgOHsExq3gJbaeNiopuDzL+pUGODMZU5RWdFvn2EBiEZibn
X-Google-Smtp-Source: AGHT+IElDEkwt8XJ5yulrU4Pq/if/DW9+D+BvCy4uyWMzwkQB7j1hyGjqUJSFeo21z6BcV4IJpDg0g==
X-Received: by 2002:a17:906:1da9:b0:aa5:4d72:6dd7 with SMTP id
 a640c23a62f3a-aa54d7270bfmr179327166b.29.1732475873411; 
 Sun, 24 Nov 2024 11:17:53 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:53 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:48 +0100
Subject: [PATCH 06/15] soc: qcom: smem: adjust headers for U-Boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-6-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1249;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=GQ1J51ZFIFNTHz0+gEMUUTu+0fC1jmMmL7XJDNL8JQs=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6hv/pffmzdGR2nlJa9UhCZsp8UsfmAmWb+daecPzj
 wjTtg37O0pZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEorcx/M9UvPF072txxamH
 BGwq/7M+FDCV+tThoV305NtZMxaBtCZGhp0TKxeeM1rV+W+bYIyZVv1rsSmtKVruWof/L2Zjnqq
 7NQsA
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

Drop Linux headers for the U-Boot ones.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 drivers/soc/qcom/smem.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index 8515b8ae7777..7143856e85c3 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -3,19 +3,17 @@
  * Copyright (c) 2015, Sony Mobile Communications AB.
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
 
-#include <linux/hwspinlock.h>
+#include <dm/device.h>
+#include <dm/device_compat.h>
+#include <dm/ofnode.h>
+#include <linux/bug.h>
 #include <linux/io.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_reserved_mem.h>
-#include <linux/platform_device.h>
+#include <linux/ioport.h>
 #include <linux/sizes.h>
-#include <linux/slab.h>
-#include <linux/soc/qcom/smem.h>
-#include <linux/soc/qcom/socinfo.h>
+#include <soc/qcom/smem.h>
+#include <soc/qcom/socinfo.h>
 
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors

-- 
2.47.0

