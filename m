Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6D5FF4959
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 08:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6762383C5E;
	Mon, 30 Mar 2026 10:03:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xK7S0H5+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5CEB83D17; Mon, 30 Mar 2026 10:03:32 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF43C80212
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 10:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so33492345e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 01:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774857808; x=1775462608; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=I5wSddwNxPsFcpymQw+kjweHwkYcN9QCac1VZoFVwkQ=;
 b=xK7S0H5+B38zAt5wGp8XizZJZR3/9nQtovN/P47zux9jmBDwqWxFLOpnZ3moiUFhrG
 0fKdvXVbZ+710h029MAtQ2RhRHX6gduGLAqDSTUbfXs44XwVXPkoj/o1zYHcbKnTFPTM
 pT00/jHBKrik5THGQDtU6i7J+T1EoJexJh7Jf/CgWqU1NrwRqVmuG4b3shzyl3y3Oa+u
 h55K0iaepaYIBtAwsPZkMidWIm87X29q59frfr0qllhCGxkwwLaJYiVD3IP53cH/dW7X
 vH0f0GyOYA7PRClqH7HNegOhnkB9mGbtil2Er8TQ3pE3m77nrscxd7/GU5qWmKN3kyop
 dC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857808; x=1775462608;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I5wSddwNxPsFcpymQw+kjweHwkYcN9QCac1VZoFVwkQ=;
 b=pdvZQ447LemzEcBINilqXZQiTH7edAu0Hd3BJWimolyZEk1Tu68AKtYwHSEd2NMk0/
 eA7Y3tgqWXd9VgQ6l9WbwtoYb4+TgvKUx7qd6jDlTjF/WuqKyBJvQ4hfg7SSa5Sj/mD/
 2y1a2JmcEa/WSJJR5z+0Cq6AR01c8p/SbT9cksDefQAYGWFEz98dpnsbH4SCXYMgztSV
 tUjeSOPH+ywP/LTEniAYglW6rHpG+RsbxsbYoJYDQq6uJ9CKPqsvgNbly65TO+Ny9qYH
 RoiBGyYuNstD6kSYyk6HJSbZlqi2fQK6STbO0np4mb+Sod3MwU3x8Na8hBTXq6l+gEQZ
 p60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFi6gLvglYaMdyo1MDPQavSKm9NS4H79w22psnMA+cNG3nHP+anQh8YYYxcM1q8Um0M/z4iWs=@lists.denx.de
X-Gm-Message-State: AOJu0YwmIPH1sc9TLFhnQy2mEkKwkrCngVvOHml+zBat8QGRYA73yAfS
 qvBGVte1I8QPJW7VuRS1Om/szfsseSj+wx4UarrsI6ifEQVCTyft84UHZaqamzl+kvE=
X-Gm-Gg: ATEYQzxGk4jiw+FZB5sPIqAe/NtoVpQgZ+kgFVb1AzBqapgMm+EWadWV60+fh+oHF9K
 HkxMo5v+nGE73PBBKm4bdFKCmNufjwrh0RMcizLOYziGOyD2W3Fcrthua1E8lyqc7uusPTNn5gD
 bjm4TCyP6Sowunh4/hF7JuS0NH+Lkgirxc4wGbnhoAe5GRpY14xo8KfSLrE1U7Ldci7eJed+LAe
 NDO6z3EeN4idNDYz7a1VUvmFyoHfpjTVyRt6qjJ6TBUvFxKd5Q1IpbHj2s3uGc2mR56ItRtqm/a
 9Adq5xBdGImTFYsut4CF5bd66dm+mPxrHklzOVSWJS2mrT/5NF4hHDA9AfEQfB16mPRQVKrxYIW
 7XQsnczlFMmQ4Qd0OTogHDiXTFwICEIhii1VM1KPwloKq+zKD8I1ltDs+8EfDpi2unfzQhtojuO
 p2VvIb4w9LAe3b655mLmTFG94DaWYK5wx4Bh53zihUAFxPPD4kWomsNGcznO9lFDViEfvowPLM5
 hrmnZs=
X-Received: by 2002:a05:600c:a303:b0:486:d76c:fa51 with SMTP id
 5b1f17b1804b1-48727f0a808mr141336425e9.27.1774857808230; 
 Mon, 30 Mar 2026 01:03:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0?
 ([2a01:e0a:106d:1080:cb3c:d0d2:870b:6ad0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43cf2580194sm15861023f8f.37.2026.03.30.01.03.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Mar 2026 01:03:27 -0700 (PDT)
Message-ID: <384346b6-e798-45d9-b490-67d8cb6b6751@linaro.org>
Date: Mon, 30 Mar 2026 10:03:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] ufs: core: Fix heap corruption due to out of bounds write
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>, Michal Simek <michal.simek@amd.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>
References: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
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
In-Reply-To: <20260329231151.332108-1-marek.vasut+renesas@mailbox.org>
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

On 3/30/26 01:11, Marek Vasut wrote:
> The ufshcd_read_string_desc() can perform out of bounds write and
> corrupt heap in case the input utf-16 string contains code points
> which convert to anything more than plain 7-bit ASCII string.
> 
> This occurs because utf16_to_utf8(dst, src, size) in U-Boot behaves
> differently than Linux utf16s_to_utf8s(..., maxlen), but the porting
> process did not take that into consideration. The U-Boot variant of
> the function converts up to $size utf-16 fixed-length 16-bit input
> characters into as many 1..4 Byte long variable-length utf-8 output
> characters. That means for 16 Byte input, the output can be up to 64
> Bytes long. The Linux variant converts up utf-16 input into up to
> $maxlen Bytes worth of utf-8 output, but stops at the $maxlen limit.
> That means for 16 Byte input with maxlen=32, the processing will stop
> after writing 32 output Bytes.
> 
> In case of U-Boot, use of utf16_to_utf8() leads to potential corruption
> of data past the $size Bytes and therefore corruption of surrounding
> content on the heap.
> 
> The fix is as simple, allocate buffer that is sufficient to fit the
> utf-8 string. The rest of the code in ufshcd_read_string_desc() does
> correctly limit the buffer to fit into the DMA descriptor afterward.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> NOTE: This is for 2026.04, but please do test it on your hardware too.
> ---
> Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Padmarao Begari <padmarao.begari@amd.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/ufs/ufs-uclass.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-uclass.c b/drivers/ufs/ufs-uclass.c
> index 81fd431f951..6a51f337e47 100644
> --- a/drivers/ufs/ufs-uclass.c
> +++ b/drivers/ufs/ufs-uclass.c
> @@ -1751,7 +1751,15 @@ static int ufshcd_read_string_desc(struct ufs_hba *hba, int desc_index,
>   			goto out;
>   		}
>   
> -		buff_ascii = kmalloc(ascii_len, GFP_KERNEL);

I think the whole function is a mess, I think we would rewrite with something like this:

...
int max_len;
int ascii_len;

max_len = (desc_len - QUERY_DESC_HDR_SIZE) * 2 + 1;
buff_ascii = kmalloc(max_len, GFP_KERNEL);

ascii_len = utf16_to_utf8(buff_ascii,
		(uint16_t *)&buf[QUERY_DESC_HDR_SIZE], max_len);
...

So we stop having random len, and use the _real_ len returned by utf16_to_utf8.

Neil


> +		/*
> +		 * utf-8 is encoded using up to 4-Bytes per character,
> +		 * however, we only allocate such a buffer because the
> +		 * utf16_to_utf8() converts the entire $ascii_len worth
> +		 * of input characters into up to 4-Byte long utf-8
> +		 * characters. The rest of the function uses only up to
> +		 * $ascii_len bytes of that utf-8 string.
> +		 */
> +		buff_ascii = kmalloc(ascii_len * 4, GFP_KERNEL);
>   		if (!buff_ascii) {
>   			err = -ENOMEM;
>   			goto out;

