Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59FADCCA476
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 14:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0322844AE;
	Fri, 10 Oct 2025 16:38:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DdHOi0MT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE2218455B; Fri, 10 Oct 2025 16:38:51 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC8A83F70
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 16:38:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3fa528f127fso1614656f8f.1
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 07:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760107129; x=1760711929; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=aiAC6VE3EQ6jw3U+QaziQHH5xo3zvISj97sQcaieDLY=;
 b=DdHOi0MTK/gwMJCqq3Sdcp4yKucCPHTxghALIBe3S+oqJMII+h9ncHpTTuL1Isr9CN
 RhgP01jujDzodu9CTVKoknq2G0YSUC4g3tEGY+oBdPWQBjA0EW/D9abqfMCxUng0dk90
 a7qGcQuFvoNQpjZ+7TU5mGCSgm60ZI09tOwS35GIuBSCkkVDKfVQsw7uU05hZfg/u5RA
 RQb3AYaZJqbL7dmOTe5AHI42uLXWuR0nV2NEiyj/a2ZYe1K4YV0yPzR4Wn0s0S/VSMhu
 As8EKDRZosHGgT+y5ruN9IbI8c8jOFThH56l8+yfQQTjJjArH97pl8qUOGLPwND4ZGsR
 s6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760107129; x=1760711929;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=aiAC6VE3EQ6jw3U+QaziQHH5xo3zvISj97sQcaieDLY=;
 b=mfhV3YfkL7yrXrO+6cLBS3TCod5+HtsmAHUVCoIuHykFtZBWGDyCTRYNXDSTJKpVHC
 ZqQd+icq1ALu1n7hs+XtT1b7vZB8cXMLQHtUQJroIka/gVWPpasWhpWBP65DvpFrIdGV
 PwXryJlIeZv7P/M1YHFEu15PENlsDaLm5xrURIKcPuXnkF6Y2nKGIGAQp0zPPZwJ62FY
 KnateGuU8512USAdbVGOxE2qh9DPOa2uPhfGSCh5IJC5cMtzU7abOuRxB4CcjMg6t0to
 dZwPTJyxowb2VMhNr0Inr9LB6w9rxfUwrMmEWr0KoKhcn+a/9CEAmYlVF+eRhO+FTwWv
 wHEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Gjpr/N7REIQfTcQ5bbg3i/k5P54rq26cgbXO1dMNkb5dWGokgcQQGWuv0vfhYYGaJr/cApU=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9dT5kBAhiSZEDkNzBRJigzDfUPKv41bwWM7K/DMY0kBFDv8Oh
 HDgHg2GmEg/9XG9Le4BUu+fLH5WoiyBkS6H/faN+REcXOht1zIowb6sRY534wRW/2SQ=
X-Gm-Gg: ASbGncuKLDvX2Jt24IbYcyKwFhsbut2KrUIh+kA4wvLBVyJPDgyvFiMdMS+t+PhcLGm
 bbe5tp7R+CcHgimwrSOnPjAflaeoxEqtvusW7Zqzm3MS97Gpcztkvazxya1/bN4VSFiUiMzScT0
 Kw7bcrzZs8nbINfxMbDc/7QtkSOXsddC8IW9MxoWKawoy9UA8iLBpbKA0l83qK8HOA7UgSUEOCX
 vyTTYNyL9TQrdZaE5P3Xf3HcWqdKewJQyQpy30leU1NkOdWZclm6Bf5jPT9o6mtBzvWIx1iN+Kp
 3NluOln7wBbSUKQ3HEa9a7IIXzOHeVtFy19WGm4oYtgfZxBHBEdqfsUZNUnzp1KxPpOJ6BR0YWp
 jsAeLhOWv7KxmAzrV/JupQuCpl+Bp/OHqRfwbeV6qFaK5YVacII6Z464vhmt5pqsRZ8TOK80rUH
 Cl6HCM1/wGP3Wn4txLExYUqw==
X-Google-Smtp-Source: AGHT+IEXFw2WWthsIOMdnt25yNNi+urvVy/WAAe6UfDNfK2a6P106KhHObqMXMPXC1YkoqOyZ+94Qg==
X-Received: by 2002:a05:6000:2f86:b0:404:2fe4:3a80 with SMTP id
 ffacd0b85a97d-425829ee8c7mr9586001f8f.25.1760107128900; 
 Fri, 10 Oct 2025 07:38:48 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:2a00:b5fb:c622:3102?
 ([2a01:e0a:3d9:2080:2a00:b5fb:c622:3102])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583335sm4465462f8f.18.2025.10.10.07.38.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 07:38:48 -0700 (PDT)
Message-ID: <d5bf0f99-c88a-49c3-9416-eded1e7158d1@linaro.org>
Date: Fri, 10 Oct 2025 16:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: Fix wrong bitfield usage for Data Direction in
 Transfer Request
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251010024557.673787-1-hayashi.kunihiko@socionext.com>
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
In-Reply-To: <20251010024557.673787-1-hayashi.kunihiko@socionext.com>
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

On 10/10/25 04:45, Kunihiko Hayashi wrote:
> Commit d232d7fdbf6f ("ufs: core: sync ufshci.h with Linux v6.12") updated
> the Data Direction values from bitmask values to simple enumerations.
> 
> Before:
>      enum {
>          UTP_NO_DATA_TRANSFER    = 0x00000000,
>          UTP_HOST_TO_DEVICE      = 0x02000000,
>          UTP_DEVICE_TO_HOST      = 0x04000000,
>      };
> 
> Updated:
>      enum utp_data_direction {
>          UTP_NO_DATA_TRANSFER    = 0,
>          UTP_HOST_TO_DEVICE      = 1,
>          UTP_DEVICE_TO_HOST      = 2,
>      };
> 
> However, the U-Boot code still uses these values directly without shifting,
> and resulting in wrong bitfield placement in the Transfer Request
> Descriptor.
> 
> This fixes the issue by applying the necessary shift to align the value.
> 
> Fixes: d232d7fdbf6f ("ufs: core: sync ufshci.h with Linux v6.12")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>   drivers/ufs/ufs.c | 3 ++-
>   drivers/ufs/ufs.h | 3 +++
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 91f6ad3bfef9..b224388229a4 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -746,7 +746,8 @@ static void ufshcd_prepare_req_desc_hdr(struct ufs_hba *hba,
>   		*upiu_flags = UPIU_CMD_FLAGS_NONE;
>   	}
>   
> -	dword_0 = data_direction | (0x1 << UPIU_COMMAND_TYPE_OFFSET);
> +	dword_0 = (data_direction << UPIU_DATA_DIRECTION_OFFSET)
> +		| (0x1 << UPIU_COMMAND_TYPE_OFFSET);
>   
>   	/* Enable Interrupt for command */
>   	dword_0 |= UTP_REQ_DESC_INT_CMD;
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 53137fae3a81..cf11be3e0b46 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -77,6 +77,9 @@ enum {
>   /* UTP Transfer Request Command Offset */
>   #define UPIU_COMMAND_TYPE_OFFSET	28
>   
> +/* UTP Transfer Request Data Direction Offset */
> +#define UPIU_DATA_DIRECTION_OFFSET	25
> +
>   /* Offset of the response code in the UPIU header */
>   #define UPIU_RSP_CODE_OFFSET		8
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
