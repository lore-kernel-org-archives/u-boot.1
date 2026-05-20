Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D1D4CD4F5E
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E993846AD;
	Wed, 20 May 2026 08:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="ZnU6DSy3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BB288469F; Wed, 20 May 2026 08:05:36 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB8EF84676
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:05:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cd+E90lMPOv5v4lqG4GOZxombgzqgoCYC29cpcCmra8=; b=ZnU6DSy345W2rID7fppWmHMg0Z
 S6MznSdbsyY1dZO+wN3tsQ31K3xK7XqmfRYRhe0ple6elNjKcJ1nAE+MW1A8SH+MeuKxQO0himnBT
 IIGtNJsrHF3XKl7hkQ/Ro2aZ6CKB40Q5ob4fRfod3jv4+Vd5xnPlxWj/E0A2lxlCEkHKVO7Y/WThE
 Pk4voN5kPeR75RtRk4diNExZwL0vqwtEO+T42IGN6oplZbTV2Fcfj4t3jFa433HqP61bYVQ7W20CK
 qu3SH9GGFMTCsKvafHMCPpqnbQi9+6PDu2s9hnT4toP+RPrqWtZem8FdU6SWvZdvh7asuc7Ye2JAe
 zvhHYsVA==;
Received: from [81.57.40.39] (port=50682 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPa3i-0000000DuY3-3m7P; Wed, 20 May 2026 08:05:32 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Wed, 20 May 2026 08:05:28 +0200
Subject: [PATCH v3 2/4] pci: pcie_dw_rockchip: enable clocks before PHY
 init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-2-58f2cea72030@superkali.me>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
In-Reply-To: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 David Lechner <dlechner@baylibre.com>, 
 Julien Stephan <jstephan@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Sean Anderson <sean.anderson@linux.dev>, 
 Richard Genoud <richard.genoud@bootlin.com>, Simon Glass <sjg@chromium.org>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, 
 Daniele Briguglio <hello@superkali.me>, Jonas Karlman <jonas@kwiboo.se>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779257127; l=2701;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=o2bdf6WXlGExMqSxbQJgkmVWA573OlpE3haj5OTrXFY=;
 b=tY4kgdaEOk/LLDswWu6RXngQ1NyRA+RgH71XQV3qGF8J0oWh44JJepYnVFkMfIF2NeoKKtvSu
 j5VAwRZ+2t9ANSJoscxXPYQWFdFHb6v7dd7Om2Wisw8zvHFOt7RHvvK
X-Developer-Key: i=hello@superkali.me; a=ed25519;
 pk=5tynRWQdL93CDcapJ73FkcCRY2PeBOJOIAoIhRig53U=
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
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

rockchip_pcie_init_port() calls generic_phy_init() and
generic_phy_power_on() before clk_enable_bulk(), so the PCIe PHY
tries to lock its PLL while the external reference clock can still
be off.  Where the refclk is generated by an external oscillator
gated by a regulator that is not marked regulator-always-on (e.g.
the PI6C clock generator on radxa rock-3b modelled with the
gated-fixed-clock binding), this results in a PHY lock timeout:

  rockchip_pcie3phy phy@fe8c0000: lock failed 0x6890000
  rockchip_pcie3phy phy@fe8c0000: PHY: Failed to init phy@fe8c0000: -110.
  pcie_dw_rockchip pcie@fe280000: failed to init phy (ret=-110)

Move clk_enable_bulk() ahead of generic_phy_init() so that any
clock-frequency consumer (including external gated refclks) is
powered up before the PHY PLL attempts to lock.

Reported-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
 drivers/pci/pcie_dw_rockchip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 61117fa95..8ea51e642 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -307,10 +307,16 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 		return ret;
 	}
 
+	ret = clk_enable_bulk(&priv->clks);
+	if (ret) {
+		dev_err(dev, "failed to enable clks (ret=%d)\n", ret);
+		goto err_disable_regulator;
+	}
+
 	ret = generic_phy_init(&priv->phy);
 	if (ret) {
 		dev_err(dev, "failed to init phy (ret=%d)\n", ret);
-		goto err_disable_regulator;
+		goto err_disable_clks;
 	}
 
 	ret = generic_phy_power_on(&priv->phy);
@@ -325,12 +331,6 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 		goto err_power_off_phy;
 	}
 
-	ret = clk_enable_bulk(&priv->clks);
-	if (ret) {
-		dev_err(dev, "failed to enable clks (ret=%d)\n", ret);
-		goto err_deassert_bulk;
-	}
-
 	/* LTSSM EN ctrl mode */
 	val = rk_pcie_readl_apb(priv, PCIE_CLIENT_HOT_RESET_CTRL);
 	val |= PCIE_LTSSM_ENABLE_ENHANCE | (PCIE_LTSSM_ENABLE_ENHANCE << 16);
@@ -342,17 +342,17 @@ static int rockchip_pcie_init_port(struct udevice *dev)
 
 	ret = rk_pcie_link_up(priv);
 	if (ret < 0)
-		goto err_link_up;
+		goto err_deassert_bulk;
 
 	return 0;
-err_link_up:
-	clk_disable_bulk(&priv->clks);
 err_deassert_bulk:
 	reset_assert_bulk(&priv->rsts);
 err_power_off_phy:
 	generic_phy_power_off(&priv->phy);
 err_exit_phy:
 	generic_phy_exit(&priv->phy);
+err_disable_clks:
+	clk_disable_bulk(&priv->clks);
 err_disable_regulator:
 	regulator_set_enable_if_allowed(priv->vpcie3v3, false);
 

-- 
2.47.3

