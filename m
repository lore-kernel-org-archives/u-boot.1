Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63A57C19F32
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 13:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C25A98083E;
	Thu, 27 Feb 2025 14:48:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="r1yNWcKZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C8D980F12; Thu, 27 Feb 2025 14:48:16 +0100 (CET)
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com
 [IPv6:2607:f8b0:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D03C3807FB
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 14:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22356471820so10074315ad.0
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 05:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740664092; x=1741268892; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KKIrPQ7Tptc1bHIC2lSm8IrHo2ZQuNJaGl838ufTzcM=;
 b=r1yNWcKZGDMfnUSGg/0jXdIDpMfk/mCHFglQByTVN7DwTlfi7K8UqeGv7wXL146s6x
 JK37FdxG1c6fvTUXZfaUrNUrkH+sxBY0jAqtSmU1YG1S8gRDPne9VpHJ56LKaLpYIaRB
 +ePnsDkLOCQNAd/4d5OlN7mklidEQ8KurN/C0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740664092; x=1741268892;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KKIrPQ7Tptc1bHIC2lSm8IrHo2ZQuNJaGl838ufTzcM=;
 b=Z6hVM3ynZE0Us7Sjapf+6w4gsRXnFESwBpeR/PZLe5Nz7Acy6oXfIsWqBQrz0sOgHN
 6/Rn01AC1SMZnzvLmoB9CzdLU+ic/skdA/rAiGZNZs5ap3iQHzBXTNziWzNFNI+hp9xJ
 epz/MytaEUEq5iYFg7sZ+cIhpuT2vXr/8CQ47ffACLRauCeYAKM7gIigkCwqyBfPHepT
 VJbUEFL2CiIC3xSEqYlDqi4X/W4P3xjSQOu1IPzb7kxRPSbR5RGki+EQ055FoMPV2lH7
 4iQJ33M7MWRAIIjsRnHD936wBYyHF7W4GJqciaSDSX2HQBFEd+AuhiAEtQwJfP9a1TTE
 XxAA==
X-Gm-Message-State: AOJu0YxhR4f3NlBK+mcE4XQc+LANbcbdqD7nexsHtRgBac4SLmK53fcl
 8F24Makcwn64WoQQN2INj9pmX3D5a5ShbfXWX1t+HVV/jSNlkjh97oOoOuVR274=
X-Gm-Gg: ASbGnctP0kRglLDNO1vDGYt7jVEj7rdoj8o2CaJJwSHQbftCtJervOUUgUcL2yEGa4V
 Buma64Jgp74icaJtXfJSyhwWRIN1jayUTkuJkraWPht9AMHbrcu7DQQYijPD5XLpqH/PX/1EiUJ
 SmTLWO8RrjEfpADGyyhhLZ0On107ntdAGZ0MqL3eFJaPthoUeTatmsJ2QFpaGiw6fyobebTyQec
 sEtKYU57DrkU+Re2RiN+zB9C4USwmfiDDxFiB1Siq1gWMoQPC9jPuGOQh+P32kE+xmErlUUZJ0j
 LTO4S8j2VBzTiF1XCJjMAIiq
X-Google-Smtp-Source: AGHT+IFfGZpRg+ZF2zfBLNLu59YgxsnNOq0Et+lhlkW6GLT15W1OxKIXXEPO4GIEFDrO3DTrACuUyA==
X-Received: by 2002:a17:902:e751:b0:223:5e6a:57ab with SMTP id
 d9443c01a7336-2235e6a58a9mr17002415ad.39.1740664092367; 
 Thu, 27 Feb 2025 05:48:12 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501d3286sm14555505ad.46.2025.02.27.05.48.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 05:48:11 -0800 (PST)
Date: Thu, 27 Feb 2025 07:48:09 -0600
From: Tom Rini <trini@konsulko.com>
To: tien.fong.chee@intel.com
Cc: u-boot@lists.denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] MAINTAINERS, git-mailrc: socfpga: Update email to Altera
Message-ID: <20250227134809.GT2640854@bill-the-cat>
References: <20250227040904.18714-1-tien.fong.chee@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JOFgKD5wagO4OqNc"
Content-Disposition: inline
In-Reply-To: <20250227040904.18714-1-tien.fong.chee@intel.com>
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


--JOFgKD5wagO4OqNc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 27, 2025 at 12:09:04PM +0800, tien.fong.chee@intel.com wrote:

> From: Tien Fong Chee <tien.fong.chee@intel.com>
>=20
> Altera officially split off from Intel, the email need be updated to ensu=
re
> uninterrupted support and communication
>=20
> Signed-off-by: Tien Fong Chee <tien.fong.chee@intel.com>
> ---
>  doc/git-mailrc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Similar to the xilinx.com -> amd.com transition, I think you should
update .mailmap as well for everyone listed in MAINTAINERS files,
thanks!

--=20
Tom

--JOFgKD5wagO4OqNc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfAbQ0ACgkQFHw5/5Y0
tyzctwv/cmbq8E1DVp/FgirYVaOUJZYNJazOxfexumLQSpg/HbGVxFtYscYOYeJm
6aIQgoA0wT3bsgjrV0OPP9a3r82SE/jaL3D0TJBOc+75tvFklnG/jZkV3HBEnb2U
Ay3WHkdmzQ6cKtIIqQwRJ94Vw11JBi1U97WoR22zx/y0OV4TNPM8CAzlnKPPVjXE
kEjIsZJXRyktCVBZ1/aCT7ap6LYZiPVtbzz7qFGMNOhWS9t6K8N+RCBaqsht8iGk
1iMSzCegGouhHmLdJSK7u9PXf/mgLNktvPNAamPgGYebzCz2RuNICElmajmjFyh8
ULY65iTdqMIq1EuIoTz3AaxsDckQLaY5e3P9ygYF8lfbuAWirG0wABXKt4Se5HTo
ysmVyIzhKENlqysaxvjmcakgedwiwrd+DXmptZ4Q4EQCwCJPVY4N2tdb7INSIGyn
OCBX44f7VWyaLEmAuHvladTWYgIUs6j0j8OmUyePo89h2kuLb/pGOXQ+o1xhI17i
USHM6tUV
=6uT1
-----END PGP SIGNATURE-----

--JOFgKD5wagO4OqNc--
