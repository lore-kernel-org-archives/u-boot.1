Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF7D3CEDDB0
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 15:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCD3683E20;
	Tue, 18 Nov 2025 16:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CAUSaXjz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF87983D07; Tue, 18 Nov 2025 16:11:15 +0100 (CET)
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com
 [IPv6:2607:f8b0:4864:20::a29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B48E83BD2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 16:11:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymondmaoca@gmail.com
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-55b104727c8so1424800e0c.0
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 07:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763478672; x=1764083472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kTHtKyf2J8VplT4nC8JzoY7rfpnGrf4z3c/JC6qAecY=;
 b=CAUSaXjzyRn379c8kiXWCJVtCR13Q5JTYM+ziifWtbzs5ViVg2gCs4riKojLqaIIR3
 jkGR2iYNTTntNS4zT1TUZqtbiADz0/BaZx/HmVJW34HgV4D5EPMHHLrXweYqGyzsqaU6
 A/9/8mKmtx5cdFJu98urOrn4uJ2hI/xGx8YT0rFjZzzRF1QV/2Cz78028em31AN1wpQs
 I9d/BXS1IRb6cCEGPNS9Oqisb5kW+ePVnxQnPXg0UtEv1tWGs8vdySmRyfVY8FgPqtD9
 mabNy1HzzrWEFqI8m8hu17fxklLDwiKeZ/wrOeNhkp6KPjws21/RSKPlJme1FuDaXHTS
 xLSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763478672; x=1764083472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kTHtKyf2J8VplT4nC8JzoY7rfpnGrf4z3c/JC6qAecY=;
 b=XZh8WB139s+OcMGYdijF9hQbukoga3+oEvWpgOxuOEyt4nE+SzveV/+yDuheWe6Sts
 S4Z1b5ToZymiD4lIefmYXX6ESnKnpz9xGV8rKJBScK18ilHwg8QjiCkJKQ/MzDu4EWyW
 yTxwmGaP89MZquda1dIEMl8nLf0zSh37V57ZQtLxjjqYQAk4CYcHkGJAirWpYRqpJcoy
 KD2nsnwr43fWpYzC1vMKCgJJne4/yLHHAEpKtKuI2CqAwuHtJq7307+H6+8Vwb3CAtU+
 t54wJWcM1i4v8aBYL7WRTiaG6eOgpaFWXHpAniGOqFilIVwYFCkbdTjWw6nk3MIa2gbR
 HiJw==
X-Gm-Message-State: AOJu0YxGuNtt69dk4zljlKUZxzfm+SjLPzy/K2/K3/jPib4pkeabhGRy
 euwyUwItOl0B5Y2859anyGLprHc4XAeSisv6xiUGyvK6zhgj8AiUr1O1jDxFedHcjA6528TFND1
 AhPGeyq+f98V3/ljTQMe9/7vR8pdMXjE=
X-Gm-Gg: ASbGnctesJFEatak9lnyCEbfYrI/alv/ZZwurld+MEj8bhUyzMvIwBJ6BFriKACg8cX
 LCUBvQj6IDKnMk1BownaUTyvcfVV2pIB5NkCth/clQahnNInW3ze61WIZUlIgztjPOyMYgFXpEq
 abOvUksF/lnfe69kvQK3e2yBGVEKVaiVfBrTmuC9il9y0C91Iqlc2OwAMEqtpMU2knW0HBybJ+Y
 ELNl+DglhcNFqe8mdVq/Ddg6oInF+B9M2HBZK5OjYkFcRegU29t0Gw63JIodOfE6bclF2+F+mek
 Gjk9
X-Google-Smtp-Source: AGHT+IEQC/QGdsDhZonflAssspr6dDy8n/N+EUpTyYkgIkEZVExnobr4ugA5s2Jimqjv99vFjVmBJ54o/v8NFkcSpsk=
X-Received: by 2002:a05:6102:688d:b0:5d3:fed4:ac2b with SMTP id
 ada2fe7eead31-5dfc54ed3aemr4705306137.1.1763478671647; Tue, 18 Nov 2025
 07:11:11 -0800 (PST)
MIME-Version: 1.0
References: <20251118043042.27726-1-hs@nabladev.com>
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
From: Raymond Mao <raymondmaoca@gmail.com>
Date: Tue, 18 Nov 2025 10:11:00 -0500
X-Gm-Features: AWmQ_bl2nwil8wqBH7lH-gke6NJ_53xmBQlyOMdsoaI5-hA2CislGoejPIkqyD8
Message-ID: <CAMDkj5x_9Vo5S4cA1OGbzhzwNsgs+fKryuLve1mm3H9eK9tLzw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
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
X-Mailman-Approved-At: Tue, 18 Nov 2025 16:24:05 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, Nov 17, 2025 at 11:30=E2=80=AFPM Heiko Schocher <hs@nabladev.com> w=
rote:

>
> Add SM3 secure hash, as specified by OSCCA GM/T 0004-2012 SM3 and describ=
ed
> at https://datatracker.ietf.org/doc/html/draft-sca-cfrg-sm3-02
>
> TPMv2 defines hash algo sm3_256, which is currently
> not supported and prevented TPMv2 chip with newer
> firmware to work with U-Boot. Seen this on a ST33TPHF2XI2C
>
>     u-boot=3D> tpm2 init
>     u-boot=3D> tpm2 autostart
>     tpm2_get_pcr_info: too many pcrs: 5
>     Error: -90
>     u-boot=3D>
>
> Implement sm3 hash, so we can fix this problem.
>
>
Did you add a Measured Boot CI test for SM3 on any boards? The QEMU test
with swtpm I added might not work since it does not support SM3 (Currently
it is configured to SHA256 only) .

Raymond


> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D194&view=3Dresul=
ts
>
> Changes in v3:
> Added Reviewed-by from Ilias
> rebased series to
> commit: 69cc92d6869 ("Merge tag 'efi-2026-01-rc3' of
> https://source.denx.de/u-boot/custodians/u-boot-efi")
> add comments from Ilias
> - use sizeof(*sctx) instead of sizeof(struct sm3_context)
> - use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilias
>   This leaded to CI error:
>   +lib/sm3.c:241:50: error: argument 2 of type =E2=80=98uint8_t[]=E2=80=
=99 {aka =E2=80=98unsigned
> char[]=E2=80=99} with mismatched bound [-Werror=3Darray-parameter=3D]
>   +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output[])
>   +      |                                          ~~~~~~~~^~~~~~~~
>   see:
>
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D192&view=3Dlogs&=
j=3D182673a4-17b9-5c0c-69ad-98f742450579&t=3D34b689f8-3e29-5ffe-50ea-32bfe9=
9f47c7&l=3D334
>   so made this change back to v2 state of the series, to have the same
>   arguments as the other hashes in lib/
> - seperate linux and U-Boot parts into 2 commits
> New in version 3 as Ilias recommended to split linux
> and U-boot changes.
> use CMD_TEST instead of DM_TEST, as Heinrich confirmed
> add comment from Ilias
> - add SM3 support in tcg2_hash_pe_image()
> Added Reviewed-by from Ilias
>
> Changes in v2:
> rebase to
> 6b27b688694: ("Merge branch 'master' of
> https://source.denx.de/u-boot/custodians/u-boot-sh")
> add Ilias to Series-cc
> add sm3_hash to header file, so we can use it.
> add comments from Ilias
> - use ARRAY_SIZE(hash_algo_list) instead of a fix number
>   in tpm2_get_pcr_info() for the count of supported hashes
>   in U-Boot.
> - add SM3 hash in tpm_tcg2
> Added Reviewed-by tag from Heinrich
>
> Heiko Schocher (6):
>   lib: Import rol32 function from Linux
>   lib: import sm3 256 hash parts from linux
>   lib: sm3: implement U-Boot parts
>   test: cmd: hash: add unit test for sm3_256
>   tpm2: add sm3 256 hash support
>   test: cmd: fix a typo in md5 test
>
>  MAINTAINERS               |   7 +
>  boot/Kconfig              |   1 +
>  cmd/Kconfig               |  15 ++
>  cmd/Makefile              |   1 +
>  cmd/sm3sum.c              |  48 ++++++
>  cmd/tpm-v2.c              |   1 +
>  common/hash.c             |  42 ++++-
>  include/linux/bitops.h    |  11 ++
>  include/tpm-v2.h          |  12 ++
>  include/u-boot/sm3.h      |  35 +++++
>  lib/Kconfig               |   7 +
>  lib/Makefile              |   1 +
>  lib/efi_loader/efi_tcg2.c |   3 +
>  lib/sm3.c                 | 312 ++++++++++++++++++++++++++++++++++++++
>  lib/tpm-v2.c              |   4 +-
>  lib/tpm_tcg2.c            |   9 ++
>  test/cmd/hash.c           |  49 +++++-
>  17 files changed, 554 insertions(+), 4 deletions(-)
>  create mode 100644 cmd/sm3sum.c
>  create mode 100644 include/u-boot/sm3.h
>  create mode 100644 lib/sm3.c
>
> --
> 2.20.1
>
> base-commit: 69cc92d6869b8ff4591e5b8850872da34934bab9
>
