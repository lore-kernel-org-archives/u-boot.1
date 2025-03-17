Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0044C28B30
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:13:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FF22810F5;
	Mon, 17 Mar 2025 15:13:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TAJjUsJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4233A8129F; Mon, 17 Mar 2025 15:13:42 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43316810F4
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so14340235e9.1
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742220820; x=1742825620; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=B4Tvff9QKsklxg6kRH1wC+FR5Xq2/mGqeX27/A7P/R0=;
 b=TAJjUsJ6xgn8Vy+hPz441bTr42GIpdBE4TMfp2Qd5ieyjVzubC+p5O2afInL74yuZV
 v5+HlzgzMgDAZBQE6OCAuLehb4KJLeMFv0jWdz/prpmmNFEEv+VbjuZAa1qotrgm6ftc
 n/nPvNS9lUWC5QnWNBF8O86kRMiur+LZW8TTTOCKBpfJ/lYAepV070HOu6L9/cag8As2
 JIm6r2FAQyekrvXucrjEeKgwQBbl8f41/32PPUD10fb4BRRENNTxvocpRVb/73uM5G+W
 CIB/LIJqzajT4XStTtFRs4YVm+XckJA1XbQpUMzX9fsmzPBCim6bGww1SN8vN1LZp4qu
 +yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742220820; x=1742825620;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=B4Tvff9QKsklxg6kRH1wC+FR5Xq2/mGqeX27/A7P/R0=;
 b=hrB/EhntWaUozLgJZe8p0/0Ogfvx6emdmonPtAb7XdPqHArf5aEwLIwfmDzJgsrRS1
 ioBOZSV7zVIbEahKN03J92w1qvEZl/M1jHTqlipmHLAwvOsdE9UIZcy98HwBGr6AwhUI
 DJzGHdRkETgpQtbNEICp7weU6UEhh6ZSCaHzR4VGFLQC/flyT5erRY5wkDkbboe6J2yT
 S7Sj4N0P76K4wX8zaYxJrBLwwEElmQEQpvRFOleGKxVKjXuSBvoeg0ZuA8GI+Yg2rWtW
 fY3nkbCqENWFbXB9ARwkxKYiM5kPuij5Z15mp3CMKw5MriMlrY3OZkaVfSP8onr0Vm7d
 nTgQ==
X-Gm-Message-State: AOJu0Yz3NJ3m0OhFT/vdC23HlaSGIy6/L6HvxohWdsCbeRh4DsixGHzT
 YxkuVqqfKaJ8ZWojQoc/1FKiyYdKOhnabWj/yiVmw5fxCKL6wStc9hIRxr7p3KY=
X-Gm-Gg: ASbGncta/u+gh8ZzTxb6o+MUPCD5lEJJY4gveBaDjI2DGa202opbO/sisxB2Y+e1N9A
 6AwS9DuatO5Ce7XWzUak4zgfRMACo9iODpapuli0ckU/PDSMWfWfMZ/hRWUCMGiHbh5hGbb57dl
 VDKhD6+jli92Sq1BZw1aaZ4s7k0Am6SBSQKfaoWaAcEwr/TPuQJ5JybDQ2fasL3uoXhuvKw6QAT
 kY90JcexCIlxjeaTxmsROj+Jts1yoLPCT5oAEVWW+qHkLotXJvG9SpE1iXlz2iXo6HwA9srVimm
 aqt4bjJ4pW6pxobjS5j6/NnhvTh7QyQkTlIWdiYl9E5aPikdjL3xk8Vl5aDvWNVxLVu2S9yy8Uq
 bF+fgMOP/kFvo5rFukV1s3Q==
X-Google-Smtp-Source: AGHT+IHr9T+pmtyH0rJEVhfVBK/byHEftV2PznagbFkCRZyHWSI99dlnmxxBn1CCPVCSC4T2LF8l/w==
X-Received: by 2002:a05:600c:350a:b0:43c:f70a:2af0 with SMTP id
 5b1f17b1804b1-43d1ec8643amr137848475e9.16.1742220819677; 
 Mon, 17 Mar 2025 07:13:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:1a77:b55f:a550:458c?
 ([2a01:e0a:3d9:2080:1a77:b55f:a550:458c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe15470sm105954715e9.15.2025.03.17.07.13.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 07:13:39 -0700 (PDT)
Message-ID: <71f37ccb-8831-4e59-bf2c-16840c469db2@linaro.org>
Date: Mon, 17 Mar 2025 15:13:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/3] i2c: geni: load firmware if required
To: Caleb Connolly <caleb.connolly@linaro.org>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250314-geni-load-fw-v1-0-587f25f2812f@linaro.org>
 <20250314-geni-load-fw-v1-3-587f25f2812f@linaro.org>
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
In-Reply-To: <20250314-geni-load-fw-v1-3-587f25f2812f@linaro.org>
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

On 14/03/2025 17:09, Caleb Connolly wrote:
> Load firmware for the peripheral if necessary.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/i2c/geni_i2c.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index 4eb41ba852f7790ca646c8ba38f29fdb727fa804..fca0fab7201a2f86ff4a8c12d053297e660c4621 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -21,8 +21,9 @@
>   #include <clk.h>
>   #include <reset.h>
>   #include <time.h>
>   #include <soc/qcom/geni-se.h>
> +#include <soc/qcom/qup-fw-load.h>
>   
>   #define SE_I2C_TX_TRANS_LEN		0x26c
>   #define SE_I2C_RX_TRANS_LEN		0x270
>   #define SE_I2C_SCL_COUNTERS		0x278
> @@ -498,8 +499,15 @@ static int geni_i2c_probe(struct udevice *dev)
>   	proto = readl(geni->base + GENI_FW_REVISION_RO);
>   	proto &= FW_REV_PROTOCOL_MSK;
>   	proto >>= FW_REV_PROTOCOL_SHFT;
>   
> +	if (proto == 0xff) {

-------------------- GENI_SE_INVALID_PROTO

> +		qcom_geni_load_firmware(geni->base, dev);
> +		proto = readl(geni->base + GENI_FW_REVISION_RO);
> +		proto &= FW_REV_PROTOCOL_MSK;
> +		proto >>= FW_REV_PROTOCOL_SHFT;
> +	}
> +
>   	if (proto != GENI_SE_I2C) {
>   		dev_err(dev, "Invalid proto %d\n", proto);
>   		geni_i2c_disable_clocks(dev, geni);
>   		return -ENXIO;
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
