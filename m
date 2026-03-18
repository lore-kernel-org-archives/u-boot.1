Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C5E103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABE9E84101;
	Wed, 18 Mar 2026 15:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="u7sWE1Ma";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 237EA83F00; Wed, 18 Mar 2026 15:30:08 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F2F083E4C
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:30:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1562E40231;
 Wed, 18 Mar 2026 14:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AEBC2BC87;
 Wed, 18 Mar 2026 14:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773844204;
 bh=vbWkSze/rPD21kBAdWJNQbtyx2uXClU3tPzXJLtxRaA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u7sWE1MayLzt3sNjAKtDSa4zfzY44kyhV+ucyBKPW+2/g75KJzRUIkSv7sNkDM+y9
 RxB/JllGeYJn3RoVQaAbIMidBFBsZmpZW0Daatif148WLmsyrOAF+GIWY/c84d26Oc
 /Is+nVJeKWZSCrHkhfNlbrSZRHiTklq69O3JxIp6CRcBx8Gxuevb4JuJcFpLhEZ+vY
 x69Yc0SToR0wSOfRiydQooWZzXad/hyH6nYesariOsjuqFCDid5/5L+mIVsfF2I2g/
 po9sd8Xr9rh5WocWG3C2g8UVZ//R+vQ/2jfgEvaI56s7NjQQJYCRiMey0m1XjHrpBU
 OU8YgfRSWWl2Q==
From: Michael Walle <mwalle@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 3/3] armv7: ls102xa: fix SPI flash clock
Date: Wed, 18 Mar 2026 15:29:17 +0100
Message-ID: <20260318142949.2479033-4-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260318142949.2479033-1-mwalle@kernel.org>
References: <20260318142949.2479033-1-mwalle@kernel.org>
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

Commit bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")
broke the SPI boot on the LS1021ATSN board (ls1021atsn_qspi_defconfig)
at least.

The commit message reads
   Update SCFG_QSPI_CLKSEL value : 0xC -> 0x5
   which means ClusterPLL/16

The original submitted patch had the following description:
   Value 0xC is reserved. Replace it with correct value 0x5 which
   is ClusterPLL/16

Unfortunatly, the little information which was there, was stripped even
further. Why is 0x5 the "correct" value? In fact, it seems that the
upper bit is just ignored and thus the value 0xC translates to 0x4 which
is ClusterPLL/20. This, will result in a SPI clock of 60MHz (if the PLL
is clocked at 1.2GHz). But even that is too much for the (default) 03h
read opcode (max 50MHz). Set the value to ClusterPLL/24 which is 50MHz.

Link: https://lore.kernel.org/r/1568804284-25162-1-git-send-email-kuldeep.singh@nxp.com/
Fixes: bb6f3c0f7634 ("armv7: ls102xa: Update SCFG_QSPI_CLKSEL value")
Signed-off-by: Michael Walle <mwalle@kernel.org>

---
If someone still wants to have a faster clock frequency, because they
are using the fast read opcode or so, I'd suggest to actually implement
the .set_speed op in the driver.
---
 arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h b/arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h
index a0c3da7f46d..51ba8733768 100644
--- a/arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h
+++ b/arch/arm/include/asm/arch-ls102xa/immap_ls102xa.h
@@ -137,7 +137,7 @@ struct ccsr_gur {
 #define SCFG_ETSECCMCR_GE0_CLK125	0x00000000
 #define SCFG_ETSECCMCR_GE1_CLK125	0x08000000
 #define SCFG_PIXCLKCR_PXCKEN		0x80000000
-#define SCFG_QSPI_CLKSEL		0x50100000
+#define SCFG_QSPI_CLKSEL		0x30100000
 #define SCFG_SNPCNFGCR_SEC_RD_WR	0xc0000000
 #define SCFG_SNPCNFGCR_DCU_RD_WR	0x03000000
 #define SCFG_SNPCNFGCR_SATA_RD_WR	0x00c00000
-- 
2.47.3

