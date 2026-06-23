Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 461EFCD98F0
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 06:19:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 41D68849D2;
	Tue, 23 Jun 2026 08:18:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="F53uUJXq";
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="NkeC90Np";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8351B849EB; Tue, 23 Jun 2026 08:18:54 +0200 (CEST)
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F5C7849D2
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 08:18:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 65N5l0ik673473;
 Tue, 23 Jun 2026 01:18:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=bVcLiiYG9/15yeNMkTF1uFFteYr5GEzxlOaieCaga
 R8=; b=F53uUJXqtyXwQBS/fua0glnwLd2G4vdX3PmTHKQ1um/AvahOxOJt1XZzz
 LUrJ6oWDklDEwoyjAsXg2WAP/8/awVHP6w2VjUZ5a2S5XFRtinu6MyVMwIzxr98l
 VFHfh58zIXybZjLjS2HYSHUL4FMLVuf9tIJcEHV3Cz6bAvt36cQewYcK/X2T2AYs
 CbRRjzPOXUAHXJP77LqPlC6wfVIvfMqDD8wb5p5bi3/YQ3ob7W7KFJkfC0GljvZe
 8Z/vKXK8fPIRfFGrHJ2PYpyxlJLgTyra41qGkwBsn+kEL+N7/kiWhbgPuJCe5zqb
 vFStCvz4zkgPCLM4JpKDuQ2tqchkA==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by m0380145.ppops.net (PPS) with ESMTPS id 4eyma1r5g8-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 01:18:48 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XKWswn+zlltu11hoNYnPuOO+cyW0EFKC1YljeDzU3+7cGOoA+cJtRisqIMOe8vomMn3pK8uhEaI16hOpYpzHGRhYXKIbKv44+1FmbWuuhXqn2YMd5zXPiIu+a5Bss41C0mXXNDoeGtNc3WzFwZ6PpXn8YbcUn2FVL1lClE4oVh2XL8RlPgNGwG5TTw7bz7sp4Vao18cJ4FRI2e1adxyy8Ucf6rDrQ7d/f2qXJwgeVJxBpOvL9fZpaqJt90iw00HDEAWnaAyTQSFbHAMretmRATRhUumG6jzr1WzvAOb+DChY94ChUSG5Bm6Bw7vSxWZ/vsVx5Qh2gkURtSFLTq+/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVcLiiYG9/15yeNMkTF1uFFteYr5GEzxlOaieCagaR8=;
 b=Ec9UqKg7I6jcSpOcDb02yynwFGiJZ0a2O5I9lvQO+TQQBfa2gDjsjuR4/QCm7FTiF3DK94hIjk1YowFwoLeelq7YSERKwZDQQH7ANos3Mypbi12D+gVZx9xrP8NKl7iMhkVmBNMeR7x4OEFoMdeVYwIuIUdPO7w7NellGbSxsWxSgAbkWoqdSAjX4LCTEDdO7B36KxuV1556Pevp5WsuwGqxH0dfkVP8XZPID0TvUzsBkjMzVz82KXzzmpNONKGOZgXRNiZ41NK5DP4qcI7acIrUWhTQxHUOgJQeLkXjBFJXKJINdgWSbmrfNRencXr+rho0ZB8epG18f3DwAZPe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVcLiiYG9/15yeNMkTF1uFFteYr5GEzxlOaieCagaR8=;
 b=NkeC90NpJB2bnu+FO5KzJO7GwzMnSh/9h1UI3+AzwjHJC6AYDpxef1g5fyiSmlXLZAinwFVOPTmENSVgMmg5hxW+InBnxhEuDBKlYWDOATzoTxrE8G5nzWVLJPjbi/eXonUK1dxKPXJt7ckful0ppq/qhqQXFcoxUtrvb6QrOYA=
Received: from BLAPR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:335::25)
 by CH0PR10MB5100.namprd10.prod.outlook.com (2603:10b6:610:df::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 06:18:45 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:335:cafe::4e) by BLAPR05CA0045.outlook.office365.com
 (2603:10b6:208:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 06:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 06:18:43 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:08 -0500
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 23 Jun
 2026 01:18:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Tue, 23 Jun 2026 01:18:08 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 65N6I7711632842;
 Tue, 23 Jun 2026 01:18:07 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 0/4] arm: k3: replace tifsstub runtime filter with
 per-state FIT configurations
From: Anshul Dalal <anshuld@ti.com>
To: Aristo Chen <aristo.chen@canonical.com>
CC: <u-boot@lists.denx.de>
In-Reply-To: <20260528132746.719699-1-aristo.chen@canonical.com>
References: <20260528132746.719699-1-aristo.chen@canonical.com>
Date: Tue, 23 Jun 2026 11:48:05 +0530
Message-ID: <178219548550.1317404.12343415781723973660.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782195486; l=546;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=GL2Dajr2bFWE7iBl1FiQh2iuxDLmeQqX+Hr9lsgBtnM=;
 b=2J2PMPDWBRCJ2ckdV0yEi1b99ONvjQs/7vJbc9LED4Yw06xCCOUUpETwPa+3CgfGVUOGIqhey
 OX4gwYXUDXwBPAahyb6bWi0xg5Pn027DXmtbn4Cv+QmciicPpLPM12H
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH0PR10MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bec0b54-bd7e-4796-dc43-08ded0ef46d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|18002099003|56012099006|13003099007|22082099003;
X-Microsoft-Antispam-Message-Info: E6Exnen6FO579BoiJIKQrtu50L+T+8s66IfRoWPXbXGGcdVJq/xKhv7hJNCjOc1F1CpiSHl4DgLC3LQ/SlEW1MTWAl74ETQEEanjy/x4uQIG06esCn2Kxqg/xV0MFWEiYw8rZToulhvfrXuqNEB5QLXgHfnw/qhMEBNhf0ZNbTXEXYpBPbqGju+/ko6oPFqgSE7qesptm4unWPuVs9kL6NcFK0tSF0afdI98UaVySySNSWgbTX2T+8HCitB0SFVQwVXel1LeWHKcyrmFEwJiMeRhPYeEkLVMvL71nKmW4Br3Z4kb9dzM75jhODKx/ajOoVWnkurp3zc3pB1vui3UfAIxEhO+x3zEjraoAD8VqN8Ab8JfAB1ssUw/974+Iw2pQY0OU44ffUBGqkb4dnlMQqq7WKRG3t/b6eKx3LjoRM7KHVKDb4iAXYEKCBRKc4cOKSmd7ZEGNltSzgypOfSvrrwkG3wvo1S4hmG92NCmAlNxfpAG5ZE9OctB3m3uxh3L3PqKtp8vxYxIj0VQjTI5xREyHE3myznl5FKV2aqAAttZBrXHFGayLwiQbZI/RHkdK84ZBVMM1Gp47kHl2Dh0ffwtM1pDX8UfLYq1A8e+axMzU6R/yXdkLQlGgRg7Nr5t1NCBKr0qhiUWpIQCMm7wnWs2a8YrpXVfTSssLxWHuKeCU9IEONDY7v7VvKpS22bSxlIUBsYizvqW/uMNpoNdDA==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099006)(13003099007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TskmTKJEsVESGEnpMGFyoUJFYmAT31Eut2gh5t141+vdqv4Q6XqhPKgV9ysGt7OjVBr/bN8yJun8SCc8o7O/TIc75P1FJKM14KrbmgA9jBvsXRjHbznwFJyZUz+NNdUvTcc0nn8GqD9buCroxkv4JqfH9ElD2T7HEYeCg0qGHX0O/LCL8B5CKq8CvPmWle1Z7ig0qkhXlG6d+chPO1Hht1n43h0E9Qz8g2kn37vb7u0iowifzKE0+WWd6UtmAOtJqeLgVRMmdyln7E2bm1wOY5dYvhYc5eTo5k8CRjKj2w3BarLqfhL7sEEVlIrC4wuelKOMB7dvLGNC3rmSh6b/RA/QQ0PtRjTzAk7/AdRaI5qvaP6uQHdvGnh1whEkJmzhavQBp0VNyC1hteRF4kPrlV7MPDUm0yDiofL6FuwsJc/GUSaQs383xpWRuIJhc77/
X-Exchange-RoutingPolicyChecked: lAyyGgsHopc/JAeS9Qfra6y02OwzwyGKOkqeaVVVxRWDMNdK/GkPtYK0e6nqoV6X2Lek/egb6qS7fANOQj4F9M6aact6fvX4I8pP3fmIQgKj5v/zL00FwFJDDOIecI8WA04fdk3YHFr1sqwoyeDLmfolLapn2Hsujj8A2YE1XafskofzlfR2FWN2ua5iWEF69EIgENXpJ2s9X1PqIRkxHbpRN9e5IKbxw/p1y5QoV+z8q3XMLm9kqKwI9r0SEsBOO5QNXpbhmJuOUGK3Oq/KVGetm8zGObyWjDONm0UYutsRxYnW24CCp/7HJfWpa0PR4o+xmBJSchzboUahgLnKWw==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 06:18:43.5968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bec0b54-bd7e-4796-dc43-08ded0ef46d2
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5100
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfX0Q3yimkSqqc9
 yzknSm4hcXkwdhHN+wNrJgQABBO1hXUwKmIi6rtKxad8ncqJZF/baEBPS/rigYua5DEAmqRTFqg
 ymKLs6mK4kW5emuuouJ9bEAyIIgU8HE=
X-Proofpoint-ORIG-GUID: ue8cuc7SCyEwL3kIR6k10JYPFSXAZnd_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDA0OCBTYWx0ZWRfXx0CH8Uu0R7gb
 92gKQ8tAqZSmmQqdWyxasW4Oe41QLIexf3O0UOh1FN9VUogWJ982VGSudrX3GNboFGpV0hbgr1X
 No9QyAWsFBA37olcexIUS3AC/bnZ8T8J5oGqk4rfnnqxTxUbizpwM5iPa2K2ZGyHLiw5BWf1clL
 WF0wD/3JWz0pUrcAOI3XTKIIwqG/tPNQ4EnLX5GtMRsf09tSJ19BugPv5rqLL+An2Ia8oPGOPee
 88H4ZhIp0wFwTF8nuzNRT6wfDm8MUNsBjKEEr8igecCYfDOvKMmZpyPELjPpFbYy70GrAr+CecS
 Uw5zIwwPlwYjseODmq9i7AiQ5SDJL8d5Qv7U9tz0aU7Wi6Q9ZDvUGkTavGH4sjUiLc+CKkHNy+T
 mfH0oJnnGCs/N7LL1m/qEThTjJmLo7lb7/p03x9jf/Qt4fini2jkKH1sDDnyQ+dsdhWKbcJsU20
 yRjFfcrcRu1ksGNhI/g==
X-Proofpoint-GUID: ue8cuc7SCyEwL3kIR6k10JYPFSXAZnd_
X-Authority-Analysis: v=2.4 cv=WoYb99fv c=1 sm=1 tr=0 ts=6a3a2548 cx=c_pps
 a=t5Pm7pJ6jXSUtateXttj1A==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=pSvGZVZNAAAA:8 a=NEAV23lmAAAA:8
 a=DfNHnWVPAAAA:8 a=sozttTNsAAAA:8 a=B79_Fa6zj4yL_395l6YA:9 a=QEXdDO2ut3YA:10
 a=x5Dd85tUdMkzs_20DnMC:22 a=rjTVMONInIDnV1a_A2c_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_01,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1011
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230048
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

On Thu, 28 May 2026 13:27:09 +0000, Aristo Chen <aristo.chen@canonical.com> wrote:
> [...]
> 
> Testing on HS-FS and HS-SE silicon would be very welcome; I do not
> have either part.
> 
> [1] https://lore.kernel.org/u-boot/20250916122244.a7rda2ouhou47hp7@bryanbrattlof.com/
> [2] https://github.com/open-source-firmware/flat-image-tree/issues/32

Hi Aristo,

Sorry for the belated review, overall the patch series looks good to me but I
have added a few minor comments in the following e-mails.

-- 
Anshul Dalal <anshuld@ti.com>
