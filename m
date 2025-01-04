Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FCEE77198
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 03:19:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC39180381;
	Sat,  4 Jan 2025 04:19:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="VVD8LaTT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB9D4803D2; Sat,  4 Jan 2025 04:19:46 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DDC8035E
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 04:19:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1HFgL/CMmSDw1WRM7qvty9K1L68a5NuNDI/JIYnF6Om4VNTCDRlcCLPtvWcFJlGIpedDjg5G0dXUzsyhGs6+tlCWZJK6nynwAYvOuqU8PdAmITE1mbTwrOz77q7y/JHSyFOQQRugBAfMXYZtoCet53MOn8db+FbyqYPb9Jd154SVnPHZv5xLP1nff3N8avxHUUNqi8ABYD3nMoJYdWooivkd8d0Z2hDqelt7HBY9RZHNms7j3xIeXFTbVDkO3cj+xrcPoxAHHit8LauNOAKoRaAqRgfuPxdbpBEkp4OJM8y0fRDkHPNNeq/FbbO0gd7GFQ5zvT154Vt3K0cVFOXUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUgmEpd4KUPYbz5y73UZYtZHey54UOF04txC6xnDdNA=;
 b=E+THQzjJzcRthZhRRmdWk/tXYPdm3yy695pQojEF/T/UjVIrAcvt8U7OHwnn2pHYCw57dHXCc2qWrV34k3VA8YHNpJEcoclTwX1SAExHEPBaU1xtupX4L0Mhi6Uk7KM67EvCgPQKxV6Xh1xfEvfv0oxyQ1CXC+DqbNDIhp3Vqplm9hwtOJV7iTKJ8SNmhwfQLfAN+DLpui2HJ224yEnwQrjcnSBOZ8Kslr55T6wT5w8xMVe5cDSpex6VmVML85/0mHYcKr5kiZp6/Tb7rjC8fjpHeGqszr7VTq6BZJenSdBBx2AEKc1o04BYZ19AtCr8gjFx4dmonpQ/jb2V0rkc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUgmEpd4KUPYbz5y73UZYtZHey54UOF04txC6xnDdNA=;
 b=VVD8LaTTPOyHkVfGZXmUsgy080YJpnzawAcBJNKP6fiA3SSto1Nqpog4y3EK7pqGXADGZNUszF4KcM0GT5cD8XcJQ59JcXx3Q7OM1Q3BgnnkVzMuPqiijZWMIp+DzUeYK1XNUI/yn7iqKYjfZladfeGKJya6YQQoUX83j7NwlHaNEChpFOgwKDIr6i9bX2QfdUWWrLfz3iHyQOnqu2D4NIk/PWSIwgQUDu6d9Q5WnGX6RMHCfeNqb06mJjMxqzqJfO8tyYEIAlHJqJCKExSC1bVH+cae/xuVQ8+kO2Ipo5ynBprqeq6FsOpiKGxmI5x+GRlr5XaexPFdXutpECjkug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA4PR04MB9566.eurprd04.prod.outlook.com (2603:10a6:102:26c::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Sat, 4 Jan
 2025 03:19:38 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8314.015; Sat, 4 Jan 2025
 03:19:37 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 04 Jan 2025 12:25:35 +0800
Subject: [PATCH 01/12] imx: imx93_evk: switch to BOOTSTD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-imx-bootstd-v1-1-e09618cc1d65@nxp.com>
References: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
In-Reply-To: <20250104-imx-bootstd-v1-0-e09618cc1d65@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA4PR04MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 85cc88dd-a0ac-4b6e-21e0-08dd2c6e9ec6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWc5dll5UzRiaDV6YlpKdy91c3F5ZTZKcUY5NlMvZzQyWTB3SWs5MSt1a3BN?=
 =?utf-8?B?Ykl4d3JORHVRcmNyN0twYzdXWklXbzl5YkMyVEN0TWVDT0FNUjM5cEFhRGMr?=
 =?utf-8?B?Zk1mZU5DdE1zVnhHWGxzelc4b0ttdCswdTk2WCtBRlVFT3pJNnJ5VTczZlhx?=
 =?utf-8?B?VmFGbkFvRDZZclFvQ2RsNVFCN1lKSGpIb2lJRHd3cTc3ZlNJenRaYjRXTndY?=
 =?utf-8?B?ZHJkMlJ2SUNoQkpEVTM3Ty9zSnBvV0R3WUo3cHdhNk56a3Bwd05sRGNXWGoz?=
 =?utf-8?B?bmJnQWQzbENJOWhFSE9uYkc5bFFpaHVqYzZrS2RCd2U2T0grSG11OVBHMzlS?=
 =?utf-8?B?OHJDYk4zc0tZNDlwTFZQUGhMWE51a3QzZmM0bjRYa2hONlVMVUNiV2xQSTNG?=
 =?utf-8?B?NWlldG1LN3U5ZkFFNnBLeXdTR1YwZXBzVk9aaEk5d2lESktqaWFIZlFiaVgw?=
 =?utf-8?B?dmZldVFCZXlFMmZ2OUF1U212TUw4S252bEhNSE1Td3BEUW82UjVtdVNzRFdL?=
 =?utf-8?B?SC9sRlZMaFVDVmw0Tkw5cWlZcy95alZEWWZwUHlXa3dPaUQvWUtmdktTN0pr?=
 =?utf-8?B?M1liZnRMSTFTaGVuMi96VEpYSmdLU080ZHZNMnZtZTBONXpEMTdIMEwvbkY1?=
 =?utf-8?B?UFZhYkRhSkxtcXQzODdDQnk2cEJaR3NkOWpuV3BwamZLODM3R1I1MDF3dUM0?=
 =?utf-8?B?ZDhCcVJDdnl3WTYzMW1Vd1ZYMUtSZjV2Z0xBQXdTbGNiYVFBbUY0MjNLczdD?=
 =?utf-8?B?bnlaaWNUNHBCSTEvcUtNU2UwQitaSUZLYkovRVRTeEZ4NjV0TUJhbVFQQk82?=
 =?utf-8?B?S2d2TzdVQTdvNWFiU3krN0R1cnRzS2lQMFBydDRtOEFtYzhiSm5IcVNpMzdD?=
 =?utf-8?B?MC93YVpWM3NlR290WHBoLzF1YnUxU3BkeHd4OWtZODdLUDIwOHF4c2hPdC9N?=
 =?utf-8?B?Kzl5UFdoNlFUMEhSMFFKUE5QdDdjVXdJOW9Ec202QXI0YktUbU9yV256VHhZ?=
 =?utf-8?B?MU5ITjBFcDNZclRZaVptN3Q5VXNDYWhZSVVIRC90VDNkeVNZbzBsKzh0QVFV?=
 =?utf-8?B?aWk4U05jZzF2cVY2OU9NS0cyaDY4TWhpRzJUWEx3NFEwdUZEeXFrZUd2aWJ4?=
 =?utf-8?B?b0dXcldWZy9Ud2hVdUVLOXRoSkJkVFB6MHk1NUpkS0wvSk1GU0ZZZEcwM1hN?=
 =?utf-8?B?RGF4L0o4RU1TODZja09XSXdFbWZPWmF2ekRGRVVwRjRVTi9tTVdmZU1NaUJT?=
 =?utf-8?B?NnFyeEVselRDU2NBZHdVT1lWcmZ5Y0l2RGU2Y1ZqQnVxWEFwZW1pNTFBWXo5?=
 =?utf-8?B?aXVBZWFueHc4SDN4Z2lFSkFLSXlTUmJOYjlDRmtDWnBWaUowcDRCS29EaVlT?=
 =?utf-8?B?ditxc0wvM3kzNVBkOGxwTnIwWVY0U3VjbkkvRjRUMmErUERYVGZzNjZ4eUV4?=
 =?utf-8?B?aFVmMTB4N3MzK1YzaGE1UmxNU0hmc0ZISFBPdVZucTcwRlBRMVU0R2NKZmp1?=
 =?utf-8?B?Z3BLbmdYOE44MEkrSmY5N2liS1lJUnp2YUFVQ3d4bHdJQjVkbE9wQTlENm90?=
 =?utf-8?B?eFlWcE9EQXFqRDRvbWZHQ3pWdUFmUkNPNVRtUzFRNWpzNmNUcE05OGpNOVRS?=
 =?utf-8?B?K3NPRUtwZHFDaS9iNWdxdmNKdXA3aEl3blA3bmVmNTBlRWZLeGhSamg5d1RL?=
 =?utf-8?B?MHdWOGtPdk45MGtmOEhNd3BNS1FNMVJUREZMVWE2VWtnaFg2TTdzQVZEYVJl?=
 =?utf-8?B?SFA2MzQzT0NMdytoSzNFeTFveWxpOWZjNWRHOHJtT1ZGWGhvZTdoQjBJT0hn?=
 =?utf-8?B?Z3cxQkxXQzF0SlhOaUdHR2NMMGdlbTY0b1JBNEFXQmZDMlNGeEk5LzVtL05q?=
 =?utf-8?B?RnplM2lnU0NOOXYrRkpzZTJObDNVbE5QS1Q1c0ZTa0hObW1XRDZ5RW8rdlN1?=
 =?utf-8?Q?MlUXDkpF7cU4/yuiLRrfp6V8OUs8Gv1J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clBlMTl5WTZ3RU02YmVTZmNsKytLWUJDck9XVlpqN1N0TjVuV00zUm1qZE9k?=
 =?utf-8?B?S0FUN0ZFMUYwaGNDMjFob0gyQUwyVjRndkJYMDVUeDF1VytrWjNkMDgwend1?=
 =?utf-8?B?eFlzbklkUTdZTlRiYUQ4M0hYbmRoQXFjMTNVQU9aaXl2SEdMZlZ2YTdZT0Vu?=
 =?utf-8?B?Y21YeE5ZaUxPTkYvTGFMN1YwL093VE5aY3pOOENjcHVRR1YzVXBnMklkVU4x?=
 =?utf-8?B?dHIxMytxbWp0WUlCVXB5QjVyQkZJc3ZMeGZtbWRTNE9YT2ZlV25jcm1LbGJF?=
 =?utf-8?B?d0xkdytKZmt5UnRUM3JrQ0pWWWY2WXVTZFBZY1llb3BpZy9HL3NIRmg5cFRq?=
 =?utf-8?B?ekVIUUtVWUFrcGt1anRESE9jbUV6cHJaTWV2Q3ZpZ0NHb2Y1ZzIwS09SR3F4?=
 =?utf-8?B?WkF2WFhkZHQyZ0hFd1VTSmNROGJpQW5ncUJKVnU3K29JWG4rY0xjZEJIdWZN?=
 =?utf-8?B?OHVmM2ZOeGZHcGZRakUwVXBMTGt3T0htY3NRUS9jZGhJdFdZS1hmT25HTVc3?=
 =?utf-8?B?RHk5TzR2dTlRWTE5NmdhM1ZxV0dUQWFQdWtsblRQSXplamxKTEJ6Z3JNTnJM?=
 =?utf-8?B?YU1YNkN5aCtrMnlablVza3NZQ09tQlI0NmpERFljRCszZ3RSamNiVDhDTi83?=
 =?utf-8?B?eUF6VG82eTlpSkZhNFZFNGcyaFE3Wlo4ekVXNGdHd213NUY5Q1RzVURjN3l2?=
 =?utf-8?B?SlpWbU9McjE0OW5mNk5lZnN3azVhN1NwdGNIeE0rK3laSDFGcmhCYW9SRkdw?=
 =?utf-8?B?azVrekt1VTN4N1dzdUV4YXp1T3FHKzE4aUJBTXpLTW1iR3ZVOUQ1MldpeDFi?=
 =?utf-8?B?d0RGQ1piL2hjamliOHBXanVYTU02Rko4dWNXN1BhMTEyTjZYUzc1bitqdi81?=
 =?utf-8?B?YnJYelBJSE1zZXdZeE1NbEMvZXExTC9LalFkQ1J2QS9OaUJaL1ZOOFRjUWx6?=
 =?utf-8?B?VGt5OGxrUjZXOGtmQkhieHRqNHcwVjFnTjBwTktlcElMNHJmUUVNelFMdXlR?=
 =?utf-8?B?Q0l0cHAyWm5SdjRjR2prTDcwOURzdnB3NTc1d0p2d3d0bkNvNVFXYkVvZklw?=
 =?utf-8?B?Wng2MXc1S0lVOHo1aHB3RU4xckFuVUlvNzAxVkJnOTd3emhDUTlaWnV1aXp0?=
 =?utf-8?B?OE1BN09EdVgwejZXUC9UM0swNWI1UEtUYnV0TDdOZmZwQUtmMmRTRVV6MW1a?=
 =?utf-8?B?WmpMUVdmWHpQMmpxL0o1b1plSzNsaHNsaWVsRjZhbU1iWmh1cUdNUy9IR1RD?=
 =?utf-8?B?TWpUenE0TDhFZFBkOFp4TFpuY1d6OHJBNm9PTGNneEdtUXNxZnlMajZQQnIz?=
 =?utf-8?B?Vm1WaVhMc3ZwM3BZWjNKMXFlUm5LT1g2c0REUWpac0VFMkVkT0gxcVE4OXU3?=
 =?utf-8?B?ZzFYc3d1Q3BRdUVwb21LYkhlejBMa3hoeCtVcWZ5OG4vcG5OL09vb3p2RFZ0?=
 =?utf-8?B?Q2pKVUNKRzFOK29STmFmYytHS1ZsQnNGMXo5dVFVZ3NOWVorbW4xVTUwVElk?=
 =?utf-8?B?dEJzM3JlMEJyUlJSaUx3ZDR2ZFhMZGlZWFpSNk82R052Tkd6d0J5R0pYUEJr?=
 =?utf-8?B?Tm81STlsTHVmM0hjQko3dmtWOWxLakhYZm5IQWt5dTNML2Uxa3NNVXBWOEZk?=
 =?utf-8?B?b1p3RHQwaWQ4YXI1Ri9MSUtXT1RuTkN0Qmd6bVdseFBvM3VTd1o4bzRlRWFl?=
 =?utf-8?B?UVltVldpeGtWK3ZWaCsvdElpQVR0eEl5ZEw0RjkvTUxHRWRjbVQyQTFPZzdT?=
 =?utf-8?B?STNyRlhocVBkMjNGRG1VbEtQdmRGalFaMmo5OWgvek4vRVAvOWxrSDJGNEpG?=
 =?utf-8?B?OXlsWkpSR2lYV1B6TjFXd096bzRKbEZRV0dYL1kyTEtsd2VTT0hUSVhZdjVj?=
 =?utf-8?B?dm56cjh3YkJ1emFBdmdtQWROYXYwa3VCTUpGaG1NMzBZSjVXK1pudE1XbVd3?=
 =?utf-8?B?YmpRNHZUakhTeXpTcGhjeUI1cDRmK3hWMDMyREtETStDUW1ydnVSL2hnbWY0?=
 =?utf-8?B?NWtWK2FSZkJYRlE1czFuSDBIZ1FVa2dKdG9vOGlPSnRQdWh6RThDNklFUXg0?=
 =?utf-8?B?cTJueFpSUmY5L2Q2NVVVb1F6WS9ocDkrd25ZaGpMdU4vdlREUGxqQVdKaHN2?=
 =?utf-8?Q?lomUy3lPf6NCS+WzxrhohX+Ei?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85cc88dd-a0ac-4b6e-21e0-08dd2c6e9ec6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2025 03:19:37.9325 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SJREWYQzZ36AItWONFDNPhUz4pfrSc0c0cFE3km+fV2D3IWdC4iQ85eBpBawFG/K4sZv++2dAFrO3wEYbSpq0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9566
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

Switch to support BOOTSTD with a bsp bootcmd as fallback.
Move the env to imx93_evk.env

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig          |   2 +
 board/freescale/imx93_evk/imx93_evk.env |  88 ++++++++++++++++++++++++++
 configs/imx93_11x11_evk_defconfig       |   3 +-
 include/configs/imx93_evk.h             | 105 --------------------------------
 4 files changed, 92 insertions(+), 106 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..c52546084394a7cc26f35c93ac8fb62d9c5fe795 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -47,6 +47,8 @@ config TARGET_IMX93_11X11_EVK
 	select OF_BOARD_FIXUP
 	select IMX93
 	imply OF_UPSTREAM
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
 
 config TARGET_IMX93_VAR_SOM
 	bool "imx93_var_som"
diff --git a/board/freescale/imx93_evk/imx93_evk.env b/board/freescale/imx93_evk/imx93_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..f692f42f78ab67f004a483d886388218fadcbc15
--- /dev/null
+++ b/board/freescale/imx93_evk/imx93_evk.env
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
+
+boot_targets=mmc0 mmc1
+boot_fit=no
+bootm_size=0x10000000
+cntr_addr=0x98000000
+cntr_file=os_cntr_signed.bin
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x83000000
+fdt_addr=0x83000000
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+image=Image
+mmcdev=CONFIG_SYS_MMC_ENV_DEV
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=${mmcroot}
+prepare_mcore=setenv mcore_clk clk-imx93.mcore_booted
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+sec_boot=no
+boot_os=booti ${loadaddr} - ${fdt_addr_r}
+mmcboot=
+	echo Booting from mmc ...;
+	run mmcargs;
+	if test ${sec_boot} = yes; then
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		if run loadfdt; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+netargs=setenv bootargs ${jh_clk} ${mcore_clk} console=${console} root=/dev/nfs
+	ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=
+	echo Booting from net ...;
+	run netargs;
+	if test ${ip_dyn} = yes; then
+		setenv get_cmd dhcp;
+	else
+		setenv get_cmd tftp;
+	fi;
+	if test ${sec_boot} = yes; then
+		${get_cmd} ${cntr_addr} ${cntr_file};
+		if true; then
+			run boot_os;
+		else
+			echo ERR: failed to authenticate;
+		fi;
+	else
+		${get_cmd} ${loadaddr} ${image};
+		if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+			run boot_os;
+		else
+			echo WARN: Cannot load the DT;
+		fi;
+	fi;
+bsp_bootcmd=
+	echo Running BSP bootcmd ...;
+	mmc dev ${mmcdev};
+	if mmc rescan; then
+		if run loadbootscript; then
+			run bootscript;
+		else
+			if test ${sec_boot} = yes; then
+				if run loadcntr; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			else
+				if run loadimage; then
+					run mmcboot;
+				else
+					run netboot;
+				fi;
+			fi;
+		fi;
+	fi;
+scriptaddr=0x83500000
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index df62eecdde455af561a23a54fde5dfc0a66d1835..ed7f021b4fa08c1a6b7ab3de721e1d3593766eca 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -6,6 +6,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x18000
 CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
+CONFIG_ENV_SOURCE_FILE="imx93_evk"
 CONFIG_ENV_SIZE=0x4000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/imximage.cfg"
@@ -26,7 +27,7 @@ CONFIG_SPL_IMX_ROMAPI_LOADADDR=0x88000000
 CONFIG_SYS_MEMTEST_START=0x80000000
 CONFIG_SYS_MEMTEST_END=0x90000000
 CONFIG_REMAKE_ELF=y
-CONFIG_DISTRO_DEFAULTS=y
+CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
diff --git a/include/configs/imx93_evk.h b/include/configs/imx93_evk.h
index 260a5043d5370478a6245bd4eafcf5f1c24b495a..eb40a69d20cb0aeec973a9c1a32a6fcfd831b967 100644
--- a/include/configs/imx93_evk.h
+++ b/include/configs/imx93_evk.h
@@ -17,117 +17,12 @@
 #define CFG_MALLOC_F_ADDR		0x204D0000
 #endif
 
-#ifdef CONFIG_DISTRO_DEFAULTS
-#define BOOT_TARGET_DEVICES(func) \
-	func(MMC, mmc, 0) \
-	func(MMC, mmc, 1) \
-
-#include <config_distro_bootcmd.h>
-#else
-#define BOOTENV
-#endif
-
 #ifdef CONFIG_SYS_MMC_ENV_DEV
 #define IMX93_EVK_MMC_ENV_DEV CONFIG_SYS_MMC_ENV_DEV
 #else
 #define IMX93_EVK_MMC_ENV_DEV 0
 #endif
 
-/* Initial environment variables */
-#define CFG_EXTRA_ENV_SETTINGS		\
-	BOOTENV \
-	"scriptaddr=0x83500000\0" \
-	"kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "\0" \
-	"image=Image\0" \
-	"splashimage=0x90000000\0" \
-	"console=ttyLP0,115200 earlycon\0" \
-	"fdt_addr_r=0x83000000\0"			\
-	"fdt_addr=0x83000000\0"			\
-	"cntr_addr=0x98000000\0"			\
-	"cntr_file=os_cntr_signed.bin\0" \
-	"boot_fit=no\0" \
-	"fdtfile=" CONFIG_DEFAULT_FDT_FILE "\0" \
-	"bootm_size=0x10000000\0" \
-	"mmcdev=" __stringify(IMX93_EVK_MMC_ENV_DEV)"\0" \
-	"mmcpart=1\0" \
-	"mmcroot=/dev/mmcblk1p2 rootwait rw\0" \
-	"mmcautodetect=yes\0" \
-	"mmcargs=setenv bootargs ${jh_clk} console=${console} root=${mmcroot}\0 " \
-	"loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};\0" \
-	"bootscript=echo Running bootscript from mmc ...; " \
-		"source\0" \
-	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
-	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}\0" \
-	"loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}\0" \
-	"auth_os=auth_cntr ${cntr_addr}\0" \
-	"boot_os=booti ${loadaddr} - ${fdt_addr_r};\0" \
-	"mmcboot=echo Booting from mmc ...; " \
-		"run mmcargs; " \
-		"if test ${sec_boot} = yes; then " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if run loadfdt; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"netargs=setenv bootargs ${jh_clk} console=${console} " \
-		"root=/dev/nfs " \
-		"ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp\0" \
-	"netboot=echo Booting from net ...; " \
-		"run netargs;  " \
-		"if test ${ip_dyn} = yes; then " \
-			"setenv get_cmd dhcp; " \
-		"else " \
-			"setenv get_cmd tftp; " \
-		"fi; " \
-		"if test ${sec_boot} = yes; then " \
-			"${get_cmd} ${cntr_addr} ${cntr_file}; " \
-			"if run auth_os; then " \
-				"run boot_os; " \
-			"else " \
-				"echo ERR: failed to authenticate; " \
-			"fi; " \
-		"else " \
-			"${get_cmd} ${loadaddr} ${image}; " \
-			"if test ${boot_fit} = yes || test ${boot_fit} = try; then " \
-				"bootm ${loadaddr}; " \
-			"else " \
-				"if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then " \
-					"run boot_os; " \
-				"else " \
-					"echo WARN: Cannot load the DT; " \
-				"fi; " \
-			"fi;" \
-		"fi;\0" \
-	"bsp_bootcmd=echo Running BSP bootcmd ...; " \
-		"mmc dev ${mmcdev}; if mmc rescan; then " \
-		   "if run loadbootscript; then " \
-			   "run bootscript; " \
-		   "else " \
-			   "if test ${sec_boot} = yes; then " \
-				   "if run loadcntr; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-			    "else " \
-				   "if run loadimage; then " \
-					   "run mmcboot; " \
-				   "else run netboot; " \
-				   "fi; " \
-				"fi; " \
-		   "fi; " \
-	   "fi;"
-
 /* Link Definitions */
 
 #define CFG_SYS_INIT_RAM_ADDR        0x80000000

-- 
2.35.3

