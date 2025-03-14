Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35065C282EC
	for <u-boot@archiver.kernel.org>; Fri, 14 Mar 2025 16:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE1CE81EE5;
	Fri, 14 Mar 2025 17:53:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WBR+/nEQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E664B81F28; Fri, 14 Mar 2025 17:53:52 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C211581ECA
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 17:53:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6e90b8d4686so19521996d6.2
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 09:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741971229; x=1742576029; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8f98tNt1tKdlNTkM8kgh5grNlhBCFI34OoS7zlSB3mw=;
 b=WBR+/nEQubeR5CZ7QgqvppN2ZU4yM7YyVzg8IkrpWJUozBB2AwigEjil+0BOimJpeK
 cFEnMuhAA1jNkvP1AjnxMVn0KPoiUWqTjXALITg/7SY96BHq22sM//C5OaYlP9ZpQdq8
 YdCV4yxarkJ44DJlEZ0OMjueZ4dfmC0UZ7bu8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741971229; x=1742576029;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f98tNt1tKdlNTkM8kgh5grNlhBCFI34OoS7zlSB3mw=;
 b=QiIbhKWqMZzp3PEUhTd/s/RzrA0qai0AhZpj+Y06ARiXrIlaBIGx3M33l34DKtzngC
 jH6QtLvWgpqVtgnTMi0/Y7Dwv8W+RLMp817MK7gi+zJxq8KJvMMFsY8AVyfML5iq480e
 vgkAC8Kmrv1dMT/Dqi9gPuhA/2+8l8aleG1Ualfv5bGvZ/vfy+GvenvqaAYF4lTIbKn7
 eFweV85iwsINFFDabZIEH7YGcbXIT+y+HXblhjcGhkVvbvjGF3dKTtwofhuYRMemOahz
 T1t+kqjjIWc0/G5DcBOdslc96B4iYkSKO5d3fVnvZlKKc/JuIdEAqVBHeuRfAMT3ClIi
 IcRw==
X-Gm-Message-State: AOJu0Yz3/XN6mxwkcXjbObvyJPg6Jh/1fQQKYF9gyF2+Vve1IDAqKFsk
 Vb+K5b0LB6JANkFBuFCSTjuHxrNeIldHiLHUnG1Nl6QRoB1hh3KhjD47QclIe4M=
X-Gm-Gg: ASbGncs+LTXTl9B+SUo7BQulb4DR1Y+iNfDp4AZN4NY7NNjWLI9zNlcEZbQqOJuKZX2
 Z/MIIeeujHbyvNF6iF3GHsYoSh5JaiOY1ZkQQwUCYFmtiXRwdI6E/odKPDM+L/utH94h2Em+w4F
 Q6fDmqIZ8oNHhnEUuAK8Tg7z7CJa3huZrKkQ36FXImZi4gdlcJpAlnhiZ2FsrEsM6ryMjOEyTDk
 kUDuJNpNrlSpj7fD7DLOS9sKphe4K1N0zOz28Uudo6cP8hF0/Kcwi5CpzTM6oyb4VLDIJF5P5O4
 I2iVGD5UWE5rduRgoVKcO/lLhV0rKCYD6koRqRT3jeZP0g==
X-Google-Smtp-Source: AGHT+IE/GhceDHiE8x8aUSICv7o+QLQ1J2JEJrUyt/wsG96yCcIPkmgo58x9yJlgOUKeFM/2zDzGmg==
X-Received: by 2002:ad4:5ba9:0:b0:6e6:64e8:28e7 with SMTP id
 6a1803df08f44-6eaeaa4c59emr49626616d6.15.1741971229697; 
 Fri, 14 Mar 2025 09:53:49 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade24d025sm26148786d6.51.2025.03.14.09.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 09:53:48 -0700 (PDT)
Date: Fri, 14 Mar 2025 10:53:44 -0600
From: Tom Rini <trini@konsulko.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Sieu Mun Tang <sieu.mun.tang@altera.com>
Subject: Re: [resend v2 09/13] cmd: Add i3c command support.
Message-ID: <20250314165344.GA2640854@bill-the-cat>
References: <20250314040902.43621-1-dinesh.maniyam@altera.com>
 <20250314040902.43621-10-dinesh.maniyam@altera.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d7luQ8GaeNzMfv5f"
Content-Disposition: inline
In-Reply-To: <20250314040902.43621-10-dinesh.maniyam@altera.com>
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


--d7luQ8GaeNzMfv5f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 14, 2025 at 12:08:58PM +0800, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>=20
> Add i3c command file to support select, get i3c device
> target list, read and write operation.
>=20
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  cmd/i3c.c                          | 193 +++++++++++++++++++++++++++++
>  doc/usage/cmd/i3c.rst              |  98 +++++++++++++++
>  drivers/i3c/master/dw-i3c-master.c |  35 +++++-
>  include/dw-i3c.h                   |   2 +
>  include/i3c.h                      |   4 +
>  5 files changed, 331 insertions(+), 1 deletion(-)
>  create mode 100644 cmd/i3c.c
>  create mode 100755 doc/usage/cmd/i3c.rst

Please put the series through CI as well as checkpatch.pl. As your new
document isn't listed in the index, that will fail. I've not checked for
other rST issues.

--=20
Tom

--d7luQ8GaeNzMfv5f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfUXxgACgkQFHw5/5Y0
tywKXwv/eyvVEfrUrrTp1Dxkh+h6yciObU+e23IHdV0vE6YlKDbcgUTEIyw32T2k
dEc/A8IHYY1TWN2/vF3T0r8VyuMMvyQDBc8Pdy06sThEJK37Btfz7fyDh6+QqjY4
lR+Jh3Fz1wiJnBC2lvDuGnS4/eXXu7kyWs/xpmOJD+jNdg3/BW+MglfvxmuSLsp2
2uWNFOqwPAKUBwEbEuI8ADP+kuPkyUyBq954joAxBx0evN2uSg2OnYy+9RmKqz9L
VDwfZpihe+wizTKuNRO7fW0jAb0a2O/IFPI4Qqj4F59tUrbk51u7t6PT9vcwxVvi
JIAlhljDd+kf5jmW5GIuXEqdAzcKpJc0ZH09T2JklppyyRC92RmijvhENTNdtent
x91z5dtXlkKs3jEjlupbJzyzM1zbTP3wiBmWyJ49cm1MVQZ9FpZY2QH4JgJReKSk
PnsJY63zBWtDmQ3QW7JAZCIQzPLON+WSKSY0WOVT6HEeNMAcmO1+fjiJ2eZdEp37
OakYXY95
=iVNY
-----END PGP SIGNATURE-----

--d7luQ8GaeNzMfv5f--
