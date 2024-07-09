Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E99C2BD09
	for <u-boot@archiver.kernel.org>; Tue,  9 Jul 2024 04:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D4CE8848D;
	Tue,  9 Jul 2024 06:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BAJrH2p+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6073F884B0; Tue,  9 Jul 2024 06:43:52 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D75687F5C
 for <u-boot@lists.denx.de>; Tue,  9 Jul 2024 06:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=m-chawdhry@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4694hlY8122114;
 Mon, 8 Jul 2024 23:43:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1720500227;
 bh=J6fkjHsU3YI5isiiN3nqTeS77V2J0yNcEjeQKv+uFxY=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=BAJrH2p+jX4cNGGAw+nOXapwrW/qakn63hOirL7V+rmrd0bLGBbU5JVxGiV8zaQSU
 D2nDXvqNQtDIS9G6pKjqqD7pkx1q3NYme0qCHrdTCt5fkur7x7qlXlpoux07J0auZZ
 4GJl7VTyYt/1rrQhgTr6hkIovp2FdEi+aRItUe3w=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4694hlHr027260
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 8 Jul 2024 23:43:47 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 8
 Jul 2024 23:43:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 8 Jul 2024 23:43:47 -0500
Received: from localhost (uda0497581.dhcp.ti.com [10.24.68.185])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4694hkZS058068;
 Mon, 8 Jul 2024 23:43:47 -0500
Date: Tue, 9 Jul 2024 10:13:46 +0530
From: Manorit Chawdhry <m-chawdhry@ti.com>
To: Kamlesh Gurudasani <kamlesh@ti.com>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>,
 <u-boot@lists.denx.de>, <vigneshr@ti.com>, <praneeth@ti.com>,
 <u-kumar1@ti.com>
Subject: Re: [PATCH] configs: am62x_evm_a53_defconfig: Remove
 CONFIG_SYS_BOOTM_LEN
Message-ID: <20240709044346.jyntpefkhpgdfd2x@uda0497581>
References: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240708-remove-bootm-len-v1-1-2a537061426c@ti.com>
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

Hi Kamlesh,

On 17:20-20240708, Kamlesh Gurudasani wrote:
> Increase the maximum size of the buffer that is used to decompress
> the OS image in to.
> 
> If image size is greater than the buffer, boot
> will fail with following error,
> "Error: inflate() returned -5"
> "gzip compressed: uncompress error -1"
> 
> Default limit for ARM64 platforms is 0x4000000, remove
> CONFIG_SYS_BOOTM_LEN=0x8000000, so that it follows default limit.

Why were we failing with a larger buffer size..?

Regards,
Manorit

> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  configs/am62x_evm_a53_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/configs/am62x_evm_a53_defconfig b/configs/am62x_evm_a53_defconfig
> index ca993b427b..dfa5ecc847 100644
> --- a/configs/am62x_evm_a53_defconfig
> +++ b/configs/am62x_evm_a53_defconfig
> @@ -32,7 +32,6 @@ CONFIG_SPL_SPI=y
>  CONFIG_SPL_LOAD_FIT=y
>  CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
>  CONFIG_BOOTSTD_FULL=y
> -CONFIG_SYS_BOOTM_LEN=0x800000
>  CONFIG_BOOTCOMMAND="run findfdt; run envboot; bootflow scan -lb"
>  CONFIG_BOARD_LATE_INIT=y
>  CONFIG_SPL_MAX_SIZE=0x58000
> 
> ---
> base-commit: fd46ea0e701920eb205c2bce9d527bf0dec10b59
> change-id: 20240708-remove-bootm-len-ab4e46039656
> 
> Best regards,
> -- 
> Kamlesh Gurudasani <kamlesh@ti.com>
> 
