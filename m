Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5421C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:51:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E23687B18;
	Thu, 14 Dec 2023 18:51:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UuWmua5u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CA8087B18; Thu, 14 Dec 2023 18:51:32 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFB6987B1A
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5e32af77f15so15220287b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576288; x=1703181088; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QxsaKtLH8lNXHX1sM9/D2Arf8mT1hzDRskodHMh7ZB8=;
 b=UuWmua5utmBOqiQpKAUdKYBw+2nyoxjkPbxMXXfkdWr0rcv9K5ZFFR3NciOn3iKz56
 11yV36Zfh+PDGKgFZgqX1qdiNlkcj7LHSIQYxD12BCWrVfmY7H/ajR+1dklfJ1pUTUI6
 Fz5+iwuwFzbJ/SEm0EMbHvPcnOx8rpcbejInE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576288; x=1703181088;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxsaKtLH8lNXHX1sM9/D2Arf8mT1hzDRskodHMh7ZB8=;
 b=NE6mYSJXyKSY8+A3Lqx//4+9FfmFCflSPdxSOmwlxDAzJR38yVUKlEFq9qg4z53m+X
 94g3TM6q2zgqRoCnANqBQmP/iOUf+GWPQeohwnC96S/1dpTvn63K6y6InhIYGcq3xuN8
 IcOHmk8pYDnpZTbAITvdID/n2iQmB5xlSnJ9OYeraNsZWqHaIJ+ihoZFMh5+fO/uM+I7
 lr0xbNrZXsiArYuaNXgyxmPp2E0ze9GGdg49s6YeG6JAPO7Zs827WW/h0gVWr4HT9E0P
 oJu8a7LrqQGrO25MrRTuRDlsTuq+rD4baSk7tSLu8tZzYLmHTvmRIff5CsZRHySnpHLw
 dQyA==
X-Gm-Message-State: AOJu0YwLtvuZhS3wuApNHkGsRwdOD4CB0IzHqapw88DfhTxVE247hnj9
 rsQnvdT3P9ZMbCqMB7DPJRoV8g==
X-Google-Smtp-Source: AGHT+IGJxk0EXBm9ogqYKRTODI/1Z64WlTCkpspWJOJt3QgE/TbzjX5+nuT19POy1nJR5mypzVUwhw==
X-Received: by 2002:a81:a093:0:b0:5e2:cbb3:7b06 with SMTP id
 x141-20020a81a093000000b005e2cbb37b06mr2453819ywg.12.1702576288043; 
 Thu, 14 Dec 2023 09:51:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 l5-20020a0de205000000b005d37278f973sm5657475ywe.36.2023.12.14.09.51.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:27 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:25 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 13/21] bootz: Avoid use of #ifdef
Message-ID: <20231214175125.GG2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WNBWXWDiu/YvTX3S"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-9-sjg@chromium.org>
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


--WNBWXWDiu/YvTX3S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:22AM -0700, Simon Glass wrote:

> Use the compiler to get the set of states, instead of the preprocessor.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--WNBWXWDiu/YvTX3S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QJ0ACgkQFHw5/5Y0
tywfvwwAnMoXo5QNTkrtsbCmNVOKnt3K3oJkVCpDsN4G4hYtXdbhKGK60dLdekuP
yQu5wJTWL2/L7KBeEMIv9cDtTzAuwxVz+FElQGhjgoHk95+Ds4+V4awsrwzKbsWH
d/k9MRB/1qq9+8vNX+y8Bu4CjaB7CCUHEXjZPbq6/v+U/R8nqxIpP0Fbr4WLsn0Q
HxUVclC8Y34dyQSbjS2svDV09whp9okYVlsTqVf3Dfst+FU4vxNz2jmSe4qjjEAs
wbm3DtWObf0QAu+3pOX17l9zfy3L9oleRmx54gHMfQ70qWu10S74t+qqCtj2K0Cx
meXV0iL6jQJvrb4/wgZy8mnFRF+e1fvbjFwXQCVe/02tW7MKaIPKf++VmD7vNewM
WdEEZ/RAY4UObTlnyCO/lLdxfizTL1KGUd6NUjEYfD4aEhgMsFnU9TavT+gSh0ci
2sPbwwwDhgmbRfzOh7ZRVZ7BNsiZnCGS9GnJ+NN5myGfoqAV4gxHi5epfS6JJRcK
na+98hWv
=Tkaa
-----END PGP SIGNATURE-----

--WNBWXWDiu/YvTX3S--
