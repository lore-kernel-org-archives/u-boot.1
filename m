Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D2CCD8CA8
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 21:58:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56DDB848D7;
	Tue,  9 Jun 2026 23:58:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="AjPVMQcB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BE7848DF; Tue,  9 Jun 2026 23:58:32 +0200 (CEST)
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E07A848A2
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 23:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1781042308; x=1781301508;
 bh=ZjRX6kwUbk3QE2ny5b4NiDkov/ZmvacZAk4INo+WDkE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=AjPVMQcBQ/MiATywbc7IdGft0csZC1wCiVtUfKaIPk2ssED7JneGz8cnXohRc/foc
 X4LI8V9aE4EASs1ZpHzUU23O9rvhohRQ06AM75dY0cYe4g63NBEwvVOXXMbMCjH4fc
 iVLaILCFdNcLAwgtMCUwd35kU6J3+OocWOxeU0QUyLbIh6tRFkkrH9HoKUKvR+CxrU
 3TVSGFHPMkbSzf4/ZjPpqfk7ZkqDxeaLamUWp9ypxP9cOinWSHCNE+YzybzXGNNOPi
 qs1Z5tV9GXSwrRf/Ibv3v1C11BaubNhkTHGeML1cXqbUlPUzOpVZ5Q69lahHhah2hE
 EmO7QzRTl18DQ==
Date: Tue, 09 Jun 2026 21:58:19 +0000
To: Kaustabh Chakraborty <kauschluss@disroot.org>
From: Sam Day <me@samcday.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Javier Tia <floss@jetm.me>,
 Minkyu Kang <mk7.kang@samsung.com>, Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH v2 7/8] arch: arm: exynos: add j7xelte binman config
Message-ID: <kfG5rnZXKckS671B7eTyEMJNfKGMrN93bgx5vJoIuam7dGtG2Lc74Q7z6UCBSkTU3EH8q-GOmNX5Kpsfgp1wxHdi3Z0a-a6duNGtFdZn_hI=@samcday.com>
In-Reply-To: <DJ4QLUOW3HOV.946WQKV3H4V9@disroot.org>
References: <20260608-android-binman-v2-0-b8203682507f@samcday.com>
 <20260608-android-binman-v2-7-b8203682507f@samcday.com>
 <CAFLszTjXckdYQ4kQmmH9yFsh0GQtea2TGkRfsitNn55RkPFF5A@mail.gmail.com>
 <DJ4QLUOW3HOV.946WQKV3H4V9@disroot.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 34aef389d72c921b5263ba19ff5495230a261bae
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Hey Kaustabh, Simon,

On Wednesday, 10 June 2026 at 4:41 AM, Kaustabh Chakraborty <kauschluss@dis=
root.org> wrote:

> Allow me to chime in and provide some context for discussions below:
>=20
> On 2026-06-08 07:27 -06:00, Simon Glass wrote:
> > Hi Sam,
> >
> > On 2026-06-07T23:37:09, Sam Day via B4 Relay
> > <devnull+me.samcday.com@kernel.org> wrote:
> >> arch: arm: exynos: add j7xelte binman config
> >>
> >> Note that, as of this commit, j7xelte does not yet exist in U-Boot's
> >> upstream DTS tree. It was accepted into next so it should appear here
> >> eventually.
> >>
> >> S-BOOT expects a DTBH with hw-rev =3D=3D 6.
> >>
> >> Link: https://lore.kernel.org/all/177209522223.26390.62198935361784410=
80.b4-ty@kernel.org/
> >> Signed-off-by: Sam Day <me@samcday.com>
> >>
> >> arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi | 24 +++++++++++++++++++++=
+++
> >>  1 file chang
> >> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dt=
s/exynos7870-j7xelte-u-boot.dtsi
> >> @@ -0,0 +1,24 @@
> >> +     binman {
> >> +             filename =3D 'u-boot-samsung-j7xelte.img';
> >> +             android-boot {
> >> +                     kernel {
> >> +                             u-boot-nodtb {};
> >> +                     };
> >
> > No 'base' is set, so android_boot falls back to its default of
> > 0x10000000, putting the kernel_addr field in the abootimg header at
> > 0x10008000 - nowhere near Exynos7870 DRAM at 0x40000000. Does S-BOOT
> > on j7xelte ignore the load addresses in the header (so the defaults
> > are harmless), or do you need to set base =3D <0x40000000> explicitly? =
A
> > short note in the commit message on what S-BOOT does with those fields
> > would help.
>=20
> In my devices (on7xelte, a2corelte, j6lte), S-BOOT does ignore the load
> address. This is also mentioned in the install guide [1], as it says:
>=20
>   "Offsets are not provided to mkbootimg as S-BOOT ignores them."
>=20

Right. I forgot to add a comment to the j7xelte carrying along this importa=
nt
quirk. That will be addressed in v3.

> >> diff --git a/arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi b/arch/arm/dt=
s/exynos7870-j7xelte-u-boot.dtsi
> >> @@ -0,0 +1,24 @@
> >> +                     vendor-dt {
> >> +                             dtbh {
> >> +                                     dtb-0 {
> >> +                                             u-boot-dtb { };
> >> +                                     };
> >> +                             };
> >> +                     };
> >
> > Does this indenting use tabs? It should.
> >
> > 'S-BOOT expects a DTBH with hw-rev =3D=3D 6' is terse - worth a sentenc=
e
> > explaining that this pins both hw_rev and hw_rev_end to 6, contrasting
> > with the wider 0..255 range used by the j6lte overlay, so it's clear
> > why that DTSI's approach wasn't reused.
>=20
> I also question this approach. In my devices S-BOOT happily accepts dtbs
> having revisions lower than that of the hardware, but of course, doesn't
> accept higher ones. Setting hw-rev to 6 means that U-Boot won't work for
> S-BOOT versions 5 or below.
>=20
> If this is indeed a quirk of S-BOOT in this device, then do we need to
> make revision variants for j7xelte, or pass the revision to binman
> somehow?

So, all I was trying to accomplish here is increased specificity. That is,
since we're formalizing this process of producing canonical artifacts for
un(der-)documented platforms, I felt that nailing down the most precise
magic values for a device is preferable to cargo culting around generalized
spooky numbers :D

Since it's contentious, I'll make sure that v3 keeps the defaults casting
the net as maximally wide as possible and avoid trying to pin down the j7xe=
lte.

Thanks all,
-Sam

>=20
> > Regards,
> > Simon
>=20
> [1] https://docs.u-boot-project.org/en/v2026.04/board/samsung/exynos-mobi=
le/exynos7870.html#preparation.
>=20
> 
