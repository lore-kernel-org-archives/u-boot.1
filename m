Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D238BEE6457
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AEEF86824;
	Fri, 15 Sep 2023 13:26:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jf5IRqtN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6291186828; Fri, 15 Sep 2023 05:18:17 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20606.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::606])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BDDA866DA
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 05:18:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kZfXDucAjyG+rCRvMUY4z8YQQCLtP5Qvrvsp0CvUYM8XE5JSbrishYuM8McgW5vFw0w3UF8pHmxzab8XlKLk/TuXpI76Tf620sGy68ky+z6ui0Wr03gt/jL7/+wK8DePnQPz0slVKJ5IV6+cC7l7+OxdDh0PC/ta1ore/j/VZV/V45oG/7/yNRzf0RWV7jLWE0D+1zzdyaKD/ZhUax56JRhW9w8w4xhoESuWX59aFW9JoKHMqP3yf0LzSnxbgOoRn4ouRu2NTROwxe9XI7C1Zer/VamgjK3rOGidBfxOCRKvM586GSQhTskOcnYAAcUnIhNf0tkoTfMstTRxaSH/7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW5LcPrvea6Dp5JCGHR4YMD7DpQj8Lyh9AQun0slRm4=;
 b=cmMeMDhGGEz1SbruZg0FoZErrPrXgScKOyMgj3bN4dB8WvzRg1Mr4kstasTwXPKXBNEHA4NJInULc2k9rADQnNH37GCvGJCe2haYe9Mvxge82BrbtnRJo44gPFEG4/XqYJQ3uePfMQgvM/K8nrfHnR/E9wJEO34pEQo0teDPyR2L8mwSFssjGsvlny03dC0kEvOlC06UZXg1WUmv64pwQUGISW7BP/npHv81KCN3CSWg6n6ou/xNXNayC5ozBIoveZ+xKKZ1oAxr9GJai4ZstBVKBq/fSXoM10ie8ja0UPhMlYpKu2+l9P2xtlNjNcDUY6gCjvHIrIceH/vaWQfYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW5LcPrvea6Dp5JCGHR4YMD7DpQj8Lyh9AQun0slRm4=;
 b=jf5IRqtN+SuwHwXUu1uYCLqn0ov/OZl9I7+6lH6vYdugATUETRLxMGYUoXr2D2F0LjTeos3XyrE+29xoACPUssj6MTDdP2STpSDI48DgTvDSiC8+Up/pYV13/fMZeZIHlO6HoPy9xxHRyGvvMhsKZaSDkG/Yuf/ygw1lmdunuFw=
Received: from MW4PR04CA0090.namprd04.prod.outlook.com (2603:10b6:303:6b::35)
 by CH0PR12MB5124.namprd12.prod.outlook.com (2603:10b6:610:bf::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21; Fri, 15 Sep
 2023 03:18:09 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::c7) by MW4PR04CA0090.outlook.office365.com
 (2603:10b6:303:6b::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Fri, 15 Sep 2023 03:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 15 Sep 2023 03:18:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:18:08 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 20:18:07 -0700
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 22:18:06 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH v2 0/2] Fix issues for small sized data reads
Date: Fri, 15 Sep 2023 08:47:57 +0530
Message-ID: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|CH0PR12MB5124:EE_
X-MS-Office365-Filtering-Correlation-Id: fb78d7bc-1c43-41a1-c29a-08dbb59a62e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FT0EP50ZJdAau6e4lK2krotJTfh8ncefyHiyW40VJFeS8VRsPmJr4XyiEhLR5+qvjHpE80Iosdw0ppaM4OZcE+wK9kwbo7hJM8lyPNfluZJBU0wPMOjwhBgDd5xYv9zgeTemK6Yl40J/DftzC/E0fawph7nZIAPFAZ13awOAgeXfrWr4b57Xi2OnoB6TGIa4ltlypgaQLznrKv/dXOB3/kHikA8CTGm5H6E82IHuqic2RES/KqGUeHGLh7DuFxa5WBYKdAz1fMsNdWK1n04MV245yNqyoAxO1m5LaP2Tcuy4JyK2UjxdddduzxfsLzxHnKPWpCZyojf3VzSJnl4+MN6+hjEA/9VJpwUYTGD08D4DB9jbrZPhKWLhrsgnLAtB+W4HRhTF65hvLaUFstCi+eBG3MRyosihQNw4zGOuSk1UF0R0/KMxqyKhTw3jZ+ThVaPYfIyKEJLULoo3jNYU79AhtgcB9EbnFqdeaSuJxVQUCrZaMtYw9rAn6bIwSW2IZP8wEaiYlcL3E8s67+gDBvvTXF1JXgkBmXfgKl8PjNTkZ2LWknBJaS8QZXOpKUVBDQjdLeC2SBDFF4BUxzQKfD48aKSpRZ15ZwqMfsEyOeDNx5UpWCQoUBB72s+sq6qe0oGeKbepQ8vLjoJ/7aQw5RdKmxeQKnB/NjFgLjKhVRa4Qhq872KyNOiDo0PXnX1W82Ctayew2SOInhYQ691iyldxIsXLH1y5MxY6n0I3vjfoRndaenHLCAPFNSX3RJGDblvaY+H9NjBnVPohtqg4cA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199024)(186009)(1800799009)(82310400011)(46966006)(36840700001)(40470700004)(316002)(6916009)(70586007)(54906003)(70206006)(41300700001)(40480700001)(478600001)(356005)(81166007)(40460700003)(2906002)(4744005)(86362001)(36756003)(5660300002)(4326008)(8676002)(8936002)(26005)(36860700001)(1076003)(2616005)(107886003)(47076005)(336012)(426003)(83380400001)(82740400003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:18:09.0376 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb78d7bc-1c43-41a1-c29a-08dbb59a62e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5124
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

Change flush cache to invalidate cache and also fix
cache related issues are seen with small sized data reads.
Due to this, proper data is not read. Also some times
sf probe fails randomly.

Ashok Reddy Soma (1):
  spi: zynqmp_qspi: Change flush cache to invalidate cache

Venkatesh Yadav Abbarapu (1):
  spi: zynqmp_qspi: Workaround for small data cache issue

 drivers/spi/zynqmp_gqspi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.17.1

