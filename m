Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE533C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 09:04:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8028882CF5;
	Mon,  7 Apr 2025 11:04:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y0XzqW7J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74C582D17; Mon,  7 Apr 2025 11:04:34 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC6E782CF4
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 11:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso21209585e9.3
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 02:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744016672; x=1744621472; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=iJYxtkJ4SkT5cz120lJ0/JJIrfnmOq5uPNwTrQ6mSxM=;
 b=y0XzqW7Jo2tcsK4FFrHPjiiWhNL2s5jrG56eO8f1LkPH/xRt8GvwlfXriD/qYLGEq3
 HMG8uIp4fzXHEH8AbZeQ7jf2ryJPajiOgxFtHhKhesb7qocHeoDepZp8mdBRNbJNOzYY
 tjPs+jGrHgnvVIH/Qdd9KPV8J3VgitHrtQTXxjMrJF+AoYzwCJSXoBbBv1nf+wDkQcUk
 O6Yhpfsxm06wsc7l1PutTJk66Q3c61RFYBJ1GqXR702CFbLPk2sPYgF3Q2TZf9rBnQzP
 CjwC+yIK13mdjOWwxRfwWC/Zy7MomXASJZ3fe+G9JRxXnh2kNThVaMk9ezJO9qfWmxwG
 4NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744016672; x=1744621472;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=iJYxtkJ4SkT5cz120lJ0/JJIrfnmOq5uPNwTrQ6mSxM=;
 b=kV4TZDc314k9sZKwzm5gh8R9K8cYKMVBofttq3xzGYVoGqVOzpc6rlnG/MDtJK6BWg
 7/CZmbwF92/GjzOgF/IPF5jAxSyAxalpC3e4z0WFJ/6s0rnNyAyOiQd8HrM//J/fdXHh
 hBx1yzeqdxBTr3KxS66F5b1/42qZCvxSv/LgOnKTe8bJwOQDUx6aiOvlHzDhGruKqpRV
 baoHg6kPhPkqieRVKCY5PawjBNwNSH50RUMr/6rxA2GAF7ZXXwh7TJxyNN6XmAD8bcN3
 l18dh2RV9PChZ1BWi5nKVkBxSIVkf+u70Dh8HX71T+6arSW0Am4roSlYXJ0UWKAuksJA
 +0cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWeqIR+rw7BhurIC66Ng44s7WcKJWYb0OePqC9IVNm9Kyzcy+F3obuHhdNM3+GikQj1Qjd7K2k=@lists.denx.de
X-Gm-Message-State: AOJu0YxDwbBicT8YjRFprw8UuHCCOgKXg1bu4KN/fjNrqJnOMGRqVhuh
 Y/r9HId7PNJQrO8bm/yjpE/WM/7CpXvLTMp7XrXq1xodGHbXXFcF2gK218JCPGs=
X-Gm-Gg: ASbGncuGfALE7IBU0a1jOq7hAovzQszRvtcAINfg7hcRf0aTBKHoP/5npY9vJULvjKC
 g/+yOl3u+I9pESlYa8MJFjwHM5ddVSpFpv5z7wW+uBbxaY/g9apQk5qiTHhY6wyLgCd8PWHnZ8A
 yOtt4HxI4zz9Wa23f8fKnmXnZbM16VmOaQP6sq0cL7qMb0fQ+SAnF9+XI0VIFAEed+dmiCPsH/D
 6KrFkBboamb+lE532UD+/8I69JWpc22xWjJWdY+tQuW3GqO9LRSvlDDQoCeQew2yJpAJ9k9Vvlv
 wtu3YJbNMwdEyNj+hJuwvZVoLxUIo2H19ekGhurbl59pIjsm8o0YyrlOC6zNPhmcayTccYVOxVh
 cYDRn0ljYYzWYNQOAZmJRJGgKg9Tbq7+k
X-Google-Smtp-Source: AGHT+IHCLoZTXRSv9aSPTIXtYB/mgv4Aut2F4MRyYGyLB77djfQsjdBg5hmnKko6E4ZxxqBPNjJ07A==
X-Received: by 2002:a05:600c:34d3:b0:43d:609:b305 with SMTP id
 5b1f17b1804b1-43ee0697e04mr87513855e9.17.1744016672240; 
 Mon, 07 Apr 2025 02:04:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43eda4662a0sm84873285e9.36.2025.04.07.02.04.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 02:04:31 -0700 (PDT)
Message-ID: <9b6d42e1-1582-4250-8325-641f29d2030b@linaro.org>
Date: Mon, 7 Apr 2025 11:04:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 6/7] mach-snapdragon: board interface to enforce fdt
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 caleb.connolly@linaro.org, sumit.garg@kernel.org
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250407081927.138915-1-jorge.ramirez@oss.qualcomm.com>
 <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
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
In-Reply-To: <20250407081927.138915-7-jorge.ramirez@oss.qualcomm.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 07/04/2025 10:19, Jorge Ramirez-Ortiz wrote:
> Some platforms might require the external fdt to boot.

Why ? we may want to build the fdt in, and discard the external fdt for some reasons.

> 
> This change provides a mechanism to the board initializaion code to make
> the requet explicit.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>   arch/arm/mach-snapdragon/board.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab75..1bca9dce20f 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -150,7 +150,13 @@ static void show_psci_version(void)
>   /* We support booting U-Boot with an internal DT when running as a first-stage bootloader
>    * or for supporting quirky devices where it's easier to leave the downstream DT in place
>    * to improve ABL compatibility. Otherwise, we use the DT provided by ABL.
> + *
> + * Alternatively the board can enforce the external fdt.
>    */
> +bool __weak qcom_board_fdt_external(void)
> +{
> +	return false;
> +}
>   int board_fdt_blob_setup(void **fdtp)
>   {
>   	struct fdt_header *fdt;
> @@ -161,6 +167,12 @@ int board_fdt_blob_setup(void **fdtp)
>   	external_valid = fdt && !fdt_check_header(fdt);
>   	internal_valid = !fdt_check_header(*fdtp);
>   
> +	if (qcom_board_fdt_external() && external_valid) {
> +		debug("Using external FDT\n");
> +		*fdtp = fdt;
> +		goto out;
> +	}
> +
>   	/*
>   	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
>   	 * Bail out while we can still print a useful error message.
> @@ -178,6 +190,7 @@ int board_fdt_blob_setup(void **fdtp)
>   		*fdtp = fdt;
>   	}
>   
> +out:
>   	/*
>   	 * Parse the /memory node while we're here,
>   	 * this makes it easy to do other things early.

