Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF123CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 21:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBDDB846A4;
	Mon, 18 May 2026 23:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="B2MqpMup";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AC0984694; Mon, 18 May 2026 23:05:08 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24DCF84119
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 23:05:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-479aa2dbea2so1098246b6e.0
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 14:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779138305; x=1779743105; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0aIpVvIR1Q74oUzC8FUqg7WDUPSw9Y0UGOIhFJszDak=;
 b=B2MqpMupxX/C0iirxFH8ndqcWFN4OGlc4d30WAlXLAbmS83slKby3EvS1B+QYNLP4B
 VF88qD/KOWmUaxzT8BiEUJsHnQ+j9BZFUX9CVc2VjKQglivL2IlZGCn1cf71K5h/S/Df
 GTjTH8gynBZ4cFDT2m/wehCceLWSHi8bxdkYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779138305; x=1779743105;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0aIpVvIR1Q74oUzC8FUqg7WDUPSw9Y0UGOIhFJszDak=;
 b=bje1eySPaA9KQ/qK9y1gtVJQYcJGPa8aGaFAj3r6TnpS2qNFfL903muRD8txxY7uXU
 PgvxupBA/uIq4Rmv2LHlyT+sxj0lThrLq6P8wor7VzVkInXh7Sykoj1V+FjIflDY+oh5
 CLC46sYh23PjSpz7V+qeUOdg6MSo6n2ts4NGOgUMHSaCVN7CErUeIeDYl59SwQ5sek13
 O2K/Ilp7EDBei9CIFgq+0gVRDCk4BD2DhO5YDAwrGx5IpzBinYyy283wWkES/2hjVj0r
 HR7Bw/kO3wXT9U2M1Od3/sqSVuqDbiAKDppWa+tM+O9HrHpaBKZ97mjzOqsWaXUk8Guu
 VRtQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8jvrF4gfD+aFveKXkYSXJGKWxY7UtSGBRXuKnINXFZsJkZTDwHiUAZlLdyxYdYzQ+XcvvU9FI=@lists.denx.de
X-Gm-Message-State: AOJu0Yyu12iybs3AmsJ1c3rLE6n4udEgxHbnL+U5UZfKm6kg4t8NTSWV
 VSfJaWd/LP+hkCFdpfbouAnmgGRKxlX//fG9TQhqSENV0bjcVowtjqBkuQEh1glOcmUcI9sNNit
 6y1JEeRJrs8gq
X-Gm-Gg: Acq92OF+5Wv5P9pPBdezXGtM18uHh0SvvANgBXWg713f7zvLYrqYavY0v2t0Y95POQP
 DtSnq1J+8exzaf/8QU7bQ6JNU1RV/1CeROSNL3/fDx9klwtnGmI4/WiGdpr/WVLh8OpwnL82v81
 0PhJm5sSXff+Zw2nBZzwiIfk5Yfz29sE6vA7sdJbwcEoWrZxHtQ3/dlFcJrb6aAoJxlWCziKhyc
 /A2XNWZxDTsb8ZIKBjvHAMeQTm+OvMy5yn3HgSm1GE6wh/QubULNShl/O0V4fArRyNRBRq6IZJA
 v1GQBN7mBKa7LYXCpUNZqAMDPceQN4P4HQvPK9v8gwy7uq5Kc+zXxUbWt0uTCcg+S6i9b0RUBca
 T5m78vHYV5F5G8cssaihmQ3uVDciw8xsxbwL+4mI+xVwpI0xE6qkzur+VXNzJ4Hn8ifJBd8w5C3
 Kxe2o3Z4j+g4k8vsKKuT9cKxtHrRW41jdPd0/DO6PRyq1+5IsBngsg190LGeqj3wk5KkzUKDl1W
 9Fx6cJeleK1/FhfVPphxJGn93xhhbovH7Ed7Ig4fe83wxS9pQo=
X-Received: by 2002:a05:6808:2395:b0:450:839a:557 with SMTP id
 5614622812f47-482e564da04mr10073427b6e.9.1779138304837; 
 Mon, 18 May 2026 14:05:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-482ee389243sm5552182b6e.6.2026.05.18.14.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 14:05:04 -0700 (PDT)
Date: Mon, 18 May 2026 15:04:59 -0600
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
Message-ID: <20260518210459.GW1858239@bill-the-cat>
References: <20260516-qcom_spl-v8-0-69b55c9abffe@seznam.cz>
 <20260516-qcom_spl-v8-7-69b55c9abffe@seznam.cz>
 <1f639a99-7d32-4f3b-bd0b-8936cb56ea0d@linaro.org>
 <48832d44-dc85-4b23-980c-87ef686669e2@seznam.cz>
 <20260518205853.GV1858239@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Iu5EOil2s36HtDhO"
Content-Disposition: inline
In-Reply-To: <20260518205853.GV1858239@bill-the-cat>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Mon, 18 May 2026 23:35:05 +0200
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


--Iu5EOil2s36HtDhO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 02:58:53PM -0600, Tom Rini wrote:
> On Mon, May 18, 2026 at 10:25:05PM +0200, Michael Srba wrote:
> > Hi,
> >=20
> > On 5/18/26 10:40, Casey Connolly wrote:
> > > Hi Michael,
> > >=20
> > > On 16/05/2026 20:19, michael.srba@seznam.cz wrote:
> > > > From: Michael Srba <Michael.Srba@seznam.cz>
> > > >=20
> > > > Select SUPPORT_SPL so SPL build can be enabled, disable SYSRESET_PS=
CI in SPL.
> > > > (SPL runs in EL3, so if SPL itself doesn't provide PSCI, nothing el=
se will.)
> > > >=20
> > > > Also select (SPL_)OF_LIVE and DM_EVENT/SPL_EVENT, which are needed =
to fix up
> > > > upstream dt to make usb work.
> > > >=20
> > > > Mirror u-boot proper selections like GPIO and pinctrl to ensure con=
sistent
> > > > behavior, and select SPL_SPRINTF, SPL_LIBCOMMON_SUPPORT etc for sim=
ilar
> > > > reasons.
> > > >=20
> > > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >   arch/arm/Kconfig                 | 33 +++++++++++++++++++++++++++=
+++++-
> > > >   arch/arm/mach-snapdragon/Kconfig | 10 ++++++++++
> > > >   2 files changed, 42 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > > index 850768282ce..255d2035cdc 100644
> > > > --- a/arch/arm/Kconfig
> > > > +++ b/arch/arm/Kconfig
> > > > @@ -1136,6 +1136,7 @@ config ARCH_SNAPDRAGON
> > > >   	bool "Qualcomm Snapdragon SoCs"
> > > >   	select ARM64
> > > >   	select DM
> > > > +	select DM_EVENT if USB_DWC3_GENERIC
> > > Is there any reason not to make this uncoditional?
> > Well, my understanding is that it's only relevant if something registers
> > to receive an event. Maybe some stuff just has a slower path but would
> > benefit from this? I don't know, all I know is that the fixup has a hard
> > dependency on it.
>=20
> This seems like a USB_DWC3_GENERIC bug (missing select DM_EVENT), but
> not something you need to tackle as this is just following the existing
> way.

Following up to myself, it's not a USB_DWC3_GENERIC bug, it's a more
generic bug somewhere. I think the best answer here is to just "select
DM_EVENT" which is what a number of other SoCs do, and I'll go dig in to
what is missing a select DM_EVENT.

--=20
Tom

--Iu5EOil2s36HtDhO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagt++wAKCRAr4qD1Cr/k
Cu1bAQDjUFui5D3d9Zd8+RCmGVy/rne1hEY8oFHErXEJBX6MpgD/aeZL+MdMgh/H
iJdJHAzp+dQzFo4dIwFyNsj+8n4RdwM=
=H4zr
-----END PGP SIGNATURE-----

--Iu5EOil2s36HtDhO--
