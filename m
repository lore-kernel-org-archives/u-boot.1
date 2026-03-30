Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9CFFC97F3
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 15:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E318D83DBF;
	Mon, 30 Mar 2026 17:06:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GSEmYzNY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBD9183E7A; Mon, 30 Mar 2026 17:06:36 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1225283D17
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 17:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-4094b31a037so3309023fac.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774883192; x=1775487992; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LA8jP/vT7lGGbwSMDJerpBoJSEd1j7lk4q6lW5N1BwA=;
 b=GSEmYzNY3sFGSOhlXqWEoIDPoqNfoLOC5sItcjMZBKotVB3YxwHzzIljlN9KuC8dTt
 PD3wBH533Wu8F4/AIl9ugNuxDNyLLU6gV7ftm+LN0ji1JK0LOgwc3832TzIIKy78uLV7
 NcAF43vIioxRiIpExUOzwdMskWPKXF7BuMkBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774883192; x=1775487992;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LA8jP/vT7lGGbwSMDJerpBoJSEd1j7lk4q6lW5N1BwA=;
 b=YNh7dCqNP8u2OAHu2U6v/J8SJKYCEohbYKbDI7HQ4oY6dwWY5Zuruw2bgB+3L69s1l
 /xKG3rh+NNwfyC/DmFhakycoaEsnmJBCy677+T/XRD35q4CquRpVcycQnbQ2+rS7ljhj
 RXuWfB90EHjlUj9Vk5ubMyvtcKIUVQuQ9k1jNVxj8aWadFIU18PlAeE8R9z1UIiGprgY
 OGVdDhzRwoHZVWbrzobBLJRUtJZ0aRWKHSmtBS30ZASciEbsL1t0vegh4uUfxQ+sutsG
 bNzCHfYmdGJf8gidW5Lt+rY0KBmx9piCd40rlu+BPwYQnjgmir7RQ3hQAThxiSs175jn
 2Sgg==
X-Gm-Message-State: AOJu0YzYEfkJkF5yrEcTPw2PaH9Ue4OO76UlvFDVjJD5uZDdNQJLwfF9
 gfTDfSUbxJfoUKizfXm9tdLjwrIwnf0P3iwPLuiz2CrRwaGxnNh507heZtbaWiFAGaA=
X-Gm-Gg: ATEYQzwfm16LHQKY6cwlvj3Du9hBrPw6jrk6IDtbX7Z+Hyc/FxhSl2I7OP99Od5wXfD
 c+lxlAsonIUBEEid+JCvOxMe/GRsc7NTcziPmJ8b6c5rM2ml0MqWyZuRHrQngfx8p/Jf6TLaSTU
 XsMeXUWGyj+LsC0RNEuhVjOs4WKX5D+vx8C8Dz4auPD/CsKijodJbiucgvI010IXSAt6V1Ii9zz
 iG6nN4OSFr88QdD2CbyJt7UmJLLUZZnIOSEy72+EmTqDDxUV2Y1xxl5Uz+Pat/Pt/0VkaaCQkpz
 QD0UpcyQZewCk3WpXA8UPCRgJ5zQAdQxuZDmkuymsr89cB69GgUsAQBhlMr+8y26uVrmy8ezSd9
 q/IrbPN0e4e5UY8RgP80u6uAVf/BKKpFj1qVq8J092SyiE5UG4rDuVbnP0tTU4qmmqPN7V68o+e
 Et+JRXB3Q4VrnjIGIdt7v3jMGQBoRgNfJo+xdW+/bwySy7K5bbhvckmEZLGyTzaClU6PNtXAmUY
 QZafVoJJvV5mHwOUMiPwZYzFxWfVPX/HbhbFe+5siXUHvoZ5FodLgJnZbI=
X-Received: by 2002:a05:6870:658a:b0:417:3fe7:3c4d with SMTP id
 586e51a60fabf-41cec34c69amr6695546fac.38.1774883191747; 
 Mon, 30 Mar 2026 08:06:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41ec1cb054asm3892722fac.13.2026.03.30.08.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 08:06:31 -0700 (PDT)
Date: Mon, 30 Mar 2026 09:06:29 -0600
From: Tom Rini <trini@konsulko.com>
To: j.ne@posteo.net
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>
Subject: Re: [PATCH] powerpc/mpc83xx: Move alignment padding into
 __u_boot_list section
Message-ID: <20260330150629.GB41863@bill-the-cat>
References: <20260329-mpc83xx-align-v1-1-9935d9db5310@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="i9L6mgfZybpTBgqy"
Content-Disposition: inline
In-Reply-To: <20260329-mpc83xx-align-v1-1-9935d9db5310@posteo.net>
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


--i9L6mgfZybpTBgqy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 29, 2026 at 05:04:36PM +0200, J. Neusch=E4fer via B4 Relay wrot=
e:

> From: "J. Neusch=E4fer" <j.ne@posteo.net>
>=20
> u-boot-dtb.bin is built by concatenating u-boot-nodtb.bin and u-boot.dtb.
> u-boot-nodtb.bin, in turn, is generated by objcopy'ing the contents of
> u-boot (U-Boot in ELF format) into a raw file.
>=20
> In order to find the bundled FDT (u-boot.dtb), the code in lib/fdtdec.c
> uses the _end symbol. Platform-specific linker scripts ensure that _end is
> 8-byte aligned, which is required by libfdt.
>=20
> For the PowerPC MPC83xx platform, the ALIGN(8) directive was outside a
> section, with the unfortunate effect that the potentially generated paddi=
ng
> bytes would not be copied by objcopy. This resulted in a discrepancy
> between the _end symbol on the one hand, and the size of u-boot-nodtb.bin
> and thus the starting location of the actual FDT on the other side. Under
> these conditions, the FDT could not be found and boot would fail early.
>=20
> This commit fixes it by moving the ALIGN(8) into the __u_boot_list sectio=
n,
> which is non-empty and thus copied into u-boot-nodtb.bin.
>=20
> Signed-off-by: J. Neusch=E4fer <j.ne@posteo.net>

Sorry for missing this when trying to fix up all the architectures.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--i9L6mgfZybpTBgqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCacqRcQAKCRAr4qD1Cr/k
ChZRAP9WXUdjJpDt1gKj0eFidPAR9qlIZ2LqbSetcsjpv8+sHQD/W74+adA40RXO
yG9cGqV7/Alfuk4RZDEGV7tl+7FxggM=
=NRHW
-----END PGP SIGNATURE-----

--i9L6mgfZybpTBgqy--
