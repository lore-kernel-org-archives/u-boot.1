Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240A7C282DE
	for <u-boot@archiver.kernel.org>; Mon, 10 Mar 2025 16:23:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B468281761;
	Mon, 10 Mar 2025 17:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IQ/N5OmD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BBB781782; Mon, 10 Mar 2025 17:23:12 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ABC8168B
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 17:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christopher.obbard@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43bc48ff815so26257495e9.0
 for <u-boot@lists.denx.de>; Mon, 10 Mar 2025 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741623789; x=1742228589; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xArxd0rWLMokW2mX59XZQs+ix4r1dLpkP8WiPN+JhGk=;
 b=IQ/N5OmDPMc8ynjIzoRSl+zIIrKvRT+YRKwtvuQEAXahFZV9eMDJFIpHCgZfNROvH1
 oTyBClZmlni9USM69SK2BRDm2D7Z/uMGaL1mFEz0a6divKHb8f+SVlKtOEWJAKYFkDVU
 nzroOXC9Fp/2J+QJbAArWPjKUfdfOC+z4XjIgAu8NKFCq3mNEz9YmKogxDYRKICE/Pyt
 TGxyYtnvXq2c3BgDoZEn9nBIGjxM/AKR5XrLhhX0KtQs/IYlj7AtDz3NPx7BtdXFmEwo
 5zjUX0UTovT9JvJOSzsEwt5KY0H0SqJ7E2JpfP7tladqCruCce7NU6Rf/SbqRE5Oy0uF
 GPKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741623789; x=1742228589;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xArxd0rWLMokW2mX59XZQs+ix4r1dLpkP8WiPN+JhGk=;
 b=C/wb+E6sKGoubQbjw4ozFHPBYP917+v7v4CsmO08qHMuw5DF2ZtCfm/JBZpoiJkFnW
 RbxOUoE0V3x98zzU3xtf5+vkqlhpKmWXNY5/n3nv67EkSpUmHRD8pMbNQpnGe2zfXea1
 TcliCI7K+fYlfupgulWfaXvEedq4usIlBKv5Cw6mteLLgNqN7hY7rh6Lyqag83PT8VGU
 FKQ+2uNPK9A2wmktlNt0a2jjgwl+6+5/l9bWTvRJG7YcVtFRdhVrM/pI90tNbT1OIyOG
 Z6kEll/1hCwcT8w5JVZOnM7HZonhBEii9NI784JhsFw12YLbqrEZXL4PBftAOL8y0Vc1
 OYdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUk/uQ7w2mt2y6+57f5NG65Jhq2nca8chhTyRthSvulQFLaAARkKLbS87tm2ceyeQxjS0Bbbjw=@lists.denx.de
X-Gm-Message-State: AOJu0YzieoAndiMmNiHcFOucMXC2BXGrohw6zc7GcCa7A6GgtCvl03eE
 xbDyJYsRVXle2PQaYNkPv+SAZDb5bTl9vqY1DLTh4UDbnU3Gd8gZTjuVrj0vJeaeZf2cp6nAp8T
 ZOKSU7ynPujke3Q/ixwuDCCpljblmcnfZLYn5zg==
X-Gm-Gg: ASbGncuS/a0tbsWjAoAkZtcCkd5XbSDBY/Feup1GjfkqylSuvak4RKjrqBVboHwjEZH
 I4cOXHAEf6/teAIJwpmVAGCWKzpebhtiUcuRMUHGA9OW7234DXB5bFiZzzvPal79TvMIM0waNkd
 KiDdqWusN4A+IwkWWDk0Br7gUlY/k=
X-Google-Smtp-Source: AGHT+IESjsZe1M5Z6Ko5oeJgCG6DxXtGKPvbbCvysY1zGWSOZx3Eq3vPk7ymEcAjxzXoACmLABYdTOvnuudbuBrIAGk=
X-Received: by 2002:a05:600c:2947:b0:434:9e17:190c with SMTP id
 5b1f17b1804b1-43d01cc32fcmr1815475e9.0.1741623789478; Mon, 10 Mar 2025
 09:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250122-pinctrl-sc7280-v1-0-8bdba72e6366@linaro.org>
 <20250122-pinctrl-sc7280-v1-2-8bdba72e6366@linaro.org>
In-Reply-To: <20250122-pinctrl-sc7280-v1-2-8bdba72e6366@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Mon, 10 Mar 2025 17:22:58 +0100
X-Gm-Features: AQ5f1Jou0fhE1GnSRS7X06GoOe9x-YbRsUmmOxYqPGFEv1cCCY1t63tAW5M4ytA
Message-ID: <CACr-zFBwf65iok21QYPk2oBf+15SYC2RWsP3BziPPefmGKnhfg@mail.gmail.com>
Subject: Re: [PATCH 2/2] qcom_defconfig: enable PINCTRL_QCOM_SC7280
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>,
 Markus Bauer <Markus.Bauer2@tria-technologies.com>, 
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Content-Type: text/plain; charset="UTF-8"
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

Hi Caleb,

On Wed, 22 Jan 2025 at 16:03, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Acked-by: Christopher Obbard <christopher.obbard@linaro.org>

> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index cd94315f1765..7a60464120dc 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -92,8 +92,9 @@ CONFIG_PINCONF=y
>  CONFIG_PINCTRL_QCOM_APQ8016=y
>  CONFIG_PINCTRL_QCOM_APQ8096=y
>  CONFIG_PINCTRL_QCOM_QCM2290=y
>  CONFIG_PINCTRL_QCOM_QCS404=y
> +CONFIG_PINCTRL_QCOM_SC7280=y
>  CONFIG_PINCTRL_QCOM_SDM845=y
>  CONFIG_PINCTRL_QCOM_SM6115=y
>  CONFIG_PINCTRL_QCOM_SM8150=y
>  CONFIG_PINCTRL_QCOM_SM8250=y
>
> --
> 2.48.0
>
