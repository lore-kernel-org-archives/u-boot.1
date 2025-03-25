Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58CF6C3600B
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 15:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5B7D810E8;
	Tue, 25 Mar 2025 16:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="D702z3nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 039D981026; Tue, 25 Mar 2025 16:03:13 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65AA081026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 16:03:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3913fdd003bso2922585f8f.1
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742914990; x=1743519790; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Nyb65gLikmAtUIUWVqy10fERI0k/rBq77aDUQ5hB45Y=;
 b=D702z3nWU2ZZ3s6TOHdKNswsaGXpbtZgd8Aeqz1R+Ark64kze848iMMWPTkoABMTYu
 wgYR3RNGj9hF1ITTEGI9wulRrwEfrLAkjzFkU6ZtjOea8W49i0KwEsDRUCawNDlOZwDc
 HDWl0Nu6/Zb67IJ/B988FbSdLoarxj3nhXXh1k+O95maNJG4ael1mRnd4tB+Gmx98qhX
 rLKb2rQ3jPOvOVm8dbNipGATMKSB4UOhqc8Th+Q8aWxjOY/E5t/8Qr9O1a3hLWjTt+f1
 6jELwegeK+7/aMbrEB36La0qgpTukuDDJJEfoVW6P/BZbuXYS+dkjMPqNK2u25MwocQH
 oYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914990; x=1743519790;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nyb65gLikmAtUIUWVqy10fERI0k/rBq77aDUQ5hB45Y=;
 b=p74dcR63AbP1Zps/AoSo8H9e/00zBrs77uqy5ViLf3nIcz3D7zKr09YSzd/4WvYfWn
 VvnsHZOBy5/zCmaAc5C7mpB/9+C0e4cko1cYNNWgAT3R15lp69WSLxh75zwU2/CHaHje
 fPtK5iF2lPYMizTS04SBhOpH8hmVcnisarPzwW9GgkErtpcKXyj2M97JUhiUqZJDsjbd
 h6ZZycqnU7ZSsrPkHXwCBnc5uio/BqVrMupEVBzleOQ/ICeGR4eakuTl3azgblaxsp3l
 qIZk5CvYYxZgSHSafuQHsmU7PwbB9NQiJaIj6WpXtZ9CvAb+8MSSTdIUsVitQ+vnLxvZ
 FtGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2m8YxULzfEXaHKHXH5CamMt1S7B8JF9AjYuYHcxTY6O9jSwRc8WZZuw9/dQ1MXj4Gmku+ZO0=@lists.denx.de
X-Gm-Message-State: AOJu0YxauOqwwX5Ex5aJCeMl/h2dHzu3k+Eogd5Vn29Yge8yiZSV96vS
 +UJA8KkiGz11os8S/eR6p9PV7kArQpAO+9jwMk0GjdBdkYXzqa5gjPiG6u2No2w=
X-Gm-Gg: ASbGncv+dGn0qxy5CseFxafLoTE+mOBOe3mEzKxH1Imo4SpVVkNc5BaB1yCCq6AcA9W
 35R3YXYeFktjuU13ww6Hy6bNlaqaSm5n+S90hRDqdLAUPYnrbxeJ7+7YD6AObFzUDfZ/upIGLQa
 UmKk+E9kbPYGVtZjLKTBD4jZkPSd2VLX3VYvprvCD6sOHkydENwbOBgcCYoPfz8/Qx1KPsgtDCH
 +dVGDR6uAMRtWfMFAa8LucDdWRK3vhe/4cVpzEQ6uF2pq2ZrBsEjC+XbJWB8b0Q2/G9032qfRoh
 a8ybTfKoZtCax+l+SEYSbKNGyyAfb8Clzuj/q88OBgkoE0eGaJWb
X-Google-Smtp-Source: AGHT+IG/k5/htPM6Ir/qZ3vxJGasEFgL+1ADOs1nNBJKrGE+Py0+SIInJA4dFZm+neV0mS1cwLBKpg==
X-Received: by 2002:a05:6000:1fae:b0:38d:e3da:8b4f with SMTP id
 ffacd0b85a97d-39acc3e1cc3mr109479f8f.0.1742914989268; 
 Tue, 25 Mar 2025 08:03:09 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e674fsm13751182f8f.80.2025.03.25.08.03.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 08:03:08 -0700 (PDT)
Message-ID: <77ee8208-b25a-4072-94c3-e8f68e3be352@suse.com>
Date: Tue, 25 Mar 2025 16:03:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm: simplify updating ACPI table header checksum
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
 <20250321232121.251800-6-heinrich.schuchardt@canonical.com>
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
In-Reply-To: <20250321232121.251800-6-heinrich.schuchardt@canonical.com>
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
> Use acpi_update_checksum() to update table header.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   arch/arm/mach-bcm283x/bcm2711_acpi.c | 4 ++--
>   board/raspberrypi/rpi/rpi.c          | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-bcm283x/bcm2711_acpi.c b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> index 79b283353cf..58f8ee232b9 100644
> --- a/arch/arm/mach-bcm283x/bcm2711_acpi.c
> +++ b/arch/arm/mach-bcm283x/bcm2711_acpi.c
> @@ -81,7 +81,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>   	}
>   
>   	header->length = ctx->current - ctx->tab_start;
> -	header->checksum = table_compute_checksum(header, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_inc(ctx, header->length);
>   	acpi_add_table(ctx, header);
> @@ -116,7 +116,7 @@ static int rpi_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   	gtdt->el2_flags = GTDT_FLAG_INT_ACTIVE_LOW;
>   	gtdt->cnt_read_base = 0xffffffffffffffff;
>   
> -	header->checksum = table_compute_checksum(header, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_add_table(ctx, gtdt);
>   
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 70d3c35499b..6ecd3eb120f 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -791,7 +791,7 @@ static int rpi_acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *e
>   
>   	/* (Re)calculate length and checksum */
>   	ssdt->length = ctx->current - (void *)ssdt;
> -	ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
> +	acpi_update_checksum(ssdt);
>   	log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
>   
>   	/* Drop the table if it is empty */

