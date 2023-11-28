Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0808FC4167B
	for <u-boot@archiver.kernel.org>; Tue, 28 Nov 2023 17:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DB9E8776F;
	Tue, 28 Nov 2023 18:05:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="UQwjjLca";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 984728776F; Tue, 28 Nov 2023 18:05:36 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0079C86314
 for <u-boot@lists.denx.de>; Tue, 28 Nov 2023 18:05:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=afd@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5U89003029;
 Tue, 28 Nov 2023 11:05:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1701191130;
 bh=KRjXyMVl9kUsbiKgGOY2LWn8tY4lTreSpP/Yibk9rQI=;
 h=From:To:CC:Subject:Date;
 b=UQwjjLcadVeLpdMHbA3hHMqC0Mn4/d/TfSrgNrL7aZb7cMMuf7NF50/cZSG3/PXsK
 ZbrEj4jVq11I98nBQvUJScixathucFDr1TF5FsIwxKEQScVgMdMrvJnxgEIvr5jSFl
 a9fLkLWMg+Igk6bmhJUq0n1Vg8tSlnwwmSVuh3wY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3ASH5UgI052409
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Tue, 28 Nov 2023 11:05:30 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Nov 2023 11:05:30 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Nov 2023 11:05:30 -0600
Received: from lelv0327.itg.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3ASH5Tqc028109;
 Tue, 28 Nov 2023 11:05:29 -0600
From: Andrew Davis <afd@ti.com>
To: Neha Malcom Francis <n-francis@ti.com>, Vignesh Raghavendra
 <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Apurva Nandan
 <a-nandan@ti.com>
CC: <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 0/4] Unify K3 initial memory map
Date: Tue, 28 Nov 2023 11:05:24 -0600
Message-ID: <20231128170528.407707-1-afd@ti.com>
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

Changes for v2:
 - Add patch adding firewall MMU hole for Jacinto devices

Changes for non-RFC:
 - Included dependency patch from here[0] into this series
 - Add Tested-bys
 - Rebase on latest -next

Thanks,
Andrew

[0] https://lore.kernel.org/all/20231122211218.607757-1-afd@ti.com/

Andrew Davis (4):
  arm: mach-k3: Let the compiler size the mem_map lists
  arm: mach-k3: Do not map ATF and OPTEE regions in MMU
  arm: mach-k3: Remove non-cached memory map areas
  arm: mach-k3: Merge initial memory maps

 arch/arm/mach-k3/arm64-mmu.c | 271 +----------------------------------
 1 file changed, 3 insertions(+), 268 deletions(-)

-- 
2.39.2

