Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21120C48BF6
	for <u-boot@archiver.kernel.org>; Thu, 29 Feb 2024 14:01:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 764A4880CA;
	Thu, 29 Feb 2024 15:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L3NgAxVO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36D4B880CC; Thu, 29 Feb 2024 15:01:50 +0100 (CET)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 876BD880BF
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 15:01:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-607cd210962so9135257b3.2
 for <u-boot@lists.denx.de>; Thu, 29 Feb 2024 06:01:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709215304; x=1709820104; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wVrLwfCGBMXf7qiBOyxKhw5a6eWFAj/RengHRYijRS8=;
 b=L3NgAxVO59Xqy4BH6yca75/nkG7Rlfu26onqUO96XncrYgTJASehRRoDgNLLlC4Kef
 4bmAUwh0S7YMEDrKjOSb3/yoNxdxN15CGJXFmeEopj4Wb/zy0YtYdQ1t+YTtK7Zu+6kq
 o0hD5+KFvMK98SwjlCONBbTlAd+LCb1ETTeQc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709215304; x=1709820104;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wVrLwfCGBMXf7qiBOyxKhw5a6eWFAj/RengHRYijRS8=;
 b=HPYUrpBNcX1YZjVEvlMnRh2qwFprbVeMQy9yRk9RE8WnHIxIntJIZSWEAfO10CrFAn
 82yQgylMu/8beAJTBXumujRGOjwQR7NrEXQaq70oBxyMOScvMCqnLgaidYTzQmfQZEWX
 no/HLuQevE6ct1eMYg27NqqoWJBTRHTxh1bpWrMh4W0RpmuH2Qs/ztRLhDyWfA2PSfzm
 jjMg1nqpuEPIbvoMzFjnaluApWCjFJVGM21Ckjq9DYUbBcrHPEVmS2RYlLAhYwKVPQiV
 4aaedYa62tnbZOqoDOmdXIEaG6MxqI10wuY4uVY1iLJuuL1qavw2Zbd6wXOXeVDSFOkp
 +jUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDqUayvoWo+HyOWcMN8rRoLQwwqCsShb3hyJ727F1bziaCo4Vt/RF1MCfKv2HKkDauqyf2PkESkJ20qVK8+9Smyk12EQ==
X-Gm-Message-State: AOJu0YwgCNUyQbeZ5y1Me76fJO0LvqvTsyqIHuZe+jMLDDkBPegHuRZg
 UWziUbVvNTuxF7MBW1dQpUVLiapls08vPOrYZYfoXl/cUvqJv2c6GdMwlKzdaSk=
X-Google-Smtp-Source: AGHT+IEi6c2BGdSFjnlUkUYPUUAhpqyclZdD4u32yFQLgZCDgTSwP3vAXDgOf7yw/C9DGR634jZJKg==
X-Received: by 2002:a25:ae59:0:b0:dcc:323e:e1a4 with SMTP id
 g25-20020a25ae59000000b00dcc323ee1a4mr2617911ybe.6.1709215303725; 
 Thu, 29 Feb 2024 06:01:43 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 m12-20020a25260c000000b00dc25d5f4c75sm339769ybm.10.2024.02.29.06.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:01:43 -0800 (PST)
Date: Thu, 29 Feb 2024 09:01:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor@kernel.org>, shawnguo@kernel.org,
 Dan Carpenter <dan.carpenter@linaro.org>, Rob Herring <robh@kernel.org>,
 =?iso-8859-1?Q?S=E9bastien?= Szymanski <sebastien.szymanski@armadeus.com>,
 u-boot@lists.denx.de, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 1/2] opos6uldev: make the LCD work again
Message-ID: <20240229140140.GS3040305@bill-the-cat>
References: <20240227154002.30257-1-sebastien.szymanski@armadeus.com>
 <47c12ca3-ea7c-4097-90b5-0333c74b05aa@moroto.mountain>
 <20240228131029.GM3040305@bill-the-cat>
 <CAFA6WYN4sCk9Q66i_n+aXxRkGEbh66dh+Sr_C5SbioQ_s5BBbQ@mail.gmail.com>
 <20240228152034.GN3040305@bill-the-cat>
 <CAFA6WYMkdjE6Vrd2_fV_6Rzj8MOiPhO4EJ4kkik1_9vQnhzMqQ@mail.gmail.com>
 <20240229134242.GR3040305@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Z176jtyeTmOio0P4"
Content-Disposition: inline
In-Reply-To: <20240229134242.GR3040305@bill-the-cat>
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


--Z176jtyeTmOio0P4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 08:42:42AM -0500, Tom Rini wrote:
> On Thu, Feb 29, 2024 at 11:17:28AM +0530, Sumit Garg wrote:
> > On Wed, 28 Feb 2024 at 20:50, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Feb 28, 2024 at 07:44:42PM +0530, Sumit Garg wrote:
> > > > + Shawn, Krzysztof, Conor
> > > >
> > > > Hi Tom,
> > > >
> > > > On Wed, 28 Feb 2024 at 18:40, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Feb 28, 2024 at 10:09:13AM +0300, Dan Carpenter wrote:
> > > > > > On Tue, Feb 27, 2024 at 04:40:01PM +0100, S=E9bastien Szymanski=
 wrote:
> > > > > > > Commit 5d7a95f49999 ("imx6ul/imx6ull: synchronise device tree=
s with
> > > > > > > linux") removed the display timings from the board device tre=
e whereas
> > > > > > > they are still needed by the mxsfb driver.
> > > > > > > Add the timings back (the correct ones) in the
> > > > > > > imx6ul-opos6uldev-u-boot.dtsi file and remove them from the
> > > > > > > opos6uldev.env file.
> > > > > > >
> > > > > > > Update the opos6uldev_defconfig file so that the LCD turns on=
 at boot.
> > > > > > >
> > > > > > > Fixes: 5d7a95f49999 ("imx6ul/imx6ull: synchronise device tree=
s with linux")
> > > > > > > Signed-off-by: S=E9bastien Szymanski <sebastien.szymanski@arm=
adeus.com>
> > > > > >
> > > > > > Huh.  This is the commit that did that upstream.
> > > > > >
> > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git/commit/?id=3Dd9aa4d4fca67823838fe9861456201430c545e69
> > > > > >
> > > > > > It's interesting how the timings in linux were always slightly =
different
> > > > > > from in u-boot.
> > > > >
> > > > > Thanks for tracking that down, Dan. I'm adding in Sumit and Rob h=
ere
> > > > > because this is a recent (rather than ancient) example of one of =
the
> > > > > concerns about OF_UPSTREAM.
> > > >
> > > > I rather think about this as an opportunity to improve with
> > > > OF_UPSTREAM. We can feed these kinds of DT ABI breakages to
> > > > corresponding Linux kernel sub-arch maintainers. Especially once we
> > > > move to OF_UPSTREAM and a sub-arch maintainer profile in Linux kern=
el
> > > > to keep them aware that U-Boot should be considered too.
> > >
> > > Yes, a more extensive check around when removing information from dts
> > > files would be good.
> > >
> > > > > I think the commit in question can be
> > > > > summarized as "remove a bunch of explicit HW information because =
there's
> > > > > now a Linux Kernel driver that determines that dynamically". What=
 do we
> > > > > do next? The old information is in a presumably valid binding sti=
ll, can
> > > > > we just put it back and comment that consumers outside of Linux u=
se this
> > > > > still so it's not removed again later? Or am I just missing where=
 we can
> > > > > instead get this information from the DT still and not need to co=
me up
> > > > > with a new driver and subsystems?
> > > >
> > > > I can see following two paths forward:
> > > >
> > > > 1) Partially revert the Linux kernel commit to add back the display
> > > > timings in DT.
> > > > 2) Extend drivers/video/simple_panel.c in U-Boot to add support for
> > > > compatible: "armadeus,st0700-adapt".
> > > >
> > > > If possible then I would be in favour of (2) rather than the current
> > > > patch to do this properly.
> > >
> > > Well, looking at the kernel drivers/gpu/drm/panel/panel-simple.c driv=
er
> > > and then our drivers/video/simple_panel.c it sure would be nice if it=
's
> > > just a matter of adding a compatible but I wouldn't be surprised if it
> > > ends up needing more information being passed along too?
> >=20
> > Although I am not a LCD panel expert but looking at the kernel driver
> > code [1], the display timings are rather taken from a static data
> > structure matching the compatible "armadeus,st0700-adapt".
> >=20
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/=
tree/drivers/gpu/drm/panel/panel-simple.c#n901
>=20
> Yes. My point is that it seems like the situation changed from "device
> tree provides timings for the platform" to "driver has timing
> information for N displays" and so we'll need to do something clever to
> avoid including the structs for 5 panels when we'll only ever
> (likely...) see one. And that also yes, we'll probably need to add data
> for this panel rather than re-use the PANASONIC_VVX10F004B00 data.
>=20
> > > And I'm going
> > > assume there's good reasons for the design change in how the drivers
> > > work in Linux now and note that it might make things more challenging
> > > for us when we do care about space.
> >=20
> > I agree it is always going to be challenging to use DT during SPL
> > stage which is mostly constrained by limited on-chip RAM.
>=20
> Well, no. The DT way handled this more efficiently, I think I wasn't
> clear enough in my reply.

And it's not just SPL, full U-Boot needs to stay small and within flash
partition considerations and I become cranky and question people when
non-generic changes impact platforms that don't need the change.

--=20
Tom

--Z176jtyeTmOio0P4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXgjkEACgkQFHw5/5Y0
tywAQwwAmoI5Q3j6vhKfyFycN2pSPfHdtl65eZ0/r1fuzX9NLLO/tJ6SiMtL20af
xjNsqhQhmHR4IvCnunprhZyM5AQUwEeSAIyRQD+7uwl8R0jIMPxZ/uXOwTgp010P
eRqvfkZoWUYgu8TH2Dwpyl4TFlASiRSVOIxq97+LqAUTKDpJbtrBuLvvppLrY6tz
h8l0T/fVkBBP3yspXGUxTjZwbUsOq+Uo7lVc00rSeMHhOGq8o6TUtJqGBYhyhCh4
BGFC8cc5BHYLvCNhvhsxmyz4SsxajDDmgyJ07Xi4dHL8Rd8gFYjhZWlvOlJ5fqi6
d3JMUK/nI5x+bbLAqNYvdFaQcmSNWqIACpdX+QEWXmpscMCdq+3TNRua9XYNTBaD
FSUU5KWxkybkTqNTY2VWtSW+vWD1ncWs6gOKHWdr+AswcQyxBgEz3EIcEfsO3mUh
QOiI8q9g4+vrSFF2kdVi5lBR4xdnzA6gMHWroPNeNMYi5LA9e+U4H3ZJZApsevt2
ixj+spR7
=NJjd
-----END PGP SIGNATURE-----

--Z176jtyeTmOio0P4--
