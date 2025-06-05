Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51604C5AE59
	for <u-boot@archiver.kernel.org>; Thu,  5 Jun 2025 09:20:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BC2803DF;
	Thu,  5 Jun 2025 11:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r5wA5uX7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 841BC8091A; Thu,  5 Jun 2025 11:20:28 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40FC080050
 for <u-boot@lists.denx.de>; Thu,  5 Jun 2025 11:20:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-451e24dfe1aso5956605e9.3
 for <u-boot@lists.denx.de>; Thu, 05 Jun 2025 02:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749115226; x=1749720026; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tlkSe310MLam2gWPZvDZLKbYzobHXNoQOWz7KNGE5rY=;
 b=r5wA5uX7Nh1STaHdCywEqMI9Mdl2BKQZ842NnrYxEEgiMRhlZ0kKH7Siig3L75fZEg
 EFTkOh9XvX0wmvrz9pHcZAmAf75AHJa6MlwbKZbq53eZo+X3Jlx0tQankz9e7iwNiZQ1
 5/Dwmt/v5dXWFuYEOGKGaGkF0I68RXSa3h5u/47lA7G4l81WFU5xefdeWoV0ynANYGGk
 2HrQJ31Bz5HWmjcsUyfvf+L2v2aCYPySbEDvLvo8XsUegHJzxKwLNsM5pZLjLGvTbG+3
 5Ga4qjCQ59HRQeTTA02WX2U3VbM1Z+acQYDXJfSgkCv7Op2GwA6ZOVQgxC4sqbOWah7K
 XN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749115226; x=1749720026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tlkSe310MLam2gWPZvDZLKbYzobHXNoQOWz7KNGE5rY=;
 b=KBvhw07bKSPQew4Yx3jr3nIZM31GaYAwmVdA7qAjR8RvnjG3Nxqd+6RlX3TV0dtjXV
 2MWz6g2ZHAtZ5TIKqSoYoikrsJdk1EM6sytcXkz3gJoZyL4/nMWUdBc6IqWcIjo4DHJk
 zrfMbEiDJOSP5oTSvdsGo1OhbCwK129cXBmvF5xITcFGFqRtTAIwEqlN8nEq1TW6OGI2
 2xuWGtksWkE5fp00k3AuxxmZxU9qMP38FQJJMTSIb1AFw4h45E0FA2w4W+OEJbAE7oxq
 FxK2n+8zSpbzmiGhXnWzdndc79Sl8yQfRaKXBf+Sii27NMQKZgbg6O80UehhSmRoSUwq
 oClg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgq5Y1KgZng+xew6bHslAsAS7dwXam/GeOJOgEuZBKpmWGzXk3GwOyIsDgdNu5+saHrd4C5GY=@lists.denx.de
X-Gm-Message-State: AOJu0YycGqwIzrdSZKu5d1i8zRDg5lzE/Dudb3z++T1XA3p3oNe+UR7b
 VwTwsILrV1/r03JIVRKIbWX7DKX5dKE54E1LK466X1P10ScSq9ZgCz6zyaoxTPVW/yE=
X-Gm-Gg: ASbGnctPGvxoFEYh3DTbME1OBJ+DBZsYry3y9pz9kE57znZwp66NwlFefMWEa9Thm9w
 Ev4etKqLU0qZWtZa7ennrzhtzX8Y7tteEmVBOtPanr7fboAg9FMhr9LPHkzuMyAZ704wWlaNDyw
 27tldi1QXadWfIgLx1lQ9dz2kA7Nt6HwesTRF7JjPUyUGErYv40+oPLD+w3HOnjJiWRyuQJ++Df
 57mebf6W3rjvLy5lmvYTvGOf30QgiE7Wj1iZxmfcSvaBdJwhU4Kd6YVz56/trMb2+/9V36mOqG9
 MT6OQvgTcwbRScdPZ1lWiby0++JC2KqC4hX/qES70jVWSLCT2b/P1OES4uEN7vaNUTDs3JI3b6R
 BHoQ0gdYlXfRtKOkfuP+UMlRSLw==
X-Google-Smtp-Source: AGHT+IFF/UieumTuLK2Xnav9D0LaFCyiiVL8E8ca/SqFf/6YErBZWpiDmcWYFtcbEMwHpcTw5ek5zA==
X-Received: by 2002:a05:600c:c1c8:20b0:442:f4a3:b5f2 with SMTP id
 5b1f17b1804b1-451f1680284mr33320065e9.6.1749115225637; 
 Thu, 05 Jun 2025 02:20:25 -0700 (PDT)
Received: from ?IPV6:2a01:170:117e:fc:82f8:c6f8:6d38:3183?
 ([2a01:170:117e:fc:82f8:c6f8:6d38:3183])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-451f9919648sm17938415e9.31.2025.06.05.02.20.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 02:20:24 -0700 (PDT)
Message-ID: <062db25c-1acf-489b-a3e6-305a5df923b3@linaro.org>
Date: Thu, 5 Jun 2025 11:20:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 23/28] mach-snapdragon: Allow usb3 to work when a
 coreboot payload
To: Stephen Boyd <swboyd@chromium.org>, u-boot@lists.denx.de
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Anatolij Gustschin <agust@denx.de>, u-boot-qcom@groups.io
References: <20250523225845.2311989-1-swboyd@chromium.org>
 <20250523225845.2311989-24-swboyd@chromium.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250523225845.2311989-24-swboyd@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 5/24/25 00:58, Stephen Boyd wrote:
> Coreboot already initializes the USB3 controller and PHY on Qualcomm
> devices. Skip fixing up the USB node on platforms that are a coreboot
> payload. This provides a working USB-A port on device like Lazor.
> 
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>   arch/arm/mach-snapdragon/of_fixup.c | 22 +++++++++++++++-------
>   1 file changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index 1ea0c18c2f27..fd4aa3ba7055 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -41,13 +41,6 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   
>   	debug("Fixing up %s\n", glue_np->name);
>   
> -	/* Tell the glue driver to configure the wrapper for high-speed only operation */
> -	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> -	if (ret) {
> -		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> -		return ret;
> -	}
> -
>   	/* Find the DWC3 node itself */
>   	dwc3 = of_find_compatible_node(glue_np, NULL, "snps,dwc3");
>   	if (!dwc3) {
> @@ -92,6 +85,21 @@ static int fixup_qcom_dwc3(struct device_node *glue_np)
>   		return ret;
>   	}
>   
> +	/*
> +	 * Coreboot already initialized USB to the point that USB SuperSpeed
> +	 * works, don't tell the glue driver to only use high-speed.
> +	 */
> +	if (gd->arch.coreboot_table)
> +		return 0;

This is missing an #ifdef, fixed it while applying.> +
> +	/* Tell the glue driver to configure the wrapper for high-speed only operation */
> +	ret = of_write_prop(glue_np, "qcom,select-utmi-as-pipe-clk", 0, NULL);
> +	if (ret) {
> +		log_err("Failed to add property 'qcom,select-utmi-as-pipe-clk': %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Tell the core driver to configure for high-speed only operation */
>   	ret = of_write_prop(dwc3, "maximum-speed", strlen("high-speed") + 1, "high-speed");
>   	if (ret) {
>   		log_err("Failed to set 'maximum-speed' property: %d\n", ret);

-- 
Casey (she/they)

