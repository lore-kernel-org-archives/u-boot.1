Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF2B7C282C6
	for <u-boot@archiver.kernel.org>; Mon,  3 Mar 2025 09:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F161E8118B;
	Mon,  3 Mar 2025 10:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="N5evCiXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4943811B3; Mon,  3 Mar 2025 10:44:30 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE05B810EA
 for <u-boot@lists.denx.de>; Mon,  3 Mar 2025 10:44:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inGlBJE8YI9y+sQXaXtQryRmhjqcvHfhA4nZZCpTGDLl4kO2ycA8o92O2Ei9n6eAMBeGWQWnadhR1xptQNROA8oSlStPRvX9bWIQ/ddAg2ThvNlcK15Q2J7BUBjaLFa7kSXPNsW8Horukz9STBKpEPuUCDZXOH1lU+6Eul52ug0ZfehMdZhcBkfnI1Se+kdQ7wQ5MF7hFWHvdBLD5r+bi35xjCh2zLSOVYyzOYBZ3OKly9uQLN75XKbLmdoHQ5iepTIYff+bgVdEKasa+Zz37QmHCOuUheXo6pORdAqO5UjPlNOVIdh75v4NAQUtth3DSYLXZ7jt2ptnKx6ew2jtuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6kBL1r3ZRKzNBI40dKEOAO02m274mPDINnTdqig2YAU=;
 b=Bey3Ajak13TDvxxuixESoEyMl7awB+GwYjgSYbv9isEGNQVh4PQq/8ArF/3wBb2I/PS3cVUGmrMhEJH5UdE4Yqk2cGckJXfoH/7Qoa2obvyRNHXeNK6pZPRc86h9Hvapm7gdlCNbWo5CpG4gUMUyqr4BRY2tJmNGbv1ve/pGK/vOKbB7AFb6qaQ8RCWhGl6qtJL+qjC6Eommp/K88sKmS87ujT4El/rVQ0eeRnS88WW9c9S/sdcHSvkSzsoj11bjLmJ64P95Hy/GZzc5y9DR1882Sz7lpDsTLV5n3pX08T5F8rqoHA7BMlGM+CHw0JOsvQFJSH/h63YgDYwvmbBbpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6kBL1r3ZRKzNBI40dKEOAO02m274mPDINnTdqig2YAU=;
 b=N5evCiXqb9wI0eAH8usEOOBZ+oqNfwgakF7dAvRaxxP9WH1xRo+zN2SQ/9huk2TLCx6SZmAoJgtZtL5D9oWEANznOFnG962FeTBlTN1uVXiwxeY5iXsv/VxNz8BQaAUOYm/0Ssnx3HS47yS5/tkwpRL5ad/6YcjvQpfaywvAwkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7614.eurprd04.prod.outlook.com (2603:10a6:102:ea::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 09:44:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 09:44:25 +0000
Message-ID: <d5e121b9-02b4-4548-9aa7-47dbd2e7098d@cherry.de>
Date: Mon, 3 Mar 2025 10:44:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] arm64: renesas: Add TFA BL31 handoff support on
 Renesas R-Car Gen4
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250302210000.777581-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250302210000.777581-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: dc83e862-b00e-464d-83e8-08dd5a37fbb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SC94N05PL1BsVGpQc0hYRmw1RG5PdmNVbGxUcWQ5YzhZVWM1UVU3cHoxb3Fv?=
 =?utf-8?B?c3V0U1I4RjVqWlpudjZMcnFycGRlNm5GZlA5SG1SeE1PK01RTWN5RlF4ZU5C?=
 =?utf-8?B?UXFBQnljcVdESXY2Z21uL0hKRjNwQldWKzRiVGY3UGw3KzdLNHB4aEUvYkVa?=
 =?utf-8?B?Z3NBMDMwcG5UcURwN1RvL0dCTkk1eW9icWVibmw5M2VhckJqb05NOWZqZWZ3?=
 =?utf-8?B?RTloVnpuY2JVKzJ2bFFZZVlMRnRWVXN0WFRualhHT2pnRmNrM3RGSkVwNElL?=
 =?utf-8?B?Mno3bmxpMVh0Z09DS3BRekttRG8vTWZZWkttTEJTT0Nvd05PWisvVE1NK01y?=
 =?utf-8?B?R0ZFbnl0MXlXWE5FcjYzTyt6eUxLdWlNL3JJMTlGR2UzR2h4QkRweEVNVGxk?=
 =?utf-8?B?VVhlSmIxNy8xVWVFZDBOT09aVXlSdGI1SlFBSDZYUDVHemhGY2xrRHpabmFq?=
 =?utf-8?B?cjUxcmNVQ0xmMERoa0VrSVh0NlJydm1FQ25ma0ducCtJa3MyMUZmUEtXcGVl?=
 =?utf-8?B?N0pnM2Q1SmpUUlNRbDlYUUJIVXVHczI0Y1IwZ1o5aytBS1kzQS81L3hUZmw5?=
 =?utf-8?B?eHZNQzJyUXFiTUpUMUFZcHp0NXc1VkoyeVB6NDQ0YUpBTkV0L1BuKzVMY0c1?=
 =?utf-8?B?bDk2S3pFZ1paZWZ4QWhDVWhIdWtBK2RHa2w3NCszbDZHakM3RStUeUlxRmtv?=
 =?utf-8?B?bjhpekN0T2k3alBiNzJtNEU4dHV3eFZ3SHFqZndqdFZaSjlPQXljWC9SZ0d4?=
 =?utf-8?B?cERPc0NJKytPbWp2QkNzVHltSUZMSHdzU252N3YrT0V2d2dZVUt5UE1TalNn?=
 =?utf-8?B?dXhiS3h2eC84ckczbElIMlM2Rm5xbU02WDlMbFVMakdRV1plWklZajZwZFZ4?=
 =?utf-8?B?SWFkcDNFeEl4OE5CZXhrU2JWQisvcWhTYVRXSlM5QUo1NXUyRitDY2JqZU04?=
 =?utf-8?B?U0VYa2htQmF0UDJ6aE1KMjFrcWNXTEtuRnd4YmtGbU9FMkZYSHVYdWdSeW9y?=
 =?utf-8?B?bE1qemlDOVhHK2dFVS8vbEd1MTV5aDJnelBlRWpxSklpZVZKalBpOWl2c1RS?=
 =?utf-8?B?b01yOEFqK3l3THpKOHNnOFc1ZlovOGZBMXFYMTBvUzFxOEJGSG5IN0FOQWY0?=
 =?utf-8?B?eUtKMlhlZzZzZnB2MW1UeElEcU5FeWhBTDM5MnZqb0p5cVU0VVJyY25tbysx?=
 =?utf-8?B?czNHdWQxMFphWSsrTTQ3RElVL0lPN2pSU3RTRzJSV1kzQytpMDduUGw2R0lz?=
 =?utf-8?B?TzZUcUMxOHBlZFhiUXVHTTV6bEhFd2RrU2VnUVUwUThWamtvZGRtZlFMSHVn?=
 =?utf-8?B?UjluUHdWbk1XbmpZZm1xT2ptcnhlMkZGVFFDejlUNTFXaUtQU2NteHFRWW5n?=
 =?utf-8?B?Y3NxK2ZKaUFLZk5qZjFxRFF6VEhwSjNaWjFDZUpyVlAyL0crME44aE84dFA1?=
 =?utf-8?B?OWthczhjYmk3emxNemhYUFlyeWU2OGlEbk55SGtMaDZ0TDBkQ2FWS3hKTDVJ?=
 =?utf-8?B?ZWpRdDZCQmdnSERMaDRpdGYvUDZvV0pDM1ZLdjQremNQcHpPRDM4YWZOekZr?=
 =?utf-8?B?a25aN2d1OHcyc1BJVG5MQUpyYjhibnBVa1B5S1dmNUtXNUhxZTNFT0VLdUla?=
 =?utf-8?B?NlNTZDkyK1R1L2lSazlYaHJJVGwrTTdMRHNwOG0xNHNrODhLMjJWbHpJcVhI?=
 =?utf-8?B?c25pQUVOVlVHNFp0aFRib3lXQ3BIMC8wQTg3WnNtRWtiQUJuWmRSb24yV056?=
 =?utf-8?B?aFNlckNjVndra1Nlc0JzMkpFa2NBbm9OSjRZclJRRS93ZkUyZEdQdmJzTlBT?=
 =?utf-8?B?b0dobkZSNVQrWXNKMktEQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THUrQ1V4dHhxNWtLa285cXRiamVQNnhaczJLRDBLVTBJWDRLdW4yMUdXUGRz?=
 =?utf-8?B?VzErUEpmMFlnNndDeXVZSDRIMkRpT3k3elBTLzFVRytySHdweE5hTlFUc1Zp?=
 =?utf-8?B?QkZ2RWRFSGZaREtjV29lYndIaUx1dUt2SktrY1hiWjI5aEFZbUxKTEt0SVhk?=
 =?utf-8?B?TURCVVpTZzBUUjhLaGk0bWJSa0N4dTY1ZkcwUmU5KzBtNW9Pd0JUMG96WXdt?=
 =?utf-8?B?emk3eHVLcDRBNHJlckVNbEhBRTdPY3A4cTVxNU5WZnhYa0RwQWJNS2ZIbFNE?=
 =?utf-8?B?RDZYSEFZNkdrUnYwUUFVeWN0ZCttL1VLSE5LckwxbUR1WkdCc2c3RlB4cUhI?=
 =?utf-8?B?dm5uOW5UcXRNUlVzaktNOHhiQytySi9SSVZuV3NoVjg4dTdITU85UVk1WmlM?=
 =?utf-8?B?MXlLYXp0Q0hCMU12d1NUSi9OZnhYZ29LbFBEbW55Vm5MZDZyMHBYSEVTYS9X?=
 =?utf-8?B?L2NnYmJxNnVwWG5xaW9URkNUUi9xcnlIdDNkYThTWjNnSy9RYU1McnB4U0FQ?=
 =?utf-8?B?ZzNJRG83VXk4cTVWMGE5Ky9NcHM0ZjljNFBKRDhMNzVpZFhyckpFWmg0Uklv?=
 =?utf-8?B?dUR6Z2h0UEtELzZpOGo4OUMzSUE1RDJQT3ZrenF2UG1LVXlOOGhXVlMzTWl4?=
 =?utf-8?B?S2hFSkNoMEdJMXVUcFNocGxzS0hlM2ViVXFTY0NPK3NVRzByUzQ5MW1PYzBN?=
 =?utf-8?B?QitFdXozSm1SdUl0ZlJ2bzNkaDdaYk40a09WT2RvV0locFl0UG95MnNqMktI?=
 =?utf-8?B?bnRZTG05RWRpRm13RnJzY0EzdC9kWW11TDBaUzdEdjFlYWRMWk1Fc0g2VnFh?=
 =?utf-8?B?QUxHYm90VUFySVRuaE4vUVZlcXkwUGJhWWtUNWtraFJTQzQxWDIvNks1dnBF?=
 =?utf-8?B?aE05bFVFSnZEd2tUM1ZFTVd5cEJhcGJNclNyYmdVN3l0RkRXanFONmkwSEtX?=
 =?utf-8?B?bjJqZm9Ub08xY1JUUTl0VEg4cVNGY2liS3dnb3RVQllmL0hkbnJvUjMvdzZL?=
 =?utf-8?B?SUQ2MzNES1RLTFQyTWN1WTZaRHBaL3BSbUZGTmlVNkFpRHR5WmZNcGhmV2V6?=
 =?utf-8?B?SWlaYXJKSFk2Yll1aE5VUEZpeTdsbDh5WmdvaEpEa2FUejE4SGdLYitOZTZu?=
 =?utf-8?B?TEpXaGdZVEtFanBHdW00QW1rTzRmZzdlWHV3dnFEemwyUWQxT2pPeHVCUUdO?=
 =?utf-8?B?YVA3dmF1d3plTWJGcHF4blo4c0x1blMwUXdpL2JKZlY3NnBKVXljc0l3Ujhx?=
 =?utf-8?B?WHRuaDJPQm56TzhpcGdMUW1nSzZLTVVtb0RYMVpHb0xKdHE3ditSSjY0T0lz?=
 =?utf-8?B?Y2kxU2lZRXVBQ2VGSitPV2JrSWc3Yld4QmR6dEVjT3EwVWlnME9USytYbERv?=
 =?utf-8?B?NG82b09JdFg1M1M4a2VNbXpyeHJ6TzdxNmhHcVJuVWNuYXdRSEpZRlBUOW1Y?=
 =?utf-8?B?SnFUNVJXdWtkSWM3UmpDRml5d01kMElUWjVwOFhtcm9XV3VYL0lYclZ5Qm93?=
 =?utf-8?B?QUFiY2JubFBlQ1RwcU5QOTN1bDhxVTNpY0tYOHQzVElWbjJsNkJ1RmZISDBZ?=
 =?utf-8?B?bG9sRGxyS1dtQWp6bjl1NEd1VjBPSXBDdm8ySFpYSVNrVlVYQnV0MDV0UU5x?=
 =?utf-8?B?cDFLTFJoMEVoekdvWnk0b3J2akZha1A3aXZFRElMbVdrYVhhUUxwK0dLYSt3?=
 =?utf-8?B?elNLK1IxTzkvZzRNdWcxNWovRDhMSHI0dit5WXBzYkY0NWtNRnR1NGF1ZCtR?=
 =?utf-8?B?STUrcnFLem1EQmtFOHpraThGY3RCTDdUZnVOR3QrU3hVV3V4TmFkSkRWaUJt?=
 =?utf-8?B?Rk0zeUNKa0Z0Nmw1ZXdleHBacVI3SUlNZEgrMTdDeGFXNVc0M0UzTDl6R045?=
 =?utf-8?B?aW5HdE1WM1dMUzhBbEtQSEwwRnBHVVhwdUk0NG5JNENnUE1SMVVaV09IdjJK?=
 =?utf-8?B?eFZ5U2F4UHlicVJEdlc0RDYwYk9tSm83ZzZrOUNjNEtPaHJRUVdrM05JR3Yx?=
 =?utf-8?B?ZUNacjNOS0hHWVNjTVhKdjFEVnl0b3p0T1U1eDJ4NGtZTk1JWllCY1JwRHBH?=
 =?utf-8?B?RmRrcDkxQUg0NGpHbUJnU2x3alFCLzUweVRIck52eUpIUk1nL1YvN1J3U0dm?=
 =?utf-8?B?eG96WVJ3Z3BmL3FnNUowM2JxYTZvNnlFK0tNemVnRjhQUDRnb1NBQkFHUjBF?=
 =?utf-8?B?MGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dc83e862-b00e-464d-83e8-08dd5a37fbb8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 09:44:25.1078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gIkaGn/K67croNgMOkh4M/ieATzVJ64lNATd7KP+uDAg4BNhXx0VBInbCE4SQfd8b1uNqobsKOLt3R6OrkAtE/pWNivFTjXh4ZhQyOVqoxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7614
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

Hi Marek,

On 3/2/25 9:59 PM, Marek Vasut wrote:
> Implement custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
> handling in case the TFA was loaded. The loadables handler sets up custom
> handoff structure used by Renesas TFA fork in fixed location in DRAM and
> indicates the TFA has been loaded.
> 
> The custom armv8_switch_to_el2_prep() handling tests whether the TFA BL31
> was previously loaded and the custom handoff structure was set up, and if
> so, jumps to TFA BL31 which switches from EL3 to EL2 and then returns to
> U-Boot just past bl in armv8_switch_to_el2() to finish starting the Linux
> kernel.
> 
> The jump to Linux through TFA works in such a way that the custom
> armv8_switch_to_el2_prep() handler configures the custom handoff structure
> such that the target jump address of the TFA BL31 on exit is set to the
> armv8_switch_to_el2() + 4, which is just past the bl, and just before the
> U-Boot code which implements the Linux kernel boot from either EL. The
> registers passed through the TFA BL31 are all the registers passed into
> armv8_switch_to_el2_prep() to assure maximum compatibility with all the
> boot modes. The armv8_switch_to_el2_prep() handler jumps to the TFA BL31,
> which does its setup, drops EL from EL3 to EL2 and finally jumps to the
> armv8_switch_to_el2() + 4 entry point, which then allows U-Boot to boot
> the Linux kernel the usual way.
> 
> In order to build suitable kernel fitImage, build TFA first, upstream
> is currently under review:
> https://review.trustedfirmware.org/c/TF-A/trusted-firmware-a/+/35799
> Or if necessary, downstream repository:
> remote: https://github.com/renesas-rcar/arm-trusted-firmware.git
> branch: rcar_gen4_v2.7_v4x
> 
> ```
> $ git clean -fqdx
> $ MBEDTLS_DIR=/path/to/mbedtls/ make -j$(nproc) bl31 \
> 	PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
> 	CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
> 	PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
> 	ENABLE_ASSERTIONS=0 E=0
> ```
> 
> Build Linux kernel Image and device tree from current mainline Linux
> kernel repository, obtain 'Image' and 'r8a779g0-white-hawk.dtb' .
> 
> Bundle the files together using provided fit-image.its fitImage description:
> ```
> $ mkimage -f fit-image.its fitImage
> ```
> 
> To start the kernel fiImage generated in previous step, load fitImage
> to DRAM and use the 'bootm' command to start it:
> => load 0x58000000 ... fitImage && bootm 0x58000000
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Julien Masson <jmasson@baylibre.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Maxim Moskalets <maximmosk4@gmail.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Raymond Mao <raymond.mao@linaro.org>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V2: Only start the BL31 if running in EL3
> V3: Update link to upstream TFA BL31 posting
> ---
>   board/renesas/common/gen4-common.c | 126 +++++++++++++++++++++++++++++
>   1 file changed, 126 insertions(+)
> 
> diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
> index 52a0639073b..f7d129be4c8 100644
> --- a/board/renesas/common/gen4-common.c
> +++ b/board/renesas/common/gen4-common.c

I'm wondering if it really makes sense to have this in board/? If I 
understood correctly, this is all SoC-specific? So shouldn't that rather 
be in arch/arm/mach-renesas maybe? So that boards based on an R-Car gen4 
SoC don't have to set SYS_VENDOR to renesas or copy the code in their 
own board/<vendor>/common directory?

What do you think?

Cheers,
Quentin
