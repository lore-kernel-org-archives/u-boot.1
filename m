Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BA0C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 14:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05F268083C;
	Wed, 29 Jan 2025 15:58:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="UALWjGSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 816918091A; Wed, 29 Jan 2025 15:58:23 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D06080819
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 15:58:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wunFgoG5cct4vgVPBnt6olckwkvlpMB+SYlYDQgNt5o35THysdCwZgRyhFMc5eo+Qd/z5IRo/6EjrqX57mWXc5WdmRgQcT7qSYSTyBRU9ZAVgRkoAyuBUUZvvqWl5qyd8WXJrNKzSeOUZUsTEzhLRDuQ2JA7OhRCn1oA5XHHnDiiUxF4tKRMHd7a2BMp6YOIHcZknGWNf9fO5H5dD0+xu7WtA45fKOUgF32TWVu4ElmBidooHZ3OzBw4uDOugCyeV44KdTu0xoiPzd14U3znslOapFodefFfeD1X9dIJZq58EQA4T03rJuX+XAbgKDXWdGdVuid2NYfnmj4Szx2rJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yadISiITncg4Zl/Go3itAcJn3BRDOjyxXLvikn+F4HA=;
 b=cOpu4f3SI0SVAOuHw+SwMnTVuPlEkYCRJiCVNCJ03T+hqZR9a0zJszovPxoHEr4zo4rAZ3AGUypkV3MkvGlfNC4OmQG/dEFa/Y/OcVgxuaEU23y7u8hBvnohpq1TbK8k2lPQfAJ8b2LW8Srs8jMSuikNt7xwAvQ4JyUYSfzGcra9l4yMe7QiIMPgXvO+nF9eYrq0Qx5TYzT0x8avHUFz6F7AbJgo6hRNDYLIP3HHP7WCwUjULVgkntdNpoGvLpjFX7RTBHJHL2YASesFdIPF+3gS6YqPS9ePBjs8lmRiQX5/POB+VLtqxubW4RzEIfvfGrz7GB4UUVKbTpepX46K/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yadISiITncg4Zl/Go3itAcJn3BRDOjyxXLvikn+F4HA=;
 b=UALWjGSkF+IuAkv9ResMbGq4F4UyyG8KNn8cTjBZc4NIzernLcfNsCZ/+pk4qkpLozWBS3rx+4Q6N4EZi/CC8LEq7a+9eou4eIpYXZ5ZNfFE+b6YiM7R4vAFWFZERpUt00eQSdPTckhAPmD2JbY2l9xKQ6ARe8BZpx7riT+rOp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7072.eurprd04.prod.outlook.com (2603:10a6:800:12c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Wed, 29 Jan
 2025 14:58:18 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 14:58:18 +0000
Message-ID: <48f5c6f5-e9e7-42c8-b5c9-85962f38b466@cherry.de>
Date: Wed, 29 Jan 2025 15:58:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] ARM: renesas: Rename common/common.c to
 common/rcar64-common.c
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250118111621.362188-1-marek.vasut+renesas@mailbox.org>
 <20250118111621.362188-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250118111621.362188-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0075.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::28) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: 18267c5a-c9ac-4678-4032-08dd40755d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VjBiK0NUYVVhWjdZdDB6dFc1bXdwbkRoam5iN3RJNjBDdXlnd24wOWp1Yzdt?=
 =?utf-8?B?bWFYRXQ5YklERjhoTHIvNFU5R2tYY1RlWWNkZGIvWDZRT1ZJSHRsYUswd21a?=
 =?utf-8?B?bEY3QWNXeENZMzFaaTV1Y3p5d21sTk1nNFhUaEl3NVV0K0Z6MzdweGlRS0JT?=
 =?utf-8?B?cHRrWkZFQ3ZnRHhSMkNXOVRnd3RuTXZIVXcwRzlIZklKTG4weFA5dnZ2WWlX?=
 =?utf-8?B?L1g5QnhhNHZBdUNmUXora3FFNlh2dXFjVjBjdTJzajJzSjltTUIyWFphT0po?=
 =?utf-8?B?Zm5HVmc1K1YwV1J5N2lFTUtWVDZRL0E2SUZPK3ZWVThJREhBNG96cDd2WXNH?=
 =?utf-8?B?ZGMrOWNTMVdET0U2UlBOdnU3aURoSVJvSjhTcXNnclJZblFOV2cxRStkMzJF?=
 =?utf-8?B?V3N0VWsweTlKdjBwQ25Yc01QazBCSzBXMzlhcGo5QzJMR1NxNnFobXIvb0lS?=
 =?utf-8?B?TUM5SWZxd3hTbXZDUkFDbnMrMVIvUjlqOUYwNFV2MG5vaWVmNkxXeXlEVFBi?=
 =?utf-8?B?azU1NmtUWWtPdldqcGZpL0RNNUZXcDJ3ZGFVOElHc0JhTElsckwzQ0F1ZE5v?=
 =?utf-8?B?U1FWUlZMaURWRndPQVJpWGFNYkZWTWFEdzEvUm5lYk1UL0tpVjQ3azk1dGR5?=
 =?utf-8?B?VTVjQ0ZyUFdpVVVyTEtOK3NXck1SMFprVHhxUDFYWDd3RTlsMlNWYXk5VVVX?=
 =?utf-8?B?TW9BVTZjZnJkTm1vUDIvUVFXOVh3VHpZM2hRMmxCc1lVNEMvQ0pxUU9ZWXBk?=
 =?utf-8?B?NURrUkJETVVNQmNEM3NmdTE2VDFiTzVodVJkemd3MHY2MzJYYUVSeWpNRnIv?=
 =?utf-8?B?NGlKcmMyOExsWDBwRXNqOEZudklMQlhEbGxuZDIvK1BSQmJtbUVUWFVRaC9I?=
 =?utf-8?B?ZXhkc2dlM2FjZUJSb1hQeEVpTFlhRXFyL2pwck0zd0lqR1VZYzhQY0tCZGVY?=
 =?utf-8?B?dVRBc2pwaG9JekRHZUI1Wjk3UzBKMURQd09CbU82aGJUZmFCb2pudVpLUW9h?=
 =?utf-8?B?Q1VJVGluaGJDRE8yYlRrdzRCdW50QnEyTmtrOTR6S09nVGxqSytFMGNSN3JX?=
 =?utf-8?B?Zk4zRDFYdmlMenZjUzdWUngyZlVXQnRDaCtLcVRsRi9CeDRBVUUrVjk2ZVNB?=
 =?utf-8?B?QUR6dENZaGVsWldGMzJoaDZadS9CbTkzLzVLdHJyQnF0MEFQYkZyVVJYeGJh?=
 =?utf-8?B?VTRuRVNyV0FnN2tyaVp5by93TnY1bWVHVFZSVHFkVXkzajUxZ1QyaWx0TEk4?=
 =?utf-8?B?aUsxT0lBRDVQcjk3MmRqWnBTQ2tPVDV6ZldreWNjSUdDZVJqTU94WURnckJ2?=
 =?utf-8?B?SVdjLzl4d08xUDJOTko2YmdyNEhtSGdRRmNHSGNEMVpLRW0wdmc4K3JNbUda?=
 =?utf-8?B?QWNYUi9qRGJGZVBETzVyZmo3TG13bXFYblhmMU1SL1dsYkx0WnhNamt3Ni9B?=
 =?utf-8?B?RmM3RUV4ODRpenViS0g4VHVSTUpXQzRKVXM0bktiTDlKUFgrN2pjemorcmxo?=
 =?utf-8?B?RXIxL1F1Um1yNm1OY0ZjMUJtWHFJZ2ZuRUR5VzYrUlZhRldPcWdsUkl3VEx1?=
 =?utf-8?B?NTZxNlMxay9WRm5hTXY4c29JL0RCSFJQakpRd3RuaW42a0F6dk1WczJwTzJB?=
 =?utf-8?B?WEtlQjJEeEwrSmprd2hlOXk3MGJiR1loU1hxRkcrVmh4cXdTV3E5ZmloUmJ2?=
 =?utf-8?B?Wll4WEJHVU5jaUs4b0VJOWVhM2ZaYStsdzJtdHg2WWRGNFcyTzgyc3pjVDUy?=
 =?utf-8?B?S2UrNCtrdzl3bTNBOTI2SlhvMC9tcnZjcjRKS244Z2x5a3phKy9QVTkweFQy?=
 =?utf-8?B?QnJ4dTFld0VRMnJXVTJQeVFKcytIbUw4ZHN0YzJIc1FhWVA5RVZhOGVwWWRE?=
 =?utf-8?Q?GR9ggBQ1JehE/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjJOYWJPanBHYWJXbTBrMXg3dktzVU4xbHEySEVpa053SGJkTU50WDgrT3dk?=
 =?utf-8?B?bEFZSUw3Mzd0SjBGdU12OExmdDMwZFJqNUlvUzdYOHRxeURPYmpONHJYNFJS?=
 =?utf-8?B?bW9QOFZibmxBMG5pUmdPdDVManFDT0t1SDlNYStUUHJ2ZWdTenh5NnEzRERJ?=
 =?utf-8?B?Y1o4aG9CeUxBeG0welZ0dTFtNDBTeU9VMENzMzhOdkxIRGs5SEhUQk9KbW1J?=
 =?utf-8?B?cWh5KzRVZ3oxeG9rS1VEN1RGaHhqNE1yZEFVZ3dqTFBDUWdaSElJdVhHZXpj?=
 =?utf-8?B?L1ZmMHRhaFNKVlJxbkRBVSszK0haZFZlR2Q3V0Era1NkVTBtSkZXSDM5YWNH?=
 =?utf-8?B?enViWkJVT0IzbWJJYXJ3RjFnVm1Ua0pZN0cxRlVrYXVieDhTMEg2WEJNcXZm?=
 =?utf-8?B?YktFSTdGck5xeUJLdEYyNFVxV0lya0IxSmVUNEtLQkNjQmNTRDJ1NjdMeVlz?=
 =?utf-8?B?Yk1RbU8yUGFLRUZqM0gxbHJTQzVVU3FaRm8xMmk0WnNCM0hFWWxoc2JOZndz?=
 =?utf-8?B?NEdnKzRidVM1L240UTg2NUtZUkVzbnQ0bmRXa21ZQzRJbmppTm5aVFRwYU9R?=
 =?utf-8?B?ZlIxOXNOT1MxSlk2alQycXJ6WjQ3aldnU0pDdHdnZ1dpejV4RDB3R3puOTNY?=
 =?utf-8?B?TkVvZWVVN0lLNkI1TFJ4VXVuR1prMEpMQUo2Wk5nUGFXdWF6N0N6aU9XYjZn?=
 =?utf-8?B?Z0I4YzlGT0RtVW9OS2dsVnZIV1dRb1dSL2MwcVdzWFFja0JnRDhvYW84WElJ?=
 =?utf-8?B?UHBiS210S0VualpoMHBZYTB2QXFnTWp1TVB6YnZLZjQ3TlBXUVpKeEhBeCto?=
 =?utf-8?B?a2RaMXQ3N2FqODhYaTJ5dnRYcTFvbGVyQWVFM2daaXU5QjNpMVN3aFM1TTlQ?=
 =?utf-8?B?eUkwVnZIWU9BenJpRmJPdXZhSnl6Q2pjUHBnL0pTU29XMENkN0Rxa01NVnVQ?=
 =?utf-8?B?TGNmaHJERURLS3pyY1dweisyNVY3ZkxRV20vbUs0ZkVaTWFjM3VvUUtFZlFo?=
 =?utf-8?B?WldyeXp5M2ZEU3loTDBnNWtPcjR5YjNCYm9NM2hYYkJXeVZoU1dPSXUxalI0?=
 =?utf-8?B?NTh3T0RVNU03ak1lanBFK3FURWpVS3BNRFRZVlFNNlJTTThINnJGSGxVRFVp?=
 =?utf-8?B?SmQ4TFhQL2RYd3ZlZ1p3UmFTc3RyVlZxR1BCSGo4YjZ5Q0hKQzRNQ1cwOWFn?=
 =?utf-8?B?N1Y2ZEl1MVI3NEhiQ0RkZ1Z1bFpSUmNVcVhYcTlNUUFBOG9VL2RLNm1HYURD?=
 =?utf-8?B?QU1KS0lxMEdZQUNlaVpOR3VpQWduWUR6M1VLZEZHcEFYL1g5eFN0cFZIS2N6?=
 =?utf-8?B?SVVSb1Nxcmc5TnpGUFcrbUVUZTFzODJuN1VvNHprSjdBd2hCc2lOVkozMUh1?=
 =?utf-8?B?Y25jcER3dUhOMTlpVFA0aW5tb09wbEptOHprVGJjWmg4Ri95M1JXeFJFcHM1?=
 =?utf-8?B?YzVZRUMzRG1Qd3lGbGFBcUt0eENqNmU2MDZMWnJEYnM1UDBlMWU3M05UYzBI?=
 =?utf-8?B?YnNjMXVTSVJ5bXRIaExIMjFJSFgrKzJtbENKdkhsQ0JUQnFGRGp5MFdJZXht?=
 =?utf-8?B?ZXE4T3N6cTM1aHVhTlpwbEQ1TloxbVY0clRDMWY3MmVXYXBidnh6YjZmaC9X?=
 =?utf-8?B?RENJT0hhNUV3ZzBVSldoVURqQzZKVHoyVXljdjlXajdqZUwzNjRLZC9sbnQv?=
 =?utf-8?B?NjZmY1d0N0ZRZUFDd1RNRUFTcGhlZWhwVmFZNVRlNWk5NjJJSnI2TVJta0hE?=
 =?utf-8?B?dXdmWnNLRi9vZStnMk96c3hCYjNGTVB2Mm1wRno0MjdSd2pvVjQzZy9VK2ZZ?=
 =?utf-8?B?WllsbGpmNXcyZ2d4Y2I3ZTY3ald4RXN5MFBCQ21NR0Y4cjFDUWI1S01TdS9B?=
 =?utf-8?B?R0VNRmt5am1PVWM4MG1jL01jb0FMb3o5N2hWVk1qTmp6czFlalllUFo2MllW?=
 =?utf-8?B?b2NXQUovbmZMcGNBRWFFSmVnOHdkbEExdFVBMUxLaEkrRURSVjNnNVVNclNL?=
 =?utf-8?B?c1lOUU13V21FWUYzeVRTazVyTHVuSnhzK1RHMmFQRzNhWHRMaDBqd1hERGsz?=
 =?utf-8?B?SEFTVU1nNUNDd1IxWU8zVGc4YTNSQUdDUUhyS3dxUjNGZHhGb2NxVlZsMUhL?=
 =?utf-8?B?bHJRR04yVHl6Yk8ySXZCeER1VlBoR2Z6M3gyQjVFYVcvWmZic1dObkNtOVp5?=
 =?utf-8?Q?jfNe74m0+oalwHkqu7zsCY4=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 18267c5a-c9ac-4678-4032-08dd40755d64
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 14:58:18.0384 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwiwB6ejU/7zLO+CW2moDK8BFh2iFK7kMsbWoH0n9Ka52siKvGlge9kEsmuPB6uKjw6YNg+AUPFyLJ3h+GuaGvvFcNyzvlDi/maBHIs+UxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7072
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

On 1/18/25 12:15 PM, Marek Vasut wrote:
> The common.c content is specific to 64-bit R-Car SoCs, rename
> the file to rcar64-common.c and remove R-Car 64-bit ifdeffery
> in the file. No functional change.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: No change
> ---
>   board/beacon/beacon-rzg2m/Makefile                 | 2 +-
>   board/hoperun/hihope-rzg2/Makefile                 | 2 +-
>   board/renesas/common/Makefile                      | 2 +-
>   board/renesas/common/{common.c => rcar64-common.c} | 4 ----
>   board/silinux/ek874/Makefile                       | 2 +-
>   5 files changed, 4 insertions(+), 8 deletions(-)
>   rename board/renesas/common/{common.c => rcar64-common.c} (97%)
> 
> diff --git a/board/beacon/beacon-rzg2m/Makefile b/board/beacon/beacon-rzg2m/Makefile
> index 6a6ae94def8..10b7a7fbfa9 100644
> --- a/board/beacon/beacon-rzg2m/Makefile
> +++ b/board/beacon/beacon-rzg2m/Makefile
> @@ -6,4 +6,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
> +obj-y	:= beacon-rzg2m.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
> diff --git a/board/hoperun/hihope-rzg2/Makefile b/board/hoperun/hihope-rzg2/Makefile
> index a42c55b9d00..299769c9cb6 100644
> --- a/board/hoperun/hihope-rzg2/Makefile
> +++ b/board/hoperun/hihope-rzg2/Makefile
> @@ -6,4 +6,4 @@
>   # SPDX-License-Identifier: GPL-2.0+
>   #
>   
> -obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/common.o
> +obj-y	:= hihope-rzg2.o ../../renesas/common/gen3-common.o ../../renesas/common/rcar64-common.o
> diff --git a/board/renesas/common/Makefile b/board/renesas/common/Makefile
> index c531738b22e..8c26c0afd90 100644
> --- a/board/renesas/common/Makefile
> +++ b/board/renesas/common/Makefile
> @@ -18,7 +18,7 @@ endif
>   # 64 bit SoCs
>   ifdef CONFIG_RCAR_64
>   ifndef CONFIG_XPL_BUILD
> -obj-y	+= common.o
> +obj-y	+= rcar64-common.o
>   endif
>   
>   ifdef CONFIG_RCAR_GEN3
> diff --git a/board/renesas/common/common.c b/board/renesas/common/rcar64-common.c
> similarity index 97%
> rename from board/renesas/common/common.c
> rename to board/renesas/common/rcar64-common.c
> index 7fba8d10ff5..74ec0a46e6f 100644
> --- a/board/renesas/common/common.c
> +++ b/board/renesas/common/rcar64-common.c
> @@ -18,8 +18,6 @@
>   #include <asm/system.h>
>   #include <linux/libfdt.h>
>   
> -#ifdef CONFIG_RCAR_64
> -

This file was already made rcar_64 specific in the previous patch, so 
you could have made that change in the previous commit.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
