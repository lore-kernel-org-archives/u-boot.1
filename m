Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7130FC4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 20:36:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA34B8749E;
	Tue, 12 Dec 2023 21:36:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Z7HG0gVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C507086E96; Tue, 12 Dec 2023 21:36:37 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8283D871AA
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 21:36:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=francis.laniel@amarulasolutions.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c256ffdbcso63032935e9.2
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 12:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1702413394; x=1703018194;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBXLX5RJFV56OBI3cDpM9c/PFj8oUsHZ3J4JPUp+5d0=;
 b=Z7HG0gVqKM4fBZk4s2GZB7kxlHV6Fe7B0XYWOVMMchx0ANZ3Dicuo9RqZCHAnytp1V
 L6itngJ5bgjyANYUWFKmjBYtpOs4a+ILqMuk3/IBVEiN5y/OQX8jw8Wx2AODqzHE2BJt
 Ho4r51LST37wFxp8lqGdEimNt6+7sf0LHsr+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702413394; x=1703018194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBXLX5RJFV56OBI3cDpM9c/PFj8oUsHZ3J4JPUp+5d0=;
 b=i2+v9Fgf7oLdDOLA/5fQ0XBEBLnuTXaKfUV1p2Io7OnxQJaXRoR0ylzaP3UlYFkwXP
 WHcM/C2nuiOLnEi1mime5t6tVFdVR05rA0lKCDownQNACAOIXTLBYjeEEsSZDE/1rIWL
 lcYk7ST6bSDEaSs3eeKaNI/PnL3oeVY+12/LteAIuhepDWAtwPyUSfP9NZ7PQEQQ5ssr
 poS7tAti4t1JFEyZxwUfoJfLH6xYLOpUUml33YqBDz6OtGymj8WtR6G6PWCydkjd6q6v
 G13dSKgfTUx4depLoZdHRefXXTs0zOWRMRCronQkxvPuVys1fGFmsz07X4EdVHrhpn1r
 ifIA==
X-Gm-Message-State: AOJu0Yy4ciNIvAwpBegA9rFuHj6gaDdWoGaWN0XvYpayTuvIkeL926BP
 hqCVV1lYN6DmdMnPJUWe6Z82Bg==
X-Google-Smtp-Source: AGHT+IGQKMZpUOk7bGDUhckpGprZ39jSX2B7YpPBaGSU9nQV5zL/wpLsTSMNCvEKHqy2lWLDKUVnuw==
X-Received: by 2002:a05:600c:17d0:b0:40c:9e0:e969 with SMTP id
 y16-20020a05600c17d000b0040c09e0e969mr3422835wmo.61.1702413393886; 
 Tue, 12 Dec 2023 12:36:33 -0800 (PST)
Received: from pwmachine.localnet (85-170-33-133.rev.numericable.fr.
 [85.170.33.133]) by smtp.gmail.com with ESMTPSA id
 gw18-20020a05600c851200b004063c9f68f2sm17418101wmb.26.2023.12.12.12.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 12:36:33 -0800 (PST)
From: Francis Laniel <francis.laniel@amarulasolutions.com>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
 Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v12 00/24] Modernize U-Boot shell
Date: Tue, 12 Dec 2023 21:36:32 +0100
Message-ID: <2710814.mvXUDI8C0e@pwmachine>
In-Reply-To: <20231209231631.GO2513409@bill-the-cat>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
 <20231209231631.GO2513409@bill-the-cat>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
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

Hi!


Le dimanche 10 d=E9cembre 2023, 00:16:31 CET Tom Rini a =E9crit :
> On Fri, Dec 08, 2023 at 11:30:01PM +0100, Francis Laniel wrote:
> > Hi.
> >=20
> >=20
> > During 2021 summer, Sean Anderson wrote a contribution to add a new she=
ll,
> > based on LIL, to U-Boot [1, 2].
> > While one of the goals of this contribution was to address the fact act=
ual
> > U-Boot shell, which is based on Busybox hush, is old there was a
> > discussion
> > about adding a new shell versus updating the actual one [3, 4].
> >=20
> > So, in this series, with Harald Seiler, we updated the actual U-Boot sh=
ell
> > to reflect what is currently in Busybox source code.
> > Basically, this contribution is about taking a snapshot of Busybox
> > shell/hush.c file (as it exists in commit 37460f5da) and adapt it to su=
it
> > U-Boot needs.
> >=20
> > This contribution was written to be as backward-compatible as possible =
to
> > avoid breaking the existing.
> > So, the modern hush flavor offers the same as the actual, that is to sa=
y:
> > 1. Variable expansion.
> > 2. Instruction lists (;, && and ||).
> > 3. If, then and else.
> > 4. Loops (for, while and until).
> > No new features offered by Busybox hush were implemented (e.g. function=
s).
> >=20
> > It is possible to change the parser at runtime using the "cli" command:
> > =3D> cli print
> > old
> > =3D> cli set modern
> > =3D> cli print
> > modern
> > =3D> cli set old
> > The default parser is the old one.
> > Note that to use both parser, you would need to set both
> > CONFIG_HUSH_MODERN_PARSER and CONFIG_HUSH_OLD_PARSER.
> >=20
> > In terms of testing, new unit tests were added to ut to ensure the new
> > behavior is the same as the old one and it does not add regression.
> > Nonetheless, if old behavior was buggy and fixed upstream, the fix is t=
hen
> > added to U-Boot [5].
> > In sandbox, all of these tests pass smoothly:
> > =3D> printenv board
> > board=3Dsandbox
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> > =3D> cli set modern
> > =3D> ut hush
> > Running 20 hush tests
> > ...
> > Failures: 0
> >=20
> > Thanks to the effort of Harald Seiler, I was successful booting a board:
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> cli get
> > old
> > =3D> boot
> > ...
> > root@lepotato:~#
> > root@lepotato:~# reboot
> > ...
> > =3D> cli set modern
> > =3D> cli get
> > modern
> > =3D> printenv fdtfile
> > fdtfile=3Damlogic/meson-gxl-s905x-libretech-cc.dtb
> > =3D> boot
> > ...
> > root@lepotato:~#
> >=20
> > This contribution indeed adds a lot of code and there were concern about
> > its size [6, 7].
> > With regard to the amount of code added, the cli_hush_upstream.c is 130=
30
> > lines long but it seems a smaller subset is really used:
> > gcc -D__U_BOOT__ -E common/cli_hush_upstream.c | wc -l
> > 2870
> > Despite this, it is better to still have the whole upstream code for the
> > sake of easing maintenance.
> > With regard to memory size, I conducted some experiments for version 8 =
of
> > this series and for a subset of arm64 boards and found the worst case to
> > be 4K [8]. Tom Rini conducted more research on this and also found the
> > increase to be acceptable [9].
> >=20
> > If you want to review it - your review will really be appreciated - here
> > are some information regarding the commits:
> > * commits marked as "test:" deal with unit tests.
> > * commit "cli: Add Busybox upstream hush.c file." copies Busybox
> > shell/hush.c into U-Boot tree, this explain why this commit contains
> > around 12000 additions. * commit "cli: Port Busybox 2021 hush to U-Boot=
=2E"
> > modifies previously added file to permit us to use this as new shell.
> > The really good idea of #include'ing Busybox code into a wrapper file to
> > define some particular functions while minimizing modifications to
> > upstream code comes from Harald Seiler.
> > * commit "cmd: Add new parser command" adds a new command which permits
> > selecting parser at runtime.
> > I am not really satisfied with the fact it calls cli_init() and cli_loo=
p()
> > each time the parser is set, so your reviews would be welcomed.
> > * Other commits focus on enabling features we need (e.g. if).
> >=20
> > Changes since:
> >  v2:
> >   * Added a small fix to compile sandbox with NO_SDL=3D1.
> >   * Added a command to change parser at runtime.
> >   * Added 2021 parser function to all run_command*().
> > =20
> >  v3:
> >   * Various bug fixes pointed by the CI.
> >   * Added upstream busybox hush commits until 6th February 2022.
> > =20
> >  v4:
> >   * Various cleaning.
> >   * Modified python test to accept failure output when the test are
> >   designed to fail.
> >   * Bumped upstream busybox hush commits until 24h March 2022.
> > =20
> >  v5:
> >   * Bumped upstream busybox hush commits until 30th January 2023.
> >   * Fix how hush interprets '<' and '>', indeed we needed to escape them
> >   but I removed this behavior as tests are handled by test command and
> >   not hush itself. This permitted to have the ut fdt to pass.
> >   * Fix a problem with how exit was handled. This was reported by the ut
> >   exit
> >   test.
> > =20
> >  v6:
> >   * There was no v6 and I got mixed up with version.
> > =20
> >  v7:
> >   * Bumped upstream busybox hush commits until 9th May 2023.
> >   * Renamed parser command to change parser at runtime to cli and added
> >   documentation.
> >   * Added better separation of patches.
> >   * Removed code about __gnu_thumb1_case_si as it was merged in another
> >   series. * Various cleaning.
> > =20
> >  v8:
> >   * Bumped upstream busybox hush commits until 25th May 2023.
> > =20
> >  v9:
> >   * Bumped upstream busybox hush commits until 2nd October 2023.
> > =20
> >  v10:
> >   * Fixed a build error in commit adding cli command.
> >   * Add new CONFIG_HUSH_SELECTABLE to only build cli command if the two
> >   shell
> >   flavors are selected.
> > =20
> >  v11:
> >   * Renamed everything containing 2021 to modern.
> >   * Fixed cmd Kconfig indentation.
> >   * Set modern parser as default for majority of boards except some.
>=20
> Thanks, this looks good overall and I'll put things in CI soon and aim
> to get this in to -next and v2024.04.

Thank you!
In the meanwhile, I will take a look time to time to upstream busybox to ke=
ep=20
our version of hush up to date!

I will also take a look to enabling function, but I guarantee anything on t=
his=20
side!


Best regards.


