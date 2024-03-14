Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2242C54E5D
	for <u-boot@archiver.kernel.org>; Thu, 14 Mar 2024 06:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BBCE87D98;
	Thu, 14 Mar 2024 07:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bqLsLYVq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A4FE87CFF; Thu, 14 Mar 2024 07:46:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CED0087F40
 for <u-boot@lists.denx.de>; Thu, 14 Mar 2024 07:46:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNWlfRwDYLdeOqh4FMLh9EDpFjPQt8pZjs7vwzreOSVLE1akd0zeC5ygSAMNCUJyo1FSYNuovFbuNQ9y22eOJtIkd8BuFFfHMXuCk5C2p2+dmOaq1bHSIJnaCOFY739pTdrjK6QN2nzqj8ipHwubZXD5CyJ2683JXLAM3qAok6mK0loa9/wcqTelDighOXYm6K9FYigwMTsM7/7GboQif4uPYoGNFobCeXSePYstlFUuTj8KMVtiRNC2ObdQ3R47ykvuJYZPrztYfCe7I7ve3PJvL6gg/t+O/mu0ooY1FzNBYkOQgMl+mXIVO+jwRaQRM6oSlf33M2qWWUhYsjY8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nkCY7kWzexJUcuKvRzXE9S8TrkSYqf+aOvGv1/M/2g=;
 b=WghUSReH0eL1W1nVCVwwC2l9VLaXNqgrvqU+5K1vmnfVzXUDH5nMWhR8ErGRm+DhtjMdrhVAnJUcqWY19ZFFrk1VvkFl8giaxK4nz77XjK4v4A85Mt3oXDppMuwNmWx/e1B6fsjbZ2X9bl9KorxQgI1W87enEJGjt+jWehf45Trsk98Rcqncy3alvQCn8bm5hm8Rw6JiNJ2oG6nTTuyZgw7VozUZ78M0DYzTfXc4eoLPWR+ILbZzv/O2m5P4E9wsafALMNIh76QXYoXNM9RP3ijMSdiStGWKYj5fhQhCNz074JLjsRSQEufx75VY2xFpQ1UL8v6F+5fj7LuHfStydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nkCY7kWzexJUcuKvRzXE9S8TrkSYqf+aOvGv1/M/2g=;
 b=bqLsLYVqRh7wlLofmJCSRkx//82+bPJ5vKKix94pJN98q6cUBKyhGNiLiA1cU+34EeqqnJt1MmPfuqFOqM/1Yp7tkZayzTJdcWeMl+qNkgpO1atpXiNqd2emMMHp8rTlPbVHgRV6Z2XaKoAlR6vT0K8SWodQjz75yo4TkvhGr5Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4461.namprd12.prod.outlook.com (2603:10b6:806:9c::22)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 06:46:03 +0000
Received: from SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::17ee:bb1c:2418:7e32]) by SA0PR12MB4461.namprd12.prod.outlook.com
 ([fe80::17ee:bb1c:2418:7e32%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 06:46:03 +0000
Message-ID: <6dfdaf59-156e-40db-9130-4d62e6e5e8e3@amd.com>
Date: Thu, 14 Mar 2024 12:15:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] mmc: zynq-sdhci: refactor tapdelay settings
Content-Language: en-US
To: Steffen Dirkwinkel <lists@steffen.cc>, u-boot@lists.denx.de
Cc: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Johan Jonker <jbx6244@gmail.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, venkatesh.abbarapu@amd.com
References: <20240223140613.1240570-1-lists@steffen.cc>
 <20240223140613.1240570-2-lists@steffen.cc>
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20240223140613.1240570-2-lists@steffen.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::9) To SA0PR12MB4461.namprd12.prod.outlook.com
 (2603:10b6:806:9c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4461:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 66473be3-092c-4aae-c90c-08dc43f26ac5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H6YM+E3WMdYhIQPYrKZEu/Vl5QtO3+8of8+r3MoDeRa2YUhWbtqsb9957srsD4Jq0prfkqR4glEJzQUBKgmGYN32NZ5cFDBip+nGjsDxvM2p8PApbYzSiBktcyBid96R4IqsCIWJgRU2ODIhdL3ti6ikZKBdudKYjDeCeyPC3HqDOW179EJ350u6J5E3pKhsQUG8g4FSdqdUiAF0o4/10QSw5LsOjJlmRRIHPf0huSIAaCowTNW6wnHSZrU9FI37bMew/XNXlmBW7oE863IKpeNQaX40K2Z+9GUviZt7PWcr8ShmKBIC9qkBtgsT82XV6nPZ0U7CfbijLZGgW1PVpoLRIsiKppccYvTPMy4qLL7TAFEt/JfctTqjZcEVf8Coc2/GLc5pdAW52OhfevWKppuW/Wv51RJ743Old8pkP9843ajfKxs8VAcIVQ2S+hLCUwFTs6mPsM3sTBhyVB8oWunQ2Y9duMgcuv/OtI6msIDLxD+rssfSktGGnVg7/E7lFq17vrjUjtI4YDr/SxONBXPZtGxPoiIh+lJlleQXHILpM60ctC6s2rIKSB7P5KJ0rf2luAsoGM6QxYrEq8VZtf3rBOV8/ptcoKlrx7zmPu4BGQzCtBh6I6SkZjGRixxjXBsWmwzhG+aG6OFyUqil75ASO8prfwalTcAeAQclVv8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4461.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SktXUUFUd3RMemNTSys5VXloL3dpRDFSOEQzMGkxNm81TmtZenhQS0Z0dFBX?=
 =?utf-8?B?VkVidDhOZlhxMHVkTGtKczhOVndjbUUwYUJoWjlyNWI4SmhTTUdzZzdObVl0?=
 =?utf-8?B?VThWR3FZVXEvMjNSVE1aYkJ0ejIzZ0VsdFRidHlobnBJM2o3N2U3ODRGMExq?=
 =?utf-8?B?WUlJa2JtdzV5cTdNUHdtREMvN2VlRG0xcXpsNGJ5MWRCOUJjRzY2djYxZnFG?=
 =?utf-8?B?anp2TUJ3MUxwZ1JidzByYjYwY0ZKUjZZN3V0QlB2ZzZLcjBoR1JVK3I1bXRT?=
 =?utf-8?B?OUFLRjNHTWVQSGxteHFQeS9pSWRQVmxMR2JqRW9VSFoyMXJCMTJkb3ZFaGxt?=
 =?utf-8?B?K29oR3g4dWNTdWJRNmxzQlZkSzAwbFhYazE5aDRsQ2hXK0xIaGRUM2tpUFlB?=
 =?utf-8?B?REJvY0hld2pHM21SbUJvQXJhaGRQbEpoaEpGQSt6K2ZZd2c0dnM5c1NwbWUv?=
 =?utf-8?B?MlZGYUZQdFR4eUtoeUhZMEZmZWFaWWpIOGtZU1Z6eUpaSVp1WWZ5bWNueEpW?=
 =?utf-8?B?YjQrTEg5bytya2hvci9pbFU3RnV3RkZwWGdGMmhEK2tSay9JZnY5TDg4alcz?=
 =?utf-8?B?K1pMdWtMSE1WeGxiYTlQVWZCS0tudm9MKzU0NjBpTXVsTFBoTHN6ck1CcE9k?=
 =?utf-8?B?bjY1VDJ4Ky9rQndrU2hnQnp4VVJwckdYNk5EMUxBT3JVck1xelBzL3FkSEFn?=
 =?utf-8?B?NXBrN0xXNnlQbTR4QlBhOTR1V2RtK0J1NjI0UXNGdE5WNUJsajBEdnZZZGl2?=
 =?utf-8?B?ZUFCL3YzVEx0ZENYU3JvMGpudnQ5b3dIWTZLdUxkb1A5NXJCTkJjUUhvaW9V?=
 =?utf-8?B?bVUrZVUxRzlGazZEQmdFRkhITGRrK0UvZ0ZaOEo0VnZ5YTNwT1Z6cXhLa0Z5?=
 =?utf-8?B?MU4zZVpoT0pHUmdnQ0RYQjljbVh4MTl2blhoVWhIbmdsZ0dKVVd1OGhvMDVZ?=
 =?utf-8?B?T3NxSkxOTWtUdGpZYW1WN3pVTlBrQmtVTWt6ZFRSUElOcUtUd0V4aGZJWVcr?=
 =?utf-8?B?WnA1dllaR1NmbUNkMGxIbjRseEJLM1NjSFBhdnhGUEo5YXRmcjY3OVhYUVcy?=
 =?utf-8?B?aW9yQTMxVUUyb0lSMnNGdW5DRVlwRTNvY1ZtNVNJek1XOHozSUR1OG50VGNo?=
 =?utf-8?B?UUwvU0d2Ni9CKzhuUGdGY1ZZdEtUSUJTdDdiWE83ZEFBV251N0dDQy9iWGFS?=
 =?utf-8?B?c2tzcW1HalhFeFh5TWJLQ296aFZMRXZLdjRYZVNhUitsUFFMN2hOS01keDIw?=
 =?utf-8?B?aXlrWk1kZThCUUw1QkJ2OGJkRndleFdUeVhwait6TTFxb0V4Z21WVXNjTU5r?=
 =?utf-8?B?eUxsVTlOVUFPbi80Y0hOUkdYUnVxS2w0QjlSdFNWZ0xXRlcxcDBtNG4xRE9N?=
 =?utf-8?B?RTU5eC9uTFRBSG9kTkdJRHF0SFRKL1Y1K2hnclJMMEY4dmp2ajVJQ0FEZ3hm?=
 =?utf-8?B?QUd0b09hRU5xdFV4Zk5yVFgxR1U5WVBJVWFjSkVFcTNBUTNqcVUwTGdLR2FZ?=
 =?utf-8?B?MnN5enhjUDFIZ3h4TnM4UFRTMjhSWm4zRTdpMHpOMlVTd0NQaDNwVTZRQlZI?=
 =?utf-8?B?UmN5a0hwRnlsRUM1NnJYLzdoM296c0hkTUlTSEZJUHR2bkUxQk91Z25WYzIz?=
 =?utf-8?B?ZzkzNHpNQXRuTTJiN1VDVmVrZk1ETDJhbVI0SWZnTUVPS2JnNnZVV3JQTldG?=
 =?utf-8?B?SVZJcUZTMjdUcVlGbUpNejRwdEJFOEVSQ3g1SlEzb3VHSFpOTU4wNDhXR2J3?=
 =?utf-8?B?U1Y2YTdaQVF3a29ObDVrcVVrdER6VmszWnBaVjV3WVNUb1ZlQ1p0SjVaUmJW?=
 =?utf-8?B?OVVqZzNHeHJiOXJTdy9xTmovdTBxWmdYdm9kalBWSW42bExRcUExRU1KbkVU?=
 =?utf-8?B?dWFGeVBURDZmYUdjREtZaEhhRFZNQTl4cks3M3lnZ0dCR3RVNUNaY3dqcU1E?=
 =?utf-8?B?bElFUE15VHZRajBKeWI2WXNSY3NUOTlxbk8vS2VRY3oxNUdXc0tkYmlCQ3VF?=
 =?utf-8?B?d2UwTVpua3pqbCsrSHFGbTA2VE1MSGkwVzREaDlWZFIySElTMWZRWmtPNjU0?=
 =?utf-8?B?c0o0RnpCaGhYWjhWN1J0WU9nTmVnVnZpK21TZG54dzZlL1MyQStqNDNENDh4?=
 =?utf-8?Q?sBPA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66473be3-092c-4aae-c90c-08dc43f26ac5
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4461.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 06:46:03.6449 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJ4dAf4hyFOZmJ37s8fLPmt/GexWmD4yHp/lZ7kweO2vMbtR+YypvDVyoNS3d7Ze
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

Hi,

When we run in el3 for zynqmp board, we are seeing below issue with this 
patch:


Model: ZynqMP MINI EMMC0
Board: Xilinx ZynqMP
DRAM:  512 MiB
EL Level:      EL3
Secure Boot:   not authenticated, not encrypted
Multiboot:     0
Core:  10 devices, 9 uclasses, devicetree: embed
MMC:   sdhci@ff160000: 0
Loading Environment from <NULL>... OK
In:    dcc
Out:   dcc
Err:   dcc
ZynqMP> mmc list
sdhci@ff160000: 0
ZynqMP> mmc dev 0 0
arasan_sdhci sdhci@ff160000: Error setting Input Tap Delay
sdhci_set_clock: Error while setting tap delay
sdhci_send_command: Timeout for status update: 00000000 00000001
ZynqMP>

Regards,
Love Kumar

On 23/02/24 7:36 pm, Steffen Dirkwinkel wrote:
> From: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> 
> Previously we were setting in tapdelay for SD1 every time even if SD0 was
> requested.
> The SD tapdelay settings are shifted by 16 bits between SD0 and SD1.
> We can use that to make our tapdelay setup simpler. This is also how it
> currently works in arm-trusted-firmware.
> 
> Signed-off-by: Steffen Dirkwinkel <s.dirkwinkel@beckhoff.com>
> ---
> 
>   drivers/mmc/zynq_sdhci.c | 65 +++++++++++++++++-----------------------
>   1 file changed, 28 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/mmc/zynq_sdhci.c b/drivers/mmc/zynq_sdhci.c
> index 935540d1719..d4845245b2a 100644
> --- a/drivers/mmc/zynq_sdhci.c
> +++ b/drivers/mmc/zynq_sdhci.c
> @@ -42,14 +42,11 @@
>   #define SD_OTAP_DLY			0xFF180318
>   #define SD0_DLL_RST			BIT(2)
>   #define SD1_DLL_RST			BIT(18)
> +#define SD1_TAP_OFFSET			16
>   #define SD0_ITAPCHGWIN			BIT(9)
> -#define SD1_ITAPCHGWIN			BIT(25)
>   #define SD0_ITAPDLYENA			BIT(8)
> -#define SD1_ITAPDLYENA			BIT(24)
>   #define SD0_ITAPDLYSEL_MASK		GENMASK(7, 0)
> -#define SD1_ITAPDLYSEL_MASK		GENMASK(23, 16)
>   #define SD0_OTAPDLYSEL_MASK		GENMASK(5, 0)
> -#define SD1_OTAPDLYSEL_MASK		GENMASK(21, 16)
>   
>   #define MIN_PHY_CLK_HZ			50000000
>   
> @@ -275,44 +272,32 @@ static int arasan_sdhci_config_dll(struct sdhci_host *host, unsigned int clock,
>   static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
>   {
>   	int ret;
> +	u32 shift;
>   
> -	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
> -		if (node_id == NODE_SD_0) {
> -			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN,
> -						SD0_ITAPCHGWIN);
> -			if (ret)
> -				return ret;
> -
> -			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA,
> -						SD0_ITAPDLYENA);
> -			if (ret)
> -				return ret;
> -
> -			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYSEL_MASK,
> -						itap_delay);
> -			if (ret)
> -				return ret;
> +	if (node_id == NODE_SD_0)
> +		shift = 0;
> +	else if (node_id == NODE_SD_1)
> +		shift = SD1_TAP_OFFSET;
> +	else
> +		return -EINVAL;
>   
> -			ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN, 0);
> -			if (ret)
> -				return ret;
> -		}
> -		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPCHGWIN,
> -					SD1_ITAPCHGWIN);
> +	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
> +		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN << shift,
> +					SD0_ITAPCHGWIN << shift);
>   		if (ret)
>   			return ret;
>   
> -		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPDLYENA,
> -					SD1_ITAPDLYENA);
> +		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYENA << shift,
> +					SD0_ITAPDLYENA << shift);
>   		if (ret)
>   			return ret;
>   
> -		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPDLYSEL_MASK,
> -					(itap_delay << 16));
> +		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPDLYSEL_MASK << shift,
> +					itap_delay << shift);
>   		if (ret)
>   			return ret;
>   
> -		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD1_ITAPCHGWIN, 0);
> +		ret = zynqmp_mmio_write(SD_ITAP_DLY, SD0_ITAPCHGWIN << shift, 0);
>   		if (ret)
>   			return ret;
>   	} else {
> @@ -326,14 +311,20 @@ static inline int arasan_zynqmp_set_in_tapdelay(u32 node_id, u32 itap_delay)
>   
>   static inline int arasan_zynqmp_set_out_tapdelay(u32 node_id, u32 otap_delay)
>   {
> +	u32 shift;
> +
> +	if (node_id == NODE_SD_0)
> +		shift = 0;
> +	else if (node_id == NODE_SD_1)
> +		shift = SD1_TAP_OFFSET;
> +	else
> +		return -EINVAL;
> +
>   	if (IS_ENABLED(CONFIG_SPL_BUILD) || current_el() == 3) {
> -		if (node_id == NODE_SD_0)
> -			return zynqmp_mmio_write(SD_OTAP_DLY,
> -						 SD0_OTAPDLYSEL_MASK,
> -						 otap_delay);
> +		return zynqmp_mmio_write(SD_OTAP_DLY,
> +						SD0_OTAPDLYSEL_MASK << shift,
> +						otap_delay << shift);
>   
> -		return zynqmp_mmio_write(SD_OTAP_DLY, SD1_OTAPDLYSEL_MASK,
> -					 (otap_delay << 16));
>   	} else {
>   		return xilinx_pm_request(PM_IOCTL, node_id,
>   					 IOCTL_SET_SD_TAPDELAY,
