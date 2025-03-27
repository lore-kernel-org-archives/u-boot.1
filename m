Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66074C3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 16:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9FA6806D8;
	Thu, 27 Mar 2025 17:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="peKY2gqj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9036806FC; Thu, 27 Mar 2025 17:29:31 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C990805C8
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 17:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cf034d4abso13297215e9.3
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743092968; x=1743697768; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pl7f6Y3VDyVvmsy7qH37h/EtiuAwEDzSwBvAolAGwvs=;
 b=peKY2gqji56uIQ7Prah8d/i2GcFoqzbbsgVohBP9zskSuZh0ZTbHNIfhBkKdh+UEbl
 QcGAMUpqIn1bJ3nOtR1nrcYOs7H6x44buR8KhUtaBcrxtpElkll7hCgqD2sVJ7Hseg7s
 SlptMQTaMShorNw0SABxqthMQUHUaQ8BrFqWP8hsGdsPAuokqFKn8kJGaJ65TGz+8uSF
 9KvCaw2LHZsCXbclCBGSR1a1Tyf1SeXr3NfAwacrLFUki9YOiTmz7hX+wbJFdrWR3BnD
 k8sVv8/MFxB/F2OPMOz2UPulL3WKgO73E7TwRtuNt+6IrDRPdxcHpOsktzkfqZT9hm20
 iDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743092968; x=1743697768;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pl7f6Y3VDyVvmsy7qH37h/EtiuAwEDzSwBvAolAGwvs=;
 b=JaL3wRXnvQx7zazt9A+1tCbb2mPqIfzCHXegnUpmxC+CVNY4yY0mELZJcgCtAnsYC3
 jb/K1qi6AVDI0TTmFyrpqe8UeA10iXKgURb03QHgQ1Ko9DOYHwRVGvojQsRdgxXFg08f
 dJ/wJ8Nb6J8LViQFNB6NI9Mv2FIKozF9qsEqpcdkWUm5tmfcbq6gmc3bkMravljJuaO4
 zJl+Y8CND4wHO311NLQ3HZ0zXZiS+iWhs1tUOsayTZV1xCUD8yfIBHewSQg8EhXCYJ75
 TZKbLdBBA81Nahg1O9a/gAtWNg/0P4sYKl5aN7odBkgb35QTczHe8lyFt3fFSxbqkD3D
 9Jtg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtUJxlnoG0IBhtkqoGAWq6ZLFYECBWhVeQQVN2mYOhRSxEcJ5E58GgjAHQo8TGGDykLs6/b7A=@lists.denx.de
X-Gm-Message-State: AOJu0YzCQ/I+Z4nApmjtagm5DLzLlU1mWCMlNjVpAfZzEpz/+k575752
 9SKHrDDn8VeJ5YkSsc/5AkTHRoX58fRQRRvI0zCeC7C23QowKBhhD8Zdf+cwsPA=
X-Gm-Gg: ASbGncv115p3XnKBrWQFfeVZhx+SGUH5+TxYa9WE8q3scnB6SUzzU53Pj6Y/ImR688O
 XxjJaFMsUXph6WM4959r7yflRKqrCsWAekWEV/J1Rl9Vfr7JhsB2+0tvOXbidF3jwK3iC8lQD4f
 FDWN4LBSZ7YV+eHDV0xKlWcV1+TSSMOpHMCUulnscx5Mfeus6aKyqxOd21QdtuuEgUv3Xlvn8mi
 4qUnwTMPswCYXwqCnDqm2MGbyssLyxaTmYo/RHQk9d8z+n8KUQ3qr11TgSDjbXbh/yJTHuZ0Ngb
 uXTniTCEBZ8h6kYhz1JCgzwuG89Ev7bNpvh5FrNsjGzjMDe39xzzkieufOG4NFWkdoa5j+xYGGU
 =
X-Google-Smtp-Source: AGHT+IFtuTl3P8DsX63ekVe9lrHI+GmQh8iC1Q8OC6ErlqF7f7pMTlDoUYH5pnJH5WBEJ7EtL+1r5A==
X-Received: by 2002:a05:600c:4693:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-43d8506c88cmr32607495e9.24.1743092967965; 
 Thu, 27 Mar 2025 09:29:27 -0700 (PDT)
Received: from [192.168.1.38] (i5E863BED.versanet.de. [94.134.59.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82f32573sm41921385e9.32.2025.03.27.09.29.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 09:29:27 -0700 (PDT)
Message-ID: <2723a871-b7fe-4a4b-b898-b93b750167f2@linaro.org>
Date: Thu, 27 Mar 2025 17:29:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/29] efi: arm: Avoid enabling caches when running
 under EFI
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250215032254.4121030-1-sjg@chromium.org>
 <20250215032254.4121030-17-sjg@chromium.org>
Content-Language: en-US
From: Caleb Connolly <caleb.connolly@linaro.org>
In-Reply-To: <20250215032254.4121030-17-sjg@chromium.org>
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
> The previous bootloader has already set up the cache, so don't try to do
> it again.
> 
> This fixes a crash in QEMU when booting from EDK2
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   common/board_r.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/common/board_r.c b/common/board_r.c
> index 81715397544..e7d9a3b312d 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -110,8 +110,9 @@ static int initr_reloc(void)
>    */
>   static int initr_caches(void)
>   {
> -	/* Enable caches */
> -	enable_caches();
> +	if (ll_boot_init())
> +		enable_caches();

For the sake of consistency I think this check should be inverted.
> +
>   	return 0;
>   }
>   #endif

-- 
Caleb (they/them)

