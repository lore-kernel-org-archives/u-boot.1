Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C0DDC43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 07:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C63484A51;
	Thu,  9 Jul 2026 09:16:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Co6T+n84";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C075084AB8; Thu,  9 Jul 2026 09:16:37 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F80E84A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 09:16:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fSfqSpjTTfcVocWaAJHpMz1y7jMjy8/Hn3fax3GtJmUREkl38gzY4S9DVQGImah8ssW2yMG65xBarMKLUXbl4qF1L4ec2hkachu5Sg8EfRpzi66dBiu4XtvP0TPcb20F5P4X3xECulEX+n8lzo/mCmS8Et9eAZonv8SPvgGkGU+UgzdHuOSZV8a98syTb77Cn2HidcZ75FqyjzKFAT8C0Dtw8B1o7wo2Z5KCf0AbXddRvN794vRnn6mfhkWC9ODgm+24pN/UN9e56b9Esgvf+Jp6yfl1Q4+Xu4cOtySik3jStRgGiMBLJ3dChCKbnKuZJ2C2OimbNaLdKrsaajlV7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiDceeqgKeOceHiyEuRz9zYV68+HkIFTYHkkk3gXM9Y=;
 b=fLjnDqp0UIzJMhIH024cczvTLsLVxoaYsfUgvYb4stPaP11qd23FoiZrSrt027SURmxo8zRHQypPZlGc6ATOcug1wFx4oyHx+PbEPNFVp9XKS7Pl/feHI79MQE+q0brLKMcVEA/Fv6JxaNR9HppT2oQmiS4BZjuyrmTpZyYrEMEWS0rv9gekLKfsTCfM4zWcXPBV6WzTp7mYFEjwTbDjFqEkUABnDHTUwEF0fQL2mv4jVG3TxoyC9Mt3wf8tudEORggr4DEDki2H1SrsqTSmcqbybAY21CAWqdI0PdCrIOTFkY1eD8fhxMwv+yl1OTQWFglU1T+OTJdqGawYjUzy2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiDceeqgKeOceHiyEuRz9zYV68+HkIFTYHkkk3gXM9Y=;
 b=Co6T+n84EfBVbAeH0Rq6G7p+SKT5YSW/57VAfQqhCnClFds75+TelFaW3h4qAYOQLIwwE54Ao1E4js4BtignSQrI7k8SLD5Dml7em6303j4hzlrKQ6tWAq3aha+yn/F2pWaqKYRj2zmGMnNvWA35pcoLEDEfy8OR6HrQwwvTr3JXXU3r6a+Hi4B1yi4GvLzUKk5cCmtz3v2lUvdih0cWf9L02fybm+XJ/kEoBn11mFspncRvHAY/SzkLrdyRkcf8wNVscawolJS9bZfZ8ZZ8MDHo9UoDsO3Q08JOsVBle/MYu5Q+5fxDXYrDDc314G0YhaRy5ZbTNvogFBr8kV1Zeg==
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM (2603:10a6:800:22f::14)
 by DB8P195MB0600.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:147::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 07:16:33 +0000
Received: from VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7]) by VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
 ([fe80::1f1b:2a8e:8507:efa7%4]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 07:16:33 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: Marek Vasut <marex@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>, Simon Glass
 <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, Tom Rini
 <trini@konsulko.com>, Ye Li <ye.li@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Topic: [PATCH] arm64: dts: imx8m: Reinstate TEE ifdeffery
Thread-Index: AQHdCKrnZwSzILPPFEWG4EepumfAgrZZ0MsAgAEBKACAAIObAIACfCYAgAKlIoCAAKeQgIADtgAA
Date: Thu, 9 Jul 2026 07:16:32 +0000
Message-ID: <9f59f0c1cd31c7f7fa55243526f472119f899d8a.camel@phytec.de>
References: <20260630160951.122230-1-marex@nabladev.com>
 <0e9071095b0b590c45a139eacb210192e160823f.camel@phytec.de>
 <3200f8b6-6e5e-4275-8442-03ecb6a48597@nabladev.com>
 <5147fb9ef450d4a6963b57dbfdd6ee03eb2ae29a.camel@phytec.de>
 <95b68d7f-e0e6-46b2-af35-8da68c2a9b6a@nabladev.com>
 <8b8468aedb4510d4956ffd548e6e6a8c69cbafe3.camel@phytec.de>
 <6da789b2-de94-4e9a-80dd-3125e8df36ba@nabladev.com>
In-Reply-To: <6da789b2-de94-4e9a-80dd-3125e8df36ba@nabladev.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI2P195MB2491:EE_|DB8P195MB0600:EE_
x-ms-office365-filtering-correlation-id: 6432fdf2-2213-4eef-a550-08dedd8a014e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|38070700021|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
x-microsoft-antispam-message-info: f5HxCQGj9oXFGDq2XvhTCnnlDV8N5NFwLI4+y7T4gaPigUElRZSz9NQCWPYqHrPx1mSwKH/+3Ps6GzXtCfVjhKZ6HnPgePuMc5L+KD9sljhUccnZJHOjKjoTRNzv12+fVPSZauAjNoJegakPEUxaCyaJm3nCI5R8ctL95IOYqgg/qLM3GpBXaht896BNdxhTVEbz4NQwkMSe9qfU9zBloETOCI/pX4qzSamSMYgzt/2al94vq3jVlvFaGXmbjV2s2PuFcmMKDq0IhLOulmrw1yvnpZm1fNDVmU1pE6+9W082raBUifWtm2Ga5N66T++hzDuwZ2btSz7+0nLzaXJOAkURrWoRJ49EkBzHgCugUnM75vtFHBNwEJYVrPJlKKxcVreop83r5zKa4nf3J1CWnG2ZQIZ8emJqQEa26aers8FQjizkeN4C6Xbf7W6gIl8IFMKitjzlFk2V7zO9IWITFdBK/VPhJ9spM7MOTlz6a9dQ2R3SrriS6qBXd49AORI+agAKWR6t5GpBjWh9M9jPPgL9nylBKP3MVzgoCP8MOhQibWTHEGG8NjxfN1BtXQwzDeRJLX3+5E0MqOlQOOk/aCYWlzPvOvTTWN8qQ1LLxbrtJZ0Dl1QgVnEPti36R+szLp2+KfdPQK8Bdr2BK6PbCnHI7LESTigIfxozHWMsYO6PXQq3v7hrUPKVcnn1By47eIDawWT1O/zLTqZfx6lMEMLos7Jfyna4QkA+HkkTqPw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI2P195MB2491.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny8rcFk4aXRvMjZQaW1XcG9HMUtGTzh6WjJsVGJ0dTNyZDVIeGhHTGdod3Rz?=
 =?utf-8?B?U2lNVEMwdER3SEdzNk02b2g0eXdhaVNVSTF6VmptWW1TTWxRZVlEZFFHVWkr?=
 =?utf-8?B?bU1TcUpyM1A1Y0Y0YXc2bFdVbzRIeWVha1NML20vekdtMUVXZzNpR0t5Ykpt?=
 =?utf-8?B?NDJhNkZsYm5ReTNBb1JVRERPQkxuQmg1eE5XQ2NacnhFeVJTVk5FbHhVbmNa?=
 =?utf-8?B?OWlZYXdtOVg4cGlUWHplWDZ3eDNJYitzcU93dGlmaXg0WlRvclMyc3RNcHRp?=
 =?utf-8?B?V0ZSL0hpeUhvK1dqbkNNV1ZKamlsY2JFNGVyR2lzcndMdlZPWG91NUNrYnAv?=
 =?utf-8?B?bFNKNjAzV3M5dU5SeWdnYVF0UHdYbTZtVU9NQW5kdnV6S2phbjljOUY3ZTBx?=
 =?utf-8?B?V3Axc0RiNmtXR25xRnVCV0FnbDRjODB2dzdmUW5YVHQwZFZMNE8wajNDWnFa?=
 =?utf-8?B?SEpSbGFtM2ZaeE12eXc4NFQzTWtSRkdmYzdPRDVVVVFnZ1lUb0RvamxPandF?=
 =?utf-8?B?OW9yelI0NFlWOGdDektsK1M0RUlPQUNsSFNzM3FwVk1MK1hGOWQzUVcvUVlG?=
 =?utf-8?B?YWtGUGxEYkZkTUN0NDJsMU9GekNabUJYMUJEM2R3OEZGdXNFandKVk9YdnBy?=
 =?utf-8?B?VFZqVU45SFpINDdmSXNFTy8yaW4xeUd2R3VyVWEwbVFhS21vSU1PLzlGdmUx?=
 =?utf-8?B?SThZd1FhMm5rYUtVWWd6WnNLRDVpQmx6S1RjTXgrR0dUbGdicS9vYU10UE5o?=
 =?utf-8?B?R0RkUWxSZnN1ZDlsZ092ZDV2ZU5mUTc2U1RmYm56KzlpZWR4STRvMmpNQXJx?=
 =?utf-8?B?WTBtclF4N3A3Y2ovUXNuQklSUC9CZ29FYkRQSDZtU1dIWTlUa0w4RzBrUk9z?=
 =?utf-8?B?ME5OM1RBMmJnN3BiMHFyanVDRnFYSWh5Z3VOaGhWeE5ROUZEeUtyQjlCenkv?=
 =?utf-8?B?cGhaV3dkVXp3YVN2YjZwQXIwWjlwcC9JbkwwWFJQSG56b0paTkNIQTFMY3k5?=
 =?utf-8?B?RGh0ZEw2S3VXZXAxd2pFUWIvZEhIN1dlZklRbG9yZmdRMnNITE5NMVFqSERt?=
 =?utf-8?B?WHVBZFdrRkV0VVpobXN2alVIVGd6NlU1eUFuMlFvVzJUM3VvQzhKNU1ITjhu?=
 =?utf-8?B?cXZhMXp4NGFIWEpHdzg0dTdFK2MzOHFFZnRFajduSHk0Znp6NFZEZlNqbzFJ?=
 =?utf-8?B?RFRFbDVmRjRGcUFQbGg2eDJlNjczdHpyL0JkeWMrbndSdlhUME1ZOVdETitn?=
 =?utf-8?B?MEcvZ1cvQys0WnhjZmNPVU9vRmt6VHNkSVFySmM0dERnWit6bTRmUzRvSWxk?=
 =?utf-8?B?YUZKVGsrS1RIdFRIMlZkWWZOdnMwUFNBNzR4WnhSeWNBMDlZQXh0b2t3Ylc5?=
 =?utf-8?B?NVFWaW9RUGpHaE1URzV6N25BSVp5M0VUajFDL2IwTGVsOVVSSFhXVHFJOUxq?=
 =?utf-8?B?Qnk5eStpS0c4RnNvUllrVGNUdlVsRmtkZnE2WlJEY3VvZThycHk4TmhBRnk5?=
 =?utf-8?B?SmNKbGE2RlNKTllkd1ZlbWQxZU1pZDFDSkZuSTdiT1NLc3JtRmtwRjlUVnU4?=
 =?utf-8?B?djJVazhYd3FieEFMOTZrMDI4cXBrUXFJaVU0Q2FyVGRkckNhOVpNd2RaYVd4?=
 =?utf-8?B?TlZwOXp3TWZEOHpDZnRpaDhUU0Q0eGV3T3dkYlpJNUVTb2luYyt3U2lzcDBm?=
 =?utf-8?B?NjBhakUzWDI1Y3ZWblNoMk1tc2hPWXdETGZPdUNzalBaMWliY2lIRkNoTWxZ?=
 =?utf-8?B?bnRiQU1rNnpZQXJKa0VNK2ZsUFdKckVMMzdSaEVhSHcyTUZuc2JrU3oxTlMr?=
 =?utf-8?B?enhJeUFJZFNNTklMOVp3YVhyRElpdjJxSUlqMkh3cDNGWmtDRFNjaGN4QWlk?=
 =?utf-8?B?RUhITjFxRFFmREhHYlIyMlBiVTlScGI5czJsTDFPdHh2R05DazNMWlpQa1RK?=
 =?utf-8?B?ZGNoVG10Y0hXVCtrUjROWW8zUjhyOUFzK1ZZcDErOXI0Qm03ZmNQZlRIc3pq?=
 =?utf-8?B?TDhQRHdoN0RLOHhpOHZMdXNZVVA0OG9UK1ljZFBwYTBtWFJWT1hRTEwrenhO?=
 =?utf-8?B?b3JTUHQvNWFaYStHTkQ0dHBQdklLSzN4N1lKcmdpOHBaeDlXN2FJUmdYc29z?=
 =?utf-8?B?Vzgzbk5Ba2EzT2tMOEZEVDM4TDUzYkpvOUpCdU05RzlNVnRzL2p5ZUpBR2lo?=
 =?utf-8?B?cUpSMGRHMXc2TkFvUVA3UGNlY1YycVEySjdJN0xzVGVxQkxzbWFmcXB6MzFL?=
 =?utf-8?B?dWZ3cGlBd0lBejVsUVVVb2NYMjZ5S29WclNLclN1dy8vcGxFVU9jSFdQUEdD?=
 =?utf-8?Q?pEVlx3rvfqylgozrNt?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207823C7987CD94A8B11F4BF40A5FF7A@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI2P195MB2491.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6432fdf2-2213-4eef-a550-08dedd8a014e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 07:16:32.8723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAvHKZLZ8GCJ9nPCI7ghuF0xZqdFq5Ia67PbzdxIkIkaCFEt2vcLCBYmGDmZUG23S2BPsqbZx5XYJOplNBjEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P195MB0600
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

T24gVHVlLCAyMDI2LTA3LTA3IGF0IDAwOjM2ICswMjAwLCBNYXJlayBWYXN1dCB3cm90ZToKPiBP
biA3LzYvMjYgMjozNiBQTSwgWWFubmljIE1vb2cgd3JvdGU6Cj4gCj4gSGVsbG8gWWFubmljLAo+
IAo+ID4gPiA+ID4gV2hlbiB5b3UgaW5jbHVkZSBvcHRlZS1vcyBpbiB0aGUgVS1Cb290IGZpdElt
YWdlLCB3aGF0IGRvIHlvdSBkbyB3aXRoCj4gPiA+ID4gPiB0aGF0IG9wdGVlLW9zIHdoaWNoIFUt
Qm9vdCBkb2VzIG5vdCBzdXBwb3J0ID8gRGV0YWlscyBwbGVhc2UgPwo+ID4gPiA+IAo+ID4gPiA+
IFN1cmUsIHNvcnJ5LiBPUyBjYW4vd2lsbCB1c2UgaXQuIFRoZXJlIGlzIG5vIHJlcXVpcmVtZW50
LCB0aGF0IEkga25vdywgb2YgYW55IGJvb3Rsb2FkZXIKPiA+ID4gPiBpbnRlcmZhY2luZyB3aXRo
IE9QLVRFRSBmb3IgcHJvcGVyIGZ1bmN0aW9uYWxpdHkgYW5kIGl0cyBwdXJwb3NlIGlzIHRvIHdv
cmsgd2l0aCBMaW51eAo+ID4gPiA+IGtlcm5lbC4KPiA+ID4gCj4gPiA+IEF0IG1pbmltdW0sIGlm
IENPTkZJR19PUFRFRSBpcyBub3QgZW5hYmxlZCwgVS1Cb290IHdvbid0IGV4ZWN1dGUKPiA+ID4g
b3B0ZWVfY29weV9mZHRfbm9kZXMoKSBhbmQgd29uJ3QgdHJhbnNmZXIgYW55IG9wdGVlLW9zIGZp
cm13YXJlIGFuZAo+ID4gPiByZXNlcnZlZC1tZW1vcnkgRFQgbm9kZXMgdG8gdGhlIExpbnV4IERU
IHdoZW4gc3RhcnRpbmcgdGhlIGtlcm5lbCwgc28KPiA+ID4gTGludXggRFQgd2lsbCBiZSBidWdn
eSBhbmQgTGludXggbWF5IHBvc3NpYmx5IG1pc2JlaGF2ZS4KPiA+IAo+ID4gR290IGl0LiBJIHRl
c3RlZCB5b3VyIHRoZW9yeSBhbmQgd2l0aCBhbGwgVEVFIGNvbmZpZ3Mgb2ZmIGFuZCBPUC1URUUg
cGFja2FnZWQsIGtlcm5lbCBkZXZpY2UKPiA+IHRyZWUKPiA+IHN0aWxsIGhhcyB0aGUgbmVjZXNz
YXJ5IGRldmljZSB0cmVlIG5vZGVzLiBJcyB0aGVyZSBzb21ldGhpbmcgSSBtaXNzZWQgKGFtIHVz
aW5nIHBoeWNvcmUtaW14OG1wCj4gPiBib2FyZCkgPyBIb3cgZG9lcyB5b3VyIExpbnV4IGR0YiBs
b29rIGxpa2UgaW4gdGhhdCBzY2VuYXJpbz8KPiAKPiBJIGNhbm5vdCBhbnN3ZXIgdGhpcyBxdWVz
dGlvbiwgdGhlIHRlc3QgeW91IHBlcmZvcm1lZCBpcyBub3Qgd2VsbCAKPiBkb2N1bWVudGVkIC0t
IGtlcm5lbCB2ZXJzaW9uIGlzIHVua25vd24sIHdoZXRoZXIgdGhlIGtlcm5lbCB3YXMgaW4gYW55
IAo+IHdheSBtb2RpZmllZCBpcyBhbHNvIHVua25vd24sIGV0Yy4gTWF5YmUgeW91ciBrZXJuZWwg
dHJlZSBhbHJlYWR5IAo+IGNvbnRhaW5zIHNvbWUgb3B0ZWUtb3Mgbm9kZSA/Cj4gCj4gPiA+ID4g
SSBndWVzcyB0aGUgb25seSBqb2IgYm9vdGxvYWRlciBuZWVkcyB0byBkbyBpcyBsb2FkIGl0IGlu
dG8gbWVtb3J5LiBJIGRvbid0IGtub3cgZGV0YWlscwo+ID4gPiA+IGFib3V0Cj4gPiA+ID4gc3Bl
Y2lmaWMgdXNlcyB3aXRoaW4gdGhlIHNlY3VyaXR5IGNvbnRleHQgYW5kIGlmIHRoZXJlIGFyZSBh
bnkgdGhhdCByZXF1aXJlIGJvb3Rsb2FkZXIKPiA+ID4gPiBzdXBwb3J0Lgo+ID4gPiAKPiA+ID4g
SWYgaW4geW91ciB1c2UgY2FzZSwgVS1Cb290IGlzIHN1cHBvc2VkIHRvIG9ubHkgbG9hZCBvcHRl
ZS1vcyBpbnRvCj4gPiA+IG1lbW9yeSAsIHdoeSBub3QgbG9hZCBpdCBmcm9tIFUtQm9vdCBjb21t
YW5kIGxpbmUgb3IgYXMgcGFydCBvZiBmaXRJbWFnZQo+ID4gPiB3aGVuIGJvb3RpbmcgTGludXgg
a2VybmVsID8KPiA+IAo+ID4gSSBmaWd1cmVkIHZpYSB0aGUgdS1ib290LmR0c2kgaXMgdGhlIGVh
c2llc3Qgc29sdXRpb24uCj4gPiAKPiA+ID4gCj4gPiA+IEl0IHNlZW1zIGluIHlvdXIgdXNlIGNh
c2UsIG9wdGVlLW9zIGRvZXMgbm90IGhhdmUgdG8gYmUgcGFydCBvZiB0aGUKPiA+ID4gYm9vdGxv
YWRlciBpbWFnZSBhdCBhbGwgPwo+ID4gCj4gPiBJIGJlbGlldmUgaXQgZG9lcy4gVGhlIGluaXQg
cGhhc2UgbG9va3MgdGhlIGZvbGxvd2luZyAob24gaW14OG0pCj4gPiAKPiA+IFJPTSAtPiBVLUJv
b3QgU1BMIC0+IHRmLWEgLT4gT1AtVEVFIC0+IHRmLWEgLT4gVS1ib290IHByb3Blcgo+ID4gCj4g
PiBhbmQgc29tZXRoaW5nIGhhcyB0byBsb2FkIE9QLVRFRSBpbnRvIG1haW4gbWVtb3J5IHdoZW4g
dGYtYSBpcyBkb25lIHdpdGggaW5pdCBhbmQganVtcHMgdG8gdGhlCj4gPiBPUFRFRSBsb2FkIGFk
ZHIuIFRoYXQncyB3aGF0IFUtQm9vdCBkb2VzLgo+IAo+IEluIHRoYXQgY2FzZSwgVS1Cb290IHNo
b3VsZCBiZSBhd2FyZSBvZiB0aGF0IG9wdGVlLW9zICwgaS5lLiBlbmFibGUgCj4gQ09ORklHX09Q
VEVFIC4KPiAKPiBbLi4uXQo+IAo+ID4gPiA+ID4gPiBBbHNvLCBrZWVwaW5nIG9wdGlvbmFsIHdo
ZW4gdXNpbmcgaWYgZGVmcyBpcyBub3QgYSBnb29kIGlkZWEuIEJpbm1hbiB3aWxsIHN0aWxsIGJ1
aWxkCj4gPiA+ID4gPiA+IHlvdQo+ID4gPiA+ID4gPiBhbgo+ID4gPiA+ID4gPiBpbWFnZQo+ID4g
PiA+ID4gPiB3aGVuIG5vIE9QLVRFRSBibG9iIGlzIHByZXNlbnQsIGJ1dCBzaG91bGQgbm90IHNp
bmNlIHlvdSBlbmFibGVkIE9QVEVFIGNvbmZpZ3MuIElmIHlvdQo+ID4gPiA+ID4gPiBlbmFibGUK
PiA+ID4gPiA+ID4gT1BURUUsIHlvdSBzaG91bGQgaGF2ZSBhbiBPUC1URUUgYmxvYiBwYWNrYWdl
ZC4KPiA+ID4gPiA+ID4gV2UgY291bGQgYWRkIGlmbmRlZiBPUFRFRSBhcm91bmQgdGhlIG9wdGlv
bmFsIHByb3BlcnR5Lgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBUaGUgb3B0aW9uYWwga2V5d29yZCBp
cyBhY3R1YWxseSBrZXB0IGluIHRoaXMgY2FzZSwgaXQgaXMgbm90IGEgZnVsbCByZXZlcnQuCj4g
PiA+ID4gPiAKPiA+ID4gPiA+IFlvdSBkaWQgaG93ZXZlciBtaXNzIG9uZSB2aXRhbCBwb2ludCAt
LSB0aGUgdGVlIG5vZGUgaXMgcGFydCBvZiB0aGUKPiA+ID4gPiA+IFUtYm9vdCBmaXRJbWFnZSwg
ZXZlbiBpZiB0aGUgdGVlLmJpbiBiaW5hcnkgaXMgbm90IHByZXNlbnQgYW5kIE9QVEVFCj4gPiA+
ID4gPiBzdXBwb3J0IGluIFUtQm9vdCBpcyBkaXNhYmxlZC4gQmlubWFuIHByaW50cyBhIGNvbmZ1
c2luZyBtZXNzYWdlLCBhbmQKPiA+ID4gPiA+IGdlbmVyYXRlcyBhIGJvZ3VzIGVtcHR5IHRlZSB7
fSBub2RlIGluIHRoZSBmaXRJbWFnZS4gVGhhdCBpcyBpbmNvcnJlY3QuCj4gPiA+ID4gCj4gPiA+
ID4gWWVzLCBmb3Jnb3QgdG8gYWRkcmVzcyB0aGF0LiBJIGRvbid0IHRoaW5rIGl0IGlzIGNvbmZ1
c2luZywgYXQgbGVhc3QgY29udGVudCB3aXNlLgo+ID4gPiA+IFZpc3VhbGx5LCBJCj4gPiA+ID4g
Y2FuCj4gPiA+ID4gc2VlIGhvdyB0aGF0IGlzIGNvbmZ1c2luZy4gSSB3YW50IHRvIG5laXRoZXIg
YWdyZWUgbm9yIGRpc2FncmVlIG9uIHRoZSBjb3JyZWN0bmVzcyBwYXJ0Cj4gPiA+ID4gYmVjYXVz
ZQo+ID4gPiA+IEkKPiA+ID4gPiBkb24ndCByZWFsbHkga25vdyB0aGUgZml0SW1hZ2Ugc3BlYy4g
SGF2aW5nIHRoZSB0ZWUgbm9kZSBiZSBwYXJ0IG9mIHRoZSBmaXRJbWFnZSBpcyBhCj4gPiA+ID4g
ZGVzaWduCj4gPiA+ID4gY2hvaWNlLCBhbGwgb3B0aW9uYWwgYmxvYnMgYmVoYXZlIHRoYXQgd2F5
IGZyb20gbXkgdW5kZXJzdGFuZGluZy4KPiA+ID4gCj4gPiA+IEl0IGlzIGEgYnJva2VuIG5vZGUg
aW50cm9kdWNlZCBieSBjb21taXQgYjU3ZWQxNDc5MzljICgiZHRzOgo+ID4gPiBpbXg4bXttLG4s
cCxxfTogTWFrZSBvcHRlZSBwYWNrYWdpbmcgb3B0aW9uYWwiKSAsIGl0IGlzIG5vdCBzdXBwb3Nl
ZCB0bwo+ID4gPiBiZSBwYXJ0IG9mIHRoZSBmaXRJbWFnZSB1bmxlc3Mgb3B0ZWUtb3MgaXMgYnVu
ZGxlZCBpbnRvIHRoZSBmaXRJbWFnZS4KPiA+IAo+ID4gVGhpcyBJIHN0aWxsIGRvIG5vdCB1bmRl
cnN0YW5kIGhvdyB5b3UgY29tZSB0byB0aGUgY29uY2x1c2lvbiB0aGF0IGl0ICh0ZWUgbm9kZSkg
aXMgbm90Cj4gPiBzdXBwb3NlZCB0bwo+ID4gYmUgcGFydCBvZiB0aGUgZml0SW1hZ2UuIENhbiB5
b3UgcG9pbnQgbWUgdG8gdGhlIGRvYyB0aGF0IGRpc2FsbG93cyB0aGlzPwo+IAo+IFRoZSBlbXB0
eSB0ZWUgbm9kZSBpcyBkZWFkIGNvZGUsIHRoYXQgaXMgd2h5IGl0IHNob3VsZCBub3QgYmUgaW4g
dGhlIAo+IGZpdEltYWdlLiBCZWZvcmUgYjU3ZWQxNDc5MzljICgiZHRzOiBpbXg4bXttLG4scCxx
fTogTWFrZSBvcHRlZSAKPiBwYWNrYWdpbmcgb3B0aW9uYWwiKSB0aGF0IHRlZSBub2RlIHdhcyBj
b3JyZWN0bHkgbm90IHBhcnQgb2YgdGhlIAo+IGZpdEltYWdlIHVubGVzcyBleHBsaWNpdGx5IGNv
bmZpZ3VyZWQgaW4gYnkgdGhlIHVzZXIgKENPTkZJR19PUFRFRT15KS4KPiAKPiA+ID4gPiBJIGd1
ZXNzIGl0IG1lYW5zIHRoYXQgdGhlcmUgaXMgYSBidWcgaW4gYmlubWFuIGlmIHlvdSBzYXkgaGF2
aW5nIGVtcHR5IHRlZSBub2RlIGlzCj4gPiA+ID4gaW5jb3JyZWN0Lgo+ID4gPiA+IEFuZCBzbyBp
dCBzaG91bGQgYmUgZml4ZWQgaW4gYmlubWFuIGl0c2VsZiBpbW8sIG5vdCBoZXJlIGZvciBpbXg4
Lgo+ID4gPiBObywgdGhpcyBpcyBub3QgYSBidWcgaW4gYmlubWFuLCBwbGVhc2Ugc2VlIGFib3Zl
Lgo+ID4gCj4gPiBBbHNvLCBhc3N1bWluZyB0aGF0IGl0IGlzIGluZGVlZCBpbGxlZ2FsOiBCaW5t
YW4gbG9va3MgYXQgYW4gZXh0ZXJuYWwgYmxvYiBhbmQgZG9lcyBub3QgcmVtb3ZlCj4gPiB0aGUK
PiA+IHBhcmVudCBub2RlIHdoZW4gaXQgaXMgdGhlIG9ubHkgY2hpbGQgYW5kIGZvdW5kIHRvIGJl
IG1pc3NpbmcuCj4gPiBDYW4geW91IHBsZWFzZSBjbGFyaWZ5IHdoYXQgc2hvdWxkIGhhcHBlbiB3
aGVuIG5vIHRlZSBibG9iIGNvdWxkIGJlIGZvdW5kIGFuZCBwYWNrYWdlZD8KPiAKPiBJbiBjYXNl
IG9mIENPTkZJR19PUFRFRT15IGFuZCAib3B0aW9uYWwiIGtleXdvcmQgYW5kIG1pc3NpbmcgdGVl
LmJpbiAKPiBibG9iICwgSSB0aGluayB0aGUgbm9kZSBzaG91bGQgYmUgcmV0YWluZWQsIGJlY2F1
c2UgdGhlIHVzZXIgbWlnaHQgCj4gaW5qZWN0IHRlZS5iaW4gaW50byB0aGUgdS1ib290Lml0YiBh
ZnRlciB0aGUgYnVpbGQgd2l0aCBzb21lICJta2ltYWdlIC1GIAo+IC4uLiIgaW52b2NhdGlvbi4K
PiAKPiBJbiBjYXNlIG9mIENPTkZJR19PUFRFRT1uICwgdGhlcmUgc2hvdWxkIGJlIG5vIHRlZSBu
b2RlLgoKSSB0aGluayBJIG5lZWQgbW9yZSB0aW1lIHRvIGRpZ2VzdCB5b3VyIHBvaW50cy4gWW91
IGRpZCBub3QgY29udmluY2UgbWUgdGhhdCB3aGVuIENPTkZJR19PUFRFRT1uCnRoZXJlIHNob3Vs
ZCBub3QgYmUgYW55IHRlZSBub2RlLiBUaGUgcmVzdCBvZiB0aGUgZGlzY3Vzc2lvbiBpcyBiYXNl
ZCBvbiB0aGlzIHBvaW50IHNvIEkgd291bGQgbGlrZQp0byBhdm9pZCBkaXNjdXNzaW5nIHRoaW5n
cyBmdXJ0aGVyIGZvciBub3cuCklmIHdlIGNhbiBnZXQgYW5vdGhlciBvcGluaW9uIG9uIHRoaXMg
ZGlzY3Vzc2lvbiB0aGF0J2QgYmUgZ3JlYXQgSSB0aGluay4gRWl0aGVyIHdheSwgSSBhbSBva2F5
CndpdGggdGFraW5nIHRoaXMgcGF0Y2guIEFnYWluLCBpdCBpcyBteSBvcGluaW9uIHRoYXQgdGhp
cyBpcyBub3QgYSBmaXgsIHJhdGhlciB3ZSBhcmUgbG9zaW5nIGEKZmVhdHVyZS4KCllhbm5pYwoK
PiAKPiA+IEkgYW0gYXNraW5nIGJlY2F1c2UgeW91IHdhbnRlZCB0byBrZWVwIHRoZSBvcHRpb25h
bCBwcm9wZXJ0eSB3aGljaCB3aWxsIGNhdXNlIHVzIHRvIGVuZCB1cCBpbgo+ID4gdGhlCj4gPiBz
YW1lIHNpdHVhdGlvbiB5b3Ugc2FpZCBpcyBpbGxlZ2FsOiBIYXZpbmcgdGhlIHRlZSBub2RlIGlu
IHRoZSBmaXRJbWFnZSBidXQgbm8gdGVlIGJsb2IuCj4gUGxlYXNlIHNlZSBhYm92ZS4K
