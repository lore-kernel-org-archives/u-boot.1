Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19060C4167B
	for <u-boot@archiver.kernel.org>; Wed, 29 Nov 2023 19:01:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CFE687616;
	Wed, 29 Nov 2023 20:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ThY6Es27";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3882F87691; Wed, 29 Nov 2023 20:01:22 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2547875CC
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 20:01:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a00a9c6f283so15679766b.0
 for <u-boot@lists.denx.de>; Wed, 29 Nov 2023 11:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701284479; x=1701889279; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zeJS0+YXgcV8K2msfYPrZc7s+u+FFHEg7gVWXomud/s=;
 b=ThY6Es27FK5BuOY3a2ISFLEDQf9Q1g0CmVg1Lu74mBjMP39EGpsAjk6lY2BtBJuH54
 5vgZpH6eOEJhltrXC5o7TO4Tao3it+17431ZZrh6b0fDLwLCJv0Yrxe7jyF8zY/bhA0w
 ews025ZgWlCxEj6cdxQMWF4XV1RsNcZgjetfM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701284479; x=1701889279;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zeJS0+YXgcV8K2msfYPrZc7s+u+FFHEg7gVWXomud/s=;
 b=EW7tDhikljaRJAExPNV2AeYyZfxnkdNW+SZQeiYeXaaz8NFxTFoJ/DfQpiAXaC5273
 /o2WGPUnogqOgHnRjup01NsXs5lXeL2XJV7AOiuZK6sOIyFJiWP0G3t/J3o3z7YmvVw6
 7wLpIYNEGnyGaCkTPVvRhW/BnmqMGCeIS3yt4b02/ifkzV8Ib3RqSOKKU18E0gHxSGf5
 xg8zJDKG87U4pKXzr72rB2K6B/GL03Bdz9DnXBwkedA4EuOzZrca1hl8KBCa1Qd8PV0W
 YoyGUgl7KcVJWb3J1Sa+YaMbudyDvSGLEiJuJqTlAtkul91p9UpxwJU83DhE1lPOVATH
 8jyw==
X-Gm-Message-State: AOJu0Yzul6V5tXW+ZrnQtQvQOTVC7rSk8JztViyKZu5E6h4GATGPc7Yi
 CJLX71IlYRhqfWZjotLk1IULMzuFBq2bQ/p2G8YSdg==
X-Google-Smtp-Source: AGHT+IFzwRelFfkIF8gvXqwP74fx2aLRF2MAfYe7wE5lNvZPbUHxwREC9GHnF7sxAQdl2nWuYhXn0vint48cvgP9igs=
X-Received: by 2002:a17:906:7245:b0:a01:e916:3584 with SMTP id
 n5-20020a170906724500b00a01e9163584mr12542566ejk.54.1701284479022; Wed, 29
 Nov 2023 11:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
In-Reply-To: <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 29 Nov 2023 12:00:59 -0700
Message-ID: <CAPnjgZ1e4cryN=Q8XufrdEcJoHfW5n-aN-F3pr2mTWA_0c5-Gg@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, 
 Masahiro Yamada <masahiroy@kernel.org>, Tom Rini <trini@konsulko.com>, 
 lkml <linux-kernel@vger.kernel.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, Pengutronix Kernel Team <kernel@pengutronix.de>
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

Hi Ahmad,

On Wed, 29 Nov 2023 at 11:35, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello Simon,
>
> On 29.11.23 18:21, Simon Glass wrote:
> > Add a script which produces a Flat Image Tree (FIT), a single file
> > containing the built kernel and associated devicetree files.
> > Compression defaults to gzip which gives a good balance of size and
> > performance.
>
> Thanks for working on this. I think it's useful to have the kernel
> generate a FIT image out of the box. More complex use cases are always
> free to call mkimage with a custom ITS.
>
>
> > The files compress from about 86MB to 24MB using this approach.
> >
> > The FIT can be used by bootloaders which support it, such as U-Boot
> > and Linuxboot. It permits automatic selection of the correct
> > devicetree, matching the compatible string of the running board with
> > the closest compatible string in the FIT. There is no need for
> > filenames or other workarounds.
> >
> > Add a 'make image.fit' build target for arm64, as well.
>
> not that it matters much, but should this maybe called Image.fit
> as the other Image types are capitalized too?
>
> >  EFI_ZBOOT_PAYLOAD    := Image
> >  EFI_ZBOOT_BFD_TARGET := elf64-littleaarch64
> >  EFI_ZBOOT_MACH_TYPE  := ARM64
> > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > index 1a965fe68e01..e1c06ca3c847 100644
> > --- a/scripts/Makefile.lib
> > +++ b/scripts/Makefile.lib
> > @@ -496,6 +496,19 @@ quiet_cmd_uimage = UIMAGE  $@
> >                       -a $(UIMAGE_LOADADDR) -e $(UIMAGE_ENTRYADDR) \
> >                       -n '$(UIMAGE_NAME)' -d $< $@
>
> Doesn't hardcoding a load address and entry address here defeat the point
> of having FIT as generic portable image format?
>
> At least barebox will try to place the kernel image at physical address 0 and
> will exit with an error message if no SDRAM is located at that address.
> The recommendation in that case is to omit load and entry address altogether
> to have barebox find a suitable location, but I see now that the FIT specification
> requires a load and entry address. What would happen if U-Boot tries to load this
> FIT image on a board that has no DRAM at address 0?

The 'kernel_noload' type indicates that the load/exec address are ignored.

>
> Please Cc me on subsequent revisions. I am interested in testing that this works for barebox
> too.

There has been some discussion about this recently in U-Boot too,
along with a series [1] which you could try if you like.

The FIT spec[2] does not provide enough detail on exactly what
kernel_noload means and we should improve this at some point.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/list/?series=382849
[2] https://github.com/open-source-firmware/flat-image-tree



>
> Thanks,
> Ahmad
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
>
