Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70157C2BBCA
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 23:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7DFC87DD3;
	Fri, 21 Jun 2024 01:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VllaSAre";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C913187DD3; Fri, 21 Jun 2024 01:19:49 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E04A879AF
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 01:19:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-25c4d8ae511so743114fac.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718925586; x=1719530386; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+xAqAe1RydCOyzHmYKRvlcj7UGd4AraJM0pkT4UWUms=;
 b=VllaSArevRRxbtvOdDnboPwSGFaosZugjOiLhQoHhssTSv40gG1qIb4jqUVCOyxoQ1
 7IjGK6LzaLJUZHSrN01JgOS/YkGAJfEnN1BZaX1P6VkYX6kuq3RvCEtoFNrq1GH2l9/a
 KQgUbJb8D9XHx5MfwQVpwmE16xgTMye2pgqeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718925586; x=1719530386;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+xAqAe1RydCOyzHmYKRvlcj7UGd4AraJM0pkT4UWUms=;
 b=FJf3208OVYS7Yq3KWzMFYczcpTvwHBf2kn/qaW/9TN3ifSSHL/CTPy/M2oN6eJFNaN
 dT8Dy3YCrO++RoBLvNcqa8L1USOe9sFDcscvHRVUmERx/U9Vht0MmNa7mNEUofpPpopE
 MbKtD1bXOfx+6unX5de/+4RSYKcsJLMe3Z2Cl1m2btyG/LSqPhEuWMe+chgUBGoVGJxw
 A4YPn6wdpDrSrftmHZw8SNWvHJl/DEalDu7W2mf/7FppZ+ThUVNCrY+e9OCHqG2YCRhx
 KfpPIKpASPEp86/42LvQsQH9WH91khSD02Z15mUjXmyK3UP3jzB197DQGYVuux2vM0kw
 ldSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCImstWtDfkDfQSjc4EE2E/QIN/ljnk4Ql4OVY/WykTw7eZI4KI3JpdBUXR4q/8yzRt7/S3eZhLA6n1OKDAE7CKlcNww==
X-Gm-Message-State: AOJu0Yx3CzLgPUPpcsAFGLS3UcFb+SrTphgzzM9agNFbssE/F2QbOg7R
 kOezPII1TlbJqP6Z3ZRmDSIcvg5kUBG3KRvDlLzoXVDEwU9Z0ncPQ58o9KNWlII=
X-Google-Smtp-Source: AGHT+IGg3E3nQhQyGjRZHeqKVtQCTfzfI7gBA7iHkBfDsD4NLjPWmP9McspwWWQlSo4jD/TLezFyNA==
X-Received: by 2002:a05:6870:970f:b0:24f:e100:ba2d with SMTP id
 586e51a60fabf-25c94d72327mr7280652fac.54.1718925586074; 
 Thu, 20 Jun 2024 16:19:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25cd498cefasm132469fac.24.2024.06.20.16.19.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Jun 2024 16:19:45 -0700 (PDT)
Date: Thu, 20 Jun 2024 17:19:43 -0600
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
Message-ID: <20240620231943.GT68077@bill-the-cat>
References: <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kfESqmW3v18nIVfO"
Content-Disposition: inline
In-Reply-To: <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
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


--kfESqmW3v18nIVfO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 05:05:29PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Jun 2024 at 09:32, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Jun 18, 2024 at 09:03:37PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 18 Jun 2024 at 08:15, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Jun 18, 2024 at 06:43:51AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > > > > > > Hi,
> > > > > > >
> > > > > > > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Hi Heinrich
> > > > > > > >
> > > > > > > > resending the reply, I accidentally sent half of the messag=
e...
> > > > > > > >
> > > > > > > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.g=
lpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > > > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypr=
on.glpk@gmx.de> wrote:
> > > > > > > > > >>
> > > > > > > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > > > > > > >>> Hi Simon,
> > > > > > > > > >>>
> > > > > > > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromi=
um.org> wrote:
> > > > > > > > > >>>>
> > > > > > > > > >>>> It does not make sense to enable all SHA algorithms =
unless they are
> > > > > > > > > >>>> needed. It bloats the code and in this case, causes =
chromebook_link to
> > > > > > > > > >>>> fail to build. That board does use the TPM, but not =
with measured boot,
> > > > > > > > > >>>> nor EFI.
> > > > > > > > > >>>>
> > > > > > > > > >>>> Since EFI_TCG2_PROTOCOL already selects these option=
s, we just need to
> > > > > > > > > >>>> add them to MEASURED_BOOT as well.
> > > > > > > > > >>>>
> > > > > > > > > >>>> Note that the original commit combines refactoring a=
nd new features,
> > > > > > > > > >>>> which makes it hard to see what is going on.
> > > > > > > > > >>>>
> > > > > > > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > > > > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > >>>> ---
> > > > > > > > > >>>>
> > > > > > > > > >>>> Changes in v2:
> > > > > > > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > > > > > > >>>> - Consider MEASURED_BOOT too
> > > > > > > > > >>>>
> > > > > > > > > >>>>    boot/Kconfig | 4 ++++
> > > > > > > > > >>>>    lib/Kconfig  | 4 ----
> > > > > > > > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > > > > >>>>
> > > > > > > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > > > > > > >>>> --- a/boot/Kconfig
> > > > > > > > > >>>> +++ b/boot/Kconfig
> > > > > > > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > > > > > > >>>>    config MEASURED_BOOT
> > > > > > > > > >>>>           bool "Measure boot images and configuratio=
n when booting without EFI"
> > > > > > > > > >>>>           depends on HASH && TPM_V2
> > > > > > > > > >>>> +       select SHA1
> > > > > > > > > >>>> +       select SHA256
> > > > > > > > > >>>> +       select SHA384
> > > > > > > > > >>>> +       select SHA512
> > > > > > > > > >>>>           help
> > > > > > > > > >>>>             This option enables measurement of the b=
oot process when booting
> > > > > > > > > >>>>             without UEFI . Measurement involves crea=
ting cryptographic hashes
> > > > > > > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > > > > > > >>>> --- a/lib/Kconfig
> > > > > > > > > >>>> +++ b/lib/Kconfig
> > > > > > > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > > > > > > >>>>           bool "Trusted Platform Module (TPM) Suppor=
t"
> > > > > > > > > >>>>           depends on DM
> > > > > > > > > >>>>           imply DM_RNG
> > > > > > > > > >>>> -       select SHA1
> > > > > > > > > >>>> -       select SHA256
> > > > > > > > > >>>> -       select SHA384
> > > > > > > > > >>>> -       select SHA512
> > > > > > > > > >>>
> > > > > > > > > >>> I am not sure this is the right way to deal with your=
 problem.
> > > > > > > > > >>> The TPM main functionality is to measure and extend P=
CRs, so shaXXXX
> > > > > > > > > >>> is really required. To make things even worse, you do=
n't know the PCR
> > > > > > > > > >>> banks that are enabled beforehand. This is a runtime =
config of the
> > > > > > > > > >>> TPM.
> > > > > > > > > >>
> > > > > > > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is sele=
cted, U-Boot
> > > > > > > > > >> cannot extend PCRs. So it seems fine to let these two =
select the
> > > > > > > > > >> complete set of hashing algorithms. As Simon pointed o=
ut for
> > > > > > > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_load=
er/Kconfig.
> > > > > > > > > >
> > > > > > > > > > It can. The cmd we have can extend those pcrs -- e.g tp=
m2 pcr_extend 8
> > > > > > > > > > 0xb0000000
> > > > > > >
> > > > > > > That's pretty normal for U-Boot though, since we want to avoi=
d lots of
> > > > > > > growth for things people might want control over. We can enab=
le or
> > > > > > > disable the SHA for the board, if this functionality is used =
outside
> > > > > > > of measured boot and tcg2, but someone is enabling the tpm co=
mmand.
> > > > > > >
> > > > > > > > >
> > > > > > > > > So this patch should also consider CMD_TPM_V2 and CMD_TPM=
_V1.
> > > > > > > > >
> > > > > > > > > TPM v1 only needs SHA-1.
> > > > > > > >
> > > > > > > > I still prefer to imply all algos.
> > > > > > >
> > > > > > > 'imply' would be OK in this case as I can disable it for that=
 board. I
> > > > > > > don't think it is in the spirit of U-Boot though.
> > > > > > >
> > > > > > > isn't someone checking the growth in U-Boot? Or do so few boa=
rds have
> > > > > > > TPMs that it didn't register? The size growth was 3.2KB on
> > > > > > > chromebook_link.
> > > > > >
> > > > > > As always, yes, nearly every PR (I don't check the ones that to=
uch just
> > > > > > a single board for example) gets a world build before/after. In=
 this
> > > > > > case I likely assumed that it was acceptable growth for enabling
> > > > > > features. It sounds like some of the chromebook boards need to =
be
> > > > > > setting the features to cause link failure if a size is exceede=
d?
> > > > >
> > > > > The problem is that some Intel platforms have binary blobs, so the
> > > > > size isn't known unless you have a real blob.
> > > >
> > > > Alright, but can't we put in some limit based on what the current b=
lobs
> > > > are, or look at the last few blob releases and see if they change m=
uch
> > > > in size and put something in? Other platforms have blobs and size
> > > > limits...
> > >
> > > Yes we can duplicate the entry sizes from binman into Kconfig options.
> > > But I am not a fan of that...two variables controlling the same thing
> > > and both can break, with nothing to connect them other than the poor
> > > user.
> > >
> > > I wonder if some magic could solve this, inferring limits from the
> > > binman image. But that is getting into yet another domain...
> >
> > I'm sorry, I just don't see what makes this case different from all of
> > the other cases where we have to include blobs. We know there's X amount
> > of flash available, blobs tend to take up Y and so we set
> > BOARD_SIZE_LIMIT to Z where there's some room for growth in U-Boot but
> > it takes in to account whatever limits the blobs place on us.
>=20
> The difference is that now we are using Binman, we have the limit in
> the image description, so adding it to Kconfig a) involves
> calculations and perhaps guesswork and b) results in two limits stored
> in different places which may conflict.
>=20
> I thought of a way to handle this in Binman, so will send that in the
> next version.

I'm still confused, sorry. This sounds like a whole lot more work than
setting BOARD_SIZE_LIMIT reasonably so that we fail to link and CI
errors out, before we get to buildman and needing to make this case
still fail but with fake blobs.

--=20
Tom

--kfESqmW3v18nIVfO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ0uQ8ACgkQFHw5/5Y0
tyz1awv/dqxSvNOdqL/tEoBce6t6F82kp5u/G1OSY0Q14ffRVbouV9wXC2jpw8Im
kQeFuqdyKnRytGCXq7ZCqfEGUe9DSto/Ete26yoUd2qRl8DafvQhG6tR7iTWNCT0
KQpYlpGI4fcivpfYnUhgMKrY6qOs2Q0l9EzF+BrQII3pDlJOXSjExY5Qm1YsO/2k
ZmBq2QmDhsbuD+rcA/lJTkblzk5wpY/qDmv7/CEIRBYYlITcOLqUTZC6g4DE5/tH
AEsvm7otUMqXqcnHmDq+Li68P6ZS9rqzJ1jxfC/Ufe1WTTngbmTGdHZe/kbfuIGB
g+riVCZC0uJ5jQRHXm+ZJFwkhgyZ3b/44tItT3FMjQztEpxAAC0SVy8TbRPJpx9x
rr4G6mkvguUos7OHYLvsztucNlKp4KSm++CWjDEKb89trF1aIThFf8hvr4B0LBly
eyng+FCd8IFQNSdnU8OJLnn5jNEU8gKAuu5cykcmPYXdREoa0AhDMP6oULylMdzO
CCUx6vdN
=ZnnS
-----END PGP SIGNATURE-----

--kfESqmW3v18nIVfO--
