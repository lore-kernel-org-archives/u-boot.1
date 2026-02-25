Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABE3F55434
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 00:14:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 889B583E7A;
	Wed, 25 Feb 2026 01:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="hi7H9xlG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D2583E7A; Wed, 25 Feb 2026 01:14:28 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37B4C83DEB
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 01:14:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKDDmeYMdtlPN/1LYrfOcp8Z/hR/OtYHiMAcqkWWKtqBErK27315Wt8ZtfTRSPSmbE8JHLCUOKXjm71/aQhoKaB66DHSQn3HMONJxejVwLFsASXlSlXJxIyPFksJ0TB78zX2bUi9SALG00UMBGscj1NoEEA7eAHjoMRq/joYhiPrzn71RmXd5pQxYCABhQXfP9sRDAr+8NNyBUYzFZ+JnNbgI9WFwgyld6iEaVJOKCUop/P2Uhu89TAmFXT9GGXeJVY5k+nxKVw6xirX/yvQz18YqUvLQ61tGznNSXac0Vt9nFIjHXnXmhcvDEDVbZ+95ld7KJY6PnlTQtsfxof0vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NfMksmSkYLb4mfoeKvITovzJKZurKqLO2XXNf+y8T9w=;
 b=enh8BFQD/BEWbygWXieeXbnNm2QMQh9l0HI+18ItFqMPtb9K8SG398GAPpAeAw6Hj4UQepczflBYm0MkTnx43PUlk/Q1vix5OS1AEj1P9X5pK5B+lBiLxmH3bfDRpJRsOB5BJku9ZmpGZGIOQMkwTWzXTtXW3ChjFp6AoXZmtqJwvyYKVabGMjoDCxLIXTV0zzDpJ73mR1WbYKx/tLAOH8DDqCJghcTbl1W7XDn8CcP2cQxcaeUu5nE8Y+OaqMOBL3pnkGbxaplwe16XvQ+VoQJdjjiTRKPFM5/cPFtLmAEhHHlYX+clefbxKWdWmhFu/MMhmx98mZLT4hoQqBkswQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NfMksmSkYLb4mfoeKvITovzJKZurKqLO2XXNf+y8T9w=;
 b=hi7H9xlGZAegdE25eCfgKobXcHZaZ1QOHOJ3y5BE2ZAOSobtvAXLoFiemF2yLLsgryixoP//Xk7CkRvPPLNgM7HifUQDiHFpEul9zVaBWhsEWSOUDEx3v75OpmCvk3LCkkYD7iK8Gg7XYegKFTt/VHPrV3XZfgdNB23LxdkkTCl789zBr3mYMfgnA9n83CEC3XxxaH4cYAfNEa4/L/R1cVe7TvLMBADrQ16E/gF7CdMz0F1JOXzN54i0Sq0WVSY6sEMFBp1FWar3r1Jcmr49uM2GI+2joXzw5rVaXzuFPyXaPclRFTY2CZhA5uEw4o+MrC3JnDKrwctrb5rAvyvzRQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VE1PR04MB7342.eurprd04.prod.outlook.com (2603:10a6:800:1a0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Wed, 25 Feb
 2026 00:14:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 00:14:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Wed, 25 Feb 2026 09:29:28 +0800
Subject: [PATCH 02/10] pinctrl: nxp: imx8mp: Support print pin muxing
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260225-imx-pinctrl-v1-2-7a149ab8feba@nxp.com>
References: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
In-Reply-To: <20260225-imx-pinctrl-v1-0-7a149ab8feba@nxp.com>
To: u-boot@lists.denx.de, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>
Cc: Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0035.apcprd02.prod.outlook.com
 (2603:1096:4:195::22) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VE1PR04MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c8ea63-f1cf-471a-bd34-08de7402d3f1
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|366016|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0srWFJDSTZCYzU0a2Q5dy9EbC9nbFNRUzJ4MjRYU1BDUVFRNGNUQ2x6VVFh?=
 =?utf-8?B?bmxNMDZLV3lQd2Y2UkwvRnNPZzlTQVgvRVZGSkVldWZPVWxGVG1lUjBNRGZL?=
 =?utf-8?B?a3ZUSFQ1SXA2RG5USVJyMzVUSkxhTFk1M3JwYm53bVppRml2SnNEMmk1Qjdw?=
 =?utf-8?B?TnFCRUgra3JRUkZPK090TUVlbEZYYjYrUlEzUlBEYXkvT2Q5K1lGTVZDY0xn?=
 =?utf-8?B?TkJWMEg5VWgzVGFSK2ZHdXY2d2ZVaEZ6T3VuZ3VScEkySEVTUGxvS0QxSUlF?=
 =?utf-8?B?MkJiWHV5aHVLRm52OFlQSUZNbG0yTW1QSlRNVWFtVGkxdlgwa1lGWGxwOHl0?=
 =?utf-8?B?VTNzYnNDMExsNVozMjI0eFZIbFJ4aC9xYlpMUko3NjNHNTdORXIvVnlUU3dH?=
 =?utf-8?B?bTlmcWxZRkt1dWJlbk1uUlkwTWNQTHF6MFNRYU95cGNCa25SNGJqNGVORnNj?=
 =?utf-8?B?MGszSzVZOGlMQ0FBekU3M1hJRm5VZHRrQitXS2RGL2Z6SGJDOFpRSlArbWdN?=
 =?utf-8?B?aUt1RFJrTTlRWG0vQldhdUZueTJ3VHFVTHZZQ05SeEpVL2dOQXczdjRCV1hB?=
 =?utf-8?B?QjRtcG5kQTljTzZXWW1jcDdDN0xVVk82M0s3V0dKMzNlOXVVTEZZTTJ6NWFU?=
 =?utf-8?B?bjdkbjNUOTZpVDAzUTVJenJ0TU8zSEVRRTFEcDBONml3Vnhua0Y4b255V29n?=
 =?utf-8?B?YVZ6bFdhUGJSUzdBTGw2NEthdWNUWlhsUW53dFdNQXNNZ2k5bDFPQXdNZzJQ?=
 =?utf-8?B?NGVzTWNIcTNnd2hkdnVXM2dyaW1jdXpQR1hZT3F4TVVjVnVuVlk0UTZIKzJm?=
 =?utf-8?B?Ym0xM0dTSG91RUlHRHl2eGREY01yZTcwNmpPMTFkRlVMQXhzdi8zY3p6SFcz?=
 =?utf-8?B?eVhLdzhTUVJRZTdDenBPRzM5Z2UrSlhlenRhbFhVV0xETlRSdVV3RzVLbjJv?=
 =?utf-8?B?Vk0xSG5vVno4ek5rTGtGeDFBelNKaTlPMHFpUGRGQkJTak8wWE14bmlpQXE1?=
 =?utf-8?B?aVBkZXlsTTU4S044MXNRcGpoU2FRcDBhRnppVzZtdnNCN1pzS3Z5ZXJnTGQ3?=
 =?utf-8?B?Y3VKdGpXeFg1NUswS2lBTWNRamd6NkJmcUJWK3FHbWRSNGtEUi84TzJPTGdm?=
 =?utf-8?B?K2NQeHUxbEF2NkVudVhRSHBXRmJhMG1VU1RDVE1pOTZBeUFDQVlic1pVZExM?=
 =?utf-8?B?RGdzNVpMZFcwajg2bCs1VktBYUZqMzArSklmOWVGVjExMTgxaVdVK3ZKaFpv?=
 =?utf-8?B?QkRTalJkYUF4aWgxbDNwQVlLblZzQVdObnJmamdPRE1QSWlwWDBtTTVFZ0Ev?=
 =?utf-8?B?RGxudXR6RkxtTHBzUWgxUVJxbCttam0ySUZnVHJaTkhiNkR6NFlKSDFNbVBR?=
 =?utf-8?B?V05kcytFL2NhdXlYdXVteVJveVdNQ3hJZ3kzWDRBa3NldU1vV0dkcSt1d2V1?=
 =?utf-8?B?VVlKcWFqVDczM1VhOW5KQURzMWRKMlVNZGQ2WHpSajVBMkd5bTBNZkhZbVlO?=
 =?utf-8?B?dDg1RzRoK0s5OVorWlRxVW90bUYyTS9qN2NXWSsyNnhhaE9VQkdoWHN1QU43?=
 =?utf-8?B?eVZTYWp0d1dLK1N4am10UjBxRUx3RHdxQi9HR0JXMm5XTWJQZXRjR1BPb3hu?=
 =?utf-8?B?M0ZYWk11eDFCdWtyVGtFdGQ5aTIrN2FpdkpWRWhIeXhGeEZYa2pSQTZlbWpq?=
 =?utf-8?B?U3lzY0tZdnhZdEIrQlpIbE4wM2VMcForSVZ1QndpRVZIK0dOT1dteFFudnJE?=
 =?utf-8?B?dURXZXIrRHljVlRyZHNHOFVwTFNCamdEWlRVSkdhSm52TDRuay9rakVlREpT?=
 =?utf-8?B?bmY1WWlVR0Q4dnVLRjNka2QxWEI0MTV6ZHgzRjZ3Z2lvcGl1b2QxMWlkOVRm?=
 =?utf-8?B?RGdjY2J6TGhYMEg2S1JkYURIbnNSa3IzSmRDZXZPTTY2WWw0N3ZFR0hJNmxW?=
 =?utf-8?B?UzNlTzV0TFp5Ky83ZFYxZGkvUDAyaTdCb3JFRU14VGJORDQ5SUszZFVTSXcw?=
 =?utf-8?B?cnBwb1FXK1UyZkZEd3YxYko0cXRocG5BNGxDNHlRMzhGN0FyaHBRZ2VyVnIw?=
 =?utf-8?B?YWtIL0E0bG84Wjg0QzdxcUwvSHd0MHp3ampWMmlDYzlodnRSbENqQjFxMmpY?=
 =?utf-8?B?TmlVNWxOMkJrTkdNa0lGTVpycUZhS1R3VEZ0Q3drcTk1dnpOaW8wckpILzN6?=
 =?utf-8?Q?Gsis2HpNrmVKV8obbfH+2IQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdQY3I3aGs2eWdwbVgwc0ZNZ1R4aFdKWCsraGwwYVhWOVFVVnZkdElqTUVY?=
 =?utf-8?B?ODUxTUdKQ3JGVzZOditMakRqdHdueGZhWjNBa0s3R1pqZnRMTXZhUXlrTk16?=
 =?utf-8?B?OXpJYVB0OXZ4ZXpQZGNjbW9OaEVhZFFlTHE5bWwyZndmeDBGb1RTeDdmRWlu?=
 =?utf-8?B?SEN1YTVMYzNSdzRQQU5pbnFPNkdkdmpGZkIwWFNQUkwvdVBPSEl0TlI2dDVh?=
 =?utf-8?B?c2lzdG1ubXZmUGx2RWlTU3R5S2JFWjZTVk9iYUFabHFZTlpYV3RoNnJRY0hT?=
 =?utf-8?B?b3V6V3ZDb2xuMTR0b29ia3VDY2JEcUxpdWY5Ymg4WHQvV0FiU1B2bW5Nd01J?=
 =?utf-8?B?UmZteWQ0TjEzUjYvd3JNMVJVYTFVZFFJREMrWTJuckZjemtMcWQyWmRFbXMv?=
 =?utf-8?B?dXNSRUNheWp2TmlEUDZLSUljdGl1Rllwc29IUjd2Z2JURkpYZXRKOUhQWm1L?=
 =?utf-8?B?WDBaRkR0K3NOUUVBdklpeXdMWXlGVGlTSzNxdDNqcmVSMFBaSVZCYkF1bGZB?=
 =?utf-8?B?bjIvMWsrUjdjdkxLMTFVZmQ1SzRYUVRUMUJ1SnFtSWtnTzdvS1RyQmxoUzRW?=
 =?utf-8?B?U3BpcU1LNTB3dWlMSERNL0MxV24vVHZVTS81NERNY2hXTmVZRElpV3ZDZHlx?=
 =?utf-8?B?YTUxYzl6ZkVYa1BUdVVTSXRLclMxTEo1T1JScTFrdUUxVW1WK1dGQW9FMm9B?=
 =?utf-8?B?QlpBL0NIcXZKK05kVmxSVXdVcXlONkFvemVFWkxZV3cxek44Y0JtWWIwbldV?=
 =?utf-8?B?WE1RVFk0MHJZSDY0S083U0xWc1ZObTM4aGRScTZvazlaSXNoMTF4RVQwTjZK?=
 =?utf-8?B?Y2dzZU9zTlkxTzlHNWpTZUlaUTJDYzUyRjdGVDFGb0l1WXlDbHU3ZGo3SjBr?=
 =?utf-8?B?b0tGanF1YkxObzk3TG9YdmFqYVlubjkvY3RLR0NBUnNrQ2o1Y3gwaFNVK1hT?=
 =?utf-8?B?L1JBS2pMOHZKRVM1bFVIczREWTQ0NzFmQ1E3cGhoVkgvaGNVb0c3MzU1U3Vi?=
 =?utf-8?B?ajJqUHRnY2pMbVlKM1RhREJkWFp6bjhvdlF3ZkRMV3lrTERnS0c2bXk3SXJG?=
 =?utf-8?B?VU15THlSSU5SSEZEVDdqaFhicEF1WlBWdGxYd0RsdmhKd1BRYUhyVWMvU3pw?=
 =?utf-8?B?K2NHQTRXMWtnbjdlL1gvQ1grS01JTENORnFqZkVJTTFGTnZNbHcyV3JEQldQ?=
 =?utf-8?B?WHlKR0crZUpXblovUWFLdTlmS20zV2F1VHRrTFpHSkJkakJXUmdOZkltVi96?=
 =?utf-8?B?MjIzcUlmcmw5YW9vd3RlT3NxZHRMWU41SngvTExWLzBDM2gxeFJ1UTY5YUV0?=
 =?utf-8?B?MFJ1WGdLSnNaY3EzU3hGQjNLa3FqQ1lESUxXTnpmSDVUS3IrSWh4SW8xUXZH?=
 =?utf-8?B?TWhpd1VWQlBNSGJZOXhxb29mODZOL2Zyd1BMbzM2UCthZEovRjJnNllHYjFE?=
 =?utf-8?B?YUhFaEdJL0F0bUZLUklmQkMybFV6TElxUVJFM1phTFZFTEo3cDBLQVkzaTZJ?=
 =?utf-8?B?cU8zNFpDMFJCc2NVcFNiS3JzSjlVdTRZNk95R2loRElEYm5YdWVmdDZaSjFz?=
 =?utf-8?B?QTVEaXVBVXFjZEVYRkFLRmtzTzhJNTZaK3ArSk8xRVZQdy9ua1VBby9EdHB5?=
 =?utf-8?B?MUZ3VEt3NERIMTRtOGhNTlA0QWtWZVNVb3BvaWJIYzJad1pYU2J3S3U5eVNk?=
 =?utf-8?B?TFVFaVJxL0JYMTJ1T2hJcHpPUks0cjlncWdDK1oxdUMwNWNNeGsxRnBDcnV1?=
 =?utf-8?B?K083bHFmTEhvbWxsUTFOY0dxWnVWQ3lSdGluQWh0Skt5YlBpd2VzN1lVZWdr?=
 =?utf-8?B?NVhySnNybWovSjNzTDljYjJVYkZ6cVFXRWxlcktwWHYyQTVNMjVWRnJlZHlJ?=
 =?utf-8?B?SWVvZ3VJM0hRM3VVd1ZTb0dxTWUvNkYrUjFtVEJEeC9MNVBpV1VBZWhVaTJs?=
 =?utf-8?B?RE05andOQmlwb0k4cVF5WHJsQVc3clhqZVU1a2I2M3Y2WUl3OG1uejV3ellL?=
 =?utf-8?B?Y3g1N0xIclVtVUVDN2dWRllqZDRPNStVZFJGUytWYmJPRDR4QXdzeTNsWnpn?=
 =?utf-8?B?TnpMMERpTTdtd0lFcDVHVkNOdHE3VUt2ODZyeXdtRnFuTTN4NTYxa0ROazh6?=
 =?utf-8?B?ZjVYaFdkYS9jQVVzTXVrTnF4bE93cHFwb3J6VjlUVUtxemFTdGhuWWpTdXlw?=
 =?utf-8?B?Y1g2RFVDckR0ZFBSaElSWngrSmN5aTlYUE1EbHlKRWoyVHNUYU5ySDJXanFP?=
 =?utf-8?B?cndJY1NxYUo0czFNQjdPTXdKalZVd3A1SVJuRXVNVnFmY21qSkpHR1haQ3p3?=
 =?utf-8?B?M2xuSEN1ZTdmY3ZTUUtuZU1KVWJVSGJtckhqemsvZDhKT2JTWnB3UT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c8ea63-f1cf-471a-bd34-08de7402d3f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 00:14:22.9139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KOlxGLTYHE3oadJk+KmPLtsggF5KwwULUMKDwH20s2OAm3owh5m8YRe1oHpPe6tnUDiXAe7opwnhy40BAZhJgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7342
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

Add support for printing pin names and current mux configuration on
i.MX8MP when CMD_PINMUX is enabled.

 - imx_pinctrl_pin_desc structure and PINCTRL_PIN()/IMX_PINCTRL_PIN()
   helpers for defining pin descriptors.
 - A full pin descriptor table for i.MX8MP pads.
 - Implementation of get_pins_count(), get_pin_name(), and
   get_pin_muxing() in the i.MX8M pinctrl driver.

There is no good way to add real mux names, so just dump the function ID
from the mux register.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/pinctrl/nxp/pinctrl-imx.h    |   8 +
 drivers/pinctrl/nxp/pinctrl-imx8m.c  |  48 ++++++
 drivers/pinctrl/nxp/pinctrl-imx8mp.c | 309 +++++++++++++++++++++++++++++++++++
 3 files changed, 365 insertions(+)

diff --git a/drivers/pinctrl/nxp/pinctrl-imx.h b/drivers/pinctrl/nxp/pinctrl-imx.h
index 9adf999d3bb..569bb869abd 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx.h
+++ b/drivers/pinctrl/nxp/pinctrl-imx.h
@@ -6,6 +6,14 @@
 #ifndef __DRIVERS_PINCTRL_IMX_H
 #define __DRIVERS_PINCTRL_IMX_H
 
+#define PINCTRL_PIN(a, b)	{ .number = a, .name = b }
+#define IMX_PINCTRL_PIN(pin)	PINCTRL_PIN(pin, #pin)
+
+struct imx_pinctrl_pin_desc {
+	unsigned int number;
+	const char *name;
+};
+
 /**
  * @base: the address to the controller in virtual memory
  * @input_sel_base: the address of the select input in virtual memory.
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8m.c b/drivers/pinctrl/nxp/pinctrl-imx8m.c
index d9c63b3aca6..2835fe3b176 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx8m.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx8m.c
@@ -4,7 +4,11 @@
  */
 
 #include <dm/device.h>
+#include <dm/device_compat.h>
 #include <dm/pinctrl.h>
+#include <linux/bitops.h>
+#include <linux/types.h>
+#include <asm/io.h>
 
 #include "pinctrl-imx.h"
 
@@ -18,7 +22,51 @@ static const struct udevice_id imx8m_pinctrl_match[] = {
 	{ /* sentinel */ }
 };
 
+#if CONFIG_IS_ENABLED(CMD_PINMUX)
+
+#if IS_ENABLED(CONFIG_IMX8MP)
+#include "pinctrl-imx8mp.c"
+#endif
+
+static int imx8m_get_pins_count(struct udevice *dev)
+{
+	return ARRAY_SIZE(imx8m_pinctrl_pads);
+}
+
+static const char *imx8m_get_pin_name(struct udevice *dev,
+				      unsigned int selector)
+{
+	/* sanity checking */
+	if (selector != imx8m_pinctrl_pads[selector].number) {
+		dev_err(dev,
+			"selector(%u) not match with imx8m_pinctrl_pads[selector].number(%u)\n",
+			selector, imx8m_pinctrl_pads[selector].number);
+		return NULL;
+	}
+
+	return imx8m_pinctrl_pads[selector].name;
+}
+
+static int imx8m_get_pin_muxing(struct udevice *dev, unsigned int selector,
+				char *buf, int size)
+{
+	struct imx_pinctrl_priv *priv = dev_get_priv(dev);
+	struct imx_pinctrl_soc_info *info = priv->info;
+	u32 mux_reg = selector << 2;
+	u32 mux_mode = readl(info->base + mux_reg);
+
+	snprintf(buf, size, "Function(%d) at: 0x%p", mux_mode & 0x7, info->base + mux_reg);
+
+	return 0;
+}
+#endif
+
 static const struct pinctrl_ops imx8m_pinctrl_ops = {
+#if CONFIG_IS_ENABLED(CMD_PINMUX)
+	.get_pin_name = imx8m_get_pin_name,
+	.get_pins_count = imx8m_get_pins_count,
+	.get_pin_muxing = imx8m_get_pin_muxing,
+#endif
 	.set_state = imx_pinctrl_set_state_mmio,
 };
 
diff --git a/drivers/pinctrl/nxp/pinctrl-imx8mp.c b/drivers/pinctrl/nxp/pinctrl-imx8mp.c
new file mode 100644
index 00000000000..7f02eba5355
--- /dev/null
+++ b/drivers/pinctrl/nxp/pinctrl-imx8mp.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "pinctrl-imx.h"
+
+enum imx8mp_pads {
+	RESERVE0 = 0,
+	RESERVE1 = 1,
+	RESERVE2 = 2,
+	RESERVE3 = 3,
+	RESERVE4 = 4,
+	GPIO1_IO00 = 5,
+	GPIO1_IO01 = 6,
+	GPIO1_IO02 = 7,
+	GPIO1_IO03 = 8,
+	GPIO1_IO04 = 9,
+	GPIO1_IO05 = 10,
+	GPIO1_IO06 = 11,
+	GPIO1_IO07 = 12,
+	GPIO1_IO08 = 13,
+	GPIO1_IO09 = 14,
+	GPIO1_IO10 = 15,
+	GPIO1_IO11 = 16,
+	GPIO1_IO12 = 17,
+	GPIO1_IO13 = 18,
+	GPIO1_IO14 = 19,
+	GPIO1_IO15 = 20,
+	ENET_MDC = 21,
+	ENET_MDIO = 22,
+	ENET_TD3 = 23,
+	ENET_TD2 = 24,
+	ENET_TD1 = 25,
+	ENET_TD0 = 26,
+	ENET_TX_CTL = 27,
+	ENET_TXC = 28,
+	ENET_RX_CTL = 29,
+	ENET_RXC = 30,
+	ENET_RD0 = 31,
+	ENET_RD1 = 32,
+	ENET_RD2 = 33,
+	ENET_RD3 = 34,
+	SD1_CLK = 35,
+	SD1_CMD = 36,
+	SD1_DATA0 = 37,
+	SD1_DATA1 = 38,
+	SD1_DATA2 = 39,
+	SD1_DATA3 = 40,
+	SD1_DATA4 = 41,
+	SD1_DATA5 = 42,
+	SD1_DATA6 = 43,
+	SD1_DATA7 = 44,
+	SD1_RESET_B = 45,
+	SD1_STROBE = 46,
+	SD2_CD_B = 47,
+	SD2_CLK = 48,
+	SD2_CMD = 49,
+	SD2_DATA0 = 50,
+	SD2_DATA1 = 51,
+	SD2_DATA2 = 52,
+	SD2_DATA3 = 53,
+	SD2_RESET_B = 54,
+	SD2_WP = 55,
+	NAND_ALE = 56,
+	NAND_CE0_B = 57,
+	NAND_CE1_B = 58,
+	NAND_CE2_B = 59,
+	NAND_CE3_B = 60,
+	NAND_CLE = 61,
+	NAND_DATA00 = 62,
+	NAND_DATA01 = 63,
+	NAND_DATA02 = 64,
+	NAND_DATA03 = 65,
+	NAND_DATA04 = 66,
+	NAND_DATA05 = 67,
+	NAND_DATA06 = 68,
+	NAND_DATA07 = 69,
+	NAND_DQS = 70,
+	NAND_RE_B = 71,
+	NAND_READY_B = 72,
+	NAND_WE_B = 73,
+	NAND_WP_B = 74,
+	SAI5_RXFS = 75,
+	SAI5_RXC = 76,
+	SAI5_RXD0 = 77,
+	SAI5_RXD1 = 78,
+	SAI5_RXD2 = 79,
+	SAI5_RXD3 = 80,
+	SAI5_MCLK = 81,
+	SAI1_RXFS = 82,
+	SAI1_RXC = 83,
+	SAI1_RXD0 = 84,
+	SAI1_RXD1 = 85,
+	SAI1_RXD2 = 86,
+	SAI1_RXD3 = 87,
+	SAI1_RXD4 = 88,
+	SAI1_RXD5 = 89,
+	SAI1_RXD6 = 90,
+	SAI1_RXD7 = 91,
+	SAI1_TXFS = 92,
+	SAI1_TXC = 93,
+	SAI1_TXD0 = 94,
+	SAI1_TXD1 = 95,
+	SAI1_TXD2 = 96,
+	SAI1_TXD3 = 97,
+	SAI1_TXD4 = 98,
+	SAI1_TXD5 = 99,
+	SAI1_TXD6 = 100,
+	SAI1_TXD7 = 101,
+	SAI1_MCLK = 102,
+	SAI2_RXFS = 103,
+	SAI2_RXC = 104,
+	SAI2_RXD0 = 105,
+	SAI2_TXFS = 106,
+	SAI2_TXC = 107,
+	SAI2_TXD0 = 108,
+	SAI2_MCLK = 109,
+	SAI3_RXFS = 110,
+	SAI3_RXC = 111,
+	SAI3_RXD = 112,
+	SAI3_TXFS = 113,
+	SAI3_TXC = 114,
+	SAI3_TXD = 115,
+	SAI3_MCLK = 116,
+	SPDIF_TX = 117,
+	SPDIF_RX = 118,
+	SPDIF_EXT_CLK = 119,
+	ECSPI1_SCLK = 120,
+	ECSPI1_MOSI = 121,
+	ECSPI1_MISO = 122,
+	ECSPI1_SS0 = 123,
+	ECSPI2_SCLK = 124,
+	ECSPI2_MOSI = 125,
+	ECSPI2_MISO = 126,
+	ECSPI2_SS0 = 127,
+	I2C1_SCL = 128,
+	I2C1_SDA = 129,
+	I2C2_SCL = 130,
+	I2C2_SDA = 131,
+	I2C3_SCL = 132,
+	I2C3_SDA = 133,
+	I2C4_SCL = 134,
+	I2C4_SDA = 135,
+	UART1_RXD = 136,
+	UART1_TXD = 137,
+	UART2_RXD = 138,
+	UART2_TXD = 139,
+	UART3_RXD = 140,
+	UART3_TXD = 141,
+	UART4_RXD = 142,
+	UART4_TXD = 143,
+	HDMI_DDC_SCL = 144,
+	HDMI_DDC_SDA = 145,
+	HDMI_CEC = 146,
+	HDMI_HPD = 147,
+};
+
+/* Pad names for the pinmux subsystem */
+static const struct imx_pinctrl_pin_desc imx8m_pinctrl_pads[] = {
+	IMX_PINCTRL_PIN(RESERVE0),
+	IMX_PINCTRL_PIN(RESERVE1),
+	IMX_PINCTRL_PIN(RESERVE2),
+	IMX_PINCTRL_PIN(RESERVE3),
+	IMX_PINCTRL_PIN(RESERVE4),
+	IMX_PINCTRL_PIN(GPIO1_IO00),
+	IMX_PINCTRL_PIN(GPIO1_IO01),
+	IMX_PINCTRL_PIN(GPIO1_IO02),
+	IMX_PINCTRL_PIN(GPIO1_IO03),
+	IMX_PINCTRL_PIN(GPIO1_IO04),
+	IMX_PINCTRL_PIN(GPIO1_IO05),
+	IMX_PINCTRL_PIN(GPIO1_IO06),
+	IMX_PINCTRL_PIN(GPIO1_IO07),
+	IMX_PINCTRL_PIN(GPIO1_IO08),
+	IMX_PINCTRL_PIN(GPIO1_IO09),
+	IMX_PINCTRL_PIN(GPIO1_IO10),
+	IMX_PINCTRL_PIN(GPIO1_IO11),
+	IMX_PINCTRL_PIN(GPIO1_IO12),
+	IMX_PINCTRL_PIN(GPIO1_IO13),
+	IMX_PINCTRL_PIN(GPIO1_IO14),
+	IMX_PINCTRL_PIN(GPIO1_IO15),
+	IMX_PINCTRL_PIN(ENET_MDC),
+	IMX_PINCTRL_PIN(ENET_MDIO),
+	IMX_PINCTRL_PIN(ENET_TD3),
+	IMX_PINCTRL_PIN(ENET_TD2),
+	IMX_PINCTRL_PIN(ENET_TD1),
+	IMX_PINCTRL_PIN(ENET_TD0),
+	IMX_PINCTRL_PIN(ENET_TX_CTL),
+	IMX_PINCTRL_PIN(ENET_TXC),
+	IMX_PINCTRL_PIN(ENET_RX_CTL),
+	IMX_PINCTRL_PIN(ENET_RXC),
+	IMX_PINCTRL_PIN(ENET_RD0),
+	IMX_PINCTRL_PIN(ENET_RD1),
+	IMX_PINCTRL_PIN(ENET_RD2),
+	IMX_PINCTRL_PIN(ENET_RD3),
+	IMX_PINCTRL_PIN(SD1_CLK),
+	IMX_PINCTRL_PIN(SD1_CMD),
+	IMX_PINCTRL_PIN(SD1_DATA0),
+	IMX_PINCTRL_PIN(SD1_DATA1),
+	IMX_PINCTRL_PIN(SD1_DATA2),
+	IMX_PINCTRL_PIN(SD1_DATA3),
+	IMX_PINCTRL_PIN(SD1_DATA4),
+	IMX_PINCTRL_PIN(SD1_DATA5),
+	IMX_PINCTRL_PIN(SD1_DATA6),
+	IMX_PINCTRL_PIN(SD1_DATA7),
+	IMX_PINCTRL_PIN(SD1_RESET_B),
+	IMX_PINCTRL_PIN(SD1_STROBE),
+	IMX_PINCTRL_PIN(SD2_CD_B),
+	IMX_PINCTRL_PIN(SD2_CLK),
+	IMX_PINCTRL_PIN(SD2_CMD),
+	IMX_PINCTRL_PIN(SD2_DATA0),
+	IMX_PINCTRL_PIN(SD2_DATA1),
+	IMX_PINCTRL_PIN(SD2_DATA2),
+	IMX_PINCTRL_PIN(SD2_DATA3),
+	IMX_PINCTRL_PIN(SD2_RESET_B),
+	IMX_PINCTRL_PIN(SD2_WP),
+	IMX_PINCTRL_PIN(NAND_ALE),
+	IMX_PINCTRL_PIN(NAND_CE0_B),
+	IMX_PINCTRL_PIN(NAND_CE1_B),
+	IMX_PINCTRL_PIN(NAND_CE2_B),
+	IMX_PINCTRL_PIN(NAND_CE3_B),
+	IMX_PINCTRL_PIN(NAND_CLE),
+	IMX_PINCTRL_PIN(NAND_DATA00),
+	IMX_PINCTRL_PIN(NAND_DATA01),
+	IMX_PINCTRL_PIN(NAND_DATA02),
+	IMX_PINCTRL_PIN(NAND_DATA03),
+	IMX_PINCTRL_PIN(NAND_DATA04),
+	IMX_PINCTRL_PIN(NAND_DATA05),
+	IMX_PINCTRL_PIN(NAND_DATA06),
+	IMX_PINCTRL_PIN(NAND_DATA07),
+	IMX_PINCTRL_PIN(NAND_DQS),
+	IMX_PINCTRL_PIN(NAND_RE_B),
+	IMX_PINCTRL_PIN(NAND_READY_B),
+	IMX_PINCTRL_PIN(NAND_WE_B),
+	IMX_PINCTRL_PIN(NAND_WP_B),
+	IMX_PINCTRL_PIN(SAI5_RXFS),
+	IMX_PINCTRL_PIN(SAI5_RXC),
+	IMX_PINCTRL_PIN(SAI5_RXD0),
+	IMX_PINCTRL_PIN(SAI5_RXD1),
+	IMX_PINCTRL_PIN(SAI5_RXD2),
+	IMX_PINCTRL_PIN(SAI5_RXD3),
+	IMX_PINCTRL_PIN(SAI5_MCLK),
+	IMX_PINCTRL_PIN(SAI1_RXFS),
+	IMX_PINCTRL_PIN(SAI1_RXC),
+	IMX_PINCTRL_PIN(SAI1_RXD0),
+	IMX_PINCTRL_PIN(SAI1_RXD1),
+	IMX_PINCTRL_PIN(SAI1_RXD2),
+	IMX_PINCTRL_PIN(SAI1_RXD3),
+	IMX_PINCTRL_PIN(SAI1_RXD4),
+	IMX_PINCTRL_PIN(SAI1_RXD5),
+	IMX_PINCTRL_PIN(SAI1_RXD6),
+	IMX_PINCTRL_PIN(SAI1_RXD7),
+	IMX_PINCTRL_PIN(SAI1_TXFS),
+	IMX_PINCTRL_PIN(SAI1_TXC),
+	IMX_PINCTRL_PIN(SAI1_TXD0),
+	IMX_PINCTRL_PIN(SAI1_TXD1),
+	IMX_PINCTRL_PIN(SAI1_TXD2),
+	IMX_PINCTRL_PIN(SAI1_TXD3),
+	IMX_PINCTRL_PIN(SAI1_TXD4),
+	IMX_PINCTRL_PIN(SAI1_TXD5),
+	IMX_PINCTRL_PIN(SAI1_TXD6),
+	IMX_PINCTRL_PIN(SAI1_TXD7),
+	IMX_PINCTRL_PIN(SAI1_MCLK),
+	IMX_PINCTRL_PIN(SAI2_RXFS),
+	IMX_PINCTRL_PIN(SAI2_RXC),
+	IMX_PINCTRL_PIN(SAI2_RXD0),
+	IMX_PINCTRL_PIN(SAI2_TXFS),
+	IMX_PINCTRL_PIN(SAI2_TXC),
+	IMX_PINCTRL_PIN(SAI2_TXD0),
+	IMX_PINCTRL_PIN(SAI2_MCLK),
+	IMX_PINCTRL_PIN(SAI3_RXFS),
+	IMX_PINCTRL_PIN(SAI3_RXC),
+	IMX_PINCTRL_PIN(SAI3_RXD),
+	IMX_PINCTRL_PIN(SAI3_TXFS),
+	IMX_PINCTRL_PIN(SAI3_TXC),
+	IMX_PINCTRL_PIN(SAI3_TXD),
+	IMX_PINCTRL_PIN(SAI3_MCLK),
+	IMX_PINCTRL_PIN(SPDIF_TX),
+	IMX_PINCTRL_PIN(SPDIF_RX),
+	IMX_PINCTRL_PIN(SPDIF_EXT_CLK),
+	IMX_PINCTRL_PIN(ECSPI1_SCLK),
+	IMX_PINCTRL_PIN(ECSPI1_MOSI),
+	IMX_PINCTRL_PIN(ECSPI1_MISO),
+	IMX_PINCTRL_PIN(ECSPI1_SS0),
+	IMX_PINCTRL_PIN(ECSPI2_SCLK),
+	IMX_PINCTRL_PIN(ECSPI2_MOSI),
+	IMX_PINCTRL_PIN(ECSPI2_MISO),
+	IMX_PINCTRL_PIN(ECSPI2_SS0),
+	IMX_PINCTRL_PIN(I2C1_SCL),
+	IMX_PINCTRL_PIN(I2C1_SDA),
+	IMX_PINCTRL_PIN(I2C2_SCL),
+	IMX_PINCTRL_PIN(I2C2_SDA),
+	IMX_PINCTRL_PIN(I2C3_SCL),
+	IMX_PINCTRL_PIN(I2C3_SDA),
+	IMX_PINCTRL_PIN(I2C4_SCL),
+	IMX_PINCTRL_PIN(I2C4_SDA),
+	IMX_PINCTRL_PIN(UART1_RXD),
+	IMX_PINCTRL_PIN(UART1_TXD),
+	IMX_PINCTRL_PIN(UART2_RXD),
+	IMX_PINCTRL_PIN(UART2_TXD),
+	IMX_PINCTRL_PIN(UART3_RXD),
+	IMX_PINCTRL_PIN(UART3_TXD),
+	IMX_PINCTRL_PIN(UART4_RXD),
+	IMX_PINCTRL_PIN(UART4_TXD),
+	IMX_PINCTRL_PIN(HDMI_DDC_SCL),
+	IMX_PINCTRL_PIN(HDMI_DDC_SDA),
+	IMX_PINCTRL_PIN(HDMI_CEC),
+	IMX_PINCTRL_PIN(HDMI_HPD),
+};

-- 
2.51.0

