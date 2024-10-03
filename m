Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FAFCF34CA
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 22:25:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E12A88EAB;
	Fri,  4 Oct 2024 00:25:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JvfoukOq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B78B88D75; Fri,  4 Oct 2024 00:25:53 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 067B088FAB
 for <u-boot@lists.denx.de>; Fri,  4 Oct 2024 00:25:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7a99de9beb2so81233285a.3
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 15:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727994349; x=1728599149; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0M0wfzSofNloMyxiVyiFtCLnDUAUTCIumnnTROMiGIw=;
 b=JvfoukOqKXPi7lmLqh/uEXyPEwhthy1fguLjDf3oyg6XNFcddl5sBgb+0+DkRdQRRc
 UGpDVlkMef8sYN+TDr2DfPac9BNo6Nj06FcsGYvtBZrK4I/j6I9J53FSocU1D0jmFhm8
 YcMD1uDOc5Oy8xOhX3Wyk4YU9b7RpRrrvsY90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727994349; x=1728599149;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0M0wfzSofNloMyxiVyiFtCLnDUAUTCIumnnTROMiGIw=;
 b=eMI0noVG9x0ygEdEnQCaAFH0i/twzsjKQTc05yK6d+YgycHuUiu5UXgutTjjcyax/d
 dvQCZ2UrKjY7/tQaGtqswZo9spY+DsmfwBiycZtL1J9x22+lpQpuIUZ0ys5Y8++b/jYQ
 DK76mlK6vQdv3mOMrDjZynlESiCG9FZcidm2tyC5z8MB+hidm12iQ5P3LgHSVSK2nS6d
 hzf4g5o7tPEX54+UzwcGZrrcGdSxWEMHij2MRNDR8mM3+iZgB2JbevVw/OwhNnFLmmwF
 bKnRAONouxoCzYFJPaWRrRtdMxz9OXWEOWMAh6QJ2pEOXyoH6OmgagWRsSVJm0p3jQPh
 FL+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBXQIh4mnAlkIBT0qY02qDKpbwWVpENp1NUh+87R001kzSRmK8OM3HXUhJGPAapawCVNY2X90=@lists.denx.de
X-Gm-Message-State: AOJu0YweHNJKiPg27t2MXJzlb7Bmf9TOnAsahm26seyyto6liVk0/v0Q
 4LUHOiPA9DVVYr2tQLMoYBejrN34/f8kuaA5l9cLlhMCR7CjuSL9DLLhAYPmH0k=
X-Google-Smtp-Source: AGHT+IHIZfiCCcf3+wh2dB6XRNtaTOa6ieEkNHLWtXeZEKbfQxJ/Ub4OL8qTtSl8CWzAk7fWinB/wQ==
X-Received: by 2002:a05:620a:1a1c:b0:7a9:c610:9a0a with SMTP id
 af79cd13be357-7ae6f4adca9mr112082085a.65.1727994348840; 
 Thu, 03 Oct 2024 15:25:48 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7ae6b29f791sm84515785a.14.2024.10.03.15.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 15:25:47 -0700 (PDT)
Date: Thu, 3 Oct 2024 16:25:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Stefan Roese <sr@denx.de>, Wan Yee Lau <wan.yee.lau@intel.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 18/18] rockchip: Provided SPL control over efuse
 presence
Message-ID: <20241003222544.GY4737@bill-the-cat>
References: <20240920072444.134997-1-sjg@chromium.org>
 <20240920072444.134997-19-sjg@chromium.org>
 <538c3d08-4426-4981-bf78-b906a92516e8@kwiboo.se>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ekr7BN6/bQEcd7xP"
Content-Disposition: inline
In-Reply-To: <538c3d08-4426-4981-bf78-b906a92516e8@kwiboo.se>
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


--ekr7BN6/bQEcd7xP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 20, 2024 at 05:08:52PM +0200, Jonas Karlman wrote:
> Hi Simon,
>=20
> On 2024-09-20 09:24, Simon Glass wrote:
> > This driver should not generally be present in SPL, even if misc devices
> > are enabled. Update the Makefile rule accordingly.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >=20
> > (no changes since v1)
> >=20
> >  drivers/misc/Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> > index e53d52c47b3..ff984d7b191 100644
> > --- a/drivers/misc/Makefile
> > +++ b/drivers/misc/Makefile
> > @@ -68,7 +68,7 @@ obj-$(CONFIG_QFW_MMIO) +=3D qfw_mmio.o
> >  obj-$(CONFIG_QFW_SMBIOS) +=3D qfw_smbios.o
> >  obj-$(CONFIG_SANDBOX) +=3D qfw_sandbox.o
> >  endif
> > -obj-$(CONFIG_ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
> > +obj-$(CONFIG_$(SPL_TPL_)ROCKCHIP_EFUSE) +=3D rockchip-efuse.o
> >  obj-$(CONFIG_ROCKCHIP_OTP) +=3D rockchip-otp.o
>=20
> Please also include similar change for ROCKCHIP_OTP, the EFUSE and OTP
> drivers provide same functionality, just for different Rockchip SoCs.

This is reasonable as a clean-up I believe (and possibly post "xPL"
series being merged), to reduce churn.

--=20
Tom

--ekr7BN6/bQEcd7xP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb/GegACgkQFHw5/5Y0
tywhbgv+KNH/kXTqUv7nFeKdQEbQ0jUV4QSvDhXtvibwutVNm9eWNope6ibr4hWS
nmYOFEpdnq+KZAqhRBbcvU0bL+xyKI3QbYWwLje14Zk2MJOb9s5evUTa1LcRlSUP
5ezeRxfDx9Okej7n86v5cdkBIIpIB75KCpAVOOcy3jJ/F1t6QOxYj8FNkuARjX1A
M30GeAnzQh9ZUtFvp+pFuiAfgfTamrkyTWDNkCOaC3oKVwyKA89kx1nddJfUlnbN
zSaGkig2xOusAqrlnl1giE5YdTk41FsDsEs56O4DZz4sxLhxsL14jWSnfieBidPk
Q37DFn0ufJMznGIUrdQWuSIboK0V+GxtjbpFx7lcAINMBfJoKioqC5IHm3Kzfht1
uvoVhGx2FzUBtkzqSHT1oBiUzMe9X3H+5bGxbHmW3S8XrRD2HiNrGKuqF/12v48p
mKRFx628CudwGcL0FYfASxTwhiJXWdp5HI7KWAR3ZFvO/wv0DoseXu6fVKWocRef
NaRp/nX1
=Uonm
-----END PGP SIGNATURE-----

--ekr7BN6/bQEcd7xP--
