Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C49FAC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 20:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9A34881D6;
	Fri, 12 Apr 2024 22:33:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Ji94F+nT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC5088216; Fri, 12 Apr 2024 22:33:52 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A450987DD3
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 22:33:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NtrcdmlqkPd4eaRq+JZ527mW+60HUmLvHGxLdOa7/18MTSFDHgGDAQklxggiCTAGg7vjD37KzVn5dqZMTyvClabYnzHMBe3l0i9Q1Uoe2sOO3msiHDKpXer/LLz4cCGcGEjk2alkZo0x7EHZg2uOb2SoMRszMdgCrUNy11aONWHVbJ2w7Vimj91qI3mn9jfLjjxtFaNDeupSZ5NOSRQ68JidOSmc+/fT082kEQaFFvw9tJbmXNJ64tOBd1qcA3cPPLvXqy2xQVy2YAt7h5k4Vkl+N1ShiCAU5YWUDB/rKMedXxXC3a6WcEZ1m1VAkxU8s5McJZQ1KgS84jF3JTxJYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXVcy0vnbpZV5wwrrF7RQputrdlGDOjlT6CEPqRqsaI=;
 b=VnVNg5RQNFG0g6YFiKI6c/vFEOKDYdMC8f+RThINoKN8TUwT7kKWKzhYVK7ExFZ/E/FZvYLz/WkMdQY+R8eu7QS7ujlZLXsqiS079ac/uwC3UiUgIUVf+5gbsj9EUo8etSaPS4qJeFv+OStwWGfJ/isuJkoza0A5vuwzApp+CRJ6RI6IYIX/7RY687ILYiszXKgl/OR43chD79STHTpz+Oxb1jWitUYfDvvhaOzEER+6GWEeUOee+P3a7WJbTmeKr1WGnGDXjoDCOA2ix07G9W86Riieg/TFe0/bYuky88sZqvE3WTTB2+bw3xeatJiZPtmQy+8rBbPnmJVNr2v09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXVcy0vnbpZV5wwrrF7RQputrdlGDOjlT6CEPqRqsaI=;
 b=Ji94F+nTGjtkeawPfXiQGiM15ciIlx6K0GMxCzv3G/HI6cc3fzFvsyO2MO7dfMK+ng50lEi8GvZXmIx7M/JKlSd8IdqLDmR4nKt0ptQQa8aWFTCap0z8yFv7r52/kHBdJeLfbpt/487Lgnh+B3husP3lpzSjELd3nDEDfqeTkgWaIZdYdfjnT9z4Ty3X0f2tVaXflZuD3JpGeazE3RP7j2D02VFEP3vC1Wh22qfnsyGaXSsOMmNMaoBLUqPAvumWoux5BMBj72GAugVk0wHCBObR2/S01sLKKp2xR9SSqdgn0PEH/6GgWjvFQ+OnB3VzWayPNnKpgrGQpCtb+j9ndQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB8PR10MB3912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:169::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 20:33:49 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%5]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 20:33:49 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sjoerd@collabora.com"
 <sjoerd@collabora.com>
CC: "sjg@chromium.org" <sjg@chromium.org>, "clamor95@gmail.com"
 <clamor95@gmail.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>, "caleb.connolly@linaro.org"
 <caleb.connolly@linaro.org>, "ivprusov@salutedevices.com"
 <ivprusov@salutedevices.com>, "nm@ti.com" <nm@ti.com>, "marex@denx.de"
 <marex@denx.de>, "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>, 
 "rogerq@kernel.org" <rogerq@kernel.org>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>
Subject: Re: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Thread-Topic: [PATCH v4 2/7] usb: dwc3: Switch to device mode on gadget start
Thread-Index: AQHaRTTcFS2nf817+kSYss4da+VxubFlpwmA
Date: Fri, 12 Apr 2024 20:33:49 +0000
Message-ID: <0dc7e7331852f628cdcb2fe1f59aa32f7d348f4f.camel@siemens.com>
References: <20240112085317.1866449-1-sjoerd@collabora.com>
 <20240112085317.1866449-3-sjoerd@collabora.com>
In-Reply-To: <20240112085317.1866449-3-sjoerd@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB8PR10MB3912:EE_
x-ms-office365-filtering-correlation-id: 2293c3ce-79ea-418e-9353-08dc5b2fdc1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2Zoc2oIVx2VWVmVnMlAuRI2+aPxYVB6+ql6mVJpOaDAd6YUjMrNToV6sFELbYRKv1ycSi/JnAkug/PVXkEaFOivwKQWItDuIu7yQmZiEjPmix02joG9nNmppUJT4N3uGK/EdjdFM85My53zJqlGzCUkXrBQlXYv2X6tKdZikXllu4Aw1nhsLl75zHYFgBeSBBdU0OZCSwSfYOkaOzC3gffeEw6HaogFaELSgdu7FxHwsS6enQYPJMNtvqAkQTUo3VSLInD+fnDRPqVUyWd2L7kcacKyf5VuQZ38oKaYJ3b99tHlFfG1lI2WVNjGaalzo9pitQ0rZLk4BUJtfXwG8RtqC0JPe4FL4DJdofbUxvd6zDFXAjJ5ln4sIfsjAfGQbMs7NTUEnuZChg9V0Ajp7+QZI1HaUIBe5LB3Qx97JcTdJ10nPKgnHvkKvIBmAkgodKkfOfbZhqarzUJJaAuMrab6q84VlLwr/bnIITeI8N1CbrBJ2ky7i2PyvlGqzNYZzGQihcSRP+JVD3L6L84yxsDPGAdzxtuY2bYfq0X4J2WzamIvt3eTHhaFDXdVFyuO13nOpId74fpjjT5b235rkDMZxupCmygc8E4NlGfJOUmUcnGpScIXJRRsWrmdK9MAVVUx119yo8rTzjAI3zvbKE2z3SpWRfSVW+WW8qOitLxQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(7416005)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THdZcnRIaUgrbEtlclk4MTE3cFdGVlBPY1lXUGlHbytNa2plWS9VNUJWd2JQ?=
 =?utf-8?B?R3hPNEtmamQyeWpNYTNLZGhDWThjSkdrYkJoQVdOamd1NkNuREVYRkE4SFV4?=
 =?utf-8?B?UW85M3cxYkNNSWFPTURBbHlkZHc3S3ROS2JLQyt2aVNlZVVjb0dHQnlXSHJQ?=
 =?utf-8?B?aUNVYVcrWkJsSWtiQnJqRjZ3YVIydFpiVTNZM3ZQejF5OTRqbmZPUEZtQzdO?=
 =?utf-8?B?Q0ZYY1B4RjJjRGl4ajYwbzdIL0lkQ2VEQ3drNXVwRlJqVWNTT0xKVEpGL2My?=
 =?utf-8?B?UENkWDI3WlZtWDZoMU1XVkdKdUI0NzRYYVpYekhGMDJsQ2U4K2c4K2ZuV08x?=
 =?utf-8?B?YXR6Z1BZU3RUaWRONDV5Z0dPT2s3VEVITDl0V2ZSN3JsSjJ4YURCamR1cUZw?=
 =?utf-8?B?RHQxZnR1d3BYZ2VvU0lvK1VsZW0yYnV0cUxYVUl3VTFtR2Z3S1BZeWVFbjdq?=
 =?utf-8?B?Nlk5RWczeFBtQzZZOGt3Q3FEOWk2eEVpS0FncUVZbG5HTXpoaDBWZkNqdzlo?=
 =?utf-8?B?S0tIOG5kVkxsQ01jL1dObmN2UEJjTUNuSGhNR2NlajNnRWp4eWFxQVFvLzNI?=
 =?utf-8?B?ZGNjOURMZ1pUeWUvVmlYSVhhYmJBb2c4UEJhSjV1eXVTMWJSTE5pd3FTa3R5?=
 =?utf-8?B?N0F0aXdJQ3BseksvSnpGd2w2bC9LdmhuRGo4UXd2RnJDUVY3S2pndVpWSXMy?=
 =?utf-8?B?QklnSkkwL01DaS83V3lUVU0wQ3BsTkoxME5VbGFQeW43WjRraWhPTU5qSjJi?=
 =?utf-8?B?d1pCQk50cEVlYWdpOHY4WWRjTlN4VWd6SWpqMHp6MDFrTEN6QWk3TkNXRUk2?=
 =?utf-8?B?dUt5bExjSWErU2k3WWp3eW1OSHFOOUsrZk1rL0JNSnpEOGhrR1YzYUhYcVlp?=
 =?utf-8?B?MGp5VngrRVA0ZEZIOG12LzNZeXRlOU1ESUNGbWVLYzRqa1doWTZjcFJ1VTFa?=
 =?utf-8?B?aEpGREpvZkhTcjRiMHV6eEMwS2ErNTc5bTZZeDRadHBrNGhjdWkzUW4vQnpT?=
 =?utf-8?B?STZpb0RBTWIzZEhNYlVIY2c3TFhiRXBBeUt6U2dqV014T3d5aWlrZUtBTmtG?=
 =?utf-8?B?QjIwVEg2eFdBT3FmT3kxZEViTGJlV3FUYml2VE85NWpOVC9nbDJkWFBZWGhx?=
 =?utf-8?B?YTNUZmM1S09Ob2lTWWVmZmwzOGRCUHVFOUR2aXdRc2lrc0tKTTVlRUVwem01?=
 =?utf-8?B?VTRTOW5UUmpRbnE2c2hxWVoyZForSXJmNStjOCtuR3hHRFhyeHhDa21IOTU0?=
 =?utf-8?B?REpRRTBPY01XME1BOGxEa2lWOTlCS0szMWhmM2x3Wk1BYk1HbmdZbHMyUWVt?=
 =?utf-8?B?eG56NTcrS0NENndrMkFhYkZvNk9nTDV2c3dPbFhiMUFiSE9JZmRZdWlVQzVW?=
 =?utf-8?B?SzVQeVpnMllya2U2NjRCdkZsODZDa3RyblIvZncxMGxsby9TUXVsYlk5bG43?=
 =?utf-8?B?ZnNBcER2c0s4RDJYUTF4a1JYR3Z5YlhuWXgvY3c3QTVoUU9tVFdFdWpGVjBJ?=
 =?utf-8?B?ZSsrSExVUnJrZ2Q4b2ZZalYySUdJTmR0clVySWN4eDU1RlhZR1E0cHJjYmR1?=
 =?utf-8?B?SiszQ1E2TUNUNW9pUUhudU1WY0hocCtrbHd3bHRzU3dQTjM2QlNsZnNpRmgr?=
 =?utf-8?B?aUpFcWQvdlZNQjVoM3BNYTZSVE9oMjZHZjB2UHk3TkRlQ1pUcGVXQTNtUzZs?=
 =?utf-8?B?TU4yeXQ4Y1VJWnJIcTVDQnB1R0dOc2Y1K01kZk1BanVkTVE4U2praWFVSE1x?=
 =?utf-8?B?WFR0bm85Y2FjZVRHT3JqOUp0M1ZIYll5SlVOaGJueldrNGYxZjQ1Vjd2T1Iv?=
 =?utf-8?B?aGN6M2RiRjJFMGl2aUFOOGNDY0lqU3JJdmkrVFpWdWtpWlJtMmd0TnpVY1Fy?=
 =?utf-8?B?OU1qQzVYdUdvSVlTNEQ2bjZFVDhiQ3IxejJhUDJpZCttaVZIeUlyMHJaamNt?=
 =?utf-8?B?ckNzWXkxT29rTkhpNXNkdW42UnBqQlVrb2NyenpZb1FBcStXQlVxOEdVOE1o?=
 =?utf-8?B?TEZ5OXlFRTRKWTR2bzlScjF2SWlOWTF4UDd5ZW5xMDJGVUpjUUNDMTQvQnd0?=
 =?utf-8?B?UVZmRDl5TlIwb1V0NUE5cTdyY1lEMkF3WjhTZkJLQVE2V1ZqQm10QVZpem4r?=
 =?utf-8?B?ZEVHdjBNUEgxYzJDQU1FQXdKcHptSnF5S0x6TjhxOTBUS0VOSHVyOHIwTWpZ?=
 =?utf-8?B?OTBLVE5LOU00cVhPaXk0VnI4MGl0bkdEWU94aVRvZm1PeitIMmNQUGRkNE1J?=
 =?utf-8?Q?SH0rUWDZC/0OctF22mqbllk6SiIl1xR3pXetKlZDNQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <536BC635FFC2D84E85FB2DC2EC2628A2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2293c3ce-79ea-418e-9353-08dc5b2fdc1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 20:33:49.4215 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4jEb4NoQqSEoLCrpLD2eYzt5elzzz5O35LETNfefAiHwraCAZE/Q5aZuz6WKHaRDY0oP0sheqEeSvs+0KGiE+o3q74Oa1WT1oyAd7QjZ6g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3912
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

SGkgU2pvZXJkIQ0KDQpPbiBGcmksIDIwMjQtMDEtMTIgYXQgMDk6NTIgKzAxMDAsIFNqb2VyZCBT
aW1vbnMgd3JvdGU6DQo+IFdoZW4gZHJfbW9kZSBpcyAib3RnIiB0aGUgZHdjMyBpcyBpbml0aWFs
bHkgY29uZmlndXJlZCBpbiBfT1RHIG1vZGU7DQo+IEhvd2V2ZXIgaW4gdGhpcyBtb2RlIHRoZSBn
YWRnZXQgZnVuY3Rpb25hbGl0eSBkb2Vzbid0IHdvcmsgd2l0aG91dA0KPiBmdXJ0aGVyIGNvbmZp
Z3VyYXRpb24uIFRvIHJlc29sdmUgdGhhdCBvbiBnYWRnZXQgc3RhcnQgc3dpdGNoIHRvIF9ERVZJ
Q0UNCj4gbW9kZSBnbG9iYWxseSBhbmQgZ28gYmFjayB0byBfT1RHIG9uIHN0b3AgYWdhaW4uDQo+
IA0KPiBGb3IgdGhpcyB0aGUgZHdjM19zZXRfbW9kZSBpcyByZW5hbWVkIHRvIGR3YzNfY29yZV9z
ZXRfbW9kZSB0byBhdm9pZCBhDQo+IGNvbmZsaWN0IHdpdGggdGhlIHNhbWUgZnVuY3Rpb24gZXhw
b3NlZCBieSB4aGNpLWR3YzMNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNqb2VyZCBTaW1vbnMgPHNq
b2VyZEBjb2xsYWJvcmEuY29tPg0KPiBSZXZpZXdlZC1ieTogTWF0dGlqcyBLb3JwZXJzaG9layA8
bWtvcnBlcnNob2VrQGJheWxpYnJlLmNvbT4NCg0KV29ya3MgZm9yIG1lIHdpdGggYm90aCBkcl9t
b2RlICJvdGciIGFuZCAicGVyaXBoZXJhbCIgb24gQU02MjMyOg0KDQpUZXN0ZWQtYnk6IEFsZXhh
bmRlciBTdmVyZGxpbiA8YWxleGFuZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KDQo+IC0tLQ0K
PiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBOZXcgcGF0Y2gNCj4gDQo+IMKgZHJpdmVycy91c2Iv
ZHdjMy9jb3JlLmPCoMKgIHwgMTAgKysrKystLS0tLQ0KPiDCoGRyaXZlcnMvdXNiL2R3YzMvY29y
ZS5owqDCoCB8wqAgMSArDQo+IMKgZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyB8wqAgNiArKysr
KysNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20N
Cg==
