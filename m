Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A091CCF3188
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 21:54:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7B688E70;
	Tue,  1 Oct 2024 23:54:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nTKbGH//";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 718A888DFB; Tue,  1 Oct 2024 23:54:46 +0200 (CEST)
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com
 [IPv6:2607:f8b0:4864:20::f31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 654B388DFB
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 23:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6cb2d2a7d48so42383546d6.3
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 14:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727819683; x=1728424483; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+0uzNbEA3oWSsfVMMZ+665hgQV3B2+hz39+myXwfx2o=;
 b=nTKbGH///ytDcbUl+J1jzdxiT/rBUDatVT3VOWPf3tKVoamDbDzANYEbOzal7i6oGu
 gm3LIlD0hi3djCKFIQ3bXYrXFENuvcsEEDzjLk4IDQvQbIcYJzKYJrXTwP9GDGw827zA
 8R++KRKtREZNmxfB8R+fMwhM71OgewKSUyLec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727819683; x=1728424483;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0uzNbEA3oWSsfVMMZ+665hgQV3B2+hz39+myXwfx2o=;
 b=McK3TzAMpvsYek08rQaa9eG0hqvBLoyqfGizVwlfudb8CL6ZbvstfzP6ViAPtAwPdo
 Hd8FYwNUxhZzdVbpE+InJ44OP6bBOcjYk1By4vzKUk2alOhynEXL8nXF1gwVrctQrpE/
 6zSdL5adLxhK5RQFrj26FlXGbD8MV7Ki10N3qlvFIWTQKvITt8Qw87S+NywAngclWdvv
 WSXsZoiN32vx0+TKGyQB/pd2VhUfYojPxMA2cMhvFYe3u9L8pInsx8Y9rj2kn2F87GX+
 eWrYPv6mqaqrp2w6fj0sH4uC7D1Ruzwvg66mM56rRmn7LRjvs1nvQgnqjS6XKJimqKEn
 r28Q==
X-Gm-Message-State: AOJu0YykLV88b3gUil3ibE0P01E6wmTEKTzEJ+oWNh9wJATcDl7Ky4RU
 2qTxkrrBJyYC9WVYptP+HZ/v8lYFZXVRXw2pP5X6lVuokTk+wNS53QGjoHr9Ico=
X-Google-Smtp-Source: AGHT+IHLD1LukrnTvCWjQoyfkWJCh5oeuu4TW1DCLEZDqXTDDodYI4WxE8mXmwQFgSR8otyOaAU7Wg==
X-Received: by 2002:a05:6214:459a:b0:6cb:83a8:a976 with SMTP id
 6a1803df08f44-6cb83a8ab01mr5370236d6.53.1727819683192; 
 Tue, 01 Oct 2024 14:54:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b614142sm54122896d6.57.2024.10.01.14.54.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 14:54:42 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:54:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Masahiro Yamada <masahiroy@kernel.org>, Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v3 01/33] Makefile: Add a u-boot.cfg file for VPL
Message-ID: <20241001215439.GK4737@bill-the-cat>
References: <20240930014956.1434060-1-sjg@chromium.org>
 <20240930014956.1434060-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tnTO3R5Qv+CjvkcG"
Content-Disposition: inline
In-Reply-To: <20240930014956.1434060-2-sjg@chromium.org>
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


--tnTO3R5Qv+CjvkcG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 07:49:24PM -0600, Simon Glass wrote:

> Create this file for VPL as well, for consistency.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--tnTO3R5Qv+CjvkcG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8b58ACgkQFHw5/5Y0
tyx0wgv/XMG5p+M2BMl1C2tpFMqHOpOqPkTlm6KJ25KUlMbVm+PfyR1T/iiJDqzB
zTRn8RJNntRgxV8mq5NtCb1FIieU/00jQte7NZJud4T0kxNtbqa58ixkTS4e3F91
oJYVkYF2YzyL6cu+elzNzWOsNyv+2gXFaFqIBQX4ZunvuXV/x59/Ot7CFAewOFXz
0nyZ37vcFJ5YHNCiisoAiadM/4Iaf2mvPqmL/eETCV4nalZhPSixwI7+BtfEIq0P
7++w9RvilP0Acb3xcUSSFaFIjUKGrxxI8QSPEDIndcHn5EmVzgDnxukGzFPVrYnR
9jNfS3av+KeGe/QRL35p542zrNRN9dLTbKzuljL4yFvZ6+SLOVdPFd4yQmKdHsms
KxjKqHCw2sNwWri51mAntIlGHl+R1LyDd6N+KO7C/ogTVLeQpWay8ujQaY0NwPOO
fAWCOKSiuA5a7SEC4bB/U+8ZKOo0xK0PZhwKeIPMNBnOG77mU2ULokhRMMBzlYOc
dIgDv7nx
=Wm+S
-----END PGP SIGNATURE-----

--tnTO3R5Qv+CjvkcG--
