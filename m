Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE72C5B552
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 06:53:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F9CB8070C;
	Tue, 10 Jun 2025 08:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="hVmmyYKN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A10E80C83; Tue, 10 Jun 2025 08:53:18 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D75A4805D7
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 08:53:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfE/ExdHxLNys131OYHNq53hq/DvCSLluxnkKi4wTfF+rbp4zgzUzK/x2GGOsGFKwyLEmQckuAu5IAs0dlI/8MIkvL7thbRwxOSR1hSvghrF3QuH3AYdbjXmL547TUj2ciIVJ+Sdm25P/xu7sF5W6wJmiRSyPTDuwLEpvzH6skSehOPPheeqxnIMLb3mAVsXAn3Z3J7AJHkwSjUQc93GXolWCgwF7uTEtzVbGhY7pJWDEYZhXseu1inf/M4otm6ZxdiqcEG6z/TeiDQlXno6niODoGxDFG4Q3SbosiE+rQpufcAHfGh9tGt74Nx7lk29YO+gZK5x2YWWk32ZMing9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uygXV/Yx6xiXAYSrAkULhKyErsdkXLmUXaCng/GxDJU=;
 b=ZFUomLgM15lk3f2tQ3QWD1neVoxuIIlAvNRsEihzEt60TjRrioWxzs2TXvzmV6suMGpF47paAC725UhXg3zBbkpmBcEUtSdPv8SRvMQWR33QSCxUPUmc6MTPRLCHh1bzicMcfKnRtEF5/ouC76Of0JSk3p9SdSrBliI37dW+/kvXW1hwfNLVJeNXiqhWPoRqAAfqit3PtfZ7uSBgDSacU0TEQEsgOcELEOuOXKlGMnOpMa9YOqNUo7m1heJuDVq5wy82v4e1as5m2x2eMJffu71ONaE/B10LDUzjJINHtKFgglvoRb2cIDxYrc2gMgmKkZhSit86Yd+2yz0M720Wcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uygXV/Yx6xiXAYSrAkULhKyErsdkXLmUXaCng/GxDJU=;
 b=hVmmyYKNEyMrWynn5U5apWSXP6NHifsxXe2E0pDGkPYVyKkqFnrbv3Ydt8FLrx1Kx8LrqZ+R24AmMDQSQ//xT2R4yhY8q7r1Eypp/Bqi91Wh1S5CnkUrUbQ0vr2BqyZZOvt7sYtTYYKqjsDL8tS6ZzczrTmQqCLjBunByKGk5jQ9zRwayCZ+/rH5l4zlnVLrO56VCNxBt9uZvtte1NcFEU7aGwoQfy1WkJrxNhSz/n9K52bUQHuPaoyRZNefkAtt57KSMjlpjG+v1jcbv2uz62YZi4hfCDoUK8dFGIERacsPbHmIrYMoe4osMo6lmbyZkCBh2P+1OAOqI1xPM8o3bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from SN6PR03MB4288.namprd03.prod.outlook.com (2603:10b6:805:c6::21)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 06:53:12 +0000
Received: from SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55]) by SN6PR03MB4288.namprd03.prod.outlook.com
 ([fe80::4512:6543:5c49:ef55%5]) with mapi id 15.20.8835.018; Tue, 10 Jun 2025
 06:53:12 +0000
Message-ID: <32e3dffa-06a5-43d7-bdae-06f004318c96@altera.com>
Date: Tue, 10 Jun 2025 12:23:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with Dcache
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Ravulapalli, Naresh Kumar" <naresh.kumar.ravulapalli@altera.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20250603115442.19971-1-nareshkumar.ravulapalli@altera.com>
 <20250603115442.19971-7-nareshkumar.ravulapalli@altera.com>
 <LV8PR03MB8137A464CF2A9747F13D5DBDA76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <LV8PR03MB8137A464CF2A9747F13D5DBDA76EA@LV8PR03MB8137.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::17) To BYAPR03MB4279.namprd03.prod.outlook.com
 (2603:10b6:a03:19::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR03MB4288:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 25017aaf-33cf-40c5-37c6-08dda7eb7717
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N014em5rQVdHSHVLSW92dnRsMGZyODVyaElQT0dIdWVhM0pOSEFKSkhXQW5y?=
 =?utf-8?B?WWZ3a2dMUFF1UjN2U1ZtVE5QT1NMRXBHVTRJZFYraVpwRHVaNEMwZy9kM29T?=
 =?utf-8?B?NHMxdmJLdC8wNEtERHdqVHJTc1A4b0ovclNWN2czbTEyVkhEb1pTamNkN0pO?=
 =?utf-8?B?bExwc1AxbzBNdnJlRDVHY0w0aFFreGZPS0N5RWpWbW84blMxSDgzRnNtMnJ4?=
 =?utf-8?B?NHBScXlxaVNnaHBZV3lRTmpubmhJQ09IQ0s4c3RVSXJUbXFFemVjZTBzTkVU?=
 =?utf-8?B?WTd4VzhZY2NGUnFodWMvd1VqUTVUN1E0a2J6Y0RJU3FuUVZxRVA4R0lGZzRC?=
 =?utf-8?B?NWFoV2lOY0w3QVZJZVdYYjdNbkQ5cjEvMlFiQU1FQTEyTW80RWxSOEFPU3ZH?=
 =?utf-8?B?M0ZuZjhxUDY4THFmL2JiZ0VjT1M3RVRaVGhSQ3RXZDJmZjN3aURnLzRkb1ZH?=
 =?utf-8?B?MlZuWGRsZ3VaWDUwbVBlR0xXMnpxU3RqQnRCcnBHSXozTzMxRkpWYWNzdTls?=
 =?utf-8?B?OEtYVGZ5UFFodllTcHJXU3Q1TkpmLzI4STMzWGlqdHd4Mnc1RE9McVAweXBW?=
 =?utf-8?B?VDY1THFJYXVZcE5KRWZ5dUkvVnMwanIyK1Bubjd6bUN5SDFkY00weVFxM1Zp?=
 =?utf-8?B?UHlVblVXeHl2bktJdXJTOG5kOWtzK2pNMjgzOUN3bHA5U2VxWVUwZ3oyd1VW?=
 =?utf-8?B?ckhOUkE2b3JzNlQ2bWxpODJHd1AzMVBqN3ZRUXNabExVUk5nb0xvUERUb25F?=
 =?utf-8?B?em9YcHo4WEN3aXFLbUYwR0xmZ0I3eElPeUZhUk9TNjFUeVorelZTUTN5djc2?=
 =?utf-8?B?dkJkYUxoa1lwR0pQWmxCamNSTHpFbW5OZkZ5RkJrRStsTngzK2ptcSsvRG5S?=
 =?utf-8?B?aVVIL1FucEpjZ1cyc0lYZjlZRkhCaHQrOW5VNnF1K3ZkYklaWStoWjdNZjJG?=
 =?utf-8?B?dWFZUHBzeWlmcVMyTmtQdXMyT1MvVnE4Zi9DZDNmQXhDMmo4Q2JnQXRHM3Nm?=
 =?utf-8?B?eUh6R3JrdjgvZW52alZYei85blJGL3ZYWEhPM0NBdW15Qllaa3JLMVM1bkc4?=
 =?utf-8?B?SXl5UU1vTWJ0Y3VKeEowWXBrcUVSSktwaHFnSEV5c3NGSTkwbHJlZkNTc20r?=
 =?utf-8?B?SzN0RFlVT21aWHNLWnZtR3hvSndzSG9DQUh2ZVRLTnh5RjF3M0V0Si9LbXdP?=
 =?utf-8?B?STlZSExPeXJoMjZBSjJmeXJRUGNLUTVMVkN1SEM5L1NleFJSODNNbUIveXJC?=
 =?utf-8?B?TU1DZU1JZ3FhK09ocklSaWZBY1E5ZlhKTXh6ZGlWdSt6QXhsUnZrcDdqTVZz?=
 =?utf-8?B?OFhxVlVBZkZ2NUNyUGd3d2d6RStPRGg4dmFZbE05TWRMQ0hOdXN5UWVQOTBS?=
 =?utf-8?B?SzZ5WTIvVVRjUVVDWk1wZGdXcU55bU9TUFhTUDFTT3h5em1uSFNIYkZ3dEZB?=
 =?utf-8?B?VGtDY2FBV1RqdnpXdXl6S216dDk3WXlFRUFDeFpBVlh6aHNlS09yWGJtbzVF?=
 =?utf-8?B?Zm9KY1lDU1hrWHhuRjFZU1RqR1FIUVVrdEsrbkp5QVNCcXZ5eCtXM1hkZnU3?=
 =?utf-8?B?OHNtd3BpSHhLN2ZWUVR3bzkzdExESzZmRk15Qno0TW0xbE5qQVJ6dHB1Wloz?=
 =?utf-8?B?U2tFRy9MTEJ5SWhsdlgzMG9rSVR3eE5Pejdoc2x0OTEreUNVS0o0dG5wSGla?=
 =?utf-8?B?aHJnZTVyL0lTWVU4ci9KTTZQWHVEYzZzaWN3T2Y4dDJLb0pwY2VlNElrNlkx?=
 =?utf-8?B?WmpLbFhUWVpZV3phN3RDQjRITURZWFhHTlRoM3FLenhhdjNUeXlBbHFsNkRs?=
 =?utf-8?Q?AsQzQKp8gTnA6hb7MoOWXVI86BMXzAlDpE0tU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR03MB4288.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkZhOFdERkRIS3hscHhGODZROFhHZDdLaDlCaTlmQUNLZ0NVbDY5NXAzVFZ5?=
 =?utf-8?B?NGtyRkZaMGN3VXFnWGZ1VVRRMkZBWjhrMWx2UzVuOWtDLy90a1F5TzlzZy8z?=
 =?utf-8?B?MHZQQ3F3aWxTYzBJTHlYd0d5NTVUK0EvSWVCcUtTUE5lVkRmZXpWOFBucjRW?=
 =?utf-8?B?V3FwYTFEY0hSTHp2ZGMrTXArcUhydlVDeFRaaG5IWjlQNGNVYzRacGdkM0VX?=
 =?utf-8?B?VjRSMjY5U1E2azRObGtjcUt0OGJPZzhjWENLeG1RM3dCV3pZb3dmaVRyV2s1?=
 =?utf-8?B?bFNhcVNKcndEZWFHT0pqbWM0Vy9BZCtSR1pmZmhoN1AyTFAxYnN0MkRiMUJB?=
 =?utf-8?B?UFg4SWtuWXd2V3JMSDhRckc4WVlReXNMelVsMlJ6bnVpVkZCQTFKOGtYa1U3?=
 =?utf-8?B?bmE1K3pGRzRXN09qUVZyTVZtaVl0bDZ5U0JMUjI3SHQ0NWhKQU9Gckp2YWRB?=
 =?utf-8?B?R1ZXVE5yTDVkdDI5dEtpTEtxMEdNb21Cd2JXRjc2VWZYNlU2ZmRSbXI1d2dn?=
 =?utf-8?B?bWMvSWJORUlUVE5XNHE5TGpCTlhadkFMZE5zSVVxSnhnVkVoQXV5T0piVTBx?=
 =?utf-8?B?TXRMdmVKUkZSUUxiQVN5M01CeGRZenlQaXEzbEg3Z0hpcis5VFJNNmF1NWw1?=
 =?utf-8?B?YnlEOWtJN0prQ01OMkNsMVNKWW9NNEFWcnRjMFdlZGV5akZkMnJMTVJRb0FY?=
 =?utf-8?B?VmpSam1FNnIyS01MVFBwUkpsT01LSEVtV3JIWGNnanRHOG5DMEF4cGowNktm?=
 =?utf-8?B?VUhYcWd3S1FueUIxOHR2S1ZPZzBuaUE4V1NJQ3BsVEhUMk52a2FiTXJ0N2lu?=
 =?utf-8?B?WFVHS3F5ZVBhUWFUQWErc3ZkLzZoKytiK0VqWUMvcGdMem91b05yemMxQVBn?=
 =?utf-8?B?QlZ6cFFKZFRybUVUcS9WdVM4VlFyS3VXUmFPbDlGRk1qSVcvbVlQMVdtUUJr?=
 =?utf-8?B?cnhuVXA2TG45ZnJoWDFQNERJdVNNV243dGlIckxOcjdCc0pVY0NVaVVwZ2Z2?=
 =?utf-8?B?ekxCOHZsSzRmaSt2WlZnUW16T3IwWTl1T0FLQkp3a0V4VWE1SWpkMFVEbjZP?=
 =?utf-8?B?VzJDQm11RkhVM21XbnE3a2ZGOHBtMjNSNTJEUGhhZ0lxNUF3RFVpU1BPRTVR?=
 =?utf-8?B?dWRTWEhvYjVhZ3ZZNTRKM2NJa3FPbjlQRUoxc1AvR0NXQUNuczh4eEkwVFJr?=
 =?utf-8?B?ZzJjOS8zZDhteEVTRkhERkpoMDQyamMyZmM3elRWMHRlb3A2VjBiQVkreUN1?=
 =?utf-8?B?ZnVNTmFGVERLelo3MDJwcTJrNjV1WWFhamMrSmdIOWZTMDJ6OWR2akJtYTJF?=
 =?utf-8?B?aFR0cEVZeVIwSCsvRlhIVUFNMXZmZmxFSldUak1Hck9hZFBZWUM5Q3Z5MU9T?=
 =?utf-8?B?WDNsMHArcUpiY2RWcEtreUVORkRNcnQ1UGV2ZTNKSy9CUjVnZXR2L25qdFdw?=
 =?utf-8?B?elhrWEg0V2ErR1dYUjVMODlGbHZvL21Md3NjWERxQVYrOTA0TFFWb2VuaG9r?=
 =?utf-8?B?enpNSDRFUUw5SEQ0ZlhTVUtubUUveEp0YkdERjdWZWFtRVR4SERSRnJoVmp1?=
 =?utf-8?B?ckQvYkZrdEpvT0p1aGpRMCtLQTJ0SFNycXpLTGl6L0dPMll6TmgzcFFmVTZK?=
 =?utf-8?B?SVp4cytDVThCUWFPR1k1QWYrc25OSE9nOVIwOVAzRDAyK1dFczFZYTFML0t0?=
 =?utf-8?B?dS8yakJ3bkRSdTBxWUxveUwzN1hSMUhVYkpWL1BlR1JYM2JNeVdPSFZSTUFm?=
 =?utf-8?B?VnNNQW1Pa2pGOW9oejRPcjlXdEMvWjZWNVB2TzRTNmRzNzZobjUvajN4ZktF?=
 =?utf-8?B?QTlrSWZNcnRYL3NwMGpWOGNVM0dWWnByREFzOGVJNGR3T1VoZUk5MkJvRGp0?=
 =?utf-8?B?aWNkbEVZeDhuU21iSWY1cHJDUU9FQ0RYZ1dRRVo0WmdMU2I2dXFrL2YyTDJH?=
 =?utf-8?B?RE1CVVVxTzV6bTg4Q2dxQUxlL3Zhdm9wK1Ftcm1zQW5uOHQ1ZnJOQnVjdk9L?=
 =?utf-8?B?em5hcWlJRjZraE1acmxXcTljZDhOcERmeUNmTW1kbmpIS3hrZnA4YWxFUnVH?=
 =?utf-8?B?YTdtbnM2clNGOXc2ZUJQRXVhM1AyRXdMaXB6ZUcyNjJOUmJ5N2t2WDhLakRD?=
 =?utf-8?B?NnhYUFZqeEZydURVblh5Q1NhckhHcGk4NGZseFdkRFNFSjlwZmdCL3FVSnRI?=
 =?utf-8?Q?EmMYWoTomoEPhCJccsGA0OI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25017aaf-33cf-40c5-37c6-08dda7eb7717
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB4279.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 06:53:12.4214 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d33SEgZzZPa/3UVuY4FFYO5caO0P15Wv7AeYV9o56DGtOHlXODv2nbRFfggg/hkwPTmVZ7CENDUAe8NLTapKNwvKFvLJMJyYaeO6/wtsPQ+Tea1SUCxgNkXNJK8QSsDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
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

Hi Tien Fong

On 06-Jun-25 12:15 PM, Chee, Tien Fong wrote:
> Hi,
> 
>> -----Original Message-----
>> From: Ravulapalli, Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Sent: Tuesday, June 3, 2025 7:55 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt
>> <simon.k.r.goldschmidt@gmail.com>; Chee, Tien Fong
>> <tien.fong.chee@altera.com>; Tom Rini <trini@konsulko.com>; Ravulapalli,
>> Naresh Kumar <naresh.kumar.ravulapalli@altera.com>
>> Subject: [PATCH v3 6/7] drivers: ddr: altera: Improve DRAM init with Dcache
>>
>> Initialize DRAM memory fully to bring it into a known state. The process is
>> improved by enabling the Dcache. Also, if hardware watchdog is configured,
>> it is reconfigured to avoid timeout.
>>
>> Signed-off-by: Naresh Kumar Ravulapalli
>> <nareshkumar.ravulapalli@altera.com>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> ---
>>   drivers/ddr/altera/sdram_arria10.c |  3 +-
>>   drivers/ddr/altera/sdram_soc32.c   | 52 ++++++++++++++++++++++++------
>>   drivers/ddr/altera/sdram_soc32.h   |  2 +-
>>   3 files changed, 45 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/ddr/altera/sdram_arria10.c
>> b/drivers/ddr/altera/sdram_arria10.c
>> index a1288d5fb50..6cb5002208b 100644
>> --- a/drivers/ddr/altera/sdram_arria10.c
>> +++ b/drivers/ddr/altera/sdram_arria10.c
>> @@ -4,7 +4,6 @@
>>    * Copyright (C) 2025 Altera Corporation <www.altera.com>
>>    */
>>
>> -#include <cpu_func.h>
>>   #include <errno.h>
>>   #include <fdtdec.h>
>>   #include <init.h>
>> @@ -719,7 +718,7 @@ int ddr_calibration_sequence(void)
>>   		puts("FW: Error Configuring Firewall\n");
>>
>>   	if (sdram_is_ecc_enabled())
>> -		sdram_init_ecc_bits(gd->ram_size);
>> +		sdram_init_ecc_bits();
>>
>>   	sdram_size_check();
>>
>> diff --git a/drivers/ddr/altera/sdram_soc32.c
>> b/drivers/ddr/altera/sdram_soc32.c
>> index 0b928a2352f..5cdf48d2d01 100644
>> --- a/drivers/ddr/altera/sdram_soc32.c
>> +++ b/drivers/ddr/altera/sdram_soc32.c
>> @@ -7,25 +7,59 @@
>>   #include <asm/system.h>
>>   #include <linux/sizes.h>
>>   #include "sdram_soc32.h"
>> +#include <watchdog.h>
> 
> Moving the watchdog.h as first header
> https://docs.u-boot.org/en/latest/develop/codingstyle.html
> Please refer Include Header section
> 

Acknowledge the comment, will fix it in next version.

>>
>>   DECLARE_GLOBAL_DATA_PTR;
>>
>>   #define PGTABLE_OFF	0x4000
>>
>>   /* Initialize SDRAM ECC bits to avoid false DBE */ -void
>> sdram_init_ecc_bits(u32 size)
>> +void sdram_init_ecc_bits(void)
>>   {
>> -	icache_enable();
>> +	u32 start;
>> +	phys_addr_t start_addr, saved_start;
>> +	phys_size_t size, size_init, saved_size;
>> +	enum dcache_option option = DCACHE_WRITEBACK;
>>
>> -	memset(0, 0, 0x8000);
>> -	gd->arch.tlb_addr = 0x4000;
>> -	gd->arch.tlb_size = PGTABLE_SIZE;
>> +	if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITETHROUGH))
>> +		option = DCACHE_WRITETHROUGH;
>> +	else if (IS_ENABLED(CONFIG_SYS_ARM_CACHE_WRITEALLOC))
>> +		option = DCACHE_WRITEALLOC;
>> +
>> +	start = get_timer(0);
>> +
>> +	start_addr = gd->bd->bi_dram[0].start;
>> +	size = gd->bd->bi_dram[0].size;
>>
>> +	printf("DDRCAL: Initialize ECC RAM (%ld MiB).\n", size >> 20);
>> +
>> +	memset((void *)start_addr, 0, PGTABLE_SIZE + PGTABLE_OFF);
>> +	gd->arch.tlb_addr = start_addr + PGTABLE_OFF;
>> +	gd->arch.tlb_size = PGTABLE_SIZE;
>> +	start_addr += PGTABLE_SIZE + PGTABLE_OFF;
>> +	size -= (PGTABLE_OFF + PGTABLE_SIZE);
>>   	dcache_enable();
>>
>> -	printf("DDRCAL: Scrubbing ECC RAM (%i MiB).\n", size >> 20);
>> -	memset((void *)0x8000, 0, size - 0x8000);
>> -	flush_dcache_all();
>> -	printf("DDRCAL: Scrubbing ECC RAM done.\n");
>> +	saved_start = start_addr;
>> +	saved_size = size;
>> +	/* Set SDRAM region to writethrough to avoid false double-bit error.
>> */
>> +	mmu_set_region_dcache_behaviour(saved_start, saved_size,
>> +					DCACHE_WRITETHROUGH);
>> +
>> +	while (size > 0) {
>> +		size_init = min((phys_addr_t)SZ_1G, (phys_addr_t)size);
>> +		memset((void *)start_addr, 0, size_init);
>> +		size -= size_init;
>> +		start_addr += size_init;
>> +		schedule();
>> +	}
>> +
>>   	dcache_disable();
>> +
>> +	/* Restore back to original dcache behaviour. */
>> +	mmu_set_region_dcache_behaviour(saved_start, saved_size,
>> +					option);
>> +
>> +	printf("DDRCAL: SDRAM-ECC successfully initialized within %d ms\n",
>> +	       (u32)get_timer(start));
>>   }
>> diff --git a/drivers/ddr/altera/sdram_soc32.h
>> b/drivers/ddr/altera/sdram_soc32.h
>> index 4c6137e728d..85a951a5a74 100644
>> --- a/drivers/ddr/altera/sdram_soc32.h
>> +++ b/drivers/ddr/altera/sdram_soc32.h
>> @@ -6,6 +6,6 @@
>>   #ifndef	_SDRAM_SOC32_H_
>>   #define	_SDRAM_SOC32_H_
>>
>> -void sdram_init_ecc_bits(u32 size);
>> +void sdram_init_ecc_bits(void);
>>
>>   #endif /* _SDRAM_SOC32_H_ */
>> --
>> 2.35.3
> 

Kind Regards
Naresh

