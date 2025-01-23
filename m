Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10C1C0218B
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 16:28:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB5D801B0;
	Thu, 23 Jan 2025 17:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tgaSR07W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C4DA80214; Thu, 23 Jan 2025 17:28:42 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AE8C80137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 17:28:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6dd049b5428so9704326d6.2
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 08:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737649719; x=1738254519; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8Kike4UbYxaZTt8edxgNo/DxcQJ5f8XImkbxUeINZ2A=;
 b=tgaSR07WtxwWFpCuVVH//iaq54R1hMeebH4ZYog0Y0wFg56eJ7hnCjfaCCgHE7MiiZ
 hdLVPcCrtBlalCET1I+Sv0qoTvSvQdw7Hx59BgIjZWF/K7gTINV3pAOEFJ6r/aHe/fPX
 iRpB8ihVNL4R/0QEPhsRNoMqVELZ3M3M6cVHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737649719; x=1738254519;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Kike4UbYxaZTt8edxgNo/DxcQJ5f8XImkbxUeINZ2A=;
 b=D1pEC9ilfGEnNI6GLmnybuZlqDW2iUM6PqrQ3PxWK4/hvlsJ8pFB1DbiOybjxgKKIP
 CBnO6hEp+qx9uACcE23yhII5T1eNvIjI3oRl1C/3eGHqEvw7wqlJOj3DeZ0EvpJ/+y0Z
 XjP6qodE11cTEYmRIfeiQqVJgDpjXNXKtgpKfUSqH+RPRaGItOJOrCgbnpIaFC+APVNH
 vev+UPuksRe2Rr17qLGm/5NQlbHcjSNEQRAXd3fAqx0ENg3PPyOppyxxLloiyEStKLDF
 PM25Qjr1CwqeFK93oj5fKQ6wdmTKNYa2AxFBRKtt3K/DW6ZatYSyBWt5Qq+O6yj+G+zX
 7GGg==
X-Gm-Message-State: AOJu0YzGqbqTCSE6gmE0gbNJmebLtddsWbPFY8kVn9tynL4LrqBkqN48
 yMTGrRzs8egWFE1GhrBw5lByyxQEFWcjORgJJc7wa+enKfAcabSrkhgIETUg5R4=
X-Gm-Gg: ASbGnct/w0cbk83DNcCVUkYhqOxOwP751vn00W/R7qHJYbAfbYsmDtJlH15M0mEDRqr
 uh6Zn66FIXihWAo+jtFYNrgixwjoTiViFUXzYI+FFfGB2NVJ9UHt9ITwnK+6JBEq4Jyma1PnSQT
 LYkYshQRQUUJGQTppiLOlXKXY9tkbIxnsej4IjTDcTCvRmL6FchIQquJ95MTln+FYGDv+qFyukj
 oDpWl0z5YtZ+8Bx4xwJuP2Ru+LarDLr3UidyJvlaeL1D1qolAgfV00XCgvDWDAD6eqvD3vR6h3i
 RQKt
X-Google-Smtp-Source: AGHT+IFK2ZWxn+LemMmenzpvDi/5L7if84K7Rr7P+AT/+lPmn1PqSkxArj7F/2+ZlmzeYsylQ+OwAw==
X-Received: by 2002:a05:6214:4015:b0:6d8:a946:eee5 with SMTP id
 6a1803df08f44-6e1b218a549mr423803796d6.23.1737649719165; 
 Thu, 23 Jan 2025 08:28:39 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2058c11f7sm31286d6.100.2025.01.23.08.28.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2025 08:28:38 -0800 (PST)
Date: Thu, 23 Jan 2025 10:28:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v4 45/46] pxe_utils: Refactor to separate reading from
 booting
Message-ID: <20250123162834.GL60249@bill-the-cat>
References: <20250123161114.84071-46-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7mOw5iDWKe0ximd0"
Content-Disposition: inline
In-Reply-To: <20250123161114.84071-46-sjg@chromium.org>
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


--7mOw5iDWKe0ximd0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 09:11:06AM -0700, Simon Glass wrote:
> It is useful to be able to select a bootflow and read its images,
> without actually doing the boot. This allows adjusting the bootargs, for
> example.
>=20
> Provide support for this in the pxe_utils module, by adding a 'probe'
> method which selects a label and saves its settings, so it can be booted
> later, if desired.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v4:
> - Fix the force-prompt logic to leave the flag alone unless forced
>=20
>  boot/pxe_utils.c    | 71 ++++++++++++++++++++++++++++++++++++++++++---
>  include/pxe_utils.h | 41 ++++++++++++++++++++++++++
>  2 files changed, 108 insertions(+), 4 deletions(-)

In the future can you please use --in-reply-to so that patchwork and b4
will track this correctly? Thanks.

--=20
Tom

--7mOw5iDWKe0ximd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeSbisACgkQFHw5/5Y0
tyyv8wv/YJQU6ue9RD5NsAd9Mr0dX5n55/PzBJTffrCBoroGoiCs3zrB9C/S2bUP
BAB6NR9N118uay2vGQHZrgDSxYGYFKFsChxTA4lIL0y0HRIh/g/90AUH4HlmQvL+
XQa2VlDn6NhFNnW3Ur5BqklfQ7uC/vNTK9JZx5qdAjnIJdLN5mH4B1CM4VqOl7xq
dleMeQmEJBUhk0Ggs2vBrDld/E52eR0jo/069XI2deXvjSdEWwphYdQmdh23wx/M
uLe4FxxtaiTNGiN8+5JUwhwWPNpl2z67Js3eEV09rezc+uRs/zKGa6YMQjVraXo0
2/E0lkxn8a/R+A8lWigDRgeu/T0nqvEFyrAu/7eE/0R0szlB6oh64J/Iu08D1VFf
PBgdPoNkHrxWPea15Du6Q9elaktcMVUUhc0B9VE6dhtxVJBYeJp7Nzpr9ldRTIAd
MTO9pJ1/IPwV4UU8GQjrQULEKAjn8k7l8VQW3Cexh0kmw2+kZS3BpmHNuPIogZ/e
xOz8sNqh
=sch8
-----END PGP SIGNATURE-----

--7mOw5iDWKe0ximd0--
