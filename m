Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8FCBC47077
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 03:20:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF7F3877E2;
	Wed, 17 Jan 2024 04:20:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jhJAl2tM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2480887252; Wed, 17 Jan 2024 04:20:37 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1D7E87620
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 04:20:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZhc0xZ8Zr7UuQwu6MfbusS8+otAJZy7994xGvfog8stNGgBjxbAPKzCyYo+q1oYmc4mOMy4iSG0nqr3K0106kA9ffHLR3n0L/dWu2/rE7OVNbDBtLSbYSYeu8JdO34KjKvACf7/mYwR1X1C0EkfiKYngmR3V3zSve2kYtQ+2SmdTL3sXYTZw6+fWr+7MREUXyUhUDMCf/ZN8sZHQnHT6i8CflQo0FxQeyGAZe6wy9OXNs1AnJH14u0VNT0w5leHuX1wUKsfbl2VZMnDLvjbU5JoDgLM1mJJDdjZIT+sm9EDhDiudzcx3sfMQ1wU6uRCa0sx1YA46ARx3Ls/NksLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BjvCQuUbejpn2NMkuw77ujQUUe45hUTq+suEzv2JkzY=;
 b=IfW8wOXln5iLgOnNnP7vXZuSen0T5jENKKNwlTx6+XCFgA8rT9ORMUR4B8u9CN4rlrgHrYaMR7e9+fq+jd3AHWT0Q6x7sP7XDRzoVRAPVGPZXcJUvWWB57zN4Q658XrADd+Yr1uotlRSX4ZFStoanO+RXOaKDZyPWRsGBd/k4/OVYtPax4mrTe2TrbohYtaDYGV2xkpgD6en+V+HIOCXHU+UwzLTrNDaXT4A7bNNMSMVYkJwuL3Ve55KYjIMvazhauXC6EbgA2oyMuxV67/SL9TXGmJFaSQwLdXGyYrBcXUym4nF4DgEGqFwIGw+K7rCyZ4a/q/3E8JCBAKjEkwBaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjvCQuUbejpn2NMkuw77ujQUUe45hUTq+suEzv2JkzY=;
 b=jhJAl2tMpWGp1hSkvxMqunbczzkuYJ/DRnof94WZxmqgn6X+7K75KuryPCipsjZz9Gs5KHGAfn5ij9+5WylbYMfeUW7RBN526K7vP406cQTdrLZ+uwTd+IbUUr21RlP0dTQDuEr1ohfle59jh5awU33Fi3Vmik1jlpviQvQ5Ifk=
Received: from SJ0PR05CA0082.namprd05.prod.outlook.com (2603:10b6:a03:332::27)
 by SA1PR12MB8095.namprd12.prod.outlook.com (2603:10b6:806:33f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Wed, 17 Jan
 2024 03:20:29 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::63) by SJ0PR05CA0082.outlook.office365.com
 (2603:10b6:a03:332::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Wed, 17 Jan 2024 03:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Wed, 17 Jan 2024 03:20:28 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 21:20:27 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 16 Jan
 2024 19:20:27 -0800
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 16 Jan 2024 21:20:26 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>
Subject: [PATCH v3 0/2] xilinx: Update the kaslr-seed property
Date: Wed, 17 Jan 2024 08:50:12 +0530
Message-ID: <20240117032014.1014084-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|SA1PR12MB8095:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e72c200-328f-4d1b-11ea-08dc170b4134
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lQ/tJxijHU3erME03x2qQnhUMemU5aBQ/wNh7/o6WfGjmo/pnFe8nVABkjislL2GVf+jJrCjt91vtv3P3aWDfgCJWRS1PxjleVnXZd5FRlpB43ekvEdaKd664GlOCyY4ucTCpTPZ5YafI2IGTPBh37nETPlHCYBwbnhEQ8mNnpge2J/9mlEjbdT5JQmeLiakZWlF2qMb/1gnwYXS/5rAe6f69lF4rE6HrDMvCtgBUGccDobw2tAKYu1EY4RTMDV6d+hGdrmi13J8GXFCL/+fbUf2vJ1xAZfQoujRAbFuTXMIfDjSQNSNlyo/lnScTvVzpqRio+wG57KXXO0JwB0CsKZ68n1GPBOCqyzympSsj54xOiDzbOK2iKQmVRwfOKjMveoF/Tx6N4Osl1q6BRgQim5M77SeLUzyOOC/rHuEOgKrtNEN/OKj8Lk4ZK5kYgE1LPiY0IkAB35iNHFWF+p99JU0RKQpv8BGq4fUuDbBCt+QuBGNtD5dxyuA+m63sJUkaAcyEGdymoK5jA3/jPtrU3/10dcvxS9zF5est2eRFv2VTKiYtgHsicTFmvzDS4xByNc4xAZ/Ochu16Cxrs0HxnrcgVW3NXVGg9WyLwlN09jH+VH7FmaLwr7zjgp9Rwr+oH/OElI88uqnpJ3NSp5gmNNBxWQ/HVUDOdooUUZ4qQ3KciutM/2N2/IKNX4p6FLYNVvIspn6dXoA6ggzbxi0OIhR0NpqP9kp3DV+R6FF8iweu75mW5N6LX4xUDWO2CTYB3+1Vg7CazGUqvamrZ6Ow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(40470700004)(46966006)(36840700001)(6666004)(8676002)(4326008)(8936002)(2906002)(4744005)(15650500001)(5660300002)(478600001)(54906003)(70206006)(70586007)(41300700001)(6916009)(316002)(356005)(40480700001)(40460700003)(82740400003)(36860700001)(86362001)(81166007)(36756003)(107886003)(83380400001)(2616005)(426003)(26005)(336012)(1076003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2024 03:20:28.4528 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e72c200-328f-4d1b-11ea-08dc170b4134
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8095
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

Update the kaslr-seed property and enable the config CONFIG_OF_BOARD_SETUP.

Changes in v2:
- Created macro for size variable.
- Removed malloc and created array for rng buffer.
- Added debug logs for all the apis.
Changes in v3:
- Fixed the return values.

Venkatesh Yadav Abbarapu (2):
  xilinx: board: Update the kaslr-seed property
  configs: zynqmp_kria: Enable CONFIG_OF_BOARD_SETUP

 board/xilinx/common/board.c          | 49 ++++++++++++++++++++++++++++
 configs/xilinx_zynqmp_kria_defconfig |  1 +
 2 files changed, 50 insertions(+)

-- 
2.25.1

