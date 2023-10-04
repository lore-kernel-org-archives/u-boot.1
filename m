Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B894E936E6
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 21:23:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E9608695F;
	Wed,  4 Oct 2023 23:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="d5PaBwnz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A46078667A; Wed,  4 Oct 2023 23:23:10 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C282A8695F
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 23:23:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1696454586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wbGB26XJvd6XDKnEoHk2gEdHd4GoGqbRXFL2HxLF2yQ=;
 b=d5PaBwnza+M0SrJ2UE0ZJRDEEhXwypFqrWU0+ko+34IHnnivn+mbUQlRPGVxu73tyvP8K9
 SA5kg+wCBuv8YrxK8huAKETVip132qQyQcUBByyYGLZ59okXzgF11UFaQYsyGtibupST2e
 Q7WRZcKMjM7/FFdFBvMRdbDM+ffJyJw=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-60-WnPJ4KkKO5-LCACN5bCUxw-3; Wed, 04 Oct 2023 23:23:05 +0200
X-MC-Unique: WnPJ4KkKO5-LCACN5bCUxw-3
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0154.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:32::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Wed, 4 Oct 2023 21:23:02 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::ccb1:8f1e:69ef:d622%5]) with mapi id 15.20.6838.033; Wed, 4 Oct 2023
 21:23:02 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>
CC: =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "sbabic@denx.de" <sbabic@denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, "festevam@gmail.com" <festevam@gmail.com>
Subject: Re: [PATCH] toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg
Thread-Topic: [PATCH] toradex: verdin-imx8mm/imx8mp: Remove bootcmd_mfg
Thread-Index: AQHZ9vb3tJ8M1BRUsUirlzxQErR1bLA6I/qA
Date: Wed, 4 Oct 2023 21:23:02 +0000
Message-ID: <df849acd8d1b602c5721cad8241fda08fb155ce6.camel@toradex.com>
References: <20231004191358.24488-1-francesco@dolcini.it>
In-Reply-To: <20231004191358.24488-1-francesco@dolcini.it>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0154:EE_
x-ms-office365-filtering-correlation-id: 93722f33-e035-44b2-7df3-08dbc520178b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: WwG7t9nngBOwgotDTxjPVBzYG9HrT1EpHG7AB4WB37vwY/5JRUdvSEPFZrdKsgCj2YOVNDDi7NOExs4bkZWpzcs5oYE3iFX1sDholEbsNyw8GCCjjPzqEuAX4HmxWxqNv4Q+iPBtsj2jUFcMjKPjO0NZWEq+GnOytUU5guZPCguFuKJC2O+diFuGyKLzOcErIine7VCIUnqzexyD54lv60+SYrFQ/wTkXw1J4EhrD43LnxwUInG2bviBMwFOo36HfC2Uw0yghGEgEZvr4lgPNfMqrK9098Jxe7VaC/c9rTbMC98JRqC6g2ZshlCkAZX8BrT+oIKl06YP//g6dWgc8pTzDzbGzzfdgNsRWDQFpIQFkI9hXq/od1u7dwlL0RWw8gO3EugK9JrEKn/GUoojAZYXfEEd1o+enXUdGjOQbf2Q+M8SDy7Q7FreigFInxHTXhjLToPKDXsu1uQ7W/l2NY8aBRYEWHGKnaa7agNaUZgwweVIuhIchwauW7uRBjYpIUUl3fQQKH7sObAk7Of4ncd31PQvjVPuakgyKzbUDlbyCgDzkseAHnfNZIbsJ6XxLPhB7vndU/0Wd/N42n1isbX3JWKbKhUS7hgrjaCTKqZM2V9LtMHM20WUZ6rcb3QjDWFCpv/VTdI+A/KfSiOKBQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(396003)(346002)(39840400004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(38100700002)(83380400001)(2906002)(86362001)(38070700005)(122000001)(36756003)(316002)(66556008)(6512007)(54906003)(66946007)(66476007)(64756008)(76116006)(6916009)(6506007)(41300700001)(66446008)(6486002)(2616005)(478600001)(71200400001)(8676002)(4326008)(44832011)(5660300002)(8936002)(139555002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHVPRUJ3T3czRGw3eEhnb292dzJmTUthdS9NMXBRYzZmall5UVQycGN0ZHlr?=
 =?utf-8?B?ZFE4QVVYVGtPWElSR1RvNktsTHF5cmk4Q1BTNjh1c3JVWVlOaVdLS2dyNkFH?=
 =?utf-8?B?VzZiTVI4Tk1iTUp1d3VQQXNIcTlRSTR4aU5nMmEydjV5SGoyUGYwaHlZeVRM?=
 =?utf-8?B?YVVrbUU2VXZDMHR6RUN4Z1RLdXVpejMzUGJPQThYTE1yUEYySDVZQVkyWTBU?=
 =?utf-8?B?bERocHF5dXFWSndtSTBCNDRRWHNxd1g1SEpKQTBCSitOMlQ2TDEzeDhOempa?=
 =?utf-8?B?YTloVDVTZU1WOENZV00vU2R5bW1tM2wyMDdhNTF0TDFMNVVjV2RlTzZ3QXIw?=
 =?utf-8?B?aXBhcnpLZWpPb1J2anE1MkZvNlNjeWcxSm9tTVRybk5IcGlaaTRMbjJXRXJZ?=
 =?utf-8?B?UWJHT043QWRjcXpuWGxwQ2lkVFordFN2aTF5bE5KZnloaDA1V3pYaTAzOHU0?=
 =?utf-8?B?ZE1PYWtJdGxQUUd1dW1jN3drUUhZblY1T1EyVXVQWU03Qm5RUEMwQmp6K2xh?=
 =?utf-8?B?M1kwMjBNR0FjZCtLbUhCZ0k0RUhjY2pHbnFPSUhkSzZQL0M0azJQdjM5RDRF?=
 =?utf-8?B?cWZjbnFSU0E3OEJZa2pzVGM2ZVRlUFU1bEpPeWtzeDBYLytPN0M3cnVGOGgz?=
 =?utf-8?B?UHpGOWk3K1NRZFR0QUVSS29IYmlKZjZhMy81TWpSR0pDcjhjVHpTN3pIcXdr?=
 =?utf-8?B?eGs4NVBSam1vNUo5NFE0QWpoZ0NqczgxeDJhZGgzTzlxbWRxdFFJcWZaaFRS?=
 =?utf-8?B?UEEzeHA3NFA3VnBHY1pVeUVnTmorNmlMSzlTWHUyMGVmUlNaMGU1K3VCU0NB?=
 =?utf-8?B?R3BSaG96S0Vtb2pmaWtPYlkxWEdyNjIvM2hTWURZc1p5Sk5ETWJIZWZ1djE4?=
 =?utf-8?B?ekp1THFERVFzaHdyUGE0UmViOEZqRkhPcmMvanF2aE5Nb3V1aHB4RzM2K1Ax?=
 =?utf-8?B?VE1YWEtSQ1prTG9mZzRaYnJwMnp6MWh2RSt6VUo3R3M5ZStjNHpFTnB2Wk5S?=
 =?utf-8?B?Y0gzdEN4cFkzTFJQdHVzSFVtQ1Q5V1NVU003NCs2R2cyVjE1UXE5dHpEdVFS?=
 =?utf-8?B?TGlaUFpScmViNkRqWis0YkR0bnBxdG9nUzljMUg5N0VSQld5S0lOVHZRaXJW?=
 =?utf-8?B?bEpBcTRUUnkyNE9CQm1pR3dZNDBRRTlxV2JHYVhTSFU0bzVSbmJ1bmlkM3hl?=
 =?utf-8?B?WEpwNENKNmFnM0ZSZTk3ODBvdmhVQ1ZCdEpnREFpS0FTaEs4T0JYbW9uZ0xH?=
 =?utf-8?B?YXdML1VjRnBSMzZFWlZBTjJMU1ZKbldrc3RKTnNGelhkRmFOODVwTTEvQksz?=
 =?utf-8?B?UnBGQmMzelh1UDBwWTVDS09pdGQ5d1JoQ0I3MkFUQXdkNVZzSitnVm9ROEdn?=
 =?utf-8?B?SVV1dzdsTUc3bysxQ0tQam9FSWtycldUcWxDd2VvZ1RWZ0N6NElTS0tUZHRY?=
 =?utf-8?B?Y28zOURiMzkySkwzOFdMZUh1ZEdEK1pPTTgrY1BFbm1YVW8zRXBKeFA5RUww?=
 =?utf-8?B?RzZEWjBYdDZrbVVzOFFZVlpLTWpIaDUvUHl2L2t2cG5pSVZhcFovbmlqZmZq?=
 =?utf-8?B?ZzVlL3ljQXhhM3ZrMG9YYW44cFVjcE4wTldrSDdzdlZXNkMvcDZlRzByUFpu?=
 =?utf-8?B?bzQvSE9kMHVuTStpUmU4MENKWGxlQXlJYWIyL3VEZlgyUWdQUEpCV21GQ1Ba?=
 =?utf-8?B?V0J2Y1h0TVJRRklEQ1p5cG1yK2FaUmFKcTd3QkhoUDJwYjFFa1ArNmpnUHN0?=
 =?utf-8?B?U2hBTkNOdzBteTBNMHRuck5ycGkzZURwYi9DQmxsc1J1em5yeHVMNzZlb295?=
 =?utf-8?B?OE1KMUdoTkg0NUZzeEdVcXcvcUxJMVhka1VnbmJuT2w5Q3UrUVpaWTBMOTJG?=
 =?utf-8?B?eXozUlRvNTBLdW5jajg4Z0hjOHZZOFFHL2ZCYzg1cGxPK0gvanBMaUFWT1h6?=
 =?utf-8?B?a0xWOVFQb3pwRTJ1aUExdkFRRGdDTjYyQ2lYZ2M4a3l3WGlIS1loMDlmcVY5?=
 =?utf-8?B?L1p5T2M3QUxPL1pEZzMwelhWbm45NmlTVFJKcUFVOWZQVDZnMlhEMGFOYm4x?=
 =?utf-8?B?djZ3dDQyUXFaUFlJdStCMXZHZXRaT2RDT3M4N2pNanhjWXU4N2JJeTFHdXda?=
 =?utf-8?B?WHoyc0doTXgxUVNtYW0waHcwL1o4MnNKQnNJaUZETmluOTZmUE5JMGxGMWhI?=
 =?utf-8?Q?xxMp5a2emK6u/Mml68aKY3A=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93722f33-e035-44b2-7df3-08dbc520178b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2023 21:23:02.7316 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkKdRL9dBu8UvTxbNbxELN3RTsJjKfXOgaYFaTzpA26EKQjrpSRjrFzGOwHB/lMAQGJEpgommO2fBtNM8cQf43fu3LCxoqr/V0hZWN9RKWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0154
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <53B1B3AB29C51246A601875D7E7DE3AF@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

T24gV2VkLCAyMDIzLTEwLTA0IGF0IDE2OjEzIC0wMzAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gRnJvbTogSm9hbyBQYXVsbyBHb25jYWx2ZXMgPGpvYW8uZ29uY2FsdmVzQHRvcmFkZXgu
Y29tPg0KPiANCj4gVGhlIGJvb3RjbWRfbWZnIGVudiB2YXJpYWJsZSBpcyBsZWdhY3kgZnJvbSBJ
TVggZG93bnN0cmVhbSB1LWJvb3QgYnJhbmNoDQo+IGFuZCBpcyBub3QgbmVlZGVkIG9uIG1haW5s
aW5lLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSm9hbyBQYXVsbyBHb25jYWx2ZXMgPGpvYW8uZ29u
Y2FsdmVzQHRvcmFkZXguY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBGcmFuY2VzY28gRG9sY2luaSA8
ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlzd2ls
ZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gwqBpbmNsdWRlL2Nv
bmZpZ3MvdmVyZGluLWlteDhtbS5oIHwgMSAtDQo+IMKgaW5jbHVkZS9jb25maWdzL3ZlcmRpbi1p
bXg4bXAuaCB8IDEgLQ0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NvbmZpZ3MvdmVyZGluLWlteDhtbS5oIGIvaW5jbHVkZS9j
b25maWdzL3ZlcmRpbi1pbXg4bW0uaA0KPiBpbmRleCA4Y2IxZjFhZmYzNTMuLjgwNzJkNWQ1MDNm
MiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9jb25maWdzL3ZlcmRpbi1pbXg4bW0uaA0KPiArKysg
Yi9pbmNsdWRlL2NvbmZpZ3MvdmVyZGluLWlteDhtbS5oDQo+IEBAIC0zNyw3ICszNyw2IEBADQo+
IMKgI2RlZmluZSBDRkdfRVhUUkFfRU5WX1NFVFRJTkdTIFwNCj4gwqAJQk9PVEVOViBcDQo+IMKg
CU1FTV9MQVlPVVRfRU5WX1NFVFRJTkdTIFwNCj4gLQkiYm9vdGNtZF9tZmc9ZmFzdGJvb3QgMFww
IiBcDQo+IMKgCSJib290X2ZpbGU9SW1hZ2VcMCIgXA0KPiDCoAkiYm9vdF9zY3JpcHRfZGhjcD1i
b290LnNjclwwIiBcDQo+IMKgCSJjb25zb2xlPXR0eW14YzBcMCIgXA0KPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9jb25maWdzL3ZlcmRpbi1pbXg4bXAuaCBiL2luY2x1ZGUvY29uZmlncy92ZXJkaW4t
aW14OG1wLmgNCj4gaW5kZXggOTQyMDgxYWI4NGQ3Li41YTM0ZjZhOWIyMDUgMTAwNjQ0DQo+IC0t
LSBhL2luY2x1ZGUvY29uZmlncy92ZXJkaW4taW14OG1wLmgNCj4gKysrIGIvaW5jbHVkZS9jb25m
aWdzL3ZlcmRpbi1pbXg4bXAuaA0KPiBAQCAtNDYsNyArNDYsNiBAQA0KPiDCoCNkZWZpbmUgQ0ZH
X0VYVFJBX0VOVl9TRVRUSU5HUyBcDQo+IMKgCUJPT1RFTlYgXA0KPiDCoAlNRU1fTEFZT1VUX0VO
Vl9TRVRUSU5HUyBcDQo+IC0JImJvb3RjbWRfbWZnPWZhc3Rib290IDBcMCIgXA0KPiDCoAkiYm9v
dF9maWxlPUltYWdlXDAiIFwNCj4gwqAJImJvb3Rfc2NyaXB0cz0iIEJPT1RfU0NSSVBUICJcMCIg
XA0KPiDCoAkiYm9vdF9zY3JpcHRfZGhjcD0iIEJPT1RfU0NSSVBUICJcMCIgXA0K

