Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82BEDC83F2C
	for <u-boot@archiver.kernel.org>; Sat,  2 Sep 2023 13:09:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8BA5386411;
	Sat,  2 Sep 2023 15:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XGFL4/QR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 713C786416; Sat,  2 Sep 2023 15:09:35 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CB2C847C3
 for <u-boot@lists.denx.de>; Sat,  2 Sep 2023 15:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58d41109351so11809047b3.1
 for <u-boot@lists.denx.de>; Sat, 02 Sep 2023 06:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693660171; x=1694264971; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UbZhoArVc6gelEqOWVo5XBEd6MyIZzpaCVGEHyd62vI=;
 b=XGFL4/QRGRTUhjZ8p5wo/OUuigzfE63u+CJiiGqTBvvlgROMuqtwynI0xzAs6Fn9HH
 Ww+Y9P66GzUJzPKwdxZQaJiTcVaRhNPBPenGBZXK66zifjALIbi0hsZmFUtqLFEvcarO
 +zMlHqBLC2qZPywPWihqWF/4kIKleMSUNWCHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693660171; x=1694264971;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbZhoArVc6gelEqOWVo5XBEd6MyIZzpaCVGEHyd62vI=;
 b=VXKALBC4Gl2A6ydli49gWw2cFawxabaYZTQP6R8dpH8yerQQGSMvuM027Z4zlo90eH
 KKBeAyrpH+wohB7ucpQ3+Hcgbv3No5QaJcCGn5O/iNukscxoa0msLiTQwHYrE2i9s1ly
 Du6PJ20oNY/ihgvH9TjT7LR0K/BVd6OiZSpQ3BltpCHAz+NqL5jdKgyZ/PFucWH1i5qk
 8iGCBrjavp8zbrybIvxWxyLL3klOec2D65ho5LdpPjHuft9mr03SFxPzIAd7ihb9QeQc
 GbnEb6Ohb1jmT2hzrkdusS4hQ331eJ0pm9eu4tyN9fGiyUVR7izhN3KULRtbP7cvvOwF
 GpeQ==
X-Gm-Message-State: AOJu0YwSq2huK8qUb7gG4Vvr6SoRbsa6oftbzbUmX0E0AR2WoHwburoC
 2VGoBqRhkZkanYuq5Yv0FBDNxQ==
X-Google-Smtp-Source: AGHT+IHoU/wyIRXKzK728O8kXUvL+83U1bKXO/AO723tSAOJwsUj3okEyK2SQneEMLjU/TcPURMomw==
X-Received: by 2002:a25:cbcf:0:b0:d71:7d2f:c548 with SMTP id
 b198-20020a25cbcf000000b00d717d2fc548mr7941302ybg.15.1693660171072; 
 Sat, 02 Sep 2023 06:09:31 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-9522-bc83-aa36-be61.res6.spectrum.com.
 [2603:6081:7b00:6400:9522:bc83:aa36:be61])
 by smtp.gmail.com with ESMTPSA id
 r11-20020a25b98b000000b00d7745e2bb19sm1331932ybg.29.2023.09.02.06.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Sep 2023 06:09:30 -0700 (PDT)
Date: Sat, 2 Sep 2023 09:09:28 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: Re: [NEXT] Pull request doc-next
Message-ID: <20230902130928.GU3101304@bill-the-cat>
References: <a1e38d39-ac45-4705-8860-8c6688e338cd@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hu2vVcYy2+HOTVN9"
Content-Disposition: inline
In-Reply-To: <a1e38d39-ac45-4705-8860-8c6688e338cd@gmx.de>
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


--Hu2vVcYy2+HOTVN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2023 at 09:51:56AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit b8b512a45358d50bce2e17b5941c5e39b52a05=
94:
>=20
>   Merge branch '2023-08-31-replace-more-init-hooks-with-events' into
> next (2023-08-31 15:10:42 -0400)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git tags/doc-next
>=20
> for you to fetch changes up to edd8149cc686f749c51fafcfbb7802da73b42aea:
>=20
>   doc: board: ti: am64x: Fix build step numbering (2023-09-02 06:14:34
> +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/17599
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--Hu2vVcYy2+HOTVN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTzNAEACgkQFHw5/5Y0
tywCWwv7BSzzpFZBeGsFYvQmEKrACUMAMzLzm1kU2Hj1jkQ+Ked+SZUJ9oCR+jOm
TZ8zqoN+6Lsm6nx2e8Zc1iFrqgX154qnG/fhwDitZnfuo3Wsb+KgbwX+mK1sN9hV
PeB5GupJshDZi7R3n41A+in23pjteHW0DbmA5SPnmBjddFYsQuh98Zzv8G7Ur4xB
1/kgsXTP/AJqh+JsoKfl4yZsg4Bar+BoPcmiIgWuvhHeFGmhBAF7h+YTEslOWv+v
Om5mUXZlceyxnr/Xkty7dkfKqBtsDSpbjKsovZU266pHkVIuVcz0Vla92XF+wGme
RyyfTdOgo0id5L8VyPW9AZGyrTUEuaJ/uh6gPB6ijHlrXBv9ieB1OXZpbXfmMpE1
ZsemBNTO4FVGT8oduoRGkd1mK34PMg6x5JGfh/zukjLRkHWxVK9tNebzncEjqPMZ
EExdTdA4YChnJgBzUcqF0QqgyUN4NeZ2JWzy48SZjhdAZmeWxYmeCgo2oAWwUdRS
lkb70pwV
=6kx+
-----END PGP SIGNATURE-----

--Hu2vVcYy2+HOTVN9--
