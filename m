Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1C7C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 13:56:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B283883995;
	Fri, 25 Jul 2025 15:56:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tvXWQmn+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52BFB839A9; Fri, 25 Jul 2025 15:56:05 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313AE83987
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 15:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e58d5108dso1332950a34.3
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 06:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753451762; x=1754056562; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gSJBhTj4zkQUqtrhaBBMOA6EaeFM1BKLOoA1/wvWi/A=;
 b=tvXWQmn+XzSg5onPgVKplV3UVBoFtbSAOj0d9CZM5q7dYw32hufO7xQrc5KGHFhEE3
 23q/L5xHaVomNDtMKOwERGMs7N9Vkf3GlHnq+uKG6LoN0DoIkbUNkEphsUih/S+BcjN4
 oqKq555cy48t+NRqnuq2HFrlH0BJE1xHCzGlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753451762; x=1754056562;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gSJBhTj4zkQUqtrhaBBMOA6EaeFM1BKLOoA1/wvWi/A=;
 b=ufFANzP/0d5QQdSyw1OenKjlLvg3BMaQ8/K5cKqJ8Cs0RrVwcKaDaXZG0KhJGqoayM
 PqsugOSsTs1dT+9w8MqwsugCnvLw9EFjv7mOtn02AI61xFFqOPN9gtgaIgqFNsq4J0mj
 TF5WK71/dEYLz3NO7dcIt//PnU3eIB/yCZIiS5r8FXFSEGFcWVzDHi3xEi4SoBFRHOCA
 W8oCE79GacgN58DSeeDdVsi6rW2l17L2ZEadIu6p9+a+8j2AgfazTszY3SS5sLotCxi2
 kcdyxuMkEfLVf02QU9CEdtNZJB/kCujYQYufaSym47RpMKo5uFMlRcTKn634Df01iwF/
 8TjA==
X-Gm-Message-State: AOJu0YzQHc/MZLa7UYQyntRgDWfnJjeB1G/Aw0OSIoVoZWaoJ1WDpHrR
 +9XBYHZXbC5aCcKT7Efu/v4EJ8jrDBKN1vNUmBWGTdAcSuWZWiid1hnRo0g0yrxVQp0=
X-Gm-Gg: ASbGncuP0EMcqXWUnS+ol192baqOvlu/eiCCCJch9tAK8WOaIZzofkuJV+UGNCB3365
 A9BzstiEb2D9F7iZMTWE0c7G908sUL1KXDPZknYvYEcDwuzOGJ1qW983eCPm5iWAZeGpq6HsMzm
 Sm89nJP1DsNVDzKHd7Us5sabral3BzLQ9pWHFtPh+dgyaDUsEUoHqgQx1/YgP3xgJWpfuTS6GLr
 R3dM489vlFcYIMJ5Xvj1gXlCLarScCNYSWHVsSYawmxLNVzu8iUb6Clmt7Kml8Fz72VMuq1NG/6
 J3G4w8YbqLq45T7phXQHQyhbTHLufy8sIT12kO50zOdbOsYOJbjM++jmSjCNLgqsmHSMjNxpgFq
 OuFGpoHamZPqwtOc2sC7SurkntljmUOoGU0R4A9fl0kPaiCvTnNbtWx4M
X-Google-Smtp-Source: AGHT+IFxiBQQIo7kxrPjbo7bQ3Hhhteyvl14le8+DNIxjKrOo3bo+Zkr/LI97+YFLdv2QpSYRI4img==
X-Received: by 2002:a05:6808:6801:b0:421:4d86:67b with SMTP id
 5614622812f47-42bb92476f5mr1170639b6e.26.1753451761886; 
 Fri, 25 Jul 2025 06:56:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-42a3098cdc0sm602028b6e.10.2025.07.25.06.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 06:56:01 -0700 (PDT)
Date: Fri, 25 Jul 2025 07:55:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Message-ID: <20250725135558.GC1807455@bill-the-cat>
References: <cover.1753442748.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8Uy72jVYjYizg3rV"
Content-Disposition: inline
In-Reply-To: <cover.1753442748.git.michal.simek@amd.com>
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


--8Uy72jVYjYizg3rV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 01:25:51PM +0200, Michal Simek wrote:

> Hi,
>=20
> when fpga drivers were enabled via sandbox some coverity issues came and
> make no sense to fix them when there is no user of these drivers that's w=
hy
> it is easier just remove them completely.

Ah, thanks for taking care of these.

--=20
Tom

--8Uy72jVYjYizg3rV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIOM7gAKCRAr4qD1Cr/k
CvQyAPsE7aHB9eNk9iQL0XXIXoDCo8muTTDAeRtAGl/VXrmRzAD/eXD+mAVlH11C
hhNvVlOpsfInL4Zs1vkhJUCcYaQIFQY=
=W057
-----END PGP SIGNATURE-----

--8Uy72jVYjYizg3rV--
