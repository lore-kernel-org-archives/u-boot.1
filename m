Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01CEDCD4851
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 22:21:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FBEC84713;
	Sat, 16 May 2026 00:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eBtzZnMT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43C1F84882; Sat, 16 May 2026 00:21:15 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E22A846E6
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 00:21:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-415b23dd6e5so129662fac.3
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 15:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778883672; x=1779488472; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HV8HuLp7oNDRvbbWqGq9cY0KvqFsqjLpMffWHTYl5cw=;
 b=eBtzZnMTbhJam/no1MzBlJ/FDvvGvmeohjFHamiWWFrDyHCQ1sN01kWVxr/gBcwHfG
 uP66GarNfeBmdoMbQ1727DEA256VYPWMKwDUXHYuHuM3lEfNxnjhCkRl1TNQQFIT11xt
 0FinRuRLMIj/yUhfmD2AD237leZ30h1awf87o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778883672; x=1779488472;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HV8HuLp7oNDRvbbWqGq9cY0KvqFsqjLpMffWHTYl5cw=;
 b=K2nnDklq03L3dtQfdNHSHuFN5ePwwpl4/3dd6hWntuk0mEXB+oSzWOy0aP/9dP87IC
 C9Sddw8GKNBYRCzkUuKvT5ZrCT0wYR8T06kPuwn68WyCvoIWYTXKeDmtFz1TZspSiquk
 2w941nObyxNBbiZWmKCDiym3AiBzqleE5TLHXK5Apc/IIo1MAcRtHeO8vKHRKtmulBJU
 ZRT4BMy2HxIYvm3GuUceyDpuNSYTsg+aiILYnOqYAR3LoPkaTFMFiZdS9lP/lr/nYEYo
 P0ATYxJbHhMSemF2oAW3vboxwyEywRnU6TxgVqQJYur9oCTybSvw/0yHQ2Gzo1/Ivgda
 fblA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S7ew2/4y7WoN7djEwt1PNF1yCoDmpts/upkvAUJtrP0KDxErrZkhYADX8lZANq5JDRK+BGYA=@lists.denx.de
X-Gm-Message-State: AOJu0YyfwmVO9mC779wgrmWLsZGac/1jTZGKtX39RjTYfjEjsgS6T6bm
 Xn1VYOJiisZrb2sCbodAsLz0CqJyKsTayD976cpOr0+lUt88tIKDOH+F9SJH3RrcLl4=
X-Gm-Gg: Acq92OF1XRuWNEVtJ0f3SXVZJ4tEmaKTqgSfwJzqUg4iJB9q/zJiACpBVtwqY0P1l3L
 O5IdqLl9KbhKYcyMX3q6HHEE10kYXWgtvQIXICENwfdvXfG6XSVjUt2Pis82m3yz8uiD6pFAwsy
 KQRkraYfSaituRdaLdr+SDxUWayzBEYVJN+1rLKoZhF3WvR/kgv+l8K+ijwvyfuxPZsZ/JNuw3N
 F7fmSn0jM0B1ulKSUQDF5jN/8p0qchbn3Fg5/ijXI03jyTnhWrxtDTJnnyYb/TPkPndkoc5TSYs
 /JNmO8sEsip9edOukycvbl/Bqi0y4NEuqbL/TWL8OSFb+/JTuQT8UDiCit9M4uyAIIpnolxljHT
 U5SOShJSXTEgicF7KkKgLa6JfEYN0st1Jh7wtzhtKDEcHV99BhUT4NvkPpA0K/FyPyxGP3rVcI/
 KxaoN1mMxkBWzMcMEu2AXQ2nsNF1ZdUnr9tdqm80nxrn6EjeVNUHGfiIzsQw7OexJY6htGghC29
 nyeRDrOEm7V5vTb3k6nUTEH291Y6SB5rIUMEa0IY8Bk9yi5Q2g=
X-Received: by 2002:a05:6870:b0f6:b0:439:7835:136c with SMTP id
 586e51a60fabf-43a2dce8716mr3798486fac.23.1778883671715; 
 Fri, 15 May 2026 15:21:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fc4dcb89sm5231139fac.12.2026.05.15.15.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 15:21:11 -0700 (PDT)
Date: Fri, 15 May 2026 16:21:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Sean Anderson <seanga2@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau@advansee.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>, Heiko Schocher <hs@nabladev.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Yao Zi <me@ziyao.cc>
Subject: Re: [RFC PATCH 00/11] Tidy command option parsing and use it a bit
Message-ID: <20260515222107.GN1858239@bill-the-cat>
References: <20260515203311.2555651-1-sjg@chromium.org>
 <20260515214305.GL1858239@bill-the-cat>
 <15041974-8838-56b6-b9d5-250383ed2625@gmail.com>
 <aa023095-2b32-070f-ff43-1f6922918b51@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wS6uYON7Fo8jyOJB"
Content-Disposition: inline
In-Reply-To: <aa023095-2b32-070f-ff43-1f6922918b51@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--wS6uYON7Fo8jyOJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 06:06:38PM -0400, Sean Anderson wrote:
> On 5/15/26 17:59, Sean Anderson wrote:
> > On 5/15/26 17:43, Tom Rini wrote:
> > > On Fri, May 15, 2026 at 02:32:51PM -0600, Simon Glass wrote:
> > >=20
> > > > We have had getopt() for over five years but it is not much used. I=
t is
> > > > much easier to understand arg-parsing using getopt() and it avoids
> > > > common errors. As the named maintainer I decided to look at how to =
make
> > > > more use of it.
> > > >=20
> > > > So this series explores the impact of converting a few commands to =
use
> > > > getopt() instead of ad-hoc parsing. It updates getopt() to handle f=
lags
> > > > anywhere in the cmdline and provides a few helpers to reduce
> > > > boilerplate.
> > > >=20
> > > > The chosen commands are:
> > > >=20
> > > > - echo: very simple with no flags
> > > > - hash: fairly simple with just one flag
> > > > - env grep/export/import - fuller examples
> > > >=20
> > > > The series also adds a recommendation to use getopt() for new comma=
nds.
> > > >=20
> > > > To try to reduce the code-size increase, a lower-case function is a=
dded
> > > > and called from a few places. The difference is fairly marginal.
> > > >=20
> > > > Overall, the result is not pretty (see below) with about a 1.1K size
> > > > increase on arm64:
> > >=20
> > > I think that means this is a no-go, and you need to work out what mig=
ht
> > > lead to a much smaller growth here.
> > >=20
> >=20
> > Unfortunately, the only way to get a size reduction is to convert as ma=
ny
> > commands as possible.
> >=20
> > --Sean
>=20
> And to expand on this, you really only get a reduction for any given comm=
and
> when there are several options being parsed already like in the nvedit st=
uff.
> Since most U-Boot commands don't use options it will be difficult to get a
> reduction even when converting most commands on a board.

We don't even see a reduction on "qcom" which is a platform that already
enabled GETOPT. nvedit is growth too:
01: Prepare v2026.07-rc2
02: lib: string: Add strlower()
   aarch64: (for 1/1 boards) data -40.0 rodata +40.0
            qcom           : data -40 rodata +40
03: cmd: ini: Use strlower() to normalise case
04: fs: fat: Use strlower() to normalise case
05: boot: pxe_utils: Use strlower() in get_string()
06: lib: getopt: Permute by default with inline reorder
   aarch64: (for 1/1 boards) all -6.0 data -24.0 rodata +18.0
            qcom           : all -6 data -24 rodata +18
               u-boot: add: 0/0, grow: 5/-1 bytes: 272/-8 (264)
                 function                                   old     new   d=
elta
                 __getopt                                   576     756    =
+180
                 getopt_init_state                           12      88    =
 +76
                 do_log_filter_remove                       364     372    =
  +8
                 do_log_filter_list                         444     448    =
  +4
                 do_log_filter_add                          580     584    =
  +4
                 do_bdinfo                                  160     152    =
  -8
07: lib: getopt: Add getopt_pop() helper
08: cmd: echo: Use getopt() with '+' prefix for option parsing
   aarch64: (for 1/1 boards) all +3.0 rodata +3.0
            qcom           : all +3 rodata +3
               u-boot: add: 0/0, grow: 1/0 bytes: 68/0 (68)
                 function                                   old     new   d=
elta
                 do_echo                                    156     224    =
 +68
09: cmd: hash: Use getopt() for option parsing
10: cmd: nvedit: Use getopt() in env grep
11: cmd: nvedit: Use getopt() in env export and env import
   aarch64: (for 1/1 boards) all -4.0 data -16.0 rodata +12.0
            qcom           : all -4 data -16 rodata +12
               u-boot: add: 0/0, grow: 2/0 bytes: 164/0 (164)
                 function                                   old     new   d=
elta
                 do_env_import                              692     832    =
+140
                 do_env_export                              608     632    =
 +24
12: doc: commands: Recommend getopt() for option parsing

> That's why I used it for new commands where no one could complain that
> I grew their board.
>=20
> I think it would be nice for all u-boot commands to have proper option su=
pport
> like in barebox, but it's a lot of effort.

Yes, it would be good to move in that direction. But we need to figure
out how to do it in such a way that's not such a big size loss. If we
have to do a big conversion to start with, fine. If we have to
restructure a few other things, fine. But "convert echo so everyone
links it now and it's sunk-cost" isn't the right path.

--=20
Tom

--wS6uYON7Fo8jyOJB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagecUAAKCRAr4qD1Cr/k
CuwHAP9CkvtkL8NTa1X0KdDcsvDfHFh6R/MXVTbHxPNCfASvdgEAx87uftzeCG+G
3FgSliLlQIbgwNvtjiTZy67GojgYSAg=
=NwlI
-----END PGP SIGNATURE-----

--wS6uYON7Fo8jyOJB--
