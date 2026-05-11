Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B60CD37B5
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 10:05:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53492846C7;
	Mon, 11 May 2026 12:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="jcEjtcsp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B979E846CA; Mon, 11 May 2026 12:05:37 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 90878846C3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:05:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpcOvHyh8Opw3Fy+y3JTHfPCmY6r88viQ76Rb6cHYXUhxj9IZuheu7MSPn9StBvSy0mL3zT3MAnSFMqXEhiEdz/TiOrm1tqZQxReacAQ1SXC6qMa3JUlYqhh94oyb8v80+YRW2qZ6WaRZYsftejwMl8vCX2Nk9cwEka/si2hSq3gFN7vh805XJjhP4hPAKO9swPkwEwRr6DQuQVm2ZtTCDJGXOdFhaIjypgf3BchrijPucS6sqk/IE8dfMFo29Hxf55DxGJtnuJ8NfLJqpr8OzhwHOwKqvYZup6FUopFSMAX2PJf0qPwBCWNNh99ffYVdpTEYkI47Yjz3Wubm2oidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0ciGeaZ6aPzdBX+D7lxIir/wY4jYe9YfwHiCAtauCc=;
 b=Jx226314rN1XD1sp1bHxKWTBNEOYe9WgryxxtaTrepcblOaeu5Vq6+AT3itnHOwxBtrCLVQsJqBRWQLnjkhomfbRD+g+u2UWNyPlYJMl5puyk9855pJEw0skHurxjZWn0DqrYIf1WDaCfPuCtFSQBwGDAb1eZUBfNX0h5HpyEiHM/2HTLKyArv81IGjMZ4yFvb3sDHcRobwy6TW98/WI3HRxisx/ULRGIMUx4AgoxjJmKorksZlbQJxxVvJEaunW3pheXKPQW62M6RzEXKamIWJ6kbCvk/Pf1DbZ5aQ4OXMzPD/9ajtWPG1RSC/61wwVTP57sA6vbJ57Uq3Lf6+PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=toradex.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0ciGeaZ6aPzdBX+D7lxIir/wY4jYe9YfwHiCAtauCc=;
 b=jcEjtcspFpNaJveWX0hUy4iBsN7Zy6JK0Hu4VHvyNZSYbyxt1VgJfE5VgLt/U4c257TSAfEatYIDDimZA/pSSU4stiC0/IZBgD8FkoP66bsvSZR73NemvwgJ7t95gobB7oWUEBnyDi9cq1vkbPzdgDWJVjYHMxBLF9ftKlaF2Es=
Received: from BN1PR14CA0015.namprd14.prod.outlook.com (2603:10b6:408:e3::20)
 by SJ1PR10MB6002.namprd10.prod.outlook.com (2603:10b6:a03:45f::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Mon, 11 May
 2026 10:05:32 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:e3:cafe::82) by BN1PR14CA0015.outlook.office365.com
 (2603:10b6:408:e3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Mon,
 11 May 2026 10:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Mon, 11 May 2026 10:05:29 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:05:29 -0500
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Mon, 11 May
 2026 05:05:28 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Mon, 11 May 2026 05:05:28 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64BA5PdO3134170;
 Mon, 11 May 2026 05:05:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] board: toradex: k3: Sync rm-cfg with TIFS
 v12.00.00 firmware
From: Neha Malcom Francis <n-francis@ti.com>
To: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
CC: <u-boot@lists.denx.de>, Sparsh Kumar <sparsh-kumar@ti.com>, Tom Rini
 <trini@konsulko.com>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 Vitor Soares <vitor.soares@toradex.com>, Neha Malcom Francis
 <n-francis@ti.com>, Franz Schnyder <franz.schnyder@toradex.com>, "Emanuele
 Ghidoli" <emanuele.ghidoli@toradex.com>, Bryan Brattlof <bb@ti.com>, "Ernest
 Van Hoecke" <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
References: <20260508-v1-update-rm-cfg-v1-0-ec9d033f8ec1@toradex.com>
Date: Mon, 11 May 2026 15:35:19 +0530
Message-ID: <177849391957.1452947.3072701683767310378.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778493925; l=684;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=6Qfaf6ED0pxUmPYYT/32hqRCQ1es1iwGtwKA+A0yjj8=;
 b=i1rC+uHTuBOs8gU44L/VD3gR2uVNMGi1DpuTNs2c11HNUtCp7lPTtuIYXKPpkRDDysdnx9hj3
 Il8yUYqjr+7C1boRCFsr3VFZVpeyMMrGRWt95ZlAJU6CsC+vJUrFxMS
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SJ1PR10MB6002:EE_
X-MS-Office365-Filtering-Correlation-Id: 54d03347-7fbe-4801-26f4-08deaf44d4cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: gZXGjotMVU3QYgzm/OY6Fp5WvBdJrnehQQwMnFwh0fPUxuPCmRq8x0S/eFQCArEuXQjh3QCH4QhrA1DhfX2VB8vEa9lJaFq/UTpVTSpBs1Bp2F159U+0C3Km4MJIODjtgLfiYeqsGtr6Kto9GbLm3+iKDIBkvoBLmJUzej/F+HyumzJp7mMQasNhoNCSpJFaCg/q+2K1cuKuxASZWbRxQkeIz6St3rSjr5iCoavXlcs6W2rKtelc5gPpgo+Q6WjosyXodn2gomsAh0eOY2vuaNDg4doo4dwe0xmip0y5XZDDSkCyD1sQOwMV196t1Kh38+KjNZpvqjAF93lKSfqcZXlK+HkbnAEz2qEnY0DM7/f8hljVqoy3hMe9r/n6cQJ+wfOq7JSPbXWz6a4LQ/tX0HaTZk3Pt2fW9klIkSusuaDrXEBFQ4GRRFyKm0gmyqn2ivTpfbBRCj4rJAxjnvP+kJxRpCHwpWS/reOvsr2iPrcx6Uox7yjXag6qx+0I0JJvcSTC2CREqF/wuIR+Hn2b/0OoKEmdhutXtOpNsHGj5IcPof+FLphwRrcCb/W4ANURY2gVzJmYuHzDO+N+ek3ut1LGiPBGlpppvO9m5NyXdS5G3awqbifJbsF59FAjYkNbUx393a9Am54QLQvTaIBkFYkiFJBUSikdDVHhGq7B8Ealjf3aftWexkbjRsduT5T7hu47hXH750xQDk5NLNXntnDc8i0nYLTaE/wbBSQ4tQw=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S3ocNAl0ZmslxZLhf8GfUZF26hZOySU5xtO6l2gX//P89Q3AQzJdFqR7oI69fuwxG26GIDx/aklJm6jEXUYC8u1P0khLrNUJD59XXkszeqzmOUhKbTW20pQJi1H/GTAsraE7Rd2ahQVInGENCJHr4IvganD79lw1cCpP0XCBCrmuBFtDYvZ47Vap4DGioR+F8LyKjn0xBTzeebJxaga4oC1m9YyuhkY95z10u9xeLVL4A/4bhIl1cM3eUzY4Xl9fT2ba44IhTraH1wM3YizTcdPUrBWfXNX0lw6e4BJSiuOPstOtIE7zmIa+/V3y1/RTwheTUzEGrDQaLRWjv0+2AGR0SdhNt8ugkb86eSuWn+VsbXBwA1KQD/m82laPY5OfrAMj09fjwIHi2AtQv2mBd48dxLn+MBx4BP/nWFP98k+6olUkyMcy1+De2V0wwzms
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 10:05:29.4719 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54d03347-7fbe-4801-26f4-08deaf44d4cc
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB6002
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

On Fri, 08 May 2026 10:52:08 +0200, Ernest Van Hoecke <ernestvanhoecke@gmail.com> wrote:
> board: toradex: k3: Sync rm-cfg with TIFS v12.00.00 firmware
> 
> This series updates the Resource Management configuration for Toradex
> K3-based boards and makes sure the TIFS-specific RM configuration is
> used where applicable.
> 
> For Verdin AM62P, the tifs-rm-cfg.yaml file is refreshed with
> k3-resource-partition V12.00.00 so that it stays in sync with the
> existing rm-cfg.yaml update for the v11.02.09 and v12.00.00 TIFS
> firmware resource reservation.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
