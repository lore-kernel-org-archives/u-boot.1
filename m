Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97D4C25B4F
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 14:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1914288080;
	Thu,  9 May 2024 16:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UVKDl3qe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D69D388096; Thu,  9 May 2024 16:53:50 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA97B88076
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 16:53:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c9958a9485so90224b6e.2
 for <u-boot@lists.denx.de>; Thu, 09 May 2024 07:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715266427; x=1715871227; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3WMC2gJUFNmZAQnBc9SoVxpInWEw2e48S3KagRsNXWE=;
 b=UVKDl3qewUL8gT4jj+ZEQY/NTPdEQoXG283SMwdkEAmlO39UDyx+JGRAq1q3u3jyIu
 a071W/grggiK2sFJAzxw6294h+zafaV3O9r4U4hcrOEes5SfJIK3P3l5Jyod4dmu7sbE
 cw/EzEzTgn5wY8br0QSjpTwPt1vfPevm4pZBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715266427; x=1715871227;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3WMC2gJUFNmZAQnBc9SoVxpInWEw2e48S3KagRsNXWE=;
 b=LgiWak/7B9/3WKN2gbLzUPyoX1ChnJYrK5wXt52L3r3ME8n+eEVnmGwVewwd+4fWVN
 X9ybRmLAgQKehBtS/Bgu3WlsgkMPDV/h40i7lXkg10NSQ8WYAJuA/Q+Jq7BQgt7Ko7wM
 wUDnD0PB0ups3cas7HpO8RpiKd6/JJNpP3szODlzX2n8rT/wkB3j8W16d2q3/8lBI10T
 wWbXAyrckZHKxqO39uL7BqWUMSh0hBBEZPFY9WAGONj02E8NjybpOKRzAiFz2kN91QzV
 GuLtYLjlOgttNQrYPslgrZzYFxXoRV1Ev+BB95TxFN59+J4awYb8sPUnq7wyAuepPuTm
 w/Ew==
X-Gm-Message-State: AOJu0Yx355JLqwB00N5CrPIO8oZgIVoxeQxi2OLiEY2wmGURKqLPWsPJ
 R23Og9B3TIFanpcpIstwVsH8aCoVKy7dbTuzP6+bt/eLDOyXVXqHnh2MkoXGvl8=
X-Google-Smtp-Source: AGHT+IFrtA5EeJE41+WaADLYhihOxja5b4zO/oWpTLJXmFXwMljNtagrpA+8JMwuSzRseVPOp46uNA==
X-Received: by 2002:a05:6808:1141:b0:3c7:351f:b3ff with SMTP id
 5614622812f47-3c9852bd7d2mr7068771b6e.14.1715266427455; 
 Thu, 09 May 2024 07:53:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f1ccc6esm7628476d6.103.2024.05.09.07.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 May 2024 07:53:47 -0700 (PDT)
Date: Thu, 9 May 2024 08:53:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 1/4] image: remove redundant hash includes
Message-ID: <20240509145343.GG2568172@bill-the-cat>
References: <20240509143743.1496210-1-raymond.mao@linaro.org>
 <20240509143743.1496210-2-raymond.mao@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dDfZ/PCQSzpeGzTC"
Content-Disposition: inline
In-Reply-To: <20240509143743.1496210-2-raymond.mao@linaro.org>
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


--dDfZ/PCQSzpeGzTC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 09, 2024 at 07:37:38AM -0700, Raymond Mao wrote:

> Remove the redundant includes of u-boot/md5.h, u-boot/sha1.h,
> u-boot/sha256.h and u-boot/sha512.h
>=20
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--dDfZ/PCQSzpeGzTC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY843QACgkQFHw5/5Y0
tyyBwgv+M7/6IxbnzdUTnUQUo+/QuihmlbB1KhW3DkiwYYc8ADtVh9xNFLN/y/Gp
pcihCoA9o9pCk/fF3cKkxkpTnt1i1IiWE6EM2OHbcRUHmOvfa92yZVTIGcDDfagy
OwhNCUns+AB6slaZfb/QFTsvqsRykomH95obD9ETzlL/1jsw6PHOpDDteYuje7AU
DAom5zkeLXWYyd+dm7CHrX+gDLL4sjlxeu2A4WstjbqNs8s26T8+4SmvzyLJk7Ue
v4x9NU1w5Prb2Yvd30DKo2r9stlRe8VVydfUK708eaF/8b2nx7LOAj5HDq3O5uTy
ZfIV6FytV7pQ48LGPHJEUunIXuhfQX2BKGHTDMUuN7E/POY7G5glfI+t7gsP9ZZK
7Xo97MEvZTLDoyGjkC2JCYAE8LLizJ8j+r3tozfq7PgctaYOnxQfQ/LfAgsmtgF3
GG9IhToXho8oBd4uNRUNZATiQgADD+PWMP4TQQ5+Nk4jh9ED4Qygqerr68OjtARW
vLvCWEbG
=Em8m
-----END PGP SIGNATURE-----

--dDfZ/PCQSzpeGzTC--
