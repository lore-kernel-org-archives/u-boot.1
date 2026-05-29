Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B2BCD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 18:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8957846FA;
	Fri, 29 May 2026 20:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NcOKi9ek";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D78A6846B4; Fri, 29 May 2026 20:46:52 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B09884693
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 20:46:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-485fb0b20b2so140336b6e.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 11:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780080409; x=1780685209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QHkcDavg9smNrXDQTKd6blgkrRW8yuIcjZQiH93ul/w=;
 b=NcOKi9ekEcD59dcBZrqPb5hpkmq5vjYczWTis1x0S2fOxcVcxHO9nVrqBgayVrEO+k
 eHTdqtEQCss/uMKkv4CRYk6JEiY4VlDhWU7aoOgnhdlrAjoZJjMXwzx8BdxwxMLz2TaS
 T1wS0eTPxxMQEIbRzjxwy+Jr4En0izMxXLng8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780080409; x=1780685209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QHkcDavg9smNrXDQTKd6blgkrRW8yuIcjZQiH93ul/w=;
 b=RE5X2ZcDmcnfHuMTXBq+56siQS+EQwlPw3+UJVl/ua3N/eT+trANe+phNJ89uKuOYn
 130ZVgvMOy0Os37vjGulUV2OWLHQ2DcEXpnm5Xg0KyLzYHmuKs9lDfOr/IDwyzGzA1Ao
 ynLpkDTB8wPUNbumHavtTQMkC0Y12oR5AJZlNzKmxBkWgHI1rOhE9AJjupF0IfSJkzKU
 1igf7Bt8ZfhN2Wx8rRE2V+Y0No6hR7TgyYgT4YMqTdVUSzbvq/P+NFmlddA4yHNzbQUh
 SFvifHA4rU8oR62N2qUL+h7bTVt9WDuLK400hd5xVXo2GrWxtap+52+TuJGZFoyAjF/t
 Ydqg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jJhG9dwFRN1ailqji52eEkSEEbLfwROB59ySrHyUZGXDaYFuBzOwaO+hIm9sq9iwV/6qblIY=@lists.denx.de
X-Gm-Message-State: AOJu0YwGk6Fq18Y+fdIkFxPJIzjO+jYuL+w86QjVwSTS3s+KSnKhB/7G
 UFx41llDEsIfWPjRkxmdcKfxFM1KL38/gLZJA3MljEeQcZ2AO69nV3lcDUt6FCY3NKw=
X-Gm-Gg: Acq92OGvrniTlC9VXiRdMQkibv9E08qfwA3i4HY1c4bzkD6mNlLznp2htD/enq7dA3i
 F+AQPQxxU57qJMeipMgpOn3YuNAst6stFpV/HXxm7FfeEWs+hQN1+H5jsJUmpTyRXKyw2jUIjaY
 hqcyUElrCsaUb00mq5cTxdqfveYLPhSQ0aTN7VN89Sj3XDYjSVOMupzCKJbTKSW5u2XI+oEcd9x
 Nh2mvX3TwEjKVZthLC1ZiJky5SxGNm1EliQRH5WUtNxYtMZPweWhwwxzgn/NfoAPwh7CdbSR/zr
 cwpYb4JFa63t82nn5YraMHvZavW96nN6p1zmczTcy7Vs3qLYrbPpW+ejIjHIkSYVPfdDIFcsBxQ
 vZVjyKpYSSL3M1ETw+c7eOK29rZ7C3VI+B2GoFidP6TTdvysMqqi/LwnxyXCbeTl3Qg9N+ua3HM
 S7TdkhvJQT1ohnUyc2CRLsbBi0T80IYvWcApaLcIX65FIlDK8/YGZAoVmygKiyuFlZl3uJr9Ksk
 MBXrtZOH9sujgs6uuPigSWIOtm3pANd7v0O7bUy2ayQGrxzJgdcGnvV
X-Received: by 2002:a05:6808:c283:b0:46a:869c:b576 with SMTP id
 5614622812f47-485fb25119bmr437404b6e.2.1780080409132; 
 Fri, 29 May 2026 11:46:49 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-485edc5f6acsm1088977b6e.5.2026.05.29.11.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 11:46:48 -0700 (PDT)
Date: Fri, 29 May 2026 12:46:46 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Matthias Brugger <mbrugger@suse.com>, u-boot@lists.denx.de
Subject: Re: Pull request: rpi-2026.07 rc4
Message-ID: <20260529184646.GD627328@bill-the-cat>
References: <CALeDE9OPBpdJbXawZRRAX3M5FNSMqkMbAtUipCXeeOZ-b=Usfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KDDHjzKXvjMHXZXU"
Content-Disposition: inline
In-Reply-To: <CALeDE9OPBpdJbXawZRRAX3M5FNSMqkMbAtUipCXeeOZ-b=Usfw@mail.gmail.com>
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


--KDDHjzKXvjMHXZXU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 02:27:32PM +0100, Peter Robinson wrote:

> Please pull the updates for the Raspberry Pi.
>=20
> Updates for RPi for 2026.07-rc4:
>=20
> - mmc: bcmstb: Fix non-removable check in bcm2712 init
> - mmc: bcm2835_sdhci: Parse generic MMC device tree properties
> - rpi_arm64: Enable MBEDTLS/LWIP/WGET and WGET_HTTPS
> - video: arm: rpi: Add brcm,bcm2712-hdmi0 compatible
>=20
> The following changes since commit
> 76d62273bc8a5dc126ed79ed0fb65e5a97359577
>=20
> https://source.denx.de/u-boot/custodians/u-boot-raspberrypi.git
> tags/rpi-2026.07-rc3

Applied to u-boot/master, thanks!

--=20
Tom

--KDDHjzKXvjMHXZXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahnfEwAKCRAr4qD1Cr/k
CkG4AP962OzLOKcisddipy68CAtPbwtkzqJbX11iKSBLhrh0NQEAibCR6ViFGVKP
pBlkJ4zTiLXFzWE1Dr4LUSbmcN+R0AQ=
=kFy0
-----END PGP SIGNATURE-----

--KDDHjzKXvjMHXZXU--
