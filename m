Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128D7C61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 17:10:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CD8687604;
	Tue, 21 Nov 2023 18:09:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hLan0rWw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1D2587632; Tue, 21 Nov 2023 18:09:38 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E9387618
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 18:09:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-40b2c9ee8ecso3370085e9.2
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 09:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700586574; x=1701191374; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2yMCPbZvHg5dQxeFWPPFiuNAoZLNlbdzcYsk9kLzoDE=;
 b=hLan0rWwomT19YdWlspP/9I43HGhta+nLwpY3kop1LZ88MPIcyy+vAtxy5X+HY/oEh
 ABojgbFf4oMWmtdLUK5NPnFrRPlQxgnjXgsxQTEkWSw/1vKPwrAmUeNNjL1zg3HsZ1Dx
 C+SUynWsmwod4H93+I4P3c2jFXmlysoHTp0Mh74xdRHkppc/jlAsKj7hHs45B85+Xe+Q
 Pxxr2Zzyo7s9dQYrNYy3gmBVIHnVuJBGshjkgXW2BSwQlmb+6Vs4hLrW9YNdS3uJSDPj
 h+Lh8trAI200vmfVhjwf+kw9FMAQNz79CpOJO88UMZ5QTn9jIJg4YEjbp/zHh4MJJHzc
 p4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700586574; x=1701191374;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yMCPbZvHg5dQxeFWPPFiuNAoZLNlbdzcYsk9kLzoDE=;
 b=vRbGDo6yWwhPV665oGoIPtas85Q1Rr0XlYBPnJEHVL2QAmcRb4IAqPHTPtAFg3j4O1
 wAnflkUql10ahNUYbrb2e+5f2X/m8hjA2JNzKIukXGkd8jmMU+lmp8i0C3C3sMQGlXxQ
 Y3ZteVK/ewUNXd9RTSmzsr/9/lC/0hZANBpumY4qFqp/0G6SEpPaCbnSqqmnDlWizx2A
 fO8qMN8Pk+UmDVeMlrfoUTO8bR7HTsCEXjEJ4ajJtv/TA19F/LXiaBhnDDutqvx8lqMe
 H59H911wpyDF4FIDb/FDnxCnIN7DwUNNNsA/tW27OuJr1TYNmzJDGxqakbj5g9zMOZ6T
 DMPA==
X-Gm-Message-State: AOJu0YzG0WJd7MOg7BMaGyYQNPm+3bYaisuurRLAAobilFD3G8s3l6Zl
 8cdLP/Jo0vzF8k3CSWqURb4xLw==
X-Google-Smtp-Source: AGHT+IF92NcbRUPUAmYkbRSK0QcIb6c4n09Fpt7iO2oN3fBnyOt/w7Hpvqwz+NZhh4VGf5jX4QrxdA==
X-Received: by 2002:a05:600c:4f8a:b0:40a:5c71:2c3e with SMTP id
 n10-20020a05600c4f8a00b0040a5c712c3emr9155172wmq.19.1700586573934; 
 Tue, 21 Nov 2023 09:09:33 -0800 (PST)
Received: from lion.localdomain ([79.79.179.141])
 by smtp.gmail.com with ESMTPSA id
 1-20020a05600c230100b003fefb94ccc9sm17345812wmo.11.2023.11.21.09.09.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 09:09:33 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 21 Nov 2023 17:09:28 +0000
Subject: [PATCH 05/21] dt-bindings: drop msm_sdhci binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-b4-qcom-common-target-v1-5-9492198e0c15@linaro.org>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
In-Reply-To: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QLv/i9nKDSKixmLjbz+tpo6tUL3ouZlsH6f2FdVmN8o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtSYJ64PTxVPvr+Ta07V+UXm39eY9vWuOXwrZlmexYYd2
 vu/cjsKdJSyMAhyMMiKKbKIn1hm2bT2sr3G9gUXYOawMoEMYeDiFICJ7Ndl+J/Enz91Q+67+TeN
 JPM2nWxtalVyl9q74t5mzvDnTCyv9zxj+J/AsvrwWuugW7MNSw8v/hjc9SXz3NVlG3/vmuXn9LQ
 ufUU+AA==
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

The upstream DT is supported here, so drop the U-Boot specific binding
docs.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 doc/device-tree-bindings/mmc/msm_sdhci.txt | 25 -------------------------
 1 file changed, 25 deletions(-)

diff --git a/doc/device-tree-bindings/mmc/msm_sdhci.txt b/doc/device-tree-bindings/mmc/msm_sdhci.txt
deleted file mode 100644
index 08a290c66931..000000000000
--- a/doc/device-tree-bindings/mmc/msm_sdhci.txt
+++ /dev/null
@@ -1,25 +0,0 @@
-Qualcomm Snapdragon SDHCI controller
-
-Required properties:
-- compatible : "qcom,sdhci-msm-v4"
-- reg: Base address and length of registers:
-	- Host controller registers (SDHCI)
-	- SD Core registers
-- clock: interface clock (must accept SD bus clock as a frequency)
-
-Optional properties:
-- index: If there is more than one controller - controller index (required
-	by generic SDHCI code).
-- bus_width: Width of SD/eMMC bus (default 4)
-- clock-frequency: Frequency of SD/eMMC bus (default 400 kHz)
-
-Example:
-
-sdhci@07864000 {
-	compatible = "qcom,sdhci-msm-v4";
-	reg = <0x7864900 0x11c 0x7864000 0x800>;
-	index = <0x1>;
-	bus-width = <0x4>;
-	clock = <&clkc 1>;
-	clock-frequency = <200000000>;
-};

-- 
2.42.1

