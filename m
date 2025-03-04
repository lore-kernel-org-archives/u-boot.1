Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A578C021B8
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 09:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A92E581273;
	Tue,  4 Mar 2025 10:11:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XT5AadGR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53CFA8129B; Tue,  4 Mar 2025 10:11:34 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3AE7810ED
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 10:11:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-390dd3403fdso4596083f8f.0
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 01:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741079455; x=1741684255; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c8Wmmn8M/OgiOH6NKd9CKSjOb/3JOuUELt3nUAlLwmA=;
 b=XT5AadGRYmuSNlK3O/bZl6Db+5ypuTXpbYAYyHNmm9zVbjr/3XAD2/uLDiDXPTFHpS
 bIbxX6H6siFlC/s0wbV2y0mYSc79CATny4xmHpGjsAIsiztZUOHBnmWRBeuyyhbDYVC0
 k+vcdaEEaYmigT/HaOEFvw8stEwUMAqfkzkUPCwrcm4usK72X8RfTbbeqGekX+0Q3+BW
 UWPfk05IrAKN7bq7ILnEiUu1AUnRPn5CACKEQbaSjia2nWv43sn1sfUnpfxISu4sT9JR
 tqe+RN5SmQY1yNqDMLymnSloXPuUOZu3kIls/cYzkY3p3soyCD5kRGIUm42k37CgW0bs
 HvhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741079455; x=1741684255;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c8Wmmn8M/OgiOH6NKd9CKSjOb/3JOuUELt3nUAlLwmA=;
 b=Xi7ldb0IYOyVgSTlwN14OnpB/PTpZFIEHoFLaazs7HVwbIskWvSjTTE+UnA1dyXW2T
 Sv75FZtdBXH/KC0ayRKT8b9/Y+S8QbjN+K2qIHWPqT0cPcB10yQnJVklscuqmsQeNHjK
 szXV8I50FXSKKdswwgUvNzcfnsmFPwCL/JqhGf4lXrewKeGJdmC91pFKijYfPPkkbZ4O
 gGnuXPJhZnBPnmUTWqGdQJ6faq1wGLnTWr2cu/S3u6k7He/IxaqL9247d9uErDqeiECs
 usQMUrenJHbexV5YNyVVCuPN59nKm0Bpsy/1PXmjQWPNs6o6SahESbdEIO7ehTq5SEBv
 PD9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8TPiTa3PZNOFovOhSQgIrvQEKtymyBS7+9i/Z2Zp8H7AN9SGp/2WgJQXC4RkaVFEwYHfhcvk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw4NP1FeR04tSote9gk0VN23agpPBMJ3vi5IY3fRX3Vxv4+sDYE
 jqpQs3HEp2pw8hgOWKhuCj2OipvHljc1Vy20s0P1AeE47fzX/Xc4dEcnTL9CdME=
X-Gm-Gg: ASbGncsx4nImmeBX4HU9kK96WPv0dZMqm/mmhPLh+wzjrmwKJ7nQHkuy6slAzeH56N0
 e85eSfgTphzih5rSSGlUgiToNexipTlL1vVsO7DDvbOp1TJKoRMa1diQH+lYPinfsSaUZ/l+PmF
 eX4fN4mKsF25McKgWRpxytgD/v6WLYL+Md7q984AB3f16H/c4/Mp/0Iso+QGbZXY6Hq78kqlrp7
 cUDWnVvQy1PBPtD71oom8kR3x6/MER+TYSoS0UHz35hTBW0Dk8VXP/TQXQ3hDBW48SMve+10SKY
 19COTguN7PnEf73E7WPTy8cGcNgLCavIpAiFWQySD0EU6hGHCbTex9Y=
X-Google-Smtp-Source: AGHT+IH7HfPfz6g0OLGBHzqXrfBXDc3ZQk4QphmpEyTSlRHLcbAIjKflWHv+04m6ccsIzjZMOFS1ww==
X-Received: by 2002:a5d:6c6e:0:b0:38d:c364:d516 with SMTP id
 ffacd0b85a97d-390eca81d4emr15358352f8f.54.1741079455299; 
 Tue, 04 Mar 2025 01:10:55 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b7dcfsm17280968f8f.55.2025.03.04.01.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 01:10:55 -0800 (PST)
Message-ID: <81cacb0e-c8b7-4c6a-869b-a7d89de29aa1@linaro.org>
Date: Tue, 4 Mar 2025 10:10:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] common: clean up usage of structure jmp_buf_data
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Philipp Tomsich
 <philipp.tomsich@vrull.eu>, Kever Yang <kever.yang@rock-chips.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Bin Meng <bmeng.cn@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Matthias Brugger <mbrugger@suse.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, =?UTF-8?Q?Vincent_Stehl=C3=A9?=
 <vincent.stehle@arm.com>, Janne Grunau <j@jannau.net>,
 Yao Zi <ziyao@disroot.org>, u-boot@lists.denx.de
References: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250302142121.150480-1-heinrich.schuchardt@canonical.com>
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

Hi Heinrich,

On 3/2/25 15:21, Heinrich Schuchardt wrote:
> When implementing setjmp() we did not clearly separate the architecture
> specific part from the non-specific part. The lead to code directly
> accessing the architecture specific struct jmp_buf_data instead of using
> jmp_buf.
> 
> With this series include setjmp.h is carved out from the architecture
> specific implementations asm/setjmp.h.
> 
> All direct usages of asm/setjmp.h and struct jmp_buf_data are corrected.
> 
> Thanks to Zi for starting this clean-up.
> 
> Heinrich Schuchardt (4):
>   sandbox: remove linux/types.h dependency in setjmp.h
>   arm: include asm-generic/int-ll64.h in setjmp.h
>   common: clean up setjmp.h
>   arm: use type jmp_buf instead of struct jmp_buf_data
> 
> Yao Zi (1):
>   efi_loader: Clean up usage of structure jmp_buf_data
> 
>  arch/arm/cpu/armv7/exception_level.c |  8 +++---
>  arch/arm/cpu/armv8/exception_level.c |  8 +++---
>  arch/arm/include/asm/setjmp.h        | 17 ++++--------
>  arch/arm/mach-rockchip/bootrom.c     |  2 +-
>  arch/riscv/include/asm/setjmp.h      | 15 +++--------
>  arch/sandbox/cpu/cpu.c               |  2 +-
>  arch/sandbox/include/asm/setjmp.h    | 18 +++----------
>  arch/x86/include/asm/setjmp.h        | 11 +++-----
>  include/efi_loader.h                 |  4 +--
>  include/interrupt.h                  |  2 +-
>  include/setjmp.h                     | 40 ++++++++++++++++++++++++++++
>  lib/efi_loader/efi_boottime.c        |  9 +++----
>  test/lib/longjmp.c                   |  2 +-
>  13 files changed, 73 insertions(+), 65 deletions(-)
>  create mode 100644 include/setjmp.h
> 

For the whole series:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

That's a nice cleanup. I will rebase my uthreads series [1] onto this
for v3.

[1] https://lists.denx.de/pipermail/u-boot/2025-February/581626.html

Thanks,
-- 
Jerome
