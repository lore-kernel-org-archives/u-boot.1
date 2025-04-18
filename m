Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A4CC369C9
	for <u-boot@archiver.kernel.org>; Fri, 18 Apr 2025 19:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7886883212;
	Fri, 18 Apr 2025 21:40:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="Vjbwui1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 279068329F; Fri, 18 Apr 2025 21:40:09 +0200 (CEST)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D3F832B3
 for <u-boot@lists.denx.de>; Fri, 18 Apr 2025 21:40:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJdu4V1007477
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Apr 2025 14:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745005196;
 bh=2nvG4+lX8D3yOVDTBm+Q5BcEHOk8mqCDZz1RVRwlQf0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Vjbwui1qMI0yieAQXi7b8R/Db3tnen/h7lbVw4OkJ8nVbf18YYsW51ThjZlYkHVdE
 BW/SLNKSEF8Udkgnn8w+85LX+xPi1f/xlhlUxI1w4nTYuGEaUQUdMAyy/9pyFMn0/+
 PGvkSlWVpCGpXiliX14wtu3Quicu+UW9JxU52WCU=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53IJduBq003015
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 18 Apr 2025 14:39:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 18
 Apr 2025 14:39:56 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 18 Apr 2025 14:39:55 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53IJdtMA027813;
 Fri, 18 Apr 2025 14:39:55 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH V2 3/9] beagle: beagley-ai: env: Set up the boot devices and
 boot methods
Date: Fri, 18 Apr 2025 14:39:37 -0500
Message-ID: <20250418193943.953952-4-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250418193943.953952-1-nm@ti.com>
References: <20250418193943.953952-1-nm@ti.com>
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

We just have a single MMC on BeagleY-AI. So drop all other boot options,

In the meanwhile, we also will use efiboot and standard boot methods
consistent with other K3 Beagle products.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v1:
- None

V1: https://lore.kernel.org/r/20250411225717.3117370-4-nm@ti.com

 board/beagle/beagley-ai/beagley-ai.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
index 10d62034e1af..db29d13420aa 100644
--- a/board/beagle/beagley-ai/beagley-ai.env
+++ b/board/beagle/beagley-ai/beagley-ai.env
@@ -11,7 +11,8 @@ args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
 
-boot_targets=mmc1 mmc0 pxe dhcp
+boot_targets=mmc1
+bootmeths=script extlinux efi pxe
 boot=mmc
 mmcdev=1
 bootpart=1:2
-- 
2.47.0

