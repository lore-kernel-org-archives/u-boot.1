Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9523CE8D6B
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 06:57:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24725835FD;
	Mon, 17 Nov 2025 07:57:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="N7WQ27e+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAC5D83ABF; Mon, 17 Nov 2025 07:57:21 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01C3B808AF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 07:57:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3416482c8e=patrice.chotard@foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AH6hW3a603373; Mon, 17 Nov 2025 07:57:15 +0100
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4aejghn7w1-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 17 Nov 2025 07:57:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b8aiDs1840HZWUijzjoXF3oCu5HjnA2IVeUzfHoM7eG/Z9EplshqT5D8w0pKnVzYJLqew6fC0sj7d1ZLaU6WGMfEQC8BP3VfFuCwEDl9FLEmwLU7R3SJ4D7pwn0ObwDz8weVwCQ0sWvQ5QuUJ5CMW1hnRRM9KaoUjPoaBsas+/58/GQpwb9K26tNsBm09fhXZGmu/9waAwDl/8PhEnPfuYXlrh953aRvt0ckD5eGky6K5rqplbCgW6GBC8UOBrWlPLbbkPfYP1WC7BDobtfCbpUhj+upKowiZeMtOSs8gtiEL9so5IYnzrvZxWfcmnKFox27OgZhed24REkRvd6kYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rZgwWC7VTAOrFI0f7y806vJBxlz1sHJ0fOcqiRhFxg=;
 b=q2v38QecKFKPer61GZ/xqXGKm1P58UxYU+4NvRBbWslhc5GKHEAA894s3LSB5i06JggAcwccIIzIy3RG3MPBbXUy/1forO5a7t/h2TrrNkTOhPLrxGn5iMGss7/qrKEGabnHZjANrNz4LZ26i7VDxn5Hp+h4HaM5NfwLPg4Xvadg5F4xKv/82e+Y+0uFL/nWixZ842zM7IsORQPGT/hMxPuhAZf3K9bCsaqQ4euAAUOgbDOBys/VMZDbp/ZJSLByS+cO8geIZVz0t8kNWCDMhhL4qaXHiWyKA4IkwbXd82ALSls1aDzwvRoPKe9gUTP/EjNPqRiY9ZyGp+5pJaxKcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rZgwWC7VTAOrFI0f7y806vJBxlz1sHJ0fOcqiRhFxg=;
 b=N7WQ27e+6r6Aimiklx2pYzw25F5Z8j0Rwz20M011dbJ2+CcP8b8zZTHprR8n+sA4hOYfMDr3jdgXZdCX8KFBmVn4STmsfwda+RyvabzirGNCLFH8myux7ouVD6yrJ9CA0hur1RDcmXkOP14vrKhwg2Om3Hw7IFQBGoPdBHv/dGQFADCD4Hjcf8tRn6+XGRkkw+rTKGQ0ZSJABI7GvMtHIUtMUxzt8drIrsV5x7ZHPaJIfK9pYpNqsYiLLuotFE01ymBjkpzo4fQuiZdvg3Uv1SjMvlnKkY4WjeXWWEu1QEtggzuhJb51+jU1LadRy5I3eFklCnRFEyidPsIWAToLnA==
Received: from DB8PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:10:110::29)
 by DU0PR10MB6365.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:40f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 06:57:12 +0000
Received: from DU2PEPF0001E9C3.eurprd03.prod.outlook.com
 (2603:10a6:10:110:cafe::aa) by DB8PR04CA0019.outlook.office365.com
 (2603:10a6:10:110::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 06:56:46 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF0001E9C3.mail.protection.outlook.com (10.167.8.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 06:57:11 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 07:57:24 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 17 Nov
 2025 07:57:10 +0100
Message-ID: <39ec397a-dbf7-4b04-8d58-5d87ddcca45d@foss.st.com>
Date: Mon, 17 Nov 2025 07:57:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: stm32: Fix STM32MP15xx DHSOM boot breakage due
 to ETZPC
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.denx.de>
CC: Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini
 <trini@konsulko.com>, <u-boot@dh-electronics.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>
References: <20251023214614.181165-1-marek.vasut@mailbox.org>
 <7a078242-2d34-4100-a61b-5418294954ad@foss.st.com>
Content-Language: en-US
In-Reply-To: <7a078242-2d34-4100-a61b-5418294954ad@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C3:EE_|DU0PR10MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d9bd40-8f0b-4959-e71a-08de25a6888d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0dkOW9GOUVVMm1ScVFySXY5b1ZzZUhXYXkrT0R3RklMYXBZUDUyVlVuekwv?=
 =?utf-8?B?dzVBRDg0WEJNWkVROWtrbG9Vc2pIeFlVTjNmV2plQ2dRdXNDYVhkR09keEdj?=
 =?utf-8?B?ZzVIVjRlcU81QngwQStYeDIrNzJQMTFwZVpTczdpbWYvMGRYblVoUTNBVG13?=
 =?utf-8?B?WHBHdldNaTByOTh5aSt1M2xJOVNleFdQQW8zODdFUzlHbC9YK1RxNmtnR2FD?=
 =?utf-8?B?cHF0d0pJS1VoQ3RQbUxUNDhQeEszbXVQQTRSWUV6RU9JK0s0cHZTN1RnelV4?=
 =?utf-8?B?YkNxSHNZMXdDRS9JNDJFSTUydlVMNjJlTmZ0b2xhdXdxVjJnUlQvNEE1TWwy?=
 =?utf-8?B?MnhGVnMwSlZSQjEyNkZuSWdGRmFSb2p1UG9rL0VLeEpzekcyUGFvTkdhMmdi?=
 =?utf-8?B?ZGlyYTBaYk1PdTNUNW42aEY1RTZpRnRoQlgzZ291MDNpUjk2VGdRM0k5cG1w?=
 =?utf-8?B?cEM3anFOWnd3QnFxWjlLUW83c0c5c2JIZERPaG5uYURMYTRyTE9kTFdISUdX?=
 =?utf-8?B?eEJKV3M5ZkFUOXJ0K1lZaU04cGNZR3FBMXgxRVdwMTB2WVhMZXJKMndLYmVo?=
 =?utf-8?B?ZmlEU2Z4VXg4ejBFaFFMYnlkUDlQVm51SkNTSnQ1NlZaMVh0N3RDb3pvRnk5?=
 =?utf-8?B?TU1TczEzQk9KOTdRcWxVdVczMFZxYjNZanFxZ1pveE9Kb1VidGVJMXJrcHg5?=
 =?utf-8?B?UUp6RlZ0TURXdWlyTC9xTFBKQnRxZW9HQVFubVRoNEMxbEZ0V2prNW16QmV5?=
 =?utf-8?B?ZDNkWWZNYmkzUVl0cmw4ekt5amNVZ0lFZDJGR2lnU2VTZ1BVMFNwdm5ZU1dB?=
 =?utf-8?B?TFlScHR2eTlEQ1hmYTNjL01pZnQ5SjJ6K0FReWh1b21Od25mVkFqamorMHpp?=
 =?utf-8?B?SnNzTlRTcU1PdmpraXVsNDNDaXNRQVlab1FYREhZYkh0bmtmemtjaDlGeUlv?=
 =?utf-8?B?bTJrQXUrb3BrQkRmTVlVSFpxMG9yL2xNeThEZzhZMXFtNC9ONjFYTFVlQU0v?=
 =?utf-8?B?bkN6NXJ3OFBPeEJXZVkxUkFKZDlocEhWbUJWL3VJKy8xUGtQbzlJQmNaeEJu?=
 =?utf-8?B?NlhxemhRMjZKMUl4d0R0RlRYc04zZ1hDbW9nM2dwVS9tNTBTaWsxNk9VdjhV?=
 =?utf-8?B?YmlqV2V1SE44NGFob29zbGNrZER6TU1wdGxYWE8zejBSc1VWcnB2L0lBZGN4?=
 =?utf-8?B?c2NFUVFIeTJyWTFYMStJZUZhUW5MLzlRWVdHUDErS2R0Q3psaERFUlp3ZmpS?=
 =?utf-8?B?K0tDa1Z0bnhncVg1MlR1a2hyKzRVZHdNK1ZQNk9BZUZ6dnlBbnhtbzB6VzBU?=
 =?utf-8?B?NTJNdWRqZk5ha2hGUHJ6RFoxLzY2OEZEU2Q1bElwZjlOdWlrdEF4UVZzZGJn?=
 =?utf-8?B?Q1FKUFZxWDA2dWUvdmdYWHdCd3p1TVRpTGxCZlRRZFJVd2M1M0FUb1gxaUdy?=
 =?utf-8?B?SkpVS25Jbm1CbnVRalNqMnlvVXpQYXhNeW5DRmUrbVdOK1Y5dDdqR1RVU21s?=
 =?utf-8?B?dzZEbkIxeWZiY2I1VGRKazByYzQwRDJXdzBVTWF6enYvbUFxU2ZERDhNZzNa?=
 =?utf-8?B?c0x1Ky8xLzVFTmxQUnZiR1lIOXpldVFZeHZNQ2dqTEZSQnZnWEpwY0JTYzg0?=
 =?utf-8?B?SW9UVkdpUkU1Y3pSb1NTR2dybzhxMGdkdGV6RFdTblQ3VnE5OVovMFdjQW9F?=
 =?utf-8?B?eGpIVWxJc1NsQkJDWVkvVFVqeUlJQiszUUtURkJ3a3dJeEE1Y3dTNEc0Nk1R?=
 =?utf-8?B?V0VkUGw5Zm1Tbk1HUHZBTmVZT3pUcXFrWndqS2szUitCNVFheWhGSDNvUk1r?=
 =?utf-8?B?Z1dGWVpFN0ovZ1N6SWdpaklhN2k1Q1ZrNE45b0xkc1FVbVU3Q3RkZU15akd2?=
 =?utf-8?B?cnBEOWFiMUNvQU1ISkZYK3paY3gxSkV4RUdha1Zxc3VGdkNHakRKUUVZV2Zy?=
 =?utf-8?B?MGVGQmd5SktJVVdJbWlOWFozY2R2NHRZZDZnYVpwSEtYVnBTdHYwRDV5TnZV?=
 =?utf-8?B?WHA1a3U5THdrK3Rocm5oa1NmY2RYQlhkRmtHbmIyamx3V01HaDkzSmRxMU4v?=
 =?utf-8?B?cjFURUFWNUNibC91dFlGYS9nV2pyVFN1WUZFbXBTeUJIalhDc2NHazFqME80?=
 =?utf-8?Q?oFXo=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 06:57:11.7859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d9bd40-8f0b-4959-e71a-08de25a6888d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF0001E9C3.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6365
X-Authority-Analysis: v=2.4 cv=G+cR0tk5 c=1 sm=1 tr=0 ts=691ac74b cx=c_pps
 a=GTbBXONw3Gu2zOAaXE4BkQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=b3CbU_ItAAAA:8 a=8b9GpE9nAAAA:8 a=k-42gJp3AAAA:8
 a=zk4-lHRcAAAA:8 a=phlkwaE_AAAA:8 a=4w7EsD9R8gIcnaO5_zQA:9 a=QEXdDO2ut3YA:10
 a=Rv2g8BkzVjQTVhhssdqe:22 a=T3LWEMljR5ZiDmsYVIUa:22 a=uCSXFHLys93vLW5PjgO_:22
 a=7cv85riZL9-k45RWW8P6:22 a=uKTQOUHymn4LaG7oTSIC:22 a=HhbK4dLum7pmb74im6QT:22
 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: lGRFiAfB6Mpc5hJVW2sQvLUTUTQXENkF
X-Proofpoint-ORIG-GUID: lGRFiAfB6Mpc5hJVW2sQvLUTUTQXENkF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE3MDA1NyBTYWx0ZWRfX9Zm0AzT4yVS3
 0z4ihaunaegQghN5ePOToyHm1vczRF9s0RTQ1g4rHZq4Vpt0RllG4w66P+ezKCuRiqJCvv+kQ+f
 Q4aWXg4hofugIMKZsBcQG/QQuT8LOr/kcZUbWk4T6WperEppvx9JLAafx51SXkYDLXG3Xkq373C
 XzFRAKQYu2p7TbssQAkOLWSq7fNrAl9l0KT/pnhkh+L+7ZCu3dGVXhX2QurlzTEnabfgBWlAD9z
 sTyMBj+dpcNaIrNZTfwE3oXfdFrqwg/D7+sXZloME0qRPx4ueVaXdUHvCMv5CPSVP/TSCBZNQRY
 dxS5fGm6oOgkJgxQZcjeoekyJmVMpd+8Xs020OvqDVShnhSoKh/wPw4Ssqkq/YGm3wDgMf+xJtl
 f25H5MEBDN+qYr4XNbfTO8Ch+kF7kA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_02,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511170057
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



On 10/27/25 17:37, Patrice CHOTARD wrote:
> 
> 
> On 10/23/25 23:46, Marek Vasut wrote:
>> Switch etzpc bus to simple-bus to prevent breakage on non-TFA systems.
>> This fixes boot of every STM32MP15xx DHSOM device.
>>
>> Fixes: ad3cdc677dda ("ARM: stm32mp: add ETZPC system bus driver for STM32MP1")
>> Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
>> ---
>> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
>> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> Cc: Tom Rini <trini@konsulko.com>
>> Cc: u-boot@dh-electronics.com
>> Cc: u-boot@lists.denx.de
>> Cc: uboot-stm32@st-md-mailman.stormreply.com
>> ---
>>  arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi b/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
>> index 386c605c07f..ed2629f379a 100644
>> --- a/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
>> +++ b/arch/arm/dts/stm32mp15xx-dhsom-u-boot.dtsi
>> @@ -51,3 +51,7 @@
>>  		};
>>  	};
>>  };
>> +
>> +&etzpc {
>> +	compatible = "simple-bus";
>> +};
> 
> 
> Hi 
> 
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Thanks
> Patrice
Applied to u-boot-stm32/master

Thanks
Patrice
