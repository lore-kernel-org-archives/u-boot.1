Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BECC5DF9D
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 16:55:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4FE5860650;
	Mon, 24 Aug 2026 16:55:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdcMLZoLbILc; Mon, 24 Aug 2026 16:55:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787590545;
	bh=uwLtuyHflchK9pFDoX7suLItksKpnp6ikxFbPjOopeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rijHgO3kqH5/HOap/oc5xvKs+GKZvzBGT6y3FbpdBOI7K+0LycPsBK9nFzwU7keF0
	 huLYai/jGE/LLi7lmyeIq9zfPo2BEyFZDkVLVGpZ313+gWDOwKSZNnvo2wtBv8MdeC
	 9Eeqz4WVVZYKEKA/TCmVEKvijNP6EXpiqhLvHGghp/RmBUHyHYOF91qL3mrO4aVGrT
	 RGHiB9DRURZh3LyupR0qRdCaxScZLFxlUQZlDTDCng/bhn4SS5RlA+Xlfp6ymHPJoi
	 kohzlZWwDtWcGiZirQhxJHsSvJP4NNlIrSvcU0fVbVauzkSUlL7mKK6ESIdd08WFJj
	 v7WW3Ve/TO91A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 25E5860618;
	Mon, 24 Aug 2026 16:55:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 728E034E
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:55:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6401D60618
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:55:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VkO-2jCQEiHW for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 16:55:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::9;
 helo=mail-oi2-x09.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=mYk7h1nR
Received: from mail-oi2-x09.google.com (mail-oi2-x09.google.com
 [IPv6:2607:f8b0:4864:32::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B12860606
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 16:55:42 +0000 (UTC)
Received: by mail-oi2-x09.google.com with SMTP id
 46e09a7af769-7e9f37a2160so1276388a34.0
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787590541; x=1788195341;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=uwLtuyHflchK9pFDoX7suLItksKpnp6ikxFbPjOopeE=;
 b=mYk7h1nRwH/zAXQR0T+zxOxhA8b92Hgecv0P3G/Z/jFBLuv3esP1aIU9AX6m9j2hOG
 p+jzKimLS9AW5cHu78fg3yXjT+wgiMajUO9BCK2v3W9kRnsH+jAoVpKUY81RnUrT9JpJ
 Tpg0jj0jyom1dzYiFnITbO4VdUJRSdtXunEag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590541; x=1788195341;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uwLtuyHflchK9pFDoX7suLItksKpnp6ikxFbPjOopeE=;
 b=N6CK6NGG4QsTHm4c8XTRwwKcxMnHCNTObRWB4bS0P0II2uh8qM1w/DvmkSM23yFzEL
 ULFqNBQxxIzO4+LVC9ItzQjUrb4HXUTOMTkLpl+iivfQz4Xm4y09DcSgeT/6QEIdNpDT
 os/dY+RIs7e1amuzUBRmvQusX4eodKveP9LMZK3xWfuC0oz8iGOTbjEp7TBnGD8jdNCg
 +0m+xWP1/tiL/2wtlv6VA89lH+hPI5VZJ0yd08ANSG7NLa+wcHSfRe05kiGAd0KUx/D4
 6W/PkVHHDJ2/oKCMNSL8C/nA5ZJwvMF3WmiIyDQI0qYAnHkLxJ9PfZb1X55o7M7UvYFG
 Ywew==
X-Forwarded-Encrypted: i=1;
 AHgh+RoSh52kU3a54c9oSPIjSs1RYtLuYtaZTHWCwv2aAjX7lhU9YfZAfecqLsoC9TWiURSpJ6f6i8s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++laURCZelTtfmcbl0iAQx0i0M3A0I4kW48yZpjNKTKw4aI7A1Ub
 0+jOWUzRK2z4/PKbGq3JrJcSxW4yttCDs68Fs0p7s2tckq8v7wkRIF3GWH2lU0NZN0I=
X-Gm-Gg: AR+sD12nFQ0nmOk9L4BakhkR8g4xcKSqfhYhSTALojeIc6vALQTXsOZn306AifR15MU
 8i49XRNXT+q9K2DYXM4JXp1zJrnZJrig3Umf6VT48Ky+XliTgKyx5BhicmHOuM4YKP0o40UxVM6
 siut8ubMstWjDtNJ5WKCjv+jAke2ByrRwb6CAOpPE+9kFNh7Xz6vZLXU90uZI8LOsiE0GdpABTI
 lEYnJnKVA+rHykCTx8wddm83yffTo2R3fFV84bt/iC4VvCx3Yge21WdhvLnb3O1PW7z59Gh5ruA
 +UfNpge5BatFtTHOj1EYpJlugxddi/FiQWcfWmFGZCjFS6Sm9dL5s0oXe5pIYYswdt1BIFsmVGj
 s/DR3UOklnkHmcjy+G4moR0zZ6YPTMCIN0FEHX7HYj+0b7x6v45YWvyZjq4YDoEjrAdon1CqKr3
 uesLkbt9y+uWkdtbkSN98k+BRQ9B8DMwGq3C/nRxfekgnsW7YUKS4ddJ9NCG+M0HLnYhChBcj8k
 COpDyiKwusbeNY0Um9IaH6naRwApDhnm6cSX6rTK+K6HlJnud24wcBtydv/y8X792welf2Rah46
 A/kjJKUqMQ==
X-Received: by 2002:a05:6830:82a6:b0:7e6:f7fb:967f with SMTP id
 46e09a7af769-7f47636d8f1mr21914402a34.2.1787590541443; 
 Mon, 24 Aug 2026 09:55:41 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f48fc500f6sm5637143a34.15.2026.08.24.09.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:55:40 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:55:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <u-boot@0leil.net>
Cc: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH 2/6] rockchip: rk3506: Update ENV_MEM_LAYOUT_SETTINGS
Message-ID: <20260824165538.GJ523975@bill-the-cat>
References: <20260803190946.2259514-1-jonas@kwiboo.se>
 <20260803190946.2259514-3-jonas@kwiboo.se>
 <574bc6fa-8469-417c-9418-023d1bd0eb29@0leil.net>
 <363bae8f-de1b-4e74-b6f9-de35efc7e119@kwiboo.se>
 <19ba2ba9-57d9-40a5-b75b-69f3a63261d7@0leil.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4W3pqwiPxymuL3BI"
Content-Disposition: inline
In-Reply-To: <19ba2ba9-57d9-40a5-b75b-69f3a63261d7@0leil.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--4W3pqwiPxymuL3BI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 04:31:29PM +0200, Quentin Schulz wrote:
> Hi Jonas,
>=20
> On 8/13/26 11:09 AM, Jonas Karlman wrote:
> > Hi Quentin,
> >=20
> > On 8/12/2026 11:49 AM, Quentin Schulz wrote:
> > > Hi Jonas,
> > >=20
> > > On 8/3/26 9:09 PM, Jonas Karlman wrote:
> > > > The RK3506G1 has 64 MiB integrated DDR2, the RK3506G2 has 128 MiB
> > > > integrated DDR3 and the RK3506B support external memory up to 1 GiB.
> > > >=20
> > > > Current memory layout cause issues using compressed kernels or ramd=
isk
> > > > due to the default load addresses being used.
> > > >=20
> > >=20
> > > RK3506 is an Aarch32 SoC, and Linux kernels on that architecture are
> > > self-decompressing, U-Boot doesn't do anything with compressed kernel=
s.
> > > You can see that kernel_comp_addr_r is only ever used in cmd/booti.c
> > > which depends on ARM64 to be actually built.
> > >=20
> > > I simply recommend getting rid of this variable as it's quite
> > > misleading. All other Aarch32 Rockchip SoCs we support don't seem to =
be
> > > setting this variable, so no additional cleanup to do.
> > > Same for kernel_comp_size.
> >=20
> > Thanks for looking deeper, I will drop these two in v2.
> >=20
> > >=20
> > > > Change the default load addresses to also work on SoC variants with
> > > > limited memory, keep all default addresses in the 0-64 MiB range.
> > > >=20
> > > > 			 old		 new
> > > >     scriptaddr		5 MiB		2 MiB
> > > >     pxefile_addr_r	6 MiB		1 MiB
> > > >     kernel_addr_r		32.5 MiB	8 MiB
> > > >     kernel_comp_addr_r	128 MiB		48 MiB
> > > >     fdt_addr_r		30.5 MiB	4 MiB
> > > >     fdtoverlay_addr_r	31.5 MiB	6 MiB
> > > >     ramdisk_addr_r	96 MiB		48 MiB
> > >=20
> > > That leaves less than 18MiB for an initramfs (don't forget U-Boot pro=
per
> > > is located at the end of the DRAM as far as I remember), which is very
> > > little.
> > >=20
> > > Do we really need 2MiB for the DTB and DTBO? 1MiB ought to be enough =
for
> > > the DTB and I'm sure less than 1MiB ought to be enough per overlay
> > > (overlay are loaded and applied one after the other). This should free
> > > an additional 2MiB for either the kernel or initramfs.
> >=20
> > Agree, I thought I had seen DTB may need to use a 4 MiB aligned address,
> > e.g. for RISC-V, but ARM seem to only need it to be any 64-bit aligned
> > address.
> >=20
>=20
> 8-byte alignment is required by the Device Tree spec, c.f. https://device=
tree-specification.readthedocs.io/en/latest/chapter5-flattened-format.html#=
alignment
>=20
> > >=20
> > > The multi_v5_defconfig and multi_v7_defconfig zImage kernels as built=
 by
> > > KernelCI are respectively 7.5 and 11.6MiB as of yesterday, c.f.
> > > https://dashboard.kernelci.org/build/maestro%3A6a7b3f4762f33761c0aedc=
06
> > > https://dashboard.kernelci.org/build/maestro%3A6a7b3f6562f33761c0aedc=
2f
> > > So maybe we can reserve a bit less than 40MiB for the kernel? But may=
be
> > > kernel_addr_r is also used for FIT images which may be much bigger th=
an
> > > the size of the kernel alone? The load/entry properties are required =
for
> > > images of type kernel according to the FIT spec so that part isn't
> > > something we need to deal with.
> >=20
> > My local Rockchip ARMv7 kernel without loadable module support is now
> > around 26M for Image and 9.9M for zImage, it used to be just below 32M
> > for Image when I also enabled more debugging options and partial support
> > for other SoCs. So support for up to 32M uncompressed would be nice :-)
> >=20
>=20
> What's the benefit of using an uncompressed image in your workflow?
>=20
> > I have made some minor adjustments, see below, that seem to work to boot
> > into a minimal initramfs busybox rootfs in my lab.
> >=20
> > Looking closer at ARM kernel booting, I can see that during
> > decompression the kernel will be decompressed to close to start of DRAM,
> > and if the compressed and decompressed images overlaps the compressed
> > image will be copied to end of the target uncompressed image before it
> > continues.
> >=20
>=20
> See
> https://people.kernel.org/linusw/how-the-arm32-linux-kernel-decompresses.
> "Close to start of DRAM" depends on TEXT_OFFSET of the kernel I think.
>=20
> > U-Boot also tries to move ramdisk and FDT to end of memory to reduce the
> > chance of the kernel decompression to overwrite FDT or ramdisk.
> >=20
>=20
> Unless initrd_high and fdt_high are set I believe?

And setting those in your default environment in tree gets me very
cranky because it often ends up breaking users in unexpected ways (for
example, yes, you put things in non-overlapping correctly aligned
places, but some other user that just picked up the board didn't know
and loaded some FIT image and ... now it blows up. And this is based on
history of that happening).

--=20
Tom

--4W3pqwiPxymuL3BI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaox3igAKCRAr4qD1Cr/k
CiCPAQCrA3j+AQJ+HUwqGdbELLsmKK3UDowK4phn4qgx6b6HfQD+NWOG8IdMkUwx
q1wFt/TwZJcx0NJeKzvk5wwb0BlqHAI=
=oOSV
-----END PGP SIGNATURE-----

--4W3pqwiPxymuL3BI--
