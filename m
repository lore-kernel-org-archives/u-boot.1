Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C0C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 11:00:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF4B088939;
	Tue, 16 Jul 2024 13:00:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E888887A; Tue, 16 Jul 2024 13:00:09 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7737288977
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 13:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 46GAxevF081357
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
 Tue, 16 Jul 2024 18:59:40 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS34.andestech.com (10.0.1.134)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 16 Jul
 2024 18:59:40 +0800
Date: Tue, 16 Jul 2024 18:59:37 +0800
From: Leo Liang <ycliang@andestech.com>
To: E Shattow <lucent@gmail.com>
CC: Bo Gan <ganboing@gmail.com>, Hal Feng <hal.feng@starfivetech.com>,
 "rick@andestech.com" <rick@andestech.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "yanhong.wang@starfivetech.com"
 <yanhong.wang@starfivetech.com>, Minda Chen <minda.chen@starfivetech.com>,
 "duwe@suse.de" <duwe@suse.de>,
 "namcao@linutronix.de" <namcao@linutronix.de>,
 Xingyu Wu <xingyu.wu@starfivetech.com>, Mason Huo
 <mason.huo@starfivetech.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH] riscv: dts: jh7110: Enable PLL node in SPL
Message-ID: <ZpZSmdrst4z_Q4JQ@swlinux02>
References: <1709694011-683-1-git-send-email-ganboing@gmail.com>
 <ZQ2PR01MB13079F11D2A7B2A20968F4FDE62BA@ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn>
 <CANV2PTMPrQVZhWvNFxi8-RA0ZC4UAF1sHBbHiipUc01aWx6oqg@mail.gmail.com>
 <0eda64cb-4ca8-f8bc-7515-6d2a2d3d4638@gmail.com>
 <CANV2PTP3o1Q2JPCZO8Ewfye+oz9f3TVNTYhYZ3EAKtdYAhvkHg@mail.gmail.com>
 <f355e582-cb52-e4c5-538b-26bcf69f0a2c@gmail.com>
 <CANV2PTOzgyzYSbNRJXuvLnMDAT-mDL8o1tU7d72qTKQDMdt_Uw@mail.gmail.com>
 <CANV2PTP2hpd5m17+_T7zp2V6w03d=0rgAuwukyC0LHVYxLtRuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANV2PTP2hpd5m17+_T7zp2V6w03d=0rgAuwukyC0LHVYxLtRuw@mail.gmail.com>
User-Agent: Mutt/2.2.10 (e0e92c31) (2023-03-25)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 46GAxevF081357
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

On Thu, Jul 11, 2024 at 12:55:05PM -0700, E Shattow wrote:
> [EXTERNAL MAIL]
> 
> Ping. This regression still exists and is now in stable release.
> Should we revert this change or how must it be fixed?
> 
> -E
> 

Hi all,

I think I could revert this commit for now 
if we cannot find the root cause and solution right away.

Best regards,
Leo

> On Sat, Apr 20, 2024 at 3:56 AM E Shattow <lucent@gmail.com> wrote:
> >
> > On Fri, Apr 19, 2024 at 5:51 PM Bo Gan <ganboing@gmail.com> wrote:
> > >
> > ...snip...
> > >
> > > If without the change (reverted), can you read/write the same SD media in U-boot
> > > proper? (U-boot proper will switch BUS_ROOT to PLL2).
> >
> > I tested again this change in commit e6b7aeef, before this change in
> > parent commit e6b7aeef~, af04f37a HEAD from today 19th Apr 2024 (which
> > due to not matching EEPROM product_id will be in the fall-through case
> > of board/starfive/visionfive2/spl.c), af04f37a with applied patchset
> > "board: starfive: add Milk-V Mars CM support" from 15th Apr 2024, and
> > af04f37a reverting changes from e6b7aeef also with applied patchset
> > "board: starfive: add Milk-V Mars CM support" from 15th Apr 2024.
> >
> > In all builds is OpenSBI at commit d4d2582e HEAD from today 19 Apr 2024.
> >
> > For each build tested per vendor Milk-V the Mars CM Lite (SD Card only
> > non-eMMC) has pinmux of GPIO22 instead of GPIO62:
> >
> > -- a/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > +++ b/arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> > @@ -233,7 +233,7 @@
> >
> >         mmc0_pins: mmc0-pins {
> >                  mmc0-pins-rest {
> > -                       pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
> > +                       pinmux = <GPIOMUX(22, GPOUT_SYS_SDIO0_RST,
> >                                               GPOEN_ENABLE, GPI_NONE)>;
> >                         bias-pull-up;
> >                         drive-strength = <12>;
> >
> > U-Boot config is simply starfive_visionfive2_defconfig.
> >
> > Results are as follows.
> >
> > StarFive # mac
> > --------EEPROM INFO--------
> > Vendor : MILK-V
> > Product full SN: MARC-V10-2340-D004E000-000006DF
> > data version: 0x2
> > PCB revision: 0xc1
> > BOM revision: A
> > Ethernet MAC0 address: 6c:cf:39:00:83:11
> > Ethernet MAC1 address: 6c:cf:39:00:83:12
> > --------EEPROM INFO--------
> >
> > e6b7aeef: 2GB microSD (no speed class markings)
> > af04f37a: 2GB microSD (no speed class markings)
> > af04f37a with Mars CM patchset: 2GB microSD (no speed class markings)
> > StarFive # mmc rescan ; mmc info
> > unable to select a mode
> > unable to select a mode
> >
> > e6b7aeef~: 2GB microSD (no speed class markings)
> > af04f37a revert e6b7aeef with Mars CM patchset: 2GB microSD (no speed
> > class markings)
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 1c
> > OEM: 5356
> > Name: USD
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 2.0
> > High Capacity: No
> > Capacity: 1.9 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > e6b7aeef: 8GB microSD Class 4
> > e6b7aeef~: 8GB microSD Class 4
> > af04f37a: 8GB microSD Class 4
> > af04f37a with Mars CM patchset: 8GB microSD Class 4
> > af04f37a revert e6b7aeef with Mars CM patchset: 8GB microSD Class 4
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 2
> > OEM: 544d
> > Name: SA08G
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 7.4 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > e6b7aeef: 8GB microSD Class 10
> > e6b7aeef~: 8GB microSD Class 10
> > af04f37a: 8GB microSD Class 10
> > af04f37a with Mars CM patchset: 8GB microSD Class 10
> > af04f37a revert e6b7aeef with Mars CM patchset: 8GB microSD Class 10
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 74
> > OEM: 4a60
> > Name: USD
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 7.5 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > e6b7aeef: 32GB microSD Class 10 A1 U1 HC1
> > e6b7aeef~: 32GB microSD Class 10 A1 U1 HC1
> > af04f37a: 32GB microSD Class 10 A1 U1 HC1
> > af04f37a with Mars CM patchset: 32GB microSD Class 10 A1 U1 HC1
> > af04f37a revert e6b7aeef with Mars CM patchset: 32GB microSD Class 10 A1 U1 HC1
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 3
> > OEM: 5344
> > Name: SC32G
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 29.7 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > e6b7aeef: 200GB microSD Class 10 A1 U1 XC1
> > e6b7aeef~: 200GB microSD Class 10 A1 U1 XC1
> > af04f37a: 200GB microSD Class 10 A1 U1 XC1
> > af04f37a with Mars CM patchset: 200GB microSD Class 10 A1 U1 XC1
> > af04f37a revert e6b7aeef with Mars CM patchset: 200GB microSD Class 10 A1 U1 XC1
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 3
> > OEM: 5344
> > Name: SC200
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 183.3 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > e6b7aeef: 256GB microSD Class U3 XC1
> > e6b7aeef~: 256GB microSD Class U3 XC1
> > af04f37a: 256GB microSD Class U3 XC1
> > af04f37a with Mars CM patchset: 256GB microSD Class U3 XC1
> > af04f37a revert e6b7aeef with Mars CM patchset: 256GB microSD Class U3 XC1
> > StarFive # mmc rescan ; mmc info
> > Device: mmc@16010000
> > Manufacturer ID: 1b
> > OEM: 534d
> > Name: GE4S5
> > Bus Speed: 50000000
> > Mode: SD High Speed (50MHz)
> > Rd Block Len: 512
> > SD version 3.0
> > High Capacity: Yes
> > Capacity: 238.8 GiB
> > Bus Width: 1-bit
> > Erase Group Size: 512 Bytes
> >
> > > One potential problem I
> > > could think of is perhaps the SPL built is without SPL_PINCTRL_STARFIVE/JH7110
> > > or the u-boot dts is missing the pinctrl that properly sets drive-strength and
> > > other properties of the mmc0/1 pins. What dtb are you using? I tested this with
> > > visionfive2 and it's working fine. Can you share the tree/config you used to
> > > built for Milk-V Mars CM Lite? I don't see the corresponding dts being checked-
> > > in to u-boot tree, so it helps if you can share the code. Thanks!
> > >
> > > Bo
> >
> > As described, this is upstream U-Boot. Does this 'mmc info' testing
> > help give some ideas to suggest?
> >
> > -E
