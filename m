Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1554FE77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 07:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11E4280612;
	Tue,  7 Jan 2025 07:59:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xSuU93jh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 709B6806DC; Tue,  7 Jan 2025 07:59:37 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93591806F4
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 07:59:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XjV5Mnhszc3gzPVOqfRz/xBRPl3aEJa445h3Rac+XB2pXjEESTW1Px67iYFelysCXK2kHiBIhq+bKznScigIEnw9b5bEaxh9hb5Nf+G0bLdR9w8QeAWOzroYbTa+RK1Hwqbc8q3oB43UtM2WC2v+5zOpUSd/3ttdwkhcb6gEGHkpcmJdl/T1e/HZdQZ1k8qz3QtsTRlqaE6Cd8XZeguJYdEmJGnzDc77cm0y8PnQyYlKF5rCBpZKfKQdpsJ/cmRGUtDdmP9W8rRqduEinO5NnzVsvfXlaprkZebIUn+PaI6gqbKkiPswlmMvmiTfgoO77GT1sVFGG6YNpGfQYHv50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2Irmv2G6bQIfjaHWimcIOotb4M8+C3hXknNbgpaEPg=;
 b=QTFY4P4IiGnzAweohASttI/qvbkq0lOKiSS8mxsfx4gD7zZkY6uIuz5nTUOWacBMdeER1EQlpHNXI4/W1XjSRr8zPXxc3p4qbpmun3y3zOZ8W3X+flmInS3WrmKoHRmt3TpPbXBt6p/7fCoLvVrd5+xipei8bhdUr+UgFjHucB0HrcKHVmC1WF1pNs6zpBS8MLaFhXNLEq4FgEL4HUKhRzdbecTJxD6TuY0NqGPnPQsWSbg1zfB9TQtZCgwDy3vp8oVSxbhIRXjTbuMjh5FFlvMHXQ+WDm8DquBNvoxLEXfpFSjgP2tk+MyuJIgqgHpODLXR0up1yxDwsxhSYmHjlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2Irmv2G6bQIfjaHWimcIOotb4M8+C3hXknNbgpaEPg=;
 b=xSuU93jhVIIqwyboWEAUR4p/xKFs704P1lgMTpLOYMMFOgKWdGD/fZFZxnPFIW2QkwIW7KiehDtr/suryWs1UGLRsYFsDtKN8cJVpRKJlvzzSRipkL4YnJtv5WSTbx3wADqeOgbwDUrw484wRwonIJT3WPWfrGloeukHHywkvzzSMgduA0R71CzZgYTlPLRoj/Ng3L492mWf4nz6HZhZ9zf/hYLiENxZ17qFUNbHR0a61FbeF2b/WhfXrYcVQziQSJ9TbmyKAZyqRVtCX+ZncjDbfzftQGLwRt4flwAp9bYTRI1fP3zitmT0Hri03EJf+tuep8R+9730ip/BiwwyjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10523.eurprd04.prod.outlook.com (2603:10a6:150:1d4::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:59:27 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.018; Tue, 7 Jan 2025
 06:59:27 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 07 Jan 2025 16:05:11 +0800
Subject: [PATCH v2 11/16] imx: imx8mm_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-imx-bootstd-v2-11-97671b1694cd@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 220f2c5e-d9dc-4170-26c8-08dd2ee8d3c5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WTgwZDB3MWszOTRkYWpQdDloUFMxRFkvV1IrNkIxV3B0MStXVUl0N29ZNlZk?=
 =?utf-8?B?UUJqMHFFOEh5QUxHTkljL0dNWXBoYUVLNWRrRXQxR1NmbmV0ZTAxN0JRRTda?=
 =?utf-8?B?a0pGTW5nK0ZKS0JmOFplVDdXSE4zOWJONlRTUTB0eHBQUFdVMGZhaVJ3dTFr?=
 =?utf-8?B?Y0Q5am1oSkoxWDhEeWp2dTlvVVNUYXYybW9hL2UwU0h4M0h0dE50VzhtMmRD?=
 =?utf-8?B?VzNaeXdOQVpQSWplckpCeG5hdWZENWVHSzhpK3U5MnVkZlh6bkt4d2dxRExt?=
 =?utf-8?B?bnIraFhNelFoOExBRVNrSnRUV2ZMNGtsUTdhdkJYcDM0UVRLNFozTGtRM3JQ?=
 =?utf-8?B?SVlJdFlRbW0xRU8wMjc2S3Q0T3J6WDk2anNBcGQ3RGVhWTU5QmF1MlhhdTdn?=
 =?utf-8?B?c2NqYkZJb0E3VHAvYXkwM0FFaHhmZk1ZUmoyK3BIZmk5d1hxWXZBWGxjd2Vl?=
 =?utf-8?B?NDdUUGp6WUFibW1zMERxYVBsWHFjckxVZEs0WkM1azVRUUdqRGtRbG92SGNZ?=
 =?utf-8?B?VWxmQnUvR0g4cFdMV0U3OFBuTTN4RFVucnJsaS9qZkM2eE11SFN6NlZrSEpT?=
 =?utf-8?B?emdLVVIxNXE3Ym1ya2UxMDRuYk5EZy94azU4bkVYbkpZMlZEQWJQUXB0dVhN?=
 =?utf-8?B?UFlNUStTb0UzalBPQlk5VEl0enB6aXJJanBvcjBhTTNxNHlKV0VUbFhVWksv?=
 =?utf-8?B?cnVCRHZMU00waGNPQW5NallVSHNUdFpLZTZsaVdCY2pvamhWaWxzamlzcWMy?=
 =?utf-8?B?VmVHMGFSRUd5ZnRSY3d3UDNZV3RIZnVsNHhLYjJtanhSRnNwRklncFVIek00?=
 =?utf-8?B?aFBwSWJVN0VDL0JQSDM3cTRVNzJXSnJuZEpsajdKMUMyMi9neGJpV1IvNFUx?=
 =?utf-8?B?Z2dheHNOODh0c296M1VTSVZLMWI3blZXYWl2NmI0akMvVWdDVGJueHpiYjhU?=
 =?utf-8?B?SURWemlLM3I2QzR5djVNS3JYNGF2OTdLN2szOVA3aU5uSmdhcksxaEJxUWgr?=
 =?utf-8?B?QXdHUzYyVkxHQ2IySnR2ZXJMcEVGdTR3NFBXNytBNFFOWXJsUmtiT2R0S0k0?=
 =?utf-8?B?VlRqMGRlajAzeWI2dWF3VDlzd0dCdzVCZnZxdnoxVlVaWUduWHVQTFlEb3Nk?=
 =?utf-8?B?OHNUa0p0ZUY1ZlE5ZVl5N1NnVHN6a0JuYVl0cHRpTUozVDdUZ094SEJLWVRv?=
 =?utf-8?B?eHA2bmFRTUlBOHRGMk10Y2JVcHVUeHR3N1FON0pQamRlNzlsWmc3R3E2VUdK?=
 =?utf-8?B?ZllIUHFhNTJ0c0RONWJuTmxsTTB5YU8wM2QrSEtob2ExbjgySU01eERwMTNj?=
 =?utf-8?B?WEhLUXZiK25icUVZQlN1Y1kzb3oyUjRsQXA1Q0pEMDc4NTI4MktBSnYyQ3Z1?=
 =?utf-8?B?S1lRTTZPWUJucmYwU1FZOHExdEhwYW02Tm0vcXEyWGZsdmJBVGZXa2lkam5u?=
 =?utf-8?B?TGhCd1FMVTU4NndzeEhrYjV2M0hLdU1tODR5aVZ3YTdUQ3MvVjJIWmI0TDl6?=
 =?utf-8?B?eWVZd0grOEducng3Y2pIUWlEWlNUWU5kNHdXK3NVZkl4S0FXTncyamRsUGxw?=
 =?utf-8?B?N21rMlpiaU0xc2Ewd2ZXM2JOajZqRlFVUVRwbjBMOFh2QS9ZaHFZUElNa3Y2?=
 =?utf-8?B?VHFqOXR1VUl0bFZkNlErTS9VLzhzRHZEZHBhU0RCTXlFQWhicXdHOTZ0SFk4?=
 =?utf-8?B?VFc4Q0pSVXZwTHozbUlDYmFsYWxOVHJJV1hiYlYwUzRrSGhhM2pqeHcwbURL?=
 =?utf-8?B?N3BtUDFPRHVvM3AyQWZDWnFGVXdnNkZoNDcyRWt4b0djeS9UOVVJcE42S0Ex?=
 =?utf-8?B?VlN2RHpWeHhRbWZQSVE0d2hIVEF1TEVnRCt6L1lZNEZzUDByZFdZbytoemdW?=
 =?utf-8?B?TlhzVlZ4Zm5zUHd6RWJSd1dtTVpDRnU1aFQ1Qzh1ZStmZWZKUlA1RzlQL2pi?=
 =?utf-8?Q?Z6Gfbx3uNrsGDCoBya3c4iLT3y7FHU4Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTFNYVFBczUyTHEwOWI1SVBZNkNwRWhjY0NuRWVYRHkzRUpBQ3JPZFN6Q3FU?=
 =?utf-8?B?T1lHb1krR1hoOVNFeUpGNHZ6b01hUWNyVGV5Q2xHU3hxVStvQlJrbTk4d05N?=
 =?utf-8?B?YWEycWhTeERiUDJMM3JrK2RIVzJ1MGNMUzllUnlqV08vNkhLeHpXSjJoNWU5?=
 =?utf-8?B?TElIcmllU1NjdXU2QkVwVWw4eG1oa0FVRVhNN2J3aUg2RC9hMkRLVjF0a3dD?=
 =?utf-8?B?Qm85RU9aMUhmWURTdFJFa3NQN0E3LzZwNzN4TUhjTENCU3FucnJyQUdwMFlh?=
 =?utf-8?B?OVVIR3dvaUM3N3pOaldGUlptNlpuQUFLbjhudjlaT1MxcnVjWWJ1R3lTdTNn?=
 =?utf-8?B?MFo4ZTlsdDZTWFcrZm4vSGxnejdCV0xoYnBCb251anRqaWxmZS81MUFldk4x?=
 =?utf-8?B?THNhRk5WeTMyTlZ3RVBmZ1c0cTVXSmpIUlljNzdGMUwwWngxNTdmNyttSDhp?=
 =?utf-8?B?RGlTYThpSlBKcUs4aVowYzRXWTFSdTNFaDBlU3BtUTRpR3M3RklxNmYwd0Z0?=
 =?utf-8?B?R3FqS1VpZ096UUZmSW1Vcm1SUjVLT29ja3NYS2hVbEtKaWZ0dEYrc25rTzFT?=
 =?utf-8?B?cGtjMmQxYU9JYjVWM1d1SE4wTS8ySlF1VHdYR2dYanBINUNOVmxPWi83Z0ta?=
 =?utf-8?B?aldUVFVjaE44MFpEakkwQ1NGS1pZMXBDWGo1ZnBSb0ZYRzVvWEM3cmtJaGdZ?=
 =?utf-8?B?WkI1NUxNd0VaUEE0TUxjUkQ3Y0RZeVZpeWM4TUxOMlhoMHdzWG9Wa3lQRkEy?=
 =?utf-8?B?MGVRN2s0V3RGT0FBWXBmZStFK1FLdnZoa21NQnh6aUxrcnJDbnlzL0JiN3Q0?=
 =?utf-8?B?YWR3bkhjeTUrQTlBdFoyUDBGbFM0TGZ6MC9UVE1lNnZmcDV2NUw0bEllYVRw?=
 =?utf-8?B?VEpGenRjSFFqY2J2WEE4U3V0RWNuMjJFcmppQU5UV0h4ZVVWK0xtckxaV3Qw?=
 =?utf-8?B?TWxWK3RYSDJ2OFJTQml0RjFWT01Pemk1Q2F4Nmx6SnRvMTREcGI5Q3kva2kr?=
 =?utf-8?B?ZWVIV0JkVklXa1VHZy9iQS84T25Sb3FRS09wY01KUWRmUVlCc3NmN2lydEov?=
 =?utf-8?B?SFhwZzRDRk82TytnRi9TZ0V2eWdqdGNZS0dzUDNIZlN6MlZIdE1OQmZuN1dV?=
 =?utf-8?B?TFBhUGY4TWUvQzlYT3IrNUJFT21sL29VTCtvZGlnOHJobzc2blptbWRlV05y?=
 =?utf-8?B?TXJjN2t3ZXdRN2hkVnJFdUs1SHNJeVlpUkkvMW1Qam9vWkk4aU4vbndGZGZT?=
 =?utf-8?B?ektKUW5BSWpWSnRYQnFlcHdMRU5HOEx0b2lxc0d1Mmd2UlRnUEl0UGtBby90?=
 =?utf-8?B?L2pDTjBFbytNMWFlcXJBZ1RMaUkvdlkyS1NtQld4TFp6T2UzRHlqWk5Wdkw3?=
 =?utf-8?B?T08wSVltK05NTlFvaGJxcjNXdytDMXpvaEFrUVpHaDN6bXY0NHdKUnpYV1pC?=
 =?utf-8?B?WGp4RGIzWW4zaUVWNVVaZ1ZSWWp3Q2RrSXlNcTBTbHZUcTk4bEhJQzdUZ2Y2?=
 =?utf-8?B?TWZPZjJLN2E3aUtIQTBwT1lacm5tWE1BYTBuOFQ4bGNDUXZ0cFd0bGNMYjhm?=
 =?utf-8?B?blVlaC84Z0dhYUJFNFBFbFkyNWxWdXVoeHVFQWxZRjlKWjg1d1pOQUlsalVm?=
 =?utf-8?B?bC95Uk1RSWorQmovdVppejBNbzgrRHhhSk50T1lHa0NGUU8wMlJVYTZmMHor?=
 =?utf-8?B?UkNZakNmOUEzRnF5eGh2KzVvQ1FHNmtxbGNTMm1YYkZsejA1b01Va0E3YXBW?=
 =?utf-8?B?MFdYY25rK3N0dlEvZjZ3dUxsUWJWZFBsUHd4UTN6Qk5UR1dPbE1XWXpocFFS?=
 =?utf-8?B?dWNSSUlVdEh4em0xOUhicW1zb1NWR0NPZEN6MWhvUHEvR3lCV2hoUE5tc0Fx?=
 =?utf-8?B?dmxHK3NoK002dUh0RUkrRU1UMkFaQ3RSMXQxOEJsaEo0OE1WekYyU0tZcDVn?=
 =?utf-8?B?OFJOZHd5NU8ycWNVOEtnOFZuUGdlVmFGOHQ2b1dEa0VhN1RRdW9OSEVaaWNk?=
 =?utf-8?B?K1R0NmZ0Zndqb3VyS3l5UXNpbEVzS3JGVEs1cVlMMmRES1JWdkZFb2NsSEZk?=
 =?utf-8?B?eGRHQkZ2NVZ0bklKbkdlSnJSYjMzMGZiLzRqcUt4Y0ZPZVlPMzN0L2c1QlVF?=
 =?utf-8?Q?3QB2EIhmI3QtHhQyAwwDT9M5B?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 220f2c5e-d9dc-4170-26c8-08dd2ee8d3c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:59:27.8131 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qOPo2JhvHJHj8ctSURJUejSFSCnpjuiwAvW0bO9pZQU2m51cmmZj2Otfp+Vh9NMPRImRPheAKWH6XshMAdLiQA==
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

Move env to imx8mm_evk.env
Switch to support BOOTSTD with a bsp bootcmd as fallback.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig           |  4 ++
 board/freescale/imx8mm_evk/imx8mm_evk.env | 67 +++++++++++++++++++++++++++++++
 configs/imx8mm_evk_defconfig              |  3 +-
 configs/imx8mm_evk_fspi_defconfig         |  4 +-
 include/configs/imx8mm_evk.h              | 22 ----------
 5 files changed, 76 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 0cf3c1baffeecc5d7475e6f7b8d77539aa9646a2..28be6a22bf07e1341ec841bace149cdbb871fac0 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -154,6 +154,8 @@ config TARGET_IMX8MN_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MN_DDR4_EVK
 	bool "imx8mn DDR4 EVK board"
@@ -163,6 +165,8 @@ config TARGET_IMX8MN_DDR4_EVK
 	select FSL_CAAM
 	select SPL_CRYPTO if SPL
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX8MN_VENICE
 	bool "Support Gateworks Venice iMX8M Nano module"
diff --git a/board/freescale/imx8mm_evk/imx8mm_evk.env b/board/freescale/imx8mm_evk/imx8mm_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..29690e75b15aa7c3eb93bd918d42a4d124dde7b6
--- /dev/null
+++ b/board/freescale/imx8mm_evk/imx8mm_evk.env
@@ -0,0 +1,67 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_fdt=try
+boot_fit=no
+boot_targets=mmc1 mmc2 dhcp
+bootm_size=0x10000000
+console=ttymxc1,115200
+fdt_addr_r=0x48000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+fdtoverlay_addr_r=0x49000000
+initrd_addr=0x48080000
+image=Image
+ip_dyn=yes
+kernel_addr_r=0x42000000
+loadaddr=CONFIG_SYS_LOAD_ADDR
+mmcautodetect=yes
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+prepare_mcore=setenv mcore_clk clk-imx8mm.mcore_booted;
+pxefile_addr_r=0x40100000
+ramdisk_addr_r=0x48080000
+scriptaddr=0x40000000
+
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx8mn.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+mmcboot=echo Booting from mmc ...;
+	run mmcargs;
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if run loadfdt; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	${get_cmd} ${loadaddr} ${image};
+	if test ${boot_fit} = yes || test ${boot_fit} = try; then
+		bootm ${loadaddr};
+	else
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			booti ${loadaddr} - ${fdt_addr_r};
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadimage; then
+			run mmcboot;
+		else
+			run netboot;
+		fi;
+	fi;
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index 90757100c72877d961d3a110e5293c9248c790b7..2c583c4157111cfed8e467cde39be6c9582ac26b 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -24,8 +24,9 @@ CONFIG_SPL=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/configs/imx8mm_evk_fspi_defconfig b/configs/imx8mm_evk_fspi_defconfig
index fb4a4421cf04c3e0f2cee10f1f7689227f44dfd0..af49b82c74cddb0b548b9970af2289e3de320060 100644
--- a/configs/imx8mm_evk_fspi_defconfig
+++ b/configs/imx8mm_evk_fspi_defconfig
@@ -5,6 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x2000000
 CONFIG_SPL_GPIO=y
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx8mn_evk"
 CONFIG_SF_DEFAULT_SPEED=40000000
 CONFIG_SF_DEFAULT_MODE=0
 CONFIG_ENV_SIZE=0x1000
@@ -27,8 +28,9 @@ CONFIG_SPL=y
 CONFIG_FIT=y
 CONFIG_FIT_EXTERNAL_OFFSET=0x3000
 CONFIG_SPL_LOAD_FIT=y
-CONFIG_DISTRO_DEFAULTS=y
 CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx8mp-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
 CONFIG_BOARD_LATE_INIT=y
diff --git a/include/configs/imx8mm_evk.h b/include/configs/imx8mm_evk.h
index 3bbbd900dd439a93af62cbcb9c95d03b012fee86..957d9c05083f10534467fcd7b3a5f8d7f1fd4b4a 100644
--- a/include/configs/imx8mm_evk.h
+++ b/include/configs/imx8mm_evk.h
@@ -29,28 +29,6 @@
 
 #endif
 
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 1) \
-	func(MMC, mmc, 2) \
-	func(DHCP, dhcp, na)
-
-#include <config_distro_bootcmd.h>
-
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"console=ttymxc1,115200\0" \
-	"fdt_addr_r=0x43000000\0"			\
-	"boot_fit=no\0" \
-	"fdtfile=imx8mm-evk.dtb\0" \
-	"initrd_addr=0x43800000\0"		\
-	"bootm_size=0x10000000\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x40000000

-- 
2.35.3

