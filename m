Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B70AE91298
	for <u-boot@archiver.kernel.org>; Thu,  5 Feb 2026 15:16:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966B983BE1;
	Thu,  5 Feb 2026 16:16:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Yv/7VxjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6176B83BF1; Thu,  5 Feb 2026 16:16:04 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FA383AAD
 for <u-boot@lists.denx.de>; Thu,  5 Feb 2026 16:16:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bi/Xz7PAFkALJ7wRKDOAPkYD+Drp9xEjHqaRRXdTABZe1kkY37JUxxCh/YPYp6LJJ5VsA1kEILDAGG37aKMHcPr50qoL5boeNOucA14b4ao1wsTIvp+c9VuZxALZuIMQmljBL+klTgJjMKoHHczFj+xHlu/0aJA5xWEW9dn1XtcjtFMsnagDM+Goq3ERSDaXdNQxXSYSTe+zfDv7DOuAcyUOAlTlXt1l7pSpuI43qZck1dYEX0ZxQzXVu+rl4cfDt+JgUtJSvWiOFrMhlzsMu0Fo4qEqve6rVm+Bo4T4eNyvnTrjg2Y/PacouipOHrnRG6btHWTc+8pHVGAQaO9DrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZzfjO/auh3P2kSACacqChnr9j8gZFs5DQjkVj55HNT8=;
 b=Nb/083S4TCEC22AdWnFlTpIkQHv9Ovlg0hlAcc8VB15Asu444QiWvg5smwBPphDX91p5JqCWE/E/vXTL1Gf5Wm14QNsLsKrKE4ctjelFQBTJRbMcjpk5dmAG8oXwA6cDqyT4Vz0avErn8RJjuI8p5NP3+Vnu64NjAkDcrzWAeGcKb8DyF9sxiWeWq6g4CXK6iyO4QrlLoFCMW1eKfcFhfR0H7w2mI1tzG36cln///wRojyqCw4uERnXEw3E02eaDvmR5EV1wcWK5s802CS6y0KfUkP2LqjIdL1bZC5PH/LmD8mq33EGHCP6ImY/UnfXS2iC0RqwOAsv8qt+c9eaCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZzfjO/auh3P2kSACacqChnr9j8gZFs5DQjkVj55HNT8=;
 b=Yv/7VxjBnsRXuA3GN3MZZNKwP5ubOaobOFwWU78pnaoxZSMFpgpeU2hDzF8eueG/gB0t0rh2xioZ2q7/6rBiPzXhsT23cJpZ0XQHlr2DCW17HGCEEt2xvaEiIn+OXm7XRPAm4lZpt0KfYpVQe0ow4zCsZBdLqPj5FtOb2auUnawufMP/jKD6EHSQpjU2YnHkOJ+jowXq/G4zsE7NfFch38K1EWkCBkWpoGfQ8Mc+LBpkUp2P7/FKtJsMWhVVknr+BNqNgYw6STkNMsEtuK4blsdFScsICX0N0HsAUOCdqxBQUwdUutB1mz93W6gevZPGJtP7qXIlCw9wIZq3kd5Z1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7233.eurprd04.prod.outlook.com (2603:10a6:20b:1df::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Thu, 5 Feb
 2026 15:16:00 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%5]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 15:15:59 +0000
From: alice.guo@oss.nxp.com
Date: Thu, 05 Feb 2026 21:55:13 +0800
Subject: [PATCH v1 07/12] arm: imx952: Add watchdog base address
 definitions
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-imx952-v1-7-2103d0222a0b@nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7233:EE_
X-MS-Office365-Filtering-Correlation-Id: 036e6d51-76e7-489b-3821-08de64c9779d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|19092799006|1800799024|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MHdHZlpTSCtLVmlrQlZtZnpCbjdobFhrZVVqTDU0NmhJRXByVGdDeDNUd3ha?=
 =?utf-8?B?UzFBQ1Fia3diSHVwSklFdW9FcE82RWJsSWg0N2FFL1ZFV3ZqTkJ3bm0vdE81?=
 =?utf-8?B?ZENMMUFERHhTUENINGFaZFBlQVhaR1owc1ZrR1BudkcvSnF6L3gzQXp5NXVN?=
 =?utf-8?B?NjBWRVJNamhXcUpYTVZqVGdrT2JlWnlnczlJWFVsY3VhQkwrN2NNMlNFOHpM?=
 =?utf-8?B?b2VmR0JVNWJrQXFZd2lMOUliTWtHODR6Vzlwa1ZQajdvS2xZN1V0aHhvN1N3?=
 =?utf-8?B?U3FrU2RwVUJVTWQzTWQwMm5Ybm5JYmZ6dGczaUtzOVdodi9uRUFLQ1lDMTY2?=
 =?utf-8?B?dklLS01kSDlTUVZUb1RCbHNQNHVEVnVmeWNLaTJ0dUlXbDNUNXRLbEJCU2ZY?=
 =?utf-8?B?czFzY1h1RFhkUnk0UWlaT3pPUGJBSlhqSmM5d2wrT0wrWHJLaHpMUnFnckFU?=
 =?utf-8?B?TkVLay8wbWdzSDdjcEdpZE93cDJETnVLSHBxSlV0WFJ1dlFsMldSdUMzQW1H?=
 =?utf-8?B?VGpZakpzaS9BaFRVTTJTOVFxZEVrM0Q5NWlJS3dDRDhMMmRTQVRxMTFmSW9w?=
 =?utf-8?B?OHplS2daTjRMVEVTdEFKSU5NUEJIQ0JHSVZtMVRnRkZUSWdDUzQrNmFVQWFS?=
 =?utf-8?B?YTBVRzM4cDBzZGZKdVJMRjdFU005YkUwZVlxOHRhS2EyaEl3UlZIcFFEWjlp?=
 =?utf-8?B?QUtxZlNpdy9NMW1aZStvZVVBbFhxek8vQnJsTVNOUWkvZ09lNGlGT3J3RHlG?=
 =?utf-8?B?cEFXd2tTNlVGdUNUbitWTmFIdFdyRExHOFVIeUl2aVlEQ25zZXhtQlZWVzBo?=
 =?utf-8?B?OHlSd1BHeDZ6Szd4Z2NUY3RGbUNFUkorWFEwVFNNOFIyOVd1OXBTQlJKZ3Rs?=
 =?utf-8?B?Wjc1c2pPTG9yQ2thQ0VuSmRTcXZaWTRUOTF5QWdwZWRndUZpWDlCdnRBQlQ1?=
 =?utf-8?B?MEFZNUJUdEFjMUlVdEltQlFZQzhRT3RrVzkwaWJYdFhPR1RoM3A4SmxTbmVJ?=
 =?utf-8?B?YzdOTzZLWjlHenljZUVBcTRoaVhzVmNXOXNCWS9ENFU4R3JERlJ0ckZIeU96?=
 =?utf-8?B?MHE5Ny9Ka3RvV2Nxb0o5aEhncExaTUdBd0xZWE9pNmlqYXEvM1BqT2pmdjlW?=
 =?utf-8?B?U3gyaUdGbS95SEY2d3pyK3dhYk9UcTh0L1NKNnAxb3l6WlQzWkdPekMrZGM1?=
 =?utf-8?B?cTZzQjF1aEY5OGZDcVBSTE5laTAyb084WHJSLzNVd1lHVkhmQmlocjY0TlRz?=
 =?utf-8?B?ZTZHVWl6Y29CaXN0MHRNSzFXc2V5OVAzZUF3MnM2b2R5U2ZpTjlsL0d0SUJI?=
 =?utf-8?B?VHErSGVtcHVETy9qa0g1azUxeVFTY1lmSEdESGZ3bkxueUU2RlhTSVF1Zlp2?=
 =?utf-8?B?L0ppeVB1UklORTlIZDg0dlVXUkVNY3V4MFVPR2ZBT3pYdDN4YmRVMmdySC9N?=
 =?utf-8?B?MWZtWFB2YnNRSnBuV1I5ZldqaFRBRk0wNEJOdHByb3lWVlBuMUhmdEZzcFB4?=
 =?utf-8?B?cEJQcHJMdTVFZmxoOGJNU2pROTQ5UXg5d3RsVEtJMml6VVlnRTBQYmI4NjE0?=
 =?utf-8?B?YVZNN3UvckVMcTZqY2hOUHFFNjIxSkJxamgvbWNYYXVnRnFNbGZsLzB1am1L?=
 =?utf-8?B?c1pzQ3JvZEF1Y05YNWEzUUF1WkxSRTQ3Z1dlc2dJVm5XdWtWeGpRcGVEemdC?=
 =?utf-8?B?a0J1blZsUW9zOExQNUJ1bXFsVHF0QUsya0kvZUpxVldtRDZmUjUvNTUzeXU1?=
 =?utf-8?B?ZS8wTmQ0Mm42UFplTmI3MEI5aXBTU1pSMVVlTnp0RHpsK2hzWnZiMVk1RUN4?=
 =?utf-8?B?RE5RbzVsN0VMU3hER1BXNWpBNDQ1U1dWYjRzU3lwYWN6UFl3dEcwYjZPSVdO?=
 =?utf-8?B?MWNvR3Y2Yit1Q3BWZnd6K2lZZ0FhNDlRS3FTOWRLZGVJUE5FclZzdmV2VVU2?=
 =?utf-8?B?YzBRcG52RUNwWmxnbW5QS2ZralpOMlRKK2xUVUdMWjZidHZvT3BJVUpwVDRK?=
 =?utf-8?B?bWlncTNkMEN3SnMrRUFabkpjUGFib1ZWdWF3NHZuU3dMcXJjcUxaYU5BdzUx?=
 =?utf-8?B?d0dEaEMrK0pMV0VaQ045dzNPRk1LN243RExmZjZ1UlBoTFFtdlQ5NDBQRUhW?=
 =?utf-8?B?Ly9WTXFYZ0xYR1hOV253a2pZanZpR3hNZXRzM1VNWU1KampMbzN1Ym5KVkQw?=
 =?utf-8?Q?Dv6m/LIxSKuP/gL7NAK4GJM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(19092799006)(1800799024)(376014)(7416014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZURNTS9SL3FSUHVCOXBFZEJ2VVM0S1ZBbmxEUENoeXl0aUdXN0IzWmk2UXAz?=
 =?utf-8?B?ZGgrTi85NXZIcHFrajFZWTczdEZzaTBIUk1mVEhiL09TUXlrUGhCbjZoV00x?=
 =?utf-8?B?ak5IendwSmYyME1Od25XN1dQaG5CbXRZM1A3akNtaW13WmozanpEcFc4Wm9J?=
 =?utf-8?B?NGpicktlKzdRWGdzSTR2N3FPQVZkQzBjTk5TWmpjNTFzNkRkVmlQMnFFbi8y?=
 =?utf-8?B?RFFhSWtSQXN4VUQxdmkwNFlFQ25HTGhIVVNiRkpXYmY2dG53akJVd3g3N09p?=
 =?utf-8?B?TnZHWWlCbmErU0RPVU1uMitBUWRMNnA5OVJ0YzBvRkU2bFFMTTVmMHVrQWda?=
 =?utf-8?B?dUNOWVlJTkNrbUpURThiU3QxL0lKNC9sc3ZkQnlCQW04aGVrOCs2UGtHVkxs?=
 =?utf-8?B?cGUyUjRnNk5ZUnpRSk1pMndTa0NVR3NRYlk1MFM5dmRxK3dtdUJvUm5ZcDUw?=
 =?utf-8?B?dVkvYU5NRzkvS2sxWXVHRHh6Y3d5SFpNWEtKWm1hcldEUG5HcVI4RjEyMUpY?=
 =?utf-8?B?TGtxU0lOL2cwcFpMeWRCR3Z1aG1XZHoxV0pUeWVzZVFmZ04ra2xVbkVUY3FR?=
 =?utf-8?B?R2ZKbVVWSHZGMW9YeHFiSFN6bVF5Q25ESnhUaFBlbFBIdDVIYlBuR2hhT2Rm?=
 =?utf-8?B?NG1ZMW81d25pQWZSYnczTWtUUWtXT3dVUG5TcUZSK1NMUFZMbnkwQkR5dnh4?=
 =?utf-8?B?aEFEUWtyZmxhL3d4Y0dZWG9LTlc5STRlNmVmMUJPQ1dIaG5SOWk1cVhDcDFQ?=
 =?utf-8?B?RzkrYkN6TEZJNk1jRGlzazdoWFp6RXhrbVloNDhRSkkvVUVGYS8vMEpSZkE4?=
 =?utf-8?B?M3M3ei9pcUJMbGZaNlhrKytKVmR1WU9hWTBrdEIrb3NkMnJIZFhHblJzZ085?=
 =?utf-8?B?UU1oVkhIYVprVkhlMWFTUGNYMUlUS0MzVitYZGVBNi9FelRzaFRoTDNCQUlY?=
 =?utf-8?B?K1F1WURidTM2ejllZWdrWmJ0ODUwdVNrbnFvWVhnamlYTGtKZlF6UjNRanow?=
 =?utf-8?B?cGkvdzBKV2U1UXpCdEcyTFYvZkJuYVpOL1V0dkdIeDBxblFoTnZTVXpqd29p?=
 =?utf-8?B?WTZpMFhSdW9INXd3UHZsRW1SL2ZaUWRPaTI2OWlWWVNKOTJtTDJsWWpKV2VO?=
 =?utf-8?B?VnFHYlNwVUtyWTZGK3E3WkRmVmpRbWd6WkhtS1Bqc2hRZW1xVHM4RHAvaVIw?=
 =?utf-8?B?N3lWQi9Dam54dHdjYytiQ0lQdkN0RUF3UHZtNFdqU0tQbE0wSHFuRTZQSVZv?=
 =?utf-8?B?c3Nya0Q3MGNQb3Q5S0VObEVWSEYralNqYzdPVG5Yb2JzTzRPekJSbVJpU1Fo?=
 =?utf-8?B?UTNheCtxQUpXd1FYai9JTG1JUEVYSzROZXBSK3o3RUZ4bWRMSTZzbkd2TGRj?=
 =?utf-8?B?cm5Cb0J6NFQ1SEgxZ01FV3l0R0JnNVRmR3BDb1hFZDJOZnZzOU1UcTFDTnZ5?=
 =?utf-8?B?OFIrU0g0dFpLemNtbmpDQ0pYQXVhSnRwQmE1VmtybEp0eXVDN2REMk1RcDRq?=
 =?utf-8?B?L2pUT1VodkEzUERHZDFtSGpNeXQ5NDh5cGYzdHVUUFRodHlIcFN6NGJoNktI?=
 =?utf-8?B?ZWJhZ3ZpMGRvbUZBSzhMRW5pNUYxVi84cTU2MFNmMUtPendmVS92dkc1MVMv?=
 =?utf-8?B?c0p6dnVWYzlkaStWYzJKTEhpT1RiWVczU002VHBEQitGSW5Vc3ZFUDRSZk13?=
 =?utf-8?B?eVBCK1kzdUJWYVpuUGNrL1VmNis2T1JHMUdhMDQ5NENCcmV0UHdWc3ZmSnJL?=
 =?utf-8?B?Y1FRMHRHQ1BTMStOM240R3AzZ2c4S3RBZ2hJSVVQdnd5Ung0VDJQL0VsK1pz?=
 =?utf-8?B?VWlzd3Vpbmd0dDNDS1Y4WnBBWjcwdHZ5RTRUS3Zmazh2NTNlQkZGQlRVNEl1?=
 =?utf-8?B?NVNnbk5KcWtKc3hjc2xiWk5Xak5kNWpGeDhodzJZSmRBNCtFQ3crdlpqbHhZ?=
 =?utf-8?B?V0dxeU9QL2dDRkttZlNLMmMrazFGZ0p1c2ozYWhNYVkvQ1YzbmpjWDA3UUk3?=
 =?utf-8?B?ZzhLdmk3TVBqaFZxcEQ1RzhGQ2c1TUswaTFHRU5JN1JtWEZCL01KdGF5T3Fz?=
 =?utf-8?B?OXBRaXMveitQbnY4QUtsTHB2cGxTcUtNdDJNTmN5bzVkNk1wRVlKWTA1bzM1?=
 =?utf-8?B?bzJ0NGk5K1ROalRMd3V3U3JoYmUzODJNWU5MTjB5UVpGUHpoTnZrZ0xUNEtG?=
 =?utf-8?B?RXZhRFVzQnVRYm11Q0NsM29PejEwTGw5bkJuZlJ5ZmRVdmNBRUJqS0ZJZEVu?=
 =?utf-8?B?VFJwaEtyODkzRy94ZHcyQlRpek5PZExBcytDTGVmR1o0TzB6c0dnY0ZCWEZ2?=
 =?utf-8?B?U3Y2ZDhoYzZQbk55eW9XYUM1TGdWZ1dzcVEyRHM0V3U4RG5CYkQxZz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 036e6d51-76e7-489b-3821-08de64c9779d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 15:15:59.6843 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91L+SRUc6s26WbcCS0GnUIEOQ1P91gmaAFBhXygeOCA0BraCefRaFP5unuCargpirm+IHfEFvC63vZpzISfHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7233
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

Add WDG3, WDG4 and WDG5 base addresses for i.MX952.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/include/asm/arch-imx9/imx-regs.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/include/asm/arch-imx9/imx-regs.h b/arch/arm/include/asm/arch-imx9/imx-regs.h
index 2d084e5227a..7c7a34f74af 100644
--- a/arch/arm/include/asm/arch-imx9/imx-regs.h
+++ b/arch/arm/include/asm/arch-imx9/imx-regs.h
@@ -17,6 +17,11 @@
 
 #define ANATOP_BASE_ADDR    0x44480000UL
 
+#ifdef CONFIG_IMX952
+#define WDG3_BASE_ADDR      0x420b0000UL
+#define WDG4_BASE_ADDR      0x420c0000UL
+#define WDG5_BASE_ADDR      0x420d0000UL
+#else
 #ifdef CONFIG_IMX94
 #define WDG3_BASE_ADDR      0x49220000UL
 #define WDG4_BASE_ADDR      0x49230000UL
@@ -25,6 +30,7 @@
 #define WDG4_BASE_ADDR      0x424a0000UL
 #endif
 #define WDG5_BASE_ADDR      0x424b0000UL
+#endif
 
 #define GPIO2_BASE_ADDR	    0x43810000UL
 #define GPIO3_BASE_ADDR	    0x43820000UL

-- 
2.43.0

