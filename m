Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79923CE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16BFF84272;
	Fri, 14 Nov 2025 17:49:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Pnk0UKKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C12DD84285; Fri, 14 Nov 2025 17:49:31 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC5BB84262
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGgd4x3043344; Fri, 14 Nov 2025 17:49:24 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013023.outbound.protection.outlook.com [52.101.72.23])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7kktyk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:49:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zPBSrFaoQrEcyIFZskuScpHJxTCeYejBNrZ2PuT37DWElXsJydqZmY6A1MR3IeXs2cBEKefHwQGYCsWhIQZsaURTfFcDNbM9xcDL6GIBvDVMt+bJBpNkfOrs10bhYqu1PaFrvg2a0O2SmHqmcYMryXPBearhHr5j18Wqi7Lq7Tf5j0dCc1y7nCiqF5nnrjU2FxyoYKrdwvEgknPEOxx//S5clh4t+9CTZqHVond9IwNe6TNJrIvDqXvyDVuoB0dAIeqtd2dvll7RGoFkqiSYoTnd5atk7kHkoY5LdSr6/Ddg8CUZKb7aNXbKN+ruohFQEqm0ntGslz9VlXe9HOB5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZj9iZaedmgLwIhHa82GtWsJ4r1JMZIeXajsGTokplc=;
 b=iA+QnF+xSsMe41BxmGatnnS9ntCCRMgqaUcJaGMESa1aCRn5Paz8eW615D1hy5bKM4OIK3Jd/BsypJNCI7ywjsl/KUFIDudGEN63Elo3ngXJNEok55crMsNIbHWUlAh62NAC9HqrP1qyKZSIwShcXL6yIKZYDuw8CV1wlYORqKsEMBZh68CLVzgUSf2S8PdO5s9sqB+jzLwL9BB1lv2QShe1Y6a5w4LHU503yzbbZGdANiyQUM52hUto+KfpEJVhJQo/erKNOs+GH9UxBzN807ibkxUPyFDNzPVOARCJtAgd+jW4g6I2GnoPsgglfMwpaJjohGLobFpre2v7MBZPKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZj9iZaedmgLwIhHa82GtWsJ4r1JMZIeXajsGTokplc=;
 b=Pnk0UKKEah2hhtlESWGN4jwBnYAJ0wBmAdoIuoasEI6Nvv3fyhQsJYiqVNCeXGKEfswYT6NZ7qkZIWlFEcq5J+LflM3DPKPpT3fe8gF9QWhJu0VQjjfQtelwkj4bww3SltCzFIP7k0mLShtLu4MNQk5wyD5ogVFYiKUlxAr4cGRVbF56TncsbuhGdY4et4uog9sG6py/oIdrljzsF3K0/CH1GcT5BSRdLRmNbUAF2IGlw+hdxFEGwDzBPIRtwXEo/GIrfbpl3n0LPfRSfGaW0H72qqTb3do3OCPqvXlFkKW9lLoA2OVXYqppAOhw4t/aVAmIwdotV/Pr2ff5gRP+cg==
Received: from DUZPR01CA0350.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::22) by PAWPR10MB7367.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:2ee::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 16:49:19 +0000
Received: from DB3PEPF00008860.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::7a) by DUZPR01CA0350.outlook.office365.com
 (2603:10a6:10:4b8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.18 via Frontend Transport; Fri,
 14 Nov 2025 16:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB3PEPF00008860.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:49:19 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:49:30 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:49:17 +0100
Message-ID: <29f8c9c9-1149-4974-a54d-c9ffc30f0e32@foss.st.com>
Date: Fri, 14 Nov 2025 17:49:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] video: stm32: ltdc: properly search the first
 available panel
To: Yannick FERTRE <yannick.fertre@foss.st.com>, Raphael Gallais-Pou
 <raphael.gallais-pou@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>,
 Dillon Min <dillon.minfei@gmail.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-5-b42847884974@foss.st.com>
 <ac267663-0663-4ab4-8456-fb6256d001aa@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <ac267663-0663-4ab4-8456-fb6256d001aa@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB3PEPF00008860:EE_|PAWPR10MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: ff332a45-3e96-4d59-d657-08de239dc17a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmNIeVU3WmZ3bm9xS1AyUlBNNEcvZkJpaTBPVUNhaXZWVzFSOVBXSXM5bExV?=
 =?utf-8?B?eldFaDlOS24wTU14a1p0aUxzdHZNM2lJdE9YUnQyNGJmVVRKU25WQXUxYkZQ?=
 =?utf-8?B?bHNJaG1VaTFhSVJSS0pEVzUrZXh1MDhCTmViTE9LTmRBcEovUnJNVGl1Vnkx?=
 =?utf-8?B?TlNLS0RtTW9yYy9saUlvNVk4ek8xNkR4UW5MMDFPc2JWSVU2N05sSDVNNyts?=
 =?utf-8?B?OVNLVDhBMTh6THdLLytnT0FPZ0ZmRkpuRFRzamRNTFdiVXczNTFFZi9TNElj?=
 =?utf-8?B?bmhJSDJ6ZkIxMWM0RlJrb3U2ZjBnSUtTRCtYNnI3Q2FMMXZoZ0NoRlVvSVhT?=
 =?utf-8?B?T0VqZTRZV1ZPajVPb240K0lsd2hGRlZvc3o4UEF4aTZGRmZFb0hqVitOVW5w?=
 =?utf-8?B?akk0Q3FOREN0QmF1alVpN1ZSRThGREJTNVJwemlxcDBENkxKWnB3Y0NPcVd4?=
 =?utf-8?B?c0RwTWluNzhsQVZWYzlpSlVCVUQwZm0wQ1B3T082cXVTeDFUYkQ2UWljTTVp?=
 =?utf-8?B?NkJJd3hON2RtMTczWDFnb2ZVSWNVblorNS9IMUV1QzNmWWZvTHd4dzN3Z1BQ?=
 =?utf-8?B?cFVJeW5VK1Y1NjUvUjVhK3V0QXJPQ3RFT2UzbjM5dFlSdWh6N28xZnh6MG9s?=
 =?utf-8?B?Y1pMUkpoeXFxdkgzRCtPeFRXbVlqZndYMmMyMEl0SzBwOXRraDVVZ3hQcC9R?=
 =?utf-8?B?eG5VWTVjYXNOUDlYaVZHV0Q2SXhTcStRbVh4SHordmNFZmZWOVl0K2N5VFFk?=
 =?utf-8?B?ZGVsWWlHclQ1a0tneUNySGhpY05TRzZGNzRqTmtURkxpc3g0aS95Q25vaWJ4?=
 =?utf-8?B?KzdiRkFIZ0JSYkJ3Z1pBUi9WRjFIUC83ZVlERE1Sd3h1ZTdvOGpzbVk1aTdD?=
 =?utf-8?B?NlFYcHRTajY5WWhEUkVaUWZGdzUrb2t4WGJ2TU9DSTUrZVJCTlA2L084cUYz?=
 =?utf-8?B?ZG9WeE15OStUQ1BPeVdtbDR3dms1WWp1N3RmQ2ZjOXZReGtjRFJvbVNRTlZh?=
 =?utf-8?B?djZpOXNBVlNCSjNWbWdDZ2JsTUxQWTBpWHpQUXQ1djRKRFlMbUZjV2dmV3Br?=
 =?utf-8?B?ZFNFbUpNWXIyVkpqRWZRazF5TzBQSnlsTE1JWWo3TDhuY0RlTjIzK3lNRWRR?=
 =?utf-8?B?c2pYWEM0QW41WUxtT3JhRTBmUlBvalFLNGhOaDJsS3VuL0xTMnBiQWxOa25H?=
 =?utf-8?B?aEFPQTFnQlV4eWZERU5Jc0RlakFuWDNzRmVGbjRwQktUdEJtcnprQUFnNHZv?=
 =?utf-8?B?ZkxqbmhGMUk2eE5KczdiZDVSTDdzYmE1SVBRWVJ4ekR6TzkxdWg5eEVtb2tq?=
 =?utf-8?B?SlZ3WE85UWdKL2VNZTdDZFc2aWd4bldXb3E1Q1VyS1JWdzQvb1hWRkpDd1Bu?=
 =?utf-8?B?M0dRVlpSdFdZNEJYRmFmbjEycGQ0Z3ErSzFvQnQ5NXRlcDlmMllZczU2TXNS?=
 =?utf-8?B?ZWx3UGpIbU84TjhtZEJsa0gwamVYN3RvSnJLbmRqdFBlVklFYUpEbXhsRUhV?=
 =?utf-8?B?Y2p0dElML2FmN05CSWpTQ3pYS0NWVXh6aGhCanpMRzdXNHpaMHVHWFJWVWQr?=
 =?utf-8?B?RThjajdLb2dZWkJzVGo1WitMVGE4Y3dtMjBrbU5Eb0taZ29jaVg0NXhIRkhj?=
 =?utf-8?B?TC9GdUI5dXlDZGJWMEtMc0tjMTZvUzdDbEZwQzNZc09EWWo1UTA4WFBTcUpr?=
 =?utf-8?B?YWFmZk1WTnpVRktQbDV6dC9mWEEzMHhFM0s3VHBrV3RSV3JFS0txV3VpYUg0?=
 =?utf-8?B?VlJrc0F0eWM4ZU1ER3MvdHZvazRTZEhETHJMbTRtY0tGMDFjQjJMOGpaZG9m?=
 =?utf-8?B?TGVGcS92Ylh3ZC9Dczh2N0hacnZkUUZsZFBYaUpzRkhtUDVNNThpV3VyRE1P?=
 =?utf-8?B?RnA0a2w0aFlqenBzRXNuVmZNdndOUExPRi9JNnlOVGFBc28ySGJmK0lucUtz?=
 =?utf-8?B?UGVoaktKaFp1cHJ6R3NKZmJkMlcxYkpUQWxDT3ltQzVsc1NITDJ1VzRiZWdI?=
 =?utf-8?B?RDh5SzJEZXVuZmxkbGlVcXNyV05LcVFIazNSMVkzRVJyUS8xZFRXRkFEUGsr?=
 =?utf-8?B?anpJRWhHTGZsVG9ZMXFzbmlMWDFnbnFRc1RNbzIzNisvcUxNRGdkYitYQW1y?=
 =?utf-8?Q?gDBxjb6GDfE82TJAFXv6TMoT3?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:49:19.4918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff332a45-3e96-4d59-d657-08de239dc17a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF00008860.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7367
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNSBTYWx0ZWRfX+dZkUbM/G4Yz
 ngrbG8NO6KVg5yaHKWurKIuqXPMJ+gKpNBUxE6cFDJubrOK38Az8PGB4lXU/5v7UP87lQWw/iE1
 Eb3nDCph0vi2TLl3guVFygJqFkjGXxwuP4qel9NEYLdrNuTga1PQkaMgHssW/u0K4nDBL4Yy/QS
 46dJpZSH3QDPh+uKlsg5Ci352CfmbcluUEOPJD/x1YpdkzJOjU/WkKbwn/PjzxVZSkCFPrB1Fto
 dCyF1ivn0tpToJbIgUhpoQ+FTdE3i9nciwfANIEYACwRYKpV3UdAOarxBfu1yudb9mF/pvbfzdO
 /eQyuHx0b86PKLdIiS0uzADvDNK8/8dtyCEnT2+2SC9bhBgLyRIz4YnfE251bgZ5JtiZti8hABq
 KBIJjOT+TOGitfrK2n9F174t+zTMRQ==
X-Authority-Analysis: v=2.4 cv=Xsf3+FF9 c=1 sm=1 tr=0 ts=69175d94 cx=c_pps
 a=guev5NpOtKZLIFWBmHTLzw==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=kHEJ6T4nsVNC8KP5Z3wA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: EdkW-IkVVQ33I7D1_JyqTZUqNvyFSNCe
X-Proofpoint-GUID: EdkW-IkVVQ33I7D1_JyqTZUqNvyFSNCe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140135
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



On 10/30/25 08:43, Yannick FERTRE wrote:
> Hi Raphael,
> 
> Thanks for the patch.
> 
> Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>
> 
> Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
>> Initially there was only one DSI bridge with one panel attached to this
>> device. This explained the call to uclass_first_device_err(UCLASS_PANEL,
>> ...) which worked fine at the time.
>>
>> Now that multiple bridges and panels, with different technologies, can
>> be plugged onto the board this way to get the panel device is outdated.
>>
>> The lookup is done is two steps. First we circle through the
>> UCLASS_VIDEO_BRIDGE, and once we get one, we search through its
>> endpoints until we get a UCLASS_PANEL device available.
>>
>> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>> ---
>>   drivers/video/stm32/stm32_ltdc.c | 136 +++++++++++++++++++++++++++++++++++----
>>   1 file changed, 125 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
>> index efe9a00996eca0301d2a2b82074ba9690a967a73..834bfb625d2d34a44bd8edff1c92af6dec344c20 100644
>> --- a/drivers/video/stm32/stm32_ltdc.c
>> +++ b/drivers/video/stm32/stm32_ltdc.c
>> @@ -17,6 +17,7 @@
>>   #include <video_bridge.h>
>>   #include <asm/io.h>
>>   #include <dm/device-internal.h>
>> +#include <dm/uclass-internal.h>
>>   #include <dm/device_compat.h>
>>   #include <linux/bitops.h>
>>   #include <linux/printk.h>
>> @@ -495,6 +496,101 @@ static void stm32_ltdc_set_layer1(struct stm32_ltdc_priv *priv, ulong fb_addr)
>>       setbits_le32(priv->regs + LTDC_L1CR, LXCR_LEN);
>>   }
>>   +static int stm32_ltdc_get_remote_device(struct udevice *dev, ofnode ep_node,
>> +                    enum uclass_id id, struct udevice **remote_dev)
>> +{
>> +    u32 remote_phandle;
>> +    ofnode remote;
>> +    int ret = 0;
>> +
>> +    ret = ofnode_read_u32(ep_node, "remote-endpoint", &remote_phandle);
>> +    if (ret) {
>> +        dev_err(dev, "%s(%s): Could not find remote-endpoint property\n",
>> +            __func__, dev_read_name(dev));
>> +        return ret;
>> +    }
>> +
>> +    remote = ofnode_get_by_phandle(remote_phandle);
>> +    if (!ofnode_valid(remote))
>> +        return -EINVAL;
>> +
>> +    while (ofnode_valid(remote)) {
>> +        remote = ofnode_get_parent(remote);
>> +        if (!ofnode_valid(remote)) {
>> +            dev_dbg(dev, "%s(%s): no uclass_id %d for remote-endpoint\n",
>> +                __func__, dev_read_name(dev), id);
>> +            continue;
>> +        }
>> +
>> +        ret = uclass_find_device_by_ofnode(id, remote, remote_dev);
>> +        if (*remote_dev && !ret) {
>> +            ret = uclass_get_device_by_ofnode(id, remote, remote_dev);
>> +            if (ret)
>> +                dev_dbg(dev, "%s(%s): failed to get remote device %s\n",
>> +                    __func__, dev_read_name(dev), dev_read_name(*remote_dev));
>> +            break;
>> +        }
>> +    };
>> +
>> +    return ret;
>> +}
>> +
>> +static int stm32_ltdc_get_panel(struct udevice *dev, struct udevice **panel)
>> +{
>> +    ofnode ep_node, node, ports;
>> +    int ret = 0;
>> +
>> +    if (!dev)
>> +        return -EINVAL;
>> +
>> +    ports = ofnode_find_subnode(dev_ofnode(dev), "ports");
>> +    if (!ofnode_valid(ports)) {
>> +        dev_err(dev, "Remote bridge subnode\n");
>> +        return ret;
>> +    }
>> +
>> +    for (node = ofnode_first_subnode(ports);
>> +         ofnode_valid(node);
>> +         node = dev_read_next_subnode(node)) {
>> +        ep_node = ofnode_first_subnode(node);
>> +        if (!ofnode_valid(ep_node))
>> +            continue;
>> +
>> +        ret = stm32_ltdc_get_remote_device(dev, ep_node, UCLASS_PANEL, panel);
>> +    }
>> +
>> +    /* Sanity check, we can get out of the loop without having a clean ofnode */
>> +    if (!(*panel))
>> +        ret = -EINVAL;
>> +    else
>> +        if (!ofnode_valid(dev_ofnode(*panel)))
>> +            ret = -EINVAL;
>> +
>> +    return ret;
>> +}
>> +
>> +static int stm32_ltdc_display_init(struct udevice *dev, ofnode *ep_node,
>> +                   struct udevice **panel, struct udevice **bridge)
>> +{
>> +    int ret;
>> +
>> +    if (*panel)
>> +        return -EINVAL;
>> +
>> +    if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
>> +        ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_VIDEO_BRIDGE, bridge);
>> +        if (ret)
>> +            return ret;
>> +
>> +        ret = stm32_ltdc_get_panel(*bridge, panel);
>> +    } else {
>> +        /* no bridge, search a panel from display controller node */
>> +        ret = stm32_ltdc_get_remote_device(dev, *ep_node, UCLASS_PANEL, panel);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   #if IS_ENABLED(CONFIG_TARGET_STM32F469_DISCOVERY)
>>   static int stm32_ltdc_alloc_fb(struct udevice *dev)
>>   {
>> @@ -532,6 +628,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>>       struct display_timing timings;
>>       struct clk pclk, bclk;
>>       struct reset_ctl rst;
>> +    ofnode node, port;
>>       ulong rate;
>>       int ret;
>>   @@ -568,7 +665,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>>       }
>>         priv->hw_version = readl(priv->regs + LTDC_IDR);
>> -    debug("%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
>> +    dev_dbg(dev, "%s: LTDC hardware 0x%x\n", __func__, priv->hw_version);
>>         switch (priv->hw_version) {
>>       case HWVER_10200:
>> @@ -589,13 +686,35 @@ static int stm32_ltdc_probe(struct udevice *dev)
>>           return -ENODEV;
>>       }
>>   -    ret = uclass_first_device_err(UCLASS_PANEL, &panel);
>> -    if (ret) {
>> -        if (ret != -ENODEV)
>> -            dev_err(dev, "panel device error %d\n", ret);
>> -        return ret;
>> +    /*
>> +     * Try all the ports until one working.
>> +     *
>> +     * This is done in two times. First is checks for the
>> +     * UCLASS_VIDEO_BRIDGE available, and then for this bridge
>> +     * it scans for a UCLASS_PANEL.
>> +     */
>> +
>> +    port = dev_read_subnode(dev, "port");
>> +    if (!ofnode_valid(port)) {
>> +        dev_err(dev, "%s(%s): 'port' subnode not found\n",
>> +            __func__, dev_read_name(dev));
>> +        return -EINVAL;
>>       }
>>   +    for (node = ofnode_first_subnode(port);
>> +         ofnode_valid(node);
>> +         node = dev_read_next_subnode(node)) {
>> +        ret = stm32_ltdc_display_init(dev, &node, &panel, &bridge);
>> +        if (ret)
>> +            dev_dbg(dev, "Device failed ret=%d\n", ret);
>> +        else
>> +            break;
>> +    }
>> +
>> +    /* Sanity check */
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = panel_get_display_timing(panel, &timings);
>>       if (ret) {
>>           ret = ofnode_decode_display_timing(dev_ofnode(panel),
>> @@ -624,11 +743,6 @@ static int stm32_ltdc_probe(struct udevice *dev)
>>       reset_deassert(&rst);
>>         if (IS_ENABLED(CONFIG_VIDEO_BRIDGE)) {
>> -        ret = uclass_get_device(UCLASS_VIDEO_BRIDGE, 0, &bridge);
>> -        if (ret)
>> -            dev_dbg(dev,
>> -                "No video bridge, or no backlight on bridge\n");
>> -
>>           if (bridge) {
>>               ret = video_bridge_attach(bridge);
>>               if (ret) {
>>
Applied to u-boot-stm32/master

Thanks
Patrice
