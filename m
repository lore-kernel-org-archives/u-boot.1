Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A16D9C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ED7A4807A6;
	Mon, 24 Aug 2026 12:59:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aaJbDn3w9FcS; Mon, 24 Aug 2026 12:59:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787576385;
	bh=OqhocBqwzfKdgepumpLVo9xZbFiI+hYcuMic5h4V7zU=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=nJekZ6w+/VM4OlrbELRET9BSkqKo4xpRK6koTAfxa88GBB52qqjS+xoq+BUvMTQsZ
	 G7pJLVgGsTBqFvzRjsb3W1O60I2SS8vsoMbrVCtdSdBfVEtRY3CWT3EW7xEdMmiPWv
	 Djr2RguTZ6H/482rYi9+9cN1LJ2VIOH0DFprDusVDT0SXhJyYz6tSB97Ls5YRiMXXo
	 AZqr/pDM6QfuQTxs/BW5fGKLxEt2HN5YFv36WBIGI8MhKs40Wx/wLO4tIyUBViISXR
	 O7C77l3jhh75JxY9grJGTv9yD5wCBaPHv7m8ZPl/iBitYEY7uC+9sUTP4HtDK45OR4
	 eYP9bhy5PXL7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36B4780796;
	Mon, 24 Aug 2026 12:59:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9266641A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8455340340
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1u8aHH6WhjE2 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:59:44 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::435; helo=mail-wr1-x435.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=HhcdoTz0
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6253C40330
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:43 +0000 (UTC)
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so2718759f8f.3
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 05:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787576381; x=1788181181;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OqhocBqwzfKdgepumpLVo9xZbFiI+hYcuMic5h4V7zU=;
 b=HhcdoTz0LM9p3m0uh8U0YcJDTU8RNopFGiITTHCYTKaM1vN+2TciBaHB15nLm4huNq
 dFsG1Qzazncj9cVoLCRDuzvHRrTjOJCHalTjJvlt1qvkzALij6lrJp4IEhUtJAzds3JN
 JIHGOBIOHU0MYU/l3uSB6h5BcqF+xJ/2MYT4FF8TWwY3hoX1wyt1a4F1HougsXAFJRYA
 ewW/G33uMQrLbCF24cYJ0cq+peIv9Tk3hI5TwRRGg5q+Zjk2orem1bGC6NnUNrXiQQte
 o0JGzvp4JAngLPvmfmdHcPLDM4WrE6bJr2OyLngOAxr37/EIbisYmGTFlhIJk2vRatv4
 LFLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576381; x=1788181181;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OqhocBqwzfKdgepumpLVo9xZbFiI+hYcuMic5h4V7zU=;
 b=IZb2pMI9uo9kNOkdw4cj8PF9BPFFgeVckchU+N0425aK1cL3dyVoR5zWICGT5ijKir
 L320Mhqwtz7Lsb/crGz511lCJ+ZlLEllC+65GcDcNc/NAA2eAt88bnjHiFKhTiRQiiNq
 SDBZW/fWF4oKEWCHC+1Gg7AoufnnbIOe+aOVHg5YI5K4DZ2RSkOCCvXQ2SZBaRc9DYU/
 XepkPBG+XOwMah4ovX+FsS/JfviZspyjm/rZK9VdLTCRfmrb0CXXxn84SgcSlAUQyP02
 mlbkRrjIOCt540NnjOh7k8n/IWVCJwxiiO5tbJU7GVDKdJqvJ7TDSdJXW6XpklP9xMxh
 ZL8w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqavtyJf8N84C85gzEUZC5H4zZIzNptF90s0FHSNuuMXMztc05k8l3C6T02pAVCQYT4PBnUvDM=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++kotAhR7B6ru3g8gFXnBj0EAbuYAwHKL4mPSr34slitRXYOF0g1
 0X1QlhLjSmRsJNzcxc4/dv87Ic0O2UADy0VDyyEDlXcr+vNGdiz8icCUF3C3zCBJjhc=
X-Gm-Gg: AR+sD10ppfV32yDW1YILlqRZmnThq3ANqV90CgJsuG6/WoCfKhVtOV1O5OIGH9YbW7L
 ISxnOg5+BfhO1uyUKofTU7YB0yezTL0StPw3moG1p2sRnx/hjdHXcMeOcNP7biwktjDgRo/3yWE
 bfNyeFZSJS/POC1fOk7Qy+44JW4W+6N/LMGLdATzSEh6h/DCJIcj78FRz7IFfrGtjWxkNKSONHy
 C+1usmNQ+baoCtMu1pCKhMdyb8pdwKX/9eYMr2xAJA3Uxwlb8zjCSTG+GGfoHAbFCA/4ymc1L1u
 VwI+LvKZS0keFvEwoyfGq9O3gUnG1XVFYtyzypIWVBM2C2JMoSzBw8FJ9xM9z+O9iA3RAbl6K17
 eafSIWMAKDrBkAwT7RmkhviLX2flqHoaYVA+3fa4hriIsRSZOowbZPpREGNTY1uLOZ3hCssdJaW
 OTt5VXKdkdvEcZTPe9ffNcYQpi98SO4RW+mWTg6T4O5IM1cZEVG5U9S9Ouoa3ju/Tk871IcyTft
 8AMDMb26KguqqmMLcP4FjFrRMYjYPGg7g4Z/Kx1lQ==
X-Received: by 2002:a05:6000:2212:b0:47f:81c4:36a5 with SMTP id
 ffacd0b85a97d-482c0ba3389mr33399727f8f.15.1787576380945; 
 Mon, 24 Aug 2026 05:59:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273?
 ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9b69a49sm8106788f8f.7.2026.08.24.05.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:59:40 -0700 (PDT)
Message-ID: <a5c38878-4233-4df3-871d-09ad511c7260@linaro.org>
Date: Mon, 24 Aug 2026 14:59:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] reset: meson: Add s4 support
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260817163604.1893382-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163604.1893382-1-sanderson@brivo.com>
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

On 8/24/26 14:53, Sean Anderson via groups.io wrote:
> Add s4 support. There are no new features, so just define the layout
> info.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/reset/reset-meson.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
> index 8c27563ce23..16d2dc19898 100644
> --- a/drivers/reset/reset-meson.c
> +++ b/drivers/reset/reset-meson.c
> @@ -82,6 +82,11 @@ static const struct meson_reset_drvdata meson_a1_data = {
>   	.level_offset = 0x40,
>   };
>   
> +static const struct meson_reset_drvdata meson_s4_data = {
> +	.reg_count = 6,
> +	.level_offset = 0x40,
> +};
> +
>   static const struct udevice_id meson_reset_ids[] = {
>   	{
>   		.compatible = "amlogic,meson-gxbb-reset",
> @@ -95,6 +100,10 @@ static const struct udevice_id meson_reset_ids[] = {
>   		.compatible = "amlogic,meson-a1-reset",
>   		.data = (ulong)&meson_a1_data,
>   	},
> +	{
> +		.compatible = "amlogic,meson-s4-reset",
> +		.data = (ulong)&meson_s4_data,
> +	},
>   	{ }
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_reset
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
