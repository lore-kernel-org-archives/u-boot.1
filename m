Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F83D1AD43
	for <u-boot@archiver.kernel.org>; Wed, 16 Oct 2024 10:24:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA25388FAC;
	Wed, 16 Oct 2024 12:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Bsz/HF2+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29C2288FA0; Wed, 16 Oct 2024 12:24:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA95888FAC
 for <u-boot@lists.denx.de>; Wed, 16 Oct 2024 12:24:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGfdOqHwAN6C7X9NbYKpQR+jr0G6ovImHyFCbNQEi3Z69B4ZE8f67hcxLK/1VN3JRWvboro+vId2TbMr7JtrDIredfgCd6qu2hbc3XTVjVrg5BbR177vHBqO/4vlOC0+91N3v+jTx4XRdJyFFxcVJ/+XcpDMb2VcUyAb0W4yMdMyK2+UxuBLF+FBddCleW+Xt5LGek00CIkNJujml5sqdMkzOj8McBF5I8TMVRLQjBfAP7nSiZGsVWeNU2M9YpF1tAYz70pLVCBufJ0VBoLHYrWm4LZ7IeaEivS7TeUkubClQXVhgPNszd00NeIn3nxCuPSmUwhL4M0EciQO7Ku4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaLBnm7sW1sTGrHNRdjdYvOjgdmWqqAyjdP28w+brwI=;
 b=niCtGgTz4cQ+YtuVn7Aplmc71mtZS25qRPLPIofDfs/nH3Xfn2FxKMCRPUTbgRGLB7WFt3nFj2KtRycOacUSxSlYdXO7jI4xL9bTDUZjoGNANBcKFocFTN5dugQepRbomugqdAwojCIYI+M8KiMmoVbHFlxSfM5gMOws6p2HuuqcWKI39MW51osWWBLRgXOn5rUu1QaL7hARGwzqkCsuPHBfssJCY4EsN54VFQl+TIsSTIBw8+pQurbvPJQssmIh1srUAhE4uP13xMTHACuXD3YFLt10XJdSt7sb2UvZoagZbJLCDe0xtPn8FYwYwAC0N3XVNgOkWo68v6bDcCQc4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaLBnm7sW1sTGrHNRdjdYvOjgdmWqqAyjdP28w+brwI=;
 b=Bsz/HF2+1u2XY79ObCJoZoM3HEGr+x4NRtu2m+xUoYB67yhiK9TkSv1YDzL8eup7MmNesuBxjAIpg77Ms/o142efLHhy/e991YRnxtpRMcQ237X8du5NWDPYCzQep6UrGZ6NsAlqN6jtj1Ufo1tnDG0vwcauLNe/1/7jcDDI14Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DBBPR04MB7835.eurprd04.prod.outlook.com (2603:10a6:10:1ea::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 10:24:23 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 10:24:22 +0000
Message-ID: <65a444c9-02d4-40f2-9ff2-708cdd6d00e9@cherry.de>
Date: Wed, 16 Oct 2024 12:24:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] rockchip: board: Increase rng-seed size to make it
 sufficient for modern Linux
To: Alex Shumsky <alexthreed@gmail.com>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>, Marek Vasut <marex@denx.de>,
 Ben Wolsieffer <benwolsieffer@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Chris Morgan <macromorgan@hotmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Janne Grunau <j@jannau.net>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Jonas Karlman <jonas@kwiboo.se>,
 Joshua Watt <jpewhacker@gmail.com>, Kever Yang <kever.yang@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Neal Gompa
 <neal@gompa.dev>, Philipp Tomsich <philipp.tomsich@theobroma-systems.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Stefan Roese <sr@denx.de>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>
References: <20241016100203.629713-1-alexthreed@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241016100203.629713-1-alexthreed@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0414.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::7) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DBBPR04MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: da0cdcc9-37f9-4c12-c344-08dcedccb3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|366016|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTV4QzBlbTBWYUNHeTlzNlJNeENaRVR5QWF6WVlNTWJIanp1ZWJOU0E2QXlr?=
 =?utf-8?B?dmFQaFJJMmNFUW9jbW9tK2pubmtMSDNVeGE0RDVmUUVXVmVhOTl5ZUxyMjRo?=
 =?utf-8?B?Nm5xL0FDc0JSY2tRazN3T2JOaHlRVDBYNFppSVRLVHpEbFNJVytlbGEvQ1dx?=
 =?utf-8?B?ZzNuZEZRZS9KMVJYWCtTM2xPTDcwLzgzajdOTmJrT2NFVDJVVTRhc096RXlm?=
 =?utf-8?B?YXVXUnRxcEhHY0tpdm5qOXU3WDVXV056NHBFellZOWswelhYNzJnaEJ4ckYz?=
 =?utf-8?B?aGsvQVVBREJUZ0JzM3cvdmMrelRuTG1BbUFYa3JiVmpVcFhicGFwK1FYbGJ4?=
 =?utf-8?B?aXpxYTlWenZ6bHVaczl6cjdKMjJrYWVCYWlOM3N1cnF4a0c1V2crdDgzcVFv?=
 =?utf-8?B?TVNkMXB6QTArUVpOcGE4Yjczdmd5bEdueWNDTk96STkzSUNqRldkQjNIOFNO?=
 =?utf-8?B?cGtjWE5GL3dIOFdpc0Z5UEdpSHR5cGxDQ2JKTml6cnN0cHZLLzQ1NWpUZXdj?=
 =?utf-8?B?SjNiNmZBVTdxYmVVNnRua1Awdm1jV0tuSksxVjAwdkgwaGNDbXhiSGVXWmlh?=
 =?utf-8?B?NVlyOEZBd3hJQ1pXMlFtSHJPTlY0TmJqbU5FVzkrOHNpazZaY1cyYXRvYVYz?=
 =?utf-8?B?WVQ4aWFwY3pzU2tLbHUzL2dkTEtzREErdGg0YXVsQlE4c0xVMUFwcmVSVG5P?=
 =?utf-8?B?eTFpYStKMk9BWHU2NnpmOGRPRDBlQXJGWDNtMDU5blBpQmx5OGpweXI3NEEy?=
 =?utf-8?B?d1YzZ3d2eVJ5b2RGb201R2IzblNaSHlxUnM1US83UnM4RE1zb3JDSDlTa1RP?=
 =?utf-8?B?QW9Sdld4bjlzVEJ5SFc3dEsxdFZqMUxWc2hMcStpc3FHNUpsZG90a1BDSFg0?=
 =?utf-8?B?Mk1mdk1zRG1kNmpqVzBqWHJ4aU1uZmYwMUtmZm1MNmZJN0t6MXlJNnJmMk1h?=
 =?utf-8?B?WjVrcnlzV1ZnUTRMemptZmJPbHFGREVsVjJINWZncnZlSWFHQkpQZXpES0hU?=
 =?utf-8?B?cjVJRm9tUzNESFBhTjEwSzRDUks2eVgvWEwyaG1GK0dxWVRITWQ4Wng3WGxp?=
 =?utf-8?B?NXp3cmpvUEJKZzErQTdpYlFuc2F5bUZJbEgwK0Z2a01VTFdMUEFKNzR1VkJl?=
 =?utf-8?B?VkNhU0pScngxT0ZDZ2VOc1VTMW5oTitSUWVHNExsallQWWtZd21FY3dXUUts?=
 =?utf-8?B?eEN4Rys5ak4rSGVkNFcwYnBNUThFRWJDQ0VzOE1vdHVjQlVaQU9CckFmaUhV?=
 =?utf-8?B?VGRWd1ZpZnlmMlgzRzBzM1FpUXl3aHowS3ZnaWVhZ0trLzBDcksrVlR6VFFC?=
 =?utf-8?B?K2JBQmFUNnY1bDI0TnFjZ2huRnNWOVB3WVAwampjUVR5TDMrNk0zNkVoUzZ0?=
 =?utf-8?B?TC9kVkpRclVTbzh1N1YvUGxPc3ZBV0ZGdlZsTy9DVm1wcytKMlduU3JRODVO?=
 =?utf-8?B?RkVYWnZNL0t6THN4bjk0SlJkSUVIU3VwOHFnYW1DNU5wS2tpKzZGOVk3aFJQ?=
 =?utf-8?B?WVlqaVJTUm1PbHIrRG15bXJQd25aeFhUUkQvRXNXQTU0WS81ZlZONS9kQUJn?=
 =?utf-8?B?ZGpDOU9OMEkxdWkvWm1TczFGRWtBQWJGSlc0cDJPQndsMUJ3cWlGeEhJY2F6?=
 =?utf-8?Q?/D6LO468JkskSx0CF1Yf9xk9/1RmOVOymqtp6tVwCamU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUhkM3pxZGlyZU1wYmxORVJ0MitadmN0cmhwMTFJQUFGb0lxVEpaWG8zSlR2?=
 =?utf-8?B?L2I3RFRGSnowcy8yNVYyRmdiRG5BMkZxQUpqcURXRlhqaUI0UVFUUGZsTnND?=
 =?utf-8?B?NUZDc1lTYTk1NHFNSFIvTFVIejdiMk5weUsveUZzM09pbUd0M0M4RVFhbGo0?=
 =?utf-8?B?UFBjMDZ2ZDdmNkJ5czlMemxFM2txY3RGZEFmTk9odWNxd25BS2JGYTlpQ0hS?=
 =?utf-8?B?RThXRm5iRnhEZ05FbDBoK015OGpRbTVGclJpZ1pMQU9xZHU1b2J1UitvNDFr?=
 =?utf-8?B?aXhNQnViYnNRSGlyTWZIdnpxcnNIWXQ0WTVCYUQxMXhLdkM1MVdJdGxVVTAr?=
 =?utf-8?B?MFRKNTdNR0t1Q203VVpRY2tRZkYrT2Nub1Y5djNxTWxLVmZRWHdZdXFqSnNj?=
 =?utf-8?B?aUJwQ2hHcUxGNzJsS29ZOGlFK3F6TndkMmtNeWNZVUNuOTFHKzl4bWdmRG9u?=
 =?utf-8?B?ZG1iOTk2ZGh6d3dUelBYMWsrNHQyWUU4bWF4R0VYU3pFdkFwL0VxektlUHJ1?=
 =?utf-8?B?akJJcWlJa1gyZU9yTjRtbHJZdWRseFQ3NStZMjNhdDByK0tpZlF0bkx5MzRm?=
 =?utf-8?B?R3djbStIc3ppcFg3MHpiQ1ZzYXJjaXQ2UU54VWxpWXJ2cGczUFVmcm5QYmxz?=
 =?utf-8?B?RWpZZkdtY1FKM3BJc0NSYVZsY0JyeUl4QlBscFhxVDVzdkFPZWdOMzJqd0Vu?=
 =?utf-8?B?OWJsSzN1ZHBxdFdmRlZBMTBiYXUvT0VOVENBV0VZTXBiSzA3dGRVN3Y0THBn?=
 =?utf-8?B?cFdseFV5amxzV0c2SUhDTTFoRFBkemZMemhtbFZpaWU4VHYxUG9TRzlKMEc5?=
 =?utf-8?B?a0ZvTk84eGVwWXY2aEsxU21xWFJvM1gvdVppVG9YVG5WSlE1Vm9XcFZCMWNo?=
 =?utf-8?B?VFpxc0k5TjdtZkJ5MWtDbUFIZ1gycm1ON0FIeW9GY29kOGhTZjhabEcwTCsv?=
 =?utf-8?B?Z2hFV2xGemw1WDlhSUcrWHhUY2YrWFh0MjhiU2pZWW5HeWEvMFkwZE5Kc1hW?=
 =?utf-8?B?dXJHWW0yRTR2b0ZTc3FDRUxrcDNtQ2phblpjcU1YVjRlQzRiSWc1dDBkZTdG?=
 =?utf-8?B?alpXcnhKQzRUWmxJRXdyUDRQQ1FnQ1Z4UDJha2s4U2s2NUs4N2NiVXRLTG54?=
 =?utf-8?B?U2FSYzZhVXZiWVRIRzV3aGFtb1lObm80ZFozcnJteFArSGlxdUh0cjdCZFpp?=
 =?utf-8?B?Qm9vZE5icDNUUmo3REZpRjVtRkd3SjRtZFZGN3VScjJQeTI0cERXQWh0YVRD?=
 =?utf-8?B?UHZuR29zYllJQmEyYjFxM3RuR25qWW1IMU53ZzgxdXRnUWlpNmhMSnVTemd5?=
 =?utf-8?B?R01jU29hSHptaG5UYzZsazJ0Wnc3ZmRuUG4rdVJZVFJWUzZjcFVubGQyd2Fn?=
 =?utf-8?B?Vi9NWE1xS3J3ZFRRa2ZvM3l1TzVNdUljRzU5ckh2Wlh2Ny9oekZHWnUvbDh4?=
 =?utf-8?B?OWJYaUg2Wm9OZlN3d0F4K3BrdVNCMWJmS1pGZUNQQXVlcEt3K1B4Z0NwUzV5?=
 =?utf-8?B?T2REdE9lREt0NGNod09qWUZsSHJIOW5XazRoYkpSUm0zSVJSeVgwOFRhY0F4?=
 =?utf-8?B?SFlpYUNXTzNKMEZDVHZQdXdWL0cyNG1vVHAvM1hFdS9PSWxleWRGYzVzRDlU?=
 =?utf-8?B?VFdqbTg3UzFqckhGY2Y5M054dS9xS2V0bCtPdi9jVFNNYXJYeHUvbXJsaHdq?=
 =?utf-8?B?SXpSbE5LN1pJZGx2VFpVNk4vYitMWGg1UmNyZGtPZDlUamRleUNNVnJ3NmU2?=
 =?utf-8?B?cjkxRXZ4MkFOU1dRV0hnQTUzMUFvZi9XbytOOWEvRFl3SDRsSldBWjEyRTM0?=
 =?utf-8?B?OGFSL0NYZHpMYmJuTWY1cDQzTXZGWFczV2xiYXdUQzM4RkdlS3ZjYno5Wlp3?=
 =?utf-8?B?aWNqMTk3R3RqR3ZWVFNiZHJFS3NRVmlXKzVNOVVFbzQvbnN2VGpES1UwcXlV?=
 =?utf-8?B?Q1VjVmlxUlNEWUhVbDlpL0FXMGRQSmhMUmRFeVVJdjZzUjlvbEdzeEpXdlZS?=
 =?utf-8?B?aFkwY2FWOFBtRDZRQVVEaXh2TnFSRGwyZHZ3eVViQkhyQm05MjQrVE5GMWdE?=
 =?utf-8?B?d0IzcDkrVlNOV2Y1VW15MUVwN1Y5cmZHcDAzd0JHa0hpSVJqMWJId2xZWkQy?=
 =?utf-8?B?LzdFcGJES0ZSdzNvbmtPUEZGZ3g3UTJRNWhtZTB2c1BTditFZW5HZUZwK0pz?=
 =?utf-8?Q?yzOsJ1xo0L9JTr8FuS6FIJU=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: da0cdcc9-37f9-4c12-c344-08dcedccb3e9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 10:24:22.8936 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X5U/jUKFI7liapRE6Ye9YZ8/DDMCZU3VCOQ1stzg1NaWiUHuviEVD+Y+xlq8oqXZk2Q8dQRNODzBczpdAGAboh/siIWdbxqhhlZ7MssUNMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7835
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

Hi Alex,

On 10/16/24 12:02 PM, Alex Shumsky wrote:
> Increase rng-seed size to make Linux happy and initialize rng pool instantly.
> Linux 5.19+ requires 32 bytes of entropy to initialize random pool, but u-boot
> currently provides only 8 bytes.
> Linux 5.18 and probably some versions before it used to require 64 bytes.
> Bump min value to 64 bytes to be on a safe side.
> 
> Boot with 8 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [   12.089286] random: crng init done
> Boot with 32 byte rng-seed (Linux 6.11):
>      # dmesg | grep crng
>      [    0.000000] random: crng init done
> 
> Linux source references:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.19#n551
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/char/random.c?h=v5.18#n236
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Fixes: d2048bafae40 ("rockchip: board: Add board_rng_seed() for all Rockchip devices")
> Reviewed-by: Dragan Simic <dsimic@manjaro.org>
> Reviewed-by: Marek Vasut <marex@denx.de>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
