Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E9B3C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:53:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC58F839DF;
	Thu, 22 Jan 2026 00:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J8IOdEWW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0453283A3B; Thu, 22 Jan 2026 00:53:24 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D72C8313B
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:53:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ci1PeqZJStzPMjv3lN+9LW6dOuqFd5i44eU6o7DKN09nHwqFnnZryffPRE0rEm0aSDkWM/T4fhcrIAPt6wZvCwGCYD7h2OFaiyYal6vRtX2Dk2xZqgtZenNyskhJF7aM9F7+L0B72xttgLG1jLS3KkwwvJdBptgOjcrzDzSSfaXz/it79mCaVbf0Ju/LTTS09zrjTaqxqf7NYGyysudwd0tYN0HTgTQprDqkGmFUD2gCoO1TueaXjSbUKz6866pmMaLU2TCr4CUV/yqqsCxBdrI5tQRmju50kTeSnHlzyT+5WKN3NGQcXso3Flo/xBZjd8jgkbOXcVvn3cviYjsImw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKopw2yh9IzK8/kc8W/5WNe55/f51ne5h4m91j+Q70g=;
 b=Lb1GQNNkJEynxuHhvybi1Qtj08m3vsXcYtSplPOIP1MmlnjB5zR6JqwfaJavb6uCh5NeG3+0Swjni8e7CMuYs4z+KI6AbFUZolkRHynOEN8RKMV60eeaBSUBrldniV9PGk+DjlbQ0qvYyY3ETF0gaicO1mEISIW4FRSSqSm1ZZA2jeiGdxZr0vjL0lNqHex8ywak5zu46ZDhxdqqjLNxigZzorIC4ow3/Bj9sPSFi2nl9hQuHsZ0QHNKqjd6Ohg2I0BwSdRmtxDktbVlYHipxGD08XSt1EsHen5bAL0vaaJclxmG61VMEW1Jq7mTPCWpvbObmOIuhn4SeApRYhHjWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LKopw2yh9IzK8/kc8W/5WNe55/f51ne5h4m91j+Q70g=;
 b=J8IOdEWWPcn4szSlm4T/trj7hLLOomDc9iLG/6/l49fw/SFG6oH0X+6T4tOz6yWZTL2gJfc6J1+IZx7DG3mnmQi2znZm4qjgAMb636xUvB+VHPRig3QB9rXtT8HBVoP03WMmimsSg9c7PoRMBDyveNU3yTrk4UJVYWHnUWZuylo7WJbOuA2zi+dfm244pWDDg7xnxHYogDojUcVAqnDe0DdJRrf75gtqYS9ey+VACW9ZyhIGXb935EfwC8mGEF/zWHOmmoa+oRZEqJJ3TGUPP/fVREAa0/MkCsuTGMf70QMYrW3eRe/lZJsYr0uS8YE3QjPlRi5hWQAkHssU4Cavfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:53:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:53:20 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:53 +0800
Subject: [PATCH 10/12] imx8mq_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-10-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 228d4972-530a-4b8a-33bb-08de59483f3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1BOVkxmK2RyTUlEeEVORTVtTlZPKzlVVytheDR0bkFCSFl2WXp2MXNhWUdD?=
 =?utf-8?B?bGlYaktXd25qanVpYTFLMlRFWDBRMzFvb0ZhdjhOVWpkbXN2RGQvTkdiMDN3?=
 =?utf-8?B?Mm1GcGZ4R21DblZXTVR5dXdxaVM1b1o0MDBGWnhXL2w1VnhHanM1cWI4ZHRG?=
 =?utf-8?B?WVdzbDVVMzUrM1hUZFMwMHVicDhqakhvWU9NQTZObWxlZUtrUkl2QzJsbUN2?=
 =?utf-8?B?M3Y1UUNvaHFzejVDMm1yYzFOdVlPRVUvU0drTDRwRUxQazJWbzQyeWdsbm5B?=
 =?utf-8?B?bWx5RlpJMm5HN2dkREFIMDBYRE9ySnVxZnNJRHhIdjRyMHFTcGptWEp0bzg4?=
 =?utf-8?B?anFYZjl1aXZXZUJSd2dnZXcrcjJYLzN5ckpBWlg5R2dWSmlCUEg2VkpqOE03?=
 =?utf-8?B?amhlZGEybXlCQ1FFajcrZ25IdGhlKzVCY3l5ZTVYdnBtVkUyckpMQ3JZc1R2?=
 =?utf-8?B?QWlHMFZpU1JNd1ByaWNadnBqNlJrb1RsNHEzOTdkdUFwY25aSkx3bmJoU1pX?=
 =?utf-8?B?RmxDdmRkUTVML3hNOHBrZU5UbXdzdERmTUV0MDk3YXplcWRkRWdSNjBIRzJr?=
 =?utf-8?B?UE40S0czbmczdFRIQ2JnemNNL1g2YUVpaUxUWHVYMXlodmxLYmowZUs3cWNx?=
 =?utf-8?B?M1VlRXN1MkJyOVk5M09GdnJmUDV3dDhDWXdUVlo0REwrU3BhMk5YUGhuOWR2?=
 =?utf-8?B?ai9MSnlOMVJ5ZUoxUGUxY0JwL0ROTVJVbC95Mnc0b1o2c1V4MWlqcEVMQzVP?=
 =?utf-8?B?UG5XNExHQTYvVVo1RWFLT1FFbERac3RuV0Y2dEZmb01CLzRQZndkYkZFV2pn?=
 =?utf-8?B?VW1BaWZMNGJBYlRPMDRFZExtRXFSVXRIbVRHQ2czcS9aRW5GdnNoQnVCV29t?=
 =?utf-8?B?VXJVd2VWa1duSGZzb3N3cXNoZGFKRWZPbjl5cFQ1VGh2QXY3cjY4c0E3ando?=
 =?utf-8?B?ZnNFbDJjSXZrSGJKanhKVkhTWjVvVWJieUd1cHFSalBHVkRMSHYxT2tDVzB3?=
 =?utf-8?B?ajZHYUVpNXdsT2hPNy9EcHVBYk1sb3ZvRVFtZWNwb2VhMmlEa3RQa2JFMHd3?=
 =?utf-8?B?WmdyZXRkdWdwNUQ2ajdhMG1VbXdNRnBocXZOS0xVTGZPWXkyOWFydU5xbU9U?=
 =?utf-8?B?SHBrQU1RZjBSdkRxSm1qTDhFTUs3azFmd0ljZkJwQVNaQU5nOXhPK3BPemtM?=
 =?utf-8?B?QnZoZnJzSzhQeEQ1bXJTNFBxaHhwd0t3aG1Xd0JXQm5Fcy9Gb0FRVFIrc25M?=
 =?utf-8?B?b1lxd2JKVUhNZEYydzNuME1TcTYwRlk3UHlNbVNXWDVsa1JUZzY1TGRsaHpo?=
 =?utf-8?B?ZXV0N0ZYOHRQak10ZzJQUXVGVURiM1F5K1hCVFArdDZvbnVIM0dUcXJBOHpC?=
 =?utf-8?B?N1dkUVNydlVKS1ZqOXFKaGJmTHdqcmRNc2FFRWZoeHA4YWxYMC81elU4ME5Q?=
 =?utf-8?B?UWo4NzJyUFR4M3VZQW1nbUJaSGU3OEc3RHFKWHQ3M1Qrb2FYZ3g5SUpmVWV0?=
 =?utf-8?B?Y1d5dmhBVlNvcWhLVXNIWGtaNWErcDZKS2ZEQ0w2ckJEYms2Tkh0b253a2Zk?=
 =?utf-8?B?TUM3MFBkOURZTmhobGgvd2NhNThZNWdSQ2hVWmF4QWNwZnN3QWFVRnBjTHdr?=
 =?utf-8?B?M2ZFd2tXcnFhMGtqSHM4ZWZoYitWTGx1bzdsbmlBeEdpRFg0dVR4QlNSSTR4?=
 =?utf-8?B?cGRDQTdwS215bGgxSE9pTGV3Zng1am1mTEFIL0llcGE2WHUzd0IvdXdrSno2?=
 =?utf-8?B?TFh4QmlRN1dOd1FXMWFoeG5rR0owMWhQRjRPRVN0QnJEWTU5Q3pCYzRFK3Rt?=
 =?utf-8?B?bS9sU3JReDZXRGVEZllQaDFtZm8rUStpbld0M3psU1I0L0xqLzIvSXZ5V292?=
 =?utf-8?B?QWFzdWFyYXlPVHBoNWlJN3Q5V1dIZDQzc2ZkTWc4YnJUeU5EYmlTVVYyLzRi?=
 =?utf-8?B?SCtXOHRPSnFDQlJ4RUdTVXJ3MXZLSzV3QmJNZVhJWm1HeXp6QVhkd3B6dHRE?=
 =?utf-8?B?MXJJNlNLbWhIUVZhVzlFQ2ZSWWNuOXRqQTdzRHkzUituR3BTUzJTVEtUbWww?=
 =?utf-8?B?dDZiWWdIMEw5ckM3WXZ3dzlROUFDenB6RG9NYkJEMmdmMHFaT2RNbEowQU0x?=
 =?utf-8?B?WXVYaGRrVEdjL2NtTkJITmowMXFWbkIxL0lCQ2w0QjNkUG1CcGxwNVg4R0FY?=
 =?utf-8?Q?6azrlvOYfoVdGTiYNFMFbdk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGhuNWQ3b1Q1a2duQjU4K0l0RGQrMGZ2SmJTYlhNMk5tZTRiTUFjdkNzYjNp?=
 =?utf-8?B?WWxBTVpTVzc1Z1k4RGFncFlvN25RRmNWc05IOXNyOVdYRGdDWUlHNzVrVTJz?=
 =?utf-8?B?QkFaSlIydldVZEx2R3Z6QnJnRGszWmQzNnN4UFRJZmR5anh4eUhndTF4YWdp?=
 =?utf-8?B?UTJWS1R5bVgxWjI5TVhuTkxoYUtCSERpaEw1RmNmWS94SXgxeHFFU0JKZnJL?=
 =?utf-8?B?Q2oxQkM3cEdtV3V6TU16QUlwNnhwWXdsaTQ0YnN6bUpYc05mb3ArYzN2U0lJ?=
 =?utf-8?B?L01teERqWHE2K25ZY1lvSVlXeWlzN056V2ZmbFpJWU4rZWp0Q0xlbHhEWUlv?=
 =?utf-8?B?MlZENkVJZklCcVptaHJwUStrbUFvRFgwa3dpbmVqV2x5T1pFQ1ZBenVXVXB1?=
 =?utf-8?B?T1BVZWRucTFyMUxhRzhtMDYvZS9VYXJZOTg3ODR6UHMvUEVWODNGUlRRWEpJ?=
 =?utf-8?B?OEdSRUU2aVJwa1ptYnJpaVpUV2d5RHQ2UGV2QkxWc1ZPRWFxdDFuL051MThR?=
 =?utf-8?B?ZnVnWW1DUTgweStWRzdQYlRYa0RtcHhKNkxCNGtSQmhvQ3c0VVQ1cVdLWnV2?=
 =?utf-8?B?czhpUjlZMXNjRU92UFM0WFZCbXJia0k3MTBDTGlTS2hCeTZoKytjVnJsakZ0?=
 =?utf-8?B?bC9RemZ2UWM0TVVmaVBqMWFUNnBOUEFQOHVTaSsvTEFVcWJHMzN2S1FKd3N0?=
 =?utf-8?B?ZXZPOHpVUzNhRCsxVGhwcVBaanlFeUEzRlprOXZ6ejloUlBBdEpaeXRJeENv?=
 =?utf-8?B?cTN4TytRWllTWmMxYkhHSVNnK2g4ZDVsTHp5WTlBdUg3WUFVRjFhTFlGNTBK?=
 =?utf-8?B?Q2ZyTXBWMDU4bENhNnY1UmRXSTBxM0dHR2J1MWpzMXdDU2dPSlhyWklmMFpM?=
 =?utf-8?B?bjlmdlpXdmxTbnVldTlyWmFPMmVzMVJkUGhMS3QzZExlaUgzRDNISXQwcGoz?=
 =?utf-8?B?UVFhck9OSVhmVVdQeVBSTmQyK1oyUnpMcC9HSW12SG0rVTBHZThQemRBU0FU?=
 =?utf-8?B?K3pHTFBIcU1zZ0xyTG50cU9NZy80dzBOcEFFVjZwaFBXZk1IZGtHS2doM2Y4?=
 =?utf-8?B?WkUxdjZ5NEFDTDNqMWs3WmF3VVZjL0NtTEdVSGxycERraktYZ3ZIU25tNlhy?=
 =?utf-8?B?WVU3Q2N1Rkx5NzZJMEVNSXRoa3I3aWdLQ2dBKy9JQXoyQnFwZFFENDJwRkRE?=
 =?utf-8?B?TXBIQno2bUZWdkwxZnRrdjlRd3NzWkxZUmkzQ2V5MTkxWEl4LzlGT3pjMTE1?=
 =?utf-8?B?dUNOWndJMytJNlJwcjYyeUl5VXovMHhGR0xDUnpnOUFQODlac0s0aXdNVzFR?=
 =?utf-8?B?cy93MjVYbzJkVUU5UXNUQ0JXZlI3dUU4ZEZUaFJaNGZ5dG1VaTMwbXpvUzVP?=
 =?utf-8?B?ODFuK1RQUUcyWkZ3bHp3S2c1U3IyeG5CM01KcjdCdWQzbWlqMTdIVVhWTE5D?=
 =?utf-8?B?cUxGVEZUc2IvaUZOVVNyL0hIRUxVWUZGcFZoM1VNWEhTdWFwVEhDZUdnb3M4?=
 =?utf-8?B?Ky9uQlkyMk1LRjNYNlNkSGVXYk5YN3FwSTRvR1NlbHZyRnpTWlNWbmh2cFI0?=
 =?utf-8?B?MmpaRzdDQTZvZWY4cWRpcE9mQUZkaVNnM2tacXFYLy9uY0xyMVBMUm04VWpZ?=
 =?utf-8?B?bTdzUHMyakJVdjZLdUZWaWxrZ1NWSmZNbmlvZjRZTWFTcnRKTklPWGJhV0lt?=
 =?utf-8?B?dzB2dGRQOXhRTFdocGpIN3doamFWNmlqVUFuYm1lc2lWQ0RqTHlQSEJuYUV4?=
 =?utf-8?B?QjFjaGF1SGZVM1BadWExV0svbk5Kb3hRSmpQL2NoZ1I3UFE0ZUdCdGhmQ2dR?=
 =?utf-8?B?VlM1ZFE3a3dtK3IzejZqTG4rSDdsTWZoalRCUGYwTTYvUDlhL2hjK3dZOXJl?=
 =?utf-8?B?K0dzRERNaFhMbVRCdXJOSmYzVmI0M2JmZzBRaUFnclZrZjgvY2VUaHhTeExm?=
 =?utf-8?B?UWxLVnF2TDlQTnp5emFka1RtMzM0b3hPc3V0ZlBSdVF5T0JqbG1ZdGF4UmtQ?=
 =?utf-8?B?NTFvcHBJUUxBVDdONlNlSzZRY096YzIzYkdoWUxPYjg1SWJPSHhKaThldzVw?=
 =?utf-8?B?M0FUUmhzd1R0VjJzRTFQS2xIWU1LeWhSek83R0pncWUzVElSeHBOZFh6U2Iw?=
 =?utf-8?B?UXZacjYvQmM4TVNPaXR3aUZ6cXZyVkpxT25yUGZBd3lzVCtwMGptL3F4TXY5?=
 =?utf-8?B?SC84L1BvRllnc3V4dGtNT2g4QWxKTFAwQnV1TjY5aklxUFl1VTgwM1Ftcmp4?=
 =?utf-8?B?SDdnVlVlbmw1dno4VVJSOE9za1lYajJqVWkrWWZ5ZmZpaWNoamtrSThlMFQ1?=
 =?utf-8?B?TmFtc3NhK0JpTW1nVUJHN2RoNHBrUXFPc0diQ3N6eXZtRjMveU1kdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228d4972-530a-4b8a-33bb-08de59483f3d
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:53:20.3200 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLQ3YxRhUFDEAU0CKlIld6iwhguEEpck0ggxY3MC/HsG90jINiG8/4gMw5CLZ+MnlioqJi7XJki4n8QEpFKhFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mq_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mq_evk/spl.c b/board/freescale/imx8mq_evk/spl.c
index a346305c863..5116d806bb6 100644
--- a/board/freescale/imx8mq_evk/spl.c
+++ b/board/freescale/imx8mq_evk/spl.c
@@ -9,7 +9,6 @@
 #include <image.h>
 #include <init.h>
 #include <log.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 #include <errno.h>
 #include <asm/io.h>
@@ -30,8 +29,6 @@
 #include <spl.h>
 #include "../common/pfuze.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 extern struct dram_timing_info dram_timing_b0;
 
 static void spl_dram_init(void)

-- 
2.51.0

