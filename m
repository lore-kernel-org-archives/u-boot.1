Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAEBCF258C
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 09:53:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E0683F53;
	Wed, 19 Nov 2025 10:51:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nzOKO0XT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6258397D; Wed, 19 Nov 2025 08:19:15 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8691583979
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 08:19:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-63e19642764so5407759d50.1
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 23:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763536751; x=1764141551; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmPVobL37mZt+21+TcDyxvrLgF8h9IXXdEA0llSD/6I=;
 b=nzOKO0XTIcKFSMRBtdWf/EAGDz7QOfVXcy84hObcni4UJyr9U3YY00OkaorRYhwmUo
 bi337E066rmCNDV4u5UvITzcVSm1LAEzb0pH+LyAwLtx2nZJDtS7hTq2pYnzSS85JF0a
 LW7AGB1N5uHEDdXXU1ICypmG/y1d8Qk9DBw96/U41TYqgJsMMVRX/ASqgxUwy5WMnZwB
 vmbVzNj+AND2x4zVCkNJaChmspj/GS8XwuWINY3iwZPTa4wE+IVE+lYKtqGmltKsbckB
 QHTqYfmcIKghd6AI1dPmqYhly/y7gR5zJjf4dhjDg68bnLyMTBZ1S8ZEp0nSQCRoLZLZ
 l16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763536751; x=1764141551;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UmPVobL37mZt+21+TcDyxvrLgF8h9IXXdEA0llSD/6I=;
 b=QIKmekQ27irilHfxHuPWCM9g9RO/47h303A21tth30w3i8aZ5y6bblSguyioW2xfxH
 fcTu/ymWMGhfEsLJnFs7qdWrwkgpIpkniEC6ignBxh8VgDL6ac5sOvryvrpHunBzEjYj
 0dMxjV0JfdWSraSJBJVb1MmmTGUDpF1NKWyOvRRrG/p8RV8YkB4g+qsBbc2xDOi4xgg6
 BisiF7zXrQck5laGRdtc8a7gcw2t2nyVsrNpwOL9eHLgLoU7PQgLhDBO1KUcnT1AFhxQ
 yPzIKtw9sggWIMi4i8QVDp20Po5lWnDpePP0JN9KLk6/kIq3AQUSk10wquMNc7Y2bZ6B
 QYVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX1bYaDHOUymNfFnQOptT1WzEsoyK5UhSWqau9rzvo4m4N7uGpm4ljSDPgofxDVkb9+1pbcFs=@lists.denx.de
X-Gm-Message-State: AOJu0YxKJDwtVrAI5hY5FEnJWzk35LCbLq+6FkGC4zsgtEVT22gTsIkL
 kAXNKk2jzjJA4fQ4sVh7J13/I4TJdpSYmSM7jz9lA48qcYW7UJtJ9RekRfJKCGP2T5x6phbAzIv
 j8/3CU/kpsgFiUjBz88DcJ7pUvLTXxl1o3zeqZn+ieQ==
X-Gm-Gg: ASbGncsOCO62pPEQGC4XclvgN0R8jROl1EqmI84SpBad1Kk0pkeTlB5GSxfvzCemvlc
 krXdJEtgSs3zp/j9vKsfmpm/8DaUH7WLDqfdSrgLf8gOQZRsuelO5NlzFBz1DTpVQMABtcMzFH9
 H1LrkrhXxCOVzQSyDT4H6i5pzs5mz/cwjDP87NJpRo7CMyOLHFaqcaM+mH1iEahq+uVjyJ+Ggkl
 HdUa3Myjl6ysqc3Y2Ha4/10cgVSVZYnAUfiJx7xKcqsR1w4CRoYqahEpdNRelrufimmUaMnqfgD
 bbsnwYcK/nHWU8bO2OtNZUaVdn+Zhz6yXOf5URIxyrhGcsmDBmqtpn/2zKNy
X-Google-Smtp-Source: AGHT+IEXQ+2qRXzEGTMIJBkfOmN4Yb3mL2yhCdQ0rPKPptKAKqHCYVJ1b0/6ptn1PfyfqNG4BD6jVebiIsPlfb2OEnw=
X-Received: by 2002:a05:690e:c4c:b0:63f:9d50:fdfe with SMTP id
 956f58d0204a3-641e76ec3acmr14882962d50.56.1763536751050; Tue, 18 Nov 2025
 23:19:11 -0800 (PST)
MIME-Version: 1.0
References: <20251118043042.27726-1-hs@nabladev.com>
 <CAMDkj5x_9Vo5S4cA1OGbzhzwNsgs+fKryuLve1mm3H9eK9tLzw@mail.gmail.com>
 <2d9173e4-6b86-79d6-8d7d-f6d953efe61d@nabladev.com>
In-Reply-To: <2d9173e4-6b86-79d6-8d7d-f6d953efe61d@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 19 Nov 2025 09:18:34 +0200
X-Gm-Features: AWmQ_bl6ItJ4WXPKfSoEf9CUhutNGA3ECGSbodVdzavYbOYRRoAww1Oyj0YIMY0
Message-ID: <CAC_iWjL9cCDCjnSvFBsiM9VHHDKO9e_ber8eceG5iYqE_n+xRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
To: Heiko Schocher <hs@nabladev.com>
Cc: Raymond Mao <raymondmaoca@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut@mailbox.org>, Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, Peng Fan <peng.fan@nxp.com>, 
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Raymond Mao <raymond.mao@linaro.org>,
 Sean Edmond <seanedmond@microsoft.com>, Simon Glass <sjg@chromium.org>, 
 Stefan Roese <stefan.roese@mailbox.org>, Sumit Garg <sumit.garg@kernel.org>, 
 Tom Rini <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 19 Nov 2025 10:51:00 +0100
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

Hi Heiko,

On Wed, 19 Nov 2025 at 07:40, Heiko Schocher <hs@nabladev.com> wrote:
>
> Hi Raymond, Ilias,
>
> On 18.11.25 16:11, Raymond Mao wrote:
> > Hi Heiko,
> >
> > On Mon, Nov 17, 2025 at 11:30=E2=80=AFPM Heiko Schocher <hs@nabladev.co=
m <mailto:hs@nabladev.com>> wrote:
> >
> >
> >     Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and d=
escribed
> >     at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
> >     <https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02>
> >
> >     TPMv2 defines hash algo sm3_256, which is currently
> >     not supported and prevented TPMv2 chip with newer
> >     firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
> >
> >          u-boot=3D> tpm2 init
> >          u-boot=3D> tpm2 autostart
> >          tpm2_get_pcr_info: too many pcrs: 5
> >          Error: -90
> >          u-boot=3D>
> >
> >     Implement sm3 hash, so we can fix this problem.
> >
> >
> > Did you add a Measured Boot CI test for SM3 on any boards? The QEMU tes=
t with swtpm I added might
> > not work since it does not support SM3 (Currently it is configured to S=
HA256 only) .
>
> Not yet, I have to look how I can setup this, as Ilias also mentioned
> that. Any chance to setup this with QEMU and swptm ? Ah, if I see it
> correct no SM3 support yet in swtpm ?

Yes that's the problem. swtpm does not support SM3 and I can't test
locally. If you just boot any OS, the measurements should appear since
the functionality is supported by all the major distros and OE.

Regards
/Ilias
>
> bye,
> Heiko
> >
> > Raymond
> >
> >     Azure build:
> >     https://dev.azure.com/hs0298/hs/_build/results?buildId=3D194&view=
=3Dresults
> >     <https://dev.azure.com/hs0298/hs/_build/results?buildId=3D194&view=
=3Dresults>
> >
> >     Changes in v3:
> >     Added Reviewed-by from Ilias
> >     rebased series to
> >     commit: 69cc92d6869 ("Merge tag 'efi-2026-01-rc3' of
> >     https://source.denx.de/u-boot/custodians/u-boot-efi
> >     <https://source.denx.de/u-boot/custodians/u-boot-efi>")
> >     add comments from Ilias
> >     - use sizeof(*sctx) instead of sizeof(struct sm3_context)
> >     - use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilia=
s
> >        This leaded to CI error:
> >        +lib/sm3.c:241:50: error: argument 2 of type =E2=80=98uint8_t[]=
=E2=80=99 {aka =E2=80=98unsigned char[]=E2=80=99} with
> >     mismatched bound [-Werror=3Darray-parameter=3D]
> >        +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output=
[])
> >        +      |                                          ~~~~~~~~^~~~~~=
~~
> >        see:
> >     https://dev.azure.com/hs0298/hs/_build/results?buildId=3D192&view=
=3Dlogs&j=3D182673a4-17b9-5c0c-69ad-98f742450579&t=3D34b689f8-3e29-5ffe-50e=
a-32bfe99f47c7&l=3D334
> >     <https://dev.azure.com/hs0298/hs/_build/results?buildId=3D192&view=
=3Dlogs&j=3D182673a4-17b9-5c0c-69ad-98f742450579&t=3D34b689f8-3e29-5ffe-50e=
a-32bfe99f47c7&l=3D334>
> >        so made this change back to v2 state of the series, to have the =
same
> >        arguments as the other hashes in lib/
> >     - seperate linux and U-Boot parts into 2 commits
> >     New in version 3 as Ilias recommended to split linux
> >     and U-boot changes.
> >     use CMD_TEST instead of DM_TEST, as Heinrich confirmed
> >     add comment from Ilias
> >     - add SM3 support in tcg2_hash_pe_image()
> >     Added Reviewed-by from Ilias
> >
> >     Changes in v2:
> >     rebase to
> >     6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-bo=
ot/custodians/u-boot-sh
> >     <https://source.denx.de/u-boot/custodians/u-boot-sh>")
> >     add Ilias to Series-cc
> >     add sm3_hash to header file, so we can use it.
> >     add comments from Ilias
> >     - use ARRAY_SIZE(hash_algo_list) instead of a fix number
> >        in tpm2_get_pcr_info() for the count of supported hashes
> >        in U-Boot.
> >     - add SM3 hash in tpm_tcg2
> >     Added Reviewed-by tag from Heinrich
> >
> >     Heiko Schocher (6):
> >        lib: Import rol32 function from Linux
> >        lib: import sm3 256 hash parts from linux
> >        lib: sm3: implement U-Boot parts
> >        test: cmd: hash: add unit test for sm3_256
> >        tpm2: add sm3 256 hash support
> >        test: cmd: fix a typo in md5 test
> >
> >       MAINTAINERS               |   7 +
> >       boot/Kconfig              |   1 +
> >       cmd/Kconfig               |  15 ++
> >       cmd/Makefile              |   1 +
> >       cmd/sm3sum.c              |  48 ++++++
> >       cmd/tpm-v2.c              |   1 +
> >       common/hash.c             |  42 ++++-
> >       include/linux/bitops.h    |  11 ++
> >       include/tpm-v2.h          |  12 ++
> >       include/u-boot/sm3.h      |  35 +++++
> >       lib/Kconfig               |   7 +
> >       lib/Makefile              |   1 +
> >       lib/efi_loader/efi_tcg2.c |   3 +
> >       lib/sm3.c                 | 312 +++++++++++++++++++++++++++++++++=
+++++
> >       lib/tpm-v2.c              |   4 +-
> >       lib/tpm_tcg2.c            |   9 ++
> >       test/cmd/hash.c           |  49 +++++-
> >       17 files changed, 554 insertions(+), 4 deletions(-)
> >       create mode 100644 cmd/sm3sum.c
> >       create mode 100644 include/u-boot/sm3.h
> >       create mode 100644 lib/sm3.c
> >
> >     --
> >     2.20.1
> >
> >     base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
> >
>
> --
> Nabla Software Engineering
> HRB 40522 Augsburg
> Phone: +49 821 45592596
> E-Mail: office@nabladev.com
> Gesch=C3=A4ftsf=C3=BChrer : Stefano Babic
