Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF19C54E67
	for <u-boot@archiver.kernel.org>; Wed, 20 Mar 2024 05:49:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F7B587F78;
	Wed, 20 Mar 2024 06:49:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RYt+OEhb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B46880D2; Wed, 20 Mar 2024 06:49:19 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60DA8871C7
 for <u-boot@lists.denx.de>; Wed, 20 Mar 2024 06:49:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42K5n7xa050672;
 Wed, 20 Mar 2024 00:49:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1710913747;
 bh=c8+bhSy4ovI5gZxPTDK/3lgI5M96t+9f1NTvSKyCKyo=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=RYt+OEhbyKXAEByoqFvCrvDW/lihXWNuffDlUS31hVgb5j2anwyXZE6VNmrNFONhX
 ExixHDM7f5VV1uiibQnqLOwNavisj8Z8i3lUG8JJ7binrvijMXgyqhVbCqpYdtpiY/
 bt9z5ttRMEnLSV3yyiFnSCdA5bYYi7XgaviLFZKo=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42K5n7KP029999
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 20 Mar 2024 00:49:07 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 00:49:07 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 00:49:07 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42K5n2m4017545;
 Wed, 20 Mar 2024 00:49:03 -0500
Message-ID: <3b588cc0-225e-466d-9257-f0f4ef592cf3@ti.com>
Date: Wed, 20 Mar 2024 11:19:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] remoteproc: uclass: Add methods to load firmware to
 rproc and boot rproc
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>
CC: Francesco Dolcini <francesco.dolcini@toradex.com>, Max Krummenacher
 <max.krummenacher@toradex.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 Simon Glass <sjg@chromium.org>,
 Ravi Gunasekaran <r-gunasekaran@ti.com>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <srk@ti.com>, Vignesh
 Raghavendra <vigneshr@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20240228120645.958316-1-danishanwar@ti.com>
 <20240319224032.GA1686480@bill-the-cat>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20240319224032.GA1686480@bill-the-cat>
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

Hi Tom,

On 20/03/24 4:10 am, Tom Rini wrote:
> On Wed, Feb 28, 2024 at 05:36:45PM +0530, MD Danish Anwar wrote:
> 
>> Add APIs to set a firmware_name to a rproc and boot the rproc with the
>> same firmware.
>>
>> Clients can call rproc_set_firmware() API to set firmware_name for a rproc
>> whereas rproc_boot() will load the firmware set by rproc_set_firmware() to
>> a buffer by calling request_firmware_into_buf(). rproc_boot() will then
>> load the firmware file to the remote processor and start the remote
>> processor.
>>
>> Also include "fs-loader.h" and make remoteproc driver select FS_LOADER in
>> Kconfig so that we can call request_firmware_into_buf() from remoteproc
>> driver.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Acked-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
>> ---
>> Changes from v5 to v6:
>> *) Collected Acked-by tag from Ravi Gunasekaran <r-gunasekaran@ti.com>
>> *) Fixed few typos as pointed out by Roger Quadros <rogerq@kernel.org>
>> *) Added if condition to check if uc_pdata->fw_name exists and free it
>>    before the strndup as suggested by Roger Quadros <rogerq@kernel.org>
>>
>> Changes from v4 to v5:
>> *) Added Kconfig option REMOTEPROC_MAX_FW_SIZE to set max firmware size
>>    that can be loaded to a rproc.
>> *) Added freeing of address in rproc_boot() as pointed out by Ravi.
>> *) Allocating the address at a later point in rproc_boot()
>> *) Rebased on latest u-boot/master [commit 
>>    9e00b6993f724da9699ef12573307afea8c19284]
>>
>> Changes from v3 to v4:
>> *) No functional change. Splitted the patch out of the series as suggested
>>    by Nishant.
>> *) Droppped the RFC tag.
>>
>> v5: https://lore.kernel.org/all/20240217122602.3402774-1-danishanwar@ti.com/
>> v4: https://lore.kernel.org/all/20240130063322.2345057-1-danishanwar@ti.com/
>> v3: https://lore.kernel.org/all/20240124064930.1787929-4-danishanwar@ti.com/
>>
>>  drivers/remoteproc/Kconfig        |   8 +++
>>  drivers/remoteproc/rproc-uclass.c | 102 ++++++++++++++++++++++++++++++
>>  include/remoteproc.h              |  34 ++++++++++
>>  3 files changed, 144 insertions(+)
>>
>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>> index 781de530af..9f9877931c 100644
>> --- a/drivers/remoteproc/Kconfig
>> +++ b/drivers/remoteproc/Kconfig
>> @@ -10,6 +10,7 @@ menu "Remote Processor drivers"
>>  # All users should depend on DM
>>  config REMOTEPROC
>>  	bool
>> +	select FS_LOADER
>>  	depends on DM
>>  
>>  # Please keep the configuration alphabetically sorted.
> 
> Can we not make the FS_LOADER portion optional? I didn't realize how
> many non-TI platforms this impacted. And even then it's possible I
> assume that custom designs will load the firmwares in other manners.
> 

Yes we can. We can wrap the remoteproc APIs using FS_LOADER in #ifdef
CONFIG_FS_LOADER. And instead of REMOTEPROC driver selecting FS_LOADER,
the clinet driver (ICSSG in this case) who is calling those remoteproc
APIs will select FS_LOADER and enable it.

This will make sure that other platforms (ti or non-ti) that doesn't
support ICSSG but enables Remoteproc, will not enable FS_LOADER. This
way we are not forcing other platforms using remoteproc to enable
FS_LOADER. In this case the APIs will not get built.

Now FS_LOADER will only be enabled when there is a client driver that
uses rproc_boot() APIs. It's upto the client driver to enable FS_LOADER

below is the diff,

diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
index 9f9877931c..a49802c132 100644
--- a/drivers/remoteproc/Kconfig
+++ b/drivers/remoteproc/Kconfig
@@ -10,7 +10,6 @@ menu "Remote Processor drivers"
 # All users should depend on DM
 config REMOTEPROC
        bool
-       select FS_LOADER
        depends on DM

 # Please keep the configuration alphabetically sorted.
diff --git a/drivers/remoteproc/rproc-uclass.c
b/drivers/remoteproc/rproc-uclass.c
index f4f22a3851..a6a8be5009 100644
--- a/drivers/remoteproc/rproc-uclass.c
+++ b/drivers/remoteproc/rproc-uclass.c
@@ -994,6 +994,7 @@ int rproc_set_firmware(struct udevice *rproc_dev,
const char *fw_name)
        return 0;
 }

+#ifdef CONFIG_FS_LOADER
 int rproc_boot(struct udevice *rproc_dev)
 {
        struct dm_rproc_uclass_pdata *uc_pdata;
@@ -1063,3 +1064,4 @@ free_buffer:
        free(addr);
        return ret;
 }
+#endif

Let me know if this looks ok. If it's ok I will post v7 with this change.

-- 
Thanks and Regards,
Danish
