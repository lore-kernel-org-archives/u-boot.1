Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20394D5B154
	for <u-boot@archiver.kernel.org>; Sat, 13 Dec 2025 11:36:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F29E8307F;
	Sat, 13 Dec 2025 12:36:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="aWJLWuPU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2DBB2835FD; Sat, 13 Dec 2025 12:36:09 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E274083045
 for <u-boot@lists.denx.de>; Sat, 13 Dec 2025 12:36:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=us1whvggOLCe+4AdR2JmpuHqe4K3/+e0oIIe3fwj/2fvC9FljAVpxs+xpPTCR1xO1xr5n92r0PXqIut4ELo+c9XYMqCfBNayxVLLtoQItRuMide0TSuLMN5evbmcYBxOGzCjDXvRBraMQMvg5Xd3TzqER/8u1jV2oJUxx7+E4tCQjgkupeIpT+jp8yK4EOQmh4UyJdbxdq08vBjaGSeSoNO9e3Gb7GPdbEVhp9rPi25g7w+uUZr5J8EeLUf+Cn+6vvsq52BngiPWDeEQGsQSI/aWxS/5P8fJvmpel7tPNheHzqtxf9NhewnC3ZsglCRXlkFrse/fF+ccfEWt65OhEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQbPqGMgo0HxluRoUmMD4GM5+MtvCr8JaESUqKWmULI=;
 b=BR5jBA69fhFPhPEifXpgpkF4iX4xvaD5RmknagOjIJRB+F0ePz8ymstaxIC1S4fMKzGXQsavW2du6sEwyp2IPiL9jHD0lAKTikR5YWXo8sUgVEUUtyUBcCLvXLTS604TPsaU9Tx9dH73IYdyHbLTBQuDqHNsOxTTQH+tCbBs8Ii+RpF15w42j2akHjSQsaDlOommuvx5JHHXQC+J1rJ3YnQrYI+1VDaIDL9JI5QzMXffJaeHvGzGm/mOwBd4fLeljWOvEqcNpgm7iHeDseiL9vrr6C3S7NhuhrT1FV8ilWGXZrE+SNNCbOA48oF2XluVF5TYI6qt3c9yfOfUQhnAcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQbPqGMgo0HxluRoUmMD4GM5+MtvCr8JaESUqKWmULI=;
 b=aWJLWuPUgG2Ribd/ATf5HbursQwSznNZH4mezcEL7swxPuXmpndFfgEf3MYdNkMPr6C1XYkpI7MUSKdPyZZJRAo3Bj8SYQLZO0nf96j5HYDPEM5W4Y/tS1Fr0nxzVqW2JlRpDcKN0DxQGnwQHRRO5JSxqH9+Cbj0CeMtgcu/557kavroTg0m9yyfffyi9BrhLYSi4IzzddKwp6sRJFt22F1niImsajgubv3sG9zmJcOp+V+lfmNLK/fWpGtZtPLb1A0u5OEbcnsV2mu/Al+0KpxCvBYckbaLA+WjBUXWrI/9GcPqIdCNnBUtIH3UcVmTkfRHvt/RTklta2Uz5j1Jrg==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB9122.eurprd04.prod.outlook.com (2603:10a6:102:22d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Sat, 13 Dec
 2025 11:36:04 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9388.003; Sat, 13 Dec 2025
 11:36:04 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Fabio Estevam
 <festevam@gmail.com>
CC: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Alice Guo <alice.guo@nxp.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Vinh Nguyen
 <vinh.nguyen.xz@renesas.com>, Valentin Caron <valentin.caron@foss.st.com>, Ye
 Li <ye.li@nxp.com>, Michael Trimarchi <michael@amarulasolutions.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH 0/2] clk: scmi: Fix name defer
Thread-Topic: [PATCH 0/2] clk: scmi: Fix name defer
Thread-Index: AQHcam5W7rI5pdClEkqfKQITTQueQLUdjIyggACXO4CAAU1g0A==
Date: Sat, 13 Dec 2025 11:36:04 +0000
Message-ID: <PAXPR04MB8459F29BBA73A78228B31EFB88AFA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20251211-clk-scmi-imx-fix-v1-0-9579567da829@nxp.com>
 <PAXPR04MB8459088345D73E40394E121988AEA@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <030912f8-7bcd-4e4f-a63e-85fa8eb27917@mailbox.org>
In-Reply-To: <030912f8-7bcd-4e4f-a63e-85fa8eb27917@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB9122:EE_
x-ms-office365-filtering-correlation-id: b64f954d-4643-432a-f9d3-08de3a3bccb6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?RVJlbndkZzkrTEJOb0laa09vWGlIQTU3eWlTbktnSkNrdFRnalRCTVgvYURH?=
 =?utf-8?B?eVVBWGR5ekNwZWxmK093VFpJYlc0MlU3dCsrUFhPTzZFQWpHbXE0dEthQk1G?=
 =?utf-8?B?a2x0alJjeFRaMVkzdS9QZWxxOUpEYXpwbk5rOWNmUStLeDJZWGc0RU1lcWlz?=
 =?utf-8?B?MSs3VXYweVgxT2NmSWNKNUtIeTQxMURlc0pIcjVuSnRJNFgwNjJ5aTJnbXdL?=
 =?utf-8?B?Z0FDNStlTlUwNkxES1dvMklPcVUveDJTN2kwTDdWajEvSXZ4R0Z5SldXZUJC?=
 =?utf-8?B?QkJPd0hzbnFOWlFBQXJQOGdST2l4VTZuTU9RUjJQaTVWdjBnUUdoNVh6eENY?=
 =?utf-8?B?WEd3UGp0K1NsanRFSUg0STZMRkJlcCtUSDFxVGROam05eFU1K29EYTJDSC9V?=
 =?utf-8?B?ck1JZ2paOG9hV0NMQkhkM2dMS0YzMWt4bEZ6bk51SmJ4NVIxUkY3Z3hCSFVC?=
 =?utf-8?B?ZFZQeUZBdVZqU2FZblZYL01BU0RLa041bUtuWGVnYllpWlNRSG4xUnA4MERk?=
 =?utf-8?B?SDBZZ3hyb3R2TzlFNC80S0FiOFF5Wi9TVGF1V242cmtjOTFPek1IRzNtVFgy?=
 =?utf-8?B?dmp1bi9KcktJSUE0UFR6MXpZWjQ3NFM0Z2hjejR3Ulc0TURwNzY5VjFSUy9X?=
 =?utf-8?B?cDlsaWtkSWFPQlhESVErYU5aazYrblJBbDB0dStjVDBiSjR6YUVqN0hFM0Qv?=
 =?utf-8?B?UjFmcFFGUGl6MVcyYWJZVkNhRTRmN2RYVmdDZTdpMjlzR2dRNzNRVnRUWXVD?=
 =?utf-8?B?dnI2L0hGNUtPSFluOWtjSlppNGY4OHRIU2txWTNETGhYTVBxL05PdlB1Rk91?=
 =?utf-8?B?dC9iRElwWUdPSWFUWTJpdW5jWGg1REFEK0RoQ09HWHVoVy9JRjlGbEpGcUN4?=
 =?utf-8?B?cHEreDRiNGhMOHJoZ2Jlb2V2MjZ0SkluZDlaa3d6ck1Yb2dyZ3hOY3B4a0Vv?=
 =?utf-8?B?MmJ5Y3VnMEkzUmZqbEZJSkVkT2xkclBoU3pxdEJaU0hYTjVQczZGekpDRXZu?=
 =?utf-8?B?UFpFZEhGZE8xSGZFOFNaeUtsZ01MTENkQWd3ZnNidjZUbG5Jc2IxaHY4WVF5?=
 =?utf-8?B?SjQ1d28yYXVOQ1NqbDNFcGliR2dIYkpYMkxhaDR2elowMGEzNWk5NkpZZVdp?=
 =?utf-8?B?MVV1Z29KdFlnZVdORmV4aHJyOHV5d2FIVTJHSjA3b0VFVGM1cUVmNm5PSkxB?=
 =?utf-8?B?dTZ4aFRib1RNVDBZNGVhVnlleERhYjZjZGxwMHVLM0NZTXFHV2RUMHNCQWV5?=
 =?utf-8?B?dGhGVDRFcXh6L09qMjlHSk9sL01jcldQbXI1dWtsNldZc25SY3pOdzBMOUha?=
 =?utf-8?B?ZGc5UkphbzZ0eFZxVXdLVW5uODU0cy9BK210N2UwVnJ4eDFWV3JiTSsveWp1?=
 =?utf-8?B?VEQ5eVJnb3NsSUxCdkV2U1dsbi9RdWU0MGE2d1Y2M29SSlFhSkRPazA0Yksx?=
 =?utf-8?B?d2czNFgyUjVEc1pEOU9hcEZRRlZ1ZHdUSklrR1ZMZ0dCeVA5TEFFaGhMb2pr?=
 =?utf-8?B?Si9jcFdrT0M4cTYrU1Y0UUdLOWE0R1Bxbi81T2FYd0F6TlZoM3dVR3dEYWRq?=
 =?utf-8?B?Y1NlQjd6YVdvY1FYY1hITnhOUHc2cFVZTDh4ZVh0Yzh3a3ovSnhDekdVcU9I?=
 =?utf-8?B?OFhBY2x2ektSRzRwajZPY2RPeEJBYnpiTjhwZVBic2ZJQXF4ZDJVY0tkQWll?=
 =?utf-8?B?dlRwMTJIUTBlNitwU0RjS1RqWk9pTTJReTgzZW5sQk9xSHlsb1VhQnIyOFpC?=
 =?utf-8?B?M1MyYlR6QXZoTldtbjBYVCtHUlE2TjhxY2IvNkhXbnhVZlROd0d1WTV1d3Fs?=
 =?utf-8?B?NWM2VjA2azh1ZW5rOEM5dEdUdFhKdDlPTjgrMXBOR3JQVkNRNVRMTGt2VkRu?=
 =?utf-8?B?Qkdway91MTV0ZGNabVhjd3RtVGhudTRXWGhSbmtXSG5ZY3pFdUd3Z2NpZmJY?=
 =?utf-8?B?bmJsTHY2cGNGaFhjc291V2RMZzg3WWg1LzNqdjhuSWdFL0k5YmFteitrdW9y?=
 =?utf-8?B?NXltOXpjMXhEQ3Y3SFdEcEZjUmVIVkxDM2E1QWFGNC9HdmE2S3IwT2xyc2ZS?=
 =?utf-8?Q?b1WTjg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(7416014)(376014)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VWROSThQdzVmZ2dpQzJ0R2wwbXU5YlZ4STR2MExOcGErQk5ScFNaeFV1cWE3?=
 =?utf-8?B?STdXaEc4Z25TVTJsM3IvUUlJSzgwSE1CZjlvTkkvNHNnVk5OVjU3QXVoa05S?=
 =?utf-8?B?K1V5emptSk5XOHErQ3Bsb3p4bmNyczVUMmptSk9oVnhsR1N5dUNZem5iZ3Mz?=
 =?utf-8?B?dVB2N2pYY1l3WU9HV2lsTFkrREd1UDB2VjUxU1dGSks5QjRMVlZHNk84SEx3?=
 =?utf-8?B?aFFVdlF5WjIyODJpaFZPWkM1cFJ4c0lLcHJyOWpnLytIaStEOXNja3BRQ1E5?=
 =?utf-8?B?SHhaZVF3dWhxb0V2Qnd3b21aVHlMWW9pd2NGYi9jUUtzWEEzU2pkTUtPVldp?=
 =?utf-8?B?TTRzMXc2aVZOQ3ErOWx2NkxmeFMyYjY1T0NNc05NTEtCZTZZb3BHb21mTGUw?=
 =?utf-8?B?L2dPM0pGT3RacDJkQWlBRW5DRUZtK09uNXNxVXBINzlBTHJUMW1YWlY2V2tk?=
 =?utf-8?B?Y3NySURkYzVCMHAyTG5ycERiTE13SDI2YnNvNFI0Sm9oWFBmdmwvUmZJTVp0?=
 =?utf-8?B?MllJQkZhOWpJMGU2N1htSktIenRpcC96Qmk1NWV2djIxZW8xN0ZFU1dOdFRt?=
 =?utf-8?B?bGFsK3JZWGtBR2lIMGpJSmVibHdPVUdCaVNyZlZuRHp3RkxTekh3eTdqR3oz?=
 =?utf-8?B?d3BXb3F4OUpINlhkL2xzOHBidEhoelpPeW5iQnEvdXZRMVpWbEpYSVpITHk0?=
 =?utf-8?B?OG1vditVLzh5YkNZaGNBM0Z0enFNTzhTcU0wVk9pZ0tIM2VybjdJanFTZjUw?=
 =?utf-8?B?NVhLUWZBcEVhaTgzNnU2T3FpT2VoWVVQSkpSS1NwSWNuS3hBZGo5ck95SmpX?=
 =?utf-8?B?RU5kdzVQY205RkM3eG5Jc1NxUHpnUEIzb3cvZmRUNnZtcnM2V3VlV2J5ekRF?=
 =?utf-8?B?VDlWUC93VWcwTzhQMWw5aTYvdFNleHlMMGJtR3hmYWpwTU1UU2xBQlErZVFG?=
 =?utf-8?B?bXo5djgycjQrS1RCU2pjeTFkRWxVbXZYMlRuaDYyM3BybFo0ZzZudnJ5VWFL?=
 =?utf-8?B?cHBUS05YV0d3TlVFYXRDejg5R1V5dHk0ZnlENm95SXBFYnVlUE92WUU2OEJh?=
 =?utf-8?B?blJOSkhadlBwYVAwZjRTNkNEM3pHS3dNSVptUkhlOTVaZHlXZmFxTVFINWxH?=
 =?utf-8?B?NXd2bTNPUkM3V3dDQTZ5UHhXTEs2QWIzVVdodFUrU3YxdEhZU29TVElUdmVU?=
 =?utf-8?B?c2tHNWxvR1N6VDkydHZtdXFzMkxMR1J6RnV1aGNaVDd3QnUxdkh5UlhLeEZX?=
 =?utf-8?B?cTFUalpoZElGNVdmQWVzWm1ZZUkrdEpIVlBjUHBwS1pzMkF4OG52aDYwUlJp?=
 =?utf-8?B?UGR1MmVMSDVDY1hBL0NscHhyUm9HNnBTVFAyY0NXSEVibGxwS2RVdndBTFJw?=
 =?utf-8?B?dzZ5QXJmQ1k2ZWtqeFZkU2p4MGo1UTFZc2xjY0FqQ2xpenZvMWdiVlhER2Z4?=
 =?utf-8?B?Qjhyc3I3RENPdHMxWHdjWFQ2UnBQZnYvWStBcE9lUlNjcDIvVXVtd3h2SENW?=
 =?utf-8?B?dlhMbDFTZ1dtS1Y0T3IzWUQycXR5QWVUU2V1MTQwTmdhTnlrMmREakRjMWkv?=
 =?utf-8?B?TWFvTXl3eXpwRXdndE1WbzU4blZBcVlsZnJuanlzNnJMbU15aFJMb3luMDVq?=
 =?utf-8?B?M0VpNUw3cjZyN0I1OVkrd0YrUGRSWEdEZWVsQ1VMV0EvRzVNRk1QRHJPYncz?=
 =?utf-8?B?UDA4NFZKMXVvbVdzbXorSFlqRjF2a0MybVY0bi9laDJaK0JxRW9hOWJxZ0Jr?=
 =?utf-8?B?V25GSnFua2puNDdXbEFTSzgvSUpBWnFLbnhtQ1VKVVRaRGw1dk5tWWk1K0VF?=
 =?utf-8?B?MkZQKzMxalNoUnNLMG9QRUNPaE1XNmJWK0ROdXpJNGpLSWw4QlRzYTB0c25r?=
 =?utf-8?B?SFpJTzR4cFlNSmJLbU4xL0FoeXE2YVk0MnJ4a05FZ0l1TnNhZGg5K0RNYTlN?=
 =?utf-8?B?WWFXQ2FRSDZoamllN05RRkxleE8vVzloWndYQWVkdmhyRGFJMGZUenZSZitu?=
 =?utf-8?B?ZnFtWUF0em8xT0g0T2ltT2luSU1QUXR2NndOQ2Jzc25tL09SSTFpTlcyMzRF?=
 =?utf-8?B?SVBYcTJjMnhoWW5jMGYzMHBNOEZITDFnaCtoM1EycGs3dS9qUVVnOXJQREt5?=
 =?utf-8?Q?Xp/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b64f954d-4643-432a-f9d3-08de3a3bccb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2025 11:36:04.5174 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV0DXj6x5hBqZRamWr4JpqrBqdPhMILFyg2MMLwlDcssEp7iuwkKEArAszTvXH1Zx+9hamDOM914YndyUQhOeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9122
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

SGkgTWFyZWssDQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAwLzJdIGNsazogc2NtaTogRml4IG5h
bWUgZGVmZXINCj4gDQo+IE9uIDEyLzEyLzI1IDc6MzIgQU0sIFBlbmcgRmFuIHdyb3RlOg0KPiAN
Cj4gSGVsbG8gUGVuZywNCj4gDQo+ID4+IFN1YmplY3Q6IFtQQVRDSCAwLzJdIGNsazogc2NtaTog
Rml4IG5hbWUgZGVmZXINCj4gPg0KPiA+IEkgc2VlIHRoaXMgcGF0Y2hzZXQgaXMgZGVsZWdhdGVk
IHRvIHlvdSwgbWFpbmx5IGJlY2F1c2UgcGF0Y2ggMiBpcyB0bw0KPiA+IGZpeCBpbXg5NS1ibGst
Y3RybC4gU2luY2UgdGhpcyBwYXRjaHNldCBpcyBiYXNlZCBvbiBQYXRyaWNlJ3MgY2xrIHNjbWkN
Cj4gPiBmaXhlcywgSSBhbSB0aGlua2luZyB0byBwaWNrIGFsbCB0aGUgc2NtaSBmaXhlcyBpbmNs
dWRpbmcgdGhpcw0KPiA+IHBhdGNoc2V0IHRvIHNlbmQgYSBQUiB0byBUb20gZm9yIG1hc3RlciBz
b29uLg0KPiBQbGVhc2UgZG9uJ3QsIEkgdGhpbmsgdGhpcyBpbXBsZW1lbnRhdGlvbiBoYXMgdW5y
ZXNvbHZlZCBxdWVzdGlvbnMgYW5kDQo+IGZyYW5rbHksIEkgYWxzbyB0aGluayB0aGlzIGlzIGNv
bXBsZXRlbHkgd3JvbmcgYXBwcm9hY2guIFlvdSBzaG91bGQNCj4gbW9kZWwgdGhlIHJlbGF0aW9u
c2hpcCBiZXR3ZWVuIGNsb2NrIGluIERUIHVzaW5nICJjbG9jayIgcHJvcGVydHkgYW5kDQo+IHBo
YW5kbGVzLCBhbmQgdGhlbiBsZXQgdGhlIFUtQm9vdCBjbG9jayBjb3JlIHJlc29sdmUgdGhvc2UN
Cj4gcmVsYXRpb25zaGlwcy4NCg0KQWgsIEkgbmVlZCB0byBnaXZlIGEgbG9vayB0byBtb2RlbCBp
dCBpbiBEVCwgYnV0IHRoZSBEVCBpcyBhbHJlYWR5IGluDQpMaW51eCBVcHN0cmVhbS4gRHJpdmVy
IHVzaW5nIGN1cnJlbnQgRFQgaXMgYnJva2VuLg0KDQpXaXRob3V0IHRoaXMgZml4LCB3ZSBuZWVk
IHRvIGxpdmUgd2l0aCBpdCBpbiB0aGlzIHJlbGVhc2UgY3ljbGUuDQoNClVwZGF0aW5nIERUIGFu
ZCBkcml2ZXJzIHJlcXVpcmVzIG1vcmUgdGltZS4NCg0KVGhhbmtzLA0KUGVuZy4NCg==
