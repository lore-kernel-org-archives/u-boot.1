Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663BCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 19:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDACA84241;
	Thu,  9 Oct 2025 21:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bK8Dq/Uq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6C0684241; Thu,  9 Oct 2025 21:06:55 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C35378423D
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 21:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-378aa12c13dso443868fac.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 12:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760036812; x=1760641612; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Rr9+UYOOTI8qO5KvmUZTs/vVUTs6hIu9sDHNg14OrZE=;
 b=bK8Dq/UqqOYTQma1DYqyooTuotnmb+NiF1JjF2FWnhUe+RXdFoL095nFYJk2z+8+Ga
 VJJ85rJi+w0kAJYcCOiXjjAaRPcPPzyyr5ZZaXMnHU6tA1tVsgJ+UHmFjHyBpbA/3VYz
 FaZKkv27HgJ6DdpUM15W/g4sXUBZXD4rhtro8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036812; x=1760641612;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rr9+UYOOTI8qO5KvmUZTs/vVUTs6hIu9sDHNg14OrZE=;
 b=qDgvIUdJ8KvnKSJ7LuiVVqAlyJOGcCoVfexgjeo5BuuyDHbjy1Osyvz/0Q9dqdp7MC
 cYD/YBG0WnAq9nd5yzOUCte3oCOZ9WWVoupQTUm2Xsskxn8jR9gdYc/oNT/CtjkoCQH6
 Dx6FywqexVFvum+mGCDYfz4f2ZpryV3hV/ihturw1vri8JpgljnVxNFovHIAoO2SEpz1
 tLtOZQYCSyBdCJdgvh6TvPK8cuM9OoNxusUe3O/bkbCaEDkODRFFYcbsnfW2KkuilRzo
 FI0Dd2IjrSbtyG5SHTf7tm0KY6TtQEMNyVe2z32bjCKwz0/6WoCXaS4LOUJtPNl+jrB8
 kPdw==
X-Gm-Message-State: AOJu0YzM8CxEFNoNi0BySW5JkxxFwtfpFVC5DdC+pnOLOV8IicxKDMmu
 0jHi/eFUOeSUz8q6pk8CvZQp1hZVPOJxZorau9xzSUL0TOMfxf4K0i3oun3sPdgd9sk=
X-Gm-Gg: ASbGncteUfQ2r6IgdGuuJ3wqoVCKUiqxizd22YULa7Imdccqt/WmyAk9D52zmn2IK07
 73z3A9+cUpwGS13brvhQ1Q8Yc6Z2+W603EFJdbzi/1CBpbLpcPtwFAm+A9Vh4ijjTo30Jd/rqa3
 1dKVWpNwCIS9ssgakWpQ9E/Y11dyl2Lu1ZMV77fpph2B95RswejFH2LJxURp4GH2hPp2Vywxo9Z
 8roT6cuF8kEE2iOFo57DLZWc+l4RS6pc+Rq8HQ/rrc9z96Zy0ZtC2xxWNpDz3XiWVkiTiZywT0v
 uqX8WaeyQZMq3VXaheaLjDq6x/PAlVSBcdCKDVz5/wh7XNM8LWlg+7ozWVjIgcVAidb+ZJx6ik/
 azd19Qa+mrfLUM40GHN6OqkwDVt8tEYZTFwDVclx9AOmAejOD/U3TPwOUufwxLJhz4i+JPgfjmh
 N012oQpvyd4g==
X-Google-Smtp-Source: AGHT+IHo2CCRrIvQFRSjro9rY+nA3GrIz3dfbCbaCHGle4xeOGMFX/bzEb5lpupAd11DIgP+PXP5Qw==
X-Received: by 2002:a05:6870:828f:b0:377:8166:9376 with SMTP id
 586e51a60fabf-3c0f6d1ff0dmr4179974fac.28.1760036812035; 
 Thu, 09 Oct 2025 12:06:52 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3c8c8e80a22sm127020fac.13.2025.10.09.12.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 12:06:51 -0700 (PDT)
Date: Thu, 9 Oct 2025 13:06:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Anshul Dalal <anshuld@ti.com>
Cc: u-boot@lists.denx.de, vigneshr@ti.com, afd@ti.com, m-chawdhry@ti.com,
 n-francis@ti.com, b-liu@ti.com, nm@ti.com, bb@ti.com
Subject: Re: [PATCH v1] env: Kconfig: disable external env in secure os boot
Message-ID: <20251009190649.GT298503@bill-the-cat>
References: <20251009123435.960225-1-anshuld@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z5/c0y7PPe/wg1O8"
Content-Disposition: inline
In-Reply-To: <20251009123435.960225-1-anshuld@ti.com>
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


--z5/c0y7PPe/wg1O8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 06:04:34PM +0530, Anshul Dalal wrote:

> Falcon mode uses falcon_image_file from the env during mmc fs boot, but
> external env can be compromised. Therefore disable access to external
> env by setting SPL_ENV_IS_NOWHERE when SPL_OS_BOOT_SECURE is set.
>=20
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--z5/c0y7PPe/wg1O8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOgHyAAKCRAr4qD1Cr/k
Ci7OAP49ariSo3pwayrQqDNdtNRcrSA0HQWoBku1jImI0Zr0fwD9HTnSxOTjbCq7
xlry6rYbdXHA5bfJ1LPDK3CpdvSlbwM=
=Mzpl
-----END PGP SIGNATURE-----

--z5/c0y7PPe/wg1O8--
