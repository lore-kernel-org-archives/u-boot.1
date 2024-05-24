Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B3CC25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 16:58:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 781AF888C3;
	Fri, 24 May 2024 18:58:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="aB7Reh/E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B6E0888C3; Fri, 24 May 2024 18:58:05 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7755C888B7
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-794ab0acfbeso65398485a.0
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1716569880; x=1717174680; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=l0lHRKHXaDf4pc87WcHEZQ8+IqN0WOhKVYX7KOTNRfQ=;
 b=aB7Reh/EyOTtkG6tttv6Zg8rXMfhRmxr7QPyyom+3q/tyDIRSEx2+KyWkz+MeYrVlt
 mwuc02/EwdH6Fwu6p+TGStPCtPuvir3pVibJ9kRamIKucLd2RUAVFyvrMkMzu0nb7Kbs
 Gi4idmvB6BGTZL42jquH8mDKvsDrdSwMuo370=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716569880; x=1717174680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l0lHRKHXaDf4pc87WcHEZQ8+IqN0WOhKVYX7KOTNRfQ=;
 b=CSVEfN/m9jY7tuLoNUsfy0sLwzCHsM5/+vVLSaNbBBTKCTRRPT/x0JcHw+CVOVBto4
 jdVhWq103R+F/235tGZAoJi34lcul8TSN586ks+wFhRjPF27fSgAiO2RLZoDIW7dlUe5
 AFz87HsJMTa6ikOqRO7Wqvr7AQIRTqagQEID5z+PsJn1KtcyIrfDd9c7kKIhf2QDOCgb
 5vihPZqGopPdcT9vpx3J7p8rDJOmzzyhqwZ8Ozc7YFIVH1eHdQbhgw0AiEqox2tIFzWU
 q3EAuMNcD2jYr8pw8AHR+AVSAhXhyCLe5LJPb7w+1aPiPRODQcQ7OkIu26e/cx1vCrpK
 02Pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhenN8wWV20CeaWyNFga23socEXi1NvIWokRGhW3s36wDqGJ+TafgDcSSBqRwD87O8pXK0Jk34SpScoQtSV/Q05+Nltg==
X-Gm-Message-State: AOJu0YwPwKhU7B+fsArH4siaCF+F3RpwF6XpVVE9kvrP08Fjhcru+peg
 o70jU4L6hiwV38vvZQEsZFo67V0YVIkgalxVC+s6FpA2GT5ZVNdrzbIEWnzP1Fw=
X-Google-Smtp-Source: AGHT+IHAjNMlJheJqnHxGnGY19bivIFvQO/mb0KB2D0Lt5V4cSxP5i4kI8+PhbN6CVKLkK2zpSjunw==
X-Received: by 2002:a05:620a:1655:b0:793:82:ad50 with SMTP id
 af79cd13be357-794ab080962mr287869885a.23.1716569880179; 
 Fri, 24 May 2024 09:58:00 -0700 (PDT)
Received: from bill-the-cat ([189.178.170.52])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-794abcdb0eesm78909585a.62.2024.05.24.09.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:57:59 -0700 (PDT)
Date: Fri, 24 May 2024 10:57:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: "Abbarapu, Venkatesh" <venkatesh.abbarapu@amd.com>,
 "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v11 0/8] spi-nor: Add parallel and stacked memories support
Message-ID: <20240524165756.GD2568172@bill-the-cat>
References: <20240304031046.25998-1-venkatesh.abbarapu@amd.com>
 <SA1PR12MB8697F03FAFE69E8FE81F397598E42@SA1PR12MB8697.namprd12.prod.outlook.com>
 <20240507154836.GV2568172@bill-the-cat>
 <4250e775-1269-4929-8451-d8056c6f2f23@amd.com>
 <20240524152646.GA2568172@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="94qS+LH6W6A4Fn4F"
Content-Disposition: inline
In-Reply-To: <20240524152646.GA2568172@bill-the-cat>
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


--94qS+LH6W6A4Fn4F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 09:26:46AM -0600, Tom Rini wrote:
> On Fri, May 24, 2024 at 04:09:00PM +0200, Michal Simek wrote:
> >=20
> >=20
> > On 5/7/24 17:48, Tom Rini wrote:
> > > On Tue, May 07, 2024 at 04:15:14AM +0000, Abbarapu, Venkatesh wrote:
> > >=20
> > > > + Tom Rini
> > > >=20
> > > > Do you have any comments for this series?
> > >=20
> > > Seems likely fine. Jagan, do you have time to put this in a PR for
> > > -next? Thanks.
> >=20
> > No reaction for quite a long time. Can you take it directly to next bra=
nch?
> > Or do you want me to send you pull request to get this to regression an=
d see
> > if this breaks someone else?
>=20
> I will (am now) taking a look directly, thanks for the reminder and your
> patience.

Two problems. First, on mx6sabresd:
+(mx6sabresd) u-boot.img exceeds file size limit:
+(mx6sabresd)   limit:  0xaebf6 bytes
+(mx6sabresd)   actual: 0xaee00 bytes
+(mx6sabresd)   excess: 0x20a bytes
+(mx6sabresd) make[1]: *** [Makefile:1478: u-boot.img] Error 1
+(mx6sabresd) make[1]: *** Deleting file 'u-boot.img'
+(mx6sabresd) u-boot-dtb.img exceeds file size limit:
+(mx6sabresd) make[1]: *** [Makefile:1478: u-boot-dtb.img] Error 1
+(mx6sabresd) make[1]: *** Deleting file 'u-boot-dtb.img'
+(mx6sabresd) make: *** [Makefile:177: sub-make] Error 2

And second, run time failure:
https://source.denx.de/u-boot/u-boot/-/jobs/839632
Which is xilinx_zynq_virt and failed:
Saving Environment to SPIFlash... Erasing SPI flash...qemu-system-arm: ../u=
til/fifo8.c:62: fifo8_pop: Assertion `fifo->num > 0' failed.

So very relevant.

--=20
Tom

--94qS+LH6W6A4Fn4F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZQxxEACgkQFHw5/5Y0
tyxMbQwAjqswsfXfzNMNurhnXESvDHuQnsrmShu7IpQzul3b11/luEg36QW64Z2a
6ks2pFqAG2p3VfnThPckVA7qiIIHm70T03y2yX6+32+VxOTH0qMQ37Fik1sKgHGV
bihSvbuSZ/ZCdmicoYko1KGBPnktCZk4VgzrFHnG3/KWaNdsrOV2Rl3TbIJD+eEU
M+ZK3ENuXEHl27h3OZOSy7yvJbunJAz4QTdq74oXZqUtm6D90g4RUoufhQ2fIAhQ
MUYw3hGa9+bKXU6yVXQKuWh85AeM3FkOrl1GXqf/0aBGbl0K3ftDN8PpAUocQ7Yo
Hzkm/lVZ776bIZDPrgYI2vD1GKI1o5bidGo84nmSzEPdUQ/zZO0okiGvkCj8rTOG
3LoPxM2+32ANOgjxg4VY5OFJ/1AGwShfYdH3lYwRw8/n2WMKApUGM6kSFbD3XDNp
TETa30KL0J690mwEZZyOAF6TJ6fwO54InzOfRHS4SVO/BkztAo2xWRif7GnUVzNg
XXXefclX
=586a
-----END PGP SIGNATURE-----

--94qS+LH6W6A4Fn4F--
