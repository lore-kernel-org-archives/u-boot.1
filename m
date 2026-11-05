Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEF2606A326
	for <u-boot@archiver.kernel.org>; Thu,  5 Nov 2026 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yR6eAJd1;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jMrWsy4S
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A1913810DF;
	Thu,  5 Nov 2026 10:52:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T5qplkTRXRE9; Thu,  5 Nov 2026 10:52:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F1E9A810E2
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793875925;
	b=tdv7oyRNDFgkZgHRUxi+p+EiTySHh5B8Dgr/B3vB6u4C0orzyaxFpnCf/r8oDKL0RDXd
	 joEpzMTocjuGP2NBFCv6eeWABzsAuKFrkmBMiUpxyBoWDjt90ZqihPCjC31Rgyl3ObL0T
	 DNN2ZI+EO2NV5NQj/Uv8ovYql/qFqwzHwdorzacQw4Xxbl/yYk6lxUu2zumIAHWZEyEhz
	 G2adx0DsKkSUkAsKd6orzIhAIh/zKGownXVgvRo8pOBcb4pyjfZC8bz+aiJPzqvUYjwBG
	 SPRLa+bFCn9B3RH5/q1ReAiW+ki1fxUAhwT7LfCZERmQxCW55dfKvqxyrFBZAfGaMxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793875925;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:From:Subject:To:References:Content-Language:
	 Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=ojWFak9opfieAkvnw4h8u7hMfBEUy3boOXP9S53ly8g=;
	b=T4b/txLVj9pqrpIvwRTNjJpCNwrDTE0TLrKDumXtkR+MA2mAAA6L6r5BUbclfKfHKdI1
	 Z8ZdOU01/alWZ33Q46SRy/FDehs8TvPKagERZkWBg1/VDESktnGnl+mzuFsUmlVJNoPjk
	 kB3OCXPPaXDYG2LSGvgE/RrVIirRP7JjyR2bLFe8kpPWIc9gfTzG3x1VjYOX/G3A7toZI
	 M9F3SbdFL5WURZNuFLWi3W04m5w5sjm4KxgFztV0V+UKwrA0UskocsROSB+xW6j+2Rbp1
	 cWSXD67fjdZ/vH6zlpkj/OaiR2eykVm0JNI/VtGlpDRsP1v8I3TivCcawq9peED6Eew==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793875925;
	bh=ojWFak9opfieAkvnw4h8u7hMfBEUy3boOXP9S53ly8g=;
	h=Date:From:Subject:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=yR6eAJd1hwy2AGw2JjxAZH1Xe/zu1Uwwh/w9CZw6RuEoBLV1CDtr/o4tZ6tSuidIB
	 D/c6Ze4HaPEAemr4V8TVrr9YDc3B4XFYO1Cq+zrDUKgPt+zEPEnOzBTHmE/TtFDdJR
	 Bv5iHcSwQbsJvq5cQi1iQD+snc6dUunmEyY9ytyFZ5PhE80sJbROsd3EvqmTrD8fYA
	 mUicFuDahW/tEs1D4dGmB+YSxq151lzwP4Tjgwp6Wm4sHRRDx5wC4J8Iw0iKh/gIfQ
	 uEJ9z2Ntu6WbynpS4V0JmbHfeVDRcY2HkvGe1vRIQp1CGVR7JbQqLj4jlSWBUAlo8c
	 G1heWMGcZ3w6g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1E9A810E2;
	Thu,  5 Nov 2026 10:52:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 863C231F
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 77D436080C
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id L2h32tfWA_SP for <u-boot@lists.u-boot-project.org>;
 Thu,  5 Nov 2026 10:52:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F8FE60697
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=jMrWsy4S
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F8FE60697
 for <u-boot@lists.u-boot-project.org>; Thu,  5 Nov 2026 10:52:01 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso12719405e9.1
 for <u-boot@lists.u-boot-project.org>; Thu, 05 Nov 2026 02:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793875920; x=1794480720;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ojWFak9opfieAkvnw4h8u7hMfBEUy3boOXP9S53ly8g=;
 b=jMrWsy4S6iMyOvKT0o4KKxCvUDCSPSaoEh7sM9OxWQF/XolLZ4yJszFTHj/8rlGU8v
 ZhcC3T/20KlCNpAIfxqR6sX8sA6xXnoBpQHEteyTsaYBQ9un5i/PCMnEqScmEP7Wl2TJ
 COzzngYak8DJLWszA2J/FZYC1D++CTZVnlIFmgncYtdXimae2GgQz1m/l6hcqlK0xrYV
 CqJhNfseG91DILpxNPbeDyTig+OLgip55Avgym04n+zBmiuZo7/RDPURi4mxiP/g8y7J
 YeBHQHisP0QGfNv7kej+TnPil+EnsQ+MiJodPXDJAn9aYTlyvVsc+9lz0bZID6+/1Zs0
 ojWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793875920; x=1794480720;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ojWFak9opfieAkvnw4h8u7hMfBEUy3boOXP9S53ly8g=;
 b=u96+Fx+PVtKgvkmwtQNQSq47R01b9F+D8OCzNMZjc84IKhFYYpPLLZwTSjnIuoovM0
 kJKySkWel1pP2x5ejxRdH5ewTP+NWbzeLknrj7qRy6mCTZINtvPpzIO1H3TSlxcSpMp0
 LqQwlkJ6mH9SjhmF5w6GVyycYzJCXF/J0SrWKZTEGdV1Chpe8nVDlytWjxwE+7DiaUgI
 OL2//CXAMQSALSM8kNQ75425U068kAVxlJnTRsqhYHiVCzFScI0kYEr0hUUMZlHYUEph
 eHikdXFbs3VqFUAcPybFhZ46w9Cl1YofNi9C2PkP20PZN8J/S1AH35hVe/GqGWy6w6fM
 dlYw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzP7eqAGMpzo80c9R7eQwExlA84BpwTfVbhVDL23zclXw2NoItzzfIZUxFtz84a0g1h/gEJJ38=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/Zbn0Q4YQs171f+lh7mZ0hzyunDj0yow5zAxU4uostTfY6QkD6
 Wsf7O6woFCSjBGJJt/X9JZOaVM6HsVzKO1wxDbM4v88jT+D9EU+Ab7VoKxEMqpUNjok=
X-Gm-Gg: AYBFou0hE2RwUGxgcIMsyrQ9cjHjBWjaxFPVQzpK5LtBDx6R0GJ+Nkg1GY7HFhK333m
 cjI6vJcLwX/HsligvIdkC/ksY0ShZd+YIZjUQrRME6OkvLDnpkZFE8arNYimOhcOeQogCvpPYDz
 jetN/jjGYrwWuy3rBCLJZFS0sSQB6lHZyyZpEgX7N08Vuu110tzJ0XUzivFVUxyCvTukyUo4sMf
 QXB1T9DXpQka3WV/FreMNpWStl9qN979OmWAiIDq7eotHC4GEb/yeKnJFiY8BNG20swr4deLPAK
 9VbtfbJYRYAJMIhW3dEiArnI2obJQXXKbtQTQzCrmTvc2C8G0DaArOHjCm9HImimD28X7j9C06X
 pHiYwjNI54Mq4VcWPI/CBqMaaJlk3fhn2HbTT4KJNuSQ3gtDs3JV1yXjJQqdFAiPuDM5AbiL792
 sXC3jEHVr+Q3wVQP6/hAGvS9sw4e8Yf/ccNG3IjoqZEKpkaKOT4k/7xDM5i5V4jFR2tiUzbKsVJ
 DbVDwDNqelOGNUUd7lu4Y7pJLNlrXW98nY61wyDILm1AKUkrwqf21bvTV6KNG2xoExn+b8NBA4e
 ZipNGTx2LWRcNJH7lQpn5vgwiyKu8JwZWrU5NzOPhqst4T9A4mI4aWmYQIPVADfXy4Y39s2//XE
 JusxP1Dk=
X-Received: by 2002:a05:600c:a49:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4ac177539eamr429182315e9.14.1793875919733; 
 Thu, 05 Nov 2026 02:51:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:9899:e54b:a2f2:3695?
 ([2a01:e0a:106d:1080:9899:e54b:a2f2:3695])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b5725fb0d1sm55579185e9.8.2026.11.05.02.51.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2026 02:51:58 -0800 (PST)
Message-ID: <8641c293-19b1-4eba-951b-71fe787cae45@linaro.org>
Date: Thu, 5 Nov 2026 11:51:57 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 6/9] gpio: qcom_spmi: add pm7250b/pm8350c compatible
 strings
To: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>, trini@konsulko.com,
 ilias.apalodimas@linaro.org, casey.connolly@linaro.org,
 sumit.garg@kernel.org, lukma@nabladev.com, sjg@chromium.org,
 Michael.Srba@seznam.cz, senthilkumar.l@oss.qualcomm.com,
 manivannan.sadhasivam@oss.qualcomm.com, nathbappai@gmail.com,
 balaji.selvanathan@oss.qualcomm.com, petr.hodina@protonmail.com,
 marek.vasut+renesas@mailbox.org, u-boot-qcom@groups.io,
 u-boot@lists.u-boot-project.org
References: <20261104163408.1250410-1-sumit.dhami@oss.qualcomm.com>
 <20261104163408.1250410-7-sumit.dhami@oss.qualcomm.com>
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
In-Reply-To: <20261104163408.1250410-7-sumit.dhami@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 17:33, Sumit Singh Dhami wrote:
> From: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> 
> Add the missing compatible strings for the PM7250B and PM8350C SPMI
> PMIC GPIO controllers, needed to bind against DTS nodes that use
> these PMICs' GPIOs.
> 
> Signed-off-by: Senthilkumar <senthilkumar.l@oss.qualcomm.com>
> Signed-off-by: Sumit Singh Dhami <sumit.dhami@oss.qualcomm.com>
> ---
>   drivers/gpio/qcom_spmi_gpio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpio/qcom_spmi_gpio.c b/drivers/gpio/qcom_spmi_gpio.c
> index d06b9a4b513..feaafba7e09 100644
> --- a/drivers/gpio/qcom_spmi_gpio.c
> +++ b/drivers/gpio/qcom_spmi_gpio.c
> @@ -746,6 +746,7 @@ static const struct udevice_id qcom_spmi_pmic_gpio_ids[] = {
>   	{ .compatible = "qcom,pm6150l-gpio" },
>   	{ .compatible = "qcom,pm6350-gpio" },
>   	{ .compatible = "qcom,pm660l-gpio" },
> +	{ .compatible = "qcom,pm7250b-gpio" },
>   	{ .compatible = "qcom,pm7325-gpio" },
>   	{ .compatible = "qcom,pm7550-gpio" },
>   	{ .compatible = "qcom,pm8150l-gpio" },

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
