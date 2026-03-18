Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5C0103E17A
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 14:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419388405B;
	Wed, 18 Mar 2026 15:30:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lisXM7MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E545383CE3; Wed, 18 Mar 2026 15:30:05 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CE2E838FA
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 15:30:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 646C4600C4;
 Wed, 18 Mar 2026 14:30:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB12C2BC87;
 Wed, 18 Mar 2026 14:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773844202;
 bh=7LCOA8VAUnwQskZVKrNM/eYjXkBLHRKvoI9s68R0MvI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=lisXM7MBEJIcpfDRNrJROmOkBld7wxDDbwv0pB1MpYPajqGFz/MpidVGpMXRMXHfz
 /o5GNT7ZTQJ5bgc/9/3uqQu5LDL4uN5CyA3PquJc+QB2L/7A7B42GlE+V6mYoA8QYT
 DVaHRhk5NCcBFGmafRmGs2w6LMh0NpRlROz7vsLyXwd+IJW1t6KQOQYecyZrtRFIfc
 EhL8TcVbden2G167aqCVYBOhjw5vYqlqKvD2bjyMSI6+yBYYSdz+HCTOpZCxszhPCU
 0/kSL11ikbrjO4HAz6DhqFT4TcXHhZkMmlix/KjTF1VCPNPmoOutJmwCplU9FKYlC0
 qiekjPM4AFtlQ==
From: Michael Walle <mwalle@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>, Tom Rini <trini@konsulko.com>,
 Ashish Kumar <Ashish.kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Kuldeep Singh <kuldeep.singh@nxp.com>
Cc: u-boot@lists.denx.de,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/3] configs: ls1021atsn: enable serial driver
Date: Wed, 18 Mar 2026 15:29:16 +0100
Message-ID: <20260318142949.2479033-3-mwalle@kernel.org>
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

Switching to DM_SERIAL disabled any serial driver. Re-enable it again.

Fixes: 191b10ac70d7 ("PowerPC / Layerscape: Finish migration to DM_SERIAL")
Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 configs/ls1021atsn_qspi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/ls1021atsn_qspi_defconfig b/configs/ls1021atsn_qspi_defconfig
index e36d336d84b..37629d88c48 100644
--- a/configs/ls1021atsn_qspi_defconfig
+++ b/configs/ls1021atsn_qspi_defconfig
@@ -68,6 +68,7 @@ CONFIG_TSEC_ENET=y
 CONFIG_NVME_PCI=y
 CONFIG_PCIE_LAYERSCAPE_RC=y
 CONFIG_DM_SERIAL=y
+CONFIG_SYS_NS16550=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_FSL_DSPI=y
-- 
2.47.3

