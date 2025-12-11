Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94C07D41C35
	for <u-boot@archiver.kernel.org>; Thu, 11 Dec 2025 13:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DB8AC83655;
	Thu, 11 Dec 2025 14:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dya5nuPP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1D788389A; Thu, 11 Dec 2025 14:47:23 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC5983045
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 14:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-450c576a335so43981b6e.1
 for <u-boot@lists.denx.de>; Thu, 11 Dec 2025 05:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1765460840; x=1766065640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8l6moKjTn+mYUDGLygX7ucVuiHSNnRq/VL7drVMQcSM=;
 b=dya5nuPPyN5Wl6/JDH0d4RDtgzmQkEPUFysrtEYykaDFPCvphscQnrHpNrPdr/oAgS
 q6dlQcEj+jlZYqJVauWAgzy0LHitWKmb1x+WWYLSmfGOLqyrRbFkbqj8JWPrYopp1xML
 WQXYBSzB/MlCasbylnWNON/N8D2tCos1Oc+qY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765460840; x=1766065640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8l6moKjTn+mYUDGLygX7ucVuiHSNnRq/VL7drVMQcSM=;
 b=a1jVWxFvvrFOhquEQmoF3S2re0O+XyGL3G56Dvf+ynW5pIA/RQnvnVYtctsfCwV9F/
 7UlwBa97j4ce7G6DFTB13oLjjrAs5l2UAdE6CKhK4mPCrr4wNBoUOmb/244At8Aj80xw
 U93fMoVE/5c+LSGPatHN7JAQ6g5kL3pt1aH52VFxSgjQ0yZDMOtR/iNt805g6OUEAUgF
 hPKnFeswJVSpKtU+WIiSiUWwmzaizH5KfSO189iut43G7j6Nw8lPV9YxMrdw3YufsGz4
 aegVF8xyWPQn+UnYSAcwnW2+DUkezswZePjdD2hDA2z7jSmzS+pazuAayjuhLlVLILYt
 1Arw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUf+T6Ajgs9nA94JZZ7EiGTWZY67maGkNh4Q0AzJSMsVTGA+iHTXa1xZpx+RUCLuZZws73li7c=@lists.denx.de
X-Gm-Message-State: AOJu0YxeZEtV6zQMInFM2GdC2LMfuOTfvz6kuOVoQj+d+q0Enbc7FFeH
 Y4FQMZGqa7ZvNQumBkYrXUgbMezERNf2841k11pzhX0s4ShkHb2W2xP0fQX6rb0WyHg=
X-Gm-Gg: AY/fxX4/ZiQNFXwHdi7QPMkj+YZIdmQ/C9fmIEoH2HRetU48eWWiOi/FshtmYAW4KOY
 tjKlh1kZgyR5iryaJHpDdVErBYluzimWQVl5b8VwSHW2zU6Ghsw3JEVJxZ7wOVatousbbU5Vu+i
 /ZX8IGhw1ZEM3av3GHh0Q8LTKv8UlCSFfS0TaygGmjdAAPmKPNuyUrf+WpMEsbA4kLOv0yju779
 ySJGG90Jo3E9gTBvnwbM7H5N0tVIgBkXPMJ3TTFlPCXJzj8tXdHd/nrwtZmIGMj3/jvDlaNALWt
 nwp8Q2CpMiyP/YUtm2kEAMdMKQE2ieaGvavAQWOMjJmFcsKFwlXyOPXwPQ5esCkWFyyHify+ffm
 +oyMazcBuKnOou1WhB622rZtkS5D7+kYrx1oPztjMO6orATaQT3mciPHr+b/70vaKoR3TBUt+8h
 1hhzNEQLJ7gbFkN1miEUigtd7LoEmdE+lu30SnwzF0OE8CR3797A==
X-Google-Smtp-Source: AGHT+IG2Qh2ppmSJOmWyvqXX4J2Wuss81dbItA2SZfIaKgtfzjJm6a2BILyxfgnwrkQI1G9uFBwTCg==
X-Received: by 2002:a05:6808:5141:b0:450:3c6f:24fc with SMTP id
 5614622812f47-455864ecb20mr2848410b6e.31.1765460840006; 
 Thu, 11 Dec 2025 05:47:20 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-45598cf2c00sm993768b6e.14.2025.12.11.05.47.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 05:47:19 -0800 (PST)
Date: Thu, 11 Dec 2025 07:47:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251211134716.GM303283@bill-the-cat>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
 <20251208153226.moktyjv3irmjlg6q@lingo>
 <20251208153852.GP303283@bill-the-cat>
 <fd494719-1152-44c7-9de8-0e9a370c659b@linaro.org>
 <20251208163527.oq7vddgodao3legu@unguided>
 <20251211114226.jbggbrqlcfq7dbur@exterior>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0N0bdzEJMgs95fsz"
Content-Disposition: inline
In-Reply-To: <20251211114226.jbggbrqlcfq7dbur@exterior>
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


--0N0bdzEJMgs95fsz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 11, 2025 at 05:42:26AM -0600, Nishanth Menon wrote:
> On 10:35-20251208, Nishanth Menon wrote:
> > On 15:52-20251208, Andrew Goodbody wrote:
>=20
> [..]
> > > > > Confirmed by reverting the commit. Looks like
> > > > > 9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?
> > > >=20
> > > > Interesting, OK. What Andrew did in commit
> > > > fe780310cfa8bf5a093894b5cd7fe85c6b02fd91 is more complex than befor=
e and
> > > > there's two stanzas there. Our lab is current being re-worked again
> > > > right now so I can't test on the K3 platforms I have, but can you p=
lease
> > > > see which of the two changes in clk-uclass.c is the one that breaks
> > > > these platforms? Thanks!
> > > What is the breakage please? I did put this series through CI and the=
 only
> > > issues were due to lack of disk space, so not related to the patches.
> > >=20
> > > Andrew
> > >=20
> > Looks like A72 would'nt get started.. adding a bit of print to get an
> > idea:
> >=20
> > https://gist.github.com/nmenon/c0487b99cbd2308ccd11ffe510a780bb
> >=20
>=20
>=20
> Any suggestions to proceed?

Can you please see which of the two changes to clk-uclass.c is the one
at fault, or if it's both? Thanks!

--=20
Tom

--0N0bdzEJMgs95fsz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaTrLYAAKCRAr4qD1Cr/k
CjZUAP4uOsgNyprironn9z8cbz21UADbE0fmWGwLrpLbLJ3H3wEA2SXJH3oTk9FV
jaMXV0jTMdH790azjL2ItI01xFeaQQM=
=vJ+B
-----END PGP SIGNATURE-----

--0N0bdzEJMgs95fsz--
