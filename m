Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B98FD58E73
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 07:44:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4B0483F4C;
	Mon,  2 Mar 2026 08:44:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3H0/WJiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A07B883F2A; Mon,  2 Mar 2026 08:44:01 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99B9683F37
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 08:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBkRmOS7T9+Qe+Knz0zgpLtIImzKJHaE1+nckPO3F87KvD5TVqDVDT0O7RiccmnPeSnip+ipAHAtpqdvtRG9SHgPSMq18WoRG0+DreGr1p1fGeIBil7zmMWp8n3oOSORLAlFEvRbPKfnKTZ9wmeVq0WJyA+8BNRCCNLzwwl9ylkI6ZiV6FvRBLPP9oInc2uEOT8/vreSaDGp7WG64EVwaLw6rQ3ldwJiuAGabZ/bzAfCRmWzz+FZYAvQblu5eyjdVzdz7iWt0TduMprX3ozlbzMP0A3y4/zMAuya4D4DTeUQ7CyYTZHJoBNVB0NWma3MZTtA7oP4EhANwdK4VTvC2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt89buTkuIRWGmEc+Ih5/XSlirEMmMjX0OXU79sWC6c=;
 b=EAPsjr6ZVybYw62FA747/ynVcOVkD/VcVj3DGHUbaN4zTIgz92mazVjvsM1uhVrk+6QQBqTkx+cie0cRfS4fzQcJbvpliDQ84j5Hiv+BumMYQgJSbqkv9qHDewnUA7l92VfkfLv1VyiO3oHQkShBIa0wiFkgA6YwCIGPd3QwJxMhv+un4R7qxSuhRcU98Bk9/nQ/t5+w85xzwvemHAF6Wz0O+o6iPCkKR2Mm/CLzexhv3AC/q4EE688IoFqdfvsBuL6kAFjkeDvyvIcCAfu+8luPIt1dh15nI+Tjn/NpX44zPzE3cqjS3SDp0nuDG2l5hFWdWj5fUQ8FkAYKzr4AYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt89buTkuIRWGmEc+Ih5/XSlirEMmMjX0OXU79sWC6c=;
 b=3H0/WJiuFF3+qmswNJlIwlNbajEDHMkhJ/Lm2NRavCp0p/e3R6lsVgFEpEPK+My6zZsjm8XuP5LfoHoV2sIF8y3EG9KXkmnR9O98I+9h5jHU+AISr8aIDdZymRI8P99eJZzcXLYrZkQP4+mnMhvUzE2db7xrbJhJrR/GuNDM0Oc=
Received: from SN1PR12CA0087.namprd12.prod.outlook.com (2603:10b6:802:21::22)
 by MN0PR12MB6104.namprd12.prod.outlook.com (2603:10b6:208:3c8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.21; Mon, 2 Mar
 2026 07:43:54 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:802:21:cafe::d9) by SN1PR12CA0087.outlook.office365.com
 (2603:10b6:802:21::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Mon,
 2 Mar 2026 07:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 07:43:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 2 Mar
 2026 01:43:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 1 Mar
 2026 23:43:52 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 01:43:51 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Harini Katakam
 <harini.katakam@amd.com>, Jerome Forissier <jerome.forissier@arm.com>, Martin
 Kaistra <martin.kaistra@linutronix.de>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/3] net: zynq_gem: clear TXSR transfer complete
Date: Mon, 2 Mar 2026 08:43:33 +0100
Message-ID: <f354680d43fba0f590a6fae693848e5bf7114ba5.1772437409.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772437409.git.michal.simek@amd.com>
References: <cover.1772437409.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+7zga+sHtmCuM9hqkWDjarRnbNB4PgSy3Ah+zDOqVgQ=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQutV+5+jLPB9ai7f0er+IqTz8WPVh178LjjD9M3fNS3
 wp+0dt8v6OUhUGMg0FWTJFlOpOOw5pv15aKLY/Mh5nDygQyhIGLUwAm8nQnwx8e3p6n9hMdCidu
 nDb34YSlSgtK5R+w/BGr8TQsUt2ow9DK8IfjxwuxjzHMey9eXGFh/JTNS+ZyzczcqC5Vl0WCiz/
 86mMGAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: b06f7103-afcf-45b0-42c6-08de782f73f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: F0h08VXEd5fp/k9mWygQUd7x3iS/sszPWNCUnwrSNSYvcWWhJKxwItHWmyMUz7G1srbIKwKMztWVBzeiATCLm7io5iQ4ctA8d6616IPU1LXPgntOzrZNA7SOYTLLNcBrDKUlOYFaFVStHIA48PW1w45daEHL9VVgPiaSBO6aoo+jR4cn73uZw6+iUhgOHdbOCB8kxBSJWwcPrtZ4SxLPFK9XUXoNCX6ZDocN3nLfL86Z5WyY9Ff+Kg8E7tgUeIebwuPPrOD+0CIOBXIvSUqCA4+ejG/7ajtOrH4ApPhmiod/loxG3acY8OcvSKD4v2jAOPQA2OW0uxAOiPJUKrJ2QvqWA5tTn5NVlNTWwP9yyD7u+ACCw37TkjOwtEdnQMAIPwb6rwm37sjy0UQMjntQRyLaOyR+V/Fyeb23pGwmsMR7Jum1qjMqDG2Qzddkf3r8ECc7z54Uus+apiwER3Juz7H7+BpNfB1sPVxQn2gw7KriGRHzkyJwpPmoC65ydriTFivFHwWbH/nKw3IJo2bLsZbx6/8d96f7ZbABEdf7Gl28JuJ45JGNMxs282sHbek2Le1Ly08CuAQ238JmYttbSMaGNinb8rveQnGekZeDfZK8QwBqhBwtOiTR7LAR5wxuz3whXQF8OszpzooYwYyvaYVIesfiaX5xaJmYLaUuBRYe3j5JQ2Uk8HKr1B5FXBLsiByqmi8kkmrPTQ4w61A6hbXg4+knSY+LlFgjUlyAA14iaGe0WJXb/OivEFTFWPD0/+wbRlRr32RLi7Rqs9Nq9PZPCzh97VoKXFHG0J19KsxN94rWcRqQcKGTI7mDBc0yQWkxqV18nHACip47duDicw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8xBWPuW+iCe5gqaldGqtc89bPKHZvm1LtD+QyNEYdpfMXrL68ZlAgS8jE+8v+HAmn/N4kA7HChCKMNyq1hnIsa2V0FweaFeMBncSweBnHDaSrBvGczGH42snu3MxyeidGiy6sUaXNZp3OlVL1Z5ze57NLWALTl6oGZxRnEMUc4CZtmc8liR/c5xRo0GYeV+BMdn3BnwtT92q5ybalwzM5aFKWbONLqX0j0TYTYr9/uympxv0j8JK4bsh5xDHh9AM8G50pc4fvwhqj/jaMDnEJGj/1wRwmhDptt+oy5Vp4wIxQ92SlB52Yg2Cqf1tPbEfMqBE3DhCfKDX4CY9w3LZkAR8J3ueQhdtZVLRHLAjN3n8LMGQT79lYd3hY4ecxdRFMmj0gavbvg/vjNvW/ZktnNeJ8nmcLzClbNRmPOELPGv9JW6X0efZ5/YKaTczjRNI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:43:53.7072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06f7103-afcf-45b0-42c6-08de782f73f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104
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

From: Padmarao Begari <padmarao.begari@amd.com>

The Zynq GEM TX status register retains the transfer‑complete bit
until it is explicitly cleared. The current flow waits for
transfer‑complete but never clears it, so on the next send the wait
loop returns immediately because transfer‑complete is already high.
This causes the driver to report TX completion before the new DMA
transfer has actually finished, which breaks back‑to‑back
transmissions. This issue causes timeouts during LWIP TFTP transfers
when cache coherency is enabled.
Fix this by explicitly clearing transfer‑complete (write‑to‑clear)
after the wait completes, so each transmit starts with a clean TXSR.

Co-developed-by: Harini Katakam <harini.katakam@amd.com>
Signed-off-by: Harini Katakam <harini.katakam@amd.com>
Co-developed-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Message-ID: <20260227144530.505233-1-padmarao.begari@amd.com>
---

 drivers/net/zynq_gem.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index b05c752b17eb..41883a440528 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -693,6 +693,7 @@ static int zynq_gem_send(struct udevice *dev, void *ptr, int len)
 {
 	dma_addr_t addr;
 	u32 size;
+	int ret;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 	struct zynq_gem_regs *regs = priv->iobase;
 	struct emac_bd *current_bd = &priv->tx_bd[1];
@@ -734,8 +735,13 @@ static int zynq_gem_send(struct udevice *dev, void *ptr, int len)
 	if (priv->tx_bd->status & ZYNQ_GEM_TXBUF_EXHAUSTED)
 		printf("TX buffers exhausted in mid frame\n");
 
-	return wait_for_bit_le32(&regs->txsr, ZYNQ_GEM_TSR_DONE,
-				 true, 20000, true);
+	ret = wait_for_bit_le32(&regs->txsr, ZYNQ_GEM_TSR_DONE,
+				true, 20000, true);
+
+	/* Clear the transfer complete */
+	setbits_le32(&regs->txsr, ZYNQ_GEM_TSR_DONE);
+
+	return ret;
 }
 
 /* Do not check frame_recd flag in rx_status register 0x20 - just poll BD */
-- 
2.43.0

