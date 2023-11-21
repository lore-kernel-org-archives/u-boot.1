Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CFFC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 20:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 563A5870F4;
	Tue, 21 Nov 2023 21:49:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JjLQZTry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F13E87169; Tue, 21 Nov 2023 21:49:12 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B63AE8615A
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 21:49:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5ca53400c8bso27869977b3.1
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 12:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700599748; x=1701204548; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YU8yR3gtIdPwK7al81Yx+rgjw3Hm7zGwsuF/ql6/WDU=;
 b=JjLQZTryPCDTFS719/nfT1fd60atIxCC6QD+Tyz7klxpDCa4T8DBxAG6dbElvQlciK
 Iy2Zi1mGUDSUOiejwfaNrNzbbuqTC+j1XqoF743VxpM6jb47jiSvYl5S2/PwG3Vn2bT6
 yDgeC7/XZ5ikZ6KaTDcyvKj38nGz6JSSCsDys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700599748; x=1701204548;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YU8yR3gtIdPwK7al81Yx+rgjw3Hm7zGwsuF/ql6/WDU=;
 b=EzbPEsQIswsnBud2RZl6twtQ9RKSft3mSXG5Irvn32LN2mXY+xvrdLA8LjnJnKisGQ
 WlxCkRIw+Q5UlKY69P5eNYTHh1FYjvffC1P11wxrbrNtNCjZN1mKDCxz/IB2erx7RFNA
 uAaeHl3al3HXMESurcRpGk1F0Bhg099XjazVjNAVA9jr2usbPGJ9jgcdHRhuU5t1AEeK
 fZ0K2dDyyJ8gU2CHVLBWxaZ1f4Dk9xi2xfH/kdMW4htmZ+VRFgirSmU01UDZnvVCTLsZ
 dohat9vb6jf1adUH5niuXuPhVOFGZ60PiaGsTiAZIHbnuGG3v2uim4Ex9YPgTTwCTkj3
 3sTw==
X-Gm-Message-State: AOJu0YxT93mprKdZLV9L3S2U2uxOOWObb/c5WEOImsveIeQZlYvVyV1O
 MZgeAeZZEj3K1miLySktRw73qg==
X-Google-Smtp-Source: AGHT+IHQVSdYVcG01xoLLAlFJSrqsw1g48mHMklBo7iSc3cBK1kZjOH98RQr7M8iOJxNSL9VP33Jfw==
X-Received: by 2002:a0d:d54b:0:b0:5ca:b66f:c28d with SMTP id
 x72-20020a0dd54b000000b005cab66fc28dmr209053ywd.21.1700599748404; 
 Tue, 21 Nov 2023 12:49:08 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92fa-6f17-75b6-6213.res6.spectrum.com.
 [2603:6081:7b00:6400:92fa:6f17:75b6:6213])
 by smtp.gmail.com with ESMTPSA id
 e2-20020ad45362000000b006779f7e68c9sm4283942qvv.134.2023.11.21.12.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 12:49:07 -0800 (PST)
Date: Tue, 21 Nov 2023 15:49:06 -0500
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
Message-ID: <20231121204906.GL2513409@bill-the-cat>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
 <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
 <CAC_iWj+7FCrAYt1z1=9o8+6uxYiqG++nc72-XHYiHDtP6Uag0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uZtYQ1644WFBFYQL"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+7FCrAYt1z1=9o8+6uxYiqG++nc72-XHYiHDtP6Uag0w@mail.gmail.com>
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


--uZtYQ1644WFBFYQL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 10:40:39PM +0200, Ilias Apalodimas wrote:
> Hi Simon
>=20
> On Tue, 21 Nov 2023 at 04:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Mon, 20 Nov 2023 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > > On 10/15/23 04:45, Simon Glass wrote:
> > > > When the SMBIOS table is written to an address above 4GB a 32-bit t=
able
> > > > address is not large enough.
> > > >
> > > > Use an SMBIOS3 table in that case.
> > > >
> > > > Note that we cannot use efi_allocate_pages() since this function has
> > > > nothing to do with EFI. There is no equivalent function to allocate
> > > > memory below 4GB in U-Boot. One solution would be to create a separ=
ate
> > > > malloc() pool, or just always put the malloc() pool below 4GB.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Check the end of the table rather than the start.
> > > >
> > > >   include/smbios.h | 22 +++++++++++++++++++++-
> > > >   lib/smbios.c     | 24 +++++++++++++++++++-----
> > > >   2 files changed, 40 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/include/smbios.h b/include/smbios.h
> > > > index c9df2706f5a6..ddabb558299e 100644
> > > > --- a/include/smbios.h
> > > > +++ b/include/smbios.h
> > > > @@ -12,7 +12,8 @@
> > > >
> > > >   /* SMBIOS spec version implemented */
> > > >   #define SMBIOS_MAJOR_VER    3
> > > > -#define SMBIOS_MINOR_VER     0
> > > > +#define SMBIOS_MINOR_VER     7
> > > > +
> > > >
> > > >   enum {
> > > >       SMBIOS_STR_MAX  =3D 64,   /* Maximum length allowed for a str=
ing */
> > > > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> > > >       u8 bcd_rev;
> > > >   };
> > > >
> > > > +struct __packed smbios3_entry {
> > > > +     u8 anchor[5];
> > > > +     u8 checksum;
> > > > +     u8 length;
> > > > +     u8 major_ver;
> > > > +
> > > > +     u8 minor_ver;
> > > > +     u8 docrev;
> > > > +     u8 entry_point_rev;
> > > > +     u8 reserved;
> > > > +     u32 max_struct_size;
> > > > +
> > > > +     u64 struct_table_address;
> > > > +};
> > > > +
> > > > +/* These two structures should use the same amount of 16-byte-alig=
ned space */
> > > > +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
> > > > +           ALIGN(16, sizeof(struct smbios3_entry)));
> > > > +
> > > >   /* BIOS characteristics */
> > > >   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED  (1 << 7)
> > > >   #define BIOS_CHARACTERISTICS_UPGRADEABLE    (1 << 11)
> > > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > > index c7a557bc9b7b..92e98388084f 100644
> > > > --- a/lib/smbios.c
> > > > +++ b/lib/smbios.c
> > > > @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
> > > >       addr =3D ALIGN(addr, 16);
> > > >       start_addr =3D addr;
> > > >
> > > > -     addr +=3D sizeof(struct smbios_entry);
> > > > +     /*
> > > > +      * So far we don't know which struct will be used, but they b=
oth end
> > > > +      * up using the same amount of 16-bit-aligned space
> > > > +      */
> > > > +     addr +=3D max(sizeof(struct smbios_entry), sizeof(struct smbi=
os3_entry));
> > > >       addr =3D ALIGN(addr, 16);
> > > >       tables =3D addr;
> > > >
> > > > @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
> > > >        * sandbox's DRAM buffer.
> > > >        */
> > > >       table_addr =3D (ulong)map_sysmem(tables, 0);
> > > > -     if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulong)U=
INT_MAX) {
> > > > +     if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)UINT=
_MAX) {
> > >
> > > You have to check the end of the the last SMBIOS structure not the st=
art
> > > of the first SMBIOS structure against UINT_MAX.
> > >
> > > > +             struct smbios3_entry *se;
> > > >               /*
> > > >                * We need to put this >32-bit pointer into the table=
 but the
> > > >                * field is only 32 bits wide.
> > > >                */
> > > > -             printf("WARNING: SMBIOS table_address overflow %llx\n=
",
> > > > -                    (unsigned long long)table_addr);
> > > > -             addr =3D 0;
> > > > +             printf("WARNING: Using SMBIOS3.0 due to table-address=
 overflow %lx\n",
> > > > +                    table_addr);
> > >
> > > This should be log_debug().
> > >
> > > > +             se =3D map_sysmem(start_addr, sizeof(struct smbios_en=
try));
> > > > +             memset(se, '\0', sizeof(struct smbios_entry));
> > > > +             memcpy(se->anchor, "_SM3_", 5);
> > > > +             se->length =3D sizeof(struct smbios3_entry);
> > > > +             se->major_ver =3D SMBIOS_MAJOR_VER;
> > > > +             se->minor_ver =3D SMBIOS_MINOR_VER;
> > > > +             se->docrev =3D 0;
> > > > +             se->entry_point_rev =3D 1;
> > > > +             se->max_struct_size =3D len;
> > > > +             se->struct_table_address =3D table_addr;
> > >
> > > You must fill the checksum:
> > >
> > > se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3_ent=
ry));
> > >
> > > With the checksum filled I can use dmidecode in Linux based on the
> > > SMBIOS3 table:
> > >
> > > ubuntu@ubuntu:~$ sudo dmidecode
> > > # dmidecode 3.5
> > > # SMBIOS3 entry point at 0x27ef53000
> > > Found SMBIOS entry point in EFI, reading table from /dev/mem.
> > > SMBIOS 3.7.0 present.
> > > # SMBIOS implementations newer than version 3.5.0 are not
> > > # fully supported by this version of dmidecode.
> > > Table at 0x27EF53020.
> > >
> > > Handle 0x0000, DMI type 0, 24 bytes
> > > BIOS Information
> > >          Vendor: U-Boot
> >
> > OK, great, thank you for figuring this out. Do you think this might be
> > a reasonable solution for -next ?
>=20
> What about [0] ? Do you expect this to land for 2024.01?
> I think we should one or the other, unless this is a hotfix for the
> upcoming release
>=20
> [0] https://lore.kernel.org/u-boot/20231121025818.741258-1-sjg@chromium.o=
rg/

I would like one of the two smaller changes to be agreed on for v2024.01
and we look at the bigger problems for v2024.04 (and heck, that
can/should start now) around SMBIOS and memory allocation / reservation.

--=20
Tom

--uZtYQ1644WFBFYQL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVdF78ACgkQFHw5/5Y0
tyzz1Av/Z5ZWvZtRrsEDDB+bto8YgNjq6zBQSND9H4lXUThp/gcpwaxUPQvQKlgC
4C7c88gs1XZ49W3nkeJLCyhGV05Unl+4CCEu+GQY94exadkHZvXxKsMGJZAU/0Su
KO2puIe+6+juAgZPT8VpoeU23C2B0GJ1xTVWvKWBb7fFWYr4gtldJ8Ee2NDLKoga
4h/fA+WRh4AfEpSQSF3brNbQRv7+xcQKVZjTZ5MIHy/v+l1AeyDQ3DVuZgsIUhIS
XhJeOtjgwr60N1QGGdLPrDAS6Eob+8a/Izc39awNOPZ4ZbgQIOPDk/fYdhwbymTO
RtsUe33Ru4WMNJElCoSOXMHTbew4PyNeZvkIn1ccDOsbhlLu9HlVW7SpZh3sktks
uT7UNZzFvn7as5wTAgZNkkyxi6ITYuhUhq8AbJcyeK2Ea5I2uZYI/+exDQfVgTVt
3UIrpzex6WffQvhXa1ezIso1gaAZQKgYzA9NS+X0tc26l+1CkVOBwwKeuhuiNc/1
IDigQ8+J
=LbO4
-----END PGP SIGNATURE-----

--uZtYQ1644WFBFYQL--
