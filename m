Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0DE5CAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 22:43:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E86EA83071;
	Tue, 30 Sep 2025 00:43:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sf2Lwx0c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D0F5832DA; Tue, 30 Sep 2025 00:43:43 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F297807B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 00:43:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-74526ca7a46so2023048a34.2
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 15:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759185820; x=1759790620; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5rBg8iR80JgndmnchDrpeaYKO81U0Hp3sBIGkyrNz6E=;
 b=Sf2Lwx0ctyH8VVtjjp+BhuaTklqE86ujGw1WABLBgwGqf+TjM9z9LFqwE0lB7wAFXR
 PfpceUcPj1ZUn8GKTDi0B+H5Nvuz2a6UBJAMdWt0yblCE06OMxaYgCvGH1pzybrMq6Wm
 DERNFjUDU0A/iDCVDpf5bEMDB4oGak++k+Tss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759185820; x=1759790620;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5rBg8iR80JgndmnchDrpeaYKO81U0Hp3sBIGkyrNz6E=;
 b=O2Pugjd3rGNI21CoDWN0TwwkikeW75J5lcR+OuRplFPpoAaqTY837gvXfyS5v1Wvkw
 9l0SBx/2kzCbBBGXrIzi0+X7c5H0MugcpOHrlc93cY33SyrIKUS3KyBPO+8HgeNMLXGT
 uUxQjmmVMuyTX2kh5JJWq1/geR76HAA7eaaBN7Pv8VpfvTST0Pte4OScmTXmOEa/udWf
 zjkzYVG2chK5YUeFX0Wu0AjJKDkM55UQ01wMrv+GRAGhInsIXMSKWfgYYj4hGcyQKgqx
 9trN75Ojey8fR9fKyaCIFGp41dPcQ7Y+CSVxYq970HVztvXifobDWI405UVFEBPIQXW8
 28Ug==
X-Gm-Message-State: AOJu0YyIW6QYYv422DQdiVJagMPYkf77UCr0rQTfBJmsrn8ekZFFEnvP
 qa4A7RiogiSo4B27s7TQvJxU89tlZsicpGrfqBSiwrpFbkdRilsLd7JNzt1jFarKECbiLVQ8OtN
 DbfNzw4k=
X-Gm-Gg: ASbGncvwo8A7wZ+w+8YWowP/ZmV0zwPHRLHL0ofHFQzIkI1Tqq6AylGHpAupYGfco2S
 H3T/qc2r0zcckn0yCpo5VjlGQgWebjntIUUaMSTUPnH2E2hozYQNHA7wNpTb3summxgAWRx/mbo
 L4iwZwwckoHwUbUd6pBiPtMdPIw1cOi7an38HxJ7wdyNcXzZl3IQ4AGNIXytSqKDOsKnCYoUmrr
 i8uAemyltXwy8cgexrxMK/Qk2jVsSXPvKY4ufLDN/nefwfBi/sLA93URMDT2x+rDNxhRGqhWl+x
 IyLyJgyGJrGJS2g+HY1shP8sYo2YePl1fcEuQ224oHjh2EHzWLOEgHbe5hZJpH+En6ovjYWHxUJ
 hRsHQtJujZGOdXjc2V/7a/Ao+7FELtx9miTCJ/JhrANuXSTiEawmGZ+T9
X-Google-Smtp-Source: AGHT+IEzACS2ltiPAZsUwDDiDaxlkNew/lZEa9/0n0WTmWqEXvWtaz0prMkJu5Z9G5Ihb5BT7P8PSA==
X-Received: by 2002:a9d:554e:0:b0:7aa:6d76:fd65 with SMTP id
 46e09a7af769-7aa6d770139mr5579296a34.23.1759185820136; 
 Mon, 29 Sep 2025 15:43:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7acd75cae90sm2019358a34.36.2025.09.29.15.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 15:43:39 -0700 (PDT)
Date: Mon, 29 Sep 2025 16:43:36 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>,
 Mathew McBride <matt@traverse.com.au>
Subject: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250929224336.GS6093@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K0HhykDavSrWUbYI"
Content-Disposition: inline
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


--K0HhykDavSrWUbYI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As part of working on "allyesconfig" support I ran into the following
problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
implement support for the VSC8584 PHY. The vitesse.c driver is much
older and only had VSC8584 support added for a specific Freescale
Layerscape platform whereas mscc.c is modern and been updated with
newer PHYs as well. And we need one driver to support this phy, not two.
I am inclined to remove support from vitesse.c. However, only 4
platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.

I'm cc'ing all of the board maintainers (other than PowerPC platforms)
that use PHY_VITESEE today to see what their feedback is on which way to
go here. I'm ignoring PowerPC because that can just stay on the
PHY_VITESSE driver based on timing of changes in git log.

--=20
Tom

--K0HhykDavSrWUbYI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNsLlAAKCRAr4qD1Cr/k
CnQxAQCIOlHA7HMPBxkqYBot7KR1nFUv3Pd7WzNI5324AdRBywD+JyuU9ebQIGfK
vsTrHFpZ92wga2vHdkeytjJZy0lN5Ao=
=wgiG
-----END PGP SIGNATURE-----

--K0HhykDavSrWUbYI--
