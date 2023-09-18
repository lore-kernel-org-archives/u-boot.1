Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10612C46CA1
	for <u-boot@archiver.kernel.org>; Mon, 18 Sep 2023 14:11:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3971186958;
	Mon, 18 Sep 2023 16:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vx9rbMx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4181686960; Mon, 18 Sep 2023 16:11:34 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::61d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F72486936
 for <u-boot@lists.denx.de>; Mon, 18 Sep 2023 16:11:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZJdFPw0WMMOHAdIgc/x7v4ftcKS+Y1G+NE2x9X5VHhxh7qw1bF2JsQav4W42YaDVGb1kfzKuWOjPJnSZnZyroVD8YBh6GbU8CIRCZJb4ZN2+3be/e6D/R6ZFZ4iUbAftxCL9eed4e3FswfEwAvMkV6hN2xUH4ewFEPYs6MmwVlx35Pn2ApV2tCU25BVYDRz6yoC2NnZ59Kn/tp8xPAMF+JQcrEvgOwwKsqShWf5YfHTFm+uIVNR5oZU/hen3KRgr7w+C+IRMr1ciVzlcyNEtCYt7n8hNUiwwweD9xHKzEJMzhLd08NcNrjywSGsrwR33rqg8JWhcPk0ufbZ5DmbfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2SjXoOygYXSW7QyMvGPssHXEVM+o5u9Napvjm/bfZ4E=;
 b=Qd6YK9ohT3habPW//ZHGhV/6PiNGrd8IXsUCqSdBhxD4ua/vuBxz+0n7PX3QN8L2z/rEKPnHUCazs58Q8BZ/2os3uT5J6cNyufc0PXTEREznmIPuXcmljdkOlZW6KRkq8dnuIfYZFGZ/VEvS6JeTPBMzx5f9exjxQl4PnEidj7nA4ImlNNFqX4T80cDXGZhfmrqBmJdkXX9rub9x9cnyLh0OvNZ/QDi/2K2LqCYavV0gFVWyV04dmfZRT9pYWjnZisqxAYhc/1055BCpJy9PY4gtu3z+5m1ts9FS0bkd2kPy1odH2pzroFu4DWyxnu/1NCscIoKarnuTIhMksQQnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2SjXoOygYXSW7QyMvGPssHXEVM+o5u9Napvjm/bfZ4E=;
 b=vx9rbMx5WIuzV10Wg0cViZ7JlR+QoNFer0zN2TEoIO3GYzeIpgDpuzyyYinHmGldiyyYG9gCc+KGw0s1W8QGhZMhdCoDdh5+Fbl8c9R6Ke1AznJOqcEkhyFfkHT5SfIeLbS9i6w7HO/AFOo2bUa/nyoew1SlWBaVlNrf2wjqN3w=
Received: from CY8PR12CA0067.namprd12.prod.outlook.com (2603:10b6:930:4c::7)
 by DS0PR12MB7772.namprd12.prod.outlook.com (2603:10b6:8:138::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 14:11:28 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:4c:cafe::5b) by CY8PR12CA0067.outlook.office365.com
 (2603:10b6:930:4c::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 14:11:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 14:11:27 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 09:11:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
Subject: [PATCH] arm64: zynqmp: Remove resetin/out from K24 psu_init
Date: Mon, 18 Sep 2023 16:11:23 +0200
Message-ID: <7b207e90f68028ab36fcc22df4127492f174793d.1695046281.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6834; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=xFRXKxmQW4RJ502sDCoQ9lE0Bb6AN7T2OE1vavVqNMM=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlSOqK5CX12RGIe5+58cfdkYFJlnP5Gx880EsR0e/W+ce
 FmviN3oiGVhEGRikBVTZJG2uXJmb+WMKcIXD8vBzGFlAhnCwMUpABPZbMMwT/V5zj5T+QW5sXXB
 KZNMe+OZw43WMswVsn2fucsxz1Gz9fMFp896cu/D3Q8BAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: c0a03065-f813-40c1-0514-08dbb851267f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTM2cxCprUSJXydVvA/xJa4d49mVgk0UcqfoC6e9hQt1Ez4UhKi8UeRnZmiT7X8zRu5+RWxYLCT+NioJjBBP7fq1xu0OOnGUtmEryTBsIfWWGB6roOnEfPGdFW4deFGSH0p2IV1kSDRv16fVqmMsnpsoXRNO8cSioqJtHi3Luw0yF7XHR/Gt9hvrHLc9t2wTvwQBb/dLabnUiOD7tgfr/lMNfFDxkGQMoUXpxCqOlCW0AtOYgRfcwzkOYHRhd1DiknCYDcxDZZffjKX6oRq1qMMBFXwHdo39lu2GHBc50hjONC+QC4R9JDprCwyYRvVAHvp2fmPpd6U/JB3gG/aSyq7jZd75H5wDtrUfj65sk/dGEGz9ZUT89CAMEbAjUmmr+8/85D3GE34AKTQcHSHfqIRxqZoqeofPB+NZK4Ha/f/fYzgqV5VKxeI1/PMhEKzbMoQJUWM0fbfiJJK12C+zZFh3GRVpEltcxNU4ULxQENlcJDjIl44yAQyYXaKqMJbdMnQTvf33s/0SHtmpIaVuOAD6J9RiTMxduAOYixlSI7G5O3+UKzyoa2sPm6GLhtu7vsMvdVN9z0cqT7pMD7aGWFr/MB8pIksaEsdmeyLv9poWaDZRvLvqooqKMsOjnKFJxD4Wkty6Vf/o4MaKHbnr1ytYPpFDEXgpqF/WWg1W+FIBLojI/bY4f8aKW/uOb6UYgKExozmwDUcjo7aIdk5Q/tERdxz0B+piukTugEFxGevFS4ngvZmiPix0i5gQxKua0kMumOHW3Fn05GMHTSTaMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(39860400002)(136003)(396003)(82310400011)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(26005)(5660300002)(16526019)(8936002)(8676002)(40460700003)(2616005)(2906002)(86362001)(356005)(82740400003)(81166007)(36860700001)(47076005)(36756003)(83380400001)(336012)(426003)(44832011)(40480700001)(70206006)(70586007)(110136005)(478600001)(41300700001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:11:27.9215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0a03065-f813-40c1-0514-08dbb851267f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7772
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

The code is not called that's why remove it.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 .../zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c  | 123 ------------------
 1 file changed, 123 deletions(-)

diff --git a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
index 45102302dc2c..166e61431ba5 100644
--- a/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
+++ b/board/xilinx/zynqmp/zynqmp-sm-k24-revA/psu_init_gpl.c
@@ -602,129 +602,6 @@ static unsigned long psu_peripherals_init_data(void)
 	return 1;
 }
 
-static unsigned long psu_serdes_init_data(void)
-{
-	psu_mask_write(0xFD410000, 0x0000001FU, 0x00000009U);
-	psu_mask_write(0xFD410004, 0x0000001FU, 0x00000009U);
-	psu_mask_write(0xFD410008, 0x0000001FU, 0x00000008U);
-	psu_mask_write(0xFD402860, 0x00000080U, 0x00000080U);
-	psu_mask_write(0xFD402864, 0x00000081U, 0x00000001U);
-	psu_mask_write(0xFD402868, 0x00000082U, 0x00000002U);
-	psu_mask_write(0xFD40A094, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD40A368, 0x000000FFU, 0x00000038U);
-	psu_mask_write(0xFD40A36C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD402368, 0x000000FFU, 0x00000058U);
-	psu_mask_write(0xFD40236C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD406368, 0x000000FFU, 0x00000058U);
-	psu_mask_write(0xFD40636C, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD402370, 0x000000FFU, 0x0000007CU);
-	psu_mask_write(0xFD402374, 0x000000FFU, 0x00000033U);
-	psu_mask_write(0xFD402378, 0x000000FFU, 0x00000002U);
-	psu_mask_write(0xFD40237C, 0x00000033U, 0x00000030U);
-	psu_mask_write(0xFD406370, 0x000000FFU, 0x0000007CU);
-	psu_mask_write(0xFD406374, 0x000000FFU, 0x00000033U);
-	psu_mask_write(0xFD406378, 0x000000FFU, 0x00000002U);
-	psu_mask_write(0xFD40637C, 0x00000033U, 0x00000030U);
-	psu_mask_write(0xFD40A370, 0x000000FFU, 0x000000F4U);
-	psu_mask_write(0xFD40A374, 0x000000FFU, 0x00000031U);
-	psu_mask_write(0xFD40A378, 0x000000FFU, 0x00000002U);
-	psu_mask_write(0xFD40A37C, 0x00000033U, 0x00000030U);
-	psu_mask_write(0xFD40906C, 0x00000003U, 0x00000003U);
-	psu_mask_write(0xFD4080F4, 0x00000003U, 0x00000003U);
-	psu_mask_write(0xFD4090CC, 0x00000020U, 0x00000020U);
-	psu_mask_write(0xFD401074, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD405074, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD409074, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD40D074, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD401994, 0x00000007U, 0x00000007U);
-	psu_mask_write(0xFD405994, 0x00000007U, 0x00000007U);
-	psu_mask_write(0xFD40989C, 0x00000080U, 0x00000080U);
-	psu_mask_write(0xFD4098F8, 0x000000FFU, 0x0000001AU);
-	psu_mask_write(0xFD4098FC, 0x000000FFU, 0x0000001AU);
-	psu_mask_write(0xFD409990, 0x000000FFU, 0x00000010U);
-	psu_mask_write(0xFD409924, 0x000000FFU, 0x000000FEU);
-	psu_mask_write(0xFD409928, 0x000000FFU, 0x00000000U);
-	psu_mask_write(0xFD409900, 0x000000FFU, 0x0000001AU);
-	psu_mask_write(0xFD40992C, 0x000000FFU, 0x00000000U);
-	psu_mask_write(0xFD409980, 0x000000FFU, 0x000000FFU);
-	psu_mask_write(0xFD409914, 0x000000FFU, 0x000000F7U);
-	psu_mask_write(0xFD409918, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD409940, 0x000000FFU, 0x000000F7U);
-	psu_mask_write(0xFD409944, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD409994, 0x00000007U, 0x00000007U);
-	psu_mask_write(0xFD40D994, 0x00000007U, 0x00000007U);
-	psu_mask_write(0xFD40107C, 0x0000000FU, 0x00000001U);
-	psu_mask_write(0xFD40507C, 0x0000000FU, 0x00000001U);
-	psu_mask_write(0xFD40907C, 0x0000000FU, 0x00000001U);
-	psu_mask_write(0xFD40D07C, 0x0000000FU, 0x00000001U);
-	psu_mask_write(0xFD4019A4, 0x000000FFU, 0x000000FFU);
-	psu_mask_write(0xFD401038, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD40102C, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD4059A4, 0x000000FFU, 0x000000FFU);
-	psu_mask_write(0xFD405038, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD40502C, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD4099A4, 0x000000FFU, 0x000000FFU);
-	psu_mask_write(0xFD409038, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD40902C, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD40D9A4, 0x000000FFU, 0x000000FFU);
-	psu_mask_write(0xFD40D038, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD40D02C, 0x00000040U, 0x00000040U);
-	psu_mask_write(0xFD4019AC, 0x00000003U, 0x00000000U);
-	psu_mask_write(0xFD4059AC, 0x00000003U, 0x00000000U);
-	psu_mask_write(0xFD4099AC, 0x00000003U, 0x00000000U);
-	psu_mask_write(0xFD40D9AC, 0x00000003U, 0x00000000U);
-	psu_mask_write(0xFD401978, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD405978, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD409978, 0x00000010U, 0x00000010U);
-	psu_mask_write(0xFD40D978, 0x00000010U, 0x00000010U);
-
-	serdes_illcalib(0, 0, 3, 0, 4, 0, 4, 0);
-	psu_mask_write(0xFD410010, 0x00000077U, 0x00000044U);
-	psu_mask_write(0xFD410014, 0x00000007U, 0x00000003U);
-	psu_mask_write(0xFD400CB4, 0x00000037U, 0x00000037U);
-	psu_mask_write(0xFD404CB4, 0x00000037U, 0x00000037U);
-	psu_mask_write(0xFD4001D8, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD4041D8, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFD404CC0, 0x0000001FU, 0x00000000U);
-	psu_mask_write(0xFD400CC0, 0x0000001FU, 0x00000000U);
-	psu_mask_write(0xFD404048, 0x000000FFU, 0x00000000U);
-	psu_mask_write(0xFD400048, 0x000000FFU, 0x00000000U);
-
-	return 1;
-}
-
-static unsigned long psu_resetout_init_data(void)
-{
-	psu_mask_write(0xFF5E023C, 0x00000400U, 0x00000000U);
-	psu_mask_write(0xFF9D0080, 0x00000001U, 0x00000001U);
-	psu_mask_write(0xFF9D007C, 0x00000001U, 0x00000000U);
-	psu_mask_write(0xFF5E023C, 0x00000140U, 0x00000000U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000000U);
-	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00000000U);
-	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000000U);
-	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x00000000U);
-	psu_mask_write(0xFE20C200, 0x00023FFFU, 0x00022457U);
-	psu_mask_write(0xFE20C630, 0x003FFF00U, 0x00000000U);
-	psu_mask_write(0xFE20C11C, 0x00000600U, 0x00000600U);
-	psu_mask_write(0xFE20C12C, 0x00004000U, 0x00004000U);
-	psu_mask_write(0xFD480064, 0x00000200U, 0x00000200U);
-	mask_poll(0xFD4063E4, 0x00000010U);
-	mask_poll(0xFD40A3E4, 0x00000010U);
-
-	return 1;
-}
-
-static unsigned long psu_resetin_init_data(void)
-{
-	psu_mask_write(0xFF5E023C, 0x00000540U, 0x00000540U);
-	psu_mask_write(0xFF5E0230, 0x00000008U, 0x00000008U);
-	psu_mask_write(0xFD4A0238, 0x0000000FU, 0x0000000AU);
-	psu_mask_write(0xFD4A0200, 0x00000002U, 0x00000002U);
-	psu_mask_write(0xFD1A0100, 0x00010000U, 0x00010000U);
-
-	return 1;
-}
-
 static unsigned long psu_afi_config(void)
 {
 	psu_mask_write(0xFD1A0100, 0x00001F80U, 0x00000000U);
-- 
2.36.1

