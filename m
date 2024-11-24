Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE6BE668BC
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 19:19:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3154899BE;
	Sun, 24 Nov 2024 20:18:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Et873+BR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7084E899AC; Sun, 24 Nov 2024 20:18:01 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DDC289986
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 20:17:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aa549f2fa32so80085566b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 11:17:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732475877; x=1733080677; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fbZv7I51Fvc8FujdGK3KkOlLr4aE65D95KWDsJk/+u4=;
 b=Et873+BRKrbyghp5Sn1l8z40o5B3SacSbV3RWmsPfshyK2P5/r5jIj5pIzsFuTjGOx
 ety1JVyhPqUP2pab31Hjs2XtETxL2pTAwnJy9eZl32VmGpIDRAupfI/HWROd/aAb48tn
 dnfhAg/y0yDGnKZT1suBtF5d4ly3B973nDQVVdi3wHEZEVMTBaAR9GoxrAz31ZGIxdU2
 NBRd+Oy8NqB+rwRXtZJC5Vhm36U1SXo20u4Yuv/bVgObLoKvsulvCWSgc6fCtzUYYe4x
 a8NVT9DwDUjs5ZHbL0NGX3vFKkRC4t5EGzjwZw2+cVs/+n381jLxKes6hMT3KQa2ikdp
 pTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732475877; x=1733080677;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fbZv7I51Fvc8FujdGK3KkOlLr4aE65D95KWDsJk/+u4=;
 b=h5Qs5Xytq+M6wc6KsVqc1kgZ6a7VKSyNsbq2r1JLNnHIMcXrne0mk5tkJI7kubZpQu
 e2tK2P9YpQFNcFuujQHpu7dTodQTdj88mYqDVHmr02SW0DocDSn27h4Hj/s8YzKr0dHY
 jHI+Zz5GEWwkdKXPig39ObB/OxaBzFS8ot1DpjiuMnkF36UItaQEc/AKO18c63QYCLmo
 8GSi0smbmyZaV21i3EQCr8xmhwE+ZG7ctvb9X8wTRj768SwLOwioeIkbViXeUZy6attD
 60jXovgCiAFMouILYtfw1YGk8n/hb+1deh6xNs7uCY7kPKaumx5sYqxmR33TMFjf6zvt
 zw+Q==
X-Gm-Message-State: AOJu0YzepB3pbU7Aw9iBP2SUCXyqxgi6dJ1SY5mW6AWaOGC2l0koiLu7
 yNoRpcB/43JF/l8ScUoLHMZBzGFG/aXfUZMGt2M4mGJj59nuT4mmM0rhiRArid8=
X-Gm-Gg: ASbGncsuUbNu3MAaVoogFTV0/EZkJ2bA2asJUixP3f7FnGlwmhz9F/2Jv99k4wcD/mm
 6GSwsJempIZrv9mMEPZpAAl1hThZAT3Wz6Ju7OFB6mqQwfAMqCgU7Ylr2xWYx5jhQvBE/Wu7aVC
 Aj/guDyHudR0W9QPC5vHInFltoL1t8bmkKC2yrFTnI5jL5V8Wsh1tgPaedeUy5s90/OhWIyRKnI
 CyNviteDcdzI5Vcr33a/Qyd5DKzH1UiXwPuTsfiZkOTVeleBnVCWjAgMIRj/FyD6rVx
X-Google-Smtp-Source: AGHT+IEaboD9LIiolLUR2e5COxF2ZGnT1c6JAqfc6wzzO9A+JN0jXWZ42Wf75KxgKWkDCVI27palsA==
X-Received: by 2002:a17:906:9c2:b0:aa5:297a:429f with SMTP id
 a640c23a62f3a-aa5297a431cmr640441866b.51.1732475877104; 
 Sun, 24 Nov 2024 11:17:57 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28f848sm371874566b.36.2024.11.24.11.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 11:17:55 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 20:17:51 +0100
Subject: [PATCH 09/15] soc: qcom: smem: stub functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-modernise-smem-v1-9-b7852c11b67c@linaro.org>
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
To: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Mario Six <mario.six@gdsys.cc>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1326;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=0Q7QWrKEhKPoIqHJdNt08/uJsx0eh4DAgJs/Cmym8Yc=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTn6psnKzhEp80KPNjBdqWQ+67q+oS312dwLJyRd0j1e
 u+5qdusOkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEtGwZ/icx90b/enFIYXXN
 vX3C7dJumxsWe3p5qn88suf+vqiVwicY/kdzsGZxbW75M//v6tmP5h83U/Lp2SD9ZJZGwey5GxZ
 I+O4AAA==
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

Allow smem to be optional for Qualcomm platforms by providing stub
functions.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/soc/qcom/smem.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/soc/qcom/smem.h b/include/soc/qcom/smem.h
index 755003807dba..586432412eb8 100644
--- a/include/soc/qcom/smem.h
+++ b/include/soc/qcom/smem.h
@@ -1,16 +1,36 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __QCOM_SMEM_H__
 #define __QCOM_SMEM_H__
 
+#include <linux/err.h>
+#include <stdbool.h>
+
 #define QCOM_SMEM_HOST_ANY -1
 
+#if defined(CONFIG_QCOM_SMEM)
 int qcom_smem_init(void);
 int qcom_socinfo_init(void);
 
 bool qcom_smem_is_available(void);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 
 int qcom_smem_get_free_space(unsigned host);
+#else
+static int qcom_smem_init(void) { return -ENOSYS; }
+
+static bool qcom_smem_is_available(void) { return false; }
+int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
+{
+	return -ENOSYS;
+}
+
+void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
+{
+	return ERR_PTR(-ENOSYS);
+}
+
+int qcom_smem_get_free_space(unsigned host);
+#endif
 
 #endif

-- 
2.47.0

