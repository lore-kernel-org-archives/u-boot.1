Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E228EEE645A
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 12:12:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A74F486590;
	Fri, 15 Sep 2023 14:12:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ph3kA3mQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4C486672; Fri, 15 Sep 2023 14:12:18 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A772086538
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 14:12:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJh3JIR2MSDlYGYgHVwTTiFhk/zJ+QkHvYJbUMj3UkvOwSKcnZJczWqSAOtDX63QJ5Gp1oZVxTHvVFF16lD1SaNc6ZdAk4Xc02hqYN4x/6Ub00g+jd1om7EH4xbfsBuC6I092I5DM3D0lmWt2Xm1LU2oQPb4jpdlB5UKoqZqKgegs/WEkYtvnzF2ODuaQEJwPszDIyWhYcbCYmUTTZE6BHczxiz39L6YW3gDdQ2b/tisXtY6RvWQijn9sWgyOVJy7iz8wDmFANUu6qVpriX8WocqCIFmyDZ0N6+wBlI5AnCEZV8qzD2OGwFN859b1SHHiF++aXCrUcVkiVSGXuZLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oixPZZv3IzRiY0xQilMfECaYRogih/qTgMyiS6VpIMM=;
 b=XvAZpU5QjFfCq/+X/2g/kxl+ww7EbuNGGSffRLIJtMRFrjH77Dw6oqCoLHHKmoJYFJJaeEDrT5GKUb4V9WxHJgxERksxnD7fBP9Tx88sAuli7tsoFqMXBGdf7cp2pvR2UOdOlz4mbzOo/UBVZ/xrUXMO2U23aJ8A/3vf1drde2mC1R2kfn6MLnusHkud1uO5hEq0hze+vSeKYbkyD12k2VqgubFaLcEX4swStC91bsxQkNH559bJm/liCmCLEUJMpt6Bmd8Yk87ODE6YtWW7fQzIi4HkaTp5+TS3aM1BAnDzqRhURGNT19qDNN8NmJrM83MG3y6E1NvXOP4f5e9XRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oixPZZv3IzRiY0xQilMfECaYRogih/qTgMyiS6VpIMM=;
 b=Ph3kA3mQ7DA3El6ZYJL2mDE15Z+lHPFqWZAWmhItO2mHpGxkjtwc+MWjaeGOXcctdyrI7JzrwoFYiaaQvZ9rr3fcrEru6Ro+yabSOQLRKz4FBsEdQxEdHvxmxZGiRupn2iQaV/JPKhIQvhGVojlCBYdOs9RU4faHCEWUYF9ANSM=
Received: from BYAPR11CA0041.namprd11.prod.outlook.com (2603:10b6:a03:80::18)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 12:12:09 +0000
Received: from MWH0EPF000971E7.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::86) by BYAPR11CA0041.outlook.office365.com
 (2603:10b6:a03:80::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 12:12:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E7.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 12:12:08 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 15 Sep
 2023 07:12:07 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>, Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 0/3] trace: Fix flyrecord alignment issue
Date: Fri, 15 Sep 2023 14:12:02 +0200
Message-ID: <cover.1694779918.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=0waJvRh96mYKKDTxy6IgXnvEKxWy9IObewNCdTA7B4A=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhlQWL37G801rD5XHPr5ha+5Q4LfgSPwj2z/GCvoTLSYs3
 a30Nca1I5aFQZCJQVZMkUXa5sqZvZUzpghfPCwHM4eVCWQIAxenAEykfjHDbNYV66QWZ0x801dq
 MH/arYaYiSlMzgzzXcyWVNyt4udf1fjHYFb83k8VtgczAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E7:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: 91362b7c-e6d4-4eb0-24e3-08dbb5e4fc23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1r7qnuzCl5pC+w/6G9TNj0+bdB3450BDWQqyfYiQ+rOQ5zytyrXHcu9tJsjNpnguw5Xb98b18niO2o89vZa7yYpxa10kMejAzydUobZuVB134XE/VtfFrKeJ9Rn+PG9nTcM8supPTyTOsOqsv5eflVMmlCf+UvRqUlQjab/wrbdJJiaqKfY0m2pZSb2YFK53W2x3vGf1rK7WMeFH21NP3utIuqOIBs10HRZnY7RIO7FSA4cXKEC7JXUgucxPpnQzm7Y7UVrHtNSTPi8emdLVIF3L3n1hG3MfaPTGeBCgUdi2JGYQ/XwVmiwDY+7Qseqo+4fYOGfYgIsQ7jerNPeuZ+vcvsGtlt1aAZvpCqRKyhpEWAcnutfuuhoZA5L0imxzxUxA3ek5U893EXU/AN7KBdFA8h4BVOTHpshTCZOHT8pP5mmxpL/3ha4isTi1+xdeSyAwMNz+aahb1isZnvmVBoiB9SUJ3HqWwTP8D4eZnxp98ylLiEaePXmWwa6vLQxCOFW863v/tfJIV2OQsuahqeYM8qbgmo1AAXgoNMuIVcVoySdlLt+ebymDxwWqMHnLZLMVUqnb0SP0papMTkhstwzNwsm3aEd764wLiHokw19hrJ/pYvKhDNqPIkOtRSAwS0V51cBfuQBHdeqQyq+4HbubPmVB9ueIq66Y4V39MsoRhHuidxTTPcgAOqp0zFFSdka/dsHRGCYGMsbg5qpK6MjJYNq3o/BAzWytPZ0lHM6qxl5GQ5HHvSYWXzUIPu2wP3LLNTx+i5rsZKoPPbRyIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(1800799009)(186009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(81166007)(6666004)(336012)(5660300002)(2616005)(26005)(426003)(110136005)(4744005)(16526019)(70206006)(70586007)(44832011)(316002)(478600001)(41300700001)(8936002)(8676002)(36756003)(86362001)(40460700003)(2906002)(36860700001)(82740400003)(47076005)(83380400001)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:12:08.8983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91362b7c-e6d4-4eb0-24e3-08dbb5e4fc23
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

Changes in v2:
- s/start_addr/start_ofs/g'

Michal Simek (3):
  trace: Use 64bit variable for start and len
  trace: Move trace_clocks description above record offset calculation
  trace: Fix alignment logic in flyrecord header

 tools/proftool.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

-- 
2.36.1

