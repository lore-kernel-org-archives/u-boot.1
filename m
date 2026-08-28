Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF63BC61DBD
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 04:28:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7A36960725;
	Fri, 28 Aug 2026 04:28:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DhaZqkmmNGOw; Fri, 28 Aug 2026 04:28:45 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787891325;
	bh=YJxPR8d+zhz6/6ZS3dukQHM9Lmpi7Qt7kN/WAcnOHAc=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sx+dJXWBhmpSkIx2V/24QtRlKQIrLV+Wk1XAnYoYIg7hzfYPKPA70QBVg7AmttS82
	 dSlCMBD+8Dk/Vh3zV4Cy1t/eiqzleR4Ih4qXhMtEDX1pvkL840ndXidRFiEACXG0wR
	 swUBBTSl1DyjBi7vwiQiXIlAlW3NE0IFOWM813krOjOvimQYK8DRp/tjUyH/XZJthk
	 OEb9pIQP9AqqFdwEiA7JVawBW/72TJJyU7VVz2NRx1NUTgUeeqcK9iAcUlDvjNM2L5
	 iLR6tFA8LrVxGVc1vrlsamzP6g5wrNo+8WqiBQKA+0oBYJufPQ+CXCuG146t5Fs6ea
	 iSE2YFa/13TDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7727D606B9;
	Fri, 28 Aug 2026 04:28:45 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 729E523E
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 58D1140111
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4MfcZ-zpRE0M for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 04:28:43 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qb6bYreM
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5740140063
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 04:28:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpHIpQvUVtWrHrTxNdPYETyQRO6ZE0mnuIerKTsAHcN4iPYs9PcGSYs4FrMG7k3N5DnqJWwhUlTJ78uTC8jMSkpWoSpEVc+kDNF3vlVjT0qUJSDXp5+RoKc2aHHOucYapUuKNaPcqp7HLmT9iihB2FBuGKu8cAuAJQtXtesxnPegVoLO5FPWeWYPfNdt2PNuHTVQFw1OrDsEUbT7q40KTWNoimg9TeS4wYGtwebyFaaEGm8EpqaXXqWxldkLe+VyNSdA9bZatzXfXWEEybGp434FPrXEy/nW1UK5ysIM2HPtFTe2LRVPr7elCCLJs45IQWcgnC7CMbLdhwTBEVDVyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YJxPR8d+zhz6/6ZS3dukQHM9Lmpi7Qt7kN/WAcnOHAc=;
 b=lJ+tFkXjmQL/o41QMC5OxtWd2OivF0xT2SGbdA62SEKRo4B9OJP8911C2mUNNiDTT4zdlu2BBw8h+EiWH9nACQw2R+7yDGOuEaphbIgU3VClm9B9WHc3UIkUosGg1hFu60aT7p5YkfwZDCJX94KOH1txpTi1iNcHBz7ljWD+9jTisl3I/oWGyYCJkFiPtRurna/DmkFFNEGMXy5M+9EcdXvyUhm859piAvBdYHsue+CEAKLYPEPgZwyPLiqBhtpzmgaT1jVOhX5wdCR8uYnOgPmXNqmiD/En3b9A11hWOxnldpGa9eJXsaxlbdplsOJHFaUkFs1fJ1Lm7fR9vPcn9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJxPR8d+zhz6/6ZS3dukQHM9Lmpi7Qt7kN/WAcnOHAc=;
 b=Qb6bYreMySXdG2h7HuulKfW175LZ+JGWL+BOcvw1EVvRbNMcjTghAkY+IAuLhVTsP9L4jzi5nC9YQRIhq7cud7xqo8IQhig57vTfCKx0Ybp7eJGLKsHyxU7yL/zRyyfLoSA5dUbGQo+zfgOzPCJwNPEOo378+qa41EZRfc6rf8s=
Received: from CYZPR02CA0023.namprd02.prod.outlook.com (2603:10b6:930:a1::21)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 04:28:39 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2603:10b6:930:a1:cafe::63) by CYZPR02CA0023.outlook.office365.com
 (2603:10b6:930:a1::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Fri,
 28 Aug 2026 04:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Fri, 28 Aug 2026 04:28:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 27 Aug
 2026 23:28:36 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 27 Aug 2026 23:28:35 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH v2 0/2] efi_loader: show drive details in the boot menu
Date: Fri, 28 Aug 2026 09:57:56 +0530
Message-ID: <20260828042828.3421664-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 13ee859f-6595-437b-fb0d-08df04bcd4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: UGIbijqaoP2K5GOuGzCRad4kxK0KoDWQuA8FUR9e23bti3MbSswh0g5zryx51X3TcQbCqZqnn5WVt212GxtYFVRw5P/tDuCRwCAcOe1ZMsIE0VMUW2XpjEN5uZbGOvzlgGIsLdFISyVspvwxqtiqee7wJrAaFpXkO+iCsf+x4IhRf5elqvCkCSREy9VmThg7eQcBFCaFK+EtcK2Gyz7dsWWeWORnVZ6bx+Q1wHZB8ZjkANAPIZEaxpa0aaqahu0sYwvArzHYdwUHULwJF02ohDyNYOapd5SFVhYDK4kFagWJLFVNmDgx2otT74vMJL+AGEslWwaZiUPqkOm7YLbQVyVm9kLw/C7PXxV7iVBSw1EYK793KDZjB/3pU53qRuWeIE0818KvDVwfrgl5XfdGa+Q1lP1xCPhG0UY8bOHRox16ycRYYaYMClJpzj08XlIO8vLHcWtmuL+2GNtajYvg3RX1bQ3wqIkOslIa6x3FWAj0CEsOdaL3vUrBBh1v5tDY41HkJp/lB2M+HM6bqVg4o+4dX31ri3EqJ77FPecBU+4mtd2j8aydDrXgS/G4OPtm8U1GzpknUbSFGqcweQnjT3bWYfbVNGx4omHnQ/mGykl6i3acGhMWOjXrDhdcBMo6E2UnU9+pMSQorvCBlbU4/2G5j8Nj2JQqNXRpF6Obl85rkJlbcezjZ67Vf9DX7yNa1J+GlQKmrSwLrOeNdLY26A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lBmd2VsfhwSD2cPUVhE1TNpbwTdsczbvz4uoJsWt5izhXOGU+M8cSpg8J71oQEioLzq/+uxvhgByTE8rRZAydDxi8XI2QJh7KGjLihDDP/jidAQLPnk0e+meuHhAEn1bofA2MJgeRYlHobpZNRnLO9SaYkBEBOBz4bro5F4kDA5tMBJ9xJ/lNXWMPpTa1RiPJo1JGVJcf+SPNyI22QpImWGfBq2SboWoKlNz9HINIOi2teY/MQQ5Mg6G4KKh4SwclX8+I2Rf6NRzA0PcTz23CfNn9z2nL3ILZaFScTptkgdRht63IXZFI/a4ZQwBCcjz/slEvaPMC8VqOz8hD0tHZaNVLdaRo9uL3f+2zk8mloIUAlil/IFTYh9U8HCfASlaNTMu8VOMsMZ7a2nUPWeoDKdjED1J16uKVmjj739SIZAWdxU6RqewlhRdVVXAkBwI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 04:28:37.7169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13ee859f-6595-437b-fb0d-08df04bcd4a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The EFI boot menu only shows entries like "usb 0" or "scsi 0", which is
of little help when several drives of the same type are attached. Append
the capacity and the vendor/product strings of the drive so that the
entries read:

    usb 0 (29.7 GiB, Generic Ultra HS-COMBO)
    usb 1 (28.6 GiB, USB SanDisk 3.2Gen1)
    scsi 0 (1 GiB, MICRON MT064GBCAV1U31AA)

Changes in v2:
- Address Heinrich Schuchardt review comments
- Reuse the print_size() formatting
- Add a new snprint_size() helper
- Build the suffix with a single snprintf() instead of a chain of
  strlcat() calls.
- Limit the name to 64 instead of 128 characters.
- Document the limitation in the commit message.

Padmarao Begari (2):
  lib: display_options: add snprint_size()
  efi_loader: expand disk device names with drive details

 include/display_options.h | 18 +++++++++++
 include/efi_loader.h      | 12 +++++--
 lib/display_options.c     | 22 ++++++++-----
 lib/efi_loader/efi_disk.c | 66 ++++++++++++++++++++++++++++++++++++++-
 4 files changed, 107 insertions(+), 11 deletions(-)

-- 
2.34.1

