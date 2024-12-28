Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96CD1E7718B
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 01:12:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4F718036E;
	Sat, 28 Dec 2024 02:12:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="EHLfGxyX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E306780422; Sat, 28 Dec 2024 02:12:08 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::70c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 331E680317
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 02:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDjKivwgzQFqzSgZVhAMpaDaqV8BsQZWCvlfbH++AiRnV/zb1DScqlE2R2T/z/vYKO/7pgcOwGZH0HfHx1FpDn54WLW/9ANuedglkLmlV+xY/1QlKbbAYe8F0Uk4BpnruZYPE6K9vUnvLyfstK7AvFtNPk/PXEsc6CUevnTisqmFu9Wa78D+7V5qYmoGPbTYgWaU4jF2p8Nh9dLwI3bkiQhEwT0l75oWmaC4td/Aj6vmfGSOOJMYrazJ6S7iLzvml2/Jf5q+ek31an4qAS3ck4j/0vbpMkWVenz9XdVqpvwlsBFuLf1v/lOF3FgXUffKmJE9lehD/zGYbAfpvGdpPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eOxj3tAaFh669Ebm0Eq8c0JPByAS6OcYyrZyna204BE=;
 b=OgWiJs9oZSOQh6ilqs3is2754aVBLgP/QyYgmX7AUOdBCtX77o+49L3DuBhavOO0pBReHog2K+GNgmw6jH4o1tPSHw/+TMZxrNcNR6guR+AA1amxwSxFzCmi+9S8oXGR1+5yIWSvHWXVDZUiHvP/CApMp6HCuwU3V73LVKiwyxAA0XXHat5AS0Iysm5d6WDIEjXls9AUt1dWCOxVPLAg9oMr1uc2ulP9QK/j+hvLBfgAvlc34/D6Lh8Pwrz+eM0DuppIn0Y6upJpNQGs6AUNouxWyNUlVrawdkwKnIY1DayZrLhQlKY1nVuDV6EKkzdIdZP8Jopp8RLGplmurck9Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eOxj3tAaFh669Ebm0Eq8c0JPByAS6OcYyrZyna204BE=;
 b=EHLfGxyXmckVlTyYZrf3PlwMq+THC/9ELKN88gg8KMJSntZO09lmiONHbehGWhG3NAkNmewcfUoWQQ4IetsO7s5++oAuoznYpdfm1psvotdtr6zSsH/vvF+TPBSLN/brk1lcppTyYaUbHYYXnMe+TezvsEASTKjAddP4v1z2KpMfyTTdm+RzJDzi8AXKadxGki6m12BjElOyDuf3epbK6JMd3c/byvDgxADnNXFPf5V8Hhef9NtpCIGXGnDmUgG+qyo2zkIH5BJXD9DEjKOuRuO5n/c21ilik8SdrY3/9kb4ar84Ehi80y/HT7+vNv15hZ7YvCkdzwlbZsKuRItFNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB8811.eurprd08.prod.outlook.com (2603:10a6:10:478::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Sat, 28 Dec
 2024 01:12:00 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.8293.000; Sat, 28 Dec 2024
 01:11:59 +0000
Message-ID: <3809876e-9051-46ef-96ce-61bc363b307d@iopsys.eu>
Date: Sat, 28 Dec 2024 04:11:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 00/11] net: tcp: improve tcp support in legacy stack
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu
 <sughosh.ganu@linaro.org>, Yasuharu Shibata <yasuharu.shibata@gmail.com>,
 u-boot@lists.denx.de
References: <20241223105852.1074404-1-mikhail.kshevetskiy@iopsys.eu>
 <20241227210012.GG1505244@bill-the-cat>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <20241227210012.GG1505244@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0079.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::19) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB8811:EE_
X-MS-Office365-Filtering-Correlation-Id: ee984116-e761-40e2-a68c-08dd26dca113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RnZueHB1N2w3bTZQWnpZaXFEMWM4VkpGeURobktSZU4wenZPTjljaTlDc0dl?=
 =?utf-8?B?UHZXaU1KaHNBZ09OOWpIU0MxS1ZNbHN1K1FTT2dCbS9lMEJFSWswdEhRd3Fs?=
 =?utf-8?B?bEdWbFJUMUtWYnR2RVN5WFVGdWdiUXlxcEx1eW5OcjhTeXJaVnpqUXR2ek0y?=
 =?utf-8?B?THkzMG9OUmcvOGIxWXowRnpoaU9UTWlHamxSMXpkSjBLcWtMRzNFTEVUckYx?=
 =?utf-8?B?ZjV4NUt0L0FmS1pnOCsvNUZ3VHpzQ2FvR2xIeUYwZTlFdWl5RkZJdEtablVL?=
 =?utf-8?B?bk1jenpwUnhRcEk4ZHZ5V0hqLzFQZXVDUDIvRFdtOHBTKzRUU3BZVVFmcFZG?=
 =?utf-8?B?Y21sbklEaXNXS0hUVkhWTThPOFMyZWVxNkM4MzFVcG5kYzZnM1IwaTB3eGwv?=
 =?utf-8?B?VU9KOUs1UW53K1VQc1VETktIZ0dkRUFUcDFCQUlMWU0zYWFEcU1WT0h4UTNY?=
 =?utf-8?B?RFZIZHNMajhiVUJVTDlmNFU3bmJpZXk2RDE5dDhFQzhkUTlLOXBDQUhmOVpy?=
 =?utf-8?B?cVRSby96WUF3OHFlMmZ6bU9na0dvZjlJYjhqWjhvQVNNcnA1ZHRQajdWaVNi?=
 =?utf-8?B?bmt1Wnd4Yms1TXdNNnFYMDFMNk9lMVFjOHVlR3ZSV2dJdVkwTVBFbUpHa1Nx?=
 =?utf-8?B?ZUkyNzduTkhMVmt3TVd0UGlQcjNPc1ByM3RNU1RyaHorK0NhdktxWWdqS1Bi?=
 =?utf-8?B?YzZRMTNZbGRxTXk1RW1qbXNVY1dYdEQ3TTZhQzMzKzhsYTdvZEV5Qll4YzRv?=
 =?utf-8?B?UjRQaGg0dG01anFZSkVBNHg2b05Qa0FrRkZUdVJaZHFzQlhiSmZmZVRQS1JE?=
 =?utf-8?B?bDJRZEwvQ3ExdkFEVTYvRTQ1OUVHa1hFWmk0RkVDNWtKQmpYcWs0Qkc1OWxR?=
 =?utf-8?B?UjMyZHFRRE1rMElXa1dHRzBwYjQ0czNmNDRxcVVDRk9jS1dkd0VsSXNDVVlq?=
 =?utf-8?B?TWhNZ3Z1WURJUVcxNEVYUDdWaEV0VUxOblhlbWVmU3JnTU1pSExqL0ZEOWxx?=
 =?utf-8?B?QmxXbWltczA3YksxZkRZMG5oUkV4K3FNZFp5UDhycWU4OVY1TlgrMFBDbmwz?=
 =?utf-8?B?RWZSa1Q1TGFHNnVRVWZPc3hxeStwMUkrZm5aTnlpRjFPQzBtWkszNUpaclgv?=
 =?utf-8?B?MHdiV2l2eSsxbGRwd1pFdkhCN3labVNscmM1UFdmcW9PSFZmT09jVXR0K3Qv?=
 =?utf-8?B?NktnZXNzcm5PekI4cXdlWG11bjZKVGo3eTV6Qlh4YWxHMnE2UmZmb0sxVXNZ?=
 =?utf-8?B?Tjdnc1B2U1RYSW9oWDhKRjZnT1JmTXJsa1VuNTNVWVFXS2JEem1oY1RxK3U0?=
 =?utf-8?B?aTVDd3k1cHBqVHpJZVNrV212bVRURmVKdDBPaEJteEZ1TXhabS9paVVtYmF5?=
 =?utf-8?B?TDVheTRqNlV1MXg0SjZTRDFId3locGs1Ykk5YTgxRURxdlN4ZGt1ZkpZWXd1?=
 =?utf-8?B?dC9zQzlBNWtsVXAzQWNpbHlLZ1ZNMVBFS05PbnRiNUZoNEZLRVNRQU1KMzA4?=
 =?utf-8?B?K0llalFFY2pVR2VsZmhjR1FvWnVkc0xYMlpGeDkwOUlqV3kycWMrOTQvbHZn?=
 =?utf-8?B?N08zWmtTQUJlK016Y09GK0NzNFpENGtZV1F4blphaU5NYk54ek1PR3B6WlQv?=
 =?utf-8?B?WUtpcUViQkF2MmwyNDJLZDIzUUJIbWF2YWhUSklzelVaY0JSMFVRcnZIOWk2?=
 =?utf-8?B?Nk9BTmtoa2pBdkZhbDlLczM4aFhGYUNteW80aU96aHdUZ3pNZFpib0VrNTdh?=
 =?utf-8?B?Z3J2SmZ5bXJDZTJ4eDg4TXpJVzBQdXNwU0VGZ2UxM0QwZkN0bythMWFVZmZr?=
 =?utf-8?B?cDFFOE9ZSWZwSlAxZzJwZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(7416014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkxPa25PTklrSE5SSUs0NHd3SExYT2lIYTBnakFabWhIL1RSVkxNVGxUUjFY?=
 =?utf-8?B?dWlQMWVmZkxFYVZuckR1cWgzbW1teUE5R2hrOTgxYjdwZ2lrMEx0UEtlUUVM?=
 =?utf-8?B?WENoUHVHVjJ0cnJiaTlpZDZpdFUyTDEwRnNpRHFVOUFwa2Q1c0ZycGluZzRx?=
 =?utf-8?B?NHBjVmpCd2NDNEhIdWkwaXp2VDlZNHZxNEZIV3J1MmYzOGFzNnM5d1lia2hv?=
 =?utf-8?B?bWl1NGlOektXa3l4amI4OFhyaFJ6WUZzYytLMGFIWFRmdXJTV0lsV2NsRzVY?=
 =?utf-8?B?UGtaZGROZUhwUmE1UlQ2Z05PVWwwYkhDSmd2UVBQZlJ4MnFtR2VEYWZGbFJT?=
 =?utf-8?B?a1hIMEtRQVhNRkE4TXMvR1ZyVVYydVZIVmEyMm5rMmpkUXpGRUhINjNyS0V6?=
 =?utf-8?B?b21KMWtEblJHSjhtbE5NQmlGU2lNamNDVmZjZ2gzWk5UNmlFa3gwWG5VanND?=
 =?utf-8?B?VU5tcXhGYWM2bk5SUmgwMTZyelZlS2drSjlVSUpDenh4cHZaVVVVMG4wM3Z5?=
 =?utf-8?B?TUQ0dzNYdXNWOURVbFgwTHptNjN5WjM5QXdHREQ0WDd4RWhLd0xlTCtqZk1S?=
 =?utf-8?B?bi8vM3lnSWFiMXE0MjFMTGdYNEtJM05sSFVmVGZXWHEzN1lkWEU0ZlRzQ3px?=
 =?utf-8?B?ZFR0K3BubDVUanRDVTVFWWc1cGd4dGZ3QlA2QnJZLzEyK28zOVJKTDBCd3pj?=
 =?utf-8?B?WVkwcXFPSlpzd0hISTJuS2MrWFh3bG1ReVZHb1ptN1hpSlphNXovYVdrRW53?=
 =?utf-8?B?NUIyYlhzOE1LeWtha3JSUlFhOGk2VVB4bmwxSk9YcXJPN1UrSWc5QVZ3R3hX?=
 =?utf-8?B?QW9ESDJDbzRNNHh0QTY3QzVNREZVeUo2R2F5Wjg5eWRteUdwNnU5NU1xMHEy?=
 =?utf-8?B?MjR3cGRIN1BvYUZnS0phSE5kR2pvVFBka0M1S0RuRnAzQ1JxcWlLVWM3MEZ1?=
 =?utf-8?B?aGxNOU1CZit4UjVjVlpQemRWTWhkN1hHYkVzMXE0eFNCYVc2c1NSb1puM2VG?=
 =?utf-8?B?bmZobkoxMWI4UnZKQ2g3N1lKWkYvVUpYd3E1dm5Sb1FieDBGOVpwT3lKaEhm?=
 =?utf-8?B?QUJESlBlZGhuMkVKRFFtd205Nm0vcUFjd3FFUWFUZHlibzFSQUlyZzNhOEJF?=
 =?utf-8?B?YzFHZGxTYXFEOFU4Rjd3c1huMHEwbjlZMkVpZisvTFFZMG8yZkp5ZjZoTTFm?=
 =?utf-8?B?ajNpVVBRVVVkdTRWL0tPZ2k5NjJDd1V3LzZRRHJiVGZkaGErYjV6NE42eWhZ?=
 =?utf-8?B?YzRWSGFvUGp2ck1Ja0NvT005VFBsc0VKVjhEYjdzSWs0OUVUQnp5Nk1DWFQ2?=
 =?utf-8?B?cjFGMng5L0RITldNZlBlWnZRWHRZYnNCaU9rbkZSL0FrNzJYUVViYzV4SWcr?=
 =?utf-8?B?bTRjaks4TzlrUFc1M2k2VHA0R3o3WWdnc3ljYW5mcTEzOFFIZXpwdk5vc1Bm?=
 =?utf-8?B?aDMyNFpaVVpOb3F0cEM5QzFWZ2xqTitqOEVnR2R6UjlycDhCek5nZ2M1bnpK?=
 =?utf-8?B?eHVJTjdqbHJITysranN6UVpnbnpNZE1veU1mekxGVjRnajI5azFvbzdkU0ZE?=
 =?utf-8?B?TFpPZEQ5UGxvbzBsalJ6QytWd0VzcUpacExXQkRCVW9ZdnRhKy91bXBjYWs0?=
 =?utf-8?B?WFFQWXJIckNjU2RvS2VySVNHVTZ1eVA2VlBVdis0RFdvcjF4T2hrR2xldXNz?=
 =?utf-8?B?YXJvcGFDcFJvanhWUDRtNlh6cDFuc3h3RDJIMWFTZTZQTE9QMk1taDY2RDN5?=
 =?utf-8?B?c0xtM1ZDWGNxbWRuNU9Kem1SalhJc0t2b1BRSmVWOVJaOTdSTDRQeEtYN1lO?=
 =?utf-8?B?cnJNT2J3UDBaS3Myc2R0YXY4TVBwaWYzbmhHMWhqS0VZQTZWVC8rRDkrdXdh?=
 =?utf-8?B?R3hIVGhRMlNjSU5xQWFjY3RKVGNyb0NiK2wzNU1zTnNUekVFSHhpSlgxQytl?=
 =?utf-8?B?OHBxMkgybFAxNzJyWXp5Yys3N2F2UVFtN01LUkI2Kzd3MlN6TzlYMzMrTFMr?=
 =?utf-8?B?TzFIbGNSK200cGZUYzhhY1AxYWhqd3NPbG9Bd09KdFJiZjVkZFRvVnVweFFU?=
 =?utf-8?B?OXNuUHVyWkZaS012NExFSFpKcXV3TFhSRzVQTWNCUzg3OFJwR3E3TVpuci9M?=
 =?utf-8?B?NGtiRHV2TjhZclloY2IrRElkT1pLdFpDUFE4Qm5LVnZvRmFlOFVITFJORHZO?=
 =?utf-8?Q?iAy+b5ifIP2reoP2K3PTQPw=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: ee984116-e761-40e2-a68c-08dd26dca113
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2024 01:11:59.5073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DQ2CIuesOnuZ7OpHtHRq2vMY9SbDlaodha+C/pbSq1RShxzkCUOmTJojYzawC9N8rx5rdSc9Y6GDR3eScNgN+Tj0hrQUEY7mZMWVaOxuVhQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8811
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

Is there a way to run this test normally? I tried to run it on x86_64

* make sandbox64_defconfig
* enable CMD_BOOTEFI_SELFTEST configuration
* run u-boot with "sudo ./u-boot -D"

type the following commands:
    => setenv autoload no;
    => setenv ethrotate no;
    => setenv ethact host_enp1s0;
    => dhcp;
    => setenv efi_selftest "http protocol"
    => bootefi selftest;

but DNS functionality does not work. I tried direct DNS querying with
the same result

    => dns example.com
    UDP wrong checksum 00000001 0000e946
    Timeout
    dns lookup of example.com failed, check setup

But wget, ping and some other commands works normally

    => ping 142.250.74.14
    Using host_enp1s0 device
    host 142.250.74.14 is alive


Lets go back to a test.
As I can see this test should not work et all. Current wget
implementation requires
"default server configuration" being set on target server. Unfortunately 
"http://example.com/" does NOT set default server configuration.

Thus wget open 93.184.215.14 server, then send the following request
    GET / HTTP/1.0\r\n
    \r\n
Please  note linux wget utility will send the following request
    GET / HTTP/1.0\r\n
    HOST: example.com\r\n
    \r\n
(some meaningless headers were omitted).

As result in first case we tried to open default server. It's not
configured, so we
will get 404 error (Not Found). In the second case "example.com" server
will be
queried, so we get normal HTTP response.

I can patch wget, so it will send HOST header. Unfortunately it will
require configured DNS.
What do you think about it?

PS: Anyway, I found a bug (incorrect error handling) in my wget code, so
I will send v16 anyway. 

Mikhail Kshevetskiy


On 28.12.2024 00:00, Tom Rini wrote:
> On Mon, Dec 23, 2024 at 01:58:41PM +0300, Mikhail Kshevetskiy wrote:
>
>> Legacy TCP stack is bad. Here are some of the known issues:
>>  * tcp packet from other connection can break a current one
>>  * tcp send sequence always starts from zero
>>  * bad tcp options processing
>>  * strange assumptions on packet size for selective acknowledge
>>  * tcp interface assumes one of the two scenarios:
>>      - data downloading from remote host to a board
>>      - request-response exchange with a small packets
>>    so it's not possible to upload large amount of data from the
>>    board to remote host.
>>  * wget test generate bad tcp stream, test should fail but it passes instead
>>
>> This series of patches fixes all of the above issues.
>>
>> The benefits:
>>  * A lot of bug was fixed
>>  * Better and more reliable TCP state machine
>>  * Tcp clients becomes smaller/simpler
>>  * Data uploading was fixed (now it's possible to transmit a huge amount of
>>    data from the board to remote host)
>>
>> Modification was verified with
>>  * firmware downloading via u-boot wget command
>>  * fastboot over tcp
>>  * netcat linux client using test netcat implementation (not included
>>    to this patch series)
>>  * Firefox/Chrome/Edge using test web-server implementation (not included
>>    to this patch series)
> This fails on the EFI self test on qemu-arm64. You can see this with
> "bootefi selftest" on the platform, and the excerpt from the full
> failure log at:
> https://source.denx.de/u-boot/u-boot/-/jobs/984858
> https://dev.azure.com/u-boot/u-boot/_build/results?buildId=10224&view=logs&s=664d8594-b731-54d7-afc5-7167226e08f3&j=52970d71-9fb7-5005-2ae1-66817be903ba
> is:
> Setting up 'http protocol' succeeded
> Executing 'http protocol'
> 93.184.215.14
> Packets received 5, Transfer Successful
> lib/efi_selftest/efi_selftest_http.c(216):
> ERROR: File not found
> lib/efi_selftest/efi_selftest.c(114):
> ERROR: Executing 'http protocol' failed
> Tearing down 'http protocol'
>
