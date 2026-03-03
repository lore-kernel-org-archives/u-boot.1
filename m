Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4C32EDA68F
	for <u-boot@archiver.kernel.org>; Tue,  3 Mar 2026 15:53:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39145839DF;
	Tue,  3 Mar 2026 16:53:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ez1Ks6Nb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CBC683F4C; Tue,  3 Mar 2026 16:53:41 +0100 (CET)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ECB0E838BB
 for <u-boot@lists.denx.de>; Tue,  3 Mar 2026 16:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-679ed01869fso2246726eaf.0
 for <u-boot@lists.denx.de>; Tue, 03 Mar 2026 07:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772553217; x=1773158017; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x0HtW9tpxhOgfh8HaVM62kY2SfSgYU50JLwzMRA3PBg=;
 b=ez1Ks6NbyGsII9UKSWNRVqf8811fjVgtEEAB53WoKgGLbdpWZ+0IVQMvRvZw/NKnA6
 omW+7maQESD20sYgAUj931lpo3vNU+9aecZyWJnsrJL3yyHny5lMyoelJFa+piIedess
 MTkufjAehwYhw90csA4IJCIfInGLwRXh7GZHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772553217; x=1773158017;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0HtW9tpxhOgfh8HaVM62kY2SfSgYU50JLwzMRA3PBg=;
 b=Oo+skTqZH6tIM2VZSHkLR2sDQX/Ow/AFCZc19lbHvHQAt6+tzj4pPWtn7umAtY0Fsp
 em1/49NyNnFGXEZ7CY7C2mkiaELWC8cHDlwMIxL8siZ3LSQ+X4ADdCZJrizjRllU6Uhp
 HROV0YPGLJQIYtWkM98lRSEtwsQo52KO0Rm75HHzqDw/K+fKpHhKfa6RmN4frLRGssu+
 +S9wo4k3HvC2km71N483mmf0TtslwM/eCfsSisRwEgYiP6wk/7bNdrr0gWch6EDwcxL0
 BUKP8Zu8YziFxlDRucJ/VF+TbVCcGBKmXsPLf65DkwXzNgX0pBi5fy6R9NinVVJP8TdH
 NMNw==
X-Gm-Message-State: AOJu0YyZ9xtF6FUj3SAwHbkcMDpmSpEfTBARByfeamqHkhRaf4KE5OIO
 Mu4Z0opX1cuhglJqrJTLNRaEyP0L045RMHeMQ1N9DOf+AXklhO0a05XR8HkHAE3HeSphisTqI6q
 qbKNGc1g=
X-Gm-Gg: ATEYQzwHlM3xCfkEfVbc0XcKh6KLLrqn7pfs5sH8AM6KIYou0vMgo12yBpXAlo3YCCt
 zObEAX43EwDGxNhIBrKrVyv8xMmw3h7lOvlpf1/HlT/7jONimRVdryiX62UG+ZrisOCXgPXtv+i
 4rtisPMkJmVrlY6G1LWPzTVg5dL9VyLeJM4+2Bd7ssOKYqzPcjwgiRyTcN2QYonJL7axVyLEkdS
 VX8Xs3a7adCvdDbGq4wPiKzQsuSy/ItlJ0MNawl/n7rCRKb4f+3NDdxXodAO/C6gzQTgRvgAmHW
 PxasisP2SV16res8jOjriwQ6NjMCcy2CxyOGK2/dmTJpBPaX6SbnngyzIwmUYfkgsBIvxRibS9x
 +Ewg0XCnVMnF6lKkwYbW3Zfa/uDD0Jvo6K0FJRIYHbgvgDBzWEa0sw8GUpShquZuy0dieNJuSuH
 5yf7R+zMvT/2BtgeKcqgxqYB7dzf09solzRSKOTgpxbIfAETjR30GuVZE0dRVd91DI1ss2r9vUa
 hbQQBfZA+2IJ4nO/VhoNmxyt8EOcwJR6C6bAaWaMgYlHpRP3Ww=
X-Received: by 2002:a05:6820:1794:b0:676:a667:4947 with SMTP id
 006d021491bc7-679fadb6baemr9904431eaf.10.1772553217588; 
 Tue, 03 Mar 2026 07:53:37 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-679f2bcbb58sm11522157eaf.3.2026.03.03.07.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 07:53:36 -0800 (PST)
Date: Tue, 3 Mar 2026 09:53:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] FIT: Address Secure Boot Bypass for Signed FIT Images
Message-ID: <20260303155335.GO1388590@bill-the-cat>
References: <20260302220937.3682128-1-trini@konsulko.com>
 <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2MtLAafUG6svq40K"
Content-Disposition: inline
In-Reply-To: <1c8f8282-7ec9-440e-bfbe-2494f5ea69c8@pengutronix.de>
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


--2MtLAafUG6svq40K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 03, 2026 at 09:08:59AM +0100, Ahmad Fatoum wrote:
> Hello Tom,
>=20
> On 3/2/26 23:09, Tom Rini wrote:
> > There is a flaw in how U-Boot verifies and generates signatures for FIT
> > images. To prevent mix and match style attacks, it is recommended to
> > use signed configurations. How this is supposed to work is documented in
> > doc/usage/fit/signature.rst.
> >=20
> > Crucially, the `hashed-nodes` property of the `signature` node contains
> > which nodes of the FIT device tree were hashed as part of the signature
> > and should be verified. However, this property itself is not part of the
> > hash and can therefore be modified by an attacker. Furthermore, the
> > signature only contains the name of each node and not the path in the
> > device tree to the node.
> >=20
> > This patch reworks the code to address this specific oversight.
>=20
> Do I understand correctly that this is a breaking change
> for FIT with signed configurations?
>=20
> - New U-Boot hashes more than intended for old FIT
> - Old U-Boot hashes less than intended for new FIT

Sadly yes, similar to:
commit 79af75f7776fc20b0d7eb6afe1e27c00fdb4b9b4
Author: Simon Glass <sjg@chromium.org>
Date:   Mon Feb 15 17:08:06 2021 -0700

    fit: Don't allow verification of images with @ nodes
   =20
    When searching for a node called 'fred', any unit address appended to t=
he
    name is ignored by libfdt, meaning that 'fred' can match 'fred@1'. This
    means that we cannot be sure that the node originally intended is the o=
ne
    that is used.
   =20
    Disallow use of nodes with unit addresses.
   =20
    Update the forge test also, since it uses @ addresses.
   =20
    CVE-2021-27138
   =20
    Signed-off-by: Simon Glass <sjg@chromium.org>
    Reported-by: Bruce Monroe <bruce.monroe@intel.com>
    Reported-by: Arie Haenel <arie.haenel@intel.com>
    Reported-by: Julien Lenoir <julien.lenoir@intel.com>

--=20
Tom

--2MtLAafUG6svq40K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaacD/gAKCRAr4qD1Cr/k
CrtvAQCE0vZbikNzqpuDIsZkVNn19e1LQTZgySNMCmD3LivriAEA1mTeGF25s8X4
sQuly3MhGp50wAB9QK8VR2rSWuYruQw=
=S8/x
-----END PGP SIGNATURE-----

--2MtLAafUG6svq40K--
