Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AE28C83F01
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 12:32:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D333C863D4;
	Wed, 30 Aug 2023 14:32:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BlPMpMOv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26337863D9; Wed, 30 Aug 2023 14:32:02 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02E2863D3
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 14:31:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37UCVqKb040600;
 Wed, 30 Aug 2023 07:31:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693398712;
 bh=0XvPFL7QObnvChp84nswuRy5PVian1RNPmjLj1mh/jk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BlPMpMOvEhxnb/uG5W6UpfMnAhL9fxMdqqeQzLn2W1RY9JXAQTIMKO72TUfRXUDHj
 GbxwV+r4LuIgjlLbhhj3G49r3V7Ef2B7HTlH39q+HmnCKpQuTbj1u6Pmz2veKF5NIN
 oaaHccgFRoVEsuTmh+4+Saf+ZkENGARjyyJ4AqpQ=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37UCVq3x079380
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 30 Aug 2023 07:31:52 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 30
 Aug 2023 07:31:51 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 30 Aug 2023 07:31:51 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37UCVprc122507;
 Wed, 30 Aug 2023 07:31:51 -0500
Date: Wed, 30 Aug 2023 07:31:51 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Jan Kiszka <jan.kiszka@siemens.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>, <u-boot@lists.denx.de>
Subject: Re: [RFC PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Message-ID: <20230830123151.rp7wkhi5m4leg6ny@ravishing>
References: <20230829221457.101469-1-afd@ti.com>
 <20230829221457.101469-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230829221457.101469-3-afd@ti.com>
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

On 17:14-20230829, Andrew Davis wrote:
> Add am62x_beagleplay_r5_defconfig for R5 SPL and
> am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.
> 
> These defconfigs are composite defconfigs built from the config fragment
> board/ti/am62x/beagleplay_*.config applied onto the base
> am62x_evm_*_defconfig.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  configs/am62x_beagleplay_a53_defconfig | 3 +++
>  configs/am62x_beagleplay_r5_defconfig  | 3 +++
>  2 files changed, 6 insertions(+)
>  create mode 100644 configs/am62x_beagleplay_a53_defconfig
>  create mode 100644 configs/am62x_beagleplay_r5_defconfig
> 
> diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
> new file mode 100644
> index 00000000000..ad708e15397
> --- /dev/null
> +++ b/configs/am62x_beagleplay_a53_defconfig
> @@ -0,0 +1,3 @@
> +// The BeaglePlay defconfig for A53 core
> +#include "configs/am62x_evm_a53_defconfig"
> +#include "board/ti/am62x/beagleplay_a53.config"
> diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
> new file mode 100644
> index 00000000000..276b1f81a3e
> --- /dev/null
> +++ b/configs/am62x_beagleplay_r5_defconfig
> @@ -0,0 +1,3 @@
> +// The BeaglePlay defconfig for R5 core
> +#include "configs/am62x_evm_r5_defconfig"
> +#include "board/ti/am62x/beagleplay_r5.config"
> -- 
> 2.39.2
> 

my only complaint is that if we add lets say
board/ti/am62x/dfu.config, Then:

R5:
1. am62x_evm_r5_defconfig = am62x_evm_r5_defconfig
2. am62x_beagleplay_r5_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config
3. am62x_evm_r5_dfu_defconfig = am62x_evm_r5_defconfig + dfu.config
4. am62x_beagleplay_r5_dfu_defconfig = am62x_evm_r5_defconfig + beagleplay_r5.config + dfu.config

This information can be in a single txt file Rather than have a
defconfig file for each combination.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
