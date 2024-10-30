Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A68D5CCB8
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 15:04:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4A1388F27;
	Wed, 30 Oct 2024 16:04:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KR3CG/0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 574E388FAA; Wed, 30 Oct 2024 16:04:11 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B407F88F1E
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 16:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbd092f7f0so48431026d6.0
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730300647; x=1730905447; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=i6U0iqLkR7KwpYKBdOx6AT94LYVTI36icWJy5KMmsoU=;
 b=KR3CG/0ZeCdwjsDxUHq4FBK3T1gHioFJgJ4yXk6/c3OGine6sKBQFiPp3JMfSmC9F5
 AbkvNG8gWzgNSvBWfFSeRIkXGax1PbEXG7v5zAnDSRRGQmk37dm9V2+GPwxnldY3th7U
 F4eRG1exsye7nreXH1aZ6IO+uLdRrPK/DI9mU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730300647; x=1730905447;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i6U0iqLkR7KwpYKBdOx6AT94LYVTI36icWJy5KMmsoU=;
 b=G4ksdHbWncM56T8+JKVKdHpMUkCi8qTTfWFBIviiTjI9KrUrfG2B9wLMQeYwh3nB/L
 opKakUlyfKSen6YDs6QPk3aRD6o1K8EiOcIE8Wj/KCUnYDrf9VbiD8dTrfcMOQeQyGBF
 mDFMsfBiwhSAv5j5pHsvPgvMQdBzpW14/aLPHzZajiVZQ4VZv/rxZ85Q1Dxnnix8SeLk
 GZvoX47bfJK5R+OoDxfoKzpSJQs0bCR14mcnNtyfRBdSFclqK0/wOi+5hfarTN2F7epE
 EMNUfYxDU6a9IbSnBMPU30LsLDQOPYgWDctYIdjbkro4NnwTULxbqQzGWUJFBtspRdeO
 0BaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRkdS3DkRbGqAoWlMgVUzSYM364ajo/ihiSxZpBLGIHagnRCLAP/+xOoU/Va2Pys/aIMOGtm4=@lists.denx.de
X-Gm-Message-State: AOJu0Yw+adtDQin1xgSNWpO2IkH1HRUuQRwXdDVZOPlaiBWCOuyJ3/7R
 1uZ/+I12CpJ5sUYvkbk/cixTuoD87j7145r6hVmSU4rCy7p+vOq4jvaXLtzWYws=
X-Google-Smtp-Source: AGHT+IFLR0FwVYFFwie9yzHoDGKglsvDDTsIfb29rM/GeOVuw3frOHvqsYmCf3QKzQdbyexsB+3ptA==
X-Received: by 2002:a05:6214:4802:b0:6d3:45cb:40eb with SMTP id
 6a1803df08f44-6d345facd6fmr50679566d6.10.1730300646778; 
 Wed, 30 Oct 2024 08:04:06 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991329bsm52571386d6.58.2024.10.30.08.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 08:04:06 -0700 (PDT)
Date: Wed, 30 Oct 2024 09:04:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v8 5/8] sandbox: Report host default-filename in native
 mode
Message-ID: <20241030150403.GM2558755@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
 <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
 <CAFLszTj+jOut1_-E45A-f=smJejn+BTZ4XVuDr1YdJ20=zKQSQ@mail.gmail.com>
 <20241029164027.GE4959@bill-the-cat>
 <CAFLszTh04Mw9PjdMUm5o_Hn7az9iM4B8+OBgP8a6Y69HbW46Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E5XRCngLqiDYK+QV"
Content-Disposition: inline
In-Reply-To: <CAFLszTh04Mw9PjdMUm5o_Hn7az9iM4B8+OBgP8a6Y69HbW46Xg@mail.gmail.com>
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


--E5XRCngLqiDYK+QV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 08:44:30AM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 29 Oct 2024 at 17:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Oct 29, 2024 at 04:45:54PM +0100, Simon Glass wrote:
> > > Hi Heinrich,
> > >
> > > On Mon, 28 Oct 2024 at 20:16, Heinrich Schuchardt <xypron.glpk@gmx.de=
> wrote:
> > > >
> > > > On 10/25/24 11:56, Ilias Apalodimas wrote:
> > > > > Hi Simon,
> > > > >
> > > > >
> > > > > On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > >>
> > > > >> When the --native flag is given, pretend to be running the host
> > > > >> architecture rather than sandbox.
> > > > >>
> > > > >> Add an 'efidebug filename' command to report it.
> > > > >
> > > > > Heinrich does this allow you to continue your testing in native a=
rchs?
> > > > >
> > > > >>
> > > > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > >> ---
> > > > >>
> > > > >> Changes in v8:
> > > > >> - Add new patch to report host default-filename in native mode
> > > > >>
> > > > >>   boot/bootmeth_efi.c | 25 ++------------------
> > > > >>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++----=
--------
> > > > >>   cmd/efidebug.c      | 25 ++++++++++++++++++++
> > > > >>   include/efi.h       | 25 ++++++++++++++++++++
> > > > >>   4 files changed, 94 insertions(+), 38 deletions(-)
> > > > >>
> > > > >> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > > > >> index 371b36d550b..f836aa655f5 100644
> > > > >> --- a/boot/bootmeth_efi.c
> > > > >> +++ b/boot/bootmeth_efi.c
> > > > >> @@ -25,32 +25,11 @@
> > > > >>
> > > > >>   #define EFI_DIRNAME    "/EFI/BOOT/"
> > > > >>
> > > > >> -static int get_efi_pxe_arch(void)
> > > > >> -{
> > > > >> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhc=
pv6-parameters.xml */
> > > > >> -       if (IS_ENABLED(CONFIG_ARM64))
> > > > >> -               return 0xb;
> > > > >> -       else if (IS_ENABLED(CONFIG_ARM))
> > > > >> -               return 0xa;
> > > > >> -       else if (IS_ENABLED(CONFIG_X86_64))
> > > > >> -               return 0x6;
> > > > >> -       else if (IS_ENABLED(CONFIG_X86))
> > > > >> -               return 0x7;
> > > > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > > > >> -               return 0x19;
> > > > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > > > >> -               return 0x1b;
> > > > >> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> > > > >> -               return 0;       /* not used */
> > > > >> -
> > > > >> -       return -EINVAL;
> > > > >> -}
> > > > >> -
> > > > >>   static int get_efi_pxe_vci(char *str, int max_len)
> > > > >>   {
> > > > >>          int ret;
> > > > >>
> > > > >> -       ret =3D get_efi_pxe_arch();
> > > > >> +       ret =3D efi_get_pxe_arch();
> > > > >>          if (ret < 0)
> > > > >>                  return ret;
> > > > >>
> > > > >> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(stru=
ct bootflow *bflow)
> > > > >>          ret =3D get_efi_pxe_vci(str, sizeof(str));
> > > > >>          if (ret)
> > > > >>                  return log_msg_ret("vci", ret);
> > > > >> -       ret =3D get_efi_pxe_arch();
> > > > >> +       ret =3D efi_get_pxe_arch();
> > > > >>          if (ret < 0)
> > > > >>                  return log_msg_ret("arc", ret);
> > > > >>          arch =3D ret;
> > > > >> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
> > > > >> index a6b11383bba..790f9e2fa36 100644
> > > > >> --- a/boot/efi_fname.c
> > > > >> +++ b/boot/efi_fname.c
> > > > >> @@ -9,29 +9,34 @@
> > > > >>    */
> > > > >>
> > > > >>   #include <efi.h>
> > > > >> +#include <errno.h>
> > > > >>   #include <host_arch.h>
> > > > >>
> > > > >> -#ifdef CONFIG_SANDBOX
> > > > >> -
> > > > >>   #if HOST_ARCH =3D=3D HOST_ARCH_X86_64
> > > > >> -#define BOOTEFI_NAME "BOOTX64.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
> > > > >> +#define HOST_PXE_ARCH 0x6
> > > > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_X86
> > > > >> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
> > > > >> +#define HOST_PXE_ARCH 0x7
> > > > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
> > > > >> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
> > > > >> +#define HOST_PXE_ARCH 0xb
> > > > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_ARM
> > > > >> -#define BOOTEFI_NAME "BOOTARM.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
> > > > >> +#define HOST_PXE_ARCH 0xa
> > > > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
> > > > >> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
> > > > >> +#define HOST_PXE_ARCH 0x19
> > > > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
> > > > >> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> > > > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
> > > > >> +#define HOST_PXE_ARCH 0x1b
> > > > >>   #else
> > > > >> -#error Unsupported UEFI architecture
> > > > >> +#error Unsupported Host architecture
> > > > >>   #endif
> > > > >>
> > > > >> -#else
> > > > >> -
> > > > >> -#if defined(CONFIG_ARM64)
> > > > >> +#if defined(CONFIG_SANDBOX)
> > > > >> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> > > > >> +#elif defined(CONFIG_ARM64)
> > > > >>   #define BOOTEFI_NAME "BOOTAA64.EFI"
> > > > >>   #elif defined(CONFIG_ARM)
> > > > >>   #define BOOTEFI_NAME "BOOTARM.EFI"
> > > > >> @@ -47,9 +52,31 @@
> > > > >>   #error Unsupported UEFI architecture
> > > >  >>   #endif>>
> > > > >> -#endif
> > > > >> -
> > > > >>   const char *efi_get_basename(void)
> > > > >>   {
> > > > >> -       return BOOTEFI_NAME;
> > > > >> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI=
_NAME;
> > > > >> +}
> > > > >> +
> > > > >> +int efi_get_pxe_arch(void)
> > > > >> +{
> > > > >> +       if (efi_use_host_arch())
> > > > >> +               return HOST_PXE_ARCH;
> > > > >> +
> > > > >> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhc=
pv6-parameters.xml */
> > > > >> +       if (IS_ENABLED(CONFIG_ARM64))
> > > > >> +               return 0xb;
> > > > >> +       else if (IS_ENABLED(CONFIG_ARM))
> > > > >> +               return 0xa;
> > > > >> +       else if (IS_ENABLED(CONFIG_X86_64))
> > > > >> +               return 0x6;
> > > > >> +       else if (IS_ENABLED(CONFIG_X86))
> > > > >> +               return 0x7;
> > > > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > > > >> +               return 0x19;
> > > > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > > > >> +               return 0x1b;
> > > > >> +       else if (IS_ENABLED(CONFIG_SANDBOX))
> > > >
> > > > Please, add a warning here:
> > > >
> > > >       log_warn("You are using the sandbox in non-compliant mode\n");
> > > >
> > > > The riscv64 sandbox can only run riscv64 binaries
> > > > The arm64 sandbox can only run arm64 binary.
> > > >
> > > > We cannot expect a DHCP server to do the expected with the value 0.
> > > >
> > > > So why should we introduce this?
> > > >
> > > > >> +               return 0;       /* not used */
> > > >
> > > > The following comment would fit better:
> > > >
> > > >      /* This breaks PXE booting on the sandbox.*/
> > >
> > > This line is already in the code. I am just moving it to a new file.
> > > PXE booting is not supported on sandbox. Neither is EFI booting, until
> > > this series is applied.
> >
> > It sounds like EFI booting in sandbox is working and being tested and
> > used (as a testing mechanism) right now. And the work and questions
> > being raised here are around having your changes not break that existing
> > use.
>=20
> Well it would be, although at present that flow does not work, due to
> a problem either with EDK2 or QEMU. It may be fixed at some point.

Since it sounds like Heinrich is testing shim+grub binaries currently,
I'm not sure what you mean here.

> With this patch, the -N flag is needed to use this 'native' flow. The
> flag is not needed for CI, which is what I consider to be the normal
> 'sandbox' case.

Well, unfortunately your code has escaped in to the wild and is being
used by other people now. For your still unclear what we need it for use
case, you should be invoking the magic logic you need, not the other way
around.

--=20
Tom

--E5XRCngLqiDYK+QV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmciSuMACgkQFHw5/5Y0
tyx6zAwAjgXGJkcf6BGocKrewB+gcd1Hgi05mPIkjBW7iYy2c+37imbUXF3I+XHI
npyF+KKUc2XWGj264YMR8kUC+ABVOcg0NiaP0kERwp7zp45tBsOShkEK2toq0pn2
5Klmm44LO2P7oyGDYh9LTf9FWACA1P/XH7CnNY65/YYEuTSeIqpUSMztEswp2WSN
IclQourk9bC4855jkJj2ZqUG27pAbcEn6yH6f3Hqyrhsz3yowg06RbF5F+X67SpG
SbPKhvduRbKsIecq9QiUOyMTTcRrAl6YvccrQRUk24HV6tQ4JPQHmFifK3zhKaJR
D6ah80APZZa9nVMLlTM+ib3cfENrmzpK7uLRGUZPGEqmnHOvMl5rRuRTQkoJ0TAu
H3fNV/pyd7xkmNbk/04hysEI4IEJjPKx8soCna6HqmAkU7myqgFU9bEs9lwX+pmY
ZG7GaBv7KWyfT6hpj8x1Mx8lGt2WF6gvthkOVL+GtKaWvfAD/5m28PwB4Ah6uEa0
N+4nXQF8
=X+na
-----END PGP SIGNATURE-----

--E5XRCngLqiDYK+QV--
