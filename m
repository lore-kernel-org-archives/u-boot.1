Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E55C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 15:37:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F01C940769;
	Thu, 27 Aug 2026 15:37:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xeg4anN4zuxR; Thu, 27 Aug 2026 15:37:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787845068;
	bh=dh4OCjO04g0TKiHtMQq2+efsrwXqSSPP04CluYs+f+A=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=AeSefFaGjnix4FE7MmELeEzeQ1bP4hIEqO/e+XZ6piIwTU9LfbdMk2r0NW8IgAYHK
	 NHSvhEXbNPNHLoAIFIA9nGhuAl/1iMfXaY9Pa8nyoId5u26b/qyQWKCR56wXnR1V0b
	 N4BFZfVPXrCHRasstoiuaKvkDcvfp6aGTrZLZI+SQuE5YvOclPjGv2+B6kRm1i/RA0
	 rSHNXZ0aMcsScChL+JVTGzoTIHGUGYrJ+ziWyaLF5DWtPOv4XyPC55tBJkCLxLy1Hj
	 YVd7+F84CkaZdrlpyj4lUpRv3s8BVDfffLjgN14CRkpWEeeu6LPbEtNmsr0dFIy9eh
	 uK4GCufs4gldA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22C71407FE;
	Thu, 27 Aug 2026 15:37:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6582B334
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:37:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 575EB607D6
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:37:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id f_dRQLKuP-ye for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 15:37:45 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32c; helo=mail-wm1-x32c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=BCymWvt9
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4B27C607CC
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 15:37:44 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4956869750eso15408645e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 08:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787845063; x=1788449863;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dh4OCjO04g0TKiHtMQq2+efsrwXqSSPP04CluYs+f+A=;
 b=BCymWvt92MYnWBzmdzyWZ0V0vWek887NpR7wS6s7lzM9fnjnPP+YOgulbKWGAWsAWY
 mx8UgCakR9zBy1vropE4iKOOzzDWDFbBoxPe34zqGbBdB1WbFJKZmoIzhhxku083OIOw
 +t4VD/CFVDbTCWSPjGHh6eqhLCAtrMUX/QWeRIeE7JEi7czfXjMfvIwI8vinBkmnJVyP
 SwyB1CEumkmIbU6B+w2Sc+/pQt+kUeWZVMzn61gd2OJwG4vfAF9SXOWphbuYbS3WslCL
 4OI1I/adcGVARaQkGCIS8QXf8cEdfILczn4126nOI0Vtz/O998/0qOJvarGgdIGWnGaH
 a6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787845063; x=1788449863;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dh4OCjO04g0TKiHtMQq2+efsrwXqSSPP04CluYs+f+A=;
 b=JFcVsvOCZKf5TpYzaFqKfklYhl92RhytFnaQEUqXB98DGdP1YU6m6m33Cajm2K8D9Z
 Exqyygh4AXKUaLGI/t3L2x1+4Wa9iIJwFOHiK4xuZpYlDOElHlqjMMTxY4ZIHDp2GjSA
 eqNCFA2ALiY3XHutc+ZBR6AFiQacVnpVIv3seLpCW57lDQtdwHJxj3ctU45mxPDb2NGO
 kIFNdwWpDHZsVsQM3Gi9DhmbZbHUQB2Yugd9hUzLEGzD+7yPRUoYnSZgQHo9IXZ7P9IC
 8Fk9h4YwhCwjYLL4xkqKQt68SF3hKW7q37lqfK2E1uxlxih98eNTApB3Nmlgob3sAttz
 bfNQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RptSr5DsYDVrsQbR6lkEa8FHBiUI13Yt7AtDROzPwWV6Y7o+G0iYEfiUSKbsCgph1BoQWHgeWY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n5p8fdxbrlJokWwl6qyDUE4b44+obGM18NsCRkrIocB+kf6LNe
 i2CakXbnD8RUpy2Hmv4l2DfQfIdHnrF8lsU6/8zJ8/Og2MIkPWMYWC5PV30IkBtliT8=
X-Gm-Gg: AR+sD12S/M44fLb9sosrpOCCdtjBVEEfOpxL9dJU5XO/R6emz3KefKugrHe5g2pNmQt
 ubb692kCwKsmUCR/t3ubDYDnrUYh88LMoQFApFPx2T05pnmX1mSWOZoeQW+ufAMctN1if9Mmwzn
 mC8wpFXlJpf1lxHGku1Rpl0Mn+76u0lT5IRrVAPLWLwHlKzjY9q5tWUGFXHwhZ1qRm45TusUzkK
 +9Zsout+sTSN8A5w3pkQXPj9TIXRkmKQWoD/MluRI1qd5YNdN1J9smtjCYuF6Z/qtUMBZ+NXB6Z
 AJfj02CPswwrtybBynjQa1qoL9ehgmxjhCFE+FYLnrvUTOu70fwSVcGoCmB+CHLzWWAnSpUK+jD
 dEtzQ0e7iaTAwlFpoKSaQbdESLiLESt6/y92DLsC5xN7oWD4pbvYdFTlXShr9ofE4+dBgU71Xhc
 LlNR+iC1ZfLUodouAZlXACtzjwOzlcMwZHZt5B/QiFUNb+cPnIqnklOT3i9dtpXdnHXoS97PiQt
 KmMHflPGS/wHS+JzAs9Pr1pR9S1jjXWwA9UysHglEAkAg==
X-Received: by 2002:a05:600d:6413:10b0:49b:c8e:a211 with SMTP id
 5b1f17b1804b1-49b0c8ea368mr109647145e9.5.1787845062725; 
 Thu, 27 Aug 2026 08:37:42 -0700 (PDT)
Received: from ?IPV6:2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18?
 ([2a0d:e487:122f:5669:ed69:66c3:c4c3:2b18])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4942366asm57217395e9.3.2026.08.27.08.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 08:37:42 -0700 (PDT)
Message-ID: <b0d1453b-3039-4cfd-a648-8263810e2443@linaro.org>
Date: Thu, 27 Aug 2026 17:37:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/9] clk: meson: a1: Use clk_set_rate from
 meson_mux_set_rate
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: u-boot-amlogic@groups.io, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>
References: <20260817171623.1943847-1-sanderson@brivo.com>
 <20260817171623.1943847-4-sanderson@brivo.com>
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
In-Reply-To: <20260817171623.1943847-4-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/17/26 19:15, Sean Anderson wrote:
> This function is useful for other drivers, but it's tied to the a1's
> meson_mux_set_rate implementation. Convert it to use clk_set_rate so
> the drivers's set_rate implementation will be used (no matter what it
> is).
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/clk/meson/a1.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/meson/a1.c b/drivers/clk/meson/a1.c
> index d0376663069..422cdf5f4d1 100644
> --- a/drivers/clk/meson/a1.c
> +++ b/drivers/clk/meson/a1.c
> @@ -523,8 +523,6 @@ static ulong meson_composite_set_rate(struct clk *clk, ulong rate)
>   	return 0;
>   }
>   
> -static ulong meson_clk_set_rate(struct clk *clk, ulong rate);
> -
>   static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
>   {
>   	int i;
> @@ -542,7 +540,7 @@ static ulong meson_mux_set_rate(struct clk *clk, ulong rate)
>   			.id = info->parents[i],
>   		};
>   
> -		ret = meson_clk_set_rate(&parent, rate);
> +		ret = clk_set_rate(&parent, rate);
>   		if (!ret) {
>   			SET_PARM_VALUE(priv, info->parm, i);
>   			break;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
