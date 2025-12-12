Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E55D43363
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 06:33:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9511835B3;
	Fri, 12 Dec 2025 07:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="bPMJt8rd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C228367F; Fri, 12 Dec 2025 07:33:07 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3158334F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 07:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n7in+9cqkORvkoyloQwNREoUsGp/c5Socd9EtgqkPNXlHXcwL5z5JX46KRnbrVQXTlB0MbewtJKXqm62NS1TpQxsrCtnxFMPjM6Nlf6GBWiPGfVR9+a5iZxj6JSQIw/Er0hs2HyV8e2hRaSgWOCRLq1TqA3bTH3KmuIDGLptP7w6LrNvbY4pxAehHuVuiGYQ+l+ys/NfWsIkUYLtVhrY1DsXwZJXQhGg2G0jUiZ9EafCjg2ebI0KYxO6pYf5yutFDeaosqh85AirU6bSbNQcMwxUa35zK9dzzSlAOeXPvJkHATBlhN/jejJOwh1586rxfIaGtO/hlWmtrsRCMsxrAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=et1zhDR8kLen4VMmsFpvAtxliJ0JiosZ5eWivVtRA2g=;
 b=MlrcRoYTARwKosF4b0mEQ5kh5JUAzf4INJqtLFfgMaBXhE8xV/IWFYkc4Ztxtp7h/XjwUsEYbugj7SiVhAaCiXMRpBAVDcYpry76pGu7C4C4mHRO8ZrP8UDGQ02cdw4Kzl7iXMVtojOH3m+hENoXCceMNURLLuKoWBBmu6Cwhwi9xkTjw+jvqxEB0R8QSkwEjMIAepHXRG43vowy8ukWWPSPMA32K7vhu7xxQ38Ll5kiPSjIckfunImK4iOc7+dz3YWYWQ9+9h/5tHIxeFovL7ddqdiLbmDtR7gi8QBoZzDDlp5BUnAfjfc14Fl8fFCmRcpp7B2FHnBSkKt17vGaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=et1zhDR8kLen4VMmsFpvAtxliJ0JiosZ5eWivVtRA2g=;
 b=bPMJt8rdezztArHquRU+Nod7suGXYUoL9g+91L/f/MCPvVSco1NxDjK4jdf/kue++BbD1ADFNguQhq9rcT5oxmdUlpwNjP/RhHfO3w5W9Izjr+6aJmdFfzGZk1e3ZIMl7waXVXQU7hOg09+OYDflzafuFMbQurzkKU4CUfQdWCNrY+hqZ2Z37PXxlLFjh+zy6j0ql7EzfdyCb6YoKF4ae+7v4BZjYY3nh5HEtP6zDTnjHBuORaX9cmKnku46RYEGE/i/8RngcYi+BC/DJMPIhHSXWLSzUTwgNrtGDbnj/s0UyW1VluD7tI/r0TzmfklG+m9DvZEMPq8tf0aiugLCQw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AMBPR04MB11785.eurprd04.prod.outlook.com (2603:10a6:20b:6f6::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.11; Fri, 12 Dec
 2025 06:32:57 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Fri, 12 Dec 2025
 06:32:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Fabio Estevam <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Alice Guo <alice.guo@nxp.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Valentin Caron <valentin.caron@foss.st.com>, Ye
 Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH 0/2] clk: scmi: Fix name defer
Thread-Topic: [PATCH 0/2] clk: scmi: Fix name defer
Thread-Index: AQHcam5W7rI5pdClEkqfKQITTQueQLUdjIyg
Date: Fri, 12 Dec 2025 06:32:57 +0000
Message-ID: <PAXPR04MB8459088345D73E40394E121988AEA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
In-Reply-To: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AMBPR04MB11785:EE_
x-ms-office365-filtering-correlation-id: 9f1b0f68-b66a-494e-8fa2-08de39484a1d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?V2ZrNDErQzBQWFFtM0puZFdBR1hGdEIrVjdkOFI3MUxxdE5Ra1F2eGkrUE1z?=
 =?utf-8?B?S0VTd3J1R0VDYTF6OEpKRDJIcVBCNzRLQ0preGdSdU5MSHZFa3ROZnI0Y3lx?=
 =?utf-8?B?ZmlIbnh1Smd0Zk5aWjR0NzREMFNDVTZwdnYvTkJudTk0dG5zN3BLd1FHdGVO?=
 =?utf-8?B?MWFVc0R5OWFOc0xIV2VCNnJONnRncXdGTkdoakxKVWhhZ09sM0QrSko0cTR0?=
 =?utf-8?B?S210YSt4K05Idk5XYlR5d3prTHZLcUNmdjltcE1zRkhHN0hFcUwxRTNzL2lG?=
 =?utf-8?B?dlUrdTg1d2x0WWpheG14WEFCdlYralVYV29kRnd5aFMrZmZwTmVGaUQrQ0da?=
 =?utf-8?B?WjkydkFKaGtUL2JzWGdtYU02MGFELzk0RkhrM0RtaFJ5dFRNNlc5eU5EZWwy?=
 =?utf-8?B?YTNkT0R1aGNHSnFPMVVMN1Q2UDlFcEZZaVlmZ3FxenVTMVg0YWM2KzNwNWZv?=
 =?utf-8?B?U00wN3dsNUV1djI3MExITFcwVmxJOW04WkRrUlpMTVBzN1VhVHYrZm9IckFU?=
 =?utf-8?B?NmdKVzhUUGFTbXhvZkxCYkE3NXFhOUZJbjhyN2N2RFovbit0RHZCQkc3YXpD?=
 =?utf-8?B?SGIwQlN1NW9iSWNVV2V4TkxTVGpRcFEvMXp1L3liUmZ5NGpHV3NxL0t4NS96?=
 =?utf-8?B?RDRWb1U5d0NzTEk3MGxUMFgxcFVRTVd1NmU1YVlybTZHVURXKzViQ0tCRTNu?=
 =?utf-8?B?OEhSYnZ6OUdTVTBJY3Jjb1NBMUkwcnNGVGdjck1mNXlVVmxHR3hvVnF5bEZm?=
 =?utf-8?B?cVZLK3Z1UkRQVFFOcGVjVEtuQW12SFVhR0hwSXBsbFRnaldNajNwTjNzeHZN?=
 =?utf-8?B?cDFSYVQrZzQvNUJKTWVzWGtWNXVhSTlBVkhDbFM3NW02VmI5SW1oZ29ReUlZ?=
 =?utf-8?B?MzhCd3R1SXQ2NlFVR2tjVnYzK29OclozeFlNZFdYRG1KNHZkdHorTWRzdkdl?=
 =?utf-8?B?NWNmV1k2M3hTK0VvV2lSVDhBTEY2MkJ1SEhHWk1XcE5jL3puZmpxNS9rMEVT?=
 =?utf-8?B?V3NuZGg2VUdER0ZDMnM2dklIWm4xM01DS2lVRzZCbVh2cVphRlhoNC9BcDh6?=
 =?utf-8?B?aDd2cm90OW5BcU5GcG56NjkrSTQ5Znc2dG51MlNHaXNNR2JwK3hNK3p5QmRL?=
 =?utf-8?B?ekk4ZUwwVnBGQkQ1TjhlMlpKQU85STYwVXpvM2c4Z1JLMk9vcE5pSWFnRWhu?=
 =?utf-8?B?cUloYjhxMStCZE05aVEwRVFIMTJNME1LVDlRK2xrUDJ4aGRQamlLRFdDclhv?=
 =?utf-8?B?Z3Q3WmFheVc5SUR4dlhnNmxxa24rZlRpd3MwTDBHTHdRRVhWUUd6WUJnUFY0?=
 =?utf-8?B?cysyM1BycjRtSHRRekNpdCtoRHhKR0VINHBJZGxXUUhRcWpNUjkxMHlqUU83?=
 =?utf-8?B?b0pOcDVZcUFhckIzSlc5Z1dsYkw4Y0lKeVRHdmxRblRTaUJKTG5CQXF1NHVO?=
 =?utf-8?B?VzhIQ2tKbndIcW44cDJ5VTZqQjl2TmcrMHpxeU5XYk8wUUxTRitUbTlkUkZh?=
 =?utf-8?B?UGdpMmxvb2p1MXp0eUhpQnRwYzQzeW9Fb2NhTEZ4amE2bngxSGpyQzdveFhz?=
 =?utf-8?B?VW44bGV3MnMzOFVrckoySHBURDBrcnE3d3JnSWFmT1RLSTRnTmR5Vnd0L2Fy?=
 =?utf-8?B?bEdyYURwNVllcUhSQ1Uwczc2SlptYkMvV1FEakJ1b2M5SmorZnd6UzliY3Z5?=
 =?utf-8?B?dmwzZmplS3d5T0pwZG1xM3NZbi9QUjdtVFJYeDdyNVhxeWY1NFAzZE1scnNH?=
 =?utf-8?B?OU53ZXFBUVVmYjFKamxhdUpmZlpiWThwWWM0ajFiQWNkL0FNbkFSakNQVVh1?=
 =?utf-8?B?R2MxWW94T3JEbk4xbXIxNnArQ2JYN1dqNlZCN0E1bkxDMWs1aTBZUGpzSWhJ?=
 =?utf-8?B?U0d0MDNkcGY0cjFBdmxWUE16UlJCTVZHYXIvSzlmL3ZGOFJpRzRmN0NmY0ts?=
 =?utf-8?B?TllYajVNalpBSlRjczBnL0ZHa2JoRTdwemd5bkQyR2pEUFQraEhaaUF6Tjdt?=
 =?utf-8?B?UFpRR0FvRFNRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(366016)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHgwbms3SXZISXczMjhKb1FXTkxSNDlrbnRob3VQTlFoZVNqWXpCbVMzVWZi?=
 =?utf-8?B?YjBSdDVkQTVKcE81YStaQ0dhWXhSMGpyNlFPMmVLT3VsN1VCOTlJWW9QMXE3?=
 =?utf-8?B?STBwY3czUlg5MnFaQ3VGZ2gzMWZwZm1paytqZndpTXRKZkRNL0JxMnJ0c1ho?=
 =?utf-8?B?OVV1YlViZVo2dGlMdmNvQ25LdWp3RHQyeElhQzN6UlR5K3VCdXZnS0pYUWxD?=
 =?utf-8?B?Z05yRXE5aUtkZ0tub3I3SGVvR2VVdlBwUVRrSFgzdFlrd3kwbEJtS0F1YkE1?=
 =?utf-8?B?K3RldXp5VkZIek01cHM0SUNMTjBRT0N4UVJHMFZqeVFVZ3V1a2tDT0lzcjFx?=
 =?utf-8?B?Q25PRzI1QTVwN1VBWVBNQVMyN1pINkdJaDYybGNTc0hVSFBBM1QvcXFqNGJP?=
 =?utf-8?B?Y0xWMy9UcUowYmw1c0tpdFBETTVNQWRsVTM1VU16cFlUN3NWeHlrOWsrbHc0?=
 =?utf-8?B?YkVyL2t4TG1GYU9adnh3WlJRanY1dFlSa01JVWNrNGt2U0lWSzNCdGsxWlRy?=
 =?utf-8?B?OU0rZUFadGQ1TnI3TE9qNHh3RFR4K2NlTXk4aXhHOUs0SE1JK2NTQlRreXJ4?=
 =?utf-8?B?bzdqUjA5Q1ZpM0hyb0pqcDdvV2lnU0xCalQ1MUhzMXhPSmI2VUVWcDFXd2lm?=
 =?utf-8?B?bVZDajlPcjZrYjh3QXA0alNoYm1McGhNUzBSRmxyK0ZZWWQraEY3dHBvK0E4?=
 =?utf-8?B?TlZNVlNlTk5ITkNzMFQzM05oRGFvd0tZVzk1UGRYVThaelAvcFZkZkRqMmR4?=
 =?utf-8?B?NmxWTWlJQ2lhUEVPb2NkckRQMjZHdlZ3UExML1diQXhhKytPck1YSjI5VG5n?=
 =?utf-8?B?RjNBb0RPdHY1TTk3YmU2QWV2WUM2QWRGKzVNWWFrNGtUOEVOL1hudDh4Z3Rm?=
 =?utf-8?B?MGZxSnR4OXg2NVphMTBxb1BYQnlOMG9xVE1VZjFZcmpuU2JGdHl5RS9mRnZO?=
 =?utf-8?B?WnRody9zQzRzcmUzZm5TZjVrUDg1MzJlMlRwZHR4b1c2WWlqWjhvTkgvY1BX?=
 =?utf-8?B?dXZISkFFclpjTDI3M3llK2lkMVhCNUpjcWt3bmg3M1lka04yQ0dwSnUwc1o4?=
 =?utf-8?B?OFdyOEpTZ3ZFZzhnOXBRaTVQeVFIQ0tsZ0xQS2JnZ2MzVHo1emZ5TDlieEVR?=
 =?utf-8?B?ODhKNDBCdXJ1a2RMaHAwYXJFczdOcVBXZ0NDdEkwV3ZobkJZYk42NUxTOHBM?=
 =?utf-8?B?dFRDQlpxQ3Y1NTVrQWlCV1psUlV4V29MN2FBNi9GOHhZWVRtRmZaa1A2ejZC?=
 =?utf-8?B?eStsd2tlQTlGdFFqQkt2bXdKVUhLNlIyM3ZRL2FOYVFScmtxZW1uR2VkRnNH?=
 =?utf-8?B?SVo5YXdBdUlMSFZ4RXZnbmFNQ0xhekZtbmcxZWJEQXc1b2kwN0EvWStTWDBk?=
 =?utf-8?B?ZzhhQnVRVW9HTUZTc2FHSXNBbVBGRitPQlE0Rk45Y1c1Z1hFVGRwdm9PT1g5?=
 =?utf-8?B?SEw5S1NzWXNhb0UzbjdWcWFJQU1MbS9SQTZXTFVIUFBJVXNRRVhIY205N0JE?=
 =?utf-8?B?NVRHZEl6WkxtR2ZGTEN6NnhZWEgydlNxM0dQMTY2Qm9sWlhsSHRxMmhyWmF1?=
 =?utf-8?B?a3VuUldkaVRGeTJHT3hlUjdOZlV1UE5LeENNc0o5SXIwaEJpb1dVZ3Q4WUlq?=
 =?utf-8?B?Y1BOYnVFeVhiQlpYWVNBLzc0WStTRXZoUG5jNVFuNk5SZHNQY2tvTFpqajRI?=
 =?utf-8?B?bEtCZmZ6RG84V3FraVhVaEk2M2ZiTm5wa2duQnluS2ZuZ0wvU0NYQ0lmN0Nw?=
 =?utf-8?B?emJZQk8yNktXdk03dVRTdGZoVi8wMjliMUpUbVdpcFhEZEtDZDlpenQ4TlMx?=
 =?utf-8?B?aHRndEprNTZkQjRiQ280RUhzOXpIcHlodjNxczhIRHppdnplNStyZk9jdVE5?=
 =?utf-8?B?YmNHS3FpN1U2am5XY0hmZnVyQVJQamVDYTZaTElYQjFjN1BNR2dNSCtTUlRM?=
 =?utf-8?B?amw4RWo4eFBieVlXeEZKN0FwcTRIbUprcDJDLytUbitYR0gwYmNOd3ZidjUr?=
 =?utf-8?B?OUpZVXJKNTl5dDFoNXN3OHQ0UWZ6TkljU1FqUXRsa0lhK3ZmVE81aU50QzdE?=
 =?utf-8?B?Z3NjelZrVjF1MFd6ZFVxRzZlNzRPMEt5S24wdENHcEpMMWo2cXFQdElqMTdN?=
 =?utf-8?Q?MB0k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f1b0f68-b66a-494e-8fa2-08de39484a1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2025 06:32:57.6833 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHom7tmwfUTxrI7ISQKjvAhNdBbMxPovd5+H2GoqV5VNq3je47ihgjTVXAapr7gmSC1wV7nVzeaS9pkjuPKW+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB11785
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

SGkgRmFiaW8sDQoNCj4gU3ViamVjdDogW1BBVENIIDAvMl0gY2xrOiBzY21pOiBGaXggbmFtZSBk
ZWZlcg0KDQpJIHNlZSB0aGlzIHBhdGNoc2V0IGlzIGRlbGVnYXRlZCB0byB5b3UsIG1haW5seSBi
ZWNhdXNlIHBhdGNoIDIgaXMgdG8gZml4DQppbXg5NS1ibGstY3RybC4gU2luY2UgdGhpcyBwYXRj
aHNldCBpcyBiYXNlZCBvbiBQYXRyaWNlJ3MgY2xrIHNjbWkgZml4ZXMsDQpJIGFtIHRoaW5raW5n
IHRvIHBpY2sgYWxsIHRoZSBzY21pIGZpeGVzIGluY2x1ZGluZyB0aGlzIHBhdGNoc2V0IHRvIHNl
bmQgYQ0KUFIgdG8gVG9tIGZvciBtYXN0ZXIgc29vbi4NCg0KSG9wZSB0aGlzIGlzIG9rIGZvciB5
b3UuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IFdpdGggbmFtZSBkZWZlciwgaW14OTUtYmxr
LWN0bCBjbGsgZHJpdmVyIG5vdCBhYmxlIHRvIGZpbmQgaHNpb3BsbCB3aGVuDQo+IHJlZ2lzdGVy
aW5nIHRoZSBnYXRlLg0KPiANCj4gUGF0Y2ggMSB0byBleHBvcnQgYSBmdW5jdGlvbiB0aGF0IHVz
ZWQgdG8gcmVzb2x2ZSB0aGUgc2NtaSBjbGsgUGF0Y2ggMiBpcw0KPiB0byB1cGRhdGUgaW14OTUg
YmxrIGN0bCBkcml2ZXIgdG8gdXNlIHRoZSBuZXcgQVBJLg0KPiANCj4gVGhpcyBtaWdodCBub3Qg
YmUgZ29vZCBzb2x1dGlvbiwgYnV0IEkgbm90IHRoaW5rIG91dCBvZiBiZXR0ZXIgbWV0aG9kLg0K
PiANCj4gUGF0Y2ggYmFzZWQgb24gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjUx
MjA4LXNxcXMtdjEtMC0NCj4gMjkwZjA1OTRlMzBiQGZvc3Muc3QuY29tL1QvI3QNCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gUGVuZyBG
YW4gKDIpOg0KPiAgICAgICBjbGs6IHNjbWk6IGV4cG9ydCBzY21pX2Nsa19yZXNvbHZlX2F0dHIN
Cj4gICAgICAgY2xrOiBpbXg5NS1ibGstY3RybDogUmVzb2x2ZSBzY21pIGNsayBiZWZvcmUgdXNp
bmcgaXQNCj4gDQo+ICBkcml2ZXJzL2Nsay9jbGtfc2NtaS5jICAgICAgICAgICAgICB8IDIwICsr
KysrKysrKy0tLS0tLS0NCj4gIGRyaXZlcnMvY2xrL2lteC9NYWtlZmlsZSAgICAgICAgICAgIHwg
IDYgKysrKy0NCj4gIGRyaXZlcnMvY2xrL2lteC9jbGstaW14OTUtYmxrY3RybC5jIHwgNDgNCj4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgaW5jbHVkZS9jbGsvc2Nt
aS5oICAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysrDQo+ICA0IGZpbGVzIGNoYW5nZWQs
IDc1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6
IGQ0MWU1ZTYxOTUwNjE5MDhlOGQ5YjNlMGRhOGVmOWVhOGJmMzcxOTMNCj4gY2hhbmdlLWlkOiAy
MDI1MTIxMS1jbGstc2NtaS1pbXgtZml4LTBmZmUwOTlhYTNkNw0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiAtLQ0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K
