Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62B85C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9561D82CBC;
	Fri, 20 Jun 2025 10:55:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XXwWIdnL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53DC382CF4; Fri, 20 Jun 2025 10:55:07 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63E5D80E9A
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-453634d8609so6406075e9.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409705; x=1751014505; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FBgVWughqFoNs3Ns4f4d410vGgsrtvBwnT7yI3RhoTs=;
 b=XXwWIdnLAQ4PvcXu8F/DvfgbdQWCJYec65CaUXRZBd9wFOVxD5P5O4usbZSdgfXAZY
 aL6Ye9zRZck0kUhi9sdMO5j2redQpYjcOXViGZq8WHURtulQyyG1IOt2FoCnJFpFRQAy
 IXFrGBgMLKHs7+gS6FUvh1Ifr3aVqj4GquBCViuFMeuZmSwp8F+iADD+PItiSdJSFdiD
 C5ZtHm23MMTOZyMgN+c4Vi0e8lK3WKTKXCWQi5h74ZucCnzahlNYEV3og6Fvy/HSqzhZ
 ZALecGuK4Ieq008278RsgyQijgg1nLtr443ndh1Dvddv8HRoqaykhf1GJcMB193n0LdQ
 JD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409705; x=1751014505;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FBgVWughqFoNs3Ns4f4d410vGgsrtvBwnT7yI3RhoTs=;
 b=LnqgEOQmDH2oDh6ERIv8zsPjMO16zhPoSYIZ4hUUr3U8J14NhCqPOKjlndkvcFEOus
 7jdRmUDfLzXy+MpjSkpnWTohzruDyD5EMvQjG2aQAKU+VFsy5xukMe9yf1SbE9bPdGQK
 ABBdwTO1mN0D9iIbauDcRHgwKXmgJ+Ul4/Dj6ugV0daoaJFVwkO91ZSuIIUg3y9pBH5p
 kt/3v4OD28fg+UbgEYpyPg25/R86P7NvWDWdj6aHhHbBTy8tM7C8IWqzlSYgJzD0p70C
 OdsoqAu1ZzYvUYHfysrUMOocdcWS37lq58Hb60p2wz67h74d3/MomyuTgAbNPedya68u
 biWA==
X-Gm-Message-State: AOJu0Yw8GvCqkXxbwDLqPZW0AmyO/XGYmoHsaSq2wsgBP97lNyp6BqvZ
 6mWZZftEvkoxcTpfcpW3zVLRQDHDp8i574jHWaooSGCJxUL86zN0UVnpgo7c0ZqUD72AEXtNpU8
 SZlGtdnU=
X-Gm-Gg: ASbGncu80qdSpA0Vqjr+q2YQSsx98Z+RKIjVE6/zXoO6VQ7NfSneC4otuBHPc41t0FN
 5O4r7WEtDZ2HN16FHi2vY09DUkP+riMj6Ssgsb4PTIC/MY/bgEtinLQ3nxCpEJ+/fzlwKHXv+Be
 pD64owF7OViUWUPr/cIm1D0Z+yYED5oAm6HusbyzhFbG8s+R3sjAtKVaGbTHnpsx73aohgNWKwQ
 bbn9Dkd8x2y94b0r0jPpLtw5kF8VVAvZT9dby5/v42K8KAzoRBWtPmfBuo9w7rPfspknDnVer0a
 mjZAzIBxrwnvCIcx4QDirm+vylKm60RTe0fcy8QESInOF4JnHVPsFTNa302YUXgIxHoRRiRUgXI
 +ztxYtscs3sKi/NLEfhn7+71Btyg+X4tuNPRSJE4vfd/R04hW7Q==
X-Google-Smtp-Source: AGHT+IHGxDW7YfNINN7aprSMmTJpTpLEm4GhqmAU7000KGG/3mHSnSt0NhdaS/+Ui+g5ODrV0zCkpA==
X-Received: by 2002:a05:600c:820e:b0:43c:e478:889 with SMTP id
 5b1f17b1804b1-4536478ecd2mr20960125e9.0.1750409704750; 
 Fri, 20 Jun 2025 01:55:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb5ecsm18717645e9.8.2025.06.20.01.55.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:55:04 -0700 (PDT)
Message-ID: <6bb69a1a-1cc7-495f-96eb-8c0981a3bc9b@linaro.org>
Date: Fri, 20 Jun 2025 10:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/8] clk/stub: add sm6350-rpmh clock
To: Luca Weiss <luca.weiss@fairphone.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250618-sm6350-bringup-v1-0-3cc22aab7a7a@fairphone.com>
 <20250618-sm6350-bringup-v1-2-3cc22aab7a7a@fairphone.com>
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
In-Reply-To: <20250618-sm6350-bringup-v1-2-3cc22aab7a7a@fairphone.com>
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

On 18/06/2025 16:25, Luca Weiss wrote:
> Stub the RPMh clock controller on SM6350.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/clk/clk-stub.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5f5aca41d5b322537f070a740bf1f80531006036..5863ec72abefefb3c62152805260238b7045e81a 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -52,6 +52,7 @@ static const struct udevice_id stub_clk_ids[] = {
>   	{ .compatible = "qcom,rpmcc" },
>   	{ .compatible = "qcom,sdm845-rpmh-clk" },
>   	{ .compatible = "qcom,sc7280-rpmh-clk" },
> +	{ .compatible = "qcom,sm6350-rpmh-clk" },
>   	{ .compatible = "qcom,sm8150-rpmh-clk" },
>   	{ .compatible = "qcom,sm8250-rpmh-clk" },
>   	{ .compatible = "qcom,sm8550-rpmh-clk" },
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
