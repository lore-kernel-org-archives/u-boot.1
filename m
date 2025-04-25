Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD49C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:32:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 996DC82A4B;
	Fri, 25 Apr 2025 19:31:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="GONq+q4J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB31D8296B; Fri, 25 Apr 2025 19:31:34 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB474829EF
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:31:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVNL52994450
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 12:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1745602283;
 bh=h1ifZKZkZXiT5LhQ4gOB/+Zuf7NUr8Iyc0AJlu+HOMM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GONq+q4JppiUDMPr0kqPnRknJ0KmOq2bLdfZuIKk/faNkvSfcCTXf77rHhkIYyVZO
 f/eaPRm0Vmwdp2DCCM+ifRs4TctxCCWSstrGDfZRV267Gifr9QEOhww8ehDFGSXHX8
 RPoQ8e/b6t5YSVZW0T+amlCtuTIFN7EAg2tFoodc=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 53PHVNKc007627
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Apr 2025 12:31:23 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 25
 Apr 2025 12:31:23 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 25 Apr 2025 12:31:23 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 53PHVNhM120215;
 Fri, 25 Apr 2025 12:31:23 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Neha Malcom Francis <n-francis@ti.com>, Robert Nelson
 <robertcnelson@gmail.com>
CC: Beleswar Padhi <b-padhi@ti.com>, Udit Kumar <u-kumar1@ti.com>, Jonathan
 Humphreys <j-humphreys@ti.com>, Andrew Davis <afd@ti.com>,
 <u-boot@lists.denx.de>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 4/9] beagle: beagley-ai: env: Setup scripts for LED control
Date: Fri, 25 Apr 2025 12:31:14 -0500
Message-ID: <20250425173120.141503-5-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250425173120.141503-1-nm@ti.com>
References: <20250425173120.141503-1-nm@ti.com>
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

Most of the users of BeagleY-AI are headless OR do not use serial port.
In such cases, it is very useful for the device to provide some level of
indication to know what state their board is at.

Unfortunately, with a single LED (ignoring the :heartbeat), the
options are limited. This is a precursor patch to actually enabling
the LED options that will use the same in the follow on patches.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
Changes Since v2:
- None

V2: https://lore.kernel.org/r/20250418193943.953952-5-nm@ti.com

 board/beagle/beagley-ai/beagley-ai.env | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/beagle/beagley-ai/beagley-ai.env b/board/beagle/beagley-ai/beagley-ai.env
index db29d13420aa..16a03acfca3c 100644
--- a/board/beagle/beagley-ai/beagley-ai.env
+++ b/board/beagle/beagley-ai/beagley-ai.env
@@ -10,6 +10,8 @@ console=ttyS2,115200n8
 args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
 	${mtdparts}
 run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+set_led_state_fail_load=led led-0 off
+set_led_state_start_load=led led-0 on
 
 boot_targets=mmc1
 bootmeths=script extlinux efi pxe
-- 
2.47.0

