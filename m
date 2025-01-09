Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F35E77188
	for <u-boot@archiver.kernel.org>; Thu,  9 Jan 2025 02:25:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A311480719;
	Thu,  9 Jan 2025 03:23:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="anIc5zet";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CA02806FE; Thu,  9 Jan 2025 03:23:54 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EA1806FF
 for <u-boot@lists.denx.de>; Thu,  9 Jan 2025 03:23:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ws7b9TYyDEAP4G0x3jhtrmOhmnxrkJGtozGb2qXVXwNf244oJ5X969D1Pagwg+/jEGTuEzRJGWwcwyIeP2C2V1sSXbXf5wrXTmd5nT2ViXLt6riPoSb9F5OF1R4CPXGKDdBw5WmxZEi5ji/7b65QlZNftbKWIe1gtbU8U/PhpEqGyDZEvpH9kJWKaX5opY4zQ+BqPeMr30AGJJZzDQlYw88/4cniSuO1nJ+5dy/99BZzj/FYijU5WPbntU17463BMPxoukVJBxtPiSzCgVjjX3hJd6DrT39LyPa3FjuixIeKqBOmrfnhsjcF3H1osE5rtqw/S4+jqlCXWj42KnnMJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovw4Xr0XW1oTX6KARgSNypnbM9kfXS0GDOFpS4/XKG8=;
 b=lPA5yYRkT4daW7tmfKiTGPE4kaFAhw40HIk+aB5nWSKK7TpjVX8cWSAvcI++kT1VxLJPvKgbBLUrij3ebBFp+WYtfZrjA7s+n8ujSXMa/3vR0xjIkOiCNrcgSHMrG6FbjpeDhg8fOUPDvHfaTeIbnSIfZMacDeaAq1luJnCdsz1ufMKVWsW5leEf4TVpoES5k1hZej3r4bp7b6iJiSiBeW8sg7v/dC4FirqMT+Aj1TIo6ajCEZa/0kk7DzolcfBDR7n2ezUb0O5lZiMC3i/nSNSDncUDV4vFDnzLTu5/Tg+VK4smMke8CGTOOKJx7fbvSQw0BISkA2rKFipGC07rkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovw4Xr0XW1oTX6KARgSNypnbM9kfXS0GDOFpS4/XKG8=;
 b=anIc5zetDCzYnjGH4Ks+b6di22FMD3+qJnjip1eeOj/WU1R3+VvsniVboI7bhJ2S/qNzqGQYr+CdGdIz5BNBFrRgnhgHa+nFRg3faOMxP3fhgb81FFi1ukM3qlAxizQR5mHe9FpZd46nLziR4K88/5zX+cr3zCiHk2uz4LgJ9N7+AHW69X1uQht+Nqn3gQR3p0xJvWgNwNJejzWhExuKwdJ5VHctX+6szHEFvQEpgiAoY0bol98Faxp8L1kMCEhG91qmvGaxya6DPt9UbvTxJdmQCq160YoVmsfXNFKxh8LVrQXPqXdl0MjQuj6KEVuPScxkcZeXTPFp9A3+Tlkn2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DB9PR04MB9355.eurprd04.prod.outlook.com (2603:10a6:10:36b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 02:23:49 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 02:23:49 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 09 Jan 2025 11:29:18 +0800
Subject: [PATCH v3 17/17] gpio: adp5585: Update compatible string
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250109-imx-bootstd-v3-17-16e5fc0baecf@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2e76ae53-4c16-4909-0c54-08dd3054a729
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXRabmdFeXozZkczOWlMZ0Y3K1NUU0dpbFZiOGZTbHJwcUNBNjhra3ptWUI2?=
 =?utf-8?B?UzRqQ203djRuTU0vNXhmTDY2Y3BTcDExSmIrK0xScy9GSmxXdjhuOUhYYmFT?=
 =?utf-8?B?RWpqRWdiSHZ4ZGJ2QW5hR05zMXl4b3VHcmhaWnF0SUtDa3hsN0dwdkVXZEdv?=
 =?utf-8?B?b21IV3JCM0huU1ByWXdrbmx3Ni9oR3BWSUNEUFNmcENUcUt1T25pU0Qzd0U5?=
 =?utf-8?B?OXBiWDJnTVlEelljM01tV1YrRkhlaUpVZDhCWUxqckRMN1pEVDVRVEtRN09n?=
 =?utf-8?B?UDdyakJIaEhFWkF6YStYY3hUdHdiaDBMQTRkU3RBblhxNUlqUlhDUjdhOUpF?=
 =?utf-8?B?dzU4WlgrUXBiQ0tRNzc0RmJtUVVmUktqNmFNSlgrLzJrSTkvenEwN3hEbVoy?=
 =?utf-8?B?c1JBVklaV1NxSHlTdlV3MzhaVzRONG4rUnhHcTk4V1BqVk5YaElmZkMwMW5C?=
 =?utf-8?B?T2had3Yvdy9OUDNOa0xmYnRsdnZRMXNSTzFPV3ByRlVmKzhDaHVWSUJmeXlO?=
 =?utf-8?B?SjlXMkpUaGRtL0JqdEdQbndlYUNhQjNmWCs0UUlaNVpjZ1BHbVVhYTdwZTla?=
 =?utf-8?B?MVY5eUhNRlN2cWFoOFN4VlVxMGdFNDRhNlYwd05XSk9Bcy92b2RwQ1FyQm1U?=
 =?utf-8?B?R0VQTUQ1TmhQbmNiSlVPQzZXVUVLckdGOVN2QWtJMHpEZk1ra3Y1d1dUM2hq?=
 =?utf-8?B?TkRmblpWUGhSZjhPb0h0NmExWGZMeURKcmV5WC9ZTC90U2NWd09ySVlEZzRF?=
 =?utf-8?B?bUlwMnI3YUMxOE5NanhlZnVUVTMvN0VHZ3RBQ1lhMjUxRzVoZG1Oc2lwdS81?=
 =?utf-8?B?QVh5ZW9kcTBPQ0RaN3ZCV3B1SVM4ZkdUNWkyWHJ0UHNsOThCSTBvUVN3by9K?=
 =?utf-8?B?cEpaMXV3bEFDSVpJTFpISlcyNFlPQWdIc1BxOFNCMHJQcDB3SXc0V055Y3Vp?=
 =?utf-8?B?WjJyejhuVmNNTFV1Q0F2REJzeDE2Uld4cWRabWJ5bE80dTk2UFRNQ1AvZ3Yx?=
 =?utf-8?B?aHZZMHg2aWViNUl3UFg3VWJJa0RHSFBpdXJkSFJFMFNmRXhnMFdXV3BOdVdt?=
 =?utf-8?B?R0ptSDN6ZGxSalFJaTE5VmdHeEVUVjlHTmticnZGS2ZLeHFWQmV6TkRVeTBH?=
 =?utf-8?B?V0t1c1lxUStkTEtqN3VPUVZzYXVBNFEvckxCK2FUeC9NM0FiYVZ0VkQ3amRv?=
 =?utf-8?B?b0FxU3V5MEVhSkVTQWh2M1Y4SFpQRkg0MktzRkdrTDZuUUJkRU5pQXpJYWpM?=
 =?utf-8?B?eUNhaGxKMStOWEZhUm1KUUNQbDVHeE1LcHIyUWhreU83TWsyZnBwRzZ1bzJn?=
 =?utf-8?B?NldHSDdEYmJFQVlwS2ViSXcwbzBBL1pqNExGVTJWMS9LWnRldGNMbFVmMDF2?=
 =?utf-8?B?T1AxczRFS0hUQWxKTXd5a1dPQmdSYTlQWWpSRngzQ2NBZWZrMTVNdW94dFJl?=
 =?utf-8?B?c2hoY0VZZzkvWkpEUHNYNHJqdURjUGlCSTg1OUNJM1plbjM5OHVwSmRjajFL?=
 =?utf-8?B?clFjVHhNc1ZydzNyUEcxZ1pGVlZSK1ZBRk1WbEtYVkh5cUdEOUtyYzkwdjYx?=
 =?utf-8?B?RGlZdEhzUFJ0TERPanBHS3VYTWRTUzJpZnc0R09uWGtsejhTVHpTNTBqVlAr?=
 =?utf-8?B?bG54cVArQWRVdEtKV0VTMy9QeDQwdGJQYjYzYjA1YUlnc3ErR2xvWGtTM0p2?=
 =?utf-8?B?Z2lqVDc1VUFreGk0ay9vTTViV2dzanFqMGJkT204akFyU0hocUpyMmZtdnBE?=
 =?utf-8?B?b2xkcVpVUVNlQUJMamRFR1lTYTBXb0NybDJ1Mnp4azkxRFcvcUFDcVBvQnU2?=
 =?utf-8?B?UER5VkdRYVkvbkErd21QSlMxYWZPV1NNNDdaUW9WejVPYnlDS3hzaURvUVI1?=
 =?utf-8?B?OTZOV1FZOVE2MDh5RWdoTSttNkxTcUF6TFJEd05qL2Ixb0F0MnVYeEs0Vkgv?=
 =?utf-8?Q?LjpRJWITQfYDhilHMFYYcEiecVwmciSX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWpjMmEyTGI5Yy9YaGRPcHF2U2FHMFpLRVVWN1g3OU1WYm41eE04b0V1Ujds?=
 =?utf-8?B?OE1FNTc2QnB2V2FlMmxrMWV6MmZNR05hUVpweEloUmVhWFpJTmRVVVkxbCtJ?=
 =?utf-8?B?cnlhT0FOTmZ6R1FPa3hxb3NoSCtJVzFFNUtOZm52enVEd3AzUWZaUXowZ2lj?=
 =?utf-8?B?dklhKzlOaS9oUWMxc2NSTUkzMzVDNTZiVnN0cERsTzNEaHM2dFBTWVBqSVF2?=
 =?utf-8?B?L2JNK0QxMGV2WkhNMFIwUTJxV2RyWFphS0VJbWg1bkJBY2R1YkpWeUdtSFpF?=
 =?utf-8?B?YTdYRTdyeDRvQ3FxWUJyN0YrOVhZQkFNMkxEblZnSVR3OTJvWEd3d0RpUkRJ?=
 =?utf-8?B?THdDNmRNVWNKTEJLRXJMWmQ4UlNZQnpheUlPdjcwb1FWRjF0alIrQzU4VnNa?=
 =?utf-8?B?RlB6czN5MlRFWEM0SmF5M1diTk1yeU1aQ3d0cFVialFLemhxbk5kSnVUaTlF?=
 =?utf-8?B?cWx5YlNscEg2WVh0WXh6MmtlZSs3U25FN0xMNDZyQkhRS2s5WXR2K2cwcFJH?=
 =?utf-8?B?RXMrWDJZNks0NVF5MmN6Vjl0RWtvQ1cxT0Rnc0tIcEE2ckMzWm5jWWhmNFJ5?=
 =?utf-8?B?Rm5Dd21xOHE4ZWdLWGRSOGg0YlZMMmVEaWpuQ21GVUQ0RlkwV1lCMk9Md0kr?=
 =?utf-8?B?b0l4dE5WRDk5R29iRWpTbzRxSVdLbEc4ek1nZE1jS3l3K2pyWlNycENnbVBp?=
 =?utf-8?B?bm1xS3JBdEM3TlVBdXFsbXkzOENKTnYreVNRQVFBUkpjdW10djFzNnMrR3F6?=
 =?utf-8?B?WDN6NmhWRy9vUU16T3dDTi9jSlpRRjBYSFdGK3VJM1RBc2gwK3k0Q0VEbmkv?=
 =?utf-8?B?K3Y3Um5UUUpuVkR3T2gwRmxuNW9sN0x0azNLMTErSklaWmZYQ3BRRmRMVUFr?=
 =?utf-8?B?TTB6WnM5SWZ6QmFHYlJUYVQ2WkJ4SGlYR0JubDJXZWtrTU1kVk1VbjNXMnNp?=
 =?utf-8?B?NEhURmlyVUpaU2ZqNXNRUjFLN1BsSmFPU3p0a1gzaUNkZnRLaHdyd0lrNGc3?=
 =?utf-8?B?SVIwYThjb1VzZzRZMC9NTXk2aUt4UkgraVU1VVlqcHErNUdQTWp6Y2pOVkQ4?=
 =?utf-8?B?elFkMVk0MklYWXZvNll0bkhCS0k4Y3BlUWlKUjg5eHd6S25wSkYrWEdyVTh6?=
 =?utf-8?B?OFV3MXdoZFdIV29KU1M3S0xGUlBLekVsWHJ2dEdIMXB3NTU2b3dxKzVHZ2lz?=
 =?utf-8?B?Vk9WN29HN2k1aWk1aUR6Yk5qaDZHVWxSUkNjZkc2SEVYdTZwTHd5ZzFBeUk4?=
 =?utf-8?B?VU4vRHNkVVplNTR3OFRMSHpaTW92S0hUUEVlYW9VcUV2QnROZUZVTmRNRTUz?=
 =?utf-8?B?VDNUVm5HcUV3R1VvQlhBci93bWxzemlpYjF1aVZRS3pKTW0yR1ZnZUVRMnFy?=
 =?utf-8?B?RTZRejY0b2UxNjZlOFVIL0NONmRLbHVkd1pQKzRoUmE5QkYvcW5yRGRZalVa?=
 =?utf-8?B?NnhLNVl6b0wwdXJ3RTk3TnlGYjB2QkMxWWxHMW8wSEY2UFovYTFmbDk0czBk?=
 =?utf-8?B?L1M0OHNKcHYwN0tqNzZraUg1YWRiZzJROFRuSUwzZCthb0cyVnAzR2xUcFZZ?=
 =?utf-8?B?V3laY1VRb3JVN1FqSzh2UE9OemhlTlM2TFBWcVhIMjJQN1RRelhMQ2lmdGlO?=
 =?utf-8?B?UEE1SDRXbkE1b0t6OFl4VFVqRURRRnNYd3JOQld2SHErMyszU1pLejM0OGI4?=
 =?utf-8?B?UEJBWHNHOXlZNUdXcXZzeWx1UFhUOFk2UWdaUk1HWTNFKzRtTDVHcmU5SUxJ?=
 =?utf-8?B?R216MVdWNy9tUksrQmVCZTBLTnY1YWxuUFYrNHJJVlVYRmJVeFhRSGluM3Bi?=
 =?utf-8?B?Y1RvOXZpY0c1UkdTZXBIQXNYU0gwRkdPbVF3VjVINTY4clYxLzZjQXJHZEU0?=
 =?utf-8?B?OVV5eHZPK0hJeEVZN0dVSEhUUzBncEhOSHBBSjl6WklCTjBDR0QzTXZpNE8y?=
 =?utf-8?B?YTVCeXY5MlVMc3lMSlc3N3JBSU1jaGZsbkl6Qkl3OUFvV2tadlFWVHp2em9P?=
 =?utf-8?B?MndXeVlwTnlPRUZIZ3EvV08rNVBSRFBGSDFNR0VEbHBKdXVwTDNKa2xnbE5w?=
 =?utf-8?B?TUFQUTY2Yzg3OXVWc0VmRndhalFMTkRQUHZ4bGxKbGsxNDk1Rkh3RXlhL3Rp?=
 =?utf-8?Q?ZMsu0kiy1OL5hpzZTVj9FhMcM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e76ae53-4c16-4909-0c54-08dd3054a729
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 02:23:49.7275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6I0p7x2piPeVW0z1j+77fxc3lC2nuTmTHcwGENmDAKowFHrlxWDQL92kitJOJepuw66kBEEZHAqa54rluXa0Q==
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

i.MX93-11x11-EVK has switched to use upstream device tree, and use
"adi,adp5585". Since i.MX93-11x11-EVK is the only user of this driver,
so it is safe to drop "adp5585".

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/adp5585_gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/adp5585_gpio.c b/drivers/gpio/adp5585_gpio.c
index ea0cb75459b741c0157aa9077c44163b3c0cab01..114583b3c3bd9a51fbe1960b7532150d0d7cabdd 100644
--- a/drivers/gpio/adp5585_gpio.c
+++ b/drivers/gpio/adp5585_gpio.c
@@ -224,7 +224,7 @@ static int adp5585_probe(struct udevice *dev)
 }
 
 static const struct udevice_id adp5585_ids[] = {
-	{ .compatible = "adp5585" },
+	{ .compatible = "adi,adp5585" },
 	{ }
 };
 

-- 
2.35.3

