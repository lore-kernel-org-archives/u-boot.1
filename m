Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EFFC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 04:46:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEA0C8329F;
	Thu, 17 Jul 2025 06:46:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TC3FzC1+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CAA5832A4; Thu, 17 Jul 2025 06:46:50 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A09283287
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 06:46:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRgFBG+at8ULMEomRxOEiMvrr2eEeCG+aYWAabukR6BM9XDPSI7NUiDVb0pYOwvQLu8xObPQukUIPeE0BORNzTBb4y1d6MVJHgdDV6Q9QbAXQlJoK4lSIxdcSL8z8s1sM5N9Tbb6lOV8haHhOf8ARXdVvUNoZKddacwpzQs7pKcEjT+pFCK5OFD6s250gmC4XoEe8MKwEhJqbURw24B/gMWjR2VMOmlWLJgSdmZnJvkzU9ip6LvjAlMFyhKqZemplodGq3UAIuE0GknlWbwzahXghyEPbFoYklyphozy9qtJCJUrtCUrl+g7pj01Fce1ydbC7rq8iVYEAKlNlqefNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BW+cJ2WJlNxL6FavJKdGheobmznLcL8JS1PlVjTy38Y=;
 b=o2gIdOCH61/rVE2Eon47ThCWZlSQ8SiINhap/dS5CZW4aYkv6dTYv02jzc00oiQ8tSmsn8BW4QVUJ/qKNLsZyMKB+abpPIKCm9L9jVMerIOILZPiXHLqmZUfasBSobNzzE4p65+KaSadi6czrbfvyOZoC90SmJamdEiJXraEnIKmndLWF3+VRzCXWEyrcQWqJodXIyIx6I+DQPWa/zpsLlqw+DMEMLuhCpXo7g69SztjpfF5WWzYudmL0GpunF/AaubtuknO3J6tx4obESjxaiqeb4MFsX5fSiWb/1jir07i0GRc5OtvMTzUEqqY2Sup25YtXlxpLEcsdTEVt1MH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW+cJ2WJlNxL6FavJKdGheobmznLcL8JS1PlVjTy38Y=;
 b=TC3FzC1++f0Xgp1BL6TycrgG9eJnrhJzpabnvtg6TVd2W6q9ecBuBQ4XWgsdv2NhAU/Yy16r7IKeBNncrfk24XyQZEqcxhOpdCzxvOjm0ar/9zeQYRBfOYFKlEl6lRXF60a8z/iMiVSx2sy5ZJHlYU1BxTwHpn3AKcbGI6asYFk=
Received: from MW4PR04CA0032.namprd04.prod.outlook.com (2603:10b6:303:6a::7)
 by CY3PR12MB9678.namprd12.prod.outlook.com (2603:10b6:930:101::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Thu, 17 Jul
 2025 04:46:42 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:303:6a:cafe::fd) by MW4PR04CA0032.outlook.office365.com
 (2603:10b6:303:6a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 04:46:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 04:46:42 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 23:46:40 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 16 Jul 2025 23:46:39 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] gpio: zynq: Fix the documentation warning in
 zynq_gpio_get_bank_pin
Date: Thu, 17 Jul 2025 10:16:32 +0530
Message-ID: <20250717044632.1353588-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|CY3PR12MB9678:EE_
X-MS-Office365-Filtering-Correlation-Id: 52086b45-a6d5-4a0d-570b-08ddc4ececf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hHLJukwIeVYQ3ryyOfCBEdiZYRjSEp4yfVKcvNj43pBJAH4G1EaNSwtkYFkd?=
 =?us-ascii?Q?UNvea942l2tUK+E0gG2Hs6XFnzL8r+jccTiOP3OgdwgOXQBsfync2Cut35PR?=
 =?us-ascii?Q?a1AWEXdDHNQPIYePuxvj/t5xNvGEWY3wNwTk4oupvPUtQP/W8hCMNwBsEFkD?=
 =?us-ascii?Q?YsABN7CqHO3RcSR7rgrHIZEmXqmZ5zuXYkVKmcXf7payDckP2Oiw/wbKp/0j?=
 =?us-ascii?Q?dg4ey9p2o0fs5Hg6oLXracJKmCKTbgCFrEnXS6mqF5r7wFFZy94sz1zSe6QV?=
 =?us-ascii?Q?B+WQ+PD84bbqobBoPR1hVdDCax3yCrSzgpzoJmuStq0AkzZZXbxxIHgeg353?=
 =?us-ascii?Q?LwfpqZREsr63TemRoYtjBOaOW9BtaJf4gCs8Ed5nfMsJpQyXiTnkidwQ4kuo?=
 =?us-ascii?Q?jXqnbvDres56XjOxNsED5Iz0gwiSYtzjWdgtWAq3ZTDES7WF8AGoCSluBug6?=
 =?us-ascii?Q?D77K/6lb2NZP+faaUoXIG7QLbS5EVcAJBXtrsC6DUFfpq2xm7v26tJzIoAmT?=
 =?us-ascii?Q?ZmBRPaT7shkT4Uc/3jTe/CGUv7dBPXatl8SN2SfvcJBuCtxBeDlgCVNFxb/f?=
 =?us-ascii?Q?Fyaj/47MHMf2TA8mDHIzrFLJxwXvShL0ORCs7vobuAF4cdwVGHCG08X8FLB3?=
 =?us-ascii?Q?qmYQ8lp0XrsFQqgziiVkMU6OQgPK765A5NppxIG4yXhxJF4UVFluOPIjcMCS?=
 =?us-ascii?Q?M0O43YlNABYTRogyBvNeSd5f3LPPxIo7AancsSQA3vjGnyMNsBNdvseEFZkO?=
 =?us-ascii?Q?zSNCcQc8v/jdp6mFrRi6iVSKs+5avKPMHrGAGXf22NO1+GoQBcdCWZP+0vKw?=
 =?us-ascii?Q?7ipQaueQW6pucKgl30iH+mxABMKK6t9wtkXhmceLzqa8I1fPSkXNbkCXN/fd?=
 =?us-ascii?Q?8Lv3nrxqiRvZxckACGJSL8iicCXjq3JernYhB0SJGNfyD9aF4k9FjpqzvWqe?=
 =?us-ascii?Q?X8Lhg+DIiC3ijxAgyRB2Vb2Usk8rhbuIQVvkEmfzPBlEv07YuxNcJ6CoKuzH?=
 =?us-ascii?Q?YVy/WC+G3A9rtogZmvEfd9Pn/MKLtqBVm51PweVOANkO14nD5/aKAjJVQz0H?=
 =?us-ascii?Q?mfnfUkXSupw6RSU3DaVKH6+SftJlKZFvuBHEvx+v+KWJ0FoCUVPpslFdq66y?=
 =?us-ascii?Q?jnab1ore5+eyor1CijFS2J4C0AHxqtfv0mhB6D3d/JvUTtY0+hvs+zKVGz9D?=
 =?us-ascii?Q?R+neSrdKTJ2QSL6muAZqbvUpqE0WWjhFevqYgNTEH9RaqXdxbAadRbw25t9i?=
 =?us-ascii?Q?hZfvQAHO4xMvNlEg11/zxz441SUW9dWJTn3wK0Ji5v0WBMiyW7bIQaO3k/p8?=
 =?us-ascii?Q?xTi/w0dd7Pn3snNV6rYNdUosPyC2Ufpj3HZ9lB2ZSt4wnHeJB8ahoC39lpbW?=
 =?us-ascii?Q?c4wmmEArzqjJuJ8CRGvRmFaDZGHvVXKwA9ofy+0fOOVcOB6Ay3sfKXUs4GF+?=
 =?us-ascii?Q?cydT8ntnngZVOfj84u1PbOXppygiYeBv7PnKwKt84eRyEnvy/YY35Q1lWgXg?=
 =?us-ascii?Q?eHwpaHSaWUaEePLOiFRpmWfHRPsTr0ilj5K1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 04:46:42.2620 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52086b45-a6d5-4a0d-570b-08ddc4ececf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9678
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

The 'dev' parameter in the zynq_gpio_get_bank_pin function was not
described in its kernel-doc comment block, leading to a Sparse warning.

drivers/gpio/zynq_gpio.c:194: warning: Function parameter or member 'dev'
not described in 'zynq_gpio_get_bank_pin'

Add a description for the 'dev' parameter to satisfy the documentation
requirements and improve code clarity for this function.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/gpio/zynq_gpio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/zynq_gpio.c b/drivers/gpio/zynq_gpio.c
index 7db58c70663..ef4f33f84e9 100644
--- a/drivers/gpio/zynq_gpio.c
+++ b/drivers/gpio/zynq_gpio.c
@@ -184,6 +184,7 @@ static const struct zynq_platform_data zynq_gpio_def = {
  *		pin
  * @bank_pin_num: an output parameter used to return pin number within a bank
  *		  for the given gpio pin
+ * @dev:	Pointer to our device structure.
  *
  * Returns the bank number and pin offset within the bank.
  */
-- 
2.25.1

