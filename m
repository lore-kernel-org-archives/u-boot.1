Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35735CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 10:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC1086FB0;
	Thu, 19 Oct 2023 12:40:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BzSNy0Z4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F23A86FB5; Thu, 19 Oct 2023 12:40:03 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2686086FAD
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 12:40:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-9bf86b77a2aso749406766b.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 03:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697712000; x=1698316800; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8R+rZhbgTpt6lH6uebfjCKyhWtJQKW50dcHjdP8BCvw=;
 b=BzSNy0Z4biQaa3IU1ExI0L9LbDrVCvaXDgJgb7spyBZ30ioV5IVEVNJB4jOCxpKJER
 98vbY28wUA1IEeuiZK0SG9JlqXPFarF37ky7qM8pTDAOkEaM09XBkiT2hPm6tZvz6kne
 8NMNgcr4k0/WJeNBwg0QZ3Nii+HMSTE0rJw00ZgEZdgSrBwxNdZv/EmDgeNiypGCkJyI
 bJGRxeZ/kZBrrY2kjWl2T090WgpxZbqEFGUNx/AIZz+hzrMUqj4LFMsic3zXk4/pV3Uf
 6dhfvWzPYMiHXXfisA3ifpiMnpONks7zGWn45R6MrdDs+jsaJ2RDOIBQqFXMgNh+RbPY
 OO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712000; x=1698316800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8R+rZhbgTpt6lH6uebfjCKyhWtJQKW50dcHjdP8BCvw=;
 b=NfUhYOIuUGEY3V9pCrp4vUB70hZJwDeoRnOeIleLawN5TqoC85A+k6ozWCnIUlDZns
 HoxbJYRWTd6GB7Q5jsXQxvQF4/OclhCfJeVzNVjUsj52L2tBTRYVbfAyC7of1mwxl5rp
 BfqQzvS2s5iytgaXj7OuEmCNslOiCc3Ur3X4pQaSL5wDQohKSv79j15xoFKALsESEDlq
 3qIV1ktpk0I9sviYP21kYyiDgsthXlhUvVsOMh6h2S6WPTTfENtVyt60f/rgcyHyd643
 5zrFYjN6rS09Ghm+/R2gNNq4G5CE936TmIaptVoO46GlS8vjse6uk2l5HwJSEZBfV3n3
 UJkA==
X-Gm-Message-State: AOJu0YxFkWJJr1pAKEJcgl6rgBrxypz6LMHxzPXfB+ZzqkScC22hddnp
 lKRFAxwJkxakd9tO7oIqeBP8FMwrZ0Zitg4vF604jUt1
X-Google-Smtp-Source: AGHT+IFoE3y90oD7pqaGGdv/xHXNJlLOiKNk7PG3Q0J673v5yiv+YfSUGo4ClZewivMXQZbsAbXSoMNfQj2sVHiOxKM=
X-Received: by 2002:a17:907:7e94:b0:9bd:bbc1:1c65 with SMTP id
 qb20-20020a1709077e9400b009bdbbc11c65mr1454938ejc.13.1697712000405; Thu, 19
 Oct 2023 03:40:00 -0700 (PDT)
MIME-Version: 1.0
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
 <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
In-Reply-To: <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 19 Oct 2023 11:39:49 +0100
Message-ID: <CALeDE9MbMTCY-6eBeZ=a0es5MEDycAFWT710O81C_WYheBEVSQ@mail.gmail.com>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 18, 2023 at 4:29=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Tom,
>
> On Wed, 18 Oct 2023 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> >
> > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethernet=
 is
> > > available, add it as an explicit dependency.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > >
> > >  lib/efi_loader/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > index 13cad6342c36..fca4b3eef270 100644
> > > --- a/lib/efi_loader/Kconfig
> > > +++ b/lib/efi_loader/Kconfig
> > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > >       depends on BLK
> > > +     depends on DM_ETH
> > >       depends on !EFI_APP
> > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
> > >       select CHARSET
> >
> > I don't think this is needed.  After reconfiguring qemu_arm64 to be abl=
e
> > to disable networking entirely, we still are able to build with
> > EFI_LOADER enabled, and no warning / link errors.
>
> Fair enough.
>
> As of this patch the following errors are generated with -a ~CMDLINE :
>
> +lib/efi_loader/efi_device_path.c:985:(.text+0xca4): undefined
> reference to `eth_get_dev'
> +/bin/ld: lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> undefined reference to `eth_get_dev'
> +/bin/ld: lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> undefined reference to `eth_get_dev'
> +/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_name=
':
> +lib/efi_loader/efi_device_path.c:1095:(.text+0xe00): undefined
> reference to `efi_get_image_parameters'
>
> which is why I added this patch. A later patch disables networking
> entirely with ~CMDLINE so that is why this problem goes away.
>
> This series was basically built up by disabling CMDLINE and then
> fixing the errors one by one. I didn't go back and check whether (at
> the end) all the patches were needed.

Was this just tested on sandbox? How do we know it's not going to
regress a vast amount of actual devices?

> I could do that and send a v4, if your more general concerns can be sorte=
d out.
>
> Regards,
> Simon
