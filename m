Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7948E77184
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 17:01:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 212F980196;
	Thu, 19 Dec 2024 18:01:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="m79n1C5w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 948108021A; Thu, 19 Dec 2024 18:01:03 +0100 (CET)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F044B8007D
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 18:01:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5f1dbf0d060so459093eaf.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 09:01:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734627659; x=1735232459; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UeyvAGqJzze+5suVVkXvhTdAlCNJZimWY4bNNKIjZrk=;
 b=m79n1C5wI+Oa779Xp83pBuP/gjbUyP0GJPNiWG2N06CZOEtFQ/aoFufAjlaMwQ56sb
 /ft7E8UsyryOlwUnHALzq0HY5Xg2R/XJ+3ywpnZHmAuDGWoRil/IjxLDgOV64Ier7IGN
 hvO2zV9nL3MDBjNFArgWV/0vfoFXogRPcsYz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734627659; x=1735232459;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UeyvAGqJzze+5suVVkXvhTdAlCNJZimWY4bNNKIjZrk=;
 b=cKg3aSaZVgA9v5R2GWye+Eik4L3wZFnz2lRzD768qDGGNOzVsldovgXKWHnFVeaoje
 F+DPUgrkbDzD51x+nu1ygkabS0iqVoK++g+yVsAKTj3Bg09CmseIQ14YXGA1IYgh3Qw+
 5CWYbwl5frrQorDqAwXqVcGnNtPr7jhalZEWZ40qL/gWpTkdkPu0o8TKTiOftaTZdQws
 HtAml9TCE1VJs00E0Yp+Evyj5YpIGTYd2TbSRhUU1slpwRb9BU/8tPOtS1tzRZ6aRYHQ
 p73Fpuqt2hce/+gomsM0zsO8ys+EAGK6DP6hLPdinvk8vEu0jw29Bw/+uDJfDlmRGSh1
 LVNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8HzdKeydRQ5AfvABgEB1fMr7SpqxIhpNHRsRNNJiXbNPykO0XajETjFbh+Dk36hwN02ML9Lg=@lists.denx.de
X-Gm-Message-State: AOJu0YwPM5u4RXJ4KFVVPUsw8yJHmIinkpTdjWx11BfvVTdKWm4RPh4o
 uHbijYCJuAfEbACMY7AfwYwh1hqVRHQG5oTEwRkF+0yXP+SiTxIHQXciw64li47R08xQBmittot
 7
X-Gm-Gg: ASbGncssfYJdMITkiUzqkIkNX7tCMKHnq1u9CB4Lz0UgusFTFYjbHa00VpQHzRUGIQJ
 FE7mbVvgJ3xRisNhsXcdmsoJN4rmrkt4d5CjlaY+9pNryVKlQnfHs9yDBQPTAi9BLwZBA//LUaZ
 8owtndv1Krr31WCt/g1ex73yvLfB1n60ymgxwFaWZcW6RiUyFBUpsEczfNUBN7dMm6OrwK0ughb
 8dMj/L23jR+RJew5QPKL9wFsIgjOHQdEtLGZBPmRja/5h9TvJ36udco
X-Google-Smtp-Source: AGHT+IFSy05AZSmVFdQzTX1WdRhm7x1GYQ4trgdAQo2FQm8qjrJtVldxSFEmqGfbNJXqP+ZPZYHp1Q==
X-Received: by 2002:a05:6102:3a0b:b0:4b1:16f8:efcb with SMTP id
 ada2fe7eead31-4b2cb29a77cmr362944137.17.1734627648820; 
 Thu, 19 Dec 2024 09:00:48 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd1810ec55sm8215626d6.48.2024.12.19.09.00.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 09:00:48 -0800 (PST)
Date: Thu, 19 Dec 2024 11:00:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Roger Quadros <rogerq@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 lukma@denx.de, n-francis@ti.com, mkorpershoek@baylibre.com,
 afd@ti.com, glaroque@baylibre.com, sjoerd@collabora.com,
 martyn.welch@collabora.com, rasmus.villemoes@prevas.dk,
 caleb.connolly@linaro.org, j-humphreys@ti.com, nm@ti.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <20241219170044.GX1505244@bill-the-cat>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
 <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tu7srQ7k/Co4aQ5B"
Content-Disposition: inline
In-Reply-To: <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
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


--tu7srQ7k/Co4aQ5B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 11:41:10AM +0200, Roger Quadros wrote:
>=20
>=20
> On 19/12/2024 07:50, Siddharth Vadapalli wrote:
> > On Wed, Dec 18, 2024 at 04:05:47PM +0200, Roger Quadros wrote:
> >=20
> > Hello Roger,
> >=20
> >> Hi Siddharth,
> >>
> >> On 18/12/2024 14:45, Siddharth Vadapalli wrote:
> >>> Enable USB0 instance of the USB controller for USB DFU boot functiona=
lity
> >>> which requires the "bootph-all" property in order to have USB enabled=
 at
> >>> all stages of the USB DFU boot.
> >>>
> >>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> >>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> >>> ---
> >>> v1:
> >>> https://patchwork.ozlabs.org/project/uboot/patch/20241217131658.29207=
99-5-s-vadapalli@ti.com/
> >>> Changes since v1:
> >>> - Collected Reviewed-by tag.
> >>>
> >>>  arch/arm/dts/k3-am62p5-sk-u-boot.dtsi | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi b/arch/arm/dts/k3-=
am62p5-sk-u-boot.dtsi
> >>> index cf087c6e343..c2091fc1a51 100644
> >>> --- a/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> >>> +++ b/arch/arm/dts/k3-am62p5-sk-u-boot.dtsi
> >>> @@ -16,3 +16,13 @@
> >>>  &dmsc {
> >>>  	bootph-pre-ram;
> >>>  };
> >>> +
> >>> +/* Required for USB DFU boot */
> >>> +&usbss0 {
> >>> +	status =3D "okay";
> >>> +};
> >>
> >> This should come via upstream DT sync?
> >>
> >>> +
> >>> +/* Required for USB DFU boot */
> >>> +&usb0 {
> >>> +	bootph-all;
> >>> +};
> >>
> >> This as well? But I don't see it upstream. Do you have a patch for ups=
tream DT?
> >=20
> > I haven't posted the patch for Linux device-tree yet. I will post it and
> > it can be synced with U-Boot later. In order to avoid blocking USB DFU
> > support on the Linux device-tree sync, I have posted this patch for this
> > series to be complete in terms of functionality. If Linux device-tree
> > based sync is the only way to enable this, then the following patch in
> > this series for documentation should also be dropped since the feature
> > will not be functional without the changes made by this patch.
> >=20
> > Please let me know if this patch can be merged on the condition that I
> > post the patch for making the same set of changes in the Linux
> > device-tree as well.
>=20
> Tom, what do you suggest?

I feel like Nishanth will say it if I don't, so, it's blocked until it
comes in via OF_UPSTREAM being re-synced. That's the rule to avoid the
problems we've had in the past.

--=20
Tom

--tu7srQ7k/Co4aQ5B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdkUTUACgkQFHw5/5Y0
tywFPAv/ToUH/e7s5agn1t1lExlavbT0pxnQ4332y5iY2EdnSNM1qN1ctnEtyy/A
gTqrC+sUoSRYcaS6L3goalHS0I8DNX3nCN4XyDnWzMn1zf5KQlX0P0OV0cYyXngD
cGpIkmVUGVBKG8ONp/2jDItNyR1CIyJoD+gl8KsD8vnYPjOmG3eZ669u6yxwk1UP
pRXf5kaD/NYxtpNluP4+PzKDoq+T7ICIYZckkAyijSec81E6hEjRIYxRvOb0zBko
oRnKqXUbT1ZaHiJMoGzp5UHkFfBWhcX9tMPWAHU2jKk1Pn3UsO8nMIa5BabpZCpL
/SHJtNrqY4m31yq294PwZJn8RYho+pcS2WxAhXkb0c4OwImYfhCEo/F8dTmJY7/P
p1D0RRMIMjRbqEf7+Q58aAcgbqCt13Q+8swkKVmn8TsZmThXijM25chSpzrB2UBh
pOcrfQrzRRRFb0GuXzCPLt86ZTy83m5EcrJ9l9OiaYxCziLjoPXOYBzoCT3FK93f
Addhm3Ff
=4dmu
-----END PGP SIGNATURE-----

--tu7srQ7k/Co4aQ5B--
