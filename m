Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B6CC46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 09:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5358787E;
	Tue, 26 Dec 2023 10:48:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l+8eZtzw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55F9E8793C; Tue, 26 Dec 2023 10:48:27 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8835187931
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 10:48:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-28bc7155755so1552112a91.2
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 01:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703584103; x=1704188903; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0mKRQMQ7yjpThcUlSL56Zrv/JvS/Lf8a6j4Dg32zwgU=;
 b=l+8eZtzwDz/ZLrzpMzhhfS/W36dFiIKG6xPrMQzVAdv3yG/JuRmbQQgxQudFMfOpEK
 5BFGlgziQ1X0ixRn64zXNYpd3tkWazWAYdAHb5Gcuqw55UJwv6Q907qu2lRAHWvRr/Ur
 xL/zf5rw+NQJm+r24JbFEvb4Rh8mna/FUfja4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703584103; x=1704188903;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0mKRQMQ7yjpThcUlSL56Zrv/JvS/Lf8a6j4Dg32zwgU=;
 b=uBvbZRA/3jImcQIxpGYILjqZ++uUdm9bEBfHeuJltClPhYlGHLSH3UOaNhh9kngG8x
 UFWNv6oxbrGcmmFGaUamFDlrFcr2UcPJv7pa88myTBqeEUJrre6KlgSwTNAGrWQLQ5Gd
 zvvWWQJ4XkAHWN34uClYpm31zR9zmhwjvWIH92zEcJdOA0zmVOiWSbGAsez+zcOfM/O1
 MyPsqr9/VV1ZhI0n46K9SNCaqTKMilOvvHzWS51u4547Ko5ypFUyvvPhvLgOg2nXqXYt
 BOPBOM5BKAZdV8i7m7ot56aU1phByziNnndgzrZVzQcfjNT901cUhkooTGBl9qTRRkpN
 CBJw==
X-Gm-Message-State: AOJu0YwMUXu6VQ7gZplJYyMzuKLl8RJ295qbhUcHvJKp3nmZYUZ6LpnT
 nYM8dWu8LArFRKiSOV9iHJMJd+LiM9qOjDb7aEdRSBSe3kJp
X-Google-Smtp-Source: AGHT+IGdfL/cZw3s/8aV1RViIO6rRh9c3zTwmLNgA4+zNI1QufXetr2JTk1eVn79B7ApgGLnuB+sZSYNJTrUNzbSseE=
X-Received: by 2002:a17:90a:fe8d:b0:28c:7de9:253 with SMTP id
 co13-20020a17090afe8d00b0028c7de90253mr100238pjb.40.1703584102925; Tue, 26
 Dec 2023 01:48:22 -0800 (PST)
MIME-Version: 1.0
References: <20231205155523.721784-1-devarsht@ti.com>
 <871ec46f-feb6-146f-91f9-6f02c0da3b45@ti.com>
In-Reply-To: <871ec46f-feb6-146f-91f9-6f02c0da3b45@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Dec 2023 09:47:50 +0000
Message-ID: <CAFLszTiJ6En-jQr_3v4S0d4eUyBvvOt==SeZ8n46ZjLwju6Tdw@mail.gmail.com>
Subject: Re: [PATCH v5 0/8] Move framebuffer reservation for SPL to RAM end
To: Devarsh Thakkar <devarsht@ti.com>
Cc: u-boot@lists.denx.de, agust@denx.de, trini@konsulko.com, 
 bmeng.cn@gmail.com, msuchanek@suse.de, rasmus.villemoes@prevas.dk, 
 yangshiji66@outlook.com, praneeth@ti.com, nm@ti.com, vigneshr@ti.com, 
 a-bhatia1@ti.com, j-luthra@ti.com, nsekhar@ti.com, n-jain1@ti.com
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

On Wed, Dec 13, 2023 at 2:56=E2=80=AFPM Devarsh Thakkar <devarsht@ti.com> w=
rote:
>
> Hi Antoine,
>
> On 05/12/23 21:25, Devarsh Thakkar wrote:
> > Move video memory reservation for SPL at end of RAM so that it does
> > not interefere with reservations for next stage so that the next stage
> > need not have holes in between for passed regions and instead it can
> > maintain continuity in reservations.
> >
> > Also catch the bloblist before starting reservations to avoid the same
> > problem.
> >
> > While at it, also fill missing fields in video handoff struct before
> > passing it to next stage.
> >
> > This is as per discussions at :
> > For moving SPL framebuffer reservation at end of RAM:
> >
> > https://lore.kernel.org/all/CAPnjgZ3xSoe_G3yrqwuAvoiVjUfZ+YQgkOR0ZTVXGT=
9VK8TwJg@mail.gmail.com/
> >
> > For filling missing video handoff fields :
> > https://lore.kernel.org/all/CAPnjgZ1Hs0rNf0JDirp6YPsOQ5=3DQqQSP9g9qRwLo=
OASUV8a4cw@mail.gmail.com/
> >
> > Changelog:
> > V2:
> > - Make a generic function to reserve video memory at SPL stage.
> > - Add debug prints while skipping framebuffer allocation at uboot.
> > - Correct commenting style as suggested.
> >
> > V3:
> > - Change spl_reserve_video to spl_reserve_video_from_ram_top
> >   which enforce framebuffer reservation from end of RAM.
> > - Use gd->ram_top instead of local ram_top and update
> >   gd->reloc_addr after each reservation.
> > - Print error message on framebuffer reservation.
> > - Update SPL doc with spl splash screen specific info.
> >
> > V4:
> > - Split patches into atomic commits.
> > - Remove duplicate check for video blob passed addresses and error out
> >   if invalid address/size received from blob.
> > - Improve SPL documentation memory reservation scheme and print message
> >   for video memory reservation from bloblist.
> > - Add Reviewed-By.
> >
> > V5:
> >  - Add comment for filling video handoff size with aligned size
> >  - Use PHASE_BOARD_F while checking for U-boot proper stage
> >  - Add Reviewed-by
> >
>
> Is it possible to pull this series in if no further comments ?

Yes please, this has been pending for a while.

>
> Regards
> Devarsh
>
> > Test logs:
> > https://gist.github.com/devarsht/30a3c1591270c9ebae00714b48d33058
> >
> > Devarsh Thakkar (8):
> >   spl: Enforce framebuffer reservation from end of RAM
> >   arm: mach-k3: common: Reserve video memory from end of the RAM
> >   board: ti: am62x: evm: Remove video_setup from spl_board_init
> >   common/board_f: Catch bloblist before starting reservations
> >   video: Skip framebuffer reservation if already reserved
> >   video: Fill video handoff in video post probe
> >   doc: spl: Add info for missing Kconfigs
> >   doc: spl: Add info regarding memory reservation
> >
> >  arch/arm/mach-k3/common.c    | 17 ++++++++++-----
> >  board/ti/am62x/evm.c         | 18 ----------------
> >  common/board_f.c             | 41 +++++++++++++++++++++++++++++++-----
> >  common/spl/spl.c             | 19 +++++++++++++++++
> >  doc/develop/spl.rst          | 37 ++++++++++++++++++++++++++++++++
> >  drivers/video/video-uclass.c | 40 ++++++++++++++++++++++++-----------
> >  include/spl.h                | 10 +++++++++
> >  7 files changed, 142 insertions(+), 40 deletions(-)
> >

Regards,
Simon
