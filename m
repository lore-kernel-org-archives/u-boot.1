Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 997BDC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 21:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A0B88F28;
	Mon, 16 Sep 2024 23:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=debian.org header.i=@debian.org header.b="lkkj3CdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5EF788F0B; Mon, 16 Sep 2024 23:05:49 +0200 (CEST)
Received: from cascadia.aikidev.net (cascadia.aikidev.net
 [IPv6:2600:3c01:e000:267:0:a171:de7:c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8960D88B2D
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=vagrant@debian.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=debian.org;
 s=1.vagrant.user; t=1726520745;
 bh=JsGkH37o/rsydOvJVHzSuDMUoDTYFLMaRPyAZODIkD4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=lkkj3CdJG91YYnFRx2eRe0BvlFgk6aN1TjFHj+YngU1pkTU1Eq32tYkmyVFZDkrEj
 Hkq/T/NhRi3XWBhdqSIuRMHU7u+RwwppKLy6b+HBmQ5HQklhW4ZYVKZsioMspzSzhb
 ax8dXBrt6U2FiIVMZ7vbA/5s3Vb4ilZTG/w6Davano0xczzEI3t2ZEFJhTaWxbkW1+
 Y+RGYBxtWzyokMm1nAjv1NUcyQZP6as5IJsKIPMAJWwpjCSElBl1WrsNDjbGGmlutE
 AgUEKeFvEBBTPKEPcowvVXk20liwUha/kp7gJZgCkQfcm+KCHYdIhW61SOtO8JW092
 UvU51e8eb2MWg==
Received: from localhost (unknown [IPv6:2600:3c01:e000:21:7:77:0:50])
 by cascadia.aikidev.net (Postfix) with ESMTPSA id F38B61638;
 Mon, 16 Sep 2024 14:05:44 -0700 (PDT)
From: Vagrant Cascadian <vagrant@debian.org>
To: Herman Rimm <herman@rimm.ee>, 72987@debbugs.gnu.org
Cc: Efraim Flashner <efraim@flashner.co.il>, u-boot@lists.denx.de, Matthias
 Brugger <mbrugger@suse.com>, Peter Robinson <pbrobinson@gmail.com>
Subject: u-boot: rpi: Enlarge space available for kernel.
In-Reply-To: <c56191d9f088cc52844d3cb1c7eec0f413745b2d.1726507300.git.herman@rimm.ee>
References: <20240902190459.13783-1-herman@rimm.ee>
 <c56191d9f088cc52844d3cb1c7eec0f413745b2d.1726507300.git.herman@rimm.ee>
Date: Mon, 16 Sep 2024 14:05:22 -0700
Message-ID: <87jzfbl371.fsf@wireframe>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
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

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 2024-09-16, Herman Rimm wrote:
> --- /dev/null
> +++ b/gnu/packages/patches/u-boot-50M-kernel.patch
> @@ -0,0 +1,51 @@
> +This patch configures the U-Boot for Raspberry Pis to reserve 50 MB for
> +linux kernels, because the 6.9 and newer linux-libre-arm64-generic
> +kernels can be larger than 36 MB.  It was created by Herman Rimm
> +<herman@rimm.ee> in August 2024 and is not submitted upstream yet.
> +diff --git a/board/raspberrypi/rpi/rpi.env b/board/raspberrypi/rpi/rpi.e=
nv
> +index 30228285ed..54a8e9e5ae 100644
> +--- a/board/raspberrypi/rpi/rpi.env
> ++++ b/board/raspberrypi/rpi/rpi.env
> +@@ -43,22 +43,22 @@ dfu_alt_info+=3DzImage fat 0 1
> +  *   text_offset bytes (specified in the header of the Image) into a 2MB
> +  *   boundary. The 'booti' command relocates the image if necessary. Li=
nux uses
> +  *   a default text_offset of 0x80000.  In summary, loading at 0x80000
> +- *   satisfies all these constraints and reserving memory up to 0x02400=
000
> +- *   permits fairly large (roughly 36M) kernels.
> ++ *   satisfies all these constraints and reserving memory up to 0x03400=
000
> ++ *   permits fairly large (roughly 50M) kernels.
> +  *
> +  * scriptaddr and pxefile_addr_r can be pretty much anywhere that doesn=
't
> +  * conflict with something else. Reserving 1M for each of them at
> +- * 0x02400000-0x02500000 and 0x02500000-0x02600000 should be plenty.
> ++ * 0x03200000-0x03300000 and 0x03300000-0x03400000 should be plenty.
> +  *
> +  * On ARM, both the DTB and any possible initrd must be loaded such tha=
t they
> +  * fit inside the lowmem mapping in Linux. In practice, this usually me=
ans not
> +  * more than ~700M away from the start of the kernel image but this num=
ber can
> +  * be larger OR smaller depending on e.g. the 'vmalloc=3DxxxM' command =
line
> +  * parameter given to the kernel. So reserving memory from low to high
> +- * satisfies this constraint again. Reserving 1M at 0x02600000-0x027000=
00 for
> +- * the DTB leaves rest of the free RAM to the initrd starting at 0x0270=
0000.
> ++ * satisfies this constraint again. Reserving 1M at 0x03400000-0x035000=
00 for
> ++ * the DTB leaves rest of the free RAM to the initrd starting at 0x0350=
0000.
> +  * Even with the smallest possible CPU-GPU memory split of the CPU gett=
ing
> +- * only 64M, the remaining 25M starting at 0x02700000 should allow quite
> ++ * only 64M, the remaining 11M starting at 0x03500000 should allow quite
> +  * large initrds before they start colliding with U-Boot.
> +  */
> + #ifdef CONFIG_ARM64
> +@@ -69,9 +69,9 @@ fdt_high=3Dffffffff
> + initrd_high=3Dffffffff
> + #endif
> + kernel_addr_r=3D0x00080000
> +-scriptaddr=3D0x02400000
> +-pxefile_addr_r=3D0x02500000
> +-fdt_addr_r=3D0x02600000
> +-ramdisk_addr_r=3D0x02700000
> ++scriptaddr=3D0x03200000
> ++pxefile_addr_r=3D0x03300000
> ++fdt_addr_r=3D0x03400000
> ++ramdisk_addr_r=3D0x03500000
> +=20
> + boot_targets=3Dmmc usb pxe dhcp

I would really like to hear comments from the upstream u-boot
maintainers on adjusting these values...

live well,
  vagrant

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRlgHNhO/zFx+LkXUXcUY/If5cWqgUCZuidkgAKCRDcUY/If5cW
quPqAP9nLcLkuvtdpf3dyKxkpJQuA9j+odEOJFEWuQNcG1gvBAEA9Yk4uId+n409
4gEcIwaiPYOyQnE0iIT1igum6nxu1AY=
=lRKm
-----END PGP SIGNATURE-----
--=-=-=--
