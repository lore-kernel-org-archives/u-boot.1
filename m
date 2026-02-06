Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC666EB28F4
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 08:50:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E4538382A;
	Fri,  6 Feb 2026 09:50:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="S6bFHvNT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7093E83A64; Fri,  6 Feb 2026 09:50:23 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A036836D3
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 09:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 074FF3F46B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1770367821;
 bh=lKJtIEAj7b1a6zvL+RpivmFHAjck8Sh86sg/qc7qOE0=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=S6bFHvNTd5re7yj/ib0cFwgK1yFib/l0OkzMTRqhfYKu2cmgjy+7aEKkR7xQhY9ag
 L6ISPXuZFzF7DH1q0mS4ihZCP9tFjzG5hOl52xAZSZ9OWSsbanPDm6QxXwdxC00z9r
 DEOyAx1NbI/j6helYDv/hcBhlK8Ua2QyizTG+jKy3T/eNAcFUebM/76A4QkosGekmP
 K4EO0Bou7e00We92HjX/cnO01qyw8ZPBwEOUcjn3ECVKA36RZ2xG2xffXsUwdShdvX
 nTsppVFvON2P+Se7JHjWWACFMnSjKmXsgt6LDEDI5q008I0vlzTbGd2LFxhML7TXRi
 /8rgP3u0yN6pvQLJWbo7PzNMpiat6ZN5c44sGNt4/dwfyxXOIBPdQCQo0Z1q1xNMGq
 MBpAMM9u48V7IQCc77p2wLn1hbj4chFJBi8HcGUfWNEXAWT0FSoQfy7j6o3Q37ol1X
 hKtlEUnkAgKnPDaLFb4JOXzSy7GYfpxan78p/SAAd7lyH200klQSzR8gk3gkc6VnjL
 JJrKl/ZUNgESbtZCdpzuWxBEp8m04ISTniFSe9GQmmwsKGokRBWXyBulO1Ykzh7X3p
 DPq+zrqxjNkkbabv+EpmAHq4DStd1ZgiqghjPmCdGaHL6zkWmMTgNNTm1bPoyWaqLT
 pFpPUhiaHlm+l/YWd2jAo2kY=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-482eec44485so16178225e9.3
 for <u-boot@lists.denx.de>; Fri, 06 Feb 2026 00:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770367820; x=1770972620;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lKJtIEAj7b1a6zvL+RpivmFHAjck8Sh86sg/qc7qOE0=;
 b=NYF/fXi5WWkcZa999NWHY3C5LkdipoIA5wfEFMmLydRz4wAYSwsgq+/diigLgRfEpF
 4EcaXI8S42T2iO8fk+sujK3jyL6pAOkg2udazuy9lA4OR13s6UeRdSLvW5knJkMrCxkz
 x0V4Ryu+3G+67gT4rKAZcl+deqcVByKkwEQ98fWlohv+5cthPuEGfRPqyu8ZfcGVM9Ga
 xZu6yoEg+LQmvY3rwsEhXnSyfPuURlG+b9PxHP+yaw8rM02vp/aENT5LZPBDpU2zeB2G
 5GxJhjTy/W4T3Rx3S/D0jJW9mpY7qstueDUDB2/fi3u8VA/LDJpFibABOYfGKbnUkI0g
 kEbQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUyibR4e0KGTzWcadLhUY0t43cCBd3oiuW2KhzH2kJC+Gs27pi8FBmSYZT4hAg3lKFvwxb2l4=@lists.denx.de
X-Gm-Message-State: AOJu0YxgyUHukid3Ma4qIESqSycH7aFKEx1LzkI/v6PMmkn/s7BMEVl0
 L8UsQy0SHwzZXy8hHgheMzI7WQ2psT+h0IzuXTSdAhl9xx3F8TBKZUDjcUpjljt48V46DiRvRz+
 GW6Nv1XiBowGiavjVaDEgWcWKSd6/Q8jTO6Ardid74oolOie84U0ezjzbOSo0G+cmJzldCsY=
X-Gm-Gg: AZuq6aL2qY255PE8Gog3rEHssDiZ4wOwj+mTZyL843ESKVXWGP2kT6eFC4kOGPuHp/s
 MUi0jKTtpI5OPWz80hNhooWYtDVu7TkUZInvXMB7SHW2rsinMHtvTXJYmaUnAMQam8JgM52CmLR
 ZaMiRfBa2xfW4N/+19wXkm7w+77xNhFqofShGFAd8N2jknlTCfTFF8Xt//JGU3Yf3wySd/I55VR
 ES/t1cmo797XveclSVM+dz7cnYoZ4HBNfjurVZ8Q/f0M9hoBiJ2Xpc2HU1glG9LabvVw1NGeFxZ
 F8EB0xJ1Z/VCpyKPlW/PBlKaCbwFst/qLXGVro90fdqYvWyaDR6Tq6F7ZasSXkGtGlsvA0Iw0EG
 Ka9LEEB9kidSlo5yHEVcErORjInwgLUgUNwXynO3vjrX73WAkTtfLqnceerRO1s/qfxQy1V6GuY
 JoW2aBVuA=
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483201e408dmr24689875e9.11.1770367820550; 
 Fri, 06 Feb 2026 00:50:20 -0800 (PST)
X-Received: by 2002:a05:600c:4e48:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483201e408dmr24689645e9.11.1770367820178; 
 Fri, 06 Feb 2026 00:50:20 -0800 (PST)
Received: from [192.168.103.128]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d8341csm107902845e9.13.2026.02.06.00.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 00:50:19 -0800 (PST)
Message-ID: <8e51592e-cedd-4a70-b061-410900d25798@canonical.com>
Date: Fri, 6 Feb 2026 09:50:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: Improve EFI variable load message
To: Pranav Tilak <pranav.vinaytilak@amd.com>
Cc: git@amd.com, michal.simek@amd.com, Padmarao.Begari@amd.com,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260202113717.2696718-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260202113717.2696718-1-pranav.vinaytilak@amd.com>
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

On 2/2/26 12:37, Pranav Tilak wrote:
> Change the EFI variable load message from log_err() to log_info() with
> neutral wording. The previous "Failed to load" message caused customer
> confusion as it appeared to indicate an error condition.
> 
> The efi_var_from_file() function deliberately returns EFI_SUCCESS in
> this case to allow the boot process to continue normally. This is
> documented in the function's comment block but was not reflected in
> the log message level or content.
> 
> The message now uses informational wording to reflect that this is
> normal behavior when the ubootefi.var file does not yet exist.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>

Hello Pranav,

Thank you for the patch.

Please, use scripts/get_maintainer.pl to determine the addressees for 
your patches to avoid future review delays.

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/efi_var_file.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_var_file.c b/lib/efi_loader/efi_var_file.c
> index ba0bf33ffbd..f23a964a418 100644
> --- a/lib/efi_loader/efi_var_file.c
> +++ b/lib/efi_loader/efi_var_file.c
> @@ -173,7 +173,7 @@ efi_status_t efi_var_from_file(void)
>   	r = fs_read(EFI_VAR_FILE_NAME, map_to_sysmem(buf), 0, EFI_VAR_BUF_SIZE,
>   		    &len);
>   	if (r || len < sizeof(struct efi_var_file)) {
> -		log_err("Failed to load EFI variables\n");
> +		log_info("No EFI variables loaded\n");
>   		goto error;
>   	}
>   	if (buf->length != len || efi_var_restore(buf, false) != EFI_SUCCESS)

