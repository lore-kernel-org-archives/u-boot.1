Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EB95E71D2A
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 12:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A71AE86ED1;
	Fri, 29 Sep 2023 14:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K475lA2z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E44D586ED3; Fri, 29 Sep 2023 14:55:39 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B0686EAC
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 14:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PdCGa5ztubho8gzlbAo55HqgBkTeS7MhOfoVzFyIPZVXsnQjVAKXsbcfnLTREMO5cjeOSUe2j8ZyUvu6lyFxpOhM+sf6zeyBYK4ADEMmvdaQ+8d6UfES8TJ0f0DKWjclyn9wkUVUYYonfJQT+Xxa1yuZOLbs25hnrBXxNu4dglesCyj3YBnZxHPBBCDAdhvs25hxNkmczMouyxdSTgU50HePhYzN3HZ49UnaGnu+4gBd2zpGEPiQpZAoDycsnSCFJ4EUV+e+oRk8yDuGHuLeCWQO6LcnoRv1zyR0MBQfEaicF9hfZ8JLpWBhCb4aRhrch1ZT+FnrCAXh9PrWZY+I4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2YdTD34a1j8B4A2gJBd8Jsj32wNo8gvkEqdv3SCvPI=;
 b=lgrs2gJSOqW4rhrXm5SaqwRPN0Ou3y4Is67w44GFbXEVm+Q5uk4DSA7/+Nc2w8X5XJlNgtp+LnKkjExpAEvN2LeIoDnjMxFGKdF1sQr/FiFPoaDSFES8+GPny7EpL3MWpNeCo2LEB6wKTNetfT7QKT0vZYpKJx3bhlqUj13CgpMQfOmTQhs+lphogvNRT1vHLpbCKJCDRX25KsfVULC4djSikALNU3lt9WjAKuDgXb7P8iXXqaKDkDsHqBZumOKRwZqQsGexxTdOXyelpTurH1Zfk+cpMKWVKKfl1stj57IU8cqlde4vX7fTPT/zZnYTcbWJ6VVdDYDs2NaI8T0hFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2YdTD34a1j8B4A2gJBd8Jsj32wNo8gvkEqdv3SCvPI=;
 b=K475lA2za0cBKfkbrGEuc1WqXc6Hh2Hjp/yHZw+V6TNQXJ/fHNBOdXxa3YbITVe3KvwuiFyxJo7LBO67pMjkxmpDEchD21HOdbxyn2hQ4ztMAyCq1XkbdyL/O4W3FAM9ega+dAUixQeB3HmYxGisOnONA+H+q/3f32uTltq2IUI=
Received: from BL0PR02CA0038.namprd02.prod.outlook.com (2603:10b6:207:3d::15)
 by IA0PR12MB8895.namprd12.prod.outlook.com (2603:10b6:208:491::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Fri, 29 Sep
 2023 12:55:34 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::19) by BL0PR02CA0038.outlook.office365.com
 (2603:10b6:207:3d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26 via Frontend
 Transport; Fri, 29 Sep 2023 12:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 29 Sep 2023 12:55:34 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 29 Sep
 2023 07:55:29 -0500
Message-ID: <6c671700-bae4-444a-a70a-0428a9c80fb6@amd.com>
Date: Fri, 29 Sep 2023 14:55:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] mtd: spi-nor: Add spi flash lock config option
Content-Language: en-US
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <git@xilinx.com>
References: <20230928034940.2220-1-venkatesh.abbarapu@amd.com>
 <20230928034940.2220-2-venkatesh.abbarapu@amd.com>
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230928034940.2220-2-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|IA0PR12MB8895:EE_
X-MS-Office365-Filtering-Correlation-Id: a77ddcd4-c804-4455-febe-08dbc0eb5eaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sr+YMWNlUzGJlirh9rukTBDSniyI3F7sFPFLwx8V787K2wsERiBAhQ0ld9TyxpF9Pfhw0n5Epo5YIBggq/X8bl+LU+p9gD0Pb8CGfWjC2c6gnPjzp4TNIpTKQdNZoGHABkLVmTF9RliHlZbEMYNMFWiZz08KB0Kf53YmtJu0KunTBYw3Sz2mxJql92+8lcP92AH0tcIv8XRoZFWTvU526SklWP9byT8/PiEqkqUzbn+58oN7E9R+HRz9UGrcLn/tKLDtQeJ0TijjEJOBKCmCDG7/DfrE6NKe1CEHbH7oqE5WZ2nMc+lOpwfxRtnK84Ll4Ee5TqvUa7PKakPnniAH2LK96TL5w3+y2Eg47BTzFY6LEVMCK7d+jKu+I/79WOpKN0RGVCm4BJuvMvP+6amI26P/drC6+YfapqS1FsDdJW+JwV5v1AEb5io2Bzyyd95mDOZGQZgm+QlGNsJY6lo0gYp/FT5I4MLVB1aa9aQDucJiGGaIa2lqifOt0yImlIoF3YIaGJ9CHPwm6ghtUay2fk40AZYris3Zg6+WhogBiaeArX0MiqrRrJ/Uo6UT8lOAF/u0RtB3c5TQ3gLOs2I3MmgC7urJSGLkO4NT3+zzO+oSqJcU/9+2Ya763Oiwnge2hKwA0G6dQd9S1MfL1e07oYe6SXYUdejfw3/wM2nm1SbnljjREpVLeFAsXdUNptOOavf25j4ETiveO675B3nzr2xbG2NO2DcIP5Nwg7WJEU7nVSKDtItYS98ZwwWV7Cetp9KPwPq7ea0HxUA7ztwJRRL157DNAQzo8U0QwNRLdLY6oYeBWZEr3fMQzyUGVdJE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(356005)(40480700001)(82740400003)(53546011)(81166007)(16526019)(26005)(107886003)(40460700003)(2616005)(426003)(336012)(5660300002)(44832011)(4326008)(8936002)(8676002)(86362001)(2906002)(31696002)(316002)(36756003)(70586007)(41300700001)(16576012)(110136005)(54906003)(70206006)(6666004)(478600001)(47076005)(36860700001)(31686004)(83380400001)(43740500002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 12:55:34.0403 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77ddcd4-c804-4455-febe-08dbc0eb5eaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8895
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



On 9/28/23 05:49, Venkatesh Yadav Abbarapu wrote:
> Provide an explicit configuration option to disable default "lock"
> of any flash chip which supports locking.

Please also write reason for it. Based on 2/3 and 3/3 I expect you want to save 
some memory.
Another reason could be not expose that functionality to be exposed to users.
Should we also guard sf protect command itself? It could give us additional space.

> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   drivers/mtd/spi/Kconfig        | 7 +++++++
>   drivers/mtd/spi/spi-nor-core.c | 8 +++++++-
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mtd/spi/Kconfig b/drivers/mtd/spi/Kconfig
> index a9617c6c58..476d848321 100644
> --- a/drivers/mtd/spi/Kconfig
> +++ b/drivers/mtd/spi/Kconfig
> @@ -134,6 +134,13 @@ config SPI_FLASH_BAR
>   	  Bank/Extended address registers are used to access the flash
>   	  which has size > 16MiB in 3-byte addressing.
>   
> +config SPI_FLASH_LOCK
> +	bool "Enable the Locking feature"
> +	default y
> +	help
> +	 Enable the SPI flash lock support. By default this is set to y.
> +	 If you intend not to use the lock support you should say n here.
> +
>   config SPI_FLASH_UNLOCK_ALL
>   	bool "Unlock the entire SPI flash on u-boot startup"
>   	default y
> diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
> index 6093277f17..9c51f2b1b0 100644
> --- a/drivers/mtd/spi/spi-nor-core.c
> +++ b/drivers/mtd/spi/spi-nor-core.c
> @@ -1099,6 +1099,7 @@ static int spansion_erase_non_uniform(struct spi_nor *nor, u32 addr,
>   }
>   #endif
>   
> +#if defined(CONFIG_SPI_FLASH_LOCK)
>   #if defined(CONFIG_SPI_FLASH_STMICRO) || defined(CONFIG_SPI_FLASH_SST)
>   /* Write status register and ensure bits in mask match written values */
>   static int write_sr_and_check(struct spi_nor *nor, u8 status_new, u8 mask)
> @@ -1386,6 +1387,7 @@ static int stm_is_unlocked(struct spi_nor *nor, loff_t ofs, uint64_t len)
>   	return stm_is_unlocked_sr(nor, ofs, len, status);
>   }
>   #endif /* CONFIG_SPI_FLASH_STMICRO */
> +#endif
>   
>   static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
>   {
> @@ -1461,6 +1463,7 @@ read_err:
>   	return ret;
>   }
>   
> +#if defined(CONFIG_SPI_FLASH_LOCK)
>   #ifdef CONFIG_SPI_FLASH_SST
>   /*
>    * sst26 flash series has its own block protection implementation:
> @@ -1729,6 +1732,8 @@ sst_write_err:
>   	return ret;
>   }
>   #endif
> +#endif
> +
>   /*
>    * Write an address range to the nor chip.  Data must be written in
>    * FLASH_PAGESIZE chunks.  The address range may be any size provided
> @@ -4103,6 +4108,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   	mtd->_read = spi_nor_read;
>   	mtd->_write = spi_nor_write;
>   
> +#if defined(CONFIG_SPI_FLASH_LOCK)
>   #if defined(CONFIG_SPI_FLASH_STMICRO) || defined(CONFIG_SPI_FLASH_SST)
>   	/* NOR protection support for STmicro/Micron chips and similar */
>   	if (JEDEC_MFR(info) == SNOR_MFR_ST ||
> @@ -4126,7 +4132,7 @@ int spi_nor_scan(struct spi_nor *nor)
>   		nor->flash_is_unlocked = sst26_is_unlocked;
>   	}
>   #endif
> -
> +#endif
>   	if (info->flags & USE_FSR)
>   		nor->flags |= SNOR_F_USE_FSR;
>   	if (info->flags & SPI_NOR_HAS_TB)

M
