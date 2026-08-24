Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E32C0C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:35:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1ED5F40699;
	Mon, 24 Aug 2026 08:35:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BgYQEQW9AdTu; Mon, 24 Aug 2026 08:35:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787560552;
	bh=JczOzr6kXneR37/rbTutMxQ/eW4DbiEGrHRdlTLzsCM=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wHItBMh46BE0sTh0Kp300SR1BsUP+pf+Rz1g9JzF4UaS7ErAq6iC3WMcqMSSJRujq
	 tDGpUfAXw+rbzSlLW0T9o7DN887qClrO9QbzUuWWafYvKsLKa3BuMi5+MVpmlKe3oz
	 P2cFs+7y7ZqZ0yHjg2QEfxEQxsGH8PXvs5ySaZZNb3/nr1Ttp3QOmtTgaCwxVjx23u
	 QDKeaN9met/e8d2bRpXbEBZccqIbYmcCPRv0Jq8ae7w7iULMIMohaxCuL5IiN1RzgB
	 6smLfEya+4BoM/uFR1F+9J8PGYZZR8VQ4cU0goDHmKopcPjQflq4brwpWB64F9UsNb
	 bpPV9OYAyzR3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 589B540649;
	Mon, 24 Aug 2026 08:35:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D486A396
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BA9B080DFE
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0uCZbZRTekvn for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:35:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::5;
 helo=cy7pr03cu001.outbound.protection.outlook.com;
 envelope-from=pranav.sanwal@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=G+WZhmED
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EF06580E07
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:35:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAW+0AjsI4gZ0COWEXlTO1ZlZTdPngNRZfSS5Egb2eJz8QBPCYBRd4xvFIjeSvrwerEG+f4NIfVHN3wckbaLI6tDEapf+HrU++YUpkg+suObQFpmHEe3jL5ljcDtwgcfDwGIub8Yy7peRZFvxm9QC6DrEHWiq+ILQCPwzxBma9EF516ndgx0yiF45ua7q2k99sroQqSA+VmZXf9aLqeyM2f8EBmVEmlXmPD1q9XL3Mevm+/5d+Dh7J2mVN+0f7fHTjSfDsczZtnGXx38nZlOPDAhs76ZaifAwZX/kCXqSaxYvf/F51PI1D7ORj0jBKYo41XOEjmfdiC0T1DrnPSTsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JczOzr6kXneR37/rbTutMxQ/eW4DbiEGrHRdlTLzsCM=;
 b=v2ovrr1ufpUaDCCGGvd8wbQcGMxn6Sv5I+Evm2c/vo4nUSQ+UABGtBIjA7/RBd7ISShKRmukqypmVXqcK/Qdo95BO1iCEMY4mQiIhBCXxOmXFgSUZTshDzFHE+aQ5wmRURwETZp2x21XIiiBNZGLpvVvzjwtVKhb1xfugt2SIH0SL5N7Al368EMQQJckRX2JQjvQI/1+wRa57lvYbxAwWT5rzTWFBnVtBgjt2WPjBJp0eErKfsfsBo8YPYWYM4eXl78VJSDH4zQ8WQA25vF1Qtx0m5ePr0IE/vCSqTpl3q2hoPwDevPmszNpY/q+++TlRI2Tbl5fqxNeHc+USJyj/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JczOzr6kXneR37/rbTutMxQ/eW4DbiEGrHRdlTLzsCM=;
 b=G+WZhmED2Jf6Nd2ozFSdTYWIoyR+h6sfZ+JECjdfVuuj4HDDSH5mYfP2sXD3ge1IQaOiFcpHQ+HOfDXkhJYUFmEV9wMUReYVy2Z7/WzICc7CStNziywESQLpXiHmk00M7n22z9xdIBlNx4/7d2Iok5TmLMeLxXFvQ7SleFZ8eBI=
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by DS0PR12MB999312.namprd12.prod.outlook.com (2603:10b6:8:42c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 08:35:46 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::93) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 08:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 08:35:46 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:43 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 03:35:42 -0500
Received: from xhdamitn41.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 03:35:41 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.u-boot-project.org>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/2] pci: versal: Enable AMD DW PCIe controller for Versal
 Premium Gen 2
Date: Mon, 24 Aug 2026 14:05:00 +0530
Message-ID: <cover.1787559753.git.pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DS0PR12MB999312:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f09656-26c9-455a-757a-08df01bab173
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|13003099007|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: WAyAUAasrbSKyVQxrDl60rQbPADyVAXlkQRyoYatrqGNeoAF6kyYBtxABMB+Ck/Ss/sXRixsOfqo48n4jUzaKXXWTs+F8NkQ3pLaSLnS0gf2GucQFeTL1idY4/lYvahBNeWl2TzgvqEl3U+o6tXFp9XV/CuNL+af9SnGz0Y7qHpglS+E8R05Xc8FveDX7U2Jx2odB1UeszFMUbWLXwsXI8XZnWBpp7Zcdv7m93k3/FOXUt6sLbGlRUDgurh5Ri5oRNGUU3Arby7t32Ale0mHyz4IZPbkKrJkrFhIY+SYJBwBd/09SYh4zzw3iuKftB5pREdhD0NjRM/6RpDjg4th4z2e1CB3/tkqvcl9QJX9JCUXXdg7ktuhwmLXLQeDZ6hKDMY2yMMb86+vq6svENHv0kFvXWPEvXt9rjVOBtSxxQX/EkXVETo+FkS7iWZsHdshFRRn5RAPHYMsI+zwIOKfSqup+1CCgiTDdnwOlw2sJdCIUbgpLFtHVGwOx54pN5V3WAyu1D1Kvfd7+9ucwp6UHwKb6WB+ij8TOqQZcRxdLXjKBGR67ct4O24d/Q3kObq9rfxCvMEkEakTaXwjrTv6s42fT0dZhjbLkAvdrkIu5sQ2P21PwMvlj9aYA1rjBCkiIW8IPE02iugGhXKnjXwL7m92CCLIK1d4WvcbOnUPvjE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(13003099007)(56012099006)(10067099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZC+2d2rXxLPmMyZ5NZstE+xWo0MkNzV/aO51GbKShpAI1qWXS4CLdz3QKeqQVXJNm1ZH3FGIvVxy8lK3zackK8pndbAoUlvR/RcD6b2umpMQlYr3RR7D0sVxfWB1Z7bykm5k2fkS1ijb/aw+eBFetaTQ9NvZmkSiQegKcu4FiJQDB1Zx9FcHyQtpqQPsLec+QVbDaS4wMUnit2+UAm/7GGz18SeSH9KqzXf326Pwp3myv/wJIVWAn2OcxxgzyXnvnLN69RtCe6473XdSLpYZ7csPSCbAMwaj6msHoapPhG7c+PhiZLsrxQIUKKUDXbUdLkSZEkNDVJJrCtFb7ewSioV7fdmQx+++XUqgTuwZMJ19oFZJcJAK65UtCuzxPk89E0hkYXrKLCPr/NsZLTaQBT+TZVsKhyvOGIN6s7A/+m2Fol20sfOw0F9xTcjni+SN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 08:35:46.2222 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f09656-26c9-455a-757a-08df01bab173
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999312
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

Enable the AMD DesignWare/MDB PCIe root complex driver for Versal
Premium Gen 2 and turn it on in the amd_versal_premium_2 config
fragment.

This series depends on:
"configs: versal: Add amd_versal_premium_2 config fragment"
https://patchwork.ozlabs.org/project/uboot/list/?series=519895

Pranav Sanwal (2):
  pci: Enable AMD DW PCIe (MDB) controller support on Versal Premium Gen
    2
  configs: versal: Enable AMD DW PCIe controller for Versal Premium Gen
    2

 configs/amd_versal_premium_2.config | 4 ++++
 drivers/pci/Kconfig                 | 4 ++--
 drivers/pci/pcie_dw_amd.c           | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.43.7

