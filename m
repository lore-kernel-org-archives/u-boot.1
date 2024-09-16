Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E60EC3ABB2
	for <u-boot@archiver.kernel.org>; Mon, 16 Sep 2024 13:27:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D07B688001;
	Mon, 16 Sep 2024 15:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Ibv1rkjs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9457885F4; Mon, 16 Sep 2024 15:27:26 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 732AB86BF1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 15:27:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 48GDRK1G037232;
 Mon, 16 Sep 2024 08:27:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1726493240;
 bh=cGW5/a9q4lsYLkIMnx6CxDamSkSCAqfQ4n1m8NTS3K0=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Ibv1rkjsshx2wTUh4R8UgUQ2GkmQrL+xMSTISciR3bIvLWqHsQ2meP0ZonB4hpaea
 LNOYMxZ0TjXW+qavhFlSmcNMnIYKw7NuWDeW9SKPn0wjdfvohXXWgiXJvrWgVDNy7M
 S6ROXeMdlC00zTEinZN1B2Ga7G8PR2n7gKSuvdeI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 48GDRKOI003079
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 16 Sep 2024 08:27:20 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 16
 Sep 2024 08:27:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 16 Sep 2024 08:27:20 -0500
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 48GDRKo2065703;
 Mon, 16 Sep 2024 08:27:20 -0500
Date: Mon, 16 Sep 2024 08:27:20 -0500
From: Bryan Brattlof <bb@ti.com>
To: Guillaume La Roque <glaroque@baylibre.com>
CC: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, <u-boot@lists.denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Vishal Mahaveer <vishalm@ti.com>
Subject: Re: [PATCH v2 3/3] board: ti: am62px: Add android bootflow support
Message-ID: <20240916132720.r3tstmbxmbqpvncb@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20240912-sitaraupstream-v2-0-2101323d3fa5@baylibre.com>
 <20240912-sitaraupstream-v2-3-2101323d3fa5@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20240912-sitaraupstream-v2-3-2101323d3fa5@baylibre.com>
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

Hi Guillaume!

On September 12, 2024 thus sayeth Guillaume La Roque:
> From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> When CONFIG_BOOTMETH_ANDROID is set, enable Android boot flow support.
> 
> To build for AM62Px for Android, we can re-use
> the am62x_a53_android.config fragment when building A53 bootloaders:
> 
>   $ make am62px_evm_a53_defconfig
>   $ make am62x_a53_android.config
>   $ make
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  board/ti/am62px/am62px.env | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
> index f8b6aff2c2fd..7ef54079aa8d 100644
> --- a/board/ti/am62px/am62px.env
> +++ b/board/ti/am62px/am62px.env
> @@ -13,3 +13,8 @@ mmcdev=1
>  bootpart=1:2
>  bootdir=/boot
>  rd_spec=-
> +
> +#if CONFIG_BOOTMETH_ANDROID
> +#include <env/ti/android.env>
> +adtb_idx=3
> +#endif
> \ No newline at end of file

It's odd that checkpatch.pl didn't complain about this. Or maybe it has 
never complained about newlines? my git hook script didn't complain so 
IDK. Anywho just wanted to point out the nitpick ;)

~Bryan
