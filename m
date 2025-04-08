Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB4EC369AB
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 20:51:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5691E82F49;
	Tue,  8 Apr 2025 22:51:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Co706kGU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8096680FDA; Tue,  8 Apr 2025 22:51:24 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 562CB82F49
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 22:51:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72c172f1de1so3356511a34.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 13:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744145481; x=1744750281; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W7ffn2XW1/mAmAH7+WvBMhDc3L9Xkv0pHW5woNCTeN4=;
 b=Co706kGUfWX7/JY7WVDzFQfxyhlHJFv2qboIPATfHKTgsir6J85smSdIoo5hRJ89PS
 Z2OsOEHR9NGVmZQkqoTXDTRnQBj+QLF1xLuwsDRI0l05OpF1KG70+ZbAZe4JYH2qG/l+
 oqynOkMYhclXP0dJdxKDTBp2UI0O8jVQJnqv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744145481; x=1744750281;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W7ffn2XW1/mAmAH7+WvBMhDc3L9Xkv0pHW5woNCTeN4=;
 b=LsmxYQ2Tw2Q/y3jFvXeHXa0nGZnNbJ7fpEcCgNAWR1B5ciOKs7PDzhKSxx7ms9Xz1r
 Fh2+uF1dKIMKpzfImfF2AYYCbh7XowhSb3+ZLofKzP40+6boWdPu8Y80913/C6+70lBX
 PJISt5WN4LlL8xw9GBC8UnCDfR3RsPa3S8Whdbm0tS3vrUIzb/OAxMVCYN1mKDcMlxnp
 xjIft1G9c/c1Y61PEUQHivuMT5diU9dKu/LW6MLgOIKlIb+jd1uh3HLgQdQSTng5HxVb
 kWVYfHMYKKbxALHhSoajT0R81Wu59QFQ66yPdsMgEVnLa+w/9+PIpiGDvDi7Fd6+CSpr
 daGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0x44qucDHjXXsny7hVwD0Vm1v9r8UeyMnbUK5fzS0ICyKyxhRK2hjJi+vcc9qWF8TS00Z3qU=@lists.denx.de
X-Gm-Message-State: AOJu0YyEqUzonkArpuLOvGOGtJMKa1dc4PMxz3Evpj1wmiOgtb4nmOEm
 G6y9s0yZ4B9omMUWVbNwoGZA0W6bknO8BuXEvDB2xrG/dcJvL5ujdngOIHD2/hiI0UzO1gwgmZk
 R
X-Gm-Gg: ASbGnctG98XAu5jpd9uTWY6Eir2s7CZUd2/fV2d3NxcV6lAR/cIq2X/iabrgCF0N3th
 ayG76YOBjBOvhx6MG1sLIV8vvVaNkMgjo86h/Qgva0BEFBsA9aovxGVNhpm2BR1aiq2oEH3wcrK
 RXz7iC4PPiWWnRzWR7CZXD9n3W+g6whzihwW2Rw78uzv0vUHIcrDB2z81bhq9djnWJPQZOvpqVd
 /WuWHij6S8i51alvasN7KqDL0bbxtportxFq267at4mOhfLiBQ4HwLF+T0GtgSVgFsC3v+OVUBk
 1aQ77fr8YnPmeQSgJc57IUmwWOE/83Xo/uOs0vMbMERZyz6Gp8WArUq7Jm8FrMBzHuzQzbQ/siF
 kpKj99A==
X-Google-Smtp-Source: AGHT+IE0ztEWxYTgvsGyTmxf+4+rAApAfZLbLlStr7RHsn2GCR7tmaxkS9xrNJWPkHHmERPW7llqpw==
X-Received: by 2002:a05:6808:bd5:b0:3f6:a7c7:909b with SMTP id
 5614622812f47-400736e7078mr238773b6e.22.1744145481098; 
 Tue, 08 Apr 2025 13:51:21 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40069c17c9esm585422b6e.49.2025.04.08.13.51.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 13:51:20 -0700 (PDT)
Date: Tue, 8 Apr 2025 14:51:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: update Python requirements
Message-ID: <20250408205118.GY5495@bill-the-cat>
References: <20250408153606.118149-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="q0FZ11FvV1cHX8cl"
Content-Disposition: inline
In-Reply-To: <20250408153606.118149-1-heinrich.schuchardt@canonical.com>
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


--q0FZ11FvV1cHX8cl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 08, 2025 at 05:36:06PM +0200, Heinrich Schuchardt wrote:

> Update the Python dependencies to the newest releases.
> This addresses CVE-2024-56326, CVE-2024-56201, CVE-2025-27516 for jinja2.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  doc/sphinx/requirements.txt | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Now that I've merged next to master we have:
=2E/doc/sphinx/requirements.txt
=2E/tools/u_boot_pylib/requirements.txt
=2E/tools/buildman/requirements.txt
=2E/tools/binman/requirements.txt
=2E/tools/patman/requirements.txt
=2E/test/py/requirements.txt

Which need to be kept in-sync because otherwise the part of container
building where we assemble a cache for pip will complain about
conflicts.

--=20
Tom

--q0FZ11FvV1cHX8cl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf1jEIACgkQFHw5/5Y0
tyy3ywv+OklGur51oSFyEmvrYe0CEJcJE0MEgNfGLTHraK0+kzfdlR8Evf06lHdZ
3Hw2HBbWBFL5Z+N7cWFSm5bijHhrfQ52RqohNOs0R9rdfV4afZFV6MREoedvRfdp
2M/NEnypr/MYpkJQuMFvPO5IfUYLo5hQCnlqotib0/wxjnBhDmXzkQdvHC0MUUra
5xgXg2tf0K5lR0HefviTF3Gn6/CtqvyCMWxJat2Yuwq5Ovc54Y2SMZn0nn+GEs3f
GZcq08AXz7ehapN1BMjAIu9R7n8X9npk93g/6sCSviNIDFglQTkuHfdQr66fEU4g
qCl1VGFDQNKhtFqXBMc1BPSxFiJDDLMV95eJNfingczcxsjuqTu/GsgtjBjc2Ihu
EHMUPoXXS3WqLRqa5gEPZ3QWSWQYqPFEEe03YYVPorpMrtqJ50XN9wEr3iyVcEor
DL4W6+ZIjg2N5BO8y6NbgaUEumNJV3IIE9rLfeR8XgXGOZKzD6HX+jh0YVGxsMDv
sO2/cBrW
=78iv
-----END PGP SIGNATURE-----

--q0FZ11FvV1cHX8cl--
