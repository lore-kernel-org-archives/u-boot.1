Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C119606B80E
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 17:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kHKsdkOU;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=WZBQ7Uji
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E3BE4813EC;
	Fri, 13 Nov 2026 17:30:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tclG7r4UkOKf; Fri, 13 Nov 2026 17:30:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4AD39814BC
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794591034;
	b=Cl//JCNRVU+YUK1HTFfnAT9WoOjRi2c6YbYH+d+AkKKbVlwh2aWhtpcLjh9Pjb46pjw0
	 vyP2e4eOjvD7Sz5/Uqk3u5fcR8uW3OxdawYurOPqLhL6tAzq5/0KAtgyylvNpT67+2CKm
	 jItQC/f89m9t5u9n5GBk13J5cawbMQuf/97tLmUlX/yWIrNpjIlC+/nuS0T/Z3A/yzAj7
	 271zDKrjyQpBUzJN0OvEHjrkLMKznqNeOrrZp5kHo7yeSglTc4nMbq+gi3yl4JitOkjS+
	 D6zbHMrCiMvs4MoF+QF9bDhDvbn3htYmLDyCLaGr0VG9VGiF+Lxc1FkMtGOYreI12xA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794591034;
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
	bh=u0FiGeSnAyAUgXsX289AdPuHJU8mqG5sR/Erm+H5YtM=;
	b=gVJR4xjD0TKTutvdHgsMIvLm7NXQAd7Q4R/AKWh31Ws5SZk6u9/dd4fwbkqqt9ihB9du
	 ax+bRncXQtB8cALkDGdF8xOpbjjF4Oc/MFka0ZVmLXDAwUHGKg5kTTYyYF/voLphVjwQW
	 8y6nwze6jQZDazf5Gs91OR9j3lqoiGAKv28QmmfA0i85TOErYX79R6XHNBIJ7dJ0xdFLm
	 MGrrOtzvUeLxq5in8nt+7yTY+BWDGBk3D7uxqRWFA1eTjStFQgaG7+AsWPjQYZ++UZ+ja
	 qgwEGJ6o0nBd+DO8WKV1363Vd7QlU6QJjCPrp+oJaMm18UZwgIWIdpmaC2uTU7TX7FA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794591034;
	bh=u0FiGeSnAyAUgXsX289AdPuHJU8mqG5sR/Erm+H5YtM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=kHKsdkOUVQrxYGdJh6z8/tArYdmPLSMsBfB/AJWAQXkeItTxYspJ67FZoK21SkWBT
	 F0RJy8BiS3XGfDyaCO1tLrSSqE8EM09kQueolSAg0Oh7F2IszMwFWEpsQJ2/oe6jch
	 /XW+fQKp9RJfGHOyWBpCFA3UgKNFI0jAVoaIqABPgUaoP9UDLqRFBs3GLMpEZWnPwe
	 fbUstYCvHTmE+Fu4i6Nb98zGI+YSaQr6I0ae5EYK18XM8Gj299JQ9jxU8XGMa46bT9
	 WnG8z7IwTNHPL9Ea6epxVMkJCL+vfwzGQgdHMvFtzPe4kPsMdXLOlAbh/G8QPsWY4P
	 96CDvF71+bMYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AD39814BC;
	Fri, 13 Nov 2026 17:30:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C6571A6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 38B46606C7
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pYVuI1WZ-Wxv for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 17:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 3362F6066D
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::330"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::330; helo=mail-wm1-x330.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=WZBQ7Uji
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3362F6066D
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 17:30:30 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so8864205e9.3
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 09:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794591028; x=1795195828;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:cc:to:subject:reply-to
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0FiGeSnAyAUgXsX289AdPuHJU8mqG5sR/Erm+H5YtM=;
 b=WZBQ7Uji6eXXsM5bFmMnXNbzyc/wh775BGugRVYQdMHydAzmiPL6isuTOQB6bXHQFN
 H+c0hTg+Q19AJp8onrBvYDYzr3OF/TLe6Y0b/dG3PPlk9n8D3NlBdmyGAvNAWcJuF9Kd
 hwelJzBu7/WBGAPALSi/2bmvDVt+a93qmhyFzwBAxi4NClsSHes4R+HHeRq/cuSqfuL/
 WPiTioj7hCTKJX3P+sym1PWpczit6MOH28nCLKh/lew8hJUF0jRSVNrwSIxtukkfF4KA
 vVe+gQVUpBSEkm0A6wlCf5WXKKXoxz5mNe5S6JIrzZdNmI5Gc9HPd6oCHn4UBHPWvF41
 LE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794591028; x=1795195828;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:from:references:cc:to:subject:reply-to
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=u0FiGeSnAyAUgXsX289AdPuHJU8mqG5sR/Erm+H5YtM=;
 b=yCY0Xh/abLPsQQjf5HSAUL+7H2DqJRuJKcq4QsAi20jL+0NE8zse7uUx8omdeLuXmK
 Dd6PXmsCVZ6AOGv/bzK1ncnAy41fCkt76wG/sEDegVKb4qGY5ZPyPrsF2p/Nekw3NONt
 PQQobVZrH9Bd3TJVzJuGAAQsZpBi3ANd3asV1yQ4ijTV9js0ltOyrC7hyaYDAKKLBBTG
 ZXvrhuTyiKsTAkvC/0O0dGpBhMojK07CzrTCbTYvtd6BWOG0wyKxIdrMlBqCHiBjkR9I
 xZ5rc0lfbhKDTEwZGT9vpaV2R8k2adKQo2p8ujjZILlXiMaljsIhxgUeAbCoj0It2nAr
 mgDA==
X-Forwarded-Encrypted: i=1;
 AL+hErHzf1Lsr/9ZGL9GLD4hErl5Gav/AId6PhMwyC2CoIlRXyFhVVC5TzcObsWzyAxA4xJdFc8kLTE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+C6C59VvZBINi+SZuEdzGTIr+3jY906N9GlvgS1GJDLJquL2Pi
 OBC+hFHYKOTeS5cWJ2gpl4+L1wvkkv0d0dH4Is62ZSbZwETZdV7O3dEUDlS1uyFhulw=
X-Gm-Gg: AYBFou3snFZbmctGC8hOSp1LnzbOXJ8/wKlhsTZ5LQGG4U7xzWg9CGf2feFTXaa5RWk
 JW6FBn60PgdFh6DzvizwyMBHWN6+9Neqx5QEeq1miDBHD8AXqd9uE8h/O7zYptt42BclQVUjXcI
 B6YNykQ6ldUjy4wDIscIrNGD6C7wLzeqL1vPRZQx1OFD4Xvgpb7c6jn3hgG4SZG611iiDyDEXuh
 FR9DxDenEsA5PduHLoHFO48rvW5dTgsyG8sREHlGVQDUeHZ9vnWWNvlUprFfbC27nRgot+0C/ZB
 m8RwLOtx+zdRIu3xygutjuzchkW+jp7+HAIp0y2BXEQ6nVAWUpF+iWS/9SRgO9OXQiDanmI5AHJ
 RKZmlJWim9Nz2nsBoIzSO3sn2P+VKLaIFT22fEnjXBKe2Gqt0ubePGPAjLNhVCsMRFBb/DVkxir
 V0Lxhaw6cCWQErG12wxuS0oUIoPz0g2RAAf25cEsFmp3TLj/rHz+6c5d9Q/qTShajMihKDKPzDw
 1vxgCB7u/TIPmy34Xx98gJf+tothEW15EOhpEH/MbW4wPMMDSPMo8jbmwzlHACt0Oh9DGWy5zBD
 Naf/ZITnxF9NiC9wfyTgKP3hAdpZ2lloU3XvToCVLRqTR94m6u0NfI3SY67DfBethS1zf6ARxvf
 b260GfL5lZw==
X-Received: by 2002:a05:600c:3b07:b0:4bb:5de1:e912 with SMTP id
 5b1f17b1804b1-4bb5de1f216mr28495725e9.1.1794591028257; 
 Fri, 13 Nov 2026 09:30:28 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:425d:19c0:6d18:4379?
 ([2a01:e0a:106d:1080:425d:19c0:6d18:4379])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb609cc1b2sm2206665e9.11.2026.11.13.09.30.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 09:30:27 -0800 (PST)
Message-ID: <193d6c72-7ddf-43dc-9279-d675e6b5f6a7@linaro.org>
Date: Fri, 13 Nov 2026 18:30:26 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: Remove spring board
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: Jaehoon Chung <jh80.chung@samsung.com>
References: <20261113172043.1235725-1-trini@konsulko.com>
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
In-Reply-To: <20261113172043.1235725-1-trini@konsulko.com>
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

On 11/13/26 18:20, Tom Rini wrote:
> This board no longer has an active maintainer. Furthermore, as it seems
> unlikely there are active users of this platform, remove it now instead
> of waiting.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> If someone would like to pick this up instead, that's fine.
> 
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> ---
>   arch/arm/dts/Makefile              |   1 -
>   arch/arm/dts/exynos5250-spring.dts | 702 -----------------------------
>   arch/arm/mach-exynos/Kconfig       |   8 -
>   board/samsung/smdk5250/Kconfig     |  13 -
>   board/samsung/smdk5250/MAINTAINERS |   6 -
>   configs/spring_defconfig           | 102 -----
>   include/configs/spring.h           |  13 -
>   7 files changed, 845 deletions(-)
>   delete mode 100644 arch/arm/dts/exynos5250-spring.dts
>   delete mode 100644 configs/spring_defconfig
>   delete mode 100644 include/configs/spring.h
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

