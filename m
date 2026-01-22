Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3B5EC44536
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 23:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1C8A83A6A;
	Thu, 22 Jan 2026 00:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ilxyNACT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5067983B85; Thu, 22 Jan 2026 00:51:35 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5682C83B32
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 00:51:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6WR+gv8RmER13HOUpdVuVXXiz9uCidhJMr4kixSxONRdn+xLoq3OS82p5jsF5h/rB60sJDF8YueZY/Gopfhdw/nOdwmAvSznNh2/hUUcQsYxjRjxOkNJWfEaaTEAqeKCPoJpyqKaF4o9A8k0w3b7StyV+4YWk961VrHsnnFUFzxi3nVdjRYwyGhAokj+lJk3ehh2VXZXAdfIF4ejw5wQ+lq2T3rJGByuagp5aKg2lHRILgspoX2kI81ABIhrudYzJSZoyNHaAFQp8K0f17EHfcyPIa09vbxu46TQ158UmQChpIs5gJ8/VMC4ZqOdHftcpNk19O0SO+AP30bckYnVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=puZbAkhZ+wEPvg/6HbPxbcT6OqsKghlWyzRSRwcsht4=;
 b=sGT5tm7VuOUFge6O+kPCyDpWG0KQTqHFbyj2bkNX3QRhsWsDUoItCPAtOqv076Ka8BywlRpTYqKtNne/CFG6u6Z1XxB7zhya2hLyzGUkFvjsstvlvcqaV4CVpqt8m5dKs/HmOZC6j6oqUQ9qcozxy2kV+a3LQHr1jTz+tjqjDB0DSQWfoi59XRwXpDX2nLkmSDoI0zGIE7Si0kjf20qlDgZxiyVp7tNNScJ5fRcU4zxfkP4F/LzGCFJMyKnw7eInVkSo8MHY6+BmTZpWBvjoJzzjMOx+DjrX+NnXtcvb5PjTX/wBF/oFgUpXnqyEYNgioGVKyjGEY4xFEYPn9HxGSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=puZbAkhZ+wEPvg/6HbPxbcT6OqsKghlWyzRSRwcsht4=;
 b=ilxyNACTW53Jh7lm445EdJ3FJK98CSIYpkYym2QeNvQ4pasxlFSiwuhvWYb7IknkJKbTCWdmGvGYgdgtUuMXveKIZrwI7hueeDR/qtgqv2wLsoLF12zyKxkZFQP5HAHGcY7DLVBQgW5U7L/p6SIpsBFLwAdw+pZf/sV0T0yfPDhTHYKGk1fvUff/XDNdwzV7hKSwss86R7vma94/XGcfz3vEooXHwSxQVkQxur0vvziR1RqlzAb7phBIOeCxvYx+f+i++p1jI/A51socOTJg99+Nrd6HDJRUhdqWXln7j6fTv5wXy+yj0xXmz1nGB2w7OTO+B/PMBysfid2WpCIjiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM0PR04MB7090.eurprd04.prod.outlook.com (2603:10a6:208:19e::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 23:51:31 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%5]) with mapi id 15.20.9542.009; Wed, 21 Jan 2026
 23:51:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 22 Jan 2026 09:05:46 +0800
Subject: [PATCH 03/12] imx8mp_evk: spl: Drop DECLARE_GLOBAL_DATA_PTR
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260122-imx-clean-v1-v1-3-a52a94b7e173@nxp.com>
References: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
In-Reply-To: <20260122-imx-clean-v1-v1-0-a52a94b7e173@nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To PAWSPRMB0023.eurprd04.prod.outlook.com
 (2603:10a6:102:37e::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM0PR04MB7090:EE_
X-MS-Office365-Filtering-Correlation-Id: 70f78a66-7b1b-436f-7976-08de5947ff2b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|19092799006|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OE1kQ3FOWVVDK1BMclJGdFgrdzRPYkNsWlhZN21ObS9uSFFWU0dGVS9ZZmp5?=
 =?utf-8?B?VUpFK2xCM3RYRWdzTnExYlNqdkp3WGVCTlJzWEM3b3N3OS9jUDlEVWtoa1Fj?=
 =?utf-8?B?Q1ZVRUUvWWNZcE43SUFvSFFoSEt5amppb2czQjk0NjJ5bHgvOVd0V0xhL0Jx?=
 =?utf-8?B?Rm1QQit6Rkg1S01CVFpUMjFURzBBS3FsUHFnLytrSmUzMlpYV1dLNnVycUJp?=
 =?utf-8?B?YS8xY2NDS0xHdzVUS3VqL0J3MHh6aDBhdFZPdDdRc05hQ2NDZEplVWRGK3gz?=
 =?utf-8?B?ajBRdDhNU25WQmc2cjlnVlNUSTk1Vzcvb09aNytZYkFjTm5iSGNqaDVyS2pR?=
 =?utf-8?B?U2V5ZGtHcTJXK0tCczlOaTlHRTJaMkpQQndFRjVMOUpsUnNmUmJGcnh0TVpB?=
 =?utf-8?B?OExoRlR2L2NWSVFkOGdFZ1luR2Fkbk9EOU9lSHVhdkVBL2owRWF4eUx5eGpV?=
 =?utf-8?B?a2hZd0JlMG8zem9Zb2luUUhIU3ZUWlRCMlJmV084TDl1QysrbEx6VDZ4VVlU?=
 =?utf-8?B?RHNybytocndvcU4rNUxRTGFHMEVxaUt2VmFZN0pGY0J1N0NvbnFSam9yMzZz?=
 =?utf-8?B?TzdHdENWeDYrUHZkN3J5MUFKM1R3UGRTMzluNEtOaVV2MmxwNG5nNU9jTU9t?=
 =?utf-8?B?b3RKVDFDTmZLTUdvakxSNHQ1MlhoNGVhemJYK284Zy9jMUJQUmg4TkNlK0dS?=
 =?utf-8?B?UmVHdlBSS3d1UkZuOU1pR1Nqb0FPZk0waXdEK1lxNTMzWVd4OXJFTjJ1Tllr?=
 =?utf-8?B?Y2dKMEgwS1A0VjNWdG1pc3dYbFV1azcvUmxUaXN6dXczVXpRQkFkOHIrZnJT?=
 =?utf-8?B?WEhBWDA0dmh6VG54OU1iQ0VIN2NPVDF1aWh5d2dZU3pRZ3NHZVN2dDdPVDJM?=
 =?utf-8?B?OXB0UDZ2S29KUzRUdGN4R2lWMnlLZVExVnRJcW12UnUzaFZEZ0FxOEF5Nzhr?=
 =?utf-8?B?YUVHMjhMbXQxSGtTdzJFam44b3JvS2I2R2RpcnVJRTJKSVhVRVFRbTBkUlJD?=
 =?utf-8?B?UHpObzJqVm9nSGZXZlRlMVR6c0VkWTh5L2poT3RYdnlJQlFtUFM0ME0xMi9D?=
 =?utf-8?B?OVoxdVE1OEI5S0Z6cjdpNGJkTWt6L2pEdkFCdmdmdFZsT01yVFJDViswbWs1?=
 =?utf-8?B?MjIybDdqaC9RVlNzcjYxQTV6eUtDK2kzMzlYLzBld3NuSy84V1plRlV5b3Av?=
 =?utf-8?B?L1hWSS9xSmtaaEZBUVFod2J6NUFoSmZiSlNENU9SOUtDak1DYUNWR1pqdWdL?=
 =?utf-8?B?OC9OaG1ST0toU3lReEhVMnRCNVhwZzVPTUxtanpnaUJtWTJhRlVWQm1md01G?=
 =?utf-8?B?S2xETy9aUUdxMVNONUFTUk5xenBKbFNKMTlHbHE3YUhSQkFmL2xJWjU0Qk1p?=
 =?utf-8?B?TVdpcFhmellOVFRUVTB5WTl3NGlUMkR6R0o0bWF0SEtxeGluZGx3N2N4ZXdy?=
 =?utf-8?B?SzV1emhQVm44MHhWRHB3V2FzejNrWW55TGkrZ0g2YkhSL2ZwSXBGL25OL29X?=
 =?utf-8?B?dlg3dmJtZlRpMDBTZFcrSjZqVnlqcEFMaFF4NnlubHNDQVYzNytKbUQ0cS9m?=
 =?utf-8?B?TWxGdlhCUndRZVpyQmRZYmlEdFN2bGJFVHFzY2RDNmVTSXNEUFNPT0RmT1lq?=
 =?utf-8?B?Ulh5eHVKTlFQMFVab1lUQTNjbk0zbG0zYStSYitRbGlFTkhoM3g4VjhJRkVs?=
 =?utf-8?B?WDN2amMxOU1SWWJvdlgzRDVPa1Fsbi9uOFZ0OHlkRTZ3VE00bVhseUt0VFE4?=
 =?utf-8?B?Nnc3TGEwaFNvcXdjSm1mUXNXcVJpTnNFY0FIY3dJSFNCZHBmclhQVmlPdnB5?=
 =?utf-8?B?NTBaYmNlMmkvaVJnSXFCY0NVd2cra3BSc24zTDhydzd5UmtXQW04SHI3TCtm?=
 =?utf-8?B?dVMzUm12U3cvdjNxWVo4dzNEa1RtRGtqKzZjTXI0WlYzQk5Pc1M1MXRFeFIw?=
 =?utf-8?B?M2hyNUlmUDl3ZFhaUDMrOFVTWEFrb0FYNmpiYTA2NFZzY0dqTnpqMlJRYy9t?=
 =?utf-8?B?QnQwOUVFOVVKeDlNeHg4YmlBRzZvVDZzaGwvb2hVb1RxbkdydmUzSmN4MkNz?=
 =?utf-8?B?OFFtM0ZvY2ZpMmJ1VHd2WjhMZ0FKUXlxZXZROWJ0UGJUV2M2QnhNZndKRkg5?=
 =?utf-8?B?R0J6NXVIRkRqMzNSVjUvSjdJa0tEbm1kcnBZT2grcDZSNHBaTWpvZkJ4S3hl?=
 =?utf-8?Q?QgwIKZnb53CnRrleF4B/uPw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(19092799006)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVFYkFxQnFCbkpWY2lhUmkyZjZzVTE5b0txMTZNa21abS9ibXZWb04ySys1?=
 =?utf-8?B?TzVaOXYzTVF3QXJIZU53ekRwd3hTUWNycHBsN2xRenN1bDNLb01Ldjd3Yi94?=
 =?utf-8?B?UUVWWHQrdGhqM0E3WjdkdmhtbkN4STZiNENzNlgyNG9WTXVZc1VJYjU1eExK?=
 =?utf-8?B?Z2Q2TnBxa3F3cTlDck5xcWFod0czQkRLTHRMcFNOZ0swZ2FVaTdBNFdXT0Y5?=
 =?utf-8?B?S2xGM2VTd3JmdUJvcEloMG5zWjh4YUVsYUpxaG1SK29ZRG5PenR2eVlkUThS?=
 =?utf-8?B?dVBMTnJ5MTFSVS9UeEhpL1BocjBERHhjblNMVndJbTFJMjBERGZOMTlWVmFB?=
 =?utf-8?B?Vm9PZ0t5QUhNcE9GRDdkdEZQOEx6VmJ1a085aFloTDg1dE9kdmlETFc2NUYv?=
 =?utf-8?B?OHhzdmFNMTJNbHdtRkJEWXRxd2J3cXlNcFZJU0xic2NPSkwyZWNTdFJQUDhs?=
 =?utf-8?B?c2NGc0ZOc3A5akVJajFRUlRuVjFWVEw5cDd4ekJnRndxN1RVWkFSTFFoNlB5?=
 =?utf-8?B?cDdIYlJJK3FwRlZXYmNtVjE3dmtKM1poeVhuSm1hMXNBNGx6Wk1uWVoycHMz?=
 =?utf-8?B?N3B3V3pwRFBLK0lyUDBpRkJSWUV5ZU1QVHFQS25PRmZLMVdTckNxdmU2R2Nx?=
 =?utf-8?B?T1lzZC9wWG5WcjQ1VVk5dTZ6NDBmT3hLYUFMVy8zQmZFSmMxYTkrb2M5U1d5?=
 =?utf-8?B?SzdIL0EwZFppZy90VGdYUjlvMjVmZTEvOXhQcDJZYmYxUC92bmgwcjdvY0FC?=
 =?utf-8?B?Q2syUk84TVh4RG9HT2tVWGpNdFpZUC8wNWJra1V2TDQ4bThlSGxxdnhCaHhx?=
 =?utf-8?B?SnZRSHNuWFE4U0Ivb3ZWdUs5eS9ORTBVbGZvTkRPSWxQTUpqK2VBUzJyNWpY?=
 =?utf-8?B?b3U4aUtEdFllRFJWbldSWTZhVlFITE1SMkFkMmJZWHZMVFZSbi9VeGlMUUI4?=
 =?utf-8?B?NXBNZkhSb2J5WUJBT1dTeFUzbWkyZHhIWHZKc0c0NDdYTkE1Mi80OStxczdQ?=
 =?utf-8?B?Vi9EWXNyKzVCNW1NQkRLcjdaOGdRbTRWNDc1ZmM0dkEyV3U3RVlPeU5zUjR6?=
 =?utf-8?B?bEloT0szZ2R2dlR1QkkvK3VYcHVJZ21VdnhFTlZ4ejVNaHR1b2xta0JReGhY?=
 =?utf-8?B?emlKRnU0S0YvblZVbk5sNmJkWUo3UXlwUWRGTWp5R0dWODdNVm9hNTNXNFho?=
 =?utf-8?B?d3BFeS9IR0VzTU41UkNwMGo4MHhWTElubUtScXFRTUpLRktLS2NpQkEzU25x?=
 =?utf-8?B?ZmdhY1J3RmU5ZkxCYngxRWowdnBZcVQ0a29wNjRPRUd3eWVMM0pFdTdWcVEy?=
 =?utf-8?B?RndJcDZQNURkdGczQWJ1YUtIeWdpTFM2dXB4QWZlbm1DWE1uQUNxcmFLOFpM?=
 =?utf-8?B?ZVpYYTNVQmoxQ3doblZpQzh5Sk1PTlo1RC9jbERlQ0RmbngxazlYalp0dm1R?=
 =?utf-8?B?RDRJWVRtU0dYeGRKcW9UVTZ6UGZQS3RqNjRXNnNzYkdpU1V4NUtiY1NzZXR3?=
 =?utf-8?B?NEtaejNSdS9SYkZ1RnNoTDNRWEdZWGsyZGN6L0NSM3FiVlF2RnpyOGM4T3Yr?=
 =?utf-8?B?RkxRUVBkeEJOWjFwZzk0K1BEVUF2VlUxVkdwWmV4bnlyS1hCOUQ3d3ExSUVp?=
 =?utf-8?B?Z1ZoQVJLa1ZYbzcreHRpK1pEajNvdkJ6ejBHcVl0bEU1emt1MzZpK1JZazVp?=
 =?utf-8?B?UTVFemRQQkRXSTBDd09UQ0lGMzBnRmc4cUhOSWtQeXRmOC9TVXNWUGMzVGtr?=
 =?utf-8?B?cy9ITUJuN1FZRDRVbWUrNHNoRmlHVGNQV21nQUNVbUU3clRveEF2TEptb2Uz?=
 =?utf-8?B?UFYxYlhuUUovZWFZQW40akRib0x0ekRhd3IwL2M3dEI2VExYWmtYUG9IZFNs?=
 =?utf-8?B?bkFCS3AvU2l2OUxFenYyNFVUbU4yOUtXb0VyYkRCOGNmdE9vQW9EcndidldO?=
 =?utf-8?B?VGJqeVJCdnNCdGNNQmx1anNDSG1Hd1IzeHZFbEh1WE5sZENPaWVlQzNBUU9a?=
 =?utf-8?B?ZEdCWmxTK1lDdTlqNFdvd2JNM0wzY1pKeFQ0dGlXL2hDWGpiMDRXWnBqRUs5?=
 =?utf-8?B?QzlHV0dCSzN4bGFWQmVRS3lUVVhTRFFEdGN6Rm4yRE1nMlppdDBsNE5qK2F0?=
 =?utf-8?B?cWxMUUlVKzYraGMyZkJxNVdPUTBRRlZNZjVVSVQwbGJzSFMzd2I1NmlGWDNW?=
 =?utf-8?B?UWJubGtPMitpaXhBaWtRQ0VvZnl0VCt4Nm5qSHR2NUN1bFFRcGVFZWdJTnVG?=
 =?utf-8?B?OXpVL0xhbVVqeVFMbHZzQnV4WCtSamtWYzR0cldja2c0ZDlFMFdjSFdqM25n?=
 =?utf-8?B?R3Q3TytUQmRKR1hlNUk5cC9KRG9VSGtWMTFqbU00bmQyMkJ3YXl5QT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70f78a66-7b1b-436f-7976-08de5947ff2b
X-MS-Exchange-CrossTenant-AuthSource: PAWSPRMB0023.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 23:51:30.8489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2fDfFd1xawr2HhAUpid7hyhfoZxPZNXC9R6kVnZmKu9cqwWrKbkzPvfNAa04QlZEiRYvk6KsqQ/62pwrn8ed1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7090
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

There is no user of "gd", so drop DECLARE_GLOBAL_DATA_PTR.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 board/freescale/imx8mp_evk/spl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/board/freescale/imx8mp_evk/spl.c b/board/freescale/imx8mp_evk/spl.c
index 552bf689228..4e6a5830b07 100644
--- a/board/freescale/imx8mp_evk/spl.c
+++ b/board/freescale/imx8mp_evk/spl.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <log.h>
 #include <spl.h>
-#include <asm/global_data.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/mach-imx/boot_mode.h>
@@ -18,8 +17,6 @@
 #include <dm/uclass.h>
 #include <dm/device.h>
 
-DECLARE_GLOBAL_DATA_PTR;
-
 int spl_board_boot_device(enum boot_device boot_dev_spl)
 {
 	return BOOT_DEVICE_BOOTROM;

-- 
2.51.0

