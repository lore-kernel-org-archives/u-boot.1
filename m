Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CC16EE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 12:32:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FCAD86E19;
	Mon, 11 Sep 2023 14:32:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WUJD/XJb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA26386D14; Mon, 11 Sep 2023 14:32:43 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01CEC86D59
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 14:32:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bTafojLYiKGB6U63/GY3wMthtNhfmEgUeBHcCMhVxdW2O9pKQKAS/Rd6QwXpjz2dgYCxtAuRnYRlB9qJgHSyZv3yDQu5kpjpCDKFZB5sL7eFMgMw/260oQ+7GpH9ueNHU5UW2+9udwxuGr0wtqMj/hBrSTS6LWe64876DndyArqK5DzhpdVkZgRg2eEquXAO5v2/XJR87Z3MQHTZ4o/ZETGO1On1RFwFW18DDgOXwEmHXAZeJJfMz4Cz92nF9Mxz3XJ/uqr7yMdyqq2lxsDtBxGHlFqKwy3M7QtugS/DFk5B5fyeYAFMaJcJnr+p9tRUXz6nsXxitokWBY/Jee02cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+n62Bllt2+JhSub4H9+rL6dZiZ0aQS2a4EnxPTgq6E=;
 b=LCqlHfw5QDWR+THTDIAYS1sBZGh59KnokiXBmEO3Um0enl4otSub/3bABC1lyl9HoAYhzQtA6kGpVwVs/6IJzLCH6jxo6VoyzOPdUK4jljusaYk+8FUuf/4ODmwPdGMZgQRxk1BMGvQxYMrzYgyubiPmbIzAbDe9QLEZGZZOz7ik7Oe6Su7tf37g6/DcOAAbVAXKsBPXLK3j+wKkuG0g/0S0gP3Pe95rSzZjEawqpHF2xmAI29kfGC7r3VdPdT0ke5sq8J/MUAJJuj2MApMPw1DpO0wXpvTyX52Y1X9z0QoH0IzBL9GiwohQi3q8xwujoS5V6NmSa/Uw3XHaPmgKRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+n62Bllt2+JhSub4H9+rL6dZiZ0aQS2a4EnxPTgq6E=;
 b=WUJD/XJb4+vmUyjYxbw6FQ6iVLhfDsHCTl0ALEN4w8yr9pBzzXeBwBO3ziqRrHA4H2NH5OqvE0yjUiqeGDT5JZfd45aOvTr5l5XU7vWl7RByVj65bxgOia0VBZSVNIDQkOjPx/PP4YWl0wuu8BICdlhmNfdlwrwoVsB40N8FfiE=
Received: from BL1P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::27)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Mon, 11 Sep
 2023 12:32:34 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::ad) by BL1P221CA0026.outlook.office365.com
 (2603:10b6:208:2c5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35 via Frontend
 Transport; Mon, 11 Sep 2023 12:32:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.16 via Frontend Transport; Mon, 11 Sep 2023 12:32:32 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 11 Sep
 2023 07:32:30 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] trace: Fix flyrecord alignment issue
Date: Mon, 11 Sep 2023 14:32:26 +0200
Message-ID: <cover.1694435541.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OIFB5xJwiFsC48VZuVC7kJNVUAuUx1ozpeIo6vyIxp0=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhpT/HNfy96Z+be5pm9rB4Mh1rvO0i/HPzd0Ts+wffj377
 JLF9UtLO2JZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEJGUYZrOsZ5172sNdX8E/
 uvbeh/lMn18s5mRY0HuG99zJNZs0Hm76Giczi+vSK98OBwA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e65e0f-8c66-4f25-2ad3-08dbb2c32bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LdjcSuHpsqwV+9pKrzyZTDwwsgR+/yuQd8tEAGMTJw/X+rT3/mMuqOy40e15SjB/z0YFuiqbkjV60ABuUJPK2QeWhNBUdiVRapwWGspUJNdDS/0xt+BEdOdb4LGubpILVpBTUfv+JuvlyI0lkddEumO9eMhszObbc2MnObKC5swuyAiUQ9c7aglpLrktsQucV8Cxr0cUqrz0F1bGJpthLzst03hfvyqJ0zMRm1Zb3wWXR+KqDjftjVWEMPf3sp7oIRbUQwZZYjMMAM0RIhlAMyRJ9kUywDw8ua0xPl02stx0DwZuBNrcJAZkxtGbXXaqtbolnrok5MemUFDjtWokgFVzf+0nrx0kXwZxsf0IGfWBavMUV/Dw626QDhzE93kyW1/kAGMPvkrQxokDzCi7iprym8pPbs6vWCiwrI0kxclIGfxiASSS3ASrXXaj8BU7CoDDOKNti8zkPBoVWTJIvVX8e2SB1dwTtwg+kSkY0Ga3NPaTzs5HF6/GSIDNUqJcC2Xp/MgoJCuoGZnBUQKR21j6BCQ07FCysEhnVM/0NJcihPXZACjkJ2OFD0+bqOLBkn88DJx+TzkWXkn4jPIG5pwbU+G2g1DO+OPrcLjsuoeUchcYckLyI1W9cG9HywHpWWAA0is1gaGNbnxnwWa21kQWLT1xErl/taRHwcifcXWwjv7Xzk4Kv7eO9sY58HRHU9DvlR5eKkBEiu987b+yVQCV4/0wbwg+y/TAQ7afYEFIVIgpoWLPOLXnFA6gn+IEhKy5Kw5D/ksNdWf8z0VA4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(83380400001)(356005)(82740400003)(81166007)(86362001)(36860700001)(47076005)(36756003)(2616005)(336012)(426003)(40480700001)(26005)(16526019)(316002)(41300700001)(70206006)(8676002)(70586007)(4744005)(44832011)(110136005)(2906002)(5660300002)(478600001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 12:32:32.9123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e65e0f-8c66-4f25-2ad3-08dbb2c32bfd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
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

Hi,

sandbox is getting bigger and bigger and I have reached the case that
adding some more functions ends up in CI loop failure. After some
investigation I found that flyrecord header have incorrect information
about data offset which is caused by incorrect alignment calculation.
That's why this series is fixing alignment calculation.
I have done it via 3 patches where the first two are just preparing code
for actual fixup.

Thanks,
Michal


Michal Simek (3):
  trace: Use 64bit variable for start and len
  trace: Move trace_clocks description above record offset calculation
  trace: Fix alignment logic in flyrecord header

 tools/proftool.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

-- 
2.36.1

