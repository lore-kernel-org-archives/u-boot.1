Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758B1C197A0
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:44:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4747087489;
	Thu, 16 Nov 2023 16:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CvSv+otk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D5BC87465; Thu, 16 Nov 2023 16:44:35 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20C8A874D6
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-41cd97d7272so5485441cf.0
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149464; x=1700754264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DxtzR1ABqlCsIoCk+goc4ozXbH9nt5z8PrUic9G/OaU=;
 b=CvSv+otkZNIVQ4f7MEXK/j/992IMefN4/tJk1Z/VoUCV19sd7CvP6zCHAiEgYLhvaa
 fYmfQovpCzZnpJyY69M+FWwGuAgyGIZcZYbdXCnbAPHBSONPPAdJwypB/6t/RQJkNBW+
 o8B4+FpeTReZKcUHwbnM9rqLDshj+VWBIK37Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149464; x=1700754264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DxtzR1ABqlCsIoCk+goc4ozXbH9nt5z8PrUic9G/OaU=;
 b=dyczqysjb/jhzoZWo5nmvCwZxwK33x1vLb5d25dPmTKrQZbFdGxy13nZGU8ZF9PQJV
 LxpK/ab7smc0BuIDKDI0rkO+2sBwofmFTOrTJIUOOcYOHpn1JZFNFOaVRlmf9853cUi5
 +mk1L0S+Ze4O7ipu/LtR5efjI3S4bGiYcT+bNt8tHirQXpuTIxkTfeVrlFe5zKEjb36Y
 CiSlGEw6J154lRNUZCTVMQIWNNncsEWPQdokpvYU05Oyegxm1RZXc+lBxdx0w7D8DrBL
 9IDIWmPNWIT0WL0hCnIq5RL/gz2N/RzLeuKoBjZDPQOqy6++kY2UtvIOtoUjykx2XU6/
 DLVw==
X-Gm-Message-State: AOJu0YzdYD0TwyvsnPXghHi2A0j2S9Nd8V6m2rdwkVpFSFLnipg4v/iN
 zb+YrXvVnAJHETX0NhHRMJQZgA==
X-Google-Smtp-Source: AGHT+IGDZ4GssNW5xm25bSIYsL1nDC80jyM+sO0f3rlP/lsjB9B2E3oNDi4TSZbAYPP0fWfC5CDpCQ==
X-Received: by 2002:a05:622a:211:b0:41e:5ccd:a7a0 with SMTP id
 b17-20020a05622a021100b0041e5ccda7a0mr11018125qtx.44.1700149461953; 
 Thu, 16 Nov 2023 07:44:21 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 h12-20020ac8568c000000b00421b14f7e7csm4412651qta.48.2023.11.16.07.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:44:21 -0800 (PST)
Date: Thu, 16 Nov 2023 10:44:19 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 17/32] bootm: Move error printing out of
 boot_get_kernel()
Message-ID: <20231116154419.GO6601@bill-the-cat>
References: <20231116041043.362055-1-sjg@chromium.org>
 <20231116041043.362055-18-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="eaAJhYzjH8oPTCAW"
Content-Disposition: inline
In-Reply-To: <20231116041043.362055-18-sjg@chromium.org>
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


--eaAJhYzjH8oPTCAW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 09:10:17PM -0700, Simon Glass wrote:

> The same error message is printed in two places. Move it out to the
> caller so we can avoid passing in the command name. Leave the bootstage
> handling where it is.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--eaAJhYzjH8oPTCAW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWONMACgkQFHw5/5Y0
tyxxTAwAmOw+r53v+eFcjMPwWSF2Y/LWNklsWpnMLo8uD5iPHwKJPGMaD6XB9Pxr
IGHEpm9d3x/SNMb+ipFeZw/ho/gvBtwES51bitmAGbeYz6AGIYbGoSAdYYUEsIdE
p7TFCFWBoUV7isbEiL66uk6PeAn+PB/lT4PnZ5GUE6+dyebYaFgpwP9xNylNIdId
aRHrU1Cjbp7AkHurfLBlhqtG4QLpmAi5QtltIyLchlIGKcnU65NcoWq4PwocmqFh
0qp8XNHds5J/SZ7GnnF3hiYwpycUE7TfOep7QIhNoQJohRan+Zj7IxpXJbtYHefG
GmzdHG9FUZQUoAM7TKbfOVyc1X06PRD6Ijj1+xLDSN+2LnCHix0r8tF8T/Jf5IYG
cFpBmdIJc/sv947bgyEa6ATQv3edCo8YdE1c/M3SLQ9itbqEFRXjgpwqwROpOMaK
636C1Om/6QhRGRTcH4NNoP3PK1eekYAAm0WxM6o5xvKtzkD3fiHhmlsPAkqiU3GW
NQxfkIqv
=cGNV
-----END PGP SIGNATURE-----

--eaAJhYzjH8oPTCAW--
