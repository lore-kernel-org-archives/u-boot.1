Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34722FF885A
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 07:38:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B214E84255;
	Tue, 28 Apr 2026 09:38:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="FJ9Lm5Pu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38FAB84106; Tue, 28 Apr 2026 07:21:00 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2282883A91
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:20:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=chen.huei.lok@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbhymLfPFQDzVivIO6aCpqstkvluW5f7okv4AnaF1ybw4g6Ge+818mPsNr4uw/GxLlhZgqWisvoa1c8H/HGyNPaTL2zqCBWxR9/y5JK8UowpZxIqoFdQmPbggDVmvmNqJYK1Uz+LT0I3YcQQ2DRbm05jkKhduskU8x8aemh5/QX4Gs1f5bDRYSWhfpVUN3cE1ONLrDJriZNHFZ94JIIIMjbNRCza4+uJTaMcpiI8dYtWU3/e77oVY2931MhmQJ0tXFS6fua590tpTUJ1z95KGHSLyixkzd+jdo3K4RkKkhoIvZ6lRmHJhSDLu/f0B/ZSVeNPqdD9ffF8jLrwqm8ZrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZqVj/dw3JlZYXfwDet3BJfH7hR6yPZyOGzY+CkH3ME=;
 b=ihDe1ycs7FaD36ZDDKwmjlz2DRmMJEMujNeRRhUE2xTvywN1cHjbCGeJZ1FDQa3zjFlnF46ZlwAcqlxqRNWEsB7PvwMlLZKsafzZZN6MSqBFuGAKPGvNCQ2u9CRxofeKpdOWiYiBe+6/36z1N4cB7jvgKfOo7QWRt9VKEWTfjPC+NusHklwjbLuZW8MmcWccMiNePIOupHoAoeqNydTT2TL7ezls7FAseEtAwQI6rHG7rJasmoctoDVawFZ+9FdvsnyO+R+nk0ENsbk+DxptnnxOPFi80nsDuf+HgzP2ZGBVuTSCN91Z5B/Wj82gQClGDS46mv2/FUU+qGa7R9drlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZqVj/dw3JlZYXfwDet3BJfH7hR6yPZyOGzY+CkH3ME=;
 b=FJ9Lm5Pu8pF1MV4n6t597iNjSZ4Z1tbGHtO8yMhF4+BrFbOFmM9TplIdnHQC029crGOYEkF8H8Yns786bRrm8EGpk9t5nwj8pmlT2+mbUnsQQ5gprH56IhA9DsHiQhFRII1HE8Gg+Ra6Iq8wCyQ2okbPmznDM08W+XmMT+n+HA1SP0sSBhOiYg+ozVvrRFAvMZ/4zRV/4I5kYpqpk7xL91WZo4rh9K7X5c2oN0cOWq4HvhRyKya482eWhQNJWs8Kd1ZLI4lci50wulanvhBuMu5aI7m7cviwfh6GV1yNthlXytJwJG1hYPai839C3CaA9iH5Utpd1BPWuHOCN6XDfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from IA3PR03MB8021.namprd03.prod.outlook.com (2603:10b6:208:502::17)
 by PH0PR03MB5893.namprd03.prod.outlook.com (2603:10b6:510:32::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.20; Tue, 28 Apr
 2026 05:20:49 +0000
Received: from IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad]) by IA3PR03MB8021.namprd03.prod.outlook.com
 ([fe80::3016:b672:c683:f7ad%4]) with mapi id 15.20.9846.025; Tue, 28 Apr 2026
 05:20:49 +0000
Message-ID: <d7eb4c12-7789-4ee3-bd3d-d8d618e13567@altera.com>
Date: Tue, 28 Apr 2026 13:20:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drivers: fpga: Use SOC64 conditional instead of
 Agilex/Stratix10
Content-Language: en-US
References: <778084f8-3688-4133-a64b-5f58f33a9653@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>, Alexander Dahl <ada@thorsis.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>,
 drosdi <danish.ahmad.rosdi@altera.com>, chen.huei.lok@altera.com
From: "Lok, Chen Huei" <chen.huei.lok@altera.com>
In-Reply-To: <778084f8-3688-4133-a64b-5f58f33a9653@altera.com>
X-Forwarded-Message-Id: <778084f8-3688-4133-a64b-5f58f33a9653@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:196::18) To IA3PR03MB8021.namprd03.prod.outlook.com
 (2603:10b6:208:502::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA3PR03MB8021:EE_|PH0PR03MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: dd5eab5a-c978-450e-a606-08dea4e5e85e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: TBSfXy0Wa+Ra5K/tWLqdJv42/7b61+ioC1k/4m7LPUqlE3UWXSel7IvTorc5gDCApT7B84sRDAGR1QS+n43EKT8SbU0At2j8wAagII21qQ0Ky01wzIJdHreXUBV5M3Sue066oysSGh11ckJNY8Edn/DtWjyKQAsZTZu644y5jFvbZ4OvdgkNz17mP1gtqVySHkIVCNkXAcVCxGIVegAoL2DvwNY0dIo6TpCJ+WF1q6u9qu3zNFMNp/ReBULq2gvvZglBhxMyGAeg8adBIvM2Yh6TTnzeJbV1uLGuv5uxjkv+q6qgZxEpKSI7Joedhoka3EfCcNUr7WyQOStwc9rwvjx1d12SELkm2kAQvotF0Xf17QHOYOIAUzDMgacDkQMJQ9w20xKyLk978N2If7zQf9JOUgxK/WjBx2JBDXiajFwAuxt2/dvsSGlDbGtiXYTjn14zrD+EWeNkLzLA+QFGjBCOFl6j8cg1JK2iwPva9fwA4NLLZ6YccYYbMnCuDuKRtga/msiMO8lEC7GSZ5YCeFHNXHbXuvUKMCbqr0SW9tHl2Seuxz8pxvAR05Jxly3FmARWXh/ODJ2dx8kz5Xmh0iFHlL3hPd0aXdDO21uX4lNDvip3Dm7+gEjhbgGLLLF4OWjZB/mAnXpIDXRlQiFpfuhZvJvaVhm66fgp0s0rwIslVVJYFz4NPOsfHIrnP5ZdbTK44+to3ra/zcvkPPv3RhdWBmnGD0qSpCIXSS5txWA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR03MB8021.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SVRyOCsvSmlMMTRBTUJIT0kxUnpXKzRwclhycWdPWnc2c3hMdFpIMWJnU1Vl?=
 =?utf-8?B?WTBEUUJyL3RhN2ZSeGNFSWdKWnB1dVRtMGtVNXk0RU5nQmxxOWZrYzUxYldR?=
 =?utf-8?B?MmJEWGE5U2hVb01TbmIyOXB2NWdDc0IxSUxpQ0FaYWxwQ2tqN3VnMlc5d2NP?=
 =?utf-8?B?M1VCMVNjTGMwd0xaOHBWWGpDcDlBMmc3cFdHNVVpaWtvbUVoWkdrVXVqMWNv?=
 =?utf-8?B?alBZOWxqdTQreVVkbjdOM09jNitWTTc4Y1d3bEIvNWZleDY1M2g2RFFhMjBm?=
 =?utf-8?B?Vzd5K1Y4cFFLdWl5S3d5YmVrSnBCRzl0YzNhdmhCeFhRRko4bXNvblNmbmVr?=
 =?utf-8?B?WXRUS1RXaW1oZnFGZmwwZ29neVlvcnRmL3lmWHBOME85TlV6cE1Ua0tLTDlJ?=
 =?utf-8?B?dW9qSUFvQ0dRaU1iLytlYy93RDU0dWx3bHduV0JmY0YzaUo0WS9RQ1JLTXFn?=
 =?utf-8?B?UDhoYno0RG92YTZUb1RKT202L1FCa25IdjhEM2tNbkU2bldVOGlGbitVVkxx?=
 =?utf-8?B?Z1UzeHF2dEY5Yk54OFpVQXpzN3pSTG1SYzQyZ0U5RHBiK0ZZVXJib3JVYjhq?=
 =?utf-8?B?Mm96UmFMQ1JmZ3RZUlB6R3Z1d3ppMG9Uano0a29jNUNxcnBkdWRYbmQrb01a?=
 =?utf-8?B?OHkyMStvdStYVnk2OXlaQ0pqQk4wWXRvZHJFemd6M2h0dmhzZmlnVGZmWUhC?=
 =?utf-8?B?WGdFTjlBK2IrRWVET21rdU4xak00M3lBbjduLzhQcXVyT2tVUVNvcG9zZ0Zv?=
 =?utf-8?B?NW9sVkJJZVIwSW8vT0pDUng5YlJyZDNDZWN0TnJqVjZkdE1BejdEa1Qza2Jp?=
 =?utf-8?B?NjRoVmxLYXRmL2xodHdYYW5mQ0grNGoyaktxZjErVlJ1aEo1ZDZyREY2bU0v?=
 =?utf-8?B?QzZ4SzdhODZiSnBtK2YvWmRyQkg3RFJ3MmVETVlMRElNK04rVU9oYzlnclJJ?=
 =?utf-8?B?VmdYaGZOdHFObU1wamY5UTdvanJXQW1KSGZzWFNvMSt1Qm1PTFMrcU00dmlL?=
 =?utf-8?B?K3R1U0FiNTl0Rmh2UVVsdVIzNFJ1bjA4MUZpNUk2SWQ2WHlnY2o2NG1RRzhp?=
 =?utf-8?B?TFBiZVYweG5RakdNQnpkMjgrKzkrYlpQUm5ObVYwZmVmbVVZa3FmTmE5VjEv?=
 =?utf-8?B?VTh6L0F3VXNORkZrczIzek01ZVphTWczVk92VVArdjlsanFHcldSLzk0UklC?=
 =?utf-8?B?WHo3WUk1YjczYWxEMyswRHF4ZWkzdVdKR0gvT1RDb2VxZnE0WUNweVMxZGVW?=
 =?utf-8?B?WmlIcGtyYjFuZUY5TUEyOXQ1L2JuTFlDN0Z5UjFyMENsWDNBcEZCMXlBS2hD?=
 =?utf-8?B?QWxZOGRRZHZiT0FxbVJ6TDNBcFZ4K2RkWVF5RlpiVmFUc1dORTg4VE5Jd2w4?=
 =?utf-8?B?NHp2Z1FqdHh5akVVTDdHNjU1RWV6NDVqaXFVakREby9ZN1JJeEdubGdmbW1E?=
 =?utf-8?B?TDJEUjJwM3dGUGJ6SmtXdXpIWDFhSnZYN0Rqc1JvWU0vNjBwZXJ1ckk0ZWJM?=
 =?utf-8?B?TWVpZHBJMGZ1dGdYVW1sNmRCeEMxclpDdVpTSXFUbU5pR3R5RkE1QlNuY2xE?=
 =?utf-8?B?TXJYYjNHWllaOVoxQkp5SE5iVUxFTXVHcDlqbmtydzRKT2VRSDROZFZCV1Fl?=
 =?utf-8?B?cFhVbktHdmUwVmpNQjgyYUkwZzY0OEFxWlIrRk1xWWFPNDFHc0EzS2dUd1RG?=
 =?utf-8?B?Q2l4bW03emxhQmxkNXdZMGFGaCtUcFBNUFFhT3B5UmR2bTAxTjhDU1pRZmVw?=
 =?utf-8?B?QkNZYzRJK2trTGpOUzY5ZjBjTkpBQU96KzZhNjd2WlBzanV6cGw4WXZtTjE4?=
 =?utf-8?B?RG9jVkF6eHRTM21maXVvNDRjejJmZUVkaXdETVNqeXZRVWVONE9lSzFDNGt1?=
 =?utf-8?B?ckdmZi8zV1R6cUg4VlIvSnJxWUZtcFVvNXhRM2ZqNVE5M2JqN1loYmxtdExw?=
 =?utf-8?B?TVVHN0lhdkNaN3JJYjhhblpjejNLNHhYb1dVaTczZmhBV3hWVFRxdEpNb1M0?=
 =?utf-8?B?djNGSnl0MGpxbUJXb2dnaWZKZHR0TE45S3N4M1M2YWVad0wzWWtxSjVuUWs2?=
 =?utf-8?B?dEVJYW1OclZ0dmZsREdTcjhTQVVrU2RxT2txbHFNV2VyU3B4cE9tTWJFTlJq?=
 =?utf-8?B?RU1QUkorTlZGbjBkM2RHZnNDK0g5V256R3dNZ1hiRnhtdnI1WmJSSlNTQkJq?=
 =?utf-8?B?T3lxaWhKbEFQV3M3SmZqZHFjSVhEZWNobWljZmNFWlU4YXY3VnoxZ0tCaWtV?=
 =?utf-8?B?V1FaYkxEMVZtY1laYTErRWVFR01RaVFMOEtIQVBQcGlwbUZOOFRmQ1N1WGpj?=
 =?utf-8?B?QUZFb0l6M2ErNlhkMVN3N3J2SUhVeFRkNjRNeC9NdXl1YjVqQWRhR2lkVmZ2?=
 =?utf-8?Q?jYZIRUxl4Fl1dm8Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5eab5a-c978-450e-a606-08dea4e5e85e
X-MS-Exchange-CrossTenant-AuthSource: IA3PR03MB8021.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:20:49.0353 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nemcscm6OGlJgbgr3Xse7NvxbeUH6E2jw/dujU/vMw54Qv+LdMZmgj3BnxvoioTKcTsZv5GITahROuh/3HN6uBuDSdG0DMYNpmcu5l/K/4c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5893
X-Mailman-Approved-At: Tue, 28 Apr 2026 09:38:07 +0200
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


Hi Tien Fong,

>>
>> -#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_AGILEX) || \
>> -    IS_ENABLED(CONFIG_ARCH_SOCFPGA_STRATIX10)
>> +#if IS_ENABLED(CONFIG_ARCH_SOCFPGA_SOC64)
>
>
> The guard is now CONFIG_ARCH_SOCFPGA_SOC64, but N5X is SOC64 yet does 
> not select FPGA_INTEL_SDM_MAILBOX (confirmed from Kconfig).
>
> So the comment says "SDM Mailbox based devices" but the guard now also 
> covers N5X which is not SDM Mailbox based.
>
> An alternative guard that is more semantically precise would be:
>
> #if IS_ENABLED(CONFIG_FPGA_INTEL_SDM_MAILBOX)
>
> What do you think?
>
>
CONFIG_FPGA_INTEL_SDM_MAILBOX is the more precise guard here.

The functions being protected (fpga_is_partial_data and 
fpga_loadbitstream) are specifically for SDM Mailbox based devices,

as the comment inside already states, and N5X does not select 
FPGA_INTEL_SDM_MAILBOX despite being SOC64.

I'll send a v4 with that fix.

Thanks.


best regards,

Lok

