Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B6ECE8D52
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 16:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DD2884248;
	Fri, 14 Nov 2025 17:45:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="CzLGov5L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1CB384248; Fri, 14 Nov 2025 17:45:50 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E83DB841E7
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 17:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3413684226=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AEGgk2H2746508; Fri, 14 Nov 2025 17:45:48 +0100
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4adr7j3tuy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 14 Nov 2025 17:45:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgiTN2spzw+hlHJ41zO2gyRQjXkAadBXCyfYA2T8TmTo6xKbcF2hqXVbqhJTLNZN7J7yZmS11FuRrbGSc4jJpKsTX3IOWPt/6zbbrkFgVQZUld6xVItPbneRxcPHXApc9+qUAlFO/oKgC/G5I3Y1v6YFG0b7JCd9TQSEuRBoFKwSYyzbvHg5ynR0h4XWFi/Q0HoJzG1atIeT4zVgMWtT6/AfxlcT13COvhwyPkeSMNn0HDQPW6F+vLILD7QwloaSLUpiw8llxE/203KcVoFoOIrfCtbrxIxDsK06Wel7fmZapnXnS7/Gy5Uu5NzeBC1/ybBjGcVyHI8tHcCd/QLwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzZwcnOKnANJa+SfWR+FOWuXfBpAiZMf6ZzdIx5iRDs=;
 b=O6N/JXhtEVpfWfrTVTzMB3VzGsAygxsUv2udkMO3DkBp+/x9PJmSPGB66XQnu5zb+jGPOuSfv1R61DW3CPP7YpJ/uNIsR74wHYbusMdMAwTAZMJZR+x5sWuOaSaCSE441Ki9qLHxvm6mF9mTjJQliWaUkBVuVS6JU7aUGv7LWbG6xUQzdy65abkiyubNu7AbeiUaKWGghkW4OjlJwgx9GXbftE1wZZfHTEk2gEiRPfQP8j/0uZhohKaS+wyZI63VS5m0NCfuvxVRcE9AuSe/p92N0aLo2zvcR5GkEn1fnPQ3XKuGLSjiP1UYO/FoycFJTOf0S+Pl5DnXssNEdzKIfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzZwcnOKnANJa+SfWR+FOWuXfBpAiZMf6ZzdIx5iRDs=;
 b=CzLGov5L7QIXfy6Zc9DpyLU7xZFsHb2C0ZMGVDlB8j/oHKgL1JplQCvc1TzGqgoR0UuBdakw1w0mugXXhzJAjFX9Q1klRzLck1D2s50Lpynil9HyrKF4HPJvCbxUnhd4YdUByX0R+W39dwBkNlMhoAfxVZzl1zdGsdsUGHai0l9x82ESfPH2Ow+QsgqLeKtzaDzXd/o3HzZmbQzZDD5RzeotlLgENCdYGbXVHzt6Rh87xYuWswc/tvwagr91ffVnginJJdSlT40RP+NXmxP8gD8I++fLQfi9s2m7A8cVi1M75ZMgrdflLx0eEFi3kknD6V2D450K5sq7XOf8KQ872g==
Received: from DU2PR04CA0310.eurprd04.prod.outlook.com (2603:10a6:10:2b5::15)
 by DB9PR10MB5811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:392::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 16:45:43 +0000
Received: from DB1PEPF00050A01.eurprd03.prod.outlook.com
 (2603:10a6:10:2b5:cafe::1a) by DU2PR04CA0310.outlook.office365.com
 (2603:10a6:10:2b5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Fri,
 14 Nov 2025 16:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF00050A01.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Fri, 14 Nov 2025 16:45:42 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:52 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 14 Nov
 2025 17:45:41 +0100
Message-ID: <684c2342-b72e-4364-b327-3ddaa72e2643@foss.st.com>
Date: Fri, 14 Nov 2025 17:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] stm32mp: Add stm32mp23 support for syscon driver
To: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, <u-boot@lists.denx.de>
CC: U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>, Tom Rini
 <trini@konsulko.com>
References: <20251017121852.109561-1-patrice.chotard@foss.st.com>
 <20251017121852.109561-6-patrice.chotard@foss.st.com>
 <993e5192-5d7a-4dab-ab90-c73ba5b32b4c@foss.st.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <993e5192-5d7a-4dab-ab90-c73ba5b32b4c@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF00050A01:EE_|DB9PR10MB5811:EE_
X-MS-Office365-Filtering-Correlation-Id: 79044e2c-bf91-4c29-b21c-08de239d406b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vms5a2NTeEl3L3RIazJ4WFVHTmR0dnJsN0NBb3BQSkcrS1NyTmZpZng2K1ZR?=
 =?utf-8?B?d1BBQ3dMdFZkUmVkVzJOSkhjUnBhN3BVSW5YMndrQXFGYlBYRFlsd3FYa1d5?=
 =?utf-8?B?ZzNLcTQrMmZ0SGd0N2crNUhNa3RHR3NvaGZWQnJyaGsxSTBsbE9oaGlhbTJQ?=
 =?utf-8?B?ZUNna1d5bDgzazVtNzZvakJCYzF2ZjY1N2ZrWW96aENmL0pFd2ZqRE1UNUZO?=
 =?utf-8?B?VlBhODdNbXhLdDFSTXU0TnFjNWhyVDFFSEdRWDY1YjZnakNsTVR3VUFYQUUw?=
 =?utf-8?B?RnVjR0JoeWY0MEpzZ0I1amRSVlVCR2VLbVZKbFI4QmQ0dkJieDZPTC9CVDVE?=
 =?utf-8?B?UC9tYTlOVUNudnpoM1RYdE51aDdQSUlobTZtNmswSFNoS2hJZkoxYkt4dXpy?=
 =?utf-8?B?bGdhNTYwZTRPODk3eG5uRlAxSE5WZjdOMEVWZWlLdUw4cS8ra2RzRU91SWYv?=
 =?utf-8?B?QzBLV1JKd0dScDhtVmRVdjU0STQzcktNeG1ueWZqZVdHQ3VjVllMSHpDbmJu?=
 =?utf-8?B?Y3VHalVvMnMwcFlCZXBqZ3FLRUVhUU1zbUp4cFpaUlRzRWpXVDNwZVkyZVk1?=
 =?utf-8?B?Y1VieVdUL054ZzkvM01mRlJYU3o2Tll0WTUyQmhEYytpOGM1aldrd1gxT3BN?=
 =?utf-8?B?Z0VUV1RYbE5GNVNrdG82aFF4Qk1tV1RjeHN4Z2NIbnVLdXM2WENKWEVsQ2Nz?=
 =?utf-8?B?dEJLWllHQ2ozQmlTYmJKc0ZnelBJV0laTjJWelA3elUxeGFVV28yZXVpRUJG?=
 =?utf-8?B?QlJZNWd1Snd2bkRlSGtERG5tM3ZLN2EyaWZReEppRUtmakFWUGZlRFhHNlVp?=
 =?utf-8?B?cCtxdklMZFcwUWRjc2VaVWZ6WFRSVHdrRU9yeXZ6RlpDSk45L3JPMmlhdDNx?=
 =?utf-8?B?VkhaWlZwOE1zNjJoa2Z5RlJjemZ5d29Qd29qTFY2c2w1eHV5ZFdaT3AzR3Ay?=
 =?utf-8?B?dHVKKzRSeUFnWkFreHRscEtwdkR4d3ZnSXdOYk1UV2ptcTJTaGI0V0o3eGxH?=
 =?utf-8?B?S2ZrQVFjM3dlR1dRdjdOdCttaHRJYjNvTFM1Ti9ZTlkrMkFoU3dLdGpDUDhI?=
 =?utf-8?B?NnQwMUVZOGR4eFJtRVE2SlpkS2h0ckFTUWNGbnlOd21UbXQvMUd2ckZWUEVk?=
 =?utf-8?B?RVllcUJsZDlhVHo5Ync4NmcraFRJNGFOWSsrbFB0MmFDTUJ4a1U5U1BWRzFy?=
 =?utf-8?B?ZlNiUkdpRmZMRjdEMlBTV080VkUrdlNKbWpKTy9DZ3ErMVF6VCtoeW5WczFL?=
 =?utf-8?B?WmswWUx5RC8xYmFxell3RkJTK2pIS2RJSXEyMUt4akFSQTRnSDFuTDcrYWM4?=
 =?utf-8?B?eVBiOVNOVzVHdEVSbWs4dUZ4d0VsY1hoZElVdTBkMXJzNEFqdFNVMWdKUGNF?=
 =?utf-8?B?SzFtV3c4ZnpDczk2YnZMSTZLbFNQK1Rab2RBK200SVE2anlmRm1odUhzNHRv?=
 =?utf-8?B?YXFxWit5Y2Jwem5ZeE8yK0tPNGF1RzdNTGRnMEFRdnNnU2o3THFWUDJ0QWFq?=
 =?utf-8?B?VDNEaVZZNU5IeFhRODl2ZER3NDNDOC9nbCtkbTZjUm84R3l1b3VEbzY0U1F2?=
 =?utf-8?B?dFNwNEZEQndSMmtnT1hydS9QWTN5MlM3UmtaSnlEMTZHeGY5c2xkYk5mU1hO?=
 =?utf-8?B?UlFzWElhcm1oS3krbzNrN0tEbjl5TzhXM1UrM2VMWlhtTWMxMVdFY0ZVQXZK?=
 =?utf-8?B?WGhxYVZvL3hERS9RbVpvdFJlY1NKdkZEZWFlVjZ6azhiMll1MjU0TkdJQmd5?=
 =?utf-8?B?NjhVQ1hzd3NQa3RYS01QUFJiU2RBS3NYMm1lOHAvUFJ5VlhpVVpNZ0U3N0M2?=
 =?utf-8?B?UDdLc21IamRMZWZZWWdxelRuK3I4S01mUUxrZkhIOFFHd253SDR4OTdnN1hn?=
 =?utf-8?B?ZldHdTFvQnBLbjVsam1wUHZXTlRmbzdsSzlVdlI2aHRkYzBqakd6b0xPOEk1?=
 =?utf-8?B?L2lCTjhpVEJyMG5tZHVEMVZWRXBvY0hLN0V1MXJXZFhZdUJvN2Z2VEtEUjNx?=
 =?utf-8?B?UHJIeFlweUlneTRWdUVwMldEWG9IS0lObHRmZ0dQbHo0azh6TWJ5NThkMzNa?=
 =?utf-8?B?QWlrZktKSXlwUWlRVHFGRjk4M25GYWViWHNiTFNCNmp2VzUvT2hHcE4rNmpF?=
 =?utf-8?Q?NAfU=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:45:42.9633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79044e2c-bf91-4c29-b21c-08de239d406b
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF00050A01.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5811
X-Proofpoint-ORIG-GUID: OZRBZ-DTeh7z4EBLJ3hl7WhYRMhK8TIv
X-Authority-Analysis: v=2.4 cv=DPqCIiNb c=1 sm=1 tr=0 ts=69175cbc cx=c_pps
 a=L+++h01d6Df5J4tORmQWUA==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=FJVfW-5ctJKdVZPrdgMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE0MDEzNCBTYWx0ZWRfX+I5XxNj5Qipp
 Ful6t+g9obNi18Enx2bXKCMgqATNTRUt/00gErE1MuV5gzJeYc91esE9BrHN8QsXG1/7WIdJ72Q
 /CE9UtFomOe7t06HGfnbtDyP/9Go1z+ns3ophdkgRmR1rPQcgK2xj8hXBw7i2QG3T97u9PP3iVS
 XYPU2V8OM+yM5N5ooDbBk1lrLKml0eclEOlSBsopPPgqsUtgDFo5UWncYX7R+71aY8h+v92qTuW
 zlnfTz9om28jOGw9fBN72fGcyXj6qhxWDboWweLcptIUoCUnfS7xE1sCa/pEDWB/x6yk3zJq25Q
 WKb7HoUfti38W9/AHK2uXVrJUxj+NQY2yoei9am5t20kg9Q4nHEd7FOkzYW3ugc5UALEzAiWlXG
 u8Tn9WtOKcCgmjPMt6crwl1+be6OEg==
X-Proofpoint-GUID: OZRBZ-DTeh7z4EBLJ3hl7WhYRMhK8TIv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-14_05,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015
 malwarescore=0 phishscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511140134
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



On 11/13/25 18:45, Patrick DELAUNAY wrote:
> Hi,
> 
> On 10/17/25 14:18, Patrice Chotard wrote:
>> Add "st,stm32mp23-syscfg" compatible.
>>
>> Fixes: fdd30ee308a2 ("ARM: stm32mp: Add STM32MP23 support")
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>
>> ---
>>
>>   arch/arm/mach-stm32mp/syscon.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/mach-stm32mp/syscon.c b/arch/arm/mach-stm32mp/syscon.c
>> index 8bcbd979340..b00897e87ec 100644
>> --- a/arch/arm/mach-stm32mp/syscon.c
>> +++ b/arch/arm/mach-stm32mp/syscon.c
>> @@ -10,6 +10,7 @@
>>     static const struct udevice_id stm32mp_syscon_ids[] = {
>>       { .compatible = "st,stm32mp157-syscfg", .data = STM32MP_SYSCON_SYSCFG },
>> +    { .compatible = "st,stm32mp23-syscfg", .data = STM32MP_SYSCON_SYSCFG},
>>       { .compatible = "st,stm32mp25-syscfg", .data = STM32MP_SYSCON_SYSCFG},
>>       { }
>>   };
> 
> 
> 
> Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
> 
> Thanks
> Patrick
> 
Applied to u-boot-stm32/master

Thanks
Patrice
