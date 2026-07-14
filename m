Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92BC7C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 01:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF71A84B73;
	Tue, 14 Jul 2026 03:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jhqhc3iV";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Yx0WpRVn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD12B84C3C; Tue, 14 Jul 2026 03:37:43 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DD7B84B51
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 03:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=jm@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66DNm1rw713254;
 Mon, 13 Jul 2026 20:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=cv5a2ZQJgskXH6fLQzOxguuhi14gmvcZcm7O5eqi+
 88=; b=jhqhc3iVU8rjmHm6IoyVAJvldfS7GBx/tsx8MWnU4OU6zv60IoyMAffD8
 2kCyFR1zRSS4kFYyCDoxodqexFFQ3i6AmUD3DPENkH2mnkGYbzxE5Tv9aT7J3h24
 9xM+w3Pi22LUhswf6IEFrxs07pgqqngdWJgXhH7VDPx+bt0m1vkNmjvs4DeFir++
 6ypNuHnUi3AYn6gZVm3SpQFy3aX/7pAT/VRsqMySqv8hP4J1eV5GIdNAPPeVYykq
 qTOyCJlbpvH2UytGK6F3eZaDABIQW49JOzKIx9Dv+rkWMLw/PZuBkl89Op5RWsgK
 6HxXgIzSZNJAOPlW/AjuJeRWmafTw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013045.outbound.protection.outlook.com
 [40.107.201.45])
 by m0380145.ppops.net (PPS) with ESMTPS id 4fcxxemts2-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 20:37:28 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNBAxBq4mVInjPIhI0DlmqKP7Gvfeud8pD1ueM7MN5XVd6hI0b39olp8PbkLV66lQ8jbUnb6wOaiUSjiNepOqvdau4ACPLYeevEPqAcqgvQ2ZWi9d4980utwIKLNOskTT1Hw7i07nwA6jzdZVKMKYcpid4zJEciPlhbJV0GZOZf00gwSTn4XQ1/W0Are0XRn8rZWgE8tKN4tuSLymrOp1mjkK+F2zzW8BRVBDRcMZwaghFYs4qxowWqfiD6/du5PX/LF4mET5TXZri9/5QEEJMHpV2xn1iIgUgygVpYdfaeSSZm1G/qucTp7PVW+48u7kNmIKspFLMi4HSBelkQnYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cv5a2ZQJgskXH6fLQzOxguuhi14gmvcZcm7O5eqi+88=;
 b=fI87k60LegFE9LEcnWdGuRk3DR8pbklb6otpSYeJu04QzUc5ShZHlBIp9ycXWzaVcYg0ON4Sgz1Qnz6G6laWpddUQKZQsscTlqZnspzRlLYyanZPu5tTBcAHNRju3JV9SJsmv9TS283jPkmoLt38y20DO0sIdodPl8z1QxBNfhJHNwuPau3Yfp1EWuJWxcAmDSgxeeMZSoUCbw9pV9H/9FW6j1n0j60EKWkavCvO+OHywM9TWAhzDalJ9/4cRG/yCy5rVe+e39bBCVweKxnaZzun94fGA9p4yHGdsNzJhA3WomAQttAsBKkoN8iD42v8BrFxH1h8lFl9DEgNvmW2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=altera.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cv5a2ZQJgskXH6fLQzOxguuhi14gmvcZcm7O5eqi+88=;
 b=Yx0WpRVnrEAv91zVnULdT+paoZtQByFQs5asnn6zBP3GV9W2ae/f75TEAmJ3uadq1GrjtbuY0rIb6vG5yplofQS8H4u/sVfldhkDXeI5lvZCmX/o2bXDSRoHR20WnFuIZAgDelhrsGEamhu/HcU0bVXo4+BI0K5AaGFunPCGB7U=
Received: from BN9PR03CA0537.namprd03.prod.outlook.com (2603:10b6:408:131::32)
 by IA1PR10MB7113.namprd10.prod.outlook.com (2603:10b6:208:3fb::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 01:37:25 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:131:cafe::9) by BN9PR03CA0537.outlook.office365.com
 (2603:10b6:408:131::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 01:37:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 01:37:24 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 20:37:23 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 13 Jul
 2026 20:37:23 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 13 Jul 2026 20:37:23 -0500
Received: from [10.249.33.93] ([10.249.33.93])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66E1bN9j2962501;
 Mon, 13 Jul 2026 20:37:23 -0500
Message-ID: <d17a810c-e2db-4a24-a37d-2d7e02466ce9@ti.com>
Date: Mon, 13 Jul 2026 20:37:22 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Peng Fan <peng.fan@nxp.com>, "Kathpalia, Tanmay"
 <tanmay.kathpalia@altera.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "trini@konsulko.com"
 <trini@konsulko.com>, "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "marex@denx.de" <marex@denx.de>, "tien.fong.chee@altera.com"
 <tien.fong.chee@altera.com>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <agg8f-Q_RnVI9Gyl@nxa18884-linux.ap.freescale.net>
 <f87d4c47-8675-4b43-b076-52325e2c00ca@altera.com>
 <96aa516d-9039-4b64-a779-3f16a9b9b816@ti.com>
 <2e75ec28-a3b0-4890-8e10-ea0459d6ff7d@altera.com>
 <2571b1a0-9395-40e7-a85e-4204c7543d39@ti.com>
 <ec10eda7-a33d-44ab-b89e-46380fa289d7@altera.com>
 <MRWPR04MB12330469B22D00DACBD1546EE88FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
Content-Language: en-US
From: "Mendez, Judith" <jm@ti.com>
In-Reply-To: <MRWPR04MB12330469B22D00DACBD1546EE88FA2@MRWPR04MB12330.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|IA1PR10MB7113:EE_
X-MS-Office365-Filtering-Correlation-Id: b5593954-c154-46c0-cf48-08dee148749c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|18002099003|22082099003|56012099006|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info: XAEnsZSlmh/LOmAuBtjWtUabLiGybSlWBqPA2cOWkr6KG65MkXCPUuZDg4OlP0RHoGm8f+75+mCOEejTMYRwDTstQiet5Vs4CQ8iUScBRSpqotDqNklrp56afYnAFxFFGjh3AaXCKWir3CKbVwoADV+2ry7GABJclOpvITyqZyEZf9xmn7Yvfd5rXGVJXZqIVSrdigjpVL3xQZMyIijczvLfa3kNbA3ychjnykFGYt3I+BqZG7BIpY/HUTD54vwfgLwCSVPOAXGS24uDfLRkL96Sk5SPYNRGgsGVSrRRVLovjSGTQ00f51HPaQwlgpY2Txahy6EFFPnpuKMM1qOzX8h/mm7bpl0NcFr0uMFKwlrh9HPz+vKGGFZT2kG0sslGWFhGzY2xlhBl5XzliQryJhupm19Bcx1XuYAO4G1nc2yUFr5VHzZuVZjiCeay9/qVNFP1+UdyY/ylYrvFFEV6zuF7h37uZWlgWcA27nc5w4CNDAWj00J2SQxZ2Ir9zQmnB1razzj4DYZ7G5YI3LAWeCNWn4ta/C277ZOMuW7SScQTuFzTtirKngydiDfde9M1IUdHloaSrvlCM1gqfVvbZYXifhpqtp3lpAlDCjis9Eif6eAKeWHDf9A7V/LRbS97tTLOet5xHl42C41bl8+oFCoYSjjskO5qqYez48+j7+HS6y1oeDRiggioWGFSKQn2atDVnLh43dHV0zhhCx8aug==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(4143699003)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CunzS56n1LCEhI+eE2U59nS0H311q9uHRW8MqWHqCAdmsEmBr/Uik6uHjPG7tISvSrVbA1dztKrl4ZLuOPVfQlM6bbUBTgtxIThUY7svsMP2G++ZiGUfgtVFLjhQ95tExCYNYWoo6efj5KyYvIMgSaC2v0sfCKGWezjaFe4slEU5HcMyuX3/AEQoa1InmtZ2b+rEYYznmkadCjpt+nnwRuMyJR6+pc2bPnKInyOhCVAOB+McOS4GkmWiYZp9avsc8H1O9ISQXdHRQ/nGLrU+G9qcinP0i7i9FTiHHTSi9DlH1/ofetnLbUKO+0xxUYpnaSUI55S8/yb+YpU2DWoJppTpFcoopq5a0PVrNUvEEu1EhIGyBX83ONiQvuA2zdo/0RXiJhpsa1Szvzij0ufKFo6S7KL5tN+KfFHsVWhiFpFfnPL1djJacYjTclt0HFi4
X-Exchange-RoutingPolicyChecked: ghWtAbAhOVoMDnCtM9wxv490+uKUPnC0rjCF8SgDNpGPtQAOC7nMcpAonrkIcyE8xgkxIZ8jFyqbhToNDL5qEI0zdeOs25XPHlStiGXf71diV4DDcvMiabX+MjQm0MTH86Kdn5tXiU5W/nd64UxGSGKKGrWRoen81VfuAD9PutCmcr4CCMidRuGFBJojZqLfQdZrSeNbR0gq6IeMDrKli/BmSLtQcjReqWVwzngA5ajIsbSkbp+lzcFS1b9ECMsD1iChvPb36JvYnLCTfWSdAOhf68ZtfSrl++xYCzRsmAlRq7yQcUOBRZ4rXsW76khd4VOVeE/xTrujU/JD0l97/w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 01:37:24.2429 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5593954-c154-46c0-cf48-08dee148749c
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfXze60vgsYWack
 l8TGk1dXKxdlguZwtMtj4a0pReP4TtA/QbAsZn8HOcNMj06KSQELM9wVW5iAjtv+XwdwHB1GXw3
 KsrJAg5JpaX/h+VWqsPsc5UkLjEh/HKVlWQdThUvvGGtkG9fuN8wbEsIP9rhz8wrikmYWQdzT4w
 Yl0OjgnHuA7QuV0XNDMAwPicf4Wdegq0RnM/05/EG3PVGvGkkG0qKILs5rNElTcMmA+1GGNg12+
 CYpa39FDfKi9FQehVsb6ObVOaQB7kgj8Zkg7EZnmmUq+PvUcVEzEzqZOi7xu2fJkuKP1VKo/7AV
 YJo4C4dnh0Tt5F40BgHaUVbFmWjS4hZ+UZGJfrLjco9zBhjqLOyUvTKi1XhOzlDRyB+cgEuBGdm
 /iIriXRqAHnTZW6bltfFVattGE+Po2ZCTnBnsYYi0JfJyOoNm384L4ROqblKRCrwHnjagIfTVJQ
 1O+YgYWhMvqDginFfbQ==
X-Proofpoint-GUID: aENFNkHAe2GaPxy7AEASjFj9rHg4GgOb
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDAxMyBTYWx0ZWRfXysNrE99EPqlV
 sYB3ZP22HvxlTg7vqTJjkyoW7QbYqYiKw0AsdQPhE0KDAeuJp253skbrxRgP7SGa+z6bMAESiqc
 plrs+S2smjsaO9hgqcaviR4uMilV+lw=
X-Proofpoint-ORIG-GUID: aENFNkHAe2GaPxy7AEASjFj9rHg4GgOb
X-Authority-Analysis: v=2.4 cv=Frk1OWrq c=1 sm=1 tr=0 ts=6a5592d8 cx=c_pps
 a=IhFJ2QRitvxj7yHj5jvJkw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VzwNk457a8kPGWc87pwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_06,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140013
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

Hi Peng, Tanmay,

On 7/13/2026 5:21 AM, Peng Fan wrote:
> Hi Tanmay,
> 
>> Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without
>> power cycle
>>
> ....
>>
>> I worked with Judith Mendez to get to the bottom of this - she shared
>> logs from the AM65 IDK board and we went back and forth analyzing
>> them, which pointed to a board-level power sequencing problem on
>> AM65x rather than an issue with this patch. In her words:
>> "So it is truly a power issue, I have a patch to fix the issue on am65x.
>> There is nothing wrong with your patch, coincidentally my power issue
>> caused am65x to fall into a weird state and your commit caught that.
>> So actually, thanks. I can now send my proper fix to the u-boot mailing
>> list."
>>
>> So this patch did not introduce a regression - it actually helped uncover
>> a latent power-sequencing issue on the AM65x board that was
>> independent of this change. Judith will be sending a separate fix for the
>> AM65x board issue.
> 
> Thanks for the updating.
> 
> Thanks,
> Peng
> 
>>
>> I'd consider this matter closed with respect to this patch. Thanks Judith
>> for digging into this and confirming the root cause.
>>

Confirm on the above. No problem, thanks to you for the collab (:

~ Judith


