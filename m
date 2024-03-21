Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09863C54E58
	for <u-boot@archiver.kernel.org>; Thu, 21 Mar 2024 06:55:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 222DF8803B;
	Thu, 21 Mar 2024 07:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=SocionextGlobal.onmicrosoft.com header.i=@SocionextGlobal.onmicrosoft.com header.b="eYYrcYAN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1DC1488060; Thu, 21 Mar 2024 07:55:42 +0100 (CET)
Received: from ps81.spcmail.jp (ps81.spcmail.jp [52.192.49.129])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB28F87FCC
 for <u-boot@lists.denx.de>; Thu, 21 Mar 2024 07:55:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kojima.masahisa@socionext.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hJo4d8M/3Ml+4uNsrwZutbFwnB3TUKP/OFjBMCmtuL/K3u3dV2hxN8MbYnf0tKBAkz9GLN7X/xwGyPED3bYZ7WpILp0FT5R84N43mPO6q3E44ghFCdroM365glM7rnWP75L/kKV7do64MxWarSmQHpX1SQcQYKjMgz85IFu6czo305anjtiEOUNdTQgiZU37Q5R7gqCitpepiEtOVsQicz+2J+k1RYA6NGAEfZFacLPa++Z0Dx69TS6Ph9cmxHAJYKDntSH5amef5hsVNs5MlVSsaYtY3Jd05m4S5rJLtIPTQcRiROrqsd9OhQqVVMiwe0SUk3bzkbi2EEHGjCyO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Taz3B2ecpKqHZmohCHScnKeAO1QTOfOfd3bTkjdte3Y=;
 b=J/ygamqlBYUMU10Xy7BILddntGNW6DS8hLDK/I49tXhQzGNcEQYFMTCqa+iTFhv4bJOcxlPHD9lN+j3LcWM+bQJ+KtMprETzrVJGXeXYWPikNZCPvAMbMs0wi87A742SHc3cRKcdDP+5CBbfM+IBPm9cc3lkl4eDO/H4m1qoU248Le61E1bf2XzWGWwlOduI7/dBlekGCQd7GjOWhjJzkKMB0O4RO82q/ahzDAdc3OMIZgpxA9HaJS4xDaW/vNrF+h2l69fQF983e4E+pF7Uflt9hQI17MZ7+LFj483WBm7//amK+UnGIHNEFc5BpIgy7E2DP5+8/IKJ6obiFw4JVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=socionext.com; dmarc=pass action=none
 header.from=socionext.com; dkim=pass header.d=socionext.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SocionextGlobal.onmicrosoft.com;
 s=selector1-SocionextGlobal-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Taz3B2ecpKqHZmohCHScnKeAO1QTOfOfd3bTkjdte3Y=;
 b=eYYrcYANwz+ByfmtL82W3FiOBkg1f8uWeEs4sczLeY7o6fjIkvCwZCo55kCeVVcorE/OTQ+pO/UiGS/C3lffp3DouKFticV0+4/A+riwqIZsmjDuSAkjfbWWqQ3RPqNZ7V0kl7Bosqf7rj/+radK+7ZpmPoJsfqGDxI6pTufTHM=
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com (2603:1096:400:151::10)
 by OS3PR01MB8366.jpnprd01.prod.outlook.com (2603:1096:604:191::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Thu, 21 Mar
 2024 06:55:24 +0000
Received: from TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::d04a:eae5:6d52:39f]) by TYCPR01MB8375.jpnprd01.prod.outlook.com
 ([fe80::d04a:eae5:6d52:39f%6]) with mapi id 15.20.7386.025; Thu, 21 Mar 2024
 06:55:24 +0000
From: <kojima.masahisa@socionext.com>
Subject: RE: [PATCH 1/1] .mailmap entry for Masahisa Kojima
Thread-Topic: [PATCH 1/1] .mailmap entry for Masahisa Kojima
Thread-Index: AQHaeSG2bitsJgyIqEStpiPYt0Ej77FBxEYQ
Date: Thu, 21 Mar 2024 06:55:24 +0000
Message-ID: <TYCPR01MB83751029362BD6B2F2EB5E4CE3322@TYCPR01MB8375.jpnprd01.prod.outlook.com>
References: <20240318104718.18365-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20240318104718.18365-1-heinrich.schuchardt@canonical.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ccmail7: Relayed
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=socionext.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8375:EE_|OS3PR01MB8366:EE_
x-ms-office365-filtering-correlation-id: c22c65cc-5bac-489b-65a7-08dc4973e228
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cviOxgIui8/ZSgCfyH4t+CUGcXMPAAFi4HgkIK9pkkydfxkbOYLjD0ld5LCIHUwr7lle7QTPZ7Jz16ied0Gvw9v0n3xNf09A/jSBonE52C6/7uiOZ3gHEt0nOEVqAOsGHrZNtSMCs5tNH5v5KfLR69hNnaIrpnoTZ3A5Iknbp9xsbOOCOQGAEP0131+AEKlE0gPKOmpd06K7Db574APK2mzZIR3YiNIuFIh9DFzwR1gMwwDRXRHak6k/gdzsDV7i+1ezNIkIeiCh7vGdiVOAjyLsKyYHR26ivI8wrmWvC8zNdGZyzQhszwyfKMopLM+fnGz+YMCAuw2QjGPvfDYSuFqKzLLSmmcBqrAng/Rpy5jW1eZ+PycFRbS2s3LJYGks+7ocNdjuKyCYWnn/uovyzHhRTFUghc9HsAWXRDhMd2UUO0+FdY9PtOUW/DFLb3Hv/SEa6soAY2xFiLhDbciDZSrNA8acvjoMByA/AaeCgyPLwz9dFTJkTAGUNj9V1RuBpVspO/jq7Gl/boBg7y76KrWrGYS9ln/TOBCNc28vdi3a3Qmv6ddOH7wFc2YFgCo8cs+8JTYAZ8qg5gPcgCp9HymaN21JqLMQrqqEeaDYyrDm7suJ7NkrU/iF0EaMBfrmq98acrzaF+HBCzTK5Q+NUl2SkrY8RnNKNIdSCVIngxVhEacjPObaUKubDoXk7kIDZ/CfIAb/Rbh3txv6iVvnJOizwMAoF54lJPXDicOE/T35gRMvzMyrgwY2HeFnyP7J
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:ja; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYCPR01MB8375.jpnprd01.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(1580799018)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1VZOVl0TWV1a0JxRWlFNzhDZ2x6Qml6c0ptSEdzclc2YjZreGdsTjlKdk9Z?=
 =?utf-8?B?N0x5OUpJYmxyZ1lXRDNEUC90eXVDRDRLNGRocVdzMzl4bU1BdU8zSDFHbExr?=
 =?utf-8?B?UjRZLzl1UUdDTXFsbTU3TzdLWUw5WW5CS1lkNkI0WXpmclFzWXJOb0VlSTNk?=
 =?utf-8?B?VVNaQTZJeEhwUDNUUGgwV0F3RTBEY0t1QUVvMlM1Yzg4MnRvWVlEL0dNOExj?=
 =?utf-8?B?MDdqRmZkaWtIUmNGeFlQQko0ZHl6L1NxSXl4Z2krSUErbUpBbVluY2NDWnkz?=
 =?utf-8?B?VFVOUGJDdlhwL0pzK3pFd1Z4NWV3OHN5L1JEbzhibVY2NWkvM2JyVWlyS0s5?=
 =?utf-8?B?L1RaWndjRXZyek50Q25yU1RjWTZhVjhyV05hakVDdmZBSHJZN2xveHR6WDZY?=
 =?utf-8?B?NWpBYmR2bDYzQTFIaDhaTVQvNGMvT3RKNDZEOHdiVVVKWFZNQitpQytRVXNn?=
 =?utf-8?B?L0VzaXlsbDJ5SWdjK3dqTjVJaUQzNFdJbUNZa0hzRlp6Z2t4d0Jlb21XUDRJ?=
 =?utf-8?B?cTJheE9oWXhmWHZzOEE4L1RuNHI5ZG5jV245TEdLNm5SeWFvb0s2Z3p0M3VT?=
 =?utf-8?B?N21KNmsvNDUyQ3QrZmg0M0xjdWYrdUY4QzBvb1o5L1Vra0JDQnZYa2cxRXlW?=
 =?utf-8?B?czFIdmUwRldiREsxNG5LN1JOT1d0d1NvbVFwTDN2MzU0Tys4Y2QrdCsyV0Zh?=
 =?utf-8?B?VkdEam9IK0lQc0R2UnRPdGYxMDE5R0QxVEE0VXhOajNXaEFkUVRzOFZMWS94?=
 =?utf-8?B?dy9oYndQdTRKejk1MCtoWmFEbGxtYzJqUjNxL0RVT0tIMDgzMDVJcVZnT3J5?=
 =?utf-8?B?dEJIYmQyUjQ5OTIyRVpRNE9GNVVsQ0FJbndLYVVSZ1EzalErNEJucUVoVmQ4?=
 =?utf-8?B?V1pNbkc0KytncmM1bWJQYUVmMmt1R2ttZE94Z0JrNFdMQW5NcERxY21ES01t?=
 =?utf-8?B?a0R4eENBVEErZXpvM1JYbDdMSXhGeTBCdTVtcGZ4NXo1c1ZuUVF5K2JTYzZi?=
 =?utf-8?B?MXdaZVlqZEsrUXYzeWxSYmVvM29MUFhtSFJOeTA4K2lRYklQZGdacFVPTjJ0?=
 =?utf-8?B?RHZQaktDQTcxMUJmazEwNkIrdFkyQ21neTRIOEtuYS9sNHMxOGFPRmtBYTFP?=
 =?utf-8?B?TGRMMmJkampNZ0dZcU1HQkVvKzI5RmpqZkVGeDZDK0dZQ2IzeTRxcndCeUFH?=
 =?utf-8?B?b25RQzF4SlR5Vm5FS0pLb0JDTmNkZUVjdXBZS2xkWUJFZUtpOHMwSUlsdFNz?=
 =?utf-8?B?bWFTZ2FFRm1WNjdjczR2MkJ3ZEhvSFZ5TFIyWURIYVB3RktRMko2V25TcWdh?=
 =?utf-8?B?RDJBRDhHZ1U2ekw0b1hNMm5xY3ROOGt2T3VkRWZvQUg5bzJpNHFiQWRNTysv?=
 =?utf-8?B?MlZPRmd2eDl6RHprcFV2VUZYNWJjUWtBczlpUC85NkRiNFVvS1M0T2Voa0Uv?=
 =?utf-8?B?VUt2WnBrSlV5aU5GejJ3VHdTRjJwanAzRkI2Nk1QRzdidFVYcVZwMStUblJt?=
 =?utf-8?B?NHg4MDNMY2xsampPZGFiOTJLVzlxZFdvTFF2cWxYRzlxVXZSbnc2Qy83emNt?=
 =?utf-8?B?SnRlR3BwNk9MR2Jhd0JtVkhUNlE5RHZ5WDhnczJBMks3ZHE4dHFJdDA0V1or?=
 =?utf-8?B?QkFONEdxVjNxZkFQYVhneUJQeWJkNS9ZWmUyN3l3dEtZY0djWlhpK0F6WmMy?=
 =?utf-8?B?TS8zcXNIM2YxZDltQUk3WGQ5MVozbWFXbU9xbC9EWDg4RHo4dGJrTE1sWkta?=
 =?utf-8?B?RWV6em9Xb2tIZGZhZ0JTRHhlZk53b0JzNlBmUHpqY2xsYjh6NCtmSzIzN0kv?=
 =?utf-8?B?SUdnWXNxOTFkMEdvMzRZOFBxNFlvcnlncnNBVlEyWmNhOHJuOXlRdU5PVVlt?=
 =?utf-8?B?ZXlxOHAwTzcxb3dzR1FOVW80L2IzK2xxa1k3Zm5QVVV3cnVlekF4czh2Rnoz?=
 =?utf-8?B?SXZKdWxSdDBYVW95KzFjRUlUZWtBcWxDYXJ2SWV4QkpVdWNBUFFuTk4vSHlq?=
 =?utf-8?B?TGVNRnd5L3lHbmZrLzE5YUhlODk2K1FTcHpqM3F6dCtuM2c3cTFtSnR3c0d3?=
 =?utf-8?B?WTVOQ3VrZTJ1aS9YMk1xZ0tiTE1FOHRDZVA5ZS9sVjhrcFlTdEQyYUhVQy9t?=
 =?utf-8?B?eFlRQW5DamVqTWFGbDU0VG9PVHdYTUc5M0ViN0JLQXhjWlNPT2h5UG03TUpk?=
 =?utf-8?B?aHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OFEx+9jTCSz2K5f72mQGo3BpcYnSaAyOA9MJneXMGHEVfUYSoVRa9TaH4GiHCkiIhC5wSuirHdMIq87A191sjXA0VQqrInp5BhfUb2/eIqyiSQfepnlBycsKC+G2DiVvn8C7RrRuohZEsoAKU6UKuOcItUHMYRAVVeyvaf6rMH9aRPkdKOeMCw0KxGHGyOsdktcjTEy/Fr7mMxK1fSuNRUiWw5Cwm8lTxgOT173GD+z2dO10Ijp2cOoS1cuyNcm2ttMIcK2Bxy3S4NPFiGnWXKN10PWf8c3+gC+kRRERKmG/pA+dfvDF1Ca4g1RBdf2hrhLhPLBHAo13zI8cz6qx0cN6aw178zVX+jp2EuVQkNS6eWR25nerJU5wXVaT5dg9uuM1ufciocIWI+v+3IpPqiOBhGWXBDKY65/cJqmPRIz9+k/zty/lWXU29QrlOoyrLdEe2yOHOfRFjsWforvPHvfEQp4FivfEGytjlOa+0h04cLy+CdP2ZdgLhffo1vBrM+43x6Msp724qXjp0pExkHS7bA7gN9aAnQrtsUDQWqlybxEPkgDGQhU6a7Zp9OyF9h60uhE17WE2HRUU9euLmkoIF5EVoiuaemR66Vbd1W9Ea19NNxQoJMBGpH5y9dSYdOrkxdtVOEqgsBEK6EfYFRCk5aAvfgFKIHT0NaGygHhuIxmjR6QhSr0mtNuG+4man2yl4b4H66TmqnGcikOyk2WQnzvLHxNwWZYWlYi8idD6bBiCyAP9BoZV8vWPtXkm
X-OriginatorOrg: socionext.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8375.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22c65cc-5bac-489b-65a7-08dc4973e228
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 06:55:24.3787 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 33c08a51-ea9e-46de-8669-aff1f467d3fe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pPnbYUzfAL2ov1PKYaSqAIkuj1CiKkfWcN/BPXc4TOHfni3+V0VMQhF8i9QeQTnYpc/HZR47L/JFnSh+hgwC5x6mLS9kDIkAB2mhMt2yNf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8366
X-CC-Mail-RelayStamp: CC/Mail Relayed
X-CC-Mail-RelayStamp: CC/Mail EncServer Relayed
To: <heinrich.schuchardt@canonical.com>, <trini@konsulko.com>
Cc: <u-boot@lists.denx.de>
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

SGkgSGVpbnJpY2gsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVp
bnJpY2ggU2NodWNoYXJkdCA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0KPiBT
ZW50OiBNb25kYXksIE1hcmNoIDE4LCAyMDI0IDc6NDcgUE0NCj4gVG86IFRvbSBSaW5pIDx0cmlu
aUBrb25zdWxrby5jb20+DQo+IENjOiB1LWJvb3RAbGlzdHMuZGVueC5kZTsgSGVpbnJpY2ggU2No
dWNoYXJkdA0KPiA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPjsgS29qaW1hLCBN
YXNhaGlzYS/lsI/ls7Yg6ZuF5LmFDQo+IDxrb2ppbWEubWFzYWhpc2FAc29jaW9uZXh0LmNvbT4N
Cj4gU3ViamVjdDogW1BBVENIIDEvMV0gLm1haWxtYXAgZW50cnkgZm9yIE1hc2FoaXNhIEtvamlt
YQ0KPiANCj4gVGhlIExpbmFybyBtYWlsIGFkZHJlc3MgaXMgbm90IHZhbGlkIGFueW1vcmUuDQo+
IA0KPiBDYzoga29qaW1hLm1hc2FoaXNhQHNvY2lvbmV4dC5jb20NCj4gU2lnbmVkLW9mZi1ieTog
SGVpbnJpY2ggU2NodWNoYXJkdCA8aGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tPg0K
DQpSZXZpZXdlZC1ieTogTWFzYWhpc2EgS29qaW1hIDxrb2ppbWEubWFzYWhpc2FAc29jaW9uZXh0
LmNvbT4NCg0KVGhhbmsgeW91IGZvciB0aGlzIHVwZGF0ZS4NCg0KQmVzdCBSZWdhcmRzLA0KTWFz
YWhpc2EgS29qaW1hDQoNCj4gLS0tDQo+ICAubWFpbG1hcCB8IDEgKw0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvLm1haWxtYXAgYi8ubWFpbG1h
cA0KPiBpbmRleCBkMWYwOGYzZWNhOC4uNTlmODQ3MTEwMDAgMTAwNjQ0DQo+IC0tLSBhLy5tYWls
bWFwDQo+ICsrKyBiLy5tYWlsbWFwDQo+IEBAIC01Nyw2ICs1Nyw3IEBAIEpvaG4gTGlubiA8am9o
bi5saW5uQGFtZC5jb20+IDxqb2huLmxpbm5AeGlsaW54LmNvbT4NCj4gIEp5b3RoZWVzd2FyIFJl
ZGR5IE11dHRoYXJlZGR5dmFyaQ0KPiA8anlvdGhlZXN3YXIucmVkZHkubXV0dGhhcmVkZHl2YXJp
QGFtZC5jb20+IDxqeW90aGVlQHhpbGlueC5jb20+DQo+ICBKeW90aGVlc3dhciBSZWRkeSBNdXR0
aGFyZWRkeXZhcmkNCj4gPGp5b3RoZWVzd2FyLnJlZGR5Lm11dHRoYXJlZGR5dmFyaUBhbWQuY29t
Pg0KPiA8anlvdGhlZXN3YXIucmVkZHkubXV0dGhhcmVkZHl2YXJpQHhpbGlueC5jb20+DQo+ICBL
YWx5YW5pIEFrdWxhIDxrYWx5YW5pLmFrdWxhQGFtZC5jb20+IDxrYWx5YW5pLmFrdWxhQHhpbGlu
eC5jb20+DQo+ICtNYXNhaGlzYSBLb2ppbWEgPGtvamltYS5tYXNhaGlzYUBzb2Npb25leHQuY29t
Pg0KPiA8bWFzYWhpc2Eua29qaW1hQGxpbmFyby5vcmc+DQo+ICBMb3ZlIEt1bWFyIDxsb3ZlLmt1
bWFyQGFtZC5jb20+IDxsb3ZlLmt1bWFyQHhpbGlueC5jb20+DQo+ICBMdWthc3ogTWFqZXdza2kg
PGx1a21hQGRlbnguZGU+DQo+ICBNYXJlayBCZWjDum4gPGthYmVsQGtlcm5lbC5vcmc+IDxtYXJl
ay5iZWh1bkBuaWMuY3o+DQo+IC0tDQo+IDIuNDMuMA0K



