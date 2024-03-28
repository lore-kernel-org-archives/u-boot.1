Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3B0CD1280
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 12:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 075C887F07;
	Thu, 28 Mar 2024 13:51:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="iqQtX0Ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 505CA88073; Thu, 28 Mar 2024 13:51:29 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2072f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::72f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4104187ED7
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:51:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFC6VOUdYV1gNavoAS9Zs3Mp305ECo5Lj9bsKjYEBgVfSmOzS5XHlVWwkF0AjTH5tqdBzcPsDl+jTKozVcsVmBLJNgEG1VWyWelrJJeHpEpbA6ja6rPWuLVHLhESVaSwHVNyBNKAqAUqZZMMrN4yC3OiVzFQq/Ng8W6fORYHA6oMbFh6Rs5gqVA2bFUupue6bJ0YjgrpP5KdLvxjDdD9DH/+rNUichxfGqGw0Ac7soafp+4IkXCwkLwh2cacU6iJsFoaAg0nptMgcMO5C2EGwxYxl5wtD7Ux3AHv9ui8G96sG47q9/dSYqRzvpWAw4e+UZAmjaKrq6JCDSyzbeYuoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gD4o0gUwepMT5yjLsUKm2wPmOoI4Li2Sr+JK3b4NJYk=;
 b=kxeML+k/YlkLqGLs2rtv8Zu9Bz7w7O5FMtYPFJUlsaflcnNMDVBOULoGxoo4uIAXk/fCWatHN3tq7AR0LUpCLOJ4/mQ+42/5cwAgPeBrcY/omm9v5XHL8US+BCS7srWZ3YcHa+W+/FBUv+0rtgCtX9O7SvtrUHZydNFnbcqQxETnTpJGrxgDDhhTNzR1iRdLKMZAlkcMWNGEE4wzped2nmTpm76yFSxIukO8NZYx9FvFSH6AhZa9vCXrq7PUWE6w0z26Y9Bv49csrtCwJFMHunJPQZuk31tJ5LwJxgZxi/glWS0+8ak/1x3nP8GsDuUI8hpwsH8JSw1myJjwNnNypQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gD4o0gUwepMT5yjLsUKm2wPmOoI4Li2Sr+JK3b4NJYk=;
 b=iqQtX0NsuvqAzUGpNmjFCKnbtG+TALjNCKZrm+/QlhYgFwVp0mYZmi3dzOxn4xQAGWXDN5WoO9fkIBPkRGcZPPWMDhM0aGfJxNf6SQlHneWji3ImbBlWLUdxLkeMFTNZsawWVZfWmfxcjNOQ6dXhvZcDpRMoYvg2YEGVVAfTN7o=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB8PR04MB6796.eurprd04.prod.outlook.com (2603:10a6:10:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 12:51:25 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 12:51:24 +0000
From: Josua Mayer <josua@solid-run.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "baruch@tkos.co.il" <baruch@tkos.co.il>, "trini@konsulko.com"
 <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "cgmeiner@igalia.com" <cgmeiner@igalia.com>
Subject: Re: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Topic: [PATCH] mx6cuboxi: Fix Ethernet after DT sync with Linux
Thread-Index: AQHagQqDZm+rU8RW7UKPuP1WrY5GmLFNGzIA
Date: Thu, 28 Mar 2024 12:51:24 +0000
Message-ID: <2fe4eeba-c805-4dbb-a07b-9eb9382c019c@solid-run.com>
References: <20240328122116.2460855-1-festevam@gmail.com>
In-Reply-To: <20240328122116.2460855-1-festevam@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB8PR04MB6796:EE_
x-ms-office365-filtering-correlation-id: f83507ea-ee33-42cc-7b78-08dc4f25c6c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 608GXy/BHb/Zi8nIYaHANsNBA9NJOA1Q04+jK5kVJ/OntW0auY9Dz7cBk5TYhpN06Rp8l1NYPW+YCVOp7QUn475l6yupvyJy4e6mlGNlO4x127SCXEtYJYUk4AKlSdGz+kF03LjJ6rtjQZmrjxgtWSIfp2N9Ia0mYtanC2DB255IR53neiLoAiJdcoxTGWaTV+PhIsAB18HFo8azswq/1/+BRK92qsNs04/RWZlD3NS3/LrSQgWe9IoDFwr2S7lWiZLQf2zHQBHzrfvnUME2edGkzZMMQ44nJ+02TVelIoj2nawuVzINts5mHHMM2JcNQECOJyh+Ux83rFiB9NmHqDPVdI8+53iQ19yVPzwHtvZLy3UvHibHP+76bOlqhpmiRe8pLpvBQj0VpluLG8H6/MWN/EiIoCP6XZlikafK+FJpLIFZMj5XPI5opD8VfOwNSKZIj8KeTN8kVG4Mv0p+PMuMdi9s02OMwwIia073Q583GxYEnM+6v75K5/k6J+0qvi3Z4aLAAbXFz60bqZyQi791xM2rnU4xnbU+cs7ELSm52CRNZFwf3T9pTqX6estJKsKSFW5voMfaNpzBPuXBrCO7t08B2O9n2V3ExZJbTDV6UnaDUX3GT8K94EvQenEjAQJELZTuaTczyUmqlIt0+rmX7S6lvNlOonaWWF5RsgUDTRiahUez72WK6B70MVoxVpM9qUSynawH/NICW1gxVwrLP/EhU6aDhjEsFfzCEg0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzhkMVdnaHRGT0ZaWDBGUWdWY0Y4eFJYZXdqMzBmRDhsbkpwS3Q2RFJnL0dn?=
 =?utf-8?B?TnJpcTlQdFZmUmVIUCtvbVltWWRaeU5ucjY2dlh0Z1JEUUhzRmw1bklyeWU1?=
 =?utf-8?B?SmZZNlFpa0NiR3RMWko4b0NSQlBRZWYyM0FoNjFEUERQdkk5bmpoY0NoL240?=
 =?utf-8?B?K3hiSUMwWTQ5azRBZ3AwSkNOM2hJK1dTZjhZanFkVHFxcW5OS3dGZTRpcmps?=
 =?utf-8?B?dHlTQlRNNXdCRWcvUVZyNE81WFFodWVUWkJIOFVtdjlvaHZlNkQ2MkFjQ0JH?=
 =?utf-8?B?YitkTkNQdzZLTXZweWp2bDMyOERSQmlRWGRYVisxeUZCWTJXUkZ2V2tReWxU?=
 =?utf-8?B?Ui9LRlhaY2hic3V6YTRuZEl4Y1BMdlRTc1dQSUJvUm4wLzNzb3ludXA1ZS80?=
 =?utf-8?B?ZDNPbVdFNUw5RWNYSHJlMEVqYVE2TTZHUVBxNGFZMVE0eXV0aVFYUUloVTA2?=
 =?utf-8?B?K1FQODZFd1h3M3RWT2d1TlRreEhEbzBPcHhWZExqbXhhT3dnd1gwUE93YkY0?=
 =?utf-8?B?ZTgzRFY3WE9QNHAwUWlFTUVodkFnaVF0ZmlsanF5amlaN1ZIclRhY1lSZXlG?=
 =?utf-8?B?dGpnZWxOWXRzdnNGQzNyN2dtQkYzcXFtbHlIcE1NTXd2N2pnS1BMV1ZrZlJZ?=
 =?utf-8?B?VFVXTENjSTliTzZuaUQvcThBSEVKY2JaeVV3UnNXUUEvUm9sdUVlanUxaVpm?=
 =?utf-8?B?VFVuR3hVMGFKNm9zUUtsMTNQYXRpZU1ORXJ5bzNGQ2VYNkI4bngxR21rZjVv?=
 =?utf-8?B?RnJJTTUvNHhmWFc1M0Rqei9GcklHMHhSOWJiYUtMMWEzV1BTdzA5Wmx5V0RS?=
 =?utf-8?B?R3NPN2xhTVF0aGNaMldMZEFJSWhJZllXWUtud2FTcUZGeDRuTSt3UWJNaXFH?=
 =?utf-8?B?WFhFWmhaRmxNdkd6SGVkazlCbUpXSnowaXYrYWl2cTNaSGJBdk41NmUza1pR?=
 =?utf-8?B?VWlYRzlaeXhyanFEcHd5RDRwTEg5MnVEdFlWK0VsZS84M0E5NDdvcEhvckdj?=
 =?utf-8?B?S251SkhmaG10ZlRUT29qTGUyenNBbTJjMWVRNG9LM1RMWEVodVk2aElSeVVV?=
 =?utf-8?B?c2R6MTJOQXg0Q01UWTcwVGczVjZ2OG9PYkFIajVFdVhGaE5ZVHNJaUNjSUxN?=
 =?utf-8?B?dmNjYmo2TkFTMnlEN1lTZENUR25mcWd2QnpkSU82WEtqVjBpZlRkQVhJVlc5?=
 =?utf-8?B?eXVnVytQbm52ZDlxajBjNzNtalhtMTFiVWVSMUZJS3ZPdFl4ZXA2bUZITC9s?=
 =?utf-8?B?eHdBSGwxQVplQnBHYnR6T2xjNStta2ZKaWlJKzgwcURjSlVrM3I3VDVOMEVY?=
 =?utf-8?B?dE5RTEEzYytSbWtSNEZlakF6UVlXTTRnWG0rUmtQZnZkc0Zzbk1RRVhXeFla?=
 =?utf-8?B?SVk2T1UyYUtCL3RrNDZoUjRlWjM3K0YvV0RYc09kWUVEcDNXNllqQnpHdkkw?=
 =?utf-8?B?V3BBVXZOMllYS3VwVDVrTU1qRUlMMEdUbWx5c1B5RXVkQkxBaUxGVEtnYTFm?=
 =?utf-8?B?SDJoSHAwb2U4YXVPaTAwWjZ4blc2Ky9YRkhYSjl0NzhTeHNpaWJoRXlqWSt3?=
 =?utf-8?B?RW0zNVF6Tk5KOGYwOU9rZC80OFBTejl2eE1ZL1ZqVVNWMFl6V0ZBM3RGa0g4?=
 =?utf-8?B?VFFEaHpPL2psRUJaaVF5UWN2bWJrMkc3OHBHYkNQUCtNTTF6aW1mNHJrRU5N?=
 =?utf-8?B?eWdPUjZhTjJGUWJsdUZEWjFibDRscEE0Sk5uWmZSVEptWFliSFNYQi83dTBS?=
 =?utf-8?B?aFlpYnZnOEtmMm92QVVLVEREaTBPTzduV2NldDkyZndvTFo1RW95ZmJiNElw?=
 =?utf-8?B?WUlQeU1JcVJMRFNsWEE1QUZtWFJiS3ZyN0FMZDZUdWRoOEJOV0RaWC91c2li?=
 =?utf-8?B?cjU1VEJGclQyaTRQY2RlakJPTGxSV1dxQXM3MktZWmUxbUtxVVlPYlByeHBC?=
 =?utf-8?B?TmRrdnV3Zll4aE9za00xSS9aSEZmU1BwanBCYmZDdU1yYnVxb3VmTklselRT?=
 =?utf-8?B?U3dLRVF6SXdYbFFLbmwwN2R1L2NSM0tDS1pvczRYYnR1M1pjUjN6YzVMdk9E?=
 =?utf-8?B?US9rOGFUVkQraFEwTnFoQW9pOHZPS1kxSmtvTXJGdXBJci9UeVFPQzR6Y3l4?=
 =?utf-8?Q?8gC4fvB6zjTyv5XA+1C8po091?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8C6CBF5687B5845BED8FEB1F38C4A50@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f83507ea-ee33-42cc-7b78-08dc4f25c6c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 12:51:24.6381 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fme28RwlFetYRE2L7uxNfAwNOjqylDQjLYhswnzC5f0Ep5eGqUiJTzaeO+gQnOa4IkR4NRSLXAwpkHfMFiLL+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6796
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

DQpBbSAyOC4wMy4yNCB1bSAxMzoyMSBzY2hyaWViIEZhYmlvIEVzdGV2YW06DQo+IEZyb206IEpv
c3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPg0KPiBUaGUgaS5NWDYgQ3Vib3gtaSBh
bmQgSHVtbWluZ0JvYXJkcyBjYW4gaGF2ZSBkaWZmZXJlbnQgUEhZcyBhdCB2YXJ5aW5nDQo+IGFk
ZHJlc3Nlcy4gVS1Cb290IG5lZWRzIHRvIGF1dG8tZGV0ZWN0IHdoaWNoIHBoeSBpcyBhY3R1YWxs
eSBwcmVzZW50LA0KPiBhbmQgYXQgd2hpY2ggYWRkcmVzcyBpdCBpcyByZXNwb25kaW5nLg0KPg0K
PiBBdXRvLWRldGVjdGlvbiBmcm9tIG11bHRpcGxlIHBoeSBub2RlcyBzcGVjaWZpZWQgaW4gZGV2
aWNlLXRyZWUgZG9lcyBub3QNCj4gY3VycmVudGx5IHdvcmsgY29ycmVjdC4gQXMgYSB3b3JrLWFy
b3VuZCBtZXJnZSBhbGwgdGhyZWUgcG9zc2libGUgcGh5cw0KPiBpbnRvIG9uZSBub2RlIHdpdGgg
dGhlIHNwZWNpYWwgYWRkcmVzcyAweGZmZmZmZmZmIHdoaWNoIGluZGljYXRlcyB0byB0aGUNCj4g
Z2VuZXJpYyBwaHkgZHJpdmVyIHRvIHByb2JlIGFsbCBhZGRyZXNzZXMuDQo+IEFsc28gZml4dXAg
dGhpcyBmYWtlIGFkZHJlc3MgYmVmb3JlIGJvb3RpbmcgTGludXgsICppZiogYm9vdGluZyB3aXRo
DQo+IFUtQm9vdCdzIGludGVybmFsIGR0Yi4NCj4NCj4gU2lnbmVkLW9mZi1ieTogSm9zdWEgTWF5
ZXIgPGpvc3VhQHNvbGlkLXJ1bi5jb20+DQo+IFtmYWJpbzogQWRkZWQgdGhlIGNoYW5nZXMgdG8g
aW14NnFkbC1zci1zb20tdS1ib290LmR0c2kuXQ0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJpbyBFc3Rl
dmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IFRlc3RlZC1ieTogQ2hyaXN0aWFuIEdtZWluZXIg
PGNnbWVpbmVyQGlnYWxpYS5jb20+DQo+IC0tLQ0KPiAgLi4ucWRsLWh1bW1pbmdib2FyZDItZW1t
Yy1zb20tdjE1LXUtYm9vdC5kdHNpIHwgIDEgKw0KPiAgYXJjaC9hcm0vZHRzL2lteDZxZGwtc3It
c29tLXUtYm9vdC5kdHNpICAgICAgIHwgNDAgKysrKysrKysrKysrKysrKysrKw0KPiAgYm9hcmQv
c29saWRydW4vbXg2Y3Vib3hpL214NmN1Ym94aS5jICAgICAgICAgIHwgIDggKysrLQ0KPiAgMyBm
aWxlcyBjaGFuZ2VkLCA0OCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9hcm0vZHRzL2lteDZxZGwtc3Itc29tLXUtYm9vdC5kdHNpDQo+DQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvaW14NnFkbC1odW1taW5nYm9hcmQyLWVtbWMtc29t
LXYxNS11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg2cWRsLWh1bW1pbmdib2FyZDItZW1t
Yy1zb20tdjE1LXUtYm9vdC5kdHNpDQo+IGluZGV4IGU5YjE4OGVkNjU4Ny4uMzU4Y2Y4YWJjNGZm
IDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvaW14NnFkbC1odW1taW5nYm9hcmQyLWVtbWMt
c29tLXYxNS11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9kdHMvaW14NnFkbC1odW1taW5n
Ym9hcmQyLWVtbWMtc29tLXYxNS11LWJvb3QuZHRzaQ0KPiBAQCAtMSw2ICsxLDcgQEANCj4gIC8v
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKw0KPiAgDQo+ICAjaW5jbHVkZSAiaW14
NnFkbC11LWJvb3QuZHRzaSINCj4gKyNpbmNsdWRlICJpbXg2cWRsLXNyLXNvbS11LWJvb3QuZHRz
aSINCj4gIA0KPiAgLyB7DQo+ICAJYm9hcmQtZGV0ZWN0IHsNCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL2R0cy9pbXg2cWRsLXNyLXNvbS11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg2cWRs
LXNyLXNvbS11LWJvb3QuZHRzaQ0KPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiBpbmRleCAwMDAw
MDAwMDAwMDAuLjRjNWYwNDNlYTkyYQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJt
L2R0cy9pbXg2cWRsLXNyLXNvbS11LWJvb3QuZHRzaQ0KPiBAQCAtMCwwICsxLDQwIEBADQo+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAgT1IgTUlUKQ0KPiArDQo+ICsjaW5j
bHVkZSA8ZHQtYmluZGluZ3MvZ3Bpby9ncGlvLmg+DQo+ICsNCj4gKyZmZWMgew0KPiArCXBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZwaW5jdHJsX21pY3Jvc29t
X2VuZXRfYXI4MDM1PjsNCj4gKwlwaHktaGFuZGxlID0gPCZwaHk+Ow0KPiArCXBoeS1tb2RlID0g
InJnbWlpLWlkIjsNCj4gKw0KPiArCS8qDQo+ICsJICogVGhlIFBIWSBzZWVtcyB0byByZXF1aXJl
IGEgbG9uZy1lbm91Z2ggcmVzZXQgZHVyYXRpb24gdG8gYXZvaWQNCj4gKwkgKiBzb21lIHJhcmUg
aXNzdWVzIHdoZXJlIHRoZSBQSFkgZ2V0cyBzdHVjayBpbiBhbiBpbmNvbnNpc3RlbnQgYW5kDQo+
ICsJICogbm9uLWZ1bmN0aW9uYWwgc3RhdGUgYXQgYm9vdC11cC4gMTBtcyBwcm92ZWQgdG8gYmUg
ZmluZSAuDQo+ICsJICovDQo+ICsJcGh5LXJlc2V0LWR1cmF0aW9uID0gPDEwPjsNCj4gKwlwaHkt
cmVzZXQtZ3Bpb3MgPSA8JmdwaW80IDE1IEdQSU9fQUNUSVZFX0xPVz47DQo+ICsJc3RhdHVzID0g
Im9rYXkiOw0KPiArDQo+ICsJbWRpbyB7DQo+ICsJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAr
CQkjc2l6ZS1jZWxscyA9IDwwPjsNCj4gKw0KPiArCQkvZGVsZXRlLW5vZGUvIGV0aGVybmV0LXBo
eUAxOw0KPiArCQkvZGVsZXRlLW5vZGUvIGV0aGVybmV0LXBoeUA0Ow0KPiArDQo+ICsJCXBoeTog
ZXRoZXJuZXQtcGh5QDAgew0KVGhpcyBub2RlIG5hbWUgaXMgc2hhcmVkIHdpdGggdXBzdHJlYW0g
aW14NnFkbC1zci1zb20uZHRzaQ0KPiArCQkJLyoNCj4gKwkJCSAqIFRoZSBQSFkgY2FuIGFwcGVh
ciBlaXRoZXI6DQo+ICsJCQkgKiAtIEFSODAzNTogYXQgYWRkcmVzcyAwIG9yIDQNCj4gKwkJCSAq
IC0gQURJTjEzMDA6IGF0IGFkZHJlc3MgMQ0KPiArCQkJICogQWN0dWFsIGFkZHJlc3MgYmVpbmcg
ZGV0ZWN0ZWQgYXQgcnVudGltZS4NCj4gKwkJCSAqLw0KPiArCQkJcmVnID0gPDB4ZmZmZmZmZmY+
Ow0KPiArCQkJcWNhLGNsay1vdXQtZnJlcXVlbmN5ID0gPDEyNTAwMDAwMD47DQo+ICsJCQlxY2Es
c21hcnRlZWUtdHctdXMtMWcgPSA8MjQ+Ow0KPiArCQkJYWRpLHBoeS1vdXRwdXQtY2xvY2sgPSAi
MTI1bWh6LWZyZWUtcnVubmluZyI7DQo+ICsJCX07DQo+ICsJfTsNCj4gK307DQo+IGRpZmYgLS1n
aXQgYS9ib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMgYi9ib2FyZC9zb2xpZHJ1
bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMNCj4gaW5kZXggOGVkYWJmNDQwNGMyLi5mYmFiMzllODAw
YTYgMTAwNjQ0DQo+IC0tLSBhL2JvYXJkL3NvbGlkcnVuL214NmN1Ym94aS9teDZjdWJveGkuYw0K
PiArKysgYi9ib2FyZC9zb2xpZHJ1bi9teDZjdWJveGkvbXg2Y3Vib3hpLmMNCj4gQEAgLTQ0Nyw3
ICs0NDcsNyBAQCBzdGF0aWMgaW50IGZpbmRfZXRoZXJuZXRfcGh5KHZvaWQpDQo+ICAgKi8NCj4g
IGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpmZHQsIHN0cnVjdCBiZF9pbmZvICpiZCkNCj4gIHsN
Cj4gLQlpbnQgbm9kZV9waHkwLCBub2RlX3BoeTEsIG5vZGVfcGh5NDsNCj4gKwlpbnQgbm9kZV9w
aHksIG5vZGVfcGh5MCwgbm9kZV9waHkxLCBub2RlX3BoeTQ7DQo+ICAJaW50IHJldCwgcGh5Ow0K
PiAgCWJvb2wgZW5hYmxlX3BoeTAgPSBmYWxzZSwgZW5hYmxlX3BoeTEgPSBmYWxzZSwgZW5hYmxl
X3BoeTQgPSBmYWxzZTsNCj4gIAllbnVtIGJvYXJkX3R5cGUgYm9hcmQ7DQo+IEBAIC00NzksNiAr
NDc5LDEyIEBAIGludCBmdF9ib2FyZF9zZXR1cCh2b2lkICpmZHQsIHN0cnVjdCBiZF9pbmZvICpi
ZCkNCj4gIAkJcmV0dXJuIDA7DQo+ICAJfQ0KPiAgDQo+ICsJLy8gdXBkYXRlIFUtQm9vdCdzIG93
biB1bmlmaWVkIHBoeSBub2RlIHBoeSBhZGRyZXNzLCBpZiBwcmVzZW50DQo+ICsJbm9kZV9waHkg
PSBmZHRfcGF0aF9vZmZzZXQoZmR0LCAiL3NvYy9idXNAMjEwMDAwMC9ldGhlcm5ldEAyMTg4MDAw
L21kaW8vcGh5Iik7DQpUaGlzIG5vZGUgbm8gbG9uZ2VyIGV4aXN0cywgdW5sZXNzIHlvdSByZW5h
bWUgdGhlIHUtYm9vdC1zcGVjaWZpYyBvbmUuDQpUaGUgdS1ib290IG5vZGUgc2hvdWxkIHByb2Jh
Ymx5IGhhdmUgaXRzIG93biBzZXBhcmF0ZSBuYW1lLCB0byBlbnN1cmUNCndlIGRvIG5vdCBmaW5k
IHRoZSB1cHN0cmVhbSBsaW51eCBkdGIgZXRoZXJuZXQtcGh5QDAgbm9kZSBieSBtaXN0YWtlLg0K
PiArCXJldCA9IGZkdF9zZXRwcm9wX3UzMihmZHQsIG5vZGVfcGh5LCAicmVnIiwgcGh5KTsNCj4g
KwlpZiAocmV0IDwgMCkNCj4gKwkJcHJfZXJyKCIlczogZmFpbGVkIHRvIHVwZGF0ZSB1bmlmaWVk
IFBIWSBub2RlIGFkZHJlc3NcbiIsIF9fZnVuY19fKTsNCj4gKw0KPiAgCS8vIHVwZGF0ZSBhbGwg
cGh5IG5vZGVzIHN0YXR1cw0KPiAgCW5vZGVfcGh5MCA9IGZkdF9wYXRoX29mZnNldChmZHQsICIv
c29jL2J1c0AyMTAwMDAwL2V0aGVybmV0QDIxODgwMDAvbWRpby9ldGhlcm5ldC1waHlAMCIpOw0K
PiAgCXJldCA9IGZkdF9zZXRwcm9wX3N0cmluZyhmZHQsIG5vZGVfcGh5MCwgInN0YXR1cyIsIGVu
YWJsZV9waHkwID8gIm9rYXkiIDogImRpc2FibGVkIik7DQo=
