Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE15FC35FFC
	for <u-boot@archiver.kernel.org>; Tue, 25 Mar 2025 15:01:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE36810E8;
	Tue, 25 Mar 2025 16:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CQft8LSL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B81E81951; Tue, 25 Mar 2025 16:01:21 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73AD381026
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 16:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso36691275e9.2
 for <u-boot@lists.denx.de>; Tue, 25 Mar 2025 08:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742914879; x=1743519679; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=fCamRPugi6KEfxe5irVIxQb+lsZgn9pHAi00rHuSTkY=;
 b=CQft8LSLoe7octSCDqC+sxv9zfImRoDYDITaeP+5g/Nnc109u0fUhLvWYRCLyl3BfM
 j46Ldp5qpkCRnWPvEAC29QV8ElWE773uFzGP2jHveaElHJfhgMwNGnd7Cgpw9lRXosoY
 ntpjWWpRbmzgmIKssYcwQa2XvToRlZp4FNifBrlh02ID9Ex57jbaittB+CG6uXNVVRvE
 R+bI3L4LEHZbIk3mJeBRTpOPjj02MRiyCnpK+e1ZWeBg+AMyFt3Y76QQBxcgFCbP1foe
 3X7ll5lvTTtfevLNvO7nEcmJJniIOOLmijcre026hmlQJtQ8gWiZGeCiIH75XxNSAihD
 95jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742914879; x=1743519679;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fCamRPugi6KEfxe5irVIxQb+lsZgn9pHAi00rHuSTkY=;
 b=RJbmnY52pue+WjVt9vc7sqXoYTDwULtHgjUPqRf8ljOM827wy/JVHn5XB24SE34AmO
 4n8B+qFnQwAMK9JOV97gjtjTTNARvjZlSTCnci/FDOatoD34mnhVJFbndhUPm7XmYdOW
 Jkbm06zD4i4qI1wBGpE/mH8SG50JxMJ0T8WzQsV+A25i+wUObxQT7cbTZ8yy/kg4NWjX
 yGWQiLGSRr0/xSwB5INLYNqillTIKAE9dnyTavFcxiOJnHhJtBW7wTAE+jyiZd+BkY4J
 INcusA5cdUGfWxKDcvfpcUxUNL1CUrIPKN0qElBi9iGxHWjv62QN2DEFmZg818EFo2G5
 ibtw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+U/yMxmofQ7jiGuMiGbP25+ycfw6CROTFol1rVorQSkFIzJGWZLK6MpBw9xc5xxpyD8PlHQs=@lists.denx.de
X-Gm-Message-State: AOJu0YzJXPD0YkzVCRHKgkQRhPh2P/KSM6/HPLzDO0945GO6E5gDEd9D
 5ZDBnAUG2UunywQO/GQW5eSnK5qYMn6VxwYcyxkg48IUPXhPenzJef7TUYMX1mE=
X-Gm-Gg: ASbGncub1mYvlVAsHWRKk2dehMo/YyqQCCbEwpAoqQXJwXwWOyvdfAYJR9g2cgk8KVP
 6Key96ZxKC7Nyc/UgkPxKhi1KeC4dkATD7T6RtQz58lXqOx8lms7KK/deB0kK9AkkuHWoWtUoG2
 nGdiC+fHj3j1LXRZBnAo/UMV8o7NrpVk+dA/IARoJ1YlZh+pddvFxDQXSfDyWN1LWtvbUoNa9DI
 KPbw6x7kC1tv39lVQYnw37r77Ae4nPhzMbUSjgUosCMXSziSrNGwBzRWeApeGhRmmHZI6W8dbBO
 /UIYGO28ZGmS5fADkUvJpsHm+fs4zhkzzQwUfqDwpg==
X-Google-Smtp-Source: AGHT+IF07rhglLABWvM98Aw2YsFuYL88qrhIW5Ql5nm0y4Q9N5nHhO5zwNcbIRUWrlBsQTjTJAGrng==
X-Received: by 2002:a05:600c:5890:b0:43a:ed4d:716c with SMTP id
 5b1f17b1804b1-43d510f851amr118225325e9.22.1742914878488; 
 Tue, 25 Mar 2025 08:01:18 -0700 (PDT)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efdedsm14086054f8f.96.2025.03.25.08.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Mar 2025 08:01:18 -0700 (PDT)
Message-ID: <736163d2-ef55-4793-aeab-fce6b55f0366@suse.com>
Date: Tue, 25 Mar 2025 16:01:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] qemu-sbsa: simplify updating ACPI table header
 checksum
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
 <20250321232121.251800-5-heinrich.schuchardt@canonical.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250321232121.251800-5-heinrich.schuchardt@canonical.com>
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
>   board/emulation/qemu-sbsa/acpi.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/board/emulation/qemu-sbsa/acpi.c b/board/emulation/qemu-sbsa/acpi.c
> index ba85e08fc7d..7e4c55cc818 100644
> --- a/board/emulation/qemu-sbsa/acpi.c
> +++ b/board/emulation/qemu-sbsa/acpi.c
> @@ -133,7 +133,7 @@ static int sbsa_write_gtdt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>   	gtdt->cnt_read_base = 0xffffffffffffffff;
>   
>   	// FIXME: VirtualPL2Timer
> -	header->checksum = table_compute_checksum(header, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_add_table(ctx, gtdt);
>   
> @@ -181,7 +181,7 @@ static int acpi_write_pptt(struct acpi_ctx *ctx, const struct acpi_writer *entry
>   	}
>   
>   	header->length = ctx->current - ctx->tab_start;
> -	header->checksum = table_compute_checksum(header, header->length);
> +	acpi_update_checksum(header);
>   
>   	acpi_inc(ctx, header->length);
>   	acpi_add_table(ctx, header);

