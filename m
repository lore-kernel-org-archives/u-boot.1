Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B287CCFB42C
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 19:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69BA788CA2;
	Sat,  5 Oct 2024 21:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G/nFNfE9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EFE588B55; Sat,  5 Oct 2024 21:35:07 +0200 (CEST)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D4DD88970
 for <u-boot@lists.denx.de>; Sat,  5 Oct 2024 21:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-7ac83a98e5eso283985285a.0
 for <u-boot@lists.denx.de>; Sat, 05 Oct 2024 12:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728156904; x=1728761704; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CJ5jqSaLkBOq2HvGx5Jhf6+UiQ6okMAC3MRNK6qh8fY=;
 b=G/nFNfE9egAUe2EbSmo267atA3/RslBwYAqzrmSAz2hZLzbushcJikO0+rWQgJJmDc
 RuG8qegbJh8PYffqsZYEtDCFSgI7EAHkgFJbQIaunfVDjA7fIiQbGPYhoAe3b5mSSSZk
 DRwVHadVRciOfnm874FHgQV35pPjp0yOs+jqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728156904; x=1728761704;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CJ5jqSaLkBOq2HvGx5Jhf6+UiQ6okMAC3MRNK6qh8fY=;
 b=tKd0ad3L4Lo75JjY7CRQ/JAYxCciDUie9zaAXOP+WtU1kWC+HY3HE6MZXvyaTvq3Ls
 e6bifJxzyPHyx8QuzQeO28gqEPad40dNpxrX7R7BmVmciEPyvGNYPCQBnFeW1TMOlsHk
 YGL0hJnKKMMPuZtkgAVAPJP6y4eIXmOQ8Zzjb06xZ3gv+VlrnoyR6nWCo0401vkJJGGJ
 c0Zk0jiPwJ2IxTKwvDwD3J6SMiS9Kh8XKjjB5ii3fIcMhQEekcL0y2QP/6a0P308HTrX
 3QUY7pQYI7c7iyqe/AW678MHkUAtOQLcBKbTLIdPgT+0lUieLc4ZkmUh1bi2yb7+S62f
 IHFA==
X-Gm-Message-State: AOJu0Yxb6xI3vPqoyyGl0B2vwpPHgV9zGXxmSHIRcDH/WRBIRw8MoSoz
 H4DiEz0mJDecw6VhGGMAjINJX68344WDWaVyMy34kznQ0E28Oo6LHGHlHgY9hy0=
X-Google-Smtp-Source: AGHT+IG/oMck9CFxeD1CRu8pb0SEpMhvSPuPWBCU8XkXbXl5ItzqY7h9zpbldntsCCDq76BxVzvVjg==
X-Received: by 2002:a05:620a:248b:b0:7ac:e157:e281 with SMTP id
 af79cd13be357-7ae67e8981cmr1657966285a.32.1728156904221; 
 Sat, 05 Oct 2024 12:35:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae7563619fsm104113785a.62.2024.10.05.12.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:35:03 -0700 (PDT)
Date: Sat, 5 Oct 2024 13:35:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] clk: renesas: rcar-gen3: Fix SSCG caching replacement
 with MDSEL/PE caching
Message-ID: <20241005193500.GP4737@bill-the-cat>
References: <20241005174523.182066-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IJncaeVV5MtNzr+W"
Content-Disposition: inline
In-Reply-To: <20241005174523.182066-1-marek.vasut+renesas@mailbox.org>
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


--IJncaeVV5MtNzr+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 05, 2024 at 07:45:02PM +0200, Marek Vasut wrote:

> The SSCG is active with MDSEL[12] is not set. Previous commit
> 99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching
> with MDSEL/PE caching") inverted the conditional assignment
> of priv->sscg =3D !(cpg_mode & BIT(12)) during conversion from
> (priv->sscg ? 16 : 0) to priv->cpg_mode & BIT(core->offset) ? 16 : 0;
> Invert the assignment back to the correct state.
>=20
> This fixes R8A77980, R8A77990, R8A77995 and R8A774C0.
>=20
> Fixes: 99c7e031196d ("clk: renesas: rcar-gen3: Replace SSCG caching with =
MDSEL/PE caching")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/master, thanks!

--=20
Tom

--IJncaeVV5MtNzr+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcBlOQACgkQFHw5/5Y0
tywuuwv/dbsDeAHXoMk30OZjZiWeBFq46os0gSgIak67yTVO2P0OGQDz4Ws5XXTF
pp7TNE0fDJlawJIygybZ0s4LI8TqrPCz5rOWI67GTm+u9hWm79XmxFjGKsqPqDMj
57ff2jtrWdvBdrB7G1V7p4Fu8rLOsdovUGb/5i3+9/A9cl4FSuMTMN6J96y6TKSw
L3ICoz/l5ORnbsNIO7rsCvj4nzK8C77pJ2P573DwvAUYTHPxRqjgBQcNNPKZX5xj
Rdd68CSsl/qScOqqZUtMA7ldb8QFk4PVoyRuK7Pi4t6tDQfiOyrjitIYMU6e6MED
rDA3Cg/BhUKAIV0rr3GuENcgDiLooyHMRakIaGeD/lchM7QoMdZ5mKZJpdJnXTK2
7W8N6tNUxBSRORPM7p4dLMPa0iGYKk2s9M1X4XdW2o6TYbO8n+QRzJZCCs0QxmGc
GJHykocVTITAnWdTRWXF6LWfot0zukha4+qUzIDvA6jATpwQNrXHhHdcqz40wMVc
diqi2fIR
=WXwg
-----END PGP SIGNATURE-----

--IJncaeVV5MtNzr+W--
