Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 959E0D3B9A9
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:55:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F2A836C8;
	Wed, 10 Dec 2025 08:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="mwUvywVt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 01A1083655; Wed, 10 Dec 2025 08:55:52 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8775383655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=44396d9337=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BA7iKi32041158; Wed, 10 Dec 2025 08:55:40 +0100
Received: from am0pr83cu005.outbound.protection.outlook.com
 (mail-westeuropeazon11010048.outbound.protection.outlook.com [52.101.69.48])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4axy3ds5dt-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 10 Dec 2025 08:55:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3KwY1vzLOHniqVCXsmIg3/jyQCrbcWeoQFw3GODiyScy+E+B0a0SKbY3/VBRAo2Q0qCYbCZLkDAbIISvq97aAW2k+Er9X041L4Uls51Y98yaAQVre1cuwjtoCfA/geqppDrbSm0U87+sIRgxU5kJHLKqU7vLcLjhhD4U1TWwAPeauQ0J1Cs6mEUSOtFXtsDwC5JiGHZDhV4DpAQzwPP+nlSC9GtJ/4m9w1YlxZrOVfMujLsgVs50hx02deg+32WCimo2EXh7ZENwiPeYf6nMWFf7cVAZnx1mzaKMcsPvY9YTOGU+GDYx3txLg9cmF3kKDoQzwK71OkAqlvMIyxEqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2arl+b2Xwohx6VTv9UE7OmFu0/pZ9aWB12CUUJVF0OE=;
 b=P6xvarEDNcII+Y61ny1nItNZua9cQgOKnk/4w1N9LoI8F/N48I7JLEaUetxgmp3bCV0X5iAP1+KA9BUqiIAjVSp4+iYe4uEIwsU9EshZB2sCdyT9dYQkE8KFWZNgQWHrJY+AWeGUH8dlrI4rQbUoVPq7hoCAuP+uKnNWLJnWxJ7Sp/nMW55ko0vHAp9r2PzmUYcRsADH0wKbLtqI/awGzaoijHOr7PElvr0jEi3ums3qxm1WIEtAW5HnmDKxG/2QftbIeoib1HoOpefGPQp9yygh+eR1uf36eZ6UU7d+Uuq5xGcSHRiBgW8ZbNLtMFPC7snuM0peGE+CyuMK2vhi5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2arl+b2Xwohx6VTv9UE7OmFu0/pZ9aWB12CUUJVF0OE=;
 b=mwUvywVto5kYVCC3EQbBUSlmh8fDyV41+fT0flnEMxJdz/X/N9ddwD8zsIasIgCBrCqvOgPfo1knO1REXwo8CNrKTkVDHDC8sXDnzFy45X+1bmragikOIuYYmM8SvBa61ETEUz05OUSFCENi6Rgh9jyN0WtVLwz+ieNf7rysvL3mpznZ7n5xxP6ho8R5dEBncp92GsL+MrPdo4/RXZqk3VIAYNjAEelza5kSBQrBlo8PS4SQzeKmc/u8/EY4TGGm5oVKXCXBOYgx+Vh0Ty1fsofI/YcbqYLm6uSpMRH7V7N0M0/waesg2LiyJ1IHKKaDjL1AidhiXzNwc1+gP6he/A==
Received: from AM0PR02CA0109.eurprd02.prod.outlook.com (2603:10a6:20b:28c::6)
 by DU2PR10MB7785.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.7; Wed, 10 Dec
 2025 07:55:38 +0000
Received: from AMS1EPF00000046.eurprd04.prod.outlook.com
 (2603:10a6:20b:28c:cafe::3e) by AM0PR02CA0109.outlook.office365.com
 (2603:10a6:20b:28c::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.15 via Frontend Transport; Wed,
 10 Dec 2025 07:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AMS1EPF00000046.mail.protection.outlook.com (10.167.16.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 10 Dec 2025 07:55:37 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 08:56:20 +0100
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 10 Dec
 2025 08:55:36 +0100
Message-ID: <a8fe7c31-1aff-4625-8717-7dfdcc572fc6@foss.st.com>
Date: Wed, 10 Dec 2025 08:55:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>,
 Patrick DELAUNAY <patrick.delaunay@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2026.01 =
 u-boot-stm32-20251209
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000046:EE_|DU2PR10MB7785:EE_
X-MS-Office365-Filtering-Correlation-Id: e13085dc-579a-4b95-c522-08de37c181d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YTQ2b3dFWk92bm9adUZSbDBJSldaY3JqTEs5TjNEeW9RUjRFUGhOT1pJbXhG?=
 =?utf-8?B?RTRuQUs0bVowVmFnTGFaTWNKeklqM05lVnpKNlUvR0x4NGdCOEhTenNYQU9X?=
 =?utf-8?B?bm9sZjdzS3UwYWMyNWtpU0lLMElvazZ0TG1ENFlPb2liejYvd09xYXF4MzB3?=
 =?utf-8?B?WUxKVVlnbmlURCtscnVEYzV0Z0xUZy9RWmVMdkl2R2hjM2lXekdzajBiaFhL?=
 =?utf-8?B?Y1ZCL01pRGo4c3hZT2N3V1N2Zk12RVZGVHBCL1J4WFk1bUdWUWhROE1jQkFu?=
 =?utf-8?B?ZUFMZFVCTTdTUGRaK29iWnVhTTF3eTJFNDhKNTlmU21jN3FLTi9oellabm04?=
 =?utf-8?B?TW84V2lnVWZ4ajAyWVM0cTFMdVArZTh6UnZJbXFFdmZCTzdvM1dwcVUrekFJ?=
 =?utf-8?B?K0Q0V0wrb0U1MmtmVzBiQjB1Z2t4ZXMvdUR6UEk4aklodG5Jdmd6TDZHYnZL?=
 =?utf-8?B?RVFLOENVM1BmNHVDQ1RSRDl4SnVRN3JpV25aZWlSalplSmZJRUVkb0tGU3pN?=
 =?utf-8?B?aHQzdUhXNFBVNW9KY09WRjJzaEtMWVFpQk1rdmk5SHJUTVB2ZGFuSWN2dlFR?=
 =?utf-8?B?MTRzRG14SDRNSVVpMGx2WjdiVlRGYVdSMElaRjRnZ1NXT0hOUWIrc3VqbXJ0?=
 =?utf-8?B?dWhxaVh6UHVFSXM0OFFNczFJcTZtTk40MlFlQWlydHpxME01V0taOXdWajl4?=
 =?utf-8?B?RFBTSUJ1d2xaWVQ0VUVTSGRtRzN3NzVnOFlQTVVSUzQ2TnpNNVQ3UituZEF0?=
 =?utf-8?B?aHZkVG5HNzh2NDQzZTM0WFk5MzJhZXVrcFAxVndOMG16VHRYOGhsWkpieVly?=
 =?utf-8?B?a3RJWDZUM2dyNDRJOHc3S0NZbGR1MHUvcTkwRGdjRTdHR05DUE1QN2I2SlJ1?=
 =?utf-8?B?RmRnbFpJcDJzV3ljYUl2K0xnU1VLNXlCaXJ4OW03bGYreWEvbWJWbFlML3d6?=
 =?utf-8?B?Mm4yd0Uxd3dGcnBCc1BsTHZqY3RmaVVocWxzd0F2TG5pK2xkSVpPMGRKemdr?=
 =?utf-8?B?R3VYMVlsY1A1MTNuNjRNY2w0MzlWOGVCeG8wVXVIYVZTK0Z0VlQ2b2pvQ20r?=
 =?utf-8?B?L0srUGl0VUQ0WmpHYkRKNXlMY0UrdHpzN3Q1SklMelNzcFlaanA0cEZpNEM2?=
 =?utf-8?B?YnJNY3pUVmhSNGt5QnNsV21LSTZ4VnliWWJtWXNodGNyRjl4RTM2Y1BnbUM1?=
 =?utf-8?B?cThUZWpVUnp0ejZEVnNxaUw2YjZjUU9wWmZRQ3c3Z1Y1aVZUcEhjbWFjRmdV?=
 =?utf-8?B?OEF6SW16dHFTeHJzTUtiUkRySU81Qi9ITnFHdGhtUTJtMW9XSHdIWTJEdi83?=
 =?utf-8?B?bDhUMjV6VVNkdWVGc2JLSERlcUZscWgxN2FXb1JRa3RrZmhTLzNmRUhsZ0Qv?=
 =?utf-8?B?ZERvNmpkL0NUUDFQR3lKVUhkbElQRmhZVDdOd25JcC9jRWdWbnoza3AvQWlk?=
 =?utf-8?B?SCtxVTRPT0tZMi9DU3AvZXpoNFZDNzZFamN3QmJrVXJxSnpiN1pJSktNc0o0?=
 =?utf-8?B?WVAwZHgxTzhIMjVwR3B3L0RneVFNK3B3bzJ4SzhPZXkxWHNzM3NKcTJKVzhs?=
 =?utf-8?B?RGdORy9WSUlmdVg3aEQ2dGZSN1RDMm5rRDRESnRjbWRMZWppbm1pWXdiRGxW?=
 =?utf-8?B?dzdORjB0WFJUU3BiNnNZZi9SOTJFVmFDa2UyQUh3VDRzeWpnYWZUZDZwNzRj?=
 =?utf-8?B?S3dmd0FTcHlDSXpxbmt6eXExM2pVeGlRbHpTdGduUWFzU0NYb2tCd2dOOVBn?=
 =?utf-8?B?OU02SzgyTTBhbm1WSTNOMnBhUHg1RXpZQ3hWYVVhMERIZmQza1dKcnV2bC9L?=
 =?utf-8?B?M0ZGMkJhWGc4Q0JHSkZ1MWlXcndxT2cwaW4zWFJ3QzhRQXluL3R6VlpyYlpT?=
 =?utf-8?B?anBNcFpHQVZtU2twSGJxMll6SityYWw1ZDd3OEZ2V1ppd1ZVWUNuWW1wUmd0?=
 =?utf-8?B?TTBpbDlacC95THE1NDNnbWkzdExnZGx2cFkwZVpQWlVTWjRjZWw5cEJSc2tX?=
 =?utf-8?B?Z255Y3ZMU1R6Q2pYUDkrRGIxa21wemplTmJOTHZnYlN5RkljV202enU0eC81?=
 =?utf-8?B?RktablBSczdzSldpc09wTUdwM25WcXE2b3pCczZuYTBKamsvdU9wc1ZBZHly?=
 =?utf-8?Q?/feg=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:55:37.9049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e13085dc-579a-4b95-c522-08de37c181d7
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS1EPF00000046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7785
X-Authority-Analysis: v=2.4 cv=FJkWBuos c=1 sm=1 tr=0 ts=6939277c cx=c_pps
 a=YgCVrCdv7G7y5nYQ0Hvsxg==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=XWp4PHTOCikA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=zAFMNAEoqqPFEQwHkIwA:9
 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEwMDA2NyBTYWx0ZWRfX1HDQM//Wp3GX
 0flncAs7TQPw6XrABzU8S4Ha8Kl6v0Miq3lb4ud70TGHqPAKcYd6/6jNhvzhuusYVOoXKA7DbH0
 kTvzeeQulGoH1zDziWZ26W7J/9J1k3zvdX7r2BtxxaJ4BSVjDr6kf2sDRsiMkE6Ip3WqgWPncM1
 hJqduuzycbk8Oe/ZCcQmgNP9OrOohIzx1VGkcVathcwKQFQWTebA56cml3hYEviLyFn8g2iawh1
 yP3rVNJ9CB1uOHWj8ZN64jEoPWY8x4S1VcvTyWow3rRiqwwAq4wblbwJGzClX68r6UY7xaK7zan
 ZXUzoyCRARxiGl878xW/vIR1KFEKeRerkJn8L8kZa/I13ihl0MZ+BHTjYljaaKtNE9Q5Nu+vNb+
 GLPZPLK9f0Nf3LwxX80/lr1leGGwKQ==
X-Proofpoint-GUID: tOVOXbypFxedx3Im1Tp0JsNjMqDb-WS0
X-Proofpoint-ORIG-GUID: tOVOXbypFxedx3Im1Tp0JsNjMqDb-WS0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_05,2025-12-09_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512100067
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

Hi Tom

These 4 patches have already been pushed on next, but Marek requested them to be part of master.

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28704

Thanks
Patrice

The following changes since commit 0e0a198a68be71148f5ec27ef86796174f91436f:

  Prepare v2026.01-rc4 (2025-12-08 12:54:47 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20251209

for you to fetch changes up to 78e94666dd794ccfab561a9ef6e5b9d6a785ee97:

  ARM: stm32: Add missing build of debug UART init code on DH STM32MP1 DHSOM (2025-12-09 15:24:36 +0100)

----------------------------------------------------------------
_ Add 1 GiB DRAM support for STM32MP13x DHCOR SoM
_ Fix 512 MiB DRAM support for STM32MP13x DHCOR SoM
_ Fix handling OPTEE in middle of the DRAM
_ Add missing debug UART build for STM32MP1 DHSOM

----------------------------------------------------------------
Marek Vasut (4):
      stm32mp: Fix handling of OPTEE in the middle of DRAM
      ARM: dts: stm32: Fix 512 MiB DRAM settings for DH STM32MP13xx DHCOR SoM
      ARM: dts: stm32: Add 1 GiB DRAM settings for DH STM32MP13xx DHCOR SoM
      ARM: stm32: Add missing build of debug UART init code on DH STM32MP1 DHSOM

 arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi |   6 +++---
 arch/arm/dts/stm32mp13-ddr3-dhsom-1x4Gb-1066-binG.dtsi | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi             |   1 +
 arch/arm/mach-stm32mp/dram_init.c                      |   4 +++-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                   |  11 ++++++-----
 board/dhelectronics/dh_stm32mp1/Makefile               |   2 ++
 board/dhelectronics/dh_stm32mp1/board.c                |  30 +++++++++++++++++++++---------
 configs/stm32mp15_dhsom.config                         |   1 -
 configs/stm32mp_dhsom.config                           |   1 +
 9 files changed, 137 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp13-ddr3-dhsom-1x4Gb-1066-binG.dtsi
