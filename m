Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E85EA3F09
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 05:44:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77DEC83CEA;
	Tue, 10 Feb 2026 06:43:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="WftvDEUB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A7DA83C67; Tue, 10 Feb 2026 06:43:56 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FF983C67
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 06:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C931811043C; Tue, 10 Feb 2026 06:43:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1770702233; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=dct7PD2Pc2Tgv2vHoGc58gLe6Xehwsvt9cpc/mgKJIw=;
 b=WftvDEUBJrpGTBrB2IYJEFLMCcOvCUcDrqpVuQHgt/T1tnki0cg9nnJMeSFaZFD0uGbFCq
 l/iGWc5qs5el2K3afKcqAN6ivKkZpjJxV8Jz21+WbIRINVvvIwCtiDPzniVhgAZQJhdytQ
 3QaBzlrTqfd+i/sWZzB9qYCEFc12R+HdkFDhta0dHkNiGg18+tHtytg19m5vkjJHzVkir6
 D7VbA0ymqm5ZLRHKqpCYhLtD/Shd0m+/kh7u/1UoTAGYpSHyqPcwiALOkC/hSNhzgX9P4K
 6d5U56v//TvS5LbxPJmnYL5gk6ZdpZQB8auqqGXTPnjKcmhPqgOwPsbcDOAOog==
From: Heiko Schocher <hs@nabladev.com>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>,
 Heiko Schocher <hs@nabladev.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/2] arch: imx8qxp: Override weak fb_mmc_get_boot_offset
 function
Date: Tue, 10 Feb 2026 06:43:45 +0100
Message-Id: <20260210054345.126651-3-hs@nabladev.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260210054345.126651-1-hs@nabladev.com>
References: <20260210054345.126651-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

From: Adrian Freihofer <adrian.freihofer@siemens.com>

Add IMX8QXP SoCs specific implementation of fb_mmc_get_boot_offset()

This is needed as bootloader offset is different dependent on SoC
revision!

For revision B0 the bootloader starts at 32k offset. On offset
0x0 the bootloaders environment is stored.

On C0 revisions of the SoC bootloader image starts at offset 0x0

Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
Signed-off-by: Heiko Schocher <hs@nabladev.com>
Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

---

Changes in v2:
- added Reviewed-by from Mattijs

 arch/arm/mach-imx/imx8/cpu.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-imx/imx8/cpu.c b/arch/arm/mach-imx/imx8/cpu.c
index 0e112af661c..27c431881b0 100644
--- a/arch/arm/mach-imx/imx8/cpu.c
+++ b/arch/arm/mach-imx/imx8/cpu.c
@@ -899,3 +899,24 @@ bool m4_parts_booted(void)
 
 	return false;
 }
+
+#ifdef CONFIG_IMX8QXP
+#include <blk.h>
+
+/*
+ * On B0 revision SoCs the bootloader is on 32k offset
+ * and at offset 0x0 is the U-Boot Environment stored
+ *
+ * So we cannot flash bootloader images to offset 0x0
+ *
+ * On C0 revisions of the SoC bootloader image starts
+ * at offset 0x0 ...
+ */
+lbaint_t fb_mmc_get_boot_offset(void)
+{
+	if ((get_cpu_rev() & 0xF) == CHIP_REV_C)
+		return 0;
+
+	return 0x40;
+}
+#endif
-- 
2.20.1

