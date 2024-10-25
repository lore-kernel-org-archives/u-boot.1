Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B1FD0C614
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 14:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8517D88FC5;
	Fri, 25 Oct 2024 16:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P131+jqU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4344D88FC8; Fri, 25 Oct 2024 16:13:33 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 301F188C3D
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 16:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-460c2418e37so13635021cf.0
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 07:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729865603; x=1730470403; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NNcMYVGbsYSPVU7t+saj9LkNYEzvrutiarLDprjvUYQ=;
 b=P131+jqUxlDWJ7d7yojPmsXjWbTlvNxWU36ue0DVXbdglOwy4n/hvs7EPBGFniDEsp
 SSTCj9EOTULFe5l7p17ebc32tFNVRyb0Nh0NzX73H6i2thNmwaUi+RJcCODH/Rqp7rj3
 bbKUdbP3EWgIbRuhkbyNER7SP+IexF8uaH70I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729865603; x=1730470403;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NNcMYVGbsYSPVU7t+saj9LkNYEzvrutiarLDprjvUYQ=;
 b=r5ZHC7EwQc4W7lu4K/+7mklORGZQIKROyUgbLtgZOJ6aEFnQC7js5r0OYgRpz/blID
 KJr5M40yM1vn3+QmJH1FU6pfLTfOjXdiZKXB2iflM3kGkWw4tcRvzfEwc81+qWIu/0mk
 s5vURQNa5HXXlaj5T5Q+vJwtKaILfa/0bBLjNZdgvMMFGx/csHbiaXiCDU5ZKe6pR86X
 ydiJmMwaKnsc4CYis/amX1SIR7wBuZepy4J/lb5GooxIRn0m/yIZtN1/y2HTjGh7ggyo
 oBvhK0Gc7y0Z9afERjdICo9rDQhCAWUYWTZry/Rfqew7WGD1GEjxgGM7gSppOIt7YoSX
 8Stg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhB9BpxlzFPFvtFvMExAnycErE4Md5/3Kz6NguCkN6ITeKBA5BnHHDyGwILPWjDQxujYDf/FM=@lists.denx.de
X-Gm-Message-State: AOJu0YzmlNXU5OgALb0OagsiErmt0JteC5F+DsBWAEScn721h6tXDe89
 5dIkFqam9FFB0RkRNx4Az674to2kSpTZ9YWaH2W8GuEAT3wbNeyMWWyCfEghL/4=
X-Google-Smtp-Source: AGHT+IEKQaKcej7P+ZZAHyBpLNNrQmn7yzK8gmHUwV4kzJY2cNM/LhbqZmHhpUVEpZfKV5GE2tiMEg==
X-Received: by 2002:ac8:5789:0:b0:461:1c54:5bcd with SMTP id
 d75a77b69052e-4611c546a48mr103153171cf.13.1729865601507; 
 Fri, 25 Oct 2024 07:13:21 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46132142c4asm6351851cf.32.2024.10.25.07.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Oct 2024 07:13:20 -0700 (PDT)
Date: Fri, 25 Oct 2024 08:13:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>,
 u-boot@lists.denx.de, sjg@chromium.org, philipp.tomsich@vrull.eu
Subject: Re: [PATCH v3 1/4] debug_uart: Replace debug functions with dummies
 if CONFIG_DEBUG_UART is not set
Message-ID: <20241025141317.GY4959@bill-the-cat>
References: <20240918130155.299353-1-lukasz.czechowski@thaumatec.com>
 <20240918130155.299353-2-lukasz.czechowski@thaumatec.com>
 <22ae3879-e266-440c-8f25-2d46a5676261@rock-chips.com>
 <c72f7799-5748-4602-bfb2-c99ba767a614@cherry.de>
 <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MODP8duxw+AzTBDl"
Content-Disposition: inline
In-Reply-To: <076ad029-7788-4f2f-b3fe-58e61fa8cf51@rock-chips.com>
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


--MODP8duxw+AzTBDl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 08:30:44PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> =A0=A0=A0 This is regression of "#ifdef CONFIG", is it possible for us to=
 go back
> to use "#ifdef CONFIG" in this case?

Yes, that's fine, thanks.

--=20
Tom

--MODP8duxw+AzTBDl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcbp3kACgkQFHw5/5Y0
tyzcgQv9FFCwK2GvpMMSFspzuoyCpQVKQPGUdtQYHcyIHi2U6LYf3Ox4oWLXwBaC
99Ba4NZGwulHENmNkFMkL/h8DZShhBRrLoSViaPmM833lKIkX2C830R7fltxyHLi
N+RU0HdjIqrmxldANkWcpFOAcBjlbC9EDDnc6vAdnVDXsXa8Ek1lk623odCi4lmc
8ho8gBs1Y2SG19K3sRfYNyIGbIJi0osC5NEPWHKlyc5O/KCUxxkpFwHevCRjQfQR
5IZrOP0xBVR0dw/Iw5dsios1fGcUtjecPtQRKczn6a+aM5Az/iDPP3VHEbW7l22N
Z+HbEQRadNOBj9utNymMSMG3b8fmLedEjtMEkag+FGdgHJzX1MTKwJTocsqFOfpO
ris6IjPbckoLvSmOwbs8KiaaWJBWXWrC5m0XqsOE6CSuo2uO9TZwFnW4ludxxCoh
UVhz/XzZ+CH/pFoTDjbG+B/XoF1aN9+Ab2xYbwiqEg7cZMqhBUZsjecGJPFCBJry
uhFo5oXG
=o1ZD
-----END PGP SIGNATURE-----

--MODP8duxw+AzTBDl--
