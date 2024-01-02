Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16913C46CD2
	for <u-boot@archiver.kernel.org>; Tue,  2 Jan 2024 14:55:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4647D8773E;
	Tue,  2 Jan 2024 15:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mDW9GXlK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB11C87823; Tue,  2 Jan 2024 15:55:43 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1439A8770A
 for <u-boot@lists.denx.de>; Tue,  2 Jan 2024 15:55:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e7bb1e0db8so73459367b3.0
 for <u-boot@lists.denx.de>; Tue, 02 Jan 2024 06:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1704207340; x=1704812140; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XAXUPRORv1aJjdIzgXH4sIf26IDNWfeuFh2ML123mE4=;
 b=mDW9GXlK0wIoB/1FmNeB41M/iq521FXRH1zzsQt2JePvnzHHKM11+/XQ/fMcvs3VgB
 2/bzLgBDdZQsEr7T5P0VSCR8loOLT34df1j6Z7ZMafi5OFPWYjpJgoD5SIk+8XGX+vib
 KOY7xc4U2NxDl/L1Ge6SCDj1dny0lQyq1mHSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704207340; x=1704812140;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAXUPRORv1aJjdIzgXH4sIf26IDNWfeuFh2ML123mE4=;
 b=gCxW77FNTirNWF152IOKQ6mcMyN2FBQ4HFEjKzzHYL7XpdmRaUrW1rXL9jvO68R9lB
 c6Rpdpq8Rq9urRD347OJJ0e6Y1GI0b2JHL0AdSBskmVA3pTSpDOYSk4hINeB8aafu2Hf
 OB0gn6Q3E8caiPMzlPI0nQ3iocPxih8lIYGapFGCcl657dh+f7tZRIT3o5RY7cqF+nwD
 ER9xcuPN58xYA2HVFpkaOMvI+uuBaTfPBO0WlJwjPhnjEoXq51JEopkwUlqlYOYjYorc
 aLsWNQ3AgUMKxXpJ8JTOVdNwQu5OIC9bA62sSetUAiZjP6IAVcj5LARQC3xGNwjL9rDj
 y4BA==
X-Gm-Message-State: AOJu0Ywlo0CG/zVuMxXHfxREaclz/WPfHuMJ3OmrL7Te2ecrabs13bmg
 Wa7ZFYlLiX8dScd70NYizfyCtEMeHTQj1Q==
X-Google-Smtp-Source: AGHT+IGBxAempYXYtWhjkeHJVs1aPRVmEj9mur8QM996+m0eQtRE5p4oBGJ7U7UcH/T0YTXA64gIPg==
X-Received: by 2002:a05:690c:3387:b0:5ed:9194:5b8f with SMTP id
 fl7-20020a05690c338700b005ed91945b8fmr9319379ywb.20.1704207339639; 
 Tue, 02 Jan 2024 06:55:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 s6-20020a0de906000000b00598d67585d7sm12222675ywe.117.2024.01.02.06.55.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jan 2024 06:55:39 -0800 (PST)
Date: Tue, 2 Jan 2024 09:55:36 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Sumit Garg <sumit.garg@linaro.org>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Andreas =?iso-8859-1?Q?Bie=DFmann?= <andreas@biessmann.org>,
 Michal Simek <michal.simek@amd.com>,
 Michal Simek <monstr@monstr.eu>, Minkyu Kang <mk7.kang@samsung.com>,
 Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH 0/9] dts: Move to SoC-specific build rules
Message-ID: <20240102145536.GK2652760@bill-the-cat>
References: <CAFLszThBrAVSH2jYxhxFSETqr4za+BqjZBBjLaDokc1ZdrXXRw@mail.gmail.com>
 <20231228142311.GD2652760@bill-the-cat>
 <CAFLszTghB1ZObpxUe+afAp2zzQOfn2M9198ofsgnyW9cseG2Ew@mail.gmail.com>
 <20231228154019.GH2652760@bill-the-cat>
 <CAFLszTgZfAHATieERE1x8hhoFHpYDK4Vq4=VVmQapKEn63diyA@mail.gmail.com>
 <20231228204425.GQ2652760@bill-the-cat>
 <CALeDE9MfEd=xjwekR+oVPuWNR7TBPCMU6mc+Z7ig7tc1nhKu_Q@mail.gmail.com>
 <CAFLszTj0MQGUBcNqVTLZuOL=1YBD2pqL2+P8oLKqc5PnLq3GdA@mail.gmail.com>
 <20231231140127.GA2652760@bill-the-cat>
 <CAFLszTj0vdkZ+ch5-crygw7i3Mj8DO5=4naOWAwYMFNqGe0WWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vZnb6Db6BNHKOXmt"
Content-Disposition: inline
In-Reply-To: <CAFLszTj0vdkZ+ch5-crygw7i3Mj8DO5=4naOWAwYMFNqGe0WWA@mail.gmail.com>
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


--vZnb6Db6BNHKOXmt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 02, 2024 at 07:06:36AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, Dec 31, 2023 at 7:01=E2=80=AFAM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Sun, Dec 31, 2023 at 05:45:00AM -0700, Simon Glass wrote:
> > > -Scott as it is bouncing
> > >
> > > Hi,
> > >
> > > On Fri, Dec 29, 2023 at 9:46=E2=80=AFAM Peter Robinson <pbrobinson@gm=
ail.com> wrote:
> > > >
> > > > On Fri, Dec 29, 2023 at 12:23=E2=80=AFAM Tom Rini <trini@konsulko.c=
om> wrote:
> > > > >
> > > > > On Thu, Dec 28, 2023 at 07:48:08PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Thu, Dec 28, 2023 at 3:40=E2=80=AFPM Tom Rini <trini@konsulk=
o.com> wrote:
> > > > > > >
> > > > > > > On Thu, Dec 28, 2023 at 03:09:40PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Thu, Dec 28, 2023 at 2:23=E2=80=AFPM Tom Rini <trini@kon=
sulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Dec 28, 2023 at 01:37:07PM +0000, Simon Glass wro=
te:
> > > > > > > > > > Hi Tom,
> > > > > > > > > >
> > > > > > > > > > On Wed, Dec 27, 2023 at 1:21=E2=80=AFPM Tom Rini <trini=
@konsulko.com> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Wed, Dec 27, 2023 at 08:23:56AM +0000, Simon Glass=
 wrote:
> > > > > > > > > > >
> > > > > > > > > > > > U-Boot builds devicetree binaries from its source t=
ree. As part of the
> > > > > > > > > > > > Kconfig conversion, the Makefiles were updated to a=
lign with how this
> > > > > > > > > > > > is done in Linux: a single target for each SoC is u=
sed to build all the
> > > > > > > > > > > > .dtb files for that SoC.
> > > > > > > > > > > >
> > > > > > > > > > > > Since then, the Makefiles have devolved in some cas=
es, resulting in
> > > > > > > > > > > > lots of target-specific build rules. Also Linux has=
 moved to using
> > > > > > > > > > > > subdirectories for each vendor.
> > > > > > > > > > > >
> > > > > > > > > > > > Recent work aims to allow U-Boot to directly use de=
vicetree files from
> > > > > > > > > > > > Linux. This would be easier if the directory struct=
ure were the same.
> > > > > > > > > > > > Another recent discussion involved dropping the bui=
ld rules altogether.
> > > > > > > > > > > >
> > > > > > > > > > > > This series makes a start at cleaning up some of th=
e build rules, to
> > > > > > > > > > > > reduce the amount of code and make it easier to add=
 new boards for the
> > > > > > > > > > > > same SoC.
> > > > > > > > > > > >
> > > > > > > > > > > > One issue is that the ARCH_xxx Kconfig options betw=
een U-Boot and Linux
> > > > > > > > > > > > are not always the same. Given the large number of =
SoCs and boards
> > > > > > > > > > > > supported by U-Boot, it would be useful to align th=
ese where possible.
> > > > > > > > > > >
> > > > > > > > > > > I don't know why we should start with this now, and f=
urther not being on
> > > > > > > > > > > top of Sumit's series to remove our duplicate dts fil=
es. And that's
> > > > > > > > > > > where we can have the conversation about for which ca=
ses it even makes
> > > > > > > > > > > sense to build all of the dts files for a given SoC.
> > > > > > > > > >
> > > > > > > > > > This is a completely different series - there are no co=
nflicts with
> > > > > > > > > > Sumit's series so it can be applied before or after it.
> > > > > > > > > >
> > > > > > > > > > My goal here is to clean up our build rules, rather tha=
n just throwing
> > > > > > > > > > them all away, for reasons we have discussed previously=
=2E I filed [1]
> > > > > > > > > > to track that.
> > > > > > > > >
> > > > > > > > > Yes, I'm saying we shouldn't be doing anything this serie=
s does until
> > > > > > > > > after Sumit's series has landed. Along with the fact that=
 I don't like
> > > > > > > > > what's going on in this series.
> > > > > > > >
> > > > > > > > This seems to again be the disagreement over whether a sing=
le DT
> > > > > > > > should be build for each board, or all the DTs for an SoC?
> > > > > > >
> > > > > > > It's about the disagreement on what we should be building, an=
d what that
> > > > > > > infrastructure looks like. I do not like adding extra rules f=
or
> > > > > > > "clarity" because they don't make things clearer, they lead t=
o the
> > > > > > > unclear mess we have today getting worse. Most instructions a=
re _not_
> > > > > > > "now take this dtb and this binary and .." but just "take thi=
s binary",
> > > > > > > because we already have the rules and logic to ensure we buil=
d the
> > > > > > > required dtbs. I also don't like the parts of this series tha=
t amount
> > > > > > > to deck shuffling when we should just be taking the chairs aw=
ay. There's
> > > > > > > just not nor will there be a case for omap3/4/5 platforms of =
"change the
> > > > > > > dtb", so building more is pointless. For other SoCs, there ma=
y be some
> > > > > > > cases of "this could have been just a DT change", like
> > > > > > > rock5b-rk3588_defconfig / rock5a-rk3588s_defconfig could shar=
e a board
> > > > > > > dir, but the configs are different and the dts are different,=
 so I don't
> > > > > > > know that you could really just swap the dtbs.
> > > > > >
> > > > > > It is true that we have a different defconfig for each board, b=
ut IMO
> > > > > > that is not good. It is an artifact of the way the build system=
 works.
> > > > > > IMO Kconfig should be used to define sensible defaults so that =
the
> > > > > > defconfigs are nearly empty. Perhaps config fragments can be pa=
rt of
> > > > > > the mix, if we can agree on [1].
> > > > > >
> > > > > > But if we let this genie out of the bottle, it will be impossib=
le to
> > > > > > put back in. The devicetree should control the hardware in U-Bo=
ot and
> > > > > > it should be possible to use the same U-Boot proper on all boar=
ds
> > > > > > which use the same SoC.
> > > > >
> > > > > We've never been past the point where a few examples of closely r=
elated
> > > > > boards can re-use the same U-Boot build and just change the devic=
e tree.
> > > > >
> > > > > It's going to be very SoC specific if we can ever do things like =
that,
> > > > > and it will also likely in turn become a question of where did the
> > > > > tricky bits that U-Boot used to do get shoved instead. You're not=
 going
> > > > > to combine board/beagle/beagle/beagle.c and board/ti/omap3evm/evm=
=2Ec (and
> > > > > ignoring all of the other omap3 boards) and get one binary that w=
orks on
> > > > > both, and just uses DT. Let alone that no one wants to do that wo=
rk.
> > > > >
> > > > > You've mentioned Rockchip before as maybe a better example, but
> > > > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D383579&=
state=3D* was
> > > > > leading me to think that no, there's too much "this is what THIS
> > > > > hardware does" that means that no, there's going to be hardware
> > > > > variation that one must just handle in C. Or get more and new bin=
dings
> > > > > accepted upstream to try and make that be data driven, and also p=
ossibly
> > > > > have to deal with "that's policy, not hardware" type arguments an=
d so
> > > > > forth.
> > >
> > > Oh wow yes that is crazy! But you can always check the compatible
> > > string if really necessary. It would be nice to use a sysinfo driver
> > > for this sort of thing. I should just be a full-time code reviewer...
> > >
> > > >
> > > > Related I've seen issues with nearly identical rockchips devices th=
at
> > > > use different memory chips that as a result need different U-Boot
> > > > builds because the early boot part needs to initialise a completely
> > > > different set of memory and the two different sets of rules aren't
> > > > detectable at run-time nor are they even small enough to fit into
> > > > smem.
> > >
> > > Some of the differences are real/important, like memory settings, some
> > > are not. For boards with enough SRAM that SPL can use DM/DT, we can
> > > deal with these.
> > >
> > > But even if SPL does need to be custom, that is better than having a
> > > full, separate U-Boot for every single board.
> >
> > I'm not sure that's a use case anyone else has or wants, and I disagree
> > that building a unique SPL and then more generic U-Boot is a win, in
> > practical and effort terms.
>=20
> Think about firmware update where you could have an update that
> supports all rk3399 boards, rather than 110 separate (and duplicate)
> firmware updates.

I don't know who wants that actually is the problem I keep trying to
bring up. In other words, you're saying that the differences between
rock-pi-4c-rk3399_defconfig and khadas-edge-v-rk3399_defconfig are
unintentional and it's just due to different device trees and I say
they're intentional and the desire is not for a "kitchen sink" type
rk3399 primary U-Boot build. My evidence for this goes back to the SoCs
where we do have both "kitchen sink" and then board specific builds.
This would be things like how there's the am65x_evm configs, which
support all of the TI reference platforms (and others which follow the
EEPROM spec TI uses) and then also iot2050_defconfig, which also uses
the am65x SoC, but does not (would not) support the TI EEPROM layout and
instead does what it needs to do for their custom hardware revisions and
support all of those, instead.

What I think you keep wanting to aim for is fine and good and something
platforms can opt in to, and we have some doing it today. But it's still
at the end of the day a choice for the designers.

You say "110 separate (and duplicate)" and I disagree with the "(and
duplicate)" part of that. Could some platforms be condensed? Yes,
likely. But figuring out how to do that starts with figuring out why
they're separate to start with.

> > The only win I see there is it would be part
> > of what I've said before about how I do not want the "XPL" series you've
> > talked about before, but instead think Yamada-san was right in hindsight
> > and in short we should have "fooboard_defconfig",
> > "fooboard_spl_defconfig" and "fooboard_tpl_defconfig" and you make each
> > config and build each config by itself. In that context, yes, you could
> > have barvend-fooboard_rev1_spl_defconfig,
> > barvend-fooboard_rev2_spl_defconfig and barvend-fooboard_defconfig to
> > get a more generic U-Boot build.  But nothing so much like an OS kernel
> > because we care about binary size and rarely does the OS vendor (but
> > some production cases in turn do), so outside of SoC-vendor where
> > showing off features is more important than size, most of the time, will
> > you see an actual use for SoC-generic U-Boot build.
>=20
> We'll see. The size cost for making things generic across an SoC is
> likely very small, particularly if the settings are in the DT where
> they belong. But I do accept we are not seeing the pressure yet.

Yes, I think we're well past the point where it's a case of needing to
see the implementation rather than talking about it over and over.

> For XPL, there are pros and cons, but I thought we talked about that
> at the time and agreed that the need for Kconfig dependencies between
> phases makes having separate defconfigs too painful?

I recall there being a large number of issues.

--=20
Tom

--vZnb6Db6BNHKOXmt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWUI+UACgkQFHw5/5Y0
tyx+AQv/aU/J4ho0i+aEhWa4lMntZKPx5h/B2uDI90gthnhxMhe7TQAUMn3DzAql
EOlFBWlBefdOVFVXgzKAaLxVaG5hJOzx2UmWu6hmpttL9E2CWfChbjt05ObVoqMZ
RIf0ZEbgg0pKxEggtF7qiduso2ygDj5N8JMYsWEeRkeCGGOvaeGRKng30h6fBsAh
sGvpF+U7QGerY1AKHWBeiKo8CMEJ/NnRVcmjC7Gchj06QYz47hqufyq1SXJdm3z1
02rPsnVOnpQhvO/JTlxqVwFYcCB7VuQgLtqUdNzrslz7xObfoFYtwfuJPUmbtbAZ
vA7OwFHEFxuF+a6CEv2q3b/gOhlyjAF4bHQfP9Clb0Q3pXeATSTpAurMviWciq1h
RlGJKmS118E3Ftb4CyOC/X27ZkvtXlMCPxHsQITL2cNOI1Xi+bKZ9hp3fKDOJQSp
0NlDFbNaOMtpybZBb2AYx33pnasM31S2YSocEpz33SoSB297MLwyaX/8L1XbaTcC
5WACjBUr
=X5Xo
-----END PGP SIGNATURE-----

--vZnb6Db6BNHKOXmt--
