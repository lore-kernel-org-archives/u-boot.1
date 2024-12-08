Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97AC9E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:58:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7725289578;
	Sun,  8 Dec 2024 16:58:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S2jvRoOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2545A8954F; Sun,  8 Dec 2024 16:51:34 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3A75893C4
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:51:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-7b6d23b1449so38415885a.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733673090; x=1734277890; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=aj1XU4F66dOAfF/Zrsat71xu+Jp+tPzXKsAcD8qgT/M=;
 b=S2jvRoOCR+z2ticrxs9BKN7DrMfuVqdr5vUz57To7lIX05FWY9jUUCKNLs+XbbaKKB
 MqyOziSihmF6vhUnYOcKdIJWl1X+SIwR5/mKkASuvU2mJmWpWJjEISc4Frn2BdwbBgyV
 JkUGoXgykfVG68P8mdG1+IugpMFTFDubYUd0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733673090; x=1734277890;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aj1XU4F66dOAfF/Zrsat71xu+Jp+tPzXKsAcD8qgT/M=;
 b=S7x77eiH0XozWaa9NuGRSRw4LPriiR1w6ndElYM7ETboa5rwviFR7mlbTUxpqzeoh/
 CtB+IXL5iFQCynoE+V60sBIpwRtm5IQUxJN3+7LI+ayg5Kn2pwunDvdBSPKg1tbYw18g
 AEyatPlVbhxZeHicZSTWQHQwv7/ObGNDCLMO3nEHNoDEPJitl0MGFQVHH32HkAfFcr75
 iHBaZ7jD2esyVsOwiX007k6M7ztYY3OwUFI+fnZnRYOSBz5rFacAuRs/D/DZTXwSDAFf
 6Nf3qeaAoghvrD02O49d4NYgHYH0/CHSvRKKvGz6KRgCC592OVpIo+syF0Wrej2StUXg
 oGVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXD8h5EPKowy07Pn9aquLqrAugrUGyDUuueuML0Tad9kYcrNqT3c8mYoAoUq86wi0+gb3wJ+MA=@lists.denx.de
X-Gm-Message-State: AOJu0YxrDyve+KYSbC41qHJZQurzFNVqqrKnThlDbUJBaaoSyK8XMHdd
 ZVJKg3jtaV2dAjBbIAE14OUn1o4ZD1dQ05fv8XweQ31hNEwiSN0p2Mv6bG1aFzw=
X-Gm-Gg: ASbGncsBqiW0EiFSbFf/6YfSDYRBxtUg3Va8ESwX0YiYUEuPE1REc+qig/jLswhzoks
 hdHnCHC77CAojxCRwXR+TfQmzpebjCOWUQ9BkuQqm+QyILkLMBDIUIP/MGVP0peSmWpdtGU5EiU
 Q/c1Zfm0RWWPkrgtXF8S5NfZpTKaa20s7FIuX8TGVARUJMr+jgpZZbtretzv7MZAVceufD0n5ik
 14zen/iH5prdU1nr5cdnALTLiPWV7PwQeHFgLqVjqldoMOKt8I=
X-Google-Smtp-Source: AGHT+IHmL/ZnUtjV5zoOmenIjLMA4nXttA9uchG1qHjWhmRGLu+Sroro+gXKPUL96wbUAFUsaxvoGA==
X-Received: by 2002:a05:620a:27c1:b0:7b6:d5ed:6091 with SMTP id
 af79cd13be357-7b6d5ed61camr132024685a.45.1733673090548; 
 Sun, 08 Dec 2024 07:51:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467296c9880sm41825821cf.19.2024.12.08.07.51.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 07:51:29 -0800 (PST)
Date: Sun, 8 Dec 2024 09:51:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, u-boot@lists.denx.de,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Gabor Juhos <j4g8y7@gmail.com>, Hanyuan Zhao <hanyuan-z@qq.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Romain Naour <romain.naour@smile.fr>, Sam Edwards <CFSworks@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH 00/10] Improve UEFI app support
Message-ID: <20241208155123.GG2457179@bill-the-cat>
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <CAFLszThjGaKd3Z8fYaBqANDnyGOtGSF7t-o7B1B70R9q9jYfgA@mail.gmail.com>
 <CAFLszTitRwZbOMd-a0nQKzkBUg1OorNFrGzsdyZPtV9rdfEnyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ib1m0p51LBZNiICN"
Content-Disposition: inline
In-Reply-To: <CAFLszTitRwZbOMd-a0nQKzkBUg1OorNFrGzsdyZPtV9rdfEnyg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sun, 08 Dec 2024 16:58:09 +0100
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


--ib1m0p51LBZNiICN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2024 at 08:28:42AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Sun, 1 Dec 2024 at 09:15, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Matthew,
> >
> > On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wro=
te:
> > >
> > > We run a mixed environment including traditional embedded Linux and
> > > UEFI. For consistency it's valuable to use U-Boot in both cases, but =
on
> > > UEFI systems we want to run the full Linux kernel UEFI boot stub. This
> > > patchset adds support for that, along with various other quality-of-l=
ife
> > > improvements such as automatically finding partitions based on their
> > > GUID, automatic identification of load addresses where the firmware h=
as
> > > given us constraints, support for EFI variable access in the EFI app,
> > > drivers for EFI network adapters and TPMs, support for embedding DTBs=
 in
> > > the EFI app, and a couple of bug fixes.
> > >
> > >
> > > Janis Danisevskis (1):
> > >   Fix efi_bind_block.
> > >
> > > Matthew Garrett (9):
> > >   Add EFI handover support to bootm
> > >   Add part_find command
> > >   Add a command to find a load address
> > >   Hook up EFI env variable support in the EFI app
> > >   Add EFI network driver
> > >   Add UEFI TPM2 driver
> > >   Support separate DTB files with the UEFI app
> > >   Use the correct ramdisk address
> > >   Add command to set an environment variable to an EFI variable
> > >
> > >  Makefile                        |   7 +-
> > >  arch/x86/config.mk              |   2 +-
> > >  arch/x86/lib/bootm.c            |  60 ++++++++----
> > >  arch/x86/lib/elf_x86_64_efi.lds |   4 +
> > >  boot/bootm.c                    |   5 +
> > >  cmd/Kconfig                     |  23 ++++-
> > >  cmd/Makefile                    |   3 +
> > >  cmd/addr_find.c                 |  87 +++++++++++++++++
> > >  cmd/efigetenv.c                 | 133 ++++++++++++++++++++++++++
> > >  cmd/part_find.c                 | 156 ++++++++++++++++++++++++++++++
> > >  drivers/net/Kconfig             |   7 ++
> > >  drivers/net/Makefile            |   1 +
> > >  drivers/net/efi_net.c           | 110 +++++++++++++++++++++
> > >  drivers/tpm/Kconfig             |   7 ++
> > >  drivers/tpm/Makefile            |   1 +
> > >  drivers/tpm/tpm2_efi.c          |  97 +++++++++++++++++++
> > >  include/asm-generic/sections.h  |   1 +
> > >  include/bootm.h                 |   6 ++
> > >  include/efi.h                   |  24 +++++
> > >  include/efi_tcg2.h              |   1 +
> > >  lib/efi/Makefile                |   2 +-
> > >  lib/efi/efi.c                   |   1 +
> > >  lib/efi/efi_app.c               |  41 ++++++++
> > >  lib/efi/efi_app_init.c          | 163 ++++++++++++++++++++++++++++++=
--
> > >  lib/efi/efi_dtb.S               |   6 ++
> > >  lib/efi/efi_vars.c              |  44 +++++++++
> > >  lib/fdtdec.c                    |   3 +
> > >  27 files changed, 967 insertions(+), 28 deletions(-)
> > >  create mode 100644 cmd/addr_find.c
> > >  create mode 100644 cmd/efigetenv.c
> > >  create mode 100644 cmd/part_find.c
> > >  create mode 100644 drivers/net/efi_net.c
> > >  create mode 100644 drivers/tpm/tpm2_efi.c
> > >  create mode 100644 lib/efi/efi_dtb.S
> > >  create mode 100644 lib/efi/efi_vars.c
> > >
> > > --
> > > 2.47.0
> > >
> >
> > Thank you for sending this and for your interesting talk at plumbers.
> > It is a novel approach and potentially provides an alternative to grub
> > and EFI_LOADER, etc.
> >
> > I'd like to try getting this running in CI as we don't have any such
> > tests for the app or payload at present.
>=20
> I'm planning to pull this in as this seems like an important use case.
> I'm not sure how much time Matthew will have for this, and I want to
> avoid this series going stale.
>=20
> The comments which are not 'why do you want to do this?' are fairly
> minor, so I'll send a follow-up to resolve them next week. We should
> also think about what code we could move from lib/efi_loader to
> lib/efi so we can share it with the app.
>=20
> Matthew, thanks again for sending this. if you are planning to do more
> here in the short term, please let me know.

Please don't grab other peoples patch series and pick them up for your,
well, whatever you want to call "ci/master". You can do what you like
with patches you wrote but taking submissions from others is just going
to confuse the situation as to if you are, or are not, forking the
project at this point.

--=20
Tom

--ib1m0p51LBZNiICN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdVwHcACgkQFHw5/5Y0
tyyfZwv8CMWlWjwg6jEejVUxjhJlF6fb3OT2WtPpaNIlYiG9ojJFc4Zh/JxNHF+m
+vjzAwKbiGU/QWsEyarMyega1Cht0+l5u/hEQZDdCXDgludeUpj1+lfMCPWV983C
GN9NCv9xxeTpo88R7kBAWmw5mHSfXSuTuWR8/e3Cr9bY1ZDxmDJxXuohsPtbqQaC
wn/7wzWxH9ihQ4hbcdzlj+GSijFmk3EiNKyrxGibsy++OviMPwGaxUtvVPb/xig+
sXQPkKgCk66Tu+bPuHotWczLr9pO6ev2l19kT4GYwM1eItZdpCupABv/pmrKBv1Z
C9ov/fLVVPzO5iCnUoZsauhthExFhZBQl0GkzKx4OqoGGqJTVP5fratN7WYVTjPW
k/B8xExcB1w6Q2ksKDZd+QhgOaz7bnLGeSWmvw2auQLzjsoeoZiNmRoceFbq/cRC
Ig/T8lk9glXyPTpK2vR+k/PxsR1/egXaCLYH1jGgommguDsiKjKP6kXd2fmRBRJW
qVsCdLxg
=eJbZ
-----END PGP SIGNATURE-----

--ib1m0p51LBZNiICN--
