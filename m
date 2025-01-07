Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB0A8E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 14:45:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5ABAD801E8;
	Tue,  7 Jan 2025 15:45:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HP0qFgrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC549803DC; Tue,  7 Jan 2025 15:45:05 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 885C38007D
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 15:45:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso163156085e9.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 06:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736261101; x=1736865901; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=ddUhYaUPHRCv9UQ+HDuqxqG0Za45TWBmfNAHB12IWhQ=;
 b=HP0qFgrnUdLwOkTrfnrHk3UQIVKwn2zrE6gXh3mtnq8/05pS7OxEDZyDNCp9EAgqPS
 YQR3U69UAHQr8rkimQ3u0etE+NCb9Yt0Yon0fZF2g6i1eNtAV26OMbWAyjmHvaUTzcvM
 orC8834prHYCVRVcE2DyQhUSp00mzQDjVR7wRkoZoXH9j/kojk0xat0ZVh8LgAHVYylY
 ZQsv2ocFhigth6TEj4PpWwylTuxINiJS+FxDlOIqf0AQ+bbqZWqXGudwTaUZlsxoikSL
 sVZ0lqUVou7yNp4rc/9jNdrWPhSm7r9AJ9pVj1kfyTJc3j85V/BMaHgI7WtGh+CTsgUa
 WMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736261101; x=1736865901;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=ddUhYaUPHRCv9UQ+HDuqxqG0Za45TWBmfNAHB12IWhQ=;
 b=wuK91gVTGOMTIHMo7q0Zka46Q/khkvjHgZaqJ5LUUGirfAEPs4eYLys4olp5G4Zppv
 YnkFc6A124rs8sAsNJdV5db81RL3tyuYekpsJtrmLiLXKZD9pi0IpO4rWOrBba5yZhXr
 RIzXBvewRlePjhA/4p8NGH75U5Zm0YYxb6U98yj1Ug/gb87uNHv8Gmzq7tS5eBqMuIUp
 ke65lEajW9rWxH0xMV9hzPMBZGDg+0Pb2pU1Mpcg0PRvFDYhk0ALFOWzgrOp0HlXRWav
 MEd8ntx0hixRRSwdvQ0Qypxy9kkywyr+Os8fjCbftHxNi0Apucv9C0D7sWZ+UsEpHa5O
 QJXA==
X-Gm-Message-State: AOJu0Yx493Hbv8SMLI7b2txCSc+3HuRXqfejqMBTHOtD4SqG1ctP/wFh
 ChriFYNaBAH5WWxHcp5JOR1fyHeoktQIRcusCOcdIP/db5drt3NgjxWpcxOFzYDb4rDRYxuuN39
 +
X-Gm-Gg: ASbGncvcxnkOBdDkjjgngbb7D5GikIkRtpgtFc2OVTlibbcz9FWOFVcVIiYXAQrdpJa
 ZJqnOQphcGSD5JgRjbShai3APzIw3lHa0bHkn7y484f+oi89flfdKSCpfWq/s6Tv7x3gmGLUo/X
 BI4PflnFd77S0C8zTKSOfPS9fqj1T/g69EDxhIn9Edd3cV+vg0hlA0/PmI3MwE7gKjoFSFM2vuc
 e+DB8l6nAYw8jwdvUuHeQM/mJWyQxnuy8on//To3hT+QK5mrdoWCWoyfLpTOFcmdyalh9iRca66
 xMkDGZoNcLBX4Q==
X-Google-Smtp-Source: AGHT+IE0ypy8PxfQYDFC2amH+WRY2HxJ7SdiPR6AZ2K9u38h7z2GUv22xsQ5Xy1PYuoCuNuQTduxtg==
X-Received: by 2002:a05:600c:154b:b0:432:7c08:d0ff with SMTP id
 5b1f17b1804b1-43668b5e079mr475921085e9.23.1736261100927; 
 Tue, 07 Jan 2025 06:45:00 -0800 (PST)
Received: from [192.168.27.65] (home.beaume.starnux.net. [82.66.176.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8330d4sm50004823f8f.29.2025.01.07.06.44.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2025 06:45:00 -0800 (PST)
Message-ID: <ba57773d-0088-4a3b-aad8-235941071dc3@linaro.org>
Date: Tue, 7 Jan 2025 15:44:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] usb: dwc3-of-simple: Remove Amlogic and Rockchip
 compatible
To: Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240121203818.2075381-1-jonas@kwiboo.se>
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
In-Reply-To: <20240121203818.2075381-1-jonas@kwiboo.se>
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

On 21/01/2024 21:38, Jonas Karlman wrote:
> Remove the rockchip,rk3399-dwc3 compatible from the dwc3-of-simple
> driver now that all boards have changed to use the dwc3-generic driver.
> 
> Also remove the amlogic,meson-gxl-dwc3 compatible, it is no longer in
> use by any device tree in mainline linux or U-Boot.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/usb/host/dwc3-of-simple.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/usb/host/dwc3-of-simple.c b/drivers/usb/host/dwc3-of-simple.c
> index f9df59d2e5d7..de1797d02ec0 100644
> --- a/drivers/usb/host/dwc3-of-simple.c
> +++ b/drivers/usb/host/dwc3-of-simple.c
> @@ -90,8 +90,6 @@ static int dwc3_of_simple_remove(struct udevice *dev)
>   }
>   
>   static const struct udevice_id dwc3_of_simple_ids[] = {
> -	{ .compatible = "amlogic,meson-gxl-dwc3" },
> -	{ .compatible = "rockchip,rk3399-dwc3" },
>   	{ .compatible = "ti,dwc3" },
>   	{ }
>   };

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
