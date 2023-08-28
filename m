Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E97EC83F11
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 17:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A13C186483;
	Mon, 28 Aug 2023 19:33:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fIRejZgK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 164678647F; Mon, 28 Aug 2023 19:33:22 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA104864B3
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 19:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37SHXG6S091576;
 Mon, 28 Aug 2023 12:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1693243996;
 bh=Q/Mt1FAICTpW6QZ5qYzbI0Jp/Tz4NUA0UUC8ySigYnY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=fIRejZgKyH2ar/OhpXjSjd3ocMoX/aTF2n66k7qs5bh2hP1ED0oaaI0u19Z539GgX
 kypiIbMqBKoGYKBWFtbxpf8q9nCbr820algvn2SuJu3vqK/Q37HiuARV1xoBTrPLT2
 L1TU11zn+xG+UE/JXINqBvQ3q59tj0bXYppJCnGU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37SHXGca102988
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 28 Aug 2023 12:33:16 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 28
 Aug 2023 12:33:16 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 28 Aug 2023 12:33:16 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37SHXGEf059639;
 Mon, 28 Aug 2023 12:33:16 -0500
Date: Mon, 28 Aug 2023 12:33:16 -0500
From: Nishanth Menon <nm@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <u-boot@lists.denx.de>,
 <vigneshr@ti.com>, <u-kumar1@ti.com>, <reidt@ti.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <sinthu.raja@ti.com>,
 <gadiyar@ti.com>, <a-nandan@ti.com>, <vaishnav.a@ti.com>
Subject: Re: [PATCH v1 0/4] J721E DTS Sync with Kernel v6.5-rc1
Message-ID: <20230828173316.tpzluxjvcnwmcyjj@circus>
References: <20230828113109.2533045-1-n-francis@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230828113109.2533045-1-n-francis@ti.com>
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

On 17:01-20230828, Neha Malcom Francis wrote:
> This series aims to sync kernel.org v6.5-rc1 DTS with that of U-Boot. It
> also includes cleanups where necessary along with certain changes to
> ensure boot is unaffected.
> 
> While it's mainly synced to the tag v6.5-rc1, one extra commit has been
> added that cleans up duplicating wkup_i2c0 nodes [1] in Kernel.
> 
> Same as with other board series that have taken up this effort, cleanup
> of mcu_ringacc and mcu_udmap are dependent on MCU Ringacc [2] and DMA
> [3] fixes. This will be taken up after their merge to Linux.
> 
> [1] https://lore.kernel.org/all/20230721082344.1534094-1-u-kumar1@ti.com/
> [2] https://lore.kernel.org/all/20230809175932.2553156-1-vigneshr@ti.com/
> [3] https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/
> 
> Boot logs:
> https://gist.github.com/nehamalcom/231426b784e0ba96ef3a0da84346e038
> 
> Neha Malcom Francis (4):
>   arm: dts: k3-j721e-r5: Clean up inclusion hierarchy
>   arm: dts: k3-j721e: Sync with v6.5-rc1
>   drivers: misc: k3_avs: Add linux compatible to maintain sync
>   configs: j721e: Remove HBMC_AM654 config
please change the order of patches:
a) introduce the driver change for vtm
b) cleanup config and drop the hbmc node stuff
c) rest of dts sync

NOTE:
* J721e does'nt use SYSFW - it uses TIFS
* for properties that dont use bootph or u-boot, properties, we
  should'nt be including property changes in u-boot.dtsi or r5.dts
  without explanation as to what.
* There is a bunch of /delete-property/ plugged in for no clear reason.
  I see that even for timer - but timer data could have been included in
  arch/arm/mach-k3/j721e/dev-data.c and so could have been others too.
  This needs clear explanation.

> 
>  .../k3-j721e-common-proc-board-u-boot.dtsi    | 139 ++-
>  arch/arm/dts/k3-j721e-common-proc-board.dts   | 483 ++++++---
>  arch/arm/dts/k3-j721e-main.dtsi               | 974 ++++++++++++++++--
>  arch/arm/dts/k3-j721e-mcu-wakeup.dtsi         | 280 ++++-
>  .../k3-j721e-r5-common-proc-board-u-boot.dtsi |  29 -
>  .../arm/dts/k3-j721e-r5-common-proc-board.dts | 308 +-----
>  arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi       |  31 -
>  arch/arm/dts/k3-j721e-r5-sk.dts               | 536 +---------
>  arch/arm/dts/k3-j721e-sk-u-boot.dtsi          | 158 +--
>  arch/arm/dts/k3-j721e-sk.dts                  | 663 +++++++++---
>  arch/arm/dts/k3-j721e-som-p0.dtsi             | 213 ++--
>  arch/arm/dts/k3-j721e-thermal.dtsi            |  75 ++
>  arch/arm/dts/k3-j721e.dtsi                    |  32 +-
>  configs/j721e_evm_a72_defconfig               |   1 -
>  configs/j721e_evm_r5_defconfig                |   1 -
>  drivers/misc/k3_avs.c                         |   1 +
>  16 files changed, 2428 insertions(+), 1496 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-j721e-r5-common-proc-board-u-boot.dtsi
>  delete mode 100644 arch/arm/dts/k3-j721e-r5-sk-u-boot.dtsi
>  create mode 100644 arch/arm/dts/k3-j721e-thermal.dtsi
> 
> -- 
> 2.34.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
