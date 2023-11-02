Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D07C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 17:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B5D98714F;
	Thu,  2 Nov 2023 18:34:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dfcRTv8M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E155A87725; Thu,  2 Nov 2023 18:34:26 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF06F86EB5
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 18:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A2HYHuh031040;
 Thu, 2 Nov 2023 12:34:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1698946457;
 bh=qNkTpktVmFuj4ANfaaJw0UmzN5AS+Tm3pEXU3FkygTk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=dfcRTv8MXQlVTI1q2lL7/rd2xXc8nZvD4Z9gS+TqErhtX9CnYN5sJhTyIQNuC5xnv
 QRdcDrOAWcDQ2ZoKl73b2uc7TzaSUReNjBsXabKpQ9CV/zbYPIcIGHqgwv5xlpWRQp
 ccMH2YkvQcqzEeYA0xF7RqNN+5EBFL3/sZQt4bk8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A2HYHlb021690
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 2 Nov 2023 12:34:17 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 2
 Nov 2023 12:34:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 2 Nov 2023 12:34:17 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A2HYHCM046086;
 Thu, 2 Nov 2023 12:34:17 -0500
Date: Thu, 2 Nov 2023 12:34:17 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>, Praneeth Bajjuri
 <praneeth@ti.com>, Robert Nelson <robertcnelson@gmail.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Jan Kiszka <jan.kiszka@siemens.com>, Heinrich
 Schuchardt <heinrich.schuchardt@canonical.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] configs: Add am62x_beagleplay_* defconfigs
Message-ID: <20231102173417.ts32zfd3sf7ojner@margarine>
References: <20231101170519.39627-1-afd@ti.com>
 <20231101170519.39627-3-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231101170519.39627-3-afd@ti.com>
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

On 12:05-20231101, Andrew Davis wrote:
> Add am62x_beagleplay_r5_defconfig for R5 SPL and
> am62x_beagleplay_a53_defconfig for A53 SPL and U-Boot support.
> 
> These defconfigs are composite defconfigs built from the config fragment
> board/ti/am62x/beagleplay_*.config applied onto the base
> am62x_evm_*_defconfig.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
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

Let us also update the documentation doc/board/ti/am62x_beagleplay.rst
to point people to this configuration?


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
