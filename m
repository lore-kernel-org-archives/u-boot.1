Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF614D3A670
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 16:40:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 657A088DC6;
	Tue, 29 Oct 2024 17:40:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MMCc679M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48FA288E81; Tue, 29 Oct 2024 17:40:35 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B8E478857C
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 17:40:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460ad0440ddso41014011cf.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 09:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730220031; x=1730824831; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oAnsX9H3bpx+CFHJ+YMfeb4czLIFNiuFJB2gTXamqLQ=;
 b=MMCc679Md1US+qDY0n7leywG9nFWIY3om7+ojYJCSXxCtFdXfAb1pNwVG1xdYKVis5
 6dnUQFQvz8gz5+fEEForxcQlKTXdMu7pu7fZQtD6q+9GSHEyGioxWnfH6fStTA+6Q78N
 I6u3tjet947pmny90gp7kEZ3DmWb6QvLocy10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730220031; x=1730824831;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAnsX9H3bpx+CFHJ+YMfeb4czLIFNiuFJB2gTXamqLQ=;
 b=pgB38abv1hXv2Yq1tc5cTYWoQd+0raTLYq8C1YTSTGBbcX9GNkhBSsHvSUncmZDNae
 idbzV86UArQqP1SyQ8UXD7oDhQrB7OUuY/1r6DEnFGqTOJ2j0v/koy9NmYD2GXJ3F+jT
 1oANc3BdWupKOVn+sEtquwQvwHtUSTlXOX1LrJ2KRsS/5CrMI5CGrZnbcG/QaL/MAlfn
 v/d7fjJanLNsw0oMudcu2uHjlzA90PRdSlakK0FG64FSn2q2C8wB/ABfCgxf31w2e6B3
 WO9uhglwCTO1QmDcpxSvODIo+kBbsQkchp/uU0hvWx5O1Ypr3ppBo4Lve3njf1evMtBO
 33aA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXneU3y8q6f5DDoAc+am11OpoV09A5kY1X+m3m/E53TBoN5XNNHOVL8AAiZpSQieQGtE4M+xNo=@lists.denx.de
X-Gm-Message-State: AOJu0YxV7QoYHldyMcUAMLQfcGtLSrxGFTswTnCeXFrulX4QkYMx9fkG
 xdroUTZYwCtdxAs0lKhd0tpGhLAMu9qClSEDslXpEfWl11ep+/jmTOOh84MWTUg=
X-Google-Smtp-Source: AGHT+IGBxGf4vlzNWeC/chxzXhypVIsT9E5I4ZuHna5Vwq1c4TX1Ye3BJaDzEh5cfKpbTaqptGnUdw==
X-Received: by 2002:ac8:5916:0:b0:460:4e67:d67f with SMTP id
 d75a77b69052e-4613bfc8673mr192892281cf.2.1730220031458; 
 Tue, 29 Oct 2024 09:40:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4613237454dsm46218161cf.75.2024.10.29.09.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 09:40:30 -0700 (PDT)
Date: Tue, 29 Oct 2024 10:40:27 -0600
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
Message-ID: <20241029164027.GE4959@bill-the-cat>
References: <20241022120032.196311-1-sjg@chromium.org>
 <20241022120032.196311-6-sjg@chromium.org>
 <CAC_iWjKUjsMdqXa2YZGiu1FSsjx_aH6cDQsi+2Ng5i-+9obQhQ@mail.gmail.com>
 <ea85b8fc-fe7b-4a76-a3e1-bb92b45b027a@gmx.de>
 <CAFLszTj+jOut1_-E45A-f=smJejn+BTZ4XVuDr1YdJ20=zKQSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dZ6arZLQ92QVZ60X"
Content-Disposition: inline
In-Reply-To: <CAFLszTj+jOut1_-E45A-f=smJejn+BTZ4XVuDr1YdJ20=zKQSQ@mail.gmail.com>
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


--dZ6arZLQ92QVZ60X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 04:45:54PM +0100, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Mon, 28 Oct 2024 at 20:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 10/25/24 11:56, Ilias Apalodimas wrote:
> > > Hi Simon,
> > >
> > >
> > > On Tue, 22 Oct 2024 at 15:00, Simon Glass <sjg@chromium.org> wrote:
> > >>
> > >> When the --native flag is given, pretend to be running the host
> > >> architecture rather than sandbox.
> > >>
> > >> Add an 'efidebug filename' command to report it.
> > >
> > > Heinrich does this allow you to continue your testing in native archs?
> > >
> > >>
> > >> Signed-off-by: Simon Glass <sjg@chromium.org>
> > >> ---
> > >>
> > >> Changes in v8:
> > >> - Add new patch to report host default-filename in native mode
> > >>
> > >>   boot/bootmeth_efi.c | 25 ++------------------
> > >>   boot/efi_fname.c    | 57 +++++++++++++++++++++++++++++++++--------=
----
> > >>   cmd/efidebug.c      | 25 ++++++++++++++++++++
> > >>   include/efi.h       | 25 ++++++++++++++++++++
> > >>   4 files changed, 94 insertions(+), 38 deletions(-)
> > >>
> > >> diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
> > >> index 371b36d550b..f836aa655f5 100644
> > >> --- a/boot/bootmeth_efi.c
> > >> +++ b/boot/bootmeth_efi.c
> > >> @@ -25,32 +25,11 @@
> > >>
> > >>   #define EFI_DIRNAME    "/EFI/BOOT/"
> > >>
> > >> -static int get_efi_pxe_arch(void)
> > >> -{
> > >> -       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-=
parameters.xml */
> > >> -       if (IS_ENABLED(CONFIG_ARM64))
> > >> -               return 0xb;
> > >> -       else if (IS_ENABLED(CONFIG_ARM))
> > >> -               return 0xa;
> > >> -       else if (IS_ENABLED(CONFIG_X86_64))
> > >> -               return 0x6;
> > >> -       else if (IS_ENABLED(CONFIG_X86))
> > >> -               return 0x7;
> > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > >> -               return 0x19;
> > >> -       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > >> -               return 0x1b;
> > >> -       else if (IS_ENABLED(CONFIG_SANDBOX))
> > >> -               return 0;       /* not used */
> > >> -
> > >> -       return -EINVAL;
> > >> -}
> > >> -
> > >>   static int get_efi_pxe_vci(char *str, int max_len)
> > >>   {
> > >>          int ret;
> > >>
> > >> -       ret =3D get_efi_pxe_arch();
> > >> +       ret =3D efi_get_pxe_arch();
> > >>          if (ret < 0)
> > >>                  return ret;
> > >>
> > >> @@ -239,7 +218,7 @@ static int distro_efi_read_bootflow_net(struct b=
ootflow *bflow)
> > >>          ret =3D get_efi_pxe_vci(str, sizeof(str));
> > >>          if (ret)
> > >>                  return log_msg_ret("vci", ret);
> > >> -       ret =3D get_efi_pxe_arch();
> > >> +       ret =3D efi_get_pxe_arch();
> > >>          if (ret < 0)
> > >>                  return log_msg_ret("arc", ret);
> > >>          arch =3D ret;
> > >> diff --git a/boot/efi_fname.c b/boot/efi_fname.c
> > >> index a6b11383bba..790f9e2fa36 100644
> > >> --- a/boot/efi_fname.c
> > >> +++ b/boot/efi_fname.c
> > >> @@ -9,29 +9,34 @@
> > >>    */
> > >>
> > >>   #include <efi.h>
> > >> +#include <errno.h>
> > >>   #include <host_arch.h>
> > >>
> > >> -#ifdef CONFIG_SANDBOX
> > >> -
> > >>   #if HOST_ARCH =3D=3D HOST_ARCH_X86_64
> > >> -#define BOOTEFI_NAME "BOOTX64.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTX64.EFI"
> > >> +#define HOST_PXE_ARCH 0x6
> > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_X86
> > >> -#define BOOTEFI_NAME "BOOTIA32.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTIA32.EFI"
> > >> +#define HOST_PXE_ARCH 0x7
> > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_AARCH64
> > >> -#define BOOTEFI_NAME "BOOTAA64.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTAA64.EFI"
> > >> +#define HOST_PXE_ARCH 0xb
> > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_ARM
> > >> -#define BOOTEFI_NAME "BOOTARM.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTARM.EFI"
> > >> +#define HOST_PXE_ARCH 0xa
> > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV32
> > >> -#define BOOTEFI_NAME "BOOTRISCV32.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV32.EFI"
> > >> +#define HOST_PXE_ARCH 0x19
> > >>   #elif HOST_ARCH =3D=3D HOST_ARCH_RISCV64
> > >> -#define BOOTEFI_NAME "BOOTRISCV64.EFI"
> > >> +#define HOST_BOOTEFI_NAME "BOOTRISCV64.EFI"
> > >> +#define HOST_PXE_ARCH 0x1b
> > >>   #else
> > >> -#error Unsupported UEFI architecture
> > >> +#error Unsupported Host architecture
> > >>   #endif
> > >>
> > >> -#else
> > >> -
> > >> -#if defined(CONFIG_ARM64)
> > >> +#if defined(CONFIG_SANDBOX)
> > >> +#define BOOTEFI_NAME "BOOTSBOX.EFI"
> > >> +#elif defined(CONFIG_ARM64)
> > >>   #define BOOTEFI_NAME "BOOTAA64.EFI"
> > >>   #elif defined(CONFIG_ARM)
> > >>   #define BOOTEFI_NAME "BOOTARM.EFI"
> > >> @@ -47,9 +52,31 @@
> > >>   #error Unsupported UEFI architecture
> >  >>   #endif>>
> > >> -#endif
> > >> -
> > >>   const char *efi_get_basename(void)
> > >>   {
> > >> -       return BOOTEFI_NAME;
> > >> +       return efi_use_host_arch() ? HOST_BOOTEFI_NAME : BOOTEFI_NAM=
E;
> > >> +}
> > >> +
> > >> +int efi_get_pxe_arch(void)
> > >> +{
> > >> +       if (efi_use_host_arch())
> > >> +               return HOST_PXE_ARCH;
> > >> +
> > >> +       /* http://www.iana.org/assignments/dhcpv6-parameters/dhcpv6-=
parameters.xml */
> > >> +       if (IS_ENABLED(CONFIG_ARM64))
> > >> +               return 0xb;
> > >> +       else if (IS_ENABLED(CONFIG_ARM))
> > >> +               return 0xa;
> > >> +       else if (IS_ENABLED(CONFIG_X86_64))
> > >> +               return 0x6;
> > >> +       else if (IS_ENABLED(CONFIG_X86))
> > >> +               return 0x7;
> > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV32I))
> > >> +               return 0x19;
> > >> +       else if (IS_ENABLED(CONFIG_ARCH_RV64I))
> > >> +               return 0x1b;
> > >> +       else if (IS_ENABLED(CONFIG_SANDBOX))
> >
> > Please, add a warning here:
> >
> >       log_warn("You are using the sandbox in non-compliant mode\n");
> >
> > The riscv64 sandbox can only run riscv64 binaries
> > The arm64 sandbox can only run arm64 binary.
> >
> > We cannot expect a DHCP server to do the expected with the value 0.
> >
> > So why should we introduce this?
> >
> > >> +               return 0;       /* not used */
> >
> > The following comment would fit better:
> >
> >      /* This breaks PXE booting on the sandbox.*/
>=20
> This line is already in the code. I am just moving it to a new file.
> PXE booting is not supported on sandbox. Neither is EFI booting, until
> this series is applied.

It sounds like EFI booting in sandbox is working and being tested and
used (as a testing mechanism) right now. And the work and questions
being raised here are around having your changes not break that existing
use.

--=20
Tom

--dZ6arZLQ92QVZ60X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchD/sACgkQFHw5/5Y0
tyyR/gv/cE3ttURXyXaaVPMhsQD/gbGUHYYvugJj0DxzGXaRF/XStZ+cG0lXsIlQ
MJZuU2B0xyJwrT1IVy6YRRJVNlTd7l7g5fITptUroEBawTYvEUTRwjaYW+zlhWRV
8mGj7HBUC14bqYZZ0GO1ifLziHRdnBjj7hTt7d2b4R3O0K+0Moc8hMVE8bk9hj55
I3VKHonQyomSV5mLdYozNqYWmBzeuhTQyAHnInWXFkrBLSyHXprbFh2t25UAG4U7
xoNCFYyBzjVd2NoVdUICALOwVZP6dr1ab2Q8Rek3Oppn750bdLVkfSsA8UAiIE9k
DxmS41B8TEUHeCoblppDmm8iqADITQegflGUStlYeamb1hTJa04XqJwAN7SIZ+f7
PkOEuVOODOSIAlWvYLwDTlwlQs1YYMBZYUHMVS3LrHfceWXN096VXsVTa0rCo8Qq
Q8TvtYr3ZLEDQ+soeKg5vUR4P9YnxpLE8V8UeVPzinNc73SkAzeWicC74UaINtzy
gdf1Ctxa
=cJz0
-----END PGP SIGNATURE-----

--dZ6arZLQ92QVZ60X--
