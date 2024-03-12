Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0D5C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:54:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F12E887EA3;
	Tue, 12 Mar 2024 19:54:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="v3Pfi8O5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B1E187F16; Tue, 12 Mar 2024 16:54:58 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B414F87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1dc49b00bdbso33670045ad.3
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710258894; x=1710863694; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fbsb/uXeLZM7AoCFbFzRO0IQlKQHmex9FAoY/KSTs6U=;
 b=v3Pfi8O5SNvAoqGKE+xzJ+FRMt3/l+vSIjPHzsM5P1j4q0cq8aaa7hxAXLrkblvrBw
 Xm+Xi1hJbOxEJrCCYbQzt89NI+s5vrSS+pR03WXPixNUL4RCN7a+MdWTqvVhKUSLy0a9
 H6lz8dY9MFq2x86XGBUNJomiIe4PFOhF3ctin8g2m95y8ngwEIR2h/4EUxGdEYcdAd2d
 hMMRkzoedT9zZr0Gmi4/66nmQDNWLmItuMkP6bo/dHmTAP9Zlpl3Mip09VTOvVrd0AKX
 cJ3Kn6Z1pwvte2rIb3a/ZvOnStc/bnzgpUs2pLSCnnqkfMKvvbBKU5az3VR2j71JEEyi
 0D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710258894; x=1710863694;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fbsb/uXeLZM7AoCFbFzRO0IQlKQHmex9FAoY/KSTs6U=;
 b=QmJy31WNVRN2FT41GVoY8Brkk8VGUG8ZFVXZHs9Cudv9QmyiAtZX9OOXkNQUuAanNG
 f9igXaCkpZiPvxQKWiDC1bkcxpRQzKdYltJ0FkjxgJRmSkIpchD62vI57UqeVD6z7guU
 ZrCfHeene0y/WYUZkHOH61bvSnpfYuQA1lrhV27lZun0P1Hjl+ugmgtt5tSFpbTHmLMy
 eST2zdzT3YBBretvCEH7xhFtRVqdKNaoAEDbW+ifpaG2VWWipNU5+5u0W8cd6tI1laBg
 4+kCAwXKBVDrU6pg1sszP9uG8kPVi7kVA7fG90R4NHoSwaImP8v5Ch3+M1OlYvg7Yzy9
 D1VA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvEfN/DgBbCeIB/M6CctBTuQ1D+VyJfsmYstsaDxtLNQA5/6p4R44kbTtk7mqHe3xzUJ/C/k3J4pZ1VzGM/Pd577bAxg==
X-Gm-Message-State: AOJu0Yw9Ds4gh+loJeuBoNqVr2MGA0bPYJWPlrG7yg8kXkQAbYRYkqsa
 lTIm0BFfGGPayJOnxdazEdHEm2WxQgzrUs6Ra1lKZrkgJ0g/vm+eZvrjetA+IEE=
X-Google-Smtp-Source: AGHT+IFfW68g+2sVzUChu/rlBGkiAUbseJer8SamgvWjLF4DDDuZl4tWWqHNkwT/JbOX6GSmMsslTw==
X-Received: by 2002:a17:902:d2c5:b0:1dd:9984:29d3 with SMTP id
 n5-20020a170902d2c500b001dd998429d3mr7780411plc.32.1710258893841; 
 Tue, 12 Mar 2024 08:54:53 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 u11-20020a170903124b00b001d8f81ecea1sm6909100plh.172.2024.03.12.08.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:54:53 -0700 (PDT)
Message-ID: <583e4ab1-e716-46ff-92a6-270ede29d6ba@linaro.org>
Date: Tue, 12 Mar 2024 05:54:48 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7 v2] arm: fix __efi_runtime_rel_start/end definitions
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
 <20240312140832.1968215-4-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-4-ilias.apalodimas@linaro.org>
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
> __efi_runtime_rel_start/end are defined as c variables for arm7 only in
> order to force the compiler emit relative references. However, defining
> those within a section definition will do the same thing since [0].
> On top of that the v8 linker scripts define it as a symbol.
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols within
> the correct section.
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> 
> Suggested-by: Sam Edwards<CFSworks@gmail.com>
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Reviewed-by: Sam Edwards<CFSworks@gmail.com>
> Tested-by: Sam Edwards<CFSworks@gmail.com>  # Binary output identical
> ---
>   arch/arm/cpu/armv8/u-boot.lds  |  4 +---
>   arch/arm/cpu/u-boot.lds        | 16 +++-------------
>   arch/arm/lib/sections.c        |  2 --
>   arch/arm/mach-zynq/u-boot.lds  | 16 +++-------------
>   include/asm-generic/sections.h |  2 ++
>   lib/efi_loader/efi_runtime.c   |  1 +
>   6 files changed, 10 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
