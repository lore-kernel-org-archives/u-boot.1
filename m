Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B7F5C3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 20:35:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECAD1826AA;
	Mon, 12 May 2025 22:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lCTvSAOY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E501580584; Mon, 12 May 2025 22:35:10 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F1D6826AA
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 22:35:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3f6dccdcadaso3886306b6e.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747082105; x=1747686905; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nj1NC4QZyKThxtAjGsRr+GcUK09cRIFDSg/HV6eIeho=;
 b=lCTvSAOYbM7P2bOlO1V8govLIUy5VByhqZyPVr1TKX7j2ZLniVsyneXRDN6HJlFOzm
 24mim+B9hozQeAQWhI1CbAciPkw+Vc0zIy3mujVe2AhV5PlFTDL0Qb4hHC3p0RfBmpYp
 jXq4hgeJ8X/dUZkwiyfQXpuzEN4bSE8r/K8SE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747082105; x=1747686905;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nj1NC4QZyKThxtAjGsRr+GcUK09cRIFDSg/HV6eIeho=;
 b=PQ5/oH5Ju0Qjr1hbbHxWXd5KhOepwoAZZ2YlPsmTrjFnSPImxlYbLwa9b4HpiI9taF
 NWk9HDw1/hNuJxkgdaK4Lz+6EByiRbCn5CsIvA+Vhaez6HTnbd80dytFLxmhfh5hSZB/
 2SkdLi6UxUTBotLKIfY9BmIP6w1rV0EW0lH5MJ61wnpG6jFat8AwjXH0WrKBIyqNZg5e
 xlNfNeowDkGf5mMsYjlMUn0Tbl+N+nykxkOokeKRYFVBiCKJet3OOAQXH/KpuR/gpDS8
 5Uoe5Y3L+g24D1R8hvck2BomkLKyW/ouSDucYLLfbLg1Cd54qXsugmNdh2LZ/fZJ4N1Q
 fHNw==
X-Gm-Message-State: AOJu0YywlWza/hmFsvUd/cBjo62zs31yFaMxlgoNQCJMgCxkjPvkGiAC
 wMcSHulmrtPtBuopnP0T0gz1pVT6ualm754OZxghtkHb2iM1Neo0StQYmDygCedsOKL+B+ezJfA
 mX50=
X-Gm-Gg: ASbGncs/Byw0VLcvZsBASJIjloSXPdG3RIng6YZ06o7hS8FsTiNyW15ufpfJUGSv7ck
 Ei8xN1PKepe2c69yphItfsnSajfkJEP10TB/YdgeTq+J0T8HxM/pse132aHQdI+0SXPaYvzK8NA
 0n5TRI/5B3qydMD36wP1SW2r8MH3ZTth9wky31eUWNk+9fd5QJ6i6c8kShRFmDLyQgq+GY5rgPZ
 2U7utv/ABJGpbfCdft4r0aEVULQJonByx3URzBhF889po128HhYXH4cQoWj44XxoPttNaz7VFw9
 vlSWuGKRybcvqi5xR6Hs/SfJ/7iqK21GXBrE1yvg7abqHoFMaXgzUpnqCK3+oZk6RCkg+u71KVv
 N+yrlLup2b8e6
X-Google-Smtp-Source: AGHT+IHeuKszuJ2l/4vdCubO1lWpPRmn0+lWaJ/uvVORHkwwvR94WfnYeyKR+8RnoMIJcd/n+12Rdg==
X-Received: by 2002:a05:6808:1392:b0:403:3195:58cb with SMTP id
 5614622812f47-4037fe6e33emr9227286b6e.28.1747082104979; 
 Mon, 12 May 2025 13:35:04 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40380389220sm1708187b6e.37.2025.05.12.13.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 13:35:03 -0700 (PDT)
Date: Mon, 12 May 2025 14:35:01 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.07-rc2 released
Message-ID: <20250512203501.GR603748@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g85B1L6vBMShn6Nd"
Content-Disposition: inline
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


--g85B1L6vBMShn6Nd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

So it's release day and I have tagged and pushed things out. As it's
-rc2 I've now also updated the next branch and so we should focus on
fixes for master rather than new features. I tried looking over the
patchwork queue as a whole last week and so I picked out a few
outstanding patches that I had assigned to others but that had been
reviewed and looked reasonable.

We're continuing with a community meeting following the release and is
the same time as the previous meeting. The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
May 13th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D1307528552322&hs=3D1

In terms of a changelog,=20
git log --merges v2025.07-rc1..v2025.07-rc2
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

I continue to plan to do an rc release every two weeks and the final
release will be 07 July 2025.

Thanks all!

--=20
Tom

--g85B1L6vBMShn6Nd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgiW3UACgkQFHw5/5Y0
tywaBwv+Im4k2Zjarjw5HQxABa24N3y26RgjO5BpjEV/UPJuD1ZRzg3mlMgda8AI
Aj/cREAgudcBxtN5PPQF471o81oozMYjbg3wD/+J8VP1KAswINtznoeYKosTkNHg
0zPush9eD0/XqfDCf8f48Rl4WleSdE1pOLWZc/b+BQ/CrYVNePdMZHvOX35c/utS
gAgYiZpJQpLnGOt3yL84+yUNN5Wms1e3HyVR3FNOYY71d78pitL/+kAnuuU86+TQ
yAnzeibnZTxCt4d6AYEpVueYaRb7KSK5VOzEJKlgL9cNsx1IgCUs2OX5Z8JK3Lzr
SqRQVNSbzpVO7LT1sRlkp6syN0eW0cXpZiEwWk91niqVuS86ibSGniNeXBkJlycb
nk8NSt5Fd8pUbDDg2mHIubXe5SXmae70KP5PCGj8tEhkDatIlPFtuZXiwxVkJmg+
+ZZno8GYz5hhWu/MYnTLq3XMog1bHA2PLvsqTfd9t6ko5bTLERk+0i7IMdP5jbKD
7sLAkyJb
=rdQV
-----END PGP SIGNATURE-----

--g85B1L6vBMShn6Nd--
