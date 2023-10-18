Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECCEFCDB482
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 15:27:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6781786FB8;
	Wed, 18 Oct 2023 17:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="idocb+rQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1028A86F40; Wed, 18 Oct 2023 17:27:19 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E69DE86FC1
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 17:27:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-d857c8a1d50so7118306276.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 08:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697642835; x=1698247635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MusqOzZ/P4VJoihlB9SfJhWKKWSN2Tblc0J3Cuqz/LY=;
 b=idocb+rQLGbOWe7v35pb3lNzTjWb/8VGDzziEp1nB+cjE+1Skr0EXzqj48H6rTQKWw
 MZCOby7tK2e48Skxn+0udatTvkrHa0BUM+4zimqWkDs4EGxI7gRPgrvpX29w47J+zFqZ
 otVP94rTzs2qsrUnfy1+Qbo+wW5xQZugj381k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697642835; x=1698247635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MusqOzZ/P4VJoihlB9SfJhWKKWSN2Tblc0J3Cuqz/LY=;
 b=nsi+FL5H1+JJywLSXhzZweHucdI+yRLlsZMUoOrtweeUyHmghhLuSFh73VsoWEKseN
 b28rgwmqAfS+vraRaBuR5FanhZNAnmBP+//XKs6UnxJHf0cwnfFmLa6bafK1aoh0rcSD
 fVMaQEaJxyCEJYL5IZiEgxKdwwYY5py+CYiG4Ruw0y+o4OrkCyfy8QJfliEZuezhl5Ai
 Q9eb84v25MSqvnuIjUYUML5BRQbCUvO03l4q2ifYXcQ5dhfESDNwXD16W6xqvQuSuW2G
 fqKO8HHU1xlD6kyN9X2+ySOj0VaK49CwQ7bJGAmHsKi8ZkJRAS8TV6RgF6va7etY/BE/
 vBkQ==
X-Gm-Message-State: AOJu0YxW82VYyaBjaxlH52+Y9TX9n2+fUl/juBpQfft4Ot4S3bnNmedx
 WKZCp9VusG1VBW3WkkVcbDC0DbxRXs4+Um3yFXo8JQ==
X-Google-Smtp-Source: AGHT+IF2Yb+FieDUbzTGQnG5JCmu9rTAucx6PEb6sduJn6UT8iD35QPX7WJxSfWPIeXrus+5v8Oamg==
X-Received: by 2002:a25:abd3:0:b0:d9a:68db:7f96 with SMTP id
 v77-20020a25abd3000000b00d9a68db7f96mr5450265ybi.21.1697642835564; 
 Wed, 18 Oct 2023 08:27:15 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 128-20020a251186000000b00d9ab95777ecsm1369990ybr.49.2023.10.18.08.27.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 08:27:15 -0700 (PDT)
Date: Wed, 18 Oct 2023 11:27:13 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231018152713.GT3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
 <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2pVdNDyWLf8HNV83"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--2pVdNDyWLf8HNV83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 09:23:42AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
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
> > I don't think this is needed.  After reconfiguring qemu_arm64 to be able
> > to disable networking entirely, we still are able to build with
> > EFI_LOADER enabled, and no warning / link errors.
>=20
> Fair enough.
>=20
> As of this patch the following errors are generated with -a ~CMDLINE :
>=20
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
>=20
> which is why I added this patch. A later patch disables networking
> entirely with ~CMDLINE so that is why this problem goes away.
>=20
> This series was basically built up by disabling CMDLINE and then
> fixing the errors one by one. I didn't go back and check whether (at
> the end) all the patches were needed.

Yes, part of the issue with the series is that you didn't go and rework
things after getting CMDLINE to link for sandbox, to see what else is or
is not still needed.

> I could do that and send a v4, if your more general concerns can be sorte=
d out.

Don't worry about a v4 currently please, I'm working through the issues
now picking out parts of v3 and re-working others.

--=20
Tom

--2pVdNDyWLf8HNV83
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUv+U4ACgkQFHw5/5Y0
tyw3/gwAuv5Z2jDUobSX/RlVoQO8IorbuCznYskPUNifPOTCFNbaSlH8EYmQ7TET
NLH+zJU1i8rGhm9iAWZ/7uCwIU3yqBi6DHNOExbh+jLgzvYnUvpXpNnTD0wJiT1N
awJPq50e/cHEQl6wWg0QWHL97EEtHxGFyhbGi8b4wwV+Zm+cqwnWCtqUpknULcjb
o6XOxIs+nR81WNH0KL5jxbpl+Gj0wjAMdwGIHaSL4eZgaH432cRoUBczzzxaxFEf
XwbiNgM5ijTFT+t8m2HRwY49k7lEmrlLEGJRpqrO0+0yKHh08NvKh1jF0a0Pa8iW
eBh0HifsjJbPxJ48LP8r0xSa2pNM55wyO7a/4rtmYeinqHfEYaNAUYXwuGYFyfKi
SHGak/QzyrfPMvC9MbNqnnawCdRzVa+AFXOeb6MLkjLTX6b8Myuqna1/8LRzUXIg
UAvoOsRqrxrM9mNoR5pP5GTiKQ3ffVzqsCy/vSh4MWlwwengBV4QSe3VSamvm55E
x403nA3B
=nfhl
-----END PGP SIGNATURE-----

--2pVdNDyWLf8HNV83--
