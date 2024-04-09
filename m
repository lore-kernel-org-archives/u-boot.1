Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B3BC67861
	for <u-boot@archiver.kernel.org>; Tue,  9 Apr 2024 18:04:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFD8F87F01;
	Tue,  9 Apr 2024 20:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v2kzf1sa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7081487DCA; Tue,  9 Apr 2024 20:03:20 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FC2B88198
 for <u-boot@lists.denx.de>; Tue,  9 Apr 2024 20:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a51addddbd4so479014166b.0
 for <u-boot@lists.denx.de>; Tue, 09 Apr 2024 11:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712685796; x=1713290596; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fZ0Qlh1Opm2kOOa7cUT1mrSTjeJPcggoDsoX+RHEsXs=;
 b=v2kzf1sad34wKXK/L/RiuBt5XDE9jHV7k/d36m2yQLB38BCvd0OBP0OSr2mG27mxwl
 m3784li5Qcb87ycJm/hkfaZqcGrW1qFu6H/juaQe9/rHXSloDHT8wGgOXkgonjAj2nSx
 oJNexpZyXvA5TxX3XsHbbAWgJJN+onfiuOH1C3SHvpPukj3IM9jGsKbbLH234iofN0Zh
 L6NHLIm2BUKmpZPb2OraiRSWZ6VF8/WvE8Vm49A+kBCN+mEgz3gyhH3yd1j89neAa4ai
 kwFGgQfT/FbmJQx26/MHTLlaqXAgsYZ5ijDu+vFEOAouQkbHZckFPvIK7mG5qjsvwqNS
 UFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712685796; x=1713290596;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fZ0Qlh1Opm2kOOa7cUT1mrSTjeJPcggoDsoX+RHEsXs=;
 b=kT7N6CCiJv9s/wGyxPOR0hAqis0dEXJvm/GPEcWf/ciCiCTJ70egkZrM9ksbGbqonW
 Lbqtqf4d29O/Xg4OhaHDXsI8pT9uCnwPw20izcfsN1ID3MuqHva1gjch5c5M/xhdSnXb
 yca3LaFAQII876o25R7xE3wZxsTnRbLWwCa6J1wzaAl68lnlRAep6sqB1rudyTuspHxL
 8FshAGrr+8Lfj4F6oUpW2kmaAC7Yo1SPt7uhc/j+ztMyLQQ0aBMBUhKBIKsXs+B9dz3T
 PQ18hwDbuITxEpI7abo9hzZ65EmzImV3wP/5HcoIOGautoKrxmWV7KTKVNd1u721wKOq
 LM4w==
X-Gm-Message-State: AOJu0YxOn7/7YCZ8KGulB/bFCjntfb5QSKhQ9YIL7oJFB0l47hBmKWWY
 2soBEioBNv5GlJY/n9LcjfU5yhD5RXoHCHtc7O6G/8Ufqj4arT87zCJN6gX/BZo=
X-Google-Smtp-Source: AGHT+IETF1WAPhv6F990uFFHDwn50WBmt85FR2sqygrJ1tNzR+UO+olmrkkbU5RK/36BGv0xcweS+w==
X-Received: by 2002:a17:907:968b:b0:a51:d1f6:3938 with SMTP id
 hd11-20020a170907968b00b00a51d1f63938mr166603ejc.42.1712685796674; 
 Tue, 09 Apr 2024 11:03:16 -0700 (PDT)
Received: from [192.168.0.113] ([2a02:8109:aa0d:be00::570d])
 by smtp.gmail.com with ESMTPSA id
 d4-20020a170907272400b00a4e5866448bsm5928783ejl.155.2024.04.09.11.03.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Apr 2024 11:03:15 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Tue, 09 Apr 2024 20:03:06 +0200
Subject: [PATCH 7/7] dts: sdm845-db845c-u-boot: adjust MMC clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-b4-qcom-mmc-fixes-v1-7-5039164ecbf7@linaro.org>
References: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
In-Reply-To: <20240409-b4-qcom-mmc-fixes-v1-0-5039164ecbf7@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=784;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=SvaptCVs6q8sz0/p15Ii66d2UrAbTXUC6dXIwR0+daY=;
 b=owEBbQKS/ZANAwAIAQWDMSsZX2S2AcsmYgBmFYLYDj4JPK9t5f5YjCjTOm/b8ewsIb0hfJ4pU
 IlHsvkhGpiJAjMEAAEIAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCZhWC2AAKCRAFgzErGV9k
 tkJtD/9Wik1GfDq6hwS/r6fi+xnhfUzHID75m6nq9tVFXqYSyeqMh71pszCTvrZ5NIMmG1IiWo/
 ZUoozBtT3D6zNyn3zQvg/vpvgkJ3/weZ/vpeoTxziGjzkz8MXn1gpn0HjP+qqW24L7RXPyqLTH/
 eRFFX0MSSr6NJhO+f6rG1hdzjTZDCtWIY2P4pQ2bOA1jZohsjufMLxNmp1lUEAUaGF1Bky4NR/h
 9OniuPB/ow7ReVMID4JiPXANzxQSS+jVyuY+zcxSL1wxAnfYkPOSQZ4bq92IjI4PUwhGxU2Niyj
 CyKkAM1uaGH6eGl/4rC1NLRMjeqlOffReqi9a4R4UGcgpvdaJ/SWndlyaPnGdY7wLKHKMQlvaK2
 7XD3mnCC/HwPBbPb+dcETRJSN8SNGqbZ61havOAhslwHKipCPyxSEP9Pr7PzrSCOIjUmcvNZ4JQ
 3Gov8tq3uvPQzQVmI/aQbVx9RJ04UQctgrocja6E3cgruKdejrhBTHt3IrrEl4LXXR0GO3vZgXb
 C9/H+OwWg2bne6G1bL7dnEcI3pw0SKm2ta0qK8z3z4aeRDs3JY8EhMwHKkajPcirnqHfdPnwjkJ
 UYrBFCZ8qJ/RDECgY3KKqGA3fP9viI7uRGs58fsEJ3RtSl7tZAj/4bIYecpXFLdvnVg5VYi+be4
 hKCwTFst7qmlRhg==
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

Remove the reference to the xo clock which is on the unsupported rpmhcc
clock controller. It isn't needed for MMC functionality.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 arch/arm/dts/sdm845-db845c-u-boot.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/dts/sdm845-db845c-u-boot.dtsi b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
index 906f9faa5451..9e4533e603c5 100644
--- a/arch/arm/dts/sdm845-db845c-u-boot.dtsi
+++ b/arch/arm/dts/sdm845-db845c-u-boot.dtsi
@@ -6,4 +6,11 @@
  */
 &pcie0_3p3v_dual {
 	regulator-always-on;
 };
+
+&sdhc_2 {
+	/* Remove the unsupported rpmhcc xo clock reference */
+	clocks = <&gcc GCC_SDCC2_AHB_CLK>,
+		 <&gcc GCC_SDCC2_APPS_CLK>;
+	clock-names = "iface", "core";
+};

-- 
2.44.0

