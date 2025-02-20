Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3FCC021B3
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 21:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD8BB80FE2;
	Thu, 20 Feb 2025 22:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="cXVme55q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58C580F56; Thu, 20 Feb 2025 19:33:33 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DEA880077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 19:33:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-219f8263ae0so28217645ad.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740076409; x=1740681209; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/3tbiDco+PtjagQS7qRZYhkj3SuxDM/MLMxU+bGgFt4=;
 b=cXVme55q9iomL/CyNFDajtzBoiGPqaEtkKn9oNXCz3CNl7JmUeMYLnUuwe9/tnE5Zi
 HccS2CscxoIjFdUTjvJZeCsFU6NwJZnEs9wlHpZdEPQsg/0pUVUF+21L3pHS9287cIxe
 AkPT1e51dXzODDASqpTLEzWI/tbh18G15yxTtoib560Y5s9AIuOgnaPkl8Z7D40x75R0
 boZirbN1+xhO556pMnULwzsxY6JtzYvfgSKr7k3UpsHeZnvtPf+vQIcLpsq8Pppt+mhw
 +YGEyOOv+moGH73VPhCykT4QIyOYSY3PfSjFM0g1P/IqXGGm5Qk2w3KPWN81UgliahWP
 OmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740076409; x=1740681209;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/3tbiDco+PtjagQS7qRZYhkj3SuxDM/MLMxU+bGgFt4=;
 b=HwDPJU/fvPdlDpHzBLo621ITWsc8jPata6NJAxghn2kFlUginGcDJJat6Gsc0OpLQm
 DCcmOTSYBRtrfi/Ff4bOkIlJaqRHqo2DW2AUaA7fi9YGr/nzxyOsFlxb+9y7VzFvnyAN
 VDt7cu2MXs4fBx5zNgvonYgx4cBldOWyMcVcHuNLyRdd3Ou80vk8DS47R51/riVjqQAe
 88BZPEQeDabZxhW6Y20x1FxsrYY/4qq/nn1DyG0VdKc4+qgjfQI+HDhKeKom7kth/8Cp
 FKh7s5C61Ve9wzb/WDKF+yq4ZhX88dcTxQ2sunUYuDnjJkVBpklOienJVsBfV1uDdqIk
 9gug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUJryPKceE7uMfsBLq/obdEnFagTfodm3fFIMr2uK7qEBLvj8AZKgJfdsWRcR3KNmuKwwdIuo=@lists.denx.de
X-Gm-Message-State: AOJu0YzBEVi3b0NA2cymnzX856fLsREizr4828kAdJLT2ya6i3TMisjm
 DSGmZxFUSLvbGZR9C9Mwa3MpGuVJfwmkpoPVTX1IOE/b5Mqs/pI25bsNGArOm18=
X-Gm-Gg: ASbGncsbhIawy/yVlQJqqI18AURIj63S28mdP2RQ8Uae37ggKHNucgutLrXhuE5VGOg
 WyK6S4ige1et+iM/Y6MzFQPiW9ZeohCtXS0rKXHuELFyhm8h+DAKgt29IOrZplJGeHvKHXh+Imf
 uhhET6tC9a78AI2SHVbbCHuGYcrCvWRX9INq46wHnWUtz1cF+hLZvETcX9nFgNYszo1y54AvF/Z
 ULaBrRuLw5xbGj4RLwYvtsEWb45uWBIer81W+FQdi3PaHov2z6em3LPac381NMC9uGJw4E8ZcHU
 lOJRg/fFB1JUfRUzS1C+tbRVop8Rec7Twx8mzLUBY38K+dehSZVrkEs=
X-Google-Smtp-Source: AGHT+IGocqObetDg6wtFatsdm3mgvQhhGvw0a1c9UBKoNFnM11HlCyNek/gMUE8fAGYUXgh4hlQEjg==
X-Received: by 2002:a17:902:7487:b0:21f:752f:f2b1 with SMTP id
 d9443c01a7336-2219ff5de16mr2133125ad.30.1740076409512; 
 Thu, 20 Feb 2025 10:33:29 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73269fa358dsm10458036b3a.91.2025.02.20.10.33.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 10:33:28 -0800 (PST)
Message-ID: <12f8c492-0b3b-4dc9-80e7-5fabdb6db398@linaro.org>
Date: Thu, 20 Feb 2025 10:33:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: Enable RW, RX and RO mappings for the
 relocated binary
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 mark.kettenis@xs4all.nl
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Tom Rini
 <trini@konsulko.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Peng Fan <peng.fan@nxp.com>,
 Sam Edwards <CFSworks@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Alex Shumsky <alexthreed@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Joshua Watt <jpewhacker@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250220135506.151894-1-ilias.apalodimas@linaro.org>
 <20250220135506.151894-7-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250220135506.151894-7-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 20 Feb 2025 22:02:17 +0100
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

On 2/20/25 05:54, Ilias Apalodimas wrote:
> Now that we have everything in place switch the page permissions for
> .rodata, .text and .data just after we relocate everything in top of the
> RAM.
> 
> Unfortunately we can't enable this by default, since we have examples of
> U-Boot crashing due to invalid access. This usually happens because code
> defines const variables that it later writes. So hide it behind a Kconfig
> option until we sort it out.
> 
> It's worth noting that EFI runtime services are not covered by this
> patch on purpose. Since the OS can call SetVirtualAddressMap which can
> relocate runtime services, we need to set them to RX initially but remap
> them as RWX right before ExitBootServices.
> 
> Link:https://lore.kernel.org/u-boot/20250129-rockchip-pinctrl-const-v1-0-450ccdadfa7e@cherry.de/
> Link:https://lore.kernel.org/u-boot/20250130133646.2177194-1-andre.przywara@arm.com/
> Reviewed-by: Jerome Forissier<jerome.forissier@linaro.org>
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> ---
>   common/Kconfig   | 13 +++++++++++++
>   common/board_r.c | 20 ++++++++++++++++++++
>   2 files changed, 33 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
