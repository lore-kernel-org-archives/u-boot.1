Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8609C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:58:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A3F481951;
	Tue, 25 Mar 2025 15:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Ncb7KHNM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB42181B42; Tue, 25 Mar 2025 15:58:49 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8459681026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-391342fc148so4003464f8f.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742914726; x=1743519526; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=TnIKc86Y5Fr9O8RUMeuEAcd95HTkivzADBSLRSBixJs=;
 b=Ncb7KHNMcp33jDHo5MIyte6tdzeTlC+KpOu29qi0FrrAd6ziYQwMsq2ffZeBp+uDFu
 sEAcDAFNBpofy6xnQU07zia1XA4b9nlvcrOifkg5O0b/KZcnZyB0/jNP9lV5RVsJyZYX
 jm9iQy9j2vjxfmGJdvo6P1WfadiI9RuPkU4pfrGcPaYC4AkF7f7DVPRfwV8ns0kY6QPy
 emP/C4BcJXkCuhO7RSONfnedNYCJFGLMJ5AAhkl5ILu3RiEEU0sIKwWUY06ijXlYrcdz
 enjWXaefdkhlILjgvDAzPebfHvOb1RDbUXeiRku0uPWkDGUluYQjP514wc5GzMp+a03n
 0tOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914726; x=1743519526;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TnIKc86Y5Fr9O8RUMeuEAcd95HTkivzADBSLRSBixJs=;
 b=gNawQGqWDae2nGL7NM4C2ROMe4qYvfY0y1MBHHzSXnj0uFWcdUiF9rDZPNe2SQxqlO
 C1yyQvSXZi6FaW7AglmLKH5AnRROIe2dE3g4nPL2482Snb9J4rkyvdliNtwfgyBlzmmA
 KOMO6nb6/MYRWEg6Or5diiEFZrPvc+8XbBXWxtsm/WROuy9E+TuMsBguRTNT9vnQQ5YW
 Eksb+rE8Jyj9ed51IEqb6l4b7LMHdlYydkNfys78Nn485bpTsAW7SksSqqUYLnb+GouX
 KNa50pTtt8rxFVWNSpSg9MLk97T67ueVqIvsmLSJUBn0b5OfCPAlnV+UfYGj8za44tGY
 1+YQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsx6nI79jbbwUhKCJ2wDO+y5EKTvB6tzCG/NW5sjLg76kA1Rt86tn7EGUXYoFGoP07bUeKV98=@lists.denx.de
X-Gm-Message-State: AOJu0YzUrxSOvXKcbbAYTQg3ZRb/1H9du5qsTrJy17YrVV7M94av5Juv
 D5yxGkzTk445xDl4fgw9B6e5FUfekCKi4ftpA3ztItZtU2BvbDJ2t7534d/EGCo=
X-Gm-Gg: ASbGncslJJODzmlrHwqbOV5Zjo5aEZnzP7f4kOnJNi3ZUtfc6a4+bhL6YwbJSCK7bHm
 QOfs2Rff0iIgfWlKTDHXg6EZst4DOaWgDHfRYY8S18Rw9JGyWJ6s36DzzVDEAkFk+j0LGcbfjfs
 MAvm80yVrsxuuakbm94kQPIHu2CG9BRwHQqWJ66Y6g4xE3OzM1UcGMAUj/mnkvAK9K1Y70+c4cr
 9GeVmaHkRNy3heRuVmaw/up80ev5zJo7OX0qTWJ8f3HHTatrckQ4bcTBiUSxZ8+HKT8O1BskXal
 HC4CKvmclX0H3v533T3i4ICB8R9JcKHQNlJY3yL4xQ==
X-Google-Smtp-Source: AGHT+IGU+HKOlnsXneZutW50N5fPnXSPmFDcvoW9drfpQs9ReWmeBnJF7ObHbZWKTR4xNYD/Jj0BwA==
X-Received: by 2002:a05:6000:2cd:b0:391:39fb:59c8 with SMTP id
 ffacd0b85a97d-3997f90d929mr19292530f8f.25.1742914725876; 
 Tue, 25 Mar 2025 07:58:45 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e65casm14164421f8f.69.2025.03.25.07.58.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:58:45 -0700 (PDT)
Message-ID: <1d190da6-df41-4232-9810-27d58361ec95@suse.com>
Date: Tue, 25 Mar 2025 15:58:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] x86/acpi: simplify updating header checksum
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Fiona Klute <fiona.klute@gmx.de>, Martin Stolpe <martinstolpe@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Moritz Fischer <moritzf@google.com>, u-boot@lists.denx.de
References: <20250321232121.251800-1-heinrich.schuchardt@canonical.com>
 <20250321232121.251800-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 xsFNBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABzSRNYXR0aGlhcyBC
 cnVnZ2VyIDxtYnJ1Z2dlckBzdXNlLmNvbT7CwXgEEwECACIFAlV6iM0CGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheAAAoJENkUC7JWEwLx6isQAIMGBgJnFWovDS7ClZtjz1LgoY8skcMU
 ghUZY4Z/rwwPqmMPbY8KYDdOFA+kMTEiAHOR+IyOVe2+HlMrXv/qYH4pRoxQKm8H9FbdZXgL
 bG8IPlBu80ZSOwWjVH+tG62KHW4RzssVrgXEFR1ZPTdbfN+9Gtf7kKxcGxWnurRJFzBEZi4s
 RfTSulQKqTxJ/sewOb/0kfGOJYPAt/QN5SUaWa6ILa5QFg8bLAj6bZ81CDStswDt/zJmAWp0
 08NOnhrZaTQdRU7mTMddUph5YVNXEXd3ThOl8PetTyoSCt04PPTDDmyeMgB5C3INLo1AXhEp
 NTdu+okvD56MqCxgMfexXiqYOkEWs/wv4LWC8V8EI3Z+DQ0YuoymI5MFPsW39aPmmBhSiacx
 diC+7cQVQRwBR6Oz/k9oLc+0/15mc+XlbvyYfscGWs6CEeidDQyNKE/yX75KjLUSvOXYV4d4
 UdaNrSoEcK/5XlW5IJNM9yae6ZOL8vZrs5u1+/w7pAlCDAAokz/As0vZ7xWiePrI+kTzuOt5
 psfJOdEoMKQWWFGd/9olX5ZAyh9iXk9TQprGUOaX6sFjDrsTRycmmD9i4PdQTawObEEiAfzx
 1m2MwiDs2nppsRr7qwAjyRhCq2TOAh0EDRNgYaSlbIXX/zp38FpK/9DMbtH14vVvG6FXog75
 HBoOzsFNBF3VOUgBEACbvyZOfLjgfB0hg0rhlAfpTmnFwm1TjkssGZKvgMr/t6v1yGm8nmmD
 MIa4jblx41MSDkUKFhyB80wqrAIB6SRX0h6DOLpQrjjxbV46nxB5ANLqwektI57yenr/O+ZS
 +GIuiSTu1kGEbP5ezmpCYk9dxqDsAyJ+4Rx/zxlKkKGZQHdZ+UlXYOnEXexKifkTDaLne6Zc
 up1EgkTDVmzam4MloyrA/fAjIx2t90gfVkEEkMhZX/nc/naYq1hDQqGN778CiWkqX3qimLqj
 1UsZ6qSl6qsozZxvVuOjlmafiVeXo28lEf9lPrzMG04pS3CFKU4HZsTwgOidBkI5ijbDSimI
 CDJ+luKPy6IjuyIETptbHZ9CmyaLgmtkGaENPqf+5iV4ZbQNFxmYTZSN56Q9ZS6Y3XeNpVm6
 FOFXrlKeFTTlyFlPy9TWcBMDCKsxV5eB5kYvDGGxx26Tec1vlVKxX3kQz8o62KWsfr1kvpeu
 fDzx/rFpoY91XJSKAFNZz99xa7DX6eQYkM2qN9K8HuJ7XXhHTxDbxpi3wsIlFdgzVa5iWhNw
 iFFJdSiEaAeaHu6yXjr39FrkIVoyFPfIJVyK4d1mHe77H47WxFw6FoVbcGTEoTL6e3HDwntn
 OGAU6CLYcaQ4aAz1HTcDrLBzSw/BuCSAXscIuKuyE/ZT+rFbLcLwOQARAQABwsF2BBgBCAAg
 FiEE5rmSGMDywyUcLDoX2RQLslYTAvEFAl3VOUgCGwwACgkQ2RQLslYTAvG11w/+Mcn28jxp
 0WLUdChZQoJBtl1nlkkdrIUojNT2RkT8UfPPMwNlgWBwJOzaSZRXIaWhK1elnRa10IwwHfWM
 GhB7nH0u0gIcSKnSKs1ebzRazI8IQdTfDH3VCQ6YMl+2bpPz4XeWqGVzcLAkamg9jsBWV6/N
 c0l8BNlHT5iH02E43lbDgCOxme2pArETyuuJ4tF36F7ntl1Eq1FE0Ypk5LjB602Gh2N+eOGv
 hnbkECywPmr7Hi5o7yh8bFOM52tKdGG+HM8KCY/sEpFRkDTA28XGNugjDyttOI4UZvURuvO6
 quuvdYW4rgLVgAXgLJdQEvpnUu2j/+LjjOJBQr12ICB8T/waFc/QmUzBFQGVc20SsmAi1H9c
 C4XB87oE4jjc/X1jASy7JCr6u5tbZa+tZjYGPZ1cMApTFLhO4tR/a/9v1Fy3fqWPNs3F4Ra3
 5irgg5jpAecT7DjFUCR/CNP5W6nywKn7MUm/19VSmj9uN484vg8w/XL49iung+Y+ZHCiSUGn
 LV6nybxdRG/jp8ZQdQQixPA9azZDzuTu+NjKtzIA5qtfZfmm8xC+kAwAMZ/ZnfCsKwN0bbnD
 YfO3B5Q131ASmu0kbwY03Mw4PhxDzZNrt4a89Y95dq5YkMtVH2Me1ZP063cFCCYCkvEAK/C8
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250321232121.251800-4-heinrich.schuchardt@canonical.com>
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



On 22/03/2025 00:21, Heinrich Schuchardt wrote:
> Use acpi_update_checksum() for updating ACPI table header checksum.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/x86/cpu/apollolake/hostbridge.c |  2 +-
>   arch/x86/lib/acpi_nhlt.c             |  2 +-
>   arch/x86/lib/acpi_table.c            | 11 ++++-------
>   3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/cpu/apollolake/hostbridge.c b/arch/x86/cpu/apollolake/hostbridge.c
> index 039236df02d..284f16cfd91 100644
> --- a/arch/x86/cpu/apollolake/hostbridge.c
> +++ b/arch/x86/cpu/apollolake/hostbridge.c
> @@ -298,7 +298,7 @@ static int apl_acpi_hb_write_tables(const struct udevice *dev,
>   
>   	/* (Re)calculate length and checksum */
>   	header->length = ctx->current - (void *)dmar;
> -	header->checksum = table_compute_checksum((void *)dmar, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_align(ctx);
>   	acpi_add_table(ctx, dmar);
> diff --git a/arch/x86/lib/acpi_nhlt.c b/arch/x86/lib/acpi_nhlt.c
> index 880ef31df7d..8aae5fa5af7 100644
> --- a/arch/x86/lib/acpi_nhlt.c
> +++ b/arch/x86/lib/acpi_nhlt.c
> @@ -414,7 +414,7 @@ int nhlt_serialise_oem_overrides(struct acpi_ctx *ctx, struct nhlt *nhlt,
>   	cur.start = (void *)header;
>   	nhlt_serialise_endpoints(nhlt, &cur);
>   
> -	header->checksum = table_compute_checksum(header, sz);
> +	acpi_update_checksum(header);
>   	nhlt_free_resources(nhlt);
>   	assert(cur.buf - cur.start == sz);
>   
> diff --git a/arch/x86/lib/acpi_table.c b/arch/x86/lib/acpi_table.c
> index 3186e48d63b..b13292c4150 100644
> --- a/arch/x86/lib/acpi_table.c
> +++ b/arch/x86/lib/acpi_table.c
> @@ -173,7 +173,7 @@ int acpi_write_tcpa(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   	/* (Re)calculate length and checksum */
>   	current = (u32)tcpa + sizeof(struct acpi_tcpa);
>   	header->length = current - (u32)tcpa;
> -	header->checksum = table_compute_checksum(tcpa, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_inc(ctx, tcpa->header.length);
>   	acpi_add_table(ctx, tcpa);
> @@ -242,7 +242,7 @@ static int acpi_write_tpm2(struct acpi_ctx *ctx,
>   	tpm2->lasa = nomap_to_sysmem(lasa);
>   
>   	/* Calculate checksum. */
> -	header->checksum = table_compute_checksum(tpm2, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_inc(ctx, tpm2->header.length);
>   	acpi_add_table(ctx, tpm2);
> @@ -279,9 +279,7 @@ int acpi_write_gnvs(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   		 * patched the GNVS address. Set the checksum to zero since it
>   		 * is part of the region being checksummed.
>   		 */
> -		ctx->dsdt->checksum = 0;
> -		ctx->dsdt->checksum = table_compute_checksum((void *)ctx->dsdt,
> -							     ctx->dsdt->length);
> +		acpi_update_checksum(ctx->dsdt);
>   	}
>   
>   	/* Fill in platform-specific global NVS variables */
> @@ -330,8 +328,7 @@ static int acpi_create_hpet(struct acpi_hpet *hpet)
>   	hpet->number = 0;
>   	hpet->min_tick = 0; /* HPET_MIN_TICKS */
>   
> -	header->checksum = table_compute_checksum(hpet,
> -						  sizeof(struct acpi_hpet));
> +	acpi_update_checksum(header);
>   
>   	return 0;
>   }

