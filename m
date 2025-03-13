Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2180BC35FF3
	for <u-boot@archiver.kernel.org>; Thu, 13 Mar 2025 16:04:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AADA080F9C;
	Thu, 13 Mar 2025 17:04:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WFWyA7xH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B2B080540; Thu, 13 Mar 2025 17:04:15 +0100 (CET)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5BA680F9C
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 17:04:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-47688ae873fso11059231cf.0
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1741881848; x=1742486648; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=N5PYmRmigyNo4oUZn8dRhEODT0IucJnnmsmkXhX5CbQ=;
 b=WFWyA7xHyvt0Y2dqqxJHtb6M5k4H9NhpQ6CIdOpiZUyOLPHgut/8zH7GHbXUg3IhzU
 bLMgwkOAUBmVfn/atfX0yRg4z+YYObFD/esSowNYx3xncGpDq8eJOFKXelcoJELfx4+T
 5mfuIn31kQrRt1RnlnJxZB51mMLurf7KSYSBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741881848; x=1742486648;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N5PYmRmigyNo4oUZn8dRhEODT0IucJnnmsmkXhX5CbQ=;
 b=rI72L6Itayono2e5lG9VAuHZynZYgHjD7FbCkqN5XGqb2i2H1LPd9Qo+KK7aCRzX5b
 nBNQ5D1Uf0WQxBZabwi8XR8ckAAalKjoLKAy9IzhhjlNdg/hbl0VUMt82++zBtWacR/w
 hYGfery3ayfNsnFNu5jUR7UEOteBRFDsj7nPxaDyFQiw/SBpB8KLACgA5dYjNu6Fwmd0
 /+kvVoKsxyvori/fNIkrUIh3S9+tQX9OJaTNSm/LVjoHUkOCwokG8poe+xiOmLHWFkfP
 gfsvEvjDisDu4HcADLY1zmvs9O6hbVWb6zi4QAyqAWc7PSlszXMhEo2n0FiiNsuFo9fE
 Tm2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7SLF2OB2WAno6hk3cUpXzVn+Txw5rTPWe9kp0S6jTq/dDE8qVaaws6yrEDxus2DehycIeIhM=@lists.denx.de
X-Gm-Message-State: AOJu0YxFa33nhWJ475Ku5jmwtbv4qKMaPjjrj4kCBpPnUo1A9V99HZ4C
 /vxaX8vxDZkNtynuwkjzSlvV4y6uciEE3e1SJGRg/PLYDLOCCBUMnQa4Zpb/phU=
X-Gm-Gg: ASbGncv4jVUfTnE/X6+8CRvIxycFLcnUHHIk+KurjN7nAM8WlnJLh3+tWwhQn5WO43e
 TsJTvLuCaxOAiDr5laEIF1Mu+yIVgg1lo/YgDnBtHJAjY105ITyaBjCezN9OiSRmp5guvstPK6y
 BJmsExvyvSFeGwvR1cIX1S4xfRKQPb3Kf+Jo9N624gf4KOokQ5BwAGB3D9LqyxFl4KwmljIivTE
 SsqbfmzmY8uHg1qVRNRXNiAJ8jtxRxXaB0sv8sLXed1eDomSLRwd7U3csi6vzOlUtGoZR2TxTUK
 Wb1J999jJRZA5K+1/cusnJ2q2oYPGCFKK+aR3HLteG528Q==
X-Google-Smtp-Source: AGHT+IH6TzEVa7GBZLnUTVnTs5CkfDAk6lPgUVmZ+I+6W6EC9cq9a8UxVzPk+VLY9NIBRa1T3pcAPw==
X-Received: by 2002:ac8:5955:0:b0:476:91a5:c832 with SMTP id
 d75a77b69052e-47691a5cbb2mr226106741cf.32.1741881847662; 
 Thu, 13 Mar 2025 09:04:07 -0700 (PDT)
Received: from bill-the-cat ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb6610a5sm10709441cf.34.2025.03.13.09.04.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Mar 2025 09:04:06 -0700 (PDT)
Date: Thu, 13 Mar 2025 10:04:03 -0600
From: Tom Rini <trini@konsulko.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Sumit Garg <sumit.garg@linaro.org>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>,
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
 Sebin Francis <sebin.francis@ti.com>,
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>
Subject: Re: [PATCH 02/19] arm: mach-k3: Kconfig: Add symbols for IO+DDR Low
 Power Mode
Message-ID: <20250313160403.GD2640854@bill-the-cat>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
 <20250311-topic-am62-ioddr-v2025-04-rc1-v1-2-666de9c105cb@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0qQFu3l0AUwNePLN"
Content-Disposition: inline
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-2-666de9c105cb@baylibre.com>
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


--0qQFu3l0AUwNePLN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 11:30:41AM +0100, Markus Schneider-Pargmann wrote:
> There is one new symbol to enable support to resume from IO+DDR where
> the SoC is turned off and DDR is in self-refresh.
>=20
> The other symbol is the address of a memory region to be used to store
> meta data. This has to be the same address as is used by the firmware.
>=20
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm/mach-k3/Kconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
> index a3ac490f677429b851b4b4b3d6753ef6997884c9..1e6deb3b9cf1c5a8091a88d8c=
825ebdbb681424a 100644
> --- a/arch/arm/mach-k3/Kconfig
> +++ b/arch/arm/mach-k3/Kconfig
> @@ -150,6 +150,15 @@ config K3_DM_FW
>  	  bootloader, it makes RM and PM services not being available
>  	  during R5 SPL execution time.
> =20
> +config K3_IODDR
> +	bool "Enable IO+DDR Low Power Mode support"
> +	depends on SPL && (SOC_K3_AM62A7 || SOC_K3_AM62P5)
> +	default n

n is already the default, this can be dropped.

--=20
Tom

--0qQFu3l0AUwNePLN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfTAfMACgkQFHw5/5Y0
tyyqiQwAnUpaBpT3kFzKvSiywdCuZwufSzJ73EGiwnVJDPi/8Y/pDQwctZlz8nVl
gMmyoh9K7NFtNo4oMgDp7BDM7p16b+4AqCdcoKrPHgdLjLaMtUjKNK11UWGO/7hw
BmaPt7hAONBQ4ek9kH09fz2/dcPIPTic57Hx4nGUVLB/MW1mLeGbejmgHb3P2mJX
sWhZ6i6+45TYtbayAj40SM1zxFBbyEsJUh8KHT1B0adeI2yTMJ7k6peiXfLEXKAS
g8+re85PbvSRM8IyT9Yykqm7CybFqjwDDS9qUExpr8gVH89ZiMVK4MHlODBnP9C8
DeP7f1tKq5v2Ues0KH5lh1KYLBRFKoJF358WXVasOsP0w5s/3TFWrnGvP3UaKnqv
zvDe5OCh7+OUxGc+yewMpUkz1jn4nNAiXsBZOIWwPp1fRQOtn4Zp/f/Nw+L3fLLe
zEB+jxDy0VnYUUyoKvsqBEDjhx/xGbb7tcKamnejMoKpI5eLbHGzX5ThteIL9iWN
PLPmRl/w
=pHQ0
-----END PGP SIGNATURE-----

--0qQFu3l0AUwNePLN--
