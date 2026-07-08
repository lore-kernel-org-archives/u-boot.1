Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C762C43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 16:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47F78496E;
	Wed,  8 Jul 2026 18:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SHPMnYc8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA8A1849F0; Wed,  8 Jul 2026 18:19:52 +0200 (CEST)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10C38496E
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 18:19:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-43cce34c881so470295fac.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1783527588; x=1784132388; darn=lists.denx.de;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L81axNqiZeF5ZQVi9ZpQUV+BUSxOSisbfVPLm7KAv5U=;
 b=SHPMnYc85wGPaKYfiQUrmJKsfYGBMIaOLU96a5S0a5+8v9/fqklXn12nqD1Z5tU0A0
 iJhJyQDuB+8wCEB2NhP18YdDW4AJVNH6ehZ3EqVon5NvxyozccM00SIB6NzRovbWKWhC
 86+TMVK2N0ERvhJEDH1S+/X1njqUWklCWpeos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783527588; x=1784132388;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L81axNqiZeF5ZQVi9ZpQUV+BUSxOSisbfVPLm7KAv5U=;
 b=REiDmQ+Ya0FE7zHKLghwoapSf0gElpkoWZmYPbmH1CGTClzwCKqYA+0cQFumH7KQyg
 EGJA2Hdwaip+3A91nq3TWFSEkkWnPDxfx7TFc6CcaGe9hr6ak/fnAEmFh5KNXMugQspN
 pNIiCAXf8KxRhbDj30BdH6Rmbp5EsITb+jEm/Te4J0YBs4K8HvlzHMmjyu6wjDPuv63T
 J8O90Tp/CgD8GFXrCJ2VWx10//fZkCCTCtgDX2YgDZB8MvYW5KgeLqEVA95UHzoRbTC/
 OwJsAjjHR7vxfN38stWP9wWAKQRNXx5M4ruY3hpRYf+15PsWKnE0CmMBr8e1DxyqHElZ
 CRMw==
X-Gm-Message-State: AOJu0YzzUNRThkAtpoqzBdbRcgX2+C4Y3xwoLhyXkwBWx/nomG3vaokW
 V3xP1zijyv/9ZRqTI9eY8KO8wdRMIPx97+CISQk+tsptVWHcYv/j27LGn5L73u6EKcpuokCuc0y
 dEj2fCaA=
X-Gm-Gg: AfdE7clZt1pjL7KR6sq9zSwhiIJPGF4SvudLwIu4pfloWwtKAhQsNvsV04q+n0KuYf1
 Ja+WHK3Vo26MoSHhah8zsCogacRy7lhVr1vjZEJWyFai0MBv3xQpBRG1/zk2Nb1HWc3Aa4VD6XN
 ltWvvZRSWpgW5ha9+md7K8HmJh6f2oZWgqYT3Y1xVWlaekY60Aa8o+E4HccsH67jCrzZOjU0Xm7
 40AP/zBe+9A0e6sPK84SZ9DhlJUB65kN96GZ6Lk+DynzHyZnyiWBVuBkOk8DxYQ3quKHtawglcp
 5gRjZ3yny1PEtqXIlMKWTsy2GJ3XzreYmSvRwoxONcOlY6EBFZawpCie2LunrvEWQN1io4Z9cyR
 FAW7DHeSc2JNqR3Lclz1d9NpZsy4vheE6sLTkpbCwDav4mSAhXcYDKLJlbrY6xsPn49EyuSoPK9
 UEAQBzOc+TGF0z1QLqKRVxVpMt61Qzv5NFVo1zO5AVFS1CXOl1XisAiiQLFrpFW2QmptvUgxCUp
 68bSirAcoxwJKv1MgIfMxg79JeB8RIODmz0wA==
X-Received: by 2002:a05:6871:20e:b0:448:5591:15d6 with SMTP id
 586e51a60fabf-45163d515edmr2097958fac.34.1783527588122; 
 Wed, 08 Jul 2026 09:19:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-44cfb13d624sm17036021fac.1.2026.07.08.09.19.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 09:19:47 -0700 (PDT)
Date: Wed, 8 Jul 2026 10:19:45 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-board-maintainers@lists.denx.de, u-boot-custodians@lists.denx.de
Subject: [ANN] Updating branching scheme to use "main"
Message-ID: <20260708161945.GU749385@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Nz5t4Z31cjA4fyMf"
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


--Nz5t4Z31cjA4fyMf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

As part of migrating from source.denx.de and over to
git.u-boot-project.org, I think it's time to change the branching scheme
=66rom master or next to main or next. Since we'll be changing the URLs, I
don't think we need to (and I'm not sure we can automatically) have a
period where both exist. Thanks!

--=20
Tom

--Nz5t4Z31cjA4fyMf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCak54nQAKCRAr4qD1Cr/k
CpCsAQCxKrRwB5SbywfQJcgmsbmsiajH0cC9zqv2JxQcdMPPZgD5AUoiggGWllHy
D4XAgPBMrmN4PUg2gN++v89lFPtv+wE=
=YqcY
-----END PGP SIGNATURE-----

--Nz5t4Z31cjA4fyMf--
