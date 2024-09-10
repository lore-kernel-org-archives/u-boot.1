Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8520EDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 17:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E10A5890D6;
	Tue, 10 Sep 2024 19:22:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YmVC7TBo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C513890D5; Tue, 10 Sep 2024 19:22:34 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 48C0188F65
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 19:22:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-457cfc2106aso40214421cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725988951; x=1726593751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ofpJzibaYkYhl/FWhzBaf1pW+cklPdv1YLtYPffpGdc=;
 b=YmVC7TBoOAprELFrd6Z9jdvCHxTBeu33oe3TWnKqyVDT257SVh/J9MevbCC5406Q9x
 Z49u/iSwH2JvDP0yS9ypT7ciJI5obf7FcXlI0Kj9KOPv6M11YrZ777858ObmajQwvL30
 vAw4xtjnTRfdCgWKdfDNrr5pnr09UX7BHGF5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725988951; x=1726593751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofpJzibaYkYhl/FWhzBaf1pW+cklPdv1YLtYPffpGdc=;
 b=B/cBD3uUwUJ8u55dRGXfndudHZfs5sTlsC0FnK35IFawKWDxPO4Irp3zvjkE72pI31
 ++T7WEB+xoizqYGSM02zLnnoq0eCCPsIbtdSvQpiJ1ZMKFScrf3O+wlKiFRpfuMGF6AR
 FDVkrSnOPb8qTwj0/+5I5QLJZGl3B/AXc/DKZbNYxPRzna0hrVmTelDzPo7YujKQdMPc
 FKzcB46vAQiPzT53I9ujfEIFBlCVXUn/5BV4b2xVMMI0rEL9BnhGXBhtZLYweEp+E5TO
 +NG6/QQbgtDvhwRvKQMCpwf9U0+3goSIPuA7Q2a0orNoJWpoBjyPTEDcj+NrWQYkkDN1
 VSfA==
X-Gm-Message-State: AOJu0YwRaFyuQMCmOEvdIWBqOBasA/7UHxjWK8J8wPre8RrDtfujkIUq
 kFzh/AFZseyXVIftH18vsLfoC5/R2QqrVYYIt4dNMMwFY2nO0C6tgdlbrzkRDeA=
X-Google-Smtp-Source: AGHT+IFIr5hL2nzBpVo7oZo7bQmsOC2rE2+F5slgcbVmqf6crD21ZfQqm03iRwTmhnUqdjW23mcvQA==
X-Received: by 2002:a05:6214:5889:b0:6c3:67a9:bc07 with SMTP id
 6a1803df08f44-6c52850d724mr113394386d6.47.1725988951010; 
 Tue, 10 Sep 2024 10:22:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c53434672bsm31925286d6.59.2024.09.10.10.22.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:22:30 -0700 (PDT)
Date: Tue, 10 Sep 2024 11:22:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Marek Vasut <marex@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Jonas Karlman <jonas@kwiboo.se>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v2] spl: ram: hide SPL_RAM_SUPPORT
Message-ID: <20240910172226.GK4252@bill-the-cat>
References: <20240910130019.3211647-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gV1zyub6BVwRSgBO"
Content-Disposition: inline
In-Reply-To: <20240910130019.3211647-1-jerome.forissier@linaro.org>
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


--gV1zyub6BVwRSgBO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 03:00:18PM +0200, Jerome Forissier wrote:

> Make SPL_RAM_SUPPORT a hidden Kconfig symbol, automatically selected
> by SPL_RAM_DEVICE or SPL_DFU. Avoids the situation where SPL_RAM_SUPPORT
> may be enabled without the other two being enabled, which results in the
> following build warning:
>=20
> common/spl/spl_ram.c:19:14: warning: =E2=80=98spl_ram_load_read=E2=80=99 =
defined but not used [-Wunused-function]
>    19 | static ulong spl_ram_load_read(struct spl_load_info *load, ulong =
sector,
>       |              ^~~~~~~~~~~~~~~~~
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--gV1zyub6BVwRSgBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbggFIACgkQFHw5/5Y0
tywTJQwArVUm/V730hcUyfqZGtp4PgUdAdq1hjFiEaH83zf2ML5ZQeSsr4CnmAXm
PDm1Ro+kSOFJxB4Oows/75hIg1N0DzV9qSHHnkWf1y2WDaESb9MsCKKaZ7UkITXV
fgva+dstgBFRd0ruomiO2Onc4qPGL/xRSdDmwvvaLt8U9tNgP4l/S+LrbOMU+tk5
GoWJz7UsmNQk57/3I7ir4/p72Krdrg2OedQJvdhuVHvjbT0e8ykTDQOtIiLyoKoX
N0NZqn2bPY6zZSgf1CTykjbHZSjcraUwH2PdXsMQ48YDBGJBQLhtIuqcRxgRKR0k
biaHxXXE0n+nf1bDgUO8ZImPr0pL+NjEPW+FKEunL0jVKdG3lZjD7rqH62RbVkWK
Y8edz01I7lUNmV0HNkXBU+xpKhCis4Q6QNlSrq+VA6i4nKXvwnfK/iPm6/fooyeD
3tSl9Kt0T/tOHDYJpGVam0jbe1AhYCgMsYZ2Jtl5TfvcU5ZWphR+opeBU/R1zULH
arnB29Do
=+GC5
-----END PGP SIGNATURE-----

--gV1zyub6BVwRSgBO--
