Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5500BC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA2E87B10;
	Thu, 14 Dec 2023 18:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Qq9YvhrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DD9487B14; Thu, 14 Dec 2023 18:51:27 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 079B787B0E
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5c85e8fdd2dso81691807b3.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576284; x=1703181084; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z6gCcUDZDit+WCuBia/pHbE4S/NiMba5+cgJDEvdBnc=;
 b=Qq9YvhrZ9HL2c8f61JbLrP4V2Xd8U1HtYD3Ardu7vOuntJi8Dnolh8OCMm+823sUW2
 DdgL7KEJ/y8VTLQ15BBOY7iWZgeFyRwKtEbaN3bEd0QU0QsOnTk6/CpZObUGjhvwye9J
 Tr8gIP7JmjXcL0nphN86xX3kna65X15xUbcrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576284; x=1703181084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z6gCcUDZDit+WCuBia/pHbE4S/NiMba5+cgJDEvdBnc=;
 b=qH16yEgmLUL4qO9z6oo8cZv/oXGcIWSzeykuSOOmUFf5rW+wlj8VZELSJmRWRninJ5
 OhunibIb2PLQk49r/kF/Bch0TxZ5+lA8B8ZVqZwLV9jONpVSx75qMH/6n3sqDtmRWlXq
 /96Rd/8ltMjcxWJGGmNs90FDN3xRjsakcnPLonz+KT4LbhWEWOC9/UT7jlIqiAlDQCwn
 H+UeiUXnRqnMetOh7oihPkZPbTYWamXpesn0pyU1YJgUO9RBkdbRneH4Hu3maA7v7iBr
 5EVt2ltaZhBdHoCUbTio1ibW+PShQFF2UDVVuUY8WF6Yv8nOYVwjYbveKTeatet3hY1S
 tLhg==
X-Gm-Message-State: AOJu0Yz0amK0AtYQ6impf0dQyW0+hEbjLCu6U0eHqBzYCUiVQPhApoSo
 QX4HQFDFUXvwpG70awbp53+kxQ==
X-Google-Smtp-Source: AGHT+IFrl8qXtFn97401sWBYcwuH+U4G05YgvgmJfua3HZdwA9RqGHgaF/0qxbEfYN3Vi3tQ6Nk+Jw==
X-Received: by 2002:a81:6dc7:0:b0:5e3:7804:c54d with SMTP id
 i190-20020a816dc7000000b005e37804c54dmr1493068ywc.75.1702576283811; 
 Thu, 14 Dec 2023 09:51:23 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 q64-20020a818043000000b005d76007799bsm5627580ywf.141.2023.12.14.09.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:23 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:21 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 12/21] booti: Avoid use of #ifdef
Message-ID: <20231214175121.GF2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-8-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vs5uZQajJX5TAuk6"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-8-sjg@chromium.org>
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


--vs5uZQajJX5TAuk6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:21AM -0700, Simon Glass wrote:

> Use the compiler to get the set of states, instead of the preprocessor.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vs5uZQajJX5TAuk6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QJkACgkQFHw5/5Y0
tyziBgwArUBqGfX0Wvl2Rp6Y61+6R0CToorf3rqBz2uhX27a6hwZ68/w8NfQ+ksf
eRcbUR7agBqAs0ZGuQ1Fb0XoUK4kGbrMYZG/75VcKBc/nSlJgaxC04Hf7z0d7KJO
dRSFCBRubPXpOimjJCPv9GNlP2UGv6DrCyaYr2hWUbhUtWlsyVh6DaEZBslLuxwX
ZOvWFbDx3E4UkC+eB9ZecQWVYWTlWyjrVi4nB3cWYwvX7kssueFhnyz82DCJZGz6
DMlT6GdpDvqkTSaGgOlZKBqU7q7Eix6PNhQomPcc/n77YzCzHhqVhnEiMSVGy1CX
4EaUKH+L3WFVCryib9MPsTWo6VtkBbpV97LuBn8xgX80QNyAbgG/daWiWeVK/9+Y
KciQNjhBBQjCoMpTgaPqqcmTWdLfZX3YXMahxPFkXjyLsfcuPevhnAYKxGUi593C
gI569zZDe6pra5Z8hO44ytd9vtZEa0sDyfb68Yj96m18NcNE9PrbMDZbYMpJ2vs+
nEvz70JK
=vWtW
-----END PGP SIGNATURE-----

--vs5uZQajJX5TAuk6--
