Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACFA0C636E5
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 16:54:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21120889A7;
	Wed, 28 Aug 2024 18:54:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IdUw/CJr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DED988916; Wed, 28 Aug 2024 18:54:54 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9449588703
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 18:54:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a1df0a93eeso409368985a.1
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 09:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724864091; x=1725468891; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=apv+cEQsk6Pv1uD+fBliTH7aw9v4GssJE3SyWlNivb8=;
 b=IdUw/CJrOse96bpX6PnKRW4Ry+Y5mqqiFbBESpC8JOD+iiSxGKDLhfXE3us2F+gVPU
 hGl2m4XzF7rnnJOCxD7O4maSQQ4+6WeHAkn8qEKOOfKcAI5nP4ikXa9X3FEFxTA5MseX
 ZLsBkXc/GsThXiFodyLAo0DL7lvorP86XBYvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724864091; x=1725468891;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=apv+cEQsk6Pv1uD+fBliTH7aw9v4GssJE3SyWlNivb8=;
 b=In7HVVb0KkGVQ5y3nakRPNYgRjzSu/b0TDJsikSEGDnpASkRavf31pjbFfsVVsORc9
 wATn/+Rl/uw/ByTcfwKCo2GXeQkIY8JNCyrSng2bBCLMXB5DkckYFAPJdntHYYhBzGPh
 vwgBjYcUgNRb6xflBPrnw7ARAO338a8+oZQTHbbpEv1KJBP64zdwGJSbAJZ+ZCE705Go
 rnEcvud5LlJSu6nmpu+Z8BdzIyw3MTXE57t8+57ohmfpCQKpeUxoqY+eMFAJH2EBsr5p
 +CYXtUbUKjqjhTUMbgkpk6k7xQ5wEDGRFnPNVtcEtZmn5RsSxUHPhHpqhsn6gT2YwI9C
 iq0g==
X-Gm-Message-State: AOJu0YxDSyGMmrTF3vOIh89HbjulIs9npNVtodowQGpdBNl9xpzb6Yf4
 KGGqJwYagaT2PO+Kx5EK/4hygnIfnd23MDhyBILDG93Bm8o4btdZKUnvsr8QgJHJLBK2xSDkqBm
 E8IxHVg==
X-Google-Smtp-Source: AGHT+IGQzvLKZH6mn6xyS6mYNFjszeRIqu21EzXtn++g070whMll4FSdK3HCIGK4J6iLcu91UI3sBg==
X-Received: by 2002:a05:620a:4452:b0:79f:190a:8ad7 with SMTP id
 af79cd13be357-7a7f4c940f7mr299199285a.33.1724864091273; 
 Wed, 28 Aug 2024 09:54:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a7ef227da6sm122558485a.90.2024.08.28.09.54.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Aug 2024 09:54:50 -0700 (PDT)
Date: Wed, 28 Aug 2024 10:54:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v4 1/3] Create a common file for test
 scripts
Message-ID: <20240828165448.GS2479150@bill-the-cat>
References: <20240828164523.125770-1-sjg@chromium.org>
 <20240828164523.125770-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3oYI6ghwLgPGrBWo"
Content-Disposition: inline
In-Reply-To: <20240828164523.125770-2-sjg@chromium.org>
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


--3oYI6ghwLgPGrBWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 10:45:21AM -0600, Simon Glass wrote:

> The top part of each of the u-boot-test-* files is common. Put it in
> a common script file to avoid duplication and to allow it to be
> replaced for the Labgrid integration.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--3oYI6ghwLgPGrBWo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbPVlgACgkQFHw5/5Y0
tywehQwArz8o7O1GWquDv0v5pDyDqpIYS2wU1Lub/yB1/vuxsKxyqeDVoKUT0Gm/
D+SDH1GGrE68x3AV1Xthsw59eSkb0R8a0Q/IjXX99XYr7CmTkQzIW0iKYqANnzkx
HtXmX9l5ynIf1PP/+fks7vmjKJ2YVeXJh6miC6WgdYfXpXhAl0jRX5dZJEhVOaME
Mt+otREPnyg09MRkDwu1ncye58JF0nCVm3X0NWBFEZANV2e2tQPFgBrQKYt3UN12
N7QwvfPnwDXY6E4TDz+D+fS03YfEEhDq7pLNgYh/DcWrBUYR9yrW9hApehnJeL5C
y/I4MYmiuqJsIY6Bmb0LR6xlQ4TAP9/ANrEjtB2hEhxkhkQh17xRTrNTaPHJmXgQ
qoMtr3ULZ281xiuT1Dvqe8MN1XU+FNXB85Sp5lmy42cVRRyroMsLnEHzLxE7yuNh
F7ZwN0EgvTrV0uOp6vG6XRzpQdP0gdDhwrYn4DyZ7re7qeOYYITDL7WbanPeAYi4
Yhc7NBMI
=xfSD
-----END PGP SIGNATURE-----

--3oYI6ghwLgPGrBWo--
