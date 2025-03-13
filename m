Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B8BC282EC
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C785480FF7;
	Thu, 13 Mar 2025 17:19:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ImjEk2qu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DCD68169D; Thu, 13 Mar 2025 17:19:34 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0785180F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:19:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c08b14baa9so84867385a.3
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741882770; x=1742487570; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5aGKZMZay0cZTnMuBCD4njj6O6TkgVxSlx5qnHo98Ds=;
 b=ImjEk2quKGBk7WXZIzRDGtA4TE8m+VKvbNmH5i5quLmqbx4kul72fgsLo1jRBWMs6U
 Jj1QRntxGCwr+Kb7hvjyj7j6m8k1yDxLBDLKW85hgbaYaLDDJ6rTrRNPCIqcCEgF5q0d
 yaKKGXMtfzvCHZKTBTsowRqIGshmHiPaLUBx0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741882770; x=1742487570;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5aGKZMZay0cZTnMuBCD4njj6O6TkgVxSlx5qnHo98Ds=;
 b=Miq5WurJt2hPVNp1NzW97RYRBxlrK7GJRCzZ4EXI1LB4VsEmVpGSgdFcnQ/24QHblU
 OTFoftsil5ERAY+BxmIXla2ibYvktYr2yeAQw3nHy5XDAA71FsDDjBCm5LXAu0puoBiL
 3sPqPte/K5u28+RU63ogbui9J5z6ZrAz1YUpEKSIMsjROv7SFfs/qplS4dD/1E315m+0
 Wt3XxREojOXHT+fjlVIjeRXBGx0y6bbi/kDMPpFDAG0ReoNJ048/s34nZetNZH7AyBVt
 X5h5R89Od2vDSSq50dHbH48S2Ubxiv6dZidb60F9rRd2damVzrfQSEdqmM5QOisHITJ1
 Y98Q==
X-Gm-Message-State: AOJu0YxPOxoSEtJuF11i83MWK/TTegjIju99RWDTje4opfQg/rC4rT5A
 Bx52MUAicLFO4NQfgNlgvKdBxOU99QNtjIoQ/FyZjzqCHtuq8a/D+Ft9GfVkdoNjI5ErG8dVIyh
 F
X-Gm-Gg: ASbGncug9MPOa7HjpU5BXt17e1GjTkGJCGKbGXvDaH77l2D1eKam8aRLNNpITJ6QiPK
 2RYjZsLN4eZzoESeGRlH0wdalGUwutfKDD+SRfGArb/fTj/IrqhqHoEPjl7tfaRLatuaiNgnbFC
 Nuh2D+vIEIEUDDpkPEEhwM/AvVHtViyZw7xUeuvEo5h4GafiIJS3XRo/mqXf1yzbnZ/4bbwbSXI
 T6gDM/FgAdfFQbulU60VQtmE7TKKt2N4M92kJbzlV3Stnz3FfHrgmT43cYa/e4N2z34SFLMZYLP
 C5jFedngzbn/eejx67mlYr5PWb02RtvRc/thav0rsgqB6Q==
X-Google-Smtp-Source: AGHT+IED6jTXWOdVIVo/xmUwUc/W9Jx0H7MBShP0/ee9bNxt1xJMXP5sYQEc7z/X3jluFlzeMABQEg==
X-Received: by 2002:ad4:5ba9:0:b0:6e8:fcda:6863 with SMTP id
 6a1803df08f44-6eae79ed91emr4312746d6.14.1741882769941; 
 Thu, 13 Mar 2025 09:19:29 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6eade34c75fsm11098726d6.112.2025.03.13.09.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:19:29 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:19:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Harsha Vardhan V M <h-vm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [RFC PATCH 3/4] drivers: k3_fuse: Add fuse sub-system func calls
Message-ID: <20250313161927.GG2640854@bill-the-cat>
References: <20250313115517.1181829-1-h-vm@ti.com>
 <20250313115517.1181829-4-h-vm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7C3l1ZTNIk2v418Y"
Content-Disposition: inline
In-Reply-To: <20250313115517.1181829-4-h-vm@ti.com>
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


--7C3l1ZTNIk2v418Y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 05:25:16PM +0530, Harsha Vardhan V M wrote:

> Add K3_FUSE config option to add and enable fuse sub-system
> implementation function calls.
>=20
> Signed-off-by: Harsha Vardhan V M <h-vm@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

And can you please file an issue on
https://source.denx.de/u-boot/u-boot/-/issues/ to further clean-up the
fuse related Kconfig symbols and logic? What we have today is a bit odd,
but it's I think easier for me to go and shuffle things than explain how
I think it should be. Thanks.

--=20
Tom

--7C3l1ZTNIk2v418Y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTBY4ACgkQFHw5/5Y0
tyyDIwwAry0fUnzrR/OKlz1LCHwy7Lfn/Oui5ptDp9FeXZ2tR6twl1Gll2LJzoMh
iM9xfbF5ZIZfAtvLwxUNQqopMPLanQv07a+svxZi6i8VztjPw80XJD8Cu4MfdQha
SKsDz62cWLyn0IAO1Wk7W8Q/pj769JmNkQdnrkoLdnfBUThEQqX2/3Y+NAFLYMFG
WFAbmUYy5zYoVr8r2FIXbKboTwyTgA9SOtAhtWSJVfaVgQzf0VmlYdWc+0vN6i6b
tnD2RTP/eHIq7JDeY6FJygzr4kPXaE12/QLtdkb/6YREs2gYUBEdmjXO3onAIMiF
v6Pp1h2E5e028dPeM6DBoNUG0PHsD+2lIV6Wc8zjeRAKAJxlkQOXRUM9CYl+fcjz
lK/StjgP6YhJ9jap2cJGLExoMcJKKkbDZ+mUD02vc/qmi4WRV/P0kvqTHnBJV7VQ
JUkOqVYY6EkQPw/sphD8PGJknaj399a6Y0UZmd2UDCDwvVY9I524uJ1JNRAJxrFQ
rWblAg/0
=NF9G
-----END PGP SIGNATURE-----

--7C3l1ZTNIk2v418Y--
