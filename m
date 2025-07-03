Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA3AC83030
	for <u-boot@archiver.kernel.org>; Thu,  3 Jul 2025 11:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3923D82F00;
	Thu,  3 Jul 2025 13:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Y9dWbx9T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 480FD82E08; Thu,  3 Jul 2025 13:22:52 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AF8882103
 for <u-boot@lists.denx.de>; Thu,  3 Jul 2025 13:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-604bff84741so14478547a12.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 04:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751541770; x=1752146570; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tgsVS/JRxYunRTF2fBW/d0z81d8HxohvCsXOwb/j8Sw=;
 b=Y9dWbx9TrY2RDcJpAaXd5tgd7vO5ABGVFfoO+xGZaObSAEF9rZQajrVTfX4ucy2tc0
 1khY6rU4CwmgiZhzqEMwp5jve4DuCRWJ8V6gnGojBn/fHHfYmnQ2/gHFU4p+w5f/bEQr
 5FYAlTI6A35ND7xzmwrjL4dcaDMK7corxNe8D92fmoXrsuu0Frc+nK75Bo22SNvjRaAS
 hreoB97NBfN8hKYIxLlCHTX94ecGfQntC04Ikf4L50nUgaqtdnIMFyGu7Lruaws4PCAO
 SjiNroQYTAlclxoIwL1s+NMsknJ64bTftXKWVk3DcVcsvzOvVkuyBO71vLpuUOJmeyUR
 CrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751541770; x=1752146570;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tgsVS/JRxYunRTF2fBW/d0z81d8HxohvCsXOwb/j8Sw=;
 b=ceiuNuqB1a8RjoqhMok8dIN13asmrHwi8UAWU4wiy/E6EU6AWGAnhn79EctdQY5koG
 M+EVlUs9s4W3hIWi3NV5XKINZIPhhWSXhUqYlv9F8t03B91dGf85e5Ig3PiOBS9FQDr8
 zDC9pcHkhkp23EqMcbe1de5cx9Poz9zzllsCwHfyvXEEuPNrkFQ/s5Pb6DYC7s06G+bg
 7uSVO19ILBqI5RuSVQXpyjaLMvbNTSnahhi1qDYYQLUqS/il5ZJiOAOIw3xpXxGDbsNE
 IudCGpDMF5td7V2zFzyRSWgBTSWlZkSz1egM/38DqpEReRRoc+RqPxiILvyr9W5GEMmw
 X5+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/VYkpZ9thW+b9dMJWB+BgJTeQkq3KVrgdEwESjqd+NYmlNuK3BXjFWeTo10+BrDjXHcAsSb4=@lists.denx.de
X-Gm-Message-State: AOJu0Yz8lUfpe/tPNzbcenQrH47Mi3S3BvoRrEgt1xoWze06HKmcpsex
 SW6NS6T0LDQjpThxYyEd44nIGQ/mXlqSP+Ex7l3u+fy53tNS8/IZ/w4jlBUrwmuPC6s=
X-Gm-Gg: ASbGncsYCOVpyTIP2IiHIBjAfxuD12g09Ed3MdRxjP7f0ec2dVyd5lWqa8/wxzE4ZIl
 2Akm0BvmG4QU1fxHKjClAmJEed7IE7yTxBQG5gw3prOW8cgqQTfqOWNcoyZmOuvjmVx76iJTC9Y
 e4ChiAn+eBIl8PMCPttv0qA1TYxoRMXvbORrbqHElSw5Qd9gBjPM3yy6icTDv+H2/zfKCtiVhfC
 82WDraI5N1Q/1VMrwTHTKypLB6hWmjN7XSMAnK99xXgjMOJjrGd1C2d09KEoqtYbTXYg+t+p0IG
 fbWUQS4P6ppr52ZzpaPa1bbg07kKm2isf+2aUceGEBjPoh6i/lHjHH0NNe/oEIbySkYK/4RkfXW
 jomP18aIvtX0sUk4DqacD2BoDHrma+/vX3gm9Xos=
X-Google-Smtp-Source: AGHT+IH2cfnLjEKOCpbZky/vjs8hl5IfA9NaTTQyuD6zJao9SOtkdxPqF8hg6sb5tIdPug5nTZipfw==
X-Received: by 2002:a05:6402:4552:b0:60c:3c19:1e03 with SMTP id
 4fb4d7f45d1cf-60e6ccc0adfmr2199856a12.9.1751541769582; 
 Thu, 03 Jul 2025 04:22:49 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3d084.dip0.t-ipconnect.de. [79.195.208.132])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60c828bbea9sm10507548a12.1.2025.07.03.04.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jul 2025 04:22:48 -0700 (PDT)
Message-ID: <381c951a-c3cd-435d-aee5-d93a57ee6d77@linaro.org>
Date: Thu, 3 Jul 2025 13:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] arm64: initialize the frame pointer register
Content-Language: en-US
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.denx.de
References: <20250703051951.43372-1-heinrich.schuchardt@canonical.com>
 <20250703051951.43372-3-heinrich.schuchardt@canonical.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250703051951.43372-3-heinrich.schuchardt@canonical.com>
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



On 03/07/2025 07:19, Heinrich Schuchardt wrote:
> U-Boot may be compiled with frame pointers depending on defaults built into
> compilers are via explicitly passing -fno-omit-frame-pointer.
> 
> To stop walking frames it is necessary that the initial value of the frame
> pointer register is 0.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Casey Connolly <casey.connolly@linaro.org>> ---
>  arch/arm/lib/crt0_64.S | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/lib/crt0_64.S b/arch/arm/lib/crt0_64.S
> index f3f279f2c39..3ff0577e9c8 100644
> --- a/arch/arm/lib/crt0_64.S
> +++ b/arch/arm/lib/crt0_64.S
> @@ -168,6 +168,7 @@ clear_loop:
>  	/* call board_init_r(gd_t *id, ulong dest_addr) */
>  	mov	x0, x18				/* gd_t */
>  	ldr	x1, [x18, #GD_RELOCADDR]	/* dest_addr */
> +	mov	x29, 0				/* frame pointer */
>  	b	board_init_r			/* PC relative jump */
>  
>  	/* NOTREACHED - board_init_r() does not return */

-- 
// Casey (she/her)

