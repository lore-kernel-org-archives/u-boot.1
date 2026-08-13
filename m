Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3FFC5B572
	for <u-boot@archiver.kernel.org>; Thu, 13 Aug 2026 07:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2441560A74;
	Thu, 13 Aug 2026 07:11:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HNsfEtI3SH9r; Thu, 13 Aug 2026 07:11:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 54257608BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786605112;
	bh=81gzsgrp3OGzAOWgPTfjTyxWy9Zo9cFnT3PrTCtE6Lo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vsgCnqZjMm7vDJbEsCKptiLFBizrDBNOGVhXL0r4ejuOLE8ee7p2wnt69mIUepBf7
	 y59Dx23c1CbP3dN77MVvXwddzGHVQMu9NoORdb4XY1XnOhAjzLJYJHEaQ4vNs/XQWG
	 yCfoOCKJVR2AMnYYHh8KKozM1u4lX/PBa//j+ogFN8/pfeObI/w66Vya0S2V1oYHSB
	 zhUlXSyvkgt0tS8zG+CGGb8Uw4ohvR8KuwWcx2XncqjRFyjtC5SybbLngB+SPSeQME
	 61EqQ3ZVex6kLsiMGD+ijQ9QgKzDkf3dAkTGZF9GKq7+5yEdoyO96fRDM8ZwtIl9eT
	 wa4bmyE1UxKVA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54257608BD;
	Thu, 13 Aug 2026 07:11:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id BD2BD282
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A57E1608BD
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s4N4AMDl3Dmc for <u-boot@lists.u-boot-project.org>;
 Thu, 13 Aug 2026 07:11:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c111::9;
 helo=dm5pr21cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B35BE608A1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B35BE608A1
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B35BE608A1
 for <u-boot@lists.u-boot-project.org>; Thu, 13 Aug 2026 07:11:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTVGgPsdyJgnwBUpFFtGc4vrODVbq1rjxTa2tgPiZuVtrHl8/FDlI5wNXzrBBth+ILSER8ozYGjrm5Let8IE2IiLJJgmQXkl8Rc3HuVWTGlgbPrVhSr5/cLWYi6Mxg+PLhIdsKpIj2ChAhE+qSjoyfpFPeit4EVqOMC7V6V9KucNBr71H5KC3AhXr1qNyopBmLMpyE7+3TqX0Zd3NP9prB3QbCUl4zgDqrhvekTV4ZhDab8YP5ebctkn0KgN2utLiGeA0p1OJLhbQhuqDakMrabiGtQ1Yd6f3fRQ1uAbCIAJDBkJIjhKiT3Lslx6G60fQ2t7Awscg6UOmT3OaX6Ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=81gzsgrp3OGzAOWgPTfjTyxWy9Zo9cFnT3PrTCtE6Lo=;
 b=t8DLxszOqM9/WpPWPdx+eDvv5rn2O0OGJpwKjuHhQ+LQcDvJMdCCKHvMlqXDs6NNrbqIO47fYmeo+vAx8t+pA+IP4wu5Vi2GHS0A4OEZZvBxL4ftmMtEwmF3vdDsXcDlAmboOV4Ce+jeu4+JuSWLMCFv0nh8WDFtAAbw31MUCu4CSaFpWgmJayZWVttVFNqKTYcxHp7lYHlcU8YkiR0dYC8y1hlfIP5xfZuM9J0DCpH16I5xI5JvSlLwDamW4QsumWGCPG2W2CwiHOt+TkX+t+LQWJc+nzLYn89TuSC4e63+h8ypUE8gdyF0kDA/3T0h/ltZoKRu2X71VKHVsaF80w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 07:11:43 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::4f) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.4 via Frontend Transport; Thu, 13
 Aug 2026 07:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 13 Aug 2026 07:11:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 13 Aug
 2026 02:11:42 -0500
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 13 Aug 2026 02:11:41 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Quentin Schulz
 <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/2] MAINTAINERS: Cleanup non existing files
Date: Thu, 13 Aug 2026 09:11:15 +0200
Message-ID: <cover.1786605072.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=770; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cXAyuZaZ2XcPYKUloNHcAGHLRmlzdypLjI28QmuwMO8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTV5inHqPzpF35SfJVx+kKj6AK/1+uYv+zKryycW8p86
 cffayXOHaUsDGIcDLJiiizTmXQc1ny7tlRseWQ+zBxWJpAhDFycAjARhxSGf/b+P1pWB22bd27j
 Eglvl03ckYc7hEtWbQx/bSbVNktNbzXD/+hpMb9ClyvNs3X8eDlR76akM/eRlxObv898KvfjW6y
 WJA8A
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: d6862bb6-1069-4357-5ffa-08def90a2126
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: dwd+LExvmxkghrFVh6rkQv/UUqMKiI1fPFoCgY7PtAqphmRtPxEOTOT8bGHOgTToNdmjqXbxBno99+pO8MWynwJehKSm/8OhHBRf+LR6oSR38IogLyfjnJBp7HiHtnXWPYnEpR6M3KRDQhEjpp0/L8OoMSDOyQnjKJM2FgFmAZZqwCibx5abH7inzvvhMx0NsRgB7bMolqetffS+bvEv+AGzeYr3mqShVT7FaDjxts1MN0vhsY6e+dovaFDvmUJxFSylAUDo8qarB7a1pD8wSal4tdimI+HPZRekUkKdpQSMc2lqFRKpE2j/OtUtvazGHXeV86zY6WOO2gcvKoOyLD7oiMIg5mlCh1eQehT/uYiKrGWZmrSIzUr3gkTE02/Z4IIcoGj4tJvOLVj9eFG5kpU39vkWGB2x4YnnoWZUwsGes82jYqPI90MhOdXQahn8gN1PyPytwfxM+GMRyfMAAk0ZvtNfMfk69S8yE+ZvDIW/vQtaTv2b8XFlt++H/4t9MoSfkOdxn/O30d9floepu3No6mbqbNmHtxpuo91Fl6f71wy1+G2kCCJQALVUgYXM4RjQb1SmKe/7ij7CWlHSslkMXajqltgG+Sv7oG9U6tmDoLS2Jt+zZbaFwBZycr0XxGrvosjTnCvyxQzy6nH5lbXB3FhVNfKXr8XaYYu7MDYcSi/+M3bEro8+ZAOp/zX8CBpef6ccG/1tXs46puRsfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ze4vl//Y1EYlzYs/e3wWKo7+UYt4h4VpRFKQULS1x+37soZshR6EZ4BNSnbw6/neDG2wOAXsMGoiZqw/nYgZA+Rq774/p3s/PhKO4MOA+lWoqrP/ts1PzqQYV/Ey66LLwSscrKJhuIO7QnFoibtX1jzZIJhDSjTRnd9WK+qRSyOv+G1cjTAiz70T9tFdrUyJ2D/+j4d6Wll51YIxQ89mhty3vZt679+warqDr51MOaX74EvBBCm/2kwdUFDrySTpb3Q+FYRZS7XCYfcEWez+fcM6q+k3pB9BKgkyP3hUfM3IF+LFj1iS+H8iXWQGyrnFnR1wn73IaeaNusZwVpEcTkjoMEwrgfW8MwsgCA2UvWfcsDWgMXMcM0KqshrVMAHMKa8UrTMcSkANdS05PYIqbOARx54cp8CTN+KTS3bU705m4Tio48+36DyxiKoJ3O2c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 07:11:43.3606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6862bb6-1069-4357-5ffa-08def90a2126
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81gzsgrp3OGzAOWgPTfjTyxWy9Zo9cFnT3PrTCtE6Lo=;
 b=zeTjMReblaKhNOHg1+sLfmHgOgzoPLvpVF9X/Qf4fH4uktAamuuHUQIXznNAaT6nY2vNi+zSBL87uN/W4G8CV/fDkjDp1FVhlkdfY8sGMxLPkjhjB8fM3VajFoFR3nRcaNDvVZ6uIr+EOro7rIo1d537w4yVPXZZScWhzmLorYk=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=zeTjMReb
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

Hi,

I found in my Microblaze fragment that cmd_mfsl.c doesn't exist but still
it is recorded. That's why I wanted to check all entries and found that
there are also other files which doesn't exist.

Tom: maybe good to run it in a CI to make sure that we don't get out of
sync.

Thanks,
Michal


Michal Simek (2):
  scripts: Add MAINTAINERS F: file existence checker
  MAINTAINERS: Remove references to not existing files

 MAINTAINERS                        | 45 ----------------------------
 scripts/check_maintainers_files.sh | 47 ++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 45 deletions(-)
 create mode 100755 scripts/check_maintainers_files.sh

---
base-commit: 0b581a9612e46310ee52bf8359165950d38b2a2b

-- 
2.43.0

