Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62794C10DC1
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 16:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75D6C876CB;
	Fri,  1 Dec 2023 17:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lkK7hpU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A031876A7; Fri,  1 Dec 2023 17:22:51 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24034875A7
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 17:22:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3B1GMUc5082695;
 Fri, 1 Dec 2023 10:22:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701447750;
 bh=EUjdTd5Nd5eTxNBpUzVkto/gW790U4eRSwsRutR7+20=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lkK7hpU5DRcDVtyNaA5MD9yiw7orZ+BHxpRan75I3skzNZmwMW/K4zsB6CNptrtZm
 X/cEztf9l4ZetmM7tBOTAC6PvJEOaWUSKlVJOBuCGdDGeawGmQXKcW116B2zob2YfH
 C+fjnyZIiMlxh+vmfuvzcOZhvqA/PPZzOTTnkNck=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3B1GMUUq074794
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 1 Dec 2023 10:22:30 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Dec 2023 10:22:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Dec 2023 10:22:29 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3B1GMT2v092882;
 Fri, 1 Dec 2023 10:22:29 -0600
Date: Fri, 1 Dec 2023 10:22:29 -0600
From: Bryan Brattlof <bb@ti.com>
To: Apurva Nandan <a-nandan@ti.com>
CC: Hari Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean
 Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, Neha
 Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>, Andrew
 Davis <afd@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya
 <sabiya.d@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Aradhya Bhatia
 <a-bhatia1@ti.com>, Christian Gmeiner <christian.gmeiner@gmail.com>,
 Nishanth Menon <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Roger Quadros <rogerq@kernel.org>, Jayesh Choudhary <j-choudhary@ti.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Yanhong Wang <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v5 03/17] arm: dts: Add bootph-all for memory node
Message-ID: <20231201162229.ejxjcib6cvyphsyz@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231130115552.3580995-1-a-nandan@ti.com>
 <20231130115552.3580995-4-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231130115552.3580995-4-a-nandan@ti.com>
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

Hi Apurva!

On November 30, 2023 thus sayeth Apurva Nandan:
> memory node is used by fdtdec_setup_mem_size_base() and
> fdtdec_setup_memory_banksize() during dram_init(), so use
> bootph-all to enable for all stages.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/dts/k3-am69-sk.dts    | 1 +
>  arch/arm/dts/k3-j784s4-evm.dts | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am69-sk.dts b/arch/arm/dts/k3-am69-sk.dts
> index 9868c7049b..2d6e51001b 100644
> --- a/arch/arm/dts/k3-am69-sk.dts
> +++ b/arch/arm/dts/k3-am69-sk.dts
> @@ -36,6 +36,7 @@
>  		/* 32G RAM */
>  		reg = <0x00 0x80000000 0x00 0x80000000>,
>  		      <0x08 0x80000000 0x07 0x80000000>;
> +		bootph-all;
>  	};
>  
>  	reserved_memory: reserved-memory {
> diff --git a/arch/arm/dts/k3-j784s4-evm.dts b/arch/arm/dts/k3-j784s4-evm.dts
> index f1f4c8634a..c33eba5fec 100644
> --- a/arch/arm/dts/k3-j784s4-evm.dts
> +++ b/arch/arm/dts/k3-j784s4-evm.dts
> @@ -34,6 +34,7 @@
>  		/* 32G RAM */
>  		reg = <0x00 0x80000000 0x00 0x80000000>,
>  		      <0x08 0x80000000 0x07 0x80000000>;
> +		bootph-all;
>  	};

These edits to the board files should go into *-u-boot.dtsi It would 
make them much easier to track for the next dt sync :)

~Bryan
