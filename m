Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9E9F54AB8
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 13:34:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D88D80517;
	Tue, 24 Mar 2026 14:34:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="CRg80yu6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD9AB807C0; Tue, 24 Mar 2026 14:34:16 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FB680212
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 14:34:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEpfG4TDX983o2OzKCIeoAKNh3+wQrR9tZDRtfEj3HQYb6NPhkjpXn0ka4XJ9Ba5guI/uY1ieZ3qxn6qvJ+yFVNkC3cgJgkqfIdoLk8VJjFzgQs1jq12DXsWaxw866cv2NWpvFJfh61Vyfkf0l0rTGhLeuoYVQjROKHpxwjcqoHqRRdspdDrjskjmKppVDYr1DMkrAicgKuAqKQIDjsFL0qlwBIGXlcn4hOM0byfiTceWw40R9KRYcaZIAxK4RD8EYg2PHlFZ2AoFEtKrCu99pABDA0NJIbp0cuIfTTTAW5yYm/KtZqO9oeN7BQe2MQaa8of2mYBL/HgS297S2kCVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7jxmAhkbi+lqXQP2oezx44rvnO7yHrdUXQyul8CzNM=;
 b=YMfU1e5iTS+NvyP052Uel4wtoH08mu+kgwqhKSzh0WsfZhPSKl45GsPmRuHpdYEO9kTJ5LdPSiHw+UYS92PAem0ZKD9GO+eyIRPWRGJK4MLKXZQfphE2JoBM/rRWUw5Lvue5r1zJnUBu2L7hhtbFTnTsxE5t+/EiMOMlk1i1e1WdtExUD6P/4f16nkH6fAU2algaCo1thlggIhfs1QVsIQVv5wgT0z2k6/qktYGYEg9Pdbb6qjAYYFKE2O39BzbBIyQ1gQuQNLsBbNgrxo+IKPtTxKN7qgIrPj5co5PjMRI6es4UA9dWEa6/LRsW/LrFdiHikdyhQxEdPDROzKRQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7jxmAhkbi+lqXQP2oezx44rvnO7yHrdUXQyul8CzNM=;
 b=CRg80yu6uzgmNmN1H7z1qTeoxTRK2DIJGZF76aEEK7ikrby1fCR2ayA6ny9LroPuv53cWXU0a3gAXCNBLM+WSkN2Sl9b6TZt4Vg00QCOyvcoTSSmdMM5fwvXbn5JL5wNc+NsmfTF7sAFVqmBV2C0266RKRXxU5WZIct8HewOvIzh1lOVsZsF8kYu1ylbAREW30tRlvbHQ5ca1ij+aJ4tbduL+PNptQG07vLpIuKPDLFsHGIAW78vKUk08tDsIt5ph+wDMHfIMB5k9Nkixrh5UfD0QFVXs2lDBRzopGFNRnpDze9mtOZpPex4XkBR+pp559kYj9YavCcZmd187nDc0Q==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8100.eurprd04.prod.outlook.com (2603:10a6:20b:3e3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.20; Tue, 24 Mar
 2026 13:34:02 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 13:33:52 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Yannic Moog <Y.Moog@phytec.de>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 dl-uboot-imx <uboot-imx@nxp.com>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>
CC: Teresa Remmet <T.remmet@phytec.de>, Benjamin Hahn <B.Hahn@phytec.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Leonard Anderweit
 <L.Anderweit@phytec.de>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, Manoj Sai
 <abbaraju.manojsai@amarulasolutions.com>, matteo.lisi
 <matteo.lisi@engicam.com>
Subject: RE: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Topic: [PATCH 1/4] imx8mp: phyboard-pollux-rdk: Convert to DM_PMIC
Thread-Index: AQHcu26fu/SKG2qt2keMIyt632OA4bW9odiAgAAMctA=
Date: Tue, 24 Mar 2026 13:33:52 +0000
Message-ID: <PAXPR04MB84596009AB3591BBE0AD49F98848A@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20260324-power-legacy-v1-0-ed432367817c@nxp.com>
 <20260324-power-legacy-v1-1-ed432367817c@nxp.com>
 <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
In-Reply-To: <0c16dfd0d1cedc87bbac071030bbb4d6f04ff4af.camel@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM9PR04MB8100:EE_
x-ms-office365-filtering-correlation-id: ba3b093b-45a5-4c9e-6742-08de89a9fd5d
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|19092799006|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: AOhvfxbhSNJkylMymNoXMIevLSHTpJpi0rsfGdocC9YahwDPunbBsYWQ9ce7Akp7g7KQMjEkj/sDNKSYizrUNK2OdVle/biSs1i0VFuLb5msWwW1b/O34pS9i08gP3Q8slJcz98g3Beu9VIfTrozKeOsxkEvCVUHQle9grqSUpKvS8fBT5hAUBiaf8+bDvxU653UmaxYHZTXxj9fD7NfRr+RlsELPq7npuHo/y1KKN7jAiI86SkgHvpqxjMkv1muh+4/nOlN2fFHOY6XKb5Gc8oMar5HfdZO0sHY+dKfW2IUXpGOEzuZ2LhDm+bwHMvfAmk/t3BFD96vURU6vD+ihbI7/gJ8eAgNerwv4hFUSYZRaqdp5QuJ0bBvWhleOrkdaC2MaeNCVP75kEzVYVve1neAnX6rHcgeSKAxWndArCS8jpOzuiHAHU2rkY9tju0/ihbybqVJW/drZF3eIb3eWEr9ZoC1qRlnvfPnZf3xCUT9ftFAgEFYGpug9PPfR0Py0FFv5yL9z3LEq4Ix5tXREG3DeHIfSG96ERFlw5feMjuDKNezUNcSpgoVMof20DoI4EKkKH8Tc9WOhODTsWWqzwVTzLuSUZQPewcEitoMPWlN7WAmvKYPiBOUnqc+0pczGfknk3z4tPecsRtBaeqJKhE+C0Kd1r+71CCBAsa0EJUXdJHRauwvwQa0KmIgwnu2oONcRC1DFzjJQw4b3RrcsID2cJOtScvqdzbqgUDunPlvVBJP3bVJpE8MqfongczH+ZquTenlDS1fBvgVnG+4OPUBBsz1D9fEpxX6Si2oOM8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(19092799006)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dklOVGZMK2h4WTQreXkwZVd3L1JGanYvRlFsTTVNZXVTSUZ1M3k3YWhvN280?=
 =?utf-8?B?Yy9YTytiSCs2MjJkZndlQTFTSVYzL1FTbGc1ZzEyaUJpazVST09RejNXa1VY?=
 =?utf-8?B?RkZqSUw2L3VhZUNhNUd2blE0L0EyV3k1TTZ0dlBiYjZxenBEVFV5aGd3RUx3?=
 =?utf-8?B?YlZGRmF2U0NTK0VDNUpDY3FpaEpKbVh3QW5SanBHay9hd0lpRTRyUVBHMU5P?=
 =?utf-8?B?U0JnWkRjazBPL28vMlpSOHJXQ3o0dVlqYkNsNk1iNDY3WHg3TDZSUHhqck5I?=
 =?utf-8?B?MWtkN1ZRZFVHR1QweGVtSlZzdmI5cjNtMnUwbFBrK1BMRWx1WFhiSjdaMWRn?=
 =?utf-8?B?cmxBK1A5bXU3akJXK3FLa1N0UHp1REFDeHdzUEVENERMbjZwNWpNUG9ZaDcy?=
 =?utf-8?B?bDdHaUtTQXFld3VsNnltQ282ak5TRzNGeFZNOVoyYTJwZHRWQVJldm54cEpM?=
 =?utf-8?B?b2V4SGcwU2M1VWtOYXRUMEl1MHpyR2RlanRpcmpJN1AxQThSUzhhcDNDT3pP?=
 =?utf-8?B?RkU0MDRReUh2N0tIMXhrNEdZWFJOR3RiSmF1d2ppNUVyNE1zREkwVU42alRK?=
 =?utf-8?B?blJHUk9pbmNsYWR2UWlTTDNUS3NZMWZ5dXRsS3VncTExOEo3ZjMrU0pTY2xZ?=
 =?utf-8?B?NG5UTGQxd1hPUDlibVNNNlhpVzZhRUxnOWVHenpjN2Q3NHVUZVRqVGFrdjNB?=
 =?utf-8?B?SkgrSm4zRE8rTUhtODE5WThSOE01WmFBWVlOaUFDdUxpS1BuVllMenlpME4r?=
 =?utf-8?B?RzVPNlNkcytoWXpaN3ZpMkFtQi96RnhxVHNJYVJsbXZ2Qlh6b2pUbVJ5aHRT?=
 =?utf-8?B?WEVMTTd3SS9Cd2hWdXAvQnJ2UFNuOFN6MFl5YnNTZW9GZTZsNDRKb1FNWG5T?=
 =?utf-8?B?enFOWThWbzhibzU0QzQyZVl5N1VoQzRlZWJoQUFhOWgyODYralAvdld5V1dI?=
 =?utf-8?B?THBVcU9mRUdsZGF3bFczRFN3Skk3NkVuRENOdW16aHlUaEJUOC9BZ1NyMEVQ?=
 =?utf-8?B?TGlEVU5pTFFNdlpjcDJyZkNsK0xDeW5LVXo5ZHpDb09tVHBuUFpES0ZObmNZ?=
 =?utf-8?B?blVaQjdZMXpFVS9EYlhKVUliZm1vNkVZOFVGN1lkVnhQOXp3NE85eGNSb3g0?=
 =?utf-8?B?K0FKUlhnMCs1cVJVRENpVThMK2lMS214ZTlBVUVrVElGN3ZrNUIwRnMzcDBm?=
 =?utf-8?B?eHVpckUvOXJVWERZOFlGT0tVTkg3U3R3VUZsZ1pIN3FzdmxDa0dxczE1SEZD?=
 =?utf-8?B?MUtTZnRqdmd1T2FBenJlbEFIenhDRU5MRkwreEtRMHdWNEZieHNHeTl0MGtt?=
 =?utf-8?B?U0NIeDYyQUZacEg2NDg2MjZPV05XNkNFWEpiSzdjWG1CeXA1dEVzV255dWFs?=
 =?utf-8?B?RW9Eb2pQSzJuT1h2TGRLeS9DaVAxdTlib0dzaXl6ZWNDM09DZkM4RDI5Vlk1?=
 =?utf-8?B?NjhjN3hhOHlzVnpjUDBPL0NvOG9veEpoVDJDdGJnSFRaNUF1NzIwRDhhRWFp?=
 =?utf-8?B?NGVoVVhxZEloa09tNUQ2SlplUGxydmFaVVl0WDY0SG10TmlkZmRNaXFGaGV2?=
 =?utf-8?B?d09zQm0ydkVqU0xZZ2xIWE1mY05Ed0t3bUpQUUNrUzBSdWpjVDVWWitpSDIv?=
 =?utf-8?B?NEg3WmVRcGVWM2R0NktPUWhWZVlZUjNKbWN2dklrb09YUktrakNkNnpDeU1y?=
 =?utf-8?B?eHVPaTVseVZqQWpYdGlQZVJSMTFQc05uT2RueGowc3B5cWpOVWJXNUFmNjdO?=
 =?utf-8?B?ZnR0SzVDWnBsQmc3OUF4eVQxaVlNQmpML3dIeWYvTHhvblJnQ0NIUGpJYWRm?=
 =?utf-8?B?K3BXVTMrc0d4dUw3Vm1kMXJ5Q215RXREOWRZY3NGVUtZR2plY3NhdEZzeVd3?=
 =?utf-8?B?UVFpakJNZ1RTYzNQdXlmMmMwUFgwaUVNQmViSFNpVXpIY2VuWWEwaFlvQ28z?=
 =?utf-8?B?dlgxbk9MNW14d1VHdEEvanBTR0dTSGdqOWNXUWFma1hsaW5JOFdGTlYxaExx?=
 =?utf-8?B?MjVSRjRsaWNTejg5Q1NjMFJ2bFdWbmpnTFBja2VweUwxUXNRc2FydFFkWkZ4?=
 =?utf-8?B?cktZOGc4SUFScVNjVVdGeHpWM3VrZVJyZElzc0xjYTQvNnhlY1Y1Q2J6bDFZ?=
 =?utf-8?B?QWhuU2F3bGVuNXhLcmJ1WmpMZGJWRUVhOXVqYzNKNkZiRFZ0OENDeklpb1Rq?=
 =?utf-8?B?ZzFsNlo4R1lWNnRjVC93WURxT2Z4bEtNNTZnZERBdCtMQmZhQWhjUXg0MlU3?=
 =?utf-8?B?RFA4dER3WFQxZDhuUmxONjg4cGZyOFJUcExmUkQ2c0g1c3B6bGFFbUl1elYz?=
 =?utf-8?Q?bp3DEncTkj9g3pNQ8K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3b093b-45a5-4c9e-6742-08de89a9fd5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2026 13:33:52.6078 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4GTtihw04pCTOLOyuZ4GxPKmwo+aO/sPH6Qk/J9xHNDSQKW9YGOMD397H0XT6XnUbxniniPl5okJr9jK8XXPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8100
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

SGkgWWFubmljLA0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBpbXg4bXA6IHBoeWJvYXJk
LXBvbGx1eC1yZGs6IENvbnZlcnQgdG8NCj4gRE1fUE1JQw0KPiANCj4gSGkgUGVuZywNCj4gDQo+
IE9uIFR1ZSwgMjAyNi0wMy0yNCBhdCAxODozMCArMDgwMCwgUGVuZyBGYW4gKE9TUykgd3JvdGU6
DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBDb252ZXJ0
IHRoZSBib2FyZCB0byB1c2UgRE1fUE1JQyBpbnN0ZWFkIG9mIHRoZSBsZWdhY3kgU1BMDQo+IEky
Qy9QTUlDDQo+ID4gaGFuZGxpbmcuDQo+ID4NCj4gPiBDaGFuZ2VzIGluY2x1ZGU6DQo+ID4gLSBF
bmFibGUgRE1fUE1JQywgRE1fUE1JQ19QQ0E5NDUwLCBhbmQNCj4gU1BMX0RNX1BNSUNfUENBOTQ1
MCBpbiBkZWZjb25maWcuDQo+ID4gLSBEcm9wIGxlZ2FjeSBTUEwgSTJDIGFuZCBQTUlDIG9wdGlv
bnMuDQo+ID4gLSBSZW1vdmUgbWFudWFsIEkyQzEgcGFkIHNldHVwIGFuZCBsZWdhY3kgcG93ZXJf
cGNhOTQ1MF9pbml0KCkNCj4gdXNhZ2UuDQo+ID4gLSBVc2UgRE0tYmFzZWQgcG1pY19nZXQoKSB3
aXRoIHRoZSBEVCBub2RlICJwbWljQDI1Ii4NCj4gPiAtIFVwZGF0ZSBQTUlDIHJlZ2lzdGVyIHBy
b2dyYW1taW5nIHRvIHVzZSBzdHJ1Y3QgdWRldmljZSBBUEkuDQo+IA0KPiB0aGVzZSBjaGFuZ2Vz
IGJyZWFrIHNvbWV0aGluZy4NCj4gDQo+IEdldHRpbmcNCj4gDQo+IExvYWRpbmcgRW52aXJvbm1l
bnQgZnJvbSBNTUMuLi4gQ2FyZCBkaWQgbm90IHJlc3BvbmQgdG8gdm9sdGFnZQ0KPiBzZWxlY3Qh
IDogLTExMA0KPiAqKiogV2FybmluZyAtIE5vIGJsb2NrIGRldmljZSwgdXNpbmcgZGVmYXVsdCBl
bnZpcm9ubWVudA0KPiANCj4gYW5kIFNEIGNhcmQgaXMgbm90IGFjY2Vzc2libGUgYXMgYSByZXN1
bHQuIEkgYWxzbyB3b3JrZWQgb24gdGhpcw0KPiBtb2Rlcm5pemF0aW9uIGFuZCBnb3QgdGhlIHNh
bWUgcmVzdWx0IGFzIHdpdGggeW91ciBjb21taXQuIEhhdmUgbm90DQo+IGhhZCB0aW1lIHRvIGlu
dmVzdGlnYXRlIHRoZSBjYXVzZSwgeWV0Lg0KDQpUaGlzIGNoYW5nZSBzaG91bGQgbm90IGltcGFj
dCBzZCwgdW5sZXNzIHBtaWMgbm90IHByb2JlIGNvcnJlY3RseS4NCllvdSBtYXkgZ2l2ZSBhIGxv
b2sgb24gInJlZ3VsYXRvcnMiLCAicG1pYyIgaW4gVS1Cb290IHNoZWxsLA0KdG8gc2VlIHdoZXRo
ZXIgcG1pYyBpcyBnb29kLg0KDQpBbmQgeW91IG1heSBhbHNvIG5lZWQgdG8gY29uZmlybSwgd2hl
dGhlciBTRCB3b3JrcyBvciBub3QNCndpdGhvdXQgdGhpcyBtaWdyYXRpb24gdG8gRE1fUE1JQy4N
Cg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gWWFubmljDQo+IA0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gwqAuLi4vYXJt
L2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaSB8IDE2ICsrKysrKyst
DQo+ID4gwqBib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmPCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHwgNDMNCj4gPiArKysrKysrLS0tLS0tLS0tLS0tLS0tDQo+ID4g
wqBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8IDEwICsrLS0tDQo+ID4gwqAzIGZpbGVzIGNoYW5nZWQsIDMyIGluc2Vy
dGlvbnMoKyksIDM3IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L2R0cy9pbXg4bXAtcGh5Ym9hcmQtcG9sbHV4LXJkay11LWJvb3QuZHRzaQ0KPiA+IGIvYXJjaC9h
cm0vZHRzL2lteDhtcC1waHlib2FyZC0gcG9sbHV4LXJkay11LWJvb3QuZHRzaSBpbmRleA0KPiA+
IDQ4MDRhMjA0ZTkyLi44NzFlN2ZkNjc0ZCAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2FybS9kdHMv
aW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstdS1ib290LmR0c2kNCj4gPiArKysgYi9hcmNoL2Fy
bS9kdHMvaW14OG1wLXBoeWJvYXJkLXBvbGx1eC1yZGstdS1ib290LmR0c2kNCj4gPiBAQCAtMzQs
NiArMzQsMTggQEANCj4gPiDCoAl9Ow0KPiA+IMKgfTsNCj4gPg0KPiA+ICsmcGluY3RybF9pMmMx
IHsNCj4gPiArCWJvb3RwaC1hbGw7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmcGluY3RybF9wbWlj
IHsNCj4gPiArCWJvb3RwaC1hbGw7DQo+ID4gK307DQo+ID4gKw0KPiA+ICsmey9zb2NAMC9idXNA
MzA4MDAwMDAvaTJjQDMwYTIwMDAwL3BtaWNAMjUvcmVndWxhdG9yc30gew0KPiA+ICsJYm9vdHBo
LWFsbDsNCj4gPiArfTsNCj4gPiArDQo+ID4gwqAmcmVnX3VzZGhjMl92bW1jIHsNCj4gPiDCoAli
b290cGgtcHJlLXJhbTsNCj4gPiDCoH07DQo+ID4gQEAgLTgzLDExICs5NSwxMSBAQA0KPiA+IMKg
fTsNCj4gPg0KPiA+IMKgJmkyYzEgew0KPiA+IC0JYm9vdHBoLXByZS1yYW07DQo+ID4gKwlib290
cGgtYWxsOw0KPiA+IMKgfTsNCj4gPg0KPiA+IMKgJnBtaWMgew0KPiA+IC0JYm9vdHBoLXByZS1y
YW07DQo+ID4gKwlib290cGgtYWxsOw0KPiA+IMKgfTsNCj4gPg0KPiA+IMKgJnVzYl9kd2MzXzAg
ew0KPiA+IGRpZmYgLS1naXQgYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMNCj4g
PiBiL2JvYXJkL3BoeXRlYy9waHljb3JlX2lteDhtcC9zcGwuYw0KPiA+IGluZGV4IGZjN2FlZmQw
MDczLi5mYzZmNTEwNDkyNSAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9waHl0ZWMvcGh5Y29yZV9p
bXg4bXAvc3BsLmMNCj4gPiArKysgYi9ib2FyZC9waHl0ZWMvcGh5Y29yZV9pbXg4bXAvc3BsLmMN
Cj4gPiBAQCAtMTE3LDQ1ICsxMTcsMzIgQEAgb3V0Og0KPiA+IMKgCWRkcl9pbml0KCZkcmFtX3Rp
bWluZyk7DQo+ID4gwqB9DQo+ID4NCj4gPiAtI2RlZmluZSBJMkNfUEFEX0NUUkwgKFBBRF9DVExf
RFNFNiB8IFBBRF9DVExfSFlTIHwNCj4gUEFEX0NUTF9QVUUgfA0KPiA+IFBBRF9DVExfUEUpIC0j
ZGVmaW5lIFBDIE1VWF9QQURfQ1RSTChJMkNfUEFEX0NUUkwpIC1zdHJ1Y3QNCj4gPiBpMmNfcGFk
c19pbmZvIGkyY19wYWRfaW5mbzEgPSB7DQo+ID4gLQkuc2NsID0gew0KPiA+IC0JCS5pMmNfbW9k
ZSA9IE1YOE1QX1BBRF9JMkMxX1NDTF9fSTJDMV9TQ0wgfCBQQywNCj4gPiAtCQkuZ3Bpb19tb2Rl
ID0gTVg4TVBfUEFEX0kyQzFfU0NMX19HUElPNV9JTzE0IHwNCj4gUEMsDQo+ID4gLQkJLmdwID0g
SU1YX0dQSU9fTlIoNSwgMTQpLA0KPiA+IC0JfSwNCj4gPiAtCS5zZGEgPSB7DQo+ID4gLQkJLmky
Y19tb2RlID0gTVg4TVBfUEFEX0kyQzFfU0RBX19JMkMxX1NEQSB8IFBDLA0KPiA+IC0JCS5ncGlv
X21vZGUgPSBNWDhNUF9QQURfSTJDMV9TREFfX0dQSU81X0lPMTUNCj4gfCBQQywNCj4gPiAtCQku
Z3AgPSBJTVhfR1BJT19OUig1LCAxNSksDQo+ID4gLQl9LA0KPiA+IC19Ow0KPiA+IC0NCj4gPiDC
oGludCBwb3dlcl9pbml0X2JvYXJkKHZvaWQpDQo+ID4gwqB7DQo+ID4gLQlzdHJ1Y3QgcG1pYyAq
cDsNCj4gPiArCXN0cnVjdCB1ZGV2aWNlICpkZXY7DQo+ID4gwqAJaW50IHJldDsNCj4gPg0KPiA+
IC0JcmV0ID0gcG93ZXJfcGNhOTQ1MF9pbml0KDAsIDB4MjUpOw0KPiA+IC0JaWYgKHJldCkNCj4g
PiAtCQlwcmludGYoInBvd2VyIGluaXQgZmFpbGVkIik7DQo+ID4gLQlwID0gcG1pY19nZXQoIlBD
QTk0NTAiKTsNCj4gPiAtCXBtaWNfcHJvYmUocCk7DQo+ID4gKwlyZXQgPSBwbWljX2dldCgicG1p
Y0AyNSIsICZkZXYpOw0KPiA+ICsJaWYgKHJldCA9PSAtRU5PREVWKSB7DQo+ID4gKwkJcHV0cygi
Tm8gcG1pY0AyNVxuIik7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+ID4gKwlpZiAocmV0
IDwgMCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+DQo+ID4gwqAJLyogQlVDS3hPVVRfRFZTMC8x
IGNvbnRyb2wgQlVDSzEyMyBvdXRwdXQgKi8NCj4gPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBDQTk0
NTBfQlVDSzEyM19EVlMsIDB4MjkpOw0KPiA+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5NDUw
X0JVQ0sxMjNfRFZTLCAweDI5KTsNCj4gPg0KPiA+IMKgCS8qIEluY3JlYXNlIFZERF9TT0MgYW5k
IFZERF9BUk0gdG8gT0Qgdm9sdGFnZSAwLjk1ViAqLw0KPiA+IC0JcG1pY19yZWdfd3JpdGUocCwg
UENBOTQ1MF9CVUNLMU9VVF9EVlMwLCAweDFDKTsNCj4gPiAtCXBtaWNfcmVnX3dyaXRlKHAsIFBD
QTk0NTBfQlVDSzJPVVRfRFZTMCwgMHgxQyk7DQo+ID4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBD
QTk0NTBfQlVDSzFPVVRfRFZTMCwgMHgxQyk7DQo+ID4gKwlwbWljX3JlZ193cml0ZShkZXYsIFBD
QTk0NTBfQlVDSzJPVVRfRFZTMCwgMHgxQyk7DQo+ID4NCj4gPiDCoAkvKiBTZXQgQlVDSzEgRFZT
MSB0byBzdXNwZW5kIGNvbnRyb2xsZWQgdGhyb3VnaA0KPiBQTUlDX1NUQllfUkVRICovDQo+ID4g
LQlwbWljX3JlZ193cml0ZShwLCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzEsIDB4MTQpOw0KPiA+IC0J
cG1pY19yZWdfd3JpdGUocCwgUENBOTQ1MF9CVUNLMUNUUkwsIDB4NTkpOw0KPiA+ICsJcG1pY19y
ZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0sxT1VUX0RWUzEsIDB4MTQpOw0KPiA+ICsJcG1pY19y
ZWdfd3JpdGUoZGV2LCBQQ0E5NDUwX0JVQ0sxQ1RSTCwgMHg1OSk7DQo+ID4NCj4gPiDCoAkvKiBT
ZXQgV0RPR19CX0NGRyB0byBjb2xkIHJlc2V0ICovDQo+ID4gLQlwbWljX3JlZ193cml0ZShwLCBQ
Q0E5NDUwX1JFU0VUX0NUUkwsIDB4QTEpOw0KPiA+ICsJcG1pY19yZWdfd3JpdGUoZGV2LCBQQ0E5
NDUwX1JFU0VUX0NUUkwsIDB4QTEpOw0KPiA+DQo+ID4gwqAJcmV0dXJuIDA7DQo+ID4gwqB9DQo+
ID4gQEAgLTE5Myw4ICsxODAsNiBAQCB2b2lkIGJvYXJkX2luaXRfZih1bG9uZyBkdW1teSkNCj4g
Pg0KPiA+IMKgCWVuYWJsZV90emMzODAoKTsNCj4gPg0KPiA+IC0Jc2V0dXBfaTJjKDAsIENPTkZJ
R19TWVNfSTJDX1NQRUVELCAweDdmLCAmaTJjX3BhZF9pbmZvMSk7DQo+ID4gLQ0KPiA+IMKgCXBv
d2VyX2luaXRfYm9hcmQoKTsNCj4gPg0KPiA+IMKgCS8qIEREUiBpbml0aWFsaXphdGlvbiAqLw0K
PiA+IGRpZmYgLS1naXQgYS9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiA+IGIv
Y29uZmlncy9waHljb3JlLWlteDhtcF9kZWZjb25maWcNCj4gPiBpbmRleCAyZmNmN2RiOWU1Yy4u
NTFkOTczN2FmYjMgMTAwNjQ0DQo+ID4gLS0tIGEvY29uZmlncy9waHljb3JlLWlteDhtcF9kZWZj
b25maWcNCj4gPiArKysgYi9jb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZw0KPiA+IEBA
IC0xMCw3ICsxMCw2IEBAIENPTkZJR19TRl9ERUZBVUxUX1NQRUVEPTgwMDAwMDAwDQo+ID4gwqBD
T05GSUdfRU5WX1NJWkU9MHgxMDAwMA0KPiA+IMKgQ09ORklHX0VOVl9PRkZTRVQ9MHgzQzAwMDAN
Cj4gPiDCoENPTkZJR19FTlZfU0VDVF9TSVpFPTB4MTAwMDANCj4gPiAtQ09ORklHX1NZU19JMkNf
TVhDX0kyQzE9eQ0KPiA+IMKgQ09ORklHX0RNX0dQSU89eQ0KPiA+IMKgQ09ORklHX0RFRkFVTFRf
REVWSUNFX1RSRUU9ImZyZWVzY2FsZS9pbXg4bXAtcGh5Ym9hcmQtDQo+IHBvbGx1eC1yZGsiDQo+
ID4gwqBDT05GSUdfSU1YOE1fT1BURUVfTE9BRF9BRERSPTB4N2UwMDAwMDANCj4gPiBAQCAtMTEz
LDggKzExMiw2IEBADQo+IENPTkZJR19GQVNUQk9PVF9NTUNfVVNFUl9TVVBQT1JUPXkNCj4gPiDC
oENPTkZJR19GQVNUQk9PVF9NTUNfVVNFUl9OQU1FPSJtbWMyIg0KPiA+IMKgQ09ORklHX01YQ19H
UElPPXkNCj4gPiDCoENPTkZJR19ETV9JMkM9eQ0KPiA+IC0jIENPTkZJR19TUExfRE1fSTJDIGlz
IG5vdCBzZXQNCj4gPiAtQ09ORklHX1NQTF9TWVNfSTJDX0xFR0FDWT15DQo+ID4gwqBDT05GSUdf
STJDX0VFUFJPTT15DQo+ID4gwqBDT05GSUdfU1lTX0kyQ19FRVBST01fQUREUj0weDUxDQo+ID4g
wqBDT05GSUdfU1VQUE9SVF9FTU1DX0JPT1Q9eQ0KPiA+IEBAIC0xNDQsMTUgKzE0MSwxNiBAQCBD
T05GSUdfUEhZX0lNWDhNUV9VU0I9eQ0KPiA+IMKgQ09ORklHX1BJTkNUUkw9eQ0KPiA+IMKgQ09O
RklHX1NQTF9QSU5DVFJMPXkNCj4gPiDCoENPTkZJR19QSU5DVFJMX0lNWDhNPXkNCj4gPiAtQ09O
RklHX1NQTF9QT1dFUl9MRUdBQ1k9eQ0KPiA+IMKgQ09ORklHX1BPV0VSX0RPTUFJTj15DQo+ID4g
wqBDT05GSUdfSU1YOE1fUE9XRVJfRE9NQUlOPXkNCj4gPiDCoENPTkZJR19JTVg4TVBfSFNJT01J
WF9CTEtDVFJMPXkNCj4gPiAtQ09ORklHX1BPV0VSX1BDQTk0NTA9eQ0KPiA+ICtDT05GSUdfRE1f
UE1JQz15DQo+ID4gK0NPTkZJR19ETV9QTUlDX1BDQTk0NTA9eQ0KPiA+ICtDT05GSUdfU1BMX0RN
X1BNSUNfUENBOTQ1MD15DQo+ID4gwqBDT05GSUdfRE1fUkVHVUxBVE9SPXkNCj4gPiArQ09ORklH
X0RNX1JFR1VMQVRPUl9QQ0E5NDUwPXkNCj4gPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfRklYRUQ9
eQ0KPiA+IMKgQ09ORklHX0RNX1JFR1VMQVRPUl9HUElPPXkNCj4gPiAtQ09ORklHX1NQTF9QT1dF
Ul9JMkM9eQ0KPiA+IMKgQ09ORklHX0RNX1JORz15DQo+ID4gwqBDT05GSUdfRE1fU0VSSUFMPXkN
Cj4gPiDCoENPTkZJR19NWENfVUFSVD15DQo=
