Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76470C021B3
	for <u-boot@archiver.kernel.org>; Fri, 21 Feb 2025 20:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3B48807C4;
	Fri, 21 Feb 2025 21:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VCpYgMAy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D09C80EC0; Fri, 21 Feb 2025 21:04:10 +0100 (CET)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A27B806FE
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 21:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc3db58932so3884084a91.2
 for <u-boot@lists.denx.de>; Fri, 21 Feb 2025 12:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740168246; x=1740773046; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C7XeDUE1Nxc9i6CZBR8RuVNu41opI6/H0YlRJ/uqZuM=;
 b=VCpYgMAyTJ+rmK2k8AY/WZFKKwLQfgbrzUqbvUpoZyD3ndOYdsJwKrINb/XaoLh4Ie
 L+4O5Kd2PE2+I8MyU5kX/2adYtMvmIs2jxlqRDtLKWQW+0htC5cTIBcJBshXNgaNFfM+
 Nhbdgg4Muou4d7nK5oPk2eUtd4T7+0kRwx2Cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740168246; x=1740773046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7XeDUE1Nxc9i6CZBR8RuVNu41opI6/H0YlRJ/uqZuM=;
 b=EPDfcZ3tGK/9e7LzZbe4ME4utRcQWh2+bkIgByQ1ftlv2Kt2jkqhzKZiR4gzRgGkmp
 21dq3Ub5o3CYLexhOl27rxoE0lPYVJWQ2mKNfJURQ4/77a/0PFA+hFJ4+dRgDmyBpA2T
 LSbZ1DfEYSzpXlAxvi+cO+Y1GeCHSlsVDkVhHLYbjGBjJ8PRDhMXiiVGnvhsYXz8erkh
 D4as1oy1eiJTPiHEmkihZfTic/0niJKw7jr73p3zaxp9GctB8Td/VF7smBIz7bSNkQ1C
 iH5M22MT5FpUdrDNmd8m27qH9+1Ro0rt9UXsVyXblFNg2TaFN8c6MosXXej4k7oPTWuz
 UODw==
X-Gm-Message-State: AOJu0Yz2lriT5zaYkTy9sDwqA9mbKxd0nlGm3MGQ6jAMMUSAvZ5TJwoY
 w8+c0RL4DKxA+9Qouy3R5r9Y33cc2wIl2s7Okr+sgTevIoqgT55q+fLCo6OR4lNotJDP/sJrwwz
 UwSA=
X-Gm-Gg: ASbGnct7EFD6eb46CKF/IHgNrrPpf6lhcG0IJ1ZxATOKagGD5AhNNhpb6k6/7ynupni
 RYskDpULGfruRB/JL20vPIilSL7TsukUTY3Lnt/DhqA5hEgxLm63UkSp0lcns2nxX0Onb8bL7p9
 Gdw7iv4XaD+0pekOBcdaRND5Ol3fdvJzCdSUJCp2IFuqkLCEiMSgL3cMXs/ZxwcdX65kepcjck0
 p4/cGx2UecNxOlmWJK0+oi5Lm4XGxoxb5L4wUZiXkx+77fwl9JhF6IqkbYiS5a0yqZrWk++6jcE
 CzNiugJOt1XZQJF4K/CkGNv5
X-Google-Smtp-Source: AGHT+IF1Lehiy0xWonB5q5qZR6W4LqlWvI78mWx/7J6hX7diBJE88sHp4fUxAQtirdzHSdJYnXwDZw==
X-Received: by 2002:a17:90b:3b8e:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2fce7b051famr7328453a91.25.1740168244531; 
 Fri, 21 Feb 2025 12:04:04 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fceb0606aasm1809904a91.28.2025.02.21.12.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 12:04:03 -0800 (PST)
Date: Fri, 21 Feb 2025 14:04:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, seanga2@gmail.com
Subject: Re: [PATCH] spl: return kernel image header size in os boot
Message-ID: <20250221200401.GQ1233568@bill-the-cat>
References: <20250221151752.2618666-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CSXhOXKeog+XBL3d"
Content-Disposition: inline
In-Reply-To: <20250221151752.2618666-1-anshuld@ti.com>
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


--CSXhOXKeog+XBL3d
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 21, 2025 at 08:47:51PM +0530, Anshul Dalal wrote:

> During kernel build process the header size is computed including the
> BSS whereas it's removed when creating the uncompressed image. Therefore
> the size of the uncompressed image on filesystem will be smaller than
> the size specifiedin the header.
>=20
> Therefore it makes sense to return the header size back instead of the
> file size in falcon boot.
>=20
> More info:
> https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>  common/spl/spl_ext.c | 4 ++++
>  common/spl/spl_fat.c | 3 +++
>  2 files changed, 7 insertions(+)
>=20
> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> index c5478820a9b..6d8d6544092 100644
> --- a/common/spl/spl_ext.c
> +++ b/common/spl/spl_ext.c
> @@ -17,6 +17,10 @@ static ulong spl_fit_read(struct spl_load_info *load, =
ulong file_offset,
>  	ret =3D ext4fs_read(buf, file_offset, size, &actlen);
>  	if (ret)
>  		return ret;
> +
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> +		return size;
> +
>  	return actlen;
>  }
> =20
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index fce451b7664..ddf85e2cece 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -55,6 +55,9 @@ static ulong spl_fit_read(struct spl_load_info *load, u=
long file_offset,
>  	if (ret)
>  		return ret;
> =20
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> +		return size;
> +
>  	return actread;
>  }

Some image formats include information about the BSS as well, and others
do not. But this is just having some parts of SPL return the filesize
and not doing some deeper probing. Given that usually problems like this
arise from loading contents in to memory too close together and then
getting wiped out by the kernel BSS, what's the problem situation you've
run in to, where, and with what loaded where in memory?

--=20
Tom

--CSXhOXKeog+XBL3d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme43CYACgkQFHw5/5Y0
tyzM+gv/UIGQF8V0PrEmi3vg5sIy3DWEEqHVK6m/IZXmJOiBIIaOrAHdmaB6JzIY
ckfLUjSZ7RVLJfuskSw8UDKaXvtq37EEThwQuP4ArkbNR8lcE0U/6Nnl8ODcbSj5
x9tLRpb2XXG7mZp1vvF96ZMunMxdx50O0hrV8YF7kEohwAl1ZGQvRghMU0uCBwd4
cJn+D718kWvGYn/eCYJWEVR4LBKh0O5iFnuuxK8IZv+DzGUS3O+lfYbqPHCSc5C4
WX3zf/Lvr0aVR1iWnBO9WitxkwIgNv8ywylOpunYCoxw5G1wdi9KvwGRVnxn9dMO
1DyiVlphNbtcEC6ho7kePn100GMzsae8hTR9UJOY4avQggYLPQeW0y9EndKS8RFg
l9760XNNjMc/OoxZ4iZewvDfBOHxyUsBvm9MqRIa4/uh/POV2yWxRngGfK06SxtM
+l4Rij7oSj+cZ5q9L2zsqVSsouVyAo/yte+DzZlYKK9F5H09WWLmhX8akkGubiq1
ZGBROlZx
=t3kU
-----END PGP SIGNATURE-----

--CSXhOXKeog+XBL3d--
