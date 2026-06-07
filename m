Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A76CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:45:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A533D8466E;
	Mon,  8 Jun 2026 09:45:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=samcday.com header.i=@samcday.com header.b="HM/yfmJv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 205EA83EF9; Sun,  7 Jun 2026 23:52:56 +0200 (CEST)
Received: from mail-106100.protonmail.ch (mail-106100.protonmail.ch
 [79.135.106.100])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B3C683314
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 23:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=samcday.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=me@samcday.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samcday.com;
 s=protonmail3; t=1780869169; x=1781128369;
 bh=Cd1Kp/v4b3zKIA1jIhMA+r5IBmJeQvwnd3JkRzG3cQI=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=HM/yfmJvDv7SCYsmIMSUBpqthI0nRb9ecH4YDvUn3lY6GpES6q052yTXDyVOKKCAz
 hBHZqTJbx/1wCawy0Tsh5pqH5y/eY0E9Sg+gJvRwm04MxtxeoZKlbtckQ1YQKWC7xJ
 lCl3W5Hyql/5KVwKZP30VgYtVETYpwdMkbKQHecvQQuuLTEolfmTvueUOzpfiDwjvU
 xC0Ze+/0v0NIxWGOIY7ExeEAQKT3XPvSL+J2ja+ZTBr1xiBizYSSPkgOW18SodrSp5
 gzZMr0zJNH6GqoOTkR/ixu5eG7vb/Ede2ZiCz/a0gNRxuPzduwfPCXZO0J2ZPmiTWD
 yOOJfNfS0FGYA==
Date: Sun, 07 Jun 2026 21:52:36 +0000
To: Casey Connolly <casey.connolly@linaro.org>
From: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, Denis Mukhin <dmukhin@ford.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Javier Tia <floss@jetm.me>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Aswin Murugan
 <aswin.murugan@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
Message-ID: <nS2QU7ZPcYber7ZULg_eRSmQ27Grrv-6k9M0IA72f6l4mshkWUos1SiHqOlFVzu2EyaI6fbrE5oF-yQzYps5zaUU94Pr2FN65hlWlc-LrHk=@samcday.com>
In-Reply-To: <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
 <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
 <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
 <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
Feedback-ID: 25366008:user:proton
X-Pm-Message-ID: 84ecb395f3e4c61b10d5ae8ef0aba810ab5b827a
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 08 Jun 2026 09:45:10 +0200
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

Hello,

On Monday, 8 June 2026 at 12:48 AM, Casey Connolly <casey.connolly@linaro.o=
rg> wrote:

> Hi Sam,
>=20
> On 6/7/26 01:05, Sam Day wrote:
> > Salutations Casey,
> >
> > On Saturday, 6 June 2026 at 10:03 PM, Casey Connolly <casey.connolly@li=
naro.org> wrote:
> >
> >> Hi Sam,
> >>
> >> On 6/6/26 02:52, Sam Day via B4 Relay wrote:
> >>> U-Boot is seeing increasing adoption on pocket computers, many of whi=
ch
> >>> (sadly) have fused bootloader chains. Many of these bootloaders have =
a
> >>> very rigid definition of what a "valid" downstream payload looks like=
.
> >>> Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
> >>> it's something decidedly more grotesque.
> >>>
> >>> To date, this last-mile packaging step has been trapped in downstream=
 CI
> >>> pipelines, blogposts, documentation, etc. This patch series aims to
> >>> gather up all that esoterica and institutional knowledge and codify i=
t
> >>> in U-Boot's build system, using binman.
> >>
> >> Awesome!!! :D
> >>
> >> So happy to see this being worked on, it's a huge benefit to have this
> >> here in the build system.
> >>
> >> That said, I think we need a bit of discussion around binman, I
> >> previously worked on using it for teaching the build system to emit .m=
bn
> >> files (see [1]), in the end getting binman to co-operate was a bunch o=
f
> >> really annoying work and I wound up with a sub-par result.
> >
> > Yes, I saw that series. I tried to engage you on Matrix about it a few =
days ago
> > to get a sense for why you felt that binman was unsalvageable. I should=
 have
> > engaged you properly here on the list, that's my bad.
> >
> >>
> >> The new approach which made a whole lot more sense is to use a vendor
> >> Makefile fragment to add a custom build target, skip dealing with binm=
an
> >> and just have the necessary info in Python (since adding a table entry
> >> to a Python script is really no different to adding a binman DTB node)=
.
> >> That's in [2].
> >
> > I would prefer to use binman. It's already well documented. It's alread=
y in
> > use by countless other boards in U-Boot. I prefer maintaining DTSI's fo=
r the
> > configuration DSL than some Python dicts. Also, at some point once enou=
gh
> > devices have their native Android boot artifact described, there will b=
e
> > clear patterns that can be neatly tucked away into shared DTSI fragment=
s.
>=20
>  From my side, binman is a no-go for a bunch of reasons, polluting the
> device dtb being a big one, the ability to debug and maintain it is also
> not something i feel particularly confident about. Hence having a
> standalone tool would be the appropriate way to go for this, I really
> want to avoid having to learn this bespoke overly complex build tooling
> when it's selling points aren't things that have much value for Qualcomm.
>=20
> >
> >>
> >> I'm really not in favour of adding a binman node to the DTB that U-Boo=
t
> >> uses, and I think it's kinda dumb that this is the only sensible way t=
o
> >> configure binman today...
> >
> > I see nothing wrong with that. Can you expand on your concerns a little=
 more?
>=20
> It really just goes against the goal of using upstream DT. Previously I
> managed to get binman to parse its config from a separate DTB but that
> was hellish to integrate the tooling for.
>=20
> Having this random node at runtime for completely unnecessary arbitrary
> reasons feels just wrong to me.
>=20
> >
> >>
> >> The way that mkmbn works is it just has all the device-specific config
> >> in a dictionary where the key is the compatible string, it finds the D=
TB
> >> in the U-Boot image and gets the appropriate mbn config from there.
> >>
> >> I see you've clearly put a lot of effort into this, and I hate to ask
> >> you to do a lot more, but I'd really like to avoid using binman, would
> >> you be willing to rework this to put the config in Python and just hav=
e
> >> a custom make target like in the mkmbn patches? You can probably base =
it
> >> on top.
> >
> > I'm definitely not interested in doing that. I would, however, be very =
willing
> > to address any specific concerns you have with binman.
>=20
> That's a shame to hear>
> > At any rate, if you want to NAK any binman usage in the qualcomm side, =
that's
> > fair enough. Please let me know if you see absolutely no path forward, =
and I'll
> > split the series to just focus on the binman etype impls and their usag=
e on
> > the Exynos side. That would be a bummer, but I'm intending to maintain =
a
> > long-lived close-to-mainline downstream anyway, so I would continue wid=
ening
> > the support there and hope that your opinion on binman changes in futur=
e :D
>=20
> I don't feel comfortable depending on binman for Qualcomm, so we'll
> leave it there.

Acknowledged. I'll resend this series scoped to Exynos only and hope that
you're no longer a gatekeeper for Qualcomm in future.

-Sam

>=20
> Kind regards,
> // Casey>
> >>
> >> This way it avoids the need to add stuff to the dtb, you can just pars=
e
> >> `u-boot.dtb` to determine the device and pick the right config.
> >>
> >> [1]:
> >> https://lore.kernel.org/u-boot/20250722-b4-qcom-tooling-improvements-v=
5-0-df143f1247fc@linaro.org/
> >>
> >> [2]:
> >> https://lore.kernel.org/u-boot/20260511-b4-qcom-tooling-improvements-v=
7-0-0c06346e79a9@linaro.org/
> >
> > I wonder if maybe the ELF wrangling in particular was cursed? I had abs=
olutely
> > no issues using binman and getting it to produce native binaries for a
> > half-dozen disparate devices.
> >
> > Cheers,
> > -Sam
> >>
> >>>
> >>> Put differently: an overwhelming majority of these pocket computer
> >>> devices have a "canonical" payload format that U-Boot currently has n=
o
> >>> support for. Let's fix that.
> >>>
> >>> The first patches in this series introduce an `android_boot` etype. T=
o
> >>> begin with, this is a "typical" abootimg, as defined by canonical AOS=
P
> >>> sources and reference `fastboot`/`mkbootimg` implementation. There's
> >>> plenty of devices out there with a sane(-ish, nothing in Android-land=
 is
> >>> ever truly sane) bootloader that will happily chain a U-Boot rolled i=
nto
> >>> the kernel section of an abootimg.
> >>>
> >>> With that out of the way, the cursed bootloaders are next to be
> >>> supported. Binman etypes for Qualcomm's "QCDT" and Samsung's "DTBH"
> >>> formats are implemented. These are non-standard vendor-specific
> >>> devicetree containers, which the previous bootloader uses to pick a F=
DT
> >>> to boot the downstream with.
> >>>
> >>> In both cases, these vendor-specific formats are tacked on to the end=
 of
> >>> a v0 abootimg, with the header_version being hijacked to encode the
> >>> length of this following payload. Thus, the android_boot etype is
> >>> retrofitted to allow these shenanigans.
> >>>
> >>> Binman configs that produce flashable boot artifacts are introduced f=
or
> >>> the following devices:
> >>>
> >>>    * google-sargo (vanilla v2)
> >>>    * oneplus-fajita (vanilla v2)
> >>>    * samsung-a5u-eur (QCDT v0)
> >>>    * samsung-gt510 (QCDT v0)
> >>>    * samsung-j7xelte (DTBH v0)
> >>>
> >>> I also successfully tested a vanilla v0 on my samsung-expressltexx, i=
n
> >>> conjunction with the qcom-armv7 series already on the list. However,
> >>> since that work is still in-flight and the expressltexx DTS is
> >>> downstream, I opted not to include it here.
> >>>
> >>> Signed-off-by: Sam Day <me@samcday.com>
> >>> ---
> >>> Sam Day (13):
> >>>         binman: Android boot image support
> >>>         .gitignore: ignore binman-generated blobs
> >>>         arch: arm: qcom: google-sargo binman config
> >>>         qcom: arch: arm: qcom: sdm845-fajita binman configs
> >>>         mach-snapdragon: enable BINMAN
> >>>         binman: android_boot: vendor-dt support
> >>>         binman: Add QCDT support
> >>>         binman: android_boot: SEANDROIDENFORCE support
> >>>         arch: arm: qcom: samsung-a5u-eur binman config
> >>>         arch: arm: qcom: samsung-gt510 binman config
> >>>         binman: Add DTBH support
> >>>         arch: arm: exynos: add j7xelte binman config
> >>>         configs: exynos-mobile: pull in BINMAN
> >>>
> >>>    .gitignore                                         |   1 +
> >>>    arch/arm/Kconfig                                   |   1 +
> >>>    arch/arm/dts/exynos-mobile.dtsi                    |   5 +
> >>>    arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi        |  24 ++
> >>>    arch/arm/dts/msm8916-samsung-a5u-eur-u-boot.dtsi   |  39 ++
> >>>    arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi     |  39 ++
> >>>    arch/arm/dts/qcom.dtsi                             |   5 +
> >>>    arch/arm/dts/sdm670-google-sargo-u-boot.dtsi       |  27 ++
> >>>    arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi     |  25 ++
> >>>    arch/arm/mach-exynos/Kconfig                       |   1 +
> >>>    configs/exynos-mobile_defconfig                    |   1 +
> >>>    configs/qcom_defconfig                             |   1 +
> >>>    tools/binman/etype/android_boot.py                 | 408 +++++++++=
++++++++++++
> >>>    tools/binman/etype/dtbh.py                         | 173 +++++++++
> >>>    tools/binman/etype/qcdt.py                         | 160 ++++++++
> >>>    tools/binman/ftest.py                              | 127 +++++++
> >>>    .../test/vendor/android_boot_seandroidenforce.dts  |  22 ++
> >>>    tools/binman/test/vendor/android_boot_v0.dts       |  29 ++
> >>>    tools/binman/test/vendor/android_boot_v2.dts       |  46 +++
> >>>    .../binman/test/vendor/android_boot_vendor_dt.dts  |  27 ++
> >>>    tools/binman/test/vendor/dtbh.dts                  |  29 ++
> >>>    tools/binman/test/vendor/dtbh_bad_model_info.dts   |  19 +
> >>>    tools/binman/test/vendor/qcdt.dts                  |  20 +
> >>>    tools/binman/test/vendor/qcdt_bad_msm_id.dts       |  17 +
> >>>    24 files changed, 1246 insertions(+)
> >>> ---
> >>> base-commit: a4c8728f225b0d7d591fb9199ce7efb72f48290e
> >>> change-id: 20260604-android-binman-ad7a43f4e99d
> >>>
> >>> Best regards,
> >>
> >>
>=20
> 
