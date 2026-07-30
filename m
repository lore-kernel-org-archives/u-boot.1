Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F09C54FD2
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 06:49:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8B649406FC;
	Thu, 30 Jul 2026 06:49:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ftI-w2u_oSq; Thu, 30 Jul 2026 06:49:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7685B407D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785394179;
	bh=JpZ/bMh7fWhwyCwRkYiNbA7FctM8xT2fwDuZSdJA2Ps=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=zY67E5sVpDmhgbfoQqCJ+Sg9wOja81VH34oG0JcQ6h5eBlA+cScyU7wc8NGWXvQii
	 P8R0DZQEeiJCMW/QeANZXjn5RH4/F3pzdKYcOsYkmm5/NRmVK3QiPU1nHFi87QB4wp
	 9N85NTrvcE8OmUYw0wBmes9adzJWFC9hOaSn2Ah4A5ZZ/VP//50XGVxsMcvI0XCou6
	 YUQzoV71PN2h9etSplYCLpytRGtPW0WFJvowiZBu1u48gBvYsvl5wBJlpPEUVHJCA3
	 cLENRbFu2XazAoXY1SElwdfbXjKj1y4XbmGey9VHTjfG+iO9CTKtdIxJRNtpknhLUo
	 K+BfpoXr9pM4w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7685B407D3;
	Thu, 30 Jul 2026 06:49:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 48A3C27B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3A1AE6078B
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHJCcc1A5t5h for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 06:49:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D426F6073C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D426F6073C
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D426F6073C
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 06:49:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aSo35frF4x7mfOJYJnWTVu//8w/33K1Z8skKhRH9A3BBHx3z3f0MVghrXnjSPXLbHVZkIKODtV2F3/tVjMu/cZ7NstSVs/imJNchUGtizIecaMPkxPxYUYTMylqZD15U6g775zp3D4BDfKcVHYZDM5/ZhjC4RacvYU8Qwlgm6zcZCI6rOavjUdUF9rYWg1VT8rREWQznksz/blvRUxENFioxM/3Uebet8AgDMFFc7At1e9YnX2qdT3uUrve/8Vz6ir4nxYqAZDhaGA0mm2xAZ7qrz1sbxf68Ahclj/S+6Zy1RlWuqih71mDpht02pA3ddKCv/eRX3BlRfFbzf60wMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpZ/bMh7fWhwyCwRkYiNbA7FctM8xT2fwDuZSdJA2Ps=;
 b=uWOidTTe+J/ssreN/5xs1G/pUGquSo9esXAIoWxm5QtorQy9qg6mJFilpg08lm9l5GJg39IoU++Wgox/4Leht/SRe5wl18+Y9AJbIJrKR6W827LBhQ18/ZBCHNn/CgkjrTmkB7vRWf+8SpaqDcXXvU2pPVylc6Ad8G+JebKo24SKubRn6pVYQeDtGqD2lYgv5lLzfHPWqlTdkOZvSyKq5WCpeMZwoSrWUaXrp0oKlKxf+zsDwcd+S9pKyhMfpY1VAM942pVfFAaDPCFQ1kpO+tLBCyGy1z5Vi6c3PuNAea2qd7VP/PtL2gdEZbxrPoUZiiXVhteeOATqQ5ZHX18QXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
Received: from BN0PR04CA0043.namprd04.prod.outlook.com (2603:10b6:408:e8::18)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 06:49:31 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:e8:cafe::85) by BN0PR04CA0043.outlook.office365.com
 (2603:10b6:408:e8::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Thu,
 30 Jul 2026 06:49:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 06:49:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:27 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 01:49:26 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 30 Jul 2026 01:49:25 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Alexey Charkov <alchark@gmail.com>, Anshul Dalal <anshuld@ti.com>, Bhupesh
 Sharma <bhupesh.linux@gmail.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Johan Jonker <jbx6244@gmail.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Padmarao Begari <padmarao.begari@amd.com>, Pranav Sanwal
 <pranav.sanwal@amd.com>, Pranav Tilak <pranav.vinaytilak@amd.com>, "Sean
 Anderson" <sean.anderson@linux.dev>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 0/3] ufs: amd-versal2: Cleanup firmware interface
Date: Thu, 30 Jul 2026 08:49:15 +0200
Message-ID: <cover.1785394153.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=rFad9cVtMKaxdu7dv1p6WERDFaypk9z1N3XTia/xxg4=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRlfX67VapoVruBpZb+lyNhZ145damopgQ9+jzlkuZdl
 0tV9SyfO0pZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAiD48yMiw3/bh8R7jfTsHQ
 Mr1bbZ12wS8Yug5pp+h0fef5/kH1cwcjw4EzGfNcV/CdTaqc/PrjT3+JM5em+r+eK71gzWNP5Q9
 K6hwA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 8115e6e4-539a-4c26-9853-08deee06b49a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|7416014|376014|13003099007|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: E4PJ2hMK21S325mFNvsQOf1m3kNMZjb7YDwWVEQMYBv0Bilv0eLgYGmR6s6jANzl+6gYH8enCfK3npiQMLZG9mjoQL7m636ILdn22PRlsEN1DiKBIztmYad0ELEhji/GJM9T/6RMsySkDOGr6U6Y1juAfn0VhweasKSg9WVpQWzkl1d6XQyooorCl0wAEnb1zsK4UYsCzziEJHS3ohn72irxC00e3meikN0yDgBz8ewfdFwomwExjt+KBP8/3qKTATw8EfTdgVjkGrsNx2iiYKvjHjGIe1vQoulFlsq+LFqBpGreCJvsCdYVtM0WImjygmD/x17PpfN8Q/PfdZfPTQQciCzz+8LaQYtYIKkAuYccVEO/JNueZJAp3uY2GVMpcferp+1YSGfep0T4cnMmGhDbrX/DKhl5/w43C/59LQ3DGjM7FMRVvpFWo8TEYTyunkKqRgM2EJzj+2py5NAMcGlJLPEEPLwJJ3l4PBTZcukycfqvhSgkbAxGPMmEi6278V4qBILPTnAKBoz5uPromXsYZHlPJedv1MQ6QLsNc/N5taoGVlPn2X6Ww6BuJgicrJwW0UGk4t6mM1SMUyZYRi7U5jSGQ85w6v6mEQlqbAhhWJWHXGRTka/+1kbUDRwtIvxLug/4FbV9Wb5mGUz1kcttTUxy8/q/X+7+4TpxETpdL4pvFbOd0Br5Uv0z1zFxhitehQtuIZoS0zj1chLWIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(7416014)(376014)(13003099007)(18002099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZDmr53DvUKUe/ygLqV54u7Y62w2pfrxTmtFlKQa+J7xQ5/co94UJ160nkUopkNIyR6PMf5hvZmFRBkDcr1inwWkCtcoftW6BM+lpnqwEzUke1O3St4CPCxsj9aZDybTyTdj7VR71CwBPvDA3SXOjUyXxHXSB6aJ3+w4qxZUweBoTG/BKAQYs7NznsPkqfZLx8vMAV6nJ8FkQMaVQudvCT68EkxG2Y1IoRGzse+EGELB5YeZmO50qHRRu4cktGnhPTnqQHOwWj3u2NGQaTTfrmuxDJeBIPsVjr5PD6Kaa2kaiP9XhU7N6eeuEj3s35s+xHik+56IXDAvdcmwxRqTmEHJebVGDvN6MMskNxRZ8Rq6OFv/VvT871WKiGVB5Kq1q/xoQceUEQnK7Is8tYA83nQTKRelj16mAbKoxWJVeKgM35MMyG1FqqudrObpV6pZ/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 06:49:30.0008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8115e6e4-539a-4c26-9853-08deee06b49a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpZ/bMh7fWhwyCwRkYiNbA7FctM8xT2fwDuZSdJA2Ps=;
 b=Qc7lTvdKOmrB/UMRAtQtjU9eHgU3vqX2Hr/wyZCUY5WDqLEntZknm2VUF1i37gAJsQ3o4Z7wlY+JC87BCM6x/vDMOsXHkf9M/n8xbarCgqplZjguusSagaKyoc2BEFPDBnqY1CRQvD30zoVZHsj0AslaO3QMNwAdO+rud1ld21Q=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=amd.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Qc7lTvdK
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

the first patch mainly alignment with Linux kernel version. Issue was
related to IRQ handling which is not valid reason for U-Boot but still
correcting sequence make sense.

The second patch is moving firmware handling out of UFS driver. UFS driver
cares about delivering functionality. And doesn't really matter how exactly
it is done. If it is done via firmware interface, via IO polling or in a
different way. That's why move loops out of UFS driver to be able to use
different interfaces for it.

The third patch is just Kconfig update.

The series is based on
https://patchwork.ozlabs.org/project/uboot/patch/6419fe4f6f1f451aee624c7762b7aa690d50e498.1784870711.git.michal.simek@amd.com/

Thanks,
Michal


Michal Simek (3):
  ufs: amd-versal2: Perform controller reset in the init callback
  xilinx: versal2: Clean UFS firmware interface
  ufs: amd-versal2: Remove ZYNQMP_FIRMWARE dependency

 arch/arm/mach-versal2/cpu.c                   |  34 +++--
 arch/arm/mach-versal2/include/mach/hardware.h |   5 +
 .../arm/mach-versal2/include/mach/sys_proto.h |   8 +-
 drivers/firmware/firmware-zynqmp.c            |  72 ++++++----
 drivers/ufs/Kconfig                           |   2 +-
 drivers/ufs/ufs-amd-versal2.c                 | 129 ++++++------------
 6 files changed, 119 insertions(+), 131 deletions(-)

---
base-commit: 7e24149aacb83335fa997e2457144f23ba5e1bda

-- 
2.43.0

