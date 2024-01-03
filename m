Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9701CC3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 18:41:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDCE487727;
	Wed,  3 Jan 2024 19:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ovI95VEE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9D318773D; Wed,  3 Jan 2024 19:41:27 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC7ED87705
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 19:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403IfG5Z123369;
 Wed, 3 Jan 2024 12:41:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704307276;
 bh=YS7HrJqUUkC/HZfNxORskXEV1fXdhUHYFKqUXsw99G8=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ovI95VEEihkMbIdlAkjxKTf1Lr12UHticu6QmXh5TfbtXU0dk17/aerbgqfXeKTAK
 OIyhaZHTmi+yG98+RAGj/AyBR2j0p5m99g7KhyicbWsRy1M7qQKDzmq9mOg3NGCbuq
 A1SumpsX/4ahxEL0x/zmV+QN29bAgiHPV28V5UXc=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403IfFTR000489
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 12:41:15 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 12:41:15 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 12:41:15 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403IfF1l080272;
 Wed, 3 Jan 2024 12:41:15 -0600
Date: Wed, 3 Jan 2024 12:41:15 -0600
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
Subject: Re: [PATCH v7 17/17] board: ti: j784s4: Add MAINTAINERS file
Message-ID: <20240103184115.ytufvuiimuxjc6a5@arguable>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-18-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-18-a-nandan@ti.com>
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

On 00:45-20231220, Apurva Nandan wrote:
> Add maintainership for new J784S4 files added.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  board/ti/j784s4/MAINTAINERS | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>  create mode 100644 board/ti/j784s4/MAINTAINERS

NAK - Introduce the same as part of each of the board support being
introduced.

> 
> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
> new file mode 100644
> index 0000000000..d3f0e50391
> --- /dev/null
> +++ b/board/ti/j784s4/MAINTAINERS
> @@ -0,0 +1,25 @@
> +J784S4 BOARD

J784S4 EVM BOARD

> +M:	Apurva Nandan <a-nandan@ti.com>
> +S:	Maintained
> +F:	board/ti/j784s4
> +F:	arch/arm/mach-k3/j784s4
> +F:	include/configs/j784s4_evm.h
> +F:	configs/j784s4_evm_r5_defconfig
> +F:	configs/j784s4_evm_a72_defconfig
> +F:	arch/arm/dts/k3-j784s4.dtsi
> +F:	arch/arm/dts/k3-j784s4-main.dtsi
> +F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
> +F:	arch/arm/dts/k3-j784s4-thermal.dtsi
> +F:	arch/arm/dts/k3-j784s4-evm.dts
> +F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +F:	arch/arm/dts/k3-j784s4-r5-evm.dts
> +F:	arch/arm/dts/k3-j784s4-ddr.dtsi
> +F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
> +F:	doc/board/ti/j784s4_evm.rst
> +
> +AM69 BOARD

AM69 SK BOARD please

> +F:	arch/arm/dts/k3-am69-sk.dts
> +F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +F:	arch/arm/dts/k3-am69-r5-sk.dts
> +F:	configs/am69_sk_r5.config
> +F:	configs/am69_sk_a72.config

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
