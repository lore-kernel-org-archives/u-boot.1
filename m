Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BEEC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:36:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3578B838D7;
	Wed,  8 Jul 2026 06:36:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="KoPV+gvg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AD6849F3; Wed,  8 Jul 2026 06:36:57 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2778D80087
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:36:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B0u8dr8VezmMgn+K7PwkmQBAlMHTvzB/M/ofFfVJm15BgKh8U/jlVd130KT1e89qGJfaxsn3UKsRcWj6ibl//SoWkq5CxlDW0HIZLMGjbaxWN1AOdd+IHnVZynlmu8rp1XFiFV8PmR5nlBhaDccArYR1peXmnNtkygSzcNjCJbCxAQ6mcpIuKd331blJUC7pTF2ZLa4FjSa2dL8iqQilhxkPRS2YOq4KV0qI6auMDjXNY3or9sbmH80TY6NPlhUfUIMeCejcNvXjqgM3AFuFbBEk/CxsAIQvxPrd8a6D+zIa0cAKjuP1Tlqp27b0qqCMgWiljYbEBD3qtDLv4SEz3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PzwaNznjIJFZZRqHRZC6yDmiV0b5ps3tl8CN/XS+ZlI=;
 b=RiAbMIwOAc1hDyT8nxbQVlYAQGBwedwX0gH7fxlviDFJHTRJ4QDLLKdVCpwQ+/IJPPhmp3w8H3n6dsEp4WjCxry+ucMJkmNtRBVehaBpTmbqN48HainOmJlfmA7NpJx3COUgflIIHRM9PsBDSzWj603vOl40esqPBQbuJi+O9T4HFCwhrWTjzzfWTECT03L+r7uVEoVZgzize49ClB1nPW675zfsakc44vQ9ps72rbWV7rYMewFKds/6lVGRpOfasHSUiTo+20QDW3uW3cPVy6uVsgZwmbGONcBEHsbBBDJ9HLfWn0t/iZtbQOToC0dnDLut90rVfBPlo91ubTh5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PzwaNznjIJFZZRqHRZC6yDmiV0b5ps3tl8CN/XS+ZlI=;
 b=KoPV+gvgai6RtpPBI3qXWrdPdIugFk79ZobPF8/XOa2eQfWboiIkoTySzx7DD5W5tonvDHlXRsKuQdMu8uw8aiwUXc7z4QNkz12HfKd1QOIj6YZ1oSDnEQjpnxh92rj5p45vGIt53lMyrb2iy3v2cU5PNwIIs2WOB6ceQWyBYPriI0aL8FCpeTJ0oNLt+0DNzGF1+zLPlVtpscITJvBZI5rtsdr5z+4ciZ5ABG3askEVtfQ549YwqJh58e0iJdx6R/X3v99jhzFKBMOGvGx+AR9lK/ZdBBDoRgq1cUD3qAdfeXffSiWZ2i/WFUI/FXRLqzt6wv+oSPcZm5wXpsjkEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by LV4PR03MB8355.namprd03.prod.outlook.com (2603:10b6:408:2da::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 8 Jul
 2026 04:36:52 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:36:52 +0000
Message-ID: <93341edc-a8d7-435f-b847-044fb980e623@altera.com>
Date: Wed, 8 Jul 2026 12:36:41 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] configs: socfpga: n5x: enable CMD_MTD
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-4-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-4-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|LV4PR03MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b913b57-bd94-41f5-e7e6-08dedcaa8838
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|4143699003|6133799003|11063799006|56012099006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: m3PcJxG4It/OuFTbge7jeFNKF/C4l7t0QM1Ah2L0XhId5gPQdb2Vt8/LHYBtbNyc4cBULlWzH3Nh8sIBlPcFO+QIH5rXb1+ttHWRl4UUNko3K38RsUNHb+Buv8lWT0+aRJGQwa+I/X4vcIITzj7CpEWVJpHopL93zjJwKECt1FSnAow+zu0IaZaE3TIsgjlBc04uwVZDHRlj7kga/N+mBDjBYQ02qiWTV8qbeFsHFWB1ULIOz0CPjhryt/AwRUgmx7ph+u5GfwBKtsNMQRVuVByYxoDMjKslpBkD4X6FcXmStslq4Hhv7JrqzNIX0/SdD4Txy66be8RBuxzK6Iqhh4hjg5SYdAyqyfOsXzfHI+pJKPw+UOv+BWmWsYX+kd0voo8xDwZIilybrPzG6gr3fsanEcsSxABunLxt5f0chAs7dvmRwyjGRLwJJmtDwGK7Hph1pyRN10cZfoMSLO5lyG5mo0L7krTXEWE7cJJg8r60qLG24LYmv6yqe7KEHlmZ9kDG5C/ua88EZe++A3dNaPBKOzGMFFXmCibH1J7jlmM9m0vaOy9RlNY8zgciqoQhyDeGeqP9rvCk+QXhkDeJ19O4T032tbgCIJaj+By9sv+5DExccG57mwBgjKnNmV/jiWPjzZOqBE2M/AHN3CPoFr36AgaiUH3BSi7MJQw6EJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(4143699003)(6133799003)(11063799006)(56012099006)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXhsOUVqSHVKcTRRc09JNDlmSVoweDlTRnV4aVJaNGh5RGxrZ21yeENFNFUy?=
 =?utf-8?B?dmdCaUZjTkdUd1hCeFBRczJmUGhnbGdmdkl4ajNnWlRNdmZ0SmRhMzNPSE5T?=
 =?utf-8?B?RFVpMFRoTHY5UElKZk1jbjdpeTJNVXBJdWRCemhSalJJQ20wWkEzWlpCR0xa?=
 =?utf-8?B?cnhXY3JMNVpBaWhWTEJmWU5Mekt0Uy9xOHVwc3EySzVnQVJneGtCVCtWZERW?=
 =?utf-8?B?cUJmZ0VXQU01SmJBSFlxb25LYmpnS1gvOFErdE5TUC9Pai9oNFpRNE1sYnVn?=
 =?utf-8?B?ZGs4eVZPY3hUUTdLSnN0NFBWaXNMQjh0Ym5sT2Yya093QUtwSVlHam8wYU5Y?=
 =?utf-8?B?R0lKQjdVVCtZcUFicGVDZU92SUpwNnNiV0xNcXZSdnc3bGlScUlzclpxZ1JK?=
 =?utf-8?B?a2dIWW5zNk94WVY5d3RGc3BBUTVWR0Z4bHJXSGpVQzBJMldLUnZBMXJITWFE?=
 =?utf-8?B?M25GUXVXQTczcXFUTFpQMjRleHdsY25OWEFNKzFxNjBoYjJZQTlXL1BNVzIz?=
 =?utf-8?B?dVBIN2dJTTErbG5YUmlybXpyV2t1ODFiZi9LeFk5TFhpWnErTGZMZGhZczhD?=
 =?utf-8?B?ZXJMVlVaS29FQTlTZm0xSjFXRlBGaE5JN0drb2lRR0tvNUZQNktBS1M5bWd6?=
 =?utf-8?B?U2xtWDJQMURmc3dhaDN3aXFpeDZVSVh3WUxtb3krMHZnNGU3dTZ6b1FEUzA5?=
 =?utf-8?B?eVoyand1U3Q3YitoTHhWRWVGVGpuS1NWSDJVeldZTjI0c1F1K2dmS1hJZHJy?=
 =?utf-8?B?NWgyVGVqWE9FUHAwempDalRmZE5nTW54YnFJbmtGdktjNERiZjNpOHZNcmZr?=
 =?utf-8?B?blBXOTB3T0RkZEdld2Z2VDdqdWV4eG9Xa2NSSjczVW56UDRvZTh0MndrTHZa?=
 =?utf-8?B?T2kyQllZWFZIUG5oWm9WaHZHMEk0QTRremVuZmxIWkNMblFNMm5ZZUNWaTg4?=
 =?utf-8?B?ajg1b3QrNStuSzJjaWxoRkY3TkVUMTl4WXNsMDlWOGROYzBWc3VTbVFldDgy?=
 =?utf-8?B?a3lUSnhMK1pBTmJJWVEyVFV5c2VlTmZJN016Ti90UWNla2wvUkIvV3h0alh5?=
 =?utf-8?B?YzhOeDFMbEFzTHZjUTY4SjZsVDc1UGZYM0RCTWVsclc1cUl1eCt3VHA2T0JS?=
 =?utf-8?B?VFdkbUxHSUV6OE8zWVZ6NTIvYktKTlJwQlRBdVNrbFVPZXg3R2NhWjFKNjg4?=
 =?utf-8?B?VkF1MmI5S0FJbHlyTzJCRjlVWkdRR2ppbXVsUGxtNjg3emN6NFJRUGNtM2JM?=
 =?utf-8?B?eUd1eVBjZTUvTGV0RmpQVDRXOEp4Zk8yS1l4TjhncG44Ti9jSzJtS0R4bFlY?=
 =?utf-8?B?ekw0ZVpkTFJvd3NZODQ5aGc4S1lockVZZ2oyZW5oSFBILzQzVmtVTWhsMzJF?=
 =?utf-8?B?Qnd0UWZ3OEtrblRMaUZCSWxYYTJnbHhoYlJjVEtnNXhIRGZ5eXhINWlBN3Bi?=
 =?utf-8?B?OGIwTTM0UXUxZUZGdVJKZDc4QXlKNG1mRThrUE1aSjg4eTBqYzVYLzExb0Jj?=
 =?utf-8?B?c2RhVVllZUZ0djZNZnBtWGV1T2dZaEhhdmM3YXJlaUNBczVUMkN4WWdKeHRQ?=
 =?utf-8?B?NVE2TzFKaTdEMGpCQXpLcVNUcERNZTk5N3QyMllPTldIN0FkakxwZVJlYVJV?=
 =?utf-8?B?bkVKbE9EVlRQbzhOdDVjV3RtTUR0WkM2NGZ6d0JIMHZ0cU9kWXlYN2NYb2wr?=
 =?utf-8?B?WW44Z0xwZW8zZGhTZVRNYmhjbmo1Zk9ENlRUNXFUdDM0em9YVndCTE5YaVI4?=
 =?utf-8?B?V2MwdUNlZ0pvdldULytYQnNHVm40TWRJb2JEQTcxcHRTQ3dqSHlscFBEdkpK?=
 =?utf-8?B?SlVacDkzdVF4Y3VYTitBOVhVeU9iTE5sNXJ6cUw5R3dzTmM5em1NblZrSk11?=
 =?utf-8?B?ckdOb1IybDJScWp1cWt6dTlZV0FqbVBKTVZYN3lvUlBCcjFnR0MrOFFrcktF?=
 =?utf-8?B?dmtnU1JGWk1uVmVQaGVYSkJPWnNwRGE1YUdWRS8zMWdLdUZBTEhEQW9MY0Vz?=
 =?utf-8?B?UGx2cDh2aWVKeVpPZWtVZDVuekRTdUNvWlpvblNLR3dEUEVTbzNZY3FDZE9v?=
 =?utf-8?B?NkN0R3cxcC9pY0ZhOW5GUkRvQWFCVUZKWHEyZnJzMXN0VEZkOFd4a0dRTm12?=
 =?utf-8?B?V1FxME0rRmM2RVl1Z0tMZXcxYzNVWTMycGtNOE1WWlRNSDQrY3ZEL0YvbXpG?=
 =?utf-8?B?S2NQbmJ3SDRaRmhELzVFbWVxdWxleHRDM3JBaGRESmQ5RjB4aXRGNHVkVjNS?=
 =?utf-8?B?aUg5MFYvY1BQZG8xYVpiRkt6YWozd25kamxTeGt5QXV0K1BSWkpoajViSnBp?=
 =?utf-8?B?d2FjcFlvZ3RmUm9sYmY0aDk4UklHY2hRczNIYjJLVDkrODgrS2lyRmpYWUw1?=
 =?utf-8?Q?9xIjUureOMuN3p8I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b913b57-bd94-41f5-e7e6-08dedcaa8838
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:36:52.5157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fAlbjvMggM2b5v9Ph5Q15AmpD4qERZQY2oxiogNEJkfZgoLBoYe+hBTy/2zbYjlIgnY1B5Tf9ZdyGIIzThdM4RBAhrhy/PEq3tgAPH+un5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8355
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Enable MTD command support for the N5X platform.
> - Enable CONFIG_CMD_MTD to allow MTD operations from the U-Boot shell
>
> This option aligns N5X configuration with other SoCFPGA platforms
> that use the same MTD framework.
>
> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>
> Changes in v3:
> - Drop CONFIG_SPL_ALTERA_SDRAM: auto-selected by Kconfig for N5X, no
>    explicit defconfig entry needed
> - Fix CONFIG_CMD_MTD position: correctly placed between CONFIG_CMD_MMC
>    and CONFIG_CMD_SPI per canonical savedefconfig ordering (was
>    misplaced after CONFIG_CMD_WDT in v2)
> - Rename commit from "enable CMD_MTD and SPL SDRAM support" to
>    "enable CMD_MTD" to reflect actual change
>
>   configs/socfpga_n5x_defconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index 97c90656e7d..9159fa0c859 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -52,6 +52,7 @@ CONFIG_CMD_MEMTEST=y
>   CONFIG_CMD_GPIO=y
>   CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
> +CONFIG_CMD_MTD=y
>   CONFIG_CMD_SPI=y
>   CONFIG_CMD_USB=y
>   CONFIG_CMD_WDT=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong


