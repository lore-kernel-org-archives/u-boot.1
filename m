Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEB8C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 15:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8B48A801FB;
	Wed, 12 Mar 2025 16:10:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Xg4sqFEg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7EA801FB; Wed, 12 Mar 2025 16:10:10 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F34F0800B6
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 16:10:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phtrQ/rCeJfqmRLCQB3tTs7xjeUe5VKXMb2xvNXKzJ7L0rMbB1oYXRUHePU6i+SrucdA4shQOYuSspBNktPvqHvRhUJQT4sdfRiVvAngtGI60CLR5tRbvDjnqZZbg/JPz2MOp+ZOsqvJaIEhJ52Uv+pRHq4BDdiir263RcBR8yOSumfvzF9J7ePxhyF4w7dhnIV3JzEWYihAqEzGWkFB1ZNddsdholw1+k6rvk7RBdVYDBIxkA2WbrAo11yn84aHTYN1koEkiIQEzYnnHk7UhiTAjZnWaY+UQ5h6k/7pFN/PCxC7bB59bVt7hQcfXmHEHR3uXFRKOLgT6/tXdRknFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8IZgVspe1GiN2p8YMx7H83x2amfkWEtdmROsd0ZDto=;
 b=RLID9rdOafS3Ah97Zb46LqlhA6DqmrzhnNUETCpqd3rEzLojITYB+QXR8/2bSP1H/OVeS1eFMU7FDGRnQR16x4gD+7lonM6mO5eLdJVHOHKXnn/1rYnLm250vuDPkrjzMEwKP+PFzQTU23sCesnKk1bXs0rcYCgTMvxo6uugJ84ziJtyY81NaAqRy09qSMUhY6JrP8GZFHH79KcqCwmslwpB/EZEp+LsFVomXWqjrHKFybpALtgFY38kea+dXn+aB4o80/4m1TlL4FB0a11OgdvwO0ZWH3m1Xd4jsmQXfNTIWzQI8GIsD8LUGIJplbeY3A/I5NTBAhpbuvZ8jGe+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8IZgVspe1GiN2p8YMx7H83x2amfkWEtdmROsd0ZDto=;
 b=Xg4sqFEg0JM113LHMVoxyi9x1KeVIFD+Q3HNnHk6R+gEwHKrEYY2Z/bf9O7l/EQ8rbL83p4VdtTk4ScU/Ili59F+p4pVcbyzNMqfdOHJLgN+S1CDLfGZ+e8RzeHy9IXXGGrojwMqOp4YkNGEqSV8ibPslzUNY5ebRPTfXu/1Fs/ICC8niCJUU+za5TyaDnajUmrUiyNaOvdXaG2F9ZSwYjwR5gQ6yr3dnnGGEtaOfvwAcqc3b73vPrfeFfyUYXg/irhJCzU0e5ZqiDQxM7VO3jFZ7vJuyN1En4GFyfEaNxXZPRcleBQuNu7kbS9ZU9hk43V3RhirUIwYuLrVsxXEIA==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB7623.eurprd04.prod.outlook.com (2603:10a6:20b:29c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Wed, 12 Mar
 2025 15:10:06 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:10:06 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, =?utf-8?B?VmluY2VudCBTdGVobMOp?=
 <vincent.stehle@arm.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: RE: [PATCH] imx8m: soc: cope with existing optee node
Thread-Topic: [PATCH] imx8m: soc: cope with existing optee node
Thread-Index: AQHbkbkPO3fdAErKrEyuSCQxmDrzsLNvjiiAgAAPfBA=
Date: Wed, 12 Mar 2025 15:10:06 +0000
Message-ID: <PAXPR04MB84599BAB4FADAC79AB75934388D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250310123621.389594-1-vincent.stehle@arm.com>
 <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
In-Reply-To: <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB7623:EE_
x-ms-office365-filtering-correlation-id: 4cec87e2-72c3-4b9e-6a85-08dd6177f903
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UlNZR3BtUzFBZkFJMFA2ZDIrTHYrOHlXY09zSWFMb2hIS2pmSEtkTEl1RS9R?=
 =?utf-8?B?SEZ5OGtpUWl0aktleGdrb2o3MmlOaGxMbEFsYUVGRnNhQlR6eEpPRjF3V3RK?=
 =?utf-8?B?Mkx6ZXprVzhKOEVOTHBjVXhQMWx3ZTRxRHk4MnFNSHFld2RkWUNNR1hadjUw?=
 =?utf-8?B?ZDYyWDZlUTJGbk95RFFsYzFCUjZ5T1pmQ3U2eC9NT1lMNk05NHJVbzhFOHBI?=
 =?utf-8?B?anFyeHVoR2J6VnY5MXBGakRIcmZzOGNIZGpkZ1JDWUxqNDRqQTAzNTB0ZGhZ?=
 =?utf-8?B?NnNJZS9xM2ZTZVhBSnNRbW9BVHh4aHlIWTZWZjh0c1VhejRmNzZsYllvRVJ6?=
 =?utf-8?B?YmFYL0MyemN2WDhXQmI0N2pXdUgwUE5IU2pxWTU1aDJOQWIrWjdYZXYxODRn?=
 =?utf-8?B?WFFDVG54dlhMbFlIbVY5dDFYb2NVSnVRMVVFeC9sMFJJQWtrRld2dmIydEJj?=
 =?utf-8?B?YWVKc3ZkV01BRWNYRmdKOHZmV2ttSkg5SlkweFNzSlRLcHZCVENUVnZYREU1?=
 =?utf-8?B?TTZyQlR3S2dEdEl3SnVmd0kydUJTVlYwUHd5Q2JqQVByWXpJNkxERTZPbnlL?=
 =?utf-8?B?TGJyaVNNTDNaYmR1MEExVU8vMkFRUWYwakVJY3l2ZWVOaXI5YXpLTENIZmtU?=
 =?utf-8?B?NURZeWVUTXFxd2RwVnA1YXc5SDAwYjh1ZitZUGphZjc4OVRMejVoZ2t5TE50?=
 =?utf-8?B?YUZad2Y1YUdnV3J1KzI5K21FUG1kS08xN3daT0t3cFl3UHpHYVlnT09IZWJW?=
 =?utf-8?B?cDNQQTRoNktINU9VL0Nqa3ZpYWZvWFJjMXFIelB3aWtJcUt3YlI5bTJ1eExQ?=
 =?utf-8?B?cDlIRU5xQng3emVHSU5EQk9ySEJQemN2ZFhic25icGRSTklhaHVyVW9SQTdX?=
 =?utf-8?B?amhiMXY0bWRiWmRSaHc3UHRqMGtEUEFkaTE3U2FFbGpjaHQ0NDhhSHArM1U4?=
 =?utf-8?B?TmtLcHZXRTVQanVpUWlNUlFCTS9Tdk5EeVdkRmsyQ1pCQnhycWRyNUFPcUVE?=
 =?utf-8?B?ZlBzaGF5TkJJRzN5YjdRTiszeVppbDlSY1NpYXRmVGpsdlYvVCsvTStrajVL?=
 =?utf-8?B?eXlaQS9wcCtxL2oyS3dGTDRZelA0Wi9pYjJtL0djZ1lrZzJla2t4NjFRNE9l?=
 =?utf-8?B?WkcyVzR3bzNBQ1J0MWJ2SUg5TkNDc0VpUXVKTFJUblRjM0tTODV2Nzd2S2Y5?=
 =?utf-8?B?a1NhWjVHL1ZiRHRKbzgwQkFlZVJmbjJqMisxTEJyenRFbTB3dWNydWE4SkND?=
 =?utf-8?B?VHkvMytSTTV1RzlBWkFGMkgxaEV1dXFXOVFNdHFjSzIrWjNZUjJsb1ZIOUc2?=
 =?utf-8?B?R3laaEJuayt0eXp0SlIxcldsK05yR1kwZFJ6ZWFEZGRlVGErMnZWTnUwMXVh?=
 =?utf-8?B?dlB3U3J6UFBseFZhQ244aisxNW9FVm5wY0d2cDY5ZWNBZUtuQjZ2eE8ybVNx?=
 =?utf-8?B?d0gvR0R6ZkJnMFVJcURaN3R6cjliaWMzSEgyQ2h0ekJDVXJueEtsaFExdytN?=
 =?utf-8?B?S0F3OWZKY0kwYjFNeEJwSSt2cDMranREMkdZZ2FOcnBrOURyUTU4Qk1OLzR6?=
 =?utf-8?B?bmtIRDRmMUU1Y0x6WkY4SCtLaUY0KzV2MEs4Ry9JNHBoU2xOOG5nWmxvZm5X?=
 =?utf-8?B?WU0wazJ1cjRyYldpTFNFazdha1IvTDQzbHZJSXcwWlFZR2Q5WVRCYnUrNEta?=
 =?utf-8?B?Q25jM2ZZZVdiOTFaZ2Z0RVRFMVBIQzlVeUtTZHR3ZGNqb2xyVUdweGhBaGpw?=
 =?utf-8?B?RllwdGVjL3YrTGlyNlEzMVM3Z1ZHcVg3clgvUS9sSXE3SWh0UDZGUlBvSXFD?=
 =?utf-8?B?WUx0RlZzdHFwbkk0RngrY0pyMWs1NXY2ZDM0L2s3elF4NlJBZGNDaEJ0ejll?=
 =?utf-8?B?UHp0WHErWHQzd0tpaTkwVW5sOEg5NlN6S2Z4WVU5MFBBc00xZUpDZVhWb3d5?=
 =?utf-8?Q?fEHdDk1A3+nA3Ut8S8ilLN87xZB1+3Js?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VytNR1BLWEFVUFV4ckRIelVlSFloeVpDSlBxbXdIWWdRRnM1WGRZMThIWDRU?=
 =?utf-8?B?bW9BUk1ZWHllTCtMUi9JNmtsd3NqenBvdVJJbVcrZEFydlRvcFdFYWtYZHgy?=
 =?utf-8?B?SEhZOGd1SHhMOXpTbkVYRG52YmpLbFplMTAzZnFXckNYLzI0eVNGTkwrOWRE?=
 =?utf-8?B?Sld3cFJvVDBaVXlLWWVQVlI1V2M4bEZWSFdrVVhVZWlTN1dQa0lJZlg3NVYv?=
 =?utf-8?B?YUNaK2RjU3luYUlSQWtqaHVyZDBEcTluWDdRdDg2U1d1MERWTElHdDFSQ1Ri?=
 =?utf-8?B?UG5tc1BYMkR3TXlRQ1d4NUpRbXkxTmdpREZHaEhWTE90ZGd4MWl1V1R1d3RL?=
 =?utf-8?B?cEhyOG9LVU5YZWJlVWdza3cvQ292b1lhWm14SElOcU4wVFNSOWhVRWd1aGQ2?=
 =?utf-8?B?U2o4b0VSdzdJd2tNbk9wcWx1NHZTcmVTWVV1ZlZVNEZidW93ZUVLd2ZDaXN5?=
 =?utf-8?B?WVZmTEMzUGdzVDVxZ1gySXI2K0N3OGVJMmRJQVBUSEV3OVhvZXJjeDd2NFVu?=
 =?utf-8?B?bW1xSDRNRUU1cndndS8rc2ZmN1hiVlJyZWhjZDFmeldXU2xZZVpuL2E1OWw2?=
 =?utf-8?B?RW1keGVjckkxa2crZlc5cTZ6TVl1YnhVY1MrZTJxMFlmTWdwZk53OThtQVBm?=
 =?utf-8?B?Y2JNSmEvVWZqQU9XaDlBS1VSV2p3czJmT1RxSTVJSGt2dzc0UmxiKzJzVUly?=
 =?utf-8?B?TXoyd1dkdGZ2bVdQS2EyZUU0Z1haWWdWS2RFS3BEL1V4ekJBSGFFU09uTXpx?=
 =?utf-8?B?MEZ3S2ZGa1pieHg3VENRZk9sZktEakp4SWs2ekdxWlRpWW96SXRvY2c0MTFl?=
 =?utf-8?B?K3lEWVFIbTJ2eUpYTVRKQlBBMFIwbDFicUtuVCtYR0VaaXVlSUsxS1kzNlgx?=
 =?utf-8?B?bTJPOENsYkNLNDN1YnFpalU3anNPTHZ4TWdTS3puWVBpd0tLbzNJNUFPK3Mz?=
 =?utf-8?B?Nlo5TjRXQUgrNlpZRWdkU0tHcVpVUWlLem54ZnZvRXNIYkUrNXA0VlJTMnQ0?=
 =?utf-8?B?R3VITjdHTHM2bGp5OVVRUVFBMjYwcytRMGIycU5iOStDTVJtZUxnOXRNMy8r?=
 =?utf-8?B?aGxmSnppdElGMkxXWmNMZWtBVnJDZnhrc1UrNjNxbzJQenFhVTBLczd3Tk9I?=
 =?utf-8?B?WHJTTEU0eXVqNFczK0I4aTBXVG9RSTdPMTVZZlV1dGs3eW9zcmRzd1NtWVJ4?=
 =?utf-8?B?K2Q2NERma05HZW02QWZXcTl2cWJ1d3BkZ0hOT1lML0dPSDNSTmRHV0RwbjBz?=
 =?utf-8?B?SWp0dklRVit1UkJXYkRXSE9OUFNUWUphVnlCNS9QUVZTSmdJY3Fwa3ZTd0Iz?=
 =?utf-8?B?L1FmZTNZK0NIMXdFWGRwM29sMjA3MlVUVFoyK2thM2M3dGpDZjczNFNJemNX?=
 =?utf-8?B?YmMzRFpRKzFOWGNtTEt2L0dOUzYyVDRqcTdReXFBRnFUUXJTMVo2dVBTNTZP?=
 =?utf-8?B?NUd6VFNVd2pJOGVtTGpieWlpemhoVGN2UUtJZXVDMEpKRFNROHE4WkFqTy9V?=
 =?utf-8?B?c2FDNkQ2dmE0b0VRa0tveDNKM2dVWXAvaHcwZ3Ayb2htNzI5bU80SWtCckFw?=
 =?utf-8?B?Vzh2SWJsL0xGaW81dk5KZlRLTlZKNjk3dXh3eWllcWl3S2V4TklibWttbW1S?=
 =?utf-8?B?UWlTNHZaVmtVZWFuM1N2UU5IUmtHQ1J4eDV1cjl3cFFQUFU3ZGxUQ2ZXSUFP?=
 =?utf-8?B?QWtSbklwQ2c0ZTVPL3Y4Qlk1aC8rd2pzU0FuWFF4SFkyRW9mZ3RYcGlOSWh5?=
 =?utf-8?B?bHZoanp0MDNON2RHZVlZNDY2T3RPajZsYVBZR0pVTlpndkFzRmhsa3RvdHJ6?=
 =?utf-8?B?UlVJZk5KbU9FbVRNSkpKOFdPUm1RL2dqR1EzcWliM0x5RDNMMy9BaGhyZTZ6?=
 =?utf-8?B?ZTdSN3lTOXh6UUJoTDQxN2prTVRCekdNeVgvNEUwREhma1ROTU43R2xxTnJM?=
 =?utf-8?B?Z0NOL000OVV2a0ltYU9meWpyNkJnbFNpS1ZWYjNBWURkMks1anVEU21LOVpu?=
 =?utf-8?B?bmVZRXdtejFsa0ZQWlYwemEwWnZ6T2tBYjdKaGpHRjRkUFdXSVVaYS9iS2ps?=
 =?utf-8?B?bjZISEIyR2R3ODRzZHo4bVhOKzlBdy9HTGRkdXB5Y25jQ0cxMHJTVDR4L1gw?=
 =?utf-8?Q?P4nk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cec87e2-72c3-4b9e-6a85-08dd6177f903
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 15:10:06.2919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2IQERIEppUtWVWMRMDd7qWQfwmhB9Wip3OuQoo16hABEgflFRpA86muLI6+CXyUzEnkjR/bynNlTGuTBjfU5sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7623
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbXg4bTogc29jOiBjb3BlIHdpdGggZXhpc3Rpbmcgb3B0
ZWUgbm9kZQ0KPiANCj4gSGkgVmluY2VudCwNCj4gDQo+IE9uIE1vbiwgTWFyIDEwLCAyMDI1IGF0
IDk6MzbigK9BTSBWaW5jZW50IFN0ZWhsw6kNCj4gPHZpbmNlbnQuc3RlaGxlQGFybS5jb20+IHdy
b3RlOg0KPiANCj4gPiAtLS0gYS9hcmNoL2FybS9tYWNoLWlteC9pbXg4bS9zb2MuYw0KPiA+ICsr
KyBiL2FyY2gvYXJtL21hY2gtaW14L2lteDhtL3NvYy5jDQo+ID4gQEAgLTEyNzAsOCArMTI3MCw5
IEBAIHN0YXRpYyBpbnQgZnRfYWRkX29wdGVlX25vZGUodm9pZCAqZmR0LA0KPiBzdHJ1Y3QgYmRf
aW5mbyAqYmQpDQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+
ICsgICAgICAgLyogTG9jYXRlIHRoZSBvcHRlZSBub2RlIGlmIGl0IGV4aXN0cyBvciBjcmVhdGUg
aXQuICovDQo+ID4gICAgICAgICBzdWJwYXRoID0gIm9wdGVlIjsNCj4gPiAtICAgICAgIG9mZnMg
PSBmZHRfYWRkX3N1Ym5vZGUoZmR0LCBvZmZzLCBzdWJwYXRoKTsNCj4gPiArICAgICAgIG9mZnMg
PSBmZHRfZmluZF9vcl9hZGRfc3Vibm9kZShmZHQsIG9mZnMsIHN1YnBhdGgpOw0KPiA+ICAgICAg
ICAgaWYgKG9mZnMgPCAwKSB7DQo+ID4gICAgICAgICAgICAgICAgIHByaW50ZigiQ291bGQgbm90
IGNyZWF0ZSAlcyBub2RlLlxuIiwgc3VicGF0aCk7DQo+ID4gICAgICAgICAgICAgICAgIHJldHVy
biBvZmZzOw0KPiANCj4gVGhpcyBsb29rcyBjb3JyZWN0Lg0KPiANCj4gSG93ZXZlciwgc2hvdWxk
bid0IHdlIGFkZCB0aGUgb3B0ZWUgbm9kZSBvbmx5IHdoZW4gQ09ORklHX09QVEVFDQo+IGlzIHNl
bGVjdGVkPw0KDQpQYXJ0aWFsbHkgcmlnaHQuDQpCdXQgVGhlIGlzc3VlIGhlcmUgaXMgdG8gaGFu
ZGxlIHRoZSBjYXNlIHRoYXQgdGhlIG5vZGUNCmlzIGNyZWF0ZWQgYnkgb3B0ZWUgb3MgYW5kIHVi
b290IHNob3VsZCBieXBhc3MgY3JlYXRpbmcgaXQgYWdhaW4uDQoNClJlZ2FyZHMsDQpQZW5nDQoN
Cj4gDQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtaW14L2lteDhtL3NvYy5jDQo+ICsrKyBiL2FyY2gv
YXJtL21hY2gtaW14L2lteDhtL3NvYy5jDQo+IEBAIC0xMjM1LDYgKzEyMzUsOSBAQCBzdGF0aWMg
aW50IGZ0X2FkZF9vcHRlZV9ub2RlKHZvaWQgKmZkdCwNCj4gc3RydWN0IGJkX2luZm8gKmJkKQ0K
PiAgICAgICAgIGludCBvZmZzOw0KPiAgICAgICAgIGludCByZXQ7DQo+IA0KPiArICAgICAgIGlm
ICghSVNfRU5BQkxFRChDT05GSUdfT1BURUUpKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ICsNCj4gICAgICAgICAvKg0KPiAgICAgICAgICAqIE5vIFRFRSBzcGFjZSBhbGxvY2F0ZWQg
aW5kaWNhdGluZyBubyBURUUgcnVubmluZywgc28gbm8NCj4gICAgICAgICAgKiBuZWVkIHRvIGFk
ZCBvcHRlZSBub2RlIGluIGR0cw0K
