Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D384C10F1A
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 13:26:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D2588774;
	Tue,  7 May 2024 15:26:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mb6UHALa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A500F88774; Tue,  7 May 2024 15:26:33 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 695A2886D1
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 15:26:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7929363c7a3so250271785a.2
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 06:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715088390; x=1715693190; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4FLYR1B0+nealrzel+CTyyGRmDgKvfCNkMiAH0lb+DQ=;
 b=mb6UHALamaLsqLj0puMpHyi8Iv2jZdewWc5QKjR+hC5Lqn8cH6kEtl9WWEwv1bQejB
 ik3S1l3Lj9WmXQ03cOYCkR1OPjExjg6SL47SUilt+7GHkExmZV7VmLOPNHspgjlkrtco
 1uhBr3lYVRPeombH1JU58NJAib24mfy/fo9Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088390; x=1715693190;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4FLYR1B0+nealrzel+CTyyGRmDgKvfCNkMiAH0lb+DQ=;
 b=rZG4hT+XvinbS3qVageGMYdKVpjiZRKgIM+VUuqMK/4TIklMDnglL0K8OTVORgzxwV
 cUkcnEtBpMgqg8npuL2j3ttY6Q28gBxtie6hDnb2aVQ5AR2g/ldIYYIjin2Si8ce+bnS
 uRZurKQftsKRQfaBw9YGib2enflS3hyoA7G6LfmS6BfUmy4a1xO/TJWYELfGON694pXj
 XtbBYw5ImIEFqY913V/+HGB/pWdkZXrKKZpw5a7rzfKF1Ya25Jg0G2FEetumsQeWsV6b
 yPm9awXOLG1E70Xzl9ThxExlIPwhjP4Ljbgyih37dFuGTYU6RdYF0QdZmSVVPzGas3qs
 DWTg==
X-Gm-Message-State: AOJu0YzDGvgsY7sOGzExAqZElx/2RZathN4BZeCEz34Xq6bxZM/ZwYGA
 cYRslPJ0iPo6QQ7eyZshSQZsGLY7KTISqUzEwVXlJPTopzumEVC00si9dwo3+oA=
X-Google-Smtp-Source: AGHT+IFb6Kw90PsiZqGKSDkmp0lv5Bn7nOFfTTXZU0Y7ZwKPuH6ysujSEkBx1haGiLcXUQW94hU4yA==
X-Received: by 2002:a05:6214:20ec:b0:6a0:cad1:9ba0 with SMTP id
 12-20020a05621420ec00b006a0cad19ba0mr13228567qvk.64.1715088390250; 
 Tue, 07 May 2024 06:26:30 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a0ceec2000000b006a0fbe09a4dsm4674222qvs.16.2024.05.07.06.26.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 06:26:29 -0700 (PDT)
Date: Tue, 7 May 2024 07:26:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
Message-ID: <20240507132626.GS2568172@bill-the-cat>
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
 <20240503201842.GA2560583@bill-the-cat>
 <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XHWtrc5winuYMQi8"
Content-Disposition: inline
In-Reply-To: <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
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


--XHWtrc5winuYMQi8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 07, 2024 at 11:22:45AM +0530, Love Kumar wrote:
>=20
>=20
> On 04/05/24 1:48 am, Tom Rini wrote:
> > On Fri, May 03, 2024 at 05:39:46PM +0530, Love Kumar wrote:
> >=20
> > > Add tests for booting image using tftpboot/pxe boot commands, tftpboot
> > > boot case loads the FIT image into DDR and boots using bootm command
> > > whereas pxe boot cases downloads the pxe configuration file from the
> > > TFTP server and interprets it to boot the images mentioned in the pxe
> > > configurations file.
> > > This test relies on boardenv_* containing configuration values includ=
ing
> > > the parameter 'pattern'. tftpboot/pxe boot cases boots the Linux till=
 the
> > > boot log pattern value is matched. For example, if the parameter
> > > 'pattern' is defined as 'login:', it will boot till login prompt.
> > >=20
> > > Signed-off-by: Love Kumar <love.kumar@amd.com>
> >=20
> > I'm not quite sure where the problem is, next. After enabling FIT image
> > support in my build so I can use the image I have on hand:
> > U-Boot> tftpboot 200000 v6.6/image.fit.nocomp
> > Waiting for Ethernet connection... done.
> > Using smsc95xx_eth device
> > TFTP from server 192.168.1.10; our IP address is 192.168.1.100
> > Filename 'v6.6/image.fit.nocomp'.
> > Load address: 0x200000
> > Loading: ##################################################  82 MiB
> >           3.2 MiB/s
> > done
> > Bytes transferred =3D 85984256 (5200400 hex)
> > U-Boot> U-Boot> crc32 200000 $filesize
> > CRC32 for 00200000 ... 054003ff =3D=3D> 754c839a
> > U-Boot> U-Boot> bootm 200000
> > ## Loading kernel from FIT Image at 00200000 ...
> > Could not find configuration node
> > ERROR -2: can't get kernel image!
> > U-Boot>
> >=20
> > And in u_boot_boardenv_rpi_arm64.py:
> > env__tftp_boot_test_skip =3D False
> >=20
> > env__net_tftp_bootable_file =3D {
> >      'fn': 'v6.6/image.fit.nocomp',
> >      'addr': 0x00200000,
> >      'size': 85984256,
> >      'crc32': '754c839a',
> >      'pattern': 'Linux',
> >      'config': 'conf-852',
> > }
> >=20
> > But it's not trying to boot conf-852 but instead just passing the
> > address. This image lacks a default config, which your example has and I
> > think is why the tests work in your case.
> >=20
>=20
> Hi,
>=20
> Yes, this case expects to have some default config in fit image as it uses
> 'bootm <addr>' command to boot, below change in fit image should work.
>=20
> configurations {
>     default =3D "conf-852";
>=20
> test_net_tftpboot_boot_config - This case will boot from the given config:
> 'bootm 200000#conf-852'

I think perhaps a related issue is that you're wanting to test that a
FIT image with a default config works as expected. This should be added
to test/py/tests/test_fit.py where we already construct and test
assorted cases like that, and not handled in the "test OS boot" test I
believe.

--=20
Tom

--XHWtrc5winuYMQi8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6LAIACgkQFHw5/5Y0
tyyMoQv9G11ZTtTp2pMMvIXssMGsJBuLlxhMTNOGR1Pt6Tia9ZN1+xofR8uj2OyK
GcG1BZ6BwpyyABH/EyRg+XPGOfkS+//dXATgN0Jhtzp9iI3v5K1qJjlJZ0nvNWIC
aBduUxxvl5CNLwiKGvrIWtGq5escjeOGPfw5IfkKKV+Z3ysC8cRBlYxuZI9tW/E5
UqIbRxdM4kUHih63jS05UuaZg2w2XBurig6ChKXMVf2y43B+4kEZ0j+GzAhZL3bb
IwZkpaKcbLsBPIBPT1wOOo6In4H2FmQtPzhTaZ47eEVD9g7aBU+MfvHQZsaD4elK
EaNPUcIJ9f5Xn2gj45NLPxgm1UynJ3k895Iq3bE93jt1xmAbGSPrqmcugZR+9xsx
snEKB5IaxMMtG8C3l6uyQ1J+3u4TNOUfDrIyPdOcaxkHWL8VnQbXB3immgVwmV4Q
/WWtegXN3j3KpAqkEaDRX/d6d6ZWvqHCrjnHvGO5vpQnJcfiRUz58Xxge+PZusrK
Y8Jf6Ks6
=sFrb
-----END PGP SIGNATURE-----

--XHWtrc5winuYMQi8--
