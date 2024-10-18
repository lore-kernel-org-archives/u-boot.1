Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4703D3C53F
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE41891E5;
	Fri, 18 Oct 2024 05:14:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qk6tpc99";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D63C0891E3; Fri, 18 Oct 2024 05:14:54 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59EA38920D
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:14:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7b13fe8f4d0so111510485a.0
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729221291; x=1729826091; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rEcjVNRqAtE83/a4bGuHyDcKif5Q3MytoDPlLZtzj9A=;
 b=Qk6tpc99YAIowZSuAym102ujnv/kfeFw1VjR1WJNzZTPlQGGH3N5mSaGvw/Vrwdfrv
 Wr/vxocgiC9707VEnSowBJUhPuePgA50XBXJjpn6pr9ykKujlJSHVFnjIe6nOFxxJ8F5
 9TVvr3YjqRnILt07TC2ycEX1vKoZMBWU0RNcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729221291; x=1729826091;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rEcjVNRqAtE83/a4bGuHyDcKif5Q3MytoDPlLZtzj9A=;
 b=rs9nJc6CzXDxzSbIu6UQjEs4yBEy7oE4Furd/VfbhY+7zfKDeEB1kdNDgr67yBHJzJ
 H6MfzLf+HNGfdH2oVnjZF0upSls7vbXqsPgT8yGWfLg5CxbC8OTi3uIpV0s3ZoNIghF9
 WNDydubTgfknunBL/C8roerT9fRd0kzAcMsDqLxkVaMDJbiaylXIMxaqFvFjpjS9jMKS
 OrY+bz56mXgcd0Lk4ZU8oR2FPwCGRO6C3ygBc7lQxiBsXf1j5Z3jz2odhdHwDPKxk3Yn
 1lJvZLIg/I7CdmHqKv/5vQkRhYYmcnj0eKPWAnJuxRAMSCuaz9HQNRMbZORy6WHmvBKM
 +LTQ==
X-Gm-Message-State: AOJu0YzSxKVhbCpmNBGZ8BT/qiecfI/O4ztPLzW4TTU2GlWLSX3rn/ff
 d4lNJ8T8w/zpNiN4+nyf2zCZreSx0PTd+cH755Yz9pXq9bv4PVcXZsfTGFunNv0=
X-Google-Smtp-Source: AGHT+IF4CLcEmMIIowuj+Su2r+Ljisb3wFEqn0ieGyDAXVduY9HRtkbUZc3Y1RqzdzTvKwCMg26mpg==
X-Received: by 2002:a05:620a:4095:b0:7b0:6e8:94fd with SMTP id
 af79cd13be357-7b1579ccaccmr119083585a.0.1729221291222; 
 Thu, 17 Oct 2024 20:14:51 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b156fa4368sm31165785a.58.2024.10.17.20.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:14:50 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:14:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 26/34] efi: Simplify reading files by using the common
 function
Message-ID: <20241018031447.GT4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-27-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3iSyRPx5FHiA+gvc"
Content-Disposition: inline
In-Reply-To: <20241017232413.724808-27-sjg@chromium.org>
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


--3iSyRPx5FHiA+gvc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:24:05PM -0600, Simon Glass wrote:

> The efiload_read_file() does similar things to a common function, so
> update it to use that instead.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This is probably the first of a few commits that should read
"bootmeth_efi:" not "efi:" I think.

--=20
Tom

--3iSyRPx5FHiA+gvc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcR0qYACgkQFHw5/5Y0
tywPJQv/WUtqm6Mq49WaujktnPHDy8aKLWRTqQIuWHEkNlWzHaX8velIAwEadDjU
+jC8h+zizFthYbdSaxZTeql63ERWv4zgOnw2+KwC5bkf8S0HGTECY9lOWkrCDoo7
Znp/LHIx9xw7ESbO5k/nRH0zL3mxKM6Qo9JM5jdodloBxbnJ8n6ljXdWB1lViHCN
SSGrsoTNM5K9FYJYbrhlAjlbEooJwSevXez5fsYac9+DhFAk6LM9Ga7cdP8xNm9V
xJo0t3Wamv9RFJ+Jo9vAcUnn0u1MXMP2kEizBVLDFDXUx3xTn2fvj8jkYaR4Eflv
d0qSVYMnurYHBX/NPy+UBy9GrS2PYA55ezF5kH+4jGn2mb2nmr1B6h+Be/VyH+rB
BtcwMtb7OhnGuSvqKwSZiydCwRQMBKe9wc0DQ5kX/l6vMrVwnDAqbCRwUiRmVEgk
atIvhY5A+IEuyJX9oMz+emX1pjYUfEjSRZibTQFRfOegxtxXGJyltUHv9nyogbBi
XIl2hTmf
=EDQw
-----END PGP SIGNATURE-----

--3iSyRPx5FHiA+gvc--
