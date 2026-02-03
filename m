Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFF4E83078
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 10:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54D9E8405A;
	Tue,  3 Feb 2026 11:10:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CxecUYU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9793E8407E; Tue,  3 Feb 2026 11:10:31 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5440583DF3
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 11:10:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBD/uoUYhJagQZK+fz65Y0zwq/n6T1TReKUDmo7CnkkLwyO91WyZUTiTMqmjUjkj6w5SzMvmyR9W9R7PvwuYO3eKxK/87MOziaVug+bjLd4L49M1MMvViyc4V9aiujjXx+S32XMfdIxTWglfkqaQuxLrAOjaCaG8BqXXwSkHnLvjJX5HZCIoYglkHufMVApBaW+dlmjHYF3ajDkgwj28oyEHyVxEjWTmZe2+xjSAkjsSW3hFLzrJWGCJzxVhHTvipV98xnNrR7EOrpju8Dm95jcTUN4H8uSOmqn0rMtFBQTOjYGMz8NBSXiXR0+S4gppsHksmUwBalSnPkE+W4R7oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i6iztYEOu2yr6CG6Dk41Q5urvjOxrLpgax3MSpiEzQA=;
 b=wyN8C160KkrI/i26aXczSZM4S9FQEIc6Gu9sboKDGE+9/up6M++Y/MfGp2IcfF+0tORAAO05KDWvU2jKhdQOTnEA5EAxpmY4RQJKWNJhNh/ydcjFerQIltGkH+U6MnpABq8xW5PcwYUtBGxNsXdqx6DU4BGtq8DPmb+xC8wU47C+8mw/vsQsa890xb8nGqBI4lI6CQGZLiz8K5ullhhkN5j0N+/js9q0zLK4QYBmz4YJUwMWlUH7mmkWwG0Rf26/o+MEs80KjwVldhAspEDWmm3mMDiPkVtXkj384XbX/Z6k91smr4qPUniCU/ajuuzPy1/9GNJK2545TpiPePjq3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i6iztYEOu2yr6CG6Dk41Q5urvjOxrLpgax3MSpiEzQA=;
 b=CxecUYU1KXnNV4K8uZgcO/1cc+SbqB6KkqvjCM8o3rrnppJOfAL4mBRFEaGnZvY73Z3/NVQL+UEYVHvs5BOfTBgmzhG70/Q4BwiZ8A5kqMfJMnrlip638DQTbaT9jzzmnxm0x3fKNTKbLCumZIdqVbOiPHmUTibfbQEzV3PZSf0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 10:10:24 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 10:10:24 +0000
Message-ID: <92c5c4f6-05fd-4c65-be43-b5125030cacb@amd.com>
Date: Tue, 3 Feb 2026 11:10:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] efi_var: Unify read/write access helper function
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Shantur Rathore <i@shantur.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1770105470.git.michal.simek@amd.com>
 <620c169fb271be3ca6de3e8aea498fba7aa36d99.1770105470.git.michal.simek@amd.com>
 <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB11941E99EBCEFBB6D8F523E6F839BA@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0053.eurprd02.prod.outlook.com
 (2603:10a6:802:14::24) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d00c977-6c9c-4152-5f08-08de630c71f1
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEVuK3NZNE1tSGlSbnFPT3J4blRtVDVWbW9aT05DSmlXY0xqQVl4UXBacWto?=
 =?utf-8?B?WkgvRGFPZmFlbWZ6OHNDRFNTRFhnWFRVbmZKbXhOcEp0RFlPR2dQK1JlQk01?=
 =?utf-8?B?Y2hwZUZMS3FIMUJ0dFBlSlRvT1doNklzODdERnllejduWmV2Qk5jdmpPS3pk?=
 =?utf-8?B?V3NuOUlxNUFNTXZOdlVyQThsT2M5TnZlcEJWVml5YlQwaDRrTXhTZFRUYWEx?=
 =?utf-8?B?WSswQW1TVStaMWV0MmU3SFdZeFFOZEhHczVSYzN5NlBEVlJPVy80VUNUMmN6?=
 =?utf-8?B?bitFaGJibWZYYy82OVpCdi9VMEVmK29wa2hyUU5iTzJXa2R5U2wyaklPdVJK?=
 =?utf-8?B?bzc2YytaRzZPV3YwVlRiQXFCdlU0OXViQ0VrSHRsSVFDWXZhVlVObitNdTV6?=
 =?utf-8?B?aFVHWWZlSnZtS3dVZ0NRQ1REMXdJOTlqVmRJVHVLLzIyem5QbWJGUXhnUHhz?=
 =?utf-8?B?VVZCdHhsV3NmaWRuRTljRXBpNkEraDcyak80MXhMd3lDK1U5Y2xhRGljVnli?=
 =?utf-8?B?dXk4UmxxQWR0Z2owOVN0c3BtNWYxeXlmdTU2aEJ0M2ZvemF1NmJDbHZuRm5L?=
 =?utf-8?B?Snl3aWd1bTlaUzM3QURha2o5azRlbnBvblNVSTIza1hIQnN2MUtEdm1TV0d0?=
 =?utf-8?B?ZkdvVFFUeVk5MkRjYXk3MCszNktEUWZ1SXA1d3hhRFhhNHYxa3I2VU0vaEVn?=
 =?utf-8?B?OHczaGd6ekxla2dPekJpcmNKNmhqcFl4eUdPbHJnMmdhUW9RaG5VSzBYVlFX?=
 =?utf-8?B?dUFibmIrSUg1b1FEOWY3VHNYbUVrNU1sWTBhMG96UW1GOGEwaGMzcnFoZXV5?=
 =?utf-8?B?cGVDaUNLaWRFTkg1L29KRzFRVTM1bnRXNW9ONVhMajdwN0tJM1RNN21RUWVI?=
 =?utf-8?B?MVJLWVVsN21xZVZIY1ZmVFRyMUgzT0F3VnVSV2NNZkROelhxOG95a0xBZE43?=
 =?utf-8?B?WTV0RVFHME50aUdBb0JXWHkwdGJ3c3BEUVp2bzdlQXlmOG9RTzNCekg2YkJx?=
 =?utf-8?B?UGdjZzZORnMxYi9la28wcGlUcXYxVUx4ZlcyQWhwNzdmc1pLU3EvaCs5TmVV?=
 =?utf-8?B?cXVpbWUzSm1PeEN3NlBaWGUwVGVheXJUKzY5YXQ1QnNxRVFrejYvQktSeVNW?=
 =?utf-8?B?MWlvelUySzdZaFpHZ1QyWnFQcW1yUDJIZHl3NzNpc29nZkR4YWZFbUlyVnpt?=
 =?utf-8?B?KytTbjdvc3ZZQ291RzBYSU9VN2hORUtvN3h0SXZ4LzZoaEN6b0FNUys2WUJ3?=
 =?utf-8?B?R0ZxeUJDM3FVT2FCZmExZVRsWDFZLzIrc2h0NitmREUzWFFOWENycFNRZmhB?=
 =?utf-8?B?Zi9hLzNqZ0xrK1hIR0FPeEw1Z3dSTStPRkZpN1NDNFlBaE41OVlDakxvWHR3?=
 =?utf-8?B?eFdmaVdnSEtRRjFnUEVIZk9EU3U2a0dSS2E5VWJCRWRUQlJCMVN3ekcxbitk?=
 =?utf-8?B?R0RjTHNYWjlBa1V5VG1tSnZBbkdMUFd0UWEzbTZGL0dHWGVmY2ZMVnpxV3gy?=
 =?utf-8?B?Um1jYXNJZXVZcmQvQWs1MHJzcFE5cXJtVkt3dEhSVXN3TTVtZkZCQnBQWlFK?=
 =?utf-8?B?LytuUzJ6dUxsQWU4RVRuSTBacFpBeEZ5RjBDRStKMGUyWHdkdTBvU1hiZ3lO?=
 =?utf-8?B?S1AyNkl4RjdhUVNxNElwbGVBSGFsSElZc3FKbFErNlo4Znd0MXlhMytaVjQz?=
 =?utf-8?B?RmVEZWZJcThqL2ZPU2xTZFdSMVpKMUtvWlpnZ0taNTF4SHcyUkZXZXNRbm9o?=
 =?utf-8?B?L1R3bDlzTHpwWmt4U2hiZS9pb21KVFR0bmNIWERKVFRlNEgxZXF0VnlhZVEz?=
 =?utf-8?B?aFMvVC9aY0puYjZ4TlpjYTZCZXNvcmtiRUZsdWc5Mlpud3NVYUt2N0piMWNN?=
 =?utf-8?B?VkNMMC9JRDRRN2NjL1ZWUUdYL3h3NGRtNGtFbWFId1E0alpXb2tyU2M4ckE4?=
 =?utf-8?B?QXRaY1dsUytTZ21NSXNxT1pxaWoybVFuUGxyeUVVelErVnAvTDhrWExZSHBG?=
 =?utf-8?B?MWtHSTVlSzl1VSs1UWJlRmRnOXdhSTcwZmRVcHJyUnBUOTdibG9naE01VXVw?=
 =?utf-8?B?Wi9PU2ttZ0piWUkxQ1UwUU5ZU2ovU0JVZVhsajRMR28wZWVnRnhSanR3Nktj?=
 =?utf-8?Q?Hzyc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L09SV2dlT3hENE1oT0Q4TUd3YWRvQTdNS2pidCtPOTBac3FPZ1ZnU1Z6RGdR?=
 =?utf-8?B?aW52WXFCbWpIZUhuMEZlVXBlRGo1dHRiVDVQSVhCSmlFSUFjdEk2UldRNXM5?=
 =?utf-8?B?azloMFdjU3hqVnQwa0VuczBCbGlHd3RFZ0NoaGNYVTFaYzNmNEMxb3RUUU1G?=
 =?utf-8?B?S29ZSVJkYXBvM1k2TUxocjY4V1dScTQwazlVd3k4UWtnYTNPVy9UMHZJQjBm?=
 =?utf-8?B?Y3ZMWjkrZVhGZXhaSHhFSFdUeE84NWk2cVNxM1NiSm1ISzRzbUM0bGY1ZFBw?=
 =?utf-8?B?bnhmZDRad3p3bVZVdFF2L25yRCs1Q1pFS05XTWJuZXVWcTdFNmNyL2h3aXds?=
 =?utf-8?B?NWdNdnJ2V1Jzc2s5MzVTRnZjUk5lcy85ak54a1hPdGVvTTZmUkpsOGFTWnhZ?=
 =?utf-8?B?QlBxWHZrb2dmNUYvS0Z6WlVIeWYycmpHU1AwNEtUcXIyZlVUMXJrVGZ4RHQ4?=
 =?utf-8?B?RlZKYzh1bS92Y01SR2RNT2lJdVFudG5rcVNnV1ltV21SZWNXTEdEUUlJd0Uz?=
 =?utf-8?B?Vm05TkZDZjA4eElKL1FvTGo5SGdoVXVmOXdpelN0SjUrd0hmU21GZmxWdk93?=
 =?utf-8?B?NzBBTWYvU1E0Smtoc1Uzdi9vN2NnRkxJbk5mS1B1bVhGcm1Xem1BS1R0azVj?=
 =?utf-8?B?SDJxNDFXUi9hMWlna1F1TjhhZDlvYXlkTEx4RkRESUpBcmxOaDVmUUJBSWZB?=
 =?utf-8?B?MmNQa3pwRWxHaDd6OW5CKzY0aHd1ZFlTajYwT2dweWppQmlodElNdzZNSlVO?=
 =?utf-8?B?VFUwMW1xcGRiVlBaMENEbVl4U3p0Uk5oL2UxOTdEbVYyQkcxOXdERTJ2enFH?=
 =?utf-8?B?ZVJOYVM4cEc5dkRxUjJPVnRGcmcvK3o2QUxuUmF0ZVNXVzVxakVZbW9TWE5u?=
 =?utf-8?B?YndPbEtSVEJDUmYzZFlUSSsvT09jcHRxblpFbUg2OUVKZlBnVHZVMXdBd05l?=
 =?utf-8?B?LzZkL09JMWllRHNGZTBrVmRXVHQ5VW5DeUJBN2hGL0tCVUIxQTVhT1RrRk4w?=
 =?utf-8?B?dnhLZm1Cb1FjOXN0YmUrZjVsYmdhYWJqUDF2NTNBc2FzNkxlcnpUcjVQUHRm?=
 =?utf-8?B?VFNmQzFDVmQ4dU1QemRWd1pNSzhCRkIwaW9YcnhQKzBPOGt4OW5NeHNDdmcw?=
 =?utf-8?B?cnVWenFZZlNDRkR6WHpRUVJBdEtxRDRvcGk0UnFXK1BLUGIvajAxS0VIRGQ3?=
 =?utf-8?B?NmZxTW5BTkZ2cW9NWEZ5WkNWU3J5SHdia1pwVXpVOG1zaDJpWTZYMTRpK2Jp?=
 =?utf-8?B?YmdMNHM1d3lKcWZ2eFl5MTFmRUNNbitXcWtXdDRBV0dpY0cvL2xYUkNSenNJ?=
 =?utf-8?B?Ym9PWVhKUnR3ZE1QTjNqbURVcmcrZ1BrVG9lNG5HVHhiSitoTGlBQXBnTEYw?=
 =?utf-8?B?SGJVRGtGenNkU3lrR1FQWHIrSGdNdGhpQUt1Y3hIcTV0NFRGNFZsRHFCQ2Rm?=
 =?utf-8?B?SjZFQlVINnE0RUdUL1Y3cncrWVRmSC9VejBTVzZNdmcwWjVuUXVIZFkxOVJ2?=
 =?utf-8?B?elk2OERXbmYwRERFdnhOWnhzRThoOFRuVFZPekVqZ1RDSXpQRzVWa3paZDM5?=
 =?utf-8?B?VnFKVjJEWTZBMjl6NHMxSU5oY093aCtybmc0L3o4RTVCWE1UUGlwK0xhVlJL?=
 =?utf-8?B?STR2WXdGRXE3aXprdWNaM2lEVy9HUUIyRzk5ZDF4WWdrdUh3bkJCQWdxMWtM?=
 =?utf-8?B?UUdNdjNPbHdtYk5JK1ZveFdKekljTzRBRTJYdWt5NjFFUXpab3NFVW9DamFH?=
 =?utf-8?B?VWxtMzAvNmVHdlQ0RUpoRlpYbWgwM0Q1SkJOb1hRenJPRnUybnRPYXpBSWJ4?=
 =?utf-8?B?Znl6bGpnYmxmN2lWcGU2KysrZ0p6Y3pYY0FVNzVPTE1aczlJcHNwcm4wRkp2?=
 =?utf-8?B?UVErdnVaZWlDSjBsdVdmZ1VVdW1GSWE3VTBTRk9sblF6TmlNc3pOaUdjUkc5?=
 =?utf-8?B?cCs0Sm9qU1FEWkZWYkltL1B6S05VV2RxaTA5ajQraFVIbWZ4aUlMOWJCVzl5?=
 =?utf-8?B?U2VEUGhsMVhYK2ZkTnA3TWo1VFB1WmpkYTc5TUpvdDYrazR1dGdRNzlaSVpS?=
 =?utf-8?B?YTdYK1J3N3ZlMlJGbElkMWZnVi9xRzc0cVpHSmdMUlN1UkFZWURZblEzZ1Jl?=
 =?utf-8?B?R1FwZXlLQlJ5elJTd1Y3VEFHbFM5T0hic0JlWXJvWnBoYm1EOWNZanR6aEh2?=
 =?utf-8?B?NUJBdXA2VmxGSi9BNW9EK0tlNnRKUXFCckVjc0lTSjludGFuZXd0d0QxUEJG?=
 =?utf-8?B?cUZEeUhYaWxFeWE1Ui9XbWRFSU5MRU1saWc2UVBtRmRqTTZGSWhuc2E5aTV5?=
 =?utf-8?Q?athbaqvdEaZJhFlmPa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d00c977-6c9c-4152-5f08-08de630c71f1
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 10:10:24.0272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Ow3SK94AIncJtJ6gQuFBHVDnhaNJBRjKqgCk8EnkW9EPladP0ymxggtwCak8vca
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

Hi,

On 2/3/26 10:44, Maarten Brock wrote:
> Hello Michal,
> 
> Why are the new function names non-symmetrical?
> efi_var_to_storage <-> efi_var_from ...

Ilias was asking about these names in v5 review.

Thanks,
Michal
