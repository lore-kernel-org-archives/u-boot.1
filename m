Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD542C25B10
	for <u-boot@archiver.kernel.org>; Mon, 13 May 2024 20:57:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DEB3887D46;
	Mon, 13 May 2024 22:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iTLPWdrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AACA8829E; Mon, 13 May 2024 22:56:45 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5F6488280
 for <u-boot@lists.denx.de>; Mon, 13 May 2024 22:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mwalle@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 7546D60F82;
 Mon, 13 May 2024 20:56:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6803C2BD11;
 Mon, 13 May 2024 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715633802;
 bh=k64/xBc/spU8kAXnkJ4y7tvyRQBRv6l0Mf1xM3dADBI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iTLPWdrVj3oQ7qcLg4ao0gb9wXgR8FkjuZxZaFtdmHVFn688WOKWt6vTMoMWrushP
 CZ8DDApleQdJ12R3jjyltS206UsONH31pe7EHnOzWTdAv3D/5kSTzkjapACCmzOoVc
 CB/mpQXDmkVQ93YXzYqfaGLYJcVmNiMEqDRCzWpjQOXUdQ1uI8pgYMhAdbmk1ML6p1
 l/hSEXtiOjTBKf1STbREbh28qbFtevVnAYtqli6UNdcFA6Wb0HZCtxF7Ws9rop5Em+
 Bd3mYpQ4Otp1hQ5kv+HbXIm7fjHxVSV8Gd7q6US/4YcBj9Zx/eLuJTeGTmpqMvS6eD
 Hu0LKqBVMHM3g==
From: Michael Walle <mwalle@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>
Cc: Samuel Holland <samuel@sholland.org>, u-boot@lists.denx.de,
 Michael Walle <mwalle@kernel.org>
Subject: [PATCH 2/2] net: sun8i_emac: add support for the V3s
Date: Mon, 13 May 2024 22:56:09 +0200
Message-Id: <20240513205609.1872861-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240513205609.1872861-1-mwalle@kernel.org>
References: <20240513205609.1872861-1-mwalle@kernel.org>
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

Add the compatible string for the emac found on the V3s SoC. The SoC
only supports the internal PHY. There are no (R)MII signals on any pins.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
 drivers/net/sun8i_emac.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/sun8i_emac.c b/drivers/net/sun8i_emac.c
index 8bff4fe9a9e..94bcd40acb8 100644
--- a/drivers/net/sun8i_emac.c
+++ b/drivers/net/sun8i_emac.c
@@ -893,6 +893,11 @@ static const struct emac_variant emac_variant_r40 = {
 	.syscon_offset		= 0x164,
 };
 
+static const struct emac_variant emac_variant_v3s = {
+	.syscon_offset		= 0x30,
+	.soc_has_internal_phy	= true,
+};
+
 static const struct emac_variant emac_variant_a64 = {
 	.syscon_offset		= 0x30,
 	.support_rmii		= true,
@@ -910,6 +915,8 @@ static const struct udevice_id sun8i_emac_eth_ids[] = {
 	  .data = (ulong)&emac_variant_h3 },
 	{ .compatible = "allwinner,sun8i-r40-gmac",
 	  .data = (ulong)&emac_variant_r40 },
+	{ .compatible = "allwinner,sun8i-v3s-emac",
+	  .data = (ulong)&emac_variant_v3s },
 	{ .compatible = "allwinner,sun50i-a64-emac",
 	  .data = (ulong)&emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
-- 
2.39.2

