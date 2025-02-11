Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B40BC0219B
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 12:42:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18A1180104;
	Tue, 11 Feb 2025 13:42:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WidCICiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6681C800B3; Tue, 11 Feb 2025 13:42:34 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C35D800B3
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 13:42:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4sX8hNG80ELGim2aQx1/nyFYx8L32i1uWwc8O6YFxsoPVPMuI4a+Khh/qESeul+pga6S5SIWZ1/Pjz1UQ8H3AWTFNTe/p848Ur9jNTyY3xlj1drr62PDZfdGHSI6a1CudNcy7Tnu4uT19GbCXK0avCTEJxya29rkyRIy47aa0ArPAN0ysacvDvio846QioszXGI0DJnH981UHlx5zKsy+AlVv7Fv8ySeoJ/cFl9YBVq/3Y6rrFeUyLB7N+ob25OzYnsCVfoPn6sZJnGp0qf/Lns/aBYYb62CEfp4YCap73ijKC41woWgAGJp+HJKqfy6ECzk0g1LkO4RbU2ty6aFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94izvw1jyqKFajbVsiMwcIxOYuY8zkukWf5AALBOPrQ=;
 b=xwnLaoTjlCWr+SnKwNSodwyHkf8SLZgXxZLpH+ZCiSXL8rE7ZcnI7nP7eHXyQDHszihjv9Cmz2sV8HRNbbU9vQO9/VtabUuoNgUJ7yDsBH2J7YQcs/xaz4649holPstXeiqLgmzWQZCFMtijmTESHhhyLwYmojCmpjl7n/rTsxJ8KTI9QaNvIl0HLEHP5zTfFQqgbaPouTf+0qTZjqF36aCxHGiKMYcfAOqEQaJvbvrF6GO9gSw1V9y2e0xbSQ6rSN9WvtZdZ+4jUAE4QhyfYRIe7JpdOe0TgWHCrjtonW2MJeqRct6zi6KLEkMVp6Iev6oGbbapTXaD7XS+yJvy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94izvw1jyqKFajbVsiMwcIxOYuY8zkukWf5AALBOPrQ=;
 b=WidCICiu2Zrv9n31x5SNby9sLfV/aJqsfpvRDQ3uQ1KTg45c9my2hlZuvzEeGp1Ha4JVKIFpOAC4tep9yC6Jrc9Hy/0zPaY26e1N6Dqjtn2gO+3uRGmP0z/h9aBMAkwWxlAWAlygpc47sg6ibCHqkaEuhAiWDmvBI4io08jrsEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM0PR04MB7139.eurprd04.prod.outlook.com (2603:10a6:208:19d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.19; Tue, 11 Feb
 2025 12:42:30 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.8422.012; Tue, 11 Feb 2025
 12:42:30 +0000
Message-ID: <39f48938-b141-4121-b621-119ec43ac6d4@cherry.de>
Date: Tue, 11 Feb 2025 13:42:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] env: mmc: Make redundant env in both eMMC boot partitions
 consider DT properties
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250210013159.350443-1-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250210013159.350443-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0107.eurprd09.prod.outlook.com
 (2603:10a6:803:78::30) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM0PR04MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd4941a-7f69-4253-2ad5-08dd4a998c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|10070799003|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXplTlJia0xmSVIybC9aZkk2a05reW41dlBpRGtWR1RtdklraStsLzZaUzJo?=
 =?utf-8?B?T3VPVy9EZE1wUHRHYlpXd3Bha0tDR3BGYlgwdUJIemU1TnRmZlhZWHZZNTFj?=
 =?utf-8?B?b3FNVGk3SnBRZnZJZUV3Z2tXQnJCNnRFWURSUXEyS0o1dXRKallpdzdkaFlR?=
 =?utf-8?B?TlJBNXlvT01pRTBLblRwWXdwTHl3dEJFaDl2RmVkRldyeXhVSmsrcWkrU28z?=
 =?utf-8?B?NGo5Q0hScnVPWUNUbCtsVGRoR1RsNEtvQ01HaVNmeGVtTG8vTDNsa3NtNVlE?=
 =?utf-8?B?ZnhETVBkODVSQzlMTWdnVFRjTWN6bjltdGV5M0JMekwyeCtTMGN6Wk5pWkYy?=
 =?utf-8?B?L2JpcmpVUk1renh5ME1QRTJCQ1QrWDV4bnhaYVBiUXBpb1JSVm5pUXNpbHAx?=
 =?utf-8?B?cTBVb3hXdkJRSEx1RjhRcndJbXY4Tk5jNEhDcGpmem5kWTc3cnl0R0k0dmcz?=
 =?utf-8?B?Mzl3QmY1NTFwZzZKandxWERURThmSVZhSk4zYSswTUlNZHpmaVpQTTNoTUp4?=
 =?utf-8?B?ak1MQnRnV01JTWxsWi8yRmZGektpc3pyYXpZSDgrdHk1eU80eXpKSERkTHVB?=
 =?utf-8?B?S1V5b1lYaXdjVFZFRGpOWUQ1Q2g5c0FFVEZYRXlLVU1MQWNmWC8zRkNZcFhj?=
 =?utf-8?B?VTBmbFJvQmhxZVlBUTROTTQvakg2WDM3N05nUHdTcjJvRG1OWE1uelJINEZs?=
 =?utf-8?B?MGIyejU2S1VvWGlmbWdjV2xnWmZXWVRBV1NDT3lHcVVIVERYaTRrZExockRu?=
 =?utf-8?B?M2JWVHc5UXNTMElFT2ZyQ2txWGxDV0tWb09vZmFZekZFRmhpcU9mU1VuZzlU?=
 =?utf-8?B?WUZxdkQzbHoxdUpIM1djek9HRlZXRnFTdTlxZUp3N3pmcDhZeFV3dG03WEVW?=
 =?utf-8?B?djdDM3RHODVyZkI5WEk2VDk3UkVXZzVISlRKcVpOTlhPQm16R0FZalJWUktP?=
 =?utf-8?B?cW44MVJDTE1zQ29GRlN6T0dZZlFodFBRY0pzY2lyL2JZWVhqOXp4YnF0L1NM?=
 =?utf-8?B?cjhqNm92SUtqdjgySnNLSVJpUnNDa2tFUWsvWU9zNndqcUNVZW8zNmVvMjEr?=
 =?utf-8?B?ZktqQmJON1M1K3dGY0hLV0NNaWY3ZkEzNG05K3ZFazcvejRJVGZqRnBoZ1BS?=
 =?utf-8?B?eTUra2Fmd1NzN1lHNUljTFV4aXREc1RmUEtWOXJmRk9wL0MwUmdQU3V0Mllm?=
 =?utf-8?B?RENtQi84c1M2QTBpL1JFVElBS1dhNDlHdWRqMnFlV0MwL2NQeWpqTVhPWndR?=
 =?utf-8?B?d1dwNzRza0VOTk5NcVRGVU40QXV4REl4Yjl6S2dSM015ODQ0ZDFwbUtxUlA0?=
 =?utf-8?B?MlUvZmNRUTMwcmROTWk4d1NpaE5oUGd0Wmw0Z2xjOUY2bkZpSEs1ZXdKOVVY?=
 =?utf-8?B?aHlsOVBCWFhHb28wS2QyaWwwb2hLbEF0YThaMHlUZTBxcngxcGR6LzBHdFZY?=
 =?utf-8?B?UjRYRkp5V28zTm5CcDNPU0tCd08zM0FlWXdlKzM0VjU1TnQxKzVoblpjcHdq?=
 =?utf-8?B?ZEYzd2Rvb0NEc1IrbllTY20wd3ZrWHd6MEhjMEJCdFMzUWJoSVA5UEF5bGZK?=
 =?utf-8?B?eU5LY0tDMENxYkFjVVcxZWRtSDlmODRQYWpKRERGU3NIWGRQdVlnRGZWV3VB?=
 =?utf-8?B?bHVHRDR5V0t6YWJGemRUYmwwdWJLWWRoa0M4dkhrRE5maFZYRjdzaDc4YVkz?=
 =?utf-8?B?K1Mxc3Ard2xmZzlncDJVem9BdWRiRHpkemhVTmNLeGtyVmhHcnJCVHBVZ3hp?=
 =?utf-8?B?eXlNZm12ODR1R2VKUFFEcFdzQU1WYi8wL3BsYkZReU5lVThXVVRrdEdDVFYx?=
 =?utf-8?B?VzZkUHRKb3lIQ2c4b2QzYzVyUEZkekFpQlBobHU1NVhLN0dlVEJCcGc3dzhh?=
 =?utf-8?Q?HiWxP++Dnnky3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWZYT0pwbWRXTlkxWVJPZ3A4Q25jY0I5Wkh0RldFcnVRYW5qRlREaWZRNzRG?=
 =?utf-8?B?cis0Ui9JNmx2MnF4cWJDU2p6QmhJbG82emRsUVZqVHZ4Q2V0MTJFc0JnVE5h?=
 =?utf-8?B?dmpHZ0JzLzhBRmw2d1hQeFdOUVo0bEltUWs2RzVGakNrRjRFUUZYbEw3T2Ny?=
 =?utf-8?B?Smw0aC91ZTlPWmovQkNEQ3d5RFYvNzl6UkhJWmpYdUFxUm5QQ2dwd2tZRFdm?=
 =?utf-8?B?a3pESmlLcEhjZElMYmF2bk9zaGpkU0YvazE5UzRlaFJtUkxnTUtEUGtVbDAx?=
 =?utf-8?B?aWZPZVprMm0vTG5tMkFZVlBxMWdmSG5VMVhoTDlvM3MzaTdFdFhkUllUaEI0?=
 =?utf-8?B?OFpuZlhwYWw0UmtsL3BlOTFueHA5ck1kdEsralhuSlJjNCtRYS9GaWJhdDJY?=
 =?utf-8?B?QzgzS3M0Q3RLQ0VFR0Nua3BqNlZ2MWJTQS9XaGIxZDNzQWczQVZ2NHRjV1ly?=
 =?utf-8?B?bFZ0OFg4YmNHbWZIdjdrVG1oT0hiSk1UaWN5c3J6VGVWb3YwdjVtemxQZUIz?=
 =?utf-8?B?Z1MzQ0ZKVFM2bUovdTVtQmNMdUNoKzJYRU1WMTNmbmZmQ2ZybkQ4ZUZqVEEv?=
 =?utf-8?B?dEdaOUFWUEs4UDBIdm1KZXRiRmFlbEhweDl1dUQ2RGVtWmQyVC9IR1ZMU0V2?=
 =?utf-8?B?YzlSWWJyZEdYbmR1YklRRXMrbzh5RzBLTHFnQ01GTWJnUVpucElWTW9KUlV5?=
 =?utf-8?B?WmxkUXJESEYzVzJMSmFYbXpyRStibWN6eG1za2FHQ2pyM2pQbUhRLzBkb1Iz?=
 =?utf-8?B?TFVvZXBpbWdBUm81WnIxYkRRd0pEUGNkMHJHUUVtd2VLbEFzdWVmTGFHR2xn?=
 =?utf-8?B?SERiTG1zZmNqRVZsZHc5U2pOWllwak9tbnFTZGk3QVFrUTJaaTFuc1VSS1A3?=
 =?utf-8?B?VkhRZktHc25IUkFxUkhqaU9BTDBSK2RGSWxIVEZ2OXp4MXNqQnZ5SUw0cytR?=
 =?utf-8?B?cCtKZHZrT2MwampLK0c0TjJ6VEdEb1RaeUt6bEtKR1Jpc1V2aUpEWGxMdFBy?=
 =?utf-8?B?NnExZnpJU3VRa3RUUjc3bWY1V2RKOFdQZzFOLzh3RWtnZ0RBeEt5bXU5NnJS?=
 =?utf-8?B?aHdnYVlITXpZOUhlZWN0Kzk4SXJkUy91QkkzL216a1ZXVHNDTTBCRGJ1QmZL?=
 =?utf-8?B?anh4NG8yL0VrODNXSzVrejNvbURXdlFaQm9SRldXMXkwenc3ME5ZcEZCN0dO?=
 =?utf-8?B?MTI4cmdtV2pPVkk1NGNUYnU1NGFKZXZQY2V1Tm1YVlBmY2FNclUwb1gzajkw?=
 =?utf-8?B?RkhKUVU2VDVPamUzYy9MWnZKZVFlTGZxNFNsS1pzWVV2bzJnbEVOU3FURFBZ?=
 =?utf-8?B?WXVCS0hmTnFWZzI0RkZpWWZoQWcvN1VvT0s5azhRTmxjUmdlOXhuOUJTSjlV?=
 =?utf-8?B?Q1BqaUVVTGlGd3MzUUZoa28yQ2FGd3RSS09Dai9IaVhwK3JXTzM0b1dnTk1J?=
 =?utf-8?B?SktqQXg0YWFqMy9DUmNWQzZmZTRONWxEa3BpenJzSHRJWnZvczQ5S0dxS2FZ?=
 =?utf-8?B?cEFUb3lOazFrb3QwbXdLaWk5MlZyZGU1WVcrWkdpM2dXU1VJNkVHU2t2cXdl?=
 =?utf-8?B?TkhGWHNPck5ITldxTXhKQ01rSDFndm93S2NBMDlrNTIwQ1I3bTFVcmJlSTZj?=
 =?utf-8?B?U1R5dnJVTy9yNGZHc095S2tLWkJWeHZFc2xnYzBrTHhhUHV3Z0NkQUZKZ2lZ?=
 =?utf-8?B?MkFTc2RhRSsrMlhNSDNyYnZTWllvU1JGb3dnYzlKUUFMSVlneWNQWTg2Z1pl?=
 =?utf-8?B?d1JNY1g3RGVrcjEzSDBhRDZUZ3ptakdyajBtVUY5MkIwY2lkT1JOdTQrQ2ho?=
 =?utf-8?B?eG1KOXBiUXpnOGVLVExqQkc4eE5yRjZuYldnZHhMR1BFeXlLNnIwMUcyOU15?=
 =?utf-8?B?MVowK0hCWFcvck14d0o1Wm1tSklGK21EdXhLTy81YkFvZjdFSFBUaEtjbzBG?=
 =?utf-8?B?VWNGS1hMMktPM0dqTjBaRmJQdjdrOXpHSkVrN2xnbTNadlg3ZDBBK0VwZkpq?=
 =?utf-8?B?TnVTK05rbU8zcDk1V3A3MUIzNWRucHBKcXZ6YkNVU1BKczFqTWxtNVRJaWJ4?=
 =?utf-8?B?ckV2WURPdVYxZVhaaUovTXZOQzBGRUkyUS95S3hBUlhQSUR0TTcyQ0Y2MTdn?=
 =?utf-8?B?MU5Qd1dsUDVscjFuV3dUOVp3ZzJtRXI3czErcTlDaCtXMzVpYXJzUS84bmJp?=
 =?utf-8?Q?6M0E2kZ9l+ha4KHwvwydklQ=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd4941a-7f69-4253-2ad5-08dd4a998c73
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 12:42:30.6499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: URvLK2Uci08c5nyfHMCg5GQ0u41dWzGR2P4woJUEKR8euB0cwA4Dx0StGM17jwRxS5DMpdyf7G/ikxXLizAL0DHPyNV5/Lu4VSzuVT45w3k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7139
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

On 2/10/25 2:31 AM, Marek Vasut wrote:
> Introduce a new function mmc_env_hwpart_redund() which replaces
> IS_ENABLED(ENV_MMC_HWPART_REDUND) and internally does almost the
> same check as the macro which assigned ENV_MMC_HWPART_REDUND did,
> and call it in place of IS_ENABLED(ENV_MMC_HWPART_REDUND).
> 
> The difference compared to IS_ENABLED(ENV_MMC_HWPART_REDUND) is
> in the last conditional, which does not do plain macro compare
> (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND), but instead does
> mmc_offset(mmc, 0) == mmc_offset(mmc, 1). If OF_CONTROL is not
> in use, this gets optimized back to original macro compare, but
> if OF_CONTROL is in use, this also takes into account the DT
> properties u-boot,mmc-env-offset and u-boot,mmc-env-offset-redundant.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   env/mmc.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 379f5ec9be7..e911571f1f8 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -40,18 +40,6 @@
>   
>   DECLARE_GLOBAL_DATA_PTR;
>   
> -/*
> - * In case the environment is redundant, stored in eMMC hardware boot
> - * partition and the environment and redundant environment offsets are
> - * identical, store the environment and redundant environment in both
> - * eMMC boot partitions, one copy in each.
> - * */
> -#if (defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT) && \
> -     (CONFIG_SYS_MMC_ENV_PART == 1) && \
> -     (CONFIG_ENV_OFFSET == CONFIG_ENV_OFFSET_REDUND))
> -#define ENV_MMC_HWPART_REDUND	1
> -#endif
> -
>   #if CONFIG_IS_ENABLED(OF_CONTROL)
>   
>   static int mmc_env_partition_by_name(struct blk_desc *desc, const char *str,
> @@ -217,6 +205,23 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
>   }
>   #endif
>   
> +static int mmc_env_hwpart_redund(struct mmc *mmc)

Maybe a bool would be more appropriate here?

Please also document what this function does, the name isn't the most 
explicit I've seen.

Looks ok otherwise!

Cheers,
Quentin
