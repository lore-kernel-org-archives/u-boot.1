Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B851CA1016
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 06:42:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1E7B832DA;
	Thu, 11 Sep 2025 08:42:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="UAIVcwQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 029CD832F0; Thu, 11 Sep 2025 08:42:29 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15780832AD
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 08:42:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaxPby5eZOoQW6xKTPvR9vqSMROsMTlRUFJBa/OUV5QCrID8bat2rjVlmeN5FxUhyT7ASFriF2DZxsvRjefXWHEgkzctywxicyF4ItS7+U/uZmE2yxhhUlXZZDApdl8pvD2fpVTkj64bTYg1Y82ALliBsUr+NaAg99jcepXHuAvhyMuTMG2IxaoQfOEtlE8q0njLIReB9OTeP7SRmQO4TQxW1o0GEr2x9QTQ2k2hCPj92/2+xIlU3k5SpFUa3h0l7y5Xn/B/ROoSEq/8+HOONL01wRUei2UjvhqZzNHSoxEssxpMotPU/cNujjmnaOnSDubzLnusY1ZvC/sJm3IzJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0O1h1WWy3MEi7j07GrvBFIjZ6liSLWgGcX7PCorHv6s=;
 b=W9r/6voRhsfMuRMO7uXwQYspVJikIbdpUVEcGGIMO0LOd0wRLRGOv19DGrGeD6fvXEtQp9EvhvXOYt22PKHpfmopS8K64ITXHooUd7U8wbYRvbJKUpzb1PlIsFFnfmMhJ+Pp9z0oLcPG9PQrgK6cJDJ0llMmucQtTk9+S0OTYmwaZmXVcIPYZBQNV5m1pHS9JcJxlTmjclqM2Xa0w8wVt7cN1MRNcakGXWl0bHVdsBbmTxXicMAjFYV/0dy/RUBtIbVe81MnF40ls+HOxQQgfv7PrI1wck9vWCz2/lHN7eU91lRbJqaJ9siBbWUBofty45mOi2CxxseRkV1rQUMbXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0O1h1WWy3MEi7j07GrvBFIjZ6liSLWgGcX7PCorHv6s=;
 b=UAIVcwQ7YnNF7RHFqh5jDiS4GJuHw0OrLn+A9OZ5hfgKERFZUl9Pu3YnPAzMfj9JQHQ5HYKn8JDjKVaG1zmp2gSnrIPHNcFx8HNJPjUOfjc8ielDhFz2MIPxsQ5UsqyJKc3aV76tFkmwttRizd0TZaUME2gAnA7IrW9A9en3Y4yk5llCCr9HjelMYbDftT2PuXPVvEDEgy7UFXGO/8DfQg7sna/6bzj0+3m3C8ZlHtXPVpWYg9enpVCVsdDW9Ws6Guz64Rq5S6flGX78cjGq/V02Scrrm8EDMxMDLSPYBeKGensLnU4oODx3HWRjmQegrBpLtzzfR+CK+4boHy1OHw==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB7178.eurprd04.prod.outlook.com (2603:10a6:10:12e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.16; Thu, 11 Sep
 2025 06:42:22 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9115.015; Thu, 11 Sep 2025
 06:42:22 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: E Shattow <e@freeshell.de>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, Alice Guo
 <alice.guo@nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>, Peng
 Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Subject: =?gb2312?B?u9i4tDogW0VYVF0gUmU6IFtQQVRDSCB2MSA0LzhdIGlteDk6IHNjbWk6IFVw?=
 =?gb2312?B?ZGF0ZSB0aGUgZmlsZXMgdW5kZXIgYXJjaC9hcm0vbWFjaC1pbXgvaW14OS9z?=
 =?gb2312?Q?cmi/_to_support_i.MX94?=
Thread-Topic: [EXT] Re: [PATCH v1 4/8] imx9: scmi: Update the files under
 arch/arm/mach-imx/imx9/scmi/ to support i.MX94
Thread-Index: AQHcIq4sAVH8wXY8eE+tHSEPIIcXyrSNOU4AgABLkvA=
Date: Thu, 11 Sep 2025 06:42:22 +0000
Message-ID: <PAXPR04MB96448A9D96B04749D3E882FBE209A@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20250901-imx94-v1-0-c85ae7cdd95c@oss.nxp.com>
 <20250901-imx94-v1-4-c85ae7cdd95c@oss.nxp.com>
 <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
In-Reply-To: <5ce9ad71-2d24-408b-ba55-cd87bf96afb1@freeshell.de>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|DB8PR04MB7178:EE_
x-ms-office365-filtering-correlation-id: c2d28d06-d730-4247-e7b4-08ddf0fe5cc0
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?V3h5WERNNWVJcTF1MXhkQ2kwYzFwU0swNU1WVWxnT3Zpc1NoRDBYcVZmUnZJ?=
 =?gb2312?B?M2JJcUV5YXlkWlM2Qno2bGkxdk5iUVNSMFp6UXdXMm1NQ1pMM3NiQ3FqbTky?=
 =?gb2312?B?QjVPa3IrZ2pxTHA5Z1RuamhsMHBvSFhFbDhRK25IeVp4dDZTOVdPQmRtaWVo?=
 =?gb2312?B?UUNPanF1OVhkQzBMOWw0Nmlic3duc0NYamZBTDNkcDdDTi9LNVRmcy9Cd096?=
 =?gb2312?B?ejNDNFNObTZFcE1aT2ZlWVcyUUVMaytFY0ZXWGlxVTk5NTVHNVV6Mkp6NWxw?=
 =?gb2312?B?MDJRVVhCdXR0OVl1K2RVTWVEbmNEL29VMDFkQ2Q4Qml2eDBBZ1R6bmdpOVJW?=
 =?gb2312?B?NkFOM3l2YnNxeTdhQXF2K1cvQmpEYzhaeFVPeVE2OWxlR01jYzl3aTlOanJl?=
 =?gb2312?B?T09qUlpxdFNIamUrMjlCcHBibkUwSGNvK1lmd1NUNHpwKzRIWm1FSzlMNm5J?=
 =?gb2312?B?eEFXZC81ODRmMVNkVzc2eXFGdSs4YlVuS2xWYUEzZ3ZZV2dxakcxeXQ5cmVI?=
 =?gb2312?B?cnlia0doZ082bTZmUE84VGNzeDZVT2EyM0VsUTRsa3hvNStRU0xLaVh1c0JX?=
 =?gb2312?B?L3Fac3Y1N1dzd2doai9GRkIwRlc3bUR4dkZDYWMwMyt5MGYrWVlrRXZVOEJm?=
 =?gb2312?B?TDNvQkYrLy9HVDViNHVwM0VzT2U0MVpXRFROc1UwN2t3Mkt6ZnBZSjZGb0Va?=
 =?gb2312?B?eGlNVUk3VnpBaEdPbHdqNUowaEt4ZHZzTk11a1Rxa0NKSFFmem1tdktEY01m?=
 =?gb2312?B?ekJHK3FFc2h3ZjI0NGpvcVJDMXdHc09UUTdPbHU1L0NBTkNHVVdZVDJGRUR1?=
 =?gb2312?B?M1l4T2hiTGg0WEdCR0xFVWVEWXNNWHNDRmQ0T2o0QnlyQ0ZRdnRiaFc5Mll1?=
 =?gb2312?B?SFgwYU9BM21YT05jcDc4cmZhdVFHSklkNkp5czM3amlIZ0k2UzM1TTRHYjhK?=
 =?gb2312?B?RXJoaE5vcnUySWtjWS90ZUVQVGovVmNxd213b2J2ZUsxczMrVHZCcjF0Mmgv?=
 =?gb2312?B?dzNtZFpkMngwQTJQY2FTZ3NaMkREUVpIa3M4eG92RVE0WXhTaUY2SWVFZkI3?=
 =?gb2312?B?a214RzhCQ3JkNU83Y3loUk5IdjBzWkkxN2hHbHZVQll5dlRaKzV3VXBjUlN2?=
 =?gb2312?B?VGp2VGppTm9GMTJRQmdETzFjVWoyVWlFWWpVRktzVjY4UDUwb0owWUk2dEtt?=
 =?gb2312?B?d0o5ODNlOGlrOURYelloS2Z0dUg4SU5UQWRWaitDUzY3WkRnRUJMSGJRdEZU?=
 =?gb2312?B?RFA4MzB6KytvbHpPSk1NWU8zR3ZiWUxJZDdwQUhIT3NYTGdiSDg3bUprcHZy?=
 =?gb2312?B?M1NGK2ZqSVZGaHBqQ3RjNzZDWXMvODkybmNyck1xeFFsMTkwYkU0TWlJck9s?=
 =?gb2312?B?VlNGc1pnU3BGY2dYTDdrcmZYc3BMMjVsWGN4TnlzUW9pZnlvOHppZ2lyYWkr?=
 =?gb2312?B?Um5FVEZRTHoyVVV1SEdUSTZDMlRSZm85TVBGMWhmd0tHeTlhb2xVei85ZjFB?=
 =?gb2312?B?YjBtam1OU29keloyZzVrd3hKakpBUWw2L25oM05BZElhdzZqTjh4dTg5TU5i?=
 =?gb2312?B?SVJCdklGYTdMNXUxMmpzR3lhZ0RwMStaeWY1L3h3dG5tdnhBYXVmZzRFUXh1?=
 =?gb2312?B?VHdvS3FhTU5MdkVKU2VzdVh2RWs3Nlorb3NzSlNLRjJDWEJ2TWxiUDNIbDFh?=
 =?gb2312?B?KzBONXFQT05iVndLNklTQy90T2c3UlZaUFJCRGJCYUI0UVVJYjFWcWJKOUtn?=
 =?gb2312?B?SHI1VXlVZXZvMHdTOHVibERMWjZLcURjaVFtZllQRk5LUHRIaWhmRld2aEJZ?=
 =?gb2312?B?ZFlYNzFpUnpScTd0U0NYR2xQUFA1cmpKUno1RXpod2Zma05xMlFHYjZoRkd1?=
 =?gb2312?B?MFA0SjVJOERBcE41QVdORUErWEt6bWRGV3o4RXEyY3dEUStiSWZqYW80c1ZE?=
 =?gb2312?Q?Pjv1l/Dc6x4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VXhickJpMnJoaGkzcFkvQk1hT085R0cyY2VtVEl2aEk3RWVxR01Ed0VRR0d6?=
 =?gb2312?B?QW5SYzNaS3VDZWQzY05USjVzMW9jbzJxYjNFOXdzMzJjRnliaXFGNUR2QU90?=
 =?gb2312?B?UFRuWTdyYmJKMVlsS0FSdGJTdGVUcXdoTWl6dy9jUXd2cFdyL3N4OEZFajh0?=
 =?gb2312?B?WkgxYXJXbVd4eWpuZjkyekNKTS9KcUdMVGN6MGEzZUVhM0IxbE1jblFuUGI5?=
 =?gb2312?B?UVg1Q2dyWG1VTzd1OWZhSUFNQS9wc1lJbmZ3NmZQZHUvNHhrdjdvQWxWOHN2?=
 =?gb2312?B?T3FzYlVTTW9jRmxJN2FBejBPNkdpT05vRWZGK0lwNUYvckFyMzdJQlpWYkZI?=
 =?gb2312?B?Yk81MXU2NGVHd2tJWkZUakZBQyttSDlBQkFpbjdHN1FUMURJalBrZGRhcWlr?=
 =?gb2312?B?MjBOVThjb0MzVWFzZFExcklNVHRNcUdzdkRuVFE4dWtORzk3d09HdStUZUJt?=
 =?gb2312?B?QWpxTURHWjNybm1kL3pMZUVrZ3F6NTVuckdmQjdpbUdUenI3ZUVIV3VWNG9I?=
 =?gb2312?B?clJ1MFUrakYwMWU3NDVxelVnV3dLMmQrc0NJTTFsWnNMbmpMQnd3UkhDUDl0?=
 =?gb2312?B?NktpV1RjYTIveWdFbzlUbENOcWVHZGdlSVcxNEorTHo3c0FBY012dW1HNE4x?=
 =?gb2312?B?eVdPMG50ejdBRTViRG0rRVNxNDNtRUtrMkVqL2JZbElqVnFLN1NqZ0RzMUU4?=
 =?gb2312?B?cWFOUWdJaUludCtwT1p6VFJVN0l3WlhDSTJsc1RxTjdRT0NlOGdvWjNZOGkw?=
 =?gb2312?B?c1BHVi9BSlY4emtCbVc3aW4yS2ZxejhIbUt4QlFnZWk0S0lNMUp5a21rcXVI?=
 =?gb2312?B?Y1hCN1VKVzFTT2NIRlhYZS9kak1CU3VBa253NHpyenRCb3NRNkMwVC9GV1k0?=
 =?gb2312?B?bUFtY1ZzVlhIcDV2THNGQllGWDlaR0hqMjBaVStCdGNZK2tTQ1hxK2pJWWY5?=
 =?gb2312?B?Wkx2dkh0S3N3YTNsbHl0d0pCNnNiUDk0QmxhR3BMM2dMTWE5Si9qVFlrczNT?=
 =?gb2312?B?N2wzWHJOQXhNdE5Pdmt3SkNyWjhWVjFOUGZCalBWM0FYM203Ym84N3ZtUk0r?=
 =?gb2312?B?NERFOHRUbDA4am1tY05Rc0ROL2NrTU42ei83VnJDcEEyK2JLK1h5TGFFYkZs?=
 =?gb2312?B?MFhUQVBXM2kwd3g4M05NcUxJOU1BU1QwTTJzajUwZFU0dngzakkydXl4MC9U?=
 =?gb2312?B?M096a09YU2lCbFJ4TnVPbE5Ldk5lK3ZodlVTYXJwZ2VtZHFQNTJEMENEVm1v?=
 =?gb2312?B?dTZHelJHOGJJYUpSeVpCL1BqZ0dYS1JkcEx0SWNnRzFBc2NZd01ZTjFmWFZW?=
 =?gb2312?B?WmF3ZXl1eFpBMDVKVTdtYUdWazJwTjV3WEM0MFFhdEY1MVFKWEs3d1VmUFpH?=
 =?gb2312?B?VG93aGpidnRNa0tId3AzSnMrK3JwZnRFSmZ5b2NHM0lDR1NCc2gvaE5aUFdL?=
 =?gb2312?B?OHVvTXA4ZkF3ckxadDlGR0VtcU9PTmkyYW9BcVBxVUVES3NHNDRJKzM2bmtN?=
 =?gb2312?B?REt3cEJMRjhKb0ZwRk9nTHBmNjdPR21RNlp4aWZ3bEIyV2hVRGFrUmpvL2tq?=
 =?gb2312?B?bnZLMUNBU2xuOHVJSE9nYzhzTlBEVDNEZFowRkkvUnN1dzFWbUpFdUhOMUFM?=
 =?gb2312?B?R0lEbDRmYjhhc2RxNGk4YzhZTUJLY0hPRFR1Q2VSWFpqOFN4bmxQL3ZjclF2?=
 =?gb2312?B?cDBDYUxmeENsOGF1OFlVQlJWVWVDYm9QRTJyTlp3YkZtMkR0cFdBZTJPS0lO?=
 =?gb2312?B?RzlMK1V6YmxNL0MzS2hHR2xSYWQvT3I2L0lNYkxGdzNDYnc1ajc0a3NWTWQz?=
 =?gb2312?B?d1ArMit2QitFcVlrY24wbHFGMTlrMFpzUVZxa2t5U3c2eUNFM3htUnI2QlN1?=
 =?gb2312?B?aGxjQ09mREdRZUVaaGZacHlhMTlEVEdyTldpMXdNM0gxaGViYitwejBENHFy?=
 =?gb2312?B?VXdYVnhMV3U4MnZaT0hlTE0ycTBRcjFmcUgyYXJJK1dMcjgvTDh3TjIwVkw1?=
 =?gb2312?B?VnUxVHhSWTgwM080K3JxbXpTMk5uYnFxR0xMc2pBR1JLUTBhOW1BWVltUWYw?=
 =?gb2312?B?TThNdDRFSnl5OWFqVllRZzZGNTVMSGo5UWp2enlBY3lKcSthaERnU3RPTGJ0?=
 =?gb2312?Q?2j/c=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d28d06-d730-4247-e7b4-08ddf0fe5cc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 06:42:22.4788 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: alhKSEiPYqC/4KAl1ZoAQKLYWGlzjbPmqp02wmRiiW1itFlU7oBpoNM9hDpnSxRKjYp1I1RXgbn0Hh7C51dlCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7178
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBFIFNoYXR0b3cgPGVAZnJlZXNoZWxsLmRl
Pg0KPiC3osvNyrG85DogMjAyNcTqOdTCMTHI1SA5OjU3DQo+IMrVvP7IyzogQWxpY2UgR3VvIChP
U1MpIDxhbGljZS5ndW9Ab3NzLm54cC5jb20+OyBTdGVmYW5vIEJhYmljDQo+IDxzYmFiaWNAbmFi
bGFkZXYuY29tPjsgRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPjsNCj4gZGwtdWJv
b3QtaW14IDx1Ym9vdC1pbXhAbnhwLmNvbT47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+
OyBBbGljZQ0KPiBHdW8gPGFsaWNlLmd1b0BueHAuY29tPg0KPiCzrcvNOiB1LWJvb3RAbGlzdHMu
ZGVueC5kZTsgWWUgTGkgPHllLmxpQG54cC5jb20+OyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5Abnhw
LmNvbT47IEphY2t5IEJhaSA8cGluZy5iYWlAbnhwLmNvbT4NCj4g1vfM4jogW0VYVF0gUmU6IFtQ
QVRDSCB2MSA0LzhdIGlteDk6IHNjbWk6IFVwZGF0ZSB0aGUgZmlsZXMgdW5kZXINCj4gYXJjaC9h
cm0vbWFjaC1pbXgvaW14OS9zY21pLyB0byBzdXBwb3J0IGkuTVg5NA0KPiA+IC0tLSBhL2FyY2gv
YXJtL21hY2gtaW14L2lteDkvc2NtaS9jbG9jay5jDQo+ID4gKysrIGIvYXJjaC9hcm0vbWFjaC1p
bXgvaW14OS9zY21pL2Nsb2NrLmMNCj4gPiBAQCAtNiwxNiArNiwxOCBAQA0KPiA+ICAjaW5jbHVk
ZSA8YXNtL2FyY2gvY2xvY2suaD4NCj4gPiAgI2luY2x1ZGUgPGRtL3VjbGFzcy5oPg0KPiA+ICAj
aW5jbHVkZSA8c2NtaV9hZ2VudC5oPg0KPiA+ICsjaW5jbHVkZSA8c2NtaV9ueHBfcHJvdG9jb2xz
Lmg+DQo+DQo+ID4gICNpbmNsdWRlICIuLi8uLi8uLi8uLi8uLi9kdHMvdXBzdHJlYW0vc3JjL2Fy
bTY0L2ZyZWVzY2FsZS9pbXg5NS1jbG9jay5oIg0KPg0KPiBXaGF0IGlzIHRoaXM/IEkgYXNrZWQg
YW5kIGl0IHdhcyBzdWdnZXN0ZWQgdG8gc2VuZCBhIHBhdGNoIHVwc3RyZWFtLCBidXQgdGhleQ0K
PiBzYWlkIG5vLiBSZWY6DQo+IGh0dHBzOi8vbG9yZS5rZXIvDQo+IG5lbC5vcmclMkZsa21sJTJG
UEFYUFIwNE1CODQ1OTcwODYzQTE2NzE4OTY3MjcwRDFBODgwRUElNDBQQVgNCj4gUFIwNE1CODQ1
OS5ldXJwcmQwNC5wcm9kLm91dGxvb2suY29tJTJGJmRhdGE9MDUlN0MwMiU3Q2FsaWNlLmd1byUN
Cj4gNDBueHAuY29tJTdDMzU3ODlmMzFiZWM4NDA0ZTk1YWMwOGRkZjBkNjdhZWElN0M2ODZlYTFk
M2JjMmI0YzZmDQo+IGE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzODkzMTUyNjIwMDMxMDM2
MSU3Q1Vua25vd24lN0NUDQo+IFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzSWxZ
aU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGENCj4gVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRV
SWpveWZRJTNEJTNEJTdDMCU3QyU3QyU3QyZzZGF0YT1CTFI2dQ0KPiBwVVdLOFhFa0hNQXQ1bTBY
JTJCQW44Z2ZPTnZEcXdMNmdVTFFaMk9jJTNEJnJlc2VydmVkPTANCg0KVGhpcyBsaW5lIG9mIGNv
ZGUgaXMgdW5uZWNlc3NhcnkgYW5kIGNhbiBiZSBkZWxldGVkLg0KDQo+ID4gKyNpbmNsdWRlICJj
b21tb24uaCINCj4gPg0KPiA+ICB1MzIgZ2V0X2FybV9jb3JlX2Nsayh2b2lkKQ0KPiA+ICB7DQo+
ID4gICAgICAgdTMyIHZhbDsNCj4gPg0KPiA+IC0gICAgIHZhbCA9IGlteF9jbGtfc2NtaV9nZXRf
cmF0ZShJTVg5NV9DTEtfU0VMX0E1NUMwKTsNCj4gPiArICAgICB2YWwgPSBpbXhfY2xrX3NjbWlf
Z2V0X3JhdGUoU0NNSV9DTEsoU0VMX0E1NUMwKSk7DQo+ID4gICAgICAgaWYgKHZhbCkNCj4gPiAg
ICAgICAgICAgICAgIHJldHVybiB2YWw7DQo+ID4gLSAgICAgcmV0dXJuIGlteF9jbGtfc2NtaV9n
ZXRfcmF0ZShJTVg5NV9DTEtfQTU1KTsNCj4gPiArICAgICByZXR1cm4gaW14X2Nsa19zY21pX2dl
dF9yYXRlKFNDTUlfQ0xLKEE1NSkpOw0KPiA+ICB9DQo+ID4NCj4gPiAgdm9pZCBpbml0X3VhcnRf
Y2xrKHUzMiBpbmRleCkNCj4gPiBAQCAtMjQsMTMgKzI2LDEzIEBAIHZvaWQgaW5pdF91YXJ0X2Ns
ayh1MzIgaW5kZXgpDQo+ID4NCj4gPiAgICAgICBzd2l0Y2ggKGluZGV4KSB7DQo+ID4gICAgICAg
Y2FzZSAwOg0KPiA+IC0gICAgICAgICAgICAgY2xvY2tfaWQgPSBJTVg5NV9DTEtfTFBVQVJUMTsN
Cj4gPiArICAgICAgICAgICAgIGNsb2NrX2lkID0gU0NNSV9DTEsoTFBVQVJUMSk7DQo+ID4gICAg
ICAgICAgICAgICBicmVhazsNCj4gPiAgICAgICBjYXNlIDE6DQo+ID4gLSAgICAgICAgICAgICBj
bG9ja19pZCA9IElNWDk1X0NMS19MUFVBUlQyOw0KPiA+ICsgICAgICAgICAgICAgY2xvY2tfaWQg
PSBTQ01JX0NMSyhMUFVBUlQyKTsNCj4gPiAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICAgICAg
IGNhc2UgMjoNCj4gPiAtICAgICAgICAgICAgIGNsb2NrX2lkID0gSU1YOTVfQ0xLX0xQVUFSVDM7
DQo+ID4gKyAgICAgICAgICAgICBjbG9ja19pZCA9IFNDTUlfQ0xLKExQVUFSVDMpOw0KPiA+ICAg
ICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgZGVmYXVsdDoNCj4gPiAgICAgICAgICAgICAg
IHJldHVybjsNCj4gPiBAQCAtMzgsNyArNDAsNyBAQCB2b2lkIGluaXRfdWFydF9jbGsodTMyIGlu
ZGV4KQ0KPiA+DQo+ID4gICAgICAgLyogMjRNSHogKi8NCj4gPiAgICAgICBpbXhfY2xrX3NjbWlf
ZW5hYmxlKGNsb2NrX2lkLCBmYWxzZSk7DQo+ID4gLSAgICAgaW14X2Nsa19zY21pX3NldF9wYXJl
bnQoY2xvY2tfaWQsIElNWDk1X0NMS18yNE0pOw0KPiA+ICsgICAgIGlteF9jbGtfc2NtaV9zZXRf
cGFyZW50KGNsb2NrX2lkLCBTQ01JX0NMSygyNE0pKTsNCj4gPiAgICAgICBpbXhfY2xrX3NjbWlf
c2V0X3JhdGUoY2xvY2tfaWQsIDI0MDAwMDAwKTsNCj4gPiAgICAgICBpbXhfY2xrX3NjbWlfZW5h
YmxlKGNsb2NrX2lkLCB0cnVlKTsgIH0gQEAgLTQ5LDE5ICs1MSwxOSBAQA0KPiA+IHVuc2lnbmVk
IGludCBteGNfZ2V0X2Nsb2NrKGVudW0gbXhjX2Nsb2NrIGNsaykNCj4gPiAgICAgICBjYXNlIE1Y
Q19BUk1fQ0xLOg0KPiA+ICAgICAgICAgICAgICAgcmV0dXJuIGdldF9hcm1fY29yZV9jbGsoKTsN
Cj4gPiAgICAgICBjYXNlIE1YQ19JUEdfQ0xLOg0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIGlt
eF9jbGtfc2NtaV9nZXRfcmF0ZShJTVg5NV9DTEtfQlVTV0FLRVVQKTsNCj4gPiArICAgICAgICAg
ICAgIHJldHVybiBpbXhfY2xrX3NjbWlfZ2V0X3JhdGUoU0NNSV9DTEsoQlVTV0FLRVVQKSk7DQo+
ID4gICAgICAgY2FzZSBNWENfQ1NQSV9DTEs6DQo+ID4gLSAgICAgICAgICAgICByZXR1cm4gaW14
X2Nsa19zY21pX2dldF9yYXRlKElNWDk1X0NMS19MUFNQSTEpOw0KPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIGlteF9jbGtfc2NtaV9nZXRfcmF0ZShTQ01JX0NMSyhMUFNQSTEpKTsNCj4gPiAgICAg
ICBjYXNlIE1YQ19FU0RIQ19DTEs6DQo+ID4gLSAgICAgICAgICAgICByZXR1cm4gaW14X2Nsa19z
Y21pX2dldF9yYXRlKElNWDk1X0NMS19VU0RIQzEpOw0KPiA+ICsgICAgICAgICAgICAgcmV0dXJu
IGlteF9jbGtfc2NtaV9nZXRfcmF0ZShTQ01JX0NMSyhVU0RIQzEpKTsNCj4gPiAgICAgICBjYXNl
IE1YQ19FU0RIQzJfQ0xLOg0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIGlteF9jbGtfc2NtaV9n
ZXRfcmF0ZShJTVg5NV9DTEtfVVNESEMyKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBpbXhf
Y2xrX3NjbWlfZ2V0X3JhdGUoU0NNSV9DTEsoVVNESEMyKSk7DQo+ID4gICAgICAgY2FzZSBNWENf
RVNESEMzX0NMSzoNCj4gPiAtICAgICAgICAgICAgIHJldHVybiBpbXhfY2xrX3NjbWlfZ2V0X3Jh
dGUoSU1YOTVfQ0xLX1VTREhDMyk7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gaW14X2Nsa19z
Y21pX2dldF9yYXRlKFNDTUlfQ0xLKFVTREhDMykpOw0KPiA+ICAgICAgIGNhc2UgTVhDX1VBUlRf
Q0xLOg0KPiA+IC0gICAgICAgICAgICAgcmV0dXJuIGlteF9jbGtfc2NtaV9nZXRfcmF0ZShJTVg5
NV9DTEtfTFBVQVJUMSk7DQo+ID4gKyAgICAgICAgICAgICByZXR1cm4gaW14X2Nsa19zY21pX2dl
dF9yYXRlKFNDTUlfQ0xLKExQVUFSVDEpKTsNCj4gPiAgICAgICBjYXNlIE1YQ19GTEVYU1BJX0NM
SzoNCj4gPiAtICAgICAgICAgICAgIHJldHVybiBpbXhfY2xrX3NjbWlfZ2V0X3JhdGUoSU1YOTVf
Q0xLX0ZMRVhTUEkxKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBpbXhfY2xrX3NjbWlfZ2V0
X3JhdGUoU0NNSV9DTEsoRkxFWFNQSTEpKTsNCj4gPiAgICAgICBkZWZhdWx0Og0KPiA+ICAgICAg
ICAgICAgICAgcmV0dXJuIC0xOw0KPiA+ICAgICAgIH07DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtaW14L2lteDkvc2NtaS9jb21tb24uaA0KPiA+IGIvYXJjaC9hcm0vbWFjaC1pbXgv
aW14OS9zY21pL2NvbW1vbi5oDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAw
MDAwMDAwMDAwMC4uZGYyNmVjZmYzZTQNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJj
aC9hcm0vbWFjaC1pbXgvaW14OS9zY21pL2NvbW1vbi5oDQo+ID4gQEAgLTAsMCArMSw0MSBAQA0K
PiA+ICsvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCsgKi8NCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IDIwMjUgTlhQDQo+ID4gKyAqLw0KPiA+ICsNCj4gPiArI2lmbmRlZiBf
U0NNSV9DTE9DS19DT01NT05fSF8NCj4gPiArI2RlZmluZSBfU0NNSV9DTE9DS19DT01NT05fSF8N
Cj4gPiArDQo+DQo+ID4gKyNpZmRlZiBDT05GSUdfSU1YOTQNCj4gPiArI2RlZmluZSBJTVhfUExB
VCA5NA0KPiA+ICsjaW5jbHVkZSA8Li4vZHRzL3Vwc3RyZWFtL3NyYy9hcm02NC9mcmVlc2NhbGUv
aW14OTQtY2xvY2suaD4NCj4gPiArI2luY2x1ZGUgPC4uL2R0cy91cHN0cmVhbS9zcmMvYXJtNjQv
ZnJlZXNjYWxlL2lteDk0LXBvd2VyLmg+DQo+ID4gKw0KPiA+ICsjZGVmaW5lIElNWDk0X0NMS19G
TEVYU1BJMSBJTVg5NF9DTEtfWFNQSTEgI2VuZGlmDQo+ID4gKw0KPiA+ICsjaWZkZWYgQ09ORklH
X0lNWDk1DQo+ID4gKyNkZWZpbmUgSU1YX1BMQVQgOTUNCj4gPiArI2luY2x1ZGUgPC4uL2R0cy91
cHN0cmVhbS9zcmMvYXJtNjQvZnJlZXNjYWxlL2lteDk1LWNsb2NrLmg+DQo+ID4gKyNpbmNsdWRl
IDwuLi9kdHMvdXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVzY2FsZS9pbXg5NS1wb3dlci5oPg0KPiA+
ICsNCj4gPiArI2RlZmluZSBJTVg5NV9QRF9NNzAgSU1YOTVfUERfTTcNCj4gPiArI2VuZGlmDQo+
DQo+IEFnYWluIHRoaXMgd2VpcmQgaW5jbHVkZSByZWxhdGl2ZS1nbG9iYWwgcGF0aC4uLiBub3Qg
Z29vZC4NCj4NCj4gSSBkb24ndCBrbm93IHdoYXQgaXQgc2hvdWxkIGJlLCBzb3JyeS4gSXQgaXMg
ZnJhZ2lsZSBhbmQgd2Ugc2hvdWxkIGRvIHNvbWV0aGluZw0KPiBiZXR0ZXIuDQo+DQoNClRoZXNl
IGZpbGVzIGFyZSBkZXJpdmVkIGZyb20gdGhlIExpbnV4IHNvdXJjZSBjb2RlLg0KDQpCZXN0IFJl
Z2FyZHMsDQpBbGljZSBHdW8NCg==
