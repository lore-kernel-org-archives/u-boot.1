Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1477B106F318
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 10:09:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF0F483EAC;
	Thu, 26 Mar 2026 11:09:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="H2eHb11s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECF3F83F86; Thu, 26 Mar 2026 11:09:31 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A94BE83DA6
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 11:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOUwFkGsSzSLELmeXAt+q+ApwN9VCnZNUpu+qzEfsFmKXA/nw1UkXJgCVZdMSxozOPLZCngAsqHr5321jmY31o1jkVlgQGzVTXOV0EEtUA6HhXCDhxfGf6bLS18p3qxli9AsBHE5d+eDck4n7TO0h6BmawOgJBsqA5Yfwdzo3rb4gnimYAt7US89ufxUEXvNDZD54ZrGBy4usKCZx8GShlrHMrH7pWfrQtEy5Y+lPooU0mVO9JGAwdXOTvrNSJqGoz/Nigv/+mza31UrtGjk9TwnfH6Qe7n4D0GAQ0biBD3UT/QYbXkoOjW3aRX/J7qI9TuBXpEZ0BROShd9NcPwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9m0mOOSF8LAF94qX15Du5T403TA79RL7SSWTSieemzs=;
 b=BJF3k+u2APhaAzbiKK9f7Pr3XTsszIH3vl6Ds7XICDWQROMAG06I9RpxIAP1yYTSgKL1oPTilhqQWUUBkehOONKkYkVmNajTLrPTE0rMDUNRS1vsSpjbfChIq6OfgOD0DAlcKR1Beeu6+7H8FmSb3154tCSRlNA/9j0bhk7CVi0JIdEBzJfWU8bnDnHlM4jboLgb/JRPWaB+xZ9un4giiSlCkxL3M7TPk6cl0uHgLzH4xmyW8+hJLMhu5JE6wbI7V2y5ElUFqdKHrnPIDLnRZsY0Tdfe+IGFWr158p2bny+Dl2B+NviR1XhcJuVCtG61971AO9K6LHD7lNHZjoe4dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9m0mOOSF8LAF94qX15Du5T403TA79RL7SSWTSieemzs=;
 b=H2eHb11sGiTJB0MFa+JRjSxxbOnx3FARDcfAmQlQyvEPEjUs0jPgCzLGUojY9D7m17zSS8WKfX48VoFGiVdtPBK7xWOQpw1e6J1bILKN+4LDD3JMkv7+QtvG4WJjrvn+0VMmlDLKprG3p2rSJo9ZyjyzxxIyRSGLDUiv5sR01En9ZX9KLAyJz9o6o1um+kbao9vXuVAc2B/ULNuhJiAzC+8ujbUfIxsSq9IRO6jf+ZBxlVl8x8VZlsV5XiHXhWQIPHo4qiJ8CIxM5T6J7GrTY/knvguTz2lmGX4Ll0/bP2fyKuMVETmJ5TVnkHH7rOni5uR6XHma7g5iUos5diOqfA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10300.eurprd04.prod.outlook.com (2603:10a6:800:218::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.22; Thu, 26 Mar
 2026 10:09:26 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Thu, 26 Mar 2026
 10:09:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Teresa Remmet <T.remmet@phytec.de>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>
CC: Benjamin Hahn <B.Hahn@phytec.de>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, "trini@konsulko.com"
 <trini@konsulko.com>, "festevam@gmail.com" <festevam@gmail.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Yannic Moog
 <Y.Moog@phytec.de>, Leonard Anderweit <L.Anderweit@phytec.de>, Francesco
 Dolcini <francesco.dolcini@toradex.com>, "emanuele.ghidoli@toradex.com"
 <emanuele.ghidoli@toradex.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, matteo.lisi <matteo.lisi@engicam.com>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
Subject: RE: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26fu/SKG2qt2keMIyt632OA4bW9odiAgAAMctCAAA7pgIAA1XPAgABLxwCAADtBgIAABo6AgAFXeYCAAAsRgIAAFz9A
Date: Thu, 26 Mar 2026 10:09:04 +0000
Message-ID: <PAXPR04MB8459BDC32A687313A84530D78856A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
 <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <5f44e3d45ac725c16c61a92fff527f9b7bea2fc4.camel@phytec.de>
 <PAXPR04MB845968E9F7A73809AFAE21E18849A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <fd99509a-315f-4c0d-b300-eba1308f7ff1@kontron.de>
 <acPDFUn4R/nsQcg0@shlinux89>
 <d10bc263-3129-4504-acac-e751c0f8e3c3@kontron.de>
 <acTov6d4vNMnG5qY@shlinux89>
 <62b194ca7fb48a9779b601ad2812ea5b767459c8.camel@phytec.de>
In-Reply-To: <62b194ca7fb48a9779b601ad2812ea5b767459c8.camel@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI0PR04MB10300:EE_
x-ms-office365-filtering-correlation-id: a640a411-6757-4deb-174b-08de8b1fb5b8
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|19092799006|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: n+gN1LWtsuYqVvNq2+dv3ykhpDV8APITln+ObM2UuVc+97FSCTVU4NulSKMD0Zy1bVx1bGRHJURHI1mlM8eddq9V6MT9vMA8BzmoBBbXR2uX3/RpzHjnHUoQNMqAsrlhl5cJlQ2JablaNryQLLJFnAQnlJZrE2XDunbldCSmw5FMhJGFFWglWbk7ux+NHU0OwtRWyyzO8DZVybFKQBzLjzylKrvgyPgCsCuZsSImqTc5nGQc5XJvB+d87vrcs94HitgyJQ2ZsH1Kottf9kv0DWUfgqwe9hCKmReAegIWI6za24Ac9u7RtjQ/iPGJ2nknIqBGTOZMlvY5y+N5kacsLirykizg6KHfU+0ZAuXnJfdy0lmNp9RUxJ5b8VyTLJ9HPIbPFEfqNoQ24DXUIRcvkjXBG8wykCWH3+x3T1WSJlp7ElnixX3HyrSkL+8uotA9xyQy+PsDo6fseWsXecqA/snV/gGIXSUq/qpF9zrQvhmaSlD1PRQwWCGqfZ0lyeFyba0jTDDioFFhX1TSr0I1JAQbMvn3tUK7WDZ04yvKV8wwKUCg9m0OSqFXfp+rYgZJXX596Ya5e6ccMe0gUSmg8Bi9S/xl7bQGip3l/SHVyPIXVSmeM9PptnOzZ7UexXdDdAxHKSR371evW3YCWjtUaQtjr8SAXjd9ZOauMG8ppnlfDmP0A1M+d1E945WODPaSGeEuT8SZVVXvaXSP8as/zrUZ6DXdL20D8jJx2qG+igfPHg4paW5NOSXdUweOAVCjQjNKrttkk7a7VuZpFzx07y/s984rx9zjSoj2g03hOxs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDM0Wi9zTDRTT3JvVExWSXpjTExCSUNOWWhYanI5OEFpUDRPdkNyY3RrajM1?=
 =?utf-8?B?U0dTZlIxMDFmcy9tc05sR1NDZkgyRHVwL0trS3hGdkxQSFhhYjdrMTkzbmpp?=
 =?utf-8?B?QmNyK0FrM3AwMTB4K3hQbFZjdmRETk5aWHI1azl6empCQlZnNTNMaGJsWklS?=
 =?utf-8?B?cXJZSzBqQi9SWEtOL010dTFGRkVDMW5ocXJjeXZwaVQ1YnJtZE1wV3Rid0FB?=
 =?utf-8?B?bVpMYmQxS1JBZDhUSFQvV2NZN0xpN3RSSFpLenRzeUJoQ3d1TkVKekUrd01C?=
 =?utf-8?B?UEJPbERMNzRBNGNlL25Od1JTUEdjaEhvM21TWmlsSmN0NHlaUGhDTm9JSnJY?=
 =?utf-8?B?Zk5PQm5Dcy9RbVdOSFBXWXBOakIzeUlmeC9GRHRVaDN6WUc0dktKRGNRUk96?=
 =?utf-8?B?cTRUc1ZJbWFuamZuZTZVT2FudU83eDd1TENyWXhXdDllY3MrWjlVMmNJYmVM?=
 =?utf-8?B?ai80bElPSjh0dlFCYURqWCsrOHRCRUZTWFBIODdWRGhRWW1NVFNwUWtYelcr?=
 =?utf-8?B?V05lRHE3NGNrUHJyejh6bFNKVFF0bDhsd0RXZjNTd0RDemYvbExxcUdPOGUr?=
 =?utf-8?B?ZFZSeWZsWjFBUi9nWFA1TS9IL3V3TGZ6Uk1RSWNoM2ZZbDlYTzlTQXdvVVZy?=
 =?utf-8?B?d2FKT1BPNUJocHlGL3ozSTkvUVRYZ3pSZWNpRm81amFGWVR6UUMxdGRpY3gx?=
 =?utf-8?B?dFk1OW1iY3ZmRjBSdWR5VTUrRFVQcExmQTNyQnR5VTFVQU9GbnVjM0h0eTVw?=
 =?utf-8?B?OTZPUVRMdHJ1ekN1c1lsZWNpUk5IdktIWExaakNlM1BVaU93TjR4MUtIQVhC?=
 =?utf-8?B?NG5DMFNVZmRWOFZvNXZ1T3JNVDRlK1NJZ3A2YUpsQ0R5ekhMcjNOeUMzSStm?=
 =?utf-8?B?L2MyTnAvZkZrRkVxd24wNVBjUGg0S0dxdlB5VTBldXVZeE1PYlVMWnlqOHQy?=
 =?utf-8?B?WUo0NU1zaWVnT0ltbktxR24vYk5XVzV0V2tWYzhrUTZjOFpOV0FTQWFjNm9O?=
 =?utf-8?B?Rkg4STJlTCtXbS9mbkJmZmgvdjFTZmJtdW4rN080ZkxzZjFTVEdiMkNaWlFL?=
 =?utf-8?B?ZjBjbjhMWmQ5cWVDS0dSa0RBWFkrd0R5K2p4ZFJKOEpSb2Vza1A1ZDE3SGZK?=
 =?utf-8?B?WmhjMHVidzJpSzJNK3IwUmd3a2orcDExMk92Z3NxcVZzSGRsQm9ZaUpGOWdN?=
 =?utf-8?B?TXBmVUw5dTQyY3hwUVhTbzRrYWhsWWg2YmllYkR6SzRHUHlOcG5zcFZmWHk0?=
 =?utf-8?B?RDdNZEpSYVdqLzBYYUIzdy9hVXNROElnNHZOMUViU05IRmpMd3ROcDd1ZWg2?=
 =?utf-8?B?NUk2TWV2WWVZbW0raU5lVVFyNU1XSFp6cFk3L1VvUFFXQ0pHMkh2d24rQ29z?=
 =?utf-8?B?TDlxWnE0dFAxVDN5REZLa2NIalZwUXExR2ZSdjFpVzFLYTJ5R0RXSlNzQ1B1?=
 =?utf-8?B?d1lqSmR3Y01QTWFXUGxpWWxyUHBFb0JsNGZBd1BQcEcvQm0xVjRkcDQzVHdk?=
 =?utf-8?B?WWhpRTRmQVU2a3h2Wml6UUNqemt6eWEzU0hxN3ZtUVNQN29qUEJ0em1BUDM2?=
 =?utf-8?B?NFdJUnd2RnpmT0NKVWk5Q1M4eFBLWDE0ZFJYT2hsQUxtTlpzQ2cybUZUNGM4?=
 =?utf-8?B?N2dINjBDa1lhSEFkc2g3SGo3b3c1QXZ0ck5HSXZZOFlLUjcvNmFtYmVrUlpI?=
 =?utf-8?B?Z0N3VTlqUnJLbVVXWk5PRjcxTFpjcTVUeEkrMjNhZDk1YVRqbG1nOHFvc3oy?=
 =?utf-8?B?ejRSUEEwSWNBR3EweGs2WWc2Z3VUUzg2M2NTV0RlQjB4N2kyY1ZzT1VFRlFQ?=
 =?utf-8?B?SlMyU0RtTzZSUTVlMmxyREZYVWFjOGczZmNhWGhvaHFQcXRmbjVNY00veG5W?=
 =?utf-8?B?b3JudXFud3lReUNHRjZreW16V252S1RIU1JlZ3ltSi9ON2p2YWFTRzFURmdj?=
 =?utf-8?B?dUVTeTMvSjZ4cENFWnczNXF1ZTRXSXYwVWJyN2RzbGt0bkYvZ3g4d2xEN1JE?=
 =?utf-8?B?VlIrcVhCVnZ3VG9PYUxXOVlOMVlaK2JDeU04am9JNm9Tb1lwcFcwbmE3RVNx?=
 =?utf-8?B?SmF0YzZNVnBTTWVjU3R0eUhkUG5jaHVEa2IyUTdHSGN6aklCZlZTekxxQ0pq?=
 =?utf-8?B?WGc2azN0a0VyZEhsNHk3MFNLeHRjb0FTNEVybG8xVVdXMXd6SHhrVk4zNmY3?=
 =?utf-8?B?T3ZzZURQV1FSTWdvaHJsZ1FMOFAvMVJZZHlmWks2OXRUWm1ZK2dYTFpZMWlN?=
 =?utf-8?B?N2E1WEJkNC9jeHJvSElMRkVxWXdmOVQramgwWnI5Nmw4TldaeStvQy83c3BE?=
 =?utf-8?Q?wW6mj5ZkBr9juU29bp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a640a411-6757-4deb-174b-08de8b1fb5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 10:09:04.1622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5me21dN3CzMJFy71b+wJhd59xGvFxWDBXAnJfrxlA/J5JR38eOriA8EHQPepCUjD48vL/ILtdnFtiVNdCWvXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10300
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gaW14OG1wOiBwaHlib2FyZC1wb2xsdXgtcmRrOiBD
b252ZXJ0IHRvDQo+IERNX1BNSUMNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvZnNsX2Vz
ZGhjX2lteC5jDQo+IGIvZHJpdmVycy9tbWMvZnNsX2VzZGhjX2lteC5jDQo+ID4gaW5kZXggMzM1
YjQ0YThhMWEuLmY5MmMwYzkxYzRkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2ZzbF9l
c2RoY19pbXguYw0KPiA+ICsrKyBiL2RyaXZlcnMvbW1jL2ZzbF9lc2RoY19pbXguYw0KPiA+IEBA
IC0xNDU0LDggKzE0NTQsMTEgQEAgc3RhdGljIGludCBmc2xfZXNkaGNfb2ZfdG9fcGxhdChzdHJ1
Y3QNCj4gdWRldmljZQ0KPiA+ICpkZXYpDQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Ow0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB9DQo+ID4NCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cmVndWxhdG9yX2dldF92YWx1ZSh2cW1tY19kZXYpID09IDE4MDAwMDApDQo+ID4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJlZ3VsYXRvcl9nZXRfdmFsdWUodnFtbWNfZGV2KSA9
PSAxODAwMDAwKSB7DQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHByaW50ZigidmFsdWUgaXMgMS44Vj8/Pz8/Pz8/Pz8/Pz9cbiIpOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpdi0+dnMxOF9lbmFi
bGUgPSAxOw0KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0NCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBwcml2LT52czE4X2VuYWJsZSA9IDA7DQo+ID4gwqDCoMKg
wqDCoMKgwqAgfQ0KPiA+IMKgwqDCoMKgwqDCoMKgIHJldHVybiAwOw0KPiA+IMKgfQ0KPiA+DQo+
ID4gSWYgaXNzdWUgZ29uZSwgSSB0aGluayBpc3N1ZSBpcyBjbGVhciwgZHJpdmVyIHRoaW5rIGl0
IGlzIDEuOHYsIGJ1dCBpdA0KPiA+IGlzIDMuM3YgYWN0dWFsbHkuDQo+IA0KPiBXaXRoIHlvdXIg
Q29udmVydCBETV9QTUlDIHBhdGNoc3RhY2sgYW5kIHRoZSBjaGFuZ2UgYWJvdmUgKGFuZA0KPiB3
aXRob3V0IEZyaWVkZXJzIGR0IGNoYW5nZXMpIHRoZSBpc3N1ZSBpcyBnb25lOg0KDQpUaGFua3Mg
Zm9yIGNvbmZpcm1pbmcgdGhpcy4NCg0KLVBlbmcNCg==
