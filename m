Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E36EC02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 08:24:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A28B8069D;
	Fri, 17 Jan 2025 09:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="naX6ofKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 18135806D8; Fri, 17 Jan 2025 09:24:52 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20719.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::719])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE5C780312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 09:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jI6s3Pln5yc6rZMGZL7OTVVYI0ASBr+DaegFNjAf7PgUfezZJWX5xF5WFfeR/O411Fj5VjwAOCfX6xDmkqvF9dxJyB6AeC0SlR7/fGkvH50FQoq4Yl2Z9KmA7EVbc63Egxe0PJQjYkRmBErP/eqycmaeMmyjZS3ynMrlxD8jh7D3CX3mfo6kNWUw3k/fDRd5P39xPcknpWw+3SCyLXj1QQ5ZGcmK5/fX6rqxmq7ODKw/M6RHhzoSWnFs4c596imcNJsSTa0cyQcXqabT7phzMUvXaTzpKWb3RShi9lQzjHCA2Er2XtIX3rz7AsRY62w314GYCFOVPJsnw9FfrdFYxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/fTCwqprXKOCfx/dLIy3wjHTVEJIP2pEkn+L0JNo7U=;
 b=B2ZhZbZ7ONK5hX2LcMl865+LztxnrHIgMtTvGpqmdbgELDlXMWl+ohcaEXwdRFtb1eTYH1Jfk44vx3ugj4i6wYGElpp78IGkNsNuOQxanovPTF3W8Q2LhyOjXqiE0bKj7dfNoG6BXqVm1y2dhmd0Ag/5WLBfCe/UW0aUXSJ55N/7fs1NQ6BWyUli/m2Ys4ptZqiLxNTGJ7m2qWGNJZJ+40HVaFeeiuoI5TawJhMuF3U5LZjAIxMR6PkSkDyC5HsB6O0MIqd5qt4x0StKwwimS4MfMxH5sSDvN2zcNUcmYfGXPU+8Onhpyc6Nn84EOVBQFQdHK5n0Nt5XSUfZoy0czQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/fTCwqprXKOCfx/dLIy3wjHTVEJIP2pEkn+L0JNo7U=;
 b=naX6ofKwt71rX3eJgjrK/TLV31iZP0hGrCWQmxKRLLkFux2NBWFUVMtWyBMbpXFwx1I6uFF5r78jgmFc+yleqofpkDIefWrLo1h2YpGvPx+mmE9hUxuOZqlfWXATg4XyJYUrW2wpVRWDVDgzWx6eDLDPiGOEYG+2ugpq33kE8lJIALSAGxZjMKOxye0m9rMUKdnZrDl275o2EEGaPckNDgZpLJ0UmNhV8HwxIjkCzoqJ/Er080kykpFwbDctiVwB4yHdd9HX57Bg8S95gkHkIy2S7IYPouBl6ZuWmu451hdZkD43jM5zeo7F8PZIVSYVu2JSjonSK+zO48q87aWrJg==
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM (2603:10a6:208:b4::32)
 by PR3P195MB0554.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 08:24:48 +0000
Received: from AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f]) by AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
 ([fe80::3f8f:9315:c279:d35f%4]) with mapi id 15.20.8335.011; Fri, 17 Jan 2025
 08:24:47 +0000
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>, "marex@denx.de"
 <marex@denx.de>, "festevam@denx.de" <festevam@denx.de>
Subject: Re: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
Thread-Topic: [PATCH v2] imx8m: Guard binman nodes with CONFIG_OPTEE
Thread-Index: AQHbaIMuz2mrP9Y+CEeOUab6MRvuW7MaoYOA
Date: Fri, 17 Jan 2025 08:24:47 +0000
Message-ID: <efbbd217c00ec775fb7c2a7a0da18a4b5ee0e39a.camel@phytec.de>
References: <20250117015642.2373824-1-festevam@gmail.com>
In-Reply-To: <20250117015642.2373824-1-festevam@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0P195MB0386:EE_|PR3P195MB0554:EE_
x-ms-office365-filtering-correlation-id: d84c263b-1fff-4ace-4041-08dd36d067d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?eGZCRDE3K3l1ajZabHlCd1JHcHp2SVZRZVoyYVBoVXo3N3pMbFNRcWZGT1cw?=
 =?utf-8?B?Ti82bUpMMmFQRVptaytnWHR4Q245eDl3THkzQXRacXJVTDhkeXVYZFlQRW16?=
 =?utf-8?B?Z0U0V1Q0dTBCWEZxNzZsM2RaR05lYzBDYkpaYUw0Y3FTMnR0cFM1em1LRGN6?=
 =?utf-8?B?NjNWUHZnaFU1RHV3eUJMSHdiaC80STVkLzJWUmd3ajRRMzJMQWpuOHBNSEpW?=
 =?utf-8?B?elNPak5RUEVaV2piNFZuK2k1QTNJUmFLNWZ2VHBYTkREd0hXT0o5Rm5EMFVP?=
 =?utf-8?B?TkVqTmQzQ3k0aFYxMnlrNm5LaDN5WU9NN2FOMXZHL2dXMjBHZlRLTTF4bzIv?=
 =?utf-8?B?eC9ZcTNJOUdqa0lxL243VkdneXpTWUxIU2pmbFhTNmVnQkpSL1hIeU1MZklE?=
 =?utf-8?B?dlpNbEc5bk5vSzY2bUlWY1lOWGpnTElpRHAzd09oRXFQSkIySmplMkVzL3Bi?=
 =?utf-8?B?elRaL3NTVGEyUjVLNTdvMTRtVWdPZlAyZ0ZHcVVBQWF3SDFBMkxybkhlbUxl?=
 =?utf-8?B?SmVmMXpSbGYvZ3FNUVRxTnBtYTJIdG1tRFVHZVlJMmVHaDFjQU1sUHFYb2lw?=
 =?utf-8?B?ZmRFNE9jWU9WajhveXhxSGhoL2JVZW5mTWJIN3BnRFlSNEZzendZNXRtT1or?=
 =?utf-8?B?Y0h0TTQrQ0xWc09FSUdTMWdHeHRrNGZmQkJWeGgxNGl2QVBYTHBLNzhDTFRV?=
 =?utf-8?B?MmlZTlN1ZXlRWFczdnJVcG9HenlQd3lCWitvdnVPNFdPY0pIK0tPd3ZpRTZO?=
 =?utf-8?B?VFE1a1NlN0o2bzM3dCtVL2dOTzBXbFlGbkdhSDV0T0NITFEwWm4rOEo3aERp?=
 =?utf-8?B?S0pVM0xDTGg0MGJ2QTVBY2tpYnl4cEJ3dUZYZXBWVnFPdmdCcSsvUktDWTZV?=
 =?utf-8?B?QTVyVkZYVCtHWEtIc3lBUmpNMnAzZDRjeXg2TmdHd1RSUUx2bE5RNVpYdGRn?=
 =?utf-8?B?THR0dlFYc2tDd0Zxdkh6NU9kQWdNaFFBN3NDditqNE8zMmV5TlJEa1JidjFJ?=
 =?utf-8?B?T1JjbHV4SnJZOXBMOS9TYTdpc01SZGI5dStxNmFtS0VMS0dsRTFGU1g3b2Zw?=
 =?utf-8?B?eEMvWk5naVVyVjRzK3BOM3duSERzMG43ek15QldxL0tuYjZGQVM1VkhnZjhq?=
 =?utf-8?B?SHdiR2hLYmx5bkhZeUYxQkw0WW1WMkhsMnZ1Y0QvaU9aQTJPVDgwTnhLMnJ0?=
 =?utf-8?B?enNJbm95Yjh1cmluVHZLbGhjUCtpQWp6VGV0NWlDWGhCNVlmTTJNSThQM3Nj?=
 =?utf-8?B?eGJNNGErNzJjejQ2R0pSMzVJaFYvdGZFODlHK3ZnVFlQVmFiaWsvQlNZQzMr?=
 =?utf-8?B?TlFNTEtYSHBwaWFKejgyWm4rZVVkVFFja2hYTCtuUEt5VU5YcjV4RnY3WDZl?=
 =?utf-8?B?ME5DVjFycjgycDZtNmJxR3BPanEreUdpcTNNYW9zMGwzRi80ZTB0S3E1SjNF?=
 =?utf-8?B?VFlETlNtbmViZXdTWjhuRWFsNndkWUxCRzhQQXlvZVFIUU9jd3EzVlVMRkdi?=
 =?utf-8?B?TS93eURKbktrbTZhVDJhRTdFWVcvVittSHE5dVhpTFBYKzVRbkpMbXE1a2xy?=
 =?utf-8?B?eEdwMSt3aGh5c1NzaFFsVzdRVGxML0VGbWZkMnlKYmVGZ2Q3UU5CbmdCcGlr?=
 =?utf-8?B?LzJPbFVXbE04ZE9IbDVIbWhIaHBxbnVIN1ZPSC9JcTRUK1VUbHVLU0J0Q092?=
 =?utf-8?B?VjJ6b0tvRFBOdUtDTGh2RkZDaDFOdld6dWo2VVpGSXV4WXQxU2g3ZWhmNVB2?=
 =?utf-8?B?eDlOUmdyaUhTOUpNL294QXlKS3V2Q0x5SWc4TDM4dHR4NHAyU2dDZEF2NGFF?=
 =?utf-8?B?N2hWU1NoVGdoeE04alBGZHl2c2dMT1pGLzAvOGZxNkhuY00wVXpoK0Y2STE3?=
 =?utf-8?B?b2xoalZzU3RoZXc1bE15TzhTYVVMWkZqVkp1UG5RaXg2Q1BUdi84eGxGRnBI?=
 =?utf-8?Q?DWp2qka/6yDhSaVS9oscR/dFIerFGqg4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM0P195MB0386.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhJSG91ZGNjZG04MW5PcFM5emhWN0c3aE5VMStMblVlUE01cVZqMVN3c3hR?=
 =?utf-8?B?UzRkSFE0NWZqM0FtdFYyNnE4OE9NdTdDRmIxa0Q2UVhBVHZQZTAxQmJ2U25V?=
 =?utf-8?B?TFdHMnlZckFQYVE0QWUxT0Vsb0J0QmpXWTh3N1dkbkpZZ3hVZ2xsOHgxNWU5?=
 =?utf-8?B?SWJLQjRaWVRHdkdNL3h1aFFtTDFwdW1MV0x0MzZhNHAxWXpYU004bGFRdkJz?=
 =?utf-8?B?OTI1dDR4WUlhdmxkeXFQTW4zQXl1MkhPKzAyM21sWjNmdzFIVDFRWVVRRXNP?=
 =?utf-8?B?U2Y3cjZFZ2xwYzJKV05iQzMxZDBhc0ZtbTF5d2lzdG5UWUM4V1N5M04wVktx?=
 =?utf-8?B?Y1BScXEwdlhhVHFRL28yWUZYekVyTWVMRXp6S0g0anlIdmg5V1lDeHdOODdB?=
 =?utf-8?B?VWpWWEVWWXUvYkJ6OEtBd0ZOLzhZL0c0RnVOcmZ5ekI1a01qUzRSRWdrSlVB?=
 =?utf-8?B?UWtKa1VjWjEzKzhXMEJSZWlwZzBsdllKSklIb3JobmFtcXQxUThyK1d5YVdU?=
 =?utf-8?B?SVR1K1d0a3F1OTVKWUNRTXVUZURUTC9uV3dzMGhTanM5WWVqNU56T1BURFNZ?=
 =?utf-8?B?U1JHMVVXYXNRSDdHMzNUVldLemJDdHVCVWFxY1ZRcVZEYmZrWHlpQmIxQ3J4?=
 =?utf-8?B?SzNBUitvZkJHeS9MS0dFWEhvcWZaN2dXdi8xZUNsN2IrWTZUNDdMdWZNNHBF?=
 =?utf-8?B?V2s4T3FyNm5uRmV1TnVPaUFHd3dyb2Z4dmJ5NFczOVpZbC94dFVabyswMUYv?=
 =?utf-8?B?WDJXYk5BUkdNQlpIb3hjR0I4RlpydFdSU3VWeFh5NE1KQ0s1dll4dGFFMlNJ?=
 =?utf-8?B?RDZnQXJRenVlb1FMb20wTUVWY056WCtRcjVxWWFvQWp5UGQ2c1kzY3hNNUJ2?=
 =?utf-8?B?ckh4TTlGT1FrTzFLUGVkd3h5RDl6VzRER21pT3JjRDdZdnM4b3gvMVdkZzdS?=
 =?utf-8?B?RWt1ZFM2VXZwWm0yR0d6Qzd0djdvd1Y2QWVQT00vMWU2N0xPQWJlVkgrc01C?=
 =?utf-8?B?YkJhREpWcEdYOVMvMjV2d3dFN2FRK1ZEVFY1Z3daZUt4cmZ2VTZJcjRQemN6?=
 =?utf-8?B?MUlMb1NDMmtmVldSeFNVc0tjS1RqT0tNNUVDZytkbWFYL1dOU2drSERmdDlQ?=
 =?utf-8?B?anRTbmhPdWI5RWMrSWQ5UnV6U3ZvTnZDc1lOT3dWZk5zODJKeWZac3F5ekR4?=
 =?utf-8?B?MkNPMzE5ck5CWWJLN1FWOWxIQkRPT29OU0FOelBWUEI5eHlKNUg2aC9CK1E2?=
 =?utf-8?B?MC95TTJ4Ykh4Uzk5NWJwV2crc0x2R0dYSHNUeEVRS3FvVUs2R3g5cmRkK3lS?=
 =?utf-8?B?dmtxbXRtWDBUMWdGR0JLRExRY0FuODdRNElqMVE1SVF1V2ROVUQzcjdUcGFP?=
 =?utf-8?B?bjVjTm8wempVZGhidXZqNDBZRy85REdhRVBLcFJGWTlIR2UwTmJSK1ExamhV?=
 =?utf-8?B?RmF5QVc3Q2ZDNVBVSnl4ZTQza1J2dEdIdjdUaTI1VXVkbkZCeDhwek5VVVBy?=
 =?utf-8?B?WEtaZWFLdlNLcFhqYk01Ukw1MUd0TC9yaUdXWEc0Yk1uL0pBQTBMYUVtWlhQ?=
 =?utf-8?B?QVA1a2R1bXhUZDVsaUp3MHZFYldXcFkrd0wycS9vV1hWc1JuVHlWcmQ3MFNW?=
 =?utf-8?B?WGREYm85anZzUm1DVlZzbXI4NE0yVERIZDlxTkNjZU1DZ0d5dFBONHh6ZU9V?=
 =?utf-8?B?S3lodjZSSDRzb2JpWEZWYUZhTGFwT2R4VGsvZHFmS3NSdXZhamR3YzNIOE92?=
 =?utf-8?B?RDhCZjUvRUZyVWNEdjNKWmtPREx3anZzMFYvQk1mRWFUTWRjY1dtR1lLU0pJ?=
 =?utf-8?B?cmtJZDNrQVprRjU4RWpQSkNWZDZ0ZytUTTFyaUE3SDZPdnFQcm5xUmxtNU1k?=
 =?utf-8?B?QjdMc2l0dnkvT1NsSFVPVXFPMmpUSmphM2IzWllxTEEydXRPUmlPRUdBOG1Y?=
 =?utf-8?B?OTY2bDhqQTdkY1VUcDZzN0VYU3h1bzJORk15enVHb0FYSXZZMTRNdGdJak9p?=
 =?utf-8?B?SkJoZ2l2ZGVaTWx4M0dJbU53TXQyZDB3Y3l1L0puRDRsenNISlIzRnJtWk1L?=
 =?utf-8?B?OStHY3l5dUJGSHJGUmdJR0pTU2MxZzY1a3hPenhqK3ZidURHWWNMU1YyMXFv?=
 =?utf-8?Q?jx2jocbqPRPLf0l99gcOSie5W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <73D85B067B68404289191C2EA969AD1D@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0P195MB0386.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d84c263b-1fff-4ace-4041-08dd36d067d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 08:24:47.9097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r58z8oyJdIViLGYME+FOS1fOi/+mgR0OrCPhgsdR8fAm8idIJ5SfXORNjmv79sIMqxSjJ7rfpFC1RrpNxnvyiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0554
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

SGkgRmFiaW8sDQoNCk9uIFRodSwgMjAyNS0wMS0xNiBhdCAyMjo1NiAtMDMwMCwgRmFiaW8gRXN0
ZXZhbSB3cm90ZToNCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZGVueC5kZT4NCj4g
DQo+IEd1YXJkIGJpbm1hbiBub2RlcyB3aXRoIENPTkZJR19PUFRFRSB0byBmaXggdGhlIGZvbGxv
d2luZyBlcnJvcg0KPiB3aGVuIGJ1aWxkaW5nIHdpdGhvdXQgb3B0ZWUgc3VwcG9ydDoNCj4gDQo+
IMKgIEJJTk1BTsKgIC5iaW5tYW5fc3RhbXANCj4gSW1hZ2UgJ2ltYWdlJyBoYXMgZmFrZWQgZXh0
ZXJuYWwgYmxvYnMgYW5kIGlzIG5vbi1mdW5jdGlvbmFsOiB0ZWUuYmluDQo+IA0KPiBJbWFnZSAn
aW1hZ2UnIGlzIG1pc3Npbmcgb3B0aW9uYWwgZXh0ZXJuYWwgYmxvYnMgYnV0IGlzIHN0aWxsIGZ1
bmN0aW9uYWw6IHRlZS1vcw0KPiANCj4gL2Jpbm1hbi9zZWN0aW9uL2ZpdC9pbWFnZXMvdGVlL3Rl
ZS1vcyAodGVlLmJpbik6DQo+IMKgwqAgU2VlIHRoZSBkb2N1bWVudGF0aW9uIGZvciB5b3VyIGJv
YXJkLiBZb3UgbWF5IG5lZWQgdG8gYnVpbGQgT3BlbiBQb3J0YWJsZQ0KPiDCoMKgIFRydXN0ZWQg
RXhlY3V0aW9uIEVudmlyb25tZW50IChPUC1URUUpIGFuZCBidWlsZCB3aXRoIFRFRT0vcGF0aC90
by90ZWUuYmluDQo+IA0KPiBTb21lIGltYWdlcyBhcmUgaW52YWxpZA0KPiBtYWtlOiAqKiogW01h
a2VmaWxlOjExMzU6IC5iaW5tYW5fc3RhbXBdIEVycm9yIDEwMw0KPiANCj4gV2hpbGUgYXQgaXQs
IG9ubHkgcGFzcyB0ZWUgdG8gdGhlIGxvYWRhYmxlcyBsaW5lcyB3aGVuIENPTkZJR19PUFRFRSBp
cw0KPiBkZWZpbmVkLg0KPiANCj4gUmVwb3J0ZWQtYnk6IFRpbSBIYXJ2ZXkgPHRoYXJ2ZXlAZ2F0
ZXdvcmtzLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogRmFiaW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZGVu
eC5kZT4NCj4gUmV2aWV3ZWQtYnk6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQpUZXN0
ZWQtYnk6IFlhbm5pYyBNb29nIDx5Lm1vb2dAcGh5dGVjLmRlPg0KDQpUZXN0ZWQgb24gcGh5Y29y
ZS1pbXg4bXAuDQoNClRoaXMgcGF0Y2ggZG9lcyBzb2x2ZSB0aGUgcHJvYmxlbSBhcyByZXBvcnRl
ZCBieSBUaW0uDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uOg0KU2luY2UgdGVlLmJpbiBpcyBtYXJrZWQg
YXMgb3B0aW9uYWwsIHdlIHN0aWxsIGdldCB0aGUgc2FtZSBiZWhhdmlvdXIgd2hlbiBPUFRFRSBp
cyBzZXQgYnV0IG5vDQp0ZWUuYmluIGlzIHN1cHBsaWVkLg0KV2hhdCBkbyB5b3Ugc3VnZ2VzdCB0
byBkbyB0byByZW1lZHkgdGhpcz8NCg0KV2UgY291bGQgcmVtb3ZlIHRoZSBvcHRpb25hbC4gR2l2
ZW4gdGhhdCB3ZSBndWFyZCBpdCB3aXRoIENPTkZJR19PUFRFRSBpdCBtYWtlcyBzZW5zZSB0aGF0
IHRoZSB0ZWUNCmJpbmFyeSBtdXN0IHRoZW4gYmUgc3VwcGxpZWQgYW5kIHNob3VsZCBubyBsb25n
ZXIgYmUgY29uc2lkZXJlZCBvcHRpb25hbC4NCg0KT24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQg
Zml4IHRoZSBidWlsZCBlcnJvciB3aGVuIGl0IGlzIG1hcmtlZCBhcyBvcHRpb25hbCBhbmQgbm90
IHByZXNlbnQuIFRoaXMNCmNvdWxkIGFsbG93IHVzIHRvIHJlbW92ZSB0aGUgZ3VhcmQgaW50cm9k
dWNlZCBoZXJlLiANCg0KRnVydGhlciwgd2UgY291bGQgY29tYmluZSB0aGVzZSB0d28gaWRlYXMg
YW5kIGFkZCBhIGd1YXJkIHRoYXQgcmVxdWlyZXMgdGVlLmJpbiB3aGVuIENPTkZJR19PUFRFRSBp
cw0Kc2V0IGFuZCBtYXJrcyBpdCBhcyBvcHRpb25hbCB3aGVuIENPTkZJR19PUFRFRSBpcyBub3Qg
c2V0IGxpa2Ugc28NCg0KDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHRlZTogdGVlIHsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBkZXNjcmlwdGlvbiA9ICJPUC1URUUiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHR5cGUgPSAidGVlIjsNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhcmNoID0gImFybTY0IjsNCiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb21wcmVzc2lvbiA9ICJub25l
IjsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvcyA9
ICJ0ZWUiOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGxvYWQgPSA8Q09ORklHX0lNWDhNX09QVEVFX0xPQURfQUREUj47DQogICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW50cnkgPSA8Q09ORklHX0lNWDhNX09Q
VEVFX0xPQURfQUREUj47DQoNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB0ZWUtb3Mgew0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgZmlsZW5hbWUgPSAidGVlLmJpbiI7DQojaWZuZGVmIENPTkZJ
R19PUFRFRQ0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgb3B0aW9uYWw7DQojZW5kaWYNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB9Ow0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB9Ow0KDQpZYW5uaWMNCg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gLSBB
bHNvIGd1YXJkIHRoZSBsb2FkYWJsZXMgbGluZS4gKFRpbSkNCj4gDQo+IMKgYXJjaC9hcm0vZHRz
L2lteDhtbS11LWJvb3QuZHRzaSB8IDYgKysrKysrDQo+IMKgYXJjaC9hcm0vZHRzL2lteDhtbi11
LWJvb3QuZHRzaSB8IDYgKysrKysrDQo+IMKgYXJjaC9hcm0vZHRzL2lteDhtcC11LWJvb3QuZHRz
aSB8IDYgKysrKysrDQo+IMKgYXJjaC9hcm0vZHRzL2lteDhtcS11LWJvb3QuZHRzaSB8IDYgKysr
KysrDQo+IMKgNCBmaWxlcyBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vZHRzL2lteDhtbS11LWJvb3QuZHRzaSBiL2FyY2gvYXJtL2R0cy9pbXg4
bW0tdS1ib290LmR0c2kNCj4gaW5kZXggZWNjMjMxOTI3OWVhLi44NjA4ZmEwMDRmZGMgMTAwNjQ0
DQo+IC0tLSBhL2FyY2gvYXJtL2R0cy9pbXg4bW0tdS1ib290LmR0c2kNCj4gKysrIGIvYXJjaC9h
cm0vZHRzL2lteDhtbS11LWJvb3QuZHRzaQ0KPiBAQCAtMTY0LDYgKzE2NCw3IEBADQo+IMKgCQkJ
CQl9Ow0KPiDCoCNlbmRpZg0KPiDCoA0KPiArI2lmZGVmIENPTkZJR19PUFRFRQ0KPiDCoAkJCQkJ
dGVlOiB0ZWUgew0KPiDCoAkJCQkJCWRlc2NyaXB0aW9uID0gIk9QLVRFRSI7DQo+IMKgCQkJCQkJ
dHlwZSA9ICJ0ZWUiOw0KPiBAQCAtMTc4LDYgKzE3OSw3IEBADQo+IMKgCQkJCQkJCW9wdGlvbmFs
Ow0KPiDCoAkJCQkJCX07DQo+IMKgCQkJCQl9Ow0KPiArI2VuZGlmDQo+IMKgDQo+IMKgCQkJCQli
aW5tYW5fZmlwOiBmaXAgew0KPiDCoAkJCQkJCWFyY2ggPSAiYXJtNjQiOw0KPiBAQCAtMjA3LDcg
KzIwOSwxMSBAQA0KPiDCoAkJCQkJCWZkdCA9ICJmZHQtU0VRIjsNCj4gwqAJCQkJCQlmaXJtd2Fy
ZSA9ICJ1Ym9vdCI7DQo+IMKgI2lmbmRlZiBDT05GSUdfQVJNVjhfUFNDSQ0KPiArI2lmZGVmIENP
TkZJR19PUFRFRQ0KPiDCoAkJCQkJCWxvYWRhYmxlcyA9ICJhdGYiLCAidGVlIjsNCj4gKyNlbHNl
DQo+ICsJCQkJCQlsb2FkYWJsZXMgPSAiYXRmIjsNCj4gKyNlbmRpZg0KPiDCoCNlbmRpZg0KPiDC
oAkJCQkJfTsNCj4gwqAJCQkJfTsNCj4gDQoNClsuLi5dDQoNCg==
