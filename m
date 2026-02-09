Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2E0EF06FB
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 01:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2360483D3D;
	Mon,  9 Feb 2026 02:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qS+YPFxv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF086805D7; Mon,  9 Feb 2026 02:29:14 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B0E383C91
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 02:29:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISruZslc89ofAZGL/aRHqPdNwYyoPQNLht5kfCoo8k1S9wKczfHo4uYjGVhbDO/4SEfxJPOR+p8P4/eaYmelSQcgLi2U+KEMPpvd4u6d11XTo4OStbndCEavocnfLlXkLrZRI2mQLjb8QuYWjfI03869tl6DCedjBHp4WMC3fMJjVU7bLZStoz1rxsHrM80dUBxxEUYOj31hyOjjHZpElNjq07ZQXUO5qUCV5+6Q4z7sj4i1MQZAIQWukIUhBQ/9FTyc/jxsckJZBNc6VYAmbIHtt54pqHRqUcgfyYrEoW5x49PxZt3pTvAe9KJv0GTto3anM1dSLxDdZZgKO/UVJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=rMkrNy45N/Wm7mjeuM6jP7S+opeMkbwXmYQKHysW3DaHsQ6CFJQmhOenSkwQ7PjmJKeeOZrWH+W9wdsEvyT91OcEQgWpVPQTk/G28XJjnaHawY4ni/4EQueCcInpQcnL/5mVDRuXsRWcX381KYwStzpMizRcM2g1/jPw/S1XbHqgVmwJ/BloctebpXL6mIbRf1oapyjidPqCEQO2J0OW0PdBXwoAs/vhceoWfy+0sK71zMQWo7dWvJ0rr6VYI5E+g/JtcgntvHH+oYjStbjwbyJ8XcQ6h4M5t2BbJ8h3LrVtWkiagGBwJV1r5kCpANNM+aWkUk4q5pJEHw6eLa57Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSABK4mrFlRETHt7Ep9E6IaJWCfL36Ko+hKrDtSdzMg=;
 b=qS+YPFxvmA4lnfvB4bBPnfxevneoiqsSmFBbV1MVJ3M/K9NSlR4Q3AS9/Cx92Z7cDkxILcrGAs+D7pHiUb29M8PlrMDxIGppcLBu/Avo/Egvit9LHRjp3zyHot/YPPQs9e/uJMbnrkXlr1TscPgefqNiYHbPWCY23F3i03nJ/sThG70kxTfwK3hAm3QqWrdcid/iwKVYsudE5bX5iRTrtdg55MeHxr2KO9geA4xBnu5jWG3EzBEsREDa6jRVcBjkovhzL8KN7PrOq+OyylUiniqxVcgl+T4Q4REJ462aPcj+GL9rXD7e69/ZDNeJKsm7s9UnTQCtMeLAHEVw0A5GUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAWPR04MB9840.eurprd04.prod.outlook.com (2603:10a6:102:387::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Mon, 9 Feb
 2026 01:29:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Mon, 9 Feb 2026
 01:29:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 09 Feb 2026 09:30:14 +0800
Subject: [PATCH v2 10/14] nxp: emc2305: Cleanup headers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-cleanup-v2-10-73a3a84ddbdb@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 69bae4e6-6386-4632-03cc-08de677aa06e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVRaRVhSOUtqYm1hQ0pHSGtSYXhDTGlXSk5ZN05FZXVncVgrQ2JIRHdReER1?=
 =?utf-8?B?Yk1PZkdTeEJYZmUyeDBpNWc0ZVRFSVBvQ2xDSzNacHg4SUNLRHJkcVJseTFz?=
 =?utf-8?B?akRSQURSNHpZV1hVaENFVDhRbWlqTUNNTU5tOUcraE1WRlRxR3Q0RGRiTXM4?=
 =?utf-8?B?dXJFdEJvWVBZaTJoV2JkaVpaRG9SK2YyRTNLMjhtRWUwSEhEd0VVZXowOFZP?=
 =?utf-8?B?dXRqWFZIaFg5N1VPSElZeGFSd3p0aEFRT0o3R3BZY2pJdFFIYjZ5cHk1ZlJQ?=
 =?utf-8?B?TVhldDk2Tm52dWFaN1VpMm16Y0JJenlYcmx5RzJrbk1jTkpGOFN1ZE5Gb0xk?=
 =?utf-8?B?SkZhaGxSNWEvUWxZTTh0bS9HNkJmN3Y0Z0srOGp6WmowNmdvQWJxU0cvNVEx?=
 =?utf-8?B?cVlNS2ptK3VsZzM1SHBrZEY1M29BeXptTDl3SUkxY1cxQnByUFZDZUEwamk3?=
 =?utf-8?B?NVE1TDRPS2g1YWptVWlmdUx3SWtDRHFsR1ZEKzVab1M1WStjTjFMQWZNNU92?=
 =?utf-8?B?a0FVTStiaHhwNnpOR1ZEUGRZQlZQZERkUmIrWmdDNTNGRDZ0VUQ1WGFsNG0y?=
 =?utf-8?B?UVF3VkdwbjNnWStFMHIyRk1IZmpLcDlkT3BxcllpUGMwWnNBWVl6R0VvQ3Qz?=
 =?utf-8?B?c3BTZEhxbnpyUVpIUHZLS0ZrZlZTM1hvU2FPS2JYc0Q4Tytybnc5ZVJJRXBE?=
 =?utf-8?B?YW1OdDFpQng0RHVJQlQvRFpudzRVMkxXT2JsMzE5QXV0T01YVDUxUWw5a2FG?=
 =?utf-8?B?K3NCOE00THFjMms3OWJUQWZzaGhBclRKQjIrSzQ4cExVeVNFemRNQzBPMUEx?=
 =?utf-8?B?WUpkalJYRkNBNlQ0Y1hKSHZmY0Q5Smx2Yk1mbkZqNFJwS3Q0N2VYbUU0WDdr?=
 =?utf-8?B?Y0k5alBTVGNtM0w1MGFZN3laMWdpY3NLQ1FVUjZmVmlESGJzSW1NTUJNbnBC?=
 =?utf-8?B?Qm01bHNUWmFtcXlMbnFQb2ZQdTU3YUhsN0JQTnkwT1RxamZleW9sQkRPWmM5?=
 =?utf-8?B?OG9KRkRiMWZFN0JESzlyb2lMMUJnWHNDeHp3M2RSbmVmcFR0OHZkckJGVFA2?=
 =?utf-8?B?SVpqajVWOU9PbVlyR0FmYUFLTlhpRy84RC9ZS2hwSnpIdTVVOG00NzVpeFdT?=
 =?utf-8?B?MjAwSTI5TjA0YkJ3T1h5K0srZ21DS3k2NjZHSVpNdkxGcVo3dG4rV2NLYnE3?=
 =?utf-8?B?NmdXVWY4eDZRK3U0cVZRdk9wbTdES2NEaDJtZzMvd2EwOEh5VDRYVkhFNkxN?=
 =?utf-8?B?V3N0eFo2R1F6bEk3YjhsWmoza29KYnBIY0wvdEpxMHBNbC84QXg3RGMxRCtV?=
 =?utf-8?B?ZTZLUS9QaFR3emlLWEhaMk44OFpPQXZPa3hwKzFReUZoY1E1T2ZRMmc5dHZJ?=
 =?utf-8?B?V1g4TWtPeTYyQTYvSm9jTHphSVV5TUM5WUFEV0k4YmhjUnVqQnpLZERjNzRK?=
 =?utf-8?B?bkVINklGanpBMk5Hb09OZFowcGlGUU9DTzR6eGpkeUpVT1dSSVdGY2RCM3Js?=
 =?utf-8?B?dGFkM1VEZ1FtNmFxam40VU0xSXFvNFRzUWpqa0I3U1g4SWw5cGQ5UG5DVlU5?=
 =?utf-8?B?SXV1alhlVDJLOGNTT0hRb2NaZi9tNnlWNTQrOGJaaTJlMnV3ZkJIcVdIYmxu?=
 =?utf-8?B?eGhRekpmdmV6QU1DTElMdDJJZk1vaW5ManVOOHQ5NlkwOVNWeXhKWUNONStB?=
 =?utf-8?B?UjFPQitEdzJEYkx4ZGNtKzUyejQyTmJ0V1BzWjNFZHVKMUxuRmtPNzJRVHhv?=
 =?utf-8?B?Q3FOdnUzRStFTXMwdmZuWGF1Rm94SWsvNWJXVnZsWkx6d011Q0Q4RUd6VFVh?=
 =?utf-8?B?SUxPWHBTbEdxeExJK2dzOEZ5ZHBYZ0FrUzJqQjFQY1pFSUFudzh6T2xjcjN2?=
 =?utf-8?B?LzBOd0dmQ09BaEFXaEZWbXlibG1CVlZwMmZxWFBtYUJ1RHdtS2dSMyt1ZVRM?=
 =?utf-8?B?ZkJsM0xQMXNZM3Blb0c1TlJCZHd1SjBFbjhuUU1RVEV3ZVVhb2ZyQmZHOXYw?=
 =?utf-8?B?Y3M1QkN2VWM4Q0RNR1ZFUW93MUpXMEV3TWo3Q2FCZU5hZFhZTXh1NGhnQ3Bw?=
 =?utf-8?B?bDRrMlBEQjIyNDg4eVZFaXNHbzhaTDJQamk4L1Q0b3ZBaVkwSjBzeDBEYnRN?=
 =?utf-8?B?bFhjZzhiRWg1UHMwcHpjMHlkc1l0dWJ5U2ZJT0lDa3JUSUlsWGpQaUdmcE9X?=
 =?utf-8?Q?as6xQZ3ji9SA47/t0weBc/M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(376014)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hPVC96cEZ0aXJxbnl1MmR5RDQ5cEozc3dWOFdJcGRuYkFvL2RyRXZhTHFm?=
 =?utf-8?B?TVZVWGEzVjZFMmUrRHdaeGdLaVk5UTdpbUc1eW95VkVyV2JUbkJEWVZzTEtp?=
 =?utf-8?B?emNQZ0EzWk5ra2E5RHdYdnpobmg4dEYvZ3BGNWFMWWpQd1lPQWpTb0hESUti?=
 =?utf-8?B?cC9CMnY4TktYSnpRREl4bEZ1bDQwNkJnRVVrK3R1K0o1OFRVOGhTMjBSS3Aw?=
 =?utf-8?B?V0lJakozNEo3TE9hd2xrSW8zcGZXc0NyY2FDbXE2WEtoM2oyaWJNUDZkWWdt?=
 =?utf-8?B?MHZNUzJ2eUVWMzQ4dklMV0pLdnlOaXFjdTN6TXJNRTNtWGVqZ2JOc1Z4SldC?=
 =?utf-8?B?anRQREhhWEp1eVJtYXRRWVgrRlRaQ2tqeG9jV3NVMDg0cFNpTTNac1hBdjdK?=
 =?utf-8?B?NUkxT0dHaXM1TmZiNmFpbzRIa3RtQnpzVmkvSmltQ2o5dlVKakdDaXJaQWVp?=
 =?utf-8?B?OU1kTld2dE1lTUJJR0hyRHp4NzNlMVVObjhPVVVBckFDT05rOEMvaUdYTitF?=
 =?utf-8?B?VTBRTVZQZEhPeFFzanZRMW5wVVdZdVUvR256TU1WSjZWN2hqRUhVQm9OQzNY?=
 =?utf-8?B?aVVSZEgrU0VXdzVVNllRSi9oMGY0QjNTcEFZSnFBdG9lNkZEdUg5eHRzbWdz?=
 =?utf-8?B?bmxGeWMxRUVDUUdHMFN0VHpRTXhjWkMxbTZPVitCOU8xcmRNTmpSUFI0UmFQ?=
 =?utf-8?B?V2dRM2xlLzBrZXIzNVFDSmhNUkxFZXJEQTduZ3FFbFRRcEhMTXVYRndIQVpr?=
 =?utf-8?B?enRaajZnWXE2ZGdCMEtZV3dXSDhheXBhb3R0Lzd6KzhhVHZ0SThoZjVkay84?=
 =?utf-8?B?S3FxM3ZTSFJYZTFhdHU4bUdXdjJpcHVtZllsUjFFNzR5WStrOVFCdk14Z3FN?=
 =?utf-8?B?Y2MvWVhIdFBPTjZBRmdHMlE0OWtjWThCRzEwNVczR0VsODNQaFBTUDJSeFJQ?=
 =?utf-8?B?NzJmam16MG9Qb0JPUGhvRndHTkcvdnUwN1VGcG5FM3Fibk1xOTY2S0dqcDNz?=
 =?utf-8?B?dUx6enByYVVRZjhrcmxSc3FsV3FhbXJMbXJIay9zKy9IRmp5M2ZHQU5QUzRu?=
 =?utf-8?B?aStTd3BUQTdkVS96OG9sQ3Vqa2kzaGpTTUlQWVA0YTI1dnUxdWZIL04vSm5V?=
 =?utf-8?B?SlozUXRjSkdkWC9abVR0NFVNZkR6TFZEVXRMVTlvZ1dBWXVBc0VvUlpKaTZU?=
 =?utf-8?B?VnQxNDZJRFdZY1JRZ3A0eWM4RDRDTTBaaVJXMlVRRDVlS2l5emZvTHh6bjB2?=
 =?utf-8?B?bU15OTdGWU5PaE5PaXlnVVhiZkU4aisxMUNvOXF3VTcrZGZKbTdNN1NFWlgy?=
 =?utf-8?B?RGdsRFlkdWltVXd3OFY5SW0rUCtPdXI0eDZCQ2I1TUQwSXZpblhoWk5udHF1?=
 =?utf-8?B?VVhKVHRFNnVrNEgzYnhXdmhibm1xZDNwb1NVcUpCakMxMm9zSjBxdko3dWl6?=
 =?utf-8?B?Nk1EVmV6UDJTU1pXV3RCQi9jMnU4dkh0NVROWk5xczZwOWdRZHhRRGU2bm93?=
 =?utf-8?B?VGFSQmxMdU9GRW9Dd1dWUDhXeG9wcko0eUZkUURtMkRrUk4vQVdISXpQQlMx?=
 =?utf-8?B?cnRXSWx5eEZRaG90ejFMKytPWm5mVnEwdDQzQ1R1QTNLRFBBckkxbVhjZjhG?=
 =?utf-8?B?M3pRUWlLSlNUQk5lc3hXWWo2T2lzb1pCaGpQbFB5T2MwWkF2U3BSZ3RqaU91?=
 =?utf-8?B?cGt0S3Z5WnRHeXFiWVQ0YWJMK0FTbHRjejA0MTJzWGd4VEwyMWNCckh1alRL?=
 =?utf-8?B?K3RIemhyWUhjMGFCV1pQckJoU084VWVNOGtoYUxrZktLZVVTRlBBS2ZGdUtZ?=
 =?utf-8?B?TXo4eWFqK3lQeS92ZC9vRmxPQmhSaWZYMVRPNjJBMWRMRm5tWFdNYUJPS25G?=
 =?utf-8?B?MzE0YUUzNEdQQndBdUVsWlNndGY5TGxDWUlWSWY0RjNyOUxMSXQ5OXViaWNW?=
 =?utf-8?B?WFNZdUFIdjNTdGo4QVdOcEtJeHBqYVZUVFJydTNYdCtXcjQ4eWIxeXpmV3gw?=
 =?utf-8?B?QXl6c2luakpVcHhRRVZ1K1ZnVzBJRkVKb1BKN01JaHhXbEJDdzlqbG95a0Ro?=
 =?utf-8?B?U0tuc1hwU1h3NTZxV3V4d01yejEvZ2FrdTFhZHJieHZpUk16Wkc4cDRMd1ND?=
 =?utf-8?B?YTk0eGdjQU9LTnZteGplRFhuZFRZZ0VPWXVFK1NNcVJvWE0xSU5BejBvSHRQ?=
 =?utf-8?B?K3JsTHh0Z2poVHRmMmlQbjNOam5DQUpVaXkvSUhGWjc0NnRvRFhrajZHbFNx?=
 =?utf-8?B?QTAxajhpNXhyVUZLaGw3ejdKcy9DR0JYdk1ycDk5WVZRbEdCRTVnb0tTRnl6?=
 =?utf-8?B?RlRod0V4ZmdWOTFLT1BLVDRJNHp1OXBEWmV5RC91Zi9jS2FzUUVvQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69bae4e6-6386-4632-03cc-08de677aa06e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 01:29:10.9561 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1sP/LmCL2iPYHxvxu7EcEjCDVaDQJagtlRGecDW/aGiH51wrcaQCEMdDX5jdCP1T+EUkCO3ZTPmOjYiU701llg==
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

There is no user of gd, drop the usage of DECLARE_GLOBAL_DATA_PTR and
the including of "asm/global_data.h". Include config.h to avoid
build error.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/nxp/common/emc2305.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/board/nxp/common/emc2305.c b/board/nxp/common/emc2305.c
index 50252bb5007f667bd53115922b9c8d06e76f7f61..7e5151eaf5f9f31cb0eba3f85115c0dec46f096f 100644
--- a/board/nxp/common/emc2305.c
+++ b/board/nxp/common/emc2305.c
@@ -4,15 +4,13 @@
  *
  */
 
+#include <config.h>
 #include <command.h>
 #include <i2c.h>
-#include <asm/global_data.h>
 #include <asm/io.h>
 
 #include "emc2305.h"
 
-DECLARE_GLOBAL_DATA_PTR;
-
 void set_fan_speed(u8 data, int chip_addr)
 {
 	u8 index;

-- 
2.37.1

