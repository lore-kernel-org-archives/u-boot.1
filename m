Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5537D21275
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 10:44:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D44788D8D;
	Thu, 17 Oct 2024 12:44:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="N+sX8JVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CB088F71; Thu, 17 Oct 2024 12:44:44 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2CF3088DD0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 12:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f4d8ef84so858683e87.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 03:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729161879; x=1729766679; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Cw53JRMcSS7YebZAqmcvmOKfgiiNontSuO9KcPu+zZE=;
 b=N+sX8JVOo2F33fY8IFLOaEGuqVv9ajtd/d7elbuCNttIU2ubJCu97/TBYC/cToj0Kg
 04TPjMQIue3g2Qy4ryhBM09F19XWDB/hWdMrRkjCL5u55/iIiDzi3wdu8vMRhcfy9E2v
 /JivA3xjDOd50ybr+/tbpXPUBK7XpPn1RFHi+27vUBDse44zIFKW98Lc/gER3xqSVGtJ
 OHRhqae7qkLZ2D+PBhELY8IF57Gx7wi01uLfaSbGyX2Y8GPrCIxQcpHj0GNN0CSZeqVk
 Uz/3SgOCezH7SwXutCGHpbJC5TEzm2DJEFrCruy6JGWuDUZLfh3pHuTK0i2NpBuw1Q7Z
 f85A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729161879; x=1729766679;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw53JRMcSS7YebZAqmcvmOKfgiiNontSuO9KcPu+zZE=;
 b=LE7+XKV+cn/tA14Y6OQJVKBD/4iNDFd1UVKqGsDBIykbbz5NIaVbHXxaHBA1O2dBNb
 enY7aD3JpKELbnn8YDbLfFGVC7egKcDyQysu11juad9GmHWLRpSwPKSKq/IwZDYErr0o
 44xXhEI2anywg/EovYnFb02/+4iYmK5pQe89/pnlUy33n3xKHrmyVQGDY6eijh65Ke3M
 VaUuy6VAvLC+fXhj9wmE8lJOjCWYoGi+6D+pHS4GcZkdAuPGuYxoGkO7U6dEhrA0meT7
 LPuVdLLqrSZWSEf96iOeIMDjomTG80Z7Itp2guyQH0udEPXFvZTZjsLIiT5rgorR7FSv
 AxMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU28NYmBCeX/TdQwzCd6fNGWJJAho1O4OA18ZMyR1DVVb1BQCKdKSvDA3Fov0PKjuUEyv3Kh74=@lists.denx.de
X-Gm-Message-State: AOJu0YybzT+eFqyIunr8uiD4LAn+CTTRJMh+fdvUMF8ZfzGqtBe7qfXS
 MTQtgLcuQwapjbKJsnHX2Nqr2GnCakMEudHKkTm0qztS/raLBjSDMo5TToFYJKk=
X-Google-Smtp-Source: AGHT+IEgxbOG6l+hVB4OPkn4QBEqM2sZhTOZ5WYdxDIptQh28caUZIupWhZxcS/BkH1i54apTmt3JQ==
X-Received: by 2002:a05:6512:1242:b0:539:f23b:59c3 with SMTP id
 2adb3069b0e04-539f23b5b5bmr7159608e87.34.1729161879349; 
 Thu, 17 Oct 2024 03:44:39 -0700 (PDT)
Received: from ?IPV6:2a02:8109:888d:ff00::2? ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a29749962sm281859566b.79.2024.10.17.03.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2024 03:44:38 -0700 (PDT)
Message-ID: <a6e93069-e84a-484a-b93f-672bed7f6bb2@linaro.org>
Date: Thu, 17 Oct 2024 12:44:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: qcom: ufs: drop unused ufsphy_v2_regs_layout
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20241016-topic-ufs-phy-drop-v2-regs-layout-v1-1-af804ce47060@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20241016-topic-ufs-phy-drop-v2-regs-layout-v1-1-af804ce47060@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 16/10/2024 09:43, Neil Armstrong wrote:
> The ufsphy_v2_regs_layout is not used, drop it and fix:
> phy-qcom-qmp-ufs.c:87:27: warning: ‘ufsphy_v2_regs_layout’ defined but not used [-Wunused-const-variable=]
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/phy/qcom/phy-qcom-qmp-ufs.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/phy/qcom/phy-qcom-qmp-ufs.c b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> index 8908a34df54..5b17f3aee67 100644
> --- a/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qcom/phy-qcom-qmp-ufs.c
> @@ -84,12 +84,6 @@ enum qphy_reg_layout {
>   	QPHY_LAYOUT_SIZE
>   };
>   
> -static const unsigned int ufsphy_v2_regs_layout[QPHY_LAYOUT_SIZE] = {
> -	[QPHY_START_CTRL]		= QPHY_V2_PCS_UFS_PHY_START,
> -	[QPHY_PCS_READY_STATUS]		= QPHY_V2_PCS_UFS_READY_STATUS,
> -	[QPHY_PCS_POWER_DOWN_CONTROL]	= QPHY_V2_PCS_UFS_POWER_DOWN_CONTROL,
> -};
> -
>   static const unsigned int ufsphy_v3_regs_layout[QPHY_LAYOUT_SIZE] = {
>   	[QPHY_START_CTRL]		= QPHY_V3_PCS_UFS_PHY_START,
>   	[QPHY_PCS_READY_STATUS]		= QPHY_V3_PCS_UFS_READY_STATUS,
> 
> ---
> base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
> change-id: 20241016-topic-ufs-phy-drop-v2-regs-layout-fc269a6d1d0c
> 
> Best regards,

-- 
// Caleb (they/them)

