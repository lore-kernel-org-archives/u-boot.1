Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64393C55174
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 18:13:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F4CA60693;
	Fri, 31 Jul 2026 18:13:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVA0bwX5vODJ; Fri, 31 Jul 2026 18:13:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B306F60657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785521628;
	bh=BmltzXVcJQr8wVZbIjy64G8uGBSGZvxOvKMcHozIdH4=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ci1fop7gEM90kYDeW0Ork9HBkr7d+lIF0aKrJmv0t+za+2UW8vUBHmIzZg5Syxyus
	 g5TCb02EYmxkHzyVaaldk+iRmKI/QUGkV9HqBCIK4LUTu+2c/tm59vLZ2FcIMNXunV
	 DyZXx4qY+xzs2C/WNoCJgEose+tLy52XL1uV3ack6DAuqCkezCLLczoZaKVDKMn++u
	 CpmDnzhNl8SDVDGwIHJO9tSicmKAmPhNObuejVGNhaWnSuDs+THfxi/zPqoiE9HxRt
	 q+LMegqHij5J6z6unLZc3RzpOf31iU7MIiX1xyk+xcpBcv8sdY/yaWnUqM/GPjCZAG
	 ug538TC1ZU6Og==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B306F60657;
	Fri, 31 Jul 2026 18:13:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id AC8CA3B6
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9E4EC400E9
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3eiERflYuBi4 for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 18:11:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=smtong@axiado.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5C05C40025
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C05C40025
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5C05C40025
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 18:11:07 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A69D84A30; Fri, 31 Jul 2026 20:11:04 +0200 (CEST)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAF1880117
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 20:11:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qlw8UC+tnzPVpPy+lOrCOSku799bADUnnZfQ2epC/xYmLa8ITF+N1uBUCwUcWf6uwVwezTsHSaI88IT9zVPQOABY/u1E0tOikSFrooJUPqqdWQ7BxDEbXJXHFqoNMxsVgORRjW57fDcYnUAh2lOuhQEo6IMFyD95KRT3xFkYCmBD/C592uRs3GUk88ncUBVAB7Uqdv4e5LnmOS/iQyxV0miQbN3J8bR8XOEwyvn+FzKTd6GEA2GFquzIY+nRI6KCx6HLHNca2Zpsjje2b9pDIlEd7+cPIlyXdgzB8AQEkb2HvxgCiucFNuoBM4OE9uELx0WJX5TrivThFpGjQCmXuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BmltzXVcJQr8wVZbIjy64G8uGBSGZvxOvKMcHozIdH4=;
 b=PmJ9+opEt3sbwHKD7pG3/2LBEraux4zpKj+ldMAcDyHJFPYzsqEcTMzrZsaItzD3P8TmAyNIX4zSA9gwBR7lOHJeMthx4gVWO6LocUo/POsDXwksdfLSGEjn0cahYRIRHCDYDCZAMdCLFGUi2iv0xX0iz6pRqJXGV3j/dI2ACx10BwLDoIs6Me8jkN4H2Pbz20M1mAbUFbB0Ob46jTdPw8z4erm1LKtbs/QxWb5yVJlqQ3Z8Bl0fKRJ2bTvkkwRoYCpsoLuOn5YlEQnJG0Y7p5A7vK9nMTZTZswtvxyRq7343g6/G9m5zQHBFK3655af5V5V1dEpz4FQp4wNvQwTGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 64.62.143.114) smtp.rcpttodomain=arm.com smtp.mailfrom=axiado.com; dmarc=none
 action=none header.from=axiado.com; dkim=none (message not signed); arc=none
 (0)
Received: from BN9P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::17)
 by SA7PR18MB988375.namprd18.prod.outlook.com (2603:10b6:806:4cf::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 18:10:56 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:10b:cafe::a2) by BN9P223CA0012.outlook.office365.com
 (2603:10b6:408:10b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.14 via Frontend Transport; Fri,
 31 Jul 2026 18:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 64.62.143.114)
 smtp.mailfrom=axiado.com; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received-SPF: Fail (protection.outlook.com: domain of axiado.com does not
 designate 64.62.143.114 as permitted sender) receiver=protection.outlook.com; 
 client-ip=64.62.143.114; helo=smtp.corp.axiado.com;
Received: from smtp.corp.axiado.com (64.62.143.114) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.0
 via Frontend Transport; Fri, 31 Jul 2026 18:10:56 +0000
Received: from [127.0.1.1] (unknown [10.4.1.117])
 by smtp.corp.axiado.com (Postfix) with ESMTP id C25E94157BE1;
 Fri, 31 Jul 2026 11:10:55 -0700 (PDT)
From: Siu Ming Tong <smtong@axiado.com>
Subject: [PATCH 0/4] Add eMMC support for Axiado SCM3005 board
Date: Fri, 31 Jul 2026 11:10:48 -0700
Message-Id: <20260731-dev-scm3005-v1-0-30bea90ac5f7@axiado.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACjlbGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyNz3ZTUMt3i5FxjAwNT3RQzo2QzS2NTEwNzEyWgjoKi1LTMCrBp0bE
 QfnFpUlZqcgnICKXaWgDjjNdRbwAAAA==
X-Change-ID: 20260727-dev-scm3005-d62c69354074
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Prasad Bolisetty <pbolisetty@axiado.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tzu-Hao Wei <twei@axiado.com>, 
 Simon Glass <sjg@chromium.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, Karthikeyan Mitran <kmitran@axiado.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Siu Ming Tong <smtong@axiado.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2258; i=smtong@axiado.com;
 h=from:subject:message-id; bh=rTl4034jJ6mhhVeGIs3q2AtE7c1ZqH46D0g6zmiKT18=;
 b=owEB7QES/pANAwAKAXwcqHIUQvOOAcsmYgBqbOUu71XD7BD0+8QIQa7gdmxWdvI1ehBN0UWP9
 Rz7dH5d6hGJAbMEAAEKAB0WIQR3Lze7GwS3XzAkT0h8HKhyFELzjgUCamzlLgAKCRB8HKhyFELz
 jmAiC/0dFmwxEwSmrpaomoInlgyRmiuZyy2JGODSWk6LIXCyI3YhcoANX98ya0qf8aEGEdyID7I
 yU0vAIgTfA25Wyye/KDumMsWTDFGJ3YyhzepzS2C8dmm/N8eSkd3Z0BZck5LA0qoTrHy09KAM9s
 g8RxE3fYlwkjv3+62FPurFfKHHLY2wZerPWWTVClIN1Q5si7QPFDSTKg6rp+eEIrVwSfHOHr3dr
 Jxfzj7n2/9IhHITc/O9dGyrG8NYyA1fTTNL4NA9qnlu+XvZ1WNeEoBFgscDQ4dlI/NYovUr5qcT
 Retku/E7yLOtWWPei4hCGkn1CqBHBWNWdtlJeHt7xfHmZlUVVaAKNWHA8yA4RroLRWXsfVM0ttn
 aRTf4fJbVgJ6C8PwGO4I12Qk5u3EXaYbwDesVI0/0y79cQxD68PUM7aed5FtPOywA7EA7bwGjAb
 whSOuqTw15wGFJwiNrSY62JSwdZ5hVeIZs93TEEjSTJ4q88rn42CUqbkiHZEjpu3L7Agc=
X-Developer-Key: i=smtong@axiado.com; a=openpgp;
 fpr=772F37BB1B04B75F30244F487C1CA8721442F38E
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|SA7PR18MB988375:EE_
X-MS-Office365-Filtering-Correlation-Id: 93db40e2-3ac0-4c39-3b21-08deef2f1160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|56012099006|10067099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: Ug7M5CFpbAGLdnn8qyZDWDhQQbtTYNbuBBwpGhd3BeVBaAGvw6PlI0vP9tux4UW+zG2tDKc0MKo7JvKxH/qt9ioKaL617nYGhdklbA3qnhh+CA8A5U8bjkbBpE8y4egvXYAn64um29EoRXG1zweVi/SBB9V2xEfO/dYzmmGK9kqFX0akXSxmR8FNAI/oSK3OT25Lw4GmHZUztuPMd+KhILtcwdtwuqEJBwDqCFAzSn6/uQ1erT3mzLDbFJizIoQdyK006+XaB8wf1RljtayyN0ub0aUYJxEy2SB0RK49DGR9e8tldJmWmHADboypRAY+zqpKUVT/LFnpaI6k4pSCe0YN8EUY7ZqNPIjbm38arjCJ5ywBfKEKEpu5zjeWlb1BNOT8NnqDrj3j1DDLq4r/MaRFdJHye9J/wzR3AnIXjYInnd8YGcO9Q9eMrOQ8WSzN0WhCQbt6WhtLRSbs6nkPlzs82g82s7z0lP8tmc9jLxxdGFbDhyYq3kQIkyYpsVmh0tKiioCOMKFFoM93g1i16g31uGHCDxJTNrK/6DmuErqHm93+P/5+krbjw2gS0W4yI7ATwniB3QA3mAOJMyWX6o2jS9lhOObJmeSyiR4Sm6+SpRFh/DJ6Il+YS/VEWzK1/O6phrawt/N+yUc5h3QQII2+VFsIgjioQdWzM9/fwCs=
X-Forefront-Antispam-Report: CIP:64.62.143.114; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:smtp.corp.axiado.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: f3iR+qdHbkBKHVCscsYCGtw+xP/PrkhLLox2Kok5C9S/ndk44aO/rEEXiy7QtstPKYpJ09Z1aOTvWQtNZeH9YuvqByoDGYswtF9kr+5uRTOpjKnTgB/LNtCO9cmcfUoLF3FdCLx5e7dPwJURqWV/ATGlcwiM28BTwMN3nGZT/nNf+eCjzK6nv1mIhQdCcUwCSd4hIU4q5QNKZGHVJpSZXQqSCE01mb/sbLxCx60uKPDB3SQv+2l0uQCoyA0ucFRHyeBZH20WhdpEiQz9jG+0UJRHNrD5iHYZpNyquHaLHq295vzhY3kUAN54/bcv5lbivTo9nxGcfUaV0gsXRhAKviPvqj7dkqnD+1UU3GySxUM2NFiu/3NrFkUAXVwti4zQlrAXgIZ54M+QYgniz6eZIPyOBer4d9E9or/xG9FPxij64fw7GBaAFFFkRGUAcQuF
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 18:10:56.5469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93db40e2-3ac0-4c39-3b21-08deef2f1160
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=ff2db17c-4338-408e-9036-2dee8e3e17d7; Ip=[64.62.143.114];
 Helo=[smtp.corp.axiado.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA7PR18MB988375
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 18:13:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axiado.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BmltzXVcJQr8wVZbIjy64G8uGBSGZvxOvKMcHozIdH4=;
 b=jeQdcyKwa33ddMRtIJQ7FYUV/X6sQadrprAnQ8F8FH4a9aukzsHV32u77slGHAg/eaD+0/hwjVVxDaQmJVzpIrjPChPqU3wvvvTrd8CIuvevK7EwviYJdXiHlmYWO0ruCnrz8OmVZ9NIjoP2g9RS3wtLSmkUUD/4V1vdqV51cGJCX+wsoa76w5/OyO+ANrpUsBoTvi+z7ZptBdU58ehShji5CXgaQjmfam0jmuO9fWsKxNrUIDtepPDFJab88EPR84ZBwGmKYNjbMyfpEm7ujURiv4AMUGVlYIckvQaIAvmo7Z+0NSTUgqgiKvCl2G3LXYcyT8cCpif+EQKCl8+TcQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=axiado.com header.i=@axiado.com header.a=rsa-sha256
 header.s=selector1 header.b=jeQdcyKw
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none)
 header.from=axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=smtong@axiado.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=axiado.com header.i=@axiado.com header.b="jeQdcyKw"; 
 dkim-atps=neutral
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

This series adds eMMC support for the Axiado SCM3005 board, based on the
AX3005 SoC, which uses an Arasan SDHCI controller paired with a dedicated
eMMC PHY.

The series is split as follows:

  - Patch 1 adds the eMMC PHY driver (PHY_AXIADO_EMMC). The PHY provides
    signal conditioning and DLL functionality required for high-speed
    operation with data rates beyond 52MHz, and is based on the Arasan
    PHY.

  - Patch 2 adds the SDHCI host controller driver (MMC_SDHCI_AXIADO) for
    the Arasan controller. It builds on the generic SDHCI framework and
    adds SoC-specific signal voltage switching, HS200 tuning and eMMC PHY
    power sequencing through the generic PHY API.

  - Patch 3 adds the device tree nodes for the SDHCI controller, the eMMC
    PHY and their supporting fixed clock (clk_xin) to
    ax3005.dtsi, and enables the SDHCI node in ax3005-scm3005.dts.

  - Patch 4 enables the new drivers in ax3005_scm3005_defconfig, stores
    the environment in MMC and bumps CONFIG_SYS_MALLOC_LEN to 0x400000 to
    accommodate MMC operations.

Tested on the Axiado SCM3005 board: the eMMC is detected and enumerated,
and read/write access through the MMC subsystem works, including
high-speed modes exercised by the PHY tuning path.

Signed-off-by: Siu Ming Tong <smtong@axiado.com>
---
Siu Ming Tong (4):
      phy: Add Axiado eMMC PHY driver
      mmc: Add Axiado SDHCI driver
      arm: dts: ax3005: Add SDHCI, eMMC PHY and clock node
      configs: ax3005_scm3005: Enable eMMC support

 MAINTAINERS                      |   2 +
 arch/arm/dts/ax3005-scm3005.dts  |   4 +
 arch/arm/dts/ax3005.dtsi         |  25 ++++
 configs/ax3005_scm3005_defconfig |  10 +-
 drivers/mmc/Kconfig              |   7 +
 drivers/mmc/Makefile             |   1 +
 drivers/mmc/axiado_sdhci.c       | 311 +++++++++++++++++++++++++++++++++++++++
 drivers/phy/Kconfig              |   9 ++
 drivers/phy/Makefile             |   1 +
 drivers/phy/phy-axiado-emmc.c    | 208 ++++++++++++++++++++++++++
 10 files changed, 576 insertions(+), 2 deletions(-)
---
base-commit: 02f8b8ab6d6095dccf867d899099322f7430d20d
change-id: 20260727-dev-scm3005-d62c69354074

Best regards,
--  
Siu Ming Tong <smtong@axiado.com>

