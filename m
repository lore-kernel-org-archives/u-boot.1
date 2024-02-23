Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEBEC54798
	for <u-boot@archiver.kernel.org>; Fri, 23 Feb 2024 20:48:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4779C87DEF;
	Fri, 23 Feb 2024 21:39:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ft5vSDqo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DFE87C62; Fri, 23 Feb 2024 21:38:41 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFA3387CF8
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 21:38:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-608c73f03a9so7104267b3.0
 for <u-boot@lists.denx.de>; Fri, 23 Feb 2024 12:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1708720697; x=1709325497; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PPxNm/7SowT4kJZv8MU/HC4kaBmSMctudubkf9sJy4g=;
 b=Ft5vSDqoA1Y6NN7h40SGdctaecK64rvNK1E+Xj8jIrSp6JC35taMd5FkM5xL+WW0jz
 Y2DWFJ+NJeMQfHo30eKzIOlB/VuH58+ZMmNGV+hFk0ZIkxTnr0touCKC3izMMUB/in95
 h9NJJpDwE4fWUf4ltzq5dRFhJZM11jVc8ke3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708720697; x=1709325497;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PPxNm/7SowT4kJZv8MU/HC4kaBmSMctudubkf9sJy4g=;
 b=NgfXQYuFnn8xyssbrOXF36D1rFdyB0ECqBfilT9vcSmEzynRu2z+iCejcipqmW5oZ8
 mXtxLHyVBCYCj0wjhucd36SelFFtAwMqtlBptsnWjTLE1s+bNuPwK45gYhuK2Vg+rmtN
 t5Wf2M8rehcZQGro6pAjne5ekkF+9WY6ldW0R+62HaUUYiIg3sX89x/FZoa4kNmi0UZO
 vRd3sWx88ki5PM+Z+qgrcFxqJ4MHNszY5hk/eenrW+Dck7Er2xBi5YQL8oJU/x8BZHgD
 rZkjgW0jcOEmzAjPp3FwQitqAYRAjpVrl10mk1axezGTna71UeLREptxY/0fRRhI1Pyt
 RSCQ==
X-Gm-Message-State: AOJu0Yxrm321ky0373EnTrHzTC9zXCZJOXI/djnigAr7F5uHvsci+0PD
 zkYSCvfxSaUxiWbg7Bpbc5cs7A2ygATp5AozpK4KohbRUcCTIESfLsp/koaScXD2bvM/xzaZ0tl
 C
X-Google-Smtp-Source: AGHT+IEo3doe6W5nkWFTQ7qXMiAqP9LtFJZMuVjhV85ZlqJQ7zgXlyZ+AEYTD8/SGQfyKMvV7lfMdA==
X-Received: by 2002:a81:ca4b:0:b0:608:cda9:b735 with SMTP id
 y11-20020a81ca4b000000b00608cda9b735mr731253ywk.39.1708720697434; 
 Fri, 23 Feb 2024 12:38:17 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 k7-20020a816f07000000b00608ba371690sm436044ywc.94.2024.02.23.12.38.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 12:38:17 -0800 (PST)
Date: Fri, 23 Feb 2024 15:38:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Ivan Orlov <ivan.orlov@codethink.co.uk>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v2] cmd: eeprom: Fix config dependency
Message-ID: <20240223203814.GB3040305@bill-the-cat>
References: <20240223171420.9492-1-ivan.orlov@codethink.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JJmF6AxyZgqOpnYb"
Content-Disposition: inline
In-Reply-To: <20240223171420.9492-1-ivan.orlov@codethink.co.uk>
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


--JJmF6AxyZgqOpnYb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 05:14:20PM +0000, Ivan Orlov wrote:

> We should have CONFIG_DM_I2C or CONFIG_SYS_I2C_LEGACY enabled in
> order for `cmd/eeprom.c` to compile as it depends on the i2c functions
> which are not compiled otherwise. Update the Kconfig entry for the
> 'eeprom' command correspondingly.
>=20
> Signed-off-by: Ivan Orlov <ivan.orlov@codethink.co.uk>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--JJmF6AxyZgqOpnYb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXZAjYACgkQFHw5/5Y0
tyyl4AwAtdkA5FOUOD8l4Q+ryapH9h1hfDJTgptt8oGL/S+baVrdwODJd2C2LOyL
wJydd4CNc9/uJEonyGL/GwbE0cOjupcQENw+IDcXsWEUkLSM3L7PS77qXW4tvNVQ
87dW4De7wVU7NQ4YJm04rnB5pPN3IltTKlai4N79bqEnQsfqRqDffhzrZYdUp1w0
te+dt8ZM3KwG5XEhJA08BZUAwDMWBpG4/429f3e2nB2NPxYE8Z5BfPxf0HFpNA/Z
QNtCPJrLKA9uNmpBcg9jr6IbZN+vRgr7y5BmPIrxKjqFBRHOdX6esRC7S7G1aJ4C
fedCNxymYlfOro2lgoFDTIBqglMeK3QiMZ0XqvsjhW8+/W/zA/PK745RRq935SZN
GGE9sgJR8wys1EbiBBTwOMeuyOQDbTfTOeVLTN2c01MMkbAP+VklL7oUcrqzqOx2
BS0yeWrKDsUX6MPe6z0zjcW1ZWDUd+AJimppJ53i+OjwBQ/X3Wbga85rzUqWK65D
vndvA82Y
=q5j8
-----END PGP SIGNATURE-----

--JJmF6AxyZgqOpnYb--
