Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A571DC02198
	for <u-boot@archiver.kernel.org>; Fri, 14 Feb 2025 07:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D257C806FE;
	Fri, 14 Feb 2025 08:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Fb1e8tvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26238806FE; Fri, 14 Feb 2025 08:05:53 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0F0480077
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 08:05:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNRRgjTuq8Df4x8bpG3yOW0EDBQ2qNxWLBqMJKIz7ZdRNBv+YpKzUv+k94A1jYXlbHMViY2tsGhWlrL8tKHtwUgxIwJuS9mKqMdaKgrqHycpYUR5/g8vOBrVu/LL+H4wnh3yAzwy/U8Hao5fQZlLeNAybP54Ty0gJ1myOciXLS2VbKRU91FXbvOHnWXZOWkSdDNVHSnMd9N4SkCAaFCXIjE+Wz7BRwqya44p5wXNkfbofWdMsGPL6Vc3HdN1c+jgBkVCNhRDxgN3/S3GFBkoeKXwiJSF9hsZrA8AITjnB9uSk/TS35vjLCb+7BwvgOH1JeGVM+739zDbPujPvJt0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6qaELJuD/z/nIR6dFqweUbtaMqbiKV1wiIYmX5DfvpQ=;
 b=cKpW5Y4GeRASUv41fETRjwSP3E9utLvWFEYTqleia3sSeQrGu2peqL+J9rlR7apy8FFXx5TZhLhFqYN50qC+8qDwSw7elW03HezZNbONJPDd16bwqkLbWO1KspoQ73KbhdOYvtOJDKPTduOv/QR3UewwE9euduSvZlUXQWrTtwHX6oHaSBr9N5y6f+ppm3hWwN7kTs8Yi0uR7oAopb4akUvR8FTS7gEiQ7/GNg/AD8poz5fCJ1pO0a9c1PQFKRRFQ318WydqKvCCWnbGf/yaW7sImzNvrm0kNliClf2S4Yef+4Yg+a9DPUJplGxbR1ERSA9Mf/qCD1q+KjMZE4h2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qaELJuD/z/nIR6dFqweUbtaMqbiKV1wiIYmX5DfvpQ=;
 b=Fb1e8tvFDwgidIB35llDIa3rbp5mhue6Q0/6iZ8w58q6rEOk/ycjPF5ZUJukWkA+DKr2t/FMTKUpVtSxY0sMoitBO7xstdRgPT79yEwR1DV4nKQuzOR2XnNWwFD40iFtqK5TeO8unRA7aqG2SsFkvY/FJnS1c7me1GSEUx9ol2AlShuFH+R4ni4/ibAm9nqVdPp9Bk4PH8J+kXM/ahdQJDdO0BzpEC2RsSA40amxaXeeAyUF8wUWpc4UYiGKUwWE0OiAVzbwG6D/qwy5cciFJkF97Z48GMLizBN2WShdZXrOjDo6YHd1u3QxxUJjm8MHtHfwyyR4o+iasgFX1fRS3g==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by GV2P195MB2091.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Fri, 14 Feb
 2025 07:05:47 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%5]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 07:05:47 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "alpernebiyasak@gmail.com" <alpernebiyasak@gmail.com>, Benjamin Hahn
 <B.Hahn@phytec.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Yashwanth Varakala
 <Y.Varakala@phytec.de>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Teresa Remmet
 <T.Remmet@phytec.de>
Subject: Re: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Topic: [PATCH RFC 6/6] binman: doc: update Optional entries
Thread-Index: AQHbcjjLfXNkb9lhtEeZVLV5ci3/5bNAlVuAgARWDACAAG+WgIABHk4A
Date: Fri, 14 Feb 2025 07:05:46 +0000
Message-ID: <d3bfaf2fda01b1ace77d3335028bb5adcf536197.camel@phytec.de>
References: <20250129-binman_faked_optional-v1-0-a4534bc67cbb@phytec.de>
 <20250129-binman_faked_optional-v1-6-a4534bc67cbb@phytec.de>
 <CAFLszTgFvp_YYHZ5GzvZAfLmWeGmoTW5_vhM88ebd7RoA3Mo=g@mail.gmail.com>
 <54732a43eeea4e18829a0c1d561110d9de07e286.camel@phytec.de>
 <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
In-Reply-To: <CAFLszTik+WRQUb8++nvZxdNPeipeOCyFwMF+WaVJZ95-peHY9Q@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|GV2P195MB2091:EE_
x-ms-office365-filtering-correlation-id: 8a4ceeb3-ca00-4bae-e6fd-08dd4cc6019a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NkgrOWIvL2w1eHUrZlZ6Nk1SNzdhVE1OcDVwNE5QcHdJaWs2MTlDUlhGY0xk?=
 =?utf-8?B?NkMxbUJXWW4wUEMvd3dKR3ZpSnVLKzZCc3Rrb25pekVGNm1NVzBIWnQvS2RX?=
 =?utf-8?B?YS8weTJZMFAxQTJIN1l3NlAvTi9YODB5ckthZTVIMzRnYzI2bFU4RDBxMWc5?=
 =?utf-8?B?UFk4RktaTnA5cWVSdVdrQi9mUUJibDVOU1BNYWc5K3A3L2RYeU0xemtjeGl2?=
 =?utf-8?B?MXhPeHFaeDlGcFdheWVvVkpqM0ViSlZyQmJHVkhzKy83NzUzdFRRcVBWcldK?=
 =?utf-8?B?RnphdGRsRWYwaEVpaXhvOTRlNkVPVEZUT1R4aEhYd3FHN3ZVREhMa0RLRkhw?=
 =?utf-8?B?RVpkdTVUZ3dtQkR1NVpLenpiNE1TR3MvT2tKV0s2akpNTktjaFAxRkU5NmxD?=
 =?utf-8?B?aEtVRTFxNmc5dkxoOW9wbnRoUXVIUFpRVWxrSzhwSG8yWm1scjhMWFlEZFRH?=
 =?utf-8?B?bGoxM2xlSmVEcm04RHZ3SUpGeG1CZ2VGOXQyTmppRzMwaWx1QUNVVytPSUNG?=
 =?utf-8?B?RTdJSHpQSnpKUGNEeGdGcjhLVTQ2UzRQaG5oUU5aR2JKRTVidXZoZDJ5V0c2?=
 =?utf-8?B?RWJweUlORW11ZVFTZ0N3WDRuZlFwblZBcW0wR3I1SHdsMDlrOG80THFUZXMy?=
 =?utf-8?B?OVJ0NzZoQWpCZkJCNTNrWjV4K1NGL0cxaFFVTTJFeGZaZ2pFdmU0VGVMTjVr?=
 =?utf-8?B?OTJ0eXF3YjBlKytnRzI2SXg4aFpzVlBmRGxjcHFSYUFncksxUGZpS0QvZDdk?=
 =?utf-8?B?b3JramNSL016SkVPZ0tNNXVKeWNMTlBGNzZsVzZTSjRva0h0UFQwRVhzZW01?=
 =?utf-8?B?UnViV3lRTHUyQzhUQ1Y4ZFVvaDZtdDhXOEs4eEdlSE9SbmdNanVzYW1JQUZm?=
 =?utf-8?B?U3pzK3EydHhPTFg5TEEvU016NDY2ZTRQSElkODh4NjhpYlV4R05qL0NIU1k5?=
 =?utf-8?B?WFZLaHpaODVoMFlOZHFyditvR1QyL0NGMlBxd0lWQ0pMTlBhdkxvb1hWRUxu?=
 =?utf-8?B?cWIyWGlidWdxTEpqeUhheC9jc0VXQlltK2Q0WTZjdC9JMmtmNWhxMzRmbzUx?=
 =?utf-8?B?MHBuSkczdjF4VVcyNkxGWVVkek5zZkZWU280NENNTFAxVk1tZDJOUXZLajQx?=
 =?utf-8?B?ZWMwYStwMCtndTJFelVCSWNoWG1ja3B5SklNVlBTYkVzQ2lMQnZUVC9BOG5i?=
 =?utf-8?B?ekNnZkdhS2NCSGhpcFA2Y1g2NXNLM1Fmd3lIWUY4UWtYK1d5YUtWQ01EbXNv?=
 =?utf-8?B?WVZiaVdHaVdMSW41a0JNRHVQZ2V1RXVDcWVnZkxXQ1htQTI5UWhmRWJYYkVG?=
 =?utf-8?B?Y1FrNnY5bUx4U1lOaUMrUDlIL3YrMXFRN3JreFdxdjkwUkl3OXRDZ0ZJU3Uw?=
 =?utf-8?B?a3pzRnVoL1dOTVY0RHp0L0FJMUNhdUhKOFJqRzlCcUt1UCtXZ1NJOG5KWi9z?=
 =?utf-8?B?WDc4bEtPVkYwL0VkNHNONkZmUTZZYWJWb1QrQytxM3ZFVUZJZHpkQVRycVFq?=
 =?utf-8?B?aFV4TlEwZEUxdGF1bFZGNUNSWGZRYThya3hVYWN3TUljdk1wRWxPS1p0WEhp?=
 =?utf-8?B?VCtmMDZKRlN6UVFVaXhNTnQydTB6b2lPT0V1YUk5Q1ZDcTV2T29CdFBqUHVZ?=
 =?utf-8?B?VmdXKyt4czJHK01ZVHcwWnBmYnRVWEw2REVyaS90TVJIQm1CZ2x6ZllIM0lv?=
 =?utf-8?B?NVpXendUZkhWUE1aUEk0TTBRckZYS3FQOFh1aE1RVnJ3bEhNVHBDczB1V2Fi?=
 =?utf-8?B?VC9aVDhVRHpVNU5rbGxTaVM5SE9BSG1Wck9qTHdiQjJjYjQrQjBzNVkyYlR1?=
 =?utf-8?B?SXhha3hNNXVhUTF3ekNzVTZkYUpkaWlBZThha3NzUk9qdHY3ZERrV3dRV2tW?=
 =?utf-8?B?clVVbXBPSUQ0VStlTytFN3lBdVJ6dXBscXlKMUpyT0ZWUDJNbzFhYjVUSFRu?=
 =?utf-8?Q?k2k8j+Hg1ResdW2H2abZTvQl8ULsVFoC?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V0crYmNGK2ZoSFhFUkdpRjVGOG1xeklEaWhYa0dzWkRWN1kwUFd4ZzNKUUFB?=
 =?utf-8?B?Z21VbGVXOUxLK1h1NHZJYkVCVmtGYWR3WFU2aDBkUUFIcHdERDNXOEpxc3oy?=
 =?utf-8?B?cFNxR2NNT2RLcE04NHV6N2l2amtYVkxYOWVPSmhXVGFoMGpiOFEreDNoeFZZ?=
 =?utf-8?B?dTJuZFh5Wkd2UjBrbWRFNDFkV2xOSkhpazVKV2xseG42eUFNQzZjdEVhUkpV?=
 =?utf-8?B?RUlyTnREbGtIeFZzR21Qc1UyMjd5RGhuc3BpY2l2Q1FEMEJadGxiSEIzQk1U?=
 =?utf-8?B?Sk5wTFpvWU8ranlIY0hoOGh3aXhWRmZkZTJwelpkZ2pQc09QcElQallQQkZ3?=
 =?utf-8?B?SlpmRWNjay82V1c4R3l3ZytvTGIraWRLV1UzUE1qMFdlVEpsWTArSTNKUVVr?=
 =?utf-8?B?WDNFR3Mwa3RWZHdlWEUzQ0RxNWZub2ZXcllFbmlTSkllZEJyem1za3JDMXJF?=
 =?utf-8?B?VWxZeDFHVUl1WnVLcXdmTXV6N0tmYnlxbnc1T3NDQzZPcVdxUFU2eXoyc1ZU?=
 =?utf-8?B?RTkwNDNmZkpvNTd6VmRjQU1zdnh1U3hIZSsvcnlvYU5SVkZERTVJYTg2MVJq?=
 =?utf-8?B?TnNJV2JqcGY4QThlenhJNFFOY3dNZUtsVEVJRjk3MGZBYUtMRVQ3TmlLb2FI?=
 =?utf-8?B?cFczRmsyY3dHQW1xVnFKNzNkRUZ6VCsyWUsrNU9ZcFloQnd3TjFudWlkU0Zl?=
 =?utf-8?B?ZUROTmFaUUV6RkVXek9RR1RWcDFqOG1ROFlZRnFVRjU2dDF4b0t3MVJjT20z?=
 =?utf-8?B?eXZFUGlhekNVRUFJdlc1eDkrZzRRT055UUFBZzNDeWZtUk5EbUVaZjh2TDBk?=
 =?utf-8?B?RmUwZVdWVk9tZWFyUjFyekM2aGs2bTlIUlVVMGhzeW5nM3FRSnZGR3owdDRP?=
 =?utf-8?B?bkdRVnZ5VzNKNjdraCt0dHVvb29GSG8ycVlXTHNBbzdTN0ZIT3NVeE1nZjV5?=
 =?utf-8?B?TnlDbWpzbkdoTVJGU3drS1gxWGkwUDF0QWNtUTdxZlJjU1FKa0thN3U5a0o5?=
 =?utf-8?B?ZjA4Y056MVY3Y0pSeTl1bnRMS29qL0ltYTZZU2dpUHNWQlRNRnEramhjKzhZ?=
 =?utf-8?B?cDJMN2k1VzVVK0hIOGZZV2UrVktuRXFFdnNWU3V6blhhSVgwKzR6dGFrQk1x?=
 =?utf-8?B?NktpQWd2a1Q1NUNNQWdIYjhmR1FBR1J2MFFuUXM5Z2lQQk1Md3NwOTNIcHkz?=
 =?utf-8?B?Mm12cFlmVUhTOVVBSDVPb09NdW5uY2pEVDJLZ1paK0NvOTVwcTd1bEs5UXd4?=
 =?utf-8?B?UnZZRzUzNDRHdlFLQTRKWkdKbjROZDZnNG5OS0J4R0dGWGpVMTVzQkxabDRK?=
 =?utf-8?B?UXFLWVExN0k0MmlLRFpKUFB4VDdYNU90WlBDU2xIVy9rNUMvQkNZclFqK3Zz?=
 =?utf-8?B?Z201cWlka0RkUmY2ak45QUVPRFVjMVhpQlRHRzNCN1h2S2t3ZnJraFpYUUsr?=
 =?utf-8?B?ZGNvb3dZdzN5NTZtSytGTDJMMUp2aG5IZEF2R1Z4VUJzaFB6RHFLK1RNWG9x?=
 =?utf-8?B?TWtGd2E5Z2JmOFVXc3o4SnJZV2hGQnAzTjdtbVBncElqbjVvUUlJUXdFeDZC?=
 =?utf-8?B?YkthYS9JYzk3cUxKaGVsTkFBb0FST3A5U1RyMDZKZHU3ZWRjUjhrUE5ObU01?=
 =?utf-8?B?S0p5alRqMjVGWjJiN1dVQ200aWg2NTA2R3FRYWxON1ZLWDRwV1NablVwRnJX?=
 =?utf-8?B?dlZVQjl2Ty9VT2srODBWY2o3ZUVSL05ndjBiblFtaGk3QnNvbDFGUHBrTXFl?=
 =?utf-8?B?dGU5ckE2TmdkbUZldHhZUXlqbnJ3SjA5bllvbzFZZ2ZmSjZhL1BFb3NpT3c2?=
 =?utf-8?B?MTBVT096dmc3ZlRzaVJJQ0VhVUd5UFBuUnhBa3VTL0k2czZOQXRhZjJoR1hE?=
 =?utf-8?B?a3I2c0VmbzhUdWozNHF2eHJZL2YxemoxUEJvRFBKeFRYTXhDMTVjampKbmlk?=
 =?utf-8?B?MzdjRFFjVWMyMzR5RWhEcjZ2Q3NsdDNNUTlRNjV5SUNrMnBSb2UxRnZHVGdS?=
 =?utf-8?B?MGZQQzBZL2ZiQTR0SnBnUlJhNDRBcmdVY1orN2ZzdUlHd2dkQ21lcncxRlE5?=
 =?utf-8?B?V0ZtZE5RYU9EY0Q3UE1uTU9UeEdHWElVSmpUcWF0cXFaVVJzZG85aWtIL0Nx?=
 =?utf-8?Q?BxD/qbm+++Ky8onbpEtS0t7Ed?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A05E88705241E46AA48202D45FF7B0C@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4ceeb3-ca00-4bae-e6fd-08dd4cc6019a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2025 07:05:47.0107 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T5cXdN1f7STZj0lMRacU+M7YUCWmciq+KMTEXTB0CPGV+KJRNg9p3OmMbE3Oj/kaP5qg+jLPGS2IjtPVCpNUdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P195MB2091
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

T24gVGh1LCAyMDI1LTAyLTEzIGF0IDA3OjAxIC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGkgWWFubmljLA0KPiANCj4gT24gVGh1LCAxMyBGZWIgMjAyNSBhdCAwMDoyMSwgWWFubmljIE1v
b2cgPFkuTW9vZ0BwaHl0ZWMuZGU+IHdyb3RlOg0KPiA+IA0KPiA+IE9uIE1vbiwgMjAyNS0wMi0x
MCBhdCAwNjowOCAtMDcwMCwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIDI5IEph
biAyMDI1IGF0IDAzOjMwLCBZYW5uaWMgTW9vZyA8eS5tb29nQHBoeXRlYy5kZT4gd3JvdGU6DQo+
ID4gPiA+IA0KPiA+ID4gPiBUaGUgYmlubWFuIGRvY3VtZW50YXRpb24gb2YgT3B0aW9uYWwgZW50
cmllcyBpcyBub3QgYWNjdXJhdGUgaW4gdGhlDQo+ID4gPiA+IHNlbnNlIHRoYXQgaXQgZG9lcyBu
b3QgY292ZXIgYmxvYnMgZW50cnkgdHlwZS4gQXMgdGhpcyBpcyBhbHNvIHRoZSBtb3N0DQo+ID4g
PiA+IHdpZGVseSB1c2VkIHR5cGUgdG8gaGF2ZSB0aGUgb3B0aW9uYWwgZW50cnksIGRvY3VtZW50
IHRoZSBpbnRlcmFjdGlvbg0KPiA+ID4gPiB3aXRoIGZha2luZyBibG9icy4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KPiA+
ID4gPiAtLS0NCj4gPiA+ID4gwqB0b29scy9iaW5tYW4vYmlubWFuLnJzdCB8IDkgKysrKysrKyst
DQo+ID4gPiA+IMKgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAtLWdpdCBhL3Rvb2xzL2Jpbm1hbi9iaW5tYW4ucnN0
IGIvdG9vbHMvYmlubWFuL2Jpbm1hbi5yc3QNCj4gPiA+ID4gaW5kZXggOTkwZmMyOTU3NzAuLjJi
YWZhNmNhNDA4IDEwMDY0NA0KPiA+ID4gPiAtLS0gYS90b29scy9iaW5tYW4vYmlubWFuLnJzdA0K
PiA+ID4gPiArKysgYi90b29scy9iaW5tYW4vYmlubWFuLnJzdA0KPiA+ID4gPiBAQCAtMTE0NSw3
ICsxMTQ1LDE0IEBAIGNhbGxlZCBvbiBhbGwgZW50cmllcy4NCj4gPiA+ID4gwqBJdCBpcyBub3Qg
cG9zc2libGUgZm9yIGFuIGVudHJ5IHRvIG1hcmsgaXRzZWxmIGFic2VudCBhdCBhbnkgb3RoZXIg
cG9pbnQgaW4gdGhlDQo+ID4gPiA+IMKgcHJvY2Vzc2luZy4gSXQgbXVzdCBoYXBwZW4gaW4gdGhl
IE9idGFpbkNvbnRlbnRzKCkgbWV0aG9kLg0KPiA+ID4gPiANCj4gPiA+ID4gLVRoZSBlZmZlY3Qg
aXMgYXMgaWYgdGhlIGVudHJ5IGhhZCBuZXZlciBiZWVuIHByZXNlbnQgYXQgYWxsLCBzaW5jZSB0
aGUgaW1hZ2UNCj4gPiA+ID4gK1RoZSBlZmZlY3QgZGVwZW5kcyBvbiB0aGUgdHlwZSBvZiBlbnRy
eS4NCj4gPiA+ID4gKw0KPiA+ID4gPiArQmxvYnMNCj4gPiA+ID4gK35+fn5+DQo+ID4gPiA+ICtG
b3IgYmxvYnMsIHRoZSBlZmZlY3QgZGVwZW5kcyBvbiB3aGV0aGVyIC0tZmFrZS1leHQtYmxvYnMg
aXMgcGFzc2VkDQo+ID4gPiA+ICt0byBiaW5tYW4uIChUaGlzIGlzIHRoZSBjYXNlIGJ5IGRlZmF1
bHQpDQo+ID4gPiA+ICtJbiBjYXNlIC0tZmFrZS1leHQtYmxvYnMgaXMgc2V0LCBhbnkgbWlzc2lu
ZyBlbnRyaWVzIHdpbGwgYmUgZmFrZWQuDQo+ID4gPiA+ICtJZiBub3Qgc2V0LCBpdCBpcyBhcyBp
ZiB0aGUgZW50cnkgaGFkIG5ldmVyIGJlZW4gcHJlc2VudCBhdCBhbGwsIHNpbmNlIHRoZSBpbWFn
ZQ0KPiA+ID4gPiDCoGlzIHBhY2tlZCB3aXRob3V0IGl0IGFuZCBpdCBkaXNhcHBlYXJzIGZyb20g
dGhlIGxpc3Qgb2YgZW50cmllcy4NCj4gPiA+IA0KPiA+ID4gSSdtIG5vdCBxdWl0ZSBmb2xsb3dp
bmcgdGhpcy4gVGhlIHRleHQgc2VlbXMgT0sgYnV0IHlvdXIgaGVhZGluZw0KPiA+ID4gaW1wbGll
cyB0aGF0IHRoaW5ncyBvdGhlciB0aGFuIGJsb2JzIGNhbiBiZSBmYWtlZC4gQWxsIG9mIHRoaXMN
Cj4gPiA+IGZ1bmN0aW9uYWxpdHkgaXMgb25seSBmb3IgYmxvYnMuDQo+ID4gDQo+ID4gVGhlIGhl
YWRpbmcgaXMgYSBzdWJzZWN0aW9uIG9mICJPcHRpb25hbCBlbnRyaWVzIi4gVG8gbXkga25vd2xl
ZGdlIHRoZSAib3B0aW9uYWwiIHByb3BlcnR5IGlzDQo+ID4gbm90DQo+ID4gbGltaXRlZCB0byBi
bG9icy4gQnV0IGJsb2JzIGdldCBzcGVjaWFsIHRyZWF0bWVudCBpbiByZWdhcmRzIHRvICJvcHRp
b25hbCIgZHVlIHRvIHRoZSAtLWZha2UtDQo+ID4gZXh0LQ0KPiA+IGJsb2JzIG9wdGlvbi4gSGVu
Y2UgdGhlIHN1YnNlY3Rpb24uDQo+ID4gDQo+ID4gV2hhdCB3b3VsZCB5b3UgbGlrZSBtZSB0byBj
aGFuZ2UgdG8gbWFrZSB0aGlzIGNsZWFyZXI/DQo+IA0KPiBPaCBJIHNlZS4gQXJlIHlvdSBzYXlp
bmcgdGhhdCBvcHRpb25hbCBlbnRyaWVzIGVuZCB1cCBpbiB0aGUgaW1hZ2UNCj4gd2hlbiB0aGV5
IGFyZSBmYWtlZCwgZXh0ZXJuYWwgYmxvYnM/IElmIHNvLCB0aGF0IHNlZW1zIGxpa2UgYSBidWcg
dG8NCj4gbWUuDQoNClRvIGNsYXJpZnksIG9wdGlvbmFsIGltYWdlcyBhcmUgZmFrZWQgb25seSB3
aGVuIHRoZXkgYXJlIG1pc3NpbmcuIFNvIGluIGNhc2UgdGhlIGltYWdlIGlzIG1pc3NpbmcsIGEN
CmZha2VkIGltYWdlIGlzIGluZGVlZCBwYWNrYWdlZCBpbnRvIHRoZSBpbWFnZS4NCg0KSGVyZSBp
cyB0aGUgaW1hZ2UgbWFwIGZyb20gYW4gKHBoeWNvcmUtKWlteDhtcCBidWlsZC4NCg0KTWlzc2lu
ZyB0ZWUtb3MgKGZha2VkKToNCg0KSW1hZ2VQb3MgICAgT2Zmc2V0ICAgICAgU2l6ZSAgTmFtZQ0K
MDAwMDAwMDAgIDAwMDAwMDAwICAwMDE1OWUxMCAgaW1hZ2UNCjAwMDAwMDAwICAgMDAwMDAwMDAg
IDAwMTU5ZTEwICBzZWN0aW9uDQpbLi4uXQ0KMDAwNTgwMDAgICAgMDAwNTgwMDAgIDAwMTAxZTEw
ICBmaXQNCjAwMDViMDAwICAgICAwMDAwMzAwMCAgMDAwZTQ5MTAgIHVib290DQowMDA1YjAwMCAg
ICAgIDAwMDAwMDAwICAwMDBlNDkxMCAgYmxvYi1leHQNCjAwMTNmOTEwICAgICAwMDBlNzkxMCAg
MDAwMDg0NTggIGF0Zg0KMDAxM2Y5MTAgICAgICAwMDAwMDAwMCAgMDAwMDg0NTggIGF0Zi1ibG9i
DQowMDE0N2Q2OCAgICAgMDAwZWZkNjggIDAwMDAwMDAwICB0ZWUNCjAwMTQ3ZDY4ICAgICAgMDAw
MDAwMDAgIDAwMDAwMDAwICB0ZWUtb3MNCg0KdGVlLW9zIHByZXNlbnQ6DQoNCkltYWdlUG9zICAg
IE9mZnNldCAgICAgIFNpemUgIE5hbWUNCjAwMDAwMDAwICAwMDAwMDAwMCAgMDAyMmI1YjAgIGlt
YWdlDQowMDAwMDAwMCAgIDAwMDAwMDAwICAwMDIyYjViMCAgc2VjdGlvbg0KWy4uLl0NCjAwMDU4
MDAwICAgIDAwMDU4MDAwICAwMDFkMzViMCAgZml0DQowMDA1YjAwMCAgICAgMDAwMDMwMDAgIDAw
MGU0OTEwICB1Ym9vdA0KMDAwNWIwMDAgICAgICAwMDAwMDAwMCAgMDAwZTQ5MTAgIGJsb2ItZXh0
DQowMDEzZjkxMCAgICAgMDAwZTc5MTAgIDAwMDA4NDU4ICBhdGYNCjAwMTNmOTEwICAgICAgMDAw
MDAwMDAgIDAwMDA4NDU4ICBhdGYtYmxvYg0KMDAxNDdkNjggICAgIDAwMGVmZDY4ICAwMDBkMTdh
MCAgdGVlDQowMDE0N2Q2OCAgICAgIDAwMDAwMDAwICAwMDBkMTdhMCAgdGVlLW9zDQoNCllhbm5p
Yw0KDQo+IA0KPiBSZWdhcmRzLA0KPiBTaW1vbg0KDQo=
