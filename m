Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAEBFCD11C2
	for <u-boot@archiver.kernel.org>; Wed, 10 Apr 2024 06:12:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8AD087C40;
	Wed, 10 Apr 2024 08:12:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LRIXFcxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1347387C40; Wed, 10 Apr 2024 08:12:37 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20711.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3DE888166
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 08:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlKNGc/+hsLTNLJbAIfP3CCHC2SFKSH5s+sgCsoEIDjGb0BWmzjSlGcLyTOSmFQPUqW7WO24TlvC6HufsnjMljaGBMTguyKtGRpQQ7sXA7hXyXuLivG94uIjTEpd9wN+B5aaAalMYYlH+W/JcnrAp7SniZLy/s/jX8BSZum6Dw4/oZ9oIzmJKX8JBmXAG/pJm0bCPE/5PIzfJyMQWOGWm1zASy/v1QteERy9JyXcfU3yRxsweMplpBGC/8NwJwjhrRlY7VqtKGd9YdPqXX0CXzIaImdNeyrxc5Slc7fWnihiH00nZjqByT1SbxkUdZQMZ2Bn8knme2JrAkYTzAkW4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGI+fU0DIllN6aDNS/JCOiAbupMUNgOh7R/szVj/Zv4=;
 b=CvIDwBq+xMviW0pByfvs90+7ooLEANaP+K50gRqxz2kAipTIF4/dTDei8IV3PpuoAWiHvlhKhOSoiEEsLNzfZB6dsl/DLdm/s/gKx6+AMMVtRFmuXHxEGYTHc3n+HgyBr9bdVYh0fdmmv3mU2FW63lE5elDMOYBrANpsZZADGcbSWnmxH51QELOY2Klw7g2R/B8SoqTlpB1h/4OYmpG+xYy69rdbRznOociQG7tyg/VPiJwIbqGlZoiOE7PEp2XoYv7DhaoCCR1ULKfdtsB95CrwkazqN37cLcRz3OIByMmv1x8ni5nC6olV0l0OPd0HYeajrVC+JtFJEZL9SElzjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGI+fU0DIllN6aDNS/JCOiAbupMUNgOh7R/szVj/Zv4=;
 b=LRIXFcxnZ32XvwS3ciSb50/fxictSNqVrT9l0aWCYRHLNaL8nuO7PwEiUKKH9gl32uwWPV5OF+oMyyP1CisbQpPbJiiESccYCcqeEzb18O55uuPI33uwH/bQKHOJcEFP0wJKEsQKSh9Pj3/t1WxstWSC/WtBoVHXlz2ZSi9WgTU=
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM6PR12MB4481.namprd12.prod.outlook.com (2603:10b6:5:2af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Wed, 10 Apr
 2024 06:12:31 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::6622:ec76:9367:3907%2]) with mapi id 15.20.7409.046; Wed, 10 Apr 2024
 06:12:31 +0000
Message-ID: <164ee02a-101a-438b-bd25-4ca8acbec6ce@amd.com>
Date: Wed, 10 Apr 2024 08:12:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: zynqmp_kria: Deactivate CONFIG_SPI_FLASH_BAR
To: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, u-boot@lists.denx.de
Cc: trini@konsulko.com, venkatesh.abbarapu@amd.com, git@amd.com
References: <20240409094826.4131643-1-tejas.arvind.bhumkar@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240409094826.4131643-1-tejas.arvind.bhumkar@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0155.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::48) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM6PR12MB4481:EE_
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dgzOO4dGlNpW7KQmRXqF0gKCj+PH4z92ORBrDmNfvtvbJ/VHwJkNXNnb6eLYhNqmZEtoN6NhclzKDpNNvcxcsfLoUbSmlqzoh95Twn3lF3RaFMuZFwOFzPtqz/h5aip35KibvmZS3OMutDNO+qo7y0xuptUoJm6y4HVVRh5TvelOMML4koSoIvHBCxl66EKQX5l/+hhza4COaTAJqgjTvyCku9mNwh4d6fNKVaZ1UbHipDbsIMkmhFbgN46+3Cds1OFp6RdA/rxInZzmB2cpa4SCfyjdavCdD1+dvrJGQLpjVgieQooy2hcjnbuAH2a68kAfeIoRZf6+wOoXAQGsx84CfAejsK6WlHBW9TVpLXlIzc3RBSCHVePNF59o9VrTv6QFGyJhA6PrxRFxM4slpIcf17yvGOzp30kjyObhJ74TzJwCtqV8WhLcjx89YcWZTI2pCuuSmlgs6OL2AKWCbXdfb/I7jzGfHN7zjd6F0HbNeEYx2wBseZSA7w1Nq9RaxjxdKmT+aT2dh105efIU/wDHrgp1ubU73tuN0Rwyh1SbzWD3sPjpcm/Xhv2POvzwLVpgtud52/nJNMIHQZcOdq9MoiWXA+JAQE7QGEDCkYvcpMfRGJVBAXQIxMIrHG7tCHs0M0vt8Z5bE8IufJ3V6vnE3SXvUDnpVzHbG7Pyfqg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFwMU5qRVdOTE9YS1ovc2ZwVlBLK1pVWUtMdWZQckVxbEkzdjZDQ1lDNGRB?=
 =?utf-8?B?UGdEYzdISWpYVjFZTTI3M3BpMWpWL29MSEdJaWhoNURiRjZ4YkdTbFc1c2ha?=
 =?utf-8?B?WFgrZmVNcXZrRHhMS25QZWN0VFY3VjFCdldJSmlLYzNYc1FOemUxZStMNFo0?=
 =?utf-8?B?Uzl0bzF2cTlCRlZCbEN3VXl6eTc1aVdUZDZkYVJ3ZnNaMVJiaGdXeW1ZQmt0?=
 =?utf-8?B?UlJBQnJBZjdtSEtFeXFtbUJZMk1DRjhrUUVGa21mWjB6Ym4wMWUySnFCdDFL?=
 =?utf-8?B?cFZ5cXQ2b2hublVJS1lvbUtZK0p1Uk5wdjB5Nnk1TGh5M0h6VUZjNjNIWVJT?=
 =?utf-8?B?TDVLL0U2dUhnYW1FNWl2cys1R09SMlNteUkzRzRzL3ZJbTNLbXM3cVA4anFh?=
 =?utf-8?B?ek5EUEIzUjJVT0k1Wkc3WXloQmt1QS9LUTNqMnQwWFdzTEV1UGRoVzJrTFdS?=
 =?utf-8?B?MWVLWjhSWTBtZXptbkNBenZOR1BQZDdqMzIzaksxZW5GdE5Zb0trS0gzeHpm?=
 =?utf-8?B?V2hnT3h6QmhTVzRybnpsNTVwTHlsV2kreG9yS0FRVkJDZitPZWg0ZEFFQysw?=
 =?utf-8?B?MnZia3MyY2UrVlRHdnNKZ1BPS3FTZmF0a0ZHSHRwSWZTUHhuNHZlVzkrY2t2?=
 =?utf-8?B?cTN4S1A1dkQ1MTlGelpieHE2UEZWdjNSMXFTUFY4c1RYQVFmaFY1ZHlpOERM?=
 =?utf-8?B?YkNCQW9HcmRmMUJYa0hmRG01VU5QVnVseTFVOHlrdnEyb0M1dzVXTGd2TFpR?=
 =?utf-8?B?VHZhMTlmSldRbDNtWVljd2hVSjh1dHNVcDZ4azBQeEJtbzZ4T2t0SmFkNkFJ?=
 =?utf-8?B?VWJ2N25qeWlGckNsMTdrYWJsbk85cENScHVGemZQeThkTVpxbk9xcVd1TTJR?=
 =?utf-8?B?SmdtYk9UcnVLTURRUUNJdXg0TWxyMHQ4ZXpWMklxaWI5OHBPeGhac3JDbzcw?=
 =?utf-8?B?UkZTV0luSEhDWjV5b0hIeEZ2Y2Fnd09FYitTR3RxZllYbHBsR3ZoaWpSVURS?=
 =?utf-8?B?b2NoejVjZXBObUhzSGhvSmZGMlAycHlkVnp4R2dyN05MY1J5UjFjcE5aemp5?=
 =?utf-8?B?RHFUR1lTdUljK014bDlMWThxNEtJUkNjb3BmZFc5ZEQ1L1NiYmFqeE1mRkI2?=
 =?utf-8?B?NENxS0NyMTRTSTl3SXlHZ0ZrOUdlZUMvTDMzOXV2bGtJMU00K2Y1QlREcTZT?=
 =?utf-8?B?cldKTTlXSUF0azA5ZmttM3grQzZ3Q002NG0zYm5aL0lxMWZhQ3JDcjl4MXdB?=
 =?utf-8?B?VC9RS3VMNUNJbVBGNDh0ZnduWnZMS2laWDltRm9kZm8xM2QvQW5KWkt5VU13?=
 =?utf-8?B?bkdmV3BTa1VGWE1qWFVkQmoyR0pDQU9tQ1NWU096TC80QjhzMFZ0akFQOUIr?=
 =?utf-8?B?dTNVdnNpaU50bHlFSnNIdWtRS1AwanN5SmhYeG1NQytLSWZsYmVPUVdYWGhu?=
 =?utf-8?B?SXR2MlE2NURhMGpyTUFrMnZ0bnZ2VzhXRTdzU1AzVzBMWTlEdmR0T0VQcEZo?=
 =?utf-8?B?VER1bXFLNHlmUGQzOUZaZjNWdmh2UDBIbVpsYzFCenZzeTZzWUpobmZLa08y?=
 =?utf-8?B?WXp3NkNTU2lXaTNDV0dUdlYyMWJUQ1ZoNFNEWEYyMDRKbU4rUWVVSXRUNVFq?=
 =?utf-8?B?NytwR3VQQ0xNMHJuMHNtN1FnR1pOdmZEd1pBLzJVLys1VHJPYXBxVHRaN0VR?=
 =?utf-8?B?YkFDUThtdXBJemVYcFRWL2pIVkp2OEMrencvQlFZVGxzam1VRHdQT0lQRSt1?=
 =?utf-8?B?R0RhdHhzdldoTW9kU2pBdWtrSm9GbHJ2cUtYRDVmWmFlLzBjYmsxNThEd2c5?=
 =?utf-8?B?Ymp1QkYvbXR6YWhONkFPRUptTTV0b3pwOEZsaHZOdEVzcHRNQ0lBZ0luK0p6?=
 =?utf-8?B?V29iUW9sQ2grWWs2eCs5cldSV25WUFdXQlRlZEFXbVRtWld5Z1dFSHBtV0NW?=
 =?utf-8?B?Y0dGU2VQQlF2Z1NwZkFEUnhDVkltSjh3bFlYTnppRUNDcndJcGNJMktpNHFX?=
 =?utf-8?B?QjFtekVpVG9HZ2FiRnpqd2FuTmR3Wk8zMmNiUzdyZ0lZMEkrYTRzN29kcW5w?=
 =?utf-8?B?ZndPdm1SR01FWEpLMVJGd2xvVkhaY1NrVEsvNGNFeFkzcHBUdTM4OXhQZUFX?=
 =?utf-8?Q?yLHwx5bvQ/XP50ssMAokzRzui?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82361ad1-e8a7-4959-2d8b-08dc592534eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 06:12:31.7139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1BtF2x9SornUV48nfweOOCVOYqkw1I+ymEm2J9U6D894mFtGJgD3R34ebFFeVnCG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4481
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



On 4/9/24 11:48, Tejas Bhumkar wrote:
> The Kria board features a recovery application that activates
> when the FW_EN button is pressed.
> Upon power-up flash operates in 3B mode, However, the recovery
> application changes it back to 4B mode.
> Currently, after a reset, u-boot activates CONFIG_SPI_FLASH_BAR
> and assumes the flash is in 3B mode. However, there's no code
> or reset lines connected to the flash that could return it to
> 3B mode. To resolve this issue, changes were made to disable
> CONFIG_SPI_FLASH_BAR, which activates 4-byte opcodes.
> 
> Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
> ---
> Changes in v2: Updated commit message.
> 
>   configs/xilinx_zynqmp_kria_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index 7cb8b62d32..7af8b27be9 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -155,7 +155,6 @@ CONFIG_MMC_HS200_SUPPORT=y
>   CONFIG_MMC_SDHCI=y
>   CONFIG_MMC_SDHCI_ZYNQ=y
>   CONFIG_DM_MTD=y
> -CONFIG_SPI_FLASH_BAR=y
>   CONFIG_SPI_FLASH_STMICRO=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_SPI_FLASH_MTD=y

Applied.
M
