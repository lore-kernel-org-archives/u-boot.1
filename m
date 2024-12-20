Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669F4E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:45:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E46C780352;
	Fri, 20 Dec 2024 15:45:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ddwzXlEF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 473838036F; Fri, 20 Dec 2024 15:45:24 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24A8C80243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:45:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d8f65ef5abso15588936d6.3
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734705921; x=1735310721; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IQUK28hQSCS/LuoAVK1mIXv+pQn4yMxRTcJz+K580kI=;
 b=ddwzXlEF59SZVGTaBp6i5S8B95rYF83UrCUDW6WaMQY7RS4osBon+LSzTCi4/68Rwc
 uM0Q275g3vIW/0YtamoMxofCpLmAZSib0XRVwCMO8LSPp8mOQrjFoS0/ZRjRzP++O8/D
 eGCl67zUQdO/IjemHpgY7efmvX14P310uRnIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734705921; x=1735310721;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IQUK28hQSCS/LuoAVK1mIXv+pQn4yMxRTcJz+K580kI=;
 b=g7aoJ+kKdTbjp5SYvIH5YyyqDc1LOY2bpdT5IsEZTcAWQu/lqKFk9T0EnAK7H45l9A
 qO1AhC9Rc/UoC4nDSMF1ARPIbk+/6pfoRA04Zmw522RXNHe/kMxphkWcP76NjglSmbpj
 Sj5+wHpFR1Kkn9KdrB2qYFkrh/MSI3eqeZR3WtZox4uNwEa9+je71ZP0kUskXp2xv9kk
 oCpYjPI1m8ghj/537WkoKI+q00v42XxUEYsGEJ6sakg55bsKloGyi0WphBX6XxF3vRxP
 J6slGSu5bAqgnUskh72+Qv3yb2igU5c4QWgIVBFwahllT1aKSDbnILrAnJ1HmkZ+pHSi
 vlTA==
X-Gm-Message-State: AOJu0YxkuySy/AsjZhWXKJE1aulVfz+HocneaUhCfvjqlYwYYnzy67W3
 c0xUAZoR2TMvb0ZH7bmlR32GE9H/FYbX5N8kZGL2cDpez34es05AB3eO5hUHnoZJh/h6FX3OGkY
 LzQE=
X-Gm-Gg: ASbGncvPLhM/AvL+e2Wby9UyeHa96xKgEbOHP053a5Uh9/8fqNsosxVaDS8Luts9LIh
 FfPQRD5LMd+3L3VhQydJc8nOhrmrtguff7f6M5SxXT1cISuudV2GAglALXmW2Jcn6YMhKU72wFk
 KL1i6q3xl0YwkbJEFCYSIlUpYmVa972URdQANYzmWOUZ6h5ksNyg/oUB0C6x1GY+hFMCV5yJGi1
 XDak/+lHQhHw7y9EsRuNEA8/adsf9KOYF+fjQIFmszapQzMdGkcrCUL
X-Google-Smtp-Source: AGHT+IF7T6bOAhZIKjjRzei6JexirpdfViini9pmEsFdDAqcFIACVc1/zHWcmt+bHEUKCV4b2HC06A==
X-Received: by 2002:a05:6214:460d:b0:6d8:7fe2:8b31 with SMTP id
 6a1803df08f44-6dd23357023mr55142576d6.23.1734705921004; 
 Fri, 20 Dec 2024 06:45:21 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd180ea762sm17523986d6.15.2024.12.20.06.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:45:20 -0800 (PST)
Date: Fri, 20 Dec 2024 08:45:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
Message-ID: <20241220144517.GC1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PeD0GLHSyZ6Hj9ax"
Content-Disposition: inline
In-Reply-To: <20241220040120.3245610-4-sjg@chromium.org>
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


--PeD0GLHSyZ6Hj9ax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 09:01:18PM -0700, Simon Glass wrote:

> The devicetree file may not be provided, so avoid a failure in that
> case.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PeD0GLHSyZ6Hj9ax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlgv0ACgkQFHw5/5Y0
tyx6SAv+J04SilXrmacVz1rukTayr0U9fZBtYjS6LFHdITHb9mQX7eZIKoboOzOq
XBsr9F+/FSFwYzYjitV/VnM1i7uc7izjZkn14e2fq5ta7HVWK7rYAL9em6+pmvIs
RoseATyKW9187elE3ul9125UHMLdmbRbftTaK09BCU4z2eyLLCc3q0Dsup247NJj
hhabyelyTvlX7Q+iXK96E86YmhmgmGa59emWkZJD3LWnG9yvTk85rtcK9OFnGQFR
C9Owbj93vPBlzqLt5kr2vOsHjqyRBONJBlOA4APS7sb1Osed9rR2Ogq2fGSDjgWe
nIRnGx1rzTie4ZvFIBEVoMOIAj4mvrm2+18K+/ptuaAdfsV36/NOzs9gddyUwhnw
gvAKCQZ066CbhqVBI3LL1YSAsGxrsl1qxhI8UjA8h18KtlOeBoIIROKPMoHfd02F
6lbH9YENkBGbC6YKcGCL28ITN9JgQowBX/DuzwN7kWRAKltthglCi3SyQSvp6nf+
H3i+GmDF
=vSnx
-----END PGP SIGNATURE-----

--PeD0GLHSyZ6Hj9ax--
