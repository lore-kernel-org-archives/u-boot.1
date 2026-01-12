Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78701C9EC91
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 13:28:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5716838A5;
	Mon, 12 Jan 2026 14:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Q4eLMxN+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D09783923; Mon, 12 Jan 2026 14:28:49 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 068178388D
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 14:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64b92abe63aso12990152a12.0
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 05:28:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768224526; x=1768829326; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yr0Uol08tbOyuEhkESneMei1cti+EzIbBTo7yTMaR7M=;
 b=Q4eLMxN+BrWIIFEz4SFnBzA6xv3A0TRFwEwcI90Hot3cXzxSWcT011ahBJlZNXrdn/
 5uINfKCRdBzZyMo6Rm40yqNH5UFJoq7+agkRbCaIztfqP7obe1s6V9efdAtm5IKgCQSa
 Gg/05L86o/A8lQFWZJuW1dWmmVbLxyRwXGY0DGyUsnWWdeOKEvak0JdLdC3NNpCdHDoH
 80ehJMN1n9Mq7T6BUTLnztHn3lc6TEiIkf8J+KeoQWMouPr5VbXCXZtXGXMN4hK4NqZ3
 U5OpMHFAK+U1EY4FyROailzPwocEEkQuN19jh4fgA4mnml2J3T9M9jQwJWeh19GQuOS5
 J4zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768224526; x=1768829326;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yr0Uol08tbOyuEhkESneMei1cti+EzIbBTo7yTMaR7M=;
 b=inloCDqsTu16nqrybQV4s6G81z0BrwbSeTNdsWjXqyGJUFfrtuM5efE2BJ7OvmhInJ
 4I5v0usKslp5CwtPmRrsRnRr14YdPsh7/r8+woI9c+87AwfyMuUchl3cAEGhFlhRTC0x
 IZgAH2OPxUUri7N8AMFMjLA99yE0Mk1P2pGMP9LRZKIf6qoLzrtnHwz6YCp6zwWJ9cic
 LCUOvwFw33mhSnnF92KkfAU867HLrprxkklcoXA0dRoTSSy5C1bvgGVHDrdYTF3TQaCH
 W77gZOOXgzPAilKXw0ECCb5U403VO9eGPtbIW/hIaBTOtl+sFFyy1rC8DFQwXdvJguA9
 6yqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcs9PYy65UkPmDb8EmC7prrQqeELHR7fOcPc7KfKXZ1PGnYJsJVVr3qqdVOk8LUdnxXOTs/GU=@lists.denx.de
X-Gm-Message-State: AOJu0YxnFkW/TDhVhPsjAq6OSdBhMc7mwjdzWm1u+JV0HDqmnTMj2qd0
 EyLR2QBNLf751Mx7WjzR/EWU4fCAjAKrgU1VN1jbXdqn47u6KawcwBKCDiakP+ycNyC1v72SCHC
 SW/XcnRA=
X-Gm-Gg: AY/fxX5N+/LHG0m6JGUpboAeOy0Y/fGeXJuHV+K5PMhK1o1zcQc2pyG5Kd/tFxhSXZp
 LmZdLUXGEzDXaxckUrndSFG21XcLiz2a+DK/qrDX0Q8dIm9G7TQCM8yyU5XxGa6y9WMnw0ygIKt
 Yw222dkgUrWYbaIBfok8meJkIRryxWTyLzD3ucaVv8wUyRSQXU7VWJyvlXviw9p3AA9RDj2exaA
 GT9SX+dmbwLQmOD4gV20OecGspBUd3KRLO6PgY6wTfbnfUFxQvHo5Utiw7UBYEEc5bp4c3zUH1o
 evypp54hdk0g5bDt89kA4Ub0/wHMlc4h1OkkqPJU2pDqScjNGIy907i1TTThELlNy2rqg7w8VgP
 FhdNDWKUqnN/y78jun9q5aibQaO0AyiAYNfcAOxmQQfjPVjghVhFlFI0UdYgaeU19MWriQUsF6c
 xqSKBJt7hlN16ta3jWvgheXUJV5pk5d6TxbjXrIsAWJ+Qp051hWys=
X-Google-Smtp-Source: AGHT+IG7UWUuXev2MT0ln7OVptHtPKNkNlLxA00BkWXQm6v0cgdEquAH7Al29hCKYlYbq2aPPR1Yhw==
X-Received: by 2002:a05:6402:278f:b0:64b:83cb:d93e with SMTP id
 4fb4d7f45d1cf-65097e64045mr17339782a12.20.1768224526172; 
 Mon, 12 Jan 2026 05:28:46 -0800 (PST)
Received: from [192.168.1.36] (p5b29e30b.dip0.t-ipconnect.de. [91.41.227.11])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-650f4d8ec43sm5221893a12.35.2026.01.12.05.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 05:28:45 -0800 (PST)
Message-ID: <2170841d-15ab-463d-b5b7-0b2d5b8e79d3@linaro.org>
Date: Mon, 12 Jan 2026 14:28:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] configs: qcs9100_defconfig: Enable SYSRESET
Content-Language: en-US
To: Varadarajan Narayanan <quic_varada@quicinc.com>, trini@konsulko.com,
 neil.armstrong@linaro.org, sumit.garg@kernel.org,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 jerome.forissier@linaro.org, sjg@chromium.org,
 patrick.rudolph@9elements.com, clamor95@gmail.com, me@samcday.com,
 robert.marko@sartura.hr, u-boot@lists.denx.de, u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
References: <20250613051957.3159564-1-quic_varada@quicinc.com>
 <20250613051957.3159564-6-quic_varada@quicinc.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613051957.3159564-6-quic_varada@quicinc.com>
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

Hiya,

Can you respin this as per:
https://lore.kernel.org/u-boot/4ce7da40-8c8c-4594-a108-15a723006a94@linaro.org/

Then let's get this picked up.

Thanks,

On 13/06/2025 07:19, Varadarajan Narayanan wrote:
> Move to SYSRESET for implementing the reset command.
> 
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Add 'Reviewed-by: Sumit Garg'
> ---
>  configs/qcs9100_defconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/configs/qcs9100_defconfig b/configs/qcs9100_defconfig
> index 10ff4d25398..1fb621b27ce 100644
> --- a/configs/qcs9100_defconfig
> +++ b/configs/qcs9100_defconfig
> @@ -16,3 +16,5 @@ CONFIG_TEXT_BASE=0xaf000000
>  CONFIG_REMAKE_ELF=y
>  
>  CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
> +CONFIG_SYSRESET=y
> +CONFIG_SYSRESET_QCOM_PSCI=y

-- 
// Casey (she/her)

