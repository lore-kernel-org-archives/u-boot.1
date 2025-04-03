Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CF9C3600C
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 19:02:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BB1D82140;
	Thu,  3 Apr 2025 21:02:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QZXJRkml";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D498215B; Thu,  3 Apr 2025 21:02:47 +0200 (CEST)
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3983A82139
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 21:02:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3f8ae3ed8f4so651983b6e.3
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 12:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743706964; x=1744311764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LJwPQBQ1YwOiFEEIxHdQbeZFYC8dfjpFsiNZ71mb/zk=;
 b=QZXJRkmlYJNGUTFmWjEVMQzfWhvZJmg0GNMv86N9ohFJ2QBfT8qqO20W7yMulyEiq6
 A5+ApZaf1h8x1xE7eqzuHXDHv3dMkEfew/FYIo3rXlJPVCVYfRuLjqn24oGqyFIEC86a
 7cs/EGm3V2P4Zz+mMTXIcDLGid6LO/1c2WUgs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743706964; x=1744311764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJwPQBQ1YwOiFEEIxHdQbeZFYC8dfjpFsiNZ71mb/zk=;
 b=r692eH0FmOz2qJIq6/0tv9nxXo+LG15ySnsH4ZV3qWljS87OEew9bvPIwa0RR7J0bJ
 F6wBGvp4KPWYPIk66PCH7XrHpM67Kupr9bfskcozQ5hue6rs+EcecjYVuLTUFTBtxhCw
 O5uqBNaiVtJI4ft7rkLoDSa18xr/BmMY0mvC+u5L+wyW0pyOtncaXlP5C2oufsorKu9R
 uThjaI8t8jrJG2Yybmv2fhGiVTvN+NfCAhxaAb2u5Iner80cXspUgtQYepc2+JhM6Hr5
 n6TfoW1FOWyxq7CR0urI3kBSidLFq+bf6vJ6N2XypQJ2ISQzFSsL8VR3C/ks5eXqc63X
 nVQg==
X-Gm-Message-State: AOJu0Yz707ujAFoL7NMIJinMTbexZ7xf4ESPZ8O+p5syaO0sIDI0Y1r+
 ZmGEZLUC+fuLs1AC2n2txoCGDme8oA0wSEcFZI7duMeY48/n+qP7AdvUmzVcQ8Y=
X-Gm-Gg: ASbGncvjIprEmyLzchkHXo5FtMnICuyGGe8gTpqse/TyzArNf0YJY6mMxJ75/njNR9B
 +VdEYMM+8hTjIZUiCdw2QIswf+WIHhExOHhisgWo0Jp7UfUEVvFuT3a363+cUItXf3Tpwj9ywfJ
 +wnkb6G11+2VwjjINbpM77L2HRcY3UPySljLdCBBuW7sn5yYEvKMb+N0majGdxGqPghiLukDutx
 lSDKA/2+jlvQ55toPupXuWJxNqtlAoIchQ2LNHb32S/4dAbbNCBaXU9lpgBToFBj3l9jEQw4nfA
 oOFlyobivVr+mRakbfC+MubzI49djRaBQIOFLy7ymOYNx2ULWrs8YWCKEReJX1hSrmffNS4GcqQ
 HAv49vw==
X-Google-Smtp-Source: AGHT+IHPYj8t89Qgtpb3+yX2OXSDvqDUh4LzOVhSrmsAvOIsafOvG2XtwBCbg2INZgvFobNG1OrmQQ==
X-Received: by 2002:a05:6808:144e:b0:3fa:7909:271f with SMTP id
 5614622812f47-4004558f079mr244085b6e.5.1743706963826; 
 Thu, 03 Apr 2025 12:02:43 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4003ff98f2csm312401b6e.22.2025.04.03.12.02.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 12:02:42 -0700 (PDT)
Date: Thu, 3 Apr 2025 13:02:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>,
 Marek =?iso-8859-1?Q?Moj=EDk?= <marek.mojik@nic.cz>,
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH] fdt: Allow OF_HAS_PRIOR_STAGE to be disabled in defconfig
Message-ID: <20250403190240.GM5495@bill-the-cat>
References: <20250403175408.2211779-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="oTFrrbW9eE0XnABQ"
Content-Disposition: inline
In-Reply-To: <20250403175408.2211779-1-sjg@chromium.org>
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


--oTFrrbW9eE0XnABQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 04, 2025 at 06:53:49AM +1300, Simon Glass wrote:

> At present it is impossible to change the qemu_arm64 defconfig to
> obtain a devicetree from the U-Boot build.
>=20
> This is necessary for FIT validation, for example, where the signature
> node must be compiled into U-Boot.
>=20
> A proposed change to QEMU has been blocked for several years. As a
> workaround, the only option is to use QEMU's dumpdtb option, merge in
> the signature node manually and then disable OF_HAS_PRIOR_STAGE
>=20
> Unfortunately the only way to disable OF_HAS_PRIOR_STAGE at present is
> to hack the Kconfig. So update it to allow use from defconfig. This
> avoids needing to patch U-Boot to get this working.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Link: https://patchwork.kernel.org/project/qemu-devel/patch/2021092618341=
0.256484-1-sjg@chromium.org/#24481799

How about instead we do something like:
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b7311d3b754b..44e45a304cd0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1080,7 +1080,7 @@ config ARCH_QEMU
 	imply DM_RNG
 	imply DM_RTC
 	imply RTC_PL031
-	imply OF_HAS_PRIOR_STAGE if !TARGET_QEMU_ARM_SBSA
+	imply OF_HAS_PRIOR_STAGE if !QEMU_MANUAL_DTB
 	imply VIDEO
 	imply VIDEO_BOCHS
 	imply SYS_WHITE_ON_BLACK
diff --git a/board/emulation/common/Kconfig b/board/emulation/common/Kconfig
index 4c15c8bcb891..9053f2ff2f55 100644
--- a/board/emulation/common/Kconfig
+++ b/board/emulation/common/Kconfig
@@ -13,3 +13,10 @@ config MTDPARTS_NOR1
 	help
 	  This define the partition of nor1 used to build mtparts dynamically
 	  for the u-boot env stored on nor1.
+
+config QEMU_MANUAL_DTB
+	bool "Manually provide a device tree to QEMU"
+	depends on ARCH_QEMU # Expand more if needed
+	help
+	  For some use cases, such as FIT validation of U-Boot itself we need
+	  to override the device tree that QEMU would normally provide to us.

This way we don't start opening asking OF_HAS_PRIOR_STAGE.

--=20
Tom

--oTFrrbW9eE0XnABQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfu20wACgkQFHw5/5Y0
tywkeAv/SLj7QAVBPeNB2CE8A8DGjYCDLQwH/9pv4A5eME36IjSdvM2m7pyOUUUB
zEnStJKcCC1ulqxtygCMcW7XqV8XD4htmo8nBxSV07SVjMPqLoOo5wGIojqSFg6g
7oXL/EJlCOCOavcDoaCYI2xtcYS2G+/DNLdIoG+xJUdKKlNWPIdKzaWNmyMdA/c3
PJpnN2Ni5wOzoV8gQLXVbchiGfDoWJwiqdINeHRvLgfanOo0MytFH7ikJCzWG9+d
788h0nfB3MLHNXi5IpUpGkEzTtbQ+VSKDZTrTu1+IKTS/B5nTAvpFy6a5f9jLXA7
XoVY4Uv4LlGbyD2WzL2Szea1+G8sVs/Ac+LSK7J6yu+FLzy0z26Bx2R/FX0kk6aR
X45p23VzcuD5RvkMd8DV9JPxg+17vYyYttDfQl11qIqoK0j8qiHu405Dx0p9buKY
ddkvAqtthsF5GzOLvgeBRTTe4nCmc0vsm1ITuLZPhqR+CymRm194DheLS08hbsav
qnZzVnmh
=s5zI
-----END PGP SIGNATURE-----

--oTFrrbW9eE0XnABQ--
