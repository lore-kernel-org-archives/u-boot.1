Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D31C36018
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 12:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72B1588B89;
	Tue, 17 Sep 2024 14:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NwujHJvf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0BC88E06; Tue, 17 Sep 2024 14:21:06 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB61388B89
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 14:21:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kE9Rs/m8hWXfLehFSn2qvjLDSM/C9ipUSi8ySVscUCl2Mh5oSaVHpuO4wpTeDDsWFULdDnAT650bOfJnxSohU46jmSdIGD5yeUw/j2BV1CXFfoBeANJD7/gmEs8PDomrktJCHWvoV18aensp89qxhFacJsExIhBq36cDtWCNmsI0t097vb70lTPGBvSJFx00KR9jy4ZzflP/lCzVB/i3wh9R0foYvtCHzH3Z5LmhsnooqaVe7hoqW7y3hYPNa31d7P4jUooQnWLjLNuOh++yYCMt6+cJlzHzSJwHyVMTS283vU95XGPXdYwh9JH9Rx27HYPW6RLwh73DL0uEGZIQHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYNKX6QryNnKnqr/ja7I0FpwL1XSJMfH+i/USW8y6ck=;
 b=DSNIX+TcIdjExMz8nGwXcEtnfQSC4mdmV2oyz1GDCzmDRfE+XWvfwZEJ0ht6IughfDVwrZcyzffBfX/TeevfcJPxhROjRiX4jhBG4cja3aK59ZA54bSeHbNf+sS4TsCrbj3QQt/GvNcX9DHjtqutt20iXn6mL/D8FVv9oapFS+HiQY6r9DL4v61vCyVcV3vKAIaGYwrNgmVcaI2vSOGgQbVWdtYND4sRgCYgxZCTaQhJ3kMoo5WaJvThbI2WBtN12pu0+V/0G3Pt39UQdbdlORcGZ5j0mg27TELbFmyiFfaXNrV2CJRbLDpCq77f3+dRqSZCoVnJNmpGSpMhZ2+xDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYNKX6QryNnKnqr/ja7I0FpwL1XSJMfH+i/USW8y6ck=;
 b=NwujHJvf1ksAbcDgjHYO9NocD0at8jmv4u0mg7e3GzUmRzxcVoXxHd4v8Zv0JGmvguyp2zGjr0kBr8xuylx+egGweS4/u7SrwB0UaCkS60k8Fz2Fo58XC7NGrccRqoAVELN6QjdljMLC2ItwT5kotH8mhEB3tJj84WyAURrh8FWnYaLr0ZLVJp4xO8WS2jdsX3TqDRA2rdNuNN6+MKDookOF4AlI/Sj1D3lg2lYjZWtITZ+2uog404vjWaSWmC4irv2LnWrAN7bnq3544yLb2CrnYwifwIBoINcnQujaxuML6yfN8VQaPEn3j8237ArbmB7CactEdzD7CA5I+po6Aw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GVXPR04MB10900.eurprd04.prod.outlook.com (2603:10a6:150:21c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 12:21:00 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 12:21:00 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@denx.de>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH 04/21] imx9: soc: Print UID in big endian format for EL2GO
Thread-Topic: [PATCH 04/21] imx9: soc: Print UID in big endian format for EL2GO
Thread-Index: AQHbCKmZFDe5Vyo6qUOIAqJFizNuA7Jb5W0AgAABBmA=
Date: Tue, 17 Sep 2024 12:21:00 +0000
Message-ID: <PAXPR04MB84598442F1AC6F16508F1D9388612@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
 <20240917-imx9-update-v1-4-4fe8effc937e@nxp.com>
 <CAOMZO5DCaU7min2OjigJiXOJpXMgOnncwjbFAyiwrX0UAxiOvg@mail.gmail.com>
In-Reply-To: <CAOMZO5DCaU7min2OjigJiXOJpXMgOnncwjbFAyiwrX0UAxiOvg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|GVXPR04MB10900:EE_
x-ms-office365-filtering-correlation-id: 175c8378-7ae3-430c-40e9-08dcd7133124
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Ri9maklyQS9wbU5mWFNkNENnZHFxSkkzOHRVRU41dVYwajJuT3FwQlNKR09I?=
 =?utf-8?B?eVRqU0NWYXYxcFVGOWxSclJYRmorbHk2SlBqOFVLSFFwZmpNTGIyUkFtR1BN?=
 =?utf-8?B?M1RBdHlnL3RlN1JScUNGTklYVWdjL0plbE5NL1FXLzc0VDZOQzZGQ0M2SGhG?=
 =?utf-8?B?MlE0K0FzSGY1bFRSTi9xWU9UbEw1TlY4NVJ2bGZ4aGkvYVZTVU5TUE95L1Iz?=
 =?utf-8?B?d0VqUmZSak8rbmNGUE80ZXVKRHFOekhsSnZCUCtha2VOS0l4ZnRuYXM0ejRL?=
 =?utf-8?B?dXpwZTZuZm1idUU3TTFuV0diMk84Umh6Uk1lM21SR2hEb3piNTNFNjZZV25k?=
 =?utf-8?B?dGVtQ0R4RWJqUkZmcWNNdVE4cWxyQ3EvREVCZDg4TGdBaWFWVnpQaG05ZGho?=
 =?utf-8?B?T2VTbmVMWkl3c051ZWV6NFdjZTR4ZXp2LzJCUGs5VGRxbnAyTVpFcHFVMGRU?=
 =?utf-8?B?Y1Uwd0J1VUptdFRpNHE1M3hvRy9tRm9TSngrckg0VFUzZWdRSXB4b3U5eGwv?=
 =?utf-8?B?a0VWRloxa0xNSFo1c3dhcGZvVGh5SW1KQUMyRFhhZ3BKRTZMeXFGZFdRQ09K?=
 =?utf-8?B?TFRyL0hDQkJtYkJtdmE0cDVvcGo0elU3aHVOMVBLTWtKQ3hNemNrdHNFVDJ1?=
 =?utf-8?B?RktiaTIxa1RWdkYrT1VqL0c3VEVBNWwvZHg2UXdDR21LdGUrbjFuZUdmaXNi?=
 =?utf-8?B?WVkxMnBuaVBFdHhGVVc4M1JQTEFyRkRVdks4a2dLNEtJQ3hLTllzVU8xemw3?=
 =?utf-8?B?TXBsYmFTTWVsZnpjWUpTeGEybFlycFRsOEUraGk2TGIzeGlWOXNwUXMwU05U?=
 =?utf-8?B?d0tHRDRDOHRpdDAxcW9FV1lQM3dnK2hobCsvTHJhQjdOb3NMWmsyakVWeEs4?=
 =?utf-8?B?Z0NEMW5kclJ4anFmOWFJSUtLa001ZDVsSWkyVnczcitHZTljVERzQzk3OGw4?=
 =?utf-8?B?akcweXY1Wm1FY1M1eDJGeHI3RGFhMGVHN0NPMmNjd29laWc3VENGQUpOT2dN?=
 =?utf-8?B?MEg4NDlBNlUvdFd0aEhtc0IzY2hIaCtmamsrcldmS05tMFFpYVpXQmllWEo0?=
 =?utf-8?B?Ym5mVFcrczdPKzNyaG5BcTZ1ckJna002NDlRd2hCVUEvWSt6dmdpUjloczM0?=
 =?utf-8?B?UkNxSXIrK0pqcUlNejhZbkU0K0tyYWFQTWV1SWhaTDVGVDVBTlVyaVlqTHRG?=
 =?utf-8?B?NnNESzBBc1ZmeVFCS1E1MWMyeUIxVUVOTjJQT0xJdXBCTk9CSmpwR3M0TnU3?=
 =?utf-8?B?NGROUXlXVnVMUk5UZTZGUit0UEJCMUVlOXJzTEswakFSVExyeGYrbzBpTnNS?=
 =?utf-8?B?YWZPUEFEdndrUDFld0FmdEJnL05PMDFjczhqb0pKVFgvM1FSSW1sME15S2g4?=
 =?utf-8?B?aDdtZE84azA2cFhpTi9ENjd0SW83NFM4V2ZaL09Ebk5PWnlJY3hncEFSTUpr?=
 =?utf-8?B?WHhab2JHWC9KSmxGTFN1RmhDOCs5Q3NBY3ZUZzltVmtxb0R4NEZvWnNLRnh5?=
 =?utf-8?B?eUp3MWNiSjBQV3A2bFVLT1B2TEVUTU00cHZOajlBWEhxRDdHRWVlcjNqc0xy?=
 =?utf-8?B?ckpXamZYUU9iM1hJbGg1UU9JNU5MaEkwV3RIU1VHMUg5RVc2a2FuTjdCYUUz?=
 =?utf-8?B?MERHT1FlQkZyMm5sdlVVOVkvT01HZWRlaG9YdXFFRFgyRFVJRldnVzM1VlNZ?=
 =?utf-8?B?TE1mYlZUS3c4OEVpSUl3OTI1S29vYjgyWnJMYk0yeklwV2l5eE5HMHQzdnl5?=
 =?utf-8?B?bThMbGVURkJUUUNKSHlkQzFVYS80ZCs4S1J1QkI1QVoyOUZZTldpR2Q5U0FZ?=
 =?utf-8?B?S2lWQ3Z2MTRXVFM1NEVYS3dTRnYrR2wvY0g1QkZCaEpVUHVwai9Sa1l5cW16?=
 =?utf-8?B?WHZLbTE5NnF3RnowTi83NzR4cHF2VGhYTGI0UVd4dnE4T1E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mm55MW5sdGRMTDlhS3VCaHZZUEIzRVJaamVoV1AwdG51aFJqbUd5ZEFTSGFq?=
 =?utf-8?B?WUoxY1Z5LzVhcDllNGtpNGovR1Zic1hCalRUZjR4S0I5ekJNaVR4U1Fmd3VX?=
 =?utf-8?B?VG9iWUZiYi8wdkkySG1hSE9vb0JhR3kwVmVuUVZJMDU3RlljZnZpbWZucGJo?=
 =?utf-8?B?MENrRGhzOExVcVFZWnE3Wk1VQVNTai9rOHl1NG5sZVJjLytCeS9UY1NvSkpE?=
 =?utf-8?B?bmQ0eklNZHEzZmxsb3pIZkZSTzJ0MTJKTWlRbDJnREM2Si9Xd0FuOEZPdmlE?=
 =?utf-8?B?K0Q5OTZUbDV2NWxtWUQ1eFY1OS9OSUQ1Z3N1UmJISWxidUJZQ1RKVXo3N3Bv?=
 =?utf-8?B?ZTN1ZEVHTjZINDNwRzZyR1ArVDAyaEpsSUJvQU5Fcll1a0lGbkxxd01QS2NT?=
 =?utf-8?B?WkhIbHZoN0Y2NTJYUXdra0NjSGFRRGw0VDJKc09idjBnb1hTVXl1YittR1h0?=
 =?utf-8?B?WTA0emJQcUpuS3NPYVNtVzNhMzNnQ0VicGplNWc5SjNyUXdWZno5MFQ4QUtJ?=
 =?utf-8?B?Rk4rRUZBdDU1RCtnOVc0QlpOY2tGa1FhUXBBZzkvbVYxRUM2K3dmZXIrY0tr?=
 =?utf-8?B?MnFBVEF3VExlVm1yZHlLY09VbUY0NC95UEhjcEsyd3IwRXZXYm16VFdWa2F3?=
 =?utf-8?B?cXkzU1F5UlNLNDVnSTZlNEhreVV0dkFtK2FnTGNmRlJrR3BkeEE3QlFqS25L?=
 =?utf-8?B?MXcvQXA0T1lEK3ErcVR1TUQ3ajRncEdjalBzNmZCMGZjYlRlZ1FIVWZNcGdH?=
 =?utf-8?B?ck5TQ0JIbk1KSWlsMjBYZkdGMEUzalhmZ09oeHBPampNOG9jUStpdWIvUkFT?=
 =?utf-8?B?M3dqS2RYUzJKcHhITnFKMWtQVlBQZ29ESmFEY0NjK1ZWQjdzdkFTcHlqY1Uy?=
 =?utf-8?B?ZjdWcW9oUStIbWZaRkZ3ekoydE40TFc4OWU4RHNwZUREWkxUMGhqSGkvL2U0?=
 =?utf-8?B?UXRWeG1hVWkwTWtnTEd0di91dzlsQk8wb05iV1NKWUl2M1BLV1JiamF4VEh2?=
 =?utf-8?B?ZUljeXpWazNvUEJHN0pQemlyY0VHRjY5aDhOSS9zNFI5R3pNTkNPWEdsdEl4?=
 =?utf-8?B?QmQ0S28vMzgrTitqNVM1NmNVbkF2aUdwenF4QTd6VjlDWGEvem9OYUtoVEFZ?=
 =?utf-8?B?bmpsMmEwZ2srWHJTUllqU1NpaWRBSm9Gd3d6VHY2Z3dUWVBjRjhzRmVPVEox?=
 =?utf-8?B?dFFXZUFQMWZ5eHBOcXk0T1l5cVR4L2xxN0QydnNmRHJoMDVpRTJLcmtNdEZZ?=
 =?utf-8?B?Zm9qWHZwVzEvQlhEYk9aZFJvb0NBSVJoTDJmNWk1cWRrU3hYbFAxakE0ak92?=
 =?utf-8?B?SWZTWXlGNWxrVHpLWW80akRISUZESkNKVy9vL3lPV3h5cmFJM0dlNStSRVFp?=
 =?utf-8?B?NmtGMldpaVg2S0lvajNlRUtWTVVNczgwVDdudElIMmttTUgwaE1nbTlXNFR1?=
 =?utf-8?B?MEhsRUtrRmd6Qy9UV1h6OVpwSm1lRDllNXJVWkQyOGVLRmlrMnN3NHZCcWJ5?=
 =?utf-8?B?SVB6RHV5c1F2YzJyc01yOURrT1dsVE9EV1Q0dzdiY1ZTT3g0b3Y2U0FHMHdE?=
 =?utf-8?B?dC9yekd1Slg5R2xWaitzTDdLVi9mODJyUEhtZzBYVEFqenNtRHRTRllvUkZx?=
 =?utf-8?B?Vk13ak1xTXRpZEVodU5CVUhGUkVtV05rOWlNb0JPejNyYWpNTVpINWtCTnUr?=
 =?utf-8?B?MmtqZ0l0UndkemVxSzJxcDg4STdYQ2FtS1F4UDFIUDZpVi9OWDNZZlhlNVhV?=
 =?utf-8?B?L0RZNERXVWxTVFQ5V0xqNklwclFyQXp3Tkw5MFVDM2NFZ0pia3N3WmdqaW5N?=
 =?utf-8?B?TmJiRmUvdi9EVk1HSzdmTExVcW9RdFFTekFYQlUxd1RCVkhvL3d3NTlIRFAw?=
 =?utf-8?B?SmZWRE5tTVB3QStDVEUyRHBiMzNpMklHUXBNWHVJb3NjRlJWM081NVVKR2pF?=
 =?utf-8?B?RDkzMUMvdG8ya0JoYTZ1RHVnRldDTFJtMXI4YThMb2JIRGZpQ2I5ZFBRVDdN?=
 =?utf-8?B?Q2J6bXJQMkM2OE5SRlQzdkcxbXZVMzBPR25KUXFKMzk3Nm05YTJKd0N1L3NH?=
 =?utf-8?B?YVlRdytsUVN0SDNSdVBuNGhYL2hjeU51MTJ0Y3l6TVlySlA3VDc5WVU5K2dG?=
 =?utf-8?Q?3J8o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 175c8378-7ae3-430c-40e9-08dcd7133124
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2024 12:21:00.8259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LITUcNq3sXOY9FXg7ZfubbK0iEiVRRhM5w2AxIV6NXjLGibicPhY0GAbsmwW0WIEx8Wp8etzaVujDx/4OmY0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10900
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDA0LzIxXSBpbXg5OiBzb2M6IFByaW50IFVJRCBpbiBiaWcg
ZW5kaWFuIGZvcm1hdA0KPiBmb3IgRUwyR08NCj4gDQo+IE9uIE1vbiwgU2VwIDE2LCAyMDI0IGF0
IDExOjMw4oCvUE0gUGVuZyBGYW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90
ZToNCj4gPg0KPiA+IEZyb206IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiA+DQo+ID4gUHJpbnQg
VUlEIGluIGJpZyBlbmRpYW4gZm9ybWF0IGFuZCBhcyBvbmUgYnVmZmVyIG9mIGJ5dGVzLCBzbw0K
PiBjdXN0b21lcg0KPiA+IGNhbiBkaXJlY3RseSB1c2UgaXQgZm9yIEVMMkdPLg0KPiANCj4gV2hh
dCBpcyBFTDJHTz8NCg0KRWRnZUxvY2sgMkdPDQoNCmh0dHBzOi8vd3d3Lm54cC5jb20vcHJvZHVj
dHMvc2VjdXJpdHktYW5kLWF1dGhlbnRpY2F0aW9uL3NlY3VyZS1zZXJ2aWNlLTJnby1wbGF0Zm9y
bS9lZGdlbG9jay0yZ286RURHRUxPQ0stMkdPDQoNClRoYW5rcywNClBlbmcuDQo=
