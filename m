Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0A3C28B28
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 23:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A79380F9C;
	Thu, 13 Mar 2025 00:49:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="h5Z8eS1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73594810F4; Thu, 13 Mar 2025 00:49:34 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D4C380756
 for <u-boot@lists.denx.de>; Thu, 13 Mar 2025 00:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=peng.fan@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QnEU1y3CDLigujF3P+Bd8+/dyfWDn5/7iwT9Vj8tK7BFM0x/pwODMA0F215n2PckaOjYw1Ux+wGfi6d4SOCHZi3/rYSAl+Hwp1yM17QuW4RawAPAitDxEPoRejJC1rwKohONF3d2Box3FKA7Zut7F96n0+HnNWKUwU726HnLopBIsc61GNfnhssY1non9Sq/RPw3srQXrJyfOSi7Q4V7LDk3e7f9GnHo8HAk9OWuk27v1QJAofhTVKo1zNtDFKCW7NXQtspcAtKgF1kZ7E7YRL2lSYrWqk/6cg6mz1Q/5PSib6CM4l/0nZnmI1jpxZBeEUbgpm3dyE4U7N6AfFOZrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IQ1lxreNOTtcmpbOmPE/0D5MtB7NEiDH1479AqYZIM=;
 b=s317zVDP+ubU8jl+lU9uf3VcWYmAKiD/kvuI7wnGaq7vfUId5n3flrBRJfQTDPj+osO873o/YaeGInGcJ+JiP2ypkvQ6kexGUWbtIWMOu/B2rhumyhOMaYj6HE+BYeOR9ipcXU9jjdYlYY8BjWKRZJD2WU26TeFUKwsCxJFulrV4FeRvc289r3ikP9VMg45i/SI3vV2sF6f77kMG2DEbH4Emzr+QlApzIbocFYZkXBtGix3BiNyQfyMxQ/5GITJfuwtOsLcEnT+DN52+SxSnjAAwnBrrWWMOQWmUj0STQ4ZtyMwvNMgQm2/IncS+SgGipQ4r8wFBLNifw1oOApbTMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IQ1lxreNOTtcmpbOmPE/0D5MtB7NEiDH1479AqYZIM=;
 b=h5Z8eS1qKbg33Yt4s0r6kpzrFn2DHCwx0K/ezIgivbd8j+zJRt3YLRe7oe0vWhC2g6LsYnW0O0JCU6E3xdwJmjOsAlp4fa2BqJwDpx6h4Ipwl8m8rdPKkDk2jPvTbBiNpMypOeWKYV5NJv2qf1kNKFYWWl6IDP8vfV6dM2z1o6WOL+TQHI6DIjPnFVETJgSp7GYfI+Ja5NQzv/qE81JS7kB670wM8Hm21b6XdbROP+o81lSnciMBzWAQneFX0Lr+A78FSq5BwCL+62LxpjxObp3kIQKrx7NAVPr5IUxGNm7+bCZOOaNFtySudBKRNnzh88HNdkVYtq6n2sNEzk7dtg==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 23:49:28 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.8534.024; Wed, 12 Mar 2025
 23:49:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: =?utf-8?B?VmluY2VudCBTdGVobMOp?= <vincent.stehle@arm.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, dl-uboot-imx
 <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, "tharvey@gateworks.com"
 <tharvey@gateworks.com>
Subject: RE: [PATCH] imx8m: soc: cope with existing optee node
Thread-Topic: [PATCH] imx8m: soc: cope with existing optee node
Thread-Index: AQHbkbkPO3fdAErKrEyuSCQxmDrzsLNvjiiAgAAPfBCAABGigIAAf87Q
Date: Wed, 12 Mar 2025 23:49:28 +0000
Message-ID: <DB9PR04MB8461D8A236FAC9852C8F219F88D02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20250310123621.389594-1-vincent.stehle@arm.com>
 <CAOMZO5BV1BBP-f++-NzjzEDXCG1-2WVjma8-e5zpi3yLKGeYCA@mail.gmail.com>
 <PAXPR04MB84599BAB4FADAC79AB75934388D02@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <CAOMZO5BTGGU=fJkuxjgq++7+qw5maanjZ14p4=9_RhPdO85GgA@mail.gmail.com>
In-Reply-To: <CAOMZO5BTGGU=fJkuxjgq++7+qw5maanjZ14p4=9_RhPdO85GgA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|AS4PR04MB9715:EE_
x-ms-office365-filtering-correlation-id: a0735020-2d7b-45bd-ea4d-08dd61c08741
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NHA4R29ia043SEEyNlFtU0RhQVNiSFFtRXlnaEVBNWJjMERCbm1hQitCa05B?=
 =?utf-8?B?TG5nMmpDV1lrOXJnOVkzNE1ha2pUWG8zTTNFRmZ0MVpWS3MwcldLQkgzYTRL?=
 =?utf-8?B?R2pUdEgvY2w3UjgzQlZiV2p1cVQwMzE5cDVKa21JWUY1SUhkcFV1THR2amoz?=
 =?utf-8?B?cXFwQnlxN0NVS1M1bWV0dG42YXBLN0ZSZ0hDZVRnU3orUW9PcFEzVUgrOEhP?=
 =?utf-8?B?NzJOVGJZYTdTM254bzhUenBVYzF2Rzh6RHFGNmQyYjNoN2lpcWwzWE1tOUNl?=
 =?utf-8?B?ZXcwMWYzSVpzS3dHbURJcjd4bXNuNVNwVXBRNGtIeXR1U0trc2R2LzZ4L1Rr?=
 =?utf-8?B?bXg3RjRxekpSRURIT2tPbWVMbTBNQVNuTTIvOWtxSUt0dllXL1poTW45VDdR?=
 =?utf-8?B?UXdwS3hPQTd6Vm5rc3llek1penNZYU1Vb1BDTUsvWTR5OVlKWTU4SFVmbkc3?=
 =?utf-8?B?MmhKOHY4S3lLZldZV09yaEh4SlgxUkUwUktNQlZ0Q2hIVFlRWWdVOWlrWWow?=
 =?utf-8?B?ODJTbDc1a3RMNE5heHZlaVNUWExKVWJkTkdmTmN3V3Q1MWp3bDNxbmp1NHhP?=
 =?utf-8?B?ZloyWkpkRlg2UGFLNkU1N1J0Sk5lTDQ5SU5QWW8zNUxwUlNzbTB4NW9NNTlt?=
 =?utf-8?B?c0dVTGxSTXBOUVEyMFRXL1RYMjdEYUZQeGNNeTNrOVR5YmFkU0F3cS9iS29F?=
 =?utf-8?B?T25JS1hDMzdIcVhsSVJVaGV0YzdjUFhvNUVaN0FWN2l2dzBMdjNwaWxlQ2pV?=
 =?utf-8?B?RlBaRDRWbVBNZ0QybFhPUEJMRGFBK2wrb2RoaGZURmpIeDR6cVBWTjF5eGlI?=
 =?utf-8?B?T1NSQndwSWVRQkhUblovWTg1WmxCbTZkMyt6aWNhNFRsa0JTK3hWMUhyT1Zm?=
 =?utf-8?B?VkFnQitZSCsybmJHcHkrRlozRS9MN2VCRXZoT2tQN0k3eEg1WFUwNVZmWkps?=
 =?utf-8?B?bkZxbmZUZXhUQ1F3M0o4bDNDQUJlOFZ4SUliOUZFQ29JenQvWjVTSnc3aXJy?=
 =?utf-8?B?YkF2TTIrSG85emFFdlNPWDlkTEU1eHFubnZhY3dWY1g5Y3pJQXFleTRGSTdi?=
 =?utf-8?B?bjI2T2RPZWk0bWpTMnhIWUxlUWRnNWE4RTFPMm10amtzeW9ITnlpRDNhRkRJ?=
 =?utf-8?B?SzdjLzI2MU9VQ0dkb3RGNWxyampLQkV6bnpkRGF2L3NNU0RvU1M4TWFXNGY3?=
 =?utf-8?B?VXhBVWVVNk5mbG9aK1R3K29qbmlvRmw1LzJwb1JDSE1QZTdMaEZBZTNiMllW?=
 =?utf-8?B?YzBRWWZYbUVPZGhRWGFrQVRuN2Z2eEdTSUh2UmNnVkQxcDQwUlFIem41Y2dK?=
 =?utf-8?B?V082QTM0UDdZZGNSZ3JtUHBvS3ExY215QWZFZzR6c2QrZ3NqZDkrYkJzMUdl?=
 =?utf-8?B?UisxdnIxdVBTUVZ3dWl6d05hd05kUnlqWnluV1p2Vm5HVXZZdVdxOUl0R3Zr?=
 =?utf-8?B?T2lPbzFiOHZSb0pBZERHZElYcjhNZHVWT2FIb09lNGNvMWEzcXVVdEhCaC8z?=
 =?utf-8?B?THdzREFObW5sS3FtUDJXK05mU0FOVm4zTy9jdDEyMzdaV3hVMjQyek5jcG5t?=
 =?utf-8?B?TEZiVTZ0V2x6WUxwNzZkTTN0bUEwaHNyKytjUC8wNE12UnBoMzhYRmZ6ZndJ?=
 =?utf-8?B?KzlHbHl4UE1iaU9GMlIwdnZvVERNZ0NOTzVkMThTUEJlOEs0aTdNV25HZVh4?=
 =?utf-8?B?ZDNTNCt4ekpDVlh3MXpZa1h6NEVmNm1UTEUvcUlwb0VtMnRlOEpXanlZZzQw?=
 =?utf-8?B?bnhhYkl6Mm5xZnN2b0hQbTJLOTJRYUZuZjQxM3JDdjNYYU9VVDlBSFB4TWZE?=
 =?utf-8?B?Sm14Zy9jN2JCZWJQdElOcFRla0NvY3JyMHl2cjdWR2RUSjNFaTZJNXp6WGNI?=
 =?utf-8?B?NTFCcU4vcVMyQXJYSTI3TzZmZWF3d0NOa1phaVZ1anB6WlJWZ0lPKzd6NE8x?=
 =?utf-8?Q?QNoAcknzJwb7sZW3cduH89YjoFRHb2xP?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDZXMk5aRGtEdzRJTElvdlpIUTNwa0R3cFpCVzRZcFAxSHpjV1dIZnc2b2FQ?=
 =?utf-8?B?bHBzSWFGQTNGeUlVRkUvOEdmZkxJRy85VWNHZUdWNGxNTXZ0YzhncXJydWRJ?=
 =?utf-8?B?ZTZLQlg3dTFTNW9yU01iUE4wM2h0U05NVUMrVXc0YXdJVUlMV0NGTUUzak1v?=
 =?utf-8?B?TGw1V3RQMUM0UkFEOW8rMWpIYk5aWVE2QVRDZ2ovN1NUcEp1dFFmRC85bXAx?=
 =?utf-8?B?TG03K1lBUlhvNVBHYkZMcE9pMmNuSUlFbDBxVjk4ZlZpcXZlUFdlQnh6Tzlp?=
 =?utf-8?B?cWVUamErZmdIZFBFT3UxRTc3QytyaTN4bCtIWXlJdHpIQVBUNUJhclVjdkxt?=
 =?utf-8?B?UXZaQnphalpDcFphQTF4bXg2Mk56aXJmWDM1dGhpb2hLOEdIRnVqWFNOSUgz?=
 =?utf-8?B?TVRvSmxVZHU5L25jUWI1TUQxbk1XL0d2ZFg3eTNNQTQ2aVdjT08vWkhJRkRV?=
 =?utf-8?B?Szkwb2dKUll4akJ2Qk1uTGxWb0JLc2hCMTZBdHJuVzFxNnZSWE5JeG9SVGFZ?=
 =?utf-8?B?TDBYT0hwd3Z1V0VIWkVSYVhWTmN1aUR3TVF0dUVtbkNMZUVscnN5V1ErM2Vk?=
 =?utf-8?B?Z0NWSVVOS1kxWUN3ZU0rM2E2c0IvZlJNd0oyOVRqWE4xb0pzK1dIR0FjSjgy?=
 =?utf-8?B?WnIxVHBGM3lnZG1KOGZZQ3BFaGljRFc1MmdlZ0x3anFNRFhiYnJrdWYxUU9T?=
 =?utf-8?B?MnVSdUJiRmNUZi96QnlwZXFTb1VBcFpUMEZSb2Y0MHZqMUU4SWhkd282RjE3?=
 =?utf-8?B?YUhuRjJiU0N6cVRpN3lla1hxM2FUR3BPNlRxdk51MmpDNktlWkhNSjFOazg4?=
 =?utf-8?B?Umd6b2ZKQkdNVE9oOGk5blk3TkNtUE03NFZGK0doUnQ1U1NPUFFZRjFpazJS?=
 =?utf-8?B?K01SWk5FTU91UFVtZWFrRU1YclF6TVVXa3BnZkkxZ0pvampRU3lYNFBzcjBj?=
 =?utf-8?B?UW1WbUNLNis5K3BWK2wySnJiZmIwME1vcm9kRDUwYkNGaVFLY1Zud050T1BK?=
 =?utf-8?B?Q2NRMjI1ZjBwbkdrUm5IdnBZSGcyOUJ2UXpWeDlMSFEvVVVjZFphZWtRQTFl?=
 =?utf-8?B?aU5oVFBBak1IUk1OSjlaSmU2aU55eWhZR25ZdDJUSjN6cFd1TnVCK3JHUEds?=
 =?utf-8?B?OFhjL0Q1TFdFTlQyTWt5TTBtZXQ3V0JSeXExTWdGcjZXNnU2SWlLaGFNYWlF?=
 =?utf-8?B?L0EzYUlMS01mdEpMRWV0QXlDajBZeXVyV09qSTBpTlNQVGZicUV3VjNGeHh0?=
 =?utf-8?B?bHNXK1kvbURNMXEwQVRPNStQc3dkL1dBdyticXpnTDlIQmVDWTlnSWJiRG5r?=
 =?utf-8?B?bk41azZSUklVbm43cVluaEdQVTF1VHhiYWt3MGF6OVB0aElWTkh0aTVSeXlQ?=
 =?utf-8?B?RnBSMjRhUmgxMGJ4VW9IZ1phNDM2OW1DUDN4d0hRZ1M0aXBDQ3lYS21NYk51?=
 =?utf-8?B?STBNenpYZ091TmtOOGphaGd1cSt5TVNnRzg0WVdIUFE0V2pHTjJYdnpReXN4?=
 =?utf-8?B?bmV1UC9UM25oUjVOd0g4MUpzaWpEbXdxYWxpRlJMRDRVbUVNWFZKd3Z1N2d1?=
 =?utf-8?B?OVc2MThEaWM5emM4UGdITDRRWXFyN0hsRHZNV01Hb3NNSUZxeENLMS9IY3hk?=
 =?utf-8?B?cTRJUk5LbEN6a2ZQZnBsYVU3eE9RQUhOVjdnQmZjWm45YmRGWi81eWpFUDVB?=
 =?utf-8?B?YkF0VlQvb25vYm9ZbVNKS3NzRTg4TDJVWC9xNnRPcFo3YUtFeEZJUEVnM3Rp?=
 =?utf-8?B?UHZINC9jSFVpRVNJR0RYRUdSdVBKNkxHTUtuT0p6US9wZFBPYTR2Q2xtM2No?=
 =?utf-8?B?U0pkcnVkZlphdkZUTVJWcllweWlmbFRDcnAvSW1YenU2UCtIVHlrMjFPZkNx?=
 =?utf-8?B?VUIxWTZub1pPRmw2TjR6ckZMR04rRG8weXNSeGZvTXRTMGovY1dDak9Fb3hw?=
 =?utf-8?B?SXJzZXhOb1JDNW9xRlAyNk9FYzVlWmM0VFd3R1NlaE1BSFk3Z21Ib1loTzU2?=
 =?utf-8?B?QkN4aGZDcTIrUFRySXliWU5TK2xEOWwzQldKdXRYdWJVcEVOMWpMRkV6eEVD?=
 =?utf-8?B?dkRxeHpwMnNZZUdqOHZabXVGNXVaYndRUjlrZzczckd2bzJNaXRYWTM3cko4?=
 =?utf-8?Q?f5VE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0735020-2d7b-45bd-ea4d-08dd61c08741
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2025 23:49:28.6802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KWQTv51exjXHRT8NG2yklvV9KyoJ/Ss4Mp4kfNKlcR8oW7LL0e/pjJPaLRpLyhv+J116S0wA5fljujr+wpfSOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715
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
ZWUgbm9kZQ0KPiANCj4gT24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgMTI6MTDigK9QTSBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IFBhcnRpYWxseSByaWdodC4N
Cj4gPiBCdXQgVGhlIGlzc3VlIGhlcmUgaXMgdG8gaGFuZGxlIHRoZSBjYXNlIHRoYXQgdGhlIG5v
ZGUgaXMgY3JlYXRlZCBieQ0KPiA+IG9wdGVlIG9zIGFuZCB1Ym9vdCBzaG91bGQgYnlwYXNzIGNy
ZWF0aW5nIGl0IGFnYWluLg0KPiANCj4gWWVzLCB0aHMgcGF0Y2ggaXMgY29ycmVjdC4NCj4gDQo+
IE15IHF1ZXN0aW9uIGlzIGlmIHdlIGFsc28gbmVlZCB0byBwYXNzDQo+IA0KPiAgIGlmICghSVNf
RU5BQkxFRChDT05GSUdfT1BURUUpKQ0KPiAgICAgICByZXR1cm4gMDsNCj4gDQo+IEFzIGEgc2Vw
YXJhdGUgcGF0Y2guDQoNCkkgdGhpbmsgbm8sIENPTkZJR19PUFRFRSBpcyBmb3IgVS1Cb290IHRv
IHVzZSBPUC1URUUgZmVhdHVyZS4NCkJ1dCBoZXJlIHRoZSBub2RlIGNyZWF0aW9uIGlzIGZvciBs
aW51eCBrZXJuZWwgdG8gdXNlIE9QLVRFRS4NCg0KVGhhbmtzLA0KUGVuZy4NCg0K
