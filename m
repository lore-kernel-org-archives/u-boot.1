Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D892CC001DB
	for <u-boot@archiver.kernel.org>; Tue, 15 Aug 2023 14:43:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDD5286993;
	Tue, 15 Aug 2023 16:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zwapeoz0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 878B7863E9; Tue, 15 Aug 2023 16:42:53 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4977786993
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 16:42:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d6265142e21so5302400276.2
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 07:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692110568; x=1692715368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zOAJH4MAf+Rtn7n++VdluNSXEQP7e2aApRPnPMX4aWY=;
 b=Zwapeoz0MHwRTmbb7ESuPDgLfb0/n393Ra7cwPkQ/TRzYErGbYfAMQFoNwv2L1nL+3
 PEVUQAo22+laj0uUDq9yhdoQYiNFVOEKio1MfMydbnTppf3nQdQlQ+oCgPKJzAToH7Y6
 c9SjM9TbVDs7C66tABzCgg4uJYjGEL30DoO1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692110568; x=1692715368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOAJH4MAf+Rtn7n++VdluNSXEQP7e2aApRPnPMX4aWY=;
 b=OGPqThgyiA3FCm8Epy0kHvkFk8VwGpndIg8RJxrxt1n4JmPHWm478+UNPpcu6NhWm2
 Ctg2/xS3X65//yhjhFJiwiz1wMnkCwgbSJg4JGE/W1BN7lYiQdemrzsepX2xLKJZFx7i
 aMKXK6V3mcqAfW9WrLU4zF4mdTIDPvFcjOU/S+5yF70cRP94UtvLU2liW1KtYnGUn2BG
 4sIy0MZBStWvFe0aZfdcyEddWYFxbLWFmNpWE+tQdVs9tOnbiDFhznylnFsekQKfytId
 l4USjXI8PI0F+kahXVbTooPOdeOf9dRn4wbXqcfE8c3IXfncXWBFgy4vc3W4xJ5xyYU7
 c9RA==
X-Gm-Message-State: AOJu0Yy5/dFDp3W7ATLVQwwFPUkd6ETaP9gDcSyEkOx4HHeOXDPQ4RKK
 LU4SLLhoAMjy8ZSTmshxeLvBGg==
X-Google-Smtp-Source: AGHT+IHMFZaG7q4d38KlvYAdpke3x06sm9U8ruqxTWswUS95YzzOBwF0h4lftnmFgsiKVAaQsZm9+g==
X-Received: by 2002:a25:c0d3:0:b0:d62:9b77:a41a with SMTP id
 c202-20020a25c0d3000000b00d629b77a41amr12345909ybf.31.1692110567982; 
 Tue, 15 Aug 2023 07:42:47 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-14d5-2a24-c47a-465f.res6.spectrum.com.
 [2603:6081:7b00:6400:14d5:2a24:c47a:465f])
 by smtp.gmail.com with ESMTPSA id
 7-20020a250707000000b00d0c698ed6b6sm3001042ybh.41.2023.08.15.07.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 07:42:47 -0700 (PDT)
Date: Tue, 15 Aug 2023 10:42:45 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>,
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v9 08/10] sandbox: capsule: Generate capsule related
 files through binman
Message-ID: <20230815144245.GL3630934@bill-the-cat>
References: <20230812055725.252424-1-sughosh.ganu@linaro.org>
 <20230812055725.252424-9-sughosh.ganu@linaro.org>
 <CAPnjgZ2uxYuOuBDS9Uf2ntwcNh=yWdyDVvE+-m_-ra+dsiEBSA@mail.gmail.com>
 <CADg8p95WCjvui2j1f_4o_CL9Zn8ULbUeC3oHEamQvLVmvHNdLQ@mail.gmail.com>
 <CAPnjgZ3PxxOcTs9u5AzxpRJDtWiY19YzhJkTiC-vgmXGp4kymQ@mail.gmail.com>
 <CADg8p95GXbc5cWGK3jtwK1=zsRDV_6h3z_BCj71MrW5LZJOnZw@mail.gmail.com>
 <CAPnjgZ2pTsvL8GhiDHyEchGJkiMMQCtLt+hfaK3tNxbHPTVnhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yAMimP1AWdosc3tv"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ2pTsvL8GhiDHyEchGJkiMMQCtLt+hfaK3tNxbHPTVnhQ@mail.gmail.com>
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


--yAMimP1AWdosc3tv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 04:51:13PM -0600, Simon Glass wrote:
> Hi Sughosh,
>=20
> On Mon, 14 Aug 2023 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrot=
e:
> >
> > hi Simon,
> >
> > On Sat, 12 Aug 2023 at 22:33, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Sat, 12 Aug 2023 at 09:40, Sughosh Ganu <sughosh.ganu@linaro.org> =
wrote:
> > > >
> > > > hi Simon,
> > > >
> > > > On Sat, 12 Aug 2023 at 19:55, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > On Fri, 11 Aug 2023 at 23:58, Sughosh Ganu <sughosh.ganu@linaro.o=
rg> wrote:
> > > > > >
> > > > > > The EFI capsule files can now be generated as part of u-boot
> > > > > > build through binman. Add capsule entry nodes for the sandbox
> > > > > > architecture for generating the capsules. These capsules are th=
en used
> > > > > > for testing the EFI capsule update functionality on the sandbox
> > > > > > platforms.
> > > > > >
> > > > > > Remove the corresponding logic in the test setup which was used=
 for
> > > > > > generation of these capsule which is now superfluous.
> > > > > >
> > > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > > ---
> > > > > > Changes since V8:
> > > > > > * Build the capsules for all sandbox variants.
> > > > > > * Remove the type property by renaming the capsule nodes as
> > > > > >   'efi-capsule'.
> > > > > >
> > > > > >  arch/sandbox/dts/sandbox.dts                  |   2 +
> > > > > >  arch/sandbox/dts/sandbox_capsule.dtsi         | 315 ++++++++++=
++++++++
> > > > > >  arch/sandbox/dts/test.dts                     |   2 +
> > > > > >  include/sandbox_efi_capsule.h                 |  21 ++
> > > > > >  test/py/tests/test_efi_capsule/conftest.py    | 155 +--------
> > > > > >  .../tests/test_efi_capsule/uboot_bin_env.its  |  36 --
> > > > > >  6 files changed, 356 insertions(+), 175 deletions(-)
> > > > > >  create mode 100644 arch/sandbox/dts/sandbox_capsule.dtsi
> > > > > >  create mode 100644 include/sandbox_efi_capsule.h
> > > > > >  delete mode 100644 test/py/tests/test_efi_capsule/uboot_bin_en=
v.its
> > > > >
> > > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > >
> > > > > One way to reduce the files is to put all the capsules in the same
> > > > > binman image. You could have 'size =3D <0x1000>' so they are all =
the
> > > > > same size.
> > > > >
> > > > > Then your test could check each one by iterating through the (sin=
gle) file.
> > > >
> > > > This won't work, as the UEFI specification defines a particular for=
mat
> > > > of the capsule file. For multiple capsules, the individual capsule
> > > > files need to be present under the /EFI/UpdateCapsule/ directory on
> > > > the EFI System Partition. The spec does define a format in which a
> > > > single capsule file can have multiple payloads(input binaries). This
> > > > is planned to be supported once support has been added for generati=
ng
> > > > capsules through the config file.
> > >
> > > We continue to have challenges getting confused between testing and r=
eal world.
> > >
> > > For testing, we can do all sorts of things to make things simpler. We
> > > don't even need an EFI partition, etc. We can have a test which checks
> > > that U-Boot can decode an update and apply it, The current tests rely
> > > far too much on an end-to-end, black-box approach, as I might have
> > > mentioned.
> >
> > Okay, but I am stating the constraints on using a single combined file
> > based on the way the tests work today. So if we were to generate a
> > single file consisting of all the individual capsule files, that would
> > break the tests. That was my point.
>=20
> Sure...my point is that the tests could use a bit of rework to make
> them easier and faster to run.

We also need to test them how they're functionally used. At some level
I'd be "fine" if we had "test individual parts of the framework" tests
in sandbox and "test as they're used" tests in QEMU.

--=20
Tom

--yAMimP1AWdosc3tv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTbjuUACgkQFHw5/5Y0
tywNVAv9GEUdF0eLZDOwBO0OQ5lNWz1dM2jjsIdLClKwNYs234yd/rrgZybr70pZ
7firD8I5AEXhJ4dUCt65BZT5nYJMXrvC8fNGdFsmcGBDY2I6CvHenJD7NWDgeRST
nGZY6O7uzvE3JiZZklEIwZM7Di2xm7F5YmUSu/pwgJJ4scBT0dL75hGGqEDiFUBS
FRqQYS5d/gT/PP3ZrqG7PgQpC/UYpL6QSDvdN7BEPsdtLEHr2aZEdT/sQS1Qkvtg
3lY4HagzLWpF/ep3teD4M5+dfgYGHv8PzneIUCfvX3zsGuIYzoV6xIqTJq2PJWDR
Zv8dDnSPoxB5pvDqlIexX4o3zY3vHi5RbESjoSStxzOM7BnPfvE7BV9YnJmQBefX
wrCmvreki0awB0DiBg6xTJ/srdvj/ULFIvD0LwfKQNLte4zyrKu7oJ4EPE+Itco3
YSs1HpuJCOaQVN0YsoKFo2szikVQdtznKbHMSEzhmT86UeiZ0l56lxlPiruF/3U8
bpTv2JHf
=hAuw
-----END PGP SIGNATURE-----

--yAMimP1AWdosc3tv--
