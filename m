Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A566ED3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 14:17:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC92892D2;
	Sat, 19 Oct 2024 16:17:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="arPevz0Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D8C03892CB; Sat, 19 Oct 2024 16:17:02 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 877A8892AA
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 16:17:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4608da1bea5so21033701cf.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 07:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729347419; x=1729952219; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VgSO6NEPG/a+yOMY5UktXc66hvGhbPTDpb6Uo81IYYQ=;
 b=arPevz0QelEy1BlolIvXYzxL4JC6NFn3Yfvg8ygFsbg45CMQLk+4PMkBfw20o+Aq92
 xeHotPZLEQqAYTsvMyjZ00v+uXmGHOhJqQN07sbLnNn3MU5TC0MZ0OwJJ8U5fVEDsOKy
 tKzqW1TMcR6B62w/pHvbW9ZgAzBAlw8kcr7hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729347419; x=1729952219;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VgSO6NEPG/a+yOMY5UktXc66hvGhbPTDpb6Uo81IYYQ=;
 b=b5EmGSUIU+rBFzY4hNqnyqSG3mbvJ7gGb/NPSl16yzu+q1Zhbn0pdKsZluykkpKx47
 1TLVFPTwgZ4w0ec/eGWJy6EpjBcxsuzDZaYXSbZxHSttCiRKgGei2M84S5iXkgo13wV9
 JTsEDpDG56NGfkKW787S5Y2Yx8vpYZ9zI0hr+rvzma0aYJxGv9HgwVqQ8UAb1eOyENvg
 AV1LzetcSJZoHAK6wdTPFag56oHfpeFCIsq0iGHS0D7hkSLatHEDb+4tDweyVFQK9CnP
 X0nUsP7w0Lq2kG86v/adIgoTKw2JFe8OrYt6vh2eHkiLkhNw8piua20Emlryb3ty2OEn
 EcHg==
X-Gm-Message-State: AOJu0Yx4ou0EVJbUPVbBhdP5LszzgRYEApdyCtf9VT39S0Sady7Ke3KX
 3cr8mDrJ2iRSq6uDFRaoJIGbVcRYd3oJV//94p3FV4dJNfBEKKFc96nTLiEG2f8=
X-Google-Smtp-Source: AGHT+IHxW+YlOrXEG0R00Eq7J6II/kUM8o693J1Hg8itkgFAS1EJK0t32iWGpaBWiIh9fbNDTSRY/g==
X-Received: by 2002:ac8:788:0:b0:460:bb93:4b00 with SMTP id
 d75a77b69052e-460bb934d0dmr35520361cf.50.1729347419275; 
 Sat, 19 Oct 2024 07:16:59 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cde111b366sm19369206d6.5.2024.10.19.07.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 07:16:58 -0700 (PDT)
Date: Sat, 19 Oct 2024 08:16:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>,
 Nishanth Menon <nm@ti.com>, Baocheng Su <baocheng.su@siemens.com>,
 Li Hua Qian <huaqian.li@siemens.com>
Subject: Re: [PATCH 00/11] boards: siemens: iot2050: SM variant, sysinfo
 support, fixes & cleanups
Message-ID: <20241019141655.GS4959@bill-the-cat>
References: <cover.1728539755.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uL5X8p1WKDqCaRYW"
Content-Disposition: inline
In-Reply-To: <cover.1728539755.git.jan.kiszka@siemens.com>
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


--uL5X8p1WKDqCaRYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 07:55:44AM +0200, Jan Kiszka wrote:

> This series depends on:
> https://patchwork.ozlabs.org/project/uboot/patch/a54b501a-9a98-426c-a5ca-=
faf547411a30@siemens.com/
>=20
> This adds support for the new IOT2050 SM variant, introduces a sysinfo
> driver which also permits SMBIOS support and switches the board to
> OF_UPSTREAM. There are some further fixes for the boards included as well.
>=20
> Not yet included is configuration support for DMA isolation via the PVU as
> this depends on not yet merged DT bindings and another overlay.
>=20
> Not a merge-dependency but still needed to restore full support for the
> IOT2050:
> https://patchwork.ozlabs.org/project/uboot/patch/6c201a24-422a-41f7-846c-=
1ad5b0ebc7e2@siemens.com/

This currently fails to build on iot2050 on master, can you please
rebase and re-run CI? Thanks.

--=20
Tom

--uL5X8p1WKDqCaRYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcTv1cACgkQFHw5/5Y0
tyyS+wv+OKpWa40Rt1FqPUlDCupWYbKFcFcYGxu+bmPQa94QkDb1t99ipvtcqWKu
aoZVhpq88PQMv6ETAhWoGDyFBtIt397WyL2bkOg/puc0hSN7Le2FLhPc2dSO1hR5
13434NmkS4YWtnzsrc9ucuk6fsNEcY5fa0eeunbqsZXEM1/JZM/lCaj+GS6nMimX
Q5SWLrY0pz4ermyDSnTL9PjLTT0Oy0Oj5Oxa385uMBrhSyVS6nd79hAG21CptcQX
JNGZXdz5SXu6K12uI/euApEP/crwyOS/xT25Giv/arEZD7tbHfWmKhU2p2TqL6Xo
T0Us9tDPM1VFkuFM7LuSX8M71zoFX0KsOrGIbHp8rvFpEzyNhwMwSWkzwVwar16v
+N+ZxtwZF3QhYaQnRO1AJklzrb9+G96YLmA11OmOjp2bLyx8IFRGMQpWwFg8PJE7
5sHrhsRtLwVOkQSrFXH+sp5p6/EiIhnYAF1Jh1eg2vL3eoOAfAnv0bUHTGhngOvX
+jiAfJMw
=ImK1
-----END PGP SIGNATURE-----

--uL5X8p1WKDqCaRYW--
