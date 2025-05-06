Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675FAC3ABAC
	for <u-boot@archiver.kernel.org>; Tue,  6 May 2025 09:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DABAF80BAE;
	Tue,  6 May 2025 11:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="GjUFMb/L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDE4782161; Tue,  6 May 2025 11:49:38 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C99A3800D7
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 11:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 919A33F206
 for <u-boot@lists.denx.de>; Tue,  6 May 2025 09:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746524975;
 bh=n5Ya788iIhJy4GHx4oN8Dqm5RWaFQmthBpPw2fy7tTg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=GjUFMb/LDjMZp8v0wjY/WMolEqbwTRpRztejrHoinbSqyqKC/uuJC5Wnpe01sd33c
 L21oGvJ26iMxcM/dtdo9e2nk+CFmM/DGYPagu85b8YB+3vexGucyxUEF0l5CSKOE9J
 mQZb0aeEZi2uRAzixQhDViuAMBFQW7nCzYEsObgbCRfqW4WB80stMAnF7+5cvxcF7p
 M5og46LSrZ0bz3aLpOCEiEu7BWy0C0ww8U6C4MFkwXpZaW56Vhp2vJwLL8tt90AU1I
 laoorDaTs0q/AR8zMiY6FJ/ad4MZucTlG+Dksjjzy2qvmBL49VWzHUL3YilSKy52+L
 N5My6EwaNTPuQ==
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5f620c5f8e4so4104169a12.1
 for <u-boot@lists.denx.de>; Tue, 06 May 2025 02:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746524975; x=1747129775;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n5Ya788iIhJy4GHx4oN8Dqm5RWaFQmthBpPw2fy7tTg=;
 b=ciMJ2HEiwG/L9j570ViWDY2y83J0Eixoj6bWPrYy/CaX2o5O+wjndNKSMkAcixgYYR
 fAYRES86ACOqTpZokF2icLlhN9bod+ciJjG73lckbYIavaZab0LTAo0kvt63nL/anjRu
 mGlskB3mC+tXh9s3PLX7ikL9Jr8Z88xyWdVcW38OfZWDOKzyKr/1EvoNDh8EXgRgYwi4
 91B/C1Gc91SfJDOsnCmew0qwYdnamsV4hdq5Q/opEzmAT5SR4rYa1ot+hJf6HayG2jEg
 JlNKgu8pz7ymLx+W+CbCVhjIsJIiSTTBXDWpxPa2Kc6DD5vZFr0laqtZcoyzLtfr73Ei
 12jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyBe22eL6ueIpmqpM5kJcExtQ07Kp2pnRFHRjwqRzCu6yJ4nWjMVLtx1ae9zqe3V+/lkN1Wgg=@lists.denx.de
X-Gm-Message-State: AOJu0YwTXqP8iZSVqiwwTx45cujZSbSa2Ai4rRxeNBWM2v0f3wKbhW89
 HtCCPos6ALJkggbfQdajTK6We6YJLZ5v47BIMEBywhSYgq/SoC07MVPKvnoqrgAUMWihwNMjKhK
 SCuy1fxpuIG2ISRCdWRtgZT34RX1FUl7iya2vpT9rEJEHOoMm30UwSipjg8wEa8DX9DD7wWfrQB
 8=
X-Gm-Gg: ASbGncs+URhnL8KJMsG+/NinGF3R6qcd/SmStzlE6VG0lHWaojMpozWK3aIGlJzy9LO
 r1KISsxFYofIG5UkoOxiMbN5tC/3rz8clrNBg9lxtbVeO2XdBDXF4F4xhCQ+rtZdS3RTNjufGF4
 eR2aAg9kJqnu40aZwSljndoi2x/t3IEKPUB61NGHpfBphmZHw4MFFlfDSn2xx3sAZUasBLx68Pu
 YqtkaXeVDHJXAZXl2iyA16ra9JXs5wtF1k+EQB9rtbFAJtptirr+8xATdZjjeGWmnNc1Wzky4lb
 OKE8ExZUPkk1fQOhRHqFZDYNBPoNBrpD
X-Received: by 2002:a05:6402:5021:b0:5f3:26bb:8858 with SMTP id
 4fb4d7f45d1cf-5fab05e092dmr7785481a12.34.1746524975183; 
 Tue, 06 May 2025 02:49:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLt5OpQQZ2MpvhydvjWSKtMWZKdwca0lGN2tpWLvSBRTKFKvM0dnkL+v72zy3pB/qT7ZH+BQ==
X-Received: by 2002:a05:6402:5021:b0:5f3:26bb:8858 with SMTP id
 4fb4d7f45d1cf-5fab05e092dmr7785468a12.34.1746524974836; 
 Tue, 06 May 2025 02:49:34 -0700 (PDT)
Received: from [172.20.6.239] ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa777c8afbsm7507063a12.28.2025.05.06.02.49.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 02:49:33 -0700 (PDT)
Message-ID: <7c05f66b-1047-400a-816f-db0de0951def@canonical.com>
Date: Tue, 6 May 2025 11:49:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: set the width of the physical address/size data
 type based on arch
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20250506092401.646595-1-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250506092401.646595-1-sughosh.ganu@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 5/6/25 11:24, Sughosh Ganu wrote:
> U-Boot has support for both the 32-bit and 64-bit RiscV platforms. Set
> the width of the phys_{addr,size}_t data types based on the register
> size of the architecture.
> 
> Currently, even the 32-bit RiscV platforms have a 64-bit
> phys_{addr,size}_t data types. This causes issues on the 32-bit
> platforms, where the upper 32-bits of the variables of these types
> can have junk data, and that can cause all kinds of side-effects.

How could it be that the upper 32-bit have junk data?

When we convert from a shorter variable the compiler should fill the 
upper bits with zero.

> 
> This was discovered on the qemu Riscv 32-bit platform  when the return
> value of an LMB API was checked, and some LMB allocation that ought
> not to have failed, was failing. The upper 32-bits of the address
> variable contained garbage, resulting in failures.
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> 
> Note:
> Although the LMB API cleanup series depends on this patch, I am
> sending it separately so that it gets noticed by the RiscV
> maintainers. Sometimes a patch may not get the required attention when
> sent as part of another seemingly unrelated series.
> 
> 
>   arch/riscv/include/asm/types.h | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/types.h b/arch/riscv/include/asm/types.h
> index 49f7a5d6b3a..45d806c83eb 100644
> --- a/arch/riscv/include/asm/types.h
> +++ b/arch/riscv/include/asm/types.h
> @@ -35,8 +35,13 @@ typedef u64 dma_addr_t;
>   typedef u32 dma_addr_t;
>   #endif
>   
> -typedef unsigned long long phys_addr_t;
> -typedef unsigned long long phys_size_t;
> +#ifdef CONFIG_PHYS_64BIT
> +typedef u64 phys_addr_t;
> +typedef u64 phys_size_t;
> +#else
> +typedef u32 phys_addr_t;
> +typedef u32 phys_size_t;

This matches what has been done for ARM.

86c915628d58 ("riscv: Change phys_addr_t and phys_size_t to 64-bit") 
changed the definition to 64bit phys addr_t to support the 34bit 
physical addresses (similar to LPAE on arm32).

I don't think that we need 34bit support currently. But I would prefer 
if we could find the root cause why the upper 32bit gets messed up as 
this might point to a generic problem.

Best regards

Heinrich

> +#endif
>   
>   #endif /* __KERNEL__ */
>   

