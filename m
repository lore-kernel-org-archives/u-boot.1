Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F48C5DF71
	for <u-boot@archiver.kernel.org>; Tue,  2 Jun 2026 08:58:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DA238488B;
	Tue,  2 Jun 2026 10:58:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gIJqN9cS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FF308488F; Tue,  2 Jun 2026 10:58:13 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25E2884884
 for <u-boot@lists.denx.de>; Tue,  2 Jun 2026 10:58:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-45fd464d51fso1227274f8f.3
 for <u-boot@lists.denx.de>; Tue, 02 Jun 2026 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780390689; x=1780995489; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=yuPSVklIS0b1S1BXn2FRvXrZW9yOM6Zwy4pMmAdT1sA=;
 b=gIJqN9cSJ3BuUdFZ1DZjqrxVoqVrLAy56ZZB8WrQqZuM74Tmd7e9zMacPUNNAmPRnE
 TNSttCz/KcssvTh6YuXak/TTeX0ap4Dg1WgH0lmRWmkz69X3ra2pMbzyZsjOMg2GOUbS
 jVEC+mUJ8+4+yZV6d9EgV+tBsie1mHR8GD90Yo0b00NeWH8RjO75t9/Na51eOlAoRqu9
 6OJWTUACwOPPn1HxR+S3axEC/6vy79Xo+GefXBc24j3h2H6IgYCE6KDhKcF5ZMlOZPTU
 J23FChesj2MarGVr3xr4zdiYaR6EU4JkhbW+xJNMvEPOS4HOZZiQU8huqe1w0//zRJpJ
 +Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780390689; x=1780995489;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yuPSVklIS0b1S1BXn2FRvXrZW9yOM6Zwy4pMmAdT1sA=;
 b=P7gPQsoRj1+cXlDZ2E6fNoUKxiMgpzS5h4ZEofLx77gdebgPjLrfmb+mObJIlMJHAT
 GKASJu6xni+VGFqOgXtmmQMN+bELj1rzj2XUZO+Hvu50wRLCIWXYBMZBL/ZXgQcT0siD
 19esxvGuMJs1isGICE/SaAAnKbBDRLrf/xeHoQ8Oa1jbJ/vxks8RJeQJD8frF2TAjK5k
 rE2dhC5waWDz3OY3rIuD0KtX/POv3JK4JuvPU9qIh3A1LqiS+6+siR3ouEr361LTuPju
 yx3g0shSknMum/EzCL1H8uCKqJe/g0/vapDEQMuBKhb+FzlPGxIV1x9N35Vd3xKDeulP
 ApoA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DSSnYB5QMCo8YWRdDrbyXvBTCi0XwvVLPWS7n/jNFlAWLjkjq2Y706RoXwxdYo/22hC+0icQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxfXZYZpyDvYPk8zQO4xFmiRJSZR3vwhFGhNyE5/o196Cj+1UE7
 DOXnSUd/cALHbbEwrBk7b2j2caL94XMNKPLo/wOM7LuS+b5e0kT2WnyRZ8H71iGm7TQ=
X-Gm-Gg: Acq92OFWMlguVUph/Up5M4ikpSiHefdVdVZdGy0QX/7wKGnDq9kJlJ0r3Qr8VwL4XDZ
 9JjWhECxLycW/FaQwJEYnDQVmEqzfSZkine+cL206QXTvnFdur0mP2sO+NuGnieQTRFEmIiJ1yA
 CyZnXeA08xKHA3eZSqu9LlcmGeovHv+cnlWZ4eMPByTeSW2xwI4F5PJWG7ZjtHLaRgRHmHYUhxo
 q8+VWSWaVmbcohCl7NMpToaQju3Q9mjNpb0QUYQ+FzHKQAb12Fc1JM7dOXTA1uLDWLOi2Mn+QKu
 OS0najaWFf1Jq51wt7aX4gTsE758YuFQD8Cxts3m3wmsiSRRpDsYBbn6modLf+geG+XGlaa0lV4
 GQvPMxqhYu8jSML670+nGjtMxc2GSK/crCSkGhgfXmqvsjkrzKaUJlQqx6W3/GzY+mLsijGquc7
 onSubqwdmGNWB6Z6MgMR5Sz566KV7yJV4dI+8IZH+vKRBUxPxydpPigHs9O6WqQahr7gbebxIiv
 rpm6xYlJL5WSGyiZ3Zgmpjzn2mA
X-Received: by 2002:a5d:4f85:0:b0:45e:e230:e53 with SMTP id
 ffacd0b85a97d-45ef6b95033mr19717026f8f.34.1780390689331; 
 Tue, 02 Jun 2026 01:58:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:13a7:124b:487c:e2bc?
 ([2a01:e0a:106d:1080:13a7:124b:487c:e2bc])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354c682sm30649491f8f.23.2026.06.02.01.58.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 01:58:09 -0700 (PDT)
Message-ID: <5620fdf5-9560-4308-9c4a-fa2eef212dba@linaro.org>
Date: Tue, 2 Jun 2026 10:58:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] i2c: geni: reset controller on NACK to recover from
 invalid bus state
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, hs@nabladev.com,
 trini@konsulko.com, casey.connolly@linaro.org, u-boot@lists.denx.de
References: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
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
In-Reply-To: <20260602064322.2409171-1-aswin.murugan@oss.qualcomm.com>
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

On 6/2/26 08:43, Aswin Murugan wrote:
> During i2c probe, repeated accesses to non-existent slave addresses
> generate consecutive NACK responses. On GENI I2C controllers, these
> back-to-back error conditions leaves the controller in an invalid
> or busy state, especially at lower bus frequencies (100 kHz and
> 400 kHz). As a result, subsequent transfers fails and valid slave
> addresses are not detected.
> 
> Currently, controller recovery is triggered only on timeout errors.
> However, NACK conditions (-EREMOTEIO) can lead to the same stale bus
> state.
> 
> Handle -EREMOTEIO similar to -ETIMEDOUT by issuing a command abort
> before starting the next transfer. This ensures the controller state
> machine is reset and the bus is returned to a known good state.
> 
> This improves reliability of i2c probe and allows correct detection
> of slave devices under repeated probing conditions.
> 
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
>   drivers/i2c/geni_i2c.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index fbe5ab0ad0c..7498cbcb41a 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -285,7 +285,7 @@ static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
>   	}
>   
>   	if (ret) {
> -		if (ret == -ETIMEDOUT) {
> +		if (ret == -ETIMEDOUT || ret == -EREMOTEIO) {
>   			u32 status;
>   
>   			writel(M_GENI_CMD_ABORT, geni->base + SE_GENI_M_CMD_CTRL_REG);

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
