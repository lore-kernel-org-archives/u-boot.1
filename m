Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB45DCCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 13:14:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F1D5838AE;
	Mon,  3 Nov 2025 14:14:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="OntD8E4h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00C7F838D7; Mon,  3 Nov 2025 14:14:03 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0718A83700
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 14:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=3402134e50=patrick.delaunay@foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5A3D1tqa3276470; Mon, 3 Nov 2025 14:13:47 +0100
Received: from gvxpr05cu001.outbound.protection.outlook.com
 (mail-swedencentralazon11013010.outbound.protection.outlook.com
 [52.101.83.10])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4a59yh81bs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 03 Nov 2025 14:13:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wx/8k9tTGGXEXlW2dBZLCtDFj2dUygQFZ8RTqsYm8ghncDuEpIOd0fLMlqQLt/CHbc50zlsb2RQxiglEaaZ7zERrDsbbZEMnRREO+ItS6m4DHtsq/2azeJ3Z4uiJhTsWRviac97519/tp3KesSUvsg5fMIHJ9kSBva0sXW5YEu7qdHSGyPHdIEZ1J/9Lswh5/nut7ecHr21aHzpPGfENXIAN4An++YozLYocfelo8Qwc9OXSpv+d4nfVC4kgPTYphYZfxTzkGC5jTcMBWb7N1MynGQuOmvCtZF2bSVmC5ddd3WyMNEtWHJCseik5tDpevVMhsOTKOMUP8O4h4CNIeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNeu0KfgCKH2GGdFkzz0p+zm1Kj8x4+uoAuWFJAMsFg=;
 b=BwJyPzNEqe0f3dPjAWLrh8tM7/Q/7FB14iL4fKxiDSVDNTSOl6aJe8Mg+ArVjB4MYMhKpdA7m7FehF2pXHXr2ugRXHaapUGaYMQbn8lVBBdMAO6Fw4kIaDX81+JYbui48n242oQ/6wrGOvtYZdLYgpTmkKVleZ7hO43KWJeGULKl85cMAGvNMEbHOq2LlM3dlTjEyrbPMpon+LSFh1/PTvXm6MTrM+8JtCnhY1yQ/iP+gHcgof1HNISl4S8WdBaD6L+/Wc/yCSy+NyauKeaDv0INMurtqWYFDte1pJ6dsUr2OuP84mgmeefHh8OugSI8+dqNunbvnE8CRHiMb8czsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linaro.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNeu0KfgCKH2GGdFkzz0p+zm1Kj8x4+uoAuWFJAMsFg=;
 b=OntD8E4hQKAURp72UbnZTIQHAnvhIinOQugD0HHPgXzofqP+9xLSKZ90a+Jc4oRNFcLKmDv9Z5pDXDcGjO3SPxrsiDCxjFvCgsS/0O5rW2IuqJkRb3i5FHHMGBLw/5pfqhU+vrA9NiCZseNzE5kZ4uik5HiMlBbVFwawKAOp0zX3I1Xb8I8urtTfTv0CfW7LkDyK0MBbcAQWEAID7mcIJw8MH4X1dbFeskK4gEQs/pHqaxpXn7MW2hkbr0pGDuRRkpxJE0CdNU1y1PY8aAp5E4GXhCpCSANRWBbXNr7UjuW2zg093c42jP9P8+s0r+99Mr0GZLBYiiAGm54HqB8QEA==
Received: from DUZPR01CA0006.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::13) by GV2PR10MB7030.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Mon, 3 Nov
 2025 13:13:44 +0000
Received: from DB5PEPF00014B9B.eurprd02.prod.outlook.com
 (2603:10a6:10:3c3:cafe::63) by DUZPR01CA0006.outlook.office365.com
 (2603:10a6:10:3c3::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Mon,
 3 Nov 2025 13:13:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB5PEPF00014B9B.mail.protection.outlook.com (10.167.8.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Mon, 3 Nov 2025 13:13:43 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 3 Nov
 2025 14:13:44 +0100
Received: from [10.48.87.108] (10.48.87.108) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 3 Nov
 2025 14:13:22 +0100
Message-ID: <6da32ef3-5c3d-48d9-b69d-2b94cbdfc4fb@foss.st.com>
Date: Mon, 3 Nov 2025 14:13:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: Prevent SIGSEGV on debug
To: Andrew Goodbody <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Tom
 Rini" <trini@konsulko.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Marek Vasut <marex@denx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Ye Li <ye.li@nxp.com>, "Sam
 Protsenko" <semen.protsenko@linaro.org>
References: <20251030-fix_debugs-v1-1-4750e9617499@linaro.org>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20251030-fix_debugs-v1-1-4750e9617499@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.108]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9B:EE_|GV2PR10MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: d29fee02-ccfb-4dd9-6313-08de1adad05e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OElSeW1yQk5WSVhsTTEzcmp5SFRJenl5SFJhWUNXNVRWSnBjbU5aR2hOaXoy?=
 =?utf-8?B?MEpyMVhFUkxWanltR2g5K2dKbjN2dmR3T1VtUWtvTU1GSFRnbVZHc1MweW9v?=
 =?utf-8?B?MVBXOGtROVlHb2UvMWgzOTNGVGcyemg3WlQycDN2NlZQMUhSUVBsNUtsT2k4?=
 =?utf-8?B?WUNJdFl1bHd5UHp5ZTdHTjRoQW83VEtYZWE5bnlDRGMrYmFEYmJjVFV0dXk3?=
 =?utf-8?B?T2JacTR0ZEdGRzF5Q1d3Vlh4QVVuMFJFbUltbFlzSC9VeEZ4UzFaRVNDMjl1?=
 =?utf-8?B?b3ozUHVTeXlIRmh1R2tvRUszdVNGS1g2eDR0bmk0QTZPbEVnVEJ0bUY3ajJL?=
 =?utf-8?B?TmwwanpiVVNFK3U2Nmowd1hrZy80bVZBR1dKSFdEaG1CUldJcTZSaFd6R1dS?=
 =?utf-8?B?dzZUejJ1QXdhR2JpSW5TcDJINmZDMmlvNXFtdTZLWVI4Ymx6VWNuTXl5bUlF?=
 =?utf-8?B?QjhYTkNkSElyM3QyQm5XZHZKcllTRStlOGZLVzhsTmlhOTgvQnFGTUR4ZFNx?=
 =?utf-8?B?RkdXamM4TWVGOU9IVlRpQTV5dEJnV3dQM3YwR1o4U05XVXp4Vk1uY3MvQW5C?=
 =?utf-8?B?VkliRDFaMjc1NkF6cjVLUnFqbHZpL2U0cERsaDA0QlRDeW1wNXdXUUlRWlVY?=
 =?utf-8?B?N2Z2Y0dDZkQ0Q3hVZDVXWXhDQURpN2JWdDVmdjZ1dmJIakQ3N2VwQVJMN3d4?=
 =?utf-8?B?aDlHSGFWVjUyY0g0Mno2UTVnVU5zZUtLRWs1Q2JSanJ1ZGU4cUxjWFozcWlF?=
 =?utf-8?B?N3RNaGlmSDMwQzFJQUVJNjhQMHc5ZW5sYmQrendGbUVHcWl2dkxCa3RBaXQz?=
 =?utf-8?B?TVk3SEdNMUxydUlVeUxQUUlBcEhFOWI1VTM3YnQyVzlJYWZqRFdWWlRMTjZ3?=
 =?utf-8?B?eEFuUWkwdVZ0bVpHNjdiN21aYWw0WnBXeUFTMEpueURPNVNoeGFFbk44QUd4?=
 =?utf-8?B?eS9ad2plWGNzQ3h1eDYweVNaSEdTL3RKS3NEaHp6WjRiUUFDWVVPZENUL0hi?=
 =?utf-8?B?dVpjQ05kYnY3MHYzRk5qZFB5UXhySVViVFhTMThsclN6Q1JJaUhsZkxmcTFJ?=
 =?utf-8?B?bnREWHRkSVZNRHU1QVY5cHNSVmRWcnBINExaOEpyNlFuVnZXNmxPdFJ4SjUy?=
 =?utf-8?B?ZGVMQzBQSXRzVzJTMTJLNHJmamd1MnVudmtsQTdXN3htUW0zSTBWSXFPOW1y?=
 =?utf-8?B?cElSMlFMZ29WWmxCcW5iQ1AzczJuSWErUzBHNWdFUDdUamtYNTN6cEs5NGtt?=
 =?utf-8?B?cyt5U05uSUtObW1HRVE1ZVU0OUl2NlVBUzc3bUJtQS8rdjdlZTdoaDJNWTBT?=
 =?utf-8?B?N1NyQjVyMWpNV2RhWGtOdGtFaVlUOUs1aGJWQXVsdlVFUVIveWFud0JoNTNO?=
 =?utf-8?B?djR1a09aZUVLTmVNZFVCaityQ0Rwd1N2SjJnblcrUGtjejJNblBUL2RPdjdT?=
 =?utf-8?B?Q3JGcXBtYklHZFQzdG9rNG9kZkxVbWd3Qlpza0xJelgvOE9YdXhueXZaRmV4?=
 =?utf-8?B?Wm5mNmlWOGJ0Qk1YM1NaNkNoS3Jld0NoZHNBdjhublV5VlNRTnk5bUZzanh1?=
 =?utf-8?B?TDM3NmlBUXo2ZWJ6dTZNZ1lPUitaODZINGxhendiOEJHaFRDQU4rczRNUEx0?=
 =?utf-8?B?bmlPdWh1WndlYnVETGRCKzNRSVNKSnRaeXM2WFBWRE5jYk5iRDYwemNhSk5q?=
 =?utf-8?B?WGhxZDhTa3p1QnlWd0R3Q2w1ZmdFaVlHZ2NQRndNNGM3VDVOblJxcTZJcksw?=
 =?utf-8?B?TWhybUVmS1pIdkFvQnRzazBxaGJQaXdwVVNzWWJkNVc4cnQzTkdZN3p1N0tV?=
 =?utf-8?B?MEU3K3F0aWpKdG5RdXZ3bUFSaXllUmRkTFI4ZTZuSDlJRnh1aVB3Tkl5TGZD?=
 =?utf-8?B?VmJ5bjR1ejZoU2ptRDJ6bXBkaDUzbWxIK2tZcHNIU0E4Mk1UTk8yaXFMVU00?=
 =?utf-8?B?RHk2OFNsUlFzQTd5R2hCR1lmbGl4R2VRK3YzSExReHNmdVNHMGNya0xsVHVi?=
 =?utf-8?B?OTROWmdDZjQ4WWxDbXpMcnZlNERIV21NK3RZQitwdkVzRjNQMEFsSnNJWVJ2?=
 =?utf-8?B?cHl1YUtnVVAxVWc4bk0xTEdvUDdqZ3hWaFNQZnViZ0hrSzNXbHFrVk9mcm96?=
 =?utf-8?Q?Nu9E=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 13:13:43.3062 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29fee02-ccfb-4dd9-6313-08de1adad05e
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B9B.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7030
X-Authority-Analysis: v=2.4 cv=Uohu9uwB c=1 sm=1 tr=0 ts=6908aa8b cx=c_pps
 a=RD4ubCJsghbcDB/ph/12PQ==:117 a=d6reE3nDawwanmLcZTMRXA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=q6CKDgr7omsA:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=8b9GpE9nAAAA:8
 a=xP8ZzShGZ0TjiDIF3GIA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=T3LWEMljR5ZiDmsYVIUa:22 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-GUID: 2EEeSbcK1UZC6Rrxc6x9nCdU4cUDn_0T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDEyMCBTYWx0ZWRfX8rR6xfJhFy6g
 Cwv4XNytCh4QnBY5oje2nk4Z6CP8Ot3BCqsGd4z1J0Yk1p8RxFVmkLrg+gRDYgWzTR29CxFCHzO
 CB3waIhJ0es2UqqiWuZh6hsn2EhtCBdVjwUp/qqDRaW4mK0uXYa8nl3wyjVGiamecH4MaDWvc9C
 HkCTNgVtjsEpUkas9BZcHSs1pUaEwFZEvnf0NaZCqp1pCpr8l0BsumZZeCJbNS1iVUKmWIj2q2u
 8Vf0tOL92dwSHVFj5W94gA/Atr0W6RBVgKuBxHZvb5bnDmus7/k+ZWaH3UB5dL4ymz7mqH3+LYa
 6OLOCs2Bv7IW51uDVZ1pVbDVRwcVEuocsoHCMeJrk63mjZDeHi5J8AKvwz4KAzcF4pxbmIQfgqQ
 6YFPg2530mFiHadfWfQU/0g9F+sHEQ==
X-Proofpoint-ORIG-GUID: 2EEeSbcK1UZC6Rrxc6x9nCdU4cUDn_0T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_02,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 clxscore=1011 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030120
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

Hi,

On 10/30/25 17:55, Andrew Goodbody wrote:
> If LOG_DEBUG is defined and a NULL clk is passed to clk_enable or
> clk_disable then an attempt is made to dereference NULL in the debug
> statement. Guard against this.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>   drivers/clk/clk-uclass.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 3dbe1ce9441ca513d41be90520ff175c96b4253a..1f55dbe385b76d0d6cfbf19bc9f4f1abe619baf2 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -660,7 +660,7 @@ int clk_enable(struct clk *clk)
>   	struct clk *clkp = NULL;
>   	int ret;
>   
> -	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
> +	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
>   	if (!clk_valid(clk))
>   		return 0;
>   	ops = clk_dev_ops(clk->dev);
> @@ -721,7 +721,7 @@ int clk_disable(struct clk *clk)
>   	struct clk *clkp = NULL;
>   	int ret;
>   
> -	debug("%s(clk=%p name=%s)\n", __func__, clk, clk->dev->name);
> +	debug("%s(clk=%p name=%s)\n", __func__, clk, clk ? clk->dev->name : "NULL");
>   	if (!clk_valid(clk))
>   		return 0;
>   	ops = clk_dev_ops(clk->dev);
>
> ---
> base-commit: e34d01d23e45e007368685ffa6dfd674b6dd7b17
> change-id: 20251030-fix_debugs-de8b8c877969
>
> Best regards,


Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick

