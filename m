Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B3BC4332F
	for <u-boot@archiver.kernel.org>; Mon, 30 Oct 2023 15:55:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7279587AA1;
	Mon, 30 Oct 2023 16:55:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PovTzf6t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3AAD386F50; Mon, 30 Oct 2023 16:55:00 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36AC487A4D
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 16:54:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-671357f0209so12801226d6.0
 for <u-boot@lists.denx.de>; Mon, 30 Oct 2023 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698681294; x=1699286094; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ZLSlyDGvgsgkMhZu4I7R5sZnR0pcET35880vgchu3A=;
 b=PovTzf6tUE599iM9uk61fmBWHneHprO8gQ/mDV2wnYtD7u3hWAkFNCcKby9F7zc57F
 cACMwA74QxE8T/CjU+2fMcSU5P3orWSkVi2GRPcWMCU5ZaG8uI1aord73DYsAQJ7MaYX
 rDI6mBVRyT7zwcVPpXKi8ixn1usKW74yXnbrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698681294; x=1699286094;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ZLSlyDGvgsgkMhZu4I7R5sZnR0pcET35880vgchu3A=;
 b=o1iX907APhaYzTp3KVMlf5Esmr1RE57Jmqv9mrTPv3yGJLkbY/J05dzQdRvsVGzaRR
 05ammxhwksYIsOt6p+llCY5h8av6g61zgLL5wFdeJi1cIczSf0JTVM+GAGfXvz5L/VQH
 S4E4LTPuEUNw7gfDOw96r1FlOet6tEoRFSe7vzmVr7ztHhc4qpeFkasbVAkRQyCMQT/J
 W8BaefkM8azR5a6rzEKutdQcJIO2drP6c/lwYi8+3b/5PxU7isAFftO3VDVMh5omx8Q3
 87E6BsoPgS516MjhGO5jRat4oeyeqi95R7TiQGcGUy24K282oRvMCARxhlwDI1jBbdhI
 tC+g==
X-Gm-Message-State: AOJu0Yyju7lJhlmg1Gyhjd0O+emiG1Hj0pf5YdpD2xUVFSBbnP9KqwYQ
 4+ArhyjdJjr9bE/pTc/a1R6bHVBKQMUgT051bcTOPw==
X-Google-Smtp-Source: AGHT+IFJ6QaJZeQUzd2qA+4T9D4kH5pQ1/5j03uLGzO2YgNovQdgXUfooxhocQAxaWHr1D79X8YAxw==
X-Received: by 2002:ad4:5ec8:0:b0:670:bcfd:307a with SMTP id
 jm8-20020ad45ec8000000b00670bcfd307amr8580701qvb.23.1698681294584; 
 Mon, 30 Oct 2023 08:54:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 mi8-20020a056214558800b0066d05ed3778sm3523615qvb.56.2023.10.30.08.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 08:54:53 -0700 (PDT)
Date: Mon, 30 Oct 2023 11:54:51 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-custodians@lists.denx.de,
 u-boot-board-maintainers@lists.denx.de
Subject: Dropping common.h usage
Message-ID: <20231030155451.GT496310@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JNcFsj6dFtE+j1B4"
Content-Disposition: inline
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


--JNcFsj6dFtE+j1B4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

Now that checkpatch.pl complains about adding common.h to new files, I
would like to ask custodians to try and fixup patches that had been
submitted already and use the header. In general, we can just drop the
file entirely. If we can't it's often a quick fix of which include file
was missing already. If it's a mess to unwind, that's another matter of
course. Thanks!

--=20
Tom

--JNcFsj6dFtE+j1B4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU/0cgACgkQFHw5/5Y0
tyyLHAwAp2KtfzPjwtyKrEWRFug5Hv9Z1aTBH/c92XLl/0yC5Slt5mqlG0vEVFHD
kYPoj5wqrJdw3zqc1gli+jN96Wm37Y6XXO47npyr023/1/sg8Q3PsP7BXpTVkW65
ED+R2n7hY2ohYtoYlgErLSwJpmZfLdPzrClPrsAKf9flheuQz1YJzvA8vWJMvXtt
XLt8GR75TN7UCOeACvRR01gsluy2YX7myN7dNr+GzN9S+1QV7WYL+7FhsQSaBhXT
Kr01LAeES2A7eDI6QfsLLEgfhrNu3rUyh3fW1rNhDgYMEnKDYwfdSW5wAWjm2apB
jGj+Xas16pqAJpJuTBe+tmJSu2Qm+Y7nQgV/bbZG21M64y5Q2O5xzJesAFFWA+Q9
HpiDGYNpm+KQPivXv29cu/kRF3JkM4cDZYtTDUBvfqBRnrSwXenhS+NLiFbHMNNa
KPen8kT6ow7XlDw9UYXdDYkhbda/S4TeOZsaB9zlq9L6OmAyhicK/32qW7KaCmUV
FrN+fndU
=NNRW
-----END PGP SIGNATURE-----

--JNcFsj6dFtE+j1B4--
