Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4EBAC27C53
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 15:32:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 554588836D;
	Wed, 19 Jun 2024 17:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DcJE4+EB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AE348840F; Wed, 19 Jun 2024 17:32:14 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B50AC882DC
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 17:32:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5b97a071c92so3149704eaf.1
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 08:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718811130; x=1719415930; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JHaY15v4m82+EgvfqYsrBo7W8UVONIUWr9H7AYL25VE=;
 b=DcJE4+EBcuR/vXplP7NiG73Pv55zORpMoMx1ENwr2DTZgdNulUWcsz/+xSKJ79aL45
 qIanr3523DAtSrhNt+rTMcr+IX76n0y1x76tmGU/WUaGMo/IJnQhYbcKdnokVmmzcRYE
 u6MWR8XWBHHCML1FJKd+zJpEf8UQKeS4r+aY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718811130; x=1719415930;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHaY15v4m82+EgvfqYsrBo7W8UVONIUWr9H7AYL25VE=;
 b=WH+47NycnY0gSrtvStdGvoam+OVOHw6LC5TQI1cBw0e/KZFnJvm5UlxBKwKko5xlvB
 w5/IQCkzMAiGt1vWgYqT7DpeKI+sN9nrtdwPLfEq1KQMAhkGuFh7qDG0t7h9NqX4WNU1
 DzeJijHPErj7Ck+IzkPk9l1Tktcly7rPbrMX2OnRCMNeWu7MG26UqeqUJ3DANuKfdghM
 B8m/kX9YhORBmZ+PgkM3gm772BjsNdcPz1q3AhiVIL6/1uwsGb56HsTg6mvTnY8yL8bu
 Ab4rFNpwvzH8jq5ERNiYelLwxVebKgxfJ7IIRBsye+I1yffUlVEUOghy8s+gXS1FjxL3
 Vnkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIuEZAHDxf1iGd3qphqCgePHK9+B7KRLcvcoK8Fl8iwe4c6sbLFg2q81xoubVlScm0XS7Dpn1ZEMiFqXHGudj8psk0Mg==
X-Gm-Message-State: AOJu0Yy2fUyb6jA0Ld2pawhZSg2FIZ9IPKaiWKs9KmVTQP6mfgsUfgPG
 Xx2f7qlyBLAmdQmdCvEbWN3uE/hhwd/dESPqq2BS+oskLjzA/o3al+fOp9K7tRc=
X-Google-Smtp-Source: AGHT+IEmhzH/EfLyCRW0IDzS5njAc6FREvpVEpVgiwiYheBoNTpB5jPdkJctn7YQGTEjenbP1bnbDw==
X-Received: by 2002:a05:6870:55cb:b0:255:1819:b442 with SMTP id
 586e51a60fabf-25c949020efmr3101827fac.8.1718811130314; 
 Wed, 19 Jun 2024 08:32:10 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25983669238sm835636fac.33.2024.06.19.08.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 08:32:09 -0700 (PDT)
Date: Wed, 19 Jun 2024 09:32:07 -0600
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
Message-ID: <20240619153207.GF68077@bill-the-cat>
References: <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SaOAfhAEwIRaTonI"
Content-Disposition: inline
In-Reply-To: <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
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


--SaOAfhAEwIRaTonI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 09:03:37PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 18 Jun 2024 at 08:15, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 18, 2024 at 06:43:51AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > > > > Hi,
> > > > >
> > > > > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > > Hi Heinrich
> > > > > >
> > > > > > resending the reply, I accidentally sent half of the message...
> > > > > >
> > > > > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@=
gmx.de> wrote:
> > > > > > >
> > > > > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> > > > > > > >>
> > > > > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > > > > >>> Hi Simon,
> > > > > > > >>>
> > > > > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > > > > >>>>
> > > > > > > >>>> It does not make sense to enable all SHA algorithms unle=
ss they are
> > > > > > > >>>> needed. It bloats the code and in this case, causes chro=
mebook_link to
> > > > > > > >>>> fail to build. That board does use the TPM, but not with=
 measured boot,
> > > > > > > >>>> nor EFI.
> > > > > > > >>>>
> > > > > > > >>>> Since EFI_TCG2_PROTOCOL already selects these options, w=
e just need to
> > > > > > > >>>> add them to MEASURED_BOOT as well.
> > > > > > > >>>>
> > > > > > > >>>> Note that the original commit combines refactoring and n=
ew features,
> > > > > > > >>>> which makes it hard to see what is going on.
> > > > > > > >>>>
> > > > > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > >>>> ---
> > > > > > > >>>>
> > > > > > > >>>> Changes in v2:
> > > > > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > > > > >>>> - Consider MEASURED_BOOT too
> > > > > > > >>>>
> > > > > > > >>>>    boot/Kconfig | 4 ++++
> > > > > > > >>>>    lib/Kconfig  | 4 ----
> > > > > > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > > >>>>
> > > > > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > > > > >>>> --- a/boot/Kconfig
> > > > > > > >>>> +++ b/boot/Kconfig
> > > > > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > > > > >>>>    config MEASURED_BOOT
> > > > > > > >>>>           bool "Measure boot images and configuration wh=
en booting without EFI"
> > > > > > > >>>>           depends on HASH && TPM_V2
> > > > > > > >>>> +       select SHA1
> > > > > > > >>>> +       select SHA256
> > > > > > > >>>> +       select SHA384
> > > > > > > >>>> +       select SHA512
> > > > > > > >>>>           help
> > > > > > > >>>>             This option enables measurement of the boot =
process when booting
> > > > > > > >>>>             without UEFI . Measurement involves creating=
 cryptographic hashes
> > > > > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > > > > >>>> --- a/lib/Kconfig
> > > > > > > >>>> +++ b/lib/Kconfig
> > > > > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > > > > >>>>           bool "Trusted Platform Module (TPM) Support"
> > > > > > > >>>>           depends on DM
> > > > > > > >>>>           imply DM_RNG
> > > > > > > >>>> -       select SHA1
> > > > > > > >>>> -       select SHA256
> > > > > > > >>>> -       select SHA384
> > > > > > > >>>> -       select SHA512
> > > > > > > >>>
> > > > > > > >>> I am not sure this is the right way to deal with your pro=
blem.
> > > > > > > >>> The TPM main functionality is to measure and extend PCRs,=
 so shaXXXX
> > > > > > > >>> is really required. To make things even worse, you don't =
know the PCR
> > > > > > > >>> banks that are enabled beforehand. This is a runtime conf=
ig of the
> > > > > > > >>> TPM.
> > > > > > > >>
> > > > > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected=
, U-Boot
> > > > > > > >> cannot extend PCRs. So it seems fine to let these two sele=
ct the
> > > > > > > >> complete set of hashing algorithms. As Simon pointed out f=
or
> > > > > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/K=
config.
> > > > > > > >
> > > > > > > > It can. The cmd we have can extend those pcrs -- e.g tpm2 p=
cr_extend 8
> > > > > > > > 0xb0000000
> > > > >
> > > > > That's pretty normal for U-Boot though, since we want to avoid lo=
ts of
> > > > > growth for things people might want control over. We can enable or
> > > > > disable the SHA for the board, if this functionality is used outs=
ide
> > > > > of measured boot and tcg2, but someone is enabling the tpm comman=
d.
> > > > >
> > > > > > >
> > > > > > > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> > > > > > >
> > > > > > > TPM v1 only needs SHA-1.
> > > > > >
> > > > > > I still prefer to imply all algos.
> > > > >
> > > > > 'imply' would be OK in this case as I can disable it for that boa=
rd. I
> > > > > don't think it is in the spirit of U-Boot though.
> > > > >
> > > > > isn't someone checking the growth in U-Boot? Or do so few boards =
have
> > > > > TPMs that it didn't register? The size growth was 3.2KB on
> > > > > chromebook_link.
> > > >
> > > > As always, yes, nearly every PR (I don't check the ones that touch =
just
> > > > a single board for example) gets a world build before/after. In this
> > > > case I likely assumed that it was acceptable growth for enabling
> > > > features. It sounds like some of the chromebook boards need to be
> > > > setting the features to cause link failure if a size is exceeded?
> > >
> > > The problem is that some Intel platforms have binary blobs, so the
> > > size isn't known unless you have a real blob.
> >
> > Alright, but can't we put in some limit based on what the current blobs
> > are, or look at the last few blob releases and see if they change much
> > in size and put something in? Other platforms have blobs and size
> > limits...
>=20
> Yes we can duplicate the entry sizes from binman into Kconfig options.
> But I am not a fan of that...two variables controlling the same thing
> and both can break, with nothing to connect them other than the poor
> user.
>=20
> I wonder if some magic could solve this, inferring limits from the
> binman image. But that is getting into yet another domain...

I'm sorry, I just don't see what makes this case different from all of
the other cases where we have to include blobs. We know there's X amount
of flash available, blobs tend to take up Y and so we set
BOARD_SIZE_LIMIT to Z where there's some room for growth in U-Boot but
it takes in to account whatever limits the blobs place on us.

--=20
Tom

--SaOAfhAEwIRaTonI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZy+fcACgkQFHw5/5Y0
tywfgwv/a85FWR4ZZMKdlHOS0ybftIy18Je/DOsA1jWNYW2tpOW0YZDm/+uxOxcM
LJVLcEllZU4DPUfaMSzPQChJ9ncURW37C3jwdhiY00S8jtLN2gzf6AHtdCcCAM1P
XL3J1pDf8E+gdiNL+yNCDWKmjnPjyDck1PeD3JcB1wVJbU8E0PuUoh0pCV+9R/HS
KMUitdgFwml3TPSVMr/Jo//to1GjhmgiBddNP+qu6n5UvEFmgGcg2cNWes2v08VQ
xSboG5hqeCQeu7j9f/uIMo12GZpLdsFMcpPrPsl4e3SMHtj2I319Ex23PS6uJb5v
nn3tcBr9K5uY7ohUad7KWraQ1HSQfcNDLZShsY610w2wpM6crOrWXd3+c+g6hw34
xKHiIHwJ+ppXRzZSz7l3FSboeaEQ9QB01Is0ZOz7RndCZGyOvd8qxidt5t1OmlPJ
/vWdtww7ohYzUBWZI2h6BOiO48k3nySxxTwctV9EaNQbPEf2SM8n6JltKBH58urE
i4yhvvO+
=/s+f
-----END PGP SIGNATURE-----

--SaOAfhAEwIRaTonI--
