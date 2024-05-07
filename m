Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D54CC25B75
	for <u-boot@archiver.kernel.org>; Tue,  7 May 2024 13:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7246188739;
	Tue,  7 May 2024 15:20:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dAN/mjiG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6954688739; Tue,  7 May 2024 15:20:08 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C72F88749
 for <u-boot@lists.denx.de>; Tue,  7 May 2024 15:20:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-43ab8e0f435so9273901cf.1
 for <u-boot@lists.denx.de>; Tue, 07 May 2024 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715088005; x=1715692805; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pl8hNre18Hx5YIZ4xPV3pkx92qm7YtdSrpsdQ7Sq4Bg=;
 b=dAN/mjiGzS1pGh1mmn92IHWZrwfjbBSorAs/3K6QPzWeRPKNejDDXhS4JMJZ9zvo9T
 QCZVVMN1DcA/VqrP2IEhEjjzSAJF+XGpacUX1uhe4D/739ZqaFk8L1fHV1vzOhBar51g
 z67tD0WVQN5FEEt5PGV+U8PKbuF0hb1P47JMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715088005; x=1715692805;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pl8hNre18Hx5YIZ4xPV3pkx92qm7YtdSrpsdQ7Sq4Bg=;
 b=Q6Wq8RODQRMWLQ4tKWizAU2zbAQ17aHG88X/uqq+MSITnqb0u8bh0yL4XC/3/B2DLK
 iYlNtXbwldUmv1rtvYF6Hg4ALJHjI6vPzx7+U2BBThxBUMfbV0l9lalawbFzVoVCS/mA
 Lc965Vksh5jlP0mSzBJAGJMS9PflfemytLUMdbJnzNkZq43ikfoTQe2zXadfY6JMMSX2
 yHztBFWUpokrHXyw4U4GriR75k0LpPjSVXvNvX0LPiGIaP2zh1kZts8NZwC40B0YCKgp
 yxtEAtboMJKL7iU9fMsGCQZMPCi/LyLAthrrqpLDepXIsw3h0Aji97MDb2Zl4OM1mWkf
 +hmw==
X-Gm-Message-State: AOJu0Yzxxt+4v38m/QZVZ9T12WzsLwVk4B7qrhMTDYg0IdHwxNkI5dDo
 W3L9u0Bejft5ACW3yHJ3BiVkygvFlPW5cUxCWq8JVGuD0zjj0IRkCdIiDZaJenk=
X-Google-Smtp-Source: AGHT+IFkN22WWI63OA5KLbIkGbpfipE9ApyzGkIsnQmRFFix0Yif9l8H7qbjboHKJXhu0upjmUi3sQ==
X-Received: by 2002:a05:622a:138d:b0:43a:e248:12bc with SMTP id
 o13-20020a05622a138d00b0043ae24812bcmr14387253qtk.8.1715088004946; 
 Tue, 07 May 2024 06:20:04 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 ec21-20020a05622a5b9500b00436e5e47969sm6457607qtb.54.2024.05.07.06.20.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 06:20:04 -0700 (PDT)
Date: Tue, 7 May 2024 07:20:01 -0600
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com
Subject: Re: [PATCH v4] test/py: net_boot: Add test cases for net boot
Message-ID: <20240507132001.GR2568172@bill-the-cat>
References: <d08d45f50dcdfb70e22a27cf13a990bcc2c020fc.1714738132.git.love.kumar@amd.com>
 <20240503201842.GA2560583@bill-the-cat>
 <8df3d032-65bc-4bc9-a255-ba825847ea9d@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vcfdOcd93RUWs07H"
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


--vcfdOcd93RUWs07H
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

I wasn't clear, sorry. The problem is that since we define the config to
use, which is good, we need to then use it. I intentionally have a FIT
image that supports every aarch64 platform and I'd rather use it for
every platform and not a per-platform FIT image.

--=20
Tom

--vcfdOcd93RUWs07H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY6Kn0ACgkQFHw5/5Y0
tyw8dAv1F9hjKkaF/gaeXMoPl6Ykve5DBLDqp7vmJ2DVEWBVDqPwacHXF2G+5skb
nHGi37L6kxN4ZvoCdriGLlc/hSnWj2Lw0OsjM2e/c/jm6/Vp2ODZQJ24yZxdMRhH
YERpC60udm1lZOZaKrCopLBabzTvnwV8FZljT+p9zauAHnH6hF6BgG6XskUPrySw
Gi4SUdsX3qfvQ3c2H7PDHmSOfHoCe16eO+YDDRkELB4qEKCu0y0M5fxiab6gHbL6
J5dIxMB00FCm3YrhkbxBpFPGhJJzdGgqJYFOxBeP4D0Y1uwY0zByWRjAeBLQWtzG
r5fMWo07bXWYHvoh2jSQOr4V0k6A4iCA4RoG/FqNokTo1hnww9Z6IhQsI4BJ7Pej
xE3tdTAulDnFJdvqDoAacu7Pf2c7erM9m5AKkwSnHsuWyzw9sBqacHZjp+dxvWls
KONcHLjO7RlOyEvAEXQ8DZRq7G+Yuk3OK64x7RRO8jKCSMRp2Wvn9QCcHALZdhGR
lAaBPqQ=
=NnaG
-----END PGP SIGNATURE-----

--vcfdOcd93RUWs07H--
