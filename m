Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDF2C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 17:19:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71EBC883AB;
	Mon, 17 Jun 2024 19:19:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YAfOzdRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CEBB6883AB; Mon, 17 Jun 2024 19:19:45 +0200 (CEST)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F258837D
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 19:19:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-3d4430b8591so275707b6e.2
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 10:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718644782; x=1719249582; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PYctsSTg6139TU6EZmRa8lEU5DJjAPFhhYbtx8tLv+k=;
 b=YAfOzdRdK9Yh0gPAbKj5TcL0wO6gMmOQsAvp2LWMgv2IBOg7wulbYCeskk/yrB+Jwk
 6EpHJjXjDMv9UYOp+CWkrrLAGu79hutxQDJCCLCXn5O1T4Cp9RhILizu6vAIuVSIWXnV
 fkFvy/NZnoBjeeX98VbzL0Onf/bQrwd4pZSrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718644782; x=1719249582;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYctsSTg6139TU6EZmRa8lEU5DJjAPFhhYbtx8tLv+k=;
 b=uihYJaxCtYIg+75x+9MXvczl0dAGLXh0l5+Ar6O3ga9xmc53SfjjIahiLK5N9/A/5R
 xDy+VOik3T6DZ6CtJSI4Cbd/djBKcpXBcC4Zd5QgBz6n14E+tFQ7DDZxFHUM0zG08VcI
 7tNgJng1efaa16saIu4LWbixmkOg5146UvhJbIraBJm7koqzbJjcKZ7N9yq8R0zNBsHn
 5OqvA0IelKBeuK72FNlhTpvaYuZkDP2ncQQmatBUt/Ybdi7/BIt/3lXXKPdya0c3WBmg
 6xTLrfqf/FPkb5rNVtO5XCEMXvcMQlX4plAKQrGht2hgBeTM39Ueq4IA17N6X5YCtdo3
 usyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU37aplRR3AhK8ceokANH+Jl+dEJoOOLKA62tov8U3fXo4vfD3HpLcGdO/snTNAOs60NAMgxhDLSU660ps6caOe9EQNQ==
X-Gm-Message-State: AOJu0YycQ+OYrcoki6uywrSV9E6Ut8/IqPvJAcriAPyf+vyXXHkcvjQO
 FVNjtsBWfc61fliSDhaS+vqNtjHSrmRujnmHNldBcWtmF8kWMbTMVIX79lzMWks=
X-Google-Smtp-Source: AGHT+IFnSSiJ8v38qfvnmy0KH6J3+oZxAjsywhfbxzhPIFBOGoildLOkpvV1G+KUC5b1Ron64d7vLw==
X-Received: by 2002:a05:6808:f15:b0:3d2:2003:983a with SMTP id
 5614622812f47-3d24ea2d010mr12883328b6e.59.1718644782209; 
 Mon, 17 Jun 2024 10:19:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-45.totalplay.net.
 [187.190.205.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d2476c0a87sm1550999b6e.45.2024.06.17.10.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 10:19:41 -0700 (PDT)
Date: Mon, 17 Jun 2024 11:19:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, hs@denx.de, pro@denx.de,
 vasileios.amoiridis@cern.ch, u-boot@lists.denx.de
Subject: Re: [PATCH v3 2/2] doc: api: bootcount: Convert to rST documentation
Message-ID: <20240617171939.GZ68077@bill-the-cat>
References: <20240613220212.37078-1-vassilisamir@gmail.com>
 <20240613220212.37078-3-vassilisamir@gmail.com>
 <6cf18006-bed8-43cb-aff8-591781f8c3ac@cherry.de>
 <20240616182053.GA4275@vamoiridPC>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HMCW/f9N5YGWfbN9"
Content-Disposition: inline
In-Reply-To: <20240616182053.GA4275@vamoiridPC>
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


--HMCW/f9N5YGWfbN9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 16, 2024 at 08:20:53PM +0200, Vasileios Amoiridis wrote:
> On Fri, Jun 14, 2024 at 10:43:09AM +0200, Quentin Schulz wrote:
> > Hi Vasileios,
> >=20
> > On 6/14/24 12:02 AM, Vasileios Amoiridis wrote:
> > > Move to the new documentation style with rST formatting.
> > >=20
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > > ---
> > >   doc/README.bootcount  | 53 ---------------------------------------
> > >   doc/api/bootcount.rst | 58 ++++++++++++++++++++++++++++++++++++++++=
+++
> > >   2 files changed, 58 insertions(+), 53 deletions(-)
> > >   delete mode 100644 doc/README.bootcount
> > >   create mode 100644 doc/api/bootcount.rst
> > >=20
> > > diff --git a/doc/README.bootcount b/doc/README.bootcount
> > > deleted file mode 100644
> > > index 0f4ffb6828..0000000000
> > > --- a/doc/README.bootcount
> > > +++ /dev/null
> > > @@ -1,53 +0,0 @@
> > > -.. SPDX-License-Identifier: GPL-2.0+
> > > -
> > > -Boot Count Limit
> > > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > > -This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> > > -
> > > -This allows to detect multiple failed attempts to boot Linux.
> > > -
> > > -After a power-on reset, the "bootcount" variable will be initialized=
 to 1, and
> > > -each reboot will increment the value by 1.
> > > -
> > > -If, after a reboot, the new value of "bootcount" exceeds the value of
> > > -"bootlimit", then instead of the standard boot action (executing the=
 contents of
> > > -"bootcmd"), an alternate boot action will be performed, and the cont=
ents of
> > > -"altbootcmd" will be executed.
> > > -
> > > -If the variable "bootlimit" is not defined in the environment, the B=
oot Count
> > > -Limit feature is disabled. If it is enabled, but "altbootcmd" is not=
 defined,
> > > -then U-Boot will drop into interactive mode and remain there.
> > > -
> > > -It is the responsibility of some application code (typically a Linux
> > > -application) to reset the variable "bootcount" to 0 when the system =
booted
> > > -successfully, thus allowing for more boot cycles.
> > > -
> > > -CONFIG_BOOTCOUNT_FS
> > > ---------------------
> > > -
> > > -This adds support for maintaining boot count in a file on a filesyst=
em.
> > > -Supported filesystems are FAT and EXT. The file to use is defined by:
> > > -
> > > -CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > > -CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > > -CONFIG_SYS_BOOTCOUNT_FS_NAME
> > > -
> > > -The format of the file is:
> > > -
> > > -=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -type entry
> > > -=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -u8   magic
> > > -u8   version
> > > -u8   bootcount
> > > -u8   upgrade_available
> > > -=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > -
> > > -To prevent unattended usage of "altbootcmd", the "upgrade_available"=
 variable is
> > > -used.
> > > -If "upgrade_available" is 0, "bootcount" is not saved.
> > > -If "upgrade_available" is 1, "bootcount" is saved.
> > > -So a userspace application should take care of setting the "upgrade_=
available"
> > > -and "bootcount" variables to 0, if the system boots successfully.
> > > -This also avoids writing the "bootcount" information on all reboots.
> > > diff --git a/doc/api/bootcount.rst b/doc/api/bootcount.rst
> > > new file mode 100644
> > > index 0000000000..9435a7ef15
> > > --- /dev/null
> > > +++ b/doc/api/bootcount.rst
> > > @@ -0,0 +1,58 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+
> > > +
> > > +Boot Count Limit
> > > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > +
> > > +This is enabled by CONFIG_BOOTCOUNT_LIMIT.
> > > +
> > > +This allows to detect multiple failed attempts to boot Linux.
> > > +
> > > +After a power-on reset, the ``bootcount`` variable will be initializ=
ed to 1, and
> > > +each reboot will increment the value by 1.
> > > +
> > > +If, after a reboot, the new value of ``bootcount`` exceeds the value=
 of
> > > +``bootlimit``, then instead of the standard boot action (executing t=
he contents
> > > +of ``bootcmd``), an alternate boot action will be performed, and the=
 contents of
> > > +``altbootcmd`` will be executed.
> > > +
> > > +If the variable ``bootlimit`` is not defined in the environment, the=
 Boot Count
> > > +Limit feature is disabled. If it is enabled, but ``altbootcmd`` is n=
ot defined,
> > > +then U-Boot will drop into interactive mode and remain there.
> > > +
> > > +It is the responsibility of some application code (typically a Linux
> > > +application) to reset the variable ``bootcount`` to 0 when the syste=
m booted
> > > +successfully, thus allowing for more boot cycles.
> > > +
> > > +CONFIG_BOOTCOUNT_FS
> > > +--------------------
> > > +
> > > +This adds support for maintaining boot count in a file on a filesyst=
em.
> > > +Tested filesystems are FAT and EXT. The file to use is defined by:
> > > +
> > > +CONFIG_SYS_BOOTCOUNT_FS_INTERFACE
> > > +CONFIG_SYS_BOOTCOUNT_FS_DEVPART
> > > +CONFIG_SYS_BOOTCOUNT_FS_NAME
> > > +
> > > +The format of the file is:
> > > +
> > > +.. list-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - type
> > > +     - entry
> > > +   * - u8
> > > +     - magic
> > > +   * - u8
> > > +     - version
> > > +   * - u8
> > > +     - bootcount
> > > +   * - u8
> > > +     - upgrade_available
> > > +
> > > +To prevent unattended usage of ``altbootcmd``, the ``upgrade_availab=
le``
> >=20
> > I think what was meant here is likely "unintended" (not deliberate) rat=
her
> > than "unattended" (unsupervised)?
> >=20
> > I understand you didn't introduce this and just migrated it to rST, so =
free
> > patch to whoever feels like sending one :)
> >=20
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> >=20
> > Thanks!
> > Quentin
>=20
> Well if Tom agrees also with the previous patch then maybe I can send a v4
> correcting those 2 issues it's fine for me!

Yes, please do a v4 with that and adding this to the index in
doc/api/index.rst so that CI will not fail.

--=20
Tom

--HMCW/f9N5YGWfbN9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZwcCsACgkQFHw5/5Y0
tyxLLwv4qez2JD1D2YpWnqEmnjZTPIIi86aMkvwGOC/n0QCfeT8O5M/edqiPXwmP
RM2z+3YLdfymDKUsqv5mRRUSyX55255WzRQip3l6SNb6ghxZkoPZRDWCGTlmsBZo
7T4x8IqOsvrNdMudrxpFUzcEDnk+kQbdZZEVOJuRW1JoNrZvE78EuuvWzuzFNUog
Qm8w8I41QFnMlf+c9HfqE9Oyo2ctJLuAQFIGTow2hsFDOcXjmY+/+TjXaf66p0sK
Kr+fUl7F5LDTXS+ejSalp+GVRl4F/LVmURiGCGIAR4E9jxCW0oQdTfbRzCA9Tk7n
Kd9D2M2Gl+PZa9eUxqFYWXQ+yLTvkxTMhkim0E2I5AfaPYBnhWLAGON/NUnAv4/y
KXYKS+GyqxCfSoFi7yzi54OMkX/7Q9LW6DYQ3mxgc9DnC7VhbAuTIUH0xfElX+DN
tIiDRmRKS+w+14lSWqC0nIWI4NnwrhGjFtHQFSFE0hpkfZjT8iNyoR0ZjXJRH4To
PmvRLTI=
=6GY4
-----END PGP SIGNATURE-----

--HMCW/f9N5YGWfbN9--
