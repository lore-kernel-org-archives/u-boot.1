Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3BC47DD3
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 296AD87D7B;
	Fri, 19 Jan 2024 17:10:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tKjx314G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66AF587D32; Fri, 19 Jan 2024 17:10:04 +0100 (CET)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59C5687D79
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:10:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-dc24f395c84so818997276.1
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680601; x=1706285401; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3T64edlNRb7xJdWJTHOLgBC/Bk3YktKksZcMtTl2XbM=;
 b=tKjx314GOp6c/MLh8pjHV36htqfJnkj1HMXO8hdh39tiRNIAAJ+vbaaJjcYUqeqVzr
 li6QvhmKJfubqdw/biXBRi76zFkiEPWoV1nqojF7eQjecMFtrJAX7LEBh6qHYbq3YNyQ
 AVtde13/g5RUcT1ymZHMVGCZXf4/0lexUIKNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680601; x=1706285401;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3T64edlNRb7xJdWJTHOLgBC/Bk3YktKksZcMtTl2XbM=;
 b=jsAvNp4443Zvy/zWBmHdtTdjilWFDUpfcKrXGy7PHTmBNq1IfAi+r8JRtywED1PX4h
 hm56W0f8HiUxVIfSLkqHUi8iUoygU/PawA0dQH63KeFQNY58/9uMwEN+eHEtAxauLa/S
 k4Xy/B/BO5/+UF7HARevqmh8mBokHhIcQzEOakHdxaGnHq6vQCZZPYIBgoAi9WhZPft6
 Co8E/8G7tFvjf7rjzL9VlQG5O2nH4OoLslFgFYNF8qdrPDz9dKwqnPKplRHXXuiLQIjY
 dvN5mQH7Q5VdUNDxpbCA+YO4lHYCZGJQ2P4ygLBVz9C4Ah03w02UY24KFFV/d7cZQJXK
 /BSA==
X-Gm-Message-State: AOJu0Yz4rpRlaUo9dIHNXjQyJUEJyRj2yrax+VaXOoKRQKlGJZYaJm8N
 vRUe/KCxjQfAnDGESA9uPHFU8+tWRcuTFAcEJsnzDlofW8YNGDUlIEoSAGBl5R0=
X-Google-Smtp-Source: AGHT+IH7VFvr3/FXCYHuXZLvwYIiwcl0KTCK6cYqf2CZuSjQRDqsaMIW+gLCqNboYTiT4wNzdC5axQ==
X-Received: by 2002:a5b:804:0:b0:dc2:2f47:d5fe with SMTP id
 x4-20020a5b0804000000b00dc22f47d5femr860383ybp.24.1705680601090; 
 Fri, 19 Jan 2024 08:10:01 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 x192-20020a25e0c9000000b00dc226e2dd70sm2852426ybg.3.2024.01.19.08.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:10:00 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:58 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>
Cc: sjg@chromium.org, marek.vasut+renesas@mailbox.org,
 troykiskyboundary@gmail.com, rasmus.villemoes@prevas.dk,
 u-boot@lists.denx.de
Subject: Re: [PATCH] cmd: nvedit: Fix typo in 'illegal character' error
Message-ID: <20240119160958.GI12635@bill-the-cat>
References: <20240108172045.1474962-1-ivan.orlov@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7qnmVV6nQ7psO79/"
Content-Disposition: inline
In-Reply-To: <20240108172045.1474962-1-ivan.orlov@codethink.co.uk>
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


--7qnmVV6nQ7psO79/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2024 at 05:20:45PM +0000, Ivan Orlov wrote:

> Fix a typo: add a space after the single quote in 'illegal character'
> error message in 'env set' command
>=20
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>

Applied to u-boot/master, thanks!

--=20
Tom

--7qnmVV6nQ7psO79/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqntYACgkQFHw5/5Y0
tyzjDwv7Bn8bDuMcVFR161FLfoRNEg32Ye38WN7hIrzppV42Cez9TW+NXYuJGfgb
aNhz8sfWfAvcVdxsazd8HnTw9eJWRBUfblTQcFtzX/wyc3g2NF6y9VaytLQysVAA
qHK0iZuLNjfk2HEqmw0liNyZMD7FLZ94r4ocvaPblVh9SBG4oEKFK1bvHXJYC/Yj
4S3xd7OpTeAMzhQGo2FaQAU7kdi+Wd59KWjPTtI+Z3TZMauhvHsTSvbFgWHwUf8Y
a8X6xUB6x539C+9eATMliUwjcUUrEMlKuee38jCnCqJC6MT50TXsVC6pW7TnBu9e
rvA9/yvNr1MQaLUt1wEvhzuy4snaYc5Baqj+hQmoB1c9WAI9APwgnORGZW5ore96
mYd9dZKFIWAbxr+UVv7IpZsuuUjmxcSTXsHHcyX/ggqYhqwi93x4S1DueXJlOXua
kaphI2Ub/3dVUnkm3OHk9MdZVsUfhOExYnWgupD2Sbi+NRxKAFxT2VyjrYz+qlgR
dcYnyRfH
=XTZx
-----END PGP SIGNATURE-----

--7qnmVV6nQ7psO79/--
