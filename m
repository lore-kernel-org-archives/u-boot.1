Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE0DE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 23:52:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42AE38921B;
	Sat,  7 Dec 2024 00:52:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lbtdGilg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4891C8913C; Sat,  7 Dec 2024 00:52:43 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8C448918B
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 00:52:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-46679337c24so19639431cf.3
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 15:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733529159; x=1734133959; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qEmQzM9eSJKQkLsvwEqiWJdiSAiHndxacDKMEDj5e5Q=;
 b=lbtdGilgm8NRUEuzuAaqW5Fnou8OkkCg2ERFjXbqUuk2f6u9RLjIfZ6uf+vH8fOjhJ
 9tCOzdjjOkQSHVET9agcp6+ZpzHiKelUEPCuLT3/E3XKmuSj6txY1cWum9W4w4wY7wPu
 jiDHaJq2jhojWIxCNe4ZsWPdP820Aeo+5Uq9s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733529159; x=1734133959;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qEmQzM9eSJKQkLsvwEqiWJdiSAiHndxacDKMEDj5e5Q=;
 b=FngmdLON2jX3fvb6IuAPK4mT3anxax4YANw9mWaaw1zzKppspn6CkfEWlrKFo96ZkS
 NJA9eLYhVKsFqcXnhh3HJ8i6A7fNRphSMSnvi0KgYlgM4u086oZap8K86k5c1SZ3OZ9D
 wU/E8rdWDBUIr83jnvv9I8lzJyJwoZJ/LLRpLHe0csM7err6rlCIBWgEZrDIlYxS6gax
 6Z9RVOVd2Dgd3HFv8G8rt+3hEMT42YiCGvzVnQFqLgC/hqiJmtBTBNRcbmM2L80Vw0mV
 AyZ++zvaFNT4lH2x3CaJbuHexCWafNDxwHXMPVMAQ0sperDXoC3FkK7/ES8YnF0U+IoS
 H7vQ==
X-Gm-Message-State: AOJu0YztlZ0H4Bx6jLTHcnLpS4xIVsA6pBxseWjXpjXEI5u/0Fkgz+DF
 j6C+gUwYBKFRzNTChPHjSXnegNcDt431tHfscFfPXMU3c3jAWzrWpgD/AJ7n3rg=
X-Gm-Gg: ASbGnct0T5HzgbDhNA6BtYFQgnO92yLUVDz663/5nF8PjOuiQKN6Wg/4Na9thz+wD7C
 NtF6fCAECnjNaV4eOyCGHHdecb+ozy14Orcw5Ly/1vYivt/5+CUOGvVcIDyGTvtDTBn9gAjyZjD
 9U98fIt9oVQyxYPj+dRsXGU53L0PKjrMmxlyzY3uS8rhu0y4UdG+mY1swbQ7mjtwVjgOOI5maMr
 VVaPQjlXIUVsh+duj+uowcB3qaIEpWJX4BQYzU30RP7gud1ZJM=
X-Google-Smtp-Source: AGHT+IGbZfRpjlXjPAxfwUpPkU5J8oIYtT5wqslyybgIs9At5hdQUeqUe4yCmNBR88UylgO9XJrRZA==
X-Received: by 2002:a05:6214:2a87:b0:6d8:a946:eee5 with SMTP id
 6a1803df08f44-6d8e71272ffmr63918656d6.23.1733529158907; 
 Fri, 06 Dec 2024 15:52:38 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6b5a46723sm222660185a.7.2024.12.06.15.52.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 15:52:37 -0800 (PST)
Date: Fri, 6 Dec 2024 17:52:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, Jan Kiszka <jan.kiszka@siemens.com>,
 Jerry Van Baren <vanbaren@cideas.com>,
 Jonas Karlman <jonas@kwiboo.se>, Marek Vasut <marex@denx.de>,
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, Richard Weinberger <richard@nod.at>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>, Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 0/3] rpi: Tidy up booting
Message-ID: <20241206235233.GB2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FYsHESWeXz3+ITl/"
Content-Disposition: inline
In-Reply-To: <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
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


--FYsHESWeXz3+ITl/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > >
> > > > > This series allows rpi to boot a compressed Ubuntu kernel with ~1=
00MB
> > > > > ramdisk, by expanding the available space.
> > > > >
> > > > > It also tidies up some strange behaviour with the provided FDT, w=
here a
> > > > > separate pointer is maintained to it, even though U-Boot has copi=
ed it
> > > > > and placed it in its own space. This avoids strange bugs where it
> > > > > accidentally gets overwritten when loading a file into memory.
> > > > >
> > > > >
> > > > > Simon Glass (3):
> > > > >   rpi: Update environment to support booti and large initrd
> > > > >   fdt: Allow expanding the devicetree during relocation
> > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > >
> > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > >  common/board_f.c              |  6 ++++--
> > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > >
> > > > My feedback here is the same feedback I gave the last person that w=
anted
> > > > to update the Pi addresses, and I forget if they came back and did =
that
> > > > (and it's in Peter / Matthias' queue) or not. Disabling device tree
> > > > relocation is a bug and must be removed.
> > > >
> > > > After that, given the range of memory sizes available on Pi platfor=
ms,
> > > > allocating the kernel / initrd / kernel decompression buffer at run
> > > > time, ala mach-apple would make life easier in the long run.
> > >
> > > Yes, of course, but for now, this resolves the problem and I don't
> > > believe it creates any other problem.
> >
> > Yes. I think you missed that:
> > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430.3050251=
-1-walter.lozano@collabora.com/
> > is also outstanding and should solve the problem.
>=20
> No, it doesn't support decompression, although I have to wonder why
> that patch was never applied.

See Peter's response elsewhere about having a lot of things to do and
not a lot of time. I know he's intended to pick up and post a Pi PR for
a while.

> > > The solution should not be board-specific though. Once I have the
> > > bootstd files stuff is finished, I believe that bootstd will be able
> > > to do this and I plan to do this. Then the variables will be unused
> > > for rpi and we can just drop them for any bootstd boards.
> > >
> > > As of now, we have 390 boards using bootstd and 381 using distro
> > > scripts, so it is progress!
> >
> > Yes, it will be interesting to see what the future holds, and any of the
> > solutions handle some of the trickier corner cases that lead to the
> > current situation. Or perhaps the best outcome is that in current times,
> > those corner cases don't really appear anymore (with 512MiB DDR being
> > the lower bound for example on all the Pi families).
>=20
> Well rpi is a bit unusual...

Sure, but not in this case? Lots of examples of multiple models with
different memory sizes, and especially with 32bit platforms smaller (by
current standards) overall DDR.

--=20
Tom

--FYsHESWeXz3+ITl/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTjjkACgkQFHw5/5Y0
tyyXGQv+ORkcqi64mgST8GNZff3QZH4399iQ0KvuUdd0KNQ6EhcjvS15kmduUQOQ
Lan7DBsNh/ETvre8Mfga/JxdEP9ZobQS/pHeduIaRrwFYjQpERtxJABpw/6yQG8h
vBuP5daZf6DBfIfC8F2u+4h73uaFCRdAvRHXpnVEr71ChMdj/1DFjk++urYah8jU
H6ZM8YfGjZmcRZV0NKArm4Z6QA5T78t9XsArAcPBwdylUYDiPVy15N8JBsvBBv1t
x2qA24S5Au+k3h2PQvjAlXhmV9xUJ8RGL1DPSMRG7RSYhGWKpTvnm6kAJzxUS9Pv
n4Fb8j2s1xZafzU2K7QLDZjLFnYn/sXn2XXvdgz4oaqsu3IiPVPKAMXk6JI25MLA
PZwCYBfkV+0G5o5+sr2lp5RYDBQ4pcGsRQ3B0t712MBetYFGl88UkBxlcSVjXxjt
lDDRHVpEzN5K3VrsaISraBKv5Y1OJkrVaHht5NMv/O8Qrq24fZnM/Ajn3fhX+lw4
wZ5LOiW+
=vmpY
-----END PGP SIGNATURE-----

--FYsHESWeXz3+ITl/--
