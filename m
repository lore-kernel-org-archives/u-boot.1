Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F406C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 21:20:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79B99884E0;
	Fri, 19 Apr 2024 23:20:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FrZcDFnk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DCEBF8804F; Fri, 19 Apr 2024 23:20:51 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0046884E0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 23:20:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-437b3f256easo10183481cf.0
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 14:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713561648; x=1714166448; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S/d3cUjS5yxsLD6Bs0Hf6VfDT7FRyZ2IThf2+l6UxeI=;
 b=FrZcDFnk/sf+TQ3H7IP/9/nfDBM8TftZALtQ/6iK7ekVDmkyG5potLrzUo1+nne0v8
 DuHZze4z19i749vfsj5dBpKldRSMVLYQzImRWll4q8p0JDWtGBT3yvFYL1RTPVhipPpv
 TCz2LFCzqomIhnwBVIJ/MA+e17nxsL9+LDPRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713561648; x=1714166448;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S/d3cUjS5yxsLD6Bs0Hf6VfDT7FRyZ2IThf2+l6UxeI=;
 b=oKNky+R0g32lHbNERgXmpIdo5f5y1qDRMaaNi/Hx4m3L/8UjqiQpRd8rJ08K7jPkU8
 yIB9TSWVGlprbE9Icr6dNF93+PRgX9plTsUEuGQsfeoUG1k7sAo1Pi1amNdajdFjDyC2
 p7vlA9rFMI6xLvp/6dOvFaWPETWcA1QHz2Yb5YOqVCH88euBhQYE/qcbYqPo5L4bzUU8
 bfjVAWBY4lZStYo8gJniSIohCmpcyu4cmO/ZZ/UFkNWqyqnuhAcZXj5nDL+dkgM+XxqE
 6XJ5dqVODquTQ+itcZGcX/a+X+hYfHAxzq4TG5t/3aEI3MbUExbIae4RHXhnBn+DDtCN
 jr4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXx8pLto5bXQeVSoKF1yawCIgOHLFH4+/jqyB8UkDa9NvUlMZBP4aU/ls/4DuaLwrHaMxHC8hSJd6dWxzwgA+xKfaQTVw==
X-Gm-Message-State: AOJu0Yz0diLCtbbu4ZOVyJEQnWm/2mft4g3IBxIpKqLbBK47jNku4JNN
 nmmExLhJf9H4TdJNvuvqZrFrzLTnsVl/bCL2fj9qPEPjdUZRIhURYdblP4MZEaU=
X-Google-Smtp-Source: AGHT+IFspRUxqCRnGkSe6yfSEFrIFQZbmIMlrLL8ciF/yg09oWSoXfsgKnHRTKzaGLcUFGT3TesJyQ==
X-Received: by 2002:a05:622a:58d:b0:436:8356:bf5 with SMTP id
 c13-20020a05622a058d00b0043683560bf5mr4038411qtb.60.1713561648589; 
 Fri, 19 Apr 2024 14:20:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 kk3-20020a05622a2c0300b00436b2135b51sm1897838qtb.64.2024.04.19.14.20.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Apr 2024 14:20:47 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:20:42 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonathan Humphreys <j-humphreys@ti.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Judith Mendez <jm@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Devarsh Thakkar <devarsht@ti.com>, Simon Glass <sjg@chromium.org>,
 Nikhil M Jain <n-jain1@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Bryan Brattlof <bb@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 04/19] doc: board: ti: am64x: document OSPI layout
Message-ID: <20240419212042.GM1054907@bill-the-cat>
References: <20240419205701.163821-1-j-humphreys@ti.com>
 <20240419205701.163821-5-j-humphreys@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SrNWZm1mOP5EQJmd"
Content-Disposition: inline
In-Reply-To: <20240419205701.163821-5-j-humphreys@ti.com>
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


--SrNWZm1mOP5EQJmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 03:56:46PM -0500, Jonathan Humphreys wrote:

> Signed-off-by: Jonathan Humphreys <j-humphreys@ti.com>
> ---
>  doc/board/ti/am64x_evm.rst | 48 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
[snip]
> +Flash layout for OSPI:
> +
> +    .. code-block:: console
> +
> +             0x0 +----------------------------+
> +                 |     ospi.tiboot3(1m)       |
> +                 |                            |
> +        0x100000 +----------------------------+
> +                 |     ospi.tispl(2m)         |
> +                 |                            |
> +        0x300000 +----------------------------+
> +                 |     ospi.u-boot(4m)        |
> +                 |                            |
> +        0x700000 +----------------------------+
> +                 |     ospi.env(128k)         |
> +                 |                            |
> +        0x720000 +----------------------------+
> +                 |   ospi.env.backup(128k)    |
> +                 |                            |
> +        0x740000 +----------------------------+
> +                 |      padding (768k)        |
> +        0x800000 +----------------------------+
> +                 |     ospi.rootfs(ubifs)     |
> +                 |                            |
> +       0x3fc0000 +----------------------------+
> +                 |   ospi.phypattern (256k)   |
> +                 |                            |
> +                 +----------------------------+

This should be in an SVG see doc/board/ti/j7200_evm.rst for example (and
I'll set aside some non-SVG examples in doc/board/ti that should be
converted). Thanks.

--=20
Tom

--SrNWZm1mOP5EQJmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYi4CcACgkQFHw5/5Y0
tyzlngwAsHOHA9CwLocnAGJ4QC3qHe+jnuOLxusZUKHVkES3lxTObRi7YLC6ykim
qdHP3F6xA0Wm4n7NSQWAYBCNQDVZOAQbl81aodus/RbeKLXjuQpqj8QlhMFlidSU
ObSKJZVvs7w/LSMzzZNl5ItdRiJPk92NssnnX5FEedzgU/CteQJQEDkJHaH66Mga
v1//S8xZW4hRwrUTaHTUnxinnLrHxrwgPzplrdOdf3ZAgr3rtl3sldqwRm585StW
VVJPQvefrz6nvOGtr00fTnwowWda9nNYOt8yatar5wJHZATX7jomsa5gdbCcWVzT
30I75UzdRqQfwkfqJwKzMcad8Pf04GUCP8qrsh2PMiVMxF+EPklk7VmFx95OqUaO
0USWGJiB1jCbrkoo/ZnH17mdNjcn6gW/0GzhDmoGV0CLYZpPTae3qshEfaeQTwdN
s01Z7OX75QDwyTA8lgRemXTjpC7q9ipdawxsZH4rs6n8oORVF2XMf++7tIGlk5qr
6qx7/Cu2
=h5PF
-----END PGP SIGNATURE-----

--SrNWZm1mOP5EQJmd--
