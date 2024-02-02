Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225C6C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 15:08:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46F9587B8C;
	Fri,  2 Feb 2024 16:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="AqmIj0IW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0AB78753E; Fri,  2 Feb 2024 16:08:42 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0726.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::726])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 636ED87B8C
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 16:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XEDbnan6stPsPRCdnTFlnPIkTQnR5SemL83qq7DOfGTR6Hs6ztgvVG3731ljqA+QZkIX3ymwXW4yEyBgj8VLWxGtKd5VpTZ5xG2jSsnwuBfbuHffoWbuwRAzAQaazjdKJ6C82lJxTU9kDvLBRnSvquoKKGb+evtFXqnAu1RNpG9IsLQBc/NucLccG4nbWHzdqrcVWVLKa78S8bExsrj9Za/4hkWBEvTuiY9C6TfTnZi61hevnXUV6fpaKhWmSZBjAAaYBFpitUAsG6wrZfyQVoE2kIkVfzi4fjNTlY4/fV4rITukyhKJr2LdaG6ho8MI3FLlJ/yFJP0+yf8WRFu/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLY03xkstSHRvrVOHLqU1mkGZTiVqj3+Df1x78yKpLo=;
 b=EuD068dkQt1oxXmrjdnGgyB6iWRKognGcMcYFUHXDhIKDg924opv4p9C5nrEbikunXnpgbLAcRFi2058z6WDupqh/D2QBjnmE8eUhplbWC3G+NCDMN5FArz9k/wl645Y/uqEFAOqFnbyD6gGEg0FT1YYXDUL/GiKfI/APhm8neRgFtsszumYU2i979RpvqUJLRGh1JL05PttAsLScJ5EL6YknFdLon7fzlTGmPtosB5Y9oaXQsmtMsLbejhe3jo1uKQLidcXUKc2ezBvZ09SNGnGwyFC7nApYS55m3rsUIZVtnuiwMAk3Lhdj9ppy/s/WgP0RwJ4lPYYdjgFiK3o0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLY03xkstSHRvrVOHLqU1mkGZTiVqj3+Df1x78yKpLo=;
 b=AqmIj0IW3tXKOfg2HmP3ShmyNvlmVq3W5Srb9uhGJQmDgmSsetoisqy9vyKcBsaQH2FhZVrVyyfO5gAKDaCBmVLSfqHrjvLtPK1arEpK3cP6Ws783Gn39+Dtrfxjm9EfTQg4qzgmo08cAuAOWZHebS2FWssqeUyGdtMXWXzxDzE=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB8539.eurprd04.prod.outlook.com (2603:10a6:20b:436::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:08:39 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:08:39 +0000
From: Josua Mayer <josua@solid-run.com>
To: Tom Rini <trini@konsulko.com>
CC: Dennis Gilmore <dgilmore@redhat.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Thread-Topic: [PATCH 3/3] arm: mvebu: helios-4: add defconfig for spi booting
Thread-Index: AQHaRj7DNa2xbuM1UkuvtQ0LZOuCHLDX/bYAgAETLoCAAFD1AIAd5Q8A
Date: Fri, 2 Feb 2024 15:08:38 +0000
Message-ID: <1a58752a-71ac-45eb-bc18-b2263309cbe9@solid-run.com>
References: <20240113-helios4-spi-v1-0-2a5663a10e6a@solid-run.com>
 <20240113-helios4-spi-v1-3-2a5663a10e6a@solid-run.com>
 <20240113172236.GI1610741@bill-the-cat>
 <a28684d7-46e7-46d8-9018-4857de07a3c2@solid-run.com>
 <20240114143716.GJ1610741@bill-the-cat>
In-Reply-To: <20240114143716.GJ1610741@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB8539:EE_
x-ms-office365-filtering-correlation-id: 59634c8f-4549-449e-6f61-08dc2400d61a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AqBdQQlnFlWtqz1vQg/7xk8m+f1ThdEVhgtmzEV6D37sc4y9GSAYTZ+5EoED61U+jMACjvJln/9A/EG8/YIKX0++7+rp9fa79heBe3iBFkkOleIyXm/olCMZUnR2XKWmdILhG5MBlEDx25e9geWRUOJB5O3wfMfufuJKUFcmN9LngUl59eXIrV6xo6HwfW/+17YouMT/eb+sjbsgTEek4r+LqFsrrC1pGfdSs1FyLIAfLNK0s4T4RaHDtlDuyjTV+zre13OSDrkfhqoUFTXlHCsqezkmm57TrpNSv9uQeQ9Mfk999Ya/iiLOW4JtDOSoPkYFMp/IV2Mh3kiAIseCvYpyyrJ5KZPuskoU+3q0guFlxqB9809IuJbRmwLpXqjvMQfsimAMoWxC4gCwQmNZd+6dyCYobmu31/vCO/Zr6pRObAnSLsnJE9pow3pNQzeYA5jXFpu4f3S6hRKKgpCb2XpcsMIwWCe9GkanOVuR+tqq3IYBEretjZ0ywFxL+vpOCNG4d/SxFVkiM4E6qzVjAlaawL1/qX9h8sXEQa1tRvEPNaT5a9e/UD3G9tRs6e0EeFqHycfAIwKYAjSfc6aTPQe5gcKV9BcqlcBuxkvYCtFBlfPOd8IdD2jeW8cs4JP19j+IFijnftnEyAVa74Kt3g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB7586.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(366004)(346002)(136003)(39840400004)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(86362001)(31696002)(36756003)(38070700009)(122000001)(26005)(38100700002)(2616005)(6512007)(6506007)(6486002)(66946007)(2906002)(966005)(478600001)(71200400001)(316002)(76116006)(54906003)(66556008)(66446008)(64756008)(8936002)(66476007)(8676002)(91956017)(6916009)(5660300002)(4326008)(45980500001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkxKZk1WcVErWjM3cHNSRDdRMXVHK2YzeUk2ZytrSTBiWTcrRHBRV0kyMVNr?=
 =?utf-8?B?WWdURkJFZG1kamJ2dUc1elNtOVJtMGZOMWxib1RscjRQVS8rYmNYbkthTVMy?=
 =?utf-8?B?cy9CSGlId2ZCMHhteEpPN1A2cTRnRjBoSks2M2RtNXNzb3dJb3JBNlYwaUxD?=
 =?utf-8?B?THorc1k4U2Rrbndxb29oYmczbFJFcWxWOGVkaCtEUjRhTm5sdkR0Yk0zL2x4?=
 =?utf-8?B?N3IzK1N1N0FOR1U0TllTSG9mc2dQcWlrdlMxNnVOcDVUSlE1eWo2UzBuRk1q?=
 =?utf-8?B?ZmJrSVdnZ2FXeHhFdnRxcjVvMVZSbnJ4OGVVSmFvZXZYRDRmdzhzVzF6UXoz?=
 =?utf-8?B?UThtaTZpVEdid0xWRFVKb2FSakRhUjF4TEQrZVNOTWY0OVdEcVV2VFNTdDBP?=
 =?utf-8?B?TDJYOWUrYUs4TGtHenNVeTFObVJ2WnRRMUpZemNVL0VRMmRwcXBBbzJRVzB2?=
 =?utf-8?B?SHFhNVZ3MmZMTGg3OVdWeE5MYmthZDB5SnV2R2ZCUUZVUDV6WHFqMjlRTGw5?=
 =?utf-8?B?WUJzQVZkSmd2c0VmM3pvdTd1SU5EZnAybXQ1eVUwRmViS096YXorU2VzMzlz?=
 =?utf-8?B?T3QyYUVHemZtbGE5ekZkcHFDZUhDd2x2L2Yvb2NxSnZaRkR1bWZydElRckNP?=
 =?utf-8?B?VUhmeFEzZlE1dWV6TzJzbTBQdmhUeFdHZVNCNW5nN3JHRGI2TXg1RnlwZnlU?=
 =?utf-8?B?bklLanFueWI2eFpVTXJCWXg0Z3BwdlpTRE1peHcwNzAvallmS3lXdUZvYVJw?=
 =?utf-8?B?Yk05cVhnKzE5MnA1QmJVUjFJRmFVUHI4ZFlSL2F3VFZmM0lWcmxoSTNOYUZj?=
 =?utf-8?B?b1UzMzZlWWczbmlOTDBqa1REVTFnR1RENFZhRTVnam5NblZhcHl1T2pKWUx3?=
 =?utf-8?B?SUV3SVQyMXZlNVlyVkhFbXZRbDlUSzhTblZTdjJDd05VbVNMQldPNi9CdWJC?=
 =?utf-8?B?aTQ4N0ZkakZPTnkrQTI2dTJobGMyWmRKd3FhR2RJejREb0JEa01lTm11RGJw?=
 =?utf-8?B?TnM0WVBJMVpCTWs0M1ZLVnpZQUFaM2J5OEF4eTFJQ0gyaHh6RFN5ZkFuNmlN?=
 =?utf-8?B?ckVRcS9ZZjhha24rSlk1YlB2dGVrVUJkWU00YU5mUE5zeGpqVnJUM2t3Z0Vr?=
 =?utf-8?B?S05mM2ZpSlVUd1JqbGpwYjVwT1pMVytxd2lxMEY3TUxpb0NSTGZwZ0ZNU0Rh?=
 =?utf-8?B?RzVwZC9YcENyWGVTclFlVVREREcySlc3TzhXaUhRVHhlazZndGNzTVVKTlZo?=
 =?utf-8?B?Qjl3V2Iwa0dUdUlpL3RzMnY1VE1wd3JtQnMveFJKb0htc01Vbm96Z3hxZ08w?=
 =?utf-8?B?VnVXTnQ0bkhKUU1FTDhtL1JDN01ERUNoWS9iWW1haUxTejQyV1hhaWJueURi?=
 =?utf-8?B?aEY1UDcwM3QvK2Fac1lKTUpLZEZMNzF1a292Q0xMMTI5Tko3dDZtKzhrejlK?=
 =?utf-8?B?WVN2Mjc2Uy83WFl6YzI2d0U5bFJmSXdIYmtYNWtRUEZxbWFPRDdEdzdRdVRx?=
 =?utf-8?B?T1NIUFdlSXJFOEh4TU9DdTRKTFA1ZnZ0WkZjMmVYZys2ZmNROUV0blljV211?=
 =?utf-8?B?WGwrY0VqUk9uMit3NHRUcDRQVURxYUhqc2FuTlNSaWwzQWhkWkFONVlnSjY5?=
 =?utf-8?B?bndCUzF6V3ZNZEpnNytQR0ZkSkREcjRFZDFCaFE5ZFlJUjFIQ1R1ajVJanN2?=
 =?utf-8?B?VWxPclBnWFdRMFdjZmczc3Q5NGZKZ0tGcVpGVjNxQk5NaDNrejM5UlRZRzcz?=
 =?utf-8?B?MUN1amlwUVdLSTJ3Vnd2Um5tcVI1bVBiTlJTR3F5RW8rTFB2ZkJhOUtXQ3pG?=
 =?utf-8?B?Y2VvMHNHNHhCOHB4Ni9kSlBhOGxFRlRyOURWMCtiMWIzZFliZVF3Q2NjWUts?=
 =?utf-8?B?VUpPSmQ0aUFmMUlsT2pPUG5JcU45T0hnYmNlSTd4bGxpbTN1amFqbjNrQjhZ?=
 =?utf-8?B?OCtWS3lEWjFmejBxWEJhaFArN3V6Z2hZeVpqQVJWemx5YUZVRlpRWXBkUmJZ?=
 =?utf-8?B?cVlXK05aRlEvdTNZVERGZ1pRSEdLSldvUEVXb1dNWW0zU1BZWnBibUVVTFFh?=
 =?utf-8?B?TlNoVy9HZkdOUW5DQXV1TVpNOWwzZUFEZzRCQUtlWjkrams5SDN0bVREYmg3?=
 =?utf-8?Q?pklc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <354B4098CDB3094D9BFF81B7A2E81344@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59634c8f-4549-449e-6f61-08dc2400d61a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2024 15:08:39.0072 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qaFoD1BGZsKN9PjNilY8TZPNQDA9+Q2JrE/Qzx6z2wT4Kxk1O9jtveWCotXjeH7ZtMFlYFA3MK+mx6SwjdcQhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8539
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

QW0gMTQuMDEuMjQgdW0gMTU6Mzcgc2NocmllYiBUb20gUmluaToNCj4gT24gU3VuLCBKYW4gMTQs
IDIwMjQgYXQgMDk6NDc6MzFBTSArMDAwMCwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBIaSBUaW0s
DQo+Pg0KPj4gQW0gMTMuMDEuMjQgdW0gMTg6MjIgc2NocmllYiBUb20gUmluaToNCj4+PiBPbiBT
YXQsIEphbiAxMywgMjAyNCBhdCAwNTozNjo1N1BNICswMTAwLCBKb3N1YSBNYXllciB3cm90ZToN
Cj4+Pg0KPj4+PiBBZGQgYSBuZXcgZGVmY29uZmlnIGJhc2VkIG9uIGV4aXN0aW5nIGhlbGlvczRf
Y29uZmlnIGZpbGUgdG8gc3VwcG9ydA0KPj4+PiBib290aW5nIGZyb20gc3BpIGZsYXNoLg0KPj4+
Pg0KPj4+PiBTZXR0aW5ncyBmb3IgZW52aXJvbm1lbnQgbG9jYXRpb24gYXJlIGJhc2VkIG9uIHZl
bmRvciB1LWJvb3Q6DQo+Pj4+IGh0dHBzOi8vZ2l0aHViLmNvbS9rb2JvbC1pby91LWJvb3QvYmxv
Yi9oZWxpb3M0L2luY2x1ZGUvY29uZmlncy9oZWxpb3M0LmgjTDU5DQo+Pj4+DQo+Pj4+IEEgc2Vw
YXJhdGUgZGVmY29uZmlnIGlzIHJlcXVpcmVkIGJlY2F1c2UgdGhlIG9wdGlvbnMgYXJlIG5vdA0K
Pj4+PiBpbnR1aXRpdmUgZnJvbSBtZW51Y29uZmlnLCBudW1lcmljIHZhbHVlcyBpbiBwYXJ0aWN1
bGFyLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQt
cnVuLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBjb25maWdzL2hlbGlvczRfc3BpX2RlZmNvbmZpZyB8
IDgxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gIDEg
ZmlsZSBjaGFuZ2VkLCA4MSBpbnNlcnRpb25zKCspDQo+Pj4gU28sIGEgc3VwZXIgbmV3IHRoaW5n
IHRoYXQgbWlnaHQgYmUgb2YgaW50ZXJlc3QsIGJ1dCBwbGVhc2UgdHJ5IHRoaXMNCj4+PiBzaW5j
ZSBJJ2QgbGlrZSB0byBwcm92ZS9kaXNwcm92ZSB0aGUgdXNlLWNhc2UuICBUaGlzIGNvdWxkIGlu
c3RlYWQgYmU6DQo+Pj4gY29uZmlncy9oZWxpb3M0X3NwaV9kZWZjb25maWc6DQo+Pj4gI2luY2x1
ZGUgImNvbmZpZ3MvaGVsaW9zNF9kZWZjb25maWciDQo+Pj4gLi4uIGVuYWJsZS9kaXNhYmxlIG9w
dGlvbnMgc3BlY2lmaWMgdG8gdGhlIFNQSSBib290IHVzZSBjYXNlIC4uLg0KPj4gSSB3aWxsIHRy
eSBpdCwgSSBsaWtlIHRoZSBpZGVhIGNvbmNlcHR1YWxseS4NCj4gT0suDQo+DQo+Pj4gQW5kIHNv
IG5vdyBib3RoIGJvYXJkcyB3aWxsIG90aGVyd2lzZSBiZSBrZXB0IGluLXN5bmMgZm9yIGdlbmVy
YWwgY29uZmlnDQo+Pj4gY2hhbmdlcy4gIEl0IGNvdWxkIGZ1cnRoZXIgYmUgZG9uZSBhczoNCj4+
PiBjb25maWdzL2hlbGlvczRfc3BpX2RlZmNvbmZpZzoNCj4+PiAjaW5jbHVkZSAiY29uZmlncy9o
ZWxpb3M0X2RlZmNvbmZpZyINCj4+PiAjaW5jbHVkZSAiYm9hcmQva29ib2wvaGVsaW9zNC9zcGli
b290LmNvbmZpZyINCj4+IEhlcmUgaXMgcG90ZW50aWFsIGZvciBtYWtpbmcgaXQgaW5maW5pdGVs
eSBjb21wbGV4Lg0KPj4gRS5nLiBvbmUgbWlnaHQgYXJndWUgdGhlcmUgc2hvdWxkIGJlIGFuIGFy
bWFkYTM4eF9zcGkuY29uZmlnDQo+IFllcywgYW5kIGl0IGRlcGVuZHMgYSBsaXR0bGUgb24gdGhl
IHVzZSBjYXNlcyBvZiB0aGUgaGFyZHdhcmUgcGxhdGZvcm1zDQo+IHdoYXQgbWFrZXMgdGhlIG1v
c3Qgc2Vuc2UuIFRvZGF5IHdlIGhhdmUgc29tZSBUZWdyYSBwbGF0Zm9ybXMgdGhhdA0KPiBzdGFy
dGVkIG91dCB1c2luZyBjb25maWcgZnJhZ21lbnRzLCBidXQgdGhpbmtpbmcgYWJvdXQgaXQgcmln
aHQgbm93DQo+IHNob3VsZCBwZXJoYXBzIGNoYW5nZSB0byB0aGlzIHN0eWxlIG9mIGRlZmNvbmZp
Zy4NClVzaW5nIHRoZSBmcmFnbWVudHMgYXZvaWRzIGFkZGluZyBtb3JlIGRlZmNvbmZpZyBmaWxl
cywNCmFuZCBhZGRpbmcgdG8gTUFJTlRBSU5FUlMgZmlsZS4NClNvIEkgYXR0ZW1wdCB0aGlzIG1l
dGhvZCBmb3IgdjIuDQoNCk15IHJlYXNvbmluZyB3b3VsZCBiZSB0aGF0IGJvb3QgbWVkaWEgcmVs
YXRlZCBvcHRpb25zDQphcmUgbW9zdGx5IG1haW50YWluZXJzIGNob2ljZXMgdG8gYmUgbWFkZSBv
bmNlIHBlciBwcm9kdWN0LA0KYW5kIHRoZW4ga2VwdCBjb25zdGFudC4gU28gaXQgZml0cyBiZXR0
ZXIgaW4gYm9hcmQvIGRpcmVjdG9yeSB0aGFuIGNvbmZpZ3MvLg0KDQo+IE9uIHRoZSBvdGhlciBo
YW5kLCBUSQ0KPiBpcyBpbnRlbnRpb25hbGx5IGFkZGluZyBmZWF0dXJlLmNvbmZpZyBmcmFnbWVu
dHMgYXMgdGhlICJmZWF0dXJlLmNvbmZpZyINCj4gZG9lc24ndCBjaGFuZ2UgYmV0d2VlbiBwYXJ0
cyBvZiB0aGUgSzMgZmFtaWx5IGFuZCBzaG91bGQgYWxzbyBiZSByZS11c2VkDQo+IG9uIGN1c3Rv
bSBkZXNpZ25zIHRvIGVuYWJsZSB0aGF0IGZlYXR1cmUuIFRoaW5ncyBhcmUgbmV3IGVub3VnaCBo
ZXJlDQo+IHRoYXQgSSB3YW50IHBlb3BsZSB0byBleHBlcmltZW50IGFuZCBzZWUgd2hhdCB3b3Jr
cyBiZXN0IGZvciB0aGVpciB1c2UNCj4gY2FzZXMgcmF0aGVyIHRoYW4gcHJvdmlkaW5nIHN0cmlj
dCBydWxlcyBqdXN0IHlldC4NCj4NCg==
