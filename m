Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC23AD2F7EE
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 13:24:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34749841CD;
	Fri,  5 Dec 2025 14:24:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="YJ3Rc19t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57D2841DA; Fri,  5 Dec 2025 14:24:38 +0100 (CET)
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BDF7841BC
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 14:24:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=443406b657=patrice.chotard@foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B5DIawo2637385; Fri, 5 Dec 2025 14:24:29 +0100
Received: from osppr02cu001.outbound.protection.outlook.com
 (mail-norwayeastazon11013057.outbound.protection.outlook.com [40.107.159.57])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4autdg1m4g-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 05 Dec 2025 14:24:28 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3YxpTZAxID/7zcyV21JXhs99sTHT1ze0QyFql84LKNCv2S8pCyPDJZgZZaSmGR9CYfczpIf3XlSdRlpPfhsoceWOC7UPA1HHS4xxbUQDwWrZwUwHUdU/jLwnSCqBeIal21JibvpwsAJRjrQRFUk0UkBbBxkx6XXkoqAS8Leaulb2BfF2Qe4vMJ7esQmw7TTQW0swBlRDD6okzKdpK2y2rR2reCUKtkW7fQqAzwcifvMBhnONlpCLDEcgvebAHeGq/YEq+KSZaGZ2RKRZ8SA9RCUFUOqoZMBFPnszkbm+V9e1UqpcgqNO0JOxcCO/Os8p+HZcMqBhCSMAADDwl7FxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KCweKlvpnt6SzzLlZyQTXcLrwRYJFkbGlSnKgU47r4U=;
 b=k4GjIjVolzGKLbpUGAAG6gO7R5ZdGEwDzx1r2feVx6Q4wrzXT3KEdGA2Lyl1bnT4z5gwR+Spd2KAegEBpFOfKB6iqEYQ2Xb5oqHYiWzA2Prg35QO/yJwshjPreWGGuF2s7i1zTgjwdHKpLaXjrqi/BZZqHXjBIYp+Yk6SailjB8ciCOZm6CANeiaPcm5R9FiBApGZ3J5+XBjIDFCB+zFygyzIdSXavlu8nosyYn2pF6YAeO4qKJ+zh/9xPH3Pwn1oxP2rV7CN3fUR6xzxuxmbHx5dMMkJ8aQ3oe9OUtOYgBCcZgfDni8wu8/cB15iij8eyXfffbAE1OXr0pwN3roag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KCweKlvpnt6SzzLlZyQTXcLrwRYJFkbGlSnKgU47r4U=;
 b=YJ3Rc19tkKWpHB8jV7PjwYdSLLuhTcJ0rcDaUcyiadYFjUBZyZs+uYtBzAu3XPrm512rB7hpbpjqBWQXmxTrG6jLYds8ZJRWyfVTXwGFeZIiGPBs5fNh9nwX1dKrTbL8ytpVOoO5nKOxPFHuaqdRhS/QeCXFUxiy7Izc7tuIQNembEEkcHnQWMLdG/G7ZzfKQnmemqE8h9QxVM4n8WGiX8/Wn1y0NNOqTfkCGmSRJVr3+gwEBxYptsdJMHLH5P/FkAskzahD5QyNMmWjND3U4uZqsV/cm3iLmlDsCGQ/SHichADzlPizGmYxARDwRcDrhNeoaORYnmG5jIOtQxev5Q==
Received: from AS4P250CA0017.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::6)
 by GV1PR10MB8938.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 13:24:25 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::3a) by AS4P250CA0017.outlook.office365.com
 (2603:10a6:20b:5e3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 13:24:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 5 Dec 2025 13:24:24 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 14:25:02 +0100
Received: from [10.252.31.202] (10.252.31.202) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 14:24:23 +0100
Message-ID: <24fc65d7-befb-4e8a-9bd6-46edbf87cfa0@foss.st.com>
Date: Fri, 5 Dec 2025 14:24:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
To: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, marek Vasut
 <marex@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PULL] Pull request for u-boot next / v2026.04 = u-boot-stm32-20251205
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.31.202]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|GV1PR10MB8938:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e47d58e-906e-49d3-770d-08de34019bb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TGxNZERnRm1lNWJLSEEydFB4SU04WWxoaVNrRytUcEk0K1VHSis5QmVya1E4?=
 =?utf-8?B?ZkI4cVE5SzhDYmo4OEdic1IrMlJtY3pGdGhUTTNYNTJxMzJURXJWdEZZUkk5?=
 =?utf-8?B?cjh2ckFQcll2MlFmRUhFU2ZKMGZQa1hVMEpkQ1JnSk9hdTJYSTVNK0VMcDFH?=
 =?utf-8?B?MG5teTg5MFZlRGFrZEFCcDloUkgvcElNSDlaZGFvcGwzU3BaT2RFZENGUXg3?=
 =?utf-8?B?TTlNVTRmTG9VLzEwSGRnQzZWTUs3OTg0em9IMUhFMHhtN25PK0FiVHllY0o3?=
 =?utf-8?B?b1h4cUN1WDhVV0tHUDMzR2VVQmpKVE95bWh1MGtqcS9abzkrbkN4S1kzenNy?=
 =?utf-8?B?MS9BckdaS2NvWEhHcHBJTHk5R2Q3RnBEcVRZOWNnZHlPd0dNV3d0c2phMkNp?=
 =?utf-8?B?dzhNQmJJWHkwZzIrTEFtbU11dU0wZlF1d3ZyYlVuMmNlL3JDVkYvZDMvcExZ?=
 =?utf-8?B?UUIwV1gxUm1vYi9CQVJEVUptNlBFcVIrZGx0Q3JCRmJEcFRsSTRsekpiZlBq?=
 =?utf-8?B?eHBpWk1ITW02a29iN2pIeFRaMFdtKzd4eW9lMFBSOU5EWk9wSEhXZVlkMDgy?=
 =?utf-8?B?UTRMUVVGbzYrcU5JaVFZK1hkNTRCTmZ4TE9rbzVCbnlTTStvN0Zydy8yMnlI?=
 =?utf-8?B?NVR3anVDc3FBVUNSSjkvdE03NCtlY200QURqVS9BWERYaE9UdWx2S2dEZ0dE?=
 =?utf-8?B?c0pYUFRJQ2lFbzJBWENhUjRKVnlnb0hnaHdqQ1BPK2w2OUNTUG5qV0t2RS9W?=
 =?utf-8?B?d2JscGMvbUFMYWFUTktlazNuN3ZkS1ZJZEZLSGdiYVJZeE9JOEIyMUsvN2ww?=
 =?utf-8?B?NlRlek81YmVOQzcrL2N6S3NQblI1R25wT0lrVzNSU2Fob0VHSzZNT3gyYnlw?=
 =?utf-8?B?L1YzZ3dGVDgxRXdyRTdVblk5aCtMbXB1WG9kV1VpcElvaU1ZSldFMnlveTFi?=
 =?utf-8?B?WWFlYkdKaTZGamNQSHpUMDF6cFdNcU1rd2RnMm1KNVdjeHBjblV3bUlkUUho?=
 =?utf-8?B?UFM2N2N2Nkpna0M5djQyUnFLKzI2clArNFBxVlF2bmwvZDdoOUpPVXFreHhj?=
 =?utf-8?B?Nzd6b3U4RWx2eWtpVUtXRXA4dExBNWhuMDNrYTBvdjR0MjM0SCtvdVdRdGQy?=
 =?utf-8?B?N3A0Q3hwSUh1RE9zS255Um9PSlFKa0x3MU1IR0VwWlNIRnRaNS9nVGJCRnFv?=
 =?utf-8?B?aTA4dnBSU3dudVMzS1VaQ0tHY2RsR3FlNTdUWEdJTnIzR0UyY0V5RStxbXN3?=
 =?utf-8?B?QjRWVWc2TWh1WkN2TjVneWZESlNlRDVKOU1aMGhoUTFiam1ENWxjYnBKYlhU?=
 =?utf-8?B?Szhma1ZlVkJqU201WldtY3d0dVpMYTdOeEZGWmpCUy9oSjVDU2YyM0cvMG5S?=
 =?utf-8?B?Vm5NL2NVYjUxKzVacHNwL1pnWWNVZ3FKbFo1SUtmWDNUYXZUK2N5cW82Y2sv?=
 =?utf-8?B?VjhWOXBpNzV0blQ2WHdRcGxjc0pjMHd4WDcremdub0hxdVlwU1J4cXRmU3JT?=
 =?utf-8?B?SUhSNlhicDY5UDJWcHhrNGYwN0NFSHpkbFdUdERaR0d6aEhQR0hTaGcydzFm?=
 =?utf-8?B?MmNVVlZwWndsb3EwSEVCemFtL1BUVHNnM3NqTEg0azdjMmg3c0M4OCtmbElE?=
 =?utf-8?B?dzYrNzVUSTM5WGNoUml3Z0JMczVLQldHVjhUajJGQURVVnYzczhPTFVtUmVs?=
 =?utf-8?B?bjBtS3ZQOFVrUDM2MWdidU9RaDBHVVlwMnIrT3NRYmVXejhnRHEyTEFJRUhL?=
 =?utf-8?B?RlB0ZDhFZ09zNExHcllrMGdLbXJFRStvQXlSZE1URjU2VHMxL1E1UkxDbTBE?=
 =?utf-8?B?RHRVMDE0Y2Fvd3pNZFZRN2Jja1V1ZDVGWm8vQ0hvRUg5WUdMY2trbU1sR2s5?=
 =?utf-8?B?RTlEUTVtbmxtNE5lUG0zTE4vRVd3NUlzSW4ybG5PMVRtLzlwcC9Bc2kvV2RL?=
 =?utf-8?B?WlVJK2FCMVlwMFcxTFB5T2RUVDhGdmJudnBWSTlkSWtiVWhaRytlOStWVFc3?=
 =?utf-8?B?QU54aXNRa1Fac2VhbXU5QTgzbVI5b2FRMkVjS3h6RkJFRmZqUEZsamFrNGtQ?=
 =?utf-8?B?QXorTG9rVDNJVEo4SGVmdnJ3dXJycEtoTVZTS2dyMEI1Nms0b3lYM0s5QUgy?=
 =?utf-8?Q?XB0Y=3D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 13:24:24.4016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e47d58e-906e-49d3-770d-08de34019bb1
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8938
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA1MDA5NiBTYWx0ZWRfXx0dZh5Pm3Ixy
 kZZbi0S2nPl3lQ45E9TVZWWguY5yHbVatSQdmPzpy5Vvw6DGDZlcfAXW03ckNevfIs/drvcdGYH
 +xuClnr3stUxO5148Z62wx2fej13sgXYl3Ch6ZVW678MclX3STeWZMohpGUam5+AM4qQyA3r9iA
 ojJXFGsJHrPiLjiJFu11LLPBidz9CSqYDgREWSALvIAg89oCJrV+gU7mh2DJ9ovyu59els+2F98
 4YcC1P3aYaNDta7ftDTE8mA3LrQlo94gYGQ/bx+BftsUqZ0rvAfjwCnQ23wturHJ2D12uZD62s/
 Rx4K0oMWwF1Jwr7CiY9/ePBtlvYECH83/B5WblHY9Zr0mw5OvVtKb+F2IqNUjk79LnXaKWBq73P
 nbu65IY3o5rh/8qrlEAXiq/nvYAtNA==
X-Proofpoint-GUID: XidDti6Fd491ylDG7dujccHTzR7P3qkS
X-Proofpoint-ORIG-GUID: XidDti6Fd491ylDG7dujccHTzR7P3qkS
X-Authority-Analysis: v=2.4 cv=YrEChoYX c=1 sm=1 tr=0 ts=6932dd0c cx=c_pps
 a=P96BltJlxYhvWyA3BXnrvA==:117 a=uCuRqK4WZKO1kjFMGfU4lQ==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Uo5EeBN78AAA:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=s63m1ICgrNkA:10 a=KrXZwBdWH7kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=YfCOm-DyAAAA:8 a=0tn0yRldiltswqKnMuMA:9
 a=QEXdDO2ut3YA:10 a=zQLMK8awuJ6_Hvp-_9Ux:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-05_04,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512050096
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

Please pull the STM32 related patches for u-boot/next, v2026.04 = u-boot-stm32-20251205

CI status: https://source.denx.de/u-boot/custodians/u-boot-stm/-/pipelines/28641

Thanks
Patrice


The following changes since commit 59f9fcc1f514762674ac07c13c2a85f7aace7250:

  vexpress_aemv8: Stop disabling device tree relocation (2025-12-04 15:11:26 -0600)

are available in the Git repository at:

  https://source.denx.de/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20251205

for you to fetch changes up to b6e61ec06251351bcca22e7a14d9a720ad47ad07:

  ARM: dts: stm32: Drop "u-boot-led" from stm32mp257f-ev1-u-boot (2025-12-05 11:39:42 +0100)

----------------------------------------------------------------
_ update LED management for STMicroelectronics boards
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

Patrice Chotard (22):
      board: st: Update LED management for stm32mp1
      board: st: Update LED management for stm32mp2
      configs: stm32: Enable LED config flags for stm32f429-disco
      configs: stm32: Enable LED config flags for stm32f429-disco
      configs: stm32: Enable LED config flags for stm32f746-disco
      configs: stm32: Enable LED config flags for stm32f769-disco
      configs: stm32: Enable LED config flags for stm32h743-disco
      configs: stm32: Enable LED config flags for stm32h743-eval
      configs: stm32: Enable LED config flags for stm32h747-disco
      configs: stm32mp13: Enable LED_BOOT for stm32mp13_defconfig
      configs: stm32mp15: Enable LED_BOOT for stm32mp15_defconfig
      configs: stm32mp15: Enable LED_BOOT for stm32mp15_basic_defconfig
      configs: stm32mp15: Enable LED_BOOT for stm32mp15_trusted_defconfig
      configs: stm32mp2: Enable LED_BOOT for stm32mp25_defconfig
      configs: stm32mp2: Enable LED_BOOT for stm32mp23_defconfig
      ARM: dts: stm32: Drop "u-boot-led" and "error-led" from stm32mp135f-dk-u-boot
      ARM: dts: stm32: Drop "u-boot-led" and "error-led" from stm32mp157a-dk1-scmi-u-boot
      ARM: dts: stm32: Drop "u-boot-led" and "error-led" from stm32mp157a-dk1-u-boot
      ARM: dts: stm32: Drop "u-boot-led" and "error-led" from stm32mp157c-ed1-scmi-u-boot
      ARM: dts: stm32: Drop "u-boot-led" and "error-led" from stm32mp157c-ed1-u-boot
      ARM: dts: stm32: Drop "u-boot-led" from stm32mp235f-dk-u-boot
      ARM: dts: stm32: Drop "u-boot-led" from stm32mp257f-ev1-u-boot

Simon Glass (1):
      board: st: Drop old LED code from stm32f429-disco

 arch/arm/dts/stm32mp13-ddr3-dhsom-1x2Gb-1066-binG.dtsi |   6 +++---
 arch/arm/dts/stm32mp13-ddr3-dhsom-1x4Gb-1066-binG.dtsi | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/dts/stm32mp135f-dk-u-boot.dtsi                |   6 ------
 arch/arm/dts/stm32mp13xx-dhcor-u-boot.dtsi             |   1 +
 arch/arm/dts/stm32mp157a-dk1-scmi-u-boot.dtsi          |   6 ------
 arch/arm/dts/stm32mp157a-dk1-u-boot.dtsi               |   5 -----
 arch/arm/dts/stm32mp157c-ed1-scmi-u-boot.dtsi          |  14 --------------
 arch/arm/dts/stm32mp157c-ed1-u-boot.dtsi               |  14 --------------
 arch/arm/dts/stm32mp235f-dk-u-boot.dtsi                |   1 -
 arch/arm/dts/stm32mp257f-ev1-u-boot.dtsi               |   1 -
 arch/arm/mach-stm32mp/dram_init.c                      |   4 +++-
 arch/arm/mach-stm32mp/stm32mp1/cpu.c                   |  11 ++++++-----
 board/dhelectronics/dh_stm32mp1/Makefile               |   2 ++
 board/dhelectronics/dh_stm32mp1/board.c                |  30 +++++++++++++++++++++---------
 board/st/stm32f429-discovery/Makefile                  |   1 -
 board/st/stm32f429-discovery/led.c                     |  39 ---------------------------------------
 board/st/stm32mp1/stm32mp1.c                           |  45 ++++-----------------------------------------
 board/st/stm32mp2/stm32mp2.c                           |  38 +-------------------------------------
 configs/stm32f429-discovery_defconfig                  |   3 +++
 configs/stm32f469-discovery_defconfig                  |   3 +++
 configs/stm32f746-disco_defconfig                      |   3 +++
 configs/stm32f769-disco_defconfig                      |   3 +++
 configs/stm32h743-disco_defconfig                      |   3 +++
 configs/stm32h743-eval_defconfig                       |   3 +++
 configs/stm32h747-disco_defconfig                      |   3 +++
 configs/stm32mp13_defconfig                            |   1 +
 configs/stm32mp15_basic_defconfig                      |   1 +
 configs/stm32mp15_defconfig                            |   1 +
 configs/stm32mp15_dhsom.config                         |   1 -
 configs/stm32mp15_trusted_defconfig                    |   1 +
 configs/stm32mp23_defconfig                            |   1 +
 configs/stm32mp25_defconfig                            |   1 +
 configs/stm32mp_dhsom.config                           |   1 +
 33 files changed, 169 insertions(+), 184 deletions(-)
 create mode 100644 arch/arm/dts/stm32mp13-ddr3-dhsom-1x4Gb-1066-binG.dtsi
 delete mode 100644 board/st/stm32f429-discovery/led.c
