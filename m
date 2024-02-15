Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843F4C48BC4
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 21:01:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 454DC87F20;
	Thu, 15 Feb 2024 21:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ufmgxeaY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A37887F97; Thu, 15 Feb 2024 21:54:09 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F30887E85
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 21:53:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-337cc8e72f5so49216f8f.1
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 12:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708030384; x=1708635184; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tU86BR2yf6Sy/cWeox8RiBDvbI2PuPfRpCL5s8N+Nt0=;
 b=ufmgxeaYZKLvDMe2yZ5bP3rm6NYeYJK0fV3cVISZO3YTzA79la3cNxFn5kqNct7ZHp
 +psskvg4HgEZh6nU2CdgWVMdtZEFBIsE0q6Gvm34ZdpZx2P9WoEcG4nG6bNatdBGYGed
 NM7Qna1FAlivFUcV1RXQGGuFE7aIrMcnm2mzwvtx2E8ZLqDqNvBjAcpCAfYmBnAi/YDQ
 oJgrj19A5s+NLLhDPrL5DCON7T+uOLqZvzbvxQTCRC+Ge5PXH56H5FOCzJZsNlBa6MbJ
 G5pm0HNeSYH/Z5V0nRPokEFeSHZ5/1qDKVw9v0il1bJvyn6/abCXFZ4WXB8xmRGMamHJ
 17ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708030384; x=1708635184;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tU86BR2yf6Sy/cWeox8RiBDvbI2PuPfRpCL5s8N+Nt0=;
 b=jWblNq3gYP6Bp9srbwCvWDJyFVy195F6QLwCYtlECWcn/0cCCV5nvOYMmFFIMUB77a
 3/58rIOPdQiboZHwpNkzPFlYVr4SPJZzIfz5BIBiyUBU/3uBKBmgmePo4HlBuQV2uHdL
 ykXczWHZK3zJs+u9wCJJUPB2E789weYHisYsfRg7U6U6FH1bj+NnhRC9VbrMlH7SSgBR
 6Em2hrP5ZzNrHzBRdoI3t6pQpLipGPl2PYvi0wAk/NDL7PxDQk/mITymT0yFrf58+HWM
 GrVD0DjsApueYVx6xp1g/X88n5e2X3M9yW6Z11KWqlYpMCqsf+koPyMiFzZr7fDHXsQb
 17xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXB8FpuXF+IjT6GekyRUSRUuMsn9x6F0Jas3QByG24zE7vsrxkHFCenDXnS33UuH160NNfiXygtIeuCjUe1VTDl0gIOfw==
X-Gm-Message-State: AOJu0Yy7rWBhRypU39IvQPm7FdyC9rSUQ9K5FaEFGZdbOYTQ+ak9955k
 zQ7pjjAFx0r4gblb4lSAhNihXf4wN58LcbhTjC3eKs2mBkSZN1sJ/X5e2FuOXYUqoOtXKJp1zjJ
 Y
X-Google-Smtp-Source: AGHT+IF71G8ZuEMACTQrqHG3vWyDHSGWNXGhEvng8nIIIXf5NQQwtrlZN6vNTyxe9xKJMrVC7LD0iA==
X-Received: by 2002:a5d:5387:0:b0:33d:13b6:1dd6 with SMTP id
 d7-20020a5d5387000000b0033d13b61dd6mr1104759wrv.39.1708030383821; 
 Thu, 15 Feb 2024 12:53:03 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e4-20020adfe384000000b0033cfa00e497sm194025wrm.64.2024.02.15.12.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 12:53:03 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Thu, 15 Feb 2024 20:52:55 +0000
Subject: [PATCH v4 37/39] dt-bindings: import headers for qcs404
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240215-b4-qcom-common-target-v4-37-ed06355c634a@linaro.org>
References: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
In-Reply-To: <20240215-b4-qcom-common-target-v4-0-ed06355c634a@linaro.org>
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
 bh=9J0fQlSwIiDEiiEP9jBoxqBWdRjc3jE0Kbmrm33oPaA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtRzle2FfesWWNxJMBMuPuQvyhezPnXfNoPJJvttjhik+
 RZu+3iqo5SFQZCDQVZMkUX8xDLLprWX7TW2L7gAM4eVCWQIAxenAEwkqo3hr9iU3j0HzOo7RXfc
 n1cQyjVXM2OlfLh6upGZSLb29sOdiQz/Ax1e2woqZ51b8XDLp9L4olMvucLXynD0XrwguTLbo0l
 kNgA=
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
2.43.1

