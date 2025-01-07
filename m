Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD402E77199
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:01:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2189D806E8;
	Tue,  7 Jan 2025 07:59:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lbs9n22E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CEE806E8; Tue,  7 Jan 2025 07:59:44 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE65380609
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YCkGMMkvCg/stkOd/8IiM4VHTPunowNaS8+nC2UYvLAtnDk7vG8t1Vwm2K/TkbTp9dFFZlOE5oYk1AWzQFLzuH5l6FhDqRNKE1mirngr3+39GHd/mLBlrTA7mftJTjPzTJK2ZZ3VGVmvHZ0QJ4L3elrK0qRQKs40u02+Yn9z3qgAIUNCI7xSkRQVS0pC8L2EPpjiAzJg+6VyUud3+pfPjeGLx/K13+w3TD0Y8uWlrDjL0luSDJ7HKFtfEL9AHcxbyvjWZLjBRttkH3yoDHFQZPd9XQ26sPWCliSoYz3Wv8wyK2QaiRfEB36LG++T53PwwEfuTlZCUl4fKJhomJtp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlUMGyxBQhduNy05t7RQz5g7V1u7VQrya+aWgAOdcJk=;
 b=ka+XxhuTCogjGe6Nh79VxdNgjW52sAQwji4shVRGK3HJEUxC0atSVeRHTk+NDMhFXD0s4v0gM0WhcJiuFGwnW+zu8vFyHW++5ZVPw5N8Vkz/sBsRGP8xlzgLno4GRFcp0JdTQLk2y1UcIQwsgVNtCil3WXwdjtPEUlp5spccrUG3Q+b0ZErechkg1sWZIB0F/K433Q/fvkXSrplsa6IfiRqV8HpIFYi41zmMFKOtVeRHpXEnSGz4mkwSOD9y+cnEjadQfPAM5akinKNj7RX6sprwZCHZzm5le3e+JaM8uGHlDvFTFkL8KcJ6NhuGLf1H4tu3tU1bPPQJI7g08J8wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlUMGyxBQhduNy05t7RQz5g7V1u7VQrya+aWgAOdcJk=;
 b=lbs9n22EmPC92S6Q6aCnChUvCt+oAK0SAJPWs/UQHwUdcKL4QJmIYyuaSj4FAZlaGIxS+/1tnATbhPF4CpyM1gGxFTkj/ECvkwvMrZd1Ss1+l5LCBpZGcliGcUimxHkxlssF6uSwH29H24Xy3Ty9ZIPlZv2TUXMsRGCQSkNsLwUk3kuIigs03teiDV6A0Jjm2DO0s5Rc+B/zwzVB/PHTE4HRLJy+Kpn1bEZaSktrn4UuzOmR8IUyCr9SoY9eTHJdFBSKNwTdNvpn0plYSUW7QRWmK9HWdrUk4IQ+hNgdZLPpS/6s2ePrgtRu3iz7A9pzLukS+oYWXVFQL05Qxbb6tA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:35 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:14 +0800
Subject: [PATCH v2 14/16] imx: imx8mq_evk: Enable dynamic settings to
 mmcdev and mmcroot
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-14-97671b1694cd@nxp.com>
References: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
In-Reply-To: <20250107-imx-bootstd-v2-0-97671b1694cd@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SI1PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10523:EE_
X-MS-Office365-Filtering-Correlation-Id: 086c1508-e87d-4dfc-9c2f-08dd2ee8d83d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlRFM1RkUXNxMnplZFpFK1hsRVUxVnZYV3V4djRDckw2TTYwcHdhQVdWUXJw?=
 =?utf-8?B?QjhwNHBRK3lFV2xMVkpzdUI1YUUzbExRUUFlUnlHSXpBc0pvQ3VWYXVwaHRn?=
 =?utf-8?B?TFZoYm11VjhNSUpzSG01NFZwOTFSWFFkb2YvOVUvVUlWTmYxMjFiTGJTNkZy?=
 =?utf-8?B?SVR4WFdveW9XK0MrYVYyZlRkZGJ3ZEVoMVptRStSUEt0dHR5NjlmU1p2RFlY?=
 =?utf-8?B?aWgxZ2ExM1YvajJNZkpVenZHM2FNUUlJbW9yWm5pU29iN2R0RGkreGxmOGth?=
 =?utf-8?B?YTIwNWkrRGMvUDR3Sk9RTnBwTXpwRGFrWlloaHpqNkNselhCcTY0ZXFBKzBJ?=
 =?utf-8?B?blZVTFFvUXk5a0FyM2RyU0d2QXROWlgydGxIODc5L3BxdDZHQ1VQNzlPbk5a?=
 =?utf-8?B?UG03VDVNR3RXOTF2QUJZNjBlK21UbnFaODZhT1NDWTlGVHpGNnVGVXBiNGRZ?=
 =?utf-8?B?S0haNkZ6dG5BdDRza3JwQVNjbEhYS2w4dWZGaFRJVzdXc0l4SG1rUDhvc216?=
 =?utf-8?B?emJBajM3OWE1TWFRaFgwL3BYTTY1SmIvL3k4bWdQK01sTmQ2RGFDNWlNSmg5?=
 =?utf-8?B?eUdFWU93UnF5TEpBaFo1dGRZSm9uL004VmU2THVBSFpLc24zZlQzeGFYTXdl?=
 =?utf-8?B?SGZGNENsZllNaDh0TEVqM0VNQkt4NURyR3NKK0hSMmhOdDZmQ0VjaEQ0bTlJ?=
 =?utf-8?B?ZklLT2tuOVFRZ3h6S0U1dTZmVllCMDQ0bzFQYjZFYzBHSmJyLzlBdUQ2WDJa?=
 =?utf-8?B?ajFsRzd0WW5BSm4ySkNGb0hwc3dxWmxWMUlGZDk2MVVoUy8wSVBXZGhsWlVr?=
 =?utf-8?B?Njg1eXhIeDRKUlhzRkpoVFBieUt0VFExL1VQU2JqNTV4OUxpbEN4L3BZSmdC?=
 =?utf-8?B?QjZIT1JDNUU5OGZScUhMYjlyc1N0azZUK2dibHl0bUdEbkZaNWVvR3dJOHFO?=
 =?utf-8?B?d2N5aUNhaUphY1NPdWVFN2RvZ1ZyTGpmVU5nb2FROGxyNEMrYjVDRkVyeW12?=
 =?utf-8?B?bzdzRkhrSUNMaGdobmtXSzdXQldWN3BNZE1DZVRzcnAzem9sbWFKdTFJdkl2?=
 =?utf-8?B?SDB6SDIrRzJETytLL3FHZWp0YjRrbHU1UDAvOFlUQ291cWRsNUJWMENtdjdl?=
 =?utf-8?B?V2pzTCtOblIrNGhMMCtsY0tsV1dKc2g4MnQ3VTJkYlltck1RZHN2cndCaUN6?=
 =?utf-8?B?b2lycDVGMm9JNm1vWlpCWFh3UjRNNHJJVDNOWDlkZmw3M3BsbGJDYWRKMWQ2?=
 =?utf-8?B?T1JNWCtnWmIvMWZ3cjJvQnpoeENpYk5PbEV5N0pESDVtSDlxYmtvcnRjN2tQ?=
 =?utf-8?B?MERtV3lYZFd2Rjc0eDlHM3UvVTFwY0gyeE1kTTNjWko5VU5nOUJDVEZETUNZ?=
 =?utf-8?B?YUxvc25Ub3YwY20rV2tHb0xMREozZGsyOVpjSEt1d0pURElmMmVBWkRxSHRW?=
 =?utf-8?B?U00ycmRFUDI5OGNvSmtWN2Q0U2UxTWhnWDJoK0tQNWVrWHR4bWd5SmVsczBN?=
 =?utf-8?B?NDhpdVBKb2hDb3Y5S09WUkZvTXB1MFJGUHBvamFHblpNOThCcHloU0ltU0Nz?=
 =?utf-8?B?aklrSFVEeGI1RnprY0dVTnZPUmNmRHRQYXJZSVBQY0JJb3p0Z040ZEZ3Z1FO?=
 =?utf-8?B?dTNPWVh1T2xQREhHbk1JTEhzekJ2RXlDK2xDcmJJcjNLZjlKVVA3TFVEb3M2?=
 =?utf-8?B?YUtSRllrbGw1SjVGU3AzaXE3enVLL0F3REtQMVVCc2JuSlA0V2VVaXBrM0I2?=
 =?utf-8?B?WDhENU1Pa05SMzFKb1ZLdTk3WWpJbFRMMnEveDlXNU56K1pXSnFPT3NYKzRO?=
 =?utf-8?B?RXI4WGhkeHJmVUtNTjd6ZHo0OWRZVWJsQktDcVFQcmQwdTBzb2o3UWlaVk9y?=
 =?utf-8?B?aUpLVGcxSjY3dC9oMmlCVm5ISmkwL1ppOTFBY3NUYmU5aTM3dlFYM2hGZEEy?=
 =?utf-8?Q?6P+uQa+EiqBcXF6riLu7S7fQ9JoHgiMr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nm9pVWp3d3dxWkd6L3poUWQ0TldrT3JGUytWRmQ5QjFrWWZrSUtrOE1teVda?=
 =?utf-8?B?SkpmYVAyTUtRWVVUK01Ibnc4MFlPMDQyalQ2K1JFVlBDL3BVS01OQ25ZY3lE?=
 =?utf-8?B?aXdNek95VWpYQ3phcEFqNXdVa2RUak5ZeUpZT294M2FuZGxpdzJGeE1zZGxZ?=
 =?utf-8?B?L2NaRk1IKzN3MmZXZUl0d0lieEd5Q05BZ1Bsbi9WdFpWMjkrckJIK3J4NnAw?=
 =?utf-8?B?MHVnRW1sVStUUlZpa1M1ZUhHajFwYjR0S0djZWdxdGIwRlBBZy9uc2E0UHJv?=
 =?utf-8?B?NkpEV3JEdUVEK3RwenpJWVpoY2hVUHR1YnpoNWZhUEhzY0JvNmNUZ25mVi9l?=
 =?utf-8?B?d09qZ2pDRmdLakxjeWVGb2hSc05qWEsrQ1NLcFA3cGRFR3VtTmFpUzlBZHdt?=
 =?utf-8?B?WUxjZDh4N0FHMUxvenoyamdFMmd3SE1GbGtkSzdXalpUSW5iUkg4N2lncVBs?=
 =?utf-8?B?OUo4QkdkT3N0a1hTVDZxV3c2Zm5ZZFJZYy9ENDJRWUg5YlBIcG5DaUhSajNr?=
 =?utf-8?B?TDUvOFl3T2hIa21BSm5sTlRYRDRaR3MvZCs4Vm1FZlhqcHJjT2JwNHlBSmc5?=
 =?utf-8?B?Qi83M09kZFhuZFg1dUpQT0w4L21kN3llVXk4Z0dHOE5CWDI4Z0ozNFJLUmpM?=
 =?utf-8?B?Y0V3NWJabjJ4VExwdTkwSmcrUUNkVWxjcW5DTkEwMkdRVUMrSzN5SkhIV3VK?=
 =?utf-8?B?UjFtTU1mdGtpQVRKZjhKWFYxRmpYamJmU21aM3hYbUtKa0xsejEzRDBJL2dy?=
 =?utf-8?B?Unp5K2lhNlRFdnY1Q1d2ZE1rZUVQQnYzc0RVVFJvTGFoWEpOWkd3Yi9DQStl?=
 =?utf-8?B?VGF1amNQbml4UVlpTmlad2YvT3RpOEFSaXp4cG9ubzNiTURCVVN2ZjdqRktu?=
 =?utf-8?B?T1hldk9zdnRQQ2pDd25nbGdGRWk2V3JsT2RtS2hGNHIzcjloanZCNkVpdzBo?=
 =?utf-8?B?aHhWMXpqU3FhRDBTN2xKSmRFNmRwa0g3WDRaSnVCbitISGo1bUFGVzNCeVFI?=
 =?utf-8?B?L0tDOXRCc1M3TVlrcmdoNVlnN3lPbWVCSlZZblhMaEQ1RDVTS3NiYW9valhp?=
 =?utf-8?B?a1JxRUJiaDlYVGpjN3RPVUU0K0REQzU2ajc4UXAzSkhjVS93V2pJVHFKS0xz?=
 =?utf-8?B?NHJydk9aUXZlbHUydHN6SHkrVU5hOHlpVlpsSTMyNTkwOUFpRWQvNG9TeTdJ?=
 =?utf-8?B?VXdIN2twZDNQYVJ3VVo5Z3ZXQTdRWFRWYzlyT0c5dWdsWXp2MW9ibklZdGUw?=
 =?utf-8?B?UjVDdmdwMFpVNGxuMDNUMDE3dzRZOGo0TTRPUUlNRlVKMXZ5T2lKVUJGMVk0?=
 =?utf-8?B?bEkxTmNEV2pkVkdDMUl0SWF4UzV6ZCt2blgvWm9lL01BNXlQVDEyc3BIOUJ3?=
 =?utf-8?B?cmtpNG5PZEdRaHdWN3hVTFFFQ0dpWlhzaEx5d2I4V2JodUhmV2EwN0pxSUNt?=
 =?utf-8?B?bU1TNzIwSXkwUW5uQ3I4emRmaTVaWE54NVQ0UXJ1MllMSmd6RGZBeWVSRnEv?=
 =?utf-8?B?aFlGcnhhaGpQQ05ya1lnMUVTK1dMcFBGbllSSGY3djJXRnA2UllydVFFdmN6?=
 =?utf-8?B?MjNBdVR6ZUU5Y0VTclBtYjlhbFJ0eWhlK3JBdE1Zb3VZUGNSdzNqNkgvSGla?=
 =?utf-8?B?ZUlYZmxiUGM3ZnQzRUdDOGJsTm9abzRWbEd6cWJuRTV1bVYyWWNWOWVzUy83?=
 =?utf-8?B?MWpLYlM3blpRY0J6ZE10bmdKbTJSTVdmakdzWCtnVjc3aXB0a2tCSFNrUS9Q?=
 =?utf-8?B?V1pxSVd3NUVnc2Vld2c3ZEpmMzAxK2xpWXhUQXNWTENMR0J3UXBMZERrT2tq?=
 =?utf-8?B?UDNSZmlDcVl5MWRWWmY0dEpMTkp0WGdkMEZtSVc0MWZham5sNGtLY29lOVF4?=
 =?utf-8?B?NWpkTVBXaVNvbmNtZ1h5ZStkalprNzZZYjZtTDF1ZUJmenNQK0ptaW5hczU5?=
 =?utf-8?B?NWUzNUVJT2xoR3g3U21tNDNWNFhpOU0xSkR3Y2tQVkd3ejNldk1aNjdXUVgy?=
 =?utf-8?B?WlNoMWwrWUlRRkNOMm5DaGIxZG1iL2tEK2cwVTBlcHFkUURUUWsrd1A3TG1Z?=
 =?utf-8?B?d0RJaG9tRG1YU3JuYW5oNmFGTGd1WEw0QTRnVDdwU2M5Tkg4SEQrRTNFVGtz?=
 =?utf-8?Q?K7PjCnTN9ImtT/xLPbspil07y?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 086c1508-e87d-4dfc-9c2f-08dd2ee8d83d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:35.2873 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLJerKxYkaHTsVfj6lsl/lAWp90FkI4Qd1FodXpFhCIq62I8TCggEQCo0p2c+4/vX0qrhYTjfnDpQVBDpaneBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10523
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

From: Peng Fan <peng.fan@nxp.com>

Enable dynamic settings to mmcdev and mmcroot for i.MX8MQ-EVK
Since we are here, clean up the including headers

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/imx8mq_evk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/board/freescale/imx8mq_evk/imx8mq_evk.c b/board/freescale/imx8mq_evk/imx8mq_evk.c
index f833996d5248eba637b443d7bc66141c3aff8f9b..18e83d90a08d653dd629bb773ffd11f50532f4b9 100644
--- a/board/freescale/imx8mq_evk/imx8mq_evk.c
+++ b/board/freescale/imx8mq_evk/imx8mq_evk.c
@@ -50,6 +50,10 @@ int board_mmc_get_env_dev(int devno)
 
 int board_late_init(void)
 {
+#if CONFIG_IS_ENABLED(ENV_IS_IN_MMC)
+	board_late_mmc_env_init();
+#endif
+
 #ifdef CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG
 	env_set("board_name", "EVK");
 	env_set("board_rev", "iMX8MQ");

-- 
2.35.3

