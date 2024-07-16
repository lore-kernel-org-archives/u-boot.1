Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76297C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 17:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3E7D887E6;
	Tue, 16 Jul 2024 19:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gwDNLzNP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CAB4889EC; Tue, 16 Jul 2024 19:21:20 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AF0887D1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 19:21:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3d9de9f8c8dso3370288b6e.1
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 10:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1721150476; x=1721755276; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MGyMyVmIzhmIyGflPh0TCg7mN+PkloIi+2HDCwtcVQo=;
 b=gwDNLzNPTNwWBJtUGOX36F7+DILGQgkBgbR1UhkiVE4EEWTjl0L4tsbjLKOWsaRjo4
 fCNatIQxnZ1nhDmIYj7lypMhbwxi+PaWNuDJLOk549bZxm3y2FCCiANcE+QdTidr9i/6
 XnOC+G+p795TXFZEuScqQYYUUxr7pNbJtKJLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721150476; x=1721755276;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MGyMyVmIzhmIyGflPh0TCg7mN+PkloIi+2HDCwtcVQo=;
 b=JfIAlis/x+ysNbuybORjfIpg5t+ps6wgspniBjl6Zzy1gb+HxMUt7TgWC3TrOg0Fv6
 DXSDxfTeBU9TKmmj+w5uDMgLkbotxqBlZQBomVzozMqtZPQSCRG8JFiZvc/3eQDF6LNb
 ii8LmOhV3HsywMswHpupkjwOOlCjAX0PzriR5ReqfM36eaoXrp0E08qCmga0TUwTwlj/
 f8LfV3I6RRDmyZBcvfPN9Q31CKoSmpDt2URqBBp+1m283usDQ8ryl+g43IqYxfy5jybE
 t1t291grnZVr7EdQjURBbIZwwIKIae526LwIoYW1l8zjSofTXTXZ1id7sZTnppz30CKa
 YWFQ==
X-Gm-Message-State: AOJu0YySDITWTjXzlokRtWN0OoTPrAdHFVe66lA5hoQIGlslIY4m5Unl
 cEJCVyLM0/mL5wVvkGXs5CO9ZJJ2FnDdeM2WsfDkjPbwV3anr5PDOUSKXKO5HPM=
X-Google-Smtp-Source: AGHT+IHj37u4g4Y90PECLsAqgQr/fY/VzliLASApvJ9b1GXHFnmuvGPmMbhB3yrLaLn/6NwILnJcJw==
X-Received: by 2002:a05:6808:2381:b0:3d5:4256:26d4 with SMTP id
 5614622812f47-3dac7b6102emr3979450b6e.7.1721150476078; 
 Tue, 16 Jul 2024 10:21:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-103-45.totalplay.net.
 [189.203.103.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dabbac0846sm883952b6e.6.2024.07.16.10.21.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jul 2024 10:21:15 -0700 (PDT)
Date: Tue, 16 Jul 2024 11:21:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Walter Lozano <walter.lozano@collabora.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn@collabora.com>,
 Matthias Brugger <mbrugger@suse.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] board: rpi: Update memory layout for Aarch64
Message-ID: <20240716172113.GG561963@bill-the-cat>
References: <20240716171602.2279766-1-walter.lozano@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mm+qeaMBjerzrV+E"
Content-Disposition: inline
In-Reply-To: <20240716171602.2279766-1-walter.lozano@collabora.com>
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


--mm+qeaMBjerzrV+E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 02:16:02PM -0300, Walter Lozano wrote:

> ARM and Aarch64 have different restrictions and trying to accommodate
> larger kernels like the ones used in distros can be challenging. For this
> reason, separate the layout and rearrange the map for Aarch64 to support
> kernels larger than 36 MB.
>=20
> Signed-off-by: Walter Lozano <walter.lozano@collabora.com>
> ---
>=20
>  board/raspberrypi/rpi/rpi.env | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.env
> index 30228285edd..37c7f6a920e 100644
> --- a/board/raspberrypi/rpi/rpi.env
> +++ b/board/raspberrypi/rpi/rpi.env
> @@ -42,13 +42,19 @@ dfu_alt_info+=3DzImage fat 0 1
>   *   For Aarch64, the kernel image is uncompressed and must be loaded at
>   *   text_offset bytes (specified in the header of the Image) into a 2MB
>   *   boundary. The 'booti' command relocates the image if necessary. Lin=
ux uses
> - *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> - *   satisfies all these constraints and reserving memory up to 0x024000=
00
> - *   permits fairly large (roughly 36M) kernels.
> + *   a default text_offset of 0x80000.  However, loading it at 0x80000
> + *   will allow to reserve only up to 0x02400000 which permits medium si=
ze
> + *   kernels (roughly 36M). This is good enough for customized kernels b=
ut
> + *   not for distros which by default enable drivers for many different
> + *   boards. Under these circumstances, using 0x00200000 provides room f=
or
> + *   larger kernels.
>   *
>   * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn't
>   * conflict with something else. Reserving 1M for each of them at
> - * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> + * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty for =
ARM.
> + *
> + *   For Aarch64, since the kernel is placed in different location,
> + *   accommodate them to reserver 1M for each of them.
>   *
>   * On ARM, both the DTB and any possible initrd must be loaded such that=
 they
>   * fit inside the lowmem mapping in Linux. In practice, this usually mea=
ns not
> @@ -62,16 +68,21 @@ dfu_alt_info+=3DzImage fat 0 1
>   * large initrds before they start colliding with U-Boot.
>   */
>  #ifdef CONFIG_ARM64
> +pxefile_addr_r=3D0x00080000
> +scriptaddr=3D0x00100000
> +kernel_addr_r=3D0x00200000
> +fdt_addr_r=3D0x03400000
> +ramdisk_addr_r=3D0x03500000
>  fdt_high=3Dffffffffffffffff
>  initrd_high=3Dffffffffffffffff
>  #else
> -fdt_high=3Dffffffff
> -initrd_high=3Dffffffff
> -#endif
>  kernel_addr_r=3D0x00080000
>  scriptaddr=3D0x02400000
>  pxefile_addr_r=3D0x02500000
>  fdt_addr_r=3D0x02600000
>  ramdisk_addr_r=3D0x02700000
> +fdt_high=3Dffffffff
> +initrd_high=3Dffffffff
> +#endif
> =20
>  boot_targets=3Dmmc usb pxe dhcp

We need to drop the disabling of device tree / initrd relocation as
that's sure not going to help matters. What's the minimum amount of
memory an aarch64 Pi will have? I really prefer reserving 128MiB (even
if that's not the maximum Linux Kernel Image size anymore) and then
device tree and then initrd.

--=20
Tom

--mm+qeaMBjerzrV+E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaWrAIACgkQFHw5/5Y0
tyyWrAv/V45pEHAvR9dKFHlp4DJA25d+BFhs0fNjba8nVwagKLUkG/n6p3igi9qx
enomhIwLLuq7jwWHnjifZ+3inTz8ltMRNrJI1o5Stwlp8uRYQzauEY5yTTNm8ygv
jK0Go2WjCXP+vofSb12PV5AWtbyP21iBBHZhZNYgj0IqPFOgpDKWzo3d25Dj0NoH
q1x+bFxJtiRQWUXHVkvd2PBynvRwC25dtEd4zxGcB0JxDR+7po9nLv98e3v1Cmat
RspE84aqBdXaGV5gDDIbP/6CsKI5CBg0BVNobDB1V+uBTwh46qN+VvnNBqjtd9x7
DqTHgAbYiYeWsaf+a9OTzpwxI4M5xhhTjhU5+dqgJPVEwrXbYFBTHymUF6dviG4Z
5Y3Ql9xfOZyYdVS7V95Bspe79cZWARoOzrx5Lz4M//JBlEAT+W9ZWtZSKDE+IE25
xNY3GMk4BZnJFiNCZ6OF2F0E5hsk1dLeiHp1OoOjeL4CgiisiIb+NUHa89HvCQdp
CwZRT0/b
=NDng
-----END PGP SIGNATURE-----

--mm+qeaMBjerzrV+E--
