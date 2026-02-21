Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EA9C61DEB
	for <u-boot@archiver.kernel.org>; Sat, 21 Feb 2026 20:10:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 380E483936;
	Sat, 21 Feb 2026 21:10:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E+uRRI78";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0803683A41; Sat, 21 Feb 2026 21:10:30 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC627801BE
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 21:10:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso38125495e9.0
 for <u-boot@lists.denx.de>; Sat, 21 Feb 2026 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771704627; x=1772309427; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bC6JUj3zrICaEtjd4CMhHMahl5hK76o8+V2OCKkV3nk=;
 b=E+uRRI78qPJOruyGCl7KbSt9i1j+oacJYbWLcobK7Js1ggsm/esnIU1NTbwG1JYvgJ
 liVKiii3Dy/BcwCnoH/FKJbu0CkNsNcIiu5g+fTPUsseJ/S8gvrZ9j8/PK5GIAYsN33g
 cK0sq1b3ELytAuMUoUcaiEXTR6KtdHQSrgeIr6h5V9lKlDJwaJgVqeuIrJ39/ce8qkiQ
 UBgS6xTg/MBBEf2WUoLkDhEv4pctaGqX7o42Be3+bae3F3/QQB1lbkNNxLyadjXCb7HN
 7UQ1DZh2H1sp3q0yTY9tSATSKvOHvxnPAi7peVNPYe25tAU+LXoGFPPnziiu/ERc+w19
 fWIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771704627; x=1772309427;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bC6JUj3zrICaEtjd4CMhHMahl5hK76o8+V2OCKkV3nk=;
 b=byUj/0yqBaAe3YNRvIICf9bAWappMAAM4cHSj0h6swh/9xhYJXxwQHG2mNve39lp/B
 kRELQSaNKGRPilgTLsPsI4teTxAStUN/zRgNKIZu//aYz3B6VBnlIDeKewFolre6bkqb
 MvH9l/D9XGnCSFDItUvQ9ms7Zy1bS47X7tqEKZwWtE9JGkT+M4J//12TotBzAv1OKc4W
 dCGMSusQmmGwxAIkMQuR+Xii1H0OTpCLhO10yK9oCaOtbST6y4S3VkSGjEtCvr9DF+tV
 UEmcy1qSzestKEzugLvJYrnfcKXfyPFUYBhZ2xMjsEZnGiCe0aG/wdZ9L9dM4hi8Hod0
 /dPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ0Bv8YTSMqy7btGsVI7ydb9mqCms2xwg5QqbeSzKesOXRhy63in1bLu+iVVbfF6R7qdT+8Yc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywt/5HMtnTxIY5Yawm+L4OjLSGuU/n255DqPkme84xMbW5ii2po
 ylAVdf6StL4saEn3r3mXUNOSZwlzVgLpnC76E3qIKGWd9nAphb/gym2klAvuo1v1zk4=
X-Gm-Gg: AZuq6aJC3jBsiZCdw0xyfsxfwkbPOXIAkIMUEd8RsmQOE+BfCuhrmlPa2olbbWJE44d
 xxQz0J9c0Xff5k5ZL8R5MJPpds3HLn2Ki9drTo8O6txmX41skRmCUUMXXMrXP7tkG3gjOn7jv1Z
 /LiTqYAHmw8OE9Y/Jjm+W9FExyb4YjalGc1y7wjTUQuy27W8k+LhYT2HTGKs24AJRmXHdS3gaFH
 jOvcnnPUjyvUuMB7TZKpa+a4PPA+gOx+kVt1w5x+n3krILWftPn+baA/4p3uy97oqsp+0TLsI1s
 rzJX6stseFCurO2kTK5LSid5MZxfFLStcaEbx0p2DmxlqR4uOujPSQH0QNt4gjGauUsdc3pMcuC
 apSpPy70cMuIkWwIKs4ePWUSQDpePaVp5bojl8BdoXEU6HfPCSiF/oPTKHvvWLLhdlNjxRMTBN6
 63pxUQ5UpIMFSEHZhX6pOg/61c4Nizmd6nDnAH0MLkCaZuK0WbVunuMo5j0881EA1EH/9MuB1Cx
 A==
X-Received: by 2002:a05:600c:6487:b0:47e:e2b8:66e6 with SMTP id
 5b1f17b1804b1-483a94d2fb5mr70957475e9.14.1771704626747; 
 Sat, 21 Feb 2026 12:10:26 -0800 (PST)
Received: from ?IPV6:2a01:170:117e:fc:801b:3248:8888:6772?
 ([2a01:170:117e:fc:801b:3248:8888:6772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a3db3369sm70222935e9.0.2026.02.21.12.10.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Feb 2026 12:10:26 -0800 (PST)
Message-ID: <cef3b382-7b11-4295-b441-4859b10a522f@linaro.org>
Date: Sat, 21 Feb 2026 21:10:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mach-snapdragon: allocate memory for DT overlays
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sam Day <me@samcday.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, George Chan <gchan9527@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, phone-devel@vger.kernel.org
References: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260217-qcom-fdt-overlay-v1-1-d0fa0e70d738@smankusors.com>
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



On 2/17/26 09:51, Antony Kurniawan Soemardi wrote:
> Allocate a 1 MiB LMB region for fdtoverlay_addr_r when
> CONFIG_OF_LIBFDT_OVERLAY is enabled, allowing runtime application of
> DT overlays on Snapdragon platforms.
> 
> This is useful for Android-based boot flows where the final DT passed
> to the kernel must contain modified /firmware/android/fstab entries.
> One use case is redirecting system and vendor partitions to microSD
> storage instead of internal eMMC without rebuilding the base DTB.
> 
> The allocation is conditional on CONFIG_OF_LIBFDT_OVERLAY and has no
> effect on boards that do not enable overlay support.
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>

> ---
>   arch/arm/mach-snapdragon/board.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5a6dd23d93515029a596b5f77ebfa3..829a0109ac7807d692e127178f76d8822d5da5e2 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -555,6 +555,11 @@ int board_late_init(void)
>   	fdt_status |= !lmb_alloc(SZ_2M, &addr) ?
>   		env_set_hex("fdt_addr_r", addr) : 1;
>   
> +	if (IS_ENABLED(CONFIG_OF_LIBFDT_OVERLAY)) {
> +		status |= !lmb_alloc(SZ_1M, &addr) ?
> +			env_set_hex("fdtoverlay_addr_r", addr) : 1;
> +	}
> +
>   	if (status || fdt_status)
>   		log_warning("%s: Failed to set run time variables\n", __func__);
>   
> 
> ---
> base-commit: f9ffeec4bdcf1da655a0ffea482062adde78fee8
> change-id: 20260215-qcom-fdt-overlay-ec6b8d9d2a1b
> 
> Best regards,
> --
> Antony Kurniawan Soemardi <linux@smankusors.com>
> 

