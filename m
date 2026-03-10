Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 516DAFD2D77
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 13:14:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC90B8404A;
	Tue, 10 Mar 2026 14:12:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DrKeYToc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC95783FA7; Tue, 10 Mar 2026 11:55:15 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F4E583981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 11:55:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=boon.khai.ng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1PVPcW18fSgsRoroopG80GD9NzgV7jFPLbB4CLoEmZLv0iFuicpvVsNbFCu6shsku3iWyeFI6wkIzM8/GNhuoJIPZBmofzEtnjEBFXUdAAV3XDW8U5pvORftQaTAAzozNIjML3tmt2zN3bCKJzBh5A61sQPE53MVvXa36xRHXrVaVjAFHGZTqUaTyJ8Zf10eUKsx2VkA8Syjco0a5IoHnjxOV3RxVScqhNARdvxqBshPWMcAKLIt4EWK4+DGAgs0h3hJAZMTu27DJ/h2njcrKwe2xC5/ONNa6KgI2fUCAOwBWCSLO6xWSdnsbnGH6GnKoxZB/mJVOKilmr/e2FfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KS/dueLY16pUPimnWTU0IigES+yqCCmiiwLJf8Z4/Ho=;
 b=CQOZj2Kfd1pQAkKseSYiHbftFaoPRtI//kdx/Ft3GeOncHcOaf6boG1cQW1T8KAqCrC3JEpeJZm+4EMwAeurZxFtu459f/wOlXwOcFXFWqcioime0aVyRFqZ9j8Es1nsLkMcj9nQqL4DWgjLTBH4tuBWdQlHLedbiHWLO+pAuVaDCjMnDq7pOEEkF5D652sYpCfFewmemr76eyVe/VaIHimN2mapq90dVpSLqsZMyeq8V/bH0ajjwt5Nhdln2m12I5/7FJvip167+juQ6uSZy+86ReAHmOhweUPuUxsKirNaKKSLu2hsRLNDPfT6Aykg2S7/nechkJAtcdB7SiWNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KS/dueLY16pUPimnWTU0IigES+yqCCmiiwLJf8Z4/Ho=;
 b=DrKeYTocG0Qw4S7QHxhMlsZAeYVqpTH9zmYBSgsdEv6cUw5OihfXGqFN7FxwZz5N3sADozZO+AcEQy1+oXxnWmSrRcem3+vkxazR4UsPx1g+A9UpXKFL1XLeiRGFzXhiM0WSDmYQ1Ogy8BzoOdvOBdWlsvu4Ss/NgcEro4XLhDoB9y+c4jNUB6QmyiMeql2/HZr96upHRIwJRwxhTTbVpgwGL5QDFnerXJD1LBda6qW8cQ7xNazBfblxfFzbOwxbsxjn2rT1i/sxNxZR713hCkQLu0wp8PVL26v90cIGVIQtROZ/idKCx+CwxNhCM7wxQsVnisUXoshH0sM/8YkXcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SA3PR03MB7187.namprd03.prod.outlook.com (2603:10b6:806:2f6::11)
 by SJ0PR03MB5629.namprd03.prod.outlook.com (2603:10b6:a03:278::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Tue, 10 Mar
 2026 10:55:10 +0000
Received: from SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53]) by SA3PR03MB7187.namprd03.prod.outlook.com
 ([fe80::7000:d55:b39c:2e53%7]) with mapi id 15.20.9678.023; Tue, 10 Mar 2026
 10:55:10 +0000
Message-ID: <9c903855-51de-47df-9551-655aa52b8316@altera.com>
Date: Tue, 10 Mar 2026 18:55:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] spi: designware: add support for bits-per-word DT
 binding
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, U-boot Openlist <u-boot@lists.denx.de>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260227110434.5058-1-boon.khai.ng@altera.com>
 <20260227140756.GP1593142@bill-the-cat>
 <a66c8ed7-0f88-4e1f-a212-30e39f675df2@altera.com>
 <20260303143721.GM1388590@bill-the-cat>
 <20260303-choosing-chivalry-6f892a14eaef@spud>
 <ca14a108-6308-4b48-981a-a0d20b716ded@altera.com>
 <20260303170554.GR1388590@bill-the-cat>
Content-Language: en-US
From: "Ng, Boon Khai" <boon.khai.ng@altera.com>
In-Reply-To: <20260303170554.GR1388590@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0001.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::13)
 To SA3PR03MB7187.namprd03.prod.outlook.com
 (2603:10b6:806:2f6::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR03MB7187:EE_|SJ0PR03MB5629:EE_
X-MS-Office365-Filtering-Correlation-Id: e27babf1-adf5-45c5-7398-08de7e937fb9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: nsxIeq+MvHejyDBUgWGCgG21nJfdGYfS9LtOvYTZxFyqsJM8IzYnpq9dTJVvBGGdhJM49FKIWCj343chNBlAlnUShSMhRsuyx5VgOUXLgeYppQ/zrbNWMNefaXG6nb02Iz/dbF8DuRiKiY60vHqHPmGF5p+NNw3incSwYQpDIKCt1TaBnICfMg3V7MT9mSHPxi95yHyPK5V2pQ5LUed9QYifm/8QmBGrkZHFHpTS5tVigHrCSwG8LyjeIC2rUqaoDYsoA0mhJhntN7lby96qcIH8kNFPJ5CpBYWc+84BuFnuQCqXCoq7tQf4cOX2HITz1J/ER2NZ3kWu1u00NByOyAT5GB1Hv3WLVr7vtkwduybU7hM991rjQSzD3b2Kr0C8KNdXK6QD7fnx74sunYPH021+/58+LVxe+hxtea2VlY+48ooCa675SfVguexoyS5RTU0ItWD5eoFTojqcvrzL5oJ4PyqUhH1k2dtkrfPDZsLox/3dpa/SojQYjtkr70qIoBGjuVi61pbCNq/D5xwsZXhD3m3E7huJVr86dDvM854S+jF+38Jm3kY4lt5nz2zfLM9AWcUxZKG9NfzLy1Gv1gog68AKNBWQenmH/JfERppHhZt+DiHuSqlBIFph1xVW5zmsLkeX+lW37hih4YpWtPdm8TeiybUgCO+Qmalz3Nq5oHkS0o6XLIvimUfTuAUx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR03MB7187.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bm9NY1BKamhFNUoyTUlBK21taDdiSXNYREJNeXFHQ0FLb3k5RzBndXF6VWJH?=
 =?utf-8?B?bUxURlhSWXJJK1VYYjNFeEo1MHM4RlVFRHVjbVZKd2xhSThiT0RYeUFLTUhS?=
 =?utf-8?B?Q3ZLaTl2UnhzMHIwc1hGeWl5RDFsQU93ZjZpRUpmcDh4V1FmUkZjQlplUzE4?=
 =?utf-8?B?WWgyQktVTjRYSEZ4bDBZd0NCTVFNa2YrZ2s2RUVSK3RjRmptVVQxUFZuaEdk?=
 =?utf-8?B?S091RkwzQXNjM0IzYWVBeE5KNXVVUUI3SWNyTkR0RkE1VkV4UWV3bmVMemRP?=
 =?utf-8?B?dDkzK3FoaXYwSHBmc0lGc3lYR0VEdlpweXJOdzNmTGxuQ21vRUVmaFpiR3I2?=
 =?utf-8?B?UnBKKzZ5LzMxdzluZFhva0xNN2hscVB6V1IvcC9mNHI2SzBiejV2Y1c0TU5s?=
 =?utf-8?B?SUQ5dTNDTU02OC9LQzRYZkkwV1BDUWZvMkYyanlhNzM5bnlST2g2cjVuc3FI?=
 =?utf-8?B?bXAxbGRPRmhJOWl0R1VqSEVUbXY5UmhPT2t0Uk9JU1NPUit6NWhhTXFXL3Jw?=
 =?utf-8?B?UHZub1Vmbm9GbEhZTkZTbnpKTnprL2lVMzNEUmV3Wlp5ZDFVd0dORUZjdXpH?=
 =?utf-8?B?czdzdktSTHRJK2dualNYSnFaUHZTSUNSYm0wektzS0ZhSmhLT1JlUVFXbmsy?=
 =?utf-8?B?VmYzRjFXbTNxejNYOUdzYVRkK245c295YTJGNWs0Vi9xblVaRU4vZE4yMG00?=
 =?utf-8?B?c1lyYkEzMjZDODJZbUpiYjlSeUhES3p3NStWT0wyVW1TVmZvd1FkMkRRLy8y?=
 =?utf-8?B?WWgrL2RJS3V6c0VoZWRrNEpSNTQ1ZTRwVE0xVlhzbk5jd0tqeGdqTHJwcTMx?=
 =?utf-8?B?YzJHdXYzRnZLYnRZbDNaQ2MvRnZXYmc1cE5acG5kc3FHOUZUZncrTEhXb2Jo?=
 =?utf-8?B?MmxSNGMraEtidFBrYWV2QzgvVlpVc3JvWDZiWVVuUnpRdWUwQVdOVmQ1MDRr?=
 =?utf-8?B?d3lpRFh0RHdCbG81alIyTnZpUkM0R0VZUzNNUFRHRmJJVnh1Y1NkV3BNdnYv?=
 =?utf-8?B?c0NOV3lydkZaazZBTUN3ZWI4S2RtTWtTY1NVRUV4dUNvRGRsZ3QvOW1xYWFh?=
 =?utf-8?B?d3ROaTE1Z2dESVpRSDRtMFpqL3kwUTY5YW05UXdpTGZoMnB2MU1DZlBsL21D?=
 =?utf-8?B?MnJ5aG80amZ1cWlHZmtjdk1xN01kUkwrQUEvUFA2ME81NFdhV2R0VENEQ1dv?=
 =?utf-8?B?TTBHS0ViQ0VLV3lJYVVDYkYxT1pST0lnWjlOVE1lN3gybmgzRHpibit0Y3hI?=
 =?utf-8?B?d2U5aTFoU2dZWWh1UGxaSXNBeHNBZjJhZnNMemtnc2RtbWhpSzdDU0hOKzlp?=
 =?utf-8?B?MURDa3BQWCtXckd0M0lQM29Ha2NNK2pYQWd4U1dnV1I1ZUV1QXl2MmNkQnR5?=
 =?utf-8?B?amh5dWFpSlBRbGE3MHBsYm1VTnpjbTJmYnZ0VVc1b3hWakhDdFFVM2N4UnEv?=
 =?utf-8?B?d3FRbmM5VXJ3YnN3YVhZdUhUVGEvUFAyN25SaWxTUUhzdnFCSTBjdGMyR2hJ?=
 =?utf-8?B?QUg5OFJzNkdHTTNoLzBBY0hTM1h5L0dlVHFTOWwySjNNcVQ4RlkvNkVPTmtS?=
 =?utf-8?B?M0tHS2ZMNlJNeUdxRkNPMDdMZTRvcHB4dEJob0txSTZLU3BYaDBnL3E1OGRQ?=
 =?utf-8?B?MU1PN2NTMisrNFlEK1dDc21hL1FZUFlIMmNhZk9zTytoc3FVaEkvblJhNWRW?=
 =?utf-8?B?Z1FMc0dlVGwzK2tudzlhV2lyWVY3cEg4Mko0ZkFoNVpxczBaeTRuT1VQSUMw?=
 =?utf-8?B?WEpsOGJjczhIZUJERDlJQ1BUQXZWRTNBYjV6aUlYVDd0S2lCem9ZWFkxQTlI?=
 =?utf-8?B?YkNvZXVJMThjYjNaVHpEeDcyUEg0TWNvUFQzQWFROHdwVXdSN0owK3o4eFNx?=
 =?utf-8?B?NXpqajdMMmR6ZnpiMXlPbUpVYjRwWFBpaktLYmtuSnhMTk83N3lqWVlKSnA2?=
 =?utf-8?B?UHhVTGwzWkFmZjRDYk9rbFVqNTJtSEllMU1SbUF1L2Rkc083NlJIUmdodElG?=
 =?utf-8?B?eWg0bjlqM1YvSGNMRFBHdXNzNUlHdHh6NVNNRVozT1FxMCtiVjN2bmNRZWtu?=
 =?utf-8?B?QnlHcHJBK2dwNFhubHdFZFJkcENWekFnbDcwUFVFbmtRcUlBNzhCUllwWTlU?=
 =?utf-8?B?UWM2UEVRVVVzRTlFNmJLelZSaGJJbjBGTkJ5ZzZJcXVBVjU4c1UzTWdNdzRz?=
 =?utf-8?B?UC9NaGRmc3liNWpMamF3cHRiT21FN1ltUlhEK2w0dHgyV05wOEN6alZrSWV3?=
 =?utf-8?B?ayt1VWFLM0l3TStjTlBTWVl4QlhhRFAzcHJ0dWp3YnFqM1BYQVUyUHYwOWNj?=
 =?utf-8?B?VlY1UitLTFhPTnZpbWNHMzM1bC9YbU1MOEpOVGp5L0ZDTHY2eFl0Y0Z5RXRn?=
 =?utf-8?Q?VmgmBj0daY1s4jTc=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e27babf1-adf5-45c5-7398-08de7e937fb9
X-MS-Exchange-CrossTenant-AuthSource: SA3PR03MB7187.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 10:55:10.4684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZWQXyNHEIx29UVPF+HLgm39zbCEfWoCntj0weUMgx/+yFVT7rz7ABUEQ+uBwvcxjvy3t2HP4cSxkoJzSAnTujg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5629
X-Mailman-Approved-At: Tue, 10 Mar 2026 14:12:26 +0100
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

Hi, Tom, Conor,
>> configuration.
> 
> Thanks. And can we reasonably follow what Linux does here instead?
> 

After study the linux code, the bits_per_word value can be set at the 
higher level stack for example the touch screen driver ad7877.c at line 
https://github.com/torvalds/linux/blob/1f318b96cc84d7c2ab792fcc0bfd42a7ca890681/drivers/input/touchscreen/ad7877.c#L694

will implement something like that in U-Boot too as follow:
1) Add the bits_per_word in the spi_slave struct
2) at the dw_spi_xfer function to resolve for the slave->bits_per_word 
value and store into the priv->bits_per_word, default to 8 otherwise

Regards,
Boon Khai

-- 
 >
