Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDF8E9E30C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 13:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E636883DBF;
	Wed, 11 Feb 2026 14:53:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="g7C04J5j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD2D083E1E; Wed, 11 Feb 2026 08:23:10 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 643ED8367F
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 08:23:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cR/oDr0bsPi/UUdbs3AC683ngaPy/nenV4kGRr1m1j1+vGAhSInML4zfFAj77sJMFJWxdcV4nVrd1a2kVNnR+4pgEWqZJxUstLE+uyRMYQ+UM9H5gRrh2ZXM2bIeJ3rk9/O8IlSyV+ep8lAcuQ8NMCnxomiPRMsVpdHhWMvYOqwKS9v/jhkNcZBJh2u4p1FjGi1m/egiaTPShiBKiO9+PVAPpvUgrwR621JHOWUiC9wqoAuDPZQ+LiX+Zhic/VjG29G/clNFbHC2daldye1k9gZ/s8QmbMQIHkXklKTYPLKC22Fjb5Nsu3HRhjw7dAAvbAXoU+67EC3xNuTcg6M0LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjEN9GUjvPdNhc15nbTncY6jvsZtvlxnZWnmvQ/VIqI=;
 b=C6l4uK5YQq9qosqzeXQsmua1yiz8avf/7xLT44y08IIBhWznJS9oHLWJZK3AHTirRtiEjNLU//bVA6UbA9OhDTK9O1xgVo/W/k8GnmXebAyHrFljd7SBz0MTGzpJM7tTPEG5al00OvNRQddSlx3UKuU3+lcaUKEI4ABXdHKFin1665Dop0J5pabu04NE0n3JmVeYPKaqbs6Pk0pu3mZeCTgOrcbT5/ivJyj/Zvmp3qQ6YLTalHpnuVNhgydE2096W+SRZnIa3bcHGFDY3K3I7Ya/2r7WeIsha87zUJAmJI3sLHN6mcip2oIAsH2JmcHwM6kj49MUcuWU6oWdUYeyjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjEN9GUjvPdNhc15nbTncY6jvsZtvlxnZWnmvQ/VIqI=;
 b=g7C04J5jajHTBDGFdSkeHXbZOHFzIt3rSSvUWiBDOW+MV2d0sN3fcR6wvbQKEz43SyhZ54G1JJGKZSRe2V0e4M1UDEaq4J5ZtYxHSYtajxBsFTD+IW5hUqaAXiRJkeYEb8vlEcSorRn4ATp0O2F+7WV0MfTz6aYC0v199mGEKQuJ1ADJGQBOfJA9poDoCUcphLYwTEevyB8oFra0GhxIE8ovRGvbA1W94ic8g9F5WG1VjnsMqxfDvdACikAtBOuMQMTZWhQH/P82RUqt8D0KUi5M5YaY2pem1YRpC5vI4w9tz/+0XMNN2DFTjlZSc0Qr6MvXm/AnCzOuz2c0uNThCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by SA1PR03MB6627.namprd03.prod.outlook.com (2603:10b6:806:1ca::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Wed, 11 Feb
 2026 07:23:04 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%3]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 07:23:04 +0000
Message-ID: <6e6a547c-ad0a-423b-83f5-507c908cbe42@altera.com>
Date: Wed, 11 Feb 2026 15:22:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mtd: nand: wire SPL NAND MTD loader into SPL build
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>, Jan Kiszka <jan.kiszka@siemens.com>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203074721.25520-1-dinesh.maniyam@altera.com>
 <20260203074721.25520-4-dinesh.maniyam@altera.com>
 <20260203145758.GJ2603314@bill-the-cat>
Content-Language: en-US
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
In-Reply-To: <20260203145758.GJ2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0062.apcprd02.prod.outlook.com
 (2603:1096:4:54::26) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|SA1PR03MB6627:EE_
X-MS-Office365-Filtering-Correlation-Id: e998f6e6-7a17-4616-47c9-08de693e653c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXR2azcrQVZBazNVbVp3cVJBYzRja0I1ZHY5b0M3ZXI0UWxFb0tyMUJWNk9I?=
 =?utf-8?B?Q3hlK2xOalAxWGZsYTBjbnNHenJIZU9aUE5vTmRrNVRVQ2dHR1NocDJhQTc4?=
 =?utf-8?B?UGFqTzdDZUU4NzJXd2FUMWZNVGFRY0syVWJZRWdKc2Fpdlk5a2M1Q2R6Y3B0?=
 =?utf-8?B?TlRJR1UvS0oycU5KcHE2NmhOMVJkR1dWVVBPM3M4OW5YZitZRzViYk55eWMx?=
 =?utf-8?B?ejJRV1ZHRVFkd0poWE1Pd0laMDVVRVNoZnNZYXJtcG1WdW9PT0JVZFowOE1m?=
 =?utf-8?B?aHdHVy85QjhCQjI0WnlUeTZBVHVLMDhjVlBuRTFiM2tnN2dza3hHVUE1WjNM?=
 =?utf-8?B?ZFZLYm9vLytVSEJSQVhvTzZDY2w0aHoySzRkMHZCejJVdDBwbjhKR2FiaWVu?=
 =?utf-8?B?QnZMSnFvWVZQdmNtU3lSYWJaVEVRQ2xSbDFkNy9GTGRlWXozbmdVRWpyUkFv?=
 =?utf-8?B?L2pMUk9XU2VtbzVCS0Jrb3A4V1k1TXY3WERYK0taSGFQQ1lpTU9wUXB3bVc4?=
 =?utf-8?B?cnBxQjhKbk5oa0QrM2tnQWVGdXZobE1FS0NXT3NPNkUvbW5GSUlDbTgwejZz?=
 =?utf-8?B?ZDhJaXZWMVRpd1dwY1pRY2wzVmlKNGxMc1R2REZwbmxNQW9RNkpmN3kzVExK?=
 =?utf-8?B?NUJFSHhpUEJnV0VNRm9TL3ZHdW40aDlHbE5ZMlNmc0pidnozQzhSd1l4UHN5?=
 =?utf-8?B?QUZFQjBkZzRGZjNnYkJSYkN2TlppeTUzRmpSU1ZtSkpKWUJMSXR5ZllRckhk?=
 =?utf-8?B?ejRNQzJkaGQ3YVNSNmQzVTBSWTU5VUV4M1p5ZHJDQWxRaXN1Wmx3TEpXbnk1?=
 =?utf-8?B?QTlDa0xCbVlMc08wZHBFSi83eEVLaU5rSEc1R0NSUnpHRWRkWmRpQnVoTkhp?=
 =?utf-8?B?aTdNb1ZwRjluOHJPTHpZcGtSRngveHEwMmRGTWRrZEhrZG5ZbFNxVWlCbE16?=
 =?utf-8?B?RE4vaVl1dVFwNXhOZldVTXkxelp5UXB0c0FyRFNGNE1kNU9aU1k1RjNjZFZy?=
 =?utf-8?B?SWs5d0NETG9nYkJLOG9PZnA1K3c4ZktDUDJlOE5uMmZHMmt5QS9GMFRnQjFB?=
 =?utf-8?B?OEQydzZSaHFzaVVkeHV4aDBpMEo2a3lhWGJEZlZ5SjUrYzUzblo3cTJRTDdD?=
 =?utf-8?B?RUVmTWUrcGpUZlo4bkxkcU9qc1pvazRlcmN5ck9wQ3Uya2Vpc0sxQjcvZGNm?=
 =?utf-8?B?QUx5Z3NGV1dnQWdFQmxPSjc0RFVocWNFakl2c2tpYzltRE9qK29HSU8wL05y?=
 =?utf-8?B?WDV6aCtTOXNMcmhzeDVIcDM4QjNiN3FOVHVkNldscEZwK0VqOFlvRW15ZVRZ?=
 =?utf-8?B?bGFpUlJBb2orczFCY0p3dkx1UmhORHVFNzZ2N21DeUllMU40d2h3UXJmNVZI?=
 =?utf-8?B?YTRBZlExWWRwTTdOKzNSYnFuV3B3ZFhsejRtNUF4cFJTRExyaEZ1RkZjOWUy?=
 =?utf-8?B?bnhLNWpiMzhQRDBmQ21scVB4VEhZeFVFNk9ENEQyT2c3dkFoMjc3UnZsOU1J?=
 =?utf-8?B?MUlVVnJSdTA2QWhlVXpWSDJML1FnK3Q2cFo1dndnSGU1NTVGUnpHTnhYOWZ0?=
 =?utf-8?B?ZXpCR3JPS21aN2lCNmxsZFdoRlc4UjkvSnB5OEF3QWNFNS9vRnJYZnEwdzRQ?=
 =?utf-8?B?Vyt3NVNRZGJuNUM2OW1pSGhBYUo1VU1Qck1Cd0hxelFPL3lubEJyTmRjamVx?=
 =?utf-8?B?MWVCMEZXNlpsZDVvdVJBQ015OGp3QWxOOEwwWktOc003dUg4ZGwyVlQzcDJL?=
 =?utf-8?B?M2NmTkJvc1pOdmJlcjh1ZUhlR211TTdxN3BpMUYveUU0V2dJdk9oZi9yNWcw?=
 =?utf-8?B?ZTB2aW1lSTBkenF2a05GemlVQ2Ezb09mS1BlOWdSZzVoU3h4b2ZzS1ZPVzRt?=
 =?utf-8?B?dmZpek9NbEZqY0p2OWxLMmZCK0tmRHloUTdTNU5yTW9MUTcxUkk3Wkk2eG9v?=
 =?utf-8?B?cjFsemFWdkt6eStLdE5hS0NqaHAxZHhyM21CNmJId0h3VVV5TUs2K1JIbDFo?=
 =?utf-8?B?TDR6alRnWFB2emFEU0hzUnI3WkFqU0FQNFo2Z1NaQ1JQOWErU0dLSGwzczlp?=
 =?utf-8?B?eVA3YUoweGZ5N0VoMDFwcisvZTM3d211RGV2STMzZlpWVjJnRStXN0NSTndQ?=
 =?utf-8?Q?6qzM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVwMkkvQWdRMEwzSVJoV1RUTUM0RFYzZlo4anArQ2hBS0xRYzcwTGUra1hs?=
 =?utf-8?B?Z2pjNHU3Ykwycy9iSVIrRW82RTFpYytTVFM4TGVsalBYWHFSZU5yWTFBdWNM?=
 =?utf-8?B?OVZuYjdXczdTMzNvRU5QWG5UdDZLeDVWbDE0cXJNa241R3BWamF6LytLNWMy?=
 =?utf-8?B?TUkxUi8yaFV5QTBiN3JvNHY0WUJCbFRsTmdNdE05dGVPc21xWDlTTFl2TWpl?=
 =?utf-8?B?OWVOa0lQNVhNT1VuYVpKSklzSFBvd0VuUmZmeUNsYVdtc1g1KzJLSFEwcFVv?=
 =?utf-8?B?ekVvUnk1WTlPSkJrZFJvVjV2MEdUTCtaZ0c2OEk1ZmF6SGU3VnpWVHNWell2?=
 =?utf-8?B?U0x0cnV5Z3Q5akJxcDgwdkJ5QkVSR3lNR2FjRElNbi9FZm00MGJDWXBMQVcv?=
 =?utf-8?B?T1NuL1VZQld6anY2YnAwamJPbFJkb3pqKzBwYnZwTm5PNjVuSmhoYXFGZkUr?=
 =?utf-8?B?ekI3RlcrMHRjbnA2b1NXMTFETnhFcHR4MWw3YlNSLy9rYnI0c3MvMG9hejA2?=
 =?utf-8?B?S1hkMnNFRHVMaVNVdjdpL2lFTjZMMkFXTmhJOWVmZm5sazMwdERNSllSekha?=
 =?utf-8?B?alBQaUxRb3puZlpvcVNBK0x2WSt4aXVlNXhVWk1OMURxOTBlcEtNeVJTREd1?=
 =?utf-8?B?NDFWdGhjazdadnIyQjdHLzJUeGhkanZrRkYvSTdESmVoaHEvNU9wOGFTMk5E?=
 =?utf-8?B?NUlKRjloZDRkOG0yWlhFMHRyUnJNQUt0a3hGR2M0SGpWejdEdFJpcENrSlpx?=
 =?utf-8?B?NGhISVk1anJ0Ung5NTNWOWtlaEdiWnFnc1dYKzZMQWd3MFRkTjFJY0VjOHRu?=
 =?utf-8?B?L3hjSWQ1dUQ0L0o3QzFocmZkR1A0VVpPWGJsV1J4MHA2dVM4eHIzMWV6eHNW?=
 =?utf-8?B?QkhGM3FPSzgyMXpYTEloN3h5K2l5TVZRb2ZKNDdNckNTOE81MWt1SE9Qd2Rh?=
 =?utf-8?B?Q081OVR1NWZkajI0RXg2OXQ1RE1iRzJFaGxIdDBhOTBxMytYT1AzcW9JcHFK?=
 =?utf-8?B?VlM2RnZjWDVMeWw3ejlRSXRiZzlybVZ4cnhMNGVlYndIcnFodlpvYXR4YW9x?=
 =?utf-8?B?OUE4OTJObVF5bVUxNDdmTEExVGsyWUJEYVhFQUpHZmxMdXFVSEVBS0ZPV1lD?=
 =?utf-8?B?YmFaZlUxdTNsM2kzVGFDVVBtcS9tSzhJWkVYc2JsMDYwd004VTQrK0s3RVJi?=
 =?utf-8?B?V3M3cEhwMkNoVTE3bWNRZ0M2eEhrQlFMdm9zUTVZQUg5aWx6UjNNMjZxSk50?=
 =?utf-8?B?RE1ENHVqM3ZkNEFpcVVMdUNTZFFncVNpTEhxU1k4VVkzNEdKanpFQktySHZs?=
 =?utf-8?B?cUplNm9RTGd5cWVDZ1AzR0pXNjkxSlZpNjg0S0hXeVFlTWY5NUZGS3l3TTFV?=
 =?utf-8?B?L2w0VDE2L2NSSjNEYTk2clNRQmVsRWlZdG83YlpyRGh1Y0YxcG1pQ09kQWVM?=
 =?utf-8?B?UGw3bGxVdnluelh5UDZIRk9ZVUI4WG9lZTRGZCtJUEFGYkhiTFBBdC9WQ0NO?=
 =?utf-8?B?SmF3TW5xakMzWWJpeDc2SGFuRnBPNDFUeXI4bUxXQlJhNkhwVUExVHB6Q3pK?=
 =?utf-8?B?cmJ6K1VBVVllR1h3Q2pIZFBERzU4V0RHaXZGbUI4NlFTcElOL0UraEdPWFlk?=
 =?utf-8?B?b3h4MHM4d05vUERRMVg1R1M0a2dHUzZGQUZYMnFrQ1JnbHVWYzBDbDJpY1Zt?=
 =?utf-8?B?Wk81NkNCRWc3Mmp4L3hUOHJTRno1OXAxN1hDY0xmeDk3dElEaW51U25ubzZX?=
 =?utf-8?B?c3hPKzZVMzYyS2NWOVZHczVYZTlSekhWUUY3dGZYTWgwNitDcHlnOXZvV1dh?=
 =?utf-8?B?anZzYXoyT285OFBHaG11YnpNakJpei9mYmNnaFExc3NYZmJXbC9qeldjYUQx?=
 =?utf-8?B?cTNSTDNFT0dtZDJuVjJ4NlcwZ3FaY1I1Z000eno4Q0xhTXoxaXNReitIcGY1?=
 =?utf-8?B?ai9CM2c5TEpwcjBQaDZTS2c2VktYc25nQ3hTMkRhb2tyT1lRdDJHUDd3NHVC?=
 =?utf-8?B?Rng0NzNxVUhCU2pjWTh5WnBLQ0R1TWszUlJQTmo5WkZoNEtzRTViaGlrYWsr?=
 =?utf-8?B?dnhGQm5SYk82RUdNVS9RdmlvRld5VkR0VVAvRlVkdWRIZjY0M01oSUs0ZElm?=
 =?utf-8?B?ajcyeGlOSUxOMkUwSEQrc1I1ZjYzQjNZYUNBYTIvaWJxRnRVUWZLNUcvRHZw?=
 =?utf-8?B?bldwNjFMeW1NL1JCckdZVVExU2VXQlRnbm1OVmRBQzA2dVdDZmpRSy8wcFFP?=
 =?utf-8?B?WHdqdDBlT1loaUhHSUlVb3FDRHE3bnVTL2xBQWhUT0xvOFdnTTVSRzJ5NlM3?=
 =?utf-8?B?MTJoQjZYM1B5NEU5MmptRFh6VENla3RwanJUT0RITlI5anJYTk9xMmtydHpD?=
 =?utf-8?Q?kCigjIEou76gC2MY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e998f6e6-7a17-4616-47c9-08de693e653c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 07:23:04.6316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyOjVDd7usyclFs2GPTOs2WzKJeL16R2u4Lhhrdt/qR6BoZW2jYKnwrbMYXlyXVQbs7GCdaVJP0Vvw8v/EkfaKDIWGF2ItRcc/iA73gQ9VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6627
X-Mailman-Approved-At: Wed, 11 Feb 2026 14:53:33 +0100
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

Hi Tom,

On 3/2/2026 10:57 pm, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 03:47:19PM +0800, dinesh.maniyam@altera.com wrote:
>> From: Dinesh Maniyam <dinesh.maniyam@altera.com>
>>
>> Wire the generic SPL NAND MTD loader into the NAND SPL build when
>> SPL_NAND_USE_NAND_FRAMEWORK is enabled.
>>
>> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
>> ---
>>   drivers/mtd/nand/raw/Makefile | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/mtd/nand/raw/Makefile b/drivers/mtd/nand/raw/Makefile
>> index 76546a6287b..51a3b9a2aee 100644
>> --- a/drivers/mtd/nand/raw/Makefile
>> +++ b/drivers/mtd/nand/raw/Makefile
>> @@ -12,6 +12,7 @@ endif
>>   obj-$(CONFIG_SPL_NAND_AM33XX_BCH) += am335x_spl_bch.o
>>   obj-$(CONFIG_SPL_NAND_CADENCE) += cadence_spl.o
>>   obj-$(CONFIG_SPL_NAND_DENALI) += denali_spl.o
>> +obj-$(CONFIG_SPL_NAND_USE_NAND_FRAMEWORK) += spl_nand_mtd.o
>>   obj-$(CONFIG_SPL_NAND_SIMPLE) += nand_spl_simple.o
>>   obj-$(CONFIG_SPL_NAND_LOAD) += nand_spl_load.o
>>   obj-$(CONFIG_SPL_NAND_ECC) += nand_ecc.o
> This should be in the previous patch.
>
> I will merge it to the previous patch.
>
> Dinesh
