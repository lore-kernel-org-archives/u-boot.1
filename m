Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAA2E77173
	for <u-boot@archiver.kernel.org>; Sat,  7 Dec 2024 00:53:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3A4E8904C;
	Sat,  7 Dec 2024 01:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZAFTqaoc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67F6188E5C; Sat,  7 Dec 2024 01:52:58 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C0189082
 for <u-boot@lists.denx.de>; Sat,  7 Dec 2024 01:52:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8e8cb8605so7628946d6.0
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 16:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733532773; x=1734137573; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IZaYSRXcJEgNdASL7VHpRwGxJWLSCzVZAlnlSpNZdwc=;
 b=ZAFTqaocl4IgkMuHyXi66dI8UiKAGW+3VNVMSI9hfIQyv6Z0gAibxFZysFZmS74dG8
 al0vob2KAIKV0rqmovcqSIjr9KPNjkhCOQubF8RfhpHvwhdAdMeNkxjhY7AXvcYtN3mJ
 hEIwXKMgIqjmd0j7D10VBJJE9Huq9edY8pBR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733532773; x=1734137573;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZaYSRXcJEgNdASL7VHpRwGxJWLSCzVZAlnlSpNZdwc=;
 b=QSlt+WgUDx5XBbe2aE9EM4VY/4vjDq3AYgS1wLajYmmUZ/4HjKjIkCnp3bih0MHfLO
 nm6nitdhywHVghc3LjN66bCuAVmMBEkajCP4ptUAPIAAijC+l8wm5BVoFk6wO3ieGRX2
 L7lrI+Yncvaq48UaxNlCuSLjGyskxmA9PGqR83bQNSR6Jb07ca44+Sp7NgJwNFxgPAy6
 Ol73mhe7TBlECEZCdIpsb3JAXFdziwuawZHFDh60grd7izQlnw9jNWJlFAiVYA+X9uMB
 wJ+7A182+VC3j9AT/x90KaAm5IAN+/LCDX0OfauBZkHCyL/13MGQ3zfGihT9jVdOg+m8
 7lVA==
X-Gm-Message-State: AOJu0Yyd/u9jA17DgR5yT/qzqETYrV5ew0pkcZUyN8Zm4qqZG2thPKSr
 3Q9HYj+5znj90+58suPJDJyB3pknaOM5E99iPxhBVMIdIX3bAudegrlnZsyUNTU=
X-Gm-Gg: ASbGncsrcsCqtdFKFxPYXEBSHO2hvbnxh8gV7e2wbA4Ta26Qc9TpzLllJWkmVqs9HcE
 ckC7qn/01tHQC6C/ng0CmfgihV4ADRhm5/1XlVsQ3iljpMr5EYlXBu3tEc+WoG+pX+z74KAmPa4
 KSuMlxL2ipNkzzK2VLGvNISDswbeEmEBtyWkwWKrMS6quamqCZ61YocvEpv3dNm0FkCXlCUEjBB
 RurX0NSnXUVXpC0E4uigTrTkhq1Ye/7DsCmiYF0LkDa9FN5StY=
X-Google-Smtp-Source: AGHT+IH0m7sD+XBaZVuHQf8zW75WxpMV3pTwPXZ4HJ8+ISZKwe/DJ9pIg6N3wzh3pnl7Uw5LMZ59iQ==
X-Received: by 2002:a05:6214:21cb:b0:6d4:1a42:8efa with SMTP id
 6a1803df08f44-6d8e6fbe307mr56223606d6.0.1733532773041; 
 Fri, 06 Dec 2024 16:52:53 -0800 (PST)
Received: from bill-the-cat ([189.177.125.100])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8f0884263sm9256846d6.97.2024.12.06.16.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 16:52:51 -0800 (PST)
Date: Fri, 6 Dec 2024 18:52:46 -0600
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
Message-ID: <20241207005246.GD2457179@bill-the-cat>
References: <20241206131113.2865416-1-sjg@chromium.org>
 <20241206140852.GO2457179@bill-the-cat>
 <CAFLszTizXjXnc_P3RHpxbKj5qoEfW_Swrc6V6v6dS7kFUqH9CA@mail.gmail.com>
 <20241206194130.GX2457179@bill-the-cat>
 <CAFLszTjQchtBH+K5rRPdiOGgb1bYq3LFWH8BP7jw+noXEaC0GA@mail.gmail.com>
 <20241206235233.GB2457179@bill-the-cat>
 <CAFLszThCR3KG+AVCN_ZeVVmKXverd6g+qNnKrt5YbdTy6jEayg@mail.gmail.com>
 <20241207000029.GC2457179@bill-the-cat>
 <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Oanfj/InZZvZssHr"
Content-Disposition: inline
In-Reply-To: <CAFLszTiLFe80OQy1q5eVCoZ-v0AhaKUOzdcLsWK9wEwn_SzZ9w@mail.gmail.com>
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


--Oanfj/InZZvZssHr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 05:10:39PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 6 Dec 2024 at 17:00, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Dec 06, 2024 at 04:56:31PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 6 Dec 2024 at 16:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Dec 06, 2024 at 04:41:37PM -0700, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 6 Dec 2024 at 12:41, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, Dec 06, 2024 at 12:17:49PM -0700, Simon Glass wrote:
> > > > > > > Hi Tom,
> > > > > > >
> > > > > > > On Fri, 6 Dec 2024 at 07:08, Tom Rini <trini@konsulko.com> wr=
ote:
> > > > > > > >
> > > > > > > > On Fri, Dec 06, 2024 at 06:11:10AM -0700, Simon Glass wrote:
> > > > > > > >
> > > > > > > > > This series allows rpi to boot a compressed Ubuntu kernel=
 with ~100MB
> > > > > > > > > ramdisk, by expanding the available space.
> > > > > > > > >
> > > > > > > > > It also tidies up some strange behaviour with the provide=
d FDT, where a
> > > > > > > > > separate pointer is maintained to it, even though U-Boot =
has copied it
> > > > > > > > > and placed it in its own space. This avoids strange bugs =
where it
> > > > > > > > > accidentally gets overwritten when loading a file into me=
mory.
> > > > > > > > >
> > > > > > > > >
> > > > > > > > > Simon Glass (3):
> > > > > > > > >   rpi: Update environment to support booti and large init=
rd
> > > > > > > > >   fdt: Allow expanding the devicetree during relocation
> > > > > > > > >   rpi: Use the U-Boot control FDT for fdt_addr
> > > > > > > > >
> > > > > > > > >  board/raspberrypi/rpi/rpi.c   | 20 ++++++++------------
> > > > > > > > >  board/raspberrypi/rpi/rpi.env | 10 ++++++----
> > > > > > > > >  common/board_f.c              |  6 ++++--
> > > > > > > > >  dts/Kconfig                   | 11 +++++++++++
> > > > > > > > >  4 files changed, 29 insertions(+), 18 deletions(-)
> > > > > > > >
> > > > > > > > My feedback here is the same feedback I gave the last perso=
n that wanted
> > > > > > > > to update the Pi addresses, and I forget if they came back =
and did that
> > > > > > > > (and it's in Peter / Matthias' queue) or not. Disabling dev=
ice tree
> > > > > > > > relocation is a bug and must be removed.
> > > > > > > >
> > > > > > > > After that, given the range of memory sizes available on Pi=
 platforms,
> > > > > > > > allocating the kernel / initrd / kernel decompression buffe=
r at run
> > > > > > > > time, ala mach-apple would make life easier in the long run.
> > > > > > >
> > > > > > > Yes, of course, but for now, this resolves the problem and I =
don't
> > > > > > > believe it creates any other problem.
> > > > > >
> > > > > > Yes. I think you missed that:
> > > > > > https://patchwork.ozlabs.org/project/uboot/patch/20240723193430=
=2E3050251-1-walter.lozano@collabora.com/
> > > > > > is also outstanding and should solve the problem.
> > > > >
> > > > > No, it doesn't support decompression, although I have to wonder w=
hy
> > > > > that patch was never applied.
> > > >
> > > > See Peter's response elsewhere about having a lot of things to do a=
nd
> > > > not a lot of time. I know he's intended to pick up and post a Pi PR=
 for
> > > > a while.
> > >
> > > OK, but let's drop that patch since it doesn't support decompression,=
 right?
> >
> > No? No one has done all of the work required (remove fdt_high /
> > initrd_high) and this also solves the larger kernel issue.
>=20
> No, that is a separate issue. We need kernel_comp_addr and kernel_comp_si=
ze

Yes, those are required for automatic decompression, which is handy. But
the highest priority is removing fdt_high / initrd_high because those
lead to so much time being wasted by everyone. Your time digging in to
and making patch #2 for example.

> > > > > > > The solution should not be board-specific though. Once I have=
 the
> > > > > > > bootstd files stuff is finished, I believe that bootstd will =
be able
> > > > > > > to do this and I plan to do this. Then the variables will be =
unused
> > > > > > > for rpi and we can just drop them for any bootstd boards.
> > > > > > >
> > > > > > > As of now, we have 390 boards using bootstd and 381 using dis=
tro
> > > > > > > scripts, so it is progress!
> > > > > >
> > > > > > Yes, it will be interesting to see what the future holds, and a=
ny of the
> > > > > > solutions handle some of the trickier corner cases that lead to=
 the
> > > > > > current situation. Or perhaps the best outcome is that in curre=
nt times,
> > > > > > those corner cases don't really appear anymore (with 512MiB DDR=
 being
> > > > > > the lower bound for example on all the Pi families).
> > > > >
> > > > > Well rpi is a bit unusual...
> > > >
> > > > Sure, but not in this case? Lots of examples of multiple models with
> > > > different memory sizes, and especially with 32bit platforms smaller=
 (by
> > > > current standards) overall DDR.
> > >
> > > I mean in the sense that it puts the devicetree in the middle of RAM.
> >
> > Which and where? Or do you mean it being exacerbated by disabling
> > relocation (which is why I keep going on and on about removing that from
> > platforms that do it)? Most platforms will load to the "middle" and
> > that's why you must not disable relocation because it's only a problem
> > when, well, relocation is disabled and U-Boot says "Gee, you're going to
> > break but you told me you want that, so, alright then."
>=20
> No, the rpi relocates. I just mean that it puts the DT at about 512MB
> in RAM, which is annoying.

I guess we've once again lost some details. With fdt_high=3D0xffffffff we
do not relocate the device tree we're going to pass to the OS from
wherever it happens to be at the time. That is what I mean by
relocation. Looking at a Pi 4 here real quick, it has
fdtcontroladdr=3D3aea8b30. But if you mean fdt_addr, yes, that's around
512MiB (fdt_addr=3D2eff2d00) and likely the previous stage throwing it
there for the OS as a likely always accessible option.

--=20
Tom

--Oanfj/InZZvZssHr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTnFcACgkQFHw5/5Y0
tyxMrwwAoCjZT/Pkx2zgRt9cE9KKg7pIF/cEyBvJHkCcZTApSQXLxCLovWg9Wgqn
aMdfSGcKmB6RUqx0pIaeWIrNUVfh+cjCHKcDogqYJPQeXkSc6ZqsmLsslZvuDCEA
BCEUXxWsW+SnWvuHt9HPnPbGrU3xU7c6gde25LEFOj0mhrSgdI5gKa7/iEiTlPSB
PNiGFTD1TMJLFhriB3JXvLiexCU9TuaEsQVk7Dw7JHhIZ0QVfO2GwzlIhe4JsE4Y
4KdGiLqZjsmfb/ivYe7Nkch5tEj4+0RxTLi8auZWUiCMcXrR7ZphE6+n6jrLXGfr
lz09j+2xjfJtx5mJZ9tVM/1LzBhmbWYW4mdaSXheF7TsK/3TZaLzxWy2+uJLcPVf
ntzNEEp3IcvtsjECusNOV15Pu5YsHBFa7DcFySzkkPno7FI/Hjr2dPTPJb9/MX6Q
y+qr8vYY7+W0d65iL9UyWDEEzy9i2FTu+BnnLx3pMhqx1QRDzBTd2cWW/6bNUene
6/Jo/1zw
=q4M3
-----END PGP SIGNATURE-----

--Oanfj/InZZvZssHr--
