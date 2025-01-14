Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE586C02180
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 01:22:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F65F805C5;
	Tue, 14 Jan 2025 02:22:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="njII9Gks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B661805DA; Tue, 14 Jan 2025 02:22:28 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 806D480285
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 02:22:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d8e8cb8605so27026066d6.0
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 17:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736817744; x=1737422544; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nxf1b2BMsbxpoUs5eN/NGfe59La1WmvSzuGi4zknsfo=;
 b=njII9Gks0JqwYIGYM/EPX+f/VCjmhV1aPGwI0rFf1A1hswhhrqIJEaX7NFW6abtNO4
 thIghQgVh65CwTDFWApzkVGwIndcF/WVp76dHzl1HQZFS3WSuWJE1JgfGe5qaVoVceiT
 3Duh/Z4CbmHmMIqb0u7RhWhOX7Xlf5AyyK5v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736817744; x=1737422544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nxf1b2BMsbxpoUs5eN/NGfe59La1WmvSzuGi4zknsfo=;
 b=KyysN+tEgBGCtA64Ru/VB+BBC2hexDc8eBGvT/wKOg1eVHVOzVV+7dxCk31Wnf6kDS
 lT9dbrK2nXqf8jxh+vKQASMDZc1I6j+YB/xzdz7JAwGv0bjQZhveAg7B6bS8k8TBlwdX
 /VIp+boHxduagN/orFZmYtW46NFOLwS4njwjtzuvn188wPvDqjTHlCM4Qx6lCNi512bd
 5FQ3Tr/Wy+lrEy8t0XF41pCIpDNTAMXsNScNOn8iknnUxuGxLy4WgzLvVY810BnbUVr5
 3/1yLKRFqmzWa7abYzdMS+JuSC0aevq/orfiOOV3qcf/Stcg/iY1fJOTY/FBLvdj55Bk
 42AQ==
X-Gm-Message-State: AOJu0YymtQ1gVpjlG2R4M24gMvxNnWMb4+HGBJsBQMswO5PXeFpOqcHY
 M7bTBZqC7YDhENnAOxFrkfzP5PjlPea6z5TY3CyTN2cmscyfh4vW0G0gho4BkOc=
X-Gm-Gg: ASbGncsHBf/0I+AlgPeQmf2aZfP4384soK02uYJEQhZurgGMLMLUd3ffxYK+2HWT8FZ
 Z8ZBkCw7++ZHj0efg4UwNfCEXRseA5/Zx41kJzTww5teIqcD+/Lj3uPAbrZFF/DCfZbnMHjo4tV
 rUa8R7s/HBpuK4swIj8Ruv9J4KIILHHzBKb5Ew9TNf99PLyHkYotxhMP2YAxTDyz0AY7xaGiAWN
 mC8h14l+kKV7L848JL4XKmx6e9FSswlKXCEOq56LFQQ4ua0snk4Z61WJg==
X-Google-Smtp-Source: AGHT+IFwTQeGOVDoDklt9U4hnGEA1zs+YpKOYp1hFKdpYJ2AZHHryUikLAHebLzg2EmcB1TwhRyvPw==
X-Received: by 2002:a05:6214:e8d:b0:6d8:7d7c:bdd5 with SMTP id
 6a1803df08f44-6df9b2d4e78mr379588326d6.36.1736817744240; 
 Mon, 13 Jan 2025 17:22:24 -0800 (PST)
Received: from bill-the-cat ([187.144.100.247])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cd1b0sm48459971cf.49.2025.01.13.17.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 17:22:22 -0800 (PST)
Date: Mon, 13 Jan 2025 19:22:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 02/15] vbe: Split out reading a FIT into a common file
Message-ID: <20250114012219.GF3476@bill-the-cat>
References: <20250109123010.4005298-1-sjg@chromium.org>
 <20250109123010.4005298-3-sjg@chromium.org>
 <20250111225433.GS3476@bill-the-cat>
 <CAFLszThO9BaSi8R8=3FpLq7Nnx7XdiCungY1vcRfKyfFQ0baJQ@mail.gmail.com>
 <20250113204419.GE3476@bill-the-cat>
 <CAFLszTjo1FcHL4G76u1tS3caEgdpk7FHdstoXe+AhERO8rJJfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NhyOmVU5ELqK8Gau"
Content-Disposition: inline
In-Reply-To: <CAFLszTjo1FcHL4G76u1tS3caEgdpk7FHdstoXe+AhERO8rJJfg@mail.gmail.com>
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


--NhyOmVU5ELqK8Gau
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 05:13:46PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 13 Jan 2025 at 13:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jan 13, 2025 at 01:03:52PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sat, 11 Jan 2025 at 15:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jan 09, 2025 at 05:29:57AM -0700, Simon Glass wrote:
> > > >
> > > > > Loading a FIT is useful for other VBE methods, such as ABrec. Cre=
ate a
> > > > > new function to handling reading it.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > This causes a bunch of growth:
> > > >             a3y17lte       : all +1328 text +1328
> > > >                u-boot: add: 8/0, grow: 1/0 bytes: 1328/0 (1328)
> > > >                  function                                   old    =
 new   delta
> > > >                  blkcache_fill                                -    =
 332    +332
> > > >                  blkcache_read                                -    =
 240    +240
> > > >                  blk_read                                     -    =
 188    +188
> > > >                  vbe_read_nvdata                              -    =
 156    +156
> > > >                  vbe_read_version                             -    =
 140    +140
> > > >                  vbe_get_blk                                  -    =
 100    +100
> > > >                  simple_read_nvdata                           -    =
  96     +96
> > > >                  crc8                                         -    =
  72     +72
> > > >                  vbe_simple_read_state                      108    =
 112      +4
> > > >
> > > > Which is unexpected for just moving code around that's not newly us=
ed.
> > >
> > > I hadn't noticed that on the boards I was trying, so thank you for sp=
otting it.
> > >
> > > This is because it now uses blk_read() instead of blk_dread(), so if
> >
> > That's not what this patch does? There's no caller before or after in
> > this patch of "blk_dread". Just moving functions around should not
> > increase size on platforms that weren't using the existing
> > functionality.
>=20
> Firstly, are we looking at the same patch? Here is the one I am looking a=
t:
>=20
> https://patchwork.ozlabs.org/project/uboot/patch/20250109123010.4005298-2=
-sjg@chromium.org/

You're right, I replied to the wrong patch here, sorry for the
confusion. I'll move some of my comments in reply to the correct patch
now.

[snip]
> > > > And even when it's just a move it's still growing:
> > > >             xilinx_zynqmp_virt: all +128 bss -72 text +200
> > > >                u-boot: add: 4/0, grow: 0/-1 bytes: 540/-340 (200)
> > > >                  function                                   old    =
 new   delta
> > > >                  vbe_read_nvdata                              -    =
 156    +156
> > > >                  vbe_get_blk                                  -    =
 148    +148
> > > >                  vbe_read_version                             -    =
 140    +140
> > > >                  simple_read_nvdata                           -    =
  96     +96
> > > >                  vbe_simple_read_state                      452    =
 112    -340
> > >
> > > Unfortunately this one is hard to fix. As you know, whenever you take
> > > code from a single module and put it into another, the compiler cannot
> > > optimise away the function-call overhead. I'll note that there is no
> > > increase when LTO is used, e.g. with xilinx_versal_net_mini_qspi

Yes, but 200 bytes isn't just function call overhead. Some of that might
be from going from one ALLOC_CACHE_ALIGN_BUFFER(u8, buf,
MMC_MAX_BLOCK_LEN) to two?

> > > So let me know what you think.
> >
> > You likely need to re-think your refactor a bit then. If it's in part G
> > or H that we have more than one caller of any of these functions, that's
> > perhaps where it's time to refactor and expose them?
>=20
> Yes of course I can move things around. I would need to drop the FIT
> loader as well, so this series would become quite small. Shall I do
> that for the next version?
>=20
> But just so that I understand...in the next series, when abrec is
> added, and I have these same patches, will you accept this size
> increase?

It sounds like you're talking about re-ordering patches and I'm asking
you to re-work your re-work of the code so that it doesn't grow things
without explanation, and minimizes growth. Maybe that's code changes,
maybe that's better commit messages, likely it's a combination of both.

--=20
Tom

--NhyOmVU5ELqK8Gau
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFvEgACgkQFHw5/5Y0
tyzvFgv8DsER54lfwVz23hYx3Q3coxIPwkxGMW9lYShICaLxBLXNurrAU3O4X+a6
55ogBx4MN7BPgbUqmhvGIWXwT2o8zP/6olToqsS5OaD/KoVhHbx93biCTMbXcjA7
tWFfTwfbkPGzbRbWxb7rgM0OLMI8n5rKE1mYVkGcpFf63RSJZNa+B9jPC7qixfQH
h50hZz+xLxTUxk69VLijzY2V9OFj9J23Umq5TzkKiPExPzlNw1eKHdKtYQZU9EHZ
Lw+oNBSeLM/CwmJ3QsaH2ERiJGWVB87CjWrgfYIbH95XK8QYwFnwK8OIZilEYciQ
H+UejkXhzqQ28stkGH51XuL92nYiKyxhg7YD2QR3IflCZDzLe03+tzL9RbqgjhmH
TaZcRnjbllXGPSW/h7d5T4PYQ7yehyDRTqg8Gy0ed0BFc0iHvXjV+Cj+D0Ubm3mD
P3vVz3dx1/gqPG8+lpj6NRv8kgjc6dnRtCqdUrScOgoebSFgzvTpUIbpJdEPegKS
ymSSHV0g
=aSFq
-----END PGP SIGNATURE-----

--NhyOmVU5ELqK8Gau--
