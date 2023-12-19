Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916C0C46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:09:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B77E487889;
	Tue, 19 Dec 2023 17:05:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F1i88j02";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E2A3877E7; Tue, 19 Dec 2023 17:05:20 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24CBD87887
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so24192705e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001892; x=1703606692; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=C4Z3rWvg3d8+EMPqC3ah9SpgHp/fEMxlgs5cskmgTy0=;
 b=F1i88j02zMZohdWKJivr7rAuSc7LNYQTUcd7yRLyOzKregLeDqUxdw60GQ6K9+vtOA
 8hyhEU1ezuOZMFDkLL61qwZJrXxZw/X//du2wG5gkVsUYx5n5EDCP0/sG1nQkKPn9Lkm
 8ITyCY7EeQlhavSOiF1OHbdEKenEyeLX+EAUwlq5jtSXk+4G+QNfv3bEVvAo3E4eZ0n+
 HEf567++ADuvekzC4MJCZGd9zcnCLuxV6I30PXFHtYOfEHvsJ/stfim6Fso/UUhp7V9Y
 K8cXturOjQoIdcZpjQGhtCcb6aOw9CkJPEfJpP28jD5KoxbNxah5RHbbu0mI6fNuWBaW
 0Elg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001892; x=1703606692;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C4Z3rWvg3d8+EMPqC3ah9SpgHp/fEMxlgs5cskmgTy0=;
 b=lzPsp6op/KxRL+anmL/uLexzFZv+zTZsi/SEsjN76fUCwGlh3JKqTDKeJqPX42zELs
 fEvu8CNuwhGAIzOVHL9oX1msW+5obBsYCJ9ugWxJX8Wcu/x1WtKIFGbQTvJGw+cosr+K
 xJVdjpPhxxGjg9qNahJPcpKOSZPsObS+3y9x78DAQgq+X2c2YNYOofhUzY4vzIprN5Zw
 zQeT6vZnpJCFWnl9d3o5u5N4WjP8kvoaLtuUDJMubUZsRlJ6ExP+oB1eCWJ+3BsFX8fC
 U5mWZicL/IuE804xX1I3N9dz2tMzCgLZew7smjgPQjz5BBmhgxcG3/X5EKQXkDtWSynm
 wmUA==
X-Gm-Message-State: AOJu0YyKtY2Ub+b4yVb72AepT0HN6mjpFDSH6Tsjq9MRbg0+so8GLSII
 8O2m5C+epg3OMII3MWjBkGv8fVF+SHHCu/YjgufutQ==
X-Google-Smtp-Source: AGHT+IFFWPoWcU/zvFCHgQBJAnqtXh0GLuRp1K9wRlTdAGie9uLyHhU111nZPaPWQ49TU+IwB0gRag==
X-Received: by 2002:a05:600c:600b:b0:40b:4aef:deb3 with SMTP id
 az11-20020a05600c600b00b0040b4aefdeb3mr731460wmb.15.1703001892691; 
 Tue, 19 Dec 2023 08:04:52 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:52 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:30 +0000
Subject: [PATCH v2 29/32] dt-bindings: import headers for qcs404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-29-b6dd9704219e@linaro.org>
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
In-Reply-To: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=875;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=Cs7TXCesbr2enqwjyryK8ZRqkEYstbVM/ZnBMtIS82g=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/SwbWI2mCS/p23HG8+JU5dsbF/OwHtv+56KQ/Ybbl
 81VWJ/HdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ2Exl+Gf72nGT3zyBlnif
 tfbuM763anf+Ofb4xw49ua9RKhedv9xk+Cstrz3r0v+ifR0pVU9WW5x9rPU8lbvY/MFDvdfOC73
 l7x4AAA==
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
2.42.1

