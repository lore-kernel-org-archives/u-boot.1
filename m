Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542B2D3B7D2
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3297890B9;
	Mon, 25 Nov 2024 05:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IX5G6qPQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE0B899E7; Mon, 25 Nov 2024 05:13:37 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9306D899F0
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SSvh5M3wNDFgSG1rQA/Jhc0CeYUo8A7qudOY0HCgT66jp6ehJJxBJrO9C+CXp/wrDYWOIogaZhRbyoYkIu7G8O9ORmDriu3ngjVHjUZ6aXaZQPTFAO1Sy1AArKUDvsK9IpZv/5j6eiZr5EnV7GYJ2RPAbekWDH0IIy44t1IjO6rHHy8Qr1+PUe3ueKkWSwMyT4VjUF4NlxrKKn2yF32IKBXcw2M1bUVAn4JWLC+rAIyK7bVq3BjZcRzS0NaYutFREPU+wdGwLYyj3E0dPMMLapkPj3gOmXcGb2Bz5XhYosTEA60sxG2XscEr+2rEsFEVF/qQCt84YnDKVbbw7lh1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo/gOPZ/KcivXwd5XlbQvMCHEoPDXOwt78ciico7Rqk=;
 b=vL9WJxpeRjlSELiLhkeJtsCLxWskJe47J1x5nmmJBd+aFFRTkGGvhwCRQU1TNhOB2I1SdhYWRP5i33CznqDbHi9hyVVXCPEl5DqYTDbpLDmuQQfCu3XH8zqPI57yS7qjNgSz7CjBLUxW2PZoPMm7GeOnvRYW2U+vhvdaD8OIjg8LLe9ihtc9WSuGYia0np0jo1ZwK3t5efuYa//0c9ejOtw3nV3aiii8FaXDxxdp2n9HCjlgPHvqJM79jFEui4PsoIlb/lw/P6coALg/GH6btteIy/D7LiL8RVnntchyXxgSKfjt8ZTdsLDX+zyn+SLDt+fEMUbXuJBudcpLUkS1IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo/gOPZ/KcivXwd5XlbQvMCHEoPDXOwt78ciico7Rqk=;
 b=IX5G6qPQsfMotAX4BCJqtsdFpeLpd8JQ+nxl+oLY/C4/rjJHCX325HyAuscV5PgDQsgigVzcPWVZHScDOycJTc6A+NZ9gO+j/TGs5ARonECeNrC+GU1fErMRoDBOGHtlw1gchPNgE1q3vHaZCyr1LW81RtpnFnVmSjIFYbKEk3Y=
Received: from BY3PR05CA0033.namprd05.prod.outlook.com (2603:10b6:a03:39b::8)
 by PH8PR12MB6722.namprd12.prod.outlook.com (2603:10b6:510:1cd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 04:13:31 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:39b:cafe::51) by BY3PR05CA0033.outlook.office365.com
 (2603:10b6:a03:39b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11 via Frontend
 Transport; Mon, 25 Nov 2024 04:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:13:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:24 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:22 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 2/5] usb: onboard-hub: Fix the return values of regulator
 APIs
Date: Mon, 25 Nov 2024 09:41:59 +0530
Message-ID: <20241125041202.980-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|PH8PR12MB6722:EE_
X-MS-Office365-Filtering-Correlation-Id: d0f86821-05c3-475c-365a-08dd0d078598
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LXN4YWRZDzRcwOaAjO2wP3S61nKrWWZNP+MMboY896Jq73nwuz4du0jTde6f?=
 =?us-ascii?Q?KweH2OxO1ZiAZqd1odq6QCt9zkq0OJiHcyDvMoreSE+JR9sl0I0fgC51ca91?=
 =?us-ascii?Q?nfu8tSpVVXvq7qJ9oOkC0GZx9kusZgXF5ZxVFIRTZ7v7FvlNUt6VAK+lmA6m?=
 =?us-ascii?Q?ZzusPsdRj9nqmDMqrTzZvXR4rJGRp3ll5mAuy3MKRySgFoDYlHr1iJjbJRMw?=
 =?us-ascii?Q?os/Kvq8AJRwrY9TNgxx5ojYRwhKUClcmZuB7SYcLu3pOwWuUmqdHrZ0GXfcd?=
 =?us-ascii?Q?e5o4E0zDTjK62wTyG/9nC4+K2XP00nI9lDMOl8kFeNbZoaNaQj2vayx05UKM?=
 =?us-ascii?Q?zeP3poOzFCRl1G+8Ai0yll5Ye4jxyDQUhGUFxoZyGpvuoJAL+DyRHEzVuwvn?=
 =?us-ascii?Q?0aBzvtVpwfEo36VDmqJA9hqGXmy6BRKzBpCSlSli3CG67RiLINBSkwyKJccz?=
 =?us-ascii?Q?3/kKXbrkhG8Alq0zINwXmMiHUISasHcdeHqMPPOne4LmE6kSdMcszMdU0RC8?=
 =?us-ascii?Q?8NkcUbb0RpkMNPzvRRfXyG1kZzyS62gXo4O845AS+OJtyFDsFH2NsIiAbQA9?=
 =?us-ascii?Q?Q3XmzDYzjYxW5nRu3omdD6G1u/wFoFskrmT9K52q5LYpqA3kdzdLeeG/mjbC?=
 =?us-ascii?Q?A1UwUF2fImTNi1vnmiCE5/cnYWisqRK+cTO0nRoxYjs7FHszkgklMPfrUYcE?=
 =?us-ascii?Q?4PzJ6ZxWf/x+L42YD+ahRZRz3Ss2ClN44ipgc1BqqOyecB1/SLnoi7H+7gAl?=
 =?us-ascii?Q?qzCFQoAo8OQ/hBNQKTYFkAqsYkNsc+tn6bbUCnBlAJOY9P1o01EQ9soPn4NG?=
 =?us-ascii?Q?9Jhe0w1Fr+z7n+kwCCPU8F9nZ9BZwSEiZmtUIageGQcaQHVaFBPTxgSnVIEO?=
 =?us-ascii?Q?MzQ5Tnb6HjR8aMWmrySVuXUO3q0jfFcGW119tWz3MNjyAI3d5+dChZreZX0b?=
 =?us-ascii?Q?5kVWaG7JKsdj1czlhroAJPuKH/mvdadq3IGW9f4OEDxAb15CP56LFP44KZ3g?=
 =?us-ascii?Q?tRQvmLDQUjgKv9PPe3+cm/PgAwa6nuqJukfR6V7KjQJ15jRnfFqrGWXpYuYF?=
 =?us-ascii?Q?prBGlsX6z4esmLCrF3gI8jUXiHWQcVB/S7WSi0B9Tbb6JdT+TMlBflBHCnHL?=
 =?us-ascii?Q?heRn9AQwessKWbm+mbgH+HfnqX0Yg7je5fcnzP49lhOIhPUBcjQIVgoL2fV1?=
 =?us-ascii?Q?1x9s2xFzKWyua3+HeeBfxcWDPhm+UZrP6F1Zf5v+9Y58CgPfjtA6GpsxBqKq?=
 =?us-ascii?Q?/0HBWiwB/SnGnwF5WY2SYIy1o75E33KYJeKsRPrDURV42JhnLjrYJnq0actd?=
 =?us-ascii?Q?B75nuAfzXkzVIYWabOXrHdAAZH+K145chfHfccSvu5FdDKMCtKd4CME83xVp?=
 =?us-ascii?Q?XxlnbT2WJM2qFWwxlgELV13KGXeWTNz3yvpY3NtgxyA06vJhpRvqi6wRE7CR?=
 =?us-ascii?Q?q/UZ+UL3NjBQjNfYo1JgzWJbHKKCzjXY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:13:31.2193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f86821-05c3-475c-365a-08dd0d078598
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6722
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

Don't error out if there is no vdd regulator supply, as these are
optional properties.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index e4d1f12cb4..812e7749de 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -57,14 +57,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	int ret;
 
 	ret = device_get_supply_regulator(dev, "vdd-supply", &hub->vdd);
-	if (ret) {
+	if (ret && ret != -ENOENT) {
 		dev_err(dev, "can't get vdd-supply: %d\n", ret);
 		return ret;
 	}
 
-	ret = regulator_set_enable_if_allowed(hub->vdd, true);
-	if (ret)
-		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+	if (hub->vdd) {
+		ret = regulator_set_enable_if_allowed(hub->vdd, true);
+		if (ret && ret != -ENOSYS) {
+			dev_err(dev, "can't enable vdd-supply: %d\n", ret);
+			return ret;
+		}
+	}
 
 	return usb_onboard_hub_reset(dev);
 }
-- 
2.25.1

