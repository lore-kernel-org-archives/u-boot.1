Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE49C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 22:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A726688692;
	Fri, 19 Apr 2024 00:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MzsT4PRa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC23488698; Fri, 19 Apr 2024 00:48:06 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C50188697
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 00:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-418c0d83e61so15236745e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 15:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713480479; x=1714085279; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5layRykKgdXVikCZs2hcIuHbtybfELpMT4BFSOTZRbY=;
 b=MzsT4PRaCWiFtdfUYgZ59jRVGF5AdaVcmcewKcWHSBeqkfAuMGc31jj7RrVCSVltWX
 iKI5ECo4aS+/9AilPUsEsTjmzkiBCuO93HnOa+vCE5dZ8O4bikYjznVaQsOzqEXJsY/w
 G7galBcicyW8i//Wnd88sSR2r6LhST7BOuS23vwIerWx7o0MUj7j96m25gSXoXg683Hr
 NRAzBBrUBdWwl1HzLVzatO0ZTDhNvJlP7NYxeAjUh3nx4gxDmOjcbCYSDwBoqUX42cmo
 8WWj8IOWo2K6438h6spAtnPSpNcGTwNhHrwrSnMsxgnflD6KdK/4z1we6UPdf967wKRx
 i8JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713480479; x=1714085279;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5layRykKgdXVikCZs2hcIuHbtybfELpMT4BFSOTZRbY=;
 b=O6nXW36bbsuP83HpDLSRwtnCHuU4dhtlH7fSOtrqKU++Cgrii8F7CugWv+1fTA/FNA
 bgXohKxNvgO9Pp4jT79f14Q6UqRZcgqlXevtCNVfoXhY+4BWVv9YYSqrxpO+3LrEWM/D
 q/VEMH7dDjYk1Ft48Susj3O7kqL8YJo9KCS5w2LJssSqPUMHzoE3e0Z4T931n43ieudR
 +M4rM2f4W49TVbPh72PmxgZrr8XLbrINM3ePg2KjmnFXFg5r+jYwQFKwE/YeqwGEj0ZZ
 OZx02F8vsw0OSfh151k9pixg13hsTLqWjghCnenPs151wtxZR0Lo77O5PdrpGJOt35Bw
 Lf6g==
X-Gm-Message-State: AOJu0Yy28aij3a5gt6nbJJrA2TvdTmciZLBEiStwv14qcswuY13CaXfL
 zOy7em+gT0N9SYAZAad8E0W0YAAkqkx5L+oJ8gbLWqzB3aTKMTZXHoDkE0HsECo=
X-Google-Smtp-Source: AGHT+IFGtZ1UvJOyFoZBeyczlrk3UV3nV7bBU7JeIAdTYyuCF815mOy9Gow5sL4PZtZpL7TCTDL8EQ==
X-Received: by 2002:a05:600c:1da2:b0:417:e563:4aa4 with SMTP id
 p34-20020a05600c1da200b00417e5634aa4mr188686wms.5.1713480479407; 
 Thu, 18 Apr 2024 15:47:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 hg12-20020a05600c538c00b00415dfa709dasm4155131wmb.15.2024.04.18.15.47.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 15:47:59 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 19 Apr 2024 00:47:54 +0200
Subject: [PATCH 2/2] configs: qcom_defconfig: enable GENI I2C Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-topic-sm8x50-i2c-v1-2-67651e27f23a@linaro.org>
References: <20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org>
In-Reply-To: <20240419-topic-sm8x50-i2c-v1-0-67651e27f23a@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=568;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2pJ0i9g8zUz/8GB20tjE6EI5K8UDNuHmUKOn26+AIns=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmIaMcPWqzAL/hgw33cvh/yKcJauNefOUiyHhQ0JjZ
 rhwgiRmJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZiGjHAAKCRB33NvayMhJ0eAAEA
 DQ2de4MDqzoh6T3ZsAZvyppeJoYU5N2UtDvupWATWmY9jQepW5rILU/jB6RCvDNE8Z3XQTovS4oSzi
 M/n5bMxg3xN5LJOnijhWO9bkr4eZB3Ra44nl4eO/yZ1LrKAnsWsZysZAvD0QxndRi7AUfVdq8VxUEv
 0jaW/5RoYJLcif3DqZ1QAKbKETBjGoviQt/A/H5C680eld0/UNJOs2QR7oKgAPjNcf4pzr1GHc6bw4
 U4yzskLRvzDzvuz27oZq9G7zjrjnGEMWEnJjKnb4arCPRrCHEqu2eDxx0Jqc296yRFanG+wRDOJ414
 1+GK/6KFewKJz02YC1oNo+wNi+AOJQeD9ktS4vbZjkptAk1yzKd5tJw+XhBUKgqRzjLkk9cE2Boq25
 qDlyWi0+LyDmb9lhoa9dVZzhJNKzcIldwO3bF2x0jNBlOKykW3Bq9zRsHL3oUt4f6mTWxY6gydb8O2
 nyRYGkhs305ZOQplM+t0pOX6ujStj8wLsjmPNLBE6oZzkSewwmEbwUNx6/pJFuGnyWWHtxE8AT5pyQ
 BcNMwOxELGKTSrZ7pXswauO0ZtCPE+kjwdbNNnx4RHM3q/DAd5hQSTqnpshCeGGGzFkn/2WXM2sML9
 aIDBj3FGzI4J2+MrUzpBW+GNTCRCJeLWZ8hbNYdDZHe/hZ/oVoBMN06zneUg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Enable the GENI I2C driver in the default Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 1abb57345ff..8d440b23625 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -41,6 +41,7 @@ CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y
+CONFIG_SYS_I2C_GENI=y
 CONFIG_I2C_MUX=y
 CONFIG_DM_KEYBOARD=y
 CONFIG_BUTTON_KEYBOARD=y

-- 
2.34.1

