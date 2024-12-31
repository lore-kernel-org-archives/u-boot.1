Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0864DE77188
	for <u-boot@archiver.kernel.org>; Tue, 31 Dec 2024 04:09:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84B1B805EA;
	Tue, 31 Dec 2024 05:09:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Dc6LHDLm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27849804B6; Tue, 31 Dec 2024 05:09:09 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A17805EA
 for <u-boot@lists.denx.de>; Tue, 31 Dec 2024 05:09:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7b6f7d7e128so917998285a.1
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 20:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735618143; x=1736222943; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7HZ/QkRDxsep94HjegvKiWfFJ0y3qt9j237Ri+QwVoI=;
 b=Dc6LHDLm5/m1QFYEydZuyauW6W/hduLVeoC9L8m/j7uVdSHdiqinuAdY6hQ3NxV8k6
 CId+Yilno+LrXiOAOQTO/C9tnSF8cbMfxw4Z53t4vWQYUwY1CZiR3rYlPJCTIOWEK7go
 O/ehk3Exs1JA65JWSmUbJOglr1SK41aeA1C7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735618143; x=1736222943;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7HZ/QkRDxsep94HjegvKiWfFJ0y3qt9j237Ri+QwVoI=;
 b=n39vcrDBTQ6xJ+vSLfRgbxNgbMsprW6rO/qgPUT0vLgQxA3bn7uUUBurNGE+fBBHci
 Ig4eO5RCSO8F2zxjq4amk3Xh7/tdyLsKCVNU/xOA7szYpuPETpmWohwj6oLzwCD8sW7l
 62W3Z/+Cv3GrozWFns++GU2lbaOd2H47QogjgrF/7FDwi4v5wKKDxSYRuVvnh1VhDdnu
 N0iA8Hpnma/dWX5CpfTruOlDY6LNXJ3J8pK2EUtgLVIpdwzcKwHQV7s7lWRbiHX1zQh3
 7lnIFzQ6XVWgFStpCCe2gKoJwDoF8nd9I2nJAl5K/CvCU79n+3pB5JGSImOdIlY0iMqB
 2SlQ==
X-Gm-Message-State: AOJu0Yw4SyvGTcZuFBnZ2EMQDI6BuU4XY0YbJxZyFj4nmaWlUkfzfJMF
 HO6+xVdeaER9LjlO0SQGDPiP4gxBs1SUgfU802ppBonXW++GFu4Qqm7y67Uw6gbGqnWEBVz/PYO
 g
X-Gm-Gg: ASbGnct6VWNcbZycTEdw+M6EXOsGfk+rkQQIi34n6M6ubV9CUIa8Ez3Ende1MQODUjP
 H4u3c91PBngVeEGCR+AsgvJgL2IbiLlyd70XpHIbivvM1rzQChCD8MUe3KH3i/M22GEUY+V8htD
 +g7iK183rXuav42E86C1pC175rfnhgUUosi9YG4Sj7wue85HBz3ZDf+d0R/uLSczryVM9TQHh86
 9xTjHVAB0x+VStVgG3SBgIhBmQqJOAbVDuDkCVuRs+VIR5b9WWgRUq+0A==
X-Google-Smtp-Source: AGHT+IFNX0IB07/hjfRBfAX86Xz+w2O/oD4KeC99eFj7Gnn9hMa+Yhtd7qoWSUPSEswa4Baeb/vxsQ==
X-Received: by 2002:a05:620a:6843:b0:7b6:e616:4e67 with SMTP id
 af79cd13be357-7b9bac05a1emr5860935685a.2.1735618143267; 
 Mon, 30 Dec 2024 20:09:03 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac30d7e2sm976129185a.59.2024.12.30.20.09.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 20:09:02 -0800 (PST)
Date: Mon, 30 Dec 2024 22:08:59 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de,
 marex@denx.de, monstr@monstr.eu, Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [ANN] U-Boot v2025.01-rc6 released
Message-ID: <20241231040859.GG3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/VoN2OuG/B4dBcs7"
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


--/VoN2OuG/B4dBcs7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and so here's v2025.01-rc6, and I'll update the -next
branch shortly as well.

At this point, I've merged what I hope is the last SPI-NOR related patch
for this release. We aren't 100% back to how the codebase was for
v2024.10 for the non-stacked case, but I think we're OK.

In terms of a changelog,=20
git log --merges v2025.01-rc5..v2025.01-rc6
As always, more details in pull requests (or the tags referenced by
them) will result in more details here.

Unless something else happens, I plan to release v2025.01 on the 6th of
January, 2025.

Thanks all!

--=20
Tom

--/VoN2OuG/B4dBcs7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdzblsACgkQFHw5/5Y0
tyyAlQwAoIauX2WNynkQ+rk8gw980ZsmsH+xb0rFj81mbh7IgnMY8SM89LYLAeJ0
VkpSXLX7TJADsT6l2EgO3uk2yCprzxwzgUKVQtjTSINOw4NH5KB+83FfuQPHUrXw
zzqH++AEB7yY6N+AA7ObO138y8tfI3uw+/f+lRLoPRmHEUCWecuykcuF76TAHiSD
tC2PFO4OY4mZxy4L6b8XBeD/aAvQpcOY3+Ktn6h8aCxnLebvKVpaSj+wgSFljyIt
ev0pVM6u4jiIs/uNgvdYKQVzobvpCXMI5WpZsrZHJ58/zRCZlsaPZbgUJhL7vR6Y
64yyE+IMbDswOoRSO03hA20lA3dzMKXRo1WoBkbgs925AyCQu/z7XV2fJ2O+VQRs
RVSxcsctaSPoPIKG7FGj5l8D5RAc9TIgp5an2RtG38vfzvsOFvi+2ELGjxTmBHIN
4WAdlW08ce54zZ4goctSmDrPN/8LugFCrrlBiS8ABjFYRYNLD4lLm6XNnQ3dHGYh
kiJTWCcS
=guCp
-----END PGP SIGNATURE-----

--/VoN2OuG/B4dBcs7--
