Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E2AC35FE4
	for <u-boot@archiver.kernel.org>; Sun, 15 Sep 2024 12:45:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E0DA88DB1;
	Sun, 15 Sep 2024 14:45:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="FfyPenf7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9598843A; Sun, 15 Sep 2024 09:06:04 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2071b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::71b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C4F88D91
 for <u-boot@lists.denx.de>; Sun, 15 Sep 2024 09:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvFmdkmmHCTDKru2T4UsJFWc+retnBpqbHpPVWA7dB1ajIofWQDBjEKkjKLIzZPXFo9FRJPT2Nrnsj/nCkAwOpkORJ0SIYP/dF+YoITi9c/I+P5WKhUanN4oDb789Pv2ZyYO0EhEFVkMeahbDC4ZQ2Hswl1mxEexMIg1r4FBJ/A+/caRwiFzb3fNM/YwAQPyoZTaH3i4TqN7iKJMvomkD+qD6Y34aFsV5VGa4pVbsd1+m4e/x1A9QKJxFWPszgMi3RqoIrmVq/5wIlVFP8QPifRC722sPtMHBR/ZqtJHAKKrFtt3Mm9RaX+LNqtPBjzmhrVK3zMik4fec7udCcJ0zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kl/L347rFcBIycaStVC201Ma26EcpLruAEkZ5onxJAo=;
 b=SlpDOVL2Le4LFzSFD96AQOh5W20Gg4O8XvE6fLmLsBRDbKIiPPWZkMVwit+ruQwXXjr5/oizQMVGSm2+iYW1M+iKMUPiIo48s0tAtZfVknCg0h+aIkGcfe/4FN4KXUjq7Lvc67P0v+2KNbgaTBdwL9wyOKdXs0gSAMKx1UcaomYqbr+8wge+zpSIs/swOCh1z0fPe4dUUTzrUDXXgopvrwSivaLUHnfavWZpgxE7Hj+GyKl/PNUesINUXeyJuPI5WxFORCukH8RmfQIT9MejIYHZg/NL554HtBwJHi6o9v/6wV3hw33SFhNI0dOzBSGYGSjLHncnz1eG/xwKM9F/jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kl/L347rFcBIycaStVC201Ma26EcpLruAEkZ5onxJAo=;
 b=FfyPenf7I2uXJ0LoGb3CQ9+mJkfIDiH9oJi5RHvz4oTfmjcBAvloCxCePhlXTsj9EM+I6oKQNUkUhjHsgiSXxzozFKnVxwRmL11XGBD9659QGEfx9baaMewyclt6/OiQ0PD87nrCrD8/4eIID8Y0cgEsDPL2hKrJHfsRY05mpOY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by PAXPR08MB6366.eurprd08.prod.outlook.com (2603:10a6:102:153::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.11; Sun, 15 Sep
 2024 07:05:59 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%2]) with mapi id 15.20.7982.011; Sun, 15 Sep 2024
 07:05:59 +0000
Message-ID: <680515ee-58fe-49dc-b7f3-53478d23b9c2@genexis.eu>
Date: Sun, 15 Sep 2024 10:05:51 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 10/12] net/netcat: add netcat over tcp support
To: Simon Glass <sjg@chromium.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Francis Laniel
 <francis.laniel@amarulasolutions.com>, Anand Moon <linux.amoon@gmail.com>,
 Marek Vasut <marex@denx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Sean Anderson <seanga2@gmail.com>, Baruch Siach <baruch@tkos.co.il>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 Richard Weinberger <richard@nod.at>, u-boot@lists.denx.de
References: <20240909222720.2563118-1-mikhail.kshevetskiy@iopsys.eu>
 <20240909222720.2563118-11-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThqbdJ6XuivxXBvc6N1rFX=oZsp-Tt-2N_c11y2Aj1JOA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszThqbdJ6XuivxXBvc6N1rFX=oZsp-Tt-2N_c11y2Aj1JOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: HE1PR0401CA0120.eurprd04.prod.outlook.com
 (2603:10a6:7:54::49) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|PAXPR08MB6366:EE_
X-MS-Office365-Filtering-Correlation-Id: d20d4f08-c006-4802-1d86-08dcd554d9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WXVDM3c0RG9lTlJPa3M0NW1wM0ljZ3ZVdWRUY3VrSGVkSUZrcTlQVFk2Z0U2?=
 =?utf-8?B?Q2ZWZURmNUpzTHFxelRRVU5rWDJuU1NSbWU5VG9EUHp1c3FiMUpJMDhCTENp?=
 =?utf-8?B?NlRyZE9aZzU0b2hZdUxET1pMVTB0MWl5K29hM1BRQTRSanFWVCtRTHJickcv?=
 =?utf-8?B?cm1VZ29PTGxETE5GNEN2UWR4RUx6MS96c0pBenhRTWNhZER1TUV3YVNUY05S?=
 =?utf-8?B?SGMvVUdZYktJWlJ0dFFyMWl6cVExOWtQUU10NGUwV2Jsa0tBTjcvemJQZkJ0?=
 =?utf-8?B?WTVHbmNGNy96ZUxqS3RFZHNJcjM4Rml0ei82b3FVZlNKaG4zK2UzUHBQc3Vy?=
 =?utf-8?B?eWNtcVBiZTRJTjRiS3IvSXNkWCtSZWlqTE52VE5idDdYSHFHS0hOdE5memN0?=
 =?utf-8?B?b0pRbCt0aHpwNTVGYXZCMkNyOGZpMU9pbVVRZDBySkFHcENTVmo1T0V5bkRh?=
 =?utf-8?B?NC9VSENNUXZoblo0NzJXRTJYbWN3RzY5WTVpeWY4S3JQdHhkK3pacEFHN09L?=
 =?utf-8?B?WStTWnZLdGxjd1FBcVRvY1kycHdCalA3NXV0TFlsL3ZaR0hYazVhcTU3cldz?=
 =?utf-8?B?ZlhyNlIzUXNpVVJSd241TFNQdXNYSXh0cGNBaTdxdU1OVkgxZkd5RDk3c2s3?=
 =?utf-8?B?dEl3eUxvWlJvaVJSMXpBcWtTNWdLVTZCSUk0dlpwWTlUTmZ2UWdvdmYyeTJh?=
 =?utf-8?B?MHU4YWtPTXdTSk5ua2o1TG1YM1haT29vbFdodkRoNU9QN05iRVVZNzNQUzY2?=
 =?utf-8?B?UWlmb0VOMjZ4ZU4yazBENnFDSEx2eURUcllLS2RlNURqYm5EK214Q0NNZ1Uw?=
 =?utf-8?B?V1gwKy9kVDhkYTh2L0o3d1RHZWZZdTNqSDNmSGpWRnR5a1ZjU2VTQjZFTjdN?=
 =?utf-8?B?N2hReWRJT2hMVy9ld25ldTVUcWJPVHdXUkxGY3FsSzJWSzlaOG5yTlhiUHhY?=
 =?utf-8?B?TnZsTGkvM3pPeFVQWWkrMm54THBBOVpuRmRpOEk2d1VHWlhOeXlQMEpxdjZT?=
 =?utf-8?B?Y0VFUDVRck9ZbDBJZlFVZ0U1VW45WUZHTjZ0aHFMYklnY000TklhVTVxbmFB?=
 =?utf-8?B?ZVFaRHNPUy9ia0xpdk1tWXdhaGp6Qk15bE1aSFBvZ3RmZWJJenh1cnROWlN2?=
 =?utf-8?B?VUdXQVB4bXBrY09HWHo1Tktva2JTdHJJZXdqbE54Y0dlZm5nd0x4QTFkUzJK?=
 =?utf-8?B?cEF1aFNKMUh4V04yU2Nqd0dZYldzV2NtNFdmOXhQb2t1NGY5a2VQSHpOSFpB?=
 =?utf-8?B?M21TdXY3UFFSOVhrWFpWNEJkQUhsUGxaVlBNbFhpUE5oMUM1SXdScTIrMGI0?=
 =?utf-8?B?Smlsa1JVVHNkWUJqUi9iT1k4MENMU1Z2b3R5L1BCejZMT21nUkJsTlJQeXYv?=
 =?utf-8?B?bDNXZUdsd1VLOGl1VkI1d2xxV0hHWGFSMjMxZlp5dzhFWGZrOVJxY0dVamM3?=
 =?utf-8?B?dTJzYlMxNWROQTNramJTTm1JNndVdUFZWUsrY2xJdkJYSXNYOUpJWSsxVGxP?=
 =?utf-8?B?NDRodEVaSWxDcElZQTBFdG00M1htQ0dwYzJUMUpaMDR6S0JOclBQQ0dVbTdC?=
 =?utf-8?B?cU0zTVZNWmp4dmI1aUlFOVNmNE9MWjRyOW55QkVhYmJUendtT3JLamFtQ0g3?=
 =?utf-8?B?SHFqUnhTTk1xMStYbThlOW1jcDFKZmh2NHFLdFB6ODVDNFlkdTNvaklNditY?=
 =?utf-8?B?Vm1ZN3I4Z3oxemVLL1ZFaGd1Zld1K0YwNndOS1NIOEpSRElyWE11UEs5Z2dy?=
 =?utf-8?Q?GsjcH/FwxEZRQQKzCY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGduUzhjWTYzdkhtTG5vZHMyUElEZUtWY0oySVNGcExIeGQyRUR1bkhVeWJk?=
 =?utf-8?B?SDJJMlNaT3h6dzRKM0VYeU1QQ0N2UkxtQVNuWDI5bjYyR2htbVhmN3ZFSnZW?=
 =?utf-8?B?L08zYUlFemVqQ2MrN0U5d3E5MjdvWFowSG5BakxnN3VmbjN6UXI3U1Q4N0x3?=
 =?utf-8?B?TGlSNHAyNXpGOFhwcHVMVWRMSEYzTlc1VUtSMHB3ak51UDdLdEhuT2M0RW5u?=
 =?utf-8?B?cElWRllNeTFxMFhHMDZvaVBSNkRtU3NuM1o1TlplZzU4UDRSQmlaOU5Pa2Fi?=
 =?utf-8?B?Slg0WHNMQlJaK0M4aUp3RU5XeXM1dGR5SmhndXZ5YjltM2hqbERwZ093WjZO?=
 =?utf-8?B?Mzh3UjhRNlZMS0E2eHNMYVFuRk9KbitxNkpMQ2N4aXFuczNsUmxBTEF5NXBM?=
 =?utf-8?B?bTNjMGlsQjY0K1hWVXdoTHpIRVk1ZDlMRGRQZVhxUy9iL1ZNRElpSnVHd3U0?=
 =?utf-8?B?K3VEczRod0NRTWpOcDRpeUlTQnBZSjRtMTZvNXJYSFU0RHpSbE40RnRuQ1RN?=
 =?utf-8?B?Mi9wZUVwcUc5akI1OHhYSVdTenZuaWY1YWZXSTFNNXZEYlAvN1Y5MFgvZllt?=
 =?utf-8?B?bzlmWmw3TjZHNEZMa0xudHVKclU1aVA2SVEzNENsNkllUk5GNkJGelNNaXYw?=
 =?utf-8?B?aEUrYm1pcFZLYVF3RWFqeFNrSlM0RmlXcWt0dUJuMG9iK3ZIeG9UNThqNU5t?=
 =?utf-8?B?eE9KMUxPcTc2bmh5TkIwR1k2cmxqNms5eUdRSGhhVm81b21yNDJQbkJyUEV4?=
 =?utf-8?B?UkI5dlFCMDVOQm1UVFgzWXIybnJCRy9UblJ3QzJqZlltRHpJTVAwazdaSGFG?=
 =?utf-8?B?Yit6YkdWZUtBVXdDWjdKQmowYjMrSEZUYWtvZ3E5NFlVQjBtTFRYWUVjaDZj?=
 =?utf-8?B?Q2hqaTNBckdOdHltc0swc3hTb3d6aEtBeDZDMUxHcUxwMDhybUIzTnh6T3li?=
 =?utf-8?B?SEo4UE5kbS9wejlXcTdoOVZ6Z2o3WTRZelhXam53bE5tVkJuUGpoUXhocWVH?=
 =?utf-8?B?T2wwVWwwV1kvTkRacmpnZkZ6UzNmdFBwUTZ1c3V0VmdtdXJucFpYcmxjNzZt?=
 =?utf-8?B?eitOeDNBZmhrclJYNzdMYjcwTmNGUnQ3UktiTE05WWNWaUJuOHFOTGpGVEg2?=
 =?utf-8?B?cjdZZHUzbnFta1dTbFJNRlhMdXk4RE83dkFXRUUwbnlreTREYTU2bWViWWVo?=
 =?utf-8?B?anVuYnhwc0J3cDdmNDNQZ1IyNWM3dEdxeW5qcEhCYWhtLzFOMWN5UklNL3c3?=
 =?utf-8?B?aTlUUnNxVGtrMytrQXIwMllYN05KMVhOdHpaN2pVUElraHB2YXJDV2xRUDVy?=
 =?utf-8?B?ZUJsRFNxSnhpQUdGVVdSOXpZaFhsOEpIeVdMYnljUXpwZm83YUhHQ20yVU9s?=
 =?utf-8?B?QjVLb1Zwa3hyQU9ZeXp6bjlhMitmNmxETFpOb2hVaEdkbXhIMmdqRXlsbHhz?=
 =?utf-8?B?ZjdzWGlRK2Q5MFNDQWlnZG5tTEpmbDJOUFNWa2JuMGdwZHFWQ1FSWnMrMlRR?=
 =?utf-8?B?MVA0OVhHUHczQnhWT29GMWNKdUNSeDZvRTRKeUhJYXdBRXZHQTFLaVJWbUhR?=
 =?utf-8?B?ZStCZ0ZvYXQxSzBmL2ZEOTFIYW84ZCtUMjNMRVV6dFUzOW9COThkYk5rU1JI?=
 =?utf-8?B?RWNJUk13TkVvN3pzZ1psNVdvYm5HSk9QM3VSbHpKcURtZ2g1V1Nmci84MGEz?=
 =?utf-8?B?S2YrcGNiQ0FHOExJT3ZjV25oanRqYnVHZG9NeE9qM3B1MEp1Tlp1dVk5R016?=
 =?utf-8?B?VjdVVmE0S1FlYTl1NGdCVGZuaUtoQzRMMDdkL2hxTXk3dFZGNDRxMG5SbGNE?=
 =?utf-8?B?cHgwMDlvYm1XaDZtM2hnWUxrRnFMbnZ2Yk1sNGZFS0V0M1Z5T25SdzJ4eXln?=
 =?utf-8?B?TUxtdk5ORm9VRHVrYWZUaFpHK1VpWk1xNTdRcVRJeE5KWnZTalgzc3VPUFZV?=
 =?utf-8?B?THFWN1gwTFgzdW11VkVqazRGd1pDdXh1blIwZiswZ2NSeUg2ZFZ2TllQTzZC?=
 =?utf-8?B?Ynpna2hJNldPR2FSMlFJT0dSUHROaFl4MmFHQzNGU1J1MlJZTDAxdnJYSCtn?=
 =?utf-8?B?STBiYk5uc0N3YVVweHV1Q0g4SWJUZGhkeHhEVkxUVEhMenhyZ3RWNVE1YnhJ?=
 =?utf-8?B?RE1ib0lwdERSSUNXYXpNVWdBaVpKK3U4dUl3akNjRjEwMFJBM0huTFV1N2pT?=
 =?utf-8?B?TlE9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: d20d4f08-c006-4802-1d86-08dcd554d9d6
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2024 07:05:59.0423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ebVDACNm2susYfwIUXdOkCnb/EUttvj9lNnnqRdQMG7zvde5S3eGT64yn8PpykNgCAfXJF6JGa6yAsNTiganFYfe8x9Xp4h0nrDErcBX48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6366
X-Mailman-Approved-At: Sun, 15 Sep 2024 14:45:38 +0200
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


On 12.09.2024 03:59, Simon Glass wrote:
> Hi Mikhail,
>
> On Mon, 9 Sept 2024 at 16:27, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> This patch adds downloading/uploading of data with netcat.
>> Client/server mode both supported.
>>
>> How to test:
>> ============
>>   netcat-openbsd=1.219-1 from debian were used for a tests
>>
>>   a) Load data from remote host.
>>        * U-Boot listen on tcp port 3456
>>        * PC connects
>>
>>      u-boot: netcat load ${loadaddr} 3456
>>      PC:     netcat -q1 ${UBOOT_IP} 3456 < image.itb
>>
>>   b) Load data from remote host.
>>        * PC listen on tcp port 3456
>>        * U-Boot connects
>>
>>      PC:     netcat -q1 -l -p 3456 < image.itb
>>      u-boot: netcat load ${loadaddr} ${PC_IP}:3456
>>
>>   c) Save data to remote host
>>        * U-Boot listen on tcp port 3456
>>        * PC connects
>>
>>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} 3456
>>      PC:     netcat -w1 ${UBOOT_IP} 3456 >image.itb
>>
>>   d) Save data to remote host
>>        * PC listen on tcp port 3456
>>        * U-Boot connects
>>
>>      PC:     netcat -w1 -l -p 3456 >image.itb
>>      u-boot: netcat save ${loadaddr} ${data_size_in_hex} ${PC_IP}:3456
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  cmd/Kconfig          |   7 ++
>>  cmd/net.c            |  34 ++++++--
>>  include/net.h        |   2 +-
>>  include/net/netcat.h |  20 +++++
>>  net/Makefile         |   1 +
>>  net/net.c            |   9 +++
>>  net/netcat.c         | 181 +++++++++++++++++++++++++++++++++++++++++++
>>  7 files changed, 248 insertions(+), 6 deletions(-)
>>  create mode 100644 include/net/netcat.h
>>  create mode 100644 net/netcat.c
> Reviewed-by: Simon Glass <sjg@chromium.org>

Can/should I add this "Reviewed-by" to the next patch version?

>
> nits below
>
>> diff --git a/cmd/Kconfig b/cmd/Kconfig
>> index 978f44eda42..abcd003f7f1 100644
>> --- a/cmd/Kconfig
>> +++ b/cmd/Kconfig
>> @@ -2007,6 +2007,13 @@ config CMD_WGET
>>           wget is a simple command to download kernel, or other files,
>>           from a http server over TCP.
>>
>> +config CMD_NETCAT
>> +       bool "netcat"
>> +       select PROT_TCP
>> +       help
>> +         netcat is a simple command to load/store kernel, or other files,
>> +         using netcat like manner over TCP.
> netcat-like
>
> Please add a reference to the protocol or the 'netcat' tool or both.
> Help must be at least 3 lines.

Netcat (https://en.wikipedia.org/wiki/Netcat)  uses plain TCP/UDP for
data delivery. In the TCP case, TCP by itself provides reliable,
ordered, and error-checked data delivery, so no additional protocols are
required.

Is it enough to write the following description?

netcat is a simple command to load/store kernel, or other files,
using well-known netcat (nc) utility. Unlike classic netcat utility
this command supports TCP-based data transfer only, thus no data
will be lost or reordered. Any netcat implementation should work,
but openbsd one was tested only.


>> +
>>  config CMD_MII
>>         bool "mii"
>>         imply CMD_MDIO
>> diff --git a/cmd/net.c b/cmd/net.c
>> index 53ce2bc5d0c..364139ec5b9 100644
>> --- a/cmd/net.c
>> +++ b/cmd/net.c
>> @@ -206,6 +206,28 @@ U_BOOT_CMD(
>>  );
>>  #endif
>>
>> +#if defined(CONFIG_CMD_NETCAT)
>> +static int do_netcat(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>> +{
>> +       if (argc < 2)
>> +               return 1;
>> +
>> +       if (!strcmp(argv[1], "load"))
>> +               return netboot_common(NETCAT_LOAD, cmdtp, argc - 1, argv + 1);
>> +       else if (!strcmp(argv[1], "save"))
>> +               return netboot_common(NETCAT_SAVE, cmdtp, argc - 1, argv + 1);
>> +       else
>> +               return 1;
>> +}
>> +
> Needs longhelp
Could you explain? Usage examples?
>
>> +U_BOOT_CMD(
>> +       netcat,   5,      1,      do_netcat,
>> +       "load/store data via tcp netcat utility",
>> +       "load [loadAddress] [[hostIPaddr:]port]\n"
>> +       "save Address Size [[hostIPaddr:]port]\n"
>> +);
>> +#endif
>> +
>>  static void netboot_update_env(void)
>>  {
>>         char tmp[46];
>> @@ -323,16 +345,17 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>>
>>         switch (argc) {
>>         case 1:
>> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
>> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
>> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
>>                         return 1;
>> -
>>                 /* refresh bootfile name from env */
>>                 copy_filename(net_boot_file_name, env_get("bootfile"),
>>                               sizeof(net_boot_file_name));
>>                 break;
>>
>>         case 2:
>> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT)
>> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
>> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE))
>>                         return 1;
>>                 /*
>>                  * Only one arg - accept two forms:
>> @@ -354,7 +377,8 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>>                 break;
>>
>>         case 3:
>> -               if (IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) {
>> +               if ((IS_ENABLED(CONFIG_CMD_TFTPPUT) && proto == TFTPPUT) ||
>> +                   (IS_ENABLED(CONFIG_CMD_NETCAT) && proto == NETCAT_SAVE)) {
>>                         if (parse_addr_size(argv))
>>                                 return 1;
>>                 } else {
>> @@ -365,7 +389,7 @@ static int parse_args(enum proto_t proto, int argc, char *const argv[])
>>                 }
>>                 break;
>>
>> -#ifdef CONFIG_CMD_TFTPPUT
>> +#if defined(CONFIG_CMD_TFTPPUT) || defined(CONFIG_CMD_NETCAT)
>>         case 4:
>>                 if (parse_addr_size(argv))
>>                         return 1;
>> diff --git a/include/net.h b/include/net.h
>> index b0ce13e0a9d..0af6493788a 100644
>> --- a/include/net.h
>> +++ b/include/net.h
>> @@ -515,7 +515,7 @@ extern int          net_restart_wrap;       /* Tried all network devices */
>>  enum proto_t {
>>         BOOTP, RARP, ARP, TFTPGET, DHCP, DHCP6, PING, PING6, DNS, NFS, CDP,
>>         NETCONS, SNTP, TFTPSRV, TFTPPUT, LINKLOCAL, FASTBOOT_UDP, FASTBOOT_TCP,
>> -       WOL, UDP, NCSI, WGET, RS
>> +       WOL, UDP, NCSI, WGET, NETCAT_LOAD, NETCAT_SAVE, RS
>>  };
>>
>>  extern char    net_boot_file_name[1024];/* Boot File name */
>> diff --git a/include/net/netcat.h b/include/net/netcat.h
>> new file mode 100644
>> index 00000000000..d8e09aaaa55
>> --- /dev/null
>> +++ b/include/net/netcat.h
>> @@ -0,0 +1,20 @@
>> +/* SPDX-License-Identifier: BSD-2-Clause
>> + *
>> + * netcat include file
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +#ifndef __NET_NETCAT_TCP_H__
>> +#define __NET_NETCAT_TCP_H__
>> +
>> +/**
>> + * netcat_load_start() - begin netcat in loading mode
>> + */
>> +void netcat_load_start(void);
>> +
>> +/**
>> + * netcat_save_start() - begin netcat in data saving mode
>> + */
>> +void netcat_save_start(void);
>> +
>> +#endif /* __NET_NETCAT_TCP_H__ */
>> diff --git a/net/Makefile b/net/Makefile
>> index 64ab7ec740a..dac7b4859fb 100644
>> --- a/net/Makefile
>> +++ b/net/Makefile
>> @@ -33,6 +33,7 @@ obj-$(CONFIG_CMD_WOL)  += wol.o
>>  obj-$(CONFIG_PROT_UDP) += udp.o
>>  obj-$(CONFIG_PROT_TCP) += tcp.o
>>  obj-$(CONFIG_CMD_WGET) += wget.o
>> +obj-$(CONFIG_CMD_NETCAT) += netcat.o
>>
>>  # Disable this warning as it is triggered by:
>>  # sprintf(buf, index ? "foo%d" : "foo", index)
>> diff --git a/net/net.c b/net/net.c
>> index 86182cc504e..d81604a57ce 100644
>> --- a/net/net.c
>> +++ b/net/net.c
>> @@ -108,6 +108,7 @@
>>  #include <test/test.h>
>>  #include <net/tcp.h>
>>  #include <net/wget.h>
>> +#include <net/netcat.h>
> That should be above net/tcp

Is there any reasons?

Should I move <net/wget.h> as well?

>
>>  #include "arp.h"
>>  #include "bootp.h"
>>  #include "cdp.h"
>> @@ -564,6 +565,14 @@ restart:
>>                         wget_start();
>>                         break;
>>  #endif
>> +#if defined(CONFIG_CMD_NETCAT)
>> +               case NETCAT_LOAD:
>> +                       netcat_load_start();
>> +                       break;
>> +               case NETCAT_SAVE:
>> +                       netcat_save_start();
>> +                       break;
>> +#endif
>>  #if defined(CONFIG_CMD_CDP)
>>                 case CDP:
>>                         cdp_start();
>> diff --git a/net/netcat.c b/net/netcat.c
>> new file mode 100644
>> index 00000000000..633afe5c60b
>> --- /dev/null
>> +++ b/net/netcat.c
>> @@ -0,0 +1,181 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * netcat support driver
>> + * Copyright (C) 2024 IOPSYS Software Solutions AB
>> + * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> + */
>> +
>> +#include <command.h>
>> +#include <display_options.h>
>> +#include <env.h>
>> +#include <image.h>
>> +#include <mapmem.h>
>> +#include <net.h>
>> +#include <net/tcp.h>
>> +#include <net/netcat.h>
>> +
>> +#define HASHES_PER_LINE                65
>> +
>> +static struct in_addr          server_ip;
>> +static u16                     server_port;
>> +static u16                     local_port;
>> +static int                     listen;
>> +static int                     reading;
>> +static unsigned int            packets;
>> +static enum net_loop_state     netcat_loop_state;
>> +
>> +static void show_block_marker(void)
>> +{
>> +       if ((packets % 10) == 0)
>> +               putc('#');
>> +       else if (((packets + 1) % (10 * HASHES_PER_LINE)) == 0)
> else if (!((packets + 1) % (10 * HASHS_PER_LINE)))
>
> but it would be nice if you could use 0x10 instead of 10 and masks
> here to avoid division. Or perhaps it doesn't matter.
>> +               puts("\n");
>> +}
>> +
>> +static void tcp_stream_on_closed(struct tcp_stream *tcp)
>> +{
>> +       if (tcp->status != TCP_ERR_OK)
>> +               netcat_loop_state = NETLOOP_FAIL;
>> +
>> +       /*
>> +        * The status line will be shown after the download/upload
>> +        * progress (see show_block_marker() function). This progress
>> +        * generally have no final "\n", so jump to new line before
>> +        * output the status
>> +        */
>> +       if (netcat_loop_state != NETLOOP_SUCCESS)
>> +               printf("\nnetcat: Transfer Fail, TCP status - %d\n", tcp->status);
>> +       else
>> +               printf("\nPackets %s %d, Transfer Successful\n",
>> +                      reading ? "received" : "transmitted", packets);
>> +       net_set_state(netcat_loop_state);
>> +}
>> +
>> +static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
>> +{
>> +       net_boot_file_size = rx_bytes;
>> +       show_block_marker();
>> +}
>> +
>> +static void tcp_stream_on_snd_una_update(struct tcp_stream *tcp, u32 tx_bytes)
>> +{
>> +       show_block_marker();
>> +       if (tx_bytes == image_save_size)
>> +               tcp_stream_close(tcp);
>> +}
>> +
>> +static void tcp_stream_on_established(struct tcp_stream *tcp)
>> +{
>> +       netcat_loop_state = NETLOOP_SUCCESS;
>> +}
>> +
>> +static u32 tcp_stream_rx(struct tcp_stream *tcp, u32 rx_offs, void *buf, u32 len)
>> +{
>> +       void *ptr;
>> +
>> +       packets++;
>> +       ptr = map_sysmem(image_load_addr + rx_offs, len);
>> +       memcpy(ptr, buf, len);
>> +       unmap_sysmem(ptr);
> blank line before final return. Please fix globally
>
>> +       return len;
>> +}
>> +
>> +static u32 tcp_stream_tx(struct tcp_stream *tcp, u32 tx_offs, void *buf, u32 maxlen)
>> +{
>> +       void *ptr;
>> +
>> +       if (tx_offs + maxlen > image_save_size)
>> +               maxlen = image_save_size - tx_offs;
>> +       if (maxlen == 0)
>> +               return 0;
>> +
>> +       packets++;
>> +       ptr = map_sysmem(image_save_addr + tx_offs, maxlen);
>> +       memcpy(buf, ptr, maxlen);
>> +       unmap_sysmem(ptr);
>> +       return maxlen;
>> +}
>> +
>> +/*
>> + * This function will be called on new connections (incoming or outgoing)
>> + * It MUST:
>> + *   -- setup required tcp_stream callbacks (if connection will be accepted)
>> + *   -- return a connection verdict:
>> + *        0: discard connection
>> + *        1: accept connection
>> + */
>> +static int tcp_stream_on_create(struct tcp_stream *tcp)
>> +{
>> +       if (listen) {
>> +               /*
>> +                * We are listening for incoming connections.
>> +                * Accept connections to netcat listen port only.
>> +                */
>> +               if (tcp->lport != local_port)
>> +                       return 0;
>> +       } else {
>> +               /*
>> +                * We are connecting to remote host.
>> +                * Check remote IP:port to make sure that this is our connection
>> +                */
>> +               if ((tcp->rhost.s_addr != server_ip.s_addr) ||
>> +                   (tcp->rport != server_port))
>> +                       return 0;
>> +       }
>> +
>> +       netcat_loop_state = NETLOOP_FAIL;
>> +       net_boot_file_size = 0;
>> +       packets = 0;
>> +
>> +       tcp->on_closed = tcp_stream_on_closed;
>> +       tcp->on_established = tcp_stream_on_established;
>> +       if (reading) {
>> +               tcp->on_rcv_nxt_update = tcp_stream_on_rcv_nxt_update;
>> +               tcp->rx = tcp_stream_rx;
>> +       } else {
>> +               tcp->on_snd_una_update = tcp_stream_on_snd_una_update;
>> +               tcp->tx = tcp_stream_tx;
>> +       }
>> +       return 1;
>> +}
>> +
>> +static void netcat_start(void)
>> +{
>> +       struct tcp_stream *tcp;
>> +
>> +       memset(net_server_ethaddr, 0, 6);
>> +       tcp_stream_set_on_create_handler(tcp_stream_on_create);
>> +
>> +       if (strchr(net_boot_file_name, ':') == NULL) {
> !strchr
>
> Please don't compare against 0 or NULL
>
>> +               listen = 1;
>> +               printf("Listening on port %s...\n", net_boot_file_name);
>> +
>> +               local_port = dectoul(net_boot_file_name, NULL);
>> +       } else {
>> +               listen = 0;
>> +               printf("Connecting to %s...\n", net_boot_file_name);
>> +
>> +               server_ip = string_to_ip(net_boot_file_name);
>> +               server_port = dectoul(strchr(net_boot_file_name, ':') + 1, NULL);
>> +
>> +               tcp = tcp_stream_connect(server_ip, server_port);
>> +               if (tcp == NULL) {
> !tcp
>
>> +                       printf("No free tcp streams\n");
>> +                       net_set_state(NETLOOP_FAIL);
>> +                       return;
>> +               }
>> +               tcp_stream_put(tcp);
>> +       }
>> +}
>> +
>> +void netcat_load_start(void)
>> +{
>> +       reading = 1;
>> +       return netcat_start();
>> +}
>> +
>> +void netcat_save_start(void)
>> +{
>> +       reading = 0;
>> +       return netcat_start();
>> +}
>> --
>> 2.45.2
>>
> Regards,
> Simon
