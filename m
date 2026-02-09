Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F74EF06EE
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:29:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE31A83C39;
	Mon,  9 Feb 2026 02:29:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ixBxLEAa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0179283C39; Mon,  9 Feb 2026 02:29:00 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1428805D7
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qygIg1lSgsFlPgKmK4ezzsl+MX55DeyECCWdFqzM3p91+d/ixSVUvorc9blGTB0lW7BJ2tlgqGx/ofOBigz3noKBb5pklcdSHbvbfmjR7A/ofrVdNSjd1i7INhJT8+4mu16RvhM3Pt0lGN20xPFuMn+B9xYZAZNQ9+2cTgF+5v1WF5TJTiLcqaSTIaTCVOUakeFqvvE7PSdP9mrwOiOz6UtvgPhu6kDY56MvMrdPtUnUeMfTRM3oYykSfvVlwMtGuO4bOET0UcXyPiguwvhd5u3Cblrxq9euJ8aNS5hfkXgg3O18Np/lrj+WV1sRaG+JpoESqzSPTsM0rUs/KxkA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=KhcEbEYB4chaiadjz3DybOQ36qW43G/qy+Pe+3MPjvuLrssj7kVeM3Gs/6JAKSOphMkN9Ph1q2/RD0puqbxQixs1S/hLzLgdHNtAZmljFNjR+ZbsMAK0N4xP3yZIXFquLVXn6mDYd0IHpjHpfEeaRv+AlnvJoJ8xjFzlxCiVZsCW7v3INZWKtkXAo26me996rgjrq+7heJvsHhsA/HKeZRrjKMJJSEr9sZGbH282oRsJBHihEUQjRW3vTqoz4p3WE0YT7sbrOzpQce+ij4aJJac311hq6cojEisqDCPOtIZEtuIARq2DEh9IQlNm2SalR+nbybP62DjZqRemtR2LsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNZEjv4XeyFjVnflGVu4jur+/eBQa6VRS5f+9Ri8EII=;
 b=ixBxLEAalaF9ShNEY6ap3VJKBxW9KtrK9exUVRYbpLyi3pfubaKbw4gHsgvJTCdzjNPdUTmdEqpV0hz898EXkqc1K4+mpqz6oboKHmCPMN7GBGilq+wAVKZYhQMb/KcgUImcGxTZXfYxsdGlVftfYrotSvTD5AjQ2/I3MB9wWEvl6VSaASJWaq6B6aZiO7WpJCRXpv979MIZMTTXjEMGy4lSHSU3z/aEtD/fMxVyv8OpKOwkgz6rxr91BAYloY2z6UoasFlc/RhZmpRs1VCGrlygqN4jOjfD9Pdd0ny1cuJi73UPeOBclW5w69IRfhI4Dz87E64QkcVUrDcF5DRCWg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:28:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:28:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:06 +0800
Subject: [PATCH v2 02/14] mediatek: mt7622: Drop useless board files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-2-73a3a84ddbdb@nxp.com>
References: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
In-Reply-To: <20260209-cleanup-v2-0-73a3a84ddbdb@nxp.com>
To: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR06CA0207.apcprd06.prod.outlook.com
 (2603:1096:4:68::15) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAWPR04MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: b7abd2c3-6b17-4428-6178-08de677a96fa
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzlOMFhCNWd6bGF5UWxrUkI0T1JuZytGLzhXV3grcmNUUllyQXYzZmxvY1pN?=
 =?utf-8?B?ZkwzRWxDRyt4Z25PRk92UDMwN1JDL09vQnhRZHc0ajRXTEViL0d4UExNOUhW?=
 =?utf-8?B?UnN1ZHV1SEkxaGpydzlHeitNY2J6MGNMWXZ2SXBvaEJVeHJzMGQ0cktpRnp4?=
 =?utf-8?B?bVdxWXRzSnlnazFiN3RlR2V5bk9VRm1wclpvWFVpd2Rac054NkVBYTljYjh5?=
 =?utf-8?B?UnA1VVpyUzB4NUdlK0dzOVl5eUc0OGROK2srSWVMY1E5Syt6SHNrb2FqMU5F?=
 =?utf-8?B?ZFRWWWRTUWxueGRDZWM0THhaVGpGaG9PcUJGcWJuQTlRaXNFeTJtazFyY0Vh?=
 =?utf-8?B?ODJnZnJLMDZDNHRGeUt4eWk2ODg3ZmJCZHBTUU8xYmc0TmVxdnVKTkY3UmRL?=
 =?utf-8?B?RThGLzBwamRybWlwdGxBUGpFdUdlbXdBczkrc0ZUOFpRczd2Wm10bW04ZFZt?=
 =?utf-8?B?TEx1dExMRytXV05TbE43dnR5cndmN2dYWDlEWERPREJiSzZFZFZneG91KzhV?=
 =?utf-8?B?VGZoWEFab0YrbXBnWHpqSFBRaDRhRzRieUh5ZzBBQzYxUTJWNi9ER2cxNW0v?=
 =?utf-8?B?elZIUVpsWmJiRkJ3RTU0ZUxwckFKeldWc0RxSExob0tRN3B0TTJMT0xnUkhn?=
 =?utf-8?B?OWlabXdTVjM4Z1RmUGRHMi9QREdpWm1wZHVGQ25sQThHcTdDWUY3Q2ZEQUNr?=
 =?utf-8?B?STFhYUFsRk0zWnFmTG4zTWRCTDE5a0tUcHpueWxFU3RIV0Jsa3V6T1pJakEr?=
 =?utf-8?B?ZDgvMElYNHY5OCtyYm9nTDIwc1FQY2RXVkwxb2xaYlNuRFpLNjVKVWxtWE4x?=
 =?utf-8?B?ZW4xVzNZNUIzV1FGUU15Mkc4bHRYaXI2TDZIMUV0dmZIT251dW93QjVyK0Vs?=
 =?utf-8?B?T1U5emFSRHRkcU0ySzRuYURiMWJweXF0R2xhTWJSZFBzMDhCUFBOUTUwRkpF?=
 =?utf-8?B?OTAxUm1mOXdjUDBlSGlIUFVZWVR5WDgrUXhRQkprR29hSk1VVTBJSG4rMkFH?=
 =?utf-8?B?dzBSMkx0aW1lR3VYeVZERzVVVEtWZmJ1WGdKWGVHY2NZNGlJL2NseDlSb01R?=
 =?utf-8?B?eWNxQW9CR3o1TFY4R2ZtNWhRS0F4TWhnNUNDY3pkWXVLekVOWnQyTWtNY3dI?=
 =?utf-8?B?Q2RzaVVKTWhpUmFaWUFQdE9iRzFRTERDWlNPUmZra2xxaEZNQ3BMeHhNRlpL?=
 =?utf-8?B?YVhxVWN3YUpFTkxFb1pNTEQyNk91YUtnQ2Y5dnBRL0NkaDd2MGhZUDNoSHVa?=
 =?utf-8?B?MDBUcVR1QW5lVzNvd2pHR3dBMFlkYWI2YXRpRk5neHRRS1NJS3JmK2xYdjZ1?=
 =?utf-8?B?cHRYRFNTWkhkanNaRGJTcXNlcU9pNGt6aFlRc1I2NW85blg1NWxsQTBkam56?=
 =?utf-8?B?QkFkQ3ZYaUMvTlgwZ2tybCttcW4zQXo5VkIrMGNVUVN3MC9pclR4eDBSQzNs?=
 =?utf-8?B?WllydUV2Uk44MXg2d1RSY01SZDJaZlFOaWdWckptUEQ4UWIyb2ZpL2NzN05P?=
 =?utf-8?B?Z2ZiVDlNd24rTFdqYkVFbm93ejJucnNqWGcvbnl5SEZSeTZnS0lVRGlyalpk?=
 =?utf-8?B?R2Z6QWJXTjF4WENaKytkaElvVDNGL1hBbGJPSWdpRWhnMHVJUHNNdWJzdFFR?=
 =?utf-8?B?YitaN0FKNmV0Qmt2ZjhXU25pZk5XSWlaeFJZandmTVA5K2tUMWQ4Y3NqUGxB?=
 =?utf-8?B?RlBhamJ4dE05bGRJNHpMOFdaL2RKOC9oeG5aVEUwUE93NXNoZmhhNHBoQ3o3?=
 =?utf-8?B?Qlh4MEp0T0tyMU54b3dmYldWUE9oTXRQaFVYK2cwZ21iQ0lid3loYVNrVllD?=
 =?utf-8?B?VFZrT0FwRjhRaFlFN2Y3YWdNczNkd0tMVHhaSjc5SHhJYnlKVVFWaHB3NXR2?=
 =?utf-8?B?ZEhIc1J5cGp5WG9pc3Vod3ozMDNlRG11amM4WUZscHBRUXBHMmZ2SmtQMmkr?=
 =?utf-8?B?RHgxcU9GMS9SUkdvWGtGdzg2NlFRaHd3Q0F5WkZBTDA4V0JsQXA0Yjkwb0FT?=
 =?utf-8?B?RmVYK0FFSmlSOENsTWJ1a3JwdGhKY0I4T1RHRGhQOHp4K0s4RmZBWm5UNGRW?=
 =?utf-8?B?SFhXVGlmbFhMejVpRmY2ZnpuTFpKem50VU53bjJkQXhFalN0NVhHMXNjOGhm?=
 =?utf-8?B?Zm5wMmMvNWxCelk4SmlYMUtmMHB1OUxwZFdVdFlCV0w3Qk9xeWlFbjRBaC9z?=
 =?utf-8?Q?4mSAlIp2wCfYWid2tDeMfqM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0lRTWVobUJPT2x3TFc2TTMzN21hM3UyTE9Wa2pibHBIQUxPaGh0bXZSSGM2?=
 =?utf-8?B?OXNOSE1GclNZa09PbHBBTHhscHdGTDJZQ1FBUmdGLy9pYjhQQW9FUjBMOHZi?=
 =?utf-8?B?OElkZE9samFyOXp6bnZOcXlSWnVxMHlCRnVNdmtESzRHb0NaZGRPbnFtS2Ns?=
 =?utf-8?B?M2lBcXRmL1gxeFJnYnVnazBHdDFOM1lwZHExajJ0SG94M216aU1JSXgvblJL?=
 =?utf-8?B?US9UKzd1L3FmNEF1VXpHTnFPaFBzeml5cFVzMWdwQW1ReHNYR2k1VUtmQlZo?=
 =?utf-8?B?TzZuT0F2RXB6czI2YWpUcjdvTjVxR3VIWG14TnlCMDd5N3c3UldVeS9Za0lW?=
 =?utf-8?B?bHhNRnczMmRTSXRmS2Y3R2xQLzRWSi9JK3JFVmcwT0puT1Vmb1F6dW8vK0RC?=
 =?utf-8?B?VHgyNjAvcXdENGdZOXRsQi8zeWp1MlovM3oyWGpaVjV5QXpZOFlsOXRjVkp3?=
 =?utf-8?B?cnQyd1lsMnVYeTh4eTBvWUV1bUFDUjd5Uk5XK2JRWFRrNFk1bWlQdmdUdnFO?=
 =?utf-8?B?UStHNkZKWXN6eVdFaWVVMTRBQWNtWUM0bFA4M1RCQzBKenZpdU9NUmtwb0dp?=
 =?utf-8?B?KzkwR3phWGhkLzRtQjZQUVFsU3grcUZFb0RxU283ZDl0WDFMUE1GUzk1NjZG?=
 =?utf-8?B?RjhVcjhIUXNZN291NWhHSEhieHZCeXl1cnBvbHR6Nit6cUI0OU1BWUhnN2hE?=
 =?utf-8?B?L09UYnhlZFF0V0RHOGZpdUE1YXBUd1BzazdQTWM3aXh4dnZBWmc5RWk3Y3VM?=
 =?utf-8?B?Sm9mVk5GTGw3TklBQ2d3Z2FnZDdsdDlCR2lKMFl5ZGhPWDJOTldIb2JrUXp6?=
 =?utf-8?B?am5WYU9uN3grR25xejJiTXdjZEE0TXN3NlFqMXlrWVZqK25lMGNMbVNOYXly?=
 =?utf-8?B?ckpndDd6KzNaQjlmbktXcGl0aGUxQXVPTkJSYjQ2R0gxZXkvSk9lUzNuNll6?=
 =?utf-8?B?UFBsUjErRlo4Mi9zOWtQL0tMcm00UDU2cm1SOUI5R01uVEVJcUVkVDVoMUxT?=
 =?utf-8?B?aE8yME54czJheHRoWjhSOUFLb2daQ2xTVmw1NzV6emN2UXZIb3dQNkhUcnJi?=
 =?utf-8?B?OUZVSmpFNmRtRVRSTlE0ZVcwUGxJNTFrZW9lNS9nb2hYZlhUc0hPWmFVN1JH?=
 =?utf-8?B?MU9vWHo0U2VVMlNUOVlQS1FlUStrVWtMUkpxVTJaUisvRTRGTU1sR0F6dC8x?=
 =?utf-8?B?VDZ0VVBQbmlEYUhTWnJOck1adGZoaHF1SG1WblB0cjhSTDh0MVNEM2dEWXh5?=
 =?utf-8?B?UXV1RkVEQkRib2tEaGJHTWtSRGNtb2swcXFJTzZRNUgwSC9HSjZMK1JoaTVO?=
 =?utf-8?B?VWROenV1cTBncnZ5QUQ0UlU4TFdHU3JXT28wKzNXdjRZWDkxMG1vTHZMU041?=
 =?utf-8?B?RlRlTXdBL3dnQ05xQU43M3F4Y3FUSEZQYnFta0xieWNUVDBYRG1rTnNpcDNz?=
 =?utf-8?B?SzhuTDdmWDc1MXBUclp6bjJOWVgzZlVSMUswM3EyODZKVCt3QmxyOERFb3hv?=
 =?utf-8?B?clFjcWNuMDBwOWMzL1BaanRROFp0NGZQSzN0cHU5WktIaWZIM2RoYjl3Y01q?=
 =?utf-8?B?Z3pvV0w0YjVleU03SHpSK1prc0FDTmwxMXdkNzVKYmpWNy9ha1hjcUV0UUVE?=
 =?utf-8?B?YndES0x3WEFJOWZnWFJCMEg1cXJtTGdIUHRKT1g0UVA5QnVwUmJzM0RVSU5S?=
 =?utf-8?B?UkNnMDh4UG01KzZTV3FKZ01yMUtlTmVPUWVKbGpXV20xdTBaY0MzQldUMXZP?=
 =?utf-8?B?UFhwRFo4MEtsZVdKdUEzT3RLb1FyWTdEMjdVaE5hZnNoOVd6bFhxUTRuQW8y?=
 =?utf-8?B?NjF5WDJnK0hrWVJEL01JNlE2RWdhZHVqbjJDZFRnRUhzRFF3U0VCTDhabGRj?=
 =?utf-8?B?NWtKdVNDWVZkaEVNZmhSTjlnODd5d0hYY24xaUdCc05mOHdWcFNUOGZtWUpZ?=
 =?utf-8?B?bWpyY2cvRUNzTmpYVm1mcjArUzZ2M1pGREQxY3N0YzUrZ2Zta0lwc3J3T1li?=
 =?utf-8?B?OE5Cak1jT3BzSktJSUJNMzYzNzRCdUpxM2wzRDZES1B4Z2RmWU5nM3ZJbG1D?=
 =?utf-8?B?ZkNYM2tJc3RxdHZ3UFpLRmVrOVR2WkVhL0FrVkxBcDZQSmxqQ2Z6bHVibm9C?=
 =?utf-8?B?MmVoQTBzbWpzWktTS1F2aEVXZkV4dkU3VkhadTlKSzJhaHJaZWY1VjNiaVIx?=
 =?utf-8?B?Q3pLSzhDSGtDanNUSStjNVZsT1ZyeFI2cDd5bkhGbjJWR2h1dDZLWUQ2QjU4?=
 =?utf-8?B?MmxpeFI5RnFWbk9rWW9rWWFVRCtyNjFVVlZNT1pMRWUrelZ0c1hjQys5UW5V?=
 =?utf-8?B?K05QcWFvUTQrNjVSbnMwNEtIMjR0L0RXdzJCT2NRWlNZSDhCd3ZzZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7abd2c3-6b17-4428-6178-08de677a96fa
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:28:55.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbZXhuWu3dvw6LueRAWMOZyPWjbbXZ3NsQwwGhGbm6n/mir+spYLjICh5DVBnE7upomk6EFR6GDrAxu6bm2K/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9840
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

No functions except reserving gd in the board files. The files are
useless, remove them.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/mediatek/mt7622/Makefile     |  2 +-
 board/mediatek/mt7622/mt7622_rfb.c | 12 ------------
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/board/mediatek/mt7622/Makefile b/board/mediatek/mt7622/Makefile
index 64f101337bf16620665cc5d7a308849ba127e107..35f3136e833b4d7f8a92233708e3e15765272b0f 100644
--- a/board/mediatek/mt7622/Makefile
+++ b/board/mediatek/mt7622/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier:	GPL-2.0
 
-obj-y	+= mt7622_rfb.o
+obj-y	+=
diff --git a/board/mediatek/mt7622/mt7622_rfb.c b/board/mediatek/mt7622/mt7622_rfb.c
deleted file mode 100644
index 405f393aade112356ef8422a6e9d4f271ed2e672..0000000000000000000000000000000000000000
--- a/board/mediatek/mt7622/mt7622_rfb.c
+++ /dev/null
@@ -1,12 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2018 MediaTek Inc.
- * Author: Sam Shih <sam.shih@mediatek.com>
- */
-
-#include <config.h>
-#include <env.h>
-#include <init.h>
-#include <asm/global_data.h>
-
-DECLARE_GLOBAL_DATA_PTR;

-- 
2.37.1

