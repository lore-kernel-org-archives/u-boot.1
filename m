Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF94C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 08:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D7581D5D;
	Fri,  4 Jul 2025 10:37:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cIIBbBeg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45CFB822D7; Fri,  4 Jul 2025 10:37:43 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9C833803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 10:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3135f3511bcso769406a91.0
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 01:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1751618259; x=1752223059;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=voXPTqnvileXZR/k04gX/uc59up8VVypTLz/J0nAUKo=;
 b=cIIBbBegsBvDJdKpV4x68eyAfY+NacWTVxl/h/gqIi3f244QjgtwuP3mH+apfLQQIz
 fxGEkfS77NGtbJ82S5JtlvWE51gWSsGcv8OX27xJP9mIKkSVVeUWVNSAIREXyNecy9dd
 /aMGeJsyZ3iW42jq+7Gyue67/aHE9GFoGn9vY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751618259; x=1752223059;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=voXPTqnvileXZR/k04gX/uc59up8VVypTLz/J0nAUKo=;
 b=ceCKa9/a0V+fSsbI0kvhATlnd8lU+QKztLqy9DmwcKtmydvQitdkxjtcspX5aBOShI
 BgVbp4khTrtplBVCiH3vM3fIeNhOx+xZxSDntasgmLq0HbXbPJ0DCY0Jc0G9zmmlN39y
 RsbacOihtft47ahKfVHCTm0iu30IU1RcljPwB2pDyFC/lSLoW5+GbJzmISC7o68BHu15
 nEf1BqzL9UYbEYpys3m35EFABzT7LRLsd01eF3ypoyon/CkRDzbRIcpNZhdE65C/RLcN
 WKkxmL0c6R6kaMX54UYLwIkvgZY51GmVurE007VoFEO/CwyF9+8ZaYJ2NtM/tJdK59Bc
 QEjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVH8yNjw+RuKhZSdzBcHQwUV5i7k+r+hNbKZKCvGrndBlCKmTtDKJNwJVc3zJXYrutGARHuM/A=@lists.denx.de
X-Gm-Message-State: AOJu0YyVARp4AZWCn6ABT8O8plAmL0AbRiZPdFpADx4E2Odf+CF4iXbz
 U35jsNeeNjpPgamDGYFtvWdJFWTVMwWCSk1HFsRpEXKpwbZJ428HwasU2t3zGp5bXRGeWZneRwY
 Z2wPuiVJMjh2aL6gYZr7Y3WUqcFAsvunEYmShwob2Qg==
X-Gm-Gg: ASbGncstw4a+Kh6oMwmoA8xANqJSN91HNyK3BG/H0TY2JYHGUigE+jP/81aq1/7xw6O
 HmgmVZEjZOtpy2Hbvrq9F3XHPOQBFmExFRDGIYyEdj9hmUswzEsRrKpWhzqv1ddta0T4aCbXD9H
 oznloKjxnlZIif5eTU9d868xbnudoT0y8QcHvxFyMFaw==
X-Google-Smtp-Source: AGHT+IFBii998Ul87b5eEWs3mPKRUNkgVc0b1FTbHDwmiQgtcHxTTKZCY0jkuy2Ie6TWgHv/sGDcZuZCf/MsUOygx+s=
X-Received: by 2002:a17:90b:2647:b0:312:e51c:af67 with SMTP id
 98e67ed59e1d1-31aac433b33mr2683395a91.1.1751618258897; Fri, 04 Jul 2025
 01:37:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
 <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
 <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
In-Reply-To: <0b7fcdb0-0d18-41ef-8607-cf060ce3d058@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Fri, 4 Jul 2025 10:37:26 +0200
X-Gm-Features: Ac12FXzEQDKZNl0EjoA6Mv028m-M7WBZlKFO94yPErX7i16yio5k3K8KaARCg9o
Message-ID: <CAOf5uwniX09rvpChMVrFWVG-X5S52aK_ZjnpS8EAN24=r1youA@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Otavio Salvador <otavio@ossystems.com.br>, 
 dl-uboot-imx <uboot-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi all

On Fri, Jul 4, 2025 at 10:33=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Fabio,
>
> On 7/4/25 04:34, Fabio Estevam wrote:
> > Adding Tom.
> >
> > On Thu, Jul 3, 2025 at 11:33=E2=80=AFPM Fabio Estevam <festevam@gmail.c=
om> wrote:
> >>
> >> Hi Jerome and Tom,
> >>
> >> On Fri, Apr 4, 2025 at 10:51=E2=80=AFAM Jerome Forissier
> >> <jerome.forissier@linaro.org> wrote:
> >>>
> >>> This series replaces the dynamic initcalls (with function pointers) w=
ith
> >>> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> >>> init_sequence_f_r and init_sequence_r. This makes the code simpler an=
d the
> >>> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -51=
0
> >>> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >>>
> >>> Execution time doesn't seem to change noticeably. There is no impact =
on
> >>> the SPL.
> >>>
> >>> The inline assembly fixes, although they look unrelated, are triggere=
d
> >>> on some platforms with LTO enabled. For example: kirkwood_defconfig.
> >>>
> >>> CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/2=
5514
> >>>
> >>> Changes in v6:
> >>> - Rebase on next branch
> >>
> >> This series breaks the boot on an imx6dl sabresd board (mx6sabresd_def=
config):
> >>
> >> U-Boot SPL 2025.04-01075-g3c9c3d852e00 (Jul 03 2025 - 23:23:12 -0300)
> >> Trying to boot from MMC1
> >>
> >> (Hangs here)
> >>
> >> I ran a git bisect from 2025.04 to master, and that was the result:
> >>
> >> 8c98b57d72d5e5b94ed064fe1041e51216165334 is the first bad commit
> >> commit 8c98b57d72d5e5b94ed064fe1041e51216165334
> >> Merge: 739ad58dbee8 bbee3d41b33f
> >> Author: Tom Rini <trini@konsulko.com>
> >> Date:   Mon Apr 14 08:59:45 2025 -0600
> >>
> >>     Merge patch series "Static initcalls"
> >>
> >>     Jerome Forissier <jerome.forissier@linaro.org> says:
> >>
> >>     This series replaces the dynamic initcalls (with function pointers=
) with
> >>     static calls, and gets rid of initcall_run_list(), init_sequence_f=
,
> >>     init_sequence_f_r and init_sequence_r. This makes the code simpler=
 and the
> >>     binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and =
-510
> >>     bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >>
> >>     Execution time doesn't seem to change noticeably. There is no impa=
ct on
> >>     the SPL.
> >>
> >>     The inline assembly fixes, although they look unrelated, are trigg=
ered
> >>     on some platforms with LTO enabled. For example: kirkwood_defconfi=
g.
> >>
> >>     CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipeline=
s/25514
> >>
> >>     Link: https://lore.kernel.org/r/20250404135038.2134570-1-jerome.fo=
rissier@linaro.org
> >>
> >>  arch/arm/include/asm/system.h             |  22 ++-
> >>  arch/arm/lib/cache.c                      |   5 +-
> >>  arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
> >>  arch/sh/lib/board.c                       |   9 +-
> >>  common/board_f.c                          | 223 ++++++++++++++-------=
------
> >>  common/board_r.c                          | 247 +++++++++++++++------=
---------
> >>  include/initcall.h                        |  49 +++---
> >>  lib/Makefile                              |   1 -
> >>  lib/initcall.c                            | 102 ------------
> >>  test/py/tests/test_trace.py               |   8 +-
> >>  10 files changed, 297 insertions(+), 378 deletions(-)
> >>  delete mode 100644 lib/initcall.c
> >>
> >> Any ideas?
>
> Have you tried the master branch recently? Hopefully commit 410d59095a9f
> ("arm: kirkwood: fix freeze on boot") should fix the issue.
>

We have problems that our board crashes with display enabled when this
series is applied but we can boot
if the series is reverted. We are still try to understand what is going on

Michael

> Thanks,
> --
> Jerome



--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
