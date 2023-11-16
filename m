Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BECFC5ACB3
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:53:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FC7B8744B;
	Thu, 16 Nov 2023 16:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Lg7TNMWY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 353088744B; Thu, 16 Nov 2023 16:53:35 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31958652B
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-671357f0209so5449116d6.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700150009; x=1700754809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Kkxk24v4aX6IRDD1ImSzUiljV1Dl5Egz5CxTN1zohOc=;
 b=Lg7TNMWYh0utzLn2Q81O2O8SdPjalLnxbZ6WV4i96Zm9BiYRexLtZvEpup8ZX6TU2B
 Dwgbanlh8q0Bon7qLxSdHZIMg/lcuBUPswmxA+iUaYj8I0LXdnuBBjWA6uN2/x4/oZPq
 obBe+m5Xkzi7FLyr+6Bsxx/8P5JW0asUE71Nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700150009; x=1700754809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kkxk24v4aX6IRDD1ImSzUiljV1Dl5Egz5CxTN1zohOc=;
 b=re3oU83wVr+5s2qpkybl1lV3k1MuB9hy/BaoOmLJv1WSsOVOIf9IiYWcyw+gAo8/CV
 X83QzHJRkC2b0jtKxZ9AroxD7gcPvYzuobu5zwqEOZpFQqdIr8fyJBNivRntVdH/M+aZ
 4QEv9BYoixVWlJJXvKj14RzKx3YHx7Qdq6CJUO1xGM1yMHOo9KVd0uRBlXj9Rm4uujPi
 Z1JzJTCyB7DsRC1oY0k7kkODiEtZg2oAbGButQ5vqLN/AYG7bEopWTsIwzuvEgachIxV
 dW+uBctfYoDfM6v+TVP+tKtQ8xY7UnPwQ2nl80QQlGK9GbjXa/GvGaEuWIQwddA7iyPm
 Kj/w==
X-Gm-Message-State: AOJu0YyreeZmYh7UXqFbS7SmCgQT0iRmZOWqRFuPnBhwizm2WxULJBwF
 Zxx/BuxeY7M/0S8Xv7Pyhg/pDw==
X-Google-Smtp-Source: AGHT+IFIUjabGXSR3q644C0erLFgL2Joq0vFZPeFhHNz5ZHzvHSWLXUWVPoLBNjqhSbiBzDcuPtT3w==
X-Received: by 2002:ad4:40c2:0:b0:66d:139f:34cd with SMTP id
 x2-20020ad440c2000000b0066d139f34cdmr8893975qvp.13.1700150008772; 
 Thu, 16 Nov 2023 07:53:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 cu19-20020a05621417d300b00668eb252523sm1448337qvb.63.2023.11.16.07.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:53:28 -0800 (PST)
Date: Thu, 16 Nov 2023 10:53:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Artur Rojek <artur@conclusive.pl>, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 1/9] board: Move show_board_info() comment to header file
Message-ID: <20231116155326.GS6601@bill-the-cat>
References: <20231113030001.240020-1-sjg@chromium.org>
 <20231113030001.240020-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7S1qq/9WZdO2Sdc1"
Content-Disposition: inline
In-Reply-To: <20231113030001.240020-2-sjg@chromium.org>
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


--7S1qq/9WZdO2Sdc1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 07:58:21PM -0700, Simon Glass wrote:

> Move this comment to its prototype and tidy it up a bit.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--7S1qq/9WZdO2Sdc1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOvYACgkQFHw5/5Y0
tyyO9Qv+LDRTGykL25LXhc34v6F0yXljIHSS7Icn1FH3vKVsIldCRJgt8AkTyXrL
lBaIjAOsSbJ8+mCyS8TkFeiUMn1vEiS6Ucb3TqgayouLkWoTMxfM50dakpUdtnl3
UpMjTtguISYTnkisq3vHaSSAaFeHhG8pT0vJKsFQWnwx3SxNeheu29dsiMJGmEOD
xtIsQjVeSctKqozphPQvLjdLLuJGcEyWWBUVIRRSwPRuU8V6aQ9D1N9IDKKvPjd0
kODNTSYWEBBmtYFSx/KTbYpJI34iovxnTUk7Pjk/0zj5K6kHT0jFiqNYAfv7hXb3
+adMJzkEdC92ncuUhf35CtyLZ+AT5VcyfrOjPqnMsym+czQWo8yTWEPEqN0d2Yzj
0U1Rrd+dKMKhSDuwh9MdY+16Y8AAVNf20LvG0c9owgL6h0NMOnzfjyfa1j3MPsDK
/iV7HSW6o5an5Au/UA9e74fJ8YUsH70Xas893JkMYaBdQsMVP+FBtoDZMgDLuYf3
0iv+fScO
=GJ28
-----END PGP SIGNATURE-----

--7S1qq/9WZdO2Sdc1--
