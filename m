Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42094E8305B
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 06:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAF1F83FC8;
	Tue,  3 Feb 2026 07:52:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VebopgeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C10D83FCF; Tue,  3 Feb 2026 07:52:25 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E70D183FC6
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 07:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htc0UPZDhDSZsfy+z7dIzFljS3jDrjlfzhFwfCNjzKlk45Bz/RZ6TSSyZoKt0aexrse0NL8KKrG2uZ7dLET/g8DgfuLPr6/VVI5Ews+4bEY1ZouvGG7ls2hXHaw/frscPz0e8lXgvuw1jKTy6g1OEvodhjmuCSMy7LK5NWdeqLOyNRK3YwrLfG7RO7LGu+nGdacT9rf8IJNy9YIRTRdNEvIZ5lJ0e4DGOvcI6AtlEZ1H2teov5utbtIk+PlzoWwzrHD9XM8QfwXcfm9twpvSVXyyxxkV/nGI8xL+33pE24LY0G+r0cThTyqSn6hh6M4gFAB0rALDdvNigQFhdljlsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsHCLoWGKOa+wOI4OO2Sy36Tr2KUVAemSnPi/JvpBwg=;
 b=tw7Yv8sgOy7AOT38r4N0eLahVhWuT/MHdXRIy8Hx3ozKnzLmlLKPiEgpZZRi6O8WgNGIDldp87kEgWMA3lCMcV6p/S2Ny2hcJkORn9mgh2RByzljqafX+KObPqck99hYn9F1BG0BpcELacVwi+0+qACsj0idQmp5nrAgdTJtb3zDaES3B94Wo17luC6R5GiENnF0ng44c0dSOQU7ow/6B9s9sjPwUWsHf0fKIrjMSXBWJ0cZ3jQqfH4h/rNDiRW/hoClK7OaByyozUAfGas2NGLxsTRW1Bc9J6puhIyn2tAC/yqskELa0gT7pmGNt1/q+5zUQcl24qHoFExPLvb1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DsHCLoWGKOa+wOI4OO2Sy36Tr2KUVAemSnPi/JvpBwg=;
 b=VebopgeB27f37C0qR7xQN01ZQ/fpPO/IogtacLEvvwzlX42gJqWuEiPm4uno3RiN4lWBBNLIxRFMd5q4ZjtwXr2OBmMhV1xewdnyKJlW/NiGEN1JnNq/5ZugHWKl0pJmKCSsiMbvh1S22n+2Q2vNAdz0eqTVV0ef2MR7VpF9hjehOaiKOEljZmxXF4KNdh6zbQbamlqRuyYbolIHUj0BbgJ3mw9NUW+jf1uGJCXWpyVRh1kYbFbRriBpeg6ZLFt5To6ak2SMFyfc/dv8MfBSN/ASX+qjDY9ucYsJ7ytMjSc1b3egL5+EpPNVTNGs6xb1jgvTY7ND0mAmZemDtQ06xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by VI0P195MB3205.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:2eb::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 06:52:13 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::295f:9a59:b66a:621a%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 06:52:12 +0000
Message-ID: <a4678f35-03b0-4670-bcc6-2200f8dce34f@phytec.de>
Date: Tue, 3 Feb 2026 13:51:54 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH master] arch: arm: dts: k3: refactor common nodes to
 k3-*-r5.dtsi
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Cc: Tom Rini <trini@konsulko.com>, Nishanth Menon <nm@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>, Manorit Chawdhry
 <m-chawdhry@ti.com>, Bryan Brattlof <bb@ti.com>,
 Paresh Bhagat <p-bhagat@ti.com>, Vitor Soares <vitor.soares@toradex.com>,
 Parth Pancholi <parth.pancholi@toradex.com>, Andrew Davis <afd@ti.com>,
 Gowtham Tammana <g-tammana@ti.com>, Vignesh R <vigneshr@ti.com>
References: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20260122-r5_dt_refactor-v1-1-5442a4321756@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KUZPR02CA0010.apcprd02.prod.outlook.com
 (2603:1096:d10:33::8) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|VI0P195MB3205:EE_
X-MS-Office365-Filtering-Correlation-Id: fb9b3014-79df-4982-d588-08de62f0c236
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|13003099007|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U0t5SGR5b3daS2FMNGVrWS9TMHFmSmoyK1B6UVAxaXFVTW9nYlBLVTBodnBx?=
 =?utf-8?B?NkdRV0NkeDFhTmZBU1BoalE5aEVKenI1Z1FHR2dJbnFSbndhTjkyNUJ4Y1Rq?=
 =?utf-8?B?YlR0MzJqRVRYdDZQRVY0b1kyMTErVk5NTEhualJwcVhCQWZVRTRKT0dZNU83?=
 =?utf-8?B?NWhyNmgwZ2h5cXI4UWJucjBibmhRa293c2k1ek0yV0x0bTVQdWhTdnRjdytk?=
 =?utf-8?B?UzEyQ3BHVWFDNUIvVWpQSVVtMllNSys4ZDM3OEdPbzB3Mks3aHdyMVViWVpm?=
 =?utf-8?B?SmdYWEs4NEwxTjRGOW4xM0VrNnVuanI0cmN6VW5FeGwvSWsxZ3g3d1Y1OW8z?=
 =?utf-8?B?dzBTd0xXWERTeDYzK3NBWUVubVVxZVNyTVhRRDd6S0RLMXVQMFJwU2hXM1g5?=
 =?utf-8?B?YmNlTUFZK3FtaWhwUzltRFQ2UkV4WVNkaUFKWXFrYjUxc0gvUEx4Q1QxcTg0?=
 =?utf-8?B?VVN6Z21JdHNVWEMyT0JuaEVKT2F5NWw2Y2VQMkJQZlM5dE1sUzI5aTQzUmpo?=
 =?utf-8?B?QlM2VThNNVAyUTFyMHhiSWpjeXBxVUtlU2pTeE9ZNUc2SzdUQk9nVWdwVFNM?=
 =?utf-8?B?UVFqL0FPY1VOUUlkQ1Y3VVR2RCtWazBvdG90ZDZ2OHpsd1YvQ1hmdmVEQi9U?=
 =?utf-8?B?OFozNytuSFlsT2lsbSs3YnVFMU96MmM4WDZISTBybzc2aCtFb3RVek9ncDhQ?=
 =?utf-8?B?RTdSNU5qOEsyNVRvRWw2MU9XbnN1bjZKc0RKbjAyWWI0RWo4YW9pZXFWRmVv?=
 =?utf-8?B?ejF6OVpIaGRvUTFBQlRXVU54UkxINVBFUTluQXFtQWNFZTB3WWUvMk14TXVa?=
 =?utf-8?B?U3d4WkRCa1RKTVdFMXdTeC92RFVHMkdxTmQwN0kvbnNMU0M2OTBiN1VvaVVG?=
 =?utf-8?B?VTBqYmtpblJhSUV0bENuS2cwSWpGUDlxVUdKcGpqM3dnTmZPeG1EZU1EQ3R2?=
 =?utf-8?B?TUtoRllwb0NLYklicDhDWktjb25naVphZStXdmhpd09nQSs5SGMrcFVmQWRa?=
 =?utf-8?B?aW5NZnZJYjVGOFo0d1drRzNlV1pmV2ZNeGFiaFZHRkFHRGd0MkZpRlhDbHFD?=
 =?utf-8?B?S1hSQlhOaTJGd016OUJWd3JLU21reXlGZnhFdVBaYXZtZ1k0Z3JIRGVERVVj?=
 =?utf-8?B?ekRGSGY1eUxJQlA2T3Jjdks5MEhlczVkL2xUOWllenpldUlqZE12aEZUeWty?=
 =?utf-8?B?QUY4WnFIaEJYM1RpcURRbnZJYUxPOS9pNGRjUHg3QW9CYWh5dWltc3lJSUYr?=
 =?utf-8?B?SklSMzJoSHgyN0Zndm5raThCWGZYT3BwckNsVmRMSDdHMEYwVDVnRXFmSFQv?=
 =?utf-8?B?WkE1eWZodUpjNy8vSnNhYUQxTTRMWkNWaVhUaTZ1UitMQWltMmZzVXdEcy9J?=
 =?utf-8?B?NUM3NkpWN2doeVJxSUpET0FVZmZuemE5a1EweWI2T1FVc3J0elRHMm1LemNT?=
 =?utf-8?B?RmdVMm9uOTFJVXl3RTh0cDNVK2k0bmJUc3NRMWM4ZG9neFB0eXByR0ZmNFg1?=
 =?utf-8?B?TDVidUNxK293S0QwOW1jcm16cHNjN2U4WUowWXoxbHN6TUZNQXRudTUzWGZ1?=
 =?utf-8?B?T3crbjdiemVFV21Dc2FHd3phNEJlSGtpWnFVbndQVkpXckdzbXdMam5DSWpo?=
 =?utf-8?B?QWtrWitSUDIwZ1NqQXRpdSs2emdvcUZNV3l4azk2OTl4QitFaXZQdjlZSDlR?=
 =?utf-8?B?cmFIZnk0UVBuZnZOQ1ViQXp4SjFRZG03ckVmYTg1SzNIS0prdm8zSDRNYlRT?=
 =?utf-8?B?Nyt1Z0V4cjV1K3JZc0JGODBBSENSZHlxci9adEdja1lHbTg3aWNRMlJpWjM4?=
 =?utf-8?B?RTkzZitoTmwyYS9ETFFxMEtJNyt3UkVEQWVRb1VzUnFzeXpmNDc4MHlMRmhQ?=
 =?utf-8?B?QWxQWjJFQzJVODVaQkVkRjdROC9zUlJ0WXJhbjI3cU8wKzlBKzRFRDRjOG9I?=
 =?utf-8?B?bEUzN1FXNWREQnFCUHVCb0JVSTVBdjFOaSswLzI1bG1GbTJPanoyRkNMYVVJ?=
 =?utf-8?B?WXhRT0tRdFlwKzhsTFFiM1RqblJFNmtVbzJwQkVJcUtmck9QdnZQK0wvdGo1?=
 =?utf-8?Q?PFpG66?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(13003099007)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SS96anJ6R2FWa1pETWV2Z0RXVm5xNkF6WVkzdVozWVBUeUYvWENCN1hPZnY4?=
 =?utf-8?B?bmMxUTYycnh6SHhhZEZYSWNPL3ZQM3k2YlRLN3k4d0RPbDFEeWd0djE3eUkw?=
 =?utf-8?B?V0poaFM3MjFlMkRzOThJeEdjanc5SUtUb2lzSnNsTTlRalZDL0pQbUEyN21p?=
 =?utf-8?B?bEd4V2djWjdnWWNhM3diMC9aTk5aWFV4cHRmMzRDemtzRVpsdkFicWpOWFF2?=
 =?utf-8?B?MWJGYkk4dUlFRTFBRXlqUHNjMHRLOE9YOHpIRjY5K1BYalgxN25OU2VweEpu?=
 =?utf-8?B?bU8vdmRkTTRPUm94NG5pMVlTV0dsUStweDR1VTF1ODZCM3p6MVY3SGpUYUJN?=
 =?utf-8?B?bHFZWmtGY3JWbUgzdkVBR2pkY1JZcndsMVExYUFRbTEyRzJrejZNb0RVRS9L?=
 =?utf-8?B?WlBpVEZqc3VraVB6OTQzcnlGSnZ0TkJHdmNTNWliVklHcWt5a2JQOHI2RDBm?=
 =?utf-8?B?eW9jWlMwbytrU0RMeXlOZEFEeGV2V0hQTzRPM0tadk5vVjBEWlBYK0RsU3o4?=
 =?utf-8?B?YWhpcTJ0bU56SS9WZk9IM0VRS2xDbHZ4Q2xBQ2pPSVNyTENnZFE5RU5aSlU0?=
 =?utf-8?B?cjJCdEpWSHk0RTRvQS94dWhvdHVac20yQm4rbE92UUt6bzZ1RzZ5aDNXcGJw?=
 =?utf-8?B?Wno5Tk1RVzBGSzdtdFB6Rk42cldwcDZJZW9qWW1qN2VjUUVwRVF4ZXovUDJO?=
 =?utf-8?B?dkxUZ0lqMTY3d3E0bmFpMWp0Kytramx0S0dYVjd6MWlXYW82NzVTMHF0aW5Y?=
 =?utf-8?B?VHB6T1dSSWJUWVZ2ZkZsQkI4VDZlQVlMSWhNZS9hR09CRUFiNUZ1emo0aVAz?=
 =?utf-8?B?THk1RDU0bm9zdjhnWGxnNzhvQVNLRUx5a3VEblp1QXBNbFpZTVhrT0l0MTRF?=
 =?utf-8?B?dXVVTFVOeGRzSmlHUnFXOGM1ZGZTMmROeVpEczVwMTJ1TTl4cWNIUDBldkNI?=
 =?utf-8?B?T1pZV3pGc08xM2ZwRXBLMEI5ZkNaWW9pSSs5SkxjVnBvWUNMSXRWclZDckxa?=
 =?utf-8?B?V2dUNmUxOC9ybThiM1hsUC9ycXhiQVcyd2ttSTR4MzhLdER2dXJsZjY0R2dI?=
 =?utf-8?B?VDZTL1EzcUg1NmdDeGNPaDUzbzJVcTBVb1FYcFBmdmxSbmZWV1NRVC93eFU3?=
 =?utf-8?B?Wm4rejNmUHJyOFhUZlpVaW04WmliRVQ4eHF4cDJSZTRTZzh4N1AxeVIyaXlm?=
 =?utf-8?B?S1M4UkM4Z3lUNXg2N3R6Z0MrTGJCZXVYS3J6RlphbEROYjBHeFU0N3JweC96?=
 =?utf-8?B?R0ZQWStkU2xhUlRCRHZyV1VqNnliV0RlZWQyemVnbG40SHVpWjVZdGhHd0c3?=
 =?utf-8?B?V01pQ05JckRYb2taRk5TeE16QXo5M05nOUpoMW5USUljWkZQa0lwM0NWZjdv?=
 =?utf-8?B?YnM0U3lVaHRETTFheUJHeFpWTTd1QUcwN3lpQnVRRVY1SFN4NVNGTyt6Yjl3?=
 =?utf-8?B?UzBydVljeklCdVRCenFpRnptck45UktXaGdVU2svWmN2TlhqT0RGYXlBSlo3?=
 =?utf-8?B?MU52VU5iM29nYzF5eUlpQlN3MzkzZnM1R00ySlc4bW54MzkveHdjNXVxYlhQ?=
 =?utf-8?B?TXJJRWYvTjdKSXhuYjQ2a0RDK2owcXBzcHBWZkZ4Vms0ZnJnTHd1RTIzWGZB?=
 =?utf-8?B?WTRuQVNFdlYyT3BzUmJ3MEROdENVcWhhRkR0OEU2dWtCK2tNZGwvNEw5LzRK?=
 =?utf-8?B?SWt5Q0RGTVJsb3IxUm9iWmhDNjZaWG1BU2V6QmVEY0N5bVhQLzJ3czJwdThh?=
 =?utf-8?B?YTk5QTdFMG5MRmMzZXdlZEd5RTh3UUJJbWpJcCsrblNFWlkrNFFNcW43amtQ?=
 =?utf-8?B?WEJqNUtack1tVWNrcXJEbnhMZjBaSnZoekFteDZpRVFIVXRJcElBc3RpTUNZ?=
 =?utf-8?B?N0p1Q243SDhsWTFjQzYwVFpBVTcxOVBwRVRqelNTNGZpZWZnRGdiUk5nZEhz?=
 =?utf-8?B?T1lHWDlqa3RBVkRiSnMzSFp5U3BWelFMNTBJSG1oUGdPMkFTVFVYWVNPeVR4?=
 =?utf-8?B?UURFTjl4dkxreWFUY1lGVkJqM2J0K0lqV1FWYjl5clp1WiswMXVGOXlaNzZ6?=
 =?utf-8?B?bzEvMmJyK2J2OEZETkZxWkV4M3BVdDFVU0RRNEdjcnZVVGdDYW4rZmt0eVVQ?=
 =?utf-8?B?NVBRSDd0SzJDSVphQUFYeHByUzI0NjBJb3g1bmdZL1BGZzRoaGx3Tm1DTTRh?=
 =?utf-8?B?Sml0Uldvc3V0SG9hbi81WCtQOVl6empwNkJvRG5oWnV3Mnc4UjE2a2pTVnh6?=
 =?utf-8?B?OUlxRGFoTDA3MmFKM0IxenI5eGlIeFFYRjIzNmszNnNYU1JYZDVKaGxWdjNI?=
 =?utf-8?B?S25MSGdMbVNVS2hYRUNya1NpMk9NWDR0Q2hiS21vWktscGpKS2F2QT09?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fb9b3014-79df-4982-d588-08de62f0c236
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 06:52:12.8148 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gz4PsRXni1KtEcadPYyVAYxpd1SuqHDFAxSMsCBnOQUI34V+grTp1Geg6z71avQjXbz9AYQ0GeXg+lQjY7yvCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P195MB3205
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



On 1/22/26 9:08 PM, Anshul Dalal wrote:
> This patch refactors the nodes in each board's R5 device-tree to common
> SoC level dtsi. No functional change is intended from this patch.
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
> I have verified the DT delta before and after the patch and there is
> no difference except for the addition of "tick-timer" under /aliases and
> "clock-names" under the a53/a72 cores on some platforms which should
> cause no functional change. An exhaustive diff for all DTs is provided
> below[1].
> 
> The following affected platforms have not been boot tested:
>   - k3-am625-r5-beagleplay
>   - k3-am67a-r5-beagley-ai
>   - k3-am642-r5-phycore-som-2gb
>   - k3-am625-r5-phycore-som-2gb
>   - k3-am62a7-r5-phycore-som-2gb

For the phycore-soms:

Tested-by: Wadim Egorov <w.egorov@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

The only thing I noticed is that the a53_0 clocks are redefined in our 
files. This can be dropped I guess, but should not be part of this patch.

Thanks.


>   - k3-am625-verdin-r5
>   - k3-am62p5-verdin-r5
> 
> Though I'm not sure if the patch should be split per SoC for ease of
> review?
> 
> [1]:
> 
>    k3-am625-r5-beagleplay:
>     --- build/before/spl/u-boot-spl.dtb
>     +++ build/after/spl/u-boot-spl.dtb
>     @@ -31,6 +31,7 @@
>      		remoteproc0 = "/bus@f0000/sysctrler";
>      		remoteproc1 = "/a53@0";
>      		serial2 = "/bus@f0000/serial@2800000";
>     +		tick-timer = "/bus@f0000/timer@2400000";
>      		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>      	};
> 
>    k3-am625-r5-phycore-som-2gb:
>     --- build/before/spl/u-boot-spl.dtb
>     +++ build/after/spl/u-boot-spl.dtb
>     @@ -10,6 +10,7 @@
>      		assigned-clock-parents = <0x02 0x3d 0x02>;
>      		assigned-clock-rates = <0xbebc200 0x47868c00>;
>      		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
>     +		clock-names = "gtc";
>      		clocks = <0x02 0x3d 0x00>;
>      		compatible = "ti,am654-rproc";
>      		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
>     @@ -31,6 +32,7 @@
>      		serial2 = "/bus@f0000/serial@2800000";
>      		serial3 = "/bus@f0000/serial@2810000";
>      		spi0 = "/bus@f0000/bus@fc00000/spi@fc40000";
>     +		tick-timer = "/bus@f0000/timer@2400000";
>      		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>      	};
> 
>    k3-am625-verdin-r5:
>     --- build/before/spl/u-boot-spl.dtb
>     +++ build/after/spl/u-boot-spl.dtb
>     @@ -10,6 +10,7 @@
>      		assigned-clock-parents = <0x02 0x3d 0x02 0x00 0x02 0x9d 0x16>;
>      		assigned-clock-rates = <0xbebc200 0x2faf0800 0x17d7840>;
>      		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00 0x02 0x9d 0x14>;
>     +		clock-names = "gtc", "core";
>      		clocks = <0x02 0x3d 0x00>;
>      		compatible = "ti,am654-rproc";
>      		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0xa6 0x01>;
>     @@ -29,6 +30,7 @@
>      		serial0 = "/bus@f0000/serial@2810000";
>      		serial1 = "/bus@f0000/bus@b00000/target-module@2b300050/serial@0";
>      		serial2 = "/bus@f0000/serial@2800000";
>     +		tick-timer = "/bus@f0000/timer@2400000";
>      		usb0 = "/bus@f0000/dwc3-usb@f900000/usb@31000000";
>      	};
> 
>    k3-am62a7-r5-phycore-som-2gb:
>     --- build/before/spl/u-boot-spl.dtb
>     +++ build/after/spl/u-boot-spl.dtb
>     @@ -10,6 +10,7 @@
>      		assigned-clock-parents = <0x02 0x3d 0x02>;
>      		assigned-clock-rates = <0xbebc200 0x47868c00>;
>      		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
>     +		clock-names = "gtc";
>      		clocks = <0x02 0x3d 0x00>;
>      		compatible = "ti,am654-rproc";
> 
> power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0k3-am642-r5-phycore-som-2gbxa6 0x01>;:
>     --- build/before/spl/u-boot-spl.dtb
>     +++ build/after/spl/u-boot-spl.dtb
>     @@ -10,6 +10,7 @@
>      		assigned-clock-parents = <0x02 0x3d 0x02>;
>      		assigned-clock-rates = <0xbebc200 0x3b9aca00>;
>      		assigned-clocks = <0x02 0x3d 0x00 0x02 0x87 0x00>;
>     +		clock-names = "gtc";
>      		clocks = <0x02 0x3d 0x00>;
>      		compatible = "ti,am654-rproc";
>      		power-domains = <0x03 0x3d 0x01 0x03 0x87 0x01 0x03 0x89 0x01>;
> ---
>   arch/arm/dts/k3-am62-r5-lp-sk.dts              | 82 +-----------------------
>   arch/arm/dts/k3-am625-r5-beagleplay.dts        | 72 +++------------------
>   arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts   | 76 ++--------------------
>   arch/arm/dts/k3-am625-r5-sk.dts                | 86 +------------------------
>   arch/arm/dts/k3-am625-r5.dtsi                  | 88 ++++++++++++++++++++++++++
>   arch/arm/dts/k3-am625-verdin-r5.dts            | 81 ++++++------------------
>   arch/arm/dts/k3-am6254atl-r5-sk.dts            | 86 +------------------------
>   arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts  | 58 ++---------------
>   arch/arm/dts/k3-am62a7-r5-sk.dts               | 60 +-----------------
>   arch/arm/dts/k3-am62a7-r5.dtsi                 | 69 ++++++++++++++++++++
>   arch/arm/dts/k3-am62d2-r5-evm.dts              | 72 +--------------------
>   arch/arm/dts/k3-am62d2-r5.dtsi                 | 75 ++++++++++++++++++++++
>   arch/arm/dts/k3-am62p5-r5-sk.dts               | 69 +-------------------
>   arch/arm/dts/k3-am62p5-r5.dtsi                 | 77 ++++++++++++++++++++++
>   arch/arm/dts/k3-am62p5-verdin-r5.dts           | 76 ++--------------------
>   arch/arm/dts/k3-am642-r5-evm.dts               | 81 +-----------------------
>   arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts   | 76 ++--------------------
>   arch/arm/dts/k3-am642-r5-sk.dts                | 81 +-----------------------
>   arch/arm/dts/k3-am642-r5.dtsi                  | 84 ++++++++++++++++++++++++
>   arch/arm/dts/k3-am654-r5-base-board.dts        | 74 +---------------------
>   arch/arm/dts/k3-am654-r5.dtsi                  | 77 ++++++++++++++++++++++
>   arch/arm/dts/k3-am67a-r5-beagley-ai.dts        | 67 +-------------------
>   arch/arm/dts/k3-am67a-r5.dtsi                  | 70 ++++++++++++++++++++
>   arch/arm/dts/k3-j7200-r5-common-proc-board.dts | 82 +-----------------------
>   arch/arm/dts/k3-j7200-r5.dtsi                  | 86 +++++++++++++++++++++++++
>   arch/arm/dts/k3-j722s-r5-evm.dts               | 81 +-----------------------
>   arch/arm/dts/k3-j722s-r5.dtsi                  | 84 ++++++++++++++++++++++++
>   27 files changed, 768 insertions(+), 1302 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62-r5-lp-sk.dts b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> index 95cd9b707c7..2d89c204981 100644
> --- a/arch/arm/dts/k3-am62-r5-lp-sk.dts
> +++ b/arch/arm/dts/k3-am62-r5-lp-sk.dts
> @@ -9,84 +9,4 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am62-lp-sk-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		tick-timer = &main_timer0;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial3 = &main_uart1;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> -
> -/* WKUP UART0 is used for DM firmware logs */
> -&wkup_uart0 {
> -	status = "okay";
> -};
> -
> -/* Main UART1 is used for TIFS firmware logs */
> -&main_uart1 {
> -	status = "okay";
> -};
> +#include "k3-am625-r5.dtsi"
> diff --git a/arch/arm/dts/k3-am625-r5-beagleplay.dts b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> index bba69871fd2..fb0b83b83f1 100644
> --- a/arch/arm/dts/k3-am625-r5-beagleplay.dts
> +++ b/arch/arm/dts/k3-am625-r5-beagleplay.dts
> @@ -11,70 +11,14 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am625-beagleplay-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1250000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> +#include "k3-am625-r5.dtsi"
> +
> +&a53_0 {
> +	power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>;
> +	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +	assigned-clock-parents = <&k3_clks 61 2>;
> +	assigned-clock-rates = <200000000>, <1250000000>;
>   };
>   
>   &main_pktdma {
> diff --git a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> index 0f2c592593e..46b621242b5 100644
> --- a/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am625-r5-phycore-som-2gb.dts
> @@ -10,42 +10,9 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am625-phyboard-lyra-rdk-u-boot.dtsi"
> +#include "k3-am625-r5.dtsi"
>   
>   / {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial3 = &main_uart1;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>;
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -
>   	memory@80000000 {
>   		device_type = "memory";
>   		/* 2G RAM */
> @@ -54,42 +21,16 @@
>   	};
>   };
>   
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> +&a53_0 {
> +	clock-names = "gtc";
> +	clocks = <&k3_clks 61 0>;
>   };
>   
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&main_bcdma {
> +&main_pktdma {
>   	ti,sci = <&dm_tifs>;
>   };
>   
> -&main_pktdma {
> +&main_bcdma {
>   	ti,sci = <&dm_tifs>;
>   };
>   
> @@ -105,11 +46,6 @@
>   	};
>   };
>   
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x08000000>;
> -};
> -
>   /* WKUP UART0 is used for DM firmware logs */
>   &wkup_uart0 {
>   	pinctrl-names = "default";
> diff --git a/arch/arm/dts/k3-am625-r5-sk.dts b/arch/arm/dts/k3-am625-r5-sk.dts
> index 67589f941ba..9dbcd36e002 100644
> --- a/arch/arm/dts/k3-am625-r5-sk.dts
> +++ b/arch/arm/dts/k3-am625-r5-sk.dts
> @@ -9,92 +9,8 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am625-sk-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		tick-timer = &main_timer0;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial3 = &main_uart1;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> -
> -/* WKUP UART0 is used for DM firmware logs */
> -&wkup_uart0 {
> -	status = "okay";
> -};
> -
> -/* Main UART1 is used for TIFS firmware logs */
> -&main_uart1 {
> -	status = "okay";
> -};
> -
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x08000000>;
> -};
> +#include "k3-am625-r5.dtsi"
>   
>   &main_pktdma {
>   	ti,sci = <&dm_tifs>;
> -	bootph-all;
>   };
> diff --git a/arch/arm/dts/k3-am625-r5.dtsi b/arch/arm/dts/k3-am625-r5.dtsi
> new file mode 100644
> index 00000000000..c509857ac5d
> --- /dev/null
> +++ b/arch/arm/dts/k3-am625-r5.dtsi
> @@ -0,0 +1,88 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		tick-timer = &main_timer0;
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial3 = &main_uart1;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&secure_proxy_sa3 {
> +	/* We require this for boot handshake */
> +	status = "okay";
> +};
> +
> +&cbass_main {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +};
> +
> +/* WKUP UART0 is used for DM firmware logs */
> +&wkup_uart0 {
> +	status = "okay";
> +};
> +
> +/* Main UART1 is used for TIFS firmware logs */
> +&main_uart1 {
> +	status = "okay";
> +};
> +
> +&ospi0 {
> +	reg = <0x00 0x0fc40000 0x00 0x100>,
> +	      <0x00 0x60000000 0x00 0x08000000>;
> +};
> diff --git a/arch/arm/dts/k3-am625-verdin-r5.dts b/arch/arm/dts/k3-am625-verdin-r5.dts
> index fb431c96337..dfd960aaf3c 100644
> --- a/arch/arm/dts/k3-am625-verdin-r5.dts
> +++ b/arch/arm/dts/k3-am625-verdin-r5.dts
> @@ -9,75 +9,30 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am625-verdin-wifi-dev-u-boot.dtsi"
> +#include "k3-am625-r5.dtsi"
>   
>   / {
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		/*
> -		 * FIXME: Currently only the SPL running on the R5 has a clock
> -		 * driver. As a workaround therefore move the assigned-clock
> -		 * stuff required for our ETH_25MHz_CLK from the cpsw3g_mdio
> -		 * node of the regular device tree to here (last one each in
> -		 * below three lines, adding a <0> as spacing for parents).
> -		 */
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
> -		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
> -		assigned-clock-rates = <200000000>, <800000000>, <25000000>;
> -		clocks = <&k3_clks 61 0>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-host-id = <10>;
> -		ti,sci-proc-id = <32>;
> -		bootph-pre-ram;
> -	};
> -
>   	aliases {
> +		serial0 = &main_uart1;
> +		serial1 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +		serial3 = &mcu_uart0;
> +		serial4 = &main_uart5;
>   		remoteproc0 = &sysctrler;
>   		remoteproc1 = &a53_0;
>   	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
>   };
>   
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> +&a53_0 {
> +	clocks = <&k3_clks 61 0>;
> +	/*
> +	 * FIXME: Currently only the SPL running on the R5 has a clock
> +	 * driver. As a workaround therefore move the assigned-clock
> +	 * stuff required for our ETH_25MHz_CLK from the cpsw3g_mdio
> +	 * node of the regular device tree to here (last one each in
> +	 * below three lines, adding a <0> as spacing for parents).
> +	 */
> +	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 20>;
> +	assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 22>;
> +	assigned-clock-rates = <200000000>, <800000000>, <25000000>;
>   };
> diff --git a/arch/arm/dts/k3-am6254atl-r5-sk.dts b/arch/arm/dts/k3-am6254atl-r5-sk.dts
> index 225ad44e722..02a950a9a07 100644
> --- a/arch/arm/dts/k3-am6254atl-r5-sk.dts
> +++ b/arch/arm/dts/k3-am6254atl-r5-sk.dts
> @@ -11,92 +11,8 @@
>   #include "k3-am62-ddr.dtsi"
>   
>   #include "k3-am6254atl-sk-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		tick-timer = &main_timer0;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial3 = &main_uart1;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* We require this for boot handshake */
> -	status = "okay";
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>, <&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> -
> -/* WKUP UART0 is used for DM firmware logs */
> -&wkup_uart0 {
> -	status = "okay";
> -};
> -
> -/* Main UART1 is used for TIFS firmware logs */
> -&main_uart1 {
> -	status = "okay";
> -};
> -
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x08000000>;
> -};
> +#include "k3-am625-r5.dtsi"
>   
>   &main_pktdma {
>   	ti,sci = <&dm_tifs>;
> -	bootph-all;
>   };
> diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> index 96860e80e9a..b54cd9d48a4 100644
> --- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> @@ -13,48 +13,18 @@
>   #include "k3-am62a-ddr.dtsi"
>   
>   #include "k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi"
> +#include "k3-am62a7-r5.dtsi"
>   
>   / {
>   	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
>   		serial0 = &wkup_uart0;
>   		serial3 = &main_uart1;
>   	};
> +};
>   
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>;
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -
> -	memory@80000000 {
> -		device_type = "memory";
> -		/* 2G RAM */
> -		reg = <0x00000000 0x80000000 0x00000000 0x80000000>;
> -		bootph-pre-ram;
> -	};
> +&a53_0 {
> +	clocks = <&k3_clks 61 0>;
> +	clock-names = "gtc";
>   };
>   
>   &cbass_main {
> @@ -79,24 +49,6 @@
>   	};
>   };
>   
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -	bootph-pre-ram;
> -};
> -
>   &main_bcdma {
>   	ti,sci = <&dm_tifs>;
>   };
> diff --git a/arch/arm/dts/k3-am62a7-r5-sk.dts b/arch/arm/dts/k3-am62a7-r5-sk.dts
> index 64923c2c710..4570ff6edbf 100644
> --- a/arch/arm/dts/k3-am62a7-r5-sk.dts
> +++ b/arch/arm/dts/k3-am62a7-r5-sk.dts
> @@ -9,50 +9,12 @@
>   #include "k3-am62a-ddr.dtsi"
>   
>   #include "k3-am62a7-sk-u-boot.dtsi"
> +#include "k3-am62a7-r5.dtsi"
>   
>   / {
>   	aliases {
>   		tick-timer = &main_timer0;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
>   	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
>   };
>   
>   &secure_proxy_sa3 {
> @@ -61,26 +23,6 @@
>   	bootph-pre-ram;
>   };
>   
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -	bootph-pre-ram;
> -};
> -
>   &wkup_uart0_pins_default {
>   	bootph-pre-ram;
>   };
> diff --git a/arch/arm/dts/k3-am62a7-r5.dtsi b/arch/arm/dts/k3-am62a7-r5.dtsi
> new file mode 100644
> index 00000000000..1cb8bdbb78d
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62a7-r5.dtsi
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-pre-ram;
> +	};
> +
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&cbass_main {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&secure_proxy_sa3 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/k3-am62d2-r5-evm.dts b/arch/arm/dts/k3-am62d2-r5-evm.dts
> index a3213d00145..62f337e0131 100644
> --- a/arch/arm/dts/k3-am62d2-r5-evm.dts
> +++ b/arch/arm/dts/k3-am62d2-r5-evm.dts
> @@ -9,74 +9,4 @@
>   #include "k3-am62a-ddr.dtsi"
>   
>   #include "k3-am62d2-evm-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		tick-timer = &main_timer0;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&secure_proxy_sa3 {
> -	/* Needed for initial handshake with ROM */
> -	status = "okay";
> -	bootph-pre-ram;
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&secure_proxy_sa3 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -	bootph-pre-ram;
> -};
> +#include "k3-am62d2-r5.dtsi"
> diff --git a/arch/arm/dts/k3-am62d2-r5.dtsi b/arch/arm/dts/k3-am62d2-r5.dtsi
> new file mode 100644
> index 00000000000..23dfc49c2ea
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62d2-r5.dtsi
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		tick-timer = &main_timer0;
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&secure_proxy_sa3 {
> +	/* Needed for initial handshake with ROM */
> +	status = "okay";
> +	bootph-pre-ram;
> +};
> +
> +&cbass_main {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&secure_proxy_sa3 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +	bootph-pre-ram;
> +};
> diff --git a/arch/arm/dts/k3-am62p5-r5-sk.dts b/arch/arm/dts/k3-am62p5-r5-sk.dts
> index e45d2bf6a0b..9a09360c242 100644
> --- a/arch/arm/dts/k3-am62p5-r5-sk.dts
> +++ b/arch/arm/dts/k3-am62p5-r5-sk.dts
> @@ -9,81 +9,14 @@
>   
>   #include "k3-am62p-ddr-lp4-50-1600.dtsi"
>   #include "k3-am62a-ddr.dtsi"
> +#include "k3-am62p5-r5.dtsi"
>   
>   / {
>   	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
>   		serial0 = &wkup_uart0;
>   		serial2 = &main_uart0;
>   		serial3 = &main_uart1;
>   	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-all;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 20>,
> -			<&secure_proxy_main 21>;
> -		bootph-all;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&cbass_main {
> -	sa3_secproxy: secproxy@44880000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg = <0x00 0x44880000 0x00 0x20000>,
> -		      <0x00 0x44860000 0x00 0x20000>,
> -		      <0x00 0x43600000 0x00 0x10000>;
> -		reg-names = "rt", "scfg", "target_data";
> -		bootph-all;
> -	};
> -
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&sa3_secproxy 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-all;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
>   };
>   
>   /* WKUP UART0 is used for DM firmware logs */
> diff --git a/arch/arm/dts/k3-am62p5-r5.dtsi b/arch/arm/dts/k3-am62p5-r5.dtsi
> new file mode 100644
> index 00000000000..338bd73e1c0
> --- /dev/null
> +++ b/arch/arm/dts/k3-am62p5-r5.dtsi
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-all;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 20>,
> +			<&secure_proxy_main 21>;
> +		bootph-all;
> +	};
> +};
> +
> +&cbass_main {
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x00 0x44860000 0x00 0x20000>,
> +		      <0x00 0x43600000 0x00 0x10000>;
> +		reg-names = "rt", "scfg", "target_data";
> +		bootph-all;
> +	};
> +
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&sa3_secproxy 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-all;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +};
> diff --git a/arch/arm/dts/k3-am62p5-verdin-r5.dts b/arch/arm/dts/k3-am62p5-verdin-r5.dts
> index 17739086935..b1735b363ba 100644
> --- a/arch/arm/dts/k3-am62p5-verdin-r5.dts
> +++ b/arch/arm/dts/k3-am62p5-verdin-r5.dts
> @@ -9,76 +9,10 @@
>   #include "k3-am62a-ddr.dtsi"
>   
>   #include "k3-am62p5-verdin-wifi-dev-u-boot.dtsi"
> +#include "k3-am62p5-r5.dtsi"
>   
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 36>;
> -		assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 38>;
> -		assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-all;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 20>,
> -			<&secure_proxy_main 21>;
> -		bootph-all;
> -	};
> -};
> -
> -&cbass_main {
> -	sa3_secproxy: secproxy@44880000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg = <0x00 0x44880000 0x00 0x20000>,
> -		      <0x00 0x44860000 0x00 0x20000>,
> -		      <0x00 0x43600000 0x00 0x10000>;
> -		reg-names = "rt", "scfg", "target_data";
> -		bootph-all;
> -	};
> -
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&sa3_secproxy 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-all;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> +&a53_0 {
> +	assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>, <&k3_clks 157 36>;
> +	assigned-clock-parents = <&k3_clks 61 2>, <0>, <&k3_clks 157 38>;
> +	assigned-clock-rates = <200000000>, <1200000000>, <25000000>;
>   };
> diff --git a/arch/arm/dts/k3-am642-r5-evm.dts b/arch/arm/dts/k3-am642-r5-evm.dts
> index 67b8587d3b2..e3d363a8e39 100644
> --- a/arch/arm/dts/k3-am642-r5-evm.dts
> +++ b/arch/arm/dts/k3-am642-r5-evm.dts
> @@ -8,56 +8,7 @@
>   #include "k3-am64-ddr.dtsi"
>   
>   #include "k3-am642-evm-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1000000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	clk_200mhz: dummy-clock-200mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <200000000>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> +#include "k3-am642-r5.dtsi"
>   
>   &memorycontroller {
>   	vtt-supply = <&vtt_supply>;
> @@ -72,33 +23,3 @@
>   	clocks = <&clk_200mhz>;
>   	clock-names = "clk_xin";
>   };
> -
> -/* UART is initialized before SYSFW is started
> - * so we can't do any power-domain/clock operations.
> - * Delete clock/power-domain properties to avoid
> - * UART init failure
> - */
> -&main_uart0 {
> -	/delete-property/ power-domains;
> -	/delete-property/ clocks;
> -	/delete-property/ clock-names;
> -};
> -
> -/* timer init is called as part of rproc_start() while
> - * starting System Firmware, so any clock/power-domain
> - * operations will fail as SYSFW is not yet up and running.
> - * Delete all clock/power-domain properties to avoid
> - * timer init failure.
> - * This is an always on timer at 20MHz.
> - */
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	/delete-property/ power-domains;
> -};
> -
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x8000000>;
> -};
> diff --git a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> index d27fc7fa882..4b7a63db4ce 100644
> --- a/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am642-r5-phycore-som-2gb.dts
> @@ -14,83 +14,15 @@
>   #include "k3-am64-ddr.dtsi"
>   
>   #include "k3-am642-phyboard-electra-rdk-u-boot.dtsi"
> +#include "k3-am642-r5.dtsi"
>   
>   / {
>   	aliases {
>   		ethernet0 = &cpsw3g;
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
>   	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>;
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1000000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	clk_200mhz: dummy-clock-200mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <200000000>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -/* timer init is called as part of rproc_start() while
> - * starting System Firmware, so any clock/power-domain
> - * operations will fail as SYSFW is not yet up and running.
> - * Delete all clock/power-domain properties to avoid
> - * timer init failure.
> - * This is an always on timer at 20MHz.
> - */
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	/delete-property/ power-domains;
> -};
> -
> -/* UART is initialized before SYSFW is started
> - * so we can't do any power-domain/clock operations.
> - * Delete clock/power-domain properties to avoid
> - * UART init failure
> - */
> -&main_uart0 {
> -	/delete-property/ power-domains;
> -	/delete-property/ clocks;
> -	/delete-property/ clock-names;
>   };
>   
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x08000000>;
> +&a53_0 {
> +	clock-names = "gtc";
> +	clocks = <&k3_clks 61 0>;
>   };
> diff --git a/arch/arm/dts/k3-am642-r5-sk.dts b/arch/arm/dts/k3-am642-r5-sk.dts
> index cfc548a1cea..27f3e87fb90 100644
> --- a/arch/arm/dts/k3-am642-r5-sk.dts
> +++ b/arch/arm/dts/k3-am642-r5-sk.dts
> @@ -8,56 +8,7 @@
>   #include "k3-am64-ddr.dtsi"
>   
>   #include "k3-am642-sk-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1000000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	clk_200mhz: dummy-clock-200mhz {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <200000000>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&cbass_main {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> +#include "k3-am642-r5.dtsi"
>   
>   &sdhci1 {
>   	clocks = <&clk_200mhz>;
> @@ -67,33 +18,3 @@
>   &serdes_wiz0 {
>   	status = "okay";
>   };
> -
> -/* UART is initialized before SYSFW is started
> - * so we can't do any power-domain/clock operations.
> - * Delete clock/power-domain properties to avoid
> - * UART init failure
> - */
> -&main_uart0 {
> -	/delete-property/ power-domains;
> -	/delete-property/ clocks;
> -	/delete-property/ clock-names;
> -};
> -
> -/* timer init is called as part of rproc_start() while
> - * starting System Firmware, so any clock/power-domain
> - * operations will fail as SYSFW is not yet up and running.
> - * Delete all clock/power-domain properties to avoid
> - * timer init failure.
> - * This is an always on timer at 20MHz.
> - */
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	/delete-property/ power-domains;
> -};
> -
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> - 	      <0x00 0x60000000 0x00 0x8000000>;
> -};
> diff --git a/arch/arm/dts/k3-am642-r5.dtsi b/arch/arm/dts/k3-am642-r5.dtsi
> new file mode 100644
> index 00000000000..71e1f9d1de6
> --- /dev/null
> +++ b/arch/arm/dts/k3-am642-r5.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 137 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1000000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	clk_200mhz: dummy-clock-200mhz {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <200000000>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&cbass_main {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>, <&secure_proxy_main 0>;
> +		mbox-names = "tx", "rx";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +/* UART is initialized before SYSFW is started
> + * so we can't do any power-domain/clock operations.
> + * Delete clock/power-domain properties to avoid
> + * UART init failure
> + */
> +&main_uart0 {
> +	/delete-property/ power-domains;
> +	/delete-property/ clocks;
> +	/delete-property/ clock-names;
> +};
> +
> +/* timer init is called as part of rproc_start() while
> + * starting System Firmware, so any clock/power-domain
> + * operations will fail as SYSFW is not yet up and running.
> + * Delete all clock/power-domain properties to avoid
> + * timer init failure.
> + * This is an always on timer at 20MHz.
> + */
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	/delete-property/ power-domains;
> +};
> +
> +&ospi0 {
> +	reg = <0x00 0x0fc40000 0x00 0x100>,
> +	      <0x00 0x60000000 0x00 0x8000000>;
> +};
> diff --git a/arch/arm/dts/k3-am654-r5-base-board.dts b/arch/arm/dts/k3-am654-r5-base-board.dts
> index 99eb8a2d442..30eb3a9ade9 100644
> --- a/arch/arm/dts/k3-am654-r5-base-board.dts
> +++ b/arch/arm/dts/k3-am654-r5-base-board.dts
> @@ -9,74 +9,7 @@
>   #include "k3-am654-base-board-u-boot.dtsi"
>   #include "k3-am654-base-board-ddr4-1600MTs.dtsi"
>   #include "k3-am654-ddr.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x0 0x00a90000 0x0 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 202 0>;
> -		assigned-clock-rates = <800000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	clk_200mhz: dummy_clock {
> -		compatible = "fixed-clock";
> -		#clock-cells = <0>;
> -		clock-frequency = <200000000>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&secure_proxy_mcu {
> -	status = "okay";
> -	bootph-pre-ram;
> -};
> -
> -&cbass_wakeup {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -/*
> - * timer init is called as part of rproc_start() while
> - * starting System Firmware, so any clock/power-domain
> - * operations will fail as SYSFW is not yet up and running.
> - * Delete all clock/power-domain properties to avoid
> - * timer init failure.
> - * This is an always on timer at 20MHz.
> - */
> -&mcu_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	/delete-property/ power-domains;
> -};
> -
> -&dmsc {
> -	mboxes = <&secure_proxy_mcu 8>,
> -		 <&secure_proxy_mcu 6>,
> -		 <&secure_proxy_mcu 5>;
> -	mbox-names = "tx", "rx", "notify";
> -	ti,host-id = <4>;
> -	ti,secure-host;
> -};
> +#include "k3-am654-r5.dtsi"
>   
>   &wkup_uart0 {
>   	status = "okay";
> @@ -128,11 +61,6 @@
>   	/delete-property/ power-domains;
>   };
>   
> -&ospi0 {
> -	reg = <0x0 0x47040000 0x0 0x100>,
> -	      <0x0 0x50000000 0x0 0x8000000>;
> -};
> -
>   &dwc3_0 {
>   	status = "okay";
>   	/delete-property/ clocks;
> diff --git a/arch/arm/dts/k3-am654-r5.dtsi b/arch/arm/dts/k3-am654-r5.dtsi
> new file mode 100644
> index 00000000000..1762c1457d9
> --- /dev/null
> +++ b/arch/arm/dts/k3-am654-r5.dtsi
> @@ -0,0 +1,77 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x0 0x00a90000 0x0 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 202 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 202 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 202 0>;
> +		assigned-clock-rates = <800000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	clk_200mhz: dummy_clock {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <200000000>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&secure_proxy_mcu {
> +	status = "okay";
> +	bootph-pre-ram;
> +};
> +
> +&cbass_wakeup {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_mcu 4>, <&secure_proxy_mcu 5>;
> +		mbox-names = "tx", "rx";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes = <&secure_proxy_mcu 8>,
> +		 <&secure_proxy_mcu 6>,
> +		 <&secure_proxy_mcu 5>;
> +	mbox-names = "tx", "rx", "notify";
> +	ti,host-id = <4>;
> +	ti,secure-host;
> +};
> +
> +&ospi0 {
> +	reg = <0x0 0x47040000 0x0 0x100>,
> +	      <0x0 0x50000000 0x0 0x8000000>;
> +};
> +
> +/*
> + * timer init is called as part of rproc_start() while
> + * starting System Firmware, so any clock/power-domain
> + * operations will fail as SYSFW is not yet up and running.
> + * Delete all clock/power-domain properties to avoid
> + * timer init failure.
> + * This is an always on timer at 20MHz.
> + */
> +&mcu_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	/delete-property/ power-domains;
> +};
> diff --git a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> index 45d104e8e3f..61ee75b7432 100644
> --- a/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> +++ b/arch/arm/dts/k3-am67a-r5-beagley-ai.dts
> @@ -11,72 +11,7 @@
>   
>   #include "k3-am67a-beagley-ddr-lp4.dtsi"
>   #include "k3-am62a-ddr.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial2 = &main_uart0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>;
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1200000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-all;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 22>,
> -			<&secure_proxy_main 23>;
> -		bootph-all;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&cbass_main {
> -	sa3_secproxy: secproxy@44880000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg = <0x00 0x44880000 0x00 0x20000>,
> -		      <0x00 0x44860000 0x00 0x20000>,
> -		      <0x00 0x43600000 0x00 0x10000>;
> -		reg-names = "rt", "scfg", "target_data";
> -		bootph-all;
> -	};
> -
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&sa3_secproxy 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-all;
> -	};
> -};
> +#include "k3-am67a-r5.dtsi"
>   
>   /* WKUP UART0 is used for DM firmware logs */
>   &wkup_uart0 {
> diff --git a/arch/arm/dts/k3-am67a-r5.dtsi b/arch/arm/dts/k3-am67a-r5.dtsi
> new file mode 100644
> index 00000000000..48bd15f480f
> --- /dev/null
> +++ b/arch/arm/dts/k3-am67a-r5.dtsi
> @@ -0,0 +1,70 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>;
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1200000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-all;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 22>,
> +			<&secure_proxy_main 23>;
> +		bootph-all;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&cbass_main {
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x00 0x44860000 0x00 0x20000>,
> +		      <0x00 0x43600000 0x00 0x10000>;
> +		reg-names = "rt", "scfg", "target_data";
> +		bootph-all;
> +	};
> +
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&sa3_secproxy 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-all;
> +	};
> +};
> diff --git a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> index e35b767a7e3..b0e73fe72c4 100644
> --- a/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> +++ b/arch/arm/dts/k3-j7200-r5-common-proc-board.dts
> @@ -9,92 +9,12 @@
>   #include "k3-j7200-ddr-evm-lp4-2666.dtsi"
>   #include "k3-j721e-ddr.dtsi"
>   #include "k3-j7200-common-proc-board-u-boot.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a72_0;
> -	};
> -
> -	a72_0: a72@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x0 0x00a90000 0x0 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> -				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 202 0>;
> -		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
> -		clock-names = "gtc", "core", "msmc";
> -		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>,
> -						  <&k3_clks 323 0>;
> -		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
> -		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-pre-ram;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <3>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes = <&secure_proxy_mcu 21>,
> -			<&secure_proxy_mcu 23>;
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&memorycontroller {
> -	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
> -			<&k3_pds 90 TI_SCI_PD_SHARED>;
> -	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
> -	bootph-pre-ram;
> -};
> -
> -&mcu_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <250000000>;
> -	bootph-pre-ram;
> -};
> -
> -&secure_proxy_mcu {
> -	bootph-pre-ram;
> -	status = "okay";
> -};
> -
> -&cbass_mcu_wakeup {
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_mcu 4>,
> -			<&secure_proxy_mcu 5>;
> -		mbox-names = "tx", "rx";
> -		bootph-pre-ram;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes = <&secure_proxy_mcu 8>,
> -		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> -	mbox-names = "tx", "rx", "notify";
> -	ti,host-id = <4>;
> -	ti,secure-host;
> -	bootph-pre-ram;
> -};
> +#include "k3-j7200-r5.dtsi"
>   
>   &wkup_vtm0 {
>   	bootph-pre-ram;
>   };
>   
> -&ospi0 {
> -    reg = <0x0 0x47040000 0x0 0x100>,
> -          <0x0 0x50000000 0x0 0x8000000>;
> -};
> -
>   &fss {
>   	/* enable ranges missing from the FSS node */
>   	ranges = <0x0 0x47000000 0x0 0x47000000 0x0 0x00068400>,
> diff --git a/arch/arm/dts/k3-j7200-r5.dtsi b/arch/arm/dts/k3-j7200-r5.dtsi
> new file mode 100644
> index 00000000000..6c61ba5faec
> --- /dev/null
> +++ b/arch/arm/dts/k3-j7200-r5.dtsi
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a72_0;
> +	};
> +
> +	a72_0: a72@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x0 0x00a90000 0x0 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 202 TI_SCI_PD_EXCLUSIVE>,
> +				<&k3_pds 4 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 202 0>;
> +		clocks = <&k3_clks 61 1>, <&k3_clks 202 2>, <&k3_clks 4 1> ;
> +		clock-names = "gtc", "core", "msmc";
> +		assigned-clocks = <&k3_clks 202 2>, <&k3_clks 61 1>, <&k3_clks 4 1>,
> +						  <&k3_clks 323 0>;
> +		assigned-clock-parents= <0>, <0>, <0>, <&k3_clks 323 2>;
> +		assigned-clock-rates = <2000000000>, <200000000>, <1000000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-pre-ram;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <3>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes = <&secure_proxy_mcu 21>,
> +			<&secure_proxy_mcu 23>;
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&memorycontroller {
> +	power-domains = <&k3_pds 8 TI_SCI_PD_SHARED>,
> +			<&k3_pds 90 TI_SCI_PD_SHARED>;
> +	clocks = <&k3_clks 8 5>, <&k3_clks 30 9>;
> +	bootph-pre-ram;
> +};
> +
> +&mcu_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <250000000>;
> +	bootph-pre-ram;
> +};
> +
> +&secure_proxy_mcu {
> +	bootph-pre-ram;
> +	status = "okay";
> +};
> +
> +&cbass_mcu_wakeup {
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_mcu 4>,
> +			<&secure_proxy_mcu 5>;
> +		mbox-names = "tx", "rx";
> +		bootph-pre-ram;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes = <&secure_proxy_mcu 8>,
> +		<&secure_proxy_mcu 6>, <&secure_proxy_mcu 5>;
> +	mbox-names = "tx", "rx", "notify";
> +	ti,host-id = <4>;
> +	ti,secure-host;
> +	bootph-pre-ram;
> +};
> +
> +&ospi0 {
> +	reg = <0x0 0x47040000 0x0 0x100>,
> +	      <0x0 0x50000000 0x0 0x8000000>;
> +};
> +
> diff --git a/arch/arm/dts/k3-j722s-r5-evm.dts b/arch/arm/dts/k3-j722s-r5-evm.dts
> index 02a3494a877..e1ef5d181ed 100644
> --- a/arch/arm/dts/k3-j722s-r5-evm.dts
> +++ b/arch/arm/dts/k3-j722s-r5-evm.dts
> @@ -9,92 +9,13 @@
>   
>   #include "k3-j722s-ddr-lp4-50-4000.dtsi"
>   #include "k3-am62a-ddr.dtsi"
> -
> -/ {
> -	aliases {
> -		remoteproc0 = &sysctrler;
> -		remoteproc1 = &a53_0;
> -		serial0 = &wkup_uart0;
> -		serial2 = &main_uart0;
> -	};
> -
> -	a53_0: a53@0 {
> -		compatible = "ti,am654-rproc";
> -		reg = <0x00 0x00a90000 0x00 0x10>;
> -		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> -			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> -		resets = <&k3_reset 135 0>;
> -		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		clock-names = "gtc", "core";
> -		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> -		assigned-clock-parents = <&k3_clks 61 2>;
> -		assigned-clock-rates = <200000000>, <1400000000>;
> -		ti,sci = <&dmsc>;
> -		ti,sci-proc-id = <32>;
> -		ti,sci-host-id = <10>;
> -		bootph-all;
> -	};
> -
> -	dm_tifs: dm-tifs {
> -		compatible = "ti,j721e-dm-sci";
> -		ti,host-id = <36>;
> -		ti,secure-host;
> -		mbox-names = "rx", "tx";
> -		mboxes= <&secure_proxy_main 28>,
> -			<&secure_proxy_main 29>;
> -		bootph-all;
> -	};
> -};
> -
> -&dmsc {
> -	mboxes= <&secure_proxy_main 0>,
> -		<&secure_proxy_main 1>,
> -		<&secure_proxy_main 0>;
> -	mbox-names = "rx", "tx", "notify";
> -	ti,host-id = <35>;
> -	ti,secure-host;
> -};
> -
> -&cbass_main {
> -	sa3_secproxy: secproxy@44880000 {
> -		compatible = "ti,am654-secure-proxy";
> -		#mbox-cells = <1>;
> -		reg = <0x00 0x44880000 0x00 0x20000>,
> -		      <0x00 0x44860000 0x00 0x20000>,
> -		      <0x00 0x43600000 0x00 0x10000>;
> -		reg-names = "rt", "scfg", "target_data";
> -		bootph-all;
> -	};
> -
> -	sysctrler: sysctrler {
> -		compatible = "ti,am654-tisci-rproc-r5";
> -		mboxes= <&secure_proxy_main 1>,
> -			<&secure_proxy_main 0>,
> -			<&sa3_secproxy 0>;
> -		mbox-names = "tx", "rx", "boot_notify";
> -		bootph-all;
> -	};
> -};
> -
> -&main_timer0 {
> -	/delete-property/ clocks;
> -	/delete-property/ clocks-names;
> -	/delete-property/ assigned-clocks;
> -	/delete-property/ assigned-clock-parents;
> -	clock-frequency = <25000000>;
> -};
> +#include "k3-j722s-r5.dtsi"
>   
>   /* WKUP UART0 is used for DM firmware logs */
>   &wkup_uart0 {
>   	status = "okay";
>   };
>   
> -&ospi0 {
> -	reg = <0x00 0x0fc40000 0x00 0x100>,
> -	      <0x00 0x60000000 0x00 0x08000000>;
> -};
> -
>   &main_bcdma {
>   	ti,sci = <&dm_tifs>;
>   };
> diff --git a/arch/arm/dts/k3-j722s-r5.dtsi b/arch/arm/dts/k3-j722s-r5.dtsi
> new file mode 100644
> index 00000000000..06a63fb83ba
> --- /dev/null
> +++ b/arch/arm/dts/k3-j722s-r5.dtsi
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/ {
> +	aliases {
> +		remoteproc0 = &sysctrler;
> +		remoteproc1 = &a53_0;
> +		serial0 = &wkup_uart0;
> +		serial2 = &main_uart0;
> +	};
> +
> +	a53_0: a53@0 {
> +		compatible = "ti,am654-rproc";
> +		reg = <0x00 0x00a90000 0x00 0x10>;
> +		power-domains = <&k3_pds 61 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 135 TI_SCI_PD_EXCLUSIVE>,
> +			<&k3_pds 166 TI_SCI_PD_EXCLUSIVE>;
> +		resets = <&k3_reset 135 0>;
> +		clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		clock-names = "gtc", "core";
> +		assigned-clocks = <&k3_clks 61 0>, <&k3_clks 135 0>;
> +		assigned-clock-parents = <&k3_clks 61 2>;
> +		assigned-clock-rates = <200000000>, <1400000000>;
> +		ti,sci = <&dmsc>;
> +		ti,sci-proc-id = <32>;
> +		ti,sci-host-id = <10>;
> +		bootph-all;
> +	};
> +
> +	dm_tifs: dm-tifs {
> +		compatible = "ti,j721e-dm-sci";
> +		ti,host-id = <36>;
> +		ti,secure-host;
> +		mbox-names = "rx", "tx";
> +		mboxes= <&secure_proxy_main 28>,
> +			<&secure_proxy_main 29>;
> +		bootph-all;
> +	};
> +};
> +
> +&dmsc {
> +	mboxes= <&secure_proxy_main 0>,
> +		<&secure_proxy_main 1>,
> +		<&secure_proxy_main 0>;
> +	mbox-names = "rx", "tx", "notify";
> +	ti,host-id = <35>;
> +	ti,secure-host;
> +};
> +
> +&cbass_main {
> +	sa3_secproxy: secproxy@44880000 {
> +		compatible = "ti,am654-secure-proxy";
> +		#mbox-cells = <1>;
> +		reg = <0x00 0x44880000 0x00 0x20000>,
> +		      <0x00 0x44860000 0x00 0x20000>,
> +		      <0x00 0x43600000 0x00 0x10000>;
> +		reg-names = "rt", "scfg", "target_data";
> +		bootph-all;
> +	};
> +
> +	sysctrler: sysctrler {
> +		compatible = "ti,am654-tisci-rproc-r5";
> +		mboxes= <&secure_proxy_main 1>,
> +			<&secure_proxy_main 0>,
> +			<&sa3_secproxy 0>;
> +		mbox-names = "tx", "rx", "boot_notify";
> +		bootph-all;
> +	};
> +};
> +
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +};
> +
> +&ospi0 {
> +	reg = <0x00 0x0fc40000 0x00 0x100>,
> +	      <0x00 0x60000000 0x00 0x08000000>;
> +};
> 
> ---
> base-commit: fd871fc6bb497c6ddd7b39622480b89add78f57b
> change-id: 20260122-r5_dt_refactor-4535f5177593
> 
> Best regards,

