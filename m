Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DF92C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5D5487230;
	Wed, 15 Nov 2023 23:36:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BkzDzh0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AF4A8722C; Wed, 15 Nov 2023 23:36:34 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A708721D
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-41cba6e8e65so1160381cf.2
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087791; x=1700692591; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ejW1H42bqLMbY8GBG1Vv68F4VV2cvPE+HP2Aom0UGxM=;
 b=BkzDzh0u1LgZb7dPDQQjrV5SZjVU4AVjUpn2Mtpp0ArtiT2PyVISlR5cVi/EWDqMqj
 D+WlbpwhEUZtQg3q7XsGC93jK4dR4VKc6ZUDdh+U3YJiSD1GN3NJcH3ILSDd5p0xht8B
 OEa6pH79KRm/vvYeksBkYSDNsQ66VwORkH2Iw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087791; x=1700692591;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ejW1H42bqLMbY8GBG1Vv68F4VV2cvPE+HP2Aom0UGxM=;
 b=JYSk0EnCnqC33YKceADySZYmnjgiy798cRK6BUUeVUVHcvTYVIDOwngnsVpifiZkdR
 P1EkyepEe7lWrBxeT81gYSSEhXBQUJ2O6QPmcfr3eau/sPJXeRCGKrONKL8AC4drtOaL
 kgXC7TfEetVmHs0J87rAcDuE7oqK7b2cHA0BEJHHkBNClUIeHIlQuyOLFjlD83A2yaJC
 ynNwmpI4VZbz1iGTsNhxivJJNVYeSYcSqiRmbKmh1I3vw9x4CE6EdNJe01do47/O0S0f
 nEAJImxV7LJfDce7+gwi4BlOqSIqIOwjpaLHz/5kRgXN/jEG2sIXsrkwi0P1HI17BfKN
 oTwQ==
X-Gm-Message-State: AOJu0YxH+gdwp9/nfIxqafjeCEu44abx1qqsEq9vIQ7On/CBRq7bvPdK
 j5RFpyInPP3Fgvi49GRr31SXWw==
X-Google-Smtp-Source: AGHT+IHUxc/cpvRbhs5BMPNvCYdydUeu1+ovluiGVjSq9l9VU2kl4GPQ9fDVA9NYqA6fG//yoPk7XQ==
X-Received: by 2002:ad4:470b:0:b0:672:4e8c:9aa5 with SMTP id
 qb11-20020ad4470b000000b006724e8c9aa5mr7213676qvb.47.1700087791086; 
 Wed, 15 Nov 2023 14:36:31 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 o6-20020ad443c6000000b006779f7e68cdsm874467qvs.79.2023.11.15.14.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:30 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:27 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH 08/29] bootm: Move boot_get_kernel() higher in the file
Message-ID: <20231115223627.GP6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cDby6QEB7UWIXp86"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-9-sjg@chromium.org>
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


--cDby6QEB7UWIXp86
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:53PM -0700, Simon Glass wrote:

> Move this code and image_get_kernel() higher in the file to avoid the
> need for a forward declaration.
>=20
> No attempt is made to remove #ifdefs or adjust the code in any other
> way.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cDby6QEB7UWIXp86
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR+sACgkQFHw5/5Y0
tyytHwwAgRoHKD94Nh7uHz/dKCnRTccX4k0RUHbidJ9CCU0dpn9Rt8SU7kL29qF1
usK72leSOjNwGXkGhTz0DJ3/4u1RwaqerBiiv2GsQtQrmz0MsMUEy5MBJjpkRowY
bY9/122jhfTpSiI1m73ZqDK8ZyitK12RYKq5xfF/AZ8fy/42LVWbs0ipU+msqCRb
Wp7QXt0YDYol6zULeFVIOUg6boDJYbcRqzY1LwFvEm6pu1mDRiT+JMbq/3ywbd+s
XVbz1wtGCWB8tFwGM6gGGcj6ALBDCtfzp52XdplfotWeikx17g231AnKIZUNJVrC
QOVRktGJ0Sap3p8OrRJJANZlm8IWM1i2yPXLSWFjr1Z4cQOyvEf8Da+OajpQ5I1B
2zI4AL2UqJXrY030cbRe09XAJimo9Izc0P1Tx+XvD7xFk8ZCahRxfivxmaDlPYwC
/DvQEm+DXnXBS782h3QeH98PpEtTlWjN8mWuJegdiB9vm7WkqjheIEslGgwvH60L
4aZEOUzK
=tGl0
-----END PGP SIGNATURE-----

--cDby6QEB7UWIXp86--
