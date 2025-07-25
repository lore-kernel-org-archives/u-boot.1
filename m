Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C86C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2BDE8399B;
	Fri, 25 Jul 2025 15:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RwqwHz8P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33A228399D; Fri, 25 Jul 2025 15:25:28 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A8683993
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4563a57f947so15636625e9.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753449926; x=1754054726; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3gCRT5FMJWCV8qL3gi5jCx0Seu4Yi3AfXafY/grRzyI=;
 b=RwqwHz8Pk+tenTklXVdZ9slVwlzFuqXeEsPKVzM9TKxeIweGUPEBFxUfikn6hbEy22
 0+wRmZtiLxAUF6n3SOIB/V4aVx+Zl8dYKp02KTb77BVvQ6PnQHoMm/rHOJJh9rc5jNay
 nXnAz5PECVM/K4q9sOjwa6AOB67BKj72AVJ8OVoX53gmoMC7ZEHfWRVzq2MPKWBLIUyN
 aelRJCEsT4i9eOa5FkyKD9PfwQfW5gCm5/01oL/Hg0XumjCPoTmHzPlsjQ+M5ZI62Nds
 DPuPJP3uZuMe4/BL4LPcU/JG0Gw+kKI6R0TP+0EhkdMRP3Qx0V10Zzk//yFoL/z93Qyh
 Ue3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753449926; x=1754054726;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3gCRT5FMJWCV8qL3gi5jCx0Seu4Yi3AfXafY/grRzyI=;
 b=dcVYS/+Lu80V66mtcayVUyifxyp7Bh/qeTZRMU/Wm85jhCbA/B4KqVPlTq9PlPSoVS
 izHSQDINTlQOkVY2/AfX7tkNJEw1AJTetq0cBvLPPmCEqWULuWxsa8l14cTnQXtimmOY
 UZnN4znwVQ/jMIju/YmDEjhqvKUqcnfyQVynzI6Sjcf/XZaQkmlUtY37TsiOMXUEoBLz
 FOuIvdqaI18TT9zm8RlWuAUFrr2rV3WKGDcLBq8Wa5jarg8MuOR6jRLealWnx5DFdWsL
 jQZGU4jF+z9iZKPck6oK/34pmT9W7+3PdBBgwovzhB2PwMJzAAySxX6pCTUNQm4EAxtI
 PnjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3RPYlvNgbezbpWjMpncUy+7dhVu/VOYd3uBB++uTQKcIu8qOwjIco5MhYZRf1pww181to/Rg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyhdvr3fgK6vD0XsuivO3wz+a6JiLX9/wuGrpFydqYwqq9VFrGw
 RLv4OMyjZ+7SuwLXQcheW8nx8dp5K3lb74cJaXpc7ZIJW6gsoMLlYa1ismFtx2shV9w=
X-Gm-Gg: ASbGncvdWh40amFIPMZSiL9hf77WFkzBg74bwXixWh7H+aKJalBC1Ri5EYWsoAMnO91
 8r2Wojhp+4Hy2z2fku9PuvMsugk/vd481MBLBVmpfHvJ6MlZV/8ckP2HzRhs7t0bTK3CKcwTW3D
 S4xQWbjmmjZJPcfS672wBvmx+/4PaItmN+KFpP+0QMaLzupgl8oA1FBqSq6PqUvEHO4UPhmIyMN
 NYeEE9fUcpMGrm5rekmmLvhgCmIH6iCXlMeo8Qy9rdL1YXM8+cLu1A9lqPNi5FpjGbFAgqodg92
 fhjurcs7ssM7edHonvoGNYPLLVK4ESwj7/P/UN4Gnp/x4smLu4bujWxsr8p5r5TpO5B5hOlFbMk
 EqzezsHCI64PnAJ5Sq5xiT+lucy76JGadFTzA5mqN//eATUyE9CjIme6tEyvsY2g=
X-Google-Smtp-Source: AGHT+IGgFtALdLIYOPjEg5lKcJhxPBKRNdPaklzUHru2/EQdoZ40O+CGvM1W3RRa313qwyRYW8VCdA==
X-Received: by 2002:a05:600c:4c24:b0:456:18b3:df2a with SMTP id
 5b1f17b1804b1-45872976cbemr19868745e9.7.1753449925559; 
 Fri, 25 Jul 2025 06:25:25 -0700 (PDT)
Received: from [192.168.1.37] (p549d4bd0.dip0.t-ipconnect.de. [84.157.75.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4587054c562sm52816085e9.10.2025.07.25.06.25.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Jul 2025 06:25:24 -0700 (PDT)
Message-ID: <a0b9ba21-eb35-47cc-9efe-fce5a8b19f10@linaro.org>
Date: Fri, 25 Jul 2025 15:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] button: qcom-pmic: Fix dereference of uninitialised
 pointer
Content-Language: en-US
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250723-button-qcom-pmic-v1-1-9c317ac71167@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 23/07/2025 12:58, Andrew Goodbody wrote:
> The pointer 'label' is declared and later dereferenced without ever
> having a value assigned to it. Add an assignment to this pointer so it
> will be valid later when dereferenced.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  drivers/button/button-qcom-pmic.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/button/button-qcom-pmic.c b/drivers/button/button-qcom-pmic.c
> index 85addfe32a2..b823490d6d5 100644
> --- a/drivers/button/button-qcom-pmic.c
> +++ b/drivers/button/button-qcom-pmic.c
> @@ -195,8 +195,9 @@ static int button_qcom_pmic_bind(struct udevice *parent)
>  			continue;
>  		}
>  
> +		label = ofnode_get_name(node);
>  		ret = device_bind_driver_to_node(parent, "qcom_pwrkey",
> -						 ofnode_get_name(node),
> +						 label,
>  						 node, &dev);
>  		if (ret) {
>  			printf("Failed to bind %s! %d\n", label, ret);
> 
> ---
> base-commit: bd0ade7d090a334b3986936d63a34001d99722ad
> change-id: 20250723-button-qcom-pmic-882cb5415dd6
> 
> Best regards,

-- 
// Casey (she/her)

