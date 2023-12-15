Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DF2C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 08:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D056A87A84;
	Fri, 15 Dec 2023 09:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="X0/fu6ww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1179087A21; Fri, 15 Dec 2023 09:49:36 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26C8E87AE6
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1702630173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xUHaixgSrJYiCUUs6AUjuSJ6aeU1GvSCl500gK1FX9Q=;
 b=X0/fu6wwCMOAc5T7R0duzjHA+e6wpJ5wJKpGRsQ4/3/pfKLbqU0VQoq44OjfDW11sQ1qIr
 Al8aBfVA121vzkkYjZpHV4qPoSUifhfRFj7a+g2AJnGwOKnKlbDOOdtdHeBj/ItOEaVtmM
 k1i9fUrZ99RrU7ALwez3L4whHciqfUY=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2104.outbound.protection.outlook.com [104.47.22.104]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-35-7jZR7DTuPZ23dna6VxKVwg-1; Fri, 15 Dec 2023 09:49:30 +0100
X-MC-Unique: 7jZR7DTuPZ23dna6VxKVwg-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB0943.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4f::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7091.31; Fri, 15 Dec 2023 08:49:28 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::cdd5:e0c0:e3f7:dd1%5]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 08:49:28 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "bb@ti.com" <bb@ti.com>
CC: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "sinthu.raja@mistralsolutions.com" <sinthu.raja@mistralsolutions.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "n-francis@ti.com" <n-francis@ti.com>,
 "kamlesh@ti.com" <kamlesh@ti.com>, "afd@ti.com" <afd@ti.com>,
 "a-nandan@ti.com" <a-nandan@ti.com>, "seanga2@gmail.com" <seanga2@gmail.com>, 
 "lukma@denx.de" <lukma@denx.de>, "j-choudhary@ti.com" <j-choudhary@ti.com>,
 "a-bhatia1@ti.com" <a-bhatia1@ti.com>, "m-chawdhry@ti.com"
 <m-chawdhry@ti.com>, "hnagalla@ti.com" <hnagalla@ti.com>,
 "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "nm@ti.com" <nm@ti.com>, "ralph.siemsen@linaro.org"
 <ralph.siemsen@linaro.org>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "sabiya.d@ti.com" <sabiya.d@ti.com>, "rogerq@kernel.org" <rogerq@kernel.org>, 
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>
Subject: Re: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Topic: [PATCH v6 00/17] Introduce initial TI's J784S4 and AM69 support
Thread-Index: AQHaKEErqILJ/BT++EqH7SwUhV8EjbCpGYyAgAApEICAANQZgA==
Date: Fri, 15 Dec 2023 08:49:28 +0000
Message-ID: <946574dc39d1cfb5bd08950a61eae06f3fbdc06c.camel@toradex.com>
References: <20231206123753.1486031-1-a-nandan@ti.com>
 <51eeab25314144926eaefaa2e83353ffec9309fe.camel@toradex.com>
 <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
In-Reply-To: <20231214201019.5bjxb5ki67yjn4ku@bryanbrattlof.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB0943:EE_
x-ms-office365-filtering-correlation-id: eecb7444-4fba-4719-eef6-08dbfd4abf5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: Pxsx+wNQu8wpr8QZwGz0iP/YQNkXxITN2nsWGfVxougcxDNqT1INSPbZJv7oQ10qfiCCkQuPW+1NxUrcEN0ya/c+0P53TOAZMqY0WB6aABvLmW/rervDhr+3501OciRf3dg4EqnWnZxN+9tqFuXihxhbGXZfN6Ftfx1We/MEAxUtNoGFso9BXHIXlyfRNZa93Hi8lYi5qr9jucLJApsB3KiPQaBF2IF4PJWETxSspx0WUlsLLfXlw4d0eR5L7nxKe7w3vM44CaSHyQERHZn0toMEGgJTZQsbMhCfohUqzRWraDY8NljKAa3U4ClMIXtJE1HDfnhkfXzgU6V9dnzNK0Evs0i2b0nD20N7Bjce2C7wJD5Wlne7boCCh+Vmh7ylsK1uA5dGoU28glwKRfYnTTX3u2pbjcMUHe9GsyzkL9Lkv5u2aoSO9VILAmRZg3El3zmLrsmKDVAyvpMnFEz262B6MuZIGL0YhhqPpOH4ZCyBDkpJ6V78siTxtJMaSsFlZ1ZuAQt0B0j6geYmiKRJ2H2tiELH1uuymKd6L+Zs0GRSwc2wQGn+od4MoO5dIF7IB2ZJ4sOaeol6WIOvYMa0tICVhBvwRiqnk1HIxgiqdUOFiNTKnE8R/cjB5/fY3OCw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(346002)(366004)(376002)(396003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(86362001)(8936002)(8676002)(4326008)(316002)(44832011)(6486002)(478600001)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(6916009)(41300700001)(38070700009)(7416002)(2906002)(4001150100001)(5660300002)(36756003)(122000001)(38100700002)(6512007)(2616005)(71200400001)(6506007)(83380400001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TkpBKy9qS2xHODdtZUNKS0JBSlJpaFhBODBDUGl1U3NkQ1R1RmpTcTVpRnB5?=
 =?utf-8?B?TFN2VGhXUmd0aXFQSW8xcGhSekxNZGx1V0pvaEhYV2JCOEdiaC9Wdm1mVWZI?=
 =?utf-8?B?YkF0Z1AwcGpNY2dBZ1g5NURtNUZxVzhmMXlVNmRHcDI2U0ZwMEE4YXc2NTBO?=
 =?utf-8?B?R1VFY2xNR08yMlQwQ0RPeVltRk1zbXZJQjN4SHJ6aytBZHRyNTdMeUhObUVv?=
 =?utf-8?B?V3QwOXlPdU5pV1l5dmlYOTlhOHlQNGlOZ1Vob2JHN1dHRDRaTlFPSE14WEV0?=
 =?utf-8?B?dlhCbXJMOWhHbGFVaThtVlNyaHQ1T1NvYXIvcWRUVlpta3BNbkE1cEVMN2Q4?=
 =?utf-8?B?TjV6eVZ6WmpkZStiY2Nkc0M0YjlzNFcrMHc0dmUyVFJDbVVQcHhDNk9odDRr?=
 =?utf-8?B?MXBiUjFUdkwxRjhsQS9lWFNXakZpUzdaR2JLeERNZi8zSTB6ODA5cmZRc3RV?=
 =?utf-8?B?M0hXUFRQU3FaMFk3MHRVTDFlRCsybnQ5WEhBUUMybFh0aDBvdmthOW4wYVdz?=
 =?utf-8?B?bGZhWC9FOWRPNUdTTlAydGNxNzVNdmxrcmVaZHBVRVBVUzlwTTBNYUVGMmJo?=
 =?utf-8?B?UlVSTTBaN2QyTm5BUDBoU0hsdjRFaW1oZGNzS2JxWkVVb01ORHdiWi9IanI5?=
 =?utf-8?B?NWJ6VmJqTWFHNnFxN3NTV0VGMENNVVlwVzBCTkhjOGhFbFF2eWFvQmhQNVZ5?=
 =?utf-8?B?bWNxakd6TXhCcG4zeEx4Tm5qZmRVcVhrVVlnNWhLUFpRaWNwOHl5OFpDbS81?=
 =?utf-8?B?WjVCdVNIZmVlaUlKN0E1QVk4dGk2aXJjRXVaQ2g2ZkM1Y1NEazBRZ3RZbmNO?=
 =?utf-8?B?Y1JhTFB3RmJVN0lLSVpaZCthNy9wZjlWNzI5alZMUC9UUEVkTFo3VUVIZHJ6?=
 =?utf-8?B?akQwRGpWd0tCZGg1RUtqaG9ZS0NzdjArWlRNZ2laMFhDSEx1MDJkVlpsN1VT?=
 =?utf-8?B?VTJJMW04cFVJOUppaUd0dmpsRFFFblI1bTVTNnpEdXdvVmdSU0l3b1dSSjV4?=
 =?utf-8?B?MVJRNzhMbW1KbkZhekt1dWk5OXk5WkhUY0d0MWtaWk10TzdDTVpRVURieDl2?=
 =?utf-8?B?V2ZYREc2RzdudEJPVnYxRGhCTHVWZlQrT0RZVkUvRFNNNnNYbjJVbUs2NlVz?=
 =?utf-8?B?WURBMWlFWE1uMURRUHdJQzdLVVhxaTJ2UmdOaW5laG9sYTQ5a1hxSXl6MFEy?=
 =?utf-8?B?c0lpaVB2SFIyYkExQmx3eEp6aXo2QkQ3OWg5RlZFQW13bC9nN0ZXWUxMY3I2?=
 =?utf-8?B?MHlaTUd1VTNOWEhEc3FCTWNCWXJsb3F2UCtQaHY5UEtsS0lic2JUYXliL1RF?=
 =?utf-8?B?N3FKaDdXT09xTzlKcHpiMGdFZUxUaDZVOFJSN3lRdXpRa2FyUXg1aG9wanRD?=
 =?utf-8?B?anFNUEtqVXYraStjckFncERrdnNlQnl3WDMxRnE0VjY0blNKMnpZSnY3MllY?=
 =?utf-8?B?ZDNuaFhPWUdjOWtlLytBekNvY1F6Y2ptMVozdDN5bUxsVUo4R0JqRTIwdHp4?=
 =?utf-8?B?bEszbjVuSE90QWw4YjhBY1IzL3NTaDlLaXZUODAvMmJ3dndnOWdtcG1pVElC?=
 =?utf-8?B?azdsbzZTMC9RM0kvZ2hCUHhQR29yejBUbjFHcWtGR1prYmR1VlBYbGwxSGUx?=
 =?utf-8?B?c3I2V015dG84bkNXUDV4cjNNRThLWi9rV0JSZHp2RVRXTlZUeE5NQm9mSWNi?=
 =?utf-8?B?R1V2ZW9wcHFUTW9kejZwODNnS2VHd0VhdnlDNkZjbnYrNWt1K1poKysxUDVM?=
 =?utf-8?B?dFRmQk5EQ1Y3UW5DZTJvc1JuUUo0cFBIUnRxWUI5OW10dUMwandNN1ppUWVq?=
 =?utf-8?B?eFpCZ25aNW8rYXFsbzVkdzNXSUdrYVpmNVM5WDAxUEtCM0JoRk5YbmdWOU9J?=
 =?utf-8?B?RHU0ZTcrS2x5R09Ba0tvbUVZQ1NiSmkwQ0lWNDY3UXg0bWc0ci9BNUFNMDRN?=
 =?utf-8?B?MkVGMUtDWU5STlBYRFB4L0wwb3FwSzJoTjFpWVF5emNBQitxaTNPUmFjeW5R?=
 =?utf-8?B?cFptYmF1SVhBQ1lLUkxrcXAvbEVqc1BKaG5VRUJZOE9jRTdLeGhpZVR3YURy?=
 =?utf-8?B?L2IwemVjbUlkM2g4c20wOXVtYUpHN2pjVGxRNFh3VHlia0ZJL3lMcTZFckpR?=
 =?utf-8?B?MVE1L1JDMkllYXZyV3JpenJqaVpQSWo3RytYcjFScEF3MEdUSUdHNmhDcmNk?=
 =?utf-8?B?a20rbFZPc1R0OVpETVg0TWJLZEZaUXlBOUo3UkZSbjliY2UzeWxydjV3d3hh?=
 =?utf-8?B?eTlxa3Z5Z2dab3E2ZHQ4Y2hWMjBRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: eecb7444-4fba-4719-eef6-08dbfd4abf5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 08:49:28.2395 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brA9sCG5LO0Wp3NK4kZGrQbnF9iKmsNaSZT5yvss/9dX27aP0zQ6QlNyKY9BUz0hOOJ5CDUQycouydtCKlx4tbeedrWLosPzbFnPa0hBBt0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0943
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <37B3D8C03FB7F146BD77906245CBEB65@CHEP278.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIzLTEyLTE0IGF0IDE0OjEwIC0wNjAwLCBiYkB0aS5jb20gd3JvdGU6DQo+IE9u
IERlY2VtYmVyIDE0LCAyMDIzIHRodXMgc2F5ZXRoIE1hcmNlbCBaaXN3aWxlcjoNCj4gPiBIaSBB
cHVydmENCj4gPiANCj4gPiBUaGFua3MhDQo+ID4gDQo+ID4gT24gV2VkLCAyMDIzLTEyLTA2IGF0
IDE4OjA3ICswNTMwLCBBcHVydmEgTmFuZGFuIHdyb3RlOg0KPiA+ID4gSGVsbG8gRXZlcnlvbmUh
DQo+ID4gPiANCj4gPiA+IFRoaXMgc2VyaWVzIHdpbGwgaW50cm9kdWNlIGJhc2ljIHN1cHBvcnQg
KFNEIGFuZCBVQVJUKSBzdXBwb3J0IGZvciBUZXhhcw0KPiA+ID4gSW5zdHJ1bWVudHMgSjc4NFM0
IEVWTS4NCj4gPiANCj4gPiBGb3IgdGhlIHdob2xlIHNlcmllczoNCj4gPiANCj4gPiBUZXN0ZWQt
Ynk6IE1hcmNlbCBaaXN3aWxlciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KPiA+IA0K
PiA+IEhvd2V2ZXIsIG9uZSB0aGluZyBJIG5vdGljZWQgaXMgdGhhdCB3aXRoIHVwc3RyZWFtIFRG
LUEgSSBkbyBnZXQgdGhlIGZvbGxvd2luZyBlcnJvcnM6DQo+ID4gDQo+ID4gTk9USUNFOsKgIEJM
MzE6IHYyLjEwLjDCoCAocmVsZWFzZSk6djIuMTAuMC03Ni1nMDIwOTE1NDFkDQo+ID4gTk9USUNF
OsKgIEJMMzE6IEJ1aWx0IDogMTg6MTM6MDgsIERlYyAxNCAyMDIzDQo+ID4gRVJST1I6wqDCoCBG
YWlsZWQgdG8gZ2V0IHJlc3BvbnNlICgtMTkpDQo+ID4gRVJST1I6wqDCoCBUcmFuc2ZlciBzZW5k
IGZhaWxlZCAoLTE5KQ0KPiA+IEVSUk9SOsKgwqAgVW5hYmxlIHRvIHF1ZXJ5IGZpcm13YXJlIGNh
cGFiaWxpdGllcyAoLTE5KQ0KPiA+IA0KPiA+IFdoaWxlIHdpdGggbGF0ZXN0IFRGLUEgZnJvbSBk
b3duc3RyZWFtIFRJIEJTUCAoYm90aCA5LjAgYW5kIDkuMSB1c2UgdGhlIHNhbWUgdmVyc2luKSBJ
IGRvIG5vdCBnZXQgYW55DQo+ID4gZXJyb3JzOg0KPiA+IA0KPiA+IE5PVElDRTrCoCBCTDMxOiB2
Mi45KHJlbGVhc2UpOnYyLjkuMC02MTQtZ2Q3YTcxMzVkMw0KPiA+IE5PVElDRTrCoCBCTDMxOiBC
dWlsdCA6IDE4OjQwOjM4LCBEZWMgMTQgMjAyMw0KPiA+IA0KPiANCj4gV2hhdCB2ZXJzaW9uIG9m
IFRJRlMgYXJlIHlvdSBydW5uaW5nPyBOb3QgZ2V0dGluZyBhIHJlc3BvbnNlIHVzdWFsbHkgDQo+
IG1lYW5zIGZpcm13YXJlIGlzIGRlYWQgb3Igd2UncmUgbm90IHVzaW5nIHRoZSByaWdodCB0aHJl
YWQgdG8gdGFsay4NCg0KWWVhaCwgc29ycnkuIEkgd2FzIGFsd2F5cyBydW5uaW5nIHRoZSBsYXRl
c3QgZnJvbSB0aGUgdGktbGludXgtZmlybXdhcmUgYnJhbmNoOg0KDQpTWVNGVyBBQkk6IDMuMSAo
ZmlybXdhcmUgcmV2IDB4MDAwOSAnOS4xLjItLXYwOS4wMS4wMiAoS29vbCBLb2FsYSknKQ0KDQpT
bywgaXQgaXMgcmVhbGx5IFRGLUEgd2hpY2ggc2VlbXMgdG8gY2F1c2UgdGhlIGlzc3VlLg0KDQo+
IH5Ccnlhbg0K

