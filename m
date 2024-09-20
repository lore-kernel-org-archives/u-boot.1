Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6304C78853
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:01:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C59688AA7;
	Fri, 20 Sep 2024 17:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="T6JcMgq8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1125A88BD2; Fri, 20 Sep 2024 17:01:46 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D352788498
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7a9ac2d50ffso180791085a.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726844503; x=1727449303; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/w4tYNLucMgJgUfvn3thsYrICF+0CRNRDEsbdT66tw4=;
 b=T6JcMgq8sQ0Q+XyX4ioQE4zVG7y0hO28n6qAQxEzVT3Jq4Nk1EX8CnYhtBlLZH2KNO
 NA+4aXx/hwnp+KcukxDgoktWbYqD0e8OPe+1PB8gAd/YdhbUxAIPPcVl0zuIjPFbRqAr
 YXuZfpBHDySYd73iHMx/ueWrbB4DYVKDSpZE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726844503; x=1727449303;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/w4tYNLucMgJgUfvn3thsYrICF+0CRNRDEsbdT66tw4=;
 b=emI7Ddx58YIcxQByWYCEyNF21fyXGmZaoU0/9PPD9nUyvea9xisdnLYwTtSSewxr3K
 +YRGKTRBKNKSkwDDdbvP62zyi/oLhyUV9ZjYjKNqFiGiR9cL8p43iRQUgtCRTTBBwtQW
 M290RbLxCv0pXNeLJhFx8dECANgh2IsLQhqY1jjs8dnwAk+DTmHJu9ZyhnAOpNgOEG8t
 YtMtWzZ5jTC6FeRDvm86b/hARncyOhLjoqG247FEQqygT5aw/4dq3hM2GxDS3W+Gg7Fq
 eC+dlVzKDncjaxDOpypb+45xYhwuv9yjpw8r+65qWqTp3/9+lNBGC0Fj175RHwLEb3L/
 Xnhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcjka1EnW5J0ZHH8uag1+FdRjjAfAoNC67u3oJOT4jwMrZsEud0AopRBcVvcO2W1Cg3XlNtjU=@lists.denx.de
X-Gm-Message-State: AOJu0Ywgupyj2NWy5O/SOwlgOje0ilXrj0ahUtwbsx933p7TfFB7zxpm
 Rm7AlwmO/S4e42URkSgUFRJimpBPKLt1oTZB5ziS1JiCFC8BgrdqFAxl5AXfb8M=
X-Google-Smtp-Source: AGHT+IE0rtgKqyZlnsZOBlCQeXJfuNJV8dFHSoj1bLOqLxDNnISjLlrHFK7j5PLajLT/n7+HggQoSg==
X-Received: by 2002:a05:620a:45a4:b0:7a9:ad0b:6d61 with SMTP id
 af79cd13be357-7acaf54b841mr1048024885a.9.1726844502506; 
 Fri, 20 Sep 2024 08:01:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7acb0829f1dsm187094085a.60.2024.09.20.08.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 08:01:40 -0700 (PDT)
Date: Fri, 20 Sep 2024 09:01:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>,
 Apurva Nandan <a-nandan@ti.com>, Bryan Brattlof <bb@ti.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jayesh Choudhary <j-choudhary@ti.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Roese <sr@denx.de>, Tony Dinh <mibodhi@gmail.com>,
 Vaishnav Achath <vaishnav.a@ti.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 huang lin <hl@rock-chips.com>
Subject: Re: [PATCH 00/18] vbe: Series part D
Message-ID: <20240920150136.GD4252@bill-the-cat>
References: <20240828014538.3322013-1-sjg@chromium.org>
 <CALeDE9MX6MMECX+vNCjMs8Z2_G3+gSio4BxFHgez-H_a4f2Uyg@mail.gmail.com>
 <CAFLszTgrCGhvhO0GDSLABu1D10H97dBWFSnEf8gSJujq6iUduw@mail.gmail.com>
 <20240830004936.GP2479150@bill-the-cat>
 <CAFLszTjjni839jghOpforB-4+MnqRh7JXw575VtP_UO-SzfnKg@mail.gmail.com>
 <20240830014622.GQ2479150@bill-the-cat>
 <CAFLszThE7mrnOyGCzPcC01soCvoT++SgvUp4WpHiJZH4CXhWQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9jryl7ZT6rqmUUsb"
Content-Disposition: inline
In-Reply-To: <CAFLszThE7mrnOyGCzPcC01soCvoT++SgvUp4WpHiJZH4CXhWQw@mail.gmail.com>
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


--9jryl7ZT6rqmUUsb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 09:25:53AM +0200, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 30 Aug 2024 at 03:46, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Aug 29, 2024 at 07:06:32PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Thu, 29 Aug 2024 at 18:49, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Aug 28, 2024 at 04:16:55PM -0600, Simon Glass wrote:
> > > > > Hi Peter,
> > > > >
> > > > > On Wed, 28 Aug 2024 at 03:59, Peter Robinson <pbrobinson@gmail.co=
m> wrote:
> > > > > >
> > > > > > Hi Simon,
> > > > > >
> > > > > > > This includes various patches towards implementing the VBE ab=
rec
> > > > > >
> > > > > > What is abrec?
> > > > >
> > > > > It's a VBE method which supports A, B and recovery images and per=
mits
> > > > > updating from SPL onwards. The idea is that you can safely update
> > > > > without bricking a device.
> > > > >
> > > > > >
> > > > > > > bootmeth in U-Boot.
> > > > > > >
> > > > > > >
> > > > > > > Simon Glass (18):
> > > > > > >   sandbox: Add missing header file
> > > > > > >   bootstd: Add stub for bootdev_setup_for_sibling_blk()
> > > > > > >   gzip: Correct function comment for gunzip()
> > > > > >
> > > > > > Is this from upstream gzip code somewher?
> > > > >
> > > > > I'm not sure, actually.
> > > > >
> > > > > >
> > > > > > >   fdtdec: Support separate BSS for all XPL builds
> > > > >
> > > > > Needed so that VPL can use DDT
> > > > >
> > > > > > >   tiny-printf: Correct return values
> > > > >
> > > > > I can't remember, sorry.
> > > > >
> > > > > > >   tpl: Support numbered aliases in device tree
> > > > >
> > > > > The MMC needs to be accessed using its sequence number
> > > > >
> > > > > > >   ram: Support driver model in TPL
> > > > >
> > > > > That should say VPL...but again I'm not quite sure
> > > > >
> > > > > > >   serial: Support debug UART in TPL
> > > > >
> > > > > This allows debugging of the jump from TPL to VPL
> > > > >
> > > > > > >   armv8: Support not having separate BSS
> > > > >
> > > > > VPL doesn't want a separate BSS since SDRAM isn't available that =
early
> > > > >
> > > > > > >   arm: cache: Drop a stale comment
> > > > >
> > > > > Just something I noticed
> > > > >
> > > > > > >   arm: Fix up a stale comment in sections.c
> > > > >
> > > > > Another thing I noticed
> > > > >
> > > > > > >   mmc: Support driver model in TPL
> > > > >
> > > > > TPL needs to read VPL from MMC
> > > > >
> > > > > > >   mmc: Add more debugging for SPL
> > > > > > >   mmc: Log the error when init fails
> > > > > > >   mmc: rockchip: Log some error returns
> > > > > > >   mmc: rockchip: Allow clocks to be missing
> > > > >
> > > > > These all help with debugging reading of VPL from the correct MMC=
 device
> > > > >
> > > > > > >   rockchip: mmc: Fix a missing colon
> > > > >
> > > > > Just something I noticed
> > > > >
> > > > > > >   rockchip: Provided SPL control over efuse presence
> > > > >
> > > > > We don't want this driver in TPL or VPL
> > > > >
> > > > > >
> > > > > > I'm not sure what most of these patches have to do with VBE?
> > > > >
> > > > > Basically there are a lot of little tweaks needed.
> > > >
> > > > Well, I think this gets back to some common feedback. You have a lo=
t of
> > > > little bugfixes, which is good, but they get sprinkled in to the ne=
xt
> > > > big series you post, which is bad and hard to review. And that lead=
s to
> > > > fixes not getting merged / reviewed timely because nominally simple=
 fix
> > > > A is in part 3 of a series to introduce something larger and to whi=
ch
> > > > there is feedback to work through.
> > >
> > > I actually thought I was splitting them up quite nicely. What do you =
suggest?
> >
> > I would refer back to your own comments about what some of the patches
> > do and say that "Just something I noticed" should be a one off, and
> > little fixes for this-and-that should be a 1-2 part series and so on.
>=20
> I really don't have a great workflow for keeping track of more than
> 6-8 pending series and even that is sometimes a struggle. For testing
> I need everything applied so I have every series in a sequence applied
> locally.
>=20
> I will have a think about what can be done. I wonder how others do it?

I believe the answer is multiple branches and merging them as needed. Or
what I do is make each subsequent series a branch off the previous one
(and set the upstream appropriately) and then rebase as needed.

--=20
Tom

--9jryl7ZT6rqmUUsb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbtjlAACgkQFHw5/5Y0
tyyV4QwAh5uU7ecBeG5QKrg75xjdgQf3XQjB7dUypfdclfeYBFzrc/D2NJZBxjk1
Ho+WEcWRtmJe9vEt6mq2ExMz44OfmKCJQfmXBXTGz3xZzJ9EhrlU7alO9/2nclo7
k1oKlwlhZ56O8m9j/8NYRU7Jq9YBtKP0AfXVZpQKLY4yqAjDRNtBuudxwRAxJOy9
EelGF5aV97d3+pDKb3mNAEZjpr14hxuArNeae0CS/+hKGSnv+GjlVWzzyKaEVRGW
HeG1WDFDHJ7JYSUXEm7iKSTI4xkZqYPFrDAeKUCK00WJ3tsKZTtEVIpbHqDt7NWU
p+g6FWvanlnvYriMwLgd48y8jCa/ejojJpOtZM1EZiRzfYuD4/CtLIQK+ofFoA0W
F8rViV06G07B71o8d1ZF/INjKtmJiRWCgSQHMXBQCCsyC3c1cqPO66OwkhdUF6NW
moYBSnmio+K2REpwYDCmoSULYIrcjmZDfYkktr8B+J8qBHlMdB39RZCy5TpHx6P5
xn4qZDPk
=8yjX
-----END PGP SIGNATURE-----

--9jryl7ZT6rqmUUsb--
