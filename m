Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9FBAE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 06:04:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7BFA80654;
	Mon, 23 Dec 2024 07:04:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="XMr5zCqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 449C680655; Mon, 23 Dec 2024 07:04:23 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 784FD80642
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 07:04:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN64CA0806968
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 00:04:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734933852;
 bh=LgjFb8YSiVX81J8Mm4eUkypdnjiNZzlGMGMnAIwx84c=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=XMr5zCqZ94DxFSJixlXNqz4Oge7VV1mSjYvp97eZ+QMKdXLKcy3shzWpowLn0109P
 rewecBb/zNmK4Vpo/hLFLEF7axUAbsq71nujLYrL4lVFF/1S+WZwf78sw9ZmV/3Q9Q
 Uukfv5xuby4A55LdIPGifS4CRv49VQr65s+4eY6A=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BN64Ckq097257
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 23 Dec 2024 00:04:12 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 23
 Dec 2024 00:04:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 23 Dec 2024 00:04:11 -0600
Received: from localhost (uda0497581.dhcp.ti.com [172.24.227.240])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BN64BSH013054;
 Mon, 23 Dec 2024 00:04:11 -0600
Date: Mon, 23 Dec 2024 11:34:10 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: Simon Glass <sjg@chromium.org>, Alper Nebi Yasak
 <alpernebiyasak@gmail.com>, Tom Rini <trini@konsulko.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, <u-boot@lists.denx.de>, Neha Malcom Francis
 <n-francis@ti.com>, Aniket Limaye <a-limaye@ti.com>, Beleswar Padhi
 <b-padhi@ti.com>, Nishanth Menon <nm@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Keerthy <j-keerthy@ti.com>
Subject: Re: [PATCH RFC 8/8] configs: Introduce configs for J742S2
Message-ID: <20241223060410.l3pqnaitn3r6bbjn@uda0497581>
References: <20241217-b4-upstream-j742s2-v1-0-13a6a127b344@ti.com>
 <20241217-b4-upstream-j742s2-v1-8-13a6a127b344@ti.com>
 <a61dd9fd-96c4-4e40-9a92-6f16d846c4ee@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a61dd9fd-96c4-4e40-9a92-6f16d846c4ee@ti.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Hi Udit,

On 19:44-20241222, Kumar, Udit wrote:
> 
> On 12/17/2024 4:37 PM, Manorit Chawdhry wrote:
> > Based off j784s4 configs with delta changes for J742S2
> > 
> > [ Add AVS support for J742S2 ]
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > ---
[..]
> > diff --git a/configs/j742s2_evm_r5_defconfig b/configs/j742s2_evm_r5_defconfig
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..2be6318df76632dd2cc5cbeebcb6ce674cd80338
> > --- /dev/null
> > +++ b/configs/j742s2_evm_r5_defconfig
> > @@ -0,0 +1,9 @@
> > +#include <configs/j784s4_evm_r5_defconfig>
> > +
> > +CONFIG_ARM=y
> > +CONFIG_ARCH_K3=y
> > +CONFIG_SOC_K3_J784S4=y
> 
> Isn't above enabled by j784s4_evm_r5_defconfig

These are actually required by buildman to be functional so even if we
have them we need to re-define these after including as well iiuc.

> 
> 
> > +CONFIG_TARGET_J742S2_R5_EVM=y
> > +CONFIG_DEFAULT_DEVICE_TREE="k3-j742s2-r5-evm"
> > +CONFIG_SPL_OF_LIST="k3-j742s2-r5-evm"
> 
> Also, AVS is enable with
> https://lore.kernel.org/all/20241118105714.1973573-2-n-francis@ti.com/
> series
> 
> So please update k3_avs.c if needed as part of initial series.

I think this should not be required, we have the DT parsing and the
configs are propagated from j784s4 configs only. The vtm node is also
kept in common file (k3-j784s4-r5.dtsi) so that should also be here so I
think we have the necessary stuff for keeping AVS functional.. 

Regards,
Manorit
