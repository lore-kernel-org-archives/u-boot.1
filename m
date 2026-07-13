Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A2DC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 22:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 255F784C69;
	Tue, 14 Jul 2026 00:08:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hmhFHBdc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4244D84C69; Tue, 14 Jul 2026 00:08:20 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 07C0D84B73
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 00:08:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-6a116bd18ebso264218eaf.1
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783980497; x=1784585297; darn=lists.denx.de;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=29aoB6KM0RqAre+vJkoZHkwk6kzB8pLBrFOWb8jwVUk=;
 b=hmhFHBdcR1XFpXjVI+c+BCsY0yCFBQk9Rz0TBeyZqeeLqh6IGCzoNSCNFwlFC1x2n7
 IzOI/72q41pXQ/pJlUW2LGp8KS0DA1KETKFdkLYIoOtRFKz6xUXVAeN/SUVR5WT1d7r6
 TUdr3Xy8zvEmW3NTRog6769iOHHveFcgIZ1+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783980497; x=1784585297;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=29aoB6KM0RqAre+vJkoZHkwk6kzB8pLBrFOWb8jwVUk=;
 b=baqoJDc+dXfapkYoKGE6YkQY1RAGbLkvk5diPsDwVttcb302TI1AI6sxzyFojyGzYL
 XOI6W6AhwYJhpnqx+PVHy07xNttlbM0YIPscle1gEqxqusQsOiorovzy7TGij4rRr1fn
 N+60ckLgRlnYsRQ61TM7K7vdb7CraPkTFuJXKXKFpoyA0GTFqLYi79DsASQ216z0JIUv
 fwZJAY813eWw4wr478j0lko+LcN4YDIPxAJD4y+lnyxlUOAECyB85QocoMIq2bBbCWVz
 DbgrjvDXV/+mzpL0NPf5vVgFc5yYUjiMxa4YvYBaGRwso6Py0mjSxYRyXG5pglOigqPr
 quYA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wqF0objL8e5lX79YIEZg6C+WDwYy4QgL4ZIv1U++a3BXsSGwrUdDS/cUUe5M0vt0rLAabCM4=@lists.denx.de
X-Gm-Message-State: AOJu0YxubLp9zROgkKICYQ7KiXuz3NW+Fwg6i+LTIfFea8FDAGesW2Rw
 qeUJkrOHJI4jja3i9h+jjPI5C4Fuao4kkYYQaRUAmCuf1ik5kSzPlpIjzHrJ8gzXXRQ=
X-Gm-Gg: AfdE7cnIfo69s06xUki1bj2sN7kuX47W7Gftr2c1nnV2S2K4oi75OSokVfX/u45Bsh4
 uZ4mTZIF8cy5PYSq1bHTVm4t3xzS4S2YLrckpj3I8ruDwR6PCnNy2r3k0L0iFfezmZmfDHE8Nhq
 2lDn3ymAe9jrIKOvbFtFN1tqRR9mjR2hpiGg7B/TcvNHFG8iakWcmoQ+t9XcHM+tbAM234DJFkr
 WDyTKDFxc5y84pCzSsoF+n2rzeQZRvS65bcPauBySeYe1oI5gRAkWSxPrwsS+LQONHcttDvr5Lj
 x90UpytHoyfiNn+A1ZnnN/B2PmUHR7bQqkh0aLdOh+RSjtUgS3q5wk1p37EsqK/d6fspznXviKx
 UxCBenGOuUtWo6D9VLplCEWOPXgo7gq47vrlTl4hrtwP7f/YcfwQr47msp85IAyntKH126BbiIj
 Xr2PhFMudtmMXAg3ySELhW9Ig623/lvYYO/DRJYKGo2MFIHmqIGrKpUPdxtVw0Yt/u2mwQvAFtm
 fgDel+GJxZSZdwE8Yk/USQhckgs/jFCwaC3gA==
X-Received: by 2002:a05:6820:2112:b0:6a3:ce0:a34d with SMTP id
 006d021491bc7-6a39a728551mr6203717eaf.54.1783980496782; 
 Mon, 13 Jul 2026 15:08:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a38a4bd734sm7426886eaf.4.2026.07.13.15.08.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 15:08:15 -0700 (PDT)
Date: Mon, 13 Jul 2026 16:08:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Simon Glass <sjg@chromium.org>, Ludwig Nussel <ludwig.nussel@siemens.com>,
 Anton Ivanov <anton@binarly.io>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Randolph Sapp <rs@ti.com>, Francois Berder <fberder@outlook.fr>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] boot: fit: cover the dm-verity roothash with the
 config signature
Message-ID: <20260713220813.GX749385@bill-the-cat>
References: <cover.1783816074.git.daniel@makrotopia.org>
 <81cb6eed897871b3548e81ee63502b65f797c44a.1783816074.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="atBEZdFTnxxRmLJ2"
Content-Disposition: inline
In-Reply-To: <81cb6eed897871b3548e81ee63502b65f797c44a.1783816074.git.daniel@makrotopia.org>
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


--atBEZdFTnxxRmLJ2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 12, 2026 at 01:33:21AM +0100, Daniel Golle wrote:

> A dm-verity protected filesystem image is not hashed by U-Boot when it
> is loaded; its integrity is delegated to the kernel, which validates the
> filesystem on the fly against the roothash taken from the FIT dm-verity
> subnode. The roothash is therefore the sole integrity anchor for the
> filesystem, yet fit_config_add_hash() only added the image node, its
> hash subnodes and its cipher subnode to the signed region, leaving the
> dm-verity subnode (roothash, salt and block parameters) unsigned.
>=20
> An attacker able to rewrite the boot medium could then replace both the
> filesystem and the roothash, recompute a matching dm-verity tree and
> keep the configuration signature valid, defeating verified boot for the
> root filesystem.
>=20
> Add the dm-verity subnode to the list of nodes covered by the
> configuration signature, both when signing (tools/image-host.c) and when
> verifying (boot/image-fit-sig.c), so the roothash and salt are
> authenticated together with the rest of the configuration.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--atBEZdFTnxxRmLJ2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCalVhzAAKCRAr4qD1Cr/k
CiE/AP9a/pyt27mSdHbwCEBP/UIc0DwkV3XzcS45frY4/WX8nAD/UzqkE0Y/Ixnj
XIZ3v3NyUPKFTy2exGkgn9VpUklltw0=
=Qxy4
-----END PGP SIGNATURE-----

--atBEZdFTnxxRmLJ2--
