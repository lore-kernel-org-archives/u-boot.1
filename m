Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD214C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 13:31:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D49A80EC0;
	Thu, 20 Feb 2025 14:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iuE5esL3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BAD680F5C; Thu, 20 Feb 2025 14:31:55 +0100 (CET)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB43F8007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 14:31:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5deb1266031so1717154a12.2
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 05:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740058312; x=1740663112; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CgeVf/ZApKzuaB5pwg+ePZxUp0u4gWxwOyM3G9tIsz4=;
 b=iuE5esL38jhTFJauLJRGKXMAy+yLe2dpLffLkAz2oI5+bVtRECxgSbm2XQCg9zX/Ez
 42oxRH1cNPg6ZbJCFF0hA4ab1Knc9TZhZxlSCEoDtma3NxdLFgyPp5Rhr/x3sfWyCUNL
 K55XMQ+jMqqXExaSDPaczxHSkExjJQ3E+YlnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740058312; x=1740663112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CgeVf/ZApKzuaB5pwg+ePZxUp0u4gWxwOyM3G9tIsz4=;
 b=YNxOJlnTxotOWf2sKEQ4feBchAPDiiXt6r4EWCmj8+VJY0ueh54hQNHYrV6rDES3+J
 JFrRus+Yro2pZ3lEalsmTnkqfg0UzraWLCD2bTcAp0UtuvajeH8m9xa4ng/57kV0KWZe
 xvcRH/f66C3Wd+FOoarr+EPcEuNIgodpWsFx20iittl40AdZpvU/qgnsaGmQAUjXNM3G
 dR7hlp3CwGsyju5Pa2ngwno0+JxH4uAo3164N8NMucLkxyy9w09RClxgqrcrIPXd9Uze
 4LhDePF8CWllORy2uVEyWYUXgPUSPznVyUf45y49s2zjKCmXAoks5adl91uP9RpqA5ox
 TwdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl0KuR2KwG6x9NYIUwnETIkqf5B0qaSKyOdZPs4ZIVaIf0pp5I8sTckJ/RnX70LX4vqW8MT9g=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7XB/Ppf8qMhgkXf1jszoSZXi3WSx842YKOENAloPfi/zSztur
 XRuj6mEuWr/Kg1+nweSXmnqIZk/Se220lt+yF6QKGb+ZcEeFGz+dy2IAnQsMcynZpWggeH7kB+q
 uooGup05/73TdWILUVmmkvLlRAy8hRHskGmf2
X-Gm-Gg: ASbGncsKgiVgjfKV2odqoSdNMZY2p/ShDVfNgoGF/4EQDCoamh/la3NaEXdmmbt7fck
 HjO0xKq4xARPiy3EC12D5xKX26ppS6BeEa8tHsJCa0BvbwAm7w3APBUeGdKQUYCprRZASI85tww
 ==
X-Google-Smtp-Source: AGHT+IE1p3ODBr9quqCUrG0rE+TvNtTpg4pWSRJa0MKyL9pd0AkVkfwRJWhajiIGk8wCj0l76rkT2Q5NX7IOASa01GQ=
X-Received: by 2002:a17:906:3118:b0:ab7:63fa:e4ab with SMTP id
 a640c23a62f3a-abb7053d8cfmr1911394066b.0.1740058312331; Thu, 20 Feb 2025
 05:31:52 -0800 (PST)
MIME-Version: 1.0
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
In-Reply-To: <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 06:31:40 -0700
X-Gm-Features: AWEUYZnZLR2kwmHeTDK4sg0n4OwpDwSmUGaAwUlGd7yeEyFnIsP4-JGpWfTaeKM
Message-ID: <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Pawel Kochanowski <pkochanowski@sii.pl>, u-boot@lists.denx.de, 
 Gabriel Nesteruk <gnesteruk@sii.pl>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

On Thu, 20 Feb 2025 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 2/20/25 07:58, Ilias Apalodimas wrote:
> > On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
> >>
> >> From: Gabriel Nesteruk <gnesteruk@sii.pl>
> >>
> >> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> >> in `copy_fdt()`, which may not be sufficient if additional nodes
> >> (such as FMAN firmware) are added later.
> >>
> >> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
> >> to allow users to define the amount of extra space reserved for FDT
> >> expansion. The default remains 0x3000.
> >>
> >> This change prevents potential corruption when resizing FDT after
> >> EFI boot, especially when firmware like FMAN requires additional
> >> space.
> >>
> >> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> >> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> >> ---
> >>   lib/efi_loader/Kconfig      | 9 +++++++++
> >>   lib/efi_loader/efi_helper.c | 2 +-
> >>   2 files changed, 10 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> >> index d4f6b56afaa..bd2cbe995c9 100644
> >> --- a/lib/efi_loader/Kconfig
> >> +++ b/lib/efi_loader/Kconfig
> >> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
> >>            No additional space will be required in the resulting U-Boot binary
> >>            when this option is enabled.
> >>
> >> +config EFI_FDT_EXTRA_SPACE
> >> +    hex "Extra space to allocate for FDT expansion"
>
> Hello Pawel,
>
> Is this problem really EFI specific? Wouldn't you have a similar problem
> when booting via booti?
>
> >> +    default 0x3000
> >> +    help
> >> +      Defines additional space (in bytes) reserved for expanding the
> >> +      Flattened Device Tree (FDT) when passed to the EFI system.
> >> +      Increase this value if your firmware (e.g., FMAN) needs to add
> >> +      more data to the device tree after U-Boot relocation.
> >> +
> >>   endif
> >>
> >>   source "lib/efi/Kconfig"
> >> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> >> index 04b2efc4a3b..91b2a5b8653 100644
> >> --- a/lib/efi_loader/efi_helper.c
> >> +++ b/lib/efi_loader/efi_helper.c
> >> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
> >>           * needs to be expanded later.
> >>           */
> >>          fdt = *fdtp;
> >> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> >> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
>
> This is not the only place where the configuration value needs to be
> considered:
>
> lib/efi_loader/efi_dt_fixup.c:171:
>                                0x3000;
>
> Could you, please, send a new revision of your patch.
>
> Best regards
>
> Heinrich
>
> >>          fdt_size = fdt_pages << EFI_PAGE_SHIFT;
> >>
> >>          ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> >> --
> >> 2.43.0
> >>
> >
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>

Let's do this instead, as it is generic:

https://lore.kernel.org/u-boot/20241206131113.2865416-3-sjg@chromium.org/

I believe the copy_fdt() function can just be removed, as the FDT is
already in reserved memory. Putting it in the ACPI_RECLAIM region is
wrong, too, as it is not an ACPI region.

Regards,
Simon
