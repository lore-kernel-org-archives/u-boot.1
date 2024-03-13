Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1661C54791
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 20:22:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30CD587F01;
	Wed, 13 Mar 2024 21:22:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZBLeituF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D32387EDC; Wed, 13 Mar 2024 21:22:02 +0100 (CET)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3B1987ED7
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 21:21:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.henderson@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-6e4d48a5823so248774b3a.1
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 13:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710361317; x=1710966117; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X3BrEQC/J6I4Vn9G/UO2nL+IOD2dRgMaanXb6y/sKC0=;
 b=ZBLeituFDTlAYgBIg1dKPwH1G3XfIBiyilgTootwb5Pd1e8ElsBEtgju7XY/kU76mz
 0T1/l5H/eEZGmZp+DTdOvbtqHRnp73zHFEMr9QOZdO3PzUiyJqiKitaa21288zkZ4w/W
 0wslZn2zdtTFECt7PMMjL3PnwtAZn9JJfVoH0w+5z2aI/AS8dVxwVurcydfx5gTKYNDS
 q8NZgw82JMtbOP+44dLZtxaPBQ+HlhIKrChzH9eXMYjXUfqvRfkBrcrKVCy4aW9ptfmN
 ochpUvmnMTMyP1HnsUbQQmvFoh3Nr3ErjipTJh+qvdbxCyCzNVwPVvyJpi8hpL0SSdLq
 uQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710361317; x=1710966117;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X3BrEQC/J6I4Vn9G/UO2nL+IOD2dRgMaanXb6y/sKC0=;
 b=HjApEQ42+USrfiqADRflziANukB8Rrqr9PW8Z/3GlVhgJRDImww0q66FGl0dr12i2p
 JAtKLyz9SKgPyndUgiUY8mv3QEgDFtp7XBdWgA5hj5jpPtoobuzrKMacrSP/DHr/y65L
 sX6rsrkwVJxRe2biy0pAPXtnHljbOIvLMg1zwo2EeLGl8ct+QC3Za3wg8q7k4m1JFCuU
 F8iEWbYEoF/jm3/jRNtwZrbuXuVe7QseCqJfpeb2Qx4Epx/j2we2DCq4jAWuBUhjfUTf
 qq/IzpCR4dWm0u6Zq+e3xKygmOwAwqPFskhk8UerteQ++GKmdBhU4b53Ss9C7ejopZjh
 1txQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNvZIVk0HnXIpO0lQxgqy+xSfz2U3SgTcBrczKyTo20xDrCHxkQTA9uKYSbx8XeUuV7ZAYdLTcGPaKThDxGtGvCwjJRQ==
X-Gm-Message-State: AOJu0YwClMVd39l6nhi5he+v0Uy81W7rsjkWiYwWKukruthPV7J5WC7g
 jiQpi3IgiD23o/Mqh07+ZsmC+S1HI6MDZs4wp6Okc8j6sGI8/7O/tHQHV0IEGI0=
X-Google-Smtp-Source: AGHT+IHXJ6L77nDYw9sx26Ca2zQKb2wKCvK8iLEfTj3/0V9U7LOXc3YFddim+r3kcMPsdA6aPTg4LA==
X-Received: by 2002:a05:6a20:daaa:b0:1a1:6ab9:9139 with SMTP id
 iy42-20020a056a20daaa00b001a16ab99139mr24776pzb.11.1710361317358; 
 Wed, 13 Mar 2024 13:21:57 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 le3-20020a056a004fc300b006e6c088d5afsm11064pfb.177.2024.03.13.13.21.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Mar 2024 13:21:56 -0700 (PDT)
Message-ID: <c1b5b9a6-b59e-4ce7-b0a6-07c92b606828@linaro.org>
Date: Wed, 13 Mar 2024 10:21:51 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] arm: remove redundant section alignments
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
References: <20240313162324.2117909-1-ilias.apalodimas@linaro.org>
 <20240313162324.2117909-8-ilias.apalodimas@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240313162324.2117909-8-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Wed, 13 Mar 2024 21:22:17 +0100
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

On 3/13/24 06:23, Ilias Apalodimas wrote:
> Previous patches cleaning up linker symbols, also merged any explicit
> . = ALIGN(x); into section definitions -- e.g
> .bss ALIGN(x) : instead of
> 
> . = ALIGN(x);
> . bss : {...}
> 
> However, if the output address is not specified then one will be chosen
> for the section. This address will be adjusted to fit the alignment
> requirement of the output section following the strictest alignment of
> any input section contained within the output section. So let's get rid
> of the redundant ALIGN directives when they are not needed.
> 
> While at add comments for the alignment of __bss_start/end since our
> C runtime setup assembly assumes that __bss_start - __bss_end will be
> a multiple of 4/8 for armv7 and armv8 respectively.
> 
> It's worth noting that the alignment is preserved on .rel.dyn for
> mach-zynq which was explicitly aligning that section on an 8b
> boundary instead of 4b one.
> 
> Signed-off-by: Ilias Apalodimas<ilias.apalodimas@linaro.org>
> ---
>   arch/arm/cpu/armv8/u-boot.lds | 9 ++++++---
>   arch/arm/cpu/u-boot.lds       | 8 ++++++--
>   arch/arm/mach-zynq/u-boot.lds | 4 ++--
>   3 files changed, 14 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
