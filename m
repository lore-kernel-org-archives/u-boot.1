Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16BCD132CD
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 13:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7D0588F4E;
	Mon,  4 Nov 2024 14:56:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JosWkdyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA64288936; Mon,  4 Nov 2024 14:56:58 +0100 (CET)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781AB8904D
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 14:56:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7b155cca097so341180485a.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 05:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730728615; x=1731333415; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G3xEVNJKqqdrl4nMBP9/4u3ofwnpA2OJNwRo8FYKFVM=;
 b=JosWkdyuqDQmANxMCoQNI1+i0Xr6cz7G4SZJmi/RQuCNScpzfRtqWLHK26vuzn+mEc
 HKE1paXjCLYvgoNy/b2+VoXUmCimzB+OIy9ikjlg8M0dbkAfYuSS1+SgrrE07utbObDJ
 nC3ZXPgCDK7Vh4TzboGOy71VaLZhNkgnya0vI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730728615; x=1731333415;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G3xEVNJKqqdrl4nMBP9/4u3ofwnpA2OJNwRo8FYKFVM=;
 b=rB9hvQp4BQy2t1jEetY8/ecx5/rdcTOwDemNX5rsmyEGnpMOaxgHjkMdDqUu8AL7CA
 WajGDy37MSg6/YGl4Ry0qzg7HP241HJbdQLZERf9IL6QZW2MT+ZCJIksEWYaEDk/euN3
 +oGwD6fOuwnIWbRPhNEiMbYihCVXtDWSH/LIxboxLz9eMIsXXTxAFnwQl6QUAqeYzbm3
 x33MaL5dPlK6LYE3aZm09qG7oMUbN/Oz1ytLvme5cdsHsuH1i+h+doki5HmGOL7Ad89V
 G0Vb6EY7L3MKosaCtVatICOqMJCICc7EopFWRddV9YNFGjLbQWwKXVSUyhWH7w8bJTXU
 X+nA==
X-Gm-Message-State: AOJu0Yx6UUytZ53cOfTWYVAkVbJU6a9J0V4f8w+CGSppVfZmNhHcU5Jh
 t12XmBWvytIRcsy9r7WbCBV5ENLB3qWe945XA7gNwhtU4eRxe11BIfsQYClg868=
X-Google-Smtp-Source: AGHT+IHZ0zkYq47XtTWucEjysTa2rTB4sWk3YoDxWx/JNL8iFxCnY0MxRC1TCEzYL5lnEuNo28RaUA==
X-Received: by 2002:a05:620a:178f:b0:7b1:4222:b385 with SMTP id
 af79cd13be357-7b2f3cfd150mr2945290085a.11.1730728615357; 
 Mon, 04 Nov 2024 05:56:55 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b2f39e9c76sm422499085a.22.2024.11.04.05.56.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 05:56:54 -0800 (PST)
Date: Mon, 4 Nov 2024 07:56:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH 7/9] docker: Drop coreboot for arm64
Message-ID: <20241104135652.GN3600562@bill-the-cat>
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TPiztnP9gOSX+Ofu"
Content-Disposition: inline
In-Reply-To: <20241104133954.840994-8-sjg@chromium.org>
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


--TPiztnP9gOSX+Ofu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2024 at 06:39:51AM -0700, Simon Glass wrote:

> This isn't needed for sandbox builds and coreboot isn't much used on
> arm64, nor does U-Boot have a build that supports running from coreboot
> on any ARM target.
>=20
> So drop it.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--TPiztnP9gOSX+Ofu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmco0qQACgkQFHw5/5Y0
tyyFEQv9Ho/eCvgbZrDOJeFARY/lms087I95eD35Tb3tMvpoApHn+9mzO9P4zX9E
GVLIM5v951WHCOsZDUKR+dg/ADGCqnBqEcF2gk5fv66ayUPF4wsrI64QguXUAYtv
azhBdp+77vWUNjXB0rjKT59AKC5YBX9cKphsqJ2r4OJh8b1Cx1a25oNiTNKYWZVC
kWAQqKeQd6YsBkGbqawkqOFgu5B6KIFQ8cDfXZYzcwKx7Q1GTMjiYxy51neBAqYM
8cFiZFH2UQMe7orE1y4ncswP2vTKzXqwetB5VbsB+qhklC2+/heq95FPxVxx0tOn
t14f3MT1uw0zZzvZZAmErUOWkDZBkIlyZARas0EMPQycHCZpqvs6J3AagNmNRP+k
lZ8yyffIG91xjTEG/+SpfVMvQxZ8GsTI8TngUSiMdLtKBdJXWB+PC3jDi2x+S/Qg
SVgbgW4vx3elpgg55QTgzxWECshhnwmd17/pbxWu2VjBLO8scqkMvwrB5NaAPrWY
PwrDNR8F
=d0E8
-----END PGP SIGNATURE-----

--TPiztnP9gOSX+Ofu--
