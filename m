Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C67CC2BD09
	for <u-boot@archiver.kernel.org>; Fri, 28 Jun 2024 13:05:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA78888239;
	Fri, 28 Jun 2024 15:05:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lrXtpMlf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D505C88453; Fri, 28 Jun 2024 15:05:16 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF183807EC
 for <u-boot@lists.denx.de>; Fri, 28 Jun 2024 15:05:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 45SD5Ck8086816;
 Fri, 28 Jun 2024 08:05:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1719579912;
 bh=l1t2QmnfAwp7cuhNygWL0jwkxjMOzON/MRKpLz/2Znk=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=lrXtpMlfybKjKs3TOg9ucuTUi2/4zMvnVGuz5R7ewKdIV8keP1dHPt4M+NWrA83qw
 e75y+au7bp6O4WVFj3bgC6Q+b30QDMumximRMdGafbH+oXE7Tyt+xIC+oGuZIW2Rgd
 lVjaMVsRTJhHVz3aUzAWJ5yIseYZFovg1b8UEBG8=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 45SD5ChE029954
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 28 Jun 2024 08:05:12 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 28
 Jun 2024 08:05:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 28 Jun 2024 08:05:12 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 45SD5CZL006996;
 Fri, 28 Jun 2024 08:05:12 -0500
Date: Fri, 28 Jun 2024 08:05:12 -0500
From: Nishanth Menon <nm@ti.com>
To: Manorit Chawdhry <m-chawdhry@ti.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>, Tom
 Rini <trini@konsulko.com>, Vaishnav Achath <vaishnav.a@ti.com>, Jayesh
 Choudhary <j-choudhary@ti.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH 1/3] include: env: ti: mmc: Change name_fdt usage to
 fdtfile
Message-ID: <20240628130512.4hcrvcap72mgihga@preschool>
References: <20240628-b4-upstream-streamline-platform-v1-0-17659af992c1@ti.com>
 <20240628-b4-upstream-streamline-platform-v1-1-17659af992c1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240628-b4-upstream-streamline-platform-v1-1-17659af992c1@ti.com>
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

On 13:53-20240628, Manorit Chawdhry wrote:
> name_fdt is kept for backward compatibility but it depends on EEPROM
> detection logic and some of the platforms like J7AHP/AM69 don't have
> that anymore which causes boot failure.
> 
> Replacing name_fdt usage to fdtfile as fdtfile is populated based on
> CONFIG_DEFAULT_DEVICE_TREE.
> 
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> ---
>  include/env/ti/mmc.env | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/env/ti/mmc.env b/include/env/ti/mmc.env
> index 0256a2d2aaca..037a09010ce4 100644
> --- a/include/env/ti/mmc.env
> +++ b/include/env/ti/mmc.env
> @@ -16,7 +16,7 @@ importbootenv=echo Importing environment from mmc${mmcdev} ...;
>  loadbootenv=fatload mmc ${mmcdev} ${loadaddr} ${bootenvfile}
>  loadimage=load ${devtype} ${bootpart} ${loadaddr} ${bootdir}/${bootfile}
>  loadfdt=load ${devtype} ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}
> -get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${name_fdt}
> +get_fdt_mmc=load mmc ${bootpart} ${fdtaddr} ${bootdir}/dtb/${fdtfile}

Did you check the other users of mmc.env file? How about legacy boards like k2g?

>  envboot=if mmc dev ${mmcdev}; then
>  	if mmc rescan; then
>  		echo SD/MMC found on device ${mmcdev};
> 
> -- 
> 2.45.1
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
