Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A934C4828F
	for <u-boot@archiver.kernel.org>; Wed,  7 Feb 2024 15:45:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F8C187C9A;
	Wed,  7 Feb 2024 16:45:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZsrysgUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E5E787B05; Wed,  7 Feb 2024 16:44:59 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A56387D08
 for <u-boot@lists.denx.de>; Wed,  7 Feb 2024 16:44:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78562c1ca4dso23180485a.0
 for <u-boot@lists.denx.de>; Wed, 07 Feb 2024 07:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707320695; x=1707925495; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=biTb6/Lb+GVGBiAMhKT8+BjlVw9ulDTdmxC+HeTGSGU=;
 b=ZsrysgUeY0TTx5npOEuPjeu/3JOMg2UWV73mp+1PIUToEPS8QuQc/Sg2pyUU/COCk+
 V2j0fQzunLOYsSf2+MgsmAios3a5LTIIfKN/8OhLAvIQiVYsMR8665bjZ39GkDQdIj3O
 QLeXzdQX0Y0Uu6nRx4XWH0O4S3mcHoC7UPJrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707320695; x=1707925495;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=biTb6/Lb+GVGBiAMhKT8+BjlVw9ulDTdmxC+HeTGSGU=;
 b=c7voO6UewmD8f9TIFTJzuRcfZ78JE7b/ZDETZ9FqNGLLNS7GY6+1I9mdg0T1hNHcBD
 7kq2MH1CgX7hnAZppyfP1YYijOWq2BvNTTs7chFHoKgmlDt1uAl5vUX11RWSM8IAlY8K
 f48iyapPtutWqPZvoa15Vr0ShM26bfJocODo/jzFcZB9lf5vS4+aKtIMdpLBzEQ01mg9
 egG3WhUXKVdb/8ah1NSkhwRE31jbHFm1TIKd3rJ7+2w9RLykwm7UBwjeo+YRAOkZ2+dl
 u2Wko6sK9jg0jrCwrS0RZOWloPeUg4d4p66w2eYo9I/EIyJ4IUPD5YRH0O0Ho7kSjkbt
 Z24g==
X-Gm-Message-State: AOJu0YwoD04gRyCghBGlFgTh3bcWMC6WKD86po1F3i22DPGziALs5kiQ
 lUDK9PbHLUucQEDLtYJ4dWBIaGQDePX+CApXhmmc00soZn/KBlORgUDPk1ls6AtSThAoSh7riel
 G
X-Google-Smtp-Source: AGHT+IHssIGaQSFLURMnTy1if8zmQf1yqQdMFmhvbWN0O21urhk/IJiOSxmSeF4BwZvu/mqNBSZcOw==
X-Received: by 2002:a05:620a:200c:b0:781:6055:9283 with SMTP id
 c12-20020a05620a200c00b0078160559283mr6069631qka.64.1707320695340; 
 Wed, 07 Feb 2024 07:44:55 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWGtPLg//Fa1yLzJ3GHglOFg+uDQcq7wpXkRppHZ9nMWfUW8Tug2TXFC5524Ii+n99pz55iqyFutxetZ0GlznSfC/DMxQ==
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 d4-20020a05620a136400b007856017f334sm620627qkl.23.2024.02.07.07.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Feb 2024 07:44:54 -0800 (PST)
Date: Wed, 7 Feb 2024 10:44:53 -0500
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] arm: dts: nuvoton: modify npcm8xx reset property
Message-ID: <20240207154453.GA1152441@bill-the-cat>
References: <20240124015451.1780852-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ICQ6F9uGjmZUVhoA"
Content-Disposition: inline
In-Reply-To: <20240124015451.1780852-1-JJLIU0@nuvoton.com>
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


--ICQ6F9uGjmZUVhoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 09:54:51AM +0800, Jim Liu wrote:

> Change reset method from generic to reset driver
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ICQ6F9uGjmZUVhoA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXDpXUACgkQFHw5/5Y0
tyz/zwv/ZeiK3kn9ThFckMEq/2NYrUWRe2AzkspqQXjh5uxawwZqheA7tcXcwxpr
fN/TvsT03QKXsiOamDP+8EyiAORXLnfLRDAGCN1Xj+gsJsFp4inRpPLu1i46c5Cr
MjTrdyTsolLzidmFvtlbNCMUIOKKj/ERaogXhq1Y5kECGTVwithyW+vywq94VAKx
4GzsYC8x4KX14b3wSJm4miKTRzrbX7uuZG95tTqyxIgkB3dJl6Uov1JLGI2URVA2
pQwPvpuZFXqrOtYF9rrgvra1BEH+AHA13Tp3wLPVkWc42oPsI0tUqw/lHVwdP+9V
45Hck3mNcpKdl5PaIed4MXEn1rU/i8UWoLKg/0L3b8NJuTc1ia10Vp1GxoUgRRV+
o5oOq5qXgVyxzEzhc22KCTXoSt8JTSymY5V5kbyqAlTtYHg/8ZHb8cdSuJalvMjg
HeU3zUZvjfuK55tGWtIwA1i1I6uIWU1IlIVaXDlymsG+dW67ExEBhjGWGJjEw6Xt
FA+1rO5q
=KsAf
-----END PGP SIGNATURE-----

--ICQ6F9uGjmZUVhoA--
