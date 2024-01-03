Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D47C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 15:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 424298772E;
	Wed,  3 Jan 2024 16:53:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Zeh9/etR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 588AA87756; Wed,  3 Jan 2024 16:53:37 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4238875EB
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 16:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403FrPNf009616;
 Wed, 3 Jan 2024 09:53:25 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704297205;
 bh=YvB6CJ3uuqupc9PiCwvuyprpt79uw3jGFDiupRKLi/U=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Zeh9/etRaf+MLbqcHt55lDsoD2MRbKfg/HTalFSYqCoqf1Tw4muR//2n5Z6KCAPWZ
 XaNwUzEZm2mrGzn0YxtVRgu/ZEtPl8jlKbm76cVE0/yfhxm+SiTuK1N3FKrsXp+5Pt
 QY1gynSldwqTMDhSMsq8uOpzB00Ojb5BX+v1A71E=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403FrPIV125188
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 09:53:25 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 09:53:24 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 09:53:24 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403FrOml107023;
 Wed, 3 Jan 2024 09:53:24 -0600
Date: Wed, 3 Jan 2024 09:53:24 -0600
From: Nishanth Menon <nm@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Roger Quadros
 <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph Siemsen
 <ralph.siemsen@linaro.org>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>,
 Sinthu Raja M <sinthu.raja@mistralsolutions.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v7 00/17] Introduce initial TI's J784S4 and AM69 support
Message-ID: <20240103155324.cr74b2plb7kjan4t@richness>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20240103153715.43kvt4ma7u7gz76y@sandblast>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240103153715.43kvt4ma7u7gz76y@sandblast>
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

On 09:37-20240103, Nishanth Menon wrote:
> On 00:45-20231220, Apurva Nandan wrote:
> > Hello Everyone!
> > 
> > This series will introduce basic support (SD and UART) support for Texas
> > Instruments J784S4 EVM.
> > 
> > The J784S4 SoC device tree patches are taken from kernel patch submissions
> > and will be updated as they are accepted and merged to the kernel tree.
> > All other patches are specific to SPL and u-boot and do not have
> > dependency on other trees. Appreciate a review for acceptance to u-boot
> > tree.
> > 
> > Here are some of the salient features of the J784S4 automotive grade
> > application processor:
> > 
> > The J784S4 SoC belongs to the K3 Multicore SoC architecture
> > platform, providing advanced system integration in automotive,
> > ADAS and industrial applications requiring AI at the network edge.
> > This SoC extends the K3 Jacinto 7 family of SoCs with focus on
> > raising performance and integration while providing interfaces,
> > memory architecture and compute performance for multi-sensor, high
> > concurrency applications.
> > 
> Tried to apply this series on top of:
> next dffa6d0210f5 Merge tag 'dm-next-1124' of https://source.denx.de/u-boot/custodians/u-boot-dm into next
> 
> 
> $ git am -3 v7_20231220_a_nandan_introduce_initial_ti_s_j784s4_and_am69_support.mbx
> Applying: arm: dts: Introduce j784s4 dts from linux kernel
> Applying: arm: dts: Introduce am69-sk dts from linux kernel
> Applying: arm: mach-k3: Add basic support for J784S4 SoC definition
> Applying: arm: mach-k3: Sort SoC JTAG_ID entries
> Applying: soc: ti: k3-socinfo: Add entry for J784S4 SoC
> Applying: arm: mach-k3: j784s4: Add clk and power support
> Applying: drivers: dma: Add support for J784S4 SoC
> Applying: board: ti: j784s4: Add board support for J784S4 EVM
> Applying: board: ti: j748s4: Add board config yaml files
> Applying: board: ti: j784s4: Add boot environment variables
> Applying: arm: dts: Introduce am69-sk u-boot dts files
> error: patch failed: arch/arm/dts/Makefile:1411
> error: arch/arm/dts/Makefile: patch does not apply
> error: arch/arm/dts/k3-j784s4-binman.dtsi: does not exist in index
> Patch failed at 0011 arm: dts: Introduce am69-sk u-boot dts files
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> When you have resolved this problem, run "git am --continue".
> If you prefer to skip this patch, run "git am --skip" instead.
> To restore the original branch and stop patching, run "git am --abort".
> 
> You will probably have to rebase this series once any review comments
> are addressed.

Looks like public-inbox in kernel.org is missing patch[1] #11, but
patchworks[2] seems to have a copy

Comments to follow..

[1] https://lore.kernel.org/all/20231219191537.4039361-1-a-nandan@ti.com/#t
[2] https://patchwork.ozlabs.org/project/uboot/list/?series=387428
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
