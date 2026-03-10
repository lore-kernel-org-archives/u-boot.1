Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB3BEB104C
	for <u-boot@archiver.kernel.org>; Tue, 10 Mar 2026 11:14:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304783F2A;
	Tue, 10 Mar 2026 12:14:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="kWc6T36P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD4C83981; Tue, 10 Mar 2026 12:14:48 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0CEB83981
 for <u-boot@lists.denx.de>; Tue, 10 Mar 2026 12:14:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ludwig.nussel@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bU2LyJnVJvStE3U2MNwQiFfhjThuleGJFmrs00PL7d5JDXNs1lagUI3SVY22ETp9FQh+Xe6jM/zsDiIu9qCMKXqu+OCh5qYLHY07m/0/TgFoPCAQG5Pnl3L8QNuDcva5UfrPRHmVx88ks/SOLrP2nsDacXHyQRj9gg3JewmwzG4GS7PCnKZDVewdc0tTKQrFLJJVIx1FZWp490Y7bR07COvzV9EvnSuFa4LsrtMfvbB/AkqYB4iqTXu6nRFMEoCbAyyFAq+B6iDb1bErmLPdQERmoeqnW0CJtmECn//TGY92v8UeSVDHqxxcmvPvbtq1DCgt0z3aRvhDrMWAsY3oNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2wHeKxjqAiXmFNVuto1lmucI4TdgpYjEq7TLhcLtG4=;
 b=GLL8PUbLhsPCq+WBfxKrdyunM/JGDUYD4LrDI2nxolb97HN/j/8343bbI8WhVSdEOKbm7KFFdPrOlAsNsvDuZ5eGXtc271JsuN5KORBjWzwEFGD6CQP6PAeDlHiIDN1wClxNW1bqrpm2I+OPOOHrsd/7aCl8oOvtcYf9O6t7BwfLKrHtwHztujGxh/ttrxst1epOIMXi1lv4fdMLAt8TnrXC1uacBwRb4vDtZ8u0kqh1fIkI1I1MwJnsOt0NUCkQswlaoL/FhGtPbZuTfwX9+mP4h6xSB3XodXFcoRSR8lranuwGPw/wQhZYXU3C35jDK9HopxKBIWfbxfRmESS8ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2wHeKxjqAiXmFNVuto1lmucI4TdgpYjEq7TLhcLtG4=;
 b=kWc6T36P+B3cWEzN4ZylyseicbXQRcbwgezuihVEmKTndf3NmTam4Ggcjhh9kQTdH4C+fkdG+5VAVybWvdEGQ0OiRmlAzI/BxEshk4ZPsfackbPLubi6vgXwHSnu6HYAnD/dut2cX+DoPb4bK/QX86IixjiU5UO9n7X8ZMLSEM85/SeB5Vc15KRCdHZMdEId6G3djatmRPb6mi2bAITKce/pF3IYglHH23/RCSkQRIw2b9d7ToTX6WmZLfyOWGwVk4QtAuqL6Gs0N9YCZe9EPyW/nS5Qyi+OPWy3w9S5w857cJBUbN0qk1mO9Yau8eQ25kaEvhc01C3iKmtdJc8q+g==
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2cc::12)
 by AS8PR10MB7858.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:631::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Tue, 10 Mar
 2026 11:14:43 +0000
Received: from DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1]) by DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::97ce:ff62:c0b8:4ed1%5]) with mapi id 15.20.9678.024; Tue, 10 Mar 2026
 11:14:43 +0000
From: "Nussel, Ludwig" <ludwig.nussel@siemens.com>
To: "sjg@chromium.org" <sjg@chromium.org>
CC: "daniel@makrotopia.org" <daniel@makrotopia.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>,
 "a.fatoum@pengutronix.de" <a.fatoum@pengutronix.de>,
 "simon.glass@canonical.com" <simon.glass@canonical.com>,
 "eballetbo@kernel.org" <eballetbo@kernel.org>
Subject: Re: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
Thread-Topic: [PATCH v2] boot: Add fit_config_get_hash_list() to build signed
 node list
Thread-Index: AQHcrQf4iKfyPquL1k6tmhf5MF7Y3LWmenOAgAAD94CAASW2gA==
Date: Tue, 10 Mar 2026 11:14:43 +0000
Message-ID: <917d92d314ea4021859befe5fd6e7f3e8036f33e.camel@siemens.com>
References: <20260306012019.800588-1-sjg@chromium.org>
 <34161583f77cb999a04789bf6798d6fbd2c4e234.camel@siemens.com>
 <CAFLszTj_hRfCU6V2O08qOF-8LsOZ_tinxPKVaNKypwwa=2H_sQ@mail.gmail.com>
In-Reply-To: <CAFLszTj_hRfCU6V2O08qOF-8LsOZ_tinxPKVaNKypwwa=2H_sQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5019:EE_|AS8PR10MB7858:EE_
x-ms-office365-filtering-correlation-id: 6c87a5ac-b156-4431-a82d-08de7e963b59
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|7142099003; 
x-microsoft-antispam-message-info: dRL4/1UL2LfEdae/7Ixe+jcKmrI6+opWwAgMgv0R4RX23FDDKEHsWM+wLSaV5Be0r5jOz0L6YO7J34K7Phi8+vlJnDt2p2UoeSm/Tr2H4bRs0lpSL7TnmqfDfhik0OLDg+eRkSzrG7nR58Oix4zlpTk6PAAAZnPw3ixyCfMsVpUvcTnqjFOD6boWdHDotvkF4aP3bdL/TdMRkSJDyYaBNZVKF5IXJ011ebEVPux5afgM+0PKlI6xcc0s0vvF9nB8y2EixNgz3lpgGSc8YximqAry3c871nnvkSPMKj1n/Gdn1WJGoJuCuhgVZYNad9znDY+FKVRblFvibelyQGjLmeh7eECnQVqglV6GTrFsZeXUcJMriR+wJylNCCi9SjhAL1qXtfwws6RU5eZYEhriBasS+EwUUnD64JeGHzEkeBr6iSOHk2J1aW4Vt9AheANrQNFl3KJA5yssGKGWP6sHAgikq1z+JwBFw6G7unB5sIqwHcqObnvQG3spLgqhWE8lCXD6szN5EBby0eCU2mfZ7qEhfWF4l4tVwRsIkgzZkCcApUx6O2OJIzMGPz+Eob8sXo/JGPsJPxmkWLzextlNrb8F3IC+u4fgZGoQALTXth6//x10EM9eQvYEOicptgMo2ya+d/50mssroAxkaU96PJ7Nac4h/iAr96BPuXiihyeCiDjW3EccUmG8U0OskajmneblqkVfx+MIWoPiwRRnhksFd2V3twHddYNExko5RwY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(7142099003); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9HVVZQWjc1QlorRGpSSHZEeEF2NVVCK3ZoaFZXck5UTlgveURWY21OSTVZ?=
 =?utf-8?B?bGR5VUF5Yis3aERuTE5UYkpGTEpxaUcwYjdpNkNMYjlocnlRdGIyZmN0eFdu?=
 =?utf-8?B?Uk5Bdk9oYXFCbW42TjVzaTRraTBwOUNCTWFpOElLckpoSzZ3a2Q1V2ZYR2xv?=
 =?utf-8?B?YmY0R3RGWjdCMFV2WmswMW9CNTFLQm9ucHVUZVM3NDJ6aDRURUd4c00yTzBT?=
 =?utf-8?B?M3hzRHJoOHU0NmxSRWs2cHlML1RsVDdheTBoNXZISXV6MUFBejkwODlVRGVs?=
 =?utf-8?B?VlhhbE1ld003NEEzRUtUMDZMUU50c1NYS1daR0lnNTRuYXZzb0lVL2hFL3Ju?=
 =?utf-8?B?MGN6Q1FSUEtQc3RlUjg2TkloQ29iZ2k2ditZTS9JOFY3d0RJcHpMY3RVUk9R?=
 =?utf-8?B?N25rZm9peDYyUmxEYjh2d1BOZ3cvRGpTcXMyQUpjU3VaR0RON3ZFc1hVS2tN?=
 =?utf-8?B?MERVOUlHWFVDYnhtdDcyZ0FOb0Z0QVN2TmZEZEF0bm9Nc1E4Znk2THRCaWhW?=
 =?utf-8?B?WWtlelY2R212MnlUeEw3QXowWE0xRFJZRERoNDhmL2pMU1MvMXFtQlI2ZEVT?=
 =?utf-8?B?cGsxSWo4U0tSd2w1SmUwakpjbytsNDljTkNBczEyN25OcjhmMHRGbGoyMys1?=
 =?utf-8?B?aWFSVjVSa3kyMFFZZWNxM1J1VnAxcWZDY3RRc3FRVUxLM2RZODdXc2E1djVE?=
 =?utf-8?B?STM2M2liWm1mdUowaHF6V2dVbVVoeS9lSmZnYW8va3B1VTBsY0pnYlBYTDUv?=
 =?utf-8?B?cDlFcU56RW1xak1CZCtYRDBEb2syWkIyYW9wYlMzVnM3c1hGYXVkdGZYQVpO?=
 =?utf-8?B?aVN0cG9nWjZTN3dxaVhETXcxOTFhZW1JV0lhY1UzWC8yckJCdWtlZnR5aHB1?=
 =?utf-8?B?MDBSdFZqVitEbnRrak94dG8vdWRmQlE3OHRJa0xWNkFydEdnZGd3L3BuYzdy?=
 =?utf-8?B?djQ2cTBYRlFiL01vSkpIUVArWVV2NzEzQTNYMjVEL25aZHliM1AyeUxkOEFI?=
 =?utf-8?B?WCtxSytFUDFIQmVxN2Z3WHZYMzVFc25zekNRSzk0a1NSWEZvQnpYUmM3NkUy?=
 =?utf-8?B?UmxtZmxPMzJOTUV1MFlvZFpKUzlJZERaYTAwQXJjdWttTnNUd3BWdHkrRWI1?=
 =?utf-8?B?dmRFc20vL2xCWExUUTg1T000dENHM3g1ZGVXT1VKYjJ4RHpyMVRDS2hvRHhC?=
 =?utf-8?B?U2owZkZLRkJKTy9ZY1F5ZTAvV1AzRzZ6aXJpUnBJNjZKTGtWWVJrUTEreGEy?=
 =?utf-8?B?MWtVdTNCam1TQ28wYk91SDFjeWNtcVBzdHJJLzh6VTYrZm40MmIzZE45TjZJ?=
 =?utf-8?B?eCtRNFR4RzdqZUE0ck5nZ1N2NXp5N2lVbVpaKy9lbkkyUFJFd3BWa1Z3NWRT?=
 =?utf-8?B?SHowbEo1OStvYmM4Q1hRRzhMeXJhRHNrSmM1REY0MmJzU2JidWJ6Z3JER1FV?=
 =?utf-8?B?NklzaVlQMDVBa2dJQkpYTklvS2pmSE9PbHkrU3JPM3pvQ3RQMXM1Y1dqWnU4?=
 =?utf-8?B?bW5lRVM0M1dMTnZkdVFTdXdUTzFwRlpoemNQVVQzR213SmJTL3NRNHAzUEtE?=
 =?utf-8?B?SmFyUk9DZzFsWHdHdldIYnVUVlQrN3ZzRFdhUG9td0Npd1k4aGN6c2FMcHdY?=
 =?utf-8?B?R2U2SUtERUhNa2hFaTJlS2V4WGpkSzVkY3N2b3RkNHdKVGMxbytLdzFtYVhX?=
 =?utf-8?B?VERlWEpUM0ZoVWZ6akhHdDF2N3ZObzZiYVFXVWdsM29NQUg5MVR0TlpnVi9j?=
 =?utf-8?B?elFkV1k1UCtsRytWRjZqclZPYWhnS3lBbStCRTJkdk5sdkl1TzR1MmYveFhW?=
 =?utf-8?B?NzFiN3lBS0dpL3p5Z0RZTERMSVh2b0NBYjJDaDg0Tm1DTnc4TG8wN3Q5MjFI?=
 =?utf-8?B?dm5jOVFOUFpTQ1BTcGVQTE1CREJJSFZDT0U3SGoxMzMxejByMWIxK0g0SG52?=
 =?utf-8?B?WCt3VTlCZDZWVkhIQkQrOC80eFpEanBVVGlZUitUYnEvaEN3UkR2K0pobG9k?=
 =?utf-8?B?dGE1QW1USENwTFpHWU12VmtuTEhkck4wU0ZRRCthUVN5ZVhWZHg3YVMxU0Y0?=
 =?utf-8?B?dDRuUGw2dS9ld0hNVUdBb3YvZDh0MWdtUThOcmNsR2dUWldsK0NUSVA2VnZF?=
 =?utf-8?B?NXIrSElHbjM1QmRwLzFHbGFkbVQ5WUdLSkpVdzNNSmVNWFI4RTNkYXBmSXp6?=
 =?utf-8?B?dFpDQ29CUjBDUzBtSktwQ1hBZXovYkN4Z2lpRldyemc4Um1aYkM0Mi9aRzVl?=
 =?utf-8?B?K0xnb0ppKzBsT2JKWjBBUFdMV1llczJjZVdHcVhqWHlDUXBCYUlWSDVGd25I?=
 =?utf-8?B?SDBnbHlaakVTMmtZSlBMaDVpVU44MFdaeHgrbUJDTmZZUDZWdmt4RE5tNEFW?=
 =?utf-8?Q?3XLsuE4p19I8hZb0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CB2E8B3D55E4E24090D549E19FEC3D42@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5019.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c87a5ac-b156-4431-a82d-08de7e963b59
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 11:14:43.9074 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKYFnvPRgJnIAfOBusJr66HZRT7G1OpdGaZMVz0OVYkthU7eeXGHZhFruSlPH1zU/bk+BFEXcmOGTp8GvAqtx/t5onbrF2SIEILA6cvkjko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7858
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

T24gTW9uLCAyMDI2LTAzLTA5IGF0IDExOjQzIC0wNjAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4g
SGkgTHVkd2lnLA0KPiANCj4gT24gTW9uLCA5IE1hciAyMDI2IGF0IDExOjI5LCBOdXNzZWwsIEx1
ZHdpZyA8bHVkd2lnLm51c3NlbEBzaWVtZW5zLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVGh1
LCAyMDI2LTAzLTA1IGF0IDE4OjIwIC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToNCj4gPiA+IEZy
b206IFNpbW9uIEdsYXNzIDxzaW1vbi5nbGFzc0BjYW5vbmljYWwuY29tPg0KPiA+ID4gDQo+ID4g
PiBUaGUgaGFzaGVkLW5vZGVzIHByb3BlcnR5IGluIGEgRklUIHNpZ25hdHVyZSBub2RlIGxpc3Rz
IHdoaWNoIEZEVCBwYXRocw0KPiA+ID4gYXJlIGluY2x1ZGVkIGluIHRoZSBzaWduYXR1cmUgaGFz
aC4gSXQgaXMgaW50ZW5kZWQgYXMgYSBoaW50IHNvIHNob3VsZA0KPiA+ID4gbm90IGJlIHVzZWQg
Zm9yIHZlcmlmaWNhdGlvbi4NCj4gPiA+IA0KPiA+ID4gQWRkIGEgZnVuY3Rpb24gdG8gYnVpbGQg
dGhlIG5vZGUgbGlzdCBmcm9tIHNjcmF0Y2ggYnkgaXRlcmF0aW5nIHRoZQ0KPiA+ID4gY29uZmln
dXJhdGlvbidzIGltYWdlIHJlZmVyZW5jZXMuIFNraXAgcHJvcGVydGllcyBrbm93biBub3QgdG8g
YmUgaW1hZ2UNCj4gPiA+IHJlZmVyZW5jZXMuIEZvciBlYWNoIGltYWdlLCBjb2xsZWN0IHRoZSBw
YXRoIHBsdXMgYWxsIGhhc2ggYW5kIGNpcGhlcg0KPiA+ID4gc3Vibm9kZXMuDQo+ID4gPiANCj4g
PiA+IFVzZSB0aGUgbmV3IGZ1bmN0aW9uIGluIGZpdF9jb25maWdfY2hlY2tfc2lnKCkgaW5zdGVh
ZCBvZiByZWFkaW5nDQo+ID4gPiAnaGFzaGVkLW5vZGVzJy4NCj4gPiANCj4gPiBXaGlsZSBncm93
aW5nIG1vcmUgZ3JleSBoYWlyIHRyeWluZyB0byB3cmFwIG15IGhlYWQgYXJvdW5kIHRoaXMgSSBm
b3VuZA0KPiA+IGEgbWVhbiB0cmFwLiBta2ltYWdlIHJlYWRzIGEgJ3NpZ24taW1hZ2VzJyBwcm9w
ZXJ0eSB0byBkZXRlcm1pbmUgd2hpY2gNCj4gPiBpbWFnZXMgdG8gaW5jbHVkZSBpbiB0aGUgaGFz
aCByZWdpb25zLiBXaXRob3V0IHRoYXQgcHJvcGVydHkgb25seQ0KPiA+IGtlcm5lbCwgZmR0IGFu
ZCBzY3JpcHQgcHJvcGVydGllcyBhcmUgaW5jbHVkZWQgYXQgaW1hZ2UgZ2VuZXJhdGlvbiB0aW1l
DQo+ID4gKHNlZSBmaXRfY29uZmlnX2dldF9pbWFnZV9saXN0KCkpLg0KPiA+IA0KPiA+IFRoZSBu
ZXcgdmVyaWZpY2F0aW9uIGNvZGUgd29ya3Mgd2l0aG91dCBzdWNoIGEgd2VpcmQgaGFyZGNvZGVk
IGxpc3QuIFNvDQo+ID4gYXMgc29vbiBhcyBhIEZJVCBpbWFnZSBoYXMgZS5nLiBhIHJhbWRpc2sg
YW5kIGl0J3Mgbm90IGxpc3RlZCBpbiAnc2lnbi0NCj4gPiBpbWFnZXMnIHRoZSB2ZXJpZmljYXRp
b24gZmFpbHMuDQo+IA0KPiBZZXMgSSBub3RpY2VkIHRoYXQuLi5JIHdhcyB0aGlua2luZyB3ZSBj
b3VsZCBoYXZlIG1raW1hZ2UgcmVwb3J0IGFuDQo+IGVycm9yLCBidXQgZml0X2NoZWNrX3NpZ24g
ZG9lcyBkbyB0aGlzIGNoZWNrLg0KDQpGb3IgbWUgd2hlbiBJIHRyaWVkIHRoZSBwYXRjaCBpdCB3
YXNuJ3QgY2xlYXIgd2h5IHRoZSBzaWduYXR1cmUgY2hlY2sNCmZhaWxlZCBhdCBmaXJzdC4gSSBh
c3N1bWUgZm9yIGFueW9uZSBub3QgZGVlcCBpbiB0aGUgdG9waWMgaXQncyBqdXN0DQpvdXRyaWdo
dCBmcnVzdHJhdGluZyB3aGVuIHRoZXJlIGFyZSBubyBoZWxwZnVsIGVycm9yIG1lc3NhZ2VzLiBT
byB5ZXMsDQpJIHRoaW5rIGl0IG1ha2VzIHNlbnNlIHRvIGhhdmUgbWtpbWFnZSBkbyBzb21lIGNo
ZWNrcyB0byBtYWtlIHN1cmUNCmZpdF9jaGVja19zaWduIGFjdHVhbGx5IHdvcmtzIDotKQ0KDQo+
IFdoZW4gZGVzaWduaW5nIGFsbCB0aGlzIEkgZmVsdCBpdCB3YXMgbmljZSB0byBoYXZlIGEgc2ln
bi1pbWFnZXMNCj4gcHJvcGVydHkgd2hpY2ggZXhwbGljbHRseSBjb250YWlucyB0aGUgdGhpbmdz
IHRvIHNpZ24sIHNpbmNlIGl0IG1ha2VzDQo+IHlvdSB0aGluayBhYm91dCB3aGF0IHlvdSBhcmUg
ZG9pbmcuIEJ1dCBwZXJoYXBzIHdlIGNvdWxkIGp1c3QgZG8NCj4gd2l0aG91dCBpdD8NCg0KSXMg
dGhlcmUgYSB1c2UgY2FzZSBmb3Igbm90IGluY2x1ZGluZyBpbWFnZXMgaW4gdGhlIHNpZ25hdHVy
ZSB0aGF0IGFyZQ0KcmVmZXJlbmNlZCBmcm9tIGEgY29uZmlnPyBJSVVDIHdpdGggdGhlIGN1cnJl
bnQgcGF0Y2ggaXQgd291bGRuJ3Qgd29yaw0KYW55d2F5IGFzIHNpZ25hdHVyZSB2ZXJpZmljYXRp
b24gZW5mb3JjZXMgaW5jbHVzaW9uIG9mIGFsbCBpbWFnZXMgbm93Lg0KSU1PIGl0IHdvdWxkIG1h
a2Ugc2Vuc2UgdG8gc3RpbGwgcmVhZCAnaGFzaGVkLW5vZGVzJyBpbiB0aGUgY2hlY2sgdG8NCnN0
YXkgY29tcGF0aWJsZSAoaWYgaXQncyBhIHN1YnNldCkgYnV0IGNvbXBsYWluIGxvdWRseSBhbmQg
ZGVjbGFyZSB0aGUNCmZlYXR1cmUgZGVwcmVjYXRlZC4NCg0KY3UNCkx1ZHdpZw0KDQotLSANCkx1
ZHdpZyBOdXNzZWwNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
