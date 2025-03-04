Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61952C282C6
	for <u-boot@archiver.kernel.org>; Tue,  4 Mar 2025 13:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C38A18141D;
	Tue,  4 Mar 2025 14:48:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="n1XpXuup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7735E8004F; Tue,  4 Mar 2025 14:48:52 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D42A814A4
 for <u-boot@lists.denx.de>; Tue,  4 Mar 2025 14:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-307bc125e2eso63196461fa.3
 for <u-boot@lists.denx.de>; Tue, 04 Mar 2025 05:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741096129; x=1741700929; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YPoEp6RbJWUrBSX5HA/CE85CcbiQUfu7V5I8shs2vas=;
 b=n1XpXuupjB5uaLwt2cQkE/tfADArHCsIZMcSbMmuMEAHfNnzh05IryMGtP5fFeJfwi
 vEK1Q87n3S8VsnmFomLbRohN2YNN7gwT4jYU89irJTjThr0ARLAMjKWOv4rYot/xOvLK
 srP6sYZsRyxRoYpvixuVuaHIdfzkk5F+9fNFMPJv5FCnBTyyl8fpTx16RGsUF2M0prVu
 quLuT5je4ymSN5GvUeuKp7zJ4E9JqCa9YUFV9pKxwc00hGTVs2Mj8bMSXYiQ//13P3O2
 ShyCqABNLkxRO1hQDMwupufOqPhAy80tNU3fquEE/1Ka6+YCzkemFvpy2K1wMo8wVd8z
 rnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741096129; x=1741700929;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YPoEp6RbJWUrBSX5HA/CE85CcbiQUfu7V5I8shs2vas=;
 b=kUfBx0Lh4DttJVhJyWDrg67F1YzPo3k4mTnH4sIg4wpz1Rkph3ODHRtm8iasSq4TPZ
 YaBFTqfshZUTHPCaTd14w/kUe++VuAka0lLgzvkq8hssw74u3vz8d+zcFKnsESzoPHtF
 6WCa4p+jE8D+v5BmqMjitFCqcbuetE1KWVvsP3Yw6kj9Wx68R2Nh9Pe6UiX6blxcXBWj
 WuCiRzVIDZMdf7PDKa/HSKQfcJfE3o5TtlPwww5zU4x8ckekcM0kG1s6vitGQClAOfz2
 F9Bkv6sHezguUuw3EQ8FWk0OpRBmzcJBTeMEmTCedxNpQN9J91sdUXYmcBebfhKqZrLx
 7iqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVum9VYAMvqWmtev3R7az2+aGGu0bhaVBghQFu9rPF5RRMVwnxlZScm+5WxR9JrOLO8qvbJvlw=@lists.denx.de
X-Gm-Message-State: AOJu0YwKBtkrCr2JvtWADNIzL6gQ/yHU34uYopCip+gwc3wfBq/QHMzw
 SZjSNB+jOu/6ES+03Vt972dn9Q2PYSI/6qWw+5K1jQVQUS8jBkBgtkYOJOvctxw=
X-Gm-Gg: ASbGncun3k636Lz6fdtiSEI6gQF3dmPStSFDGYp/3ffLNbs57IkcTJIW3r+IhkE30cu
 5BQKOwtGZL+YtcZEkQUqa4QKZjkBx2VXgJBYMcZ+2betkibE9zRT+XRaFEQxTEjnFMLBL4yNdxe
 VAe9dOCbyUHkbTSzv5EaQzTdidy2D2HkdfnP4fe6Wq+TqFExYiWKHzqnJ1hlkFo/CB4+3Aglrji
 HBSeQXQaywEGjpgwsfRUK5dePUkp36cyDhO1EnoMTXTd1Ey9chN64c97p8cuTpDdV84cVZNuQ9g
 mbzNAIkjbcFVg2847tBZWZCKfWN8HOpfsvM/3KHpBHQ4GNp8ZqJcV94=
X-Google-Smtp-Source: AGHT+IHj91+xdZzH4ZDL1/SYpCgYh6Pb7MiYfoOtlSmF39PqELhfyW81yjozi3cbhA6U5qrOtRMJRA==
X-Received: by 2002:a05:651c:198a:b0:30b:a187:7a77 with SMTP id
 38308e7fff4ca-30ba1877b0emr52491201fa.4.1741096129257; 
 Tue, 04 Mar 2025 05:48:49 -0800 (PST)
Received: from [10.100.0.2] ([45.84.137.215]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-30bae18057csm9123541fa.26.2025.03.04.05.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:48:48 -0800 (PST)
Message-ID: <c702adb4-f9e7-4c57-b4e3-783b643354b3@linaro.org>
Date: Tue, 4 Mar 2025 14:48:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm: include asm-generic/int-ll64.h in setjmp.h
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
 <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250302142121.150480-3-heinrich.schuchardt@canonical.com>
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



On 3/2/25 15:21, Heinrich Schuchardt wrote:
> Don't assume that u32 and u64 are already defined.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  arch/arm/include/asm/setjmp.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/include/asm/setjmp.h b/arch/arm/include/asm/setjmp.h
> index 662bec86321..9a7f5af9f8f 100644
> --- a/arch/arm/include/asm/setjmp.h
> +++ b/arch/arm/include/asm/setjmp.h
> @@ -7,6 +7,8 @@
>  #ifndef _SETJMP_H_
>  #define _SETJMP_H_	1
>  
> +#include <asm-generic/int-ll64.h>
> +
>  /*
>   * This really should be opaque, but the EFI implementation wrongly
>   * assumes that a 'struct jmp_buf_data' is defined.

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Regards,
-- 
Jerome
