Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FDAE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 22:09:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80EE48979C;
	Mon,  9 Dec 2024 23:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Or+wNwRi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 024FE897A3; Mon,  9 Dec 2024 23:09:56 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4F00A89798
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 23:09:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4675feed835so14233671cf.1
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 14:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733782192; x=1734386992; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PAOR3JYJw/c84Vykg4xfjHz0FExS4WCVxIDjyI6btws=;
 b=Or+wNwRiHfslfAsoWS95V9usF1a6aYcKRqw/8OccruULZxxtpiAoPo4Yr9Duss2KEZ
 NabUPZp2HTeNZMiYVSqMyS48qk5RhEo7S3B0XbL3dyRambkQ+3/8yoV3U9jfqwqHbx0j
 A2+JMXMuCO8DgDbdEFeuQ9o0eyOHSqfTMp+W4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733782192; x=1734386992;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PAOR3JYJw/c84Vykg4xfjHz0FExS4WCVxIDjyI6btws=;
 b=H2v+UwYdjlMBBWiJUsnt1TfhriwklTenBLFuFQd5/hpA5IYYsNP0v6tY6fU3Y4bcIx
 S9MOG8zRdAtZieErywXZPY5aCRA25YniSqmvoPnP3masIKYgBT4IJ+XzWsW2YpueAylv
 saf6HZAYHIhoGcHa2m+PRNF5G4Bv1Lan6dFGNfRSEDB1aP5qZhyjYIkZNBumWaZ/g50M
 fwLWirN+/4SFJwU0NEpKNDndNWmzajiDujsse9lfbQc4GcaeXHi+602yOfRCEE1XAWOA
 QNdhvTM8+M/besrNP6ViSWvDgPprh/cqvA8hvjfpcQP+PjFjO0DbaWHjrHo5MQuC0kwT
 tVwA==
X-Gm-Message-State: AOJu0YwrCoLubZQ00AGx6J6QHqSqiY9tGOqOl/cfYKUkpT+ZCyakim0k
 BgAcPAsNtj5HbVdtEVQ64JVlT106uo5q5T7qhSzzY7dTsFlIx4W2Dn6hbdcDKvGyfrar97A3Mkg
 p4MQ=
X-Gm-Gg: ASbGnct0zTrR/CfgqfxUpNvCWWc97vTmqwDFHgi615rqedICig0lZfgJuRGPI5SegDF
 KmLfRvl4mDXFEwjff9fF+h7+O1lB36wYZ1THS7v2RBLOw7mSlETgfVaqTvqVglGNNSLlOJx/cIa
 1/f673+2DILnKY9dhK8drIujdZLUcvrQE3ELGSP2hn45ONlbkAX3g9kLejNaX8ZB7kU4fjCWMHM
 aM3l+uhrH5Icpc8aiRs4LxPTQUgrzIAqdfl/ZcDbYBocR7XEmXk
X-Google-Smtp-Source: AGHT+IGp11GY2xcGCKYNsZMpoa6PfyP+Lg8r/P7Qz3rTu1daTRH/DRFrl0yaLxrqtpR/yuQaTDqBdw==
X-Received: by 2002:a05:622a:5d3:b0:467:681c:425c with SMTP id
 d75a77b69052e-46771eaf019mr34993221cf.1.1733782192048; 
 Mon, 09 Dec 2024 14:09:52 -0800 (PST)
Received: from bill-the-cat ([187.144.7.203]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467557cd7desm25183591cf.27.2024.12.09.14.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 14:09:51 -0800 (PST)
Date: Mon, 9 Dec 2024 16:09:48 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.01-rc4 released
Message-ID: <20241209220948.GY2457179@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qG3fYUqEm1mwNIoy"
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


--qG3fYUqEm1mwNIoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Once again it's release day and so here's v2025.01-rc4 and I'll update
the -next branch soon.

Right now, in terms of regressions I'm tracking there's the Tegra
related PMIC issue that Svyatoslav is working on, and seemingly still
some SPI related issue that we need a hopefully "simple" patch for, so
that we can unbreak platforms that worked previously. Otherwise we might
have to revert a bunch of those changes at this point and try again next
release.

In terms of a changelog,=20
git log --merges v2025.01-rc3..v2025.01-rc4
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

At this point we have two more rc releases to go, one on the 23rd and
one on the 30th, with the final release on the 6th of January, 2025.

Thanks all!

--=20
Tom

--qG3fYUqEm1mwNIoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdXaqwACgkQFHw5/5Y0
tywT0gv9GQpGbYhRQwDlRtcc2pMp6iT431M+x2xa/YXhht6s0smtXX5DLig4JOGR
3HzKPKtIwlmxCqBRT5cRrBGastX9Wj0WImIUdd2qK6ZPP0tT25ftG3fHa9gQUPZs
+OrvEVLPoaok7PKK0LL7y4Gv/dKKMR2PKRBq12ndahlPfJZQgXNf4pvau9JZ9T5a
WaK7yld2Sko2gdJmuSnIma436XOVBacwCB2lodFPbzZF9uygWhJHfGzuNX+wWXbB
ZIU2/lhxTUPTfgykz0P+UHUUPdMpsdqKqHwqqrqhAjiiybEeByigjMCnSLGYwN4p
Vor19lajfvnr2Dr9BVgBO2HwEuIliLyyszmueY4RxeArf25fJW439BIyzLWvdkoH
Gr5dIeyjIUlsSLT+XXi/26cFKMFJH9vP/qWEg59crgekHSBrMy/J1bwDEqGzzlMd
UWY07ksAjwvhnVU3snHuDfB2nb2DUWwpeUvh2t28YyGwmoRFAAy+Od02V4K0eei6
fVAZdrSV
=VQyM
-----END PGP SIGNATURE-----

--qG3fYUqEm1mwNIoy--
