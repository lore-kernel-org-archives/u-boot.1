Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D6D3D2ECF3
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 21:51:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4332839E2;
	Mon, 19 Jan 2026 22:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="w71KlH1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEBF4839E8; Mon, 19 Jan 2026 22:51:30 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90C36839DF
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 22:51:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZVHxAJjVfcQ5zwHuFXCdu5oYyJcxz6kRQzJk5O2mgdGOqDc7UvDQnmAU30ydSkr3WHFo34l0g8Q2Z9rS0XSsAywScZFMlv58PVGjj12XEEcnEvqDKmUIj41kXgcLhcLL77gAHYeOE7Sb/qD8CeUPXKw+xiJq/8dGjmQi97q5f9fjFo31c0vrPlqAJG8WuA1yB057CsE7wi/KjqiusdgOVx9PV3vht3FlJL/i7iTtuWtukFXYhQUL7YnS9B6Z64AlBkgRVBGSd+0JjrCE9SdzZHDDPp5wvD06/zPs1Pim6Z8Twh7nf+tpW7GfQAE1pKfpua49Dwwl09kwjlSDuYjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OIvTQD93hqD9UzHNo3gBD83c6CxI+lPOqp+4BJJPWL4=;
 b=rWJPq3zBZqZbZntf085iw0lnz3ZsS6kgFxhSItE986G0MyMoFBrOlmYFChGPXF3mCsThtzGcc46J3+xJTv7zfHH6eSaLwc/3C+Sbbc9ZSeDuA/F+UGnKwtPOnGjyLZkcHfDFQz+EXr04xZC7DjFxKnxxrGrUFGXNLlNCUYDfUf67pJB6nyBxXc7Afb9wmMhPuRS28SRrsVRJz0YrS6sR+R4NOzDAaIJ/DMkPDkmtKhkNrX5j3pDyYiKCdWsgZJ6ZjIwKaoRkPGP5lTP0o5BFYuGJB8CB+5T36c3P210G57hsn5j59VRDToWpP0Gq0v1IlBvtgcKn2rPFoNUtTGqNng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIvTQD93hqD9UzHNo3gBD83c6CxI+lPOqp+4BJJPWL4=;
 b=w71KlH1wh2zmlzvzke4xmgxA48IAMwO+NYf/1wmkNP5lVOX1Kd9tNTgtRtvsnlALhu7iuLL4mijaw9/3Q2JvuDx3bLojoLm/NuuFOIym4uU5S/u4E5SSo8xelp3IE/CbRrSDWZosD5vurSpUdOlK0fV+ElNIr7MP0UKawsn/X/HjQ1tbHHP2ezOvBnaZI6a15+KFxWsXAWL+poG4x89WKKZrv9XPzZFgYS8h7QaH2pvbHMF/pPJs08jQtPD4coZJubugDTszPt+a8PAw3MaHB2YrNrXKUsXoYXQTRl9n/mxSV/YpIz1kMCDB+Jf4GYN2LM3uozGu/iv54mP2xzfN9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15) by AS2PR08MB9102.eurprd08.prod.outlook.com
 (2603:10a6:20b:5fc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 21:51:26 +0000
Received: from VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681]) by VI1PR08MB10029.eurprd08.prod.outlook.com
 ([fe80::5e67:2d67:644b:9681%6]) with mapi id 15.20.9520.006; Mon, 19 Jan 2026
 21:51:26 +0000
Message-ID: <8b35d4c3-bb10-4d6c-b049-5fb4aeee8922@iopsys.eu>
Date: Tue, 20 Jan 2026 00:51:22 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] mtd: mtdpart: fix partitions searching
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Corneliu Doban <cdoban@broadcom.com>,
 Alexey Romanov <avromanov@salutedevices.com>, u-boot@lists.denx.de
References: <20260119003606.748561-1-mikhail.kshevetskiy@iopsys.eu>
 <20260119003606.748561-4-mikhail.kshevetskiy@iopsys.eu>
 <60cb63ca-faa9-4a34-8d19-57c7b652ad83@cherry.de>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <60cb63ca-faa9-4a34-8d19-57c7b652ad83@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MI2P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::18) To VI1PR08MB10029.eurprd08.prod.outlook.com
 (2603:10a6:800:1c6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR08MB10029:EE_|AS2PR08MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9e3495-0973-4ecb-3915-08de57a4e4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0FlbDhnYktGSkpHUlgyZDlUNC9PVnpRSm85UlQrUGJ4Tm04TFRmMGNqeGwx?=
 =?utf-8?B?N29zRG85ZEQ4TTVtQ1BobVk4MmpQaUtYYTJyemtHclNEKzVSOGlTZmFRb3k5?=
 =?utf-8?B?U096TjV3SU52a0xtMkJnUllrL1BFQi94UlQzckh5RUgwbitrSnltSldVbTE2?=
 =?utf-8?B?OWhOM1lBRDBkVUdHQytRTXgrTENUdlJuNWNUZS9CQ0Exa3NCalZBYW8zUkFL?=
 =?utf-8?B?TFVUYXVuUHl0ZUpnNEJRUHM3TzFLNEJwVVZ4UHQvSFQrUUZ4UElWYTlGODNq?=
 =?utf-8?B?TFVPVkt5cWlvWFN3SjJjMXdvdUtRQVpYbWd4WEV3MTdaYURsRk1uTFAxVjRh?=
 =?utf-8?B?UGFqb3hndFVxaGliQWw2dUQrTVFrVUhNVmVZbmJTSWJTRXl1NmVWM3R2UUNG?=
 =?utf-8?B?ZXlKSlY3LzVlK3RNeWt1V2pKOFZXclFvVXhhMzBZeVdUNmpDQXE3TUM1Rko5?=
 =?utf-8?B?WVdnUExwNERWaWg1WXdRb2lhT0IrSTVRT3hSalMwMWRYNHZkVTRhWm9HdjRJ?=
 =?utf-8?B?VWI2TmVrckliV2toMG5xeEJJK0pKeGVGZ1ZzTG1oZWVQL3FCL0JqMWRUb2hN?=
 =?utf-8?B?U2pxdHc4V0p1U3JkTlcvTitmRmJvRm9OZVY5UmorWmZpeFlOYXV4bGpFZWg3?=
 =?utf-8?B?WVlWVThwSlZxUENvR0dRQ0lCWTdXRGtyU2poTjJRTDlKSzdNVWVjZHcyNE52?=
 =?utf-8?B?ZEtEcURGaHhzd0hBYkpvSzJqemJJSHdKQ1F0VExFa0JlV0FPU3hYdGJMT3FT?=
 =?utf-8?B?VjVxRnFLYVBXSkhCZHk4UGJ3RGhERndjK1AvNWNHYlg1RUZVVkFXMGFLeWxy?=
 =?utf-8?B?ZUlJbm1kMlZ6VzJmV2pObVRscnBNdHo2STVIZXphWVVqcS9VSzdmS3pmN3hJ?=
 =?utf-8?B?b2hCUzRVaEpJaGpLbUowZVZtY1NieDMyd3VOcEJ4OTJsVGpuMTVIOGREUm51?=
 =?utf-8?B?aFRQZ3dpaTRLb1pzVFlhS3B1OTk2aFNaY0dTbWpUSG5zMm9xZXN0ZHhYVDdD?=
 =?utf-8?B?aUFuelAyVEUxOXhRbmdOY0JHWCs2RXladjBTTDkycE51aWwxb0RoV0NZS2FQ?=
 =?utf-8?B?WHlvc3dVNkJJaGxjMzd0RTBWeEpKQ2R2MkswZ0hLcWRYZWF6YzZDZ1hIeHY1?=
 =?utf-8?B?U3N5Z3FZbUw3bkhrRGFUZys5ejNMRVZycmthSW9INmhnbXE2R2R4RHEzTFFV?=
 =?utf-8?B?bldQOFFQRFluS25pUlNiSjhVRmFIZXhpNDkyalVDWWtOWXNRVTNYenBobUY0?=
 =?utf-8?B?cFNHZG1LRWV3YzhTdGdpZlJBM0ZtV1RpVXg1Rk4yaVQrTmVlR1B4TFZFUEZG?=
 =?utf-8?B?aFdUTW9wZEYwbUw1RE9xY1VmcW5Zb0M1OWw4T1hMZUUrYWU0Zmh1NzVvd2hF?=
 =?utf-8?B?eVpWU1hHVGZkZThQNmRoaFZvc1pkWDNpTUhhNUNEMnlPWXZWczdtRTFqcTdI?=
 =?utf-8?B?QWdYSytPNWpBZzFoSi9YbXM5ak55aStuVHpQbmZsR2NpTGhFODYrWEV1SnVN?=
 =?utf-8?B?TWJMZUovVXhPdXJxbnYzZTFCTFpxcFNFZEVzcWZLN2c3Q3Y0ZHlYb1BBMXZQ?=
 =?utf-8?B?Y3Aydlo5b3huS1pPZllLNEppRlB2Y0ZuVU1GampHOFViUWh3OFZNYi96Tzdw?=
 =?utf-8?B?ZXdXRkFjam52dUJjNUoyd29uc0xTRmROeFo0R1hUWmtWNE9NMWFPTDR2aTZH?=
 =?utf-8?B?SVBZeVF4VS9rY1pGMWxjL0VoMnBocmJYcktlbTZZQ2hBVkx1RzV6bkJXZjJZ?=
 =?utf-8?B?aUZKWDVzVXJUYjc3bFIyQU95S3NPU3ZlL3pxblBpV2h6cjF2d2ZjNHRabVQ3?=
 =?utf-8?B?ODMrYk00Y1p6SGVOd25tcWJxWTF3amhsK3RLeVNZVUM4Sk0zUG5XNGp3aCtJ?=
 =?utf-8?B?UytzemxHNGZnT2hoalFhbnZ2UmVUM0hZV3ZRV3dsUWdGbjE2YXh2bUdrQU5y?=
 =?utf-8?B?NDcxTUM0WmNVd2NGc2hZN3R4RW1UVnFSQ0p5YUpIWTlVeWp6RnlUWU00cWtN?=
 =?utf-8?B?UldxOVpqQk9BeDNTYVhrL0tibGlqWXlQeWtJNllRME8zYnhjNi9LQWpkVnJz?=
 =?utf-8?B?Z251V1FRb1FUMnhrVGlKb2l5Y2w5dWF3Tjg4WVloNTFlajZTQzdBUDhaVnU5?=
 =?utf-8?B?TUJDYmUvSGE2ZnE3TTF3TFV2RVVVNGtpQzhBc1FxNmg2UXkzeXFIeG5DaU1w?=
 =?utf-8?B?N1E9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB10029.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020); DIR:OUT; SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjZWRUVhMFlvb2FZVXc5S2I2RU1mb2NKZGg5ZGxXNUxabklleEszYWdLTHVL?=
 =?utf-8?B?MHk2Sm1zc3FPWkhIZlpJSFg5Zk12bVBTMUtxVENJWVV5RnIvNThnM3BKeDFK?=
 =?utf-8?B?a2RMUzJNMGs3cFlQOVRJdDdUT0xSaGJIc1NOeVZFRVUwS1VPWDViQmNxYUw0?=
 =?utf-8?B?YVE3K0ltVnQyMFpyWkNJNXV4eFVmNlNXYkM0YlNJVi9NTTBacStCM2RmWHNP?=
 =?utf-8?B?dE1ld2ovVXhweFZqQUdSMlRlVC9ad2FpR1pJOGQvRHlBN3dyWURpQUlrYWhK?=
 =?utf-8?B?UVdWMkZjdDIzZXQ1cnFZM0hvVlZxOTlJVDd1NFgrMUNNSDhuQnp3Wm41Z2JP?=
 =?utf-8?B?ZVdvTXJKeFlYckZzRGJtVlhpTHR3Zk5hTllTWnk3NTlIMCt6U2QyUkNFQ3ds?=
 =?utf-8?B?S2NzWTFCcXRlTlREbWRFV1F4TDhyMkhsaUFhdHBvQmc4S0JiMG9HM3FoeVhs?=
 =?utf-8?B?MFRMK3pidUJGYmVid3BpclJ6bHphU2ZsSVdxODIrSk5XSHpORXMzbkVSbFBZ?=
 =?utf-8?B?b3VManRlNUZrSThtTTJnNlhNcnVxTjBJdDhnODJSSXlkZk05S3VjbW5lN1ZK?=
 =?utf-8?B?ZnJPaldzZ3cxZ0F4VllTT0pDelUvTFJtOXNrRmQxUW1hWG5iS3ZlSVdvU0R0?=
 =?utf-8?B?c2lydVBoR0pIbHUvbWl1ZUFqMW5wTHEvZ0V2UGpsRHZicGFqQXNCQStMd1VV?=
 =?utf-8?B?SzRUMkhMOWlPTW9FNVBjRGNUZlg3amVtNXN4b25QVk80MFpjRWtlQkkzNEsz?=
 =?utf-8?B?MVNrY0F3alk1dlNUbjh4VDRaVVBIMzdBSlg2N1RKbDRIUVNqQUJkVW9DUmNr?=
 =?utf-8?B?S3FaQkFmQ0pjL3MwaGMyb0ZURDN2NVNIMFYwdU1hNE9hVCtCaVZ5VDlvVGow?=
 =?utf-8?B?elcrNG5IRWsvWXlyNEVhcnFDZk4rRWJYMFhnYjFuTkcreER3Q0QvYmg5RUJV?=
 =?utf-8?B?RS9LSm5HdmZxSUxtdTBJZGVsVXVpL293c3gwYkwvMkRNUVR6cWtkUHdkYldE?=
 =?utf-8?B?Mkp2a0lLWGQwTTB6Ykc4aXVERzVXQytteXV5WVN1ODVSWW93c1Y5YTg3Vm1U?=
 =?utf-8?B?eXdTdzdkOUxwMjduZzBIYVdBSWNIdGxkT0U4YWt5NVlpYVVMdXpvZ2hway9k?=
 =?utf-8?B?dDNtSWhhaWJ1aUc1QTdnYkxqRUtETTZrc0Z5Q2x5Y21wbzJkNDFVSGgvODhQ?=
 =?utf-8?B?a1A1dUZEeFpYS1RBTVdpMnJ0MkM1VE5rTGluZFhuZGJjRXRWYVNlY2huUjVz?=
 =?utf-8?B?WU5QSVlXNGR4ZExjaHJRSjBES1VrdUlaSGRqSEtIcklWS0dYbXpvTjFJTmQ3?=
 =?utf-8?B?RDJHVUhrQ0MvMmlqSTlFekxVT3VXUG0ycURRVmZERWVvWVVVclR1djloVU8y?=
 =?utf-8?B?K1g5RzZtV2F2NHc4NTJQU1JNc2g0M2lvcXBydnFaKy9KbWVubGw0M2x2VExY?=
 =?utf-8?B?V1Y0SUFQNDFCd1Vma240QzNueDlIcVZwaVBORzBRUkJYWm5xTEM3SHRpaGVK?=
 =?utf-8?B?OWczaklXMnFFYVltZmg2VjltWnorM0htZkNvb1N3UmVPV21rTXZqODRJZzFv?=
 =?utf-8?B?bmZUT01FZHRicThlek9LT2lNaUYvZkxKV0tqSnFiU3FWN0w1ZjNiTlR0c3d5?=
 =?utf-8?B?SFJYby9EQUtuWEJacGZvUEpPUW5tV2xTMGdlSjVodmJzSFNzQW95RjV2ekxG?=
 =?utf-8?B?V0QrK2FEamdUWmx4T3hnWlBySFFFNzRsajJRbmk5K1RTOUJDRkxMSWx6b0Nw?=
 =?utf-8?B?dW9oTk5VYS9HMEdFNDQ3REJadldWZ3pYV2ozVU42U2lIWXV6Uk5TMVZXZDZ5?=
 =?utf-8?B?SnRRdU5sV0FRdmJTUCtOa2pZK0Z2a0VrVC82NnlTUytkQ1RZbmFFNitpT0o1?=
 =?utf-8?B?dXc3RGttemZwbXp5UkFzS2RuZlJ4Y1ZyYWRMZUh1VkRLVmRldUpwa1Z5VXRH?=
 =?utf-8?B?WlNsK20rdGxCdHBWRG1UTTQ3dFFaNHppbDJaSVk3cUdpVDFrZzE4Y0ZUbDhM?=
 =?utf-8?B?MUhWVXBoMm1TOWxtZ0ZIVTdmVEZ4VU9iUk5ySy9Ncko1alRKSWx4Wmtqbi91?=
 =?utf-8?B?VUIzVTE2TDNBdHJKcWJib2lzR3R0Q0VwUXBFUEtMenVUR0JuNUlQUG9FS2Vj?=
 =?utf-8?B?SFpuNW1WdENiYnE1RzBUUnZhN0lOdWRkYnpackR6NEZGWi9GNjRTYWhUa3ds?=
 =?utf-8?B?cU1rcUxZbC83WTNaRTdVMFhpLzZSdWZDQXVVZTV5a2kwMjZWcUVlaGJpTFZv?=
 =?utf-8?B?Z3FPQXRnYW5ySHJva21aamp4VHNNY0lLQU5Wekl3bVljTUw3V21VYzhJcGZ0?=
 =?utf-8?B?YTlZUlg1VC9vazd3VjdDOFVPMUE1Rm50NlpDdVZ6YVdCSXlCTnE0dnl4bzdo?=
 =?utf-8?Q?4Z2dvMkrcRGYncj8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9e3495-0973-4ecb-3915-08de57a4e4db
X-MS-Exchange-CrossTenant-AuthSource: VI1PR08MB10029.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 21:51:26.1181 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a3x5BlhfjRIx9L8uruAoTRIKd5Kbmxh4edEUxtjxRzwF0AHKMJYBtSaNP5M0Ejulxev17SQmSc1qaTRsaZTF+AyDT5v59Pw1CwdVUTDNv2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9102
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


On 1/19/26 14:24, Quentin Schulz wrote:
> Hi Mikhail,
>
> On 1/19/26 1:36 AM, Mikhail Kshevetskiy wrote:
>> mtdpart internally enumerate partitions starting from zero, but
>> partition
>> driver API enumerate partitions starting from 1. Just now mtdpart does
>> not take this difference into account. This is wrong.
>>
>
> This possibly will break a few boards which may be relying on the
> wrong offset being used. Since it was wrong (according to the doc in
> include/part.h which states the partition number 1 is the first), I
> guess it's "fine" to break those? 


I doubt that anything is broken. First, almost none of the boards
depends on CONFIG_MTD_PARTITIONS and CONFIG_MTD_BLOCK. Second, if
somebody really use it, he should already note a bug:
* commands like "part start <interface> <dev> <part> <varname>" will
returns values not for a queried partitions
* write/read commands will operate with a wrong partition.


>
>> Unnecessary debug message also was removed.
>>
>> Fixes: c29a6daec184 ("disk: support MTD partitions")
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>   drivers/mtd/mtdpart.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
>> index 842d3e7274e..0bd4b3db022 100644
>> --- a/drivers/mtd/mtdpart.c
>> +++ b/drivers/mtd/mtdpart.c
>> @@ -1067,7 +1067,6 @@ static struct mtd_info
>> *mtd_get_partition_by_index(struct mtd_info *mtd, int ind
>>           if (i++ == index)
>>               return part;
>>   -    debug("Partition with idx=%d not found on MTD device %s\n",
>> index, mtd->name);
>>       return NULL;
>>   }
>>   @@ -1082,9 +1081,11 @@ static int __maybe_unused
>> part_get_info_mtd(struct blk_desc *dev_desc, int part_
>>           return -EINVAL;
>>       }
>>   -    part = mtd_get_partition_by_index(master, part_idx);
>> +    /* internal indexing starts from zero, but part_idx starts from
>> 1 */
>> +    part = mtd_get_partition_by_index(master, part_idx - 1);
>>       if (!part) {
>> -        debug("Failed to find partition with idx=%d\n", part_idx);
>> +        debug("Failed to find partition with idx=%d on MTD device
>> %s\n",
>> +              part_idx - 1, master->name);
>
> I think it'd make more sense to patch mtd_get_partition_by_index() to
> start with i = 1 instead of i = 0, because if we ever get another user
> of this function, then we don't need to go through the same trick that
> is implemented in this patch for part_get_info_mtd(). What do you think?


Not a problem, will change it

>
> Cheers,
> Quentin
