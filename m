Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9C3C54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:55:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49C2187F63;
	Tue, 12 Mar 2024 19:54:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kgHs/HBi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0234A87F30; Tue, 12 Mar 2024 17:08:55 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8823E87DE8
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 17:08:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-29a2545a1e7so3753449a91.2
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710259731; x=1710864531; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jSgvbwn67C2e6PrGfD0bnyRNbSmkCLpgqLBXLVkFY3M=;
 b=kgHs/HBifSZPBA7eXOxS8D+HmoYxlxUny3hth75ngV5sxNbPCv3oDsQ0eKIwURVrxg
 OVZ/9htCrydjm93wMZefZ8dRPx2df6GykwymCflbl2d14I76Mdr5ZbPBh/ubkhYDKnZD
 xDrkYQ3VyRLdbkOLs7Cc+tJaUi74L5iY5+RHuuFXgdOFYdsKSLVM3iqLqOcL3yGc7Xxa
 BXjURkDyWg24a/Ij/Hm6Ckje4K5Cl3QJ4nyBKOyNmZlmj525THz8/xnWBmhHfHU/VDeu
 ihj7fKqWzL2VDQJyVa+P70gFN5B5YwXGEGGWui6h/YlsvZk1ZcXUN3ER5lTkcl8YmTG+
 tAPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710259731; x=1710864531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jSgvbwn67C2e6PrGfD0bnyRNbSmkCLpgqLBXLVkFY3M=;
 b=NJEbGW19dfKVXd6ViCPU/KiQGs/Cgb+0eIV9NZNdEQT+QKPXksxzkmIgQ5RKNNABtC
 YBKZa8cMidqsS82zvYUbfOxfNBsXLTsK/K/e3cenXT9vhkY5gGgkP3y2IFmvPUr+uNGe
 vhneDPnNHJ7FKxBLQ1IJ9eaNZM2mZegfayVqmg/prUogExpbh/zElu8+6OkVIysLR+Dg
 BZ8G/UFLUFrhDSUx/Tqf/WhAH4/2pwGWLFscI1RxgUr/ZtzAinUrsSo+KwYvFxQz6kYa
 ZqhKmztVuz3wZct+3xwA3Ka+az7WRgNWnpBj/IBbuPxyzNA2RWaZXALGHdPWxRBiao1u
 FYSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy4Ehb3eKnC8vkYu1VF4cBMPiE6f6pT6xyF+Oose1i4zyNWgMVJ/tkOzHgOikNH1V33U1qDtSouMX+Sf+l+L8sW+o+sQ==
X-Gm-Message-State: AOJu0YyKA0GAnO4i0nfcYGDr3MXBIOHI6heUzUwrq9K9iBgAiV52aVwb
 Ik3Hulve0iUGs3B0SKieyCAw63zgB5i4dDqDPl2O/uQVlYPX4kE/VMxvukFfwgs=
X-Google-Smtp-Source: AGHT+IEGN8WD9vptUReUnEF2nv+/Wals9KwXmI+gsRMau88fcN9arl8OIDJF0kjSlowB0qbxfDIiew==
X-Received: by 2002:a17:90a:6c01:b0:29b:9f1e:ab2d with SMTP id
 x1-20020a17090a6c0100b0029b9f1eab2dmr872230pjj.36.1710259730739; 
 Tue, 12 Mar 2024 09:08:50 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 l20-20020a17090aec1400b0029c3bac0aa8sm1354362pjy.4.2024.03.12.09.08.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 09:08:50 -0700 (PDT)
Message-ID: <dc45d41b-f167-40be-b24d-6eee50c6ff31@linaro.org>
Date: Tue, 12 Mar 2024 06:08:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7 v2] arm: move image_copy_start/end to linker symbols
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
 <20240312140832.1968215-7-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-7-ilias.apalodimas@linaro.org>
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
> image_copy_start/end are defined as c variables in order to force the compiler
> emit relative references. However, defining those within a section definition
> will do the same thing since [0].
> 
> So let's remove the special sections from the linker scripts, the
> variable definitions from sections.c and define them as a symbols within
> a section.
> 
> [0] binutils commit 6b3b0ab89663 ("Make linker assigned symbol dynamic only for shared object")
> 
> Suggested-by: Sam Edwards<CFSworks@gmail.com>
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> Tested-by: Sam Edwards<CFSworks@gmail.com>  # Binary output identical
> ---
>   arch/arm/cpu/armv8/u-boot-spl.lds           | 7 ++-----
>   arch/arm/cpu/armv8/u-boot.lds               | 9 ++-------
>   arch/arm/cpu/u-boot-spl.lds                 | 2 +-
>   arch/arm/cpu/u-boot.lds                     | 9 ++-------
>   arch/arm/lib/sections.c                     | 2 --
>   arch/arm/mach-aspeed/ast2600/u-boot-spl.lds | 2 +-
>   arch/arm/mach-rockchip/u-boot-tpl-v8.lds    | 7 ++-----
>   arch/arm/mach-zynq/u-boot-spl.lds           | 2 +-
>   arch/arm/mach-zynq/u-boot.lds               | 8 ++------
>   9 files changed, 13 insertions(+), 35 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
