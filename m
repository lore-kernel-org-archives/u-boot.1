Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55F8D2D0E2
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 12:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48357835B3;
	Tue, 13 Jan 2026 13:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Uzbxr1UW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E29EB835FD; Tue, 13 Jan 2026 13:16:40 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A19DD830CA
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 13:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlVlLGasyG+9Om6VVmNNS/LwHP4t5xhheeNfJYKYVC411l/WyHk56zi174Fcnai0MWbxq1VJuLqpMM1F7FE+dq+s7VlLGxObKIeNxNHRuz9fXibjWJGYo73LKgT7kDcGeyNcH3Yi5nkiqF7PZqIfjZOEmvP+1EdcJmlj15sIIIeuqHWiMp+NvULZdrtP0yAeKObClpm9GOZot6qaQfomTWEJgSOviSTXm9Q2Pz1JE5DGBzUDmoiEmE+SQvNOY0LKydYmpW/lP/VVszYXd/+Yyp3rQFJTgw/hMROMsi+uEgRJhjCv1FZFKUL/DGMIgZZaou9UoYavOZ2bdJWkAdxO/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rtRGM3yYCWEyC53gBlAD+oiGRVStOgkghYiLz0Iq5E0=;
 b=lhZPrtUDARrWqsJQLUD+NcP3DjejPsWTectK0XFdvwmJ147slj4qEvMQNeUfviFKao1cCqMMT8g9D7bBu1EckJN9icQQCE7fzzArzanitrzVTNXWRS++O1Pyxj5BTVkHHOs14LYTQNl8coyRcre7tK18dg0miSO1tLfFba+mlqsX3SyrL5w/YcPgo3a+/65qmpqLRdZmmg/F2zqelk7LjYHpLzip/r+G6c4yThmUw3xeGhcKrnoLtbw9xJoM493J3B5+6EYZHBMl0CXJU3Pi0UJuNZWaSITvm2Y7/oS/1w+tDC7Wib9e6VpitT4Coq7RjkiOHe/hV4ELHbcuetYXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rtRGM3yYCWEyC53gBlAD+oiGRVStOgkghYiLz0Iq5E0=;
 b=Uzbxr1UWxVI3HELD31PbXfVjSmlvbzoa4QCK3Q2BSz3iyjgnz0Lv5AWRdzUFljJXUSU+EVmvctFCdjUvvzK9Vvkh32uf6Yn+fVUKOEqDT0VN1LBTogEUMRZ+/d1FCkuFRhZKFOlSMCXGswVft4akOo3BpXr9HbmNceZ0mUbK/5Xr69PlbcfZHZ9J+zJ4Hw5oVExXr1ex4FPGjdWTs6X94bMOUFCVK5L/F9Jm7ji+tjJV5wn2mS44fU3VOrUJY8ak7DtNx8FjmGtbpdTmx2XR41V7N/bQh2DmloeYHWINn/zTUmJnbl/dX4BxGGk2oTAHOvYZFcxiGos7dF0GXnpBDA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11738.eurprd04.prod.outlook.com (2603:10a6:150:2d4::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Tue, 13 Jan
 2026 12:16:34 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 12:16:34 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>, "Peng Fan
 (OSS)" <peng.fan@oss.nxp.com>
CC: Joy Zou <joy.zou@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Tom
 Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "linux-amarula@amarulasolutions.com"
 <linux-amarula@amarulasolutions.com>
Subject: RE: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
 calculation and support high-range
Thread-Topic: [PATCH V2 0/2] power: regulator: pfuze100: Fix voltage
 calculation and support high-range
Thread-Index: AQHcgtOgv7YuExHLh0OBDEUBcPwCzbVPz90AgAAeHwCAABkS8A==
Date: Tue, 13 Jan 2026 12:16:33 +0000
Message-ID: <DB9PR04MB8461FE81E473E7B5DD8CE557888EA@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20260111082347.1302003-1-michael@amarulasolutions.com>
 <aWYJKl90YEvhVZMV@nxa18884-linux.ap.freescale.net>
 <CAOf5uwmGjw5daQXRcqJzpTsH3xXTGODZRqf1qWhM7Xw2sEHQhQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmGjw5daQXRcqJzpTsH3xXTGODZRqf1qWhM7Xw2sEHQhQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|GV2PR04MB11738:EE_
x-ms-office365-filtering-correlation-id: cd2cfe10-f555-4c5a-fcc4-08de529d97c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?eElPQzN2ekFCeXRxeHh6bWhHRlhjdnoxOW10OVVRTndwTFhCS0xUS0g1MEZT?=
 =?utf-8?B?ZDc3dzFramVibU03MDFVRVZ3RTVIZFpGVXRrUmQwakozU1MwMTZycEZHWHox?=
 =?utf-8?B?RzJHTDUycEpwUVdIZzlSbG5aaUJ3eVRTNnpDNkNWRGZXSEpUa1VUOFZwV1Z5?=
 =?utf-8?B?TUxKUkI4dWFqK3I1Z1VoeE1YbitXZ0thdkFYMHlnNFZ1azBuSEU3cDZFNVVn?=
 =?utf-8?B?YUg0UTJnTThyU2Vya0hPMGlmQWpjay9lYWhhd0pNdEc0Rjh5cE5VUmJvRGhq?=
 =?utf-8?B?WDNvdGxWWXhhVjNCYTNXbi84YkJ3MHZlUlpXdksxUWJCM1BCSGtnLzBUajEr?=
 =?utf-8?B?QUdhaXg5Y1JVNldJendhM0F2a3B6eURpWXQ3Q0g1ZDFKTk5OS3J3RElVeGZX?=
 =?utf-8?B?dXJYaHZNeks2Q0VEekdrQWJkOFlIY0JPSjVVWmJmaitFTWpCY2hzYTBmd205?=
 =?utf-8?B?endkaFRseWN1M3hxYTZpM3UzemJpSGY1QWhLUDBNZVdGSzFLUXZycDRVQXA2?=
 =?utf-8?B?Vm9Vb1JySWtWRUE5Z2lIQmtpa2w0dVNOemRNTHF4MkM4bkVweWRUb0Y1ekdy?=
 =?utf-8?B?cTVQNmYxcGVPZklkbWpDSWFSV0Z3Q2JpOEhkZ2szVXM0ZDh0d3pCaTlwQkxS?=
 =?utf-8?B?Tm9za3JjRVhaZmIzamxyd21tSUFHNnBYa0lWVFh2K0g0emhJbU1OZnZ5ckRx?=
 =?utf-8?B?cDdmZ09nSUxxVTM3Qm5XNXpZTkkvVUtMM1NzTWFJOE5id1ZKdXk5QWFsdlJs?=
 =?utf-8?B?VXpBdE40TjZXN0JFUms5UTFrY0c1cEMrTW8wVTlFVjdOblRBUDVHdUZSUVFk?=
 =?utf-8?B?MnZ5VHlnOXdzRGREamhzemNtZFU2YmYzeGpaZHBIUit0OE4zSWFQQlRNSkZL?=
 =?utf-8?B?MEc0SlA1bHhzdHB5WUNMY3RVYkMzSHcrVVVlZFdzSHRkWnorUVBtUDA0akIv?=
 =?utf-8?B?K0x2M28yMy9JQWh2S0VZMGtqalZXWlZ5dlJtbmhGZ2k2dS9pZUpwN3pEcUVj?=
 =?utf-8?B?MmtNVjRnNW5FZ0xFektEVGtTeTRaVWJWeG15MVJBZElLZVdjNDJydm14V09m?=
 =?utf-8?B?bThsRTBwMEpxZ2Q1em5SeGYzMDVwamwra1VOeDlWbUtrbTIzZmVVZUxWNzhM?=
 =?utf-8?B?ZHZvZThOUmtoV0lESCtQSHVGQzhVb1kyWHl0UzYyNlQ1U3Rnd3pMdjdkTHla?=
 =?utf-8?B?MEs5VXhBdGtWemkrZFlHeHFDNVFzNkdIN1ViekZCTTU2TGQ2MXQ0czNqOUdE?=
 =?utf-8?B?Witoc0VBemw4d1JBQ2NGVElVU2JIUWI2RTY1VDJiVU1TNDR5YTI3OEg0RHZL?=
 =?utf-8?B?bTdwajNuQmNPNDE2cFlwSTJWaHA2RUtwN1VwbTVzWjREVWZPZmZuSXg4ZjVD?=
 =?utf-8?B?cnNpV2tXMVQ4MWNGSkVFRTVGZFNDVGRsL1RSVVRDMExKSlZobHdNeFhDdHQ0?=
 =?utf-8?B?TWUySU9rZmtXK0YrZHhoS0RwTmQveDJNU2FsUC9ZZ1JkRkwyK3pYZXo1TlZL?=
 =?utf-8?B?c0N0QXI1bHhFbUdtS2d4aG01dWNEeFNic2FyMnhDd3V2R3ZYb0lidXFmazFV?=
 =?utf-8?B?UHVOZnVsQjBNSDN0WFVWd3JpMjBiQW40dVdqRHpBdzd5eG53NGlvK1ZGaElT?=
 =?utf-8?B?eWdEYTZrbERQNkszQWUwYXA4WkFDTXMxclBsSGVOc1pSNlJ0cVQreDVPZ0ZW?=
 =?utf-8?B?MzFQVzYvTmxCaW5yTnZTQllWNkFwNnBPTThlSkc5c3dMQThYSW1zSSt1aXdr?=
 =?utf-8?B?SDZBMlkrV004VWUxNDJiRDU1dU1tM3UyMTZCaEM0aFh3QjlBdmNlajBrWGRq?=
 =?utf-8?B?U0tjdCtPMmhFMXdVNUtrUDNXWms5N3g2MlpFcitUQ3Nqa1FmNmNWUlA5bGww?=
 =?utf-8?B?SXp5bzdVY1ZhaFdocTlPMHVJNjVoSzdMTTlVUEVWbVBZR3VxMU00ME9ld01m?=
 =?utf-8?Q?XNQgCVTfLmkHTjvViH7DFyl/hKiqHs/3?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ejBuWXo2TUFjSVA4YTdlbWRUSmhiNjdTc0FCbys2c3BJNk1VNmNpMHVKNjhH?=
 =?utf-8?B?bzZoWW95NjZFVjlkK2NPeXpRWFpvR3NqRjE5Q0pobmZ0Z3NOME9pV1owVWp6?=
 =?utf-8?B?bWt5QWZ1eHlJOEViT1EwS1N3c21NVCtZaEl6Ky9MYzdPN0UvMEJpblpVNGVw?=
 =?utf-8?B?clRQZG4zYVVIK0tNZGxnRnFNS0NPZTEzRUhnWE5QNkE1TThFRVR2SWFhdVl0?=
 =?utf-8?B?TmIrUlVFNVFRRGJWRDZ1UStQMmNFVU1xV3ZsUzJwZFhDU0R0Q3l1d1dzdjR1?=
 =?utf-8?B?V1pvMVhEeEJvZnp4QjIxZFJqTk5ZMm56WHJYS3dKZGFpUjRJbWhQZlVZV3NO?=
 =?utf-8?B?MURoSTFkV1FQTFRwQXN6czU4bmxCQ3B5ZVVNSFVZM3dBTHVLNjVxYTQ5MXZh?=
 =?utf-8?B?S3hUZERvQSs3M1RtUjVQMVUwQnZUM0VjTUwydkR5Y3dLODBpYklaV0Rlei9T?=
 =?utf-8?B?eDNvRTBJbHZDWm8xeHRtck56MUxnUldCNEN4azhDM2lBTVMzdituMW45eFNE?=
 =?utf-8?B?cmhuSXpIWnp4emRIM21aRnFiSVQ1MzNZSkV4clRhT1N3amR5YXVmdHdZY0FT?=
 =?utf-8?B?WjN3YzNuWklYRU9mZ0cxZjFPSFBURFViTnhEL1pYMmpDUDgrVWFCQ0QrbnE5?=
 =?utf-8?B?T09NZUdybEppMUs5Sm1rTWpzNkY5MXNTQUx1d1JlUS9ZbXBYSDVIZGZXVEZU?=
 =?utf-8?B?RFFFS3pFUFRJMG83WVZNeGNSOTBWSjcxRG9WOEZmMTJJcVhlN0dkUHczWER4?=
 =?utf-8?B?MHVJSHN6MWV4VllQQ2xsQUszTjBkdTZJb254eUhxQWpjU3FwSGJiUGxRUnZl?=
 =?utf-8?B?WDIvVHVna2wwcmpheHo1Z1lhek1lOEpVeU1xUHM5cXZWM21IVitDUzY1dERG?=
 =?utf-8?B?RldrSHJYd05DQ1c4WU05dVc2TGU5VU5ydEc1TFRGYlhGdWFxOVhhQzBzSkxm?=
 =?utf-8?B?OWF4VVRxVmJObGRkTWlUOWtnbTVjd3FlUjRleWl3SGNka01CNFJPSlZTR1Nt?=
 =?utf-8?B?WjNhQVY1cldGT2VVRUlNbDRPWHFSU0t4cVl3Wi9rK0xIUHg3MlQzWm5nWXZv?=
 =?utf-8?B?VzNHVXhyalA5NXIwVXBCY2dnK0gwWERLREZpVTduSkgxLzB0M0lCaXcvNzV0?=
 =?utf-8?B?SlNYNFU1ODZmVVVtN1JFUEtxRGRVMGlGa1krd2JsdCtyUWtveGdaSE5tODE3?=
 =?utf-8?B?L0VTWlpDS1AyRUt4TjhFN2VCby8rQmR1RDk3VTd2L3VoN0IrYkRKNFNZVWt5?=
 =?utf-8?B?ZDNsNEVDKzM3eGlvN3pydGdENElFMjk2eHNoaC93Q3N6TUxBYW9ia1o0UWVm?=
 =?utf-8?B?enk3VTExc3hzV1F6THN5cDd5Wkh4UExqY0FsKzN4WWwvdmZKa08zdHVOVmli?=
 =?utf-8?B?N0wrVzlWR05FVUVZYThGSGJoZW5YeHhSQUFBUnQzQTdwdFFqdi9Bekw3UnZh?=
 =?utf-8?B?dDZKTDF5K3BHQ3RZZk8yUFVXajdaazdiUHBvRlI4aW91MXFJbkdlbHNWNlZU?=
 =?utf-8?B?M1VxaFlsK3hKR1k1WExHNlMwWGhPK1FQc0JpUDZta3FDUzlVYXRDQWNldHU1?=
 =?utf-8?B?cElLUnM1SE4weFZqZTllUzNhNWJrYXJIcHNuUnVyTXdTOHNxSzRrV3JoUzBS?=
 =?utf-8?B?OVYzUkJldm1TTVVURG5tSXoyK2RCakJoOHEyN09ONmxpczBaS21Vb21wUkJY?=
 =?utf-8?B?aGFPRUFoSi85U0hKbW1LM2hhenBsSFdTV1hBVUk5SmY2TjREemZiYXJHc0g1?=
 =?utf-8?B?S25YYnlvVWpYQ2l0UzJMbllpUDY2a2dNWkp6WklXbW1SV1hBUisrakplWDJK?=
 =?utf-8?B?L2EyMEd4S2djUUJ4ODgzaDA2RE04Y0o1Wk1tR1JTdkhmdU5XbVRrTENKaER2?=
 =?utf-8?B?L1dCeGdDTnJOVW5iV25mWEFpZFlFbWRId3JKenEwYUNNdFAya2U0NDZBY04z?=
 =?utf-8?B?RmRXZk1uOHh2YmZ4anNmUGErRnQ5QVhmbGtldU9jbmlWZ0RuU3ByRzFEMHJ2?=
 =?utf-8?B?UzZVdjRraWtJdnB1cE1pRUhESU9lc3p6TVdUNTFzSGRUeWlESU1ML21Vanpx?=
 =?utf-8?B?TzVBajZTYzRQMTFGampXbnQ0YzF3YVIxQUJmdmkxdnNpcWZodzF3QTh3RnZQ?=
 =?utf-8?B?S0E3dGdvNmFmWFNiNXlqcEZ1WlNUVjVwemtqWWxNMkxIU2NnZVdxcUxPV05U?=
 =?utf-8?B?TUZtNXJYUnB2Mk9Ka0pqdjc2Y2UvZVpRNWlVT1VJY2xXTU43UmpKMkJtRk10?=
 =?utf-8?B?Q2hFYXVic3JRcFo5NlZjZXJsTk1IbEY3T25tMS90YkhFWnRBMytNcjRKREJj?=
 =?utf-8?Q?jElsuC+4T7/yHn8KdA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2cfe10-f555-4c5a-fcc4-08de529d97c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2026 12:16:34.2615 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eRnnCBkHv1+g5YlBlVDyz3vO/xaxCBUvQ9XpwqtAGMgB8ChQ+o1ZRg8stAHSDE9KAQYcu4kpynZQ/3Qd1pg66w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11738
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvMl0gcG93ZXI6IHJlZ3VsYXRvcjogcGZ1emUxMDA6
IEZpeCB2b2x0YWdlDQo+IGNhbGN1bGF0aW9uIGFuZCBzdXBwb3J0IGhpZ2gtcmFuZ2UNCi4uLg0K
PiA+DQo+IA0KPiBJIGhhdmUgdGVzdGVkIG9uIGEgbmV3IGlteDZkbCBkZXNpZ24gYnV0IEkgY2Fu
IGFzayBEYXJpbyB0byB0ZXN0IG9uDQo+IHNvbWUgb3RoZXIgaW14NiBib2FyZCwgZG8gSSBuZWVk
IHRvIGluY2x1ZGUgaXQgaW4gdGhlIG5leHQgcmVsZWFzZT8NCg0KWWVzLCBwbGVhc2UuDQoNClRo
YW5rcywNClBlbmcuDQoNCj4gSSB3aWxsIHNlbmQgc29tZSBvdGhlciBwYXRjaGVzIGVuZCBvZiB0
aGlzIHdlZWsNCj4gDQo+IE1pY2hhZWwNCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcNCj4gDQo+
IA0KPiANCj4gLS0NCj4gTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpDQo+IENvLUZvdW5kZXIg
JiBDaGllZiBFeGVjdXRpdmUgT2ZmaWNlcg0KPiBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+IG1pY2hh
ZWxAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXw0KPiANCj4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4gSm9vcCBHZWVzaW5rd2VnIDEyNSwg
MTExNCBBQiwgQW1zdGVyZGFtLCBOTCBULiArMzEgKDApODUgMTExIDkxNzINCj4gaW5mb0BhbWFy
dWxhc29sdXRpb25zLmNvbQ0KPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRg0KPiB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20l
MkYmZGF0YT0wNSU3QzAyJTdDcGVuZy5mYW4lNDBueHAuDQo+IGNvbSU3QzUyYzQ5MDlmZjlhZTQ2
ZWViZWVkMDhkZTUyOTBmY2Q3JTdDNjg2ZWExZDNiYzJiNGM2Zg0KPiBhOTJjZDk5YzVjMzAxNjM1
JTdDMCU3QzAlN0M2MzkwMzg5Nzk4NTAzMzc5NjElN0NVbmtub3cNCj4gbiU3Q1RXRnBiR1pzYjNk
OGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0lsWWlPaUl3TGpBdU1EQXcNCj4gTUNJc0lsQWlPaUpY
YVc0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxkVUlqb3lmUSUzRCUzRCU3QzAlN0MlDQo+IDdDJTdD
JnNkYXRhPWNMekRHOVpIRFpXa3prbXloWU1LMVowZWxXYTFmaDZBM3NRMjVaaDk4dHcNCj4gJTNE
JnJlc2VydmVkPTANCg==
