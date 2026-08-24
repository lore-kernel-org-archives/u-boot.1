Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE440C5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:48:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2309F606A8;
	Mon, 24 Aug 2026 13:48:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TRtYChczBdSZ; Mon, 24 Aug 2026 13:48:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787579291;
	bh=DJ2Zy6JHUqB2iE2lb9bjD31sKg8TOmKf9sxHfG5zDFY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SyYk3G17eFpyypHay2RpVOUV+LPiYFj3c2Cb3eKFGwMgKyHBuIV/B9uEDWb1FBebe
	 DbYpAM9wjomeYxM3ZpxL4jPYnnhRu52CjQj8EjSV4Yzy5mvcpTMWyMdBpJpDUpP56T
	 i/EvRSMgsIfee3Qwc7AgMXKfMj4sMz6U+O33hhE6zFhvUYAinW2b0iWwkYbrMFc2eV
	 T00sd85PG5g3I2KYOeuQfZ9xt14Voo8+6d9h6GEt3v1RlVRvcwfSt+kINytN0WRNYv
	 5vMDJvoujY6/25eBP0ngB3e5Md97DLNZYaa5x13KBKJsn6YiUhW+sfbYf1t8J0E/mV
	 r3qL5OAQmxpkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5343260624;
	Mon, 24 Aug 2026 13:48:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4777D2FD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:48:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2DBE54063A
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:48:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hEdt_gbVeEHH for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:48:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.27.42.1;
 helo=smtp1-g21.free.fr; envelope-from=vjardin@free.fr; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=free.fr header.i=@free.fr header.a=rsa-sha256
 header.s=smtp-20201208 header.b=d3l/IHAB
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 270AE40602
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:48:08 +0000 (UTC)
Received: from localhost.localdomain (unknown [91.160.0.144])
 (Authenticated sender: vjardin@free.fr)
 by smtp1-g21.free.fr (Postfix) with ESMTPSA id 06E25B00572;
 Mon, 24 Aug 2026 15:48:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1787579286;
 bh=R1Y4XWKQMS0iM8VxpJbU4S6cJCrMMEdREvFi7y0LMTs=;
 h=From:To:Cc:Subject:Date:From;
 b=d3l/IHABTO2008n7ehHYPMnDYpwSQzDtJ7l2zM6fXOZm3NRZ3xETaht/5+vKQjyZk
 UX/MgJA1+hOOIym0LY44a5cGwAUf3de2jDPp4Ja+C0Q9P2p9gHzHGLp/j2XE+DOSqH
 6Q3Sq+ycsL3nBV3jgBSTKb2WIDlNKG4r1wM5A3y9Ya53QZDLW1utajZkOMmoheLUyt
 886RGouKbUx7etZeCUzNHlGTtL0iUDacWN6hS0+keLXsje4YvQOQxGXncVeP8qHGXq
 0vGXgVw0mgguPmKDrSKqStM5BvrwkuB3PNg4U2m+D70dJtgd7W/KWyLNVJL0ldTgZ1
 ZTyYnUYC4yxOw==
From: Vincent Jardin <vjardin@free.fr>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Peng Fan <peng.fan@nxp.com>, Vincent Jardin <vjardin@free.fr>
Subject: [PATCH v1] net: ldpaa_eth: fix error logics of unconfigured DPMACs
Date: Mon, 24 Aug 2026 15:47:58 +0200
Message-ID: <20260824134759.2711989-1-vjardin@free.fr>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

ldpaa_eth_bind() returned -EINVAL for a DPMAC node without
phy-connection-type.

That is not "skip this device", it is "the tree is broken":
the DM core propagates it out of lists_bind_fdt() and
dm_scan_fdt(), initr_dm() fails, and U-Boot stops before the prompt with

  ldpaa_eth ethernet@1: incorrect phy mode
  initcall_run_r(): initcall initr_dm() failed
  ### ERROR ### Please RESET the board ###

for a MAC nobody asked U-Boot to drive.

Why it matters: device trees imported from Linux enable
every DPMAC and leave the phy description to the board file, because the
kernel's dpaa2 driver does not need one for an MC-managed MAC. U-Boot's
own Layerscape .dtsi instead ships all eighteen disabled for the board to
opt into. So the moment a board takes its SoC description from
dts/upstream, every DPMAC it does not configure in U-Boot is enabled and
unconfigured, and one of them is enough to stop the boot.

Signed-off-by: Vincent Jardin <vjardin@free.fr>

---

 drivers/net/ldpaa_eth/ldpaa_eth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ldpaa_eth/ldpaa_eth.c b/drivers/net/ldpaa_eth/ldpaa_eth.c
index 94e62748239..27ae6747464 100644
--- a/drivers/net/ldpaa_eth/ldpaa_eth.c
+++ b/drivers/net/ldpaa_eth/ldpaa_eth.c
@@ -970,8 +970,8 @@ static int ldpaa_eth_bind(struct udevice *dev)
 
 	phy_mode = dev_read_phy_mode(dev);
 	if (phy_mode == PHY_INTERFACE_MODE_NA) {
-		dev_err(dev, "incorrect phy mode\n");
-		return -EINVAL;
+		dev_dbg(dev, "no phy mode, not binding\n");
+		return -ENODEV;
 	}
 
 	dpmac_id = ldpaa_eth_get_dpmac_id(dev);
---
base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
branch: for-upstream/net-ldpaa-eth-decline-dpmac-v1

-- 
2.43.0

