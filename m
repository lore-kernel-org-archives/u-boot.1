Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC8BAC369D1
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 09:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 66AB181E14;
	Thu, 24 Apr 2025 11:16:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GMwUf/ft";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F71F809D4; Thu, 24 Apr 2025 11:16:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E620B81B4B
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 11:16:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnermSw4i/87h8pHmA3wU2cQlTEN0KNYlQ/ox5uKZivwl6F5MZ7baixnFR4eaelJ6gt6cUlOH57ZIdHoRKr1C/PKnPNNyQtoRD/3IYvcWTkVjSAThdMHLiOiw4H4DXEmLA1kDCiPUB6vJgCMgEmaTN6x0F+SHyFqdZtL/IMahyauwc1bzQg05cg1Xf+NlsFR6xW4KAbVZaM9hT0OL8rVf9pSWmOo6OGb5pj82uyX2RYQsQJi+LZ5N+EgHisKAstHFuzaRqOE1srFprgCEg+YR0jOYkH7UEuIFgV1e9GhRabnJ8ctOXxKzNZDvrePX/723bhTNzwZw7Yt952xlXlH7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqDc4JzBigO3IL0DdqpjalRFlvUTor3XZvnCQJqXFS0=;
 b=uEW7qjT4iNgMD4UCmbXo9AHlZTdRuU1SzSq07dC045RG7DRXrCFaxg3LcY2NPmcTpgOYCzK+7IocRfOPk1c7mOiqW7ewsYCJJk7Q/mI+y+M31lR/vuxh8APbbqrccDJiIwGYc0XysZ1r9PPrEn3qhRbr5DwuBj2YJ4RIXxWDMu3XxHBLxLsrYZ2VtJqg7x/YzhZ/xa8VN22jSluKJimc0IwukrY+H3Zzy9kpIf7UUAPd+yBsNQokdZ+ToLX37o9uLbMi8QBDWuPB5ycYzFYzbxCYyCKZIxOQGgAhInrMy6z1BR18o6J/q6KRdSftoBMz2MO53OTapKplL13zN6d1EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqDc4JzBigO3IL0DdqpjalRFlvUTor3XZvnCQJqXFS0=;
 b=GMwUf/fte9DmZyBgdfhd4r8JLq2TJfpfEJjwT/ASN5gnKdedpIxpjEMOiN/ybzyX/dkmV4jAL6LLxvGzEwSNEw/U+Vw8bXmACrup7B7y19Bjg5GhV4BNHU46xGkgVFifKo4MZYzxfxGZOXFgiIhKLlmfXUrrUeT+zRDgSAMoedc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10326.eurprd04.prod.outlook.com (2603:10a6:150:1da::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.25; Thu, 24 Apr
 2025 09:16:07 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 09:16:07 +0000
Message-ID: <f6502b26-9e1c-463b-86b8-8b3e58675678@cherry.de>
Date: Thu, 24 Apr 2025 11:16:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: fix typo
To: Aristo Chen <jj251510319013@gmail.com>, u-boot@lists.denx.de
Cc: aristo.chen@canonical.com, tobias@waldekranz.com, trini@konsulko.com,
 k.kurematsu@nskint.co.jp
References: <20250424091416.87720-1-aristo.chen@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250424091416.87720-1-aristo.chen@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10326:EE_
X-MS-Office365-Filtering-Correlation-Id: 65af3d5a-16e4-458e-c334-08dd8310a49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|10070799003|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEY4T0dXbGh2alN4WjhRNytaVURvUG5uZC82L2o5MXlVbjVPbHczWWhIZlNm?=
 =?utf-8?B?Z2RhNEJhTElxYmZhaTNoWENHR2dMK0dLMVRybkh6TVVBQmhobXpjTHRYQ0Zs?=
 =?utf-8?B?ZlhZYmtiNzlhbSs3eElQSC94NTZjaXRwQ1NaK2Nab0xJd2Fha2IzZGdPREVu?=
 =?utf-8?B?VWYrN0ZMWHRmaWFkSGVDN0J0VU5GTEN3bGJ5MERmejU4eDhtYzVBNzNLdXI4?=
 =?utf-8?B?elAyMUoyK3RsTE9tdzh4NUw2UlNaUDViTkd5SEdzRFJHdlRpTit5RmdWNEZL?=
 =?utf-8?B?ZUFPaFhHbjZOMnJDYnkrSi9nUnVpbmNZOUR0V0E0TmxVUHFoOGxkZTVQR1Bi?=
 =?utf-8?B?a2tnRDhMVlRaM0k2VTFHVGlEYi9BVmVYZmhoUjZYSDVtbTQ5WDlkZloweXMr?=
 =?utf-8?B?YlRiYkZyOElnT1hvU2RtcVFYaThPVncyRjlpbE1nNDJHWGxNNXhaWVVPV3Nq?=
 =?utf-8?B?bEsvSEpXMkJCNlRqL05CVFBSL09pSEdkOVBmanlha05qdGNCbnkyV1RKS3ll?=
 =?utf-8?B?VGVGVWdHdzJ4MzBPTFZoZjh1RWRiV1laYkJZRkgyNkQzN1pTbk10VGU3enJD?=
 =?utf-8?B?VGl2RDA3cVBIRWJhN2c1dG11VDFJK2p2Z0taSmFnSmxBNGJ0SHgrdnNkOEhO?=
 =?utf-8?B?eDlsZEkrbnlNY2o2WFNmeFQ4OWZVTlNibXlOL29ndnZkUk5wd3Z1eHp4SXlm?=
 =?utf-8?B?M09LZENENVVEREEzMC9JVXpIR2lLeXlxT0FiU2FNNkFzaGZqc1ovcVp4QWdm?=
 =?utf-8?B?bGs1TGJqeWNlTUI3ZUJiM0ZJdGZFeFkyU09HZTVLcTZYY3lhWlAzMldvMkhY?=
 =?utf-8?B?cU9zYU4zRjRGZk85R1VHT3ROQm9mWjJxQVVheEwySnZsakk3dHZjek9WdGQx?=
 =?utf-8?B?Q0w0YzdOdmlFSjM0YUZzZjJ3VW14SnZacHRsVXFEcnVvUC95ajRTM01pWDht?=
 =?utf-8?B?WU5sRXVnZDR3VDc1TGhPT2c5K3RKck5Za3k5YWxzTmZVUWxXYU5hNXpITFBW?=
 =?utf-8?B?a05iVWc2ZnF3UkdvSngrK2gzZlhYK2RjNFBkUGkyc0RMUUVGdWNuMnhYZmow?=
 =?utf-8?B?TDZ6ZTFIcHJHcm9zNGVmK2hqN0twZk5CUS9oZ3E2dDQyZ0NNY1p5K0ZJSklN?=
 =?utf-8?B?RU1RNy9mTmZNSzY3Q3VQdnhSMmZyRExxMkRzL09KdGEvRUE4VXMvL3g0T2s2?=
 =?utf-8?B?K1lqTlZWY3NabEMxK3hqVFA5aUlaV1pkMWx1VXpvUkwyTkhvKzNBWjN2S2hl?=
 =?utf-8?B?NnVpU1U0NVZ1UW1rU3hjbDZydDNSQUhIQldxcFloc1NXQjYzSm8yaG5oSTlS?=
 =?utf-8?B?L0NnZFQzaEg3alhONUYvcDFGOUZhRHVvQnplZUpGcjlVdndrUFJ5MlREeUpH?=
 =?utf-8?B?UWJhMzhwY1M4dFhWd1JlK2M0THdpMGNzU0t3UUVyVEtwRmF6c2UwN24rYUh6?=
 =?utf-8?B?UDJ0cDlyb2FiNUR4ZVkrVndmVTltdDNDZmduNDBRUjdWcFhNUlM4VjU0UnZo?=
 =?utf-8?B?cTR6K1pVd0JzOG9VdlpvY3NqVkxlV09KWXd6MjI3eEsxeGJ5UHlpN2pscmVh?=
 =?utf-8?B?MVp6MURmb2dHa3RQQytoVHlFc3ptZmJyb1dHOWpjWFFVTnNEUi9CNVlhc3Ri?=
 =?utf-8?B?NzVrM09zVWVwTUhHRUtISk14U21ZR0ZFR3hTOFg0RWI3NW9MeUJhaFhKTTY0?=
 =?utf-8?B?ZVM1VEkzZjFMWXFhT3RoNHRPdW5nWkg4WEY2WW5Na2gvQ1FFcUExYk9HTDE4?=
 =?utf-8?B?Z3FtSTk0UUpzNTdEb1lHSGh5SHhUUlhGUVBVRU9KZFdjQnpmSmlCZ1ZucWY3?=
 =?utf-8?B?eGVRTFpGcE12QmJlZnJmV0FROEQrdGZ6endDRlBROTNTc3VIQzhqQVFVYW9T?=
 =?utf-8?B?bk45MTNjb1g1dnNHYTIxY1hJSjZuSHBrVzVSUTdDcDZneWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk83MTdydXZwbWdzR01pbjFSWGtuZzkxcE5FM0w0NURScjQ2bFlETTBObWlT?=
 =?utf-8?B?VERYTys0dWVYY1NDMEg5RGJnZVMzemhCZ0VvaThQb09Ub01tcmdkUm1GdWZ5?=
 =?utf-8?B?SWtYS2dsU0VCR3NuMWswcUxKcVBkL1hrZHl3Z1hqYVBpWmIweXFKTXd5ck53?=
 =?utf-8?B?Q2oreXE2eFdQcGNOVm9RdzZjYjMwb29GdTVkQkEra08zL1ovYVR1NWZJM0tB?=
 =?utf-8?B?SmVJRDh2UEE2WVh2SXVydm9MWDJqdmRwOHU1eG0zMlVPRUJsVUhnTjJLdTlM?=
 =?utf-8?B?MWpJd01GVVluUExtV2NwUmN4ZWpWTkJtaVY2b0xtaTUyOC83TFoxNGVqUnl3?=
 =?utf-8?B?KzVEQjJBT0tsSkplT2RlZ0FveGxPNXYrNUYyMWlpckloWG9SVnIzTFlURXht?=
 =?utf-8?B?WmlkSEtBYW9kZ1I0amlFU3Y1T01ELzlRM3MvMng2K0dscEFSQlZNUHl1eVow?=
 =?utf-8?B?ZXpERSs4ZUdDcjh1ams5TkN3V1VrUHVtbmkvK0NTSDZHZXJJbUNneElVeDRO?=
 =?utf-8?B?WkFvSnp3Q2krL0hQZlpYMzJjMlJ0eDVSdm5yRVFlMlkrMXpQRFFEUlhJaDc2?=
 =?utf-8?B?UUJFUUdzRWJJS2I1b2lKSldEaTluS0ZqbUp5cFdVQVFsblVSc1MwNmZwZDN1?=
 =?utf-8?B?Ull5c2V3b201c0gyYmR6RWRDTjFWUWJoZnkyUmU5bUhmMGlHb3RxSlhPUFQ5?=
 =?utf-8?B?c0JzamFWTXB3dlZUSDBEUUk5SDNRbVZnNVFoaE5qUnhpWUVtVGJCNWluWlhG?=
 =?utf-8?B?czBFNWZ5dWlpYm1ETGNDM0h6S2xZM2VHN3UrR2tOS2ttSDUxU0x3djFPSVF4?=
 =?utf-8?B?MHJ0SGZlYU9wQzNnWElYZnZPV0t1UkpXSnh3Z1VoTXdTSzlKRHFjcFFuNm45?=
 =?utf-8?B?ZzRRdVQ0NDBSbWhYVFBvMlJFQ1ZJQTRRby9kTU1Fc2JYRnl1enRwaVY3SWt0?=
 =?utf-8?B?OEZ4VWxEYWNLUTFIMWl2eEZ3QkhkSFNZNXRCU3ZraFpPV1JYUTdrMGQyT2th?=
 =?utf-8?B?OUpWLy8zQlI2SmZqSXBXNWpTZzNPbm51VFZ1ZTNnR1MvcThNVW5DYXZiMVJy?=
 =?utf-8?B?cVp0RkFVSlFJZEEyeWJzVmp0SG9mWG1QQlFxc2tCeW9wTE16RzFxTnpHRHp4?=
 =?utf-8?B?c3d6MjdEdlFDenp5S21vL3BpeE1sSG9Dc2ZUblNINUJCeS9ZZUNvZElPMUN5?=
 =?utf-8?B?TFVQaVpncWJnYm5HWlhTNmZRVGtwaDhZNlVJc0N5NHl0UVlQLzcya295dHY1?=
 =?utf-8?B?YmZ5RFBTdTBwclBKU2VmMkxMd21YRjB3YXdlQVFBc0JTd1BtcjZOMGlxakZq?=
 =?utf-8?B?T0R4VmZvT0Z3enhEcWRPUVZ3SHV3OXN6L3A3V0RJK0RyZ3pGNDJlM3JPMmRR?=
 =?utf-8?B?anBwOUptNkdjeFlYU3JLQVJISk9vcVY0L3VXeHZZK0RrUmNjYWJ5TE01Qkpn?=
 =?utf-8?B?MnI5K29LUDhBZy8xOUNIUjZMeGF3WlZ3MnNreVFTS1dvcjI2YU1uaWpUNHZX?=
 =?utf-8?B?YlpQN3FUd1REa3NHRkVocnhmL0dtSklUNVE2dHorK0dwNVkva0o4QVJGMXY0?=
 =?utf-8?B?YWpIenNHOFNhU0RjdGpCREladlRET1NoenRvQWlsNXpKblc4eVRqdmowK2NV?=
 =?utf-8?B?clhQM1R2VkZQNDRldW9VZitNbzJCRnhsWVFIUDZBcXh5ZGpubzlseFJ5Z0Rx?=
 =?utf-8?B?bC8yaEVvZzBjdVVTWTBRZldVM2EvWkRGcnFlV0xybUlGc2x5b0JiUDRPSXhM?=
 =?utf-8?B?NWh6M2NTRlBGWEZVaU82bk9oUU16L0dBOUVSTjJ5MmY1R3o0RHdzcER4blpZ?=
 =?utf-8?B?cXZMTUhvOVBYU3o1S3RkcGlXYWs2VERoWitVL2NUZTcwSFA1S0ZvTTcvSTcw?=
 =?utf-8?B?STI3a3RXQ2pjUi9jR2czNGJ4dUlkZE9NQlRlQUIxZzVnTWhtcTBIbU00YzhD?=
 =?utf-8?B?VThSVDZDeTJPVnYrZ0d6YWFKeE90UEhJVEE2dkFxY0p3VVdPQ2dEZ3VtK0xH?=
 =?utf-8?B?LzhMSTdOWW1ObW1iRjFqMDU0ekZaeW9PVEIwbko0TkVrU3UvNlFMeUJZMkI2?=
 =?utf-8?B?MFBqMzdKUUpmS0VwQ3hGWkZvaE1OREIyWlNSNG1qSWdmV0xkNXNVMDIzOGQ4?=
 =?utf-8?B?MXJpQkd2Y2haQWtEdUdKdUpiNklrY1F3eWpZTVgrRzdDN2ZTM2pkTmYvRGNu?=
 =?utf-8?B?eEdpQjErdHgvUndJZGlPZmNQdXBtWHNUeWZqVTNtUXUwUWhXNUZXbHhubkNz?=
 =?utf-8?B?K3QreFJEZHdCUHhXSGk2MytvcmlRPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 65af3d5a-16e4-458e-c334-08dd8310a49e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 09:16:06.9939 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jsBDUgeTchM2a0DFrnwcS5CSWJaLQS9Q29NuV+VRarsNFiAQxbuWScSbLt0F0eHh9MSffso7wQN7uAzUonKCBTvM9mcsCk5rvy1y594hbBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10326
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

Hi Aristo,

On 4/24/25 11:14 AM, Aristo Chen wrote:
> Fix typo from "to" to "do"
> 
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
