Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC6ECCD193
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 17:04:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2A5678323A;
	Tue, 14 Oct 2025 19:04:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Y5BLZJ5y";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Y5BLZJ5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73EE88323A; Tue, 14 Oct 2025 19:04:31 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 088DF807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 19:04:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=dSvMFFlblsP/McFegsQeTRtUZGqXmXTu5lkvCe0ajcHUKCt4k4gdvBXn1djYkSZkR3O9MZwbXOFpu/g22zpD6Xl5gI3T64zFRsQqgyLXNZ5hP6a+/Vn8BaVPp4av0c0HLnuNTfvIuDCjbyy2WAGOAWLtCk99pxTzCKvmN+cqVs9XOS+QQdDrOhJNRuOhHjgj+1yeWdwpYx5Lg/gLYLp0O7tjHrMmfWSAHNiahdKYJ5Nt/jUMJBeb1R6fDlvHVFfk/ipSjvIuD7A0L7lscoHed8WekPSMsqovz5Rn5xszs8VrgGqVQQ3Owyn9/lo9duUtbGRejWtd02jUK/bcPCpxnQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSAHFEcqjqawyWRLIrjyi8BCsSA0Y+qoVAqTvHQRbY0=;
 b=Pz+qFg6zYgpTlACi2Udx0jcr4NcExJK+zEU2tSka0GreGjzXArarvl33hIPXttdClUC994dCC/Cosjg6aD3OZ8fdulqHE0a5SnkwHFRfxP5tfUDiWYDvi5I2aCYaHLBHNjp38EefuUiujyoiHOX4Ij+Zri3W9GOZUxDrTZh3knAXd/FTPbJV8dqMT5OvNn/+mQeDVMUpKgA29LnHfDHMOWLG9G5CoerlEgJtD+xIc9Bp8PIzl605MSKdqfXGKG2q8ZQVFZXISovFO6khnglXw1t3W3WmkYVAAdv71YWsX/+xHmaN+ZqCTr8YYdcnmqcsRaHNS0PfdLbOxassmcZtOw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSAHFEcqjqawyWRLIrjyi8BCsSA0Y+qoVAqTvHQRbY0=;
 b=Y5BLZJ5y1dUt9AwbmA1M2MSADYMfyjZiq6IGgg3KDwJPeqA0zyhldgS/V6uK2Mfa5uK7nSR5MTCZxYokwhEfxiCPJKBzdauXZLmAp6yO3ReXHt8zqo/jJlj3qYGuvA1rjJQ6PsKJ8XcnKJA3ckf8kKzQ9nyeGETgZaHBvuiSb3Dur6cuqed3pq0RkJDtull1mEEESRbQMA3VXf4q2ZKpQJNYtbPFwVkFCdTK855RhX3SO+U3lYz1Z9xWUt+KsLwLSSAF+tiQmMbdyaBTY1yo5DQXTKpCrdpuR4XfyNjr8wXs9xC58GjXyci8nw1xDgASfpaTosUQQm0RLpSF7g3pOg==
Received: from DU2P250CA0011.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::16)
 by AM9PR03MB7283.eurprd03.prod.outlook.com (2603:10a6:20b:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 17:04:26 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:231:cafe::49) by DU2P250CA0011.outlook.office365.com
 (2603:10a6:10:231::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 17:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7 via
 Frontend Transport; Tue, 14 Oct 2025 17:04:25 +0000
Received: from outmta (unknown [192.168.82.144])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 6742820081631; Tue, 14 Oct 2025 17:04:25 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (unknown
 [40.107.162.96])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 8843520081244; 
 Tue, 14 Oct 2025 17:04:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZ7SJaqk6FEUonca6A4vx4lzNmuCQwuKBCXEL8ksSRAHpU2o3pm4H8BF6QYKd1GGTe4Pg1I1wCZ8dNIp3sUo2pbXTIL9FCP9AYOdcLviO7kG39sk+utEsvkKzCmKtIx7lvY/tfHTJ28clUz+7/QhN095ailzgWRxMGcbcSN2EqwyXXO/hRCEl7qxSYAl6TsrFWoYujwxsfgeqNZXYr8JsvyrFRQhHgp2hwBAK5kDEtKPIrUjE0v/2gbAumDU35L/ejwjCmH46Afkv/8MN87jOeBbxfwsvPNkyT2ka0w9CfhXAZs+2VjYYXLf06m/TCxi424AK2pVKSazGSKCgVj14w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSAHFEcqjqawyWRLIrjyi8BCsSA0Y+qoVAqTvHQRbY0=;
 b=Wj2E4i+xdzyqZFT4qSerpbz+E3PqOi2PSR8n8jwVPW6so7AULcFtjmqmPNSCIvtvtzuwmK3hNx/EtuE1liiMgOFaCnYad5av93DbuVLwMSa1LLZzihOSX53P6/1DSa5iheGFFUTp1fUaeOgeOoO2lI+goH8dtBCrQZmn9eSDjboy8ihKyMyctEeyO19ySmiesStIaebkrkmB7rq9VmJF6Rqu/r9vJAes3RnydjkR5j7auLA9JItLXEewSOuMyKFiC9RPtN5EWf7phOoDtqMO2fXTYzZxM4FLSoTdbYKf10NzIQSrPtlHSyRIzxPNmXiUMzhQnH6tYLyaJuLeV/dWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSAHFEcqjqawyWRLIrjyi8BCsSA0Y+qoVAqTvHQRbY0=;
 b=Y5BLZJ5y1dUt9AwbmA1M2MSADYMfyjZiq6IGgg3KDwJPeqA0zyhldgS/V6uK2Mfa5uK7nSR5MTCZxYokwhEfxiCPJKBzdauXZLmAp6yO3ReXHt8zqo/jJlj3qYGuvA1rjJQ6PsKJ8XcnKJA3ckf8kKzQ9nyeGETgZaHBvuiSb3Dur6cuqed3pq0RkJDtull1mEEESRbQMA3VXf4q2ZKpQJNYtbPFwVkFCdTK855RhX3SO+U3lYz1Z9xWUt+KsLwLSSAF+tiQmMbdyaBTY1yo5DQXTKpCrdpuR4XfyNjr8wXs9xC58GjXyci8nw1xDgASfpaTosUQQm0RLpSF7g3pOg==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM0PR03MB6196.eurprd03.prod.outlook.com (2603:10a6:20b:15b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Tue, 14 Oct
 2025 17:04:22 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 17:04:21 +0000
Message-ID: <24072e36-64cb-481d-a805-e3b5f1f61571@seco.com>
Date: Tue, 14 Oct 2025 13:04:14 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fs: semihosting: Fixup smh_flen against overflow
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
 <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
 <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
 <b9e025ec-6b69-4d8a-837c-07c75bf3131e@gmx.de>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <b9e025ec-6b69-4d8a-837c-07c75bf3131e@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0221.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::16) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AM0PR03MB6196:EE_|DU6PEPF00009527:EE_|AM9PR03MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 14344399-422b-4e6f-cfd5-08de0b43bac2
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?bG1yNW1CLzhLMWx1UHp2QkliZGp2cUU4cDJaMmZmaGVML3dvMGN2K0RSYXdO?=
 =?utf-8?B?K0dvTG01N1hhWjdIbUZWM1JQRHVjcFlCSFhyRDkzUEVEYmxuUlkxclpkT016?=
 =?utf-8?B?U3YyREFqeElqVzd6aXlUMDMyZlpOS2g1VFlUbmVLR3pxTDNBU25TejJBRHpK?=
 =?utf-8?B?Sm5tYTBZU1FNd1ZPMDh2OG1POU90SXV6dFNKci9jR3Y4aHU1WTViQzBTUFg5?=
 =?utf-8?B?czVSUjJCVG84V3FJZGp2RTNtSWZSdmN0SWViUm94eWtYYlN6dm1tVXorV1ls?=
 =?utf-8?B?MTRsVTJUUEpuQ3ZzcjltNVhNc3RCNXZFR3NoQXpxQ1ZXTm1MWmEzQ0FHZE5X?=
 =?utf-8?B?TDZJb01yeHJuUjVSdzFFdEowK2RvVkFDL1hpQys5UGdwUFhLeDljV0x2Nlo5?=
 =?utf-8?B?UHQzWUs3cVlIV2V6QWpkY29Zb09VUlgrVVl5RFlJUGpqd3Zuazl5TUdWZjUv?=
 =?utf-8?B?TkU2MFBRbHZRNXZ2WVdrQmM2WG94Ykc4a3VRVTYyUlYwOFBLRDU1ejBIZURk?=
 =?utf-8?B?MkhpeVZQUzUrblVhajhUcktXTFI0WUFTUGErZ3NTMnhNNDY5YkhmbSttOFpl?=
 =?utf-8?B?RndON290RXByYmhIdUlNWjZJVkVXL2ZRRkdqWDMzNXhieXA0YXFWVXcvbGM5?=
 =?utf-8?B?anc5VTI5MXIzSzFITFRKc0MyMnM5TUFhckpaQWZJK05jSlFUcituU3J2aVlB?=
 =?utf-8?B?K0Jza2puTC9nUlQ4M1ViMEdKbWdKYUVDM1BVRS9wdDgrQ3VrOVo3M0tlTUND?=
 =?utf-8?B?MlVNZ2w5MnpVdStkMlpmOXNuMmJMT25hdURRWng2cW1KclBXVjh2UG15T0dl?=
 =?utf-8?B?dVA5eFE3c0Y1Yi9mR0xVMmdvQ1kxVDF2S2U0L0h0Q1BWUTYrZDhsTzl4N2Fy?=
 =?utf-8?B?KzlORHE0Rk0wMDllYnpsTTkwVHVFaDRWMUgwTm9ObmlGRlpZeVVtUkorOThW?=
 =?utf-8?B?aExkcjgvR2d2ZzV4T1hqRUkyK0p0Um5xQ0Z1dS8yZXVQcmRDTEpiMENJOU5m?=
 =?utf-8?B?ZG41Rms3bzRXOGN6Umx3b3JnL0ZVZ1g5aUR0bDJiU09JWkR4ZGFTTEM1NXEz?=
 =?utf-8?B?bjNQd0RHdHZ2OGZ3aFl4WXN4eHVmM0M2TnNIaG5xVTFqNzJBTGh6ZnZTdGg1?=
 =?utf-8?B?R3VaTlpuTFVVa013WjQ4OWNjSitwdkhRY254V0c0MDJ4U3Bma0Rnc2pBRllB?=
 =?utf-8?B?aXdZaWNIWTkveFZOWm8zMUxYUDdNbm1WODNiUEp5TW9iTVVDR3VHUE1sbVZi?=
 =?utf-8?B?L1VpMlVHWm5wSFMrdG9MQ2JUNjNvWkF3Q0RHbmZFeTlCNDNoemhrSFVabXVo?=
 =?utf-8?B?Qm9FTlFINHNDblVXV2hmR2pDZmdMbjRGODVIMldsbFovNkhSbGJLVW1FYWJP?=
 =?utf-8?B?VWEvMXNLOWl0MHB5bFpjaTlDZ0RLTnFOZmxnV0N5b3o5dXFPNVNTVE03bnRa?=
 =?utf-8?B?NFMxZjZ1dStqMFhnNVkwQ0RoU0thRXQrcjVwSE5IU2EvZTdFcng3MGNTRU92?=
 =?utf-8?B?bUZwOUpBcDBzU3VBSWs3b1pZL1dsUXk5cnJreE1vWGhiT3Nua1ptRi9WL2JW?=
 =?utf-8?B?c045KzBJVlI4OG5aYllzcHhIc2lxQ1B5alg3d2o2TDY1OHlLWWE1L2ovUmJl?=
 =?utf-8?B?NWNvQ0hSQm9MdmQyNHB6cnl5NnRiNW9OSTBWRVRoOXFVNjRZdHhXeXFSclBN?=
 =?utf-8?B?V29pNDIrMEF3OHlsMlRYVEprSE5MUkFEdVgzR3R1dXNFaHdGVGtmQ29jcnBm?=
 =?utf-8?B?SmRJaHB3YWQwUVA0WkZQeEpRN0RPQ09jcWUxT2hYUXNzZlhTb3Rhb1gwdkVY?=
 =?utf-8?B?NkdDVGVaczlKVWtPa0R0R0dMblFmb0RFRkJPV1dUVGRYMUxyUExSaitWRW1h?=
 =?utf-8?B?N2tQTWI3ZTNyUmhTUlJaZWdjNno4MHM3QnlYQ1owSytDeDdkdWxaZjdpZ1Bp?=
 =?utf-8?Q?kvTY10Bpn5C9bs5F9yeHHcncWtyHRTi7?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB6196
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: ff4ba811-3de9-4964-409f-08de0b43b85f
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|14060799003|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VmFJRGlCbitid0kwRGRlYWVJZ2tpcE5BV1hqSjVKVzVqekp6bU9mN3hXbnFB?=
 =?utf-8?B?SVdjeWdBNlMzTUNxWXcwL0szcjQ4R2xza3BMYjFWQmgyZlpvOWtKb2E2WlVR?=
 =?utf-8?B?cTFnYWJSK0dCRFc5Tnpza1diRVFFSkpsY09PUVNxaWYzVk04Q1Q0a24rWGxa?=
 =?utf-8?B?eUhCajhWYWJYeGd4cWt0Tk0vdXAwSkRMZXpHYlZrMlhSd2ZLTjRVaUQxd2tx?=
 =?utf-8?B?UEM4ZjZHcUVUSkZxd0dLZnFIWTcrc1Y4c2trVmZvL05qTlNNRW1NL0FjT2xB?=
 =?utf-8?B?TW8rQ2FRaVc1RXBGUDI0UHltbTE1RXZ4blh2Ui9Balg3S1RMV2wycWExREpM?=
 =?utf-8?B?MkhmMlhvc0h5a1JTWHVuclAxYlRWV29FdHMwMzljSmhhQXEwbDk4VlM5WHFj?=
 =?utf-8?B?ZDFMQWoyM2FvSkJIR2NNT2xRYmNxQklQandMMDlDUTdOamk4NnhiVTI0Mmcy?=
 =?utf-8?B?M1F5Z3FhSUlvWHV5OVZISlNIQldIUEF1ckRWWEN5TEhuU2lzejF4dldxUjZv?=
 =?utf-8?B?Tit6NlNRMDE3bm1yVVFSemU0aFRJQWZaSnhDRGRLU0tmY3ZJam96Vi9saW9E?=
 =?utf-8?B?emxyaERLVjZaRTNacWNwcDBHeW5iVzNHMi83c0hPTGMySE1CdUZVS05HMHk0?=
 =?utf-8?B?bUFlS1pjc1h5TEk4dTJaSGFoak1TZWJ4UWlzNE1ja3huUDFCOTlhU0MxWmRG?=
 =?utf-8?B?dmE3elpkMW5RSDJzbTBRLzRaRHhYN3EyL0pTWm5sQ1I0UW9kbDNBNTBQNTVR?=
 =?utf-8?B?SHIwNVJpVVgwVEJ5bEhMS3JRVE5WQnd2alRpc3FCL2xaaTVTSUU4Ri8wUFZu?=
 =?utf-8?B?VWJjRFB2QkRaMTRCMU56UGhqQWljWjkyZS9vWVJGcHhnbHplZUQvMDZMVlJ6?=
 =?utf-8?B?RmNKSTdCYmFRa1JvRmxvd21uc3RDYzM4SS9vQ2FXc0Y2Wm5CSjBmbkgvYjE0?=
 =?utf-8?B?V3IvNlJXcGpTay95R2JKN0FwdXhzOUdOa1FOeE1PcUhvc0VNZ2Y3b25jVlVq?=
 =?utf-8?B?TGlqVm9PRjBoK3dCdnNQdm1vL3RKZkxBTktZdXpWK2xkSFMxNzFteGdkREJt?=
 =?utf-8?B?NHVoNFF1RjUzK2UxWE5MODJLRlZyWGtWbzFoakNiTnZRSjZHQ2YycVdPNWlP?=
 =?utf-8?B?UDl1UGVWTHp6ZUhManBSRnh6bFR6WHJMaFZtUk92MGt4RHpjN2pBcE5ET2Uv?=
 =?utf-8?B?ZFUyTXVEMmdaMEZGWGdnWWhjaFFqeVBsRnM3emJOd3NWZDNwdjhNZVNVbkhk?=
 =?utf-8?B?VURpR1BNZEp6MHBxMEtQcGEvUDZDZElEbDZvdDJaUm41cU9ONHBldzVSd1Zo?=
 =?utf-8?B?U3hkbkR1WUNPM09tcGxtQisraUQzUVlSQXBBanNFRGI5TXBXanB2dmtKN00y?=
 =?utf-8?B?VEs0cUJCYlVQWFJRZUpPbmtRMlNmU2txdE0rM3dUdnNTRVVKZTlWb25sYmp1?=
 =?utf-8?B?dHpKU0RxME96b2N1eVJ3ZXV1ejZIYVA2OEpQRXo3N3ZSZ21EZlpYbklGYTFM?=
 =?utf-8?B?a1Q1eFBKWlk4RWc1VEZBRi8yM1NYS1J5QUJvcEhNSUdYdWkxTUpkNVBta0xx?=
 =?utf-8?B?MXF1Y3ZEeHh6K2dpcFd1VS9EbjB6YjFWQThnVDE5VFBtemsvUzlLZmlYS3Qv?=
 =?utf-8?B?U3lLTFhWT0VKU0NXRkdkdTNaNExNanpRTkFJRFRCYXF6T0F4cS9GTERpblk3?=
 =?utf-8?B?cU8vYkFGOFlaUHdKSElPdUxuWTZENVNLUHhVT3h1OFh2UHFsWUl6bTdkVzc1?=
 =?utf-8?B?K2Nidjh0UlM1NzJVa0xEZnhwd0VsaHBUOERKaEFpbXBvU1paUUhwSWN4YzNY?=
 =?utf-8?B?ODYvRGpPVmduTWFzbFpVMHo4Rkp3MitEcmYrVGNVeEpYMVZOejdTczFzd0tO?=
 =?utf-8?B?QlBkcVREZ1VmWGhRWlh2VGk0SkdVWGF4aW9tb1Y1WC9qd29qTjh5aktSMjhN?=
 =?utf-8?B?WTZHc2IwcVRTMzROYTRVTnBTeHpvR0M3S1piKyt3N2wvdWVldmtCY2hTMFQ1?=
 =?utf-8?B?YVdWRnJEVUVxdjl2dGt0Y1dsQW9xNzZNcEd1L0FzbVdQekppMDFZckdPWEt2?=
 =?utf-8?B?Q01FVm80UHBoODRDNW9laHVQSDVqd3BURFIwSXIrVTZRc0xUd0wyakptZ3dB?=
 =?utf-8?Q?NjZM=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(14060799003)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 17:04:25.6494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14344399-422b-4e6f-cfd5-08de0b43bac2
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7283
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

On 10/14/25 12:59, Heinrich Schuchardt wrote:
> On 10/14/25 18:21, Sean Anderson wrote:
>> On 10/14/25 12:03, Andrew Goodbody wrote:
>>> The sys calls SYS_FLEN was being used in a way that did ot allow for
>>> file sizes > 2^31. Fixing this required changing the signature of the
>>> function to allow file sizes up to 2^32 - 2 and also being able to
>>> return errors that could be tested for.
>>>
>>> This issue was found by Smatch.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   common/spl/spl_semihosting.c |  6 +++---
>>>   fs/semihostingfs.c           | 14 ++++++++------
>>>   include/semihosting.h        |  5 +++--
>>>   lib/semihosting.c            |  6 ++++--
>>>   4 files changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
>>> index cff6f5351e265136b3effe483fd5d641fdd109f8..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
>>> --- a/common/spl/spl_semihosting.c
>>> +++ b/common/spl/spl_semihosting.c
>>> @@ -28,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>   {
>>>       const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>>>       int ret;
>>> -    long fd, len;
>>> +    long fd;
>>> +    size_t len;
>>>       struct spl_load_info load;
>>>         fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>> @@ -37,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>>>           return fd;
>>>       }
>>>   -    ret = smh_flen(fd);
>>> +    ret = smh_flen(fd, &len);
>>>       if (ret < 0) {
>>>           log_debug("could not get length of image: %d\n", ret);
>>>           goto out;
>>>       }
>>> -    len = ret;
>>>         spl_load_init(&load, smh_fit_read, &fd, 1);
>>>       ret = spl_load(spl_image, bootdev, &load, len, 0);
>>> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
>>> index 15f58d578b65f7dbbadce19093546f5bdb46c0c3..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
>>> --- a/fs/semihostingfs.c
>>> +++ b/fs/semihostingfs.c
>>> @@ -35,10 +35,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>>>           return ret;
>>>       }
>>>       if (!maxsize) {
>>> -        size = smh_flen(fd);
>>> +        ret = smh_flen(fd, &size);
>>>           if (ret < 0) {
>>>               smh_close(fd);
>>> -            return size;
>>> +            return ret;
>>>           }
>>>             maxsize = size;
>>> @@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>>>     int smh_fs_size(const char *filename, loff_t *result)
>>>   {
>>> -    long fd, size;
>>> +    long fd;
>>> +    size_t size;
>>> +    int ret;
>>>         fd = smh_open(filename, MODE_READ | MODE_BINARY);
>>>       if (fd < 0)
>>>           return fd;
>>>   -    size = smh_flen(fd);
>>> +    ret = smh_flen(fd, &size);
>>>       smh_close(fd);
>>>   -    if (size < 0)
>>> -        return size;
>>> +    if (ret < 0)
>>> +        return ret;
>>>         *result = size;
>>>       return 0;
>>> diff --git a/include/semihosting.h b/include/semihosting.h
>>> index 42832d86c711ff04e91b6b739c80629253f6d30a..60535199b9532ce16620aea3ca1ea741c5b73766 100644
>>> --- a/include/semihosting.h
>>> +++ b/include/semihosting.h
>>> @@ -124,10 +124,11 @@ long smh_close(long fd);
>>>   /**
>>>    * smh_flen() - Get the length of a file
>>>    * @fd: A file descriptor returned from smh_open()
>>> + * @size: Pointer which will be updated with length of file on success
>>>    *
>>> - * Return: The length of the file, in bytes, or a negative error on failure
>>> + * Return: 0 on success or negative error on failure
>>>    */
>>> -long smh_flen(long fd);
>>> +int smh_flen(long fd, size_t *size);
>>>     /**
>>>    * smh_seek() - Seek to a position in a file
>>> diff --git a/lib/semihosting.c b/lib/semihosting.c
>>> index e49b16b0aa34ab04b6c8949a3e7cab539fdbef82..547a936e17f38204e840035a50f481e57d159592 100644
>>> --- a/lib/semihosting.c
>>> +++ b/lib/semihosting.c
>>> @@ -154,7 +154,7 @@ long smh_close(long fd)
>>>       return 0;
>>>   }
>>>   -long smh_flen(long fd)
>>> +int smh_flen(long fd, size_t *size)
>>>   {
>>>       long ret;
>>>   @@ -163,7 +163,9 @@ long smh_flen(long fd)
>>>       ret = smh_trap(SYSFLEN, &fd);
>>>       if (ret == -1)
>>>           return smh_errno();
>>> -    return ret;
>>> +
>>> +    *size = (size_t)ret;
>>> +    return 0;
>>>   }
>>>     long smh_seek(long fd, long pos)
>>>
>>
>> Nack, for reasons outlined on v3.
> 
> Dear Sean,
> 
> I prefer considerate discussion to NAKs.

I have discussed my reasoning on v2/v3. I want to make it clear that I
don't believe v4 is the correct path so it doesn't get merged
accidentally.

> Please, provide convincing reason for not supporting files beyond 2 GiB if you want this patch to be altered.

Outlined in v3.

--Sean
