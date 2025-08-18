Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512AACA0EC6
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 10:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA7B82AC4;
	Mon, 18 Aug 2025 12:22:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BMYi46Dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3472E82AFC; Mon, 18 Aug 2025 12:22:51 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD62E82A53
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 12:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-45a1b004954so28005235e9.0
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 03:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755512568; x=1756117368; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=te9QLJLSJ8A3CQGwhxhHAdn32STrnuz1X2hlPsInrhA=;
 b=BMYi46DjDix7t1iYhU8OvmmY0/n7d2bGzHgCzTTYM7TcI5znjwSMSnsrYMrtF5N5XG
 YdcjrgP5+tEN7PA81tEEH74oWTDjGZmBnb84GphGHEhmB9QR4yykphLgEIQOnMMrx9QT
 9UeVsTU7+g2fl0HFcopDp+J3w9PhzRIjLrUx4CDEtc1wHr21QK/qJ6ocgivapbJCjHnN
 QrGNM9HQTZLAx+jGsvmSlhZVVCigwKlXMCBGbChsFk5BmvmmXQYxvOCIyDtUks6RFCvq
 75gy2HRUdORxylkGAaLCXvmM9yy2WcBgiSYbuwY+/SMmBo+CEjOBSZlK7DUfPT8I32z0
 03pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755512568; x=1756117368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=te9QLJLSJ8A3CQGwhxhHAdn32STrnuz1X2hlPsInrhA=;
 b=veJXrcNKn/E3xLBqhSAx/DiFdqS/0NRLed17UG+qztiefpgp3nJ1HCw82dn2J6pX1l
 VwdrDAsn3BxOh+yc09V6Y1Kz8SF1puqHITdQcSmUcYdExraK5krm6Suq+peVEapbRFGT
 jUnjg8Hvm1Wtqjf6fXYnObm4gG3dWCvI0cn9rPWWI8GhI48os8muBYPb7CPWv8086f8s
 AReTZY7Qp/T7dzz1Z8F1N35xa9pvgNcmOJKgy4tPSnq1J2Rgs3hzx/EaqfMoBLHiHA90
 l67kRNdH0QRPr0jMr+hdetFz9gp4O53JLIESF0Rv/tr8R5uXCyVfaN39+5DqOv5e0hei
 2P1g==
X-Gm-Message-State: AOJu0Yz05AYo+gpS8ibp7vdOxPZWJkpg9KBn2UAX0ZHusZqYmb3chxMw
 cWslaBA6U+pxO89OFzJgimi1Y5ydyWshXNVWrFQ59P2BlUfDeCnyFZmJedQEnSjoA+HjTiTxk30
 62X/1hrMuyQ==
X-Gm-Gg: ASbGncsbmOwvP5TtUZ7HFCEpQDjMGPMw32QQT+ykK8XbFiyzIOSdtDWrsb5CX38myp1
 96kr+HOm/sZVjjOVwV/g2D0qq845jlqQsbvriYkkURTwTSZofQxzepPq0OuLqIU4/1NgHTcQh5q
 9V13g4ec3AFaVUxw/IXpkT1fFt3Kdh86hL1TU/FkLoi1CX+3iPteyIBMeYSvEWRrrCxMjZgHZsF
 9ceq42g/Oql7zxCWYqbIarPTNPfCC4RjAS04+Xjg95dVQSvz8VnSk3nhDwKzHeSp9S7NJbaKk7r
 atmyFOToRUP0bxepPHqpy3zBjmpRbAlMGwyQXknAr4mhFd3PdbNtPkJo2ETx5wyWz09FHdjZXjf
 XoHOw4Rn5eM7lminFSUHnpcoUyVnd+l3jA5EwqxrqohbyZgxMapEq5oukLgdAnCORp+tlqXjO17
 lVog==
X-Google-Smtp-Source: AGHT+IGgAY+cqW1gsSip6UqHQh3QZR8oMIj6ZZqft/KmOuCBMyZTn6ZW3dKAbkvtvWdX1Q08aR3Tsg==
X-Received: by 2002:a05:600c:c0d1:20b0:458:bfe1:4a91 with SMTP id
 5b1f17b1804b1-45a292426aemr27029135e9.20.1755512568107; 
 Mon, 18 Aug 2025 03:22:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:2d28:4b2d:6840:1003?
 ([2a01:e0a:3cb:7bb0:2d28:4b2d:6840:1003])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c6be10esm176091755e9.3.2025.08.18.03.22.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 03:22:47 -0700 (PDT)
Message-ID: <9a680f6d-c159-4b88-b4ae-ef187b6d2794@linaro.org>
Date: Mon, 18 Aug 2025 12:22:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] phy: cadence: sierra: Remove variable that is not
 assigned to
To: Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250806-phy-cadence-sierra-v1-0-2f0830caaacb@linaro.org>
 <20250806-phy-cadence-sierra-v1-1-2f0830caaacb@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250806-phy-cadence-sierra-v1-1-2f0830caaacb@linaro.org>
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



On 8/6/25 17:24, Andrew Goodbody wrote:
> In cdns_sierra_pll_bind_of_clocks the variable 'i' is declared but never
> assigned to before its value is used in a dev_err. There is nothing
> obvious to assign to 'i' so remove its use and just put a default of 0
> in the dev_err call in its place.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/phy/cadence/phy-cadence-sierra.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
> index 2c9d5a12127..46a728405cc 100644
> --- a/drivers/phy/cadence/phy-cadence-sierra.c
> +++ b/drivers/phy/cadence/phy-cadence-sierra.c
> @@ -602,7 +602,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
>  	struct udevice *dev = sp->dev;
>  	struct driver *cdns_sierra_clk_drv;
>  	struct cdns_sierra_pll_mux_sel *data = pll_clk_mux_sel;
> -	int i, rc;
> +	int rc;
>  
>  	cdns_sierra_clk_drv = lists_driver_lookup_name("cdns_sierra_mux_clk");
>  	if (!cdns_sierra_clk_drv) {
> @@ -614,7 +614,7 @@ static int cdns_sierra_pll_bind_of_clocks(struct cdns_sierra_phy *sp)
>  			 data, dev_ofnode(dev), NULL);
>  	if (rc) {
>  		dev_err(dev, "cannot bind driver for clock %s\n",
> -			clk_names[i]);
> +			clk_names[0]);

Wouldn't it make more sense to use "pll_mux_clk" as the clock name? Or perhaps
just "cannot bind driver". And get rid of the unused clk_names[].

>  	}
>  
>  	return 0;

Thanks,
-- 
Jerome
