Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF85FF8875
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 12:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1FC4784843;
	Wed, 29 Apr 2026 14:18:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C8IUHWUp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4357684858; Wed, 29 Apr 2026 14:18:41 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E972984841
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 14:18:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 7FC154445C;
 Wed, 29 Apr 2026 12:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B14AC19425;
 Wed, 29 Apr 2026 12:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777465117;
 bh=OxWeBK6+omHTBQWsZqNdx29ThafambMb+5RYuMfpqnc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=C8IUHWUps36b7U+MvZqAGjPn+hzZ4TYcuU0j7TK2Zfmbc5/TyX76NeeC9NKfjXY5B
 fJWrAP3Ju1n/e4D6Sf2c7n2L8aTroIIHKkVFJQIn6Rplu7jcjGyGqF5enR6D7mKkct
 Md9/XNrRXZbHHDPxksytQcHkwAwhVSbUu4sJ+v+bSlQgj4koN1nH2YTLIw4V54RwD8
 ym+b74M5V7YKBXDL1cRfuzt76pqaomlAoYEAeIEomfTzf2Zv/wT3CtV5p5PtkIkt/j
 PdztydMxHVxoiqJK86dB7dxn0lvMYy25xbz4XyK9VC5Iej8wkRmzbaBrOxBWjoo+Sj
 n6+pq+XIQbSgQ==
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
Subject: [PATCH 02/10] caam: don't write memory at 0 on PPC
Date: Wed, 29 Apr 2026 14:17:16 +0200
Message-ID: <20260429121816.1026326-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260429121816.1026326-1-mwalle@kernel.org>
References: <20260429121816.1026326-1-mwalle@kernel.org>
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
 arch/powerpc/cpu/mpc85xx/cpu_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init.c b/arch/powerpc/cpu/mpc85xx/cpu_init.c
index 739d14f8002..478ab648948 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init.c
@@ -41,8 +41,8 @@
 #ifdef CONFIG_FSL_CAAM
 #include <fsl_sec.h>
 #endif
-#if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
 #include <asm/fsl_pamu.h>
+#if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
 #include <fsl_secboot_err.h>
 #endif
 #ifdef CONFIG_SYS_QE_FMAN_FW_IN_NAND
@@ -899,6 +899,8 @@ int cpu_init_r(void)
 #if defined(CONFIG_NXP_ESBC) && defined(CONFIG_FSL_CORENET)
 	if (pamu_init() < 0)
 		fsl_secboot_handle_error(ERROR_ESBC_PAMU_INIT);
+#else
+	pamu_init();
 #endif
 
 #ifdef CONFIG_FSL_CAAM
-- 
2.47.3

