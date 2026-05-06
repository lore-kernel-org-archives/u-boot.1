Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01053CD342C
	for <u-boot@archiver.kernel.org>; Wed,  6 May 2026 12:36:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1181848E3;
	Wed,  6 May 2026 14:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="blu3vcnn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1534848D8; Wed,  6 May 2026 14:36:10 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27C48484F
 for <u-boot@lists.denx.de>; Wed,  6 May 2026 14:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id BAF1F40ABA;
 Wed,  6 May 2026 12:36:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6308C2BCB8;
 Wed,  6 May 2026 12:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778070966;
 bh=n5wkEu9MLvI8w8T5KG0eGItYgvumdAMQOfxuU4BAhOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=blu3vcnn/ak740MKvfaCMVBUWTm2RsuWyO56Yv+e3l7WKC6/VRuHbfD9hcRObwB4o
 I6pFSk0SFlxe0GPKvUJ83Pb/0TUMb6h/wwiE45AER9G2Qr4W1ED7rQwvNKo2HwxI8Q
 ThvZL49z+1GMFHBr//GlUrR+ZzR1RQIUjnnGhjYPzFfD11p8xiIpRDkrtRAPHAVujs
 rLzX2NeIYbWWYADrolCmaKijtYykneIRIEMYRic4/lWL0WDfa9egh99X5kHK9P2Cew
 oa3Ebq0XLWbZLKCDoNEmNOs4/PjO5/oml3/6kFqLaqxipLr56UDPdgEPlQpsaCr3NO
 wr5Tl0SpRlP8Q==
From: Michael Walle <mwalle@kernel.org>
To: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
 Tom Rini <trini@konsulko.com>, Pramod Kumar <pramod.kumar_1@nxp.com>,
 Vladimir Oltean <olteanv@gmail.com>, Alison Wang <alison.wang@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Priyanka Jain <priyanka.jain@nxp.com>, Wasim Khan <wasim.khan@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 TsiChung Liew <Tsi-Chung.Liew@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Shengzhou Liu <Shengzhou.Liu@nxp.com>
Cc: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>,
 Jerome Forissier <jerome.forissier@arm.com>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH v2 02/11] caam: don't write memory at 0 on PPC
Date: Wed,  6 May 2026 14:34:11 +0200
Message-ID: <20260506123507.2081751-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260506123507.2081751-1-mwalle@kernel.org>
References: <20260506123507.2081751-1-mwalle@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For non-secure boot environments pamu_init() isn't called but the CAAM
will still call sec_config_pamu_table() -> config_pamu() which then uses
an uninitialized ppaact variable. In fact, that variable is initialized
with 0, so the config_pamu() will happily assume the structure is there
and will operate on that memory. Call pamu_init() in the non-secure boot
case, too.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 arch/powerpc/cpu/mpc85xx/cpu_init.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 739d14f8002..414782c835f 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -41,10 +41,12 @@
 #ifdef CONFIG_FSL_CAAM
 #include <fsl_sec.h>
 #endif
-#if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
+#if defined(CONFIG_FSL_CORENET)
 #include <asm/fsl_pamu.h>
+#if defined(CONFIG_NXP_ESBC)
 #include <fsl_secboot_err.h>
 #endif
+#endif
 #ifdef CONFIG_SYS_QE_FMAN_FW_IN_NAND
 #include <nand.h>
 #include <errno.h>
@@ -899,6 +901,8 @@ int cpu_init_r(void)
 #if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
 	if (pamu_init() < 0)
 		fsl_secboot_handle_error(ERROR_ESBC_PAMU_INIT);
+#elif defined(CONFIG_FSL_CORENET)
+	pamu_init();
 #endif
 
 #ifdef CONFIG_FSL_CAAM
-- 
2.47.3

