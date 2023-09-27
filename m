Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70630E810D5
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 11:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A188E86DCC;
	Wed, 27 Sep 2023 13:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="u2HHNaq/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D448C86DC4; Wed, 27 Sep 2023 13:53:58 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B89A786DC2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 13:53:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38RBrsAo104095;
 Wed, 27 Sep 2023 06:53:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1695815634;
 bh=42/DXRAOHz5xPhRoLFGjDNPWAfnhfJVlOaM38MC8C0k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=u2HHNaq/95LrczTMfGdfaD3tDe8lvWg5UutR+J5uHA05yVWE1TaC1+NdPTcw0EYKo
 dg1NdwTzYDlTN3Dm2MGR8192CMgMRk5rZYRyKMsSAioV2cQZlVA8ZFp4At+PmtQfm3
 I/60s9ChIiRsPmY+17ZMgqZDigcTUapIH/AjsEhU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38RBrsZi030442
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 27 Sep 2023 06:53:54 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Sep 2023 06:53:54 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Sep 2023 06:53:54 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38RBrsqK088416;
 Wed, 27 Sep 2023 06:53:54 -0500
Date: Wed, 27 Sep 2023 06:53:54 -0500
From: Nishanth Menon <nm@ti.com>
To: Nitin Yadav <n-yadav@ti.com>
CC: <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 4/4] board: ti: am62x: add am62x_lpsk_* defconfigs and
 env files
Message-ID: <20230927115354.2ralz6azvdel7hto@lubricant>
References: <20230927082105.3729470-1-n-yadav@ti.com>
 <20230927082105.3729470-5-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230927082105.3729470-5-n-yadav@ti.com>
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

On 13:51-20230927, Nitin Yadav wrote:
> Add defconfig fragments for AM62x LP SK and corresponding
> customized environment file for AM62x LP SK.
> 
> Signed-off-by: Nitin Yadav <n-yadav@ti.com>
> ---
>  board/ti/am62x/am62x_lpsk_a53.config |  5 +++++
>  board/ti/am62x/am62x_lpsk_r5.config  |  5 +++++
>  board/ti/am62x/am62xlpsk.env         | 21 +++++++++++++++++++++
>  3 files changed, 31 insertions(+)
>  create mode 100644 board/ti/am62x/am62x_lpsk_a53.config
>  create mode 100644 board/ti/am62x/am62x_lpsk_r5.config
>  create mode 100644 board/ti/am62x/am62xlpsk.env
> 
> diff --git a/board/ti/am62x/am62x_lpsk_a53.config b/board/ti/am62x/am62x_lpsk_a53.config
> new file mode 100644
> index 0000000000..a568324997
> --- /dev/null
> +++ b/board/ti/am62x/am62x_lpsk_a53.config
> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of am62x_evm_a53_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-lp-sk"
> +CONFIG_SPL_OF_LIST="k3-am62-lp-sk"
> +CONFIG_OF_LIST="k3-am62-lp-sk"
> diff --git a/board/ti/am62x/am62x_lpsk_r5.config b/board/ti/am62x/am62x_lpsk_r5.config
> new file mode 100644
> index 0000000000..1532f4e336
> --- /dev/null
> +++ b/board/ti/am62x/am62x_lpsk_r5.config
> @@ -0,0 +1,5 @@
> +# Defconfig fragment to apply on top of am62x_evm_r5_defconfig
> +
> +CONFIG_DEFAULT_DEVICE_TREE="k3-am62-r5-lp-sk"
> +CONFIG_SPL_OF_LIST="k3-am62-r5-lp-sk"
> +CONFIG_OF_LIST="k3-am62-r5-lp-sk"
> diff --git a/board/ti/am62x/am62xlpsk.env b/board/ti/am62x/am62xlpsk.env
> new file mode 100644
> index 0000000000..3b79ae1b3f
> --- /dev/null
> +++ b/board/ti/am62x/am62xlpsk.env
> @@ -0,0 +1,21 @@
> +#include <env/ti/ti_common.env>
> +#include <env/ti/default_findfdt.env>
> +#include <env/ti/mmc.env>
> +
> +name_kern=Image
> +console=ttyS2,115200n8
> +args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
> +	${mtdparts}
> +run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
> +
> +boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
> +boot=mmc
> +mmcdev=1
> +bootpart=1:2
> +bootdir=/boot
> +rd_spec=-
> +
> +splashfile=ti.gz
> +splashimage=0x80200000
> +splashpos=m,m
> +splashsource=sf

Why dont we use the am62.env ? What is here to customize?
> -- 
> 2.25.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
