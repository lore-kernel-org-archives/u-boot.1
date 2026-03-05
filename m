Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D68F47CC0
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 19:38:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 395FA83F2E;
	Thu,  5 Mar 2026 20:38:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sMqCE24W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413AA83F2E; Thu,  5 Mar 2026 20:38:09 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24934839A8
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 20:38:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7d4c68f0e47so5525768a34.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 11:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772739486; x=1773344286; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8hMIs046NGN/qxH99jw2Wx/UztJY62eo3k5rSQSc1po=;
 b=sMqCE24WyBB3BD5Qea+kyNckonwBRSepUFwd89TTF+HQdVXHkLhPoIGzwCSjSA2iV6
 K60w8f4OHeN9tAPXtzcLvVPDXvEdOuvkEwUvtMdE2vzsSC8L2MZIuMwWIsCVY+8Ib3rN
 NJtcWb41KaFZY92cupPwxIURZLycWdi6wAQes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772739486; x=1773344286;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8hMIs046NGN/qxH99jw2Wx/UztJY62eo3k5rSQSc1po=;
 b=VgrKzt1wW1Bv7cI0dEZOHP79USqQLreTKDdDOM4l1n5UBJtQDFmNKva7kPwCHgGQGE
 FdzK3tP/OFrtsYWLDzT31dLrRPGhmjNQgJ/9K3wCibY+JOrV8AEkVbdMLb1pfXp+gAgA
 wwUDC0HsyYInw4lh1+TYG5e8D1cUiyGdDRIyo1v7uqAXChWFLimq+7BdBZwICnL7++1J
 ZQKa9kJmIh5r7snyJ0dEEKNfS+lbkaJbZLnOX/jql1kT12JdptQL9df5bipsiuMC9bNv
 QL+gLymBVGY8XiaxoddW16tPpDROtD6iE3PUBY29GyppFCdFRVCW8isKyFqh2+CDqzq3
 3e1A==
X-Gm-Message-State: AOJu0YxURP5RaVpj5wMXuqkYn0VeVMGawSWvuWmduyg+RF0SABZdaSZ5
 7oqUYyqM6YUFFuDldOpRKHgBB/XkmaJ6a+e+FdwpaZZmde/vikyZOAlP8BTsL2k9AWg=
X-Gm-Gg: ATEYQzzpiXt7zO/3zSFCywucnq1Ifpl4R855C4NtDx6MBLkbCb8oAjaFGWT+6Ifu/zN
 Sr9A6hI/T5Yvn8JBQuPcGBCoxOisHDlo8UYI8a7tilM91k5gnDcNPQb1fMbHIy0ZFHmqwxFf8rt
 ZdfgIDYcWZo30envi0F2xQWJZVdZMogX3mwnfkN+cKSWXouU8Kvo2pC0Jb0li6C6gukfP3ARZyd
 QJ0mQyDZC8ZkECHMDdfZT2F09tGjbRI5TdbIlZX5b7UmBv206DQSyq4jm5IwSdnUCt7dYHVuewg
 yjHNETNu6ZCGFpyXHeUV2DNatGHQDWT/V6cbjKwhkENWobFeGziO6bKEeo8w8/b/yiomjzGrVa6
 j1yDesVGPt/fYRqELKaZnmRcW6bIO03+biO9KQaiwUKMQEQPRdTIHUpM31fmdttElwZY/k6N87Y
 nHs/KV4WgOa5nbz3VWk6Us8VPiIpuVKiXsfnntkWqXp//xx5uu6r1Tkn8cTF3KYWyIH19CzJTGg
 FDm1hlvvvXI1WhqD3SShtVu3JhThF/hgB2B+DVaKfut/PbuqXg=
X-Received: by 2002:a05:6830:82e8:b0:7d1:9da9:c6e with SMTP id
 46e09a7af769-7d6d39f0292mr3657798a34.25.1772739485768; 
 Thu, 05 Mar 2026 11:38:05 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d58644d426sm18580729a34.3.2026.03.05.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 11:38:05 -0800 (PST)
Date: Thu, 5 Mar 2026 13:38:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Ludwig <ludwig.nussel@siemens.com>,
 Simon Glass <simon.glass@canonical.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Enric Balletbo i Serra <eballetbo@kernel.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Subject: Re: [PATCH] boot: Add fit_config_get_hash_list() to build signed
 node list
Message-ID: <20260305193802.GH1388590@bill-the-cat>
References: <20260304135202.1535134-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zvmwk/v1K0UFpvPa"
Content-Disposition: inline
In-Reply-To: <20260304135202.1535134-1-sjg@chromium.org>
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


--Zvmwk/v1K0UFpvPa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 04, 2026 at 06:51:48AM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The hashed-nodes property in a FIT signature node lists which FDT paths
> are included in the signature hash. It is intended as a hint so should
> not be used for verification.
>=20
> Add a function to build the node list from scratch by iterating the
> configuration's image references. Skip properties known not to be image
> references. For each image, collect the path plus all hash and cipher
> subnodes.
>=20
> Use the new function in fit_config_check_sig() instead of reading
> 'hashed-nodes'.
>=20
> Update the docs to cover this. The FIT spec can be updated separately.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>

This breaks:
FAILED test/py/tests/test_vboot.py::test_vboot[sha1-basic-sha1--None-False-=
True-False-False] - AssertionError
unfortunately.

--=20
Tom

--Zvmwk/v1K0UFpvPa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaanblgAKCRAr4qD1Cr/k
CovIAP9taxeM21DjdgQtSbtOOvAJlW87An4H5L8ncwUORhcktQEAr6b+TYPABSLl
54HTwuVMDG7w21prOtrN6NCRzeGnCAM=
=k0eK
-----END PGP SIGNATURE-----

--Zvmwk/v1K0UFpvPa--
