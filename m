Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ACCCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 08:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA3B783FF5;
	Wed,  3 Jun 2026 10:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NU58Vd+9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C165C840ED; Wed,  3 Jun 2026 10:42:28 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF81B83EF9
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 10:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umezCgEpNOmTwxRz9GbyFf5ARRNsjbAD4qc3rGwnnEDjdlLviuopKRaUjRdCnXOH15Bpi/c98K74K4GixSD5SHx1KSrMEBT6hEP5w/hh5qKmGZ7T5IRhxl5qNTmolEo7x2bBL6PeJtx3lfO1mFIXH/S4yDq6oSfaSQd4t6sGNVUf2X+2VevPIQvO9pWm3vh3anyfIhMalkVbSaaqgJpIIMu1gbBOQyjEI4amnvlgdldkQIuPE/fyVIuPCLnOWc4SrrDNOZAzQnm7r+9sJKwFuuSXU504vYAzL+BjaFAflFn3DKymu4CmQanOZTWqjjmocnQglgseN125Fi0M9Xjofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FCf99OLk3OAAjPxII3IEUqpWKIceO3mzlCnSTSFB2KY=;
 b=ByB3J3Ax7fsasXjv3pMTT6MGk0SwsTHQt8MfbdBgxAlLKvQYRAnvw0HKkcWssvgLYERphtbjQEhtcNkmGshF0iWoNw7zDY3RViLTwp/pAOV2z+eajORe/B2xPj0P4pvOMrt0vM89t+vYzJ3SCKkSJzxb7uHws/9Pcvpl7Waksp/eD3jWcnmZ9ci/0XfbtCWibzr3ZF8dz9g2QnTdWPnwOyFMeTzH0II3G9HJmzj37cgELUrux78wWGTuiCKWQrxCd/LweJtzBE4ZmJ66L1suh8Z7j1kpwIoj5L0oyAHsI7kFuPEtBuwrSyTIcpyKfSBn7ehhVsW0tnVPVU2xRxPFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FCf99OLk3OAAjPxII3IEUqpWKIceO3mzlCnSTSFB2KY=;
 b=NU58Vd+9DADSnlQ8NDMRaZYzYk5MtKmLjIkWWvUvy3epNiCn6u/TyCBjb1ksrYGZs0hhRsBwnwzX5mXYV9xlRiV4QrhOOXvIOhp+Nls2QGjpx8Xn4hZT07ez7WLGy5uXANQNZjkiNgOI2U9ZondeI724htv+hJJBDqTDgdRBq14=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS5PPF7856D51FE.namprd12.prod.outlook.com (2603:10b6:f:fc00::654)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Wed, 3 Jun 2026
 08:42:22 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0071.011; Wed, 3 Jun 2026
 08:42:21 +0000
Message-ID: <d3ff1c38-1348-4916-821e-bf2825d94960@amd.com>
Date: Wed, 3 Jun 2026 10:42:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] mtd: rawnand: zynq: Fixes and software ECC support
To: "Miquel Raynal (DAVE.eu)" <miquel.raynal@bootlin.com>,
 u-boot@lists.denx.de, Love Kumar <love.kumar@amd.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Andrea Scian <andrea.scian@dave.eu>, Tom Rini <trini@konsulko.com>
References: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260602-dave-upstream-nand-fixes-v2-0-412965ee38bf@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0110.namprd05.prod.outlook.com
 (2603:10b6:a03:334::25) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS5PPF7856D51FE:EE_
X-MS-Office365-Filtering-Correlation-Id: 06ed344e-3e70-4aa1-e2d0-08dec14c0746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 4k3gtOZdf4e12JzJ3nQmnw+PggIss/3ZHp94rVJbRhnM+FcsnOxjSbDiVIfCtfkmC8E5kQnwrFc4c8UQwJbojBQwZzssX3KkQV64LevwiwmUvbwrNxYR+L3ZOljP9MWP8JC2Tcm9zhVHbJy62PfWj5yS2AxPUerFFyAMrgB4qGwKS0wsKqaU/ibgC5iYdcoBbinuxt8P/GgZNsjN3C6SH1NNEthnkBXRsHzlcgPn9ehwB9Xfk2LV7+g/cbzwS5+o4FKl41P/44EWNiYF7d/+ivgAP3XVUJzJK+0GUy4p/HI7PC7FGFpbBFDsZAHTNR9cd1FJzkVNKoGMCF4kWGx/KLFHMW9hkEicezNUn73IEn88j5H3jeqkvRIxd5wOUBCrssleZPrsIX/18E9twUk7R6ug/dmVFSh8A4R6rsFafm1s5BCuh9p8BsctZPYF9rR203mr4lxhj793t14R5FTdO2lJR0i36UndRH6g99DFrbbjvdV5WCVfjC/1Xt2ehEP0qLus+NnRGlGeEPCg99vvCS8Rkbrr0n4lGDASn4C6FoTc2b2amLRr/4r3wd1F5PFyFxtMMjR5I/73+d/iNk/lh8Ra7PiP560iO3qFrfL28WEudEd7wq/Ug2QFs+KKOet9yL0Rd2473jOOc8f1jLfeMEyaAthtsFj0TKaZbyLMEHQM79rAudDuHqI32Rdt1BddHJE8kRGe8k0hhat9h72RFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTlzY1ZrRHk4clNTRGtwZmZ1RStPQkxIdDdHMFZnaWdlWXUzUFd1NSt3OVZN?=
 =?utf-8?B?SlUxbTQ2dEl0NHc3RzBLTVZYT1BVTlAvSUxqYldud2ZSWEg0SWR5Wk1uS3Fy?=
 =?utf-8?B?UWR2Um4wZi9pNG9CL3RmZ1Vnb2pEQUwwSm8wb0hoYWRTemQrMXRJWGFmM0l5?=
 =?utf-8?B?b2NMOWgvUCtETzMzOGdkbWU3ZWlIYmxtSml2czFRRHRaOEIvZ1FJcXZOSnFl?=
 =?utf-8?B?T1pwWTM5MkFWVVFLSVJzRXFqa05Rem0wQ3V1Q3VWR1lCd3NvUDZacXhPOUhW?=
 =?utf-8?B?blEwYzZTYmtuNFN5T2ZONkIvRzFzRmhtUmdXbC9yYzZsQUVpV2NuT2RLK2N0?=
 =?utf-8?B?bnh5SWZjZ1hiaUJMSEFoTEpuWlkyOElhSjJMeXZ6TWFpWU03S2VIQ2s2aDJh?=
 =?utf-8?B?cDZwYlJPNVJ4VTRKekJmcmpsdVBmTVZEOEVUTGxoU2Y4OWtoM1Fmb3ZqNlJv?=
 =?utf-8?B?NEU1SklxajB4QWtoQnl1S3N6YlRZLzA0NzVnUnhHdnBBTVNMQzR3M3BFakJR?=
 =?utf-8?B?a1JXSDlYN0JsTGNNQTRWR3hjL2I3dmEyd0M2QkZhaE1ZK1hUQUh0TzZMMGk2?=
 =?utf-8?B?MlJHek0vckpnVERPZDQwVnNqVVRYT1RVTVFVWmZDQnBVbDltZ1daWkZ5MW1Q?=
 =?utf-8?B?MlhlU1FYdktuc0xSY1E3LzVHTHJhNlBsUnJwbkdUNzVFYmt2eDhNbXJTWTlr?=
 =?utf-8?B?V2FDTVlmQ0tzRW9UR1RTUzQyQjF1R3JZaDB5YXZrVU4wc1ZxQyswV0c3MFFU?=
 =?utf-8?B?ekI0RFlySFlCZFdDTnNDK09JVE1sbEN1a21ieWMvRkROVk5XMmVzOWRXVzc1?=
 =?utf-8?B?dldaUzZXRHZ2TDJrUWlKazZPakhrYUlFcmlHSGdqdDRSZ2NaTUFtZ3FzWC9w?=
 =?utf-8?B?eGdSQ3d5aHJVMTBZbnlEQVZaSVNJeUZmeGsyNHZCL2tIU1lqRDBMM2xQc01K?=
 =?utf-8?B?eXJ2WUV4dFdHdFUzNUNpakRacktyTFoxeXZWZXd2TFpMQ25FM2tyNnRaVjFU?=
 =?utf-8?B?Z3pLUlc0Y21TZTdVWUJNZW5iSktnaFB6M1V6UnFBMWQ3NFRVNVNLaXQ4Wm5p?=
 =?utf-8?B?dk5iaVRteWZVbE1BMGhmRndIK3Ntb01SazZqdGVINkxYTEIxa0tEekN1TzMw?=
 =?utf-8?B?QUIzQm5nQ1dPUFd6blBxUlhRak9iSUdDLzNuclBCcElOYjRmeTVpS3A0eEpZ?=
 =?utf-8?B?WXRPSkppYlZ0aWxORldvRlR4dUxySExTT1MrTFY0d0JzMWxRdjlkVVVQM0VI?=
 =?utf-8?B?MjNXeEhwNXp6L1F5N1RkYzkwako0ZUczYUd5ZFZ0aHJ0Tm9WRmlRK3crcG1J?=
 =?utf-8?B?a0ZBUnpNRVNGSGFPNmRoSWJ2RkNHVTFzOHRZSmp4NCtpc1hlMUlQVlQvNE0w?=
 =?utf-8?B?Yk5hekladi9sSEJtcE5GaC9LM1Jhb056NFY2K1cvbVN0cGFtbjVZODc5NjdH?=
 =?utf-8?B?SGVuOG1ualprcGJvQTlHVjdMaVhZOXFWbHRyOHVoRW5mVWJnZENSVGRMMVVz?=
 =?utf-8?B?WlJpb0JRTm5EdU56WWk4MTNnQkdNd0tyOStKRHovUDZqRjRjR00xZ3k5cVM2?=
 =?utf-8?B?RFZqTWVIMTRmNDhPRCs0bVlOWE4zclQrNlo5dDlBaTJoQjFEUjg0Q2xQQ29j?=
 =?utf-8?B?NFhaV256TW1HaUFiLzM0elNBdm8xQ1J5OEN0aHZybEJha1VhMGYwV1JSRzI2?=
 =?utf-8?B?Nk5Bd1oyZHo1QkNUZ0NFTnhtZzdLVWNRSGZjeUEwTkhJUFhRaVRYNEY0ekcy?=
 =?utf-8?B?bmo4OEp1Wno0anVJVW1PSlRFSjE3RWhvWEl5TllYdFNJNVNGdU9PdStDY0k1?=
 =?utf-8?B?a3ZGSTZJM2RxSnd4S0ZzV1RjRFEwUTBzK2NJdEdLQmQ5MitFQnpZcTZXdVo5?=
 =?utf-8?B?aFVTRGlFZDR6WVdYNGxlaEJVQzh3Ykk0cVRhbW5ULzBWSDV2cTBKcnZtTFZZ?=
 =?utf-8?B?Vk92SURtQ0ZxTE4wMEpTU3haUHRBNm1TQlFWZXFqbnNNRVlPSzlUTWdxZGdP?=
 =?utf-8?B?ejhYbUNTVTEzSkxwTGNiSkdnZHZsSEpVRXg2S2JjblJlM1BXZlFYNnhhemZP?=
 =?utf-8?B?ZGg0OUR3Z1NvbmdJNnRYMnM0Rk9KTk1Ea3gvaEVPbVgrZWQ1NWt1TXNuSEhh?=
 =?utf-8?B?RGpsOW9iUG9WbkdFSmUwRkJINXpzSTF3c05jTGdOcjNBYzZWMnZXMWtxajJJ?=
 =?utf-8?B?Q0U2TjRuV2pDS1F5Zmc1eDNIclQ2eEE0N2pYTGl5OVBMaGQvcThuQzMrOFMx?=
 =?utf-8?B?ZzBXQjVzRDdZNVhLWDgyV1N3aHU3NFJGdmFjTU5nRG91NHVGQUlCdkE0K0h4?=
 =?utf-8?B?YWZYK09pT09jVjErUVRlSEp6QXdLc2YzZFhKMGI1NW14dVp6SlJ5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06ed344e-3e70-4aa1-e2d0-08dec14c0746
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 08:42:21.8114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +a86Nr8dXSXT1pKmfJcx7sO685v5mHXNTf+WTuIXljOIw6Rz89NLUc6aG+5TFSFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7856D51FE
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

Hi Love,

On 6/2/26 12:28, Miquel Raynal (DAVE.eu) wrote:
> This driver is deeply broken in many ways. I've tried to clean it up by:
> - flagging the most hideous parts (where Micron on-die ECC support is
>    hardcoded)
> - enabling DT support, eg. for reading the ECC configuration
> - fixing software ECC support
> - aligning the software ECC OOB layout to the rest of the world and
>    allow a working interoperability in Linux.
> 
> Signed-off-by: Miquel Raynal (DAVE.eu) <miquel.raynal@bootlin.com>
> ---
> Changes in v2:
> - Fix the sponsor: s/DAVE/DAVE.eu/, no other change.
> - Link to v1: https://lore.kernel.org/r/20260529-dave-upstream-nand-fixes-v1-0-e5bbddb10676@bootlin.com
> 
> ---
> Miquel Raynal (DAVE.eu) (5):
>        mtd: rawnand: zynq: Align the layout structures with the driver namespace
>        mtd: rawnand: zynq: Add comments about very bad practices
>        mtd: rawnand: zynq: Make sure an of node is attached
>        mtd: rawnand: zynq: Do not fail the probe for no reason
>        mtd: rawnand: zynq: Fix Software ECC engine support
> 
>   drivers/mtd/nand/raw/zynq_nand.c | 115 ++++++++++-----------------------------
>   1 file changed, 28 insertions(+), 87 deletions(-)
> ---
> base-commit: 744cf5d4e398c5f657e5c3eeb44d00fa5175dc85
> change-id: 20260522-dave-upstream-nand-fixes-60a5336517a2
> 
> Best regards,

can you please test this and provide results?

Thanks,
Michal
