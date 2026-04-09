Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C0CF31E21
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 14:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C30378407E;
	Thu,  9 Apr 2026 16:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="InpK25Dj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F1DD84099; Thu,  9 Apr 2026 16:48:12 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 934FE83CF5
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 16:48:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7dbcd61429cso463857a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 07:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775746088; x=1776350888;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dA2BEfvSYiDFfXDP8hmBc6qmvHdhWLAahf8w4Wg9Z94=;
 b=InpK25DjCIKGfhMcrclsoLsrNGbge0ovkzmi5fE3O2yBbgbA2tvh2mwROxVrc1l4Kn
 YvUNvhhdqU9D8pRayKzobmgGOI9mLEWNxC5OC4Jai7QA4KAT21rHR5euXuoU4J9ibo+P
 LwEN/89CshtQt5UuxzaR6Zs9nyS3CpkFTKtwyhUAaxBCkGH3Ep0qJ1GXReRsxQVfqL2m
 ZtpzPxw5X15CRjpJIzekpDunaULNU8pYnCuivRw4Ba7UEJ9e1eCR02njFwk2YPK9ZEiU
 4V6IElLYGV33xvmWFMProqsdY7IndnBF85D9Dm58Gn653lB+FN2DR6fnUKroizsn3jlF
 y1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775746088; x=1776350888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dA2BEfvSYiDFfXDP8hmBc6qmvHdhWLAahf8w4Wg9Z94=;
 b=V5yUrhCojNgyEARz3758CUm9IFrkk+NXnR1e2iyAguKQluGEeyCCWmGy8otrUEWr+Y
 fDgvaT+W3hqb+kY/jGz2/ms2AIL5+W+x96n14G3HXIBs74Zzp2KeDhHnslUoX+DdQQ3Q
 9svh6/ZcbDDuco1e+D1YKkhrP17QHO1UaH4yC3iad3ChskWGrtLDVfD/QWQL5szQng0Q
 HZGxgcJLBQl1ANvH+aczEttXnsBiLTpBf2H5JshAq1rbVTSDrU1wPV4h88AT160cu5KI
 9dYwo7Wp3PA/JX83YnN8baLfRbWA7rMM/LG80TKQC7c7vDba1V6D6cinF19DcKogn3q7
 ZOJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEzspldRp2flbQK6gLYtFEZ6fNz6iDKruoxeGXzICeV/OZjslzy40oN2YRsldzBX4Tej5RL/8=@lists.denx.de
X-Gm-Message-State: AOJu0YzTXKEDaxcFFJy9LD2TnFbp9aT5ApJ5r37Y/UUgMjLTp570TW9T
 IohDJ5vW3twE0Lq1RLFblnPg6wvAw0BkGaXyxoNMeLgaHdWlGNJwZrm5ozFAVjH/5w8=
X-Gm-Gg: AeBDiesCpXq4B7LGycc8XRSWZ8VHr8KYT4UcpUmttRbDCoci2qjkPbzhw4DkTWjGNTT
 Z/WrrBfHQkFwup920HOjCapXrbnlXVuBxc2HQ/T5TbCck2QOOHh1NnBueFx2tC8d317mJlHOUCg
 kovtPr7rMb/rG6UT5fdAUU0l6d8psI1gQlE8xNW+xWoXFCTzwE0Hf9wjQEI6ePeY/0bF8pnhdlt
 V9c1YWPPeTkDjSS7+IVbw9/hmsxrZkTXpmsn0tJCbkAClkqFPrS2PQlP6MF+QsBb96d8o3ZMREo
 +OcI+7e7fCpM+YLxs9papyFWXHGeFm9s2o32Br9muCpq8M31UjrzqLMVXvkllXroK8cFQttChlJ
 Sk8kBZ0CG7qGYw+rWM57nkVtp+Z40Of348cWdblyjGv5aOTZkTS+HYWwzsaYJagtT2DVs7YIKEv
 Os8WUHetcbS6zutxRDRPzDU0EzWqn1NdY9ibq3gHzukvxNfPl7YMG+8OuXycxQMvbnEaQaz1+yk
 g==
X-Received: by 2002:a05:6830:82ab:b0:7d7:f146:873a with SMTP id
 46e09a7af769-7dc16ded8demr2247450a34.2.1775746088293; 
 Thu, 09 Apr 2026 07:48:08 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:a548:cf0c:d054:fd01?
 ([2600:8803:e7e4:500:a548:cf0c:d054:fd01])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbfc1cb79esm4940415a34.15.2026.04.09.07.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 07:48:07 -0700 (PDT)
Message-ID: <0d32e594-8cca-4d59-b838-442ce2cad394@baylibre.com>
Date: Thu, 9 Apr 2026 09:48:06 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] boot/fit: fix misleading comment
To: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 James Hilliard <james.hilliard1@gmail.com>
References: <20260409-boot-fit-fix-8-byte-alignement-for-overlays-v2-1-32a7878e134a@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260409-boot-fit-fix-8-byte-alignement-for-overlays-v2-1-32a7878e134a@baylibre.com>
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

On 4/9/26 8:15 AM, Julien Stephan wrote:
> When load address is specified but set to 0, we ignore it and load in
> place instead. The current comment is misleading, so update it.
> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> It turns out that the else is not useless. The comment associated to it,
> was misleading, so update the comment instead of removing the else
> branch
> ---
> Changes in v2:
> - update comment instead of removing else branch
> - Link to v1: https://lore.kernel.org/r/20260324-boot-fit-fix-8-byte-alignement-for-overlays-v1-1-257b132b6bda@baylibre.com
> ---
>  boot/image-fit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/image-fit.c b/boot/image-fit.c
> index 067ad236081..2d2709aa5b1 100644
> --- a/boot/image-fit.c
> +++ b/boot/image-fit.c
> @@ -2282,7 +2282,7 @@ int fit_image_load(struct bootm_headers *images, ulong addr,
>  		printf("   Loading %s from 0x%08lx to 0x%08lx\n",
>  		       prop_name, data, load);
>  	} else {
> -		load = data;	/* No load address specified */
> +		load = data;	/* load address specified but set to 0 */

It would be even more clear to me if it said something like:

"fit_image_get_load() succeeded but it set load address to 0".


>  	}
>  
>  	comp = IH_COMP_NONE;
> 
> ---
> base-commit: f0000b4a57e9edf8ff8454b9056d767466dff57f
> change-id: 20260324-boot-fit-fix-8-byte-alignement-for-overlays-381b0a17bf4e
> 
> Best regards,

