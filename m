Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A929C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 17:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 89F3088817;
	Mon,  8 Jul 2024 19:42:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dHzMESmT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B07C8881B; Mon,  8 Jul 2024 19:42:04 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065538880E
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 19:42:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-25d634c5907so2934094fac.2
 for <u-boot@lists.denx.de>; Mon, 08 Jul 2024 10:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720460520; x=1721065320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=64omvwtf0fIrL8bpFmTB9NvXNTKwHPh1n2GnqfgITAQ=;
 b=dHzMESmTurSTgSaScKz9VD+VhYLExPn9jRCnw5an0Xbb3wwBNJ1IT+5v+z18802qo4
 1bnm8j3tTswEJ9KFPOLvUfF40UKXfUdMOuWVu5WtTEacN8eWC1mYdztYnr54A2DPjXQB
 IpsScSnOS7rjC0l13dtoq7OqqGWUCpTDX9COw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720460520; x=1721065320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=64omvwtf0fIrL8bpFmTB9NvXNTKwHPh1n2GnqfgITAQ=;
 b=dAJMiYhwGDTWBfGjchBQy23hGq2h7UqOzXHp+W4zIeNHc7P2DJxDlPfrcQ2nQMU7aM
 6PYHrL8/6UpCMxFQX3OJm5PdR7BdRepRy73b9ED4p5eyDvfp1oKr2zc3FzVsNA6I0IGq
 1XSwStHHXP1dMTXJG3FknUX6p4rqpL1jUgjIrStRlTadNq3iaZ/JUSiU4om1AEQsnSSv
 x1ziZuIWRg4+yOxrKiDHjaOBIx2rZTtQ4vPHGabHVf9ElMqtnmqOU0cxlP4xfTrCCPMA
 7tbNNrcHds/Bp6tK4SOjOvhl/eRjHYixpesxk0Qj7wenUB5Wt/JDKZDW3yXP+lLAP7/h
 DXjA==
X-Gm-Message-State: AOJu0Yz2lbEvpPZIYg9L/oPFuOxqEXGUNs/O3hL3n/iklOzKwhlqI2EM
 q0vGGIETwV2JE1+d4V2HyAqrGnOW2CntSPyTE6TOLRAbNboJN8VGx2fJObCFnptYSNxrfrK+G7r
 N95I=
X-Google-Smtp-Source: AGHT+IG9SysretKKWJT1mItDhLyQEThfOm30F9anQ4lYjFqsfs814GUkkgqNgJkV+8KKcdvkAKNCoA==
X-Received: by 2002:a05:6870:472c:b0:25e:12b9:be40 with SMTP id
 586e51a60fabf-25eae846386mr68258fac.25.1720460520667; 
 Mon, 08 Jul 2024 10:42:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-25eaa083bbcsm92410fac.26.2024.07.08.10.41.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jul 2024 10:42:00 -0700 (PDT)
Date: Mon, 8 Jul 2024 11:41:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Stefan Roese <sr@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Please pull u-boot-marvell/master
Message-ID: <20240708174158.GL38804@bill-the-cat>
References: <63f91338-51d5-494d-bca8-c9e2b075ec67@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sP4dk3YWbDF1U/xx"
Content-Disposition: inline
In-Reply-To: <63f91338-51d5-494d-bca8-c9e2b075ec67@denx.de>
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


--sP4dk3YWbDF1U/xx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 08, 2024 at 04:22:52PM +0200, Stefan Roese wrote:

> Hi Tom,
>=20
> please pull the following Marvell MVEBU related patches into master:
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--sP4dk3YWbDF1U/xx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaMJOYACgkQFHw5/5Y0
tyzFawv/Y6bW0+f8Td7d2+i+Gpd7r7Pl+A55ko/hMvNO32oBpr5A3Pc12KnwiFPA
mmlHxrTAgArh/t407ricv3BwlsvBwGRkI7iUdVKbxJNz0V035FTQKfINJRzTDxBq
HQUA0MHqy29XQW8xc2g/MegdAoZzkIbZDzoHmduzNyy6kzL4jaERp9rn/vOjqd0+
IIaqBWzgZKsrF+k5NPP20esw8/VQAJn9GWi3IQr6f+l/yWxs95l5ghTki01fbi9A
9Yj9HnKzFvhfvj6DRenGZH7NvY0rGrbDw60yaskrZvogEckXcXUMZyhx3mAYdSLg
2C4ItwMAtHKEvX7u395UrWqnZP76fA7UN7dXseASzP7Xo3LUM2wbdG7IsOH11lSL
RoPC5pRS6tJAUsibWFmFVTP4ZdMB15i22S4KzgLWeOSeO9pc+EQCwkGAjxzokIVp
SOjYfiknAjyn2af3ToPAkdlD1dZJeULqFRNuQkJwRVhWrxOa1zUYL09HEmQYZzEU
b/7vmK4Z
=DNM8
-----END PGP SIGNATURE-----

--sP4dk3YWbDF1U/xx--
