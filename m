Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D19A7C02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 15:43:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D40280805;
	Wed, 22 Jan 2025 16:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="oRGLgmkQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41ACD80824; Wed, 22 Jan 2025 16:43:09 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9DDC807EC
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 16:43:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIiQyxlc0WeFBUekMKiVJFcTvfpiOtqOHztstrPNWMdYUsvTX1+snU4c6GI4TzrFEaDbcaulU3n+1QC9Vqi5KfAb0wXpJYHEP+W5nTS+gABsAwKv1zwpPXBNAHTqjFXCsucn8sS3svbMI4W/SdTvYpIptZRuHt7huLvi8v50mWqYD6hKUCbY7ti7wx7qe1415rc4+spsDpcM8S2MmEIipaQQUGjsvWP4eJCxuvYyYo14iGirfKEhSVAips6EHKd/4wuAEclQ0JR+2+xnjeM2s3AvYZBDjvWesDg2Bkx1MU6Tq+bVuFwMan2l3f44kfOMEW4oQmvi1zj8nOcYb6rkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FO+Zl8g82tU7scvwAZ9uJDu/WYBLSmsiwZwA5hjIAZM=;
 b=TMAJmxmDiaiPQxAKXFMKRd345eAeiRTIwCpE6YpFPGMFTtaF7R5kD6qo0pndnvCE6HY3A31XrH39xby8aLPSToPSVpa1aZRw0OTISlcTQQsSm5UPXEbQqUUM20QU2PGw1YmDy9qU5VuWR+U6iIHyRwMKIpp09DpBfus+QszsWYb48fLACFnU+SqWfXb3/H7/KfRrDMW1040+r/lxnoSnWxfnz8+ODioDAkaemsVf3+EaPIxryLwsV/z5hfoNc0RMFoqJ8jV3tAB8Mq1+t2VM2TnNxL0O0hhsUE2dLgjR1TA8e+aoOlX4GGhAEzXUT5UspkZMYed8PpChCRIa2Uj4PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FO+Zl8g82tU7scvwAZ9uJDu/WYBLSmsiwZwA5hjIAZM=;
 b=oRGLgmkQUSkGY57OaNd/ClLuCrKucmh1sEQ0YTGcSd3krW3JdyfLGHSWHMTo0uy3uABFGRN7Rmq2592oj/HOOnyqW2TSNXS8STYC6/ja47SLhcqnXyMb7Sqm/tEc1mLsUAUqMmVWROEhl8idEdVJ4zlVr3Dsm65eaEjCwkjX8k8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10461.eurprd04.prod.outlook.com (2603:10a6:800:216::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 15:43:03 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8356.020; Wed, 22 Jan 2025
 15:43:03 +0000
Message-ID: <ec967669-a715-4f16-854a-958607df13b8@cherry.de>
Date: Wed, 22 Jan 2025 16:43:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] image: apply FDTOs on FDT image node without a load
 property
To: Marek Vasut <marex@denx.de>, Quentin Schulz <foss+uboot@0leil.net>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <20250122-extlinux-relocate-dtb-when-dtbo-v3-1-46bef4eac720@cherry.de>
 <ee42f531-0084-467e-86e5-3c16a8c90cb4@cherry.de>
 <d973c75a-5b54-42aa-b68f-dcf45f8b3144@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <d973c75a-5b54-42aa-b68f-dcf45f8b3144@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0158.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::16) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10461:EE_
X-MS-Office365-Filtering-Correlation-Id: b8403898-7b58-4b92-3160-08dd3afb752a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QlhSL051UUkxV0g0Tmthc2pzbHFWVFVFSlZIc0RnK0xkYTlXUDArZlVCNVF2?=
 =?utf-8?B?OCtWN3VITkpHaWNWU29oWlRFSUtMN1V1eXVwWWQxZkU2RXN5RkJXWXBHRURE?=
 =?utf-8?B?czhOUUM0NVBmUlVkTllEczRBaXVzdjhSdVI0VnFMZkd4ay9RblArem4yUXJT?=
 =?utf-8?B?OHJaZkk0bTQyU1UwOTJ6UFhzeU1GdWhydnlmejVWMUMrWm9Rbm1tQkVOMEVr?=
 =?utf-8?B?c1pET1hwb2orZXp6MzFpc1EvYlF0cyttUFBGY2Q2VzBobXI2V2gydkxjUHNJ?=
 =?utf-8?B?dzUyeVVENzdQT3hPRzJuVElYTEZ5ZlIzdnFGdSt3Rk5GcVBDUURwbmprUW9M?=
 =?utf-8?B?dDZvWUMzbm1TcklDczF2aFVGTFVsa3JYUEUyWGM5anRSSEgwY3NxNlcvQU1B?=
 =?utf-8?B?THJ1SVZhL3cwVHJPeXVSaTRIK1gwZlhVSGU0b3ZWbko0a0RCTGlOZzA3azV6?=
 =?utf-8?B?Mnk1MFRWM0xhb0JaTk14QVBBUEJoUXlsakRLVnAxWUFwalBHc2NabHl5aUNK?=
 =?utf-8?B?cEF5emtKZlZUbXhoTVhSVW9XOUpOS0ZrRUgyV3luSEtvS0l4WHVnYkJybTNB?=
 =?utf-8?B?QWdlVnpIcjhoNFFoSDhmdld5WWtjaXRHNXQvSnl5eEhxdVQrSjFxd1ZiMVF4?=
 =?utf-8?B?aFVVaXJreUs1aWtrU3hmRUVHbWkvUHdGQkxneldsUGh0NHdzbDlLT0VXOWJt?=
 =?utf-8?B?aFpRSys3UjlUclBBcElSaGtjRmtQSjhLUkV3NnBDSjRCLzZqb2JQZmdkblNa?=
 =?utf-8?B?TFJIR1JSWmdEeGo1blp2NEFkZmxPa01xWFRDYm5EZ1lueXovWVJRZVZ1R29j?=
 =?utf-8?B?QTROYS9pKzVlNjE4U2FvVStuVVJveS9LRi85YUpqYWdqVWtXclZ6am9qQy9p?=
 =?utf-8?B?T0UyWUFWRERzbUs0TUVhLy81TzloRzBhSGw0Zm0yZDNqdXNMQU5kZkdXRWI0?=
 =?utf-8?B?T0xnVG5DUktwNk1sNnQ5Z1d4dHdNOGJLTUMwNDNKV2JzeE1wZjhkWGQ3VnQ4?=
 =?utf-8?B?R1NLdkYrVU9HQ0IvWlkxRDYwQStVR2xWbTVaSkVOcDRmNTFnV2xaRWw1VmYy?=
 =?utf-8?B?UCs1dzhvclZ0R1VZR29LSDJMclJ6ZTczNXkzelE5ZkxLdkVSSTRsblJtZWtK?=
 =?utf-8?B?YlBRRHA3UE8zMjdTR1dkUnhvR09pY2NJY1B4RzUzNTZpNm1KMEY2NEZHL0Ux?=
 =?utf-8?B?alRPWjNxT2pUVDRZYzRhM0tQRUY1cUh2TXNnQVlhVnFONVoxZmkrQ3BOMm10?=
 =?utf-8?B?SHFRNFVsZVczdmtBS3NoN0xXR1dqZktiL3lJV2h5WWtYVFFyZ05RL3hFdHNa?=
 =?utf-8?B?REtldFJSR0hzZHFKbFkwOVRuVTZIUFhBZE9Yd0YwTldKZWxxeFhjcEprYUF0?=
 =?utf-8?B?REhCL3NvU2ZZckx3SDlBTlRUZDE0STRmWWx6d2FpK1JWd1pCMVo5MWdOZzVR?=
 =?utf-8?B?Smt3bStNc05BSzlMczV6d0R2QkpkY2hXQW9sdEVsNFFrTTU0Vk1TV2VjN1Qz?=
 =?utf-8?B?eVNxazJPZWJzWkpXakltRDNiYlZ6Y0RWSkJXL1psZ25RK21xWVVHdzJVb1dE?=
 =?utf-8?B?YlAvOWlrS2ZOTjM5WnJDOEtFWWJpOXROY0h0clVWV0RkVkhzT2Nna0dPd2pX?=
 =?utf-8?B?SmFSNFhJKzllTC9zYTBvWnlpdUpGK1FOaDk5NThrVGhkTGRSMDM5bEVBSS9W?=
 =?utf-8?B?eUZ3MytXVTQ0ZWZHYXh4dlhtMHJ3SlNGc3BIQjg0cWgrK21ZUDU5Q010Z2Qv?=
 =?utf-8?B?MzBDTW9va0JrbDNCL01lc2N5VlV1SUZJSGQvbm45b2g2WUFpMFJrclkzOGZv?=
 =?utf-8?B?TTBKRmhPNGZwR3lXZTluMitFb3djbDBXUWlmN3ZyeW1yUjB0UnJmeGZZRDFH?=
 =?utf-8?Q?ZjNp7QtRx2/ii?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1dzSnIxZkpGU3poMS83YXg4S1dCcFQ0bWVPa1lCWCthUmpMbi9ZbDdveXk4?=
 =?utf-8?B?bzVWSjdyVEhIbVBka0JCOTl5SjBDampETWlGb3lodlNnQTZlazcxN21BYktY?=
 =?utf-8?B?YTVaUzhqWElQL1c1M0hqR0hNU1JNd2ZsWDlXbUlpVlNMb2pUeDNobUxuOVhq?=
 =?utf-8?B?SEJWUUp0d0htSzMzYWh0K3NobndnVkFyQlZuNTZ5QmMrajJMTGkxYktCK0o1?=
 =?utf-8?B?SGxwTW0rcjByaGhhSXI4VXlMU2FBdnRsTnByR2Zxbkd6dkdIcDVQeGtVRHdx?=
 =?utf-8?B?dkpST3gvMHVqZzNYMklIb1RMYTVsOEFJZFJ0dys4RCt5cFRxMEFoVG5DQzQy?=
 =?utf-8?B?UDVGbERVRmZqVktIclhDYzliampvQTQ0Nk9OWENHTGdWZmY1cytDU0UrMmlX?=
 =?utf-8?B?SW5WRGtraklNTmdpaVh0cEVSZTdSMzQ5U2VUUmRxdFNpOG5oZzdKM1VlYjRC?=
 =?utf-8?B?N2lTT3c3bm95TC9UQ2c5OGtYTTVESjVJTlpJd1ZPYXNyWGpBZVhYU1hWUUVz?=
 =?utf-8?B?QVZUQjVqWHpyM3R4YWxKc0Frb1FMQ21wVTVDNmZsc2VXeFNnUHE3VlpZVjk0?=
 =?utf-8?B?UUdETVZzcURuOTVVdTZ0UHZxWHVlU2FQUk4yb2J2VUhpSTFoL2U5WmtFUjRD?=
 =?utf-8?B?SG1rYjlvMHhKbURKcE9CbFRzVzhhS3l3YnFaampSS0loVWcrQVY4SGpDblB6?=
 =?utf-8?B?SWJqUGRobkk2cnhMU0R1UGp4a1F5VWV4aThxYWFQMFpXWk9Rd2cySnlERDFi?=
 =?utf-8?B?ME85RCt0ZDJkd3l6a05adkdxNFlnL2k0TFlrUUxoTHVLRjEwUHBNZmkzeGlo?=
 =?utf-8?B?czQvQkkyL3VyUlJxL290dkhGdStUdno4ZTdwSVhKS0pZQ0liN3NGQlgzQVpQ?=
 =?utf-8?B?UURUeTE2ckd3d2J1bWxBc3BrbXJyZFZHUlJqNkgxUXpUTkp6RkJkU1I4ZWNP?=
 =?utf-8?B?K0s4alR2UGl2YkpTM3Q3T2Mxc0VEblhiUHMzTlRaU1F5UXBqZlBVd0tBM0dG?=
 =?utf-8?B?U2c1SkJOUG1GRTBWUE5ybmRUeWVJYUswSkp5Q0NvdnFUUzNlcUtJSy8yRjVN?=
 =?utf-8?B?SzBZTkVzVkgwWUhhS0JBQzhWMjhzVkMvamlGb3QydnNvNE1CQ2RXcXdiSktP?=
 =?utf-8?B?QWtqb3FzWmc2dkJveDM5K2M2cGVzbHNvaTVadEdZUHJ1cW1Rangyckh4Vk5Z?=
 =?utf-8?B?ZTdxaVNQSjRxOEN0OGtPS29QSmJiR2g0dHdUWnFlVE5VVHFzc09QeEJhaHR5?=
 =?utf-8?B?MCtCakpid3JjYU5DWUtrb1RvSjJyTmhoVXpMYTlQTFBSRHpOL2k0TGR2alRJ?=
 =?utf-8?B?Q09Kck1IcU4rcDVQWUZ2RCtHNWIxWXY3K0c5OHcyekJ2QzBrSjk1WW81SVhZ?=
 =?utf-8?B?MUNEeGxXWjlxMVgyRHk2Wk1qVzRkdlp2T2h2a29ER2hPNU91VUNQajFzZ0I0?=
 =?utf-8?B?MG9RZHpzaVgvb2VyNnRwMU5SL21PWFVRSzlDYkF6YTlvMVhkQ3dNbFc1cEVt?=
 =?utf-8?B?ZEZzRTFQRlJIcEtsU1F4YUNWLys2YVRpb1lDUmJMeWRHSlR5em1ZU1VpOUUy?=
 =?utf-8?B?dFJRd1JIeVJmN0RKTVF2VU9aZGlvbVIvNjN6dWs5L2NEajF4VEI3L0ZnVXpn?=
 =?utf-8?B?aGw2UTlpenlVcnk3M2lyQ2Nlb0p1QTBteXFObkIzWUtjdExoUmp5bS92MEdX?=
 =?utf-8?B?Sk9qSkc5QWZyd1plOE4rLytrdlk1aVFTZGYzUjJyckcvRjd0VVc1aTdVaDZL?=
 =?utf-8?B?OUxySWdLNWtnaG5mQ1A3d3R3WjNwaTlMWXNBL0gyTjRzOVBLekphRGU3Q2F2?=
 =?utf-8?B?MGVtWHhWS0VkRzFqWGJTUGtOMUJjc0hWa0R4MGgzalYvYW40N01CeXJxTTd3?=
 =?utf-8?B?VzJiNUxPZWpicC9HckhSUkduYks2Z1JwZVBVeGRpK01UM1dlUGZwcGR3QzVL?=
 =?utf-8?B?amt0bUhaKzVMeThlNm84eGcza21BRWFIYlNVd2toWFVacWhIWHlFOEdmVlFl?=
 =?utf-8?B?MHpBSEdnRHkwZEZTY2tCVFdDVEpaWnRHK0VhMVFuOTFPZFpCaTBBcHdidDRZ?=
 =?utf-8?B?L2lQNzQzTWVFS2R1YTdTekF1bDFVZVRscEpiQnA5VXV3eWdHbERpWXlJRFZB?=
 =?utf-8?B?ektreWV4TnRUb0ozTUFIVEJpeCtNanFTTFBZQ05LeTJIcG1WRGpMcFNienR5?=
 =?utf-8?B?eHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8403898-7b58-4b92-3160-08dd3afb752a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:43:03.4236 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NZn8yv4kws6giFKi6jb6Af9M24U5SoZeMitTSJI+XJJLxgd0kGpWv6pOyocuFW0HhQHSeDfZZGwKK+crj/I+QUG3OoGQriTfgycdisOYuQM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10461
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

Hi Marek,

On 1/22/25 3:32 PM, Marek Vasut wrote:
> On 1/22/25 3:21 PM, Quentin Schulz wrote:
> 
> [...]
> 
>>> @@ -2395,17 +2395,18 @@ int boot_get_fdt_fit(struct bootm_headers 
>>> *images, ulong addr,
>>>       /* we need to apply overlays */
>>>   #ifdef CONFIG_OF_LIBFDT_OVERLAY
>>> -    image_start = addr;
>>> -    image_end = addr + fit_get_size(fit);
>>> -    /* verify that relocation took place by load address not being 
>>> in fit */
>>> -    if (load >= image_start && load < image_end) {
>>> -        /* check is simplified; fit load checks for overlaps */
>>> -        printf("Overlayed FDT requires relocation\n");
>>> +    /* Relocate FDT so resizing does not overwrite other data in 
>>> FIT. */
>>> +    of_flat_tree = map_sysmem(load, len);
>>> +    len = ALIGN(fdt_totalsize(load), SZ_4K);
>>> +    err = boot_relocate_fdt(&of_flat_tree, &len);
>>
>> My bad, I mistakenly "compile-tested" this with a defconfig that 
>> doesn't enable CONFIG_OF_LIBFDT_OVERLAY so this was never built.
>>
>> The compiler is actually not happy about that, it wants it cast to 
>> (char **).
>>
>> @Marek, what do you prefer? We go back to having of_flat_tree a char* 
>> or do the cast in boot_relocate_fdt?
> What about -- go back and add a code comment ?
> 

Not entirely sure to understand the kind of comment you'd like to see there?

Would something like:

// of_flat_tree is storing the void * returned by map_sysmem, then
// its address is passed to boot_relocate_fdt which expects a char **
// and it is then cast into a ulong. Setting its type to void * would
// require to cast its address to char ** when passing it to
// boot_relocate_fdt. Instead, let's be lazy and use void *.

work for you?

Cheers,
Quentin
