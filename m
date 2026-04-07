Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E56B7FEEF2E
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:08:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B3BB84198;
	Tue,  7 Apr 2026 15:07:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="cTWu086I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7AFF83A41; Tue,  7 Apr 2026 15:07:30 +0200 (CEST)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A56D48413A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:07:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Alexander.Feilke@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=t1Vt6aVsvc3SzwWskBtCbVCIa1+8n3ewaGNAFhUSmsU=; b=cTWu086ItZ5p7qgZn53cjGxbk4
 4n0BKT4bybeZ3a+6YXsNbCNPMhs5uvnbBugUzJptFUb4BiIeWRWlDmAxPe1TIBXfwjzJhC8th0X6i
 JwkEcQCbU1oXAudZ/vLhPGXmwwq/bQV4ScT4Hh+nodFylwS5ePqn/UmZgYamN+zqqL2MNGYTT1XSn
 iIj1GjCtgpIB3PYPV0x3Xo+rBXUM/6p5FWUL0W/419BmsJ1SJrmXsuSVh1oDACV0DL0NOTABvEB2O
 STn9XvNwv4pyCVrEdu4akVsWsNAZieReNENc6655Y3vAJr+ItRRLRvTlvu/Hgt61JSau8yuG1zR4b
 TMaX3v4A==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wA69I-00071v-2n; Tue, 07 Apr 2026 15:07:20 +0200
Received: from localhost ([127.0.0.1])
 by sslproxy02.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Alexander.Feilke@ew.tq-group.com>)
 id 1wA69I-0007St-0a; Tue, 07 Apr 2026 15:07:20 +0200
From: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com
Cc: Alexander Feilke <alexander.feilke@ew.tq-group.com>,
 Tom Rini <trini@konsulko.com>,
 Alexander Feilke <Alexander.Feilke@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH v4 1/8] Kconfig: update build-target for MX7 with SPL
Date: Tue,  7 Apr 2026 15:06:44 +0200
Message-ID: <20260407130654.778838-2-Alexander.Feilke@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
References: <20260407130654.778838-1-Alexander.Feilke@ew.tq-group.com>
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

Prepare for MX7-based module with SPL support.

Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index 7f00e76ba78..6d427152f42 100644
--- a/Kconfig
+++ b/Kconfig
@@ -539,7 +539,7 @@ config BUILD_TARGET
 	default "u-boot-elf.srec" if RCAR_64
 	default "u-boot-with-spl.bin" if ARCH_AT91 && SPL_NAND_SUPPORT
 	default "u-boot-with-spl.bin" if MPC85xx && !E500MC && !E5500 && !E6500 && SPL
-	default "u-boot-with-spl.imx" if ARCH_MX6 && SPL
+	default "u-boot-with-spl.imx" if (ARCH_MX6 || ARCH_MX7) && SPL
 	default "u-boot-with-spl.kwb" if ARMADA_32BIT && SPL
 	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_ARRIA10
 	default "u-boot-with-spl.sfp" if ARCH_SOCFPGA_GEN5
-- 
2.43.0

