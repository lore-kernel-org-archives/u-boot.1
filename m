Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BD7C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:40:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FAB82102;
	Fri,  2 May 2025 16:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Zv+5/SBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D3E48210A; Fri,  2 May 2025 16:40:38 +0200 (CEST)
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com
 [IPv6:2607:f8b0:4864:20::c2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F0D381F7E
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:40:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2c.google.com with SMTP id
 006d021491bc7-603f54a6cb5so1316757eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746196835; x=1746801635; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2Fq/ZIMBo+1VnqCfucMVqxQpN7C/+U+lQBfW3mcWyz8=;
 b=Zv+5/SBa+rJtprpMUmIgKFunZ4JAcywtgHTDjLTtVRVltjVAPmTTa+8GfcFucVLdkd
 0mi5YjCmom/wr2IFYaDk+K8kyYW4HJ9U+79Arqh+D6NcfZaM44hTenYbUJLgBGdH0nkW
 uP5CG/psA9egIrd/Pv+FWkNFduuDXefDYIVKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746196835; x=1746801635;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Fq/ZIMBo+1VnqCfucMVqxQpN7C/+U+lQBfW3mcWyz8=;
 b=OlTBu7cYQ0ZPgAyUzhaz6gwegvQKHJolWVd29/tiIrXWddB/HMPbW7RB9zfdbo0t3z
 FNfvGa3c8WKcrAa5uQyLY+YFJkJjaVUwXX8vGcf8yLXoM2FnQw8QbvM4JAe5xELnZQwg
 xpvT+L0o6pw355MVDclFqhP4gy377RziZpKYQADJOGoljWjjM0As3JsoONDscAnB+PbB
 lRbVxUHyALcB0Vhyz4Wn41qI707/87IcAVBE63l9pNNqw1x+Pm1+6PBGh9K9d6VWrPhe
 3ij+H40DrxsNuyoDfNFD5mWcTSyXwBkX9P48S1pV/f/BemzZqEPkE+lsXOYVm35dGe26
 17Ww==
X-Gm-Message-State: AOJu0YwQ4GE5MlzBxikmEuKsdS1oG97CjiCCEKWLhm617G4vfZHyM4x1
 3b5iZCp/75ijqjwULH+6zH5jkv0o/fNnAx09XsYMIx//mS9bhTXXoLAQLoOzWAs=
X-Gm-Gg: ASbGnctEeUg2tDYgt1tZ2huAhUCriAPeo+l8bTT4nRFpBkxemoy/qLwZXJiOjlbQR51
 pVxKX+m9qNierGIVk87VIwcviR8PSp9wD+YwSYgLePYZieeFUqj8OtcuBMW6+k5JzaD0ak11DPb
 dnWHjNE/x7mYOxQBUyR1Wu7X6wqbAQeCkanzqSu25wHHW1pILKUZOe9v78pZMI+MViUfG+zXBC9
 EY7OUI7gxNMfybuBX44Bi4dCVWWAB86rt0GTThisD6LbiDjDosbr3gfsDJTpKIEWM5AGQDQEkJh
 AucHQEGcPNdwCBxdQctLEic7S8ct2PBRtYlfn8DSzhpSwzGuIqS40JKI7x+j/axV4EnqOyItFDm
 8tg==
X-Google-Smtp-Source: AGHT+IHZO6Qpd8LQmrJ4ge5Mxa6sUyDEU+4ZPo8SlOlaZ8SkW9oPzEe5kiHVNpsr3/ytH0Pk4wGmYw==
X-Received: by 2002:a05:6820:811a:b0:606:85ad:881 with SMTP id
 006d021491bc7-607ee5132dfmr1501308eaf.0.1746196834806; 
 Fri, 02 May 2025 07:40:34 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607e7719bfesm539294eaf.0.2025.05.02.07.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:40:33 -0700 (PDT)
Date: Fri, 2 May 2025 08:40:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Bruno Leite <brunosampaioleite@gmail.com>
Cc: u-boot@lists.denx.de, ravi@prevas.dk, probinson@gmail.com,
 Matthias Brugger <mbrugger@suse.com>, clast@prevas.dk,
 Bruno Leite <brule@prevas.dk>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH 0/2] Add rpi5 specific defconfig
Message-ID: <20250502144031.GT1261075@bill-the-cat>
References: <20250502113556.134731-1-brunosampaioleite@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="j9RgRiHllrbPP0SX"
Content-Disposition: inline
In-Reply-To: <20250502113556.134731-1-brunosampaioleite@gmail.com>
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


--j9RgRiHllrbPP0SX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2025 at 01:34:33PM +0200, Bruno Leite wrote:

> From: Bruno Leite <brule@prevas.dk>
>=20
>=20
> Currently rpi5 uses a generic rpi_arm64_defconfig file that builds rpi4
> devicetree. Add a defconfig that is specific to the rpi5 building the
> now available upstream dts for that board. The defconfig makes use of
> defconfig including that is now available and only changes the DTS
> related config.
>=20
> It is also necessary to add a more specific u-boot.dtsi to rpi5, since
> due to the ARCH_BCM283X config it will try to build the
> bcm283x-u-boot.dtsi and break.

My question is, can we not adjust rpi_arm64_defconfig to be generic
enough and not have a problem on Pi 5 due to the default device tree?

--=20
Tom

--j9RgRiHllrbPP0SX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgU2V8ACgkQFHw5/5Y0
tyzgYAv/WBYa/O0jQeyEqlHiUFU2VC/WGOjK1PBuvtWjTerc2yqe+J5St15nxcLI
6n4UDmEmZjHUD9TAr3+JcIcccGkUBtc+bUEIuQbgkXXv8GP+24RsDNWYGy8pVOiy
374JG2K6KlYKXIvXxIXHKXzjNCI73zJ5L2NWp/XLqaADwQ6ijv8Kr5XDv3My22tB
OdHTLnO+mN4EFRfcwOwz8xCADhB4iQVtmxyaQhW0fu4BS8BwnomRDrIvgvyXr2vL
xpVUkfK2Vd2fMbNQs6+eVekfwFG5KgYMG4hm6GfwxHFd+Z1n2/VDQU/bmHdbA4q2
o2IRpRuch7K7HAyVPmt4+etDiMnXe6rWKfCud6/z6J6ibYf7hfFlqff07EbJWt1s
h+PEcp0EpCIEKuHPHli79ucWPgF+alW6RNkWIZkuqfB0GjeGP3Fx75naU7WWuYjH
ZX+St7kdE5Ud02K2Lc7Xq+7km/eMk1bZPs43it8yYNHDGAshJoWSrK4dZOvwFs+n
XLlqj//x
=wH/s
-----END PGP SIGNATURE-----

--j9RgRiHllrbPP0SX--
