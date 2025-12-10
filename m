Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 405D1D3C92B
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 17:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3568D83AEF;
	Wed, 10 Dec 2025 18:11:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="h5eYfMMq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19CD583C94; Wed, 10 Dec 2025 16:56:06 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89BC8307F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 16:56:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DKUspN7tfx0sfhR2WRfjcENK7AdVQxllg7h5QKQT7Ii6zU96mCNwKqTv+ZHokn/yqtHqdfMLuysTms+uuNK0EZ3lnXMuxXlC8CacRdaY2vT7odAFmzoNRDnO98NVtGnr/B2D4tS8eZj3kZnH3pob6qiIQynMA0WmWVufXw0hdErwVT7bFvVcC8HrArMpQssCxKFuyFoGkzSbcWme4cwb1D02KE7+OqVt5L1vqbqriac4b7tV36CT4F50ZFhpibEqk/b2U28Q6KDxy/VSSPKUmUcadX/5ZLPE+EKEncjGMlPJLwgJoAoOOr4jRPgy8Lbl2jxrXSVa6704fwRyDIlYUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Xw6Z5p+xj8LoIJKjwCuI0QSC6Xz4OtwvSF/DQb+XB4=;
 b=ZwPzNKd3xrIZ0NY/vIn1RuNv2RmyzkXHHyksCobE39v+iGDzTswOJ8II65vb/7abzvPP+2fF0EdfctkeXspekbSGsAFADURMHa3CyGHKloSLC/msHA23fwCplDaAxOO6JLxAmsJuIIuiizXja+tbSv/3tVA+CxBM/7G6TSFUXWdz3anC8p2QaEdo++BrM4etoMcCisEGE7ltcGIKp+joljLr3G67MOzpk3q05HZSQgi1T2OwyF9my0wwlGo3GMXnZAREr9Le8nLdMZGoDYYbsMDmmEl8KTxuEW3wNAE3TjoI3J7LrWHeZ1bOjF4GN2nkq0Fjz3JH7MHNMxRxF3vkfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Xw6Z5p+xj8LoIJKjwCuI0QSC6Xz4OtwvSF/DQb+XB4=;
 b=h5eYfMMqO69ThkCfxqmX2Wl8Wf5gNjQ1KUM8l3hNS8KlYfDBUTWzSuLkvRX9lY2kdmC6w1DTdrRjPKMgaZavZZ2lYfdYTSV6LkSIhcdrgSDNLtoR1CbAtJlRDRvUedub1i8RymRA8ZsIVhQzrrUdpaSyyPi9wlR9hD1ZpNwG+pFif3Nycp1uC9BqElYdxZezsuy+5bWahkgDxp/GtWxqhsXF499XxNA95njD2SAO3UBUe7pQOKAf8VAXQfYC33NbBqxaoNbr8+F17byQhiEJN9TRBACLKC+bASYZpXpuEYLDII4TnnRYEGW4RFdkFpMAL3DqvqidTlVTCxWgHGfxEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PA1PR04MB11360.eurprd04.prod.outlook.com (2603:10a6:102:4f2::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 15:55:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Wed, 10 Dec 2025
 15:55:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 11 Dec 2025 01:09:31 +0800
Subject: [PATCH] firmware: scmi: sandbox: Use scmi_clk_state_in_v2
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-scmi-sandbox-v1-1-97a0401f8991@nxp.com>
X-B4-Tracking: v=1; b=H4sIAEqpOWkC/x3MQQqAIBBA0avIrBNUCqyrRAuzsWaRhgMhiHdPW
 r7F/xUYMyHDIipkfIkpxQ49CPCXiydKOrrBKDNpo7Vkf5NkF489FRncHMYwWWW9h548GQOVf7d
 urX3mhekqXgAAAA==
X-Change-ID: 20251211-scmi-sandbox-fa9f4f5808cc
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI1PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PA1PR04MB11360:EE_
X-MS-Office365-Filtering-Correlation-Id: eaa2f082-a8c8-432e-a46c-08de38049c97
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QndGM25ETmhjTnVkZDg5NExlYWZwLzlaSk5KMmdnSEFqdFFvUkhnYnhLVDlF?=
 =?utf-8?B?Mm8vSkNXTk5kbHRLWmErTHZGWjdtMjFpY1p6SGxyd3RQb0s2eTNycFZTNHpk?=
 =?utf-8?B?VTlBbldoakNLVjlBWGg3Rk9vZU53M1NjNGc0ZmdLUTQzcVl6em8wSmo0NjJS?=
 =?utf-8?B?ZzRKUDFzY3NEbG5mbjVGc21KUkhwWFZZZGJvNkh0T1VaZWs0YXJRN3pwZ243?=
 =?utf-8?B?dUJpcHV6RWlZdC82dDRuSUNIRVNDa0RsVC9kSStHU3ZZNGhQZ1o3VWZtWmt5?=
 =?utf-8?B?dVRtcnBvRVJZZk5RdjFOekRhdEJtblNBK1dHalEwQWhNVm12elNwVjR0eThh?=
 =?utf-8?B?WHNlQzhHRzBPdEdVTXZVbnJUd0lOTFRPZ0VOcGovSXhvZHQ1L2FSNWtKbE12?=
 =?utf-8?B?MTFWVFgrQmtOZVQzVFM2M1Bia2JFWHFzOGZWd2dlc2hmeUVnZUI2THhOY2Vn?=
 =?utf-8?B?dTJac0pPZnR2WGUrLzMvZWEwdFg1RzFFTkdlcWZES3ZNTXFsTG5ZQjhMbmJW?=
 =?utf-8?B?VU1IVy9Rdk45eVlaWktTRXY3USt1UVFXTzhxV1BvNkVUV1ZxRUV6UlhPeTlx?=
 =?utf-8?B?WnNJWnV6OThNSDRuUGFobi9Xak4ycmxNOHNMN3JRYW1tYkk0YWdMckYyNDcv?=
 =?utf-8?B?RGJhQlE4OWpuNnp2czJtOGx3cUoyVTQwMVNLRG5mbGNlQTBBaXcxU1I5MnFN?=
 =?utf-8?B?T0lFTEJON0dyTnZQMTBLWldVcy9aL0FqcFg5SjR4cDhrZW9jM3Jla0VVVUFN?=
 =?utf-8?B?SUFIZk1SRDdLSk8zTGdRci9mdWpNWGV5VWJ0bDMrV3FLN0Zja2crQ2trRUEz?=
 =?utf-8?B?VHpqNHdwZC82bUJxMHNGYzJpamlQVGg4a1hrTDd0U0F2ZVhhdmhDclg2aU5s?=
 =?utf-8?B?ek1odjJpSldZa2lvWkh2R2lqaVFzTnF3STlld0RCcWR2VHBkeFVqQWZUQXJu?=
 =?utf-8?B?VGpyb2FSVVNKNUVGU3ExWHdXQktGdDk3cFpxdkpKQ2Z3eHpUZ25vdlZSQlZv?=
 =?utf-8?B?djhoTFl4WTNvbmtxRWpnT2tDaDdHNWh4bHhJZUFzbEhoczdtWlBKdFJPRmpF?=
 =?utf-8?B?bGYrTE9DYk9LR2pWSXYreDVsaXIxM0YrMHo4LzJ1N2NiRVl6N1d2SGhxL2t2?=
 =?utf-8?B?cXhEdmtQSnUvMDFmUEpkRXZqc1RkMkU5Q2tYRENQWThPdmFuOTAxTXVETzh6?=
 =?utf-8?B?TG9XRmNOT3VUd2dyeHVhZm9kY0lKc1E3R3dDSzNhcXV1YWdSRW96UDRZc1pC?=
 =?utf-8?B?TGNLNUlkcjNlQ0hyOHgwRWRRSjJUem1GWHcwenJZV00zSlZlaTNvellFM29I?=
 =?utf-8?B?a3E2TGV2T2JiQkR1eWoxdkdNYy9HOEx2RjRlNlphcXpFRmZHMlg5RTF4S1N1?=
 =?utf-8?B?Zk5sYWx0UWd4clJKaXFXbHFsVGRhejF2cDJDci9COUJlN2dhclZjaE80TmNR?=
 =?utf-8?B?aTJOaXpyTUxhTGNBb2xDZVJQcVNhMDZhaFVIQXFLSGhTK3FSVkVPMmVraUVo?=
 =?utf-8?B?MmxpSHRudXVHWG5kcC9KeU9GQnRPVFJnbFVRZ0dQM2dTUStWRHREYndkaU9K?=
 =?utf-8?B?c0Q1ejkycUhaTHdxNXNMbWNCSzViemQwWjlCNVVuQmNrM2UrczlTS1llcncw?=
 =?utf-8?B?VjVLb3dGRXBLclVNR29qZ1drUEZLazZKYlBtcUpiK202YStkS2hISG1OMXZo?=
 =?utf-8?B?QXNSeTN5SEdXallpQ0VleVlBeGVzdGtBQ3pOVWMvQUtBS3d3Vmh3VGNjc0ha?=
 =?utf-8?B?blB0SjhaRC9PdC9wenBEbGgxc05oR2k3eFU0RHhFU1NLcGZWMDc1dXVLcDNU?=
 =?utf-8?B?VDgrNTE0ZzhsZFpYQjREWXNTVGVvd2thV2dkSHMwcGxXUjRaQ0s2bGNjMUMw?=
 =?utf-8?B?M3oxWm8xVUx4UzhUK3pScHNBQ29tOXQ0STBGNmt0SHZ4Q0R2UGw5M0JoZlFk?=
 =?utf-8?B?K0lmUmNPN0lYR3ZnUHA3M3pSQnhKVGdwMUdaQmZTNDVPcEZ6b0VHendtS2lh?=
 =?utf-8?B?cER3Y3RKNzNLajhzNzlJRXNVcnAremFvTjVSMllCUVpjcDFJeThkdGpOanYz?=
 =?utf-8?Q?xSVrf1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(52116014)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUh0REMxSkJkbmdDZ1BpdEUwOHJFYTIyZnB3L2o5MXU0bGJYemIxWnppWVJx?=
 =?utf-8?B?Z0o1MFhoT2xUb1k3eDlxM0tlMmVzUW9IdmxIWXdIZEE3M1J3WGVyaHR1RTJE?=
 =?utf-8?B?MFRKN2JTVjdmV3Q4cnIyQ0ZITDdZOWtHVFhvQ202Qnc0SW00SmtjTXNjZGV5?=
 =?utf-8?B?OVB5TW42cVp1eEhSMVc3VTArVVVnWXFBekcxbENsOE9sZldzalUvTmovTFlE?=
 =?utf-8?B?ZkJGQW83V0RONitYc2F6UnZtS0tzdGhPYXVyMUV5bWw0cEg4clMvSDBTYTcv?=
 =?utf-8?B?YWJ2YStkbTNEVjZreTc2YmxZZDBremRZL0dRNFFkRFE0dE9naEExQTJxeEF4?=
 =?utf-8?B?V2ROZ2djaTI5dXNieXMwbTdFMEs2eWkzSngrTmZWQVhMcU14K1phYm5BTk9z?=
 =?utf-8?B?MCtGVEpTK3pJeU9kQU1qQjVyWm5OUWJkZ0FkdDJDNEtKSVowS2wwbVRMTjlR?=
 =?utf-8?B?YlJ0R2YxSW9hTmVna2JaSWI5ekQycTcxOElHcmZRUnk5K3Q3SmNxQ05kWVVw?=
 =?utf-8?B?TzVmNWc5LzBGRkdta3VtYUo4ckxZMU8xbDI1TTBFeDBrYVVtMDE3VzRCallQ?=
 =?utf-8?B?ZG9xZy85b1Ftc3RLVVExNWJMM2JwSUVlN1JZL212bENpSFhhR3FRVWdvQmRS?=
 =?utf-8?B?T3dBY3Btb0V5aHBhSXMwRTRFRjFSZE1kN1BoVVd1L05sNkdwb0VmcnoyalJv?=
 =?utf-8?B?M3FTcDF0SCtES0NvM05RYzNJRDFxb1ZXb2EzWG5yd3NiZEs2dzVEMmQvU1BX?=
 =?utf-8?B?SUpNYXBMZGtOTHFkMGhYQzRBSXFPVmJESUZvNzVIWFRwdDZQRmJNV3Viczhy?=
 =?utf-8?B?WWRJd0hwd2hUOGMrTWRpb0JDY1M4QkFCWkNUVlZLeS8xL1E5Z2NXMFd3bkYx?=
 =?utf-8?B?ckxPN1RUQWUxSUNLc0hkZzNyangwT0dESUlTWjk4aW80TGlrdEk1TytBWHQz?=
 =?utf-8?B?YngxUGFZL3F0NUUwWkZycmVZUXhsYmpsQ2VFMjArTXNYeExaT0RpMVFqZm5R?=
 =?utf-8?B?K1RYT2ZiYXM1TVpFdW44Rnp1ZFp1RU9NTk9OSzkrOXhROEdIREk1OU5pbEdH?=
 =?utf-8?B?YkVlYzR3emo0S2JZU0E4OW55aGJKYytFMUZEcDB3VUNjOGpNYlZublFYVFNm?=
 =?utf-8?B?dFhQUk13aVhkeTJ0Nm00UllOYU1DbUEwZXNtNjZaV0VNd1NIQXlnS2tsa1Zy?=
 =?utf-8?B?aERGWlVmZXZHd0ZNV1FZUWY4cnRSdWJKYVRQU2hJbDV1RHhsanloTlN4Uldy?=
 =?utf-8?B?dGpyKzJRODNrWEY5U0xNMXB5RXdDUlFVUjZxcm16UlRxZFBsSDk1Z2g4cy9w?=
 =?utf-8?B?SmtzcDFSTGlCc0w3MXI0VStEQjRrcEZWTmZ3ZzduMXlBTER6UzE2bE5Fd1F0?=
 =?utf-8?B?SUJPWktCZ2g3WEhsaFpzMzBrN2VOeEhJdm5vQmxWRnBNTTgwcUlUdWZFaGl4?=
 =?utf-8?B?OW14Qit1R3lndTYxWGdDV09wMWRFUmFDRzZPVVBTZGFUZ3BuOTJtS0lmR1JD?=
 =?utf-8?B?ZHd4akhMajk3aU9DWG1lMXFVSjRGb2x0dDQ4cTd1VTI5Sy81NmI0aTRiZ045?=
 =?utf-8?B?N3VYcS9UT2EwdnNONnlrdW1GNzhiQ0NBQXRhREpCU3BNUlhXMnBmalUyb0Fo?=
 =?utf-8?B?N1VmRjRwMERJb1dKSndKNmJqZ3VIWGJyQ2habTkrTDdhbGIybEdIRWVjNFhO?=
 =?utf-8?B?MUxCR1puYkZjY2JKMkEwSXpoYXE0ZGFwMXZ6eVhvWDJ3azBCM0VrT0Z2Yjgy?=
 =?utf-8?B?Snh1Mi9CdGxXTzFZUlF1M1QrVmZmNHlqZlJkc3pVWmJ3QWFld1hGczBjOG5U?=
 =?utf-8?B?b0owdjUzcnR3MjllYzdYQ2NUT1o4QllOV0lHNEVHalNpb0RwaU0vUm55M1ZG?=
 =?utf-8?B?cExaNHZaSnF6SWlwTTZmaER0ZkxoVktJcXFqVUl6Nmd0TC8xdUYya2xXeEcw?=
 =?utf-8?B?bStzTWJWNmJGaC9PZjN2U1hucTFRdkp4N2J4NFdWdW5UWEVSOGg5d0N0ZGhB?=
 =?utf-8?B?OUFhaTNxWjZnVDAzR0lZYjNsK3BqM0c5clNmSjhzeGF3OXNzUzgxbzVLY1Jw?=
 =?utf-8?B?NU5oRWZ6Y2NQcVJmK1NhNVkydkExSnJ5aWd1SkxOZnJxOVhGaE1IYk9vOVVP?=
 =?utf-8?Q?m3P0jdfSKIt/wN75J2nxYaYZx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaa2f082-a8c8-432e-a46c-08de38049c97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 15:55:59.3619 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r26Fxo6GJNaWsMAzk7APrldxjye9k1vgtOS5ZVv6BMC2m48UbJMz31PEXL41DxqK+j4Q5oSp64x8KFo3QsLZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11360
X-Mailman-Approved-At: Wed, 10 Dec 2025 18:11:19 +0100
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

The sandbox scmi clock protocol use version 3.0, so need to use
scmi_clk_state_in_v2.

Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/scmi/sandbox-scmi_agent.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 5b242a039c2..010bf99fbc6 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -828,7 +828,7 @@ static int sandbox_scmi_clock_rate_get(struct udevice *dev,
 
 static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 {
-	struct scmi_clk_state_in_v1 *in = NULL;
+	struct scmi_clk_state_in_v2 *in = NULL;
 	struct scmi_clk_state_out *out = NULL;
 	struct sandbox_scmi_clk *clk_state = NULL;
 
@@ -836,7 +836,7 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
 		return -EINVAL;
 
-	in = (struct scmi_clk_state_in_v1 *)msg->in_msg;
+	in = (struct scmi_clk_state_in_v2 *)msg->in_msg;
 	out = (struct scmi_clk_state_out *)msg->out_msg;
 
 	clk_state = get_scmi_clk_state(in->clock_id);

---
base-commit: 0e0a198a68be71148f5ec27ef86796174f91436f
change-id: 20251211-scmi-sandbox-fa9f4f5808cc

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>

