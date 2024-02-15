Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE9FC4829E
	for <u-boot@archiver.kernel.org>; Thu, 15 Feb 2024 11:31:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C50287DD0;
	Thu, 15 Feb 2024 12:30:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=etas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=etas.com header.i=@etas.com header.b="HUNV2o4O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2DDB87D83; Thu, 15 Feb 2024 09:00:49 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7E9F87D6D
 for <u-boot@lists.denx.de>; Thu, 15 Feb 2024 09:00:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=etas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Felix.Nieuwenhuizen@etas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hrok7fPt6KIpZj8jybjWslj2ZME5xN7yprTCqFPIsn3T83lEJvx1Nbg445WpPNnlOrXLWCX2dS2YQR09jXJSPkV5H4mDSS0kBO49aSulOmDHpxkg7o/qqkguhvEAFY9qSERdYltm/6FCiKDX4+LNoVpM5A1yeR5mWGoiKekFwHRjDXu7Xcm4QNHeFIb8VIAFBqaxwiIThZusBUpgrBL3qF7KHfyIBcU8CndxXHVaESGzay0/ZjNkBfdMJG3kLxSBDg29mx/K7oLwJgX8zqDxBnzayqN5WS1THr/ZHM2NLaTsqt1kyUVDBMEwv8URXWpv2cvW/5LkD6c9epm6LHimcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOqzT90QbHXyLoU5mK2Tnl4rn1T1xi6jQshF6x0nIPo=;
 b=D5eSmIe/7wJ652TsSBMCzpDRvvEzTU4lMwF6EbB51m0nVvbVKnCAGkYV4OXODYqjNbMynZ2B7ox1+ePyP82plly9p1dfIGwO/dajRDgZq2iJENz/rnlmp/xRHcx6Q9ujN+3iVD6j0kKMUkP2oHkxqOByWWGr4MjCtCu2vsJhzHaSsYFYt35AJELvsn7F/pU4xY+p0oZaY+Ho9RGF/NkQyGXmOsaRun3RRQG5sUmlMNaTgzGfWThOMRkQ8Yz7AYsvxhJJ6bXiaOmGZ0Vh340vjvhEstmGnU5OMTDxLBf3n95eddi0uJ0McQUTPnelDgJpTt1G2vzYXLl3sj/d3xbY0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=etas.com; dmarc=pass action=none header.from=etas.com;
 dkim=pass header.d=etas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=etas.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOqzT90QbHXyLoU5mK2Tnl4rn1T1xi6jQshF6x0nIPo=;
 b=HUNV2o4O1paVzO2q/QOvNXPua3m/a1ltyulac17chDAYQNHGuIGw4Jzz1a+IDu+fCiTMWtH3O5HYP+Z27YfxMtaMcHQUMs027psTbZNpGvd7uSTNnJ5U7QQgmBZd6hm04N5Myu3phr6609DTseAElVwFwSc4ScZ+vcHvwIUYb+DNev6Evzh4yiAk0iEnPXc45DRkwD31clCKYIwdDDN6i6GNmHGHa535vcfN5eYfFt+XS50SPmydWUTkA0vfMekjyNlo1BRc+Jh03daE9ucWRYDJ5gzApz1mr9I5dI2CNGsif4tU+AGlOjpcMwn1YfTqCTWtXWQwfwTcL3cmSuONpQ==
Received: from DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c1::17)
 by AS8PR10MB7588.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:562::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Thu, 15 Feb
 2024 08:00:41 +0000
Received: from DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9164:3161:14cc:2e8c]) by DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9164:3161:14cc:2e8c%4]) with mapi id 15.20.7292.026; Thu, 15 Feb 2024
 08:00:41 +0000
From: "Nieuwenhuizen Felix (ETAS-DAP/XPC-Fe8)" <Felix.Nieuwenhuizen@etas.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Double free error with ubi_volume_desc/ubi_close_volume
Thread-Topic: Double free error with ubi_volume_desc/ubi_close_volume
Thread-Index: Adpf5FWaRET7VkkPSCuKFbP8PdiGoA==
Date: Thu, 15 Feb 2024 08:00:41 +0000
Message-ID: <DB9PR10MB4924F174A9B11749A43FFD5D884D2@DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=etas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4924:EE_|AS8PR10MB7588:EE_
x-ms-office365-filtering-correlation-id: de029690-d4e8-4b21-7633-08dc2dfc34a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ybEsf2HdnZ33/450Zkffmf0refT7d6blwFH6F3CZcZZu3btYA31YbQwqFN7ny/Nu0pgsyayrsFA9iTIZymcLLu0c57ewGJbbQT305M/enna9drufKsXEOQS35cbDxFyStZaLyyqH5c7oAHWhtUJS/XKJJ6MvpYF8Bh1isa6/eN5P37Q7FwXIA3QlvzHxKe35725Q8ka+LV8+u++g4ALTsn9AWky//SPJoQhxOl/AXz0SZM7TjEbSrHQ5pa5WC8bAkVfdXFrC6HbYyC7UmYkSj40312HpnQV/Cg4URImger7729VmWdKcbuViLIQib9AMw4+ZQL6WH/z+jjzjzszjLziO8zGKlfI2ocWcnS56XJxU3dRQ2rJYgtECB5QrF105E6XQxePUOyjlfKufQzi5XRGNZAeL6DEFwQIZCOY2eWFkKSLyuh8r//vlMdG3T7/HXpXZJamTp9IV839/eK8NX8P7tXst30JuWT4w6ecduIKPYYEn18KZ+c0iOCJk95zsmiGvPkRwKDpFo4RvNQeG2s0KXxVPZuuJ/+6064eHdA5R0FIfxxHIg+7SXF0yJzZXzdeXdXNE+sXxVtxPsMgcz1+Uky3dC/QOww+NUvUAF2omuKP6moa2cucVkHfLVF0X
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66446008)(66946007)(64756008)(66556008)(66476007)(76116006)(316002)(41300700001)(6916009)(55016003)(2906002)(5660300002)(8676002)(52536014)(86362001)(26005)(33656002)(8936002)(478600001)(6506007)(9686003)(71200400001)(38070700009)(7696005)(83380400001)(38100700002)(122000001)(82960400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlFMndrLzI4YVdaa0YrWmF2N28zeDZCelVGbjg4Y2wvTWtpcDU5UlNnRTlW?=
 =?utf-8?B?d0gvc3J4a1hvUFpzU3pCWHhsOE41OWkwS3RoM0hBOVc0cEVhdFdQWmcwNFFj?=
 =?utf-8?B?azliSHZ5YmRLUHFpQVNtODFHQUwySWZyZWlidEhzbzRtUlR6WmRsSW92dXJX?=
 =?utf-8?B?Unl0RGNCNDFadFFJQWk1Y0ZmUlBuYXRGSVZpUjJTd2pEajRleGdtaE8ySTdL?=
 =?utf-8?B?Q29ETGdhblQzWll2c29JeGcweDM5OFhvd3hFQXl2Ky84Z1MzKzhFZ2doQ0ky?=
 =?utf-8?B?S3JFOS9OT2ZEdzkvQlBOd0M1b3lMMUlPbE9DUTFTT3ArekROMDhoU0VvWTJ6?=
 =?utf-8?B?eTE1VmxZcklpUzUxRE5IZlVDMkxRTDM1QjZDRk90SzZWQkc1TzhTcElTcXVy?=
 =?utf-8?B?Wm5WcGtnWCtxZWNMekFkYmUzRGtQakkrZ0JUdmVxczJNN3cwUmlCV2g1MXUx?=
 =?utf-8?B?YXZLWnBudVo0ZG9hOEhVeDJIaFBzZ2ZJR3Y2aGtNTTRIeGFjQ3AyU1E2eHZO?=
 =?utf-8?B?MlMvQ293dVRXaWN1dWtoNDVxY284NmRMZ3Bvc1NJcWsvZCtLc1h4OENWYkl5?=
 =?utf-8?B?OFNBTmZZT0lhcmQ1UnJHMWIyaklBL1Jqd0RpVXcwVDdhNnFTU0YzVzFZL0Z3?=
 =?utf-8?B?NzZIRWY4YmpMcTdya3czOTRQRGlscnJtOXkzajBzVi9oYTRCczI4aEJLMWo4?=
 =?utf-8?B?eU1nNU1CcUlORUYyT1pxa1RVWGg1aE5pUEUvcldGSFRaTFdkQXRjbnFXUFJC?=
 =?utf-8?B?Wml1MTVIcm5oSm5hZE1hUXFoeEpFZEtOanMvcjNnelBIdllTeUhwLy9xYmVT?=
 =?utf-8?B?RXROOE5EWmpBK1ZFQjNXWCtRdTBDOEwxWTlyd3Y5SmxSdjFVMS80VUV1STN6?=
 =?utf-8?B?VmVjT05hNVp4ZjF6R3dPTTJLTHBBaERYRWF0bWUzVmcybDRsUC9ITWtPMmpj?=
 =?utf-8?B?eDZjQVNhd3h0VU9WbXBpWm5VcE9WcCtOSGZTNm93QkNUN1dsZXRBbXhmQW1x?=
 =?utf-8?B?dHMycW1ocGIrUXA4RkhhVHJ3OS9Vd25FdWdWcGRyeVl3ZE1sdThRZlBKSlZa?=
 =?utf-8?B?WHhKUkZvbXFrRkZyMGQyckp6aW00VWZTbERoZFVPZWRqUHhOcXVZUE9KMjJL?=
 =?utf-8?B?RGlocmlCYUNZdy9OTGtjQ29YNVdDY1ZmdGFBNEZyeXFUQ1RpNngzTDduVGgy?=
 =?utf-8?B?L3ZSSDQyMU9CMVFuVlYvdTcyOG9nTUl0MUxEdGc1bzFoeXVvQzVSTUgvRXhh?=
 =?utf-8?B?ZUR1KzhNZmJrU2xqbHhJTm15RUI4Sk1rRW03WXdYbGNPWFVXK0JnZG1kUlRO?=
 =?utf-8?B?YnZGUDdab0twSXB4a2tBZXFWKzVHOU9UbGhmN1Fsa0c2dms3TlRqbisxcGZm?=
 =?utf-8?B?NmlhMkdJQzBmSFozbFltbU5LUkhUUVpHNWpYL0RXK1kwNlUyTWxYdGxDTERE?=
 =?utf-8?B?MkR3NFhEcGRQSFYrWmhmM3QyT05TZ1Yzb3ZPY1Z3UktrL1NlSXJKZGVsWkdu?=
 =?utf-8?B?bFFVWk1GMHo0MHkxNCs1eFlJTXlucmthYzk1aHlOdW1GN0hwOHdJSHRqZ25m?=
 =?utf-8?B?Yk85bDVKZHFwSFJHQmlJVy9KQ05lVmgydGEraVk4enduVmhjdHZiNkcyRUtR?=
 =?utf-8?B?enB3ZlhubU8xd1pMbXF1SDV3U0tKVllBVkI1bU5VYkpZdTl1SHh4bG5pM0F6?=
 =?utf-8?B?ZHcxMkplQXNKbXNCajBmTlFUMkIyUmlTNTg0Y0t6YXJHbm1nWlRqZHFtdXNn?=
 =?utf-8?B?N3Z2SHFZZnc2UXRlWVNHcFg1dmV3NktiaXlTRnVkL0EvcVRlL1JhMUdLcytj?=
 =?utf-8?B?ZTBFTitNY1VWc1l0dUlHci9STW5heEc0OGRzRkJsdnpWUS8zRm8xeVM4czc1?=
 =?utf-8?B?WUp6eXIraC8xOExMVVlOV1ZYY1M5MlNPbE1yREZIYlJtTVhKaFlQMTJJYVRP?=
 =?utf-8?B?OHFiNkppdUZzQWZ4V3VjOEc5Z0ZwNzlmMWF0YXN0WDhmYkRuUElLM0piblhQ?=
 =?utf-8?B?RFFCZmNYSitkdXE5TG00N2MxV3VRdW5yazZrV3RHQ1JJanBVOU5FQXBJaDVo?=
 =?utf-8?B?TW1nVW9FaUJONjBkYkh4TVdDdCs0bURwWk1ZZEFIVmx5QXluTC9lbFVDRVpW?=
 =?utf-8?Q?66ng=3D?=
MIME-Version: 1.0
X-OriginatorOrg: etas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4924.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: de029690-d4e8-4b21-7633-08dc2dfc34a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 08:00:41.7843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4/Jw6mlQ+Twx/bNMFfnDEzy97+0U0TQBaLcoFxpJTBSBVUB3NeYk8BYPtb6VlwD4nbpFpvWsAUGP2Js5NOTnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7588
X-Mailman-Approved-At: Thu, 15 Feb 2024 12:30:49 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

SGkgYWxsLA0KDQpJIHNlZW0gdG8gYmUgcnVubmluZyBpbnRvIGEgZG91YmxlIGZyZWUgZXJyb3Ig
d2l0aCB1Ymlfdm9sdW1lX2Rlc2MvdWJpX2Nsb3NlX3ZvbHVtZSBkdXJpbmcgYSB1Ymlmc21vdW50
L3ViaWZzbG9hZC91Ymlmc3Vtb3VudCBzZXF1ZW5jZS4NCg0KVGhpcyBpcyB0aGUgc2VxdWVuY2Ug
dGhhdCBJJ20gc2VlaW5nOg0KDQp1Ymlmc21vdW50DQotIGRvX3ViaWZzX21vdW50DQogIC0gY21k
X3ViaWZzX21vdW50DQogICAgLSB1Ym9vdF91Ymlmc19tb3VudA0KICAgICAgLSB1Ymlmc19tb3Vu
dA0KICAgICAgICAtIG9wZW5fdWJpDQogICAgICAgICAgLSB1Ymlfb3Blbl92b2x1bWUgLT4gcmV0
dXJucyB1Ymlfdm9sdW1lX2Rlc2MgIzENCiAgICAgICAgICAtIG9wZW5fdWJpIHJldHVybnMgdWJp
X3ZvbHVtZV9kZXNjICMxDQogICAgICAgIC0gdWJpX3ZvbHVtZV9kZXNjICMxIHN0b3JlZCBpbiBs
b2NhbCB1YmkgdmFyaWFibGUNCiAgICAgICAgLSB1Ymlmc19maWxsX3N1cGVyDQogICAgICAgICAg
ICAtIHViaV9vcGVuX3ZvbHVtZSByZXR1cm5zIHViaV92b2x1bWVfZGVzYyAjMg0KICAgICAgICAg
ICAgLSB1Ymlfdm9sdW1lX2Rlc2MgIzIgc3RvcmVkIGluIHNiLT5zX2ZzX2luZm8tPnViaQ0KICAg
ICAgICAtIHViaV9jbG9zZV92b2x1bWUodWJpKSBpLmUuIHViaV9jbG9zZV92b2x1bWUodWJpX3Zv
bHVtZV9kZXNjICMxKQ0KICAgICAgICAgIC0ga2ZyZWUodWJpX3ZvbHVtZV9kZXNjICMxKQ0KICAg
ICAgICAtIHNiIHN0b3JlZCBpbiBnbG9iYWwgdWJpZnNfc2IgKGluY2x1ZGluZyB1Ymlfdm9sdW1l
X2Rlc2MgIzIpDQoNCnViaWZzbG9hZA0KLSBkb191Ymlmc19sb2FkDQogIC0gdWJpZnNfbG9hZA0K
ICAgIC0gdWJpZnNfcmVhZA0KICAgICAgLSB1Ymlfb3Blbl92b2x1bWUgLT4gcmV0dXJucyB1Ymlf
dm9sdW1lX2Rlc2MgIzMNCiAgICAgIC0gdWJpX3ZvbHVtZV9kZXNjICMzIHN0b3JlZCBpbiB1Ymlm
c19zYi0+c19mc19pbmZvLT51YmkgKHRoaXMgb3ZlcndyaXRlcyB1Ymlfdm9sdW1lX2Rlc2MgIzIh
KQ0KICAgICAgLSB1YmlfY2xvc2Vfdm9sdW1lKHViaWZzX3NiLT5zX2ZzX2luZm8tPnViaSkgaS5l
LiB1YmlfY2xvc2Vfdm9sdW1lKHViaV92b2x1bWVfZGVzYyAjMykNCiAgICAgICAgLSBrZnJlZSh1
Ymlfdm9sdW1lX2Rlc2MgIzMpDQoNCnViaWZzdW1vdW50DQotIGRvX3ViaWZzX3Vtb3VudA0KICAt
IGNtZF91Ymlmc191bW91bnQNCiAgICAtIHVib290X3ViaWZzX3Vtb3VudA0KICAgICAgLSB1Ymlm
c191bW91bnQodWJpZnNfc2ItPnNfZnNfaW5mbykNCiAgICAgICAgLSB1YmlfY2xvc2Vfdm9sdW1l
KHViaWZzX3NiLT5zX2ZzX2luZm8tPnViaSkgaS5lLiB1YmlfY2xvc2Vfdm9sdW1lKHViaV92b2x1
bWVfZGVzYyAjMykNCiAgICAgICAgICAtIGtmcmVlKHViaV92b2x1bWVfZGVzYyAjMykNCiAgICAg
ICAgICAtIHRoaXMgaXMgYSBkb3VibGUgZnJlZSBlcnJvciwgdWJpX3ZvbHVtZV9kZXNjICMyIHNo
b3VsZCBiZSBjbG9zZWQgaW5zdGVhZCAoYnV0IHRoZSByZWZlcmVuY2UgaGFzIGJlZW4gbG9zdCkh
DQoNClRoZSBpc3N1ZSBzZWVtcyB0byBiZSB0aGF0IHViaWZzX3JlYWQgb3ZlcndyaXRlcyB0aGUg
dWJpX3ZvbHVtZV9kZXNjIHRoYXQncyBzdG9yZWQgaW4gdGhlIHN1cGVyYmxvY2ssIGFuZCB0aHVz
IHViaV92b2x1bWVfZGVzYyAjMiBpcyBuZXZlciBmcmVlZCwgd2hpbGUgdWJpX3ZvbHVtZV9kZXNj
ICMzIGlzIGZyZWVkIHR3aWNlLg0KDQpJJ20gbm90IHN1cmUgd2hhdCB0aGUgY29ycmVjdCBiZWhh
dmlvdXIgc2hvdWxkIGJlOg0KLSBzaG91bGQgdGhlIHZvbHVtZSBiZSBjbG9zZWQgYXQgdGhlIGVu
ZCBvZiB1Ymlmc19tb3VudCwgb3Igc3RheSBvcGVuIHVudGlsIHViaWZzX3Vtb3VudD8NCi0gc2hv
dWxkIHViaWZzX3JlYWQgbm90IG9wZW4gdGhlIHZvbHVtZSBpZiBpdCBpcyBhbHJlYWR5IG9wZW4/
DQoNClRoYW5rcyBpbiBhZHZhbmNlIQ0KDQpSZWdhcmRzLA0KRmVsaXgNCg==
