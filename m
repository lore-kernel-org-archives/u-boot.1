Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD83CD5BAE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 11:53:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D043188C7E;
	Thu,  5 Sep 2024 13:53:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eyUVeS6s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A11F688C66; Thu,  5 Sep 2024 13:53:45 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A534388C87
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 13:53:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c26a52cf82so308770a12.2
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 04:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725537223; x=1726142023; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BwWisPo1Op3p6sefIdcAf1nVkF861/k7oL7RvEIg7XY=;
 b=eyUVeS6sjTh0Hy1BMtqn7mmnxw5vWeqf9ntjGZDsUHxeRBz/X0y9Wc9YZqEPih5uK5
 knyS35XYLd2kTl4/6Rw3a3gh7p/DgIwX+bETjC1QhZN3Lazes5FlwLz9LJOJlRBv2904
 iZCYlcPOFe5IEJzbCm2YTDgCy5JRQrlRa+c8BsTGOHQql0EKxd2Qzx9AVZbhbgqRdaaG
 gCA4nem0GYC2zZLAjwSmyVcXVbTLSbUtBfu6bVf7X4dZC5MROHoPW0+gE/8u881wFFhK
 QxS+5nqgihzc9etvfkFjfYDlgV0YIoI60oPN+7h6y/ZY6kINJ5bQXHf69EsomJx4a9yw
 5AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725537223; x=1726142023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BwWisPo1Op3p6sefIdcAf1nVkF861/k7oL7RvEIg7XY=;
 b=Ev7VgffDQ8wb0YBA9mV8nOG5qgM2E5lfseFFTkBMkJvkYl6waTiuvzlOUDZiDno8Gn
 7py/su9NfOhzyGjQBus2dV/HuHyfse1PSt6S/pUKdUl1eVVIm3cIOX0cj76TCis7bd1M
 qNN3tcYUbBvJyiLgDVrgNuaMyd5yAPk9jeam/MT66c86rOgmUb9RGQ3hWLAC7CbBhybe
 TJqy+h3iSP+PhvUiz7DikLjlRsFur4L1EhZfnHcd/VNFbWHdpFFFbRscncwSN2hGAUhb
 Ye9TkF/F6Sc4YMrWdrmkiNIin3FT53IUhafC/eNfnpxPmMzHBY8m08LgWZTr/j0e/UTf
 U4AA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGTNKsOSvz4iVLOFs+bGH+RWfJt4f9n36bU02epsUp8nlxQw6KlzDSe5epCNIMnqjbM8NLGq4=@lists.denx.de
X-Gm-Message-State: AOJu0YwDN6JRzidqOipVR2X/NEth2jFw3yFLhReU6cs+5xxCH2EuMaxO
 Z4OlPyngPfMBYiBIczOzYapBBXEhyn6LLutw94umUMJoI1dvscFGuWomXk36psA=
X-Google-Smtp-Source: AGHT+IFJOwqVwQTERpbyKEYZhtZO1rHodM6L2R5GI4sgMpkQiR0L/Q4Jo2+r0f6qBvf4mKEwLQ+XHw==
X-Received: by 2002:a05:6402:280f:b0:5c3:c296:1bc9 with SMTP id
 4fb4d7f45d1cf-5c3cd7b7422mr2102267a12.29.1725537222831; 
 Thu, 05 Sep 2024 04:53:42 -0700 (PDT)
Received: from ?IPV6:2a02:8109:aa0d:be00::8db? ([2a02:8109:aa0d:be00::8db])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3cc69838esm1123375a12.65.2024.09.05.04.53.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 04:53:42 -0700 (PDT)
Message-ID: <c0179e92-6212-411c-9d94-b75b4e6c9784@linaro.org>
Date: Thu, 5 Sep 2024 13:53:41 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 0/2] regulators: qcom-rpmh: support SM8550 and SM8650
 platforms
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20240903-topic-sm8x50-regulators-support-v1-0-0857185bddc0@linaro.org>
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



On 03/09/2024 18:13, Neil Armstrong wrote:
> Fix the RSC and add the tables for the PM8550 and related regulators.

Thanks Neil
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # sm8250 rb5
Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> Neil Armstrong (2):
>       soc: qcom: rpmh-rsc: add back __tcs_set_trigger() for SM8550/SM8650
>       regulator: qcom-rpmh-regulator: add support for PM8550 & related regulators
> 
>  drivers/power/regulator/qcom-rpmh-regulator.c | 136 ++++++++++++++++++++++++++
>  drivers/soc/qcom/rpmh-rsc.c                   |  43 ++++++++
>  2 files changed, 179 insertions(+)
> ---
> base-commit: bb403c895887eb5b29652f916646f886b34c6309
> change-id: 20240903-topic-sm8x50-regulators-support-b149f2417299
> 
> Best regards,



-- 
// Caleb (they/them)
