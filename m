Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AF1AC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 20:43:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7916788F22;
	Mon, 16 Sep 2024 22:42:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mhVXFYKv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F8F88F22; Mon, 16 Sep 2024 22:42:57 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49A1788E92
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 22:42:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-457e153cbdcso45983691cf.2
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 13:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1726519374; x=1727124174; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+nyb1kWYixjgiB7W4VGRqx0e8KJDhYXa0jGeQRtfoVw=;
 b=mhVXFYKvY9BtQ/O1s1DU/y3nnvyHZB623cUUz6rvVkbtdauan/y4EHS+XTxBKjvdO6
 rn1r8ly2BQl/MQ+RYplTPuI3RaonJBLrz9hyf+bwiPD9naUzkmxxVc80wNK+8myC8Vog
 GKZLhYBdeowGq/iHX5SNV9oE+Yk+VgWcEcO30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726519374; x=1727124174;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+nyb1kWYixjgiB7W4VGRqx0e8KJDhYXa0jGeQRtfoVw=;
 b=Zfbkk+P987FasT0e/6z7lxT9QW/f9/LxxnwVvKcSfbjcX1RSf3QbwVFUmL7+vVeSAX
 0qoFrefd6sPlmQ6NtiRePyLzLYikwio4cdc7yPzgg2xQ+QMPcb00/RTdErINNvYmzzSn
 7K6a3HUWDhK37oY8d9bIlWCccrvjKHTx3I/YWMXmvOEo+W2V2SErYY1ZBz3rb/15QlWo
 miiXzdlCItOE00MFD1gXlNBtRbLZ7AEuGk/mtfcSLkcDIuF/BSodFHoSjqehRVx2Xksx
 sNWKUBxUgu3zPxrrFAwugqbghBuQ+xplawNfO+IPxP7qFE8Y0NfS2ltBNjW/e2+fMCx/
 8nuQ==
X-Gm-Message-State: AOJu0Yxr+t5DGQuRN3MxN8tuqDBqx2S2ycp+fBi6z1UxzGVZjLGH9C00
 Y5MKyykX+NUVHnGx4YmXzSF0xwlTbp4Z4Rzz0y8cXSwH5I0kEVyUZi+6im5ud0EdIQMdUYPLZiR
 8N5M=
X-Google-Smtp-Source: AGHT+IHhyqvAgChngVkCyA/Z8j/GJAFFUUowRwbhaudx54rIZQKEcI6dt2IibI6PVdjS4tnr0gwBcA==
X-Received: by 2002:a05:6214:5984:b0:6c3:5dcf:bf5a with SMTP id
 6a1803df08f44-6c5735940b9mr318924326d6.37.1726519373954; 
 Mon, 16 Sep 2024 13:42:53 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c58c691ad9sm27816026d6.77.2024.09.16.13.42.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 13:42:53 -0700 (PDT)
Date: Mon, 16 Sep 2024 14:42:50 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.10-rc5 released
Message-ID: <20240916204250.GJ4252@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VOeJPDPYdF4QWako"
Content-Disposition: inline
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


--VOeJPDPYdF4QWako
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc4. Things have been continued to be
fairly quiet and I am optimistic will remain so until release.

In terms of a changelog,=20
git log --merges v2024.10-rc4..v2024.10-rc5
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means one last rc on the 30th of
this month and then the final release on Monday, October 7th, 2024.
Thanks all!

--=20
Tom

--VOeJPDPYdF4QWako
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbomEoACgkQFHw5/5Y0
tyyNqQv/S+hCZRaPtR9bOiJrELZ162kK6ODJYPwEevc/R5uuZfSetKXp62L8i2fm
iZ+u5ItOfgDQQao0dLVFloCfNUfVdCwoz2leTLrsfOcq9x9kSVP2X0eZDIi1sP6E
nd6zNN63/8eAtUDkm3GTMxYD6HOIukIZ6QYxgpW3XygH7l7o+nmXIogeR3RdaKwa
QAcW5oQm0N5JmS00fXfKRxi8DN1zLL6CIuqTUgGAYS7uYJzS5fhJK6cCQU9xrFJ9
Uapw3arh6hUyDe0sV7vAsLg9vZg59BiuwV4zulLhiVPWuL9m4b5hIGDlfllIRIeF
kjjdbfAowNryzLAEKC5vI0x8ZoxGs2u+IjTrTpLfX3JDxgBKIgdcYt92I2wU5k95
rcG8V6i0SH/VvtsIyIDIly4sMcImcWhEBIaQHNyJPQZ9X7NX6r3MS9TigJPm0MR/
uXE8mKpR1Fi1Dsvfk/5Vi7J5cjckpKWpYDFNlGhP0vDZ9bar/D0jKJMv5I8YaOeM
ZPQPbAY8
=hyWn
-----END PGP SIGNATURE-----

--VOeJPDPYdF4QWako--
