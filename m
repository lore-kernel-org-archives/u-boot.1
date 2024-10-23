Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97538CFA443
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 15:42:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E9A5892AA;
	Wed, 23 Oct 2024 17:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="OkmVD10w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFDA988B0A; Wed, 23 Oct 2024 17:42:09 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CF39E892AA
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 17:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=mbrugger@suse.com
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a6b4ca29bso598817866b.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 08:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1729698125; x=1730302925; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=HDIRdKbEiJtTg+C6EkWb7VK14fbdWsWYgYeBGcBMfeE=;
 b=OkmVD10wcaUWAhJy1vjiNX+h26/SnA4dWsIqudz63aW2k0N0wzBP/T0g0Yg+5Y2x/Z
 kg/D9Igacpct9U2/3tnJ8LUTPZknv5ietKuXWyPxfqNC3yVzNLZhZ6m8h70bkwH+BfOy
 DvYikLvmm395zfDGYU5ikAbkDZkJPgvO6MTlmiLiYl6m6cqWmTXrw39ap1Nayl91u4Tx
 QPxbNjPGIexmg9x6EmEQGpdrxgEpqES84ru2aOFFqKTLCMJAR1viGMZI1N4ap+yYpUcf
 M31gdlwyR2Im0ABNnLZVvhGXpnBksGR9Lxc4vmaicmSxgyfu5Mfzn4ITCdTPLGsNtgW0
 9Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729698125; x=1730302925;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HDIRdKbEiJtTg+C6EkWb7VK14fbdWsWYgYeBGcBMfeE=;
 b=vEn8iNsdKIBERftxojbt/45esb4ylj4iw+W1KUjtjsItUqhWrDocttHXmIRgBHZ+Pr
 2lKhLGAI6bEjn22+WC+Pe3A9Bl9kuoYBJC+RumgUzSJeMNLGb9iuzRNX+Xju8j0QoSFG
 CbzhixfWjdVoiMIeOleoXJHwk+pQ+CPrz8GOUJa7C5MkBqlaPimt6MCoPvwED04SMTFR
 wEL8QUvx0+iOC7BMVTEnkB4+qRYSHX8oeptbLNEILawRP+zI1eAJ56F+1SWpTcWTAnO3
 9rrtzelvB8i4yOLarIZ4n537jWnwZVq2i/4iesgZsPs1iIeIyku+nwzS6Cu7jxgxRR+/
 /LBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/vQF8nugwLqCqPnzfpl0D0gPUnklA6qFvHjfLy1DQ+EufnnaEyNS70sT/6gkrxWunfpdTm+M=@lists.denx.de
X-Gm-Message-State: AOJu0YzaPfEWZ0SQiEpR1hdc/fMRg6JAX0YrEq5SXiq0r5ov7oU9VsLC
 3yC3DEecAR+CxPfRsN1dG+RdfFLxOwJHpRuXXMWjd4G/SsKAa1z2r8AwJjCE5Xc=
X-Google-Smtp-Source: AGHT+IENTay98Vpk8In19A+cWW1jgngU0uuuJHChwHN9b0GjZwbdmDRE8bs27YUSGkdod7kCD/LlQQ==
X-Received: by 2002:a17:906:7310:b0:a9a:6bd:95dc with SMTP id
 a640c23a62f3a-a9abf92f667mr290238266b.46.1729698125178; 
 Wed, 23 Oct 2024 08:42:05 -0700 (PDT)
Received: from [192.168.0.31] (80.224.71.185.static.user.ono.com.
 [80.224.71.185]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9a9157183bsm498734366b.143.2024.10.23.08.42.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Oct 2024 08:42:04 -0700 (PDT)
Message-ID: <5b945eca-48cb-4226-82e5-c88b1209837f@suse.com>
Date: Wed, 23 Oct 2024 17:42:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rpi: Only add frame buffer node if
 CONFIG_FDT_SIMPLEFB is set
To: Martin Stolpe <martinstolpe@gmail.com>, u-boot@lists.denx.de
Cc: Martin Stolpe <martin.stolpe@gmail.com>,
 Francois Berder <fberder@outlook.fr>, "Ivan T. Ivanov" <iivanov@suse.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Tom Rini <trini@konsulko.com>
References: <20241023131012.2445564-1-martin.stolpe@gmail.com>
 <20241023131012.2445564-2-martin.stolpe@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20241023131012.2445564-2-martin.stolpe@gmail.com>
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



On 23/10/2024 15:09, Martin Stolpe wrote:
> The functions fdt_simplefb_add_node and fdt_simplefb_enable_and_mem_rsv
> are only available if CONFIG_FDT_SIMPLEFB is enabled.
> 
> Signed-off-by: Martin Stolpe <martin.stolpe@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
> 
>   board/raspberrypi/rpi/rpi.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index ab5ea85cf9..47db441696 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -569,11 +569,13 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   
>   	update_fdt_from_fw(blob, (void *)fw_dtb_pointer);
>   
> -	node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> -	if (node < 0)
> -		fdt_simplefb_add_node(blob);
> -	else
> -		fdt_simplefb_enable_and_mem_rsv(blob);
> +	if (CONFIG_IS_ENABLED(FDT_SIMPLEFB)) {
> +		node = fdt_node_offset_by_compatible(blob, -1, "simple-framebuffer");
> +		if (node < 0)
> +			fdt_simplefb_add_node(blob);
> +		else
> +			fdt_simplefb_enable_and_mem_rsv(blob);
> +	}
>   
>   #ifdef CONFIG_EFI_LOADER
>   	/* Reserve the spin table */
