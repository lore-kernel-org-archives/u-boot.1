Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2515DE7717D
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 11:12:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 768BB896A5;
	Mon,  9 Dec 2024 12:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eyzicB/8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C57F2893A2; Mon,  9 Dec 2024 12:12:06 +0100 (CET)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F5F896B1
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 12:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CxnntX+hSW6SbeygiD18ueo3OQKxc0aQ4/0W1/hGb6ZknN3X+4K4p12Ql4xXVUA+zK6k0rxhviQtQDPf6HyKMaITPlxRn41Gsicza3hK65pl17qRQ7PF5bspKBXlPoedryEf9x3g85JjcOpTSB+1o1KF9H6Wwl0H6Qli7sgsnkMrE5qac2ypy59+L/yhQvN+f7eeXGOHdd3BiquJBvMpxysCoWc9YHUwRBVUA3JidVyXahj6IvuTuA/nspMQGD913BgYgL8K6r0YXA/07XdnhN8NP8TMKwmWPsAMvOkb5/wnhFCpz2mh85esSr5X/RTacLoAS6X4pR+tLidsZE0Wpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MQV0+HyXrRjH7uamXYmGmNMdh50vqMapjYB9EALZjk=;
 b=XCY6wpswY3oy5KogMMDJUW9aomZd/1lMD7jD648ly0c8KP+WmheniLPhMOXZAg73gRAaeEIpPj9BbE8uEcqRy8iF41Rem7SyKoooiTEJaUNVYcCed7tPNWEiyEnQdeHmo/HT30Py+aU7WC5V1rUswOQXo9lzrtDDkxKr8jQ0YCYshgusluS3mf/hGHRZ9WAiBerYVhDCoOySSekoOSpX47FsI/6FfX/Ll/2cqYETC1eE96bBL10Yzl+EneZDEyOVjRlOl6gU03J6ExcrvsLOW/i4uXNjYejHE8e5X+w4f4h9xmszCQQMhT7Dw2nyXS2lc9P12klTMpfwgXSUQcnBLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MQV0+HyXrRjH7uamXYmGmNMdh50vqMapjYB9EALZjk=;
 b=eyzicB/8V7jO3i1qvB4lf7raoHRRVNkXqaRaxg8JK/kWIUZVBMlabuyWRXqBhuY/8rkyFgSlwkccp6MOx8LcyVNfthG2q+2ADOcy7bUprGq9fVGDjE6fFw/0pt5FUCZRdFST9gtSCx1hhImA3yhdUa91/9tq5JcHbmdNn4QXnuQ=
Received: from SJ0PR03CA0267.namprd03.prod.outlook.com (2603:10b6:a03:3a0::32)
 by MW4PR12MB6706.namprd12.prod.outlook.com (2603:10b6:303:1e2::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 11:12:01 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::80) by SJ0PR03CA0267.outlook.office365.com
 (2603:10b6:a03:3a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.11 via Frontend Transport; Mon,
 9 Dec 2024 11:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 11:12:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 05:11:57 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] video: zynqmp: Add support for reset
Date: Mon, 9 Dec 2024 12:11:50 +0100
Message-ID: <0504474a91a9839828aecd37f8855fd154cdf2e1.1733742708.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fwA65OK6eGwOVUZ9GctiBTEmgmStFgPZc2XsxhMPR2E=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvSwC+WyGwq1JgcZrPN+WiHj6+Tizin0a32M7yXTWVJJf
 D4br07qiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABMxK2SYZ/HL53/c0ziP73YM
 R3KzCn+eXVDCyDBX7Phnp/vGeUfkVAL3T4/1Pe20WeAsAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|MW4PR12MB6706:EE_
X-MS-Office365-Filtering-Correlation-Id: df9e43c9-7ad4-4002-a876-08dd18424dd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MHDkw3BKZE56KjqTg9EasjKHDyh6Ik3EC9aQxzkLLXNft0wQih9IAM+eh2ag?=
 =?us-ascii?Q?7TAKK3lOBmm32N88ySyHl4dVG/ohIy/mKGkjVNFWDBsd6GFEGbHhB4ZZ6sts?=
 =?us-ascii?Q?gPgy7XVZQ+fOPniDZMtOsKE3ZeAS073hZLJXdXJq8nmwTOzjZYfshJrbpXCE?=
 =?us-ascii?Q?Tuajask25uMObD/Tlbrjb3G5vzPGpp+o3W05fAXDDfIK13sdjVGhOmm76Y1O?=
 =?us-ascii?Q?ECg1JsAlMTUYj+iqxQefq2mwWj1eMxCB4/4b4o8hhtBZ9rVCM4RKqJr8bV45?=
 =?us-ascii?Q?t4gwC61DrClrvCUgfqQ/dMoSnZiJjq4g07+zqdgG0rqmJ5/PWuh9HNfOerud?=
 =?us-ascii?Q?iUVtpe4p6lOM3mqSx+ZAI/XRbeM/9fmfaAYMgny731Fjbs4ALULg2+OZl3ym?=
 =?us-ascii?Q?PWe6CL8l8fHRgV2bi6JE8pRTiTIlB9SW1bM+2LohO+SQvsaNlGB77BsnVtS2?=
 =?us-ascii?Q?KNlC7hNtzN5aNZ1UoQAk4Oy3qG9T4xotVLW+04CriJGpVj/5vm7Wb1Su+fec?=
 =?us-ascii?Q?PBg7YQ3dFEvMoDIC0TxrpkeHjTOR617CxD1ZRiI/KbN0Yfa6p3GH1vTsPl29?=
 =?us-ascii?Q?hS4cULDZw2ZgD2wVQirC/4MyOnHko99g990eypBpjpQV4DXbi1Xem7tzffj0?=
 =?us-ascii?Q?dU6Q7dXP9k/xtfWjq8n+h9dJm5JRgwkJTo8fuCcyArTLzej/pteUefn94bX4?=
 =?us-ascii?Q?ELjaWejL8+S9L+CmsLZLB1liRAvdOGNEok91RPhLjBWpOBwdOKFFp65etQHo?=
 =?us-ascii?Q?Mb9tyo+7z4gtAkTMQ/9E3ONvYZHrwFJJ+SKOLvMVt2owZdJegLTzzmXJDPRX?=
 =?us-ascii?Q?VYxs7mILcd+F3SZCE9KFXYUk5j6zLRJ4y89K5DiedOkf4maf7iuaTSzmI8fe?=
 =?us-ascii?Q?BcA3ijZs9jPTOyqtT7sBr55aaCfDVZxnUSxb1ptpQ9VVjbG3Ldk1NY8aPufW?=
 =?us-ascii?Q?8Ie75JF8lNRm4LrizYuAUsh9biPF9y05kbT3sjiueZFLmf+7rFXXgA8ViNj9?=
 =?us-ascii?Q?eTe3O/rH0jYHAiyIDmJjj+QGPqDHuqyzQ6rQ5RtTsQLbZgPJnsR/657nT8XE?=
 =?us-ascii?Q?yiUnfSpey9ew2NiBZg+6Be6XUr6NHhlJWg2S268TSvplVi0V25eU3BhSum6F?=
 =?us-ascii?Q?rR9HC6YeMZWpzHgtRohInrXixerytHkwORK5mg9+nOoT6vadBdIV1fr2C0Tu?=
 =?us-ascii?Q?o6fqzjwEDuie0E7uiq2u8F7MJPZqtERd6mrAAtNfQS8FXTPIWnc+RJxEUZ1/?=
 =?us-ascii?Q?FbULlGGGKrC++fJtVsFTPgVGRL1SmykA0ItF4uZUZHKnOiT57nhDYSenSwjT?=
 =?us-ascii?Q?lequl1hwNWpPD4gDcviRzpwslsZt5N+uH5zj5QBf10JSxTULAQjU59W7fhLk?=
 =?us-ascii?Q?kpsxQSmHJB1LMHgjKGUK2ydrgsp3GUJBmXt505qoBBpiUPnewBPlYdPJHVag?=
 =?us-ascii?Q?TfOylE88q7yHpDu83sTIVlANuCBRHJuv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 11:12:00.7606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df9e43c9-7ad4-4002-a876-08dd18424dd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6706
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

In Kria SOM configuration DP is under reset and access to DP is causing
hang that's why call reset at probe to avoid this situation.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/video/zynqmp/zynqmp_dpsub.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/zynqmp/zynqmp_dpsub.c b/drivers/video/zynqmp/zynqmp_dpsub.c
index 76abfeac4433..52af23c3c835 100644
--- a/drivers/video/zynqmp/zynqmp_dpsub.c
+++ b/drivers/video/zynqmp/zynqmp_dpsub.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <errno.h>
 #include <generic-phy.h>
+#include <reset.h>
 #include <stdlib.h>
 #include <video.h>
 #include <wait_bit.h>
@@ -2093,10 +2094,15 @@ static int zynqmp_dpsub_probe(struct udevice *dev)
 {
 	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	struct zynqmp_dpsub_priv *priv = dev_get_priv(dev);
+	struct reset_ctl_bulk resets;
 	struct clk clk;
 	int ret;
 	int mode = RGBA8888;
 
+	ret = reset_get_bulk(dev, &resets);
+	if (!ret)
+		reset_deassert_bulk(&resets);
+
 	ret = clk_get_by_name(dev, "dp_apb_clk", &clk);
 	if (ret < 0) {
 		dev_err(dev, "failed to get clock\n");
-- 
2.43.0

