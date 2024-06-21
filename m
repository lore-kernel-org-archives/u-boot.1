Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9BCC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 16:05:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8404887FBC;
	Fri, 21 Jun 2024 18:05:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qt70YQoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADBCB88059; Fri, 21 Jun 2024 18:05:24 +0200 (CEST)
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com
 [IPv6:2607:f8b0:4864:20::c2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35FE387B77
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 18:05:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-5bae81effd1so1132941eaf.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 09:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718985920; x=1719590720; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ocE/rfXxRct66nNpI6FmJLyd5xFbXlfxl55PmgcqDnY=;
 b=Qt70YQohLEDcdI0UFebIXuw6SngjHDherWJjiM7Fiu5ldsoJY0r9m/e0I/DWHVH/1M
 XMWQ3RwTIpURl1RiATr10Vj1vL8NSpYsdn1I2R6WL7zjQDKI5rAVc7hMNKFS10GCL73e
 Ddg4xAlxD6wGb6cWeg2+poTsKkvlH3BP4khLM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718985920; x=1719590720;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ocE/rfXxRct66nNpI6FmJLyd5xFbXlfxl55PmgcqDnY=;
 b=a9hsDXdglZrQW2ie3Ib0YRtm5f/iY5fViorD119CxSoqewG4LB5t3ETsXJByT5shkL
 z5r2mzeZCqjALZuR03OUVgS+WPK887Sc+hFnsCvYYOiU9QKVJgsIOwgBvPEq1N4kzp92
 15L2lWUHIum3YvgwEJwHzdCeNDI+OzgC5TKLtr3I5sPX/6VxZAgu4odjNoXgw9uCyR4h
 nGN+J/6nIOAjmrrBShPecnNGOq3Vto7FS4FNRglavKW6FGP93Db+jI3CffjQOMLu4jH/
 fKpYF4yB6hFryeN1hgYZWp7yvtSTtw/vDVkSVZxTMdg3yNMAsoV/bLO01mrHXgErqE4e
 ZsFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwgS3qolVUGKwSrqgDTBTYjIMf6z837CE1BZC1nG8DNL50yK4CwnaB+89C48az9QjNp5AUJylCiOztZb/lk7x2NSzbgQ==
X-Gm-Message-State: AOJu0YzdBsYkTCtN6LsZJg5UWSeynUTFVXfyA+B+LCz2sQN0vwCecPv1
 GrTVRM4bCQb8/b4i8NSTmcN3fQ5k9EwmqOoXdYH3TChMv7b9ejNoyFpzjs5Ahv0=
X-Google-Smtp-Source: AGHT+IER0+14jCQ0xaRtxBiKEKXjjD1n0pqWRt4y3vizNgQpm+Iz7odkyJ5DynwPIvQGsy3UkN1Vog==
X-Received: by 2002:a4a:d2db:0:b0:5ba:e1aa:9346 with SMTP id
 006d021491bc7-5c1adbcaa5dmr10389313eaf.4.1718985920541; 
 Fri, 21 Jun 2024 09:05:20 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5c1d55d9b9dsm307641eaf.23.2024.06.21.09.05.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 09:05:20 -0700 (PDT)
Date: Fri, 21 Jun 2024 10:05:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
Message-ID: <20240621160514.GY68077@bill-the-cat>
References: <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
 <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NfiTbHX7VTsQ787X"
Content-Disposition: inline
In-Reply-To: <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
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


--NfiTbHX7VTsQ787X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 08:57:51AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 20 Jun 2024 at 17:19, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Jun 20, 2024 at 05:05:29PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Jun 2024 at 09:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2024 at 09:03:37PM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Tue, 18 Jun 2024 at 08:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Tue, Jun 18, 2024 at 06:43:51AM -0600, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> w=
rote:
> > > > > > > >
> > > > > > > > On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > > > > > > > > Hi,
> > > > > > > > >
> > > > > > > > > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Heinrich
> > > > > > > > > >
> > > > > > > > > > resending the reply, I accidentally sent half of the me=
ssage...
> > > > > > > > > >
> > > > > > > > > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypr=
on.glpk@gmx.de> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > > > > > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <=
xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > >>
> > > > > > > > > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > > > > > > > > >>> Hi Simon,
> > > > > > > > > > > >>>
> > > > > > > > > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@ch=
romium.org> wrote:
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> It does not make sense to enable all SHA algorit=
hms unless they are
> > > > > > > > > > > >>>> needed. It bloats the code and in this case, cau=
ses chromebook_link to
> > > > > > > > > > > >>>> fail to build. That board does use the TPM, but =
not with measured boot,
> > > > > > > > > > > >>>> nor EFI.
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> Since EFI_TCG2_PROTOCOL already selects these op=
tions, we just need to
> > > > > > > > > > > >>>> add them to MEASURED_BOOT as well.
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> Note that the original commit combines refactori=
ng and new features,
> > > > > > > > > > > >>>> which makes it hard to see what is going on.
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > > > > > > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > >>>> ---
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> Changes in v2:
> > > > > > > > > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > > > > > > > > >>>> - Consider MEASURED_BOOT too
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>>    boot/Kconfig | 4 ++++
> > > > > > > > > > > >>>>    lib/Kconfig  | 4 ----
> > > > > > > > > > > >>>>    2 files changed, 4 insertions(+), 4 deletions=
(-)
> > > > > > > > > > > >>>>
> > > > > > > > > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > > > > > > > > >>>> --- a/boot/Kconfig
> > > > > > > > > > > >>>> +++ b/boot/Kconfig
> > > > > > > > > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > > > > > > > > >>>>    config MEASURED_BOOT
> > > > > > > > > > > >>>>           bool "Measure boot images and configur=
ation when booting without EFI"
> > > > > > > > > > > >>>>           depends on HASH && TPM_V2
> > > > > > > > > > > >>>> +       select SHA1
> > > > > > > > > > > >>>> +       select SHA256
> > > > > > > > > > > >>>> +       select SHA384
> > > > > > > > > > > >>>> +       select SHA512
> > > > > > > > > > > >>>>           help
> > > > > > > > > > > >>>>             This option enables measurement of t=
he boot process when booting
> > > > > > > > > > > >>>>             without UEFI . Measurement involves =
creating cryptographic hashes
> > > > > > > > > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > > > > > > > > >>>> --- a/lib/Kconfig
> > > > > > > > > > > >>>> +++ b/lib/Kconfig
> > > > > > > > > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > > > > > > > > >>>>           bool "Trusted Platform Module (TPM) Su=
pport"
> > > > > > > > > > > >>>>           depends on DM
> > > > > > > > > > > >>>>           imply DM_RNG
> > > > > > > > > > > >>>> -       select SHA1
> > > > > > > > > > > >>>> -       select SHA256
> > > > > > > > > > > >>>> -       select SHA384
> > > > > > > > > > > >>>> -       select SHA512
> > > > > > > > > > > >>>
> > > > > > > > > > > >>> I am not sure this is the right way to deal with =
your problem.
> > > > > > > > > > > >>> The TPM main functionality is to measure and exte=
nd PCRs, so shaXXXX
> > > > > > > > > > > >>> is really required. To make things even worse, yo=
u don't know the PCR
> > > > > > > > > > > >>> banks that are enabled beforehand. This is a runt=
ime config of the
> > > > > > > > > > > >>> TPM.
> > > > > > > > > > > >>
> > > > > > > > > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is =
selected, U-Boot
> > > > > > > > > > > >> cannot extend PCRs. So it seems fine to let these =
two select the
> > > > > > > > > > > >> complete set of hashing algorithms. As Simon point=
ed out for
> > > > > > > > > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_=
loader/Kconfig.
> > > > > > > > > > > >
> > > > > > > > > > > > It can. The cmd we have can extend those pcrs -- e.=
g tpm2 pcr_extend 8
> > > > > > > > > > > > 0xb0000000
> > > > > > > > >
> > > > > > > > > That's pretty normal for U-Boot though, since we want to =
avoid lots of
> > > > > > > > > growth for things people might want control over. We can =
enable or
> > > > > > > > > disable the SHA for the board, if this functionality is u=
sed outside
> > > > > > > > > of measured boot and tcg2, but someone is enabling the tp=
m command.
> > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > So this patch should also consider CMD_TPM_V2 and CMD=
_TPM_V1.
> > > > > > > > > > >
> > > > > > > > > > > TPM v1 only needs SHA-1.
> > > > > > > > > >
> > > > > > > > > > I still prefer to imply all algos.
> > > > > > > > >
> > > > > > > > > 'imply' would be OK in this case as I can disable it for =
that board. I
> > > > > > > > > don't think it is in the spirit of U-Boot though.
> > > > > > > > >
> > > > > > > > > isn't someone checking the growth in U-Boot? Or do so few=
 boards have
> > > > > > > > > TPMs that it didn't register? The size growth was 3.2KB on
> > > > > > > > > chromebook_link.
> > > > > > > >
> > > > > > > > As always, yes, nearly every PR (I don't check the ones tha=
t touch just
> > > > > > > > a single board for example) gets a world build before/after=
=2E In this
> > > > > > > > case I likely assumed that it was acceptable growth for ena=
bling
> > > > > > > > features. It sounds like some of the chromebook boards need=
 to be
> > > > > > > > setting the features to cause link failure if a size is exc=
eeded?
> > > > > > >
> > > > > > > The problem is that some Intel platforms have binary blobs, s=
o the
> > > > > > > size isn't known unless you have a real blob.
> > > > > >
> > > > > > Alright, but can't we put in some limit based on what the curre=
nt blobs
> > > > > > are, or look at the last few blob releases and see if they chan=
ge much
> > > > > > in size and put something in? Other platforms have blobs and si=
ze
> > > > > > limits...
> > > > >
> > > > > Yes we can duplicate the entry sizes from binman into Kconfig opt=
ions.
> > > > > But I am not a fan of that...two variables controlling the same t=
hing
> > > > > and both can break, with nothing to connect them other than the p=
oor
> > > > > user.
> > > > >
> > > > > I wonder if some magic could solve this, inferring limits from the
> > > > > binman image. But that is getting into yet another domain...
> > > >
> > > > I'm sorry, I just don't see what makes this case different from all=
 of
> > > > the other cases where we have to include blobs. We know there's X a=
mount
> > > > of flash available, blobs tend to take up Y and so we set
> > > > BOARD_SIZE_LIMIT to Z where there's some room for growth in U-Boot =
but
> > > > it takes in to account whatever limits the blobs place on us.
> > >
> > > The difference is that now we are using Binman, we have the limit in
> > > the image description, so adding it to Kconfig a) involves
> > > calculations and perhaps guesswork and b) results in two limits stored
> > > in different places which may conflict.
> > >
> > > I thought of a way to handle this in Binman, so will send that in the
> > > next version.
> >
> > I'm still confused, sorry. This sounds like a whole lot more work than
> > setting BOARD_SIZE_LIMIT reasonably so that we fail to link and CI
> > errors out, before we get to buildman and needing to make this case
> > still fail but with fake blobs.
>=20
> It is simpler for me, since I don't need to reverse-engineer the space
> requirement for each board. With the patch I sent, I can just add some
> reasonable numbers to each entry and it will do the right thing.

Yes, I very much do not like guessing about 3 numbers instead of
guessing about 1 number and using the standard mechanism we already
have. Please use BOARD_SIZE_LIMIT as this is the standard mechanism to
enforce size limits on U-Boot itself.

--=20
Tom

--NfiTbHX7VTsQ787X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ1pLcACgkQFHw5/5Y0
tyxkjAv5Acc29pPP466rcttPmmb3YVwi171qxVIHFnnNkr5ErNLv8lEyXMjC5/Gz
cWLIn0iJIlCDyj0MmO9gp9x8SITJyd9ArJoIRx+7eUQb0sAGN1MxVtexjCr1oGUS
W3XyGyXE2OyzP11bgHUXlLY/yUm4vs3KMiscZvIBBgnvikWOYlLgvhvM6mx3tg0X
u+Szjm71eIMf58B5BM1NHqVziqenZZsZbK1Q4Q3zeqjnjbXGxUAO4v76OMh6boNU
9IQZhMy4+lEsaD5lr0sNdyCeG7STFeOvFH2HxPkxZSelKsMPg+N9APVPuLvlYH7t
61EFVGgH/YIUkamNBHvkUzk29NKZtae5W/ZE24X3o/zYdVcNQhVnLjxpD+eAlKoe
b1/EeQpMtekG76UDTXUmbsaZue5oTngONJsbgciawRXDF+PFS3zs8v50mgMZkEaa
tkHXCkEDLMvKKZnVVb8ecHYxVXyhs8EAG1MG6mKCdP5vENmCLqyt0r9WQ6vspvg/
lP3ZdDmx
=5g14
-----END PGP SIGNATURE-----

--NfiTbHX7VTsQ787X--
