Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4142106F303
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6859283E76;
	Thu, 26 Mar 2026 09:45:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="WhgmP5y4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8C683EAC; Thu, 26 Mar 2026 09:45:00 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0D583CF5
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:44:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=t.remmet@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Blk2AUlrxpBxgLY9NFOXUlou74/+j0C2kJV1GsbutHKOF20jgQ+qD1UlvGhZMgwjXPlha5huy96UDQW53GvnQIDTBEeZH2viSXLG4IRf2Jaa9n5hdJpJDIcZo25dWDcW0K08NwWe4RRNJibvULjNH6D/qBVTuAcPn3pKKJOKZrVjPmpfZs1nxpLQHt/2aCXA7lRoEiAcRur5c7OwFTTUoGIiAPSD/qGw3OmULkTCAzKnQ9p5WsdBpGyl0Ytuvk3C74umrvweoIriI0g31lbLhfVpnmL3G+XYRx3Z1/n2zUertdck3pA8Bq+h/6Cfc6dWMuRhaxONn96lVWQuEBSf9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QHOAAinMbGh2OUv9RCvhkE46azqvo+0TtChxF4/GBMA=;
 b=NtSN7WstvbsCgjeLhYUBR4GfknZJsBl8g0W1MtWjUbm4wN7PdGS2puWeYGoD221YrWHuDLftpphksBoJHTucjzLsU5bxPvm5MT5s/hJmfKIXdxCoVidXBymTdoAgocYq0uLRV3WYm6epWmgpYnTHXN93Xl195jSnc9UkwJHUAS6Vkcdgb6WzCIYXaz7E4v3FFenStzr74l8fk9QEO9tbOPfIlUnrbppZGNk0pzJxLEQe0BEJHkoTYJr0bqS0qfBwvCu49m/i2P796yClUflGB+kZ+AKVXAk5BEYoRpg18egHO3v0LDyvfuX8KaTl/OpZv1zjfAdYo68lttpTQuUYpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QHOAAinMbGh2OUv9RCvhkE46azqvo+0TtChxF4/GBMA=;
 b=WhgmP5y4SLssiT7lNcUWcyccMRXUAV1T9kiBESYKpmtH9AXk+y8Md9e5dseMt8ZZP3Fp0xbxFKNZAoQUzb/iU9kYHHjcTyziM97PgQcIDgWOcMKjoPQued61jG8a+CwZA7LTf//3bpa2GgES70H6GRzxrtLj84GettvNwddntSF4UezjX/PJ29wZonmJMRqi2d+6Q5fJ3Sx97aBTzvCLlF23oIqShDPYedEscW5rH31EIjnNtYVbeLhbjHPuUgcVVFUyQQut7iPwtQCQcpgR8lKjgHZ0itVNImo2qpRSQaKwPH5q2MVLqhqOEbrPVS9FaOFz2r8KWXM18n6QYUlNyw==
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:297::14)
 by AS4P195MB1986.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:586::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.6; Thu, 26 Mar
 2026 08:44:55 +0000
Received: from DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335]) by DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
 ([fe80::efce:766c:909a:9335%3]) with mapi id 15.20.9769.006; Thu, 26 Mar 2026
 08:44:55 +0000
From: Teresa Remmet <t.remmet@phytec.de>
To: "peng.fan@oss.nxp.com" <peng.fan@oss.nxp.com>,
 "frieder.schrempf@kontron.de" <frieder.schrempf@kontron.de>
CC: Benjamin Hahn <B.Hahn@phytec.de>, "sbabic@nabladev.com"
 <sbabic@nabladev.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "festevam@gmail.com"
 <festevam@gmail.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "upstream@lists.phytec.de" <upstream@lists.phytec.de>, Yannic Moog
 <Y.Moog@phytec.de>, Leonard Anderweit <L.Anderweit@phytec.de>,
 "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
 "emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "matteo.lisi@engicam.com" <matteo.lisi@engicam.com>,
 "abbaraju.manojsai@amarulasolutions.com"
 <abbaraju.manojsai@amarulasolutions.com>
Subject: Re: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26vAHASgIg2tUyrTGbfHiDkArW9odiAgAAM/wCAAA5aAIAA4N4AgABAXQCAADtCgIAABo6AgAFXeYCAAAsPAA==
Date: Thu, 26 Mar 2026 08:44:55 +0000
Message-ID: <62b194ca7fb48a9779b601ad2812ea5b767459c8.camel@phytec.de>
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
In-Reply-To: <acTov6d4vNMnG5qY@shlinux89>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1228:EE_|AS4P195MB1986:EE_
x-ms-office365-filtering-correlation-id: 9ddae03e-1922-49ac-d244-08de8b13f49a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: 4/1jahyl1NRXStQm1VXSDiINViUsSUJYs4v6730sVbOav+HYfxxqc2P+iXOfC/0fRrjzFjVgSnj0Y0a1FAppUpIiJnwCa2iLOEpiCTsYFQn1iwqo0GYyKP9kU87M0AralB+LlDSpIYbcV3zSIVUpjeWRlajrNNxlPplsIHR4T3rZg/0G5MvW2pz6Y9qfnstIh0k56juCUwyRLVBZPaGXq8fb44x44D5jSfKG+vQxtHSSH5sc3OYseJqA5JB37oqw07L65NDRYjGd637yU3GS8HMJsJH4l8AqGOjUbbGMolKJ3myQ9IdwTv3IAG20ruT2P8u8spst2BDf4yUMLjGOACC2ygkTf/U96+NMivhXUZFoPB8z1mH2phjNhYPhtSZVHoJFYPNhr8YNuo80A5kXa6buwwyo2sLtuEnCJljUmTs7fstgc2pPPFWPyU1J0PkoJt8fLtWLptR3rzXz90xbPPBRW3SpxHMlUYvXfYW1gjLDDitNT1deOQLRkpONYEPNMPnGNIWWGKxdbPtWhCBACf9QBts5JDlAeJF4kC5Y8lj0rnMZqvoDAUYJpzwKzLyVO4GxE9sFb+8FjAA5UZk3mAWD6SUhpRKXOaJXDr/pjT6jMplU1+QTDbqSZh0sEETaQKTnPWZj/6skWaf3uyLbtABd1Q8Fi0mFL8ZRewpy17TUnEjMXehR+rELBhHDVm4mJ8RpPZSgCPrtW0woXr1WnimJiR9h2TIKIFf6gIgPcU7H8BgAAh/qmDxxd13mdp7sACPXcK5LEDIfWFx7MD0qoguL0LzM8RaTpBVUi1BubWQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1228.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cXN2aVdQN3hOM3hubTVLeUJKYjNpblNzUkR0Y1dPY29FczZYa1g4cDJVM3pv?=
 =?utf-8?B?RFA5elR5OUtZUUdhcDFKY3c0ckRNNXRsaEdKdGVHSWdPQ3FSRnV3WUwyY0J3?=
 =?utf-8?B?MEM2OEZ4a0lGSWJrUDNRNEpqU3g3L1gzMEx6UW14R2NkbDk2NTdMRFBOdlJH?=
 =?utf-8?B?a0hSYnAwRko5eGhvdnh5b1pWZFBxcy8rdHhEM1NleXFIcHUybTVhK0x6RUJJ?=
 =?utf-8?B?V0NYcnlLbFM3NG4rWW91MmtRd1ZlMEllYWJHYXZqdXVjeVl0Vk40czl4VllB?=
 =?utf-8?B?M0s3cG9Wb0dYWHJNdjM5SVoxZVpJbkxSUTIwNkNZOGV4cWNhRmRibnBkdGwr?=
 =?utf-8?B?dTEvSFlObXo3UERWeCs5aFN0Qm1IRlI4ZjZOVmwwRVRDYXgzeUsyM1hoa0t0?=
 =?utf-8?B?Y0lpRkQyWElzRmFyZ2RmTVRzV1RoZUVWcWJ0Q054d0hkZzJzMGw3eVBFVENj?=
 =?utf-8?B?aWl5VDRoZzBpMmREdThRdnN6M0lDM3N2cS9rQzhxakNKSHhzWTF4bTFEWjBL?=
 =?utf-8?B?bnQrbENMNTVGMEVFTFlycHBSa28veVNkWi9HVUNoa1AyN0ZPOWRQZjV0QnRh?=
 =?utf-8?B?LzhrV1ZIUHRMYW92M1FPQUxTMVZQS2wyKzcycEpUQ0FCSHlOSjdoWkJ4Tmk4?=
 =?utf-8?B?b3djV0tRWkFBK2NlUWVXaVVVNmdEV1YzRC9GUk1CRURnR09SNEZlL3VvWUl2?=
 =?utf-8?B?YnJuOEZsYi9HZU5sVEtDbmpSd2QxTi9aR2dqbEhnMTZYUUtDeFF6Ykl3Tm1o?=
 =?utf-8?B?Nm9rRzYrQXFtMzZ3MFdidlNQWWRTaUhsNlB5SzRDd0NDcTErUDFTS01PWFZC?=
 =?utf-8?B?Mkp0bS8wbzFSK2g0QkRvMGZWaTFsT3k0aGF1TjBybVZ1K0dxWGs2Ympnbmtq?=
 =?utf-8?B?LzBES2FkM1NtOVR0SWFwWkJDTXZoUVZ6K1JkVXpzZFI4TUZpZTg2eFNGSER1?=
 =?utf-8?B?QVFQcXp1aC9Nd3BxV0h6RnJ5SWVBQjJqQW1kcm9kTGlrRFN4UnNSWXhrajJP?=
 =?utf-8?B?Z00xaGJab3VjNzJ0RkN6TG1JNGZJUXZnNndOdVBlWHlwdlVCbWV3NjFZazVq?=
 =?utf-8?B?U1pFSUx1dDc4NTNiS0h1K1FqUmw4Sk9VK05nOG5JZ1dXY3hlNGhMeHAvaUNE?=
 =?utf-8?B?SnN3dks2MGVHbSt3VlAvVmZQSExyNmwwV1VDbTM0UFF1dERKeUM5T2UvMEJJ?=
 =?utf-8?B?OTMySVc2QWJwYVY0NXNEcFl6anlSMEVqTWlZcTdFV2dkVmZZaGpROFVZS05q?=
 =?utf-8?B?bVRpL3hpWEFPWWJPS0c1S2l3SkczTlA0SkdNUnpkUFU4UXcyckJXcVM1ZGlT?=
 =?utf-8?B?b1FQUmtTclZvaVZRbS9XSWUxbm9DbG01eW5KdXFKS3FzUUFtK3QwMmcrc0xM?=
 =?utf-8?B?WFpqczJJY3NMVVFmaHcrbkJ4TVFxSlNtK2NBVWdFdnhIdzJOajd2T1g3L2dE?=
 =?utf-8?B?NE1NV1RHWDh6b2dWUWQwSCtWTFFUSGRoWnlsNk12dDBLaDdaOWY2Qjlha1Ay?=
 =?utf-8?B?V1czUVZMSnAwMDlaZDhSVENCRk41QW50dEtnQ3lueWc5cGE0RVVnNkdHcUNl?=
 =?utf-8?B?MGFPNnJBeVhRcWdNUXVDblNPaDdmUi9QaXlhbGptNE85TndpemtzcGxMeFpW?=
 =?utf-8?B?ODFCU3ZIRmdZaUZpS0xLZDBEQWwvclhLUE05YmNzRGQ5cXlneFlBcWhMeStR?=
 =?utf-8?B?dytmTjY1b1FkTmU5QVVrejBna0xiUWh3Y0kxQytjM0ZiWkdQMzZLV2JFc3pr?=
 =?utf-8?B?RUJDRCtoRmlPd1J2dkdSUDdMT3BVK1o3eWdpcHpHMk9CUGdGRVFYTTJwSDE5?=
 =?utf-8?B?WUF6WTFkTFVkRUZ2V3lrc01IQjc1a1ZVV1pkNWRFV090TEdtWWJWNThjaTFT?=
 =?utf-8?B?aDZ4UTFjMmJ3dGtRM2pjT1ZFenJocjdIQ0M1d0NsZmErOEFZbndFOWFodHht?=
 =?utf-8?B?L2FCMytnaStJRDZabEpINDlDLzhtdEJDNTUybmIrZHlHN1YvVUhtREM4L2J2?=
 =?utf-8?B?bVRvVHFTQzJBUk82cjMzN1IvSVB0Q2o2T3VFT0dZenVFcm92WXV3M1duekpQ?=
 =?utf-8?B?TGZqZi8reGpaT2xEUVpKN2xFTSt3VlR6WnBrZW9rWnMvMG9RK1BMRkY5N29X?=
 =?utf-8?B?bkU2dys5TWI4UnN6V3huNFIwdERyYmF5OXd6UFJGYnFDTHJuVW81eWV6aTJ5?=
 =?utf-8?B?UWtVaWlrUytDNnBQU2xqc0JXNFZzcHdVVEROK0RrQWJVVG5zbDlBUWpId2NV?=
 =?utf-8?B?dHVCcXc2bXpCSHh2ZHgvSklRZXN6djVqVjFVT3A0UmczMFowME93M1prdlVE?=
 =?utf-8?B?akRCWllHeE1jMkZJSnNpNmtCeE02Z3lYeGVNd3B2bzVMN09kMDFzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C85452B5C3092E408A10C8C19BF6C535@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1228.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddae03e-1922-49ac-d244-08de8b13f49a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2026 08:44:55.7274 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBqrofz9IK+W6EoaR1wp2PZnJPtMicGiMNCUWeTj8uEQyxn3z0jffJSLlnAWxzeOqS+9QAo/bm0X/Jdt1ht7JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1986
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

SGVsbG8gUGVuZywNCg0KQW0gRG9ubmVyc3RhZywgZGVtIDI2LjAzLjIwMjYgdW0gMTY6MDUgKzA4
MDAgc2NocmllYiBQZW5nIEZhbjoNCj4gSGkgVGVyZXNhLA0KPiANCj4gT24gV2VkLCBNYXIgMjUs
IDIwMjYgYXQgMTI6MzU6NTlQTSArMDEwMCwgRnJpZWRlciBTY2hyZW1wZiB3cm90ZToNCj4gPiBI
aSBQZW5nLA0KPiA+IA0KPiA+IE9uIDI1LjAzLjI2IDEyOjEyLCBQZW5nIEZhbiB3cm90ZToNCj4g
PiA+IEhpIEZyaWVkZXIsDQo+ID4gPiANCj4gPiA+IE9uIFdlZCwgTWFyIDI1LCAyMDI2IGF0IDA4
OjQwOjI2QU0gKzAxMDAsIEZyaWVkZXIgU2NocmVtcGYgd3JvdGU6DQo+ID4gPiA+IE9uIDI1LjAz
LjI2IDA0OjUwLCBQZW5nIEZhbiB3cm90ZToNCj4gPiA+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggMS80XSBpbXg4bXA6IHBoeWJvYXJkLXBvbGx1eC1yZGs6DQo+ID4gPiA+ID4gPiBDb252ZXJ0
IHRvDQo+ID4gPiA+ID4gPiBETV9QTUlDDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEhlbGxv
IFBlbmcsDQo+ID4gPiA+ID4gPiBIZWxsbyBZYW5uaWMsDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4g
PiA+IEFtIERpZW5zdGFnLCBkZW0gMjQuMDMuMjAyNiB1bSAxMzozMyArMDAwMCBzY2hyaWViIFBl
bmcNCj4gPiA+ID4gPiA+IEZhbjoNCj4gPiA+ID4gPiA+ID4gSGkgWWFubmljLA0KPiA+ID4gPiA+
ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNF0gaW14OG1wOiBw
aHlib2FyZC1wb2xsdXgtcmRrOg0KPiA+ID4gPiA+ID4gPiA+IENvbnZlcnQgdG8NCj4gPiA+ID4g
PiA+ID4gPiBETV9QTUlDDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gSGkgUGVu
ZywNCj4gPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiBPbiBUdWUsIDIwMjYtMDMtMjQg
YXQgMTg6MzAgKzA4MDAsIFBlbmcgRmFuIChPU1MpDQo+ID4gPiA+ID4gPiA+ID4gd3JvdGU6DQo+
ID4gPiA+ID4gPiA+ID4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+
ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+ID4gQ29udmVydCB0aGUgYm9hcmQgdG8gdXNl
IERNX1BNSUMgaW5zdGVhZCBvZiB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IGxlZ2FjeSBTUEwNCj4g
PiA+ID4gPiA+ID4gPiBJMkMvUE1JQw0KPiA+ID4gPiA+ID4gPiA+ID4gaGFuZGxpbmcuDQo+ID4g
PiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gPiA+IENoYW5nZXMgaW5jbHVkZToNCj4gPiA+
ID4gPiA+ID4gPiA+IC0gRW5hYmxlIERNX1BNSUMsIERNX1BNSUNfUENBOTQ1MCwgYW5kDQo+ID4g
PiA+ID4gPiA+ID4gU1BMX0RNX1BNSUNfUENBOTQ1MCBpbiBkZWZjb25maWcuDQo+ID4gPiA+ID4g
PiA+ID4gPiAtIERyb3AgbGVnYWN5IFNQTCBJMkMgYW5kIFBNSUMgb3B0aW9ucy4NCj4gPiA+ID4g
PiA+ID4gPiA+IC0gUmVtb3ZlIG1hbnVhbCBJMkMxIHBhZCBzZXR1cCBhbmQgbGVnYWN5DQo+ID4g
PiA+ID4gPiA+ID4gPiBwb3dlcl9wY2E5NDUwX2luaXQoKQ0KPiA+ID4gPiA+ID4gPiA+IHVzYWdl
Lg0KPiA+ID4gPiA+ID4gPiA+ID4gLSBVc2UgRE0tYmFzZWQgcG1pY19nZXQoKSB3aXRoIHRoZSBE
VCBub2RlICJwbWljQDI1Ii4NCj4gPiA+ID4gPiA+ID4gPiA+IC0gVXBkYXRlIFBNSUMgcmVnaXN0
ZXIgcHJvZ3JhbW1pbmcgdG8gdXNlIHN0cnVjdA0KPiA+ID4gPiA+ID4gPiA+ID4gdWRldmljZSBB
UEkuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gdGhlc2UgY2hhbmdlcyBicmVh
ayBzb21ldGhpbmcuDQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gR2V0dGluZw0K
PiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IExvYWRpbmcgRW52aXJvbm1lbnQgZnJv
bSBNTUMuLi4gQ2FyZCBkaWQgbm90IHJlc3BvbmQgdG8NCj4gPiA+ID4gPiA+ID4gPiB2b2x0YWdl
DQo+ID4gPiA+ID4gPiA+ID4gc2VsZWN0ISA6IC0xMTANCj4gPiA+ID4gPiA+ID4gPiAqKiogV2Fy
bmluZyAtIE5vIGJsb2NrIGRldmljZSwgdXNpbmcgZGVmYXVsdA0KPiA+ID4gPiA+ID4gPiA+IGVu
dmlyb25tZW50DQo+ID4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gYW5kIFNEIGNhcmQg
aXMgbm90IGFjY2Vzc2libGUgYXMgYSByZXN1bHQuIEkgYWxzbw0KPiA+ID4gPiA+ID4gPiA+IHdv
cmtlZCBvbiB0aGlzDQo+ID4gPiA+ID4gPiA+ID4gbW9kZXJuaXphdGlvbiBhbmQgZ290IHRoZSBz
YW1lIHJlc3VsdCBhcyB3aXRoIHlvdXINCj4gPiA+ID4gPiA+ID4gPiBjb21taXQuIEhhdmUNCj4g
PiA+ID4gPiA+IG5vdA0KPiA+ID4gPiA+ID4gPiA+IGhhZCB0aW1lIHRvIGludmVzdGlnYXRlIHRo
ZSBjYXVzZSwgeWV0Lg0KPiA+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+ID4gVGhpcyBjaGFuZ2Ug
c2hvdWxkIG5vdCBpbXBhY3Qgc2QsIHVubGVzcyBwbWljIG5vdCBwcm9iZQ0KPiA+ID4gPiA+ID4g
PiBjb3JyZWN0bHkuDQo+ID4gPiA+ID4gPiA+IFlvdSBtYXkgZ2l2ZSBhIGxvb2sgb24gInJlZ3Vs
YXRvcnMiLCAicG1pYyIgaW4gVS1Cb290DQo+ID4gPiA+ID4gPiA+IHNoZWxsLCB0byBzZWUNCj4g
PiA+ID4gPiA+ID4gd2hldGhlciBwbWljIGlzIGdvb2QuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gPiBBbmQgeW91IG1heSBhbHNvIG5lZWQgdG8gY29uZmlybSwgd2hldGhlciBTRCB3b3Jr
cyBvciBub3QNCj4gPiA+ID4gPiA+ID4gd2l0aG91dA0KPiA+ID4gPiA+ID4gdGhpcw0KPiA+ID4g
PiA+ID4gPiBtaWdyYXRpb24gdG8gRE1fUE1JQy4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4g
SSBzZWUgdGhlIHNhbWUgaXNzdWUuIFRoZSBlcnJvciBpcyBnb25lIHdoZW4gdGhlIHBhdGNoIGlz
DQo+ID4gPiA+ID4gPiByZXZlcnRlZCBhZ2Fpbi4NCj4gPiA+ID4gPiA+IFBNSUMgcHJvYmluZyBp
cyB3b3JraW5nIGJ1dCB0aGUgdm9sdGFnZSBjaGFuZ2Ugb2YgU0QtQ2FyZA0KPiA+ID4gPiA+ID4g
aXMgcHJvYmFibHkNCj4gPiA+ID4gPiA+IG5vdC4NCj4gPiA+ID4gPiA+IFdlIGhhdmUgc2V0DQo+
ID4gPiA+ID4gPiBkdHMvdXBzdHJlYW0vc3JjL2FybTY0L2ZyZWVzY2FsZS9pbXg4bXAtcGh5Y29y
ZS1mcHNjLmR0c2k6DQo+ID4gPiA+ID4gPiB2cW1tYy1zdXBwbHkgPSA8JmxkbzU+Ow0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiB3aGljaCByZWZlcmVuY2VzIHRoZSBQTUlDLg0KPiA+ID4gPiA+
ID4gVGhlIGV2ayBpcyBub3QgdXNpbmcgdGhpcyBwcm9wZXJ0eS4NCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBJIHRyaWVkIHRvIGFkZCB2cW1tYy1zdXBwbHkgZm9yIGkuTVg4TVAtRVZLLCBJIG5vdCBz
ZWUNCj4gPiA+ID4gPiBpc3N1ZXMuDQo+ID4gPiA+ID4gTm90IHN1cmUgd2h5IHRoaXMgcHJvcGVy
dHkgaW1wYWN0cyBwaHljb3JlLWZwc2MuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gVGhlIG9ubHkg
c3VzcGVjdGluZyBwb2ludCBpcyANCj4gPiA+ID4gPiANCj4gPiA+ID4gPiAtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiA+ID4gPiBNWDhNUF9JT01VWENf
R1BJTzFfSU8wNF9fVVNESEMyX1ZTRUxFQ1QgMHhjMA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoA0KPiA+ID4gPiA+IE1YOE1QX0lPTVVYQ19H
UElPMV9JTzA0X19VU0RIQzJfVlNFTEVDVCAweDFjMA0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IE5v
IG1vcmUgaWRlYXMgYXMgb2Ygbm93Lg0KPiA+ID4gPiANCj4gPiA+ID4gSSdtIHByZXR0eSBzdXJl
IHRoaXMgaXNzdWUgaXMgcmVsYXRlZCB0byB0aGUgVlNFTEVDVCBzaWduYWwgaW4NCj4gPiA+ID4g
c29tZSB3YXkuDQo+ID4gPiA+IA0KPiA+ID4gPiBXaXRoIE1YOE1QX0lPTVVYQ19HUElPMV9JTzA0
X19VU0RIQzJfVlNFTEVDVCBiZWluZyBzZXQsIHRoZQ0KPiA+ID4gPiBTREhDDQo+ID4gPiA+IGNv
bnRyb2xsZXIgY29udHJvbHMgdGhlIFZTRUxFQ1Qgc2lnbmFsIHRoYXQgZ29lcyBpbnRvIHRoZQ0K
PiA+ID4gPiBTRF9WU0VMIGlucHV0DQo+ID4gPiA+IG9mIHRoZSBQTUlDIGFuZCBzd2l0Y2hlcyB0
aGUgTERPNSBiZXR3ZWVuIDEuOFYgYW5kIDMuM1YuDQo+ID4gPiA+IEludGVybmFsbHkgdGhlDQo+
ID4gPiA+IFBNSUMgdXNlcyB0aGUgc3RhdGUgb2YgU0RfVlNFTCB0byBkZWNpZGUgd2hpY2ggb25l
IG9mIHR3bw0KPiA+ID4gPiB2b2x0YWdlDQo+ID4gPiA+IHJlZ2lzdGVycyBmb3IgTERPNSBpcyB1
c2VkLg0KPiA+ID4gPiANCj4gPiA+ID4gV2hlbiB2cW1tYy1zdXBwbHkgaXMgc2V0LCB0aGUgZHJp
dmVyIGFkZGl0aW9uYWxseSBzZXRzIHRoZQ0KPiA+ID4gPiB2b2x0YWdlIGJ5DQo+ID4gPiA+IHdy
aXRpbmcgdG8gdGhlIFBNSUMgTERPNSB2b2x0YWdlIHJlZ2lzdGVyLiBUaGlzIGNhbiBwb3RlbnRp
YWxseQ0KPiA+ID4gPiBjYXVzZQ0KPiA+ID4gPiBjb25mbGljdHMgYW5kIGxlYWQgdG8gYW4gaW52
YWxpZCBzdGF0ZSwgd2hlcmUgdGhlIGRyaXZlciB0aGlua3MNCj4gPiA+ID4gdGhlIGNhcmQNCj4g
PiA+ID4gaXMgaW4gMS44ViBzdGF0ZSBidXQgdGhlIHZvbHRhZ2UgaXMgc2V0IHRvIDMuM1Ygb3Ig
dGhlIG90aGVyDQo+ID4gPiA+IHdheSByb3VuZC4NCj4gPiA+ID4gDQo+ID4gPiA+IE9uZSB3YXkg
dG8gaGFuZGxlIHRoaXMsIGlzIHRvIHNldCB0aGUgU0lPTiBiaXQgZm9yIHRoZSBWU0VMRUNUDQo+
ID4gPiA+IHNpZ25hbA0KPiA+ID4gPiBhbmQgc3BlY2lmeSB0aGUgc2QtdnNlbC1ncGlvcyBwcm9w
ZXJ0eSBpbiB0aGUgbGRvNSBub2RlLiBUaGlzDQo+ID4gPiA+IGFsbG93cyB0aGUNCj4gPiA+ID4g
UE1JQyBkcml2ZXIgdG8ga25vdyBhYm91dCB0aGUgY3VycmVudCBzdGF0ZSBvZiB0aGUgVlNFTEVD
VA0KPiA+ID4gPiBzaWduYWwgYW5kDQo+ID4gPiA+IHVzZSB0aGUgY29ycmVjdCB2b2x0YWdlIHJl
Z2lzdGVyIHdoZW4gc2V0dGluZyBvciBnZXR0aW5nIHRoZQ0KPiA+ID4gPiBMRE81IHZvbHRhZ2Uu
DQo+ID4gPiA+IA0KPiA+ID4gPiBCZWxvdyB5b3UgY2FuIGZpbmQgc29tZSBwb2ludGVycyBmb3Ig
YWRkaXRpb25hbCBpbmZvcm1hdGlvbi4gSQ0KPiA+ID4gPiBob3BlIHRoaXMNCj4gPiA+ID4gaGVs
cHMgdG8gc29sdmUgdGhlIGlzc3VlIG9uIHlvdXIgYm9hcmQuDQo+ID4gPiANCj4gPiA+IFRoYW5r
cyBmb3IgdGhlIGRldGFpbGVkIGluZm9ybWF0aW9uLiBCdXQgSSBzdGlsbCBoYXZlIGEgcXVlc3Rp
b246DQo+ID4gPiBGb3IgY3VycmVudCBwaHlib2FyZC1wb2xsdXgtcmRrLCB2cW1tYy1zdXBwbHkg
d2lsbCBhbHdheXMgdXNlDQo+ID4gPiBQQ0E5NDUwX0xETzVDVFJMX0ggZm9yIHJlZ3VsYXRvciB2
YWx1ZSBjb25maWd1cmF0aW9uLg0KPiA+ID4gDQo+ID4gPiBJbiBkcml2ZXJzL21tYy9mc2xfZXNk
aGNfaW14LmMsIHdoZW4gY29uZmlndXJlIHdpdGggMy4zViwNCj4gPiA+IFBDQTk0NTBfTERPNUNU
UkxfSA0KPiA+ID4gd2lsbCBjb25maWd1cmVkIHRvIDMuM1YsIGJ1dCBTRF9WU0VMIGlzIGxvdywg
c28gbm8gaW1wYWN0LiBXaGVuDQo+ID4gPiBjb25maWd1cmUNCj4gPiA+IHdpdGggMS44ViwgUENB
OTQ1MF9MRE81Q1RSTF9IIHdpbGwgYmUgY29uZmlndXJlZCB0byAxLjhWLCBhbmQNCj4gPiA+IFNE
X1ZTRUwgaXMgaGlnaCwNCj4gPiA+IHNvIGl0IHNob3VsZCB3b3JrLg0KPiA+ID4gDQo+ID4gPiBv
ciBJIG1heSBtaXNzIHNvbWV0aGluZy4NCj4gPiANCj4gPiBJIHRoaW5rIHlvdSBhcmUgcmlnaHQu
IFRoZSBwcm9jZXNzIGlzIHRoZSBzYW1lIGFzIGluIExpbnV4IGFuZCBJDQo+ID4gbmV2ZXINCj4g
PiBzYXcgYW55IGlzc3VlIHRoZXJlLiBKdXN0IHRoZSBmYWN0IHRoYXQgd2hlbiByZWFkaW5nIGJh
Y2sgdGhlDQo+ID4gdm9sdGFnZSBvZg0KPiA+IHRoZSBMRE81IHJlZ3VsYXRvciBpbiBMaW51eCBv
ciBVLUJvb3QgeW91IGNvdWxkIGdldCBhIHdyb25nIHZhbHVlLg0KPiA+IFRoaXMNCj4gPiBjYW4g
YmUgZml4ZWQgYXMgZGVzY3JpYmVkIGJlZm9yZS4NCj4gPiANCj4gPiBTbyBJJ20gcmVhbGx5IG5v
dCBzdXJlIHdoYXQgdGhlIGFjdHVhbCBwcm9ibGVtIGlzLiBJIHJlbWVtYmVyDQo+ID4gaGF2aW5n
IGENCj4gPiBzaW1pbGFyIG9yIHRoZSBzYW1lIGlzc3VlIHdpdGggb3VyIEtvbnRyb24gYm9hcmRz
IGJlZm9yZSBzd2l0Y2hpbmcNCj4gPiB0bw0KPiA+IHRoZSB1cHN0cmVhbSBEVFMgd2l0aCBzZC12
c2VsLWdwaW9zLiBTbyBpdCBtaWdodCBhbHNvIGZpeCB0aGlzDQo+ID4gaXNzdWUNCj4gPiBoZXJl
LCBidXQgb2YgY291cnNlIGl0IHdvdWxkIGJlIGdvb2QgdG8ga25vdyB0aGUgYWN0dWFsIHJlYXNv
bi4NCj4gDQo+IElmIHBvc3NpYmxlLCBwbGVhc2UgaGVscCBkbyBhIHRlc3QuIEFmdGVyIGFwcGx5
aW5nIHRoZSBjb252ZXIgdG8NCj4gRE1fUE1JQw0KPiBwYXRjaCwgdGhlbiBhcHBseSBiZWxvdyBw
YXRjaCB0byBzZWUgd2hldGhlciB5b3UgaXNzdWUgaXMgZ29uZS4NCj4gDQo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL21tYy9mc2xfZXNkaGNfaW14LmMNCj4gYi9kcml2ZXJzL21tYy9mc2xfZXNkaGNf
aW14LmMNCj4gaW5kZXggMzM1YjQ0YThhMWEuLmY5MmMwYzkxYzRkIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL21tYy9mc2xfZXNkaGNfaW14LmMNCj4gKysrIGIvZHJpdmVycy9tbWMvZnNsX2VzZGhj
X2lteC5jDQo+IEBAIC0xNDU0LDggKzE0NTQsMTEgQEAgc3RhdGljIGludCBmc2xfZXNkaGNfb2Zf
dG9fcGxhdChzdHJ1Y3QgdWRldmljZQ0KPiAqZGV2KQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB9DQo+IA0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAo
cmVndWxhdG9yX2dldF92YWx1ZSh2cW1tY19kZXYpID09IDE4MDAwMDApDQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyZWd1bGF0b3JfZ2V0X3ZhbHVlKHZxbW1jX2RldikgPT0g
MTgwMDAwMCkgew0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcHJpbnRmKCJ2YWx1ZSBpcyAxLjhWPz8/Pz8/Pz8/Pz8/P1xuIik7DQo+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcHJpdi0+dnMxOF9lbmFibGUgPSAx
Ow0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHByaXYtPnZzMThfZW5hYmxlID0gMDsNCj4gwqDCoMKgwqDCoMKgwqAgfQ0K
PiDCoMKgwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4gwqB9DQo+IA0KPiBJZiBpc3N1ZSBnb25lLCBJ
IHRoaW5rIGlzc3VlIGlzIGNsZWFyLCBkcml2ZXIgdGhpbmsgaXQgaXMgMS44diwgYnV0DQo+IGl0
IGlzDQo+IDMuM3YgYWN0dWFsbHkuDQoNCldpdGggeW91ciBDb252ZXJ0IERNX1BNSUMgcGF0Y2hz
dGFjayBhbmQgdGhlIGNoYW5nZSBhYm92ZSAoYW5kIHdpdGhvdXQNCkZyaWVkZXJzIGR0IGNoYW5n
ZXMpIHRoZSBpc3N1ZSBpcyBnb25lOg0KDQpbLi4uXQ0KVS1Cb290IDIwMjYuMDQtcmM1LTAwMDA1
LWc1NDhmNzIzZjYzZDktZGlydHkgKE1hciAyNiAyMDI2IC0gMDk6MzQ6MzINCiswMTAwKQ0KDQpD
UFU6ICAgTlhQIGkuTVg4TVBbOF0gUmV2MS4xIEE1MyBhdCAxMjAwIE1Ieg0KQ1BVOiAgIEluZHVz
dHJpYWwgdGVtcGVyYXR1cmUgZ3JhZGUgKC00MEMgdG8gMTA1QykgYXQgMzFDDQpNb2RlbDogUEhZ
VEVDIHBoeUJPQVJELVBvbGx1eCBpLk1YOE1QDQpEUkFNOiAgMiBHaUINCkkvVEM6IFJlc2VydmVk
IHNoYXJlZCBtZW1vcnkgaXMgZW5hYmxlZA0KSS9UQzogRHluYW1pYyBzaGFyZWQgbWVtb3J5IGlz
IGVuYWJsZWQNCkkvVEM6IE5vcm1hbCBXb3JsZCB2aXJ0dWFsaXphdGlvbiBzdXBwb3J0IGlzIGRp
c2FibGVkDQpJL1RDOiBBc3luY2hyb25vdXMgbm90aWZpY2F0aW9ucyBhcmUgZGlzYWJsZWQNCkNv
cmU6ICAyNTQgZGV2aWNlcywgMzIgdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQpXRFQ6
ICAgU3RhcnRlZCB3YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMg
KDYwcw0KdGltZW91dCkNCk1NQzogICB2YWx1ZSBpcyAxLjhWPz8/Pz8/Pz8/Pz8/Pw0KRlNMX1NE
SEM6IDEsIEZTTF9TREhDOiAyDQpMb2FkaW5nIEVudmlyb25tZW50IGZyb20gTU1DLi4uIFJlYWRp
bmcgZnJvbSBNTUMoMSkuLi4gT0sNCkluOiAgICBzZXJpYWxAMzA4NjAwMDANCk91dDogICBzZXJp
YWxAMzA4NjAwMDANCkVycjogICBzZXJpYWxAMzA4NjAwMDANClNFQzA6ICBSTkcgaW5zdGFudGlh
dGVkDQpOZXQ6ICAgZXRoMDogZXRoZXJuZXRAMzBiZTAwMDANCkhpdCBhbnkga2V5IHRvIHN0b3Ag
YXV0b2Jvb3Q6IDANCg0KPiANCj4gRnJpZWRlcidzIGZpeCBpcyBzdGlsbCB0aGUgYmVzdCBmb3Ig
eW91ciBwbGF0Zm9ybSwgeW91IGNvdWxkIGdvIHdpdGgNCj4gdGhhdC4NCj4gT3RoZXIgcGxhdGZv
cm1zIHVzaW5nIHZxbW1jIG1heSBhbHNvIG5lZWRzIHNhbWUgZml4Lg0KDQpPa2F5LCB0aGFua3Mu
IFdlIHdpbGwgdGhlbiBjcmVhdGUgdGhlIGR0IHBhdGNoLg0KDQpUaGFua3MsDQpUZXJlc2ENCg0K
PiANCj4gVGhhbmtzLA0KPiBQZW5nDQo+IA0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IEZy
aWVkZXINCj4gPiANCj4gPiANCg0KLS0gDQpQSFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNl
bG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6
IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBs
Li1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1
NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4gMjYvNjY1LzAwNjA4LCBERSAxNDkwNTk4NTUN
Cg==
