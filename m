Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE97C3DA6E
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 17:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40EB087811;
	Wed,  3 Jan 2024 18:52:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="K5gscUkn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A66887823; Wed,  3 Jan 2024 18:52:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0571C86EEC
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 18:52:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 403HqLcb081191;
 Wed, 3 Jan 2024 11:52:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1704304341;
 bh=W6WJthw9HuGS10yMTxFCkti6ZcXqFz7HyJBSHupMuU0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=K5gscUknDDT1xqbKZtDNVJ0bu27xOG7JaQGUMLWrpjRKR5CLsaV58rClW1RBCG0FH
 Oahtp7F0ZnfRZMfXcc7RD7h7Q1wGwvoLRgKluB6NUzp7v02wxHwhBVCd6kf//7vE5y
 sFALodxpPGDFULjHoe+47ffYZjkGHYjymWXxGRYk=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 403HqLc1085921
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 3 Jan 2024 11:52:21 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Jan 2024 11:52:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Jan 2024 11:52:21 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 403HqLxO125817;
 Wed, 3 Jan 2024 11:52:21 -0600
Date: Wed, 3 Jan 2024 11:52:21 -0600
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
Subject: Re: [PATCH v7 13/17] arm: dts: Add bootph-all for memory node
Message-ID: <20240103175221.ovjzcwwljnjhka2n@expire>
References: <20231219191537.4039361-1-a-nandan@ti.com>
 <20231219191537.4039361-14-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231219191537.4039361-14-a-nandan@ti.com>
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
> memory node is used by fdtdec_setup_mem_size_base() and
> fdtdec_setup_memory_banksize() during dram_init(), so use
> bootph-all to enable for all stages.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/dts/k3-am69-sk-u-boot.dtsi    | 6 ++++++
>  arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm/dts/k3-am69-sk-u-boot.dtsi b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> index d1623b6bbe..6d848ba6bc 100644
> --- a/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am69-sk-u-boot.dtsi
> @@ -5,6 +5,12 @@
>  
>  #include "k3-j784s4-binman.dtsi"
>  
> +/ {
> +	memory@80000000 {
> +		bootph-all;
> +	};
> +};
> +
>  &mcu_udmap {
>  	reg =   <0x0 0x285c0000 0x0 0x100>,
>  		<0x0 0x284c0000 0x0 0x4000>,
> diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> index 74de8a4db8..ac749782bf 100644
> --- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> +++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
> @@ -5,6 +5,12 @@
>  
>  #include "k3-j784s4-binman.dtsi"
>  
> +/ {
> +	memory@80000000 {
> +		bootph-all;
> +	};
> +};
> +
>  &mcu_udmap {
>  	reg =   <0x0 0x285c0000 0x0 0x100>,
>  		<0x0 0x284c0000 0x0 0x4000>,

Is there a patch submitted for upstream kernel?

This should be part of your patch for board.dts instead of a
patch that fixes multiple board.dts after introducing the dts in the
same series.

So squash this change to relevant patches please and please refer to
upstream kernel patch so that we can drop this later on.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
