Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59534F531CC
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617B1841D5;
	Mon, 13 Apr 2026 22:36:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="M0esJXG/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D0CE839DF; Mon, 13 Apr 2026 22:36:23 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108818407D
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=rs@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jE0FsLKPOyzk1XGegO3eIWyNfnGDAk91OniwPICsk0Qx3w9TbgQ4iMfki6e9ztvvELnCamrU1fOFcMk1/x8XUa9JlH3rHQnsggMcl6+CUf5knScvcxrZB1CWNXJlBaNGtg/nXBYKQqO45bAQ1ViYwB+Sbn7PHHtTym8Ebp5pQMRO1IDKdSjKDgKGCfcBfS7d3b3/cD/gopI+iAVjt9H2ycpQzvNd8qwC6/A3pO4oHC3sg7sh+fee040+Z9q/fTxoAhyE1c7vXiM5xi2nhdFvJGwXDKtKVkKmR+CUVjd+N1sG2vFCbc069PzQX6fLlwMcor2/cSrYyV1Lr6iRJlcPiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BihGei9F75MI8D2TW8eLiANcx8NBUGDI9uEcleqVqXc=;
 b=vdKzLfZyMOpQkVgz1wr6UXHELl+XKvca7DzRn2E2gQL8PFCA7/7aXzfGjIivtmMOq6cAIYsNtDR5IhtI0FL1jyKAAQ98A2U0f3PPPxKruPi4OKMgncIn7wGFVq9k69MYYAPmq+65el0saCavC0E4FvvTgq1YvdaV/CrmUYmYoGbIKL9Hddr57fL8rMhFloeQoqVQgHHlpjmLAKFiWauYOsdE3b+OMoNwmxLzIfmbVobnb07MAWu0nkKcor25xGBHpUjLcyLCCfKljt/WavZlARng5cl3yFgdf4lRo0iziWHlvVq5gUVCdYzazAif4N2IhVe8L+c2RypFkeR4QpPaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BihGei9F75MI8D2TW8eLiANcx8NBUGDI9uEcleqVqXc=;
 b=M0esJXG/Q416btDB79CY3hMd/XqNJIBiiOD9/wbZyYk2XEXpb6m2nlL4+LIPyvpPEocoiVz5ZrFf+ST3KSfLO1Wq7hkRqQreWwzEikVi3la0M+iTNxddMg8e9ez1JgzoFOSwbV/iHskujN/XKvdTQNUYx7eY0bbml2Ex0n957Jw=
Received: from SJ0PR13CA0059.namprd13.prod.outlook.com (2603:10b6:a03:2c2::34)
 by CY8PR10MB6611.namprd10.prod.outlook.com (2603:10b6:930:55::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 20:36:17 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::d9) by SJ0PR13CA0059.outlook.office365.com
 (2603:10b6:a03:2c2::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Mon,
 13 Apr 2026 20:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Mon, 13 Apr 2026 20:36:16 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Apr
 2026 15:36:12 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 13 Apr 2026 15:36:12 -0500
Received: from rs-desk.dhcp.ti.com (rs-desk.dhcp.ti.com [128.247.81.39])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63DKaBsa2729634;
 Mon, 13 Apr 2026 15:36:11 -0500
From: <rs@ti.com>
To: <robertcnelson@gmail.com>, <ayush@beagleboard.org>,
 <Erik.Welsh@octavosystems.com>, <anshuld@ti.com>, <bb@ti.com>,
 <trini@konsulko.com>, <afd@ti.com>, <xypron.glpk@gmx.de>,
 <ilias.apalodimas@linaro.org>
CC: <u-boot@lists.denx.de>
Subject: [PATCHv3 0/6] various memory related fixups
Date: Mon, 13 Apr 2026 15:35:49 -0500
Message-ID: <20260413203555.1990337-1-rs@ti.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|CY8PR10MB6611:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a827129-31f5-4e12-e903-08de999c4ff1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YM+lxncMUnNMdasCgPPdu+fQtxI6HpIuhD/9598CJuG00P+lF7OLyxukWBcrzxM8eMjkaIWBiYDz5glUJgSLTuaKQk3p4ANuuLIvXIfsq+zAHRm209JVd6Yo2eCKs3nWKMNW+SdKAKTD55IdGgD9NlWlI5tcNuJ0yGSDMm9ZLU6N46teoOwoifejG1Udw59+Isk3VbDJP+juEt8brlSViwvWQfP1xLMcF53xI3S3/j7ZM2CrcuACKAh49WmupOynXzzbFaP6a0XPn7sDMT9lU1PzkA+/Ds7V7zsEXjuGe9D2BCQeo5GQU80urenIhRq9697mlQCPaY4E77QMej0LkOiiNluzkoKpidm8IfyesGZS11e3qjoQ29pfPOjtif33Os8frLTSggA6419o4Ir3TJ0+PIgL1YDUcslWQp6yrA+iuk6BtwOF25VWXMxdO+mYi01gkuJcMAXrRysxe0nzTUynkJt9nZqbcv3cSrDU+1RC7/mnVSInXYuKVTvIa9MVyW12SsvRkwcTnLt9pEXYbUBVQsbd2RLjpcGerNhsjGTuF3QGtIXkOnOpPX62XMZwH7K/wrsatGiO9r71qUI0Gt7mLU3sljDJZqqcrKQWyh8epTExmmN8Xy2okYVoNPf0yl/ge0xR28bsy/ORPYXgdcsm5LCdc5DPfko3cPD83PeXZn7rx2W1Ej3HshM3Yji/KUQjXPmy4+K+Uxa+KJ2KQJOjNRhHnfBcI6iE6qQPKx4xJqeMda60/0IRoCR2jv0gB+yKFwPzXNReJfdfYqXOWCUSM1hx3h2EQxkQZKoCFKY=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: csQz5KGKfvkAniMtC78DNPBU1wP+FV0IRNpNQTnWux6uctaOqy1C4fImI/HqkTo7V0cvD1KzOXxwELu5ZxQmcKYLSKR3+Fbn8kCB3CcWukO4viKX9XIvCz6In/sqQslopRAzviZlSGbCc6Z3prfWKobc/HpXBZs7T2I1LrbsgjKD7fjt0cH6cAQLwS5Kbnko+H1gPTttBHnkZiZNuhlKktkKeueaRiem+wR0hd6ESEX05a8dlZZNFTLfzfaC5f40np/fekNyFcTFXhi9rH1cIvTaDqd9QoUcw/WmaVzHbcZOnGxw1/z17KTkxzJ2ioKxn24+NV5bnC7c4C/wf+IW7wCZRhKXkjfm3lXE1lyUlxaG1d8Yv7Jcx2E9BOiGLMP569H775Qa3TVSdXHFHdLI7F2S2ehyz5vV1+8jfV4eKqfa8oGOAFufFlL/oyb+RfcN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 20:36:16.7028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a827129-31f5-4e12-e903-08de999c4ff1
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6611
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

From: Randolph Sapp <rs@ti.com>

Nitpicks and fixes from the discovery thread on adding PocketBeagle2 support
[1]. This does a lot of general setup required for the device, but these
modifications themselves aren't device specific. For those specifically
interested in PocketBeagle2 support and don't care about these details, my
development branch is public [2].

That second patch may provoke some opinions, but honestly if that warning was
still present I wouldn't have spent a week poking holes in both the EFI and LMB
allocations systems. Please let me know if there is a specific usecase that it
breaks though.

[1] https://lore.kernel.org/all/DHHC66BBMD27.YHGIH43C6XBK@ti.com/
[2] https://github.com/StaticRocket/u-boot/tree/feature/pocketbeagle2

v2:
	- Remove additional increment and decrement in lmb_free_fdt_regions
	- Drop the patch to backfill EFI_CONVENTIONAL_MEMORY
	- Adjust the removal loop nitpick patch description
	- Change the reserve memory patch to use new end_addr_sp
v3:
	- Update lmb flags to use the macro documentation for constants
	- Change efi_mem_sort to use list_for_each_entry_safe

Randolph Sapp (6):
  lmb: allocation flags macro documentation
  lmb: add LMB_FDT for fdt reserved regions
  efi_dt_fixup: use fdtdec_get_bool
  efi_selftest_memory: check for duplicates first
  efi_mem_sort: use list_for_each_entry_safe instead
  memory: reserve from start_addr_sp to end_addr_sp

 boot/image-fdt.c                       |  5 +-
 common/board_f.c                       |  9 +++-
 include/asm-generic/global_data.h      |  6 +++
 include/lmb.h                          | 44 +++++++++++++--
 lib/efi_loader/efi_dt_fixup.c          |  3 +-
 lib/efi_loader/efi_memory.c            | 52 +++++++-----------
 lib/efi_selftest/efi_selftest_memory.c | 21 ++++----
 lib/lmb.c                              | 74 +++++++++++++-------------
 8 files changed, 123 insertions(+), 91 deletions(-)

-- 
2.53.0

