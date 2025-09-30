Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EF2CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 18:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 220E2800D7;
	Tue, 30 Sep 2025 20:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C6aZmnof";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6436835AA; Tue, 30 Sep 2025 20:38:27 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE1F5800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 20:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ece1102998so4283820f8f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759257505; x=1759862305; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=1y0LzoWbxTLDBjx3YV4OVWnhd46QIpoCTExb+zOwWTk=;
 b=C6aZmnofTITPN1cXS34IWp6YoWdvIoSiqMh9GLQ2KNd/HdKKfAPXak3lM1olVssS27
 Aj0V177jYOlxJ+8YEkKLBKoqcjxPrLcFDajWv96SUHkbS7qAxXxm9hzWVFqUa0rtxFq8
 Nac5T+q8vdT1DSNk+PMk9J7M7w8rB3cj+8IgA1fmY2e7MlPv0SGO31mluyiLLs5YqQ/R
 bFRaFORu4ozZ77X9G+ZBAJxIDbQjtIU5fKAzcvm/CmX1qKw81gUeembDupE57d9061u3
 D3lJFsReXq+oQ2zen2EzG4E1W0cVs8EVzQJVF3SgofRzu8lKK3w4XwN0X7nH0rMzcwii
 qgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759257505; x=1759862305;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=1y0LzoWbxTLDBjx3YV4OVWnhd46QIpoCTExb+zOwWTk=;
 b=qnl4AThJveVEJ7xJlH7kEqzU7pyBpeiIHsVSQi/+ClmdH2knjTSvlz56DTbMuOJ9KH
 bzt8LPd5mq/8XtcoqR8Xy7Q0xfahLN9aDFS2LwX/pmcv4Rp+eRxaPc5bqiUuaSauWaDF
 U0Fa2oJIMUkaiqNfnsNd9nUa3ce5aSDL5E0+a1va3X99VvMyrqYU6h0wtxVjYF/cK/qg
 O3vAOVLvt4bEic3zek3SGHaCtfgT1T+hXth5tYBwe4HP8mkUNUpcW70QD0WNDW+cob2U
 xUgtRn/3rRG+7Tt6Tm+B++I8nyN2gj9SrbqnyZkdAUNkaFAqBf4/1W+/OO/jiFRlKClN
 y9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3qEgKb7wObgUj1QHb/USMucI4t1VjhMxy9F5ckWSME+atIM/l7m9vloK6knUL/1aWUU1fYCs=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2zkn+DYxNRZA6yUv0HjrVlzYH3hfZgDbMdUD4fZTETNi6BRce
 vbYHPue+fqp2ZdjAKqpx0L9MPr8f3s97Pq8poZVZPxFe+m0xn3NBy0C9yUp4zPWO3Lw=
X-Gm-Gg: ASbGncvom18O6o2nWj/fnBS51CU8etDcfavZXiKjIM7MxCo9arKogDlsg2hWMTO3xYV
 5hlwCSn0ezvaMxXzQdfkrFcElvl8Q2n20/ooaTMRkDDd8uCtM7fitJJSsKcp/4o4/ObiQT1jOCP
 dsneOPTjVP+tXX8huNy/i1cxW7eT25ETs7CDdiYJ4kiMqtyRBiYmizsE16p/4FvwO3v8MXw8RlJ
 0gKC6HbrNitpxPcyIkRqpJJgpxM0ALjOBZ02ZkVmiPZ1N0bQWK5XyThS6AhLEzzNdFt2JmRnghV
 zrDnVvBl+2CD+W8F3sKOVP2th6L4dpjMM5bnpB4eJGO2OKIBdKJ9xsS3ShfFMDeURvpUS9cddev
 JzdlnQW9/BKW7hOgewNnY20B7NXQWudPULBTXo/MRapiNfH0ybTC/ufb4sw3Jp688m4FYJuKOCU
 7VPc3Kmru8BHvyAhxWLY8W+UjyIq93JGWLBA==
X-Google-Smtp-Source: AGHT+IFJwJB/yjEvFyxf7jmV+XEVc2bGrwX/6KRDcAKrX1evT6ZLqDQqUyu+nw1pvZzZTo3I/8xjLw==
X-Received: by 2002:a05:6000:26c7:b0:3ec:db87:e88f with SMTP id
 ffacd0b85a97d-42557820ceamr613000f8f.58.1759257505114; 
 Tue, 30 Sep 2025 11:38:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9459:14e0:525e:d859?
 ([2a01:e0a:3d9:2080:9459:14e0:525e:d859])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb871d051sm24335154f8f.14.2025.09.30.11.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Sep 2025 11:38:24 -0700 (PDT)
Message-ID: <199d6674-44c0-41f3-8f47-b478802e46c8@linaro.org>
Date: Tue, 30 Sep 2025 20:38:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/5] clk/qcom: sm8250: Remove unused defines
To: Luca Weiss <luca.weiss@fairphone.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20250924-2025-10-misc-v1-0-7e75842ca714@fairphone.com>
 <20250924-2025-10-misc-v1-2-7e75842ca714@fairphone.com>
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
In-Reply-To: <20250924-2025-10-misc-v1-2-7e75842ca714@fairphone.com>
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

On 9/24/25 13:30, Luca Weiss wrote:
> Clean up some defines which are not used in the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/clk/qcom/clock-sm8250.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clock-sm8250.c b/drivers/clk/qcom/clock-sm8250.c
> index cc481258d2266a40c54d51fd2c5faee22ea9f2cc..37268c4eaf5a6c89f519cf9853101717ce86b9c9 100644
> --- a/drivers/clk/qcom/clock-sm8250.c
> +++ b/drivers/clk/qcom/clock-sm8250.c
> @@ -18,14 +18,9 @@
>   #define GCC_SE12_UART_RCG_REG 0x184D0
>   #define GCC_SDCC2_APPS_CLK_SRC_REG 0x1400c
>   
> -#define APCS_GPLL0_ENA_VOTE 0x79000
>   #define APCS_GPLL9_STATUS 0x1c000
>   #define APCS_GPLLX_ENA_REG 0x52018
>   
> -#define USB30_PRIM_MASTER_CLK_CMD_RCGR 0xf020
> -#define USB30_PRIM_MOCK_UTMI_CLK_CMD_RCGR 0xf038
> -#define USB3_PRIM_PHY_AUX_CMD_RCGR 0xf064
> -
>   static const struct freq_tbl ftbl_gcc_qupv3_wrap1_s4_clk_src[] = {
>   	F(7372800, CFG_CLK_SRC_GPLL0_EVEN, 1, 384, 15625),
>   	F(14745600, CFG_CLK_SRC_GPLL0_EVEN, 1, 768, 15625),
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
