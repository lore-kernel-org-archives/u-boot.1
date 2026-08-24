Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F116DC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 12:59:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id B8E2240652;
	Mon, 24 Aug 2026 12:59:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc5kznFKwJ7l; Mon, 24 Aug 2026 12:59:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787576396;
	bh=9lhzdL+a1BKnrrBERY/UHGCc8CRG9V/A8/xlr7D0+ds=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=STYoiXRWZQ1H+jyckZ26lDO+LbxSLKbH0ZvZWC0O1cgf97/3kG/K+pTKtfDn6WSWm
	 x54zv6Wx5YSwu4iUednYLdL6G6h6YVmG17191Ku12WXUTuDpe2mKWUHnlcSavbfpv3
	 QJUrQgS5vRwzbSCym3dMr8L8WM2eE3ltOnEQL7tTA0UfhN7hozeoQtJMZvH4sjTYvT
	 Go/glCHqyHTclkbzCdEYLnUpaDOhVCO/+bKA519vk8QqQ0u+eipxNpAmk6yGUBFRHF
	 b/wk2ULoG2kFt85PqA9UrGgEWT0NriKJgp3htdEYaoF9ydpcps+E1aJ+escpQ7h2Xs
	 cTHEQv29jLRyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6326640340;
	Mon, 24 Aug 2026 12:59:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86AE8396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6D41440029
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GvGEXJ7kn-R5 for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 12:59:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42d; helo=mail-wr1-x42d.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=DX4SUiEC
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7CF4040050
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 12:59:54 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so2489366f8f.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 05:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787576392; x=1788181192;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9lhzdL+a1BKnrrBERY/UHGCc8CRG9V/A8/xlr7D0+ds=;
 b=DX4SUiEClr7+IeOB5mLg54GKZDbJNsWAVob263V8rwRhoBGjUQF/l5bYk5ok+MMqbi
 /Mpn7WS7fD65ky5DdA6U4OvBlA1kqMjlC2r2ZXtQMmlfoEFldY1iaSG9V91XLgaRi1Et
 GoVrjQWGgFPTze8bTtN1NVqLn8QlOSFY5BXlQbyIpQ2RU/UVTInnVFE9rExf7jt+d+Qs
 NuDSdgkZ9EIXb+QmtSJZCUU2/xbp5DsrEk8XVZkI+nP6HDFC2PnKul2NO9Q2c/s6rlmA
 ZdlJCYIF3l7G4n+5AQaOXs42px7DmbQfWC2K2rWhfuxWNikNPgvwy0dCwHLwAIhKZhqE
 TR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576392; x=1788181192;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9lhzdL+a1BKnrrBERY/UHGCc8CRG9V/A8/xlr7D0+ds=;
 b=aHz9qzoX5UxaOKy6HBbN5owpqwVNLZDBEKsxMhiiqnoTkPYwxxlBWT+GyUxZVC/2mC
 jfq8IBbOYKmsYmwyUcGWmWZbQ5ujJbdPaMf7D/fG7SpEpiiqcCmVR8BXWgGc2X00tu8u
 4hO6ZYaiEVR8yFUFKxt19C7BJZU6g1HI8+my0A0TqB2Ap/Ry3CXTzvxjlX/AXmJszXNL
 862BhOitCSM49DKNyKTqpYvyBjqKCy/bpliwlEsVsMmIKViN16I+Yng0F1u1JUIptVW/
 60J7UF4a0OrbArtaMKTD66fw3m0MRAWoZldCl14sE30sXeB4ENGbUpz+HGhDHSWk80Om
 kKQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIZyC5h6nQM/CrNEIsf9U1//J609siDI2/iD7DcxWOEyPUD56+tS+q3SkvrjtBz5JbJ9DgFy4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mNP2cT8g0FHEpjlj6QzMqJeyjyS1b+KuD/0FofH2ZTudKOyf4s
 /967qTarNS9HqoxkQnyL9uVJ6s4PBzFctbrSiYy774sgLUksOt0+gl31X1UetRjrxRU=
X-Gm-Gg: AR+sD11T92iI39OVgT8PVfAQ1cDTlXyg9VXnXwJlz3unXAyyo20i6R6AnEDsmCihI3r
 ld/iqPAFnhBfz6qQpYa6YpHeQOE/35PBgtA2u6SzzhpD2yCkp53KqBH8CM+wuC1pGYQ9ea8u9Jn
 7uPNeOoY0BZCf7dCIk1JluCYEBoW36dxdTSScwYH8KUQIY5sIlWueH8X1ZZhDTx2MsYxI4tEWI5
 b7h7Hwe9u8D2wwLxJJJZq71Iut1qpXp8bVXZK6OW+DSDvR+XGi6AYweW50ShXfo/YDL/NSO9L9Y
 +yfhNgft2QlgUbGAoiMo7CCX/d2ghFxldlczu8fGeoA6IthtsGZEsDa5WZR2fKdGhGJdeZnJngX
 CpV4JkyTWqJtYE4yuhwHB5G3DLV995I6CtnI+0mxyAY1VRycLbNLjWrLICPK2FovFK4i9yhObJw
 urBqaRnR3BsCcDZwXCm5i7SvU7o2HP5HCQ+Wqs9bxp6r4eIk3wA6LrUU1rKtSobePS1Tn0JvZnm
 buxDQkDEhvjM1rL3STm8VrqxJQempyp5YGBJ5y4/9c=
X-Received: by 2002:a5d:5f93:0:b0:47f:5ec2:d54 with SMTP id
 ffacd0b85a97d-482c816c126mr19222602f8f.5.1787576391949; 
 Mon, 24 Aug 2026 05:59:51 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273?
 ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9c0bef5sm8339351f8f.31.2026.08.24.05.59.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 05:59:51 -0700 (PDT)
Message-ID: <2aa0d5e3-e0e2-4f82-b620-39f4c3a220e6@linaro.org>
Date: Mon, 24 Aug 2026 14:59:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] serial: meson: Add s4 support
To: u-boot-amlogic@groups.io, sanderson@brivo.com,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>
References: <20260817163438.1893025-1-sanderson@brivo.com>
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
In-Reply-To: <20260817163438.1893025-1-sanderson@brivo.com>
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
> No new features, just a different compatible.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/serial/serial_meson.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index cc71381f87e..336ca552ead 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -244,6 +244,7 @@ static const struct udevice_id meson_serial_ids[] = {
>   	{ .compatible = "amlogic,meson-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
>   	{ .compatible = "amlogic,meson-a1-uart" },
> +	{ .compatible = "amlogic,meson-s4-uart" },
>   	{ }
>   };
>   
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_serial
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
