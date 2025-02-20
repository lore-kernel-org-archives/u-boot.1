Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85EC8C021B2
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 10:50:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07385801BE;
	Thu, 20 Feb 2025 11:50:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="bXdTlCpU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2255880C98; Thu, 20 Feb 2025 11:50:19 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A0558007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 11:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id B31683FE73
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 10:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1740048616;
 bh=lRfQueScKCbG8g4W2w2vRGmIqZSAMl+4f+w/HSra6/s=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=bXdTlCpUGJLf2D87TRPsGGqGqd1cnoXIQOidUtS+u838XgCTtIN7qsWx+A4nslIE1
 szCcmn5vYapuSlCf2hzMiLkc+602YvT87HeiaQSRulUoOzn6P+mdsarZR2uzh5X0dx
 8FnS644dS25NJEwrFEZ+3HlLvlVV6laLOiw8SC/M4/+f+NsUIgFzpxdkCYDBIP07yL
 EkDN2xH44srqVJ8BnvvDJ5rnvG/MzhvOXvC14FO6hF3Lvc3DV6jIkpNym9CDgp24vD
 5Np95ex4oUD0ATKilDGG6I1D1ybx8bfvTvJQHP0FJtcjkwpO2F7nLNgkgGV1fs5LHn
 27EuPWR2QAs+A==
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43947a0919aso9147335e9.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 02:50:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740048614; x=1740653414;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lRfQueScKCbG8g4W2w2vRGmIqZSAMl+4f+w/HSra6/s=;
 b=w2hgVUO+ikxHEvpu57bnOKcKdllWourzSnpLg+bu2srugopkJY1Tbmukd3hvchYM80
 c7syBQkmSbonhrH6sJmPvG/F4v23UaeDXRhlDnZwqHTQu+ILxHRjGFdRrMoDTlV7+YzQ
 EKnSkPx4b1a5/FXflg1ms2nW+8HZz7eYSn4UMnY+Iaxltw0UFciLur24eRHoeL9GYt+M
 oxV8ujb5mvCMzLQSJQQDSXBV/J/Pb1b6JZv5i0Z5+dnDdsKjcGHuq0SZS5L5PpveHZV5
 W/jXyGgVs2BURRa8qq31fgYLkKqX3PZezASkNiYo2W4GTKvPu9gY/4boVCqc7ALZJ7EP
 mSvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1EeHeffsgthv332Cy5eqHv1UzmWSNqf0zFMuME/7tZp/sVamIMZ7NhB3zItnrdphzygoK6YA=@lists.denx.de
X-Gm-Message-State: AOJu0YzJ/0SLFOezTnAPnqaEEgLULHrv+6XBCvTMrZcoDkIbr/I5tZhX
 BHkk75LeOl/MNcGGqVk1BNQT0LqWTrTVH4VWcXG4Mj0+yg/JVTsoqdjMQKe+zFY5d9Hd7n+DTz2
 e5ddhrScXZQuhZOrjH1d/LqIzDGyiUyVv/y+VPnO7dcnWlnodhnhjqdzBztzZp6AC+3U=
X-Gm-Gg: ASbGncsYk1WtovnmIZwO9OMVyGmWBheDirs+D3XmshjEaI1M2JaascpNyx+dGSJPUXE
 I12aGOZ8zeKMh2phiCcox1Hz4R/8/bhTubFQxHAhcd4I0L4osr654zRqM6vvaUGWlmAMIlUz76j
 LczOQEpI7HN1T2cmZm0jYIX7wlJj/xa+zb/cCfIAu+8vhv1bmfe6/1wnKNXsiVm+49Y74w5jPc/
 4BQIBtJ3hPVMuRk014nzBkl/XCx5JLhHY1yoQwr2DMOPV5Sb6xG4igO61QZO4fbO+O3SBLLLX9e
 jMOR/3PQiTMPH9ia3EXcwqmWM/6VmaDalftsBkUJP5dsf1V2V3IR9rbKpANfs9gG7hHD
X-Received: by 2002:a05:6000:1568:b0:38f:43c8:f766 with SMTP id
 ffacd0b85a97d-38f43c8fb55mr18377400f8f.31.1740048613847; 
 Thu, 20 Feb 2025 02:50:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFRJk4zAW74nETvHanwLWsW/n+PNSqxeZ7g4ucwPK8hF0IcuhhbqguRSNAwXf2OHr1R/JhxwA==
X-Received: by 2002:a05:6000:1568:b0:38f:43c8:f766 with SMTP id
 ffacd0b85a97d-38f43c8fb55mr18377373f8f.31.1740048613417; 
 Thu, 20 Feb 2025 02:50:13 -0800 (PST)
Received: from ?IPV6:2a02:3035:6e0:1d2:497a:3557:382b:d853?
 ([2a02:3035:6e0:1d2:497a:3557:382b:d853])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f7979sm19989669f8f.83.2025.02.20.02.50.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Feb 2025 02:50:12 -0800 (PST)
Message-ID: <654e629d-5e64-42ef-820e-ef86babc60d3@canonical.com>
Date: Thu, 20 Feb 2025 11:50:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] lmb: optimise the lmb allocation functions
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Udit Kumar <u-kumar1@ti.com>,
 u-boot@lists.denx.de
References: <20250220095654.121634-1-sughosh.ganu@linaro.org>
 <20250220095654.121634-7-sughosh.ganu@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250220095654.121634-7-sughosh.ganu@linaro.org>
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

On 20.02.25 10:56, Sughosh Ganu wrote:
> The actual logic to allocate a region of memory is in the
> _lmb_alloc_base() function. The lmb_alloc() API function calls
> lmb_alloc_base(), which then calls _lmb_alloc_base() to do the
> allocation. Instead, call the _lmb_alloc_base() directly from both the
> allocation API's, and move the error message to the _lmb_alloc_base().
> 
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V1: New patch
> 
>   lib/lmb.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/lmb.c b/lib/lmb.c
> index 874063fc1f5..6bfc0dbc9ce 100644
> --- a/lib/lmb.c
> +++ b/lib/lmb.c
> @@ -758,26 +758,22 @@ static phys_addr_t _lmb_alloc_base(phys_size_t size, ulong align,
>   			base = ALIGN_DOWN(res_base - size, align);
>   		}
>   	}
> +
> +	log_err("Failed to allocate 0x%lx bytes below 0x%lx\n", (ulong)size,
> +		(ulong)max_addr);

Printing such a line is not expected in an EFI application. It would 
mess up the output of menus in EFI applications like GRUB.

I think this line should be debug output.

Best regards

Heinrich

> +
>   	return 0;
>   }
>   
>   phys_addr_t lmb_alloc(phys_size_t size, ulong align)
>   {
> -	return lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
> +	return _lmb_alloc_base(size, align, LMB_ALLOC_ANYWHERE, LMB_NONE);
>   }
>   
>   phys_addr_t lmb_alloc_base(phys_size_t size, ulong align, phys_addr_t max_addr,
>   			   uint flags)
>   {
> -	phys_addr_t alloc;
> -
> -	alloc = _lmb_alloc_base(size, align, max_addr, flags);
> -
> -	if (alloc == 0)
> -		printf("ERROR: Failed to allocate 0x%lx bytes below 0x%lx.\n",
> -		       (ulong)size, (ulong)max_addr);
> -
> -	return alloc;
> +	return _lmb_alloc_base(size, align, max_addr, flags);
>   }
>   
>   phys_addr_t lmb_alloc_addr(phys_addr_t base, phys_size_t size, u32 flags)

