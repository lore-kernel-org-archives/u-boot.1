Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7231C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:54:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6908787F40;
	Tue, 12 Mar 2024 19:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PTIz3Q4H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2640087F3F; Tue, 12 Mar 2024 16:57:24 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EDE387C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:57:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e6aaa2f02cso530751b3a.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710259039; x=1710863839; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lExkqVGbsoyGRTI8eYDx01otmCygmTmzWiak5f9EgWk=;
 b=PTIz3Q4Hg3kkBOyDJHzlWaXH+XSjtoTHHh168Mcp3M8yqvob6DfV8aEHt+wwJ/cIXn
 Ca+TLcva1/Hf8aavNvKFxwkBC1pvlWuVh+DDK1x+fFsffvjnIYP/4PYSWkX0rnK3i14a
 mnh70nHVrAZ5TvDfWCjV85j4IMZQHLPUQD8nwgiMhaBf+/X/B4+v6WlD5dfIA5OO0y0k
 IwxoQ8K0ozLmhtntlmrqwadvQwM1Va4g/64swIWRe+x8UhPEX0KTKFpVYznRROXc49oB
 /iqrwoCaB7umtCxNV73If9PvRsITFfNAmeXnUNB7i5WdGHz+vBQmDbKep/uwZvwhj21z
 170g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710259039; x=1710863839;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lExkqVGbsoyGRTI8eYDx01otmCygmTmzWiak5f9EgWk=;
 b=ZBVLSWGxI9kMgJDpZCjnnHDjR7BxNR43cdG2u/khQzQxDTGvsCTEjXFHohqSYPr6RN
 y54Uj3nWPOvOWnkoEuibN15aQb+eEQHF6z9c1yfV06DnxmBp+52tHT0jw6PEEW7bDjUL
 d6UllGuyXv4saHx88X4MQ0d2aj2/2fX4CP3eH6EGTcoEnAmPBd6Hga9CUTvKZHWD85XR
 Ifhm3PYgF9y3XN0sWxpKiF7axfnfodu0VCkMoYsIA9cm0pUfLSMEvOaNNsLXpfxBF5uw
 oNwOyWDZKpIiZXdhbPxh4q8cumDdyPL25IkSVDXXomaPiLisH7eXc2Zx9dDfmgQ6REC3
 1/yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzY5TshnLgM5yaRox1QQqpSDC3UWm0VxyW6MkIznPM0UBgy2g2W0kNqsrXv+BSsqtFQ4jmaV0AOjdp/OFgLD7TyC/WTw==
X-Gm-Message-State: AOJu0Yw8ZNKgLqYD6VGvYiSnVnnUfbi8YOekDSkW1f9BSY8ux0wHzAh9
 IRAuLVsnL0cdYoL8p2Frx/7x9V5OUYMj/7Yw49WwDrd3EzJsBqX7cdHKmYChgFo=
X-Google-Smtp-Source: AGHT+IHlNmvtGG9Px2UTrwQEwdUuWZo09V4VWnHRFTi7lIeWq3zddvTWtEmFkWtAfesDA2/cT3wc0A==
X-Received: by 2002:a05:6a20:9591:b0:1a0:cd54:6d9f with SMTP id
 iu17-20020a056a20959100b001a0cd546d9fmr9188108pzb.23.1710259039426; 
 Tue, 12 Mar 2024 08:57:19 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w7-20020a17090aaf8700b0029c09574b43sm3490422pjq.20.2024.03.12.08.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:57:18 -0700 (PDT)
Message-ID: <6e4a8968-5d6f-481d-8c4f-5c0211df0ed2@linaro.org>
Date: Tue, 12 Mar 2024 05:57:13 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7 v2] arm: clean up v7 and v8 linker scripts for
 __rel_dyn_start/end
Content-Language: en-US
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de,
 trini@konsulko.com, cfsworks@gmail.com
Cc: caleb.connolly@linaro.org, sumit.garg@linaro.org,
 Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Michal Simek <michal.simek@amd.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>, Bin Meng <bmeng@tinylab.org>
References: <20240312140832.1968215-1-ilias.apalodimas@linaro.org>
 <20240312140832.1968215-5-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-5-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Tue, 12 Mar 2024 19:54:32 +0100
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

On 3/12/24 04:08, Ilias Apalodimas wrote:
> commit 47bd65ef057f ("arm: make __rel_dyn_{start, end} compiler-generated")
> were moving the __rel_dyn_start/end on c generated variables that were
> injected in their own sections. The reason was that we needed relative
> relocations for position independent code and linker bugs back then
> prevented us from doing so [0].
> 
> However, the linker documentation pages states that symbols that are
> defined within a section definition will create a relocatable
> type with the value being a fixed offset from the base of a section [1].
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> [1]https://sourceware.org/binutils/docs/ld/Expression-Section.html
> 
> Suggested-by: Sam Edwards<CFSworks@gmail.com>
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Reviewed-by: Sam Edwards<CFSworks@gmail.com>
> Tested-by: Sam Edwards<CFSworks@gmail.com>  # Binary output identical
> ---
>   arch/arm/cpu/armv8/u-boot.lds | 16 +++-------------
>   arch/arm/cpu/u-boot.lds       | 14 +++-----------
>   arch/arm/lib/sections.c       |  2 --
>   arch/arm/mach-zynq/u-boot.lds | 14 +++-----------
>   4 files changed, 9 insertions(+), 37 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
