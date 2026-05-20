Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7EF0CD4F54
	for <u-boot@archiver.kernel.org>; Wed, 20 May 2026 06:06:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FD12846BD;
	Wed, 20 May 2026 08:05:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="mxibePzL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9287F846A5; Wed, 20 May 2026 08:05:37 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47F49843B6
 for <u-boot@lists.denx.de>; Wed, 20 May 2026 08:05:35 +0200 (CEST)
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
 bh=kGbJwgHtj73TPcYnlWRWGGmCI1zXjSpcjNjqZeQrDzQ=; b=mxibePzLLc2Wr9IfIjNDrXMguO
 S384rxMYdel7K4ZTQdy0TeJimYILGZzpCxlpVuErC47YxnwwYL5itLonHAis8lt24OpcQRshJCROs
 BEbWMz42SQzykHvZ/NA1wW9gQoJXRXm66pbAIWbFeL/qg/ODSsWxOoaFhj6pH8yTAvjxyOtA9tTMn
 0HtItdguNARJMyv3V+XrTPFam67hvvuzrXdK5QlQk8VeO3yyGFBqCJzljg9q8NlKJe2LjdzRtuFPq
 CpramSJEIguzmIfuYvPXH2Y0A5HYEUK3Hd8ArgaVGhOGTvpTyWKvnApWZ+3a+I8E27W6fSjUvXRo/
 6DG9V+RQ==;
Received: from [81.57.40.39] (port=50682 helo=vscode.iliadbox.lan)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.2) (envelope-from <hello@superkali.me>)
 id 1wPa3k-0000000DuY3-1YX8; Wed, 20 May 2026 08:05:34 +0200
From: Daniele Briguglio <hello@superkali.me>
Date: Wed, 20 May 2026 08:05:29 +0200
Subject: [PATCH v3 3/4] pci: pcie_dw_rockchip: drop clk_release_bulk calls
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-3-58f2cea72030@superkali.me>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779257127; l=1951;
 i=hello@superkali.me; h=from:subject:message-id;
 bh=Xauk+P5X13Uzkrcp5Swh07g176yc8U732ts6uJqT5Ms=;
 b=os5rF1A5H0IZZIzlrrP2pp+wMtknZPqxkez/ww8+ltA8enM2Fw8gox4QiPG+EMKVEpqLooZpm
 g0q8q7leSlKAI+0Tz6ai0us6WyH6gl9RkRzzax96wJ+kKd8LkxJV5uO
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

clk_release_bulk() loops clk_disable() over the bulk; the bulk
array itself is devm_kcalloc()-allocated and freed at device
detach, so the function does not actually release memory.

In parse_dt() the clocks are acquired but never enabled, so the
existing call disables clocks that are off.  In probe() after
init_port() failure, the inner err_disable_clks: path added in
the previous patch has already balanced clk_enable_bulk() with
clk_disable_bulk(), so the outer call is a double-disable.

With the new gated-fixed-clock driver both cases trigger
regulator_set_enable_if_allowed(false) on regulators that were
either never enabled or just disabled, desynchronising the
regulator enable_count.  On rk3588-rock-5-itx with only one M.2
slot populated, the failing empty slot would decrement the
enable_count of the still-needed regulator twice and pull power
from the populated slot.

Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Daniele Briguglio <hello@superkali.me>
---
 drivers/pci/pcie_dw_rockchip.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/pcie_dw_rockchip.c b/drivers/pci/pcie_dw_rockchip.c
index 8ea51e642..c1e34df53 100644
--- a/drivers/pci/pcie_dw_rockchip.c
+++ b/drivers/pci/pcie_dw_rockchip.c
@@ -425,7 +425,7 @@ static int rockchip_pcie_parse_dt(struct udevice *dev)
 rockchip_pcie_parse_dt_err_phy_get_by_index:
 	/* regulators don't need release */
 rockchip_pcie_parse_dt_err_supply_regulator:
-	clk_release_bulk(&priv->clks);
+	/* clocks don't need release */
 rockchip_pcie_parse_dt_err_clk_get_bulk:
 	reset_release_bulk(&priv->rsts);
 rockchip_pcie_parse_dt_err_reset_get_bulk:
@@ -476,7 +476,6 @@ static int rockchip_pcie_probe(struct udevice *dev)
 		return ret;
 
 rockchip_pcie_probe_err_init_port:
-	clk_release_bulk(&priv->clks);
 	reset_release_bulk(&priv->rsts);
 	dm_gpio_free(dev, &priv->rst_gpio);
 

-- 
2.47.3

