Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC19CD3427
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 13:50:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E1E0848FC;
	Tue,  5 May 2026 15:50:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="lgbVtk4A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4581084940; Tue,  5 May 2026 15:50:07 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AA76848B8
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 15:50:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0R06pYzfHa1JDscA3jJu02eh0exTt7jZ7segBubVRQlKIzoHof93e7Bv7yS2afGdplPrIfAVcxb7Fi+hfQYVAn5jlcvMaeHwri9rznuTvfm3VwX8ai7o6zz1fd9FpdgM+ETnbeGs78bwLaeLbX4c3/fpdEo+VCsas6J4NjvmIGy8X9Fudlg2XzU5qno+VXi4USULRW9L2glLeEdb7u1z61oBAusSvHt2e/8h3MJYhURkW9p2nfk3v8BWEXoEQMvS0GIxAQde+dsJxwEx2zF8FwKvtRGLBivL54dX3TUDxZEL26xycCted5MdSVy8YXl5TOnGalg/BGtyOGnTrfQog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0SK5EvTsQm5M2WO179RLDfJTZR01CNF3lUNwoffvleo=;
 b=l13WK0ndY8PbuAJNIkJx7UXvAZpw6MPNudSVNo4SbMkYvL4Azaf3qAe3hwSzNk3DyYKqoj5vzLhua2EcKufKG9MLbTJOPxZMm5MnkxBQ5LmgbhahwYhhHw7anZ2u86+lRvNIHTeVh8loCUzkyt/LTvv1C1PZpTVgxcZ8QwJ953zbrJwEw1pOBY6wUPF8Ol79TYhpbcuxTlcfXQ6Ubd6EDo2z4fpb6gkjPzUILw98nMCScsBIYCdRmSH+5AWt3FsRogv4C9BTRwELbJH13liwc1jRtfYZFFlfwRregQ+1jqSHip5qVOjEahb5iwX5lcfHe1VyNG917fV4A1xWD305kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0SK5EvTsQm5M2WO179RLDfJTZR01CNF3lUNwoffvleo=;
 b=lgbVtk4AOrcgaY2RsiXLfV3SibOlo/cTzLn+oDeyPvHnY1tRnUOuTjyT8b3Jv41RxQmuiU1qp0sVP1aWh78+nml7uXPfIyTmZld8htx9RZWwqXA07ZKdiRQOwRY8EJMim/EW8WnmVlPB6TiYrsJghmdJY5glPcAugmUHDtG0pd15jhtgSIV5r2NlPWrkaPfM/YYPlPXegaNWmC6kN4K3eBNxC+0Rk7gQt8wM+uZLGRK+Mt/HcKVMz+QoWD951c++wbTn32COYrdPFW2nb8IfDsidgTfuPAnp4AyvfeMxlHLaluRRL60s6TwVdjHnsGl3VFky1NoBC8xcO8PfVdJR5A==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU0PR10MB7076.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 13:49:54 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 13:49:53 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "raymondmaoca@gmail.com" <raymondmaoca@gmail.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "casey.connolly@linaro.org" <casey.connolly@linaro.org>,
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 "pranav.sanwal@amd.com" <pranav.sanwal@amd.com>, "michal.simek@amd.com"
 <michal.simek@amd.com>
Subject: Re: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Topic: [PATCH v2] lib: fdtdec: validate bloblist FDT before consuming
 libfdt size
Thread-Index: AQHc3AyQiseYSTlF3kO9NGPTIjkkqrX/GxuAgABYGICAAADMAA==
Date: Tue, 5 May 2026 13:49:53 +0000
Message-ID: <064b011e32963eb1e6220cafe4614186a1fc16c8.camel@siemens.com>
References: <20260504212524.1665166-1-raymondmaoca@gmail.com>
 <b7432c55f00b4c9b2043ca8efb262a5d5ec4d6e2.camel@siemens.com>
 <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
In-Reply-To: <CAMDkj5yUHypTiuYk+VqOVA3FSJpDo6CsqsVAWn69nOS3EapAcw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU0PR10MB7076:EE_
x-ms-office365-filtering-correlation-id: c2bca6ea-d9b4-45aa-df83-08deaaad2f6d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|55112099003|56012099003;
x-microsoft-antispam-message-info: zHQHw5OFCPaGsQyLBKZbQcrAsetnxClmnrEcRnTBTqaSnrehDpWWpVMIsddRByFOp35Qu0gRDyytDqhiLT3w+Dvdyd/o+QeITet6bR+5AJ2ifyWa8tYQ3DN5XZrDTXa5B3pe9FEUPVmsjOr5uJMarCwki0N++kJev+6IsDw/RCU5uD+1wXwSOUm8Z6ksICM9emSQtWf1Fc5foGc5zm2CY1CLeX6cq2wRXhrCxR/pXUITzH8tv9lrFfcoJkEBw5ImhDZcw4T2J/mGNJdjrfw0Ce82pmMVwwBLY7tLTRcw6fUlKTEjbWW1G58gTHb670y2I/xxygulCmx56wH3768rHwB/cfvCUzlyFHo8NLpROZ8U2s0HQ1+kFnn2qD7ZSKiDKp8OyM+YsMfX3rrprHXrrnnT8QYt0jx8AmrS2Jfx+IFAIy/dyF35XIdGWiZF2KLcQm8NqPAnCs1sNDKc8qQYpBPlTma7Ie22jB5kO5awnf5uoo1x4iguHw9WpyGGEKs63Nd3aa3HdZFl+SXpWvHy5eALxWtBGCH6h/gQYPUVmXbX/1D5hNFqGd2c0dkbLys14Bi0m9onoLO5SqTCjuBeqsW+/tocU+Zh8E+uQiIb7Oy+idm64xcAWHa/k4DsVR5IylGm7v+lTzG5hWjoORDqacah03zz6ztUtsX6/kBFbTstCctt0Bucob2IkBiiX2T3FOyeci4pQPjmqvIGlE8+Hw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(55112099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SENEY0NQeW5FWjNSODRvb2VGeHpYMHo2eEg4eXd3aTBRaGRmRFpFVCtDQmFq?=
 =?utf-8?B?SUkxN3M3eGRhSEJMWW83Zm91ZHQzNEdycHgzMWorekVKZG5UaVplbXNwZXFO?=
 =?utf-8?B?NUo0a3pFTG5hMnN1UzVJeHd4aHJvZ0JpaVdZNXZZSU1Jd2RZQXBocUlxa1o5?=
 =?utf-8?B?Q2tDUjZ4QTRENk5NaEhaTTVOOHhxZ25uYVQrcGVscVQ3L1lBMW5vRWtSb1ZE?=
 =?utf-8?B?Q0VpNWNiNEF6SzFZaDdnWFVsMlMyemdNWk5BRUF4Nnljem5oWFU0MEkyUm13?=
 =?utf-8?B?Rm84WkJYSSszSG9nWEZnMWRxUGxlUmRvcGRzQnZySlJLR0cxR25JU01aQVBY?=
 =?utf-8?B?QXFxVzE3MXlyZzNCcElKNUZ4d2JKK20yckUyaHdsRXVJcTFNTlNmaGVsbnBO?=
 =?utf-8?B?bWp2RlRQTXU1eFdUZGN0K08vNUlUbm1DTk5ubGZoTGk5bjBpTk1CVy8wMU9N?=
 =?utf-8?B?Q3MyaWxSazFWM1gzTTU5VWUzYTNmZER6c3dRZU1rL3lpc3dRL0U0WUpjRndt?=
 =?utf-8?B?SDhCUm5mbFRad1lxZEsyS3QvWksrd0VhZERLT1IraVUrWmpsZW50dzVMbkNF?=
 =?utf-8?B?YjJtZ25rZ1N2dDlQNEpGRmEyU1JxbXFiY2JRdUhmN3IyaStXbW4wakxxVUtn?=
 =?utf-8?B?QlFRdjRvWWdoY0lCMzVkNkFQbE9pMkdUUTNVL2xubEZLY25IaUJmRlFaYWda?=
 =?utf-8?B?UVNrMjI3TkVFZ3RLazl5U1M0cDRqMTd6emhLZ2NhRDBwRERGUWlhMXhFTExX?=
 =?utf-8?B?MGJCWDBVSklzU2YrSWJaeXgzeVhLWDB1N3pqWHlpS0g4ajhab0RYWXl3M2p1?=
 =?utf-8?B?Q0tnRFB5MzRJb0EwR0tGdmdOUnFqd0k2NFpJQkpkVVE5SVdReHNkRkdGbENK?=
 =?utf-8?B?VkNhNGpXOWQyTkZ6L1cwbmxaaUdSVjRIeldNYTdmdU9RczhhZjRqSExHSGl6?=
 =?utf-8?B?U1FrS3N3UDh1MDFsWkZwSlo5TVNieUNocVBqMWR3OXRBVEhjNW5DNW9iK3lT?=
 =?utf-8?B?emJDM0ZkejR5SU5uTHArWDZ4aTVLa0hka1J5WHNuNlcrK3owdXg5SHJZdHF5?=
 =?utf-8?B?VForanVGY1k3VnhqU3dCdUlMWnlzSWJVMVdLalNuaVRYdnVSTnN5OVRtUW5i?=
 =?utf-8?B?YWtsNVlySUdtREVKN2NmMTNZazFlY2lDQ0RsSnFJT0t5SEpEc3grMkJQWFBY?=
 =?utf-8?B?TkVHZnN5Z2VuYTQ1ZmhBY282RXFmSzk3b1VaWXZsSDRpZXpxMTdkQ3NkTitP?=
 =?utf-8?B?ZGlJeUt0WmZCZWpwVDZrNURmUmxlcXZPOGZnRlA1bG5LdlB2cTc4VUxIdVNK?=
 =?utf-8?B?cS93Rk5walA2QUpRWmpqYkgrY2tQbmkyYzdETGs3NU1XVTU0cDlocnhiZ3FR?=
 =?utf-8?B?eFdFNk1UcnhJT0NKSEwrVFNRYko4NW00YlVqS1hSVi9aY3FNZ1FSb2dTYk1K?=
 =?utf-8?B?cjlNZWxvS1UybUl1TEdEMHkvcnVMSG5nSlFsTVFUR3MxUGoyajVvSkxJL2Va?=
 =?utf-8?B?clFXWWxOZ3JaTkJIWWcweGdvZTV1UTI3QTlYTVBkM0N4ZDZFRVpNSWRocmhl?=
 =?utf-8?B?VUxQRnlPaVNJQ3Q5RWp2T0NUQ2Q2VFlCMkp4Y0ZnTU5CeW8zczc3WkxnTkd6?=
 =?utf-8?B?cnJTOFdCK2FvTXl5RWxBQVVlS2N6ZjJnVjRRQy9tazlURjJLYXBnVWxDNk15?=
 =?utf-8?B?eGxuRGt2ZzZMMEt6blFRWk1EcUFGM3R3NFpqb0lZUEFsVXJKSkFJb1EyMmJn?=
 =?utf-8?B?N3FVayswbnV6TGIzaDZDVUU2VGltUnUwZGxjYnRFZWYwS2IveXk1UDd2Z2xz?=
 =?utf-8?B?cVJjeSt6a0pNVDhuTnlFS0JheWdnTDR4ZnhTWDVvcWJKUVk0YmlVb1prbHNN?=
 =?utf-8?B?dkVpOU9xSzB1eGRkNXFmdVFLVHR6TkVIaGV6VGxDQ0FTWEhsOTBqckcvSWly?=
 =?utf-8?B?d0szZ1lIZm56QUtlVmErSUtrVTNnMUFES0RHQWNiZVJhQzVxTnJwbU10a2t1?=
 =?utf-8?B?T0Z4Z1NnR0QvQU9YR29SV0djeEQ5eVBSVG81QWNBcnR1S3lReS9kQkFaNXpj?=
 =?utf-8?B?YzJUZzdHQUd1amRrNzZidVpXYkt4WlkxWjFmWnVqK1hYSDRZT3p2cEtXc3Qv?=
 =?utf-8?B?OU50dk9VeXNsb3BHWFZjclYxdk9KbmphWGYxL1dzRzNTajlGY2dTTHAwdjBX?=
 =?utf-8?B?QVMyc29QdU9IZnBOeFZzT1B1Q1ZtMFZ6UkR4WnZxY0pBZFpadTNOZldPRmpl?=
 =?utf-8?B?TUpVRUZMcXc2QVN5QzJkSDkvVWpNeHpsSUpoWXU0c3hMRWlVZEc3SmhBNVgx?=
 =?utf-8?B?S3ZVODdiZjg4RnpML2tkOVJGS1Z3bW9mSTJDQnNmMTZoWkdaaUxPMVNsZHNq?=
 =?utf-8?Q?ddDtIUQZi4juLFtU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDECF75B70D1F141AA970BE839CA7080@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c2bca6ea-d9b4-45aa-df83-08deaaad2f6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2026 13:49:53.4072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drvZ45gxbb+yK7IzM2Y0fmAKMk88go8EvgRU1rFRBAR6tN2C3R95YSXBfx6jpboiBWE5yaKZq7DVRiaVDQYG/0elfIx9URqmX9eS6xjPJgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7076
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

SGkgUmF5bW9uZCwNCg0KT24gVHVlLCAyMDI2LTA1LTA1IGF0IDA5OjQ3IC0wNDAwLCBSYXltb25k
IE1hbyB3cm90ZToNCj4gPiA+IENvdmVyaXR5IFNjYW4gZGVmZWN0cyBhcmUgb2JzZXJ2ZWQgaW4g
ZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0b3MoKSwNCj4gPiA+IHNpbmNlIHRoZSBsaXZlIEZEVCB0
YWtlbiBmcm9tIHRoZSBibG9ibGlzdCBpcyBwYXNzZWQgdG8gbGliZmR0IGhlbHBlcnMNCj4gPiA+
IHdoaWNoIGNvbnN1bWUgaGVhZGVyIHNpemUvb2Zmc2V0IGZpZWxkczoNCj4gPiA+IC0gZmR0X29w
ZW5faW50bygpDQo+ID4gPiAtIGZkdF9wYWNrKCkNCj4gPiA+IC0gYmxvYmxpc3RfcmVzaXplKC4u
LiwgZmR0X3RvdGFsc2l6ZSguLi4pKQ0KPiA+ID4gDQo+ID4gPiBBZGQgYSBzbWFsbCBoZWxwZXIg
dG8gdmFsaWRhdGUgdGhlIEZEVCBoZWFkZXIgYW5kIGNvbmZpcm0gdGhhdCB0aGUNCj4gPiA+IGFk
dmVydGlzZWQgdG90YWxzaXplIGZpdHMgd2l0aGluIHRoZSBjdXJyZW50bHkgYWxsb2NhdGVkIGJs
b2JsaXN0DQo+ID4gPiByZWNvcmQuIFVzZSB0aGUgc2FuaXRpemVkIHNpemUgYmVmb3JlIGNhbGxp
bmcgZmR0X29wZW5faW50bygpLCBhZ2Fpbg0KPiA+ID4gYWZ0ZXIgb3ZlcmxheXMgYXJlIGFwcGxp
ZWQgYmVmb3JlIGNhbGxpbmcgZmR0X3BhY2soKSwgYW5kIG9uY2UgbW9yZQ0KPiA+ID4gYWZ0ZXIg
cGFja2luZyBiZWZvcmUgc2hyaW5raW5nIHRoZSBibG9ibGlzdCByZWNvcmQuDQo+ID4gPiANCj4g
PiA+IFRoaXMga2VlcHMgdGhlIGV4aXN0aW5nIGZsb3cgdW5jaGFuZ2VkIHdoaWxlIG1ha2luZyB0
aGUgc2l6ZSBjb25zdW1lcnMNCj4gPiA+IG9wZXJhdGUgb24gdmFsaWRhdGVkIEZEVCBtZXRhZGF0
YS4NCj4gPiA+IA0KPiA+ID4gRml4ZXM6IGI3MGNiYmZiZjk0ZiAoImZkdGRlYzogYXBwbHkgRFQg
b3ZlcmxheXMgZnJvbSBibG9ibGlzdCIpDQo+ID4gPiBBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IENJ
RCA2NDU4Mzc6IChUQUlOVEVEX1NDQUxBUikNCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFJheW1vbmQg
TWFvIDxyYXltb25kLm1hb0ByaXNjc3Rhci5jb20+DQo+ID4gPiAtLS0NCj4gPiA+IGNoYW5nZXMg
aW4gdjI6DQo+ID4gPiAtIFJlYmFzZWQgb24gbWFzdGVyLg0KPiA+ID4gDQo+ID4gPiDCoCBsaWIv
ZmR0ZGVjLmMgfCA0MyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0t
DQo+ID4gPiDCoCAxIGZpbGUgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMo
LSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2xpYi9mZHRkZWMuYyBiL2xpYi9mZHRkZWMu
Yw0KPiA+ID4gaW5kZXggMmQ2Njg2MGY2ZWQuLjYwMWY0MThkYjZlIDEwMDY0NA0KPiA+ID4gLS0t
IGEvbGliL2ZkdGRlYy5jDQo+ID4gPiArKysgYi9saWIvZmR0ZGVjLmMNCj4gPiA+IEBAIC0xNzQ0
LDkgKzE3NDQsMzEgQEAgc3RhdGljIGludCBmZHRkZWNfYXBwbHlfZHRvX2Jsb2Iodm9pZCAqKmJs
b2IsIF9fbWF5YmVfdW51c2VkIGludCBzaXplKQ0KPiA+ID4gwqDCoMKgwqDCoMKgIHJldHVybiBm
ZHRfb3ZlcmxheV9hcHBseV92ZXJib3NlKCh2b2lkICopZ2QtPmZkdF9ibG9iLCAqYmxvYik7DQo+
ID4gPiDCoCB9DQo+ID4gPiANCj4gPiA+ICtzdGF0aWMgaW50IGZkdGRlY19nZXRfdmFsaWRfZmR0
X3NpemUoY29uc3Qgdm9pZCAqZmR0LCBpbnQgYWxsb2Nfc2l6ZSwNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aW50ICpmZHRfc2l6ZXApDQo+ID4gPiArew0KPiA+ID4gK8KgwqDCoMKgIGludCByZXQsIGZkdF9z
aXplOw0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgIC8qDQo+ID4gPiArwqDCoMKgwqDCoCAqIFZh
bGlkYXRlIHRoZSBoZWFkZXIgYmVmb3JlIGxpYmZkdCB0cnVzdHMgYW55IGhlYWRlciBvZmZzZXRz
L3NpemVzLg0KPiA+ID4gK8KgwqDCoMKgwqAgKiBBbHNvIG1ha2Ugc3VyZSB0aGUgYWR2ZXJ0aXNl
ZCB0b3RhbHNpemUgZml0cyBpbiB0aGUgYmxvYmxpc3QgcmVjb3JkLg0KPiA+ID4gK8KgwqDCoMKg
wqAgKi8NCj4gPiA+ICvCoMKgwqDCoCByZXQgPSBmZHRfY2hlY2tfaGVhZGVyKGZkdCk7DQo+ID4g
PiArwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHJldDsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoCBmZHRfc2l6ZSA9IGZkdF90b3RhbHNp
emUoZmR0KTsNCj4gPiA+ICvCoMKgwqDCoCBpZiAoZmR0X3NpemUgPiBhbGxvY19zaXplKQ0KPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUZEVF9FUlJfVFJVTkNBVEVEOw0K
PiA+IA0KPiA+IGhlcmUgeW91IHJldHVybiBhbiBlcnJvciBmcm9tIHRoZSBsaWJmZHQgZXJyb3Ig
c3BhY2UsIGJ1dC4uLg0KPiA+IA0KPiA+ID4gKw0KPiA+ID4gK8KgwqDCoMKgICpmZHRfc2l6ZXAg
PSBmZHRfc2l6ZTsNCj4gPiA+ICsNCj4gPiA+ICvCoMKgwqDCoCByZXR1cm4gMDsNCj4gPiA+ICt9
DQo+ID4gPiArDQo+ID4gPiDCoCBzdGF0aWMgaW50IGZkdGRlY19hcHBseV9ibG9ibGlzdF9kdG9z
KHZvaWQpDQo+ID4gPiDCoCB7DQo+ID4gPiAtwqDCoMKgwqAgaW50IHJldDsNCj4gPiA+ICvCoMKg
wqDCoCBpbnQgcmV0LCBsaXZlX2ZkdF9zaXplOw0KPiA+ID4gwqDCoMKgwqDCoMKgIHN0cnVjdCBm
ZHRfaGVhZGVyICpsaXZlX2ZkdDsNCj4gPiA+IMKgwqDCoMKgwqDCoCBpbnQgYmxvYl9zaXplOw0K
PiA+ID4gwqDCoMKgwqDCoMKgIHNpemVfdCBwYWRkZWRfc2l6ZSwgbWF4X3NpemU7DQo+ID4gPiBA
QCAtMTc2MCw4ICsxNzgyLDEyIEBAIHN0YXRpYyBpbnQgZmR0ZGVjX2FwcGx5X2Jsb2JsaXN0X2R0
b3Modm9pZCkNCj4gPiA+IMKgwqDCoMKgwqDCoCBpZiAobGl2ZV9mZHQgIT0gZ2QtPmZkdF9ibG9i
KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVOT0VOVDsNCj4g
PiANCj4gPiAuLi4gdGhlIGNhbGxlciByZXR1cm5zIHRoZSBjb2RlcyBmcm9tIHRoZSBzdGFuZGFy
ZCBlcnJuby5oDQo+ID4gDQo+ID4gPiANCj4gPiA+ICvCoMKgwqDCoCByZXQgPSBmZHRkZWNfZ2V0
X3ZhbGlkX2ZkdF9zaXplKGxpdmVfZmR0LCBibG9iX3NpemUsICZsaXZlX2ZkdF9zaXplKTsNCj4g
PiA+ICvCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gcmV0Ow0KPiA+ID4gKw0KPiA+ID4gwqDCoMKgwqDCoMKgIC8qIENhbGN1bGF0ZSB0aGUg
YWxsb3dlZCBwYWRkZWQgc2l6ZSAqLw0KPiA+ID4gLcKgwqDCoMKgIHBhZGRlZF9zaXplID0gZmR0
X3RvdGFsc2l6ZShsaXZlX2ZkdCkgKyBDT05GSUdfU1lTX0ZEVF9QQUQ7DQo+ID4gPiArwqDCoMKg
wqAgcGFkZGVkX3NpemUgPSBsaXZlX2ZkdF9zaXplICsgQ09ORklHX1NZU19GRFRfUEFEOw0KPiA+
ID4gwqDCoMKgwqDCoMKgIG1heF9zaXplID0gYmxvYmxpc3RfZ2V0X3RvdGFsX3NpemUoKSAtIGJs
b2JsaXN0X2dldF9zaXplKCkgKyBibG9iX3NpemU7DQo+ID4gPiDCoMKgwqDCoMKgwqAgaWYgKHBh
ZGRlZF9zaXplID4gbWF4X3NpemUpDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHBhZGRlZF9zaXplID0gbWF4X3NpemU7DQo+ID4gPiBAQCAtMTc3Miw2ICsxNzk4LDcgQEAgc3Rh
dGljIGludCBmZHRkZWNfYXBwbHlfYmxvYmxpc3RfZHRvcyh2b2lkKQ0KPiA+ID4gwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmV0KQ0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4gPiA+IA0KPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBibG9iX3NpemUgPSBwYWRkZWRfc2l6ZTsNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gZmR0X29wZW5faW50byhsaXZlX2ZkdCwgbGl2
ZV9mZHQsIHBhZGRlZF9zaXplKTsNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKHJldCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJldHVybiByZXQ7DQo+ID4gPiBAQCAtMTc4MSwxMiArMTgwOCwyMCBAQCBzdGF0aWMgaW50
IGZkdGRlY19hcHBseV9ibG9ibGlzdF9kdG9zKHZvaWQpDQo+ID4gPiDCoMKgwqDCoMKgwqAgaWYg
KHJldCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
PiA+IA0KPiA+ID4gLcKgwqDCoMKgIC8qIFNocmluayB0aGUgYmxvYiB0byB0aGUgYWN0dWFsIEZE
VCBzaXplICovDQo+ID4gPiArwqDCoMKgwqAgcmV0ID0gZmR0ZGVjX2dldF92YWxpZF9mZHRfc2l6
ZShsaXZlX2ZkdCwgYmxvYl9zaXplLCAmbGl2ZV9mZHRfc2l6ZSk7DQo+ID4gPiArwqDCoMKgwqAg
aWYgKHJldCkNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4g
PiA+ICsNCj4gPiA+IMKgwqDCoMKgwqDCoCByZXQgPSBmZHRfcGFjayhsaXZlX2ZkdCk7DQo+ID4g
PiDCoMKgwqDCoMKgwqAgaWYgKHJldCkNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIHJldDsNCj4gPiA+IA0KPiA+ID4gLcKgwqDCoMKgIHJldHVybiBibG9ibGlzdF9y
ZXNpemUoQkxPQkxJU1RUX0NPTlRST0xfRkRULCBmZHRfdG90YWxzaXplKGxpdmVfZmR0KSk7DQo+
ID4gPiArwqDCoMKgwqAgcmV0ID0gZmR0ZGVjX2dldF92YWxpZF9mZHRfc2l6ZShsaXZlX2ZkdCwg
YmxvYl9zaXplLCAmbGl2ZV9mZHRfc2l6ZSk7DQo+ID4gDQo+ID4gZG9lc24ndCB0aGUgZmR0X3Bh
Y2soKSBhbHJlYWR5IGd1YXJhbnRlZSBhIHZhbGlkIGhlYWRlcj8gQ2FuIHRoZSBwYWNrZWQgc2l6
ZQ0KPiA+IGV4Y2VlZCB0aGUgYmxvYl9zaXplIGlmIHBhY2tpbmcgb25seSBzaHJpbmtzPw0KPiA+
IA0KPiANCj4gVGhpcyBtaWdodCBub3QgaGFwcGVuLCBidXQganVzdCBpbiBvcmRlciB0byBzb2x2
ZSB0aGUgY29tcGxhaW50IGZyb20NCj4gdGhlIGNvdmVyaXR5IHRvb2wsIG90aGVyd2lzZSB3ZSBu
ZWVkIGFuIGV4ZW1wdGlvbi4NCg0KSXMgaXQgc29tZSBraW5nIG9mIG5ldyBVLUJvb3QgcG9saWN5
IHRoYXQgQ292ZXJpdHkgZmFsc2UtcG9zaXRpdmVzIGp1c3RpZnkNCmEgZGVhZCBvciBjYXJnby1j
dWx0IGNvZGU/IFNoYWxsIGl0IG1heWJlIGZpeGVkIGluIENvdmVyaXR5IGl0c2VsZj8NCg0KLS0g
DQpBbGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
