Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A6F0E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 16:37:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E84EC80352;
	Fri, 20 Dec 2024 17:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BoosVjx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7392A8036F; Fri, 20 Dec 2024 17:37:57 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 390EF80326
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 17:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-46772a0f8fbso18877951cf.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 08:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734712674; x=1735317474; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wcNh7Y2xTlhq28S4I937AxojvqduMS8R7vf9hl8YDnM=;
 b=BoosVjx8mFfZlv7t9zXJKN7BhClpK88wxCUkdi8K4fE0YBGvl/RVbUE3c3q+YKU0mm
 NYqjMFgmkJu7iq7El1UTKTzDXhx3CgMRXSvIsTpjHuYPYVnUHp+Ay2h+bKps37OSoQ/X
 ns8+FSb9IKhzAPzDFl/BKbBEqacCUWm6PGBqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734712674; x=1735317474;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wcNh7Y2xTlhq28S4I937AxojvqduMS8R7vf9hl8YDnM=;
 b=res7y7ACCFcd/FmYmukE10owf86CKN45hHgwgz4GdY5ZQrbvQ220fCHLppMQ2sbOod
 JABydv6SmpHDutHTytaptnsUgqdrvAawbFIcgjxWu/JSD7B3xx8TrxO6L5bhN9BfWx60
 axxSZbZ7WOfYr0CjgMu4O3C5dz8knWCHLIKGpVcTfyCOSdyRKZl7YL0o2b/tUhRqV+Bt
 oVC76K1Tf/+GGmhLdu19g1GnoQ5emcPEvX9M28zUbl4W5bHA+iqXBrMk+9GqL8yUcpGt
 SdfxY33p/3gDDVnVRx1W46u4IbtPILzpq9yuJTT4L0CWS1beiKQKK9/IZLaOIKR/ksvm
 yOFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Spf/vpKBydJzqNPwqqNOETrB0YrMborknX2A4j6n47EVWVqQSFiGRG+ag63jGPiHfxnJRtg=@lists.denx.de
X-Gm-Message-State: AOJu0YzsRwZAtdciE9IBx1CIQqJ3UeYkMlMb68Kpj7lU4BfaG2KJW92c
 5fHNLdvOTVj6ZkjoJqjgfAgOfiHvUeNoSJ5hHTsN4zw4/LR99JsO/QGpd+E9W90=
X-Gm-Gg: ASbGncskI3zjPQFqQEz7w2st2MhY3K4bDr/9j6lP798bWy0pWpw5H1OPcdvvEStNcdv
 WBsrbE2G89yiqLi3S/pgoo40XS+zhM5wTN8j0nVlTOXJ0pBBlzyki1Kt93d3f7AHVr7C7IqM/HE
 aOBjVuIULtdju/9GIy3qaAwWOL/wCbT/lF4T+UIdk1bMVqVpPuntRa0+AXxWkSMErzLgFhCayHJ
 7Ifno+b95qlcQWwkJXkM/g3Wvk8LH7xJlzCMSFgotOjdqyV0ZDRe9Jr
X-Google-Smtp-Source: AGHT+IFwty2AcxzxXVXZcwbbFWaEzqzdC2+8oV03dAYFhRh0NrTuJAPE1yKGO45NCdE56i6+V/LXkQ==
X-Received: by 2002:ac8:7e96:0:b0:467:59f6:3e56 with SMTP id
 d75a77b69052e-46a4a98a6e7mr62976521cf.36.1734712673925; 
 Fri, 20 Dec 2024 08:37:53 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1760fsm18263491cf.71.2024.12.20.08.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:37:53 -0800 (PST)
Date: Fri, 20 Dec 2024 10:37:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: Roger Quadros <rogerq@kernel.org>, vigneshr@ti.com, bb@ti.com,
 lukma@denx.de, n-francis@ti.com, mkorpershoek@baylibre.com,
 afd@ti.com, glaroque@baylibre.com, sjoerd@collabora.com,
 martyn.welch@collabora.com, rasmus.villemoes@prevas.dk,
 caleb.connolly@linaro.org, j-humphreys@ti.com, nm@ti.com,
 u-boot@lists.denx.de, srk@ti.com
Subject: Re: [PATCH v2 4/5] arm: dts: k3-am62p5-sk-u-boot: enable USB0 for
 USB DFU boot
Message-ID: <20241220163749.GH1505244@bill-the-cat>
References: <20241218124542.3519447-1-s-vadapalli@ti.com>
 <20241218124542.3519447-5-s-vadapalli@ti.com>
 <e4b23017-375e-4430-aef2-001c1b6402ca@kernel.org>
 <noztdv7z4cwzjwc5sgqvzli36ppm2tlgrpqjgxbkbtojs34jnp@3lhnfx6ol4in>
 <a0dd6878-5f26-47a0-8025-ba9d9d320a31@kernel.org>
 <20241219170044.GX1505244@bill-the-cat>
 <lq5jqpiifhnmdvfqy2wguqklikcpo3hl37p3ojbm6pfsl6supl@opm7xkmql4y7>
 <20241220142528.GA1505244@bill-the-cat>
 <5qksc7opj374tssk365jfo5orxmymwn3pzcvchtodf2nenvtsa@4v2dldntch7z>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="taX5zTqK969PkW0c"
Content-Disposition: inline
In-Reply-To: <5qksc7opj374tssk365jfo5orxmymwn3pzcvchtodf2nenvtsa@4v2dldntch7z>
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


--taX5zTqK969PkW0c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 09:49:46PM +0530, Siddharth Vadapalli wrote:
> On Fri, Dec 20, 2024 at 08:25:28AM -0600, Tom Rini wrote:
> > On Fri, Dec 20, 2024 at 10:19:31AM +0530, Siddharth Vadapalli wrote:
> > > On Thu, Dec 19, 2024 at 11:00:44AM -0600, Tom Rini wrote:
> > >=20
> > > Hello Tom,
> > >=20
> > > > On Thu, Dec 19, 2024 at 11:41:10AM +0200, Roger Quadros wrote:
> > > > >=20
> > > > >=20
> > > > > On 19/12/2024 07:50, Siddharth Vadapalli wrote:
> > >=20
> > > [...]
> > >=20
> > > > > >=20
> > > > > > Please let me know if this patch can be merged on the condition=
 that I
> > > > > > post the patch for making the same set of changes in the Linux
> > > > > > device-tree as well.
> > > > >=20
> > > > > Tom, what do you suggest?
> > > >=20
> > > > I feel like Nishanth will say it if I don't, so, it's blocked until=
 it
> > > > comes in via OF_UPSTREAM being re-synced. That's the rule to avoid =
the
> > > > problems we've had in the past.
> > >=20
> > > Thank you for the clarification. If you merge this series partially
> > > (i.e. this patch is dropped), please drop the next patch for
> > > documentation as well since the feature will not be functional without
> > > this patch and hence shouldn't be documented as being functional.
> >=20
> > Please post a v3 of this patch with that can be taken now, off-hand I
>=20
> Did you mean "v3 of this *series*, with this DT patch and the
> Documentation patch dropped in the v3 series?

Yes, sorry for being confusing.

--=20
Tom

--taX5zTqK969PkW0c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlnV0ACgkQFHw5/5Y0
tyyzIQv/UgH3zTmroFX+wXrhlsP4nAuWvx7+t5LmL/b+yTGTHS4yQpQ0raqU+zQU
WaHZt3OWBV6Mnnqa6oIlQeZ+x02CtzyT3Hwdzzz8yeoMaRJiEFBxnf9xogDA5nSv
eN3MbQ0bOky1OiIla+6DV1y1Ksv9v26LXW0in4f/Y3UvqHaHIqBj314+gqOQMmVF
z2guox/gFXQliV/xzKcTZ3dds7mw15ahjorQpnwGsKGnoW0zzKbw4TkU4wicSrII
jZNCo8PSjjmPQcvVy5hJ91aiWXAFKuReL6gkpAjCpTHnr6+MLHdYFCAGWP3Z3Vi1
M1cP+ngQmsOOXjfbjse7vl69UgS8D9ETXzqpMDbTIxLGcqFbvWfCiPN3UtqLgGNf
wOF4r1/mCugfgJLvs+jLUDOELq23X1ALlH121mDfS6H+TKYAQ7omUt0pyEAYXw62
ugkhzUyk5M+riyt7MuSRbPLZh3F0g2LhLJFApgX7af77GqTuocQEpsK7i0Fvr0T/
wDIwuB7A
=BAy0
-----END PGP SIGNATURE-----

--taX5zTqK969PkW0c--
