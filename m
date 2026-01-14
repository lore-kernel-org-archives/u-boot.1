Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D9D37E3B
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 14:39:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D6028063E;
	Wed, 14 Jan 2026 15:39:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dNGCOaYX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985C6830CA; Wed, 14 Jan 2026 15:39:36 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB69F80325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 15:39:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so4612705f8f.2
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 06:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768401574; x=1769006374; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=wxzgAtu9Bal0Qh/rhyij8czQv5msMUaSChxt2CJD1vg=;
 b=dNGCOaYX22AOC8grRB9jTcLu0JwEY1/oE3M0boaf7Jnxkrc5BN7mNRDPO1YYdvx21J
 o2y0szw6Dy4wfCDW6LvVH1m9uWQ9b1UIGxSAzSMinpIz/7YhIPwQDbYDpxYF0zJw4Jgw
 tSgyz9yNOdbruRLRPy3ciJo2gPPyIuJI/D9sC//ZTP6CaEqK9xJ5O6YCaCob+zUcnO8L
 0IlizWmVPK7J5kZI+xAeTug9N/JAYaiWSQmdQuse5jHUx7DM7wUjDE9CBIO+VEV0ti1l
 dxRgXhDpRM1BiGsIIPYDdUB9VivRz0vcz7uGeUEj3Om3I0kuPzh2W9rJE46ae5dIPk87
 p8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768401574; x=1769006374;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wxzgAtu9Bal0Qh/rhyij8czQv5msMUaSChxt2CJD1vg=;
 b=HQfwMXU45Olgvu3mnso3LEUQckCzn/10FieCldrzaFsqzl5NraJwi75YFAyGQPaRmt
 TXnKAknrl3G6dhtKVkQqgPtwIzKoU89YChnuy0VXAvIIeW5iAE1+6ezv0XuZdqokrbnS
 Y5Vcy3yT5CQc+nnfOfThwpcBClAMgwJ1v900Uj93wYL51YAuXNdAT2PTF+Rn2mEEbDJg
 5JgMuySnnjuuCiFiSbc8c1Z08++O8inaf57JF8lrvBni43YVwfoAz3GRH4C+kEca7GHo
 KArrgZs6xF07DNYwyo4a5PFxHVI5TGkKLZ58B7nXiTc86vT24lrU+WM+9/plfDebFxmD
 9saQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZA5u3z0KefRySL1xTKJkXH8yae2xxr+89se3pRRXnNApXnavujF5WeGLI2DEiuNxysrhXf6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9//48CBzZGppf7EfjetgXIrgvshMk1mWc1aFfgOfZ0lkt5nZ9
 u+y+otFGNLZYjF6HU5JPYWXrteNe/jrfEHL8L287Nidq/bfJ6IAcCpCe8eM2PNqUvEGAAaBhT46
 iXSJU
X-Gm-Gg: AY/fxX5Sg/Lvx7/fFrLGHltEJhbhGCaQQFK3ticiQTrZafQlrkuzu1oOtrBgOe5RsSk
 UQJd8PtArI2AEcl34S6dthIP8XM/LYZskbbFuNax+iaEprL3pLHuQkOKmRrRtxxxGVNy36Czs7F
 dqMZpN+OXXrNb/cpesCjTqsmEscKpDVtc8b8L4WVfDH3yuTT7eH7hnpCFoK1U5ddn48N3Wu6BM2
 gCuoA8bipJh60zJggytb1oVCGfb2Wy1CrQsleCRLN+mISTBwRoUJWg6TRoDs1XVQyKFxx3ka/8e
 hjwHL65xf+MQyCAF19QLPFPJ8euy87y8XbaAScmxD6jWSAeZU2nlntWXcZK709xRgqj3Ha7DScQ
 Y33BYo3D/wmcTUIDWLcXT9aY6o4NraMOFGaCBjOATx1B3Jw5ls1UZCpMu6lDsiwryTWPYP7Gi+d
 Nd7gSpjxjEM4mbPEjICkNtm09di6aNMlgHNiyUB/Z4W3xXd+kOkjFNuhLx9CX/9Hg=
X-Received: by 2002:a5d:588d:0:b0:431:3bd:3781 with SMTP id
 ffacd0b85a97d-4342c548abamr3323896f8f.37.1768401573985; 
 Wed, 14 Jan 2026 06:39:33 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080:d283:7a7e:4c57:678d?
 ([2a01:e0a:3d9:2080:d283:7a7e:4c57:678d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432dfa6dc4esm28386147f8f.23.2026.01.14.06.39.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 06:39:33 -0800 (PST)
Message-ID: <328c1940-2557-4b5a-a089-d83c4fbee14c@linaro.org>
Date: Wed, 14 Jan 2026 15:39:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] usb: dwc3-generic: respect role-switch-default-mode
To: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>, Sam Protsenko <semen.protsenko@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
References: <20260114-casey-usb-role-switch-v1-0-fb7a626466b9@linaro.org>
 <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20260114-casey-usb-role-switch-v1-3-fb7a626466b9@linaro.org>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 1/14/26 15:13, Casey Connolly wrote:
> Respect the default mode configured in DT if it is set and dr_mode is
> OTG. This allows the board to prefer host mode even on a DRD capable
> controller.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   drivers/usb/dwc3/dwc3-generic.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/dwc3/dwc3-generic.c b/drivers/usb/dwc3/dwc3-generic.c
> index 7044696ced0c..1aa9fc933282 100644
> --- a/drivers/usb/dwc3/dwc3-generic.c
> +++ b/drivers/usb/dwc3/dwc3-generic.c
> @@ -528,8 +528,13 @@ static int dwc3_glue_bind_common(struct udevice *parent, ofnode node)
>   	dr_mode = usb_get_dr_mode(dev_ofnode(parent));
>   	if (!dr_mode)
>   		dr_mode = usb_get_dr_mode(node);
>   
> +	/* check default role for DRD controllers */
> +	if ((dr_mode == USB_DR_MODE_OTG || dr_mode == USB_DR_MODE_UNKNOWN) &&
> +	    ofnode_read_bool(node, "usb-role-switch"))
> +		dr_mode = usb_get_role_switch_default_mode(node);
> +
>   	/* usb mode must fallback to peripheral if not known */
>   	if (dr_mode == USB_DR_MODE_UNKNOWN)
>   		dr_mode = USB_DR_MODE_OTG;
>   
> 

So it means that,on phone platforms, the controller will default to host ?

Neil
