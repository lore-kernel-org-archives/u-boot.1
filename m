Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 182E8E98DFF
	for <u-boot@archiver.kernel.org>; Mon, 23 Feb 2026 09:20:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4249483C6E;
	Mon, 23 Feb 2026 10:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jw8dCXbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C519B83D0F; Mon, 23 Feb 2026 10:20:18 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FAEE83935
 for <u-boot@lists.denx.de>; Mon, 23 Feb 2026 10:20:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vyqOPFbINdv+edVlCzGzVj5o1/O4qOzO/TH9C8k2SvDlIA/nLsOEeBykFfyBtEgiZblip+9ym/IVQ85JdTsPvYD9rAa9DHabw9y63dS3rTtqXtYuyyVkuiImmQZUX02fc7BxNnvuy1BXjxd1LT0YXpfDTrP5PfbNA2Y8RZZmwdwSXyqDROmHuW4XUJ7bOlro4g8vJH2YmswHMT9YT/bUPzwH/NiQixgF/pq6HxmCqsMOeMGMObgRTqYf5FdSsfOA4RSG0VxQGi5zLRXyUoALoDMvuP2O6TSYcyCPtJfA888SsfOSoQtT9LQs9nS4FOm96VJmlFxCdcbxQhtcVitWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1lZDUNe8D/lyunEzjGU66EOFiLPkQy/HtXyQL/irBE=;
 b=prTKWf3PYwM1bohnZKCFSuU4OWNdebu8ofN4q2o6Xz62n4Mifkh5XaoUwNUyaYOuw9XQV5Np4L7fBQZGW9yjrg4/vikpp4lWN553GhyKnC9I1mkp0g6H7pO4uByLPLsxk7vzm7op3XkwSOqArw3esX3F46lwoPrq7lrJvnSe5pawpfX9PZK1Lbquitubg5gDIWzX8UFyHl8rwP6fgXtEEgXFdZPicPaVyn9YWstpEIJd3zPbZdq/P1vP43OiTykqtF3gw2yQQWCbILQwpx7LJZGuxgn3dwCTSPB2WbN079KjACSDoZLGe800dpzHfLZKnoYTWnU3IPMHFdby9cm4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1lZDUNe8D/lyunEzjGU66EOFiLPkQy/HtXyQL/irBE=;
 b=Jw8dCXbxUPP3dxx4GeotGK9wAlnA0G2gYMl820JSSwnkrGQaKlRhFe/pDIGfYWrR+v4H2d8Nvi7oeb1UkgnYR4KvDTNU9RIWKEMt3p488J88hf1zoKMxM68dMVFLuqxHMBBPIcMHatW5+J4+oKmUFs3MdqmdG71hSW9eRqS8AOo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 09:20:08 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 09:20:08 +0000
Message-ID: <7d3cbf74-ff91-4a6e-8725-e77c6341154a@amd.com>
Date: Mon, 23 Feb 2026 10:19:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
To: "Begari, Padmarao" <Padmarao.Begari@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "tudor.ambarus@linaro.org" <tudor.ambarus@linaro.org>,
 "j-humphreys@ti.com" <j-humphreys@ti.com>, "marex@denx.de" <marex@denx.de>
Cc: "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
 "vigneshr@ti.com" <vigneshr@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>,
 "caleb.connolly@linaro.org" <caleb.connolly@linaro.org>,
 "sjg@chromium.org" <sjg@chromium.org>,
 "william.zhang@broadcom.com" <william.zhang@broadcom.com>,
 "stefan_b@posteo.net" <stefan_b@posteo.net>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "Takahiro.Kuwano@infineon.com" <Takahiro.Kuwano@infineon.com>,
 "p-mantena@ti.com" <p-mantena@ti.com>, "git (AMD-Xilinx)" <git@amd.com>
References: <20250430050923.135256-1-venkatesh.abbarapu@amd.com>
 <PH7PR12MB74282B424C0D91F616819527EC6AA@PH7PR12MB7428.namprd12.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <PH7PR12MB74282B424C0D91F616819527EC6AA@PH7PR12MB7428.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0150.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::34) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c47c521-95d4-466a-3689-08de72bcbd17
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QS9qNTBHdnBKV011Wm5Ra3dvK1RVOXphMU93ZkJuQjlROWh4Vlg2WTFrbWhT?=
 =?utf-8?B?UHZCTTYrY0QrRm1qS3QxelRDZTVpRTRWb0F2bWhTeXkxVkRxRnc4SlRFdGlp?=
 =?utf-8?B?d3NPU0Q5MUtIUTYxaEFueXYrSWZGTklPVzkxOWNKQUFSZ1RrWUFNaXRHaE9G?=
 =?utf-8?B?TVRMWXdETkJ2T2tqc3lUNUs2dFRoR3ZPVmtsVk9COGxlajgvS3g1ZVF2MGFL?=
 =?utf-8?B?WDZQQzF5WjFITklRVDFKTUFLdCsyNmtlUmw1VWZGZGh4S0V5V1M1enBxLzFt?=
 =?utf-8?B?STEvZDFNZSsxR0h1bHVzQ09tK3dEOTNmVmZmcVIwZlFrbzZnQWI4WVNKN0JQ?=
 =?utf-8?B?Y3AwVkVETVdIWE8xNDY5NUN4Mi8zYTU3Uk5XeURYM1FTRFNQNWJhcHhaMldS?=
 =?utf-8?B?QWhMdFhDaldPMEora2pmVi9laGlmeXpDZjNaQjRqQ1V0YzlSanRiY0lOcEhH?=
 =?utf-8?B?SWVBalg2YmFUNThhL0gwdStGbG5FcGFSbE1vYTlUcU1abCtxWUFheFJXdWN4?=
 =?utf-8?B?aHNERkFEamNGemh1QmoraXJnbG1TNnA0aklqNG5WUC9mRDAvQVV1Y09QQ20y?=
 =?utf-8?B?bS91OXJKdmpEc2ZodEVHRHd1QWVia0JPcWVTUGxkOUhlOXVoZUNwV3BEcjZm?=
 =?utf-8?B?Ym9iN0xnZ3RHbHpJV0k4Z0orWm5PMGwvc1VWUnpjMVo1Z3BzR3ZQeUJYT2x6?=
 =?utf-8?B?MGxUbnZONEZFaHROYm1mWjNVSXoxZVpIWUtzYWplZkdBRUZNemhScVhpcnFX?=
 =?utf-8?B?SzFqTTczMXd2aFIvUE5rQW93VytxcG1USWlWUENNc295ODlJVVhZRkRKb3Nz?=
 =?utf-8?B?ejFnelpLOEdFYVpFUlZYQmZuekZpVlllK0trYUtZb1M3VDMxU1ptdlllaHEv?=
 =?utf-8?B?VjcrdVRDZnR3aHZGUzBScXJxeFNsOHRCQS96b09GdG0rYUVjcVZnS3ZhOThT?=
 =?utf-8?B?elVWM1hjTmJMTHJHUk5RVlV4WWx1MCtMRE1GeEpSSDczTnFwSXdJaXJ6eVVE?=
 =?utf-8?B?R2FMWDZIbTMxL3RNdnkyNFZmbjNETEZnN3o5b0VSVU51MU1ZcGVDYmZHWi9O?=
 =?utf-8?B?RUtXSmZyZjlubWRSenQ1QS9hS3lKOUo3WG84bG03K0x1bVkrdEpPS2tqK1Bi?=
 =?utf-8?B?d3ZYaDlvSjM1THA1YTBrUmNUOVh0SEVjR3RybzFndkEvSTJSZEpiTW4zVlA5?=
 =?utf-8?B?NTRYeldaT2V2L1h3dDliamdYZmRiMTl5cmFqS1FwOG1kWjIzYmVsNTRkcWN2?=
 =?utf-8?B?QzhaamNqYmxaUzZ6M3RlSnMrL1NuT3M3OTA2bm9HeDFKU08wajBtSXplMTQ1?=
 =?utf-8?B?dmtsWWdYZ3pmR0w1SDcrVHdXSUoxUkZEaWNoaVR4LzVkaGVOb05mWHNkVDFn?=
 =?utf-8?B?a1R2V2NDdzFFanY4R0U1aDQzbVZ4NEwwYm8vTzVnbjFKMDlrbC9ydEdQUEFp?=
 =?utf-8?B?OUlMZjVvNmMwTjBwOVA1M2JIQUtIZC9kQTZRMFlWV25VNDlkMGFMQWNaTDhk?=
 =?utf-8?B?V1ZvTUI4L2xtNzNFMTJ0RENhRXdPeEMrZFdmYU5tc1dkR3IzZkp5MUs5b2d2?=
 =?utf-8?B?azcyVjZNS0lRN2x1azBKRG5tbVg0QTNGWU5leGc4VXdrTnh1dmhUSHdRTGpr?=
 =?utf-8?B?Vkt0T1JqOENlblRBb0JieGNUQUlsL0ZiMzZDNDF4MTdrNmZ0ZVZia3dYUHNu?=
 =?utf-8?B?bnVjbU1PUnFSa25mSWQ0eTVGZHVvWWRzc09jUkJ3OHZ4UVRQeFBPUGlrazQ3?=
 =?utf-8?B?dzZlbHR0RHBlZ08vTzhoajBhTEkzc1Z0Zkl1SWFXWHRsMmNnS3huZ0ZVbHFk?=
 =?utf-8?B?QkcvOWxhaGcvY3U1cElsNGxVekdlSGJXeDFKcENua2JPMmxaOHN6Y05zdmJl?=
 =?utf-8?B?UGlwOTlWcFVoMjlFUDNxSlI2ckxLUlVrUlU3dDJqaVpTWjMzOERZdnREUndY?=
 =?utf-8?B?MzNaUTJqbnZLU3dEVlY1QWpHckUxNmk3Z1ErZ2FQSVllTHhpV2hGa2dIM0Ro?=
 =?utf-8?B?S2IwMFVVeCtQYXpkMk8xUms5SnhUTUtka2ZXTys2R0lQVjl3TVFqVG44QXlk?=
 =?utf-8?B?ZUpEWGwxRU9aN09hYmY5d05JalNCSXF6OGhZMlNFWXFacUZzdFRPQzdnbXVB?=
 =?utf-8?Q?5l8k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGs2WlZCMVowdTV0SSs1V1RsOVlzNE9qbDZtNWNqTlF6azNrWVFxVjhHUGdG?=
 =?utf-8?B?bndqVWhtZ29rL0o2WEdBKzZNMVR5ZWpWcFBGVWNNVkl2Y1hQQU83NmMyVG1E?=
 =?utf-8?B?UGh2UFROM3BZTCtURjZPeUlSeGNLeVhmdDhRM2xleWJyZW9kOXNtdXB5aEZX?=
 =?utf-8?B?MFFGZkkxZ1JQSDdTejNnSW1YL3puSjFYSlB2K2t2VXN3cThYMHJISmNwZWNp?=
 =?utf-8?B?V0ZOOTdQcjY0OWNQOW9GWXlvbU1Pb3FkM3NBdWdsUGJzQjJ5ekZTaS9iS0Rw?=
 =?utf-8?B?c3R6WDFkYkN1b29ZZG5aNWt5UENwdnBkRU1tSDdYZW94aXlaSWE2dHZIczFY?=
 =?utf-8?B?K2lxWUtKOUltNm1NVWtjclRYV3ZFdm4xeGpmeXZnMjhXZWRIN0kzd3FYL1A4?=
 =?utf-8?B?a2diM2F6anBXM1ZKanNzNGE0MHhpYU9IclAwdjFxb3o2UldVdlQ0N0krTzFy?=
 =?utf-8?B?em4xenZmbVJYajR2NDdyb0k0ZXU0SXQrVElRN1NHdnVrVStCemMwMCtCbmQ2?=
 =?utf-8?B?cFgvTlArNzAzT3NYTzFYZTJyR3hCSFljVVZOa3FsUlFyVExBK2RyWXNHUkpK?=
 =?utf-8?B?ODJzUkxpbTZLL0poZ2l5ZW8vMEkxS0VnQy9KNmlEdURpTUgzeitFQ1ZXMmFE?=
 =?utf-8?B?ejlNOTg0YUE1QUo3SmJCUTNyM0FqOThyRndsTmUyckxCME5JMkRQMGI1bUoz?=
 =?utf-8?B?eWhHdHRoVXFhR01mVWkwOUIrejVQVWc1WjRPcFJOSmNCKzJUdTUyQ0JneVRI?=
 =?utf-8?B?c3R2Qk1uSnJsQVdrVk82ZWRhS215eHdZOG9zdjRBaHRlRkppUnM4QjB3ZzNy?=
 =?utf-8?B?RWJ5L3NqQkVNV3p5NVQrOWpEdlhDdUREa2hZbU5HNnNpWjRZUVJMNXVmRlEw?=
 =?utf-8?B?QUVQckdOZ0FQU1V1aWhLNWpBRkVEbnNnNmlnOWRHMzg4ekczYzZoSTgwVWhB?=
 =?utf-8?B?K2w2UGFZV1AxZFUxTmEzZVNWemZJRE9XdjdoUzZXRE1yZUJDUi9oRC85WlBC?=
 =?utf-8?B?aVlQWHJQb3hYQjZSVmYya2QwQ3R6eURjWnJOcU1MZUlGRkRwOG9XY1pUcVBs?=
 =?utf-8?B?M1pocEVXa2pCQ1VJbjdzWnlIaGRWOFZmYk51eU9CcURvL0xBVjlNRWdhTUU2?=
 =?utf-8?B?L3RlenRuN3NiSkFYNGxnUGo3UURMT2RSTEFtQnJzb2ptaHgrUFJTSFFyL1lF?=
 =?utf-8?B?OGlQc3NEZDU3ZEhNTlpEWlBrcVorMjBFM1VuZjI2Z3dQUjFYbENUQ1Bkck5V?=
 =?utf-8?B?ZHZiNEpqZm9MU3VXQ3lIeVBvWEtSYVRkT1NNdlh1djhGK25GeVROa2txSGpn?=
 =?utf-8?B?MWRsM2kycDZ2Ui9JR3F1Z3NjVnBQaVo0RHlLc24razI0ZVVqamhVMWtkL0xm?=
 =?utf-8?B?L2NZMklhOUI4a3NoaWpkeTFJaTR0NU9MbXhhenhxUE5JUTdrOFhSVS9hWC80?=
 =?utf-8?B?cFd2bVJlcUVEQlhQRmRsWnVpVGhDUHBxOC94cXFHMktmUlNYQU53NWRCQW52?=
 =?utf-8?B?YUF2eDV2WXRmMkdUZlY1ampiY09CSHU5eWN3SUJpVFlFcm8rUE1DZVBUQmRq?=
 =?utf-8?B?TCs2M2J6T29ia3dFOFYvU1RaNDRBblpkYk9FY2NpZGZCNktheFFQaEdzRDI5?=
 =?utf-8?B?UjJOWEFNUlRKOGtJTFFkQ2l0RlFQS0ZlZ2tadXdNSDRoRFJoMCtkTXhtZytu?=
 =?utf-8?B?MUFIeEZSdnkveTZHd0F0a2d3RmxTNGlGMktPeVoyVEJha0puWFdTWXd4eFdv?=
 =?utf-8?B?N2pvNXJoTGw1YmZJcmpDc1cxWHc4UUtFbXVEcmxLWkEvejBmVko2OGhQdjFX?=
 =?utf-8?B?Mk14dXhPU2h6dWZZZzlPZlNYYnVsU3NQMHlDZjVyeERPL3JiYU1memd5NS9t?=
 =?utf-8?B?cWhqUGlsRG1yZ243VmFYNnNYTnJTS0JKVWw0T2lPQkkwUzh6TlNWN1pOSm95?=
 =?utf-8?B?ZzhaajlCUmwzQkYxZHE4NVZneHN4eXNPaEcwK09WeURrbDYyMmxUUHJlcEIw?=
 =?utf-8?B?SyszL2QxNG1jTkdRZlM4cmRuZ1BNS1lVMXE3WGJLWXF0WTRJQ21xYWgxa3dJ?=
 =?utf-8?B?K0JwYjF3akRjYVZaNTljOEVGMXBVOFNoVGd4bWNyZU43VFoyVDR6d0I0M0Zk?=
 =?utf-8?B?d1k4ZG9uUmJmRVRJTEx6MG9QdEFoMXFWdUVXOFpvSzNOUDJiSEFqUnFDSHNG?=
 =?utf-8?B?V2Q4ZGtBdERTRUhXRTJ1STgwRUNQbllFbWxnZWdabFJVeXVoQkVvSk5YTWhk?=
 =?utf-8?B?eEo4SVBkV0pNREpFMHVlTHJyQlNQNUxlbDdmTGVpUEtuQmllYmorNjVabENz?=
 =?utf-8?B?RVNmbzczNzJNYmNvNkNUQTlFRU9nUE1EUVBic3R3YjVkUkJ2THNFZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c47c521-95d4-466a-3689-08de72bcbd17
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 09:20:08.7668 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDyMqgQZJXbcNuREmlWo9JGgkreIINLOflvqNgpr+wBHz8wX7o1T4BeZVsIXt5/t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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



On 2/18/26 11:03, Begari, Padmarao wrote:
> [Public]
> 
>> From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> Sent: Wednesday, April 30, 2025 10:39 AM
>> To: u-boot@lists.denx.de; tudor.ambarus@linaro.org; j-humphreys@ti.com;
>> marex@denx.de
>> Cc: Simek, Michal <michal.simek@amd.com>; jagan@amarulasolutions.com;
>> vigneshr@ti.com; u-kumar1@ti.com; trini@konsulko.com; seanga2@gmail.com;
>> caleb.connolly@linaro.org; sjg@chromium.org; william.zhang@broadcom.com;
>> stefan_b@posteo.net; quentin.schulz@cherry.de; Takahiro.Kuwano@infineon.com;
>> p-mantena@ti.com; git (AMD-Xilinx) <git@amd.com>
>> Subject: [PATCH] spi: cadence_qspi: Disable the DAC mode in indirect read
>>
>> Hang has been observed on QEMU, as it starts with indac read and fills sram, but
>> after dma is triggered, it tries dac read instead (based on priority) which gets blocked.
>> Disable the DAC mode in indirect DMA read and enable back for writes as DAC
>> mode is used.
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> 
> Tested-by: Padmarao Begari <padmarao.begari@amd.com>

Applied.
M
