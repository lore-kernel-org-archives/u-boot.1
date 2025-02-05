Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B88C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 05:50:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDA6480104;
	Wed,  5 Feb 2025 06:50:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sU9YUIUg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A55A805D7; Wed,  5 Feb 2025 06:50:56 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB0F80087
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 06:50:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 5155olOd3295660
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 4 Feb 2025 23:50:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1738734647;
 bh=dCYx3vQVbKGamxpaRQnYRX6VEKg3A5fwEE/vsllYEbM=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sU9YUIUg9o+kK4JpapOiHk+8ElS0ymKXlz4qokMlP239l0wzeFCAiEAuGuuVqW6My
 452CTFBnREc56k+/62mw/TEkMh7TflaUAhkBf1Nh0zOhgE/Br24eGbdVJlzte7Uncd
 liAHQJ7qXkdjTUUER1BlryFSrtDWz4WRK5Jw9ELQ=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 5155olRm006510
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 4 Feb 2025 23:50:47 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 4
 Feb 2025 23:50:47 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 4 Feb 2025 23:50:46 -0600
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.199])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 5155okpL046295;
 Tue, 4 Feb 2025 23:50:46 -0600
Date: Wed, 5 Feb 2025 11:20:45 +0530
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
Message-ID: <20250205055045.qeam5kvhdlxhow6y@uda0497581>
References: <20250106-b4-upstream-j742s2-v2-0-42d6129ce333@ti.com>
 <20250106-b4-upstream-j742s2-v2-2-42d6129ce333@ti.com>
 <e815500f-e4a0-4deb-ae33-f98ca7021503@ti.com>
 <20250204044332.rte6wrki2i54wqpn@uda0497581>
 <4b1a9385-4a98-4c92-9a55-395f1a0fe8b9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4b1a9385-4a98-4c92-9a55-395f1a0fe8b9@ti.com>
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

On 09:43-20250204, Andrew Davis wrote:
> On 2/3/25 10:43 PM, Manorit Chawdhry wrote:
> > Hi Andrew,
> > 
> > On 14:44-20250203, Andrew Davis wrote:
> > > On 1/6/25 3:34 AM, Manorit Chawdhry wrote:
> > > > From: Neha Malcom Francis <n-francis@ti.com>
> > > > 
> > > > Clean up templatized boot binaries for j784s4 soc. This includes
> > > > modifying the k3-j784s4-binman.dtsi to use SPL_BOARD_DTB,
> > > > BOARD_DESCRIPTION and UBOOT_BOARD_DESCRIPTION from the files that
> > > > include it to further reuse code.
> > > > 
> > > > k3-j784s4-binman.dtsi will contain only templates. Only required boot
> > > > binaries can be built from the templates in the boards' respective
> > > > -u-boot.dtsi file (or k3-<board>-binman.dtsi if it exists). This allows
> > > > clear distinction between the SoC common stuff vs. what is additionally
> > > > needed to boot up a specific board.
> > > > 
> > > > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > > > [ Do it only for j784s4 ]
> > > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > > ---
> > > >    arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 123 +++++++++++++++++++++++++++------
> > > >    arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++----------------------
> > > >    arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  75 ++++++++++++++++++++
> > > >    3 files changed, 206 insertions(+), 108 deletions(-)
> > > > 
> > > > diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > > > index 4a82d2fd222669c4b390d4d877bc15329eab8894..adcd89b18ba9df9c72bf2e0fb0600b2bc7d1658c 100644
> > > > --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > > > +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > > > @@ -1,10 +1,109 @@
> > > >    // SPDX-License-Identifier: GPL-2.0-only
> > > >    /*
> > > > - * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> > > > + * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
> > > >     */
> > > > +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
> > > > +#define BOARD_DESCRIPTION "k3-am69-sk"
> > > > +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
> > > > +
> > > >    #include "k3-j784s4-binman.dtsi"
> > > > +#if defined(CONFIG_CPU_V7R)
> > > > +
> > > > +&binman {
> > > > +	tiboot3-am69-hs {
> > > > +		insert-template = <&tiboot3_j784s4_hs>;
> > > > +		filename = "tiboot3-am69-hs-sk.bin";
> > > 
> > > I think there might be some confusion around the name of this file.
> > > The format is tiboot3-<SYSFW name>-<SYSFW board config>.bin.
> > > 
> > > <SYSFW name> is the name of the SYSFW binary that is packaged
> > > with this file, so should be "j784s4-hs" as this uses:
> > > "ti-fs-firmware-j784s4-hs-enc.bin".
> > > 
> > > <SYSFW board config> is the name of the board configs used.
> > > For both TI EVMs and SK boards there is just one common board config
> > > we use call "evm". Other board vendors can use custom board configs,
> > > take Toradex for example, they have a different board config which they
> > > call "verdin" and they then correctly use that label for their tiboot3
> > > filename[0]. We should follow our own standard, use "evm" here.
> > > 
> > > Andrew
> > > 
> > > [0] https://source.denx.de/u-boot/u-boot/-/blob/master/arch/arm/dts/k3-am625-verdin-wifi-dev-binman.dtsi
> > 
> > The following is not some mistake and an intended change honestly.. we
> > use am69_sk_r5_defconfig as the defconfig name and that giving j784s4 as
> > the binary name is just counterintuitive, the naming should be based on
> > the defconfig IMO to avoid confusions.
> > 
> 
> The binary name does not need to match the marketing name of the board,
> otherwise we could go name u-boot.img to append a board name too, etc.
> 
> tiboot3.bin is different as we can have one build producing the same
> SPL but with different SYSFW blobs appended. To deal with this we
> append the name of the SYSFW blob to the filename. The SYSFW used here
> is named "j784s4-hs", so What happens if we get a new SYSFW blob with the
> name "am69-hs" but you already named this file "tiboot3-am69-hs-sk.bin"
> even though it includes "j784s4-hs" SYSFW not "am69-hs" SYSFW..
> 
> This filename is meant to identify the SYSFW name, not the defconfig
> used. It was already correct, no need to change the standard here.

The standard has existed since we had a single tiboot3.bin packing multiple
DTBs and working on AM69 and J784S4 (And similarly for other devices). At
that time there was no other choice than to use the SYSFW name for
identifying the binary - as what else could we use anyway? 

But now, the binaries aren't compatible with each other packing different
DTBs, and are not the same. The following should've been done during the
time when the defconfigs' were split itself but at that time templating was
still being sorted out so we could'nt even make HS-FS as the default that
time for AM69 ( which is the default device considering AM69 ) - we don't
even make GP and even that was being built for that - doesn't mean it was
the right thing to do.

We should keep the "standard" just because it was historical doesn't
make sense to me. U-boot is an entity and there is no relation
whatsoever to keep the SYSFW name in the tiboot3 when they aren't even
compatible anymore with other changes around - it should rather be based
on what am building "in" U-boot.

I understand if you mean to say that the following is somehow being used
in multiple places and it will have a cascading effect to change it at
this stage but if you are worried about cascading effect; My suggestion
would be to "fix" it now instead as the platforms are getting mature and
then it'd be too late to do it and I don't want seeing
am69_sk_r5_defconfig building tiboot3-j784s4-hs-fs-evm.bin 10 years down
the line...

PS: it's still not too late if you are thinking that given the split for
AM69 happened just a year back and the other such splits have hardly
been there for around 8 months so we haven't even gotten the time to
streamline it.

Regards, 
Manorit

> 
> Andrew
> 
> > Regards,
> > Manorit
