Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930F1D7494E
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 23:54:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5313E891B2;
	Wed, 30 Oct 2024 00:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZqCMfZmd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F60D891E3; Wed, 30 Oct 2024 00:53:41 +0100 (CET)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6320E891B2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 00:53:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e5ffbc6acbso3601499b6e.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 16:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730246018; x=1730850818; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eObaHxaTBvRc3SuD8xkm7dy7b4fHTU00mxviENsE70s=;
 b=ZqCMfZmdVuK6NBLzZ7f8s5qViPksxhA+Q3NAlQ3u6ar3gLzgrWAf2nr+GbvAuVX6Vb
 hy06XokYTReg4mZDbEPzsxzmEOTfq2zEsuZPiy2avL4JMFQ2jMZh7CLIWPRlCkEU8J9V
 G+vPH0jMexEnVXk5OqRHwmwJrDN+M6sHgLC0k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730246018; x=1730850818;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eObaHxaTBvRc3SuD8xkm7dy7b4fHTU00mxviENsE70s=;
 b=KL0LiEyXztkPAcsRmPVx4cVJ/V8A5Wfj1Voeg7BMQuhucDS28jNkq2Wy3WJQ0S7VhD
 fSveASxmGhXbLXNyhPnOc35SLK00L1nNVz7pM8U05AvAHangZntjPlT1H5g1lHGfOeos
 K3F4VB+nPGZO78dP03VzOHe0dha+DdN+0HgJYZ70uhROZ1WRl7vvOqR2HvPPu1vFkyTI
 Ef63fdPWl/XIAaVx45AHEYkx3FKDHnHPWk90fOfJZ/esY0Q8BuB3uSrHNK2Q8EedR+R3
 abuAuCJUIDSmBj+oXjDPm9wP7Y/Nw19hxL28ibalgm00NQgOauqerTnYRCL5s26EanyX
 1w/Q==
X-Gm-Message-State: AOJu0YxxlD1eSW87CAC8jzsBHzwmK6cScrhOA5rKLj1E6lmCPtMM13Ks
 0Y6w11SYS4quX6mNFe6qn9+onbqiAbrFW2EbF1vcVLKKUhi7Fqx/JtTMO9Q6j1Q=
X-Google-Smtp-Source: AGHT+IFRTLILYde1hLv/1s+2yb99ATE88r9wcBQqZG+iJUYraODe78lkpKfqdPpk/z4hlj3vuVohdA==
X-Received: by 2002:a05:6808:1482:b0:3e6:1f2a:7f6e with SMTP id
 5614622812f47-3e63846649cmr12806675b6e.25.1730246018082; 
 Tue, 29 Oct 2024 16:53:38 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17991c943sm46573036d6.65.2024.10.29.16.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 16:53:37 -0700 (PDT)
Date: Tue, 29 Oct 2024 17:53:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v7 09/11] test: Add a section for closing the connection
Message-ID: <20241029235334.GI2558755@bill-the-cat>
References: <20241010015145.1977999-1-sjg@chromium.org>
 <20241010015145.1977999-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q2aaT5SlnqI3Y5Pq"
Content-Disposition: inline
In-Reply-To: <20241010015145.1977999-10-sjg@chromium.org>
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


--Q2aaT5SlnqI3Y5Pq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 07:51:43PM -0600, Simon Glass wrote:

> This can take a while and involve multiple steps (e.g. turning the board
> back off). Add a section for it and show the output.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Logging can be useful, so this is fine.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Q2aaT5SlnqI3Y5Pq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchdX4ACgkQFHw5/5Y0
tyxAogv/YyZ2tS/dOxu7v2eylrTGTPZ1c0CNcSFi56y+Qpq8hMgrA8IqbDusLRqm
pLSSNetW2AdLxZJMmwdP0aocqs+GEOM6tX3m5NIy0g90k6aJLp1Hu5TEwOJxiajT
SnqeS21jZLUkJ2bcfkcpqqXdtYnPyWV3sn1xEHyy73iEWdI7tWioB13QKLyz1QDB
Sn94HdgQWTU1kzadgEpyHE7nnRXb7LhnBib9hWPYY9VFMGgPvdeYC2U/Fj8kDyaw
XkNdMUgmE2wsKh38FlMJtfhPVhWAGqhZoiGtrVsxkUEW80fJ34dGxVIzSxb0+dYU
h9ZzxI7jPWvi1XpXbm4sU0nBJzL702jVa5OtbPaIZ3avvvf/AkX7fsfosWh/tqvY
vziXHgRBgvclNAl5I88IKOQzjwzLjtnZ3121mQEJAyMp0Skv5rB5pX1LzVZbXNpO
BiLft1kyOCZWVr95eO7U1zv5JdxwLwJ8x6HmEk1NCtZo91g1hUCJHGODXngPJiTB
U7YjxWWZ
=kv7f
-----END PGP SIGNATURE-----

--Q2aaT5SlnqI3Y5Pq--
