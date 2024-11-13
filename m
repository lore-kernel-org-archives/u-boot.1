Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 440DDD637A7
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 23:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13F088FFC;
	Thu, 14 Nov 2024 00:59:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qpkRaul3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 155B089045; Thu, 14 Nov 2024 00:59:25 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D125D88CEC
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 00:59:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7180a400238so727355a34.0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 15:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731542361; x=1732147161; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QQI7vibV59GKA36UF+wjYgpvCP8FvtVf9pCJgIQ/oZk=;
 b=qpkRaul3GqPZipC+3FzGxeiKlUxluyEJt/3gw134B8kqEaC4A9TU+MV4AAa4saBT4e
 RAym8TBErgE/jgG2qqol4OKsAMFy+/x7A92WYL1zDxuyHBh1CgykqtSB1bf61fvub4+V
 hOqrDOEhPtBx73jRgM0EL6eLnNvB/f1Zt7VBA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731542361; x=1732147161;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QQI7vibV59GKA36UF+wjYgpvCP8FvtVf9pCJgIQ/oZk=;
 b=iaaT41a/4p5F4MZhhyytKlBdxhTbTeYjU4+12wdjRsZSbxWo2I5ypdjXIfhDik5ZZ4
 vqdtiyC4ewS22YWPC/u1L6D17a9guBOcHFoqen7XWoOcVJagl63CHXLz/Ylzm/If+aRC
 8fjufxjR/cNj2+VUDZgZFItovQexy2q+71qlHGLEF0Ogv4l6d754EJNxG7Lx/LludWxz
 pIRK6lqTG/Ryz7FASrKXIiD1kmfTu05pr05oo73URJ6wN0mNMYDdM1U/CaHcg48uUvbw
 UBWL/37yIWhIjlj4jq087+THAM50cTaDb3OtcKLwdOJBv+pRHl5w3v7tmN82gyu4lupQ
 phPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVFCNhfVxBqq/R+3BuGoVOLtwmwQoRW9ypvm39U4gakEwvRyG7qMjss+V6Z9zLZCoz1vuhcAc=@lists.denx.de
X-Gm-Message-State: AOJu0YySGd+VHA3OyccR8G7usU9pgoTGei7SJpRxW4Tz3Kcz75BQsFjO
 gzreRIsYX3JyuCEu3dQtPsFmthojRZhJ9AukvVsf/zCVGCICCSfu7jRfC/3sLds=
X-Google-Smtp-Source: AGHT+IFapY3lQn6WcFFnIqWdizhlHQCtn9MXE+uWqCdk/Ri2yn4FpEnlzpbuv+79gZEq08rrA9jzWw==
X-Received: by 2002:a05:6830:7206:b0:710:e4db:b760 with SMTP id
 46e09a7af769-71a6af2e2eemr1016717a34.13.1731542361557; 
 Wed, 13 Nov 2024 15:59:21 -0800 (PST)
Received: from bill-the-cat ([145.14.135.248])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ee494fb9adsm3351502eaf.4.2024.11.13.15.59.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2024 15:59:20 -0800 (PST)
Date: Wed, 13 Nov 2024 17:59:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: E Shattow <lucent@gmail.com>,
	U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [BUG] dhcp fails to download file with CONFIG_NET_LWIP=y
Message-ID: <20241113235918.GA3600562@bill-the-cat>
References: <7ae3c2a0-2a9f-413c-8fff-bac18421c335@canonical.com>
 <CANV2PTNScpCfP3vuwHFchR7ZgP5oDGUe1-9Lg5u2v8-cU48Pig@mail.gmail.com>
 <654f78ed-18db-4f77-a732-69ef32c8c7c4@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g7Jp0kH4De+c0ubR"
Content-Disposition: inline
In-Reply-To: <654f78ed-18db-4f77-a732-69ef32c8c7c4@canonical.com>
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


--g7Jp0kH4De+c0ubR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 09, 2024 at 04:22:26PM +0100, Heinrich Schuchardt wrote:
> On 11/9/24 16:12, E Shattow wrote:
> > On Sat, Nov 9, 2024 at 6:20=E2=80=AFAM Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > Hello Jerome,
> > >=20
> > > Using the old network stack U-Boot's dhcp command can be used to
> > > download via TFTP. This fails with the lwIP stack:
> > >=20
> > > StarFive # dhcp $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
> > > ethernet@16030000 Waiting for PHY auto negotiation to complete.... do=
ne
> > > DHCP client bound to address 192.168.1.47 (233 ms)
> > > StarFive # tftpboot $kernel_addr_r 192.168.1.103:/vf2/grubriscv64.efi
> > > Using ethernet@16030000 device
> > > TFTP from server 192.168.1.103; our IP address is 192.168.1.47
> > > Filename '/vf2/grubriscv64.efi'.
> > > Load address: 0x40200000
> > > Loading: ############################################################=
#####
> > >            ##########################################################=
#######
> > >            ##########################################################=
#######
> > >            ##########################################################=
#######
> > >            #########
> > >            4.1 MiB/s
> > >=20
> > > We should try to provide the old functionality to make the move to lw=
IP
> > > seamless.
> > >=20
> > > In the CI QEMU instances we already have
> > >=20
> > > test/py/tests/test_net.py
> > >=20
> > > to test tftpboot. We should add an equivalent dhcp test.
> > >=20
> > > Best regards
> > >=20
> > > Heinrich
> >=20
> > It is useful to have dhcp assignment without the side-effect of trying
> > to load files. Your script can be updated to:
>=20
> The dhcp command was explicitly built to support booting by retrieving a
> filename from the DHCP server and then loading it from a TFTP server. The
> recovery of many routers and IoT devices depends on this feature.
>=20
> There is an environment variable autostart that controls if the file is o=
nly
> loaded or booted.
>=20
> If we want to change the behavior, it should be via a well reviewed patch
> and not as a side-effect.

Yes, lwIP needs to match the long standing behavior here.

--=20
Tom

--g7Jp0kH4De+c0ubR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc1PU0ACgkQFHw5/5Y0
tywKwgwAnkBU3pA2+hryoYj82B2k6ywhewPb5/qmaspECcWVh3bA2Ao2muy9BnUW
+P2G0bmA1HEhxarMXijqF2dtVXK6QaJcsLuIzlbCNrpaZ8pmZBqUEluniK7DbBdO
70v0SGv3jSTF0QLdRLGfnkQ7gSu6KWgqyhNNl9aUteqqrr+2OeKyf1VurAA7nYlZ
1iOLWD91UQF6bSoTUmIBjoYdbeFW6c/5h061ZaZstcpjY2CrIHi5G2sPNAHC515F
oTItXVn8U3hkzrfOGUsZX0CoVp86V4RTrAsYBS7xMc4nroCwlbmxmeMfOpm6b6fa
8AeOvdfItqrWx9x/0nzfTLBZyqY/Y8vd2Yk3D9xvCIm74IkWJ4qJKNGO7RMPSt3y
WtjbPU1eAFjR64gcvB0mSdful82mi82BM6XI7hFEIrTv2TI0v0quMmWn8xtuxhU6
PPVCpimOW0dNl9YBEApwcZAEEhvzFHqSid3fQcksFngdOPSPZpB0Gc9XoDi1Gxq0
g/Alq7YR
=tyLz
-----END PGP SIGNATURE-----

--g7Jp0kH4De+c0ubR--
