Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ABDAC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B04358826E;
	Mon, 17 Jun 2024 19:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N4LVAlKc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3BE8826E; Mon, 17 Jun 2024 19:16:31 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 709208819D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-3c9cc681e4fso2302173b6e.0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718644588; x=1719249388; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sV0ofEtPGmvrr+KPI8eV5dY5S82ECsdXlz5nNdDU6OI=;
 b=N4LVAlKcP7rnFJQSh5RGWenCfbAlkvKFjQQMmFtasC2fp9V1IVDb7TNyXk1XlWdz4M
 vtvYcUTOMhamf0hZg2wePuasDFxyQfVBNP9MW+XwHH83tM+0yV89YwFMK+7P/3hqko2d
 p+ykbc9XsxHVyn0gI4sht5oenNZrDxqMe1GsA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718644588; x=1719249388;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sV0ofEtPGmvrr+KPI8eV5dY5S82ECsdXlz5nNdDU6OI=;
 b=wYQ5uguRVBj4eABwTkEK520JnqkqXVjMCgZHyQzvZM0Untgg13E3gs+Vkp4T3LG5tM
 lM1btnI7D7nTJ9YMONMv4VS6Iyrn2p3zzFPz+h4L+hVW0ovkSXVv/vPbfBgR7lwjeUK6
 LyhqsaH4k4D9a03uswUYtz2xmjRa2dFyrybYI/LPqJEdumULU0Gpuano4yLijiOmHPyL
 emWCBzyQrIw9a0mlJr/cL+Fw1x6YL0uGvP03+yeP7QNogS4fus1g43tiROdfx48AABST
 QJnK+KsNcFnTTJS4lsSqMRqI199Q8m/lCnLi9z7hQrVTlKRPJwLUvgl8LD9GBXblXMEH
 BF2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJrxkxEi77wA2x90WZlKVt3xSpG4HEK5qD+s/2Syna/KIHP9LG0AHnX9VFNHAgodsZqc2z7JRffJrhrnHj5oHA8dX0OA==
X-Gm-Message-State: AOJu0YyKm42SNe7Xjw6R0L8XdXANsR7qdTZP67IKR8k3KE7t6ehKg/ma
 v8AeRx2R2PnC6rzMaopFeP8cVpxwJgQIz6riqhIyrbFE9g4J90rTkyJ7p4wHJ/A=
X-Google-Smtp-Source: AGHT+IFwvSijI9jnLr05dbXxOI3hKZ4cc/mVJtdr9chjzRJXKs9CxH0pbuMhpbfKzmTkaGLy6sEcjQ==
X-Received: by 2002:a05:6808:23c1:b0:3d2:4667:171f with SMTP id
 5614622812f47-3d24e8bff3bmr14933944b6e.11.1718644588099; 
 Mon, 17 Jun 2024 10:16:28 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2475e49absm1529465b6e.12.2024.06.17.10.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:16:27 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:16:23 -0600
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
Message-ID: <20240617171623.GY68077@bill-the-cat>
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
 <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
 <14ae7a31-757a-4220-b2a8-20204e3d7aa9@gmx.de>
 <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yYg7OTj/UuG3tAmL"
Content-Disposition: inline
In-Reply-To: <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
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


--yYg7OTj/UuG3tAmL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> Hi,
>=20
> On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Heinrich
> >
> > resending the reply, I accidentally sent half of the message...
> >
> > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de> =
wrote:
> > >
> > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.=
de> wrote:
> > > >>
> > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > >>> Hi Simon,
> > > >>>
> > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrot=
e:
> > > >>>>
> > > >>>> It does not make sense to enable all SHA algorithms unless they =
are
> > > >>>> needed. It bloats the code and in this case, causes chromebook_l=
ink to
> > > >>>> fail to build. That board does use the TPM, but not with measure=
d boot,
> > > >>>> nor EFI.
> > > >>>>
> > > >>>> Since EFI_TCG2_PROTOCOL already selects these options, we just n=
eed to
> > > >>>> add them to MEASURED_BOOT as well.
> > > >>>>
> > > >>>> Note that the original commit combines refactoring and new featu=
res,
> > > >>>> which makes it hard to see what is going on.
> > > >>>>
> > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >>>> ---
> > > >>>>
> > > >>>> Changes in v2:
> > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > >>>> - Consider MEASURED_BOOT too
> > > >>>>
> > > >>>>    boot/Kconfig | 4 ++++
> > > >>>>    lib/Kconfig  | 4 ----
> > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > >>>>
> > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > >>>> index 6f3096c15a6..b061891e109 100644
> > > >>>> --- a/boot/Kconfig
> > > >>>> +++ b/boot/Kconfig
> > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > >>>>    config MEASURED_BOOT
> > > >>>>           bool "Measure boot images and configuration when booti=
ng without EFI"
> > > >>>>           depends on HASH && TPM_V2
> > > >>>> +       select SHA1
> > > >>>> +       select SHA256
> > > >>>> +       select SHA384
> > > >>>> +       select SHA512
> > > >>>>           help
> > > >>>>             This option enables measurement of the boot process =
when booting
> > > >>>>             without UEFI . Measurement involves creating cryptog=
raphic hashes
> > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > >>>> index 189e6eb31aa..568892fce44 100644
> > > >>>> --- a/lib/Kconfig
> > > >>>> +++ b/lib/Kconfig
> > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > >>>>           bool "Trusted Platform Module (TPM) Support"
> > > >>>>           depends on DM
> > > >>>>           imply DM_RNG
> > > >>>> -       select SHA1
> > > >>>> -       select SHA256
> > > >>>> -       select SHA384
> > > >>>> -       select SHA512
> > > >>>
> > > >>> I am not sure this is the right way to deal with your problem.
> > > >>> The TPM main functionality is to measure and extend PCRs, so shaX=
XXX
> > > >>> is really required. To make things even worse, you don't know the=
 PCR
> > > >>> banks that are enabled beforehand. This is a runtime config of the
> > > >>> TPM.
> > > >>
> > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
> > > >> cannot extend PCRs. So it seems fine to let these two select the
> > > >> complete set of hashing algorithms. As Simon pointed out for
> > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
> > > >
> > > > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_exten=
d 8
> > > > 0xb0000000
>=20
> That's pretty normal for U-Boot though, since we want to avoid lots of
> growth for things people might want control over. We can enable or
> disable the SHA for the board, if this functionality is used outside
> of measured boot and tcg2, but someone is enabling the tpm command.
>=20
> > >
> > > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> > >
> > > TPM v1 only needs SHA-1.
> >
> > I still prefer to imply all algos.
>=20
> 'imply' would be OK in this case as I can disable it for that board. I
> don't think it is in the spirit of U-Boot though.
>=20
> isn't someone checking the growth in U-Boot? Or do so few boards have
> TPMs that it didn't register? The size growth was 3.2KB on
> chromebook_link.

As always, yes, nearly every PR (I don't check the ones that touch just
a single board for example) gets a world build before/after. In this
case I likely assumed that it was acceptable growth for enabling
features. It sounds like some of the chromebook boards need to be
setting the features to cause link failure if a size is exceeded?

--=20
Tom

--yYg7OTj/UuG3tAmL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwb2QACgkQFHw5/5Y0
tywmqgwAmVEaKJ7GMucXyq1qC+YS5aFkA2TXS9WvZq1k8E7WEMw1vXGdE2F8ZBpa
V7I74xr7wkXVUXKPGXIbPD5Iy1zlta5ha85YPFsoY5GcFiJr0RfvmXdPS9sGeoSI
VMGjpbJDEIw1zRt0FZ7MF2lj64AxMFOUUXTugRkOT1IroxEyfG3Y6i2sx1YcT2my
ULulqjDOS99BnnSWH5VLULPG0dlBBg3lePpW8xRuceJnr4uidKzTUK5XyJpWmf+d
aK1XH+D256JYWD6bZJ8oyk+55UhuPKPo/QMTKAgX7uyuG8zh0Eb/KvKk3Etn0YFA
nXEm0bVQLaG4PbDaSqVD0nxl5BSxJGrP2j6WnRpxTKLHWwAdKRBXPK6wgQpAolMF
ehP7ISnZnruf8iC+XAaX11A52bjC3+DbBDnLpMfZoEXmSTm4UCCgHixL/6JJOCpD
+GhoHOyieDph/S/B2JigQuJvTeFC3nSNNqzB5EY/z1AQ3Zxb1P+tvOhFqjAnDsh5
yP+jdkQx
=HWty
-----END PGP SIGNATURE-----

--yYg7OTj/UuG3tAmL--
