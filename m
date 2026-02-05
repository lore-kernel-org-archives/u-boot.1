Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2894E83F1F
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27FB583AAD;
	Thu,  5 Feb 2026 16:16:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kcC5yjIU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3F5183AAD; Thu,  5 Feb 2026 16:16:22 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1117383C39
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSBP99A3DTGcTSqCT0eV50Dpn6JFZYpaawM+xuEy4sTEy4lC/WDuIObk6x3rqBeDBtI/hOvU8QMWbs3d7j+HKPa/x1w+uZlJtCztsLHXJdSi7wuyfaoap+hzpYbTVNK5QtxlBwl3tb56ml1ZeMzR5V90mIr3x/Kr5aDJwN9zSTDw/s4V+gBDEhqgP6eWPBRW3ZvAqWEHViOPosqpmbDShOyYiDUQ452jubR5O0MTL8cy2PJxvU07jqnkt4lkCEaxGXipd4LxCNs8PR9I2S4w2A4U8PIGoLxtNUH8qzyI2LLgeFWrYOifFrsmMp3wJ56hDJdztANjfV1GtgM9z+w7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oyQVXQ+D2NYXiEPLTgvOrneGKGCSKGO8ilRdrY8TLfw=;
 b=eAOjp5W9JN/JDG/we9eQeQXUbHUnTlm/HeWp4wjeftqD4+IAOFJyS6m2S1uHcinXgALv/BDxg5pZLFEDYD0eWBChiqBnOrMuZhYHYOftBOD/EWC3NCnsx/5w2E0DcOu0uDl7A+JxecEHkplHUECGUcixFoXyWRLTZRGMeGZ+wKNHdLGCFW8Y6kvFWIVXsJMBxQSotexj2GLW6Jes07k34utbh+WDOLaxWkKha6Ugf7VLn07J+uvgiMtXolDsRyCTN7GYjeYAg45RXHzjOI+9ah27gr3VRjyr5sh4wGZz+k/KnA+wicYCw9IKjLvUKxmZmhV0VrHCGu/skXwqdQJIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oyQVXQ+D2NYXiEPLTgvOrneGKGCSKGO8ilRdrY8TLfw=;
 b=kcC5yjIUVCSKlV/ylX2wtkOuKk3zF9l0TKvzhm+W4OWrCocJ3a27GLIfwQi6OdOmZVCXdDiPojeOZMgz16N3RB4yrB3njRDa4KWmyAWymTIO0h48JmTdJNAvgrI9XsxBMeX7sfAZB5vNzQ8wMWLGSTXx8BNbK/afXnzuV8fNB7HRKlWXb38DCta08xm6l4yr860m7jfWdIE9JLrQ4UMMipuWjGC+dd8LzYWU7+xPQ75bNOMV4s/QayI+Iqxmak5fyVg+4k3g9mqjIOTNMuf+enkVzi8fe3Gv7G5BPFD8dXy1ZRekVgoY3nV7JUAS44qAp8DJ32btZUAR7HClw2EGOg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DB8PR04MB6969.eurprd04.prod.outlook.com (2603:10a6:10:11b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:16:16 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:16:15 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:15 +0800
Subject: [PATCH v1 09/12] cpu: imx952: Add i.MX952 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-9-2103d0222a0b@nxp.com>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
In-Reply-To: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Valentin Caron <valentin.caron@foss.st.com>, 
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, 
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>, 
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 David Zang <davidzangcs@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Marek Vasut <marex@nabladev.com>, 
 Joseph Guo <qijian.guo@nxp.com>, Tim Harvey <tharvey@gateworks.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:4:197::22) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DB8PR04MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: 01c7cb20-fa5a-45dc-41a0-08de64c98150
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|52116014|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlNHWnFCUytwKzZMS2xOUXdYVFBpZkVnWENQeXQ1Sm9jbXB3OEU4RVY4dTlF?=
 =?utf-8?B?TTU4amM3dE90NU9aWWdKUEJ5MjJabGIzWFBoYWt2TlJObzVsRjRmckNGQzFF?=
 =?utf-8?B?OFBtL3kvYXNtYjFhMFh3L3NXZEtJeXRrT05XbjJYc1VHRDh5aTlMTlF6RG83?=
 =?utf-8?B?TXdRWUR2aWNlVTNlMzk5emx4WUhsM09maVUyMExVSUhFN1gvaGJZUHJDVEJ3?=
 =?utf-8?B?SmlYbEFlOWk0b202SzBodkJ0aWIzY2RDTFNwL0pDcU82bG03ZGpLNFhPd3Jp?=
 =?utf-8?B?Y3c5dlNpLzQwNk5MMzJiZHlNYjQvMGlGWTdncTlKVlVHeHc0dGlONEtqMFJP?=
 =?utf-8?B?UlZvbWpxSlo1UitTb0tCcE9xQXlHQWsxNDlTekhqcjhIRDBQSXJzaDlNMzRx?=
 =?utf-8?B?bU5RdTdndFBPSUkzL0hpU2o5Ymw2dVJlN0MveS9CUW12emtIUHE3SWpwU21C?=
 =?utf-8?B?VXpNNlFMbWpZOGNVRjhnTlpwWmdwQ1BoSThDRWI1cG1DWHppR0pwT2svOXFT?=
 =?utf-8?B?ejBkamRCNTlNRG9qL3BuNGc0TGpzTHBJaGd3SklvZGpqRjZWaGcwYlYxY1ZW?=
 =?utf-8?B?OWNMNDVwZjcyUExpTGlMWDg2M2N0cWlBTGVrejlweHQ5TWMvVGVFQ3FmL1hy?=
 =?utf-8?B?TWtnL3AyS2MrQXhTR1N6SWM3MHJrSlVmb0dGTWlCbFhxYWxYQmwxeW5EK2xM?=
 =?utf-8?B?REF0djAyMHpETnhIeTBTMlFaZFlPSTlTRU9UMGhmZ3h0YWtuVEl2SloxbDlq?=
 =?utf-8?B?Rk83YUQ4b1FLYXJKUVZqSTZpdHN3YkYxM0M1cmVyZ0lZS3FrSEMzZnJzUk50?=
 =?utf-8?B?SVJoM0lMcE9DQmcrWjhEc2RYYTIySldlZjBsaDMvV3lkUHZmeXBuTmRLTnhH?=
 =?utf-8?B?a0grZ2lpcEhweUNQU0xqcFpTczIyay9vMnBaeVNDWkhsZE9YZ1Y2QTNWVmsz?=
 =?utf-8?B?bEJkdGd3Mzl1VFM1dkNHZERpL3JlUlNLSGlYVG5zTEFqQnNGZlVoQ2dRZFIv?=
 =?utf-8?B?Q3dFejc0VGk2azJTeDlpbEtGN1RlTldDL01Tc09jb0x3eDg4Ukx2OWw4UjRw?=
 =?utf-8?B?dVN5WlNBeWxLR2ZKMjBwWmQxNmhBVUd4VVJ6NWIvQk1HRFRKeDNTdjZjUFdR?=
 =?utf-8?B?T3JGdTFjZG5yWHFrOVVXc2Y4WkZZM2xsbGVWQTJzM1pueXdKTUNRd2V6QlVn?=
 =?utf-8?B?bTNMaTNCRVNHUEw2SmEyV1JybVNIbWNCQlB4QzRJNy9kZ1hwN3hpQ2oyRTVM?=
 =?utf-8?B?bXVmVjBiVFh2bDcxcW82SU9xb1B1MDY3NkRkckdtemsxRVNRTG9DL2NkV011?=
 =?utf-8?B?Wk14VUpGTG5OU0VXM1VqR3V1YllKU3U4QUtieEdRMFR1bTZRRmRKOXh1dHMz?=
 =?utf-8?B?V3ZaZVIzRVQ0SVdBL0NPNTN6cndGZHdkZ0xoUDRCRkdocitsUnZIK09idnN2?=
 =?utf-8?B?eCtRbDVZbTlIOTZNTDdFVzZsTkJ4Uk0zd005OU85RklCSzJXR0MzbzhRbWdS?=
 =?utf-8?B?Sy90N1NraVFjMnc4bVhMNWpBL0Q5aFo3Njl4U3hxMmw1RVVLTWFlYUxkZWhK?=
 =?utf-8?B?MGRkSlAvaWdEQW1EU2NjRWR6cWlQNmptN1FodzBqTVpVOXdsMzcxa2R4TnlB?=
 =?utf-8?B?MmJOYXlISE43R2FOOElQOXpESkF1cWx5ZytnalBHN29mYmRLeWxJT0VUUkFr?=
 =?utf-8?B?c2xmUTQzZGRQdnlpaitiVUlJY1hBMXpRYTFmVmpuczRlVnJGYzVFRmp4OWE3?=
 =?utf-8?B?bVJrdnlKVHdkams4UlowSzNQSWRwdWFlTFlUY083WU5URVhDYjR0RUFiS0Zk?=
 =?utf-8?B?UUM5RWZiVlk2cnBNeWc5dWUvckVqUjgrSGM4Sk5oZXpwazdhZVd3RUJ4ZVQr?=
 =?utf-8?B?RUkyQ1N6ZHRLV1IvRzJEazBnTzN2RldMZDFzekVybDBVL0tyL21FVGZ3OVZB?=
 =?utf-8?B?RTFlN1VCVG11c3ZlcTZpZGJQT1NSS255UFJpQVN2eWxYeTBKcm5vV0x1L3Zi?=
 =?utf-8?B?N2d1eFNJOVFwd2trYjJabjIvcHorZVJkNXowcWxSWWl3S1J6elREQTIxU2RS?=
 =?utf-8?B?Q2krWEtqenNZME9FZEEybjhueldOL3pIN1M1b3Q3ZXgwakJGa3ExaVJvK29t?=
 =?utf-8?B?SERkUDBnR09PMzVyeTBzWGthOXR6Q3BoSkdDaFRpRTExejl5TUpNRlUreGQw?=
 =?utf-8?Q?t+NAzIl4zKxVrL3gf+BqlN0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpydGk2ZDU1anpHZko1T2dLNDRRS21hTWNrd0VHU29BSzQxNjVyZC95UHFI?=
 =?utf-8?B?Z0NiUTNYTDMvSUdDcWEyK1B5U1RuYmh6YVVDdkhwUm5DSVFoQm4wUGZvRzd3?=
 =?utf-8?B?RlNXT0ZKdzdPRmVpeERjcFIxQ0x3VXZRc2JUbE96UVVzOVR0eSszU1BRYTlr?=
 =?utf-8?B?T2dSeEl6MUMvTHRmVXRIYllJZzhFTzI5UzJjYXB2dklodyt6ajNYQVhhUk5T?=
 =?utf-8?B?L1NTaXZWZ3lGbDFsWnl2VVQ1Z0M4WDVnQm5nbEFYY3lXNFNUNHg5UUhmYXZV?=
 =?utf-8?B?OW9DMTd1NWM1Y0JxeVFGYmx4SmtSZTRYbWhISG1KeWdxVENqSWJidXAyc3JU?=
 =?utf-8?B?bWdOYzBVMHZJYS84QldJL1RDY3FxVkFERE5XLzdyS1NLSWsxSThFOVpFbkR0?=
 =?utf-8?B?N1hMekpCZ0JrRHJKSUozb1daa25zV1FpNm1namhVbjBsdkZMUlo3Rk84S2Vy?=
 =?utf-8?B?RXdYdVQ5ZFJUaFVGQkVhbjQ0NEV5a1FYTHdTL1Q1akpNdk5BaEhmOWk3b0Na?=
 =?utf-8?B?c2w1WDg1REZwaENLeFRpYUpMRkdMNzZOb1d5TWFnOVQxdVlwNnZRTEFqNFpZ?=
 =?utf-8?B?cTRWa3kzK3JhT1JFR3VZTUNxZEl5K2cwWWQxN2dTUHdWMkU0dkQ1NzhmeElK?=
 =?utf-8?B?RStEZXh0WUVVTFhmUmNaZUppbndYWnYvRUZESGNmWHFmanNkRVFhaUw3ZC92?=
 =?utf-8?B?RGtaS0dsa0Ywdi9PRWJPNjZRTGxoZ25EcG5QU0hlUWNtT0N3Wk14U2ZubHZn?=
 =?utf-8?B?VFJyb2crRzdLZGxWMXhqN09zT0FoTFVUeFZVSVJIRmVtUFJKQUtWODZVQi81?=
 =?utf-8?B?MUFXWTFtQXIxTTJvMnhvZ0pWNFpncHcrQXFWSU04ZUFhWVM0UE9BemYvZnEy?=
 =?utf-8?B?U2xPaU90YzRwdGRnang2RjhhZGhpSXllUUxxOUlaTVZ3NnBMU091K3Y1aExT?=
 =?utf-8?B?RjdYb09XYzNmd3BQV2dBNWZVTlp6UzVxYXorUmZYMFp6L1c4NE9IOXAxSTNX?=
 =?utf-8?B?K0V1eFc3ekhESGo0ZnprUHBUUnUvOGdIZUt5dlR5bjVRY1B4emFrOERqbHFq?=
 =?utf-8?B?NXNsMG9URjVuZUlmQkdvOGRETXFjYmNGSnlUQ3BITzA3ZkQ1RUxTNkFBbGp3?=
 =?utf-8?B?dzVmdldQNW1Jd1VsU0M5YmpKWWtYemliWlNwbFU0TGtnRnJzVmFraXoyeWpY?=
 =?utf-8?B?Q3grYis4UElrZk9XYXV1bEs5ekdXL1IyYk9vM1l3d2lzbHVPbHhnOXc3bzhO?=
 =?utf-8?B?WTlJak5FMTZFVm5nRTNwc1JIeVdiM2duQVNLNEdQd3NLMU50dkZ1QnJ6VjJk?=
 =?utf-8?B?MHpaTi90ekdFQ1lyYytUeXZDYVZXaFJvRXY5RlR2NnVVOWZ1Vmlyb1pOQkRM?=
 =?utf-8?B?cmc4MUhPZm8xczNxTnYwQko1VEllU3B1S1p1emNHMnhzcXUydUp1VnRMYmpp?=
 =?utf-8?B?d1o5YldJWWY3WkdoVnlpQlpTalFpSTJjYW1SQ0FleHN3YzJPVUoxbXQ2STF2?=
 =?utf-8?B?alpDOGdSWGJPTUFsMHU0TUpXc2ZUMGNKY1J5S0RCVG5iSE1tR3kwaHMyM3Av?=
 =?utf-8?B?aGJtUThMU1J6YktCYnZ1NE1aNzBkaWpnNjh2ZXNyOTJMWlA4Ynp1MkRBZjRr?=
 =?utf-8?B?Z1VtdlBSd080dlY2aitSOVpsWDNFM203WHJZNGd4RUVRTFdzaG90UFdSVVNC?=
 =?utf-8?B?bHR0dTlPbXJjc0pMaFhGbEtvakFnbGFDVEVzWjhONkdkYVkrbEpEQjE2bUdv?=
 =?utf-8?B?SCthVlR3R1F3OVJyWkJYbzN0eVFPTlJXSWVlek85cjFteS83SEU4L0V6UDlC?=
 =?utf-8?B?VmRWTnVuZHVCeGNlWlRMZHlXMWtCOHZpcFFzT3cwVHVVV1M5WlVMN3BHMlJQ?=
 =?utf-8?B?aVlVM01PTHhEemVLeWNmRW0wdzloU0NyZ0hQOExaQ0g5RnNDSktDc0FkKzl1?=
 =?utf-8?B?VmVlLytsYzRlSDdaaTMxYjd5aFJrU1pWN0FmSmFvN1BiK1A1SGx5MXlRb1ZK?=
 =?utf-8?B?ZUtLcm5yd3daaGhoODF6NngrTTFsdS8wOW80YVM5Mnl3cm5oYmRxbDJCRWVw?=
 =?utf-8?B?MzdydjJ4cjZUME1SMnlVdFZCOTFaM01NZ1lHczQwM2VaSDVtMU5pQUFiZ0lU?=
 =?utf-8?B?bzlpb1M2SFhmcytwWjQ0ZG54cFhva0xGanRJTExRdkhSMTV3T3ZyNG42N05Q?=
 =?utf-8?B?d2JMS1QyNjdLRkVIR3ZDY3k4WHFCS0Q3bVZuNFFPbXVHdGVMZlQrSE55bzJl?=
 =?utf-8?B?MnRkbmpmakZ1MGV3WEVSd2JvYzNxYmE1QnRYOWJYbmpFMXJndE9FU29ML1po?=
 =?utf-8?B?c0dJazl1eFZ4YjNnZncxaWhpeVhOaFNmeU9DSGdGanVFeCswaDdjQT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c7cb20-fa5a-45dc-41a0-08de64c98150
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:16:15.8073 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ov9Bh02g691USDRXwVWbKctSAKf31GbHNz0IJeDEZOwHvYfzs3UsByT+pPpuukwwUvCV6PGxinnNe6hWIgKsWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6969
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

This patch is used to add the imx type string of i.MX952 ao that the
i.MX952 CPU info can be printed.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/cpu/imx8_cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpu/imx8_cpu.c b/drivers/cpu/imx8_cpu.c
index 5f17122c36c..1c78f882775 100644
--- a/drivers/cpu/imx8_cpu.c
+++ b/drivers/cpu/imx8_cpu.c
@@ -115,6 +115,8 @@ static const char *get_imx_type_str(u32 imxtype)
 		return "95";
 	case MXC_CPU_IMX94:
 		return "94";
+	case MXC_CPU_IMX952:
+		return "952";
 	default:
 		return "??";
 	}

-- 
2.43.0

