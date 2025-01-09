Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71E8FE77199
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 58AD080609;
	Thu,  9 Jan 2025 03:23:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WPb+lm3H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B116080602; Thu,  9 Jan 2025 03:23:41 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97AC806EE
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PUvJ8x/B/wIhAV5hMPGpfpYx6r757HI18FViSdMFIeuBL3SWxZbSF7mIFTDzccOEL4QHR8UDCSTS42J+LdQzjw9cQCkfMf8q6z4NunVPpoFJ6q8hXtY8DpPLAm8mMDZdXiQ/+BzaKsCFSgDoO9of6ZGuLXVFh6lug6NOgQ+4Em33AnR5/kbQ8IClky8I0iVYroWFq6ZhuWqxf9QLz/Et77IVZjzR0hJWWAYfHEiZa0aAJrdpO02jnPWOMucOCa24tQUMFWv/d+e+hUCOmohOm+aNmxCstbqwA0BqyDzLGSdZzNeV+MdDG32szDsAtW5r6CO+UIV2gE+av5Ojj2d/+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w2Irmv2G6bQIfjaHWimcIOotb4M8+C3hXknNbgpaEPg=;
 b=MXlhx/WhpqFtQMaJg7WMZ0ZNG4FMiieacfAYQltCawWq30LlKIkCuceGcCnV22Ao4HTCv+P++t7CgQNoxxkDtb4lP2NZKqLFJ07P5rteeBIo0fD3ubwInb7R1SAbIo6UA1cpbXutWpOmi+S5XoiRAChLmsC9S1bqWGsTBXo8mkz+i9+iOQMkuKobNv6vwh0Uk8Oxo9wH5Pxxt9N3szJRVR3seEDbuoAQXUlrQmsI5ESyrxgVFTa0zBKpl06RCNjlQJvIAylQEMw86HoZlIlW+0UbEOpO/mIwOBysE39MCRDasdWHMASxNfwJIt0OEvgGnsdKsrWNSQHOahChthx6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w2Irmv2G6bQIfjaHWimcIOotb4M8+C3hXknNbgpaEPg=;
 b=WPb+lm3HQ6XUL9rDB8p7p6Vy8tjQNI8G+8HFjwjWUV4bXp4iA9TqzHY/6TaUq0ss69H0fNF2wYgrOKVbF0Mjv9AWx74oRQhZITten+zo9EmPVQzumxInk/09wgTDfgq/5QzghXR4NCeejfB7TncqUNjd76sNlAiIR1FKjPYTSAuw79CD5HtddYJ1/u06TQ9Kw9LHnH0uVgSQ08fHHzgNCPwN7YS/FFgIJxfZoTn/kbVeF4yi8Ydh+DoBN8ceNOFK5ohFffCVuSQNqL31k51aXZpXBCsoybcTNYx1eNonmwCvv3IDIUihjFczdsRX8NW3tENDkkbq+jOX9YCqJ6te1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:35 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:35 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:12 +0800
Subject: [PATCH v3 11/17] imx: imx8mm_evk: Switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-11-16e5fc0baecf@nxp.com>
References: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
In-Reply-To: <20250109-imx-bootstd-v3-0-16e5fc0baecf@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SGAP274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DB9PR04MB9355:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d3e56e-15a0-4ffd-a289-08dd30549e93
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlN5VGxNS1dHNEV2Q29IT014MDgrcStWZ2laTE0waGxKZEpiQUhSM0ZpYnJJ?=
 =?utf-8?B?bjRWL0owdEJOTFU4cmMzTzBmU0RCOHdsYVpCN2MzUUtqZWY2UkdEaU1LYUM4?=
 =?utf-8?B?WmZYbmEyQVNZd2RQai9qeXJJWmt1TklYQmI0MWR3Nm1hMyszcUt4eEwwa0t0?=
 =?utf-8?B?dllSalcrR3NjY1pVQnFTc3BOdDhLRHJZdjVIeWtkS2h1TW05VmNQNDdmYm1z?=
 =?utf-8?B?VXhQRVhrZ2FMbjhSRHdlcTRsdGJ6aHMxRTRhbEg1cUNJcURKNjBIdmJ5K3Vh?=
 =?utf-8?B?ZWZQZXRXNi9LcW1FL3ROYVJ1YkhISUdTQ2pxb05JRXNJbnJNRjlFV0ZRWHRr?=
 =?utf-8?B?eUt2ZGxNcVBjQ1pKTU5qQ0pDcjI2VHJZNEl6M3Y0SGZpOTI4UStYc3lJRERN?=
 =?utf-8?B?ekFBSDJxM1lxb1duNmFBUXpSME0xRWdWT0RHVE9HcG5pRzk2S0t4d2VleUdv?=
 =?utf-8?B?RkpFTHNMOGl4SnpGM0pudVcxNUFGeXpBaSt1NGprVHBKZG1PT1pZbzZqWVBt?=
 =?utf-8?B?M3RRQWk0VW1yVVBOQjJ0eDZVWWZuSXhwU0RHdkx5cTVpTXlxek9adUl6NUtl?=
 =?utf-8?B?R2UzZFJBT2xxR2hEU0ZOblBHK3daRWRwbE5CL3NFT1dWTy9vVFhjdnNDVmRW?=
 =?utf-8?B?TXhqQUsyZmtGM1RlT2JzT3BpZ0tUZlFmYjBMV05ueDZGeTcyaisycXlTdldQ?=
 =?utf-8?B?OHJnZnV3SkxETjluRHQxaGR0SFNUaEZ3TUdoMS9mUUIrN0JRU05vVStFRHc2?=
 =?utf-8?B?cTk1Z24ra0Z0bmdqOWdpK0c3WHFNZ2xCaXNvNkQ3SFUrVVVRUmloWWl5Smx0?=
 =?utf-8?B?VEpNZlhPWjcwZjA5Wlp6VjlUcGRDUUtIeWMxb1JSVWx4cE1BWlVoU3NNQkt0?=
 =?utf-8?B?NUszSWR2MmJ4QjZUK0xIRnQyaHRWclVMYXlKYkN2SGF0Zms1bVFBOFFBRExM?=
 =?utf-8?B?TnNoeHp1Z0tucXp3T2QxSWFpSngrN1FRWDNLV09vSmM1aHU3ajIwcHlXNVNF?=
 =?utf-8?B?VFRiT0VpQWhSNnFXMDFBMlNyTStNTjdpcVVhK0N2eGtGbUg3VXNxSHh3Y1Jz?=
 =?utf-8?B?MUZLd2c5bmxOOEhCRFFwNUxIVko2S0szYVplZ2lMWnZVaGxMeU1qWkQwN2VC?=
 =?utf-8?B?cy9Td3JBeFhLNDhSZ05PWkZVditGeGpsRXh5b1hibVRidHp6OCtTdDg1bU9M?=
 =?utf-8?B?ZWZOWDY2WDFrdVBTU0Q3aUJpWnF6MHFaeTNlTjlLRlBTTk1YMURJYThTZGRu?=
 =?utf-8?B?Q1RVcnJ2TStTRjlEV0V6L29SL2dGck5WT1BSeWRJdXdIT0laVnpaUXQzNTV1?=
 =?utf-8?B?SXVWeTZmZ3BJcm8wV3dSMUl1ZUMzdjJNeG8zMEdlMXZnM1NjbUdIT1JyNkhP?=
 =?utf-8?B?ZDlFb0c4K2VaU1I3TFpUd1QxUTJ4MmloK1d1Q1AwcUo3cGR1MkZLckNDT05a?=
 =?utf-8?B?cGNFaDRzS2QxMk10U2V5UzA3WjFsenJXK1NndCt0Sm9sZDc5WVZWbVpIeDdC?=
 =?utf-8?B?UlEwTTI0WTFLVUcyalkyYUd4WE9ENlZhVCsrNWRTZnlvc05uL3JHK0ZxRk1t?=
 =?utf-8?B?N2JTamZzaThicUNycGF1R3Znb1ZZbFRGS2lLVlZ4Q2NteU8rdE4vdDB0Y0Rw?=
 =?utf-8?B?cUZtVlhiOTVyYWJBbytWTkhTVFIxcUpINHc2SUdJRitXOGd2ZlFNRzVMNlJX?=
 =?utf-8?B?NlZYU01LVVhSN1NKL3dDZndZa21oS1YrclZhdDJnaVJNR29LdHd1VlBxbksz?=
 =?utf-8?B?cUZYek1IQUJWdkpwNis0dmVrS29TT3BVdUtjNm04TVd1ZzFxQmQ3Y0ZPd0Jn?=
 =?utf-8?B?c3kvcGFzVHNwOVpZOWJqNE5nS202ODN0QS9FTDNmRzQrUGpUU1JpOEVwV29V?=
 =?utf-8?B?V1IxQXUzSmFPQmY3aTBFd1psRmxCTlpJZ0hGRFdkMjVnRVVOSlNnYlYxa1pu?=
 =?utf-8?Q?4SviLmB3714KwUBs++SvO7MJuJ8RTd6p?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlhXdGdEU3hQcklxQ0M0T0VWa0R0NU15ekppa2FRSGt3L0RtZEZZbWhFN3NM?=
 =?utf-8?B?VTg5eHYxV0svQ2pZRjNaTjZ5Qm5EV0ttZW9oaDdCY1RBdVk5VGdXZGZ0cml0?=
 =?utf-8?B?YnkwUWhKMFFISEw0S2M0K2R4TTlHWEVBQTJvdmFzajBKKzVpRnMrTGovczBL?=
 =?utf-8?B?cGRIYkI3TTR1bTUxWnBTR1lSbnFTSVEzSmZydG9IbkRydzVwdVR1bXR4V1V6?=
 =?utf-8?B?WUtFM2NyS25JdG1QaWlIdStnREw3UEZvNFFPQkh6MDFTNzcwMU9qRFlndEFo?=
 =?utf-8?B?YUZyWW5zVlNFUVNBNkFWbmtFTnpFZDliWHBWMTFWUG8rbXVXTGliSGgzRzRw?=
 =?utf-8?B?dHE3cVRFNkYrMnBvR0pudW5SYWtzOFFYVmxySDRZOUhZZ2IvcGVCWjF2dWg2?=
 =?utf-8?B?QVh3MzlVSVVKS2piR0EyYWN1enNJcGdTOEp6VjBjaUl6R2JQdHlTbHBUMjZs?=
 =?utf-8?B?L3BHNXhTSE5NYm5CVFpicXcxdUtGZWZ4cVd4L1RYL1NVM0F3UWswTlMyK1c4?=
 =?utf-8?B?ZlJZVUdkVllNU1hDbUlXVjRtN2wrTGhhWlA3MFg5eUhMMG9oQWtteHY0WHpY?=
 =?utf-8?B?K0UrSmZjcUVPRmpjNmRNanAxVWtRODRaandZcjJ3bkN3NS8vclBQYmlCNStY?=
 =?utf-8?B?c2xTNEE5U21BSFpBajQyTFlCNjd1UmN3VG5CYWFiR3dxNUpWQm9vSE9NQTEv?=
 =?utf-8?B?cGZ0ZENOd3RyWkJGdDgxcUw5MGlmRjJxN0Y0Z1hTNHhWVUhyZFpjM1Jkelpo?=
 =?utf-8?B?UTZUVmxiMWplL2FrK0hmb1VUNm5TYjlIL05NY3ZpdjUycWRuZ3ZxRklZbVNo?=
 =?utf-8?B?cVZmNTBPem9pdVMvUDd3ZEcwMG1VN2ZYKzFJVHgzQ043SlpoT01aVWhSeHJy?=
 =?utf-8?B?bGI1UWZ2QWtGRWtoWmljOEwzbUV0NEl1NDNUaWlFeUlKbEh1NnBHWTJvSGE0?=
 =?utf-8?B?aXdzVlBvMVBWMTZidWNwOXd4YTE3NFc1elJEWXg0bUVkeDkwc0ZnTzh5TDJt?=
 =?utf-8?B?b01GQVEzMEp4WkhZRy9rdW9MV24rNEFCZStUeldIelFOcDZDTzRsSDh1cUc2?=
 =?utf-8?B?RXVMWlI3dE9NWnZRNVFtOGJYNjNtcWVRdU5RMUdnS3dMZ2hTM3dWQnJzQW9m?=
 =?utf-8?B?VkVFengrRGFwcVFyOFUra0FZeUlhZHk4R2IwYVVnS3VIYU40NCtNbEpKYS9X?=
 =?utf-8?B?S1Y1TzZPQTlpWHVheXU5alE4SGhzZ0RnbHhpUUsvQXpzTVhKY2dkREpEc2J1?=
 =?utf-8?B?NHJVUVhUbG8yV3dhM1hjc2NMdGE3RGc4c21XbWttM3RKdDBhalg4TTVHWXl4?=
 =?utf-8?B?QkdRTzA1THF5N0F5ajR5N0E2U29nZ2t0cVBwOGhtcFNvWlJtYjdhY2NVNkQz?=
 =?utf-8?B?R0ZVZmhOdnBqQjdYeVF2S3FEaFBjY1ZFTzBpMkNJQ3BrOEo4YUl5ZEFSRjRN?=
 =?utf-8?B?MERlUjJoNmRzdVhDMm9yOG9SWDMyYm42NGJ6dlZXSFlxeVVHS0JsS281ejVy?=
 =?utf-8?B?bU1KRUdwaEQzK3hrZFMzRGwwR3Q1TWp3eiszTVRXNkZpTzUyT2NrSjU5VUZq?=
 =?utf-8?B?ek9DdU5HVFNkakpQTTNjN1p2NjZkTzlKRXpxQTZEb0R4TVp3ZXp4MjJXVUJ4?=
 =?utf-8?B?eXludklzOG5Mb3ZNNG9JWEJ3dXJacUU4eUkwOWNkenhOV2ZEV3lNTjZwUi9B?=
 =?utf-8?B?VzhRTTBLUFFMaHlzcU9mdXkyamIwcHAvNFg4Tkpya1VSdjB5ZDh6TjJLeHly?=
 =?utf-8?B?enpPdS9XUlFBc2hqR0M5N0JkdGlobEZnU0FhTmxaamxUVGFrUzVGUDJ6cWFX?=
 =?utf-8?B?dDJHcWowbnpHeXNPSmZMbUlVT1NscjVoOTRBSVJiZjRIK2xITjlvcmJCaDVO?=
 =?utf-8?B?QUMyTXlNYXI1R3BJdFJDUmk0Y2g5MnFiT00ySlZPckJEMWpxRXVYTStPbGF2?=
 =?utf-8?B?b0M3S1R5Ni9HZ1J5dTRweGQyTDQ1d2ZGODFndGFQQmtxbllWV3ZxcmFNcW0r?=
 =?utf-8?B?Q2xKUU5aNzQxQmVjU0lEMGRJTFVtUjZBMVRweVI4dTFqY2hLRnRZVkY0OU9z?=
 =?utf-8?B?azdOMW1XWG5nQWJtK0tad092MThMcTNlb3RDTDZNaUxQR25NVW1pTFo4MVlZ?=
 =?utf-8?Q?aaMZF5tN31Paaxn3wPeL/3/kQ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d3e56e-15a0-4ffd-a289-08dd30549e93
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:35.3155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QFlB699dhZMXlAGlmEA1t4gk4+POPimjBcJlNK2prmZE2DNsuEFysESOs4BWwuyjN2B6NWj6BCCnRqkVw7ZSow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9355
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

