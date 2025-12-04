Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68E11D1F9DC
	for <u-boot@archiver.kernel.org>; Thu,  4 Dec 2025 12:52:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96D6F84034;
	Thu,  4 Dec 2025 13:52:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="NAvXbb/m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0528583CD2; Thu,  4 Dec 2025 08:12:24 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADC1C83AC6
 for <u-boot@lists.denx.de>; Thu,  4 Dec 2025 08:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN2J98rz9ax22O9ks2yq4VhLug5LyFbQb2hTcqbALaB3MnawqYk2WgRO6bo2hR+5UMX9/+/tLKUE7olVmrT6ZCverVIMCigxBickh/jSaYeKXiBrQ3ptzKMO9YnAFMtEvwDnadK8RoopS9PSDjiTiQ2zwarJvZ/rYq0IxgbfbRv+mRS2iuZi7thh/IOSNA3moUCMJZyeqDDCFUgItRWMcqmTp1K0tfVqK60y/uxRXR5T0aCH94gZ0mHELIVFXziAheaQCBOQhgfzNE5aeLrp6xShWmVX+SnkAvukF0nRwICPMnM17/NVMmBitaPbUrA+ZQExcxgtragl0oV2ormniA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qvUvSeN4f3Fzu6aw00WafqXmNjVh/sEzQN4ObfJV9I=;
 b=qPZFY/ym8PnslRvxVNtfMN0fMRF5mbbu8lc82jFcB7ABT/yPPM1wD5UIV6fCK+OSixkm1pGUpVf0zCqSiUObBK0ufswW49CoM55pE6Md5soqRZSrdH1eX1DoHOECOLSt1nrg1QzOY4QAydoNh8bjotLfQ9JREAnK+Vop96N48UI64O9fnC0rQKtPjRo5rRJp1IiJTm8YOh7QX/QLpXMANpgoxD9jpa/XhahIEHjpBObkMYyAv2B2M3NbeaSsODJUwtMmPS4ucehCBCuFrZGYGyvxHgN+ppIW3lIIY3SwCx/JpFnM7QjzD75b8ugxz+3Fwap2N9/8y2oWNYhgkgSIWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4qvUvSeN4f3Fzu6aw00WafqXmNjVh/sEzQN4ObfJV9I=;
 b=NAvXbb/m5GHk+c7gLNvmWgC4y7OYEzeRM5ou6VHFGwvp4lkd1T+80AeH7j6BWdd2oyQ5WLD06oyTOWcjetg520WLICSzftf4PAtaSBr8tTNzWwGEv+V2rTpJvwQ9jUkgVKHJI5+KxAiur80Hr4x7Py/TcIxMWIb+5hZhmk7hY1yszVFU16pK2UoyF6RuIb1M8uYslvEWdjNBubPLS8Iek8halcbMoEEdmx+d7C29jipwHetbSHkZLPtjMxC1ZTfL4daYN5ke7C1dwmpO82IYVolQsBfGltn79ZhGmL2M4xuGbJO41jj3WF9Lb6reYGN/rVw93a+CGvqUirLlRT6UjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com (2603:10a6:501:97::14)
 by DU4PR04MB12109.eurprd04.prod.outlook.com (2603:10a6:10:643::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Thu, 4 Dec
 2025 07:12:19 +0000
Received: from MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43]) by MRWPR04MB12117.eurprd04.prod.outlook.com
 ([fe80::9a10:5b39:708:7f43%6]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 07:12:19 +0000
Message-ID: <93024512-1ab0-4fdd-aed0-f52849528c21@oss.nxp.com>
Date: Thu, 4 Dec 2025 15:12:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v2 2/2] imx: Support i.MX91 11x11 FRDM board
To: Fabio Estevam <festevam@gmail.com>, Joseph Guo <qijian.guo@nxp.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Ye Li <ye.li@nxp.com>, Alice Guo <alice.guo@nxp.com>,
 Adam Ford <aford173@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Mathieu Dubois-Briand
 <mathieu.dubois-briand@bootlin.com>, Francesco Valla <francesco@valla.it>,
 Jacky Bai <ping.bai@nxp.com>, Justin Jiang <justin.jiang@nxp.com>
References: <20251202-imx91_frdm-v2-0-992b8aa99375@nxp.com>
 <20251202-imx91_frdm-v2-2-992b8aa99375@nxp.com>
 <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
Content-Language: en-US
From: "Joseph Guo (OSS)" <qijian.guo@oss.nxp.com>
In-Reply-To: <CAOMZO5Bu6735Rb=CfwBMeiJdStqx6ATZVQU9=-EngzkK2qhVng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To MRWPR04MB12117.eurprd04.prod.outlook.com
 (2603:10a6:501:97::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12117:EE_|DU4PR04MB12109:EE_
X-MS-Office365-Filtering-Correlation-Id: 49a7805c-9b6a-4e39-4b19-08de33047689
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UE1WRjVJTlNiREw1OUordnVteEg0MlZ0MExkZkpPM0JwOGpDc3VQM1RsZk5C?=
 =?utf-8?B?VXVMVGQvcUNXcjdDMFUvZXZQNE9mblF6TkVxc3pWR2gzRDk0cUNTMHpReFJ4?=
 =?utf-8?B?aERvVFJPdkFqMkdwMWtlanhjSzMrYk0xM2tCTmNoTXA0Z1pMTGdpdEYxbmY5?=
 =?utf-8?B?ZHRCZG1lYjE1c2h0dzg1SzN6V3M1T3lYdHBhbGlmdmw2TnVLTFROM29aNlBW?=
 =?utf-8?B?aUdGeDlvT2wyejI3VXpOdW8vK3I3SUFlWSt1NzhOZGJEcUF1OFRlS2JKNUd6?=
 =?utf-8?B?WWFiKzZrUzNnWDVLREV2UHFrNU9MTzUwL1NWUUhPdFZaV2Z6eGVSRFRpTDdz?=
 =?utf-8?B?a0ltSjRGay8wNzNKOTVLRGdFVzNtTDIrUGNBR0oxSGlhbFFFTkhPNTQ4QmFa?=
 =?utf-8?B?dHpnV1Z2L1AyNVhkV2Z0ZVFjSC9objJtdkdvYloyT3JncldqMTJiUHd0MlVW?=
 =?utf-8?B?ZUlISDJBVklUcDVJR1lxZnVZZ3lITTd4SldDQlVBejhFYmlVUnQyVGNJTVhn?=
 =?utf-8?B?N1dkWEVCNVpoNlNvWko4d0tsZ3k3ZCtmRFhpMlFLU01FUzJTTU43SUJTQThU?=
 =?utf-8?B?RVhuZmNrVTJhTkVIWHJWZHlLbEUySjdvNm1raG9KYys2RGVuZERSb0ZSTVVp?=
 =?utf-8?B?emVGWCt2ODJwbzhsRzBWNFVXbHVGaU14bjNSMUdMVzl3OVo0RWZOYnlPRWZR?=
 =?utf-8?B?d2xNUjYyaGc2WU16bkVBZXZ3dGtzUWVQLzdMME1ySFlMMmw0Lzc3a0gzUm9Z?=
 =?utf-8?B?Tmo0ODJ3RlV2dUxLS0ZOWi9QODY5MGlUc2RsUkJseTBOTXFlQm5KVGEwLzRN?=
 =?utf-8?B?T2V0THlMNW90V3BOMFdzM2w5aU8vUEQvcWJoaFdzcjNpMDdHTVZYcm5kc1Mz?=
 =?utf-8?B?NkkzVTNqZEZzNHgzc0N0cmlEd253bm85MW1rRTY4MjdvY3JpeDRHQkVMU1M2?=
 =?utf-8?B?dVFOQnFucHU4WUsyNEpTa1o0TzRqZ0s2YnBvNGh4NmtkNUVraXpQd2hDY2JG?=
 =?utf-8?B?YjVBVHpFakJiaHhPdXJWdXBBNEwzTEdMMmZHK0hHOUw0Qk8xZXFWOGF0eElh?=
 =?utf-8?B?cldjNUdNc0NQdUVCS2x4bWNOS0VhVURLaHErdk1VUGQ5K0FmRzN3N3JNbEJT?=
 =?utf-8?B?alpnc1orQjNsKzFnVjVJc1FxUFNIU2J5bUIvQjJibXFvb0xHcmlJT051dUlp?=
 =?utf-8?B?YW1XM21XY1QrZUN6MjNyZmN6R25mMUhBUVBOdXQrRkR2N3NtVDFwZm51MlJH?=
 =?utf-8?B?d0hUOUVyZWJFaW15UnNkVHd3SDR4NGZocXVYTEhTVjNsaTZHVW5aU0hrakg1?=
 =?utf-8?B?UlB4alI4b1JncnQ5NUxhbTZqMEZHMDN4Z1VmUUVXTytLbW9FSTRlTVhQN2pD?=
 =?utf-8?B?Z0twR0NRT1NoOW5oN1R1LzhPNVdRN0FlUll6VUFQTm13VHJFQytkWStvVHlG?=
 =?utf-8?B?VzJTTmpVSkR0RkhEL2QwdVExZVl4MXpnVitkT1JMeWRNdHY5T3pzakFaalVx?=
 =?utf-8?B?UXVVVmZFb1ZobitVQ0UzS0JHNWtnd1NLbUszMi9qZFZSaHdIVTV1OHRRelBT?=
 =?utf-8?B?UWVsVTBZOGlqamR6bmQ5U3NvSDFVcFlFRlBWOExkaE5UK1VWY05rRit0OFl4?=
 =?utf-8?B?bStJQUtLUjIvWTQ2Y0ZQVzVUb1RYSU80Nm02SkEreE52S2ZXcE01WHdrNG4z?=
 =?utf-8?B?VW5HVXpVS01OdXprUWQzMlBoRW9VMUx6YVNOTi9oUlpBQ3IzV2ZSYnJtYXFs?=
 =?utf-8?B?ZWZDbTZHbkg4akloV2lQVVR6ZzNHcVYwcjV6ZXBoZ0dvRHpCandHdWlxc3dN?=
 =?utf-8?B?RmtuNDJWRDFCWG5uOEFTbXkvZzRHeTE5NHdISGhSMjlabFoySzdrTElEbVB1?=
 =?utf-8?B?eTkvNnRlV2F4SzlFQmhrUmpNU3YwV3BzMlFPY25RaTFDUktJakJsT3M5c1o2?=
 =?utf-8?Q?iRuUboiiG9wlg0P+Rpq4IfRySKdn5T+d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12117.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVNBMjI2elY1Q3pKaWFMd3hMSS8xTEVXbmFtS2t4N09lNUs0MnFYbUZWa2ly?=
 =?utf-8?B?TS9ERlVIT210VWErWE5Yd3dnMUVIVFB6NXJRVzhzWUxRaHhGcnhnYnRKK1JK?=
 =?utf-8?B?Qld5Y2YwMlZzYUxUNGJlSGJBWm0rMGpjSTBqMDUrTEV1MXJUTFhUclNCYXFB?=
 =?utf-8?B?RlpCaTRHK01DOXBWbXNkbTFqVERGeStleXpCVGkvb3hLaDlzYjBXOU03d0tB?=
 =?utf-8?B?WWI1ZGExVXFQdzVIdUpkeXZockw4cnRLNGVYd2pNQUljQ0ZpdEdKZjdmcUVI?=
 =?utf-8?B?MWdzOTBzS2lsaExQOXpxK1I3Rko2a21CMk43Vk9wMmJIOEVpU3E3ZDhGR0VD?=
 =?utf-8?B?UlNHT0RoV1o0cTcyQjg1R1AzSjZ6WTlSWnZPcjE5aXBDT3UxV0laNlNYd0VG?=
 =?utf-8?B?MHdMdCtyR0pnUE5SNFJkRkRCanlSZi9YRnV1ejZ0b2NQS1N5SEtlUUMxUk93?=
 =?utf-8?B?QVh6WGQvRDAvL0tralB4L3pGeEYwZkJCZzZsUUtYYVl6RkxqZ2NBUUNUQ1hN?=
 =?utf-8?B?TFpNU05jVG1sWUhmWndEN0dNZmphL293OWI5WG1od3RTckZLRFZTaGN4djB4?=
 =?utf-8?B?NkhBUDBQRlpMWU8zWXJwc0VNM2R2ZVRwVWlwUXlLcU9sT1o5M2U0eE9MMXF3?=
 =?utf-8?B?OTFXeVgySUtublJDb2dqelQ5U0dwa0FGdDVHbUhzL05XYXgrZlFJQzh6b280?=
 =?utf-8?B?bGNETHdkODZIMlBiMFJLRVhqaWcxbjhqYVQxVXhkZ0RPTXIrUFd5MThLM1lQ?=
 =?utf-8?B?VnR6cERJZWFnL0NlL1pZakRwTXlFOEcrbVY1aUl1bjh2cmsxeC9XWkZFK3BK?=
 =?utf-8?B?NGVaVW1CeVQxd2hGVS9PTFhTT1BYS0Y2WFlnais1YXN0ZDJ5Rmh2WTJFQnZQ?=
 =?utf-8?B?dFFEak80SGpFZUhvQmdEczZKb3JoNlJzbGJTQlJuUHhFaE5UU0htODJJb0E0?=
 =?utf-8?B?Q0V2Tk0xTlloSWpwdllsRitQNDhqOXlFaVNCc05Vbm4yQjRkeHB6bkJOc29L?=
 =?utf-8?B?Zjd5djN1aUJlbW0rK1Zna3g2T1dYZFM4Sm1uemxidmJxcmtxNjVUbXNmWlpK?=
 =?utf-8?B?Q0J0bTZoRVJvcWExd1ZZaGcxWTFsZS95aE9ueHJtaDZmb1RqejNSbHlpcjN6?=
 =?utf-8?B?d3czeE1pR1UwVXRUZ2tOR2lWOW92bFdEcTlLcFN3ekFUSlE3cHQrMmlNUXpv?=
 =?utf-8?B?ZzRBR0ovZk8zbEEwajZPSm5SczN4MUpsNWd3Q0ZRelRQZTBPN3dwY2l1dWtK?=
 =?utf-8?B?S0lSbldBSlRJUDBiYXB6QW5BZVdDMmtsRXUvNW9UNU03L3NhUlFUNjJBaW5T?=
 =?utf-8?B?amsxb3FsNk9ydnJGMXpORG9rNXhpSjAra20rY2FEVzNtc3dUQWRubU9VOFZF?=
 =?utf-8?B?VVkyL2hIWTJvb1Z3cG5tQlJrazlCNFV1cTA4WWF5TkdXcTRjVnBzeWxEMXVF?=
 =?utf-8?B?cHdaeXpGQnNvckF0TFlwbEIzTVRCSkc4MUZ6NEFONmtxSGZQcWhOWGdGUS9u?=
 =?utf-8?B?Rmh0QUhKSEN3ZnpXaE9WNzlpUkRVNGZKVkhxZWFVWlIwZnRkYUEwaWtuUVdK?=
 =?utf-8?B?cFIxNjJ4dkRESUhxblgwYWZ0eGQ2RG9CZS9nUlV5bXVCaFJYRnNUOXVYTnNF?=
 =?utf-8?B?Nm5FV0hoVVpjKy9QRzhhaUwzRnozbjNrREM2S2x5QnNFUkRUeXVVYThXbzZw?=
 =?utf-8?B?WjBkRitZam9mTHZnNXZYNWwrRWdQSnpnajY4MG9ianE5YzFtaGQrTnB4MUkw?=
 =?utf-8?B?anUrcnphWE5wdnZnVjFHNnJPaVN6UEdkenI1RzhNQTJIbmdvZ1VFN3BMeS9w?=
 =?utf-8?B?dTZuK1NVUmRvNCtvdlBPMEpuUVRaMk9rNFhTMmhxeldMYVVGUVJscmRWbGRE?=
 =?utf-8?B?emIyNEJVVFJkd1lVdGJWQm1BWVBHUlljbDNpUzdNL28zZ1M1Y3ROZEZ5bzRo?=
 =?utf-8?B?cFArZ3NuR2RnTThPK1FraURHbUNQK3Y5V2V3NmpOeTFUTWMvSzVWb0JiKzJj?=
 =?utf-8?B?OTZTZWphMmRLNTVUcUtXQlNjMzlORUZzVlE5ejRHQWFvS3VaZUlMaVg1b0hw?=
 =?utf-8?B?QlVVSXh6VVQvN294WjdZQWRMTHJZaE8rR0FxcmhJdW1BNTg0dDB6NU5WRTk0?=
 =?utf-8?Q?U+wZKZ+XXO5bx6wheuzu+bNYS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49a7805c-9b6a-4e39-4b19-08de33047689
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12117.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 07:12:19.7012 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: el362o8IP+lPOhaOs9Mt314agOp+uFggFSO2ncaxZLXQgenpOaSjT6jfcmDu1igaqYFkvwPAogMRe7LuyyelMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12109
X-Mailman-Approved-At: Thu, 04 Dec 2025 13:52:18 +0100
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



On 12/3/2025 10:27 PM, Fabio Estevam wrote:
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
> 
> 
> On Tue, Dec 2, 2025 at 7:05 AM Joseph Guo <qijian.guo@nxp.com> wrote:
> 
>> +&usdhc2 {
>> +       fsl,signal-voltage-switch-extra-delay-ms = <8>;
> 
> Why does U-Boot need this property? It doesn't exist in Linux,
> 
Hi Fabio,

USDHC2 is for SD card and its initial stage is at u-boot.
The IO voltage switch from 3.3v to 1.8v need extra 8ms time on some 
platform. I also tested without this delay, SD card can work as SD3.0 on 
imx91 frdm platform.

I prefer to remain this to avoid potential risk as 91evk 93evk 93frdm 
all remain this property.

>> +};
>> +
>> +&fec {
>> +       compatible = "fsl,imx91-fec", "fsl,imx93-fec", "fsl,imx8mq-fec";
>> +       phy-reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
>> +       phy-reset-duration = <15>;
>> +       phy-reset-post-delay = <100>;
> 
> Using phy-reset-gpios is considered deprecated.
> 
> The PHY reset GPIO should be described inside the MDIO node.
> 
Ok, will change to main dts MDIO node.
>> +&ethphy1 {
>> +       reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
>> +       reset-assert-us = <15000>;
>> +       reset-deassert-us = <100000>;
> 
> Why is this inside the u-boot.dtsi instead of the main dts?
> 

Can move to main dts.
> 
>> +#define CFG_SYS_SDRAM_BASE     0x80000000
>> +#define PHYS_SDRAM             0x80000000
>> +#define PHYS_SDRAM_SIZE                0x80000000 /* 2GB DDR */
> 
> What about:
> 
> #define PHYS_SDRAM_SIZE   SIZE_2GB
make sense, will change.

Regards,
Joseph
