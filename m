Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8FE1C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 17:17:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DC058761C;
	Wed, 29 Nov 2023 18:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="VCV4mxd8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B3BA87654; Wed, 29 Nov 2023 18:17:04 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15E1A87257
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 18:17:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4795840337
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 17:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1701278221;
 bh=t4u6WMwIWaZ5vxN+EVHxmx5sDyqSUPulZW7mXw72+vk=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=VCV4mxd8w8jKylAsz9scFKlgrO+mLkVaytpGdY/swU+t7aRjgkKUnilr+TDt+ODoe
 XCrAXwMtjbw4Gp/w6mY9ODQVLY40mcUEw57BJER3QMr02JzsMxNYmckO82JiqJxhuR
 6KsXdsPhgED6kfHPPZtJT3EgS7TE8yL6r6INLMEBBlzyqGVaEuLaeM3f/WHYVGpxX5
 tsp4a6h5Oxgyz6L//OMNyWdTxccJ80QOfIxAlRLdde1voFVb5RrVzhH+x4zKfnYrXO
 QJuJ80UrNobGL3DLsf8yPnD4RUkGP7UOHdhiuUcWKAsFPZfUk/lHuTnYlLtXkOjENh
 gBpFXL/td4c9g==
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2c87972a358so888581fa.2
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 09:17:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701278220; x=1701883020;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t4u6WMwIWaZ5vxN+EVHxmx5sDyqSUPulZW7mXw72+vk=;
 b=dtoMFUus6tHAdQc/4aZdJXdY4gM8Y2MdZw0ChOXsWWQiiSayml3M5YKcB0oItBrTp9
 t7r93Nl9FzaEr2t6O7YDCKxU71Rk76GjC2NRWEPpCZhPzPf+lPwhfyq3VY2otD7T0zid
 BBMqqm/gzl+bVdgIZayyg8Tw5Wsc3BdNfk9gcKW3ZFofxAYAJUj4Mo3xpuXqJG9VgrhX
 8Qg3Ub1ofPB9Zmb52s1PrnOqoVuV1sHH/6Ce0pU5sqA1UqOwUwt7rjSFqnU5YcuXJ0q/
 h9Q87YDgvN5xnbhjGWCmrFx9DJuzdTreQj8lbv+WAdIeAIa2qO3kVxcVx+Ct61zY68F4
 iiig==
X-Gm-Message-State: AOJu0YyMzf8uDR5iV1PRZdtsGrGfuYZfC4169i/wpmSJHkPd6n1erf80
 EnZNlOHiWb9tYwlCF3LmFNcoLgEO9by+Xf/KiysVvP/mX+e5X9t5Dl4Dunq57VLX+KP8UUifx/I
 c02ee4JnFgwtzpZvtPYg9p31UpGv7TFg=
X-Received: by 2002:a2e:b550:0:b0:2c9:954b:7249 with SMTP id
 a16-20020a2eb550000000b002c9954b7249mr9595257ljn.4.1701278220706; 
 Wed, 29 Nov 2023 09:17:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeCsAk5J1PGpVyZa1xHsiF4xKx0xrORvhkdb+JoPd1GNNxSiOJv90k9Sa6KaEOBsicBfqZcQ==
X-Received: by 2002:a2e:b550:0:b0:2c9:954b:7249 with SMTP id
 a16-20020a2eb550000000b002c9954b7249mr9595240ljn.4.1701278220265; 
 Wed, 29 Nov 2023 09:17:00 -0800 (PST)
Received: from [192.168.123.67] (ip-178-202-040-247.um47.pools.vodafone-ip.de.
 [178.202.40.247]) by smtp.gmail.com with ESMTPSA id
 l27-20020a05600c1d1b00b003feae747ff2sm2895220wms.35.2023.11.29.09.16.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Nov 2023 09:16:59 -0800 (PST)
Message-ID: <3a272671-7c96-4644-a4ee-05257c7efb30@canonical.com>
Date: Wed, 29 Nov 2023 18:16:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] Makefile.lib: Always rebuild DSDT
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>, u-boot@lists.denx.de
References: <20211020123742.31098-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20211020123742.31098-1-andriy.shevchenko@linux.intel.com>
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

On 20.10.21 14:37, Andy Shevchenko wrote:
> The dsdt.asl is usually combined out of several files that are included
> in the main one. Whenever we change the content of any of such files,
> build system is not able to recognize them. Hence the easiest way is to
> force DSDT rebuild each time we run make.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The build process that you describe is not in our documentation.

By which defconfig is $(src)/dsdt.asl consumed? Where does it come from? 
Please, provide a reproducible example.

Would you be able to provide a documentation patch explaining how to use 
a user provided dsdt.asl file?

Best regards

Heinrich


> ---
>   scripts/Makefile.lib | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 07696e86bb54..8c3c893b398a 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -441,7 +441,7 @@ cmd_acpi_c_asl=         \
>   	iasl -p $@ -tc $(ASL_TMP) $(if $(KBUILD_VERBOSE:1=), >/dev/null) && \
>   	mv $(patsubst %.c,%.hex,$@) $@
>   
> -$(obj)/dsdt.c:    $(src)/dsdt.asl
> +$(obj)/dsdt.c:    $(src)/dsdt.asl FORCE
>   	$(call cmd,acpi_c_asl)
>   	$(Q)sed -i -e "s,dsdt_aml_code,AmlCode," $@
>   

