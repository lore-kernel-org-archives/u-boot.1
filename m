Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B26AFD4F03
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 16:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC7A3840EE;
	Tue, 10 Mar 2026 17:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OokctEsC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC9418410D; Tue, 10 Mar 2026 17:08:56 +0100 (CET)
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5734A8409A
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 17:08:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-679b072ed3aso8137210eaf.1
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 09:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773158933; x=1773763733; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AXX6NdLjUuRiQMk3/WWqWqZ/f3hstJA4/s8va84l35w=;
 b=OokctEsCHwQmj37GR6rTtwaZJIeNmU2x0jtlnk27uIDU0vQun6MqjusHxcR/GwU/Jf
 q9LCcQIcvEgkqlpEFC4qDxM2xAe9hhQMin5gQRKFiH3ChK1xF9gX+eO90UBptYCqwqiP
 gTjI4McAb5krhTV9jE4Ps4qkRSiwKVQpbXCsg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773158933; x=1773763733;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AXX6NdLjUuRiQMk3/WWqWqZ/f3hstJA4/s8va84l35w=;
 b=Z+9x9ZJBn0xr6tanQS+f3FNEdlW8rbrTKNlTsLUdKpinwEohpCNTpZePOOQSi83l+s
 e7eZW1siZbVzqW5f6dxP4dUM3HolSLluhjfddZ/3mwYeyRyz7wdFjmTuihXxDCD7/fga
 HgefUPLDbrtO6uRl17TQBHywpQTBlWpr8ttfWYrNUh8naHLRx39UwC9RAqKNSg8fTMoG
 FtykNLfOOuHIFOSapsQHpmPt2hyOlSFvZ7C0DADO2EG1D/MRM+5CSFBs3D5lJFRxbksD
 RMCYWgX4bZv0x3ZDX55EoHbOj9yP4Vsy8Z7HI74VDK5YRjq88yIDrtZ0+O3op0Bf1nEu
 Q0JQ==
X-Gm-Message-State: AOJu0Yz0Ohp0yGUSup6zxMPZQaHP4CLXesJrKoM0kRPABuRh0opuZVFq
 ZBYgXU5oO7RqPDC9geIbJE0g+qPGkbwRh/sYyDl4L3cLEzksJz/gXpXpaKkG+kbv2vKBkXkR4Ux
 b2sv/Jgk=
X-Gm-Gg: ATEYQzyQnhfyV/PHJZZasMlWDmbl+nicmMbKaCzAFryDhMh46uG3tXn9JLzG0OXBIbI
 /phC6+rMJnoKpxleRGbvu4EhBPgMAxB8T/uSm4wKugQBE41APnV8raCgFn9Z1NbrPC1lxF2k0a9
 E9u/G3JXnSZYV7TuzIFiAXk/JA90yu7eGog1OD9RIqYRfyszCl+j+i9ykMn8veBai+fhSTCkeAF
 aDkjXPVawUmxDDHOCLup38UAPElKusbBVPqYqseV+I21K/N4VYJTqDlWtqFobCXwUAbJlXKLJu+
 0ir2AP+lArUnvcERJyr30QhubgvWFRKk/C3njVzUTJt9Q3lgCgA0HMtTtywCwMTtX/mOn+uyZe6
 chx/W4YL7/tGVWAquWNAfN6Hnyzv9gg2hoGczguF1jHVbs19+ta7nBwlNRWHaYLlCv9jtATowRa
 qxcsLzeGJHO/6ZItAUuWR8wSYTHnEKclxHTn5dseyVtjBYO4b4Q5plDUKZQI58+5jkDG3I4GeU1
 duE4xB2HAsftzgDtAAmtrCIPbPWUGcJj5tLiVPz12wgmw==
X-Received: by 2002:a05:6820:480c:b0:67b:a8f8:f69e with SMTP id
 006d021491bc7-67ba8f905d0mr5990603eaf.29.1773158932874; 
 Tue, 10 Mar 2026 09:08:52 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67b9d5287a2sm8344801eaf.16.2026.03.10.09.08.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:08:52 -0700 (PDT)
Date: Tue, 10 Mar 2026 10:08:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20260309
Message-ID: <20260310160850.GJ1388590@bill-the-cat>
References: <20260310004832.158893-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dI3rVxFgcZVUnytn"
Content-Disposition: inline
In-Reply-To: <20260310004832.158893-1-kever.yang@rock-chips.com>
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


--dI3rVxFgcZVUnytn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 08:48:32AM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - New SoC support: RK3506, RK3582;
> - New Board support: RK3528 FriendlyElec NanoPi Zero2;
> - Other fixes
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/29452
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit b26cc03b7cecaabdb306c2f68eebde764161a5=
45:
>=20
>   Merge patch series "MAINTAINERS: Update ADI ADSP platform maintainers" =
(2026-03-04 14:25:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20260309
>=20
> for you to fetch changes up to 17b6f20cfefd65987d6976c7356673787fd0ba32:
>=20
>   arm: rockchip: don't use non-existent CONFIG_TPL_TINY_FRAMEWORK (2026-0=
3-09 22:52:22 +0800)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--dI3rVxFgcZVUnytn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabBCDgAKCRAr4qD1Cr/k
CrqfAP9wZk1MYWyN6VXFZgWWhZ64ozuO/tJGauRN3QgvX4gHAwEAyz9jLGG5rbIr
Eq/sGBoWEPcqOUHKGMa/CHRFTZAEkgU=
=tPNQ
-----END PGP SIGNATURE-----

--dI3rVxFgcZVUnytn--
