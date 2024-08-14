Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F73C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 570C6889B8;
	Wed, 14 Aug 2024 16:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qeBVR0Cf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DAE889BA; Wed, 14 Aug 2024 16:12:47 +0200 (CEST)
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com
 [IPv6:2001:4860:4864:20::2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14985889A2
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:12:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-2689e7a941fso4448863fac.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723644764; x=1724249564; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JPDWEKrFOal2t7v2l+MHm5fc71rA1gvGwR3BYksNDAI=;
 b=qeBVR0Cf4ni/4H+hf3fJnsZ/TemFVJ6BDvSKCN2TP7f5ID4Vs8LAsKUCQ9+abZUejY
 /xvOyWEol/mmPbH/jjjULzDcirMs57ki49tXjPLBcelF0oyyuexTlMaOjd+5+HsNFq3H
 QdpFEG1pcqAXGwOY3SSuepkRlwiY3zpdobm/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723644764; x=1724249564;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPDWEKrFOal2t7v2l+MHm5fc71rA1gvGwR3BYksNDAI=;
 b=EopTK8Lnzde2pA94Nq15gs+2IKNgiMmAs6Ri8u6CQnEm+XgefZIRyakdfuMwYS7QDn
 OL9oXDCf3mlI8S52xhtMAckvroz44tya1Qw3kcovCpfZPEG/rAtB9Q/roOFP6UTG0bUD
 YzC+a9X3MWtsyP7/YKBTXTeIGszjsKnxpD1mrN3JJT5Sv1PHXXRzAKMYabs+Axi+QIvT
 le7mnSdLEaNcRX/0ogCP5SU8bMFiEORSWIPbYyQ8MDGl83L08i+MMi68ps7Z3DB6E4KT
 9gFRptvL485zBvcmH4yqRUwGH9mZcNtTHlHDU88wtMOUzyhHZRC0adb39N9cLT38p5It
 xr9w==
X-Gm-Message-State: AOJu0Yx4+g+ibAlRZcbiZ2n+iOwZL7br84m1h6rguG+U6icc9tQQAgK/
 RPJKLWG/1rBDShd3IFW8FjULVItPllstU9uz/vZirN1rwM2fWXmHpqG9yIAtX/4=
X-Google-Smtp-Source: AGHT+IH4uefWlqUfCX2hk6cGiG2rGye9+mrIdPui2BMGPgCwF3nujCukbdgTR0TWwLMnnEBdt7AGEA==
X-Received: by 2002:a05:6871:4d2:b0:260:e611:c09 with SMTP id
 586e51a60fabf-26fe5c5d1eemr3629023fac.47.1723644763760; 
 Wed, 14 Aug 2024 07:12:43 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-26c722ae118sm2931930fac.40.2024.08.14.07.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 07:12:43 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:12:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [GIT PULL] Please pull u-boot-imx-master-20240813
Message-ID: <20240814141241.GL1626301@bill-the-cat>
References: <20240813135445.396224-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Xm9kG5NqDXY57SxW"
Content-Disposition: inline
In-Reply-To: <20240813135445.396224-1-festevam@gmail.com>
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


--Xm9kG5NqDXY57SxW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 10:54:45AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx/master, thanks.
>=20
> The following changes since commit 06dceeba3d4515ccfbe37b8989ee047a7628ae=
e3:
>=20
>   Merge tag 'u-boot-rockchip-20240812' of https://source.denx.de/u-boot/c=
ustodians/u-boot-rockchip (2024-08-12 07:58:24 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240813
>=20
> for you to fetch changes up to 72801d9971d09734f17056fd4836604d4ffd275f:
>=20
>   tqma6: Do not print the board name twice (2024-08-13 09:31:35 -0300)
>=20
> u-boot-imx-master-20240813

Applied to u-boot/master, thanks!

--=20
Tom

--Xm9kG5NqDXY57SxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma8u1kACgkQFHw5/5Y0
tywmPAwAlpNbkNxZwwpf4nTrGwe/m7cCiFOuRu8UMjGTOuJmJBCrmelzBCvsY9ZE
07tUAszUAXIvJGQffX3UO06Eyw5p+1bVEQhpjTI8JRIAov4L2iz2SWQH1q3WVSiM
9ok0EG8t0QeTMW6vGQUi8ypOFHMOFSZVsNH+RLax7nLnITU1QildGPU1L5UzQzKa
7zIKungbOyCwlZDaTp+ex7SmHypybrjqzsJ9euOiH47tP6/wDjsfbiHTlnPayVes
TuWmQsWAYjTA2r1YkN6l24dXzBzMINqsdmo/mnZaulu0hRlU/DOcnVbOXPcnv6Qg
JMjbqyI77jKKhi5oVj1jHOBDKCuu/03y2PYxgyLFaY2cS+MOcN6Jwn85nDokIo5a
WjyE87yPWV7UpShCMgogn4xGmlKGMWpwUC+tCqdKXzr2yrBqmoZiZdmk+xyB2sbw
s/X+PHWrIZMWW139L1cX+uigHLhxCw6kR0/SN7sCp1Q7XRVz8iAAl/fj/sPnSAFZ
HlHhB6Bw
=Zc/N
-----END PGP SIGNATURE-----

--Xm9kG5NqDXY57SxW--
