Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0E6C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 17:21:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C610809D4;
	Wed, 22 Jan 2025 18:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X3Sfa/x0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B154D80A09; Wed, 22 Jan 2025 18:21:11 +0100 (CET)
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com
 [IPv6:2607:f8b0:4864:20::736])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B35B809D2
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 18:21:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x736.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so108200685a.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 09:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737566468; x=1738171268; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/uECq/wrZ5blI9tIriWhtvilzCgGmXvoRVaPCnzR7+E=;
 b=X3Sfa/x0Q2rtmlmz80g3uQQ2qFc/yBC2/JL5QfROsg4CqPx+FfUkVY76aSyL1KbB5n
 r9zmCG7h/2z8ffCr7iDZPbzey4SKTk31FjpMNe8Khy5w84nAs2rejusaVaTalmwsfchN
 wf7P8uZEIeAwXUf4Jtbn1B3CCPd1Ll52Ay/28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737566468; x=1738171268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/uECq/wrZ5blI9tIriWhtvilzCgGmXvoRVaPCnzR7+E=;
 b=umoAPPpFqODia7I9yxDga2g0GQ+rvf70jODdPmSG1P9vIPzYa2WiNGntETVPEVTlC4
 tz7KU7zBattgsvHsLgOfjZQ4utxgIgIOXuIGZO9t2b/60iIN+7kL8uSWsHagm0jJspRf
 gLaMBxGRuX1dE9B3bB51T8V5hKum2O9LshFMgrFJwhhY+gL85N/N4+eHF493S4rrlN5N
 YQhgODL/bsiCwCgF5/cVI5LjDfeBPdeLseabRmJhlPN6jRpYSKaG0ieKTGrFfFfZW9WW
 nFYFe5sXqKJwWbVhRayKrhQem8D3TEZhgbnYSoF6ANIt1E1k5+MVWc2PNBZc9MCRPpsv
 FAiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuQGd8eSNqRZ7MUGRacq9DwdElqkNAbkbUK9PbaeGNrAppxD/i+NgEAPyrlk88gzhUoGK1IFA=@lists.denx.de
X-Gm-Message-State: AOJu0Yzs4F6T0zmnHag0YzPMmyBmhczoUqLG9b25CxzkdzT/Qx1rqQFK
 jZr1PiAfZLh+iE47vOZhFB13Bme5QDDDKCPR0GyAuapEo+2WcZZVSnkgMqv1uB4=
X-Gm-Gg: ASbGncuMlxIa/7eO/NkLOL4yh1ezWiDkbu8IRoUM66EqssIMzdZnU2Smpvd/R3t6xiX
 TmTJlHTYPAgSt5TJbHWipiqMC9XofXKP905sto5UQwveOdJdtTjeRaBBqbUiG+2dYvz5lvDK7i1
 4HbHUUh00aVbSFcYtfyinRmxFLaVaP8kIGkh/0/ntW584XovemkP41BNpANwrzNygtTd9Ny+xil
 zYY1UOvNfw/4NuRjaDj5xWTjHq0rApZ4D2LaKxKI51y5nBBTslhrVVS3K1zFE/Nd8c=
X-Google-Smtp-Source: AGHT+IG2/TweTRYDmImwpsPTkTEIDCvxIICB42Ewg0+LevF5qSF0n02JXh9Lr/ANLy9sbs0IaXz4OA==
X-Received: by 2002:a05:620a:24ce:b0:7b1:4a2a:9ae0 with SMTP id
 af79cd13be357-7be931ac872mr15888185a.9.1737566467958; 
 Wed, 22 Jan 2025 09:21:07 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be61487328sm681017185a.58.2025.01.22.09.21.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 09:21:06 -0800 (PST)
Date: Wed, 22 Jan 2025 11:21:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: nd@arm.com, andre.przywara@arm.com, manish.pandey2@arm.com,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 3/4] bloblist: add support for CONFIG_BLOBLIST_PASSAGE
Message-ID: <20250122172103.GA52306@bill-the-cat>
References: <20250115135209.13946-1-harrison.mutai@arm.com>
 <20250115135209.13946-4-harrison.mutai@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gPN7oRAIqLj3HQEp"
Content-Disposition: inline
In-Reply-To: <20250115135209.13946-4-harrison.mutai@arm.com>
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


--gPN7oRAIqLj3HQEp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 01:52:06PM +0000, Harrison Mutai wrote:

> When the configuration option CONFIG_BLOBLIST_PASSAGE is selected, the
> bloblist present in the incoming standard passage is utilised in-place.
> There is no need to specify the size of the bloblist as the system
> automatically detects it using the header information.
>=20
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>
> ---
>  common/Kconfig    | 8 +++++++-
>  common/bloblist.c | 5 ++++-
>  2 files changed, 11 insertions(+), 2 deletions(-)

This leads to failure to boot on qemu-arm-sbsa as seen in CI:
https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D10392&view=3Dl=
ogs&j=3Dac5e904b-a30c-5e1d-9570-462b8181c990&t=3D863544fb-ed04-5d34-fdac-10=
f5bbb057bd&l=3D423

--=20
Tom

--gPN7oRAIqLj3HQEp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeRKPgACgkQFHw5/5Y0
tyyCSQwAoFbFlii/iAEDPdd3uj9uP/+JYDJGgXY80zrt8SniGKuZ0xwByKI25F5L
us/94ajfq9O1BreB/cFLNW3CBBMiQACNRF5i1CknIH93Hin41Z4RiaJQupNU/wmt
D0AupLD7bqMdNYdzVnPb88Nrzuxre6Cr5UynL/BdThrTtQoM8PurSQOevlNxaXfD
nFOa2kk5FjYoYiuEQDzpo5c3yUf+ZZa+rBTzYqQzynio0yy2MsmMkatCUO9JB6JP
M/EVtUP0ZqyvHJ+wDFpDVlrZRL6iMgDcsx32eD4/KSaqzqZJUkbkBao0OdYejr3/
+hu7xT2Mg13Jg9YaUmX2mLBUOVFOLw3BdeMkuTXrqfJcFyc/bzIQeBkflxr3FPcz
RiWfZR4zeNSG4B5lHTKISNv034l75chmIaWDIYyTGMCmWnEsefAmY2rpYW9m1DmR
fxN8ZD9gA9jr5sAQjGdFhedjcEdx+6Hr4iVze/35N8XAu9GJ84DFukKSoRewKISW
qzOGojh+
=fP2O
-----END PGP SIGNATURE-----

--gPN7oRAIqLj3HQEp--
