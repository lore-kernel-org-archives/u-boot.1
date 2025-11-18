Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19070CEDD81
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 13:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 491E383BD2;
	Tue, 18 Nov 2025 14:14:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E0jWwMmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1F1B83CC7; Tue, 18 Nov 2025 11:06:49 +0100 (CET)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ABDD83C65
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 11:06:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-640c9c85255so5549280d50.3
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 02:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763460406; x=1764065206; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ11XSMyBbz9nf1VFGnmkyVBkkwh00ye8WEQyp8dGzE=;
 b=E0jWwMmchhraSjVnQcM00RcguPYbXKsz5QgXFefhyf/sPLtGqkVA+q3LcAw9YaqhJK
 rfpniIcMSN1sfv1nQq0O5bxh6I3nAJZSvm+3rt2P9XiGTT2uTxGTqN4+4x6CXt1/E2k+
 VH7WDt3fLe9Toua0jTPPmfkESY2b+22v2/XAYxclHtBzi5XbfJGF4ABbdeguiiZoVLAh
 HuB/SdqWHXTdpG+bJKhEh3tXSf3BZYVjifxlgafSihEYBdypOYYzMXvXeDDnqRGKJLOu
 kiD5pndEn8WpNqh0VL+yMJyMRMS6gtHuF0Ty7u4XXYc/1mp1KNdtTa/95t++hEhhlnhn
 8pxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763460406; x=1764065206;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GJ11XSMyBbz9nf1VFGnmkyVBkkwh00ye8WEQyp8dGzE=;
 b=Cq8GcH6i62DbbqJIaNtiljo9TYl96D/FzJMtu8saO6quxZTNghRoQgLiHtP9u/m/5F
 eoaZwRHbpHEInyqGoMvYRs+Q1BW4Y3UzSalhFv12VyTMIJE0BCqW5KKqlY1Zd13h+vwg
 wza1Q0RA41l3toCrlml69PfWNS4ycyX2RvbyvnS2F83bo7BafPhLos/CW4bErTQaPP2c
 /vQ6eJxu98t518TgYsZYQKlJLR6JqaP6OxFiyMN6rOcPPweGscjTHmVjS9DQb2ZUnQxJ
 wAzeHwqoOgdtvXuzNr7AycyqAeBl/FZLdgmhkh52P76+v8uPFNdZK/BXCAs9com/Mxyx
 1lTg==
X-Gm-Message-State: AOJu0Yy+6qh+dNt9VKkzJrAuVKcyQRvELmO44gL2kR7W6nhyPakpyrUi
 ss4RXaZUlMNUrmQBRe1/iCiJSe79FxMrXibcMwy45ej6aHOzcBMHqJcB/w4gva5bqUrx5LfWa0p
 6+GPOGapLdPFKkNOoq5L+65C7y8btNK4mUCtI65FOFw==
X-Gm-Gg: ASbGncs3bzq9CN5UwnlE2K0xaLqWQwkKKYR5j4WCBKHwi6465MLTkTRuCAQ/LAyn9xd
 DK3YdMjvVsKJWYWAZ6xtjMSNXtA29ULefwWw/7CTQ771xyWVJ9jx8EYkuCDKLphhcY8t8pX+M//
 o/beQVnYziTxtAt91u6vAxc0CPCu1TlmA/CF9jgRF2uyfEoKxsQTX5x3KbbooCbMlCWc3ndfRL0
 GutEhufBHLDh3Y3KPsVDzWgDhXf8urhaI0AJlT7Ez+7F/nJE+A6txtrMKau4td+0DGuS5c0uYiC
 ktxP5/s/894jdFiI1Kv7qRRl7Hc/RPYMwiJBX+k1nbZ6doXBZ8SM/9IEq8Hbzg==
X-Google-Smtp-Source: AGHT+IHuyjdqG4iibfG/dapJtG9q6p3KHEv3y0NCcPCiCEyz6vuJhEzZv5GdAgpli5JrtvU9FmwPrDk5r7/rU3kLGF4=
X-Received: by 2002:a05:690e:248a:b0:63f:9f7d:904a with SMTP id
 956f58d0204a3-641e76b89d7mr11456557d50.61.1763460405764; Tue, 18 Nov 2025
 02:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20251118043042.27726-1-hs@nabladev.com>
In-Reply-To: <20251118043042.27726-1-hs@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 18 Nov 2025 12:06:10 +0200
X-Gm-Features: AWmQ_bl8nxUgXJD0lSX83qHOD40I3jfRq9tRzIweC3gSzOvj0faPob85tgladu8
Message-ID: <CAC_iWjL8zw-tfq_a4rLjC1-jigHd6g4FqOkgZJG-yD2UfCenVQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Add support for SM3 secure hash
To: Heiko Schocher <hs@nabladev.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, 
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
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Simon Glass <sjg@chromium.org>, Stefan Roese <stefan.roese@mailbox.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 briansune <briansune@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 18 Nov 2025 14:14:53 +0100
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

Thanks for the patience on this.

On Tue, 18 Nov 2025 at 06:31, Heiko Schocher <hs@nabladev.com> wrote:
>
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

Did you manage to boot linux as well with it? Are the SM3 measurements pres=
ent?

Thanks
/Ilias
>
> Azure build:
> https://dev.azure.com/hs0298/hs/_build/results?buildId=3D194&view=3Dresul=
ts
>
> Changes in v3:
> Added Reviewed-by from Ilias
> rebased series to
> commit: 69cc92d6869 ("Merge tag 'efi-2026-01-rc3' of https://source.denx.=
de/u-boot/custodians/u-boot-efi")
> add comments from Ilias
> - use sizeof(*sctx) instead of sizeof(struct sm3_context)
> - use output[] instead of output[SM3_DIGEST_SIZE] comment from Ilias
>   This leaded to CI error:
>   +lib/sm3.c:241:50: error: argument 2 of type =E2=80=98uint8_t[]=E2=80=
=99 {aka =E2=80=98unsigned char[]=E2=80=99} with mismatched bound [-Werror=
=3Darray-parameter=3D]
>   +  241 | void sm3_final(struct sm3_context *sctx, uint8_t output[])
>   +      |                                          ~~~~~~~~^~~~~~~~
>   see:
>   https://dev.azure.com/hs0298/hs/_build/results?buildId=3D192&view=3Dlog=
s&j=3D182673a4-17b9-5c0c-69ad-98f742450579&t=3D34b689f8-3e29-5ffe-50ea-32bf=
e99f47c7&l=3D334
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
> 6b27b688694: ("Merge branch 'master' of https://source.denx.de/u-boot/cus=
todians/u-boot-sh")
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
