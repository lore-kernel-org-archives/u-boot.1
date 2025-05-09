Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7448C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 04:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D72F08212F;
	Fri,  9 May 2025 06:54:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="iug5USmf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0D982153; Fri,  9 May 2025 06:54:22 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208088210D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 06:54:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tz7NwncgBmCN+X67ekhaQ4r6IqdqThhoTYr1+PyMsE0uvjbYNDpbutjGSkHd/56aKTBRa5Bg5ofdfOt74I5M751T+oQntLFktGvvrBIulLLsjERJWh8HG6FNzRpmGykB/IYx3nPCRIs2HwsFbOi5BgibFVjARGWtG9Xng14znhwYyZPViuAEA3eudlgBE/iq5V22LFuVaNtFVRlRRXOUWgf1jx94fT7JZVHjfKB3a42lfWemYN+MGx0BksH7eI1yDZWJplpSHCmau+TqCZ7YH5/5Se5XY7sjp67CSD06HfKcOMv3nxcz+Cm6qSvr3l37aCksCwbVETlSHWqH7Agllg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZh8GMGdYIsR4m216siOfJiN8J/GKWpeVMlfcv8LHOU=;
 b=pxoPrECXcRziVzi/DGmfGF2xoyxGk6XIc6JRSd5+WNTRXK1cFSGkMQBuUnDEXzRiGqnOTpLPpzaWS+ROL2yqJNo6DLQFrUc2m0XvmLdjeF2oYTDoGGtL6RSnnOffOe58pXJEHo9fUvpvVR0fphCSKL/RDHiyueEeaN8GWFDrdnS5oZIBOu+NsKzZbcWrUmmhDMtocdJXQY80VIzuf+WN36MsQTqYwrnBx34dYiz6ImLP/R3ytfKSJubLZ0L0r0SjnFk0/4Ayvg2fuegHCe7Vq/gUoKndSe7oT6hE5cmuPthUu/zpr+Yzf2a09yKtN/Ja/9/TzjD/uSKwvme3P5PEkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZh8GMGdYIsR4m216siOfJiN8J/GKWpeVMlfcv8LHOU=;
 b=iug5USmfcWBQ/PlIBJQ/wKm/HjZRrJeGYSRKPZhw9GDWa1sNUUowVId0ydzaR+UsaFH92ay8j7TpprmY0w3ElKMQdKh0QhF4F0Pdd5bNH4x5sn1nkTqDbGPzVo06sC2CoAYDFRZaUc96l+6dKTPs6Vawa0nJvy9EHn/f6V1MkPopLbS/fl80LM/bGgTO8OKQ9H9owRrnsuQsMUmmdVeUwOxXa45vDz0IoIiDY4MM/oZE71+2ZFZCh/EKXN/ulYV+12snrCP3ZXD2k7ZYIszZ86xayfpQ7sJxfvxKBPAmxOLxvIIb0lfFuNa4OrAKanFUziKhGXAXI+eF/lgX94idjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB2053.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:89::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Fri, 9 May
 2025 04:54:15 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.020; Fri, 9 May 2025
 04:54:15 +0000
Message-ID: <d58d1e49-97e6-4750-aa3c-8b9fc6033486@phytec.de>
Date: Fri, 9 May 2025 07:54:13 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] *** boot: Add Kconfig options for script-based boot
 parameters ***
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de,
 jagan@amarulasolutions.com, vigneshr@ti.com, tudor.ambarus@linaro.org,
 joe.hershberger@ni.com, sjg@chromium.org, d.schultz@phytec.de
References: <20250508131641.2561876-1-w.egorov@phytec.de>
 <20250508193256.GD603748@bill-the-cat>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250508193256.GD603748@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR02CA0048.eurprd02.prod.outlook.com
 (2603:10a6:802:14::19) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB2053:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c848ad1-bf46-4004-76c4-08dd8eb58c7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UWJYS1pEUnhTR09VaG54aTRaMFdqY1d6ZmJsN1ZiQXNQQTNFL2Q2WkxEaWNm?=
 =?utf-8?B?SWZpa05CTmVlT3YyK3JtTDdhY0FBNjB6c2YzY29nTXNUR0plY3ZQMjBLeWFH?=
 =?utf-8?B?VlNsMmVaSUhOb0wzZlRHNkt3WFpoMnpHWGo0VVd5NTJkRUtjNldkbU5oVzVk?=
 =?utf-8?B?UzlVcm5Jc3MyUXJhTEFOTjFPaUNYYWhWa3dPV0xLTW5OdVRHU2FGYjBjWG1H?=
 =?utf-8?B?RExZYzFFN3FFQzNyUjIyQ3pleEcwTEYrb1k1TXlyVWFNdlc1eXN2MlpBM1NP?=
 =?utf-8?B?WHpzOWJ6cVF1VE4yUFZsZ0x5bWlJcWdoQUV3aVVKT2dYdnd6bVVBUjZlVTJQ?=
 =?utf-8?B?MXpjMmVZaEdVdDJmM3dqVThNTmg0R0NXZGxzajYzZ25QUGRJMnl4VHpJV3pJ?=
 =?utf-8?B?SE94TlNZdjJ6alAxT0tDTWh1NXdnQU9iZEpsaUFHaEZMd1kvWWRVUFFkTVZC?=
 =?utf-8?B?R29DQjlJQmNoQTROenV2S2xKaXNlOGFWWElOV2NicnBONXRITTVETFUyM3Jh?=
 =?utf-8?B?TTRCRVZCb1pRdzFvS3JVc2x1MHdQVXhZUFliY0svbGNHUWlKNFg0MUpFOTFv?=
 =?utf-8?B?SCswdFNuRTlua21VVTZRbkRnTDYrbmoyUmpBTDlvN1ZxbDZiQk16cUNEZUZu?=
 =?utf-8?B?d095dEcyZEcvNzdmeXBpWFd2RVlzZjlvenZyT0Y5UGtTcE1uNmVZMVZoNVAr?=
 =?utf-8?B?dkVaVVMrVU5JZzhtYjhmZXRmL2ZZbWdqUGdxODVUaXFIcG5MTEI0UkVPTUJ6?=
 =?utf-8?B?OTRqQ3VQWCtRQlJlS2pxdWlvU1NHWWVQMmZLT09VU1V1SU5Za0NuNG0zQWFJ?=
 =?utf-8?B?VDFSNWZHenpIbmQwUkU0Z3lVT2VVOXk4cmJmd2tIWTZyamVNRnBtSnNsTmNt?=
 =?utf-8?B?OEdqT0g5eTg5eEN2eDFzS2tUZkpYZUl0MjM0UTI3NjRzNHh2dXZjZkhYQW1S?=
 =?utf-8?B?NEUzcEJKSzE0RS9DSm43K2RZeUQ3OVo0aWRsczhIU05vNy91OWx0T1N2aS9U?=
 =?utf-8?B?Q0t0SThkZDI3cDVXbTE1V2h0VXNreVUrQjdBbGFXOEcxZkg3dDMyd0hMMlMr?=
 =?utf-8?B?VmRaTzFSSFJTVFVSaDdDakhMcVBYeU54TW9PbFJmbzVGM0grWEJvWEpySGIw?=
 =?utf-8?B?Zkl4MzQrQXZyeHR6b2t1T1NuZWxZRDNiQ0ZvRW1NcjhpRzZLNWVicVV3ZmNW?=
 =?utf-8?B?M1VxUm5aRFNRenc1ai9sQmVMR0kvZVpGS3owN2VzeXF4YjRWZTNYdnRUTThV?=
 =?utf-8?B?bnpSSU5STlJYbnlXT2VQOFYya1c0VUNHS3pnWHVOaUdXVDRzMGhPaHRqUUxB?=
 =?utf-8?B?NGkrWlBRN1h1UzFSVHc1d1NDcnpaTEFTTGVsWnkzNU16REU0UHdiSWcrbDlz?=
 =?utf-8?B?WmdJWFR2bHdwTlFoLzJNbTVlUkNNRFB5Y0t6TGdNcGZ3OFVWVkZCQSs4WDNT?=
 =?utf-8?B?Qi9xYU5YMnpmOFRLclZsbVl5WTdOckhQeFRJVW5La0F2T2haYjZFdC96M1pD?=
 =?utf-8?B?N0x6b2lURVBZcDZ4NkJnRWk0SCtvTzZCemtmRlZkdG0yWmtyZ2poWVVJZFRy?=
 =?utf-8?B?clFndnd5eTdUVER1L01ZUjUwaDhYc0dNZUpaTnhZSGdBREQzODA1bWFKVzIy?=
 =?utf-8?B?S29RdWFuZjRFMm9KbzZDT1FxandVWU9XaGNrOFo1bVR0anNteTUyZWZXam41?=
 =?utf-8?B?L20xeFBJZFFrWkM1TWRkYkJNcDJ6eG9UdUhUeEtXQXJaYlNKaXJNVjJvbFNl?=
 =?utf-8?B?OUU1aCtkVU9kWXJPc1duZGo0SGxIUkIzTmdzUnNVbk9TdGNDTmVvcGNKUkNm?=
 =?utf-8?B?ZU9CYk9lSGQwaDVkTXJwUXdCd3djZUowS3lFejNOQ1BoaTlaQVlpWmJkakRJ?=
 =?utf-8?B?NHZWTlV3aExQR0F1Q2ZQWjd5N1NSYjk4RC9FL2ZoT1Y4TkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnliaHR2ZzhmbWRqSUtNMHhhSnZkNGkyb01CMGNNaHN0b2hkSVhVa0ZZa3dw?=
 =?utf-8?B?cExQOFA3T1VySlBKVHFHVEFVTUV0RFY4WDJoWWQrV3NoN29USUxPTDYrNnlI?=
 =?utf-8?B?MWNXZ2toRkdnV0R1bHIyZjNMY3dkMTZxOGRDSmM3Q2xHSi95S1JDbGxSeDB0?=
 =?utf-8?B?U25iNUR4eEZtNHhDRGZTbURxNXJLcnRFeWtScTdzNFN4QVdmcmxVVVowbVRu?=
 =?utf-8?B?RndjcG41Wm9hQ3crQVZsOUlwODZSdHpWa1p0b2ZsdlZIMHY0Q1h6MWtnSC9U?=
 =?utf-8?B?SGRLeXQxOFJlQlN2dlBEbXJDQ2hFbGJuMW9DMENrZ2c2dUI0ZVBrVUoxK3Iy?=
 =?utf-8?B?YThENnFkU0xjaFdzTDlLRFlVZElVK1VuY2x4V0ZBZHd1dzhNdWJnTVVLeHVk?=
 =?utf-8?B?WU5UMCsxaWdsOGVzMzY2NTdVR0YweXZ5WmpMWEpMU3JqM0R6Nm1SQTNSaWI0?=
 =?utf-8?B?NVQzMWMyVHhlR3ovUUp3NEdLV2ZWR3JmazYvYzFLMCtpVGxjSEZaUzIvb3hT?=
 =?utf-8?B?bzdNMzg4RmkxSTNseklsQUdMYXBldmJ0eUdkQTY5MW5aRGxybGo4djdBL08x?=
 =?utf-8?B?eHVYUzFpdWJhVU12WXZ2Zy9YRGYzcHQ0SGNpc1I5RkVtVVoxVG5pOW5mSnJw?=
 =?utf-8?B?aE1xYnZQVDhvc1dUV1V2bmdUME1aR0tUSDNNSWgxOUNsd3h2QndTSFRLUzNp?=
 =?utf-8?B?LzB0Z3dBM0RKUXhOc1JTaEpkay9EQWVmQTV4aklZeXdOWXdMOU1YQmdKejgr?=
 =?utf-8?B?TUVxeldsM01EU294bkFWK3dCektqazBpQVJyVXVwVXhtaitYT0lXNUo2cktv?=
 =?utf-8?B?Q3ozVXRIekdGaUZBZzA1Vm0wbytPOVpaUEhSTHN5TFZFR0tzUkFETnUyWlhp?=
 =?utf-8?B?eE1qM2hkdnVFMlRMZjMxZE5PL1JSNWNOTWV4TEw1OG9YTjlpRGl4N2NjWW94?=
 =?utf-8?B?NjZVREpyU294R1F4dCtNdUI3N1dFSnN2Z2FJU2tBWjQxdmJTdHVXU0Z5UVY2?=
 =?utf-8?B?eWNUWU4zcXZCVDExSUgwTFNLcEwxR3VlOTBET0VqcHFFUE80YzhiVWR4Z2Zr?=
 =?utf-8?B?NWU3MGtoeDAwOUpyd1dFUHlHczFJQTVRWWRQS0ZrY2V6SUZRYThwMmx1UzVW?=
 =?utf-8?B?MTc3UlMyemRzbXVMRkFJdi82KzF6ZWRzK0FxY3pLbHhZaXJFVVBOZUtxRHFi?=
 =?utf-8?B?dFZrNytXUUFaY3VNa0tHelpDdzh6emlwMUdUeit4MHFCZmxMYnpvRU1TQ0NX?=
 =?utf-8?B?US9vNUYxd0VNOStlbVI4NjJOVHJrUG5SUkk2Y3pOQnlpZjViN0hKa2lLSTZR?=
 =?utf-8?B?SmZBOUdGMDRIR3NTcXRHNVBLTms3U1VqNnQvMkY3ZWUxblcvYWlBZFpsRTBn?=
 =?utf-8?B?WVBMU1g1NEtYNE13TVBUaTFuVm1tQ1hPdS9SMXMvdDlxN0hKODRPRk1Na2pz?=
 =?utf-8?B?Z0FSckFNc2RSZFhLV0xCWXB5UzUvWEM4bHBhMm9DWjBVNmdWY05NTjNKbGd3?=
 =?utf-8?B?cWczK0UyaEJZQ0VQY2FSMlJaRmE3SE5rZ21Xb3huUkpacFBpTlBxQTk1b1Er?=
 =?utf-8?B?YkJyWXJCM1gyMTBhL3l6R3kxTnprdjhvMVNpQkd3V1prWjlHT3VVTUtlT0U2?=
 =?utf-8?B?QjRLckdrTlJpZ1Y4MlNQNlFWVTgzMzdXeGRZWnNIY2NJSU96eGhHblRxWGhk?=
 =?utf-8?B?aUIrN1gxRS82Y2loT0hiQzRYUHJiTzl0WUt2QldlR0F5bVlkcHRycFMxN1d6?=
 =?utf-8?B?azlEbzZNdEZDYkVFczNRRElMNm1melZsZktmZTUyNWNiWnBDZS9rTEc0anJW?=
 =?utf-8?B?VXFEV2cxaUZFalhablFOcE81WWJhRnVRZ2lCaU8wTUVmc1JXbTNiN0JKSkVC?=
 =?utf-8?B?ajh5S0h6cUlyRGVVV0tjQkJET3VZc1RYNHBpeFRLTm95MklEMHlvMFdmdjVa?=
 =?utf-8?B?WU1PT0lYelVlMzVKRVlLTUlXSkE5NEgxelh3RWR0NWVPeGdPRlhRakZqVzdq?=
 =?utf-8?B?Q0U5U0Z3NWJqbEdmc3Z1KzNWWmk1WnVueEVvci90QTI4NW1JS1JrN0pEcHoy?=
 =?utf-8?B?OXB6dG5VbjFtTTBzVXMyaEhacXc3ZW5jc2ZqLzVGZzFzS1l0c3VBM08rbnpL?=
 =?utf-8?Q?LmK6WX8SBMYFBQS7rfKfzYxjM?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c848ad1-bf46-4004-76c4-08dd8eb58c7a
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 04:54:15.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cy10Vp6fGaxJtlOUs1jJ92C1jyiMOeBTQ9lyHw3JKik1dXg6ON6r6fBB9+EynVXYnaSLxZNS1o1waG+xXMtg3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB2053
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



On 5/8/25 10:32 PM, Tom Rini wrote:
> On Thu, May 08, 2025 at 03:16:39PM +0200, Wadim Egorov wrote:
> 
>> This series introduces new Kconfig options to configure default environment
>> variables used in script-based boot scenarios. Specifically, it allows
>> setting the following standard boot environment variables:
>>
>> - boot_script_dhcp via BOOTSCRIPT_DHCP
>> - script_offset_f and script_size_f via USE_SPI_FLASH_SCRIPT and
>>    related options
>>
>> These changes make it possible to define standard boot environment variables
>> directly via Kconfig, allowing higher-level build systems like Yocto to set
>> them at build time. This avoids the need for post-build environment patches
>> or runtime overrides, improving reproducibility and simplifying integration
>> in automated firmware build workflows.
>>
>> Wadim Egorov (2):
>>    boot: Add BOOTSCRIPT_DHCP Kconfig option for boot_script_dhcp env
>>    mtd: bootdev: Add Kconfig option for defining script parameters
>>
>>   boot/Kconfig            | 18 ++++++++++++++++++
>>   drivers/mtd/spi/Kconfig | 26 ++++++++++++++++++++++++++
>>   include/env_default.h   |  7 +++++++
>>   3 files changed, 51 insertions(+)
> 
> It would be nice to see what the Yocto side of this looks like for
> example. My first thought is about if this is really easier / better to
> maintain than dropping in a new env file? Thanks.
> 

We use config fragments in Yocto (based on merge_config.sh) to enable or 
disable u-boot features in different builds.
Because users may require different SPI flash memory layouts, they can 
override variables like script_offset_f in their own layer instead of 
appending an extra patch for this job.

