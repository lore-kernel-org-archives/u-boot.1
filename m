Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F063CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 07:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6FC208711B;
	Tue,  7 Nov 2023 08:12:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OcM5SL5Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0744F8711B; Tue,  7 Nov 2023 08:12:41 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC41986689
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 08:12:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A77CYtq052058;
 Tue, 7 Nov 2023 01:12:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699341154;
 bh=d5f4wu+PV+bOQ2N41uydIx4aEV+35rmPRCnqB01iQo0=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=OcM5SL5YnuCw6EbCgixigl0oU56UwqDEtQ5ofDFMr+54oagqQPiE0exb9Ve0kowdZ
 9IHu7AAKAYGcB9OrVU+v+GNohHRgM0EEPuHBwZALxvtVzP3P9kY+/mcrZDFaLCdFjU
 ZTei9MdNuys9Twn7xxVRjVTgtp7S8WWGnwf+gjS0=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A77CYlS126504
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 7 Nov 2023 01:12:34 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 7
 Nov 2023 01:12:33 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 7 Nov 2023 01:12:33 -0600
Received: from [172.24.227.36] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A77C0rQ059795;
 Tue, 7 Nov 2023 01:12:30 -0600
Message-ID: <c7089c53-d096-4ccd-b19f-8e108e8715c1@ti.com>
Date: Tue, 7 Nov 2023 12:42:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/12] configs: j7200_evm_a72_defconfig: Switch to
 bootstd
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>, Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Andrew Davis <afd@ti.com>, Simon Glass <sjg@chromium.org>,
 Robert Nelson <robertcnelson@gmail.com>, Jason Kridner
 <jkridner@beagleboard.org>, <u-boot@lists.denx.de>
References: <20231104072150.3339-1-nm@ti.com>
 <20231104072150.3339-12-nm@ti.com>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20231104072150.3339-12-nm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
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

On 04/11/23 12:51, Nishanth Menon wrote:
> Switch to using bootstd. Note with this change, we will stop using
> distro_bootcmd and instead depend entirely on bootflow method of
> starting the system up.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>   configs/j7200_evm_a72_defconfig | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
> index 889358afc316..b7bc9ad178f6 100644
> --- a/configs/j7200_evm_a72_defconfig
> +++ b/configs/j7200_evm_a72_defconfig
> @@ -29,10 +29,11 @@ CONFIG_SPL_SPI=y
>   # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
>   CONFIG_SPL_LOAD_FIT=y
>   CONFIG_SPL_LOAD_FIT_ADDRESS=0x81000000
> -CONFIG_DISTRO_DEFAULTS=y
>   CONFIG_OF_BOARD_SETUP=y
>   CONFIG_OF_SYSTEM_SETUP=y
> -CONFIG_BOOTCOMMAND="run envboot; run distro_bootcmd;"
> +CONFIG_BOOTSTD_FULL=y
> +CONFIG_BOOTSTD_DEFAULTS=y
> +CONFIG_BOOTCOMMAND="run envboot; bootflow scan -lb"
>   CONFIG_LOGLEVEL=7
>   CONFIG_SPL_MAX_SIZE=0xc0000
>   CONFIG_SPL_HAS_BSS_LINKER_SECTION=y

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis
