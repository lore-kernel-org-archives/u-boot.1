Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA6EEA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 13:01:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF7B84099;
	Thu,  9 Apr 2026 15:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1JS04JG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C81E83CF5; Wed,  8 Apr 2026 19:45:05 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D07483693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 19:45:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7d1872504cbso17531a34.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 10:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775670301; x=1776275101; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zsy4sobGloSbTvJlDAGt8vCTdiRVaJZ0MDdgYGWnZec=;
 b=Q1JS04JG4hC9dz4+yTUqRkveLsEauMbJe9blqOTv1vO5DshtctShjZFEZTFI6GBe6T
 qcRh6zLfbRjR9Vn9IN0aUaGXA5EM9siQFj+NPJQptYy1gE6LJy/RwyRRYDGbUbxybxfg
 rxkRoZFdpnHJ0GzW3/7kZk7NiDLLljGctu/N0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775670301; x=1776275101;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zsy4sobGloSbTvJlDAGt8vCTdiRVaJZ0MDdgYGWnZec=;
 b=KyxDqjX1CWMMV8ywZYTyEpzd2ntw1laKCjd4G72t8fYcrJrIY1n+xIUFJjUuZlTSiS
 WbYZQcnd3nNiYU3O6LjCnfYG0WfcjMlRp+gKO9wqtJxWb7ofb9hu4PNbC9TDcH3bzJyC
 PItV5x68O4No51qkpW3U9iXFAVkYvkTjkB15Wj2FUmhXvZUIx0lREco4thbHnNQ9COF4
 dpaUEqIAZmRYIgt1i70rZtnLiBxatu5P1D4dyJ2D3RRFhm/2+P9vVq1FhQzssraDTkvG
 xEQJbUIOvNQhUQsNaF/fW8ppf0GrQXKsyJgiVI86oGDNMeCVb6612FTNUoHi4W4jktfl
 nmwQ==
X-Gm-Message-State: AOJu0Yzi+hWX+Qozjut9xgpaBQyR7ULXyBpnufXrE5i4tfJUfN/hZKqL
 vrY3ISQLsbh3biXT7y4kxxgp/9UV2inTM5Q5V5mRpdOVY26a/LwjCJ8Xdx66oJ3pU0w=
X-Gm-Gg: AeBDievtsSunY4jYDD2FW8/OPoQHs6VxaIi9xWha3rYY2t4HkpbiOKAnLUzCWLx64hb
 czlkILJa1W28oh0kz2XdXUColLogvmj1rSh1YkG+mgnRmrnlBm+poR+HMHabC96h3GTReQJMzUT
 P5XUa98xHx0k+V2uUBDHoZ/NeSvM5wqyjrIQcBCDk9/9DDrd87Tg8jGib4XLr1+CSQ2TD9JuKdb
 LH3vC1t09w9/j+e9tzm/xqAZi4ds+ZQE9kIyg0XZxlxlW24+/FYilRHcLYFzMhXry5bKiC8dPXN
 +nc09++EGREY6z/opG2b+1nWY0S6vfivRZEbXnkMHj89903tdkn/17vW54KNUmkjsJhIdmpKc1j
 cDhpQer4TH/Gl2FzPVq/X8pooqRv/IRnH1GnQXt/Ek9xrbP/TJfaN7MHVWlylIlE4uSCrW9F9zU
 pSxQQdEWEbzEJ3PFnQ8dItD0X8HVKVoTvz/NvORVbj/IwvZp3I7PUbE1l4S01msS+mxM1u2ZtNZ
 ZW4IpA/giIZmmya2Oj57LNyQD1oifSEKUh/Uul4/9GT7X1U
X-Received: by 2002:a05:6830:f95:b0:7d7:c004:9d92 with SMTP id
 46e09a7af769-7dc1768ce07mr266312a34.8.1775670301025; 
 Wed, 08 Apr 2026 10:45:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dbc11722b7sm11414133a34.19.2026.04.08.10.44.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 10:44:59 -0700 (PDT)
Date: Wed, 8 Apr 2026 11:44:55 -0600
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
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Subject: Re: [PATCH 4/5] mach-snapdragon: support building SPL
Message-ID: <20260408174455.GK41863@bill-the-cat>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
 <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
 <20260406142737.GN41863@bill-the-cat>
 <b07ef09d-28f5-408d-b9c1-7524442f0f33@seznam.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dT9o7t5LxMu8XIvU"
Content-Disposition: inline
In-Reply-To: <b07ef09d-28f5-408d-b9c1-7524442f0f33@seznam.cz>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 09 Apr 2026 15:00:51 +0200
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


--dT9o7t5LxMu8XIvU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2026 at 07:03:37PM +0200, Michael Srba wrote:
>=20
>=20
> On 4/6/26 16:27, Tom Rini wrote:
> > On Sat, Apr 04, 2026 at 01:18:19AM +0200, michael.srba@seznam.cz wrote:
> >=20
> > > From: Michael Srba <Michael.Srba@seznam.cz>
> > >=20
> > > Initially sdm845 support is added, and only usb boot
> > > is supported for the next stage.
> > >=20
> > > Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
> > [snip]
> > > diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdra=
gon/Kconfig
> > > index 976c0e35fce..938e6ebd8bf 100644
> > > --- a/arch/arm/mach-snapdragon/Kconfig
> > > +++ b/arch/arm/mach-snapdragon/Kconfig
> > > @@ -1,6 +1,24 @@
> > >   if ARCH_SNAPDRAGON
> > > +# SoC specific SRAM addresses
> > > +
> > > +# sdm845
> > > +SDM845_BOOT_IMEM_BASE :=3D 0x14800000
> > > +SDM845_BOOT_IMEM_SIZE :=3D 0x180000
> > > +# we may not be able to use the whole BOOT_IMEM depending on the whi=
telisted regions hardcoded in PBL
> > > +# (we could technically relocate ourselves after the fact)
> > > +SDM845_BOOT_IMEM_OFFSET :=3D 0x3f000
> > > +SDM845_BOOT_IMEM_USABLE_SIZE :=3D 0xc1000
> > > +# technically the below would work, except the memory from 0x1483300=
0 to 0x1483F000 gets trashed
> > > +# between the ELF getting loaded and XBL_SEC jumping to our code
> > > +#SDM845_BOOT_IMEM_OFFSET :=3D 0x16000
> > > +#SDM845_BOOT_IMEM_USABLE_SIZE :=3D 0xea000
> > > +SDM845_OCIMEM_BASE :=3D 0x14680000
> > > +SDM845_OCIMEM_SIZE :=3D 0x00040000
> > > +SDM845_OCIMEM_END  :=3D $(shell, printf "0x%x\n" "$(dollar)(($(SDM84=
5_OCIMEM_BASE) + $(SDM845_OCIMEM_SIZE) - 1))")
> > I didn't know Kconfig even allowed this. And I *really* don't like it,
> > and I think it's going in the wrong direction with respect to being able
> > to configure a system. If these are configurable, then they need to be
> > "hex" type "config" options, and then used later on. Otherwise they
> > should just be the evaluated value as "default ... if ..." later on,
> > instead.
> This is per-SoC hardware info. The SRAM is physically located at that
> address with that size. The offset/usable size are further restrictions
> imposed by the bootrom, which are relevant for placing the text section
> (the bootrom will copy the ELF segment precisely where the ELF segment
> says it wants to live, as long as that's in a whitelisted region).
>=20
> I really don't like the idea of just hardcoding hex values with either
> no explanation of where they come from, or with a comment that may or
> may not reflect the reality since there's no mechanism that would enforce
> that the value was actually computed according to the comment.
> (also the amount and complexity of such comments would be higher since
> comments can't reference nonexistent intermediate variables)
>=20
> What I wanted to do here was more along the lines of:
> ```
> config QCOM_BOOT_IMEM_BASE
> =A0 =A0 default 0x14800000 if SPL_TARGET_SDM845
>=20
> config QCOM_BOOT_IMEM_SIZE
> =A0 =A0 default 0x180000 if SPL_TARGET_SDM845
>=20
> config QCOM_BOOT_IMEM_OFFSET
> =A0 =A0 default 0x3f000 if SPL_TARGET_SDM845
>=20
> config QCOM_BOOT_IMEM_USABLE_SIZE
> =A0 =A0 default 0xc1000 if SPL_TARGET_SDM845
> ```
> and then
> ```
> config SPL_STACK
> =A0 =A0 default SDM845_OCIMEM_START + SDM845_OCIMEM_SIZE
>=20
> config SPL_TEXT_BASE
> =A0 =A0 default QCOM_BOOT_IMEM_BASE + QCOM_BOOT_IMEM_OFFSET
>=20
> config SPL_SYS_MALLOC_F_LEN
> =A0 =A0 QCOM_BOOT_IMEM_SIZE / 2
> ```
>=20
> The problem with the above is that Kconfig absolutely doesn't support
> doing that. The only way to do arithmetics is to use the preprocessor
> ("macro language"), and the preprocessor obviously doesn't have access
> to the values of symbols, only to preprocessor variables.
>=20
> The current form is the only solution I could come up with that avoids
> hardcoding hex values, and from reading kconfig docs and sources I think
> it's also the only solution possible short of patching kconfig to support
> arithmetics.
>=20
> If you consider this more ugly than magic hex values (which afaict is
> the only other option, other than patching kconfig of course),
> I can obviously do that, although it does make me very sad, and I'd prefer
> if we can find a solution that avoids hardcoding. What do you think?

Yeah, I'd rather go with "magic" hex values in appropriate headers, and
should probably be in the CFG_SYS namespace (so CFG_SYS_QCOM_... ) for
things that aren't "how do we work out SPL_SYS_MALLOC_F_LEN" which will
just be (matching everyone else really) just the hex value, and
explained in the board doc where things come from.

--=20
Tom

--dT9o7t5LxMu8XIvU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaUFAAKCRAr4qD1Cr/k
CiSaAQCNqYGmIqHvKdLJBpnld1icuFiMGlfcX9VEPeExioNGkgD+MCFvE+aoFGLp
i8mkHvcMe63dewC2fXqdL6LiVpwJdQg=
=5wpO
-----END PGP SIGNATURE-----

--dT9o7t5LxMu8XIvU--
