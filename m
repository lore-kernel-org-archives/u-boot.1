Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8882BCA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:33:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E67833AD;
	Mon,  1 Sep 2025 08:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="yBITwSQE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DB6F838AA; Mon,  1 Sep 2025 08:33:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85EE2831B4
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTNjDt0lDzsV16651/TPQv7nuWDI9rGnZVj5fqdRxEgQxIXL1RYsVedLAhYOphWOAzP301IxuNuowk1nUN5p0E5wHi5S9gGIzVoAcvwlY8IP0jDXQHy22p9iemt1e767vvSSjEF9aby7kW7GHlNyQ9tHlKPHzCMrjMj5bevaX/d43gI79dtnFmn++OJG2QeOdZ6QsFnZd0Z9MEFyCId9iArU7x+e5gTQIgJj7t37aJj/f1ESmgmW/9z9I7URteAFDNzVbii8QDf6Rboc4o8YYkSVRh+asMhQtgoVxhZe9Kh7T4oByb/Eb2z6s2QOvf2G7GunnDToiJkNbhmgDkSgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2cjCHnMe8PSTakV6e5HPSY5lIFrFZzFglCz7+hzW9g=;
 b=E0LZW/ieIrVLrVW14DegNvOM4MrOPk75jh1aAZMml9Yl25dZW+Np+yVFhP59j0WYAF+NWmPj1IikQP0litIgxcO+/qGzGXuXUg+EltIZdBLw+dYan/tutfTgiM/OrZODPGgq3rNtqQXicz8llKjUwCXnmQZidjPgF/RhJjS+uHiB2shhKeK1ZP1u7pkzxGp7jQk6Se8eZ5VqyTscZSIDFnZOrd5VUfxVI3uoUKCG390/AM8F42wD+J8K68GKA+NPBnkRlyf6ePyM+cr6VIwwWPNlypQjHpXsOyrD0wBI/HeO+9mn5lagKxEZgacCHr6t4FERdRI+skYOsSt1jPJjVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2cjCHnMe8PSTakV6e5HPSY5lIFrFZzFglCz7+hzW9g=;
 b=yBITwSQEsW6LSoQ04x7nGAU+hUORQomKKYnoDUwmsx5ZzL2AaoujJLofh4HBW1Is4zn5ApxB2A388uQEcsbaYNlzSisQAYp1nx64srJRwPPPIp4w08fLbivBXHX8sCxOwDSH6qGhXgURCHdQwwyxd8K4KEy6rEG2qkNNtYWXyUZ/p1iGOjeG+iSi/g/ne+KpKmDXud5gxb6YtngMh1Acrnjpi3NnTPcruHQm0GFZxSJr6fvhMTbRV0IGq4uEVrbTO5kAXqURPm/ptMBjW1Hrk4+AUgaxZ1v0J2bp1eq3kWXLePSkj+bgTR5JcxQO9vGx8j91Z1y0C3tSvOz1N1hWzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI0PR04MB10231.eurprd04.prod.outlook.com (2603:10a6:800:23f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.14; Mon, 1 Sep
 2025 06:32:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9094.015; Mon, 1 Sep 2025
 06:32:59 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] mmc: iproc_sdhci: Cannot test unsigned variable for
 negative
Date: Mon,  1 Sep 2025 15:44:05 +0800
Message-Id: <175671244822.14594.17545382913954656491.b4-ty@nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250730-iproc_sdhci-v1-1-310015b22944@linaro.org>
References: <20250730-iproc_sdhci-v1-1-310015b22944@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0016.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI0PR04MB10231:EE_
X-MS-Office365-Filtering-Correlation-Id: da81af4d-d58b-43ae-d473-08dde92164db
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V3c2YmtCUndTT2xKUlNTQVB5Q0ZBMGxOcDMzZnRIRnMrMWhQOWxvNWNTNURC?=
 =?utf-8?B?MFdKNmNmcmoybnRxV3VHVE1YZjRUNzVpUTN6aU93NmFJVUlNZHlRR1N5UndS?=
 =?utf-8?B?N2JKRy9QQkpoUVIzcnRkeFEzaXlUZjdvUlludnd4M004Tk9NKzFDbk5VSGFZ?=
 =?utf-8?B?MWNISDhxYkEyYkFGblNuY2JXYS8rZE9vc1RnUXFCL3B6OUpXc3ppajQ4RVM4?=
 =?utf-8?B?L0FYSnBneGZablh3clFRcjNTSnhtWElnd2JGenAvSnp5SWxtWWFXck5DRng3?=
 =?utf-8?B?b0dreGdzdWtoM1ZBYWdhTEd0eG9kN1ZoME5oRlQ4UG9TK3FvbFptblM0RzNQ?=
 =?utf-8?B?YWdyMFMyNDlmUnNCUE5uWnlPNE1aaGhmSjZQeGc3ZURnTHo5WjVaNUVqajEx?=
 =?utf-8?B?eUtReThDU0Y2YWdQTDZkZ0RHMHVtSEZFTkcrMGxIT1RLcXB4R25PQWZLOWJK?=
 =?utf-8?B?ZFVTVXdZaWhNQlV3RmJOWkZxcXhpRW55UGM5bFBWVGhETEFQdEFpWDcrTUQr?=
 =?utf-8?B?YWZXaVBFclVEbnlPcTgzL3FhNjR5dmFML2p5WU00ZVlQa0pjTWNwSG5VK2Qx?=
 =?utf-8?B?VXlDWlV1MW14U0p0UUJDSzFkb0VtVmM2WWFLem1tcG5GdVVKSzFodGE4VWRE?=
 =?utf-8?B?eUVSTlVia0NMS1VHZVB6VUc3L24vOW4wNWVXQUJCYUkxQXk4a0tDU0orL1pz?=
 =?utf-8?B?eE1MZnBiTHJZaisyYXVaT3VnWTBLYjJsWmo3YWx6dnY2blFuZ2JFa2Ftckdp?=
 =?utf-8?B?TzJSaVpWbnBSS245RXNDRm9xN3lMSGlwZzhrc0VzM0s1T1h4bDlYaVh2eHds?=
 =?utf-8?B?cWhTcmhJWWxOOXVlWEQ3MGk2QlVOcXB1NnhMKzR5ODBaaENkME1lNjJJbWtk?=
 =?utf-8?B?a3k3T0NnUnBUTVQ1RkMyZlJzWk9wYU1FWHpxUGJPSDUyNFpVQVVoc3FzRVJQ?=
 =?utf-8?B?MHJlc1dXYnlVeWZ4OXBFc2xLSmpoTU01TXhOTGpvV1I2V2tyczdYd3FSYkJQ?=
 =?utf-8?B?RnhRaitRN0VROFowTzdrOHZxRVcyZVIzTTdZY0pVUjlWaUx0NG5uaFhNbWFK?=
 =?utf-8?B?MSszWEJjQ0hLWGhvcEx3aUxEamRCV0dhdVVvZFNhaGxTeEtUOEpVcTRkYkw4?=
 =?utf-8?B?QXdxRWZidGUxZlhSZmhIOUhKekxrS3VFUC9rc1lkL3lJdEZqV2pGeVpRdDJ2?=
 =?utf-8?B?eFRIQitBUHU5bE5BZzJJdGRtWXlpbWhVYlpGRmhhUGQvUkprWlJvYzF5RzdF?=
 =?utf-8?B?U3lDaEM0R1Bsb2RpWFZla0M5Z0NTVmRhdXkvRythTHRYN0Vyd0VNWGNTZDJC?=
 =?utf-8?B?ZXdVOHd6UFI3a3BqVEdhUlpDU1AveGtMTzlLVGwwaVZsdWc2N0VQdTlCa1dQ?=
 =?utf-8?B?VnZqMlhtSGl6L2o2Q1ZCVmFMRkU2K1RNSE43MXhiM0ZsWU02bFJXWVYxVURT?=
 =?utf-8?B?d1pic0pSWlRQN1FzNlRTWEloTjBDNXg0YW5UWStWK1laRERFWXF1aW92azRh?=
 =?utf-8?B?cVlmY1puUENNRVUzTDVRbW9RVVBBREhCN1B0UzlVNGpoTU9reW9Wb280ei9i?=
 =?utf-8?B?Qk9kOTR5anJ0TzF1MHhUcDJvOU8vY0dNZFdRYnpqYTdQMXNrbmVCTFIrMnF1?=
 =?utf-8?B?U25DUDh4Q1krWjEveVVyTlpGQUxZQlF5MGU5dHhWNHZhK0had2RmWWtUM3Rq?=
 =?utf-8?B?bG5xb01iaHNoQnRlQlI1YWVqd0RwOFY3VUxFTnhRNUdvd0dxanlrTSsrZjFj?=
 =?utf-8?B?T1J2TnNKaXlHdTEwdENCTVVtQXBMMjBGYTh0QnRZMVVmNjA4NFJ6VGFDUzZB?=
 =?utf-8?B?aHdVMnA0dmRSUGQ1T0J0WkVNTFpPQk1KcWZiRDRtbEhuaTVIb2F3YVR4bnFM?=
 =?utf-8?B?L0JUellpRFdhbWRJd0FLMGc2ZlJBREdoaHBTeSt5UVRsVnZveXRua3NmREFi?=
 =?utf-8?B?UUI0UGNjR2FlRDV5ZzY3MVE1N0NYbHFKbXd0b1Rjc0dmZUJpSGM0eWZHK3o5?=
 =?utf-8?B?cmY3cytHZzRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2lzUW1PY1l5Z0pFeFdpdmxUbzRteVJHamJyZVZRMmZVajZUSWl0UVEzSENq?=
 =?utf-8?B?Snl1bzZrQ0ExQ2xwTnpyVC9MSlcvWmZxOGJBV0F4RnVoNXhxQVBVVXg1NHQy?=
 =?utf-8?B?bk03SG5INFVieXR5enVCSm8zSnZPMkZ5TXpIUUI2em0zY2pXQXduaHpDbjMv?=
 =?utf-8?B?bjF5dDlLS0FTQTJrbE43bnpOK2VKR3hTblpMLzI3Q1JKZ2JNblFMK3hhNjdy?=
 =?utf-8?B?YzhPZkhXWHRCRWFNWUkxUXZ2d1hyN0VWZDlKeUxmU3ZoaDluT2Q2RVJyWjhh?=
 =?utf-8?B?czBVQ3FXWEZ2eDlhYS9lN0xDQTVMdXBEYk41MTNiRXVVdTA0VlBsY21nNEln?=
 =?utf-8?B?TCswSEN1RzZ6bWU1eWhqa0xyUy9MKzhWMU1WcUtzY1BYK21qV00veUF3bk9m?=
 =?utf-8?B?TUNYeVh0dCtjVlk2UTlKMEcreHdUd0U3RmFNOTF0Rjl5TU16Z1BHdkF5NDNj?=
 =?utf-8?B?d3dCTmszZ2dNUEZvY1V1cWwxV3BNYU9PV0VaY0xyU1pyMVZvUnZ4ZWZUOXFy?=
 =?utf-8?B?WGhvaDhxSGhkL2loUWhocEwzbEhwb2lKVkN6bzFwc2FkaEFvWFl5NHgyT0dz?=
 =?utf-8?B?Z2hxY3lCa2g4dThXNFVlOGorcGJTc1g4VzdZUHJrUXNPRUNMaVU2OWxmUVNB?=
 =?utf-8?B?VjBpeWlFOG1BTjFkQjJ4SzFmTGNGZjRBT1U2STdQSllqdVZUeUVJdzdaZWI4?=
 =?utf-8?B?TExzV3IwOVozRDZWNEE0bm9jaitnbjFITE5NYk9kME81aDRNeGxxVmdHVWNI?=
 =?utf-8?B?OTlzRDQrZ1VKSWhsaGwyanU5S0JVT0pDSUFvZDdzVjFycnVLbThQaHQ1eTZv?=
 =?utf-8?B?ZGJnK2ZFUmlGeU8vQm9OYnpicHFmMlkrc01vbkREcCtyT251TnArTWdKRVJ1?=
 =?utf-8?B?a0d5ODU3VitqSDNUeHJGY0RMdnhKdFFNSVZJOUxtN2V3dXN1V0xoT0I0QmZB?=
 =?utf-8?B?Z3pGK3R6endUQmpibTBUTUUxbjZhWmRDbS9VckY4RnNMWnZSVVE4UUR0Ry9F?=
 =?utf-8?B?MXh2RXI0dkdhY2xMZ2Vjb1pUVWdTdXBHUWl1bHhIUFNTOTNPVW00eklLQUZS?=
 =?utf-8?B?L3RoNEdZUFh5eEtLVGRyZXMxcVlJRzhnUUpuQnljWVZJNGVqQ0VmMWZ6ZE16?=
 =?utf-8?B?blZtQUIxclE5cVdZd0xvVWs3THA4RXUzRGJoWUVmV3JrYStYbmRJd3lPQTFE?=
 =?utf-8?B?U09hMzNyaE04Ulc5V0pnWUhaZVVBaUl3UzlYVDFQSWFqQjRCWjNrTERyYUNQ?=
 =?utf-8?B?TzNWcm9HSzM3NnkwcmRoNE0vbXUyaExtQmxtUlZ3S2lLcDhibmdkYU9uRWVi?=
 =?utf-8?B?VkhTU1ozbjhxZlJyNEt3d1hXRU5VbHNCSnBZWFRNN2JiMXlmejJzc2U1YW44?=
 =?utf-8?B?NGVNRXg1cFJCaVBzTTlQOW90bHNjMEFRZjJOVS9FYzZtemhJdHVIVjV1U3I3?=
 =?utf-8?B?a3FxVXJYZVZObEtLYXBEdTkyQVp5dUlJREh5NTRoZlBzam5OeFlISjE2RFl5?=
 =?utf-8?B?dGlaWWxvREF6S3J4VjJKeGFmZVJBdHZPbjhEdFJ4SVEyWWxSWXBzZGJpZkd5?=
 =?utf-8?B?L25pOC9iUGZ6QkwvekVUdmRVYWJaWHZXSXZmV3hrOFBFZjEyM2JvY0JsOEVW?=
 =?utf-8?B?d0lrNjYyUTFad1FxTlNQZVM4bmZZVTZ3WGFPajZQd1docWJYVVNOcmhFK1lw?=
 =?utf-8?B?aWs2N3FtcENFRmR3M3lNMnNReTlMdUlvUVNqdjZUQnpRa2NjQXVuUWQ5NTZB?=
 =?utf-8?B?QVZDREtSQnVBRTk1SWZTYzJBVTlHbHE3S3hWRmpKMU5mRjlGVk1mTnJxSEV6?=
 =?utf-8?B?dXh2UGp4YkVmMVFBVnVxQm4rZ2xsMzRxNnI2Sy84bHN3a1R5aUFpU2NoaFlw?=
 =?utf-8?B?Unc1YkRxdEJzTmphSEcxN2R6dEtVSk9ETGNYMWFsM2lVRlZVL2RjU1duakgv?=
 =?utf-8?B?MStVY0w2UE5yTkl6MTZNdmsybyttY25kaWcwbEVxSTVidjdPZGdmdXN3TkRw?=
 =?utf-8?B?MnpydktRcTIzZkFiK0hQUGxSRjA5aFFJMVhuYmM0T0k5VGpzVnZ5d0IzUVJj?=
 =?utf-8?B?UUFyN3dMNEh1QmZOUTV5alZQWHpSU290dEYycmtWVEh4M2Q3Y3p1bGo3ZG9B?=
 =?utf-8?Q?1JWqBgoRywPRuTEl+kLVjO4xx?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da81af4d-d58b-43ae-d473-08dde92164db
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 06:32:59.7581 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V+sGpbfN1YHHn3rNW3ml6joo038l+14EiQbsX2Eeo0ByxCo1rlVXvnprkTaTGQzRzGE/DzvO46ez8zIGjjli5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10231
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


On Wed, 30 Jul 2025 17:52:56 +0100, Andrew Goodbody wrote:
> In sdhci_iproc_execute_tuning the variable tuning_loop_counter is
> unsigned and therefore will always fail the test for it being less than
> 0. Fix this by changing the variable type to be s8.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied, thanks!

[1/1] mmc: iproc_sdhci: Cannot test unsigned variable for negative
      commit: 95994d4e5996610c8205597b2849b48eaaf2baff

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>
