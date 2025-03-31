Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B21C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 10:31:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442988144A;
	Mon, 31 Mar 2025 12:31:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="b3d3iCtj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 805CA81703; Mon, 31 Mar 2025 12:31:46 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54AEF8006D
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 12:31:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pm52RzZVqe8twJARAWWNPQMQndvPquYBBWUE+KIm44/DDrgd/eb56BbtUvRSahiL1uvqtDpmDMV49Pe6GaMQIDDUIV0Sr8RDdyZdsmMJ1NrmBsf+R6/xVONadnZza9ZNEMZhw6pJ1drjwgIpG1US8Pfly/uXsRgZkJ/7NfJn1VXH6BDjNqDJdfmXwY7dRTh91s2vLGh78RaxUkcl4hQUp4M3MMICVUZduCTjq8X4imSQrYFvzy9w0bUCldPSgd7Gs3cnlqhfW2QW3GalFY+J3RSW0Red0HG1jS7oXRkOyHI38A06ojz55c01oc/ncPFLzLgeodT+34RwGOTHy84ZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Z5xqHja6xwkoVLIXWnW6QAlWI6FM1JkXCOjtV7NCjw=;
 b=hWSpGne27cN/14mW+dGRkwof3TzoXxYE4cf0dnqXJBoi39s9dxkbkodJSFMhfawbS7kVYgqBFYd6DcSQBpTFV3FUyc5sUffkUkmu6YcBP/0ObbXVjQSkTI9Vr4aet+Jj+csSnYnzhAMTushbv8KfgA6gNtInL6siWHynkXK6hgGtk54dpbK6IdpElfrotB4kpKcbcDpGkZxSqynMLT4hK33DDPivxicQs3O7n0xrSQ/vVtKxoAOHxCxSK3UGVcRKQ0paSFaaml5L2d4YoCSzZbbXrHoM3u24+DRb/8lNGcXNgWc00a+GQTtPR2lb9VRkKnajCxwTygHBa5qMt7x6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Z5xqHja6xwkoVLIXWnW6QAlWI6FM1JkXCOjtV7NCjw=;
 b=b3d3iCtjmLN9RaoDy5ZO7HUf03XPz3ujlR34pXW5w+UxFsGe4a6kWRSogaJRQazeUnghyHlM3u7414uQoF7bV8h2J1e6Raf9zMZ73eREYonWXopj344pcKyHrlRsm009iyeAS8FWmns0IdTTF6Y12/TQ3EcpJmeVwtfx/R0Wdc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB9326.eurprd04.prod.outlook.com (2603:10a6:102:2b8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Mon, 31 Mar
 2025 10:31:42 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8534.052; Mon, 31 Mar 2025
 10:31:42 +0000
Message-ID: <ea8870ec-69de-43d7-a1cc-e8a437b90a98@cherry.de>
Date: Mon, 31 Mar 2025 12:31:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] sysreset: add PHASE_ to GPIO reset and poweroff
 configs
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Caleb Connolly
 <caleb.connolly@linaro.org>, Kongyang Liu <seashell11234455@gmail.com>,
 Simon Glass <sjg@chromium.org>, Robert Marko <robert.marko@sartura.hr>,
 u-boot@lists.denx.de
References: <20250330092815.10350-1-clamor95@gmail.com>
 <20250330092815.10350-2-clamor95@gmail.com>
 <aac2609c-c079-44a9-92ba-8517af78350e@cherry.de>
 <CAPVz0n0jo6MjYi7Bvj2RFxCJHdemrbUUbjzJfPXcKqfD6nCQgA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAPVz0n0jo6MjYi7Bvj2RFxCJHdemrbUUbjzJfPXcKqfD6nCQgA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ab1b0dc-fdb6-4c8f-d4c6-08dd703f3a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXo3MERPZm1iaSt3bUlTT2I1VDZrZGpUS3E0a0dJNUVKSHpUOXBhSDdCbmp3?=
 =?utf-8?B?UXlqNkdaQnV5ZlRMVVhJV1dvQ3B2NjJxT1M3bjlUTGlNaGlWaVBoN09wVFc2?=
 =?utf-8?B?MjF2dkxGbkpmcFZMN0hHdkVMYkNwTDJSZS9rMGs0UGpWWlBtUXFFVDVLaUVB?=
 =?utf-8?B?alB6YUVpUUhtSFBEL2w2Q0xDcmVIT3p6ZGY3NVJiWDcyL3Npd1kxdXhSM2xq?=
 =?utf-8?B?SHZXTlJ2UUdhODV4aVFFS2Z3VFlibDJxSTBXbUxEa1h1eUFaakxGV3ZORUs5?=
 =?utf-8?B?TmVjVFJJWHRFcGgwRVdyOEsyWStGeHpYTDRGdlQvZUh6VUNYN05TYzlmQWxI?=
 =?utf-8?B?YjZFNGFHQVk1NFVwdUgrKzBibUN6UWtvZEozTmpPVUdrYnducWRmUHp2YThp?=
 =?utf-8?B?ZnRwdnhyaXRlWFZRbmw1OXFBNkdsRlB5QzhkSU5scGJUcDYweUp0WnlzMlBQ?=
 =?utf-8?B?TFREVW1DVlRMRDlocm1jOENMT3dxNWNucjVHRUo5bVM4dTdYZDRzSG0wdzc3?=
 =?utf-8?B?YURJd3RRUHNPNnpWVm5HaGM3Zm45U2lrRmRKUEptT3pGaEdZdFJrdmc2Sjgv?=
 =?utf-8?B?YmZBOG93TmFobXdOdVhsZi8rLzZsZ0hjV1Y0Z09XNSt3WE9vc1d2NFI2NW84?=
 =?utf-8?B?ZDRSZnJDalFwbVpscnpOZHNGalhnUWtUTXVLaVIwaVd1Q1ZDeXRpdHI2ampO?=
 =?utf-8?B?RzhPeXpZZGJJK3pwY2t2Zk1tRUlsNmtvVG5HVUZLVEEvTEtlWWNDWmhONHlP?=
 =?utf-8?B?UmloQzZDRWVYZ25Jc0NKK3JEU0xZMHJ6aHVjckprZlM2Q0NKQzg1Z0JBRkpM?=
 =?utf-8?B?eWJjWUwwcnMwMU93OGNvcXlXYkI2VXZvdHE1VFYrMm9JWk5jcHRPbTIzblND?=
 =?utf-8?B?ZnJPZ2dyVjYrVVdPRnZVZmNGK1orVitoZ1JsQXNtczRTZFR3djV3Mi9SY1cx?=
 =?utf-8?B?WWJiUHVxbUdkb0kzQ1B5MCtER3Q2RGlPeGhMVkwxaTN4dWRVSjkwTml1eDdJ?=
 =?utf-8?B?QkpqRG4vYWdwMmQzU1lnSGhEeHQ5WnFQYXFFM2pIYm9NQVdianlobFVWTFVP?=
 =?utf-8?B?YjdOeXRyTWpFOUlQWndtOXdCTFhkdHlRUnhENzN4NkpIM1IzZ0V6M2FURW90?=
 =?utf-8?B?RkM3OUgrTzZIRTdiVitnM3ZCSlBGU25ncE00aE0xUktGNmtad2R4OVZoKytP?=
 =?utf-8?B?R2J4UmhFS3FNS2JzWWJMcGd2UUpCYUs3MTBVcmtVb2pEcm12U1c5Y2YzekhV?=
 =?utf-8?B?Z2hSTDJzK1Z6Nm1RQjFzOTF4S1M1UlRrMExxQ3pVcEYvYzlielMrWTdsWk40?=
 =?utf-8?B?bUNseDNTT3g0MHo2YUx0bElDc044bE9jOHJLdlpkOE02RW00WDNkbi96TlpM?=
 =?utf-8?B?RmlIWmI3cVFJTDlqRXVaQVRRZzVXY0NTZ1NXcFpHUmlUUlFrT2JKQ0psaUY2?=
 =?utf-8?B?UldORCs1eUJXNmFWTUxjajhhSXNnczJUZm9MY2t0dnArek9PLzlmUDJyekxM?=
 =?utf-8?B?d3ltMm5NRVppNmY4bUZGQUh2LzFCTmZQNXNwWFB5U1cyUFVXUWgwWDREUVF3?=
 =?utf-8?B?WXhpZ0JacXJrR1gvVWpsWjNESG9FWi9IUGxlRTQyM1pER05ET3BENlVNOWVy?=
 =?utf-8?B?VjNiSFV0UzN3RjJBSXljMjV1VW5VTElab0VnOC85YWdHc0FDRm83UndSRW50?=
 =?utf-8?B?L2pJckFHaXB0SDI1bTJwS0hjYTBRQmpoWEF1K3N4K0xzd0tOMDh0MEZZSG5j?=
 =?utf-8?B?bkVTOExvckNQbjdqd2tEbmhyd2RBeTExS2pVUEpEQU4wZS8yQ040QkVYY000?=
 =?utf-8?B?OEFsZHhDb3BSS0lpYXpnYWpMMDBnellrQzVCOW81cmM4Z2FqWWQ0NTRuMDJa?=
 =?utf-8?Q?8UM/q7+uyMDAC?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGZwdlg2N2IzU1BXdVZDWmZKbUxsQkh1dS93UndxU1VFYkpNdlR5dEZTbzRS?=
 =?utf-8?B?UXdNZ2wyekZkZW5jRTlxWXk4VEdhN1ljVjQ3cjhMcURiWHlXdkV1aHVoeXoz?=
 =?utf-8?B?a08yeDBxbXBsL2luV005a01oWWZWcjZULzl3aEljU1BPS1NKRWFGZTFGcGw0?=
 =?utf-8?B?M1NET2lCRG1YbXF2clFkUE9GenhYWG94ZkJGQnpCK00xRElGbWN3b1AyRFFK?=
 =?utf-8?B?Tkt5dEVJMTVPUytvUTVWdWRndGlUeFhaSTBNbzI2NkZ3dUN1SUhIZEZ0emdK?=
 =?utf-8?B?bjk3a0xHdnRWWWxFbU5sbFAvdS96UWxOc3RVd2RVOS81aUFTbTZUQzl6Z0tm?=
 =?utf-8?B?WElHdHlRRDFRVkhzQVZ0VERrSXZ0djNMMU1DZWVQZTNPZENtYnEvVzB3NzBH?=
 =?utf-8?B?QklaMGRpb2hHbFJwcjYyZVZucHpGRStvc3hUdnp5dHRkVXpCeTh3a1pGZGY4?=
 =?utf-8?B?K01mRWtZdk93TUR2U2k5Zm5RN1pIbFhWdHM2bzl3TFFTS0dkOE5ZZk0yYUJ0?=
 =?utf-8?B?VUZ1b2Z2Z0cxd1plZnpLUDBlVXdKMGJnQThkeEpHSjAzRkhyV0xIQVNCSXA3?=
 =?utf-8?B?ak4xd00xSi9oNVZZbFBiQ28rTG5QdEdPQVJPZ2N1dzRIaFRrQlN2bFFMbmJ0?=
 =?utf-8?B?cUt5RjNoV05jbjgzQlYwVmpPckZ0aFNJMXl6L2IyQWhMdW8yWGc1NjdzTk5R?=
 =?utf-8?B?Z1NkUG15UmVzSzZRQWlVYk9mcU1rcUk4OFhWeVJndnpWV1J6ZmZnamdOQUli?=
 =?utf-8?B?SjVCSktIUHY1UUlOZ1Z0RVU2TmRiaVhxSFJDc3BZLzRGQ3Q3UDlydENiV1l4?=
 =?utf-8?B?K2x5Slpzb1ZLRHlqeTU4QVJGa0ptTERWcEpzNXM0K2ZXZXdtd3ZCZklmTlVZ?=
 =?utf-8?B?Z0lHbkhOSCsrTjRjdzJqKzVvUFFOYWhwUVBWSi9aK2ZPUkVZeUZWNXBXVWZy?=
 =?utf-8?B?dk12NlZhMXVIcWJ6SVFHRWJXUDJkTk9laGxrSXRlT0dKVWYvU0xQdmxlZzAw?=
 =?utf-8?B?bTZIZE9GV3l2RDVpb1I1dTM4UlNIaHdTUGdEZjhHVVBQMnU4NUY4TzZnaFJV?=
 =?utf-8?B?Q2hYQ3Y3ZUhsaitzL1l4cnhmZmJBMmYxTDV2RTYrWTZGWnFpcURaVXdvU0hm?=
 =?utf-8?B?SXBsSUxUN3Jka0ZiaEc5dHgrb3MyZ0hwb1ZBNGY1WE9oZGU4cmdweW43Znls?=
 =?utf-8?B?U2d6Vm9URmRtbTJJZUxiMjFOQU9ZQ2lidnpKenJqYXQ5Y3JqYzhGaHJFM3Bu?=
 =?utf-8?B?M05ZY3VrS0JCdFc0bnFSb3FDbVcvZWo5dndWaEpvV0RmNit1dm1mUWhkamx2?=
 =?utf-8?B?d29mM21NQlNLV2E0NGNDeHllb2l1V0s2ODQyQ21pVFBYY21la1daV2FQVUQ0?=
 =?utf-8?B?eERKbGlaZGpVR0pLZXJZcUFmTlF2U09pSGRURUJhSHhoeklYOEdRN3l2a1BG?=
 =?utf-8?B?K3RIRlI5bU40bEd3NDB2V2xRZTgrRVU3NFpJblh6Yit5UmlWQm55S3c5MUsr?=
 =?utf-8?B?Zk9NMkkvVnRSU05UaGJScUlvaGdQcXpnbjllUGdjOUdWdDRMQ09VOVFvSlB1?=
 =?utf-8?B?dDVsUGppaHNMZ3drWVJnc2JyYmJmWmhUa1Z2S2t1Z2FqTy9wMEt4TGZUVmRP?=
 =?utf-8?B?VXFVdHpCRXYvLy92NGRCanpiMElOTVlrMit4RmUrZi9WUmllWkZIeS82UEQ1?=
 =?utf-8?B?ajRYZ3ZVbzY3eDluL1IxVXJtK3E5YXd5SW4yM29meC9RRmhmMzB1dXJNRmFX?=
 =?utf-8?B?QUNqWWxBeWtvZE9vRnVxSy9aZ2xDUzlCMC9zRUw4QXNWSnZxRFFpbFZTT3gv?=
 =?utf-8?B?MTRoZFZjU085YXZMOVBzUDhyTi9xbFNRQk9tR1BTNXJra2hTazJDTnREa25n?=
 =?utf-8?B?aUIvbW8zTmY0TTllS3NGZFVadlZEbm1mNXl4T1IrSTNYN3pvR3BtbzFNcVdP?=
 =?utf-8?B?VnpzUFBiOGdlVHFpOTExTmJoNXhvSVpzcmhkZHExRTBSekJ3ZTBGN1I1Wk51?=
 =?utf-8?B?Q0QyYjk1ZXUwNDlCcys1WGJTSDUvb3B6RFhkcU8zL1MzOUZRNlJCWXQvZDhp?=
 =?utf-8?B?Z3FzaEx6dEhkbTFIWFo0eHZnQmE2NkhnMndwc2tsMjlJbUFRUjkvMzFwcmR2?=
 =?utf-8?B?M1k3Q05pZjdUSHpObG5ka1hTTEdJYlczNDg4aTdJdCt6RGFnWWlMQStuK0Vn?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab1b0dc-fdb6-4c8f-d4c6-08dd703f3a46
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:31:42.1141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HdJTn5VcLDJThv9nP/4GfJWH50FyqtrVsWguhaAeh+Ps6zBVtzXPztS9aAGuQ111VU7cdKuhVrxV91uYMHbzu83qNXsIlJ0b+qxCPmtn1eY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9326
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

On 3/31/25 12:27 PM, Svyatoslav Ryhel wrote:
> пн, 31 бер. 2025 р. о 13:16 Quentin Schulz <quentin.schulz@cherry.de> пише:
>>
>> Hi Svyatoslav,
>>
>> On 3/30/25 11:28 AM, Svyatoslav Ryhel wrote:
>>> GPIO reset and power-off functionality depends on device tree data, which
>>> is often absent in SPL or TPL. To address this, incorporate PHASE_ into the
>>> config option.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>    drivers/sysreset/Makefile | 4 ++--
>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/sysreset/Makefile b/drivers/sysreset/Makefile
>>> index 796fc9effa5..ded91a4d325 100644
>>> --- a/drivers/sysreset/Makefile
>>> +++ b/drivers/sysreset/Makefile
>>> @@ -8,8 +8,8 @@ obj-$(CONFIG_ARCH_ROCKCHIP) += sysreset_rockchip.o
>>>    obj-$(CONFIG_ARCH_STI) += sysreset_sti.o
>>>    obj-$(CONFIG_SANDBOX) += sysreset_sandbox.o
>>>    obj-$(CONFIG_SYSRESET_CV1800B) += sysreset_cv1800b.o
>>> -obj-$(CONFIG_POWEROFF_GPIO) += poweroff_gpio.o
>>> -obj-$(CONFIG_SYSRESET_GPIO) += sysreset_gpio.o
>>> +obj-$(CONFIG_$(PHASE_)POWEROFF_GPIO) += poweroff_gpio.o
>>> +obj-$(CONFIG_$(PHASE_)SYSRESET_GPIO) += sysreset_gpio.o
>>
>> Are you sure this is safe for all boards?
>>
>> Essentially, right now POWEROFF_GPIO/SYSRESET_GPIO would be built for
>> devices with TPL/SPL_SYSRESET symbol enabled, but with this change it
>> would be disabled, possibly breaking their setup.
>>
>> I'm not against this change, it's just that there may be additional
>> changes made to defconfigs to transition to this new symbol...
>>
>> ... which you haven't added here. I don't know what's the policy, but I
>> think it makes sense to add the VPL/TPL/SPL symbols here so that people
> 
> You mean config SPL_POWEROFF_GPIO and SPL_SYSRESET_GPIO? It seems a
> good idea, I wonder if there is a simpler way to add this without
> adding Kconfig entry for every boot stage. Maybe you know such
> example?
> 

We don't have such a mechanism, each symbol needs to be "duplicated" 
right now.

The thing is, we cannot really automate it (globally at the very least) 
as some symbols have different dependencies (and possibly different 
default values, etc...) depending on which PHASE they apply. 
Additionally, some symbols are for all PHASEs, not only proper. Maybe 
there's some magic we can have in Kconfig for that, but we would need to 
create a plugin for it.

I think this may have been raised in the "xPL proposal" thread on the ML.

Cheers,
Quentin
