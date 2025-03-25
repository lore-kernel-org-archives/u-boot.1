Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696D0C35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 14:55:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF1A381026;
	Tue, 25 Mar 2025 15:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="BikzqbT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0445812BC; Tue, 25 Mar 2025 15:55:20 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EEED80EEF
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 15:55:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3912e96c8e8so3254510f8f.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 07:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742914518; x=1743519318; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=pOboUCTJoLM5QwIJ9VHWXu85oejuezuFN8mueblLMV4=;
 b=BikzqbT5oLx8I0r7K8aOCIh9pcm7L+W5AvCZUh2QY5J2aNqfy/AMmsD8wlX27ugFrY
 hbSs1rk3BEkAxA0b325aFZ2b70tRYMfa/AXp7dhFNq1e2kcOsu8uT6G8YH8vL6CDoWI4
 8cLatiKaRugyA5gbeYbXvqS1tCIm3q6lKkfML1aGzYdm70BrquNCvr7B0TkTqk8WhOvH
 r+LEE3a7QQaUDton5eXhucD9iA1VPXfIVC2+Ep9nOnn986gbhyvmOYjhl1S76jwTZUGh
 4VfyDryJXrGG96YyXGtBuJQZum+SkCqCx8w9MYnRY+r2xwXGFSHNA1udlBRX/jwOJXgS
 7SvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914518; x=1743519318;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pOboUCTJoLM5QwIJ9VHWXu85oejuezuFN8mueblLMV4=;
 b=HU3AM07dBACG31pt9cnttumGvFwXSL6Y8xyo2pQGidvN3DdUGeT09xP916A131x/Ck
 hGO7TT1OrJpuRRvxfRLQi8g9txSNPoc7PdiimKvW8I/YdlOpc1X1Pp7qQlHz3EdHUv0/
 6SPPDQtoX81uh5+wme5Y0GT+sDNClIg/U4Nhx1O8ajglWXTUFgOuq/XRgXsjsXylacO6
 Zvzpp/T14KAymQ8EDclgTcGEl3J9Kc9GSbacFM3Pjk20Fnr3E22iYwbGuq6djyeSkWkQ
 csSQD1XrQitgQ8CqNJQPLNCJ4vzk6hradlkTCH85PEniGeldfGBXdqf8xc91peMiRvci
 4sSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5x03ivU9bFNYZ04Dq0N/PHeUDE9Gkq6v3r0ct4XmhURDMNtD1oOMiIa3irsaQS9F/9fyTteE=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5HFn9AhacOA1aw/IurlyJwpsml9ebsaDj2l4IMcDr2mAdViRm
 jeo+kVt0oN0ifO2VsHG8JImlBQKCeC6Rjq8+LLHcVTkgvwgXmWXs580vkVBTYB8=
X-Gm-Gg: ASbGncshA8J7nYs4pvxpRrJbv2vwKMSWJiSmoEMFmQemwWEEH2JoUVZldvqTFd+bu1d
 QPVjqpvPqMebaY8nYoQsC3NnpUDw//0vDgCv5l3IHjAFo8yVG/RNs+3XHV3nLo9Elq9Gap9dBcF
 ++k+DxTAmzaGtfdlqaCHp9BvCbQyDBWMKW1pogW2gLOgB+WPKao3zYZ5jjEMs38mj0deEHchCpu
 KAQlMNiCnOPECKkY9Wxzj2q2BIrzyIt7S53xohzoVbRrZRalr7WNU6wUDOV4EFs00wxhinO1PC1
 3VVMwtjsATwI6oIanl099j17LmcyEqOmXsToYwhB8IjG7XYbUwva
X-Google-Smtp-Source: AGHT+IGP8x6pnkoaSSsz1eSwns0NNPKZLSU9Di9DXFYLu4+jdPsw2h+/oFrYyNuKlu5f8OTAzMhP0A==
X-Received: by 2002:a05:6000:1faf:b0:391:2f2f:836 with SMTP id
 ffacd0b85a97d-3997f8fa7f6mr13986044f8f.17.1742914517536; 
 Tue, 25 Mar 2025 07:55:17 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f332adsm204830025e9.3.2025.03.25.07.55.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 07:55:17 -0700 (PDT)
Message-ID: <dd76531a-ef74-47e5-a4bd-ce139a4bd86c@suse.com>
Date: Tue, 25 Mar 2025 15:55:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] acpi: simplify updating header checksum
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
 <20250321232121.251800-3-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250321232121.251800-3-heinrich.schuchardt@canonical.com>
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
>   lib/acpi/acpi_table.c | 18 +++++++-----------
>   lib/acpi/base.c       |  6 ++----
>   lib/acpi/csrt.c       |  2 +-
>   lib/acpi/mcfg.c       |  2 +-
>   lib/acpi/ssdt.c       |  2 +-
>   5 files changed, 12 insertions(+), 18 deletions(-)
> 
> diff --git a/lib/acpi/acpi_table.c b/lib/acpi/acpi_table.c
> index c0ed24984af..b5495d48a46 100644
> --- a/lib/acpi/acpi_table.c
> +++ b/lib/acpi/acpi_table.c
> @@ -195,9 +195,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
>   					(sizeof(u32) * (i + 1));
>   
>   		/* Re-calculate checksum */
> -		rsdt->header.checksum = 0;
> -		rsdt->header.checksum = table_compute_checksum((u8 *)rsdt,
> -							       rsdt->header.length);
> +		acpi_update_checksum(&rsdt->header);
>   	}
>   
>   	if (ctx->xsdt) {
> @@ -228,9 +226,7 @@ int acpi_add_table(struct acpi_ctx *ctx, void *table)
>   					(sizeof(u64) * (i + 1));
>   
>   		/* Re-calculate checksum */
> -		xsdt->header.checksum = 0;
> -		xsdt->header.checksum = table_compute_checksum((u8 *)xsdt,
> -							       xsdt->header.length);
> +		acpi_update_checksum(&xsdt->header);
>   	}
>   
>   	return 0;
> @@ -268,7 +264,7 @@ int acpi_write_fadt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   
>   	acpi_fill_fadt(fadt);
>   
> -	header->checksum = table_compute_checksum(fadt, header->length);
> +	acpi_update_checksum(header);
>   
>   	return acpi_add_fadt(ctx, fadt);
>   }
> @@ -303,7 +299,7 @@ int acpi_write_madt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   	if (IS_ENABLED(CONFIG_ACPI_PARKING_PROTOCOL))
>   		acpi_write_park(madt);
>   
> -	header->checksum = table_compute_checksum((void *)madt, header->length);
> +	acpi_update_checksum(header);
>   	acpi_add_table(ctx, madt);
>   	ctx->current = (void *)madt + madt->header.length;
>   
> @@ -374,7 +370,7 @@ void acpi_create_dbg2(struct acpi_dbg2_header *dbg2,
>   	/* Update structure lengths and checksum */
>   	device->length = current - (uintptr_t)device;
>   	header->length = current - (uintptr_t)dbg2;
> -	header->checksum = table_compute_checksum(dbg2, header->length);
> +	acpi_update_checksum(header);
>   }
>   
>   int acpi_write_dbg2_pci_uart(struct acpi_ctx *ctx, struct udevice *dev,
> @@ -549,7 +545,7 @@ static int acpi_write_spcr(struct acpi_ctx *ctx, const struct acpi_writer *entry
>   		spcr->baud_rate = 0;
>   
>   	/* Fix checksum */
> -	header->checksum = table_compute_checksum((void *)spcr, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_add_table(ctx, spcr);
>   	acpi_inc(ctx, spcr->header.length);
> @@ -759,7 +755,7 @@ static int acpi_write_iort(struct acpi_ctx *ctx, const struct acpi_writer *entry
>   
>   	/* (Re)calculate length and checksum */
>   	iort->header.length = ctx->current - (void *)iort;
> -	iort->header.checksum = table_compute_checksum((void *)iort, iort->header.length);
> +	acpi_update_checksum(&iort->header);
>   	log_debug("IORT at %p, length %x\n", iort, iort->header.length);
>   
>   	/* Drop the table if it is empty */
> diff --git a/lib/acpi/base.c b/lib/acpi/base.c
> index 8b6af2bc43a..5c755b14c16 100644
> --- a/lib/acpi/base.c
> +++ b/lib/acpi/base.c
> @@ -50,8 +50,7 @@ static void acpi_write_rsdt(struct acpi_rsdt *rsdt)
>   	/* Entries are filled in later, we come with an empty set */
>   
>   	/* Fix checksum */
> -	header->checksum = table_compute_checksum(rsdt,
> -						  sizeof(struct acpi_rsdt));
> +	acpi_update_checksum(header);
>   }
>   
>   static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
> @@ -66,8 +65,7 @@ static void acpi_write_xsdt(struct acpi_xsdt *xsdt)
>   	/* Entries are filled in later, we come with an empty set */
>   
>   	/* Fix checksum */
> -	header->checksum = table_compute_checksum(xsdt,
> -						  sizeof(struct acpi_xsdt));
> +	acpi_update_checksum(header);
>   }
>   
>   static int acpi_write_base(struct acpi_ctx *ctx,
> diff --git a/lib/acpi/csrt.c b/lib/acpi/csrt.c
> index 00927e53406..b863c644c07 100644
> --- a/lib/acpi/csrt.c
> +++ b/lib/acpi/csrt.c
> @@ -40,7 +40,7 @@ int acpi_write_csrt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   
>   	/* (Re)calculate length and checksum */
>   	header->length = (ulong)ctx->current - (ulong)csrt;
> -	header->checksum = table_compute_checksum(csrt, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_add_table(ctx, csrt);
>   
> diff --git a/lib/acpi/mcfg.c b/lib/acpi/mcfg.c
> index 8b8a5bfafae..e21fe7ce123 100644
> --- a/lib/acpi/mcfg.c
> +++ b/lib/acpi/mcfg.c
> @@ -57,7 +57,7 @@ int acpi_write_mcfg(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   
>   	/* (Re)calculate length and checksum */
>   	header->length = (ulong)ctx->current - (ulong)mcfg;
> -	header->checksum = table_compute_checksum(mcfg, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_add_table(ctx, mcfg);
>   
> diff --git a/lib/acpi/ssdt.c b/lib/acpi/ssdt.c
> index df1d739d117..41e2d3c2f6c 100644
> --- a/lib/acpi/ssdt.c
> +++ b/lib/acpi/ssdt.c
> @@ -35,7 +35,7 @@ int acpi_write_ssdt(struct acpi_ctx *ctx, const struct acpi_writer *entry)
>   
>   	/* (Re)calculate length and checksum */
>   	ssdt->length = ctx->current - (void *)ssdt;
> -	ssdt->checksum = table_compute_checksum((void *)ssdt, ssdt->length);
> +	acpi_update_checksum(ssdt);
>   	log_debug("SSDT at %p, length %x\n", ssdt, ssdt->length);
>   
>   	/* Drop the table if it is empty */

