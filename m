Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 315C7C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 19:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B8FD875CC;
	Sat,  2 Dec 2023 20:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NAwm81m5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86162875FC; Sat,  2 Dec 2023 20:03:00 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00BB287554
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 20:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5cfc3a48ab2so34557497b3.0
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 11:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1701543776; x=1702148576; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XYyiwo7QZDMPvqxvgzDz547WhTQv6Ag2Xe1syhEMfjU=;
 b=NAwm81m5S5x7BYZa/elSWo0bweUSO/L5XTv6rMFD1tJBx+ecEopOG9Da5G0BXThBte
 LxKwfH2+lY6mYRlyHXHTJmSBm2pf0ydJIsn2ZeqjRVJT6kMXOBwVFcd/4KrXFLMSg9uC
 TmfDLyl3EJH2gIGrQ5ILUCnyZoXwCnWqAeUN4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701543776; x=1702148576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XYyiwo7QZDMPvqxvgzDz547WhTQv6Ag2Xe1syhEMfjU=;
 b=IEpJRFuLPSVbJfNCnfGXBPtnONkdGXIT25bKKs8RtbNgeTwABlyj3Ua2/N3ClIs2WF
 p6WTl/qWDO/HccEQ35mgNb55RCaisYHW5dfz0zxjKGSfZtUEAj+BB4kaJl45BanNMiL9
 N4+yCWs78npZHTMD8QDF29Cax6Ym8xG+SA9OBqU4rJBPylK/U0kQg4c3ZaWhw8fP+a0v
 3TfInVX/W3Wwb9352P4sigqpkDzcKL7AlJyL0gVebaXCR/OOPvvvY8wdSryvOFYMZUPN
 X9iLA6s+bsrZB4V7Zgy+nCrRzLIczhoV4xJRb7c7x66axtFewv7ZWb0CH7Kw6B2MzJuP
 KOkw==
X-Gm-Message-State: AOJu0YzV30g+RnVWJSXHKjq8VNWi7x78u0oxdpv11YFth+4pA6FdEGXm
 sMpeYInPDV2Wd0yFqnRHu3Jy1A==
X-Google-Smtp-Source: AGHT+IHlg1wfMMz0KpQDct+0x+8d0YDatBUqm2OpMhDKq3M7s7PUmx40yqHnBDcxoKupaU1jEIhJzg==
X-Received: by 2002:a81:4c52:0:b0:5d7:1941:aa6 with SMTP id
 z79-20020a814c52000000b005d719410aa6mr1303831ywa.65.1701543776655; 
 Sat, 02 Dec 2023 11:02:56 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6796-c207-4c03-28b8.res6.spectrum.com.
 [2603:6081:7b00:6400:6796:c207:4c03:28b8])
 by smtp.gmail.com with ESMTPSA id
 c184-20020a0ddac1000000b005cb7fccffe2sm1993284ywe.126.2023.12.02.11.02.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 11:02:55 -0800 (PST)
Date: Sat, 2 Dec 2023 14:02:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v2 3/6] smbios: Use SMBIOS 3.0 to support an address
 above 4GB
Message-ID: <20231202190253.GS2513409@bill-the-cat>
References: <20231015024511.3995580-1-sjg@chromium.org>
 <20231015024511.3995580-4-sjg@chromium.org>
 <4ba6fd96-d4aa-45bc-be9d-cb8689606596@gmx.de>
 <CAPnjgZ2QWbVm-=8+E5Yv2ekdWjZ2E1VeS1TJD9rnNUfa+dhrYA@mail.gmail.com>
 <CAC_iWj+7FCrAYt1z1=9o8+6uxYiqG++nc72-XHYiHDtP6Uag0w@mail.gmail.com>
 <20231121204906.GL2513409@bill-the-cat>
 <CAPnjgZ0hXjoxiiQwv8_fF0brYTWpFS3baWVn4H3hoOGAOnPC3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0EME3J83LtmR7oXg"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ0hXjoxiiQwv8_fF0brYTWpFS3baWVn4H3hoOGAOnPC3w@mail.gmail.com>
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


--0EME3J83LtmR7oXg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 02, 2023 at 11:27:15AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Tue, 21 Nov 2023 at 13:49, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Nov 21, 2023 at 10:40:39PM +0200, Ilias Apalodimas wrote:
> > > Hi Simon
> > >
> > > On Tue, 21 Nov 2023 at 04:17, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Heinrich,
> > > >
> > > > On Mon, 20 Nov 2023 at 19:11, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > > > >
> > > > > On 10/15/23 04:45, Simon Glass wrote:
> > > > > > When the SMBIOS table is written to an address above 4GB a 32-b=
it table
> > > > > > address is not large enough.
> > > > > >
> > > > > > Use an SMBIOS3 table in that case.
> > > > > >
> > > > > > Note that we cannot use efi_allocate_pages() since this functio=
n has
> > > > > > nothing to do with EFI. There is no equivalent function to allo=
cate
> > > > > > memory below 4GB in U-Boot. One solution would be to create a s=
eparate
> > > > > > malloc() pool, or just always put the malloc() pool below 4GB.
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Check the end of the table rather than the start.
> > > > > >
> > > > > >   include/smbios.h | 22 +++++++++++++++++++++-
> > > > > >   lib/smbios.c     | 24 +++++++++++++++++++-----
> > > > > >   2 files changed, 40 insertions(+), 6 deletions(-)
> > > > > >
> > > > > > diff --git a/include/smbios.h b/include/smbios.h
> > > > > > index c9df2706f5a6..ddabb558299e 100644
> > > > > > --- a/include/smbios.h
> > > > > > +++ b/include/smbios.h
> > > > > > @@ -12,7 +12,8 @@
> > > > > >
> > > > > >   /* SMBIOS spec version implemented */
> > > > > >   #define SMBIOS_MAJOR_VER    3
> > > > > > -#define SMBIOS_MINOR_VER     0
> > > > > > +#define SMBIOS_MINOR_VER     7
> > > > > > +
> > > > > >
> > > > > >   enum {
> > > > > >       SMBIOS_STR_MAX  =3D 64,   /* Maximum length allowed for a=
 string */
> > > > > > @@ -54,6 +55,25 @@ struct __packed smbios_entry {
> > > > > >       u8 bcd_rev;
> > > > > >   };
> > > > > >
> > > > > > +struct __packed smbios3_entry {
> > > > > > +     u8 anchor[5];
> > > > > > +     u8 checksum;
> > > > > > +     u8 length;
> > > > > > +     u8 major_ver;
> > > > > > +
> > > > > > +     u8 minor_ver;
> > > > > > +     u8 docrev;
> > > > > > +     u8 entry_point_rev;
> > > > > > +     u8 reserved;
> > > > > > +     u32 max_struct_size;
> > > > > > +
> > > > > > +     u64 struct_table_address;
> > > > > > +};
> > > > > > +
> > > > > > +/* These two structures should use the same amount of 16-byte-=
aligned space */
> > > > > > +static_assert(ALIGN(16, sizeof(struct smbios_entry)) =3D=3D
> > > > > > +           ALIGN(16, sizeof(struct smbios3_entry)));
> > > > > > +
> > > > > >   /* BIOS characteristics */
> > > > > >   #define BIOS_CHARACTERISTICS_PCI_SUPPORTED  (1 << 7)
> > > > > >   #define BIOS_CHARACTERISTICS_UPGRADEABLE    (1 << 11)
> > > > > > diff --git a/lib/smbios.c b/lib/smbios.c
> > > > > > index c7a557bc9b7b..92e98388084f 100644
> > > > > > --- a/lib/smbios.c
> > > > > > +++ b/lib/smbios.c
> > > > > > @@ -487,7 +487,11 @@ ulong write_smbios_table(ulong addr)
> > > > > >       addr =3D ALIGN(addr, 16);
> > > > > >       start_addr =3D addr;
> > > > > >
> > > > > > -     addr +=3D sizeof(struct smbios_entry);
> > > > > > +     /*
> > > > > > +      * So far we don't know which struct will be used, but th=
ey both end
> > > > > > +      * up using the same amount of 16-bit-aligned space
> > > > > > +      */
> > > > > > +     addr +=3D max(sizeof(struct smbios_entry), sizeof(struct =
smbios3_entry));
> > > > > >       addr =3D ALIGN(addr, 16);
> > > > > >       tables =3D addr;
> > > > > >
> > > > > > @@ -512,14 +516,24 @@ ulong write_smbios_table(ulong addr)
> > > > > >        * sandbox's DRAM buffer.
> > > > > >        */
> > > > > >       table_addr =3D (ulong)map_sysmem(tables, 0);
> > > > > > -     if (sizeof(table_addr) > sizeof(u32) && table_addr > (ulo=
ng)UINT_MAX) {
> > > > > > +     if (sizeof(table_addr) > sizeof(u32) && addr >=3D (ulong)=
UINT_MAX) {
> > > > >
> > > > > You have to check the end of the the last SMBIOS structure not th=
e start
> > > > > of the first SMBIOS structure against UINT_MAX.
> > > > >
> > > > > > +             struct smbios3_entry *se;
> > > > > >               /*
> > > > > >                * We need to put this >32-bit pointer into the t=
able but the
> > > > > >                * field is only 32 bits wide.
> > > > > >                */
> > > > > > -             printf("WARNING: SMBIOS table_address overflow %l=
lx\n",
> > > > > > -                    (unsigned long long)table_addr);
> > > > > > -             addr =3D 0;
> > > > > > +             printf("WARNING: Using SMBIOS3.0 due to table-add=
ress overflow %lx\n",
> > > > > > +                    table_addr);
> > > > >
> > > > > This should be log_debug().
> > > > >
> > > > > > +             se =3D map_sysmem(start_addr, sizeof(struct smbio=
s_entry));
> > > > > > +             memset(se, '\0', sizeof(struct smbios_entry));
> > > > > > +             memcpy(se->anchor, "_SM3_", 5);
> > > > > > +             se->length =3D sizeof(struct smbios3_entry);
> > > > > > +             se->major_ver =3D SMBIOS_MAJOR_VER;
> > > > > > +             se->minor_ver =3D SMBIOS_MINOR_VER;
> > > > > > +             se->docrev =3D 0;
> > > > > > +             se->entry_point_rev =3D 1;
> > > > > > +             se->max_struct_size =3D len;
> > > > > > +             se->struct_table_address =3D table_addr;
> > > > >
> > > > > You must fill the checksum:
> > > > >
> > > > > se->checksum =3D table_compute_checksum(se, sizeof(struct smbios3=
_entry));
> > > > >
> > > > > With the checksum filled I can use dmidecode in Linux based on the
> > > > > SMBIOS3 table:
> > > > >
> > > > > ubuntu@ubuntu:~$ sudo dmidecode
> > > > > # dmidecode 3.5
> > > > > # SMBIOS3 entry point at 0x27ef53000
> > > > > Found SMBIOS entry point in EFI, reading table from /dev/mem.
> > > > > SMBIOS 3.7.0 present.
> > > > > # SMBIOS implementations newer than version 3.5.0 are not
> > > > > # fully supported by this version of dmidecode.
> > > > > Table at 0x27EF53020.
> > > > >
> > > > > Handle 0x0000, DMI type 0, 24 bytes
> > > > > BIOS Information
> > > > >          Vendor: U-Boot
> > > >
> > > > OK, great, thank you for figuring this out. Do you think this might=
 be
> > > > a reasonable solution for -next ?
> > >
> > > What about [0] ? Do you expect this to land for 2024.01?
> > > I think we should one or the other, unless this is a hotfix for the
> > > upcoming release
> > >
> > > [0] https://lore.kernel.org/u-boot/20231121025818.741258-1-sjg@chromi=
um.org/
> >
> > I would like one of the two smaller changes to be agreed on for v2024.01
> > and we look at the bigger problems for v2024.04 (and heck, that
> > can/should start now) around SMBIOS and memory allocation / reservation.
>=20
> Is this still pending?
>=20
> From my side:
>=20
> - we should not use EFI memory allocation to allocate an SMBIOS table
> - we should create the table on startup, like other tables
>=20
> I believe that [0] is a reasonable fix, given the circumstances.
>=20
> For -next perhaps we should go back to the SMBIOS3 series? I believe
> someone found a bug in it which is why it didn't work properly. We can
> still use SMBIOS2 when <4GB, in case there is a compatibility problem.

Yes, this is still pending and no, you and Heinrich have not yet agreed
on which of your patches is an OK compromise for this release and then
revisit all of the bigger issues that this has uncovered for follow-up
releases.

--=20
Tom

--0EME3J83LtmR7oXg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVrf1oACgkQFHw5/5Y0
tyyauAv+OXml0jItt96nKBj0AV8+YH2McOclw4HhMfajEsYXhMM1LxSGRL1fA1X5
s2uOcCz/5pDQqIsSXU4zuaa9nGvQy86p0g+iohHODe151TjD04DvZdGZl02JEl/b
+kFtb5TfGKaIfmDp83YLmRulBALOaFSFIVAujZ6Z8Vj0IsgIe2NMlT/vQ8Pj8SWJ
gFSEEk0EJI6nZAAnaeNDOBJxI5GQ2VmPOMntrPBb7k6QyFQNkAPdDRRi9+HWsvAP
vo0zvlCFnmCMPa+sWH4ZY5p4d5TqK/YyMW3O2WhB0DxgjBAAekNr/mzdQihYLMmI
11tE25bRGjK9wJuN0b1+DItdd4FOKEjhSsjNDZwNKvg8fyQgq/WA7gIAD9UyUiaN
fHvtZDBDaTIE4HU3F/OhCwcd9+d6jbBCR+W/GdVISqHIkvm6k1FG4mZYJ8B9U3qf
boWs5ywtstcmI5IZzfSUUo86i8WrZZhjEA4KScYeaoU4iyUMtkjBHVGg5vMQJy0F
snLvv4r1
=bjkA
-----END PGP SIGNATURE-----

--0EME3J83LtmR7oXg--
