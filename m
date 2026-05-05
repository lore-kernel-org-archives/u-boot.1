Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80156FF885A
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 12:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77E6D84910;
	Tue,  5 May 2026 14:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xpAMdtHo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E4F38490E; Tue,  5 May 2026 14:39:54 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7959084875
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 14:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j80ei4rBefeXXUSiiNQdUR//zK8886uQAgP907khJ19CxMrtF96vZ2cAaCtpRBw2wcXS7EIsAG0d4VYOTWLuK0PJD/hBbceYznn0X40nNBIwDk44njyCavT79yhiDZGmaOxCStN/0QMrmaTqLVDJcKxKcqDksNyTT9ShIWMkf1bhq5DkHi/6x4ePxY8tsMY9ktCmCb0sN1sBarNdb1uowTxPxhWFQxpAjK5PotrBI1m3Hl3NeZPWNlF/XEZgJhRna6COsgxsnsobkZahizJavY/zP5Gl9xK1owZMuZGVQG8ADBVr5RjUtA/Rn67WaPGo8KGyxDu9FDNSPCsul6uuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JaHvuHXyAmnf8xIvsdwJucXmdFBf96ONra27CIAakg=;
 b=mv+cnIvwymqR8ybTIQ5QkQ0smk87k2lOz3Zd9LAg/a82/hkmFrAyOZeNhzkA82Gbm5I4INzatuqrC7XnNs4cSZi0Z2Wwh5igml4BQvnHQpuqNNgM/XlHXD/fkF3bCpq9Hn8/1lc2U6DdmYZvsLevqyV0UwnGIvvODCD12k88cSMDNwJJ5nEBwU1Uo07JTMZjH0d4Ks9WKKZQEGRQxOW195UWqBENEn1npnMXzAZny8PQ84rE0gc3lgdWBSLKLp+PZYjZX/2WYonsQ+K6qW0JZltyG7NLCqkKC8gKnqDnN84bjJOyIOwk4iXIYm75/1Xly4hrw6y9MhhNO9G+NUg/Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JaHvuHXyAmnf8xIvsdwJucXmdFBf96ONra27CIAakg=;
 b=xpAMdtHo/P08qgc5xjg1YNe4ajPXrm08zaU4FKtoy0NXZd50VKOlsvsDeAf5dNOJQdu2yJAPUBhqviw6X02/nqwPzKwWbNaRC4UTfw53CtSGwSXR7czEjVXfq8ENNmc4Mr+qtaHxsSsVclUgnG3e1axc2B1gXsuJuqGn3IvY8tTV7QCJzANW3I235p0Tf9/fCTb/oUvG2xxeqbThdIN7YxHbTIFmWm0N+RiDJnUBNcF1EHTMFWtq1ZYxBGsC+hm9bdOs3uMPRFqV8SAFEUS9z/b+kIeA2Cplq3+S3I68+iExSrQcjX+fYggcttfNA1rADup7CvQEW7XKpmJqcHbSpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by DB9PR04MB11475.eurprd04.prod.outlook.com (2603:10a6:10:5df::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 12:39:48 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 12:39:48 +0000
Date: Tue, 5 May 2026 21:56:40 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 casey.connolly@linaro.org, neil.armstrong@linaro.org,
 peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 loic.poulain@oss.qualcomm.com, patrice.chotard@foss.st.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH] mmc: msm_sdhci: Use max-frequency to get clock rate
Message-ID: <afn2mItCbroVbY2V@nxa18884-linux.ap.freescale.net>
References: <20260409070620.3655875-1-varadarajan.narayanan@oss.qualcomm.com>
 <adzaOC0mgP5vfZUr@sumit-xelite>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adzaOC0mgP5vfZUr@sumit-xelite>
X-ClientProxiedBy: MA5P287CA0216.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|DB9PR04MB11475:EE_
X-MS-Office365-Filtering-Correlation-Id: 70520af5-9f86-4542-3d07-08deaaa364ac
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|52116014|376014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: RB4FTFbTOMKM2KOGwH1u7Ld3VZv/xiM+w1k/ASPCiaV2pIAKbwDrcawpHHiuHcVg62MhxofsZhe+yby8EL1QMCLchkNZIRzelHrXZo0UJ8XGWwuaV3eQHJQCdU3ymHzWaYR6wfJ8Ngy5LyD0ZfeuoX18rqtStn/tIqDeu+FLJHSK4zChVYNUBT7uIHhKsaMiwf+9yYFhnBR4ArF3FKw6MkQMcW5omJ+5xm+G9Hs+fhqyQSvVX3Mc9Dd+lKwx5otTpF0rSRviKJuR1nID7Zp5xBMVw7C1sTpi2TwkFrjLbaBAt0pOTdBDNRpNqHQB07Xq2FdTq8OeCcwoHoX64ghnmRMJtKul5aHgzY6FtMcTZTOahGEoy/aGc1xRRNHwco72Y/I3wp8NdyHReWpmQWxHzHmgrIkC/Y+MkQpd/EcT6EiaTKEH9nDJsihQKLT/qqeXstsDdWrUI0Vgiyb+vO/aGhUs4tCls5p+sEPH+2C1SXSGimC+hZcENGgMKY0jmamPWWK0Nuemgmf2T0CORVDxwpXHEk3QyNH1CGDoQs1vtlBHXeRV8qd+NFCRZew7xw/OQo5wiKSvfaHNFg3tmc1JTiGXRwdgKXDX2RYg1DH1kRnBfGfWOspFeSaBlKm0oAwYulAeZqgtCyzLUDL4tl2IfOfDS0yB8f9mdqQyljD/qebEMt8qD5GaUYFyJcFuOt+SpQZjVtaeFL9GzV6e7cm6Fy+muL00x9n5FnMxy+F5ibFPDrHmGHDTmPuwBsaLx34Y
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(52116014)(376014)(22082099003)(18002099003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t14xigjEIW/eWFuT2MPljZ2c7sgRrt4DEdRlMRsMcP8rCzwnwE8+kwbNp4iS?=
 =?us-ascii?Q?c6mQV01Hn29WkVYAJ3h9aCBlyNOhuZRsAKUhLhNURQGeFWS5AR3B9/iGi/7p?=
 =?us-ascii?Q?xJhjFo2ksXVEsBODslFJkzuTfxMldArpWMZk3TSxusFCbkqJdNPwEWcjAk8T?=
 =?us-ascii?Q?65ybEm9SVl8iWCSvenTgOKqwc9rYWoqQI6Ann1MDli64imXWl6JhNEnCaJfo?=
 =?us-ascii?Q?PC95Ti/hbT1Asm7YoSvSJHoPoXj+3cp79fxKfZGeOO3pKIaxnPWieyzMMLqy?=
 =?us-ascii?Q?3e/telXOURP2orSRr2xRQA9Fh062Wfy5eEz+VLEkV7AfBpDSwgZEdkJYWDjJ?=
 =?us-ascii?Q?Xf2T4SREabQEGgYtRXckOpA56YC1+9DjFahpo7GQLihaxcYxEX+yHWlfbNFO?=
 =?us-ascii?Q?u1hjiK1HnsrXakF+Gq360ePKWYI2hZngwTHhwofUYrmHr/fv2eW3f4fWhkyH?=
 =?us-ascii?Q?qMcJcMZoLq2sJ69mLeRqWbmNxN09PkIErJiGwSSn21m/870gl4evRZwjRzxF?=
 =?us-ascii?Q?RwjI58QGfSThTebdPlGxlihGsv//8STgPzOwjQPfYM67avfjB8HVde4F7h7s?=
 =?us-ascii?Q?zlRHmxyGQZjMZyblMl+nlFTnGU17cmxWYZ+/n1t0PsA2vnDrgk7d5SJpn9lP?=
 =?us-ascii?Q?FGbCb9kTiEIvyDy+PjFL65sYxT5BvvowZvrJ/UlugzUcu9XQTOtmxCO3vDIu?=
 =?us-ascii?Q?0oUKllcbkzYtteFUpbV1S+1GuCp1OwW0ei+MJm82QRCruq9njOHkRQ3cJapM?=
 =?us-ascii?Q?BsUWJFYWZOP5/POOa2AISSanQY4Ov95AiJhz27Ert7yS9Fn6B1oKvDW8Rcmc?=
 =?us-ascii?Q?597Yo7lx+AZKyKW/DONKkyuOVNcT1U6H+EaUz4VQUJjO7jmEsggs7oJk/8/E?=
 =?us-ascii?Q?hKkFTxRudxDu6DDLFbZ+JotoOR8LkO05rprlvfO9ylDCwv20V0taHVhVHpAP?=
 =?us-ascii?Q?/T+7q+jnhrJQ9UYVxuX/ObgzvzvNMNdE/nx8A0ZKSREYCjAJ9LZN2INcNkhE?=
 =?us-ascii?Q?t7VJrusMFqbYXlJeElWgUMOriY5M7VuANRzhhT3mav5s32yh/IIjKZC5ALxE?=
 =?us-ascii?Q?Hwe8Cwo6mpDx87MJcO3/mNW90Sqn6h8L6UKwGsRpACA+bmChletoi3JA+ZYJ?=
 =?us-ascii?Q?a7w4caK1UZkR+0j3Ppk1BYwSThPjhjnxeENKy0yD5kwX8MvTPNJXarfji0G4?=
 =?us-ascii?Q?MCxhZuTCJa4pC6SjhFlFc6m9DNOJFaZ7HPgAWQxnGa6a/D+mlEEQxIo1f0lz?=
 =?us-ascii?Q?tZo/iSUJurAaxoi7Aaf0/+VkarN46whxz0IumYoRTAf8GPNclL6LHwk9izyu?=
 =?us-ascii?Q?fz0KCZgT561kYyQTsH+VIUbKPCygDQX9lcDXw+kEJBeUJKhZL8uPHrZjBcBk?=
 =?us-ascii?Q?F0LfvGAkNKdORhJzV8nCSQ92k6Bo8r1TmFXUtVu/IgLcVy/kN1aZjRv9vpOD?=
 =?us-ascii?Q?fAxGHilI7KcUNQGt6d9ZpFa7V7Uq2j1/enZjYfAgS1UUj7iRfpUttGaxoBYo?=
 =?us-ascii?Q?0TUR4v5/b2JKAWdxoFiG+o8CV5z5Nh4ET6PR5RXhaZNjlQYAKq1ydz1uzer8?=
 =?us-ascii?Q?ep3uAD5BmUd5Wh+DNJJb2ghzkls5OJDyF7AYyuke3HMICy9JLMcEW6buyPKc?=
 =?us-ascii?Q?nojH1/xPPWTstY3MKcj2CatTN9w6Up1WQt63p6DBfh07dbrswHEc6Z8GKHJz?=
 =?us-ascii?Q?OTwDwRSiA1NLwMeA93jK9ilEeNSRdENHM/lc//Xtas/1DrkM/DMwZfsWrkip?=
 =?us-ascii?Q?w+chA27Bow=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70520af5-9f86-4542-3d07-08deaaa364ac
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 12:39:48.0588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GT8n9VywZUJIimRjmEFiF7rx6laZkqzVPWyQc/TR3SuvxPIPpBTvfjatG0Sh0Nu1ZdRclG/3EeIF0W9UmnRlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11475
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

On Mon, Apr 13, 2026 at 05:27:44PM +0530, Sumit Garg wrote:
>On Thu, Apr 09, 2026 at 12:36:20PM +0530, Varadarajan Narayanan wrote:
>> msm_sdc_clk_init() uses clock-frequency to get the clock rate for SDC
>> clocks. However, the DT files seem to use max-frequency for the same.
>> Since msm_sdc_clk_init() doesn't find clock-frequency in the DT, it sets
>> 201500000 as the clock rate and this results in timeout errors on IPQ
>> platforms. Hence, try to get max-frequency if clock-frequency is not
>> present.
>> 
>> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
>> ---
>>  drivers/mmc/msm_sdhci.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mmc/msm_sdhci.c b/drivers/mmc/msm_sdhci.c
>> index 66f3cf2de4f..2e6120f18ff 100644
>> --- a/drivers/mmc/msm_sdhci.c
>> +++ b/drivers/mmc/msm_sdhci.c
>> @@ -71,8 +71,8 @@ static int msm_sdc_clk_init(struct udevice *dev)
>>  
>>  	var_info = (void *)dev_get_driver_data(dev);
>>  
>> -	ret = ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate));
>> -	if (ret)
>> +	if (ofnode_read_u32(node, "clock-frequency", (uint *)(&clk_rate)) &&
>> +	    ofnode_read_u32(node, "max-frequency", (uint *)(&clk_rate)))
>>  		clk_rate = 201500000;
>
>Looks like clock-frequency is just a leftover from legacy DT nodes. Now
>on Qcom platforms, upstream DT is used. So let's just add max-frequency
>check compliant with DT bindings and drop check for clock-frequency.

For Linux Kernel, we usually keep backwards support to avoid breaking
legacy DT. To U-Boot, I am not very sure, but it should be fine
to drop legacy DT.

Regards
Peng

>
>-Sumit
>
>>  
>>  	ret = clk_get_bulk(dev, &prv->clks);
>> -- 
>> 2.34.1
>> 
>
