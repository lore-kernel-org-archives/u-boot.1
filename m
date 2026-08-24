Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 004C6C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:58:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 806B94068B;
	Mon, 24 Aug 2026 12:58:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uenVrikzmUO5; Mon, 24 Aug 2026 12:58:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787576306;
	bh=tvYqAVJPkgLOZpglJZNbXWxMsUxPbAjEsvQW0SCKmKI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mo8PDgZISqjgz/qbCUcKg9SDUFV4gN/xDbDrt+NghBniomlkP2j5uWZH7XNfPJmfP
	 3Kun+ODmkkiWmSCcl3REd2KD8tCN2KAnA32GmE3VdoeJKGDGHk85Totgwu7aN64q7k
	 fqron66EFcid0E9Q9n3iBN9HyeyjQEYx0QknS5bDkfHWzCMPcXb2XWFP1F4Pa75GZJ
	 Wl7oQNrBklX6ce0TVBXIuyhpcGepgpWRcFRkBh3LSFgYr/Uc43Dds9ACm5Jvxfi2H5
	 wUYYjPsU+JsAJQ2bn9JVHRT4nS4yri15q78S1YKdT4+TxqyRNAop3p6WsQMk4r22Cy
	 lQGgW8ZpkrFPw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF97A4065B;
	Mon, 24 Aug 2026 12:58:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 12752279
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:58:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 041654065B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:58:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MWxI-EX2HoHz for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:58:25 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32b; helo=mail-wm1-x32b.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=b7UPB4hO
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F387840652
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:58:24 +0000 (UTC)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so17079155e9.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 05:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787576302; x=1788181102;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tvYqAVJPkgLOZpglJZNbXWxMsUxPbAjEsvQW0SCKmKI=;
 b=b7UPB4hOP5gc9EkW04xVl7PkLokTuw5Diy1/8EMDvigUnTURVf4y5jAtkC8ZT0mAgh
 pwRfukQz3Y7RTVQ1y0wgnkbn3MWDqrnwXhKl7Z3M639kSKEGfBCz2uIeUZjUddn6C2nh
 GyE+Fh8b7PAhehKzkRn0878qNlyWgy+UyqTOc63WqOCeD9qtB3LPKiGMKEO9hJ7VuMfy
 OyF9D2FvjKgTbiIFBMrr7kSV2P8tSOqvDIA3OrNRUVMh+iifcx6EKwtWSlxV3bTj5EhA
 opfN9HRGvtaguXtmIhRVcaxyT1syn01v9ps4P+WHxWxBUvzC67WM8PySrjK3BTRGGNuS
 Rq2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576302; x=1788181102;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tvYqAVJPkgLOZpglJZNbXWxMsUxPbAjEsvQW0SCKmKI=;
 b=ZJTJjjslX2ChHarts1v2iv50Rv3BoraoZ7d/gByJp+HE0jO0CrKW+Xtwy6kqvNdYif
 F0FskIXlU0Ls+eosX7Ya6XFMe55GkOz5cAFPU4hcS4izeifndeIWOUsJbE6bzDutlzM1
 iRMyP+OpDvm+ln12TZjQmqGJLA+H5yzTsIIZ+3lyXec2ay0AcBwmlursboXBUY0tH9SG
 EpvX2gx6Qo2kuCumxYclhmT6GxqRkf1TU+OnMO2LEkM8DGYAr1m/7jGBwNVGZCCm67oM
 ddYazc9/x5yNUuMUb0CBb7ow8RJe2BhU+FIvEXzOuaqgHdZiqrd20D6sStiMpy+9oyVU
 A+yw==
X-Forwarded-Encrypted: i=1;
 AHgh+RroOb7PkGDBlITm+71fFTPv/Vf8iI/0ln3wXfZSVuleo9+wRRLqqXa3H03yFV8NQ/CwySV2Zfc=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lFcUuGQ6j+VS9v/5Ny0K2TAG6QIUF0030Y/9YOKogaTZ+lISqq
 AxCthKN7ujK2gaVO99SwWhIg76TZ1HJZvwYpsNtxlvw2vb4obnquz3E0TMwG2fuyHg5kdxdOJ2K
 /VLht
X-Gm-Gg: AR+sD12AVgX64F7qpjoophg2makr1aEvMlT2Er0lV4XD5Rh6d9GeWR+8dY9sWJCteSb
 zPisPP703XdGTwhenvkiUgdNgHNMDZwxl13JQ0garlJuQT30NTAgn5QIWkeb4VRtdjlJf8RFC7F
 ZTtDQK4gIvbsZloaafIW+QtiEX9nFTsG1/NcoVZ4AQN7WSkeSDjR0zHEAa3qgjHtepoaMQTTTB1
 kl0X+99pJuY6dOFxc8Vfdj6SqVQlBuXZUSsRgwaNf7ERq3fdJIK2mIb/q5A77GWhUvORqEfJkOo
 uQ9eITpHrYVdksu6idxGS63E24dE7XiSIC3K3c5uX9zrskrG2vvSQNCCWwAZEKLKVt0KuxqX/tM
 M7UbMVufd626NKNj9T/p8Dnsr3miMtvIJt09oI8gfDyzw4CPEdWB8QGQqRrohugxFhXtFQQYF2Q
 rApXh5QGbBuTw4+UOKKEd4lJXJzLHpQouZGQOAwAIbycz7xXup855fBIzh9NilMeXoevdkUXXVv
 1H3GQU8z2xreIRBvncQcKxBDv1zrtr6XhLsN7acTGrXZGZ0XEOn
X-Received: by 2002:a05:600c:e549:20b0:499:b65e:49c9 with SMTP id
 5b1f17b1804b1-499b8343decmr236567735e9.10.1787576302199; 
 Mon, 24 Aug 2026 05:58:22 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273?
 ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b914baeesm124361275e9.10.2026.08.24.05.58.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:58:21 -0700 (PDT)
Message-ID: <ef009f96-675a-497e-ad49-be43f4871282@linaro.org>
Date: Mon, 24 Aug 2026 14:58:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] mmc: meson: Parse devicetree properties
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20260817163652.1893650-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163652.1893650-1-sanderson@brivo.com>
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
> Parse devicetree properties so things like max-frequency are respected.
> 
> Upstream-Status: Pending

Please drop this tag

> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/mmc/meson_gx_mmc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mmc/meson_gx_mmc.c b/drivers/mmc/meson_gx_mmc.c
> index 76af3873e15..b5b4e60d8ec 100644
> --- a/drivers/mmc/meson_gx_mmc.c
> +++ b/drivers/mmc/meson_gx_mmc.c
> @@ -351,6 +351,9 @@ static int meson_mmc_probe(struct udevice *dev)
>   	cfg->f_max = 40000000; /* 40 MHz */
>   	cfg->b_max = 511; /* max 512 - 1 blocks */
>   	cfg->name = dev->name;
> +	ret = mmc_of_parse(dev, cfg);
> +	if (ret)
> +		return ret;
>   
>   	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
>   		cfg->host_caps &= ~(MMC_MODE_HS_52MHz | MMC_MODE_HS);
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: meson_mmc_dt
> 

Otherwise:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
