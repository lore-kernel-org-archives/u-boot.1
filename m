Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB11CA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E44DC80FA1;
	Tue, 19 Aug 2025 11:52:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nythkzWb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA53881D6A; Tue, 19 Aug 2025 09:17:09 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8F9E83145
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZopcXxMtu6JdK1y8GKuKS6+2/1k+k5pFjE5Gx9GYy2itFp98bNHczRKaTCLGIxNrQ1zvisHU+liU+x9o0x7Ae0YsXHE24xGQK6+xCBMjl9FU9kFQDj7XIomGcRq6ponPKxs3Kf99NabA8kGN+P6ksS+EGOaPW2197kWp6GMKo7gbc4RG1wVRNrygg2NokuCsWqAFte7mUcgeWWEGc8mSilrouKbBVUVnk/QMX/STOllbLV99JnAnBWfnx4FMIlr0fcFGR0knTwxchg4ffX6fWknJaoa1f2UDWq0zrHy+Eg+Brxkti1bImkja8AImzGe2KeFKbG41O0KKBqHle/EU8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R28XALK9jXt4uPUuzSHcPfX+uJlJ3nCfoyP7YWC4Pvk=;
 b=MEtbZo8V1TnUzaEbv1ogrQmZustsrcruEFi2K2cFaTTY4/hpNCjTO4fYNgIceIYXscxW89QoEcFdxpJ0Yj2LPm6LqxDd+MuT0vU6f7/zG6L8rJ0TxEP6bAuaCYnGZtUrsfF9pVfgQKRhsf5fsi0yO3o5GnQR+Sx3KHuYApDvzUUhk0B9+FTs0pHub5uRq8wFhVOuBdlsmC7a5NuOCuKdVfSndf9KgdMNRuS8rp8srAEL8+SpjqFhlHLX6ADDPSVLhcyhtXIl2n/UCOal5rHrFzcO7ZPMTI99rE2/3srLF+Q8njeh6LW4cGzOwG+9MCHLjCO6oNZji6TmzthUTWOeOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R28XALK9jXt4uPUuzSHcPfX+uJlJ3nCfoyP7YWC4Pvk=;
 b=nythkzWblk7XF87f/BSDH6PwPj+7jwiDccQevBFk9A3RidGFHNHWEi2BoMpolBWCc71wKloZcoE3HsfXN/S2d26SFVnyTnX8yy3SOWCF5eYMlv+r3m7gO4clqjCGpd+pFhcmLPjeuS7QIPGKC4x8FE4N6xE8kcC8kRbaYO6kkoFeVECziGIl/mLRl55sVCAR36FbmLIAGaDiKLyG7CtZaMhNINGsaiCgCKWbZs894JNV8USgdac4h3/VJECuCzO9Z7YpnZTjw6L0AktsZlltv/eiICuBV2szxthrR/8qXKm4xdP3MfDK8VvllCCetDX+AxfCFVHpw+Ex4MJ0yYeBZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by LV3PR03MB7334.namprd03.prod.outlook.com (2603:10b6:408:19d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Tue, 19 Aug
 2025 07:16:52 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 07:16:51 +0000
From: dinesh.maniyam@altera.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: [PATCH v2] mtd: nand: cadence: Fix device assignment to avoid warm
 reset issue
Date: Tue, 19 Aug 2025 15:16:36 +0800
Message-Id: <20250819071636.25197-1-dinesh.maniyam@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::39) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|LV3PR03MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: e9375f5c-37a4-4c03-b1c3-08dddef05e73
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U01xMlJlVTdMVFF5TTRCbUxaZDJLSHhKdHlkS1FMNDFnRk53dFFXMjkvR3BK?=
 =?utf-8?B?VXhjR003bnJZZFN3WGw2TGJLUWpqbHJ2MnAxdUVlNFliQ1EvR2RpZ1Y3Nnp5?=
 =?utf-8?B?dlNIeXBRSVhWSkcwOFoxVUhnM1hwelZRMlBRZ0tvei8zVWVmNmNkcndLeG9M?=
 =?utf-8?B?d2JjcDdHZHo0cWQrTHJadkNQYjczeG9mT1VMWXlnNFU5Q0N0YytzNnI3dll3?=
 =?utf-8?B?WGJsaFRoejJlMWtRTnRnR2NUdy9zaStYQmNhSmFZRnB0bzJyNThzOTZVeXhI?=
 =?utf-8?B?SkhCZE1HZlh2SjJsMm5zOWZzQlpMUFFTeGhNV3NMNDZ4UHQyN3hjQVEzZFFB?=
 =?utf-8?B?THN0M2Ixc1pIZmZENXdNMjZhM1FlTDJxa3JvVzV6TTBZQTFHTlg2WHUrc1Fq?=
 =?utf-8?B?T01xeHlNZWhNT1NuY09JU3RURUQ5Z3NhbkhkN3dZeldsUEtiQVE1NFF4ZjI4?=
 =?utf-8?B?R1BpTEorWm43aThHVzlWRmZYZnFob1p0MjhzUjVHSEpEY3RYOFZobUpRY1RB?=
 =?utf-8?B?QThhQVFVdXFlMTdwdlFFaWhCdWtFQURKWWdkTTdjSnJtcEJXQUZUR1h2NTRl?=
 =?utf-8?B?WU5yWDAveHF0UTY5MCswbUFMRnR2eCtza1N5c1J4emYyTE53dkFTR2ZpQWR3?=
 =?utf-8?B?TnVTTDNMV0lTYUpxS2xsaTg2Z2FpTmJ4ZEttaG0yNE9xNWpaZ1pEZngwc0Fx?=
 =?utf-8?B?VkFEMXR4dkpaVm42NGFDalRpaThXUGFBK24yOGpDNk1yYUtKQ0lhaVhhMUJT?=
 =?utf-8?B?byt5QXFnQWVRRnRSM010VjhGMThPVE1zK09wRFV1amphWlF0My9rVnVHZHU2?=
 =?utf-8?B?d1hHdHRrdXQxZGtyVG1QYzdyZDdhTjBCRjJWWkFKNUxSS0hvMW9XU1N6MnlW?=
 =?utf-8?B?bmgwUmp4RVJMWnVoWFp4enpwV3U2Q2ZCT1FsZVQvcjNiNzBVVUdxL1U4eFZh?=
 =?utf-8?B?VFpPaENranlwOWtmWlN6ZURGczdWeUFDbXpldTNzaWZXbWFJYjhMckF6SURC?=
 =?utf-8?B?VVhrcmNVUmkwMnVaMzRlOVZ0VHI3VjMrK2k3RGlibDFoUnJjS3d4S2pyeUw2?=
 =?utf-8?B?a2hQeUd0bi9wdFEvbE9rVXR5TDJNY0cxUFhlQzVJaWxqWGtWaFNKYlc5WUVI?=
 =?utf-8?B?U2NXcGZHbG1ZVXA3dXpNZnVnWDZYOXV4ekp6bVZxeU15OXBKMGQ0dllLL1h3?=
 =?utf-8?B?dS9JRkRFbG9LV3MwMERSazJQeTZnNUxzakxLKy9OdUhwUjVyK2cyamplRFR4?=
 =?utf-8?B?SFhacTdxZmRYemdGK2hHclZvY0VjQ3JnN0dRUm92UU5yMnNVT1JDL282Q1Rv?=
 =?utf-8?B?YzJsWXBDM0tGZ1dLU3lXUFNNVlRmWnhrMUFtcFIxQmNLQWFjTFd5eVc2M1lm?=
 =?utf-8?B?MmpGelFIRWp6VVB4UjgvcDVvSEU2bjE2dllvSFdyS2N5N2NmTzhnNS9STDAx?=
 =?utf-8?B?ZVZxMkRpU24xWlNhTUNvejliOUNOeHZHQW9nbHo1NFJ0ZU55S2lEMGdVS3FF?=
 =?utf-8?B?QmRIVVIyU0huTjRlRVFwWVRNa3B4R2VFWFVwMEYvd290OHZvNjFwMWNrWUlY?=
 =?utf-8?B?TnplNEI4a2hzam5yMUdSMmdBRTdqSXNFM091bW5PcDJVSjZyckJFR0NpZGpB?=
 =?utf-8?B?bzd4TG5IbVFZR2pGUDhNQzFnVDNQTHNhZno0dlFuWTR0MlY0WEpQekxVWlA4?=
 =?utf-8?B?NmsvOGVZNWh0NkNGZ09CZlZ2Y1NrSDVaVFlkUHgwMUpXV3djbjVpRGRJSmxh?=
 =?utf-8?B?d1pPRkxBY2s0b1p3Y1ZJOE1ianh3ZGNhd3lId1NSUUNtc0RDNWV2N0pOL0Na?=
 =?utf-8?B?aVM5ZUtnVld3MzIxR1N3SVYybHJiMldZcjhmN1oxTitNQXRDZCtxSlZLNXRk?=
 =?utf-8?B?b003VVArdUNabU1xSE1HU2Z6RExzWHhLemJtTFZFT2xmWEE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OFR3Snh5a1UyZDgzeXhJWEFkRld1a2hBQUFjeVlXVUZQK0Y4Ky9yRjJKbjd6?=
 =?utf-8?B?dVJIdlJ2K3FTdnpVWlg3U1RoMVdWTlRRd1k3YW53WWNWQnkwR29mUTJON1o3?=
 =?utf-8?B?aVdqbTZPM2JmSDJ0cFpNeTl0clExNFU3NFhqcnFGMWdhOHVoU0EzcnZHYU4w?=
 =?utf-8?B?cStqTTVZem1OdmloNmhhNTlkamdEak5YZjRWbHcyR2d6NnowV0loUDNaRmpC?=
 =?utf-8?B?NTRrZ1plNzlXWVhTbUQwd2lUeUQxdlJPSWkraFFoTFVOMmFNL2NJZWlxbVhz?=
 =?utf-8?B?S09Ba1FacDE3MlBzY0hpMkFsZEZuYlBYSndPeWpBd2I4em5FK21iaUo2dzlJ?=
 =?utf-8?B?RDdtMnIwKzBxbDhsYURmeDBQb1l1SHdWUGN0VGdLZjBwSGw5ckJnTU5KVFRB?=
 =?utf-8?B?Qmd5Qmw2dk9BT01yNzFKUHpqdGlUOUJEZExMRi9BWUpVb3ovcGpYclB5dFNO?=
 =?utf-8?B?eE1sUkszQnQ2Nktvc2o3ZUlLd21NSTJIQjZsMmRabFJTYlFWMmdFVEh5MFVE?=
 =?utf-8?B?ZFNuK1dYZlNkRll4RFc1K2dkU0tZSmI4WEdCak12ZnFSRVo3eTkzZnFkRmtw?=
 =?utf-8?B?b2o0eWo1ckMrb2h3a0tHSFRCTTBnb2hPTkxuLzdYOUFmTktkazJtQUZNRTVL?=
 =?utf-8?B?emtvWElJV2lPbDA4VXRlVmdFVFFPNkxpVzJoYVBmRFdtRUkyRTZlNmZVeXZj?=
 =?utf-8?B?QWxzVm5PVUQ4bVp2OGdvZTltcnpoeE11WFBKNy8zTHNmblcxb25xQStHNG8z?=
 =?utf-8?B?bFEzTXZMQzhHVVhMYjlPeWVXUkgwUytLVzd2M0ZYMUtsMWk4cnJBRDA0Uy9G?=
 =?utf-8?B?QjRSdlNrcGtiSHo5V3M3T2N2cjczMEZleXF1d3BBVTFwZVVUWDR4OEh1Kytz?=
 =?utf-8?B?ZldwUVVUMldiRVI1czFOVkErdVpqeFdEUTZkU0xqTEx2T0tHOFZyVHk0QTJG?=
 =?utf-8?B?QVlBcURKYmw1NzF2N3hCODA1eXM4Y2hVQ2JMNXAzMjBsa25lRCtDY3Z1dEY1?=
 =?utf-8?B?eVoxY3B4MUZ1SGFBWHV1Q3NreGVZYWUycmFBM1RueTJXVm5nTDlydHAwK2tJ?=
 =?utf-8?B?Tmx0Q1ltZldNS1kxWjZRN2c2aFNROERpMzJHRVJUZzlvTzYvM1VUaExhQjh6?=
 =?utf-8?B?bXQ2WCt6dU1rd01jQVJabm1NMkVWcGRicUROZU85ZkhxSFdYWi96dXpkWlgv?=
 =?utf-8?B?QVpkWTNueGVaNFFZNHdYckdyWlEwdXJ2KzUxc05ROVNydmJpcXVkbE5uSWI0?=
 =?utf-8?B?N1h6WURXQ0NWOVhxSXdMNjN3R1V3K1R2NXFvUnQzeWRKYThnR0I0aWRqcEgz?=
 =?utf-8?B?dmxJcHQ2blpia01DeVZSYW5YWU54TU5OQkg4Um1yRG12TFZPN0txdjRmL2ZY?=
 =?utf-8?B?SWlOR1MrMG5ESW5xUEhBUHEyMkpJK3RPS2I5aEJaOS81Ync4cEUyRE1QdUsv?=
 =?utf-8?B?MC92d2x5WkgxLzN3TzBJV2Q3UjZXRHo1L1YybXFFdVNkc1UwTWhKZWFkTm1U?=
 =?utf-8?B?eHY2SDluQUxld0Q2V3JMS2ZxNlc0SmtMVzM3RVp5dFRpWDVFSTF2VTR3MkZC?=
 =?utf-8?B?SFk5b1NPdWI2UStrbWV1eC9EUVFWaTFNOHVjbERwZzk5MkpMNXlOWjNia1pM?=
 =?utf-8?B?d0F4MDJuK2o2SVVCaFFQY1ZSck5nVmIzYmFvM3pUS0xtS0RPVDJJa1o4YTVK?=
 =?utf-8?B?Z2lNbzJDVUczcXZQTjlLRDhyVW12d2hxNnpNUDRkeUxSV0xBb2Q2UlF6RHhL?=
 =?utf-8?B?RnIycXZTd1FqSlFCU1NyZlBsVE1OeTlwMkRsT0tsSlQ2NjBQUDQrN2xFVkdI?=
 =?utf-8?B?WU05TFYyQS82NHd1VUNWQ2QwTjhtZDFva0txSVJJOGdnZUQyZy9zME5rMldZ?=
 =?utf-8?B?WTVZTS9MUnJDalRJS1hMVG9rc2M0S3NabUlBTWYybkNtcnIrWms1M2tncDFK?=
 =?utf-8?B?Wm5VcndFL0hOQmlvT1dUSzd2cnMvNFM4KzhzV3NvcXA0d3ZvYVJEa1Z1NlU2?=
 =?utf-8?B?NE1SMloxMHFlaGt6RzhTbkROZFBSckh4NzBSU1Q1ekNyYi8reFc0UnM1eGNo?=
 =?utf-8?B?dG1sc2NCNng1UWxqL1ZoZmdmMHVpVmduRkd2cGtQQTJyNTRFK050U1FDZUdn?=
 =?utf-8?B?QXVudXBucG9LVjh2ZVpwTHE0aVpBVFFxcnREdHNiY0poUmpRNk9OaGM4YnFC?=
 =?utf-8?B?ZGc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9375f5c-37a4-4c03-b1c3-08dddef05e73
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:16:51.8160 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EPZRy+4hyDo65ax+q5A/k6P8HOHJAxzxxsj3aPiD+MEo9pqYakIMtjoxxDkymbiNuu58qpm2+nFRZiiSh4I0l0mTuepPQJ9N8RJiO1MegdU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7334
X-Mailman-Approved-At: Tue, 19 Aug 2025 11:52:11 +0200
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

From: Dinesh Maniyam <dinesh.maniyam@intel.com>

The driver currently does:
    mtd->dev->parent = cadence->dev;

This works in Linux because `struct mtd_info` embeds a `struct device`,
so `mtd->dev` is always valid and its `.parent` can be set.

In U-Boot, however, `mtd->dev` is only a pointer to a `struct udevice`.
Dereferencing it before assignment is invalid, which breaks the device
hierarchy. As a result, consumers relying on `mtd->dev` (e.g. partition
parser, reset and re-init paths) operate on a dangling pointer. This
leads to failures during warm reset when the NAND device is accessed
again.

Fix by assigning the device pointer directly:
    mtd->dev = cadence->dev;

This matches U-Boot’s device model, preserves a valid hierarchy, and
resolves the warm reset issue on Cadence NAND.

Fixes: ebc41cad ("drivers: mtd: nand: Add driver for Cadence Nand")
Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
---
 drivers/mtd/nand/raw/cadence_nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/cadence_nand.c b/drivers/mtd/nand/raw/cadence_nand.c
index 27aa7f97a45..4771440d1de 100644
--- a/drivers/mtd/nand/raw/cadence_nand.c
+++ b/drivers/mtd/nand/raw/cadence_nand.c
@@ -2196,7 +2196,7 @@ static int cadence_nand_chip_init(struct cadence_nand_info *cadence, ofnode node
 	chip->controller = &cadence->controller;
 	nand_set_flash_node(chip, node);
 	mtd = nand_to_mtd(chip);
-	mtd->dev->parent = cadence->dev;
+	mtd->dev = cadence->dev;
 
 	chip->options |= NAND_BUSWIDTH_AUTO;
 	chip->select_chip = cadence_nand_select_chip;
-- 
2.35.3

