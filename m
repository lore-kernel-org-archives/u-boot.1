Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DC5C71155
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 08:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEC4382CF4;
	Fri, 20 Jun 2025 10:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sbCBfD7O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66FE482D88; Fri, 20 Jun 2025 10:57:11 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7945782CBC
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 10:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-442fda876a6so14218515e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750409829; x=1751014629; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=g7KNeeS2RRaKlsI26r+lPLpNs4n72K5TTh1X91VdQnQ=;
 b=sbCBfD7O9e+Q3ERH0Tgqvn1NozwSl2LgDcbmGt6nTa+A927XbCybbvXwch6y7lqBkB
 mlVJuaLFS2qOsN8ndidNlvneJ84u4Fre+OcYklaHqsQ0WOagXRQr/koqaXAU7HQqdKLM
 YXFsT377dVRdzW7dEKK69cVbW5RCcNQXNu3SW3sUeQlsfCmS7A92T3kFkrK5Gniy5Hz4
 I8xFy0sLd4EDYZzA0vHaYaDzKSkkJttweV1tiRJqXt3NHRttBeP7xoStYTr0uGWasC45
 +EJq1D7sEwL+OfGDjh7wA9gdj1yFxJetQCnA5QBB9VqbYZr+nSczY6zkJcuUmNuIRABT
 8N8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750409829; x=1751014629;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=g7KNeeS2RRaKlsI26r+lPLpNs4n72K5TTh1X91VdQnQ=;
 b=nPEX4CxmOp3w2UjGrWysVVUaQpLfHSVK+excPpwNjntvR4YTe0AYe9EcfyoLY4bvwO
 dQHPV7pesvgADnKLsCv6PiOSy19CesQRQgnvkAazkD+PtWn0nmg1F1BjhfJiMwYhWBl9
 zOvIk3BEFk/S6cOrII1djSO/Qy1OujWli41zVGHi53UPdoCxiQqi2mroQSGXudcPkAbe
 3howQZUXBEiwr58TIcivhalpGfBFJDkeA6MwLisWAJqPsZ7sfffftT5fp5UW8w4xYkPN
 LFOFZzgDAvqWGNcPOLUgvhTvkee5plpTZ6a8u+HqEYAkNGcZqsWmtYPNp1Pby/as9SLd
 yn7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCULzoPLZRqO0VO/acn2/yONmsmLZ7LlU2jetFMHlNkXK0LKXvLTLDXDhDaEwzXGGnJpyE1ORmM=@lists.denx.de
X-Gm-Message-State: AOJu0YyydcM14MRgnMuyVDkDK4+pm+uuIaIwnA0Xe+baO/lPQz1QnsbK
 9W5GOg591bAn2YqVgZDd5QvkhAzY8bubDmg5vbIiXQIYGxBCdugB/FaNijs0KtzFgdg=
X-Gm-Gg: ASbGncuzB0jW8h4ia2lCa/krozUc63QZ+AYeE9ZRIkW/SW4UuceHhGojE9DC8xTl4ML
 VBpwgivEmBN9MuWmop+C4PpV72TIBuxN5L+11Zz/PfpOMGEUAoQ9E8qgFYwfJBj166yRgD7t1vJ
 /NbXDy+zoHVEphjI+FRyKjOHuVTfa/5pRDqkJY0Lv7JgvhpEyUgbRwqJG0Lkxz+c4q47EozQjEs
 7RRDTLJjMe/dS4abc/o2G0T9iCQCKI+nSnsG1e/8oX3HJOGq+bs7BmAktdCeBXKsF8W23aJHRxG
 ++zkvf0fppH8D5BVXEGZa/G1ubWtlHKXYygAfHLeAxsX4WCldN9mQHzsI7O9MnnYn+aV8kQDyUW
 DiMJwkGZVd6oIuaEIL0o3rpIiQE0ReAv6qrtyqa8=
X-Google-Smtp-Source: AGHT+IE4R1xqbIHt6rvscgdaxLTZE1j8hJjMqUn4SG2JZkZWJmtTbuelPFupzTkQXVy2Ewp8hEMIwQ==
X-Received: by 2002:a05:600c:8b23:b0:442:faa3:fadb with SMTP id
 5b1f17b1804b1-453656c1fd8mr14933875e9.2.1750409828939; 
 Fri, 20 Jun 2025 01:57:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:3d60:2fa3:b982:4627?
 ([2a01:e0a:3d9:2080:3d60:2fa3:b982:4627])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453646cb5a8sm18740875e9.7.2025.06.20.01.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Jun 2025 01:57:08 -0700 (PDT)
Message-ID: <f0baf6cf-41c3-470c-93c4-53c3ddfe5af0@linaro.org>
Date: Fri, 20 Jun 2025 10:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] clk: qcom: sm8650: add usb3 noc clk
To: Rui Miguel Silva <rui.silva@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20250618093253.225929-1-rui.silva@linaro.org>
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
In-Reply-To: <20250618093253.225929-1-rui.silva@linaro.org>
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

On 18/06/2025 11:32, Rui Miguel Silva wrote:
> Commit [0] introduced, correctly, the bubble of qcom clock errors to
> make it easy to spot missing clocks in the platforms, and this is a case
> of that, add the GCC_CFG_NOC_USB3_PRIM_AXI_CLK clock to sm8650 clock
> pool.
> 
> 0: 7c5460afec3f ("clk/qcom: bubble up qcom_gate_clk_en() errors")
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>   drivers/clk/qcom/clock-sm8650.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/qcom/clock-sm8650.c b/drivers/clk/qcom/clock-sm8650.c
> index 364454644a69..7c49e99c005c 100644
> --- a/drivers/clk/qcom/clock-sm8650.c
> +++ b/drivers/clk/qcom/clock-sm8650.c
> @@ -193,6 +193,7 @@ static const struct gate_clk sm8650_clks[] = {
>   	GATE_CLK(GCC_USB3_PRIM_PHY_AUX_CLK,		0x39060, BIT(0)),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_COM_AUX_CLK,		0x39064, BIT(0)),
>   	GATE_CLK(GCC_USB3_PRIM_PHY_PIPE_CLK,		0x39068, BIT(0)),
> +	GATE_CLK(GCC_CFG_NOC_USB3_PRIM_AXI_CLK,		0x39088, BIT(0)),
>   };
>   
>   static int sm8650_enable(struct clk *clk)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
