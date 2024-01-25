Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F47EC47258
	for <u-boot@archiver.kernel.org>; Thu, 25 Jan 2024 04:53:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4ED3F8716D;
	Thu, 25 Jan 2024 05:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="dfj3K+Ha";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D02487128; Thu, 25 Jan 2024 05:45:49 +0100 (CET)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54D47870D9
 for <u-boot@lists.denx.de>; Thu, 25 Jan 2024 05:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=danishanwar@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40P4jN9v092173;
 Wed, 24 Jan 2024 22:45:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706157923;
 bh=xFqLMb8AvIitOhtJvoMV66DShF2dmy8z0jhZMLrTYYA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=dfj3K+HagnmCdxgU/WZiAJjH/+OIdiOPicDmZsOH8llsLZ6uXw38eXFcpGU2QLENj
 /qJsSbU2uq8dfKp3u3GJyVCExUbDvmdzyHX0iGZQlpjZwcJTNOv2AKjgE6yAGTOzlX
 weN14Is0IGZqBGTF6ORgPFQUuEcYuSuiqtayeq+M=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40P4jN9L116827
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jan 2024 22:45:23 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 22:45:22 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 22:45:22 -0600
Received: from [10.249.135.225] ([10.249.135.225])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40P4jCKb014024;
 Wed, 24 Jan 2024 22:45:13 -0600
Message-ID: <428ef951-f00d-4938-8663-d59a47e9fcfe@ti.com>
Date: Thu, 25 Jan 2024 10:15:11 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/15] misc: fs-loader: Use fw_storage_interface
 instead of storage_interface
To: Nishanth Menon <nm@ti.com>, MD Danish Anwar <danishanwar@ti.com>
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
References: <20240124064930.1787929-1-danishanwar@ti.com>
 <20240124064930.1787929-3-danishanwar@ti.com>
 <20240124181041.ai4wjfvz7vfieluo@wages>
Content-Language: en-US
From: "Anwar, Md Danish" <a0501179@ti.com>
In-Reply-To: <20240124181041.ai4wjfvz7vfieluo@wages>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Thu, 25 Jan 2024 05:53:11 +0100
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

Hi Nishant,

On 1/24/2024 11:40 PM, Nishanth Menon wrote:
> On 12:19-20240124, MD Danish Anwar wrote:
>> The fs-loader driver reads env storage_interface and uses it to load
>> firmware file into memory using the medium set by env. Update the driver
>> to use env fw_storage_interface as this variable is only used to load
>> firmwares. The env storage_interface will act as fallback so that the
>> existing implementations do not break.
>>
>> Also update the FS Loader documentation accordingly.
>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  doc/develop/driver-model/fs_firmware_loader.rst | 5 ++++-
>>  drivers/misc/fs_loader.c                        | 5 ++++-
>>  2 files changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/doc/develop/driver-model/fs_firmware_loader.rst b/doc/develop/driver-model/fs_firmware_loader.rst
>> index 149b8b436e..410cc1442d 100644
>> --- a/doc/develop/driver-model/fs_firmware_loader.rst
>> +++ b/doc/develop/driver-model/fs_firmware_loader.rst
>> @@ -98,8 +98,11 @@ through the U-Boot environment variable during run time.
>>  
>>  For examples:
>>  
>> +fw_storage_interface:
>> +  Firmware storage interface, it can be "mmc", "usb", "sata" or "ubi".
>>  storage_interface:
>> -  Storage interface, it can be "mmc", "usb", "sata" or "ubi".
>> +  Storage interface, it can be "mmc", "usb", "sata" or "ubi". This acts
>> +  as a fallback if fw_storage_interface is not set.
>>  fw_dev_part:
>>    Block device number and its partition, it can be "0:1".
>>  fw_ubi_mtdpart:
>> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
>> index 1ffc199ba1..3798dab5b6 100644
>> --- a/drivers/misc/fs_loader.c
>> +++ b/drivers/misc/fs_loader.c
>> @@ -153,7 +153,10 @@ static int fw_get_filesystem_firmware(struct udevice *dev)
>>  	char *storage_interface, *dev_part, *ubi_mtdpart, *ubi_volume;
>>  	int ret;
>>  
>> -	storage_interface = env_get("storage_interface");
>> +	storage_interface = env_get("fw_storage_interface");
>> +	if (!storage_interface)
>> +		storage_interface = env_get("storage_interface");
>> +
>>  	dev_part = env_get("fw_dev_part");
>>  	ubi_mtdpart = env_get("fw_ubi_mtdpart");
>>  	ubi_volume = env_get("fw_ubi_volume");
>> -- 
>> 2.34.1
>>
> 
> You should move these specific patches out of the series and debate on
> their merits seperately. mixing things like these in a single series
> that needs to go to multiple u-boot custodians just creates problems for
> everyone.
> 

I have kept these patches in the series because ICSSG driver depends on
these patches. I didn't want to post multiple series and map
dependencies so I posted all patches in one series. Patch 1 to 3 are
dependency for ICSSG driver. Patch 4 to 9 are ICSSG driver patches.
Patch 10 to 15 are AM65x-EVM specific patches (DTS and configs).

The first 3 patches will also go to different u-boot custodians as first
one is dma related, second one is related to fs-loader driver and the
third one modifies the remoteproc driver. So instead of posting all
these separately, I wanted to post it along with the ICSSG driver series
so that folks can understand why these three patches are needed.

-- 
Thanks and Regards,
Md Danish Anwar
