Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ACF0CA0FF2
	for <u-boot@archiver.kernel.org>; Thu, 28 Aug 2025 05:03:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 21DED83214;
	Thu, 28 Aug 2025 07:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="se+9BGbx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF8A2831BB; Thu, 28 Aug 2025 04:19:16 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E7B483106
 for <u-boot@lists.denx.de>; Thu, 28 Aug 2025 04:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x11nakyYZAEHyVVWP9TmyIx7x8C6K9t33Km7RbcaWZwn20qcruIJSB0t1OoLOdm+wGu0wK/QW+lhbgdKjuC4U7q9sUlYow1zRT/HGPHCNwsp4Yxxy/zCu9vL11iaW/akAadUkmNwLx+JUe21+wjI6vWc/BnRQAWwVvd8KQEq+F3r5KZBh7c7gHSyG5GT+IXClUdHZppCb2699EQHWnWCrjcWMzlYPk2E9S4C/TjFcK1a/zUCVVRWWqaAZr80Yah+8vbgU3nf09HVRw4Vw+0APtG4uk6DQ9Ba2J1W/INcBbqgOU31IoHw2iw1XakigaGcuj8b0PjXKsPanrjgaRvBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s93amqFnQanj4ns71a6n6NMDXIuAn8jRv9dnu1QkwSA=;
 b=HRRYf4jHz3ldMw3ZNJoC7jYzqCUvTRnMClT47YeJZR4if30JefMxBzdl6QxCzA1JxHR3ducvzfF5EKbsYKdXZKX5RS8otqhey2Jwk/nL5TZobBPDmr5HOx3zknqvviGqOSCFIAVwZBRlmIp9UgDLFKxYING4+G+EU0d1FVX+HmcMjOXKlLZkM1QHIdJt2LfkCCRsM4bawIb9QlPIOq6Pq3XEiwRmlh6zYMKBI+FBhrdM8MBEeJ3e565eBf0UYM2JacSmFsg9cTjcJaUA4RscTn+AuSWx6H02DTXUwz87pLL1YddzZC+a8j6XOdYfDfRXSBWlDITAAZSASXFje1r3dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s93amqFnQanj4ns71a6n6NMDXIuAn8jRv9dnu1QkwSA=;
 b=se+9BGbxrIqgaQFxqLKdOqRMkpQoEgpCg+wR9Ya+Pvk2Mqhrl8vviYiigk4HBuoIdxHxurAmAQbvY1qbVKbs5tOcDRv7pGpvugetm/GkG5WnX1eAsmkJcRjtf65asdXXZD2746HdgwVQk4l5bVvjL6lTJFHIk2aNGDZ5NKlZq4CmDcr7GZhFktq1pQxp0So7NBqX9HG8qdU8x8+ULMxbl43xdvz3gHJKLFAbH3nGPZdO6gZBfsEYO+hkh2TODu/VW1ADbjVdGjHYdZYX1gksr0zvVqC1tZAzsBiBDmYR+9NQIhwt4bAHPyKsS1zeeBQhofG4qOOXCFCfsY3i9JhKHw==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DS7PR03MB5605.namprd03.prod.outlook.com (2603:10b6:5:2c7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 28 Aug
 2025 02:19:10 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%6]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 02:19:09 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Simon <simon.k.r.goldschmidt@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>, 
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, "Lim, Jit Loon" <jit.loon.lim@altera.com>
Subject: RE: [PATCH] arch: arm: mach-socfpga: misc: improve help text and
 usage examples
Thread-Topic: [PATCH] arch: arm: mach-socfpga: misc: improve help text and
 usage examples
Thread-Index: AQHcEkyv0TZ3Zln/RkKC6+boIcI7/LRszKmAgAqQapA=
Date: Thu, 28 Aug 2025 02:19:09 +0000
Message-ID: <PH7PR03MB694289F27892EA6C179B8ADBF73BA@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250821033531.12750-1-dinesh.maniyam@altera.com>
 <b24bcb1b-0c0d-479a-82e9-168ef0bedd93@mailbox.org>
In-Reply-To: <b24bcb1b-0c0d-479a-82e9-168ef0bedd93@mailbox.org>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|DS7PR03MB5605:EE_
x-ms-office365-filtering-correlation-id: 6b0cf60e-6c86-4bd5-2f24-08dde5d945cb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|10070799003|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?amROcnBnbkluQTR3RGtxdU9YTnhNV0ViWktQMTVPbU9uNE9xS05weWU3TGxz?=
 =?utf-8?B?d3pSVE9kRE8rSlhvS0c1dERpb0s2SzllcGFtTG5lRkhOWFFnVEVoMWJRT2pB?=
 =?utf-8?B?cDJvM0UzRWE3cUVFZXBhV0xGaDU4aEhkRXA3NEtlQnQrQlZlRHdhQyt6ZmVj?=
 =?utf-8?B?NFNZUHY2NnJzUE93d0tRZDlHTGp2REJmbDd2R01vdkNwaWxkaGpsenJZa1l6?=
 =?utf-8?B?MjdGSmxxcndOdTFWWVF5aGtCa1FaYzlDL2xNQ0FJOWl1OEgxQmY2dC9SL29y?=
 =?utf-8?B?OFBkVEcrc2EyZzFhcTJ6WXZWVUlSRXpaZkVybXNVRVBpeE0xemlVRW5USDRs?=
 =?utf-8?B?Z2VxR1NDWVVobnV0VVFrTDJOUjZmQTNUWlE0NHZxRWVkVXVoWUdXMitoRHpH?=
 =?utf-8?B?Z0VDcWw2c3VrVHRKKzQvT1hxQUNzVndhZmJQM2FUUTFNZ0QrdlVEdUpxbUtH?=
 =?utf-8?B?WEc2UWNJVk1wMmpRL2dSRGlPZmlKUlpyYmhFVG54TUoxeXdIQi95ZFJLbUxE?=
 =?utf-8?B?aHE0UFU0ZHA4c0t3VmVYUFJkOG1NZE11ZU15dHJVMGdPbjFaOXo2Wmlma3hk?=
 =?utf-8?B?TzU0TFlTekpuTVJlNTA2ZDZVWEFoS2ZBNU1nS0VtLytXdFJ2NlhmV1cvK2Qw?=
 =?utf-8?B?b1VLQ3dsaUJWRm1OT1piTktXSTdFVklFRUxWTXlwZFVyZy9jV2tUT3NyRVNG?=
 =?utf-8?B?MUc0NGE1SnVuMTRic3hUanM5Vjg4T0pDQmhKcEVsUUxpdEl6MGVyaThwSGF2?=
 =?utf-8?B?ellkMTRjQTB2ZlBhRlI3YTNtUTZyUndjM2U0bDZydlNiaGFRVVZHUGZ4NmhF?=
 =?utf-8?B?WmxrNnEreVJSdGFYSDkxSmFZbENiYS9aL1RkQ2lPVmx5MFVQNmdNMzU3OGdM?=
 =?utf-8?B?Y0VNdFRDREVIQXJwMGFDOWI2b2RGbmpTUXZ4T1FLbExvQWp6Z01KOXV2U2hJ?=
 =?utf-8?B?WXFQTVFsdG9Obk05TkRmK01xbUJjQ0dTbnBwNzFTSWpVVUJGdlByOWdvSGhs?=
 =?utf-8?B?TU9tOFRTM2cvZjdFMURiQVdBNEE5YkJzSG4vUGRYSEkvZDdlTkZqSFNaNm0x?=
 =?utf-8?B?UDkwdzUzdWhFd3NsV09QM0lYdTUwOXJ0eHVQQjhTNFdkTTl5VXJHV0txL2Fj?=
 =?utf-8?B?M1VyMTU2cGlFejdvMSs1N3daZytDVG5XbkR5bGtVOXlmQnlzY1F0SEEreURV?=
 =?utf-8?B?YU1TZ0g1N0kwNk1FdFFUVXRSK3pCcThSR1Y2d0hkL1JmVmx3WGFvYjFMTmhr?=
 =?utf-8?B?OHZ5cEdSUFRLQ1NsWnVBT0NiMmRWaEp4RC81cEJndmpIZkRHMFZsTDNQdFQ2?=
 =?utf-8?B?K2E0cGdneTNiY1ZkbVNGWStKbDdrYVd4ZHFOVUdTd2psSk9MZ3Z4M09kc3M4?=
 =?utf-8?B?Kzk0bzUvN2kvWG9ONCtQVmkvUmRIWXFRVGxuNjB1MkN0ejUzd2l4cnVyOWt3?=
 =?utf-8?B?TElQV2pMUW1qWGhXMDFJTTVZZExzbFRkTTBXSW1xOXVPSElsQ2VYRzJ1WDIw?=
 =?utf-8?B?b1I5UmZnbVFGWE8yclZMZlpsSGJnbWh2azhKZnpXakFLTVM0RDlsa0pEMzBV?=
 =?utf-8?B?REU2YjZtSktsckc0RTZla3k4Umh5aEllUTZuQ2NabU5DemlBbElOaU5wVUJr?=
 =?utf-8?B?WXJxOHJYbThmelEwTXN3TUhoaCtGa3AyTVZoZHBoQkY0OUZZM0dhazE2cEN5?=
 =?utf-8?B?aS80Mjc5VTNYMjNvOW0zTlpCMjhJMTFsRnRKSGdoTEV5NnR3SkxDMmdLSHkw?=
 =?utf-8?B?MmZYcXE1NEplZFlldWJRdWRXdTNVUXhTSENsT0lROWI5ZHRaQktlY004OUV0?=
 =?utf-8?B?cnhIdWxMMFp4elhjcUZyR00zUVl6eGllUndlUndJZkhSQnBpM3VRZHFpdkNF?=
 =?utf-8?B?MFU1SHhSZU9qTFdwdXdUcFluNjVIUVBkaXJJSDFuL1pHTUhzTnhwcmY3MWhV?=
 =?utf-8?B?T2sxTFozQnl2RFEvdi9IT2Y3cDdZZkpSMlNUV2VYb2d0c3l2bHViUnZFQnRp?=
 =?utf-8?B?dkJndFpZZTdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHB2YWVhTDBYdWV6eVd5aFh4Z2cvMiszOTZyamJRQmtkWE8zUWNtY2NyZEVE?=
 =?utf-8?B?QUxDNDJWQlN0VE1jZmhqeVZnOHJTZXF4TWt2ZHZMK3BGdUl6RVFraDBQU1ky?=
 =?utf-8?B?c2w3Smhmb1Vyb0tOdEoveHUvcGhTTE1iUHhxQ2QySTBoekdZTUdWQXdJSVFl?=
 =?utf-8?B?SGtjWlRlc20ySTRmaGpibzdOeW1yM2JEVGNyMEM3Vmp0QmxTR09mcURoS2V1?=
 =?utf-8?B?THZyZHd6czVOeEtZM0V6d0lNdDQyeVU5OFl2bWYvUld0Z3hyUUZadk5Sdjda?=
 =?utf-8?B?cHo3elMrelM1UWp4cnlzeEp5SkRsZkpoSXlaZjkyWlJDZ1MxQWt4TFZHcHFn?=
 =?utf-8?B?UFFUZm1YSGNVb0xaeFcrL2V4eDdTOXI0b1hMelZzdVMrbVIySFRudUJCdFJJ?=
 =?utf-8?B?c3duR3krazBycCtHWnpQSTVJbEgzMzQrbitIOVZjajNzeEp2S0tIVDVNN0tw?=
 =?utf-8?B?QUQ4aGRuTGVVOUVjV1BHY1JuNXZFSXk0YmsvdS9pN1JVd3ZGUmVsNldNWDNT?=
 =?utf-8?B?RXUwQXRscXNTZ2dTekZQazUra2NzRitWV3lSak1lUU1rdnp4elM0U2pqa255?=
 =?utf-8?B?ckFDMzVOcG1mbllTY2o5NFVVVWZwbzltMXdLQ1loeGt4UVkwMHQ0MklUUDZu?=
 =?utf-8?B?d1dhWWhZZzcwVkM0YjNqeVprQ3BkVDllTmxGSVQ3ZFpENE9sWDI2aUM1M29u?=
 =?utf-8?B?c2V4ZTB0SEFIcUZSRlJDV2RiSm0wWjE1U2hjQzN3d0NIeVdXeHFHd2F5YjNs?=
 =?utf-8?B?aHpzWkV6QnBnd3dESnUwQ2dKNFpoMDJSUDVORHFBcW1SM0RPUUFHS1h0ZVVt?=
 =?utf-8?B?QTY1UEFKYzVnMms0eHVycitpNHdaaW05dGpVanZ6b2wyMnp6TlhFRllWc1Vk?=
 =?utf-8?B?dDVDeWJVZS9DWEtrODAxUkF1Ui9vN2F4STVySlhqbDRIaXg1Wm1rSWRKSVZ3?=
 =?utf-8?B?WEZiZnA1cW12WFd2eVp2dU9RZHBRZ0dYc2F0RFNLQ1BDekRYWFlMak5oM3ZG?=
 =?utf-8?B?VW5JYWZXbXRpVWdWWmVSdE8xN2tma3dpWi85NmxSZm44Ty9kVndtME82VkFU?=
 =?utf-8?B?a0NmajkxOXhtZmhlaU5mZ2JWallQcjgxck81ZTFXcFg5bDlEdjhMOTZUcG05?=
 =?utf-8?B?VFhnTEtZQUQ0cGxabFliM3pkYXpIY0JrcDBVU0E4RE5uK2NSMWEvRXRWNkYz?=
 =?utf-8?B?S05yU0d5TEhJTHZoQ1RZMC9xS05XajBoQ2ZqVWc0N1VUL3VQOTFjOFlsVWtn?=
 =?utf-8?B?M2RJcVVsRzg0cTVTYTJGOFdEbWNkOXNnK210VitRZUgrdlg2ZTk2K0RXbEJ4?=
 =?utf-8?B?QjU4QnVRSVlmamhQc3BpTjB4Zm9FclJIUXJiNE1Nd0pianZYTzB4MnBXR2t1?=
 =?utf-8?B?YWdLSXJzbkZLNnBtMGJYMWo4WUpCcjdQMnZZQ2ZtbFI0NlNMQkdJSmZaKzlK?=
 =?utf-8?B?VkFlcXVSL0VtVHduU3RYTVRXVlplRDBURm5DWUpZZTRldTF2bUhlZDMrSUVB?=
 =?utf-8?B?ZDVrc2lJUk9MUVZpNW5MUVBoMUk5VE1IS1p6ZUdRZ2J6ZDdyU3Jxbm8yUkdr?=
 =?utf-8?B?VkYwRlRkbEZlZzM0R3JmWkM0SVkxa09yYzhwZk1UK1BhVTNYOUgvN0pVVk15?=
 =?utf-8?B?VlNjMUtpa0xFaDBVK3o1Y3k3c3h2STNjT2pIWlo0Q21OQlAvSk1JdGdudzNW?=
 =?utf-8?B?bWdxNzV2dW4zTzRMMGQ2NXN4WTlPMmhRdmkyRXAxQkw0WUxGSjF4TlBBOUs0?=
 =?utf-8?B?S1ZoS1ZPUFE3SW84KzhwWXpmaXpSQ0lRaUtoUXk3RDMrMmRTWU84Q0JyaW9v?=
 =?utf-8?B?UzM5YWIrY2FJMi85N1ZlTG8zSldRbDR6ZmRWcjMrejlwTzY5QnJ2OU10TXdV?=
 =?utf-8?B?Z0Fvck1SaTlwNkVFSUljMTZCV2VjZTJKY1FVa2lvdHdWZG8wMm9Jd050dFhM?=
 =?utf-8?B?TGo3RDlPeFVRNXQ0T3JPQnVSMFNJamQ3VnQzOEp0MERsdDJHbWRjd2dBaW5x?=
 =?utf-8?B?enlHT1dVQ243OTU1VHlLTnhFek5iUXlEbFFsSjdHcWFyUUJwb3diYVJnQm1B?=
 =?utf-8?B?NmwrdTVURHMvbU5EVU5MVEUvSU1hMkNQZVlvajdMWkFHcThET2QwSy83NVR0?=
 =?utf-8?B?K3JIQlFTQXJ4dXNkdytSUzJEVU5aMlF4a0hFdGVHYlh1a0RXczdZTkcwTVdW?=
 =?utf-8?Q?5DHvLcrGPCBGxwH7P6B8wdWxAA3M13g6M1c8kKs9LEkj?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b0cf60e-6c86-4bd5-2f24-08dde5d945cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 02:19:09.7650 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sddcLFDH469DwIvMx7/gLPBBjKN9/07qXbkV1kGrnuBJl46lART1YfyBSOy7A/X6VjVkCq73nK9LoPV6vkGWQT6NRRlvwoEi2kTI4g6bvpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5605
X-Mailman-Approved-At: Thu, 28 Aug 2025 07:03:09 +0200
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

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFyZWsgVmFzdXQg
PG1hcmVrLnZhc3V0QG1haWxib3gub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgMjEgQXVndXN0IDIw
MjUgNDo1MCBwbQ0KPiBUbzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEu
Y29tPjsgdS1ib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFNpbW9uIDxzaW1vbi5rLnIuZ29sZHNj
aG1pZHRAZ21haWwuY29tPjsgU2ltb24gR2xhc3MNCj4gPHNqZ0BjaHJvbWl1bS5vcmc+OyBUb20g
UmluaSA8dHJpbmlAa29uc3Vsa28uY29tPjsgQ2hlZSwgVGllbiBGb25nDQo+IDx0aWVuLmZvbmcu
Y2hlZUBhbHRlcmEuY29tPjsgSGVhLCBLb2sgS2lhbmcgPGtvay5raWFuZy5oZWFAYWx0ZXJhLmNv
bT47IE5nLA0KPiBCb29uIEtoYWkgPGJvb24ua2hhaS5uZ0BhbHRlcmEuY29tPjsgWXVzbGFpbWks
IEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPjsgTGltLCBK
aXQgTG9vbiA8aml0Lmxvb24ubGltQGFsdGVyYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hd
IGFyY2g6IGFybTogbWFjaC1zb2NmcGdhOiBtaXNjOiBpbXByb3ZlIGhlbHAgdGV4dCBhbmQgdXNh
Z2UNCj4gZXhhbXBsZXMNCj4gDQo+IFtDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIGZyb20gb3V0c2lk
ZSB5b3VyIG9yZ2FuaXphdGlvbi4gVW5sZXNzIHlvdSB0cnVzdCB0aGUNCj4gc2VuZGVyLCBkbyBu
b3QgY2xpY2sgb24gbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyBhcyBpdCBtYXkgYmUgYSBmcmF1
ZHVsZW50IGVtYWlsDQo+IGF0dGVtcHRpbmcgdG8gc3RlYWwgeW91ciBpbmZvcm1hdGlvbiBhbmQv
b3IgY29tcHJvbWlzZSB5b3VyIGNvbXB1dGVyLl0NCj4gDQo+IE9uIDgvMjEvMjUgNTozNSBBTSwg
ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBEaW5lc2ggTWFuaXlh
bSA8ZGluZXNoLm1hbml5YW1AYWx0ZXJhLmNvbT4NCj4gPg0KPiA+IFRoZSBleGlzdGluZyAnYnJp
ZGdlJyBjb21tYW5kIGhlbHAgd2FzIGluY29tcGxldGUgYW5kIGNvbnRhaW5lZCBhDQo+ID4gc3Bl
bGxpbmcgZXJyb3IuIFRoaXMgcGF0Y2ggdXBkYXRlcyB0aGUgaGVscCB0ZXh0IHRvIGNsZWFybHkg
ZGVzY3JpYmUNCj4gPiB0aGUgYXZhaWxhYmxlIGJyaWRnZSBiaXQgcG9zaXRpb25zIGFuZCB0aGVp
ciBjb3JyZXNwb25kaW5nIG1hc2tzOg0KPiANCj4gVGhlIGNvbW1hbmQgd2FzIHByaW1hcmlseSB3
cml0dGVuIGZvciBDVi9BViAsIHRoYXQncyB3aHkgaXQgd2FzIGluY29tcGxldGUgZm9yDQo+IG5l
d2VyIFNvQ3MuIEluc3RlYWQgb2YgdGhlIGJpdCBoYW5kbGluZywgd2h5IG5vdCBhZGQgc3VwcG9y
dCBmb3Igc3ltYm9saWMgbmFtZQ0KPiBoYW5kbGluZyBpbnN0ZWFkID8NCj4gDQo+IEFkZCAnYnJp
ZGdlIGxpc3QnIHRvIHByaW50IHN1cHBvcnRlZCBicmlkZ2VzIHBlciBTb0MuDQo+IA0KPiBBZGQg
J2JyaWRnZSBzZXQnIHdoaWNoIGhhbmRsZXMgYnJpZGdlPXN0YXRlIHBhcmFtZXRlcnMsIGUuZy4g
J2JyaWRnZSBzZXQNCj4gaDJmPTEgZjJoPTAgLi4uJy4gVGhhdCB3aWxsIGJlIGZ1dHVyZSBwcm9v
ZiBhbmQgc2NhbGUuDQoNCkkgZ2V0IHRoZSBwb2ludCwgaW1wcm92aW5nIHRoZSBicmlkZ2VzIGNv
bW1hbmQgd2lsbCBoZWxwIHRvIHN1cHBvcnQgbmV3ZXINClNvQ3MuIExldCBtZSB3b3JrIG9uIGl0
Lg0KDQpUaGFua3MNCkRpbmVzaA0K
