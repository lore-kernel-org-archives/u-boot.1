Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32702FF886C
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 22:48:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B0C3846BD;
	Wed, 29 Apr 2026 00:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Kzuk2Vdp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDEC78465E; Tue, 28 Apr 2026 20:04:52 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 601C284664
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 20:04:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+christian.dreher.nanoxplore.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D3D5E43D88;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B6C29C2BCB5;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777399486;
 bh=LSsti4BJqJl4KRo5EVviPi2k/NbBWnu7E0DPo3w2bO8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=Kzuk2Vdpa/Jzw95BMgd3IkJIHNtai2LBSF1+/FEMN+7xfYG1RajeBStz7AKBw9x/r
 o5EV84z0FKWdTBEnNfdpdhrWeyrlUTF7qxXzvNRimX5u4P95Yvui2pQ/6BHubtf67L
 MwwsRlxng3x0VrqVib40RQxvyskB0bsaJXigWTyZCUeVy6qlPkun8F9IbuXAFmVHhz
 Nvwh4y/fDKwwUkhF2QrljRD2yB4z2vWdELW5gEG6bp/ZwTBshynFMbn3CtwcAY1Dtp
 oVqw4mU1+ofgxaOF/ALJBHsvNVC+M5NeXLctpJvPoDsU1eegYCjjRyuB2/ecVL5v/z
 BcGK4CU8enV4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id AEE1CFF8877;
 Tue, 28 Apr 2026 18:04:46 +0000 (UTC)
From: Christian DREHER via B4 Relay
 <devnull+christian.dreher.nanoxplore.com@kernel.org>
Date: Tue, 28 Apr 2026 20:04:06 +0200
Subject: [PATCH 2/4] net: macb: use SA1 for MAC filtering on GEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-net-macb-support-for-feature-lite-instances-v1-2-480e4cecac01@nanoxplore.com>
References: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
In-Reply-To: <20260428-net-macb-support-for-feature-lite-instances-v1-0-480e4cecac01@nanoxplore.com>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, 
 Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777399485; l=1382;
 i=christian.dreher@nanoxplore.com; s=20260428; h=from:subject:message-id;
 bh=lhvo8U12ACbhoHnNc4Pv7TnDPkFRxIQ2KNLPjDefG30=;
 b=BwHnmEZ8CvAXem3DEBgw3uWYyzZAWfm5pabVGPkuCncL8rTDVgS/khodoWP6PojF+3pnmPRuR
 nyoxjbcZt5ZCT871FaU1P2Yy19ZkkbLhWJPWA6Kf4H1MV+p0m1ussLl
X-Developer-Key: i=christian.dreher@nanoxplore.com; a=ed25519;
 pk=id7EcKmXLV2xNgNiCIcsPjkoMQHM/qxTYqEqMhidSAU=
X-Endpoint-Received: by B4 Relay for
 christian.dreher@nanoxplore.com/20260428 with auth_id=760
X-Original-From: Christian DREHER <christian.dreher@nanoxplore.com>
X-Mailman-Approved-At: Wed, 29 Apr 2026 00:48:15 +0200
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
Reply-To: christian.dreher@nanoxplore.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Christian DREHER <christian.dreher@nanoxplore.com>

The MACB uses specific address registers (SA Top and Bottom) to
filter source or destination MAC addresses.
On the Gigabit Ethernet version, SA1B is @0x88.
On the non-GEM version, SA1B is @0x98.

Before this commit, the code was always writing 0x98. By chance,
on GEM, this is the address of SA3B, allowing the driver to work
anyway.

The motivation for this change is to be able to use the driver on
an instance of the GEM with less than 4 SA registers.

Signed-off-by: Christian DREHER <christian.dreher@nanoxplore.com>
---
 drivers/net/macb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/macb.c b/drivers/net/macb.c
index 719aef39a3f..807a038e071 100644
--- a/drivers/net/macb.c
+++ b/drivers/net/macb.c
@@ -1007,9 +1007,14 @@ static int _macb_write_hwaddr(struct macb_device *macb, unsigned char *enetaddr)
 	/* set hardware address */
 	hwaddr_bottom = enetaddr[0] | enetaddr[1] << 8 |
 			enetaddr[2] << 16 | enetaddr[3] << 24;
-	macb_writel(macb, SA1B, hwaddr_bottom);
 	hwaddr_top = enetaddr[4] | enetaddr[5] << 8;
-	macb_writel(macb, SA1T, hwaddr_top);
+	if (macb_is_gem(macb)) {
+		gem_writel(macb, SA1B, hwaddr_bottom);
+		gem_writel(macb, SA1T, hwaddr_top);
+	} else {
+		macb_writel(macb, SA1B, hwaddr_bottom);
+		macb_writel(macb, SA1T, hwaddr_top);
+	}
 	return 0;
 }
 

-- 
2.47.3


