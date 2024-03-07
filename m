Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB8AC54E49
	for <u-boot@archiver.kernel.org>; Thu,  7 Mar 2024 17:13:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B54AF87F07;
	Thu,  7 Mar 2024 18:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qq1N2PVC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0522787E89; Thu,  7 Mar 2024 18:13:16 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 922C087DE5
 for <u-boot@lists.denx.de>; Thu,  7 Mar 2024 18:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-42e29149883so5547851cf.2
 for <u-boot@lists.denx.de>; Thu, 07 Mar 2024 09:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709831592; x=1710436392; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AElWVaeiYIoIPNiGwU3ZPpuCdFGd/RAYLjTI+8yvK8Q=;
 b=Qq1N2PVCW/73P60QLONN1/TV3Jf5Steg9ngGQTssgTzRAzNlFdjXTZHcY1RIsDWJPo
 JYiouhz064DjHtv/rntSTvPTxZtDW95sq8ny5Mg8Fw3S2wHWvB3p5F4ojPn+Ofq4vLgD
 ydgjvGg/q0nd7WfG8aiLlbhGHC45QIenVmmD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709831592; x=1710436392;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AElWVaeiYIoIPNiGwU3ZPpuCdFGd/RAYLjTI+8yvK8Q=;
 b=TNOg0ohEpMs7bmdvUFvS79UBL7s5bc+fXTguZRbnaryuaQHCQoGYv2uXjF+tEAcoB3
 j083Zt+DutzNvb2rr/iEa3RomuXVsbT4TaNltg/E4Lae9xgPuWFK+n/Zugqm57FR9H5t
 6WmXMxDHniRDee8iybelEqZLO/7QznQDn9v2DLvr57+28BJjU2WLoSwRB2JAz+jL7Mrz
 bZb+XWBnwkDHlZSkPCujormxR08Wta0BmaID8iPYoM/M+ma9Zeny8mkoZv4qPelNsP3s
 RXRoDeq8It0YLUwIvEbTLomKvil26K495B9isHQVvkpZIbsc0yvqMoF+a0IrIH1o/ASv
 GQlw==
X-Gm-Message-State: AOJu0YwI20sJcU9CKdf4LolC23krMNVyVbUApSk9tuF4iQ/xF/g+SjFa
 D7th9N/yloVKryvKij2ALwf8m6YJs/D3HG4iyD5EVJqALDq+Z7nYXAJ2yjRlXmQ=
X-Google-Smtp-Source: AGHT+IFHXKDsY3lnjcJHkuQM0hcnkiZnTgPzlYuwrK3ShUg95fxbvTl6r1PuUtown/qEAAzOY23k+Q==
X-Received: by 2002:a05:622a:2cc:b0:42e:c4d6:8861 with SMTP id
 a12-20020a05622a02cc00b0042ec4d68861mr10187731qtx.54.1709831562491; 
 Thu, 07 Mar 2024 09:12:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:7f::1001]) by smtp.gmail.com with ESMTPSA id
 k19-20020ac85fd3000000b0042eeddf4e42sm4666355qta.70.2024.03.07.09.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Mar 2024 09:12:42 -0800 (PST)
Date: Thu, 7 Mar 2024 12:12:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, nm@ti.com, upstream@lists.phytec.de,
	d-gole@ti.com
Subject: Re: [PATCH v3 2/2] doc: board: phytec: Add phyCORE-AM64x
Message-ID: <20240307171240.GP1523872@bill-the-cat>
References: <20240228084217.935848-1-w.egorov@phytec.de>
 <20240228084217.935848-3-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="s/lhfXZ0CybGwvss"
Content-Disposition: inline
In-Reply-To: <20240228084217.935848-3-w.egorov@phytec.de>
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


--s/lhfXZ0CybGwvss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 09:42:17AM +0100, Wadim Egorov wrote:

> Add documentation for PHYTEC phyCORE-AM64x SoM.
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> Reviewed-by: Dhruva Gole <d-gole@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--s/lhfXZ0CybGwvss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXp9YgACgkQFHw5/5Y0
tyz+Zwv/Y12EnbJ67VRTFfXgBdWqNP5WD++6vGB6W9Mb0CxpU0Fs0pfCmdI/qhIX
KrT/vFRI7AxYQgttprBTUVhzxlMr5vxa7ofN+jZctvKxeXsOtNK3hfSjq066zbUM
PWhT5SFOmIHYFsir1XCtG8Ks8wFvxwAHaafI0tzigytRePeLNUCM06S0Emb5jHPU
AJaAF8c36HckLPAn50OYDcLVQgNM2U5tS5nTzfUP0dHYhj9tybLWO7FSI5stz9pI
sI1E4R5dQO87ahrfm0Y2JpTJXKgpAKkCXjFVi3XPRSv2oH6jVJE65G2JGXDnX2bP
SZg/8PRCXHrEOhHTfCoves17+TlJpxOO+StCMqzTFYhB7y9K8xS6O0P0UgTAFiUN
lX4VesPv/w3ZNpLCwnj6nYJPhE7r6zr+dOYQ9fCLSFzEOmUkgnb656cde79D07gP
UhaaiMI800uEvzceusTVzusFaHn4OAk8y2ypm+jleA5ljU3e2GGlCoROlaV1PhH2
Xg4QU1wR
=aYni
-----END PGP SIGNATURE-----

--s/lhfXZ0CybGwvss--
