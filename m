Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86795CCF9F8
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 07:44:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 663CB8393C;
	Thu, 30 Oct 2025 08:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="Lo/bpWDp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 610B7838E7; Thu, 30 Oct 2025 08:44:07 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6C7B8392C
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 08:44:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=33980d621d=yannick.fertre@foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 59U7bnBD1112307; Thu, 30 Oct 2025 08:43:56 +0100
Received: from db3pr0202cu003.outbound.protection.outlook.com
 (mail-northeuropeazon11010006.outbound.protection.outlook.com [52.101.84.6])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a3mwa30te-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 30 Oct 2025 08:43:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y4UasafkngWaGUWpTeNWDGFQyFBzleYxWk5VT4T1TYZhUKrcG61emZl1EaDyqXbewxOQLLG9ENJlGr/7Giudy6UKTKxQyclcsL27qOFb42gSiN4PP7nFaqadIF1MVm7TX4sO8sViCtHhbfSelL44iq17nLo3s3h0381TILfuoWaVy0nGZT/FIrKJr66NcS3uRLc+QXyXgAJCjqOmDnfDyutiLohCApqoLV31o0saKJ28iaOBS2zirAAFAg4vHh71CHZq76bO6klb9alrdxb84iya03XsyNL4sr+08WDG70oegXAtzmy2TRHFEa7uq2dFfTKXyojDTx204m/f+d305w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GeiYqJ+m6gO84JQUrN/DUFBHuPyZ3mE1nNJIpRrGv3c=;
 b=umCbVaniOGq4y1pSGvIuR8u+N1pPm8vlv9acXuIJtBp90YoJI2yJgh65hX8/spQVSDpUHVv2y5QmSsC2kYMf27bCz0z5tbbcLDu+bR2z/VJNlwABpWyyX8xT5NETfu88hX3zxZk0kH5ecxPzmBsqXabye675aRejm61q0YAuyvuAMdChflRh4oW/k/j0k9zXhL5B1yhuhykispDc6bKim1Hiexzu9mJM5SGWv5/5CDIH6mNrwYkuxqqJpy9E0DLOt763N6hFMMX3hEyNuIIqTqDQlunQpx/AAxvsydWU91uQt0Y3JXpcjbODzAhxa17g2/udNQkWrsGZzRSe9Xzt1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.44) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GeiYqJ+m6gO84JQUrN/DUFBHuPyZ3mE1nNJIpRrGv3c=;
 b=Lo/bpWDpiVZWtTgBwRmVpmobFoLhGHpZZ5YYTjFIbRrIibTCrk4UvvAtb/nCJiSnTOsT9gNU9dPgcQGInwANGP9/9Y85q9qFDupx2WvRZAkxiovJQpcGjEXDkT3CkCCyKBDeAxjBbN/KXPGiDPDKEqdba9ebltlVoRet5EF4IJtHXr3OMdxn+JkfUJCUHl1dhYbzDR70b+5Ag5I8M+CIS0ckR/E8QOvj63esCj4Ag0EJjxX7sQhCNEO6NdHZn6tvOjNzJD1rebsCXMqFuVgM71ypxjckMJsVgrLnncKypkGY8A/n3jDBJG7bQx5O3+km/H+5GFP7t0hns4D/rFzkLg==
Received: from DU2PR04CA0238.eurprd04.prod.outlook.com (2603:10a6:10:2b1::33)
 by DB9PR10MB7987.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 07:43:17 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::46) by DU2PR04CA0238.outlook.office365.com
 (2603:10a6:10:2b1::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.12 via Frontend Transport; Thu,
 30 Oct 2025 07:43:04 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.44)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.44 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.44; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.44) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 07:43:17 +0000
Received: from SHFDAG1NODE3.st.com (10.75.129.71) by smtpO365.st.com
 (10.250.44.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:35:51 +0100
Received: from [10.252.23.232] (10.252.23.232) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Thu, 30 Oct
 2025 08:43:15 +0100
Message-ID: <218de19e-6145-4207-bfb9-72ff5ae9c050@foss.st.com>
Date: Thu, 30 Oct 2025 08:43:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] video: stm32: ltdc: support new hardware version
 for STM32MP25 SoC
To: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>, Tom Rini
 <trini@konsulko.com>, Kamil Lulko <kamil.lulko@gmail.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Dillon Min <dillon.minfei@gmail.com>,
 "Patrick Delaunay" <patrick.delaunay@foss.st.com>, Anatolij Gustschin
 <ag.dev.uboot@gmail.com>, Simon Glass <sjg@chromium.org>, Sumit Garg
 <sumit.garg@kernel.org>, Philippe Cornu <philippe.cornu@foss.st.com>
CC: <u-boot@lists.denx.de>, <uboot-stm32@st-md-mailman.stormreply.com>
References: <20250904-master-v3-0-b42847884974@foss.st.com>
 <20250904-master-v3-4-b42847884974@foss.st.com>
Content-Language: en-US
From: Yannick FERTRE <yannick.fertre@foss.st.com>
In-Reply-To: <20250904-master-v3-4-b42847884974@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.252.23.232]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9PR10MB7987:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6dd5af-679c-438e-aa14-08de1787fd69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z0E2cWhrcFJIZk1sWENCWVpJRWxORmpYalZwY3pSTnhxS0lNMTdiNFo4aU9j?=
 =?utf-8?B?TGphZnhwOExRbytUTm0wb1FFNUErOVl0RHIzVU11ODBpNi9XWWRRWVNzRHBX?=
 =?utf-8?B?V0k4Y0RJSXhMUVE4TGR3RXFXT2FINDd5YkIreXBFMW05N3h2OGpjSHV6QXkr?=
 =?utf-8?B?Q1pPOGNlVXhZU2V3RDBzc2docWgvbTVJOEswaVN5M1gxUnNMaWVEeUNmdG5k?=
 =?utf-8?B?bU9SVENpZHBNSy9pV21odUNtODZmVGg2NGcxTWlHZDFhckpwSkNldjd6M25F?=
 =?utf-8?B?dVlhYjZLRE0zeUsybTY4ZjdXQjJIWFNOQjk4YU83Y2R0WDNsdWVrWktkaENa?=
 =?utf-8?B?R1B2cVdaWVlmbHNsRm1pTXdiTFZBQmtBOW1PVVV6NDFtUE0ycjY1R3FHRlFa?=
 =?utf-8?B?bXJtV3hvVmhCU2ZYclFDWWg0K1hwbEtLYjZmWmlvdXJvK1l4Vzcxam42RXNk?=
 =?utf-8?B?SHk5emRsVFUrUVMzcGJBeFFaZ0VBOUNHSFJROCtLcGkzZ3NCTSt4YVJWbm9X?=
 =?utf-8?B?M1o0R2FjMG1ITDA0djc1eVAxakhnVGxySldiZVBtRW9GOWsxNWhZWWo0S0p0?=
 =?utf-8?B?YjlQSlVCdFpQNFJvTWlxRG9ycW00WUZqNllYSUd0OUlzTWVTeEdXalpmTUdJ?=
 =?utf-8?B?VzcxSkwxZmh1TW81L3pZNE5uUEJibW4yaHM3N0ZSaEFETzd2QXI4MTRBQTVh?=
 =?utf-8?B?OERXVVU0aXdOUEVMVHJ3YVkxKyt0VTlHb1hqdTZDN3IzZ0U3YitZeG9IVzhK?=
 =?utf-8?B?OGdlM1ZzRTJyT0JWcW4ranRPaU0zV1FmemR4SkpGTmJ2ak45eWpqWm1LL2V1?=
 =?utf-8?B?WmdJOEI4NHAyY3RWOW92d0RBUHhBcVBxazhNc1JZRy94ZFFyRDRiQ2Q3R04r?=
 =?utf-8?B?WTJYV2VpOFI0V2tMSDdsbEliRnBUWk5PdDhsSFI0YW9LNlBMU3NvejRiM1pM?=
 =?utf-8?B?Nk5sTG1JL0RuT0Y3ZWVJd25NakpMcmFQd21rM2tnQmQybjBSVklhNnFmRUhI?=
 =?utf-8?B?RG53d211YnNQK09LeFdXQXppdEdJcktiYk1zZEFtYVNKSHd3aUpVS3FHRFZK?=
 =?utf-8?B?bzJSOEdXcVczOU9hUjNDU0E5QVJkb0VkQThBYURDdUF4cUZHczlpVmxNL2lG?=
 =?utf-8?B?T3RQZXAvQzZFSllZd0tVcGx2QUpPMnNYQ2lMNTR3RzN4VmZ6ZEJGcXo3M2hD?=
 =?utf-8?B?Y1NjUkJkQzZjaFdMZklsUi84TnhjeEQ2My9GRHB1NzAyRVo0bTNBNEc5dVMx?=
 =?utf-8?B?TFhSLzVnMHhHVmg0V05XYk83MnhjMzJaaW0wdnBsYWFRcW5RS1lXV1JXTjlD?=
 =?utf-8?B?c3I3ODUrdks4REpxanNjNERDY2JEcVZ2cjUvOFBCTlJUOVcrOVJPTE1OZjZO?=
 =?utf-8?B?TnRwUlpnQmJaUW5uZklBWkJFS0tIdkxuS3oyNkpBbzVuVmU2SGxMZjJpL3Vs?=
 =?utf-8?B?OHl3M0VwQkxMeFVOVHI5YlpTL1RFUEc2SFhMVFRXdXJXeWlDNkVXd2RTZFRI?=
 =?utf-8?B?bDI4UVVVcmVFdVpNUENRTVNoTnNBY0x0VnV2bmpJU0p0WlZWdmQybTZJZVJF?=
 =?utf-8?B?Yld1MlY3ZDczb3h1SU1lOU1OMHUyeTlQYW1QSWlDd1NIYUl6NlVjbTd3Zm56?=
 =?utf-8?B?UXMvZW45RkFad3Q2SC84NEtHb0tObEMwWWMrVlB0cmhPSXVuLzF1TXZTcWow?=
 =?utf-8?B?eXRQUWJUZ0toYnFtZ2NPWVZ6S2dibWhhNy9GaWppK3JmQmQwWnJXNmJZMjhP?=
 =?utf-8?B?bktaY1loVmxyV3BFemMrdnAzL0dXajAyY3Yxam5hVTJ4ZnhRZERXYmUvTGdM?=
 =?utf-8?B?a1pUc2JETGtTbkx4Z21MWjcwUGxzQkYySjdHUkQyMVJkTkFtQzEybGZSbVdM?=
 =?utf-8?B?TlBzOHNTUndBVEtXRVdxV2UrM0YyRGVjYkRxeU5mUXpMb1Fsb28xdHBKRTE5?=
 =?utf-8?B?RTZ6bkpPOUxBa09IdmlzaVAwN3ZabkMybGN3ZUY5bS9KWldBN3JSSFdKUFVr?=
 =?utf-8?B?SllOTHhxdjYyc2xxTjlhWmNLTUJ3amRjZjUwM0Z4UEdWL2dPTWZmMVJlNU9I?=
 =?utf-8?B?UWw0eHdEaEpMbkExVjZMTklWY0c0Qzh3RHBEbEU3TlJKZzJZR3JHb01TOUVE?=
 =?utf-8?Q?Sm/NwA9PgX3Pz8C0W+Pmcje6h?=
X-Forefront-Antispam-Report: CIP:164.130.1.44; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(921020); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 07:43:17.1345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6dd5af-679c-438e-aa14-08de1787fd69
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.44];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7987
X-Proofpoint-ORIG-GUID: f7H1E-uouY5nCKCXs7yS0q7XU2JTxteM
X-Proofpoint-GUID: f7H1E-uouY5nCKCXs7yS0q7XU2JTxteM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA2MSBTYWx0ZWRfX41NzRdrhwwMO
 BtgqYqazwDZ8O4ZyyDqttmmRm4AT5r+pfvoejdD/sxngxcAeBCdDKMa062jkfL4pH6G36JcfVOh
 KUW0/huFVtYBKhl9nrb08yqyVfEs8rDmvNyDZzwe80Lsr3MBICpAhWq9f1HLBIvJWecGU+SnGll
 XEBQwEAbqso/3XcwygRyFI6wFWtIcfl2PI8Itw5z6qhahiLXixg7VB059u8c1ua10dTJHRlCC7V
 7NCi4JEkvRS71uR7FMi5ba5/5+jXOG6hsqbs+tJufE0/6Z9YVFfwMmJ3saZA2G+TjBtRIMnuIFu
 l0lq1k59+okRDopqK8iKr/5nQkz646+TRWwS9gJYlRX5ZBymcES4hnfVbLdg9VqKRh+f67WWvJP
 aSCf/sRpYxbcZQU/gBM0FeV9WwSL5Q==
X-Authority-Analysis: v=2.4 cv=DP2CIiNb c=1 sm=1 tr=0 ts=6903173c cx=c_pps
 a=65o2Amv0Ue3sVzSEE8tp/Q==:117 a=Tm9wYGWyy1fMlzdxM1lUeQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=ttam_Flv6DUA:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=8b9GpE9nAAAA:8 a=kxCilVioRAr92PqvDDsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=T3LWEMljR5ZiDmsYVIUa:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510300061
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

Hi Raphael,

Thanks for the patch.

Acked-by: Yannick Fertre<yannick.fertre@foss.st.com>

Le 04/09/2025 à 14:53, Raphael Gallais-Pou a écrit :
> STM32MP2 SoCs feature a new version of the LTDC IP.  This new version
> features a bus clock, as well as a 150MHz pad frequency.  Add its
> compatible to the list of device to probe and handle quirks.  The new
> hardware version features a bus clock.
>
> Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>
> Acked-by: Yannick Fertre <yannick.fertre@foss.st.com>
> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
> ---
>   drivers/video/stm32/stm32_ltdc.c | 22 ++++++++++++++++++++--
>   1 file changed, 20 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/stm32/stm32_ltdc.c b/drivers/video/stm32/stm32_ltdc.c
> index 0a062c8939dbe49b11aa50f5ca9701bdbe5c5b0b..efe9a00996eca0301d2a2b82074ba9690a967a73 100644
> --- a/drivers/video/stm32/stm32_ltdc.c
> +++ b/drivers/video/stm32/stm32_ltdc.c
> @@ -262,6 +262,7 @@ static const u32 layer_regs_a2[] = {
>   #define HWVER_10300 0x010300
>   #define HWVER_20101 0x020101
>   #define HWVER_40100 0x040100
> +#define HWVER_40101 0x040101
>   
>   enum stm32_ltdc_pix_fmt {
>   	PF_ARGB8888 = 0,	/* ARGB [32 bits] */
> @@ -529,7 +530,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   	struct udevice *bridge = NULL;
>   	struct udevice *panel = NULL;
>   	struct display_timing timings;
> -	struct clk pclk;
> +	struct clk pclk, bclk;
>   	struct reset_ctl rst;
>   	ulong rate;
>   	int ret;
> @@ -540,7 +541,21 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		return -EINVAL;
>   	}
>   
> -	ret = clk_get_by_index(dev, 0, &pclk);
> +	ret = clk_get_by_name(dev, "bus", &bclk);
> +	if (ret) {
> +		if (ret != -ENODATA) {
> +			dev_err(dev, "bus clock get error %d\n", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = clk_enable(&bclk);
> +		if (ret) {
> +			dev_err(dev, "bus clock enable error %d\n", ret);
> +			return ret;
> +		}
> +	}
> +
> +	ret = clk_get_by_name(dev, "lcd", &pclk);
>   	if (ret) {
>   		dev_err(dev, "peripheral clock get error %d\n", ret);
>   		return ret;
> @@ -566,6 +581,7 @@ static int stm32_ltdc_probe(struct udevice *dev)
>   		priv->pix_fmt_hw = pix_fmt_a1;
>   		break;
>   	case HWVER_40100:
> +	case HWVER_40101:
>   		priv->layer_regs = layer_regs_a2;
>   		priv->pix_fmt_hw = pix_fmt_a2;
>   		break;
> @@ -688,6 +704,8 @@ static int stm32_ltdc_bind(struct udevice *dev)
>   
>   static const struct udevice_id stm32_ltdc_ids[] = {
>   	{ .compatible = "st,stm32-ltdc" },
> +	{ .compatible = "st,stm32mp251-ltdc" },
> +	{ .compatible = "st,stm32mp255-ltdc" },
>   	{ }
>   };
>   
>
