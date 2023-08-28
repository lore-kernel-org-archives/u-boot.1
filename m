Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E03CC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 13:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B4A58645E;
	Mon, 28 Aug 2023 15:01:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="mdTOUZmU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 158228645F; Mon, 28 Aug 2023 15:01:58 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DD9D863E8
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 15:01:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SD1enM029109;
 Mon, 28 Aug 2023 08:01:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693227700;
 bh=6nMmplO3ioNtWXF2VzvojSFRIft4fmSj4v5gfDf/1X4=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=mdTOUZmU450wD+XpbMjBW9KVuCrmyqEfW8Pd3+Mqs6Vra7viraHlIz33gyaKP115V
 E0sm6l0D5iz+xRv6p87AzQyh/JZIiMnrAfNsCx1FgNPrOeYLWYFY4/cvGcTOx4aQ3i
 8dZN2cdCdngfRp6PrYM/6q0iw0tcWe/5LBY3lrWI=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SD1dab019051
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 08:01:39 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 08:01:39 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 08:01:39 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SD1dnQ042731;
 Mon, 28 Aug 2023 08:01:39 -0500
Date: Mon, 28 Aug 2023 08:01:39 -0500
From: Nishanth Menon <nm@ti.com>
To: Simon Glass <sjg@google.com>
CC: Robert Nelson <robertcnelson@gmail.com>, Neha Francis <n-francis@ti.com>, 
 Tom Rini <trini@konsulko.com>, Bryan <bb@ti.com>,
 Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Vignesh <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Jan Kiszka
 <jan.kiszka@siemens.com>, Heinrich Schuchardt
 <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230828130139.7fw2sqogxnavubpj@unwound>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ2vDyWcpsK8rXFkCZ1EpsFsDta6vN5_dkhrrmU_vfoVUQ@mail.gmail.com>
 <20230825012224.ydk4332yb4qodrdb@unfazed>
 <CAPnjgZ0BFt_jZxnazWSd05PYj79VszpcUQ0De84SVu0GgF6BhA@mail.gmail.com>
 <20230825015931.fkx7jx4sqxdr7cqe@directly>
 <CAPnjgZ1uzjhTPNhfE1NR2Boq-M_kABTrA=19xy0s9nSsXWWU0A@mail.gmail.com>
 <CAOCHtYgObufq4YKNFbn50Xk1VUmF4+_mFid9M9=JHVLwrmvBFw@mail.gmail.com>
 <CAPnjgZ3gnFaSTNnQOaKyVq4THqF+xtraYxDE8wwoYPdCnzhKAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ3gnFaSTNnQOaKyVq4THqF+xtraYxDE8wwoYPdCnzhKAQ@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

On 20:04-20230825, Simon Glass wrote:
> Hi Robert,
> 
> On Fri, 25 Aug 2023 at 19:06, Robert Nelson <robertcnelson@gmail.com> wrote:
> >
> > > > Just https://etcher.balena.io/ and flash an SD card with the official
> > > > image here: https://www.beagleboard.org/distros/beagleplay-debian-11-flasher
> > > >
> > > > https://files.beagle.cc/file/beagleboard-public-2021/images/am625x-emmc-flasher-debian-11.6-xfce-arm64-2023-02-04-10gb.img.xz
> > >
> > > OK I tried that on an SD card, but it is still bricked.
> > >
> >
> > Hi Simon,
> >
> > I've found the bootrom can be a little too quick and you'll get stuck
> > on a failed eMMC bootloader.
> >
> > I find it best, with power applied, if you hold both the USR and RESET
> > buttons down, then lift off the RESET button.. This will ensure the
> > bootrom/sysboot will actually load the microSD's version of u-boot.
> >
> > If it's still failing, please grab this newer small August release:
> >
> > That's posted here:
> > https://forum.beagleboard.org/t/arm64-debian-11-x-bullseye-monthly-snapshots-2023-08-05/32318
> >  (updated monthly)
> >
> > Specifically this flasher file:
> > https://rcn-ee.com/rootfs/release/2023-08-05/bullseye-minimal-arm64/beagleplay-emmc-flasher-debian-11.7-minimal-arm64-2023-08-05-4gb.img.xz
> >
> > Use Balena Etcher to write it directly to a microSD.
> >
> > Insert microSD in
> > Apply Power (leds should turn on, if not hit the PWR button to wake up
> > the TPS...)
> > Next, hold both USR and RESET buttons
> > Now, Lift off only the RESET button
> > When even more leds turn on, lift up on the USR button.
> >
> > At this point the serial should be loading/booting linux, and then
> > running the eMMC flasher in single user mode.  Within 5 minutes or so,
> > it should shutdown with a new image in the eMMC..
> 
> Thank you, that worked!

Thanks Robert, I did not know of that little trick. Once the everything
settles down in master, will patch that little secret into the
documentation as well.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
