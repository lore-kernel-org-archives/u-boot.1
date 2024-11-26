Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3041ED65527
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 16:53:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD7A89C89;
	Tue, 26 Nov 2024 17:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c43GTIKf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2733789C81; Tue, 26 Nov 2024 17:53:43 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 257DA89C8A
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 17:53:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM3OpVandvJ/+rj6BLplMZQfuoPKYCeK93ysOvr0IP3UvRFr67Y0po7HwJyLl4LPpmS7y1bY7DuHaB9C9/zngtU86ueOvJENzQZlp0bHDURJsuYZkcTPXT3cCqhouMeima/xBJNiRUtbyPz/gBSC7iDNyFj5JMfaGeZ9zK1zp79TT6i9ltRx6iQ0ew+91iKMML6qCO0H6EfG/hHSt5MBk3LlDs6baFrCzssOPT5q3fwa0Ufrbt02OAZk41lVG5Fh05pz9/tiDutXJrarDR7oGB0+tT5SHwdGSdc9AFOW1L7QPvIa606KRgwCo2lhxK7qc7hcc+rDSJv4LHD7wjoksw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5E4G65n3+vAnZgL6STLQavo5M5Unet8YN2eAXQxUv2Y=;
 b=jTzKv1CtHI5+UZbqeGvsJtcfA0cru6iX63scHuYIan8PSvHafpVhJmN0KqEFCRJQiABtycU/4JeuFr2+tBvwj2rkPh3MiiGu8O1sp0ELdHRz9ggWdUm3ziAdyAlHG5rSyuksD2fy2bFJCnVYXqmJu0+AfBeQyc+cHAB/GEDbgojxQk/1Rjf0aynoI4XEdBLNOrDjcYtqeJTmZMEXW2AHoOIiBbF3iU/m4a2tFhGTxeq/tUp6JxmYhqv9rqrQ7lxEEyx7f4EOmpjTYHdzFRWu5tDWZA8IX5vBGYr5z5sPXkzpzZVqDAqwH8rItO0DO2oWG/YLAbxZDdCUr1VZ3Y37nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5E4G65n3+vAnZgL6STLQavo5M5Unet8YN2eAXQxUv2Y=;
 b=c43GTIKfhLrHiP39zCmpq2i9MlK2DpcMiziLCCXmRbp7izYfYstdokpD8MFvqpk8MMBSrv1Q5I9XrASz0yNVQueD1fuUV4BT+pe5iQu4W5ezOR9hdoZ8VuzDbFu8nfjeOGs/3V0Sa+le0K7H3Sl/+CRzwVvVbvtCU5FXiv1qXc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10698.eurprd04.prod.outlook.com (2603:10a6:102:492::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 16:53:39 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 16:53:39 +0000
Message-ID: <421a8aa9-4f7b-4d63-8f5e-34eae97b8b06@cherry.de>
Date: Tue, 26 Nov 2024 17:53:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/20] rockchip: mkimage: Add rk3576 support
To: Heiko Stuebner <heiko@sntech.de>, sjg@chromium.org,
 philipp.tomsich@vrull.eu, kever.yang@rock-chips.com
Cc: lukma@denx.de, seanga2@gmail.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, joe.hershberger@ni.com, rfried.dev@gmail.com,
 jonas@kwiboo.se, detlev.casanova@collabora.com, u-boot@lists.denx.de,
 sebastian.reichel@collabora.com, Xuhui Lin <xuhui.lin@rock-chips.com>
References: <20241121142731.1202209-1-heiko@sntech.de>
 <20241121142731.1202209-10-heiko@sntech.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241121142731.1202209-10-heiko@sntech.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0046.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::23) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10698:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b4ec252-ec32-4182-ec33-08dd0e3ade7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHNtY3gzS2xVNEhLWFMyUEJJTUNjL3ZLSzF5M0drVGhjdGxKZmRPdzVKSWNN?=
 =?utf-8?B?N3ZZanVQWmRQbnZtbTZHZHZtNVFMU3p0Z1dESnBJS1hhN1hlMERPQ1BYSUtO?=
 =?utf-8?B?ejN6YnloMW83b0hVSHhkK1lOSkxGcTBVQ2cxWjdPUURLdE85SFdUNm9icnNN?=
 =?utf-8?B?ejNmdVBuejV5MTN4eTVNL3k4VjUrSFVsdUJyWnNzUkVxWEZNeU1UdWdOcDdq?=
 =?utf-8?B?TWVxOERXU2pIVDdSeklORmI2b0JoVUdVZGNJV2cxVGR1MXpsamxoRFNpUGJT?=
 =?utf-8?B?RVJVWG04SzhieUFRSXN0VFFkZzF4aXM2OUFBdnIxNzE5TTJxc2Q2K2VkT1VK?=
 =?utf-8?B?bFFEU2QzUWV1RDBOTDM5cEJwVGJCcFA2L1djK1JxdGhqd2dDcjdkaTI3dmpM?=
 =?utf-8?B?R1UwQTQvQndtZHV3RGI3U29JNDFUVG9YNzZCb0poVDBQOUxZWTg0ZnR4aUhj?=
 =?utf-8?B?czhweEdMUFFBNDJrdTY5bGpWVzkvdkxvTm41M0p3aWV0bWY2cDZ1eFF1ZzhX?=
 =?utf-8?B?VWZLTnBjdDNJb3ZyZXhKdTkvdzl0RUhSRlhaMENXd1dsSlpNaWNLekU4MjZU?=
 =?utf-8?B?VEl2b2p3dVExc0ZMTjBaWDFabXM5akw3dS9hb1RGNkVwY25EaDN1c3ZQaXNx?=
 =?utf-8?B?REh0YlJyOWMveWY1RUg3M2VRejc2Y1BWVlp3WVlvemV2VUFKMm5MYi83RldF?=
 =?utf-8?B?Y0FWaDlyZ3ZJZDlGam4rMG5Qa1Bidjczc2E5NFM2NTVHUVkreC85UU9la2Rm?=
 =?utf-8?B?RlhrVEw3a1pCWGVjQWp3UCtKc0wxTEJJUzJFZlFPK2JDUGVjR0JnZ2w0MkVX?=
 =?utf-8?B?MUtLRXE5YmIvZGY5VUgwTm9ocVJyNE9MbzFRbFNaS1BDWVFSdXdQQU9PY3I3?=
 =?utf-8?B?bzErOWpVQUlsYyt6Z1pnVW81UGhhc0NuWVhwNU52SzMyVWpCRkdva21WYUlH?=
 =?utf-8?B?c2l2UnBocko5SG43UHFpd2tsMnVFYjFFRkpFQ0hhaEljWDlWZEZ4THZUWGV4?=
 =?utf-8?B?UFgyV3lZR3ZucmMyaHFydHlmZ1FJVzhiU09lY0dWc25EeG5zQXZjZy8wWndj?=
 =?utf-8?B?SS9TcWR1Y3RCZUhNSWdlRXNPT1BDUXFuUHd4Yk1RSk9hKzU4clBvSTZsbFFs?=
 =?utf-8?B?dVBzdTZkdmRiK3QxWTNuWXRRVTRUanVseDB2WDVuSUxrNGpNbkwyMFFjUWZj?=
 =?utf-8?B?dmlPM054RkgvdGF3eXZkMzZkYy80NXlETGEvc2JsSi9XczlTeVByUFhYQlls?=
 =?utf-8?B?RTNCcGQrNVl5Ty9IQjZrQjN0bjZIeGFFUUNBQnNxdDN5dEZ6MU9ydkhZOW1i?=
 =?utf-8?B?NGdMRTRWMDh3a3QwdkpDKzhVVStYcVB1V1F5Vi90c3dnSjlUNmNxTkNhTFhn?=
 =?utf-8?B?eWNmTklIMGNwQmVVSjdUTVFJSXp5VXpWTU43Y2hCMWd5bnFJbjFFcW5zS2JV?=
 =?utf-8?B?eDdqSXR6bmpVSlFzWTBQRUJ0ek4rclUzYXlpQldqSHV2RVN5bGFWb0N4NFA0?=
 =?utf-8?B?RWxUMHMvUDdta2RRQnVLQlE2Mjh5RDFXU3RySnVhZGVVeHpHK0hFQ0Rvbmtv?=
 =?utf-8?B?TVljRGxzUVVpNkhZSG9DVWlqK0lwc1lrQzBDdU1pYUNFdVRLVkJEQVUwMmVi?=
 =?utf-8?B?TjZoZ1RKZzE5YmZqL2NSS0kraG5Zb2lnY2tMeGRxa2FZNlIxaTB6YnlHSWUr?=
 =?utf-8?B?Qk51Q2dsdG9CbCtsTkYzZjNoZ3RJQVJ6U0xlb2NnSE55dkNKMVVGZjhUTHp5?=
 =?utf-8?B?K1N3VTI3OVRTcVM5bGFvOFAyZER5ZEpTLzFZc2cwT0VJbE9jWUViT3JJdzJk?=
 =?utf-8?B?aWEwNDY2RWVzd0N5ZDhGZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlpTVHZqaU8yTDNFWHFPZTRJU2lCRVZlL2dRRG9JaDFrN3hHekJCd2ZSYzJO?=
 =?utf-8?B?a2oybm8xSjJQdXhvV25FcUdseVA5SDVJa2IxcG81S21PdnlOKytML2kwNFJj?=
 =?utf-8?B?WUNjUThXVUY2ODAvTFZjdkwwalNnbEFZWU8xYlBCSE0zbXVNRVdSZUZxWXgz?=
 =?utf-8?B?elZOMGcvWmF2eUFmRHF5cjFhSm1lQUdCYnRuTGxXS1M4Slk0cm5HRW1iNjlF?=
 =?utf-8?B?ZmlvM2NQQUVEYmVURzBoWnJQWllDeTFKZlZBbFZ1U29wN3ZxRHp5TXoyRjB3?=
 =?utf-8?B?V2hpaithdnZDakN6ZlVNUFdMdXA4Y1QyTFprQmJKZGVRdU1QeitmUFdxbXI2?=
 =?utf-8?B?ZWEzdGgzelV6dDA4SnI1VDJjNFlaWFhYSzdTUlQveWdPdUQ1c2J6Tngxa3Nj?=
 =?utf-8?B?Q3N5eUE2NzRxTjB5dEZ5enUzTmw3Q0NpaU8raEFiQnVJTGFaZEdyUW9mNGd6?=
 =?utf-8?B?NzFYY1Nyelh1TGFObjhOVldQbzE2UmRWaUswTEpWUHRkTTlDL25XRFlQK1li?=
 =?utf-8?B?SDNyajhSMysvblozekxwZXpTS0pnV0dlYzIzY1pCSWpJSkJLejhFdkVzMmk2?=
 =?utf-8?B?WFNkcXhVeGFxbFRBUDBDVEpoMzJxc2F0L0ZKelJCRHArbVpPcjhEcXpGekpP?=
 =?utf-8?B?cktXdXkwV2xsZGRkUUY3NVBpK3E3bENCM0x5ZXhqMHNUWjN5RnFtZ1NUTEZZ?=
 =?utf-8?B?UkszNEYxWm5sL08vYWI2elBkempEdWNyZWI0OC9EcFpwMmc0S2g0NGhmZTN1?=
 =?utf-8?B?S3B2SDNYcGJybVdoWHZnckllbi9UNGloT2ZPV0N0TlFpNWMrV3dqUGltMXh4?=
 =?utf-8?B?TVlyaG5MTU00L0RHdlFYcXRxdDY0TjhWZDAwRzY4Nkt6UEFNOWNFcWF3UnBP?=
 =?utf-8?B?ZDNPVGNGWndyazhJOE9UbGR4SDI1UzVuT0FWN2RpV2hGVkRMdTNsNlpoc2JN?=
 =?utf-8?B?cFQ0UnF0VXEzcUZpZ2JUT1Fkdk9EYXh1SmdYaUtIQTdvVTdCaEdvVHFCVGhu?=
 =?utf-8?B?Qmk4K0t5SHZOL0g0Z3F1ZWduVEsxUFpnQ0FDZWNnN0M4VFZPQzF1a0J4eFJu?=
 =?utf-8?B?SGJjQXRmcC9CTXVYbEY1anZtUEh1YVhiTTVHMHp6QmFTWXM4OE90N0tDSCtN?=
 =?utf-8?B?N1ZQUnZSd3hRRVRuRFMyYnY0eXhuV1I3b2M0NlY5RzY0Si8vYlYrSVlySjZp?=
 =?utf-8?B?N09FV1hUVkFsZ2hUNEZEWlNhMW1ZL2N0b2NCNk9TZ25iM2t5VW0xK1lIbUc4?=
 =?utf-8?B?SmJWMDJBQkFRVUVpMlBJSmVNdGErb1A2TW5qMlZHbTQvajF0VklTd0E2SXJZ?=
 =?utf-8?B?a09telZDQ2QyOU5Vd0U5TDZrOE9CNWlZdWR4d2kzd3V0UmgvelVpWmo4TERs?=
 =?utf-8?B?cHpXYlVQQkQ1QzNtZmYrNDRlaFFnek95MkgxYlFDbG5YdGZ3Uk1UUjRjSUg1?=
 =?utf-8?B?NTJGYVdIeU00NHBybjExbUZaZ1pRUWdlMHpFOG83cnVGb3F5UnZydEtrbUE3?=
 =?utf-8?B?dlZLM01oaWNlNWEzZ3VkdDYrSFJ1cHhqczd6RDZyQnU2dUxCb2Y5bS9rS1A5?=
 =?utf-8?B?WXM5dVhaTGdtUUJPQnFKZStSU2FzNWM2TWl3cnVrV2k0SmJObXIyYzN1R1BT?=
 =?utf-8?B?MzlrRHR1UGh4SVhRNFZQUjNMR2JycVRScFpVdWEyMjB2M2sxbG5IVmVtMTVX?=
 =?utf-8?B?ZjBiR2xRS015dVBJZDBWbDMrZ1drbE50UEg0TjVNdXlINm02M0pYQjB1WGQ4?=
 =?utf-8?B?SlpvVVZzajNDNTRhK3JJYnIzakxvcFdyR3poMnJaV3VUL3pWbGJYUWxoNHgx?=
 =?utf-8?B?R3RQLy81b21yL0wxVVNhUzk0RkppVEN3THZiMklRbmIzcEdOMnFFZmtrV290?=
 =?utf-8?B?d2FQN1c1YzZUbUE4M2owODlNK3NrcU1JTnJ4UUNORHlGN0VVWFRrZmdjUFJh?=
 =?utf-8?B?N3EyUzJ3bE9UZ09SdHo1TnlzaFhBM1pEeGFVS3NFTDBGQ0tSRlNBS0N5SytO?=
 =?utf-8?B?SFNzTEpIekgxaHRWWmtKcDgvSlNtMWR3am9OcjB6dlFVek9jUEpTSWdOWkgy?=
 =?utf-8?B?TFhEd2VtdWxVNVlXWHVCSjRZYlFNckVHOHlkN2hCRmVPNEhLRW1GQ3FzSFpN?=
 =?utf-8?B?WHpESVJxVGpEVzZXRk5jMXY4bERZRityRk9pUzRKNGdzN2tPU0J2aFZMQzdG?=
 =?utf-8?Q?3lzdbBuydF4qHMe01O4mqhw=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b4ec252-ec32-4182-ec33-08dd0e3ade7d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:53:38.9443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MzLG6vpD48mFaNcPqvP4iyq6uDoZWClw2DBDG/tYbb7NiNOOzX9urYc8EXqK9ni32JrOu2RhpF4kpKaP9s8FrQLzYQoB11mvYOCcJM7td6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10698
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

Hi Heiko,

On 11/21/24 3:27 PM, Heiko Stuebner wrote:
> From: Xuhui Lin <xuhui.lin@rock-chips.com>
> 
> Add support for rk3576 package header in mkimage tool.
> 
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>   tools/rkcommon.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/tools/rkcommon.c b/tools/rkcommon.c
> index 3e52236b15a..d89c7d3afea 100644
> --- a/tools/rkcommon.c
> +++ b/tools/rkcommon.c
> @@ -135,6 +135,7 @@ static struct spl_info spl_infos[] = {
>   	{ "rv1108", "RK11", 0x1800, false, RK_HEADER_V1 },
>   	{ "rv1126", "110B", 0x10000 - 0x1000, false, RK_HEADER_V1 },
>   	{ "rk3568", "RK35", 0x10000 - 0x1000, false, RK_HEADER_V2 },
> +	{ "rk3576", "RK35", 0x80000 - 0x1000, false, RK_HEADER_V2 },

I don't understand why we remove 0x1000 here from the size of the SRAM.

If I go back in git history, I found 
915e09814a83128fee8b87b2ee2e5f4a17e04a01 which states it's total SRAM - 
size used by BootROM.

Can anyone provide feedback on how one is supposed to find this out? I 
think it's not the first time I'm confused by this and I'm not sure 
anyone's answered me before, but in any case, documenting this would be 
much welcome :)

The RK3576 does have 512KiB of SRAM so the base value before subtracting 
is fine :)

Cheers,
Quentin
