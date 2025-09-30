Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD6ACCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 15:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D6E80819;
	Tue, 30 Sep 2025 17:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="XGZeI0gP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2530802C1; Tue, 30 Sep 2025 17:42:12 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1102800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 17:42:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=236888059d=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UFSRap003117;
 Tue, 30 Sep 2025 17:42:08 +0200
Received: from gvxpr05cu001.outbound.protection.outlook.com
 (mail-swedencentralazon11013014.outbound.protection.outlook.com
 [52.101.83.14])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 49e5bf5duh-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Sep 2025 17:42:08 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdhPTzvQregMJEj4WoYDZtq41THchF81sGXCa2f4FBVqR9qrfSq7sK9237aUu2h6tf4wlQuYm2S8SZ1QVhjrw2Qwd0mdi3FM/xLpbY5K3gPxP9uE8XY8u8w74ESkETyLleb0Nz8J5G7+rAOR8+U3b7iZChbExRHROLOcP0b21FkyvHRKF0bimpmNakvy8dqEf89q/pqlpBTNdt7SnF7ZV7+KBzQ1r032Emu4W+MXufH1bfKKUezwfmlnJJV/Gfol+cJqBJS22BnTQnPCh3wLDqVHoemASHq1GJ3Uhq07xMBb09LMt8wtKJk1KXiAJtmn1hnEzQNKZCHdEhj2am0xGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDQhQvhhMoYROG0E+mOS+o1P57IGN8Gl3EYbJjJPs/0=;
 b=cGI8zxuwCoHnE/19+kjSczKwbuHbVFlUCnmkzwfISxBvorv57l0u8Hnup1h+1JDoKduKkN26dajszQJZYzQl/UDxYYIf4PGaOynnuXpUBlAOf+R3MJO9aAJ4ZrSv1S5M16pHr5pVEHvj5qe8u5tb1c9bQJx4yUi6nqmaGqN9CcTBLAiER8Df9vnR88sfFTKUv9YfLBXZVNGwvGsEwFg3Xw1ZNNZtJ/GtNzeg6fJeBSehQtRVVY4wCVinNieHujmX2ppjzMHh6jBTknjT+ptEAf/Y0Bfxn45pZD0zZseV6++1kQjqZ8yhUAuwX2zWPC85HQ27vaRnwHf1nSP/gBSLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDQhQvhhMoYROG0E+mOS+o1P57IGN8Gl3EYbJjJPs/0=;
 b=XGZeI0gP9hABO4FGOfnS6Bds+0LE/HBL3dT03lmKz7CLrUSqsJfprMdQamRd+YXZaY72cQ+VZtJwgt5SrJAwN0SOJ9bL9mQDVeBTjx26lxv5Z2QxYTy6S3Fr0b/Ll06Sf66TUOn2JCznCxKKHQ5BEtceVFoeBRlK6b6vYFg48mVHVTGBSzUVN2B35eMHrklG3ITHXErTGG2VmGTCPlbCqsqH8x5ICX8SqF4cjtAUxJSb2NuUs6ecMBIsfNR2qle/Yf2zf5e3jkGhYMplZTTm9i28vLCLdjAnWScSKiUoZwB46WCh9y6T8Q1bhnn18YG2KGpPHwjz2k/wifgQZeSubA==
Received: from PR1P264CA0008.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:19e::13)
 by VI1PR10MB3166.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 15:42:05 +0000
Received: from AM4PEPF00025F96.EURPRD83.prod.outlook.com
 (2603:10a6:102:19e:cafe::f2) by PR1P264CA0008.outlook.office365.com
 (2603:10a6:102:19e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Tue,
 30 Sep 2025 15:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 AM4PEPF00025F96.mail.protection.outlook.com (10.167.16.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.1 via Frontend Transport; Tue, 30 Sep 2025 15:42:04 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 17:34:47 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Tue, 30 Sep
 2025 17:42:01 +0200
Message-ID: <85c9a7e9-cb2b-43cb-8123-9340245b8f9b@foss.st.com>
Date: Tue, 30 Sep 2025 17:42:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "board: st: stm32mp1: Clean env_get_location()"
To: Kory Maincent <kory.maincent@bootlin.com>
CC: <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.denx.de>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 <thomas.petazzoni@bootlin.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>
References: <20250917141736.59732-1-kory.maincent@bootlin.com>
 <55d0805b-dcb2-4277-a4da-f4c26b48a2dd@foss.st.com>
 <20250929170912.3bee3f9d@kmaincent-XPS-13-7390>
 <fd32f45e-a3c9-4170-8886-5a31dda0e4c9@foss.st.com>
 <20250930101656.28f4bcd0@kmaincent-XPS-13-7390>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20250930101656.28f4bcd0@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F96:EE_|VI1PR10MB3166:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c129a50-9252-402c-8648-08de0037e7d1
X-LD-Processed: 75e027c9-20d5-47d5-b82f-77d7cd041e8f,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ckkrUkM1em1yc0tHWGJjVHBJZXVwODE2a2QrVnR4K3V2OGRwNHl5VWNnTVVh?=
 =?utf-8?B?N1RsMWJNOEVSdkhzMmJDRUg3Z1NZdlRaTXp5N0h3azJuaEFNTmZqK21TWm0x?=
 =?utf-8?B?b2VMcmxNZXRPMGRUQXg2WjBGSmxhcXd2UkhnRm91b0xpU0hET3IrdU5xOTJP?=
 =?utf-8?B?NFh1RERvbFJ6ZnMzakpsTlJvRDFpNy9ZQzhQcUI3eVVhUDhUWmtQY1BaL3F5?=
 =?utf-8?B?VnVsTFk0TTE2Szdxem5URGpoejV4eGFDTlMwenRRQUw5NC9uTUtRWC84MTdX?=
 =?utf-8?B?dW9yeDFGZUU5Nko1M0cwZ25oK1I3Mks1bjloOXVwcVEwSWo2c1VRaDNOQmNr?=
 =?utf-8?B?eU5sY0xsaUxsZEp4ZWNGa1FCdFB1TW52MzFLRlNtaHh0SWIyWCswcG1UeWVZ?=
 =?utf-8?B?MmZMSENKL2ZFQVJjZHQrYUxINnZlM3RTL2ZjZ0d1VzN5dk4xUFlTNTVSUFRN?=
 =?utf-8?B?RzVldTJtSDdVUnNUOXdMc3dEZi9UV2tsK3UvMzd4TGw1ZCtoTmxndTlaOFNt?=
 =?utf-8?B?cjk4R1ZmVUNGYzdid1NXWStNL3hsSnpEWE9JZWR2dU45Z3hBdmJab3NZZjR5?=
 =?utf-8?B?bWg1RXpyQ1o1YllERThQWFYvekt3aEdqM0V4ejdkVjJnUE9CQTlRc1lEOGZF?=
 =?utf-8?B?L1l3VW5PT2VyZ0pKazdKNWQ4N3FPb2ZWU09ORWlNdno0L09tUzlRNmJqcXcy?=
 =?utf-8?B?N05tNTMvNEZ2d0kxOGhlZWlYcEM0QVZuTlJVL2V6MlRrNVd4dDBEa2pYT2VR?=
 =?utf-8?B?Ym51azFyUUxZZGlkdUtlaU9jemJWQ0VxZFQ3TWdUWDVUWTZJbUVaUlpRRjlD?=
 =?utf-8?B?akNUaGl2QmRHenFUOU5MUVozcklJdVk3R2ticzZBcUZwbmdqQysxQlB6aTZu?=
 =?utf-8?B?bjRtQ0MxNVBnc2hsWkgyaTJTcFYxNjV1ai9vOTNhOWQzK2pndytoTWRmdGE1?=
 =?utf-8?B?cjVtRzZteWNsZEFsc29LUHdqSjUxaTExTXkrZEFQWnJ4bjhYN0NNcE9jSVY0?=
 =?utf-8?B?SlpmRU9IaUtHaFlTc21qNEJBUXU0aEtLTFZ1NENCY1VsNHBneFhVMjd0Z1hx?=
 =?utf-8?B?T0VJQWpiZGNpOVBJSGtVVTU4UWhRa2VCUUgwL3NOV200MEh0aDhsaEpRZWtJ?=
 =?utf-8?B?UWROcjRabG0xZC9CMkx6bkVDenRaRUp6TnBYalIvbnF2VU1kRlBISjZCVTh2?=
 =?utf-8?B?UkdpOHBsOHRMRUxSUWxabUozY2EydGl0S25QR21paHk4V0VGUHAvdjZDYW9u?=
 =?utf-8?B?b3VCYXdqWVVEVVdqZHFtUkpJNTNXSm9zSGxPdWdka2Q0dEwya2pLN3VieHBz?=
 =?utf-8?B?ZjJRb241YnlMK2pOeU5QOVE4cGh1b2k1ejlVZUhpUWZHc2MzOTQyc0ZQQ2Nv?=
 =?utf-8?B?UXdMbGtKQ3dxUkNzWWhRRVphaDhTNTBrNGJjNE5UU0s4YUVUc01SeDl1S1NQ?=
 =?utf-8?B?U0xXaUNLYnMxK1QvcExmdVVXUWF2Tnp5K2FxcGZOVHUyTlNUWURaMGdZbXRw?=
 =?utf-8?B?Y3hoZk9JZllpcDExbVBWZTdOY1RNOXZLOGRGOHFFS0JCWURBWWVoZVNlNlZE?=
 =?utf-8?B?clZhQ3R2eTlCOURkVGZJNjlVc1NkbGNUVjhoMG9WcHkzQXFJY1Z2Q1RhdCsw?=
 =?utf-8?B?M0tGL2VkY2VMUGE2eDlBdW1odHZTUWNWRE05VnBPVUxpcjA0ZENCaHRDOFJG?=
 =?utf-8?B?Vkd6Vzl5c2FwYkQyakpWSWVWanNyK0k1bVJ0eXl0WmVkUEZWaEVEekxHaWJK?=
 =?utf-8?B?b1JKYkEvYm9mSHVxcjN0Q1hBbnJaaUZkSlJJaGFSeWtQWHdPam03Tmh1Z1RE?=
 =?utf-8?B?bHVEVUlCL0E2ZTA3R21yeU1BbmozY0dvdmk0amxWejhjYWZHUkhyQmd1S09v?=
 =?utf-8?B?VUtwWmhaVWFEek13K0lndTdOZ1VTR3JHN2l5aXNFVVJZR3RPbXgvajJsTk8y?=
 =?utf-8?B?TElPcjlEWnoxbWJ2dTYycDJWaFA2eEpLbWZqNlB1QkEvQVJyaEE2SVRseU1k?=
 =?utf-8?B?eXpvTllURFZMdzQ1T1p5cG80dWFMb0VpREtadGdlWE1OSDhSY1JUbjEwbU5X?=
 =?utf-8?B?SXV1ei92anpCZE50cVRhTC8ycDBucjRIajFLRjZlalRibTc2T2JyN0FWMmRq?=
 =?utf-8?Q?brJA=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 15:42:04.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c129a50-9252-402c-8648-08de0037e7d1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F96.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3166
X-Authority-Analysis: v=2.4 cv=L80QguT8 c=1 sm=1 tr=0 ts=68dbfa50 cx=c_pps
 a=g9/3GMKIs+LCGVgKrk4MiA==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=8b9GpE9nAAAA:8
 a=iO3Jg8KQ5AR-k_nGVqQA:9 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-ORIG-GUID: 7T_78jihlQ5WMFfed13y0Qzzu8dNJS5u
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwMSBTYWx0ZWRfXzkX+OkHfNj4G
 EmJwSM+FgYODdvD2NF+AYX73MWDa42ofVFIePSNjn1ac93KbLClvMqhYZDS1F3YZjF4N8De38nP
 +gK8dFHIW1PZQ1sbllcmigSDJmbngG5mRb0Ubw66+aSaYN5lW/NJb423nm6x5RrYZYCwsJKs/dY
 jrBdMes6jwyuP4bMWmUXKuRQhZHdC4to0ByNCQJ+frGa1EMK3CbaNkgabaNviUfMI/dOCBZQluw
 VELLHJs7lorWUd0lT69/FkeDJQXL7VYbsgDnmXKzqSDGkPcTHFnzFogmptU669SN81RjvgVPNV+
 SGS/nFd/qYazEm47AWDsogYrGitn9ZseJ4Ee4b+QXwWFtnCSGly+6fHjPVIo7xvLfIOEk3fJdCv
 WzvQRbA4UXG0YEa7JjYg2pAelwvlOg==
X-Proofpoint-GUID: 7T_78jihlQ5WMFfed13y0Qzzu8dNJS5u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_03,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0
 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2509150000 definitions=main-2509270001
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



On 9/30/25 10:16, Kory Maincent wrote:
> On Tue, 30 Sep 2025 09:45:08 +0200
> Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
> 
>> On 9/29/25 17:09, Kory Maincent wrote:
>>> On Thu, 18 Sep 2025 16:16:35 +0200
>>> Patrice CHOTARD <patrice.chotard@foss.st.com> wrote:
>>>   
>>>> On 9/17/25 16:17, Kory Maincent wrote:  
>>  [...]  
>>>   
>>>> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>  
>>>
>>> Hello,
>>>
>>> Any news from the maintainers? Is there a reason for not being merge?
>>>
>>> Regards,  
>>
>> Hi Kory
>>
>> I expect to send a pull request before end of this week for master branch
>> including your patch.
> 
> Oh ok. Thanks for this update.
> 
> Regards,


Applied to u-boot-stm32/master

Thanks
Patrice
