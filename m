Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B9FCFC283
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:11:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 823588393F;
	Fri, 21 Nov 2025 16:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="L7I/ElPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC65883966; Fri, 21 Nov 2025 16:11:02 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67E8B8391B
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:10:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v3/k3KNgdAVuQn8muOKWpEBUjsjrNMTTs7RqAYhKux5fdKGyjPtyea81b8mwtbEfkHzmvnMK9kh2zgjLVbdEij79IyEqVZ8R1TWgv3yTBoO4fn5cYh9xWbfhK8jW/6gzLX4KD/GvDd7NpgARGyUsh56+5nzxzAPRrRQHZYnWytVbGokX3ARcZRzRpBja8DWqbvVGBEpHOrcyt3r2ib7xxVd6Gr2u+o92vdDYfK9X/b3NZ0S76fojD+0VLNliJMuWUKEKQWKzhIMzaB2LvfGDcV7COqiqtfalD5N6Bpu9G70jgqRoVr42ZzDeMTdyZhhrBBcpJOvc16lLE+71gcgRyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCTuPlwgVU8XY4Hcxjx2klQGEebQkOHmOZCRIX/Z6eY=;
 b=nkbPoU5ZlcXEKPCB0dEfBMwgnfNgs1OF61sNRdwkAeAMFYHoFULUzOkgK/9mU1GFwcOl2xeRbqLNd77qAKfNitfb1gK3Aunut5oZb0z3lptG7MWx/eQt1rMg0U861AXvi5y8Gsf5x+VaT6PhE0NL1ksaNzhCwFEAzSd+OxHVHmeqrn3qPYwjs3YNhAXgTcL/ooeUj9EuBu1bMFOOMOLkBPlyC3tyH2zyHHgBKYSFkWNnxQ8AMYGsrxSXofCnQwbaneo7+f/lxh0cFP6Tp6XwGmHm3mhtrpWyhEPhjLb+qrK6TfC+qkhtVK8pbA56zaH2i1G3LgZrnB86OW8IcxVUZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCTuPlwgVU8XY4Hcxjx2klQGEebQkOHmOZCRIX/Z6eY=;
 b=L7I/ElPUhQtF+ei3Sz3IIUW9kfhwSthrKC09HD8AJi5ns6YP7cLdfEEKnbr46NBdAFJCauzlBq6TIK5GdhF9lP0FEfXqbRXQA/nnQ4iMLc/J8rMD3Eevdo4JkUuGAONOvlab8sRxlE1KWvH3zrO3BihPznqWE++2VsJMfsAmE3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10354.eurprd04.prod.outlook.com (2603:10a6:150:1e4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 15:10:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 15:10:56 +0000
Message-ID: <0cb997c4-14b7-4737-a0ad-6ffef33c7159@cherry.de>
Date: Fri, 21 Nov 2025 16:10:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 2/3] CI: use mirror for gnulib dependency of grub
From: Quentin Schulz <quentin.schulz@cherry.de>
To: Tom Rini <trini@konsulko.com>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Raymond Mao <raymond.mao@linaro.org>
References: <20251121-gnu-mirror-v1-0-548e6cd2665e@cherry.de>
 <20251121-gnu-mirror-v1-2-548e6cd2665e@cherry.de>
 <20251121142458.GS2125796@bill-the-cat>
 <ffba9bbf-f03d-4006-b2b1-259b94181370@cherry.de>
Content-Language: en-US
In-Reply-To: <ffba9bbf-f03d-4006-b2b1-259b94181370@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::43) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10354:EE_
X-MS-Office365-Filtering-Correlation-Id: aeede5a3-c6cb-4b23-d0b6-08de29102b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|376014|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OFZmTDBQTWxldmJ1RFFUZkhuSzFrUGc4cnQ0eU5QV2ZOWGRFOVhCYU56UEFV?=
 =?utf-8?B?OHVmVFdSK292eFRaOUVIVlRjSVF2K2lzelVtbE9Yb0c2SnFkcXB2SFU2cEda?=
 =?utf-8?B?eng4ZW55eW13WEQ1dGJPTXVPRUFIL3JYOEZrQ091MGF0ZjROdExQZHJ2MFlz?=
 =?utf-8?B?cE1kNnlCRWUrTm5pOXdNcFpPcytpWlhka0dHRkluYjgxbGpSSTI3S3U1MHNk?=
 =?utf-8?B?cGUxSEMvT2o1QW1XcjQyZllmd1JxeUlDWUxRS3lUZzNJSVZBb0lPK05vdlR6?=
 =?utf-8?B?MFR3UkJXYjg3cXMrK3JKL1FNV2EwaS9lOHk4bjVSbFdubE0veG5jQWN4NHoz?=
 =?utf-8?B?RGJscDFQdW45TWR0SkxXcllHVnlPUVNSenlDSEJBMWVud1dsY08zOS9sbFQw?=
 =?utf-8?B?a0VacDlKTE94Qld4ZlQvcFdHUjkzRnhnYzJVbUh0T2tzeWtKS0k1Ym82cHBD?=
 =?utf-8?B?RVJGUzRNSVJVU1VuRWNaWWdHU0NsVnBHLy85NzRTOXNLblBlMVFFVFM3YzlM?=
 =?utf-8?B?NDBiRGFheHAvOGpYMFI2TEZNVExuZ1c2U0thRVdLQlExSmZBTFlWSHcwZitV?=
 =?utf-8?B?NXBHUVhGa3BVZ1ZZa2xEaTQ5SFpCakdVV2hRZHNtYUNCQlJSVm02Y09sS0RV?=
 =?utf-8?B?TEcvSXhvSkYxcklYaVNuTWdaSlJFcVRjSGh3R0xvYmVkR0p6SGpYUFM2dk1K?=
 =?utf-8?B?OU5NWEQxYlhzVzdmMm4wTDNmOWk0Z2U5L2QwT1VhT1ZaTXAyeTFqQytiOEpu?=
 =?utf-8?B?WmZhYmdqUlhCQjNvU21wR1F5VTFJQ0tyajFVT2ZFeHgrOTRWZnplOEtSaGpT?=
 =?utf-8?B?V2xUQmVsZzdSZVUrWnVwRk9OSWhINGUwWE5iSS9GZEYwL1JJaDYyZDVPeWto?=
 =?utf-8?B?K0xEM3ZvbThpU1JGeUt2cmo1NUdFYWZZWlhCM1FiZnQ0enp5WFMrMVBrUFJG?=
 =?utf-8?B?bldpNzltUmphVjBnN0RNeW5VWUdZWDR3cW5jRlVhQ0ZTOXQ2MEsvTGRxRDN2?=
 =?utf-8?B?cUxIRDA0eC83RnZBV2NLUm4rRnV1UHJDSzVtZ2xzcklub3hUY2N4NHE0bVlY?=
 =?utf-8?B?THR2MENpK1lDTnFvZXdEVEN3MGIzUnFuT2MvM0FQTHZGVEY2aVBZK3MrU0xQ?=
 =?utf-8?B?K1gyQVUvOUxpZThUdDFNODlmNkNjMlBGRi9MQUVsUkY0TnJHcERhdWVWRmda?=
 =?utf-8?B?dU10MG1XTGU2bmY2aTFib2VBVm8ySktPMEVLR2NTbEJzbXpRekNvNDNlbnN1?=
 =?utf-8?B?UTg3bVFjc2FtOWlhcVBvbG43ZU1UdTI2SUNNMTlrRzZHLzU1OTlqRFZQV0ZF?=
 =?utf-8?B?RkU5enhQdFlzdzdIelRldncxUy9kM1gwdytZUFJBYW8yTWVyMERYMVBqNStj?=
 =?utf-8?B?Zk11am14aC9jWG1YUlVtN2ZuMm5NVnYvcEU1Y0Z4OStPcFhhKzVvdzJkcHJV?=
 =?utf-8?B?Y3YyYmZqMGZJSmV6K3NoL0FKWHN2ZkdHYUx2cTRmL0tVMG9RWjJoNU05c3Nt?=
 =?utf-8?B?Yy91N3pVbFRmRit5S1lnOGVNdjBtV0QyNW4rUUJWSmI5a2c4a0h2bUMySjVq?=
 =?utf-8?B?RkFJQXdhOFF2MGYyTDFod2Nqblh3b0VwcHNWTHo4ZVk3MUw2cVk3cExsanl6?=
 =?utf-8?B?NDNQTmkxWU9wZVJrWjF6bCtJdUtQOFNoNXFrYlQ2UjRRY0Ztb3dhTzlaaVR3?=
 =?utf-8?B?eU1XVG5CNEQvUmlYZDY5UDZTVjVOOHo2L3VqdDM3aHFSai9nSGhZV0h1Y2VL?=
 =?utf-8?B?VTR5YnlwY0xlbHZTdXB0V3VoNnRkUzBZVUIxbXUrZ3BEZXlHNStFSVF5ZitO?=
 =?utf-8?B?bWFpb3lQcWxBYjhhZ09YeW9vMExsTW9vOXhIdTBSTlZIZnZsTHlTeG9RdDBH?=
 =?utf-8?B?SytLeUFPZk5RMkhjTk5NZFozaEt1d2NyNjJxUnZXcFVyMGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0MzZk8xdTYxN0x6U1dVMExEMFg0eWZhRjdkUjl2VjZLK05DSWlsMXc1eWgr?=
 =?utf-8?B?RzhzTWJjMFpNNi9oSi9TbFZ0T01Ja2JrREgrdlI5VGdPWlliQWV4Z3o4MHpw?=
 =?utf-8?B?cU96UkdReTZuMHVuZGgxR3l6NU91WGUyWkdWSEFKdFU2SlF5ejVNMUtIWlE2?=
 =?utf-8?B?Y2dWSHRSTTBmYVJnWmRreVV2UHN6R1hpVkV0Ry8vRC84bWF5SzQ4aVAvbHZO?=
 =?utf-8?B?OWN2TVFyTW9Bb2JvNnhjbU5NSlR3R0dDeEFVdkIwQkZYVjBDcVg5cGtDaHBT?=
 =?utf-8?B?ZGlNNm9ONXpSajVjSWU1LzhqV2dZUFhCOEl1MUUvNzdHMXJHaU9FODFVN2da?=
 =?utf-8?B?YjEySkQ2V3pYU2RDcHg4OVpmRld2T2pYN3NXbDloc3RHUWR0UExSK3E5eCtx?=
 =?utf-8?B?Z3k1Z1FiVjRnMnFCVkQzQStJMzJVSnh2aERzNEQvUWdXUVRJN3kwY1J3MXkw?=
 =?utf-8?B?UUFZcks4TW0rUzNhM0cvZGNWWUdsTlQ5Q0FPRm1kYkZCOVRjU2dLVEpqOFZH?=
 =?utf-8?B?U0g3cTNyVFpQZEliblRPcVNvSHNlL3RMaTZRRjBEYmZaWU5FbE5SaTk1dXlW?=
 =?utf-8?B?NWpZZVd4dUFjWmpzR3NMWFpGdEh1T0podngxYU5pQmFsQWFsMGNxMHM2MVli?=
 =?utf-8?B?UnI0SDZzNWdpclBGTzV6dCtFM3BubUpzVFg3NmxnL1Rkc2psTUJDb1RYTVFL?=
 =?utf-8?B?dnl0V2NxcEN2NlZ6ckF0b3R6V3U1bHRJWTU3cXNXK0RNZW11bklaenJXWVZU?=
 =?utf-8?B?ZjBKTlg3VG55SzZtTmEvYUpWMDBiMXBVcFQwdUJkTGhKMC9PcjdidC9Kelk2?=
 =?utf-8?B?WXBjK0Q5NkowSSsxNG40eFg5QXVOZHh4N291L05zb09ZOEJFdGZJcm8xZjk4?=
 =?utf-8?B?YUxHSXpSUzY1eHYxdFdsWVNnOEVUYUxuWTRtNVFOQXBGWjRGQ2VHOGp4NS9i?=
 =?utf-8?B?WUp1Ky9aR2NxeVRnblBEd1ZIdjRWdjZ5ZG4rRmo4UUgyZlNhUGUxVXJBcWdB?=
 =?utf-8?B?Q1dNdWF2dThxQllZNFBCK25FeUtWbHlQUW1QOXE4Ykp1R1N5VXN2RUNMWEd0?=
 =?utf-8?B?a3h3OHZIazltdzE5OEt0anB6Ni9TaE1NZXg4RytjRVF2NlArS0hvT1dpNEhM?=
 =?utf-8?B?RmtLUHRXQXpmQyt5bHdmQkQvK3NzVk12NW9FZzN6NEZQUjRJU1JCWTJKOHg5?=
 =?utf-8?B?czRaSjRvM1U5MytpSEs0aVZQUU41emRVS29WWnNpdDEyOWF5ajNQTG5pK2FN?=
 =?utf-8?B?ZHpINGdaNTQ5b21aUVF0QlVIRGU3R1FZb3VsSjU5UWUyRm8zamVBQmxSZnJy?=
 =?utf-8?B?bTIvN0wvd0F2MVlFSjFQcjdXTkxZZEw1UXlQZkFoYkJZWUNBa3RzcmV3YXhN?=
 =?utf-8?B?bk1GdzJoY3hES0szKy9WVEVnU0JJeE1EV05scHlXOU5mVUtqd2lMWUptL3Fj?=
 =?utf-8?B?RXNDUysvQVZzVHVxMlZ2MkVnV2lqT3k4ZmZ4V1BMUUZ6dFIvOTFMbVJrQ29B?=
 =?utf-8?B?ZUJjSTM2aWlMWTRRQm1tMzJGeWFaQ0N1WWhwTTlEbmFOODEwTU9WREcwRXZK?=
 =?utf-8?B?Tm9BVE5zZUFPWmNUbUIwVjl1MWFNSDR1NlVOcWNzNE81UUtJMkM5Q2dIbFZ5?=
 =?utf-8?B?OWd2ZDVPcUFvUnBYWUlIM21FUzFjQnU2VlR6QXhQbE5XNmUwVU9XTkd3ZGdX?=
 =?utf-8?B?MjJBRWhaNUl1d3QrRlhoRERGNzdwc2VDaVFKWGkzb0U4MzVDQ2t3S1IySlFM?=
 =?utf-8?B?dzhYM3FmWjk0NnE3cnBuczJtdGVQbDN5eUY0dTRUQ016cXRPRjRoR3crU3No?=
 =?utf-8?B?bVZXZDZkSFN0TG9DcHpibHNwVWp5VkRpTjZDc1RIT2xHU3Q0b1EwSFAxam1x?=
 =?utf-8?B?UmtDQ0tPUFpPaTlhVjZ4azdkcHk1dWlnT2owVzlXaE9UdE1iY0Z1RXF0dHQy?=
 =?utf-8?B?SXJJZ0YyWHBKOGNmTGt6eUdMSVFKbkdvY1AzZnJUQXhDTGRuR1JkZm50MTJJ?=
 =?utf-8?B?TjBMbkRDb0FQWCtJWW1DV1FLNWJpNVBXTnZ0M1FQTlo5RXVDYkphYUVwenpT?=
 =?utf-8?B?Q2hycGIzelp1eVRPRWtDdmM5bmpRWllHd1hkbG5aRWtteHhoMWhwbDNkVTFN?=
 =?utf-8?B?cjAwMlpVT0UzM2RrclorYVJsSFkyVEx6a21JeVlVMnpLV0hid0hSYVd0RGhL?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: aeede5a3-c6cb-4b23-d0b6-08de29102b93
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 15:10:56.1943 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GOE8c4YX+H1CepDXaY6B5HuWFfqwMGkdR5gkEPq6WunXRhqwWxEFM8/699VEC+S5HiymKneOYQOBdCj7r+Mp6yEzEyQLOtvyFNQnSgOf8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10354
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

On 11/21/25 4:00 PM, Quentin Schulz wrote:
> Hi Tom,
> 
> On 11/21/25 3:24 PM, Tom Rini wrote:
>> On Fri, Nov 21, 2025 at 02:22:15PM +0100, Quentin Schulz wrote:
>>
>>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>>
>>> grub bootstrap script downloads gnulib from a non-mirror URL and thus is
>>> unreliable.
>>>
>>> Instead, manually clone the gnulib repo from a mirror URL and pass that
>>> repo to the bootstrap script via --gnulib-srcdir.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>>> ---
>>>   tools/docker/Dockerfile | 7 ++++---
>>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
>>> index 34713c5e8b2..85274c303c8 100644
>>> --- a/tools/docker/Dockerfile
>>> +++ b/tools/docker/Dockerfile
>>> @@ -148,12 +148,13 @@ RUN --mount=type=cache,target=/var/cache/ 
>>> apt,sharing=locked \
>>>       zip
>>>   # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
>>> -RUN git clone https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fhttps.git.savannah.gnu.org%2Fgit%2Fgrub.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6268e55bdc1c4b33951208de290eb8d7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638993340378906741%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=RmWBLYSxmADeqbU71Ayjs7BH%2B%2BhBpxU8SBU7bWJ%2BCDA%3D&reserved=0 /tmp/grub && \
>>> +RUN git clone https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fhttps.git.savannah.gnu.org%2Fgit%2Fgnulib.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6268e55bdc1c4b33951208de290eb8d7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638993340378938856%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=Dn8RKyWZ%2F5HUQyLZcg08fCK34pPgEXYJ0FckZm%2BId%2B4%3D&reserved=0 /tmp/gnulib && \
>>> +    git clone https://eur02.safelinks.protection.outlook.com/? 
>>> url=https%3A%2F%2Fhttps.git.savannah.gnu.org%2Fgit%2Fgrub.git&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6268e55bdc1c4b33951208de290eb8d7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638993340378959547%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=x81uTYbcXZ8xKuPeR87wXKFDjBzFggMxGpmid8uTw1Y%3D&reserved=0 /tmp/grub && \
>>
>> Right now, the next branch is in a funny spot. Post -rc2 I applied to
>> master some changes to make CI more reliable which also meant that right
>> here we do git clone --depth=1 -b TAG. And doing --depth=1 -b TAG is
>> something we should be doing here for gnulib as well. Since -rc3 is this
> 
> No, I'm not sure this is something we can do.
> 
> AFAICT (haven't dug too much), grub will checkout a specific commit of 
> gnulib, and that isn't supported by git clone, c.f. https:// 
> eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Felixir.bootlin.com%2Fgrub%2Fgrub-2.12%2Fsource%2Fbootstrap.conf%23L19&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6268e55bdc1c4b33951208de290eb8d7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638993340378977923%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=jEjaC%2FTri23TTjwrLCDcVfocG%2F6qEtGgftu9vzBt6Dw%3D&reserved=0
> 
> This commit sadly isn't a tagged commit in gnulib (there aren't too many 
> tags in this repo...).
> 
> However, I think I took the hammer approach to this, I believe setting 
> GNULIB_URL variable to the mirror URL might be enough.
> 
> grub bootstrap script does something to avoid downloading the whole 
> thing, c.f. https://eur02.safelinks.protection.outlook.com/? 
> url=https%3A%2F%2Felixir.bootlin.com%2Fgrub%2Fgrub-2.12%2Fsource%2Fbootstrap%23L769&data=05%7C02%7Cquentin.schulz%40cherry.de%7C6268e55bdc1c4b33951208de290eb8d7%7C5e0e1b5221b54e7b83bb514ec460677e%7C0%7C0%7C638993340378993930%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=kikGeVnXtlyPHiSfeula9p7yEMKentnrHCokBvYa7JM%3D&reserved=0
> 
> I'll try something out and send a v2 if that works.
> 

With

"""
diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
index 6c05ff6aa4f..c080af88420 100644
--- a/tools/docker/Dockerfile
+++ b/tools/docker/Dockerfile
@@ -149,13 +149,12 @@ RUN 
--mount=type=cache,target=/var/cache/apt,sharing=locked \
  	zip

  # Build GRUB UEFI targets for ARM & RISC-V, 32-bit and 64-bit
-RUN git clone https://https.git.savannah.gnu.org/git/gnulib.git 
/tmp/gnulib && \
-	git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub && \
+RUN git clone https://https.git.savannah.gnu.org/git/grub.git /tmp/grub 
&& \
  	cd /tmp/grub && \
  	git checkout grub-2.12 && \
  	git config --global user.name "GitLab CI Runner" && \
  	git config --global user.email trini@konsulko.com && \
-	./bootstrap --gnulib-srcdir=/tmp/gnulib && \
+	GNULIB_URL=https://https.git.savannah.gnu.org/git/gnulib.git 
./bootstrap && \
  	mkdir -p /opt/grub && \
  	./configure --target=aarch64 --with-platform=efi \
  	CC=gcc \
@@ -220,7 +219,7 @@ RUN git clone 
https://https.git.savannah.gnu.org/git/gnulib.git /tmp/gnulib && \
  	make -j$(nproc) && \
  	./grub-mkimage -O x86_64-efi -o /opt/grub/grub_x64.efi --prefix= -d \
  	grub-core normal echo lsefimmap lsefi lsefisystab efinet tftp minicmd 
&& \
-	rm -rf /tmp/grub /tmp/gnulib
+	rm -rf /tmp/grub

  RUN git clone https://gitlab.com/qemu-project/qemu.git /tmp/qemu && \
  	cd /tmp/qemu && \
"""


I get

"""
./bootstrap: getting gnulib files...
hint: Using 'master' as the name for the initial branch. This default 
branch name
hint: is subject to change. To configure the initial branch name to use 
in all
hint: of your new repositories, which will suppress this warning, call:
hint:
hint: 	git config --global init.defaultBranch <name>
hint:
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this 
command:
hint:
hint: 	git branch -m <name>
Initialized empty Git repository in /tmp/grub/gnulib/.git/
 From https://https.git.savannah.gnu.org/git/gnulib
  * branch                9f48fb992a3d7e96610c4ce8be969cff2d61a01b -> 
FETCH_HEAD
HEAD is now at 9f48fb992 filevercmp: fix several unexpected results
Note: switching to '9f48fb992a3d7e96610c4ce8be969cff2d61a01b'.

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by switching back to a branch.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -c with the switch command. Example:

   git switch -c <new-branch-name>

Or undo this operation with:

   git switch -

Turn off this advice by setting config variable advice.detachedHead to false

HEAD is now at 9f48fb992 filevercmp: fix several unexpected results
"""

It was slow but it worked. Will go with that for the v2 to send Monday. 
Ping me if I forget :)

Thanks!
Quentin
