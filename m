Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F146CCFA18
	for <u-boot@archiver.kernel.org>; Sat,  8 Nov 2025 08:02:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6317883E23;
	Sat,  8 Nov 2025 09:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="N3m++kDA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C04D83E57; Sat,  8 Nov 2025 09:02:27 +0100 (CET)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0326783DF3
 for <u-boot@lists.denx.de>; Sat,  8 Nov 2025 09:02:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4oTuavj1WudIHDN3asUBsWF/yPtCrXQ9bg+8hBVUrDkMWDeH5eGVs+Znctpnc83wS3FzYa0G6UH4yGDhz+3s9XvIDdKPpAOLx3SFnn8OuShJinq5ltnyRlpe0rX49FieA00UhKLe0/+sWDHqFwHmHO6TUAIKLMR8VcimIsHjjHnen6kVR1TfjX2vLXBY/wnqJoyqMvuIRUeL2z8FUErkgx2qy2/uV1w4v8KDBfXiJEKY+DBBDz/VBEUmJaLWQr5JJdYgueVllBxZ9JRedeZnAAXrol49yIES9iio26PuYYaqvGcgWNqQWdWjYwOWRKGHbncAlA/XBgEe84d5JiFAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owUfIGYuQBvF2UeciAmoxh3cS249QDxdLPsFwiPVKXE=;
 b=P9Qh05lajy+Sp7QwtDobKHM6hywV8w068Yrqb3IBm9hVm66FHgJRgMuGoFGibd+VFO4YDGfgSfSjBdk0LyQYeOV984FD2Hg8f1k/jdjl5pO4WvWRncId1/puka5IEdr799VSxJ84ITO30jHZELOUJBInjORHxQhoCVyZvqrr0J/4l5PODxLYGMRudn50S2ZpPn4G/FTkiSGfyzDLq7wDWWi0rdNFYTAh1PwWc9Kb+rEL8FlC24dfYPxq98VqIb8CCppK9WD7S8/lYtXmAeYVCoMJuHbokUiQdCx2PBalyo8rMFp0PO1dbi1VuhbpJfU5bRTQrx6+8A0BagtNM2vkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owUfIGYuQBvF2UeciAmoxh3cS249QDxdLPsFwiPVKXE=;
 b=N3m++kDA8Em+JiTb4LXt52lx+EEMRoPFP9UXu/HhZehhMRStJ3lbkFaUvFCDBGzg+T8aLRJIfuhlEdQTEDr/1TTAejxsV2WuOqx86rxVn9Hq+r09hwcpI/7GdxKnPQOYE5fBuPYntu0JdzrMXiUCTCxRZNknkLVJknGkYlYUypfBqtxaV0YMRSDHc8SsDjvdNUMi6y+mZA5tj8pcKGNL29d1qiVvejwJNPFWtAuolo6LC+x1bfS6QtTuGBSjnivCBYHlyYOArZAB3pGv8eICc4zhY/IouoBWyKcqWCJvTmgKZ/eWTvIjulS21VvYGK4MOMuFR+cCdj8Rk41A4SPmcQ==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM7PR04MB6775.eurprd04.prod.outlook.com (2603:10a6:20b:102::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Sat, 8 Nov
 2025 08:02:23 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9298.012; Sat, 8 Nov 2025
 08:02:23 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>, "Peng Fan (OSS)"
 <peng.fan@oss.nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Alice Guo
 <alice.guo@nxp.com>, Patrice Chotard <patrice.chotard@foss.st.com>, Patrick
 Delaunay <patrick.delaunay@foss.st.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: RE: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Thread-Topic: [PATCH v2 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Thread-Index: AQHcT5MyAGoz+7dc40ahBbweB9OJ1bTnIaMAgADAWICAAIqloA==
Date: Sat, 8 Nov 2025 08:02:22 +0000
Message-ID: <DB9PR04MB84610B2CFE5A1ACEA4726D3288C0A@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20251107030352.475169-1-marek.vasut+renesas@mailbox.org>
 <20251107030352.475169-4-marek.vasut+renesas@mailbox.org>
 <aQ3jMu4dW61RgbWX@nxa18884-linux>
 <5842e083-d9ff-434b-98fd-f0ae5da334f8@mailbox.org>
In-Reply-To: <5842e083-d9ff-434b-98fd-f0ae5da334f8@mailbox.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AM7PR04MB6775:EE_
x-ms-office365-filtering-correlation-id: b81bf009-4f51-4809-0730-08de1e9d2619
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|19092799006|1800799024|376014|366016|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?VGU0cHlab3JyMWo1WCttbG5BeUp0S1I4YjRtMGRja0tXejBuNjRTWHkvZDc2?=
 =?utf-8?B?SGgrWHRCeTcrU29OaDM2ek51ZG9FTzUxU21UMmgxVThHQ0ZHWi9Va2ZsY1Q3?=
 =?utf-8?B?VE5lMzE4NkRNRjhCMjdab1ZKR1BaTXFBVWlXSzArN2xBSmlnYXBvNlFFeHAw?=
 =?utf-8?B?QjdjY2llUkpsR0RHcFZkUGZSbmZ0amdSVTE2YS93NE1IVVJhWjRLMDZ1bEJ2?=
 =?utf-8?B?NFMydkU5ckJQYkdNbjN1N3NWa1VndUlkOXc2c1IvNk1kMm9rME9OeGVUVjd6?=
 =?utf-8?B?cGs5d01LWVlodFFzMS9Pczgzcm9LZVZ1T2ZyL3JBWTBHRm1PbVdDK3pEa0U2?=
 =?utf-8?B?TjNoTzNlSDl6NW9IWk5oNS9ub3YwYVlJZHNFVklDbkZLaXR6eklOMnQ0SmUz?=
 =?utf-8?B?VVA1eFNFS3JINmFNa3U0RVFscDdmc3RDSlM2RlBmTWo4b3l3SDlEMXIxaVdk?=
 =?utf-8?B?bDl3MXJ2SXVSdytoYk5SMEtMb0Z0Y0lPOFAvSFBJRWZRM0VUK3ducXJ1ZWxH?=
 =?utf-8?B?TzQrQnVEKzRXS1k4YisyNndVSE9kelNlYnZLb04zdEZ3YWtRZ3RrN3FMREZt?=
 =?utf-8?B?ZjRDMjByV0lUc0wzWVN3eHpxVkpLU1A3eXMreHc0WTVYUURpWVdpUytZeFkz?=
 =?utf-8?B?dzV1a1hjRXNpRkVyKzFOY29lYlBEWWxWNUFOTnRPdER2bXVPSVlJdUpZNFor?=
 =?utf-8?B?RWdGK1FtdGVJcjZHSFJVNGZ3YXJMRWxlTUs3NWdPL2p5UFRYRFpoZmhQUUJB?=
 =?utf-8?B?UmRoRGUvNFNsQmUwS2tLSHF2NnM4TkxKMFBMNU1mOWlabXJXY1o5ZVpoMEJo?=
 =?utf-8?B?d1JPVzF4Z0JhS04yRE5qcXBqT0k0cm1YaUVRVzhMYmNOaWNqNnZaNUhSL1cr?=
 =?utf-8?B?YnN4YXRXYThaaEhRWW96UDJsTlQyL1dFOVdmcVFzL0NjVzh6ZlVJU0dpaUpN?=
 =?utf-8?B?NEdOVmRRZm5mbi8xRXlvczRtdU13elhERmI1KzFDbnRPM0xGUm1CM3VxNmJl?=
 =?utf-8?B?bDk5Y2Vqb2ZsWnNKZTcxdHU0YzZ0S2tKMGpmY1RuSlg3a0JNN3plN3h4MlBq?=
 =?utf-8?B?RGlYMDk3aEN4SG9YWGdiczJXYjNTTmUyRDI3Y0V2bERXL29DbU9QNG1nNHVs?=
 =?utf-8?B?NEIyaHVtblRka3UzRk9wOEZ1dEo4RGhxTHBES2xMZitBNm9EMUZpT2RNVkpj?=
 =?utf-8?B?QkdQVkw2SWE5eStobFZuVEdlYXo4UkQzeUpkckhyOUYzb3YvVzVKSHNlODJy?=
 =?utf-8?B?eFdFZVdaVkJ5RXNiT29JNnJTcDZzSHc3Y0cvbW91aW5XRUF0eU1GTTBEQW90?=
 =?utf-8?B?aW5Ha3d3TEtsakplQktKeEVxcEcxSkJRWmU1Y3lSNDVwMnp4TllkUko3QWMz?=
 =?utf-8?B?ZTd2TFJoajliQUh3dGp5bTNWaXNScjVGYVZybUduUXY5Z3VCbTc0czBVcDJ5?=
 =?utf-8?B?MVl2NkhURGlDcUdnd04zUFZ6Y2ZTNVJhbHE3U1p2d3lVSXViKzVmSk1SUUxi?=
 =?utf-8?B?Z29XR0xrZVNESzU3ajNWbmRoc3NGWGNDaTh1MlpLSUtRdis4WmhCR2tZSGNh?=
 =?utf-8?B?NGFFK1pHR0JrdDlVc2syYTYzM1IxSzNOaG9NWk14dUhPd25XUWlFVkI0Q09y?=
 =?utf-8?B?TjloV0ppUDUzYUQzdFFNdkNZeENhRitZZ3VGeFltVWJ4OHltNit2SjZ6TVda?=
 =?utf-8?B?QWw1NDBySUVpRVF1dkwwcUdSeWJPRzgrT3RxbGd0YkNGYWx6cStWQWVFQ05o?=
 =?utf-8?B?SjVJRmdVcTUrT05WVldkVkRkaDRmT2tpK0lYQVc5R1M1QW9va1AxWEptREJj?=
 =?utf-8?B?YWpvTlgrc29Na1dyR0dSS0FRNm5NbTdMMzBydEFJYXRLcVpsN0RkS2pNeVM3?=
 =?utf-8?B?a252RVR1dTd2ejFSWXNoMXhRSkR0cGRrcFE5QWR2dDFOaVBSVnlpbVZZWk5C?=
 =?utf-8?B?bzRaNGFKUGx3cG1WWDVMLy9uajViN0I3NTFuZHVORmFJVFFNWm1EdG92RHJT?=
 =?utf-8?B?eVlkSGJOSmhxRDRKNlRBdHQ4aGhnUU9CVlVDRUpMOS9kT1JlRkQyL2FsU3VI?=
 =?utf-8?Q?wokuaa?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhEclBXb2I4ZDEzR0JGc0ZRd2IvcHRkNng4eDVITDFNWElEOVdtQmpLS3hE?=
 =?utf-8?B?ZjkvT20wMStvaTBvb3FZU3liYjdxOFlTbTV0UmQ0cXhGT1pnUjlzTmx2ckxI?=
 =?utf-8?B?Ny9MdVQ4MzhWYkdmUi9NMnpLZHNHQkFIUkRIZkpRcmdZeDJlMnNXT1JUb3ZQ?=
 =?utf-8?B?aERaRzQ1SW9kSHB2YllFelZJRVhCTUl1ekVicEo0cGxxU0F6U29ZVlFJQTlh?=
 =?utf-8?B?WUY3Z0MyZ2ZXaFFJNnpPbXZ2aGkycXJscmZRRWt1Q0VvTXFta2RVZFQrc1FE?=
 =?utf-8?B?OVloUFNCZXRxV2pCRlBObVg5amVnVkpPa2ZSSTRya1hMTnI5SFIzRjRLcEk2?=
 =?utf-8?B?cmRwRnVWMzNFYmJ2STdXSm9iUzFxU3liOHdnb3dKeE5mSnErWjlRYkljMEFV?=
 =?utf-8?B?Rmx1ZGEzbjh2OWR1UTNzWXk2ekxkd2lyTW95ajEzOVhGSUV5S0Z2Q2NkTUY5?=
 =?utf-8?B?b2FMLzlxUnB0M1FKaTB3Q1VseXFnVnRkeVhsdVc4ejUvd01yS3QybElVbWlj?=
 =?utf-8?B?VmYxZk0vcnZvdUxZRFEvK011bGFZb1E5OUlPV2o0TE5lU3psUUxVeFRncEVq?=
 =?utf-8?B?SC9tUERzUXlXdWt3MFNPQ0JZY2FzSnFLanJXeklUT2VQVUMxdG1TL0ViOWVP?=
 =?utf-8?B?UFRvSGgyVFBlMGIzdk0xK3FQekxJQzV4WFRQK0ZwdE4rc3k5aytacHd6eHZP?=
 =?utf-8?B?Um5RSmQ5cFJ4aU9lQjMzeVhEdWJoekIveXltMFhkaDRwTmVuOFY2eStnU0Mx?=
 =?utf-8?B?SjVjQTZjQ2xMa3AwY0w1bUpJb3BXdGZkQUM3VG5YNXdnNjB6ekZLdVUwK2NN?=
 =?utf-8?B?L2Z6RnVDWHNiV0RsY2VKdXJEMUtib1VtT2VCb3FwenRFTWVaWnZ1T3B1UlN5?=
 =?utf-8?B?Q1djeG5aZDZoYm9DaEduQldUSXl3ZWpSRVpNYnRKczlHQXNhQWJtKzdCUTlY?=
 =?utf-8?B?TENqY0RndmlXWW9ZK0FxNk9acVBPSVd3M1JTYlVWSVZzTzBZQzFVR3MvS3ZD?=
 =?utf-8?B?dUxWd1gyY3V2R0EvcFVNbWU0Yk1CcGwxL3pVWGxZSlJBdDVuRUc4bHVMOWds?=
 =?utf-8?B?bUhNWEdCajFTSFRkQlZQSWhPd0s3cURsbEV0aXAxYU4yemxXZjZqRE1FRG9B?=
 =?utf-8?B?S3BiRm5YMTZSVnpwbnJBRXR0K0d5SWY1bDRxd2pIbEp2cDYyNWhIQURTVytH?=
 =?utf-8?B?Q1lRNWtGU3M1WURpWkJrVUkwSVUwaW8rNE04MDl6YThqL05EbnlXZDJXQldG?=
 =?utf-8?B?aGlKT1dLazJzMWJWOW94T1hWajVuOG9sMnVJdkpmVExXQ3JyOVpyMDBMYXZY?=
 =?utf-8?B?MklwSmtLdHZIaEhGUERidmUvSWlHcmc3ekxHZTRYTVRzVmdSOHFmbHY3bis5?=
 =?utf-8?B?c2hmUXBjZDRqTWxOUHFxWFh6WFM1M2RpTTJvcGpVRzIrcmpoVXVYcEZtMEVJ?=
 =?utf-8?B?S0VMemFUeVpiTmpZQkRRUkFzQ0FiM3AzQzZLcitOTEZTMm9COXZjQmZsbTNE?=
 =?utf-8?B?WEVhM2JIOFMyZGlacVVxajJOQ0R0YWdKaWtmV3NrQTE0NHR3VnJ2QURTOVY1?=
 =?utf-8?B?NHo5RnkwQzN4V0p4dGRQSUNVbFhoN0JJeVFlOWRDY0tFM1huRTZoOUVUaG8z?=
 =?utf-8?B?VzcyK0lrcHZleEFKeG1heE11TDEvWVQyNmZ4LzFSK09MMHJmN1I5RnNCRnJm?=
 =?utf-8?B?Ynlxd0lqZVJZc0FPb3RqMmJQWmJmRXIzSkJqRVRWODUrTTRSL0VpVmpBTll5?=
 =?utf-8?B?YXI1MjVvSG1ZZjk1cmdhU0U3aG8xVWFaVzg0cDcwSnBmY2JaS2o2a2JVR3Zn?=
 =?utf-8?B?blF2empMZTFQQnlvS1JhR0xVd2RqNVZvc2d4V3RNUDFTY0dYTVYzVS81MEdY?=
 =?utf-8?B?cGhtQjdZWkNyNUVGVkZkTWJhMjRrVWozZStHNytkNWdqMFNxK3BabG1SNVh2?=
 =?utf-8?B?M0ZicDNucVNlZjdPUUFza0J2NTVLNHM1TXdyVzU4aVphb2tQVk9zTkU1aUow?=
 =?utf-8?B?RnBKZTJzd1RKV09lb3IrS2VveTV5RFdhZGhxSjVJZ01FeDFQMU8rZ3U1MGYy?=
 =?utf-8?B?UmZSeXVKaWtzQXJwcG9QdERKMGV5WHFCOUJ2ZTExVW5ERmoyS00rVTJVcGp3?=
 =?utf-8?Q?XIs8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b81bf009-4f51-4809-0730-08de1e9d2619
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2025 08:02:23.0600 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RMq5VhflzonGHa95ULsn7sNfSGYAxdcbzk5pdGMd0bxxoKY+wQX+XdFWcDqSybJfXCZLYi7wh0lD4G9tk45c1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6775
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

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDQvNF0gY2xrOiBzY21pOiBEZWZlciBpc3N1ZSBvZg0K
PiBTQ01JX0NMT0NLX0FUVFJJQlVURVMNCj4gPg0KPiA+IEkgd2lsbCBjaGFuZ2UgdGhpcyB0byAi
Y2xrLT5kZXYiLCBvdGhlcndpc2UgdGhlcmUgaXMgQ0kgZmFpbHVyZS4NCj4gDQo+IFdoYXQga2lu
ZCBvZiBDSSBmYWlsdXJlID8NCg0KPT4gdXQgZG0gZG1fdGVzdF9zY21pX2Nsb2Nrcw0KVGVzdDog
c2NtaV9jbG9ja3M6IHNjbWkuYw0KZmluZF9zY21pX3Byb3RvY29sX2RldmljZSgpIHNhbmRib3gt
c2NtaV9hZ2VudCBzY21pOiBJbnZhbGlkIFNDTUkgZGV2aWNlLCBhZ2VudCBub3QgZm91bmQNCnRl
c3QvZG0vc2NtaS5jOjQyNiwgZG1fdGVzdF9zY21pX2Nsb2NrcygpOiAhcmV0X2RldiB8fCByZXRf
ZGV2ID09IDEwODgNClRlc3Q6IHNjbWlfY2xvY2tzOiBzY21pLmMgKGZsYXQgdHJlZSkNCmZpbmRf
c2NtaV9wcm90b2NvbF9kZXZpY2UoKSBzYW5kYm94LXNjbWlfYWdlbnQgc2NtaTogSW52YWxpZCBT
Q01JIGRldmljZSwgYWdlbnQgbm90IGZvdW5kDQp0ZXN0L2RtL3NjbWkuYzo0MjYsIGRtX3Rlc3Rf
c2NtaV9jbG9ja3MoKTogIXJldF9kZXYgfHwgcmV0X2RldiA9PSAxMDg4DQpUZXN0ICdzY21pX2Ns
b2NrcycgZmFpbGVkIDIgdGltZXMNClRlc3RzIHJ1bjogMSwgMTEgbXMsIGF2ZXJhZ2U6IDExIG1z
LCBmYWlsdXJlczogMg0KZXhpdCBub3QgYWxsb3dlZCBmcm9tIG1haW4gaW5wdXQgc2hlbGwuDQoN
ClJlZ2FyZHMsDQpQZW5nLg0KDQo+IA0KPiA+IE5vIG5lZWQgdG8gdXNlIGNsay0+ZGV2LT5wYXJl
bnQgaGVyZS4gVGhlIGNvcmUgY29kZSB3aWxsIGZpbmQgb3V0IHRoZQ0KPiA+IHNjbWkgcm9vdCBk
ZXZpY2UuDQo+ID4NCj4gPiBObyBuZWVkIHNlbmQgdjMsIEkgY291bGQgcGF0Y2ggaXQgaW4gdHJl
ZSBpZiBubyBvYmplY3Rpb25zLg0KPiBUaGlzIGNoYW5nZSB3b3VsZCBiZSB3cm9uZywgc28gcGxl
YXNlIGRvIG5vdCBkbyB0aGF0LiBBcHBseSB0aGlzIHBhdGNoOg0KPiANCj4gIg0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9jbGsvY2xrX3NjbWkuYyBiL2RyaXZlcnMvY2xrL2Nsa19zY21pLmMgaW5k
ZXgNCj4gNGU4ZTVhMjYyYzguLjk5ZmQ5Njc5NjM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Ns
ay9jbGtfc2NtaS5jDQo+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsa19zY21pLmMNCj4gQEAgLTE2OCw2
ICsxNjgsNyBAQCBzdGF0aWMgaW50IHNjbWlfY2xrX2dhdGUoc3RydWN0IGNsayAqY2xrLCBpbnQN
Cj4gZW5hYmxlKQ0KPiAgIHN0YXRpYyBpbnQgc2NtaV9jbGtfZ2V0X2N0cmxfZmxhZ3Moc3RydWN0
IGNsayAqY2xrLCB1MzIgKmN0cmxfZmxhZ3MpDQo+ICAgew0KPiAgICAgICAgICBzdHJ1Y3QgdWRl
dmljZSAqZGV2ID0gY2xrLT5kZXYtPnBhcmVudDsNCj4gK3ByaW50ZigiY2xrLT5kZXYtPm5hbWU9
JXMgY2xrLT5kZXYtPnBhcmVudC0+bmFtZT0lc1xuIiwgY2xrLT5kZXYtDQo+ID5uYW1lLA0KPiBj
bGstPmRldi0+cGFyZW50LT5uYW1lKTsNCj4gICAgICAgICAgc3RydWN0IGNsa19zY21pICpjbGtz
Y21pOw0KPiAgICAgICAgICB1MzIgYXR0cmlidXRlczsNCj4gICAgICAgICAgc3RydWN0IGNsayAq
YzsNCj4gIg0KPiANCj4gV2hlbiBVLUJvb3Qgc3RhcnRzLCB0aGUgb3V0cHV0IGxvb2tzIHRoaXMg
d2F5Og0KPiANCj4gIg0KPiBjbGstPmRldi0+bmFtZT1zY21pLTMyNSBjbGstPmRldi0+cGFyZW50
LT5uYW1lPXByb3RvY29sQDE0DQo+ICINCj4gDQo+IE5vdGljZSAiY2xrLT5kZXYtPnBhcmVudC0+
bmFtZT1wcm90b2NvbEAxNCIgLCB3aGljaCBpcyBjb3JyZWN0LA0KPiB0aGVyZWZvcmUgdGhlIGNs
ay0+ZGV2LT5wYXJlbnQgaXMgY29ycmVjdC4NCj4gDQo+IFdpdGggdGhlICJjbGstPmRldiIgY2hh
bmdlIGFwcGxpZWQsIHRoZSB3cm9uZyBkZXZpY2UgaXMgdXNlZCBhbmQgdGhlDQo+IHN5c3RlbSBz
dGFydHMgcHJvZHVjaW5nIGZhaWx1cmVzOg0KPiANCj4gIg0KPiBzY21pLW92ZXItbWFpbGJveCBz
Y21pOiBCdWZmZXIgdG9vIHNtYWxsOiBoZHItPmxlbmd0aDozMiwNCj4gb3V0X21zZ19zejoyNCAi
DQo+IA0KPiBXaGF0IGtpbmQgb2YgQ0kgZmFpbHVyZSBkbyB5b3Ugb2JzZXJ2ZSA/DQo=
