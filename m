Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F04CA0EE6
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 07:36:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E2FD81FEE;
	Tue, 19 Aug 2025 09:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="b75Q2skj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBAE582AFC; Tue, 19 Aug 2025 09:36:31 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D8080FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 09:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x/rSIN1VLCiONkAVi4upnnu/GccaoqHxyTpWP8qDkuXhEG54vX3ei4HxOQzDJllMj/xvCaUI2WqbDn9bokaz8EX1zdx8eY3E7Sd9nf9EwZDbKtkwOfEgmf+Is3h5uDYhNqPXZkcLcE8kyXb1bCH1yupHgVDZHGv/RDvJOveG3atj4AnBZ1Lg6Q0QsbuXbUd6cWUhQA/uPGtHbEga9qJouksT7Wc7KIK9aT9yn3IVFfuDQ1BwJr2jVd4uuCOx6Js1+/1Dsn2zEdhXO1++/ZL51aDo6cbJ+qJg87yhIGdp+EEsayFs07zSv8rfVlxqs6kmApNG99pyVt8GMX5OKxKCQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jOdE57sW4X7KGfhw78YfTRog3Z3Gn/RIg7kKQdxIfsA=;
 b=KuHBR926VwmO9nuMt752a3juaOB4ocE7wQRzUzhErUWlxKKvDdLf+dmuNwVniLgP+3k95BCMuXW2g717cAkOZkouoWiDZ7UIzhB0pFMoh6W7RPtWPHlrU/OgpJKKnD8wxaGrt6T2SLYgLSlM6I7LLbvzCElBr8BF+Idk+QeaOsyU7p49T10y4vLBN+KXyff8ayUWpuTM166TqkiqxHogFgQMCEX5/B6COzr7JVS5IdDn56yfHDlU3Wv9z5uLUV86cazTzuJjy25HtpTcn5fItrDb9ganYBi6dmBjKl9dv6mJbSfsmJJqNRZwIa8575ZRcWdXKaHalcsco4EOtjue5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jOdE57sW4X7KGfhw78YfTRog3Z3Gn/RIg7kKQdxIfsA=;
 b=b75Q2skj74zh0PnJJcPjfLLpdOWYm0bskQv3NoOWPysoyRr7WKvO3/VMHBMi6ArsQ9uqzoA9URgwIO8ajDsbdVP1rcrryg/gxPk6OVLXKoEOvdR0K3ahpGsgzvclr6m4HNEG2zIlsx+TpNF/A84NLYAEXBAlnad3nMDbG4FuPtOGaVKHoVNRqVPIyz+L9B2ZI6ODca0Ndl8k2/v3aowAkGc0xw8rNbI0qaCnsfluDHjStZEP5qFwysER9Lxeam19h0XMrB1gm8/NCaRikIuO9Y2Kl1aZdLc3jZP2NoNE6cFvzmql9ZE7giuCHkAlmmLazEe8zVa/BV/fu6M4Jr6kQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by GVXPR10MB8003.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:17::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 07:36:28 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9031.018; Tue, 19 Aug 2025
 07:36:28 +0000
Message-ID: <5109f1f5-0417-443a-ad5b-4fac5aabfde0@kontron.de>
Date: Tue, 19 Aug 2025 09:36:27 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 17/21] mtd: spinand: add OTP support
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Boris Brezillon <boris.brezillon@collabora.com>,
 Alexander Dahl <ada@thorsis.com>, u-boot@lists.denx.de
References: <20250813234314.3945708-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-1-mikhail.kshevetskiy@iopsys.eu>
 <20250818100614.432931-18-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20250818100614.432931-18-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0016.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::26) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|GVXPR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: caf786c2-4df3-4688-9feb-08dddef31ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|921020|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHNiQlJpSm5meWtHaHFwOW9VSGpvdlNBZW9mQ1FJaXJnWlZGZnJkd29DdG04?=
 =?utf-8?B?NVVWUGhGcDdRU0E1TTNzL0tjUjRYZmlpZSs3U2lYTGJRdGhZeDN3WEJuY2sw?=
 =?utf-8?B?Q0hDelhhcUpnZXkwS2pUcE5OMzVpRzBpd1RHb3NrV1B3b0l1VDNPRkY4ZHRn?=
 =?utf-8?B?Y3pUY295ZHA0eGZkbmJQc2RORHpCemE0TmYzREU4S1YvMXpUY04wZm1BdTAx?=
 =?utf-8?B?WEtyd3F6UkVwMkF1cGx0ZEJvZnpRdGJYSEQ0TzNOSFNuTjltSk1BTjhEMW5j?=
 =?utf-8?B?V0xRSGsrdGpydzVBZkVka3BCQTB6MkJpSVNuWVFWdEUzUlRBL2RqdlIyR0xy?=
 =?utf-8?B?Z0VNMzZzUDZlT3IyblJOd3RXTmh1QWZNampJdDYzS0g5MmF0WmRMdE5JS2Nk?=
 =?utf-8?B?REdoRW90eEg4aVBPTElCSDE4K1ZyWEJZRWRiVzJNYXRSdVJMYmkvY0w2OU1z?=
 =?utf-8?B?aEJmU0xyamFwdTFQdDRRUmNXQ3ZyV3ZUck9aQ1BxQit3eXJPM2FXZnFnQWFj?=
 =?utf-8?B?SkVpdHpoODdPRnVLcVdSNVhyM0J2YzdYSDEzQlJoVElDd240blM3UkVNYnpi?=
 =?utf-8?B?dUVtZWpLY2F0MGlac1AxMnZvYmMvaEQxTktOQnFIKy9pdWxUYkVBajFzcTF6?=
 =?utf-8?B?V2d0OGJEV1BSbHBnU3hxeXhYdlRLSFA1VzZRWCtjemxncXFYTzQ2YWQvRmZ3?=
 =?utf-8?B?ZktKeDl1bWt2SnhoZ08raGVtM3NydHhreURjKythdVRQbCtJY0lJMGFWcmVs?=
 =?utf-8?B?OTI2d0FWZ2NKaVh3UVlESFRUOW5PUjMzVk9EUzg2Z25WVFIraFYyWTVaUk1z?=
 =?utf-8?B?WjFOV2t2QjI0RHllQnptOFNETTBUTVpNMHVCK21qUzhPZWtrZ1VCMHgxRVNV?=
 =?utf-8?B?eTRHeUtRR01FSXRWVHdvMk1FWWpnQ2NsYlBYN3podlpwVkpKTnhZQmtBakJt?=
 =?utf-8?B?a2orenp1aEV6cEV6Qjh6Yms3eFBKL2JjR1B6ck5jdDBsRU1OV0NKbEtMZUwr?=
 =?utf-8?B?Qy9uMXlpcGVQbGZ5dndnQzJtQTM0cFdST2t4SjNiS3ZmTUk0cHJMTEM4LzI2?=
 =?utf-8?B?cVJTNFNURHJxOTVVc2VFVVA3WHlsWHoyYWVwWm9ZMTZkUGxkVkxleWNOcWxr?=
 =?utf-8?B?MnNOUCs1Z0xGZVcrV3pFZ1A3UkplTEZNMkRLcjNhOUlQbEdoL2lDN2UzT1h4?=
 =?utf-8?B?eGdZa2c3YUp1NEZQa0VnUzBEZTBNLzhjYUVqY2l5UzVFTzF4WUFSSzIzc0lx?=
 =?utf-8?B?bmlHY3BqYXRMNEdmcVNDSlJjZkJWeUc5OVdxelR4cCtzSEJTWnMzTUQvZGtN?=
 =?utf-8?B?dnB0M1RSMzN3d2ozMFU3cExXTEl3dFpDd1Z4S0wxSFNjL0l5VmpYeWQ4U3ND?=
 =?utf-8?B?R1ppdmdLVExPZ1JIR3YwM2tqalRnNjV1Q0FIbDVzcjJHMVFmemtSTFZZdXEx?=
 =?utf-8?B?Z1F0T25PbUJRdTdwbVBQa1NoWnBHcmFENXZNSjBzNUVuSWtOck1hNlpnWkRT?=
 =?utf-8?B?REcxbUlsWDZZdHpibDBUQ1RidzlJMjUvbGFiYTVrR0lPZ20zVTArSVNYT3RQ?=
 =?utf-8?B?YmgvMGZob2NXTUVWQ2Frd2VQRCtuZDZrcHg3NndiYVFLeTB0bFFqZ09XemVn?=
 =?utf-8?B?TkZCTE5NVTdCRlBoU3AyZzJzbEJ2bGF2RHJqaUhTVVEyTCs3Y241ZEt4WjIv?=
 =?utf-8?B?bXpOS0NmcWIvNndrVUdocFA4enRZMGZPLzJwYUdXOWFiMTRhdWRuRWEzbU91?=
 =?utf-8?B?bDQ3TVZIbFRheHZIS2JzRjJLQXR3VG5QWkhNWnlCQ2x2NlVtYzhBUnR5MURi?=
 =?utf-8?B?R1ozbS9OTlBHUjdINlp2YTl5VzRPQ0JCUUw3a1gyZFh5Y1pSMTFSc2FwQ3hZ?=
 =?utf-8?B?TmNoZXliVnZ4ZkVoZC9NNEovczFoSFhQaWUrYWtUTFJiRkNGQjJrVW9VZDhy?=
 =?utf-8?B?N2dHMVBteXJoUkR5SStSNUFGbU1kOUxWa3JhUGZnWG15bkJPOVJlTW00ZHpZ?=
 =?utf-8?B?bmtobFRqWGVRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmVtY2ljMVBqNW5wNVZESkhzZ2JKdUh1eWdlZ3Y2Si8vOCtGdlJGMkhGN1lO?=
 =?utf-8?B?WGltUUREYkRSMlJDanVYaHl5cGQ2RXRFK01MZlRhZlVlV2pCNlpuekpPQU5U?=
 =?utf-8?B?S3Q0NmgvbzZPMFRMdXhlSmcva0ltOTNmZGRJVGdFbjlzZUUraUVaQy9pbzgr?=
 =?utf-8?B?UENLUDZLWDVBZDhFT2o2bHdxT2hpODI2VGRrci9TbHkvRUhkZUpoMU5oNmo0?=
 =?utf-8?B?U1BTOE9iQThDbWNNVmZIVDFaUy9tVzVNcUoreHpIQnFWd01HVXhOaGxranpS?=
 =?utf-8?B?NklxVFdFN2p1WFpNM3FrbTZVdkdnOTJoeElIc3ZpVSs2VStUUFB3cWs3Y2U2?=
 =?utf-8?B?WG1Qbkt3TUVBa3EweDZNcFBnRzNzY0JLQnRuUS9NbTcyN054WmViTytwbVp5?=
 =?utf-8?B?QWZ3ZTJuWjBLSlJaT0R6eml6T0xFWkhVNDJWNGtaWGRBNzF0RGxyVUdqQnhx?=
 =?utf-8?B?YzQwOTRHMUhJTjV3UHp3ZkhSZWVCamo1bTh6NjY1OGU0K3ZzV0p2N2RYeXh5?=
 =?utf-8?B?SmxONHUwd1phaG05ZWI1enBKc2FQSjRDQm4rL3gyc0krb1V3M3M1ZWZuY1Bx?=
 =?utf-8?B?T3YvUnVSeWZzS044WHEveENnQmkyZTZPaFNoNXFDVTcvVVI3NEpGK2dvQlMz?=
 =?utf-8?B?MnBiRUtxY0VobUVtQzQvR09wcTZ5SzFNU2dxaEY2YnQ1dmZKQ2RGajgrTDU3?=
 =?utf-8?B?UjBxb1o1bkFBcWN4ZFg0bnk3S2daUjNkVkJLYnM0THRiQVJJOCtpR29lUDZr?=
 =?utf-8?B?RG5CNUdtQnhFcXJ5OTgyVDF2R1gyL29FTmIra29KeVVaQjdWVTE5VTJhQ0ZI?=
 =?utf-8?B?N1NtSGRIWUNjdGtiYkkraTBxdHpDdlNOempHb29pRkxXRkdEbU9oek9jakRq?=
 =?utf-8?B?TzQ5bGl5WFZYcGNwKzNDNTE5WEdsUzdIOThheG9yNnhqMVp3T1VrZmRPcUhv?=
 =?utf-8?B?TEMwajRmdC95TEVUK3M2dG5KVGh0VHIxOVBlTmJzK1VZT1NYWnVLMnYwQW1K?=
 =?utf-8?B?NEJiaG9hcFV3QzRPRldFbFh5SkFPK01sNmJmTTBXUW9ZT2g2b3dKRUlvMzk5?=
 =?utf-8?B?WEZXb0lmNitDQ0k0ZTl0cEFtV1FnT2N3K1dSRlJPcDhxMFc4UXJmMkE3WlA4?=
 =?utf-8?B?V3ZobFR2bytXRWFRRGZYRGFURjU1cnR2Qjh6a2h4NWsxQldLQ2lWNksxQlZJ?=
 =?utf-8?B?L25VKzRzVkpabDN4clNVcHhkSTJsaE5BTGpYc1dEZ3NmdExOeGpaUnFFZlQ0?=
 =?utf-8?B?QWUvTFE3c3ZuZ0dHejFPNlp4M1VTVklPV0wvN09kUnBITXZNOXF3R1ZiMXRQ?=
 =?utf-8?B?clYrNDYvTVFZRVZHVUpoRUhUR3VqaDk5YTRFVVg2Z1RRQVE2RzlNVmtTbGgr?=
 =?utf-8?B?MHJTQmdLN2gxQ0cvelN5RVBRTHhSQ1dyRjc1TFQyZEtrWWR4V3ZlRGFFRkQw?=
 =?utf-8?B?ZTRnc1NQSlkwa2NFeXBEWko0Y3V4ZThnblRNY3hMR0RJb3EwWnl5UnFTSmFH?=
 =?utf-8?B?RjV0S29rYkpHc2RBZjg0WWxUQS9zTVpxNEZ4eThJOVg0ZXFrZDVKaW8vS2hM?=
 =?utf-8?B?OWM1UUU1TnNjVGtVQllwUkhDdWhoeWFZTGpxUmdybGJpMFRVaUIzaDdhUHhK?=
 =?utf-8?B?TDdxLzlRWDVBQUhJQVpZSEJUUWdqYnpaOUQyZ1BPcTYyc1VpbTZBZ1Z5aXBk?=
 =?utf-8?B?czhPTUJnRjFzRk1GRHN6dnVJdG1NMzhYeUZ1djlSZEdPb0tQaUNYTGdDOFM4?=
 =?utf-8?B?Q0RmcG41ZnZYK25pRlBzeGVyNnBLV0ZhMWhLS3gxNldDbjUrcktUd3h6S3N3?=
 =?utf-8?B?RXByVEpSZ1dQcEpTM0FleDV1WjZ0WFpiWDc1NkdtYUpOSXpoaG9Wbm4rK2Jm?=
 =?utf-8?B?dHJBT1RmUWJkczJLcm9aMVFXNE9ZU2xRYzdrT0V2RkR0RVNSS1BycGFGTTFS?=
 =?utf-8?B?SHhmcCtqUFcrSUdCcThBaStCTmYvbHJRdXFxUVdHRiszaUZEZGRwOUQ4RGsv?=
 =?utf-8?B?S0VXdlpVZWc1RHozSWFXWlpzZzljK2FiODNFL0sxOXhMNWpUL0c0MnYxaEl4?=
 =?utf-8?B?K0VpRnl5UUdXak1aRDNBd0xvMDRPclFTanZPelpvbnl1cFZDdTIxMCtwYmxz?=
 =?utf-8?B?VFJ0MmY3OEYzd0k0cS9pY3dyWjNHdTkvOTdqbWxtMXpGbklIamZXR3FMNmNE?=
 =?utf-8?B?N0E9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: caf786c2-4df3-4688-9feb-08dddef31ba6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 07:36:28.2800 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDkRjRVk7dEmF1ezsOG590+RMCsEa4uHFn3ivvfqDt+km4Wl4plDCcYyqfq8I2KapMeKpEkXcN/q6c8H0LzjiSt9UzHkrXnp9ZKGIGbu/G8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8003
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

Am 18.08.25 um 12:06 schrieb Mikhail Kshevetskiy:
> The code was ported from linux-6.15
> 
> based on a linux commit c06b1f753bea (mtd: spinand: add OTP support)
> created by Martin Kurbanov <mmkurbanov@salutedevices.com>
> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>
