Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CB5C25B4F
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 14:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410AE88789;
	Tue,  7 May 2024 16:35:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AyGwuR8x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B27958834B; Tue,  7 May 2024 16:35:23 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6314488749
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 16:35:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3c861a87d6dso2114493b6e.0
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 07:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715092520; x=1715697320; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3kMhnKMTk3o09QNhMOD9LY30cDElWaP9wLOQOAUzz8o=;
 b=AyGwuR8xI18eVGbzfMEbOHRSjYAo/c8vV8o+Hzvtc0e0SlmAHeYpcUJjZi3p7RqdiD
 nqhXuYyNz711/FunzLNxVvTGO9kqxs1W99mFmPtOOU920NLFH2lHUgtpWq7TTpUcwt3a
 prQlW2YlgrdgJveEQIS6TJOIwmfp6iSRPECqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092520; x=1715697320;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3kMhnKMTk3o09QNhMOD9LY30cDElWaP9wLOQOAUzz8o=;
 b=CN2Kak2QvnNByePnslk2IP3bsD5VlGmDU3l1nwHD7uaajsdNJHDOU0jUp/dWKHeCxe
 Fw0TiZsY4ojJKb3o92ixWSA3RGb5czRFK5vCFAYX8oFFdXrBcgxeDdVssQL7yXQxIsFF
 cyfMnEpNpjMI7Mmkih4YX5MZ8lSt5hBvJk3PMN9kouHOPgE60uOkN/tiDKrO0Ze9KjfZ
 9E7TECEtaaQa/Csj3ZIciWT2vpoXvC9WWFl6YdtjMEfAg9QYavc/JSxjPZ40sp5XOAIr
 NQvFIJFUCHq6qMo4pClodD/0Su3slCDuNiXnggyaepGe+BVqs87wM7QImewLVDjfWoc6
 U4Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTICRJQw0pcHHSKy9nzUK6VXH67F+o3Q1OtYXtauWxzop7Ri0smyfJbt9E3UG80i96b5sHsL3rqwWcDAOqXTgMqjuwjQ==
X-Gm-Message-State: AOJu0YzMQ6Z06nDvKKThQ6Uk3DjIbr+zh/ftbA+i4R61R/Gg8bWXScur
 eG1YRsHtZyEDOjmDOG0XSZW99ZUh/VZ7qtTvwDxbuxm+GWk0gHC8qRy0VZqDQYE=
X-Google-Smtp-Source: AGHT+IHdMfxC+9VYpPFRh/xqJS8xZ+NkXRI4e25JTCbaY80boEvXLnEvs46U6piflOMpQeAn0b7Zeg==
X-Received: by 2002:a05:6808:3026:b0:3c8:6649:51b5 with SMTP id
 ay38-20020a056808302600b003c8664951b5mr17258258oib.10.1715092520117; 
 Tue, 07 May 2024 07:35:20 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 j24-20020ac86658000000b0043d64cbe012sm2255932qtp.90.2024.05.07.07.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:35:19 -0700 (PDT)
Date: Tue, 7 May 2024 08:35:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <monstr@monstr.eu>
Cc: Love Kumar <love.kumar@amd.com>, u-boot@lists.denx.de,
 michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
Message-ID: <20240507143517.GU2568172@bill-the-cat>
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
 <20240503201842.GA2560583@bill-the-cat>
 <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
 <20240507132001.GR2568172@bill-the-cat>
 <CAHTX3dJ3ZyUs4r4POKG7m0Ud6hCLW4bH9rwTFW1oABdtYL3qLg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3+BI6PA+QQmtUAlO"
Content-Disposition: inline
In-Reply-To: <CAHTX3dJ3ZyUs4r4POKG7m0Ud6hCLW4bH9rwTFW1oABdtYL3qLg@mail.gmail.com>
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


--3+BI6PA+QQmtUAlO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 03:26:18PM +0200, Michal Simek wrote:
> Hi Tom,
>=20
> =FAt 7. 5. 2024 v 15:20 odes=EDlatel Tom Rini <trini@konsulko.com> napsal:
>=20
> > On Tue, May 07, 2024 at 11:22:45AM +0530, Love Kumar wrote:
> > >
> > >
> > > On 04/05/24 1:48 am, Tom Rini wrote:
> > > > On Fri, May 03, 2024 at 05:39:46PM +0530, Love Kumar wrote:
> > > >
> > > > > Add tests for booting image using tftpboot/pxe boot commands,
> > tftpboot
> > > > > boot case loads the FIT image into DDR and boots using bootm comm=
and
> > > > > whereas pxe boot cases downloads the pxe configuration file from =
the
> > > > > TFTP server and interprets it to boot the images mentioned in the=
 pxe
> > > > > configurations file.
> > > > > This test relies on boardenv_* containing configuration values
> > including
> > > > > the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux
> > till the
> > > > > boot log pattern value is matched. For example, if the parameter
> > > > > 'pattern' is defined as 'login:', it will boot till login prompt.
> > > > >
> > > > > Signed-off-by: Love Kumar <love.kumar@amd.com>
> > > >
> > > > I'm not quite sure where the problem is, next. After enabling FIT i=
mage
> > > > support in my build so I can use the image I have on hand:
> > > > U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
> > > > Waiting for Ethernet connection... done.
> > > > Using smsc95xx_eth device
> > > > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > > > Filename 'v6.6/image.fit.nocomp'.
> > > > Load address: 0x200000
> > > > Loading: ##################################################  82 MiB
> > > >           3.2 MiB/s
> > > > done
> > > > Bytes transferred =3D 85984256 (5200400 hex)
> > > > U-Boot> U-Boot> crc32 200000 $filesize
> > > > CRC32 for 00200000 ... 054003ff =3D=3D> 754c839a
> > > > U-Boot> U-Boot> bootm 200000
> > > > ## Loading kernel from FIT Image at 00200000 ...
> > > > Could not find configuration node
> > > > ERROR -2: can't get kernel image!
> > > > U-Boot>
> > > >
> > > > And in u_boot_boardenv_rpi_arm64.py:
> > > > env__tftp_boot_test_skip =3D False
> > > >
> > > > env__net_tftp_bootable_file =3D {
> > > >      'fn': 'v6.6/image.fit.nocomp',
> > > >      'addr': 0x00200000,
> > > >      'size': 85984256,
> > > >      'crc32': '754c839a',
> > > >      'pattern': 'Linux',
> > > >      'config': 'conf-852',
> > > > }
> > > >
> > > > But it's not trying to boot conf-852 but instead just passing the
> > > > address. This image lacks a default config, which your example has =
and
> > I
> > > > think is why the tests work in your case.
> > > >
> > >
> > > Hi,
> > >
> > > Yes, this case expects to have some default config in fit image as it
> > uses
> > > 'bootm <addr>' command to boot, below change in fit image should work.
> > >
> > > configurations {
> > >     default =3D "conf-852";
> > >
> > > test_net_tftpboot_boot_config - This case will boot from the given
> > config:
> > > 'bootm 200000#conf-852'
> >
> > I wasn't clear, sorry. The problem is that since we define the config to
> > use, which is good, we need to then use it. I intentionally have a FIT
> > image that supports every aarch64 platform and I'd rather use it for
> > every platform and not a per-platform FIT image.
> >
>=20
> What about putting those two tests together? I mean if config is not
> defined used default configuration,
> if config is defined use it.

So, I followed up with another email too about tests for FIT vs tests
for OS boot. If we update the exiting FIT tests to test that the default
config is used if present would that be a better way to cover the intent
here?

--=20
Tom

--3+BI6PA+QQmtUAlO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6PCUACgkQFHw5/5Y0
tyxEMgv/R6lBwE3z2eWTrnde5DLFEKmtWLvDN22Z4d/WPniGfo1UZxU0Az+r/HQl
OFX0lEqwi+hREp2WU+c9J9uoYb33Pw0FVDyGxBJHbhtfYZhQHYueh1aFy0xYkhzQ
qzKUAvnababS6hMQK7NDmctGcFvbp0vrRmc26pOK/EIu3IZnmvF44Y0GNPu2/Y0D
RVB94n/N1xzKu0PMsTsahwknqfr42v/jiK7UbS8HsPwraNydFyEiwORMnEzhkPTI
ot49PMmV2jPbVXFmrFRGhCERpolQCueMQcy9lvPHHpkPPtLGYvVcUSWFxcry+EVf
r7uFS+Z6qJE35i8CoY3uVcJVC6kIAeROC+H6fm3yCOfic9l6wtV2ZrkvFapR7VHl
Bj5UMR1GY7gQawjz1x/bKWWp4QtOFylGokSRo8uCwzC2YL/bmNvrWCtREPgtR0uw
JhrdNYOtiQyT8AD0rjNbMBotpvnf8xZVH0FDRJvjksFQGZ6tTYiMTjoYDf1JX/+1
GsrRVAQl
=lHjm
-----END PGP SIGNATURE-----

--3+BI6PA+QQmtUAlO--
