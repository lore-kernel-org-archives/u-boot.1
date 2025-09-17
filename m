Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730CECAC598
	for <u-boot@archiver.kernel.org>; Wed, 17 Sep 2025 07:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5CC783327;
	Wed, 17 Sep 2025 09:07:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="CW7BYS8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43EA1833D0; Wed, 17 Sep 2025 09:07:29 +0200 (CEST)
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1FAC832F9
 for <u-boot@lists.denx.de>; Wed, 17 Sep 2025 09:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=13552feb49=patrice.chotard@foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H6fCCV028578;
 Wed, 17 Sep 2025 09:07:21 +0200
Received: from am0pr02cu008.outbound.protection.outlook.com
 (mail-westeuropeazon11013008.outbound.protection.outlook.com [52.101.72.8])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 497fxksy2j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Sep 2025 09:07:20 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HWKO02A+TSsr4Y1y5hg9OfsQlf+g6JCopaEVQNDMpjebTwHdYgCbXe+0Pghke9l6SAibnqXGP6AIGaX5IPLYpmmQb33e3M1k5/Z03AQwGUoPeeyXNRYuY9h2S0UlPFbzH9EOF8g4bR3dR4QbllW2NCONGqUYlyiWVQuLJZsCCPupS8v3rT6f1aX+J/Aqt6fhGiehBdh5VV7AIK+TyBdLoIp9nNF4/mVkTQv5YX6WeNM6Y5YvkY2lPNpJQqYRFY6at2x/iP66mHD8NZ5W8UA+troyP8QYTfoPkS6x70/h+bsL55sb70QuAR8tL3vKh/EU0u64k5CLHnD9K6g84Rh8oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gxMCiWpVdnkZAETHKimW5LhAFKZ2MUxM7iY1f1rfaKo=;
 b=IUGR3yZai6ZvlfV8GpIsGBTuakGhDvBfHrqrPyiLH3OJBmIXfQxSl5Y1LCDbQwsE5+9VzGxnsW7BQ4HAfzY54xS4BQudwciQforZvlHwJwlWYH/Um1botfvq9CVpwYDySwdGtMiQpeLWpLUwYaTRGTKYULLjC6MCIGGeB+IUeLDk5Em+rTjszxhaqRvX6GmoCOnqadu7Xusq7SPyG1oiGl4cSS7lDY+qPxNoS8Al0yDZVYfTuTYcIvPJpZHDfTq+OrbJXy0hB8pnKISsYrHs6kf/GFRWsFnrsqg52hSAR0wjGMgvXgKlKBlHqFfgMTX+OqYu7K0kRc0jXugwcvZPWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.43) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxMCiWpVdnkZAETHKimW5LhAFKZ2MUxM7iY1f1rfaKo=;
 b=CW7BYS8oFdqGHiwfy77WRaGgUyy2eTvzcRJrATDF9e2tleDQxE9d4A64DFCo/X4mZzqHQLoxQz5v4gvX+pHH/Xi1JUjBNECfh4U9TqpcLoPUBU9aWWA2GmJnI7ebThE8p/zvgOBF3GKIovUDF7GZq6MR8CwVNYmHumurAnFXlqIoPHIPEPooI9OzzaEeIaDty8MKEEMJcr9htcGlkIbAAFyHUY/HJz09VQckTa103WAUmrn/9bsjgxmsNt8oVq0/Jw6O+jHsd+6UM8x0gbK1/2wI0VVn3s7H+CqqnYEQ88Wttbs/xsnAVCbJf5sCGPRBiNVpdlbXnXVrGG2YnmAzAg==
Received: from DUZPR01CA0028.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::7) by AS1PR10MB5141.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:4ad::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Wed, 17 Sep
 2025 07:07:15 +0000
Received: from DU2PEPF00028D0D.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::f8) by DUZPR01CA0028.outlook.office365.com
 (2603:10a6:10:46b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Wed,
 17 Sep 2025 07:07:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.43)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.43 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.43; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.43) by
 DU2PEPF00028D0D.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Wed, 17 Sep 2025 07:07:14 +0000
Received: from SHFDAG1NODE1.st.com (10.75.129.69) by smtpO365.st.com
 (10.250.44.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 09:04:50 +0200
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.57; Wed, 17 Sep
 2025 09:07:14 +0200
Message-ID: <27f1612b-25e7-4727-baa1-0001f8526acc@foss.st.com>
Date: Wed, 17 Sep 2025 09:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrick DELAUNAY <patrick.delaunay@foss.st.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Marek Vasut <marex@denx.de>
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot master / v2025.10 =
 u-boot-stm32-20250917
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.62]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0D:EE_|AS1PR10MB5141:EE_
X-MS-Office365-Filtering-Correlation-Id: 852976a3-3c31-40a9-7ded-08ddf5b8d4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFZlZVdNVzVweTZ0dWQxdzV0eW9zK1JSdUwxT3FaREhHbU1wL0xYMm5BMUxq?=
 =?utf-8?B?Y2EyWkd4dlNyTUJkb3RMVlNtcEZ6L0lWcFF3NUZRUmMrUFlXQm1xVjNIUU9i?=
 =?utf-8?B?VDQ3NThNRjR1ZzZsVTgyRkpiK0FYSml5WXEwb1FaOGRvd25OOVB6aStiN1pS?=
 =?utf-8?B?L1hEaFFzUkhNSmNrRThyUU9lVEoyZXpFdnhRU2IzSllYemlxOWREQ0RzOXVl?=
 =?utf-8?B?SGtodzNLU0kxUWU2eTc5WnBpdUVvdFZRM0ZaN3I2NUVTQXZJNTlVd0JRWXFM?=
 =?utf-8?B?c3NuU1NMMjJGMDBDSmVYazhhV05YS0tWeUFDeUl0b09KTGVWQXBhcmlGUUdO?=
 =?utf-8?B?M0lyRkJvMkZxNGFBT1Qzd3EvMXlWRFRnT3h6UzlyQU5ybVR2aUVYQ0FnbWpI?=
 =?utf-8?B?V2FhMjRweFZQcFlIaEsyQ09VRThuY1I4K24rYnZBSExOTk5RUDZkUDFadDda?=
 =?utf-8?B?WVBBbkFGREhKN1JDZGJGM2NGZVA1bjhkS0FPS1ZiODFHSGY5KzRqMm0wbFgz?=
 =?utf-8?B?bWxxK0k5Y01vdzFxbjhsMkkxZ0Jpd04zRHFPbGtERXBxRzBnanBiVWdCdW96?=
 =?utf-8?B?Y3U3RThMcnZyZHFZdmVnS1k0VFJlc0Y2NDU2ZHpsZHErOWJZSGFVTlA5YUxK?=
 =?utf-8?B?Y3E1ZGdPbTdSTFdzZTg5M29wUzlrWk1KMkUzc0pGeFhJSTNXQ3RkOURYdk5n?=
 =?utf-8?B?amQxV0JMMHd3ZnFLL29hWmpGNkxmNWpEWWtMb3I2UTZXZXhXY3JSZmFQaGox?=
 =?utf-8?B?SWlTRlRST2t0T2c1Tmg4cGdIM0tQSWJRRUlQSWtUV0QxNkZYMk16WWtXQk9P?=
 =?utf-8?B?ZE1pUU1vQUZvZHc0MkNRN3F2YnlXMVBRV2huQWxEYVRNTDZiZU1HT2djWW9H?=
 =?utf-8?B?MW5UeHZkREJQNzNXZDhWNWJLMng0b2pIazVVWUtMYVM5b3VQQndmM3EwTGho?=
 =?utf-8?B?OG5Xcm9wWnoyM2lZNlByQ0E3SGNtelhYWkI4MmJTMnNLeHIyYWxsUHBqNGdR?=
 =?utf-8?B?RnlQaFl3SCtZVXFtVjJQVkR3L1FNV0pHd1BmVWlxUWYzTjRSaGZSTnNJc3pT?=
 =?utf-8?B?WU5RaG4vZGtraWxkTTgrbzhpQ3crSllKUjQ1SGRFclZYQ1c5bWVWZlN0Z3lo?=
 =?utf-8?B?TzdGSThlMWVUQ2V3TkcwL2hpQ0pHajNCV2cyajhWZHJEdFJnM1UrQnFUTTFa?=
 =?utf-8?B?ajhmamZ4V3BoVmRQRkMvVXFNQUYvcFV3bTEwZEpSYWE0cThxMys0K1hXS2d1?=
 =?utf-8?B?N0dJNmZ3eUNvQ3hUZ2svZTJoVm9MMkpQazY3OUZ6N0drYWs0OHNaRHVUdTcw?=
 =?utf-8?B?MC8rckZUeEZTQ1NtampzY3N3VWxsL0lXdGVkL3J0Y2haWTUrcVNWM2RoeVA4?=
 =?utf-8?B?OS9OMGlmSnQvQ3ViS2hUZlhLT051bXNleVJybTRhWHNaN0xFaU1GR294OFFm?=
 =?utf-8?B?R0pIdUJySTMrUUVCMnRtdG41cUp4SXpLRERNbkVWOFJjNUMrdWxkQTFSNmRh?=
 =?utf-8?B?aWg4aitIeW5JMVpscmswcm1vTjRqZW95b2pmR09yTjhyRW1PZ1lOQ3RBM3Fw?=
 =?utf-8?B?Q25qRUE1WDJRYmlDRUlZSkVLbmZpME1xQUo2aFcwblcyUkZxVE55WGV3MDdU?=
 =?utf-8?B?SmtjSVV5V0c1dEExbklWbTgzZEZFTUQrYmE5UjJMYnNvc1p0SjBNVnY4ald6?=
 =?utf-8?B?TVNBRWt3MkhxNW5LWk5SdE8vMEg3RUNraG9RMzQrelE1ZU9xckkwdmhEb1VT?=
 =?utf-8?B?NGNjQTZmV3RPNWNmWmoxaTEzdTFjWGVPUGpYSDF4ZVF3S0lrL25jL2t5Rnl4?=
 =?utf-8?B?VG1SdVRPYUxKeTFpUUNKTTQ1SWZpelRDNXE0WVQybDdaN2I0QVhPKzZYTTVn?=
 =?utf-8?B?UkVVU2daZzh2NTZXTTBmOTl3VXpOWjRhVDRJWnh3WStYdGxFcHNRZFk4a3JP?=
 =?utf-8?B?TkovZVgvbzY2djlvSTZKWWVnQWJLN0Q0aEoyOVkyMSswYWl6cEhuM3BFZVND?=
 =?utf-8?B?RXpkSm1lY1RnPT0=?=
X-Forefront-Antispam-Report: CIP:164.130.1.43; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2025 07:07:14.9282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 852976a3-3c31-40a9-7ded-08ddf5b8d4dd
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.43];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0D.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4LL50H5RuZtV
 TjufcLHiyLkCou7I6Cw/70a1pZ4pkVtewbpVj/TCDdDIwOJO5pfuJxGSp7EOnP9yEa6KonULKW9
 GDyFhBfYBqPQUDchxbhhHI3CDF2Pgu19ZCqA3ZSCAb3GHYFkUTe86dOkgtN/9Ctpk6k75hCwqon
 HygMClkwXJm9kN7lo0LVhbqov9sFu8VgJhmG2MfPpXQ55CZjZY4pkuCHTV+E9s/F3laoUk7mVie
 3gy19eLLf17Oji6nsyRnMZG4t+BecDa3XK33eHYKVaNxZRcHcAsCT/iNvhY0rvPkCiVTYRTYQbb
 qsu4ITzLyOzoNobTYfBP8kB+D0RWw/48HqpSNNx3y7jdpjNfNIaFru9YtjY8CCSelFwYM0ecAm8
 nZ6xzT2/
X-Authority-Analysis: v=2.4 cv=JYq8rVKV c=1 sm=1 tr=0 ts=68ca5e28 cx=c_pps
 a=6Kf4RVHJovTFG9veQ3L6kA==:117 a=peP7VJn1Wk7OJvVWh4ABVQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=h8e1o3o8w34MuCiiGQrqVE4VwXA=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=SAHXIHsbQyQA:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10 a=YfCOm-DyAAAA:8
 a=ZWCJqFeMuyLkwAOQmzkA:9 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-ORIG-GUID: nlVSK0JW6J1YcZiwCNc8IzNsHHCUkH7t
X-Proofpoint-GUID: nlVSK0JW6J1YcZiwCNc8IzNsHHCUkH7t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-16_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 malwarescore=0
 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 phishscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202
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

Some last fixes for v2025.10 release.
Please pull the STM32 related patches for u-boot/master, v2025.10 = u-boot-stm32-20250917

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/27648

Thanks
Patrice


The following changes since commit 2dbde3f9b08771b8182fcbf0bb0309acaff6c2e1:

  arm: armv8: Fix spl recover data section broken (2025-09-13 17:59:23 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20250917

for you to fetch changes up to 0f4bfee3cfe7e0786b8bf748c523c8e78eda8423:

  ARM: stm32: Perform node compatible check for KS8851 early (2025-09-16 17:36:53 +0200)

----------------------------------------------------------------
Fix net suport for STM32MP2
Fix to prevent hang in clk-stm32-core for STM32MP13
Fix ethernet init for DH STM32MP1

----------------------------------------------------------------
Marek Vasut (3):
      clk: stm32: Pass udevice pointer to clk_register_composite()
      net: dwc_eth_qos: Fix support for stm32mp2 platform
      ARM: stm32: Perform node compatible check for KS8851 early

 board/dhelectronics/dh_stm32mp1/board.c |  6 +++---
 drivers/clk/stm32/clk-stm32-core.c      |  2 +-
 drivers/net/dwc_eth_qos_stm32.c         | 44 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 39 insertions(+), 13 deletions(-)
