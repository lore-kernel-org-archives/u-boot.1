Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6719DCF34A1
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:46:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2C6783DA6;
	Wed, 19 Nov 2025 14:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="I+efnUP3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF3883DBF; Wed, 19 Nov 2025 14:46:05 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6216583952
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:46:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pTgYkClm3JAoebqJ+L8vnquQ91ZA5pe7ts1NvrtuwT+WFWLy3SJy3ma1m0MzrVgn70jaysMLIMwUCXO4jJhl9EbykOkEhNZGptKVEd1TcT6QqUjEmXi33v6vQmIiV4MNSLdawwK2uiD+QzJQaUGevKn6qhfdp5FauOqMHY9ltUwZSEGTj6lsCdsY2n4hCMCQ2ZWSRhCkRqT1qlwDEUcPb0fJoC/7STH6hUUEC3eUQohjfXneQ9KX/2ERCbhDrU7J6iUMToWnnJD95C+GQY5L5FCE2uMKyVGavmdtapHfy7+1r0ETTf7reeReSztBUwIAHACdazrlYNnOmLDj37Rtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AeRYLEqlhdqAghA9oO4+Lk7jVQwpv0HZhGpfQli7LMc=;
 b=NkZ8K7jwklcMfNbfsEOkNhLwJVUbQNhv9NhPlQm9OJDQrsgHbqNiNamnnJCRgteZx/UhcuvAg1Tp9FREzHbjhHO/WHhtQqJP/tIOiT8B6ab7mx6q0H6vOO3htkYcEI89Tn6jc13R5NEFMu0YMe6Pequ53aki2PhKZWmA937XrYg+AT07ajyD0SKEgtWppM0hbyk+OmNxZM9ffknFsxeywrM2yXzcNmJWVWTVzTJ1kzaif72EWFjX11Wk6PISkG1z4kR/Uw13kpt7TZQpdfjiGX0rb6eGDkd1CIZ9RAQNKjnB4dfS4mh0xrTEsNb4aL/Vl7ixFiDvC0WHfu3uTHl9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AeRYLEqlhdqAghA9oO4+Lk7jVQwpv0HZhGpfQli7LMc=;
 b=I+efnUP3LTvIc4DUVQC4WAnn+osqf1nSuKB10yDvJ2OzNZJt+XvAURq2szNGmJI3DPwl+QTY0K7Ii+K3XxugODU2i0IFH81nw/EdrFOmsgIzR225agOfDer0yzuPigfwEYwBTPTRKHUdf1e3l2j8VzVViKMJavKrnpYxd4cBxdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AS8PR04MB9143.eurprd04.prod.outlook.com (2603:10a6:20b:44a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 13:46:00 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 13:45:59 +0000
Message-ID: <0b433974-8557-499c-9d48-c4ad2df9c9d5@cherry.de>
Date: Wed, 19 Nov 2025 14:45:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tools: binman: mkimage: add support for passing
 the engine
To: Simon Glass <sjg@chromium.org>, Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>,
 Peter Robinson <pbrobinson@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>,
 Kever Yang <kever.yang@rock-chips.com>, Yannic Moog <y.moog@phytec.de>
References: <20251117-binman-engine-v2-0-e053f683c0b8@cherry.de>
 <20251117-binman-engine-v2-2-e053f683c0b8@cherry.de>
 <CAFLszThkqMi5jxWArGrqSfnMnX5P-RbHW5Xc8_GEMGjmPhyiVw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThkqMi5jxWArGrqSfnMnX5P-RbHW5Xc8_GEMGjmPhyiVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AS8PR04MB9143:EE_
X-MS-Office365-Filtering-Correlation-Id: 89fa25f3-1b7a-4937-4afe-08de2771f909
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGV6VkoyKzRRemJVTFJQL2ttRXE1ZWExQlZSOHI0bzdLdFB0Um01Z28rNmp1?=
 =?utf-8?B?VmF6MjBkdFhGMVd5MWtaeE5Xdi9DNkdOZVdMeDRtSXZpYjB3bzlSQktmdjVm?=
 =?utf-8?B?eXZaWERyUElWdVlVcFozTWxjMFRIemN1aUl5T2JEbUQwSTRZUHJDMFFSbEtT?=
 =?utf-8?B?OVNpZDJBSkdBVk9UNHlDaEErdW10TkFPQ1BGVFo3U0swbVJmaW5mUEVadjZP?=
 =?utf-8?B?MXRlVkVHUVpUc2t2MmpKZG52aGlaWEdYQmlZOEozcnd1a1JvZEpjT1Z4a0ZI?=
 =?utf-8?B?Yk9aZjcrQWQ0dW1xanczcjRRTUJTaVl6WmVGYk9kUEVLWjI4WHJFbXlwRGdI?=
 =?utf-8?B?TEJPbzN4d3l6QWlsenYxTlhXOVFIL1RyekQwaEhFT2ljN0I2QVlrbVQ0VlRh?=
 =?utf-8?B?VXVhUkNIK0ZXVUZBM1BlUUx3cWtHMlF4Q1BqRWEyaUNqazVNTTZtaVkzVWZY?=
 =?utf-8?B?dTRoQnA2dnFKVlRiVjYyU2ZwZ0hCLzAxK2VJZTdxcHZmdk1Za2c0c0V5aFZV?=
 =?utf-8?B?MEgwUGZKMjl1c2ZNallWK01HK25wTUw5b1RQMkw1emZFaE9KQmNsODgwazM1?=
 =?utf-8?B?c0F4T1dwandGdUQ4LzJiTVBqVmRrcW1MRUlZUXJobHZJNE53QUVxQWxZdnlQ?=
 =?utf-8?B?bmEzR0xnczZ0Z2xsY0VYMlRjZktKam5Ld21NYmpqU3RJakxyUU52UVlJWEVv?=
 =?utf-8?B?WlAxTXl4OURZa0RraFB0cGtkeFRLTElQcDU3S0hFMnkrd1BxQjFaajlUb0p1?=
 =?utf-8?B?cUJRUTFvT1hhZW5FRk02V0VyNGdaN2sxamR3NWM5ZzR0N3JmZ1c4S2x1VVJx?=
 =?utf-8?B?Q09tM3ZCR2ZrL0VwZHd0UlJQdE05MERFZkVRcGZMSDdUYmwrb2UxMHVlVmVJ?=
 =?utf-8?B?RXUwL08xMm8weW1XSHBSY2hTT1JwZzVsUVpITllaSXlQSVR5REFacEJHY3dK?=
 =?utf-8?B?NlNOQWd3aGY0UjRFVHZ3aE5rTytmVW1qd09DdS9LczhNVEd0N2xGa2gxbmx6?=
 =?utf-8?B?aXZvSlgxRzBXTHk3MjI0WTU2REVwQWluNENDMlV0YVhMaWkxTXZibHd1S3lu?=
 =?utf-8?B?QjdkU0I3bFlvZm93RWV6OXNWbk9rWktCemVkN3pCdTNHVWNLY2ZyN2FiQlQ3?=
 =?utf-8?B?WWNKR3NYNGZLVytTOGEycldESEpMc2FsOHl1bmFpeE1qTHRnbTk0TVVldHIv?=
 =?utf-8?B?VklyaFpocjZtVFdaaVR6T0tJNUZHaTdNMnY2c1lCZ3BsNTFwamMxMmZWdUlX?=
 =?utf-8?B?dWFjVU1VRmVuMWVZVXdmQWV6Ykpqemlqb1BIWGVPbWxWOE4xUlNXYXZOYzc3?=
 =?utf-8?B?WFBQcDZVR0lJRk00R1Iva2haTkY5OENEYTQwUmdodzdaRmpoUEUvNldIYlpI?=
 =?utf-8?B?MkFSaVlsdjA0SWg0VGN4ZXJraWNvY3VvOE1mYWl1TVZadzN1Szhia3ljNlFk?=
 =?utf-8?B?N1ozb0dKd0ttQi81elU0a29qRm9XUkZ4T3NSTDZaVEpmM2oweU5RWkdUUC9i?=
 =?utf-8?B?SElSc2U1bnNtYkEwSXowYXU2SDBray9WNWFKNWs0ZWR2UkZvdk15ZVFsS1Uz?=
 =?utf-8?B?NmhnREFCMHBPcTlyUHQrejBuRk9UQTd3K01VUnlHRi9YTDJpYW52NHFZNFlW?=
 =?utf-8?B?WWFYYWswbm1vcnM5QVdaNTdZVWM3MGdSeXp1cjRpMlplcjlDSlY4dnMzVVpW?=
 =?utf-8?B?Y0JmQ3R0c0phaWRhY1JUV3FZY1YrenRiWHNsSCtaL0szZjFmaE04UmdidDM1?=
 =?utf-8?B?Q0JldFh2ekdKR1RGNUE0RXdYbXovZnVIMXRvWW1aY1lRWEdkN0xYVkhTTmdT?=
 =?utf-8?B?SnlvR1ZiYW5xZE5zOFNWK1FkQWFzZVZyZWtacjVpMUwrc2hucWtKb1IwdjN5?=
 =?utf-8?B?ZUxQS0tNb3lMUmRFS3M4WFZVcE1QK1FRQW51V0xDVnYxdlR2cnE3RWE0dkps?=
 =?utf-8?B?V1ZrdktReGRLYUlpRkZVRG5IRXBvdUJ5OXpjaGpzWHZEZGxLRzZYQ1VpbXlY?=
 =?utf-8?B?ZXhTV3VyeGR3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1pKWHh6cWduYTVvTGpQRE1uVXBkbitRZ1lpeThIWVYwMlo3UUhLWDhBMnVI?=
 =?utf-8?B?SHp0UzV6MlZ3WS9qd1B1MkE4RXNtRnRBRUdGZDdyUW5QTWphWnBRTXROUk4v?=
 =?utf-8?B?cVpqYWxDeW1aOVUrR1pWTUt3RE0yN1UvMmg5ZVJncjFsYWNmN21GUVE4NHlI?=
 =?utf-8?B?VGtJU01sN3YvMmFOMCthcTBUY0MvY0R2c3QyQWI5OXNqbmt2NWZ4VVRvVUps?=
 =?utf-8?B?c3pERkl0bVB2VjF0TThreFpiUU5HMFVobEZsbXJlUmRhbXkyVGdzalowSTNw?=
 =?utf-8?B?dlpkYzlpTFlJbWFPdVhaVXoyMHh1ejl0Z05hVytiVXN1UjFndlJEdXhOMDh3?=
 =?utf-8?B?akdxQ1JXS0tYUmFYSFYrNEVlVnpubFV2d2c0elpaaUVidlp1eko5Q2RvTEdH?=
 =?utf-8?B?bjBFWWdrdzl3UkJOQWY5R2hUR3FuS2J6WGRNM1hTYUN2VGZmOWQ4QU5MQU5O?=
 =?utf-8?B?UmxzM0phRkh4MmN4b2lMVlNoUEhkaWViSEo2aDZJcmJCL2F4NGJZTkZOT2RK?=
 =?utf-8?B?bno1Z3dzaVF6UEg5N0ovbEIzeGJaL2s2VEtmQThUZEJFeGFWS0FFVmxBc3l2?=
 =?utf-8?B?NXRJeUxYQWdBWDVER0cxSnhSZkdVeURuL1U4YVl3anBwS29VTitTV3IyQ1BB?=
 =?utf-8?B?SWRpTkQzZUVqVWkxQk5VMWdQbW9VMmRVdmF0YU02TlVQWFJPKzMrdkJYL3hx?=
 =?utf-8?B?WGZJcmlHU2pYZ1BGYmVFRyt4K0NFVHVCbXhRTzNGd3U1MUh5eG1GNlVSMWwx?=
 =?utf-8?B?ZHZ3enpZdFJPL2w5WXdETzFFL3BaQ0YvVVovdjVhQVd3NDU4cHUvUG5GbDls?=
 =?utf-8?B?Y01HQmxqVERGTENtOVllUy9mMmh1QmFiamMxeHpmaXcwUHYvWWU5WGRLaCsr?=
 =?utf-8?B?VTZvbUQxc3cxc3Rack4wTDdzdS8yM1dJTXBFcmhoUVJrRHA1YjF5cVlnSkRT?=
 =?utf-8?B?aklTUzZtQmlWSXU4TXA1ZE1wekVpeVVMRExBY3E2bmdhbzhMMFRrdE5VT1JW?=
 =?utf-8?B?c1ZGM1NlSGJQdEx0U1pidTFPRUZjdlgrNTdhR2xyOUVxOGVOa0t2QmVzVFdl?=
 =?utf-8?B?MnpQS1B5dDA5aGdVNXUvSWh4dVU0UktQM3A4S2NYb0wrWE01cnNteEt4cWhB?=
 =?utf-8?B?L0liaTZlbzBuUFdFUjgyazBtclRMdGtXYTJqWk83Qkk4L3RHUzA3RmtrTWgv?=
 =?utf-8?B?aFl3SWxYNlh0Q3piSm9PWEl6YUtITDlMY2pUbGYyUnoxbE52K2hKUlNJZHVi?=
 =?utf-8?B?cUM4MFhKUW93UTRldU1VR0FJR3A4ZDZ2d3B1TFRNN29NYmhwRExMV2VOMWJ1?=
 =?utf-8?B?eGRHYUY4OU9BSTBHL1NNZWhKOHB6S3N6THo4WituV0JVRzFTT1FrSTIvYTdF?=
 =?utf-8?B?UU1LSGVZeDF0RHBxRFZ2bjZhRjl2MTdTbXduRVNKYUw0MEl0TlFkd0VWblNq?=
 =?utf-8?B?bjE4OXJpdzdIdG4xbEdoKzBURHQ4V3VFRlRIN0ZNQTlISGhkdERrbytmbmhq?=
 =?utf-8?B?ZXJHVHRqekh2QjlTLzZ6SlFLZHFvK3B0MEh3bng0MlhIWCtFUlM0VkpBTVRs?=
 =?utf-8?B?OEVjSUZZak5mMjFBeGpxRk1ZY244RDdoL1FacjQ2aGVZM24vd0twaGhBTy85?=
 =?utf-8?B?RDAza3ZFZllvQ2NoT3lQVmEvQ2JVVzdzdVhlU0dCL2tUMDA0UHQwcGhwQWtH?=
 =?utf-8?B?L0R2L1dQZHpUV3RlaFBRbThIOWgvYW9EU1JwdHBkN2NiSFdqN3c5S3F4M3pu?=
 =?utf-8?B?cmRRWjI4UUtEend6K3dtankxMGFDOFk5ZDNlUE12VmRCVm1jdzFQQlFZZ25K?=
 =?utf-8?B?TVh3WDJ5bVJGOEVZNElOREZGMDFpSzZKMVgrWkZvUGZJaS9CRlg3WCtDdjh3?=
 =?utf-8?B?Zy91U2dEZFlYRjNTOUJWbHhNYjJoNW1VbFdRS3Q4QnY1WDE1dmEyRXhEQTVG?=
 =?utf-8?B?dkE5ZVFxaUFZWWF6aFRNcXY3Wmp3cVcrN0hTL3ppM0Qwa24yWUdoSzFST1Y0?=
 =?utf-8?B?TWlpYUZ4dGFrbUg4Z3BBVXppSmduODlXbEZtSkFVaXVSTmpKdXVzMlRMUVVN?=
 =?utf-8?B?MHFYMytKZU1YTmpFckhnclordGNWYzRuNjdJd0p0SjY0b0dRNnVYK1RwMEpY?=
 =?utf-8?B?cnd5MVg0THU3aDNiYjM3RFAyK2pZTTd2amQyZzhFUFFvcDFRUnZYc2Q4MXM3?=
 =?utf-8?B?SWc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 89fa25f3-1b7a-4937-4afe-08de2771f909
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 13:45:59.8798 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mM87evd45G9qLe7129q5KIP3bNFdhxMhCA/kTHVKjYFE9lzFUyLVzOrXg6GSqSMaRjnZYGOkIYqLqAPNb5vXWYJ/Sgr2qdQU1pdeawjwuEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9143
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

On 11/19/25 2:16 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Mon, 17 Nov 2025 at 12:43, Quentin Schulz <foss+uboot@0leil.net> wrote:
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
> patchwork seems to be done, so I cannot try the test coverage
> 

b4 shazam 
https://lore.kernel.org/u-boot/20251117-binman-engine-v2-0-e053f683c0b8@cherry.de/

should do the trick to fetch the code easily and run whatever you want 
to run locally.

I only tested 4/4 tests individually (you cannot actually pass multiple 
even if the help text claims the opposite). The pip dependencies aren't 
installable on Fedora 43 (or Debian Trixie AFAICT) because the libgit2 
dependency for building the wheels is too recent compared to what's 
expected. Anyway, building in the same container as the CI and repeating 
the same steps, it seems that my tests are actually breaking other tests 
now when running them all at once, I'll check. I suspect something 
related to the environment variables persisting across tests.

I'll run the coverage test as well, thanks for the reminder, to see what 
I can do, we're most likely missing the check for fit,engine + 
fit,encrypt raised Error.

Cheers,
Quentin
