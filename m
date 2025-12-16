Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098B8D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:39:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79C0C801CF;
	Tue, 16 Dec 2025 07:39:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="GslHCBHA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5551801CF; Tue, 16 Dec 2025 07:39:46 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E318003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:39:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsWU8K/PqyP5zS0VIdxZoZ/Yy+9MN4iovk0Ia6gi35E5MSvgu8g7JiV1JyQQjHQZFVbDBZtt3qKUkUGWh62S7PKBlfCztIiJFrGYV9cUavR/qH1TkAEKHgisZrDnKJ8GpA5jP2e1kPRoxz7z2DuQD9AVrWOy29r4mmxGX93q1rZuMTlIc0AnN/1naeX4RieRlzBPsdj1uLL7v/mO7GuhxUth1TrxhfOT0QOuGgedel4xfxcOQYfTSBAfWfmve7yZIpxNUD49A42pEDBIkFuoT15tQAX9P+tG6L1yRpXGMyM0z7meUgvBvmsrzizEVejA095xoYbx15gNekZmFrqjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k133x7G/McAel9rtrMQsTPU2IPeA8PN537fsfQbCHlc=;
 b=It1O6ZrIrAFhMYOAWJj3QZO4903r8t+AMuWqlWJdlgG8H1MndozTuZPJFdCZGXj25t6VXxtc971NoCFZruUs4veUEKUJcPJjL566pRgHToryiTk5DakmYe/h4f7UyKEArsOi01dk0/ESXECmqZclh3CP/jWg8MSCvk9r79VmkRiZqcSQkguwRwtrzV6eXfzeJ6rci++Ik7JopkJ2Zy6zIsA0F4704tNO9K1u+wCzdDoQ1HsXeoB3EB3WAw9hTfQVtfLZNRsMybPp3SJfg4T0hr+oVvzP03i4xaiivF638vxaeY4t7tnPwWmtlTCOokOaqYkC91jKZ/Tz4r7Xu4UfoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k133x7G/McAel9rtrMQsTPU2IPeA8PN537fsfQbCHlc=;
 b=GslHCBHAPMIxn/RNxo3bhC57GGwAp+Fznejd/tlPqjoSXZdEeyazdoVDklUPPvdaKogKslRsZpRYJSTuXKjDwQFuJBi4KuNC8IKmFzbHMgxXxTyO9rSfaJHN5uR+1xBemhDl/7SYERftwdqMTaKc6Vv2nD+50OmCRASwX48JUzHveT0kLxWEw5tZAOOj5MoNVdP0kZUbTYpK0MxR+Fnmp31CsorVGmzqktOOAz0I4ICAPFfxs0YPY2ldJbFKOaU13FukypAtLF84NvjUbm4bREnwrG9mfbR3P1+JQRPx+Sg1zbxnn2krqs7+4TL+8D4esCIcj8bI457jjPnVwVNfaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:39:43 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:39:43 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:33 +0800
Subject: [PATCH v1 1/7] usb: ehci-mx6: Move USB PHY register definitions to
 common header
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-1-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PA2PR04MB10514:EE_
X-MS-Office365-Filtering-Correlation-Id: c474adcb-c30a-43df-f5c9-08de3c6de546
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWFpbmpFM2JLVFBtQTFQS1FDbW1oQ0EwNFQ2VDVDU0hyKzltOG8rWXFXemRQ?=
 =?utf-8?B?U2Z3WDFZSkdYWUVTTGl1TERjR0lubDBLN1ZjN0RRM0pCaUJ2R0Q4T2hZSkFT?=
 =?utf-8?B?VGFMQ280Q0tQN1dFaUVwQ2JOY3BlTFRSOHV3UFVBbnFVL1dSbWF0TkZpMUtQ?=
 =?utf-8?B?NDRsY3cxQ1JKSjd2TmFBZG5ocHpFNXBSdFRvZCszVE5YTmlueEsyVHc5aFBX?=
 =?utf-8?B?b3NDa2xRN0E1eHdOakQ3V0E4VU5oeTd6YkovZHpOaVBHQ25Tc2ZoaUJBa1Qz?=
 =?utf-8?B?VktocWlTVGhWTEh5MGE0ZEFDaitDRmt6L0ZzUXNCNENZZ3d3QUtNUmZ3eFJu?=
 =?utf-8?B?OEQvcjR1Wk9LQ0d1cGVUMW5zWUN1MHJxWDNLSUJRS0I4MGMxT1F4QWlXUWRk?=
 =?utf-8?B?NCtmZmlFM1pHVmdFWXlJQlNUc1NUUG5ITmg4bUpuQnJmNzVRWUVwY1NGR0dm?=
 =?utf-8?B?d1RQZHZxbzNnOEt4Z2U5dUE2NHJWUU85aG9MVjRrcW14R3F0RFlkaisrbHIz?=
 =?utf-8?B?Y3lYQzBRUDkvaU5QdE1pZ1BXQXVvVzVvK2hYcjZ0S2JiSHF1Z1ZMWEIraUxV?=
 =?utf-8?B?Q0IxS1JNWTUyY0xVUWVBbE1CYmxmbWZIeUpaOUs4ZFJhWmM4S2FENmNyUDEz?=
 =?utf-8?B?SFE0endpbTZ4ditDTVdJb3FNRFIzRSt5Y3hybUtadEpUN0VHSUxhZTA3cUVv?=
 =?utf-8?B?UmpDV3IwTVRScFFnQXYwNG9zbndNSzNPd1dDcitEL2M0ZjdSVWpjZFVjV1gv?=
 =?utf-8?B?dVVaNWJnZU92emdEYXRXYkdWaFYrZDUzRU9ETDV6T1JNYTZJaTNFMEhRT3pw?=
 =?utf-8?B?blRXS3FpcDhZVHR6SmlwREN5MC9LUnI4cGtWcmo1dXFlREFaTUxUVXFhajFW?=
 =?utf-8?B?OHg4akVZV0NjNE9uUGY0Q3pBWDRYTi9LZks3aFQ5QmlWWUYrTjRMNHRCRkxV?=
 =?utf-8?B?QU8rZUtReWNsZjQ4a0NGK2xoRHBocXhpNXFVaG5TYVJYeXdUVE5lRWJUTDN2?=
 =?utf-8?B?N2Yzakl1L2ZzNUZHemprNXU2MjFmS1BCL2txaklvMkZTRktISnczK0pCQS9k?=
 =?utf-8?B?bjE3ZEpKVzhwUmdBNGJjM2JZYkJhTm8rdnBZVkZIOTI2N2dTamV0VUVTbmkz?=
 =?utf-8?B?QXFjVXFMSjlSRjc4VVVoVGUvTGRVaEx5aDdGNXhQaS9SdnVGbFF4aXB4ejB6?=
 =?utf-8?B?UHFLVkRIT3pXbmZabkpUQ1RRNG1FSTNhb3dUazEzdzE4Mjg2aG1rM09QQWF0?=
 =?utf-8?B?UXg3ZzFhUE9FaHB3UjlwUUxNVmtBbXQ0ZWErMzBBSVIwWUx3YzhwMm9ITjB6?=
 =?utf-8?B?Rm1yYS9CTmg4MEtoSTFmVGRSZkl3Q2ZwUExVOEFNVHZ0WjVTMlEycXdva1lV?=
 =?utf-8?B?Ry9OaDNWWlExVGtja1hZeHZJL3J6cnhUaE5vUWNaamtJNDZUVmc4U0xEV0Zo?=
 =?utf-8?B?Y0RIaUw1dFp1TUFrM2hYWkl2cHRBREtYcGZJb2lFL2FzWTBnNmVHaExMZW5D?=
 =?utf-8?B?RkdPSTl6dERzUUVkTG4wWWlhdTJWMXpIQ3ZPcFY4L2I3UFJxdVJTSUdPSm9U?=
 =?utf-8?B?RTdCWVhqaTFyNDhaSk4wdDBiWGZlVGNLVGh3YVlhazRpMTFYbURNVXROdkM2?=
 =?utf-8?B?U0pxTzNMQlp2K0Y4THU3eXBWTDRzeUQ5bE0yUlhWVlFHMU4vWUVHMEIyd1dp?=
 =?utf-8?B?NmdKZ2RwVW1uRFJFcGFCNnBqaTZYSy9uSHdUZExteTBheXdwMGJaOGRKSENE?=
 =?utf-8?B?N29pL2c5MnA1TThnb1dzSXlxQmhBanhzclFCd3daeXBhUGNqZWZwNkM2aXMv?=
 =?utf-8?B?anByQlhsK3hUZGhxOTV6M2JhSDFwdlJzcUk1SDZGZVpPM29aazNCcWRvWnJW?=
 =?utf-8?B?b0prS1FUSVZkMmJWNGRQT0tEUkJ6SEJQc2xRYi9CTm4wOXFucG9Od0hnektp?=
 =?utf-8?B?UHhFNE54akNHM3hSL0RNenRZbzROYXVPbnkrZ2NXNThZVjE1SEZybm9UWjQ0?=
 =?utf-8?B?MzlDaFR0bmF2cFRGUkZNSE0xRnRwbEVTalZ4MzVxSnR2THR4dE13S3ZhNHp6?=
 =?utf-8?Q?ruLfng?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEpraFZHcndNNnI0Qmx5SkY3NVlKTS9mOTllaVZqMkRrVmJFV2xQVkhMYnRK?=
 =?utf-8?B?T2V1bHBTeVhDZzRUby9vYm12UjJxZmpaRWVBSHlhb1Y0RFg4MS8yTjBFczhl?=
 =?utf-8?B?NS93RWhGTTdsMVZKNE9QYy93ZnRSWUsxbERzN2tYbDBGWDZ0R2VESlM2RWx5?=
 =?utf-8?B?Tk5hWDA3L1J6c1VGakRXRGlaRWc5WTJaTEJ3Z2c4aTdpQVZrUGlIL1pvU2dC?=
 =?utf-8?B?STMwV1AxM3dNMjQyWGtDanJ5SEczZi8xVzhVWXBEVTNCQzA3Y0dPSENiT3BD?=
 =?utf-8?B?cjVid3RsM3dWK1BYanNnQjZ0SVFGK25ZN1F4bzAzeWpzNVc4V2VFeWtscnk2?=
 =?utf-8?B?OC9FYTZ3MlNWdkR5R1FmVU9haEZ0Y2x3UXFOWmkvQXFlS0xrMndxMUZYMVEz?=
 =?utf-8?B?WTZpWEN2NXRNeW1BOWVvWmhLMmZVWkVNTlpDZUh5Mk5VdDQwaDZRbWgyWUlC?=
 =?utf-8?B?ZUEwVC80R0xVZHRRS2hXcmNCRjQ5MWJvck4yZTRJL2w1NEdUNjM4QWl1Wm95?=
 =?utf-8?B?TWRBd1JFQ0w5ZzRlSXBhbGZCdDBlZDl4K2I4ZjNQRWk5ZFZNUlQ0R2NTYnhq?=
 =?utf-8?B?MDdubDJrRlh5RFc4bGV5M2RxUVMwTHdBQ2M0MzArMzR3UitCUGF4akZIOGxa?=
 =?utf-8?B?UU5lZkN6TDdXYW41MlNKbWNFWXhTN2J1RDdIVWhTdjI2MmM2K09tMVdjdXVv?=
 =?utf-8?B?aWluTzBXRUJpQ3B5NUVqMEpHd25wYXdkcFFObDVnaEt4MURpSmtscjhXNUFD?=
 =?utf-8?B?L3NzeHdSRzZpc1c4QklPM3dWRGsySW40SlkxeVJRV2JiYUFzRzFkTDB2OU1x?=
 =?utf-8?B?d1QyaC9nOWpkVG5kNVFsbDJsaEJra3BKTFN6dmthejFSTGVGRjNQSVROK2Fj?=
 =?utf-8?B?ZkVXL0NFNUZZVFJLcmV4Y0lQRVNWVCt0dEFIb0NtNDU1cmJGeXZEZnlRSFFn?=
 =?utf-8?B?NVdxUHhpWEJhVzNMZk5lUVYyMnRhRG51bmtTQ3RZVTdtYnJENmVrc0t6YjZW?=
 =?utf-8?B?SkYxcWxBTnJRaWZBdVNMRld0UW8yZXBkTGNaOEN0N2RtTFpkcFdNTWZGaFBI?=
 =?utf-8?B?WkZBVFhiNU5RQWRETS83WTBXK3g4QXU4czBWOGpSRTAwck1aZkpIaC93dEkw?=
 =?utf-8?B?VFc5OUVYOHIwamRKUi9aQ3dQYmpuZUh3c004WWdNOU0rWm14QUxqNDBObGZH?=
 =?utf-8?B?ZFdiTUhRS3F6eUlCZ0trQ2hzNENHQlRteXliZFB6U2pyQktOM0ZJb0srQVVi?=
 =?utf-8?B?bFVxb3pTOS93My95bDFIcVlhZngxU296KzRHeHUyMkxMUVlSeERJVTVka3do?=
 =?utf-8?B?bEVuN2lCRi81cWxjTjNDM3NMS3JBQmd6MHhPenVNM0E0WW50cFVISm5tRXR0?=
 =?utf-8?B?enNZQUtqeERCK2IranlFalZIb2cyTnQvbWhhaDFtZjhrRDlHeHhXYlJCdWFm?=
 =?utf-8?B?aHBKMjViRmJUelE5cXBvZVEwQ1gvK3NueFErN3NZRlFnQ2tRZklCcG9rdHZH?=
 =?utf-8?B?WDdOSVJDNCs5SXlodWkxUlE1NmM5SjBLZ2JjYmFIbmwxdkNuNVJJMElzdzhr?=
 =?utf-8?B?L0pVWDlmQ3ZKUG9vN1AxZWExNTFJLy8vYTU2ZkRjR0VmNnN0eFc4V2YxWWxE?=
 =?utf-8?B?cjJKOXFqYzF5RFNldEZwNXYxRm9EalorOGNmYThoMkRTc04xWE83UmRqaHE0?=
 =?utf-8?B?Vytuc1cvM3RqT3o5Q1BDWVpKOVJiMFBTTW5OOW90Q0N5aGdacnRVL3d5Si9a?=
 =?utf-8?B?Y01FV3IrclBqNnJvaVdjdGo4RUxmaVlWUk1kQzdTN3lrakIyRlkxdE96QXFw?=
 =?utf-8?B?bU16VVpabk14QjNHM0JUYWRTb1Vyd1h5NllYbkRabDZEUk5EUW5wSjJBSE51?=
 =?utf-8?B?cDRJbmZscTBPaUhsOGdodXZKMGRqSlRULzNOdFNSRXpSeENOVyt6OGxLaE9D?=
 =?utf-8?B?aitmOHN4M0RQT2ZEWEZCUktrMVBzdlB3SWlvbmI0Mk85dDZCTWFvSE5SeUNH?=
 =?utf-8?B?U0ZpUGNNREY5cWd1V245SHE0ckRIblZ6cGorMjZwYmRhZngxUnhKcllOenZu?=
 =?utf-8?B?UlhJaDVDcmx1cnZNcldWTDdueUtDT1hOR2pCUmw3ZVdwOVZhV3ZXT0tMc0RD?=
 =?utf-8?Q?gOiyRUxTwdE7CtMLt9QOtOdtx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c474adcb-c30a-43df-f5c9-08de3c6de546
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:39:43.0116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dsIEiBvpFNPt2inE3ll/chGgjyQyYmgBB2rmVHaLP7d2uyEP0QYo5gqWKpOn7LwQyEwU7ZQNhm9TPy/TviA4bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514
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

Move USB PHY related register definitions from ehci-mx6.c to the common
regs-usbphy.h header file to enable sharing across different USB
drivers.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/mach-imx/regs-usbphy.h |  3 +++
 drivers/usb/host/ehci-mx6.c                 | 15 +--------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/arm/include/asm/mach-imx/regs-usbphy.h b/arch/arm/include/asm/mach-imx/regs-usbphy.h
index 2b18ec20f3f..543c825f9c3 100644
--- a/arch/arm/include/asm/mach-imx/regs-usbphy.h
+++ b/arch/arm/include/asm/mach-imx/regs-usbphy.h
@@ -22,4 +22,7 @@
 #define USBPHY_CTRL_CLKGATE				(1 << 30)
 #define USBPHY_CTRL_SFTRST				(1 << 31)
 
+#define USBNC_PHY_STATUS_OFFSET	0x23C
+#define USBNC_PHYSTATUS_ID_DIG	BIT(4) /* otg_id status */
+
 #endif /* __REGS_USBPHY_H__ */
diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 8f01b29c74e..cfaf49d67f0 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -17,6 +17,7 @@
 #include <asm/arch/imx-regs.h>
 #include <asm/arch/clock.h>
 #include <asm/mach-imx/iomux-v3.h>
+#include <asm/mach-imx/regs-usbphy.h>
 #include <asm/mach-imx/sys_proto.h>
 #include <dm.h>
 #include <asm/mach-types.h>
@@ -36,18 +37,6 @@ DECLARE_GLOBAL_DATA_PTR;
 
 #define USB_H1_CTRL_OFFSET	0x04
 
-#define USBPHY_CTRL				0x00000030
-#define USBPHY_CTRL_SET				0x00000034
-#define USBPHY_CTRL_CLR				0x00000038
-#define USBPHY_CTRL_TOG				0x0000003c
-
-#define USBPHY_PWD				0x00000000
-#define USBPHY_CTRL_SFTRST			0x80000000
-#define USBPHY_CTRL_CLKGATE			0x40000000
-#define USBPHY_CTRL_ENUTMILEVEL3		0x00008000
-#define USBPHY_CTRL_ENUTMILEVEL2		0x00004000
-#define USBPHY_CTRL_OTG_ID			0x08000000
-
 #define ANADIG_USB2_CHRG_DETECT_EN_B		0x00100000
 #define ANADIG_USB2_CHRG_DETECT_CHK_CHRG_B	0x00080000
 
@@ -57,8 +46,6 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ANADIG_USB2_PLL_480_CTRL_EN_USB_CLKS	0x00000040
 
 #define USBNC_OFFSET		0x200
-#define USBNC_PHY_STATUS_OFFSET	0x23C
-#define USBNC_PHYSTATUS_ID_DIG	(1 << 4) /* otg_id status */
 #define USBNC_PHYCFG2_ACAENB	(1 << 4) /* otg_id detection enable */
 #define UCTRL_PWR_POL		(1 << 9) /* OTG Polarity of Power Pin */
 #define UCTRL_OVER_CUR_POL	(1 << 8) /* OTG Polarity of Overcurrent */

-- 
2.43.0

