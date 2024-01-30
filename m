Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3CF1C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 14:11:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A55587E26;
	Tue, 30 Jan 2024 15:06:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UTQMZ1CE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0176087E39; Tue, 30 Jan 2024 15:06:04 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9113087E49
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 15:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5102e2ab56eso3522439e87.2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 06:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706623544; x=1707228344; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dZTFZ0lIfVf8IrxAf21IF62soYa2qikbbT9sQMR7E8M=;
 b=UTQMZ1CEPGj61wRGoeYMVmN6oPfdqHTliZjGHBPxapaKbMsyEX/748DS1Vy3rmMgUj
 OVzrQflZJcGNOcupcUndv79mJtzfzvFWRTsPCHZVz/2DyZbKL8RC1WFYQ3szr6LatjhA
 9z0INzP2fgrNuvibT2IesCZ9mX2hmfaEq0WjqNrTV6zEBhHdCIrl7vH80oXalvICz88U
 UJSTwxp8iWFHbsARL0ARd273irUvYfJtK2ydLn7uggS63BV7qayL8LNhFjNGTF6fzDYr
 epRJWcWj58bHO6fFY/KC7qqlWTYuURonZ+C/25k2LmwqybVVFxm+6JVLmy7b9ekhzZjK
 5a8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706623544; x=1707228344;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dZTFZ0lIfVf8IrxAf21IF62soYa2qikbbT9sQMR7E8M=;
 b=G1cGF0tMO2NPLgNcfg3SgK4ozQukPMaMbhIwyVqhHdiZVgB3J04u+K/xT5Io6Okxex
 z1I0aFiZ7lXMSvPLKNQWexBkMqktij4SuRjc1o6oqA85/ehXW6eeOjkXvdsKrMAxwXoU
 H1l2gdpA4kngiw+VYSxGHoUkh4bnvQJ9TIjnyixsZIVzbjl8aTD09Y6W6ywUYYXBkKY9
 /XLhprSeW5HBTKbJqx//LHdqZhYCB02KHe14kBTGG1QEGadFCR3MGGipxz1ZWBl8Iwtr
 nGtXqb/uTfMy2zGxqi+Lb+x9dKW2+s8Uqjzk27XKB6ZPjWQKZJ1qh2N7GpQZG9ydMA70
 Yn9A==
X-Gm-Message-State: AOJu0Yzr5yU3sw6q0EKwqHqC2351EDnY/vArGL/zSle+CRf0L2O0FfS9
 LwOK+oNmoL/ckcfZpy4t/8XR82x3+UedtDy39inK31joDerCjBFbpNJWPXktMHQ=
X-Google-Smtp-Source: AGHT+IHF6/QyFddD3uPx9aKQzsuXFcn0b4AoTvII4Jq1ul6GXsMBjwJW3Qv16xD619bYwdmrZqEi7Q==
X-Received: by 2002:ac2:58d5:0:b0:510:cab:e772 with SMTP id
 u21-20020ac258d5000000b005100cabe772mr5176011lfo.13.1706623544052; 
 Tue, 30 Jan 2024 06:05:44 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b0040f035bebfcsm1799017wmo.12.2024.01.30.06.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 06:05:43 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 30 Jan 2024 14:05:20 +0000
Subject: [PATCH v3 32/36] dt-bindings: import headers for qcs404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-b4-qcom-common-target-v3-32-e523cbf9e556@linaro.org>
References: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
In-Reply-To: <20240130-b4-qcom-common-target-v3-0-e523cbf9e556@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>, 
 Dzmitry Sankouski <dsankouski@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>, 
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
X-Mailer: b4 0.13-dev-4bd13
X-Developer-Signature: v=1; a=openpgp-sha256; l=962;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=YAKo4Cs0IwjtiyPLkvl1DXS6uAH0J8ED4Ru+/tyQsow=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSdTEKN/4LZ7M6L96kd6hT3npBxcK32us4jh7q+lXB4V
 jBsti7sKGVhEORgkBVTZBE/scyyae1le43tCy7AzGFlAhnCwMUpABM5uYXhf6q/9ZZFr96tkq97
 tPboknWS1rfPOOdJZ/QXV2/wlkzmsGNkmPZ57qJ0x7uveD/n9SYc/niIS7Pc5kT/G99o4RijDZw
 3vgMA
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

Import the headers needed for QCS404-evb.

Taken from kernel tag v6.7

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 include/dt-bindings/clock/qcom,turingcc-qcs404.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/dt-bindings/clock/qcom,turingcc-qcs404.h b/include/dt-bindings/clock/qcom,turingcc-qcs404.h
new file mode 100644
index 000000000000..838faef57c67
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,turingcc-qcs404.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019, Linaro Ltd
+ */
+
+#ifndef _DT_BINDINGS_CLK_TURING_QCS404_H
+#define _DT_BINDINGS_CLK_TURING_QCS404_H
+
+#define TURING_Q6SS_Q6_AXIM_CLK		0
+#define TURING_Q6SS_AHBM_AON_CLK	1
+#define TURING_WRAPPER_AON_CLK		2
+#define TURING_Q6SS_AHBS_AON_CLK	3
+#define TURING_WRAPPER_QOS_AHBS_AON_CLK	4
+
+#endif

-- 
2.43.0

