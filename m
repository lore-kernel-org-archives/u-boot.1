Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEBCC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 11:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27EFC87FD7;
	Tue, 27 Feb 2024 12:17:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cjk8XRF5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3919587FBF; Tue, 27 Feb 2024 12:17:51 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6764087FE3
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 12:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=r-gunasekaran@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41RBHUZL035217;
 Tue, 27 Feb 2024 05:17:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1709032650;
 bh=cI/zanFjogrfjHseEeqty3T+J1ngWXfWMFp7KHslrWg=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cjk8XRF5swyT25m3sx0XCR2QQg7oYppAsZ9RWinItq0TQkFj6gfvyZiLv8l1HumBH
 HQ3co1P/JOvQO+/jVukcheHGVVdfjAOL9ms9CCEf1xlJyvaenVDNFVBS9Vna99ZQJg
 i7Y76jdC477Wdp4fyAB3ZFw6NOt1brIE7ObnIT6M=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41RBHUk5002234
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 27 Feb 2024 05:17:30 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 05:17:30 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 05:17:30 -0600
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41RBHQm9129437;
 Tue, 27 Feb 2024 05:17:27 -0600
Message-ID: <8c46d212-da88-d513-73f3-355d17147fda@ti.com>
Date: Tue, 27 Feb 2024 16:47:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: MD Danish Anwar <danishanwar@ti.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>, Nishanth Menon <nm@ti.com>, Tom Rini
 <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>, Ravi Gunasekaran
 <r-gunasekaran@ti.com>
References: <20240217122602.3402774-1-danishanwar@ti.com>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240217122602.3402774-1-danishanwar@ti.com>
Content-Type: text/plain; charset="UTF-8"
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



On 2/17/24 5:56 PM, MD Danish Anwar wrote:
> Add APIs to set a firmware_name to a rproc and boot the rproc with the
> same firmware.
> 
> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
> load the firmware file to the remote processor and start the remote
> processor.
> 
> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
> Kconfig so that we can call request_firmware_into_buf() from remoteproc
> driver.
> 
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
> Changes from v4 to v5:
> *) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
>    that can be loaded to a rproc.
> *) Added freeing of address in rproc_boot() as pointed out by Ravi.
> *) Allocating the address at a later point in rproc_boot()
> *) Rebased on latest u-boot/master [commit 
>    9e00b6993f724da9699ef12573307afea8c19284]
> 
> Changes from v3 to v4:
> *) No functional change. Splitted the patch out of the series as suggested
>    by Nishant.
> *) Droppped the RFC tag.
> 
> v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@ti.com/
> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
> 
>  drivers/remoteproc/Kconfig        |   8 +++
>  drivers/remoteproc/rproc-uclass.c | 100 ++++++++++++++++++++++++++++++
>  include/remoteproc.h              |  34 ++++++++++
>  3 files changed, 142 insertions(+)
> 
> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> index 781de530af..759d21437a 100644
> --- a/drivers/remoteproc/Kconfig
> +++ b/drivers/remoteproc/Kconfig

[...]

> +
> +free_buffer:
> +	free(addr);

Thanks for taking care of freeing the memory.
Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>

[...]

-- 
Regards,
Ravi
