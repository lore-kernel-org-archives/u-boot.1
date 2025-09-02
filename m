Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 129DBCA1007
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 05:58:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3270B83A5D;
	Tue,  2 Sep 2025 07:58:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="muXeiyhX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF23283A5E; Tue,  2 Sep 2025 07:58:54 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20702.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::702])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BEF383443
 for <u-boot@lists.denx.de>; Tue,  2 Sep 2025 07:58:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l8QCzenqcj9NbQEro7bE9utaoNOzywH9dDI7aecmQnmmG0fRT1bOoHJf4TdYkE7RF3Mr/dqE6Vt59iq5TxFVHggo5BBUo8qw56eyzmqjvpKiXTLlmkco08rCMti/B0KUvryofzoE7/P+51I++S+IInPtzVVCMZHH3u96lf6a00Np5rpUNuJtINEuWbdj7m7uMDJpdLJ04uN5v0q7AzzGKwJahuBHqUEBRzEFRQwAWsUnX3IZ2DPVVhUEqCVzQkL6bkmrHtgDlZNgkgzZRcKvQEmLONWctbRA1lioXLR1O7sCFK08j1GCqpWnXNKuRfxAEsMe7WnR3+73wBhvIHD6Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhfD8wGRNESkAg959B4UQRaIaqp7E7VhrJtUDD4k6Hw=;
 b=bfNfoBu56RfR4Mk0FTrYj4CD+UPsI+7bFbigjuUGuNO4FuigDjMPu52z6LEBpoi79/v2uuRG7LER3qB4O8EFQAyoe2WmaVQho5MWUZVld5opOwToOB+CGUbIzSMXkRHbpIHHyR2M/mPt85hntwImTxB/WsBsIK789rM7NX3USVuzU7NhNRgl1HohhZPqbO0aFJWQzLNEeCBVDIHd3OiybkzXVmkMW467ddIrOsPxYaVEVwOAyfTGf9nmk5T8yQ643cyyax/l63u/0vEoCPiTDdGTCtqMEqWZzAKkMixRuAq3FWSCm+TbvupzprO6aKmAY3hmZq65vB5Nqyz9rragww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhfD8wGRNESkAg959B4UQRaIaqp7E7VhrJtUDD4k6Hw=;
 b=muXeiyhXpaw91BKQ8FEwDAU3933Z35XT3yFtkE3CvSBEpja0skK5Ckc6r/FN5bNUzolDjuDIHpSJPplC9bXM1G0Xa2uno+jmuHRD4AtgtA3EvfjI0yTu/dPuJzeRU91ncKM9BdZtM3xUPzL4ESqg2I5ZBtbWeUW8mmzO3XWMZOUHXIQEiCZnygQZGGIBJqaAdOKjR9UZcxRXUijv6ZzVZomn0wA58XV+9LWNNmToP4qEH5MCgG+TQijR6Qhcw1uRNLDWxSpogUBVXFPTRIeJfuk53TPj8Cuk3QTFbmeJQysPDkPRcPp3Mm4oZz26Za2Uen84jLRQdy+/+5+3taCxFA==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by GV2PPFC019BFE50.EURP195.PROD.OUTLOOK.COM (2603:10a6:158:401::8e4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 05:58:47 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::4131:8d3c:f0c6:c414%3]) with mapi id 15.20.9052.019; Tue, 2 Sep 2025
 05:58:47 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, Teresa Remmet <T.Remmet@phytec.de>
CC: "sbabic@nabladev.com" <sbabic@nabladev.com>, "uboot-imx@nxp.com"
 <uboot-imx@nxp.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Wadim Egorov
 <W.Egorov@phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Benjamin
 Hahn <B.Hahn@phytec.de>
Subject: Re: [PATCH v3] Add imx8mp-libra-fpsc board
Thread-Topic: [PATCH v3] Add imx8mp-libra-fpsc board
Thread-Index: AQHcE19XdXRpD9qGKU6t6ZJmp2u1VLR04JcAgAMjkwCAB3JhAA==
Date: Tue, 2 Sep 2025 05:58:47 +0000
Message-ID: <e65abdf445e34866024209616e9448ea992f2041.camel@phytec.de>
References: <20250822-imx8mp-libra-fpsc-v3-1-50ba9cd2d474@phytec.de>
 <2437d9efbf0121ef177f20b084ad19b54a0312f3.camel@phytec.de>
 <CAOMZO5Br+s7HA9e+AXY6qgEhn5RvDkDVEv5xgO4w=cgH+4gZ=A@mail.gmail.com>
In-Reply-To: <CAOMZO5Br+s7HA9e+AXY6qgEhn5RvDkDVEv5xgO4w=cgH+4gZ=A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|GV2PPFC019BFE50:EE_
x-ms-office365-filtering-correlation-id: 1c5332fa-62d4-4179-9cb9-08dde9e5c87c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UStXaTMwaHRWVlJjZ0tMNXJ1dklHSThaM2piY0lIVUh1WVE0b1BjTy9zWjBm?=
 =?utf-8?B?ZUptYUcrQVZZVHkwMDhsbjN0cUMvTVFPbVgwNy9YOUlueWhVTHpNekZjUnRY?=
 =?utf-8?B?Z1F0WWU4bzBLT01YbG9QNGVtNHUxZTFxeE43R0hyM25RQmRuNmd1NDM2QmFH?=
 =?utf-8?B?MzNIWUdvZXBGMHR4S3JsZGhHZ08rWHZPakRrdy9BRDlwWFlxcGVTdmdIWU9j?=
 =?utf-8?B?SW1CYzdZMk9vd2VJODAvOXdIT3VXVVliMnRnTFZmQ0lzNmhoOXRjcThXZXEr?=
 =?utf-8?B?Vkdjai8xb0JzcHU1S0djVnNXeTVzbDQvUkNXVEo4ajNSMVNEWEVmb0MrRGJV?=
 =?utf-8?B?OFFONlJXSVcwU2F5K2ZQdC9rTmwxRDF6ZWxCbVUvMHlTOThWODVwczNTSGE5?=
 =?utf-8?B?VDNPN08vbkl0eUJFT3Q0MGpqWHlDa1lyVGhOemI3eVdwdXhpYzRWaGdRcHdt?=
 =?utf-8?B?YUZ5OEcvemsreWx6aU04UmVzK2dZa2VmOTBPU2V1c2J4UDBRMFN1TnVTWndw?=
 =?utf-8?B?Mi9tempUVmxBYW1LNDBQV2VxdzV1OURCeXRKOWZhdDdHclpMNkFzNnFCaFhV?=
 =?utf-8?B?TEU5ek93YjlpbzlSeFNLWU0ySTdYM2xSbDNzOUVaejMxNFM0MlRLQzBNWjR4?=
 =?utf-8?B?ZmY5Z0liM3hMSksxc3ZMTGxCOUlGU2NPSVFzaGFxcEw5SnJicmNaS3k0cXMr?=
 =?utf-8?B?Vkx4eVkwR0djOWNVdVNQdXNMdnA1OHd6aFNueHFpWmthLzNJSXY4R25rNkEw?=
 =?utf-8?B?T2V2b1l1amNIdFE4M2xVVWl0L0ZDYVdGQVJuYWFTT25hT0xpZGtKb0NXZTdw?=
 =?utf-8?B?ZVVLRjR2M2gvSUZXckYxUHZZTVIvbDFGbE0wSHhVeFBJd1hWUGJ3dnlXaUQ2?=
 =?utf-8?B?UDBPbmI5UGZxYnJUY3ovaDk5Tlc5bjl0emc4T01TcjBwc0tiUGJvNlFJTUZ3?=
 =?utf-8?B?RWRaam1lQmVIazM2YkhMWkdSeGZWOElrR2Z1USs3cEJhcXlRR3R0cUNmMDRO?=
 =?utf-8?B?VmFiTTBDSHhwZ0h6Qzh2Sms4VFF1VlR5STJXcUhNNkpGQ0VCZTk3QngzTVIr?=
 =?utf-8?B?ME8vRklzYndTRVBNR244eFA2TElSV2VTd0FhR0swdENzbXFMaExONncwWjNQ?=
 =?utf-8?B?VHU2MlRDQjVCc01EazZEdWQ0R0QwM3pjb3VkRDhXWmFnVnRsei9jWDdwb0ov?=
 =?utf-8?B?NVN5Tjh3Ukd0em1rMUE0UFBja1daaXhjSTh1cklsWVFlYmVLeGVRN1J3bkNo?=
 =?utf-8?B?T1FHellVMEFRUTA4QU9NQVhMUVBmMWxJYjNLdmxSS2h2V0FnR3BKajZrVnZR?=
 =?utf-8?B?ejVlZkZBcTZwTzhWcEpWTjg0Sklzdzh1Und0d0JlcEFRMWFOcE5LRGFDSTNv?=
 =?utf-8?B?V3dPZjdrVmt6MTFhZXNyMjR4QU5jVWNFeFNnRWZTbkxKNThZd0ZycWthTGMx?=
 =?utf-8?B?TkxpWDltL1doU3gxNDhoWTh6OHNsSUR5Sld1QWd5MGhUY0g4VnRqa2xvekFa?=
 =?utf-8?B?ZlJ5Mms5aUltUUFsTTFJN3g0bTVnOVZ1MmJVUTNWcXZNcXhscHlTeG53OG5y?=
 =?utf-8?B?RnVXTU1CQUw1YWhpS0ErRjlHdlFMVDZTSSt3SlZLNjNybE1QSjdJVjEwSGR5?=
 =?utf-8?B?a0NTSTllQjRod3V2aDdhZ0RJUHVoeUVFaC9kYkZ5M0pPOWpSbVRBck9XK0E1?=
 =?utf-8?B?V2JjZG9Ya0Q2eFhBWFBqVjlPa3Jvbi85aEZNRVUxMjJtNFRBeUpPWVlMNW9j?=
 =?utf-8?B?cXVIVXFldXZMSElGelhjbnV6N3QxN05salJUYUVSL2kyWG9sVU40c0N2MVli?=
 =?utf-8?B?Zk9Qb3pDR244eWNHeHRYZVF1czBYNTE1bFpvZ1M2NEZiUzZUZVlOdHdkUE5i?=
 =?utf-8?B?K1JkZUw5ZnVwWFhVWE51aU1lYVVCaEtXQTcrQWhXNm1iRVFlQkNwMzlpK3BQ?=
 =?utf-8?B?OHk1RDhMT0pacVBtQy9UQ3pqTkVKZ2ZlRjBjM1lPemRZcS92RUozL3IzY1Nr?=
 =?utf-8?B?TVNMSk9xWTVRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nm5DOHB5UHYyd01lTlFRMUtUN3RDTmlRcEJ2K29tYjFsdmt2TGY4aHA0bTVr?=
 =?utf-8?B?cUdQcWM2cEN4aFVUVHlFMmFTd3BiemZhY05obERkMElwbmdXTVFWeVc1MDNR?=
 =?utf-8?B?NFBwcXZ0a2VQd0tiOWVXWDJCRUsxeVFrbkxhYmlJdkhickMrSCtwQkU5SjRX?=
 =?utf-8?B?NVY4OEV0NkYwb1FPSWdycTBJY1ExSW9ZL2VQU3MyK2VsZ3Rsenc4UHNSR3Fr?=
 =?utf-8?B?MkpOeEdhVjgvaG1uaWNvdHk1L0RGZTd1QzdtQ3BHbEhOOTRzeHJyTiszMGh2?=
 =?utf-8?B?cmxDc3g5R3ZOTGtzdHFoTUpzY0h0M05lZEJTTzluRk02dnk1eE5TelFkdTlm?=
 =?utf-8?B?MmF3a0l6Unp6NXZCZ2FaZERkclZtelhLUHMwbjN5Q0VycHZnRE5xcndNZ3h4?=
 =?utf-8?B?SkpnSVB2czM2RTc5ZkNqZTdaZS9rUVJjSWM4bXQ5YmdYbFQzV1hzK0pnZlcv?=
 =?utf-8?B?YS83R3NOd1F2UVdnNkVYMENTY3lhUjhITjdNeVZXMkgrUUR5ZXBTeW5KcXBx?=
 =?utf-8?B?QVVIRDVCVER4N3pRcTNMalJTdlFQK2xScnJCeGhQaS9UUzhPdVFieFFZZ2R4?=
 =?utf-8?B?QWFsWGxPZTBtZzV5OWk4TEVFSUtRSlNON0FRR3Q0YmtKVHFHd0tQSTUxM2oz?=
 =?utf-8?B?QjRVa3RDSEpyaEVybTZpd2k5NjZBekNGNmNGOW9nZDZ2LzRkVDJleTJSdGpH?=
 =?utf-8?B?U1RpUUc5QlFGcWh3azV2QjE4Qy9BbCt5b1FWZFJBK0hJRjRGdDJxQzNTRU4r?=
 =?utf-8?B?eUNKcmtCY2RkcFBLdVBVcENyL3dsenJmRkRnRVpxWVNrRXRJejBTTm0wMWtV?=
 =?utf-8?B?Yy8rSHd2bkhxeXVOcHJaNXY4QlhkUVU1NG5KRkVRUkN3Q2locTZZSS9PY3dC?=
 =?utf-8?B?TlJXOUJjbnZUYlJiSE9GSDF6ekEwMlo3OHdzd2o3WlVyUlNUTjc4OGJENmkw?=
 =?utf-8?B?L09MM0hGcWM2dHdJWGxNY25hc2h2WG1sWkdkdGVkY0RPL0U3SE5zanVUQXV1?=
 =?utf-8?B?d2hNUXhIQ0s3S2loMXk3V1NQVGk3RExEaHI1VHB1OE9oOVR4ajlpV3haZVZE?=
 =?utf-8?B?NC9XVTl1RHhUOHNIVlhyMURjdzU5T21aRi9mQ3E2dFM2dy8yTDVLTEtEQW9X?=
 =?utf-8?B?d2NqbHlNMnM3cSt5Q01hSGZzSk5oRngzZDNWRXcrU1dKTHFYUmhpNXpwV051?=
 =?utf-8?B?WWRlM2RsOG52eFgxczU3U2hqNzVaY2w5QnVVMXArY2ZWQXVsSC9VOGxlNHdx?=
 =?utf-8?B?bEpGek5Ma1Z3UjdkZ1Q3eHFHTyt5U1huK2dmT0ZVaEN2aFdDN1dCRGZGaWd4?=
 =?utf-8?B?d0tmdUwxZ200ZDlvSHJGMS9TNHYzMHhpSVgzVnlMMGsrOURsT2FvSzNJclZn?=
 =?utf-8?B?Mld2R1dUdGd5WWtmMTg0cDU0TnBtdXEyRnBmZWdzQVRHaFYxTE56STFDZVZK?=
 =?utf-8?B?VHlXdzNtZFFUc0w3UmNackdqMjNmL1J4bkVkekxZanQvaGxBdFNEeVpRa3NP?=
 =?utf-8?B?NXRWLys5TkVuU29sSlJuWFB0ZFhPd2F5aS9qQTVXVTJvM0loTm9GQ0N4OE9J?=
 =?utf-8?B?L1NlMjFyczhCZmw0VDJmUXM0bE1qWTAwelF1RjdRNTQzUGtpYXU1VWE1dTJy?=
 =?utf-8?B?SVdYTUxhUjZiN0N2OFErb0RxQWtJcUpmMXNiTVZVVCs4K2hSZUVzbWc5Y3hB?=
 =?utf-8?B?SkszQjdkZzFJeG9uNDRTNGR4cEZDOFZBTFc3WXBlc2VmQjNCS1B0Z2ErZ1VH?=
 =?utf-8?B?US9jTlprc2R2dlBCZmM5NUVnQTBXQ3ZpcjFnYWVSNFFQVUU1MjFodFZrTnRH?=
 =?utf-8?B?TUEyUzJ5RlBvTWNET0c5ZkZ5TjVsVHRYZUNEZ01BSEVyNmR2Ym5oa1FPdnNy?=
 =?utf-8?B?U01DcWdPUmhCQWdKSEdvS0J6MW5UUWtYOUhNaVFFL3BXSk5qVlJORlpqdkhX?=
 =?utf-8?B?bUlUT0phbGVydnhqZ052SDZNdVpKUEVjWGJaaS9aOGh0YStENXV6NHN2Z2E3?=
 =?utf-8?B?VTkvR1dQRHJFQ3orTDNPN0YxWnlFSlBQT0dUWk92dUkrQkcwV3VvWkc0VEZT?=
 =?utf-8?B?QzR0TUpRYlZITHVmUlZpemJXVnFJWi9yaDJ3TzF6eHlGRkZISnU0enVhMDBP?=
 =?utf-8?Q?9Oec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BDF251CC002ED4C80FABA17359B2638@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c5332fa-62d4-4179-9cb9-08dde9e5c87c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 05:58:47.6506 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRU69I03uCBEs44WjscNbHFFDj7eFRfXnCgKMMI83JisqXH8zCC4W9BHlV8+/Vu10BL0hZKOmgJYL2NOwtj2zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PPFC019BFE50
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

QW0gRG9ubmVyc3RhZywgZGVtIDI4LjA4LjIwMjUgdW0gMDk6MTUgLTAzMDAgc2NocmllYiBGYWJp
byBFc3RldmFtOgo+IEhpIFRlcmVzYSwKPiAKPiBPbiBUdWUsIEF1ZyAyNiwgMjAyNSBhdCA5OjE5
4oCvQU0gVGVyZXNhIFJlbW1ldCA8dC5yZW1tZXRAcGh5dGVjLmRlPiB3cm90ZToKPiAKPiA+ID4g
Kwo+ID4gPiArLyogZGRyIHRpbWluZyBjb25maWcgcGFyYW1zICovCj4gPiA+ICtzdHJ1Y3QgZHJh
bV90aW1pbmdfaW5mbyBkcmFtX3RpbWluZyA9IHsKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZGRyY19j
ZmcgPSBkZHJfZGRyY19jZmcsCj4gPiA+ICvCoMKgwqDCoMKgwqAgLmRkcmNfY2ZnX251bSA9IEFS
UkFZX1NJWkUoZGRyX2RkcmNfY2ZnKSwKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZGRycGh5X2NmZyA9
IGRkcl9kZHJwaHlfY2ZnLAo+ID4gPiArwqDCoMKgwqDCoMKgIC5kZHJwaHlfY2ZnX251bSA9IEFS
UkFZX1NJWkUoZGRyX2RkcnBoeV9jZmcpLAo+ID4gPiArwqDCoMKgwqDCoMKgIC5mc3BfbXNnID0g
ZGRyX2RyYW1fZnNwX21zZywKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZnNwX21zZ19udW0gPSBBUlJB
WV9TSVpFKGRkcl9kcmFtX2ZzcF9tc2cpLAo+ID4gPiArwqDCoMKgwqDCoMKgIC5kZHJwaHlfdHJh
aW5lZF9jc3IgPSBkZHJfZGRycGh5X3RyYWluZWRfY3NyLAo+ID4gPiArwqDCoMKgwqDCoMKgIC5k
ZHJwaHlfdHJhaW5lZF9jc3JfbnVtID0gQVJSQVlfU0laRShkZHJfZGRycGh5X3RyYWluZWRfY3Ny
KSwKPiA+ID4gK8KgwqDCoMKgwqDCoCAuZGRycGh5X3BpZSA9IGRkcl9waHlfcGllLAo+ID4gPiAr
wqDCoMKgwqDCoMKgIC5kZHJwaHlfcGllX251bSA9IEFSUkFZX1NJWkUoZGRyX3BoeV9waWUpLAo+
ID4gPiArwqDCoMKgwqDCoMKgIC5mc3BfdGFibGUgPSB7IDQwMDAsIH0sCj4gPiA+ICt9Owo+ID4g
PiArCj4gPiAKPiA+IHBsZWFzZSByZW1vdmUgdGhlIGVtcHR5IGxpbmUgYXQgRU9GLgo+IAo+IFll
cywgdGhpcyBjYXVzZXMgYSB3YXJuaW5nIHdoaWxlIGFwcGx5aW5nIHRoaXMgcGF0Y2guCj4gCj4g
PiA+ICtCdWlsZCBVLUJvb3QKPiA+ID4gK15eXl5eXl5eXl5eXgo+ID4gPiArCj4gPiA+ICsuLiBj
b2RlLWJsb2NrOjogYmFzaAo+ID4gPiArCj4gPiA+ICvCoMKgICQgbWFrZSBmbGFzaC5iaW4KPiA+
IAo+ID4gbG9va3MgbGlrZSB0aGlzIHNob3VsZCBiZSByZW1vdmVkLgo+IAo+IENvcnJlY3QuCj4g
Cj4gPiBUZXJlc2EKPiA+IAo+ID4gCj4gPiA+ICvCoMKgICQgbWFrZSAtaiAkKG5wcm9jKSBcCj4g
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgQ1JPU1NfQ09NUElMRT1hYXJjaDY0LWxpbnV4LWdudS0g
XAo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgIGlteDhtcC1saWJyYS1mcHNjX2RlZmNvbmZpZyBc
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqAgZmxhc2guYmluCj4gCj4gVGhlcmUgaXMgbm8gbmVl
ZCB0byBwYXNzICJmbGFzaC5iaW4iCgpJZiBJIHdhbnQgYSBzaW5nbGUgbWFrZSBjb21tYW5kIEkg
bmVlZCBhbiBleHBsaWNpdCB0YXJnZXQsIHJpZ2h0PwpTaW5nbGUgY29tbWFuZCBpcyBlYXNpZXIg
dG8gY29weSwgYXQgbGVhc3QgdGhhdCdzIHdoYXQgdGhpcyBkb2MgaXMgZGVzaWduZWQgZm9yOwpj
b3B5ICYgcGFzdGUKCj4gCj4gQWZ0ZXIgcnVubmluZzoKPiAKPiBtYWtlwqAgaW14OG1wLWxpYnJh
LWZwc2NfZGVmY29uZmlnCj4gbWFrZQo+IAo+IFRoZSBmbGFzaC5iaW4gd2lsbCBiZSBnZW5lcmF0
ZWQgYXV0b21hdGljYWxseS4KPiAKPiBJJ2xsIHdhaXQgZm9yIHY0LiBUaGFua3MK
