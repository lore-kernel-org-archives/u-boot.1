Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5940AE77187
	for <u-boot@archiver.kernel.org>; Wed, 18 Dec 2024 17:27:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F09D80269;
	Wed, 18 Dec 2024 18:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Ho4iAcTc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F190280274; Wed, 18 Dec 2024 18:27:42 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9971180241
 for <u-boot@lists.denx.de>; Wed, 18 Dec 2024 18:27:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ukDZ8xjEoZaq1l6iwe9+dovd2GGNJpgCn3tt8zWySvinhAk5nACth/OHCvRlq8WHaGxiFvFnZ9MI07nhZQSGASTwLRZ4oAjC+eICx+3vhVaaRIib5AFtfaEi93WvuXCjEYWaYKt9AzoJVjxlWhIB9AZjDWeZopxuIeTSOVCq3w23+F+XLFBi1Ng68tIVYEssmhw07Kzla5KdvF7JW+j8X+nYXIdK3VQbgVvR3AABpPC05SfSN9QXAV/llX22zOWQv9pTu/+39UkNKs0y/Ntb5U+96TskiBF86kBLav4uCsaPntGDipNLKZ9ohvCVOBFC1HUgLw2jT6FtByOpVb6YSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87vcNtUoTsLc8r5OnzwsV/kwCzZcJJu35RJ4IC7YX5Y=;
 b=inkHAOOvVcePiveG5qvySwNaoNmTWwGU7yOt3AToOLKbQWm1+FePcb94NRlJxeDZjgCrbzctT+WHF+XnnImWt257C73gHzPwhSb+peVnWwjDCervV/CmkvZUJyjc8wlBZ+yhbHIfsP9//uRtszH+Wk8DqWps/sKoeQpIpNXznF24bekRdrzMawEf8jftnnmW3hpIXf0SQJRg1IOkWuuRlt+wBMDxWQfKofWkAwpseaa9eYL/qpSfoNNmfsSFZ2n0cjVgNyd7Czh9OU9bbMIVyFjl5CX4T6FFd/XDoJYVDdYlQv47dimmRDYrMNkCHv/P7wIcb54iiDyrj0rVaBiFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87vcNtUoTsLc8r5OnzwsV/kwCzZcJJu35RJ4IC7YX5Y=;
 b=Ho4iAcTc/QWQhVX5aG0ChDuR6yb2tBKpZ0K9eUvXw/g2yKUo5KBRf4dvsoNiCwByXfM9PIBpj6iytLD5upkKssajco+36zua1oWnQRiTBLDzdORyye/dH7BZc9g/qLF5UlpW3CzBamRdd4GsQxtmNWhEzEhy4BbixX4tE0RE9gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB7893.eurprd04.prod.outlook.com (2603:10a6:20b:2ab::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Wed, 18 Dec
 2024 17:27:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8272.013; Wed, 18 Dec 2024
 17:27:38 +0000
Message-ID: <fd8470e7-4527-4024-8477-63248a7cc6de@cherry.de>
Date: Wed, 18 Dec 2024 18:27:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] board_init_f(): use static calls
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Michal Simek <michal.simek@amd.com>, Jonas Karlman <jonas@kwiboo.se>,
 Devarsh Thakkar <devarsht@ti.com>
References: <cover.1734537135.git.jerome.forissier@linaro.org>
 <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <252364e53d56fab1c77bda74563b24ad8a17d635.1734537135.git.jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0121.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::12) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: b65a6e49-d9ed-4d73-e39b-08dd1f89450c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UHA3VnlLeVA0K09wbDQ5akFRamluNWlwZUZIbnJaaU9VSnA4eGpVR1R6WEI2?=
 =?utf-8?B?WFYvYllmakxBb0VFSHdJRnM3eTl6L1gvVlJ4anh2bW4xSkVxbWtmTXZVMGsx?=
 =?utf-8?B?d1luMkhEWHlVenFXV3FJOTkxb21UVDdiaWpBM05BZGJ5ZEFraXh2RkY3enND?=
 =?utf-8?B?dE4wa3JIWWV5ak5JMXdObWFpY3UvVEJCYml6OEFZaHRsRXh5TXpHMnhmb25X?=
 =?utf-8?B?NFBzd0Z2SzhwUjk5NWl2b0FaYVYzeUJxaEZWKzdkRUhIWkNJSzErZ1BWRzF6?=
 =?utf-8?B?Sjh3TUlzUGdUdXA0WjgySTRYUVVNSDNmUVg1a1BOeU1TeDNZaGlHYkFHc3Iy?=
 =?utf-8?B?d1BkYUtwblR0Y1cxVG9MU0swb2VqNngyRDQ5OXhoOHh5b1JudVgxU3BEcjNv?=
 =?utf-8?B?dXcxUVJYS0NrbnpRaHJiUTJ4NitRQ3lGNFFscGRybWpOOEkzdy9kbzZhbFZO?=
 =?utf-8?B?WUtuc0F0R2JrbStUS2lJYWNaeGlGaVZ4WTU4Zk9ZWURWMEtzMUc0UnhDODVP?=
 =?utf-8?B?WEdodHJjV0RGVVhLdkpWc2JZVUQ4QU0ycUN0MU9lU2oxOWNMcFpyRHQrL3pq?=
 =?utf-8?B?N3ZzZXRVR2ZhWDZlZ2JyakloVXpwVXkxTzcvcGlneUVYc3JJdk16OHRwU2hP?=
 =?utf-8?B?VkdzcDhnQ05NbEFJd25ZSUxIVjQ2VzBCZGRuTTY5QnhTVVQvQXR6T3FidDBk?=
 =?utf-8?B?NGVHL0dxTDREYW1BOTYvSkJOZlE5OHVPWnVaSmVkVklESHY1U3BYTzd4dlU0?=
 =?utf-8?B?ckhZQVltVDlSUXZUZXRaeXhtZHcyMzd5N1ZNeVdENGdFTkI3L2d2M2pOLzdj?=
 =?utf-8?B?Y3krcEoyQWVtcVZqeHhwZk5hbkFFZ0EwL2JGeE1PZmY3aE10YWM5eHlsek9L?=
 =?utf-8?B?bEI1a09YYkhXL3ZnQVYzMGRRM1BEazYxMkc3Myt6eWE5YzlmVmtlRXdJdTVu?=
 =?utf-8?B?WDZEZEQzNVhJOEhFaDZ1bU93OUFNSUozTE9STm9tbmJ2MGZQSnhTSjgwcnA1?=
 =?utf-8?B?d2tkeFZ4Wk1oblNKZURvMXJ3NmJzR1ZZay9QbkZYOEN0VzV0OW9Yb2VIZUJJ?=
 =?utf-8?B?OG1ReXhyUVhFQ29uOEFnczYwSFBiVlJEeEhQOFdpYjRXRTdqb0VrUG1GWG1E?=
 =?utf-8?B?K29ScEdhaC85V01FcWtVWW5WeThLQzVQWXYyb3BkdkpXSk5tQTN4ajIyM2hl?=
 =?utf-8?B?ekVjbWZOTm5rY3dNTnJ0M2E0SGtNY0htWitzd1psN2k5bW9VYlZjOUNSdGg2?=
 =?utf-8?B?RW5BRVBmNkwwZnVPZ0NEbkQya1hFR1Y4OVNxc1dTcGFDcG5JZkYxb3JtSDVW?=
 =?utf-8?B?RTUwVGZuMlpOT3VhcCt4ZVQvRGY3akNHVDc5ZlI0Uk1FTnVTQzQ5aTZva3hV?=
 =?utf-8?B?ZVZEVmtmVTk3ZWNRV0RNSWYxTkIwM0dQdVVRLzdUOEVkaGRKSUhhMThIckdI?=
 =?utf-8?B?K0pRRUl3b1FpZyt1azBocmFLRk1Xd3lXRUR2UWZHK29nQXdEY2hWREo2Rkpz?=
 =?utf-8?B?Z2ZSMW1BTUNJNi9vaGZEdHE1c1NJbWl6RnhsVmJUTkk3ZFJBOUlNMHB5Lyt5?=
 =?utf-8?B?SmlqQW1QRmFFUXdqMStJdytQdDlVMzFOZUFna1BzZUI3ZFdwOE5CUUljQm9z?=
 =?utf-8?B?UnVYeE9UeWpVSXZ0ZGU0bFJLRENncnVlMW1sRFlCVVlQUklIWEZCMnQ2WUs1?=
 =?utf-8?B?OXBTSnVmTzBLK0RJUlhzT0pSOG1JR0pwZGF4NDNnL2FKbVIvMzFseXpVS3lI?=
 =?utf-8?B?dmM4ekhhc0wvcDA5MTROeGU0OTFvSkJHZjhSa3JkTmhXaWdDK1d1cjkybm52?=
 =?utf-8?B?OEdLbm5rVEx0R1FGU2J5Q3hpMWo0am5IMisvaHd2SjhhbDAxTkN2NzBuVVFJ?=
 =?utf-8?Q?qfFhD79yMYEqU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ajJIUWJCZXlLWUEwdGRuSTRtZ2JWUTllaWtNenozUFVWajhFYkJvZnoxYVg0?=
 =?utf-8?B?QzhERm5vQ20yWktXYU9qQnRGTXBhMEFIdStrRGRFSGVEcjBKcUprc005S0V1?=
 =?utf-8?B?aC9laWYxOGlyQ2VxOGVacFBjZkg3NlY5MGZSVml4SHNKSHhSdC96MUx0a2Jj?=
 =?utf-8?B?aGV0TGE3QXhFL0VUVmNHWC9ta1hMTXRuZTFORDJ0NTRXV2R5NElCNHBKSGhT?=
 =?utf-8?B?ck0vMGswNmRwWU53Z01mR0V3RDN6ckxTdnE1a1NiaFFRVTBucTRSSFFnSjJ1?=
 =?utf-8?B?MmNKa0Y2RVdsTDAxRHRiQWduTG5KVEVraHdJQnZlM2xrMll3RTdXbVVSMCt3?=
 =?utf-8?B?eFhjVTlsRFlzN2NpT09GNDVHMEFSTGg3c0ovOVE0blM1QzdUTnNzT2R1NUVI?=
 =?utf-8?B?OWsrNUQxc291V29BNlJhZms4QnJCMFdSWXBGQU54RHhFTG5WR01SSzFidXpM?=
 =?utf-8?B?ZzR6Ty9LRUo2ZXhRMzNjbWxCQVJEdkxuU1V3dFovRDl5Vkh5OVdRYllabDhP?=
 =?utf-8?B?V2hxOUVKKy9PL0h3M2dvT3ErVm82OENXUkpMMzFTZWxrZTAybkN4ZU8xOVBG?=
 =?utf-8?B?NllZMks1LzZNdFNEYmtKczdoRldaRms2TWJTR1BYeHV3R3h2bUp1NVVmRHI2?=
 =?utf-8?B?ZFRpaEFMMHhSUnA5OUtldk4vcy85cVBuZkdoeS9seEFjaGNhZFhnQWNPWTE1?=
 =?utf-8?B?Z2hNQmF5NC80T2FrSnZsSjZMNEVlbVUyN3NjTTE5K1Z1dUF6UlBmWjExTzVE?=
 =?utf-8?B?Y1ZWa05GS1RibG1hcmVBNnM1MWhWNE1PUWdnTFNRa1JEeFRXZnp1eCtDd1hk?=
 =?utf-8?B?N1BuMTBVS09EOEFSb2xQRDdpejNrSUViV28rQjF4T3N2NEhCT0dPNkM2Snho?=
 =?utf-8?B?MVJrTHBVdnlxSThmRFlBU2REc2l2dER5a3lNL2lkQ2wxSkM2SW1iM09DMlor?=
 =?utf-8?B?U1dqVGZDaG56endWZE0wTEw3THBJZzNKZzZUTGd2MkNQU2hOdFJ2RUJsWVBP?=
 =?utf-8?B?amZUTk5UZnlOYWpjZlhmODlWYlRIOUVuQ2t2cTgrd25JeXJJSG9MV2lyNU1Z?=
 =?utf-8?B?VmxSNXhlNkRkdjh5VFFSTEU1UjhENWFwd2IzWWhrUjNpK0hNcHJDL0U5RG4y?=
 =?utf-8?B?NVp4cEFzNjFsaWJabTRkUk1qczZvTklmMU9YZExpUEU1WWp5UDZ6RXVvMDNK?=
 =?utf-8?B?WUZoL204dUdyNjg4bEM3N1V1b1dyV3cvTWxzWE04MFc0dFc2OExWbTVIWi9n?=
 =?utf-8?B?Z1QwelZTV1YzQ2g2NXA3czdKc2cyalp2NUpmdkY4ZHdHbytoeXhFUFJMRzNM?=
 =?utf-8?B?VjlKclc3MGQvYlc3RVFEVWJrUU1YSVZic0JOV1ZLSnRGYzNmcU5uZnhpWjdD?=
 =?utf-8?B?UmZ2V1ZPUllBYUEvRzNwMHlwRHREcDE4b3h3N1RoQjdYanlNVFQ2Vms4ZytR?=
 =?utf-8?B?MXd4ekhvcTdrL1RWaVV4cnBDRGpqT2x4NW5uZGpPcERWKy8zaXh2SDlEZ0Jx?=
 =?utf-8?B?eHJjazdXV0dtVjJwaHpjK3h6RXo2N0dleUo5NmxWZXBZKzhtUUduYWJYU2R4?=
 =?utf-8?B?c29YR3Jzd0E1em9oWEY4TW5xUHdvcXZjSW1icXIwQjhOc3o2UFI4blpVd05P?=
 =?utf-8?B?THpsZzJWUGQxOHg1dEZZd3UzK0xLdklHLzluN0VlOGlVSjhUeEhWM3VRUFd5?=
 =?utf-8?B?OUEremMwYVhVNDhnQzJrUDNPbzN6N0hUTGhvaDZDaXZMdjJIc3JLV0hxLzNS?=
 =?utf-8?B?TXQ1K1FLOWtwSHp5NEZ4aVVrOU5NQ1E3ME1rWGcrN3R1T1ljQ0pnTEp6N1Ry?=
 =?utf-8?B?NTdFVjBYdUpLSElDMndpZk1iQktXbmU1Mm1aUVpnbHgwM1NLSmpUckVjRmt0?=
 =?utf-8?B?TG5kTWJUOE5LZzdHU0VSb1AwbG13Rit6bzVRckxTZlN5MnNQU1hpdUNaQzlJ?=
 =?utf-8?B?VmpITGgzaE5YcW02aENGZHZUc0MzbjBZRFlPU3l5Ulh4VzJmUmRoMGlJbVQz?=
 =?utf-8?B?bGFxZmlUa1ZId25pR2NxUmorK2RDMm1ncXJrOXYxbXM0TjBQN2Zra29CUk5I?=
 =?utf-8?B?dHkyZ0R1MmFMbC9rQXdoWHVkSFcyRzNmZ2FGZldrbkpONUY4TkJ1a3hSTUNY?=
 =?utf-8?B?V2xiSHJ5a0pEZVFpcWVhOWxVUGZMVGhvVitKcGVUYjhXclBJRitZa2lZQVZu?=
 =?utf-8?B?UEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b65a6e49-d9ed-4d73-e39b-08dd1f89450c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 17:27:38.7554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nghucof1G/IHflMQzjPjpXrBA1LQ8wIDKr6xtFtXq5NRPtBVYSU7ygQ8REZF2pDiix/AEUyQ57b+BKWmw3ip67mGD56pz9Rf1dApMOqozgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7893
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

Hi Jerome,

On 12/18/24 4:53 PM, Jerome Forissier wrote:
> Make static calls instead of iterating over the init_sequence_f arrays.
> Tested on a KV260 board (xilinx_zynqmp_kria_defconfig).
> 
> - With LTO enabled, the code size reported by bloat-o-meter is 1200
>    bytes less (-0.11%)
> - With LTO disabled, the code is 594 bytes smaller (-0.05%)
> - Execution time does not change in a noticeable way
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>   common/board_f.c   | 165 +++++++++++++++++++++++----------------------
>   include/initcall.h |  27 ++++++++
>   2 files changed, 110 insertions(+), 82 deletions(-)
> 
> diff --git a/common/board_f.c b/common/board_f.c
> index a4d8850cb7d..cebed85ed4d 100644
> --- a/common/board_f.c
> +++ b/common/board_f.c
> @@ -38,6 +38,7 @@
>   #include <spl.h>
>   #include <status_led.h>
>   #include <sysreset.h>
> +#include <time.h>
>   #include <timer.h>
>   #include <trace.h>
>   #include <upl.h>
> @@ -870,58 +871,60 @@ static int initf_upl(void)
>   	return 0;
>   }
>   
> -static const init_fnc_t init_sequence_f[] = {
> -	setup_mon_len,
> -	CONFIG_IS_ENABLED(OF_CONTROL, (fdtdec_setup,))
> -	CONFIG_IS_ENABLED(TRACE_EARLY, (trace_early_init,))
> -	initf_malloc,
> -	initf_upl,
> -	log_init,
> -	initf_bootstage,	/* uses its own timer, so does not need DM */
> -	event_init,
> -	bloblist_maybe_init,
> -	setup_spl_handoff,
> -	CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F, (console_record_init,))
> -	INITCALL_EVENT(EVT_FSP_INIT_F),
> -	arch_cpu_init,		/* basic arch cpu dependent setup */
> -	mach_cpu_init,		/* SoC/machine dependent CPU setup */
> -	initf_dm,
> -	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (board_early_init_f,))
> +static void initcall_run_f(void)
> +{
> +	INITCALL(setup_mon_len);
> +	CONFIG_IS_ENABLED(OF_CONTROL, (INITCALL(fdtdec_setup)));
> +	CONFIG_IS_ENABLED(TRACE_EARLY, (INITCALL(trace_early_init)));
> +	INITCALL(initf_malloc);
> +	INITCALL(initf_upl);
> +	INITCALL(log_init);
> +	INITCALL(initf_bootstage); /* uses its own timer, so does not need DM */
> +	INITCALL(event_init);
> +	INITCALL(bloblist_maybe_init);
> +	INITCALL(setup_spl_handoff);
> +	CONFIG_IS_ENABLED(CONSOLE_RECORD_INIT_F,
> +			  (INITCALL(console_record_init);))
> +	INITCALL_EVT(EVT_FSP_INIT_F);
> +	INITCALL(arch_cpu_init);	/* basic arch cpu dependent setup */
> +	INITCALL(mach_cpu_init);	/* SoC/machine dependent CPU setup */
> +	INITCALL(initf_dm);
> +	CONFIG_IS_ENABLED(BOARD_EARLY_INIT_F, (INITCALL(board_early_init_f);))
>   #if defined(CONFIG_PPC) || defined(CONFIG_SYS_FSL_CLK) || defined(CONFIG_M68K)
>   	/* get CPU and bus clocks according to the environment variable */
> -	get_clocks,		/* get CPU and bus clocks (etc.) */
> +	INITCALL(get_clocks);		/* get CPU and bus clocks (etc.) */
>   #endif
>   #if !defined(CONFIG_M68K) || (defined(CONFIG_M68K) && !defined(CONFIG_MCFTMR))
> -	timer_init,		/* initialize timer */
> +	INITCALL(timer_init);		/* initialize timer */
>   #endif
> -	CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT, (board_postclk_init,))
> -	env_init,		/* initialize environment */
> -	init_baud_rate,		/* initialze baudrate settings */
> -	serial_init,		/* serial communications setup */
> -	console_init_f,		/* stage 1 init of console */
> -	display_options,	/* say that we are here */
> -	display_text_info,	/* show debugging info if required */
> -	checkcpu,
> -	CONFIG_IS_ENABLED(SYSRESET, (print_resetinfo,))
> +	CONFIG_IS_ENABLED(BOARD_POSTCLK_INIT,
> +			  (INITCALL(board_postclk_init);))
> +	INITCALL(env_init);		/* initialize environment */
> +	INITCALL(init_baud_rate);	/* initialze baudrate settings */
> +	INITCALL(serial_init);		/* serial communications setup */
> +	INITCALL(console_init_f);	/* stage 1 init of console */
> +	INITCALL(display_options);	/* say that we are here */
> +	INITCALL(display_text_info);	/* show debugging info if required */
> +	INITCALL(checkcpu);
> +	CONFIG_IS_ENABLED(SYSRESET, (INITCALL(print_resetinfo);))
>   	/* display cpu info (and speed) */
> -	CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (print_cpuinfo,))
> -	CONFIG_IS_ENABLED(DTB_RESELECT, (embedded_dtb_select,))
> -	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (show_board_info,))
> -	INIT_FUNC_WATCHDOG_INIT
> -	INITCALL_EVENT(EVT_MISC_INIT_F),
> -	INIT_FUNC_WATCHDOG_RESET
> -	CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (init_func_i2c,))
> -	announce_dram_init,
> -	dram_init,		/* configure available RAM banks */
> -	CONFIG_IS_ENABLED(POST, (post_init_f,))
> -	INIT_FUNC_WATCHDOG_RESET
> +	CONFIG_IS_ENABLED(DISPLAY_CPUINFO, (INITCALL(print_cpuinfo);))
> +	CONFIG_IS_ENABLED(DTB_RESELECT, (INITCALL(embedded_dtb_select);))
> +	CONFIG_IS_ENABLED(DISPLAY_BOARDINFO, (INITCALL(show_board_info);))
> +	WATCHDOG_INIT();
> +	INITCALL_EVT(EVT_MISC_INIT_F);
> +	WATCHDOG_RESET();
> +	CONFIG_IS_ENABLED(SYS_I2C_LEGACY, (INITCALL(init_func_i2c);))
> +	INITCALL(announce_dram_init);
> +	INITCALL(dram_init);		/* configure available RAM banks */
> +	CONFIG_IS_ENABLED(POST, (INITCALL(post_init_f);))
> +	WATCHDOG_INIT();
>   #if defined(CFG_SYS_DRAM_TEST)
> -	testdram,
> +	INITCALL(testdram);
>   #endif /* CFG_SYS_DRAM_TEST */
> -	INIT_FUNC_WATCHDOG_RESET
> -
> -	CONFIG_IS_ENABLED(POST, (init_post,))
> -	INIT_FUNC_WATCHDOG_RESET
> +	WATCHDOG_RESET();
> +	CONFIG_IS_ENABLED(POST, (INITCALL(init_post);))
> +	WATCHDOG_RESET();
>   	/*
>   	 * Now that we have DRAM mapped and working, we can
>   	 * relocate the code and continue running from DRAM.
> @@ -934,48 +937,48 @@ static const init_fnc_t init_sequence_f[] = {
>   	 *  - monitor code
>   	 *  - board info struct
>   	 */
> -	setup_dest_addr,
> +	INITCALL(setup_dest_addr);
>   #if defined(CONFIG_OF_BOARD_FIXUP) && !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	fix_fdt,
> +	INITCALL(fix_fdt);
>   #endif
>   #ifdef CFG_PRAM
> -	reserve_pram,
> +	INITCALL(reserve_pram);
>   #endif
> -	reserve_round_4k,
> -	setup_relocaddr_from_bloblist,
> -	arch_reserve_mmu,
> -	reserve_video,
> -	reserve_trace,
> -	reserve_uboot,
> -	reserve_malloc,
> -	reserve_board,
> -	reserve_global_data,
> -	reserve_fdt,
> +	INITCALL(reserve_round_4k);
> +	INITCALL(setup_relocaddr_from_bloblist);
> +	INITCALL(arch_reserve_mmu);
> +	INITCALL(reserve_video);
> +	INITCALL(reserve_trace);
> +	INITCALL(reserve_uboot);
> +	INITCALL(reserve_malloc);
> +	INITCALL(reserve_board);
> +	INITCALL(reserve_global_data);
> +	INITCALL(reserve_fdt);
>   #if defined(CONFIG_OF_BOARD_FIXUP) && defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	reloc_fdt,
> -	fix_fdt,
> +	INITCALL(reloc_fdt);
> +	INITCALL(fix_fdt);
>   #endif
> -	reserve_bootstage,
> -	reserve_bloblist,
> -	reserve_arch,
> -	reserve_stacks,
> -	dram_init_banksize,
> -	show_dram_config,
> -	INIT_FUNC_WATCHDOG_RESET
> -	setup_bdinfo,
> -	display_new_sp,
> -	INIT_FUNC_WATCHDOG_RESET
> +	INITCALL(reserve_bootstage);
> +	INITCALL(reserve_bloblist);
> +	INITCALL(reserve_arch);
> +	INITCALL(reserve_stacks);
> +	INITCALL(dram_init_banksize);
> +	INITCALL(show_dram_config);
> +	WATCHDOG_RESET();
> +	INITCALL(setup_bdinfo);
> +	INITCALL(display_new_sp);
> +	WATCHDOG_RESET();
>   #if !defined(CONFIG_OF_BOARD_FIXUP) || !defined(CONFIG_OF_INITIAL_DTB_READONLY)
> -	reloc_fdt,
> +	INITCALL(reloc_fdt);
>   #endif
> -	reloc_bootstage,
> -	reloc_bloblist,
> -	setup_reloc,
> +	INITCALL(reloc_bootstage);
> +	INITCALL(reloc_bloblist);
> +	INITCALL(setup_reloc);
>   #if defined(CONFIG_X86) || defined(CONFIG_ARC)
> -	copy_uboot_to_ram,
> -	do_elf_reloc_fixups,
> +	INITCALL(copy_uboot_to_ram);
> +	INITCALL(do_elf_reloc_fixups);
>   #endif
> -	clear_bss,
> +	INITCALL(clear_bss);
>   	/*
>   	 * Deregister all cyclic functions before relocation, so that
>   	 * gd->cyclic_list does not contain any references to pre-relocation
> @@ -985,12 +988,11 @@ static const init_fnc_t init_sequence_f[] = {
>   	 * This should happen as late as possible so that the window where a
>   	 * watchdog device is not serviced is as small as possible.
>   	 */
> -	cyclic_unregister_all,
> +	INITCALL(cyclic_unregister_all);
>   #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX)
> -	jump_to_copy,
> +	INITCALL(jump_to_copy);
>   #endif
> -	NULL,
> -};
> +}
>   
>   void board_init_f(ulong boot_flags)
>   {
> @@ -1000,8 +1002,7 @@ void board_init_f(ulong boot_flags)
>   	gd->flags &= ~GD_FLG_HAVE_CONSOLE;
>   	gd->boardf = &boardf;
>   
> -	if (initcall_run_list(init_sequence_f))
> -		hang();
> +	initcall_run_f();
>   
>   #if !defined(CONFIG_ARM) && !defined(CONFIG_SANDBOX) && \
>   		!defined(CONFIG_EFI_APP) && !CONFIG_IS_ENABLED(X86_64) && \
> diff --git a/include/initcall.h b/include/initcall.h
> index 62d3bb67f08..9398a3ec7d5 100644
> --- a/include/initcall.h
> +++ b/include/initcall.h
> @@ -8,6 +8,7 @@
>   
>   #include <asm/types.h>
>   #include <event.h>
> +#include <hang.h>
>   
>   _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>   
> @@ -35,4 +36,30 @@ typedef int (*init_fnc_t)(void);
>    */
>   int initcall_run_list(const init_fnc_t init_sequence[]);
>   
> +#define INITCALL(_call) \
> +	do { \
> +		if (_call()) { \
> +			debug("%s(): calling %s() failed\n", __func__, \
> +			      #_call); \
> +			hang(); \
> +		} \
> +	} while (0)
> +
> +#define INITCALL_EVT(_evt) \
> +	do { \
> +		if (event_notify_null(_evt)) { \
> +			debug("%s(): event %d/%s failed\n", __func__, _evt, \
> +			      event_type_name(_evt)) ; \
> +			hang(); \
> +		} \
> +	} while (0)
> +

initcall_run_list() currently prints (printf) whenever an initcall 
fails. It's happened to me a lot already while debugging/bringing up 
boards to have an initcall fail on me and that message wasn't really 
enough to put me on the right track, but at least I had something. Now I 
believe this would just hang without notifying you before. Is my 
understanding correct?

Would it be possible to print an error message (or raise the loglevel 
from debug to error or something like that?) before hang()?

Cheers,
Quentin
