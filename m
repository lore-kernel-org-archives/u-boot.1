Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FCDEF4ED3
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 12:19:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3F2983C2B;
	Mon,  6 Apr 2026 14:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UM16Q/Vq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F21783C2B; Mon,  6 Apr 2026 14:19:50 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FE398341A
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 14:19:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cM3cWc4/QL0mBhozbMz2OluTXcqEPJ9lUh2L4lUhfiXnJ0cOYWECG9PwDnXVBHh/4e0HKvNGriY73LxuRynToM9e9ja00eGcqtNzX/hp6pNwCjyCGfKm+UWJUZY+QBVT8Cq0FWPkKDdODeUTh93QQQuEGw89N0b0qkdgWe1E88pA+DNg50Mv9EYxScy/GWqtwea4bxG9dAUNZXxBUQ9YwEZlQ6w7hxZ1PbZZcDdvU/cWk22zEETjgVqejS7K1tw5OHM+xvVxQjP80vrJsVo4FOX1z/LkZZAwx5URI0n4PyR/+BFXoyC2W0pa+6/XVtNFu1iJtKvy4I+h5T4bzy59ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBXd+gwAvU38Bk67TAzJY0A6O3Z1FkpMW2b7X6T6NC0=;
 b=f6g2XP5FrCj1M0ct8Gx19HPaqgPkF8A2j/ika+j7ecSOdugAuByA1F4d45xBXMWupATShxAIODT75yEurDFCRPJPlrfx0QCjdvO451EQBNeSo2KHb0jt2sBloFk5lx5V5L8SiqsRPz1Xd2mUQraB0vk3ocYFYoMcH4lBpXpLdGTPjFqYj86NwTv/0vV3ULI2bznvO/qWCYCi4JsBs8hE1FKHvx7BrjC837KopIiE4CmO8+LsYs/lJQyobw4EtEP7qdg2728PcfsgoNdcHk9UjXOkDuJDhpX8uYKQwTRp3sanYKj3wxbFmmOlssoLJxH56mulTAMGmA9alHyQDc7KdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBXd+gwAvU38Bk67TAzJY0A6O3Z1FkpMW2b7X6T6NC0=;
 b=UM16Q/Vq4WKHTf2f8Uv2X6eCxm/fdmuHvwP2NMxynbkDyszaJyWvLoLj6pnR/3xEUGOuwprUdVuddd+MtEpoy3BlhDrFLX8bqrZH+MDxAF2hBUvPYWSkomUFeb90fm9wn57wMverHdf8716Q+RRxSZRQEZl5+/mxHPD+M3pOSTc=
Received: from BLAPR03CA0113.namprd03.prod.outlook.com (2603:10b6:208:32a::28)
 by CY8PR10MB6682.namprd10.prod.outlook.com (2603:10b6:930:91::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 6 Apr
 2026 12:19:45 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32a:cafe::9) by BLAPR03CA0113.outlook.office365.com
 (2603:10b6:208:32a::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Mon,
 6 Apr 2026 12:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 6 Apr 2026 12:19:43 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:43 -0500
Received: from DLEE203.ent.ti.com (157.170.170.78) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Apr
 2026 07:19:43 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 6 Apr 2026 07:19:43 -0500
Received: from localhost (ada0543016.dhcp.ti.com [172.24.233.9] (may be
 forged))
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 636CJgei682285;
 Mon, 6 Apr 2026 07:19:42 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v1 0/4] Relocate U-Boot in the last bank
From: Anshul Dalal <anshuld@ti.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: <trini@konsulko.com>, <marek.vasut+renesas@mailbox.org>,
 <jonas@kwiboo.se>, <anshuld@ti.com>, <sjg@chromium.org>,
 <u-boot@lists.denx.de>
In-Reply-To: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
References: <20260403090109.3564638-1-ilias.apalodimas@linaro.org>
Date: Mon, 6 Apr 2026 17:49:39 +0530
Message-ID: <177547797994.70791.1169538213395415434.b4-review@b4>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775477981; l=927;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=ISntabbdhASj9C4SSejGNTmddBJyfV6raubxaMQ3Obc=;
 b=vsP5Sz12psHnUMRDpRlOk5C/VeHf4PeQ4UOHHXtYG8DP/hkTTwxV95SnejPJo8BIUmvAExifB
 zeAs2i3t9duAO+PWnsuCwXUyrmDY6lqfAnSCEAzbllzzjJrtcneExu4
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|CY8PR10MB6682:EE_
X-MS-Office365-Filtering-Correlation-Id: 05df6877-ae8a-44a6-bf51-08de93d6c92b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 15mRZ9W/6u5DegSADrjB9wzRnGKrP9YDxgMVTRc6Dz4fZDtgCa+QuYHyiMPQEaZDEeQviwUTSMPod0Y8q7vioX4Lkgh0mGMDlAeRMPCUu9juwX/hI4AELMq67U/07pHP5700rXfFZN8soonL59JUdnxvL4+td5V+5AWxkn+FY+sMav4D7RWd8rmGcdPnLAnnxUdTuuUvY4csZZ/3mkaqdI4s+TTA7L5KY+bhU2QfGqfW5Iq0sHruHDS22d49y4HECmgA4VHTsrhomGzzjhvFxv/IFp1e9KyawDUDwxnlhQoEj3eWWiIvkNN79i1wdG3y4MHu92Ja+juxC/FqSuPVzCuWzj8QDgf8osHcyvuvgspV4671FxtYl+/5GoweKUS2JcOSHslwa9ffYAa+AwEbQevFowcBgkvBecGFNmwcWcTbHnqPKKNEHVTDiEZ36fRq4TdummMNVYn6QHtN4cbH6nv2lHHQ6SGCwZez6FynyP390DxlFvhoTLXP9xEcK+VHtsLVqeRI4N+dOtyFnLFNTI++rQZR07pK36E0CF9yHxdgIznRG7/jhgumQwKxS3kX/JxCModW73rPIWnhyPzcAKxjH5vqaDXgWpenl2RSswu8OWSUouC1+I7/9Y/2XdJ56yXu75b6qJ/C4NOD9cRGbk+D/xF1nb7Lu5ZpbzMyBDBX+bQusOvExiIOFbsT37ifIrq+DVilyvInZlRofW8+/RBNY9fASAFWfQ60roJsjaylssG06Sa4Tqdtg+TtT6t/uusD6CRGnnc4JOumU2bPow==
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EPN5R1wUGNA4oVoT6jAxvYZnP9L2CgUKsP0hAl3XeqRbEkhCMSQYFhzIJwIOx9NoO41EFUEPKRJqGTofStF5bz50MesEYxCMP4ia9J3Q7ODTG/ztrQMvhC5YfE3pVy6pXaUuONmPY5WgURYaII25TJgbb6bsn94MioT8MwQvppmTY3uEuWsQrekufgmkPRMWFLDKnHNyfJajk9GKh4YcbCEVJzpOZMyTKS9EwVMgRFBVF4/jlbsVn/sPo8K+KK2ex7K1hmZfKaw3PJ33kSbi/SvnbfipFP5kTuTVCUbxXGeRivDAQN6c2zOb4UIFUXsU4uRIQGMG6MYBwP/51ATJTqvo3lB4E3OCG8UrjuPsuM1EVeAu1L92MdfuHt7ouTXuUrMFIGpxH1qM0NKhoCv3KpGefAQRWdMP9LOSTWkdXZTGMTg1ar2mtd/M7mnV1HNs
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:19:43.9343 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05df6877-ae8a-44a6-bf51-08de93d6c92b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6682
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

On Fri, 03 Apr 2026 12:01:02 +0300, Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> [...]
> Patch #1 - The boilerplate code that moves bi_dram from bd to gd
> Patch #2 - Moves the ram_base calculation in its own initcall
> Patch #3 - Cleans up and prepares setup_dest_addr()
> Patch #4 - Adds the Kconfig option and code to allow us to relocate in top
>            memory banks
> 

Please rebase on next for next revision, for now I have tested on top of
075bd023c77f (master) on TI AM62p and AM62a EVM, below are the relocation
addresses:

         Memory Banks                      |  Before  | After
AM62a 1: 0x80000000  - 0x100000000 (2GiB)  | fff14000 | 8fff14000
      2: 0x880000000 - 0x900000000 (2GiB)
AM62p 1: 0x80000000  - 0x100000000 (2GiB)  | ffe9c000 | 9ffe9c000
      2: 0x880000000 - 0xa00000000 (6GiB)

Tested-by: Anshul Dalal <anshuld@ti.com>

-- 
Anshul Dalal <anshuld@ti.com>
