Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F4FD3C545
	for <u-boot@archiver.kernel.org>; Fri, 18 Oct 2024 03:14:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C50B1891B8;
	Fri, 18 Oct 2024 05:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OhrhrPZr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4E1A891B8; Fri, 18 Oct 2024 05:14:42 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1B2C891AF
 for <u-boot@lists.denx.de>; Fri, 18 Oct 2024 05:14:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4609c9b39d0so10036611cf.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 20:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729221279; x=1729826079; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zrckl78r1TO+oDZdEBDf9XiV3/bvhcbKOPhgj6wzqq8=;
 b=OhrhrPZryct4JddBJ2pSjdWPtluqOcmPGEgonox0IzuDQj41sS/ZTmrOmVoiFOeGlr
 8IbSr8GXaPPGIGcTplze1blzR0YHIAhYTajPP/J0enhznSe0UEVA2DbnWAzqYk76Gnjw
 Rz2tvsDJLx+vEYqKidmHUhJfmbhvFS53OP1gs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729221279; x=1729826079;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zrckl78r1TO+oDZdEBDf9XiV3/bvhcbKOPhgj6wzqq8=;
 b=go6fnyrSOgT+vTOFOTXsa8oHpHxf69ai/1XbEBTyf8uqtY3IO5pQ5ojPuOKwZ6+gqc
 2iwbDppX/w//7OFembEDqFF5+JitKHPr6G3buDKABj2aK/T3xL/HOFa4U5sfVbAThRwB
 JOx1nA3Pa1YKMcitmXrQeAUdb8ET1RlKm8EFQUIUY7XjMyQBl8c4rVb9s3wRrEMKdD09
 25WpqWxRJ1Wk5rIokhtIy6zD8zFd66YiORWpt2kW6kpGKn+X4mz11sXaQ5lpqdnrQrEC
 NP2vCyGlPrLp6NhSphxcApJOMqEJyhSzuvwL2mKZBxL6Xxf5wLdrUD+CXfUKBkdCS1Q/
 mFqw==
X-Gm-Message-State: AOJu0Yy9ZlzUtIMr/GB/0UJSh1/8SFaJ6kVl8cGWahZHVN+OfORSiNqq
 ZTBFqweMOt/HlabztuEdiCWrjv+PdrJ1uTI2eD+eR1pu1ubVT7LwOqM37yEFwWk=
X-Google-Smtp-Source: AGHT+IFUfERQlerMGRg6S3RppkhfOZobYJdsJ7UOfKBFCXRJ9S3YxawViBAtGsWOhWqlmWzusFcR6w==
X-Received: by 2002:a05:622a:15cf:b0:460:8dba:c60f with SMTP id
 d75a77b69052e-460aed80708mr10975861cf.27.1729221279543; 
 Thu, 17 Oct 2024 20:14:39 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460aea608d3sm2919151cf.91.2024.10.17.20.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 20:14:38 -0700 (PDT)
Date: Thu, 17 Oct 2024 21:14:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Shantur Rathore <i@shantur.com>
Subject: Re: [PATCH 23/34] bootstd: Maintain a list of images
Message-ID: <20241018031435.GS4959@bill-the-cat>
References: <20241017232413.724808-1-sjg@chromium.org>
 <20241017232413.724808-24-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f5rgsIu8xUty5Xsj"
Content-Disposition: inline
In-Reply-To: <20241017232413.724808-24-sjg@chromium.org>
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


--f5rgsIu8xUty5Xsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 05:24:02PM -0600, Simon Glass wrote:

> We want to keep track of images which are loaded, or those which could
> perhaps be loaded. This will make it easier to manage memory allocation,
> as well as permit removal of the EFI set_efi_bootdev() hack.

Please stop calling it a "hack" in commits, that just sets things up to
argue. Thanks.

--=20
Tom

--f5rgsIu8xUty5Xsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcR0pcACgkQFHw5/5Y0
tywGnAv3SeZLhBy33fFWt/p2SfIcbFuuvWhJBX2aJV/49RNcxbJ/2Q0DXeZ9cjs0
eofwy4IH72WEs3pCyvJCPAuAI6cnyJpRDuL2sbyCjoCTwQ5ejSq490jO27DzMaP+
xynBgz/zde/pxuav39D1PcMsCcTbpCdpQ0pLHyWgtOaLDyNQmSsmTbJ9mcPoubRC
enqcyJElzmEV+YAygZljIhviqkts0Vg+r5rWim4238vCTQpZX4XmFJJF2e+RWNux
8dD95/ATIPgubDm/ci69XZr8EzZ+dsbARylo6jZSeGr1WqwHDzy4Ef7cmeZXhZCm
ByqafjON/NVy8aPklyCGlGiDDFQLjFSI9Ths9G3XgSqct5fza50J3aD5SlPVusHn
PIb8nXLmZ09NUDtPm29g28dOWk7sbVEouBlyy+EoRFI4s69UE/gLjdiDaVFjA3Zc
lGXzPJ4GsCoD/wEnTCangKF0TMYBv+W7HORX6Bn0p6hlaH1ZPStLb+ZE1pHpBaIZ
nEXgPhg=
=sv9/
-----END PGP SIGNATURE-----

--f5rgsIu8xUty5Xsj--
