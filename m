Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A0CCD343F
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:03:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 353DE8469A;
	Mon, 18 May 2026 23:03:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kMlLWSOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F2708467A; Mon, 18 May 2026 22:59:02 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2675D83FEE
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 22:59:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-479dc6d26e3so1764458b6e.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 13:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779137939; x=1779742739; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gt6CSn220dGQH6tXYm15sToZSgLaCc+oa3ICWJxh1WA=;
 b=kMlLWSOGNGoFXmSDqb8TA+lD4qCsDbngoGO5fjAJnNrNPk2snW3I/coEW+a3mAGtya
 2VFBoEvhf/PLBKuqwPquDElV5xL+eprwwoLnqCE9FziD+Vcqdvz1JVcocliXll/ql3+L
 GTiI9/Hnd4ElWhM22MIWK3mxReSoiLcZFErXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779137939; x=1779742739;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gt6CSn220dGQH6tXYm15sToZSgLaCc+oa3ICWJxh1WA=;
 b=bMlCOIxNRezaPWIePyZ1K8wLG3sOU2FP6LLkFEjzf1VAHlk1Sybd+QYywASGS4CVpl
 nlyK1jLXDwDU3eLLed/j8AD9AS2+2BvgduqzL+l96Mnbw8Xu9TMGjSrcAM0hia6uS24B
 hTD9wqvFQM7zlY0pUCfAiAO+qWe9x/bM3FueG8W3BnBHpMbcbE3YU9JgP1makMXTto0M
 yP7TCMLk9SmusWyR6QfmlQPro5uO0+GK6oCWY3hOG0aQWm6P24IKWcX0j2fGArw0Aluw
 3Xi/OG5TDwd/VP2qaAjaQ+y5wZtX04FFi87KCyEbr32Tp/veAYam6A6CQsKNkTpCrFgg
 bRiw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9bLiEqvVez1+oa+q5m3BzesY9VGTKjnVXOHwXsXVklI7Z9DrnuaXQUMoJ6GQ/KMRzGiRkS0nk=@lists.denx.de
X-Gm-Message-State: AOJu0YzJIXwUXxUyKDiA/VqDIwe9D2S+3tdNlMvx1oOPeR53IeEAlyeR
 6pcyweNmJs/rhlrH1E5h4j8iH85m3+DCmLt3vfracU/cJWDeluSOLgmmtOgDLv9DNrA=
X-Gm-Gg: Acq92OFX3nwkLCB2cvWhOrlzbZVqguo/NA92cPN8ORHXA0Udr1SBDnEVWdHkxr+reAe
 i3kv71Ajbl7kBDBhwrjuVEQgXAHsNs5hzoEXo7/hY+pMCxLHXcbLGM/MnSqW5+kdt/UPObQqGRC
 DWszau69r/cWnLsDEuts6PAs/ZWH+xEvKYmssRtxZGVz5Th//Nt7rNIVFfYk0StuYib9tnjF7hD
 77kHlZ9BM+lIvpNG683NhYN+OiuMuBTmDrW6gdXKc6La5K2YPJREFjm33aO8S+eGx8keoCLWH+p
 8S+qFs/Ezov6IicSbR1et29NIxvNYSVbXQMKTf3YDvGkyBOt/mP9AorGXAvGx178Nkk1UaiJmG3
 8gd3DZZ9wLKzuWq0T5GzzG2zxJRvMnZ02uQZThMWPVTqUWeBnNJDkY31z4pt59hcUOk1JUXQbo5
 0qZvZ5UAT2OxqozrpbQwYZWtcS5kQXyvzksafOuPVLhwzBRN5UUyWp2gOlT/lbDUdNsVzxhsp9V
 6itm0FVKuk+MDiA1DLa7Z1qTgOs15cG9GQR05TclZgHURDAvww=
X-Received: by 2002:a05:6808:1982:b0:467:2a6e:adb3 with SMTP id
 5614622812f47-482e5729bb3mr10786176b6e.23.1779137938569; 
 Mon, 18 May 2026 13:58:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-43a94f49da9sm5398837fac.3.2026.05.18.13.58.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 13:58:57 -0700 (PDT)
Date: Mon, 18 May 2026 14:58:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Michael Srba <Michael.Srba@seznam.cz>
Cc: Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alice Guo <alice.guo@nxp.com>, George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Alexey Charkov <alchark@gmail.com>, Ronald Wahl <ronald.wahl@legrand.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v8 07/12] mach-snapdragon: Kconfig: changes / additions
 to support SPL
Message-ID: <20260518205853.GV1858239@bill-the-cat>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
 <48832d44-dc85-4b23-980c-87ef686669e2@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dZpLhEdx4SdAMxjK"
Content-Disposition: inline
In-Reply-To: <48832d44-dc85-4b23-980c-87ef686669e2@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 18 May 2026 23:03:46 +0200
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


--dZpLhEdx4SdAMxjK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 10:25:05PM +0200, Michael Srba wrote:
> Hi,
>=20
> On 5/18/26 10:40, Casey Connolly wrote:
> > Hi Michael,
> >=20
> > On 16/05/2026 20:19, michael.srba@seznam.cz wrote:
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
> > Is there any reason not to make this uncoditional?
> Well, my understanding is that it's only relevant if something registers
> to receive an event. Maybe some stuff just has a slower path but would
> benefit from this? I don't know, all I know is that the fixup has a hard
> dependency on it.

This seems like a USB_DWC3_GENERIC bug (missing select DM_EVENT), but
not something you need to tackle as this is just following the existing
way.

--=20
Tom

--dZpLhEdx4SdAMxjK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagt9iQAKCRAr4qD1Cr/k
Cv8ZAP4rn9PjxT1U25+2hCm2WoyKRg1rlDVP1t+zIpVovqbrSgEA0A5Wf9LE+Prj
IMomhIY2xL2G1KtmrLBvutgsS5PpFgY=
=GP2C
-----END PGP SIGNATURE-----

--dZpLhEdx4SdAMxjK--
