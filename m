Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9B7D1A63C
	for <u-boot@archiver.kernel.org>; Fri,  9 Jan 2026 15:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624B28432F;
	Fri,  9 Jan 2026 16:03:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EEXUuJc1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FEDE8432F; Fri,  9 Jan 2026 16:03:55 +0100 (CET)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 765AF84248
 for <u-boot@lists.denx.de>; Fri,  9 Jan 2026 16:03:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-7ce229972f1so3801889a34.3
 for <u-boot@lists.denx.de>; Fri, 09 Jan 2026 07:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1767971028; x=1768575828; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=k7tPoaLB4waaVdzQ68ZYeJHDzOemb3zHjZkv8XxqN7Q=;
 b=EEXUuJc19rajhIGlO2A9FVko6TaCzZofJMc3N/bSAqJB9Z+UIIGhRPkdVE3s12NeuP
 LdR5GIOqIrCtXlXmVjbvMqJFdYGA4N7irZzly/+sY55quAlCurA8G3YLYo2uPMSqLKoW
 v9Sz/H2O5oGxutkLDCka15DBlPhD2MPxVZRz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767971028; x=1768575828;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k7tPoaLB4waaVdzQ68ZYeJHDzOemb3zHjZkv8XxqN7Q=;
 b=Z625guI4XN1mE5roAcWz1lLAAUu3osm+HhFW85J2oA93YC4MS3RBVbkoERk3ossZxp
 1pcy+2TEsD+72H6BPgG7HdoephbMogRor4E9PxuhAHe2IF1xkNOyUQtziq4zlRZLItnX
 vxmMyl7k3LjyaFIrDGPZt4WPu7m8pSjQtJVIz+yN/akYnmFFgrpO3l/Vq8KlUTl0yAGi
 SyzGsQx2anAL3rEsPpsPy9R3sM67YPZFRKUPf7ZRm7BLP3U6B74c3Sc3pRcB5uUouaTf
 oXy6JP9pqR2bisazmuKvnKJLG/0XsEjG7ngnsonXX6F6uYUfukpIN91W3hZZiDGrZJih
 3NYA==
X-Gm-Message-State: AOJu0YxS6OI0UuWA8XwhpC3NIoEdWgoj0R9Pqz2cI+4zJ5N8gvUIKaxd
 2m0RHVxJmp8NUF3fjLZjbQ3g0ZAIA3383Rg//NmD1g1yySsUEJRu8UQdyDK1zkwK6uo=
X-Gm-Gg: AY/fxX6n2vEThgI+5AO9zF3D4D5qPJlVybA9Eh/z57SIrlMxKKEgEjlJ093Ppg/5A9l
 r0XD0QgOsY8mYuXX5K/cWf+3WypnMotChe2Zc90cN/cFacBbF7jW+ToaGQsbRvV6ywGfCWgAaOH
 cKzFMAisUCxhA3N+nuUknVMd5N6mwetmm3ZuC6pozz2bt5Ph6xiS2RoA2QXXtXDmJIKJanH5/20
 5b0iWjdPbc4/FyqtCShgllAdJLbNX2eerMckCW6LUlcieoK56itL8sKO1c3cBiqKMukWWTEzGIy
 sHj1z1/mQtHBIzw73K5IZ0LQTVkHiwS7XpwlY+9589e/8t5uKYKfABC4CMvDQ0b+VJ8Jx1ZAwfS
 ybleCfjpOEzkyJcppnFZxtfwBTUm4cnM9joTtAsUbdr3GIlyNwqZQg5Wf1rtzEzPrDrrz77HDsB
 g/Z/H89poBGPBhXpv5NCt9CqymeP+DLK3owSkksjQLUdaaK29MCRKs3jGjjHgrPV8QH4TBPdiT4
 x25FeX4w5r53XNgQEg9rHk2kDx9z3l4ZZTp1SE=
X-Google-Smtp-Source: AGHT+IFl1YkkeQxvkigqsT7yjqgvxbRLkFUFnU4/PGxGfeCIGmaXHF5hvJhjVgbni+uXcGE68UrMgQ==
X-Received: by 2002:a05:6820:403:b0:65f:1038:130a with SMTP id
 006d021491bc7-65f5507ea0emr4130193eaf.69.1767971028135; 
 Fri, 09 Jan 2026 07:03:48 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3ffa5161468sm7147627fac.22.2026.01.09.07.03.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Jan 2026 07:03:47 -0800 (PST)
Date: Fri, 9 Jan 2026 09:03:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>
Subject: Re: [PATCH v3 4/4] fs: prevent integer overflow in ext4fs_get_bgdtable
Message-ID: <20260109150344.GC3416603@bill-the-cat>
References: <20260109112428.262793-1-t.preissl@proton.me>
 <20260109112428.262793-5-t.preissl@proton.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="NtwI0R2Cjz+qex6f"
Content-Disposition: inline
In-Reply-To: <20260109112428.262793-5-t.preissl@proton.me>
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


--NtwI0R2Cjz+qex6f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2026 at 11:25:07AM +0000, Timo tp Prei=DFl wrote:

> An integer overflow in gdsize_total calculation could lead
> to under-allocation and heap buffer overflow.
>=20
> Signed-off-by: Timo tp Prei=DFl <t.preissl@proton.me>
> Reviewed-by: Simon Glass <simon.glass@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--NtwI0R2Cjz+qex6f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWEY0AAKCRAr4qD1Cr/k
Cv1RAQCep7so7kNsqzknepVwW6bJ1gbCy1/+7SPrKEEC8RyqTwEAyWP9jd4TZKIs
4m3eyTnQUJURhGRW+NuKK7hZa5Y+UQs=
=4B7a
-----END PGP SIGNATURE-----

--NtwI0R2Cjz+qex6f--
