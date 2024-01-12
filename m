Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC07C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 21:28:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EFC8879E5;
	Fri, 12 Jan 2024 22:26:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vzmJO5dU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4FC387831; Fri, 12 Jan 2024 22:15:56 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44244807A7
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 22:15:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-humphreys@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFksv070791;
 Fri, 12 Jan 2024 15:15:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1705094146;
 bh=f9RTEVBfvz368HwiPAAh8Gr/a+iZaEsX6ugrilQCKUk=;
 h=From:To:CC:Subject:In-Reply-To:References:Date;
 b=vzmJO5dUEJ8jM25Mqi1hvVo76DcAdPzVlOT89NPTOquRzBL1bHpvzlUyj4VJDTBQK
 Szhv0TRCoYXGEAHIEYu8rM9ypx78AKfVov8O5oLrc20fEqsE4cRuQIsTeevJskfzQY
 h4ZJswojCwPTc9CVavs4zpCYzTPuc6VpuNUjw144=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40CLFkVu103627
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 12 Jan 2024 15:15:46 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 12
 Jan 2024 15:15:46 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 12 Jan 2024 15:15:46 -0600
Received: from localhost (udb0321960.dhcp.ti.com [128.247.81.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40CLFkcE062421;
 Fri, 12 Jan 2024 15:15:46 -0600
From: Jon Humphreys <j-humphreys@ti.com>
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Kamlesh Gurudasani <kamlesh@ti.com>, Sinthu Raja <sinthu.raja@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Roger Quadros <rogerq@kernel.org>, Simon Glass
 <sjg@chromium.org>, Andrew Davis <afd@ti.com>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Nikhil M Jain <n-jain1@ti.com>, "Manorit
 Chawdhry" <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>, <u-boot@lists.denx.de>,
 Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V2 10/10] include: env: ti: Drop default_findfdt
In-Reply-To: <20240109191506.3820908-11-nm@ti.com>
References: <20240109191506.3820908-1-nm@ti.com>
 <20240109191506.3820908-11-nm@ti.com>
Date: Fri, 12 Jan 2024 15:15:46 -0600
Message-ID: <86bk9qckxp.fsf@udb0321960.dhcp.ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 12 Jan 2024 22:26:42 +0100
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

Nishanth Menon <nm@ti.com> writes:

> We shouldn't need finfdt anymore. Drop the env script.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> Changes from V1: None.
>
> V1: https://lore.kernel.org/r/20240108173301.2692332-11-nm@ti.com
>  include/env/ti/default_findfdt.env | 12 ------------
>  1 file changed, 12 deletions(-)
>  delete mode 100644 include/env/ti/default_findfdt.env
>
> diff --git a/include/env/ti/default_findfdt.env b/include/env/ti/default_findfdt.env
> deleted file mode 100644
> index a2b51dd923bb..000000000000
> --- a/include/env/ti/default_findfdt.env
> +++ /dev/null
> @@ -1,12 +0,0 @@
> -default_device_tree=CONFIG_DEFAULT_DEVICE_TREE
> -default_device_tree_arch=ti
> -#ifdef CONFIG_ARM64
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> -#else
> -default_device_tree_subarch=omap
> -findfdt=
> -	setenv name_fdt ${default_device_tree_arch}/${default_device_tree_subarch}/${default_device_tree}.dtb;
> -	setenv fdtfile ${name_fdt}
> -#endif
> -- 
> 2.43.0

Reviewed-by: Jonathan Humphreys <j-humphreys@ti.com>
