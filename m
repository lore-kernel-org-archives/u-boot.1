Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CA8BC47258
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 15:06:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BF1B879A3;
	Fri, 12 Jan 2024 16:06:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="sCLSgwrK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E3458798C; Fri, 12 Jan 2024 16:06:06 +0100 (CET)
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com
 [46.235.227.194])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B96879AB
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 16:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sjoerd@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1705071963;
 bh=e2ufEElpb4PjjTXRu2FSEthDXyWAqYCAoFfOpXyMyoU=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=sCLSgwrKq4iyg1Ng3lWjiqwvkRrV6Hh1chlaQ9LTxTfkHz+uob5Hh9qrvPyn4QT5p
 cK3mKWb2kmM7CKrlR6UhH7KCy3+1wVmIkxzDaRXWw/ffeJ0h7ybn/BoxWP2ofqHsfx
 PHr08XCQc2kSjypBaNhkq2lbWsFHRciRbqJo6LHylLUM0ysfVve/jwqIdooo5frXtb
 EISDaKWoO0tdu/42eblIQLrTKyfjosOQ7+edihqQfuSiWVYFedYoFtLWyPVT09s9J7
 LzBqA4wnZk7loSqDq2iCCpt4SfDV39lTCtV7ZuFQO4DezGVjtLSFXcCYUD5XOZhEiO
 UOGbNMKoneOfA==
Received: from beast.luon.net (cola.collaboradmins.com [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: sjoerd)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 89AEF3781FED;
 Fri, 12 Jan 2024 15:06:03 +0000 (UTC)
Received: by beast.luon.net (Postfix, from userid 1000)
 id 1BA7B9F0C86C; Fri, 12 Jan 2024 16:06:03 +0100 (CET)
Message-ID: <2bf954654a89c9e939dc27dca772fe57ea0077bf.camel@collabora.com>
Subject: Re: [PATCH v4 5/7] configs: am62x_evm_*: Enable USB and DFU support
From: Sjoerd Simons <sjoerd@collabora.com>
To: Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Martyn Welch <martyn.welch@collabora.com>, Roger
 Quadros <rogerq@kernel.org>, Andrew Davis <afd@ti.com>, Dave Gerlach
 <d-gerlach@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>
Date: Fri, 12 Jan 2024 16:06:02 +0100
In-Reply-To: <20240112131913.s6tc7wqgvjmflxpy@lyrically>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-6-sjoerd@collabora.com>
 <20240112123738.v76kpf6bfngtc2kr@zigzagged>
 <a1553b40223d017dc6cc03f35be9b8e07f813b0b.camel@collabora.com>
 <20240112131913.s6tc7wqgvjmflxpy@lyrically>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
MIME-Version: 1.0
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

On Fri, 2024-01-12 at 07:19 -0600, Nishanth Menon wrote:
> On 14:09-20240112, Sjoerd Simons wrote:
> [...]
>=20
> > > > diff --git a/configs/am62x_evm_a53_defconfig
> > > > b/configs/am62x_evm_a53_defconfig
> > > > index aa96c1b3125..f335eb11e63 100644
> > > > --- a/configs/am62x_evm_a53_defconfig
> > > > +++ b/configs/am62x_evm_a53_defconfig
> > >=20
> > > Should we make the a53 also a defconfig fragment allowing reuse
> > > across
> > > multiple boards?
> >=20
> > Pros and cons. having all the various options (USB boot, ETH boot,
> > misc
> > other) as fragments would allow easier re-use but make it more
> > complicated for the end-user to get a "full-featured" u-boot.=C2=A0
> >=20
> > My personal preference, as i'm coming with a distribution
> > background,
> > is to always enable as much as possible in a default build to allow
> > maximum flexibility for end-users; Those that need
> > space/performance/whatever optimisation can always do custom
> > builds.
> >=20
> > It would be great if we could have a level of indirection here
> > where by
> > default a set of fragments get included such that it's invisible to
> > the
> > end-user that the underlying config is actually quite modular. But
> > I
> > don't think that's currently possible, hence preferring a fat
> > defconfig
> > such that the user/distro can just do `make
> > am62x_evm_a53_defconfig`
> > (and similar for beagleplay)
> >=20
>=20
> I understand, but I am looking to reduce duplication between boards
> and making it easier for new board devs to be able to pick the
> feature
> group they need - almost all am62x users who desire dfu on a53 will
> need the same options enabled. This also keeps the default u-boot
> foot
> print lower to allow for emmc boot0 partition limitations if any (I
> removed that dependency on beagle by using uda, but other platforms
> still keep u-boot in emmc boot0 and depending on the part and TEE
> binary size, the available space can be constraining)

Fwiw just testing; for the SK board the difference in size for
tispl.bin and u-boot.img is about 200 kilobytes with this extra config.
=C2=A0
The SK board i have has about 32 megabytes for the hardware boot
partition so unlikely an issue there; For the beagleplay it seems to be
only 4M, but that's currently already on UDA indeed so shouldn't matter
there.

Mind i agree with you in general; and i was looking at moving the full
u-boot into the hw boot partition on beagleplay already so the OS i
flash doesn't have to be device specific.

>=20
> I am starting to wonder if
> https://lore.kernel.org/u-boot/20231101170519.39627-1-afd@ti.com/
> will help us here.

Yes absolutely that would be perfect. Can i suggest we land it as is
for now ("fat monolithic config") and once those patches land i'm happy
to split things up?=20


--=20
Sjoerd Simons
Collabora Ltd.
