Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E566C52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 14:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8780288B80;
	Fri,  2 Aug 2024 16:38:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cUXdpDpe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB2C88B8E; Fri,  2 Aug 2024 16:38:38 +0200 (CEST)
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20::c2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58C4E88B63
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 16:38:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2d.google.com with SMTP id
 006d021491bc7-5d5cbe88f70so4126068eaf.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1722609515; x=1723214315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=lsUbiXNALZ3jUmRIVGqN655wqQqo1YuHPPAu+cfowKs=;
 b=cUXdpDpeP3MBz7sIaKPL/pj37fG7g/S7derH7brRFYotzJDQtFsobK8pGtjlIbnBCD
 3oko0gN3uhYYvNsPTebX+V2tBmvmZIfyHyA+5qyZfd7adrzo1aLumYWegMuwXlYtZ5WJ
 7E4eV6ATB3i/KOiwNO1AhMJdoo3UBOcPrh084=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722609515; x=1723214315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lsUbiXNALZ3jUmRIVGqN655wqQqo1YuHPPAu+cfowKs=;
 b=FK0aP/xKVSKkqVZEUZKBPVOfppYsH02riNwGur+azvu5MfNiGITN+9PgAa0HoPdC+l
 VTJ69337qIXuA6eGrN132ZcyEaTOMlAz8zek8ihD8u3nkVn1Oo0A1OiZpxGHpQafUiOt
 nGnhQW3Un/5jZsS/UTO5OS+hTJo4QmcPzokYzCnTtw2VR755wuT+3X/hZuGQpGWj7U9Q
 81TT/7fFCQgRkKCnLnP/jKeKohkzMRoc+SYieNl1zDq6v0gt9oVC8K4MoCqmygVPrTT1
 8/zfGEy/j+eRyr5lLJMGZKaOPmwUvWWglbVze8VphTg7/709/ntJiEN7aVZLY6Bsak9k
 7FYw==
X-Gm-Message-State: AOJu0Yzd5hcZlLA44hubp/5tSxovPHPCsL4yUAQ/5k8ST4tvwKRl95V9
 Y5DtvTEl8owXwJ5SfESLOktCXp3BiT2YDomTJweSNjhKrFe+x47L9o/bKS667X0=
X-Google-Smtp-Source: AGHT+IHl9Ltscj2oGFTkw1POHq7gkA8oOqmeEokk8uFBKaRJrKY8QnqplYZlUmX5oJSUyYTn0FjXrA==
X-Received: by 2002:a05:6820:612:b0:5d6:f4b:8fb6 with SMTP id
 006d021491bc7-5d6636d2cb5mr4458067eaf.3.1722609515065; 
 Fri, 02 Aug 2024 07:38:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-190.totalplay.net.
 [189.203.103.190]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5d757178a18sm345064eaf.4.2024.08.02.07.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 07:38:34 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:38:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>, Sean Anderson <seanga2@gmail.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: Re: [PATCH v6 00/20] Introduce the lwIP network stack
Message-ID: <20240802143831.GN3794063@bill-the-cat>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3IXNR5OR3le+/N+K"
Content-Disposition: inline
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
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


--3IXNR5OR3le+/N+K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2024 at 03:13:47PM +0200, Jerome Forissier wrote:

> This is a rework of a patch series by Maxim Uvarov: "net/lwip: add lwip
> library for the network stack" [1]. The goal is to introduce the lwIP TCP=
/IP
> stack [2] [3] as an alternative to the current implementation in net/,
> selectable with Kconfig, and ultimately keep only lwIP if possible. Some
> reasons for doing so are:
> - Make the support of HTTPS in the wget command easier. Javier T. and
> Raymond M. (CC'd) have some additional lwIP and Mbed TLS patches to do
> so. With that it becomes possible to fetch and launch a distro installer
> such as Debian etc. using a secure, authenticated connection directly
> from the U-Boot shell. Several use cases:
>   * Authentication: prevent MITM attack (third party replacing the
> binary with a different one)
>   * Confidentiality: prevent third parties from grabbing a copy of the
> image as it is being downloaded
>   * Allow connection to servers that do not support plain HTTP anymore
> (this is becoming more and more common on the Internet these days)
> - Possibly benefit from additional features implemented in lwIP
> - Less code to maintain in U-Boot

Please rebase this on top of current master and resend, thanks.

--=20
Tom

--3IXNR5OR3le+/N+K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmas72AACgkQFHw5/5Y0
tywnkwwAlaKr8FtU550z7fVIDhQTds/8yOa6S4/lrF+9YgWwLLAGz3CD+3T8wenP
WiUp7RNSEto0bTju3dGxHNUg77Lk8LzgziXAc5te70zr885oOZI5p6EJQ/ZpxUSq
TI2F/wc44TftGZ+n5Nv41VGLHZWFffC4lYPshwRT/301jg14fl/Kef7F/IsMWv6v
U5sNmfOZcPm05DdcAWbnZ5GrL1DgBmpgvNgXLFsP8A8OgCI7Y+orhJASkc3dvgzG
iREUrgzTjNw6bIGnr34ABPMhCKDZLEt5487AZgUNFD64oVF27YrQXbOMVA8/vvvT
ZHQtQRDny8wzdnLuoRY1LW5wUhhtNoaHoA7DXg+qoFXs7uP1kyqkxCIBH8ZStEIr
58qJrSjQwOOta2tY+sDha30x3ppPxEkdLvI+dkFzi7zO3GMy6px37DtVvYy46KPC
i0CeCj/iscmfR8PGkn9/08ZU4Ies4cRgZtYfAZ31smj5JaJBJgPPV4kgd4B5qkOV
qROVRrM1
=2qP2
-----END PGP SIGNATURE-----

--3IXNR5OR3le+/N+K--
