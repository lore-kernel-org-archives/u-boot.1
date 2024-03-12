Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AEB7C54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 18:55:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3CE87F50;
	Tue, 12 Mar 2024 19:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BO+zSaNV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7367587F3F; Tue, 12 Mar 2024 16:58:46 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AF1E87C86
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 16:58:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1dd84ecfc47so19581455ad.1
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710259122; x=1710863922; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DikyUzVgcoyxP7brSGz7nvuUgsuHvownLgSN6Ra0XoU=;
 b=BO+zSaNVjzEB28BuKycitszt7qt04+Y5aDlr2IQpPuzlgjgbEqLiUJTO06wZEdr4FQ
 y3jHKkS6WZrU5CBfPXSYF19haZRyD3sWfVcg0GeWPJ93S71E3F0P3vHBPW8Ubs7k61pV
 d9vd4FVnu95P1XvzlWiFzp9sWA6Jp+etikIQsWW9yEnYs971IguzjFM3V8OnQwf6zyvF
 9kNBmiBtXwqwXJyDQyM5WiK7j64LnT3U6NtuvRSPk1JvW6vqTtPzUByt7WOp/Vd1vWdn
 9fG81h39oAp9EDGxAj6gVoBnWtcSE6rUoSQZhjLcg9o4v87YRoFBnGDc9ID5/HKplraF
 yDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710259122; x=1710863922;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DikyUzVgcoyxP7brSGz7nvuUgsuHvownLgSN6Ra0XoU=;
 b=EoAQVfg1NW9cKFIwf7BhtKaQZSRB7Pj7Yw3nlDK8m15jEuHzSbEOnaoYd7tNairIQv
 Fk3D3EfTrzCs+UAbo/ylnjBDD98DPJkgPEm8Bcqr5zUi0hU9r2+WPxWbL0qtatLsO6nu
 7IErTcPrrn3QuaTtAUB3yvorZLHc7uDzXCdxRx8VFa6BNS1yLkvfi7Y2BLcAyl+U+b2l
 OGsMDYrTUmIN05idGslMAcUi6CMqtWYvRorzTdYe7sc6EQW6OBpWUuHYYnx3o5wkzIqU
 +nECaTOQXa2LB/fuRVNm/OS1WTwQ9E7/idbHA6MuChpVp0Fh1mJ71WSAahbkfYuryzRn
 rZaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVJNjPAqkZGaDOF51d+XKBKcu2/jTPg7vA/U7a+7R8rCisnimtrloCR5TUcWsblo3P03Rux5+teQTJ8+Qswz73z2PCcGQ==
X-Gm-Message-State: AOJu0YyuCdEitnqck0gU0LaAfXjkrjdwfcviZZCjnNQPO6NeERP5LNNw
 Fp6iiBnVvDHrU8ZG+uwuXYf5CJ/b5QoeiHMW476FWTWtgkIeJLlaCP6NbQahiFc=
X-Google-Smtp-Source: AGHT+IFpQSJsbsc8e8NGnpybt99mlddblMRIayaBMbp2uiRLqNszDPq4llEgSltUq3z/Qb+CoCBb5A==
X-Received: by 2002:a17:90a:fb57:b0:29b:af8d:3264 with SMTP id
 iq23-20020a17090afb5700b0029baf8d3264mr2152529pjb.37.1710259122655; 
 Tue, 12 Mar 2024 08:58:42 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 w7-20020a17090aaf8700b0029c09574b43sm3490422pjq.20.2024.03.12.08.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 08:58:42 -0700 (PDT)
Message-ID: <76da298f-aaa7-445c-a05e-9d895fcac057@linaro.org>
Date: Tue, 12 Mar 2024 05:58:38 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7 v2] arm: fix __efi_runtime_start/end definitions
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
 <20240312140832.1968215-6-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312140832.1968215-6-ilias.apalodimas@linaro.org>
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
> __efi_runtime_start/end are defined as c variables for arm7 only in
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
>   arch/arm/cpu/u-boot.lds        | 12 +++---------
>   arch/arm/lib/sections.c        |  2 --
>   arch/arm/mach-zynq/u-boot.lds  | 12 +++---------
>   include/asm-generic/sections.h |  1 +
>   4 files changed, 7 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
