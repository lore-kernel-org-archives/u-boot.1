Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E892C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:33:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F2268129B;
	Fri, 28 Mar 2025 13:33:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C92m01+f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 958CE81CFD; Fri, 28 Mar 2025 13:33:51 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A691F80079
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:33:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e6a8aa771e8so1299997276.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 05:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743165227; x=1743770027; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LTNWAJDAbMyyb2f7QLyUNNYXWyMsuUCFhsSvrp0ARpE=;
 b=C92m01+fHOzEYNeVsF7/M+Q9P3mtUgH0NVOSGlbGPD7leDFT7Vdienj6mN9Xs7mQEr
 rpRCdXudF8IOsKrVJp8hKYsIWmTpBpSfyUAdCZuVzNwW8IWXnweMR7EIoiJUlelO/cZP
 lhFgLqUG+6Q5XNX9yYvVltdGbNFFKQfO7tMjzkOSqkAHdB13J5V81PD836sfnAFaG3eo
 FAKorsVN8M9An22PTKa90HhOedALwbnjVAGTCgwHfBvApmPrSo6JWVkSr9Q33AmcqpsS
 U6F4V4PQWTPm4UEQf0DakzbT/B8o3k/H9LhJsqVrBjy4XWVDtjJzCaGDeM1UWEPxTh8c
 CWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743165227; x=1743770027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTNWAJDAbMyyb2f7QLyUNNYXWyMsuUCFhsSvrp0ARpE=;
 b=Tb2BzPnfyl2X9akDBTUAU5O00ujs81x2DA6oWxJJRfByu2LSQ38bPo+8flrmi7KdNk
 ZN4ypERal2SLV4bJ/Dq1pIjRkAOJR89jhP3C3qCHm0IQt/IwVLh+dUQK9EZEsm/6daOo
 bRKKN14u5AhoinpuziMZ3a5XQzYVTtgFMXi9gELlh59SXqb7ZzP+WE+hCxlIr9ikUuGa
 cL9g7YYdFAzZwW/jC8P7P1LWSSwpxqaE6p3wTUQAAhYLxfg1fD4M+R43EQfsVMn4vlUw
 HaqC4BDPodwehoc2g/bGp2eRY8vkLj5lsTuZb5phviwFmOhf6An+2M4Bv0oc4ytFxnW/
 v8Cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXILC9uxyIl6CBZ0Q1OL0qe8bltBp6fbvtflZRIporWhZTLr6NB3k/RfM0Ip5+Ee8bRm9nZ1eY=@lists.denx.de
X-Gm-Message-State: AOJu0Yxdhwyvdt2VbY2ZZJSR2yPGy6/uppU7SbBG33XRMA8CrL+5V+IE
 pT4T067GpDsWbHn7CTkqN7uSjHyhc080bGElsHkkLnYsFUpzJJB4suWcSjYPrw9Zao983q5Z1jp
 Z1F4VsM0/eydxF50Whiof2rmP2KHQxa5f4V+nmixXzfgzuoSCBQk=
X-Gm-Gg: ASbGncsyNfUakHyQF6ByPJjz+aeo+Q/Kn5RkbyRXn8T4IzXGpUxJ3utP70Ev20K9XF6
 sUFB8CjI6FktPooGEHIc1Ue5+hvL3aljV55Y/HMy2W3OVcumfcuV/uL0TL3KXT4VTpsOaMsHWnS
 C+2puhSq/BdiZ3Oq3rSDOYYeCAurbAKeNoYNg=
X-Google-Smtp-Source: AGHT+IEBzaQpXMAmLqWUkRv8lyt9XIFQbaQlzcWUY1TFP/SOohKvcYP/zYcLsmPWYKgTn+gQ6ANMIEFO29fwGiC57yI=
X-Received: by 2002:a05:6902:2085:b0:e5d:ae04:1e42 with SMTP id
 3f1490d57ef6-e69435ad7dbmr9616241276.22.1743165227289; Fri, 28 Mar 2025
 05:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250328104011.1837872-1-caleb.connolly@linaro.org>
In-Reply-To: <20250328104011.1837872-1-caleb.connolly@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 28 Mar 2025 14:33:11 +0200
X-Gm-Features: AQ5f1JoXeGfIs6lDxOweRc1AH4k8BRnFhDn_0lkM2B2TnYXlAPbBERe40MEcu4c
Message-ID: <CAC_iWjLHEiwUhm7D77JT1K_qzu2wmSvNhGuvbtuXK1kiOGS4Yg@mail.gmail.com>
Subject: Re: [PATCH] qcom_defconfig: enable OF_UPSTREAM_BUILD_VENDOR
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
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

On Fri, 28 Mar 2025 at 12:40, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> A single U-Boot binary can be run on many different Qualcomm boards just
> by booting with a different DTB.
>
> Simplify the build process for this by enabling OF_UPSTREAM_BUILD_VENDOR
> so that all the DTBs will be available after building U-Boot once.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  configs/qcom_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
> index ba4d38d100e0..a12a5d17b406 100644
> --- a/configs/qcom_defconfig
> +++ b/configs/qcom_defconfig
> @@ -40,8 +40,9 @@ CONFIG_CMD_EFIDEBUG=y
>  CONFIG_CMD_RNG=y
>  CONFIG_CMD_REGULATOR=y
>  CONFIG_CMD_LOG=y
>  CONFIG_OF_LIVE=y
> +CONFIG_OF_UPSTREAM_BUILD_VENDOR=y
>  CONFIG_USE_DEFAULT_ENV_FILE=y
>  CONFIG_DEFAULT_ENV_FILE="board/qualcomm/default.env"
>  CONFIG_BUTTON_QCOM_PMIC=y
>  CONFIG_CLK=y
> --
> 2.49.0
>

Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
