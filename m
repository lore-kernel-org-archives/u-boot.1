Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 467E6C41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 16:05:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 715D18781A;
	Tue, 19 Dec 2023 17:04:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fUvKd7oi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7972887775; Tue, 19 Dec 2023 17:04:32 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3641876F2
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 17:04:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40c38e292c8so24189465e9.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 08:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703001866; x=1703606666; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2yMCPbZvHg5dQxeFWPPFiuNAoZLNlbdzcYsk9kLzoDE=;
 b=fUvKd7oixMtS9kwLZCNCxMAI0q8aPRic1dJWttthIvVqGcl+G07XI71U087mLq2Prv
 phfBc+VXTPegAMAN3KoxxtDK0+1b6DpwPgLXLU1zYbm9QUve1tM+e4iGYgY+TdXEUVl5
 Eb/A6PFCs6F+xhI9UZDWLVjzLgRsbonYjZ57ssi9ObACe9GvPCVAF6QVoVaYtKVaBU5R
 cP8G4gSc5358rhfyrRmfvHqfMzQx7O+2+FhKFJt9nhMiDf881a1i1TGjhQTo1npOa9en
 KcgatusioTh+o/YmKanyCOmKcIN3hH+W/ztxabrlSZip02LcDSy4Cxbb0sj/7acD0QKO
 GGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703001866; x=1703606666;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2yMCPbZvHg5dQxeFWPPFiuNAoZLNlbdzcYsk9kLzoDE=;
 b=ZGDsPdnJKhvb8nIoKXo+F7oBW5Xk3hF/r+yBtNZsIBVvUVbftg+TizYMkRbNgOZE1C
 e9d76sm3TUqZ0E0XgbzFNgF/Jap4N7YdF2s1LNMvAz/Qx6uQganrTN9QEQxIWS5Qwvfr
 I99hRUFuO7gHRP7jFQEaMp602sBf1ozA82w5FfPx0qInKkzasQk7bHxa3JhK2lMelgAM
 AiBUh3NQNsixUhf9mu6GlUK3HBS9Jea/xtk1FyNc7YvW35j+1gLLaBXaJdi1r+VFrAdF
 SS6TF7FUBCgagc8v9IKjO/JdQFsaWiPKK312fdoh6dJyHTYqVLk79WjrD8DhnZWhdbrK
 zKMQ==
X-Gm-Message-State: AOJu0YyRKALwO+FFtdWljf8m177Xn7b7PKpi6QISkKmb9/KOZsxaeqLA
 YnlXRgISqu8eiX9XGNyZNLCiAA==
X-Google-Smtp-Source: AGHT+IEScgqW2M9ZWVQ3c/xYLC5iRCXDsTh5BMlvDrAAS0Niktn+sSNZ8YkchpPIRuZYSgcB3qeofw==
X-Received: by 2002:a05:600c:218e:b0:40c:288b:a688 with SMTP id
 e14-20020a05600c218e00b0040c288ba688mr752893wme.108.1703001866266; 
 Tue, 19 Dec 2023 08:04:26 -0800 (PST)
Received: from lion.localdomain (host-92-17-96-230.as13285.net. [92.17.96.230])
 by smtp.gmail.com with ESMTPSA id
 je17-20020a05600c1f9100b0040d1450ca7esm3429723wmb.7.2023.12.19.08.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 08:04:25 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 19 Dec 2023 16:04:05 +0000
Subject: [PATCH v2 04/32] dt-bindings: drop msm_sdhci binding
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231219-b4-qcom-common-target-v2-4-b6dd9704219e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1257;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=QLv/i9nKDSKixmLjbz+tpo6tUL3ouZlsH6f2FdVmN8o=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhtTG/Yymi+c/ePTS5cM03+MvRB/mFd0RqXyWeuj1zHes6
 zrZD2440FHKwiDIwSArpsgifmKZZdPay/Ya2xdcgJnDygQyhIGLUwAmojuP4X8119YNi5Yx8RYv
 Mq6UquONPv3UlPHGBjXFesG055YGUxYx/A+ZK/GRvVllzmbeBxLzWiIWx375/fpD1B3T+NasH1r
 r6m0B
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

