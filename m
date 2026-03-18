Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 307AD103E177
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 13:25:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1E3E8422F;
	Wed, 18 Mar 2026 14:25:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zatOMWub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96FE84242; Wed, 18 Mar 2026 14:25:43 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B08084222
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 14:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P3m/NMFdABNvOnrTNaFO1eMlQjnKkef1Smhqr/3QuX615Tr+Bv+CEH/KGL5/g6NK6XgVSnkJm2wsAK+uD8Jsph8J9Or/ftvYXp8T6v/wVHl0k3yqf/4qBHHtuR861lFdH2vZg99v67pM1sEzNvKUE+P1xxSNeZ4lv4ro/Ds0f9ur9YZ3iwHl4ZUv+96NXDfGJ91z9wU9blEC17TwXO1FZoRdvAw1AwjVFsAO3fXBKQ6KEj3H67pP013xGbwXtXauaEWz2Kdibn7FBqYhxgYvXzxNZxxuUIAIsHhHF0nwSrPLfM1b1BmtJcN6+FEKMGLL8WOI7OSZ/8Yijphf3U+Y2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lbkh7HT7FscR2e7m5gnSJQnbNfLsBH5CiwaclRf6XsI=;
 b=QZSaZ6Deurdjf/5Fiy583qHB5dXPda8aZYrnpMllf5MH4ihnwy/NLOl67TUOANTroYOOEYt5kc5n14Q4W2rZJIXzg3xXR0xEHL5xdb2UucCfwBmtzbIAD4TPZcAMGxtoVqqJ8yL9oyZwSqG21vyy71W7KKKLD87ZPLgThA0UdvqqILFAOhPf5QbvSrS5BBeclWvxy3PereeHkdWoOvlVA7fTcaACgq85WvsIUY89Cw7MEWppFJHrlb7yC6aLfaC8+CimVVTTYbsUd5g8ucsljXAh6m7gO0OPhCAsA7a/Kb7AXD+HB+oCN2f2wDBkzH8VmRdKdVo0WO0wDK3msHjEmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lbkh7HT7FscR2e7m5gnSJQnbNfLsBH5CiwaclRf6XsI=;
 b=zatOMWubqqwoaFHVcpwKb8SgnW2T0/7db0jT7pa4wvU0NasV1uEVyKH9ICsl4q2mlwhrUfrjniDQ06DRh6CEgDuuX1Ko74vOqOB6JELBjp3tlYKFyrwXgeClADukCcOQDN0TSWLg9JwvRlRpghPAC5zf1thhVg8oo5qb+Scg3wQ=
Received: from CH0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:610:77::18)
 by LV8PR12MB9082.namprd12.prod.outlook.com (2603:10b6:408:180::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 13:25:35 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:77:cafe::af) by CH0PR04CA0043.outlook.office365.com
 (2603:10b6:610:77::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 13:25:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 13:25:35 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 08:25:32 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 06:25:31 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 08:25:31 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>, <sjg@chromium.org>
CC: Casey Connolly <casey.connolly@linaro.org>, Kory Maincent
 <kory.maincent@bootlin.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Sughosh Ganu
 <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>, Weijie Gao
 <weijie.gao@mediatek.com>, Yao Zi <me@ziyao.cc>
Subject: [PATCH v2 0/3] fwu: Call EFI stack initialization after preboot
Date: Wed, 18 Mar 2026 14:25:08 +0100
Message-ID: <cover.1773840306.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=983; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=dayZ89rEgcC9tY3G3xpu/NbscemLwSeqBs/yViitOs8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTuWr7DJamEga9isdfCvtYbUtmasc9szdaWtfRUf1vxS
 LA973RYRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAExEr4LhD9eyNbx2PBnxH7bu
 mVTfeu7mKYtSmT3ZjOvuS9cl7PZd387wP2pixpFz12P+CThdYDnlnetw7teqJ5ffiTEek+1udO1
 P5wcA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|LV8PR12MB9082:EE_
X-MS-Office365-Filtering-Correlation-Id: c59a6a2a-5749-42cb-7ec7-08de84f1d6c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700016|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: aKIzwQOqKUo0EjVhej+xv+NBI/rjRr2OJfD0SXS0SaLF6sj/ANuquxAqOnKJayhXoHaiV4x27/4kV12/fL13S4IMVdyI+SmJ8lMqcKOWnlBbS8g+lakJ4JxVqM2yFeN+rQCCyrHQM7ecenXcJR+uc883WQcfqOEBXh9MPI6NmqyRZnIKNi4YHgQZJU/aFv5CrIFhJ4ash4Z6MmS9GHL2ZG03Q0VM1FRtKWl1nEmDnBkbimVnVM7vjV/U1zJanBTylarv6mahkTrmTHig/aPFWcqLLv8xdu58eMMHx6UwdUTp5ZAQFd0FNN9U8mlByCuq61d3huth2ehvG5lUWcLb4tzgUXsdcpEa6elvf+2X1YWjXHcUJBxEXpXwzJ2igDqocmMJRg0ubbehyZXNYoTii5mrqx7rkpBrMqa0r/MzZWTJQswqye6+rPbkcdh3662blLtmPCqt3fvTFu/0DdFtKF4HtJZcaDBu08x7H2eFYcx/8XZRLs1rsGMZqEDvHc5OL29GhjgZUTTaTqTQ4WOS+QZXh+YiEXxnGZUndNwCfBm7JQuJ8uxpN7ubqGZy2f3JIWA8eLyBT4q2SzepqmA+AW3IPqvqBS48kt3Jgci8GIbEnYq7N3pJeJNOv59tMpG3GrcGF2hU62pi7KI6OOIRUYo1FCakBLUMggDYZUeVHpcGCV68+bqne1mgUfp5ZyMT96HERYllN880zoaOZurG1bYTIPhtiAJrVv0p30og6WbycYa99yLnIIN0i9wgpF1b0pR8yIVrhwnsEBybds2hXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700016)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NuCbSmHAnGkMglpqwt0pJjmv4M+zCiiPy6iLntGcDHiudEn4JG5B/L+0uz+kCnZoYG7gt7Hlbnev10nTW8Tj7zHBgwxk4/+c0cWeKUR0VGGge2E/pDajEl62b7xmNFnHX6ib757PqMBNcDAtxfkU8MyphzqaNfxiP0zsWC3GuNj/g4g0BTxzR+dAMnwu6BFBNqhfFjRdoEIflrVplfk2WzIlvYK7W4QV+Kz0Mt98qnVVGGiluL+Ry+veOf1xONc0zi4N1Ob/TG55JCt4b7wysrOjPsKWr9f1fRQweUXeVvl+PEe9XNguY5t3At+BrHt/QY6fm5tcWss/Xx7RckAvWw7TCPOtMIIy5nWIB6FJ3DXHymj3K+IMK/OYSlMUXuLw+JWot81sLN4Z+6H0kB7phS4rjeNdm/l6dBar8tIpCNkm/Pqt0vhECNzoDDbe5lcB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 13:25:35.7869 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c59a6a2a-5749-42cb-7ec7-08de84f1d6c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9082
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

the whole series is trying to address issues we have on platforms where usb
and ufs init are not done before efi initialization. This is happenin on
platforms where A/B update is enabled. FWU code is called early and do EFI
initialization before usb and ufs started that's why they are not visible.

We are workarounding it by starting usb/ufs from board file but this should
be more generic approach.

Thanks,
Michal

Changes in v2:
- new patch in series
- check return value

Michal Simek (3):
  event: Check return value from event_notify_null()
  event: Introduce EVT_POST_PREBOOT event
  fwu: Move boottime checks to EVT_POST_PREBOOT

 common/board_r.c      | 6 +++++-
 common/main.c         | 4 ++++
 include/event.h       | 9 +++++++++
 lib/fwu_updates/fwu.c | 2 +-
 test/dm/fwu_mdata.c   | 4 ++--
 5 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.43.0

base-commit: 61ddd555f58ef5169c48b190423640d949e4aad1
branch: debian-sent3
