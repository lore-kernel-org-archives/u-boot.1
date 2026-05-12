Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1A2BCD4855
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 09:04:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7223D80398;
	Tue, 12 May 2026 11:04:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="LHbywRB5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF75580F0E; Tue, 12 May 2026 11:04:15 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 059B7801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 11:04:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f3XAj3Xz3M5bHy6um/W9838IXCkLaE1rhX1I83AOe3W/8aSCPAfBryMnFObJT+W0aNb/jIIitRr3Co+ILS11Hpvh8ccocmNAerPBKtE1EWY2EIWJyRPS5wU2ahJGF19KcsjSwMnN3jFS+tyH+J23VjyyUe6vaa8M24bFCM3SjRQGnHoL0DxME193zOx40vMiQtVV3q6EVfhNmlaRQ/+9ZB5xj4N5EiL/7/7q5ysMv9HHka0zHZIskWS8qa+9nORiLI5gBhPs3M3cbxOF5co38wHfeDEXvSd+Wy/7eMjsRK7dDIyYgVoci9dvc4BhtWUFKXJHqkAF6v/7aK8bHUY5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZEOtjbWMLTfOPPg7IBecL+kevHz6S5STltb5FDsCuow=;
 b=JzS8Vs/D4+xC9NkDWEqO/wX3f2/nnYJQyeT3oMOFzSEWQoQYnoeOtvWOBwdul23Z/xKFpQkdlBjx5Zgodsh8+RqbpKIJ4ecRyLp7qXwiFdQrRHRVfEbH21HkVxCkrGqlgkU+HSM4vw0Lk/OXmjNwsMybsJm+Q0hfzoqYOLRxS6eVi1Lziaob7DjlgZE4fnjYYjkFuFL36XEZpjmbklhsXxO9vEiKvWzD4kLzs18JHoyhRJUtXlvXv3rKTLqDvP2ngjvj0tJWWmkdM11uwqNuSnCHWDJES8dgYU+BVmRRfzEo353G6O+HFfdqp1MBbV/eSw4DrDy3spig9kQQHy5hGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZEOtjbWMLTfOPPg7IBecL+kevHz6S5STltb5FDsCuow=;
 b=LHbywRB5aWWD5vEw42PRugtL/dc9MMYIwsvThz+Y+hblCTW/C2rH9cQxuxrbcKfq3XdhYTaHv71hXsiuAXO+rUGZ8jSz4N9XpEvhGmf/PFSEBsqqr4uWgpi0moR8BpH2qITFe/4tSDN/mq0TjCqtnLAfG4eaboSs1yAAKZjj6be8RcW5Kaej0tdXhUAIHGo7Sco7AR8it/FslrGjQS0jNt9jZ+7G35CRfObA271B4dEz0nn+YO1x2iU3NUqp7o9K5DeogDR+o7sOj8W6IvM0vlHty89DWiFPJBhfGrNzvIX2Tzz6BA+HCkGXcVE7ASpSq8SQ4eanv8reIEOeXMDkwQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 09:04:11 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 09:04:11 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "Alexander.Feilke@ew.tq-group.com" <Alexander.Feilke@ew.tq-group.com>
CC: "trini@konsulko.com" <trini@konsulko.com>, "u-boot@ew.tq-group.com"
 <u-boot@ew.tq-group.com>
Subject: Re: [PATCH v2 5/8] rtc: pcf85063: keep the divider chain in reset
 during set_time
Thread-Topic: [PATCH v2 5/8] rtc: pcf85063: keep the divider chain in reset
 during set_time
Thread-Index: AQHc4T81NfOEwMYybEKemFI5WCz2LrYKGhgA
Date: Tue, 12 May 2026 09:04:10 +0000
Message-ID: <4c047151f8a5113cd5352d5176ae6a0df6310b42.camel@siemens.com>
References: <20260511120917.1017866-1-Alexander.Feilke@ew.tq-group.com>
 <20260511120917.1017866-6-Alexander.Feilke@ew.tq-group.com>
In-Reply-To: <20260511120917.1017866-6-Alexander.Feilke@ew.tq-group.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM7PR10MB3956:EE_
x-ms-office365-filtering-correlation-id: cdb760f4-aec2-4fe1-8eaa-08deb0056ea4
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|55112099003|38070700021|22082099003|18002099003|56012099003|11063799003;
x-microsoft-antispam-message-info: 8/9EZT5NiLQoVHJiFcmW0hZnqT3NHII+ek0K1yYI+yHoqjPT0r6B7IM8mR0oIBIcrFIdTg0MOtbBrJABl2VGqqf0HqqRr38fmldiL5G+OPA/M7H/woN39q7NNBhXZ1K55YUKGeYViGEMf6RmB/o9HBKyzLlePbPpLX2bMQ9su7E5I8ayA6oTlhz/FDEPFhTlvZIHqMGWoD9ZiCcz0FRh0tMwcqAgF36phJ3AAUVmQkgb599ELed3QkFIiv2KDxKSaHw7AvCBIte+1GYHdYJt4A0PWpiOBZTFfuZZAh73cZkA0qiqQGWuiq7cC86R5F4xmWNtX/A6aon3emVPjrP+gL/MHMbMXCO7dGPY+5PP5MiEc9+60mE0kwNg54q5fje5F4Ot0vamjM691Ed4f+ByCOnt3ai9pCO9SQuhvOf9pf0auOI2aI+wpvVzRSlZf+7LGj4bfWM0q3unpg/maKy6a+toxTxWy4/hRDEXxYRsfXMNrootaAhBgkUwnVsYETV+AqXxRLAA8FYP0V6qbOnqz/0/iEdHLImBzR5N8oQie/ezcJu7at9Bg6urm7cEeBRm2Y4Uh+w2JDiaEc0kwDtxPwJcj+ih4zHm5QNJzT620spcEcrLGiAI+9cSie1vw9SHRp1nyYRWLxce1VcFj2XB/gcmjyy+I3ADWtY8l6+zPmhXo9Ce2bJYZwgECEYxaWrRj2oSMuPcCTLUjBEBmH19dg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(55112099003)(38070700021)(22082099003)(18002099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0p2dVROeVJ3aWVJU0YvUnViOW5Ga2xOYk9hbm1wQ1VXQWJ5V3dtMHVWbjQx?=
 =?utf-8?B?SmduWTJic1hReFlKRGJ3L204bmY0MXpsRzJ2VUJBdWpIcmMxVWQ2bWRKUm50?=
 =?utf-8?B?bGxxbTJKU2JCL0tRN3VGNnhORjkzUHZNK3lVL0FiY0pRcjdVZ2ZUZzVqQitX?=
 =?utf-8?B?M0tURmY1VWc3bEZpR0lNRGlpRm1EdmYyNit3WW4zOXo3NVlpOXplbk95UnZZ?=
 =?utf-8?B?YXlFYkhsUjNPcG5iR1lnZVpiU2pManBDaDNSaUJPaDNyd1NjTGZnZ0MvVFFp?=
 =?utf-8?B?MHdhSGFzWS9uT3FKSG54eWVZbXFXdGkvRk1JS3RISk1Ob2ZvV2YxaWUwaEFv?=
 =?utf-8?B?YldnU0ljWjdxK3daZlBuL25PbFpNVm41a3pHTTQ3RzduN3VIaHRBWGhWei9U?=
 =?utf-8?B?ZUplYUlWNm1NZW9HdkxoNzV0cjV6VFNiR05XejArRStLaXUyUDJyZFRPbElB?=
 =?utf-8?B?TEdUd0JXK0R2Q0l6RC9BZENtYWhDd1hqa0tRbUI3R29MYXVGZnZoeGpqRFBQ?=
 =?utf-8?B?ZmV5QXVwRlFWaFlNRFlzUEhybnJPYkh6eUx3T3d3bzU5VkhBTmtHMy9yRlhz?=
 =?utf-8?B?VW5VYzNKaHMyN0dVYTZoYnVCNmpGNEdFZUh3UkR3M1A1OU5xM1dvZnIxdGtL?=
 =?utf-8?B?SEc5MGFJMDZlR21ESDNUSHFHRlRaOW9ocFJqYUpXWXltd2Z6VVJxZnIyL3Fj?=
 =?utf-8?B?Nll1ODljdlplZnRIa2JaZGNpMUN3QW9ibmFTR2pNdmltQ1UwMGt3MDBGMk00?=
 =?utf-8?B?NWVZMDRWcFpFU1U3SVZYNG9HZkdBQ2ZVOStzVDk2TWpYMHRyK2FEZXJLLzRP?=
 =?utf-8?B?NlVQZDB5a1JKcTVKS1lGVzNaeWI5NlVOMXd0dEd4V3NNeWowQzlFRDl4a2Zr?=
 =?utf-8?B?YzJlUUdMSDkxOGJXVHRaZ1FVbW81Zno0YSs0TTR0QmxadjM2c0RuUS9SelZo?=
 =?utf-8?B?YXNSZFJRTHJMQmUvNWp5b2RkRG1jS2ZMa3FUSFE2SVlEVlo3VGg4ZDJvd2ly?=
 =?utf-8?B?MStWN0NzUkRLMlhQN3p5eWxMaEp1T09MZFpab1ZUVFBPNmgxU1o0NitPSWY2?=
 =?utf-8?B?NlBjQlB5TlhrQjhtUjkzTXNqaXd1YndacXhqSkEwVytSNldxc1pDWUJCbHNj?=
 =?utf-8?B?VWNPRDVITFU0TUpYbGVGbk02SlF4RjdabkxZN2JQNlpicE1JYS9jZzU1TFVV?=
 =?utf-8?B?dGFrckR6ckQvK0FGT0Fra2hGNEJmTG1rWHg4M0dlS2NtR3BKbW9oRnFmczE4?=
 =?utf-8?B?RFcxVmdtSTE4REd5S3Z2bkZDU1psdUl1VjVpWWx0OWJ0NjJQT1BUd25WWjdV?=
 =?utf-8?B?dng3V0ZpcWdkMHRHeGZjZGMveTJJRWtpOFhRaExBTmkza3EzQk55VUhtZ2xi?=
 =?utf-8?B?T3FpK3dZZEdkMjc1ZkFhOGE5Y25yZnRuVGJaWHo0WTJkZmFLek9LYlA3Q0Jz?=
 =?utf-8?B?RzZlWEptNnFZSElHVGloUm5ncDJGMEtHUUtoRHVleGdaQkdKb1dRaDBHMlRC?=
 =?utf-8?B?UjJJSjI0QnowblJDKzVUSk9zQ25HTU0weThBakwxVXNKUlRwb3BVL3RXVmVC?=
 =?utf-8?B?anEzUHBnWjFnSjBYbklGQjdLK0diVVBFTGkzcnFPVUtkVWJvT3ZPSThsenVt?=
 =?utf-8?B?QXhKT0RJMHJGcmlwRldpbmZwbDB4MkZpK0t2TTNiSlNPTXVEVEpSc2tUR0dV?=
 =?utf-8?B?S0VZVjR1WlNVbHl1WEdTeDY5SFdwMlFWcklXclpiZnRkNmUrUVBPOENCRG83?=
 =?utf-8?B?YVp6NGpvQjNIQ0RXS2VlK0hnNzZydTAyRUJ1MjVDcFNiak9SVXpMOUlXejEv?=
 =?utf-8?B?Kzk1NnBzUDRtNHFFdERXWXpyWkxteUl1UlVoR3ZUZVRyT2FkRW1BWnpkdCtw?=
 =?utf-8?B?ZFljQ3JPRDNTTnM5enl3dXJLajQ3ZURpYURmSUx4TzBHZnQyUXhyckJSM2dt?=
 =?utf-8?B?V1B5bG15M3pqcFI5b1NsWmoraE1yYzc1TnNKN0E4aDAxV2lSYjdFYzM0VGVh?=
 =?utf-8?B?V29zeGVoTWlzL1c4SVRmVmQ2bDB2N2VBMDdTeE5uWW9walBnd0lkYVdRZHdm?=
 =?utf-8?B?a3Rpc3hoOU1PdWs4R3ViVGZxZ3FueWpNQXRrS0sxWGN1SjdyWkN2Rm83UmtT?=
 =?utf-8?B?QnNuZVJXWHJ1dkZMYXpYS1RQWTJTS1NPV2UvYk1hdmRZdDlmVDUwZzk3VjFY?=
 =?utf-8?B?MGh6cjF1MFM2VFFxU1k1RGR6ekhTd2FPenF6WUNLbjRxTjY5QTVMeWR1Zjla?=
 =?utf-8?B?R2Zjckd3M3dJOVJpbC9VYnQwTWM3OEt0UVFtdjkwWWVVOVlDWGVZMEQ2Zit1?=
 =?utf-8?B?aTRWTGJSVXpOVDB6T0pxcDJvdHk5MXpmSmVtNHZrNnFaMHZYN1h6ZGs1azBz?=
 =?utf-8?Q?2WaWhh8Xb3v1/D3GyDDcZ9uapEuDQVSk6yX6O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4192B43B9B51514C857BFF9D67A382BD@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb760f4-aec2-4fe1-8eaa-08deb0056ea4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 09:04:10.9930 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/z2pUw16ic9A4ZQIVW9zid3XicwIjP2MrZxlYvHaO9WdSwpBTmMSXDSLtGqmnJ1XbTrvM3D1aEWXyx7uoMFvgzD6LJ2sdY6V91Ni2axHtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3956
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

T24gTW9uLCAyMDI2LTA1LTExIGF0IDE0OjA5ICswMjAwLCBBbGV4YW5kZXIgRmVpbGtlIHdyb3Rl
Og0KPiBGcm9tOiBBbGV4YW5kZXIgRmVpbGtlIDxhbGV4YW5kZXIuZmVpbGtlQGV3LnRxLWdyb3Vw
LmNvbT4NCj4gDQo+IFN5bmMgZnJvbSB1cHN0cmVhbSBsaW51eCB2Ni4xOS4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEFsZXhhbmRlciBGZWlsa2UgPGFsZXhhbmRlci5mZWlsa2VAZXcudHEtZ3JvdXAu
Y29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRs
aW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IMKgZHJpdmVycy9ydGMvcGNmODUwNjMuYyB8IDI1
ICsrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjQgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3Bj
Zjg1MDYzLmMgYi9kcml2ZXJzL3J0Yy9wY2Y4NTA2My5jDQo+IGluZGV4IDA2Yzg1ZDkzOWUwLi4w
YjMzNmI4YzVlZSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9ydGMvcGNmODUwNjMuYw0KPiArKysg
Yi9kcml2ZXJzL3J0Yy9wY2Y4NTA2My5jDQo+IEBAIC02OCwxMiArNjgsMjUgQEAgc3RhdGljIGlu
dCBwY2Y4NTA2M19nZXRfdGltZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBzdHJ1Y3QgcnRjX3RpbWUg
KnRtKQ0KPiDCoHN0YXRpYyBpbnQgcGNmODUwNjNfc2V0X3RpbWUoc3RydWN0IHVkZXZpY2UgKmRl
diwgY29uc3Qgc3RydWN0IHJ0Y190aW1lICp0bSkNCj4gwqB7DQo+IMKgCXU4IHJlZ3NbN107DQo+
ICsJaW50IHJjOw0KPiDCoA0KPiDCoAlpZiAodG0tPnRtX3llYXIgPCAyMDAwIHx8IHRtLT50bV95
ZWFyID4gMjA5OSkgew0KPiDCoAkJZGV2X2VycihkZXYsICJZZWFyIG11c3QgYmUgYmV0d2VlbiAy
MDAwIGFuZCAyMDk5LlxuIik7DQo+IMKgCQlyZXR1cm4gLUVJTlZBTDsNCj4gwqAJfQ0KPiDCoA0K
PiArCS8qDQo+ICsJICogdG8gYWNjdXJhdGVseSBzZXQgdGhlIHRpbWUsIHJlc2V0IHRoZSBkaXZp
ZGVyIGNoYWluIGFuZCBrZWVwIGl0IGluDQo+ICsJICogcmVzZXQgc3RhdGUgdW50aWwgYWxsIHRp
bWUvZGF0ZSByZWdpc3RlcnMgYXJlIHdyaXR0ZW4NCj4gKwkgKi8NCj4gKwlyYyA9IGRtX2kyY19y
ZWdfY2xyc2V0KGRldiwgUENGODUwNjNfUkVHX0NUUkwxLA0KPiArCQkJwqDCoMKgwqDCoMKgIFBD
Rjg1MDYzX1JFR19DVFJMMV9FWFRfVEVTVCB8DQo+ICsJCQnCoMKgwqDCoMKgwqAgUENGODUwNjNf
UkVHX0NUUkwxX1NUT1AsDQo+ICsJCQnCoMKgwqDCoMKgwqAgUENGODUwNjNfUkVHX0NUUkwxX1NU
T1ApOw0KPiArDQo+ICsJaWYgKHJjKQ0KPiArCQlyZXR1cm4gcmM7DQo+ICsNCj4gwqAJLyogaG91
cnMsIG1pbnV0ZXMgYW5kIHNlY29uZHMgKi8NCj4gwqAJcmVnc1swXSA9IGJpbjJiY2QodG0tPnRt
X3NlYykgJiAoflBDRjg1MDYzX1JFR19TQ19PUyk7DQo+IMKgDQo+IEBAIC05MSw3ICsxMDQsMTcg
QEAgc3RhdGljIGludCBwY2Y4NTA2M19zZXRfdGltZShzdHJ1Y3QgdWRldmljZSAqZGV2LCBjb25z
dCBzdHJ1Y3QgcnRjX3RpbWUgKnRtKQ0KPiDCoAkvKiBhZGp1c3QgcmVnaXN0ZXIgdG8gbWF0Y2gg
cnRjX3RpbWUgc3BlYyAqLw0KPiDCoAlyZWdzWzZdID0gYmluMmJjZCh0bS0+dG1feWVhciAlIDEw
MCk7DQo+IMKgDQo+IC0JcmV0dXJuIGRtX2kyY193cml0ZShkZXYsIFBDRjg1MDYzX1JFR19TQywg
cmVncywgc2l6ZW9mKHJlZ3MpKTsNCj4gKwlyYyA9IGRtX2kyY193cml0ZShkZXYsIFBDRjg1MDYz
X1JFR19TQywgcmVncywgc2l6ZW9mKHJlZ3MpKTsNCj4gKwlpZiAocmMpDQo+ICsJCXJldHVybiBy
YzsNCj4gKw0KPiArCS8qDQo+ICsJICogV3JpdGUgdGhlIGNvbnRyb2wgcmVnaXN0ZXIgYXMgYSBz
ZXBhcmF0ZSBhY3Rpb24gc2luY2UgdGhlIHNpemUgb2YNCj4gKwkgKiB0aGUgcmVnaXN0ZXIgc3Bh
Y2UgaXMgZGlmZmVyZW50IGJldHdlZW4gdGhlIFBDRjg1MDYzVFAgYW5kDQo+ICsJICogUENGODUw
NjNBIGRldmljZXMuIFRoZSByb2xsb3ZlciBwb2ludCBjYW4gbm90IGJlIHVzZWQuDQo+ICsJICov
DQo+ICsJcmV0dXJuIGRtX2kyY19yZWdfY2xyc2V0KGRldiwgUENGODUwNjNfUkVHX0NUUkwxLA0K
PiArCQkJCSBQQ0Y4NTA2M19SRUdfQ1RSTDFfU1RPUCwgMCk7DQo+IMKgfQ0KPiDCoA0KPiDCoHN0
YXRpYyBpbnQgcGNmODUwNjNfcmVzZXQoc3RydWN0IHVkZXZpY2UgKmRldikNCg0KLS0gDQpBbGV4
YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
