Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D32CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:53:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C31F84D1E;
	Fri,  8 May 2026 19:53:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=ibm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ibm.com header.i=@ibm.com header.b="PIKP+atk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3772484DAB; Fri,  8 May 2026 19:29:23 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 42E6384D1B
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Daniel.Frink@ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648GRMUO815633
 for <u-boot@lists.denx.de>; Fri, 8 May 2026 17:29:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Fx3Wd/iH7zTJPzD02sL5XS/sIaRJhR
 4hq/Rtq6QSbxQ=; b=PIKP+atkUQneBQa1wt8AnpGkUq9iOMaPSiQeNAy7mgEFhg
 YTFh6rCZtX/RHdvPReghRGjde9l/B1zvs0ijpzvCoQROQLogFStBodmWXUWKL+Bg
 MBPG3swn03ZZaFvHt49w81y15kP88nXqyJJmPP4GflI+Y+HG6O30rxU3Vjwz598b
 8i3SMpuyXa0re8O1/mmLnnrNw9URum0ycWGoBqcpjvSDylcLtGAEBWUq7QefNnFB
 MheCnnoSemtRp2Hdsg90vGmj9a1OGUBRFXLrZeXCNiXhBHzx+qtW7WVX6tTt4Ska
 jVgdLKA1H8zD7yRTke60ZJfWUZGNaG1V1xNLusEA==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1vtfm-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 08 May 2026 17:29:17 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YB22iY0FxJeIOhK6u4tU07eC/B4xmsPaHplNUhDlSuWm2vq8Ku8iLNIz0pFGprUkaDIOGyIc5tbaMPJFMxk9Ao5ojtbhefdz04aL6R0JymyFy1OHAi3tK+V9JuAWyoQSVuhkNB9pFHoeVKNwie1U0mHjgANJAmSZp31G/x0SftokU8nQm0jBWT8tjPIH3IpXosBP0gU+zJrCq8EanAgjR9WIQn0dNK9WjL9UEJXsfTPyS1e6ROoGDIF0W2zmb7bR1g+9e/m9WeZflWUfSbtAhCkQdWKohRgmPDACFFM2/ndrFFO6dQr08HizrfOo9xuqn/bHFEWLaIuLUiHjvpQOlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fx3Wd/iH7zTJPzD02sL5XS/sIaRJhR4hq/Rtq6QSbxQ=;
 b=iNVpV1jkT+/lyZmWOpGXJcr8WfIcWk+ffki6fHpuGpN716v1wObW6I+BDTE11WdKbV3mdF5ky/tbtV4OJkXEeMyKTpaIxMd9RhKe3nNXGbvL7ldHRZeOE1Xb1S0ukTINGlMMsbLQeAA+IkI6gQItbv6VXu60hlblcnjmRxtc68B1wwCGVl/5USWp99x7RDNdIhA+LMuoMSoniiNJCdPQOCx1IOvTHn8hOdp8Hx47Pi0Zr60tGv5q9YOXfKvxCVybO5rGNc39u1uX4vrITrIezWHUmwGA+/7uQMl6vDo/FDuojjo5yVuAmPFxeUdFMK20cZHyLahJRtrkj9i0637RGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from LV8PR15MB6416.namprd15.prod.outlook.com (2603:10b6:408:1eb::13)
 by PH0PR15MB4704.namprd15.prod.outlook.com (2603:10b6:510:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 17:29:04 +0000
Received: from LV8PR15MB6416.namprd15.prod.outlook.com
 ([fe80::c4e:1092:4441:53cb]) by LV8PR15MB6416.namprd15.prod.outlook.com
 ([fe80::c4e:1092:4441:53cb%4]) with mapi id 15.20.9891.019; Fri, 8 May 2026
 17:29:04 +0000
From: Daniel Frink <Daniel.Frink@ibm.com>
To: Peter Robinson <pbrobinson@gmail.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, George Wilson
 <gcwilson@us.ibm.com>, Chris Engel <cjengel@us.ibm.com>, NAYNA JAIN
 <naynjain@ibm.com>
Thread-Topic: [EXTERNAL] Re: RFC: Remote signing support for mkimage
Thread-Index: AQHct77beMUtibAM8UCS7jFnDIT0HLXtBZqAgBeaB4Y=
Date: Fri, 8 May 2026 17:29:04 +0000
Message-ID: <LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2@LV8PR15MB6416.namprd15.prod.outlook.com>
References: <LV8PR15MB6416D60889EA3D73880A85688E4FA@LV8PR15MB6416.namprd15.prod.outlook.com>
 <CALeDE9MMHawwTju8czhSzE19q6PGnOkxg-zcyXUdrsxY+ZFHcg@mail.gmail.com>
In-Reply-To: <CALeDE9MMHawwTju8czhSzE19q6PGnOkxg-zcyXUdrsxY+ZFHcg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-reactions: allow
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR15MB6416:EE_|PH0PR15MB4704:EE_
x-ms-office365-filtering-correlation-id: 0e16aad1-61d2-4f23-a920-08dead274d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|6049299003|38070700021|4053099003|8096899003|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: BVfPj5GHvZlbAiNAbQDTTYcHODEXl2TkGeWDiJjLQ7488y/VfdCNwMweGvuMcZfh/1h5zwb26NfqtyKhpNc2vjuTqVlvlTPwInHyjtrT5btXMUT+EIVjGT1coMfqNM1+YdRJO/B6vAvFTXvOLhpT9Eek4tBZV+JUgCqr3g89AladWNnrbdE0Wxl2OI/mjBK8D5PgwGHtIqRCC9wF08WALj/kDVNnegK8i/2WCZ0o5+vZISp2vFWcQsvJT/WzZ/4mYg7YTXCFVEUl9vy0HB76AfaMwixxT9SSqG7IMnlnNNp4hS4oF2FVe70uoH4OPlvj4RxIJVzshOQ+3fFO6LZdjddkMKydL062PvA9sqAnxrGSROlZcyyYqMxhrq/luuj0+F29P9BX5QpJ3Uweu1SgU0XZ4D8aK/04rX2G1C+aiX1Tgk2sjz2LkC5VF2SIzSxSMTJNSsNiUu9PoI+ykD+1TUkV4KOTHhg3yto9L1oqF+pbF807jVfrGnS/dDhJTfol1dJ/dj0BlG5TXp0yO86Bhiw57QzJfr5K/DTZxgSDmhd5u43OFVhl6zzCk4P++WtVvhrum+SIu92tfidaQLLYVQPnolpwtGFJfz+TC+M2ZF4bn7Cm4UlcV4zk0KTZ4h0xwqH32612SpcbM09POfoLYX171+bENQ9G3yfsD8V2yoixD4PerNH355xml/rE/+uCCo1g1tBjwDtkcN3JelNbDei53CYbVF0dAI+5s1AvOkSC6Jp8pZ0yr+3L4iGclMA/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR15MB6416.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(6049299003)(38070700021)(4053099003)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUpzZXdSRHJRY0ZSazc1a2phNXBvS2lBNjRJOHRlNkhnaDc1QWliNGJiTVB4?=
 =?utf-8?B?SlNvYWVLRmY2N3ErSXNyNjl0L0lMeHhhQ2VMTERmNXFaZFI2WldjSzdaTDA3?=
 =?utf-8?B?eFBKeEM2RGlFdnFxUWE4eUppQXZwc2h0RTZicmJudFczalY3RWh4QlJNRSt6?=
 =?utf-8?B?ME9mdlVIVHhGU1dFM29vT0hDelU0NmUyTjhyVXFEdkxKR015ZEtqWFUwcDVN?=
 =?utf-8?B?SEIwV0syYWxIL2psUlRMcUhzM2lNV2lnQS9NWGw1dXVOZHB4UnVTOVliQURI?=
 =?utf-8?B?ZlpsdWNLM25wNGhnd0EzdXRyZGxnb3Zoc1NlU0RQekI5bVA5RGgxcGhtc2xW?=
 =?utf-8?B?TTFkUkh1YnY4Tkc0ZEl1K1B3amRvY0dmcGVHUVlseUhXU0hlV1ZtQXA5REZU?=
 =?utf-8?B?ZUxQZjM4RXNqWXkxOHg5OG80R01ITytvcUxRU3hDSlBmQTZhbDcyK0pGVnNl?=
 =?utf-8?B?RXY5dkhWYTJ5eUhaR3haU3dkVFlDalVJTGhjU2ZzWlU2bW5SWnJEOS9MeEN4?=
 =?utf-8?B?NGcxdzlpNFFqcFZyOUdYL1ZadTFKdTA4QmRkekErbGNITXJxaEhtU0NoM2Uv?=
 =?utf-8?B?YnFvRjVEb2pEVmNveUFWdkFtbjNGVVovemZ6dkg0V25xVTZVdmZFeWpNN0Ft?=
 =?utf-8?B?Q2duUkFYTlJ5TWc2aEFud1dzUkhua2pCaGZHVHdnUEZTRkEyL2QrdXZTVEI5?=
 =?utf-8?B?TzlXSm44SHBZbzV3ckM0KzNMQTlnTUFIRkN4NFN0eTNjdmhVVkhoRWVDVHdB?=
 =?utf-8?B?VEYxbHlqR1NJVmZINUdYQUYvb0VJTTZPQThYYzRwV2pxVkt6Nk9zQ2pOUUkw?=
 =?utf-8?B?UUl0eG1HdlUzZWd3M1NuMnJxRUJTU3VINGkwZXFmODlvMlFHYWw0VFlMYmd6?=
 =?utf-8?B?VUtkdkN3ZlBDNDJCWXlEbDZvK3NTRll0MjlGemhVUlU4SU5jTEsvS0Y4VVkz?=
 =?utf-8?B?WTRNWFd3WUd5VUg5Q0RHY2VNd0tpZ3hDUXcvYThDZkpRYUZ5SmFIQ3owcU43?=
 =?utf-8?B?RjhvRnUxdFVNM21neStPZUZHQ24wejUvbjhuNUhLeDF5SExqQTM4ZFRPdXlr?=
 =?utf-8?B?QlVyUTl6dW84WnNSRVVHSUhqQWJuOENMZThIcTZqbStXWW9xSkVqcmtQai9w?=
 =?utf-8?B?d2cwWE9lcGdkZ0FxaVFtS083dVRFWFdaOEFrQzhkWGltTFFaZmVHOTBXS1RS?=
 =?utf-8?B?SzZnTmRCSzJ4blZQZTZMR0F4UzRpcEYzRHNVc1VpRDBxRVNNa0ZrV2NMUzdF?=
 =?utf-8?B?cFBibUc5em1xRkhmdVIzNVBUSU9PMmlYRll1b0VKVklaS1pNZ0N6TzVwbnlz?=
 =?utf-8?B?aGk1Q3VKdzMzcEltMnJ6dWJOK3hSZ1hqZFlLQ2pGb3RRWGNsSlJ1S1N5V1Q0?=
 =?utf-8?B?aWFXcVhkOWZHRW82dHlIbHVWK1hMdEZzQWlVbHV2RWg4TStQT2RPNnNCZVJi?=
 =?utf-8?B?RHJLZkdYeDUrRXhBWDJoZTZMUEh5NDI0eTR3N3Qwc29wRnhOVWRaZldYUlpn?=
 =?utf-8?B?RzN4T0MwQ2FXZkZvUit6YVd3QzVrb205cGsrZnFRZHJJY0hVN1NFWksvbENF?=
 =?utf-8?B?dzBkbkM0QkNBYzQ4cWxBa0tIc1p3KzZrTmJQVE5jSzRvdG16dXFPQjBVYkhm?=
 =?utf-8?B?dk40cFFHTkN1bHVwU3UrQWlMZjJLVDhKZzkyRU9CVDU4Mzh3Q2pKTlNMSk9G?=
 =?utf-8?B?L1hXNEZ4d0hMSGppWHNDTXZ3OStZcDRaMEwrYURLZXNRZ3p2T1Bza1gxNHNh?=
 =?utf-8?B?cHQ5U2s1T3BpK29YNnFHdjZobUNBNVRvTGpISUNWa0ZDeDdXd1lLdVFKY3lT?=
 =?utf-8?B?cFJZOWFFNC9kREE2UmZqM2RlSElIWlJ1UkZGMCs0eUZxQnRKQzN6aElHazhB?=
 =?utf-8?B?TmowblpKT1VTRHFKTCtXVjgxdXJwOHM5MWVocXVocmdpdnZnMHhVM0l3R1Fp?=
 =?utf-8?B?SWJLZitDOEVHK3RheUtob0NOdDg0SWlhYTNkUEVVRVVnODlvS2xDVGkrc3Rq?=
 =?utf-8?B?SnJFT3VGYmIxN094eVM0SWFDZm5wcXR3QkhEY0pzQkVyVjRqem5nb1FMTTY5?=
 =?utf-8?B?U3JzSzdVT24zMDJvdEY4SHpVY2JRZmc0azV2MjM3THN1cDQ1L2J0ZVNiYWZv?=
 =?utf-8?B?eUQ3b3dTZExWeERuMnFiK1FST0FnQk1Ja1hTUEQveWErTDh3am90aG16QkRH?=
 =?utf-8?B?b0kvUTdPTEFFMm5aQjZYSnpNR0wrcDJ1V1h6a24wbW9NZzdjVmptRllBeWFN?=
 =?utf-8?B?bWtUZFFBZFpXWDdibWxkN3hTZDdLSjQzUldHbTdIR24xTFJONWtRMy82Y1d3?=
 =?utf-8?B?WWVmd2hoYU5lWWpjV1hGUXhIMS9leUpLN2dLSkNNTWNxVUdrbDBPQT09?=
Content-Type: multipart/mixed;
 boundary="_005_LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2LV8PR15MB6416namp_"
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: XHuaoK/WBCoLqL2/QUIoCHaB0IyC8Aij3ctVtXqPpkTzZgtJtlD23ikaTTFQVO20iHQFxLvnysg7WV7nIblZYpFstjL9dJAlKPa8ncTiDmQwrxsVsCl14GZNUKFItd3nlCskp6Vc78uSJpFe8KtLYsiBlf+3+4akcErDg9fWB5f+qfAuPMdme6XgEMqd0FAC810TIiCNGIIa3/ffGIH8cDotsEVsaByt5H6htrXU/aZy49eyWVJwTIunZnWke7gCfPxCgqH/UwZ4jr8FxWedgo30sZ0uIOZ4lAB5ye96XHLknSfgegFUDF1hfcVk4ZiiJZZXYFaSt0nInoUVW+/ECw==
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR15MB6416.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e16aad1-61d2-4f23-a920-08dead274d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 17:29:04.2669 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fj4mS3QPd8SaE7Xfbt6ztMg1Twa86Lkoglerpdz0wutV10+tD2uIw7VFSuEDtp0cH7S8Vpo2oMvE2JmnrVdoMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4704
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ZieUWvAVlV0l3wyj4BVTsqgUmWTUxKUu
X-Proofpoint-GUID: Et6RB7tf4Ys5pD0Z-jqy0ug2szevJSzL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE3MSBTYWx0ZWRfX2U9BrTQc6/RE
 2r8IQbOthG3zkBdEBf5MWNj5Z5/ATHkWB4PKnJudhA79sWWTLLkNbM+hbyYZFm7FVrSDTIKRvQe
 4HdZwkO8hPhG8EknvRTVCxN5hkFXsYPRkmvhrFfsqVJob4DYZpAsebtnUXpxukb3elkly0Ac9C1
 d/rczSAcGjk1kOo3SC5KFXWBHz6dRvgwtprucF2Q1Xame0c1HQ2KOnUzyy9W0kHVki9HlsMPPRW
 hYhIn6JdjGT5cs2p8gezVkScbwG/F1Bog/qiVFAWWSLIq2BcfhycsN/qabvBld0b7diYblg4ta9
 B7+YORD8Qv18qmXrJxJS2lDwsBZ9y8jXeWMMDLujknXjUmsxQbh95V35Gg06tVAJeY84Zf9AH4d
 p8Mds0DbUTzoLnDkVOanKjYUOZRjZ0I59xzrYKpUy3NwKzSXRrTPArrcsdrMIutdsaFaJ+EcmYa
 iIuc4nxU+27DPtCwfHQ==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fe1d6e cx=c_pps
 a=Y50mrEwtfcpO0Uk6WJhX1Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=Dk6S5pCgqxm7bWreYbIA:9 a=QEXdDO2ut3YA:10
 a=cpA4IKyDwt0qsawltwQA:9 a=4iLpT-yrx2V_YhvK:21 a=_W_S_7VecoQA:10
 a=HjfX-momtkF_p70W0z4A:9 a=WBib5RX8LX0A:10 a=ae7r0Jve0x-xhdGkZ3sA:9
Subject: RE: RFC: Remote signing support for mkimage
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080171
X-Mailman-Approved-At: Fri, 08 May 2026 19:53:08 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

--_005_LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2LV8PR15MB6416namp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgUGV0ZXIgLQ0KDQpUaGFua3MgZm9yIHRoZSByZXNwb25zZSwgc29ycnkgZm9yIHRoZSBkZWxh
eSBpbiBnZXR0aW5nIGJhY2sgdG8geW91Lg0KDQpUbyBjbGFyaWZ5IC0gdGhlIHByb3Bvc2VkIGlu
dGVyZmFjZSBpcyBmdWxseSB0b29saW5nLWFnbm9zdGljLiBJIGFtIG5vdCBwcm9wb3NpbmcgaW50
ZWdyYXRpb24gd2l0aCBhbnkgc3BlY2lmaWMgc2lnbmluZyBBUEkgb3IgbGlicmFyeSwgYnV0IHJh
dGhlciwgYSBtb2RlIHdoZXJlIG1raW1hZ2XigJlzIHNpZGUgb2YgdGhlIHNpZ25pbmcgaXMgbGlt
aXRlZCB0byBjcmVhdGluZyB0aGUgZGlnZXN0cyB0aGF0IG5lZWQgdG8gYmUgc2lnbmVkLCBhbmQg
aW5nZXN0aW5nIHRoZSBzaWduYXR1cmVzIGFmdGVyIHRoZXkgaGF2ZSBiZWVuIGNyZWF0ZWQuDQoN
ClRvIGdvIGludG8gYSBiaXQgbW9yZSBkZXRhaWwsIGhlcmUgYXJlIG15IHRob3VnaHRzIG9uIGhv
dyB0aGlzIHdvdWxkIHdvcmsgZnJvbSBhbiBlbmQtdG8tZW5kIHBlcnNwZWN0aXZlLg0KDQpTdGVw
IDE6IG1raW1hZ2UgLS1lbWl0LWhhc2hlcw0KDQogICoNCm1raW1hZ2UgYnVpbGRzIHRoZSBGSVQg
YXMgYmVmb3JlLCBjb21wdXRlcyB0aGUgZGlnZXN0KHMpIHRoYXQgd291bGQgb3JkaW5hcmlseSBi
ZSBwYXNzZWQgdG8gRVZQX0RpZ2VzdFNpZ25GaW5hbCwgYW5kIGluc3RlYWQgd3JpdGVzIHRoZW0g
YWxvbmcgd2l0aCBzaWduaW5nIG1ldGFkYXRhIHRvIGEgSlNPTiBmaWxlLiBJIGhhdmUgYXR0YWNo
ZWQgYW4gZXhhbXBsZSBvZiB3aGF0IHRoZSBoYXNoIGFuZCBzaWduYXR1cmUgZmlsZXMgY291bGQg
bG9vayBsaWtlLg0KDQpTdGVwIDI6IEV4dGVybmFsIHNpZ25pbmcNCg0KICAqDQpUaGlzIGlzIGxl
ZnQgdG8gdGhlIGNhbGxlciBhbmQgZG9lcyBub3QgcmVxdWlyZSBhbnl0aGluZyBmcm9tIG1raW1h
Z2UuIFRoZSBpbmZvcm1hdGlvbiBnaXZlbiBpbiB0aGUgaGFzaCBmaWxlIHNob3VsZCBiZSB2ZXJ5
IHN0cmFpZ2h0Zm9yd2FyZCBmb3Igc2lnbmVycyB0byBwYXJzZSBhbmQgdXNlIHdpdGggdGhlaXIg
cmVtb3RlIHNpZ25pbmcgc2VydmljZS4gQWZ0ZXIgY29tcGxldGluZyB0aGUgc2lnbmluZywgdGhl
IHNpZ25lcnMgd2lsbCB0aGVuIGNyZWF0ZSBhIEpTT04gZmlsZSBjb250YWluaW5nIGVudHJpZXMg
Y29ycmVzcG9uZGluZyB0byBlYWNoIGVudHJ5IGluIHRoZSBKU09OIGZpbGUgcHJvZHVjZWQgaW4g
c3RlcCAxLg0KDQpTdGVwIDM6IG1raW1hZ2UgLS1pbmplY3Qtc2lnbmF0dXJlcw0KDQogICoNCm1r
aW1hZ2UgcmVhZHMgdGhlIHByb3ZpZGVkIEpTT04gc2lnbmF0dXJlIGZpbGUgYW5kIHdyaXRlcyBl
YWNoIHNpZ25hdHVyZSBpbnRvIGl0cyBjb3JyZWN0IEZJVCBub2RlIGJ5IGxvb2tpbmcgdXAgdGhl
IOKAnGlk4oCdIGZpZWxkIGluIHRoZSBKU09OIGFzIHRoZSBGRFQgbm9kZSBwYXRoLiBPcHRpb25h
bGx5LCBpdCB2YWxpZGF0ZXMgdGhlIHNpZ25hdHVyZXMgaWYgdGhlIHB1YmxpYyBrZXkvY2VydGlm
aWNhdGUgaXMgcHJvdmlkZWQgd2l0aCB0aGUgLUcgb3B0aW9uLg0KDQpBIGNvdXBsZSBtb3JlIGNv
bW1lbnRzOg0KDQogICoNClRoZSBwcm9wb3NlZCBleGNoYW5nZSBmb3JtYXQgaXMgc3RhbmRhcmQg
SlNPTiAtIG5vdGhpbmcgcHJvcHJpZXRhcnkuIEl0IGlzIGp1c3QgYSB0aGluLCBmbGV4aWJsZSBh
ZGFwdGVyIGJldHdlZW4gbWtpbWFnZSBhbmQgd2hhdGV2ZXIgc2lnbmluZyBzZXJ2aWNlIHRoZSBj
YWxsZXIgaGFzIGF2YWlsYWJsZS4NCiAgKg0KTXkgdGhvdWdodCBpcyB0aGF0IGpzb24tYyBjb3Vs
ZCBiZSB1c2VkIHRvIGhhbmRsZSBKU09OIGZpbGUgY3JlYXRpb24gYW5kIHBhcnNpbmcuIEhlcmUg
YXJlIGEgZmV3IHJlYXNvbnMgSSBzZWUganNvbi1jIGFzIGEgcG90ZW50aWFsbHkgYWNjZXB0YWJs
ZSBkZXBlbmRlbmN5IHRvIGFkZDoNCiAgICAgKg0KbWtpbWFnZSBhbHJlYWR5IHJlbGllcyBvbiBP
cGVuU1NMIGFzIGFuIGV4dGVybmFsIGRlcGVuZGVuY3kuIGpzb24tYywgaW4gY29tcGFyaXNvbiwg
aXMgbXVjaCBsaWdodGVyIGFuZCBtdWNoIG1vcmUgbmFycm93bHkgc2NvcGVkLg0KICAgICAqDQpK
U09O4oCZcyBzaW1wbGVyIHN0cnVjdHVyZSBtYWtlcyBwYXJzZXJzIGxlc3MgZXJyb3ItcHJvbmUg
dG8gaW1wbGVtZW50IGNvcnJlY3RseSB0aGFuIGJpbmFyeSBmb3JtYXRzIGxpa2UgQVNOLjENCiAg
ICAgKg0KanNvbi1jIGlzIGFscmVhZHkgd2lkZWx5IHBhY2thZ2VkIGluIG1hbnkgbWFqb3IgZGlz
dHJvcyBhbmQgaXMgYWN0aXZlbHkgbWFpbnRhaW5lZA0KDQpMZXQgbWUga25vdyBpZiB5b3UgaGF2
ZSBhbnkgb3RoZXIgcXVlc3Rpb25zLg0KDQpUaGFua3MsDQpEYW5pZWwgRnJpbmsNCkZpcm13YXJl
IEVuZ2luZWVyIC0gUG93ZXJWTSBTZWN1cml0eQ0KSUJNIFJvY2hlc3RlciwgTU4NCkVtYWlsOiBk
YW5pZWwuZnJpbmtAaWJtLmNvbQ0KRnJvbTogUGV0ZXIgUm9iaW5zb24gPHBicm9iaW5zb25AZ21h
aWwuY29tPg0KRGF0ZTogVGh1cnNkYXksIEFwcmlsIDIzLCAyMDI2IGF0IDExOjAy4oCvQU0NClRv
OiBEYW5pZWwgRnJpbmsgPERhbmllbC5Gcmlua0BpYm0uY29tPg0KQ2M6IHUtYm9vdEBsaXN0cy5k
ZW54LmRlIDx1LWJvb3RAbGlzdHMuZGVueC5kZT47IEdlb3JnZSBXaWxzb24gPGdjd2lsc29uQHVz
LmlibS5jb20+OyBDaHJpcyBFbmdlbCA8Y2plbmdlbEB1cy5pYm0uY29tPjsgTkFZTkEgSkFJTiA8
bmF5bmphaW5AaWJtLmNvbT4NClN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFJGQzogUmVtb3RlIHNp
Z25pbmcgc3VwcG9ydCBmb3IgbWtpbWFnZQ0KDQpIaSBEYW5pZWwsDQoNCj4gSSB3YW50ZWQgdG8g
Y2hlY2sgd2hldGhlciBhIHBhdGNoIEknZCBsaWtlIHRvIHN1Ym1pdCB0byBta2ltYWdlIHRvIGJl
dHRlciBzdXBwb3J0IHJlbW90ZSBzZWN1cmUgc2lnbmluZyBzZXJ2ZXJzIHdvdWxkIGJlIGFjY2Vw
dGFibGUgZm9yIHVwc3RyZWFtLg0KPg0KPiBDdXJyZW50bHksIHdlIHN1cHBvcnQgdGhpcyBjYXBh
YmlsaXR5IHZpYSBhIGN1c3RvbSBQS0NTIzExIG1vZHVsZSB2aWEgYW4gT3BlblNTTCBlbmdpbmUu
IFRoZSBtaWdyYXRpb24gdG8gT3BlblNTTCAzIChhbmQgdGhlIG5lZWQgdG8gdXBncmFkZSBvdXIg
bGlicDExIGRlcGVuZGVuY3kpIGlzIGdvaW5nIHRvIGZvcmNlIG1ham9yIGNoYW5nZXMgb24gb3Vy
IGVuZCwgYXMgbmV3ZXIgcmVsZWFzZXMgb2YgbGlicDExIG5vIGxvbmdlciByZWxpYWJseSBzdXBw
b3J0IHNpZ25pbmcgd2l0aCBvdXIgT3BlblNTTCBlbmdpbmUvY3VzdG9tIFBLQ1MjMTEgbW9kdWxl
LiBUaGUgbGlicDExIG1haW50YWluZXJzIGhhdmUgZXhwbGljaXRseSBzdGF0ZWQgdGhleSBvbmx5
IHN1cHBvcnQgT3BlblNTTCBlbmdpbmVzIG9uIGEgYmVzdC1lZmZvcnQgYmFzaXMuDQo+DQo+IEl0
IHNlZW1zIHRvIG1lIHRoYXQgdGhlIGlkZWFsIHNvbHV0aW9uIHdvdWxkIGJlIHN1cHBvcnQgZm9y
IGEgMy1zdGVwIHNpZ25pbmcgZmxvdyBpbiBta2ltYWdlOg0KPg0KPiAxLiBta2ltYWdlIC0tZW1p
dC1oYXNoZXMg4oCUIGVtaXRzIGFsbCBoYXNoZXMgdGhhdCBuZWVkIHRvIGJlIHNpZ25lZA0KPiAy
LiBFeHRlcm5hbCBzaWduaW5nIHRvb2xpbmcgcHJvZHVjZXMgc2lnbmF0dXJlcw0KPiAzLiBta2lt
YWdlIC0taW5qZWN0LXNpZ25hdHVyZXMg4oCUIHNpZ25hdHVyZXMgZm9yIGVhY2ggaGFzaCBhcmUg
cHJvdmlkZWQsIHZhbGlkYXRlZCBhZ2FpbnN0IGEgcHJvdmlkZWQgcHVibGljIGtleSwgYW5kIGlu
amVjdGVkIGJhY2sgaW50byB0aGUgaW1hZ2UNCj4NCj4gV2UncmUgYXdhcmUgdGhlIE9wZW5TU0wg
cHJvdmlkZXIgc3lzdGVtIGlzIGEgcG90ZW50aWFsIHVwbGlmdCBwYXRoLCBidXQgd2UgYmVsaWV2
ZSBhIHRvb2xpbmctYWdub3N0aWMgc2lnbmluZyBpbnRlcmZhY2Ugd291bGQgYmUgbW9yZSBhY2Nl
c3NpYmxlIHRvIG9yZ2FuaXphdGlvbnMgd2l0aCBkaXZlcnNlIHNpZ25pbmcgaW5mcmFzdHJ1Y3R1
cmUsIGF2b2lkaW5nIHRoZSBuZWVkIHRvIGltcGxlbWVudCBhbmQgbWFpbnRhaW4gY3VzdG9tIE9w
ZW5TU0wgcGx1Z2luIGNvZGUgZW50aXJlbHkuIFdlJ2QgYWxzbyBwcmVmZXIgbm90IHRvIHJlc29y
dCB0byB3b3JrYXJvdW5kcyBzdWNoIGFzIHNpZ25pbmcgd2l0aCBhIHRocm93YXdheSBrZXkgYW5k
IG1hbnVhbGx5IGV4dHJhY3RpbmcvcmUtaW5qZWN0aW5nIHNpZ25hdHVyZXMuDQo+DQo+IElmIHRo
aXMgZGlyZWN0aW9uIHNlZW1zIGFjY2VwdGFibGUsIG9yIGlmIHlvdSdyZSBvcGVuIHRvIHRoZSBp
ZGVhIGJ1dCBoYXZlIGNvbmNlcm5zIGFib3V0IHRoZSBhcHByb2FjaCwgSSdkIHdlbGNvbWUgeW91
ciBmZWVkYmFjayBiZWZvcmUgaW52ZXN0aW5nIHRpbWUgaW4gYSBmdWxsIHBhdGNoLg0KDQpJIHRo
aW5rIHRoZSBhYmlsaXR5IHRvIGRvIHJlbW90ZSBzaWduaW5nIGZ1bmN0aW9uYWxpdHkgd291bGQg
YmUgZmluZS4NCkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBnbyBpbnRvIGEgYml0IG1vcmUgZGV0YWls
cyBvZiB3aGF0IHlvdSdyZQ0KdGhpbmtpbmcgaGVyZSwgaXMgdGhlcmUgb3BlbiBzdGFuZGFyZHMv
QVBJcyBmb3IgdGhpcyBzb3J0IG9mDQppbnRlZ3JhdGlvbj8gTW9zdCBvZiB3aGF0IEknbSBhd2Fy
ZSBvZiwgYW5kIGl0J3MgYmVlbiBzb21lIHRpbWUgc2luY2UNCkkgbG9va2VkLCB3YXMgZWl0aGVy
IHVzaW5nIFBLQ1MgaW50ZXJmYWNlcyBvciBwcm9wcmlldGFyeQ0KQVBJcy9saWJyYXJpZXMsIHRo
ZSBsYXRlciBJTU8gd291bGQgbm90IGJlIGFwcHJvcHJpYXRlLg0KDQpSZWdhcmRzLA0KUGV0ZXIN
Cg==

--_005_LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2LV8PR15MB6416namp_
Content-Type: application/json; name="example-signatures.json"
Content-Description: example-signatures.json
Content-Disposition: attachment; filename="example-signatures.json";
	size=1173; creation-date="Fri, 08 May 2026 17:23:09 GMT";
	modification-date="Fri, 08 May 2026 17:23:09 GMT"
Content-Transfer-Encoding: base64

WwogIHsKICAgICJpZCI6ICIvY29uZmlndXJhdGlvbnMvY29uZi0xL3NpZ25hdHVyZS0xIiwKICAg
ICJ2YWx1ZSI6ICJjNjMwYTUxMGVlMjQwODJmOGYxNzMyN2Y4MWRmMGMyZThjMDQ2MmNhMWZiYzIy
NjYzNTMxNjJkM2ZiZGFjMGQ4NGI4ODkxMDhhZjNhODlkNjM1MWJkNTEzYzViYzEwODVhMWJiYzQy
MjQ1MGM5YWM5MGM1ZGFkNDY2Zjc2NTBiZGIxMWJjZTZhMmYxZmY4ZDA4OGE5MWMwYzM0YWI2Y2Rk
MGVjZDMyOWUwZGE5MTkxNmNkNmI4NDAxNTljYThkYWVkNjJmYzBkNWIyMGNlZDhkODYyYTJmMDg3
NWRkN2M0NDc3Y2Q1OTgyZjdmMzY3NGNjYjJlODE0N2NiMjNlNDc5MDhkMzljMGYwYTY3MjhlMDZk
YTIyOWRlZDNmMzQ3OTAyMzNlNmVlMzU3OTEyM2M3MTczOWIzN2VhNWZlMTZjYTU1NmM3Y2NjY2Iz
OTE5YzRhZGNjNWYzNDIxYTgzZGFhYTk5YmMyMjExNjE1ZWI4NzU5Njc1MDM5YWUxODJjZDkzOGM4
ZjUwOTc1ZjMyNDcxZTE5YTkyZTVmMGJkZjEzMTQ1NTdiMjZlZDhhNWQ1YmFkZWNiNzk0MmJiYzk1
N2JkNTVlYjUyZDJiZTE0YWRhZTI0ODFmYjkyMjIwYTk1ZTZhZDRiYTNkNTE5YmM5OGI3YzJmNjAw
YzNmMTUzOGU4OCIKICB9LAogIHsKICAgICJpZCI6ICIvY29uZmlndXJhdGlvbnMvY29uZi0yL3Np
Z25hdHVyZS0xIiwKICAgICJ2YWx1ZSI6ICI0NzcxMDY2MWFjZjFkYTg4NzY4NTBmM2E4YzdlNTFl
NDgwMWNhMmRmOGZjODQ2M2NhMDc3MzhiMWNiY2NlODNjNGE1YjZjOWQxNmZhMDFhYWIxOWMwOTJj
M2VlZDQ3ZDkwODRkMTg2YzA2OGE1OTlmYjZhOTk2Yjg2ZGI2MjhhYTAyOTdhOTY3ODU4NTNhZDdl
OTU3YzNiMTQ4ZmI1OGViODMzMGFmMWMzOTRlYTZiM2Q2N2FlOTU5NTNjMDhiYTU0MGU5NjEyZWEz
MWE1YjZhZTkyMDhiOTcwZWRkMWNlNTFkOGNkMGQ3ZmFjYmFkNTQ4OGQyNDI2NDdiZjQ2NmNlOTdj
YTk3MGFiYjUxOGJkYjllNDczNjIxMGMwZjAyNjNmOGNmMWY4NDVjYTg4MWY2OTUyOGI0M2I5Mzg3
YTY1ZGNkZTFmZDQ0YTNlZTdmNWE0YjUxZmE1NGY0NjY0YjZlOTNmOGE5MjcyYTc1ODYyNzAwZDg4
ZTdiMTI5ZDNlMGFhZDE5MzI1MTBiOTM0ZWU1Nzg4YTQwNmUyMDdmZDE4NDZkY2RhYjBiYmM2NjQz
YTZhNWU3MWNhMGYyNzlmNDFjNzhjODllYzdkMzllYTYxZmI1NDA5MDM3ZGQ3NTA2MDZhY2NkNzVk
YWNmZjg3MzE2ZmQzMzQxMTNiZmJhMWFmNiIKICB9Cl0K

--_005_LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2LV8PR15MB6416namp_
Content-Type: application/json; name="example-hashes.json"
Content-Description: example-hashes.json
Content-Disposition: attachment; filename="example-hashes.json"; size=441;
	creation-date="Fri, 08 May 2026 17:23:10 GMT";
	modification-date="Fri, 08 May 2026 17:23:10 GMT"
Content-Transfer-Encoding: base64

WwogIHsKICAgICJpZCI6ICIvY29uZmlndXJhdGlvbnMvY29uZi0xL3NpZ25hdHVyZS0xIiwKICAg
ICJhbGdvIjogInNoYTI1Nixyc2EyMDQ4IiwKICAgICJrZXluYW1lIjogInJlbGVhc2UiLAogICAg
InBhZGRpbmciOiAicGtjcy0xLjUiLAogICAgImhhc2giOiAiMmRjYzA1YTIyZTJkYTY4YWExODNi
NTU4OTY2NjJmZmQ1YmM2ZGI1NTQ4MjQ0Mjg0N2NiOTQ0MmU1ZTcwYmMzMCIKICB9LAogIHsKICAg
ICJpZCI6ICIvY29uZmlndXJhdGlvbnMvY29uZi0yL3NpZ25hdHVyZS0xIiwKICAgICJhbGdvIjog
InNoYTI1Nixyc2EyMDQ4IiwKICAgICJrZXluYW1lIjogInJlbGVhc2UiLAogICAgInBhZGRpbmci
OiAicGtjcy0xLjUiLAogICAgImhhc2giOiAiMzI3MTNhMWFlNmRlNDA1YWU0Mjk3ZTg3Y2FlOWY2
YTdlMWM3ZDc0NmIzOTg3MGYxZDIyN2YxN2RhYzIwNjUwNCIKICB9Cl0K

--_005_LV8PR15MB641640B8F41A3BBBA138EC5C8E3D2LV8PR15MB6416namp_--
