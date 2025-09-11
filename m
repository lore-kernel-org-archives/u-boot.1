Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E127CAC58E
	for <u-boot@archiver.kernel.org>; Thu, 11 Sep 2025 13:17:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 566AD833F1;
	Thu, 11 Sep 2025 15:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="hxdep8Yv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D988833C0; Thu, 11 Sep 2025 15:14:56 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36E84835D8
 for <u-boot@lists.denx.de>; Thu, 11 Sep 2025 15:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58BDEqsq297121;
 Thu, 11 Sep 2025 08:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757596492;
 bh=/AST6HSymsA4mtX2qT7CW7w4DRgTObiD2AVUNWIL6Fo=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=hxdep8Yvnx850Z/LvuzPt/RmHWs8jgyXNy6yfWc0gL8mXl8IijooyRgSbZQLW7UfT
 qLQuSyyZF09aoMGi5zg1glsVO8VlpG5QWIfePp6c7K7uHjtfFHmAw4rZhKO/AeJ915
 Vq3+HanxEdiqbofgEzhqhhoSig3kzJcOi19RwY50=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58BDEqmt515851
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 11 Sep 2025 08:14:52 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 11
 Sep 2025 08:14:51 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 11 Sep 2025 08:14:51 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58BDEopl2169102;
 Thu, 11 Sep 2025 08:14:51 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <vigneshr@ti.com>, <trini@konsulko.com>,
 <afd@ti.com>, <m-chawdhry@ti.com>, <n-francis@ti.com>, <b-liu@ti.com>,
 <nm@ti.com>, <bb@ti.com>
Subject: [PATCH RFT v1 17/17] arm: spl: use fdt addr if arg is unset in falcon
 mode
Date: Thu, 11 Sep 2025 18:44:13 +0530
Message-ID: <20250911131414.3296697-18-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911131414.3296697-1-anshuld@ti.com>
References: <20250911131414.3296697-1-anshuld@ti.com>
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

spl_image->arg is passed to the kernel as an argument in the x0
register. However in cases when the kernel is loaded from a FIT
container along with a DT, the arg remains unset which leads to boot
failure.

Therefore, this patch sets the arg to fdt address if it's null.

Signed-off-by: Anshul Dalal <anshuld@ti.com>
---
 arch/arm/lib/spl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index c43a63f1819..2e7613a6f2e 100644
--- a/arch/arm/lib/spl.c
+++ b/arch/arm/lib/spl.c
@@ -53,6 +53,8 @@ void __weak board_init_f(ulong dummy)
 #ifdef CONFIG_ARM64
 void __noreturn jump_to_image_linux(struct spl_image_info *spl_image)
 {
+	if (!spl_image->arg)
+		spl_image->arg = spl_image_fdt_addr(spl_image);
 	debug("Entering kernel arg pointer: 0x%p\n", spl_image->arg);
 	cleanup_before_linux();
 	armv8_switch_to_el2((u64)spl_image->arg, 0, 0, 0,
-- 
2.51.0

