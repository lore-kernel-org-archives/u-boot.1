Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625CCC369C2
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 01:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBA99806FC;
	Fri, 18 Apr 2025 03:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="eAZBakVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24396807B1; Fri, 18 Apr 2025 03:43:21 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6322080107
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 03:43:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veQAprmzmv0eI5ByWJFOoMuy6uz0qb8WlS5YsYRdT3lbAxEHN30DYZNwbXPgsn8HGvXc9Kk1LV6oi+pHIf9zi6WFKKeJxz+/W9vMixnpgxV6CnRHMIJjv+MYYOLTaMYBZJwdl2jiVxx3xe3CSfYOO4bLH3QVtg2NtPU8snkNtdxhfFumpKOFFQ6D7ZfKuuwMKhZmMefcg5vuHGTs20TykYsXFK16MmYEfC8Y9qehKgXRolePCO/A5StnMrNEWjQnm/tGLYgmuW/46kjLd0BeEji02Yxh61s6MwywL3TxL4nQ/h516JTTYPOmBLBBd6sW78W6bu2GpTpusx/B2FowOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=46a/DxGdYmNCMNWwZAhfUUUptEuYgfyaHt9x1Gs7Ku4=;
 b=IRWTj3jrpnrrS0yj9VRVTw4w7hgDLPQmUzKSOD2eODfE9bd1UsM6eryV0s4yPwqmNSDdWJJ2Uo113Hlx3ZNk7tycm3UxHlFv4uWe2xPhroO+dbXL/Y0ioUtys4ufLk+a0g3cAkeBggApcYkamJLB2+p4P7b9CHAy0DuGwTjtwuNPM5Q6Ujtqur9zX4+VrDR55WwQSsaD7BtzAMwfbwH/wSkQyF2SeXUwzKHoYE52/v6lrrXoRT7E3ViCbxuBQ3oPKM7vTTgWQvjg2iwR9XL+5eDQFOZIo15dgLNr8+ldxhwSnfGK+t1QWe9oAxaslfspiY2Jt9UTG2mEZI+XBoyV8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=46a/DxGdYmNCMNWwZAhfUUUptEuYgfyaHt9x1Gs7Ku4=;
 b=eAZBakVro/rOc5f3ZyvNo5F81JJmhX/xrbGntmDc2fgRixgv0jh63lLMii82bgEsitYN6UdB7OlgRyvbNd50W5Yq9o1kGazwKlyr/BZGPyYbMufAdKFPsfa6PQHzbo1QsWC6G1d8VUtTgN/bTEJ6F6i2zStRBc/wchpfoGfIgP60xLvw2YaYWelB5s+gpMfKQ8fsjjH/jLGYOancSj0kCkgmr+8dd3CyU4fcCDFz1im47hK+fx4JZr/iQm/CAo5cTv0OeULqk7vpBgBPzQhpufqCujPK3SI4CasUJUBkVkzoc1fP/0X9EQkILLqtm5XatJcW74O3gpEzrQU9canJIA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB9282.eurprd04.prod.outlook.com (2603:10a6:10:36e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Fri, 18 Apr
 2025 01:43:16 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 01:43:16 +0000
Date: Fri, 18 Apr 2025 10:52:00 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiDlm57lpI06IFtFWFRd?=
 =?utf-8?Q?_=5BPATCH=5D_power=3A_regulator?= =?utf-8?Q?=3A?= scmi: Move
 regulator subnode hack to scmi_regulator
Message-ID: <20250418025200.GB5954@nxa18884-linux>
References: <20250322014444.174796-1-marex@denx.de>
 <PAXPR04MB96441F643A1FCC464C25CDA2E2AE2@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <4db49cb4-bb80-4aa8-958b-a5b14f0d22d4@denx.de>
 <PAXPR04MB96443BD51F4B7CE32A39ED54E2B42@PAXPR04MB9644.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PAXPR04MB96443BD51F4B7CE32A39ED54E2B42@PAXPR04MB9644.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:4:195::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB9282:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a5cf59d-e035-4de4-dcf0-08dd7e1a636a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDBZditCcllCZXFTLzdLREtzKzdncnhHVEJKN29Yd2Y0dnhITGJmL1V4MXVZ?=
 =?utf-8?B?Ry9ZdFh5eUcrRlpnV0lYd1liZnhDY25XMXVrSEgybE5WYVJ3bjBQcHRNc21i?=
 =?utf-8?B?L0xRQkZ4YVRCVGJ6dytnUEtXU1YxZDFva1FocmNqZ0xDSGdoMDAzdlllblNi?=
 =?utf-8?B?b01VTmtGdURkdkFUZTRjc0NDaVRxWnhnbTdIV1NKcC9KejIvN01jSVBnRjd2?=
 =?utf-8?B?RWNxcU5kYUx4d1lHRDZoVnFKUlhqOVhCUkcrdXdVbWJUdXBCUDdmd3JsRTVi?=
 =?utf-8?B?T3VXUk5JMEI3ODJPZ05IUzNqTERKdEsyeGFPOWlDU3lWMWkwa3FXWDRSa3Bw?=
 =?utf-8?B?TmEvalJtZWxMNlp1RHUrNkhDRFNrSWxIWjVweGlpSThUQ01uQ015TXNmblFT?=
 =?utf-8?B?U2swVFpaLzUxbnhJWmlYVFFmaHpVVmlzK3FVZWo5SC9EUWZUWlVpTzc3czFH?=
 =?utf-8?B?a1lidXJuMzR6dUNXc21MQVAxTXl5VnRkRnpod1JhNVRJTDMrS3JwYU5QS1Iy?=
 =?utf-8?B?eDlBUVhmR0hHRUhjajk4OU50eVVOaVZXNW9FMWltZnRHOGZIbkpjRy9IV2Iv?=
 =?utf-8?B?MlgwZit0SlRuVkp6cUxjb1ZvODFXN1JrSk1ZYVIwWGJ6b0lmbE5tZ1VQVVJ1?=
 =?utf-8?B?NWxWSno5RzJOQ0twNmxhbThkTHE3aXhMZmMraVdWNEVnQkY4MzUvaWlLR1Iz?=
 =?utf-8?B?MjZVVTNwaTFJQXVQdXUwdGFWSUJTNUhXZVl4emcxYWp4WFg2ekovR3RqbkRh?=
 =?utf-8?B?RmM5TWp4TE5YbHdQSHBHQTlxRTd6dGZMT2lLbjhqNWRRMG8wam16Y0UwYVdD?=
 =?utf-8?B?NDVRTFFUNm4xL0NyM2xoZm5ScFhoVFNjaTdaYUhpMVJJYXM1TXk0aHYrMUpZ?=
 =?utf-8?B?NURCT20vbmZoY2c5WktlOFkrdFhMM1pEQ2J1UDQ5U2dXS0RnV1BPSHZ3eXRx?=
 =?utf-8?B?eDd0aks2STFHbEtaNnQvTEVmdm1yK0V6S080OXBSVXAxak9RakFWdUpHa1Na?=
 =?utf-8?B?cVZ1RUdmbmI0ekMySzJTdjlyNlJ5bC9LNUtNZnRBT0hCUmw0WnJDejAwbmNh?=
 =?utf-8?B?bERVSHdpOWlWdjhROUdMSjN2N3BPNUs3NHBKaE5Qam9hcFVBY1dTS0c3ZlZj?=
 =?utf-8?B?Nm1BL1ZmVnhUQzVicGh2T2JQb3VWbnA0ZDNmdWExcWhJSDdOSUNOdndBS2xv?=
 =?utf-8?B?TFh0VU5PWmRtdm0reTZWcnB2cWtiZlQxWTBUY3h3ZExOMmN5Sk1PRUF6Ukxp?=
 =?utf-8?B?SlRETnk3OUxMNWVMRFk5RGtZUmE2cFdiQUc2S0lSL2JQUUJJaDlHRFlZa3g0?=
 =?utf-8?B?NDVVdXZWSCtDbzlVdlBvYTIrWUlFVnZMa3VVVkpKenB5a1diQndON1Bwbzh2?=
 =?utf-8?B?ckRlQnBITTkzZUMzTmJtQjRmbG1ScXYwcjVCbjY2K1BDQXJNYzh0cUUrN1lw?=
 =?utf-8?B?aTVIdllqeCtlMUZVZURVeEc4cHFKM255NU9qNHF5UVVPakpoaEgzUFlDZlk5?=
 =?utf-8?B?L2xtbVovQUl4cDY2Q1B2NUpCb1lKQzFwM2M2S1hyUzRWbTVZcGp4TkhBODQr?=
 =?utf-8?B?ZUw0QVMxbUZOWW5iQlpHM25lS2c2MzRYUXE0SVVjeXVtMlA3RXJxQ0FnenVH?=
 =?utf-8?B?OTRpM1Y4SXkzVnZqU2FHL3NpZ2RuMGFkVmlMN3llTjJka3I0WkJ0a1hBTDVo?=
 =?utf-8?B?UWhMMHNFSm5VUU1UZTA1WHp6ZUVuYTJRb2xNWUdiVUlNRFBQYmdWRlV2SS8w?=
 =?utf-8?B?T1RxdG9Oc2Rxb01BYzhsSjQ3Zm9LempCcE5FbE9MSWhodWMrODQ0aGJZSGVE?=
 =?utf-8?B?SGVsKzM5cGtxenlTdVl6VWhEemd1UzhUS0NUOWpiY0doVWFvSndpU0tMbkVX?=
 =?utf-8?B?YVhMSkl1Y091SG53Q000cS9rWjBaUnNEM1dieTJHZE1OUFk1UmRvbHM3YkZl?=
 =?utf-8?B?UlIrYkhsbnViajcvRm9aR2ZJUHFmYk5lMzR2c095ZlBCQzVNOXc1eHdwa2hh?=
 =?utf-8?B?VG5tRlVjN1lBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1NnS1FMeExRckpLdGFVVUw5bnpGQ3d2UmxnVTI4ZHR0RVY1dC95RFgyT242?=
 =?utf-8?B?UkZnZC9EdEd0eXhpa3hxR0pTd1luS25VTnJESmlsdCtHbjNYOE50cEVJbXR5?=
 =?utf-8?B?aENlSmZLY3dTQWxnNUJpUWl3cXB2RkFmVE02Q0YxNnZUNmYyYzVBYWhoZFg0?=
 =?utf-8?B?WHNMR2p2OGtSUytETG50ZDIyaTFIcysySVFTZUx2SjZEUGNiVmxZbWhaY0lR?=
 =?utf-8?B?UFd0ZGxqM2FEbGc1S2MzTUZCL0psVHFwZ3UwWCtrTEwxV0lINWFZaHBrekpM?=
 =?utf-8?B?T0VtQ2FvV0crbnlGMllxOElNb2Q4d2s1czVIR0VOSlpUUG9uZTc5Rm1NV01y?=
 =?utf-8?B?NDN2V05jbXo3ZW5Wenoyc3NQeTNyUm9yMHZNeHRzbmF4K0VOanZkN1JNSDNM?=
 =?utf-8?B?dmxSNTFZa1VWT1J4aHBKQ1Jsb2VvZEdtVU1GSmlUWjVNWEhsdU5NSGQ3NU11?=
 =?utf-8?B?dk9hYmx5d1piNzlhNndXTldWbHFib3hLZytqekJiYllXdVpXMzlwQllRMjFS?=
 =?utf-8?B?SGsrNjlCbmtwUFg3aUM5b2pBL0o5N0RpdjFJb1RDNW50WnJJS01USXFUclpL?=
 =?utf-8?B?cDU0OXFCZGNXc1EyTlZESW56OE8vLzdyMGtFcGc2TXJWMGxkTWh1MU5rQ0pk?=
 =?utf-8?B?RGZ0SFdVT0ZuejJBSWlYeld1VzZBNU1uYkI3ZS92ME9kUjdZVm5sOWtPY215?=
 =?utf-8?B?SWxoNTZLZzJGcGZEQUZxU0ZuR0tYUFllcVcvMjVwOW1EelFQcVcrYlFtOHNz?=
 =?utf-8?B?dEFnUUMzUlVuTkJFUi8rRkJpTFNKdktRQmRGaVR0dTZDV05LZlo4SGxrK1VL?=
 =?utf-8?B?UFEzRnJFWGlVUmFzc3pncHJadlVoQWZGUE81eURYQXdkUG04VkNXeVlvUFRs?=
 =?utf-8?B?TS9SU1FJRjBodVhOTVp5RWNvS2hZbjZidzNIaVdMZ0JSVGppcjV1WlhiZ0VK?=
 =?utf-8?B?L2Q4Sk9aUUVLZWNDNWk2Sk1iUWZZTXNGYlpmVm9wRWo4RXJPQmgzTStSOU13?=
 =?utf-8?B?eWZpT3dWMXR6MGRhWTVZc0dhUVVZMlN3NC9XblU1aFVqWmM0ZDVNbndIQ2gz?=
 =?utf-8?B?OVlleStxUUN5bHp6UktlVDRLNTRMRGs5WXJHSlYwQi9FNjEzL2xNOTVIMUEr?=
 =?utf-8?B?UjIrdVU3QlVhVEFYckZSbk1Lb0ZYdlZIQWZTb1djejI1MFI4b0lYS0hWT0lO?=
 =?utf-8?B?dWVacDQ5K2EyQytSZUw2MHp3UGhVbnlLcVVmTnZySHNMYXBoSTFYSVhIWGJJ?=
 =?utf-8?B?dDgzNzBwd1FPVjBtbzFYQkJYWlpxSVUxTWVFeEJKcFh2bkdvemY0dHFOVDFR?=
 =?utf-8?B?YTFVdGFPMXBKN011aWljSFdkdkxCdGswdlRBQ0p1aks2VjQ5bVhjSmpUNzJw?=
 =?utf-8?B?YzNWbUE3ZG1QOGh0cXBSZjRReklGeUxtSkdlQzAwdW9pSXk4eHB4OTVNbVJ2?=
 =?utf-8?B?bWN2aWpmd0dPeEo4TUlSTzU3UjlMVEVxNVdTekMrZHdLYmxGV0FRSkVpYWxM?=
 =?utf-8?B?OGRrNm4wQ29iNFVYb3BmQjRYdUM3SWxaY25zd0VweVY3WUE1Vmp5T2VsY0V3?=
 =?utf-8?B?Q2ZpUERGcTBUNlRCVWVrdWZrM0tBanFxUGJLT0krczdQaVBWRlN6RWY2V1pm?=
 =?utf-8?B?SERYbitXK3VOaTQwR1JhdUFuZGY5eXplMTdmQ0pEYzFkMzZZZVZlTVJPNkdz?=
 =?utf-8?B?b0ZUM1daVlRtRm4yMFFHcWw1UlppVjdPY3dZaTNQSnU4UmNnTEdRVm01Sllq?=
 =?utf-8?B?RDBLaHJ0ZmpBckdQRXNjcEJOME5Kdk4raUVtWWZhNG1xSXdLWXlNaTN5Wkp3?=
 =?utf-8?B?cERNU3YzRUVKRTBKV242L2hEZ21FWit2ek8zS1NDMGgxMmlsSmdiQ0xnRXls?=
 =?utf-8?B?eW85aldmZXBpbjl0RzBFTnNoQys0Z1ltMTF6NnI3UHljc05EUkJuYm9MVHdw?=
 =?utf-8?B?WVd6MXR1OVc1RFFMZ2RrNk02N3p5eUlWeTlia2RUcDZ1ZEo0QzJ4QU5yUWdT?=
 =?utf-8?B?blQwTW1NVGp3R1dyeEtjb0hERWhWbEtzZjVER3JNZ3VYTTZTajNnRGdhS0pX?=
 =?utf-8?B?R1FYc1NSaTFqMnFPUk8wVHNpM2czWDJJU05rbTc4ckVwWVZvSmd0azNoOCtl?=
 =?utf-8?Q?QVH7bbsNJZQVs3GCitUHRE5JG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a5cf59d-e035-4de4-dcf0-08dd7e1a636a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 01:43:16.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PGKGWSgR51CncD9qUkoovLcAAyCukyhXLP9c4Cx/022rEc68XCgXU7wPZo6Z9jTEJlGeQkyc6iU6jgBXQMxhfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9282
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

On Wed, Apr 09, 2025 at 06:42:14AM +0000, Alice Guo (OSS) wrote:
>> -----邮件原件-----
>> 发件人: Marek Vasut <marex@denx.de>
>> 发送时间: 2025年4月9日 2:31
>> 收件人: Alice Guo (OSS) <alice.guo@oss.nxp.com>; u-boot@lists.denx.de
>> 抄送: Alice Guo <alice.guo@nxp.com>; Ilias Apalodimas
>> <ilias.apalodimas@linaro.org>; Jaehoon Chung <jh80.chung@samsung.com>;
>> Tom Rini <trini@konsulko.com>
>> 主题: Re: 回复: [EXT] [PATCH] power: regulator: scmi: Move regulator
>> subnode hack to scmi_regulator
>> 
>> On 4/3/25 12:56 PM, Alice Guo (OSS) wrote:
>> >> -----邮件原件-----
>> >> 发件人: Marek Vasut <marex@denx.de>
>> >> 发送时间: 2025年3月22日 9:45
>> >> 收件人: u-boot@lists.denx.de
>> >> 抄送: Marek Vasut <marex@denx.de>; Alice Guo <alice.guo@nxp.com>;
>> Ilias
>> >> Apalodimas <ilias.apalodimas@linaro.org>; Jaehoon Chung
>> >> <jh80.chung@samsung.com>; Tom Rini <trini@konsulko.com>
>> >> 主题: [EXT] [PATCH] power: regulator: scmi: Move regulator subnode hack
>> >> to scmi_regulator
>> >>
>> >> Caution: This is an external email. Please take care when clicking
>> >> links or opening attachments. When in doubt, report the message using
>> >> the 'Report this email' button
>> >>
>> >>
>> >> The current code attempts to bind scmi_voltage_domain to regulator
>> >> subnode of the SCMI protocol node, so scmi_voltage_domain can then
>> >> bind regulators directly to subnodes of its node. This kind of
>> >> behavior should not be in core code, move it into scmi_voltage_domain
>> >> driver code. Let the driver descend into regulator node and bind regulators to
>> its subnodes.
>> >>
>> >> Fixes: 1f213ee4dbf2 ("firmware: scmi: voltage regulator")
>> >> Signed-off-by: Marek Vasut <marex@denx.de>
>> >> ---
>> >> Cc: Alice Guo <alice.guo@nxp.com>
>> >> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> >> Cc: Jaehoon Chung <jh80.chung@samsung.com>
>> >> Cc: Tom Rini <trini@konsulko.com>
>> >> Cc: u-boot@lists.denx.de
>> >> ---
>> >>   drivers/firmware/scmi/scmi_agent-uclass.c | 8 +-------
>> >> drivers/power/regulator/scmi_regulator.c  | 6 ++++++
>> >>   2 files changed, 7 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c
>> >> b/drivers/firmware/scmi/scmi_agent-uclass.c
>> >> index 8c907c3b032..e6e43ae936a 100644
>> >> --- a/drivers/firmware/scmi/scmi_agent-uclass.c
>> >> +++ b/drivers/firmware/scmi/scmi_agent-uclass.c
>> >> @@ -427,14 +427,8 @@ static int scmi_bind_protocols(struct udevice *dev)
>> >>                          break;
>> >>                  case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
>> >>                          if
>> (IS_ENABLED(CONFIG_DM_REGULATOR_SCMI)
>> >> &&
>> >> -                           scmi_protocol_is_supported(dev,
>> protocol_id))
>> >> {
>> >> -                               node = ofnode_find_subnode(node,
>> >> "regulators");
>> >> -                               if (!ofnode_valid(node)) {
>> >> -                                       dev_err(dev, "no
>> regulators
>> >> node\n");
>> >> -                                       return -ENXIO;
>> >> -                               }
>> >> +                           scmi_protocol_is_supported(dev,
>> >> + protocol_id))
>> >>                                  drv =
>> >> DM_DRIVER_GET(scmi_voltage_domain);
>> >> -                       }
>> >>                          break;
>> >>                  default:
>> >>                          break;
>> >> diff --git a/drivers/power/regulator/scmi_regulator.c
>> >> b/drivers/power/regulator/scmi_regulator.c
>> >> index 99f6506f162..2550b27246f 100644
>> >> --- a/drivers/power/regulator/scmi_regulator.c
>> >> +++ b/drivers/power/regulator/scmi_regulator.c
>> >> @@ -178,6 +178,12 @@ static int scmi_regulator_bind(struct udevice *dev)
>> >>          ofnode node;
>> >>          int ret;
>> >>
>> >> +       node = ofnode_find_subnode(node, "regulators");
>> >> +       if (!ofnode_valid(node)) {
>> >> +               dev_err(dev, "no regulators node\n");
>> >> +               return -ENXIO;
>> >> +       }
>> >> +
>> >>          drv = DM_DRIVER_GET(scmi_regulator);
>> >>
>> >>          ofnode_for_each_subnode(node, dev_ofnode(dev)) {
>> >> --
>> >> 2.47.2
>> >
>> > Hi Marek,
>> >
>> > Is there a problem in your patch? Should it be changed like this:
>> What kind of problem ? Can you please elaborate ?
>
>I think that in the scmi_regulator_bind() function, the second parameter passed into ofnode_for_each_subnode() should be the node named "regulators".
>
>static int scmi_regulator_bind(struct udevice *dev)
>{
>	struct driver *drv;
>	ofnode regul_node;
>	ofnode node;
>	int ret;
>
>	regul_node = ofnode_find_subnode(dev_ofnode(dev), "regulators");

Right. I could correct this when apply the patch.

Thanks,
Peng

>	if (!ofnode_valid(regul_node)) {
>		dev_err(dev, "no regulators node\n");
>		return -ENXIO;
>	}
>
>	drv = DM_DRIVER_GET(scmi_regulator);
>
>	ofnode_for_each_subnode(node, regul_node) {
>		ret = device_bind(dev, drv, ofnode_get_name(node),
>				  NULL, node, NULL);
>		if (ret)
>			return ret;
>	}
>
>	return 0;
>}
>
>Best Regards,
>Alice Guo
>
