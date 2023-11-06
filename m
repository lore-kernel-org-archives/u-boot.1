Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F2FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 05:28:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93B0886828;
	Mon,  6 Nov 2023 06:28:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Y5tcyLu1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B030A86828; Mon,  6 Nov 2023 06:28:38 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E25864F3
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 06:28:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A65SR37124812;
 Sun, 5 Nov 2023 23:28:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699248507;
 bh=pcOVTlz9I+RLtDnuL9mUbRp6QR/KbZUcQHTcgmXmH+k=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=Y5tcyLu1dHfVNetDblBxK9h1sKZnIDVTEF2PrHHXm+dzYjDlgiXzMQBil9XBqhJuO
 YFhYrYt08jCTpSZXFFdWlBcNk3M5DVtQoqQmQVLRyCONMCBRyUwoFO2KwxHNN1S3Lj
 h1/t5t0Yynhb2wq8ebimNtidkouAGqRmVIRtKJjU=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A65SReg015378
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 5 Nov 2023 23:28:27 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 5
 Nov 2023 23:28:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 5 Nov 2023 23:28:27 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A65SQtD105622;
 Sun, 5 Nov 2023 23:28:27 -0600
Date: Mon, 6 Nov 2023 10:58:26 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Nishanth Menon <nm@ti.com>
CC: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sinthu Raja <sinthu.raja@ti.com>, Reid Tonking <reidt@ti.com>, Neha Malcom
 Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
Subject: Re: [PATCH 10/15] configs: j721e_evm_a72_defconfig: Switch to bootstd
Message-ID: <20231106052826.nbtzqzudnh7v3yix@ula0497581>
References: <20231103003805.2420005-1-nm@ti.com>
 <20231103003805.2420005-11-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231103003805.2420005-11-nm@ti.com>
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

Hi Nishanth,

On 19:38-20231102, Nishanth Menon wrote:
> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  configs/j721e_evm_a72_defconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/j721e_evm_a72_defconfig b/configs/j721e_evm_a72_defconfig
> index 99e0e168ebf7..98ac7ca59789 100644
> --- a/configs/j721e_evm_a72_defconfig
> +++ b/configs/j721e_evm_a72_defconfig
> @@ -29,10 +29,11 @@ CONFIG_SPL_SPI=y
>  # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> -CONFIG_DISTRO_DEFAULTS=y
>  CONFIG_OF_BOARD_SETUP=y
>  CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"

Coming back to [0], AM62x didn't have early remote procs but j721e does,
do you have any alternatives in place before migrating J7 platforms to
stdboot?

Regards,
Manorit

[0]: https://lore.kernel.org/u-boot/20231005171010.zvza7uqyn4mcgp5g@handsaw/

>  CONFIG_LOGLEVEL=7
>  CONFIG_SPL_MAX_SIZE=0xc0000
>  CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -- 
> 2.40.0
> 
