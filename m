Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A61CD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:21:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C62846B1;
	Mon,  8 Jun 2026 16:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="E5PDulCE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 603BE84701; Mon,  8 Jun 2026 16:21:03 +0200 (CEST)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21344846A7
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:21:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-43fc82b52afso2846658fac.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780928459; x=1781533259; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OpABxMujVspiRQbG8FPWor3tb4kQCj58kod/LkjOu1Y=;
 b=E5PDulCE5VTgvulpsPmo2dQtLSaHApFArRp2U7h3EYCmSFOatnAUu58C4G+GNJJiYB
 8bSLrOW8DC0UIH3Ie6TCB7u20YxTipn6au2pdIXKvBxl+FobJUWtFCs8tU/FU3vh1DNE
 SH17SjLD/XJKVH+4Bsbnd+LZ2CBTIiEVp5bPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928459; x=1781533259;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OpABxMujVspiRQbG8FPWor3tb4kQCj58kod/LkjOu1Y=;
 b=fIOhLV9RANI+82rNKKka/kc8x367jHY+tFFsWqcjw5RqcBu87PqTM/O1dwJgAleO4n
 ixjGqvEjSMdCyKMPeveH3rYwXwUGEZDvB3I01xrPagUbpsw/42eg21WX0mOX5gycFOzm
 Ip/egZQBWiZlpvDMnaLp4gKxFyZcGY+geS0D3plC2Xq49O7LgYBg8joTzxA4KWZDRnMU
 YQrOxfOYNReAuAUHhYbX3hCyBsLbEWl7UZUJQTTWwU17A+qZYCwM1PHJ2HFx0yJh//9A
 0MB/Sc3n8j73i6hM3/MHh5OnPCZd0K8yyp2sPCfZFysH4480uQ+GqQopw61iySBO8gxm
 VAtw==
X-Gm-Message-State: AOJu0YzazvUiv8Bw1UzW+FwpLEKI1u/M7XyQQsBiz6xgmKcic/IA3flA
 /UBu6b6tXEHLKWFbeQZy6q7ie6xzm0hh89+gYhoVT3CFQFbPGUt5c6fPi/PoxF3D5jM=
X-Gm-Gg: Acq92OFi04VRRAHoAzffMgRlGIAe7HEJjaypuhYPfgccT/AHbQ/xEnSXMv9sF0wJv8e
 Qaxm0h8cfk+m+jB3DFksenHT3nEG39wed7M71cqGTRb+0oVwkppwiDLMgAZsTwZkejr+/OlnFKz
 CSP/pS/kO6cDt6RxPI3rhMb9FMr7421Kqz+1GXi38TcSZ4Sa0w61LZ8OLFh5WvN5GKveN4ipqvD
 rfmGgBxH5sZocvsG2VEDTAQlV+n4zQDluPyHQ0NUhEauLlIAT65Yvv02JqNXoXckndB1SnTUryT
 DhNfkt+WmonhuvlSupx6U2oNSXzYkspzdR7zFcHa6N2aCtmFfl41AutDi+AilEmABpIx4LC9Wq2
 d1O01WO+IUuVg/TWeqbV8NdJyS52rfoh0AfOJYsbeyGsoOUq2yt0LyG7lSna+4c9rf3e8+7vwNp
 gwYjeyVD5AGGLMMMbCNvIqvAvXomryQZEJlRjrTEeNccDOd7+ngaFtywnhZMj7hGOarJxKZHoLD
 qGkJvhCVBS8/Qjexj/hg+yLpFJGHhipovqqx84D5EZUDs+Nptsvfv55FPDvLA==
X-Received: by 2002:a05:6820:151a:b0:69d:8d1d:1cc4 with SMTP id
 006d021491bc7-69e68c2dcd1mr8841100eaf.39.1780928458772; 
 Mon, 08 Jun 2026 07:20:58 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69e4620b0casm10140100eaf.3.2026.06.08.07.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:20:58 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:20:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Lorenz Kofler <lorenz@sigma-star.at>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 upstream+uboot@sigma-star.at, Arie Haenel <arie.haenel@intel.com>
Subject: Re: [RFC PATCH 0/3] boot/fit: fix CVE-2021-27138 while keeping '@'
 node names
Message-ID: <20260608142056.GJ382693@bill-the-cat>
References: <20260602074335.3965312-1-lorenz@sigma-star.at>
 <322a63c7-0b63-4762-8968-f9112dd6863b@sigma-star.at>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uOwr2ZMfyUBXpY+M"
Content-Disposition: inline
In-Reply-To: <322a63c7-0b63-4762-8968-f9112dd6863b@sigma-star.at>
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


--uOwr2ZMfyUBXpY+M
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 08, 2026 at 11:10:22AM +0200, Lorenz Kofler wrote:
> Hello!
>=20
> Gentle ping :) Any feedback on this patch?
>=20
> On 6/2/26 9:43 AM, Lorenz Kofler wrote:
> > CVE-2021-27138 was fixed by rejecting any FIT node whose name contains =
'@'.
> > That stops libfdt's unit-address matching from resolving a reference su=
ch
> > as "kernel" to a node named "kernel@1".
> >=20
> > Rejecting '@' outright, however, is a regression. We have a customer wi=
th
> > signed FIT images deployed in the field that use '@' in node names, and
> > with signature verification enabled those images are now rejected and f=
ail
> > to boot.
> >=20
> > Such names are admittedly not ideal. The devicetree specification only
> > allows a unit address when the node has a matching 'reg' property, and
> > newer dtc versions warn about violations. New FIT images should therefo=
re
> > avoid such names, but existing deployed images still need to keep worki=
ng.
> >=20
> > This series fixes CVE-2021-27138 without that regression. The root caus=
e is
> > not the '@' character itself, but accepting a non-exact node-name match
> > when resolving a FIT reference. Patch 1 hardens the lookups so the
> > requested name and the resolved node name must match exactly: an insert=
ed
> > "kernel@1" can no longer stand in for the "kernel" node. Patches 2 and 3
> > then drop the now-redundant blanket '@' rejection.
> >=20
> > Review is welcome, especially on whether I missed any place that looks =
up a
> > FIT node by name.

I think it's good to have made this public, for anyone else that's in a
similar situation, but that the migration path for deployed systems here
should include a step migration away from deprecated images. We're a bit
more than 5 years past the original fix and so while I would have been
open to this change in 2021, or maybe even early 2022, it's just too
late at this point.

--=20
Tom

--uOwr2ZMfyUBXpY+M
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibPxAAKCRAr4qD1Cr/k
CvXJAP0RB4hddB/rG6+SfvOMpb9iED97+SZyyfT+9FrZNONfPgD+MIFNNXB6aYQY
/0RrtK+c8YNEvLT2OeadokMb9yIbVwk=
=09F6
-----END PGP SIGNATURE-----

--uOwr2ZMfyUBXpY+M--
