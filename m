Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D89C02183
	for <u-boot@archiver.kernel.org>; Mon, 13 Jan 2025 18:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46B61805DA;
	Mon, 13 Jan 2025 19:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RF2AKvh3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD244805DA; Mon, 13 Jan 2025 19:34:16 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0D3801CF
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 19:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-46677ef6910so47506181cf.2
 for <u-boot@lists.denx.de>; Mon, 13 Jan 2025 10:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736793253; x=1737398053; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MdbqbmeVt3PscmTFCCrqB1g6g05dUruz1f32RAnl92A=;
 b=RF2AKvh3ZbeAygNqpFqwz7JkBeqwnP0oC32LZnG3kuZ5k4IpADGNSeLI7QEDLrgnaT
 TZ3dsAB9glrNjVDBM+IZ1pymUgGIgMoJnKT8a7k/pq700KCUA2iGtOOFHx6F2jnSEBIB
 KW3I0nHEShDcn8ePA2trWmIJrbVMJSziTa2Dw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736793253; x=1737398053;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MdbqbmeVt3PscmTFCCrqB1g6g05dUruz1f32RAnl92A=;
 b=DkfAvqTV9kcYbKTh/p3HMftNcFGQhRDXeG8l9JdxnVqqDHYVN6CwkROkJC4f5RVWYh
 kFj3LLbL0M3RmlW6AInQHx9qiCkG11KGGl9aABwZ20zIG/Ahi4slFsHIgHjadL1ElQaq
 iPPyRFRLggzJh/7ul1bNY8BSwOHp+BsC1WcbI6t7txCEXGL8w/E/8biJQrNcMOBIqvJJ
 yOzlO2HHLqsdF/MWY2poi3wIjTMT26PQGgHQwbcntkyUbs8gZqkxcdOPBb10ZJFVcUjS
 inBI6y4/WzHwH7c411+OSwGdkksnE+hN0lwinhrEX+aiKXFxFAcslq9wBpBXvpBfNRUV
 QokA==
X-Gm-Message-State: AOJu0YzGWcbiF4yKcMF82fCej+c0LnIT/RrnrexkbO8WqFaE/K+ArRav
 lzKUUG7pJoPcCQgEKpua/ImiNolwe5Dn7AixtysWGrqp+mrX+Zir5kZwQvyV/r5wAbFOjAXr+8j
 o
X-Gm-Gg: ASbGncu8k8jpWoFuzfh49ulgq6Q0rIMNkfhoP2EMRtaqo/r9LE52hOEjc7F6g6YPAcj
 C8tKv/PzWU96EkuAdUu7BHorElUbQJ6/ToXEw9NCwvvT6C3X6xi+9vGRxyetVgAe1SpAO8ZS41y
 hMKR/MzDs663ziAYu4stkNJsdVaWf/aAXD781Ei7EslPIDofqI2DQcV40UkkU9Z2fbHCQmYDYCE
 P0DOAQX6Yw87s6/lNQ6KJMB8CA5qeOOQj82PZpG6ZkOkz6PHrvcb5Y=
X-Google-Smtp-Source: AGHT+IEYJkyDwLxYGkJjj6I3uEKNKod5Q3kZ8hIg/vI0hQjtEMqBIt5iv545C3ZSbo21aMmRIYL1DA==
X-Received: by 2002:ac8:7f14:0:b0:467:63a5:fb9c with SMTP id
 d75a77b69052e-46c710877bfmr345556381cf.44.1736793253004; 
 Mon, 13 Jan 2025 10:34:13 -0800 (PST)
Received: from bill-the-cat ([187.144.0.100]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c87366315sm44828101cf.48.2025.01.13.10.34.11
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jan 2025 10:34:12 -0800 (PST)
Date: Mon, 13 Jan 2025 12:34:09 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [ANN / RFC] Regular community calls?
Message-ID: <20250113183409.GY3476@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/apuuo0oVYIwW469"
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


--/apuuo0oVYIwW469
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's been suggested again a few times recently that we should try and
have some sort of regular open call / video chat as that might help
clear up some issues. To that end, I'd like to propose we have the first
one at 9am -0600 UTC (3pm +0 UTC) via Google Meet. This will be a day
after the v2025.04-rc1 release, and I'll include a link in the release
email. If this works out well, we can make it a regular thing for the
day after a release and also try rotating the time, or having a second
meeting much later in my day that's at a better time for other parts of
the world.

--=20
Tom

--/apuuo0oVYIwW469
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeFXJkACgkQFHw5/5Y0
tyzIQwv8CQBtDojh5YFydTSggJ3QC+K2sqoIr17OP7l3UtEPZviPQlF5QbHoLFLe
GPdxV7hOeKJpx79TyNtIYyRyPKkKpeamHxIQ4qMmQqC5OTgayus3DYgrkvQAkjnu
wLFov+Sk32BhsK/Pxi1+kCAQeBwn5l7+olFgCWQu2ApzTtJ9vO+MGG9yOgxygVr9
oVeAcZONFK/5V/0OiEOvzhJJdymAFa+gde2nP6KmBpLhXnShg682dQAtRXgkL0xw
cfDcu3m1wLA+iSOnFVUZzRU0xwM2i61yXHT+4P9uJWmUotvWJhWRDPiO2u2y800+
VsNQWbYR1gcgvmgq74NK1anKTPUtv9z5sTIagBvSpjBN8u8j128fm+0Hc49PbKWq
O8L+j7HzuXUpK3/qUHyPvy3kTDliL1dsymNEx6LtmQYrd5YMPXzwnyeC+4uBHTRq
LUsB7cVtt701/q7Waf0o2r5HtFVWVi5mEpS9Xj7D2zDHgDVjXn4zswqAeNSlL/rE
YCMz0IK0
=IS/w
-----END PGP SIGNATURE-----

--/apuuo0oVYIwW469--
