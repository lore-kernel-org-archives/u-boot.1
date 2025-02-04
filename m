Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DDBCC0218F
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 04:43:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1386A800CF;
	Tue,  4 Feb 2025 05:43:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="bocD2qiC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6468280104; Tue,  4 Feb 2025 05:43:46 +0100 (CET)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A898A800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 05:43:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5144hYsI2330110
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 3 Feb 2025 22:43:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738644214;
 bh=NT59ilpgv0VnRzfu4iavA4X6/LKsjCvbuQLQFwjNvo0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=bocD2qiC/qSyvSf9vPMnijx/Hzyq4W5aivSCJNqDbRoZEQ5a+0UdYxNagm4TqIt1p
 8O2BPxDmM5i2FCa50y8HJix8FyAmLJEYEsFN2/bSKlmMroHhHogxmS7bujWPtvGqok
 R38OZKRxQEvntsifI7cyjxa+pjX8jlPMJOHLJdFU=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5144hYj2123890
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 3 Feb 2025 22:43:34 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Feb 2025 22:43:34 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Feb 2025 22:43:34 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5144hXML113513;
 Mon, 3 Feb 2025 22:43:34 -0600
Date: Tue, 4 Feb 2025 10:13:32 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH RFC v2 2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and
 templatize boot binaries
Message-ID: <20250204044332.rte6wrki2i54wqpn@uda0497581>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
 <20250106-b4-upstream-j742s2-v2-2-42d6129ce333@ti.com>
 <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Andrew,

On 14:44-20250203, Andrew Davis wrote:
> On 1/6/25 3:34 AM, Manorit Chawdhry wrote:
> > From: Neha Malcom Francis <n-francis@ti.com>
> > 
> > Clean up templatized boot binaries for j784s4 soc. This includes
> > modifying the k3-j784s4-binman.dtsi to use SPL_BOARD_DTB,
> > BOARD_DESCRIPTION and UBOOT_BOARD_DESCRIPTION from the files that
> > include it to further reuse code.
> > 
> > k3-j784s4-binman.dtsi will contain only templates. Only required boot
> > binaries can be built from the templates in the boards' respective
> > -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> > clear distinction between the SoC common stuff vs. what is additionally
> > needed to boot up a specific board.
> > 
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > [ Do it only for j784s4 ]
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
> >   arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 123 +++++++++++++++++++++++++++------
> >   arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++----------------------
> >   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  75 ++++++++++++++++++++
> >   3 files changed, 206 insertions(+), 108 deletions(-)
> > 
> > diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > index 4a82d2fd222669c4b390d4d877bc15329eab8894..adcd89b18ba9df9c72bf2e0fb0600b2bc7d1658c 100644
> > --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > @@ -1,10 +1,109 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> > - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> >    */
> > +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
> > +#define BOARD_DESCRIPTION "k3-am69-sk"
> > +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
> > +
> >   #include "k3-j784s4-binman.dtsi"
> > +#if defined(CONFIG_CPU_V7R)
> > +
> > +&binman {
> > +	tiboot3-am69-hs {
> > +		insert-template = <&tiboot3_j784s4_hs>;
> > +		filename = "tiboot3-am69-hs-sk.bin";
> 
> I think there might be some confusion around the name of this file.
> The format is tiboot3-<SYSFW name>-<SYSFW board config>.bin.
> 
> <SYSFW name> is the name of the SYSFW binary that is packaged
> with this file, so should be "j784s4-hs" as this uses:
> "ti-fs-firmware-j784s4-hs-enc.bin".
> 
> <SYSFW board config> is the name of the board configs used.
> For both TI EVMs and SK boards there is just one common board config
> we use call "evm". Other board vendors can use custom board configs,
> take Toradex for example, they have a different board config which they
> call "verdin" and they then correctly use that label for their tiboot3
> filename[0]. We should follow our own standard, use "evm" here.
> 
> Andrew
> 
> [0] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi

The following is not some mistake and an intended change honestly.. we
use am69_sk_r5_defconfig as the defconfig name and that giving j784s4 as
the binary name is just counterintuitive, the naming should be based on
the defconfig IMO to avoid confusions.

Regards,
Manorit
