Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 146F0C53219
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 08:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BC71F6079B;
	Wed, 29 Jul 2026 08:12:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2mg9oVyxR1kR; Wed, 29 Jul 2026 08:12:40 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D6DB5607E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785312760;
	bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AywhgFP4R7M7PnCJXUMhDP+Ka8itRDn045ACXaCBq0OArtUwUFvka5QXoG+RfzDZ8
	 kgYTRp7I0dGX885wMg0t8k0hWYilRSGyR0HgKOv8dLd6h0FH4vKPKUirvugYFQ0YV7
	 cakQyO0gqZ5ujNbjnP6meq9AaDIZzlCWULz7LbXlZWIAkpP1bkuC1jWv5WvlhsJX3I
	 vwHGg0fqQ2wetQJbPrIXeLRVaXwVl5fTSynfchHwLoZEktVhOVffDmnt3xTQZtg0A0
	 6drlB0ytJE3LGf5JnGRNEASltDFpNaXn0cY+TwEXmLpfr8z1JKKPqMcIqs8at6M9G3
	 6R4zp9vIeVyFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D6DB5607E5;
	Wed, 29 Jul 2026 08:12:39 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E8E64788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CF7844009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LqP9tUfeAfSU for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 08:12:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 816D64004B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 816D64004B
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 816D64004B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 08:12:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMhEt52gfnVEslh6ZWF7BI0tHzf7xc/Ieg+6WvFrDd2WcDj+Ctr2TybnVnhASMIKWmy2Rob0smAoTq2o9jJ/kE1gfgffSI9t8eguePmvL17CmN86OUgVZNlmha1j2LozXd/dIV41/CSlv78S35si4YxcWR5/6X4M9235u0VF/vaPscYQtc7KyEdlnOYLMhDZPfmiHqN0n3mOuIS8ipQWTc+M9OZH8rTTGgoFSrU8d1lNcj0rvn8XqS9O0NzSm7VcFcVWWwQwkbhpRr2hoEchNduso3nV/BV/R9XNtQEBTFqPmZp+AEd2PZohIREfc3n2fDAV1+B5Y8QYv1CuJKiLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
 b=qvqFpWjuY6aym0T5tMxIdgAhLiyYWnVwNecHlT8y6MHPhsqqirx6NBQlMstpQWhd3wlREGtYefAYsuaAsqu52dClWhr2RA89n9/HQVtc4MzlEO1Gp/qkHPZuLOq97glk6G81ROclKAzV9DsPJB2G68auaCey47qBDGDMl3cYUSQuHcbYle4hruEVlrWtLCpOF+J3KVYfTFAHzrVuLPSIbqp+014/MsAb9tp1Y+9jFZjF+5ub4Y5/97HsBG9au3O1nZIZFKMs8V/2tdnjGM+7cj+3KboLTL0sufQguevmP5sZd6Lj+US4+ymzenKk68JfOVHlf63XlNP49dxbkYLDIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by PH8PR12MB6867.namprd12.prod.outlook.com (2603:10b6:510:1ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 08:12:28 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::9f) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 08:12:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 08:12:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 03:12:26 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 03:12:25 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH v2 0/5] gpio: improve claim diagnostics and fix gpio-delay
 offset handling
Date: Wed, 29 Jul 2026 13:42:13 +0530
Message-ID: <20260729081218.550465-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|PH8PR12MB6867:EE_
X-MS-Office365-Filtering-Correlation-Id: 67792c06-6e1c-4cae-1529-08deed4920fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: pldsZdhbFZ39oU0gXY2e8u3sO/MZxGFW1r/QgEYVgITpMl2MJUx5SpUoTAx5uP9G1+c09m7vy0k+bz3tFix7rYHcA7KgnFt0FOAvj497ZgP20gbE3n9rrSyPvpsBID45r/SGuMhg20PEBBkaNEMdYrfUZcBglg92INL6nGRPZ1QDkN7gu2XZOiekn5eQgGw/t0QOPr6cDis5EfX1pFVLfJQwg1vcQ76OgGaqlcWn0+F0bXXjfIVZofJgUilzxL2J8zq3StGVSrNzZOhysYRLcwaEffc8j9VhMx9CkDKmljlJY9k6rysgjKKaQAyzS6mt3cqJkFf+IgFWTcibbA0Jak8rK5yKK8C+e4fafmWCNADfkJdmN8d4bkJeDDPL3qeMUl9geBrpVttd5iPMjGLstyQuNaabwpD2Vj3LOYPCLp4OF1SE3kmKNRr6cECaa0N1AigelXvVlTvGztiWZSnAUpB2kl73y51DSRRvOaFr77fMXcN3ts7BICZGF17argmLzS82Nyj0LlaDLBduGhu6dekOtySfYz7nhouBOO40sA+BdKQd9N3sjf2V8S0U5EQP9/mROlYt8UiWghy9hq/TD19qM5A9sxZVgtgskjwe2fAzX9F22kIdMwPOZn/5tuzQaUfY3HbLjp5PECaZDeU2o0eHHx8ssSC2UpzkysOc+MvF6TI3DyhLCoZfwg3dQ6Y2UrMFt5t8QtwphXILXdI0kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iy+Pm6WrHFeYfTOX0DaH9xAYq0VXPCVN8YC0Hb2cEhatEFY35JNUJ3k4EiCIQYu5S8y5GhGERSdOjrGJPMaGTJ2G1Y43Ho1izn7vRYf8+IPlwMr+GuNWbG6k/Z2gAlJ+OwYAznVN+mSEzkSDwz8YfskvdHA9bvu+pRazrGIm5lYSGcj3B6Fw+RXzCDnAxCZuO1x8EzgfX0P1jERZqSs8LLXFL0ztj2lcson6pvtfLVNHEFlNxCCV8mhdbtn6wDwWhha+I7NJz5xpRv/WCXwbtmIWfaV2JVV8XlxhCaRmmstITZ0/SQV8g4Efrso9Lr9/SlowDW/9fOtov2Mhb06Iq3tnUDLWjj39jQMzRlaaAEFVbiL/SupIPwIMu8fAh5xp6junAuLoKbUqUjTkl0rwu1d9FEu7RY2mstsk7hWU1vaJerg7+3vr7NWPWqNogyG2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 08:12:27.4490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67792c06-6e1c-4cae-1529-08deed4920fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6867
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/szHTwuIvFrHDQPgatqSXSQvTopPs28IqQZOiZmRa4U=;
 b=LFgGMgjeksP0FaASNB87Zh6JCskU0VhTLJel43P6ugPnhTgHIenDWMr+CSuFPOVgU8f0Voi+Q7LFMP0aT9sGl5mvO8qJ/BiCMuNbfFyB18Iuv9nE9JmBow7QBnu8o1tTksB21bk5dskzbUB4D02vS5JLt0rCj4/UcWjSTwBO/Wo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=LFgGMgje
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This series improves diagnosability of GPIO offset collisions and fixes
three related bugs in the gpio-delay driver that were uncovered while
debugging such a collision.

Patch 1 logs, at dev_dbg() level, which label already holds a GPIO
offset when a new request collides with it, from within
dm_gpio_request() itself, so a collision can be root-caused from the
uclass layer when actively debugging.

Patch 2 adds the same diagnostic to the "gpio" command, at printf()
level. -EBUSY from gpio_request() is a normal, expected result there (a
pin already owned by a driver or hog), so the command already tolerates
it silently; this patch only prints which label holds the pin on that
already-tolerated path.

Patch 3 fixes gpio_delay_probe()/gpio_delay_xlate() to size and
validate against the driver's actual GPIO count (from its "gpios"
property) instead of a hardcoded 32, correctly sizing the claimed/name
tracking arrays and matching the pattern used by the generic uclass
xlate implementation.

Patch 4 fixes gpio_delay_xlate() to propagate the requested index into
desc->offset. Previously every consumer's descriptor came back with
offset 0 regardless of which index was requested, so on boards where
gpio-delay wraps more than one real GPIO line, every consumer past the
first silently collided with the first consumer's already-claimed
offset 0 and was never toggled. This was the root cause behind the
series; the other patches are diagnostic and robustness fixes found
along the way.

Patch 5 adds a .remove hook to gpio-delay to release the real GPIOs it
wraps. The driver requests them via gpio_request_by_name_nodev(), which
strdup()s a label into the wrapped device's own uc_priv->name[]; with
no .remove, those requests and labels were never released on teardown.

Patches 3-5 are tagged Fixes: c866f2f197e2 ("gpio: Add GPIO delay
driver").

Changes in v2:
- Patch 1: downgraded from dev_warn() to dev_dbg(), since -EBUSY is a
  normal/expected result for some callers (e.g. cmd/gpio.c, and sandbox
  tests that deliberately exercise this path), and warning there fired
  on legitimate operations, not just misconfiguration (Simon)
- New patch 2: moved the user-facing diagnostic into the "gpio" command
  instead, where -EBUSY is already known to be expected (Simon)
- New patch 5: additional related fix found while further exercising
  the driver

Pranav Sanwal (5):
  gpio: uclass: log when a gpio offset is already claimed
  gpio: cmd: warn when a gpio offset is already claimed
  gpio: delay: set gpio_count and validate index against it
  gpio: delay: fix offset propagation in gpio_delay_xlate()
  gpio: delay: free wrapped real GPIOs on remove

 cmd/gpio.c                 | 11 +++++++++--
 drivers/gpio/gpio-delay.c  | 23 ++++++++++++++++++++++-
 drivers/gpio/gpio-uclass.c |  5 ++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.43.7

