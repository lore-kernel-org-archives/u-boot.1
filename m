Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35B82CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 16:47:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94B518842B;
	Thu,  4 Apr 2024 18:46:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pO7XVZp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B029B883F5; Thu,  4 Apr 2024 18:46:55 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6477883C9
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 18:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3434c6e1941so624069f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Apr 2024 09:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712249212; x=1712854012; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yvfvWjtxrrYGPRjEYYhtsRkqGsklV4tVehU++LX7zEA=;
 b=pO7XVZp3qPfO5bd+t+dgB+BxhHuo8ByFRNTr9UVmF+ZZ72wGTEjAr8UhfzvfHhtuhT
 PtMKEKQvvbXMWjK33oA1LiU7dl46E2XPVb39S50qS2H9YtzTpAn2ySv7hfq0ZrfT2gK4
 GAODgzQ2CqXPKStOR3MRzi5APuxErpkTtS7yfDXqJ2UogzSJ/wTavj/+6fGu9LR2bbSw
 vN+FNSSwhuvEI/v4FZW/1VssaJl9wKl/IBe6C7G8dbt/Ikpk8g2YXIRUmXb66W4Uf+b8
 5xCAHiGQgnMMzURy98nVhwThhui9C8+uH3Q60+LKhqhairs69YwBfiVRaTnLFBo7FE6Q
 KzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712249212; x=1712854012;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvfvWjtxrrYGPRjEYYhtsRkqGsklV4tVehU++LX7zEA=;
 b=IO8sJRRlKZXAINDMgBh+ZjLzycJRBLH1B9L9AiWJr6QjXC/nrFBuR7+6EZOPNSLAit
 MRRyJ6O7WpbPL8of2WKGzRLUvErOf94Q8KlPVq3FNezE53loTNSibeHC0X2FQbEI7Gk3
 iC7sXZ+G2NJLQBpbz2i1G94iAGayYNVZz684qIj/sSnM1w3c+C0iY5CkSYZ2lv315fxz
 Vzx+ttpHLN2Tcyds8gGXhxAPQeTlyjvtTzxd2kdwjhRYqtIHsekolsuZTK3lj/CZd8+e
 ZYI3L9BGNBPB7yrRcXnOXwmmsuiih3HIJbMJ1Ce/DEdBCs3ev6eZK8dpFbpsGp3jTrrS
 OCJw==
X-Gm-Message-State: AOJu0Yz0WyG618KViZTVgcnvYdAGOxGa6cQx/u/HHpSZ6NixmsELXZOP
 L7IS4ifOyigVPZMeZ5MsRjrX4AjTLo9EmGwybgHhXysdUI6YFmD6qa+JmNcoelc=
X-Google-Smtp-Source: AGHT+IGsa2L08Fq4bYNGRJmZVWZxcXY4UaQiGCvXWey7rtPocQfE+wwDaANu2GUTaQdIlWvyJ/11mA==
X-Received: by 2002:a05:6000:e45:b0:343:5cc6:4bb6 with SMTP id
 dy5-20020a0560000e4500b003435cc64bb6mr2270512wrb.39.1712249212211; 
 Thu, 04 Apr 2024 09:46:52 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 a1-20020a5d4561000000b00343c0c24a65sm2152930wrc.89.2024.04.04.09.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Apr 2024 09:46:51 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 04 Apr 2024 18:46:40 +0200
Subject: [PATCH 3/3] qcom_defconfig: enable SM8550 & SM8650 clock driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240404-topic-sm8x50-clock-v1-3-0c8ea7fad003@linaro.org>
References: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
In-Reply-To: <20240404-topic-sm8x50-clock-v1-0-0c8ea7fad003@linaro.org>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=610;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=oUY2AewVb/45RHkMa+zumTXuIopv1rowg6xFnzfJywU=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmDtl4Jf/yYVf+9QRue+o/qFBwL1MiS3XibU83isKi
 PfUBns2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg7ZeAAKCRB33NvayMhJ0eS9EA
 CFIJKTZFPvhlYqiq7jbIM7DSFhJMU5yUaFD4w+zlB+jRdwAInqu0MzYxLhQVhJB7yF5yXcbTHz3oa2
 HVCpVc2kD28LMOO/db+EujioH4KOsy7BO45Bv4zFfmf5+t/3H6v4oNeLTB9GixM12Pzf9sXNZ0STfJ
 4wtCL9HzskbLim1+NU7jZB25W8CRwK3AUnWfQPsZ4SHwtwbms1ZxtTpxDcjqutm7BNWvVqrwxwQzWO
 tPwSGSdNWdCl/ZSumILFYIM53LQgvNCDOuPlGFs5EmMWg3Fgc/R2gHrt6d0H9Fv1bgZ9poqbFE7PBZ
 r/0SLbXClVvSPoh0TDKGFhn5i23TjRjIQpFVQ5rLzE/GWxi9f2w7F/TVr/4PvrEq8E4BJNGrSvNbUE
 prVxvTIrVqVUypzPvxOkd01RAmczSJOq23l2SHkvQTvC0fsqabqNYrLazpHDseZkYv+5KOCFkgc9FO
 CFzG//R15UesjZ/+pMtFLABgskeeZtifpWR7n4i3KwaExCn0VSXLP+jqmNUMiY/h544zpIbTKoyWug
 Lxsx6QIiMwJjh9VvIMv7tsLrQqBWl0bMQSTowms66fORRCc+0t5xLLjGEav4bI/UQqGl/dlPOBYYQn
 p+SP1HHbjLgDSWzMk67lXdLuvT+TvFH5HDuDdmeJjYiocDDKTcDDXejLsIhg==
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

Enable the SM8550 & SM8650 clock driver in the Qualcomm defconfig.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index 1abb57345ff..993c2d25f07 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -37,6 +37,8 @@ CONFIG_BUTTON_QCOM_PMIC=y
 CONFIG_CLK=y
 CONFIG_CLK_QCOM_QCS404=y
 CONFIG_CLK_QCOM_SDM845=y
+CONFIG_CLK_QCOM_SM8550=y
+CONFIG_CLK_QCOM_SM8650=y
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y

-- 
2.34.1

