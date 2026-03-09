Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3AFF3C246
	for <u-boot@archiver.kernel.org>; Mon,  9 Mar 2026 12:26:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90F4983BC7;
	Mon,  9 Mar 2026 13:26:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="aQMuZk74";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B93EB83CDF; Mon,  9 Mar 2026 13:26:16 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBB7E8063E
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 13:26:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 56E503F47D
 for <u-boot@lists.denx.de>; Mon,  9 Mar 2026 12:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1773059173;
 bh=+PUh2gx1sAkGU8U8fhobF5pM5CK05cSYjY+iIA0t56I=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=aQMuZk749h7XFkcQ9eVpe5oRy8FmB5ZNnqBuCWrQpFOw4OtDoZwSg8me1ULCO3DVj
 +zZFYgjWHgv9CWi2z0YAz3OVKLpvF9+/vNX6Vv3HfoD7Msj4E8uBqdiUVTWMijdvZD
 e+V4L85PlI0Jd4zV/s2n+f8NLky4yOzH9orE+kgfb/T606v5rV79BcZ8uxht6dt7kw
 2PP9vib05o4AnDWkovwjNoR4x8OWGCV2/S/oZl2xmffOWBoZi1z+NshIVRfJ9HFcrv
 0P6GvH8VhncgAKZcoPqxY/JhRGa1PmPzxJWfoFoCbShjr4pnKr/IIsTPi35uy1sHRJ
 63u22aKItmb/CPvtXE9+r5AuWsT5uShDbkYG/tP4wQOYBqUjTaP06yNGOnTNjl9/9K
 h7L2ixxOKxtC9+KQWus14RMb1B0XsxLU8V5wxKk0KBm512BVpdJ3IULhAbpneyGNbd
 uhYh0AMSErnIX89n+2ZbM4lsEJXxpABdNW8wqdTSLNwyN0GZjSC0Qz5TgoUOJ5WskJ
 ETpJQEixymE+X2gcPN78SZYEDWSohDSj71QEUXr3vX4xmtxtY4SY0zOYYq2KcWRwDI
 42shLpQeBhHz2SC+QwKhgHmegZftoJtgoFozEjjBLvF933OrmiAppd8mZO91KBmFqz
 ihOWhdt77gtEJDBh91j+AOX0=
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so127549485e9.2
 for <u-boot@lists.denx.de>; Mon, 09 Mar 2026 05:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773059173; x=1773663973;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:user-agent:mime-version:date:message-id:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+PUh2gx1sAkGU8U8fhobF5pM5CK05cSYjY+iIA0t56I=;
 b=KcgqgQgufTDVV8Rca5djR86TGOyUNyiNhJfz8gIaJdEPvlfn8hWRlcc+434rZfPSg/
 AXJ84BgKL6jF+6ywlgVVeX3YDVjIxTF/ZuWoCifWwPMjyWgL7RvpfVQGB3VkalPoq6Qw
 r5lDnOaowi1OIZtrbAO6tyGL652Nzx0ivIuk29jbQrODhuMWX+HfNhqNQnysm+htSbvn
 dft6/OGoHfUBYaKAh1fPB/7CAVp7PqlwiEqwsC6DocXs5Ipsw+63YWiciFaFRYdJdBpq
 kiwlynfHpC12016MohSTB/sgYgY+mb9rulbZ85zrv00EedCyAumz3frvIhJs2CGLp3pe
 hwog==
X-Forwarded-Encrypted: i=1;
 AJvYcCU83v104ZmdO8IIaUGCxo0hoLQ/cmCWlUnGCLIgcjWSB1jJiMaRbkUbVYoX/THUlVlqDnshj10=@lists.denx.de
X-Gm-Message-State: AOJu0YxPVkR7uqs/RkrQPNfiL/fXbnwRaOnr8WVnuuWOuJts2AksR6il
 EMVXMTo4KyfjYTLmP2LIJJd7NQyVyyLjHxVwmwlgYUrncmR257JH0xRMxFAFRg6nSEFfCEGIj9A
 YJISkrjmBg/tnCjuItll5O9Cz1QiEeUwnx8MWt2EWUnJjOYtHCIblQak7HTPMw2GVn2s8UnU=
X-Gm-Gg: ATEYQzx+U3wMTpIZDvqq+lD21N1LxIvVGTzhgp+YDIbjUuO7K1eH/2fSS57vUm9tI3M
 u0O017m5iCxy8qXXLRGv2u0ctP1eBrh7Wkk8W/kJBvqTrJ7swP95be94Tu+372Y2R9BrwQC4WES
 g2Y6YGlG/0eKuzdllC1j6/7FD9aSlKR6IBM7EFBC3/PyRhoz/xMapxrHEWRhci6GqvhtnLzQ029
 IA+KORXgIF4LLq8iBlvhLXkwhu/ZW2J5pPBXeOiEy0DDK8DiQDeXWeZmBj3FayqM6NWJY7uqUZV
 aci65EyjcMOgbMtwmFYQdZWxopQtFUS62SLyDOt7PoeQXqzVJDFe35iwoiqi06zqNwhJJ16hUo7
 BriI0WuyaIHHoG4CkVPcRh7XhE9gxFobAbi13XnaskmKVKLgj4EMl8B3zlSEUKeW5KvaFQiXZUt
 i5ZTAmcsJJrko1x2LEmbBffMrY42E/Y5Ow1g==
X-Received: by 2002:a05:600c:4e4e:b0:485:363b:fafd with SMTP id
 5b1f17b1804b1-485363bfc84mr76505715e9.6.1773059172784; 
 Mon, 09 Mar 2026 05:26:12 -0700 (PDT)
X-Received: by 2002:a05:600c:4e4e:b0:485:363b:fafd with SMTP id
 5b1f17b1804b1-485363bfc84mr76505285e9.6.1773059172334; 
 Mon, 09 Mar 2026 05:26:12 -0700 (PDT)
Received: from [192.168.103.129]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853a59fc36sm176446765e9.9.2026.03.09.05.26.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Mar 2026 05:26:11 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <0e4786e6-5658-4317-bee2-aa2a1610df2d@gmx.de>
Date: Mon, 9 Mar 2026 13:26:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] efi_loader: export efi_ecpt_guid
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260305161349.2317130-1-vincent.stehle@arm.com>
 <20260305161349.2317130-3-vincent.stehle@arm.com>
Content-Language: en-US
In-Reply-To: <20260305161349.2317130-3-vincent.stehle@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/5/26 17:13, Vincent Stehlé wrote:
> Export the ECPT GUID, to prepare accessing it from more than one location.
> 
> The C file containing the GUID is compiled only when CONFIG_EFI_ECPT is
> set; gate the export accordingly.
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> ---
>   include/efi_loader.h             | 4 ++++
>   lib/efi_loader/efi_conformance.c | 2 +-
>   2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/efi_loader.h b/include/efi_loader.h
> index 3e70ac07055..0ebc80e0af0 100644
> --- a/include/efi_loader.h
> +++ b/include/efi_loader.h
> @@ -387,6 +387,10 @@ extern const efi_guid_t efi_guid_capsule_report;
>   extern const efi_guid_t efi_guid_firmware_management_protocol;
>   /* GUID for the ESRT */
>   extern const efi_guid_t efi_esrt_guid;
> +/* GUID for the ECPT */
> +#if CONFIG_IS_ENABLED(EFI_ECPT)
> +extern const efi_guid_t efi_ecpt_guid;
> +#endif
>   /* GUID of the SMBIOS table */
>   extern const efi_guid_t smbios_guid;
>   extern const efi_guid_t smbios3_guid;
> diff --git a/lib/efi_loader/efi_conformance.c b/lib/efi_loader/efi_conformance.c
> index 2d31800ccb8..470141af483 100644
> --- a/lib/efi_loader/efi_conformance.c
> +++ b/lib/efi_loader/efi_conformance.c
> @@ -12,7 +12,7 @@
>   #include <efi_api.h>
>   #include <malloc.h>
>   
> -static const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
> +const efi_guid_t efi_ecpt_guid = EFI_CONFORMANCE_PROFILES_TABLE_GUID;
>   
>   /**
>    * efi_ecpt_register() - Install the ECPT system table.

