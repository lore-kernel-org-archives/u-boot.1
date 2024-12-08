Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAACE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 16:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F259288CC9;
	Sun,  8 Dec 2024 17:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JStoRWvt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A32888936; Sun,  8 Dec 2024 17:15:34 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F27A88CC9
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 17:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b678da9310so314135985a.2
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 08:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733674530; x=1734279330; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DCW5dSu8pvCKSU3nWixQAQ8z79F1CwZeEUwQYLKMwMQ=;
 b=JStoRWvts4TVd5oXPphbrJcP3GooR09FY8qHzUdUNYCorAfWjQ7x74PSEoc/pDO7tt
 PFuWhNXlHgoOaZ+1qzalqzTcG5cgig2njpDZcyVgQE9xAzNL/8ph4FitiIF8yRil3FF5
 //t8uwSlVeikVoTPNEHQAcHK/6Pyo9KLuFcL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733674530; x=1734279330;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DCW5dSu8pvCKSU3nWixQAQ8z79F1CwZeEUwQYLKMwMQ=;
 b=iTHy3WQ7UBlhto7Jd3fXl1CPvD4xe2ptQlIUwdornml+SfRCybiViRazbcpC55BGXW
 VLAqv21W83N/XxVT/1dLYyZm/OhmQOqk8X6JJsR8KCCxvllL+70YKyxeEoNIi7jYHWwU
 2M7IcYNaH628t3wHIT+c/g+RmYFn+JjsASvz9bfS1I33i6XlXIlytDuj+uk3BeXGJfnO
 FZuvIv8EvJ/QE5YBZdxFaGM9/dfj8ajUKJJdr8b5QI/amUeUEXjMPQu4eBfUa9xAb41W
 9PP45CjnXeTuTdZWMPotVGXnm5DC7YU/IdG8nVODMIdLsBssHviUiyUZxWErmFIrfRF1
 gPXg==
X-Gm-Message-State: AOJu0YwbpBrAPIh3ntSaY09ynWfYUu8ifjUOkWR618gnXm4Eiqfs5xAt
 lusqEc/+RjTRD3sH94ujB/To4y6AtncosZyxkQaUA55sZNUPb8PnVxFOBn1Lm38=
X-Gm-Gg: ASbGnct9/+lnEBKVBUWYyOfaiXrKrGzPNIT95lNDBcQ7+eIaE3Q5KrxGBo+kfEa5RIN
 am6YoXSe6En8nEorpm2nE8HNhpxgxmAJDox+stvIaMTbHJ6X4qye6BPZd2ojEvgq2wIyWQcnTU5
 sKFmA7WAdYFpeNVGMGlxAZum+MBd85Qo8JNVA8vyP3oZJ8AyGIhOnV73pMTIWmXzmvo82Bi3icV
 RHT0YzHsbUiKjZFGYr3bAfvVnxN7FTl6q4fNjAoDXaXmAwqPWg=
X-Google-Smtp-Source: AGHT+IHMObAKq0RIkJk36d4suhjp6sEpSG+WeMMs9kjgRfsJ682Q+9x0J4uztLNpCk3AHQ1UubQVZw==
X-Received: by 2002:a05:620a:2449:b0:7b6:6b88:cbe5 with SMTP id
 af79cd13be357-7b6bcac8c2cmr1393674085a.1.1733674530458; 
 Sun, 08 Dec 2024 08:15:30 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6d284748bsm54156385a.42.2024.12.08.08.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Dec 2024 08:15:29 -0800 (PST)
Date: Sun, 8 Dec 2024 10:15:25 -0600
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
Message-ID: <20241208161525.GH2457179@bill-the-cat>
References: <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
 <20241207000029.GC2457179@bill-the-cat>
 <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
 <20241207005246.GD2457179@bill-the-cat>
 <CAFLszTju5G+icA4aLWWsYTZaEzZp+qUgvgtZ38azndH+A-6Okg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XwkxnDRJXgBg20Dg"
Content-Disposition: inline
In-Reply-To: <CAFLszTju5G+icA4aLWWsYTZaEzZp+qUgvgtZ38azndH+A-6Okg@mail.gmail.com>
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


--XwkxnDRJXgBg20Dg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 07, 2024 at 04:51:34PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 17:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 05:10:39PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 17:00, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 04:56:31PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > > > > > > Hi Tom,
> > > > > > > > >
> > > > > > > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com=
> wrote:
> > > > > > > > > >
> > > > > > > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass w=
rote:
> > > > > > > > > >
> > > > > > > > > > > This series allows rpi to boot a compressed Ubuntu ke=
rnel with ~100MB
> > > > > > > > > > > ramdisk, by expanding the available space.
> > > > > > > > > > >
> > > > > > > > > > > It also tidies up some strange behaviour with the pro=
vided FDT, where a
> > > > > > > > > > > separate pointer is maintained to it, even though U-B=
oot has copied it
> > > > > > > > > > > and placed it in its own space. This avoids strange b=
ugs where it
> > > > > > > > > > > accidentally gets overwritten when loading a file int=
o memory.
> > > > > > > > > > >
> > > > > > > > > > >
> > > > > > > > > > > Simon Glass (3):
> > > > > > > > > > >   rpi: Update environment to support booti and large =
initrd
> > > > > > > > > > >   fdt: Allow expanding the devicetree during relocati=
on
> > > > > > > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > > > > > > >
> > > > > > > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++---------=
---
> > > > > > > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > > > > > > >  common/board_f.c              |  6 ++++--
> > > > > > > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > > > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > > > > > > >
> > > > > > > > > > My feedback here is the same feedback I gave the last p=
erson that wanted
> > > > > > > > > > to update the Pi addresses, and I forget if they came b=
ack and did that
> > > > > > > > > > (and it's in Peter / Matthias' queue) or not. Disabling=
 device tree
> > > > > > > > > > relocation is a bug and must be removed.
> > > > > > > > > >
> > > > > > > > > > After that, given the range of memory sizes available o=
n Pi platforms,
> > > > > > > > > > allocating the kernel / initrd / kernel decompression b=
uffer at run
> > > > > > > > > > time, ala mach-apple would make life easier in the long=
 run.
> > > > > > > > >
> > > > > > > > > Yes, of course, but for now, this resolves the problem an=
d I don't
> > > > > > > > > believe it creates any other problem.
> > > > > > > >
> > > > > > > > Yes. I think you missed that:
> > > > > > > > https://patchwork.ozlabs.org/project/uboot/patch/2024072319=
3430.3050251-1-walter.lozano@collabora.com/
> > > > > > > > is also outstanding and should solve the problem.
> > > > > > >
> > > > > > > No, it doesn't support decompression, although I have to wond=
er why
> > > > > > > that patch was never applied.
> > > > > >
> > > > > > See Peter's response elsewhere about having a lot of things to =
do and
> > > > > > not a lot of time. I know he's intended to pick up and post a P=
i PR for
> > > > > > a while.
> > > > >
> > > > > OK, but let's drop that patch since it doesn't support decompress=
ion, right?
> > > >
> > > > No? No one has done all of the work required (remove fdt_high /
> > > > initrd_high) and this also solves the larger kernel issue.
> > >
> > > No, that is a separate issue. We need kernel_comp_addr and kernel_com=
p_size
> >
> > Yes, those are required for automatic decompression, which is handy. But
> > the highest priority is removing fdt_high / initrd_high because those
> > lead to so much time being wasted by everyone. Your time digging in to
> > and making patch #2 for example.
>=20
> Can you remind me why fdt_high is so bad, or even what it is supposed
> to help with? Perhaps file an issue? I'm not necessarily offering to
> do it, but if I understand it better, then it is more likely that I
> will take it on.

There's nothing to take on? The fdt_high and initrd_high environment
variables are documented, along with the other relevant bootm variables.
In general, at least bootm_low / bootm_size are useful and the correct
way to solve the problem of "ensure device tree and initrd are where the
OS can see them", when we are NOT in the use case of "we have an API to
cooperate on this task".  The problem is that for in hind sight
extremely bad reasons, we allowed for the magic value of -1 to mean "Do
not move the device tree" (or initrd). In the latter case, it's a boot
time optimization that's quite useful and handy at least on the
processors of the time. In the case of the former, man years (I'm not
exaggerating at this point) of engineering time has been wasted over the
device tree being in an unaligned or about to be overwritten location
and we (U-Boot) don't fix it. The only remaining problem really is to
remove fdt_high / initrd_high from the platforms that disabled
relocation before I finally got all of my tooling right such that when a
new platform did set it, I would see it and go off on an
explanatory-rant about why that needs to be fixed.

--=20
Tom

--XwkxnDRJXgBg20Dg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdVxhkACgkQFHw5/5Y0
tyxmgAv+LVNz7CarAOaLbZOOkv8BolfrX4fnMLoo1s1O6FcTgGa5UjwAOFuPybRX
WrSj9eKWjYdKGm1DK96RktfT1w6JyssYV4PPkIPEPtA0Qal9Kf45X9qAG63augs4
qCjRpgNdZH0bKF95B6BQOXNnvss47Cu/LnEmkMMoZLgEbunm8JcyHTaRmM5u2HvQ
1PH9zYyc+Uo94Eo1SYXe9txhkR0dSfFZi0P33x/ZIptcnyOHRSZxcNqkgctW4Hxb
j0L2d6Yr1SSBEThDl8Xqlw8+5e7lbznVvlbc0VSNTS80SyCLhh+KuQzfc+ttxMt5
eFZ9WOgqHoIwGlh1eUSIRbHHkzsJ3RlX3KxQysHLsTuExrP+dP3eICDbzHz65QNQ
DgOo3frMKdxKPf2+jbRbEnAiM537N+A1oz41bae4ih2pyI3of1kGR0QRww1UsFj4
hrwBXeuQqabcxu6TJT0vhuBj5KDLKRRvbF3zLt1gwebIyoQ/FRjujaY44OsGYazw
mAezXAAN
=+80H
-----END PGP SIGNATURE-----

--XwkxnDRJXgBg20Dg--
