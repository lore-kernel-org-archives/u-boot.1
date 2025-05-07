Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7615AC3ABC3
	for <u-boot@archiver.kernel.org>; Wed,  7 May 2025 15:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C974E81F32;
	Wed,  7 May 2025 17:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GqLEx+jV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EDE381FAB; Wed,  7 May 2025 17:24:28 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BF428059D
 for <u-boot@lists.denx.de>; Wed,  7 May 2025 17:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2da73155e91so26567fac.0
 for <u-boot@lists.denx.de>; Wed, 07 May 2025 08:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746631465; x=1747236265; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=om/4he0PzbIVd3JFnkO4G1zqCFHyfK1JDANCbr5nsZs=;
 b=GqLEx+jVbTyW9N1GoI8GMdXovJHLrlhazhj8DJl74dTov4wrwtRKkm3C57pNu5eHwY
 owt7Te+y8/CJwZqhJoCfCxChZbPoBHifULz0nPMfraKcrSQ/7WPQcgnHuSFHH9g1Qby1
 FB9GvSie3GadJRJ2oio2H0ocg5nWRg34zBA4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746631465; x=1747236265;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=om/4he0PzbIVd3JFnkO4G1zqCFHyfK1JDANCbr5nsZs=;
 b=WqYzTxmUsIoyy5E9KIYjDLrdjkCalSXznP+Ozrmo0evI0mFqIAQ9ihKXk90U7UxWGi
 WnKQJA/Q1AuEuA/e9SvIZUH/Yu4UB4JC66CRKNlQjE5OSTUtCT6MgrVvzAZQgnDPliVy
 apAmJk6vQ6/fqPzjjj14baezrUKzeSdY8PyF6jjFVZQmHiZOyAT9K45p+EFD0iSAlUxI
 dwVV4/jDp9eMULD6T+rN7rOjfxTNe0xox3oPlNYuKDkD9Xh7cDU53151OX/KpPzcA+tE
 bS1hE5p1QrB9B+ZC6EEWHICKNBAZct9KNz4mey+Go4nFkwaVrGfzr2syWUAncQxPdr6G
 g5PA==
X-Gm-Message-State: AOJu0Yx8jl+1GKw0EykNwsEgMU4XtRBycIaYkQHrzTJZixcOQ4IjyJM7
 Pf+2BoAH5n6igZXflvPhxLjYw2tojGwN/vhfLToB5EJHTNGyZYb1cd1zWJPrlGs=
X-Gm-Gg: ASbGncs6LWy3/Xj5gF1iTXRQ1sSLmJFrwoUuKscJMIg6JbKaQsb1zeroMGLEz8mk7Ls
 LAYB5X/IXHfQtC6K/OwwJHSUgVciFTzhM7/lU7HmcW0zWLAacyxTUIugnBo+ar/36O0MECsPQSL
 9VYtw792FK+Zk8iQ806cEcIHi3B3GTUC6urVdEWFshDFPHnO99/Cyh5xbigawFlV8bxTazjYwb5
 4qFAYXehkjxOQY+RlsvhkbxunH/60+c8UJAOix6lcahBlJvV2QxBOHVnasHH0jEbNgaisVUHlni
 Aw4DTvZBDGSza5mfQz+13pkkHeu/cqcKD/HTOZfIz5e1NcKeEngapjMvo2ItZNrYiKCpumewtKV
 cox/xVmd46OCe
X-Google-Smtp-Source: AGHT+IHC74/LyY+2X2eBkREMN2nf356Ggv1mc5acwauxWAa3ma+YcDi6nAYN2OmxLjwBL/X4s8vhlA==
X-Received: by 2002:a05:6870:b01f:b0:2d4:d07c:7cb2 with SMTP id
 586e51a60fabf-2db5be1352cmr1736600fac.11.1746631464870; 
 Wed, 07 May 2025 08:24:24 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2db5d0e53d2sm668680fac.46.2025.05.07.08.24.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 May 2025 08:24:24 -0700 (PDT)
Date: Wed, 7 May 2025 09:24:22 -0600
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, ggiordano@phytec.com,
 d.schultz@phytec.de, n-francis@ti.com, nmorrisson@phytec.com
Subject: Re: [PATCH 1/7] board: phytec: phycore_am62x: Update environment for
 fitboot
Message-ID: <20250507152422.GA479524@bill-the-cat>
References: <20250428134531.2884940-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K5OlmHTLDVo9+L0l"
Content-Disposition: inline
In-Reply-To: <20250428134531.2884940-1-w.egorov@phytec.de>
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


--K5OlmHTLDVo9+L0l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 03:45:25PM +0200, Wadim Egorov wrote:

> From: Nathan Morrisson <nmorrisson@phytec.com>
>=20
> Add fit_addr_r to the environment to allow us to boot from a FIT image.
>=20
> Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> ---
>  board/phytec/phycore_am62x/phycore_am62x.env | 1 +
>  1 file changed, 1 insertion(+)

Please rebase on top of current master, this does not compile, thanks.

--=20
Tom

--K5OlmHTLDVo9+L0l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgbeyYACgkQFHw5/5Y0
tyzzAQv9ER7KYn03ndcbTHDz3cXbn7tabBdwsd/odyaAtyCKWE8kAZk2Evt7U8Qi
XwmQUi8eU44QQpaIoSi1fqe5psofE0eJ6oOQuvQDW2hytGkFIJqkJWxCG+yx95cS
gYbekNXm+WGx74r34oyAIlUIMHgzELQC+ef7nY+6TRV+mBfUC245zgR23p+kKZmB
rFZPlOSEeIc5QrQSMIKcN2eeGmVOb2gtZKtemBiRu2LMY+oviOHadoQf0bWSL3OH
jTe91KFYHSqMtOa0kaRzZvpZUs7/AFwcUTj0JKnSBgoJvtWAnknHxNAbXrbQybRO
6pnBRzdIJIbE0nwkZZ305u8yayPxXongir6jAnveqQeXgCwzpCdVIi7nF2BTne5D
o3W5ze8TRke94rzKx1x7NiUyoKcwDXYEIfemMyjgOEvza8YmlZPyFWsCsyj3RtLw
fGp33tmzHBVjyoJHsbKWrBVQsIR8aKhssBk+2Rd0sMyqA6RWCW7rhNckT9j/wfQA
cUP/BCi1
=S7fI
-----END PGP SIGNATURE-----

--K5OlmHTLDVo9+L0l--
