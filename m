Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59EE2C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 14:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F218768A;
	Thu, 30 Nov 2023 15:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Cf7qie13";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CB0787692; Thu, 30 Nov 2023 15:53:14 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABE7870D5
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 15:53:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEqs37069268;
 Thu, 30 Nov 2023 08:52:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701355974;
 bh=ybpsJvDiNalce80aFTwPAusKmAJqIYnvIn63ldUy368=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=Cf7qie13rqQL6S+YFx3AiAvuC+XlwYHIBmE6e1KtrqohND5Q+z6YeFVcY6ciI1E9p
 Sxwini/btx7zx9iKpoM8IwBTG/I7Lj16XUAS9GgGEptAm5LrDcCsetnL/k9t/0ooNd
 cKWqlzk1+mmNOy9/w25K6BLY3Hrj+5OvWkZkMFZg=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AUEqs1E072051
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Nov 2023 08:52:54 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 30
 Nov 2023 08:52:54 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 30 Nov 2023 08:52:54 -0600
Received: from [10.249.32.108] (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AUEqHgd012402;
 Thu, 30 Nov 2023 08:52:53 -0600
Message-ID: <3a3dc720-97c6-4498-86d2-8b26f770be95@ti.com>
Date: Thu, 30 Nov 2023 08:52:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/17] board: ti: j748s4: Add board config yaml files
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
 <20231130115552.3580995-11-a-nandan@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20231130115552.3580995-11-a-nandan@ti.com>
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
> Add board-cfg, rm-cfg, pm-cfg, sec-cfg, tifs-rm-cfg yaml for buidling
> u-boot sysfw data.
> 
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>
> ---
>   board/ti/j784s4/board-cfg.yaml   |   37 +
>   board/ti/j784s4/pm-cfg.yaml      |   13 +
>   board/ti/j784s4/rm-cfg.yaml      | 3058 ++++++++++++++++++++++++++++++
>   board/ti/j784s4/sec-cfg.yaml     |  380 ++++
>   board/ti/j784s4/tifs-rm-cfg.yaml | 2656 ++++++++++++++++++++++++++
>   5 files changed, 6144 insertions(+)
>   create mode 100644 board/ti/j784s4/board-cfg.yaml
>   create mode 100644 board/ti/j784s4/pm-cfg.yaml
>   create mode 100644 board/ti/j784s4/rm-cfg.yaml
>   create mode 100644 board/ti/j784s4/sec-cfg.yaml
>   create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
> 
> diff --git a/board/ti/j784s4/board-cfg.yaml b/board/ti/j784s4/board-cfg.yaml
> new file mode 100644
> index 0000000000..049105062c
> --- /dev/null
> +++ b/board/ti/j784s4/board-cfg.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +#
> +# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
> +#
> +# Board configuration for J784S4
> +#
> +
> +---
> +
> +board-cfg:
> +    rev:
> +        boardcfg_abi_maj: 0x0
> +        boardcfg_abi_min: 0x1
> +    control:
> +        subhdr:
> +            magic: 0xC1D3
> +            size: 7
> +        main_isolation_enable: 0x5A
> +        main_isolation_hostid: 0x2
> +    secproxy:
> +        subhdr:
> +            magic: 0x1207
> +            size: 7
> +        scaling_factor: 0x1
> +        scaling_profile: 0x1
> +        disable_main_nav_secure_proxy: 0
> +    msmc:
> +        subhdr:
> +            magic: 0xA5C3
> +            size: 5
> +        msmc_cache_size: 0x8
> +    debug_cfg:
> +        subhdr:
> +            magic: 0x020C
> +            size: 8
> +        trace_dst_enables: 0x00
> +        trace_src_enables: 0x00
> \ No newline at end of file

Does checkpatch not complain about this no newline?

Andrew
