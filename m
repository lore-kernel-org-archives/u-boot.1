Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40C4CCF9FE
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 12:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3332C836D1;
	Mon,  3 Nov 2025 13:23:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="VV/Lszn8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8325C838E5; Mon,  3 Nov 2025 13:23:16 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095DA8331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 13:23:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=34027e0d09=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3CBQQH3271719; Mon, 3 Nov 2025 13:23:09 +0100
Received: from mrwpr03cu001.outbound.protection.outlook.com
 (mail-francesouthazon11011034.outbound.protection.outlook.com
 [40.107.130.34])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a5vn6wss6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 13:23:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yttjLuom00HqUCrxgvDVpaYb80+08YmyS1VFtHxGzpC7dg6pDuLbzqb5+oLzCbQysVM3rJ/xJfNjMv+HpSuHPNU9TGPTg7isFYhZHthFIXX2xsu2zQJ3vHBhOn8rwzMG3VCsXEeSNUvf+KibqoC0bH4yPcbWFGNM0omg2lAIM/vT41cfjCZLLHt2umXtc+6bGJqhnnZ1m4nFjjdRNcCOezW6p+O65WxEGKKhyZGTMR1/6lOCw6UzTzcRpxhDvpPypFoYayyuAOQ1ip7Qy8UQghCUwyFU8ti+eOTC5uqA0iz5KS+KNg2NtG9M/LnhmkLMOJLo+mGCC9ssXGNtmwjwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqEFJQVuuX/M40ErJUqaL74k3PsLlDAUq77+tL/+m+E=;
 b=xOiG90pwPIAG/0qYT7zgTdvmmNlATmGFMPOF5FI2gwFmiHpMWV+DOj3T0JCLwgHZ24T/JwmPDjeJzs5Dzma1qNcUAifUtpzLga4l550s8ryAONtlMh3OyiDjq3l5RKlcanYw6YuKfGZEjSZP/uV8rrkMzBWoeqLw012Nlh0UNXhsBuBhmCqR9SU+q3iyJspdKWhrr7kpOzvjtmOBA3YXxDZZ+9fO5BFHnaWhZN0ho8o7g6WlG0FG5YP0xsg8fuXajj19+/tSJHHGib9LxVWYTxB5JV0YBd02w/IY0O0U8vfRdxHCyz1kw5U7tqQvDHO+gqWJLXUXB7zOEZ6W91a2WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqEFJQVuuX/M40ErJUqaL74k3PsLlDAUq77+tL/+m+E=;
 b=VV/Lszn80/oCJNdAjTRdEtfIU51hkcShtjuWRdCN0J0QEdALjez4tvelRg2ZQ8FBnAkgO5DdzaN3/fUXWrafIPjItLo3eII04+v8sIgE7qeJSfv3VWw5TKeg2vc11o4GrUcjPH/Dc8HamQsonB8HfD5H6c/7FQUgg1QIgzlDNgkntfqbRxESge8enSxFLaLDVPV1dWNLV6d2vrj/WHLbb2CSod+RzNPRuneQMOt8EfG+xQ7viq7dUg8H4lvd3QwzfzbBiBQvaQeW5o2im5VEnGNZhVVGnXgsAQz5MNaNrliqtHFsOgJUrkVpmSK+PoA/XUVvLcomDqSCsxczg8XIzw==
Received: from AS4PR09CA0014.eurprd09.prod.outlook.com (2603:10a6:20b:5e0::17)
 by PR3PR10MB3915.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Mon, 3 Nov
 2025 12:23:07 +0000
Received: from AM3PEPF0000A791.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e0:cafe::a7) by AS4PR09CA0014.outlook.office365.com
 (2603:10a6:20b:5e0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 12:23:07 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM3PEPF0000A791.mail.protection.outlook.com (10.167.16.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 12:23:06 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 3 Nov
 2025 13:15:44 +0100
Received: from [10.252.19.9] (10.252.19.9) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Mon, 3 Nov
 2025 13:23:05 +0100
Message-ID: <caa95f0d-235b-4819-a655-963d979e5b5a@foss.st.com>
Date: Mon, 3 Nov 2025 13:23:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: scmi: Drop mmu_set_region_dcache_behaviour()
 misuse
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Etienne Carriere
 <etienne.carriere@linaro.org>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Viorel Suman <viorel.suman@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20251025213537.238103-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.19.9]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A791:EE_|PR3PR10MB3915:EE_
X-MS-Office365-Filtering-Correlation-Id: 230cfeec-51ae-4870-9c6c-08de1ad3be77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUg5VlA4YmY4R0R5WWdNNWhQem51Rk1Oa2FjemJsUFhpOHJGSTJtcVJJbXBK?=
 =?utf-8?B?a1JwU3JrUUtoektMMFlHNEpmZk1CQnRNZHZoMjIyWVVNUmh4cTMreHlJOERW?=
 =?utf-8?B?ZmJiVFQ3VEZERmN1dkpuNlpwZHRudW1yY2QrdVhYRVo2RjVQSGpiejlwNHVi?=
 =?utf-8?B?OWtsTkRSQktCTW1IRm1UZWJwOE1EUVBUT3dIY3Z3dmkrcTNORFZjeFRXNkxR?=
 =?utf-8?B?eW4wL3A2a09vQ0crMWViaXhBQVV4eWtHSURXZ0Uzek4vUVR4NlBtWnBzQk5o?=
 =?utf-8?B?b0ZURWNSdHJuNUNQUVlBK0xpSjNHc3o0TnlORlVzYzF4cnVteUswRnI5N0dV?=
 =?utf-8?B?ckxXd0lkQ09GcWgyb1hBL1lacWx6NTdJT3Rrbm1uWmw2d2VBbkJOZngyUUt5?=
 =?utf-8?B?eHBZQXJMZCtNMGVuNUJ3ZHJuSE5ITHRPeVdLcGZXb0FKaUdKZFptNlVYTGpt?=
 =?utf-8?B?WWc0ZURPb0lXQ1JCeFZvTVNZY0w4NndSSVJIaUg5aXlKZnpiL3l1ME1qNUlL?=
 =?utf-8?B?d0I1U1haSmdnSkRPYXEvT1FHWnJIWll1ZklRODdmclIwcUNaOVM2SDBBd1Fk?=
 =?utf-8?B?Q1NodkEwR2x5UU0rbkM4TlBwaGs3OHY4OFZtcndud0hSY0NvTmUwUnlXc0Zo?=
 =?utf-8?B?aHBzWkZQWHRBeEhkMThUczlZMThNUGJRTFRZbUdyQXRkdndsTnVxdktNWnVG?=
 =?utf-8?B?V1Nua2VyY0pkZWZZZXhGNHp5RmhrZk9zK3VzQkFiQ0h4MHJXRk5RUWhZSWZm?=
 =?utf-8?B?R0c1U2dpYkNqWDZoRENLZzhPd2w1Zk9MRlUyaDJHZWVzbXdqbXBlWFU3Q0dG?=
 =?utf-8?B?dWgrcGljbTFjenVOT2p3MGdyYlZXN0F1ZTVVWktyb1RvMElzbUY0TGV2L0V0?=
 =?utf-8?B?ZkVVOXFHdXRCWjc0NVpyajgvaHMzV2J1TldpM3dKZjJLalpMaGc1eXZVOFp2?=
 =?utf-8?B?SjY1T094V2xiQVprMjF3WkdweFA3dnlON3RXZHFlK2E3WldTSkpyRTN0V1Za?=
 =?utf-8?B?aFl2M2dtZUZYRFpPSEZmMXllUFNOSkxIYTFlRDJWS3M2QzlYWXppRm5tY2Rl?=
 =?utf-8?B?ZE1ZZXVYcWxtL0tBUXVkL29rMHpzV0gwZXBYTjdqelJ1TXA2VGkreW1ubnVi?=
 =?utf-8?B?eVJBOFJwMjg0MGV3YldaMmVNUlIvSTU4bFpGQjMrN2VCQUJHd2hEM09EUy9v?=
 =?utf-8?B?NzZSRitla2ZneG5PL3V3L2EvTUtYZWQ3WjNneDZkY2l0eThVY09LRk5XNFEr?=
 =?utf-8?B?d2xzTDJCYWI0NEFyL0RDOVpKUlVZeDZQTjUzQXlYZXdKVUVoZCtvYzljV1No?=
 =?utf-8?B?V3h0MjkzRXVuNldiZ0FLbGtRL0NpbUUxUjB0QThqVG5McXZTYTZ3Si9PKytw?=
 =?utf-8?B?MmNBaVd2V2YxUzRHUk4wd0dHVkpHWnlnM2J4czVEczB1WGMzNUQxOTlCNWt0?=
 =?utf-8?B?eCtTZXNFL29UTW5KakZtMTQxdDZIL2hMaFBJN2xja25kMmVBdll5UzNGb2xh?=
 =?utf-8?B?SlRYK3NxTmVPSktmdStWcXlMeis1VkJua3htNEdjMDB5c0tLMjVHbWFuY3lr?=
 =?utf-8?B?bElvei9ITWFVUXIvcklOd3RCTEJ0MzU5a0RMWi9VVXlFNGFRUlF6d0YwM3Ja?=
 =?utf-8?B?R296RGRQWEZuU2dXNDFWNVpyczB1Yk5Bb0J3b2J2ekQyd3VYdG56eENkVE1Q?=
 =?utf-8?B?QzI1T0s3eVJoZUh6WW9ZeHVPaWV6R2diMG53T0dydHhZdUREa2lTdXlmYXNP?=
 =?utf-8?B?bW8rOFNRVHNKczUrUHVqenF2S25KVmNFSVJudGVFRkZDcSs2NktPVnhGcEVt?=
 =?utf-8?B?QVZEaTdwWmY0L2RCNCs3SVE0U3JhN3RqdUorSnN0b0J0bDA4dXhucTBqUTh2?=
 =?utf-8?B?SHE5NXRHM3dKeW1SclhSaWwrUnpsMzU4U1EzRTlXWEF5ZTF6QWxBaEl5Ny8v?=
 =?utf-8?B?Z0luaHZtN3BacjBNcVFqbW8wTldscGNuT0N2cEtsZHVkYjBOV1hZQURMY3VC?=
 =?utf-8?B?Q3FuN2RMSm1BMXdrRmdzL1RZVmx0cC9lQXNUaGJkQkROTlhGam1NaHQ1Q2pa?=
 =?utf-8?B?amxBdVdkb0UrV0RGbzIwZXRjK3ZqaDhTTW5vQi85WVV0UWc3SytKUEdZSHQ0?=
 =?utf-8?Q?iqi0=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 12:23:06.8252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 230cfeec-51ae-4870-9c6c-08de1ad3be77
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A791.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3915
X-Proofpoint-GUID: Uw7zczEZpR7M-mwInqqEucamFvGDnGd1
X-Proofpoint-ORIG-GUID: Uw7zczEZpR7M-mwInqqEucamFvGDnGd1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDExMiBTYWx0ZWRfX/HPkBQEL2Vzr
 5Du/hWQISZ+Yk/+alpoG+znfS7ABq63aSVk8wLD4PxYeOBs7QgFL+mKEdDJ73o7PtVij1dneMOS
 qhgzmM0mJPFrjMMKOTf4eoRJgfHUr5Qi5qzkhtllmWD0U1qScZsokyTHUsZ67q0DCHz36SyvUtW
 O8oSigjLVD84zNYb/OnfW6PLawL8lpyMuV14TsE3QrEHdwYJleV4SQonRA6YgrIWy00E6+kPVGp
 y8lfMz3n9pVOOjG7p/S6iljpa2QN93degslJuTFloO+nWCLoYJVNPc+1JdsP6Pe9LmHnzhoSp/2
 jgBr4fFKUzbrgXMP9HhHcf6oaXpmh3v0flRdbICqn8jqXWGqy7lNjf/nZyl994QZoXr6ycQJWAn
 Ezk1lFWtnHy0rKjFyBFZzjMeSjvP2Q==
X-Authority-Analysis: v=2.4 cv=evjSD4pX c=1 sm=1 tr=0 ts=69089ead cx=c_pps
 a=VwtKaFcTmusYpkPuFWuODQ==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=LWFDW_aBuFoA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b3CbU_ItAAAA:8 a=8AirrxEcAAAA:8 a=KKAkSRfTAAAA:8
 a=8b9GpE9nAAAA:8 a=k-42gJp3AAAA:8 a=yC-0_ovQAAAA:8 a=ZxeqqSA_CMPySrkBifwA:9
 a=QEXdDO2ut3YA:10 a=Rv2g8BkzVjQTVhhssdqe:22 a=ST-jHhOKWsTCqRlWije3:22
 a=cvBusfyB2V15izCimMoJ:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=uCSXFHLys93vLW5PjgO_:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_01,2025-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030112
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



On 10/25/25 23:35, Marek Vasut wrote:
> MMU region cache behavior configuration for SCMI/SMT mailboxes is
> platform specific. Even on ARM systems, the mailbox memory may not
> even be located in any cacheable MMU region and may instead reside
> in some SRAM. Remove this non-generic cache behavior configuration
> code from generic code path.
> 
> It is unlikely that any platform is affected by this change if it
> did configure its MMU regions correctly on start up. Platforms
> which might be affected are i.MX94/95 and STM32MP.
> 
> Fixes: 240720e9052f ("firmware: scmi: mailbox/smt agent device")
> Fixes: 2a3f161c8b16 ("scmi: correctly configure MMU for SCMI buffer")
> Fixes: b2ae10970d40 ("firmware: scmi: use PAGE_SIZE alignment for ARM64")
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Etienne Carriere <etienne.carriere@linaro.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: Viorel Suman <viorel.suman@nxp.com>
> Cc: Ye Li <ye.li@nxp.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/firmware/scmi/smt.c | 14 --------------
>  1 file changed, 14 deletions(-)
> 
> diff --git a/drivers/firmware/scmi/smt.c b/drivers/firmware/scmi/smt.c
> index 237871559f0..cd1c0801f72 100644
> --- a/drivers/firmware/scmi/smt.c
> +++ b/drivers/firmware/scmi/smt.c
> @@ -61,20 +61,6 @@ int scmi_dt_get_smt_buffer(struct udevice *dev, struct scmi_smt *smt)
>  	if (device_is_compatible(dev, "arm,scmi") && ofnode_has_property(dev_ofnode(dev), "mboxes"))
>  		scmi_smt_enable_intr(smt, true);
>  
> -#ifdef CONFIG_ARM
> -	if (dcache_status()) {
> -		u32 align_size;
> -
> -		if (IS_ENABLED(CONFIG_ARM64))
> -			align_size = PAGE_SIZE;
> -		else
> -			align_size = MMU_SECTION_SIZE;
> -
> -		mmu_set_region_dcache_behaviour(ALIGN_DOWN((uintptr_t)smt->buf, align_size),
> -						ALIGN(smt->size, align_size), DCACHE_OFF);
> -	}
> -#endif
> -
>  	return 0;
>  }
>  

Hi Marek

Tested-by: Patrice Chotard <patrice.chotard@foss.st.com>

Tested on stm32mp257f-ev1 board.

Thanks
Patrice
