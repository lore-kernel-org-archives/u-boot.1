Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F02CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 14:59:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EACF87284;
	Thu, 19 Oct 2023 16:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="qukEAcrT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67BBF87243; Thu, 19 Oct 2023 16:43:10 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6A8887208
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 16:43:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ivan.ivanov@suse.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TabCvAHtVZUrH1GaP1JNlcAYtNzPkO5ZllAR5SvqJnG4LV1gPZGqpA+nxl7pSx3Ri19WuMar2o4uSq3ctSeCyckmjZmjSUtAD9YbE7WkxYrqjhqrOdluhzyTpdDJx3sx/Pku3wK8UjH47o2RdeRgB9jYaN1aBCXNfqgNJ6lrxXeLmz2ttM63s0c9GSY7eInGezoZxg2Bt5UqvS0+BxvfuvjS9MxjN6OPopO0UttOEoiM0HtvC58Wg+z3NQfWV/EEJWFjyZF9vrOBym0qDYq6LCmAA/0EzZ2hx7cMqori0z0AB0Aw6TOhnCsvL9xwflkTgDHiSgem61XSUJOVJpAoGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlAN0b7+yt3Y1eR0aI1qyOiIpXG2MX+4HL+zcnVhhs4=;
 b=j1ZCMeIhDfhMRXci346Zx8Ica9GUqfzeK1dMxRRWrQCwbM+N8UgK5fmpaGPNY05ZqEutWmrMquluQMDBpuUiGcvzC4PB+EGdHCYR57dq76g2sEzmpwVEkS4ltwCcRJ7JCVUCEgQnnnzBLy0NF0TaqSfqjHMF6Q2vHa3F06UR8ztUaWZy08Ej8wBMS25+GaGitU878tY5zDl+gzXiezSIB7tw+c0RgMUKm2mr4qB27oZam1raMlqtzPSdGPRarz+7ouTpaYWEvVHJdU6iITJQyNWPSoe8m3quLagCOig2muy4ECTd3wqrZQ5gdl6ECrQMZ4C0DT33vDKy01DZS3yHgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlAN0b7+yt3Y1eR0aI1qyOiIpXG2MX+4HL+zcnVhhs4=;
 b=qukEAcrTShTL8azB63e53wuncNOp+Qn/LdGBoxvjTTbU6vejjAsKkUuGRyeRBjXKQv+1DnCbR/EY0uwNviYQAGLQYdRzeFJ7KsWoW1YP46jv73mH7y/kqge+JDlEZSjp5/RW88TpzjLFMIKx1dQ0E0E7NraGB7RyNQiRCRHtgRIOwt1y12OxxA+1KJPAWOXfQO6fVxvXex5PDdEQ7OPSZF1abXo/4DRABqmTggRoJufNmTA+49ooqHUV+2DHXS+frvZ/af9q/f4Q1L6+iSpK+p8hi/cFeYng4QBJzfr5xRvS3Zqjdxord6pWs3TNBsvB24gwoubM4faOgk3osCzlFg==
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com (2603:10a6:20b:103::9)
 by AS8PR04MB8706.eurprd04.prod.outlook.com (2603:10a6:20b:429::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Thu, 19 Oct
 2023 14:43:02 +0000
Received: from AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b]) by AM7PR04MB6839.eurprd04.prod.outlook.com
 ([fe80::529d:3ac4:e17f:174b%7]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 14:43:02 +0000
From: Ivan Ivanov <ivan.ivanov@suse.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: Guillaume Gardet <Guillaume.Gardet@arm.com>, Matthias Brugger
 <mbrugger@suse.com>, "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Topic: U-Boot 2023.10 does not boot from uSD on RPi4
Thread-Index: Adn7Wr0e+LRv6MRIS4aqQVJurtxargACOEoAAAB9fxAACSUYgACMvy5QAStVywAACoWvgAABAOWAAAAj6gAAAFongA==
Date: Thu, 19 Oct 2023 14:43:01 +0000
Message-ID: <f111238e4b47f0ffd1ebb29881959b3f9a489d96.camel@suse.com>
References: <VI1PR08MB2847E276099DF7263424F70083CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CALeDE9N6nhRBwtYqJ=7nqYuCsmbw03j3RBXRQ8jYsD=OMY=gBw@mail.gmail.com>
 <VI1PR08MB28474179AFB989B308072B1E83CDA@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <CAPnjgZ3t9-trzoLGc7Jcj0=J0sQLQcHSGN3_Pf+3=iZ6=rPPqA@mail.gmail.com>
 <VI1PR08MB2847B5EFD8F36E5A4D41FEBD83D2A@VI1PR08MB2847.eurprd08.prod.outlook.com>
 <a151e6508695fcc2cee740f299e58e0fee6146b3.camel@suse.com>
 <CAPnjgZ0KVwF-u5G2r-zt8+FmiHK_2ASEsoro3MtVsah58_WqMg@mail.gmail.com>
 <d0cfe8627544d1699031315cc53b961c4cadc126.camel@suse.com>
 <CAPnjgZ3AsKe9V0gE8KBbjaFQv9+3xTrqfV9k=HiDOgmBenqGRQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3AsKe9V0gE8KBbjaFQv9+3xTrqfV9k=HiDOgmBenqGRQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB6839:EE_|AS8PR04MB8706:EE_
x-ms-office365-filtering-correlation-id: f7f1a21a-7d7c-47be-d952-08dbd0b1b228
x-ld-processed: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t/wNy/IfnJGn/oNcH0BwtHlkOUG4YP2xfVrLBDc2m/eiNcFknM/zDfvecIzdy//yEVPqhrBbvNpG+T1P210CZ0I455DigLEOe0BFI3v7vgaOeLUxRtZwiB3lr68DjZLP7VQfcqx/YvyRfQXI68enJJ7QeNS2PPnnS9+nTQYu+ubYhCEfwkH8KBXxX7FJ4rMZ9roV2y+mG2gQjtj5idiZ/03fM6RoRm4WVDXptFgPv39rKZKalDzXLsC1DqoKN/4+bf/QVBLZooBPX+Fh+L3F1vBiLhFKTqtswkEZnz+MIT0pB3Br+P1YYelPOyxfiejCtfvHZ43og+EsO6fzzpkRQeUvTE00hBWu65hnFkmGfd2zWR/1SLDGH7gYAuUcy3Oz3WKj/wYKCHJglxvvOGZEqvGGNrZH7mh3z9pO3U5Gx0f/trL1DfaPQxgeR9QT9/zKQjBaM+lAgqBr7W/Z4BkyEJaQJTZb46yKrFok4/aRy4g3q6m1KYZ9lEUhM2wRKYVqkCyAHNbdvwPEpu/yM6M55EXEW6MEx8cUnMbDETrF9pAH0W4lspnbK3vRHCkFzVtHEbLs61o8BJl9ZPhdn2nzNfRAiSJgijmxhuDYuPfc9ppwkjELLWLbhHv4SRGmFz7GkBp1Q5meclNDweAmEf/8rw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR04MB6839.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(44832011)(36756003)(4001150100001)(2906002)(122000001)(5660300002)(8936002)(86362001)(4326008)(71200400001)(8676002)(38070700005)(83380400001)(38100700002)(2616005)(26005)(316002)(6506007)(91956017)(6486002)(478600001)(966005)(6916009)(6512007)(66946007)(41300700001)(66476007)(66556008)(54906003)(66446008)(64756008)(76116006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHpJUVNMUmU5dzcyZGNnN09uYVFWbElmUTVubjZnREh2WHpheWJUaEh2bFpK?=
 =?utf-8?B?dG5aMDN6TnJGak5BUGlIRWViMjBNYXkyUUxFSXhscllVS1pXTUNMSkRNL2dL?=
 =?utf-8?B?cVJEUnRGOEliZ1ZSNDlmTEVBb0I5TytlS1YrVFZyUWpYNjNZTWE3NTI2b1Uv?=
 =?utf-8?B?MkJzWGs0T2ROekc5V3VNNTMwd3YvUmZ2d0c4cXhIUzJraTJRUjlOYmgvZEJB?=
 =?utf-8?B?NWd2ajgrUU5yVlIwUW94REFTMjVIbjlIN3RoeHVkbFNuenZxWmVhU25JOGdE?=
 =?utf-8?B?a1JnQTlEdGw2bm4yMENFMHV4THpMZ1VheHhwTFZDaHR4UVFHdVdKanZocGRu?=
 =?utf-8?B?WlBTaTBueWlTeU51YWFGcE1nNStucCsxQnZKaHN6ZlhLbGhNNXMvV3k5bmVT?=
 =?utf-8?B?c0FCUVA5QXpVQlJhdDFsSUZ6OUhLRDhaVzlwTlFPSVc1bUVGR2ZuMmdyL2FW?=
 =?utf-8?B?ajR3OGE4cW96ZGxuSnZXaGRnaVZ0cWFYc3NlVjBtR0dlbVJzRWZ2dzlPN1pZ?=
 =?utf-8?B?aUk2MjNCYm1KbGdVWU4ycnZUZWordUlYVzVaeFdYT0tHMXFsZ2F3VzRFNDBN?=
 =?utf-8?B?WHpJTHFNazhEUzM5dzgrcThZRmx2M1RvSjJSdm5JUU5GMTV5Yko5UFdndzlu?=
 =?utf-8?B?U0pyekZCV0xCMHpJR002YVVtOUx1U0pheDFGRmFzcmxFaytGWDRqNUFPc3M2?=
 =?utf-8?B?MEdSYVdVSm1HQ2NXeTRjOCtpYVY0bWhZYmFaYWQyTExhREd4aXB0ZVZra1BN?=
 =?utf-8?B?d0VvblBVSmNRaTVhUW9FbjA2cXZlSHZwUlhzN2RDN2c3RWJFN0lDeUEyd1Yy?=
 =?utf-8?B?M3g0dFRWM2hNdEdXdFVFaGkvU0s0SXdjb0lweTNGaUF0ZTZxdWdxN21jdXdn?=
 =?utf-8?B?WXhqMDNwY3UxSDZ5dXFxRnB1YWhjUUM1YnBjVndIam56TDh6b3VBWVM1WllF?=
 =?utf-8?B?aUsrZHRYUlZJNzU5MXdYS2YzbnJTbGRNaEhVRURZeVJoZFBEVlNZL2JMclR6?=
 =?utf-8?B?ZnBHQktUZDUyaTAzcm9ka3BZYmlmVEozbUNIL3hZdlgvYVRGZmQ3cmhoMVY0?=
 =?utf-8?B?djlMbXovRjQ0UE81ZHBwdFdPMGJvWThZTHprS1lTRCtwVmF5dkZqY3ZNa0d6?=
 =?utf-8?B?Q2FhbWpybitVbzA3L3NLaU03TEM4cUFLSjJXZlNBdHlwbkMvOGI2QW5lVHVS?=
 =?utf-8?B?RVpva3VEdGxQRStsU0phTTJHMnN3ajVhbFN3SzkvT25WblhGV3JZV0NEM1dK?=
 =?utf-8?B?RmMwOVN0WkxPZzZhMTE1M3k4UTRvZWN3bGsycG5IQWRWRk9MZis3QytVWUR4?=
 =?utf-8?B?RGczQWdVOUtIbGpOSzhYMUZBdFVIRHd1RkhGVE1CZEZSV1Y3a1dFbGxTVGpl?=
 =?utf-8?B?WUNNNGtkdFIrYkROQzFRK1BPaFdGa1ZjWm5Ia1dzdXk4blAvMzFOcjhPL0Ri?=
 =?utf-8?B?Mk1wQVVialQxTUowR3lRRTVJVUJDNWF0emZIL2MydlRFR29HY25hNjFYTmtl?=
 =?utf-8?B?a1BvZkF1RUZrWXdOMHlyb3o0NGhJTzZJVTk0WW9xb0M1aVJUMmsvWnBVRFZ4?=
 =?utf-8?B?UFEyT0V3ZVdJeDNiTzg3TWE4cjRCamppWVh6SURQMllNMHVObkxCOG4yelhB?=
 =?utf-8?B?THM0VnlVd2NBOXVVL1licVpZNm1UdkRxZTN3aUxSL3BKQ3pFQm1xMGpyY2J4?=
 =?utf-8?B?aCtPUm54ZlM5aUc5QlNzMGVvak1Zc0RMbWRNa3c1ZnhDWGZ5Q2RyQW05NkJ1?=
 =?utf-8?B?ZGdYUWNMUkU3YjNTWjFUTnBKZjhDd0tSWDV6QXpUSTJPUFNaakFIby9oS0Rj?=
 =?utf-8?B?Z2kzSVk1bDRBRyswWjBOTW1wSUQ5djZFU2g4S0JlcXRha2U3aG40MmlNSGU5?=
 =?utf-8?B?NHlRUHVxUHVxNWJWM0N0NkdiSmJMdjI0UkhpM1ZLSDZJSVRCL29IclJHYUdW?=
 =?utf-8?B?dksrS09FU3d3aFV5S0RCTE1VcUo3Y3hFcXFEbEhFdVBUUllpeDRGZkF4VDU3?=
 =?utf-8?B?UDVuWVR1Nlk5YkVnaWRGdjdUd2JDd0hDK1dSaVRJV1liYlMzc2Vzc1JwUDB5?=
 =?utf-8?B?cElYVXFsbm1uTS9Sc0RHU1dsTE5KRUFlUDlDeFFUOVN6dzZLb1R6dEtNYWd2?=
 =?utf-8?Q?JhNbNgxp0meO1rCPXbe0Fvkbu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9A3DA74B07BEA4ABFB7E6508FE44DA7@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6839.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7f1a21a-7d7c-47be-d952-08dbd0b1b228
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2023 14:43:01.9801 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MU82N97ic67Ae/rMk2cL9uy0OLuOrvS3FqqmkEx2L+2JpR/giclUnI3iyDMK99TZzLfSGI4ev4AgseTuvMqMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8706
X-Mailman-Approved-At: Thu, 19 Oct 2023 16:58:19 +0200
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

DQpIaSwNCg0KT24gVGh1LCAyMDIzLTEwLTE5IGF0IDA4OjMyIC0wNjAwLCBTaW1vbiBHbGFzcyB3
cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IEkgYW0gYWZyYWlkIHdlIHN0aWxsIGhhdmUgYSBib290
IGlzc3VlLiBUaGlzIHRpbWUgZGV2aWNlIGNhbiBub3QgYm9vdCBmcm9tIFVTQi4NCj4gPiA+ID4g
RGV2aWNlIGJvb3Qgb3JkZXIgd2FzIGNoYW5nZWQgdG8gVVNCIGZpcnN0IHRoZW4gdVNELiB1U0Qg
Y2FyZCBpcyByZW1vdmVkLg0KPiA+ID4gPiANCj4gPiA+ID4gUGxlYXNlIHNlZSBbMV0gYXR0YWNo
bWVudCAjODcwMzIxIGZvciBib290IGxvZyBkZXRhaWxzLg0KPiA+ID4gPiANCj4gPiA+ID4gSSBo
YXZlIG5vdCBpbnZlc3RlZCB0aW1lIHRvIGRlYnVnIHRoaXMsIHN0aWxsLg0KPiA+ID4gDQo+ID4g
PiBUaGFua3MgZm9yIHRoZSBpbmZvLiBJcyB0aGlzIHVzaW5nICdib290X3RhcmdldHM9bW1jIHVz
YiBweGUgZGhjcCc/DQo+ID4gPiANCj4gPiANCj4gPiBZZXMuICJib290X3RhcmdldHM9bW1jIHVz
YiBweGUgZGhjcCIuIEZ1bGwgZW52aXJvbm1lbnQgYWRkZWQgdG8gdGhlIGJ1Zy4NCj4gPiANCj4g
PiBodHRwczovL2J1Z3ppbGxhLnN1c2UuY29tL3Nob3dfYnVnLmNnaT9pZD0xMjE2MDM2DQo+IA0K
PiBPSyB0aGFuayB5b3UsIEkgd2lsbCB0YWtlIGEgbG9vay4NCj4gDQo+IEkgd29uZGVyIGlmIHRo
ZXJlIGlzIGEgd2F5IG9mIHRlc3RpbmcgcGVuZGluZyBwYXRjaGVzLCBvciBkbyB0aGV5IG5lZWQN
Cj4gdG8gYmUgYXBwbGllZCBiZWZvcmUgdGhleSBjYW4gYmUgdGVzdGVkIGluIHlvdXIgc3lzdGVt
cz8NCg0KSSBhbSBub3Qgc3VyZSB3aGF0IGRvIHlvdSBtZWFuIGhlcmUuIG9wZW5TVVNFIHVzZXMg
dGhpcyBbMV0gcHJvamVjdA0Kb24gT3BlbiBCdWlsZCBTZXJ2aWNlIHRvIGJ1aWxkIGluc3RhbGxh
YmxlIHBhY2thZ2VzLiBBcyB5b3UgY2FuIHNlZSANCnRoZXJlIGFyZSBmZXcgcGF0Y2hlcyBvbiB0
b3Agb2YgdS1ib290LTIwMjMuMTAgcmVsZWFzZSBpbmNsdWRpbmcgWzJdLg0KDQpXaGF0IEkgY2Fu
IGRvIGlzIHRvIGJ1aWxkIG5ldyBwYWNrYWdlIHdpdGggYW55IHByb3Bvc2VkIHBhdGNoIG9uwqAN
CnRvcCBvZiBsYXN0IHJlbGVhc2UuIE9mIGNvdXJzZSBJIGNhbiBhbHNvIGJ1aWxkIHRoZSBVLUJv
b3QgYW5kIGp1c3TCoA0KY29weSBiaW5hcnkgdG8gdGhlIGJvYXJkLiANCg0KSW4gb3RoZXIgd29y
ZHMgSSBjb3VsZCB0ZXN0IGFueSBwcm9wb3NlZCBwYXRjaCA6LSkNCg0KUmVnYXJkcywNCkl2YW4N
Cg0KWzFdIGh0dHBzOi8vYnVpbGQub3BlbnN1c2Uub3JnL3BhY2thZ2Uvc2hvdy9oYXJkd2FyZTpi
b290L3UtYm9vdA0KWzJdIGJvb3RzdGQ6IFNjYW4gYWxsIGJvb3RkZXZzIGluIGEgYm9vdF90YXJn
ZXRzIGVudHJ5DQo=
