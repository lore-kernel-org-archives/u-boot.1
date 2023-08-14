Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17DF5C001B0
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 15:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E5886679;
	Mon, 14 Aug 2023 17:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HQGgvsRy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01C9B86722; Mon, 14 Aug 2023 17:04:05 +0200 (CEST)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9881865B6
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 17:04:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-1a1fa977667so3470561fac.1
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 08:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692025441; x=1692630241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NnntECuOCqFBd4hdCfgdv3mP03EPtHJdev2d4ca9ufQ=;
 b=HQGgvsRydITYvHRO5gxv8MFgXQayu9G6ob0oA7CYYKmWTs1mXfCilTnUmknQ11yHQ6
 9bPWFD9Slu3JSPrClhRuu07Mbnspr/YaCstsPtP76VEOEjo+/hrmR6LTLQkcnotfnb2L
 NlJCoyt91eGf17rgVkRMVrMVVvt0vOzmLVvFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025441; x=1692630241;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NnntECuOCqFBd4hdCfgdv3mP03EPtHJdev2d4ca9ufQ=;
 b=PO/N4t40C3HJ9xLD2muQcbIA1YVNrTWVj3AGOpRCvZEDyyOpKpAmnA/T/JiNpq6DFI
 Ztu/DAj2eW9eLaUyE8I5qk268Vftc33IHqKjv8AreghKVE7FuOzLM4oeIc/zKw/GSIxx
 JG33JhreXxBjtDyuLoBwhGN7DBmKCdgNTRaQCPAS8rs5UWFhoGs/e/+aNXDg3atQkQ4/
 sJpE2KZWuPTA+oeo2qW5cV/6IaOTOH7O1XmWrU+B4qy1vAbFRAgjB8+PaJs86A/5Rup5
 vODfS3ujThhSvbAZZTkGHSl2b1G8uouPX9LfjhYLgYebtVQdQ5/Npk4gnnaPrwORjZI5
 xJBw==
X-Gm-Message-State: AOJu0YzFzUVTEUpoDBVYOaSii4h5hobAL8gOENWi+KMQdM+QLemcuyjo
 T4ZxmM2O1QVkDLzHLkQ1bMrDBg==
X-Google-Smtp-Source: AGHT+IGhPgjWg5I+nX4aPsZ3Kitqkc3b3l8lT/u90Fky6WGTfUCvdFhDY3HF6yKe45BAA65ufYJKVA==
X-Received: by 2002:a05:6870:b526:b0:1b3:cb1f:cd1f with SMTP id
 v38-20020a056870b52600b001b3cb1fcd1fmr11984105oap.0.1692025441573; 
 Mon, 14 Aug 2023 08:04:01 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1d1b-2873-dbaa-7ea0.res6.spectrum.com.
 [2603:6081:7b00:6400:1d1b:2873:dbaa:7ea0])
 by smtp.gmail.com with ESMTPSA id
 o69-20020a0dcc48000000b00586a74620f9sm2823274ywd.41.2023.08.14.08.03.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 08:04:00 -0700 (PDT)
Date: Mon, 14 Aug 2023 11:03:58 -0400
From: Tom Rini <trini@konsulko.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, sjg@chromium.org,
 u-boot@lists.denx.de, r-gunasekaran@ti.com
Subject: Re: [PATCH v2 1/2] net: Fix the displayed value of bytes transferred
Message-ID: <20230814150358.GR3630934@bill-the-cat>
References: <20230814045348.49105-1-s-vadapalli@ti.com>
 <20230814045348.49105-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f5KRECQ4d60EhNFT"
Content-Disposition: inline
In-Reply-To: <20230814045348.49105-2-s-vadapalli@ti.com>
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


--f5KRECQ4d60EhNFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 10:23:47AM +0530, Siddharth Vadapalli wrote:

> In the case of NETLOOP_SUCCESS, the decimal value of the u32 variable
> "net_boot_file_size" is printed using "%d", resulting in negative values
> being reported for large file sizes. Fix this by using "%u" to print the
> decimal value corresponding to the bytes transferred.
>=20
> Fixes: 1411157d8578 ("net: cosmetic: Fixup var names related to boot file=
")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--f5KRECQ4d60EhNFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTaQlgACgkQFHw5/5Y0
tyyz1Av+LOSC33s2Gw0s/b5CqEr6r3pNHRBB4tLwrX7TyKK2Phi8jl1D+z5igc1t
VxxNNAwTZajDoF7KHJZt9oO7Vn8w5wO4Hnv+gH9PXUteWuBqLDDIyaQEplX7J7iY
GX4DlNeJr9GegBxS1mXIlZtPstS/doRXSde6+dl2fvjNQZ9WxmKx7NItJiHEzpcU
hYKxXCgv5b1anLnhm6R3qtaGFoqww+RAm5eDNsKe2FnKLZOIRooxiCYvJ/Ps5CKY
uq5CVb2HE5N6mmgkV9aJ71l9wizaX6uhszXs3MWzfu+VX9uaEkMIvyaifvyPVug9
FzCexrqqg3wdmLjfXQxDNsyxuXL0ujAg/WRDOT0tH452FS8Yext+gJi/EBTcHf/X
Ba8PZl5cvwhuq2Rhr4p+xVw+z09GCQMZyhEfGtEis9mZkyQvJXseYj9XVfiU0DaX
Oj6JK0XKnVlihuorVBqurRXFnlinaYVva/QlFNRfNvUNU9f1vRCLHKLCFlVGRaPo
IRk/+TJ2
=mDO5
-----END PGP SIGNATURE-----

--f5KRECQ4d60EhNFT--
