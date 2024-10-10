Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743CDCF11EC
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 13:03:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02A688904D;
	Thu, 10 Oct 2024 15:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ip8NtEr8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC31F88EE6; Thu, 10 Oct 2024 15:03:22 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD58A88EE6
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 15:03:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L3NeHLvtDgSmvT+Wco57YtsE69Zla2zFN4OOkmmAbH+UB5DtH5LjFWdXLUkFSRhAUe6+hU9vNB20hjYSiJp7a5OZp4s6Ney5lJIycdI2uHuwCramgYHSM45MaSEZTg9p5pneEth6t6qRuDkNzl/vrwhzwE2DcLeUKklDXb+9mvIqQfXghfFZfUMW0L40BNlqrhg4repoo8JMb8ZmcNs+uK4uC26W3lSrz3TSUSI5uJMC28rezfX8UVFqQbpWYRhfL0nKDgd0lY1PXO5Wn8p+zg+t/v79CRZQ7KMMWfAGdyTqFigjZUpv7d6Spo0a+wOT3RvsPikblQtl52uekhMRdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TCEF4rSmrnKPhw4/nM/5ER+ThIZL39yiZGyAwnWaNL8=;
 b=UkKZsnLyFRdCndzTKnttX1jZHy8kP++QW7MmaC9jkmhNkN5fTJ06ILYwQ/Vof6MTGxUNkhy5MbWpVh5Q8GQM+FswYAluP1svVLn5/ts6k0b7i67gy877CsWiaa5SWjV7SPOXUP6ZvMzP1rUk0EK0HvkO1CqqXpbWas56I+sGlr2iQDgwPv95joUu4VbAIDaop/LMZERYW39T1p3dfd/soGKwCGqehk6wQkOmDt6ghQ6MBzbj7PcPACwpzJgax9ZUBGkKFLURT64N4SM+lWGp5129EvKG0uvyy7O70hyDVtZbKIFsNCU6tfadlomJNzhfHL9IaSPiV/V7J11yxQNVxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TCEF4rSmrnKPhw4/nM/5ER+ThIZL39yiZGyAwnWaNL8=;
 b=ip8NtEr8/6AdXtHJKfKGRjWXY+yOrQQRr+VHL8seIJKmCbW6OGwmN/r6ShLS5XoUfsGAC0dwCgA2/IFQ7cXnw2PZAeT2oMxNYFRNduKQShK+b0RTZx/q1p6VGrz3PvMVuPlZVTl4oVg456AwA5511wW2VIaLzAXyy5UstCisCEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SA3PR12MB7973.namprd12.prod.outlook.com (2603:10b6:806:305::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Thu, 10 Oct
 2024 13:03:16 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 13:03:16 +0000
Message-ID: <a0077320-9c92-44ec-9614-3de1fc1d36a6@amd.com>
Date: Thu, 10 Oct 2024 15:03:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] binman: Add option for pointing to external description
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <fbed0251437b61a2f7a85596d7403b5b9c8237c1.1728306322.git.michal.simek@amd.com>
 <CAFLszTiBHjqc-xeqsC51hFUed8bigv8+WsC9hUnv_tEC2RahcQ@mail.gmail.com>
 <d2a8f534-a983-4092-8fc2-ce45b54de476@amd.com>
 <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <CAFLszTjYOoNcMc7MTA-RdR_mKwM+8t=yKRpuYZSfqOvVBA1_PA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0099.eurprd09.prod.outlook.com
 (2603:10a6:803:78::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SA3PR12MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 25812c82-8573-425f-50eb-08dce92be79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckVWWGcvNEhYVHlSaC9Pb2RsM0p3WlVHZFdiUW9nK3YxTEtjckVEUHI4MDRx?=
 =?utf-8?B?dWJQM3dLVHFTaFZ0TTJ1N2pkcnNoT0tIdWUwaXhSeWR6QXRZS0ZQQzdvZ1Z3?=
 =?utf-8?B?U0FNOVZpT2E0aVFsUnhFcGc5bkxxWmZ1TS9OVUM0azlWTHlVNGM1bm1NSlFm?=
 =?utf-8?B?bmhGdlh0ang0cHFMRXhUNGZLWHYvYm8wWmtFT0MyL0d5VWE5Sm5BOHRQSGRF?=
 =?utf-8?B?Z1Q4TUlnWTVBQW4zUVczc2Fpb21BWGEyU0t0bWN3RmdudU1EZFVVdEMyRyt6?=
 =?utf-8?B?UjdNdU5EWE0xcWlWdzVlZFh4Wnc1VFZCVVBXVlZrQlR3YitmeXd3Q2RMZHBG?=
 =?utf-8?B?dHM1K3ptejhqU01GTzVBUFZRWXd1MmtmelB0LzdXa2NKOU9LbTVDUnk3OWdz?=
 =?utf-8?B?OUt5NzhSU0NLN2FkTWxBMmdidDZnVjM2ZGVLcHlkK1dOZnFEYXFGOHNFTW5J?=
 =?utf-8?B?STNiRDRjdHdnWmlMaWlxaktnMXhRTzhrVzhUZkZ6MnN0a2cxMlJEQUNwL2Mx?=
 =?utf-8?B?bC9oc0kwUzNZSk90ZWFUd2hJZUZ4MENINjgzQlVoLzNyaWVMZkQweEpXSzdy?=
 =?utf-8?B?VUdqQ3BQRjdWSHlMeFVEazZBMTdtVDZmVW5aa1YzTy85c0t1ZERMVlNjUlJN?=
 =?utf-8?B?d3ZLOU9oZUtmanF0SnlNa1RIMitIbDFQKzUyaTBac3pweXlxWkNBQXhjaGtB?=
 =?utf-8?B?NXhvcGpSY1YwaHIyQ2MvU21pY2ZuTVp4QVM0NW9qNm4vUndRaFVkeFUvYkRS?=
 =?utf-8?B?ZEt1T211Q1BSY3NISEhFZ0FrWmFubXFNOUEwWDdCT3dXN2tGdnU1ZmVhREdJ?=
 =?utf-8?B?Y3NCRUNrOURYNEY1T2swcUFKVG9DUVQ2ZjkvOTNJRm94K3BIelA4dFhyRHpl?=
 =?utf-8?B?MEMzczZhdEVuVXlEVU13emUyei94UkYycUxQbVZHbVlsd0d5R3hWcC9vbnpj?=
 =?utf-8?B?d0JnWkxGWGtoOGlNUmFvd0FXampiM1FNY092M0kzbndLYkphNkRFNkNMQTgx?=
 =?utf-8?B?UjFkYlpKQkt6VkdHS3h3MFJsbExJYXQ4ekNBRW1sUEM5SnI0dlRESjR4aytu?=
 =?utf-8?B?Zk9HWm5YbkhQQmRtMm45Zm05UUtpUWxzV2tDL3VQcG9QMlB3QjdremYyYzVH?=
 =?utf-8?B?OUlhei9SZUtaK2Q2Q3FCNjJsUnVJVTRhdGVIczN5aDhhSjJpWTh6dmdjMTdK?=
 =?utf-8?B?WlY3Zk5Qdkprd0FRbjIxVTFUb055VG9vYmpjMzhralNwbVpHR1RrM3kxQlZL?=
 =?utf-8?B?R1lrdnRjYjg4WTFEcTJBVEJHZnVXL3Q3NFlIWVo3akp4eVFlaWlOWXhMdU5S?=
 =?utf-8?B?OWdZU1FQT2wzdlg2alB5RlhNbFFtTUJRUjFKZHZCalJNWjZLWU83K1dYTS9N?=
 =?utf-8?B?WTNrV1crVFJFTzVTT1F1S2xySkwrZzJKQlpab0hWb1FPWGVwNWtpa2d6Q0o4?=
 =?utf-8?B?NFhETFlPTDY2TVNSdTFRRjdQZzhXLzIrb3MyQTdlbGY4V21sYmV3clRLQzU2?=
 =?utf-8?B?Vmtrb0tGUUhyK3djcmR1enNuYUJjYVZ2dG5CdWo2TjBUVFFmZnRvUDMvRDEw?=
 =?utf-8?B?S3ZHdUkxdUx6eXF1dzFFbWZEdDFUUnBpaDA0YnA2anFQMnZoWitTUElNZUYx?=
 =?utf-8?B?bnFzUlZNZVZzQy9aTG1HUmRDNk95MlltOERnaHpMbVd0UE5EbGhwNWF6aFc5?=
 =?utf-8?B?LzFoNDJzVzRWZlM2QkJLMkhnT1FOTnF3ZHExYTI1R09UdXE4MXllTFRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bzZqNGVOQ2RmOW5HR0JvS1Bwc1hrT0JuVFZiWmlvQnhYeG13dVFlcm84NDNF?=
 =?utf-8?B?cFYvVE11VFUxMlVZaEI5NS9pdzBvZklrUGxsdXdleWUrMzc4eFF6bGJSZU4z?=
 =?utf-8?B?dmNkeEJxWERzRTlSZ1VIOFBXV3hXSkxtdDlCek9XRHZyVlVpRjROdkhERXdq?=
 =?utf-8?B?cFpFQ0hiSFdwUXdFL3pvRHNmZzNnNTc4b1JoejJOcFdKd0E4TmNBNHhvelQz?=
 =?utf-8?B?TTVMVkQ2N3dOYzMzZVJtYlNQajN4eDB6cE5yNEhTK0Nzd0k1ckFHdGJaOHZw?=
 =?utf-8?B?QjJqSFBQVDNHeHliSWxYTnVrVC82dXlIL0JQZXJtc0YxbW5CVGFMVk44MDdk?=
 =?utf-8?B?eEpNcWZzR3gvRmpKYkhuUkIvdlFQNnI0NkNyTlUyV3pkMHlweDlFSTlSZmJk?=
 =?utf-8?B?MER1eHV3UGY3N1hSVEV5SE5MQW1ObU9vdWtnZ0gwWUtFVExJSCtvVTVnRHVp?=
 =?utf-8?B?dUZLTS9tYkZJaWwzbTVlZFF1QkhVYkU0RmxrVHp5SEE1eVU4dDkzUkE1b2ZN?=
 =?utf-8?B?d2NvdmdVMTdUQ3ozRDMzakhSaENsRmVaQ0lsaUF1dEVUeUhyRTdwcFVMVlh3?=
 =?utf-8?B?U0diQkRQMlJHWGgvUVpmKzZVemNXbWdZSjFZNnFkTjRWaExNc1U3QUlSZmxu?=
 =?utf-8?B?bGt4Rlhsc0VIQkQ3NnEzbFRlODRmVTVVK1A3QWQ2ZXhxdWxqRnhDU0krai84?=
 =?utf-8?B?d3VDVkpFT04wZUVvOU9yNjlYRUp0aVpUNEN4OHRsSXJMaUN6emw5MzkrWXBY?=
 =?utf-8?B?aExjQ3RKeEsyR2JuTzVKWmc5dEpnMHZFYW9vZnFOLzlRYXo4eGRkMm1kcnpP?=
 =?utf-8?B?endGVEFQZUh2RXI3eEkyZENGZzJrM20zdFZiY0pjYUNjMTJuQk5ZVDZGSWw2?=
 =?utf-8?B?elM4eWhiSm1WNlQxemhBNU1NcmFMVkZRSWd0cm55R0lBZW42WU5HaUVlUnZ0?=
 =?utf-8?B?WDk5Rmh0YVlWYUN1UCtyVlg5SjFUaDJZbmpYOU0ybmo2MkZqODFVcDE3Q3JI?=
 =?utf-8?B?cS8wMWh6U0hHUTNvODBwZEFYSGdrcU85WE1rZ3NFK0M2N0hETWlKL2FhcVYv?=
 =?utf-8?B?MlVNMFRXRHNQSjVrUTQ3aFNpNFppNmhiNVprZXJQZGNHemFTS3lSZVlUZ3Fm?=
 =?utf-8?B?dkNvTjlCdFRvVy9mandGWFp0ZnI4REMwVXY5NG1GVDI1TDFMYTl2WmhDZmZQ?=
 =?utf-8?B?cHVFMFNYZ0gzdk1CRTI5Z1JUSUllWHpCVkxzbGhsNFhUNkJMSC9yUnlJZVdl?=
 =?utf-8?B?L2VtM2RxYWd0SkVrUUdzckNMb0ozcTcrbWZnQ3dyblU2ZlpYVlhIb1Q4UFhM?=
 =?utf-8?B?WVJHM2tZWXhmd3ZpMDYrZmd3ZHBJYUhZc1ltWVRjaVlzNC9FdkMybWQ2UnN6?=
 =?utf-8?B?QmRVcW41U05henR5eGtVV3hUMWlDWVFPemhicEczN1VsSTNFR0JORWxzT3d5?=
 =?utf-8?B?Z0trck1YVW5RelBwZi9vTi8rMXpBOHp0d0VzZiswdkMydmNyUmNOakFEWlA3?=
 =?utf-8?B?eUNYRjFjZ21nMm9DbDc1OVhFV09mWlEyMnA4cW94S0JyUVdJTmlKRTJmOW9v?=
 =?utf-8?B?VjMrK0hQeUhmRGhHaHUvdVJLTTBsUFptNU1vQ2pyUWVVV3pQSE9hUjIvbXFu?=
 =?utf-8?B?Yjl3TTB4MmcrUGVCMkdUWWVTVTFBN1pjUWM1SG9BbDRuWG5VdW1abFNyVThz?=
 =?utf-8?B?YXpqbWN6QjhFV1o0Z241TWNWd0xDNTJaeXZ2TFFXSFNSZ1U1amMrVlNKNG5T?=
 =?utf-8?B?M0FYTVpyTDU0MTVpejdvSlM1TjJFMzRTM1FtVHd2NGM4NHBXazNTWHZDZXV5?=
 =?utf-8?B?MTExMTNpVWV3S3JUT2IxOEhGWlhtL1NRYnUwSTE5STM1S0RpejN2L004NnQv?=
 =?utf-8?B?QmlkQnZuVkRKMDBWMW1YRnQzeHBPdk5qMmJzTjFBZ0k0ZU92a3NrSWVMQnVw?=
 =?utf-8?B?eXBXZmM0R080dG84NXIxYXhZbHEyM3A2ZDVoQ2t4WUhQNGNobWhuVGsxZGs3?=
 =?utf-8?B?MjFpNjdsRkUyUUVwbXdCL0pUcitvaE9LcDhnYjJENFhXYXlsY0t6cDh3RE56?=
 =?utf-8?B?azVCdGJwNXphUFNzNGVNakU4cy9nc1VQT3ZPMUpjak5sbHFIa1oyU3V2VnpE?=
 =?utf-8?Q?x6jXUtQl/Z+zO8PkvTAoG2uLU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25812c82-8573-425f-50eb-08dce92be79c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 13:03:16.0878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swsowaXiBfAfW6x7jCZKOBYipDIazxnsarzH1fogQZLqNTURKGptK/f+6KOuZceM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7973
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



On 10/9/24 23:14, Simon Glass wrote:
> Hi Michal,
> 
> On Wed, 9 Oct 2024 at 07:21, Michal Simek <michal.simek@amd.com> wrote:
>>
>> Hi,
>>
>> On 10/9/24 03:55, Simon Glass wrote:
>>> Hi Michal,
>>>
>>> On Mon, 7 Oct 2024 at 07:05, Michal Simek <michal.simek@amd.com> wrote:
>>>>
>>>> Adding binman node with target images description can be unwanted feature
>>>> but as of today there is no way to disable it.
>>>> Also on size constrained systems it is not useful to add binman description
>>>> to DTB.
>>>> Introduce BINMAN_EXTERNAL_DTB Kconfig symbol which allows separate DTB for
>>>> target from DTB for binman itself.
>>>>
>>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>>> ---
>>>>
>>>>    Makefile    |  2 +-
>>>>    lib/Kconfig | 10 ++++++++++
>>>>    2 files changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>
>>> Doesn't this defeat one of the purposes of Binman, i.e. to document
>>> images? We do want the .dts to include the image description. What
>>> sort of problem is this causing?
>>
>> We have two boot flows.
>> The first one (default one) is using Xilinx FSBL for SOM initialization with fit
>> image (DTBS) + u-boot.elf + tfa.
>>
>> The second one is using U-Boot SPL instead of FSBL. This flow is used by
>> buildroot for example.
>>
>> In perfect world I should describe both of these flows. I sent description for
>> the second as RFC here.
>> https://lore.kernel.org/r/de1b8dbabd5ab7f20d7aac217ec4f5074d39f1da.1728462767.git.michal.simek@amd.com
> 
> OK I'll take a look.
> 
>>
>> but it is also reasonable to describe the first flow but I really don't want
>> both descriptions ends up in the target image.
> 
> Why not? Knowing what is in the firmware is one of the goals of Binman.

If this is single binary composition with clear layout then likely fine.
In our case where we target evaluation boards which can boot out of different 
boot devices it will be more confusing.
For these I want to generated all images also for testing purpose not only 
images which you will burn to qspi.

>>
>> The second part is if you look at RFC and how fit-dtb.blob is composed. It is
>> one DTB + DTBS which are composed from overlays.
>>
>> xilinx_zynqmp_kria_defconfig has
>> CONFIG_DEFAULT_DEVICE_TREE="zynqmp-smk-k26-revA"
>>
>> That's why binman node should go to this DTB but because other images are
>> composed with overlays binman node is spread to all DTBs inside FIT image.
>>
>> It means one binman description is in fit-dtb.blob 14 times which is far from
>> ideal.
> 
> Yes, but I think what you are saying is that U-Boot doesn't need the
> description, so you don't need it to appear in the dtbs in the FIT. Is
> that right?

Yes.
I know that there is a code around it but as of now I don't want to use any of 
this feature.

> If so, then I think we should add a way to remove it, in Binman,
> perhaps with a property in the top-level binman image.

Works for me but keep in your mind that for SOM this should be removed from all 
combinations and for me it is easier not to add that description there instead 
of adding it and removing it.

>>
>> Third part is that I can't see binman node in DT schema or bindings that's why I
>> expect this will be reported and I can't see any code which removes it before
>> handing off to OS which is required for System Ready IR.
>> And IIRC removing is also problematic for measured boot.
> 
> I did start this e.g. [1] but have not got back to it. Help would be
> appreciated if it is important to you. I am not sure about System
> Ready IR, but we shouldn't need to remove this.

I have seen this description but this target only boot images inside MTD.

SR IR requires DT to pass dt-schema. It means make no sense to add binman node 
to DT if this is going to be reported.

> Also, please add an fdtmap somewhere so the image can be listed.

Thanks for reminder. I remember this option and will explore to see what it does.

Thanks,
Michal


