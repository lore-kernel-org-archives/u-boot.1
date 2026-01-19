Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EE6D29C50
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 18:31:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4B238313B;
	Mon, 19 Jan 2026 19:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="24y9QP35";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 270318389A; Mon, 19 Jan 2026 18:12:11 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2E0F8003E
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 18:12:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jamie.Gibbons@microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i6x05SGZjyCeZOQZIpvzBPYrtLTgUaRQEK8mOICLLnvzRW8A1B/j61yi8J2OkSATz99EAFmNjqWGHlay0XFjTev64I6vD3wLTDeigFeASu2irEAPcrphpiH7vc7vSJi9hy3bPUYfycc+WSN0JbcYZJTX5Xdlb2EWem3AMeDcFHQchPM7Bp9VHVdnOCoBViwXMwXl+lD/JmVpzz/mOpV9KJ4feGWzSm2ReJ+L5xqoeTjDFeJ/3Haejg0gVz9gh7EF1MYtQI4vYuPV6JbTPi+GKzn1SgALqNaJtCeWbrY/E1W74hgDBbw123uz+kdDjLfMWkO8GowUhcGMWVvIeJQjHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWFhLCAr0gwikkKEVjoIPBISQm8g3+B5UyJ/iJ/1Ua8=;
 b=c6nuqz0IEp6djHIved97h4i1FEelFGp55CO1gAb9xAY2c50QgwBvQGyOpg8Kiae8znS6p91ukb/O0KDo0BSKFPp/wFlrR5Jj6l6TNh8DY7rWE6vsCSJg7EgzTxm8JBdCx23AwUf0WGNdvoGOKr9lIW4+1Kh7Bixetzd8ue1Tcmybe73H7ev2/7svUthmrm2Yz3TPfMDY8K0fqGZ65Ldm79BdQNeHNE8WjHtrozrjxBiRYAvdcXB4sNe6/3+L3tr+q3/i7BtkxtcwMDYG1qpShQiijlliiwragoobNfGUrbUs9uNq81bss1zv+2CfOWJsta7DD+LUHrP4V+Wa5+L0kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWFhLCAr0gwikkKEVjoIPBISQm8g3+B5UyJ/iJ/1Ua8=;
 b=24y9QP35r1k8iTkatXN0CleWHUny3Bkr2jFsywJEN5osOUHUcnIgn/IVtv+2a0tR2fuGdwZ8EjIHCgcH1k2xwjwm32iOt6n4AKixSmeLfkV6oXf899DucOsW3/3UVMDBmMjQtEH0dCMNBWZXQmT+w3lIBVH+qIkjNXewNON+kdlaclJ0Bz0TUz6hP/SaL4o59PZHNPm6Xe7h3P0tpQmOBL+YOl76BpT+KgQFriR1RQtoaxoMNC91scceFgkhgzXAqlrFJFxqvxFQDixiuoUAq1ZasLhgqKfLMnyQoBabWC/tYulty0VL4Q+NZTj1xI/ry1GJf7nlw8NqTOnyjVrvTA==
Received: from DM4PR11MB6335.namprd11.prod.outlook.com (2603:10b6:8:b7::10) by
 SA1PR11MB5945.namprd11.prod.outlook.com (2603:10b6:806:239::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 17:12:04 +0000
Received: from DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80]) by DM4PR11MB6335.namprd11.prod.outlook.com
 ([fe80::3adb:8c97:94da:80%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:12:04 +0000
From: <Jamie.Gibbons@microchip.com>
To: <marek.vasut@mailbox.org>, <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <Conor.Dooley@microchip.com>,
 <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Topic: [PATCH v2] scripts/dtc: Update to upstream version
 v1.7.2-35-g52f07dcca47c
Thread-Index: AQHchwFkjqXL5NuND0+6jEwP8Ex5sLVU+B6AgAAFeICABMM6AA==
Date: Mon, 19 Jan 2026 17:12:04 +0000
Message-ID: <bb9936a8bafa83fceed86f0805d2340914b52dca.camel@microchip.com>
References: <20251202193310.149861-1-marek.vasut+renesas@mailbox.org>
 <d5d2320f54090420c32207c25b35c881ea1519b4.camel@microchip.com>
 <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
In-Reply-To: <82e5aebe-5792-4a68-b054-7f90dd82e7b3@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6335:EE_|SA1PR11MB5945:EE_
x-ms-office365-filtering-correlation-id: 422e868f-5eb2-4ac6-fe19-08de577dde43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?SVI3TUdDenVIRDZJaXdEc1h6MDNXc1dDZVlScWpIQlE2WlhCcStYU2pJTTc2?=
 =?utf-8?B?bzU4UGNaZFcyY0VkZHZUc09Lc1VDblpybG9MWTMrVnVGeXp2QzNZdXNYRU9X?=
 =?utf-8?B?bk1YTzhjeS9DelVRc3UwYmNXRko1d3MyblRQZkRmVGRHVlMrOG1qUElFTGYx?=
 =?utf-8?B?aFo1MFh0Z29KUk5MMGdCTkpIN1dCUE9BYVQzdWhPcG81WjVncTl3N1o0VTl6?=
 =?utf-8?B?Umw0YlFOYmlySW1JUXUwa2dMa0llSThWR2tKTjhoczJkeDluc1dCMDlmWmFo?=
 =?utf-8?B?QUhUakZIVXRGdFVpOUlaSFBWS0tJRnpRaVNQZTlmR2Y0SWpIOVJTa2Z0Z0lj?=
 =?utf-8?B?KzZWbG1mMGd1eEJ3NlVtUmQ1ZUZNSWRNalQrTGlaMWd2emtwbWNuVHZ0OUFD?=
 =?utf-8?B?dzhiSlk4WjMxMnBaYkJzY1k4czhGbFR1bU8yRjFHRzk0RUl6T1h3bm1yRVpF?=
 =?utf-8?B?ekJSK3FQaUZSdE5ZU2RYSkk5aitiMDlwOE9QWncrZ2JIT1ZQWmJaOEdyUWt1?=
 =?utf-8?B?SnZERWN1Qit1eVM0K0JDcjExWCswRllScS9EeUJ0MG5zc2ZZWDMxUm8zWFdj?=
 =?utf-8?B?c25VdjY1K2lhZFpVY051Z3YvcmVyOTJaZWhxWTNTOHRpcWpYZktYSEZ0bTRG?=
 =?utf-8?B?SFlOdmhzMmFzQ211TXczVTZ3WFZOczdadDdpdVNGS0hOSUgwMDZRZkZqeER2?=
 =?utf-8?B?QWpPRFcreDBtelJwV2hjTWFzRU1oSGJhZlhWZmViaHFpNnZNakdvd2lpZytR?=
 =?utf-8?B?endKMnBHWkNuUk15cUJWOTJoWnNpTXJ6UGgrOHB3Y1AwUFRCTXBQTE16YjZp?=
 =?utf-8?B?bGs1bDFtb3JyRnlBazdMQ01QdVU5RDVzaDl1S0x0YisyRGFwRmU5eUJDazN1?=
 =?utf-8?B?QzBmR1ZUQXVnSHk3cmpRRW1iVlB6emFOK29nVVBveGs1UVVLQXlnc0lBMUoy?=
 =?utf-8?B?czZNOWQ5WG1WZSsvdTVKZmNIZmluamVUTUF4emlJWk9yMlBYT1hvTXgrL1g4?=
 =?utf-8?B?cWZySWttUVMvck43WEVRY041WXY1RWo5eHdrOFBhUEs5RnBZU25QdzJtaVJv?=
 =?utf-8?B?K2ZUOUV1bVVLRm8rUC9wTkNJUzVoSkNtMXBoWi83Wk1pQ0tQWU0rcXpXMnRH?=
 =?utf-8?B?aDlLYkZsci9EUWZLcy9jN1llMU9VYll6Y2dDY2FnejJEOC9EYk9Ib0c1TkNS?=
 =?utf-8?B?YTB2MHY1SXcrUFVVR1BLQnB1TVpueUUxUmNhZytCVmpKbGpTWk1ISFVHYUpx?=
 =?utf-8?B?dS8ySVZIRXFIQjMwaTRWc2VhMENIK1hlcElVc2k1ZDRCZk1ZK2RvOHRJWS91?=
 =?utf-8?B?c1ZvMmJxMk93WW15b1UwaU9rSlpLeGY5UGVDKy83Ti9BMWk3ckREa0EzUUdB?=
 =?utf-8?B?TjNMVHIyaUZodDNpKzEraEY2a3Mra2RLcDRFOXMrZWdlYzMvZ2tEc2dMeHFP?=
 =?utf-8?B?ckVYUU0vRjF2QnNnck5zdzV2OVlWT2RBdTJiUU51ZFhmZWFuZXVEZnVodXZn?=
 =?utf-8?B?VG9LSU4vYStucGRNa0Q1Sy9UYTV4U0g5OXZGNGtXZ2hqMXlJWXJDek5EQkR3?=
 =?utf-8?B?aVpGb3pmeGs1dWNKNDU4TGJETVYrRnVvcmpwTDNYdG8xM0ExUkgxL0g4T3k3?=
 =?utf-8?B?Vkc3STBzY2pRK0lOcjJFMlRWek1Odnpodk1PYXcrVlN0MWxNWnVwMi9Qck1M?=
 =?utf-8?B?Ni9HVGZyNVdJenpPWlkvbXV0YkRjMFVDTW94bEd6Slc4NTdRTi90WkhYSkoz?=
 =?utf-8?B?b0FLb0pkN0xxZEpic2ZVMXdUSTFNMUhldFBYNldCaG1nZWQ0U25xOFZ3dFAy?=
 =?utf-8?B?Q3ZxSjQwR0RNcVhtQVFKeVZhbnJZVk9qMEsrU0srL2tGOFo3TCt2TjEyN0RI?=
 =?utf-8?B?aG1mSkdJd2pjQWpkSWdIVVhLSHVLWTdmK3hPS0taTTdoZUUxRHIwQVl0bTRZ?=
 =?utf-8?B?b0pyMkl0NGcyOVArM2RmWElqQkF2MWpLdnZHZU11Z0VKUFBkUE5paXJubnJ6?=
 =?utf-8?B?bFF3YlJoc2ZmeE96SmtLcHJ6S2wva0NNWnpxWlpFa2VhKy9wZHE4NUlvdmJs?=
 =?utf-8?B?cHIrYVJrYmFTdElvaEVxcFY2VExvZEs5S2lnY2o2SlovNlI5NnVjS1NESENl?=
 =?utf-8?B?MlJiMmEvWWdVNkthZkxrQzR3bC81eHJnY3h6MUt5bW5vTlNLRWhWL1B4RjhE?=
 =?utf-8?Q?ea+4FX8O+AvoZaKtk/S1mTw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB6335.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkVZeHVBbDJjd2ZJSHZhb2hsSVdNUEN0M3VQSGREbEdpbkhQRFBrMlB3aUc1?=
 =?utf-8?B?M1RiZ3hzdHlWU3JWMHdTWjVSOStscURaM0JEQjZ4ZjNzWnVEc2tDUEJJa05r?=
 =?utf-8?B?ZmZJMEExMUErNEozTDc3N2FQWUg2NGRsZ3NLTnJua3VYSXFOUWRvazVMbndQ?=
 =?utf-8?B?eDkrZGNKREVGMVdTaTVWcjJrOWppNE53RXR2OWdtQ0o1MWpuZTN1T05yRmRN?=
 =?utf-8?B?VTN2NUpiQmx6d09BSTRiV0pHNGxJYmNxcFFqZWtXSFFITzZrVlhNa3N1NUZ6?=
 =?utf-8?B?WDdmdFpPVFo1TzBRRDRyMVZNR1VRdlR2VHJTaFhYK3dwemU2MlhwSyt3elNX?=
 =?utf-8?B?RjBwZ2NDc2g4ejFsNyt2Q29GR2sxQjVVbFNGcDVsdmtMaFc3eXhxRVIxdTdZ?=
 =?utf-8?B?MmQ2VFJCNzBzaTlidEd6aWwvUnphcDc4TEk3eEpYamtFZ2UvVCtJUjJiZmVz?=
 =?utf-8?B?TmFaSVI4UTJoS1hEeWx3eHVpMmJra2xUYmRvSEN2bHBpeVdKeDlpYzhTbWRB?=
 =?utf-8?B?Rm8xRElHdmNGNkxCdjF4REtPdC9YV2JWeW9XTlFxUFhoZmtYVzJCbDFLM2s1?=
 =?utf-8?B?RFU0ekl3TTJKNllCcDVSbmN2Rzg4WnJXZUp5OU40aUV3eXNUYkxJTExWSmFV?=
 =?utf-8?B?bGk4MHA0czlCRFV1VnBOK2J1cXhnSUZFTmNVblJDSml6TUx5enRoL29hckdk?=
 =?utf-8?B?ajZ3NXd1QzUxUk1rM0QvUXQwd0UzUzY5RUNHVU1MZk9rMVJTcDlYQ3FGemNZ?=
 =?utf-8?B?a1RWZFN4U3ptQU5oZS9jcVFiN2hZMXVQTWRPb1FYVEg3S3RhaVp0YmVHZW9M?=
 =?utf-8?B?NmhLU2VQdlJ0VXR4MUNIWkQzNzBkRkZJSExOZlRPN1Jib0J1Y3EwNEFUeDNy?=
 =?utf-8?B?SjdVTEdtaXFZck5yY1ZVcy8zNVIxR3BQRnhvOTdLdnB3ZEZnMTdNS2NIbk9D?=
 =?utf-8?B?eVBwTmovREd3aEdRUk5naUc3WDVwUnhoYnUzM3g3Ky83NHhxcFd1T3hZVXBY?=
 =?utf-8?B?VVRTM3NZOUFpbUxhd1JsckVZZFVSK2dMUHFweGtGdmlQZjllY3BFSVJIekhs?=
 =?utf-8?B?TmprNVFndWNVR0ZhNGJhdjU1czRNMU1PVXJ3ZDBXd1ZkdjdXbG1Eekhza0Fw?=
 =?utf-8?B?dUVoekZjVGVvaU5CcC8rQXJsdUxOUTJYZFVoRXpvVTJwcXVoV1dUdGh5OUJy?=
 =?utf-8?B?c1ZHb1dVRW5nbE5DMmw3RUI1dzkzcTRpd0EveVE5dTZBNU1oeHd5NjNDejl3?=
 =?utf-8?B?OTh3endtL3FLQytTWkxFbkdwY05WMkVWZUloMkRrKzJPckg2T0s3b1JDbnZo?=
 =?utf-8?B?NDA4anFRWGo1cWxqeWFFbDRQdU56VDFBaHdMSXVhOVJOOUVLV2xxSVRPdXpF?=
 =?utf-8?B?cTlHZ0NqWklmMjhEVk9uU2dUWGtETERWRXdPNjU2Q3ZaVWoydy80WWFkMVdP?=
 =?utf-8?B?ZE81WnhvaGtPQnVZakZmTGJJWDJjSkhKWnpKZjNtYlJqaVlaSk92cURVMzJy?=
 =?utf-8?B?bnRLQ0RobUZWMDB1ODJpYzJ4VE9BWmxzTzQ3NUtKemtVeUJOcVl3UWZ0WVVm?=
 =?utf-8?B?ZTgvR1ZONHE2cWpucUwwMjl3ODRaSUs0LzdyRzludFBiM2hYZnRYNzhkTTRh?=
 =?utf-8?B?YnYrTjBSRC9oTGZ3WkFLQlUzSWNXeUFGWmVvaktBTVplbDNXQjh1bW5TOFFD?=
 =?utf-8?B?WjZCNTQzVWxpRW1xZ3hzT1hCd1AzdjVKUkJIQmFkY3NqWi9zUFQ0Ly92Vkk0?=
 =?utf-8?B?a1AwRkszcXpreVRPT1BRRVdQVTJCVjkvZE5VN0UzdktiMURua0dUY1IvUkJa?=
 =?utf-8?B?L3dYSXJidi96bC8yMWt5SldSTVBUVklmdWY0dzVONTZ5byt2bWFDaXZic0JJ?=
 =?utf-8?B?RU9jenh4MFZzamQ3MzArZUs5SUZwQ0d6cmhKN3pQVXduVVhwaHBOUHpNRU1m?=
 =?utf-8?B?NHBFbGlMZ2xhakVwbHhGaUFhSVVwYVdWVWFncnUvczV0eWUzamZQWlVEVktv?=
 =?utf-8?B?Y29wUWNOT3NKVnBQVzhHR2ZDZEhucFBhSzFqdkVtRVR2SXVQNTNKRnFyYjQ5?=
 =?utf-8?B?dkpMUnFxRjhUdVRkczJMdzNNS0ZwOGZwcUtmdHNSTDlYb3ZmOHpybStqa2pr?=
 =?utf-8?B?ZWlycjE0bHhlbi9YTjdlb1dHS3Avb2MvRmtLeFVXSDRGUEZWNjVOckhiY3Yr?=
 =?utf-8?B?MjdQbDc1Nk8xS2hWcEdVWHpvdm1Kc2xDV3Rnb1NTdzcxNHJyL0xCaHBhaEcx?=
 =?utf-8?B?bENxRDc2Ui9QUTdmVm0rcEM0Tm9jQjhpT1RFSEpDdHlEZ1VMRWl2N0JaVlRx?=
 =?utf-8?B?aXVyclVaTHk0MFlBMktlT1B3QytBVHFtaFBRSk5KMEpmLzJlQ09ocjdWLyt1?=
 =?utf-8?Q?g5hcC5idZcrDxhRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF6573939A0A894A9E1A28C2ABF16393@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6335.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 422e868f-5eb2-4ac6-fe19-08de577dde43
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2026 17:12:04.4430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6F8kyV9c12pJjfIMvsyG8pv8SGNgGyi/pXtwD+hQsiKsZsQHC5/lzTozosL0dD6ZlWDf6lkwIJGXGtKqfrB9Md8ouQ4S5fYrCj9unYhtFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5945
X-Mailman-Approved-At: Mon, 19 Jan 2026 19:31:33 +0100
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

SGkgTWFyZWssDQoNCk9uIEZyaSwgMjAyNi0wMS0xNiBhdCAxNzozMyArMDEwMCwgTWFyZWsgVmFz
dXQgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBh
dHRhY2htZW50cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4g
T24gMS8xNi8yNiA1OjEzIFBNLCBKYW1pZS5HaWJib25zQG1pY3JvY2hpcC5jb23CoHdyb3RlOg0K
PiA+IEhpIFRvbSwgTWFyZWssDQo+ID4gT24gVHVlLCAyMDI1LTEyLTAyIGF0IDIwOjMyICswMTAw
LCBNYXJlayBWYXN1dCB3cm90ZToNCj4gPiA+IFN5bmNocm9uaXplIGxvY2FsIGNvcHkgb2YgRFRD
IHdpdGggTGludXggNi4xNyAuIFRoaXMgaW5jbHVkZXMgdGhlDQo+ID4gPiBmb2xsb3dpbmcgcGlj
a2VkIGFuZCBzcXVhc2hlZCBjb21taXRzIGZyb20gTGludXgga2VybmVsLiBUaGUNCj4gPiA+IHNx
dWFzaA0KPiA+ID4gd2FzIG5lY2Vzc2FyeSwgc2luY2UgdGhlIERUQyBoZXJlIGNvbnRhaW5zIGNo
YW5nZXMgd2hpY2ggd2VyZQ0KPiA+ID4gYWxzbw0KPiA+ID4gcGFydCBvZiBEVEMgaW4gTGludXgg
YWxyYWVkeSwgYW5kIHRoZSBzcXVhc2ggaGVscGVkIHJlc29sdmUgdGhvc2UNCj4gPiA+IHdpdGhv
dXQgZ29pbmcgYmFjayBhbmQgZm9ydGggd2l0aCB0aGUgY2hhbmdlcy4NCj4gPiA+IA0KPiA+ID4g
VGhlIGZvbGxvd2luZyBjb21taXRzIGZyb20gTGludXggYXJlIHBpY2tlZDoNCj4gPiA+IA0KPiA+
ID4gOGYzMjRjZDcxMmRmNyAjIHNjcmlwdHMvZHRjOiBjb25zb2xpZGF0ZSBpbmNsdWRlIHBhdGgg
b3B0aW9ucyBpbg0KPiA+ID4gTWFrZWZpbGUNCj4gPiA+IGI1YjNkOWI2M2IwZWUgIyBzY3JpcHRz
L2R0YzogQWRkIHlhbWx0cmVlLmMgdG8gZHRjIHNvdXJjZXMNCj4gPiA+IDdkOTdhNzZmMjI2ZDYg
IyBzY3JpcHRzL2R0YzogVXBkYXRlIHRvIHVwc3RyZWFtIHZlcnNpb24gdjEuNC43LQ0KPiA+ID4g
MTQtDQo+ID4gPiBnYzg2ZGE4NGQzMGU0DQo+ID4gPiBlYTZmMjQzYmU3NGU1ICMgc2NyaXB0cy9k
dGM6IFVwZGF0ZSB0byB1cHN0cmVhbSB2ZXJzaW9uIHYxLjQuNy0NCj4gPiA+IDU3LQ0KPiA+ID4g
Z2YyNjdlNjc0ZDE0NQ0KPiA+ID4gMDJkNDM1ZDRlY2NkOCAjIHNjcmlwdHMvZHRjOiBVcGRhdGUg
dG8gdXBzdHJlYW0gdmVyc2lvbiB2MS41LjAtDQo+ID4gPiAyMy0NCj4gPiA+IGc4Nzk2M2VlMjA2
OTMNCj4gPiA+IDZlMzIxYjc2MzczOTYgIyBzY3JpcHRzL2R0YzogVXBkYXRlIHRvIHVwc3RyZWFt
IHZlcnNpb24gdjEuNS4wLQ0KPiA+ID4gMzAtDQo+ID4gPiBnNzAyYzFiNmMwZTczDQo+ID4gPiA5
ZjE5ZWM5MWE3YTM1ICMgc2NyaXB0cy9kdGM6IGR0eF9kaWZmIC0gYWRkIGNvbG9yIG91dHB1dCBz
dXBwb3J0DQo+ID4gPiA4Mjg3ZDY0MmYzOGQxICMgc2NyaXB0cy9kdGM6IFVwZGF0ZSB0byB1cHN0
cmVhbSB2ZXJzaW9uIHYxLjUuMS0NCj4gPiA+IDIyLQ0KPiA+ID4gZ2M0MGFlYjYwYjQ3YQ0KPiA+
ID4gNGM1MmRlZWY5MjI1ZCAjIHNjcmlwdHMvZHRjOiBSZXZlcnQgInlhbWx0cmVlOiBFbnN1cmUg
Y29uc2lzdGVudA0KPiA+ID4gYnJhY2tldGluZyBvZiBwcm9wZXJ0aWVzIHdpdGggcGhhbmRsZXMi
DQo+ID4gPiA1ZDM4MjdlMTQ1MmVkICMgc2NyaXB0cy9kdGM6IFJlbW92ZSB1bnVzZWQgbWFrZWZp
bGUgZnJhZ21lbnRzDQo+ID4gPiA0MGRkMjY2ODg3NjU0ICMgc2NyaXB0cy9kdGM6IFVwZGF0ZSB0
byB1cHN0cmVhbSB2ZXJzaW9uIHYxLjYuMC0yLQ0KPiA+ID4gZzg3YTY1NmFlNWZmOQ0KPiA+ID4g
OGQ0Y2Y2YjZhY2I1OSAjIHNjcmlwdHMvZHRjOiB1c2UgcGtnLWNvbmZpZyB0byBpbmNsdWRlIDx5
YW1sLmg+DQo+ID4gPiBpbg0KPiA+ID4gbm9uLXN0YW5kYXJkIHBhdGgNCj4gPiA+IGI5YmY5YWNl
NWFlOTAgIyBzY3JpcHRzL2R0YzogVXBkYXRlIHRvIHVwc3RyZWFtIHZlcnNpb24gdjEuNi4wLQ0K
PiA+ID4gMTEtDQo+ID4gPiBnOWQ3ODg4Y2JmMTljDQo+ID4gPiA2OWE4ODNiNmY1YWMwICMgc2Ny
aXB0cy9kdGM6IGR0eF9kaWZmIC0gbWFrZSBoZWxwIHRleHQgZm9ybWF0dGluZw0KPiA+ID4gY29u
c2lzdGVudA0KPiA+ID4gOGY4MjkxMDhiOGFlZCAjIHNjcmlwdHMvZHRjOiBvbmx5IGFwcGVuZCB0
byBIT1NUX0VYVFJBQ0ZMQUdTDQo+ID4gPiBpbnN0ZWFkDQo+ID4gPiBvZiBvdmVyd3JpdGluZw0K
PiA+ID4gYjM5YjQzNDJhYzQ5NSAjIHNjcmlwdHMvZHRjOiBVcGRhdGUgdG8gdXBzdHJlYW0gdmVy
c2lvbiB2MS42LjAtDQo+ID4gPiAzMS0NCj4gPiA+IGdjYmNhOTc3ZWExMjENCj4gPiA+IDkzYzY0
MjRjNDg2YjMgIyBzY3JpcHRzOiBkdGM6IEZldGNoIGZkdG92ZXJsYXkuYyBmcm9tIGV4dGVybmFs
DQo+ID4gPiBEVEMNCj4gPiA+IHByb2plY3QNCj4gPiA+IDBkZDU3NGExZDc1YzMgIyBzY3JpcHRz
L2R0YzogVXBkYXRlIHRvIHVwc3RyZWFtIHZlcnNpb24gdjEuNi4wLQ0KPiA+ID4gNTEtDQo+ID4g
PiBnMTgzZGY5ZTljMmI5DQo+ID4gPiBlYzM4YjVkZjhhMjMxICMgc2NyaXB0czogZHRjOiBCdWls
ZCBmZHRvdmVybGF5IHRvb2wNCj4gPiA+IGEwYzhjNDMxNDExZjUgIyBzY3JpcHRzOiBkdGM6IFJl
bW92ZSB0aGUgdW51c2VkIGZkdGR1bXAuYyBmaWxlDQo+ID4gPiBlN2RjNjUzZDRlODkwICMgc2Ny
aXB0cy9kdGM6IEFkZCBtaXNzaW5nIGZkdG92ZXJsYXkgdG8gZ2l0aWdub3JlDQo+ID4gPiBkMmJm
NWQyZTNmMDljICMgc2NyaXB0cy9kdGM6IFVwZGF0ZSB0byB1cHN0cmVhbSB2ZXJzaW9uIHYxLjYu
MS0NCj4gPiA+IDE5LQ0KPiA+ID4gZzBhM2E5ZDM0NDljOA0KPiA+ID4gYTYwODc4ZjU1MzJkMCAj
IHNjcmlwdHMvZHRjOiBkdHhfZGlmZjogcmVtb3ZlIGJyb2tlbiBleGFtcGxlIGZyb20NCj4gPiA+
IGhlbHANCj4gPiA+IHRleHQNCj4gPiA+IDhiNzM5ZDg2NThhOWIgIyBzY3JpcHRzL2R0YzogQ2Fs
bCBwa2ctY29uZmlnIFBPU0lYbHkgY29ycmVjdA0KPiA+ID4gYjZlZWFmYTY3ZGYwMCAjIHNjcmlw
dHMvZHRjOiBVcGRhdGUgdG8gdXBzdHJlYW0gdmVyc2lvbiB2MS42LjEtDQo+ID4gPiA2My0NCj4g
PiA+IGc1NTc3OGEwM2RmNjENCj4gPiA+IGY5NmNjNGM3ODc1ODggIyBzY3JpcHRzL2R0YzogVXBk
YXRlIHRvIHVwc3RyZWFtIHZlcnNpb24gdjEuNi4xLQ0KPiA+ID4gNjYtDQo+ID4gPiBnYWJiZDUy
M2JhZTZlDQo+ID4gPiAwOWFiOWMwOTJlZjJiICMgc2NyaXB0cy9kdGM6IFVwZGF0ZSB0byB1cHN0
cmVhbSB2ZXJzaW9uIHYxLjcuMC0NCj4gPiA+IDkzLQ0KPiA+ID4gZzFkZjdiMDQ3ZmU0Mw0KPiA+
ID4gZGVkOGE1YTQ5OGYyZCAjIHNjcmlwdHMvZHRjOiBVcGRhdGUgdG8gdXBzdHJlYW0gdmVyc2lv
biB2MS43LjAtDQo+ID4gPiA5NS0NCj4gPiA+IGdiY2QwMmI1MjM0MjkNCj4gPiA+IGVlNmZmNmZj
YTdlNzEgIyBzY3JpcHRzL2R0YzogVXBkYXRlIHRvIHVwc3RyZWFtIHZlcnNpb24gdjEuNy4yLQ0K
PiA+ID4gMzUtDQo+ID4gPiBnNTJmMDdkY2NhNDdjDQo+ID4gPiANCj4gPiA+IFRoaXMgYWxzbyBp
bmNsdWRlcyBmb3J3YXJkIHBvcnQgb2YgVS1Cb290IGNvbW1pdA0KPiA+ID4gZThjMmQyNTg0NWM3
ICgibGliZmR0OiBSZXZlcnQgNmRjYjhiYTQgZnJvbSB1cHN0cmVhbSBsaWJmZHQiKQ0KPiA+ID4g
dG8gYXZvaWQgYmluYXJ5IHNpemUgZ3Jvd3RoLg0KPiA+ID4gDQo+ID4gDQo+ID4gRHVyaW5nIHRl
c3RpbmcgSSBkaXNjb3ZlcmVkIHRoZSBmb2xsb3dpbmcgZXJyb3Igb24gTWljcm9jaGlwJ3MNCj4g
PiBQb2xhckZpcmUNCj4gPiBTb0MgSWNpY2xlIGtpdC4gSSBmb3VuZCBpdCBkdXJpbmcgYSBiaXNl
Y3QgYmV0d2VlbiB0aGUgdjIwMjYuMDEgdGFnDQo+ID4gYW5kDQo+ID4gdGhlIG1hc3RlciBicmFu
Y2ggd2hpbGUgbG9va2luZyB0byBzb2x2ZSBhbm90aGVyIGlzc3VlLiBXaXRoIHRoZXNlDQo+ID4g
b3RoZXINCj4gPiBpc3N1ZXMgc29sdmVkIEkgYW0gbGVmdCB3aXRoIHRoaXMgb25lIHN0aWxsIG9u
IG1hc3RlciBhbmQgSSBhbQ0KPiA+IGxvb2tpbmcNCj4gPiBmb3Igc29tZSBoZWxwLg0KPiA+IA0K
PiA+IFRoZSBlcnJvciBpczogZmFpbGVkIG9uIGZkdF9vcGVuX2ludG8gZm9yIERUTywgaS5lLiBv
dmVybGF5DQo+ID4gYXBwbGljYXRpb24NCj4gPiBmZHQgZXJyb3IuIFRoaXMgd2FzIGludHJvZHVj
ZWQgYnkgMDUzNWU0NmQ1NWQgc2NyaXB0cy9kdGM6IFVwZGF0ZQ0KPiA+IHRvDQo+ID4gdXBzdHJl
YW0gdmVyc2lvbiB2MS43LjItMzUtZzUyZjA3ZGNjYTQ3YywgaS5lLiB0aGlzIHBhdGNoLiBQbGVh
c2UNCj4gPiBzZWUNCj4gPiB0aGUgYXR0YWNoZWQgbG9nIHdoaWNoIGluY2x1ZGVzIGEgYHByaW50
ZW52YCBhdHRhY2hlZC4NCj4gRG9lcyB0aGlzIGZpeCB5b3VyIHByb2JsZW0gPw0KPiANCj4gZGlm
ZiAtLWdpdCBhL2Jvb3QvaW1hZ2UtZml0LmMgYi9ib290L2ltYWdlLWZpdC5jDQo+IGluZGV4IDJk
MDQwZTM4ZDk3Li4xMTYzZTgzN2Q3ZSAxMDA2NDQNCj4gLS0tIGEvYm9vdC9pbWFnZS1maXQuYw0K
PiArKysgYi9ib290L2ltYWdlLWZpdC5jDQo+IEBAIC0yNDkxLDcgKzI0OTEsNyBAQCBpbnQgYm9v
dF9nZXRfZmR0X2ZpdChzdHJ1Y3QgYm9vdG1faGVhZGVycw0KPiAqaW1hZ2VzLA0KPiB1bG9uZyBh
ZGRyLA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBvdiA9IG1hcF9zeXNtZW0o
b3Zsb2FkLCBvdmxlbik7DQo+IA0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBv
dmNvcHlsZW4gPSBBTElHTihmZHRfdG90YWxzaXplKG92KSwgU1pfNEspOw0KPiAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBvdmNvcHkgPSBtYWxsb2Mob3Zjb3B5bGVuKTsNCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgb3Zjb3B5ID0gbWVtYWxpZ24oOCwgb3Zjb3B5bGVuKTsN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCFvdmNvcHkpIHsNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHByaW50ZigiZmFp
bGVkIHRvIGR1cGxpY2F0ZSBEVE8gYmVmb3JlDQo+IGFwcGxpY2F0aW9uXG4iKTsNCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZkdF9ub2Zmc2V0ID0g
LUVOT01FTTsNCj4gDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheWVkIHJlc3BvbnNlLiBUaGUgYWJv
dmUgcHJvcG9zZWQgc29sdXRpb24gZGlkIG5vdA0KY2hhbmdlL2ZpeCB0aGUgaXNzdWUuIEFueSBv
dGhlciBzdWdnZXN0aW9ucyB3b3VsZCBiZSBncmVhdGx5DQphcHByZWNpYXRlZC4NCg0KVGhhbmtz
IGFnYWluLA0KSmFtaWUuDQo=
