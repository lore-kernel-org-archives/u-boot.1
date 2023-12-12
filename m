Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCA5C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 12:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6406A877F7;
	Tue, 12 Dec 2023 13:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SiMQuPYb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD8F687800; Tue, 12 Dec 2023 13:42:13 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6786A877BF
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 13:42:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5cbcfdeaff3so56750167b3.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 04:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702384930; x=1702989730; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kMOJmATQXO4ILqVZoYcqRqM3a9HwvfToTT+CxDTpK4Q=;
 b=SiMQuPYbE6TATPlitUBRULg5POmcIpQcRm8WNCCU0KxqDU4WDAriI+zlt8reysMlY1
 WO4/cJVZkUen6IFLekb/2DWsswJ6teP3W1rsuuKhnjLxneUWtzmnyLvzbsDNLaF76XFp
 R090LM1v1/mjTixDscnTVo9rPw5SdAI8bje04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702384930; x=1702989730;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMOJmATQXO4ILqVZoYcqRqM3a9HwvfToTT+CxDTpK4Q=;
 b=FlGMxAgXUI4c2ThUZ3S9ycCRun3lWxe2d5SPkk/IIjrQJuD8ZrG8ODbK4ucfETOSpd
 nwtdkwx71NRNiEPAm4m9skEb+F8Nyk6V9CikKPbdUpLAeduOhS/bQh9fO93aBUwrtj37
 EljUJqrWbLSufJD5AkZoCmZpaq0VfBSjXd/XLGlcFlYtoTPST4mfiDJ+Nj9MXdtpUIue
 SFIC6fkD7rZGBuaVB2Cb1pxnxLZrqda3mOPi7j3ylm3qHZLfFdPqF3z/jROpKJqp09Em
 SMB05mvIMvJQ63HqGlYeeP/4D9GC6cOrCTPRa9jss6OZe0BeQ48tWvLU0astK4c51+FN
 6bzA==
X-Gm-Message-State: AOJu0YwHukSO+7hTnTt6SrMQfNsdn4u3AJZe3OvbFq7WhwMFtJN+GXwH
 CJoXl2DipcO1NnMcrmpQiFMBow==
X-Google-Smtp-Source: AGHT+IHQfVctbPgc/9FyVxKHxq2Wp2qkPlCy71jHy/aLZg93fBXmpWpRbdvua8V4LkLiQe3TU+vUSg==
X-Received: by 2002:a81:8046:0:b0:5d7:1940:f3d9 with SMTP id
 q67-20020a818046000000b005d71940f3d9mr5630369ywf.65.1702384930035; 
 Tue, 12 Dec 2023 04:42:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4e19-645a-5f86-e6ef.res6.spectrum.com.
 [2603:6081:7b00:6400:4e19:645a:5f86:e6ef])
 by smtp.gmail.com with ESMTPSA id
 j3-20020a0df903000000b005add997ae53sm3754570ywf.81.2023.12.12.04.42.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 04:42:09 -0800 (PST)
Date: Tue, 12 Dec 2023 07:42:07 -0500
From: Tom Rini <trini@konsulko.com>
To: Thierry Reding <treding@nvidia.com>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 0/5] Convert recently merged T30 boards to use DM PMIC
Message-ID: <20231212124207.GZ2513409@bill-the-cat>
References: <20231106083229.256322-1-clamor95@gmail.com>
 <CALeDE9P=aUfEvhh-FD_mwRZ+5rgMkQbn+v6skqW7s3EVvnf6eg@mail.gmail.com>
 <CAPVz0n0LDVh-8W=o2Hp-AXU_=Jg5CnuYh54LxsE6XH=DD7nD5A@mail.gmail.com>
 <CALeDE9NLfGRpLxNNqNGOY3S-d9hWP1DWDjL526JNw_8xPqjaXw@mail.gmail.com>
 <CAPVz0n1WepmE6pTxSaeK6yHH2ji6_L+LF7a=TZk6hLWS8GcHKA@mail.gmail.com>
 <CALeDE9NjK3b=OskgsjCvO44M01nRZ6-5LrEgUZtYQfxy7gN5mQ@mail.gmail.com>
 <20231106210407.GK496310@bill-the-cat>
 <ZVTo7BKHmwzns_G-@orome.fritz.box>
 <20231115191149.GI6601@bill-the-cat>
 <ZXb4tN6CI6ZpPNX0@orome.fritz.box>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R0mU4Z07x/GEtu2Q"
Content-Disposition: inline
In-Reply-To: <ZXb4tN6CI6ZpPNX0@orome.fritz.box>
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


--R0mU4Z07x/GEtu2Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2023 at 12:55:32PM +0100, Thierry Reding wrote:
> On Wed, Nov 15, 2023 at 02:11:49PM -0500, Tom Rini wrote:
> > On Wed, Nov 15, 2023 at 04:51:08PM +0100, Thierry Reding wrote:
> > > On Mon, Nov 06, 2023 at 04:04:07PM -0500, Tom Rini wrote:
> > > > On Mon, Nov 06, 2023 at 02:11:16PM +0000, Peter Robinson wrote:
> > > > > On Mon, Nov 6, 2023 at 1:28=E2=80=AFPM Svyatoslav Ryhel <clamor95=
@gmail.com> wrote:
> > > > > >
> > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=80. =
=D0=BE 15:13 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > > > >
> > > > > > > On Mon, Nov 6, 2023 at 11:58=E2=80=AFAM Svyatoslav Ryhel <cla=
mor95@gmail.com> wrote:
> > > > > > > >
> > > > > > > > =D0=BF=D0=BD, 6 =D0=BB=D0=B8=D1=81=D1=82. 2023=E2=80=AF=D1=
=80. =D0=BE 13:46 Peter Robinson <pbrobinson@gmail.com> =D0=BF=D0=B8=D1=88=
=D0=B5:
> > > > > > > > >
> > > > > > > > > Hi Svyatoslav,
> > > > > > > > >
> > > > > > > > > > Since the proposed PMIC patches have been accepted, I s=
ee the need
> > > > > > > > > > to convert boards which I maintain to use DM drivers in=
stead of board hacks.
> > > > > > > > > >
> > > > > > > > > > Svyatoslav Ryhel (5):
> > > > > > > > > >   board: lg-x3: convert LG Optimus 4X and Vu to use DM =
PMIC
> > > > > > > > > >   board: endeavoru: convert HTC One X to use DM PMIC
> > > > > > > > >
> > > > > > > > > Is there a reason why the two above devices don't appear =
to have their
> > > > > > > > > .dts files in the upstream kernel?
> > > > > > > > >
> > > > > > > >
> > > > > > > > Yes, there is a reason. Linux maintainers treat submitters =
as
> > > > > > > > existential enemies or as dirt at least. I was trying to wo=
rk with
> > > > > > > > linux but I have no desire to spend any time to upstream en=
deavoru or
> > > > > > > > lg_x3.
> > > > > > >
> > > > > > > The usual policy for acceptance into U-Boot is to have upstre=
am review
> > > > > > > in the kernel first.
> > > > > > >
> > > > > >
> > > > > > May you point to a policy which clearly and explicitly states t=
his as
> > > > > > a mandatory condition?
> > > > >=20
> > > > > There have been a number of devices rejected in the past until th=
eir
> > > > > DT are upstream but I'll leave Tom, who I've explicitly added on =
cc:,
> > > > > to clarify the exact policy.
> > > >=20
> > > > Well, here is where it's tricky. I brought this up for one of the
> > > > Broadcom MIPS platforms a week or two back, and Linus Walleij's poi=
nt
> > > > (and I'm paraphrasing) is there's not really an upstream for it to =
go.
> > > >=20
> > > > What we cannot have is device tree bindings[1] that aren't upstream=
 or
> > > > worse yet conflict with the official bindings.
> > > >=20
> > > > So the general way to resolve that is have device tree file be drop=
-in
> > > > from the linux kernel, and what additions we must have be done via
> > > > -u-boot.dtsi files. And in turn, some SoCs are better about keeping=
 in
> > > > sync with the kernel than other SoCs are.
> > > >=20
> > > > Now, upstream being actively hostile to dts files, especially for o=
lder
> > > > platforms? That's unfortunate. So long as we aren't violating the r=
ules
> > > > about bindings, the intention is that we don't have device trees th=
at
> > > > are either (a) massively out of sync with the kernel[2] or (b) kept
> > > > intentionally mismatched from the kernel.
> > > >=20
> > > > --=20
> > > > Tom
> > > >=20
> > > > [1]: There are both examples like binman that Simon is working on at
> > > > least but this is more exception than intentional rule.
> > > > [2]: Per our other conversions, I know the tegra ones are in this
> > > > unfortunate state in general
> > >=20
> > > On the Tegra side we've been fairly lax about the device trees in
> > > U-Boot, I suppose. The assumption had always been that U-Boot would l=
oad
> > > an external DTB and pass it to the kernel on boot, so keeping them bo=
th
> > > in sync was never a high priority.
> > >=20
> > > U-Boot does only a very tiny amount of what Linux does, so dropping in
> > > the kernel DTB always seemed a bit overkill.
> > >=20
> > > In either case, if this is problematic, it's something that I could t=
ake
> > > a look at. Again, it's expected that the device trees are different, =
for
> > > historical reasons, but I'd be surprised if they actually conflict wi=
th
> > > one another. U-Boot's DTB was always supposed to be a subset of the
> > > Linux DTB.
> >=20
> > So, the issue with U-Boot and kernel device trees being out of sync is
> > that we then can't support the model of "just pass the current DT to the
> > OS". This in general is good to support because it means that even if a
> > given platform isn't formally SystemReady IR certified it's still likely
> > to be functional.
>=20
> This is certainly not something that we ever strived for with Tegra. It
> was always very clear that we needed to get the DTB from the same source
> as the kernel. The vast majority of what's in the DTB is completely
> useless for U-Boot because it simply doesn't support (and doesn't have
> to support) a lot of the hardware that Linux supports.
>=20
> One concern that I have with this policy is that for certain devices we
> may just not be able to do this. Especially with some early OEM devices
> I recall that they had limited storage for the bootloader. Since the DTB
> needs to be embedded, a full-blown DTB from Linux might inflate the size
> significantly. Comparing to what we have today, the Linux DTB can be
> anywhere from 2 to 3 times as big as the U-Boot DTB.

As I noted in a different thread, I will be unhappy if U-Boot is unable
to still be useful on a platform (tbs2910) that has just shy of 384kB of
space for the binary, so still being somewhat small is a feature I want
us to keep.

That said, most of the common community distributions want to be able to
not ship device trees at least some day. At least one today requires
being passed the right / valid device tree. And U-Boot will pass along
the tree we're using if no override is presented. So yes, passing along
the full real device tree to U-Boot and then being able to pass it
further along is generally desired. If you can't you can't. If you want
to take on the headache of keeping them separate, well, OK. But as this
series shows we also make use of more of the tree than we used to as
well, so just doing the drop-in and occasional resync is good.

--=20
Tom

--R0mU4Z07x/GEtu2Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV4VR8ACgkQFHw5/5Y0
tyz4kAv7BDFZMhXyzgSM1xADAQK4pXWxkPpiSq8OSHqgi2pi4pj0Fn4cSopUz5xT
qbzRfRVC0GGHLDHTTCG0ZeaxNMEdG2EQhMHDwyY68dZxPcHt82AFAGs7cLRWQh1r
3S4FE7py70cZV6JMQuOmzaoiD+Rf4Zz9Bxq1DKi6eLrtr4vAZtJwZf9dVTQfAQ2H
393rcAd4tsBvB3D0p9c1XZtua2rk9DPVvPk1Jpv9Evq6/LGlMxQ60srRmuC6zjbn
0YAKjUfZleCZPXCmNNJn0dAsjpMJd/UKXkH/Gzp1bFL/qaJmN3Zo2HewRG8aVmRe
ZRRGa4OjiIMViIfo61vIGEUBFS5uzR7Gac+h6u/5x+4/TELTU0XLgHc1URaa4SQI
mh1IeNXFuo0h8tbRAxNWSOFeLl6Z003NceQ/tsShTNyo5iqMGwMA5IgVKiR34X9b
LfsFhVHsVDDBwgfQNgQscPV8JXmnQFR7AhmjKl6a9xyI7LrJ+gCfzq4eoZc9PhEy
evbD7gES
=DPsF
-----END PGP SIGNATURE-----

--R0mU4Z07x/GEtu2Q--
