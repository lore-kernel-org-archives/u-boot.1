Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB34E7D271
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 09:49:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1604786DC0;
	Tue, 26 Sep 2023 11:49:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tZXrl89a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAFCB86DF6; Tue, 26 Sep 2023 11:49:03 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7EB786DA8
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 11:49:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 60186B81061
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0CDC433C8
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695721740;
 bh=GZc7OL2isfuEm/HBxU4VBu0sFJflPLu9HaJlWO8VvUA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=tZXrl89a7RiAkb32K8gTcTJDjn3b0p28P8vWxxOPzR9Prqwgd/SgoBAK/C8sA9F1e
 jMrq9xh8vQwEVM6SYYbtXNMc+VZwJBwoXxGBPiz/pcTeuFIV/yujXeBGgcsLe+HL/d
 iFQUkuUWG5ynB65bnKmzgKud06VS56/cPDpFUtGCzNvUgmCksLsT5cBlapGn/IEp6S
 DTcP8ttH38QMPFGa+cP5vTPl3YdQjgsPGTVG/rTRuJdlIGRZMJ7SMHaswhKsdsF4VT
 fc5Uh08qUzQG1fE44FXd/O6MOtRU7Eha+yv4rWrkBXsLtfGhUAzl+wgEzyJdcA5L+6
 TSRZGszFsv0fQ==
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-1dd2e65ed59so1715007fac.1
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 02:49:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YxRngZlEciBobEhvTzwN6TZSgz83sYjVwUeSvE0nvSFdzq2v6at
 p4hJKM4wJQvFW8/7i9dTqzuHDnxjVzuFgVapSaA=
X-Google-Smtp-Source: AGHT+IHL/awp/5fKWVzSKpcvU4cQC9Oqbn0nNLZ67O9RWyfw+zW4SXc6NRTGgXxhVj5D7W6mwYBmvueI3xhjHKPvgCA=
X-Received: by 2002:a05:6870:786:b0:1bf:5b4:4a51 with SMTP id
 en6-20020a056870078600b001bf05b44a51mr8650208oab.58.1695721740120; Tue, 26
 Sep 2023 02:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNASMF-E96ShdukjdBEyKhxByve7NwW21xJmWRC8i8eYC0A@mail.gmail.com>
 <c7c31d97-0bb1-0c87-e22d-d268f682e607@ti.com>
In-Reply-To: <c7c31d97-0bb1-0c87-e22d-d268f682e607@ti.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 26 Sep 2023 18:48:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrwdo98q0Rx4DuqG1ZMU1N4X5eKqqG7U80=HXqK3cV+w@mail.gmail.com>
Message-ID: <CAK7LNASrwdo98q0Rx4DuqG1ZMU1N4X5eKqqG7U80=HXqK3cV+w@mail.gmail.com>
Subject: Re: Question about boot failure of AM64-SK
To: Vignesh Raghavendra <vigneshr@ti.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>,
 srk@ti.com, s-vadapalli@ti.com, n-francis@ti.com, m-chawdhry@ti.com
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

On Mon, Sep 25, 2023 at 1:24=E2=80=AFPM Vignesh Raghavendra <vigneshr@ti.co=
m> wrote:
>
> Hi Masahiro,
>
> On 21/09/23 20:33, Masahiro Yamada wrote:
> > Hi.
> [...]
>
> > spl: mmc boot mode: fs
> > Found FIT
> > Error reading cluster
> > fit read sector 0, sectors=3D985528, dst=3D, count=3D184467440737095516=
15,
> > size=3D0xf09b8
> > SPL: failed to boot from all boot devices
> > ### ERROR ### Please RESET the board ###
> >
>
> Looks like SD card incompatibility to me. Could you try couple of things:
>
> a) Different brand SD card

Hi Vignesh.

I tried Transcend and Lexar,
but both failed in the same way.


> b) Degrade speeds to non UHS mode:


I added no-1-8-v, but no luck either.




BTW, due to project shifting within my company,
this board is no longer a priority for me.

I will put AM64-SK on my shelf.  :)





--=20
Best Regards
Masahiro Yamada
