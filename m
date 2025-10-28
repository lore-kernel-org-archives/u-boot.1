Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4C6CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:06:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D8AE83A27;
	Tue, 28 Oct 2025 09:05:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fY2RjAGs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76E1A83968; Tue, 28 Oct 2025 03:48:15 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90CB1838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 03:48:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uaq3WTT9iB7Dzks9O1tToiZB6c7Fm+s5zAF8eA3RZ6Ka/7rilPjah3KqnGhpIMPz/iZEe1r9r2tYseG0ueQWvOGu0kURtd5UMdOwAcwZNo2PjPnfzPhSfuOMLtte6HjTWZuo+7L9710kOhSm4I3ezfS0VkqgjXyTOSAkqCfg4urADnWSYDEcgshSI/CjNtNvuC53LNQx70jQFWeUtVDkqIWRb8+uepxUFwp4bTQVvSo7y1mr2HfFHQbWyrgh9FYFVqJCmLEokq06l5djfEuc+hiUcDLGNocOktEslWfmLjspkYxw9UYhGcHfmS+TII1TosF4k0FbCVC83stqFI85FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=sJlvKEqfDUCh5TGph8Mbx7zdmQ2zRmd05qOeoyAwVCSpLu0Y2mEucUyUS5/xWj/DUvz9SQd0TFmZF6qEemhXH/iO2gkvnWT5WOkRak5osYX31NcXGJq4HuRwFkXx6TmoPUosSk0NT5Ew/sB/7V1vp3iEOwcn+dq7+hrFnMjSTh2ygWDbQyHVzNLcKXsnhqjgimLL7LgYS3CsNofBMohBfS6+EBLE6JRfKLXIkEMpxAYBGl/J+CZICavtCweVLZYQwEFoezHWO+N4gnlA08eRYaJ7X4KTU3d4CWig9gJuiY3byvrVJ+VA7hG7EqElYyp80usB+2uikL/FnUC1qOeeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N23uWZeV2LThteEM7EcSE7zvhh0/3QCMqf1cKbx4KYY=;
 b=fY2RjAGsNtxa/PvnGHe32xcTjDAf4bPTYvnEBejLv6WgazQohgzyjbtNt/n+bsVKvQr94Ny5nrDPxWKzTgnV69940dbDUXLhrPdlIQkD1GprwpVgb1g6xybXOHRCyWnT0Mag8lrijI0zr8zG7TE1+J/RHkbn7WEnC6ESxlqou/3gQUNRst3B/gGFxJAO//iVJtBOvoiZ9mi/IxQA170rFd2i0c3v7MnEe2Puka58SQodJOsXnHZ+VUVpYu6v7QkycowEJNI4tRL7pN+CdL/jlNo8NRF7aQ1fyP+pIMtbxKcO1AOu/sunwQpRH56t8lnkDCFbebP4j7d2tAkR82VOyA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7891.eurprd04.prod.outlook.com (2603:10a6:20b:237::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 28 Oct
 2025 02:48:11 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 02:48:11 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 28 Oct 2025 10:46:27 +0800
Subject: [PATCH v4 06/10] phy: imx8mq-usb: Add SPL support for i.MX8MQ,
 i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251028-imx943-v1-6-955b8370c685@nxp.com>
References: <20251028-imx943-v1-0-955b8370c685@nxp.com>
In-Reply-To: <20251028-imx943-v1-0-955b8370c685@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>, 
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Jindong Yue <jindong.yue@nxp.com>, 
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Tim Harvey <tharvey@gateworks.com>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>, 
 Minkyu Kang <mk7.kang@samsung.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR06CA0222.apcprd06.prod.outlook.com
 (2603:1096:4:68::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7891:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa9cc1c-cc53-4171-acb8-08de15cc6f23
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|7416014|376014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cmhqN0FiRmJrdmhrQ2ptczZzV0JNM21uQUxxMVRYcmpIaEREVGJPcE93dEEy?=
 =?utf-8?B?UXBhVis1eDN5V3dqN0FjeFRFditTVXNNSWg3c056R2ZCdDk0dlR1Zm5mU0NQ?=
 =?utf-8?B?MnB4b2JYTUhjbTVDclhUSWJnUGNXVzg1TzVxejAvVWh0akhVbXA2Y081MXVC?=
 =?utf-8?B?a2U4SmpmM3VuRlV6NXorUmZyVlNjY29iK3E3VUErMlJRVnVNNlBQRE5SU25h?=
 =?utf-8?B?MG8wc2VlSjJXNlBIMXRDRno1T0h4d21SdnNIakduWFhNYWRPNm9Qdm9ObTRE?=
 =?utf-8?B?c3VabndNc1h2anhTVEQ3ZENzQTlGU2hleU5SSGdkb25ldWwxNDg4cFU5NkVO?=
 =?utf-8?B?NUZLTkcxTzg2dWZUajZXa3V4VmtldUd6Q1JodlRSYmFmM3RNNnJ3bkFzbmYr?=
 =?utf-8?B?N1gydGFnZngrZk1veDAwR0VJdFNSSVRES1Bza2cyVkJNdlEvUEhzRUkzdnBT?=
 =?utf-8?B?dWpUOFY0SXgyeVdSb2d3NUo5MUlkLzBmV3BqZWdVQUdJdk1oQklpblFxTUtx?=
 =?utf-8?B?V2dXOXl0b0tybU9sSU4rSnI2Wm1JN1lBNUY5ZG8zRVQ4Ukhka3FJOXJ4dlVC?=
 =?utf-8?B?TFF4b0RDWW5JT1NuenNWcS9GNWg3WXR2dGlCek8wTTlCRTBoRmpSSWVBRExw?=
 =?utf-8?B?cTFJRGpmdm94bm5PMkJzTHJDbWlMT3l0cjJaM0kwZnp1bk44d0JoTm5JNGlT?=
 =?utf-8?B?bFdtenM1N05MaHJ4NHpzYTJLQWRrYWsxaTg1dW9laXNsUFpCL3FXZlBhT3V4?=
 =?utf-8?B?V3RTVG9DWllnaDVZcFEwbGprdGowZjl5S21Xd08wR1FuTjIzM2dMU3ZVMEJ0?=
 =?utf-8?B?cUxsWG1UZllrOUlCTFJaWnZraUZ0QXlXWWlZVnRoNlI2NE5ZcHJxUGNLaDlS?=
 =?utf-8?B?R28zZnhhTzVFaytxL3ZsSWRrSERhUFNlRmw2THQvUm1WUXVMT1k4NTJoQWFG?=
 =?utf-8?B?YVc0Wk5IK0h1U0FLSzlBTHVNNWpvWnh6dXpJaUJNYUtSNXZZL253YVdDUzEv?=
 =?utf-8?B?aVhlZzEyd0o1WW9PN3YzdC9vdWtVSm85LzJmUk53TnVrYld3dXJjTWlkM29i?=
 =?utf-8?B?azlSRXpBUEQwY2dzRHU2NGpRR0ZZL0NWQXI0ZnQxSjE1REhrWUExQmt6RDdE?=
 =?utf-8?B?bGFsUFBQai93alI0azZ2TktOeENDK3hVR1ZsUjB2ZGVWL0kwalNDV1BEdkZl?=
 =?utf-8?B?ZkE5bHNFSExza1NsNzhEOHpmQlQ4TUZ1VS9uSi9xb2E2TTBxMHRMT2p1VVdJ?=
 =?utf-8?B?WXNTaFB6UHFCU2xxYWdSMnlESE4rMFBiK1FZQzBCcW9qenFLRW1MWXN5ZG93?=
 =?utf-8?B?TmNZaGo2bVJCN0RqSExGSGdXcEx3QXFPSW85dW9aN0VTdVhiMXoyamFyRFJY?=
 =?utf-8?B?TVlkSnJoUDBHT2VuOVZJc1BEWEpOWEREWHJ4eFB4aXJsNFdCZHN1c1ZaZkh2?=
 =?utf-8?B?cm9JUUdGdk0xOVhJd2VxRzVkdjluR1RQOFBoU01SL2NKS0thY2VEKytGWUF2?=
 =?utf-8?B?b0gzUlBoc3RlT21WZFV2NFY4VTIzajFlc295dFZEd1JjRXRsUGpFL21jR1Rq?=
 =?utf-8?B?N2ZvZmVOZjBDcXkvMG9QZTVCai9YMG5SNjZJR21IUTVkeHl4RlBBbkdkd0pC?=
 =?utf-8?B?cDM0ZnFwdUNnSm94MXp4Z3VDcWpsTkgySG1yVThVQlozYzl1VzhqY1oxZGhw?=
 =?utf-8?B?UHVxclFFdzRqN1JWcS9ZNDg0WHN6Z21hYmFhZ1BWRy9CekhFY0JQT3R1bDBU?=
 =?utf-8?B?M0R6UUlPZXhBQk9qRWRLR2FWL2hNUGFFTklidEZWeVNkbDgzMEV2emJHakJj?=
 =?utf-8?B?bG5JL3cxdzdjeTducGs5N2dsREFKTkFsME9MVzZMNzdoMmR2STJhRHQwc0xI?=
 =?utf-8?B?bFhBOUd6L2R1am8zVHR1cDhvN2h4bEswSTVuS1ZGUkVrV0xxMWVNSVhLOEdz?=
 =?utf-8?B?UWhYWm1Va2xrSW5kYVZQRnF6d2pHeENqNXJ0NVo4NnFoOWhFU29jbnF6aXRT?=
 =?utf-8?B?akhHRUFPSGRoSEEwR3lsc09VeEFNaEszUHhyNi9BRlVTL1d5bjFpRVdqaExu?=
 =?utf-8?Q?RzThFN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(7416014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zkt3VWNmYnlDcFFOQ0Z1b2F0QjAvUysxUjh2STAyVHNWZ1FMcTh2dlBUUTl5?=
 =?utf-8?B?bkY2UGNYakNnaFF0RzRoMU5yRXFQVmlsNUdrTWdqRWNVNHRORjRSNGI2Vkoy?=
 =?utf-8?B?d0w4Q1pSWTJqVklqYjg0STRkNFVQdkZHN3FIZXNWSWtKRi9aaEZHR243bUI3?=
 =?utf-8?B?NHIzdTEybUVMRFkzMFcrVUE5VTFqWkFHRmtKQVV0VWdPR0U5bzNxQVpBdngz?=
 =?utf-8?B?cHh5NXJaTVVMeEJ1emVWaEIvK0dMK0JRNVMzbWYydVI0QlBhTVRJTG1RTC85?=
 =?utf-8?B?cE83eFN1Y2g4NGhCcGtNN0dXbjRVMHR5WFU1bTFPK2dwSnZFM1ZtUFNDQlR1?=
 =?utf-8?B?Tmx4azdCTXdDdWZhdjFDYm9OTHYrRUxmcnBYaHdBNUsybHlIamo1Ny84czRn?=
 =?utf-8?B?blpFMS9NQzZQYlRTc21VZnRJTllEMnNTQ0U2aDhzOEJ5U1Q0dThPbWlvRkF2?=
 =?utf-8?B?eGJSWGFMMmNydGRmUVlnM2YrenRNdm5DTGtDTWhHeDdZOXVtOFJqdTJRanJu?=
 =?utf-8?B?amxJZmN6UWdUWUlwdy9iL3llRzByRnEreTZKM1p1SXNOY1dyZHhRUGxPTkdT?=
 =?utf-8?B?ZWxFSlZKS3NyQ0t6OGFiMGRsSUIvUGdWZlpvR2ozNmh5QmtRRGNjaXl4ckFw?=
 =?utf-8?B?VVdoZ2JyZUFaU0NzcWM4aXJZUVgvdjF3THZYOG9YNGZ2YW1uV1BJMXJNeEFp?=
 =?utf-8?B?dVZGL0RzTmJJZ25pYnZOcm42b1ViUzl2NU00MkxhWUdiZE5UNno1MU5VVDNG?=
 =?utf-8?B?NXhhVU42SFNQYk03VTYrcGd6eXdJWXNZWUxDZ3J0dkVMOEVtNW1iYnJVYnpr?=
 =?utf-8?B?TDNoWUJHNE5pYmhOeU95NUUwc2M1aVIxNXRBeStTdXV3dy90RTg5QmEvTDd0?=
 =?utf-8?B?Um9RNnVXdEFweU1Sa2M5N1loMmVINklCUS9sbW84UkRYZkloekJTZm1SWFBs?=
 =?utf-8?B?ZVh1bHE2QXM4S21QM2pYMFJIcys3K2VJREkybDQvVGtHOHRsQXBWNk5HL0U1?=
 =?utf-8?B?SU11RjdINnplTzR5MXRDMFpQdGlzenloV0RWZzVBZFZ5OW80U2d0QUtTVWl6?=
 =?utf-8?B?YU95S3A4TkorL1JYdWJqWHRSMTRNMWU3dWRJZU9OdW1tNHl3S05ydGJ2YXhJ?=
 =?utf-8?B?WHRrKzI0VWQvU3M2ekE1OW9UemcxOVBRRi9FbGhhd2VMNzd1S3NxRUp5YWNF?=
 =?utf-8?B?azhxK2psdmZrME9haldieTg5dm4zYjMyTWdXSXNWQTU4S2hxVVFUcU9iYkx0?=
 =?utf-8?B?WW0vSVVRWm9MNFJmOGpXL2JJdmp0SG1OMW1NTEUwZVpET2RPL0cxclBxTDZP?=
 =?utf-8?B?ZXdqdDc2eXZydUFDZE03S2ZIR2g4c280aWVMR3NTR1ppQnpFVThLTysxM05o?=
 =?utf-8?B?Z1hlaVN6ZWUyenpoMURkUlp3SGtJQTZiZUNLd29waDRBd3lkL0t0WFJrOTBy?=
 =?utf-8?B?THpJamZoeXcxNHQ3K1RYMlQzai9zNmgrWDU0TGZHTktyNHczQjVvVnl5TmNm?=
 =?utf-8?B?eldWRzgzKzhvVGF4SlhwSjVZbFJNbzBNOTM4Yll0VHdTWSs1b2gzdW0yamNH?=
 =?utf-8?B?UU05WTNNeFpFZTVOVVhBdFZuSkU2YmNicHdhcit1aElpeGJFYVUwZHRmOVpo?=
 =?utf-8?B?ZEo0S2Qya0JCek9RM081VDVBNlNBd1FQUldNUE1NMStKWG94VjBwN0YrZ0w5?=
 =?utf-8?B?UUNnUjZtc3k4eFl5cExka0VPL3RWQkhCd0UyL1o1WnJTRUNCUlk4ZWVNZnZD?=
 =?utf-8?B?TGliTFVwUFcyYmJTbWcyM2FBbHZheGlwN1NLUmFGTmpXaWpRUkx4REpuQzVO?=
 =?utf-8?B?QjZWZSs5eGFEczhSOHZ1dmREOVJQd1BFQ2Vkb3hhRGM3a09xdUQwODFiRGVn?=
 =?utf-8?B?dytpOXJLVVNEVWc4Tm9HY1VXNXRrY3FXSXMya3hySVlPZkZzL01mdVl4Z1d3?=
 =?utf-8?B?VlM3RjBBS2toU0RDYVFzcGRqZjRjOUlOUnA1OG81cDRId0JINjd2SUd5a1NV?=
 =?utf-8?B?U05jN00xWDZSekdRMnEzalBWOG9FaGJSSjdUbXNmUHo4WUxZZVJPSnlNTjJt?=
 =?utf-8?B?dFpjMjhzR3NyS1VvNE5ZTmZFL1pDZk9aWUtyekpJMnpaeDNabS9tRWwrUnBZ?=
 =?utf-8?Q?YGAwjthd5mvbX1kakjZ7RAc3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa9cc1c-cc53-4171-acb8-08de15cc6f23
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 02:48:11.7385 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zKkCpC/JTPl3MZRK7uUKsyr3ZCtb2WZDg65xAUwSGHjspUAHCBVcm1cklsN6BzSFUV4eQWDBtdEDpCvpN/tVOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7891
X-Mailman-Approved-At: Tue, 28 Oct 2025 09:05:24 +0100
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

From: Alice Guo <alice.guo@nxp.com>

This patch adds SPL Kconfig option (SPL_PHY_IMX8MQ_USB) for the i.MX8MQ,
i.MX8MP, i.MX95, and i.MX94 USB3.0 PHY driver, allowing the driver to be
compiled and probed in SPL stage.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/phy/Kconfig  | 14 +++++++++++---
 drivers/phy/Makefile |  2 +-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index d36a5f00ef8..420d7c7a44d 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -289,11 +289,19 @@ config PHY_NPCM_USB
 	  Support the USB PHY in NPCM SoCs
 
 config PHY_IMX8MQ_USB
-	bool "NXP i.MX8MQ/i.MX8MP/i.MX95 USB PHY Driver"
+	bool "NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB PHY Driver"
 	depends on PHY
-	depends on IMX8MQ || IMX8MP || IMX95
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
 	help
-	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, and i.MX95 SoC
+	  Support the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and i.MX94 SoCs.
+
+config SPL_PHY_IMX8MQ_USB
+	bool "Enable NXP i.MX8MQ/i.MX8MP/i.MX95/i.MX94 USB3.0 PHY Driver in SPL"
+	depends on SPL_PHY
+	depends on IMX8MQ || IMX8MP || IMX95 || IMX94
+	help
+	  Enable support for the USB3.0 PHY in NXP i.MX8MQ, i.MX8MP, i.MX95, and
+	  i.MX94 SoCs in SPL.
 
 config PHY_IMX8M_PCIE
 	bool "NXP i.MX8MM/i.MX8MP PCIe PHY Driver"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 98c1ef8683b..5a6df0ecfeb 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_PHY_DA8XX_USB) += phy-da8xx-usb.o
 obj-$(CONFIG_PHY_EXYNOS_USBDRD) += phy-exynos-usbdrd.o
 obj-$(CONFIG_PHY_MTK_TPHY) += phy-mtk-tphy.o
 obj-$(CONFIG_PHY_NPCM_USB) += phy-npcm-usb.o
-obj-$(CONFIG_PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
+obj-$(CONFIG_$(PHASE_)PHY_IMX8MQ_USB) += phy-imx8mq-usb.o
 obj-$(CONFIG_PHY_IMX8M_PCIE) += phy-imx8m-pcie.o
 obj-$(CONFIG_PHY_XILINX_ZYNQMP) += phy-zynqmp.o
 obj-y += cadence/

-- 
2.43.0

