Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E032CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:58:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79ECA83804;
	Thu, 23 Oct 2025 09:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HOX+QV/T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C621382E34; Thu, 23 Oct 2025 09:34:24 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E94BC8323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:34:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ir1XRKbTJS8Eza4NzUgTVLVwqmQcvDUKGK/e9MDni5g4fmt2u8pV3xUysnCApN/5HkAh44MOcjjP5dYMiXrdH7DE52Zxisl2jwdrj9aIVIUEQtt/1yIJZ4sr8ShPAY6ljjUfE5LQeK2i7mMACf3uBXeT1CAxvtmLjwBa7qC0r3JzJTNDbykMb+9rwlzbK5fNZdheoYJjqBzxWoLhsFGXGhavOjnwvSAhel5qNb9wXV0d0Uf8qQdNHiegCGIHnTbEio+6EJ4MWqHWGgx48F8owIkitYc2xkjcfLQ6lhE0G9sL7TyMuIdpxTuQVTVRg6184+WYcfU6vyYIhw7v9Lgifg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKBZQpndR0i2Ts7TEi67CrjaAg/5s0H3JJUhD85KbkU=;
 b=JC/GKGLCw5SHXtSVrsgVulkGah8N488PO8lMi7QInc5hOLsm1s3+umnXGBVrTjctaK3Cgu8FC3e8AlwMyswCD6ggDMNkqsglLWM1iC7jFDa6hjX/03ZIS0HtyU4dDzFKNswcfTX0HoRq9l8yoBTYgg8pyLWH6hCB9GPPDGMSPnuo6ZJNNJ4fQD7w6TKQsl9z4sao9iFdk9JulafoBpRT600iLSbh9Kjk6XkqnZAxZTKWhjZxtKVZetvp0UMPvNtkJa/mOh1oEXglp48cdjM/NUF74jeOtPPpFBAxa+LA00tbzO6MIMWJGgRIlxLHtBstjgpMlqMDALp9vCAc4ADfXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKBZQpndR0i2Ts7TEi67CrjaAg/5s0H3JJUhD85KbkU=;
 b=HOX+QV/TPGh6xQin+rRgpYAFy7mNZN/4GxoJ9riDcyXqD5BZHTBNgRkeBkEnBAshBf74fF/hMmlWeWZXn4G3rDjxWnOlgmWAm2KBZQcZB+bxiPffxhCoM0Dl6ITsH3JCTTpm+L2diLv03n4y/wa0uCBgWlTlGwRILF9LCs15n1ytEcQUqhz1ep+/u8BhuNuqePyVJmeW3IDBAjidb4QjWNHy3mlKH3ziv0gKwHVpWQZCp6YPyOd7QTr8N9ah64dt5drv2Qh/cJ9LOTpLIBL3Z8saUIGflgrwNUj9BUAEqe+GPs+8L6tjpFoJOqTqEoOUznk1DJkJsgqvtlaghkfGiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:34:20 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:34:19 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de,
	Lukas Timmermann <uboot@timmermann.space>
Cc: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: exynos_dw_mmc: Add compatible string for Exynos5250
Date: Thu, 23 Oct 2025 16:46:08 +0800
Message-Id: <176120893099.2124.3979143770222484151.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20251014114057.67215-1-uboot@timmermann.space>
References: <20251014114057.67215-1-uboot@timmermann.space>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:3:18::32) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBBPR04MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2a87f0-18a8-4c1d-ab1a-08de120693fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SFRNdjB6MmR3SXlvb2pmbW5TWmFMeHhaZUZjZTJaNnFnRFpzcVROY1MxQ0U4?=
 =?utf-8?B?YWQrQnF5Zk5HandtTndZNFZNV01NVytIVkV6Z3NZQVBUV1Z0UnZycUg0TWVj?=
 =?utf-8?B?cU1rMkVlaTZFY3UxNjhwR1hNTGRnQk50TkVSMCtCVHh5OVFIdkFiK0F6b0lV?=
 =?utf-8?B?NkJmZU1Xd0x0cnpSZ09vRGxrVnBqSmt2a05wUUhJaWJ1RzBONVJzSktEaEF5?=
 =?utf-8?B?VHYvVFp3K1dxQjVWbEhxcHpuellocUEzTEhKQmVJdzg1cWduWk5Wc2hIcGZa?=
 =?utf-8?B?VjFDSURXMklxVWwxdmMxemNRK09laHkxV3RmRWlHb3dIRmdYMVhzUEZpWHFG?=
 =?utf-8?B?RjdOWEhmY0poeFhuVWZNTVdqSUY1K2FxZ2NlL0pYWlJvVlpzNUJmaFduYUNW?=
 =?utf-8?B?NDVmTi9nU1ovemFIcHQwcGJuUkVZNHhqT0MydU5QSGhjVGo1cUx2UlRwUG1C?=
 =?utf-8?B?RHExdjMyMUtHdDkwUGZlNkkwYmFGRWloc0N3T3ZDdVZRdXE2SXVkN1JEWGh0?=
 =?utf-8?B?M1RjNFJBRTA1ZWhrSjJYQ3d5U1Q2MWZoYSswVTNwQndMNlRnb3FSTVlMOWhk?=
 =?utf-8?B?aUdoSnlVV3JnMDVFd0FmT2pTdFpKNHlwdHFvWHU4UHBFZVBMM0JqRStQM2hs?=
 =?utf-8?B?bVQ3dTkxK2NGM1BjNXEzZzRWZjl0aVJYZkhQWU8vVEsrVThiRkU4NGR0SGJK?=
 =?utf-8?B?MFRsYVRYKzdyQTVNZzcvVHlVZVBwdW9GVjRmalo5NFA0cWZibUcyTUY0NkFt?=
 =?utf-8?B?RDNpV0JZTzdPUWswekV1dFVWc2F3UDlHaFdsbXJ3TXhUejh4bmtxTUFCWHdw?=
 =?utf-8?B?WW1KUzBoeUhXd2ZpUWZwOVc0TW9xdjE3UEwydkFEaGY0UDFuZVplOVl6ZUY2?=
 =?utf-8?B?em1uTkVJVWtlY1g4TXUvOFBqNHBxTUx1dm9GRzFtcUpUcExHK2M2eE5TSyt4?=
 =?utf-8?B?L1pIbkF4VGVVME5QMU5kZVNnMzZwM0lIaGxXbmR4L29adHNnemhObXhTYmN3?=
 =?utf-8?B?bDNCa2dJWGpCWmZlVkl5cWFjb0l1eFBEN0tCME9mZ210dXV4L3Z5WEFiSXJL?=
 =?utf-8?B?U3VkZFNxTi9UdnkvakllR01vb0VmVm1wTnAwdWpUTXZQampZQkhjcFlyNEY4?=
 =?utf-8?B?RFAyRzBCOFRQdFdTZWYyL05lQ0MwR1FISTVEU1JJWlZkVjhnQzVFZ3F6Tits?=
 =?utf-8?B?K0ZxU25WNVhNQ3NBY09ZVitHY1NTUUZnek9vdGk5ckdleGMyNzhOVE5INDBn?=
 =?utf-8?B?Wk16K1BMVTF6eUtXTWN5Z2xQZHFiSGFnV0U5NTBYdGFqMVZocGN5TlhPTjA3?=
 =?utf-8?B?VERONGIzNnJBazBETytFMDJoVUVuZVB3STUzcFI4cm81dGpMQXhua0d1RHl3?=
 =?utf-8?B?OU9TcjVJZVhNT0w3cStwOENMYVBLV1J6Q0F0V2JJUzJkV3VwWUI1Z21WVXU0?=
 =?utf-8?B?UzlwMjFIRjl3Q1FSbEdSZWNnK3BvakdjUXR3dW4rVzhIMCt5dnRaRkpLYzVB?=
 =?utf-8?B?d2d6VlRPR2xYbTRvREZUSEVnT1VTaFNSd1YyOEl0RTRrSExLZlpkZHBCamEx?=
 =?utf-8?B?TGJVZnREYVFvd3BJZ2FVaUd1b2MzU0VpK0lqUmFPYURWNG1XeHpwSG9KNW9J?=
 =?utf-8?B?TEFsZ0lST3d0WjhIZTdoTzh0RTZoZ0FYSjdYTC9YdEJVVCtPRm1abmx4TzM2?=
 =?utf-8?B?djN0d2grbG9rMXFONXdUUU16QlRWcWpmS09sLytBNHgvNUQzdTNUbHZEc0th?=
 =?utf-8?B?WCs4a3NLclc1UHFraUUwbDRLY3dCRjh1Y3RPWEFvQkxvVUlGRGU0R2pFNThI?=
 =?utf-8?B?U3UzQTV4RlpqTm9raXg5Vnpma2locldNcUphMC9jK2EyVmZtdXhMbU5YTkVB?=
 =?utf-8?B?Q29lZ1dZTGV6RFhaOUNuZ2lwRllQNXFpTGpHSG53bE01MlpNOVlZRzcrZ3hh?=
 =?utf-8?B?T1h5VzNaQWEwMnBoazlOdkQzc05XV3hoZXBEUVZHTzd2TUt1M052QlpoOW4w?=
 =?utf-8?B?THI3WVRpVTVqWVArQ0o2SEFMRlVMeHNidjlQN0VMQW9nNWJWL3JOanNuVlBP?=
 =?utf-8?Q?F/Vqyx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjF6ejk3QTRxMmx6WmQrc0dvVk11c0ZYK01XZUFqOFhjRTlQczByMzBpTHVs?=
 =?utf-8?B?dGp1anVVZ2tuTUlGY3gzZjBuN3VTcnE2UEh2bWQ0MHplVkd4YXBqVXdZUTJ2?=
 =?utf-8?B?bXhBaitpRGFYYVZxUUE5SWtUd1R4U1lsSTU3ZjdETjhTRnN2aVZYNmVtdmU1?=
 =?utf-8?B?UTJ4T1c5YXdoTXlZTmlZTTFMS1QzY2pGanJKVlovTkNmZTNSbWpWSStRaXFY?=
 =?utf-8?B?SlByV0hrci9FeXpkNk13aVFVS2NXL05mQWQxMEJPdmFQcm5WMEpHaHM0RkFw?=
 =?utf-8?B?dXlZb1ZxUHdjMUM0N3J6NnNWcVBhL1IrSkxVUkEySnlYVDR4RzhjWlhFUVpZ?=
 =?utf-8?B?dmpPL3owcE1UYmIxZnhtK2ZHU09xd3hYWmh3K2hwN2hiU1pVUFQzTFZJWFlp?=
 =?utf-8?B?OWd4RjRpSk5IYUl5UE9XTnNMSk45aHpGVHpQdkRMdldVZTJDeEh6WWsrN3JD?=
 =?utf-8?B?QU1saG9OWXdyaTBsOXo0cURsVmVycTJXVzhQd1ViMThTc2FWSjkwVlVTL3A1?=
 =?utf-8?B?VU1xa2F5UEo3UlhDaWRHNWNTNXpIOTJkK1VuOE9Bb0xpVVRSVTRoeWRZT3Jr?=
 =?utf-8?B?Q1o3a25qSmxpRHIvMlhQbDNucWgrZFc2YXRGeWhETWwvOGRQWlhvL3RiaHBw?=
 =?utf-8?B?OUExQ092bEtBZ1U4OThEY1RlQURFVTM2WlB4QVZ1K3NpUTU0dHJRWlJIandz?=
 =?utf-8?B?WnI2akFRTnVRTGlVWlBOZWEyWUJQN0tyZlY5U2dyNk9BUngvbVdPTEZuS1A1?=
 =?utf-8?B?RWx3dDBBNi8yN1VVSkhjS3NPYWVVb3ZkYWY2enZRMW1yVXUrRkk3N0c1amdM?=
 =?utf-8?B?anNiQVljbkFHSDdiQU5lTjZZVVhaOWFTOEprb0NWQjd3RjdBUG9JZWhjUS8v?=
 =?utf-8?B?bUx3V25VNytaWW0xa3dMTXY0djhkclNJdGI3bkhNUytZMzNJN3dWd3k2aWZD?=
 =?utf-8?B?QU9hYlR5RXFGWmRTc0lxZjlMcm5pSHhVNkVnVitRUDRSamtHc1hINTlXaEZk?=
 =?utf-8?B?cTVKWmhZYVpXVzF4OXdieEZjWG45RXluKzdxSDg3NUo4dno3M3M0VStLclEr?=
 =?utf-8?B?blErZi9pcTBNVVc4WGtYQTRFSHROSmdOZEVKUHNIT0RvckJtTVI5WnNOTkNx?=
 =?utf-8?B?cVZxL3Q3M2ttdFlkS2xFSzFUZGZwRHk0ZUZmbmVSZHBOSW9XSG5WaHlQZEh2?=
 =?utf-8?B?SVpPOVZWVHJHSE53TytKWCtDcWpaWmFzQ0xLdVpERU5WcXVadlpOSVdSZmtk?=
 =?utf-8?B?ODJOei9zYTV4YXYrV0lZNXg0M0tyU25HMkdNWldob3lUbnhwWlRzRWpuNXQy?=
 =?utf-8?B?RzJhTXo1aWwxbEJYdzhtWjQ0QVB4dkhuZW54TUVKYzRBZ0lRRUszS0pmUm5R?=
 =?utf-8?B?QUJJOU5YR3pNT2IrWTA2aUk1d25oZ2s0NW9BR1YrUEt0VDY5cWRKbVhFUDVa?=
 =?utf-8?B?Z0ZJcDFPWUZwOSs3T0FzaG1CanhoRm0rQ3lvY1lRWjV1a05sQy9NcEdTVFZo?=
 =?utf-8?B?NktYd3pqQ25jVHp4aTBxVStld0d3N0drMGwvV0x3WlErRTJHLzRTYTMyVEdJ?=
 =?utf-8?B?N3E4V1FjVkNISGtXVGtMRTNzdHVkcHNNQm11bExORmV6bUJkT0pKYTVtUU80?=
 =?utf-8?B?TnA3TE5WYXJOQWJrM0RFR3Jtbm00NnRSSnpNYUVrSUZEcHFsTXZDOWNYN2Fa?=
 =?utf-8?B?bFlnTy8yeDNsS28wVjE5b2d4SlJaS2JDNDNJTDV5RXZwMVRzOGhTU1c1UlZC?=
 =?utf-8?B?UFVIN29QY2dOVkEvcDhDVm5keVJ2akRPNWd5MVRUWGtWVFFiVEN5TVpZSldU?=
 =?utf-8?B?UnUrdzlVbHVLUmZrY3gzQmZLVitRT3B0elJ1MS9DZnplM2YyWHZrYUNlZzUy?=
 =?utf-8?B?UVVyaFNZSVhrRlg0bjdYVWNHY3YwMjFkSld0cTRxZ2FjUWg0UWErYkxmWEhw?=
 =?utf-8?B?VDNZVUpUdHpuL2FnZ2dEYkJqTG95NGxwTXJTbVhRamlxTjcyVmE4MFRuVWRa?=
 =?utf-8?B?bDA0UlRBbmdZYkRKUVZkY2Q0NnU1ck10ZXZIYkthYWU4b25YZE9wWTMwVzFo?=
 =?utf-8?B?d3FUQnVtTjVzaHlXTTRBVzJwMWRnOEN1dDcyL0o0SHJrQzdKNjk2MkF1eDhw?=
 =?utf-8?Q?4XfEN9LvJK9FXmoG30yQObyBw?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2a87f0-18a8-4c1d-ab1a-08de120693fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:34:19.8802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3lA1JTvkmOo+RRkouRIhE0A3I76oyOZkhPT0Yz2kV2qCEXz0cDoSk7zqwr61OhqqlXu/lJJEqVeOZCbnDDsD7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7737
X-Mailman-Approved-At: Thu, 23 Oct 2025 09:57:06 +0200
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


On Tue, 14 Oct 2025 13:40:32 +0200, Lukas Timmermann wrote:
> This driver got successfully tested with an upstream device tree
> and an Exynos5250. The board in question is samsung-manta
> (Google Nexus 10) which we are getting ready for upstream.
> For the u-boot port was just this additional compatible string needed.
> 
> 

Applied to mmc/next, thanks!

[1/1] mmc: exynos_dw_mmc: Add compatible string for Exynos5250
      commit: c3ac0630662493959305285210c011e8385f10ff

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
