Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C2EE4993
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 15:40:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8856D8644D;
	Tue, 22 Aug 2023 17:40:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="YDf0+qH7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C5E58645C; Tue, 22 Aug 2023 17:40:25 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B73F86439
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 17:40:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MFeJBL064557;
 Tue, 22 Aug 2023 10:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692718819;
 bh=GCpyA1aVP9CWkRw+NuY5S0u/Dk2XqjdRam0IvNtxTEY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=YDf0+qH77uMmLLvHvBd+XS26Ve8K099P0ghg63XKXyJ07aogf5QJevCodpHGbV+FD
 I0PNJy4c5lnBo/nWm4hKkmQo7cfIW1V3PTS5kCbrOaVHYmYsDT1wpDTeZedzJz2ZV/
 v9dHPIumtJNq9z+7QMAdbxTE07vrvf/6r1FJmnUM=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MFeJrK035476
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 22 Aug 2023 10:40:19 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 10:40:18 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 10:40:18 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MFeIl2095109;
 Tue, 22 Aug 2023 10:40:18 -0500
Date: Tue, 22 Aug 2023 10:40:18 -0500
From: Nishanth Menon <nm@ti.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>
CC: <n-francis@ti.com>, <trini@konsulko.com>, <bb@ti.com>, <praneeth@ti.com>, 
 <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 <vigneshr@ti.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH V3 0/4] board: ti: Add support for BeaglePlay
Message-ID: <20230822154018.tcj6dlec5xanyzbc@overstay>
References: <20230815164440.2713726-1-nm@ti.com> <87ttsrrt1m.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttsrrt1m.fsf@baylibre.com>
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

On 17:33-20230822, Mattijs Korpershoek wrote:
> On mar., août 15, 2023 at 11:44, Nishanth Menon <nm@ti.com> wrote:
> 
> > Add support for BeaglePlay - rev 3
> >
> > Boot log: https://gist.github.com/nmenon/3e99b44380873263e39ba4d84788db89
> >
> > Full series(including dependencies) can be found at:
> > https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3
> >
> > Caveats:
> > * I have kept networking out of picture for now as it is still in debug
> >  (See
> >   https://github.com/nmenon/fix-k3-dt-u-boot/commits/beagleplay-v3-enet-debug
> >   if anyone is interested)
> >
> > Changes since V2:
> > * I have rebased to latest next branch
> >   bdc682437a67 (origin/next) Merge branch '2023-08-14-assorted-general-updates' into next
> > * Uses config fragments by default.
> > * Updated MAINTAINER file as well
> >
> > V2: https://lore.kernel.org/u-boot/20230727234446.3651836-1-nm@ti.com/
> > V1: https://lore.kernel.org/all/20230725185253.2123433-1-nm@ti.com/
> >
> > Nishanth Menon (3):
> >   arm: dts: k3-am625-sk-binman: Add labels for unsigned binary
> >   board: ti: am62x: Add am62x_beagleplay_* defconfigs
> >   doc: board: ti: Add BeaglePlay documentation
> >
> > Robert Nelson (1):
> >   arm: dts: Add k3-am625-beagleplay
> 
> I tried these series on top of next on my beagleplay with the intention of
> booting U-Boot from eMMC.
> 
> Base commit: 7e6e40c57233 ("Merge tag 'v2023.10-rc3' into next")
> 
> I can't get this to boot. Seems to be stuck in the r5 spl.
> 
> Boot log is:
> 
> U-Boot SPL 2023.10-rc3-01591-ga4f9ddf99438 (Aug 22 2023 - 17:11:47 +0200)
> SYSFW ABI: 3.1 (firmware rev 0x0009 '9.0.5--v09.00.05 (Kool Koala)')
> SPL initial stack usage: 13400 bytes
> Trying to boot from MMC1
> mmc_load_image_raw_sector: mmc block read error
> Partition 1 invalid on device 0
> spl_register_fat_device: fat register err - -1
> spl_load_image_fat: error reading image tispl.bin, err - -1
> SPL: failed to boot from all boot devices
> ### ERROR ### Please RESET the board ###
> 
> It seems that when we try to find tispl.bin, we read from the mmc0boot0
> hw partition instead of from the user partition.
> 
> Per my understanding, BeaglePlay has the following (simplified) boot
> flow:

Thanks Mattijs, we have been discussing this in our discord channel, and
I have a new version I am working on. will fix it up and send it later
today - fixing some other pending documentation aspects atm.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
