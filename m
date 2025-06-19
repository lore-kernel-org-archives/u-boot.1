Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BBA5C7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 23:55:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D5E682CDF;
	Fri, 20 Jun 2025 01:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="Rw91IMQO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EBB682C55; Fri, 20 Jun 2025 01:55:38 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43B6E82D66
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 01:55:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmfkwJkmCNMat+a0p19+4gcDq+o7HruWIE6z/Oz/QBZPczFh2QVUzF/0MJqCugzahMM91HF/rbS7v2SCypA5IKAMq7+K6ADf0WsX9Yn86G4DkRs0F7nsfPGKJAdGy+Zd9GIQMR6p/yqhXwhXL6ECpbLUlBRi0DgcA5usvxb8UGMv/AaXIQTOp4B8xru9SaZAbF3xMfW69dswxBOpmyq350R9E4VOHAQ7wTSS3JwnJDwIlmuPFOxKkbRjFGSqAnxzdX/dU8Pad9HWANF6Zh2u2fBaVzku2hS6hzRTAN1YOD6Mlf5BWoNa6c9kHgX+qf9Z+gyraIXJDbBz6YZT4e/jlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lp0+cdapnRWMFyw/BxIrLqf5LyTcM3GEpeuFMwZ4XZ8=;
 b=YpYYwRQbqhqrIguxeBycEpDYAL6KFAU0YIowX0yHii5phbil7I6Z9cv1rv6yy4xXwWAZzOnSDqU9ZuU8y646W+5FxBghXRAtcl8gQ7ZQ4LUQdxoN0/+XU7BiFE7NJIa1fcVM8WnPsclTn1StZPNzR/6tMUo8252tt3P7IrKy7quGLGbjRJhh1PXKLnU83iK92eJtKpf4icb7pYjuppoWldiN0KKKs10bjq0sVCEGQ2AOCg/NWPrS9tx0fEwE/BMgWl1fgLg1ml/S3Mw44VFQmjRj8vg0S5wcmOpnYTpWq2KyWt4+JKd9ura04Kx+52fcsszlCKRi3EyidB6nMVGjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lp0+cdapnRWMFyw/BxIrLqf5LyTcM3GEpeuFMwZ4XZ8=;
 b=Rw91IMQOvJ7G5+UZUHzpgqxv5mcEsBWHuryXyltNsK7fBJ09WLnurG8SiVRfEx5Ap4ZEYRMjDNEt7bwjGcaMN3Kr/9RSjDHGNjA9zFYywVzh4V/bo45+kOPpmLflfBwARDqRMvfKV62l8YcBgTAjNy+HfqRU0a470muz7+o0v42llvxYXivMH9laBsd2ge/6O7jdvLomwlAhDSa/lKVWWE/grFXm/pvC3fJt2Ebt67fo8mmbCClo6fRruqaj5rRcyvVwDzQl8FYK19XzOwIj4lFQZFAnldrINT8heC7N9wsKGp2VzdUj9I8y8+0pATDqNhp+r9luvB9HCfPa5Tzctw==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6919.eurprd04.prod.outlook.com (2603:10a6:20b:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Thu, 19 Jun
 2025 23:55:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%3]) with mapi id 15.20.8857.021; Thu, 19 Jun 2025
 23:55:32 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: Stefano Babic <sbabic@nabladev.com>, dl-uboot-imx <uboot-imx@nxp.com>, Tom
 Rini <trini@konsulko.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: RE: [PATCH 1/5] imx8mp: evk: Add support for capsule update
Thread-Topic: [PATCH 1/5] imx8mp: evk: Add support for capsule update
Thread-Index: AQHb4Ppj783iWmkEkUu0+dmB500Zz7QLFXMAgAAS/gA=
Date: Thu, 19 Jun 2025 23:55:32 +0000
Message-ID: <PAXPR04MB84590228D95ED9371FA86DE5887DA@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20250619-sr-v1-0-631100a113a5@nxp.com>
 <20250619-sr-v1-1-631100a113a5@nxp.com>
 <CAOMZO5CHSgaYcQcS+9VtfP0eH8QTwvJ6rG8yLijDU2M0JVacuQ@mail.gmail.com>
In-Reply-To: <CAOMZO5CHSgaYcQcS+9VtfP0eH8QTwvJ6rG8yLijDU2M0JVacuQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AM7PR04MB6919:EE_
x-ms-office365-filtering-correlation-id: a7b85006-830d-4267-683c-08ddaf8cc701
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bmhCbDRUZnFmQ3phb3NGTDlZTVNzT1BwZm9XTEJWRmwxVVpRaFZwUG42S0Qy?=
 =?utf-8?B?ZnhFbHJzWjBSczdhL2d5OVBacTZwODJqRCtnZEo1QUlrMVN4MytQaFhDOGEy?=
 =?utf-8?B?aEkzVTE3OXFFcWh0SUdseE04SGYzakwyOFhnQVhWR2tVOVlvZkJ3TzJWdmFa?=
 =?utf-8?B?M25aS2lIVzdzQmlVMkYwSk1keHNDc0NmWks0RnRTY0R5WXRyZUlQWmlmdDY5?=
 =?utf-8?B?QW1ZNXlXUlFiWXZjTHQ3dmZiZWEzKzh1eWFJVFNpV1BpWnlqTWZ3WElrYVpj?=
 =?utf-8?B?anJpZ3JqYm5jQXRXYTFOZVh6MTJTUmpvWFhBaVhHNzdPODRBUjM2M3JVekd1?=
 =?utf-8?B?Njd4VGxtUVlOUTFOOVptTkRmYlN5WGt2Y2s5NG1EbHNUWGxuOWxlQzd4UDVV?=
 =?utf-8?B?TC9EL0dqZHFUNXNvMWZEV1RsK0R3bnZkeUplMEdKK2VkY04xNUZ3M3g1ZXkr?=
 =?utf-8?B?UWptRm4ybGpBaUtWRk0zTVNYY25sMDJxcHNUQTJRZ1oxTGk5WUFnMGRZTnB5?=
 =?utf-8?B?ejcxdGdIUmxiaGp1dVVEeTRSTWVwQ1Z4bXR3YmVYU2o2RlpqV2V6Q3ExRnZx?=
 =?utf-8?B?Y3dFMkk2ZXNVN3hvVEpQdThVNkxGYTZwNElFNlVhUmdaQm1zMjRJOFdoR2dG?=
 =?utf-8?B?S0p5c0xtSjdMNk15NmhvTjBiNEdFa2VlS3piYVZRMFlwL1FzblBGVGFiaTFu?=
 =?utf-8?B?UXNablVGS3c1RWxseGExRmFrYzZISlp1MnV4dUlOKy8vMzA0dlY2YVA1dUMw?=
 =?utf-8?B?S214dmU3U1dkMmZzckRtbDN5T3dnT0dLZ2NhUzZxSXdGVDNKUVl5bTNLem1u?=
 =?utf-8?B?QWZNdXBsajg1T3Ywc3VzNThaWFZITk96ZnY2Y0FVZC80bFVjSjZxb3RiUy92?=
 =?utf-8?B?Sno3eWt4VWZ0TmZBWFA1R29iMGozajF6bloxNld2V0J2YnY2U1dVeEdrSjQw?=
 =?utf-8?B?ejkxNTRla056UnJDUDZVRGp3bUhaWU96ZWZVK0N1L05BZFNZdks2ZEQ5VGNC?=
 =?utf-8?B?bXBrV3k5N1h3c29kWjRzTlhZeVBsRitFVXVZSGNpb3VGZTJvRDU0S3d6a1l5?=
 =?utf-8?B?SExRYWJiVzZZOXh5TGdUVVdsbDRLR2xUNmNMa1dEaTQ0b2d6WXpWVHpkTFc1?=
 =?utf-8?B?czNpRGlpSFAwWFJvazQvTkhKeWYzQ0l0SWdpSm1aN1hhMUQ2NTNTMGV0Wndr?=
 =?utf-8?B?UG12U2Q4ZFlHbnhZYU9uK0hvbEI0Y3NWT1BJQWNXYjJwd0NSRVVqUVRhMDZP?=
 =?utf-8?B?M3BFQWpuZHpFYmQ2QzB0RUE4UUJxQU1QT05VTjRReUY2ZHloeEFZaDhSU2NL?=
 =?utf-8?B?S2pEbE56Y0RDSDlETG9hS2dYSjlQcUxqUzdmSWFKdFVMcXdhM2U1WXR5WE1W?=
 =?utf-8?B?Vk9pVmZIR0tUZGRoR2RSampzU1ZSdmxzaHlKdC9Oa01VOGIzSEFkU0lBQklm?=
 =?utf-8?B?dmtTMWZwWkRHQTJibGl2SStjODNYWGpBK0J3VzhKYWpHRkdDYTVvQnUrdG04?=
 =?utf-8?B?akMxSlZMVU1KNS9HY3ZhTnFxaW41TVFOTFQxYk1LUFFSSW5KZVluOFNSL1Av?=
 =?utf-8?B?ZlBKRzBiQVhLY0xQZ3JwR1lYMHVjTUJzZUw3cCt4TFJnNWdmeG1FRGhTWWVp?=
 =?utf-8?B?dUU2NTlsbjdqWVRRVmZSMEpsSHpDYW9XTDBhOHhvUE5ZNGw4eTMvNWxJMWNS?=
 =?utf-8?B?MVBTR1l5UExBMktJS1lCY0pvUDN6YVYyK2FiWXdOMVdhaE9zV0hVdlNJaFFT?=
 =?utf-8?B?ZGFiRTRMem0yS21VTmFxaU52a1dtWXRyc0R5YmUwTEdyem1lRjhNekIvYnFY?=
 =?utf-8?B?N0dKTDNnY25SczVQek5EaXpKY0RLWnpTVkFWZzY2RTE5VmlldnhUZjFSdklw?=
 =?utf-8?B?bUVsK2Y0Q0NMVTNNRGIwTWdoT1ZHNzgzb2Urby9aMURMRUUveUpHdmIvdnlk?=
 =?utf-8?Q?XaQMpuUD9ms=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFN4N1hvQTh6TVFXTFBOWXN5S3YrL1lxUmtsWktmZytGWkJWMndhRnZPaDZP?=
 =?utf-8?B?NFZTSTUxbG96MVBxQW1lQzZybGVVWGVFQ1dKNisvR3dEMENTRTh1dDlkVTZZ?=
 =?utf-8?B?dUhrMzZXU0lVb01GcXhnMFhFVXFNRTlFajA5MjBsV1BzMlkyck5lWlN4Vmk4?=
 =?utf-8?B?eDA3d1F0YzBkK01NbVZPeHhkdXFvSkFEOUhRZ1JYK1gyNldPV2N5UjU4WkEv?=
 =?utf-8?B?UGNRcW92SUdkU0lRNk56WEhZT00vbUs4YTZlS2x2K0VMRXNXbU1MclpaMU5p?=
 =?utf-8?B?bnd6SWdlN2JFeENxNWZ3alRoS3A5RW1HUmZIMWJKdkgveVFZK3Q1QnFVT1Av?=
 =?utf-8?B?ZVI4VWRCY21rNDZjODZ6a1hOUzdCT2NEWXhRZW1kaFcvSUl3a0t1TFBudGNn?=
 =?utf-8?B?bTlWbDRCVk5zMHNXZnFPWjRkQzhVZUdxSHpyNDdlWGU1R3U0TVFVWjJWMTBa?=
 =?utf-8?B?L2xNSE9Pb1l5MytZaGdkdjQrRTdiY3Q1R293KzA4K25rbXFDeWt3WjdNRXlr?=
 =?utf-8?B?SWxiTjNJMVR4TnRqWUdWSGcwcmtacTJKaHNTZDlTcEttZUMzWmFJdDVTMm0z?=
 =?utf-8?B?Um1mOUdHYnc4VndGVzFVSEliMWJpZWQzcnd2WnUwMEN2a2NGL0xuZHZ2bW10?=
 =?utf-8?B?N1BsM0pCUkdta2VtK0JKY3ZGaWEzeWpqaFJQS3VyTzVmZVg4QW1SUVdQMUJT?=
 =?utf-8?B?ODhHWHlmbmFpczFlMFRib0RPUnE4ZElLak1uTW84ZVl2MFYxMm9YcmR0TFN4?=
 =?utf-8?B?SWF1MVdkUkVLUkFCU2hUMFVmQ0pFcnNDQnl4Vlc1Y0k3SFRiZmdQUEpQS2tE?=
 =?utf-8?B?Yi9aR3ZHcHhTaHA1MTNSekZNbzRZNFdNUCtrZ2FuTlR4bGxqd2pBN054NEpS?=
 =?utf-8?B?Q3lZcnl0NEYrRXR2dkxVYVB2bFM4SStiZUxQWm9KejlqaCtNeG9vSmVTdVlR?=
 =?utf-8?B?MWtYcHhtbDhITjRHSnNWajhFWWRLdjlrK3NZZ1VwNUdvL3VoajgrVGQzNnNG?=
 =?utf-8?B?S21wczMrVyt5SDNER1h2dGtheE5YYnBTb0ZVUVJRWG9pRlVJR0tFUHlpUllx?=
 =?utf-8?B?VXR5ZlMraWVpR3FhSmZQcFZhcHROYTM4aDRPc0xBbm0zWDRLY2FxVG5rd2xT?=
 =?utf-8?B?RitMV1BtVWtSMTkvTCt4dkFKcWJMRUxwckN3TDMwS1VrVllmczMzUnQ0MkdF?=
 =?utf-8?B?c1ZaRDB3ZTZqZ1pqeEtLbHhqZENWTzZ4cGpMb3UzOVhMOWZPaHBnQk8vbEVN?=
 =?utf-8?B?TTZZTmdUOUN4UG83N2c1OHMxdDN2dzZsd044cXFDbVZtTnQ2aUh6aVFXc1Jj?=
 =?utf-8?B?amo0Nzd0Z0ZqWkFsT25kd3BOUlpsbXpZL2VXeW8xM2FkTVhnNldQS3RpaTBm?=
 =?utf-8?B?U0ZNZmZuV2hsV0tTS2NDTFd3RHhHZEpqdWxraytFb3lLbjdHT0FIMU14bE5u?=
 =?utf-8?B?M0Zaclg2QnVzbDJnNy8xcTExUDczNjc3WTJWZmZYVkdjdzZtU3BvcEtlM0ln?=
 =?utf-8?B?dHV2THFKYytQZ2l4TVFWbEhvblNGbHo4YloycnNxNEd5S0lRR3dSZTVaeE9U?=
 =?utf-8?B?cUF4WGJXODlheVF1VDMyQUp3a3dkNDdibGhVS1YrUUVDQ0ZQSEtFMVI1QjNF?=
 =?utf-8?B?czMwakJFTVllQmVYd2tqNHpDMnJqVHRhM0ptZFZvZUJKckpoMUxjRjE4Rmcx?=
 =?utf-8?B?clB1bDZucHU0Vkh5QzdwY0V1WUJFYldrSlU3WmIweTlqeHFWd0FLVXh1WEQ4?=
 =?utf-8?B?Z2NJa0t4K2F2OFpPZ2JyU3E5dHRGT1FGQ1BDWlZTOW9WV054d09ZZVlnS3Aw?=
 =?utf-8?B?UEhvSytJQ0R0ekdtYUVTbU5ZUE5Vd01zOThuVWhYeGxMNXJETWpFbE9uc1hu?=
 =?utf-8?B?SjdNR1NMYUZZRWkrSjJoMXZVOVdrQzR1eHRlUzIvdlE1Qm0zR0l0TmRqeXNm?=
 =?utf-8?B?Y3NteE9OMGZvTWxjN3Yzd045TDlIQlQwR1BXREt2cTUxY1NrQ09JQW9NZWhv?=
 =?utf-8?B?V1hNaGpuRXJvdWpjUTlEL1JnUUpYVElOc1p4RDRHaEVhOE5HSjNrZWpTRmVF?=
 =?utf-8?B?L1JuTHp2d3VkU2dwc1JpZ3RJdGs5K0xOM282MzNxM1RiVlFZdlpQUm9Pcmcz?=
 =?utf-8?Q?O0co=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7b85006-830d-4267-683c-08ddaf8cc701
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2025 23:55:32.5494 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3847HjAtM3kevSKwXQJ6rZ0ora3asHbBTXDcegOF9HeL24R2zHngvVDZDo3hlnCzi7X/tjsqmO/Uuhgarzuyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6919
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIDEvNV0gaW14OG1wOiBldms6IEFkZCBzdXBwb3J0IGZvciBj
YXBzdWxlIHVwZGF0ZQ0KPiANCj4gT24gVGh1LCBKdW4gMTksIDIwMjUgYXQgNjoxM+KAr0FNIFBl
bmcgRmFuIChPU1MpDQo+IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiA+IERlZmluZSBpbWFnZSBh
cnJheSBhbmQgR1VJRA0KPiA+IFNlbGVjdCBjb25maWdzIGZvciBFRkkgQ2Fwc3VsZSB1cGRhdGUN
Cj4gDQo+IFBsZWFzZSBpbXByb3ZlIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IFdoYXQgaXMg
dGhlIG1vdGl2YXRpb24gZm9yIGFkZGluZyBzdXBwb3J0IGZvciBjYXBzdWxlIHVwZGF0ZT8NCg0K
VG8gc3VwcG9ydCBBUk0gU3lzdGVtIFJlYWR5LiBBUk0gc3lzdGVtIHJlYWR5IHJlcXVpcmVzDQpj
YXBzdWxlIHVwZGF0ZS4gDQoNCj4gDQo+IFdoeSBpcyBpdCB1c2VmdWw/IEhvdyBjYW4gdGhpcyBm
ZWF0dXJlIGJlIHVzZWQ/DQoNCkNhcHN1bGUgdXBkYXRlIGlzIEVGSSBiYXNlZCBmaXJtd2FyZSB1
cGRhdGUgIHdoaWNoIGlzIHdpZGVseQ0KdXNlZCBpbiB2YXJpb3VzIGRpc3RyaWJ1dGlvbnMuIFRv
IHRlc3QgdGhpcyBmZWF0dXJlIGluIFUtQm9vdCwNCnNlZQ0KaHR0cHM6Ly9kb2NzLnUtYm9vdC5v
cmcvZW4vc3RhYmxlL2RldmVsb3AvdWVmaS91ZWZpLmh0bWwNCg0KSSB3aWxsIHB1dCBpbiBjb21t
aXQgbG9nIGluIFYyLg0KDQpUaGFua3MsDQpQZW5nDQo=
