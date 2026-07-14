Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0766C43458
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 11:05:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1205584CF3;
	Tue, 14 Jul 2026 13:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="VkccFR/p";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rY8OexMr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7602384CFA; Tue, 14 Jul 2026 13:05:35 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E45684CD7
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 13:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66E7UOOs230120;
 Tue, 14 Jul 2026 06:05:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=y26X24VoJFmCe7OolFZec2vmgOHqBFFxKXPIn3q6k
 ow=; b=VkccFR/p8Y+TERrFDNGmV7W0hXCa19URt8JXmUnfJUH7uNTrJq8VfukkH
 p0T+4OYdBDRgXPwDk3TJ43ZjwRUQbZ5yzjz6an5oCwWV7fdmWpHO1M8+Nt7Xyq4m
 SpnrqouYzmB/r3C2wMsZVrejYPLu9V86wYcrXcKNZZh6ARYfy/5K1/n+lU8PJg8Z
 NgBMK77q9GKP+LzRrlaYPDUQR1qgOBDw3HALd097M1KziICHFhCfR7dq7w8QMvq0
 WzcVs33x6GInewLAMnA4D7Z1zU0YyITVV3SvYi9efIaqlc8BonUZcURavL9ww+04
 bKx0RogFms43vuWMLUdNtlNJ+DFHA==
Received: from sn4pr0501cu005.outbound.protection.outlook.com
 (mail-southcentralusazon11011056.outbound.protection.outlook.com
 [40.93.194.56])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fdgshrx7c-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 06:05:29 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBwTGHsi5gN6U06H9rejwWhprQw6ewLhh1gSkNVQt3tV75OYwGobxyYeXCdv4bBZW/1zkpM0o7XtpVlZH2S2IRiSJlWVR4As5JN1IiLykS6MuI2QQwApTv/SguwnFaOr8J4+QFKyEoiy//G4SfWQzvXNU/Rqdbn7MbjX8p6sQNVcclgbbDv7qPTwLkuE1KyfnapCXIMWB5hslErZEqMmhYp1n7q+iF/WHZHuuzFD/gpipjwkgQT+1R6+HU7nXCDjjATviITjRbG5a0QeUXy89japsAX4P7GxJtS40CEsa9Thdums6U+J7LwCIm8Vk2fTg14DMnLxBPdlmm7yubd8bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y26X24VoJFmCe7OolFZec2vmgOHqBFFxKXPIn3q6kow=;
 b=FIYbgaYhSpgXEs0H8/IlPzIUDVlty5E1MtMJdIIo7b5h8czU1QGpphS2P2Wa92XLcPzs7SEJPRNldBLA+T9ku2jvBZjJmQJXf0cK4bIoaqkla3NxABjM3MvIv1Ix701vQhTjitFefzl9EZbFbpPEDXgcBVKgL5va/D7Ou7yTST9T8SpG9Ao3Vt/NnVXRvfpijtDGoQInc1/116XTtZBoUwlqegoUxcv6LG4T/IFPGQpHWDQmt2hnI2ft9n36ieKaGpOAEExGK+sdbAsf397I/PW9gWYkjbcduI4CnwReH5L98ZprIBIlnM3dmDGUw4zfe9ec5t5LH3mDwNrERaTTLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y26X24VoJFmCe7OolFZec2vmgOHqBFFxKXPIn3q6kow=;
 b=rY8OexMr5miEqCWWgE0rm1js9ooOl8Is+IxQzLxAPKNXYjQSyOpTaONNMxdAVyKbrgVU7LqOKZ74XxiJd9jonrLo5UNrKptN97crEsyITuGXNALWthgl9DR6h+uZtF7RLqX0myRBv5c/CE/ztUfhchGATQXOAy2u6G7bMm6eltI=
Received: from BN9PR03CA0775.namprd03.prod.outlook.com (2603:10b6:408:13a::30)
 by PH7PR10MB7781.namprd10.prod.outlook.com (2603:10b6:510:304::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 11:05:24 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::c) by BN9PR03CA0775.outlook.office365.com
 (2603:10b6:408:13a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Tue,
 14 Jul 2026 11:05:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Tue, 14 Jul 2026 11:05:24 +0000
Received: from DLEE211.ent.ti.com (157.170.170.113) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:15 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE211.ent.ti.com
 (157.170.170.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 14 Jul
 2026 06:05:15 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 14 Jul 2026 06:05:15 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66EB5DCA365612;
 Tue, 14 Jul 2026 06:05:14 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/3] configs: am62ax_evm_a53_ethboot: Enable config
 options required to enable Ethernet boot
From: Anshul Dalal <anshuld@ti.com>
To: Chintan Vankar <c-vankar@ti.com>
CC: Andrew Davis <afd@ti.com>, Bryan Brattlof <bb@ti.com>, Wadim Egorov
 <w.egorov@phytec.de>, Anshul Dalal <anshuld@ti.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260710102229.2980029-3-c-vankar@ti.com>
References: <20260710102229.2980029-1-c-vankar@ti.com>
 <20260710102229.2980029-3-c-vankar@ti.com>
Date: Tue, 14 Jul 2026 16:35:08 +0530
Message-ID: <178402710825.246195.13319125173218743201.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784027109; l=256;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=l0rcPxbTMo+tf+SDwXKNIveuhr7S0wdi0xeHFA0wTqQ=;
 b=Imnr0N8aoeOJ04kxSxQFjdWjynXihiMDzibqc6cuiGjRKolFPyZAyyJuTrHL9S0LYzpcoiUDB
 bagnLL2UX+BDI5fgIXtoZ4w38HFlox9uTu90CZb9ZgfDApjYIqkts7B
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|PH7PR10MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb960ba-0af8-4842-e4e3-08dee197ce0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|4143699003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: EpkOBypEjryevGtWin8eGj/bChaY64GAAsvgrJ/SpxCsw7T0E6pqw3ca6k3VLcdlZr+XGaeiKARAZFItju4SOWxgf6sOYQGf9zOBbGruDsWeNCV48hBTm5HU+E5g2R8qrbrlt0ottmV3Y66+kuKNrjss4r4fsVZEkM4Ki845I16vxSXP1YgIrowfyv7dvK/13zQh1D5Zno9Yj6i9kd2Ti2/lfvwjs2VytuG9293kiBWrNrurwy8wlslIR3/F3jUMdyT/VnCpjibkzns3W5fsth7w1ekD1NcsyQXMjNH9b/PiQTBK8viGrogBYSmh5eH3P+4UsNHnptoGyV6Gg1WAo3zaesRyFgDzOtD2vX8AiT8MoQkTCYT0BbeTKlCfb8CHJriGcjXXB+NAjcxsB8LDoTDLQAleDF11ju9cq0XEzkwzVHwabgfjQ8uTjhndcdaS1it+NEdusX/dgCZHbVK1kaRK27eX9U2vzxK2Dxg/kJlZ9nJ7lkXo4D8Pq4fYswCYvp62whdePzpVbZn0NZVeI+m4+oJwi151M5tAqdTzi+kq1SDOKl2rYwkUsPWqJRmKThePBmcFG04nTkYr04z5u1BSY9FP6GA+dzRix8IDIbpyHqEse38YvZkfp9cEGvGhNwyNbSH3JIJo28d1mRe83baO7bPmwocA6rbX1YrrwO5Z9OzdNWBF7sALDvYZfORexZDpoU/s6FxODDNf+YY2DA==
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(4143699003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nC44exG4PGjPLueCYT6AOJScBRggxD2ynfqURf6ui5CJm5kPvwChON1R8XjAlj7rbbs5+5rWJ4ytX/TOsTSgoR0ZpWxw46iQU0+ML+g2TyPLo/8Z4fIZsGxQq8mTYFkACUtJ9SeJl0Me4WXZ/ic+lvXHUjOcbrY1cY5XBsZdL6848Ll092vsBXpNxJU7gy5Euw3dFF2IGO6dlmf1xgt7wrQJadY5u/aFljo2qzK/r2mkG+PTFZZf9LHUfjVsyPWaLnDALpMmmAxul12ieL9C6PSCnA8PeIx+m6G+v2/K6w5nYBU5xxdQ0gTiretKo82prGhK+BJv7aRLO/06yMPOHBsztxyND4sOpzI/JMiaNTxaCwFzEdJ0wMqKyipTxtHbnSFhYZeb83bSjf79qZHL5FqgGyN5xE3L8U28n7fKZIoAAT4xDt3Dny2o59hWgRwL
X-Exchange-RoutingPolicyChecked: Q+906ZcC975f9/9IY7fNMXJzct+9zwIiJhtlUl8PAlWUpWPmzhcG1a6q8cwayRPByKMuFiJ7V4BQYBW88H3P2FKG70dY7odeEut+3CpzhN/30dTIQAW7s8BxADnNgBF62d7rU5xM3IKpft3SaEoQRtyuKnppBR4ME1MJNFZDH1M42ST8qPgZICwy9A9fjgFCvWhNI8SaElOBwPuZl0KypOXIvS2trXK51vtj8jf20rmo4DN4ByvuS5/ac0di51dRXRAkxx7NkvCgI/K1A0xJSmIskf1P/NnXGtNkw7ajyroHqhIGNAzQ0xUBZRbFCO5o2dP3Z4jppTD5cdySQuncpA==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 11:05:24.5214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb960ba-0af8-4842-e4e3-08dee197ce0b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7781
X-Proofpoint-ORIG-GUID: ilLtlMkRNoTtjF2ORyBbif2BdhbAWBmH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfXw0x4fqVSyF+X
 9qY/zPlx/xwZ4wJs8jnLNWoK8YevBVTemC3jf96o6sCliNPshgfo4yKBx8nPONk7kVmTcHzUiSC
 1sTe4reBBJlmVklQNB7rJ9Bgkdot2rgDN1XfGh96BpavSSyj8sCPqFV9Na+9h7z9wfMD+apE/Tp
 dIB0deqhZqsiUw2Lx82i+vtDDCaaj1Ct5rGG2ov4XpnPBDaBd3A1aadM1eh8t14OCWrkxf/RNmo
 nvv2HP+5VuBm34TPdtcxukKtx7JSIMSlHuBCGR5jlmmAkXoBBXVFW+BxOqbHqEQw9J4Tbjt08VV
 oiN1AIGmgIyxxwUa8JTu2lL2f2tlkBiOowozLLJ0LiKGtoqrQ7x4eewx2Kw8/mD5hclInBgCfJh
 tKzwKVLyZvWCGJDvw64C7A3xp0BZ/r/rg7MU4i//Tt49pemCYORAj3WWKCiDqhWmFlAwrp6u/6v
 IiQDUv7lWd++6ewghUQ==
X-Authority-Analysis: v=2.4 cv=KaDidwYD c=1 sm=1 tr=0 ts=6a5617f9 cx=c_pps
 a=RvZuBu0Sq3F4hQe2CiMyvA==:117 a=WotqVVQAdb04rnGuttW3Kw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s63m1ICgrNkA:10 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Z8NIEmU8O1QQgoT56wFK:22 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8
 a=Lq7r0lCLqwRkwuP77OAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ilLtlMkRNoTtjF2ORyBbif2BdhbAWBmH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDExNSBTYWx0ZWRfXwXT/RoWqnZAq
 M96enLUStJpilZhKcusOPE0AXEj0jLeRE/xeZIiep+zO0KBB5pPIyGo5i/ucQiw80KOYPph+xJH
 oN4bqG9I8r34GUXS/fVU0QDYU97YYmk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140115
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

On Fri, 10 Jul 2026 15:52:28 +0530, Chintan Vankar <c-vankar@ti.com> wrote:
> Enable config options required to enable Ethernet boot on SK-AM62A-LP for
> A53 SPL stage.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
