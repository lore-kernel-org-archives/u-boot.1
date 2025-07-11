Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E05C83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:45:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F47826AA;
	Fri, 11 Jul 2025 17:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nxQy8ivc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 613F48277D; Fri, 11 Jul 2025 17:45:37 +0200 (CEST)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0283282063
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-40669fd81b5so1384318b6e.1
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752248734; x=1752853534; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DA67vjnYR5H/s89re/v807JiAF07+DOxclZdf/SzjZA=;
 b=nxQy8ivcfo+nSEW0rUg/svEfXd0hgzcwzyCP2VB9mMMpHXKA2mv90gZTS/w6WvrJVX
 vhYrZ30kXkQTKdGB0GQnjhSaSjs98LcL+yiqXMgAt2nyYVNTucA75uz3RjSI8GNEPNRF
 RNxDEvCBGZ1izo0bjCEmpcfsbQ7HAh9d+Xp+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752248734; x=1752853534;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DA67vjnYR5H/s89re/v807JiAF07+DOxclZdf/SzjZA=;
 b=Vzvv0GrDBH55SjSnE7Eh8zkmTLjmtGvxxSGICIpvYFiAWQTij7CzrOFFPY2mNWzR/v
 kvmJtRvyxT4/hS4F7eqpVuBU4aCPNGunBOle6gGGxowug/1+5VFh6sQ92vVdiUE7NPnE
 n/ZY1NgkFumSGA2nGm7PJxZTDv2HV7JdGQC3nk6al2P73c6u7927ppq3jT7z6eKYz7Zm
 F44/xb8zU85fz94jQH2GMNnQrST55eVT3F45FL3izw9d6Y4td8p6maNnIFJ0oCo4CbV0
 Bf+uCDQOlfPylPOhZbUN/UFGcyPaQMK9Z7/9zGqRu9MF/ltborw5fb6yuDb5DLG3kRke
 Y30g==
X-Gm-Message-State: AOJu0YxHHoXMSdmmBzj1Od1E2CpRHR1W7rz137nwLrVNjtYBAr6Uow/w
 1GkrZ4Xcs2zibEt2GB70nyUvRoGI3KIbP2fbTfyMZxettJBZha9tR/W8Wiuu8UOxvys=
X-Gm-Gg: ASbGncso7nM/MMwcOTQfaBPatb87JdmR5tjqPR4tYcD4RuapJH+PXdXrnxqJV443Sxw
 fTIskgANIHnTA07fRoC0dJHjtIXQx54L2hwHgM1N6Pc8ZGFK2NStK08Zm1CeUdpQ6OO33VUuyEb
 FmeeQOqU7vm1gv9UUrKjc4aaiTifvhKClr+yWOLM+PWrL1XSQQfomNP+RNS/ZQQn5MiMXRZ8UGl
 o1Y94JJPeiyu106Geq8AzoUDVV4tbvC2ygC8BjdzD8CTxgHE19HiR+JJ5xxJi81m5FTN4daiueS
 JJtsZL1wajO/8Ak0r1WTXRtNoOfxyQHOEuGUJCF17CjZWYkPbd3WEKzPqafibvK4IYATvgHBmpk
 nCgyNWPoInIswURIwUlPP3g9cjSOLb5flDqzZkJadH61YrRe4j3+znN8Q
X-Google-Smtp-Source: AGHT+IFm14Ytlc578gANt+WykVlzcAUt9AeiPg4rKoxwvWMtZt8E1ygXU6tXKPNBoJon5LpnIv/zcQ==
X-Received: by 2002:a05:6808:10d2:b0:409:f8e:72a8 with SMTP id
 5614622812f47-415393d5d13mr2292546b6e.23.1752248733649; 
 Fri, 11 Jul 2025 08:45:33 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4141c58ff73sm574968b6e.40.2025.07.11.08.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:45:33 -0700 (PDT)
Date: Fri, 11 Jul 2025 09:45:30 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, venkatesh.abbarapu@amd.com,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Levi Yun <yeoreum.yun@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Harrison Mutai <harrison.mutai@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v2 6/6] fdtdec: apply DT overlays from bloblist
Message-ID: <20250711154530.GH6424@bill-the-cat>
References: <20250704134208.2895595-1-raymond.mao@linaro.org>
 <20250704134208.2895595-7-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ja17ftSAkpuPhBxe"
Content-Disposition: inline
In-Reply-To: <20250704134208.2895595-7-raymond.mao@linaro.org>
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


--ja17ftSAkpuPhBxe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2025 at 06:42:05AM -0700, Raymond Mao wrote:

> During FDT setup, apply all existing DT overlays from the bloblist
> to the base FDT if bloblist is being used for handoff from previous
> boot stage.
> According to the spec update for DT overlay handoff[1], an overlay
> must have the same top-level compatible string as its target base
> DT has.
> Before applying the DTO, it checks whether sufficient space is
> reserved in the base FDT region. A margin (0x400) is used during
> estimating the space size required by the merged DT.
> A resizing happens if the reserved space is insufficient.
> After all overlays are applied, it resizes to the actual size of the
> merged DT.
> Note that the margin (0x400) is arbitrary from experience, it might
> not cover all possible scenarios as complex overlays with many
> properties might require extra spaces and lead to FDT_ERR_NOSPACE
> error.
>=20
> [1] Add Transfer Entry for Devicetree Overlay
> https://github.com/FirmwareHandoff/firmware_handoff/pull/74
[snip]
> +	actual_size =3D fdt_totalsize(*blob);
> +	/* Add margin for extra size growth after merging */
> +	new_fdt_size =3D fdt_totalsize(live_fdt) + actual_size + 0x400;

This is still a fixed value and still not the right way to handle it. I
think now that we expose configuring the amount of extra space we have
for the tree it should possibly even just fail out with an error message
that points to SYS_FDT_PAD?

--=20
Tom

--ja17ftSAkpuPhBxe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhxMZcACgkQFHw5/5Y0
tyxcXgv/UMFbeziNV2GlKDOSAXsmyqahMeqsc/QbdH+HEpQXaiZs7NsyjfV9+EbK
NxvI2G6+lhRYcqi9tPNk+7Gdg5JwqXZwH2fwddnDbMG2r2tffCXc+PHM0VLu53+E
JYTqmaunA0vt92zcFtmRz8BUhQYBLr9pIg6KIQ/UzrXJpyAfC9ShdKueK8KRMR5f
FkHK7eT12bHYJW4i8mKIFBnz+tMIv9Qi2wnOBoi7NZG6qwlHQTcQNQxJ25FcOnmU
AiogV8qrYb2KrCBGjupiJPDiKYe94hkKef/gseXGKHgxAgpFnOcO3GNbzyieuMrp
hBPpe+V5h0zyMSaJerIEDmBD+C/cSvLTkAKmoFKjA5ndQrhTCpZO4oob4ZkUCO7S
f38mddjv1si5Ce0BMjEnPe9EsErJK4c4Mvc/Oz18G1bNFV1ZQUE7yq0D1W8iY52Z
KSfUlQ6D7C+MUXrnPz28BllI9EunuLxj/MsI26GBjGRJf3NsJ0ESZ2Ln5z+wFPe9
LyiyZ4tk
=MLB4
-----END PGP SIGNATURE-----

--ja17ftSAkpuPhBxe--
