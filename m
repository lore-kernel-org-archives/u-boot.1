Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AF0C10DC1
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:30:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 365E187713;
	Thu, 30 Nov 2023 21:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fsJBjo2a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0C32876F6; Thu, 30 Nov 2023 21:30:41 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D730B8771B
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:30:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a00b01955acso201567966b.1
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701376239; x=1701981039; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=j1kEoDVz8FmA118BIct7BasaUqEKiq39maAWu6XgfrY=;
 b=fsJBjo2aurve9XlNyyz0As/FX4v2UHxiU4j8X1hjy6fbQ5jH/CVqdQ2x+ANpAc7cAz
 O4k3fiZYItZR+ZQqG+oFyx2EQd5QxIQdySYCtaK8H4wp0I/+BUoxPFKmAaknTV8vmWJS
 kIiZw0fO0g9MhD4Z5dwkMi1M+XSzGGaLJUVcg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701376239; x=1701981039;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j1kEoDVz8FmA118BIct7BasaUqEKiq39maAWu6XgfrY=;
 b=qTcsXrBrBsoFtZ/z1uz19NQ5/PH/RVMQWui8bI6JaMQ940ZcNDfy60gwNVMFBDAauU
 BpnVZ0BdxYSDxmMKazlDxXKQ7T90mTMiUnL57rwQ46r4p0fBWr7NpzkVM9Z1myUD218r
 ZwAxc3P55oC/zAny/vImVTC6QdzR/inCdvj5xUfD1giv5hpf+wTwstUyIVzcSD+8NlzO
 9C7IYR10WLVYK2FMYkpIWclt/7K+vR9koTtc+/jc5TP73YCL1+jYYpj8jfnbHxb5GqIP
 WbfLWcVquPtxgCzcBwB78hXi23wKqsQ17t9Tg0qQBr8pLK6MTEhTm6Y4cLzBfhrQ1jn5
 X9YA==
X-Gm-Message-State: AOJu0YwFrKo1dShTB9cbVsh6GnmSnVog//3ZFLzN4fkJPqoCIoND8gBR
 c8nosVjEvDKKzdjo1xzuSdfsAQ5Zl0erTo/fDggJHQ==
X-Google-Smtp-Source: AGHT+IFIp7jl3Xe9SuGYh3OvQzZO3AxM5rdMcalwjeJ+luXeVJXVWymrXe3jpNkDnguFqELGcbxrl9p2GVcMiT0/cuQ=
X-Received: by 2002:a17:907:509d:b0:a0d:31:b455 with SMTP id
 fv29-20020a170907509d00b00a0d0031b455mr69707ejc.20.1701376238985; Thu, 30 Nov
 2023 12:30:38 -0800 (PST)
MIME-Version: 1.0
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
In-Reply-To: <03595817-4698-46d3-b2d8-3bc40c7e723e@pengutronix.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Nov 2023 13:30:25 -0700
Message-ID: <CAPnjgZ0G5DAFZj+nxVxMvNOg_wQKxwu06NAarUdVjurPYZ+tcw@mail.gmail.com>
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

I missed this comment earlier. I believe Image is intended to refer to
a raw image, with the other extensions being compressed versions of
these. So I believe it would be confusing for the FIT version to have
a capital I.

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
>
> Please Cc me on subsequent revisions. I am interested in testing that this works for barebox
> too.

I have added you.

Regards,
Simon
