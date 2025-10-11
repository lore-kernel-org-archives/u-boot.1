Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A4DCCA476
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 18:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9285283A1E;
	Sat, 11 Oct 2025 20:07:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h9FPBZme";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6850983E11; Sat, 11 Oct 2025 11:13:52 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F67B83C2B
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 11:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/8CoPoP21AtURSsqHTL6LZlu3IYkjcNnT9F4JWKY20BtvLo9Vximvq8OxdLdHWvnDLcjE7RlP4V3hHwRxndrfDGOOpTWLGY9UZoy+PoeGLetrDv7O2TamAnsv/c4YFCSba5ztROe9BT2tI9OlFOAnGvNohP7F9iZSYYEgA3KX/rKJTfvr2OAEa8/xuzCAthM8691jQU7fJ/mA3MdMJv0EqBaO7o09pexEu2ceDiR4lZEIsLbYo96bN7XXQr1yQZxYIJhiDbzXqlLBoMeg7eKoxz/mSw44n4L1l7MdSVzO2ziKMY7vRcuX7N1dJ7SwCO6uuvZ7OGxU68iBFB8d0oIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=Ar9u9QjEzoNHm3bJzV7KI0wL7T1nkrqv5HldhTXo1HmMLDZ2QXd/GG1PmTPWATk6ZJ415YkdpBoSQzztV45Mlbdcu4PKlm6rL76g8beMVFEvPthT6F3aV2TVbVdQ6LvozDz7Sqx7OA/RKHLyyhRjMJsZ7SUG04/vM3TCZTvTcIV6afy1JX9jSVzceBU9a3AFTFqnkSKFkmW3oztnekAa2gDw2M7Z1TWupcmydJ8IkDE7gmf9fmOkr56W5vAIsiq72usd21OmCWUPgs2HXM6snMZI0ccBWMUTv2WRVERK6GoN6kjpdC7z4wfNTpu1c6nxLz3D+PQ4Hw1kUjbIp5IcxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2fHi31JAPlN12Io1Dbb7K6qhFfn87ZJCPTZM4+h5Ws=;
 b=h9FPBZmeMRJeBSdvLj8+AyNE2iDZ/cLiytMs3+HkF2ewXQc0/fAgH0qhOoZxxIhwS/nEddYGufcswTdneXFxC729Q23AegR1Mj7deAxRfs0rA+Zo0Td5MaRgKL/kLwKpivq1TujbvmTWm1ghHlPYG94Q22jP877o0fjOF2CtnHwgNkT7mpQvsjli0ndrQAmecjg4I7/D2aUTJQZIpugzjkWbJbreKXKl0GCwCFyMhF0xPRgodFFPWNCpWwMA79ZR3FKw3k6y4tVnFkkuccHmJQ/3AoIYkCL8Xc3IDYb7MOjhsEQGCnX8c6B63cBKgmy3PFuOsOEa7DL23zoE8oUxGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7129.eurprd04.prod.outlook.com (2603:10a6:10:127::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.11; Sat, 11 Oct
 2025 09:13:48 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.007; Sat, 11 Oct 2025
 09:13:48 +0000
From: alice.guo@oss.nxp.com
Date: Sat, 11 Oct 2025 17:12:50 +0800
Subject: [PATCH v2 02/10] arm: arch-imx9: Add USB2.0 and USB3.0 base
 address definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251011-imx943-v1-2-072b9ede2b4e@oss.nxp.com>
References: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
In-Reply-To: <20251011-imx943-v1-0-072b9ede2b4e@oss.nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 marek.vasut@mailbox.org
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alice Guo <alice.guo@nxp.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Frank Li <Frank.Li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, Minkyu Kang <mk7.kang@samsung.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Tim Harvey <tharvey@gateworks.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::11) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: a60649ea-6347-4925-af41-08de08a67cc8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L1RtZThnaElYRUxielZNcnlsRjhoSDlobEZYbzZ0KzFhaDZJb0Z0LytWSFRX?=
 =?utf-8?B?ekdIV1MrS0V2MDhIaUc1OW5JS05KNGlqWjd4SDA0bE9EcWJaRVdjQnY3Mk1v?=
 =?utf-8?B?ZmhsQ28veDcyeXdzcFY0SXBhQTFKeENsOVNuTmw5L204YUlEWURQc2ZGUmh4?=
 =?utf-8?B?anpYV1I0V1lOOGpNY1o3czdweEJIa3A2TEFmeDZqSGcwbFIxMWF3d080Unhu?=
 =?utf-8?B?YkI2MEhlUVB1OFJabUMzMVNQOFFmZk16NjJEVlRuREpCeGlDbWVoNGdOZFNw?=
 =?utf-8?B?N1g1SEpIaWhaSnVqc1NCVnE0WDlIQis2bmFZQ1hsVEgzQnZKL283SUllci9Q?=
 =?utf-8?B?ZDFhRUVMdWkySzA3NHkvNGdjQ2ZCQVkrcmd5SkVjenpFZXFzR1Z4SmVFNjNE?=
 =?utf-8?B?cExkWENVd1JSai90ZEF6eUpaMmZvZ2svUk9DaHg4L1hDSy81Q3Q1ZW96YlpS?=
 =?utf-8?B?c1Y3SHZRL3BpSUR4aVA5Q2t6L3dOdndJN25wSnJuUmJnQUNFVm5lcGsvVkFM?=
 =?utf-8?B?N1BhbkNzZzJtaXhGQmJJWjNQbHMxcjQwOU15S010Y3I5VXZOSXpvVG1PS0F3?=
 =?utf-8?B?b1NCOHFLb0V5K0ZGaGI3TTdGRG5DWkh3Q09CeWhTejNtRmQ4OEVuMTZGbFRE?=
 =?utf-8?B?ZmNLU0lvNWE3V09kN09tSjlHUWNFMTZPT1lLQlJFcEorb2dxWEs3blZtUG8z?=
 =?utf-8?B?RXh5cU0zdytKWCtRTXdkTVN0UUVwamtCSXFXZWFxZzAyUTV4dEQ3MHN3RDNI?=
 =?utf-8?B?SklLNnVReGdyMFpIVG1SeUdmT2J5SGM3N05NcFNwWlRKY0RVSmgzV3RQWHZE?=
 =?utf-8?B?TGdBc3U2bTM0YTREWUtiWXpmeHhUbFR0Y1BSbjRYaDJDb0ZDbVFQTFhXUG12?=
 =?utf-8?B?bkExcmJEYkJlQTdKbVhyTlQ1WitBcHl4TXMwU1E3cWVKSDkwdE9KWEw4UmRs?=
 =?utf-8?B?Ym44OVV2YWxnbk4yemtLVkNYaHdSTjlVN3Q3VEdMTlk4NXZTcDNzTGorbTVV?=
 =?utf-8?B?UDRRc0tYK3M2YlA2b0lHUmQ2RkZTWHB6OXBMb1dBRmZtK05aNXE3djNKdFpF?=
 =?utf-8?B?b2dxQmZETXpFNTNMUUFVNzYwQ2xkcGk1b0JmeWJZaFZ4Q1hiL3NnbnJWMFJ6?=
 =?utf-8?B?QVRoZzA1bVdoS2lteG5uVFNJWE5OUWwwUmhpOUlCcWpJN240d1JmU3hNajhs?=
 =?utf-8?B?SHBZTGJUMWY5ZUtObzI3eDR4c3E4QnVsUDJiNEh4YmFFa3FZSkE0aGJEWCtX?=
 =?utf-8?B?R0E4alNrS1llZTBhYjJrbkRxT3RmWVdrL0ZFVmNSRkJwbGZOSUQ0R1hCQnp3?=
 =?utf-8?B?ZnpET3BISXNBbVJ1WmlGNDcwbk9GVkJxMTFuTlRiMXZhcmcrVEJYc1RYSmtK?=
 =?utf-8?B?ek9Kb2NmTDlCMzJRMU5EL2VoazZ0d1duYWpKOUVOOVpkandqSUxqM3NPNTFB?=
 =?utf-8?B?MkZUYy9pdlc2SGFHT3RsZzFBL0VsNk4wWHF3elBVWUVzRTJxMEh4aVptMGVL?=
 =?utf-8?B?OFQybU9yMFBmb05vbnJrRW5RV0ZUNVl2a01OMHZsVWJCUlNvWEVHeHBtcis3?=
 =?utf-8?B?VklaL3pHdE9Mc3dtR1NUQUFwZm1RQUlZeTJCWW5HSEZiemJVTDhZQmZsc0pN?=
 =?utf-8?B?WDhjUzRvZzZUbldLYStYK2QxWG5aQ1lHczM0c0oycmgyNStSNHVCSkxUekli?=
 =?utf-8?B?ZWNiZzJlMTc3QjRuaUpKcHVZZkFEa21SRWFsSUR4Qnh6c1BhODlZNjZSNUtk?=
 =?utf-8?B?VndvMXhnNlRpYnZFRzhTK054dE9GY2lzcVNUQk82YzFvdmhFcHdob1pmTjlj?=
 =?utf-8?B?eEp3VzN4VzdiM3dUQWVockVlcjR1cXp4RGd1TEdUaTlvSVMremYvelBhV1JR?=
 =?utf-8?B?WEMvdDI3MWQ1RWM5aXliREQxckdYYk5vVitacHFGSGlzUk13WFpZYUZLVjRy?=
 =?utf-8?B?UkpIYnU5U1JIWXBsYjBjVUxmRFFBWWc5TjlIOWRZdm1BS3FENlMwVmZ0TGxG?=
 =?utf-8?B?L0lINjZuWUxwd0MvZld1dklkZjAxaXp1TVI2bWpweGdiZHN5TldleVkvdDE0?=
 =?utf-8?Q?b0uSsR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3VWeVVOc3g4bkNNbHV3dU9EYmVlZWF2S2wwNzlScnBHWDY5WkVaN3pyNzZC?=
 =?utf-8?B?VVYzSzRkNCthVlVCeURBeC9mL3JDVlM0RGZBZ2ppa3YvYkhsQkhYWnBuaHdq?=
 =?utf-8?B?aWRwZU5JNFYvRVBrbGlkOHhaZE9PWWFudHo4NXlqcVd2RFBMU2NVNXIxR1pF?=
 =?utf-8?B?YVd3YzdoMDIvRTFHOUJSYXpLTVRtUjZtN1dRMnhjdkFZdk1LbWNNVnMzTHd5?=
 =?utf-8?B?RzBhOU9XR2FFaGdYNDJ5cFN0TkNlRkVmMzR6YWg4KzVmcE9HVElUWkdGU1hZ?=
 =?utf-8?B?OHhrVjNOUFI2L1dheTJrM1llS0pHTmgzNjlaOENNZmU2amJEbThocXNlTTZh?=
 =?utf-8?B?TTZWM1NrcTQyeGl6OG5QVjRHT0NmZzFKbDYvdThOWkJNb29SU1NVQ21tenM2?=
 =?utf-8?B?NndQTk8wME0ycU1uNGhvbVF3RXVWVFhITTZIQXlVMS9zSG15UmZDeEc3U0FY?=
 =?utf-8?B?SUN1T2RxTUZrRmtvc2JsclJseXB3SmdMQnZ0Qm5xbDZrLy9yQmRGY3hEVnJl?=
 =?utf-8?B?ZFJndWZSTjJiaXRSdjB1UENxN0J4WE1xRnJSYmJFMlg3NnV0OVlVV3lOSHc2?=
 =?utf-8?B?WkVydkRqTG8rZUVENzNkSlpmdGxmZERsODFZYzRGK1kzNUFseFFyc3djL2JU?=
 =?utf-8?B?RmFrcXUxQms1WnRXRUNJS2o3ZDVLbWdNUWI3OTd6RWJkVjZSUEFuNy9rbi9O?=
 =?utf-8?B?U011MFhvZFJCMXYyellETjZ5ZWVBTzYrY3JXM3VxQlVmYytxVGlxZUlCMFk5?=
 =?utf-8?B?ZnNrTXZBT3NsUk9pMlJYUEFnRU9lSkJMcVhDU0tIbXo1amlVcGhub2kwOEJw?=
 =?utf-8?B?WDE2NTRGWHJzNDFZRUxlWjFTbHJ6cXY4QkxvMnB0SUVsZ015VWYvaWM4aFlF?=
 =?utf-8?B?QWF4MHQrbHZOOUZXTkEwR3VUV0Z3d0lza3lQc0F6NVBzZk5QNXlpbFFhVnFY?=
 =?utf-8?B?SVNOQnEvVUJLd0ZkdzJxNzZQT2ViU2JxTjFPRnYxcjcyd0FKNzVFem8xVlZz?=
 =?utf-8?B?NHZKNTdWL0dxQmxOTHlOMHduS052bXZUQXpseUtLdEJBN0tNNCtISTN1UE5H?=
 =?utf-8?B?QWxubDlweEk4Q3lkZHBYZ1ZyQ2JJRC9sTzJiZFRWcXVHMDlISVZkcjJwdmxS?=
 =?utf-8?B?c3h3R1NwTG1oZlBWMVg5UWNKRHBCNTFITkFVa2t5YkttNGtoMUlHOFdjSkQ1?=
 =?utf-8?B?Ky9uWVl3Vm1GVlVBQkxEWGF2QjZDQzk1a2gvaDREWjRNSC8vMFRSQlg0cmF0?=
 =?utf-8?B?VUtmVFU0TUxweHZiWExaTkwvUzBhZzZDUmozSHNLMXhNNERWak5hL0pSUWtv?=
 =?utf-8?B?MmZtaXhqZVhpbTJUbXNXaGNLR1ozVW9KRmFYMHQxZnhLZkU1Rk00aTk2OEdi?=
 =?utf-8?B?SVQvZ0xEaHNHVW9ETlo3MkZBaUJmdm1pM0Urb012RURDdnJrVUFLeVhOTi9F?=
 =?utf-8?B?Y01JV2c3bTI4TVM1REpPUHBLZTRlSFV3RXI1NThOcENUVnJ5T0hrMEJBZjVw?=
 =?utf-8?B?d2JFeFBHdnF1S2plall1Z0dPd0p6VW5qZHRidzBrSytqS003V2pCU01xSGNv?=
 =?utf-8?B?M3RGNVpOSy9ibHhWVW5PSExVVUJxOFYzeVZaeGd4MzJKeHZPMFBOdGI1NEhJ?=
 =?utf-8?B?NXVIRXUxRHg5OE9Bc2pIQzdXeENBSGc0bVc0Y3d5VENkWDdiWnREOU1oN3Z4?=
 =?utf-8?B?ZEJualQ4TEkweTZ5SXA5bUtWeHhZSnhHN005T0VIc1VsendBaTRNOHJUdHJy?=
 =?utf-8?B?TDNRZmVFZVZWaTA1SWhjTWRJNWMramszUGsxTm5QaHNaVEx1MnY0dWx3NDhX?=
 =?utf-8?B?SmdzVmhEaUJzUFRoZnNwZWpIejVhUUdRTzZ3MlFKRXA3dy80T0QyeFNFcmlU?=
 =?utf-8?B?NTB5dHBWWGhwR2xTb2UvNVlRWVhUYXc4bm1qQ0VJYVBZZUNDVzNFUFl3VjEz?=
 =?utf-8?B?V1ZURTJTNG4xWEhUM1JnZlFKa3hOUXZpS2FkNWxHY21BelZydXF3ZUd1RURh?=
 =?utf-8?B?SUd2M0UwODlxV0paRXR2Vkxmc1ZTNWRXSjdRQlQxVldrcFFoZGRrd3k4QlNN?=
 =?utf-8?B?cWNaem1UYzJPVzlkTmNwVGlHOGNNRFRSSmg5MnpBQytBeWNFaE5KOEJ1Mmdv?=
 =?utf-8?Q?+ga/0Ru0Qtc4PLNmVaAfDIN7M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60649ea-6347-4925-af41-08de08a67cc8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2025 09:13:48.6139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8VK+DIQSMrl/ssYCxkWio8WcBhDj2ibosgBJrAWTUObljmKOtjWMd+Vqx0ONu5qyavIPCPpeRHtE4co0A9fiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7129
X-Mailman-Approved-At: Sat, 11 Oct 2025 20:07:05 +0200
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

From: Alice Guo <alice.guo@nxp.com>

Add USB1_BASE_ADDR and USB2_BASE_ADDR for i.MX9 platform, and define
USB_BASE_ADDR as an alias to USB2_BASE_ADDR.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index e641ed299c0..2d084e5227a 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -39,6 +39,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#define USB1_BASE_ADDR         0x4c100000
+#define USB2_BASE_ADDR         0x4c200000
+
+#define USB_BASE_ADDR          USB2_BASE_ADDR
+
 #define BLK_CTRL_WAKEUPMIX_BASE_ADDR 0x42420000
 #define BLK_CTRL_NS_ANOMIX_BASE_ADDR  0x44210000
 #define BLK_CTRL_S_ANOMIX_BASE_ADDR  0x444f0000

-- 
2.43.0

