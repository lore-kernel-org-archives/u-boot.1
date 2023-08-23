Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F3D4EE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:42:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0B0586473;
	Wed, 23 Aug 2023 16:42:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HNVFD7cF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D36386403; Wed, 23 Aug 2023 16:41:59 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AAFA864BF
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-58fb8963617so45946697b3.3
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801716; x=1693406516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QLgQ1fkpck7IoUXiGnOWEhIDP57prLuQU/hGjXZH8io=;
 b=HNVFD7cFshB6f38esi9iYw1/4ECFCBo74HzrmFAoROaiasadJsGDiFfGzsUitkSV7I
 vhHIrjHZbkLe92kkl9OO9wysgaMJi24LrCr9VbEfI8/S8TZ/3kQ4FB0XxCn9Ja5dnzAE
 XBUDcjA8uQsFPfKqPhqXfNpN9T0jaDSxeUiPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801716; x=1693406516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QLgQ1fkpck7IoUXiGnOWEhIDP57prLuQU/hGjXZH8io=;
 b=UFVj9OnrH10wSEnQLRYKwV6XGFfExSDh8L28JsVyqWfQaG64zfrd9+UGj5Nqh652ad
 FG/KI9jHco19FtzwvNzBc5iwEPYy9WRyF6og2/7ll0rWXxXd2c/NsEGy64wG0sDigEVz
 ZKG3WeeKC+kxsV+lfzgMc9ud4KCNw9MhW1f2Ah2TCnAk2fYjdRjHRMVmkJM0BhV14x30
 Z3ZgyFoppStNGvGLk3kFSehre7Jqn9iW6B8sYZRkx+LUL4a2BBYCAowPBwNLnfXjIzRM
 del4vabN81LA2zo5XtU2eop5XcaFjnD6Hm0Saco9VX4sWw5sXi28UKsC+nbvYva+OQIW
 ZJjQ==
X-Gm-Message-State: AOJu0YyYMpHSuGc1KOYJxZ6NoEe70RFAY3MyOLTEMBwfMbJwz9qWj9Le
 qJEgusUva5mig7E2W9FRhRoomQ==
X-Google-Smtp-Source: AGHT+IE67f+1qGFYD4XTFvhPyKBontP6/ynuFutk8iCFxEfvNG5LWq/t0sEsQqtUvqmUb+MS8/r4qQ==
X-Received: by 2002:a0d:c405:0:b0:56d:43cb:da98 with SMTP id
 g5-20020a0dc405000000b0056d43cbda98mr11629389ywd.29.1692801715820; 
 Wed, 23 Aug 2023 07:41:55 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a817109000000b00590f25ef8afsm2248371ywc.43.2023.08.23.07.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:41:55 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:41:53 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Linus Walleij <linus.walleij@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Carlson <stcarlso@linux.microsoft.com>
Subject: Re: [PATCH] test: Fix the help for the ut command
Message-ID: <20230823144153.GQ3953269@bill-the-cat>
References: <20230812221641.211773-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LcDbmXxF6H4z/PN8"
Content-Disposition: inline
In-Reply-To: <20230812221641.211773-1-marek.vasut+renesas@mailbox.org>
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


--LcDbmXxF6H4z/PN8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 13, 2023 at 12:16:41AM +0200, Marek Vasut wrote:

> Drop the 'ut' prefix, this is superfluous and not present in
> any of the other ut tests.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--LcDbmXxF6H4z/PN8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGrEACgkQFHw5/5Y0
tyzPRQwAuqMLWOq2e7su5Rvob48Z4K/3G1Jzw8xapZUH98a0tyfmQU26qkSk/X2y
Ai2uq71hPGvNkRaGZSstRqdiZ5suXLGF8Po4KJg++SOGLnQwOnbxmRLSS7rLbRn4
+9uMU+zTWGn7YtE1JWGkyaLDLa8bkZTm/y/rFJBVAE+aNuxcZxoiZNOremLYjM5s
UI+t32mzeGVtnunIl2bv1dqLIPuso96Cw5IrIDIW+iqJzyO0ghH9t+c3iu9T2DHx
MasxriftEwExABXE5pXEihMczZG7MC3w6nRK71Lewil6YhMOwRbuhTDp2Kjl1WtT
Q2rYzOl8s8o2xeVxIGnx25zjrn0LAKqjdVRVqpdwcmw9FVpOqzHUAldU2lN7cuvG
XVrHw5R0EimMLLmofFzYeLsvS3ufpDzghgK+h/o1VRmlPb32WEbxCIHQeby7aFYp
y9ScwWmDUR7Y3rouXUYZeVAjvD1v3W7Y/TsAEkz8D+JB9doLbBTO5slxXFVdGNhG
VzhLR2gP
=xj3M
-----END PGP SIGNATURE-----

--LcDbmXxF6H4z/PN8--
