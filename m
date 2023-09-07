Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FF0BEE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AAC3869C1;
	Thu,  7 Sep 2023 03:53:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uoD0437a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1543D86989; Thu,  7 Sep 2023 03:53:08 +0200 (CEST)
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com
 [IPv6:2607:f8b0:4864:20::b32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0831E869DD
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:53:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-d7e741729a2so456062276.2
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051584; x=1694656384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pYP+P0XsbbrX9NUPxewz+R7CIofFTyI4+mv6tZBC3vk=;
 b=uoD0437agBBrQh4cCurPieiZefeIidPdbt4TgYq2J4KO8u3jKoeQJm+ossCT+nGsAC
 ubMHSwDgOCZKwUvY3/vFUFNdxyZbCDf7dJuKkhUJI5u+0cakSmcUR8IexG+Gju+xVbSu
 U4HnOb3+Au6hiBOXfRgi4ohzrR808jW+wQTE0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051584; x=1694656384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYP+P0XsbbrX9NUPxewz+R7CIofFTyI4+mv6tZBC3vk=;
 b=LKqdJf8P9MlnmMbl+8xRc8q7iZv4gJOVCw3i34o206emczkZsxcSvCqNu/r7xgnGz7
 EcnE1z/xdX7rUx/jdJe0WNNEboiuB1c6ScG+gb3oZJpIzRz5Q37kOXpWEp1Zi0VFJt/q
 t0ux1qv7HC9x30e7K2mcgY/8zItWTLYFOMldRbU+JBNCpqY0LvzmKBT+TS6nwfukwyoG
 jQ5F8h85z5QX6i7zD7A3onQt1YxVaVlnYrGsnmYyhVM+SP5PHDTdQPadjdnbWSeoSeIb
 Wm54ZjCmoPJBszbBrlF9u+d3Vokepe/miBnL2m5u4Pt4g9ihN3EQhuX85e30FrgPku7+
 clEg==
X-Gm-Message-State: AOJu0YyXlxnLbO7XzLpCbOXRifAc86fpXM54mUQBGb0QsnhHnn3au0gj
 fKhkzQ5dtxtPxYA8+pDyxD2thQ==
X-Google-Smtp-Source: AGHT+IH64bJau8YkAyP648Ij8i2H6FhuNLLyIibn4gGaCKbW3uQnWCMi8a53HdATBFJIr4uEeTPf/A==
X-Received: by 2002:a25:d041:0:b0:d77:94d6:aa4f with SMTP id
 h62-20020a25d041000000b00d7794d6aa4fmr17795429ybg.32.1694051583735; 
 Wed, 06 Sep 2023 18:53:03 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 133-20020a250f8b000000b00d7fcdc8e17dsm396485ybp.37.2023.09.06.18.53.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:53:03 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:53:01 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Mario Six <mario.six@gdsys.cc>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] test: dm: test-fdt: Use fdtdec_get_int() in
 dm_check_devices()
Message-ID: <20230907015301.GP305624@bill-the-cat>
References: <20230823193744.64172-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RgP1U6F32NK0N9JN"
Content-Disposition: inline
In-Reply-To: <20230823193744.64172-1-marek.vasut+renesas@mailbox.org>
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


--RgP1U6F32NK0N9JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 09:37:44PM +0200, Marek Vasut wrote:

> The current fdtdec_get_addr() takes into consideration #address-cells
> and #size-cells for "ping-expect" property which is clearly neither.
> Use fdtdec_get_int() instead and return negative one in case the
> property is not in DT or the platform under test is not DT based,
> i.e. mimic the current fdtdec_get_addr() behavior.
>=20
> This fixes ut dm dm_test_bus_children test.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--RgP1U6F32NK0N9JN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LP0ACgkQFHw5/5Y0
tyyc5AwAr9ahmdjlikdVnBZ3nIJwxM48+ZzswQs9sld3eitbEu1LBDp1KJHCSQGA
DtExibFenJitvRqnjp9qPvqLZ2pjfa409LI17d0RZ3rM4ALZiVWMjhJVU+rdVKQ6
+CqtaQ70EaYBMQ22E9vt5aPPUmt5ujudmy1/tZaXsVxmXl65iN0Gleumkhk2Jwq5
vsl3wclc76rqY+xMD076Hw0wTnshRTVpnyl6GOM5jfmCmhr0WG00hMjGMKZRB/L8
ZD5zHqHxeRSIeklskCYcrdlYyCgjTnEGPqeV7lQukXNdGT0tUPwNT5+wyd0dQZ5J
qMEo1A1DtEWgo9SjachFpATpULgy4nQNVc7DQJj+eklRsmVvLV0KMYtDx/ACK8mu
jGdbZOivc73gF804cOyuwEBjOe4MDO4ih6ygjdUMK6xg4OHoF/gKlR3hZsD8k2ox
UN2vCXuZ0eG+ZLL0X+CWImKhDjzkoWeG/oirXpFa2MKeHfnlIULxuzHMuaTlQhOZ
BRzlrEcp
=VL73
-----END PGP SIGNATURE-----

--RgP1U6F32NK0N9JN--
