Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63274C44529
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 20:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1110A60704;
	Mon, 20 Jul 2026 20:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 63gPUFx9RKye; Mon, 20 Jul 2026 20:30:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 452B66070C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784579458;
	bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
	h=To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=fsJ//eYASsY4zlKdpKt3c9dFg4g9CULXZeRP9Y6zbACZtSJlYwNpN+wCjzl8cYbHK
	 SiOXoyvKYtUafoS+6ubMLvrtgyoj17/Q50MkX8NzoVsjtL/2ug8CEGyQcrU+CU6Jiv
	 jWTQUOkSmHuP9fnOu4wJaDdc2Ex9du87xGpNB5OQwqDntQZfol82cseOdMpuUlcYpA
	 eKwFEh+xIkq2+QJ20hotMmPnrgGfwBWd9ASVksAqpigBPo388E2Ihla9RAG6as2QtY
	 nUAoZro8RJj+E0haIeWTOM9Wb2/xYNHgli8mszuh9w1waHuYYgOjK2HqehBVkCfhcK
	 Rt6IABGEgkp9Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 452B66070C;
	Mon, 20 Jul 2026 20:30:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C35E5786
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:30:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B54196070C
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:30:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u8pZcPj5Pvsf for <u-boot@lists.u-boot-project.org>;
 Mon, 20 Jul 2026 20:30:57 +0000 (UTC)
X-Greylist: delayed 808 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 20 Jul 2026 20:30:56 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9A13E60704
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A13E60704
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=rs@ti.com; receiver=<UNKNOWN> 
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9A13E60704
 for <u-boot@lists.u-boot-project.org>; Mon, 20 Jul 2026 20:30:56 +0000 (UTC)
Received: from pps.filterd (m0384305.ppops.net [127.0.0.1])
 by m0384305.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 66KJQ7XH1098856;
 Mon, 20 Jul 2026 15:17:18 -0500
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11011029.outbound.protection.outlook.com [40.107.208.29])
 by m0384305.ppops.net (PPS) with ESMTPS id 4fhk0y3cfr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 15:17:18 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OU4lFAbLbYNjLpotL5kPYu9cvP8sywEBGLI0EcP9A9UsFTNbxGOsPrNJDtZym6HN9avelUJ5grknY96dnUTTXqoYCj4nx9zWp3SI7lBMjPuC91EQWEDHY9Wb+PILP+llMHgZNjPvwcgb8MtKnFNlnf3LrcabWuqP7WvT2GGS7mOMlH2YTSn0dd7SkL/KLjwsA24sGSYsn94R2XQ/SjruVmrV729QAXnEgtLq5Hh+6VvOorTBQ4773cnqWZ+cx3r2UzmbkHfIlM8xdZeSil+VwofitrwlhzN1RVB7N2bDssdSZzEx6CtSK1urWXzjQB12W1kVvM7SvCD0+r1QGx6jrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=JOHdr0lMh1mn8S1D98XXOdKDBV+HNoevoisqtfnKFxAEy9590xTsjVxsRBYHFbDGi+gr7J04LUbtewUS3JOcw5VWwiY/cvQ7lMQeJovieIXh71HMJZo0VD3HRZHp3WeLgVVPwkSJPYDtpvaZauawMTlQ1hvY9bxvuBp8GI7I1K5LOkV5kXd0GHWwRgFyKZcaJQSdR+jbXEcADzz8CQrEBa2rVwaO/1bmHpS6f9Fyomuym4Tun8YTWIJ6cuqjvHvms327reXbN94LwU8L1aDCnaWY8Id8W/a44a1kLVhQhjema2ikQgwna1qy8zNG6E18UCVcooYCF7sREHLp7dZuHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by SJ5PPF0BB87A13E.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::78a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 20:17:10 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:338:cafe::97) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 20:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 20:17:10 +0000
Received: from DLEE215.ent.ti.com (157.170.170.118) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE215.ent.ti.com
 (157.170.170.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 20 Jul
 2026 15:17:09 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 20 Jul 2026 15:17:09 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 66KKH96J3202983;
 Mon, 20 Jul 2026 15:17:09 -0500
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: <u-boot@lists.u-boot-project.org>
Subject: [PATCHv4 3/3] k3-am62-pocketbeagle2: add support for efi capsules
Date: Mon, 20 Jul 2026 15:16:19 -0500
Message-ID: <20260720201618.3863938-5-rs@ti.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720201618.3863938-2-rs@ti.com>
References: <20260720201618.3863938-2-rs@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SJ5PPF0BB87A13E:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e599ad-ac3a-41f9-effe-08dee69be126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|10067099003|56012099006|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sl64CDmTQw5MDV6WwqBlOxM+Pc7X6x43RBybQuIBEm2QVoHk1zSJn7g22Ol8zMJAJOXY94PrM6b1VNPxnv+4czm6dEg02d31GBct6GAfdeUqzdAjJnLP70BZaR6n9zU1W1Zec2DOvTxQP1irZNtUvWVhNT1p2WZdwcCCFaPSM0jbJl6/vx0t0Uyw2caLj3Le0jYI0aal7pMeZvB9t4GXhPYewa1llYxnGgz2WOrK0+Sv84iA6rKjyi66KdunnUBYMpp8tmP0SuHvhMZYj3WZrdn/1wUZrQNEOAWOq91XO/+G8wVbz502giS8j8vGejc9/OeTEfc6Tr+Yz2ID8PRK00jZfXieIwQJgwf6LnnNcGrsG7WNYVi4nuEdEiIe0dLL/Ciz2NVbIqJqNP7KdxedO+czCKZifwl+rm9zyo/9X8N8hZwPM1pUgFezx2SssvScIX9stixCI39Nmu+jI3Z5kMavw/2VWN7da/D5jWcsgXdgcQiO2M+NGfSpnwclP18F6xw0iDztUCzEZMFlqRt2JsW1hcfk5D1NFrAYAvEE1UUkxKHsVsbt+GG6508YvAkqSlGRLP4duZNH9KAbqxNGPlnDUvvVDmjAJ7V7swuZKHYv357uUGQCeCCaCJCffopzkPRP3AwB+KCSv5cXVRprWGi3DgSTsomSXP24GMGDFU6cpK/Z2B1BUi91ph8W9akoZB+An4mDw8RV0pgiw8TNLfttwVTkIn2W5Sy7rktFhGj8LPY52x6Jzf1F/63x5Afy
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(10067099003)(56012099006)(921020)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /kdbwmXrtoLTiTJLHoLdx3pZrv4HlPH9I+M7mzKBWqrTeOdcIO2sw8JX82VgB+tTl9ae+EeRps/+oHaxcbRk0sycyChqlGlv+9phf/vjL97qMOoF8dn542sZaj15uiN3vKkNX3C5OEFWNz9kRcD3buMu4QP5yPxu6OqN5ks0/njeoRq1hLh2wd9sL9ZfoWy9uvf0vX7Bgw6ZhMRRAQdzIif34rtSrUJd4hNwAzZRhzuqwIBQ7stMO5cn6CPudDw+zBZCXm8hT3Gnu+tepjAkJRyfoCplb7KRBdjgTsckZEVEs6Xwrm4/dQdQODv8I039VK19ScfvF0dvEvqe//k22qDIrCIHr8O3euZaWJSSuqA/OKC3ZWCFYz3UgpigCOfeLbKQS2hB9V65zdnIHQKSpJgrbGdRQ+3w53W1gEMvT/o+h0ZwIRSij+l6P4z1RoVk
X-Exchange-RoutingPolicyChecked: VXfdjQml5Fsyev1jTjgy03PxzpHoXYFu3B45Qevmra9PaCGNdIwcFs7LyPm5OOp5L41P4f2cJf68t1DU0dbPQ/Txs7QCej4UC5T+g/xdBmnI4D7pJZAmMePk28fzf9NGYlP5Bmw9Vjsopov4JJtwItCQzJfWHShSddw07wxXIJN7GlZwLBKgyRv5whwBi18yrAya8AProNHIpTmMGQaf9nspQXLAe2m6aPIDNJQ3EMC0ovZPbsu1bJQYPHPLqVe5Swla6MG6v4PrZJFIFMFLdeM3ZviwXcW1no7xuR6bvaSHEbcBuqKAsF71PduIk4P8UDy18dT+tn6Dhg4EC7EO1w==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 20:17:10.3620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e599ad-ac3a-41f9-effe-08dee69be126
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0BB87A13E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfXy0xaQZyIA9kf
 MlRhNDCY100tRuXgAiMjsVSPrdgW9uTajHu/UkhoPLRBZ0PlFLzO/X04B2YhQHxSpEF4tYdfliI
 t7fEGQ6aN9uSxwnydNsC988m7P0PYY1YOzMrQj7QXJNbc43SlG68JI0ORKF7IuE5uwCCAL060TU
 4q4Zoqjs2m6eyAFujUqONZuaRsm5TrXTv4NIqebT7eqPy5XNDoac8taYnCoOnAn5Gw5dKdZx8Yy
 BV2pufbOPDla6mne6OY09sKtEa2h14X78qT1Kg3/f+UHiGxun2n0Lheo6SWh0tPlZgpJp/7aXUI
 5le9FHeF75JAmlGD7CW38vcpWIQAHNGA9Z/v1Mx8+QmCrEVbYnEF1zp+KpteGhDjPJs5Ts/qypw
 +pECMKwXJI2Tf4rYwTbCFMIyDoppkqb7+gGfdoruK6Cbiqx85t9ky8v85QaufgY2/MWhaY9Ivin
 b1QfKJHQYtmL8VuWeKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIyMSBTYWx0ZWRfX+RzEl4Joxs5h
 gdTL3lQllvXsABVyvTujqGS8OGc06flj86CqbTz8JicbZF/dZua6lklo9C0Cz0ktEgagnjii9sr
 TYyuKwyrOmN12JuBYSKmaHsWORcpyWI=
X-Proofpoint-ORIG-GUID: -z_vgpRcVlV9rwxfbIbXO7bxHk6GZYr6
X-Proofpoint-GUID: -z_vgpRcVlV9rwxfbIbXO7bxHk6GZYr6
X-Authority-Analysis: v=2.4 cv=J8KaKgnS c=1 sm=1 tr=0 ts=6a5e824e cx=c_pps
 a=WFfob/tpvpsU+KY5JpTU8Q==:117 a=f+v6EHfkeJbVwR46tk4DMg==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=RAioF0-LDSMA:10 a=s63m1ICgrNkA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=taLDd7a_hP9WKsMzeGRc:22 a=sozttTNsAAAA:8 a=fGhLjsSNAAAA:8
 a=496d86qWRiBu538VFjQA:9 a=LYKFdyShAPKLkGq8p7WX:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_05,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 spamscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200221
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK
 5Q=; b=Ge1wkhPmRQIHdh4PIlD8WHUTEF6z2UaeReZJ28cW3B66IrhOOtMxZdlBO
 d6/Xvi5mJL96S2HJ/Ro6KCAdk2VrXclBb5eNo6fkxDkppvLikKKnkAk1KlyWqduS
 jx+lcX7Pz3pMssx9T2z6t+MYA6dj3Tb08CHsPeFLQV6zwVH4ysoMjJItR8RO3PaS
 Z5BkseK30a1PjBkg4WJju0ja3yrY3IL8pL78u/j/hxmIezRRS9AjH2hR8gU/N6yn
 ddejkVDN2ki9LDatdYv+GKaKeAEJ3bjOxuylSjufdz1eSqFDajil3qaHADpGGKnb
 Swzn0gDBd76ajenWtu0F3SSawKgcw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ti.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aumTO0fdzpQGgtMmsiQgBQmZuY0sHraVxIMWhp6xK5Q=;
 b=OO+zA6KTTSNrsiaUFxXS/jFX9WD4yPIXFACuXuBcMlq5ywxnIspq62hDDKyUrBLBDAVu8bCrdiv6vEFH6FnXnTW5q14uIIqDSKl8msD5HiPhQXXXvh8qGsrGoUdiX6nP2sNxdDn6fcTCDtqRt/9UNF3sJ4C86/AFVtIwYhjVewU=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=ti.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ge1wkhPm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=OO+zA6KT
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Randolph Sapp via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: rs@ti.com
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Randolph Sapp <rs@ti.com>

Add support for EFI capsules for this device. One large caveat is that
the partition holding boot binaries cannot be the ESP partition due to
the following ROM limitations.

- The boot disk must be MBR
- The boot partition must be labeled 0x0c with a boot flag

A separate ESP partition should be provided for EFI capabilities.

Signed-off-by: Randolph Sapp <rs@ti.com>
---
v3:
	- Remove unnecessary dfu_alt_info_ram variable
---
 .../arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi | 29 +++++++++++++++++++
 board/beagle/pocketbeagle2/pocketbeagle2.c    | 26 +++++++++++++++++
 configs/am62_pocketbeagle2_a53_defconfig      |  1 +
 include/configs/pocketbeagle2.h               | 25 ++++++++++++++++
 4 files changed, 81 insertions(+)

diff --git a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
index 452161115318..283e26380e48 100644
--- a/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
+++ b/arch/arm/dts/k3-am62-pocketbeagle2-u-boot.dtsi
@@ -181,6 +181,17 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule-r5.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR "F0D53723-106E-5346-8A41-85EB2D07C720"
+
+&capsule_tiboot3 {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_R5_POCKETBEAGLE2 */
 
 #if IS_ENABLED(CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2)
@@ -304,4 +315,22 @@
 		};
 	};
 };
+
+#include "k3-binman-capsule.dtsi"
+
+// Capsule update GUIDs in string form. See pocketbeagle2.h
+#define POCKETBEAGLE2_SPL_IMAGE_GUID_STR "C73FDEA2-3964-58C8-8A25-E55102172E1D"
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR "520E1012-DE6C-5992-B43A-95D53D8332F2"
+
+&capsule_tispl {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_SPL_IMAGE_GUID_STR;
+	};
+};
+
+&capsule_uboot {
+	efi-capsule {
+		image-guid = POCKETBEAGLE2_UBOOT_IMAGE_GUID_STR;
+	};
+};
 #endif /* CONFIG_TARGET_AM62X_A53_POCKETBEAGLE2 */
diff --git a/board/beagle/pocketbeagle2/pocketbeagle2.c b/board/beagle/pocketbeagle2/pocketbeagle2.c
index 291a1c6c3db7..acc694c253ea 100644
--- a/board/beagle/pocketbeagle2/pocketbeagle2.c
+++ b/board/beagle/pocketbeagle2/pocketbeagle2.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2025 Robert Nelson, BeagleBoard.org Foundation
  */
 
+#include <efi_loader.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
@@ -19,6 +20,31 @@
 
 DECLARE_GLOBAL_DATA_PTR;
 
+struct efi_fw_image fw_images[] = {
+	{
+		.image_type_id = POCKETBEAGLE2_TIBOOT3_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_TIBOOT3",
+		.image_index = 1,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_SPL_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_SPL",
+		.image_index = 2,
+	},
+	{
+		.image_type_id = POCKETBEAGLE2_UBOOT_IMAGE_GUID,
+		.fw_name = u"POCKETBEAGLE2_UBOOT",
+		.image_index = 3,
+	}
+};
+
+struct efi_capsule_update_info update_info = {
+	.dfu_string = "mmc 1=tiboot3.bin fat 1 1;"
+		      "tispl.bin fat 1 1;u-boot.img fat 1 1",
+	.num_images = ARRAY_SIZE(fw_images),
+	.images = fw_images,
+};
+
 int dram_init(void)
 {
 	return fdtdec_setup_mem_size_base();
diff --git a/configs/am62_pocketbeagle2_a53_defconfig b/configs/am62_pocketbeagle2_a53_defconfig
index 8964cb3b1955..7428926a8ba6 100644
--- a/configs/am62_pocketbeagle2_a53_defconfig
+++ b/configs/am62_pocketbeagle2_a53_defconfig
@@ -122,3 +122,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
 CONFIG_LZO=y
 
 #include <configs/am62x_a53_usbdfu.config>
+#include <configs/k3_efi_capsule.config>
diff --git a/include/configs/pocketbeagle2.h b/include/configs/pocketbeagle2.h
index dd6956aa8b90..aed60d325742 100644
--- a/include/configs/pocketbeagle2.h
+++ b/include/configs/pocketbeagle2.h
@@ -8,6 +8,31 @@
 #ifndef __CONFIG_POCKETBEAGLE2_H
 #define __CONFIG_POCKETBEAGLE2_H
 
+/**
+ * define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID - firmware GUID for PocketBeagle 2
+ *                                           tiboot3.bin
+ * define POCKETBEAGLE2_SPL_IMAGE_GUID     - firmware GUID for PocketBeagle 2 SPL
+ * define POCKETBEAGLE2_UBOOT_IMAGE_GUID   - firmware GUID for PocketBeagle 2 UBOOT
+ *
+ * These GUIDs are used in capsules updates to identify the corresponding
+ * firmware object.
+ *
+ * Board developers using this as a starting reference should
+ * define their own GUIDs to ensure that firmware repositories (like
+ * LVFS) do not confuse them.
+ */
+#define POCKETBEAGLE2_TIBOOT3_IMAGE_GUID                                   \
+	EFI_GUID(0xF0D53723, 0x106E, 0x5346, 0x8A, 0x41, 0x85, 0xEB, 0x2D, \
+		 0x07, 0xC7, 0x20)
+
+#define POCKETBEAGLE2_SPL_IMAGE_GUID                                       \
+	EFI_GUID(0xC73FDEA2, 0x3964, 0x58C8, 0x8A, 0x25, 0xE5, 0x51, 0x02, \
+		 0x17, 0x2E, 0x1D)
+
+#define POCKETBEAGLE2_UBOOT_IMAGE_GUID                                     \
+	EFI_GUID(0x520E1012, 0xDE6C, 0x5992, 0xB4, 0x3A, 0x95, 0xD5, 0x3D, \
+		 0x83, 0x32, 0xF2)
+
 /* Now for the remaining common defines */
 #include <configs/ti_armv7_common.h>
 
-- 
2.55.0

