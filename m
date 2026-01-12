Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FC8C9EC90
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:29:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1168397D;
	Mon, 12 Jan 2026 14:29:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y0iMY4FX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7861783A8D; Mon, 12 Jan 2026 14:29:09 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB048388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:29:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-64b608ffca7so9935307a12.3
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224547; x=1768829347; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cJ6quuXulQascNyuhezqgcYm57s1E0ywEbShV4Tn5Ks=;
 b=Y0iMY4FXV9DARdnT08LM0N7z0EQii3T0iQipbOyuNJAwAhRM5GbDFHXyk0XMdUKybC
 SPLwBF4Ob3v+rN1KnmnPeJ7RCqgzunCYKM1k4hFKyndJqFrE5rhyEnLweHpyEbUhEEtF
 J0grO7yGg+la2P1qs8F3UmSj4FHaYjAylEYPrn3o43hmEvwoe+0IGKD1GUWIfSZqhJBB
 l+gJNGejJ29Ec2zex3HHHhXrEfS6abrfI8b81EhhUvrGgB7t5Khv5wJArefG/7p4kda0
 TJ8oTSX7HLOcFkLcN9+yqf1iJ8z+QElXm101Z8zn2acfL7r+2zn6DrNXE69n8NpguyvT
 imvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224547; x=1768829347;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ6quuXulQascNyuhezqgcYm57s1E0ywEbShV4Tn5Ks=;
 b=w3iD98iUuNMCQtn8MHCoqhLE6KtDBCy5aikAmGeWBOvNk+iaLGdeXsK7uIxE/XsdTE
 DzWvrhLhGllYiYEMutXq0ikHt4rQNhryLFpONP+SaEkyObvpzl6We+xticmipl0H83/g
 u2iJ5wI1NGHctb0N7HoUou71MHAnkp/GT41qGJTG+xfTSzpLiylf72qrdqA1jIzHO6jQ
 1iNwARLKDaoWe/lzwBPWdmlRI/iKRxyTe1k76I9UnwlYX+w8Lg0zzmoGJDbf8SdDX/cd
 zG9XidXsaCS8Fsrhqg/ilWQru/9bdbe5S1shyWLT/BiyQi3q2QpHfuoAM2kX9wVegkPJ
 tmHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV911AfRaUeVx+15DOl2UBOjaaOLbTHt5ycEyQbXrjKQ39FaRfj/c8eDxewWvAOvARbEdUnspI=@lists.denx.de
X-Gm-Message-State: AOJu0YzDKoJkDHCJpuiJU7X0ea6VVOPJx3qK8UII2u0CfjCt7o183yql
 +5khbP1A+doeYkFhwygbcQnQgt5GQGFqvWLG3QP0PeyHsV2v956IZA8AjflpyQOZpWA=
X-Gm-Gg: AY/fxX6kvztBNSV5exxJm9N37eDMTHLy1yPvVzUmJ1ACvG4X8fwX8CPoun4WzRFcqfJ
 YOd0sNWeLRVw1a4Ctfka+9duyezdUNkiA9xTe+Qlg9wD0mQ9Ma52Qr58K927XbBio0CpfSZ/oAy
 f2uqS8yBZt5Kwq617XCVXgDzqsGv+OiWggq3l0Q+mWxBwqIsW0YhP+loNmnIa6cmLLz8RdSIZJS
 S6Q2WjQ116+xnxZkZJnLYQPx+08vW9/fcClgW/GUSSnGClZa8Y+SdAP0sllIlyQaFVujAGxQ4bg
 /akVpzG1cy1WC8qe4Ijuvk8Ee4Y723Ya54EPZufnR7Nrx21xrSNO09kWBXc/AGT0R2dLVOqcOeZ
 fKC0JPIl5ZNwPMsAOf/xPgFnNC/+3ueJvFIDhqdpie1Z0aHzkWD/aYEl4onVLDobMcqT4NvpiSW
 gAU7cK6p0Y2/BewjdBUgJVfJkJifaEhsK9Y6gFvVq2w0uycGaVEls=
X-Google-Smtp-Source: AGHT+IGc5K7HIC54JNLIGf9pIpShCsbuU0yD9huDU+NF12HUxQeJbHpO642rvwcBR0hpCdJGXTHltQ==
X-Received: by 2002:a05:6402:270b:b0:640:7529:b8d3 with SMTP id
 4fb4d7f45d1cf-65097dddcb7mr15272921a12.9.1768224546892; 
 Mon, 12 Jan 2026 05:29:06 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507b8c3f89sm17807723a12.5.2026.01.12.05.29.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:29:06 -0800 (PST)
Message-ID: <ceb1bca4-f66e-408b-a7da-74a9c80bfa4f@linaro.org>
Date: Mon, 12 Jan 2026 14:29:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] arm: psci: Add API to check for support of
 specific PSCI function
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-2-quic_varada@quicinc.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613051957.3159564-2-quic_varada@quicinc.com>
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



On 13/06/2025 07:19, Varadarajan Narayanan wrote:
> Add an API to check if a specific PSCI function is supported or not.
> This is based on the psci_features() function present in Linux kernel
> (drivers/firmware/psci/psci.c).
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>  arch/arm/cpu/armv8/fwcall.c   | 15 +++++++++++++++
>  arch/arm/include/asm/system.h |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/cpu/armv8/fwcall.c b/arch/arm/cpu/armv8/fwcall.c
> index 87de09979b1..f834d770dd6 100644
> --- a/arch/arm/cpu/armv8/fwcall.c
> +++ b/arch/arm/cpu/armv8/fwcall.c
> @@ -129,3 +129,18 @@ void __noreturn psci_system_off(void)
>  	while (1)
>  		;
>  }
> +
> +int psci_features(u32 psci_func_id)
> +{
> +	struct pt_regs regs;
> +
> +	regs.regs[0] = ARM_PSCI_1_0_FN_PSCI_FEATURES;
> +	regs.regs[1] = psci_func_id;
> +
> +	if (use_smc_for_psci)
> +		smc_call(&regs);
> +	else
> +		hvc_call(&regs);
> +
> +	return regs.regs[0];
> +}
> diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
> index 4c1b81483c9..0b788bcf0e5 100644
> --- a/arch/arm/include/asm/system.h
> +++ b/arch/arm/include/asm/system.h
> @@ -336,6 +336,7 @@ void smc_call(struct pt_regs *args);
>  void __noreturn psci_system_reset(void);
>  void __noreturn psci_system_reset2(u32 reset_level, u32 cookie);
>  void __noreturn psci_system_off(void);
> +int psci_features(u32 psci_func_id);
>  
>  #ifdef CONFIG_ARMV8_PSCI
>  extern char __secure_start[];

-- 
// Casey (she/her)

