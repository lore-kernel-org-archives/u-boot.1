Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D466E9E2E7
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 11:13:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8085582BF2;
	Wed, 11 Feb 2026 12:13:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="EoyBWESK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B45B83015; Wed, 11 Feb 2026 12:13:51 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BAC680050
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 12:13:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-joshi@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqjXilz65KyvYjJUB+/HN+08QpUD05RmQGL8dvm73DKAD167Pj87+2e2v+BjOEor04k2jz+ZVNJ2Qso5wJ0r2KZdZQ2tqiV5BuO6DSuLF87jHCLqTrN1F/n3LSdzLPT25I9ph9uZlFLdUhyxXKA5jTStU+Rz/CVwqfMid8Iyug2jIJaA4qvgJ8PxqiE8l+NGh8ujs+Z7YGJH2+KgMgJNtkfOi0DACCHQK7esg+4gDohVa6cduZA1j3Qa93b6bJljBqziG2HkS8efCYsPZSuMfH1tyv+IwcUf6YLMqsyKG1HwYKKiZgjGTR6IebN/v1pvmae7Ao2uF+E4ROc6EfRicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjNNwhvFk49zMYrzxUXAGCTtRBhQ7onY95SifbOyj1U=;
 b=M6/4vhPOW1TVT+zpj/BwajoC6GjAlgRxNlfWCZpxxUnrUt+5uL7nUvWoaKbClmw1a8DcEU+ObAg0t6ur3WoaGxT2IuXa3y9kO2G+EcFZNwmyiM1xePUfRH1wQqqdiK8tUYEbcONTDjlkltHijhiMBFqDv1XUJqoJ8xePZlAzzVcrZcEg2skgTNFAi3Eru3mXCGt42jpx8+dggrY8fcZk9AZ9zTTbzfWe7+7oYvqErUo9Y7OCb174Q9h2oH/DTpa13vi8RrOGU+vKcuRBAcU24ySR0rZ5Zqw/UrW8nikStV/nwQWVck3VSR7tWzJT+POwqR0axiPa3b+SEGBa4J7V1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjNNwhvFk49zMYrzxUXAGCTtRBhQ7onY95SifbOyj1U=;
 b=EoyBWESKsNIA+cjSNW1u1DgiP2gDDUXUGzHGpNh69LdAq2EEXal3MBXlNGaU8yaXNtTCnp6n56YWQK7YrVEAUc7NQAxTcvG/RxGzZgugeFP7QUbvl53Oc3+9dVpQrY6ncsvjRj09wXE9iNEo4dcRSMQH08/Iv4/nJjzdEUJkGjY=
Received: from DM6PR11CA0054.namprd11.prod.outlook.com (2603:10b6:5:14c::31)
 by DM3PPF9E376D9DC.namprd10.prod.outlook.com (2603:10b6:f:fc00::c3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 11:13:45 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:14c:cafe::f7) by DM6PR11CA0054.outlook.office365.com
 (2603:10b6:5:14c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Wed,
 11 Feb 2026 11:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.0 via Frontend Transport; Wed, 11 Feb 2026 11:13:43 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:13:42 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Feb
 2026 05:13:42 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Feb 2026 05:13:42 -0600
Received: from localhost (ula0507357.dhcp.ti.com [172.24.233.202])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61BBDf9G1530039;
 Wed, 11 Feb 2026 05:13:42 -0600
From: Suhaas Joshi <s-joshi@ti.com>
To: <u-boot@lists.denx.de>
CC: <vigneshr@ti.com>, <trini@konsulko.com>, <n-francis@ti.com>,
 <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>, <kamlesh@ti.com>,
 <vishalm@ti.com>, <d.schultz@phytec.de>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>
Subject: [PATCH 0/1] Fix regression caused in Verdin boards by 42b3ee7fa524
Date: Wed, 11 Feb 2026 16:43:27 +0530
Message-ID: <20260211111328.1481562-1-s-joshi@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|DM3PPF9E376D9DC:EE_
X-MS-Office365-Filtering-Correlation-Id: 093b9dbb-8722-4566-2e23-08de695e9e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VtNslYDJizDi/mRkB7OxdUevFldZGfUFwJcebQvIGtzQGX2QwcjSucMt8kz/?=
 =?us-ascii?Q?8W8ilursE0h/uHL0JDPW28bFPrm5+cqqj0qqovC/khhZKiRp+BskvFH9Ph+e?=
 =?us-ascii?Q?pNoB7rWgU8essU84MMmP3SF3dqT16RevUVwffuFwh9haolUGNz402jXm5GfH?=
 =?us-ascii?Q?IC6hY06c2xAmNJk0aSQ9D3S9WuVa7e/ujeCkcnPUbLD9yMK6j8Y2PW/zW2PO?=
 =?us-ascii?Q?Xy+mPYpy/OKXdYgFPkOUV1qzIhHjcCEEb0slnc7jFC5lhK2eU78nUjXA+Je/?=
 =?us-ascii?Q?DR0nrLJxi0Nxyq3feGg7QonmlmIZbFJX2CIvkdA9e+pAqmkheQcu24/b/R7l?=
 =?us-ascii?Q?2GPrJ/r4rz4BlzUUjSi/m+6t6/dAyWyB+srZd0XNh1n8rTtpwy6cvwjIwPoo?=
 =?us-ascii?Q?tgeAguASOPSUd3WJR7I/YFCq2408eivs9/b0390gY7id0MlukcHTSQ8O0da7?=
 =?us-ascii?Q?5bXYzXxCC1BWKrehxKYqHPHT2wqcjjK2fm7xOJIWeqFaUw253at/PuPFaNR2?=
 =?us-ascii?Q?PelcJ2ZWJDRvAhftVcrbL3BS0w5WbMxlA59pLDt/MCq1NNh9fltuI7Q0gdsq?=
 =?us-ascii?Q?E+zkngWCVQiVuBddtqsdzBpNF1+Ovn/C8aixqGpuy7/e8YY/xphOL+wxCjKg?=
 =?us-ascii?Q?0D4ZED0SP/23GkDM2qjcKaH5WE3G+I2wMFs/1NlRRBcl19DZyPd60Q7ipzyr?=
 =?us-ascii?Q?cLT9Tafl6ARmiwa5rMKG6qnPRuIz9Hwhw4GfrE2ftbGqKV6FkwAWCfyw3P4t?=
 =?us-ascii?Q?09i3gwlXEnd20sr6730Uplch+P+RWg3aj5XJvvII+xH28aJtAuhg2jA9JhKU?=
 =?us-ascii?Q?Kr9b4+LQHSbhYhvi7H78H35f1fubnN70zHQYbQfjea8JVi+wBceQ7Gy81ORK?=
 =?us-ascii?Q?5DayNPZKRxVVJ0/T3pcrR2Od56zszdVZV2wY+t4WuiJMWaqMtvZL+i2tH0U5?=
 =?us-ascii?Q?FM82/F7zvEKLHO0czT7QSxGeG+HZMVBSduiGoA5wU5Yc/0fX0qnG4US5ARus?=
 =?us-ascii?Q?t8od2SdO931vbdDWeDrOwndqwLyGXrGWRSxfA0ZDmscT14NAHh5Zbe7I5DKK?=
 =?us-ascii?Q?5mLrO/TL+NNwGFHkvY3p90nOq0w9RhOoKhj0h9q+bl+hiEsslfjoHYTMGTtT?=
 =?us-ascii?Q?uLVtasQOaWEFBrmbGImR5t0glg+rUYMxqPWV0eKxkrJrN0HviI/0Mron4h0q?=
 =?us-ascii?Q?VUNMF98k/6cQGO+2CBx6/IipN6CeHZW7SMXLssOJLnBlnqZpZ+p7NTT73yeB?=
 =?us-ascii?Q?rJ2c8Gugp89ESDkm2icXi/gKtN82E7Z2Y/HzrQODB/c7oQunhzX9O4xy3uIW?=
 =?us-ascii?Q?u4aVLQ08kjewjrvt0KzUdhovOsdkhHBDkovPK9A4AxaWfNV4RbQRemaTzrJ6?=
 =?us-ascii?Q?rmjFlrqQVD3M7iijlHC7Qcdjvlawe/AapTPC/Bi/NQu8Btw2Dxr+gE24P0jV?=
 =?us-ascii?Q?nNhN0cwGlpNbKkCKguVFWRFyEfa2ANq2IZEnqPvYW9qiuTd1hlNuiNbLR17w?=
 =?us-ascii?Q?w5Xa1cEJziLEGkQTB9uFRcrUy/mNeIomIZ1ERyLIcOhBeOKtaltYqloDsBaD?=
 =?us-ascii?Q?O9y9Xly8HnhXaRdJPlDGZaCQxPW9fZsDf2lePoEegdn4rAZmvYBB0ltuQ5M9?=
 =?us-ascii?Q?2H+mqhlafQPL/ETltcJrC/y9Y+/GOJ0wtGnuSegWR2KBACIMdvpgP4Vtv7pP?=
 =?us-ascii?Q?xl2MSgUMJYSt1ANAIUOYwRhFESc=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cWY3/oLT6UYLYw0nKXqMNxldLDQ+O/0QmYH7XF7s/uGpHIM3H8+1ffaWMFsXwTaG/O8u1Rd3xKAVPC1+sIxe683RFbXy6P4nFAWCbiAA0pqv8M+yn4ggJ//zcMZWbCJ8/nAeBEJCjsSuhdKlj3/C8u1ECMueVWUoDDEmLgePgrf31IbJwGItjYgGO1ycoEpJDQXymZeAFYA//1LzbcLZt3l/IJ80yQqO+FtnSbHZ0hHbyttYHmQb6qUC+5aqnjkwNpvH9JXmUd5PiEl4Ka6EuasNxXFNAr2Mj8ci9YPHSNCRZXbAU5jogfiC9uZ4XmTm8MN+LZuksrId334Dcs/jfzHmqbk3vK5Pe0Ysu3ctbgPNUqnTM7YKajRj5doNlI5Jc2WnO/jsUFsrCzd1YISAv9x5p9DO/jMH2SpJnit+BzfyHlIUD+YUni21nLAv5+kP
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 11:13:43.2002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 093b9dbb-8722-4566-2e23-08de695e9e12
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9E376D9DC
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

Recently, I made a patch series [0] that added firewalls to K3 boards. This was merged. Francesco
reported [1] that the series broke boot in Verdin boards. This issue occurred only in Verdin
devices, and not in the other boards, due to `dram_init()` invoking `get_ram_size()` even at the A53
stage.

This patch attempts to fix the issue.

NOTE: I have *NOT* tested this. I don't have a Verdin board with me. I request Francesco to test
this and please let us know if this works.

[0] https://lore.kernel.org/u-boot/20260127081652.506357-1-s-joshi@ti.com/
[1] https://lore.kernel.org/u-boot/20260209083855.GA9367@francesco-nb/

Suhaas Joshi (1):
  board: toradex: Make A53 get RAM size from DT in K3 boards

 board/toradex/verdin-am62/verdin-am62.c   | 10 ++++++++++
 board/toradex/verdin-am62p/verdin-am62p.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

-- 
2.34.1

