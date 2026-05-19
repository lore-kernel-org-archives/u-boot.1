Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6C8CD4F54
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 22:29:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0CB48483C;
	Wed, 20 May 2026 00:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cLKHNpZB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D60BC84707; Wed, 20 May 2026 00:25:44 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5DB846B4
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 00:25:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-47c6f914617so1981225b6e.1
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 15:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779229541; x=1779834341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=EpSMIqGj5Gce4rpHr2ZOVk1TaARd+CKW3irFR56pFCg=;
 b=cLKHNpZB7eqE/pwIKSgYVD/sEjnZ33w5PtB+bC2PQzGujZ/BUQjfFQTC2VQ6egECM/
 sOz2wZoK3Y4/o36pS7gVp7N9MY526iFUz9IkouXqmvajfESgSFfCd7ZytUCqGdNoZfGf
 Q2E51aPn7g5mIqubQtXG9icsldQ2pqpQ+T8g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779229541; x=1779834341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EpSMIqGj5Gce4rpHr2ZOVk1TaARd+CKW3irFR56pFCg=;
 b=QvOSbTBN1rgSA0h7tn9OMCpU886ORXGEE2Fod6JXB79cBPH3g8sG8Vqzp2Mfv1K6Mr
 C+RWfBBIRgnUqvw3Kyb052GiFbjAJZq+7VeOct8fPxxpSBBUBAe3r4CQwI3P95zc+676
 KlulFKIpiuJlIw0ae0fDyeMldgrEDJZNvOTswiNItbK8+qfwDQighbIbNqZVoflb3seB
 zIiDv9LpJzS87zt5l9/zIpuS2tFM01JU2jQ6v2UkG+x8BiVq2i0N5JwO8scsIfaanmEn
 K7avHbgaYWb9Z68qBUAEjm8y1kNMOvNbt4QdtnAgovBa2k+OdvtVKpc5/KQtWr3ibTQn
 0G+A==
X-Gm-Message-State: AOJu0Yxwo2MVdKHA8EJ+LS1TOKmdV4kN/uyTCIMNsGlMCoeDEBXEF0xZ
 OIe558yHhEsf5qmtpOhXE7/LTfhXj021D01PDSwR3p9aFS0hYrmsS7oOoOm4uVDcxHs=
X-Gm-Gg: Acq92OHqLR9MX4hX/EAPcMpHA9I9tg87js98E07IZl/PQWBBkOj5h8xD7vw1HhojCPH
 bSlG5cq9+rJy2ve27m+sVeahMYlvDWWNOPvBIbhF+GNFC9p4lYt5ATk+mgtrJvDMpQBB0R5vhA5
 2JL80mCdMr1/O6O1h+vjSNKXIJZLi40YHvCxRgFTVnYKlqCYnaVdKpkip+odfpG7lHrl2xK0hRX
 6Ws28w8g/Fr/FDnamU56L+Xo2CRBZjU517xTNgW7aqXfZmTK+XSZeqipOI9OirJSnu0KBc0n79N
 Mj8JkqeljQTZMRVSJMB0qh0oVSnuMks1ocjU+cGuvCGtvAsNpsvj9d5H6DIs23QK9xxvp6oznE9
 7zqnpaWXFeCA2SN3dhTXI5WNFgrMLz52Ci8+fmkpYrPILGd9f3fUyAh9cU1UW1zmb4RAc9kSFRF
 IQv+KUT/CHSsblhPGPW1us0dhQd1jaN0XaTPNHupMTCG9dg/vITHkBkMXTBm6XYbwiT9vT0C528
 pt9Nfb4/YfX0jGDSGI+l5NBhIuTN/iHLurY+Tsw5bvpzODeVCg=
X-Received: by 2002:a05:6808:1922:b0:44d:bcb0:1409 with SMTP id
 5614622812f47-482e577b604mr15035032b6e.22.1779229540864; 
 Tue, 19 May 2026 15:25:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94fce014sm8632511fac.7.2026.05.19.15.25.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 15:25:40 -0700 (PDT)
Date: Tue, 19 May 2026 16:25:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>,
 Hrushikesh Salunke <h-salunke@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ye Li <ye.li@nxp.com>, Andre Przywara <andre.przywara@arm.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Heiko Schocher <hs@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>,
 Peter Korsgaard <peter@korsgaard.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <20260519222535.GH1858239@bill-the-cat>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <20260519172225.GD1858239@bill-the-cat>
 <9988717e-7ce5-4a51-8424-f91cf2e16b55@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dvCBBbzKl7WL4Udj"
Content-Disposition: inline
In-Reply-To: <9988717e-7ce5-4a51-8424-f91cf2e16b55@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 20 May 2026 00:29:14 +0200
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


--dvCBBbzKl7WL4Udj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 12:13:04AM +0200, Michael Srba wrote:
> Hi,
>=20
> On 5/19/26 19:22, Tom Rini wrote:
> > On Sat, May 16, 2026 at 08:19:56PM +0200, michael.srba@seznam.cz wrote:
> >=20
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > >=20
> > > Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PSCI=
 in SPL.
> > > (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing else=
 will.)
> > >=20
> > > Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed to=
 fix up
> > > upstream dt to make usb work.
> > >=20
> > > Mirror u-boot proper selections like GPIO and pinctrl to ensure consi=
stent
> > > behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for simil=
ar
> > > reasons.
> > >=20
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >   arch/arm/Kconfig                 | 33 +++++++++++++++++++++++++++++=
+++-
> > >   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
> > >   2 files changed, 42 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index 850768282ce..255d2035cdc 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
> > >   	bool "Qualcomm Snapdragon SoCs"
> > >   	select ARM64
> > >   	select DM
> > > +	select DM_EVENT if USB_DWC3_GENERIC
> > >   	select DM_GPIO
> > >   	select DM_SERIAL
> > >   	select DM_RESET
> > After looking in to what's going on here more, this should be:
> > 	select EVENT if OF_LIVE
> >=20
> > And is a standalone bug fix. The event in question here lives in
> > arch/arm/mach-snapdragon/of_fixup.c and is for both USB things and
> > OP-TEE things
> That's probably new stuff since I looked at it

Possibly. This should have come in with commit 5a1dfb27f917
("mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups").

> >   (so USB_DWC3_GENERIC is wrong), but desired even if U-Boot
> > doesn't use USB as the linux kernel will consume this device tree, if I
> > recall correctly.
> I think the USB fixup is explicitly not supposed to be passed to Linux,
> since it's just a workaround for the driver not falling back to usb 2.0
> only operation (and some issue with usb3 operation, don't recall
> the exact details). IIRC the code works on a copy or something
> of the sort.
> Not sure if the op-tee things are supposed to be passed to Linux
> or not though.

I could be mistaken in the run-time usage part. But I've been kicking
the rest of this event stuff around now for most of the day and I'm
quite sure on when we should have been adding "select EVENT".

> >   But next, this only fires on EVT_OF_LIVE_BUILT and not
> > one of EVT_DM_POST_INIT_[FR] which is what DM_EVENT gates.
> >=20
> > All of that said, what exactly is the failure to build you saw in your
> > series, without the above? I do worry there's something else further
> > going on here. Thanks!
> >=20
> Hm, EVT_OF_LIVE_BUILT definitely needed SPL_EVENT to work in SPL, maybe I=
 accidentally added DM_EVENT when I was debugging that and then later I ass=
umed I added it on purpose? I don't think it was a compilation failure, sin=
ce even SPL_EVENT not existing didn't cause that, it just caused lack of wo=
rking usb.

OK, yeah. I too got confused for a bit on DM_EVENT vs EVENT.

> Maybe I intended to `select EVENT` instead... and DM_EVENT selects that t=
ransitively, so I may have originally selected that in menuconfig thinking =
"I'll do it properly later"... I really should remember why and what I did,=
 but oh well, hope my educated guesses are of use. I hope you didn't waste =
much time on this since I really feel like it should've been `select EVENT`=
, especially in retrospect, and again I don't think it was a build failure,=
 just the fixup callback didn't get executed (fwiw I only tested in SPL, an=
d I assume it does get executed in u-boot proper at least in the cases wher=
e it was tested by others, but without `select EVENT` I'm not sure how)

I'm glad you found this really, it's caused me to find and fix two
direct bugs (this one, and the TDX_CFG_BLOCK option also needing to
select EVENT) and make it clearer when this would fail to build for the
future. It's also gotten me looking at some other linker list issue I've
needed to.

--=20
Tom

--dvCBBbzKl7WL4Udj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagzjXAAKCRAr4qD1Cr/k
ChpNAQDFW0jnSMJbgpXwDpdQ2By3gPjs9UXGKx2JV/4jU/U4kwEApdMHuC49HvkM
rSAjjkrJQGV2B+4KQKFP+fDXpmEU7QU=
=j72c
-----END PGP SIGNATURE-----

--dvCBBbzKl7WL4Udj--
