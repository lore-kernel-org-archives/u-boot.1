Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD97CAC5B8
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:42:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D135A835AA;
	Tue, 30 Sep 2025 20:42:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Fr3RRo+g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 126AD835C6; Tue, 30 Sep 2025 20:42:26 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 270CB800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:42:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e3a50bc0fso43721205e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257743; x=1759862543; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Kpiy/tqKD4L3DgfNfNbLNhEnulG8h3M0/+gAPQd0inA=;
 b=Fr3RRo+g83eJw+IjWqpH8aTqbmVVmaSfaTPPJ6dYikb2sRqj76j5YbdqFFpt8PwQEB
 Yn4SmfahvFGBnmDMM5Z2Tsp35fNbQgpyNNrWnbuiWOUcQPoRtP4sM3X78gklGF6AyvpS
 K5GcC9RSj3hIBtVJioA9kwuUiuo7TYGBJIdQf6jYhusj4hntJ7hjpuW0vDpOTMX4/UZo
 ErkosnT70A+Be3Vd29Hgay1g01UnXVEhdmimzYcv5i66EHAcG4cMtENQTQuCMu8sWcs+
 7mgWnqjLOjZi3fVjTT0klAaQB0NPRywsfYlYyQBT0w/9hwPdhX6wMGbNNIdZbDKvHzQM
 aLeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257743; x=1759862543;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Kpiy/tqKD4L3DgfNfNbLNhEnulG8h3M0/+gAPQd0inA=;
 b=YARXZRd8o93wbtOl+p2htyh606yUvt58XWi7v1N/4oVra2MDVFHlfovn3vWkEKmthU
 VXiXtOPfLV+SMpskUpJOjPUKqq1KWAbl805nIZsRiBP+RL4ZEPLIVY7V84raXR7q0nyM
 QepY5EpSEdmRBIR5bna9LkMG82y3Paw38th7AksiajoGIew/U6bW9rx5Sw2DmgKlOaAq
 CEZooGQw9ZFA010pukqlyT/5T5QopffmihOmgSmGVJYFwZXfllDL+q2N9NkkdJ0ef+cK
 ObXJVhgbzTPjnkmuEQsq1x9HEAXYZVLqTY56/FJca9dzovi3yObI+eoYt02Q+r2DS5xd
 qogw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9TxrTKDIr8l4/VbJDUDvBzblG7f8CnhdttAlx7Kha5NA0B9sPtHocdrOH0qCmuCP+eVXLnqQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzkbLn6uV5vEZ22msALmJgfo0EXcCxFb8LZmUbvU9tBjFAHz0V0
 BBEexw0DcSHj8vmyoagDKzKHiJnNXLJejnVqU0QHbLdGWeQE7DtM4pf18hs/qYHjx4E=
X-Gm-Gg: ASbGncu2SNfZAvcS3zq+koVdiPwNXAP+VbBIo12QT1oZZ/K17ZgN88gC45aID25CUci
 w3sZqwD9xApuUSbERKvYu1fOU4tyq5ACq2yh86SMjUe4AJ3xWNlz8YKPLlSDn2+ohVXcwPy3Ocv
 y0MCQVyEV6qy8oH5MIXr0cNlqHG2T+HsMaVsQ+AZ/uT8S2fY5dkRno6DI9uFL2/ZXGp+f/R/2hj
 XMDMSNc65ZVDqlMTWOEW+n6uFlikAklS6/Rq6HBd4EObxz0QKpu5Mk08UQe98o5Oyg1rSoZm34k
 wQg+7gBvDbLZmj6nbiGg/1lwm622hHCMHd+Bgv0r7oV/dXRcL5bwXg1wbIXiHnnbzQDli+4bHlB
 W6rsNA+2rpn/yRMOOZTxJg8JtUgLcJaNjUUlihuQ7NmuqIPZdnfiuwj8QxBdcw1YM4hNTrrxOFT
 tGiBteZZITfJT5ji6oPiPdSIo=
X-Google-Smtp-Source: AGHT+IE7axZJLdnwh7fzGMJEYpQY5/lXp9rhUU/SXLMgb2Px1rLPEtLaPqg+zwev3dNaohMbBq8MFA==
X-Received: by 2002:a05:600d:4210:b0:46e:1cc6:25f7 with SMTP id
 5b1f17b1804b1-46e6127bafdmr7048105e9.9.1759257743351; 
 Tue, 30 Sep 2025 11:42:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a16e13sm4856935e9.15.2025.09.30.11.42.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:42:22 -0700 (PDT)
Message-ID: <0ea563c2-2f38-4d2e-96f0-925a3621221a@linaro.org>
Date: Tue, 30 Sep 2025 20:42:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/5] clk/stub: add sdm670 rpmh clock
To: David Wronek <david.wronek@mainlining.org>,
 Alexey Minnekhanov <alexeymin@postmarketos.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Christopher Obbard <christopher.obbard@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rui Miguel Silva <rui.silva@linaro.org>, Sam Day <me@samcday.com>,
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: linux@mainlining.org, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250914-sdm670-v1-0-a344024062ab@mainlining.org>
 <20250914-sdm670-v1-1-a344024062ab@mainlining.org>
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
In-Reply-To: <20250914-sdm670-v1-1-a344024062ab@mainlining.org>
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

On 9/14/25 11:42, David Wronek wrote:
> Necessary for MMC to successfully probe all clocks.
> 
> Signed-off-by: David Wronek <david.wronek@mainlining.org>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5f5aca41d5b322537f070a740bf1f80531006036..d02107ff32a7a8920e352e53b2dc21805a010d04 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,6 +50,7 @@ static struct clk_ops stub_clk_ops = {
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sdm670-rpmh-clk" },
>   	{ .compatible = "qcom,sdm845-rpmh-clk" },
>   	{ .compatible = "qcom,sc7280-rpmh-clk" },
>   	{ .compatible = "qcom,sm8150-rpmh-clk" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
