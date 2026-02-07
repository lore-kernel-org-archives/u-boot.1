Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0507EE6B4E
	for <u-boot@archiver.kernel.org>; Sat,  7 Feb 2026 04:24:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F04083A64;
	Sat,  7 Feb 2026 05:24:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hWbgWG+Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2A1B83B86; Sat,  7 Feb 2026 05:24:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8613F83693
 for <u-boot@lists.denx.de>; Sat,  7 Feb 2026 05:24:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ye.li@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QsPgJ0GvoAwO465vwZXXFflN+oTWmMd5NM+wGWw9li78bBxZrwYbW8XgcNj1jcCzg6B+b7KQeZhWpZqVlb/3Jbnws3brWFofoOg848pFmeqY/AVXsqh7qA9jIxLn6VbGFodkdfRjyDpoVe/g8ulOKafONyC40z+9An9fnEC/qboRo6LYPS6Ke+++3E00P09XaPT7506Oda4cxEgXNRBCUPuvPAfOYhqPEgLJYxqEJ0Rum2/AmUF7cNOeuy7fyvnBnQQUMcdGTaPo4XdwPcwDPMa8dQNCLv8lOhBDFgZjGizolUKo+lufXVMWQf0tbO50bMwjphDLRsSkLQSvcb8CSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=09VwOXwNKpIKudTLm2Bg8Kkan0CIdZBnozm+DuPOjbI=;
 b=iAk84S5j7iFjiugwpi4fpTWIeZLrgg5G8tgyrDzqgm1D6NDcL/MdWxoFDpwn8XoTRFH+VHhfz7fReExrkCasd/d9b0X3cSILqGIUQcVwtwwyH/2P2trNfQC8vS8+IPpG00bACdAg+Z2Pl28EsPenunqifcK4M8kPbYeX/bxmMoDYgY3ojwVPyo+eEYpOQtn15QeGPeCYBwN6ng3EJVRZ0eNgubpWhGL9rvga+85k7UWCiW0ebOTntFWoAqyS16BwPYhQVIrW1/PgbpxqGlGTak6kS40jPKqrJ8CztsTOTJX6YyamAKOMyUU82/JCNkIid4XzFFWTwyDQKVfvaViV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=09VwOXwNKpIKudTLm2Bg8Kkan0CIdZBnozm+DuPOjbI=;
 b=hWbgWG+QjLeawcCBcIrFHDcPazEdb0e5wb7AZfoUyMP6PIbCCRk2HvkeUtu3NvfmuaoMOukkwluhrkgLB9vPVhJkQ4pwcGV6CLmqFAmCtigIWBK8N8KNRH4Rjf2T824XQZAt44GV/Pm7PQdsaQYjkMfH0ty/B2Vbz04Y5w+EBqtC6y0JIyVE/7D6lNuUE1hYr4av9aOXLQKDPKuqcjOo9yzvZJe9p+X61Vr/EuD1IZ9C6JekIN+lDi9t2WrUH4rh1MHnZK/lF6SSjfCXuot8MFfGBfldcBDMkuenDPIb9Jglt2x/9U9KJELuv+yLxB7BlOsuBcBbpqG0YKSRc2RH2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com (2603:10a6:10:369::21)
 by AM9PR04MB8780.eurprd04.prod.outlook.com (2603:10a6:20b:40b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sat, 7 Feb
 2026 04:24:34 +0000
Received: from DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::c78a:2434:3a7f:3187]) by DB9PR04MB9427.eurprd04.prod.outlook.com
 ([fe80::c78a:2434:3a7f:3187%4]) with mapi id 15.20.9587.010; Sat, 7 Feb 2026
 04:24:34 +0000
Message-ID: <8da74e3b-4b71-46a2-8a60-7d75705f35cb@oss.nxp.com>
Date: Sat, 7 Feb 2026 12:24:30 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>,
 vigneshr@ti.com, b-padhi@ti.com, n-francis@ti.com, nm@ti.com, afd@ti.com,
 u-kumar1@ti.com, i-sihag@ti.com, Anshul Dalal <anshuld@ti.com>,
 Peng Fan <peng.fan@nxp.com>, Alice Guo <alice.guo@nxp.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <DFJ950O0QM0D.380U0N16ZO19E@ti.com> <DFJ9947VLHEL.PCDIJCRU24BS@ti.com>
 <20260108141233.GQ3416603@bill-the-cat>
 <939a9696-27fa-45a1-b428-feffe21ac6d5@oss.nxp.com>
 <20260206142821.GS2603314@bill-the-cat>
Content-Language: en-US
From: Ye Li <ye.li@oss.nxp.com>
In-Reply-To: <20260206142821.GS2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To DB9PR04MB9427.eurprd04.prod.outlook.com
 (2603:10a6:10:369::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9427:EE_|AM9PR04MB8780:EE_
X-MS-Office365-Filtering-Correlation-Id: f749427a-0cb6-496d-2498-08de6600cbe0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|19092799006|42112799006|7416014|376014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SnB2N1U3YXE0OWhySlBDS2dPOElwZlJ5N25XSEFRZjdsQ3lhdktldVFuRWlH?=
 =?utf-8?B?N1VvK2dlc0pvYzhORmNDNTFheThLSFBzc2ZLOW5XSkJlMTJpYUhaQ2V1L0ZS?=
 =?utf-8?B?UEtpdGcxeTU5SXB2eGdiNG5FVDVjYXVuRWptZDVpckFScTlSYlNuR2ZlSXkr?=
 =?utf-8?B?dlcrcFZhLzEzVzZpOHRDOCtWa0NqZUZJQXJGQkhoVkR6NUJKQTNwNHpVNWl4?=
 =?utf-8?B?aFlsUDRyLzNraVBEOXFGUmphSWlpL1RLMmVhcXVEVkdkOEFMR1ZlOG1URVpx?=
 =?utf-8?B?WHEweXFIK29NRFowVGpERy9xZWlLNE9oZzR5STR0enIxd2NRa2hRNlhRM1Jl?=
 =?utf-8?B?R2FxSDZHZHlrdnF1WUVFWUY1czh2c2M4VUlNNlpmRzNiR2pFVXZrRmNrN1Jm?=
 =?utf-8?B?b3Y0M000ajNCeDN0UEJRbDl4RUJiRTJtdE5oZmFlSXdUdUxzeHo0Nm1hbi94?=
 =?utf-8?B?eUdydlBzR1lhZXcxblkrTEJDenZHUjl4aDhMbzVuRXZ0Y1p4WXl4aGVZOGdt?=
 =?utf-8?B?eHlnMUs2dkI4ck9Sa1cvRzIyUlpUNEo4eXZZcHFzSmlMMHJLYUxGa0U1VmVo?=
 =?utf-8?B?MU05U3VyaG15Z1ZzYzBPa1hmUysrMlhkbFQ5YytNeU90WTVMN1F2STJFcWhF?=
 =?utf-8?B?U1pNLzlWOUtadVpnUGdRRWxMZFR1OVo1SG13SzNYSFRrL3kxYXNZVnYyTnRJ?=
 =?utf-8?B?ZU95clJWRVJPK3dYeEEzekltWmtNT0QxeXpOZlFuVEdGR1JuMVl6YlJsWU5N?=
 =?utf-8?B?dUw3UStiYTJMcjV4Q1gxTWJ2V3o4VGtWQmo5VkduZU02UHlYa2tnZzVIb09q?=
 =?utf-8?B?WnFKYis0MUJENVhNQnR4eXNDUkhqaGg0YjRzM3JzdXpwMVJ5dmFhL2pjREFw?=
 =?utf-8?B?RWNadDliRGZwNnRwLzhyL09xRE0wM0NqSlhzSmwvY3BtK3l2RUg0SjBtUkhZ?=
 =?utf-8?B?QWdlaU41bVdLRFNHdHJOOUMxaWpnQVZ3cXNhMzhNRUdaZkpia3lWYklYYnJq?=
 =?utf-8?B?ZHpNTmtSUmJ1T3M1aHF2YjlJQzFaM1M4UGlTaGhBbGlTbEx5SWtuaGEyajlp?=
 =?utf-8?B?d2g1WFhvSGdNUTN5T2dkYWJGNXRnSDkwejZaMmVpN2NkNm1EN29Jc0p3bFN1?=
 =?utf-8?B?bDFZUHRBcitZRHhORFJIUU0xMHlkYnJwcklhenNDYnV4Nyt4TjVRMU9odGl2?=
 =?utf-8?B?d1cxWWNNUDZpOHVETVk1ckZhK3ZuQXFPNDd3TGtvc2NYQ08zSkJtNC95ank5?=
 =?utf-8?B?RzVIWVh2YksrNzRPM0F4WlFFVEMzcGlldWovRTRnZjV5cVFXMDVTUTc5ajBB?=
 =?utf-8?B?VGNZUjUzcHFqSFJhZUxmTEVmaUErTHVDQUNvZmk0Z1lTL2w0TVBFQnE3VTFN?=
 =?utf-8?B?RDBTR0xVK09Kbi9jZXJ2NDBTemhzLzdicm8wVkxQRlBPT25ESm5oeG44T052?=
 =?utf-8?B?SjNRMG5lbkc1bVovSkpydGJuRWRzT20rNWxqV2p2dktXYVpCTWREVkJTb1Vq?=
 =?utf-8?B?OGwvYUFxOHdVSFNPZmR2eUFVdmIrT0FHVXRqWFhEUUxjdWFyaERSanQ5Y0pT?=
 =?utf-8?B?WlRDUjBiemV4TG8zVHFGSlVPSGxJN0VLTlBvZ1kreUtTOGZJa2FvZC9MSk5V?=
 =?utf-8?B?RUkrb2pyeGJiZ0RnOFVxVm5BODhkUmlTK2o2cEUrTnorSCtXNTFtRGduMHZM?=
 =?utf-8?B?RlI2bjRkRTA2V1hNTlE3WFVZMUFCc3pYQkNsU1d6SnpSRW56enhBZkFydkZT?=
 =?utf-8?B?cWg3cVl6SVBNNjJMMVJzOEt3Q2JCeGF4ZGY0YlQ0SHlCOFBWM05ZSng4dDdP?=
 =?utf-8?B?VGl6b3pSaFRZelVlRjcvWGV0OHpsN0ZZTUYxRmJNZnA3VlU5RlRBeldSU0hS?=
 =?utf-8?B?R3RlS3Z2dVFDR2lMSm83VHlPMTlnZTgwRG9mZU42c2p3bm1kYWNYWW5MU1RV?=
 =?utf-8?B?cmUyZFZRbFBoN2lJRXRkWmVMYm9XK2V0ZnNIYWw3cjVYTHk4YzlncjdzQWNn?=
 =?utf-8?B?Z1NxV3RpaUpqVXNkUU81NGYyUUl0RlQzUnRucFVBRnBKQUNBS01jNzYvZmRo?=
 =?utf-8?B?Zm1PZGdsN0VqZWFoU2xqcWRoU3JSelRkSlgxallaYjQrZzh4aGpEbWtEVFZv?=
 =?utf-8?Q?05E0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB9427.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(19092799006)(42112799006)(7416014)(376014)(366016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXRQN3dyVGE1NVBCbEdLV1JKN1grK0tFVDFOWTIzTXpkMGdhQUJ0YlZlL2hu?=
 =?utf-8?B?YXR6dUViSG9sNjBtdHVXVnljOE90SnYwL1VSY0kwNGhmSi80ak1IU25WN2lU?=
 =?utf-8?B?OWIwejB2a1BMNGs2Qjg1anUrcXF0NmJxUTZoempJTFNXZElRUTcwSFpjVWtk?=
 =?utf-8?B?QWlCNFJXMnI5Q3dvVnZyMjdJUUZOVWFaNkpyaEc0MDZiN3R0RCs5c2g2bzVm?=
 =?utf-8?B?MkUrSVM5LzFLbk52ZGZBZzhBdlMwNFlrR3JQVVFJZG1Qc281YWNCLzhWYlYr?=
 =?utf-8?B?NVRHSzdNakxyc3lKNUJHZks3QW1LWUxqZzdxeEV3emUrTHcxZWtXbGtQeEZI?=
 =?utf-8?B?QUh3SkxPeXRqUjVjWFBWekQyS0RZNzFiYW9xV0ROendsRlFzemMrL2I4Wml5?=
 =?utf-8?B?WG1ET3hWK2tZK0JkNFBYdkRSRC82QjVUcEprTDFZMXhmMXRESzZwK1B5MWpQ?=
 =?utf-8?B?VUI5K1IvaWNqb3V2cHErZmttVzJSTTFFVW9hQ1JETlNZc2VKOCsxZ2l2REFa?=
 =?utf-8?B?UzJvcUFoOXJrSUlSTUg0aW80bHBVTTM1S3pFbFBsZTBHb2QzTEtqblhCQkox?=
 =?utf-8?B?R3hYTlllYUpFbSt4VWsxL3A5VUJHM0k2d1FGSEJVSVIxR3lWZkhRMDN5L3Js?=
 =?utf-8?B?VDdxL1JIZDdGN1ljaUxVMlFoMHI2TFpOQm9rWWFrd29WSFFiQUdzdnE2Mksy?=
 =?utf-8?B?cVNoNFdURk9PTUd6RVQwTFl1WmF0ZlB2UldHcUhmMS85MHd3OHV1Nk9mS0pY?=
 =?utf-8?B?OWs2K3lRNnZrenZLNk04dnYyOS9yUGVuazlQb0lmaUN6MlFVY0JsU1BIVDhF?=
 =?utf-8?B?N1VUWlFsZy9TdytXN2FxRGRWOHlhRU1qL1kzUVIyVmhUMnRWYndORkMwdlI5?=
 =?utf-8?B?STFOS0RubkRncUhQbEpXMUJaU3ZUV0Z5ckwySXJwaW40ajcwKzFWcHk4UEhu?=
 =?utf-8?B?OStHck9ZWmtNN3dnN2NXaHNhamNxd0lFYk1va21HZEp4NXhkR1Z5UE1EMmVv?=
 =?utf-8?B?NXR2ZWRxSjFVTjlPVjJzUkp0TXVjaDhiWTVmN25id1haYlhVRkpEZEJGRmxO?=
 =?utf-8?B?TW9VUFJCbXQzY1J6ZElBNVk2ekZDbkhaS2cwQ3pqa3NOcVJYTFBta0RqaWpT?=
 =?utf-8?B?VkhubDRxUUdsVm9WMEE4b1JaU1JScDluOExKeWFpTzBKOE0xSDNHZzF6ZEdO?=
 =?utf-8?B?OVhKbVk0ZlhoSGRZaFZENmw4RDJCTG9GZ1lGQmFsY05qTkg3S2tRTGg2R3NY?=
 =?utf-8?B?b3dXd0puMTVUWlQ2SGlvUFZFRWhRWHVLdXIwb2xSbFJYTG41MmJMaTBmbDJm?=
 =?utf-8?B?bXIrbW5DN1VnRnQ4amxHQWlYNlZEYlpFazdJd2IwbVRPWWErMGJGcXpCSDVB?=
 =?utf-8?B?dW54aWlyQ3hxTHNBK2tCUG05R2dYU3RCQTdmTnFZYzRaUWI1QnBPSE05ai9N?=
 =?utf-8?B?QVZ5RkhiWmdoSDBKZHh6VE92LzBzQmwxK1dtNGxxRFpTWUZieUs3MDFZMUFH?=
 =?utf-8?B?NndOYkRJdHpUM2dqQTBSOEN3ZEZOM2VHbnFPK1VQVEVaQ0k0ekxUdWdUT0hD?=
 =?utf-8?B?ZEtKNlZ2bFR6T2xJQm9wZXpYQytsTXJ1aUZGbnM2KzhxNS9iYzQ2Qk16dnNk?=
 =?utf-8?B?V29paGhzazR5RUhXOVBpQWNiTW8vcml5S0czZUluMkhuSUV5YVlyM1ViR3hp?=
 =?utf-8?B?a0lvd3o0WkcvZHB4SVVhOFBwd2FsdEQ2WGRNN0h3R0hhK0hlT3JjKzZLbVFm?=
 =?utf-8?B?cGFoK25xK1UydkFTbHF5MHVYSGVsUjFmczN2MmNRVStwQld2UWdwbm9lTmtj?=
 =?utf-8?B?cXpwZXB4eDkrWWdWbW1JRys5bk1ZdjJjR0F4WnNlSm1iRzE3MjJpQkJKaEZE?=
 =?utf-8?B?ZTZZZDRPZFJwbXJqcFg2QTIyaUhCQVZ1dy9zUU16TS95NDIwLytJRk1yOVgr?=
 =?utf-8?B?RWJRcjVmSGJ5NHpNQkxZRHV1ZVNYZlNxMEhJN3N1akZuR1ovVW02b0NyMzRR?=
 =?utf-8?B?b0prZEhqWTdDcnRyQWV2M3ZDNHN5UVlrL0lVTmNuaTNCc1ZRd3FIalczUUtT?=
 =?utf-8?B?N3FsR3l4VHNWVGtCL1dYTTJndk8rYXo2MzZGTGp2cTNEdGJvSHp2ZE9YVEV5?=
 =?utf-8?B?RFowLzdkMnFQTmdOQzhDbDc5Rmdwblp6VHdORTRkY1NnS3E3Z3p5NVJodHlu?=
 =?utf-8?B?TW5FV1orcU5yMmI5RWZiTjhjUE9tcjNIQ1lRSkw3cTNzTUdaRlVXUkJKck1U?=
 =?utf-8?B?QnM4Tnd6Wkd0WTlPNmIyTmgxbGNVTFV4SnpDU3RyMlN5YVBRYzA1bncrQTlp?=
 =?utf-8?B?UFBMYWRSU21wWGZHZXpFb0hhbkNEZW91eWFtOHFpbVJ3UVZONDFadz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f749427a-0cb6-496d-2498-08de6600cbe0
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9427.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 04:24:34.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxA6MRq0g8dllaKQ5FHeul0SwQmNbaF8ZrHt09kzvGL1TaADFJJw2JOYy5cnyFCz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8780
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



On 2/6/2026 10:28 PM, Tom Rini wrote:
> On Fri, Feb 06, 2026 at 05:11:20PM +0800, Ye Li wrote:
>> Hi Tom, Marek,
>>
>> On 1/8/2026 10:12 PM, Tom Rini wrote:
>>> On Thu, Jan 08, 2026 at 07:21:10PM +0530, Anshul Dalal wrote:
>>>> CC+: TI folks
>>>>
>>>> On Thu Jan 8, 2026 at 7:15 PM IST, Anshul Dalal wrote:
>>>>> Hi all,
>>>>>
>>>>> On Wed Dec 3, 2025 at 1:02 AM IST, Marek Vasut wrote:
>>>>>> Synchronize local copy of DTC with Linux 6.17 . This includes the
>>>>>> following picked and squashed commits from Linux kernel. The squash
>>>>>> was necessary, since the DTC here contains changes which were also
>>>>>> part of DTC in Linux alraedy, and the squash helped resolve those
>>>>>> without going back and forth with the changes.
>>>>>>
>>>>>> The following commits from Linux are picked:
>>>>>>
>>>>>> 8f324cd712df7 # scripts/dtc: consolidate include path options in Makefile
>>>>>> b5b3d9b63b0ee # scripts/dtc: Add yamltree.c to dtc sources
>>>>>> 7d97a76f226d6 # scripts/dtc: Update to upstream version v1.4.7-14-gc86da84d30e4
>>>>>> ea6f243be74e5 # scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145
>>>>>> 02d435d4eccd8 # scripts/dtc: Update to upstream version v1.5.0-23-g87963ee20693
>>>>>> 6e321b7637396 # scripts/dtc: Update to upstream version v1.5.0-30-g702c1b6c0e73
>>>>>> 9f19ec91a7a35 # scripts/dtc: dtx_diff - add color output support
>>>>>> 8287d642f38d1 # scripts/dtc: Update to upstream version v1.5.1-22-gc40aeb60b47a
>>>>>> 4c52deef9225d # scripts/dtc: Revert "yamltree: Ensure consistent bracketing of properties with phandles"
>>>>>> 5d3827e1452ed # scripts/dtc: Remove unused makefile fragments
>>>>>> 40dd266887654 # scripts/dtc: Update to upstream version v1.6.0-2-g87a656ae5ff9
>>>>>> 8d4cf6b6acb59 # scripts/dtc: use pkg-config to include <yaml.h> in non-standard path
>>>>>> b9bf9ace5ae90 # scripts/dtc: Update to upstream version v1.6.0-11-g9d7888cbf19c
>>>>>> 69a883b6f5ac0 # scripts/dtc: dtx_diff - make help text formatting consistent
>>>>>> 8f829108b8aed # scripts/dtc: only append to HOST_EXTRACFLAGS instead of overwriting
>>>>>> b39b4342ac495 # scripts/dtc: Update to upstream version v1.6.0-31-gcbca977ea121
>>>>>> 93c6424c486b3 # scripts: dtc: Fetch fdtoverlay.c from external DTC project
>>>>>> 0dd574a1d75c3 # scripts/dtc: Update to upstream version v1.6.0-51-g183df9e9c2b9
>>>>>> ec38b5df8a231 # scripts: dtc: Build fdtoverlay tool
>>>>>> a0c8c431411f5 # scripts: dtc: Remove the unused fdtdump.c file
>>>>>> e7dc653d4e890 # scripts/dtc: Add missing fdtoverlay to gitignore
>>>>>> d2bf5d2e3f09c # scripts/dtc: Update to upstream version v1.6.1-19-g0a3a9d3449c8
>>>>>> a60878f5532d0 # scripts/dtc: dtx_diff: remove broken example from help text
>>>>>> 8b739d8658a9b # scripts/dtc: Call pkg-config POSIXly correct
>>>>>> b6eeafa67df00 # scripts/dtc: Update to upstream version v1.6.1-63-g55778a03df61
>>>>>> f96cc4c787588 # scripts/dtc: Update to upstream version v1.6.1-66-gabbd523bae6e
>>>>>> 09ab9c092ef2b # scripts/dtc: Update to upstream version v1.7.0-93-g1df7b047fe43
>>>>>> ded8a5a498f2d # scripts/dtc: Update to upstream version v1.7.0-95-gbcd02b523429
>>>>>> ee6ff6fca7e71 # scripts/dtc: Update to upstream version v1.7.2-35-g52f07dcca47c
>>>>>>
>>>>>> This also includes forward port of U-Boot commit
>>>>>> e8c2d25845c7 ("libfdt: Revert 6dcb8ba4 from upstream libfdt")
>>>>>> to avoid binary size growth.
>>>>>>
>>>>>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>>>>> ---
>>>>>> Cc: Adriano Cordova <adrianox@gmail.com>
>>>>>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
>>>>>> Cc: Christian Marangi <ansuelsmth@gmail.com>
>>>>>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>>>>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>>>>>> Cc: Sam Edwards <cfsworks@gmail.com>
>>>>>> Cc: Simon Glass <sjg@chromium.org>
>>>>>> Cc: Tom Rini <trini@konsulko.com>
>>>>>> Cc: u-boot@lists.denx.de
>>>>>
>>>>> We observed several boot failures on K3 platforms since the addition of
>>>>> this patch at the R5 SPL stage, the issue seems to be the newly added
>>>>> check for alignment in fdt_check_header in scripts/dtc/libfdt/fdt.c:95
>>>>> but the binaries generated don't have 8-byte aligned FDTs.
>>>>>
>>>>> I have been able to reproduce the issue on AM62p EVM with a clean
>>>>> working directory (this is important since any minor change to the
>>>>> SPL binary size such as by the added "-dirty" tag could make the address
>>>>> aligned) and GCC 13.3[1].
>>>>>
>>>>> Are we ensuring the fdt present in the SPL binary is properly aligned?
>>>
>>> Yes, the device tree must be 8-byte aligned, this is a requirement of
>>> the device tree spec itself that we had been lax over until now.
>> We found iMX95/iMX94 EVK boards are broken after this fdt lib update. The
>> root cause is default value of CONFIG_SPL_OF_LIBFDT_ASSUME_MASK is 0xff. In
>> this update, fdt_check_node_offset_ is changed as below to check the
>> CONFIG_SPL_OF_LIBFDT_ASSUME_MASK. When it is 0xff, fdt_check_node_offset_
>> will skip offset check.
>>
>>
>>   int fdt_check_node_offset_(const void *fdt, int offset)
>>   {
>> -	if ((offset < 0) || (offset % FDT_TAGSIZE)
>> -	    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
>> +	if (!can_assume(VALID_INPUT)
>> +	    && ((offset < 0) || (offset % FDT_TAGSIZE)))
>> +		return -FDT_ERR_BADOFFSET;
>> +
>> +	if (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE)
>>   		return -FDT_ERR_BADOFFSET;
>>
>> This cause a problem to SCMI agent uclass driver. In scmi_bind_protocols
>> function, a ofnode_null() is used when creating scmi-base.0 device to bind
>> with driver. This null node which has offset value -1 can successfully pass
>> the fdt_check_node_offset_, so causes crash in
>> device_probe()->dev_power_domain_on() when finding power-domains phandle.
> 
> Thanks for the analysis.
> 
>> I notice the default value of CONFIG_OF_LIBFDT_ASSUME_MASK used by u-boot is
>> 0. So why does SPL have different default value? Should we change the SPL
>> default value to 0 to align with u-boot? Otherwise, any idea for fix.
> 
> In SPL we must assume a perfect device tree has been passed to us, both
> for design reasons (it's not a user interactively, we built it, or it
> came from some other firmware stack) as well as practical (performing
> the sanity tests would grow all platforms by several kilobytes and
> overflow size constraints). I think the SCMI code needs to be reworked,
> in short.
> 
Thanks for explanation. It is reasonable to have 0xff as default for 
SPL. For SCMI, because its base protocol(0x10) is mandatory, there is no 
dts node for this protocol. So SCMI agent uclass driver dynamically 
creates a device for base protocol with null node. See commit 
(7eb4eb541c1 firmware: scmi: install base protocol to SCMI agent). This 
implementation seems also proper. Do you think if we should set 
CONFIG_SPL_OF_LIBFDT_ASSUME_MASK to 0 when SCMI is used?

Best regards,
Ye Li
