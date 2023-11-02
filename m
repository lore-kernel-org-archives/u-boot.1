Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EA7C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 07:10:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E9F987622;
	Thu,  2 Nov 2023 08:10:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="m6PPJIgB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 728028761A; Thu,  2 Nov 2023 08:10:14 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF9BA803AE
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 08:10:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698909004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KTjf+wAkiixmQdyZDC4VTiCaLlz/XAfcRSxNUOdpgSc=;
 b=m6PPJIgBwsmCVJur6UPwt/B5udzwppNEKFjKXGxlaB2LQqnv4P0Mrlfo/ngWBA5zqUAyOH
 qq2rDJXJRMq/BbJGDKq6gqfRxJ+G6xVU/23ByHxECJBDT7TMrzHrLHxbrke96PwYFo2fLA
 QCrBRFkOwyZN5AVvwb/82CGP9k6nU1M=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2105.outbound.protection.outlook.com [104.47.22.105]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-2TECYM6fMWOUvku4eYEDUw-1; Thu, 02 Nov 2023 08:10:02 +0100
X-MC-Unique: 2TECYM6fMWOUvku4eYEDUw-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZRAP278MB0160.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Thu, 2 Nov 2023 07:10:00 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6954.021; Thu, 2 Nov 2023
 07:10:00 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "sbabic@denx.de"
 <sbabic@denx.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Topic: [PATCH v1 2/2] imx: spl_imx_romapi: fix emmc fast boot mode case
Thread-Index: AQHaB96XRXORtSp5rEyqWMgsCwfvILBbvWuAgAAByACACug8AA==
Date: Thu, 2 Nov 2023 07:10:00 +0000
Message-ID: <899b50aa96b802275035f9ee40f46b461f8bfb46.camel@toradex.com>
References: <20231026073220.244387-1-marcel@ziswiler.com>
 <20231026073220.244387-3-marcel@ziswiler.com>
 <f9ce2b20-1fa1-408c-9ae6-4dd382c9c999@prevas.dk>
 <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
In-Reply-To: <6ab14ae1-7044-4663-98e4-919b9d1757b9@denx.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZRAP278MB0160:EE_
x-ms-office365-filtering-correlation-id: 2353e414-903e-4be9-c801-08dbdb72ba98
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: R0pyHo3cXMJk1h6k3QdGPEIeBIljAEf7hxfg4zNUWp+TJkdWMIBnW8Ymkvd/t018dABFJcPfqF2CKaBMYCyAPmYOz9p4vtnoIBbtA85KJQO9uV7JEbkYNhLD+g6Y4QpA40F8M+0eZ2p7jZdXjOJyIem3NuQiWDYVvJJx8SuZdFMHJhvfCZXlyrRtI8ki9mNL0tWZBLRQPwtYBO5Jwnee9YWTPqrArJQIyDoF19aliMvqoMrd1X/+9Xp+aaMOQq6L9P3dBRHJX9JswgpaG1m089PV+1y38ik/jKJlwQm+ns+fVrVlaYUobxVSNQ08i2FnwsrjhifCWthu2jXN2I0IFyRxJIMqeieS0DXSODstxzjoO2kpyrzbZsuH2hBUK51+z3wnqXxWQmGO82nw1avCkJ3ZU5ttbxYe7sFaBXGK0YoYVy/Jl/PyPNAIqaPGAiOJCp+5rsMmRYKU++PedUWViq89CdIM+4M/kBJRHT07jhDtjPMD3yKA4hWGgd2Ymx9Oc7/OkxDAUJtIByXlRWe2DscpXsp0A96+Xdq7GcgLJD4sHrlEoWTgnj67pjCR6R+noN1O28YDaYR3EBvcEpY0swmku7iFQ7kSB9c/AFl2AksniydTH5Ma+yeoi6Dn1CpR
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39840400004)(396003)(366004)(346002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(122000001)(6512007)(2616005)(38070700009)(478600001)(6486002)(5660300002)(44832011)(36756003)(26005)(8676002)(8936002)(4326008)(4001150100001)(41300700001)(2906002)(86362001)(66446008)(66946007)(66476007)(66556008)(54906003)(64756008)(76116006)(316002)(110136005)(71200400001)(53546011)(6506007)(83380400001)(38100700002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDcreVJPZEJYN0hoSWlkaERhN3ZXOTRxMHpTWVZ5MkhIU2o5VytxV2pUY2g1?=
 =?utf-8?B?Rlk4ZDNTMjJvc1Axb2F2bnljQXMwNnNBelNGTkV3bXpHalF2bTgrOURwNVBW?=
 =?utf-8?B?SWkySlFSNE9tZFQ5NVZ3S1FRM3VqS1F6bTg4VXZ5VlpBSUFZVTJ3ZlVsRmpo?=
 =?utf-8?B?RjQ0TWpCZ1BWVHlSYmlEVkh4SUtrQTIyYXBlRG1BWUZZNjl6QXB1dFVtc2pn?=
 =?utf-8?B?ckZPNU9oeWJUcFREOWNQcGxycEdkbUhSY0RwbEVEeXQ5c0ZxbDUza05zZ2Vk?=
 =?utf-8?B?b0wycENET0R5MTVGOUJDdmFZMStJOThJL0lsY25ldTRsdStTY2lqaDdGdW5H?=
 =?utf-8?B?UWU3MmdXMUg3WU01STN5VlF5RmNTL3RFYldjM3JjN0orL0swWlhhOTVYNTEz?=
 =?utf-8?B?QlpxbHREN2thRVM5eThBdEdkc3Z3MXFBWFJkY2dXQ1o1YVJRc1FhQTBHUEND?=
 =?utf-8?B?eDJnVHVGeUZkWlVzMGxLYjRXOWJHUUlWZERHWWZSdmVma0doRGN6M0ZxRzQr?=
 =?utf-8?B?WHQ1dmFIL2FUNmdSYnIrWGhzdUtoTml4MVBNZi8yVWNsajJYWnJRcFV6U0Nm?=
 =?utf-8?B?WGNhU0ZOVitkNHdqQjJwNU5sWEt5elVpUXJJWWZVOXFXWTNNcTNsdmhvdjBr?=
 =?utf-8?B?eWR6TmV0Q1lXVFIrOWFDcFlGTTlvVHN0ZkVZQS9hdTVKMFk3aGIxSlpESzJl?=
 =?utf-8?B?YkJTVEVBaFhKa2JhNFp3VFovMjkwdFlva2lLN0pmMm95RkhBZHdSMnFRVkRs?=
 =?utf-8?B?M0NBSTYvbXVJY0NJak5heDE2SHJqVEgvVzlBcHJ1UktNN3NrWjF5MU53WHdm?=
 =?utf-8?B?WGNGbTM1SUtlclY5SEE4MHRWY2tqWkd2ZHZGRkdlUnF0ME5oQTRINHVMOFJm?=
 =?utf-8?B?SDUyMm5kbWRiUk83ejdmU3A3THRJS2V0a05mMFhzYmozM0pINTdvUHhQdkor?=
 =?utf-8?B?S1M2a1U3MThIbDVDOWFmOHl1T3BWMGpEY2ZCRDJjZWhVeGZiLzFQQmNEcGp3?=
 =?utf-8?B?YlFwWjFnWDdYWEZRemlwNFd5ZWg0Wk5WV3cvNVBVaW1Jcm9ZeDhIcVJETW9s?=
 =?utf-8?B?MStkZU51eXJCS0ZHWlREQks5VFlFQ2ROLzJpWWcvd0ZXQ1lKRjNXeGZBRHBV?=
 =?utf-8?B?SFFxUTF4Mm96Tmhuem9scktPSTlwVmd6WDkrdHQzRC92Q1pWbVgyZ1JWbTlU?=
 =?utf-8?B?UlZ0Y2Jkd0lyZHVXaG1CRWJTK2ZuQlgweVk0bW5EcnRHVS92cjVpUmhzWndX?=
 =?utf-8?B?TmJrUjBOMFRaTWsxRVFuWWNsejVlQitjRmprdGI2d1p2a1dKellhbTBURkds?=
 =?utf-8?B?MXpBMUM4RjFmWFFVWUszT3JBRU8zRWFoZWRFY3o5NS9peGFZTmx6bGd0bWs4?=
 =?utf-8?B?V1ZVZmVCb1ZyemZjUEhkSDRyMFpNOEE4MHBVK0ljYzZPTjdQSWZHSWlPR2t6?=
 =?utf-8?B?VkRnaUJxYW4wYlhCV3htK1NjWWw5bFBWNWwrRVNNRSszNnpiSGhOYUEzbC9S?=
 =?utf-8?B?THBFVk50b0llQ3lkMDdMWmZKRGNsWVBUWHlDa1Q1NkhQV1lFTmE4elNRUnFG?=
 =?utf-8?B?ZzcwQnhHa0t2Tkx6ZHNObnhHVmNrYW16RjFJYzlyVVlUVGcvNTFiVXpXQ05o?=
 =?utf-8?B?LzZLZmVIdFEvc2JISWlCYjF2VGw1N0p4cDBZZjBKVjBBWm8xOHRIRW5NcVVp?=
 =?utf-8?B?M1dSTWp3dk1jUzdReDE4RE1uL1FYaU92NFhZaDJRdnZla2VhZWVjZ2hvNm5C?=
 =?utf-8?B?RWt0M3N5OHBNb2dSMjhTMUVHY01uNkJqQWtNcW9tRzlJdnFhdVlTeVJsYzc1?=
 =?utf-8?B?dkJTYTZCNzd0VzVmMUc5VkF3N0FrUmdzallRVENwN0llWTNLeFNlQnQrRUlw?=
 =?utf-8?B?RjVEZ05OQWl4YXBROTVpY2hCbURoekIzUUhXSmt5MjArMnF5SnNPYitzWTl2?=
 =?utf-8?B?WjJEWHdMdXhUWTB5RllIRE1MdVNNL0lmRXZjUUVweXVDaGhKS1R5dkNPK3A1?=
 =?utf-8?B?cWFlT1pzck5keFlxeGxTTTBrTjBCcWpKdllWcUs3cjBuNHJrYUNlK0psL0wy?=
 =?utf-8?B?OEhzWEdoMFpNekczbzFEMHRxTzdmRXVJY1BFL1dWczI4M05kRzE3amJPbW9h?=
 =?utf-8?B?MmJGaXptNHpiZUlxWStOblNkN25LTW94NmJVaG1JZEticnlNU0QvTS93b0hN?=
 =?utf-8?B?ZWc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2353e414-903e-4be9-c801-08dbdb72ba98
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2023 07:10:00.6317 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lnbLN9iZLzH/XtEXF3N54rozV65ZfVF3MbYypYyBRSGfzjQAcTnvJ/ht54+KeFoeunDa+mKkyXHYTVILD2Vfh1COs+6ShNOQ479+sNi6gKE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZRAP278MB0160
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <B7048689051F4F49B1C2BFC24ED44367@CHEP278.PROD.OUTLOOK.COM>
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

SGkgU3RlZmFubw0KDQpPbiBUaHUsIDIwMjMtMTAtMjYgYXQgMTA6MzYgKzAyMDAsIFN0ZWZhbm8g
QmFiaWMgd3JvdGU6DQo+IE9uIDI2LjEwLjIzIDEwOjI5LCBSYXNtdXMgVmlsbGVtb2VzIHdyb3Rl
Og0KPiA+IE9uIDI2LzEwLzIwMjMgMDkuMzIsIE1hcmNlbCBaaXN3aWxlciB3cm90ZToNCj4gPiA+
IEZyb206IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+
ID4gDQo+ID4gPiBUaGlzIGZpeGVzIGEgcmVncmVzc2lvbiBpbiB0aGUgZU1NQyBmYXN0IGJvb3Qg
bW9kZSBjYXNlIHdoZXJlIHRoZSBidWZmZXINCj4gPiA+IHdhcyBtaXNzaW5nIDQ2NCBieXRlcy4N
Cj4gPiA+IA0KPiA+ID4gVGhlIGNvZGUgZmlndXJlcyBvdXQgaG93IG1hbnkgYnl0ZXMgbXVzdCBh
dCBsZWFzdCBiZSBmZXRjaGVkIHRvIGhvbm9yDQo+ID4gPiB0aGUgY3VycmVudCByZWFkLCByb3Vu
ZHMgdGhhdCB1cCB0byB0aGUgc3MtPnBhZ2VzaXplIFt3aGljaCBpcyBhIG5vLW9wDQo+ID4gPiBp
biB0aGUgVVNCIGRvd25sb2FkIGNhc2UgYmVjYXVzZSB0aGF0IGhhcyAtPnBhZ2VzaXplPT0xXSwg
ZmV0Y2hlcyB0aGF0DQo+ID4gPiBtYW55IGJ5dGVzLCBidXQgdGhlbiByZWNvcmRlZCB0aGUgb3Jp
Z2luYWwgdXBwZXIgYm91bmQgYXMgdGhlIG5ldyBlbmQgb2YNCj4gPiA+IHRoZSB2YWxpZCBkYXRh
LiBIb3dldmVyLCB0aGlzIGRpZCBub3QgdGFrZSBpbnRvIGFjY291bnQgdGhlIHJvdW5kaW5nIHVw
DQo+ID4gPiB0byB0aGUgc3MtPnBhZ2VzaXplLiBGaXggdGhpcyBieSByZWNvcmRpbmcgdGhlIGFj
dHVhbCBieXRlcyBkb3dubG9hZGVkLg0KPiA+ID4gDQo+ID4gPiBGaXhlczogNGI0NDcyNDM4ZjVh
ICgiaW14OiBzcGxfaW14X3JvbWFwaTogYXZvaWQgdHJpY2t5IHVzZSBvZiBzcGxfbG9hZF9zaW1w
bGVfZml0KCkgdG8gZ2V0IGZ1bGwgRklUDQo+ID4gPiBzaXplIikNCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+ID4g
DQo+ID4gDQo+ID4gVGhhbmtzIGZvciByZXBvcnRpbmcgYW5kIGZpeGluZyB0aGlzLCBhbmQgc29y
cnkgZm9yIHRoZSB0cm91YmxlLg0KPiA+IA0KPiA+IEFja2VkLWJ5OiBSYXNtdXMgVmlsbGVtb2Vz
IDxyYXNtdXMudmlsbGVtb2VzQHByZXZhcy5kaz4NCj4gPiANCj4gDQo+IEFuZCB0aGFua3MgZm9y
IGFsbCB5b3VyIHdvcmsgLSBJIHdpbGwgYXBwbHkgdGhpcyBmaXggc29vbi4NCg0KQW55IG5ld3Mg
b24gYXBwbHlpbmcgdGhpcyBmaXg/IE5vdGUgdGhhdCBtYXN0ZXIgc3RpbGwgc3RheXMgYnJva2Vu
IGFzIG9mIHRvZGF5Lg0KDQo+IFJlZ2FyZHMsDQo+IFN0ZWZhbm8NCg0KQ2hlZXJzDQoNCk1hcmNl
bA0K

