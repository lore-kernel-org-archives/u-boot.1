Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D79CCD18E
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 10:47:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0600832BC;
	Wed, 15 Oct 2025 12:47:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="vaTLRBfG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9330832BC; Wed, 15 Oct 2025 12:47:10 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1329980107
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 12:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59FAl5M41824273;
 Wed, 15 Oct 2025 05:47:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760525225;
 bh=M4LdAKiSDWQAPc4crZdxSkryL1nMSJPCts3OseFZ5wM=;
 h=From:To:CC:Subject:Date;
 b=vaTLRBfGC8BPkZpHAXIKO6nI1SOwcMOvkHVoMNWRq/miUE12rJTFB4FIhKsgN8VSp
 lwnp9ukzgwGVoIgKh3+Rw2n2YhwLtGeMMSzFTMO+HEqGY+vx2JQ6Lx4zIVPFH/vIqV
 7m1h4huR1nvLd/xyxczm45vnVvQsyAVpDMjKt/Pw=
Received: from DFLE211.ent.ti.com (dfle211.ent.ti.com [10.64.6.69])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59FAl5Vh1166476
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 15 Oct 2025 05:47:05 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Oct
 2025 05:47:05 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 15 Oct 2025 05:47:05 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59FAl4fx1780824;
 Wed, 15 Oct 2025 05:47:04 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH v2 0/5] Allow falcon boot from A-core SPL on K3 devices
Date: Wed, 15 Oct 2025 16:16:42 +0530
Message-ID: <20251015104702.3726411-1-anshuld@ti.com>
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

With the addition of secure falcon mode from my last few series[1], this series
now adds support for the same to TI's K3 devices and documents the feature
taking AM62x EVM as an example.

The patch [5/5] (doc: develop: falcon: document unsetting CMD_BOOTx) of the
series is a workaround for now since we first need to refactor out the usage of
CMD_BOOTI/CMD_BOOTZ options from the SPL boot flow[2].

I will be working on a respin of my older series[3] addressing the same but for
now the workaround of disabling respective CMD_BOOTx option works well enough.
With that in place we should be able to revert the patch [5/5].

Regards,
Anshul

[1]: Patch series adding secure falcon mode support (in order of dependency):
  https://lore.kernel.org/u-boot/20250923124639.667718-1-anshuld@ti.com/ [MERGED]
  https://lore.kernel.org/u-boot/20251006101057.4172248-1-anshuld@ti.com/
  https://lore.kernel.org/u-boot/20251009115846.897186-1-anshuld@ti.com/
[2]: https://lore.kernel.org/u-boot/20250310135544.GV2640854@bill-the-cat/
[3]: https://lore.kernel.org/u-boot/20250408141436.712387-1-anshuld@ti.com/
---
Changes in v2:
 - Use CMD_SPL instead of CMD_CACHE in commit message of [2/5]
 - Use #ifdef instead of CONFIG_IS_ENABLED(OS_BOOT)

v1: https://lore.kernel.org/u-boot/20251010131829.3737258-1-anshuld@ti.com/
---

Anshul Dalal (5):
  spl: Kconfig: allow falcon mode for TI secure devices
  board: ti: common: Kconfig: add CMD_SPL
  arm: mach-k3: enable support for falcon mode
  doc: develop: add docs for secure falcon mode
  doc: develop: falcon: document unsetting CMD_BOOTx

 arch/arm/mach-k3/common.c |   8 ++
 board/ti/common/Kconfig   |   1 +
 common/spl/Kconfig        |   2 +-
 doc/develop/falcon.rst    | 256 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 266 insertions(+), 1 deletion(-)

-- 
2.51.0

