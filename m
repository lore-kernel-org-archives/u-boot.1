Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9489AC61D97
	for <u-boot@archiver.kernel.org>; Thu, 23 Nov 2023 17:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3FC68765E;
	Thu, 23 Nov 2023 18:22:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="SgJ61KtL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2BF886BDB; Thu, 23 Nov 2023 18:22:21 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EDC587620
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 18:22:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHMGIB006575;
 Thu, 23 Nov 2023 11:22:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1700760136;
 bh=0FcT+CcpQdok09y75hHFiZenRVQDoJac/K+4a6M4RuA=;
 h=From:To:CC:Subject:Date;
 b=SgJ61KtL3abTnnDceb5BP2AnTLwQRvHGFFLfaEbT/RSnIwNVIMv4AFpLcaxCcWc8i
 IO7FJkimsRoPpgFS5OVZtWTaSM7qixi7jPzQe71uXb66S6Fw/vYs8glLlzPPVHt2Ue
 WA4i7EIx5Z11fVUrOiDVuejFvU9EtOty3E4G1bA4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ANHMGAn129381
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Nov 2023 11:22:16 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 23
 Nov 2023 11:22:16 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 23 Nov 2023 11:22:16 -0600
Received: from lelv0326.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ANHMFvW114031;
 Thu, 23 Nov 2023 11:22:15 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH 0/3] Unify K3 initial memory map
Date: Thu, 23 Nov 2023 11:22:11 -0600
Message-ID: <20231123172214.653268-1-afd@ti.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Hello all,

This was an RFC as it might still break remoteproc loading, but
posted now for merge as worst case this would expose the issue
in remoteproc loading better and force someone to go fix it. :)

Changes for non-RFC:
 - Included dependency patch from here[0] into this series
 - Add Tested-bys
 - Rebase on latest -next

Thanks,
Andrew

[0] https://lore.kernel.org/all/20231122211218.607757-1-afd@ti.com/

Andrew Davis (3):
  arm: mach-k3: Let the compiler size the mem_map lists
  arm: mach-k3: Remove non-cached memory map areas
  arm: mach-k3: Merge initial memory maps

 arch/arm/mach-k3/arm64-mmu.c | 275 +----------------------------------
 1 file changed, 2 insertions(+), 273 deletions(-)

-- 
2.39.2

