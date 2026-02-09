Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F46E7E0D5
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 19:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 240128388D;
	Mon,  9 Feb 2026 20:56:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MmXYRcH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 54AA883BF4; Mon,  9 Feb 2026 20:56:16 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11A1B8341A
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 20:56:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4359108fd24so3092924f8f.2
 for <u-boot@lists.denx.de>; Mon, 09 Feb 2026 11:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770666973; x=1771271773; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Xo0J0cAlFLN/0G2bSdb9z4JnuJabEM07H3PsACnfkk=;
 b=MmXYRcH/yKiKoCok7pINAZhfQr9ACJDYdkSxBRQ7KGYZyv3Dar1X9IbUTcYMeuFqJd
 ptV1GCl+FQXlkvfIAIwboBwUSlMDUYIQ9IL+Qj9H52qty/tzBa/2Q52pFyBTtw4DmNGW
 B/8aIFCBCeNDJt/Ce89xGkF5YR+Q/drWMcfM/cz5dsWVosdKgRvrvAhuP7XoLaybhov0
 gfEqq8QvGu2NcYCMH9mTSFJsv2deA3y7wS56JHVY0mX2QzIPVLtHlOpftE2ENe9anaB2
 dDSLoFY8DJMVEmlOrPPqvOQ8T9ceLoKKBB04GZdPUwB4gKq/JOHFggoWHzsZIfMgoMEb
 vjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770666973; x=1771271773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/Xo0J0cAlFLN/0G2bSdb9z4JnuJabEM07H3PsACnfkk=;
 b=jgwQHssRf6165BPYjWB9fX6JAa84mRaoPHlZN3QmbR23TV2gL1AZhP7EGzC8VnrsWN
 Oo9W12r8R+a43Ar4YJSXjO/oJ7Unxx07aC/TzylTFC9nswBnaJZh42axEJgwsvch8o5t
 TrbGm+WT4Ln44yxq4Hv2WYbmKXvTNWg0s2g6Q+bsk82jJScvkdkU+WLqoYU+72NQ75yv
 GKW2UknpBWy9uNWoP3zMFg8YH8YebowKp9mxUqVhiuYSbsvsU3rJkL8Hd2n2plBoiZdI
 T21dJGInbLb44TltgejjyH8ua3Ul6yQ2nHO0pIv5T4cTyQkcqRDgDhRIv4tt8m0ub1sp
 mxPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXXuHtdT7A+lCjIl0Yp2JA8qFrONsIwjBWvVcc35cCc8q6+4zEGTyIzztSG+o9OOsez7MGg9Y=@lists.denx.de
X-Gm-Message-State: AOJu0YyUnAGltjAQn2BNhSc52eWwogAln4YGzixypH5y2l8MKFUzWaNi
 WxMu4/W98iH6ZOMXHnX+5OQQ6Egimb9+Fr6VFUfPdHkRrdPbDIqbddwjsEYx5QnQ30U=
X-Gm-Gg: AZuq6aLNlwF47lTDTlIiMDXMvuxo6/OQgii1oEefWis9LDOBIfibua+1/GYqSTpHkEM
 B5v8RUN4YA7I3KcYVmh0skIcplNDsULSvSZrKqih/Vi3KCoDDx4HYgtJWq/GIKR5mEkvz/g2iGU
 3QN88HTx/KCHKUGB/Juj7tUfov8+Iu/HlgYS/lL54MqRXn8zt1ug6b9J2A895IaKAfQ9O+bVYQN
 +C3eRHYi1J2AXIoj9vH2fkqCWKow6nryREwP6PcbmxTthoMQoahG92OXWMNx2/dDNXVqPE/tbZw
 yw+KWCFZ8P1wK8hzSOqiFoMyQbBLfmhRtJkMGgnj3lw7mKW0XQXNOMzI+Ot/1niDpB5sU8V22AL
 62+nkuoelw/xfti5dYkfBvM/FXGDnMvTkeIzS5ylS6jRq6LXsZz80i5Sf4l3OE+2rJIV6K9DmMo
 kBLe2Ku3Gqw1El2Jlz3t0mErCrYtrvCjkdAvGqi4fL2kw9cn7kjw==
X-Received: by 2002:a05:6000:2886:b0:437:7168:af50 with SMTP id
 ffacd0b85a97d-4377168b4famr4396815f8f.37.1770666973420; 
 Mon, 09 Feb 2026 11:56:13 -0800 (PST)
Received: from [192.168.1.36] (p5b29ea02.dip0.t-ipconnect.de. [91.41.234.2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4362972fa4csm27343119f8f.26.2026.02.09.11.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Feb 2026 11:56:12 -0800 (PST)
Message-ID: <46d9ddb1-79f6-47ac-8083-1ae1d2a617cb@linaro.org>
Date: Mon, 9 Feb 2026 20:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] Add clk and pinctrl drivers for SM6125 SoC
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>, Bryan Brattlof <bb@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260204-sm6125-clk-pinctrl-v1-0-9cf4c556557a@gmail.com>
Content-Type: text/plain; charset=UTF-8
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 04/02/2026 17:10, Biswapriyo Nath wrote:
> This is still RFC because micro SD card does not work with u-boot but it
> works in Linux. I do not know how to troubleshoot the issue. Any pointers
> would be really helpful.

Firstly, thanks a lot for sending this series and getting this platform
running in general, and a belated congrats on your first U-Boot
contributions.

I think the sdcard issue also happens on SM6115, I don't remember if it
got resolved there or if it was root-caused. There can be issues with
different brands of sdcard, and cards that falsely advertise supporting
the wrong speeds, so I'd recommend trying cards from a few brands.

That's the best I can think of otoomh, but in any case sdcard support
not being functional yet isn't a blocker for me to pick this series up.

Kind regards,

> 
> Changes:
> - Add sm6125 clock driver.
> - Enable sm6125 clock driver in qcom_defconfig.
> - Add sm6125 pinctrl driver.
> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
> Biswapriyo Nath (3):
>       clk/qcom: Add SM6125 clock driver
>       qcom_defconfig: Enable SM6125 clock driver
>       drivers: pinctrl: Add Qualcomm SM6125 TLMM driver
> 
>  configs/qcom_defconfig                |   1 +
>  drivers/clk/qcom/Kconfig              |   8 ++
>  drivers/clk/qcom/Makefile             |   1 +
>  drivers/clk/qcom/clock-sm6125.c       | 260 ++++++++++++++++++++++++++++++++++
>  drivers/pinctrl/qcom/Kconfig          |   8 ++
>  drivers/pinctrl/qcom/Makefile         |   1 +
>  drivers/pinctrl/qcom/pinctrl-sm6125.c | 147 +++++++++++++++++++
>  7 files changed, 426 insertions(+)
> ---
> base-commit: a8d982e1f1726254ef27bbdf362f98954ee3feb7
> change-id: 20260204-sm6125-clk-pinctrl-dc673c8148e5
> 
> Best regards,

-- 
// Casey (she/her)

