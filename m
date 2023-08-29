Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAD84C83F12
	for <u-boot@archiver.kernel.org>; Tue, 29 Aug 2023 14:09:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D4438650A;
	Tue, 29 Aug 2023 16:09:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G3OSdtA+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 671178650A; Tue, 29 Aug 2023 16:09:31 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4B9286519
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 16:09:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-58c92a2c52dso51019837b3.2
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693318165; x=1693922965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=waJRNDPLJmyjpd+pAG9iEDwV8JYEzVEB+sL0b2MP38s=;
 b=G3OSdtA+tqKGoJGFGVlePJgUyDLNnXY+bsSHjDj8Nm1NbfiQm9aViKZ4L327tKFDx3
 YmeoJNkv0I0DEW/HZ3CW3AaHS73S9fBEOc2ATZ1cVCl5YKq5AIcglvOx5TsyTXnpqRn6
 tMTAcV0iO8EjHE27lLXKiiteAV/JYuBwchp/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693318165; x=1693922965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=waJRNDPLJmyjpd+pAG9iEDwV8JYEzVEB+sL0b2MP38s=;
 b=FNrEcyuV1IHTUkOpOwTSDxAi1AkE37m++LVBgcT5XOFKEXW2Y8/J/jx6N1jj1r/bug
 QAzONKa4hmSapIefHdSq72SuhFY/pA0NOwXRZx/nEagFEBirx6ZSjhHAlBzejl29XyUV
 HGuHZQa6HySQiH9D4I0Z4YxM8UTVv44LjPk6lAglJ4yaFuNW21dBlLhmW4vaqsXYaLOU
 TsOcWTMAf2Naf1XBKUdwVuhRqWoPry5RezkFk0A1xb1FLsQwpDwOs3SB9u2jkZ9yW2Cq
 aizsy5jX8fy0a6MscPEVH5cpCOLFd99BlsBYtuT9RGBgz5L/89Z9dVPZ7T0g6siHV4pf
 C2+Q==
X-Gm-Message-State: AOJu0Yzvvf3oodrZRAz5Vzh7gjcAP9iiXh33fCrm/nvJ6P37wiqDHlyU
 ZwhBkI6gpgnWtgHy83uOE/dgtA==
X-Google-Smtp-Source: AGHT+IEOd0XrMHICiel5G7GBNSYK+hfQMiyTPvugEOLfnk3lJcgX9dr6va2Kpuh5jC6L52W7PhlgjA==
X-Received: by 2002:a81:bf4b:0:b0:58f:c78e:5918 with SMTP id
 s11-20020a81bf4b000000b0058fc78e5918mr26362921ywk.52.1693318165572; 
 Tue, 29 Aug 2023 07:09:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4165-1a0d-2d73-76fa.res6.spectrum.com.
 [2603:6081:7b00:6400:4165:1a0d:2d73:76fa])
 by smtp.gmail.com with ESMTPSA id
 i195-20020a0ddfcc000000b00577139f85dfsm2733281ywe.22.2023.08.29.07.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 07:09:25 -0700 (PDT)
Date: Tue, 29 Aug 2023 10:09:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Fabio Estevam <festevam@gmail.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Neha Malcom Francis <n-francis@ti.com>, Stefano Babic <sbabic@denx.de>,
 Su Baocheng <baocheng.su@siemens.com>
Subject: Re: [PATCH 1/2] imx: Drop unneeded phandle in FIT template
Message-ID: <20230829140923.GV3953269@bill-the-cat>
References: <20230824011804.1501058-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5gpek0HGeyJjSiBT"
Content-Disposition: inline
In-Reply-To: <20230824011804.1501058-1-sjg@chromium.org>
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


--5gpek0HGeyJjSiBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 07:18:01PM -0600, Simon Glass wrote:

> Adding a phandle to a template node is not allowed, since when the node is
> instantiated multiple times, we end up with duplicate phandles.
>=20
> Drop this invalid constructs.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Acked-by: Tim Harvey <tharvey@gateworks.com>

Applied to u-boot/master, thanks!

--=20
Tom

--5gpek0HGeyJjSiBT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTt/BMACgkQFHw5/5Y0
tyyqPQwAgnwh5YNsBgxZq5LWc5DtLJqPlTvSdh37pmPM8YzKUVi0QCVK0YPml7gM
3eZHFAetnFhsW+/BUzq+vc/VmtZ8upJH/oHA+kUOrYOixNGKEDjawvXYG4ujAoyT
fA2dK5+/V+pKqdqN6GfAWa33bv3qtTJg0VK0iqGcNr82gPqGfRPxH82loFBH85EI
4unrevpEDdPNBxTD+euYpSpGZ/W4iCiP5SuA325MnA/VoJeVdUYekz6sGlowU2kt
MTNwfP1preU1eGlcxW+XMiVeD7V+DsR0uabe/M9iWfgyw9XfqKxJRsTQ7wJppgRJ
HKypScJGAl7tPn6OxgIVy9iITmgIv167/VrszBKxA2Zegmv5EhhkZ5sPPJeyUKwP
jKwj4fls3LnlTu5oGSfXQQJgd/7JZhzpYf1VLZzKP69+Z1CYTvzDlhQcidmwgRMa
PDFUthO2QcqAv7SlIMEPRuzBT2y1ei49dpKlxw75A1ICkKLdGU0Dd5pn5RdXUpip
0GrOu2Wk
=jy1Z
-----END PGP SIGNATURE-----

--5gpek0HGeyJjSiBT--
