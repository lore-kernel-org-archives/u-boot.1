Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC84C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 13:32:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9FDD876C6;
	Fri, 12 Jan 2024 14:32:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YXGVJSID";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F5A686E05; Fri, 12 Jan 2024 14:32:30 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on0630.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0d::630])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD5E0876C6
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 14:32:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7ehDTPlAs35F1+tCdv8sLY7lvKo2H4um7VctskqwZBfkJtKBs9+vYKmtUKC3Iwh3ctZJJEl6z+6yYhu0C8GMGCBSdOebdknpJZo3CLHlhz7j7N+pP7BxIUe8R8rx1p4fT2OYpjtyqH7D+NDLjb87R+RznNUo9O2pcS2+manR4jzi/Hvcs0MNn0uxzbYQ+hOvg5hHT596y7m2h++pUf+9MT3T9mTxbV3JyqueqRAMToMQeqrZ4XHItHvx1869YLdYi6S6ngRrb06IA7PPkTkzMY3spCcc3n23cxue4szf83yqquZ0FPoIRDpqB3Da+2iai2noJkmtAKrgFzf64aFfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+Bn/wYDdd5O784fDtRHaVyqH9Z+LcqtsxOIsxW4Kh8=;
 b=H7Lt3xBZa9HrgTrpOeG9KKftZIUS2zMJ8sox+4UQSp0AKdBs6UpxyqUwsiQ9Scah6KjSqJ4Kh36+AU/9h4B7eQvJv60W54k1vfHo0GzTwafBGJwh/8e4xooPS+Oas4gA1ZRwj7c7Z+jr2KNqvc/opZ63UW1P16WJzpfl9rkbf0S7Mjuo5EWywP9bMVys1T6nD+DZxYKr0DjDnDFZ4+WtuTvkmuq4YV43H7sA6XOKoYKGvwdtoQLaMjbX8OOrnOeMBaz3E6p7rmM1jbufOjozjbNJ+O2g/sfA88/Hmvy5kOK3eZxky0MaCOoFBG1a2Y+qb3phv4CIQrz7Y4jqV8r0KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+Bn/wYDdd5O784fDtRHaVyqH9Z+LcqtsxOIsxW4Kh8=;
 b=YXGVJSIDIT30XrCo1ywGKOPB0ysIh1ivLbpvq6T2NUBMIDv1N/rcmTkZckwf65N6yFvzXorAEuq/T0TiUmpNDkCPEgg+BEYNaVi+7UemQLu2r07ca4WqEBx6pWQIODXbdb2drQfuAVEzaa/PtHl+Hlg8ad6IgKJ9odQrwYE9FHc=
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS1PR04MB9408.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Fri, 12 Jan
 2024 13:32:25 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::daf2:8c54:d469:793d%7]) with mapi id 15.20.7181.020; Fri, 12 Jan 2024
 13:32:25 +0000
From: Josua Mayer <josua@solid-run.com>
To: Stefan Roese <sr@denx.de>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/2] arm: mvebu: clearfog gtr: add config option to select
 serdes0 interface
Thread-Topic: [PATCH 1/2] arm: mvebu: clearfog gtr: add config option to
 select serdes0 interface
Thread-Index: AQHaQMXk3Hk81s8jLkqI+syUkm/nd7DRYSSAgATU3QA=
Date: Fri, 12 Jan 2024 13:32:25 +0000
Message-ID: <185971d3-4e75-44f7-b4f7-64af236b7f0e@solid-run.com>
References: <20240106-clearfog-gtr-serdes-v1-0-66cbc350c58d@solid-run.com>
 <20240106-clearfog-gtr-serdes-v1-1-66cbc350c58d@solid-run.com>
 <34ed0778-78a0-4a29-b329-638e9e24967a@denx.de>
In-Reply-To: <34ed0778-78a0-4a29-b329-638e9e24967a@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8963:EE_|AS1PR04MB9408:EE_
x-ms-office365-filtering-correlation-id: e29efb38-0152-4245-a393-08dc1372ea16
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nA0y/rWXToGP6hzaXx/PINNkzAr/mSXKjDG+MWdBndS7TRmCeZkyMGwuVZohiDhsZnp/0jVWcBqQf5nEajVpcYDn+lKyklRQINDC62OUuJRqCPfZZSqFfYmIxJV9ITXh9pa3eS9bGoU9KYjciwkJxL70SNl4Pv4asmFVaXMfpwrXma35gxKfmusx3sFcuh8fui9fN/mFP9/wF6WOzhtnNA/Uebfy9Ikepeq36Wiom7acykUQALCdbVG26V+xJikk47fexolCFe67ftbRUsvMd4xpsPRqvwp71ejbhD4WilOC9FQH7QGbly14PLKYWccJZOrhwR0RfAePnvMuKc7QoRL2+cGJT7SyybzHB6HkTYNqYjEHWQU2U0anLITEtmrlTJhrnmrUgvTM1OW4PekS5ct9n3V2K4D8h7zcaHPUCNQLnwCpPMNuMwyid/SjObpBEhDtJ94CoTH1lwbcUbYibfQbP18FoAIPP+2XLDaDM9dG1lVpk0Xxgkz022DoPkJYZw2LplphBgzCtGPdDSMeT8X7lByqGBcnO3AH6PGLQdykQQ/gI0ZCKV+Tbg7uqRVFtAonaVv6fS73u3CD1s3+D8tKnvbps7UCVGqOmnpWyKkI29A+l9x1tAsfmLz3uMTxlnPRsgdcsb5UP/KTflDzNQvfo/erde7s6COyfhRbWJe2Gjx0UEZf3spcQi2n4FGJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(39840400004)(136003)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(36756003)(91956017)(38070700009)(41300700001)(86362001)(66946007)(76116006)(31696002)(316002)(122000001)(38100700002)(66476007)(26005)(6512007)(2616005)(66556008)(2906002)(66446008)(64756008)(6486002)(478600001)(6506007)(71200400001)(6916009)(8936002)(8676002)(5660300002)(4326008)(4744005)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U0RDRkpza1IwNmo5YTJCOW53Y3RSUjdrbGF6bElZQWN4dUhvNEEraFdqMHpj?=
 =?utf-8?B?VTh5Sk9aNlVQaCsvVWFKNUxhUXJVU3kxWHIvN1B2Vml1QklTNjFIVGsyTWl0?=
 =?utf-8?B?V0VZRThONEorbGs5VjcvVlh5L0tnN0VHL0dRQ3FpQXB1Y1lLYWFPNXpaaklQ?=
 =?utf-8?B?bUhUWGlNOFhSQlVvRVE2ZVF1WlNueTUwUTluTDEzL0J6ZG9HdUhTQm5FbDQ5?=
 =?utf-8?B?YmlYeEM2SzJhNWMwNiszYnZ4Y3ZZUzAzUWZ2VHNaMkFFeHBKOTA0UUxLTGFa?=
 =?utf-8?B?K2xnTTFXTnFiZEVtTTl3dUpxQitiRnhoWldmQkROV3J2QVhiU1BlVmp0VGFl?=
 =?utf-8?B?T2cvanZ2K0k1anpXUUZlT1UxanBHOC9ZOG0yTGx4N3BRRVkzNDZWVDNXYlRs?=
 =?utf-8?B?QzcwSHU1RFlsOEZqYUdNVVFpdkE2OVJNQVJtQ2tQbFZUQlppQ2pHM1RYWmhy?=
 =?utf-8?B?NnhGeUpSbTBlZ0R5NTkxWUxEdzhoM2tZaXRzdDdqbjNFZUtOOHVuOGRlVUMw?=
 =?utf-8?B?dVE2N0JzdEZmTW1zVGVtTkNuT1VYaURuenZhSEJWSDBxU0NqdmdxelNSRDZk?=
 =?utf-8?B?NWdudXUvdXR1WXNndFFJZk96clNYTEI0VHpVTDN2bllsdDVEbXhYdlo1bExZ?=
 =?utf-8?B?bS9HeExBaTBkZFZMd2JGZ1lLL2dwWDhBMGxmVy9JQ3FvcVZYcGlZcHEvVGRV?=
 =?utf-8?B?OG14cnQ1UFVCZWc5dXNpcTJkTEJPaEdaeFlpMjh5Q1dCTU1nL3dUdE4zRnZS?=
 =?utf-8?B?SFFJaXhDbFE2cVFjZ2RSRS9VYUJIY0thanB5d0lzc0toSHlNcjRwa05KTHpJ?=
 =?utf-8?B?V01IRmJNNjhadFJCRW9FNllJL3U0ckxvQnQ4Z3l6KzF5VmdjR0hBanpWNEVG?=
 =?utf-8?B?WGh2UzJMNDZFb3p4ZUh5eUYvNU5iOHpWWjRBT3VZVWhSRkw3ZmRESWJ2UWZn?=
 =?utf-8?B?Umw0YnlKTWk2ZFdsN2F5Ny85NDNQY0dYQUQ1dlpiUkF3RkZYS2pDNzNwM1Ny?=
 =?utf-8?B?eHZ6TXZ6YUgxelFVMnAzTk9kaE9DdFhrc0JPcnQ0UWFBemJJTWJ3b0RlV2k4?=
 =?utf-8?B?cHY3OG1RZmo0VmxEQUprM1N1K2NjY0lGeWhCVVIyVEZ6b25hTDY0WUh3SnBG?=
 =?utf-8?B?KzhrRit0L1ZIRFR4ekN3dVdGcFd6bWV2UUxoVXRKNTZRQWFQQ1pGUVRZbXdI?=
 =?utf-8?B?RTBNTFFjTTUwY2lMbVo4ejU3SlVTT3p0UGx1bGRId3ZFVmtqYzhiZHE1bVZr?=
 =?utf-8?B?RWt5dXRJVXFQZzZVOURCOXozVnZvSW1MQ0s1ditzamd2NzVXekJyOEhnZmhz?=
 =?utf-8?B?VzhpUUtQUXlTeWxWM2JHWnR6bVhabERmYVdhbC9GZXVOOWhweVZuRUhZcjJI?=
 =?utf-8?B?NDIyMWdRTWpiak9TMHgwT3dncXJZVFJBLzZqV2dGS0VXbDcyeXdxVmhWVzVj?=
 =?utf-8?B?aFFxckJBL05SaHpodmFweEZxYzJYaXRaRkFzTTBlU2xyUVZxQkhCK0RxK1Uv?=
 =?utf-8?B?czFZSGYwdkJvWXd4S0RYOWp4RVFQdS8yM1pseER0NHV3RXVjczdXM2RHZEtB?=
 =?utf-8?B?YWpHOGlIemtQMTlhSno0emVvNW40TVlwRUxjL1B2UE1nS2JaNFNHK0duYnh5?=
 =?utf-8?B?NEFOMFpKYzdzaENFY2JweGRPNWpxQ094WEJKbmpFZ1BxQWlDYWxLNU5YVkIz?=
 =?utf-8?B?VGRXMGFKWXAyTVVtaFFWRkFYZHh5QTdSK2sreW9ycWEvZHZ2L1BWcm15ZW43?=
 =?utf-8?B?aEpBMWNGZW1kVGNiZnR4bDltMTkrd2FLTHJkNk5qWEVHRkkxRzZoZGV4b29o?=
 =?utf-8?B?c2JEOUNhb2tlTVlFNW5DRmtzdzF1TXJDLzdZeFMvdldiRkg3VnR3RUZFSEVY?=
 =?utf-8?B?V2pSb3RXMlNkV3g3a0V1eHJGWEh2YWxyK3dXenVjK2hlalRIbTVDenZKaWdL?=
 =?utf-8?B?M0M5S0NNTUNweWpLOVVVQzMrZHFoUFFBTWliczk5Mll1azdRTE5ub0MwNTJC?=
 =?utf-8?B?aTY0MkFTT3BFTXY0dGNnVGJpWTJHMXhsME0zOUtkWXJaZytJTDdGaTJxRld0?=
 =?utf-8?B?YlhtRC81dVFkYTNBTmFiQ1FiMitrd005bmVpL0JxeEJiWVplWHJDR2szb2ZB?=
 =?utf-8?Q?jDpB/ZojpexYNeQx8fGXmVSsP?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48FBA4E27273A248ABF3278FA7468E89@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e29efb38-0152-4245-a393-08dc1372ea16
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2024 13:32:25.3865 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZbdCNZawTLqWf5rl0VJCXe+nuGplkhtER664rKy15zpCI652EsYXpKv+y4IDBrZeG7xBmKEmRLR5/KcnO4iK8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9408
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

SGkgU3RlZmFuLA0KDQpBbSAwOS4wMS4yNCB1bSAxMjo0NSBzY2hyaWViIFN0ZWZhbiBSb2VzZToN
Cj4+IMKgICtjaG9pY2UgQ0xFQVJGT0dfR1RSX1NFUkRFUzANCj4+ICvCoMKgwqAgcHJvbXB0ICJT
ZWxlY3QgQ2xlYXJmb2cgR1RSIFNlckRlcyAwIEZ1bmN0aW9uIg0KPj4gK8KgwqDCoCBoZWxwDQo+
PiArwqDCoMKgwqDCoCBTZWxlY3QgZnVuY3Rpb24gZm9yIFNlckRlcyAwIHdoaWNoIGlzIHNoYXJl
ZCBiZXR3ZWVuIENPTjMgYW5kIENPTjE4DQo+PiArwqDCoMKgwqDCoCBmb3IgZWl0aGVyIHBjaS1l
IG9yIHNhdGEuDQo+PiArDQo+PiArY29uZmlnIENMRUFSRk9HX0dUUl9TRVJERVMwX1BDSUUNCj4+
ICvCoMKgwqAgYm9vbCAiUENJLUUgb24gQ09OMyINCj4+ICvCoMKgwqAgZGVmYXVsdCB5DQo+DQo+
IEFmdGVyIGFwcGx5aW5nIHRoaXMgcGF0Y2ggSSBnZXQgdGhpcyB3YXJuaW5nOg0KPg0KPiBib2Fy
ZC9zb2xpZHJ1bi9jbGVhcmZvZy9LY29uZmlnOjUwOndhcm5pbmc6IGRlZmF1bHRzIGZvciBjaG9p
Y2UgdmFsdWVzIG5vdCBzdXBwb3J0ZWQNCj4NCj4gQ291bGQgeW91IHBsZWFzZSB0YWtlIGEgbG9v
az8gDQpUaGFuayB5b3UsIEkgd2FzIG1pc3Rha2VuIGFib3V0IHdoZXJlIHRoZSBkZWZhdWx0IHNl
dHRpbmcgYmVsb25ncyzCoCBhcHBhcmVudGx5IGl0IGJlbG9uZ3MgdG8gdGhlICJjaG9pY2UiIC0g
bm90IGl0cyBlbGVtZW50cy4NCldpbGwgc2VuZCB2MiBzb29uLg0K
