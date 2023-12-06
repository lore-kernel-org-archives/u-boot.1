Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB23C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 07:26:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 918D4807A7;
	Wed,  6 Dec 2023 08:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n37bBfVG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BC4F875F8; Wed,  6 Dec 2023 08:26:32 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 426A880785
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 08:26:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPxTXeZCKPrLkOzMEltEeuTfIiqtf1nOpYaRFO2zjo2ZiSqJUnCwTlp8w+vUmX4UmVj8Idhho8acUI6iaC0Ip7usoGdQcSUokxhUq450Qazx2AB2WMR3zZ34+6ojsf/XcnwOhINUdykHwYCTKK+7RaOvdwiH6zAkd8Qs8rtJc/5UVOEwcGerhvbu242FCvCXUHCEMqbtDwF/+1jLRvfxxp/yseuRyFNLuzdXwpBQPvLlCyDAlGQfLOnz8QtEH16NaURpCSfuh+ND/tXtq6hcvqIPSFebeHN6PO2IOQ+zUdnnyAd/nq3G9zJyi5YnnHmIokK83k4fawYsk7JRXE6Wiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSE+hNvrD40UNLs+G0QsPkVwSZFRjgySZ3MmuDANR4w=;
 b=jx2SF7us+YG2eiQXmXrMNnLFdRu1sBxsGpwoAXwyxaIUPY+4kHpz0mHeCS3BIA+2dibxQFsNFts+v7d+zwWiq+79DO7DSCiO7om9HBAhoDcgiYMfsf3yFQ/4BdqyrnF/U9YrdAl9pJkg+Aj9FLNi1luJTcJSq2o+9i1ywf0uF+aX3gVuP1zx+pJl9sfuTBfLnvCmiWLOjP/rOzGcQh7e9xtDDS/DaPuojkr1DfZSxJ1QJUxEHoF6pcgtZlW5qdvkytLFqxOL9vlKgv2lctDje1I1s9Bd2T/d13ZAO9kKm6tdvhTgBgZ1IZm4v33r3pkXL40m/bJq6HA1x6jpIpAcQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSE+hNvrD40UNLs+G0QsPkVwSZFRjgySZ3MmuDANR4w=;
 b=n37bBfVGOaUJ+zuJ/OEPWNJElDV8rXHhVhyV7M/qUbSGHlFe39c2Gv5FrvzGQa2+NMWVTxrvedtUnVjjPWeUHTC2JLZD2xvTdNzS7VK+XGdifaslp7bcUTbvHS2RGYuAo99jUOC8JHeR/wOhSBC0UB53To40h2jQXj9wyZefNrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4758.namprd12.prod.outlook.com (2603:10b6:a03:a5::28)
 by PH7PR12MB6393.namprd12.prod.outlook.com (2603:10b6:510:1ff::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 07:26:25 +0000
Received: from BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349]) by BYAPR12MB4758.namprd12.prod.outlook.com
 ([fe80::39a2:42da:ea20:3349%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 07:26:25 +0000
Message-ID: <2bdc71c1-6092-47f5-9863-7cdc5740aecb@amd.com>
Date: Wed, 6 Dec 2023 08:26:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/30] Fix issues with QSPI and OSPI compare failures
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: joe.hershberger@ni.com, rfried.dev@gmail.com, jagan@amarulasolutions.com, 
 vigneshr@ti.com, git@xilinx.com
References: <20231206052917.3743991-1-tejas.arvind.bhumkar@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20231206052917.3743991-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0175.eurprd06.prod.outlook.com
 (2603:10a6:803:c8::32) To BYAPR12MB4758.namprd12.prod.outlook.com
 (2603:10b6:a03:a5::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4758:EE_|PH7PR12MB6393:EE_
X-MS-Office365-Filtering-Correlation-Id: cbba1ad0-d967-4e96-08e7-08dbf62ca791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GVEDk8eU7YSJ/XWig+ahcmLcN/ZlcSCnVAfiw+vgn4d8w0+M3CS3iQbzeyc9YZtFf+nC07upOBkOXKLm89a1UapwrMNRZcNZfDfcb00R5HiXN8fqnZVHb/zfC8pY48e/w5d5KTSztVXBgTQ4Lm0KkZbAXEISNWXmULtDZ1PWEiYMYmC7QjEpwmHRxybM+1iVnF/b3UNgCavtVsAjrS2xrNQoPf1UyuaSwuL3/csk1+dF7welWr8zokp38A/Pd1nSwZhAvb6sXz+ZFSJW8DobB6/R9g1hIpMDlGVzFOCxrdPZgGGpBkQhJPiWE5n7HerNjZ9P9Nn9rfAHcHRTpO5Owq0c5c+BQchliYwTU8jxOYnatordNsxso2Kkfk44LwXlttLkwcc43eR/qxeSYdCGk6hZvrWBqKQ5sexCFQyTa+QKSjqMC9hK0ZihLVrPPU4zfYFExrsZYCwmn8zgefZJzbz7nuH5itNoRqYr0Jwh+MWM1fF/IaIO//LHUf/+wzQJTwwVroQMzbXYVZaQ7gnEXUemKnENagszqnVr/X3wEDiRCevsEHg9U2XOq/qt2LzuU7yzfIa73kRs2dK6JvLO/YjTWVIECfB7dE/FGylFPdPLAPGOC4DjXy4I46l8KF9rpvnokMX8hB+D1k4U0riCQNUHTFwAw9aSsjCREpFnTvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4758.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(53546011)(84970400001)(4326008)(6506007)(44832011)(6512007)(478600001)(26005)(83380400001)(6666004)(2616005)(31686004)(966005)(6486002)(66476007)(316002)(66556008)(66946007)(86362001)(5660300002)(31696002)(41300700001)(36756003)(8676002)(8936002)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVZby9HdXlNbzFwUDg3ak5rcjhnU3hBanZNWUlBZStHZUgwYnFPbjJBcUpT?=
 =?utf-8?B?b3dxdWp2Ykk0QmZvaS9wRWVaRVJUbDFabUhBU0pnL3dJejUxcG9DN1lxZmlZ?=
 =?utf-8?B?VlRoMVExWGYzNmlMNFk4Vkd0NkJEaFZJeFhTcll1em05d2FlUlBvM2ZuUGJy?=
 =?utf-8?B?R3JIcmsxVUNKZkVKVzZaR3RUS2dVaC9kN3llelNBSldxMUFHYkJYQyt0NU5y?=
 =?utf-8?B?OEdxQUoyTXBVZkZXamUrcHdRdngyZXdhSy8zZXNQSXYxejhURDFJazJQK0xx?=
 =?utf-8?B?TEFSYjhSbnVNM2d6a0ZIcGE0K1l6V3NqRUtUMXRBVkpHeVlKVTdTbFdDbXVs?=
 =?utf-8?B?UjgzelBxR1BVcUNHUHFLRThjTXh3NDAwRG84d3Axemw0OTdCZ1A2b3hVZWRT?=
 =?utf-8?B?bEx0WCszdzR2bW5aUmtZNHhGTzVhYTZ5amhGT2k1cUYvSzUrOTZ1OXdlWFVW?=
 =?utf-8?B?Q3RGb3o5aGhSUkZKU2lwa0cxMFhxSEUyNTBrVG5HTzNLZ0xVT3dTU0JCZ2k2?=
 =?utf-8?B?ZUw4Z2Z4U1UwdjlqaWtWUTMwK21OTWJOUUZKaVlLNFdUUGVjbm5LMXhIS0Fp?=
 =?utf-8?B?Mm5pRDhkQWhjVnFyMTZlTk9oNVVLeUllUmtyMWhJd0pWNFMrNThLbjRqMDI2?=
 =?utf-8?B?cnJHV3dSUi85RkhWZHJoVXlKYS84TGd1SHRGSmpENk9NMWF0Z2RsSzl2aHNZ?=
 =?utf-8?B?NE1Rc0RUMWxtd1BtcHMrKzNCYTAyU1ZXVms0WXc4eDhxSlVDc3lmT25WeUVn?=
 =?utf-8?B?ZVJacWhwVVlDSDNkcEUzcWQzVHFrTVJnY1l5QlJtaFo5NE9KS3hOZ09SVEhl?=
 =?utf-8?B?UUJkWWU5dG9IMVFvOGRPRFJnRmxGMksrbjdkNWdGZGtJNzFCc3ViQXhJYzhP?=
 =?utf-8?B?UDZiYkxBK1kzRTZkUGhhRE15RHZZN2w2bGt2TVRTZHE5MTNKSXg3ajlMZWdL?=
 =?utf-8?B?Z1hCa1FUdDJWU3lRd3FURlRvYWl1NjVISXVoTTFFZ3EvQUdXRlBlaW5DNUwv?=
 =?utf-8?B?TkNMRjIrVEtKdmU2NS9mZm9UQ3U3WURnZktUM0tKdUxDNmJXY3NXdno4Yngx?=
 =?utf-8?B?cDRhTzA4a3U2UExNYXVPa0t4MzltVlMxeHdLWmw0Tjl6VTNqczVKcUNKMVVX?=
 =?utf-8?B?VjhJSUdNTWplUEpJeEh4eEZNeFdqaEJybkJOZnBYd1BucWxlemJKV1JCM1lM?=
 =?utf-8?B?Tkw1WUVqVyswRFNWLy9va3ZwTUQxaTYrQ1JWbWtJeVhCNFFPYnN4UXhGRzlI?=
 =?utf-8?B?aStJWGFsSGlzTlRLQmY3a2tOWG43bnhNMHJZRkpLRU5MMjA2TUZZTzB1QXpG?=
 =?utf-8?B?Z0VNUjZBeW5uYjl0amUyWTJnNlphNVAxVnk4akY3UkdpRmpQdGlEc2xYQ1Fh?=
 =?utf-8?B?cC9VK0hOMXlDMXExb1JwaEdUcVhCTHNwL1A3MittTWxsUGpaMzhpcXdMTXk0?=
 =?utf-8?B?N1R4b1FTdkQvUnpwSERTVVJURElFcVRMM2J5aCs3c3R5QXhCZ1lNdmN3eWp3?=
 =?utf-8?B?ZHV4V1dQNUVsWEFkem1kYmZTMUxEYlQ5T0hLL1NseFpNVmpYT1V6dWwwejd5?=
 =?utf-8?B?dW9yRmd2WExsMnpRdGtybm9nMGEzN1dOa3JnbVdJSnEwMkpnM0hHWHdjcEQ2?=
 =?utf-8?B?UGswVVR6U1NLakZ2SGJ5eS9obWtueHptZThlaUVCQncyMjVIU0Z6TW5KMmg5?=
 =?utf-8?B?Y0ZzTmhBaXdUWmtpcTdjVnhNVWdocWd4VkVJRVJVOERpZGdiaHhjU3pPTEYw?=
 =?utf-8?B?dktNMlpiME0rSGFoTUJhVTI5V1VXemVvRys1RDZ4REk3TGljTjd1SXIrLzJM?=
 =?utf-8?B?OWtpYitUNEdyOWsvdnVPVWhjYzJvOUR5OVY5a1FEZis4aHgvd3ZqUThsLzAx?=
 =?utf-8?B?SVhmTDFmQjlxWGxKc2lVNDUxZUlZNVhRZ2ZDLzFRT3VPK0xkMjZKK05hbWZa?=
 =?utf-8?B?YXpkWG9ReTVHZS85UlpZS0J2SkVVeU1YLy9TMzdZWjlUbDRqVDdHQXBLWGx1?=
 =?utf-8?B?N1kvTXJNT1kyU1pXNjl5a1NCSlY3Si9vZmlhTVlEWWFQUzFrcUptb2hwOFFa?=
 =?utf-8?B?RXg0NlF4WHVpYkdKUEdVbG82T3M2QnlPYWRXRnNNanZTcTV1K3duR0Y4VWgx?=
 =?utf-8?Q?YBW8UhMAtc3PECL4DKtEzpY09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbba1ad0-d967-4e96-08e7-08dbf62ca791
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 07:26:25.6300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3vVRfaGOVhcRD6SvIn6ubjQXLY6EUFXwhHm+uClCQYLwPTkjrx1v4+2rIh3+WVI9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6393
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



On 12/6/23 06:29, Tejas Bhumkar wrote:
> A set of patches has been developed to resolve concerns regarding
> data integrity failures in QSPI and OSPI for the Versal, Versal NET,
> Zynq, and ZynqMP platforms.
> 
> The series has undergone testing with flashes on the default setup,
> and comprehensive testing is currently underway to test the series
> with all available flash parts.
> 
> These patches are built upon the v5 series, which can be found at
> the following link:
> https://lore.kernel.org/all/20231201031839.239567-1-venkatesh.abbarapu@amd.com/
> 
> Algapally Santosh Sagar (1):
>    mtd: spi-nor-ids: Add support for W25Q02NW
> 
> Ashok Reddy Soma (10):
>    mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx flashes
>    mtd: spi-nor: Add support for cross die read in dual flash
>      configuration
>    mtd: spi-nor: Enable DTR octal flash program
>    mtd: spi-nor: Send write disable cmd after every write enable
>    mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if SFDP is enabled
>    spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
>    spi: cadence_qspi: Clean up registers in init
>    spi: cadence_qspi: Initialize read and write watermark registers
>    spi: cadence_qspi: Enable ECO bit for higher frequencies
>    spi: cadence_qspi: Write aligned byte length to ahbbase
> 
> T Karthik Reddy (9):
>    mtd: spi-nor: Add config to enable flash DTR
>    mtd: spi-nor-core: Set dummy buswidth equal to data buswidth
>    spi: mtd: Use split reads if multi-die flag is set
>    mtd: spi-nor: program quad enable bit for winbond flashes
>    spi: cadence_qspi: Setup ddr mode in cadence qspi driver
>    spi: cadence-qspi: Switch SDR/DTR using SPI_FLASH_DTR_ENABLE config
>    spi: cadence_ospi_versal: ospi ddr changes in cadence ospi versal
>      driver
>    spi: cadence_qspi: Add spi mem dtr support ops
>    mtd: spi-nor: Add block protection support for micron flashes
> 
> Tejas Bhumkar (5):
>    arm64: versal: Enable defconfig for Micron octal flashes
>    mtd: spi-nor: Update erase operation function
>    spi: cadence_qspi: Fix versal ospi indirect write timed out issue
>    arm64: versal: Enable soft reset support for xspi flashes
>    arm64: versal: Enable octal DTR mode
> 
> Venkatesh Yadav Abbarapu (5):
>    mtd: spi-nor: Update block protection flags for flash parts
>    mtd: spi-nor: Add support for locking on Macronix nor flashes
>    mtd: spi-nor: Add support for locking on ISSI nor flashes
>    mtd: spi-nor: Add support for locking on GIGADEVICE nor flashes
>    mtd: spi-nor: Add support for locking on Spansion nor flashes
> 
>   configs/xilinx_versal_virt_defconfig |    4 +
>   drivers/mtd/spi/Kconfig              |    7 +
>   drivers/mtd/spi/sf_internal.h        |    8 +
>   drivers/mtd/spi/spi-nor-core.c       | 2028 +++++++++++++++++++++++---
>   drivers/mtd/spi/spi-nor-ids.c        |   40 +-
>   drivers/spi/cadence_ospi_versal.c    |   77 +-
>   drivers/spi/cadence_qspi.c           |  403 ++++-
>   drivers/spi/cadence_qspi.h           |   71 +
>   drivers/spi/cadence_qspi_apb.c       |  107 +-
>   include/linux/mtd/spi-nor.h          |   22 +
>   include/spi.h                        |    4 +-
>   11 files changed, 2545 insertions(+), 226 deletions(-)
> 

Series it not send as one thread which confuse b4 and not able to get it from 
lore. Can you please resend it with RESEND tag but with --thread enabled?

Thanks,
Michal


  b4 am -l 20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com
Grabbing thread from 
lore.kernel.org/all/20231206053353.3745918-1-tejas.arvind.bhumkar%40amd.com/t.mbox.gz
Analyzing 10 messages in the thread
Checking attestation on all messages, may take a moment...
---
   ERROR: missing [1/30]!
   ERROR: missing [2/30]!
   ERROR: missing [3/30]!
   ERROR: missing [4/30]!
   ERROR: missing [5/30]!
   ERROR: missing [6/30]!
   ERROR: missing [7/30]!
   ERROR: missing [8/30]!
   ERROR: missing [9/30]!
   ✓ [PATCH 10/30] mtd: spi-nor: program quad enable bit for winbond flashes
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 11/30] mtd: spi-nor: Send write disable cmd after every write enable
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-2-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 12/30] mtd: spi-nor: Update erase operation function
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-3-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 13/30] mtd: spi-nor: Check SNOR_F_IO_MODE_EN_VOLATILE only if SFDP 
is enabled
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-4-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 14/30] spi: cadence_qspi: Setup ddr mode in cadence qspi driver
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-5-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 15/30] spi: cadence-qspi: Switch SDR/DTR using SPI_FLASH_DTR_ENABLE 
config
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-6-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 16/30] spi: cadence_ospi_versal: ospi ddr changes in cadence ospi 
versal driver
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-7-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 17/30] spi: cadence_qspi: Fix versal ospi indirect write timed out issue
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-8-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 18/30] spi: cadence_qspi: Set tshsl_ns to at least one sclk_ns
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-9-tejas.arvind.bhumkar@amd.com
   ✓ [PATCH 19/30] spi: cadence_qspi: Clean up registers in init
     ✓ Signed: DKIM/amd.com
     + Link: 
https://lore.kernel.org/r/20231206053353.3745918-10-tejas.arvind.bhumkar@amd.com
   ERROR: missing [20/30]!
   ERROR: missing [21/30]!
   ERROR: missing [22/30]!
   ERROR: missing [23/30]!
   ERROR: missing [24/30]!
   ERROR: missing [25/30]!
   ERROR: missing [26/30]!
   ERROR: missing [27/30]!
   ERROR: missing [28/30]!
   ERROR: missing [29/30]!
   ERROR: missing [30/30]!
---

