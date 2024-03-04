Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A242C5478C
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B33087FD4;
	Mon,  4 Mar 2024 16:51:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SjUCAw4I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DADBA875FC; Mon,  4 Mar 2024 16:51:03 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D8B387FD6
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33dcc82ecc1so1111941f8f.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709567461; x=1710172261; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vdxjrN5zEe+IM11bOtpQLaliUVSou4G/iAL/LZWU/Bc=;
 b=SjUCAw4I1gPjbsLxPaW/K8NZUW98vV+6/AbrOngMjd5D4/I3tEbExrMFwErOi4szfR
 GFqqO51aQ8yG3mxpeg0idECFA5rhYtc/brifPBXFNXpNUPb4jJNVVsY68JIBEr7/dvCj
 a5GQfOU14rDNWZkYDO5CLHqm9C1crdSXkU0xPXvFSDpWEN6ds85uj4/kh2iMRlB+Ns4a
 T1PMLK8Mf6OqvLYj46ptjz/pEe1YIQRbSEH/NZVE4Y+QTl6h7WZl8xOPmMDwoafrgpTz
 E7n3KR8rRtK/B5ZV1oeTt4DwMhkCbv+JQ4TK0mda7quhMA3ElOyAtsODqaO/fwBvlYXU
 elhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709567461; x=1710172261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vdxjrN5zEe+IM11bOtpQLaliUVSou4G/iAL/LZWU/Bc=;
 b=sKOeopqZleO+cm/mSXO0RSZei3aVo4IPwBC+llIX6td4NcqA8lgmWwjAI6kxcfOb4R
 8jhHGw8h9tgwtGzfjsm8r0Qt2PLxfNAMK+p+UFSA5RJtvbG79ObrctZHKLtY/OrAfQYU
 QWgwWEZE3ALJOz6C7blmgcSKaOmp7f9tryK0AjHHIB/8X5tslvDxzDjjvBUsioiUUGQp
 wn3s/5cJtfe+ogYOgYPPjVaPy+ZB4ikrhZlLt4JiXpr81QcueQOBH457gCnkh6U+PAiv
 u57Nqfa6QAF0MUkD309ER738wVojwMigJ/HJd9ec2hlNzztFdvIBLYSFm3pKwuVfJwxs
 5JpQ==
X-Gm-Message-State: AOJu0YzOGOzrprqujmGM4CgeAdFm6Au5OUZ+te0PRTlk0HLfvJX6PAoA
 z4hOBpmPOKCIIdsTYt4yh9td7DTZvQgh+Q8csLgVXJfr+QSeo52MeJ2sHp5BpohUHonhniI1ais
 LIzROjmZoytIW2L0HOFEq0f3LNyk=
X-Google-Smtp-Source: AGHT+IGmSLgYeh/cN7hhKt8+ZNijBXBIzzydrqouv6hJKUiUwxExl50LoVfsv9Be5Al5JrhcqqZYz7ucqssp4WXxEgc=
X-Received: by 2002:adf:e402:0:b0:33d:568f:8986 with SMTP id
 g2-20020adfe402000000b0033d568f8986mr5442819wrm.2.1709567460396; Mon, 04 Mar
 2024 07:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20240302220108.720637-1-igor.opaniuk@gmail.com>
 <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
In-Reply-To: <CAC_iWjK+f-ZBKT=Mf6629HxV=NCgoZ_taRMFhGK04aA1Xw-BCA@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Mon, 4 Mar 2024 16:50:48 +0100
Message-ID: <CAByghJaHFxtQaZ3ZLSbR=qkeLP3GLfOZpMVcKkrkCUqmuhF94w@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] TEE: minor cleanup
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng@tinylab.org>, 
 Etienne Carriere <etienne.carriere@foss.st.com>, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jens Wiklander <jens.wiklander@linaro.org>, 
 Jorge Ramirez-Ortiz <jorge@foundries.io>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Roger Knecht <rknecht@pm.me>, Sean Edmond <seanedmond@microsoft.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Ilias,

On Mon, Mar 4, 2024 at 12:16=E2=80=AFPM Ilias Apalodimas <
ilias.apalodimas@linaro.org> wrote:

> Hi Igor,
>
> On Sun, 3 Mar 2024 at 00:01, Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
> >
> >
> > - Address some spelling errors and typos
> > - Support CMD_OPTEE_RPMB for SANDBOX configurations and add python test=
s
> > - Remove common.h inclusion for drivers/tee
> >
> > Changes in v2:
> > - Fixed chimp_optee.c:37:9: error: implicit declaration of function
> 'memset'
> > - Applied R-b and T-b tags
>
> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/19808
> this seems to have a few failures
>
> Cheers
> /Ilias
> >
> > Igor Opaniuk (5):
> >   tee: optee: fix description in Kconfig
> >   tee: sandbox: fix spelling errors
> >   cmd: optee_rpmb: build cmd for sandbox
> >   test: py: add optee_rpmb tests
> >   tee: remove common.h inclusion
> >
> >  cmd/Kconfig                        |  4 +++-
> >  drivers/tee/broadcom/chimp_optee.c |  3 ++-
> >  drivers/tee/optee/Kconfig          |  2 +-
> >  drivers/tee/optee/core.c           |  1 -
> >  drivers/tee/optee/i2c.c            |  1 -
> >  drivers/tee/optee/rpmb.c           |  1 -
> >  drivers/tee/optee/supplicant.c     |  2 +-
> >  drivers/tee/sandbox.c              | 10 +++++-----
> >  drivers/tee/tee-uclass.c           |  1 -
> >  test/py/tests/test_optee_rpmb.py   | 20 ++++++++++++++++++++
> >  10 files changed, 32 insertions(+), 13 deletions(-)
> >  create mode 100644 test/py/tests/test_optee_rpmb.py
> >
> > --
> > 2.34.1
> >
>

It looks like it's a side effect, the test I added revealed a bug in
"cmd/optee_rpmb.c" implementation, which I didn't touch (looks
like it doesn't close the tee session automatically).

I'll address it and add a fix to the patch series.

Just a quick question, are Azure pipelines still used (so I can configure
my own account and run all these before sending patches, as explained
in [1])

[1] https://docs.u-boot.org/en/latest/develop/ci_testing.html
--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
http://ua.linkedin.com/in/iopaniuk
