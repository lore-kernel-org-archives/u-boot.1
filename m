Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40856CA0EC4
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 19:26:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E0798311B;
	Mon, 11 Aug 2025 21:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Oudm8fkL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A50968313F; Mon, 11 Aug 2025 21:26:45 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5313683118
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 21:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8817f851294so287897539f.2
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 12:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1754940402; x=1755545202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nr+Ks8lRwOfIuwGQIcD7o1AGi6h/+sIvDRe7wRyum+4=;
 b=Oudm8fkLPWduKGd/vAPpI1cZi/4+E8bbwlJxiXBBVjRWTXO7zxFar5wI+TVSyZokf0
 cP/+K8S0799iWDpJR3nBiXCIroW4xV9PZ0YiVyBUWCQBbKEgDwLfOc3X0VvuIJNg2FHu
 E8i0eVLlmjkXZpzTG+5HPYLlQJ6z5W7I/wmhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754940402; x=1755545202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nr+Ks8lRwOfIuwGQIcD7o1AGi6h/+sIvDRe7wRyum+4=;
 b=fBEoN8hldoYXhp7JyE8DpKt8xMKF7ABb5kTak8Pzh4UjfU7HxYwSlT8UCmL8D374aB
 TYEpX361I3rJQctMeXSsJOv6aIigip6zbL1hanRcv6NEPJxyMdJCPr+AHWZTKmyGOK8E
 9qQHz5QfngK00v5MDm2O2lSJM9Z68MZRJaIH3f0A8lAWreih14rtgDc76xfMav7R9jMm
 zjZCNyG4e49zHrLriLkqdIS2uK0q5tG+0m7rnDnuUoTuCS6MpQYFtol5NAtYqgirX+kV
 JDpJzzICq0ZxhH2thIPexcjHCJW5gLDSFiuXHQNcG1nyDaeiQHMHC9G712aTEHbfJnpm
 rOAA==
X-Gm-Message-State: AOJu0YxhtTbU3UpczU/GMIVKjoFYTWCCwUJGZvJRayVZpPa+OEB3TGa1
 O2wI/13haA6C29sqona31GzSN9b52nv1yjXuwMQ+mlf2bU/p3S5XM3bj8b71hogd5cG9aJKvB+4
 7tdA8sao=
X-Gm-Gg: ASbGncsdI0oMr3GDSZ1PXsPipNF6mKhRapxmxPglnYC4v+95M92GeQ0lIITluN8WvY2
 9mXWXQAeFlzjwt4976/XnBlfTVrm+h4/HZm4xi6yUAwve3fRErQc9bqZV2yWKG2MiR5qVOshvU1
 rXp0QqBGOxjXGnnPfBM/+MotNb27U7+Z9oD6cfyJhASRVPpIxtDeZYo1n96zvRUDF5u38AeNA8M
 YF26vFStNXMEYY5/BSenESj7gWu8SrDVfH5MQvOleZNsTm7wmF/EwopwpN6+y+c+WEJTtZbCQm/
 S/4TvyQO69Kdd8/b3y7UMlxRFdnudD60OoRAGOZZHdb7wQkXPZJxsVAtvgqbJO+uocpJnvMtOPy
 XzTDpK1huk+r5mDfOiGVGlTpf6ZtVJlYOjJ8iY7CRg35Vr0KgqVreN8ie
X-Google-Smtp-Source: AGHT+IFr94yQW3nMjGm8RIc5nYPYETtb0oi5ujR9bwJDUR88FUM+g7HEOrDSOAH5m3Kjg/IvI4ry5A==
X-Received: by 2002:a05:6602:1492:b0:881:7837:6058 with SMTP id
 ca18e2360f4ac-883f10dcd58mr2503121739f.0.1754940401968; 
 Mon, 11 Aug 2025 12:26:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-883f18bace4sm313668539f.7.2025.08.11.12.26.40
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 12:26:41 -0700 (PDT)
Date: Mon, 11 Aug 2025 13:26:38 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] arm: socfpga: Correct how we set BOOTFILE
Message-ID: <20250811192638.GK124814@bill-the-cat>
References: <20250811191606.1577182-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6K3VA/ihdpTtH/Ka"
Content-Disposition: inline
In-Reply-To: <20250811191606.1577182-1-trini@konsulko.com>
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


--6K3VA/ihdpTtH/Ka
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 01:16:06PM -0600, Tom Rini wrote:

> In order to set the BOOTFILE symbol we first need to have USE_BOOTFILE
> be set, or some of the logic might not work as expected later on when
> building. Second, defaults like this belong with the symbol itself.
>=20
> Fixes: da595d236b97 ("include: configs: soc64: Use CONFIG_SPL_ATF to diff=
erentiate bootfile")
> Signed-off-by: Tom Rini <trini@konsulko.com>

I will be applying this shortly as I found this as part of doing the
defconfig resync for -rc2 and saw a massive churn related to BOOTFILE in
other defconfig files.

--=20
Tom

--6K3VA/ihdpTtH/Ka
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaJpD6wAKCRAr4qD1Cr/k
Cl4VAP9QAtNwu5cz7o/BPbcjX+3sKRrFa63RhyiUAJJ/i/Og8AEAruk+QGbxh9Kx
jco02HYgI45OU8LACeVr8G631rigEAA=
=v/3F
-----END PGP SIGNATURE-----

--6K3VA/ihdpTtH/Ka--
