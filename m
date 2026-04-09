Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 173BAE98FDC
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 09:44:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BF4B839D5;
	Thu,  9 Apr 2026 11:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EZAsZWug";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4277D83CF5; Thu,  9 Apr 2026 11:44:24 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA0783693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 11:44:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPss73SZgXT5KO5WyTxVYmCAOgsY9fAmxcBf5fm3OTvDVqGNi+SqwhCjbNVpLR+6BG35RzsYk+MoOaLYTNf5aYsANqxPd3aC69ElxUezaEI0C6q5yQAOCbXHSQYaee5B3F/bk1680sUIgzvQ+JCvqRV8RXjh2KmFPzqKwzfRyL7DQRAqS8EOX8Ae2uD6HCzoqdB0BScI0BcfeZf8bFZgXoQ6v0zYfOnKKsLXE2qbcf8+9Oi9SgPXq5fCKZWH+CrDWw+4iZI9Wlji1yBPdMBZzZzQBuQr5GBkoVQe8MC5KSbIwM7JYVyhTZZlSamiUIhIiHuHqhFDJLtyYpmZcg+VvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhFyYWpri8ZI8K5AamZRX0ac3ogdiDhzv/t7A3YDJZI=;
 b=I6OwsWy3gskl4X465PtM/Pbw99MoXQY3KnxvritTStBRYmxuOu4Idle3uXsEU8U1LjkhbcHuKhC2OBlt2wm3b9+sehSTTCnkN4LDd/vhxf1b7Ds/saqToMb4iyzV0PdHGh8N5lh6M6q5kQuZMtY31R04KpDkuI+gfFRJ5PGW4etVUmdfcSYqCeJb9PyYxIxZgBT10Mq//imfvCWbl4W1YLrKPP6/DZB7Uox49YfkVFI8fZKawAlwR9DJM0qjzJtVDmsanovIFuFzXGaTmrE7YgH7AwieTxljXVbBPCittfNm49e+iunc+Lp65M3AtI9HB5QquPoQ0/bzSRXtspqpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=octavosystems.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mhFyYWpri8ZI8K5AamZRX0ac3ogdiDhzv/t7A3YDJZI=;
 b=EZAsZWugtHllwFvjO3tG9or34gbxiMy4UoR/JKFEaBsGPJa/GHoyCXOwwPdPIjJS6Z1jtNH2Njd562eWZda46giadIUX93CW5c6cooek9GK7JNEP1arHNZ30DQq9Ule9xxFPef9VNiBJevobYp1CPtVN39JwaMAPHblUZtMW+to=
Received: from SJ0PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:33a::6)
 by LV3PR10MB7747.namprd10.prod.outlook.com (2603:10b6:408:1b0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 09:44:18 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:a03:33a:cafe::c5) by SJ0PR03CA0001.outlook.office365.com
 (2603:10b6:a03:33a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Thu,
 9 Apr 2026 09:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 9 Apr 2026 09:44:17 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:44:17 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 9 Apr
 2026 04:44:17 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Apr 2026 04:44:17 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6399iGfZ3557355;
 Thu, 9 Apr 2026 04:44:16 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCHv2 2/5] efi_dt_fixup: use fdtdec_get_bool
From: Anshul Dalal <anshuld@ti.com>
To: <rs@ti.com>
CC: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <u-boot@lists.denx.de>
In-Reply-To: <20260402205038.4005350-3-rs@ti.com>
References: <20260402205038.4005350-1-rs@ti.com>
 <20260402205038.4005350-3-rs@ti.com>
Date: Thu, 9 Apr 2026 15:14:13 +0530
Message-ID: <177572785343.597550.9036357051129807578.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775727855; l=359;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=fLqTgCmIFmVy9oWFBkLTTUCJoKbdkVQ3IkxuLvh0ZKw=;
 b=Zuf3ZOZ9KqKorOWPgTUP7eqeimziJh3UQb+dSPuBXHmJmH8AaWIca7tvQiHpipxut+LwtE+G3
 LTPGeigiSCSBo1exmuHDfCWojgLCNMAV78Ua5Ye9wJR90MqpCU6AgUL
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|LV3PR10MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 99baa2d7-9ff2-4a30-0000-08de961c91b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: re5dDiIIrUCEzpdWh8Oc2YVw9HHMnXJwBCijb7cUk7W1fV/RMCGZxWjBWOW+vI9uxMnk6GGkhVNl8jwI6mjiBBQp3PE3dLh1oz3cqnliSyF04zgZfdFp/Dhx6mrx9reFnNZZYMxTvMEqRWdmhiGF0c/80Fr2MPRgH3fyDSYKlyzZEdCJz7jG3cJoDLL+7fA8ZlpVQAVUbKJhErlak8rkBvwWRBFd/qGZDGGU4V8ZSifhZOQpSrj1C6KaXj2qdxkxDaH/gikZDW2tiWyEXELncX/4hYao1r0EAIYffLJvcv2Fd+eSpXZH3Y/D/8VHdwpDdTJetQd4/PSpYe4ZQ7L5tUn01yjWVxQW39ETAyAM0rqEALmvcpJEcNwtdGJITbjYRGrd6w3pupPHIsqdl0zMyXgI/piAl9S7Zyd52/Pqf4VjgXLgC6rY2k89nIn8RB8I1Mv8jBFYrVo2RKxeLnvJcW+WrSblLZ27BrrD/QAjopAaztfsAf5EAAUo65QDnUi0kLzKJXBLx+lPubXFPTO/SYbA4leX7TOEekWIG+QmpTh5S3HOAxwqS9Rr8IIsAN4YMDxB5cT1rTimbPwHWKpl6MlX3iP8lBwlHc8QkkmTQYI4NV9uhdAl0rRfDv0GxMTg/Hgzt3lizMPvpLR2TE0z4+xum3uyyz0cBFOAYEWFCw5C81RTy0RWouqFsUXgqujkgQ0wxzck4COJy3O3ke0LN0HF+Ehx7dHM69KA1iglHfx0j3KQ8hfvRI/BdQjlQw6ki2cGxZ1StkL2zapCePCGGQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TpgXvtjTxSTsi6XxOyiwtV3o1cNOGuDNTSTexFCGmCW7lP/j2jI8qnfV24JmWWHjkAdinfpidXIsXl/pj2tsU5IyY1Cjo0Gyd53qR66jZojQq3UmmwpuMSbWOauUez2D79kZCmp1PsDbLb8A9iyrn4hYO2Ud6RRKJhpef1M0gyAAKQLQhfUc0WpHD4E8CEMe9Eay3qikS6YTKpFVJGLP59MVTXn4JWrMdI+HhWXfdMxTqwt6ZzneqcGOpYw28nO02NslYb7r1grx9RAOQ8m55klSkD7lzYKFlxoMV/0MYlb/7+Y6noFSLrVOJKolor6jJ5p7g//irXn79xSlcLeA5Nygazb2S4uXBKKpZj9QGS3LVUaXjndcxgU+PxSiXeWQh/XoOb/LuxFz2GkDmiFkYHKfWj9VZeqCoJMMnG+3/bzumX/shVuJt0qEw41T0mCF
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 09:44:17.9430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99baa2d7-9ff2-4a30-0000-08de961c91b1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7747
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

On Thu, 02 Apr 2026 15:50:35 -0500, rs@ti.com <rs@ti.com> wrote:
> Use the more straightforward fdtdec_get_bool instead of fdt_getprop and
> a return code check.
> 
> Signed-off-by: Randolph Sapp <rs@ti.com>

This is a good fix even outside the context of the series.

Reviewed-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
