Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901CACDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 16:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E73E386FE4;
	Wed, 18 Oct 2023 18:36:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XaTv7nhi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABEA80EEB; Wed, 18 Oct 2023 18:36:55 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCB8586FE9
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 18:36:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso437961666b.1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697647012; x=1698251812; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RNR0tbgHrpb7Tjg3WeFENTaYi24CAvdLOqeEL468qEw=;
 b=XaTv7nhi2N5hLJh0U50EYZGtTrHtJHgQSRelIeG8g5ewPLhzi2sTHUGAJTCCAl4rQU
 bsATS2xAIXMU6JsDEn81zemObna8S+LszGBaep1sJ0Ll+UmUs50jjRsOHnrs7/vDczHS
 PMI0Mz1A71PrsiF+0vM9G5qVrW+AhCBzTzHqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647012; x=1698251812;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RNR0tbgHrpb7Tjg3WeFENTaYi24CAvdLOqeEL468qEw=;
 b=MhGvnwPBSsIRJXrtM4waKfosCq0yH7cT5dZrcBz3T5mBf9L8lYLEUsfGq+7JXAGn5q
 gBVQcyoLu+n4OIO430BEtpakqX/a6bG6X3piapjICRSHoEX26alNrgxqDxSZEmeFQx0f
 jhCOH2uOfFp6cRt7DDnOh2lSlS6rqWsc/29dVO5+ByC20R8AgJP+shJPuZ0wJwb+CQfT
 4VuQJhTHymFdUegfOzYjawMoAtXoN9BilV2pbUfs01jZaPdZSNyQkb4a2WM+eeiueIKK
 WJFJMydfYo+iL7gnnyhDLkjO9vsobaMcXDYe/jl8hV7Fq1fDtmHqJAnjbdEhyQTCyYzq
 qyCQ==
X-Gm-Message-State: AOJu0YxP1ESyERUrohGo0+n70L8zt+/Olo0Lg8F74F5r9IIUG49UDZqr
 AdktnOUJr3E8ztMe8A6RCDskdRGPSQLy2tZEo3rrZSbVF3PxLQz+X3w=
X-Google-Smtp-Source: AGHT+IE+WhJUgCydlbIyh/cJ8KovbyFRP3G4QNCvAVwpKN/9LFa9CjVzU/XY59TPwTuT/M6eli2BL5PFgLHzXTTwdL0=
X-Received: by 2002:a17:907:d1b:b0:9a5:c38d:6b75 with SMTP id
 gn27-20020a1709070d1b00b009a5c38d6b75mr5328199ejc.15.1697647012019; Wed, 18
 Oct 2023 09:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
 <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
 <20231018152713.GT3119521@bill-the-cat>
In-Reply-To: <20231018152713.GT3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 18 Oct 2023 10:36:39 -0600
Message-ID: <CAPnjgZ0uGzKjcjAUNj9yiHmPYjWXVaj7ASPJm1p2m68MH33ewg@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Tom,

On Wed, 18 Oct 2023 at 09:27, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 18, 2023 at 09:23:42AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 18 Oct 2023 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > >
> > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet is
> > > > available, add it as an explicit dependency.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v2)
> > > >
> > > > Changes in v2:
> > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > >
> > > >  lib/efi_loader/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 13cad6342c36..fca4b3eef270 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > >       depends on BLK
> > > > +     depends on DM_ETH
> > > >       depends on !EFI_APP
> > > >       default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
> > > >       select CHARSET
> > >
> > > I don't think this is needed.  After reconfiguring qemu_arm64 to be able
> > > to disable networking entirely, we still are able to build with
> > > EFI_LOADER enabled, and no warning / link errors.
> >
> > Fair enough.
> >
> > As of this patch the following errors are generated with -a ~CMDLINE :
> >
> > +lib/efi_loader/efi_device_path.c:985:(.text+0xca4): undefined
> > reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_name':
> > +lib/efi_loader/efi_device_path.c:1095:(.text+0xe00): undefined
> > reference to `efi_get_image_parameters'
> >
> > which is why I added this patch. A later patch disables networking
> > entirely with ~CMDLINE so that is why this problem goes away.
> >
> > This series was basically built up by disabling CMDLINE and then
> > fixing the errors one by one. I didn't go back and check whether (at
> > the end) all the patches were needed.
>
> Yes, part of the issue with the series is that you didn't go and rework
> things after getting CMDLINE to link for sandbox, to see what else is or
> is not still needed.
>
> > I could do that and send a v4, if your more general concerns can be sorted out.
>
> Don't worry about a v4 currently please, I'm working through the issues
> now picking out parts of v3 and re-working others.

OK, thanks.

Regards,
Simon
