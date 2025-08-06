Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F68C87FCA
	for <u-boot@archiver.kernel.org>; Wed,  6 Aug 2025 05:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B6EC8426C;
	Wed,  6 Aug 2025 07:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hDxlNPE2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0535583950; Wed,  6 Aug 2025 06:33:51 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::621])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A9FC839D5
 for <u-boot@lists.denx.de>; Wed,  6 Aug 2025 06:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MycMYR0CjRlPhm2jE+AN/DQyK3C4mw/E+alt/QHUvPVdrjBDaW5SxZ0Yy2zYHSQkYAoSN7ebvQCwmIilYdkBszsVWtyqFc7V53xe5ZKRMg9dn81QeTlnEjjGWI3MN6HMigxTv7eCOmFjl+IAj1CNvLfJrRTHqk4WkC06COLSrqGguQJuIAFMt/bu2K8ajQF5/TMrruGx/3akfNbS8c7mGuM0XkGoTLe7LAqQQPhKDCaYm5o4B7v9CeVDO9dmoHvXUEOPZCUZZcdcqeOYxUG1D5DJktIZ+fZiItBsZegumUTo322rvBtML13DsvbADGS7fDLe2kG6Ci704AP6CT/0Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=S3UUxHnA4HeJIuCaRLUuBoWxShxd8+jV6NzPs1Q4zOUAGyqAfZ+5IhvTdfadI36/R0lapxEcpCDjWus4ygISvntHt5T45lm60mFONRZluFZQSmMSIsms3HHJJyrDa+MJCWQoVmH45bmFkO0VahwT/9tbdViPqHH01PDonWaj5g/iS1IbDNBnDV/vdekndi/HXpzzFlGsZjeUbCJvklBjFFV8HGcMzofNjzXHxE6MU71AGtHYeqnxKSLBv18LcYoCpOtHezjjLq4wmD+xG4hRENKOGBis86hU40fBwc0s011a6AC5UXHJlTaKH1AJ+V73K9die6/EPHo8umTGGX7fbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SojoK8zgHzq2SNMbmVcgdlKoETAD48vyEzp9iZm/AvI=;
 b=hDxlNPE2RTkNRkZ0N++/JfYKLvJD6ojVMHFfIg028sfdY4vKZD5nGLBrTyyp/VpGrWNtlpQZ4z9FukPwroDbJaD0wR+XIHDlP/cA6gS+z6VUyozTp+jadcKs+NYsl2r+PMOiknv8OrpbmIN4JpUIJrwA9q7fBNIXYogFNu6B8VKqI/TvGo2nzLppKQoiEzG/xgSmRTHxoPUAJl+Fc7osggYvaDjj1t6MfOgj0jcS9k/iCBIKCW84Z67/cKyWfxZdSEYMEJOk+D7lvT2+H+0ufX77wp9NV4mdr/XPYK2+981EzZ50k1zBALuYImPBxSlcoMpepld6zeukQu9ksPwYGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by BY5PR03MB5202.namprd03.prod.outlook.com (2603:10b6:a03:220::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.14; Wed, 6 Aug
 2025 04:33:30 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9009.013; Wed, 6 Aug 2025
 04:33:30 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Heiko Schocher <hs@denx.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Jonas Karlman <jonas@kwiboo.se>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v8 04/12] drivers: Enabled Kconfig and Makefile for i3c support
Date: Wed,  6 Aug 2025 12:32:27 +0800
Message-Id: <20250806043235.2260-6-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250806043235.2260-1-dinesh.maniyam@altera.com>
References: <20250806043235.2260-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:a03:40::32) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|BY5PR03MB5202:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d1aa2b6-a233-4e87-aa91-08ddd4a26517
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZG82RHowb1A2OGI1SXRBYmpsQkc2MGlRN2dOUXk4Z01sdXJqbklOdjhpb3NC?=
 =?utf-8?B?d0hYM2loT05RNXBGampsUHM0RUxUYlptWEZLdlp6Wnh5ZExjbStKU2NqTzBo?=
 =?utf-8?B?MXFoblFmOUpjcWdYWGpxbVY2TFN6V0VTWThHRlZRMk02NDlTS3kvOFJBU0d5?=
 =?utf-8?B?eVZJa29QWmdWVnRWbW9tSmVJQzBaamFiVUVzWC9rSmdoOXlHTGJ2L1B6ZTVj?=
 =?utf-8?B?SzJyOXBkck9sSEl5dmhTMk5GQ0dndE5GQUo2eDBkV0U3a1F2aEFVak1lNGpN?=
 =?utf-8?B?dDY3VXhrYTMyWExmUmJyTlAzOHljeHJmMGIwL1hpWkd2Z3ZzYkhBTjBFdGpa?=
 =?utf-8?B?a29RZC9yQ0c0VzFtcFo0ckNhQ1p5NzM2Ty8wT1daK28xQ3lvOWpWeXhtTWNy?=
 =?utf-8?B?K3pVNHhuemZsU3MzZVNuZWYwQitNTkdKaHVLdGFEeEY5U1NHM05DM0VqWFJz?=
 =?utf-8?B?RUFSSFA0b1psR29OQTN3KzM5VnRaN2RaR3Eva1I3YzUyYllTQmpKREpGR1dP?=
 =?utf-8?B?R29KOU5GRlNxU1ovbjRWMXA2MzJLQ1lsalBUV3ZLbmdoSlQ2VDg0NEIrRm8z?=
 =?utf-8?B?b2k4dEFZbEN2aHJFbFBnVFVrSnFsQkFXMUZFVE9mK0I1OEJKUk03VE55UHdv?=
 =?utf-8?B?UGlBSHkxMk9MMldYSDNaQW1XOEhyb05jT1dhdWpERUdDL05IR0U2R3ZqVnpI?=
 =?utf-8?B?STZzeUI2RHd5R2prd3UyNm1GYUZnMjU1dm9zM3VUdU1OMGV3MTY5a0dXNnBG?=
 =?utf-8?B?ZVRrc0ZHT0dnZ0thdHJ6SzJLTWMzY0VQQUVvVHZWOGl3U2VKbUJYVWNMN0dD?=
 =?utf-8?B?d21CQlZlVm1EVlUwaXlQTVB6VXJpSllVeWhqWDIxUFZ0UU9BRHBMS292TnNK?=
 =?utf-8?B?b0YxbElPbm9hdUpDMy80dXdCdUU5RThiUDcrTWc0a28vM29zOE5mSXp1NFcy?=
 =?utf-8?B?dno4WEJGUTFkOGlYSGxVWVRBaTh1RGtqWWlndnFkbmE1VksrRG81WlVmczhV?=
 =?utf-8?B?TWlpb0JvM29nUVRQSWYxZHVhc0h4cmwxVmt6eFJOSkl6UU9MN1Y5ck15SVda?=
 =?utf-8?B?dVBITnhWTzJsaWZ4YitCWmFvV09TcElqYjJiU3lHYkFTR2RoMnFJRXhzZnN0?=
 =?utf-8?B?QUFGRmxhL1ZUNjV5TStrc2prcmNjdXp5TDBObjFrcXhyNzh1eWttL2dOdzRu?=
 =?utf-8?B?bFBjMEJuUFczSGNzWTB3MnB6L1kvQ3hDRTJJa0RJcU1Tdmx5Nk5qbnl4Qndm?=
 =?utf-8?B?N1RuUTBpMnF2d0dlYmlWVXk0UVdHMnZMMkVoUk13OU9JTWQ4MFdrTXVpSi9K?=
 =?utf-8?B?SW5rbTZWWmlndGV0OFNtNSt6bzYyblpqY3hKY3pLTXBTa08rNHFHK0d1MkVo?=
 =?utf-8?B?bGlDbDBKb2tVMHdjQWZGckpaVzg3bXQvSk9sQXB3cm04QU1mUENhTTN3aW96?=
 =?utf-8?B?cjBsSlJjRUJHaG9HeVo2b2hsZUl1RjdUblU3cWVhUG4rU3ExV1Y2TnZJWmF1?=
 =?utf-8?B?RkVINmpnMlowZDNmUm1salF2R1FWUWJPZGhjZUd5VE03cVhSWlFGZGpmL3hm?=
 =?utf-8?B?REp1cmxRTWdrR3NhbzhvdzJqWkxjK3VnaXdYbjF1RWJod2FIaklyN3NKSk9J?=
 =?utf-8?B?anh3WnIrUnQ1U21VUk5hek1wMGEyc21hTW05bjhqMzkxdnp1T1pUcnpSWUti?=
 =?utf-8?B?ZWJOQjc1Y0RzalFxaG9PdlFPUkYrQzJsWVB3TWl3cW5pd2E2UTRvQktNdEIw?=
 =?utf-8?B?QS9UUGhBUnpXMXJDeVNmNHdvTEV2VHNmbm9DN3NMdHVrSEJwQytWcW9vMm5Z?=
 =?utf-8?Q?PtpY9R5dqCToaZtMinzB/D9WglzNhuwo6mK60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWNheWt2SkJwNm9vYmJWRXFRMXpRbTBkRkNhM2t4TTVwN2twQXlHOStwMTI0?=
 =?utf-8?B?Z1JxbXFjWjlIV1BuQjNHem90ZUpWdnNCTXBFRTFkN2hKNkdxaTlua3BadG52?=
 =?utf-8?B?d2hTdEk3a0Q3b3l6TTVsREtkZG5Id2xIRHg2b1FNYzVsUk5kOFlYOU9ncFhs?=
 =?utf-8?B?Q0JyTkRtaDdUc2xsUmlYdmQvV3ZmaEhWNG5ST1VUTUNRSlpvanVxakVyM3Fu?=
 =?utf-8?B?Q0dkNFJ0RVdTck9BSk16TVBLcjROQ2h5QTJnUFZLc1RDZ2ZoSWltTG5yS3hN?=
 =?utf-8?B?NTJCeWhuU29oWTBXUGRlSkdLWDBMcXRkUjV1UDRTYkN4ajNUdTFkeVFudHFk?=
 =?utf-8?B?dlJFcDllUWI1Q08remhoVExoSlo5d2VmMUs0YjVsWUpsc1dtSm5KOVRtL0Nl?=
 =?utf-8?B?ZDZKbTNGK0lxdk9yVHpadnZIUmZYeGVYVURQM2krT1ZlOHVMczE3VUZIR2pB?=
 =?utf-8?B?UmlKV2pSdHpwaFUwaDVQak8zODExNUZSampMN0UrdjQwM0VYZFhZOEcxWXMy?=
 =?utf-8?B?WkdIc1kwS3hhN2NaY0hQVENlWXBXQ1VjM1ZiZ093eEFMNHlGbnJFUmZkbmVT?=
 =?utf-8?B?OFRVK1ZKUXJ5SER0Y05BNFpCTURQK3R0UmJFU3lVZnNxaDVTSW1ZTVk1TTdu?=
 =?utf-8?B?RXEyUjFFcFN6OVVZRXRDbEw1Z2FqMEFKdUpWdHFwT3dCUkR5WjhkUDEwQlQx?=
 =?utf-8?B?RXpiWGM0ekNUUTNSWFJxelEzbjdCSFVDZCsyMitBYkliYklwVnpmTkRjcVlC?=
 =?utf-8?B?blFtNGlRWWsrbFpRMkduc21oQUxUUXZueXdYZlJPUmRlMFpKRjB5ZzJOQ0xW?=
 =?utf-8?B?SUl1VkVEcE9Rb1lERUdIVmcza3VkQ2F1UEx0YlNySU5BMnhOYWJRVjFWUGw2?=
 =?utf-8?B?VGJGUGpFZnIwMmdCRHN0T2dqVXdxNlVjVW56eHlJMkc0bmdOait4eVpUOGh3?=
 =?utf-8?B?WndFN3kvcVJzNDFYVHppSmFTZWoyekJPVlpGdE15TzRya3M0NVFSd0twU0kw?=
 =?utf-8?B?T1Q4a1NGa0RtMkc0aDI2QlE5ZGZsZGM0WTNINmtjYytDQXhmdG01WHFPbkZo?=
 =?utf-8?B?NjNaVlRlMEdob3JKUUZhYm1SQUlFcFBhbS8yd2ptRGhSRXhEMFBJZWNOWjNS?=
 =?utf-8?B?S0JxUElaTmR1aGdDMmY0Z2g3TkFoL1NTcUJWbEQzRWwyc0Fnckt5bmo3RktT?=
 =?utf-8?B?OWVHdXUyeTN6ZFlrcUplNm54MDNOanVPVHZYM011TXJoSTcvSm8vWHlrOW9E?=
 =?utf-8?B?OFd1UlZ6dVBVQXp3Nk9EaGxaZHVqVFFsSStjYVNuaEkvTEIySTB2OVJmbUxO?=
 =?utf-8?B?ZVp1eWJ2dVRXMnVNcDBKNnhHVWVpTUZpRTlBby8yWllHZitzZ0IzdzNaNzU4?=
 =?utf-8?B?Qkk5S1doK2hwOW1SZ0lkUHN0R0pnUjViaEdoZWZvU2hUcmNuYklray9ZWTdR?=
 =?utf-8?B?WTNSbzZpQjB5b2svMU9ETk9VY2RwNExIeVhhNXVBNk12ZVFiaUREMkRmdzh4?=
 =?utf-8?B?WktKektTTUo5Z1h4cHpoZWFOYTBSeElrcTVvaUFZaFhkQnV3aVRnZE84aHEw?=
 =?utf-8?B?dUtmRmhIMUlkR0I2c21mRGZTRVpJZWFFcld6VHBBZEhYNW9FK2o1amxJc2l1?=
 =?utf-8?B?YUk3YWJQTFEwSnFtRXdqQ01rSkxPSXBaK1hrSUpPaFhwRDNUUnVuOEovNzZL?=
 =?utf-8?B?bUpqODJ4M0tOd24vYUtJanlQSERSMGdvQTE5TFdUMW1JWVpnakNpREN1YUdl?=
 =?utf-8?B?aTN6MGNqRy9QektqTk1hTElpQXpEajNYbVFLRnYyeCtURjJuL0ZKdXRIMXpl?=
 =?utf-8?B?MkFUck1Td1d5cXdjRTRRMGwrZ3BFNHJmQ2JVTVpyZ29tYTVucDMvU2RBVlZi?=
 =?utf-8?B?K0hBVG12TVNkWFRDVUwyUlhGVFZvS0U2K0o2TWlDblBZVU9mTjlaRE1XZjkv?=
 =?utf-8?B?SmZ4dTB2SmVQMkJVcW8yRHZUTGdVZzEvc0J4b1UzK1JNTEpRMi9Kd01kdy9q?=
 =?utf-8?B?YXlhS1dsL0duQVF2Y1NWaVBBQnpnRkFXOHc4NWtvQ3N1K2NWc3dTMFNwZ2JG?=
 =?utf-8?B?VTF6RVZlRWNpRW9WejFkS2ZpTFRNVkx3cStXZ0FGY2VnRnlmYTBGTmNaZ2xI?=
 =?utf-8?B?c1dOR0tmdFlIOUhDQjNkSmFJNmJCTXN0VzZ6czdiWmFTM1FibW9tV2ZlRDl6?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1aa2b6-a233-4e87-aa91-08ddd4a26517
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2025 04:33:30.5320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IYiNkXVkzanJjVkd8gzHFyggggupgr2c0/vtuEnoaB37Mq849L0URu8A4ZAI1DbDD4DvG4bxYQwAHLvwcOlJn8jI7wZvt0oUCZqFQhN6sbc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5202
X-Mailman-Approved-At: Wed, 06 Aug 2025 07:25:39 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@altera.com>

Add new i3c driver to U-Boot drivers.

Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
---
 MAINTAINERS          |  7 +++++++
 drivers/Kconfig      |  2 ++
 drivers/Makefile     |  1 +
 drivers/i3c/Kconfig  | 16 ++++++++++++++++
 drivers/i3c/Makefile |  3 +++
 5 files changed, 29 insertions(+)
 create mode 100644 drivers/i3c/Kconfig
 create mode 100644 drivers/i3c/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index 0315c606744..6dcc566eb72 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1230,6 +1230,13 @@ S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-i2c.git
 F:	drivers/i2c/
 
+I3C
+M:	Dinesh <dinesh.maniyam@altera.com>
+S:	Maintained
+T:	git https://source.denx.de/u-boot/u-boot.git
+F:	cmd/i3c.c
+F:	drivers/i3c/
+
 KWBIMAGE / KWBOOT TOOLS
 M:	Pali Rohár <pali@kernel.org>
 M:	Marek Behún <kabel@kernel.org>
diff --git a/drivers/Kconfig b/drivers/Kconfig
index a073230c26d..0b0c610e629 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -56,6 +56,8 @@ source "drivers/hwspinlock/Kconfig"
 
 source "drivers/i2c/Kconfig"
 
+source "drivers/i3c/Kconfig"
+
 source "drivers/input/Kconfig"
 
 source "drivers/iommu/Kconfig"
diff --git a/drivers/Makefile b/drivers/Makefile
index 0e1f58c515b..fd155835ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_$(PHASE_)DRIVERS_MISC) += misc/
 obj-$(CONFIG_$(PHASE_)SYSRESET) += sysreset/
 obj-$(CONFIG_$(PHASE_)FIRMWARE) +=firmware/
 obj-$(CONFIG_$(PHASE_)I2C) += i2c/
+obj-$(CONFIG_$(PHASE_)I3C) += i3c/
 obj-$(CONFIG_$(PHASE_)INPUT) += input/
 obj-$(CONFIG_$(PHASE_)LED) += led/
 obj-$(CONFIG_$(PHASE_)MMC) += mmc/
diff --git a/drivers/i3c/Kconfig b/drivers/i3c/Kconfig
new file mode 100644
index 00000000000..fa68612787b
--- /dev/null
+++ b/drivers/i3c/Kconfig
@@ -0,0 +1,16 @@
+menuconfig I3C
+	tristate "I3C support"
+	select I2C
+	help
+	  I3C is a serial protocol standardized by the MIPI alliance.
+
+	  It's supposed to be backward compatible with I2C while providing
+	  support for high speed transfers and native interrupt support
+	  without the need for extra pins.
+
+	  The I3C protocol also standardizes the slave device types and is
+	  mainly designed to communicate with sensors.
+
+	  If you want I3C support, you should say Y here and also to the
+	  specific driver for your bus adapter(s) below.
+
diff --git a/drivers/i3c/Makefile b/drivers/i3c/Makefile
new file mode 100644
index 00000000000..5bb44a8d64f
--- /dev/null
+++ b/drivers/i3c/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y				:= i3c-uclass.o device.o master.o
-- 
2.35.3

