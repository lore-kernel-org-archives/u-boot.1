Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C631ACEFC21
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:02:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C61A88995;
	Tue,  8 Oct 2024 17:02:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="E+nr53lG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0832C88D39; Tue,  8 Oct 2024 17:01:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5FAC880E6
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:01:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU5NtQxDVzK3mCzNukNkgRM3w3Z6HyPDNWTNuGXiQmZgSEQInunpjTLg+py9tPGC/rzbQRjs5yf+CoUTjfiy9zEVgef4E+sleP9JHe+uiSEH1ZKYTNH7k1DK2xrNVsSTZ4HOQpJAfQeDPF+2d0rsBf+uZ2YGsPJLarb2reNpGLYKE+EAlH9XK34Ols76/He/fKfC8YiEJxB//r8ZDGsxJ4lP+3geZJVrSlwQm0phSopSTyDsH9eD/JgCG/4uRKjm/anTwiMsjBAAEpKY1c2XEtQMX29wHNXbi9z0nE7oK9xN5i/9uj/op94Y6/9+VNFXWTYEU9LgXvXdcJXcmON77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8h0j+exanlg01KPwZ0gLFtaQYZWSX6AopG2rSIWR+tg=;
 b=fkZJTGT1V7b0Sx8IlEiz5xm8FtN1ppswWQ2OrB+o4p7xdz7MfR50v/2lk5nT2mCZKfkHNoN/lvyHmhd9WpeM+htnF5pE5z+KhHLRhLR//NFcqrkOrktpsWBV++NxKIRq+qNdHNtd+sg3NbpsBbqfzcKBJPCchRU3OAw1V7OdIeLf88sI2Hzw/vuLKM5TYnV3P1CMzMHzum0pFLyW0d4FtP5Rxnh3AqE4WcCH0X/rIObYdL+3UywIWtsqiSkgTayJswq/o3a/XxXvUFoGs94BX/K/bRfv5UQ6L0wLS4rcxIeKHK363u/jjy9EXPGBgVAYZa9lhelidlpbUN1tXD1TYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8h0j+exanlg01KPwZ0gLFtaQYZWSX6AopG2rSIWR+tg=;
 b=E+nr53lGDJbLTpyu2o0LEYEQ4LioJm/Yua6F94+fa43Y9n07UV4oxrScXwK0Fz3IKqToKBZROGBXsjr8coWBjPEqdcbIc66E/0IZ31BGaBEqBU8hd8Muk0F+K4wMl6kS2gfkNm2YZ5kRoTeCbI/a3aHMyRR9SiSdEOL5ebLpOH4RZWQnN1MDvhiB9aV8686GM9MWgv3vgK5cWCp+Mcy9kYJS0uL8gsaRT/+S2Ovpd8OncBk9ntCrY6/awdYUCZeW0/MFwWK/Y0I9N38Rn9clL0Emc8xZAMXZOoOejvgu6BUarTcXxbGVHfa+nT+4mY7vxhWcFmVtuCwNaOQAjQhQIQ==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI2PR04MB10883.eurprd04.prod.outlook.com (2603:10a6:800:27f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Tue, 8 Oct
 2024 15:01:55 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 15:01:55 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "sbabic@denx.de" <sbabic@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, dl-uboot-imx <uboot-imx@nxp.com>, Tom Rini
 <trini@konsulko.com>
Subject: RE: [PATCH] imx8: Correct the SCU API return value check
Thread-Topic: [PATCH] imx8: Correct the SCU API return value check
Thread-Index: AQHbF4Lrn/WgZqCdzk+y9wNLLOK7OrJ89XOAgAABNjA=
Date: Tue, 8 Oct 2024 15:01:54 +0000
Message-ID: <PAXPR04MB845933A05D034E994CDB6E3F887E2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241006010522.20841-1-peng.fan@oss.nxp.com>
 <CAOMZO5BPoiyicMANp5Y7283_FOhgz7SMeQoLFx=xf2XWNm-1Yw@mail.gmail.com>
In-Reply-To: <CAOMZO5BPoiyicMANp5Y7283_FOhgz7SMeQoLFx=xf2XWNm-1Yw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI2PR04MB10883:EE_
x-ms-office365-filtering-correlation-id: f2015c4b-d74d-4a00-145f-08dce7aa261f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dERucnVkbWlISkdkRFBqazR3bEgzamxuWFJyWUc5K01LQVFCSG5Hb2FOU00x?=
 =?utf-8?B?OEk0TGJVVFQzcUQzbVZWcXFpdnJaTFBSckZIMUxvVTN0aXBUbG41V2FZbEFl?=
 =?utf-8?B?RUdJbGFHOVJ2K3RySTF1aGNETTNPbXNiRktmUEVQM3d5c3pnbW9JZHY4Y21q?=
 =?utf-8?B?cWpCNWE1djFCd255c011ZnAyOTFJK25XUEFRTTRpU3VMeU44RGJhV1JqLzdj?=
 =?utf-8?B?S0h1SFBkcnVKTzZXaXZvbG5SUlBjMVYvTkZVWDczcGN6b2VnSExGZHYzVDh6?=
 =?utf-8?B?U2Z6ZFlBandaS21oTU96OUJqRjJJWVNsTlU2MjZzSXVuZTdmSEsrMHZMeVRJ?=
 =?utf-8?B?a0pGbXVzZkRER2Y0c1VWcndvd2IydDRQbnIya3V2STEvaWVIeGU1bjJNL2p5?=
 =?utf-8?B?N29mcEpTSFZJTGl4NDhEUWYxR3czRWRMMTkrR1pLM285NWhLZG1CeU1HNEVC?=
 =?utf-8?B?Nk1vTkJZb3lQS1RsaVlManFOY3F4REo1aHJOSjlhTVJ3UHpPZmJaN0dXMXV3?=
 =?utf-8?B?RkdWZS9DOGJXYWQzalAxK21YcnNmTXFNVmxBaGFNZ1hQcTc0SlkrNlJIZGM2?=
 =?utf-8?B?QTk0T0pORzhYYWE4cHJZeGNjU2JSNG53dlRGcmZ3U29lSTNXam5lanJhdHZ4?=
 =?utf-8?B?d0NZeDZldGVYK2ZlS2gyTWpQY042b3NWT1lVOXg0cHUrK3lxQWJvendCclFn?=
 =?utf-8?B?aFlUS2E2amR2MFpQb251Z1J3dUVqdjY2c2FKN1ZCVEpMVm5ZSWdGRUtJbGxo?=
 =?utf-8?B?cGwzSCtBUUo2TVZ3ckNrNzN2ZThIaG1yVGx1OWRCM2grMk8yemZtWTluVlUv?=
 =?utf-8?B?dzhDaUlyTkhFMXRRWXI0NTZDeXEyV09iRWFhR3JPZWxRZy9JeUUxV21QclFG?=
 =?utf-8?B?M3hBM1NkUERuR3ZZL0trSHZodGhKNktuSStjTzRzZGtLV1QwU2ZHK2EwZjU5?=
 =?utf-8?B?eTMrMWh6bEc4cFFocG1CUnZIeUJ4S0hKdFlwdEZnVlBxTmlKOVJuS2dCU1J1?=
 =?utf-8?B?a3BHem1ZOWNNa1ByK0hsQmF0YTRNZnc2dnBhckFpT2xrdXh2Z3g5amQxa3Fv?=
 =?utf-8?B?ZGUzaDF2S250OVd0cnM4VXQ2MWxaYk55azY3R2tUa2ViR3FlRTdlUHJzSnlx?=
 =?utf-8?B?bXliZmR5ZzNtRHVkSERZQmZwZk9DUWdOUmluQ05GcWdRVGpIMEdNV1FseHBR?=
 =?utf-8?B?bjkxQ1JRTE5tb1NRdDdEV1Bqa0loWERYc3gxQWZLTFMreHhUWW9UV1FNV0hW?=
 =?utf-8?B?SEhQWGVvaWQ2VEI1eEFkNVV0S0swT20rQ0tqUU9WOFpWWTkxMmoyblJVMU8z?=
 =?utf-8?B?UDQ1eXZzSDRKVitOa3NQUTN5VHFjcXNXcFVVZ0VYQXNHaFBEcisvQVh5UHZF?=
 =?utf-8?B?TkVNbTZ3MGltNmU1VzZOZjluSktyblR4ZHlodDBqSkF6a21UUk1oWEtCMHZO?=
 =?utf-8?B?cTBOZVVXbVVKVnliNVNDMWZmZEc1VEl0czkzVTZlcVE4Y0Eyb0tyS2hwY2NG?=
 =?utf-8?B?OFcxdnhXVDRtQVVUWkVwU0xGNG45QitLSURKbU80dlloT21XK1VvSlM1eWFt?=
 =?utf-8?B?MHJ4YjRIbEE2TmhvZ05XUmh5djN5RkVHb2xKTHZ1cHkvL2M5bXpNb0d0SjhL?=
 =?utf-8?B?RnZBRnV6WkxkcENYKzcvd1JFODY5Rnc1UmVaMDJudHNuT0VDOHBWeDZadDdh?=
 =?utf-8?B?Tkw1TUxSOVV1SldJRzQ2TklITkZXMUF5aU9DT3dlanZnZjZMOGp4Y0tGdDh5?=
 =?utf-8?B?U3RzcVhPdlRDOU9PWUg3aUJoMEJXdHVNOFVLYWJUdXhVc3U4WFYzNzBoNjFo?=
 =?utf-8?B?RGg3TE03dG41YjJKQnVGQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGVDTXNBTE5ha0VwcUZHVWN6Zzh3QXg3UzRSNWpKWnpQbUI4TGkxNEg2bmE1?=
 =?utf-8?B?WmpqemVpS3hVWEEreHpPdllHUDZYdXNmeXJYOG5ma0M0TG50WG1tY3pEV09L?=
 =?utf-8?B?KzBvZEFRclRyMU5LenZmSGRyUlkweEU4dUZPMFROMUtOS3lUYjdxNFI1K0hX?=
 =?utf-8?B?a3QvaE1Yc2JtT1h6bU1TVnVteE1mdjRlRWZFSlBxUlI4TXB6K2JKV3ZMYzQz?=
 =?utf-8?B?Z3BKTDB0ZG5SbzJWNmo0UFB3LzV1bWNQUlArMEV4RXZ2Qk9MWDFWM29DREp0?=
 =?utf-8?B?aDRtdHgyUlcveEU1dlNOaHpIb21MaXJxN2t0VVlaaGg4RVZhWGd0QnMybXRM?=
 =?utf-8?B?ZFZqMkFKenpWRlhYdG1XL3hlaVRVMDE0V1ZTellGbnlZZEdFZzBpQkMreWE3?=
 =?utf-8?B?QnNPSzEvd0MvcmVzOHlDVXUvMVNwN2w5NHdYcTlDQ05UK2pCeXZscnlVRGxP?=
 =?utf-8?B?cnpyeHpjeGt4WG1Ea3ZXc1lJeG9oNjJKaUVWRWFJMERUNEp2ZkVhYXpmVkNt?=
 =?utf-8?B?Q2s3NlcxZk9QYmFkb042NkRnb2tRT0trNjBxOGFrSE5UMGhnS01JL1hld25V?=
 =?utf-8?B?UDRQRXA5aU9KdTZ3UENCbEdXYjBtM0lqcFZkRkdFQnNDTXNHUnNrNUlrTGxv?=
 =?utf-8?B?V2dmczFDVWZGUmxRaXRTN09jdHhXY0NVS2JiUFZ2SFFyelBYN2h5dVhxSlV3?=
 =?utf-8?B?ZWFPbzJFOHVGa1dCY09SbFBkWW0vck8vS1BTOUV3TXBFRHFpQTVWdGsvSDlK?=
 =?utf-8?B?WjYxVFNHWmdJcnBWRHRkaXRuM1lBaGZjQWVsb2s1UVpjV3BLRWNGRFBzeFpy?=
 =?utf-8?B?SW52MkZvM3FvK0hnb1ZWOU1TQURpa21xYXh6ZTZ5TldNQ1I2eEtQZjN3MDZC?=
 =?utf-8?B?Z1BPN0Jhcjd5NFl5ZDFMcWphS0I5bVlPc2VNYXI1aVlBREh6UU03U2R4eVRl?=
 =?utf-8?B?RDZvdy8zWVp6YUhjZ1JYRmY0dGdTa3BXREFYdVgrTnM3em5QRnlWU3JBbUVN?=
 =?utf-8?B?RUhETjhKSGNvMG80cFIwR3pNdUhBRXhpMEhJNTJTaFJnVjVjUlB5Z3gyNXZQ?=
 =?utf-8?B?aTJRbHBsQnRvai95VkJ4bkhRNmpZKzRFVEFFM29QMWw0aU1ub3drMHBraEVX?=
 =?utf-8?B?YklqQ1dMNkVxZVlOSUc3MFQ5dExRL0w5eUkzTjNmdTE1cU9WdzM2S29UK3ln?=
 =?utf-8?B?RXFNa3p4dlp2QjlkMlpoUGpBTFlZNEJzK1FIK25BdWdTNU1rcHBJcmZmeFJ0?=
 =?utf-8?B?OXB6R0F4cTdjK2gwQWd2ME1RRGJsZjFKam5SQWY0VTMxTCtmZElaMWNOTWZu?=
 =?utf-8?B?SFUxRFF2cFJQaTFUb3hoTjl4cjJzUlhTZkpBeDcvUklQM001VHN1eFNyamhP?=
 =?utf-8?B?SFV3c0ZqSmZXMFVVYjJDSmtpVVQzTEN5K2V4anVLeEgwRVlZNnRobVdIYjZ3?=
 =?utf-8?B?dXVHeVdtQ1g4SWN5UGJWZVlBOVBHa1pFVmhVMzBud0RwSWg5SHJIb0djTmV6?=
 =?utf-8?B?TVlYcWtiMmFvUnRaZkpQMlBpRE9kdHJ2dzd5RllySTRXMC9mZDRSbk1ZQjBC?=
 =?utf-8?B?NkJ3VGVzK082ZFk5V3p3b3VMTmtPL2Z0eUZqWnZSSGdjelJVZG94ZlBrYU5V?=
 =?utf-8?B?Qll0aVRnV216MDBBa0N2UElyTHpPN3FNaENRaExnOFdDTWk1L2VzeTcwalRy?=
 =?utf-8?B?dS9FYkZid2J3d3l3SUwwc1IxajRLanZYNkgvWTRuS2RiendVU3BNWllVLzJh?=
 =?utf-8?B?aTJENUJ0MkdOK2t0bC9XYWFpZ2NKZXFjUmIxSnlCaFlGRVY1L1VBVWk3eG5i?=
 =?utf-8?B?OTRPV2U5bG9henk3NmEvZytwRVk1SnJaMVFOVlV2SUNGN3lwMWJCMHpnbDFY?=
 =?utf-8?B?TXoyb2pxKzliTlZNN3haOFRvblhrck52dmdyWUp1S1g3Y1MvazE3emtCc3pk?=
 =?utf-8?B?K3UxZjUyV3RUWThIemJxYXNQZVpSYUNTckluSEhka1Nsekd5ckhzdzdkNFJN?=
 =?utf-8?B?dVVEYnpZRUxFSm1IN0xhazYvWW9lSGpGamY1cDNlcC9NN3RjUDRjd0pMQnFK?=
 =?utf-8?B?VHh3UlF6WVpyWHN6Z09XekV1dXBMNENyZS9kcWR6Q015TlB6VXdLcCtyaC9s?=
 =?utf-8?Q?WV00=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2015c4b-d74d-4a00-145f-08dce7aa261f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2024 15:01:54.9373 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4MD5UwDINpCZqJ4q1g0EOYA+SGFPpccumMXkzn97zShswKsu/DrQ5gENZGCo7KYmm/dGm3dH7uQX2r+N9DFnPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10883
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

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBpbXg4OiBDb3JyZWN0IHRoZSBTQ1UgQVBJIHJldHVybiB2
YWx1ZSBjaGVjaw0KPiANCj4gT24gU2F0LCBPY3QgNSwgMjAyNCBhdCA5OjAx4oCvUE0gUGVuZyBG
YW4gKE9TUykNCj4gPHBlbmcuZmFuQG9zcy5ueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206
IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gVGhlIFNDVSBBUEkgYWxyZGVh
eSBoYXMgYmVlbiBjb252ZXJ0ZWQgdG8gcmV0dXJuIExpbnV4IGVycm9yIGNvZGUsDQo+ID4gdXNp
bmcgU0NVIGVycm9yIGNvZGUgaXMgbm90IGNvcnJlY3QgaGVyZSwgYWx0aG91Z2ggU0NfRVJSX05P
TkUgaXMNCj4gPiB2YWx1ZSBhcyAwLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4g
PHBlbmcuZmFuQG54cC5jb20+DQo+IA0KPiBUaGlzIGNhdXNlcyB0aGUgZm9sbG93aW5nIGJ1aWxk
IGZhaWx1cmU6DQo+IA0KPiBhYXJjaDY0OiArIGNvbGlicmktaW14OHgNCj4gMzA0K1dBUk5JTkcg
J214OHF4LWFoYWItY29udGFpbmVyLmltZycgbm90IGZvdW5kLCByZXN1bHRpbmcgYmluYXJ5DQo+
IGlzDQo+IG5vdC1mdW5jdGlvbmFsDQo+IDMwNSthcmNoL2FybS9tYWNoLWlteC9pbXg4L2NwdS5j
OiBJbiBmdW5jdGlvbg0KPiAnYXJjaF9hdXhpbGlhcnlfY29yZV91cCc6DQo+IDMwNithcmNoL2Fy
bS9tYWNoLWlteC9pbXg4L2NwdS5jOjI0OTo5OiBlcnJvcjogJ3JldCcgdW5kZWNsYXJlZA0KPiAo
Zmlyc3QNCj4gdXNlIGluIHRoaXMgZnVuY3Rpb24pDQo+IDMwNysgMjQ5IHwgcmV0ID0gc2NfcG1f
c2V0X3Jlc291cmNlX3Bvd2VyX21vZGUoLTEsIGNvcmVfcnNyYywNCj4gMzA3KyBTQ19QTV9QV19N
T0RFX09OKTsNCj4gMzA4KyB8IF5+fg0KPiAzMDkrYXJjaC9hcm0vbWFjaC1pbXgvaW14OC9jcHUu
YzoyNDk6OTogbm90ZTogZWFjaCB1bmRlY2xhcmVkDQo+IGlkZW50aWZpZXIgaXMgcmVwb3J0ZWQg
b25seSBvbmNlIGZvciBlYWNoIGZ1bmN0aW9uIGl0IGFwcGVhcnMgaW4NCj4gMzEwK2FyY2gvYXJt
L21hY2gtaW14L2lteDgvY3B1LmM6MjYyOjg0OiBlcnJvcjogZXhwZWN0ZWQgJzsnIGJlZm9yZQ0K
PiAnaWYnDQo+IDMxMSsgMjYyIHwgcmV0ID0gc2NfcG1fY2xvY2tfZW5hYmxlKC0xLCBjb3JlX3Jz
cmMsIFNDX1BNX0NMS19QRVIsDQo+IHRydWUsDQo+IDMxMSsgZmFsc2UpDQo+IDMxMisgfCBeDQo+
IDMxMysgfCA7DQo+IDMxNCsgMjYzIHwgaWYgKHJldCkgew0KPiAzMTUrIHwgfn4NCj4gMzE2K2Fy
Y2gvYXJtL21hY2gtaW14L2lteDgvY3B1LmM6MjYwOjM3OiBlcnJvcjogdW51c2VkIHZhcmlhYmxl
DQo+ICdwZCcNCj4gWy1XZXJyb3I9dW51c2VkLXZhcmlhYmxlXQ0KPiAzMTcrIDI2MCB8IHN0cnVj
dCBwb3dlcl9kb21haW4gcGQ7DQo+IDMxOCsgfCBefg0KPiAzMTkrY2MxOiBhbGwgd2FybmluZ3Mg
YmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCj4gMzIwK21ha2VbM106ICoqKiBbc2NyaXB0cy9NYWtl
ZmlsZS5idWlsZDoyNTc6DQo+IGFyY2gvYXJtL21hY2gtaW14L2lteDgvY3B1Lm9dIEVycm9yIDEN
Cj4gMzIxK21ha2VbMl06ICoqKiBbc2NyaXB0cy9NYWtlZmlsZS5idWlsZDozOTg6IGFyY2gvYXJt
L21hY2gtDQo+IGlteC9pbXg4XQ0KPiAzMjErRXJyb3IgMg0KPiAzMjIrbWFrZVsxXTogKioqIFtN
YWtlZmlsZToxOTA3OiBhcmNoL2FybS9tYWNoLWlteF0gRXJyb3IgMg0KPiAzMjMrbWFrZTogKioq
IFtNYWtlZmlsZToxNzc6IHN1Yi1tYWtlXSBFcnJvciAyDQo+IA0KPiBQbGVhc2UgbWFrZSBzdXJl
IHRvIHJ1biB0aGUgcGF0Y2hlcyB0aHJvdWdoIENJLg0KDQpBaC4gSSBidWlsdCBpbXg4cW1fbWVr
LCBubyBpc3N1ZSwgYnV0IHNlZW1zIGluZGVlZCBpc3N1ZSBmb3INCjhxeHAuIEkgd2lsbCBkbyBt
b3JlIHRlc3QuDQoNClRoYW5rcywNClBlbmcuDQoNCg==
