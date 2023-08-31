Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C70BEE49B2
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 22:17:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B12F8669D;
	Fri,  1 Sep 2023 00:16:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="EGa66oBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 223A58675B; Fri,  1 Sep 2023 00:16:44 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D22886758
 for <u-boot@lists.denx.de>; Fri,  1 Sep 2023 00:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=iaqCMqOq1485ooTpT6XocQpEbGEuOVIQy333gC53MGY=;
 b=EGa66oBvf2dywk+vQzqhXUN6RC088GPAgi5E1MwzI8GJcNNpO6KJ2AkpFMaGxkHUv+QJ
 D4ATn35w62Xuyk1VLJbMRN69eAIw3G61KQdCNVlNcCFJEDTprWtC9tfozunwqfPfRctnUg
 mpkOGH8DZ8Hr7eudJ5dzXb+8CfnhAuYWhoQrwTnlvZIBcmXrQpamBHRjMPTVekJGsrVRC8
 I/5w8HSylf0KxlRvom+qR9m3Bk1ziORl7UfSVond7dvVpANq37pulu8BpYpW3RsoVQa9ba
 GZnDM3gmzzdNDONEdYf0JmgTkkc2oHHjGgrRhMz64zaB5bcEC3E3aFwUQidymVzQ==
Received: by filterdrecv-66949dbc98-rr4mv with SMTP id
 filterdrecv-66949dbc98-rr4mv-1-64F11146-1B
 2023-08-31 22:16:38.617859166 +0000 UTC m=+5859654.382621936
Received: from bionic.localdomain (unknown) by geopod-ismtpd-5 (SG) with ESMTP
 id I9WOAx_tSb-MBerf8zRz2w Thu, 31 Aug 2023 22:16:38.351 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 5/6] net: zynq: Use generic_phy_valid() helper
Date: Thu, 31 Aug 2023 22:16:38 +0000 (UTC)
Message-ID: <20230831221629.1027552-6-jonas@kwiboo.se>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230831221629.1027552-1-jonas@kwiboo.se>
References: <20230831221629.1027552-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h5YK+TTeRxfOugVvP?=
 =?us-ascii?Q?eCP9HAgXzXxIuABJ7necMXLFbKm16XZLsLRL+R4?=
 =?us-ascii?Q?vnj6N+wFTbkTkNZEKNPDT1B8il6v0mYST0tw+Fd?=
 =?us-ascii?Q?JuDutb+dBFQptkVUOBmYwHPCT9P6lH0wjCwR5RW?=
 =?us-ascii?Q?x+rVR=2F3vPvJ8aMXoH45y+XN6LrO0PEBRSJ7jTo?=
To: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Michal Simek
 <michal.simek@amd.com>, Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Jonas Karlman <jonas@kwiboo.se>
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

The documentation for struct phy state that "The content of the
structure is managed solely by the PHY API and PHY drivers".

Change to use the generic_phy_valid() helper to check if phy is valid.

Fixes: 10c50b1facbf ("net: zynq: Add support for PHY configuration in SGMII mode")
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 drivers/net/zynq_gem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index f3cdfb0275d0..3377e669f2f6 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -890,7 +890,8 @@ static int zynq_gem_probe(struct udevice *dev)
 	if (ret)
 		goto err3;
 
-	if (priv->interface == PHY_INTERFACE_MODE_SGMII && phy.dev) {
+	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
+	    generic_phy_valid(&phy)) {
 		if (IS_ENABLED(CONFIG_DM_ETH_PHY)) {
 			if (device_is_compatible(dev, "cdns,zynqmp-gem") ||
 			    device_is_compatible(dev, "xlnx,zynqmp-gem")) {
-- 
2.42.0

