Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B961067036
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 14:32:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8000984262;
	Thu, 12 Mar 2026 15:31:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="ItlX9+nW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 266C68423D; Thu, 12 Mar 2026 15:31:38 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59F2E84261
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 15:31:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=B26nPfK6Qu06BzqPPfv9a+U6JyikkXkvvmgGl/SsCmg=; b=ItlX9+nWTn3zoDWXA3q4RDHQhM
 B69VSfPVdj1E2LoLsX8dIoxOFdbL03p86EshmaeFgV7W5gWRm8NINQ4YDSj17yzFer4r95hpICOZs
 yqiJln/LofhtRw9OB8Vkmai4abpD4UxLradnNWVAm6qAy9P6S2oQkgThDF06jNFW6dsVe8yF34I/p
 1AlIqPz+mGqHCRG4vwPluMZpVyC7Rrd383kf0HjzIIBFLL7ILtX/hqvJF9C6wmpHAaZ+ldkBHIIq/
 UpIJ5JTsGTm1huKpyuQcgFzWY1TgWfDA45R9wrSBSqSLVnRNdx0TLyy7XRZ1FP4m9lpDKI4N7c4tU
 7eiOBSrQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4T-000FKj-2d; Thu, 12 Mar 2026 15:31:29 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy03.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1w0h4T-0003V8-1F; Thu, 12 Mar 2026 15:31:29 +0100
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH 1/8] Kconfig: update build-target for MX7 with SPL
Date: Thu, 12 Mar 2026 15:31:11 +0100
Message-Id: <20260312143118.1677859-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
References: <20260312143118.1677859-1-Alexander.Feilke@ew.tq-group.com>
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

From: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Prepare for MX7-based module with SPL support

Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index a50b4c8c68a..0b745e9349a 100644
--- a/Kconfig
+++ b/Kconfig
@@ -522,7 +522,7 @@ config BUILD_TARGET
 	default "u-boot-elf.srec" if RCAR_64
 	default "u-boot-with-spl.bin" if ARCH_AT91 && SPL_NAND_SUPPORT
 	default "u-boot-with-spl.bin" if MPC85xx && !E500MC && !E5500 && !E6500 && SPL
-	default "u-boot-with-spl.imx" if ARCH_MX6 && SPL
+	default "u-boot-with-spl.imx" if (ARCH_MX6 || ARCH_MX7) && SPL
 	default "u-boot-with-spl.kwb" if ARMADA_32BIT && SPL
 	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_ARRIA10
 	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
-- 
2.34.1

