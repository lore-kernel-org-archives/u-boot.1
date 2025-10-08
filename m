Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BFC8CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  8 Oct 2025 11:36:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B235583C70;
	Wed,  8 Oct 2025 13:36:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BDbNCQUG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC4DF83A57; Wed,  8 Oct 2025 13:36:15 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E3BA8394A
 for <u-boot@lists.denx.de>; Wed,  8 Oct 2025 13:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 598Ba8lF216091;
 Wed, 8 Oct 2025 06:36:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1759923368;
 bh=CG+V7ayyxDw9cApTZydC4SkWKPfEDtJpPCsqjJlJ/z0=;
 h=From:To:CC:Subject:Date;
 b=BDbNCQUGnkeHZaG5AqvMrsHbOdVcvwln8CqskQeo12SGxRYKcCGAsZh39pth3Adue
 eLm2Hi+uSj9Ra3zqyA9+pMtCudDyObUDMBVChEG+FwP1Vkla5dAD65ZReaqaBG4Xa4
 hH5EDYwS2rwfJVlQnJbKSUO1SUdz/pEhRfnCG1ak=
Received: from DLEE203.ent.ti.com (dlee203.ent.ti.com [157.170.170.78])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 598Ba8u7609599
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 8 Oct 2025 06:36:08 -0500
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE203.ent.ti.com
 (157.170.170.78) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 8 Oct
 2025 06:36:08 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Oct 2025 06:36:08 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 598Ba7fl2471012;
 Wed, 8 Oct 2025 06:36:07 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>, <kever.yang@rock-chips.com>,
 <hl@rock-chips.com>, <tim@feathertop.org>,
 <marek.vasut+renesas@mailbox.org>
Subject: [PATCH v1 0/2] Add support for secure falcon mode: disable args file
Date: Wed, 8 Oct 2025 17:06:02 +0530
Message-ID: <20251008113605.1055826-1-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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


Hi all,

Continuing from the last series[1], this patch series addresses the requirement
to disable the args file in falcon mode.

The args file is used in falcon mode for loading the device-tree for the kernel.
However in secure falcon mode, the expected payload is a FIT containing a
signed device-tree and kernel image. Thus removing the need to load the extra
args file in the first place. Loading the extra file without any authentication
mechanism exposes an attack vector and should therefore be disabled to keep the
boot secure.

This patch set builds on the last few to first optionally allow for loading the
args file in non-secure falcon boot flow [1/2] and then disable them altogether
in the next patch [2/2] for secure falcon mode.

[1]: https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/
Depends on: https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/

Regards,
Anshul
---
Anshul Dalal (2):
  spl: make args file optional in falcon mode
  spl: prevent loading args file in secure falcon mode

 common/spl/Kconfig         | 23 ++++++++++++++++-------
 common/spl/spl_ext.c       |  4 ++++
 common/spl/spl_fat.c       |  5 +++++
 common/spl/spl_nand.c      |  4 +++-
 common/spl/spl_nor.c       |  2 +-
 common/spl/spl_spi.c       |  5 +++++
 common/spl/spl_ubi.c       |  4 ++++
 include/system-constants.h |  2 +-
 8 files changed, 39 insertions(+), 10 deletions(-)

-- 
2.51.0

