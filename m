Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B19CD98CF
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 16:35:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 49BB5846D3;
	Fri, 12 Jun 2026 18:35:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QmBfBtGo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92CAE84704; Fri, 12 Jun 2026 18:35:18 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72AC7846B0
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 18:35:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-69e98c0516dso882277eaf.1
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 09:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781282115; x=1781886915; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PbT75Gw08w7d+mXJcQj8X/uwNtBFupuBO52kHOoAENs=;
 b=QmBfBtGoEI9DgdeGndOEYFnMHtQiot2OzPS920HgxN3dWkMbyOyH5l6djfPFkzAAVc
 WCOKbiLb4yk25SKi0IxjcryVBm+5AgjFbp96pqaftKYr+lL3cPkyObBCBQXjwkt4Hq/P
 CBtAiWarZzsZ03mNsd1C8m++XsR/FjD29l3rk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781282115; x=1781886915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PbT75Gw08w7d+mXJcQj8X/uwNtBFupuBO52kHOoAENs=;
 b=UWfnOGROtQaDaRWNAthBpdwaV6+slCeW+rzZpofDFWOAH8pabSgme0Lev2QYYAz0hM
 u/vQMimQnwYKic9EfxLd3uA8YOR0jxRs+1J0xPfn7fYIHeHy5y1gjvrkO7Fq0zi+Fan6
 fSLM3PqHWkfJTFXZZe95PenuR8MocYmfexHLa5MrWH6uVdGq8ND5N1wJhLrcDdLywhfy
 d96zvZVAutvSzzD6RbmSURNmQRB9SFyfOd4WB57GRwuQXdEw5fXPTrwNRBPcrtRYH3Om
 VL69+8UKhnYm1ZQXrLwyCe/7Q2Qhjyv+ccBNq/+AfXZ7LFzZ3SSfrGIAD0zJUgwFxN+Y
 OL8A==
X-Gm-Message-State: AOJu0YwND8KjMEoGH87f6UQQ2MNFloQV0UGJzRViWdvrFKkueYDypP08
 8H8q5lNArSaEXLCF7jdwZCn8qcqOWnpNM1MQZgzmpV5Q8/Te2fPHAkJsY9fVaMSfTGU=
X-Gm-Gg: Acq92OHeOxTsnPzj+OhpqJlOtDtA1Z73WEcBEXIKlSqXc8DI8144xIQmdDK2YkvJ8Ej
 4QjgG5Eiah4U18VgzZ3zD/ruegPl9fslAE71eseWhVu5AFZB8WR/x1Xnf7hPGNGeQ49hEohiUWc
 W6gX2pTeb46nVT4NUX8/CENOGA8rIzQ4WpajMCL9wR5odT4DUwAfaffqVt9k/QZZqpBG59N3Jc3
 2nOiDz4TZ459THvSFUJXDvtLAMZt7jiUDZs3LHtPfchVDFJgznSbuAEZNhSltVVMd+6kudgL8GD
 WhUybhiidxziXiVpuuhamz4KsldrCBAK/a2WZ7lWLlFfZbzm5kr02jtyxRG0EypAkc985MUCeOI
 C2WnCW/dOR6TYbEn6FlltJXKmusEqoxxJx9sYcybOzKjbrdOfdbNnh07THjGtHXSeKgvL9Cm85m
 2LmPb6gpcU8o7AehYVEfAJwsf/hiYb8L3RwyhQPp+WVx+QtUp57vajoJ9oh1uiQ99dNrqINtojy
 Xc/mrrrkFi49Gjq3XFn5CB4IK6Thc+14Dk3ecuTchUd9AHZ
X-Received: by 2002:a05:6820:4b01:b0:69e:5802:9674 with SMTP id
 006d021491bc7-69edc6281f6mr2200272eaf.21.1781282115061; 
 Fri, 12 Jun 2026 09:35:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-245.totalplay.net.
 [189.203.97.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-69ed8574ddfsm1967990eaf.14.2026.06.12.09.35.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 09:35:14 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:35:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Vladimir Kondratiev <vladimir.Kondratiev@mobileye.com>
Subject: Re: [PATCH v4 3/4] ufs: extend the current command-line interface
Message-ID: <20260612163512.GN382693@bill-the-cat>
References: <20260611-ufs_tool2-v4-0-a4de78bc2409@mobileye.com>
 <20260611-ufs_tool2-v4-3-a4de78bc2409@mobileye.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xaet8c0vVSvwbcNy"
Content-Disposition: inline
In-Reply-To: <20260611-ufs_tool2-v4-3-a4de78bc2409@mobileye.com>
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


--Xaet8c0vVSvwbcNy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 10:49:37AM +0300, Raz Ben Yehuda wrote:

>     Extend the ufs command line. Provide techniques for querying,
>     displaying, and modifying UFS device configuration and
>     descriptor information.
>=20
>     Features:
>     - Query and display Device, Geometry, Unit, Configuration, and Power
>       Descriptors
>     - Display LUN configuration and calculated capacities
>     - Modify LUN, Configuration, and Device Descriptor fields
>     - Query common UFS runtime flags
>     - Commit configuration changes or clear all LUN configurations
>     - Decode and format descriptor contents for easier debugging
>     - Clear all luns
>=20
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>  cmd/ufs.c | 1264 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 1257 insertions(+), 7 deletions(-)

It looks like my previous feedback still applies about integrating this
properly and so that it reads like other cmd files, among other things.
Also, make sure to mark functions as static when required.=20

--=20
Tom

--Xaet8c0vVSvwbcNy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaiw1QAAKCRAr4qD1Cr/k
Csh6AQCilzOPFXrbjBFRhOTgXfoucw0RfF8jUx7RkbbFN0lctQD/Sz9AXv9sMZth
vDBgRw6m+xli+qtbzSpf/KIiqtd3Yg0=
=pZ0l
-----END PGP SIGNATURE-----

--Xaet8c0vVSvwbcNy--
