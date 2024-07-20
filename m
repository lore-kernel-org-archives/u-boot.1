Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEFD4C3DA59
	for <u-boot@archiver.kernel.org>; Sat, 20 Jul 2024 15:34:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53F46886B3;
	Sat, 20 Jul 2024 17:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XjC3QAfH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4812388753; Sat, 20 Jul 2024 17:34:11 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 304E9885D1
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 17:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-79f06c9c929so205586685a.0
 for <u-boot@lists.denx.de>; Sat, 20 Jul 2024 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721489648; x=1722094448; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H6OZ4KAeG5eWJU0A4kn0Leqvy9QKwFWVviE+MozWFrM=;
 b=XjC3QAfH+ugPBLaotXILn172vdkh3QT5F+/ufB3yzpv+xvzvlCLGRGyX/7CJHR2sLq
 BysEDiXecdPcXnRKoK5iH8ZcgDtDX2ti+uu/mCgvhdrrUndVS/FJZ3hidy8VT4D8mRZP
 odZuOlsvIaIf2zBbj+R8B88vLMo2ZzNa6QOlhd9YoSJMQJuRuP97bfeovKmWDjSBlTwO
 i9jqcJERqpdde86kKnJdcf87W4VvoyRbh7nMv8dYUD4w6lW63iKRxkyHhS4Dqgi1xmky
 rDfEExgh0Gg2NoldgkcQnaGLs13RRnKW41cFamtiuLROp5Yu6d88WT522sUHAAILr9q8
 8EBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721489648; x=1722094448;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H6OZ4KAeG5eWJU0A4kn0Leqvy9QKwFWVviE+MozWFrM=;
 b=jiaU690MgCrTuqLjJNnhX6d5gHVWTZuCXbBKy20piE1JuSpxZmoJZWvnQDDU8e2IYz
 o5lTRChe6XoDtaGsxcO9weyzqlGT0h6TzoQ2criRvVh5rHPmUV/05bZtLXvZIbrkId+L
 uoU4a1TYsqeTEDsx1UyZuVvO9QrkS91lgjr5D2sqUapFr7f1rNbm+c2y+whxZLehQyAW
 VDIdVN3NIqZIuOUqj5M8c6TPsv/voQbdqW7LnfdC9Lqvop8D3phWr7st34hPngrfd3RY
 Y/OCZLjWQKx1Qqh6Z2yVzk9j3cxBK0dLtfDELF1SzQ7QAwACxoq54/LIR0z/FN0+dZJF
 INhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/WJKv+ykgwGcU0l+mGXeEF9768XxbYski/cTk/8t06yvBBgtKDVhf2PUekkYp/xs+F2ZMSXjTV6sWiGiOLBVryq2APQ==
X-Gm-Message-State: AOJu0YxfimZ4JA7SHKY3Dwhq8I5OcGfoc3qUha3VewolYeEJnF1S7mvX
 /aWwWByb1eJgkQcXA2N2PKJwGPZ7OMEBEaUCTterCwrcQOpnSXSL
X-Google-Smtp-Source: AGHT+IHPc3ZeRWVoDsQNNy/NmxNV0ApDMXGCh93it7w6lRR4DBiPmSfgefwx4Z+0BJH14s5zy57iJQ==
X-Received: by 2002:a05:620a:1a95:b0:79b:bcee:d627 with SMTP id
 af79cd13be357-7a1a19759f5mr337542785a.35.1721489647915; 
 Sat, 20 Jul 2024 08:34:07 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cd2824fsm18236451cf.41.2024.07.20.08.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Jul 2024 08:34:07 -0700 (PDT)
Message-ID: <3354d01b-5994-6954-bce9-798cc6af156c@gmail.com>
Date: Sat, 20 Jul 2024 11:34:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 03/14] spl: Remove some #ifdefs in spl_parse_image_header()
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Tom Rini <trini@konsulko.com>
References: <20240720061706.2644229-1-sjg@chromium.org>
 <20240720061706.2644229-4-sjg@chromium.org>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20240720061706.2644229-4-sjg@chromium.org>
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

On 7/20/24 02:16, Simon Glass wrote:
> This function has a number of unnecessary #ifdefs so remove them.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
>   common/spl/spl.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/common/spl/spl.c b/common/spl/spl.c
> index 6f4a8bfb3f4..02567e766f1 100644
> --- a/common/spl/spl.c
> +++ b/common/spl/spl.c
> @@ -308,8 +308,10 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   		ret = spl_parse_legacy_header(spl_image, header);
>   		if (ret)
>   			return ret;
> -	} else {
> -#ifdef CONFIG_SPL_PANIC_ON_RAW_IMAGE
> +		return 0;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SPL_PANIC_ON_RAW_IMAGE)) {
>   		/*
>   		 * CONFIG_SPL_PANIC_ON_RAW_IMAGE is defined when the
>   		 * code which loads images in SPL cannot guarantee that
> @@ -319,10 +321,9 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   		 * is bad, and thus should be skipped silently.
>   		 */
>   		panic("** no mkimage signature but raw image not supported");
> -#endif
> +	}
>   
> -#if CONFIG_IS_ENABLED(OS_BOOT)
> -#if defined(CONFIG_CMD_BOOTI)
> +	if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI)) {

Maybe this should be IS_ENABLED(CONFIG_SPL_OS_BOOT) since this file cannot be compiled except in SPL.

>   		ulong start, size;
>   
>   		if (!booti_setup((ulong)header, &start, &size, 0)) {
> @@ -336,7 +337,7 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   			      spl_image->load_addr, spl_image->size);
>   			return 0;
>   		}
> -#elif defined(CONFIG_CMD_BOOTZ)
> +	} else if (CONFIG_IS_ENABLED(OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTZ)) {
>   		ulong start, end;
>   
>   		if (!bootz_setup((ulong)header, &start, &end)) {
> @@ -350,11 +351,11 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   			      spl_image->load_addr, spl_image->size);
>   			return 0;
>   		}
> -#endif
> -#endif
> +	}
>   
> -		if (!spl_parse_board_header(spl_image, bootdev, (const void *)header, sizeof(*header)))
> -			return 0;
> +	if (!spl_parse_board_header(spl_image, bootdev, (const void *)header,
> +				    sizeof(*header)))
> +		return 0;
>   
>   #ifdef CONFIG_SPL_RAW_IMAGE_SUPPORT
>   		/* Signature not found - assume u-boot.bin */
> @@ -366,7 +367,6 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
>   		debug("Raw boot image support not enabled, proceeding to other boot methods\n");
>   		return -EINVAL;
>   #endif
> -	}
>   
>   	return 0;
>   }

Reviewed-by: Sean Anderson <seanga2@gmail.com>
