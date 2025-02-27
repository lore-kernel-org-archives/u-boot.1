Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 808CFC021B8
	for <u-boot@archiver.kernel.org>; Thu, 27 Feb 2025 00:30:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E26F480F56;
	Thu, 27 Feb 2025 01:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="kx6D/88C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3BB881026; Thu, 27 Feb 2025 01:30:17 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::606])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EC8808A2
 for <u-boot@lists.denx.de>; Thu, 27 Feb 2025 01:30:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hf2dHs/gQ5uXKQSrAsydQUMe+BcDkjsckIYoM19unLmALsv2ElApAuIf76UA0JHe/rqbQyWQIyHEoWhQFh7F9AMc8nQGpn7+EIfbH7p2gKNOJ3C/tjANxMLLeDZPRuQ7nho3m1UPBzp11h/Z0RZZRaFV67mbmM+f6AxFcwXvY/deSoSm8Re+ueVjXiUaWqjQQ2OTmwqXW500gug51ErGp3nGEcYMawL7MFl3HbnSjK2QgV8uznoNQw+FbBCxM7om+N8CFLeIrSToCID4eY0bUnGoXSmfSK5fDuQ62WP5YDHLqEgVVc0VPmRXBq3PdlxeQJlDWox9bK7uJmlUmhwuag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zmkMP7HOQkmrbVaYCC6MRzb5LUPYb3zpj9R+62SLXXc=;
 b=PtIVt5lI5XSPw/WK3Q1ImZj3xtq99loSxXCgbvw/nm5SrRNiCAQnlLFI7LCJLKP1b1t6DuzdPRrnHeAzr/DUbODoNOsliDPYbl0ITYnXdvoDPb8DfTfjMrzxpBn9u64jvDmVSLSQ22PlkU38/QH3caem12l1DIfYBo1RVrRmF6YtrClDQW7kd0MJFt/1PYAvMito5V+Y1RVvvs0AucHyt6KXVI2Fn9WAl0nNuOuLJ+wZUBUuPKOVtJ/dDL/V03KF1jqJ1r52Or5A8Y4hTv7nikr+dvD+64E8UAzYWU4TSK6HhifdQfABuJ2FMT8+rIwzr8VyIKafH1kd07ZohWG4fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zmkMP7HOQkmrbVaYCC6MRzb5LUPYb3zpj9R+62SLXXc=;
 b=kx6D/88CRhkPV1s2TMNRBRzbgmJRAXrZXQZK8XJaZ0G2hyzoP0Cv9Ubdf6Q+ENewOLlzOzJgoEK/plXFVknF0O0oWLdRcJtrQgl5BgplS5I0tydWgk+lA6Q9aIieBW6cL7Hv92PzRAMLE0sYOZPhPlrfDGptBWwO2kfOUpwReekgQfsPiOc3IfY1VwXfw3qAK0iplq0tIrDsb9/8pwrYkkEwh9VQ3J28vy5IPyfiW/JxMmXdHlRHIpMBp/nFz6Rx/CDH4tBetBSDAO19DsWNXcmSl5HqNjV/3L8fPP8CXwZYfZYdYCstxs5Hb2OZ913ORk4bm5jjQqWRaNGMUqfJ2w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8920.eurprd04.prod.outlook.com (2603:10a6:10:2e3::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 27 Feb
 2025 00:30:13 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Thu, 27 Feb 2025
 00:30:13 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Tom Rini <trini@konsulko.com>
CC: dl-uboot-imx <uboot-imx@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: RE: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Topic: [PATCH 2/2] imx8mm: imx8mm_evk: fix BOOTSTD boot
Thread-Index: AQHbhRpY04AkkA2i5k63U7t2wu8txrNaNoCAgAADLgCAABlXEA==
Date: Thu, 27 Feb 2025 00:30:13 +0000
Message-ID: <PAXPR04MB8459EF05AE7C71CB02B92A7888CD2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250222121711.6697-1-peng.fan@oss.nxp.com>
 <20250222121711.6697-2-peng.fan@oss.nxp.com>
 <CAOMZO5Drcqztvz1jE634sumDZk6Rmw5RJ1GzvvkU0mPJoDg1RQ@mail.gmail.com>
 <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
In-Reply-To: <CAOMZO5C3UmU45sN-JyS-qRkVbFC=wW1=OjhZ764UGbmK4YJp6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|DU2PR04MB8920:EE_
x-ms-office365-filtering-correlation-id: 8cdc5eb8-fef0-4f03-1596-08dd56c5e66a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?djBOZG13R0lrdmJkeVA4eDR0WW4yRTJtbFNyTms4Vk12SGYrUnRZcnhWaWdk?=
 =?utf-8?B?elJLNjF1S2dWSjVoVUVFeFlSU3N4Y0NhQWxzVDM0alZDMHA4Q3YvLzd4ekU1?=
 =?utf-8?B?L01OTXE0WEM4MXFqYXRRYjlvZ1RxTGJLcFRGaHJYNURYQ29ueWs0YXpjNDhZ?=
 =?utf-8?B?c2tjRDV5OCtUcVNhK21Vc1NBQnBlQmkxekJQYzEwYUJaWHJvU2ljeVlwb2Zm?=
 =?utf-8?B?cjBCY2ZaRGhUMEdYR0JyQnlPRzQ5SkMxdldBNXRWS3dwdnBCY0U0d1ZySWh5?=
 =?utf-8?B?QytWNGtkOGQwejMrM1pRUHliQVhNdWErMmppMk9mcG5MVjM2bXQ2eVZBSnlU?=
 =?utf-8?B?MWYrSnpHVW5MMHArTVdpTTJ5cm5tNnBTTFA4RHB0U0RGT1dDcnVBUFgwL3Fl?=
 =?utf-8?B?ZW9NaWFWc3llTWJUS3o4c1U1QWIzVC9kaDkzVFdmZFFOOUdPYlU0YXdDdlF6?=
 =?utf-8?B?dkFvQThmZmhqR1dWbzN2emU4STRtaW9YWlJKMk9tdzYyaDlJdWFJcUhTeWxZ?=
 =?utf-8?B?MVZuZEkxZHV4VnZOZEtHV1pMN3hXdGo4R3VSbWhmbWVrWHlETUg0MDdjS2dH?=
 =?utf-8?B?Wm1EY0d3cS9WZlhsS3NYZ0FtenNicDVJcDlqK2hWSS9sVy9KTk5ENlpnY29x?=
 =?utf-8?B?M3hyZlczK2NISDVHK3lQTmJ1Y01Sa0MyS3UzWXBlU0dxVlU0Zjkrc1dtKzFX?=
 =?utf-8?B?dE9NbCt6V0FVMFA5UnFhMGM0bWVxODhQTGsvbHZCTkg4TWRiRk1kdFVBVjNZ?=
 =?utf-8?B?SG9RWCt5ME45b0g0akgrRUtGdCs0TnhFOGNvMWR1Wm1DR2RES29QRXR3SVgv?=
 =?utf-8?B?M0h3cFg3WU1aVnJxVUtPTjBlNU82YXlQVkRQbWVRY0llcVJiOUZWKzRRWXpw?=
 =?utf-8?B?WGlHUlJ6VlIvMktWc1EwYWJGa1pqMkx4Sk1zcnF1eXBpYU5tVkx4dWZOdVdH?=
 =?utf-8?B?ZXdoazJJeTdNM3FQalhFUHZXRXM3TmhtRS9objNDRTlVR3FjbGE5RTBxU0dX?=
 =?utf-8?B?TkZ0aXlrZkN2YjhrRkJjV0hMb2p5WDRtMDd3QmpqeXFicW80V2dYSVk0eTVF?=
 =?utf-8?B?QWtZYlBUbHFieWZjTlhEY2gxdUJNdnd4S21ydGszQ3dWdzJWVXhYbk1QVUFX?=
 =?utf-8?B?WnczTjE3eTZqem1DRmdtQy85VlpmVmc5TFNnNUE1cm40SkVzUFM4Wm9YRnJY?=
 =?utf-8?B?a05PTTFTbzlLQlArc2xWZFNSaElQaklQUmN0SUd6Z2dQYTA0SW9LenkwTEZI?=
 =?utf-8?B?OGJ4bHUwMTViQWs2THlnZ2NWYkVxejNscGxOQTk0VTdxT3dxRUlReWhYb1lK?=
 =?utf-8?B?amJaQXVoYWhoaXNnSG1SMVlpRU5ULzJiOFpTcU03dlFxanEwakJPNERGU0l1?=
 =?utf-8?B?QVVEKzQ4L2NrdFZVVHAzdWwxSkFYdVB1TFF5dFE4bmcxRnBEUHkxUzFpalN3?=
 =?utf-8?B?cngyL0U0bFhUZUg1a21CU0puZW9qTHRoNjh5R21KdjF2TW9Bc1NjS29tSnNo?=
 =?utf-8?B?K1FUejBPWld0QVBUdU12TTBIdmVvNWp3blV2ait2MEx5dXdWUmlqWDlFckY5?=
 =?utf-8?B?VGxPdmtzSDZ6NnJBMk53d05SdGUwdEZ6d3hOL25CaUJaV2wzU1ArNGR1RWZE?=
 =?utf-8?B?dHprbmcrbGlDSzE2OEp5cWRVQXBPZW5udWt5NCtHWjdqcmZzTVdXNkkrUGFF?=
 =?utf-8?B?ZC9nTDYzQmwrVGtpZXYrZTVzMUJQUTFvR1Y5dzhQVkl6ZWxiY3ZkZHNKbzZj?=
 =?utf-8?B?TUFrSkp3T2pDaDRvNW5lTzVBYW1oejJ3ckViZjlSM1pCUldpMFhuK0RCR0Ft?=
 =?utf-8?B?c3NWK3l4Z0pJZU5BZ1BrRE44cFB3Uzgza3pqeXRNdXo4bGtyVWdsb2pETVpQ?=
 =?utf-8?B?cUxBWkNhdjFVRmZYY21kWDhoMEVwU3V4Ulo2UHRCWVArVlN0SHBSSGRYUlNR?=
 =?utf-8?Q?v3zt88fn3nowL1e1OKWd6JzqLjMLjRbT?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHZzRGNUQ1BqK3RiTmhyU2lBZm1YWklUdXlOU2owaTJSaG0yUUIyYUZXU3hO?=
 =?utf-8?B?TzBZNWhQMndZTlZsUTZpa1ROMkJTNVZudVZHMDFDK3d5SUJaRXZtdnQ1SllN?=
 =?utf-8?B?cGRTNVhVN2N1YkRCa3gvZklUL1hrbUFESjJKZ0tJQ1d0LzVyN0lZUWNFVEtP?=
 =?utf-8?B?VDN6RkRGM0YvT21jc0I3dFRFS3AvdUFYZjhsYUlZQVgrVHZ0Mm9BTEFENW1N?=
 =?utf-8?B?TTZFSWVtSERua0FINEtiZWRHY3c0bjFjVDAzNk1mSVhrOHcwZmZZRmlXOUlt?=
 =?utf-8?B?cFJEMDdOUFdPcmlSME5ERFhoQmVxUnJPbG51N0xGbGpmR0I4Y054OFdoTjRh?=
 =?utf-8?B?MU9ZNVhsL3VNaW5Bdzc4NVgvTjgzU0lhWEhlWUt1cFQzcDloRGp6R2ZKRkVT?=
 =?utf-8?B?eFRsT1ArTVRlaFUwcFIrbGVOV0pleWgwWlMzK2srVmNlVGxYV3lFUnZScGtz?=
 =?utf-8?B?REduSU1zb2d1azFJemQ0VWt3b0ptejBCZVZueUlwd0N5QTZoVE5SV0R1Mndy?=
 =?utf-8?B?NkppQmcyZUZvc29JK0lqV3p3cWFIeFI1R1FpZ25GSXJCOURQZzZZSStkazln?=
 =?utf-8?B?S2FwQitCQytHSVNpR0RadndGZVVhTC8xU1JScjVsUmxVbyt3aTNBOXJYZEJy?=
 =?utf-8?B?cFJFY3l1eFYwWEdzK3QwMHQ0cmcvYWdGMXZKVytMRWZxdlE3UjlkZkRtRkNG?=
 =?utf-8?B?aVlsS1FocURDbXFLKzVjQjN6a3ZiWEtOVy9hTDI4cTBNdFZBOGFGMFg3cUtp?=
 =?utf-8?B?Q3l0M2ZhSnZRTllncVBML1pPUVZlYjZPVUZpR040ZG1WdXVjVG0rRVJFWThh?=
 =?utf-8?B?NTJjeGNBeXpPRXZ5cUZ1WlpTS2twNGUya3BpMy9GNzdGeXVHUlZsbGJUVitD?=
 =?utf-8?B?eUwvSHgybEk3RS9mWVBGOWkwVVNtcHhNWHVtY2twZkd0aWRZaUNCeGpSVTYr?=
 =?utf-8?B?WjBwdExKMG9DazdzUEFYeUc1TWVTVUVqSEJVbVE0SmRTU3c5OGtnL2VkQS9G?=
 =?utf-8?B?TG56MUJaMDZuWXhHNWMyOS9iLzVQWDVQK1d3R21HdTl0Uk1lZGkwRHI3YnQr?=
 =?utf-8?B?MS83alcxbTRiWWFTVklkb2NCMjNyY1Jnci9ycFpkYjJubDE3R2RjV1JMcXJv?=
 =?utf-8?B?VEl2cGhxOWdyVmJxTHYvcVd2QzdYb2hqRzRkOFJlbDNsaVJrb1FVRDl3eDU5?=
 =?utf-8?B?bkh0QmdtUnhtdkNNV3lVSVg4NWpWTllGTkZKdWYvM0ViWTNuUHd2TlBSc0hp?=
 =?utf-8?B?eTZxck9yZTk5QjFiYjJKbmJsK2l4dmNuRHhCaGdUMitOUEJyeGkySHNEQmRm?=
 =?utf-8?B?ZFZDU3o5Z2NweVZhd1hiRGxiZiswZ3ZYamRUUCtqay92d1M4NHNud2x3eTJL?=
 =?utf-8?B?dXdObnRtS1ZnTTZHU094aHlFbUFDZ2J0dDdmR0Jpazh1Qmp3MnRlbDd1TDBH?=
 =?utf-8?B?VWk4QnBsM3A0cThpeVRwWko0MnRUczN5cnJ3TjlHS1IxZ2x4RnUxYjNNNzkv?=
 =?utf-8?B?MWtES3pobnA1SnNGUXlSVWppekMzaXhsOHA2QWdLNVE4RCt3WGxjcURjdERL?=
 =?utf-8?B?aFNrUWdDRkpnVjNoWmpRZXR4OUZJOHlmZ2c1YXV0RXFaZUF6M1RiVWRYT291?=
 =?utf-8?B?d05jOGNOM0V3MTFmY3plOXRBWmdWZVI3TjdnUWFEV20zMmJqUnhyNnJUa1FT?=
 =?utf-8?B?bE96SEJ1elJzdGgyY0R1OWQ5VTdyMC9aTkY4V2UrWFA5dWRNdUtjWm9zcmRN?=
 =?utf-8?B?SDNuVk42RktTL0x1U2hjNFlkcG9XSms5MW05OFNqQnNIeTA1T05wWnZPVGxq?=
 =?utf-8?B?b2FtS2dtY1k3TnBqRlJoRjF0enRCNWVEL0taQjhRajZaOGI0RVRWWTE3a2hP?=
 =?utf-8?B?TkhqcXE2WGRvcXFKT2JyZU1pTmpxeDBDUjR3L0NLZkwyZHVNTmtsOFVHRnlV?=
 =?utf-8?B?RjhhbjNYUm9RSkhnY24reEhiWUxJUWJZZ3pyT2RNWlFER29FK3ZNekpMSEJp?=
 =?utf-8?B?SzFvTWowNUxxS1o2cTBCNndmNjMvUHpIeHlmWDhUaWFwaTdjMFRvZFFnWW9s?=
 =?utf-8?B?OTJFWTNMYTNXdDVNcE5kNTY3N01pSlMrWEYrRXhia1BwUTNRdlBoTVQzRC9y?=
 =?utf-8?Q?QcjA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdc5eb8-fef0-4f03-1596-08dd56c5e66a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 00:30:13.0267 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qFrbBHpxnTAQOtuaNdch24RlUt2vRoSw0W3l90mfeSLEa+PvRvoW6NpJVW8A2yxtNxI5a/1dg2VVg5C396SHow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8920
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gaW14OG1tOiBpbXg4bW1fZXZrOiBmaXggQk9PVFNU
RCBib290DQo+IA0KPiBPbiBXZWQsIEZlYiAyNiwgMjAyNSBhdCA3OjQ34oCvUE0gRmFiaW8gRXN0
ZXZhbQ0KPiA8ZmVzdGV2YW1AZ21haWwuY29tPiB3cm90ZToNCj4gDQo+ID4gSG93IGNhbiB3ZSBm
aXggdGhpcyBib290IHJlZ3Jlc3Npb24/IFRoaXMgYWZmZWN0cyBpbXg4bW0tZXZrLA0KPiA+IGlt
eDhtbi1ldmssIGlteDhtcC1ldmsgYXMgd2VsbC4NCg0KSXQgYm9vdHMgd2VsbCB3aXRoIE5YUCB5
b2N0byBnZW5lcmF0ZWQgaW1hZ2UsIGFueXdheSBJIHdpbGwNCnRyeSBidWlsZHJvb3QgYXMgeW91
IHN1Z2dlc3RlZCBhbmQgZml4IGFsbCBpZiBhbnkgaXNzdWVzLg0KDQpTb3JyeSBmb3IgdGhlIHJl
Z3Jlc3Npb24uDQoNClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiBBZnRlciBhZGRpbmc6DQo+IA0K
PiAtLS0gYS9jb25maWdzL2lteDkzXzExeDExX2V2a19kZWZjb25maWcNCj4gKysrIGIvY29uZmln
cy9pbXg5M18xMXgxMV9ldmtfZGVmY29uZmlnDQo+IEBAIC0xMjgsMyArMTI4LDQgQEAgQ09ORklH
X1VMUF9XQVRDSERPRz15ICBDT05GSUdfV0RUPXkNCj4gQ09ORklHX0xaTz15ICBDT05GSUdfQlpJ
UDI9eQ0KPiArQ09ORklHX0NNRF9TWVNCT09UPXkNCj4gDQo+IEkgZ290Og0KPiANCj4gVS1Cb290
IDIwMjUuMDQtcmMzLTAwMDA3LWc1N2JiYzRkZTc1ZjYtZGlydHkgKEZlYiAyNiAyMDI1IC0NCj4g
MTk6NTA6MTkgLTAzMDApDQo+IA0KPiBSZXNldCBTdGF0dXM6IFBPUg0KPiANCj4gQ1BVOiAgIE5Y
UCBpLk1YOTMoNTIpIFJldjEuMSBBNTUgYXQgMTcwMCBNSHoNCj4gQ1BVOiAgIEluZHVzdHJpYWwg
dGVtcGVyYXR1cmUgZ3JhZGUgICgtNDBDIHRvIDEwNUMpIGF0IDM2Qw0KPiBNb2RlbDogTlhQIGku
TVg5MyAxMVgxMSBFVksgYm9hcmQNCj4gRFJBTTogIDIgR2lCDQo+IENvcmU6ICAyMTQgZGV2aWNl
cywgMjQgdWNsYXNzZXMsIGRldmljZXRyZWU6IHNlcGFyYXRlDQo+IFdEVDogICBTdGFydGVkIHdh
dGNoZG9nQDQyNDkwMDAwIHdpdGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcw0KPiAoNDBzIHRpbWVv
dXQpDQo+IE1NQzogICBGU0xfU0RIQzogMCwgRlNMX1NESEM6IDENCj4gTG9hZGluZyBFbnZpcm9u
bWVudCBmcm9tIE1NQy4uLiBSZWFkaW5nIGZyb20gTU1DKDEpLi4uICoqKg0KPiBXYXJuaW5nIC0g
YmFkIENSQywgdXNpbmcgZGVmYXVsdCBlbnZpcm9ubWVudA0KPiANCj4gSW46ICAgIHNlcmlhbEA0
NDM4MDAwMA0KPiBPdXQ6ICAgc2VyaWFsQDQ0MzgwMDAwDQo+IEVycjogICBzZXJpYWxANDQzODAw
MDANCj4gc3dpdGNoIHRvIHBhcnRpdGlvbnMgIzAsIE9LDQo+IG1tYzEgaXMgY3VycmVudCBkZXZp
Y2UNCj4gTmV0OiAgIGV0aDA6IGV0aGVybmV0QDQyODkwMDAwIFtQUklNRV0sIGV0aDE6IGV0aGVy
bmV0QDQyOGEwMDAwDQo+IEhpdCBhbnkga2V5IHRvIHN0b3AgYXV0b2Jvb3Q6ICAwDQo+IFNjYW5u
aW5nIGZvciBib290Zmxvd3MgaW4gYWxsIGJvb3RkZXZzDQo+IFNlcSAgTWV0aG9kICAgICAgIFN0
YXRlICAgVWNsYXNzICAgIFBhcnQgIE5hbWUgICAgICAgICAgICAgICAgICAgICAgRmlsZW5hbWUN
Cj4gLS0tICAtLS0tLS0tLS0tLSAgLS0tLS0tICAtLS0tLS0tLSAgLS0tLSAgLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0tLS0tLS0NCj4gU2Nhbm5pbmcgZ2xvYmFsIGJvb3Rt
ZXRoICdlZmlfbWdyJzoNCj4gQ2Fubm90IHBlcnNpc3QgRUZJIHZhcmlhYmxlcyB3aXRob3V0IHN5
c3RlbSBwYXJ0aXRpb24NCj4gICAwICBlZmlfbWdyICAgICAgcmVhZHkgICAobm9uZSkgICAgICAg
MCAgPE5VTEw+DQo+ICoqIEJvb3RpbmcgYm9vdGZsb3cgJzxOVUxMPicgd2l0aCBlZmlfbWdyIExv
YWRpbmcgQm9vdDAwMDAgJ21tYyAxJw0KPiBmYWlsZWQgTG9hZGluZyBCb290MDAwMSAnbW1jIDAn
IGZhaWxlZCBFRkkgYm9vdCBtYW5hZ2VyOiBDYW5ub3QgbG9hZA0KPiBhbnkgaW1hZ2UgQm9vdCBm
YWlsZWQgKGVycj0tMTQpIFNjYW5uaW5nIGJvb3RkZXYNCj4gJ21tY0A0Mjg1MDAwMC5ib290ZGV2
JzoNCj4gU2Nhbm5pbmcgYm9vdGRldiAnbW1jQDQyODYwMDAwLmJvb3RkZXYnOg0KPiAgIDEgIGV4
dGxpbnV4ICAgICByZWFkeSAgIG1tYyAgICAgICAgICAxICBtbWNANDI4NjAwMDAuYm9vdGRldi5w
YXJ0DQo+IC9ib290L2V4dGxpbnV4L2V4dGxpbnV4LmNvbmYNCj4gKiogQm9vdGluZyBib290Zmxv
dyAnbW1jQDQyODYwMDAwLmJvb3RkZXYucGFydF8xJyB3aXRoIGV4dGxpbnV4DQo+IDE6IGJ1aWxk
cm9vdA0KPiBtaXNzaW5nIGVudmlyb25tZW50IHZhcmlhYmxlOiBrZXJuZWxfYWRkcl9yIFNraXBw
aW5nIGJ1aWxkcm9vdCBmb3INCj4gZmFpbHVyZSByZXRyaWV2aW5nIGtlcm5lbCBCb290IGZhaWxl
ZCAoZXJyPS0xNCkgTm8gbW9yZSBib290ZGV2cw0KPiANCj4gVGhlbiBJIGRpZDoNCj4gDQo+ID0+
IHNldGVudiBrZXJuZWxfYWRkcl9yIDB4ODA0MDAwMDANCj4gPT4gc2F2ZWVudg0KPiANCj4gYW5k
IGl0IGZpbmFsbHkgYm9vdGVkOg0KPiANCj4gVS1Cb290IDIwMjUuMDQtcmMzLTAwMDA3LWc1N2Ji
YzRkZTc1ZjYtZGlydHkgKEZlYiAyNiAyMDI1IC0NCj4gMTk6NTA6MTkgLTAzMDApDQo+IA0KPiBS
ZXNldCBTdGF0dXM6IFBPUg0KPiANCj4gQ1BVOiAgIE5YUCBpLk1YOTMoNTIpIFJldjEuMSBBNTUg
YXQgMTcwMCBNSHoNCj4gQ1BVOiAgIEluZHVzdHJpYWwgdGVtcGVyYXR1cmUgZ3JhZGUgICgtNDBD
IHRvIDEwNUMpIGF0IDQ1Qw0KPiBNb2RlbDogTlhQIGkuTVg5MyAxMVgxMSBFVksgYm9hcmQNCj4g
RFJBTTogIDIgR2lCDQo+IENvcmU6ICAyMTQgZGV2aWNlcywgMjQgdWNsYXNzZXMsIGRldmljZXRy
ZWU6IHNlcGFyYXRlDQo+IFdEVDogICBTdGFydGVkIHdhdGNoZG9nQDQyNDkwMDAwIHdpdGggc2Vy
dmljaW5nIGV2ZXJ5IDEwMDBtcw0KPiAoNDBzIHRpbWVvdXQpDQo+IE1NQzogICBGU0xfU0RIQzog
MCwgRlNMX1NESEM6IDENCj4gTG9hZGluZyBFbnZpcm9ubWVudCBmcm9tIE1NQy4uLiBSZWFkaW5n
IGZyb20gTU1DKDEpLi4uIE9LDQo+IEluOiAgICBzZXJpYWxANDQzODAwMDANCj4gT3V0OiAgIHNl
cmlhbEA0NDM4MDAwMA0KPiBFcnI6ICAgc2VyaWFsQDQ0MzgwMDAwDQo+IHN3aXRjaCB0byBwYXJ0
aXRpb25zICMwLCBPSw0KPiBtbWMxIGlzIGN1cnJlbnQgZGV2aWNlDQo+IE5ldDogICBldGgwOiBl
dGhlcm5ldEA0Mjg5MDAwMCBbUFJJTUVdLCBldGgxOiBldGhlcm5ldEA0MjhhMDAwMA0KPiBIaXQg
YW55IGtleSB0byBzdG9wIGF1dG9ib290OiAgMA0KPiBTY2FubmluZyBmb3IgYm9vdGZsb3dzIGlu
IGFsbCBib290ZGV2cw0KPiBTZXEgIE1ldGhvZCAgICAgICBTdGF0ZSAgIFVjbGFzcyAgICBQYXJ0
ICBOYW1lICAgICAgICAgICAgICAgICAgICAgIEZpbGVuYW1lDQo+IC0tLSAgLS0tLS0tLS0tLS0g
IC0tLS0tLSAgLS0tLS0tLS0gIC0tLS0gIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAtLS0t
LS0tLS0tLS0tLS0tDQo+IFNjYW5uaW5nIGdsb2JhbCBib290bWV0aCAnZWZpX21ncic6DQo+IENh
bm5vdCBwZXJzaXN0IEVGSSB2YXJpYWJsZXMgd2l0aG91dCBzeXN0ZW0gcGFydGl0aW9uDQo+ICAg
MCAgZWZpX21nciAgICAgIHJlYWR5ICAgKG5vbmUpICAgICAgIDAgIDxOVUxMPg0KPiAqKiBCb290
aW5nIGJvb3RmbG93ICc8TlVMTD4nIHdpdGggZWZpX21nciBMb2FkaW5nIEJvb3QwMDAwICdtbWMg
MScNCj4gZmFpbGVkIExvYWRpbmcgQm9vdDAwMDEgJ21tYyAwJyBmYWlsZWQgRUZJIGJvb3QgbWFu
YWdlcjogQ2Fubm90IGxvYWQNCj4gYW55IGltYWdlIEJvb3QgZmFpbGVkIChlcnI9LTE0KSBTY2Fu
bmluZyBib290ZGV2DQo+ICdtbWNANDI4NTAwMDAuYm9vdGRldic6DQo+IFNjYW5uaW5nIGJvb3Rk
ZXYgJ21tY0A0Mjg2MDAwMC5ib290ZGV2JzoNCj4gICAxICBleHRsaW51eCAgICAgcmVhZHkgICBt
bWMgICAgICAgICAgMSAgbW1jQDQyODYwMDAwLmJvb3RkZXYucGFydA0KPiAvYm9vdC9leHRsaW51
eC9leHRsaW51eC5jb25mDQo+ICoqIEJvb3RpbmcgYm9vdGZsb3cgJ21tY0A0Mjg2MDAwMC5ib290
ZGV2LnBhcnRfMScgd2l0aCBleHRsaW51eA0KPiAxOiBidWlsZHJvb3QNCj4gUmV0cmlldmluZyBm
aWxlOiAvYm9vdC9JbWFnZQ0KPiBhcHBlbmQ6IHJvb3Q9UEFSVFVVSUQ9NmQ1NWI5MzYtZWViMy00
OWM1LTliNjEtYjY5YTEyMDdiNzYxDQo+IHJvb3R3YWl0IHJ3IFJldHJpZXZpbmcgZmlsZTogL2Jv
b3QvZnJlZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdGINCj4gIyMgRmxhdHRlbmVkIERldmljZSBU
cmVlIGJsb2IgYXQgODMwMDAwMDANCj4gICAgQm9vdGluZyB1c2luZyB0aGUgZmR0IGJsb2IgYXQg
MHg4MzAwMDAwMCBXb3JraW5nIEZEVCBzZXQgdG8NCj4gODMwMDAwMDANCj4gICAgTG9hZGluZyBE
ZXZpY2UgVHJlZSB0byAwMDAwMDAwMDhmZmYzMDAwLCBlbmQgMDAwMDAwMDA4ZmZmZjQ0MiAuLi4N
Cj4gT0sgV29ya2luZyBGRFQgc2V0IHRvIDhmZmYzMDAwDQo+IA0KPiBTdGFydGluZyBrZXJuZWwg
Li4uDQo+IA0KPiBbICAgIDAuMDAwMDAwXSBCb290aW5nIExpbnV4IG9uIHBoeXNpY2FsIENQVSAw
eDAwMDAwMDAwMDANCj4gWzB4NDEyZmQwNTBdDQo+IFsgICAgMC4wMDAwMDBdIExpbnV4IHZlcnNp
b24gNi4xMi4xNiAoZmFiaW9AZmFiaW8tUHJlY2lzaW9uLTM1NTEpDQo+IChhYXJjaDY0LWJ1aWxk
cm9vdC1saW51eC1nbnUtZ2NjLmJyX3JlYWwgKEJ1aWxkcm9vdA0KPiAyMDI0LjExLTExMzMtZzVh
MTUxNWI1OTc2YS1kaXJ0eSkgMTMuMy4wLCBHTlUgbGQgKEdOVSBCaW51dGlscykNCj4gMi40My4x
KSAjMSBTTVAgUFJFRU1QVCBXZWQgRmViIDI2IDE2OjUxOjMxIC0wMyAyMDI1DQo+IA0KPiBDYW4g
eW91IHBsZWFzZSBmaXggdGhpcyBmb3IgYWxsIHRoZSBpLk1YIGJvYXJkcz8NCj4gDQo+IE90aGVy
d2lzZSwgd2Ugd2lsbCBoYXZlIGJvb3QgcmVncmVzc2lvbnMsIGFuZCB0aGUgYm9vdHN0ZCBzZXJp
ZXMgbXVzdA0KPiBiZSByZXZlcnRlZC4NCg==
