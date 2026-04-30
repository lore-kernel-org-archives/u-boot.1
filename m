Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA347FF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 09:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6579B8466B;
	Thu, 30 Apr 2026 11:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E0RE0i0r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D66A184662; Thu, 30 Apr 2026 11:34:44 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB3284662
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 11:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Pranav.sanwal@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0oxtQYmuIgL1hvD65HQajcj/AVo7VSeirRnMRJKSeBLxiuzJ4ZJLZGEdD/hwLxGyKyzMu1qnqzda8At21R9KTfo3sjBuQlmyeqT2zI62SZ22GF1ThURNHsR5ZYRbGeAydbAtO2Dd//pTYWxOk/GOThrEuQF5MuCYxFuPXP5dvhBCI5HiF2VBf4PkhHGDVyWK6rjtFfkST8HV0UoQXRVuevsXQMSydH5nPEfiNcM4TdOat5esjXCdzo76AjFF5cT9E6E9ggzj0BI38+bUJ0icRqqn/F32NdoaHK23SGIAlebeE6nigIvoMGggJUHMMoUKdf/yFa+8jBqnhOx2j5P4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79ztOqPzUEIcmIsCTxskqS4CMxJep7b+9vEEhyQ0/JM=;
 b=yWgJoztetqLZUvqZRruY5Ho3zoXMHjLXr/tpaAHgxftz2hsURi0IejT+gsi5oFIG8nh75RfyScNpcsOnufjHzn//8nVVQo7YQ7ltFxl3KPt9Y+gg7U1c8pc4Hzp4NtEHntt7H824y+sBmOsRis8b+MKbM8ako//Js9y2EwcNRJJlN+InY3vQD2RzMlNs084gMlxKRGzmlGCeVY3wAcuQKwB2hQvxoflSlpvGrkku5M+YWHrP/43bmUaqZDqANHoISX56x+DM49AtQIXFCL4yrkOKpKSBOO4YEnmuYYbvM49hfzqyvwR3mYSxKj5rW60dbMpi14as7G6dCmaeZbb6xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79ztOqPzUEIcmIsCTxskqS4CMxJep7b+9vEEhyQ0/JM=;
 b=E0RE0i0rtCLHOXasoufIb4Hy+/P6fWkp/Myh/8IA4V+mJEFn1YPO6gRrzU/qZmOblb6AtqCJAceQu68TYC4mHoFx/vCUseyV2P86Sp9cnxNbj194RUfEI+GnETAFwJAnTIlQ0SOE/2spU/8vGynGL3xbXZWGoQnPHJmjdpl/IuE=
Received: from DS7PR05CA0082.namprd05.prod.outlook.com (2603:10b6:8:57::23) by
 SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 09:34:38 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:8:57:cafe::cf) by DS7PR05CA0082.outlook.office365.com
 (2603:10b6:8:57::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.5 via Frontend Transport; Thu,
 30 Apr 2026 09:34:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:34:37 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:34:35 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 04:34:34 -0500
From: Pranav Sanwal <pranav.sanwal@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>
Subject: [PATCH 0/2] zynqmp: Enable USB gadget download and remove hardcoded
 USB ethernet init
Date: Thu, 30 Apr 2026 15:04:25 +0530
Message-ID: <20260430093427.1852145-1-pranav.sanwal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f024c6e-9f6d-4354-8420-08dea69bb22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: JvgfzUVjAxZ9BeoD33yW48gL+7ViJGp/NsDPCgYiysnIP9EVKcXycyPsctSO24ZhjofS7U6aevoT4groraEo0wKdWjDbkm0jyXrsJQyZXf+37D6d5iu27Wp+p4ORomBurguA1yqPXsvBF4VXJ/leTqMcEJANMALv+01686mINnJgrTsxEft8aU/1R1Bh+8oEgWiNkiIW4xYDxj6973hPDiikdGAHHcSyNe6ro5NggbT8gqcG0hg9OmQeGjluU8dk5fn2OAbmaKQgE0RIw4qNKg33RTwz2NmUKRACPPqW+qsn/ZtKjekw40TDkXNPh3annXoF697XurBftgIS89oo6hOBQYBfudGyXdeOJKlBM7p7YEqC0lZt9jCvaKby9pTln58s0mEZpQVNvIGNYYPl63GW03X8ihbqBWc5/JFZ92U/awopgyQgf6Q3jMyYNUQ/nhrN4fiD8LiRty91ZOU6h9/DnWvnQViNthj1SspabUjE1fov9+kxW7Rb/G74z6azwIETpe2i3BzE6Iiq8X8j206LSyz05+5dXAYY7IoxyIFnD0VBrw/D5WMxAXCaGZCg/UKVvkQTU0po3N3tfTl8dxZzgDXMSTn+XaiQLemHZWVXhRVRcfXD4GFjpp3003gxlpeW5rsrQBAQpiCn1EHPwVio6E84+Sr1Jdkzr9YUMs+cvXjXNK9B0RKzqR3qopUk5/IV+UyI9C1FtLVm3B+hX9WxGj1sMm1ZtjNlLQKF4qX/0puJGhgi1xe0114zEDLPHhnGirssBVOIVKpa4vbTNw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: y83OylXWO9Z/ghXZae/Jarzy5pPqNfrd37jMYM0w414/kDh0CRZs4RytDL6k1ysl2HWNtBqZURSRsYef67SLtS2GqTn5xshkamt6xp659XmRDmtqEtwuSrypDUrAZ+H0XVNiEW/ivvSWWgzy1S/OEPMh/8lJkv0FKN0lYNc8hATUzD8EhEdxoUFi0xmzVCp+1OPss51R+Tb6dX7hNe0goqfXBHP3FW0q4eqdX7B2Q2KED9KzcO416q7pXwHqs2Rzp6rhVgGv19++2l3dajG5xohs+5MJlKMnX5OUPs+1IKS+tA/foXvFXtLlRcAJ1Ch9Ftq7ytqHb+3iMh1zBkTroNIiWztM9GWGivuvPKB+xDOuXI1sn2ZQ0x9hQC4OgH0zdDgDpcWwoZb0YEUg4k6laVebAL6tP+I7FQCtpbB42hgfIcyzjE3youmGx7hnm/Bt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:34:37.1053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f024c6e-9f6d-4354-8420-08dea69bb22f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164
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

This series makes changes to the ZynqMP USB gadget
configuration to enable USB gadget functionalities.

Pranav Sanwal (2):
  configs: zynqmp: Enable USB gadget download support
  board: zynqmp: Remove hardcoded USB ethernet initialization

 board/xilinx/zynqmp/zynqmp.c         | 4 ----
 configs/xilinx_zynqmp_virt_defconfig | 1 +
 2 files changed, 1 insertion(+), 4 deletions(-)

-- 
2.34.1

