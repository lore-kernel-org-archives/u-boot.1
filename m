Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A998BE9B266
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 13:56:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 328E383E76;
	Tue, 24 Feb 2026 14:56:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="rf1a5DbI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCC3D82A9E; Tue, 24 Feb 2026 14:46:07 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C55E682A9E
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 14:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=devarsht@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YonWF1VU13Csv1bH23EXS2RDIfzvPfOVmTGrv2J+f3whoq3LDFO0N8VeT4i+mSkzD0m7zemUK7lLRajy1xs3WyZPMVhKrFMTDGfJy/nKfTWgd2USIz1urASk0qIU5HCVGAn/h07UZ/yz2wU3bJ34ucq8knqq3nu2ddeW2nD3FATwlB0jnFm9GD6bgnNZLarwOJCBCIqDGd5NWGmPEtl6LbxqnpuYlvXWgcYbgNDWhM/34/q4Xju60gVeJrsoBT2LeGKq87+bfzLSGfkR7BqajOwpK0bwzA8mX4c1mHpV/ceZW5g5WYdzth6LmxBNmBxro9Zkn1Gc9tK4fm9PkdJ+2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RoOmWi0cxURHx9Vk40qlIbjDt3OBW3IVQ4c5p8Jdh0=;
 b=Wd3Uewh8qy4f0B+7pGsZf/BOH+p+/MpFGtiGxVKTr6zp5MP3VfIMmZV1WDkDqXtf3/HXOGQwkjVpaj83aw7fGx67tlAeevLHR8SnboD+EteK4Ifn4mzKP/wSvpcTS1yj48hfXru9DohZTGVJ0zySz+4h3JZ/hHlE/vyCVx8+IzCB79dDICXgZMJTdgognq0dfu5IIi5zzFPTXdkrHbM1koZqeB2u9wzuSEXF6snt7ayFoA5Pi27VqAhrqJ5iC08xBtgcVvUVoVEU9ypd2iSbOE/4Dm/gv3UdIUAXWOgz1G4iQ769bYwCcoPinuaFJY54TdTElC4HTA1tKAC3fOb/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=phytec.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RoOmWi0cxURHx9Vk40qlIbjDt3OBW3IVQ4c5p8Jdh0=;
 b=rf1a5DbI/2Ff1okY93eFj/onEhtfm42OxlHkE7FopJ7e5Zc4SjnioJwlIMvRtViqliP473ajxwcC7OPLVQhTMhUGWZw6SxQt+5181VFM3c/WlNqye5dmSNpe5qEfuDUCZQmZJzml9kce6Em7J3ndr7XUviz1Wi3FyZlCrL8KsDE=
Received: from SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) by
 SJ2PR10MB7038.namprd10.prod.outlook.com (2603:10b6:a03:4c5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 13:46:00 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::37) by SN6PR01CA0004.outlook.office365.com
 (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 13:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 13:45:59 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 07:45:59 -0600
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 07:45:59 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 07:45:59 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.233.157] (may be forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61ODjvkw2818568;
 Tue, 24 Feb 2026 07:45:58 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>
CC: <sjg@chromium.org>, <praneeth@ti.com>, <francesco@dolcini.it>,
 <d.schultz@phytec.de>, <w.egorov@phytec.de>, <ggiordano@phytec.com>,
 <bb@ti.com>, <anshuld@ti.com>, <vigneshr@ti.com>, <n-francis@ti.com>,
 <s-joshi@ti.com>, <s-tripathi1@ti.com>, <k-malarvizhi@ti.com>,
 <kamlesh@ti.com>, <s-jain1@ti.com>, <r-donadkar@ti.com>, <sen@ti.com>,
 <devarsht@ti.com>
Subject: [PATCH] arm: mach-k3: common: Clamp RAM end address to board-usable
 region in spl_enable_cache()
Date: Tue, 24 Feb 2026 19:15:57 +0530
Message-ID: <20260224134557.2067046-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SJ2PR10MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 6dc542ae-4e06-4cb0-58a9-08de73ab0b37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6Qpsd6lHJ+MJeYeoyHtSq1UAOQocdu8EGuMT4A7b0I4hDpWY2VgECNR3Uv2?=
 =?us-ascii?Q?boxPHMsdSd9+vDk7X+fVbdWTtX91YnMlWDTzrfsh5pqfyhAjVz271l++piVZ?=
 =?us-ascii?Q?jfWT8hJkKQgUaRzrLaMzMFJMFRu1vTGX0iylqEVdCAKGLFCTpeXg9IYznIiB?=
 =?us-ascii?Q?vZLbnt+q6a2MbTSTddN5AlWd0OXLVJ5kJ+G6fDwG/3e/SiM0EjkPqmXs9+qI?=
 =?us-ascii?Q?5t0tZ9xPkw6A18qTNy9nrNjkkqen07UkizRgEXef82qz+i7cCOxpbdVVlIwj?=
 =?us-ascii?Q?n7pB34euyGKv3BbBcdmyQLCBFefVLEFRQCs+3A150mlSYR+4/8GNgsDssOyi?=
 =?us-ascii?Q?eYn77bYKMJp6MVP0b3n5UjT90rjYDaFm9giw3fmUtZRAZ05hEJGbZRk1rTOm?=
 =?us-ascii?Q?Q+ZYQ9IZqQmzqUh3gJeAoyTu/TWHcYviRvkwPUcmjMpC7a7ZcM/Mj8fHtmk1?=
 =?us-ascii?Q?6JmaPkg0dhuEgPuZEmKsRepSOgoBYBgpEF1RynIpZES5K2wJlqUWx1Xhzo4w?=
 =?us-ascii?Q?8evAu7PrBB2dXiiYrJFznol064ZVjlsSTOLCRVLcTywmZo1BWZcK1ejiqW9T?=
 =?us-ascii?Q?4BpRI7C+rNGR81vVA3SmhxVAuSMOQwaLKUsAnp3BkML8v5e6xWescoFNJTWH?=
 =?us-ascii?Q?+LGWTWKnsls7xmsCtwGF0btcB2hhkV5DS+HNDloXbC0SoHDvSwEYrdi9oJKy?=
 =?us-ascii?Q?pgUu+2VpJVypWPMs5DfJJKZaaxB4YXBXfHTo3EX8B1A5+188WRpwxPCOszKw?=
 =?us-ascii?Q?RDPfdO3xkVtIMl4Y3N2XJTy32JoCnUKum7DilMFtelpatGu7AjOxi63dvBk2?=
 =?us-ascii?Q?RdAuOPGvRt3LdT/+UdsGFxnKr06FE4sJwsAvOmR2HNyaQzxe/JnIxVcdje6u?=
 =?us-ascii?Q?DNmWUBEhYm+Za72iZdJml4jMrfoc5y9CqmEL/fSXvpMsuJFvtrG//WMwAJFZ?=
 =?us-ascii?Q?eGZfzWfoqcyWKfZAesCqFJ5ycS6M+FjNJCMqw/T8FFgqlaqn9EQowcZkmxZK?=
 =?us-ascii?Q?yIj/wq9drMgoxAPsXPOXH42oYM+Ugv94LZitSQLny68PW1ggCT/pbrTj9W4n?=
 =?us-ascii?Q?kMZZXAHKrlMnj3qHHEluxnfi2AKwNEzIXRD4BYolTIdjgbO0KdK/9QGjDhYY?=
 =?us-ascii?Q?22UjCj+tAhSzl5/riN1KUxUrRJQmoY7F/b/a41ZG9n1qe5YTLSi2X5XAayBa?=
 =?us-ascii?Q?UKqJ4AJp1COe7Or9PcRjxHY3a1og81IPRaUu+m0iT4elqsyWICZdxFlVXVpn?=
 =?us-ascii?Q?js+hQNiWtDz/G2xmqi/2DDj8ywNfHyuMPElouXNhMi5KQSshlveV3CAHWrhG?=
 =?us-ascii?Q?U55RwqYz4frmzuePtuFTzAN2LGnkQioGk2slObq6n6PvNFppdwcUVWQHS38a?=
 =?us-ascii?Q?aBHlOe0IuVK/cuulAwtRXV6YqMZyDUvvDJfqY1gMdWpG4fi9gErPrH6aChsk?=
 =?us-ascii?Q?ERtrKCIIDuvpxggYbf844j1Z966gS+7x4As/SMliIA4HfkbD/JJxRC+GHbt9?=
 =?us-ascii?Q?uEnlmIichkax3S6IOY8shT1LREbYPJR5J9REnijYQITLt2jhdcC+Gmjlyfh5?=
 =?us-ascii?Q?8vMf0AdQ+KkPtHi6RQG9pWtzhXK3TLoCa23CkXrZAQ8zCyMhNJbmTvHn5T18?=
 =?us-ascii?Q?NmOrlZ0wil1gz4CCE+TNi47XQY6g1eftAT1uWbFlSj2nSSDulOn+1pPcpJNg?=
 =?us-ascii?Q?6ta+EA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WgXeN0YyRtB4nkwiNqsTKggR5My9tGeGMS3xCs9EQCgmgtHWE8rl395J0J4I5PO8mjOBhVR9Udif0ZW+J5XJUmgUCrBDcU0dgp3U+Gb6LN3/F+cUFrUU6dGwjMgdUTZ0++8JaMS7j9zYcRaJtvfXsXM7oIuttphossetaiqnEz1bRD/XltgxMrelQCvqCJKG8Sv+T+HRJpKcOp5RBx3GeGZuxKeDvvbQTG1V6P7RHz8fTwPmeI6ZNhHzvv6iHh2VuR2Xt3zHojo7ahQqkn4pHRpIhbfjAZ7d+ITZ5EziAvpTISXyiQzIunBnAKlOGzAyrx5sdksyOwGk12izZ+ys1gVH6ldVFn0OmxOJWJW0gThl2MEdKdK+8dneoIV4ZvQTcsHtr8eN0RbaXf4aXhmtGo2gPuTUpnwWbsne4r9yRJzK/zzsMw5iLKcqlZSAcK1X
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 13:45:59.7177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dc542ae-4e06-4cb0-58a9-08de73ab0b37
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7038
X-Mailman-Approved-At: Tue, 24 Feb 2026 14:56:26 +0100
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

commit ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from
end of the RAM") switched spl_enable_cache() to use gd->ram_top directly
but omitted the board_get_usable_ram_top() call that limits RAM
configuration and provides updated RAM end address per memory map
used by board and impacts subsequent allocations and reservations.
For e.g. here it impacts how high the TLB may be placed.

On Verdin AM62 (512 MiB), the raw end of RAM (0xA0000000) is inside
OP-TEE's region. board_get_usable_ram_top() in verdin-am62.c returns
0x9C000000 to keep relocations below it, but spl_enable_cache() never
called it. commit 42b3ee7fa524 ("arm: mach-k3: am62x: Enable memory
firewall support") then enforced the OP-TEE firewall, turning the silent
corruption into a hard hang.

Fix by calling board_get_usable_ram_top() after computing raw ram_top,
consistent with setup_dest_addr() in board_f.c. A weak default is
provided for boards that do not need to restrict the RAM top.

Fixes: ba20b2443c29 ("arm: mach-k3: common: Reserve video memory from end of the RAM")
Reported-by: Francesco Dolcini <francesco@dolcini.it>
Link: https://lore.kernel.org/all/20260224102121.GB340942@francesco-nb/
Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
---
 arch/arm/mach-k3/common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 0a686efa1319..2f3df5519c53 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -407,6 +407,11 @@ void k3_fix_rproc_clock(const char *path)
 		       path, a_core_frequency / 1000000, speed_grade);
 }
 
+__weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
+{
+	return gd->ram_top;
+}
+
 void spl_enable_cache(void)
 {
 #if !(defined(CONFIG_SYS_ICACHE_OFF) && defined(CONFIG_SYS_DCACHE_OFF))
@@ -420,6 +425,7 @@ void spl_enable_cache(void)
 	gd->arch.tlb_size = PGTABLE_SIZE;
 
 	gd->ram_top += get_effective_memsize();
+	gd->ram_top = board_get_usable_ram_top(0);
 	gd->relocaddr = gd->ram_top;
 
 	ret = spl_reserve_video_from_ram_top();
-- 
2.39.1

