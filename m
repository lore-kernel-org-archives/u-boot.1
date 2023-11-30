Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D1EC4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 15:21:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C84875FE;
	Thu, 30 Nov 2023 16:21:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="LIwNmVo8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 356BE87684; Thu, 30 Nov 2023 16:21:22 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2784186BA2
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 16:21:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUFLAPo075701;
 Thu, 30 Nov 2023 09:21:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701357670;
 bh=M/uIiv6ONRJNKq1AmFLi/wTe7moW+TZ/qShukowgepg=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=LIwNmVo8p0VQdwgylSBAoSxGTDXWRh8my20xDXqpqYLcur+M+YgzrbkLVeRxeg1Uk
 7FWPhoxBKJKiZiPnBPbUgkFQWqZZn1qXRgBTJ1ZGE1gWUVogWhSMttRL43P3MFvuiG
 FxcjNh43wwbBkFFxQ7CCiD+7YUCM7L/p49I4joBA=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUFLAoF090356
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 09:21:10 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 09:21:10 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 09:21:10 -0600
Received: from [10.249.32.108] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AUFL92x041378;
 Thu, 30 Nov 2023 09:21:09 -0600
Message-ID: <064aa169-8360-4e62-a5f0-f29ddac8b0b4@ti.com>
Date: Thu, 30 Nov 2023 09:21:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/17] board: ti: j784s4: Add MAINTAINERS file
Content-Language: en-US
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Kamlesh Gurudasani <kamlesh@ti.com>,
 Dasnavis Sabiya <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-18-a-nandan@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231130115552.3580995-18-a-nandan@ti.com>
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

On 11/30/23 5:55 AM, Apurva Nandan wrote:
> Add maintainership for new J784S4 files added.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   board/ti/j784s4/MAINTAINERS | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
>   create mode 100644 board/ti/j784s4/MAINTAINERS
> 
> diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
> new file mode 100644
> index 0000000000..d3f0e50391
> --- /dev/null
> +++ b/board/ti/j784s4/MAINTAINERS
> @@ -0,0 +1,25 @@
> +J784S4 BOARD
> +M:	Apurva Nandan <a-nandan@ti.com>
> +S:	Maintained
> +F:	board/ti/j784s4
> +F:	arch/arm/mach-k3/j784s4

The arch/arm/mach-k3/j784s4 files are not related to the board, other
boards and board vendors can have different maintainers, and the SoC
maintainer doesn't need to be a maintainer of any set of boards.

I wonder if we should move the SoC level maintainer lines up into the
main MAINTAINERS file, or add arch/arm/mach-k3/MAINTAINERS. Leaving only
the board specific files in the board/**/MAINTAINERS file.

Andrew

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
> +F:	arch/arm/dts/k3-am69-sk.dts
> +F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +F:	arch/arm/dts/k3-am69-r5-sk.dts
> +F:	configs/am69_sk_r5.config
> +F:	configs/am69_sk_a72.config
