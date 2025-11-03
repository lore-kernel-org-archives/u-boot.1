Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F378CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:13:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F718394E;
	Mon,  3 Nov 2025 13:13:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="gw2r3DWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93928836D1; Mon,  3 Nov 2025 13:13:15 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC2483955
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvWh6imJUcT52WnY7flMlNQx1XP9GQDImO8AwltrkYBoMW1ii6rMqi7oTz2enht25cX4A5aBcHWLzLIDo0bSRkCugWtkdckqKLFVvhzqOa+ZvzUWrkcTwt3R+wTRbqF9pE5WVrxOSGm2Pf7uFPxpNJNJdKCr6OOZBMNO9e3TeuV4M65KcWu80cEQ5PNH1tc2o2chjVxEqaDtsbXvQ8xpNmYwv7XbjShGujDZW/90f52bH+Zg89NLGMEVL/+orEaq1H8iMyX6hmE68xlaSIwh7Yxasi/R1yeb6ayk+nCVWWhid6maY2+PgCBJf5kwN5+aJUSGtPGrxGHGTAFn8sPSjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OhCjCq0qEMvCSl251udMB9LKKzNXdZ2HX93Maoc5Vg=;
 b=K92jsXRhCtnqbgbLKW17jLkfXKT86F3c/CdwmLki/OOt4GxIWai0mW62bTucm9ydxnmzW5mZanMq09kCZVlDnfqsAOIN1sm4wq40J58Wyq02ubwau05PIsd7LX10WeUHT/h8NAJt+VxVkj+zF8zi8m9HitT3G4sxtddWtkYoI7le6rQORl+plaD2Kw7y6vB3M0Ddbi8b9/9ZKRsuW2BSb+dQgDX6lZuHtFMJ+JmtwsA0PjoOXiW5hyp6UPYTzdP/JIiPUEDIKU+njquodZVShmmYYRon9tow3ZZCGjNkNlXMK2LlRf5eqH4pM+C/fGZCpoMQuR2bLWEcB57lxZFOLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OhCjCq0qEMvCSl251udMB9LKKzNXdZ2HX93Maoc5Vg=;
 b=gw2r3DWck3Q3/DeViMWHT5jGQ9iTIa9shuI7KG2svxfgq5tRcZudLsMN2mq+IYfZPx0z+x+JiAEqqx3VMRRHB/34VC+U4t7THbD+IuOZdT3BF7BH2cgdQria694Jj7B3UPd6Txod0WlRMqZwf2A8FfvZEf7RDR7Mlj1JQLLl5hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI2PR04MB10931.eurprd04.prod.outlook.com (2603:10a6:800:271::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Mon, 3 Nov
 2025 12:13:05 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 12:13:05 +0000
Message-ID: <77d2b661-3416-41ae-9f73-68977a26aa30@cherry.de>
Date: Mon, 3 Nov 2025 13:13:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] tools: binman: mkimage: add support for passing the
 engine
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Aristo Chen <jj251510319013@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-2-c13c1b5dac43@cherry.de>
 <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTgKWU7mnFdXAOX7rH8jcGs3QrEVy=49om49=FbdNj1q=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI2PR04MB10931:EE_
X-MS-Office365-Filtering-Correlation-Id: 19eb54cf-035a-458d-f3e9-08de1ad257e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0ptTVJYMXphVklKVi9GNDNPbGtpK3pKdTg2Q1QxczZSSDlTeEZNWWJ5dUNT?=
 =?utf-8?B?cStQYjJLTDVTejRLbFJiKzN0bEVVZWZ1Mkx6blVjVWZ1cjExRUdpbTdPNFlm?=
 =?utf-8?B?VlMyNno2c2ljK3ZPeTJRdDlZdXN6QVFKMjE5dWx3c2JZbFE4enlxTWtvRkk2?=
 =?utf-8?B?Ym5kcThjc1ZDV3gyME9pcG5HdUhFRkpMTW4zTVJsNmdHOXVxQWtMMWJWSWVJ?=
 =?utf-8?B?cVk3QWo0eGRSb29zQS9XQTI0WlVtVTB2cnZUSmM2RzJqRWtxa043VFFXMHVN?=
 =?utf-8?B?SEdlSmVTY25hYlNyQm05N3hpdmEwKzBGTGV2L0o2djFkZ2ZJbmNvdjNscGhY?=
 =?utf-8?B?VzZpeFhuRnpZWVNRWjRXczJKdVRsdXRpbHVzanJ6VnBTcUdSVTUzamVVdkRU?=
 =?utf-8?B?dmRjNndkMWxLc2FFNENSa1V1d0xRcXJZUTQ1enBKMVg3QVNYd1RZZXAzRkR5?=
 =?utf-8?B?QmowMUJtL0NXRWsvUnhzdUFkajdjZG8zd1FTN1oxcTlndVZTbStvVHM4N1hI?=
 =?utf-8?B?eVRpeXFob3NoZXFnUkxUTDVXeVVwOXNWT2ZKYklUcDFUL1pzOWNSeUpPREZn?=
 =?utf-8?B?OUkvYnlVa3QyaUZMMlhLUnkvM0JMdjFUc2Zoenl5N0tVTmNjc09mTVZEcWRS?=
 =?utf-8?B?YUhNUElET0Z5MzZ5MnI1eFhSMmtZc0RNTzUwejRXNVlPNjdJRGxQaUZYbVRP?=
 =?utf-8?B?WDQ1Y1FkWkhtR2hiY0NVVUd4djZrTUhmN1pqVHI0c3VjVGQxRW8zT3RneXhN?=
 =?utf-8?B?YzhqUFJiUDEwbHlCV3JtZHB0c2s1NVhETVN6ZmhrV0VQUThXcmtBcE0ybVBE?=
 =?utf-8?B?UWRjYXUyMjZFS0krWjVWT1QrZGRFL2FEQVlmZTdQY0F1NEdZVWsyWlNWK2ZX?=
 =?utf-8?B?L2dmYytqRW96Z1JnRGVIaXUrSkFNUEordGRUc3NqMk5FMDgrcnpzeXU2NlJH?=
 =?utf-8?B?c0wvOFZ3VzVSYnFGVG1BajBab0JRYStIczFTeTEvaUZJckJjQjZHK2VJcFgr?=
 =?utf-8?B?cUViQVhxNUovd0lMS3FDZmc1UDRVdkNBTjZXMnZGNEJjcVRyejhHMDdSYUVu?=
 =?utf-8?B?dHpEMGROblc1cURKOUc2d3BIWmliMndvMm8xeG1rYWRLTk84dko1dzN5RGhr?=
 =?utf-8?B?eExuS1lkS3VGcFNQcEtua21FcEVHbklYQytxb3Y4WnMyUXdHZzU5NWd1UldE?=
 =?utf-8?B?ekMvcm56bXpwcDc2b0h6eG5Zc1oyTVFTNGtQK3NEckJleE9UazNyU1l3bEVE?=
 =?utf-8?B?V3RQMGdnT3RzdHpNWHRVQ0dHMTBnVE1nQXZlT3llZCtkNkJFYlhVUDl6bjVG?=
 =?utf-8?B?WGU0S3VHYlVqR1VYT1c1NWdhOXNmUFhWSHRJdVA0RkNrU3k3YUl3NFljN3Jv?=
 =?utf-8?B?WlFpb0VzdzZjUzl5aGtHeFF4eUJDdDZDcm5VamRKNGVKOThFTHMrcnVHSC8z?=
 =?utf-8?B?UTRuc2dwUjdETlRwVWJCL3FHOXVuc3FyS3dNVHhkcXp4UXcwdkpQSTAvME1y?=
 =?utf-8?B?eGVheWNOV3FpUGg2UG52SnpqTDRidVo5NllXOWdES0poQU5obHdxUlova1U0?=
 =?utf-8?B?K1RwRnJ2eHI2WjRSbm0yb3F5R1ZSejM5YzBLT1dhd3BuL0oyK0o3YzRXOTJa?=
 =?utf-8?B?cDZORHVVVGFZenNQM08xMWkzYk9USXROY0xYQlpkT3VWc2RQMTFTc2xrbmUx?=
 =?utf-8?B?VDRsS1B3eFh1L0RvTTlFUCtoTy9aN1Q4cGREcm9PUXROOWJOWkt0UjZVbEpE?=
 =?utf-8?B?UzVvVC90Wm11Q0c1bVBDK1EwQyszN1g4NndsYVhoM0FHWWd0N1R2aGQyR0Js?=
 =?utf-8?B?ejBvWm5yUG1VcXhLNXdyR3Rsbno3eCtpbDBvVHJjTDJnQkVjYklsbHN1UVdh?=
 =?utf-8?B?aXZERmFKL1l3dWQvcXprQy9OaEV0dkhyaUtEOG9vdGd1SUZZdkw1ZlpWdEdl?=
 =?utf-8?B?L1NEMDQ3YVF3UzRLMU5rU0YxSlE2a2hMUUNFeExKREljUEYyR0xLamMxdmNI?=
 =?utf-8?B?ZlJoeWYwN1V3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVM2dlUrSzdNWGJUOXdCYzVSNzd6TDNmcWZveXR0S1M2ZnNjb3Boa2RXMnk4?=
 =?utf-8?B?SHFZYUhNUUl5OFBvdmVsbFJiOUdHNWZxTTdlZ0E3dHVuTGs2eWxCT0FZMC84?=
 =?utf-8?B?K3E1SU9IZDF1TUFhamd5ZGtLendHajZTZCtBN29KOElYditYSXhxaVVOMjBJ?=
 =?utf-8?B?U3M0My9oN2cwR09QcVhDb3VyTkYzVVE4RllpbXJtVUo1L01nSHMrZlRGbGFh?=
 =?utf-8?B?RFdpcTlRUkIzQjZoZXlsQ0ttdTVlZ1UwYXJ5cVVITktUNitlVXhLdytXalNk?=
 =?utf-8?B?eG9wdjdJRVRNQUZmWVg5ZE84K1JmRno3NEh6bm9LWXI3cHFQaHZSYlJZMm5J?=
 =?utf-8?B?aUNPTkNCV2ZQQ0s3UXR0eFhmMGpmRFBsWGFMazNVaUpFelNuQXJhVVdnaXl2?=
 =?utf-8?B?UjBuTFRwOGN1bjZzcjZDWExUelg3dDFYaEdlNWpBSWtKZjFWWWx2RDdhNlR2?=
 =?utf-8?B?VUYxWFp3NDVUUmF1MEMrTjAxU2hmRUtJUXJkRkhyNUloNHdQYTlRVkNCZ2Uy?=
 =?utf-8?B?SGJzeVpHV3Bic2dXYVdKMkF0YjluR1ZydEpDY05ZOU9Zcy81NjdyNVFncnYx?=
 =?utf-8?B?R2p3aWZIRGlDbXVnYkhYdElsOVBhOFRRT2F6YmRDYlBNZ3FlWUVDK0RVS1d1?=
 =?utf-8?B?QlEwdmVPcDRmUklESzdXL2pkdlVkbG1XU2JmcmNnbEpBT0pQTnNKVlpuN25B?=
 =?utf-8?B?ZVdkZWtVakdjSmtDaS94bS9MZndISVB0SzlhRXVXS2VTdndyWEEvNDJtcW1Y?=
 =?utf-8?B?WW9aNVNvZVh5L3llVWo1YURVSThnOWdFWmM3THZnWEhhYy9ZRFFRTjlYdlpk?=
 =?utf-8?B?SVRrSzc2TGdPdmxqcHpBaExMaE5JNVpBK0h0WExlSzRMM2lsZ0QyanJHbkdn?=
 =?utf-8?B?MDB6SjBlTlZqNElodlZpZjB2TjliWjBZdFRmbVdsNXZIRmNlZUdVWWpQdDJU?=
 =?utf-8?B?cXlVSk9keUNLTGp4RVpRZEdkTS9nQzN5ejNUZXVHaGcxS05pQUFYc3h0MzJG?=
 =?utf-8?B?cTRCZmUyZ2Vid1U4blFVZ0h1cDl3bDNaNDN3TFplQXE2SzlENjhBUi9hWDh1?=
 =?utf-8?B?NE96TG9Jbm9DOE02aitqMTdhbGE4dXRvR2U3a2tTMVZiTWI1UXp2ZFBINWtJ?=
 =?utf-8?B?Wm50MnMyTWY3NnhvaEQ3K3hvdittZlZ5L2lzdDJTd25wUmsvbG1ZSnBrQWZ0?=
 =?utf-8?B?VkNTY0Naa05JNnI1TXpubVpsRGpubFRBOEVEdlJ4RDlzV2RNMFdzOU9PeFlw?=
 =?utf-8?B?MGROUFcrMGRyc1pTNHNoZlh3bC9BSSs0LzhnVHB2YWN0STBPQ0M2UVNlM01s?=
 =?utf-8?B?QzJXT0srclg2VThuU2Ftb0dxNFFZMDlmdXFYbVpQSnlXQitZclFMdVdIMm5a?=
 =?utf-8?B?SHdLMmtObFJmUXc3TjZoRGtERzZEVFovUlF0Ni85L1V5S2lrOHNhOVB3ckhK?=
 =?utf-8?B?Qk02TWE0czFuY2s0Z2dzUUREb3pEcDRKanlTOEZuMThtaWlYS3RlakkvMUQ0?=
 =?utf-8?B?by9nbS96Zi9yeDlpczBMdWgwMThCZGVWSkpzZmFFNmd2Z2dzN3N1elc2b1Jz?=
 =?utf-8?B?aW9vd0tOQmlka1JYZm5LbldIVjByTDRSS09xY0hUZDlSR0pLQURydFZWM3N6?=
 =?utf-8?B?K2JhRVpaRlphandQaUp6Q3kwRFNSdk5lTXIyeUFIa0lGUXNMTFEzUFRUKzlj?=
 =?utf-8?B?bThyOVZlb25kK0gvS3A0U0ZUdzZLREJCS0JGeVlXQVRoYUwvdXBZV1FKaG9K?=
 =?utf-8?B?enlNcWlMSU5qS2pIQ2xkMmFTdXpKdXV3eE4xVjJVM3RMUnlKaVpCVXhNb0NT?=
 =?utf-8?B?bW1oMjQ3T2I1QUs0TDBRN1EyemF1S2hMMjFRaS9GS21MMXJsMEJtZ0ErSnBp?=
 =?utf-8?B?dU51cjhuTVhGQlIveXVvdlU0R2J3aE85OEszWlo0UkRGcVJ2K1ZuY2owNzdt?=
 =?utf-8?B?SlRGUVhhRjBuWXNzcDA1dFdyaWVxY3BRNEZiRW1MdURjeHY2NFE4MVJoNVdD?=
 =?utf-8?B?clNlWndnVi9MU00zYml1WW1WRzQ5cUQzM2lwT0kyWjlTTUcvL2tOSUd4L2lM?=
 =?utf-8?B?Y0FzZlNYTXUyWkNZVjM3dG9zc2lHSHZVL0NFTjBiaGEwUWRVcHlDUStKSExB?=
 =?utf-8?B?aWRpWk1ZcFJrSXpHeEpra1lJYW85eWNmMzRtYTZuT1AvdkdscW41MUFFZEtN?=
 =?utf-8?B?VXc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 19eb54cf-035a-458d-f3e9-08de1ad257e8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:13:05.6208 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3pa1we0HxVeGonpVgr0z7ul4epI/LaT1HgPWv5IkJd4rdbIfvd8KTqa0YVxWQaFmRO90uZuxnPZPDhBChvql9lbCF5Fqe5EuJ8e+osR0YYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10931
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

Hi Simon,

On 11/2/25 8:53 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Fri, 31 Oct 2025 at 16:23, Quentin Schulz <foss+uboot@0leil.net> wrote:
>>
>> From: Quentin Schulz <quentin.schulz@cherry.de>
>>
>> mkimage has support for OpenSSL engines but binman currently doesn't for
>> direct callers of mkimage (e.g. the fit etype). This prepares for adding
>> support for OpenSSL engines for signing elements of a FIT image, which
>> will done in the next commit.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>>   tools/binman/btool/mkimage.py | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> Please make sure this is tested.
> 

That was the anticipated and feared answer. I'll need to figure out how 
to create a dummy OpenSSL engine which doesn't require any hardware so 
it can be part of the CI. I have no experience with OpenSSL, so this 
will take a while.

Just to be sure I'm not sinking time into things U-Boot has no interest 
in, would supporting OpenSSL engines for signing be mergeable? OpenSSL 
has deprecated engines with their 3.0 release in favor of providers (see 
a recent series on the U-Boot ML for their support in U-Boot and 
https://github.com/openssl/openssl/blob/master/README-ENGINES.md for the 
official stance of OpenSSL on this). Porting my employer's engine to 
provider isn't planned (yet?) but I would like to know if U-Boot has no 
interest supporting that use-case, in which case I will "happily" keep 
this downstream only.

Thanks!
Quentin
