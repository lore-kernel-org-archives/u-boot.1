Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5366C25B74
	for <u-boot@archiver.kernel.org>; Mon, 27 May 2024 08:47:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3FA888268;
	Mon, 27 May 2024 10:47:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="guu02Cbw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D978E88261; Mon, 27 May 2024 10:47:07 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED71D88268
 for <u-boot@lists.denx.de>; Mon, 27 May 2024 10:47:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fI/w3O7JRWBRiF65dSudE3eTzgY1KgRJMiIHhae/7f3OONQN02Vxg0eilc9anLjA1lkf8XZ3P5J0oS4w6r7j0vSfmXzW09/3fnbMVENY+I79GOHnGV3jw29QCxl11SCgRPFJjDfcm9NnyBkshcNAcalp9rq5rrw2tKnDIzPmpnyoVyh+z26yMM+oFoQlSjtmyuYUZcjf+9TgKmCLpbuG3z7Nq40wASkenyO41r4u3xZ1MdcJw8g7W7DBthaqWbO0DMaBnUBUL2K7wHnDd76ZioE3JqcCUeihh9oWu9jrQOJo0Mny/ioObLAqx5HkwOzbYtR9VuUIbYdcuu4Y4C1Mhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIaoNWjMQWFFWz0g9/qoTJ+ccQ9UwoFM2IL6W8T71XA=;
 b=IYArwgMMe9DAlYGPPmfeLuY0LRQ+9l3HW13syQXUAljTM5uNVhD/w9LyWt0XPujc2wonxkAW4esXXHk+AKWiNJAkTdHJzTksNz0s55OdFsJJzs2XNjcVOHrpah6le3OSF//Dpd4fkjepAG0Zlz193tpInWFTzI7yKm9Qp5MFluNchMyfe43SKaONLOqHC4iLC/y9hLTgNQ5NJM+KAoZg6Ymg3uyKmYoe2J8Mel5M33Rme5ymDbWjhUrNb0c5TY4sCDy967/7mDmIOkF2/yy/MrKoCBXg6BlkTZ6VtakV6RWbGjIfma5Az7qvVstsk+UUbX9je4MaPTQKG3U1ZDu6Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIaoNWjMQWFFWz0g9/qoTJ+ccQ9UwoFM2IL6W8T71XA=;
 b=guu02CbwLfaeNcTjvBl4o7xR49EGleBzJ8O0CfBhWy21/volAD0B63H34JzYmAdYcz34+5eklqwrc3LyZJt2OPZ/Kc+abtMTzVyabYf7xfI0dj6k1kbiUQB6zX20ZmT+frV5JG47ShewP5TxA1LQGSHWaqDmUoCSzpkK4GlLk4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by AS8PR04MB9111.eurprd04.prod.outlook.com (2603:10a6:20b:44a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Mon, 27 May
 2024 08:47:04 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:47:04 +0000
Message-ID: <c4024690-7067-4d23-bdf3-320194e31287@cherry.de>
Date: Mon, 27 May 2024 10:46:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588-edgeble: Add USB OTG support
To: Jagan Teki <jagan@edgeble.ai>, Kever Yang <kever.yang@rock-chips.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: Anand Moon <anand@edgeble.ai>, u-boot@lists.denx.de
References: <20240527063915.6205-1-jagan@edgeble.ai>
 <20240527063915.6205-2-jagan@edgeble.ai>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240527063915.6205-2-jagan@edgeble.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0155.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::39) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|AS8PR04MB9111:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aeddfe3-f3d3-4f0f-e41a-08dc7e29927a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXp2SXBqd1JDczN1aGp0N2N4YTRGTFE2a1hMRGZTZkRxUzZWWG5XT2FBODM3?=
 =?utf-8?B?ZHh0VE8xTXFWcncxd1JFTnJGdUxjNmgvems4SmdjanBNTVMrT3ZiVGlrU3pv?=
 =?utf-8?B?VkFZdlZlNERxWEx3eVBhT29BOHdTQmR4aVBpYnBnMGpHMmd6d3pYWEtlMzlO?=
 =?utf-8?B?STc1Y0tSNnVVRXJGM3hFNklTZEROamsvRDZ1d053bE9QbjEwcGgwZW9sdHF0?=
 =?utf-8?B?R2YxWm9pa0NFMWlYOTdFcFpzcmY3cXdVVUhxL2ZxcXJ0cE0zbWFXdzQwdWkr?=
 =?utf-8?B?OVhhTGdUa1dFc1dGLy9CK2RRbXVWcGdIQUJCRjdKZ29FQmZENU9wNUZXSXVy?=
 =?utf-8?B?UnNuTnF2VGcvZ1NxWGdNYjNYQkxoUzlnUHl2czRLTThsRlBPWVhDcit5ZEFN?=
 =?utf-8?B?SDdGb3Z0WDZ4d3o3bzZVb29DTExKM3NDdzJ2a1VaQ2kvMjlGSm0ybTI3bW85?=
 =?utf-8?B?S3ZnU3E4anZiK2Q5Vkl2REM2N3Vnd21KemU2cnB4Ym5LaS9KM1hwWmV2UHpz?=
 =?utf-8?B?dEdtSk9jUVBiVXVxRlNzS1pYYWtuRkVzVUVnamNBQ29PMHlucDBXejZWMDQy?=
 =?utf-8?B?b0F2VnhTMHh4V2pyb3AzNEpQQkhtek1TTHNLN1cxSzF4MnhXbkFjcVBpWEE0?=
 =?utf-8?B?SHR1b21od0JPMmJTaXkvMVJMVU5pQWRrMCtZMjFSRFZ5YkFTK2hocm9Zd2J5?=
 =?utf-8?B?enZGaTRWa21aNk5oRUlHT3FLTmVBVTI5K3Q0Z0pYTEh6RUoxaVJiTVk2QUxB?=
 =?utf-8?B?Mk93aUY5Q29rek5ORDJuUkRIUC9GeWlkS2lzem9KUTV4N1g3U3BHbGUxTXFU?=
 =?utf-8?B?UzlNK0JwWXFxbWhzTTNjbENWcjJGLzl0Y3ZvNnE0a1g1TTZ2M3NjVnk2OENP?=
 =?utf-8?B?MHQyY2RmRUtzNTFETnFkb01kNElZN2JxVGo0MGZwYndIVUplRUM5L2NISUhk?=
 =?utf-8?B?ay93dFVHeCszT0dCUDhUbGYzL09JZC9scnU3Z1NoMkhHYkZVUGxHT2w2MkZr?=
 =?utf-8?B?NUVVUDZqV2FZcWQ1U1N2d0lLSGVzNTFpY05tYTJ0WWNpSjFLVFR4c2E4SWRk?=
 =?utf-8?B?YWlYTzJzSXJ1d2RWME1udElJbGYwcDNsdEJ0eWZNbG0wcW14OEt1MFp2Ym1v?=
 =?utf-8?B?OFkvNzUxSjZJMzg1R1pRbnI0ek9adnpjOW9vTSt3MEU4TzJCeWF0aWUvZXFQ?=
 =?utf-8?B?WjkvK0FqUjVSamFXeWNKaVJqZGszMGNtQUhSWkJ3cGFLS1o0UDBXWDVFSEow?=
 =?utf-8?B?RUFyQ1lqem12dlZzR1NZbHVHOWNQVzQ4RTRvYkEwY1lZVitseXF2cE0xZjdL?=
 =?utf-8?B?amtJbVZpUm5scmxBWnNIcE05bjBERUVRZ3NsTDAzU0pMZG41U0s3TFpFanRW?=
 =?utf-8?B?c1RrdjhteWJDSDhIbzVZK3czR3RhMHIzSHpmd3ZVVlk5M1VOV2dRN2J6bFVi?=
 =?utf-8?B?V0QrSHBUN29VSlhGMk1FS1k3dGh0M3pBQmJJS1pvbEZQWTVhWkNDa1gvdHFy?=
 =?utf-8?B?V1VteFFiWlJITHZGdkF4T3I5bHFYQ1dhQ2VMWXRyZHJZWjZkMkpWaFpkcytq?=
 =?utf-8?B?bWxjeGJON3hQUWFEUkM2U0l2T0Z1c1JEKzNlTW9ybUZUY0tjanpHRmlNQ2hY?=
 =?utf-8?B?MWRvR09BS2Y2aERxTTQyQm5EME1yQUtCYUxyT2xUUGZZOU53ZGJqcG5CZU9v?=
 =?utf-8?B?Smw1VGVZL3U2RUJrRlMxaU12cy9nbHVYNVBUU0NOdW1OalhOaHNnUjNRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHVjNUc1ODFrMlA2VjIyRnc0Wnh6WlNlYlZjNEVCbW9aZTNTaFA4Y2pLdnR1?=
 =?utf-8?B?emZ4R0xnemZmVmU3Y2orcmV6Uk03aHA4OERQN2JRVHRVSkFDU1dHN0VhQ0Yv?=
 =?utf-8?B?YzRMaU51bGV2N0RYUzg1WGVocDVndUxuQjB1aWFXblo1cXVUelBxWk9XODJL?=
 =?utf-8?B?WmZvdU0yM2hZWGVSVkE5em1OUDYzN1VWNGpOcU1Vc3JWYkhCQXcyMmFFbE9s?=
 =?utf-8?B?VXdVbmk2ZHNjRjJSNnE3OTFyNTVrTFV1QTA0MTJWOHlveDhJOFI4aU44ajc1?=
 =?utf-8?B?ZmxEN0xMamgwTGs4Wk5TVWhDK1NMeUtyaDF3cDMyUG81emhPMlZFb3hwY2Jt?=
 =?utf-8?B?MldsRU93Z0JkY044R0JTRFQwbVoxeHhzeVhjNStRVENZNGNSYmVDSEIyRlRn?=
 =?utf-8?B?czg2TUg5VkJVczRuKzZjUi9qZTdQYzdqT1htS0kyVHAzUWROVGxYWkN6NGQ3?=
 =?utf-8?B?b1RwSHZGZnVvdXQvV0pMazNPOGR6cjQwbFUzYTlaTjlJUWlvUTlCWUJUTzhZ?=
 =?utf-8?B?L2FFMXpoYVk3K1ArQ2pKZXp0bTZNWitibnpydXNlZUZsVmowVWsrZFVEYjR3?=
 =?utf-8?B?Y0xYc0xLeEplbkdPQkdxMHFPRjJ1d1JrTTJtdC9KS2w4cS9zUnlKZmRjVkE5?=
 =?utf-8?B?cUxzckZLRjB4TVdRK3lTY01Qb1NleGhnM292N0pJenV1RnNMeHFaeW82UW0y?=
 =?utf-8?B?bVViOXUxVkIxMFlwY2IvQnZHbGZqTFUvY3FCT0g0bGVza085VjJlbXV3MUdQ?=
 =?utf-8?B?TS9vd3h0SG9XdmJEc1RHQmtieDNFR0lGVG5Kd3ExL1IvZUI4VC9iMkIzZ2Z3?=
 =?utf-8?B?VEc5aURxN0k5SkgzZmkrQ3JFRWtDekt5azFUT24wQU9mSFJ5RWRWTW16blNv?=
 =?utf-8?B?MlUxSTk5cVVvNzVUZXBib3E4N1lCWFBzYUExQjVqYWVvTnJxeDJDWTFWY0Q4?=
 =?utf-8?B?WGFVdEpmUkdDbjlmcXlCYmQyTEdjMDVrOHozZ3pPQmhVNHdxK3craTBZR3dZ?=
 =?utf-8?B?UkthRkxBVnVQeUUzK0M1NFhXWDBkbWF6NHVKY3g5Nlo4WklWTjJqVUZWcHZJ?=
 =?utf-8?B?aEFmKzh5ODQyb0xCeWIyV2pNTm1VZHQ0OHFNZ1JBR3ZTWmY0b0NsVWovOURv?=
 =?utf-8?B?blBXeS9lWXJBRlg4L3Z5MEszMG9tNE8vN05yKzY3d0xnR3NmTUpXT0d2Yzdt?=
 =?utf-8?B?eDBGaGtIekJ2NGRwSkNud2toYjhiTTZuTFIwSzYxdkFPNW1XS3NmTlVjNHNa?=
 =?utf-8?B?QWVCNEtMUFRrS3RmeFNCaGhaQU1CcXNlR1c2cUxvbVhUVWpiQXhaaFZORGha?=
 =?utf-8?B?NTZCbTJndzdFSFVveTI5T2hIQ0I0UVpTTTc5ZXQrblo5N3R4ZHk4N1BaWUNV?=
 =?utf-8?B?R3hFM1QzYUtzNUZlN1graktDMTFNNWl1WGxxK0RTQmtRbGw2QTRBajdlQ3Nw?=
 =?utf-8?B?dUd1QWFscWxkSWlHYkUrNnJWWmNCa3RWdU5iaFNLMFBlNllDN29VQmk2ZVZm?=
 =?utf-8?B?WTNON1p4ZEYxRDUrSGx1dmFHWmx5RFd0R0x3SU8xN1ZEWmcyZnY5UnNJaTBj?=
 =?utf-8?B?UnFTTkZiUVlMc0x1NStIVlh5ZCtLRTN0TUZxaVZiZjdrbmxlR0s0M3FHcjR6?=
 =?utf-8?B?OWVSQ3ViODRtYlhhOG11UENqK0xyZ1NBQkZjSC9NbFcraVJqWkljeHV2RjdO?=
 =?utf-8?B?cFJZeWd0elZxeWhBUVZXd0VFd1loeHlTUDhtbWcydmlxZUh0cDhpQnFmQTY0?=
 =?utf-8?B?bzZncU8rdWRoZ3NCanpPbUJ6bmN6S2c0TS9nc1JBS1RyeUkvS0dFQWdjN1c2?=
 =?utf-8?B?SlpPSEQvQUxOQXBWbnA5U1Zja29TeWp0VDVLYnUwaVJUUmNNMndyMFYyWmEw?=
 =?utf-8?B?eGUvcXgrY0NUc3oxbkl6cVdoa2lWOEU2V2hWUDlTQkJuUTZOWHZ2OHV3Zmc1?=
 =?utf-8?B?aG1vTjVJODVITXJheEtEa2hsb1lhTmVTcllOSHBydXNlQ0s5MTMrc1ZhcXZZ?=
 =?utf-8?B?V1d1dG5ZZktWbHhUY0xIRXlzVUNzY1hTZTdubndyYUhuS3dvSUZIUVVLYkpa?=
 =?utf-8?B?dW4vcHdIdWVYblBKMG1BNnFPMjNrMkVjV1EzNWozcGZmZTlUVFJrNkhRbDZi?=
 =?utf-8?B?YjJRRU9EMEFmalUxVVFJeWVzaFFOdDlWc3RLSUJZN014c2VmbU14QXJXc0VC?=
 =?utf-8?B?M1E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aeddfe3-f3d3-4f0f-e41a-08dc7e29927a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:47:03.9816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Qc7N/uVn4uaDREaWJA/k0LZojwo6pPVxv5GKSj3Nu2uB9ZIRC4YSWjftm7K/9DgRh21EXoa6Ec3w3lPTD2ipbWDD1xGFIIhiiI4zwCghLw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9111
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

Hi Jagan,

On 5/27/24 8:39 AM, Jagan Teki wrote:
> Add support for USB OTG with UMS to program eMMC.
> 
> Add it for Edgeble NCM6A, NCM6B.
> 
> Signed-off-by: Jagan Teki <jagan@edgeble.ai>
> ---
>   .../dts/rk3588-edgeble-neu6a-io-u-boot.dtsi    | 18 ++++++++++++++++++
>   .../dts/rk3588-edgeble-neu6b-io-u-boot.dtsi    | 18 ++++++++++++++++++
>   configs/neu6a-io-rk3588_defconfig              |  9 +++++++++
>   configs/neu6b-io-rk3588_defconfig              |  9 +++++++++
>   4 files changed, 54 insertions(+)
> 
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> index 88f3f7eee2..534d9f8a2c 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
> @@ -15,3 +15,21 @@
>   	bus-width = <4>;
>   	status = "okay";
>   };
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};
> diff --git a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> index 289578803e..b3d17a60ce 100644
> --- a/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
> @@ -15,3 +15,21 @@
>   	bus-width = <4>;
>   	status = "okay";
>   };
> +
> +&u2phy0 {
> +	status = "okay";
> +};
> +
> +&u2phy0_otg {
> +	status = "okay";
> +};
> +
> +&usbdp_phy0 {
> +	status = "okay";
> +};
> +
> +&usb_host0_xhci {
> +	dr_mode = "peripheral";
> +	maximum-speed = "high-speed";
> +	status = "okay";
> +};

I don't see those patches in v6.10-rc1. Have you sent those to upstream 
already? I assume we should cherry-pick patches in dts/upstream instead 
of piling stuff up in u-boot.dtsis. This should also bring the patches 
in rk3588(s).dtsi to add the missing bits for USB support we currently 
have in rk3588*-u-boot.dtsi?

Cheers,
Quentin
