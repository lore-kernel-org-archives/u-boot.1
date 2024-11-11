Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B667CD2E9D3
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 10:36:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B2978934F;
	Mon, 11 Nov 2024 11:36:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="sDJ0SBdy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47E4C8936A; Mon, 11 Nov 2024 11:36:25 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56CB48934F
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 11:36:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AtNQNMNNezNrM48UBa65FZAl7ktpqkm23MpqdUdz6BD9vWby4+n/XfbxxxY11YOhSp+S9FDl74tRpfVx3CHjEgMfRqp0C7OYBD5T6Qy6c52JMMKWAPRalP6XuT5oTq9zvZK710WQ6LoZQKaq/Apj9ecRs04hb84UJ2TqDfPlq9/etvZ0Ywes7h5AFA+Z+UPJVD0M8/ffNrPs9sFymwGVyoH7QcP1VbVdKGTJkg8j2P6GvV/+ZmxHGGa597LqhI23pweHcuMZg3qXrN13nh+y5Xat30ZXUDtMkAlUd3F0ug5M9n3yeIemgHMvbR4DIhzNqAipsKEVMuW5b0FI/TybTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9CggMQNL7x9/Qyzi8BE0z/axNzdAlhBUT5Roo570es=;
 b=IJXsBzvoYJ7zcIBZQieJWD9SWWHWz5IBIZScGX+RwPcLC4uAYFE/J9v2MGGQXJCKeJbximfN5ebqnd4TPklBx5oQYF/w8MOBfRtSzzhUG6FMbEpsmwHFcLqkvoqkCwnFQdoycEzIH/BVBtWEabvUVT4zAbBO+8RJdzMPPEaa7FDo5EvdtMCtg/yHlikiubSvkQEnjMpmSm7SpiCW1jGB2h2PIKXQKqBGc1GcHpwz18ffDFYG1ufvP8mtyd0e0F+BK/nt7/A8nr99Kx8k7Fl6O3JWz8ElGs23QqMN4V/sMdOWl5JjMfENZWc4zIhDQwdz8mgGgGtvqNNegn9uR8R2Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9CggMQNL7x9/Qyzi8BE0z/axNzdAlhBUT5Roo570es=;
 b=sDJ0SBdyc2S/bnHZV0m1v6ibabInltQaCxLrkqnYw7ybNa8Ytgt9pe7gY7wRm9p3p3wLXnRWcu/oLhlf3ON5LgyX83CQjapEqBYvugUx/csSXUvcB79GPMGDrzZJHOJ7dHyvSmEY29FEzvlOjcD1wG2IfJu62HqYPwy8mbpYDPw23PMbrgdkyZDkwdxmdj6pX1dLTP1PIqB0qAzIZizngQRqW34B9sgIlvoooFihC8iUjbtNty+5ju0pD0OLqC1/zdXvolYvatuou4pxBroEHBCdg9XFDc4fcXwP+Qquy0j6Kf24whyfJ7p7qg8I9ARKltvEElWhzyTD+UTLLipzkg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DU2PR10MB7787.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:491::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15; Mon, 11 Nov
 2024 10:36:21 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::baa6:3ada:fbe6:98f4%7]) with mapi id 15.20.8158.013; Mon, 11 Nov 2024
 10:36:20 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "hs@denx.de" <hs@denx.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: "agust@denx.de" <agust@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "Schweizer, Walter"
 <walter.schweizer@siemens.com>, "Leto, Enrico" <enrico.leto@siemens.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Topic: [PATCH v1 15/22] siemens: imx8-capricorn.dtsi: small adaptions
Thread-Index: AQHbMZ4q6Xvo8cei1UOJNXJECsAWV7Ku23YAgAK9HACAAE9HgA==
Date: Mon, 11 Nov 2024 10:36:20 +0000
Message-ID: <cf5df90e974abd13e14bd623425fb1fa443b0dcc.camel@siemens.com>
References: <20241108052143.26874-1-hs@denx.de>
 <20241108052143.26874-16-hs@denx.de>
 <CAOMZO5D77WPgrjXXyBzk-rAApcqxfSS7nZCF8usz2jj_oF1QpA@mail.gmail.com>
 <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
In-Reply-To: <4dadf359-8113-08b7-f198-42a2111cef81@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DU2PR10MB7787:EE_
x-ms-office365-filtering-correlation-id: 6497e0c2-d59a-419e-edf8-08dd023cae84
x-ld-processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?SlNteHoxTXc2ayt1Y1dFS0owUTRGUzQwT1pFQkc2dis3UjQyTGhjUDNrYVlJ?=
 =?utf-8?B?QTlZWUdpWHhQR3pYQWZPMUNaY2tqYnljRFZMVjRkcHFHUnVteHYxYStTSHZt?=
 =?utf-8?B?R05TMTN4YmNwa001UXFsTE5ROXByOGpJWHNSUDI2ZDY2OGt5SmhoVWxCSElx?=
 =?utf-8?B?NnF2MXZiRGFhU3dISGx3VjdUNEllYXNvbFdobW0zSUhBWmMzQ2tWL0hmbldX?=
 =?utf-8?B?RCtFTnhvSnJxbFFLcytDcEhkUFc5S0tnTzFZZGpzTFBQSENXa1NPc0llR01W?=
 =?utf-8?B?WDNIbUROUjl5UFMzYldDdzlseHkyRXc3RTdmQWVhaUdIRDRaNy96aHhLSlJv?=
 =?utf-8?B?SFUzU3hRZkVSeXp4UUdOSVEvU05rbUQ2WGlQdFljVFpNcUZuN1U2Tnh4ZlR0?=
 =?utf-8?B?VlJqbU5LTUMzcHZVTWVsbDMrb0RCOWxwTFdlZWpycmJHbWV5bXliSFcvY0ZI?=
 =?utf-8?B?bVRCYVgyOGlsM1UwS2c3RmxRNU92UEU3MW02THAyMjdGNHF2L2FWaXIxYkFH?=
 =?utf-8?B?bVNCcCtNOTFPWWVWNFVhN21vMVhjdEYvNit6MytxamZkTlZuUDhDajgwOXRO?=
 =?utf-8?B?dXB1d1RYV0EyU0pST2MxdXJXai8yZVk1bUtVcUpCMlBSbnNxc2lVRExicFJS?=
 =?utf-8?B?aThRSW9mVklpbTlZczhTUm5ZY0RGTzYwekxvaHRGSENFbkJkVW9UUkV5bW1y?=
 =?utf-8?B?bjJOYWloUG1VbDh2OGNpRS9Ea0dIZ3llYmdQS1JhWVNkdXJjeG5XWmJHL1Bn?=
 =?utf-8?B?OENqY2x5K1NZME53ZkRJbUJ1TTlGRnh6RXVYdVUzajlZUExIb2YrQWwyZXk1?=
 =?utf-8?B?bzlwaDFYU2psSUdTeEE4T3pNKzRzZE42Z2FjTGhpRWx2YXpyR0ZUd0s0NXhm?=
 =?utf-8?B?Y29NUGtDREFpWkRQOFFWMVhnN1d3Q1QyUjRTRVpsVTQza2xEZWtFdm9Kc1E2?=
 =?utf-8?B?b1pLUE10N2lOTG1VMUI3cTdmTmxaYjJTVnlJWndLOFB0T003Wm45MlpEK3lS?=
 =?utf-8?B?Nmc3aW1aNWxnWnZTWGVIbmtVOTZiWlJHa2VhZ01GY244bWw3WHVBNG42S0pY?=
 =?utf-8?B?M0dmYlYyRkdaQTI4dmd6R2JySnN4V3J5SitPSDNZNmdiVGVPdkZIdW1aMGcr?=
 =?utf-8?B?TUZiTGYraXpsQlBaVDY0bWdpWVNlaDNPOGpETHZiK0hpVDFDRVkyeVRnRW11?=
 =?utf-8?B?RDUrODczWkxSS0U1eDRZS0I3R1dFUkFITDJ4TXl3YzN3V084bitEdE1yMGN3?=
 =?utf-8?B?dGh3RmJqNGR3Q3c2Z2xCSlVsU0lTZGJwTzhuNkJJNkg1VUhNRjIzOTVpYzdF?=
 =?utf-8?B?a1dwTEx2dk5jTGYzYVdxRkRvcXMwd1N0TDFId3QwbzdBb1pSWlUrZjZaNVpW?=
 =?utf-8?B?cWFocUtzTktTVHoxb21WNXVhYStWL0o3ayt6RkN1MGU4NHE0ZkZLQnVCQ3U1?=
 =?utf-8?B?U093a2dzSGlCTVFIVnlmbGVLcncvL0dyeVJ1YjRBZlhPNlFIM2RUYTFpb0Vw?=
 =?utf-8?B?dzAxOUhqa0M1aldiMDNpaDFHMFh1RnVJeWRxWE5LOFVVTmp4RXZYdnRxQ2hn?=
 =?utf-8?B?K01IbWp3cGZKY0tHMDZIWEthU2F5WWVrMXpIYUtWNjJxRUkzREJnclJHWnRQ?=
 =?utf-8?B?UlcvdzBKVXNacXNZR0F0OTBPbDdBYi9ocXZSVUtNSEdWZDRZUThwQnVpT1ZC?=
 =?utf-8?B?Tmt3cEVQU1E1V1pZZUhoTnlKbzJOL0ZNSDc1VnUzaXBqR0NXRU9rQmdyQmlz?=
 =?utf-8?Q?mV01RzD8XfsyGhsjLTp6PGYDbH01djOAHEDosNY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enlMVXkzdnVaL0hraHZsUHVFS1JKOWY4UUxaUXRqQkRadlhvdEhKdzZqN0pi?=
 =?utf-8?B?ejUrYUZPTkYwV3Y5bnJKdU9KWVhpRFhjaDMyZlp1WHNZMlFlUDNGREJyRFhX?=
 =?utf-8?B?Vk1QNWUwRkplOW9tM1YrMml5M3czVzJsVlMwNlc5MzFocy8zRzVGQW1FMVNt?=
 =?utf-8?B?Y0RBcVVvZHl6Wlh3WU1YbTNJSU9mK0UyTXV3MFkvcExBNld3MkgzNmpkTDB2?=
 =?utf-8?B?UFlPcDJnV1J4dG96WU1sR1hrMHpXUm94ZGVaZ3VLT1RkdFVZZDFiRi9zSmpp?=
 =?utf-8?B?cytsczEvNkc2bDB5VHhzMU5nS3ZZeWxhSEhSZ21WYTAweHBEemRDbFJ0Yk0x?=
 =?utf-8?B?MSsrSzRCWHF3RmtiYTlianlLNGEvZWNvWUFTQlFzVStkNWZuS1VWdkF4R3g1?=
 =?utf-8?B?Vm1FdjZHc1BhTkozNVdBWHVBdlpEUktIWlI3Vk5mcFFhTElHTVF4OU9PbDYv?=
 =?utf-8?B?SGtpaHNFWFRqdUV3WkIvSE92NDdYWS90N21ZcXlhTFMxdXVidmJsV0w5bURU?=
 =?utf-8?B?Y2xWc255ckxjQm1CUXpKTktpa3llcVpvMkNzVGRsSnY1U1puSGVMUTVyQ3R1?=
 =?utf-8?B?WHdnd1lnZExhcVJTYTVLb1h3VkR6UlJnSDFIYks5YlM5UVArTGNvSmR5WXVM?=
 =?utf-8?B?KzBCRHFSeW5CTjhQOE11RHpUM3pSTjZLT1k1MFZSRm9IdFhLUThiUEpSeDEz?=
 =?utf-8?B?M0NQbUUxcTFzaWVvYmgrUnpIYVpubGtFMW5OZ2R3dGt5RmJFMXJVYTR0UnNl?=
 =?utf-8?B?SUkwUnA4c2ZoWEhGR0NYWDUwbDdnRlRjOENEc2lXMkNsK2w4cExneDZra2xI?=
 =?utf-8?B?QUNVNUNFZ0ZJZGd6cXhlZ1hUcDBrZy8yRmtnbjMzc2VaM2s0MFBHbStlb0dx?=
 =?utf-8?B?VzU4QzFPb21xMjdwUEhKTDkzd1ZDd0IxVkhsMDhDVnRYTlJLSEZTV0xGZTZY?=
 =?utf-8?B?OFJackd4eVpycTNoYmNpK2pxYzhVWXNjVEZ5VGxZaU1pWE5uLzRQOG1BMUNI?=
 =?utf-8?B?Zk4xYXJqNDNqVmhsYUJJTEJnNGhyN0VKVHZtZ2VLZExVN0JOQklEYVUyRDN1?=
 =?utf-8?B?ZmFhdHk4UXpCRzZZVFB3ZmxvVnF1cUEzQzZ6TGJ0UDdkSnNsTUxZTWRXSnRm?=
 =?utf-8?B?QXh4aUY5dVVGdlRqVVFoRm1xbmhZZkNXenNJSG9FaHhmLzFRay9Ways0TE5L?=
 =?utf-8?B?YndTVU9VcHdKSm5uY2JNaVRWVHZUTm1EWC9HR0l5aW9QRnYxc1dtaDNralVr?=
 =?utf-8?B?R0M5YVBqRERSakNmbnBtZDAyVit1dk1PdElYZVhLbGNmTVBMWGUvNTFTR3NQ?=
 =?utf-8?B?a1YxMklBRE83RkNGNUJTUVdhYy9GV2xXQ0dwUEJuV3RiVWtiQzRRdWhsWVhC?=
 =?utf-8?B?dXFXOTV5ZFJMU3RYaS9SNzhoM3FZMWREQ294ZzdpK3FaS0ZrcWNQKzRlSWlW?=
 =?utf-8?B?NnM1QVlCdlgxU1FJcEszVTVDSzIra3ljNVUrZ2Nwc25VcVVFMTJIdTNFZHFG?=
 =?utf-8?B?anRCZlVJTVFKaUVFR3FhemdXbHdQNldMaDJIakNSRWdiUDBURHVqK0kzTjB5?=
 =?utf-8?B?V1pMYUI5THpNVm9CTmxEZ2RxU0F0cTR6YXJvUVIyNmJqZkVjRmNhRkhwUUx4?=
 =?utf-8?B?S2tWbGIwUlVFY2sySFhMU1M0Umk5UnZ4ZWkvSXBuVDNzQ2I0L2d4bEFpS2pp?=
 =?utf-8?B?bUdUenp2V0ZIa05tOVpBb1h6UDhvV2ZIZDJRM0ZlMHdxdngwbjk1SVdWb2tw?=
 =?utf-8?B?SVNrQjZmT0tPdm1DeUFNNDFSL1lWZFRLZFhJUmxQS0g5UHBDbWVERU8zMzZG?=
 =?utf-8?B?bTJpRXdDZTNYMmt1TXk4UG9xWi9CTFo4VWlMcWdsVThGTjgxRVplMUZnS0VK?=
 =?utf-8?B?dzBxZVI0aS9XeGhDYlJubFFiOFpkeHNyK29VQ0dLcjlPN3A3ajRCdmtSc1h5?=
 =?utf-8?B?bVZQTzBodHJNdnNrZzNpVmRUcmU3dDlBTzZ4MitXdGlUVWlNWmhXM3lNeGVi?=
 =?utf-8?B?WnlBMlRONmtZM1FiMW5EaWY0Qm91Wk0rZ0Jrc1ExaS9pMkQ5UHVETDRhYmU5?=
 =?utf-8?B?N2lwSnZUdkRHZ2owVy9KRlNOUXpRVWJvUnhsS04zWUorbW1odlpxYUszak1x?=
 =?utf-8?B?SzFra2kybHVlTUttSGYrQ3l2N3A0UEw4MkgzM3R2dUR6b1hsZnhNcVNOL1RE?=
 =?utf-8?Q?bDQnU/D45KBLCDf9FeKOK+0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85A12EFB9B4EA942808E36C59BB2CC65@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6497e0c2-d59a-419e-edf8-08dd023cae84
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 10:36:20.5570 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VssgchNE2dKkCFaVs/o8D0Pth6oxOnfkLjjEJlliDWaBvz1v0tp5ABQkEvEQ1+yvtGDDF6pInb9IKeSG70r8p2/a/dJzKBtX2tZOzaQ7ZfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7787
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

SGVsbG8gSGVpa28sIEZhYmlvLA0KDQpPbiBNb24sIDIwMjQtMTEtMTEgYXQgMDY6NTIgKzAxMDAs
IEhlaWtvIFNjaG9jaGVyIHdyb3RlOg0KPiA+ID4gwqDCoCBhcmNoL2FybS9kdHMvaW14OC1jYXBy
aWNvcm4uZHRzaSB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPiANCj4gPiBBcmUgdGhlcmUgYW55
IHBsYW5zIHRvIHVwc3RyZWFtIHRoaXMgZHRzaSBhbmQgc3dpdGNoIHRvIE9GX1VQU1RSRUFNPw0K
PiANCj4gSG1tLi4uIGdvb2QgcXVlc3Rpb24hIEN1cnJlbnRseSB3ZSB3b3JrIG9uIFUtQm9vdCB0
byBnZXQgbWFpbmxpbmUgcmVhZHkNCj4gZm9yIHVzZSBpbiBwcm9kdWN0aW9uLCBzbyB3ZSBnZXQg
cmlkIGZyb20gTlhQIGNvZGUuDQo+IA0KPiBJIGRvIG5vdCBrbm93LCBpZiB3ZSBjYW4gcmVhY2gg
dGhpcyB3aXRoIG1haW5saW5lIGxpbnV4IHRvby4uLg0KPiANCj4gTWF5IHRoZSBzaWVtZW5zIGd1
eXMgY2FuIGFuc3dlciB0aGlzLi4uDQoNCnNwZWFraW5nIGFib3V0IHRoZSBjb25jcmV0ZSBmaWxl
LCBvciBTaWVtZW5zIERUcyBpbiBnZW5lcmFsLA0KY3VycmVudGx5IHdlIGRvbid0IGhhdmUgcGxh
bnMgdG8gdXBzdHJlYW0gdGhlbS4gV2UgYXJlIGN1cnJlbnRseSBpbiBmYWN0DQpxdWl0ZSBmYXIg
ZnJvbSBiZWluZyBhYmxlIHRvIGRvIHRoaXMuIEN1cnJlbnRseSBpdCdzIG9ubHkgbWUgd29ya2lu
ZyBpbg0KdGhpcyBkaXJlY3Rpb24sIGJ1dC4uLiBXZSBoYXZlIGFib3V0IDFrIHBhdGNoZXMgaW4g
dG90YWwsIHdoZXJlIHJvdWdobHkNCmEgaGFsZiBvZiB0aGVtIGFyZSBOWFAgQlNQIHBhdGNoZXMu
IEFub3RoZXIgaGFsZiBhcmUgb3VyIGNvbmZpZ3MsIG91cg0KRFRzIGFuZCBvdXIgKGFuZCBERU5Y
IDstKSBmaXhlcyB0bywgc2F5LCBkcml2ZXJzLiBTbyBJIHRyeSBhdCBsZWFzdA0KdG8gcmVkdWNl
IHRoZSBkaWZmIG9uIHRoZSBkcml2ZXJzLCBib3RoIFNpZW1lbnMgYW5kIERFTlggcGF0Y2hlcy4N
Cg0KQnV0IEkgZG9uJ3QgZmVlbCB0aGF0IHdlIHdvdWxkIGJlIGFibGUgdG8gY2xlYW4gdXAgdGhp
cw0KbGVnYWN5IHBsYXRmb3JtIHRvIHRoZSBleHRlbnQgdGhhdCB3ZSBjb3VsZCBlbmFibGUgT0Zf
VVBTVFJFQU0uDQoNCi0tIA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2ll
bWVucy5jb20NCg==
