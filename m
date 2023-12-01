Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3059FC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 04:19:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20C4C8757B;
	Fri,  1 Dec 2023 05:19:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="sTE42JJk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE098757B; Fri,  1 Dec 2023 05:19:11 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DA7687136
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 05:19:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B14ItZ1037711;
 Thu, 30 Nov 2023 22:18:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701404335;
 bh=zF8vr2tjg8jaKcixFj44iZtQfYJrqS4PiqOSsnAZdYw=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=sTE42JJkbhtrDXlIyMKq/esJth35OVhD2sI1/yHM1c7NBKj326vJp4E4fEQqSbbTK
 jKUOPfSTdXlN3h73doqPiUczMYMbWq5fEXiyYcogW1ce9OUOBp2B31k0EXgL0OlMgf
 VkOuunfLB2weJsSPEavk6xVcJkeIJj7/4JQOtAdU=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B14ItJC072250
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 22:18:55 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 22:18:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 22:18:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B14Is3Z108448;
 Thu, 30 Nov 2023 22:18:54 -0600
Date: Fri, 1 Dec 2023 09:48:53 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jayesh
 Choudhary <j-choudhary@ti.com>, Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v5 12/17] arm: dts: Introduce j784s4 u-boot dts files
Message-ID: <20231201041853.5yrf77mcfdxy75ty@uda0497581>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-13-a-nandan@ti.com>
 <26046a5c-561b-4f10-a752-f3a0a011989c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <26046a5c-561b-4f10-a752-f3a0a011989c@ti.com>
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

Hi Andrew,

On 09:11-20231130, Andrew Davis wrote:
> On 11/30/23 5:55 AM, Apurva Nandan wrote:
> > Introduce the base dts files needed for u-boot or to augment the linux
> > dtbs for use in the u-boot-spl and u-boot binaries.
> > 
> > Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> > [ add binman and ddr dtsi files ]
> > Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> > Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> > Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> > ---
> >   arch/arm/dts/Makefile                        |    3 +-
> >   arch/arm/dts/k3-j784s4-binman.dtsi           |  346 +
> >   arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi | 8757 +++++++++++++++++
> >   arch/arm/dts/k3-j784s4-ddr.dtsi              | 8858 ++++++++++++++++++
> >   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi       |   25 +
> >   arch/arm/dts/k3-j784s4-r5-evm.dts            |  105 +
> >   6 files changed, 18093 insertions(+), 1 deletion(-)
> >   create mode 100644 arch/arm/dts/k3-j784s4-binman.dtsi
> >   create mode 100644 arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
> >   create mode 100644 arch/arm/dts/k3-j784s4-ddr.dtsi
> >   create mode 100644 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> >   create mode 100644 arch/arm/dts/k3-j784s4-r5-evm.dts
> > 
> > diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> > index 1a63ccba8e..b73f8a9230 100644
> > --- a/arch/arm/dts/Makefile
> > +++ b/arch/arm/dts/Makefile
> > @@ -1409,7 +1409,8 @@ dtb-$(CONFIG_SOC_K3_J721S2) += k3-am68-sk-base-board.dtb\
> >   			       k3-j721s2-common-proc-board.dtb\
> >   			       k3-j721s2-r5-common-proc-board.dtb
> >   dtb-$(CONFIG_SOC_K3_J784S4) += k3-am69-sk.dtb\
> > -			       k3-j784s4-evm.dtb
> > +			       k3-j784s4-evm.dtb\
> > +			       k3-j784s4-r5-evm.dtb
> >   dtb-$(CONFIG_SOC_K3_AM642) += k3-am642-evm.dtb \
> >   			      k3-am642-r5-evm.dtb \
> >   			      k3-am642-sk.dtb \
> > diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> > new file mode 100644
> > index 0000000000..7349c2ba38
> > --- /dev/null
> > +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> > @@ -0,0 +1,346 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
> > + */
> > +
> > +#include "k3-binman.dtsi"
> > +
> > +#ifdef CONFIG_TARGET_J784S4_R5_EVM
> > +
> > +&rcfg_yaml_tifs {
> > +	config = "tifs-rm-cfg.yaml";
> > +};
> > +
> > +&binman {
> > +	tiboot3-j784s4-hs-evm.bin {
> > +		filename = "tiboot3-j784s4-hs-evm.bin";
> > +
> > +		ti-secure-rom {
> > +			content = <&u_boot_spl>, <&ti_fs_enc>, <&combined_tifs_cfg>,
> > +				<&combined_dm_cfg>, <&sysfw_inner_cert>;
> > +			combined;
> > +			dm-data;
> > +			sysfw-inner-cert;
> > +			keyfile = "custMpk.pem";
> > +			sw-rev = <1>;
> > +			content-sbl = <&u_boot_spl>;
> > +			content-sysfw = <&ti_fs_enc>;
> > +			content-sysfw-data = <&combined_tifs_cfg>;
> > +			content-sysfw-inner-cert = <&sysfw_inner_cert>;
> > +			content-dm-data = <&combined_dm_cfg>;
> > +			load = <0x41c00000>;
> > +			load-sysfw = <0x40000>;
> > +			load-sysfw-data = <0x66800>;
> > +			load-dm-data = <0x41c80000>;
> > +		};
> > +
> > +		u_boot_spl: u-boot-spl {
> > +			no-expanded;
> > +		};
> > +
> > +		ti_fs_enc: ti-fs-enc.bin {
> > +			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-enc.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +
> > +		combined_tifs_cfg: combined-tifs-cfg.bin {
> > +			filename = "combined-tifs-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +
> > +		sysfw_inner_cert: sysfw-inner-cert {
> > +			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-cert.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +
> > +		combined_dm_cfg: combined-dm-cfg.bin {
> > +			filename = "combined-dm-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +	};
> > +};
> > +
> > +&binman {
> > +	tiboot3-j784s4-hs-fs-evm.bin {
> > +		filename = "tiboot3-j784s4-hs-fs-evm.bin";
> > +
> > +		ti-secure-rom {
> > +			content = <&u_boot_spl_fs>, <&ti_fs_enc_fs>, <&combined_tifs_cfg_fs>,
> > +				<&combined_dm_cfg_fs>, <&sysfw_inner_cert_fs>;
> > +			combined;
> > +			dm-data;
> > +			sysfw-inner-cert;
> > +			keyfile = "custMpk.pem";
> > +			sw-rev = <1>;
> > +			content-sbl = <&u_boot_spl_fs>;
> > +			content-sysfw = <&ti_fs_enc_fs>;
> > +			content-sysfw-data = <&combined_tifs_cfg_fs>;
> > +			content-sysfw-inner-cert = <&sysfw_inner_cert_fs>;
> > +			content-dm-data = <&combined_dm_cfg_fs>;
> > +			load = <0x41c00000>;
> > +			load-sysfw = <0x40000>;
> > +			load-sysfw-data = <0x66800>;
> > +			load-dm-data = <0x41c80000>;
> > +		};
> > +
> > +		u_boot_spl_fs: u-boot-spl {
> > +			no-expanded;
> > +		};
> > +
> > +		ti_fs_enc_fs: ti-fs-enc.bin {
> > +			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-enc.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +
> > +		combined_tifs_cfg_fs: combined-tifs-cfg.bin {
> > +			filename = "combined-tifs-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +
> > +		sysfw_inner_cert_fs: sysfw-inner-cert {
> > +			filename = "ti-sysfw/ti-fs-firmware-j784s4-hs-fs-cert.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +
> > +		combined_dm_cfg_fs: combined-dm-cfg.bin {
> > +			filename = "combined-dm-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +	};
> > +};
> > +
> > +&binman {
> > +	tiboot3-j784s4-gp-evm.bin {
> > +		filename = "tiboot3-j784s4-gp-evm.bin";
> > +		symlink = "tiboot3.bin";
> > +
> > +		ti-secure-rom {
> > +			content = <&u_boot_spl_unsigned>, <&ti_fs_gp>,
> > +				<&combined_tifs_cfg_gp>, <&combined_dm_cfg_gp>;
> > +			combined;
> > +			dm-data;
> > +			content-sbl = <&u_boot_spl_unsigned>;
> > +			load = <0x41c00000>;
> > +			content-sysfw = <&ti_fs_gp>;
> > +			load-sysfw = <0x40000>;
> > +			content-sysfw-data = <&combined_tifs_cfg_gp>;
> > +			load-sysfw-data = < 0x66800>;
> > +			content-dm-data = <&combined_dm_cfg_gp>;
> > +			load-dm-data = <0x41c80000>;
> > +			sw-rev = <1>;
> > +			keyfile = "ti-degenerate-key.pem";
> > +		};
> > +
> > +		u_boot_spl_unsigned: u-boot-spl {
> > +			no-expanded;
> > +		};
> > +
> > +		ti_fs_gp: ti-fs-gp.bin {
> > +			filename = "ti-sysfw/ti-fs-firmware-j784s4-gp.bin";
> > +			type = "blob-ext";
> > +			optional;
> > +		};
> > +
> > +		combined_tifs_cfg_gp: combined-tifs-cfg-gp.bin {
> > +			filename = "combined-tifs-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +
> > +		combined_dm_cfg_gp: combined-dm-cfg-gp.bin {
> > +			filename = "combined-dm-cfg.bin";
> > +			type = "blob-ext";
> > +		};
> > +
> > +	};
> > +};
> > +#endif
> > +
> > +#ifdef CONFIG_TARGET_J784S4_A72_EVM
> > +
> > +#define SPL_J784S4_EVM_DTB "spl/dts/k3-j784s4-evm.dtb"
> > +
> > +#define J784S4_EVM_DTB "u-boot.dtb"
> > +
> 
> Why not define this as "arch/arm/dts/k3-j784s4-evm.dtb"? Seems we use this
> as a hacky way to change this item based on CONFIG_DEFAULT_DEVICE_TREE as
> that DT will be renamed "u-boot.dtb". But I'm not sure what that gains us.
> And why only do it for U-Boot and not SPL_? If runtime selection is not
> working then we still have the wrong DTB for SPL just the same.
> 
> It also means we have in some builds we have a node named "j784s4_evm_dtb"
> that contains the SK DTB, and the node called "am69_sk_dtb" *also* contains
> the SK DTB..
> 

This is required for FIT Signature generation actually, FIT Signature
doesn't sign multiple DTBs and we use u-boot.dtb at the moment for
signing nodes in it. U-boot makefile has a flag of EXT_DTB that actually
gets propagated to u-boot.dtb at the end and this is how the signature
node is being compiled back to u-boot by the OEs.

Though going forward, it looks like we don't plan on having
the same support for SKs and EVMs and we'll end up changing
CONFIG_DEFAULT_DEVICE_TREE in the defconfigs/config_fragments for this
support. If that is the case then I think it's better to start using
u-boot.dtb and something similar for SPL if one exists as I am not sure
if we are going for runtime detection anymore that requires packing
multiple DTBs.

Regards,
Manorit

> Andrew
