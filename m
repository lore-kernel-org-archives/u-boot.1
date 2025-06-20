Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D500C7115B
	for <u-boot@archiver.kernel.org>; Fri, 20 Jun 2025 18:59:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0177582BA1;
	Fri, 20 Jun 2025 20:59:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LkfSv28M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 985F882CBC; Fri, 20 Jun 2025 20:59:36 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9985C80C83
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 20:59:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-711756ae8c9so19529707b3.3
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 11:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750445972; x=1751050772; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSBpenBJ3yYYE2u+arGgSZUHwwqkBRlR+nQm5FaG+Ck=;
 b=LkfSv28MSX2tKg5WgPv85WSMUDNWl17tyoUDyk1Azo0UL83xLPWIIWHh96iBNjP6pY
 dnYkMLQ0VTQFMLpJbJzNOpOae7/o0xiSiZuLj0Fk61aLvGfIwR2j1y56dwViKzRX4I4F
 M9sFJt/P/QrqzG5l52MIWB1pc4L2lG8awEFS6lJzTRv6asDSpmHKfFZ2rbZ24kKplgoV
 GrxiaKYgo4K8e6Lt8CHr+dq3pkiOGJsirPXVokXL18cD6ixfQgoZuHi0jQB1nWFpQe/L
 4Dm6A7SbWIawKLThIf3Y6y5wQr/FAYmQtDqXtHQLmhvimmWce64150eBhT/g5qFv/Vlk
 RDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750445972; x=1751050772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qSBpenBJ3yYYE2u+arGgSZUHwwqkBRlR+nQm5FaG+Ck=;
 b=Li+ACgjQt3BABeg4H59cEMIy9aVacVjN8c8CX3UTzmDR2MewmX3HY+xKjqsAZ11okA
 x4yzIWfmPpKi+Qx7E/dv571BhzOt1KiE988zlT5+jZUp5UyoiWcAhznP3i3QYEkvDA+U
 qpgokhtUqBpN/t5NaRNkRv6RKcU1ftsL7SJ3M75+DJspf/3MK3zDNq7faXtVHtBBqp2Q
 F7PpiieXtk5F8VohCx9tyAVtTZMzyuH6lIyZx3Nbl1YSs81sYU6TtDvC+cppPQ9ybGhD
 TKGaYxo1oG/T/aQ7/lJKOvBmYuj8h9gshfWBvm8X9zye/8Ncmqd5x11prIo88w3kbHPp
 WRPA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNAglCvIh3b1e7Y/0gHf1hhBZmvFSsAYPwGRF0OAdpix4d65eZQFrDRWraAJi9g3cGKmdhj3w=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw7/jV4V60PgKkQK+w/iMsCWTjs2KgxnJxLIoEIPBRwxhDSrWw
 Ec+YL6CLQS2WdBbCCsX4Z3KxQqbz6DJhu6xHgcgibRtNuq/C2YrHW1231FsensCxKzFy4kx/mB9
 Nwb590+YiMBsbQ8IVSZOhELjXwihe4smdmTEs4WqAGA==
X-Gm-Gg: ASbGncvK0RONeVtPxwtF1ZVsLiUnDzP8n4+ZWE/AJA/fnuy5jVtF0oX962AQs2dNZPk
 2GLlv6nYvJiYwYPffVTZre894q3bq6lcwrnJJGy7fpebj3QaHRg/B7rlkVwu0X5m1YHrVX8Wg06
 P3w9BaQ3vtHCIICFvlEuAYt1kL192VCLYzNGs2gzW1vaRfdZR6kPw9N+tFJjzIk61OAzN0w/LK0
 w1tcqa1d/pAAr1t
X-Google-Smtp-Source: AGHT+IE9I13/pKqDtvP/6EqYsRCUCA4ZtOKl/8QKwx2aB+QYBcfD9Hjkpcn73NGsqwsvaX/zQu6/rNkvJoNv39N1XRA=
X-Received: by 2002:a05:690c:6088:b0:70e:2168:7330 with SMTP id
 00721157ae682-712c64fd6e2mr64282387b3.19.1750445972364; Fri, 20 Jun 2025
 11:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20250620022556.10363-1-semen.protsenko@linaro.org>
 <20250620142058.GJ216500@bill-the-cat>
 <CAPLW+4=JkVWoNaK5f98fRXOLZOQWc462U=EaDfYsXGmYBDbYnA@mail.gmail.com>
 <20250620185425.GM216500@bill-the-cat>
In-Reply-To: <20250620185425.GM216500@bill-the-cat>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 20 Jun 2025 13:59:21 -0500
X-Gm-Features: AX0GCFsNnijCh5iaXPRPech3Yyx7CrdpkPPmlD0bkZu3oOvbQ1nZMzcUDCad6CQ
Message-ID: <CAPLW+4kZCtOddQtmYrku=T_voWa6Gnn8SknTVGUo8routfEgNA@mail.gmail.com>
Subject: Re: [PATCH 0/2] board: samsung: e850-96: Fix MMC devices in EFI
To: Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <mk7.kang@samsung.com>, Minkyu Kang <promsoft@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Jerome Forissier <jerome.forissier@linaro.org>,
 u-boot@lists.denx.de
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

On Fri, Jun 20, 2025 at 1:54=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Fri, Jun 20, 2025 at 01:36:09PM -0500, Sam Protsenko wrote:
> > On Fri, Jun 20, 2025 at 9:21=E2=80=AFAM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Thu, Jun 19, 2025 at 09:25:54PM -0500, Sam Protsenko wrote:
> > >
> > > > Avoid using MMC in board_init() to make sure disk objects are creat=
ed in
> > > > EFI subsystem later.
> > > >
> > > > If it's still possible, please take this series for 2025.07, as it =
makes
> > > > EFI functional on E850-96 board.
> > > >
> > > > Sam Protsenko (2):
> > > >   configs: e850-96: Enable BOARD_LATE_INIT
> > > >   board: samsung: e850-96: Load LDFW in board_late_init()
> > > >
> > > >  board/samsung/e850-96/e850-96.c | 9 +++++++++
> > > >  configs/e850-96_defconfig       | 1 +
> > > >  2 files changed, 10 insertions(+)
> > >
> > > These should be one patch and also I think you want to disable
> > > CONFIG_BOARD_INIT ?
> > >
> >
> > Thanks for the review! I'll send v2 in an hour. But I wasn't able to
> > find CONFIG_BOARD_INIT option:
> >
> >     $ find . -name Kconfig* -exec grep -Hn "\bBOARD_INIT" {} \;
> >
> > initcall_run_r() seems to always call board_init() for ARM and other
> > architectures:
> >
> >     #if CONFIG_IS_ENABLED(ARM) || CONFIG_IS_ENABLED(RISCV) || \
> >         CONFIG_IS_ENABLED(SANDBOX)
> >         INITCALL(board_init);    /* Setup chipselects */
> >     #endif
> >
> > Interesting thought though. I did a brief analysis, and it looks like
> > there are 79 boards which have empty board_init() because it's not
> > possible to disable it at the moment:
> >
> >     $ grep -Pzrl "\bboard_init\(void\)\n{\n.*return 0;\n}\n" board/ | w=
c -l
> >     79
> >
> > Do you think U-Boot could benefit from having such an option?
>
> Yes, it looks like we need to clean the code up to match what we have in
> Kconfig now, thanks!
>

On it. Would appreciate it if you can take v2 as is for v2025.07, it
fixes EFI on E850-96.

> --
> Tom
