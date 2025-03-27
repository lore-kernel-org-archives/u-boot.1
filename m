Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E5C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:28:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D0C0806D8;
	Thu, 27 Mar 2025 17:28:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mVg5mDOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D59D8070C; Thu, 27 Mar 2025 17:28:54 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DB25805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:28:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso11691345e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092932; x=1743697732; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wf//nq19qpRJWK0wwIu+4epzr3aQEFzHM4jlBScR9sA=;
 b=mVg5mDOsNc0A0Yphan9jBk0jneKtHsUbkmgszobR72RzPKz/XuiNAphH7RyhgM6CYl
 cCABlvw5CGNVe7hSaenyjGFTOulGhVW7sgBdDuVPiDe2Tvz9isG+RMlEXuV/P6Jzut+o
 3MH6isG3Z9MFBhKgZkyWjPeIu4WGb/WZonQwmpKTMXdBP7qda0D1xj4M3OvejkeXa3NF
 RbsKHGQ9hXkJUUUCZN0u6HOqcslGTzDW8kFdPffF8ushED5h2Hvb0zxqWU1LTLirzuMG
 tbqaMW7UK0rogsSk5oJc0q2wcnILhVLoN0QzRPT84pd8JudvOlwOIN7jlrwRCNgmXJpk
 nZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092932; x=1743697732;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wf//nq19qpRJWK0wwIu+4epzr3aQEFzHM4jlBScR9sA=;
 b=spZMW6jYX0dzJHE5R9d8GAMmKovuWpZHlbcLKxvQz8n3UZYDJHYfAplriyn4TvpAbr
 W1BvzIadZuxqKsfJdSEaAFNWrpvj/+/7K9UXjGzgbuySJWey/hB3csodFcCypKAEmduY
 otSTtc+/uckHwXzsba4dUoCBOf668CWTbiF61jhY3XPFzQwLVW37dGDahpzWPPCjuhar
 zJVZVvSo6cAulqH2M0L+5jcfxRdCVqzNvajTaYijuS8k9Xa+uc6Yf9SfdvKaK4uZ/klp
 sXewogAYxTHcUAXab61TTuhyPRt1YuSqAgcVwp/64wQyo9I2xO7it3AABGaBrAj4DR3z
 Snqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKNSdb8Xd79bqspjSTYCveCiOdznDIWqhCOT5ZXaPjSgTXSWYNeZDHPBp8Sgrk9jsPjk/eYLc=@lists.denx.de
X-Gm-Message-State: AOJu0YwQWiiFwPG3mUbeDRWo1XUURZ7MqP3YllQVaPB7E60ilNt+8WlH
 b4z3+x4jqSSHTzKBmGVDAgdpE0TaFFfvaJO+VaBJ1MYZnS+5p88d3RZgFzU9f3A=
X-Gm-Gg: ASbGncsuA4+dN2YD4Dj4d9IW4M7smYe9AiPE+jXmtZ4jDwzcAy++8DVpubMRwSFgEse
 OjHfno+NkSFzLTuMrntcjrRRZZyvTfbvoYWodASNbWb5M0qRGM2GNzgf8LPXKUY7aKC3uumdEY4
 N98RfimXUui80dPWMemafpgfbGpVIrO4F789uMgnxP9HNTE3J1GlSGiwG0OLQDd+Mg3mlE8fkcW
 jOKhfmC7WlT+hJpFSzgcTVnAOwH2ZS34zUU8quP+0wFVKLM1wpC5R8z2D05FaoQh9R9BrejIn7b
 F67z9qj5oXFP03FKdwLZFMxQRbIMHmkUeyyRRjMRJjN/Yg5PDSMr8UM87CK/0Wi16uQc9GmxhgE
 =
X-Google-Smtp-Source: AGHT+IGuQULHRJM2QTLdXdsTW9jvv7+P3+OGYu95pwK/t43yPhCXVQcWUd3Dhop7aiQJDQWTl+YGhw==
X-Received: by 2002:a05:6000:1786:b0:38f:4acd:975c with SMTP id
 ffacd0b85a97d-39ad174916emr4066724f8f.27.1743092931610; 
 Thu, 27 Mar 2025 09:28:51 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d7bfcad9esm43280305e9.1.2025.03.27.09.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:28:50 -0700 (PDT)
Message-ID: <a13e5210-b666-467d-8b9c-da0b8d35c3e6@linaro.org>
Date: Thu, 27 Mar 2025 17:28:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/29] efi: arm: Avoid allocating page tables when
 running under EFI
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>, Tom Rini <trini@konsulko.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-16-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-16-sjg@chromium.org>
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



On 2/15/25 04:22, Simon Glass wrote:
> The previous bootloader has already set up the page tables, so don't try
> to do it again.
> 
> This fixes a crash in QEMU when booting from EDK2
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
> 
> (no changes since v1)
> 
>   arch/arm/lib/cache.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
> index 516754caeaf..bdd0f202bf9 100644
> --- a/arch/arm/lib/cache.c
> +++ b/arch/arm/lib/cache.c
> @@ -6,6 +6,7 @@
>   
>   #include <config.h>
>   #include <cpu_func.h>
> +#include <init.h>
>   #include <log.h>
>   #include <malloc.h>
>   #include <asm/cache.h>
> @@ -138,6 +139,8 @@ int arch_reserve_mmu(void)
>   
>   __weak int arm_reserve_mmu(void)
>   {
> +	if (!ll_boot_init())
> +		return 0;
>   #if !(CONFIG_IS_ENABLED(SYS_ICACHE_OFF) && CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
>   	/* reserve TLB table */
>   	gd->arch.tlb_size = PGTABLE_SIZE;

-- 
Caleb (they/them)

