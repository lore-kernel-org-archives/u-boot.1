Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8568C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B08D87C63;
	Fri, 15 Dec 2023 19:40:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="ktOzfvSB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A77887C67; Fri, 15 Dec 2023 19:40:09 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C08C87C61
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BFIdsSr089723;
 Fri, 15 Dec 2023 12:39:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1702665594;
 bh=4YU73Tfd08CFyDJEEOHK58py/5hBePEfl4UvrjYzs/I=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=ktOzfvSBL1+zsZBkI+vl4kqkWxBP+APbNpsEZAFJATvoyThI4dnELMftEl84LFsYp
 7oHa2ddNGJUXFysVIWlrTdBV7+ULq3LkWwI+JN6hViCQZcyI9ouff9qsjKk/EzelYh
 KiT77qJiL99HjEbXfeGguDVuTnEu7KAyfwg4TRjU=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BFIdspc114930
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 15 Dec 2023 12:39:54 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 15
 Dec 2023 12:39:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 15 Dec 2023 12:39:54 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BFIdrjr077621;
 Fri, 15 Dec 2023 12:39:53 -0600
Date: Fri, 15 Dec 2023 12:39:53 -0600
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
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>, Sinthu Raja M
 <sinthu.raja@mistralsolutions.com>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH v6 06/17] arm: mach-k3: j784s4: Add clk and power support
Message-ID: <20231215183953.t672shlzlwu76xwi@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <20231206123753.1486031-7-a-nandan@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20231206123753.1486031-7-a-nandan@ti.com>
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

On December  6, 2023 thus sayeth Apurva Nandan:
> Add clk and device data which can be used by respective drivers
> to configure clocks and PSC.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>  arch/arm/mach-k3/r5/j784s4/Makefile    |   7 +
>  arch/arm/mach-k3/r5/j784s4/clk-data.c  | 428 +++++++++++++++++++++++++
>  arch/arm/mach-k3/r5/j784s4/dev-data.c  |  98 ++++++
>  drivers/clk/ti/clk-k3.c                |   6 +
>  drivers/power/domain/ti-power-domain.c |   6 +
>  include/k3-clk.h                       |   1 +
>  include/k3-dev.h                       |   1 +
>  7 files changed, 547 insertions(+)
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/Makefile
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/clk-data.c
>  create mode 100644 arch/arm/mach-k3/r5/j784s4/dev-data.c

...


> diff --git a/arch/arm/mach-k3/r5/j784s4/clk-data.c b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> new file mode 100644
> index 0000000000..d3fac38dd6
> --- /dev/null
> +++ b/arch/arm/mach-k3/r5/j784s4/clk-data.c
> @@ -0,0 +1,428 @@

...

> +const struct ti_k3_clk_platdata j784s4_clk_platdata = {
> +	.clk_list = clk_list,
> +	.clk_list_cnt = 106,
> +	.soc_dev_clk_data = soc_dev_clk_data,
> +	.soc_dev_clk_data_cnt = 128,

These should probably be updated to use the ARRAY_SIZE() macros instead 
of their hard coded values.

> diff --git a/arch/arm/mach-k3/r5/j784s4/dev-data.c b/arch/arm/mach-k3/r5/j784s4/dev-data.c
> new file mode 100644
> index 0000000000..a9b77d0f49
> --- /dev/null
> +++ b/arch/arm/mach-k3/r5/j784s4/dev-data.c
> @@ -0,0 +1,98 @@

...

> +const struct ti_k3_pd_platdata j784s4_pd_platdata = {
> +	.psc = soc_psc_list,
> +	.pd = soc_pd_list,
> +	.lpsc = soc_lpsc_list,
> +	.devs = soc_dev_list,
> +	.num_psc = 3,
> +	.num_pd = 8,
> +	.num_lpsc = 23,
> +	.num_devs = 30,
> +};

Here too, just to make future updates a little easier.

~Bryan
