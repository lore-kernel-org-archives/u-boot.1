Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92D04E7E635
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 13:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F56C86D7F;
	Tue, 26 Sep 2023 15:38:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=csgroup.eu header.i=@csgroup.eu header.b="ONE1Gzp1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD7C586D7B; Tue, 26 Sep 2023 15:38:26 +0200 (CEST)
Received: from FRA01-MR2-obe.outbound.protection.outlook.com
 (mail-mr2fra01on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e19::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5A8086D7F
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 15:38:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=csgroup.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=christophe.leroy@csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca2VGOUI54IFKDfOLUBDOT1A1/yJKiPwg/76lW1tETAJvtqyOpMnZ1/XYXCyia4ky5lvkV84AQhG4kJrpiP38T4I+bb5QVJrxAeqmO9/5TRheaDx0jJuxfbLKCxrVt4Z+C0ypqHmSbVEdofP2VdZmMQE6YmanrYeQYrQO8fMsr57QnOkDcpqKXs5+PJAtuhpIrIA9rHWu5ISqp8+LYk/aiwBVBl17+g6zIPI4BT7cDjRz826JRX/jkEoidSSlwNCZEr1CEx8h+HLNUS/x7WRON3xaDipldYtVUrBaYNdiSVWV0ncYCqZ141zStavqT/6CtGbFi4c/YH00i3Mopvg2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ssJ/e9RGwZWY/DutYE6OoDsWivPcJjyB9rQdKHNKlow=;
 b=f+Gu6iBfHCpkG5T37e7JiOM2hURlv0TFoKRPJIhVJxUkrfCWfUfGUmiamlogOgOW/qHmp113hy4iz+Uo44pdHnPF855ez+kWLyuIfUCziYIP/UGzLpM8chIZyyM2zBmcoA07VXwCVvy7MduNl/Ei1fTX6v0QgwD8R5WBIYhpvJ/+01KAP7ZYCqrEHhr2xRbNuAFh6yipEh9TffzEPsyjaJEytprT7rrUjhZEJVOl/XEoCHw9v7Yz85/X0ZY0fQK5GzaNpGuELkRvSQtaouIoiAsWPyd7Ozim0j62dVbmD4u+VuZC3rM6eawTzgH6U+5bRkXOCqeSfhV48NT6ba6KJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ssJ/e9RGwZWY/DutYE6OoDsWivPcJjyB9rQdKHNKlow=;
 b=ONE1Gzp1m8OXYoKKH/TFzWDIt4VRjPCMxuwnaRMgv02NzU2bny40dUDO/jdsOEboa4aqTdQJ9MFCPlVFf6d0Mx2ulDMagxYTqYcinlyOhuG12/UDsI5MxQv8mlZK2JZ3WynoCYJIL5e6ZJczNYwo6mnpm+y+9bhq9nuacBy6ap/mlcNTknIOwpnhj+Az1pqi+c2B0+BZm18iKF7JNMDUULYhDRXITm9AhvJj4jdJL450FDGKqJh2S8/nR1CsOUNeEmd8AvdU+qHlY49z2CjxYvxR6MHUgI50sbFRoMUaORUo5NbilSk7m5c44IIRdjwti57CRIqHpW7ke4C2u/SMuQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2257.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 13:38:22 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::2820:d3a6:1cdf:c60e%7]) with mapi id 15.20.6813.027; Tue, 26 Sep 2023
 13:38:22 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 =?utf-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>
CC: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Andy Fleming <afleming@gmail.com>, Mario Six <mario.six@gdsys.cc>, Nathan
 Barrett-Morrison <nathan.morrison@timesys.com>, Nikhil M Jain
 <n-jain1@ti.com>, Priyanka Jain <priyanka.jain@nxp.com>, Stefan Roese
 <sr@denx.de>
Subject: Re: [PATCH 05/32] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Topic: [PATCH 05/32] spl: mx6: powerpc: Drop the condition on
 timer_init()
Thread-Index: AQHZ7CfJs1w3eDbRm0Ozq2r6x6r4ubAtA1mAgAAhxYA=
Date: Tue, 26 Sep 2023 13:38:22 +0000
Message-ID: <2998d637-83c1-36dd-76bc-f02ca805e550@csgroup.eu>
References: <20230830180524.315916-1-sjg@chromium.org>
 <20230830180524.315916-6-sjg@chromium.org>
 <20230831175055.GN3101304@bill-the-cat>
 <CAPnjgZ3FNvR3JGrSFHwMGqny5JHtA7qoX5g13ZBO8Rib67EUmg@mail.gmail.com>
 <CAPnjgZ0vw2ROHAGeat3Pvzn0LGqh6Y-8TFuQ0xzVgM8atUVDpQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ0vw2ROHAGeat3Pvzn0LGqh6Y-8TFuQ0xzVgM8atUVDpQ@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2257:EE_
x-ms-office365-filtering-correlation-id: 9d84a02d-df82-4193-49df-08dbbe95da63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YW88s4lK2erkw9RWjiyFW6eEhrzS93RAVYlzgVoTPIqICtOLHHYy/0uPrvzIrJD8CAvRxloyxKOcCksYapkG8Y9sItVjVpId2oCAwSbO8k4h02UYzi0hH72BIfM2v//NNxHuv+gx+6+N7dQJ5f7IFt0408mC7gq+8cyEr1lHmVcqcL/AXsHs2y2BFNL2ktmR586cpo9tEOvuaYA+fKEIJToJvmBEaaVL4MZr1C2o5PLHKQMU3eplUTED03DXFuOyK7cpPxDYIotzzshJMu2C5oY2nuaVZw6V3VJIHjYoXHqpOor8nwLvsCI9mpM4SP6WvOojOqt8b5dep1sBYFIDer8Ms9Uu3E5kG1eFH89ghLz6mRvQ54BXbN9d0liHHrLzImtmh/3OH0BfTClgfQCrECi19abuoyfL4S7u5ehkCb/fvgdk7aa/9CNICr4ultoCyQ2pqrJGewzY8x2IZ1B1rw/Nl7NtUkQ6ZUUYzv4UEYBjB4apj3+V2pfVrEJgjdS/MtLURZacCpM5Avy/Irrcz910FvxToBUy6F0aKeJYgjmRfc+yRiJlDIvjCxmO5ycT4RSkGgQsV8SAEcuMJ7obir6kSzlFIRIFyky2f5H2zDJgYV6fQjNVw5ZoTvOKDNFF2zyOZOqa1069yEa0Y2cIkwF8l4uMRKbFM3ivvzArD3w9JOX/LGDz7Ts4CZcTSSaB
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39850400004)(376002)(366004)(346002)(230922051799003)(1800799009)(451199024)(186009)(6512007)(6506007)(122000001)(2616005)(66946007)(86362001)(66556008)(66446008)(66476007)(6486002)(110136005)(26005)(31696002)(478600001)(71200400001)(91956017)(76116006)(38100700002)(38070700005)(64756008)(83380400001)(2906002)(7416002)(8676002)(8936002)(4326008)(44832011)(5660300002)(316002)(36756003)(41300700001)(54906003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NTFwZFMyRCtaaEF0K0c0MXhpVWZqYytUdjlTUXNMSUZ0U0tzbmdqRXVSWDlL?=
 =?utf-8?B?cUZteUhEMXR0K0FZcmlUbSt6RlE5WWdYOVN1b1VWWFBQd2dvQ1lHQWcxc0hl?=
 =?utf-8?B?WU1SRFN0RzZSNmtsQkhCZmQxQ01pVzhId0ZqbXFrY0w2WDN2MUlCK0lTbUZB?=
 =?utf-8?B?QUxBekV4S1gwS3JXSlZIWmorWWV5Nnl3MU8wWUZxTmFISVk5NU1VbFVWYXdB?=
 =?utf-8?B?bjdGdW1DOTlOZUFJSC9VcWdDK2RCZlBxK0Zjamt5a045MEw2Qnd5cmw3WHVB?=
 =?utf-8?B?Tms3V2hqclNBYjhWcTRtdnhPQ3J3S3ZVbmNnTlB1bTNRRnZrZXkzeU91dDJ3?=
 =?utf-8?B?UGRwMzNWb2NvK2htWkYyNEtndW5Id3pRS3B0c2lSZDFteGRCQmdOSXZkZ1pI?=
 =?utf-8?B?R1VNYnZLaU1DSnY2VkVyb2NpWjBaeDYzNTFYMGdZelFCTUFNdi9ieG5aMnlm?=
 =?utf-8?B?STFJZ3FqcUZ5QmN1UWtCVWhxaUF0YzJDMTZ2UEpjZHhyMFc3cTBpYksvRGVH?=
 =?utf-8?B?b3p5blNXSUFGNjkyQ0tDUGQ5Vjk2KzhYNmt3N01LYjF2WEpFTE5BYW45cTlT?=
 =?utf-8?B?VHgyV3RQa2pxLzN5SXI4NTFvbGt4STRvQjh1aFBidEpVaENQNlVKWk1CT2Zv?=
 =?utf-8?B?M1oydFFPZGNIZ2krdG5iL2lhVGhzZVRUVmdBMjhrQjlJbk16Z2IwYWVrbk50?=
 =?utf-8?B?RGpDQVdoVE13NmFKS3cyQVJmNDcyZWo4Z3RrN3hvZkVzR3dsVVNhaVFTdXpT?=
 =?utf-8?B?SXZUKzlDTCtJOXNLS090ZExwbzdNRldPOHg5aHgyazRGRUlPNnpwTXdRcGc3?=
 =?utf-8?B?Nk1QY0IyM1JwVmI3RVA2c1BHN3kra2ZqcFMxYmo0bnVWTUVDclBjbGlJUHNs?=
 =?utf-8?B?SE05Z25meEk4MGNkakJPVWpuZVdxaHV6aFdRRkNOWmVwUmUzZ0FWdXZNN1BR?=
 =?utf-8?B?U2VNazljMTkrNTl6eDY2aTBjVjNzdDc4REYrV25hMTdmbE9HR1ZSdWNtVHEy?=
 =?utf-8?B?SWFGanRKQ0dDOHVId3p4R0FiTEthQmFJNnNXbnpZUmNlQmd1ZTdCQ29jY0tt?=
 =?utf-8?B?SXpnbm5jTEFHTWFocndsRk5OVk90NGZaY1hRVXNyOUpaRDF3KzFYdkR1czJY?=
 =?utf-8?B?dXp0VW42OVZ1aDZsOFZDdjdKaERld3NFUVJlajVyc0RLTWpVdVJWOXc5QS9n?=
 =?utf-8?B?eDJoWkxnVStkdjVxK0pCV3RObVpSSWNtUzNpU2RMa0crRWtMMThPVnMveTU2?=
 =?utf-8?B?aVErNHB6cHAzSWx0ZVVLSTRsSEJzNHN2ZHp4ZE5laEUwSUlPWXZyKzhNQXA5?=
 =?utf-8?B?UmQxZlYySGhtMG8yUWZUbEVlSExMbnpKeXQ2emxoWk00QS9HeG5uOVREZ0ZT?=
 =?utf-8?B?Myt1aURXUStMRkpTV3JxMEhqQXJOSnJzSndiek0vSzFLZXM1bUJUZEcrQ1d4?=
 =?utf-8?B?Uzg0eElGYUVXeTM0cTlCQ3Fjc1k2MFdWMmN3dDZzWTNJMVhZNjFVbTRkcWVK?=
 =?utf-8?B?MCt1aHJ6NEJ1dEY4NjJGQVdrbWRrSlUrbXdTWHNkckh5bzZ1VVlGdnhqTmRw?=
 =?utf-8?B?M0tOOWROYzRiYXpFT3FSbDRmUHA2MjBpdzRGM3VLNjMvT0x5Z0lkVHR4clVu?=
 =?utf-8?B?ejB2US9pY0lMSWpJa3FHYUt1bzBQUGdodENuR3Ryem5DSlpnS0YwaHVjYUJP?=
 =?utf-8?B?UlpqR29qSmdWWHArMThTcFdBN3FJbVdWYXJNUUY2NXpCZzZ3bXZTbVZJaCtX?=
 =?utf-8?B?M296VkVsSHJZWkNGeXVYVy9iYVNUdXpuVVErWDNJN3FRNjNqZ3FMdk1FUTZv?=
 =?utf-8?B?elE2NGZFR0NPTkp2Q0hzWFQyS015MU1vdjVsTkxUaDFTTHVxd0JPZnNlQ1Vk?=
 =?utf-8?B?d1h6Nk9OYkhmeGZpZFdOdFRpNEpvM3Rya1JSSE5nOUJicDZnby9nREZhbjVz?=
 =?utf-8?B?OFFkb0RXeDhSWkEyRzNtZVRORWhMN0VCdEpwOWVCS0hHOC9Iai9HVmpaajls?=
 =?utf-8?B?UjZQVythaTdmS2N3TjJzaXhkNVVEWUpGamE4M0RsbHNPWWtURlBwZlI1QjND?=
 =?utf-8?B?V2dOdjROMFpNdEkzWkhibWd2a2JEUmRMcTRDTE5OdWZJREZ0dzk2d3RJMDhT?=
 =?utf-8?B?VGtsSHVmNExKWFd2MnhrSkx0eVRWQlp0NUpRNVRiblpKcVhlZ3k4RUQ2MER6?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <427EC9FE5D12D24FA469DFC495B8747D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d84a02d-df82-4193-49df-08dbbe95da63
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 13:38:22.6260 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pGkAL0cIHDMu2D9JzOVUVcWFwM1qrgv2cs6jhRrjXx+5MnympaZBODYFUsnrm+LXGrw0ByQ4gC4VADLGkdixb1fJB97pF5lj7K/LsS/hpwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2257
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

DQoNCkxlIDI2LzA5LzIwMjMgw6AgMTM6MzcsIFNpbW9uIEdsYXNzIGEgw6ljcml0wqA6DQo+IEhp
LA0KPiANCj4gT24gV2VkLCAyMCBTZXB0IDIwMjMgYXQgMTk6MDMsIFNpbW9uIEdsYXNzIDxzamdA
Y2hyb21pdW0ub3JnPiB3cm90ZToNCj4+DQo+PiBIaSBUb20sDQo+Pg0KPj4gT24gVGh1LCAzMSBB
dWcgMjAyMyBhdCAxMTo1MSwgVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4gd3JvdGU6DQo+
Pj4NCj4+PiBPbiBXZWQsIEF1ZyAzMCwgMjAyMyBhdCAxMjowNDozNlBNIC0wNjAwLCBTaW1vbiBH
bGFzcyB3cm90ZToNCj4+Pg0KPj4+PiBJdCBkb2Vzbid0IG1ha2Ugc2Vuc2UgdG8gaGF2ZSBzb21l
IGJvYXJkcyBkbyB0aGlzIGRpZmZlcmVudGx5LiBEcm9wIHRoZQ0KPj4+PiBjb25kaXRpb24gaW4g
dGhlIGhvcGUgdGhhdCB0aGUgbWFpbnRhaW5lcnMgY2FuIGZpZ3VyZSBvdXQgYW55IHJ1bi10aW1l
DQo+Pj4+IHByb2JsZW1zLg0KPj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBTaW1vbiBHbGFzcyA8
c2pnQGNocm9taXVtLm9yZz4NCj4+Pj4gLS0tDQo+Pj4+DQo+Pj4+ICAgY29tbW9uL3NwbC9zcGwu
YyB8IDYgLS0tLS0tDQo+Pj4+ICAgMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+Pj4+
DQo+Pj4+IGRpZmYgLS1naXQgYS9jb21tb24vc3BsL3NwbC5jIGIvY29tbW9uL3NwbC9zcGwuYw0K
Pj4+PiBpbmRleCA3OGRiOWVmNTMxOC4uM2Y1MTNiMDU2M2EgMTAwNjQ0DQo+Pj4+IC0tLSBhL2Nv
bW1vbi9zcGwvc3BsLmMNCj4+Pj4gKysrIGIvY29tbW9uL3NwbC9zcGwuYw0KPj4+PiBAQCAtNzY2
LDEzICs3NjYsNyBAQCB2b2lkIGJvYXJkX2luaXRfcihnZF90ICpkdW1teTEsIHVsb25nIGR1bW15
MikNCj4+Pj4gICAgICAgICAgICAgICAgaWYgKHNwbF9pbml0KCkpDQo+Pj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgaGFuZygpOw0KPj4+PiAgICAgICAgfQ0KPj4+PiAtI2lmICFkZWZpbmVkKENP
TkZJR19QUEMpICYmICFkZWZpbmVkKENPTkZJR19BUkNIX01YNikNCj4+Pj4gLSAgICAgLyoNCj4+
Pj4gLSAgICAgICogdGltZXJfaW5pdCgpIGRvZXMgbm90IGV4aXN0IG9uIFBQQyBzeXN0ZW1zLiBU
aGUgdGltZXIgaXMgaW5pdGlhbGl6ZWQNCj4+Pj4gLSAgICAgICogYW5kIGVuYWJsZWQgKGRlY3Jl
bWVudGVyKSBpbiBpbnRlcnJ1cHRfaW5pdCgpIGhlcmUuDQo+Pj4+IC0gICAgICAqLw0KPj4+PiAg
ICAgICAgdGltZXJfaW5pdCgpOw0KPj4+PiAtI2VuZGlmDQo+Pj4NCj4+PiBQb3dlclBDIG1pZ2h0
IGJlIGEgbGl0dGxlIHRyaWNreSwgZGlkIHFlbXUtcHBjZTUwMCBydW4/ICBBbmQgcGxlYXNlDQo+
Pj4gcmVhY2ggb3V0IHRvIHNvbWUgb2YgdGhlIGlNWCBmb2xrcyBpbnN0ZWFkIG9mIGp1c3QgZHJv
cHBpbmcgdGhpcyBhbmQNCj4+PiBob3BpbmcgaXQgd29ya3MuDQo+Pg0KPj4gWWVzLCBDSSBwYXNz
ZXMuDQo+Pg0KPj4gK0NocmlzdG9waGUgTGVyb3kNCj4+ICtNYXJlayBCZWjDum4NCj4+DQo+PiBQ
b3dlclBDIHBlb3BsZSwgZG9lcyB0aGlzIGxvb2sgT0s/DQo+IA0KPiBBcmUgdGhlcmUgYW55IGFj
dGl2ZSBtYWludGFpbmVycyBmb3IgUG93ZXJQQz8NCj4gDQo+IEFwYXJ0IGZyb20gdGhpcyBwYXRj
aCwgaXMgdGhlcmUgYW55IHdvcmQgb24gdGhlIERNX1NFUklBTCBtaWdyYXRpb24/DQo+IA0KDQpU
aGUgdGhyZWUgcG93ZXJwYyBib2FyZHMgSSBtYWludGFpbiAocmVmLiBib2FyZHMvY3NzaS9NQUlO
VEFJTkVSUykgYWxsIA0Kc2VsZWN0IERNX1NFUklBTDoNCg0KY29uZmlncy9DTVBDODg1X2RlZmNv
bmZpZzpDT05GSUdfRE1fU0VSSUFMPXkNCmNvbmZpZ3MvQ01QQ1BST19kZWZjb25maWc6Q09ORklH
X0RNX1NFUklBTD15DQpjb25maWdzL01DUjMwMDBfZGVmY29uZmlnOkNPTkZJR19ETV9TRVJJQUw9
eQ0KDQpDaHJpc3RvcGhlDQo=
