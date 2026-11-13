Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC40606B36F
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jBhWeCs2;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=TbSEn+g1
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 91D8A40D91;
	Fri, 13 Nov 2026 17:31:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mG8ouZZigLl3; Fri, 13 Nov 2026 17:31:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D120640A9E
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591090;
	b=SIE3lTW3Ox4HoHYNl6IWqezm2jOdrBYF04ZfAfZ/A374Z3U5hxMcd0/0vV/ilN6Ys3Mw
	 2F97t5byxltoGwFdHNkqIQRzXOKET6WhlUtnyVBmUVqzPF1fIfTCVXkU0o5ydXjzcnzTQ
	 GcIT1klQZmIZVm9hcLnfqC+3STBE5s8/0zMUAP3dWUGkZZQX54W0295XLpa6GeebBzl8L
	 4B9wwpTeL0DwCkstUshS+sdhNV/1G6QD5CBd2h9716Iu7y/GLj9bppTIHcCAm3peLsDSO
	 OdrS0aQqP2yHNRcwv7XjygwKubyt2UxOCaAUPhRhXi6IZh2rOOEpHZN60PdGVtriRWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591090;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:Autocrypt:Organization:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Reply-To:Errors-To;
	bh=3+apF/6CkmxRetz/9siX0+n7uwVd/kQm12pHoDLhBFw=;
	b=G7bJhRIT/YaiCiDKkPbnsCg5ZtCujSgE7Q615kJnbcHkIYUQBPan4yjLvd9Mrh0gxfv8
	 2WS7OtkktwVcTQbwSIfuiaN9SVCE5kI4Opw6bOykEYN+L8QcNSq4pysyz6jpmv2vShvN2
	 8CGG7VB0TZy16z8y5/5OpaqTrqsvmq/4TcCcoeKDPLTH06Q8ElG5hF3H4iUkbran2THzT
	 eAPvQ7QtSJof/EwH9luFErx8zRWzrPQc1yy0vmVx1N8Gq2qpUE1qv1JKUtVD99KlZ6qnp
	 iGQDth37QXMJqkp1IIyMtkYbk4Engr3g9CuhBdYJA+tpf0juLNF3+U/l2W4YL3qXWPw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591090;
	bh=3+apF/6CkmxRetz/9siX0+n7uwVd/kQm12pHoDLhBFw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=jBhWeCs25WVjhy8DuL0zmJXaByzTR6lFxLdw+W6+7tC+sFagcROYwTfWhI9sjLd5D
	 v4PGr1yErVSg3rd1I1F6R33HLi2r+b5VTUiY8OQ2T1JxZh2idZPYemo+QVGRTgztQZ
	 qXXSoqG8uUCpHsjM5g/edBy3dj8g8PFjZXvkWeoEVGiJn17l57RlTIptXuSXnInnA6
	 HEhUF3FhX+SfCMhxQ6YoYcGPNpmwjtrtEKrprdQKIW7HvXrQw4LZMb+kVrwhoF+sss
	 czQaef5x5wWLvNeJsIPaE9MSw0BxgOFhI1eI7f4Y+fU+lypTvnHB1Z5ipn+5PGPoZB
	 wR7wCjBZbEuHg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D120640A9E;
	Fri, 13 Nov 2026 17:31:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id A74DA1A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8CEE1815D6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EQFsNz6AZqOn for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:31:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9DD1B815AD
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::433"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::433; helo=mail-wr1-x433.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=TbSEn+g1
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9DD1B815AD
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:31:27 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so613850f8f.0
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:31:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794591085; x=1795195885;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:cc:to:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3+apF/6CkmxRetz/9siX0+n7uwVd/kQm12pHoDLhBFw=;
 b=TbSEn+g1Dmy83r0ah6fcsQ1M+1p4BgCn7Wcfnm+yGpzhM26MhPedLTpcF+RR9Wm4qr
 wnH4FznUt6ViaEL2R9mx5eqqkuK1mTX2cTjosc/vnza1a9S8POFiy7m4W4zBAWy60Sn6
 iM3gPVAknon70jZjoespMZlznzIFY9pLdfwkdtxj8gKN+5HD9dUK/+w4BMn/w/Cyu+HG
 5NgGDW7Nxgm8eSaJYzMJ8hAhz8Y0rOu/AFpwQg+LHKB/sopMSAhSjD4lrrrAMwkql9Hz
 KsMZmDaPOGrSZbqG8eqqRpd7NWEgFNac4WQr4xz7S9natERsfwFYJSWwv2OjjQWi6KFp
 C3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591085; x=1795195885;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:cc:to:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3+apF/6CkmxRetz/9siX0+n7uwVd/kQm12pHoDLhBFw=;
 b=nF6kC6QtOsckohT9MiymZV7MM85+znWJ8vBk++Sqv9lDe81xkvM6C+JhQOd2DJwDX0
 GTDDlFs8V/0yZWA0CmWuFOVRgomzozg2NmUw8vHF8uLCo6RP5bjFSP4tAoQ4QLgin1IU
 uufniGUyLG1GdmcSKg/lWjhXRrXiF9jQ7hcuCAzgIYyEjhVFREBxo4jMRJ/+OZ4gknls
 wLSim0EWliFkNy9Lq/HusdiHRW8n0HT9MwSmnMNKubvgcv9MsgRL1GKiOfR/A+FdOHQR
 IoEmtAvGMXxJyqufXFe0iRnywwDq/Z8ArleoTxq/5N1I8WXUSRNZoXivYV0qOysrGVmL
 OiiA==
X-Forwarded-Encrypted: i=1;
 AL+hErF8ht4Hsjpw/qV1ac7knwu4Y+JBAEwVdGNOPsYGboJcwA/OnJYoxaXhbIOMkTXbrtVfxhjtTxg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z/GWcBdeB+FWCYQP7WtB/Sew1BLnwvYQVXhtME2gCVQT2eyYMeO
 u1qDkhd1gwj5K/9RbVMSSFR8TkZW6o+oEzbVaP2e6LHXnaD6W6PRJszkOeXYBuRPItJBG7EaltZ
 0qE3zKrE=
X-Gm-Gg: AYBFou2EzTppWcNZYhTUTwlLA6+xh4GYLAS9+FOsJYvkWdVaU1DtOSWOiw/Cu3hbJrF
 86yZd80Vt2ZeHR1N2dTBxkha6qvlC64VcGrWWUyyaP1o1YiN+fQnFCQbbBpt3+mxz/SndpbBheQ
 g50Ns0jc3swA3R5CoHUC0/uYaPm3NFReO2BaK7up4Degg8OiiHtnCVjOqiHGDE9ZR3x8GyTqwGN
 XxqEhpKasx8TtIC4X6Sii6P7J42dLaMguCo/PLGjTj7kXDliCrEPODZ7q9NA1y60zjPfF1DD4F6
 wp6Mm3DwitbfyefYjZWxAr8msXRneoHvS9tTMjP/pYpDPLmBV/kdBWKfUT1BX6otk7zKVrpwh5Z
 jtasouxe+J+zH7y6TOqyE2mNzq/Yzx/ckjdXHwxc8JNzYJkD+q4bud9SEEnnB2njTZCDM7GtPLw
 UnHuGOVKYUcaKFJNCAveZg4z9XnN/7Lo2Bgfp5QtlftdbgEFs9lFkfh1v0bWcnt9DL7d0+r+90e
 1wQefhSnefHeS7pklaXQzdZPID1xjQqAHcXGrP2GaWnCXjcb2UeJ19q3UBvJfaVKbZ/CWUPCdyY
 zXTi93y5B7fR8Jfcx2WOVE9spFkQlarwKhyXHaQxway6YTJJRJV5n0HLsyyPvvzEGPohl5VxCuP
 kylJMecZROrPus8e1dkT9uV9bzjNnCw==
X-Received: by 2002:a05:6000:2582:b0:490:2d81:ccbb with SMTP id
 ffacd0b85a97d-49c7467b622mr8124282f8f.52.1794591084785; 
 Fri, 13 Nov 2026 09:31:24 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:425d:19c0:6d18:4379?
 ([2a01:e0a:106d:1080:425d:19c0:6d18:4379])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d615sm6444650f8f.56.2026.11.13.09.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:31:23 -0800 (PST)
Message-ID: <c866b80f-81ca-4192-a128-19b3f9de76ee@linaro.org>
Date: Fri, 13 Nov 2026 18:31:23 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove gurnard board
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Eugen Hristev <ehristev@kernel.org>
References: <20261113154504.1213229-1-trini@konsulko.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20261113154504.1213229-1-trini@konsulko.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 16:45, Tom Rini wrote:
> This board no longer has an active maintainer. Furthermore, it seems to
> been untouched, aside from global changes, since introduction 10 years
> ago.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> I'm not sure how popular this board was, so if someone just wants to
> pick up maintainership instead that's great.
> 
> Cc: Eugen Hristev <ehristev@kernel.org>
> ---
>   arch/arm/mach-at91/Kconfig            |    1 -
>   board/bluewater/gurnard/Kconfig       |   15 -
>   board/bluewater/gurnard/MAINTAINERS   |    6 -
>   board/bluewater/gurnard/Makefile      |    9 -
>   board/bluewater/gurnard/gurnard.c     |  426 ----
>   board/bluewater/gurnard/splash_logo.h | 2619 -------------------------
>   configs/gurnard_defconfig             |   63 -
>   include/configs/snapper9g45.h         |   65 -
>   8 files changed, 3204 deletions(-)
>   delete mode 100644 board/bluewater/gurnard/Kconfig
>   delete mode 100644 board/bluewater/gurnard/MAINTAINERS
>   delete mode 100644 board/bluewater/gurnard/Makefile
>   delete mode 100644 board/bluewater/gurnard/gurnard.c
>   delete mode 100644 board/bluewater/gurnard/splash_logo.h
>   delete mode 100644 configs/gurnard_defconfig
>   delete mode 100644 include/configs/snapper9g45.h
> 
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
