Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F84AC48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E76DC88021;
	Mon,  4 Mar 2024 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="S2HWfOkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DD1B88021; Mon,  4 Mar 2024 16:29:32 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E54B588186
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7882b1e87c4so29115785a.1
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566169; x=1710170969; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dO0PnsFM6ulZ58WrGQOu4X9jm2ltO1NFsOgHW3EdP0A=;
 b=S2HWfOkwHOrTsnFqYKbC8ONcZ/4a9Iad6hXIImRBS4mOGGAwswyveZ8v2rBeOiEon7
 c+dPxEQ9gHJPMCWGIhe2P5ZYdp3TfkCIlucpQq3T1Ng4PXBdwMfy6lvCcY8IRe41F7XQ
 JajF7AIjyO/QO3ptP5JBMKYsQo2TOhLxcrVTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566169; x=1710170969;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dO0PnsFM6ulZ58WrGQOu4X9jm2ltO1NFsOgHW3EdP0A=;
 b=aRIOwFuJXSSpjvxjtuADEE5ufPbOdvycWfJclIJI3I5N+5EMt9hJiCXg54ywSLUFEa
 BZJtw4xABnu0VWRALuLBqUc1YzvLcMZ8+RWkgUGtv09J47vx3z7f4Kd4/EtmbCR1XDT2
 gJkUWcJtcDgyttzxjnlCWY+ECAT6vd3mjORUiqyZM2Y8ZBCC4MTrJpe7sYBc2WM6C+gF
 VQicm9PBmCMuQMZ1PD8+5ASAgYnv2JcAoUqiK9MOsBn7I01Gq4c726nh8asbiDM501Jr
 XhpqdEwBD04n6QC7AXsIrxWRSEBXJrd+PEfI1oBotUoP4IimNqbA6T3P0vbEkAUEdWML
 x9Ww==
X-Gm-Message-State: AOJu0Yy28Mm5S9UvAVy2FIsmqFnimEE8p6wPWXuqPGE0pP3f/BnjmSfL
 KLYUpTE1K8c79SJVe7+CC/9rfcdOEqlF78HzRG5+FuFTiZ7xIc2jHGXm6+ai1hikCwA8utvuwRw
 I
X-Google-Smtp-Source: AGHT+IH74+jLDT8P9jKRqiE9IqME446jGVOYMeFulqec9Tl72mZtb31cTxaQCeA2nSavgzjDbUougg==
X-Received: by 2002:a05:620a:28d2:b0:788:25d4:6040 with SMTP id
 l18-20020a05620a28d200b0078825d46040mr4555981qkp.63.1709566168814; 
 Mon, 04 Mar 2024 07:29:28 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 cx16-20020a05620a51d000b00787a1c74595sm4410197qkb.105.2024.03.04.07.29.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:29:28 -0800 (PST)
Date: Mon, 4 Mar 2024 10:29:26 -0500
From: Tom Rini <trini@konsulko.com>
To: Masahisa Kojima <kojima.masahisa@socionext.com>
Cc: u-boot@lists.denx.de, Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v2] board: synquacer: developerbox: add myself as
 maintainer
Message-ID: <20240304152926.GN1523872@bill-the-cat>
References: <20240301043840.2310148-1-kojima.masahisa@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1mj7IY6TOZabuRBb"
Content-Disposition: inline
In-Reply-To: <20240301043840.2310148-1-kojima.masahisa@socionext.com>
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


--1mj7IY6TOZabuRBb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 01, 2024 at 01:38:39PM +0900, Masahisa Kojima wrote:

> Add myself as maintainer for SynQuacer Developerbox,
> as I'm currently working on it.
> This commit also removes Jassi from maintainer since he
> no longer has a Developerbox.
>=20
> Cc: Jassi Brar <jassisinghbrar@gmail.com>
> Signed-off-by: Masahisa Kojima <kojima.masahisa@socionext.com>
> Acked-by: Jassi Brar <jaswinder.singh@linaro.org>

Applied to u-boot/next, thanks!

--=20
Tom

--1mj7IY6TOZabuRBb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6NYACgkQFHw5/5Y0
tyzlUgwAqyseUB3+OwVg/uYgDid6DCTs0/bKkGVJdXMczt2nHq2H9ianX9MQmjaC
eO69xq+4dwIDDEueMfbGWSGanU91HIzJQGehqAwDG1XOHaMWaDXpFM6Elqx3eQp6
TOe8etGsk14XOjgqkBd1ErPK1DtfoKyIDPr9SaTfedXq/xr4FhyRRFCg6H5hBkHR
V1jnswXENGNu6QjRmEPWepYVC6ju7+WyG4zpjq3k27aDKq0GCQRsLUlG4MhWe7zi
Scn72w7jINrTHXw+fOPHk36l7olIpvxBr2ZtNJGsOKlt08TKUmlXroGL4TZ64dCF
7CWNgUDrO4BJ1pBRTJKLQWKIgUvawI0wOH116TQb/jIiAOqwQ9Tskzp6rqaHsnpI
VjWxDYZum2XbU2vrFnJpl4/kXqhp/Osk+WPH/+8CyApPb/F2+lpdZ5Vt/r+ifxgo
NuCb7aPmZYDKOMJtMH0R6wR9Ij41O2WdNs6V15xETuR2udMIZpEN9q0zR9xGiHTm
FNCg5Ykn
=NV5+
-----END PGP SIGNATURE-----

--1mj7IY6TOZabuRBb--
