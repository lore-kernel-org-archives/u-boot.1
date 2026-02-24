Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EABB4E9B250
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 12:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1814C83DEA;
	Tue, 24 Feb 2026 13:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="eUUVhhXq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24A8F83E1E; Tue, 24 Feb 2026 13:04:39 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 671EA83642
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 13:04:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHR25LTQ0mCvQ9X8gAWkFkXSHNnhRwsbxGB9T8EnM2VuQX5GIWOiAVGdBdx7Lv2bRDuOR6Qw+Xar23yV5R8GRMun/rdfYl3PrRHvgqdWxSg/MPaZak/esYoPCbu4nA0LG/UhfZ6TkyLQNvZ6fWxvArpzWGx+Y7SfQ23VCeli6q0RonpU2EiD+gLQzrPGMVH59by2KsnnV5OKmBumvtWY1LhUqFZt8dvQAhzxRlJvykxd34EO9NKsZ9Ln51stjcP/kYxoqu7jjYJhqyXzEe/29cio4hzzdVRtlARykIIdXVHMx53e1y1SIAJ+uwFYn6uRjUggFJTVFs7IqRN2TCMZqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFXNv6/nX7YeIpWmN9GLldG58xKwFZhnt5uQMEAuN/8=;
 b=KhnO4wBQ3TVGtHmw8n5lx0FZc7Cj3nchwhgfUt/Rqa3PMXE5URgqQFEuXprh6gm+HkSZQLSuaGMnum8+1UxoHxt+8r458W0CQX0K5wkBUfTPznpYZBn0SUlxcgtLiaLn+C5GgybeY0jyzjyn4OyMF38Ma8mSPS8x7sPycokKsD+aFKA2yDXoPUoK7Pz+naKFSdKNtXGsSmYHjOH2igmBoBXsNoSLnaWt5icE8dAgKhyu5i1hfVtUZyna/hDzuzsDKH+V5wzKX+Rd3WhOkT1T8X/b9kOoGohFFZojlQQAKo+ZW9rvFD/Vomu/Kj97y8RdCbslbtlqonE2j/BnPXPI7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFXNv6/nX7YeIpWmN9GLldG58xKwFZhnt5uQMEAuN/8=;
 b=eUUVhhXqTeK6BPB/kYVx1rX/Cr+loMVsgGJyoC0wju+18ZCLBk9alRrT0lTD9s9Tzs8ZVVJ1Tl4vOc8nQU/8xZ/c7Dr+uO7Xcn7X/VskLFsoPOnQtLAqwNX1lRPI8FaejrN+R/oAT+J781JpftYtKIoABsm9utrIaC0dzxefMZg=
Received: from BL1PR13CA0005.namprd13.prod.outlook.com (2603:10b6:208:256::10)
 by CH3PR10MB7631.namprd10.prod.outlook.com (2603:10b6:610:180::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 12:04:32 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::39) by BL1PR13CA0005.outlook.office365.com
 (2603:10b6:208:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.22 via Frontend Transport; Tue,
 24 Feb 2026 12:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 24 Feb 2026 12:04:30 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:30 -0600
Received: from DFLE204.ent.ti.com (10.64.6.62) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Feb
 2026 06:04:30 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 24 Feb 2026 06:04:29 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61OC4QPZ2202322;
 Tue, 24 Feb 2026 06:04:27 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <vigneshr@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH 0/2] Update AM62AX and J722S CPSW PKTDMA Resource Sharing
Date: Tue, 24 Feb 2026 17:34:46 +0530
Message-ID: <20260224120557.1476390-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|CH3PR10MB7631:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b6ae72c-9a49-4a16-bf1c-08de739cdde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nH3g2s2i5uoc5gh0+rvhILF4OdpC+0RqyedbYlxgKtADT4TJxMQ3XxWgmhpb?=
 =?us-ascii?Q?uIcLlhaHUoNADEDQykNDkkLjZkONTw8GHbZzgSJQKRhSflL7CmGkqxOS1aYM?=
 =?us-ascii?Q?JvDiddFn3v9gAS6ZfoJlVyiHXVdGtg+p/SGlR2zeE+HAE3/73kG0ueP4p3vW?=
 =?us-ascii?Q?Zr/5QvjmUiaB4kofUfbsX0ZHEFe/yEVMGlxl2dHwLUAQMGjMDiTbgnFbcuYN?=
 =?us-ascii?Q?JJURekfBl0QBxBkl5I9luEF3dehP0oWcV6QzFq+O68wUM9+GHmCT4qr9lVTR?=
 =?us-ascii?Q?1wLHACQGKNjOEHiiQgC584f1bf88Py1JZbThbjzZoYMSQVANJAnn+7JxUGeq?=
 =?us-ascii?Q?TdO8Dtj0gEQhlB74HHFD/IW/hzgW/r7yfRPaq2xSeT5Fjy0wNxD4wZ6TGXqa?=
 =?us-ascii?Q?+xUo5e7skzOJ3OtVqHsJW+JoFg8C8kjn7vpKV2/F2GIPsjugDySEa2QlxkeI?=
 =?us-ascii?Q?lLVfIn3g9M6MAgK4R/VAxPDlr0dNXkX4dginJsP7oGGcqomWxZ5FsD961q7c?=
 =?us-ascii?Q?IlIv3E5rOrZsOS+72K6AhTdf3uCbUfEagxTV1b/Wb6Br5FIKcM1yHRiF72HI?=
 =?us-ascii?Q?RwywTCOpt52jmUoSbLcxq9UNe4JGdQTGtXzOuKbdERirnrBk4nLXpDyJQTKk?=
 =?us-ascii?Q?SpY/Dxb5RV147AdDHllL+6G98BZFRS3/uP3lio/3AuZ/0jVi2DUsg8wAxZ30?=
 =?us-ascii?Q?aFZrWaPiDw017Zjy1M1o1SWAmFJDWz3xCUPgOc9lcfE5V/EB6apGeYY5m2Vq?=
 =?us-ascii?Q?28kJb/p9x3iravStCnrOAs6nrbsHwPPLliHZezY51+g8Hv9UuMXXV0HVY0el?=
 =?us-ascii?Q?GBnuIJsT+z8PUqUIq4+z62hlEvWtn7Op6VgVGHDJKQTf5DP7Ink63UHkjdn0?=
 =?us-ascii?Q?KlKEk01R6+1fOgr6qQP/l01g4XtxD5/9PByX1lXjsWEWRMMu0exhmswF9BB5?=
 =?us-ascii?Q?9sZy/Un49H0DHhbfpV4+kYaIjKh+1cU1iKZFUIBqXss0NJSvzq9lByiKdAQ+?=
 =?us-ascii?Q?c8cM8PfDDpCnTVfhRDOaQeXBOpamCwLK/wJrkPcY/k1tu5Py5x/Bu8GcBwKi?=
 =?us-ascii?Q?7ZtI8mXclP3TR7ywbHipAuKtcxEPHxxb8EHICT1bEE+MtomHeXRy+fOnRhw0?=
 =?us-ascii?Q?yfJ0X2gW797UwoS3SJWV3OiNG5u2b1J2a8TGyJHRL6ujoGQ7c2iA1BXz9xgo?=
 =?us-ascii?Q?M03OJaJc7PveVfNoKoVpiF34v/0H4rh5cN+cSCBkyeZ93LWBmT8OvzUmFjK1?=
 =?us-ascii?Q?kmus6s/N3O5rXQ9/rlfNK2Jd1rwXsuCor1s257wJ8Y08nM5uRajcJTkUaWjN?=
 =?us-ascii?Q?CdTT99So6OmkhhirGr7eSzLNpi3hbkwyRnVqZhLMBXgJ1OzA43Hv9skThVpj?=
 =?us-ascii?Q?Xp7S7fZ1mfF9sZXFuuU+1uQFZuVtnUR46kqNmMHKU6qKHlnfAC227Ov2Ups9?=
 =?us-ascii?Q?kj+nd/zGarl0PHpfi73/21SBgGuqpdcJiCB+BKOuQhYH74cVe7auXkKjfU/V?=
 =?us-ascii?Q?aC4qB4ohYnxR0wR/x3LWNUMa5eVEkgPDr+D/k0CfWnknmgp0+rgU8TL4ZsPS?=
 =?us-ascii?Q?XbL+Eu/Idv47XGBlbgY+BRylYNHW8F0pk4irAXUjiwTZ634KDACgsAHQhZ6Y?=
 =?us-ascii?Q?rZGn71quBAZrDnlcWbocf7Y=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v1yGyvqODvCa3ngYuX3JELg+TCXvjSfepHDFRGiYrUyiEwWj8BUwthu17t4xhEPQRYZ1XN/aFGRobNi3Jm4q6KtGFRS7LJGAr791QAHpqsWQuCVANy7jDb096eSq7lFcAs0PcFkSp2Ba83MXwae2pT4pPudATn4Jjc8MR/F6RZD3BCayKNppN7rZB1aRUNZhAYy2ysiRgLJ3H2YAXUaxs0r6guiF7W5I0fM/2m3Tl6TfkkFRNJaBkGE4Z7LU0nNvHxV7JsJFlffEauSSwjZ/XqKXye12TPZDKA6i5PlVjTWWGowwx6pwpKIKlHgO6vfl8/aR2otUQYe/I/p28h8m61KcCHnR9gxSzfOKbJPJ28sZbO1QKxdwvxVn88kGYrxuuqqLgjQWWVkbM+C/OfFTHO0rNjzmYlfkWh/bKaqrFXbcj5lrLfw34D08cO4aZKW0
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 12:04:30.6881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6ae72c-9a49-4a16-bf1c-08de739cdde4
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7631
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

Hello,

This series updates the resource sharing for CPSW PKTDMA resources
of the AM62AX and J722S SoCs while maintaining backward compatibility.

Series is based on commit
4f70106beaf Prepare v2026.04-rc3
of the master branch of U-Boot.

The updated resource sharing changes made by this series have been validated
with Linux running on the A53 cores of both AM62AX and J722S SoCs verifying
Ethernet functionality.
Test Logs:
1. AM62A7-SK:
https://gist.github.com/Siddharth-Vadapalli-at-TI/ecc69e5d9cd3f09ca767bc2108ce1d0d
2. J722S-EVM:
https://gist.github.com/Siddharth-Vadapalli-at-TI/d5b3509d548be194fbafb41480a6c15e

Regards,
Siddharth.

Siddharth Vadapalli (2):
  board: ti: am62ax: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
    CPSW
  board: ti: j722s: tifs-rm-cfg/rm-cfg: Update DMA resource sharing for
    CPSW

 board/ti/am62ax/rm-cfg.yaml      |  74 ++++++++++++++----
 board/ti/am62ax/tifs-rm-cfg.yaml | 112 ++++++++++++++++++++--------
 board/ti/j722s/rm-cfg.yaml       | 124 +++++++++++++++++++------------
 board/ti/j722s/tifs-rm-cfg.yaml  | 104 +++++++++++++++++---------
 4 files changed, 291 insertions(+), 123 deletions(-)

-- 
2.51.1

