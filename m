Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDDECE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:28:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B742D8421E;
	Fri, 14 Nov 2025 17:28:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="lAD/5XqV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E40884255; Fri, 14 Nov 2025 17:28:37 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F1C984227
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:28:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEFmthx2638289; Fri, 14 Nov 2025 17:28:26 +0100
Received: from pa4pr04cu001.outbound.protection.outlook.com
 (mail-francecentralazon11013007.outbound.protection.outlook.com
 [40.107.162.7])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7m3s17-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:28:26 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xqm/Tna8wzBoG2bbT7bOP6+qlm/dzX5Lr1nF57fwsUok8fxA7iR5Ir8pgDNQrULmIiOfDk7peaRvWRgQfJg2ae9G8pqf8q1OFUul6J7txMBbKIni3HSh3vCHxAfT4P67eUkpNvY+iicMYvsDpG2xz3N8ifMEI+hXyGiTobiSDehx9spw9lJt5jyhUreMhB1J5mR0u9/apnAzipSHtKD5o3t6qbO459ZnGE65l5VcqNfvBoenIZrauEWv7IPqwIOrNi+78zJ96TUFJ5WtKYt65jgqoX9qLmPCM1aoYRfUtek659RgMoZmZUPgRIj/sGSwdoSdBP/LPZi9IixBqnyt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C3zGF8WoBt70dKpgb/t6HddhAs1+GPks3vY+XP5rEaI=;
 b=KDS1qt4egI7ZJzf5catnASMp04GYTthxlAX+8Jika5U83WYecjrEB+e0hDdXJJJwAv67HmAsgRDbIGo+2Tb04Pl0aeEoPWEtB0iJjLPl+AxuaOc74Ic6ZRNRVV36Sm8/ZuR5ZFnfB5sb5XIjn9X/ImmiEhpTjEYmHzlLyRdVMQd/ffII4PvK6vK3SFzPGCJNXw501TC1H3p/Swn8yaIq2dtrFg/nbDfhV9FqgO4oLzsSSZtPxUWChPSHygdC/vqpDia3qHwHPLPbGc/1z0GLz2WZdtD/jiMm9/w7uhp4RjMRKlRb0p8YVCvDv+1Pdf8qFx0diZ9XP7gUK70LYNmUfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=0leil.net smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3zGF8WoBt70dKpgb/t6HddhAs1+GPks3vY+XP5rEaI=;
 b=lAD/5XqVEEzJaA18siVooARc9sLVCI1o7KyXxoxard4fmYAMKYqM1Si+SFxZuDEZ0aJz5+WPzaUyNuMxXnr/V8kH6uryQuG7ee5lc3Q0Hu2+pDS2uZ8EXrzzQM0jvzjXxi4AOoml8ylYFSW5Qyyk8AT5XQE7fSw3z0U9QfrCFD+IXHl4weJnAg6FgHHSxhNrQJjblBLfLjrTsz/hNu1UuBIjdkJObRmRv9PSfyW+Buvua79w9ki87tPrZtjDV0y5R1CKRwEOy+iss2Il3VWJOsRA6k4xU4Rx3K+wYGAorTYUylZ8jEtm50Ep8LnRCQ2KaHspfcgpaNRTMkJnTbitIg==
Received: from CWLP123CA0272.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:1d5::18)
 by AS8PR10MB7303.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 16:28:16 +0000
Received: from AMS1EPF00000040.eurprd04.prod.outlook.com
 (2603:10a6:400:1d5:cafe::d4) by CWLP123CA0272.outlook.office365.com
 (2603:10a6:400:1d5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 16:28:11 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000040.mail.protection.outlook.com (10.167.16.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:28:16 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:28:26 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:28:12 +0100
Message-ID: <86cd2a31-7997-4b50-ad77-d905e7e58d5e@foss.st.com>
Date: Fri, 14 Nov 2025 17:28:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] led: remove u-boot, boot-led and u-boot, error-led +
 add cmd doc
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Quentin Schulz <foss+uboot@0leil.net>, Ziping Chen
 <techping.chan@gmail.com>, Simon Glass <sjg@chromium.org>,
 <u-boot@lists.denx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>
CC: Tom Rini <trini@konsulko.com>, Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>,
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, Johan Jonker
 <jbx6244@gmail.com>, Xuhui Lin <xuhui.lin@rock-chips.com>, Klaus Goger
 <klaus.goger@cherry.de>, Eugen Hristev <eugen.hristev@linaro.org>, "Durai
 Manickam KR" <durai.manickamkr@microchip.com>,
 Stefan Roese <sr@denx.de>, Zixun LI <admin@hifiphile.com>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Alexander Dahl <ada@thorsis.com>
References: <20251112-led-old-dt-v1-0-2892d49517db@cherry.de>
 <9e1ac6f7-ba6a-42d3-b70c-c2eca078eecb@foss.st.com>
Content-Language: en-US
In-Reply-To: <9e1ac6f7-ba6a-42d3-b70c-c2eca078eecb@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000040:EE_|AS8PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 15414388-86c1-4901-30b2-08de239ad077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UFBBb0NBY2t4NEM2L0ZSVmpnalp1Nnh2R1JDaU9MNng5S1VmNHA2TWlxaW84?=
 =?utf-8?B?LzFCV09VdWZ0S3UxdDFpZW50SnltYVc3UGRQdFFreTQxZmoxOXJYb1FMcWxl?=
 =?utf-8?B?QktYTlFhaDZZM2tFWFlRMlZWVWU4RWZSVWxCb29VZ25Za3pmejFqWUs0aEJX?=
 =?utf-8?B?THlRZjNSd0JQN1VyKzN5bkh2bWJxbTNHd0Ric3FmcmF5Q1FDT0l5UDlZclkw?=
 =?utf-8?B?Nm1FUDJVZG9Kd05XWFkvVTlocGtiS2hqSk9TTjhTSmRYWDRwT1ZvVUN0ZkRP?=
 =?utf-8?B?VzYxOHJZbUN1aEpzN0h3cWVDNG8yQ0RVcUlXL3Y4c2JLeW1pMEtMVjhVOEs4?=
 =?utf-8?B?OHNrWUxLSTVjb0o0b2p4RStPelpoclNOcjZscDExTjNGK3N5YWIxYzlEQnk3?=
 =?utf-8?B?OWJFT2NKY2t4M2tsV3BGNXRGbjM2MGppUmlVU0J6K0ViMzBoK09wVTJULzNu?=
 =?utf-8?B?UDhKNVRVLzZNaHlZSGNEb2VLNU1FWERJdUFMR1QvOW5sTDVBWWpHbGVxeXRR?=
 =?utf-8?B?bWFUcGhFbUlMSzlJeUExQlRsZ1htL21rcE9hSVRVdDdLaVBTYWIwYWRoM0NI?=
 =?utf-8?B?aWFVRjVjMnBNRzBGRTEvY3hITGpLSW1MVlVTeklCeUMydVh1bFVlVWp0MEh3?=
 =?utf-8?B?bU81dGJ5QnI4cUV6SThoNHBxQy9qVm9FQ0FBcTVsR0NDa3ZHTURRMHdqaWZ1?=
 =?utf-8?B?RXJIVG13cU93MUlSS1Q1NGpjbGI4YnFxZlpWYzdQVWZ1NDNKL1pBdG9OMDJp?=
 =?utf-8?B?bU5RRHRyUCsxN3VEOTdVOStoNU53L25CTHYrWEZGYmlrdVp2ZDVUYjMweVpD?=
 =?utf-8?B?amQvTmlOMVNFOTAwMSsrM2NkVitNNnFxVEFobkJ4RGR6UXlqS0d3aG1tRkJB?=
 =?utf-8?B?WmE1U280Z0kzbG5uWXk4Z3ZmVzBpMTlmcXJlWmxlUnpyMU9YbUxzU0lHM29N?=
 =?utf-8?B?M0YvQ2NuMUsyUWRWUk1neXdQT2d5cW04MGI5NUxSWUNlL1pkM1dOSXYrblFR?=
 =?utf-8?B?T2RDT0Q3M2xKaFVwRGQwRkxJS3JnM1l0a1AxaGhzWnZTUlZpWEtRSEdOY2ZC?=
 =?utf-8?B?cHYyK2p1YXV2VzVBQUx3OUI4NVcxNGNYVWphMUF1Z2txaDZvbXJoUU1Zem1J?=
 =?utf-8?B?Zmw2K1RPb0ovcEs2QTBHcGFtTlZuclVWMk1UNnh2NTU1VFUzVldyNWR4a00y?=
 =?utf-8?B?ZkJLaDUxaGFQL0Q0SW9pOXpVSklaN3pNSElrZjYrTU5aL25tT3NYaUZlcitN?=
 =?utf-8?B?by9XbVRzeXlDMkVNTmowVWdoMmlLcGd5OVVHa2t0am1IZ0VMSVJTNmNHTkdW?=
 =?utf-8?B?NjU4UkFCM3UrUnZVUHNtdkJ3Z2ZmOGNtMFpqamsxVmlyZkg5UTdLUHJyTzJS?=
 =?utf-8?B?ZWFPTDMrWXY4MlJ1NUk3S0ZBY3pBV3ZqYlVIMUY3QUVBM0htU3pkSW1Eb3lH?=
 =?utf-8?B?WTNMSUx6MVArd1VZa1prcFJYS3FmVnpDQlVidHpmQ1BVMnAxUXVUbU5qMVZE?=
 =?utf-8?B?alByQUZ3ZjBKTGZZdnJhV2dpeUZGNThFMnVxTmRobWNkVmJ6bFB1am9Zc05E?=
 =?utf-8?B?QlN0eVBWVlloRjlsQmhWdW44M1JTNTRwWTU3bHN1ejFKL0pRNjBFQy9VRmtX?=
 =?utf-8?B?RVJ3cW94VCtFK1JIbmdtV0c4ZUtkNE9XWmlRWUVsUG9PMktXK0c5ZE1KWkFZ?=
 =?utf-8?B?SlBJeGdCVWRSckUrUkNuQkNmOUd5cTJwamFpakd6NHBxT3RvS2lJWkRkV1Nz?=
 =?utf-8?B?Y1BMc1h3ZVhRVGwzUFozZ2kxdW9VUXdMdFRrZnU4Mmp2L2xBRkN5U2tRMU45?=
 =?utf-8?B?L25UMlkyRktCcjRaN21yNTZwUjkwRVk2c3cwU0JkNGdJTmJWMzFOZ0Jhb3Zh?=
 =?utf-8?B?dTIxVHBWUXp4Mks1dXNCcG81QURoZ2d5ZDNPZVRVV0JjaSt6R3JjWW0wNUpY?=
 =?utf-8?B?V2JKOUF6bmZUSXhxSUFIWnBjRlFGVkIrWWt5ako5aVVrQndOSElCU1VoUC94?=
 =?utf-8?B?a2w0alFUM3JaTW04VDBxSXNIbVI0N1hlWDU2OTBWRkpIakFUNXBrMmU2VUxx?=
 =?utf-8?B?bGRYZnBDS1B2d0hmaGhhR1FuRlZEVnF2UWxvQVlqZ1ZzeVd3UHEyYzhkdzZt?=
 =?utf-8?Q?J9l7MJH3oNfZj65Z2pp4fdafX?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:28:16.1841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15414388-86c1-4901-30b2-08de239ad077
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000040.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7303
X-Authority-Analysis: v=2.4 cv=AZK83nXG c=1 sm=1 tr=0 ts=691758aa cx=c_pps
 a=IZAV03aadox+VGuitpplQg==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=8b9GpE9nAAAA:8 a=voM4FWlXAAAA:8
 a=YG64nluAAAAA:20 a=mK_AVkanAAAA:8 a=6ncOQv40WcfTfMuExKkA:9 a=QEXdDO2ut3YA:10
 a=T3LWEMljR5ZiDmsYVIUa:22 a=IC2XNlieTeVoXbcui8wp:22 a=3gWm3jAn84ENXaBijsEo:22
 a=bA3UWDv6hWIuX7UZL3qL:22 a=nl4s5V0KI7Kw-pW0DWrs:22 a=yULaImgL6KKpOYXvFmjq:22
 a=pHzHmUro8NiASowvMSCR:22 a=6VlIyEUom7LUIeUMNQJH:22
X-Proofpoint-ORIG-GUID: vmZ-opaKUjYd3CFH8IABrFkFXfaB25Nh
X-Proofpoint-GUID: vmZ-opaKUjYd3CFH8IABrFkFXfaB25Nh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzMiBTYWx0ZWRfX1ugC3IndwoP8
 Mgg/dzbbVF3bhGKwSod1X0lz+KOZXLcysyFBd8WtZbT9SNgIZ+MfyMy4ddBOY6Mwk4NEkq0AaQO
 sL8i5J5x/3rD2JUD11a87G2MawSFqxo43p28BBlO3uZPx/1nTITPoEIxNKd/h0Q6IBP0H9rlMBs
 uo35l1D2zkwyR4Qb8DXUTXuBkY1UqeWwISxI+pYf9241Nb8Ighm3TXiT8Lf0L8UlmPrsySH4sJJ
 a9GRp/NT7Tdx8eb9xN2Z5lLra5VWEqwMgfMfLnB8fRxwhMOGtUEISrRuRaCDEK8mzh/mFl8hLnZ
 m4ZX3n6G03Ws7Iqddo27gHnkeuNLYRs4l+MwavP6sFBYvHwik+B3LXkfM6gdzYqZpWx4fLd9EPD
 uEibodLkdIlmhLiLMY+R6kXnNen1GQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140132
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



On 11/13/25 08:03, Patrice CHOTARD wrote:
> 
> 
> On 11/12/25 18:48, Quentin Schulz wrote:
>> u-boot,boot-led and u-boot,error-led aren't actually handled by some
>> generic code but rather by board or architecture specific code. They
>> also aren't properties that are part of the official dt-binding so they
>> cannot be upstreamed. For u-boot,boot-led, there's actually a proper
>> replacement which is /options/u-boot/boot-led[1] (+ CONFIG_LED_BOOT=y).
>>
>> For Rockchip boards, either nothing (for RK3066, PX30 and RK3399) was
>> using that property or (for RK3188) the code handling it was guarded by
>> symbols that were not enabled in the defconfig. For those, the property
>> and guarded code are removed.
>>
>> For the Sam9x60 Curiosity, it seems that even though the LED is
>> controlled whenever CONFIG_LED is enabled, it isn't enabled by default
>> in the defconfig (but the code was added without modifying the
>> defconfig, explicitly leaving a choice to the user). I decided to keep
>> that feature by simply migrating it to the new API, though I cannot test
>> it as I do not own the device.
>>
>> The STM32 boards will be migrated in the near future once their upstream
>> (kernel) Device Trees gain the new way to specify this (via
>> /options/u-boot/boot-led). I'll let Patrice handle this, see
>> https://lore.kernel.org/u-boot/94ed1988-13e8-4fe3-bdff-ba2c9973c556@foss.st.com/
>> and
>> https://lore.kernel.org/u-boot/2a3aa43a-ce19-41e1-ab56-556629ce5cf9@foss.st.com/
>>
> 
> Hi Quentin
> 
> As mentioned, the 2 above U-Boot series about STM32 led update will be soon superseeded 
> by a new series.

The mentioned new LED series is now available : https://patchwork.ozlabs.org/project/uboot/list/?series=482122

Patrice

> 
> On kernel side i submitted a DTS update for STMicroelectronics boards: 
> 
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1022526
> https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=1022570
> 
> We will heritate of this update when U-Boot DT will be synchronized with kernel DT
> (probably linux v6.19 i guess).
> 
>> After this, only one user of u-boot,boot-led will be left, based on
>> STM32: board/dhelectronics/dh_stm32mp1/board.c. @Patrice, maybe that's
>> something you want to have a look at as well, this seems to be some
>> evaluation kit?
> 
> I will let Marek to take care of dhelectronics board.
> 
> Thanks
> 
>>
>> The only users of u-boot,error-led are STM32 boards, so I'll leave this
>> to Patrice as well, I do not know what's the way to go for that one.
>>
>> In any case, I would like to not encourage people to use out-of-spec DT
>> properties when there is another option (u-boot,boot-led), so I remove
>> the properties from the dt-binding document from U-Boot.
>>
>> The help text for the blink subcommand of the led command was misleading
>> so this is now fixed.
>>
>> This also moves the content of doc/README.LED into the doc/api/led.rst,
>> while clearly stating one shouldn't be using this anymore.
>>
>> This also gets rid of dt-binding that we already have in dts/upstream.
>>
>> Finally, this adds documentation for the led shell command.
>>
>> [1] https://github.com/devicetree-org/dt-schema/blob/v2025.08/dtschema/schemas/options/u-boot.yaml#L113-L116
>>
>> Reported-by: Yegor Yefremov <yegorslists@googlemail.com>
>> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>> ---
>> Quentin Schulz (11):
>>       cmd: led: fix help text for blink subcommand
>>       doc: move legacy API documented in README.LED to doc/api/led.rst
>>       doc: cmd: document the led shell command
>>       doc: dt-bindings: remove duplicates with dts/upstream
>>       arm: dts: rockchip: rk3188-radxarock: remove unused u-boot,boot-led
>>       rockchip: rk3188: remove setup_led from xPL
>>       arm: dts: rockchip: rk3399-puma: remove u-boot,boot-led
>>       arm: dts: rockchip: px30-ringneck: remove u-boot,boot-led
>>       arm: dts: rockchip: rk3066a-mk808: remove unused u-boot,boot-led
>>       sam9x60-curiosity: migrate Boot LED setup to use /options/u-boot/boot-led
>>       doc: remove u-boot,boot-led and u-boot,error-led from "binding"
>>
>>  arch/arm/dts/at91-sam9x60_curiosity-u-boot.dtsi   |   9 +-
>>  arch/arm/dts/px30-ringneck-haikou-u-boot.dtsi     |   1 -
>>  arch/arm/dts/rk3066a-mk808-u-boot.dtsi            |   6 -
>>  arch/arm/dts/rk3188-radxarock-u-boot.dtsi         |   5 -
>>  arch/arm/dts/rk3399-puma-haikou-u-boot.dtsi       |   1 -
>>  arch/arm/mach-rockchip/Kconfig                    |   1 -
>>  arch/arm/mach-rockchip/rk3188/rk3188.c            |  36 ------
>>  board/atmel/sam9x60_curiosity/sam9x60_curiosity.c |  16 +--
>>  cmd/led.c                                         |  11 +-
>>  doc/README.LED                                    |  77 ------------
>>  doc/api/led.rst                                   |  89 +++++++++++++-
>>  doc/device-tree-bindings/config.txt               |   5 -
>>  doc/device-tree-bindings/leds/leds-bcm6328.txt    | 106 ----------------
>>  doc/device-tree-bindings/leds/leds-bcm6358.txt    | 141 ----------------------
>>  doc/device-tree-bindings/leds/leds-gpio.txt       |  52 --------
>>  doc/device-tree-bindings/leds/leds-lp5562.txt     |  63 ----------
>>  doc/usage/cmd/led.rst                             |  95 +++++++++++++++
>>  17 files changed, 194 insertions(+), 520 deletions(-)
>> ---
>> base-commit: caa740df9cae5ddc74b18b88a4fea43e27b2fdf6
>> change-id: 20251112-led-old-dt-dc24605ddc88
>>
>> Best regards,
> 

