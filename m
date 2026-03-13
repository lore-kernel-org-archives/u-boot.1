Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F60105F7B6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:16:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CE36839DF;
	Fri, 13 Mar 2026 16:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eyX8ruJQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 604F9839DF; Fri, 13 Mar 2026 16:16:05 +0100 (CET)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE9FD8341A
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:16:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-46726528f1cso1623030b6e.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773414959; x=1774019759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/xUvwfrX0rdPXeGtplU0ESaaFUtBXOymHW4+P7sqUAQ=;
 b=eyX8ruJQ0i7xDm9KuWmwxeKYsj+tVum0BMqlXmRYWmPJq/mYZaRIl+9lsLAJ6IancV
 N510WndvCuUBdIQhnb8sIs6RPKXLgcqg4Dzh9Vf5VnUO+HS1WlbfccYRrajyn4wul2J0
 3u/w1gQqvuP/+oA7ZNN97xmvufLzxgwAY1bMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773414959; x=1774019759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/xUvwfrX0rdPXeGtplU0ESaaFUtBXOymHW4+P7sqUAQ=;
 b=HoDAS4GbvbZ0h+YMVv9L0wDANTO/RaCUVa2tPjsG5K2VX6joOun5Jf+f1mpfJUHD+h
 pCBJKNwgmdbWXuw4cwtxYmHSC5cxHfZMGOIaldPTp33blCSSZqoGu6m8miQBv+m1xaj8
 CRcLUXAJvFP6eCuCJ7UG7KADpFNpIxZK5mpSOTGSgpf6HFeLBhbXYLqim7GvsKaFURd/
 KBchJK7aSyMK0YHydc/TmqALt4Rn1BzyOjBjF44I2R9JvhmKp8L3WVJsfsDMF6qw6Yyt
 4gNIrqcHfggIhzBb3DYWGfFIAiaLSZeumGRB4OuCvt2H/vD/lbtNj6pwp2vg4YQA7lyY
 ZdJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9K8upZaf63Z7Ne92KbiKp2YWXDB9e3msA87vtueNNdvrxffkFwcyG55aDzRdUoab59bcrzsA=@lists.denx.de
X-Gm-Message-State: AOJu0YyLzP7z62jTjIeNDxYZpyPfwVhAJZJ+/OG+1kNP9Bk+Li4dDDAM
 I/QG36l0tMYoMw2e5pphqZo7+RnRZTSENY8tpL2VSKfXKSe+hBKhER9egdAleXekhuI=
X-Gm-Gg: ATEYQzzTBImRQMfz6J1y1BDtG5A5+Nq0wrQ7rvNA9Xz/i17rqbHmxJhLoSjjeMVGHsf
 qDTQf7rDZE7ZC7b1O/pwmv79Q4ODkWxPSjzesAWgYmm5wUf8Jx+KiBA/V+CNWJ54lu6OvghYidc
 NjuU9tg/3wCd41rwGobqqwNL8W6cA6RdqC0dg7pkWxpXXaKwbvy+KKUy/6eA2FY4/EMBpSiTTgR
 JsybSJPMVr0Z64CYJrzI3OwK15fDBpBU8LF3qTyBQSe7MQeojC+bS1rI4Lo/PgmeWQ6sBzzziTL
 1ZwylciRYBedyMBYTv1szMhuckl+fwmrMBD3IvkR4wlHEfQi5yELhbKIwyCeAYFCwBq0Bhn/f14
 XAT7gS1+uZP+bQGjGAG8HPwrOYXSuSFpXmf7K3I4H2cDJWNYdDE2DI5Ws+NmqftFEaWBDns/ceL
 vPIYXkdPvTT28uU+CsEAFXatL7IhP7yNcb7r2t+noHbAiFfSj7DQmMnBZLtyWGOjzi3Pbq+N9me
 KxrQRqzIXU9DCDVqVlcuSlgsoUw2bjzAVhIDggoayuXyf/6
X-Received: by 2002:a05:6808:1710:b0:45e:b5f9:8a1d with SMTP id
 5614622812f47-467572ede9cmr1982249b6e.35.1773414959278; 
 Fri, 13 Mar 2026 08:15:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467342fb528sm4991755b6e.17.2026.03.13.08.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 08:15:58 -0700 (PDT)
Date: Fri, 13 Mar 2026 09:15:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Richard Genoud <richard.genoud@bootlin.com>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Joao Marcos Costa <joaomarcos.costa@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 3/7] fs/squashfs: squashfs.h: include file should be self
 dependent
Message-ID: <20260313151556.GF502704@bill-the-cat>
References: <20260313104229.1555236-1-richard.genoud@bootlin.com>
 <20260313104229.1555236-4-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AjSZYgz2zN2M+WML"
Content-Disposition: inline
In-Reply-To: <20260313104229.1555236-4-richard.genoud@bootlin.com>
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


--AjSZYgz2zN2M+WML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:42:25AM +0100, Richard Genoud wrote:

> Otherwise, we get a lot of errors when including this file.
>=20
> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--AjSZYgz2zN2M+WML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabQqKAAKCRAr4qD1Cr/k
CnOyAPwLBB51mSuLKnpiaHurcmwvCKuK9MAZOU48j47Vx7jWcgD/bLfVH+q6/X95
C5MrlqdAwrK3iMp4EFr/4esQa9KGmAY=
=WDxn
-----END PGP SIGNATURE-----

--AjSZYgz2zN2M+WML--
