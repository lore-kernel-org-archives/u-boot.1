Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6636C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 12:56:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D0ED809D0;
	Wed, 12 Feb 2025 13:56:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="U8GzsH2W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3FDDF80C5A; Wed, 12 Feb 2025 10:18:31 +0100 (CET)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77078807C0
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 10:18:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=m-shah@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IOii409521
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Feb 2025 03:18:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1739351904;
 bh=Zc7lpqhTZmDj03fDgQK39/MJ38GkFk1Ll3FsMzAiowc=;
 h=From:To:CC:Subject:Date;
 b=U8GzsH2W1L537GnSfCfS6fLLldufH+Q6MX43Rapu51EBINK4jAp05gdevxliifiqN
 9P8NvjYXaMGogZidPNOXrsxuoF+HAPh1LEB7gHvQwacqZxhbDm2Urmv1Yms/pS5Cs1
 Q1NKR2xXOWG2sF4xN1m+kNby87h5YLxZfkVtFk8Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 51C9IOFh003429
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 12 Feb 2025 03:18:24 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Feb 2025 03:18:24 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Feb 2025 03:18:24 -0600
Received: from moteen-ubuntu-desk.dhcp.ti.com (moteen-ubuntu-desk.dhcp.ti.com
 [172.24.227.18])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 51C9ILKQ067685;
 Wed, 12 Feb 2025 03:18:21 -0600
From: Moteen Shah <m-shah@ti.com>
To: <u-boot@lists.denx.de>
CC: <trini@konsulko.com>, <sjg@chromium.org>, <m-chawdhry@ti.com>,
 <n-francis@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <a-chavda@ti.com>, <m-shah@ti.com>
Subject: [RFC PATCH 0/2 v1] Propagate bootph* property to all parent nodes
Date: Wed, 12 Feb 2025 14:48:18 +0530
Message-ID: <20250212091820.213895-1-m-shah@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Mailman-Approved-At: Wed, 12 Feb 2025 13:56:52 +0100
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

In the U-Boot pre-relocation stage, if the parent node lacks bootph*
property and the driver lacks a pre-reloc flag, all of its subsequent
subnodes gets skipped over from driver binding—even if they have a
bootph* property.

This series addresses the issue by scanning through all the subnodes
of the current node for the bootph* property and propagate it to all
of its supernodes, ensuring that all of the applicable drivers are
bound and probed prior to relocation. This series implements one of
the solutions mentioned in [0].

Since, all the nodes which are not having any bootph* property will
also be traversed, we will have to incur some overheads in boot time,
hence protecting the feature under a config.

Boot time overheads:
    Baseline: Upstream u-boot

    Patch test: Baseline + remove all bootph-all properties from
    *-u-boot.dtsi except the ones which are supposed to be probed
    but have no bootph in any of its subnode.

    J7200 delta from baseline  : ~100ms
    J784S4 delta from baseline : ~350ms

Boot logs with the patch:
https://gist.github.com/Jamm02/d6e76233437525b266ec96f8a7982096

References: 
[0] https://lore.kernel.org/u-boot/CAFLszTiEZYoo+=+MJg7sgN93k144zEi18A5_Hk+J3sce00g+=w@mail.gmail.com/

Moteen Shah (2):
  arch: arm: Kconfig: Add config to use subnode's bootph property for
    binding drivers
  drivers: core: lists.c: Bind drivers using bootph* property in
    subnodes

 arch/arm/Kconfig     | 11 ++++++
 drivers/core/lists.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 97 insertions(+), 2 deletions(-)

-- 
2.34.1

