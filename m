Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B372C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 07:27:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCEFE80EEF;
	Tue, 25 Mar 2025 08:27:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Js3h1MOr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73C7580F70; Tue, 25 Mar 2025 08:27:56 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78E90808B6
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso33523195e9.0
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742887674; x=1743492474; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3mz4KMNbIlrCK46OQBgl6XPyZTFJTIQP8ZcmFbmRNrA=;
 b=Js3h1MOrOoSrjAUFMlJiTL9r3L8MPAdFPHiJYAHTi/nwhyUmVzg2myf7C9/M36XUiK
 zBK+j2+miNwN8zckBXJqRB6JLa8t7rnI93+hC01wGyy56uKaN0s8zWrHaHsaToKmN3od
 cWzMTrjDdEKPjGXhK4M2Yu6d38VF6bUbb0nNnhizSgH48Vx0rvi1pOEwZIV+3Ia2pGa1
 U6gzmYw9hvckUNGhaSo1MvcBcsH2SlddTUH8pBy2XfK5nhmOrTzEwvQXvUH6I1d7sxyI
 cLbOriUVZcFsY3bRsiheQ7lm0CNwekc9rVfowEmUCmfN6wJdbunZH8WCmgENOWiIFvOj
 LcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742887674; x=1743492474;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3mz4KMNbIlrCK46OQBgl6XPyZTFJTIQP8ZcmFbmRNrA=;
 b=gFROObrddqozaqKOAECREKSgWcAqVXqcPxkFa3ktnZkMFuuygKxX70nLRdRdTh1lf3
 BRc23wg+qb0+kgGQi+75SpoHm7Sm443tKbA08848Hjyx7FCKQywNIelfhSrI6EUAHUke
 VA3SEp5GFyPqr+pmaR9PHKVs/9kEpUaLYqmCpv/ZEz9kZUnWomSV1VWDWWbLBUiBmLe3
 gfSn2euScKl2MIJxHVBVVgEvAuEo/BszYxYLHbNhOqXpbi5ObLox/SYPHrbu4t8DNjuh
 27szwS56ZK5XlTPStZNdQgqgZJVpaZBu2MWVK0bkOG46/r8wdG6QbK3ta/ovBBrcv5xO
 ZRjA==
X-Gm-Message-State: AOJu0YwICqcR2lVo0jx9PD5Z3YEHYAhTvetscGhCWREifS2Af1dN5C2F
 sPCiekeedqDanIm9lgm3XWLl02u4LyOepmq1nvrwdrgBSXVKNiCYWQF275gXMNo=
X-Gm-Gg: ASbGnctpnFB+epPZOpZYoSYmK/DTwkcMTzlj4brEwPAqudMFkN/fgIhzv2j6yDbs4Ji
 thEFSPA9+82LGD2QHhA4LpgRiML1thxGYy/fyAutVoQWcJPGZX2iTJ1OgbZaeqqK5gaF9Wl8CE7
 8qrBgzycac7p6X7ti9wXvqDiD6ZAnIkclNMTyUAbH2EXGBO7/H0VpCUUl179bmBG8veT/Ykqj8E
 a7eP7Q6WgH2B6Si5o+31MFMHdXRlaMDJbKQBZrQDpEQWuLZKMuqrrPZFTSSJ3SGTPqj4nLprFsC
 ij1Bzht8Ycls2A9XUlJC/oWY+5Ccr+5y+oaq4FCpstwtb0ehbyXgdBbnrxRVx7QIm/vjLIhc0er
 I5sTf42S5q2j+QRSm
X-Google-Smtp-Source: AGHT+IGSPR5zpDex40CzHRun1+xGrVvsTodXzb+Xtb0pwXTLTzpz7U1ZSDoAbT3Af1ZHinMFuQjknw==
X-Received: by 2002:a5d:64cc:0:b0:390:f0ff:2bf8 with SMTP id
 ffacd0b85a97d-3997f8f6555mr15136129f8f.10.1742887673911; 
 Tue, 25 Mar 2025 00:27:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:7a:6952:5850:1802?
 ([2a01:e0a:3d9:2080:7a:6952:5850:1802])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc9bsm12715651f8f.87.2025.03.25.00.27.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 00:27:53 -0700 (PDT)
Message-ID: <ec187f34-d409-42c0-866d-91d405a46fe1@linaro.org>
Date: Tue, 25 Mar 2025 08:27:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/4] clk/stub: add sdm845 rpmh clock
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250324-sdm845-fixes-fastboot-v1-0-d177a10f336d@linaro.org>
 <20250324-sdm845-fixes-fastboot-v1-1-d177a10f336d@linaro.org>
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
In-Reply-To: <20250324-sdm845-fixes-fastboot-v1-1-d177a10f336d@linaro.org>
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

On 24/03/2025 19:17, Caleb Connolly wrote:
> Necessary for UFS to successfully probe all clocks.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 343fa5cd3fe1704c6bb15a8c9852b9b4e4990351..521ecfc5917b45f8ffaf2f25aabcc5abb4863cea 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -49,8 +49,9 @@ static struct clk_ops stub_clk_ops = {
>   };
>   
>   static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sdm845-rpmh-clk" },
>   	{ .compatible = "qcom,sc7280-rpmh-clk" },
>   	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
