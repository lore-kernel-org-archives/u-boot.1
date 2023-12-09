Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90D87C4167B
	for <u-boot@archiver.kernel.org>; Sat,  9 Dec 2023 16:01:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFC35876A7;
	Sat,  9 Dec 2023 17:01:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KNG4iNEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E534C876AA; Sat,  9 Dec 2023 17:01:51 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 923A08765B
 for <u-boot@lists.denx.de>; Sat,  9 Dec 2023 17:01:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-db5e692d4e0so3322788276.2
 for <u-boot@lists.denx.de>; Sat, 09 Dec 2023 08:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702137708; x=1702742508; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rHLB0T027V+ByulGg+2t8798VePgktCYAba9kF17KCg=;
 b=KNG4iNEdnmI/n1T3X/sk+uuCupFBNFinjn0y9skBaZi9750nSRpbXc9S2Ea8HtypKJ
 7Ej4mCW5Oak78pcHG9iifvt7anF98zVfrBbbp4sEzUFq9KmOj2DccnLfouoyYq+l2GuV
 TNkXvO0uDqJvhoz4ZRHlrtInN/gBe8BySGybE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702137708; x=1702742508;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rHLB0T027V+ByulGg+2t8798VePgktCYAba9kF17KCg=;
 b=OBlO0j6OL9tAgASBO6V3OvIwlNEE9vZFHeLOTCZ3Ag5Mj7QxwmY+PuGtts2mKkz1M7
 +RjzEx6auhqdSUdCepPeWjGB0flYmKcLJS7GMDVUzq2A9GhmcZt2KcndlJOe83uZ1AYf
 BGD9oDmIXxoDha0oskJJ7R6MqI5e7ULfrm81ORoGSjlz4atDpJ0inUh3x+uZwI9ga0cI
 NXb14x5+Wbp1kEiaiXsAmHDe/r0JanUvkyL8jWyG5Z4QHqwKVNBj1a2Rx5yq0CoY6Stq
 T3SetG9ePAWK5gY0nLu0wBVahyYPwpKHwTJZH4evWYI7dj9JVj6+CUD4g94oa7KgoEZd
 Q3Aw==
X-Gm-Message-State: AOJu0YxdSeyrfiTXxD/AMHkWL60sF/Hx77QjmASGvMyff7YchBEY1hwO
 ZTf+/+WRPMSt0I4XE5mL0XNhIh5zI8Nb9u89UfDdtw==
X-Google-Smtp-Source: AGHT+IHKBe+cgSQkB5oLSTNNeS12NWzth42KuP2N53hmIOJOl/81B574bJNnm7wXA7pxpYvQYXnJeA==
X-Received: by 2002:a05:690c:460c:b0:5d8:3a38:a65d with SMTP id
 gw12-20020a05690c460c00b005d83a38a65dmr1120430ywb.100.1702137708227; 
 Sat, 09 Dec 2023 08:01:48 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b2bd-da43-c83a-80e1.res6.spectrum.com.
 [2603:6081:7b00:6400:b2bd:da43:c83a:80e1])
 by smtp.gmail.com with ESMTPSA id
 o65-20020a817344000000b00583f8f41cb8sm1539570ywc.63.2023.12.09.08.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Dec 2023 08:01:47 -0800 (PST)
Date: Sat, 9 Dec 2023 11:01:45 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 12/18] bootm: Adjust how the board is reset
Message-ID: <20231209160145.GQ2513409@bill-the-cat>
References: <20231204002642.895926-1-sjg@chromium.org>
 <20231204002642.895926-6-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vcFbeA9uU5KMiHlZ"
Content-Disposition: inline
In-Reply-To: <20231204002642.895926-6-sjg@chromium.org>
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


--vcFbeA9uU5KMiHlZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 05:26:28PM -0700, Simon Glass wrote:

> Use reset_cpu() to reset the board, copying the logic from the 'reset'
> command. This makes more sense than directly calling the do_reset()
> function with the arguments passsed to the bootm command.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vcFbeA9uU5KMiHlZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV0j2kACgkQFHw5/5Y0
tyw4pwv/dF/nznSi15Cx44Q25HtzpIoiGCharsnp45TehlPi83Bbk1yJOZtf5jfU
tCc1nxOwOTs0e6cKI8+Z4f7NDNnb8AjLd4zuKbqhbynadEHfuV++KcGrUItItg54
6cNsMP9E7WIGH4UMJWmoYn6QvsMhdWFlnArPntLGNf8EjJsqIs5SOovtp7Oot42w
L3NTJ3C+KqVNVNVY2vqTAjVc6m/k2WxMAKoAUDIaAtjFqePJnFX+/7SeT32f0Py+
Pj25le7Z+cAA5c6GGUBfRKOCn+MXbrAWtnaRm+Q9KeOFLtOBWtW91uWNffH5qU9V
WCRYY0PnFYnueAJCvUrp8tnpobxjHYML/CALzM0HrFtcKWlH88Gl2J9wzA40eMF+
lGGc/n4RH3VZw6Dwi/DjiXy/zb5Mz07OZrNJaX2XbFcTZeDIJGAz5aZBu3Q3riZj
637IdCEa9oYcNDB8OhTNWiBHjFUE9zbu71olekvg0M/IBk1SH+sdFWhQ/GzS8zti
RKh0Bxup
=qctZ
-----END PGP SIGNATURE-----

--vcFbeA9uU5KMiHlZ--
