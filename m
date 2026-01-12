Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D983D2502E
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 03:05:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72105839A8;
	Mon, 12 Jan 2026 04:05:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KtDwzsG5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB36839D7; Mon, 12 Jan 2026 04:05:19 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CE4483990
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 04:05:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhHEZRa2aIBNmp47rOEAwEypD1dbIeDfj+ZT0vd6DLwN8+GDxdtRvmk0Uk2j8cFyCi3haB6ViZ7gF7I4vjyIvQBiuDa4kKDSL9/Crb0muTshAq8HlEG38pK5g1UkXjgAJE2zgrjbr6uu7PWW2gUwU28XGvykEpDk7IUiFdTwUPTYgtwAGIsoo1ynx4xNPn1+N7vOf9R++gK0OiHIuPyEUytFp61Sabf8qYm15NQfAe80Y6PScQZKYKyVgChVo9TzX22rpTihO8J/ArCEnxZ99JSfOeSXSugToy9pT7Gm2/NR8uF/7Rb6pPi7r+ivc+8PS16w1wi5nMZPLVU5GyfPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADnXiJHmANfsnC5tD4aYyxqaueiF63j7U5SHrN4Cs10=;
 b=o255QhGcVda641++b/j3vcrMQMk2+ZY7TGwU6EeEUGifX4b64TGLf8LfjqR/RX60SCni0nCUYyZP0OCwKMIP36cfb7rWUO1h8jvP4F22CxZbxUr9XBzfUM+6G48XOeXQyP/+natMUvlPv/eU2w017Y0DtaeuCml4RP9GJGw2S/u9RHa/NTpfc0MBaGvzk1CqVzKk/6wYi12iWBNqggqZ+K0osaYP7R9dbjrl5PfObXDbj2SDGM5dHLm/QICDyFY8AzcZQ0Ng42IwDIwOn1i0JrG2hY+Dqe9r03hbRyJ3AZR1Io6BM/24BLci7seqbh7n98e4cGKS8G4Y36tlCp685w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADnXiJHmANfsnC5tD4aYyxqaueiF63j7U5SHrN4Cs10=;
 b=KtDwzsG5ZmAoyw/fGnW/W2YTv0/202GYpoJP+hR/toRjvEvvDFK/rzo//a8TvDnVh8fVw12sqOuRdhJeRdlk3XTUCurTIZaREvd3esfIlpyN3Ucnpq7x2OtN83h0exgeRqpsR2Ik66BgrjmTpiMdWRC5XwWzMzK/3UYJO3ljATA6yIYM/CKU5vF8aB0PxhGRHc01k3nAxs6y8U3lv7pAVyJjkYq6m8BPg5jAxjR6V8Yx21cqcmu6wtOwhJJAXNV9Lx6eA7RlpiKbv5FRBDirIsygqfw2nYibL9lq5kCmI+HyIGGWbhkAHHHT4HZjijz+EnxyjJroeMzeqWe0GCPH+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:33e::16)
 by GV1P195MB1641.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:61::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 03:05:10 +0000
Received: from DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b]) by DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 ([fe80::a4ad:a30e:789a:db7b%4]) with mapi id 15.20.9499.002; Mon, 12 Jan 2026
 03:05:10 +0000
Message-ID: <5e333477-1745-4db8-a56a-abfdad8ef825@phytec.de>
Date: Mon, 12 Jan 2026 10:04:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Upstream] Re: [PATCH] arm: mach-k3: am625: Unlock MMR registers
 again
To: Daniel Schultz <d.schultz@phytec.de>, "bb@ti.com" <bb@ti.com>,
 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc: "upstream@lists.phytec.de" <upstream@lists.phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "s-vadapalli@ti.com" <s-vadapalli@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "c-vankar@ti.com" <c-vankar@ti.com>, "kishon@ti.com" <kishon@ti.com>
References: <20250815160240.3575140-1-d.schultz@phytec.de>
 <63e0078fbf5cb045b79a441dca0f2f71fd3962e5.camel@siemens.com>
 <d47cb78e-e3e4-4a65-a0d0-b7dbf22e7339@phytec.de>
 <20250910120815.ifbg5fndnaodopvt@bryanbrattlof.com>
 <64f1a6561417bf7ff9d8e92ea69e1ef842bd2055.camel@siemens.com>
 <20250910125335.orpc2lrm2amncbwg@bryanbrattlof.com>
 <ae14d825d76df8b65cf82ac78a43aa0c47689b52.camel@siemens.com>
 <20250910132609.bfqpdflcgfbtouq4@bryanbrattlof.com>
 <50c51eea-af1f-48ad-bb15-eeeeedbf9bf1@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <50c51eea-af1f-48ad-bb15-eeeeedbf9bf1@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0254.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::18) To DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:33e::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P195MB1444:EE_|GV1P195MB1641:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc8ef21-c3ab-43d1-1ee6-08de518765e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|4022899009|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z2x2blh0MVBseDRjelZENFFFOUxQSjR1eTNySC9mZi82ODdKeERwN3lUSDF1?=
 =?utf-8?B?NXpiRlRwQ01BbmlveVVJSGpDT0hXdTIvT1dGamg3aWNTWjJzN0lJMkJQTDFp?=
 =?utf-8?B?Y2E1a2RVR1c2ak80RFIyM0ZCOVFCTldTaE45N00vTyt6ZjZvdUQvaTdLUDNC?=
 =?utf-8?B?VFJaakFEaTdQMUdoUFpzRUZzU3BEZUcvcnMxNXhZeDV2c0J2NER4OERTN1Ry?=
 =?utf-8?B?RmhHeTRXOFVpazE4TWJML3V0bXhtQ0sxR1ZVcmZxWVNNN1hPUGtHYzR1T3ow?=
 =?utf-8?B?aWQyMEhraElMMlVaWWd0YkFpdXZid21KMnJjU0ZiUjlIbDhod1lZQjZGNHl1?=
 =?utf-8?B?c2Q3WHZScmlsU0Z0NThyai9WdXo0bngvU09DaDZVRXU1OGdqbjc0SHR6a3Za?=
 =?utf-8?B?bmh0MXlsSHJNbitZbUVQNWNyelA0RjFCem5CQkJ4VVpDRFlUYTV3ejRlelp0?=
 =?utf-8?B?YjdFcDNBOVB3K3lUTEpFanJvdTNEdTh5UXdZd05jNjEvT1lwdHIxczFWNC9s?=
 =?utf-8?B?eHBERFJvc1VCZ0Nwcm1OM2dnQlBPYmplNk1takI2bUk3T1JMUlhNKzNjb1VS?=
 =?utf-8?B?RjYvbmtHSFRoKzV2a3Zid09qTnduMUkyYWd4SmhYNGkydFF1TUJ6RnZyK2RX?=
 =?utf-8?B?dGRqdlVnSDZUUlNYM0xIRW5XcEFVSVNzNC9Qdm9IRHVBSGYzenpXZzdNaG9l?=
 =?utf-8?B?ZEdWZjZ2WFNVZFEyNjBWbGFFSSs2Z2ZVVFhXM0hiclB5dnJneEdFYkUzZDl4?=
 =?utf-8?B?Rm1ldjVFRlpiQjlKZjdycHg2SW0rU3h0ZmZsajBZNUxFbXlUNndFS2I1M0NN?=
 =?utf-8?B?cmlYcXhyenpiWXhoYk11Y1VmVEltSlhKMXo1MlE4TWpYQi9ZSEtDcm5NQ3V2?=
 =?utf-8?B?WENYUTNtTnNuQlJHU0czWjF4dnkyWDdNZWpYeXIvSDVRRlluU1N4ZUJaVkFW?=
 =?utf-8?B?ZUVIMG84V0ptK0RpL0ZvQ042SjlyYkJFcG9yUHZ0alh5Q0FZbk1ndHg4NndE?=
 =?utf-8?B?NHBFMzJwUEFFVUNZOUpiRWFoTWdzTnExaVFucGRYNHVncXFHNXZhRGZmM1pO?=
 =?utf-8?B?aVU5ZjBLZjVXTnlVdjhYS3BtQ2RjOXg5czdiVko3VEV4bHQ1NVNuRWRUSmVC?=
 =?utf-8?B?VElwSWs1ZEtxVkdPSU9YMFUra3dsZW96MVF5YTBXZ1k4c3R6dDgvemh1d2Zq?=
 =?utf-8?B?WUsvc3AvM0laUS9sbDgvY09VWkFBVytrSEtEcE9mS2hzK0cvSTJUUDlidzZC?=
 =?utf-8?B?anhDUHBQNUhGQ1VtWFkvQWxzcEVDdUJjS2VlZmlYU1hZbWt3K2hpMS9HUzVq?=
 =?utf-8?B?S0ZKZHVKMXhzaTZ4VDVReWNYNDEwYWJuY2tOYnNLaWZVbXFPdDBGTTJKbkdl?=
 =?utf-8?B?dkRscXZvMVhVOHRUYzJNbnlZdThMYzl4Z2cvc0tNdXNBUUY1WHR2L0JTZXhI?=
 =?utf-8?B?Q0UyT2NhUDVRa2gxNlZGUExDUXFtNkpYVU9KTEJDKzg2RXBMQmRzTzRmTTF6?=
 =?utf-8?B?YjFOQmR0V1NLRkg3S21KaExDZ3p2Z0Z1TlByakNwU3RDRFdCTnVlcW1OVzly?=
 =?utf-8?B?VytGdEtvWTJWUkhsNW90amRYajJHUCt4Qi9NekhocHZZV3QxbFBwSU93dFdr?=
 =?utf-8?B?eFlVdDVvdzFNWFk2UzhiV1VYSW5La1phOHBHWk0wWjdEcE5OMC9mc2NKZE4z?=
 =?utf-8?B?REkxMEFBMHpHVVRSK0FHalIxSmx5MlZycUlUczJVeWNLZld4VlNyNlBnaXRG?=
 =?utf-8?B?UnhOMmFHRUlSRW9UVWRaYXVGSWRDT05od0g5T0Q1NVlKbCszMFl5T2R1Tnlt?=
 =?utf-8?B?aVRxdklYSHdUcjVZME5HR1craHRncXhXYklYTjJaL25KRmR5WWIwUEpkNmQr?=
 =?utf-8?B?UDM3azM3YTEwZkR0ejlnTml1T2pNOXIrNDJrakJITDdYczMvZGxtZlRyc2VL?=
 =?utf-8?Q?IbCAZdFMrhZQp98yVc6yeqCxfEwuHhkJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1444.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(4022899009)(366016)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjIwYVpPYjdwb0FrVks4SUliL3JGdUJvRUpTSUNKVThXb1ZiTWJ5NFJtRnlz?=
 =?utf-8?B?eHV4MjBQSEhvbWdOeUthRWdOcXBBZ1VWU3llZXdiNUJqbGJVaHBsTkRnWHlW?=
 =?utf-8?B?NzBVWDhrWDlLQTZCWHorTmI4UkpXblVDUTVTTHg2UExHN0Faa05Mb0Vmbi8y?=
 =?utf-8?B?dW5xeDZVWm1rUGtWY041aTBCVGZJeG8xNnU1OEdJMEFZN0pVV1BWNTkwd1VS?=
 =?utf-8?B?MkVmSEhWODRvdEFQVTYvcWR0bDMrQytyaUZrZEQrbjVOdjdEL1BlblhGb0Rq?=
 =?utf-8?B?YnBhMENaNGZyVXQ5Z3ZubFlFTnFvbEN5T1FHTTZXVm55RG9PaDhUNzFORm9R?=
 =?utf-8?B?SlREaVFJUEZOeVNlc1FVeFVKQjZHNi9RcXpTRE9WbWRPdSthY2pwYjNkZkxW?=
 =?utf-8?B?bStVL3B6WEJtczUyRUNVS2NtWllhUGNpazVSNHlLR05ocysvakxCVlBiUlNh?=
 =?utf-8?B?dUlHa0p2WG1lRk1UMXlKdWxxb3phWHV2dVVHcEFPa1R2VUovdUdPcnFHc3V4?=
 =?utf-8?B?UjBjNWJTMGRSb2NscStydEhNMzZjNVdLYWp4NUVpM2traGc2b0c4UGlHM1Bo?=
 =?utf-8?B?akhWYWJtSDEvbzBtMS9zS292MHV5d3crNXRZVnZESGJpWHJQTHVvUERuWXhX?=
 =?utf-8?B?b1RyVFZHWmhTM0tHaWdOc3MwM25mblR5OUlTTFNZMTZ0WlNRb0h0T1dlZ1hv?=
 =?utf-8?B?RGhpTHZsT2tUWEx4cytWbmtrUEMyWkpvRU05b0pvSkdaY0xVYm04L2FEdVhj?=
 =?utf-8?B?Z2ZOQ2RBazNkQ0lzODNJS1AzSWs4MGJ6MVNMZk0rRjVBSndxTDA1KzQyR1VV?=
 =?utf-8?B?NnZQUXNjczhyZnpKN2QyTkNkVWh6Sm5mSFcwdFU1dGVxczQyWTBFbXZQQmR2?=
 =?utf-8?B?OGkweDRyV0MwTkt4dXZ3V01oMVdoY09rT2ZWaDNEZzJEeTZLL2ZEZ0EyMk00?=
 =?utf-8?B?VHc1WjdRRnVONk9Mdi85eHUvbndIcmhTVW0wcFJiZjc2YnphdlVXcUVZRnFY?=
 =?utf-8?B?aFJnOTFKVG5Bakx4NUMvMU56akxXcVp5ZmNHYXJKVzJaRlZvWThCUFlMUWs4?=
 =?utf-8?B?cVg3QitjL3ZleXJMYm9MaGNIcWJZWlZ6eDRxSFZuVUYwSGQ4MGZvT1ZObGIr?=
 =?utf-8?B?TXRnQzkrVWJHZ3VHWFJyeTdkQktRUStpNHRjaXAwNnZ5MGdOcTVYYmwyUkY0?=
 =?utf-8?B?dHpDcUlUMXBLOXlleUtRamdzSnoyWmVhdUdKQ1RWeHJkbnlNL281b1QrZGt4?=
 =?utf-8?B?a3dpSVVrQlJGdmZ0ZnJWZmVBY25TRXpPRFBBQk9QRk80cENyb3E4SEp5cTBn?=
 =?utf-8?B?ZG4yQlB1MVh5UmtaekNCRGYrY2g3Z3J4Tk00b3hwQzRlR3FHV0xWVktEcktY?=
 =?utf-8?B?bDlCaUhHNWdoSGUvMksrMFUzUkNCNWs5ZzhBUVR6V3ZTRTBUbTFXUSttVWRm?=
 =?utf-8?B?aUs3Ykk3YkpCV1pxOEZha01RT3c0aGNMNloya1lCYjhZelQrZDd6MHhjcEI5?=
 =?utf-8?B?UGIyL21DbTFKbWJKemV0RW5wQjRyM29nTjczRkJHM3h5Nmd1YkhOYWZNT2xy?=
 =?utf-8?B?bEl5RHJ2R1pORGV3b3dXcUdvcUdwVnJIYnlvNEEvV3QyeFRiMWNQanltaEpH?=
 =?utf-8?B?ZHV2ZC9WOERDZ2ZQM3NlNWpueWdwei9hZllCeDFZQWFQTmE2MDJnNFljWXNO?=
 =?utf-8?B?M0lvL3cvc21QazA2SXdFaWF2QmxkOTBUZmx0ZTN3NzZRUlgzY2JHVmZUZnlH?=
 =?utf-8?B?OGlodGtTZ0U5U1NOU2svSURoRnQwaHFHQTMxY1dJRklkUDB6Q0d6NXowbWdC?=
 =?utf-8?B?eW1GQXQxR3JabkoycUxlVytjYkl3bDJSakZkZ1JTeDVVR0VOT1ZZVXJXS05n?=
 =?utf-8?B?WU5wdEl3T2lvODBnTHVEaERiMDZiZ1RHbVNIZDZaOSsyZzhOSkRLQ2xHVWJx?=
 =?utf-8?B?cHl1K2x0bmpYVklxREcwOHpuUDI0RzJKYWtySDhtNEZWaytmYWgzd2UrWlQ0?=
 =?utf-8?B?VnpDeWhNT05PYUtNbm1zTmlQRzlXa3VxRFVuZWFxVHh3YkdqSUY5ajQySVFT?=
 =?utf-8?B?a3pNNmR6UmR5QkJLVW9ERm5WY25YZGFzVE0rbnNLNWQrMTc1dDB6R1lBd1Jx?=
 =?utf-8?B?TjFkSFE1RDlPLzQ3VE0vdk84eG5YMGQ3ZUZON3pQZFNOcStIeUZCQ3VyOVFh?=
 =?utf-8?B?QVpua1l1MkZTMHk5SExwdXAySTJqN0E5b0lyaTZ3c0FBZkNXQUptaktvT3lp?=
 =?utf-8?B?dTA0K3YzNWN5RkpMcHQxanVkZzFHRG1WbDJia3JiS1dTZkJTYnNSNFFMT0ZY?=
 =?utf-8?B?SWNSaU1wRlBqOW1qNkwyL2pmTitLcStoUVVzVUNxTWg1a2dSQWRtUT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc8ef21-c3ab-43d1-1ee6-08de518765e5
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1444.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 03:05:10.7269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjTypnCRfp70kAjCpSbdtRtPF8OX56uoxZ4ikt+mm92/q3HH7saQhTGNzOjipDFt5X1S1S9WbevGzdMULDOogQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1641
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



On 9/10/25 9:06 PM, Daniel Schultz wrote:
> 
> On 9/10/25 15:26, bb@ti.com wrote:
>> On September 10, 2025 thus sayeth Sverdlin, Alexander:
>>> Hi Bryan!
>>>
>>> On Wed, 2025-09-10 at 07:53 -0500, bb@ti.com wrote:
>>>>>>>>> The watchdog requires to have the MCU ESM error source enabled to
>>>>>>>>> trigger a system reboot. When booting HS-SE (security enforced)
>>>>>>>>> devices, the MMR registers are locked again and all write commands
>>>>>>>>> are simply ignored.
>>>>>>>>>
>>>>>>>>> Unlock the MMR registers again to successfully enable the MCU ESM
>>>>>>>>> source.
>>>>>>>> I'm just curious, could you please elaborate a bit, where the 
>>>>>>>> registers
>>>>>>>> are being locked again if they are being unlocked by 
>>>>>>>> ctrl_mmr_unlock()
>>>>>>>> in board_init_f() before enable_mcu_esm_reset()?
>>>>>>>>
>>>>>>>> Is it TIFS firmware?
>>>>>>>> What else could be affected?
>>>>>>>> Do we expect to leave General Purpose Control Registers unlocked
>>>>>>>> when we return from board_init_f()?
>>>>>>>> Does it mean that the whole ctrl_mmr_unlock() has to be re-done
>>>>>>>> after k3_sysfw_loader() call?
>>>>>>> I really can't tell why those registers are locked again. I 
>>>>>>> figured out
>>>>>>> they're only locked again after loading the TIFS firmware on HS- 
>>>>>>> SE devices.
>>>>>>> So, I also assume the firmware itself locks those registers again 
>>>>>>> as part of
>>>>>>> a secure/security feature.
>>>>>> Hmm yeah this is likely a bug or a config issue. Ideally we
>>>>>> (U-Boot/Linux) should be in complete control of when these are 
>>>>>> locked or
>>>>>> unlocked. TIFS or DM shouldn't be anywhere near these MMRs.
>>>>>>
>>>>>>> The A53 SPL will unlock those registers again, which will be 
>>>>>>> permanent. Only
>>>>>>> the watchdog is problematic because enable_mcu_esm_reset is 
>>>>>>> currently only
>>>>>>> called in the R5 SPL (config only enabled in the R5 SPL defconfig).
>>>>>>>
>>>>>>> BTW: We have seen the same behavior with the AM68A/J721S2.
>>>>>> Hmm this is strange.
>>>>> Thanks for your assessment!
>>>>> Do you know who can be contacted at TI regarding this possible 
>>>>> problem in
>>>>> TIFS firmware? Maybe this has to be fixed in TIFS firmware indeed?
>>>> I've started creating some noise internally to see if we can debug this
>>>> faster. Most of these teams are fairly insulated from the outside world
>>>> and can only be reached via e2e tickets.
>>> Thanks for looking into this!
>>> I read it as if we would not need to create an e2e ticket for now?
>> That's correct. I short circuited the e2e process by creating a bug and
>> messaging a few people internally to jump start the process:
>>
>>     https://sir.ext.ti.com/jira/browse/EXT_EP-12916
> 
> Just for reference, I already opened an e2e post some weeks ago: 
> https://e2e.ti.com/support/processors-group/processors/f/processors- 
> forum/1511852/am625-am62x-hs-se-spl-cannot-write-to- 
> mcu_mmr0_rst_ctrl/5813164#5813164

I would like to know if we can proceed with Daniels patch.
The reply in the E2E post suggests more or less the same change.

> 
> - Daniel
> 
>>
>> ~Bryan
> _______________________________________________
> upstream mailing list -- upstream@lists.phytec.de
> To unsubscribe send an email to upstream-leave@lists.phytec.de

