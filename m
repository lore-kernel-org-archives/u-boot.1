Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39DDFCCD185
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 07:18:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05EB8383F;
	Mon, 13 Oct 2025 09:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yKSanSph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 135B28384E; Mon, 13 Oct 2025 08:59:28 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76498381D
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 08:59:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tC5WheWaDo5xSR0vHOveYw1CYZiGpgO1OpDREM22Yz3TNTKndcLRs+wyxLg5ZyxNqFA3vwbhburVK1vpXFB4aho2sLxsI0CJrKU5BRRnFq6pyqTgezwVXbwiA62d3CP4wXR3xIGXJbhuhepOUtvbvyeETuvMnZXe2SSsjXaAr5f0tuWm32NLC4Qpvs98b9Y16svnoCyFnOE97U3o72eAqFht+n+nS1uwPKwH9GEJmU8coT2Dy2umt9qYAnNQrcDMlngy7IeuxUBsRmU9jsw+cCMpuGBV2o5olcLNtY3MPd9ihfE+uMhob2hhXET557/vxLPPg0geNm1yHYV44iS/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgVu37bDyWY4t5gqpAC7Cnw7exql2TUVTYwhB9n7qRA=;
 b=kAL8lyZZbdQ8/G3+iNi+kpq4/pgZ3xyA1RMTc1WrIOSbAq7ASsptAqIGjV6p9oya2r7QB3aaRmASYLb2Ck7meJtcsWY1bH8VzYeht0Iwldo6IIGoJudeDjE2UslhMGZ9mk+hWshdbCrIZZczPhA+0t51D0UAObJZptWcnVC+Zk6xi/oXhv628103untyA2IZ8TGzznojV1N/uU19/rLKQqR5yFc7Q11N2eRfkegFj5FdBesLVO0jktSkXznCCr4zungWLvQ4ceyYCDxOA/EtHd1Jq1ZO0ULzd5O6XgoPRVFv9wEDVaYrI8mWbjmpbOHBM1J4lxPMbRedeFLEg8ESfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgVu37bDyWY4t5gqpAC7Cnw7exql2TUVTYwhB9n7qRA=;
 b=yKSanSph3LMBZLoWvG6P5NkEt3NcEiYj2jV12E/TbrggQeOsdcPWgs2oHphlQyPKJzmOI/so6oR1LECT5J3DpOyIV4I4Cuf5uotqmcccL52z8LtdjKaP99Yhwj9+HixXwcCm8Upm/UBrktEt3z7CBnfku2WRGgKChAqHR/W5SozIcVLZVzz9hIC8K1V4/JdPFwAEcQuAEdetpDWAQFfRxkrjCHPseMjQXkJmoWDYop4bXMd7UqBczvIykhk8vTtLNkC5j011MNSDbVCl7ha/BJBCEhe7utF4U5+YPtZhOGwC+PaJCEwtoyWcLp56A2wBpMolaDRHWsyJT26z28++VA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU0PR04MB9276.eurprd04.prod.outlook.com (2603:10a6:10:357::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:59:21 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 06:59:21 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH v3 00/10] Enable USB and ENETC on i.MX943 EVK
Date: Mon, 13 Oct 2025 14:58:41 +0800
Message-Id: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACGj7GgC/x3MTQqAIBBA4avIrBP8Jeoq0cJyrFlkoRSCdPek5
 QePVyFjIswwsgoJH8p0xgbZMVh3Fzfk5JtBCWWlkJrTUQaj77xwg0IHb1XvnYXWXwkDlf81waN
 hft8P+DUfgV8AAAA=
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Alice Guo <alice.guo@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR01CA0047.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::10) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU0PR04MB9276:EE_
X-MS-Office365-Filtering-Correlation-Id: ae31284d-8afa-4161-d57f-08de0a260925
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|7416014|19092799006|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SHpJd2dRSTFaMDlhZVd3dFAxSThTNUhpL3Y2eFlVYWl6VWtDY2o4Rk1sYVZi?=
 =?utf-8?B?SVBKRVNKYjUwaG9rTUFHWmpxWmdVdzBDMERSZHpNbkFWSk41NEJOaEZVamFh?=
 =?utf-8?B?TnZCK3YyS3JKeURaeTk1T0w1VEJ0cUJza0pkOGlqQ212emR5WmlNVlRDdCtp?=
 =?utf-8?B?SUJ6QzlkSnFHdERZVGQyMjRoZjkrMHZNekZuSVFmdGVhK1lvR2FDS3hhRnJU?=
 =?utf-8?B?MERNemhORCt5Z2J6Q2xGY2RMMy9uWXpFK1I5d1Q1SXlYZ2dmRnpNN3pSRyt3?=
 =?utf-8?B?SGpXSzZZa3AwMFdjNGJNeEJic1ZraVFYUXlsT052K20zeitRU0R1bWNSNU9N?=
 =?utf-8?B?Y3pmOWZwQjN4RXl3MVZiOHdZMWpnMk9vUXBOWnJPZTc2WnFjYWt5Ukdmc1h5?=
 =?utf-8?B?R0VkQlpBbmxrWDFUd0VVUnNYZmlGMEVCNkRWMDhTT25pcEo3VEYzVUc2K3hE?=
 =?utf-8?B?d2xQSDFEK0ZHSjIvejhlYlJsZEZmWDRIS21kUklvSDFXU2lpa0hHMWVjWjVz?=
 =?utf-8?B?anpyR1gveElrK0l3cmgyMVJDdGZqeFJQUEE1S3k4cURHeEI3Mkd6MExXUlow?=
 =?utf-8?B?NzA4ampEYjh1SGFIL0FQdTJySlhEVTVORitvN01Zdkt2UEVibWs3ZU1oaUVV?=
 =?utf-8?B?Q002QW5zd0E2eDh2NXRQd0Q4RkgvejJ2NG05emZTQjF1dGF5YmpqcE1nTmZE?=
 =?utf-8?B?WFhYSG1wanpjeVJrR2E2NEFNNFR2c3hEOVRtTS9BWDhiQVY5MDdXWFV0c0g0?=
 =?utf-8?B?TFBMSEFBbHlMakFRaTM1SHNBdWEwVUtFbUt4Nno3d25HZ29jRHVzVFRIWGdl?=
 =?utf-8?B?NFZ3aWs5cjFmQms2QXFSKzFuK1dWcEE1d3JWK1pDenU1S3RwdGw0c3pCQThV?=
 =?utf-8?B?NklYNllQL3lsemlaalNDYmpIZDhiMDQwZk1ON0F4ckNuUmFQTWpYakw4eE1P?=
 =?utf-8?B?blhUR0w5aWRGbE1BWkF4TndXUk8xUlJwT0l2UlN0NklYWkNPTVpRU0pCYmhp?=
 =?utf-8?B?cHJaL0h4YVNTQlUzeDhMbWp5ZXN5N0JoSC9RWUhDRUxST3BrclR0NWhBREE2?=
 =?utf-8?B?Q2ovRmRZTFdZNEV0Vzh5VlJYSWRxZHhXL1IzRnptMVJldnpsc3h1bGpSOE1X?=
 =?utf-8?B?WHlkVHhISEZ0RVlsWHpNNUJjUUZ0T3J6VDI1MFc0eWkvWnNEQ3J0RGZsdDk5?=
 =?utf-8?B?b1JQNVRQRkRVRmE1YmZqV2tiU1JFYVllUk1GV3VvaW5KRmo3bnRXeHFCNlZM?=
 =?utf-8?B?bTRFRFV5YzdhOEZ1M3dIeXhoUGRjSVRiaHNiUDNlSmI2czIyZjhyb1UyUklT?=
 =?utf-8?B?SXNxaUZEVzQrdUVCQWRLb1RZcDE5akVGOHo2bEFaUjJZMXE5YXErUDJHYnlw?=
 =?utf-8?B?UzJ3UnVpQ3EvbmQ5M3J0YWt3bW1wanU2U2piRmZmVFZMWCs1TnpHbC9YYTZY?=
 =?utf-8?B?R3U0enFKVit0eUJlYXNXRDNqdktXMFhBZkJjZVNCb2RmU0pkMnJ2NEFodUtx?=
 =?utf-8?B?RjNSVUVtb1pjbkVRQlVIaWowc1hGOERvc2UwYmF4TWpyam9QaTdaYWpocWNH?=
 =?utf-8?B?MUY4NUpZcDZjOFVWQTJWYlJVS0NXV3pNcndISitZcjY3RFM2dE9wczIxWTJE?=
 =?utf-8?B?TUVwakJqdlhVRGRPaFlpMkVMWXdBZ1pZWDVmL2FZZjBaUFJRL3VOTWszTndD?=
 =?utf-8?B?S0NzejdOcGhqL21iU2hoRkJ4MkZPbHJ5MzVHajNlSjBvV0c4dm9JVXV5bE9h?=
 =?utf-8?B?OFFvb203a1Z2T1JwdGxtZHJSS1dBaUJzZGw3YXBlak9yalFkeW1TNXdCbElx?=
 =?utf-8?B?bi9Ic2pqejY3a0FMVmhnRTJlZzJFQVhBVlZvUnBlWE1rT1E5c3NIV3IyY1lC?=
 =?utf-8?B?dGd1NmV0YkhwV0N1TGxTWlBPMDRvcjQwR3RibjlvM2x4bjhGaW1HTTlXelhK?=
 =?utf-8?B?WXI0NGJiaEdYVlBZcXA0VEE5cjBQN3RFZG83R3k2K2NaNkZhUEx4M0U0ZWNC?=
 =?utf-8?B?eGRDSjZHYk1VaVBybVJ3b3ExUUxqVW1YTHZMR1BpKytKYmtTYjIzdk84LzQx?=
 =?utf-8?Q?D4xggD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(7416014)(19092799006)(376014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWZndGhDLytxd3YrVCtUK014aEY0MEZUSVFTa1dQZm11TGJSNWNub0hid082?=
 =?utf-8?B?VjViK0FFVGVNdlMzV1c5RUNnRkRVbElweHVRdnhZcUlieUJtTnlpeUZRSEx3?=
 =?utf-8?B?R015OWhLekdJRW92QXBBZThaQzJrZDh6UW5xay9iS2FiWCs3blFhaUsrZjIx?=
 =?utf-8?B?dGlOK3JtaWYwRktuQVNreS8wNlkwTWV3eGNORTVSZFF4REZ1S1hCc2dWNDRh?=
 =?utf-8?B?VlJvS0l2ZVlKV2VnRElpcW5lbmd2ZnUvOGZja1JrSmhtRXdxNVNIWXprYW91?=
 =?utf-8?B?SVN4NGVRMDkwUUplSzVhQnNVT2E2dGNEZ3YzdzZZK2ZzRmtPQVRITFdTVUVn?=
 =?utf-8?B?QjNhckxFaWNWR0NCTHdDVXZkaDh2OFdXUXNDMkxhWEhwcGl2VzZPQlZaM2po?=
 =?utf-8?B?QnZIYmp0anI2YnR4UVUvcWVkRWtiQUd5aVArd1d1UHBJYnZlMWlLc0JLQnFh?=
 =?utf-8?B?RUpLdnVtNzFGYkdPTWd4OXMyRWJGVWphMjBXV003NURRdWNrdWwxakg4WVZt?=
 =?utf-8?B?bEhLUUpYdmtYeHhkeUY0SGZvUUI4RmN2OGgwVjc1MkozSjFTRzFJbk9jZHM2?=
 =?utf-8?B?L1RRN3c3RFFDd2dscHNYdEo3SWVmMG9QUFFXaWR2ZmFpZ0pBZnpsZU51UGRi?=
 =?utf-8?B?VWRPVjZTWGFySGIyUFRFUmtDUUdqakYvWHQ0Y1pUZFZ0aEp5VXl2N0ZkWFB2?=
 =?utf-8?B?b3dxWU5UdXBtQmdpZ2JQa2JYZTRsaTNjRjlFb05Qdnp2RTRYOThNa3VVVFM2?=
 =?utf-8?B?K1Y2VWpiZi8rbUhIODdrZXdVWnVKL0k1ZlQ5djVydU45WWFlL3JzdHFUendC?=
 =?utf-8?B?WmNSb1dVOVZIVHdDM2RQNUNnMWo3QzVyaTh0aVdPOEFydElSOCs1YU0yV0xH?=
 =?utf-8?B?S0dOSDFvQnhUQ2RpV2JabWtCbHh4S0lGb3d3alA0bnlOUFhEekxPRnRZMVlp?=
 =?utf-8?B?OGdjb055dUhKdlFLZWZmSWNSaktBbzVEWE9adDJ0Ym9Gazg4b3l5M0wyT3dK?=
 =?utf-8?B?bjNUNXpzT0pLanBYM3NXRkUwcWRleUtyQ2ZLZGhDOWxGS0wzekZSa3VheUFU?=
 =?utf-8?B?b0JtRWUxa3NaODFNSFJReW12MXlvZ2Rndi9qakQrK0I3aUUzRDBmNmVWUGZ0?=
 =?utf-8?B?STVLc25mQlhqV0UvaTFTUVBJRUNhWUtCNTdQUmR0eE9Na3oxd2lubHYrMWFw?=
 =?utf-8?B?MDJNa0l6WE9kbnpZUGhzczNBamRTRk1sclVWbzRLVXlVRnN5M2l0b1NPbHJN?=
 =?utf-8?B?UnJrbHp4SGhhYXBlQVpQc1NlV3Q0V0QrWGxidmRmWVkvS2lpcmlyVmFFZDE4?=
 =?utf-8?B?clVsVjlZNElZVitLM2ViUVl2U1cxbVh6T2dTTEZSeitkdTFGYVpCdmFPaEFl?=
 =?utf-8?B?akJudEFKYkxsUTdFV1NZV3FOWFpMVkhtMElUWXZzYjdiYXJWWkpLaFk5VWZS?=
 =?utf-8?B?V09yeEVvWFRwRTlPVTBaVEE5TlhyZE5xZU91anNSN3ZNUXhSdFNBWTlHbGU0?=
 =?utf-8?B?YzdWbGR3TGxSNWM3dWpNem5vNHB6Y0poRG5GK0FsYm5WemloL2NZZENyRFdz?=
 =?utf-8?B?VitjOG1UZ2pxL2JtVDJXNWFCaDN3S2ZKQ2krSDhPTk4zT2RLMlIrUjIyNTN4?=
 =?utf-8?B?eTZOSDErR1FlTzNhMVpNRDVMM2R2QUduV2xGN1AveldmZFdZR2tLYUVDZGRU?=
 =?utf-8?B?T0ZuQ1Iram1sZGpCWXExQUd2T3Nvc2h0d1pQdWxGQXdRWFBUSWJIYW1Uc1Bj?=
 =?utf-8?B?LzZGbTRVZkVLdk9PWktUWWdNR01BYVJsTlF1M0ZTNjBlbFIxVFFJU01na2RK?=
 =?utf-8?B?c0F0UHlZbHBhTlhmSFpMMVlBcHdteFRGQlRJM0gwR1QvUFY5RHRkQm5vd2g0?=
 =?utf-8?B?ekNva1ZBSGpOMlQrbkNONm9DWVhCSFo4RWwzUTNYcE91ZG5nTVBXQUVzOWhO?=
 =?utf-8?B?R1J4YmNyUGNIM2lKQXZqVFVOanBSVkVKVzM3SnZJVUxUNkxON2UyYUMrVmtJ?=
 =?utf-8?B?Rmd2N0p0L1NPUU0wUW1HbDVrNTBKMnEzWWdHem1XWW9PZVRES1hya01DQ3VE?=
 =?utf-8?B?MUdFbDBqbGg2aGpRR1Bpb3VjNWtUSVZ4c0FsdmI1ZkljcEpFM05Ya3ZqV3dN?=
 =?utf-8?Q?nH4T3UzIvcgVGQshCgTaGekpe?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae31284d-8afa-4161-d57f-08de0a260925
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:59:21.5726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xYxMDJJ2/vJ1QBCJXZB/Ih+gr0vqEXSeSs5DAbQM6/2GmzBe7K6FpgA0Nhej+9QP5dLZZFlPoN70ErZyu6BIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9276
X-Mailman-Approved-At: Mon, 13 Oct 2025 09:18:15 +0200
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

Changes for v1:
 - Adding USB2 and USB3 device tree nodes with required PHY and
   regulator support.
 - Enabling ENETC1 and ENETC2.
 - Updating Kconfig and DTSI files to support these interfaces.

Changes for v2:
 - Resend patch series with updated To list.

Changes for v3:
 - Remove logically dead code in imx94_link_config().

Note: Please ignore the mistakenly sent v2. Apologies for the confusion.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (6):
      usb: ehci-mx6: Extend support to i.MX91, i.MX93, i.MX94, and i.MX95
      arm: arch-imx9: Add USB2.0 and USB3.0 base address definitions
      imx943_evk: Enable USB 2.0 controller host mode
      phy: imx8mq-usb: Add SPL support for i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
      imx943_evk: Add support for booting from USB SDP on USB3.0
      imx943_evk: Enable ENETC1 and ENETC2

Frank Li (1):
      Add serial# for SPL SDP download

Ye Li (3):
      usb: f_sdp: Update SDP driver to support PQC container
      net: fsl_enetc: Add i.MX94 support to NETC block control driver
      net: fsl_enetc_mdio: Add support for phy-supply property

 arch/arm/dts/imx943-evk-u-boot.dtsi       | 182 +++++++++++++++++
 arch/arm/dts/imx943-u-boot.dtsi           | 234 +++++++++++++++++++++
 arch/arm/include/asm/arch-imx9/imx-regs.h |   5 +
 arch/arm/mach-imx/spl.c                   |  10 +
 configs/imx943_evk_defconfig              |  30 +++
 drivers/net/Kconfig                       |   5 +-
 drivers/net/fsl_enetc_mdio.c              |  25 +++
 drivers/net/fsl_enetc_netc_blk_ctrl.c     | 329 +++++++++++++++++++++++++++++-
 drivers/phy/Kconfig                       |  14 +-
 drivers/phy/Makefile                      |   2 +-
 drivers/usb/gadget/f_sdp.c                |   2 +-
 drivers/usb/host/Kconfig                  |   6 +-
 12 files changed, 826 insertions(+), 18 deletions(-)
---
base-commit: 48f21e66e360552c75d70a50421d0e0ed1f59e90
change-id: 20251013-imx943usb-4e03fd527da5

Best regards,
-- 
Alice Guo <alice.guo@nxp.com>

