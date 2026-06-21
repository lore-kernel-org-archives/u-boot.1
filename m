Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7125CD98F0
	for <u-boot@archiver.kernel.org>; Sun, 21 Jun 2026 08:26:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 376FB848DC;
	Sun, 21 Jun 2026 10:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="gHCYVQEy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 31D6C84901; Sun, 21 Jun 2026 10:26:04 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D5BC83FEE
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 10:26:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 9F02B3F290
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 08:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1782030361;
 bh=dfOxjYYH5XUggYC+wRhkdyaKrxlCx2Jlh2Z5OcK9b40=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=gHCYVQEy7o6NmGwrVdFbdyGXakDkjMWOIxGlzUcNSIzRbzPyS2VmKAh5g8omyXJFt
 d89Io6erP7EBDLLgSlckcVHMzUnwQ/ob3KOmbY2o+oqBrqXFOabWXLwS3CCJFqA6Uf
 OOTo8ZyT1Sbv+unWR4rmHb/m7eTuL87NcVn57WFJpDmryx7sFVYO+J20ZB9Oo2vQwZ
 jSNXOGZxm/cvufcpzGbY1i16iUd5ahT8ABDxvjiUF4B6dW0LcjD1CIV5eAOYNhYKff
 Q7OZ+rhkRsUkNi8upvt7/mLBOGwiYlNfwJyxwaneVTcXERIOcgKX/4mimBuwMO3ccZ
 +KRNeEaoIai+5d1sINcM3L4VUA5W6zsyIxhLl7M9iGKzGVl/Mz4LvMOFZipe/3IvS9
 KrUgPndsd/1FAtMhID18vGp3iA0O3TnAkyRhpjcgnBx0TSVRkmjYl3DzVv5IdEQ8Vl
 8BQF+Gi/46N1cMvynIwzKtBNEgPPmwyUJpbB8z8fwdMu0jjlVeWslqY4aS3TYC9Nyr
 TyySesqcW+br1k2obxKS8WwAs2ui9cAA+I4fbL57J0CgFOM3g4MBMQyIMZv/sPkQ2O
 SqPN4yH0TCKLKa//8QQeEKi03ECcx9DP3WKbb5OKFd+W4b9GT7fCDg0HoAdqvluAW1
 y5tAWMdtYPiwWcN774JhBV2A=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b61243easo42570215e9.2
 for <u-boot@lists.denx.de>; Sun, 21 Jun 2026 01:26:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782030361; x=1782635161;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dfOxjYYH5XUggYC+wRhkdyaKrxlCx2Jlh2Z5OcK9b40=;
 b=iUM+3RWrhLKX1WewIKyN+qXvlg6riSONu+X7apXUhyiEnqioUrBul7ufLZliprHSJ2
 R1q5acpAHT7KkLACpliUtsxhUfmsoQ8AIZTIUvQUPwu8cy4OSIXQdfVC9kK4v2xTA0dL
 v8G5B7Ttzliw2nIvWUtfpj/d1GQ7ZlEUBOUItqHBJ8rlCOX3OHuj4XzSzUP8ZorYwPfW
 2NixKLR80HSJz6Nmg8UQJRnLIcGAnBpJ4Zsdq/RZ6ED3cmmdqcgSHsqO58gH33pWZieE
 esfFFpppnu2KDJYGisgKszp9s/55aFCDFjcpgljVZUXey5VSC8z3sJd3lztKvW5gWSKq
 0ckg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4QZQ2x95A9gynmRhYY1WM0GrKRV0WLl9dZ9cbTf0jJv/azGSivcMx9r52davPZYui+/SGg40=@lists.denx.de
X-Gm-Message-State: AOJu0Yz53of05O77Yx1sTTVJsBabcgCi6OVaWIObChnI6Qe5Z7JrTg+L
 pBsPF4wGs/+zSM90p3LJLqdToprJVqtnq7siXoWFScxZKoUANGnZXG6HssPQ2biTDAtqrlTWMZB
 zBx5yQolwbhT6O2vm9r21Xe3fMTlJAbh8D8lgZi2tHIvZBLv1oiFR91EoK2Q2SyzwOrSNvKo=
X-Gm-Gg: AfdE7clzBtN4vQM7VDc9aU38PWAPk5+JuaFW6I72XD159PxK4zBcwO+lgB6XwczSY97
 TBUGXTaaCmvfLasi/JrMbVo09NEK8vloJFOh1ffn3zfxDP6HtYHcRZTh0M1K/nkCsKdZdZ96XSt
 VZrRAncxadv+7EK8ym57e/VGU5DLABDOjKpv+VG2430nos379FKA1Afc76KlIv/v+ZuibSVPii0
 2sm07hvB+664xiNEmbaBAQScbrAR6zusVWwIbMYJ0jpcjTRmTuR2kW2gq+Z5uJclOAdhk4W1Zt1
 nV/wCYxhPU/Ma81hTrnKqkN1512IkOLs65KlUumz+AqLA/jTH17C90VmgAsknR+5NeB5n2D9eS3
 /91Q/aJPt57AVNIXZ5PMOFTvZ8SyErnVIzVCvb2rmIk690aLDwCq0k+WjZNhTOfOOlASDgdA0tf
 sr7MEtpF4ckqk2uAL0njuv883TZAzC/HrIuyY=
X-Received: by 2002:a05:600c:1f92:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-49240eb1519mr163927695e9.34.1782030361163; 
 Sun, 21 Jun 2026 01:26:01 -0700 (PDT)
X-Received: by 2002:a05:600c:1f92:b0:490:c2a3:1781 with SMTP id
 5b1f17b1804b1-49240eb1519mr163927505e9.34.1782030360846; 
 Sun, 21 Jun 2026 01:26:00 -0700 (PDT)
Received: from ?IPV6:2a02:3035:674:fdd0:98a6:6c83:9a6a:7e39?
 ([2a02:3035:674:fdd0:98a6:6c83:9a6a:7e39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm207739345e9.0.2026.06.21.01.25.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2026 01:26:00 -0700 (PDT)
Message-ID: <c47dbdc5-96fb-4525-b5d0-fc5836407d58@canonical.com>
Date: Sun, 21 Jun 2026 10:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] efi_loader: fix memory leak in efi_var_collect
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260619083830.128164-1-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20260619083830.128164-1-ilias.apalodimas@linaro.org>
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

On 6/19/26 10:38, Ilias Apalodimas wrote:
> Barebox has now ported some of the UEFI code. In the process
> they found some bugs.
> 
> In this case when the variable buffer is too small, efi_var_collect()
> returns EFI_BUFFER_TOO_SMALL but doesn't free the allocated 'buf'.
> 
> Fixes: 5f7dcf079de8c ("efi_loader: UEFI variable persistence")
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

> ---
>   lib/efi_loader/efi_var_common.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/efi_loader/efi_var_common.c b/lib/efi_loader/efi_var_common.c
> index d63c2d1b1cd8..e51b21fe0b0d 100644
> --- a/lib/efi_loader/efi_var_common.c
> +++ b/lib/efi_loader/efi_var_common.c
> @@ -446,8 +446,10 @@ efi_status_t __maybe_unused efi_var_collect(struct efi_var_file **bufp, loff_t *
>   		efi_status_t ret;
>   
>   		if ((uintptr_t)buf + len <=
> -		    (uintptr_t)var->name + old_var_name_length)
> +		    (uintptr_t)var->name + old_var_name_length) {
> +			free(buf);
>   			return EFI_BUFFER_TOO_SMALL;
> +		}
>   
>   		var_name_length = (uintptr_t)buf + len - (uintptr_t)var->name;
>   		memcpy(var->name, old_var->name, old_var_name_length);

