Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 456AAC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 17:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78B087FDB;
	Mon, 26 Feb 2024 18:27:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TOboQ9F0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B400C87F74; Mon, 26 Feb 2024 18:27:23 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3287E88017
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 18:26:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33d28468666so3072332f8f.0
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 09:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708968418; x=1709573218; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hODeMOfRag1YwNlFG/sUAoPCcpATRYPeZ5Myb9i7fps=;
 b=TOboQ9F0Q5w/Gr3r2EuZS4XEWjj+K3jViYAkmE1Em8PuY4kpfmiPu89ilfE5ejmix9
 kc/Va/HnVaA5ltXE8w1TP5h1QsTK4typdpzsE9HqgsugkdGfNirBuLre3/VWffGNz/3c
 KTktLvzlhySfJ/2iOCtzbIAeupUuj2cuGfaQ7WdEDs+fSCT4NOSdWyKOKyZm3109dPf1
 jIvcTywMRjzEPcspT0feVMek1W/NBjTtEgpAUP+Ic+6Tf/hB+roRTluDXhENtvBP3s46
 LxZIuGhwcbHrbW4t5A91ukUUUEFZi2dHMW2Noink4ee2IWS8rEgaWaWjtAks3tKci4y4
 ayCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708968418; x=1709573218;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hODeMOfRag1YwNlFG/sUAoPCcpATRYPeZ5Myb9i7fps=;
 b=paRh3IOyQlpqYSYQK3uFQWhZ4eY1sGCqccz4h6iFwep6vlo7EWLalb0uJPLpZZuPlB
 Rr6Y+qFHk6ipyc3Z33gxOpfvHoFlCUCMI384GrwtPeovu/5PvmXaQKs3/7Ban5++SbHH
 F9g8a3FGk03xUBZQ1neg1OUbC/acHa+1ySIB4bwnO6m6ZQ+aZ6FMni4TDa+4+MI3rHnv
 terNlNSC04OWKX3Y3epZtgOAzmevwr2PENNKCBOaP6aJcNIizeyTbPMqq365y+Cj8P9H
 SsZ4imYoyOXveA/gslVZVZ23Lig4NUx2DUCNVFwcdBT+EJgHuV8u7i7LHOjgKw1c1ddY
 Zr5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUulLIQ62x8PcpL2vP5T4VwOIMewIbI7i4lzOdZmRb+0NYRm6Rjnc6clY0Rgcgnkti5m5ffXrF1Boscei43zqwIwcGUmg==
X-Gm-Message-State: AOJu0YyV5Fvjug4uwEQgVGrEeKPWTKz+hoJThUeo7e9RNCwdjlECsKae
 P3BQarbw4r5GsW7kqd/2flYfVgLRWewtSfxap40HdvCoaXt9GiIy+o7A2DvXFo8=
X-Google-Smtp-Source: AGHT+IE8MnHqMnLKuuVL3J1VWcWSuL6Qa+BKVc58KVA2A2YzzoGyOSTF/IJ/mURwE8n8MnZk+93wZg==
X-Received: by 2002:a5d:6b0f:0:b0:33d:c6de:5b51 with SMTP id
 v15-20020a5d6b0f000000b0033dc6de5b51mr3262725wrw.33.1708968418793; 
 Mon, 26 Feb 2024 09:26:58 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 bt1-20020a056000080100b0033d9c7eb63csm9142256wrb.84.2024.02.26.09.26.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 09:26:58 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Mon, 26 Feb 2024 17:26:41 +0000
Subject: [PATCH v5 37/39] dt-bindings: import headers for qcs404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-b4-qcom-common-target-v5-37-10c8e078befb@linaro.org>
References: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
In-Reply-To: <20240226-b4-qcom-common-target-v5-0-10c8e078befb@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1011;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=/HgosspLAlPgKlCjuvcI7D3WR+ylek9WCRNALdnnMIE=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtQ7J/dM3yqjUlH998vMBYkpn2U91zjs8BB/XKq972Bs0
 v954nt5OkpZGAQ5GGTFFFnETyyzbFp72V5j+4ILMHNYmUCGMHBxCsBEFr9l+B82QWAJ70arNFmV
 9An9KuWT8+/mRIbZHbgrP2fNvYh3yoWMDOtO+v+2OX/5lPLfu6I9fzZwcFqGBidNcWgoWGDqLLv
 k7GIA
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
Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
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
2.43.1

