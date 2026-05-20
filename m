Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E884CD4F3C
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 08:46:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6ECB8460E;
	Wed, 20 May 2026 10:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Rn5Xzj6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3514D8467A; Wed, 20 May 2026 10:46:10 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16B02844CF
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 10:46:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbIMvUO9LAbcchBz9oRdtPf6hyWTrz7zYQq+SVFedl+rXBn6Bl9e/fyJCoJXZidDcHEUzlDVLtJCm3tQDVkGHZL7Z2bbvdErguJ+x43n5KCaz8k5d11bVfAZZqKabU0oGmqVKlyMd0aONBSv9zJ1Z1ulngSVHYyQFxi7l2UOaoPIDTGl63n+9qa6mGha26YHtlsPGWwrM+MeMvGKwphILnx44Gi9REJqqKcIDsJYr496bE1taW8u4YBVt17bVA9IOPa/5O38zs30aYEDwifBKxKVdx5ArF3dr38owCC12C36/e5O83myNMLZhCk3xu5yjzTJmJPygRzwLfrGsQoo0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sYBVSUdRropGmSryOfGuLhJJswrYUSNHiXRX9eFPY3w=;
 b=BP6Ow232DQHjwfAcyIUVl77heoBGoPVogBpH4H3qJvIkxFuScnzwvORURmju6Nqwn21D0e8yUCC+Xd1LJzZ8XyUU27p8UL/WsmSjLl45CTehsCgCzmPwVkHabiuUzyQjekLZqHxM/bTDCGaJbwjuIxx0xzem3P4a1a7idNoZ+GuHXMi499nP6WH+5KrKiyuseaF9GUzMgy28DeotdHY18/037Sgw7NPFZqhQka3p4eaEh8jsEDE6mVBCjhOosCXReGW5vbDY4TPmM4Z0UuGL6Xk4XncM2HAT76vspfRXtdHcJAqd9j92l3ZgG9kXgTQsMKuqSs8c20ecUQ8dxoTlqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYBVSUdRropGmSryOfGuLhJJswrYUSNHiXRX9eFPY3w=;
 b=Rn5Xzj6LaZ9viwBNXnFhTUBVeOTTxXaa44TOM+KV6j+w6Xz7rJOJhfqCn+jZE0m9cyNB+Ed2B3A8xALVZSueQkiJyaOeRuM4mrfVfmfVmU/klQ/aWCfs4mpubt18QeXuD9FMoGNIwWvFuir+KYl88Ro1yGdCrGGXRBZd2kJVljM=
Received: from IA4P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::7)
 by SN7PR10MB6473.namprd10.prod.outlook.com (2603:10b6:806:2a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 08:46:04 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::9d) by IA4P221CA0003.outlook.office365.com
 (2603:10b6:208:559::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 08:46:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 08:46:03 +0000
Received: from DLEE212.ent.ti.com (157.170.170.114) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:46:03 -0500
Received: from DLEE214.ent.ti.com (157.170.170.117) by DLEE212.ent.ti.com
 (157.170.170.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 20 May
 2026 03:46:03 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37 via Frontend
 Transport; Wed, 20 May 2026 03:46:03 -0500
Received: from [127.0.1.1]
 (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.50.71])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 64K8k0Lp1105920;
 Wed, 20 May 2026 03:46:00 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] Enable splashscreen functionality on AM62X
From: Neha Malcom Francis <n-francis@ti.com>
To: Swamil Jain <s-jain1@ti.com>
CC: <bb@ti.com>, <trini@konsulko.com>, <devarsht@ti.com>, <anshuld@ti.com>,
 <praneeth@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>
In-Reply-To: <20260519141716.1346635-1-s-jain1@ti.com>
References: <20260519141716.1346635-1-s-jain1@ti.com>
Date: Wed, 20 May 2026 14:15:57 +0530
Message-ID: <177926675731.47734.4060047547480927.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779266760; l=868;
 i=n-francis@ti.com; s=20260428; h=from:subject:message-id;
 bh=aw2K/2lmH8UmidMAyZDTiutpNC/hZ1fpvrm8e4h15Uk=;
 b=d8HPLqnRGv+PRZGkCD4JZ78Ayvxxzx7ploaTic29ETzoo5JixttUnwcHByiPPhpiNLL+8kCPs
 Fh77LiWTvIRCc8i0W0hpIwfr/YlX0NTbrGgbWeYIF0S9Pwpy2YQQKAa
X-Developer-Key: i=n-francis@ti.com; a=ed25519;
 pk=Z4nV5FmpAM9e1Jk0HnCKOoVUtHW8cscgDRncr2IngXg=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SN7PR10MB6473:EE_
X-MS-Office365-Filtering-Correlation-Id: 3064362f-28b1-46e1-4b81-08deb64c39ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: N8hOqAUySkJTX3hObOKEbN7+2c2nByVhZPXDWHxxb6EzsEse3jjrWlm8BCIXsFsfBu2wy3epzwgb8JChhr0+rpYvrkxa4BlEoqJU8gqUc1TAMRTSw2WrZLY8VcAOTwec2J89FKFBS58qTum813bVryOIwPWq5NQSVeL0LeYfb6bNpm1AoxGTyIK4BC7qKdy4xvDhlWVorqy5f395iZD3eQ3tEmuvdlGEE/KjZvNjZT0nfTV8s6rfJnYKkSZS4I3PHE09PTVp5vytnQ834MwJrWeNsvKAq3/GBrkaFQ3u7VA0Uj8UeI8GYL17iIqwoE4OdGjv1udYE4/CnN/dIenXkdslhZshXvB+lq4lcHQLjCJ44kEU930dAZy4ZkK52L0Rwv07iCgTgxYDijCK6YfSu9W592WNsgItU8uf6kQy3RyU4/2Q1F0ezjVr5efHpsDVXZBEIr6R5lvCmbJzvos0ZN/sVCft6uzmhf+BEhirwJ1LeLHWO4dXSZlzR5LLGKXUgA0ha+QlCKbheS1uYwf8GYs1UdYsItuyQt9MdcVL3b2r+z0jGS3qZsn0gLyoVUEEsFuIc8IFJN82wl06PL40V8Xb4hC6LkDX41ZRt7ZfLF9jNNDVd1I8GUuxjGWBGr7N86JDKPpVDGlGa17eUO+vA04Uk645yXCgmwGIdf9r9OC86r1845mkzrK7tIcFKhY0KpSsQrBUwgrFtaCtSphJ8o6fm3jfVEGdCg4MGyl1VWI=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iw+FMe56H/0VO/6BLEJH5AAygfnYJ+T7+cgPRzn3Ed9BG+GENvmE+N0VxsSOs6xjGFgQ3NRPTImPKFyl9O0fik0xC2gNgNiXn5zHyUJM/843WkuxEY+Hl+eRXvcPU0+m5+ZY8l9/vqOLYP96kRTZfr5iRx/7N7V1ScCHGXLmLTukphFnJ8UcDhnJ4/IFG48el7tsLf3hSBPOGbIi+fS+uz5bFl7aa3zQFOywg12izwmqM7QivHc/Joj6iS0RPO1gK6DfogCHh+5xdp6F7814oak6bLwYTAD0x7hoYFvHt8WYDrSh6LO+qd/8wtpeQ7fci6BS4ZpMoIPtoyRrNIiqw4J5MmHjM/zzPRuYCBB1rRYEmhAkhkv6eKtE27fWc6PJtfp/gU4wA+/5tPdqxOy53aJPDgr/zfRRIvfB3YucUp8qUM2oehoymkRuoJU/p4py
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 08:46:03.7329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3064362f-28b1-46e1-4b81-08deb64c39ea
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6473
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

On Tue, 19 May 2026 19:47:12 +0530, Swamil Jain <s-jain1@ti.com> wrote:
> Enable splashscreen functionality on AM62X
> 
> This patch series introduces splashscreen support for
> AM62x platforms by adding configuration fragments and implementing
> selective splashscreen enablement across different boot configurations.
> 
> The series adds two configuration fragments: am62x_a53_splashscreen.config
> and am62x_evm_prune_splashscreen.config. These fragments allow platforms
> to selectively enable or disable splashscreen functionality based on
> their specific requirements. The prune fragment is particularly useful
> for platforms like AM62P where splashscreen must be disabled when using
> TI-DM firmware with display sharing features.
> 
> [...]

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Neha Malcom Francis <n-francis@ti.com>
