Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4137DC3DA6F
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 18:45:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A997A86AB0;
	Fri, 25 Aug 2023 20:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="CJH25bN4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 227B980842; Fri, 25 Aug 2023 18:24:06 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on2081.outbound.protection.outlook.com [40.107.8.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43A3686A9C
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 18:24:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBeKaqPUtSP/Hvzbjeh0XGuk3l+YC5Nsma177TyshEEBrfyPkJZXHcCBG+MjPpMuqs9bU8WJkDSAeeMkaaVE4yw4PXHJq4cWdWGsC/4OfFhtJ5yDDFvspEmhbg/POzvHHAobGomctaY4IRbhmYHEJ3Da124XRwzULY2yDBtCUJWMksZK0KoRGyNb97VqJt7doqczSNg4Am9R1EeVNOzBDUzolfPJ84rTc2iLXnZNZNk5CvuUA4CcTJvjHOBrTWxQ/EZacnTvIFyGOVr23dnxSM8eBcIOQiW4eg4OkOOT0gV6+nDznBX9prBBacAj6XF1TImc3P4bsnP/nUeNEhm9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9T3q5YzSoEgYRZ4H+VlXmz2L+AVswP5lfp6j7Dy1lI=;
 b=MdPYGHUy7aAng/gL05XhjZGTCvd5NFpdcBParyl5mNAfqPsm3Ka/Qm8sAEjEYHQPsWNPYJuKDt6QjeWg9xK2+tY6dtkw/x//lg/ZstPzaWWwJA4np+LCHAdNC5kXaZUnnSf2W4NtNhlijh8xWxYfCtKZoh2dChCKruWN4lBx6B3rdx6gMppS7jNeKRbK48eYNkddknPV6k4k2dtiXXMkfNC4j7ilUoPtUdBUPiHPfrw8mRInIBEfaQweiEf3aC5VEUd4Z0rm70iQw4deVH7kR0SOQSr1l/FQNkQbu6kZIZnbYGFVFMfTw6jsaLm+8JgUSUkwnq1YfzTnk6DZRVkZvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9T3q5YzSoEgYRZ4H+VlXmz2L+AVswP5lfp6j7Dy1lI=;
 b=CJH25bN4WeYW8dBTBpcQqJlUCpLmeXYsvczOM5J3OPTu6f1rJpjVNCeREo4bGlYx6VTM93BZzqyqun2TB6U6TXlNm1IesWOK+sd0p4A5kyNLM7TNChGaw5HiCXoqFzCcrTXqwioVmGneBtZ5oSs16yZzV2O4uJ8j69V2A3bq6q8uSibNfF9DBefefZhCztzO3ZZpXSVzFrgRH/BJgzOgsLVCke4eui7ymeTUWMtqvvw0S5iRtl8F/yXTLn9ItbT5wbRXfxWw09UZN6zpjCP64jGq4Rak7YW7YvNB8JojiF8hWXM+ZFdDPpyGeWCCs7Jm1pbqM+wNu7zG/NiBU32dTQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB6708.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:86::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 16:24:01 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1422:2669:47c5:d7bc%2]) with mapi id 15.20.6699.028; Fri, 25 Aug 2023
 16:24:01 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "marcel@ziswiler.com" <marcel@ziswiler.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "marcel.ziswiler@toradex.com" <marcel.ziswiler@toradex.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "hai.pham.ud@renesas.com" <hai.pham.ud@renesas.com>,
 "philippe.reynes@softathome.com" <philippe.reynes@softathome.com>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "bb@ti.com"
 <bb@ti.com>, "marex@denx.de" <marex@denx.de>, "pali@kernel.org"
 <pali@kernel.org>, "william.zhang@broadcom.com" <william.zhang@broadcom.com>
Subject: Re: [PATCH v2 3/3] board: toradex: add verdin am62 support
Thread-Topic: [PATCH v2 3/3] board: toradex: add verdin am62 support
Thread-Index: AQHZ11bg/825xbn0pU6e11v5hlgAdK/7Mm0A
Date: Fri, 25 Aug 2023 16:24:01 +0000
Message-ID: <72cf350455ba063d79dd1971a97a39a48aa87191.camel@siemens.com>
References: <20230612205444.363727-1-marcel@ziswiler.com>
 <20230612205444.363727-4-marcel@ziswiler.com>
 <aa6e7ddab0a43f94d8530d4781599d59612764a2.camel@siemens.com>
In-Reply-To: <aa6e7ddab0a43f94d8530d4781599d59612764a2.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB6708:EE_
x-ms-office365-filtering-correlation-id: f0772a7e-ef0d-4b47-b878-08dba587b110
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0DUj//iUQZBVuPchzs2zw3K2lQcwSyUz4V0/mONAxyzJlfDEJFSWe0UMXILyryrQEoTLKU1AysOy2XjU2Zk3SXnUcFgcP3L51lheV/Oy/ndc6tCJKdgCinSlzOfAD0cGFrcoT/LR9q7vpMTZzjrspWfo9fMNpypXxR1FMeOPjyp1BFbwWMm/zXM0GHMqCDeGGPANp/M5X7LVrxETLblkmeTOLKeZWqQbRPsUAg85h14v62X/eNAwaUm2Ru4JNjdoVCTUjG5b1HrB9rdQ9R9SgCOdXi8o8pCxVgb6++YwMhqesxzocdgYq5Oxf2IAzA3bJbA0HhThflpljExF97xr5K52lkd/HA1F1A9Q6Se2SJq2qCJ+A2DMvBpmKWlZlWDghJqbASrE5/0LVQLp4Kh1WaSuWwWL0VffjoNK3jEQ6uayHZ3596AvprZFAOtvvSiQAhOqCUVki6kIMmppVnC8KqbKCF1tEzXnRLunYt0FVuXVzBeh8XAi2hKbSNn0njZNH1VimTSOIkVWRzb7b4uJOUVwtniRzDgU/IY+BxXVpQFCNp1uZcluIT1ok/4nciF/nmS+aL+UAPdsoUiu0ctRI8vW7kDZphR+zdZSy6CCLXj1TWqH434MsN6s53tc5lgW14x2Metk8RPZvZEh5XbEsA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(39860400002)(396003)(136003)(366004)(1800799009)(451199024)(186009)(6486002)(66946007)(83380400001)(6512007)(2616005)(41300700001)(4744005)(66556008)(7416002)(66476007)(66446008)(316002)(76116006)(8676002)(2906002)(54906003)(5660300002)(4326008)(8936002)(91956017)(110136005)(478600001)(6506007)(71200400001)(966005)(64756008)(82960400001)(122000001)(86362001)(38100700002)(38070700005)(15974865002)(36756003)(18886075002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWZ6TFBPODBWSmcrQUZGeDJNOEhnRE1ZaFFEbXlKZFc1Y1JoZ09xcmtCL1ZI?=
 =?utf-8?B?c1M3bDVPRy9NWlQ4dm12M1hYcjNWZkt1bGkxckFKTVZHYkJwaWx5NzZSM05v?=
 =?utf-8?B?OTM3VmdIRHp5dnJpRjhiZmdDN2xGN0g4RHRjTlg1amV6NWxYVWgyNmVwM2RE?=
 =?utf-8?B?M21aQzhSNGY5K1dNZUNMSFpIa0l5VUxKdXB4WG9MRlZ1S0F0KytEZDZIbC9k?=
 =?utf-8?B?Y3BWekhTOWRHU2JZQTBDbUN4czRKR1VoSnhxZEFOclFjaGphMzMxL1hCWUps?=
 =?utf-8?B?V3dFUVVpZUhCc3NYc2lDZHdySTZZL1c2SXlCQU5xMzFIY1NGVnVKZWxMSmZM?=
 =?utf-8?B?ZkdBWFZmYWwvTTVyVlBDUW9tL2JCcmdacXhOT1FJZXhnczloS2F4ZFF2b3FD?=
 =?utf-8?B?WldTRU50UnI5TFdPMDlQNE9JSzZCMWdQTWxZZkFqMWYrUlh6cGFrMXQzY3dZ?=
 =?utf-8?B?N0ppaWkrRUpWVDA2Q3F6SWQwbUQ5Q3BXRko0dWxEUVUyRGpTWTRxL0ExbzRT?=
 =?utf-8?B?bno3MHdBYUVRN3d3dFovL00vNUkxaDlsR2ZZcGFPV2dRUm93MmZOZVJ1OTcr?=
 =?utf-8?B?ZTlXd3E3blpjc3hzenNtTjZnK3Zud00vSkdTalh3cGN1TlZyN2lPQm1nRkFI?=
 =?utf-8?B?cW5TOXJ0MEQzT2JhWTJLQ3hteVlTeitMSk5iSEFKQ1hiQS9aNUpPaHVXdzRn?=
 =?utf-8?B?a1NkMDZhZ2JjMEl3cm03Q1BEV3BmQ0MxSVhYc1l1ZllDRENUeGpkemJvc1p5?=
 =?utf-8?B?TExhSWFJRXowaktneUloekJCVmxKRzNES3FKL0tLaVlTemJPRXJzYmh2VDZK?=
 =?utf-8?B?bWN2YTZLTFZsYWd6bXAzeE9MR2lYY0RiZzgyQkFkdUVQblVrR2E5Nk5DZ0Fz?=
 =?utf-8?B?b090YXI1WGM2RkRzdG5CaHNHWFo3cmhsOXJaaGVYTHlxSUt1MHZzQXlkYUxq?=
 =?utf-8?B?Wlh1Wlk1TjYwcWJWTnNkaU4xQ2h0U1dRcUZ2Z1dYUEtIOTk2Qnh3OW1qT3Q3?=
 =?utf-8?B?TEJBck1OSkZvbjZvWTJCTDhBN3RzNlNFU3FQTDVmR1VVOUc3QnBnRnpCTWJM?=
 =?utf-8?B?Z0hScWxtTTByNVJldE9QbG1weGdFS0xPWFpEZDJ6VUEvY0ZiTGdJYkxsWWR0?=
 =?utf-8?B?NVF5azNtWXhaZ0VXYVAzRi85VzJKaTdTY2F5SDk1cUxKWWp6UXFaS2JYU0tZ?=
 =?utf-8?B?dkxOeStteUNLVjRBMndhOWY1a0w4elFNTk1YdG5WcDUzL1dYVzR3Q0hVKzd4?=
 =?utf-8?B?RkVBb1M0N3I0cVJ6d2xvZGFlRUdWTlJpRzZDeHRjMHBYMlZFN2tPNThrQWN4?=
 =?utf-8?B?YlJZbWtDSjgxZzI0QmI4STZmcmdGNHFNaVZjTEZhRnRTN2tuL0VNUHIxWURp?=
 =?utf-8?B?TlEvenpHeTNaOEkrMnRNZnU5ZllLWjByM3kvZWZmVHEwbG5YVkZZYUhMYVYy?=
 =?utf-8?B?Yld1b3JiTW5GdGdTUVNGdW0xa3pVa2txMmxyd2VhZVZHdnFOL2tVclFzbmkv?=
 =?utf-8?B?b0hwR2JYbzczb1hZSXFlM3FXVFNVcDEyNFY2NHE2ZThmdlBzMFZBVmw1V01B?=
 =?utf-8?B?dnRac3RFLys2RmdBVlRxMHQrbCtLWnN5YTJEMjlHRFp4c0owM0NVUjlESXRp?=
 =?utf-8?B?VlRLemRoMG5MUndWR3NFTVNSYi9NSWFlalJYWHgzYXA4MmlNK1E0NzFrcXZT?=
 =?utf-8?B?R0JyZExCRC90YTZONHIvUVRaTEJCL21wc2NINXZZcy9pdm5PS0hmdEE5Y1p1?=
 =?utf-8?B?VjRqSXFVcGxsRk1MbUI5RTRRSTBBM3kxY1pTYmd0T09zVnE5MU8vUzFCNXRD?=
 =?utf-8?B?UWRHek1GQ0FHU3IyWjV5bE1NQUhrdkZDUkNHZEJkU01UMVY4L3RGMHdTSThE?=
 =?utf-8?B?ODQ0ZkJLTW1iUmlKMFEwdWd4YnFncUR1QlA1WEEvbHZQTG9hZmY2OFN2akZP?=
 =?utf-8?B?a3AvNjJwb1pGSm5YSlJqdnhEK3VBRGdTSlRjUDNwSkdtY1c3ZXhLcUFTMktR?=
 =?utf-8?B?ZzVkY1kxdVAvZjdjekkyQ291eFVqRnJBTi9US0JSd0lEanFFUDBuQ2ptRW9i?=
 =?utf-8?B?ZmloZjRrYkMyZnZOdEJabFRKYS9ZeFlaekNEekFPSmVHaHVxTUw3dHJSZkZu?=
 =?utf-8?B?eUtYdm9SNjJ4TzRadmRiM3NiOHJuYTVRbFJ2U25sZ01XcEdoVU05a1ZsNk5l?=
 =?utf-8?B?VXU0YTZGNC9jZG9WSmd1SEdLQm90MHI0Tjcyd3k1czRuSk5STTBpOHAvZW5i?=
 =?utf-8?Q?hAzViMFVvcgnVIJ2g/EAM1wEuOj9ySGpSLwIVd7umU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AFA1CBFF5209B44EBAB0D43A1D41CB40@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f0772a7e-ef0d-4b47-b878-08dba587b110
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2023 16:24:01.2410 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dWOIs7RoHW/xRpOAiqpHq6C6WueGx/iWN0a0DHvPQuCZo0rRsCmmOPDeYzYiyXKA4As82p1BR93dXmmX1I3EAyX2GIQMw7Ttq56r45HCTzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6708
X-Mailman-Approved-At: Fri, 25 Aug 2023 20:45:30 +0200
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

SGVsbG8gTWFyY2VsLA0KDQpPbiBGcmksIDIwMjMtMDgtMjUgYXQgMTU6MjAgKzAyMDAsIEFsZXhh
bmRlciBTdmVyZGxpbiB3cm90ZToNCj4gPiArQnVpbGQgVS1Cb290IGZvciBSNQ0KPiA+ICstLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ID4gKw0KPiA+ICsuLiBjb2RlLWJsb2NrOjogYmFzaA0KPiA+ICsN
Cj4gPiArwqDCoMKgICQgZXhwb3J0IEFSQ0g9YXJtDQo+ID4gK8KgwqDCoCAkIGV4cG9ydCBDUk9T
U19DT01QSUxFPWFybS1ub25lLWxpbnV4LWdudWVhYmloZi0NCj4gPiArwqDCoMKgICQgbWFrZSB2
ZXJkaW4tYW02Ml9yNV9kZWZjb25maWcgTz0vdG1wL3I1DQo+ID4gK8KgwqDCoCAkIG1ha2UgTz0v
dG1wL3I1DQo+ID4gK8KgwqDCoCAkIGNkIC4uL2szLWltYWdlLWdlbg0KPiA+ICvCoMKgwqAgJCBt
YWtlIFNPQz1hbTYyeCBTQkw9L3RtcC9yNS9zcGwvdS1ib290LXNwbC5iaW4gU1lTRldfUEFUSD0u
Li90aS1saW51eC1maXJtd2FyZS90aS1zeXNmdy90aS1mcy1maXJtd2FyZS1hbTYyeC1ncC5iaW4N
Cj4gPiArwqDCoMKgICQgY3AgdGlib290My1hbTYyeC1ncC1ldm0uYmluIC4uL3RpYm9vdDMuYmlu
DQo+ID4gKw0KPiANCj4gdGhlIGV4aXN0aW5nIEszIHBsYXRmb3JtcyBoYXZlIGJlZW4gY29udmVy
dGVkIHRvIGJpbm1hbiB3b3JrZmxvdzoNCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9w
cm9qZWN0L3Vib290L3BhdGNoLzIwMjMwNzIxMTg0NDQ2LjU4MjEtMjEtbi1mcmFuY2lzQHRpLmNv
bS8NCj4gDQo+IERvIHlvdSB0aGluayBpdCBtYWtlcyBzZW5zZSB0byBjb252ZXJ0IHRoZSBuZXds
eSBhZGRlZCBWZXJkaW4gYm9hcmQNCj4gdG8gYmlubWFuIHdvcmtmbG93IGFzIHdlbGw/DQoNCkkn
bSBzb3JyeSBmb3IgdGhlIG5vaXNlLCBJIHRvdGFsbHkgbWlzc2VkIHRoZSBmYWN0IHRoaXMgaGFz
IGJlZW4gZml4ZWQgYW5kDQphY2NlcHRlZCBhbHJlYWR5IQ0KDQotLSANCkFsZXhhbmRlciBTdmVy
ZGxpbg0KU2llbWVucyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
