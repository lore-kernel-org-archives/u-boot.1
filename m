Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8303EC282C5
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:56:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1653E81219;
	Fri, 28 Feb 2025 11:55:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XLbizO7E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E21C81100; Fri, 28 Feb 2025 11:55:32 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20615.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::615])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED46809A5
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=duXu+U+YeWKLFZWHog3yPBB3snNb6SRcGRiQpT4cA1jN/uuPvneDVgn56jfTSZvuQAiwKsQZwzDqFJ12YbHqO8a9wdc0Oo8HorOUBMpmSwayYb9EZ479Rkvf9I+05YryjBVxvcgQOuz+enUHWycvoYBep+qze1nQ+rsxkl9XVFkl2tD3cZr1tFC/c5VCvQ/IYirlEEdJYhKFT/gH9b7KFtKTnXjpJi/VPh6nVG1X4wpKVQmSzW3kgA5FiwAQR0CLrdshA1Dl9CmusSk+H8+aMA8lxfACbSfZvjuME/yqOVDZW6XuQC31IOxp9097AsHS/MHmLFchdPEtS17EEMu4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYqGAftW9Llk2yInfDDJm/PSj2YTwHglkH2DaVfXqLg=;
 b=qMiWpeO7/Pg0kNIn+XvdngsFBSzByIPiqXAffg56lB4wR0+H1SjdibWwnA9xf/p/K2VHi7QYrzjd2mtYLu2xaq/XXm44DbNPHeUfMMEZaqiMr/l9BCXTA4lMsXvQ38cLUTpA1I79Syqxu/UqiAATqdhSKFXsjGtXNJBjQLyQ2cjEXo6dwGCY5bSjEN8d9n+LiFjcuEU/pnc849JMREIlmuk0jOobpBFGw6q1goEO8zLFTHqLrE8N/PpplWdwgfYKyYD8ApYIlon5SKkNuHXMWW6Dp2DuP4jnWsRCVxtWH9IeI4Py163YLgVj4BNQ5tagWDMNYjGEiwahJpok1lsw/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYqGAftW9Llk2yInfDDJm/PSj2YTwHglkH2DaVfXqLg=;
 b=XLbizO7EA4+wXrTI4MnrrDcMptCcWomFYZ4PpV06cuFr+i7lb0H2t52L8UU6oMh0CqPYoVkAd6Pe0E1f/cKIveXwBVKSKeb1TS1a9C3Kevpoz7ptKHr/FTL6SwyRWSOJa9+dngCkAOvuBs8C7e8/OWQTWci+5EZ98fiNlO2OeV9nDbTtPjWplUxFa2M1v9Y3bvFeqs8IxuhgvqVGmBgF14i3u+gCpOtunVqjESasC5WX6t0X2v6E3qRMXDKpuwWWz8pEV/L/+EbSoiXNTerELnpc3A/5pQ1B036EjQ3asjvn1qV9RFEtXumLFmJkRzKF7OmaJospSHq42SSPghBvLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:29 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:29 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:04 +0800
Subject: [PATCH v6 13/20] imx9: add i.MX95 Kconfig and Makefile
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-13-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7d1942-7d0d-4dbb-bead-08dd57e669eb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGJTb0NLdm83MVY1NDVmOVU4RUZVOEx4dDd3TnVadzFlbUFVOUlnck1VRGFz?=
 =?utf-8?B?RUZZbVJIUU5lb0NKemw0c0JBR1EzOERBV3FPKy9NbnZVZmNWdzRWZ01SakdK?=
 =?utf-8?B?bGtoQVVVeUxab2xHb0Y2TVRac2lqRWZFb2RKUm0zb2NYRStvemdZQjZEWU9C?=
 =?utf-8?B?R0QxVkFXalR6cWRQQWFQVmpNczArZjJlQWRzdDVvL3Y1czB2NCtHSUlSMjNu?=
 =?utf-8?B?ak95WXZaSHR1YVRIZWgrZGpRQUJRaGdmSGUzQ1V3RGJSVUp0d0lXVjJubk5q?=
 =?utf-8?B?ZzdGL0hsemh4dWRHMUV3cHpYZ3ZXb3lBcTBDaTlqZGpGdFUxM3lFRGZMSjJG?=
 =?utf-8?B?TktIWE05VWdmRVU0SWZxMnBDZG9qUjdYZWhvTmVKN3ptUkxGTnFCTUtaUm8y?=
 =?utf-8?B?TlYzOWZlVE1yR1RIS2JlY0xHTU5qZG1wS0J0eTFrdFphbzA4OWRsVm10YW5W?=
 =?utf-8?B?cXFrZ1RNN3Zaa0E3UlBKUTdVQXZLazhGN3NRYSs2VHg1Q0t0QTdEaXZXVm9a?=
 =?utf-8?B?M1NDUFZlcG1TYzkvZTczUDMrT05DbmZFeTVua2FHaFl1MVl3STNFOTRUUHF4?=
 =?utf-8?B?RUN5bjlWZHVxVjlpQ3RKZWFrM0E4M1VrQ0VvcUwrbnNjcmRPWndlZzRyOEsv?=
 =?utf-8?B?ZVI3Rms1OHMrMkNQeHZXOXFGS0Q4ZGFmUENERkJmNkhnQ3VEUEhxUlZaTmQv?=
 =?utf-8?B?NDdKY3VjK1JKRTJYYW1vQXZndEVkUEVtRXRmdlVzamo2akNySTRqdmZBUWdC?=
 =?utf-8?B?aTFxOHBqT3hYMGJEREdpNWh0MjBYVzIxbGZqTlV2cS9oUVBJVnZhNUtHUkor?=
 =?utf-8?B?S01LYitubHJKR1BHV0NUY3RMVGhJWWUyY05XODhoVFIyS1hwVXNNWU9TVW14?=
 =?utf-8?B?aTVNQmdHblQreHNOMitZREgwaGpkMnovUHgrUkFLWkFRMEVpNTRxRm9iUTZT?=
 =?utf-8?B?cDZyb1Z3R3hsQnl4bVpzeFNWTWhYb29Fek9nUGRYTlZpUzh6K2lITXM3MzNx?=
 =?utf-8?B?WkE0YURuK05zakZTd2ZDY0Zud1BaREY4L2xGY29BUDg3K214ekNKbEdtWDl3?=
 =?utf-8?B?eHZFZFUxMHBSQmE1cDFNbEFMM2MzWEhiQjhGV1N1Y3FCeXlGaEthc3dNS3BJ?=
 =?utf-8?B?Y05IaXNJQ1plMXZqZmFObmh2QWNiUkFYZ3NCVmM1emNScnlGdE4xZnZyVDlk?=
 =?utf-8?B?bjkxT2VUenRYMVZkeGRyRlVkTHZsanlWdTl3OExXcFlOOFZsWjJGS1AyWk1W?=
 =?utf-8?B?L1cvSCtlVm5JMk5jbHFJd0NUclRMUUNtTkhQVTlLVE9GMXpKaWZNYXA4WGph?=
 =?utf-8?B?T2ZsZlVLd1FBc0R5MnRqMlJXbCtYUWdENE1wRWF2cHJRS0s5enYreXh3YU1z?=
 =?utf-8?B?ZTlZUllSbG40aC9GV25idGtqVFFVVVdmbTJtdHJYZ2VNWDFLN2hteEpWYllm?=
 =?utf-8?B?RzNjb0tFVGROQzBDVTJEZHVUSlcwU2g0N2EvaU9uNnlQV2UzbGl3RWF1RTdX?=
 =?utf-8?B?Z2YwZGhaQzI4RVBEZk10bXBUWXd2a0c1RmxaRXNOYUFXeXNVK0xYR3hqK3hW?=
 =?utf-8?B?T2lwQW1rRlpBTGRqN3lEL2pzQ0swVGowM2ZJUVUwUzBRd2YzOERvTlZWcGp4?=
 =?utf-8?B?VHl6Q3UrT21xRWFLbnZVcWU5aE9XdDdhcGVNeUJBVVJIa3h3dm0xU3hMTDBL?=
 =?utf-8?B?UE5CTUxXbFNhK1pLdjJUbm1uak8zMG9kM0JxTjdVNFRGZkN3bFN6MmVScjBC?=
 =?utf-8?B?M3BGRTRuTnpiQW1zaEtyUEdQMXNmOGVyQlBwUTV5cENZVnpSNlVhaGdvd21m?=
 =?utf-8?B?M0IvbDlBV1ovS3BsSlV1eEdmUmYweWUxbWt0TWtYR015eFNyOWlBQ0x4VFZK?=
 =?utf-8?B?cWE0RVZ3RXFzNlRrdWJpcVZLNmdVc05XU0M5TEN0b1pwcERwQ0VZMmRJd0xs?=
 =?utf-8?B?OVowc0JBUHE1cEdQTTJXZWpuSHNqQTlQbk82cGNrM3NuaUQxSzhVOTh6VlNk?=
 =?utf-8?B?dUF6eE94d2RnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkVxdGQxSkpaV2R6MWwwY1U0emZmYUlreldXMEE4dnl4d0dZQklsUlJ5UUg5?=
 =?utf-8?B?NmNRZGorSjhIenM1RXVuUzJ0OXBTNGdMZ0RINGdDbm1naFJDT1hkNEE2OWgz?=
 =?utf-8?B?SndEeHJWTWRxanVEVE9lMmxSaytKc0xxdDYyQmJWdGlEdzEzY2VEblVHeFdh?=
 =?utf-8?B?UUluMTFJeitqNUZKTThiMHZlbm1iNGlMVmV3U1R1ZGg5YnJmLzVobnRmWXZO?=
 =?utf-8?B?L0JlS1pOQ1NGSzlhWE50bmdTeEFKN3AxTmFXZDFkVW02VzJ4Q2g4RW92cTJY?=
 =?utf-8?B?MFpKeTBKbFo0Rnd5cFdHOVhHOTVCVHFiU2tYZVE0enM0eGJWZFdwY2N2cGVa?=
 =?utf-8?B?QXpRa3hMVW01aXpBTThvcGd5cHhvRWZhOWZXZG9HbFBoTWJWakx3R1hVeEhC?=
 =?utf-8?B?MS82Rnl1V1dnUW9jd21PS2J1WWNGeEpZMjZtdndWV2xGRk1pMis3aXBJTWlR?=
 =?utf-8?B?NENIdnYwT05jL28zbk9oWGFDaWRtZ2R1R3pFUnQ0cFRYSm1wOVNPU0lLWWtQ?=
 =?utf-8?B?WXhid2hOZjZ5L3FhdUdPODdkOTlQWENGOHlnbmhKR29MZzVjSldNdjlxRGhi?=
 =?utf-8?B?akJDZVJBNzRCb1ZVN1k1d2hyRGYzbFJyRGhPcWs5eUhLRU1acUlSNDg4TGR2?=
 =?utf-8?B?K1B1SUZaR0QwU0VkZXBLYVhEcFE0UVVTUkQ3UzI3OGRmc2FadEZxMG94VlY4?=
 =?utf-8?B?MHRSRk5Jc0lONTJxSit5MjBXeXErRWZUN0J4YStXUEh5SVBqRXRxYlNTVnFk?=
 =?utf-8?B?M20vV0pkZS9RTmFXWExJZEk1VU1BandOVmdBN1V5SDNOUUphTVhZbU9BQ3R2?=
 =?utf-8?B?alQ2TzRMS2FLOUViTjd4akZlMFhMQi9neVo5VFlGazRLTitkbmFZeEk3R3pC?=
 =?utf-8?B?L1dFWEhMd3JJK0hTSTloajUrMFBweE5TL0N1cnlVZFN6SHV4T0U0Yy9QS3c0?=
 =?utf-8?B?UDZNRm9Yc3BCWlJQMjFSeTI0WnllT1dnZE1mQ0VnVlZ0UTNWSTBQcS9Nc24x?=
 =?utf-8?B?UExxdHJaV2owZGRKeFYyZUR1bHlaczZaS05hQXlPaWNHdFh1dXRLR0R1QWEx?=
 =?utf-8?B?NUw3eStXVmgrVmUyZUFUWC9URjROelNxNHUzUDhkczhJRGtjRVRHYTFWeGox?=
 =?utf-8?B?VWpQMjhjak5FVTFrMmphVVowTDFDMWVod2hjam1jMklyZ1ZYc1EzUWVOTE9q?=
 =?utf-8?B?bndYZU5BUDN1U0RFVnA3SGdWOGNFeFJ3SDJoUFp2bURJbFlJSnpQYzJjamFJ?=
 =?utf-8?B?MWI0UXZSakg1ZGJPSzdrQnZQSDkrbm5EYjNod0RxTkFXY001UkxQMWZkdExR?=
 =?utf-8?B?TS9TTVpuSi9aTUpyU0tqcWZCRWZodnpVRFZjczhEaWZLVjNuMUJnM25peUda?=
 =?utf-8?B?d0RLOHROYzE5SVo2QkVyZ0o3aEpiQ1BYS09WQnZ5WVgxaGRKUnZ1Uk83UWZz?=
 =?utf-8?B?dWc0VlE5N2RpWUNUN3V1WUtkLytSOVBmU2ZnS1l0dkd0cTU0QldOV0JjVmsv?=
 =?utf-8?B?ejVRWlJsWXpTU3gweVBUT21xRVpya0p4TC8zeWlTZmVPWVZ6TzdxOGMrbkRL?=
 =?utf-8?B?N2ErMzEvTWN5SjhOZnI3cUNzaFdMeUJoMjhZY3RqMlRScWRoSHFVWkVOelVH?=
 =?utf-8?B?dlhiSkR2T1VtVnkzUFAzUThnaysvVmRVbmRMNmVaWUxxTHhSMEtnNk5TNVZW?=
 =?utf-8?B?RWlMMWk5ai9oNGxpWUxZTjgzZ2JsZXlDcWt1OTBsQm90czFIczFaTnZ3Vko1?=
 =?utf-8?B?d1FpRWxxT0pRZUJUa01aVmc5RzhrNlcwN0xKdFh2cHh3eDlEbVdKTjdvN0ZU?=
 =?utf-8?B?VE5YbHNZUC9lMGVOeE15QVZ0Yk1weGswTXloc2hHTkJNZmFiV2h6TldsSXh1?=
 =?utf-8?B?NnhITkE4TkQyWUlGZUFNWlRpQS9yK2w1Q3lNZnJTRGhOclR6MDJ6WE5GdWg4?=
 =?utf-8?B?UTNKMHd6SDhHV0tFR2puK2JhVlpJbEFqMi9XMXIweEdESFBEUlNOUFd2Ulcw?=
 =?utf-8?B?N0xYSDhvUGJtUVBiYW5kR2k4cnBDbEtFS2lSTzFmb1BMUXFDekFLYzd5SjF0?=
 =?utf-8?B?L0UzUkRBZGYrMzY4NmNXbFF5MGNlOThDTnpGaWVOQjllblJ0YWRHOCtYTVlT?=
 =?utf-8?Q?Rb9a7CB3PZkwDQX56Ki+M1Pu6?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7d1942-7d0d-4dbb-bead-08dd57e669eb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:28.9413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHlVffavPqp+Ps1IWw0YMNcJjkYoC+ZeFADxs2xXAtdv85ZIjnGsN05FCs/gZbmxp8DYwXmhYylqywYj6JKF6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

From: Ye Li <ye.li@nxp.com>

This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
 arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 49220c0955..ef364ca1a2 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -21,6 +21,14 @@ config IMX91
 	select IMX9
 	select ARMV8_SPL_EXCEPTION_VECTORS
 
+config IMX95
+	bool
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select IMX9
+	select DM_MAILBOX
+	select SCMI_FIRMWARE
+	select SCMI_TRANSPORT_SMT_INTR
+	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
 
 config SYS_SOC
 	default "imx9"
diff --git a/arch/arm/mach-imx/imx9/Makefile b/arch/arm/mach-imx/imx9/Makefile
index 45a9105a75..53cc97c6b4 100644
--- a/arch/arm/mach-imx/imx9/Makefile
+++ b/arch/arm/mach-imx/imx9/Makefile
@@ -3,8 +3,13 @@
 # Copyright 2022 NXP
 
 obj-y += lowlevel_init.o
+
+ifeq ($(CONFIG_SCMI_FIRMWARE),y)
+obj-y += scmi/
+else
 obj-y += soc.o clock.o clock_root.o trdc.o
+endif
 
-#ifndef CONFIG_XPL_BUILD
+ifneq ($(CONFIG_SPL_BUILD),y)
 obj-y += imx_bootaux.o
-#endif
+endif
\ No newline at end of file

-- 
2.43.0

