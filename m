Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73777E7718D
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 09:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F328806D4;
	Mon, 23 Dec 2024 10:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RYBFJ50+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4897E806DB; Mon, 23 Dec 2024 10:32:48 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6B7806D3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:32:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Wdgt105219;
 Mon, 23 Dec 2024 03:32:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734946359;
 bh=ve/ydw0Ucj80XTGAGs+HHm3ztu8kBsToNyFYZs50BNw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=RYBFJ50+oURTmygJe8WTAf0gVSyH3DpHmZUIeWszh+8EzGJ6Fh/G5sfI11SPpEpsF
 GO71heUvkwe7cW4oDFf1SQ0HaAb1LBWE9+nC5L1YILXchrZhPjXKbdVtLy2x1b4n+j
 u6no9lHTN1OYPvlNxilkRO0BDj3MVRnF9FgmT/lc=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN9WddN126100
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Dec 2024 03:32:39 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 03:32:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 03:32:38 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN9Wblp006205;
 Mon, 23 Dec 2024 03:32:38 -0600
Date: Mon, 23 Dec 2024 15:02:37 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>
Subject: Re: [PATCH RFC 2/8] arm: dts: k3-j784s4-binman.dtsi: Clean up and
 templatize boot binaries
Message-ID: <20241223093237.3zg4lhfywpwcmrds@uda0497581>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-2-13a6a127b344@ti.com>
 <0285f45f-0ab1-43ea-8ae0-70e0a8e5a201@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0285f45f-0ab1-43ea-8ae0-70e0a8e5a201@ti.com>
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

Hi Udit,

On 19:25-20241222, Kumar, Udit wrote:
> 
> On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
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
> >   arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 120 +++++++++++++++++++++++++++------
> >   arch/arm/dts/k3-j784s4-binman.dtsi     | 116 +++++++++----------------------
> >   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  74 ++++++++++++++++++++
> >   3 files changed, 203 insertions(+), 107 deletions(-)
> > 
> > diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > index 4a82d2fd222669c4b390d4d877bc15329eab8894..b37fa3ceb0e0a6296294aaaaaa561a67e8506064 100644
> > --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> > @@ -3,8 +3,106 @@
> >    * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> 
> Copyright, please include 2024
> 
> 
> >    */
> > +#define SPL_BOARD_DTB "spl/dts/ti/k3-am69-sk.dtb"
> > +#define BOARD_DESCRIPTION "k3-am69-sk"
> > +#define UBOOT_BOARD_DESCRIPTION "U-Boot for AM69 board"
> > +
> >   #include "k3-j784s4-binman.dtsi"
> > +#if !defined(CONFIG_ARM64)
> Cosmetic, I suggest to use #if defined

Would change it to #if defined(CONFIG_CPU_V7R) then

> > +&binman {
> > +	tiboot3-am69-hs {
> > +		insert-template = <&tiboot3_j784s4_hs>;
> > +		filename = "tiboot3-am69-hs-sk.bin";
> > +	};
> > +
> > +	tiboot3-am69-hs-fs {
> > +		insert-template = <&tiboot3_j784s4_hs_fs>;
> > +		filename = "tiboot3-am69-hs-fs-sk.bin";
> > +		symlink = "tiboot3.bin";
> > +	};
> > +};
> > +
> > +&ti_fs_enc {
> > +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
> > +};
> > +
> > +&sysfw_inner_cert {
> > +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
> > +};
> > +
> > +&ti_fs_enc_fs {
> > +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-enc.bin";
> > +};
> > +
> > +&sysfw_inner_cert_fs {
> > +	filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-cert.bin";
> > +};
> > +
> > +#include "k3-binman-capsule-r5.dtsi"
> > +
> > +// Capsule update GUIDs in string form.  See j784s4_evm.h
> > +#define AM69_SK_TIBOOT3_IMAGE_GUID_STR "adf49ec5-61bb-4dbe-8b8d-39df4d7ebf46"
> > +
> > +&capsule_tiboot3 {
> > +	efi-capsule {
> > +		image-guid = AM69_SK_TIBOOT3_IMAGE_GUID_STR;
> > +
> > +		blob {
> > +			filename = "tiboot3-am69-hs-fs-sk.bin";
> > +		};
> 
> I am wondering, how you plan to take care of capsule for hs devices.

I think this would need to be a separate discussion as I have just moved
the existing code around so not really sure how this is all used...

> 
> 
> > +	};
> > +};
> > +
> > +#else // CONFIG_ARM64
> > +
> > +&binman {
> > +	ti-dm {
> > +		filename = "ti-dm.bin";
> > +
> > +		blob-ext {
> > +			filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
> > +			optional;
> 
> is dm block optional ?

I think this has been marked as optional in other devices as well but
would require Neha to comment if it's okay to remove.. don't know the
history around it.

> 
> 
> > +		};
> > +	};
> > +
> > +	tispl {
> > +		insert-template = <&ti_spl>;
> > +	};
> > +
> > +	u-boot {
> > +		insert-template = <&u_boot>;
> > +	};
> > +
> > +	tispl-unsigned {
> > +		insert-template = <&ti_spl_unsigned>;
> > +	};
> > +
> > +	u-boot-unsigned {
> > +		insert-template = <&u_boot_unsigned>;
> > +	};
> 
> Do we need unsigned tispl and u-boot here ?

This sometimes help for hs-fs flows as well so I think better to keep it
for debug purposes.

Regards,
Manorit

[..]
