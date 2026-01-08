Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EF15D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:35:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79FCC841B8;
	Thu,  8 Jan 2026 14:33:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qmTf83x6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 28436840A9; Thu,  8 Jan 2026 10:52:50 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B83A83A26
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 10:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XWZLucnR5q5i/UmaCW3XaMk2ZZJw2Lc5Aq9Sz8WtQlnymPOQLKPPkQAQWO1mqkKi4cjGvWi/RGZAdrYF3BF+YmzEx79YWDZGPchZEVta8REh8L2v/kg2hjfEgizBhot4a1nQvQOTgKk5CtxP8mY8QfyDfuE4CfIg/8vmGEELVF5KzXum4AFFv6zMQ6wmq5wmoYrLmQsnvy9y8CA5lIilyy44jUgwrcTXexh98nscWzquoH1tTV/FnLA0xKQAsd7fuzqu7BY+V2XuwFLJUC6T8GUH1P0V2PlT4vLqKbTi34AbD5EOfSoY9wA4BBH1sbZd4E3kJ27bUvEau2vtdWXgsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s71e4fVIvkRXoPskqvA6m9ofLCOjPUAs+Ov1MEZfToY=;
 b=ufWOAfCSVRvCUttNJ2rvxLmQHcGCXngoPHIe2FJ1F1BnbvqJj/A0N6sSRMxQB4a1yDqtcGzjYZo43/Z56TNA5fVk66PRfXE8teBshjpRe43OPiCBdog423OxpmuVomvx2c0k1g5VvAPd8Hi+6nZj8soo5HfJcym0aPM1l+ba4oitYLZmpDw7zB2+9Dknhxywf0ERsQMqDUnHZJ8oMRP02cPjMsr6+n/5RRPqwaZ2IXp6xt3arhbGnVYOhP12C6Axgo448Z0cyIBGZ0BS/5jjEgrxrfiM5dVdqP6bhmSeBEwun5N6oEG95RVsTjCJm6xz+B03BSN0ygirYnkgcBe/7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s71e4fVIvkRXoPskqvA6m9ofLCOjPUAs+Ov1MEZfToY=;
 b=qmTf83x6+3KxV7G7lNKId4+1s50ZmLCypZZzDnlxJWUD0r1Yr16PtOdDo+IvibVyS+DfoNO7waKHveQ0MXXyqrqnkALsuFrDstMTF2jA9VH0FrpPBSmIE9WTiqGLJVDjRMYUEF9/Pl6yc02h8lpSqjcX78zJgje5hqquOKCYG6k3qeQz6BKCcnRMG1bFb3YHf6hK7ToFQhE8yTe2XciBBDhcI6WskCOX+e6Dlet+aMtbmJodfPvW0O1wD8c00VGh9HsTj61b5DxxKivcBuZjG5u/Ao4VGnoU5ia71EyNyhehGpjZ5egwssOnxwlWe/s4ewQV8vhZcQOj7KjklHmEsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by GV2PR04MB11681.eurprd04.prod.outlook.com (2603:10a6:150:2a7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:52:45 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:52:45 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 08 Jan 2026 19:06:46 +0800
Subject: [PATCH 01/13] imx93_evk: Drop UART pad settings
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-imx-update-v1-1-0d5921c575bb@nxp.com>
References: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
In-Reply-To: <20260108-imx-update-v1-0-0d5921c575bb@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2P153CA0025.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::12) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|GV2PR04MB11681:EE_
X-MS-Office365-Filtering-Correlation-Id: cdb0d4f8-d629-43e6-45db-08de4e9bac4c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFQxSE93WWNPTU85RmtGVmE4ZGJBbi9QbHRLZFREMlNRL0srTlZIRDdDbzFW?=
 =?utf-8?B?ejhvSVlOZ3ZxQnBvVG5oaUtwN2RNRVMzMm5sL0tJM2prMWJxSklPdUZ6ZzBT?=
 =?utf-8?B?TWY3ZjNpbTB5L0gxaUN3OStJaFA0Um91SE5HZUZFbkNwakxXYktOSGRpQ0M0?=
 =?utf-8?B?bHdoM2llMm1yRUtNdldNdEpGaVJzOTlxMVhxam1TUk5NMURsR21OTFQ2NEkz?=
 =?utf-8?B?RE03bkVPV2REdURkbTMvamIzNjk3RERBaVlKNlhzQTVCbFV2by9VTlVRdmJD?=
 =?utf-8?B?RmozZExyTmE1bE1YRndrblF3bnordURrMXkxQWwwUXljeHhseUNGS3dNdHBa?=
 =?utf-8?B?bXZLMktSeUx2ZDhoQ1RBc2Z1c0N5dUFtd0hEWE4wVkdJU21tWDlZbTF1Smw1?=
 =?utf-8?B?cTQwZTlBLzJDemdRZnBlaERFRURnejNDMEIzdW5weG92S0ZxWlM0VzlaZjY1?=
 =?utf-8?B?VlJ2ZkpWYkoveWdxU09nQzJLdDYxejgzYkdDbHhpYkQ0RWZMWW05NklUbGdQ?=
 =?utf-8?B?ZGExRWZTd3NCaEVDOUpkWDZULzUrTjVpUE1Zc09teFEzQkVHc0ZUelhWTXJL?=
 =?utf-8?B?aDdFeWpZQUV2cjQvcjJicTR0WEVoa085SmplUytGcGhJMTRyQ0VkaUJrMFB0?=
 =?utf-8?B?MlJ4Z1BER3BPaFNHM2t5MUdLZG8yVUR4WEpoV01UOWEyRnNuWWNzQTdXYTRM?=
 =?utf-8?B?YVJ5SkdsSzJkSW9XRTJMa2lnOUkzU1B0c1Ntdk1nNnYyOGY4V0RraGZWWXNm?=
 =?utf-8?B?bzVEc2M5NFRPWEpROExmWE9xU2IyOGJWVDZ6dnZyRXVPNnpLbzdDZEFRTC8z?=
 =?utf-8?B?RE5XaDd4ZnRxektteWM0RGFDYnNFeWxjUTVaTGlEckthYmw5ODlDR1U2ZHly?=
 =?utf-8?B?RXJPRlNZa0lsV01qUjErWUxBakh1Rmh1Yzh5S2xGNHMrTUx2dVVwTGxpakRD?=
 =?utf-8?B?d1RpTmgyVnRJV1R4U2xvYmlZbjI2UjR5OHVUanpIdmROYXZ6YnZnY3BoU3BO?=
 =?utf-8?B?dGFwS2h1bHlQbE16Y1F1eWh6RkZmdFJDZU8ramRMWlVmMXNGVlN5dDVnUmcw?=
 =?utf-8?B?eG9KNWRESkYwRE93ZURkQTg1Wmt1M3A3WDNPVTc2SWVIc0ZiMEQwV1YwNGhH?=
 =?utf-8?B?c2hEaWxjT2ZCWDI3KzVOMGpHSlNHc09NZUVPdFJPL3pSYXJkaHdGVUhHSHdX?=
 =?utf-8?B?M1RsZTV0MVNPZDF5ektKQXpyeXp4bk41RnVDSXlKditwQnlZT2hDNXlnS2gy?=
 =?utf-8?B?b1dOeWlmb2NxTmppOWFoRWJjMUlqdlRJWG5UTGcxUy85YStSSGs3WS9SRVFr?=
 =?utf-8?B?aTN2TUNXR3RMRkRjWmtWWUZ6VU00N0FVdmxFZDVJOElDdTgrN3RzY0NhRTBo?=
 =?utf-8?B?L1c0TEN2aFM2d1cyNWNlakJ4OURsai9heWJIVWsrdXZEOGhXSCtwUk5XVXd5?=
 =?utf-8?B?SVBjMUd3ZWpDVVlCZ3Q5T3NtSnFVcWd0QVN5Q0tIeEtXRWJCWk5KUlhPaUZi?=
 =?utf-8?B?cHRqTlUvc2FCblIrR1ZYUHYyaW9lZmV1RGE5ZHkwNTNSWGRwSnJqeE5xOEFm?=
 =?utf-8?B?MzIvWHE1d2l0K2d5Z2pVcVg3aVlZVlpBN0xSZ1o1dHFQUGZ1b09yOUUwSUY1?=
 =?utf-8?B?RVMxNWdSL21Oalc4Mk1rN01tcFNhdFVPSDVTSlRxZUliS01qd21SYmFVM3ZB?=
 =?utf-8?B?ajJRdHE2L3dVZWlNYjZKUWR0VXdWekFXR1BQUzBvcHVGV1Z4bWVpM2REN21Y?=
 =?utf-8?B?QzZGekFXUkFQUGxWSkpPNG1uY0I5eWV5OWsyYUF3U2Vsam9IQUhIOXpCUi91?=
 =?utf-8?B?UWlxRDhDUkFmczJTV0dEYi9DNjY3cWFOZm50WlVDOTd4cFlzVmMxUjlsQ0N6?=
 =?utf-8?B?UnVnTjlvM0Q1REZCczkzRnJEQm8zcEhvQWNRN09tb01QWU00Q2w5Vk8zckpM?=
 =?utf-8?B?NldSaEJlMzJtOTJrYXBSRlpzWEZYaEt2MEkzbHBiaE1GeW5mS05LYjNLYTl4?=
 =?utf-8?B?NmhzVTZWVkE4bXUwVVhobnZzcWNVWWN2d1Z5MHhabEZ3Z0RTQWd1YU9TRFNv?=
 =?utf-8?Q?WrlLkQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZ5eDg0dmY0WkxqZ3B0MHpEMDBJLzJxUUpoMTVaRHJ4RFNWK2RkRWxwVkNZ?=
 =?utf-8?B?SHQzMVJKZUllb0hZaUUwWVorOWduS1ZUNE01NTRya0ZvUUtRdTNabElYY0VB?=
 =?utf-8?B?L0VvaWNMTFdveXBQaFlCbm5VZEgyeEJXQXRPMXVTQWU4NVhvWjZZa0ZMT09E?=
 =?utf-8?B?eU51VHpkSXlMSFNXSmFTcnVLbTl0dmw5UVUyRGFMR0pIVlc1TEJSRDZjRFVj?=
 =?utf-8?B?Z1Z0SVA5NDRhdnFyK3Y3QVVHRXlreGdNbnVFUTB6RkM0Zkl0Qm5EYTdyK09m?=
 =?utf-8?B?YlM5KzFtL1FNbXZ5enVQVVV3UlRBcnBlK09xRCtKTmhJUzhNc0NLNDR2WS8y?=
 =?utf-8?B?bUdvM212VDA3L0NnNXJ5R0dCbllnL2htbk8wd1VZK3JETzVTOFQrRjY1anQr?=
 =?utf-8?B?RE5KQmgvcDExZW5wbnpkdW5QRWZ2ajc5VS9EUWFGbU8vRytYMTQvdEpGSW5S?=
 =?utf-8?B?dmFsS1RSOEdVU0Y1RnAxZE9Oa3IvYUR1ZFhpUXVRdnp3QWpDRWRHcitBV01C?=
 =?utf-8?B?THlyYVJzYVcrTWxEUWxkYU1UZjdrbUNsQm1oRTdqbWRWRkNJQzVabVlqb2hK?=
 =?utf-8?B?MW0wLzdoSzNsQ2wvMkExY0tDYmkxZjZ2RHpBV2MxUHNtN1FIZDFPT21td2RR?=
 =?utf-8?B?VFhSSWlZMUlnMzdycTd4MHNGUGhKTndCUnZpUG5SSWRjWWgrZ0tmYlFPMVor?=
 =?utf-8?B?akpaNlp3SzF6WVpkc2RHc0JoeGFBUzZBTXMxaENLWmFVeUpNVmhNenJsT1VE?=
 =?utf-8?B?akJqVGJSU3p5K2NCb0h4UGRRVU1JQ1R0KzVUaGpqcitmVkhLVS9VK3h6RWNX?=
 =?utf-8?B?MzdMZ0lRelNZUWNFeW8vbnlOSTlSL3NQRXozTWQyTUZvaUkvcE9HMHdTZU1x?=
 =?utf-8?B?MlozUzBoLzd4RlpVRHo2SjZQbUdmb01LNUZFY3l4dk9xejljSGxyQXZLOWNv?=
 =?utf-8?B?RmxiL2MvN3Y1R0JlellTS0NnaFRYQnpFa1FXQ08xTkYxeGhUR2FNVmxzdHdy?=
 =?utf-8?B?d3YrMlpGRWtyMlQwZk14V1dsUmJVeXdrckdVLzNmeFlZeURicGZsN1oyb3Jx?=
 =?utf-8?B?ZnBqZ1RUdWVqZVVpQTRoQUF0Vm5OMnV6U3I2ZjFldkpneStRdlU4QXZBRURy?=
 =?utf-8?B?V1IrRFo0dWsrTThodVpDdFFGRC9SRDhzdERXeGdvSzRHYnhOMXpuYS9yTnVG?=
 =?utf-8?B?ME41VGw4Z0NtK0IrZ1ZVVlBJR01PS0hIRHovOUcya0ZnUWJhdHlZQ2dOUTR4?=
 =?utf-8?B?QzlYbDllSkJaekNOYloyakk3bmNNVkhnenZQWDIrMkVxS2RQb1ZoYnlVVnBM?=
 =?utf-8?B?ZjRlSE5GeXdETEZ2MlBwTVpFVUNRSUhJQkEyNkNqaG5DUkpKeDJiamVDUHpZ?=
 =?utf-8?B?aXlON3lIYzUyNHZUMTJJcWE1Q3gzU21xWEtqRXZGWDVTK2JXSFBiRElCV0Jt?=
 =?utf-8?B?Nm1EQlljck9YdWlmMHRDYlp2N3lyOWZxZmR5cDl6WEtQQXNLbFhuRHBrRUYz?=
 =?utf-8?B?eVBtU1RQb21TNDZhVmIzSW9tVDNESzR5Sjc3MkQrZFZyenFZWlB5cW5JTUx6?=
 =?utf-8?B?WVkvM0hxWkxncUJ3UDNtczBPdHZoN1Z3a0JTTkRGNHZkcDc3VnVpdzgxT1NI?=
 =?utf-8?B?M2VJU2hLdnNoNjRKbFlnaFBHa2ZKZXdLZDQwSkJESEpFSHQ3Z1UrMTB1Zks0?=
 =?utf-8?B?endEdXorbzRDS3E3czVHUXVSeW4wak8wMStOOXdMZTNGMXNQWEgybVdTV05O?=
 =?utf-8?B?WjIxVTc0QUhoN3NHUnFoSjZ1aGhjZ0VDZExLOWwvV2tnK2Jra3hWY2hhQnNJ?=
 =?utf-8?B?a3phaHltSGlUcG54cFQ5MVFKYlQrUGdNTFcxeFp5OGtMMjFaV0RxRnlwSURn?=
 =?utf-8?B?eitFTW0rMnpuQzR6OCtnb1kzem1mM0prMTVBSEV5WEl4b0pPS3FIL21MZHgv?=
 =?utf-8?B?WUVEQ28vR2J1cklXYk03WVdqZUFLUllFNkkrbkRiUDFxdkxrby9yNGQ5SFZG?=
 =?utf-8?B?THpna0ZaeksxeDRUL05sMGNMelJSTFJzY1RwVDdRMno5K1FEbnM5ZmZmL3hT?=
 =?utf-8?B?ZTdZMGdINVl5R25WVEdMMm9ONWVIanNtRTVyS2xua1ltdUdoaGVIaExYbGhN?=
 =?utf-8?B?VENxUDVxc0VwbXRtVWJlSmFld251Rkg1azdjdlZSWDhWZHhMN2hibGVnc2lw?=
 =?utf-8?B?NnlGRlFrTVBPaDNEWTRCaEZwd21UWjZ1Vm9QWWZrUjg2R1Q2dTB6RFdTZmh3?=
 =?utf-8?B?MVFuVXU0VUM5bFZNZ3gyamliRWZaR0VjL1FTcmlFaE5EN2djc09mbm1OQ1I0?=
 =?utf-8?B?bnhRQ3ByY0tjcnFQekhrWXUvZ29QZzgxa1NSc1V1QlR2UXhlaTlDUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdb0d4f8-d629-43e6-45db-08de4e9bac4c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:52:45.4821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RMDpJahn5Gs34by+PvRxWprYgU4NJWkbRrTMaGl55R7jmZeL8Aj1qTU+InyQoDDYDLIw5I3VJavof1nAwiQ2WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11681
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

From: Peng Fan <peng.fan@nxp.com>

With DM_SERIAL and pinctrl driver, the UART pad settings in board code
could be dropped. Then drop board_early_init_f(), since it is a dummy
function now.

While at here, remove WDOG_PAD_CTRL, since no user.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx93_evk/imx93_evk.c | 16 ----------------
 board/freescale/imx93_evk/spl.c       |  2 --
 configs/imx93_11x11_evk_defconfig     |  1 -
 3 files changed, 19 deletions(-)

diff --git a/board/freescale/imx93_evk/imx93_evk.c b/board/freescale/imx93_evk/imx93_evk.c
index d62f94dc418..371b35bf1a6 100644
--- a/board/freescale/imx93_evk/imx93_evk.c
+++ b/board/freescale/imx93_evk/imx93_evk.c
@@ -11,21 +11,12 @@
 #include <asm/global_data.h>
 #include <asm/arch-imx9/ccm_regs.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/arch-imx9/imx93_pins.h>
 #include <asm/arch/clock.h>
 #include <dm/device.h>
 #include <dm/uclass.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
-#define UART_PAD_CTRL	(PAD_CTL_DSE(6) | PAD_CTL_FSEL2)
-#define WDOG_PAD_CTRL	(PAD_CTL_DSE(6) | PAD_CTL_ODE | PAD_CTL_PUE | PAD_CTL_PE)
-
-static iomux_v3_cfg_t const uart_pads[] = {
-	MX93_PAD_UART1_RXD__LPUART1_RX | MUX_PAD_CTRL(UART_PAD_CTRL),
-	MX93_PAD_UART1_TXD__LPUART1_TX | MUX_PAD_CTRL(UART_PAD_CTRL),
-};
-
 #if CONFIG_IS_ENABLED(EFI_HAVE_CAPSULE_SUPPORT)
 #define IMX_BOOT_IMAGE_GUID \
 	EFI_GUID(0xbc550d86, 0xda26, 0x4b70, 0xac, 0x05, \
@@ -46,13 +37,6 @@ struct efi_capsule_update_info update_info = {
 };
 #endif /* EFI_HAVE_CAPSULE_SUPPORT */
 
-int board_early_init_f(void)
-{
-	imx_iomux_v3_setup_multiple_pads(uart_pads, ARRAY_SIZE(uart_pads));
-
-	return 0;
-}
-
 static int setup_fec(void)
 {
 	return set_clk_enet(ENET_125MHZ);
diff --git a/board/freescale/imx93_evk/spl.c b/board/freescale/imx93_evk/spl.c
index 67a10bbb05b..cba8ccdc01e 100644
--- a/board/freescale/imx93_evk/spl.c
+++ b/board/freescale/imx93_evk/spl.c
@@ -133,8 +133,6 @@ void board_init_f(ulong dummy)
 
 	arch_cpu_init();
 
-	board_early_init_f();
-
 	spl_early_init();
 
 	preloader_console_init();
diff --git a/configs/imx93_11x11_evk_defconfig b/configs/imx93_11x11_evk_defconfig
index 7d3463a57ea..a53e5fc1de1 100644
--- a/configs/imx93_11x11_evk_defconfig
+++ b/configs/imx93_11x11_evk_defconfig
@@ -36,7 +36,6 @@ CONFIG_BOOTCOMMAND="bootflow scan -lb; run bsp_bootcmd"
 CONFIG_DEFAULT_FDT_FILE="imx93-11x11-evk.dtb"
 CONFIG_SYS_CBSIZE=2048
 CONFIG_SYS_PBSIZE=2074
-CONFIG_BOARD_EARLY_INIT_F=y
 CONFIG_BOARD_LATE_INIT=y
 CONFIG_SPL_MAX_SIZE=0x26000
 CONFIG_SPL_BOARD_INIT=y

-- 
2.51.0

