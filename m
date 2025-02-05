Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D46C02194
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 08:03:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC7E480821;
	Wed,  5 Feb 2025 09:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="m5Rdg0uW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3903E8081A; Wed,  5 Feb 2025 09:02:43 +0100 (CET)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20707.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::707])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A8BD807EE
 for <u-boot@lists.denx.de>; Wed,  5 Feb 2025 09:02:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iq5qG6pUENg1YQvUNaPDJ/PznsR1OtImoc/9b4EOQP5Wv8NWpCCtWWvitLjewB76m91afZp/GaRK7uYkQcdtUQdcCnlq4ywDrwqySJgNlTVM6oJ6oMGNzIHzruirW8kALqGv+MBBzhS4WIKCTk/yNgAPKWaTKF5eobHnLX+39Rs6Ui1YwU164i7W2Ird89sA3ZrCs6lXN+rlhBV5uJ35i3elbUOi5yiPEU1AlAISzudXf77U1+6bbjpKAPZw2qAO+tcAEeTpvcihGXXTeGWgnMxn3OvGBRQnFusFngaGTOLjwgMbkaacEd1gXQFoNVNT2ryoROdzd7o69AxX13nPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrURTLPssF8I+CFG1pMmR7vq04AcJTmyNvSVCPUCLFM=;
 b=RxQM83a6r+C2ISS5mtCp394xRGdJQJsFft2gePBNWLSbP0SKcyK5K+6bIpCYzxWFmqmh2Qlz7q9Xu/0uo+9AxMOqKdWuqjjT9jUyxU3cyQ6g7+hGFi4wEaKx5e6jULcHWercqkYfWSlkKsu2k4IdB5xMj4fzyMZT4yTZyOjfV1qhbQVkmQeJlhklPf1Ql4cSZwebhiatrAhOu3LeQlB+/OIaQwWeugAfdQWxwwrtN6HJwrCzj4hj4NJsu4cwtij8cQ+gGUW1Ur27yvATtDGY72QRNruoMGIdsTtKhPLBsMSoklRZNLdxbg7v/afFGPZTxEUQAH2zoZQcxODNc7N/Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrURTLPssF8I+CFG1pMmR7vq04AcJTmyNvSVCPUCLFM=;
 b=m5Rdg0uWb9BewmjA/eWNMsskk+CpimspfBJU8lmWLgKrDHbNK1NFcBPNpa1CRyVKn6AftXL+11paHhC2fUFM9rPe3jyFzO0pd4OxuGUJyUQI3nAROPL5BxefeIRl1cubErGoK8muYWi+cqrFkV+xVhVG7UD0xNmoGz2u+2kpv8tarVfRG+vxC0XnhV+QhW75nSf6iAi+b8tdreywZ+B5AwdOLhKkQuwQKaXDjzm8+ysM4MygX3GRMrg8+dnbtc17SmkDc8nqSNZNOYl7+/dVMhd1M/riKSPjKv6geJpPgia/LCN038PRj0n0BfbpMfTRa27PcthegsCq6qlsh/RR3g==
Received: from CWLP265CA0357.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::33)
 by AS4P195MB1937.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:581::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 08:02:39 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:401:5a:cafe::85) by CWLP265CA0357.outlook.office365.com
 (2603:10a6:401:5a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 08:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 08:02:38 +0000
Received: from Berlix.phytec.de (172.25.0.12) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:38 +0100
Received: from ls-radium.phytec (172.25.39.17) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 5 Feb
 2025 09:02:35 +0100
From: Daniel Schultz <d.schultz@phytec.de>
To: <w.egorov@phytec.de>, <trini@konsulko.com>, <ggiordano@phytec.com>,
 <joe.hershberger@ni.com>, <u-boot@lists.denx.de>
CC: <nm@ti.com>, <d-gole@ti.com>, <n-francis@ti.com>, <nmorrisson@phytec.com>, 
 <m.otto@phytec.de>, <bb@ti.com>, <upstream@lists.phytec.de>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 10/10] board: phytec: phycore_am64x: Update environment for
 fitboot
Date: Wed, 5 Feb 2025 00:01:46 -0800
Message-ID: <20250205080146.1944928-11-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205080146.1944928-1-d.schultz@phytec.de>
References: <20250205080146.1944928-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.39.17]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Berlix.phytec.de
 (172.25.0.12)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A79C:EE_|AS4P195MB1937:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e660cea-33db-497e-5794-08dd45bb7570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7vfSuefP0gsxLGvXBpT6gspAXxOo0z46XkHGXWDV+9xjdhbdMWvXs7oWqJ5k?=
 =?us-ascii?Q?rRV1Ey0kBpWnBDFY51rdpfsrKidFLRfpSmfg/MybkDqwAt1yvE8WLsc11D9k?=
 =?us-ascii?Q?7zNVxmHDkVrmZsGdVbW3A2iUw0UpAN+SHP+Ct4IwsNA/8GPmzspvUujEt7C/?=
 =?us-ascii?Q?PXIUL1VvtnhXotANko6Db9Zd5qquVxSGlF3otWhwv3rFMQlM7Am9Uo+A3OWP?=
 =?us-ascii?Q?HYRdhvcUmszlf9ZEZ43D3IpQJ0E7566p3YRqEvlnBAqHz9zb5p/AHYSwdqFl?=
 =?us-ascii?Q?cQZ32BErOngi+quRyrw4ZflKmwyywOWnB6MD0pzUpoFaMU1xFxND/JdFSnTu?=
 =?us-ascii?Q?cjj4GUmAkVo4Z2jLz3sXlqgEMAIYa1CFezFyLRjUK7tn0YieuLu6Ds2s6DDf?=
 =?us-ascii?Q?zIeh2qZmzXGVmh7XJNxM0Y4HJTd4GAAZa/BQA5w1Ow7rYfZ/hDCGqKTN4SGf?=
 =?us-ascii?Q?jYdqaUusq6LxFbczP0t938VxCqpmwYEP4ImzOepMokORrqdO+nPRUldRMnEf?=
 =?us-ascii?Q?0Sl5VeODZNT3R9Ki0DztahQKLtSszPy3DErGg4jnyi+IFu6Pg4CLpKTAf95g?=
 =?us-ascii?Q?o/fD6E78D+1QE4GZnHvxk6kSNRiNzO+clwqIQIYbhdpAFvpk7E6u7ei5ELBT?=
 =?us-ascii?Q?mAIAgRP3t6xax57ZTuyJ9hxnDMjWMBhWPiXqJN80ZB35uDX3b0eIg7zvUx9c?=
 =?us-ascii?Q?Ri2bVE/iUE8KbWXiO2Rmt4c1/4FLCnDujBr3OInlBa0qeoD/PqKwdRX3+7vB?=
 =?us-ascii?Q?UIxK2F7WDc0FZ1KqnAsiYZCqT9h+KT97LX5SIevo/x+qYMJNPMQuEeTwPo6V?=
 =?us-ascii?Q?LByJmCHDsuSz3U/mnqt0LHakYKfsglf/C3Iw/xGZumMJ74dF42INhKmLHV8q?=
 =?us-ascii?Q?M6Dx49YBwKq/b2Susmqfg7wmDE8iKllDa2JZUjot7gv2fdoXocXrRMqgONWs?=
 =?us-ascii?Q?u04lysDeX10egWn7L2MF7UAd2iR1JutA8IjIEpQ5BJcQIPoQwrEOu3QoW0Y2?=
 =?us-ascii?Q?y48/Ga2MJmpcgVL2QUVRHKjK3+Mm92GYKf3yPM+NoLWHYWWzMGcSzDSJNfnq?=
 =?us-ascii?Q?hnwuJqsoWdrgAD2KIx1RDh8C797QODevG1HaNcUy5vokPRSPxVtU4pCyaCZQ?=
 =?us-ascii?Q?l+63sm8pun74iCOg/e0VZoAZfGqqyFeILlTfw38M3Q6+3A5RWVXVz8do8EGc?=
 =?us-ascii?Q?lQ7jhGM0zickft+nTKIcB18lMkZb5hNGjDfyx94uE93p/LWxdaBJwX7Xlm/2?=
 =?us-ascii?Q?VdMMmWP5ZWuI1e15em4QIIfcRnnSxX39bv5fFGRnLWBjAU7jR/wYaf7phlH2?=
 =?us-ascii?Q?clcj0xaEFhpBmH+gb+WG2/fAz9R5S47L++mUBYofu2YDI7+h8OCaMGGnHjVh?=
 =?us-ascii?Q?qlmQVikdi5BaDHU/dTHk5/KDYmKFfv6Tz4yxDF+FSiHEjP9pfuNFlgWsTfvK?=
 =?us-ascii?Q?IZmHikUSLM1y/F1D6AjSkubQLVKF5b9NCXAoybvoOSeoRhrt/bF6reJOiSn7?=
 =?us-ascii?Q?d1Ym6Ue8teF6c5A=3D?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 08:02:38.7663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e660cea-33db-497e-5794-08dd45bb7570
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1937
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

From: Nathan Morrisson <nmorrisson@phytec.com>

Add fit_addr_r to the environment to allow us to boot from a FIT image.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am64x/phycore_am64x.env | 1 +
 1 file changed, 1 insertion(+)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index 3032b518e0b..3d5bd03118e 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -9,6 +9,7 @@ fdt_addr_r=0x88000000
 kernel_addr_r=0x82000000
 ramdisk_addr_r=0x88080000
 fdtoverlay_addr_r=0x89000000
+fit_addr_r=0x90000000
 
 fdtfile=CONFIG_DEFAULT_FDT_FILE
 mmcdev=1
-- 
2.25.1

