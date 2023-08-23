Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28BCDEE4993
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 16:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F6328648B;
	Wed, 23 Aug 2023 18:44:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Uk4CcSzo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F11286478; Wed, 23 Aug 2023 18:44:28 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFE3286467
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 18:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37NGiIGB053954;
 Wed, 23 Aug 2023 11:44:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1692809058;
 bh=GXeYSRs38onNwnT/HIaXt+HuQ+6UB9UXPoGnjvIBWR4=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=Uk4CcSzoPnDzrtXiYzJwJCLE4LsEQaf6JIc6M6dg8orlwabE7f2VPU93mEBh9qU/I
 7TMheLdnjMQqMpX3FK6/EeFGolTJE8l13k6hLDjeVGNDWP8avG75hdNDDvjjE/Ov0W
 5uBZcGLDgAUlRnzhEzdfUkCJCtzWmuwxemTpW+pE=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37NGiIi4032342
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Aug 2023 11:44:18 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 23
 Aug 2023 11:44:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 23 Aug 2023 11:44:18 -0500
Received: from [10.250.38.120] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37NGiHE4025144;
 Wed, 23 Aug 2023 11:44:17 -0500
Message-ID: <bba71d2b-09f9-6715-535e-da8275d22628@ti.com>
Date: Wed, 23 Aug 2023 11:44:17 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: Config fragments
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Neha Francis <n-francis@ti.com>, Bryan
 <bb@ti.com>, Praneeth <praneeth@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Jan Kiszka <jan.kiszka@siemens.com>, Nishanth
 Menon <nm@ti.com>, Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
References: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <CAPnjgZ14CUVt=rM943hh9PQUhK9LJDgZYPxUsATYQe3wwOUYqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/23/23 10:30 AM, Simon Glass wrote:
> Hi,
> 
> Up until 2023.04 it has been possible to build all the defconfigs but
> with 2023.07 that changed. Tom mentioned this to me recently.
> 
> Up until 2023.04 we can enumerate all the board configs that can be
> built. We can build any of them using a single name and a single
> defconfig. The boards.cfg file which buildman creates contains a full
> list of things that can be built.
> 
>  From 2023.07 this changes and we now have random .config files
> sprinkled about the place. I say random because they are not connected
> to anything. For example, here is
> board/ti/am62x/MAINTAINERS:
> 
> AM62x BOARD
> M: Dave Gerlach <d-gerlach@ti.com>
> M: Tom Rini <trini@konsulko.com>
> S: Maintained
> F: board/ti/am62x/
> F: include/configs/am62x_evm.h
> F: configs/am62x_evm_r5_defconfig
> F: configs/am62x_evm_a53_defconfig
> 
> BEAGLEPLAY BOARD
> M:     Nishanth Menon <nm@ti.com>
> M:     Robert Nelson <robertcnelson@gmail.com>
> M:     Tom Rini <trini@konsulko.com>
> S:     Maintained
> N:     beagleplay
> 
> In most cases the MAINTAINERS file tells us about each board and until
> [1] I had assumed that was the case. With that patch reverted, these
> are the only 'orphaned' MAINTAINERS entries (buildman
> --maintainer-check):
> 
> WARNING: orphaned defconfig in board/armltd/vexpress64/MAINTAINERS
> ending at line 8
> WARNING: orphaned defconfig in board/google/veyron/MAINTAINERS ending at line 44
> WARNING: orphaned defconfig in
> board/mikrotik/crs3xx-98dx3236/MAINTAINERS ending at line 7
> WARNING: orphaned defconfig in board/st/common/MAINTAINERS ending at line 6
> WARNING: orphaned defconfig in board/ti/am62x/MAINTAINERS ending at line 15
> 
> But Tom advised me that MAINTAINERS is not intended for this purpose,
> so the check has been dropped. I am not suggesting we bring it back,
> necessarily, but if we did, we could use it to specify the .config and
> defconfig files which are used by each board.
> 
> *Failing that*, I suggest a new 'name.brd' file in the board directory
> to contain this information, e.g.
> 
> # Contents of board/ti/am62x/beagleplay.brd:
> beagleplay-r5: am62x_evm_r5_defconfig beagleplay_r5.config
> beagleplay-a53: am62x_evm_a53_defconfig beagleplay_a53.config
> 
> This could be parsed by buildman and other tools, to produce a list of
> available boards and to build each using a single name (e.g. make
> beagleplay-r5_defconfig)
> 
> What do people think?
> 

How about instead of needing this new 'name.brd' files, we look into
"include" directives inside these configs? So we could have a file:

beagleplay_r5_defconfig

in the normal configs/ directory, but with the contents:

#include "configs/am62x_evm_r5_defconfig"

CONFIG_DEFAULT_DEVICE_TREE="k3-am625-beagleplay"
CONFIG_OF_LIST="k3-am625-beagleplay"
...

The # is already a comment line so these should be safe
for existing tools, and then we have in our Makefile
an automatic pass through the C preprocessor.

Some boards have can build with and without the fragments,
so to have complete CI coverage, we have dummy defconfigs
that have both the base and a fragment include:

#include "configs/am62x_evm_r5_defconfig"
#include "board/ti/am62x/high_security.config"

Something like that, then as Heinrich mentioned, simply
enumerating configs/*defconfig should yield all valid
combinations for building/testing.

Andrew

> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230803185144.1760729-2-sjg@chromium.org/
