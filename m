Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365DC2D0CD
	for <u-boot@archiver.kernel.org>; Mon, 19 May 2025 10:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DC6F81FEE;
	Mon, 19 May 2025 12:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IdBUofkw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F7C582A9E; Mon, 19 May 2025 12:30:58 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::616])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7BC781E72
 for <u-boot@lists.denx.de>; Mon, 19 May 2025 12:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xXDE4Yx60/xWGZvYSNRgHFgfc0ClgWLAhSsJelZ2dn12XPndlBpasK6WnG3VrkRWErB8fB2vFahu7rJB/MhIqFAAqmu3DsY5GFjZpmmfAlq2EBjLBawy/CX4XO98Vt5ReuDnqrY+su19PK7KB6Qd+L8mwuP+Nf0NdQjMJWEKh+ESLLW7qXfeNWL2N1vEAILYG9Lm2lorh8TnH4Cyv9SL1p50qGdUG+K2Qk3yNiUB55qMtc2/PI/05WaayF8/Ru1Fp6OUZMY7j+zpOPf+tVNRwCWSn3RYCvMbQG/UxfiZcwycHySwdIVwOMKGb//8D2sGigoZPkP3qf3itLuUKOQheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ncLRvAke25ARKklZjAEjx8/TKiMP/XN+AghdtvIdS8=;
 b=YNY8EPjjq/+d/Ov7wwIewbFJ66c09GvmSnOfq2g11IbiPr7kSyURR2IFic8DX1T/h7/8ixZVcIw1qNSYzhcxixwraQWTGOPWjlXhJ8aNqJbBpnDra9yX3yYCQrEKPti1PX+G3b0JDPAuGEmWSLatPjZQjoe0aL8lE9ipqmZwYDuT5zi7dJ2VcjnHiDX2Hiu8YwaiH7Ml+pLKkn5vS0snqz4nbGwtKjxkwJftm4mBQNDwsxqg8ShZYzZ2PLYM3GhGfFNdNWTbTxkRtnAZS9ZZjOyUaqPSR0eTQ3D3KMZ0zaqL3RO6czqjOasG6KYCrOG+kJw4sgpYlZe4X57gYvA41w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ncLRvAke25ARKklZjAEjx8/TKiMP/XN+AghdtvIdS8=;
 b=IdBUofkwhN8rSF9KZ06OvGZ5/c/23b+0dN/jkAObTyl1+oPFNYSK3MxK9wpR++07xMGHaSw7IiUk7o7fwanyOWYidyR59gkTiyBtcMdge0w95yQO9mabrFfFOy/83w3xPi4tm0RCiyrthIz5XI31sRoavJpMp5RbAx4rPruV+5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM7PR04MB6999.eurprd04.prod.outlook.com (2603:10a6:20b:de::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 10:30:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%4]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 10:30:53 +0000
Message-ID: <55d8bcb9-9f49-49e3-a0b9-02b7b7a7ff12@cherry.de>
Date: Mon, 19 May 2025 12:30:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Initial support for Wiznet W5500
To: "Verdun, Jean-Marie" <verdun@hpe.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 "jmverdun3@gmail.com" <jmverdun3@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <20250511180207.42945-1-verdun@hpe.com>
 <20250511180207.42945-2-verdun@hpe.com>
 <91db507e-8fab-42cd-88dc-300372ceee68@linaro.org>
 <5dc908b9-6659-47bb-bcad-134871ecac28@cherry.de>
 <DM4PR84MB197689F8308F8FBB04CF96CBD690A@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
 <8e930859-c73b-4bd8-b58e-474b3e70e15d@cherry.de>
 <DM4PR84MB19761284E20ABD1F1F8ED8C5D69CA@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <DM4PR84MB19761284E20ABD1F1F8ED8C5D69CA@DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA0P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::21) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM7PR04MB6999:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a42dca8-c791-4599-2c64-08dd96c03bad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1ByTTJuUSt0TlE0eUFEZ1dldzJqYTVhK3MzTHBxakp0bkZEbkRna1BjTFlo?=
 =?utf-8?B?UkVlZlN0dlBIVHlKNkp2MnE3R00wdGFLdWt1bGJFZTJwa0pibFZkQ2JEVXp5?=
 =?utf-8?B?am1iUlNIQTVhaUJTaS95Y0MwZkM5T0c2VnVFWlc0OEZxSUhSelFZdC9jdk1K?=
 =?utf-8?B?b0F3Nkh5N21NdWxwcWdjTFJYdVJwdFJ5cmZLc2JiSFZqWU1XVE15Q3NseGxN?=
 =?utf-8?B?S0U5TndpWERMUDR0Qk0xUng0SEg2c1FLdWpBeG1XSzNwRDJlRXRyemgrZUUw?=
 =?utf-8?B?QXN1Uk0wMHJwdEZiWU8vY3JucS95alkzcHoxb2czOHdaSm9UcHBjYzk1Z0pa?=
 =?utf-8?B?bHNjQWpsRTBwU2lyNjhuOENPSmtIZXhxbEFiT3NNSk11bnovdDZDejVZY0Zi?=
 =?utf-8?B?ZXUvalVaM1NWU3ZyT0pmdWtLWEtPMHFiTW0yVlNHejZWbEE0SnJtbTN0enRJ?=
 =?utf-8?B?TDMrdzhsY2N1VFp4SHFkOU5hY0E3UXF1eUhaTWxjV2k0WVlaNmlKUnVER3pC?=
 =?utf-8?B?OUQra0UzZjVYejZrSU9hNXViZUFlcVVVaXBtMTNXR0MyQVRUWUY1ay84Q2hw?=
 =?utf-8?B?Nm9ydUpUdXVwbHhkRk94MmpjSjhqUEUwOFF2WWJQeVNPUVZVVW1KRjF0UXVE?=
 =?utf-8?B?cGliSGs0MnRwTGpnenFtbS96UGo2ZkRvQ1I3RXAyNkxBVUR1YklaSWZBTEZ5?=
 =?utf-8?B?WkJBQk53bWVKalViZ2h4aDVlMlkwNmNJL3V4OEpabnoxZlFSVnZGVE5oT0RX?=
 =?utf-8?B?YWdsdEpQRVBRVmJTcjhkck1KeC9rNDNRUFdWdkErSWZqajBqZVRpWllwb3ZW?=
 =?utf-8?B?UUhkalJNcWl0Qy9JK3B3ZXh3M2VmQ1VZRk5GMCtnSGRTTVZKZlE5S3FBcGF1?=
 =?utf-8?B?NUtCZFpQU1crQlp2SHFwMjRWQ2dvd094KzlZWVBGZi9tSDE1SXVlQ3RPejBw?=
 =?utf-8?B?YXhIcGVyVlFaTE5uUGhxWm9jT2g5OGRUQ3pJWEplQ1pjQVdyQ2JFald4amQr?=
 =?utf-8?B?WFJSc3BUWUNrK0l3bmpSa3FpWDhORXR4R0YwWVBZVXBKc1ZWUk5SbDdtYnZp?=
 =?utf-8?B?UXUwRVFQV0RDbU9hbWF4YXhMTUVFZGpUYVEvZWpRQ1pVTW9ybWxmbHJvMThs?=
 =?utf-8?B?cStPdCtFT2RRVkZYQmJiT3ozY3dQMVI1UVlRZDhiS2pHY1V5VWNZMTJTejNW?=
 =?utf-8?B?Y08rc0tTWFlSa0VhUVhjWk9iTHNzb1ZwRzRod3I5bllLdjdza2YxcURleXBK?=
 =?utf-8?B?NTVwVFRmS1dKdDRXWDVEMUdsWjN3SEpXNGlIcWEwVCtRSCswU3RJelhoY2py?=
 =?utf-8?B?SGoxRm53QktrV0xoY21FWWl1UTlvYWt3b2ZKS3FoOUhobE1uNTVjTzVnbXpu?=
 =?utf-8?B?TDNMOU4zN05qeDNBZk9rVzdjaVArSkJybEJSMVduUGxxbmRveHE0OVVVcEgy?=
 =?utf-8?B?WEFRWmxtczZybEc3TWpUdXRmV2E2cUd3VmZYbW5SeHkxUlVJL29Ta0ZiNThE?=
 =?utf-8?B?ZDk2VmY1TGVEdGU3MCtvUXJjMyt2ZWJJZ1ZQU2tHOE9zckRjMmdnNkVsdmly?=
 =?utf-8?B?R2dWbmNSbG1pcUtuNW5kT1JscHlXYUZoMnB5U2RvbTRGNXh5K3dDb2g1VEdV?=
 =?utf-8?B?bFV6QU1MMjVCMFZhdEZIMlJaN1p1cUR6a0pyMjdFMGUwd1c1NzlQeko4V21R?=
 =?utf-8?B?U29UYUF6cDFWZlhFTmNzQ2h2dHVwR2hMQ3lKakdKMTIwOE9uamM1ZlN6d05F?=
 =?utf-8?B?bnJpYUhhRWNVOWRoOCt4cVZQSUoxVEV4SmhQV2g4VnZuUVAzd29ENkhxZThW?=
 =?utf-8?Q?6AWIMTF2vEuDfaOnaNKNFjsvbOsRMr0zy2xEs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVRqYVMzTXdOQ2JnSC9INmNERytYbjJXRTRlZnMvcjVlNGtVS0RtL0pLeThE?=
 =?utf-8?B?NDJiWGJ4a1dzeUN6MjdZLzhUQk1zMEtSMDMwWENmMmUwSXo1UnNOclplQVFM?=
 =?utf-8?B?cW90d1NQcFJmVVl1N096RDQwNnA2QzREM3BMcnl6ZTVFblJ0V1BLdDhBUk5Y?=
 =?utf-8?B?M2tiUDdmM1lOczRQSlFzamgrbHJpVS96cHRscTkydzg3UVdiVXFSV2xjYkhP?=
 =?utf-8?B?VVh0eFJnNmZWUzFrcGp6MVJ6dnNOQmpVc2tDYjJvWFFlMW8vTk1IamU2Rzds?=
 =?utf-8?B?aFMwSWR1allmamNWSzdFSWYvNDNTYlgvTVNXQ08yNEcvSENEbjVCRm5WUHZu?=
 =?utf-8?B?K0dDdlEyK0xNcnB1TVB3TnlSOC9UaWtaWDgvc3AwU0JIUXNFa0U0VGZkUk9V?=
 =?utf-8?B?MThMdTdtNnB0cnBBMnpIMXkxYjhZUVF6QURqV2VHbzI1Mkpkb3duK2J3bXBm?=
 =?utf-8?B?b3lzaW1JZFJjelpFU0Zyci9OYkR4bDNpR3NveUFLNE0yZFp3bkZ1eFh4VXph?=
 =?utf-8?B?djNQMVBPRmZoNFZDYi8ydzluZDdpN0MzS25VVERBUVNMVEY5a1FEWTN2bDlh?=
 =?utf-8?B?Q0xTbXBDaVV5NWpPay81QlloWXJFSW1qVHlyUHdaMDBUK0ErM1EzR2o4aWdI?=
 =?utf-8?B?YUZjUGdvR3p4aDVYYVVGNWUzT0hxYXl4ekFmelVYME96Q1g1amc2b2lNT0xi?=
 =?utf-8?B?VndRMW04bTA2R0pyaVlRdjN1bEpnc3N1aXk2enMrWHJIenlqZjhCNitjSkE5?=
 =?utf-8?B?S0krUjM0RnZrTWtmM0FSd0ViMUYzWlJHNG9SMi9KOFNySlNBZnBlOHJ1SW5p?=
 =?utf-8?B?WURWQkhIZGdTUC9SUXRsV2RkbnI5VkZwTU82VEpGU2lHb3JrU0phVHUvVUh0?=
 =?utf-8?B?REticTFuNmtKa2xMY1hDZ0s1a1dyYlhPRFRrNHk0NXRIT0VoWGVXai9KaDlm?=
 =?utf-8?B?a0ZmWDVoTlQyMXVybUJCeUhRZjhFSGlkQWdxTEJlQytySXhYbjBiRUtuUFRG?=
 =?utf-8?B?UmUxSGxVb05ZNmptdGEyWi9kOFNuZk5BeXlMem8yTElvWmVDd1pnakNraHhW?=
 =?utf-8?B?MVcrVENGaUVPc1dyd0JHbTExcWQyekZCR3VzS0JyOHNBcGVFU0h5UTI4V2Ir?=
 =?utf-8?B?NHhuVzA5cExjd1lQZU5hNjBZSFZCVmFTeURCU2xuWU12U1VIZW5GOVRiM2x1?=
 =?utf-8?B?Rit1eGVFSTBCUWpGdThGV1BwOFN6Zml5RHVxNDFtakllRTBhcEs0VTQrazRl?=
 =?utf-8?B?RGw5K1AwSlJ5S2s0UWM5T0JTOTZSUVEzQWJmSDR1NmcvazJ3eTA1K2FodkxN?=
 =?utf-8?B?bVd4ay9KaSs0a3JBLy9aeW1uZElNWWtNdHlSYjFNeWw1eGFBcmxIaXpXa25D?=
 =?utf-8?B?cER4QktGeFZBRDc4bXZFSnNtMzJ1UU9MVGptaktvdXpnc2lJKy9QZzFUTklw?=
 =?utf-8?B?eFBhZWp3U29zS1UvRm1TVU5qMURMcGNmVzFTMERKRFhCMjBDdWdZamdhMlgx?=
 =?utf-8?B?T0FrK3J1WVFJZjJhNyt1S3ZBNUZ5bXZRNTZBNEhtYm9oNVRPYU1PblU0R3Z4?=
 =?utf-8?B?NGZkV3piajZodWc4emlUanhpT3dqSU9tYzV1UnQvWFpVWXRmRzZTVGcyMmpr?=
 =?utf-8?B?RVpXUnoyQWNwaFBLb2tWMkdxTitJbDdSRTZFWkcybGFOWjJBZkxJbXhUMWw1?=
 =?utf-8?B?Y2FzaDE4UCtLNnNBTjVtanpIRGIrRUlnbDRnWG9QaG9xUllvL0k5ZCtzM2NZ?=
 =?utf-8?B?cFhFMGtqdGQzMUlZU1ArMGozbmJFUnh5NHZSQkw4TTlIQkU2TUNwVUg1WFR2?=
 =?utf-8?B?bXozeXIvVWwzemlkRkQ1TS9vdW1WSkdJOUk1K1U5RTZENDhHcktSVDVZNEps?=
 =?utf-8?B?RmlhSHB0c2VMK2lwcWpzTkdyQWZtWDFGcUIvUEhCVkRFM0lPZGYxZCtyRUdT?=
 =?utf-8?B?Tm9uN0lTWmhOWTJxZ1pia0wyVlF6NmFWQUMxVjlqS0UrVEtTRkJSTWhOMGpG?=
 =?utf-8?B?Z3N6K29oYVYxdnVkUjFqY0ZBVGVRSUZyR2dpaElHTzJhUjlEbnVUWGYwRmhZ?=
 =?utf-8?B?OXRUNUROYUdTWm9oQkYzTnhZckdaTFJmL3l5UEQrUEVha1ozODdIVSsvNlZ6?=
 =?utf-8?B?bTJLKzg4b1hUcVlZblJISUtCd3F2WWNQT0RWc2NXYkdlcHNrRTZ6TmVRbEZT?=
 =?utf-8?B?UXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a42dca8-c791-4599-2c64-08dd96c03bad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 10:30:53.8772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kYW+Oa7aGIWUgwTfVQxKWAhbdHobBejLYw9UuPlAMS3s/vjF8WL4RPH+bhLBNOYnZ3kJQAEM6/4FuVJW2cFNbbLH0i5db3qkoMH9RSbOWJA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6999
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

Hi Jean-Marie,

On 5/19/25 11:05 AM, Verdun, Jean-Marie wrote:
>>> Fair enough. You could have the same ternary operator to better match
>>> what's in the kernel.
> 
>>> Can you also reuse the macros that are in the kernel already?
>>> W5500_SPI_BLOCK_SELECT, W5500_SPI_READ_CONTROL and
>>> W5500_SPI_WRITE_CONTROL seems to be of interest?
> 
> I will check it
> 
>>> If you do that, please also update the kernel code to use that :)
> 
> I have a new version of the driver code without the _spi_read* _spi_write* calls. I think for the u-boot version it will be ok as it shorten the source code.

Since you're already written the code, maybe it's fine to keep it? I 
assume the split in the kernel was done so that it would be easier to 
add support for other (future?) chips which would be able to operate on 
different buses than SPI? Though it seems that all their iEthernet 
product line only operate on SPI 
(https://docs.wiznet.io/Product/iEthernet)? There's typical interest in 
staying possibly as close as possible to Linux kernel drivers so that 
security fixes, bug fixes and improvements aren't too difficult to 
backport to U-Boot. But that's the maintainer's and contributor's 
decision to make :)

> What I loved to do first is perhaps to get the new patchset upstream in u-boot and then change the cmd[xx] logic to a structure in the linux kernel and u-boot ? Syncing both might be a little bit tricky. I also have some performance patches to look at with u-boot (udelay call with a value of 0 is slow and I know useless too)
> 

Typically what happens in open-source projects is that once the code is 
merged, the contributor disappears :) So there's usually reticence to 
merging code if there's some on-going discussion. Here, the struct for 
cmd change suggestion is not a blocker as it's mostly cosmetic anyway 
and it didn't prevent the code from being merged in the kernel (and it 
isn't a bug that we should fix in the kernel), so that's fine with me 
(I'm anyway not the maintainer so I wouldn't have the power to veto this 
:) ).

Cheers,
Quentin
