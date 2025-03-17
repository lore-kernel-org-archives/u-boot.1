Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14D74C282EC
	for <u-boot@archiver.kernel.org>; Mon, 17 Mar 2025 14:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736AE80F70;
	Mon, 17 Mar 2025 15:32:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jn94v3KI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33467810F4; Mon, 17 Mar 2025 15:32:49 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11EB380F4C
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 15:32:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f754678c29so49831707b3.0
 for <u-boot@lists.denx.de>; Mon, 17 Mar 2025 07:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742221966; x=1742826766; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tTtHcgGp1W16rDkP8ZimM7HPVz3LGHPvMjveYeUvsE0=;
 b=Jn94v3KIitwS0VEcyOSi8aLfZKtQJ/iFK7SQ+8dUnse3b9LQDuiHwKU0TpVTvkudhW
 BIHvjmPLgpWZjq5MhbCdPlIRbhq4wOfIAGPhaU2LhRAJ6ht6zpnXB51EbLhlQf2EvKej
 Qoz6QUQo8J5H5WLqNF0PMLZ6QfkfJtuulDK9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742221966; x=1742826766;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tTtHcgGp1W16rDkP8ZimM7HPVz3LGHPvMjveYeUvsE0=;
 b=Rur22a1w+u8FY3JJU1jG/23Ta/isEN8+CT9oFRkOpxEMDsZg4FPk9bQy2aLso54xFu
 xGgsS9BhT4IPJ/glAYzT2Q03lFvix89a08iw/jTlCqStYKdFgyiPmLQKT1fahPtWgCVW
 VGYR7rQqM44WIX2/FUCjA8LSAQ6QLdZL3ihTspOaG0n+LYc8dlAnN8uo2Nt5rMrY3v04
 jOiT2r/iSLZEXelIdtGEE3ApaT7dReYL8ksqvvMY3A7+fBaqoQzoxPX9B4s28owfXsuF
 9KdeAkeJEEWlVzLc8TAB9c3HlhVEioZJMcZos+B+UQpAmra5KKnOZNn6OhzjZxITZ5wJ
 +bJg==
X-Gm-Message-State: AOJu0YxT9ODQxOES1VAB3nYOEPSUTLNBTqf11GyMwoQeIWUuVvasgO5I
 2w488yGPHalqQq7NBJumWDBeFrEQqnhqczF4ax0JOOgKmhMfTw6q3DE5wEIephwD3iXaYnu6tjF
 p
X-Gm-Gg: ASbGncsVer8S+Aj35+yCT5eufobLecAxx0ng2nB2u69tExPlXuHFTkGSD3gxSoAzzEl
 BXn/5fy81fjXZADiAFuyxKKlmq0YsjabzKt5oNKVq6YT5jbK1C054YtER3KubIprJtaO22KZYRZ
 pVDV1nB/YeW8IPAYu+OnMi/AiB+rzQyDRg/i6YtcPJmqCBiTGd05uEfgOw0QBKzWsfpb19eoPHv
 rMKOwJRcLijNJDFaxnOb6t+7N51bAx6OSXrxKgQwvxBjaBcXMSdl7DpQ0/htM51WuXIMZ6slFQd
 RMqMdlFv+35fezVr3X4yTO7hroMKa8p2UiWViwxZbR1ftQ==
X-Google-Smtp-Source: AGHT+IEq+uqlf16QZ2aRB9XEjEHldJwZujPwNOCo6sna1PytNkETX8+16zmpXHie0u5zrWFs7Q+mbw==
X-Received: by 2002:a05:690c:a98:b0:6ff:1d6f:38af with SMTP id
 00721157ae682-6ff45ef4b98mr143966367b3.4.1742221965866; 
 Mon, 17 Mar 2025 07:32:45 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6ff3286692bsm21852007b3.48.2025.03.17.07.32.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 07:32:45 -0700 (PDT)
Date: Mon, 17 Mar 2025 08:32:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bin Meng <bmeng.cn@gmail.com>
Subject: Re: [PATCH v5 09/46] x86: Drop use of CONFIG_REALMODE_DEBUG
Message-ID: <20250317143243.GQ2640854@bill-the-cat>
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G9mQCIH5yUXcW2cN"
Content-Disposition: inline
In-Reply-To: <20250315142643.2600605-10-sjg@chromium.org>
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


--G9mQCIH5yUXcW2cN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 02:25:29PM +0000, Simon Glass wrote:

> This option is not actually defined in Kconfig anymore. Use a normal
> debug print instead, which has a similar effect.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--G9mQCIH5yUXcW2cN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfYMosACgkQFHw5/5Y0
tyx2swwAn0Kzj7JXo+ekOldaQdj2L7+DU2wc/x+CjyAyrp0byVkUxWmu+0LHAPWP
kOCq27/O8DtXNB6bMU7P9REtFGzvUgKwBWS4gWjveK9fGMYC1JhTAXWRr5lqZQCA
dfdQqG+j8pe5y/qr+KiGZdWt5UKbbMIF3FpyRuZCnWGXCwGgHBQi10sm3fkAvfPn
R4FCYrppSZlbtwdv0Gzz10GqKMHg022Awi5+GwHTcoousICRjNvMns2ebWJdl55M
icaMYJqu02HgHr3CRjnwteUgWXxULpNj530Cnlq8ZNmgk3kUWLRwvDXEX7TrV8Ot
MTemV0kizvpzkfIxP4Nf9f4oOeidci5ztOOnrgPn73+p1dJL8j9R/FCcnhDoCBJM
XeAjlS9xavkPZOUGDMWSLtWWkhY9Hgq8RHUUZiKqQW/nNDcS2N7aBxz6Zh2/ogJw
7yhKXr98DnqNHYZ/v6xvMxMY1xo1HeGam7jpu6tKDpU/XDH3hkQ+DtlTEW7p1MzW
RiohqB1H
=Xyiq
-----END PGP SIGNATURE-----

--G9mQCIH5yUXcW2cN--
