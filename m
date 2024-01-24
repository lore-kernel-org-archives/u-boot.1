Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9808C47E49
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 18:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A14D87C60;
	Wed, 24 Jan 2024 19:32:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="tfC5LvdL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD2987C3E; Wed, 24 Jan 2024 19:11:02 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 878DF876DE
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 19:11:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIAffY066707;
 Wed, 24 Jan 2024 12:10:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706119841;
 bh=rPuh7/eGSrFi9zEHwED6qqm+AT7oSWY5Z1+7lxADrNs=;
 h=Date:From:To:CC:Subject:References:In-Reply-To;
 b=tfC5LvdLIlL8elslJPjGG1aUaXq1ihppHW67WrXtGjdII6fnLrfa9a2o13kC7w/IR
 hZ9XsIkAMmFEEksqNO9wzt9cTYLP+iIayPbzNNbhmPvm4QzAWGG5tIrE51JXt89S0w
 1mV6I3EYhAaPkKIzU/THPLCit2UYxKyZvQK0ImBw=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIAfK6014966
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 12:10:41 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:10:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:10:41 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIAfC8073032;
 Wed, 24 Jan 2024 12:10:41 -0600
Date: Wed, 24 Jan 2024 12:10:41 -0600
From: Nishanth Menon <nm@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
CC: Dan Carpenter <dan.carpenter@linaro.org>, Maxime Ripard
 <mripard@kernel.org>, Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Stefan Roese <sr@denx.de>, Qu Wenruo <wqu@suse.com>, Bryan Brattlof
 <bb@ti.com>, Sean Anderson <seanga2@gmail.com>, Martyn Welch
 <martyn.welch@collabora.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nikhil M Jain <n-jain1@ti.com>, Kamlesh Gurudasani
 <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, Neha Malcom Francis
 <n-francis@ti.com>, Andrew Davis <afd@ti.com>, Simon Glass
 <sjg@chromium.org>, FUKAUMI Naoki <naoki@radxa.com>, Christian Hewitt
 <christianshewitt@gmail.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Kever Yang <kever.yang@rock-chips.com>, Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, <u-boot@lists.denx.de>,
 <srk@ti.com>, <r-gunasekaran@ti.com>
Subject: Re: [RFC PATCH v3 02/15] misc: fs-loader: Use fw_storage_interface
 instead of storage_interface
Message-ID: <20240124181041.ai4wjfvz7vfieluo@wages>
References: <20240124064930.1787929-1-danishanwar@ti.com>
 <20240124064930.1787929-3-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240124064930.1787929-3-danishanwar@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Wed, 24 Jan 2024 19:32:47 +0100
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

On 12:19-20240124, MD Danish Anwar wrote:
> The fs-loader driver reads env storage_interface and uses it to load
> firmware file into memory using the medium set by env. Update the driver
> to use env fw_storage_interface as this variable is only used to load
> firmwares. The env storage_interface will act as fallback so that the
> existing implementations do not break.
> 
> Also update the FS Loader documentation accordingly.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  doc/develop/driver-model/fs_firmware_loader.rst | 5 ++++-
>  drivers/misc/fs_loader.c                        | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
> index 149b8b436e..410cc1442d 100644
> --- a/doc/develop/driver-model/fs_firmware_loader.rst
> +++ b/doc/develop/driver-model/fs_firmware_loader.rst
> @@ -98,8 +98,11 @@ through the U-Boot environment variable during run time.
>  
>  For examples:
>  
> +fw_storage_interface:
> +  Firmware storage interface, it can be "mmc", "usb", "sata" or "ubi".
>  storage_interface:
> -  Storage interface, it can be "mmc", "usb", "sata" or "ubi".
> +  Storage interface, it can be "mmc", "usb", "sata" or "ubi". This acts
> +  as a fallback if fw_storage_interface is not set.
>  fw_dev_part:
>    Block device number and its partition, it can be "0:1".
>  fw_ubi_mtdpart:
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 1ffc199ba1..3798dab5b6 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -153,7 +153,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>  	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
>  	int ret;
>  
> -	storage_interface = env_get("storage_interface");
> +	storage_interface = env_get("fw_storage_interface");
> +	if (!storage_interface)
> +		storage_interface = env_get("storage_interface");
> +
>  	dev_part = env_get("fw_dev_part");
>  	ubi_mtdpart = env_get("fw_ubi_mtdpart");
>  	ubi_volume = env_get("fw_ubi_volume");
> -- 
> 2.34.1
> 

You should move these specific patches out of the series and debate on
their merits seperately. mixing things like these in a single series
that needs to go to multiple u-boot custodians just creates problems for
everyone.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
