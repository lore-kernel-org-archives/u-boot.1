Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC6EE7E642
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 14:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B7C986DEB;
	Tue, 26 Sep 2023 16:27:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=csgroup.eu header.i=@csgroup.eu header.b="c5//GeF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 271AC86DA2; Tue, 26 Sep 2023 16:27:42 +0200 (CEST)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e19::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 546C986DEB
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 16:27:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a967/1lxtIszRW9TR3H04zfObVb+X0z0fJ86eATGsyQ03ouC7lSZW2RiR2ArbBqksG8JX87Fskl202RDIIgHiqA5WYIR3Hav/SbyQ9rAxLAgSzFjz67NDF9yuKKqYmm3fqnQ8SnOskERt+umfq27osXezgAZ1RXWBT9A37LKbYdWCkytyOM7koe6aoKTWsVPkgVjy/teu7KhdXICKmLdsHRokg13DGMMTH8Y00NQhAfarGEAbo40ZuyevAk35R/48QsnE1o26AmBC+Zy5taZrPsqN45pKjozdXEBCW20alPH/iLy62yIHsx3WkIHDtCgpGyZ10I3TYdiuhcDgVGsOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6y3kGLP6yJEGlqbsM+lMNqzf8b5NtH1o9o/baJXMCzs=;
 b=FTQ8XvS27IKJ2KCYjs9uF4Vot7yYQIhms1x7bnNKiJCegyrgNgZXl6/YbBh02D7AmEVIpSZTLRKLK7XqeVY+Gn6CpNw0CuNBHTcgK7c1Jj9Psq4PZsRUdQ2TYM3GKalpXUKEnbkNZua7b5mU/ypvrPZdHLkfMQf1qZhLT6gaylfaYgP4DwRH0xVIfwcND4Qjoplzvy130ibFOt2sdei1vEnkI0YJZXFnAfRXShHURyQ/YeKi/M/IZnIYuDLwG8/x8vXLvOoJynWWihx1AiNEZmgebDp4WmW1QiEgTH+MfMPKKclH+dQtFSsjfmCvu01pVdyalRP9HyUEHTC2RxWxQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6y3kGLP6yJEGlqbsM+lMNqzf8b5NtH1o9o/baJXMCzs=;
 b=c5//GeF8beO6V6XdOOYYaTQiSEpI6W91nyKbOYAfHtVdli4LxSeBt5ia7fsP4ojoDptzjKE43Fp0zfkNwe8QYWP+mKtCzU6AbIqQtTPv4GInl0KBB1lMiYpjQQ2M/Kmjsyu5E3drz8Frhe4kn2oajJkDedPtQzhhAjzTMnTBQ/GQollyFNf2f83OTmQBopGvBtNPQvAKOgaB9OAfFKfxFUt9Xm52aXQJuk2rn1sf/8JovUW+Q5l6cNZNV/Saxd5cK2BCB1gqclJwT9rB3pFEkeXy9cZujkJ1S2OWfvg5B42YbB9v5o7e4bF3LjIhtdAqvnQFiON0RsP2upt/k30OGA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3360.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 14:27:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 14:27:38 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, Andy Fleming
 <afleming@gmail.com>, =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, Mario
 Six <mario.six@gdsys.cc>, Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese
 <sr@denx.de>, Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v4 05/44] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Topic: [PATCH v4 05/44] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Index: AQHZ8IPoM7R5ZYADrU6p41GQixhtTbAtKisA
Date: Tue, 26 Sep 2023 14:27:38 +0000
Message-ID: <ee07c100-b452-e73a-a48e-399e4b34105b@csgroup.eu>
References: <20230926141514.2101787-1-sjg@chromium.org>
 <20230926141514.2101787-6-sjg@chromium.org>
In-Reply-To: <20230926141514.2101787-6-sjg@chromium.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3360:EE_
x-ms-office365-filtering-correlation-id: a689828d-da16-40e5-2d0c-08dbbe9cbc63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m30/9an46gZ0oSewLl2ksHi+hSYStpDuC9W33fpTDTDn+F7OYHrDrNXY192XrFLXSMjE8WL/pRYhWt+BcQp8UmTN7nl1x2IpQt9PmRNq9C7YqXl4S1bw6/RQMZeUtej+nYeIrUPFA8gRuGM2WMxxH8C+O5FjVNqhnzpi0ZrpBwCn8Fgcb3tHu9k0AMiP/iM49IToWcW8gsmwYwoTzaGmU8EW7JmuUwSjbXEWr9GnWxTeDHuzgwHga7tV7F7n3EMZ0ZhWX2qpStwmTmrJwRBoTwep/W62pbqRLbrgDs58Kh7STaA82PRxIlqPtwOgO5MAWMHjJaKedj0eI281Suv8wzbMwUrqRVMg1NxaPJwHQdiTTdGI9sxMiCAikRz0Z0MPcvkgqCWJYWs3fQsfKrzb1GKoVzWT5TPZEz4g5gWt0PlFE9JXuqfbWP0DcHjGVC/8q/cfbxQYufsFVw7l0ii/fMQsBL0v/t6jJzxB4m9Dp524bm71s50GQ6DdsrrjfrHaA628MQ6q2P0QD9XBerrMDZdxeCJjkoOkoEaU087ndOYgDVyGA9wAg9uVmPwck7iKgYAjTUwMN+WYP4noysQ4fFcgymG8RCYz9qvdaWzQvMrdsVwBsNh//DcOIdx6eDoq5Eaun/4aSAjh2LuSwNTsp6mbGF3qotLv4rWe8l8BCE8JciNAEMKwDGaZjorXej+m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(376002)(396003)(39860400002)(366004)(230922051799003)(186009)(1800799009)(451199024)(6506007)(71200400001)(6512007)(26005)(86362001)(91956017)(66556008)(66946007)(66476007)(66446008)(110136005)(31696002)(6486002)(64756008)(478600001)(38070700005)(38100700002)(122000001)(2906002)(76116006)(83380400001)(54906003)(5660300002)(316002)(36756003)(8936002)(2616005)(4326008)(44832011)(8676002)(41300700001)(7416002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHlCMldNb1dNeFE1MlFuUE44UmdHUVhJa28xRWZENUNvVlNGOGtYQy9xbVFO?=
 =?utf-8?B?Z3BGdWhPdi9HYTg4dGFxTEJQc0tPeHJYWDlEZUYwUFVINU9GVlY5MTdYL1Zy?=
 =?utf-8?B?Ump6bnZsd2Y3TU5lRlBjNGVvRWF3RGRmODd0bTAza25FczM2R1ZQTmhROU4y?=
 =?utf-8?B?MEwvN2oxbDE1aGVZSDFtRE5HcUdQYWZxQk1sRkR5SElZTE5CaG1pVTJ3c1h0?=
 =?utf-8?B?bTZmeEVMYm81dy9odWlZSXFoei8rYjdRSDJrWjlSOGwzOE1sRWJCb0tTaDFE?=
 =?utf-8?B?dzlmWmZHQ2o4d0tBRDMxWEo3Y05TdUVIKzNmaHVheTlXQTFzQjVCYTVlWkZT?=
 =?utf-8?B?SGtIR296OUNLd3pFVlBwbmlIc2pFVWllOVhMemczRlpJRWdxTmNmN1dzWHVM?=
 =?utf-8?B?bG5BdEdIekFWZndrM28yOG1kcHUveDN4V0ozajI3THovL3ZadERzUnlvSVFy?=
 =?utf-8?B?anRqZzY2MVUrdlJWYzV5ZzNrMURtN1RqT2o5WUsrK3o4MUdvUjMwVW95dWhG?=
 =?utf-8?B?bGdyK2lEWmpkVk1hZzlCeE10OHVLSXl0b1k5T3BnYi9BdWVMQWQ3VWpSdWlF?=
 =?utf-8?B?OExIU0pZMjA3WkxmMXgxL3dTRmNHTUQwY1EvM2dESXl2bG5raHVqU0tJb0Yr?=
 =?utf-8?B?dXVjZEUvbmFHclhBZGd5Z0Q3TEZWSUliZ2psVmZndGxQSFdnYVVoaWszTnN4?=
 =?utf-8?B?NC9rd2I1STAwUkEyUzJhY3FJbmVJdEw3WHlNQ2libUs1U2pyVGZIdVlvTmZo?=
 =?utf-8?B?cnRVVjQ5NTcrU0ZBb0JZOVVsWS9LRGRsV2wwOUE1V1o3NGlXRzNrYzFTOTlz?=
 =?utf-8?B?dWY2ZzlJZDRmaGN2T3p5SU1Md2NtWDhONFZXalJMR1VNUGxLRGcrZ01rRGRp?=
 =?utf-8?B?eFB1aWlqUkY4anZheWw2MGI5NEpKRHk1UlZWYU01akZ0SWN1ZUJDUlBIRWQy?=
 =?utf-8?B?OVVjaTBUakpraHRxRjZzMENDRkNwY0xaOUdFem1mYUlIUkFvMGk3dXQ1N3BW?=
 =?utf-8?B?R3k5ZTI1cWJxbXJWcm54bERTRDNzaWRiSUtSWUQrNFp5THVjOExlRm5mMjlM?=
 =?utf-8?B?M3FYZ3BJZGNyWEI0eEpBYWg0eU1XOWhGdTZ2ZGRJU2w4YVpwa0thak1zaUxQ?=
 =?utf-8?B?QXVtbVE2OGIrTWJzaWdKZlpiTzgzUWlvc1p6aEdldXpjeWtVTEU1OFdYWWJ0?=
 =?utf-8?B?TittZ05wbmJFb3BKbXNiRkdYaVN0Tko1ZmNuTDVLV2JpNE5NMEtuZU1mV0tr?=
 =?utf-8?B?Zjhjd1JtbW5qcHEvL0wwdVJuV3lHeHR5V2UrU1o1NEpWa05NbXlqN3YwVW5O?=
 =?utf-8?B?LzVZbG1RUWQ4WDRvWmxvakdRM3NCSDYzSTMvNWZiWHk0REJuTDNnN3NhRFJE?=
 =?utf-8?B?a051UGsydnp3RVhHcFZ4NUI2MlpXbzZuRmo3b3p6SHV5ZmVCekRJVXozSUVu?=
 =?utf-8?B?bEpxZlVaYXdrVzN3OERNY1J2MkthN2xXUkQzc0wxbmt1a2xOVHZuSERlSWtn?=
 =?utf-8?B?eHI4ZVp5SUZJakFSUnNGSkdPem5KYzR6TUM2cC90NHhlMnZxKy9hY3VIUUhX?=
 =?utf-8?B?TC8rOGlZZHZWKzNnU1htbytENjRqd2JCZ3dVclR4N0xTaGtZbjZXZEJLY3VM?=
 =?utf-8?B?UkJxcTY2Mzg3a3BXM2luVDJqaDJFWjVvNHlJWXhpQ2FrbmREbmtJc3JUSzF6?=
 =?utf-8?B?S1l4aUVhOTFkdCtIRzZOckVLVnd1bFpIeHJsNTBIb01rRWJ6TlI0dkdKS1NL?=
 =?utf-8?B?UVFyMWpEWmVET0d5a1pOWkZpOWd0Z0RiMTdWdXl3bTRndTlCeVF1dWUrWnNu?=
 =?utf-8?B?WGdhRWh3TDF1RlJpd3d3TGoxZ0RtK2pld1Y5b1o1NG5XSk5VZ2FUQmR0cjNE?=
 =?utf-8?B?eWVGc2dXQ254dk5yLzlxTEJuekdhcEVVeFd0MStQK3FsUEV3TnlwdG83dDZ6?=
 =?utf-8?B?aU1vZUVTcXB1QVh5UWREK3dNeWlTb1FvajlWVmtPRTZJMUtudGJoSVdYRml2?=
 =?utf-8?B?bk9pOVhJamVwNHpuOENmMVF5VmVVRGJKRG5HbmNrRHA2emIremt2VFUzMUYx?=
 =?utf-8?B?SXdHM2RmdHVMR1N5WUtOTWV0TVk1UXk1UFlqMUNwYWJLaEZMeDkyMVRvSVVr?=
 =?utf-8?B?VCswdkhaNWJHajNiUjNwbURBMk00c1NqbEllZDYxbzZjZk5BUWk2V0VNR2I4?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBC76AFE0279D74F995035D22BB41307@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a689828d-da16-40e5-2d0c-08dbbe9cbc63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 14:27:38.7595 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Lnhlc8mYaYgqZzaezb1lasznwhf+ve004Xt3Am+FZHKLsR5A0pyPctlww2U5QVT8DGMFQd/kBKOeuq40Ku0RajmbXIlGbCjPEosKO+4X18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3360
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

DQoNCkxlIDI2LzA5LzIwMjMgw6AgMTY6MTQsIFNpbW9uIEdsYXNzIGEgw6ljcml0wqA6DQo+IEl0
IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byBoYXZlIHNvbWUgYm9hcmRzIGRvIHRoaXMgZGlmZmVyZW50
bHkuIERyb3AgdGhlDQo+IGNvbmRpdGlvbiBpbiB0aGUgaG9wZSB0aGF0IHRoZSBtYWludGFpbmVy
cyBjYW4gZmlndXJlIG91dCBhbnkgcnVuLXRpbWUNCj4gcHJvYmxlbXMuDQo+IA0KPiBUaGlzIGhh
cyBiZWVuIHRlc3RlZCBvbiBxZW11LXBwY2U1MDANCj4gDQoNClRoaXMgd2FzIGFkZGVkIGJ5IGNv
bW1pdCBlYTgyNTZmMDcyICgiU1BMOiBQb3J0IFNQTCBmcmFtZXdvcmsgdG8gDQpwb3dlcnBjIiks
IGFuZCB0aGUgY29tbWl0IGxvZyBleHBsYWlucyB3aHkuDQoNClRoZW4gY29tbWl0IDcwZTJhYWYz
ODAgKCJib2FyZF9mOiBwb3dlcnBjOiBVc2UgdGltZXJfaW5pdCgpIGluc3RlYWQgb2YgDQppbml0
X3RpbWViYXNlKCkiKSBicm91Z2h0IHRpbWVyX2luaXQoKSB0byBwb3dlcnBjLg0KDQpBbGwgdGlt
ZXJfaW5pdCgpIGRvZXMgaXMgdG8gcmVzZXQgdGhlIHRpbWViYXNlIHJlZ2lzdGVyIHRvIDAgaW5z
dGVhZCBvZiANCmxlYXZpbmcgYSBwb3RlbnRpYWxseSByYW5kb20gdmFsdWUuIFRoYXQgc2hvdWxk
IGp1c3QgYmUgZmluZS4NCg0KVGhlcmVmb3JlIHRoaXMgY2hhbmdlIHNob3VsZCBiZSBvayBmb3Ig
cG93ZXJwYy4NCg0KQWNrZWQtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lA
Y3Nncm91cC5ldT4NCg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNo
cm9taXVtLm9yZz4NCj4gLS0tDQo+IA0KPiAobm8gY2hhbmdlcyBzaW5jZSB2MykNCj4gDQo+IENo
YW5nZXMgaW4gdjM6DQo+IC0gTWVudGlvbiB0ZXN0aW5nIG9uIHFlbXUtcHBjZTUwMA0KPiANCj4g
Q2hhbmdlcyBpbiB2MjoNCj4gLSBFeHBsaWNpdGx5IGNvcHkgdHdvIG1haW50YWluZXJzIGFzIGl0
IHNlZW1zIG9ubHkgTWFyaW8gd2FzIGF1dG8tY2MnZA0KPiANCj4gICBjb21tb24vc3BsL3NwbC5j
IHwgNiAtLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRp
ZmYgLS1naXQgYS9jb21tb24vc3BsL3NwbC5jIGIvY29tbW9uL3NwbC9zcGwuYw0KPiBpbmRleCA1
Y2M4NjI4ODE0NWIuLjQyMzMzOTBkN2RlMiAxMDA2NDQNCj4gLS0tIGEvY29tbW9uL3NwbC9zcGwu
Yw0KPiArKysgYi9jb21tb24vc3BsL3NwbC5jDQo+IEBAIC03NjIsMTMgKzc2Miw3IEBAIHZvaWQg
Ym9hcmRfaW5pdF9yKGdkX3QgKmR1bW15MSwgdWxvbmcgZHVtbXkyKQ0KPiAgIAkJaWYgKHNwbF9p
bml0KCkpDQo+ICAgCQkJaGFuZygpOw0KPiAgIAl9DQo+IC0jaWYgIWRlZmluZWQoQ09ORklHX1BQ
QykgJiYgIWRlZmluZWQoQ09ORklHX0FSQ0hfTVg2KQ0KPiAtCS8qDQo+IC0JICogdGltZXJfaW5p
dCgpIGRvZXMgbm90IGV4aXN0IG9uIFBQQyBzeXN0ZW1zLiBUaGUgdGltZXIgaXMgaW5pdGlhbGl6
ZWQNCj4gLQkgKiBhbmQgZW5hYmxlZCAoZGVjcmVtZW50ZXIpIGluIGludGVycnVwdF9pbml0KCkg
aGVyZS4NCj4gLQkgKi8NCj4gICAJdGltZXJfaW5pdCgpOw0KPiAtI2VuZGlmDQo+ICAgCWlmIChD
T05GSUdfSVNfRU5BQkxFRChCTE9CTElTVCkpIHsNCj4gICAJCXJldCA9IGJsb2JsaXN0X2luaXQo
KTsNCj4gICAJCWlmIChyZXQpIHsNCg==
