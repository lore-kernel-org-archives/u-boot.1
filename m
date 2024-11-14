Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC459D68B2D
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 14:58:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A31789620;
	Thu, 14 Nov 2024 15:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qAY63zgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1DF289627; Thu, 14 Nov 2024 15:58:57 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D421589616
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 15:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-71a6b13bbceso283164a34.1
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 06:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731596334; x=1732201134; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Vsaei0R3yXJCQSULT6c+AOfC4/i7QO/X0e2mXzQVIMk=;
 b=qAY63zgnPQWihqSnRG8ZMK405g7Sv4sgy09whiCSZ3S9Nhh29ZsXksW0r0bSQBnwpq
 SE09dq/thHCFShpSPTs5hLlqggOOttimMh5OOT6dcJhA7m6dO+GTqMeqRPn8+ZxDOLan
 4iW0fOP5fJmMP7On/FPCWcUODpPPoRxIo0DqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731596334; x=1732201134;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vsaei0R3yXJCQSULT6c+AOfC4/i7QO/X0e2mXzQVIMk=;
 b=FFii7/TIaWRsrP8LYiN+f6eG852DPoArumh32ZfiLNFJiiSU7co/ksKr6rF7ZW1MW8
 vhraXChuNakcJMXpBiHWlf+NdluCZFE5QDxHWC8P+OCv09H8HQYK2lDRcIgqt/XT82VW
 g1A85ZkFe7ISQDI7+RAZ5TUwe5cDlQzumJoUD3Wg1qwad4izZYJKali5DBw+/gAeCAjm
 vovFBVSdXN+0Zkv7GpWqjB2TUC3oqaWFMNegmIKV7a/I3MKAjb2t0lyqcBUPpLaFun7l
 ho+XMKl71jJsCY6kGo8DRWG5yirGZU8yaoLfjtjknYGNpIAjL1l9o3TGaNfFd3Qk8nsf
 6yTg==
X-Gm-Message-State: AOJu0YwHOVD5EOKEhV7m+g6crXY77Ws3y6LL529Y4M/45bjT0FdzVDu/
 bdxHOAW5UxB/Bdua+pLksPuRa9WIjtYmQ7FgGT1ub0SCZRswmlmP0zOuZCHHMTM=
X-Google-Smtp-Source: AGHT+IGHy5XpJPJuFB7W2Bec5iKRBcJE2iI13lFzEVBikKgET5CqdnUx4+97E++Vq6v93eag2lFBcw==
X-Received: by 2002:a05:6830:600b:b0:715:10d4:b06e with SMTP id
 46e09a7af769-71a6e44964cmr2791012a34.9.1731596334578; 
 Thu, 14 Nov 2024 06:58:54 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71a6eb451d4sm411725a34.45.2024.11.14.06.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 06:58:53 -0800 (PST)
Date: Thu, 14 Nov 2024 08:58:51 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: replace invalid GPL-2.0+ SPDX identifier
Message-ID: <20241114145851.GG3600562@bill-the-cat>
References: <20241114103501.10014-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LDAIE+jgBsseZz/8"
Content-Disposition: inline
In-Reply-To: <20241114103501.10014-1-heinrich.schuchardt@canonical.com>
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


--LDAIE+jgBsseZz/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 11:34:59AM +0100, Heinrich Schuchardt wrote:

> GPL-2.0-or-later is the correct spelling of the SPDX specifier.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

I would reword this to say that GPL-2.0-or-later is the now accepted
SPDX tag for this license and that GPL-2.0+ has been deprecated for some
time. And please follow-up with a checkpatch.pl patch to ERROR on using
the old and not new license. All that said, if you can do the commit
message I can update everything excluding upstream dts files in one go.
Thanks!

--=20
Tom

--LDAIE+jgBsseZz/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc2ECsACgkQFHw5/5Y0
tyx7KQv+LCzaVt1smLeS7aCWuC7F7RHW/WAtoWMb/tD4ocNJ9Mw+pPxErHfoIv5E
SdW8pg7PxonwPxMfTLq9HiVFb2JhLLC/A2Lv+e2ge+kA9GS/dYPOkmBSX+ockb2/
ntGzRrqej4vxIq73KOVVkzd/cpZBYkgRFd9TRa6dzHRKUyhi4MIRmBHTZHpCP2HL
HtF+BOl1DP8/ibFR/IlkSoBemhNj77bocaozhYmVP0gS24hGCdMHZ5bMU4igSBVS
vURNMqHBac/uPEBM7Gev+p8gg6GNzVbqDz03qBDphw96upWDrCvWWUD4F9j0OzKo
KS9vPJmvO6hbF4GiqWiaZg81GK93bi2l3uzqp384OEC3WYPId1QGSTSZfcvXVUIV
oipMvL/Z1DJCwCTLG/I+HpuCiB1lnj1PCxWErL/Wmd8MO2k5jbmCKtlr4LQnlXz1
r1sNn530OfGWL6xMQwVn56p279Kckwqd7OdazrfQ2AHpSiXiTKdIk/sYvp7kZ2jU
DKRcJkM5
=ceqJ
-----END PGP SIGNATURE-----

--LDAIE+jgBsseZz/8--
