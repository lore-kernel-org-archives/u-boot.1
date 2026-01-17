Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC4EC98315
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 16:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCE13833C6;
	Sat, 17 Jan 2026 17:32:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kqLpbqRk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 246128367F; Sat, 17 Jan 2026 17:31:59 +0100 (CET)
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com
 [IPv6:2001:4860:4864:20::30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09B4782BF2
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 17:31:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-4044854464fso1413596fac.3
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 08:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768667516; x=1769272316; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JkdNa3KMap/DgTHmOpVKUYVrmnrVkKOAmGD+Uw5UPXY=;
 b=kqLpbqRktST7QG4aE+CqecweFEMqUhq2nUDQvwUlz84HrQ3uNb06jX6B34goOFEUHn
 aZ6WICdVOb+sIUyXgmPRQsSp6ZQHsdX9+WraSTEwqv0THBNCLAnfhCtGpsz234wnjMqs
 l31NAjm+0t/WN6v+d+sTHNRpWZqXgb744Qdys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768667516; x=1769272316;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkdNa3KMap/DgTHmOpVKUYVrmnrVkKOAmGD+Uw5UPXY=;
 b=WahyEmHBSxiEvOVErJ5HzZr+8ZzWt0bk5w19m89ToXUw9Z3H3J9/T4sAAoMEkfyRRB
 siDS0QPBPa6iad9QWdaLggqQHsS9I13Zui/bMsAA2Y2zpAFver18es5PoluirVwI+6Mq
 esmzDqk42FWcd1bDlupnbpiHvpgVGhuvwQcGxrBuYnAzqSzabvZE5Js16Ch6IflW5+ZH
 UytE1iTQeSQO2Iy07LY8dqseDnK+adJ9Rwl2K0WAsoMeol84LjH/Qs16Q3oVx5Y8Slb1
 UjHLeNO+aHGxW23EMvUpoREybu/v06RzyRjzlL0P6YVK2LziZU8XqwmDIpzymmsH9sT7
 J76w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgYTZGzm/upTxqS8TNsMK69F+Bd/USuE8G62xNzVMkycVOSD22Ig5W8G0Pr0dCFbpCAQ27iGg=@lists.denx.de
X-Gm-Message-State: AOJu0YwGXZct/QBoEfABn4ZNWG8xnHUt2ax1YhvdMcJPT0gGYjAt4dpR
 vTv+a1iNKv9iZj2B3oD605UuI7mryGKBpmiA2277nO0Xph9I0On8L/P9R0jJNjZncqM=
X-Gm-Gg: AY/fxX5MeYTtD3hcuH6GCRWgYtqJh9tNgGqmrXeCYtok/Zsu3gwrwzZxY2m5xS2dZj1
 EpuR3909MSV5g8Nv+W1dF557BeMfmfHs/+M6G4QCdBxF6+4pJcBR6LB3x5m8iBQjx5J7JMMJ4yI
 LacKjSrMnqzO3Ug5qLyyAHn+VjZka/O26lqoOGZMXofN3hORYcCCnmeq37dqv1fXPWCH/OBFtUW
 LItLfT6kZrtgbsDLrvz91q9Dq+j+GSZtWxAmPiRuR8MoajAqo+AFTdJoeslk6ECvufbBpV3bwjg
 /zhWRBa7VU5P+/bM42skQgF0VArVqHNUcxPqvx+o65rIGx7PWrRl41k7whh/H7ddh6qSEDUHYM1
 JNYQXRNkmuF+5F2KuRGxtUNyaNh/4ZDvFl5R1uEPkfK8iEkjaY8GrYNiybG4HUboDRR7GcQkSKu
 C3FGkeZsWoNKwq/iGCGIOTtbDvh5gnri6kwqJhYvGsKXxphq7P6qO9CuVrVnSj4DA8yoVFNPRrW
 XtHAodACjo6M/kUSAkf6FKBnimoedCb61JEV2WJQu93MTNUEQ==
X-Received: by 2002:a05:6870:808b:b0:404:1da3:8005 with SMTP id
 586e51a60fabf-4044c51ebdfmr3372150fac.54.1768667515576; 
 Sat, 17 Jan 2026 08:31:55 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4044bd150dasm3953764fac.14.2026.01.17.08.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 08:31:55 -0800 (PST)
Date: Sat, 17 Jan 2026 10:31:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: ansuelsmth@gmail.com, u-boot@lists.denx.de, Ray Liu <ray.xy.liu@gmail.com>
Subject: Re: [PATCH] arm: dts: an7581: set r_smpl for MMC in U-Boot
Message-ID: <20260117163152.GW3416603@bill-the-cat>
References: <20260102132500.5794-1-ray.xy.liu@gmail.com>
 <20260117153342.483307-1-mikhail.kshevetskiy@iopsys.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gZww0g7+jIhpa3TC"
Content-Disposition: inline
In-Reply-To: <20260117153342.483307-1-mikhail.kshevetskiy@iopsys.eu>
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


--gZww0g7+jIhpa3TC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 17, 2026 at 06:33:42PM +0300, Mikhail Kshevetskiy wrote:
> > 			reg =3D <0x0 0x1fa0e000 0x0 0x1000>,
> > 				<0x0 0x1fa0c000 0x0 0x60>;
> > 			interrupts =3D <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> >+			r_smpl =3D <1>;
> > 			clocks =3D <&scuclk EN7581_CLK_EMMC>, <&clk25m>;
> > 			clock-names =3D "source", "hclk";
> > 			bus-width =3D <4>;
>=20
> On my AN7581 board, the same change in the ATF-2.10 source code causes
> instability in eMMC reading. After the patch, in about 9 of 10 cases, ATF
> is unable to read the FIP image and load BL31 and U-Boot.
>=20
> So, I am vote for reverting this change.

OK, can you please post a revert and note the instability as why?
Thanks!

--=20
Tom

--gZww0g7+jIhpa3TC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWu5cQAKCRAr4qD1Cr/k
CjBjAQCGLHBjm/G1p+EWShd0oc/vnWK2PLBm49/bRJux3J8VqAEAmI3FQ+1hJ2qy
/p4B5biDKdJClNaqXX09CPQf33FiQwE=
=34Td
-----END PGP SIGNATURE-----

--gZww0g7+jIhpa3TC--
